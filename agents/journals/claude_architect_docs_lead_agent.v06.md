# Journal: claude_architect_docs_lead_agent — volume 06

- **Agent**: architect_docs_lead (Opus 5 lead)
- **Charter**: agents/charters/architect_docs_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 06
- **Continues-from**: J-architect_docs_lead-0055
- **Previous-volume**: agents/journals/claude_architect_docs_lead_agent.v05.md
- **Previous-volume-sha256**: 35578e416d30e43af04d97d2ca8c2f51aab25c4efcb39661a9332717d018af10
- **Previous-volume-bytes**: 251354

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Volume 06 of a chain (ADR-0017 §4.3).
Enforced by scripts/agent_commit.sh and CI.
Volume 05 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-architect_docs_lead-0056] 2026-08-12T04:31:23Z | task:none | The sixth edition chooses the fix over the confession: five order defects repaired in place and the paragraph confessing them deleted, the countersignature given the form its own day-one failure path terminates in, the seal's state line re-derived from the nine seals nobody had counted — and the twice-refused split executed with a manifest, so round five can verify it instead of trusting it

### Trigger

Orchestrator dispatch, one round, dispatch-only (no work-order packet — the
class §3 of the process description names and this entry is obliged to declare
rather than let pass). The commission: the **sixth edition** of
`docs/PROCESS.md`, written from the **fourth council's verdict**, committed at
`docs/reports/process-council/round-4/verdict.md`, whose Recommendation
commissions exactly this round in exactly this order — *"a sixth edition with a
closed, ordered scope. Determinism first, the split second, no new confession
machinery."*

Two siblings were declared and both landed mid-round; the orchestrator announced
both in flight, and §4.2's inward declaration was performed rather than assumed,
twice. See Evidence.

### Inputs

- `agents/charters/architect_docs_lead.md` — my charter, read first, in full.
- `agents/PROTOCOL.md` (450 lines) — the constitution, read in full. §4 (entry
  grammar), §6 (write scopes), §7 (Mutation record, harvest), §10 (independence,
  R-SEAL-1, and the transient-mutation clause this round routes), §11 (amendment
  procedure).
- `docs/reports/process-council/round-4/verdict.md` — read in full, first, as
  the dispatch required. It is the controlling source for this round.
- `docs/reports/process-council/round-4/bob.md` — the record audit; F1 (sponsor
  guide), F2 (PROTOCOL §10 unrouted), F3 (the seal's state line), F6 (the kit's
  `N/N`), F7 (the blob-gate remedy), F10 (B.2 item 5 performed at `22c60fb`).
- `docs/reports/process-council/round-4/charlie.md` — the cold reading; F1 (the
  memoir has overgrown the mechanism), F2 (the monopolies' compound posture),
  F3 (phase/milestone), F4 (the countersignature has no form), F5 (§3.7's rule
  against its own facsimile), F6 (two roster shapes), F7 (lead-tier review
  routing; "normative" undelimited), F8 (five count-over-list defects), F9
  ("seat" undefined), F14 (three verbatim stutters).
- `docs/reports/process-council/round-4/executor.md` — read in full; the
  day-one failure path that terminates in the formless countersignature, and
  the Step −1 preflight.
- `docs/reports/process-council/round-4/bill.md` (grep-read for BILL-01…06) —
  the fetched-shell evidence behind the *extracted project-free* correction and
  the file-by-file domain inventory.
- `docs/reports/process-council/round-4/expansionist.md` (grep-read) — the
  §3.10-domain-packs-solve-BILL-01 connection, which is what turned the honest
  relabel into a committed refactor direction.
- `docs/PROCESS.md`, fifth edition, **5,446 lines, read in full** in five passes.
- `docs/SPONSOR.md` — read in full before editing (Bob F1's subject).
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` — §4.3/§5 for the
  rotation arithmetic; `docs/adr/ADR-0020-…md` §9.5/§10 and
  `docs/adr/ADR-0021-…md` §1 for the decision-record and owed-ledger forms that
  §3.5's new facsimiles and ADR-0022's structure are written from.
- **Re-derived from the record rather than quoted** (the point of this round):
  all thirteen `agents/handoffs/*SEALED*` files, state line by state line;
  `agents/handoffs/WO-0073_…-SEALED-predictions.md` and `WO-0058_…` headers in
  full, as the transcription source for the rewritten facsimile;
  `agents/handoffs/WO-0013_batch-c-countersign.md` Return log and
  `agents/journals/claude_dv_lead_agent.v10.md` (the `J-dv_lead-0186`
  delta-signature block) as the transcription sources for §3.5's two new
  facsimiles; `ORG_CHART.md` roster table; `tasks/BOARD.md` §Current milestone,
  §Milestone roadmap, §Gates; `agents/journals/INDEX.md`;
  `agents/handoffs/README.md` (the `SO-` skeleton carrying `N/N`).
- `git remote -v` for the origin repository's address, which no edition had
  ever stated.

### Reasoning

**The order of work was the verdict's, and it was not arbitrary.** The council
sequenced determinism ahead of hospitality because its adoption lens said so in
terms — *do not spend repair budget on hospitality before determinism* — while
its cold lens said the opposite was the dominant defect. I did not adjudicate
between them; the verdict already had, and a round that re-argues its own
commission is a round nobody can scope. So: the one thing first, tranche 1
second, the split last, and the split performed only after every in-place repair
had landed, so that the strip operated on repaired text and not on text I would
have to repair in two files afterwards.

**On the one thing, and on the deletion, which is the only act this round took
that destroys something.** The council's central diagnosis is the hardest
sentence ever written about this document: *confession has replaced repair.* Its
sharpest instance is a paragraph in §6.2 that enumerates five order defects,
budgets an adopter *about an hour each*, and repairs none — sitting at the exact
point every future adopter enters. I fixed the five and deleted the paragraph.
The deletion needed a ground, because this document's oldest discipline is that
a superseded claim is preserved beside its correction, never removed, and I have
enforced that discipline against myself in four previous rounds.

The ground is that **the preservation discipline preserves claims, and that
paragraph is not a claim about the past — it is a present-tense claim that this
document is broken.** Preserving it would not preserve history; it would leave a
false statement about the current text sitting in the current text, which is the
precise inversion of the margin rule (*the running line carries the current
truth and the margin carries the history, never the reverse*). What history
actually requires here is the *fact of the repair*, and that is what I left: one
dated line in §6.2 saying the five were repaired, when, and on whose verdict —
plus the full account in the companion's B.11 item 14. I considered keeping the
paragraph under the sentinel and rejected it: a sentinel marks *this was once
claimed and is false*, and the paragraph's content would then be marked false
while describing defects that were, at the moment of writing, genuinely fixed —
a marker asserting the opposite of the truth. **The discipline's purpose is that
a reader can never mistake a dead claim for a live one; preserving this one
would have created exactly that mistake in the other direction.**

**On the split's rule, and why by tense rather than by audience.** The obvious
split is adopter-edition and auditor-edition. I rejected it on the document's
own mechanism-placement ground: two self-contained copies of one rule set is the
drift hazard the whole document is organized against, one level up. The split I
took is by **tense** — current law in one file, history in the other — which has
the property that **no rule is stated twice**, so a drift between the volumes can
only ever be a stale history, never a competing law. That is also what makes
"the core governs" a sentence with content rather than a courtesy: the companion
states no rule, so there is nothing for it to govern *with*.

The rule itself had to be mechanical, because a split performed by judgement is
a split a reviewer must re-perform to check. Hence S1 (the sentinel is the
strip-marker — the fifth edition's own instrument, repurposed as the algorithm
the document said it would be), S2 (the program-local annexes move whole, which
is the fork contract's own instruction for both, so the exporter finally
performs on itself the act it prescribes for a fork), S3 (three
pure-archaeology blocks with no token, moved **by name** — an enumerated
exception list is auditable, an unstated one is not), and S4 (nothing deleted).
Twelve sites had current law and archaeology fused inside one paragraph; I
normalized those *first*, by hand, so the extraction itself required no
judgement at all. One of them was a genuine defect the fifth edition had
committed: a sentinel placed in front of a paragraph whose first half was
current law (§2.6's threshold), so the token was marking true text as
superseded.

**The split found one preservation defect, which is the reason a manifest
exists.** The marked-reference population — eighty-six references, none merged —
lived *only* in two margins, while §2.5 and §2.6 both point at §3.9 for the
figure. Strip the margins and the core loses a number two other sections
depend on. I promoted it into a §3.9 running line before the strip ran. This is
the class of defect a split is most likely to create, I expect there to be
others, and falsifier 4 in Part 0 (diff the sixth edition against the fifth and
account for every removal) is the instrument that would find them. **I could not
run that falsifier against myself and say anything a reviewer should believe.**

**On §5, and on saying so out loud.** The verdict enumerates the core as
"§1–§4, §6, Annex A, the facsimiles, the failure classes" — which does not name
§5. Three things argue it stays: the parenthesis names *the failure classes*,
and §5 is the failure classes collected; the same verdict's fence, carried from
round 3, holds the museum and the rule-plus-failure-class doubling *untouched*,
which reads oddly as an instruction to relocate them; and §6.3's closing
argument depends on §5 in terms. I kept it. But a one-section difference between
a commission and its execution is exactly how a commission quietly becomes
whatever its executor preferred, so I recorded the judgement in ADR-0022 §4 with
its grounds **and named the sentence that would overrule it**, and I am
returning it to the orchestrator as the first thing this round should not
silently pass over.

**On Bob F3, and why re-derivation beat hedging.** The finding is that §3.3
describes the seal's state line as *the single line flipped at unsealing* while
most of the record never flips it. The cheap repair is a qualifier. The dispatch
said re-derive, and re-deriving changed the conclusion: thirteen seals, four
early ones flip, **nine never do, and six of those nine were scored** — so six
of the ten scored campaigns were scored without one byte of the seal being
touched. That is not a caveat on the old claim, it is a different claim, and it
is *stronger*: a seal with no mutable point makes the check flat (`git diff`
expected empty) instead of one whose runner must decide which difference is
allowed. **A mechanism that needs the checker to decide which difference is
allowed has given the checker something to be charitable about**, and that is
the whole subject of the section. I also found, re-reading the nine, that the
later seals moved the *reason* for the blind out of the seal and into the
commissioning packet — the one respect in which the practice moved the wrong
way, since the seat being blinded is the seat that would open the file. I
recorded that against the record's own interest.

**On the roster reconciliation, where I had to choose which site was wrong.**
Act 1a asked for a scope column; §1.6's facsimile has none and has a *Reports
to* column 1a never mentions. The facsimile is transcribed from this program's
real roster, and I checked: `ORG_CHART.md` has six columns and no scope column.
So the facsimile is right and act 1a's sentence — *the scope table is the
roster's scope column made executable* — is false. I could have added a scope
column to the facsimile, but that would make it a facsimile of nothing (§2.6's
own rule about renumbering, applied to columns). Instead I traced where scope
actually lives: **each seat's charter, section 1** (§1.3's own field list, and
my own charter carries it), from which the policy module is generated. The
repaired chain — roster → charters → policy module — is true, checkable, and
turns act 1a from a step an adopter cannot perform into one they can.

**On what I refused, and the refusal that is most likely to be questioned.** Bob
F6 says the kit's `SO-` skeleton in `agents/handoffs/README.md` still teaches the
`N/N` ratio the constitution outlaws. The dispatch told me to repair the
facsimile in my document and route the original as "another seat's". **That
characterization is wrong on the facts: `agents/handoffs/**` is in my standing
write scope under PROTOCOL §6.** But it is outside *this round's* declared write
scope, which the dispatch fixed at five paths. I took the round's scope as
binding and routed it — with the discrepancy stated in the routed row itself,
because a seat that silently accepts a wrong reason for a right outcome has
banked a precedent it cannot cite later. This is §4.8 refusal-with-grounds, and
the alternative — widening the round because I happened to have the permission —
is the defect the process description convicts under *a revision that quietly
widens its own scope is a revision whose scope nobody can check*.

**On ADR-0022 carrying two decisions rather than one each.** They are the same
decision seen twice: the re-scoping narrowed what the artifact warrants, and
that narrowing is what made the split *available* — while the document claimed
to be a complete self-sufficient description, shedding its archaeology looked
like shedding evidence. Split across two records, that dependency is invisible.
I also declined to let the record ratify anything: it lands **PROPOSED with both
countersignatures owed**, states in its own status block that both rules were
already operating when it was written, and reserves the acceptance act to the
orchestrator. A record that arrives after the act it governs is late; a record
that hides its lateness is worse, and §3.6 already names the shape that makes
lateness measurable.

**What I did not do, and the one that costs most.** The doc–shell drift check is
still not built, for the fourth consecutive edition — and this is the first
round in which its own stated due date (*before any sixth edition is drafted*)
actually came and went unmet. The ground is unchanged and I will not dress it
up: building it means landing a test in one of two repositories during a round
commissioned for a document revision. What changed is that the council moved the
gate to where it bites — no unit-level replication claim may be certified until
it exists — which is a better instrument than any due date this document could
set for itself, because it is held by somebody else.

### Actions

1. Read charter, PROTOCOL, and the round-4 verdict in that order; then the
   eight council reports; then `docs/PROCESS.md` in full.
2. Performed §4.1's abort-first precheck and, twice mid-round, §4.2's inward
   declaration on announced sibling landings (Evidence).
3. **The one thing** — §6.2 and §1.6: reconciled the roster columns at both
   sites with §1.6 declared the single authority; made act 1b flip the
   committing seat's roster row; added **act 1e** landing the program-state file
   and the journal index with their cadence rules, plus a definition-of-done
   row that reads them; defined the **founding range** once at §1.7 and replaced
   six occurrences of the undefined *bootstrap range*; repaired Step 1's
   unsatisfiable preamble. **Deleted the confession paragraph and its budget
   line**, leaving one dated history line citing the verdict.
4. **Tranche 1**: added **Step −1** (four-item preflight); §6.0 gained the
   `BOOTSTRAP.md` kit row and the **precedence rule**, the *FPGA-generic*
   correction with a nine-row domain-load inventory and the core-plus-pack
   commitment, and the origin-repository address as a standing dependency of
   every stamp; §3.5 gained **two facsimiles and the owed-ledger address**;
   §1.4(a) gained the **routing table** and the **four-class delimitation of
   "normative"**; new **§1.8** defines phase, milestone and the trunk-merge
   trigger; §1.1's monopolies split by posture; §3.3's seal claim rewritten from
   the nine later seals with the facsimile re-transcribed from one of them;
   §2.6/A.7 gained the blob-gate remedy; §3.7's sponsor exception moved into the
   rule sentence; §3's packet facsimile gained the lawful disposition block;
   *The dialect* gained **seat** and a count over its own list; five
   count-over-list defects and three verbatim stutters repaired.
5. **`docs/SPONSOR.md`**: restored the sponsor's fourth and fifth powers
   (ratification; candidate-by-candidate harvest refusal) and added a
   five-power summary at the top.
6. **Tranche 2 — the split**: normalized twelve fused sites by hand; ran the
   mechanical extraction (S1/S2/S3); wrote `docs/PROCESS-MEMOIR.md` with Part 0
   (rule, manifest, arithmetic, four falsifiers, sentinel census), Part I (the
   preserved record by core section), Parts II–III (Annexes B and C, with
   B.0.3 returned, **B.0.4** opened, B.2 items 13–16 added, item 5 corrected,
   and the new **B.11**), and Part IV (the edition genealogy).
7. Re-derived the subsection index by the document's own printed command;
   re-measured the boundary block; reconciled every self-count in both files.
8. Authored `docs/adr/ADR-0022-the-warranty-and-the-split.md` (PROPOSED).
9. Rotated the journal to volume 06 after running the ADR-0017 arithmetic.

### Evidence

All commands run from a repo checkout at this commit's tree.

- **Precheck (§4.1)**, at spawn: `git rev-parse HEAD` → `7b749f0…` as the
  dispatch declared; `git status --porcelain` → six modified
  `test/xgmii_tx_64/**` paths, exactly the declared sibling's.
- **Inward declaration 1 (§4.2)**, on the announced landing:
  `git merge-base --is-ancestor 7b749f0 HEAD` → true;
  `git diff --name-only 7b749f0..91f005d` → 8 paths, none mine.
  Two measurements re-derived from the packet directory were re-run against the
  new state and were unchanged (seal population 13; state-line split 4/9).
- **Inward declaration 2 (§4.2)**, second landing:
  `git merge-base --is-ancestor 91f005d HEAD` → true; `HEAD` = `d93fbf1`;
  `git diff --name-only 91f005d..HEAD` → 3 paths, none mine.
- **Seal re-derivation (Bob F3)** — the measurement the §3.3 rewrite rests on:
  `git ls-tree -r --name-only HEAD -- agents/handoffs/ | grep -c SEALED` → **13**;
  per-file first `- **State**` line → **4 `UNSEALED <date>`** (WO-0039, -0041,
  -0050, -0055) and **9 `FROZEN`** (WO-0045, -0058, -0061, -0063B, -0066, -0073,
  -0074, -0076, -0077). Of the nine, WO-0074/-0076/-0077 carry no scored
  verdict; the other six do — hence *six of the ten scored campaigns were
  scored without their seal being touched*.
- **Split falsifier 1** — `grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS.md`
  → **0**. Against `docs/PROCESS-MEMOIR.md` → **38**, reconciled in Part 0 §0.5
  as **33 preserved passages** (32 in Part I, 1 in Annex B) plus **5 mentions of
  the token** (4 in Part 0, 1 in B.10's row).
- **Split falsifier 2** — all **22** `### Anchored at —` headings in the
  companion resolve to headings present in `docs/PROCESS.md` (checked by
  substring against the core's text).
- **Split falsifier 3, the arithmetic** — pre-split source 5,976 lines; S1/S3
  moved 330; S2 moved 752; 36 blank lines swallowed (35 extraction points + 1
  trailing) → core body 4,858; + 62 lines of split-specific front matter →
  **`wc -l docs/PROCESS.md` = 4,920**. `4858 + 62 = 4920` closes.
  `wc -l docs/PROCESS-MEMOIR.md` = 1,640.
- **Subsection index, re-derived not edited** — the document's own printed awk
  command (the fence-tracking one beside the index, which skips fenced blocks and
  counts posture-row citations per heading) re-run against the core
  → **71 headings**, and the index block and its *Derived at* line both carry 71.
  Heading count alone reproduces with:

  ```
  awk '/^```/ { f = !f; next } !f && /^##+ / { n++ } END { print n }' docs/PROCESS.md
  ```
- **Boundary block** — re-measured in the act that moved it: 4,920 lines against
  the posture list's 1,445, ≈3.4×, with the split's effect stated (1,082
  unmeasured lines moved out; **no stamp re-measured**).
- **Fence balance** — `grep -c '^```'`: core **28**, companion **2**; both even.
- **Pointer resolution** — `[B.11·1]`…`[B.11·18]` all appear in the core and all
  resolve to rows of the companion's new B.11 table (which runs to item 25);
  `[B.11·19]`…`[B.11·24]` are used inside the companion's own B.2 rows.
- **Journal chain (ADR-0017 §4.3/§5)** — v05 at HEAD and in the working tree are
  byte-identical, **verified both sides**: 251,354 bytes, sha256
  `35578e416d30e43af04d97d2ca8c2f51aab25c4efcb39661a9332717d018af10`. Arithmetic:
  251,354 + this entry ≫ the 262,144-byte soft threshold, so this round rotates
  rather than appends; v06's header carries the path, digest, byte count and
  `Continues-from: J-architect_docs_lead-0055`.
- **Not run, and stated as such**: I did not diff the sixth edition against the
  fifth line by line to confirm that every removal is either a manifest block or
  a named repair (Part 0's falsifier 4). That is the strongest of the four
  falsifiers and **the author of a split is the wrong party to run it** — it is
  offered to the round-5 reviewer, with the manifest written to make it cheap.
- **Not touched**: `docs/reports/audit/PROCESS-claims-posture.md` — no line of
  it was read into this round as editable and none was changed, for the fifth
  consecutive edition, on the ground stated at B.2 item 8.

### Outcome

**DoD met against the dispatch**, item by item.

- *The one thing*: five order defects repaired in place at §6.2 and §1.6; the
  confession paragraph and its budget line deleted; a one-line dated history
  note left in their place citing the verdict.
- *Tranche 1*: Step −1; `BOOTSTRAP.md` row + precedence rule; the
  *extracted project-free* correction with inventory **and** the core-plus-pack
  commitment (the dispatch allowed either; I did both, because an inventory
  without a direction is another confession); the origin-repository line;
  §3.5's two facsimiles and the owed-ledger address; the §1 definitions block
  (§1.8), the §3.7 exception, the §1.4(a) routing table and "normative"
  delimitation, "seat" in the dialect; §1.1's posture split; §3.3 re-derived;
  the four kit/cross-artifact items (SPONSOR.md performed; PROTOCOL §10, the
  `N/N` original and the pack refactor routed with owners and closing events;
  the blob-gate remedy stated at both sites); the hygiene batch.
- *Tranche 2*: the split executed, both volumes carrying the derivation, with a
  manifest, arithmetic that closes, and four falsifiers.
- *Governance*: `ADR-0022` authored, PROPOSED, both decisions in the four-element
  form, countersignature route named (dv_lead, auditor) and **owed**;
  acceptance reserved to the orchestrator.
- *Not this round, as instructed*: the drift check stays a named debt; the
  verdict's unit-level gate is recorded at **B.0.4** as the council set it.

**Handoff**: to the orchestrator, for review and commit. No git command was run
by me beyond read-only inspection; nothing is staged.

### Open-questions

1. **The §5 judgement is the one place my execution differs from my
   commission's literal text.** The verdict's core enumeration does not name §5;
   I kept it, on the grounds in ADR-0022 §4, and named the sentence that would
   overrule it. If the council meant the museum to move, it is one act to move
   it, and the split's mechanism is written down and repeatable.
2. **Falsifier 4 is unrun and I am the wrong party to run it.** A line-by-line
   diff of the sixth edition against the fifth, accounting for every removal as
   either a manifest block or a named repair, is the only check that catches a
   byte dropped in the move. It belongs to the auditor, and it is the substance
   of ADR-0022's owed countersignature row 2.
3. **The `N/N` original at `agents/handoffs/README.md` is unrepaired and the
   dispatch's stated reason for routing it was factually wrong** — that path is
   in my standing scope, not another seat's. I routed it on the round's declared
   scope instead, at B.2 item 14. It is one line of work whenever a round is
   commissioned for it, and an adopter pulling that named original today
   inherits a template that commits the thing the constitution beside it
   forbids.
4. **ADR-0022 lands unsigned, which is the defect it exists to record.** Both
   countersignatures are owed (dv_lead on the warranty, auditor on the split),
   and until they are paid the sixth edition is in the same position the fourth
   council convicted: a normative change to the artifact's central claim,
   self-adjudicated. The record makes that measurable rather than curing it.
5. **Annex A.8's *and nowhere else* is now false, known-false and unmarked for
   three consecutive editions** — the roster carries a tier column and §1.6's
   own facsimile shows it. It was outside this round's closed scope and I did
   not widen. It is the oldest unmarked false claim left in the core and it
   should be the cheapest item on any next list.
6. **The two conditions at B.0.4 are neither of them document work.** No
   seventh edition should be commissioned to answer them, and the council said
   so more bluntly than I would have: the constraint has not been the prose for
   two editions.

### Files-in-this-commit
- docs/PROCESS.md
- docs/PROCESS-MEMOIR.md
- docs/SPONSOR.md
- docs/adr/ADR-0022-the-warranty-and-the-split.md

## [J-architect_docs_lead-0057] 2026-08-12T05:54:09Z | task:none | The seventh edition performs the RETURN instead of ledgering it: the constitution's determinacy clause restored under a worked tally derived from a committed data file, the fourteen margins the split lost put back and both self-referential falsifiers rebuilt against states somebody else committed — and the one repair the council ordered is refused, because the record it cited contains the instance it said did not exist

### Trigger
Orchestrator dispatch, seventh edition, my seat alone, one round. Source: the
fifth council's committed verdict at `docs/reports/process-council/round-5/verdict.md`
— a **RETURN** with eight numbered repairs plus the A.8 disposition, each naming
its sections. The verdict's own ground for refusing the accept-with-conditions
form is the instruction I worked under: this organization metabolizes conditions
into ledger rows, so the repairs are to be performed in the text and the record,
not disclosed. Precheck: HEAD `d96ffe2`, tree clean, branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`; no sibling lane declared at
dispatch and none announced during the round, so §4.2's inward declaration is a
nil return rather than an unperformed act.

### Inputs
- `docs/reports/process-council/round-5/verdict.md` (in full — it controls), and
  the eight reports beside it: `bob.md`, `charlie.md`, `bill.md`, `outsider.md`,
  `contrarian.md` in full; `executor.md`, `expansionist.md`,
  `first-principles.md`, `sal-framework.md` consulted.
- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` (§7's Mutation
  record (b.1)–(b.4) read as the normative source of §3.9's law).
- `docs/PROCESS.md` and `docs/PROCESS-MEMOIR.md` at `d96ffe2`.
- `git show d96a5b1:docs/PROCESS.md` — the committed fifth edition, used as the
  external standard for falsifier 4 rather than the sixth edition's manifest.
- **The record, for the worked tally**: `agents/handoffs/SO-xgmii_rx_64.md`
  §2.2, §2.2-M, §2.2-D.4, §2.2-D.6; the campaign manifests at
  `docs/reports/audit/WO-0050…WO-0077-mutations/README.md`;
  `agents/handoffs/WO-0063B_m03-i2-report-path-campaign.md` and its
  `-SEALED-predictions.md`.
- `docs/reports/audit/PROCESS-claims-posture.md` rows C-01, C-06, C-07 (read as
  evidence for the sole-spawner adjudication; not edited — sixth consecutive
  edition it has been left alone).
- `docs/adr/ADR-0022-the-warranty-and-the-split.md` (status only).

### Reasoning
**The one thing first, and it went somewhere the verdict did not expect.** The
verdict's widest convergence — four seats, four independent probes — is that
§3.9's prose copy of the seeded-defect law dropped the constitution's sentence
*All three sit in `sealed`, none in `seeded`, each named at the tally with its
ground*, leaving the printed definition of the *Seeded* column to contradict
Ground 3, since a negative control is rendered and run. That half is
straightforward: the clause is restored as a quoted blockquote rather than a
paraphrase, at §3.9 and as a comment inside §3's sign-off facsimile, because a
paraphrase is what drifted the first time.

The second half was the instruction to write a fifteen-line worked tally from
the real record, with the verdict's figures (sealed=7, seeded=5) offered as the
council's reading and the record named as the standard. **Verifying them changed
the outcome.** The real record's class-based era carries 63 sealed / 61 killed /
1 survived / 0 green-by-blindness / 1 void, and the sign-off itself names an owed
movement of the sealed figure to 65 under the amended definition without
itemizing it. Walking the campaign manifests against the era's per-campaign
contributions closes it exactly: `WO-0061` sealed ten classes and the era counted
nine (`I-c1`, unscoreable); `WO-0063B` sealed two and the era counted one
(`IC-2`); `WO-0074`'s `IC-M5` was counted inside sealed as the void. So under
(b.1) — nothing removed from `sealed` for any later reason — **sealed = 65,
difference = 3 with exactly one member per ground, seeded = 62 = 61 killed + 1
survived.** The arithmetic closes twice and the tally has one member of each
ground, which is the shape the verdict wanted at the record's own scale rather
than at a synthetic one.

**And that is how I found the item I had to refuse.** The Contrarian adjudicated
Charlie F1 against the record and reported a second conviction the verdict
adopted: that no exercised Ground-3 negative control exists, so §3.9 sells design
intent as case law, and the repair list therefore instructs me to mark Ground 3
as design intent. **The record refutes it.** `IC-2` at `WO-0063B` is a negative
control in exactly §3.9's sense, and its seal — frozen before the run — says so
in terms: *"IC-2 is a control, not a class this round scores. Its only REQUIRED
cell is a green at M03-I2"*, and *"IC-2 is a control and scores no kill in its
own right."* It was rendered, run at `mut/wo-0063b-ic2` = `dbc4b0a`, CI run
`30955861141`, its required green observed at all three members and both lanes,
kills 0 by design. Every element §3.9 requires of the ground is present and was
disclosed pre-run.

I considered three dispositions. **Comply anyway** — mark it design intent — is
what a seat does when it treats a verdict as an instruction rather than as a
finding; it would have put a false marking in the core on a council's authority,
which is the exact class §3.8 convicts (*the packet quoted its source accurately;
the source was wrong*). **Comply silently and note the disagreement in my return**
keeps the document false and moves the disagreement into a channel the record
does not carry. **Refuse in the document, with the evidence cited and the reason
the council erred stated in place** is the only one that leaves a later reader
able to check both the ruling and the refusal. I took the third, and the dispatch
authorized it in terms: *the verdict's numbers are the council's reading, the
record is the standard.* The more useful half is **why four seats missed it**,
and it belongs in the core because it is a rule about reading tallies: the era's
own denominator had already removed `IC-2`, so a reader walking the tally never
met it. *A class excluded from a denominator is a class excluded from review* —
which is precisely why (b.1) closes the naming duty while leaving the grounds
list open.

**The golden tally, and why it is a data file rather than more prose.** The
verdict graduated the Expansionist's proposal on the ground that it makes Charlie
F1 structurally unrecurrable. Prose cannot do that: the sixth edition's §3.9 was
prose and it drifted from a constitution sitting in the same repository. So the
figures now live in `docs/process-golden-tally.json` — every excluded class with
its ground and the evidence that the ground was **disclosed before the run**, the
survivor with its replay identifiers and its expiry condition, the unreachable
set, and both arithmetic checks — and the core prints a de-domained rendering
derived from it. I placed it beside the two volumes rather than under
`docs/reports/gates/`: it is not a gate record, it is the derivation source for a
document section, and putting it beside the volumes it serves is what makes the
fork contract's disposition of it obvious. It also earns a kit row, a fork row,
and a line in the commissioned governance check.

**Falsifier 4 and the fourteen margins.** I re-derived Bob's finding rather than
trusting his sample: extracting all 50 sentinel-marked passages from `d96a5b1`
and fingerprinting each against **Part I of the companion specifically** — not
against the whole file, because Annex B ledger narration about a topic is not the
preserved margin the `[CORRECTED]` legend promises — returns **fourteen** lost,
which is Bob's count exactly, plus one preserved-but-mis-filed block he did not
name (the fifth edition's line 4825 margin, which sits in B.1 rather than under a
Part I anchor). All fourteen exist at `d96a5b1`, so restoration was preferred to
stripping at every one, as the verdict directs. Five of the anchoring sections
had **no Part I block at all**, which is the reason their losses were the least
visible: a reviewer checking whether §3.4's corrections survived found no heading
to check under and read the absence of a block as the absence of margins. Three
orphaned `[CORRECTED]` stamps are re-anchored — C-33 and C-114 as the verdict
named, and **C-82 at §3.4, which the verdict did not name and my full diff
surfaced**.

**The falsifiers themselves are the deeper repair, and the Outsider's rule is why.**
Falsifier 4 pointed at the manifest — a list the same edition wrote — so a block
dropped from both file and manifest was undetectable by construction; falsifier 3
closed against an uncommitted intermediate state at no commit. Both now close
against `d96a5b1` and this commit. I also took the honest loss on falsifier 3
rather than building a new closing sum: **no arrangement of line counts can prove
a closure**, because a moved block and a deleted-plus-added block of the same
size are indistinguishable to a line count. The sixth edition's arithmetic looked
like the stronger instrument and was the weaker one, and saying so is worth more
than a tidier sum. The Outsider's sentence is adopted in both volumes as this
document's own drafting law, with the test that operationalizes it: *name the
artifact the check would have to disagree with, and ask who wrote it.*

**On repair 3 and the limit of my scope.** The record-side repairs — PROTOCOL
absorbing R10/R11, the four charters and the gate checklist re-quoted, ADR-0022's
countersignatures — are other seats' files and §2.3 refuses my commit to all of
them. The verdict's disjunction is *repair the record or stop presenting it as
clean*, and only the second limb was available to me, so I took it at every site
the council named and added the one the Contrarian argued for: **§5.9, the
amendment pipeline's last mile**, which is this record's most-exercised defect
class and was missing from its own failure museum. I wrote it with this
document's own inventory as the exhibit rather than an anonymized one, including
the severity-cap arbitrage that lets the class survive disclosure. A museum whose
worst exhibit is the museum's own owner is the only kind worth reading.

**A.8, which I refused last round.** I flagged it at J-0056 refusal 5 as outside
that round's closed scope and named it the cheapest item on any next list; the
round-5 record put it in scope and B.11's own corollary — *a refusal repeated
three times is a decision, not a deferral* — made a fourth deferral
indefensible. I repaired rather than marked, and the repair is not deleting *and
nowhere else* but **naming which of the five statement sites binds and which
restate**: §2.7's parameter rule is unusable until one site is canonical, so
marking the sentence false would have left the maintenance problem that produced
it.

**What I did not do, deliberately.** The governance CI job is named as
commissioned with its owner and not built — `scripts/` and `.github/` are the
orchestrator's scope. Probe 5.2 is stated as the council set it and not run: an
adoption run executed by the document's own author measures nothing (§5.7). The
posture list is untouched for the sixth consecutive edition, and was read only as
evidence — which is what a grader's artifact is for, and is how the
C-01/C-06/C-07 citation shuffle got adjudicated instead of guessed: the two sites
cited different objects, and §1.0's set omitted precisely the row that graded its
second limb false.

### Actions
- `docs/PROCESS.md` → **seventh edition**. §3.9: determinacy clause restored as a
  quoted blockquote; grounds framing corrected; Ground 3 anchored against the
  record with its instance and the reason four seats missed it; fifteen-line
  worked tally added as a facsimile with its closure arithmetic and its
  divergence from the record's carried figure. §3's sign-off facsimile gains the
  determinacy clause and a pointer to the filled instance. Split block: S4's
  falsity recorded, falsifiers 3 and 4 rebuilt against committed states, the
  Outsider's rule adopted as a blockquote. Stamp legend: `[SF]` minted as a
  seventh grade; both sole-spawner sites split into their limbs and re-stamped.
  Dialect: **kit**, **launcher**, **residue** defined, admission criterion
  replaced, count re-stated over its own list at fifteen. Boundary block: byte
  figure against the A.3 anchor plus the windowed reader's load order. §1.2:
  minimum legal seat set derived from §1.4's five separations as a fusion table.
  §2.6: the nine-of-eleven gap. §3.8: *the rule moved* corrected. §5.9 minted.
  §6.0: kit table gains a fourth column (known divergences), launcher pointer
  resolved as a substrate parameter, golden-tally row added, governance check
  commissioned with its owner, the two OPEN — CONDITION rows stated as current
  law. §6.1: `[SF]`, annex-pointer and golden-tally fork rows added, Annex C row
  resequenced. §6.2: six order-independent invariants, ten-line skeleton, Step 0
  re-sequenced into four acts, Step −1 gains the pinned SHA, eleven HALT citation
  sites run-tagged. A.3: the unexecutable-anchor improvisation written in as the
  instruction. A.7/A.8: A.8 repaired. §6.3: 21 → 22 decision records.
  Subsection index re-derived by its own printed command (72 headings).
- `docs/PROCESS-MEMOIR.md` → companion to the seventh edition. Header
  self-description corrected (Part I history / Annex B live ledger). Part 0: S4's
  falsity recorded, §0.2a restoration table added, §0.3 rebuilt across committed
  states, §0.4 falsifiers rewritten with the Outsider's rule, §0.5 census
  re-derived with its movement accounted. Part I: **fourteen margins restored
  verbatim from `d96a5b1`**, five new anchor blocks (§3, §3.1, §3.4, §6.2, A.7).
  B.0.4 notes the conditions' promotion to the core. **B.12 added** — the
  seventh edition item by item, 26 rows plus six refusals. Annex C gains the
  golden-tally and launcher rows. Part IV gains the seventh-edition row.
- `docs/process-golden-tally.json` → **new**. The machine-readable original.

### Evidence
All commands run from a checkout at this commit.

- **Falsifier 1** — `grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS.md`
  → **0**.
- **Falsifier 2** — every `### Anchored at —` heading in the companion's Part I
  (**27**, up from 22) names a heading that exists in `docs/PROCESS.md`:
  **0 unresolved**.
- **Falsifier 3** — `git show d96a5b1:docs/PROCESS.md | wc -l` → **5,446**;
  `wc -l docs/PROCESS.md` → **5,538**; `wc -l docs/PROCESS-MEMOIR.md` →
  **2,028**; pair 7,566; net +2,120. All four figures printed in the companion's
  §0.3 match.
- **Falsifier 4, the one that failed last edition** — all 50 sentinel-marked
  passages extracted from `d96a5b1:docs/PROCESS.md` and fingerprinted against
  both volumes: **50 checked, 0 lost.** Against the sixth edition at `d96ffe2`
  the same procedure returns **14 lost** (fifth-edition lines 1036, 1276, 2036,
  2073, 2167, 2260, 2440, 2629, 2657, 3651, 3988, 4081, 4455, 4643).
- **Sentinel census** — `grep -c … docs/PROCESS-MEMOIR.md` → **52** = 46 Part I
  uses + 1 Annex B use + 5 mentions; the printed census claims 47/52 and 46 in
  Part I. Movement from the sixth edition: 33 + 14 = 47, exact.
- **Subsection index** — the document's own printed `awk` command re-run against
  `docs/PROCESS.md` and compared entry-by-entry with the printed list:
  **identical**, 72 headings, seam counts included.
- **Dialect** — 15 bullets under *The dialect*; the head claims **Fifteen**.
- **Boundary block** — `wc -c docs/PROCESS.md` → **366,906** bytes (printed);
  `wc -c docs/PROCESS-MEMOIR.md` → **198,269** (printed); anchor 262,144; core
  40% over, companion inside.
- **Golden tally** — `docs/process-golden-tally.json` validated: sealed 65 =
  seeded 62 + difference 3; seeded 62 = killed 61 + survived 1 + gbb 0;
  per-campaign rows sum to the totals; `sealed_by_manifest − seeded ==
  len(not_seeded)` holds for all ten campaigns; the difference carries exactly
  one member per ground (1, 2, 3). Every figure printed in §3.9's block matches
  the file.
- **Tally provenance, class by class** — era figure and its five columns:
  `SO-xgmii_rx_64.md` §2.2 and §2.2-M (walked at `2183d71`, trajectory table).
  Survivor `G-c4`: §2.2-M — unmodified `g-c4.diff`, `mut/wo-0056-gc4-replay` =
  `c95c9f4`, CI run `30852220315`, killing unit `M03-G8` alone of 27.
  Never-rendered `IC-M5`: `WO-0074-mutations/README.md` §3.5, NOT SEEDED under
  D-M5a, no branch cut. Unscoreable `I-c1`: §2.2-D.4, ruled at `WO-0061`
  (`FINDING A-1`, `DISP-0001`), ground disclosed pre-run. **Negative control
  `IC-2`**: `WO-0063B_m03-i2-report-path-campaign-SEALED-predictions.md` §3.3 and
  §5 item 5 (frozen pre-run); run at `mut/wo-0063b-ic2` = `dbc4b0a`, CI
  `30955861141`; campaign verdict — *"M03-I2 is GREEN… Kills: 0, by design"*;
  one seal cell falsified (`M03-D2`) and recorded unedited.
- **Sole-spawner adjudication** — `docs/reports/audit/PROCESS-claims-posture.md`:
  C-01 is the §1.0 compound (REVIEW-ENFORCED), C-06 the spawner limb
  (REVIEW-ENFORCED, evidence cell noting it is asserted as a substrate fact),
  C-07 the committer limb (**FALSE**). §1.0's old set `{C-01, C-06}` omitted C-07.
- **Constitution gap** — `grep -c 'R10\|R11' agents/PROTOCOL.md` → **0**.
- **Decision records** — `ls docs/adr/ | wc -l` → **22**.
- **Markdown integrity** — all 11 core tables and 17 companion tables have
  uniform column counts; 0 unresolved `[B.12·n]` pointers (23 used, rows 1–23
  exist); 0 substitution placeholders remain in any of the three files.

### Outcome
The verdict's repair list is discharged: repairs 1–8 performed, plus the A.8
disposition, plus §5.9 as the museum exhibit the Contrarian's finding requires.
**One item is refused on the record** — the instruction to mark Ground 3 as
design intent — with the exercised instance cited in the document and the reason
the council could not see it stated beside it. Three items are stated as
routed rather than performed, each because the file belongs to another seat:
the R10/R11 constitutional diffs, ADR-0022's three countersignatures, and the
four charters' and gate checklist's re-quoting. The governance CI job is named
with its owner (orchestrator) and not built; probe 5.2 is stated as the council
set it and not run. Handoff: to the orchestrator for verification and commit —
`docs/PROCESS.md`, `docs/PROCESS-MEMOIR.md`, `docs/process-golden-tally.json`.

### Open-questions
1. **Ground 3's refusal is the round's live disagreement and the council should
   adjudicate it, not me.** I hold that `IC-2` satisfies every element §3.9
   requires and that the verdict's premise is false of the record. If the council
   disagrees, the disagreement is about whether a control whose seal names one
   assertion and predicts a green is a *negative control* in §3.9's sense or
   something narrower — and if it is something narrower, §3.9's definition is
   what needs the repair, not its anchoring.
2. **The `63 → 65` re-statement is owed by the verification lead and is not
   performed.** The core and the golden tally both state the movement and name
   whose act it is; the sign-off packet's own SC-5 cell still carries 63 under
   the superseded definition. Until that lands, the program has one figure in two
   units, which is the exact class §5.9 was minted for — in the round that minted
   it.
3. **`docs/process-golden-tally.json` has no consumer yet.** It is derived from
   by hand and checked by hand. Its whole value is that the commissioned
   governance job reads it and fails when §3.9's printed block disagrees; until
   that job exists, the file is a better artifact than a prose tally and is not
   yet the structural cure the verdict graduated.
4. **The core is 40% past its own A.3 anchor and the seventh edition made it
   larger, not smaller.** Disclosing the violation is not repairing it. The
   complete repair is a smaller core, and no council has yet asked for one; the
   First Principles Thinker's argument — that the binding constraint stopped
   being description two editions ago — is the one this edition does not answer.
5. **The escape ledger has still never existed and the recovery drill has still
   never run**, five and six editions after each was first named. Neither is
   document work and both are now the oldest live items in the record.
6. **One preserved margin is mis-filed rather than lost** (fifth-edition line
   4825, in B.1 rather than under a Part I anchor). It is named at §0.2a and left
   in place; moving it would edit a row three editions of readers have cited.

### Files-in-this-commit
- docs/PROCESS.md
- docs/PROCESS-MEMOIR.md
- docs/process-golden-tally.json

## [J-architect_docs_lead-0058] 2026-08-17T22:54:18Z | task:none | The retraction arrives from the shell and this program still holds the outbound half: ADR-0023 moves every harvest destination inside this repository, writes the constitution's diff for the orchestrator to apply, retires the sponsor refusal power along with the transit that made it a power — and names two owed-restatement targets the dispatch did not, because a record that cites §5.9 and then omits a live target has minted the defect it quotes

### Trigger
Orchestrator dispatch, one round, **dispatch-only — no `WO-` packet**, and the
entry is obliged to declare that rather than let it pass. The class is the one
`docs/PROCESS.md` §3.2 names and this seat has now written four entries under:
the commissioning seat is also the sole committer, so a work order would be a
packet the orchestrator writes to itself and then commits, and the dispatch text
plus this entry carry what a `WO-` would have carried. **No siblings were
declared** and none was announced in flight, so §4.2's inward declaration is
answered with a nil rather than performed.

The commission: mirror, in this program's law, the retraction the shell
(`generic-agentic-fpga-org`) executed on the sponsor's 2026-08-17 direction.
Two deliverables — a new decision record, and an amendment to the gate block
that carries the harvest's tier routing.

**§4.1 abort-first precheck, run first, both outputs recorded**:

```
$ git status --short
            (no output — clean tree)
$ git log --oneline -1
dc4785e Two adversarial rounds convict the page of animating the implementation
        lead reviewing verification's own bench - and of keeping every worker
        alive for two minutes while telling the reader they are short-lived
```

Both match the dispatch's expected state exactly: `HEAD = dc4785e`, clean tree,
no declared siblings. Nothing was aborted.

### Inputs
- `agents/charters/architect_docs_lead.md` — my charter, read first, in full.
- `agents/PROTOCOL.md` (450 lines) — the constitution, read in full. §7's
  lessons-harvest paragraph at lines 332–359 is this round's subject; §4 (entry
  grammar), §5 (R1–R9), §6 (write scopes) and §11 (amendment procedure) govern
  the round's form.
- `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md` — read in full,
  all 1,596 lines: §§1–12, Amendment A1 (the domain tier, the classifier,
  `LD-`, the parked federation-governance decision at A1.7(4)), Amendment A2
  (the 7/4 partition A2-D1…A2-D5, the seat-qualified id A2-D6…A2-D9, the span's
  closed end A2-D10…A2-D12). This is the record ADR-0023 amends.
- `docs/gates/lessons-harvest-block.md` (221 lines pre-edit, 237 after) — the
  file I amend.
- `agents/handoffs/HT-01_first-harvest-transit.md` — the executed transit,
  including its own appended correction and §5's PR #3 record.
- `docs/federation/outbox/SO-xgmii_rx_64.md` — header and tier summary read
  (2,810 lines total; the 353 rows themselves not re-walked this round, and the
  entry says so rather than implying a re-audit).
- `/workspace/generic-agentic-fpga-org/docs/adr/ADR-0018-the-federation-retraction.md`
  — the shell's retraction, read in full, for the register and for its eight
  decisions. **Outside this repository**: read-only, cited, never edited.
- `docs/PROCESS.md` §2.7 (the amendment procedure and its fourth requirement),
  §3.10 (the lessons harvest), §4.7 (the sponsor's reserved decisions), §5.9
  (the amendment pipeline has no last mile), §6.0 (the export unit, including
  *"How the export actually moves"* at lines 4672–4689).
- `docs/gates/P1-module-ready-checklist.md` — §7.1 and the Yield/tier-3 sections
  read, **not edited** (see Reasoning).
- `docs/PROCESS-MEMOIR.md` — grepped for live pipeline claims; row `B.0.4b` and
  the §6.0 disposition rows read.
- `tasks/BOARD.md` — the `P1-module-ready` gate row and the `WO-0078` harvest
  row read for the owed obligations they carry.
- `docs/adr/ADR-0022-the-warranty-and-the-split.md` — header block only, for the
  house Status/Deciders idiom at its most recent.
- `agents/journals/claude_architect_docs_lead_agent.v06.md` — header and the
  tail of `J-architect_docs_lead-0057`, for the chain's next id and the entry
  format actually in use.

### Reasoning
**How this ADR came to be asked, which is the part the charter says must not be
a restatement of the ADR.** It was not asked by a defect found here. The sponsor
retracted a design premise he had authored — and the shell moved first, landing
its own ADR-0018 and a 24-file sweep at `cb8a9f3`. What arrived at this seat was
therefore a *fait accompli in another repository* plus a live constitution here
that still routes learning into it. The question I actually had to answer was
not "should the destination be local" — that was decided above me and is quoted
as the acceptance authority — but **which of this program's instruments are the
retraction and which are collateral**, because the cheapest wrong version of
this round is a sweep that deletes the harvest along with its destination.

**The discriminator I used, and it is the one the shell's own decision 2
supplies**: the harvest law survives *unchanged in discipline*; only the arrow
moves. So every clause I could reach was tested by one question — *does this
clause describe what a candidate must be, or where it goes?* Bars, grades,
classifier, spans, tiling, nil, war stories, self-mining, the clerical bar, the
id scheme and its grandfathering, and the whole in-flight accretion tier all
answer *what*, and none of them is touched. §4.2's shell tier, A2-D5's shell
commit, A2 Part B's shell boxes, the block's tier destinations and PROTOCOL §7's
Routing sentence all answer *where*, and all of them move. That test is what
kept the diff at one paragraph of the constitution rather than a rewrite of §7.

**Three judgement calls, each of which could have gone the other way.**

*One — the sponsor's refusal power.* The dispatch told me it retires; the
argument for retiring it rather than re-aiming it is mine and is at §8.5. It
existed to gate what left the program, and re-aiming it at a local landing would
be a **new** power, granted for a different reason, over the program's record of
itself, that nobody asked for. Retiring it is the smaller act. The cost is real
and I recorded it rather than smoothing it: `docs/PROCESS.md` §3.10 carries a
good argument — *"a refusal power that cannot be exercised at the granularity of
the thing being refused is not a power, it is a notification"* — which is now an
argument about a power this program held, and §4.7's list drops from five items
to four. Both are named in the owed-restatement list rather than left for a
later reader to trip on.

*Two — the block's box arithmetic, which I got wrong first and then fixed.* The
dispatch asked for local-landing boxes carrying four properties and for the
`Sponsor-visible` box to become a line. My first pass made **dedup** a fifth box
and dropped sponsor visibility, giving Part B three boxes — and then §5.2 of the
record I was writing asserted a 7/3 partition while the file I had just edited
rendered four. The block file is the authority a future gate is graded against;
a record whose arithmetic disagrees with it is the A2.1 shape exactly (the block
over-reaches, a criterion quotes it in good faith, the executing round pays). I
chose the version that keeps A2.2's **7/4 unchanged and swaps one Part B box**:
dedup takes the retired box's seat. It is better on the merits too — dedup is
the one genuinely new risk of a local destination (§9's third failure mode), and
a risk with its own box is checkable, while a risk folded into another box is a
clause. The count-preservation is a consequence of the swap, not its motive, and
§5.2 says so.

*Three — where I exceeded the dispatch, deliberately and in one direction.* The
dispatch said of the block *"touch nothing else"*, and I touched three further
sites in it: the Yield caption, the Yield table's **Disposition** cells, and
three transcriber notes. The reason is not tidiness. Box 9, which I was told to
rewrite, **points at the Disposition column**; leaving that column offering
*"transcribed as `L-…` / sponsor-refused"* would have produced a template whose
box records a local landing and whose column instructs the next instantiator to
record a shell transcription and a retired refusal. Likewise §4's note asserting
*"several shell commits, one per harvest"* would have left one file saying two
things. **An internal contradiction inside one template is worse than a stale
cross-file restatement**, because the cross-file case is what §5.9's list is
for and the internal case is what a copying instantiator hits first. Every
mining, span, bar, nil and war-story box is byte-identical; §1 and §2's bar
table and classifier are untouched; the historical 2026-08-11 note is kept and a
second dated note is added beside it in the same idiom.

**And the symmetric restraint, which is the same judgement pointing the other
way.** `docs/gates/P1-module-ready-checklist.md` is an **OPEN gate record in my
scope** whose §7.1 carries harvest 1's Part B against the shell — the outbox
link, the inbox PR, the maintainer's id-mapping, a shell-diff sponsor line, and
finding `G-7` asking whether a shell commit may land before the gate that
ratifies it. It is stale as of this commit and I did **not** edit it. A2.4's
write-set discipline is the reason and it is not an inability: this round's
dispatched write set is two files, and an open gate checklist edited outside its
commission produces a `Files-in-this-commit` that disagrees with what was
commissioned — in the commit of a record about instruments minted in one
sitting. So it is **named in the owed-restatement list with a dated owner and a
closing event**, which is §5.9's cure applied honestly rather than the version
where the list contains only what was convenient. The same reasoning added
`docs/PROCESS-MEMOIR.md`, whose `B.0.4b` is an open condition that returns a
halt log *through the federation inbox*. **Neither was on the dispatch's list.**
A record that quotes §5.9 and then ships an incomplete list has minted the
defect it cites, in the round that cites it — that is the failure shape §5.9
itself describes, and I was not willing to be its next exhibit.

**On HT-01, the one thing I refused to propose.** The tempting disposition is to
finish the delivery — hand the 353 to the shell's maintainer as one hand-carry,
since the shell's own decision 5 permits exactly that. I rejected it at §8.3 on
jurisdiction: the maintainer's adoption is **optional and theirs**, and making
this ADR's completion depend on it would re-create the outbound obligation in
the one form the retraction left standing. This program's obligation is the
local landing, and it completes when the file holds the 353. The other tempting
disposition — delete HT-01 and the outbox — is rejected at §8.2 on the rule this
program applies to every frozen record it owns: **annotated, never rewritten**.
That rule is not decoration here; HT-01 is the *authority* for the local
landing, since it holds the extraction fidelity checks, the merge sweeps and the
hide-test verdicts that make the 353 citable at all.

**One thing I found rather than inherited**: the four shell-corpus merge
pre-judgments (`ADL-45`→`L-B15`, `rtl H1-8`→`L-D03`, `AUD-14`→`L-C15`,
`AUD-10`→`L-E06`) **cannot be executed locally**, because their surviving
partners are entries in the shell's seeded corpus and this program inherited no
corpus. They land as ordinary entries carrying the pre-judgment as a recorded
annotation. The dispatch said "carried as recorded annotations" and did not say
why; §6.2 supplies the why, because a later reader who finds four entries marked
"merges to `L-B15`" beside no `L-B15` deserves the sentence explaining it.

**Why the PROTOCOL diff is written here and applied elsewhere.** PROTOCOL §3.6's
rule — the instrument does not edit the file it governs — plus ADR-0016 §8's
holding that an ADR is not an exception to a write scope. This is the third hunk
this seat has authored for the orchestrator to apply (ADR-0018 §8, A1.6, now
this). I machine-checked it against the live file rather than eyeballing the
context, using A1.6's own method: extract the patch body *from the record's own
section*, so the check runs against the text a transcriber will copy and not
against a retyped duplicate.

### Actions
1. Ran the §4.1 precheck; recorded both outputs verbatim in Trigger.
2. Read the charter, the protocol, this program's ADR-0018 entire, the gate
   block, HT-01, the outbox packet's header, the shell's ADR-0018, and the five
   `docs/PROCESS.md` sections that restate the routing.
3. **Created** `docs/adr/ADR-0023-the-retraction-mirrored-lessons-are-local.md`
   (688 lines): Status with the sponsor's direction quoted verbatim and the
   acceptance act named as the orchestrator's separate entry; Deciders,
   Proposed-by, Work-order (none), Journal (this entry), Affects; §1 context
   including the shell's eight decisions and this program's four still-outbound
   artifacts; §2 decisions D1–D5; §3 the unmoved sites as a table; §4 the
   PROTOCOL §7 diff with the replaced sentences quoted before it, the hunk, the
   machine-check, and a clause-by-clause table of what the replacement says;
   §5 the block's edit as performed; §6 HT-01, the 353, and PR #3; §7 the
   owed-restatement list, seven rows; §8 five alternatives; §9 consequences and
   four failure modes; §10 the non-decisions.
4. **Amended** `docs/gates/lessons-harvest-block.md` in place, ten sites:
   preamble (a second dated note, in the file's own idiom); §2's tier line;
   §3's Yield caption; §3's two Disposition cells; §3's tier-3 heading; §3's
   Part B boxes 8, 9 and 10 (box 10's seat re-used for dedup); the standing
   sponsor line replacing the `Sponsor-visible` box; the `SO-` deferral line;
   and three of §4's transcriber notes. Box count verified at eleven, unchanged.
5. Corrected my own first pass, three times, before finishing: the 7/3-vs-7/4
   arithmetic (Reasoning, call two); a tier-1 arithmetic slip that had dv's 95th
   row double-counted into the 352 (the seven chains sum to 352 exactly; the
   95th is the `LD-` row, and §6.2 now shows the sum); and **a false claim I
   nearly landed about markdown** — that the machine-check snippet's nested
   three-backtick pattern breaks its own fence, and that ADR-0018 §A1.6
   therefore renders wrong. It does not: a closing fence must be a line of
   backticks and nothing else, so backticks inside a `sed` argument close
   nothing. I had already widened both fences to four backticks and written the
   accusation into §4 before checking the rule; both are reverted, and §4 now
   records the correct reading and that this seat acted on the wrong one first.
   **A record whose first act is to convict a landed file of a defect it does
   not have is the vacuity finding pointed at another seat.**
6. Appended this entry. **No git write command was run** — not `add`, not
   `commit`, not `push`. `git status`, `git log` and `git apply --check` are
   read-only and are the only git invocations of the round.

### Evidence
All commands run from a repo checkout at this commit; the first two were run at
parent `dc4785e` before any edit and are quoted in Trigger.

```sh
# The hunk at §4 applies to the live constitution — extracted from the record
# itself, per A1.6's method, so the check is against the text a transcriber copies:
sed -n '/^## 4\. The PROTOCOL §7 diff/,/^## 5\./p' \
    docs/adr/ADR-0023-the-retraction-mirrored-lessons-are-local.md \
  | sed -n '/^```diff$/,/^```$/p' | sed '1d;$d' > /tmp/adr23.diff
wc -l /tmp/adr23.diff
#    25 /tmp/adr23.diff
{ printf -- '--- a/agents/PROTOCOL.md\n+++ b/agents/PROTOCOL.md\n@@ -347,13 +347,19 @@\n'
  cat /tmp/adr23.diff; } | git apply --check -v -
#    Checking patch agents/PROTOCOL.md...
#    exit=0
```

```sh
# The block carries no surviving reference to the retired destination. The one
# hit is the new standing line, which names it in order to say nothing leaves:
grep -n "shell\|sponsor-refused\|Sponsor-visible\|leaves this repo" \
    docs/gates/lessons-harvest-block.md
#    185:is the sponsor's whole lessons touchpoint: nothing leaves this repository, so
```

```sh
# D2's "this program inherited no corpus" is checkable here, and this is the check:
# the file the retraction makes the destination has never existed in this history.
git log --all --oneline -- docs/LESSONS.md
#    (no output)
```

```sh
# A2.2's partition survives in count: eleven boxes, seven Part A and four Part B.
grep -c "^- \[ \]" docs/gates/lessons-harvest-block.md
#    11
```

```sh
# The round's write set is exactly the two commissioned files:
git status --short
#     M docs/gates/lessons-harvest-block.md
#    ?? docs/adr/ADR-0023-the-retraction-mirrored-lessons-are-local.md
```

The 353 / 352+1 / 47 figures at §6.2 are the **outbox packet's own** tier
summary, read at `docs/federation/outbox/SO-xgmii_rx_64.md`, not re-derived by
walking its rows this round — stated so no reader takes them for a fresh audit.
The four merge pre-judgments and the seeded corpus's 44 entries are HT-01 §2.1
and §3.3. The shell's `main = cb8a9f3`, its ADR-0018 and its 24-file sweep are
the orchestrator's relay and the shell's own committed record, read at
`/workspace/generic-agentic-fpga-org/` — **outside this repository, and not
re-verifiable from a checkout of this one**, which is exactly the class ADR-0018
A1.7(4)(b) named and which this retraction removes the need for going forward.

### Outcome
**DoD met for both dispatched deliverables**, with one item exceeded and one
deliberately not performed, both recorded above rather than in chat.

- `docs/adr/ADR-0023-…` created, carrying every element the dispatch enumerated:
  Status/Deciders/Proposed-by/Work-order/Journal/Affects; decisions (1)–(5) as
  D1–D5; the explicit §11(3) statement that no test case is owed; alternatives
  recorded honestly with the three the dispatch named plus two more; the
  not-decided list; the PROTOCOL §7 diff with the current sentences quoted and
  the replacement written in full, surrounding clauses intact; and the
  owed-restatement list under PROCESS §5.9's cure.
- `docs/gates/lessons-harvest-block.md` amended in place, tier descriptions and
  Part B re-scoped, every mining/span/bar/nil/war-story box untouched.
- **Exceeded**: the owed-restatement list carries seven rows, not the five
  dispatched — `docs/PROCESS-MEMOIR.md` and `docs/gates/P1-module-ready-checklist.md`
  were found live-stale and named.
- **Not performed, by design**: `agents/PROTOCOL.md` (orchestrator scope, §4's
  hunk is the source text), `docs/LESSONS.md` (the collator's to create and
  seed), `agents/handoffs/HT-01_…` (its author's appended note), `tasks/BOARD.md`
  (orchestrator scope), and the P1-module-ready checklist (owed to my next
  `docs/gates/` round, jointly with A2.4's five clerical edits).

**Handoff**: to the orchestrator, for verification and commit, and for the four
acts §7 rows 1, 4, 5 and the `docs/LESSONS.md` seeding assign to it. **Nothing
in this round is in force until the orchestrator writes its acceptance entry** —
PROTOCOL §11(2), stated in the record's own Status block.

### Open-questions
1. **The travel copy that never travels has no cure and I did not invent one.**
   Hand-carry is machinery-free by direction, so the failure mode — a file with
   an aspirational header that no human ever hands to anyone — is unguarded, and
   §9 says so rather than proposing a transport under a new name. The visible
   signal I could name is thin: a baseline line that never moves and a file no
   session cites. Whether that is a finding shape for the auditor is not decided
   here, and it is the same open question ADR-0018 §7.1 left about nil yields.
2. **`docs/LESSONS.md`'s internal format is left to the collator and that is a
   real delegation, not a formality.** Section naming, entry fields, how a
   domain-titled section is headed, how the baseline line reads and how an
   annotation records a merge pre-judgment against an absent partner are all
   decisions the seeding commit will make, and this record fixes only the
   destination, the routing and the header contract. If the collator's shape
   turns out to need law, it needs an A-amendment to this record, not a silent
   convention.
3. **ADR-0018's A1.7(4) parked federation decision is retired *by* this record
   rather than *at* the sponsor's own act.** §3's table calls it retired with its
   subject, which I believe is right — the question was the acceptance policy
   for foreign lessons arriving at a shared corpus, and no shared corpus exists.
   But it was explicitly the **sponsor's** parked decision, and a seat retiring
   another party's parked question because the question's subject vanished is a
   move worth someone disagreeing with out loud. If the sponsor wants it kept
   parked against a future design, that is a one-line correction to §3.
4. **Row 7 is a live gate record that is stale from the moment this commits.**
   `docs/gates/P1-module-ready-checklist.md` §7.1 will describe a shell
   transcription, an open PR and a maintainer's id-mapping until my next
   `docs/gates/` round lands. That window is the §5.9 defect in miniature,
   accepted deliberately for write-set discipline and disclosed rather than
   avoided — which §5.9 itself warns is exactly how the class survives. The
   window should be short, and naming it here is the only pressure I can apply
   from inside this round.
5. **Finding `G-7` is answered by retirement, and nobody has ruled that it is.**
   *May a shell commit land before the gate that ratifies it?* has no subject
   now. I stated the answer in §7's row 7 rather than in a ruling, because the
   finding lives in a file I did not open this round.

### Files-in-this-commit
- docs/adr/ADR-0023-the-retraction-mirrored-lessons-are-local.md
- docs/gates/lessons-harvest-block.md

## [J-architect_docs_lead-0059] 2026-08-17T23:41:30Z | task:none | The eighth edition is the first this document did not need a grader for: six streams moved the record under six stamped claims in five days, the text moves to match without one stamp being re-measured — and three counts the dispatch handed me came back wrong against the record, including one the seventh edition had already been carrying stale from the fifth

### Trigger

Orchestrator dispatch, one round, **dispatch-only** — the class §3 of the process
description names and this entry is obliged to declare rather than let pass. No
work-order packet exists; the commission is the dispatch text at
`wo-eighth-edition.md`, and this is the fourth consecutive edition commissioned
that way (`docs/PROCESS-MEMOIR.md` B.6).

The commission: the **eighth edition** of `docs/PROCESS.md` and its companion
`docs/PROCESS-MEMOIR.md`, as a **currency edition** — twenty-four numbered edit
items over six streams of record motion that landed after the seventh edition's
commit `2ed029d` and are reflected nowhere in it. Expected head `5d2264d`, clean
tree, no declared siblings.

### Inputs

Read in full: `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md`;
the dispatch. Then, as the dispatch names them:

- `docs/PROCESS.md` (5,538 lines) and `docs/PROCESS-MEMOIR.md` (2,028 lines) at
  `5d2264d`, both end to end.
- `docs/adr/ADR-0023-the-retraction-mirrored-lessons-are-local.md` in full — my
  own last round's record, whose §7 rows 3 and 6 are this dispatch.
- `docs/adr/ADR-0021-a-check-is-only-where-it-runs.md` — Status block and §§1–5
  (subjects 1–4, §3.4's posture-asymmetry ground, §3.5's `FINDING ADR21-1`,
  §5.2's refusal and §5.4's evidence form).
- `docs/reports/process-council/round-5/probe-5-2-halt-log.md` — head, RAN-CLEAN,
  HALT-01/05/06/08/09, the Definition-of-Done table and SUMMARY.
- `agents/handoffs/WO-0084_m04-mutation-campaign.md` return log rows 1–4;
  `agents/handoffs/WO-0085_tb-m04-cfg-ifg-gap-axis.md` header.
- `agents/handoffs/HT-01_first-harvest-transit.md` §6 (the appended disposition
  note); `docs/LESSONS.md` front matter and landing H1.
- `/workspace/generic-agentic-fpga-org/docs/adr/ADR-0018-the-federation-retraction.md`
  §Decision, and `/workspace/generic-agentic-fpga-org/BOOTSTRAP.md` Stage 0 plus
  `README.md`'s *Getting started* — **outside this repository, and named as such
  wherever the core rests on them.**
- `scripts/policy.sh`, `scripts/check_journals.sh`, `scripts/agent_commit.sh`,
  `scripts/check_process_doc.sh`, `.github/workflows/journal-check.yml` — read as
  evidence, not as editable text (all orchestrator scope).
- `agents/journals/claude_architect_docs_lead_agent.v06.md` tail, for the next
  free id.

### Reasoning

**1. What kind of edition this is, and why the anchor has to say so.** Editions
two through seven were each produced by a committed external measurement *of the
document* — a posture census, four councils, two cold readers, an external
grading — and Part IV's genealogy makes that pattern its one generalisable claim:
*the anchor moved on contact every time, seven for seven.* This edition breaks
it. Nobody graded the document; what happened is that the **world under six
stamped claims moved in five days**. A document whose running lines describe a
retracted mechanism, an unbuilt instrument that exists, and an untested path
executed twice is **false in the present tense** whatever its stamps say, and no
grader is required to establish that.

I could have written the anchor as though this were a seventh-council edition and
said nothing. I refused that on the ground the document itself supplies: a
genealogy that fits every edition to one pattern is a genealogy nobody can
falsify. So Part IV carries the departure explicitly, and it carries the
distinction that makes the departure legitimate rather than convenient —
**a currency round and an audit round are different instruments**, the first
cheap, self-commissionable and checkable against commits, the second expensive
and only meaningful from outside. Running the first and calling it the second is
the failure; running only the second means the document is accurate about a world
five days stale at every reading in between. That paragraph is the one piece of
this edition I expect a later council to argue with, and it is written so that it
can be.

**2. The dispatch's own rule — no stamp re-measured — is what makes the whole
round tractable, and I applied it literally.** Six rows (`C-46`, `C-53`, `C-54`,
`C-55`, `C-56`, `C-119`) now index worlds that have moved. The tempting act is to
re-stamp them; that is this seat editing the measurement that grades its own
document, which is §5.7's root class in one act and is refused in B.13's refusal
list for the seventh consecutive edition. What I did instead, at every one of the
six sites: **state the new fact, name the act that changed it, date it, and say
in terms that the row still indexes the world before it.** The reader gets
current law and a visible seam; the auditor's artifact is untouched.

**3. Three counts the dispatch handed me came back wrong against the record, and
the dispatch's own instruction is what made me check.** The commission says
*re-measure every figure you print; never carry my numbers without re-running the
command*, and it turned out to bind the dispatch's own figures.

- **The posture-list debt.** E2/E4 said *"owed, three editions running" → four.*
  I traced the phrase through committed editions: it was written at the **fifth**
  (`d96a5b1`) and carried **byte-identical** through the sixth (`592926e`) and
  seventh (`2ed029d`). So *three* was three editions stale, and an increment
  would have shipped *four* against a true **six**. I wrote six, at both sites,
  with the carrying named in place — because the row's own subject is a debt
  nobody re-measures, and a stale count inside it is the row committing its own
  defect.
- **The drift check's edition count.** E19 said *four→five*. The core printed
  **four** while the companion's own refusal lists printed **five consecutive**
  at the seventh edition — the two volumes disagreeing about the same debt, in
  the direction that flatters. Re-derived from the refusal lists (third edition
  first named, this one sixth): **six**. I corrected the core against the
  ledger, because the ledger was the one that was right, and said so at B.0.4a.
- **The uart-demo founding's date.** The dispatch dated it 2026-08-15. The
  repository's own history spans **2026-08-12 to 2026-08-13**, sixteen commits,
  head `7e61184`. I printed what the record says.

None of these is a criticism of the dispatch; two of them are figures the
dispatch inherited from the document I wrote last time. The point is the one
§3.9 already states and this round exercised against its own commission:
**import the rules, re-derive the numbers.**

**4. One currency stream the dispatch did not name, found by sweeping, and it was
the most consequential single repair in the round.** The governance check the
seventh edition commissioned at §6.0 — printed there as
`[PLANNED — no posture row; the instrument does not exist]` — **exists**. It
landed at `9fa4159` as `scripts/check_process_doc.sh`, is wired into
`.github/workflows/journal-check.yml`, refuses rather than warns, and passes at
this tree. Two running lines called it absent: §6.0's block and the head's split
residue. Both are repaired.

The interesting half is *how it landed*, and it is why I printed the non-coverage
beside the coverage rather than announcing the closure. **The instrument that
landed is narrower than the one that was commissioned**: it holds falsifier 1,
the two-volume contract, the golden tally's closure against the core's printed
figures, and fence pairing — and it does **not** hold falsifiers 3 and 4, the
index re-derivation, or the cross-volume figures, on the stated ground that those
compare two committed editions and belong at an edition boundary. A commissioned
instrument that lands smaller than its commission is the case a ledger most
easily records as discharged, because **the commission is what a later reader
remembers.** So the core prints both halves in the same block and B.13 row 20
exists so the unlisted repair is a decision rather than a drift.

**5. What the retraction actually cost the document, and what it did not.** The
sponsor retracted a *topology*, not a discipline. §3.10's replacement is the
place that has to make that visible, and the sentence I care most about in this
edition is the one that says the harvest law survived the transport law's
retraction **whole** — every bar, span rule, grade, classifier and gate
precondition byte-unchanged; one arrow moved. That is the property that made the
retraction one round's work instead of a rewrite, **and it is only visible on the
day one of them is taken away, which is the day it is too late to build.** I
paired it with the other general form the episode supplies: *a mechanism priced
at design time is re-priced by its exercised value, and a pipeline that has never
landed is a design rather than an asset.*

Two judgements inside that section. I kept the granularity argument in the
companion rather than deleting it, because it is **still correct about refusal
powers in general** and simply has no subject here — and I wrote that distinction
out, since a ledger that records only *removed* cannot tell a later reader
whether a power was taken back or whether its object disappeared. And I stated
what did **not** change as an explicit list, on ADR-0023's own principle that an
amendment which does not say what it leaves alone invites a re-reading of
everything.

**6. §2.4(a) is the one place I moved a posture without an instrument landing,
and it is the move I want examined.** The clause's advisory note was *owed* for
three editions. It was then **designed and refused** — `ADR-0021` §5.2 traced its
two reachable cases and found it loud where a refusal already fires and silent
where the residue actually is. I wrote the posture as **deliberately absent by a
decided refusal**, which is stronger than *owed*, and I generalised it: a debt
ledger recognises two terminal states, *built* and *refused with grounds*, and
one that recognises only the first converts every considered refusal into a
permanent row and teaches its keepers that naming is cheaper than deciding. I
kept the honest remainder in the same breath — the constitution's withheld-results
advisory is still unbuilt and no script emits it, verified by grep.

**7. The seal census was re-derived by a better method than the one it asked
for.** E11 asked for thirteen→fourteen and nine→ten. Reading state lines would
have satisfied that. Instead I compared **every seal file's current bytes against
its bytes at the commit that introduced it**, which returns the flippers as a
measurement rather than as a reading: exactly four differ, exactly ten are
byte-identical, and the four are exactly the four whose state lines say
`UNSEALED`. That is a stronger claim than the one the section carried and it cost
one loop. The scored split (seven of eleven scored campaigns scored without a
byte of their seal being touched) rests on the seventh edition's seal-by-seal
measurement plus this round's one new scored campaign, and the arithmetic closes
both ways — which I take as a check rather than as a proof, and did not dress up
as a fresh walk of every verdict.

**8. §3.9's second survivor is the exhibit I think this record has been owed
since the campaign model was written.** The section's standing claim — *exactly
one defect in this record survived its own campaign* — is **still true under its
own definition**, and I said so first rather than quietly replacing it, because
the definition is a property of a **prediction** and not of a run. The new case is
a different object: a rendered class the seal held **no prediction over**, which
survived at exactly the configuration-coverage gap the seeding seat had
pre-flagged blind, in writing, before any run.

What makes it worth its lines is not the survival. It is that the campaign
mechanism's usual justification is negative — a seeder who knows the kill set can
choose sites that satisfy it — and this campaign supplies the **positive** one:
two independent partitions of one artifact found things neither would have found
alone. The seal's partition produced a clean seven-for-seven and no information
about the gap; the seeder's produced the gap and no predictions. **A campaign run
by one seat holding both partitions would have returned the score and not the
finding.** That sentence is the argument for the separation, and until this
campaign the record could not make it.

**9. §6.2's stop column needed a distinction, not an apology.** Run three returns
16 halts and **2 STOPPED**, against run two's 17 and **0** — which reads as a
regression and is not. Both of run three's stops are **by law**: a retro-audit row
an actor of one must leave open, and a stale aid a cadence rule forbids repairing
in place. I wrote the distinction as its own claim — *a stop by law and a stop by
under-determination are different objects; the first two runs' stops were the
document failing and run three's are the document holding* — because a halt log's
stop count is only comparable across runs if the stops are the same kind of
event, and this is the pair that proves they are not.

**10. What I refused.** The precedence rule's disagreement bullet was **doubly**
superseded and I could have simply deleted it. I kept the **constraint** it rests
on (the platform's picker cannot name a check it has never seen) and discarded
only the adjudication, because the constraint is what any order must satisfy and
the adjudication was an artefact of one pin. I also declined to add *travel copy*
to the dialect, per E24: it is defined once at §3.10 and reached by pointer
elsewhere, which is this document's own fact-once convention — and B.13's refusal
5 names it as a dialect candidate so the omission is a decision rather than an
oversight.

### Actions

- **Precheck (§4.1)** performed before opening any file; both commands' output in
  Evidence.
- `docs/PROCESS.md` — all twenty-two core-side edit items, plus three unlisted
  currency repairs found by sweeping (the governance check at §6.0 and at the
  head's split residue; §2.4's corollary exhibit; §5.9's cure-part-one note).
  No §-level heading added or removed; the dialect list untouched.
- `docs/PROCESS-MEMOIR.md` — seventeen passages preserved in Part I behind the
  sentinel under seven anchors, one of them new (`### Anchored at — 3.10`); a new
  manifest block **§0.2b**; §0.3's arithmetic re-derived; §0.4's falsifier note
  updated; §0.5's census re-run and reconciled; **B.13** minted with twenty rows
  and six refusals; B.0.4a/B.0.4b and B.3 updated; Part IV row eight and both
  closing patterns; Annex C's `HT-` and export-packet families marked retired and
  two rows added.
- Ran the governance check, the index derivation, the sentinel census, the sweep
  greps and every figure command below. **No git write command of any kind.**

### Evidence

Every command below was run from a checkout at this tree; the two `git ls-remote`
calls reach the network and are labelled.

```sh
# §4.1 precheck — both outputs, as dispatched
git status --short
#   (no output — clean)
git log --oneline -1
#   5d2264d Landing H1: docs/LESSONS.md is the travel copy, seeded verbatim from
#   the delivery that never landed - and the board stops asking for a transit the
#   law retired
```

```sh
# Both volumes, before and after. BEFORE is `git show 5d2264d:<path> | wc`.
wc -l -c docs/PROCESS.md docs/PROCESS-MEMOIR.md
#   before:  5538  366906  docs/PROCESS.md
#            2028  198269  docs/PROCESS-MEMOIR.md
#   after :  6023  403384  docs/PROCESS.md
#            2547  244076  docs/PROCESS-MEMOIR.md
# The boundary block prints 6,023 / 403,384 / 244,076 and 54 per cent past the
# 262,144 anchor; (403384-262144)/262144 = 0.5375. The memoir is inside it.
```

```sh
# E3 — the subsection index, re-derived with the command the document prints
awk '/^[`][`][`]/ { fence = !fence; next }
     !fence && /^##+ / { if (h != "") printf "%s · %d\n", h, n; h = $0; n = 0; next }
     !fence        { n += gsub(/C-[0-9]+/, "&") }
     END           { if (h != "") printf "%s · %d\n", h, n }' docs/PROCESS.md | wc -l
#   72        (unchanged; no §-level heading added or removed)
# Diff of the derivation before vs after the edits: exactly four seam counts
# moved, all upward, all where a stamped row is cited again in the sentence
# naming the later act:
#   2.2  5 -> 6 · 2.4  4 -> 6 · 2.6  13 -> 14 · 5.1  2 -> 3
# The pasted list was verified equal to the command's output, entry for entry,
# modulo the document's own bold-placement rendering.
```

```sh
# E23(d) — the sentinel census, reconciled
grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS.md
#   0                      (falsifier 1 closes; also enforced by CI, below)
grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS-MEMOIR.md
#   69
awk '/^## Part 0/,/^## Part I/'  docs/PROCESS-MEMOIR.md | grep -c 'SUPERSEDED — historical record, not current law:'   #  4  (mentions)
awk '/^## Part I/,/^## Part II/' docs/PROCESS-MEMOIR.md | grep -c 'SUPERSEDED — historical record, not current law:'   # 63  (uses)
awk '/^## Part II/,0'            docs/PROCESS-MEMOIR.md | grep -c 'SUPERSEDED — historical record, not current law:'   #  2  (1 use in B.1, 1 mention in B.10)
#   uses 63 + 1 = 64 · mentions 4 + 1 = 5 · 64 + 5 = 69, which is the grep.
#   Movement: seventh edition 47 uses -> 64. 47 + 17 = 64, and §0.2b manifests
#   exactly seventeen passages across sixteen rows (row 16 carries two).
```

```sh
# E13(a) — the marked-reference population, re-measured at this state (network)
git ls-remote origin 'refs/heads/mut/*' | wc -l
#   100
git ls-remote origin 'refs/heads/mut/*' | sed 's#.*refs/heads/mut/##' \
  | sed -E 's/^(wo-?[0-9]+[a-z]?).*/\1/' | sort -u | wc -l
#   18  = 16 campaign prefixes + 2 probes (bug3-sev-probe, wo70-cost-probe-l)
# The newest family is mut/wo-0084-class-01..13 plus class-03-v2 = 14 refs.
```

```sh
# The never-merged property, checked two ways because one way is vacuous here
for sha in $(git ls-remote origin 'refs/heads/mut/*' | cut -f1); do
  git cat-file -e "$sha^{commit}" 2>/dev/null && echo present || echo absent; done \
  | sort | uniq -c
#   86 present   14 absent
for sha in $(git ls-remote origin 'refs/heads/mut/*' | cut -f1); do
  git merge-base --is-ancestor "$sha" HEAD 2>/dev/null && echo MERGED; done | wc -l
#   0
ls .git/shallow 2>/dev/null || echo "not shallow"; git rev-list --count HEAD
#   not shallow
#   672
# The 14 absent objects are settled by the clone's shape rather than by a test:
# a full clone holds every ancestor of HEAD, so an object it does not have
# cannot be one. 86 tested + 14 by construction = none of the 100 merged.
```

```sh
# E11 — the seal census, by a stronger method than reading the state line
ls agents/handoffs/ | grep -ci SEALED
#   14
for f in agents/handoffs/*SEALED*.md; do
  intro=$(git log --diff-filter=A --format=%h -1 -- "$f")
  [ "$(git hash-object "$f")" = "$(git rev-parse "$intro:$f")" ] \
    && echo UNCHANGED || echo CHANGED; done | sort | uniq -c
#   4 CHANGED      (WO-0039, WO-0041, WO-0050, WO-0055 — the four early flippers)
#  10 UNCHANGED    (byte-identical to their introducing commit)
# The four CHANGED are exactly the four whose State line reads UNSEALED, so the
# state-line reading and the byte comparison agree.
```

```sh
# E21 and the two figures §6.3 carries
ls docs/adr | wc -l
#   23        (was twenty-two; ADR-0023 landed at 28c0707 this round)
grep -oE '"S[0-9]+' scripts/test_protocol.sh | sort -u | wc -l
#   51        (S1..S51 — unmoved, and §6.3 now says which of the two moved)
```

```sh
# E17 — the 353, re-derived from the landed file rather than quoted
grep -cE '^### `LC-' docs/LESSONS.md   #  352
grep -cE '^### `LD-' docs/LESSONS.md   #    1
grep -cE '^### `(LC|LD)-' docs/LESSONS.md  # 353
```

```sh
# ADR-0021's landings, and ADR-0023's, dated from the record not from the dispatch
git log -1 --format='%h %ad' --date=short 9fa4159   # 2026-08-12  (subjects 1,2,4)
git log -1 --format='%h %ad' --date=short 0e11ea8   # 2026-08-12  (subject 3, first green run)
git log -1 --format='%h %ad' --date=short 0fe5f8c   # 2026-08-17  (PROTOCOL §7 amended)
# E15's span, re-derived rather than carried (the dispatch said 2026-08-11):
git log --format='%h %ad %s' --date=short -S "the sponsor may refuse a candidate" -- agents/PROTOCOL.md
#   0fe5f8c 2026-08-17  (the clause leaves)
#   564420f 2026-08-04  (the clause lands)
```

```sh
# The unlisted stream: the governance check exists, and refuses
git log --diff-filter=A --format='%h %ad' --date=short -- scripts/check_process_doc.sh
#   9fa4159 2026-08-12
grep -n "check_process_doc" .github/workflows/journal-check.yml
#   25:        run: bash scripts/check_process_doc.sh
bash scripts/check_process_doc.sh
#   OK: process document invariants hold (sentinels, volumes, golden tally, fences)
#   exit 0
```

```sh
# The escape ledger, re-verified as still uninstantiated (E4 asked)
ls docs/reports/audit/dv_escapes.md          # No such file or directory
git log --all --oneline -- docs/reports/audit/dv_escapes.md   # (no output)
git log --all --diff-filter=A --name-only --format='' | grep -i escape   # (no output)
```

```sh
# E16/E18 — the shell, first-party (network), and the local checkout it was landed from
git ls-remote https://github.com/renatom11/generic-agentic-fpga-org refs/heads/main
#   cb8a9f3a715678dce1401a0726fd7711f32de751  refs/heads/main
git -C /workspace/generic-agentic-fpga-org log -1 --format='%H %ad' --date=short
#   cb8a9f3a715678dce1401a0726fd7711f32de751 2026-08-17
# The shell's Stage 0 (BOOTSTRAP.md) and README "Getting started" were read for
# the one-hop order and the protections-inside-G0 placement. OUTSIDE THIS
# REPOSITORY and not re-verifiable from a checkout of it.
```

```sh
# E18(d)/E19 — the second founding, measured rather than quoted (network + clone)
git ls-remote https://github.com/renatom11/agentic-uart-demo
#   7e611841572ebb4ba679db9854cf48f457c59ab8  HEAD / refs/heads/main
# Cloned to a scratch directory (EPHEMERAL — outside this repository and not
# reproducible from a checkout of it; re-clone to re-run):
#   git rev-list --count HEAD          -> 16
#   git log --format='%ad' --date=short | sort | uniq -c
#        6 2026-08-12
#       10 2026-08-13     <- the dispatch said 2026-08-15; the record says this
#   tasks/BOARD.md:  "609 checks, 609 pass, 0 fail" ; BUG-0001 = uart_tick_gen
#   reloaded its counter to 1 instead of 0, so the start bit was 433 cycles
#   against 434 for the nine following intervals; fixed at 27104a8.
#   The same board records, unprompted: no mutation campaign has been run, and
#   the module-ready gate is NOT SIGNED. The core prints that qualification.
```

```sh
# E22 — the two sweeps, at the final state
grep -n -i "federation\|outbox\|inbox\|transit" docs/PROCESS.md
#   11 hits, every one justified:
#     61,63   the anchor's stream 1 — names the retraction, dated
#     2513    §3's transit form, labelled record-not-practice with its retirement
#     2534    "EXECUTED (a transit that has been performed)" — a state the record
#             genuinely runs, on the one instance; true as written
#     2551    facsimile comment: "transit form, retired — §3, §3.10"
#     2564    the HT- line: "executed once; mechanism since retracted — §3.10"
#     2580    FALSE POSITIVE — the word "state transition" in the return-log skeleton
#     4857    the pin: "under a transit law since retracted (§3.10)"
#     4956    BOOTSTRAP kit row: "the federation namespaces it used to stage are gone"
#     5075    "There is no outbox, no inbox" — a negation, current law
#     5462    Step −1: "under the since-retracted transit law (§3.10)"
grep -n "eighty-six\|thirty-seven\|thirteen seals\|ten scored" docs/PROCESS.md
#   1 hit, deliberate:
#     3786    "five of thirty-seven committed renderings", now scoped in place to
#             "measured over the first artifact's campaign era, before this
#             record's eleventh campaign", so the figure keeps its truth as the
#             record grows. eighty-six, thirteen seals and ten scored are gone.
```

```sh
# E24 and two structural checks
awk '/^### The dialect/,/^---$/' docs/PROCESS.md | grep -c "^- \*\*"
#   15        (the list is untouched; "Fifteen terms" stands over its own list)
for f in docs/PROCESS.md docs/PROCESS-MEMOIR.md; do grep -c '^```' $f; done
#   32 / 2    (both even — fence pairing, which CI also refuses on)
git status --short
#    M docs/PROCESS-MEMOIR.md
#    M docs/PROCESS.md
```

**Not re-executed, and stated so no reader takes it for a fresh audit.** The
seventh edition's seal-by-seal *scored* split (four flippers scored, six frozen
scored, three frozen unscored) is **carried**, with this round's one new scored
campaign added on top; I re-derived the seal population and the flipped/frozen
split by the byte comparison above, not the per-campaign scoring status. The
golden tally at §3.9 is **untouched** and its figures are unmoved. The posture
list was **not opened**.

### Outcome

**DoD met.** Both volumes edited; every E-item executed; the journal entry
appended; the file list below is exact.

- **E1–E22** applied in the core, **E23(a)–(h)** in the companion, **E24**
  verified rather than changed.
- **Exceeded in one direction, and named**: three currency repairs the dispatch
  did not list — the landed governance check at two sites, §2.4's corollary
  exhibit whose live unrepaired instance was the same landing, and §5.9's
  cure-part-one note — performed under the dispatch's own governing rule that a
  running line must state the new fact where the record moved. B.13 row 20 exists
  so the widening is a decision on the record rather than a drift.
- **Three dispatched figures corrected against the record** (posture-list
  editions, drift-check editions, uart-demo dates), each with its derivation
  printed above and recorded at B.13 refusal 6.
- **Not performed, by scope**: `agents/PROTOCOL.md` (`R10`/`R11` still absent
  from its enumeration — `ADR-0021` §3.5's finding stands, re-verified this
  round), the four charters' and the gate checklist's re-quoting, and
  `docs/gates/P1-module-ready-checklist.md` §7.1 — ADR-0023 §7 row 7's owed item,
  still owed to my next `docs/gates/` round. `docs/reports/audit/**` untouched.

**Handoff**: to the orchestrator, for verification and commit. Nothing in this
round is in force as an amendment — it amends nothing; it makes a description
current.

### Open-questions

1. **The eighth edition has no external anchor and I do not think one was
   required, but that is a judgement a council should get to review.** Every
   prior edition followed somebody else's committed report. This one followed a
   direction and a record. I have written the distinction into Part IV rather
   than assuming it, and the question I cannot answer from here is whether a
   currency round should be *allowed* to run without a reviewer at all, or
   whether it needs a cheaper form of one — a single reader confirming that each
   repaired line matches the commit it cites. **The failure mode is specific: a
   currency round is exactly the round in which an author can smuggle a
   preference in beside a dated fact**, because every sentence around it is
   checkable and nobody re-reads the ones that are not.
2. **`C-46`, `C-53`, `C-54`, `C-55`, `C-56` and `C-119` are now six rows whose
   worlds have moved, and the posture list has not been re-measured for seven
   editions.** The seam column counts *citations*, so this edition raised it
   without raising coverage — which the index note now says. The debt is the
   auditor's and I did not touch it, but its cost has changed shape: it is no
   longer *the document grew*, it is *six specific rows are now known to index
   superseded worlds and the document says so in six places*. That is arguably a
   cheaper re-measurement than the general one, and whether it can be scoped that
   way is not mine to decide.
3. **The travel copy that never travels still has no cure and I did not invent
   one**, unchanged from my last round. §3.10 now carries the hand-carry contract
   as law with no machinery behind it, and the visible signal remains thin: a
   baseline line that never moves and a file no session cites.
4. **The precedence rule's coverage gap is disclosed and not repaired.** Run
   three had to invent the meta-rule under which four §6.2-only instruments still
   execute; I wrote the gap into §6.0 as the rule's honest limit, and left the
   meta-rule un-adopted. **Adopting it would be this document legislating for an
   order it does not own**, and refusing to adopt it leaves the next with-shell
   adopter inventing the same adjudication. I do not know which is worse and the
   text says so rather than choosing quietly.
5. **The governance check's non-coverage is now printed, which makes it
   countable and does not make it owned.** Falsifiers 3 and 4 are the two that
   catch a silent deletion, they are the two the check declines, and they are the
   two whose absence let the sixth edition ship a false warranty. An
   edition-boundary job that runs them against the previous edition's commit is
   the obvious instrument; it is another seat's scope, it is not commissioned,
   and naming it here is all I can do from inside this round.

### Files-in-this-commit
- docs/PROCESS.md
- docs/PROCESS-MEMOIR.md

## [J-architect_docs_lead-0060] 2026-08-18T00:14:00Z | task:none | ADR-0023 §7's last open row closes: the OPEN gate record stops quoting a transit that no longer exists, its four Part B boxes come back byte-identical to the amended block — and the completeness box is adjudicated against the landing entry that looks like it discharges it and does not

### Trigger

Orchestrator dispatch, one round, dispatch-only (no work-order packet). The
commission: discharge **ADR-0023 §7 row 7** — the owed-restatement list's one
row still open, `docs/gates/P1-module-ready-checklist.md`, an **OPEN** gate
record whose §7.1 carried harvest 1's Part B against the shell. The row was
minted by my own previous round (`J-architect_docs_lead-0058`) as one of two
targets the dispatch had not named, owed *"to `architect_docs_lead`, on the next
round that opens `docs/gates/`"*. This is that round.

**§4.1 precheck, both outputs recorded** (PROCESS §4.1; the refusal branch was
not taken because both matched the dispatch):

- `git rev-parse --short HEAD` → `9f6336a` — the eighth-edition commit, exactly
  what the dispatch said to expect.
- `git status --porcelain` → **empty**. Clean tree, nothing staged, nothing
  untracked.
- **No declared siblings**, outward, and none appeared inward: HEAD did not move
  during the round.

One thing the precheck did not anticipate and the entry records rather than
smooths: **the round crossed UTC midnight**. The law it re-quotes moved on
2026-08-17 and this annotation lands on 2026-08-18, so every dated marker I
wrote distinguishes the two — `[annotated 2026-08-18]` for the act, `2026-08-17`
for the law. A record that dated its own annotations to the day of the thing it
annotates would be claiming to have been faster than it was.

### Inputs

- `agents/charters/architect_docs_lead.md` — my charter, in full, first.
- `agents/PROTOCOL.md` — the constitution, in full. §7 (gates; the **Lessons
  harvest** paragraph as amended at `0fe5f8c`), §4 (entry grammar), §6 (scopes).
- `/tmp/.../scratchpad/wo-gates-requote.md` — the work order, in full.
- `docs/adr/ADR-0023-the-retraction-mirrored-lessons-are-local.md` (688 lines) —
  §§1–7 in full, D3, D4, D5, §5.1, §5.2, §6.1, §6.2, §6.3, and §7 row 7 with its
  `G-7`-answered-by-retirement clause.
- `docs/gates/lessons-harvest-block.md` as amended at `28c0707` — §1, §2, §2.1,
  §3's block (the current Part B four), §4's transcriber notes.
- `agents/handoffs/HT-01_first-harvest-transit.md` — §§1–5 and the appended **§6
  disposition note** (`J-orchestrator-0306`).
- `docs/LESSONS.md` at `5d2264d` — the travel-copy header, the **Landing H1**
  front matter, the first seat section (form check only).
- `agents/journals/claude_orchestrator_agent.v03.md` — `J-orchestrator-0306` in
  full, at the journal, not from a summary; `J-orchestrator-0305` header.
- `agents/handoffs/SO-xgmii_rx_64.md` §4.10 — the deferral line as the packet
  froze it, read to verify this file quotes it accurately.
- `docs/gates/P1-module-ready-checklist.md` — the subject, 555 lines, in full.
- `docs/PROCESS.md` §4.1, §4.2 (the precheck and the sibling discipline).

### Reasoning

**The re-quote is not optional and the file says why itself.** §0.2 is this
record's own constitution: *"this file states no condition its cited source does
not contain"*, minted after `FINDING SO-5`, where a gate instrument quoted its
source accurately and the source was wrong. On 2026-08-17 the sources moved
under the file — PROTOCOL §7 at `0fe5f8c`, the block at `28c0707` — and §7.1
went on stating four collation acts of which two no longer exist. Every box was
unchecked and every signature cell empty, so nothing frozen was disturbed and
the repair is cheap; the cost of not doing it is a collator arriving at this
gate and being told to link a shell commit.

**The governing distinction all round: what is a frozen measurement and what is
live text.** Three artefacts here are dated records and were annotated, never
rewritten — the packet's §4.10 deferral quote (frozen at `41fead6`), the packet's
bound 10 (a measurement of what did not exist at `41fead6`), and the three
transit-state bullets (true of 2026-08-11). Two are live conditions and were
re-quoted — §7.1's and §7.3's Part B boxes, and §7.3's Yield caption and tier-3
heading. **The test I used**: does the sentence assert something *about the past*
or *require something of a future checker*? The first gets a dated bracket, the
second gets the current law.

**Where I went further than "annotate" and why.** My first pass replaced §7.1's
four old boxes with the four new ones and kept only their gist in prose. Reading
it back, the old box 9 carried a **ruling** — *"checked against the maintainer's
returned mapping and against nothing else"* — that a reader of this record's
history would have found gone with no trace. So the four superseded boxes and
their `Reads` are now kept **verbatim inside a blockquote** beneath the live
four, with a line saying in terms that they are quoted and not live, because
four unchecked boxes in a gate file are a hazard if a checker cannot tell which
set binds. §7.3's old Part B is the same four; it points at §7.1's copy rather
than duplicating them, since two verbatim copies of a retired law in one file is
one more than the record needs.

**The completeness-box adjudication — the round's real decision.** Box 11 reads
*"Harvest declared complete by the orchestrator: `J-orchestrator-NNNN`"*, and
`J-orchestrator-0306` — the landing entry — says in its Outcome *"Part B of
harvest 1 is DISCHARGED locally"*. It is the obvious candidate and it reads close
enough to be mistaken for the discharge. **I ruled it does not discharge the
box**, on three grounds, and wrote all three into the box's own `Reads` so the
collator inherits the reasoning and not just the verdict:

1. **Act versus harvest.** `-0306` declares an act performed; box 11 declares a
   harvest complete. A harvest is complete when the boxes constituting it are
   checked at the gate that ratifies it, and three of the four had never been
   checked anywhere, because until the landing they could not be.
2. **A2-D3's principle, which ADR-0023 D5 applies to this very landing.** A gate
   inherits no box from another trigger; D5 says the landing discharges the
   *obligation to land* and is *"re-verified at `P1-module-ready` exactly as
   A2-D3 already provides"*. Evidence the boxes read, not the check itself.
3. **The entry convicts itself, and this is the ground I would defend hardest.**
   `-0306`'s own Outcome names *"the `P1-module-ready` checklist's own §7.1
   re-quote"* as work still outstanding. An entry that records this gate's record
   as still quoting a retired law cannot also be the entry that closes this
   gate's last harvest box — it would be declaring complete a harvest whose gate
   record it has just described as wrong.

**The counter-reading is in the file too**, because an adjudication that hides
the argument against it is an appeal record with a page torn out: a second
declaration looks like ceremony. It is not, and the reason is content — the
fresh entry asserts three boxes checked **against this record**, over a record
that did not exist in this form when `-0306` was written, and it is the entry an
auditor samples for this gate.

**Two readings I supplied rather than settled, and one I opened.** Box 8's *"and
nothing else"* meets a landing commit carrying four paths; I gave the collator
the citation that resolves it (ADR-0023 §6.1 directs `HT-01`'s note into that
same commit, §7 row 4 homes the board edit in the round, and R2 obliges the
journal) and left the clause's reading where it belongs. Box 10's *"outcome
recorded on its row"* meets a whole-set fact, because harvest 1 landed into a
file the landing commit created — determinate over an empty set, and the last
time this box is trivial, since harvest 2 checks against 353 entries. And
**`G-12` is opened**: ADR-0023 D4 leaves the sponsor *"exactly one"* touchpoint,
*"the gate signature they were already giving"*, and the block's standing line
has the landing ride *"the gate-closing commits the sponsor already signs"* —
but **PROTOCOL §7 gives `P<n>-module-ready` no sponsor signature at all**, which
is the exact fact the retired sponsor-visibility box was constructed around
(§7.2 explains it in the law it now quotes historically). Either the touchpoint
is empty until `P1-phase-accept` or the standing line names a gate class this one
is not in. §0.2 forbids me to settle that in this file's prose; it becomes an
item with an owner and a closing event, which is what §0.2 asks for instead.

**`G-7` is answered, and I refused the tidy version of the answer.** ADR-0023 §7
supplies it — *"the moment question A2 left open had a shell commit for its
subject, and there is no shell commit"* — and I recorded the ADR's answer in the
finding's row rather than ruling it myself. But retirement answers the question
as posed and leaves its local twin standing: **harvest 1's landing commit
`5d2264d` did land before the gate that ratifies it.** That is answered too, and
by an act rather than by silence — D5 performed the landing and provided for
re-verification here — so the row says so. A finding closed by pointing at a
retired noun, while the same question walks back in wearing the new one, is a
closure that will be reopened by the first person who notices.

**What I did not touch, deliberately.** `G-1` and `G-4(ii)` (they do not concern
the transit); Part A's seven boxes, which I then checked mechanically to prove I
had not moved them; `tasks/BOARD.md`, outside this round's write set and the
orchestrator's in any case. And one thing I found and did **not** repair, which
is in Open-questions: this file's §0.1 and §3 quote PROTOCOL clause (b) in a
wording the constitution stopped using on the same day the file landed.

### Actions

Edited `docs/gates/P1-module-ready-checklist.md` only (555 → 798 lines), nine
sites:

1. **§2.3 bound 10** — bound kept as the packet measured it; **disposition
   re-pointed** term by term (no `L-` id → ids landed unrenumbered; no shell
   commit → none owed, D3; no sponsor sight → retired, D4; completeness → still
   owed here), naming the landing, its commit and its entry.
2. **§7 preamble** — A2-D5's old sentence kept in a dated blockquote; the
   restatement quoted (one local landing commit per harvest); the retired
   rationale clause named as not surviving.
3. **§7.1 deferral** — the packet's frozen quote kept and labelled; the block's
   current deferral line quoted beside it with `<gate>` filled, and the
   four-for-four swap stated.
4. **§7.1 transit state** — the three 2026-08-11 bullets kept and labelled
   historical; a **State now** block added (PR #3 closed unlanded; the 353 landed
   at `5d2264d`; the outbox frozen in place).
5. **§7.1's four boxes** — re-quoted **verbatim** from the amended block, each
   with a `Reads` giving the citation its checker reads; the four superseded
   boxes and their `Reads` preserved verbatim in a blockquote beneath, with the
   quoted/live distinction stated.
6. **§7.2** — retitled to what it meant and what retired; the whole prior section
   preserved verbatim in a blockquote as *the law until 2026-08-17*; D4's
   retirement quoted; the block's standing line quoted; the angle it meets this
   gate at recorded as `G-12`.
7. **§7.3** — Yield caption and tier-3 heading re-quoted from the amended block;
   Part B's four boxes replaced with the current four, each with a harvest-2
   `Reads`; the block's standing line carried in beneath them.
8. **§8** — the sponsor row annotated: the refusal retired, `G-12` named.
9. **§9** — `G-6`'s closing event narrowed (the shell's independent screens are
   gone; the gate-time hide test is the only instrument left); **`G-7` answered**
   and marked CLOSED with its local analogue answered too; **`G-12` opened**.
   §10 item 6 annotated so no checker miscounts the quoted boxes as live.

No git write commands were run. No other file was touched.

### Evidence

All commands run from a clean checkout at `9f6336a` with only this file and this
journal modified; they reproduce at the commit that carries this entry.

- **Precheck**: `git rev-parse --short HEAD` → `9f6336a`;
  `git status --porcelain` → empty (both recorded in Trigger).
- **Part A boxes did not move** (A2.3's property, the one the partition rests
  on): `diff <(sed -n '147,168p' docs/gates/lessons-harvest-block.md) <(sed -n
  '609,630p' docs/gates/P1-module-ready-checklist.md)` → **two differences only**,
  both pre-existing this round: the heading form (`#### Part A — mining …` vs
  `### Checklist — Part A (mining)`) and one cross-reference (`(§2.1)` vs
  `(block §2.1)`). **Every box line is byte-identical.**
- **Both Part B instantiations are byte-identical to the amended block**: with
  the box lines and their continuations extracted (`grep -E '^- \[ \]|^      '`)
  from the §7.1 and §7.3 ranges and diffed against `sed -n '172,182p'
  docs/gates/lessons-harvest-block.md` → **IDENTICAL** for both.
- **Box counts**: `grep -c '^- \[ \]'` → **15** live (4 + 7 + 4, the 7/4
  partition and §10's stated four-and-eleven); `grep -c '^> - \[ \]'` → **4**
  quoted-historical; `grep -c '^- \[x\]'` → **0** — no box is checked by this
  file's author.
- **The sweep** (work order item 5), `grep -n -i
  "shell\|inbox\|transit\|sponsor-refused\|FEDERATION"` → **38 hit lines**,
  classified by line range: **4** in the historical transit bullets (§7.1, dated
  2026-08-11 and labelled), **9** inside the quoted superseded boxes (§7.1's
  blockquote), **7** inside §7.2's preserved *law until 2026-08-17* blockquote,
  and **18** in annotations that name the retirement, in the §9 rows that record
  it, or in the two `G-` rows whose question text is the retired mechanism.
  **None is live text asserting the retired law**; every one is either
  historical-labelled or part of the re-quote. *(The count rose from 28 at my
  first pass to 38 when I decided to preserve the four superseded boxes verbatim
  rather than in gist — the sweep number is a measure of preserved history here,
  not of residue, which is why it is stated with its classes and not alone.)*
- **The landing commit's shape** (box 8's `Reads`): `git show --stat 5d2264d` →
  four paths — `docs/LESSONS.md` (new, 2816 lines), `tasks/BOARD.md`,
  `agents/handoffs/HT-01_first-harvest-transit.md`, and the orchestrator's
  journal.
- **Quotation fidelity of the packet's deferral line**: `grep -n 'Part B —
  collation, deferred' -A 8 agents/handoffs/SO-xgmii_rx_64.md` → the packet's
  §4.10 text matches this file's quote word for word (line wrapping differs).
- **Table integrity**: §9's table renders 4 columns on all 14 rows including the
  new `G-12` (`awk` column count over the range).
- **Line discipline**: no non-table line exceeds 90 characters.

### Outcome

**DoD met** for a dispatch-only doc round. ADR-0023 §7 row 7 is **discharged**:
the OPEN gate record no longer states a condition its cited sources do not
contain, and every act it now asks of the collator exists. `G-7` is answered and
closed; `G-12` is opened in its place, which is a net of zero on the open set and
an honest one — the question it names was previously hidden inside a box that has
retired. Handoff: to the orchestrator, for commit; the collator inherits three
checkable boxes, one adjudication and one new open item.

**One board item, reported not touched** (work order item 6): the board's
*"A2.4's five clerical edits"* owed-item, which ADR-0023 §7 row 7 named as
sharing this carrier, **appears already applied** — the block at `28c0707`
carries the amended tier lines, the Yield caption, the tier-3 heading and the
Part B swap, and I found no unapplied clerical edit of that set left to make in
the block or in this file. The board is the orchestrator's; I record the finding
and do not act on it.

### Open-questions

1. **This file quotes PROTOCOL clause (b) in a wording the constitution stopped
   using six days ago, and I did not repair it — out of commission, reported
   here.** §0.1 quotes the `P<n>-module-ready` row **verbatim** as *"auditor's
   seeded mutations all killed by the DV suite"*; the row now reads *"the
   auditor's seeded mutations **dispositioned per Mutation record** below"*. §3
   quotes PROTOCOL §10's *"every PASS reports kills N/N (N ≥ 3 …)"*, which §10
   now states as *"the disposition of every seeded mutation, each non-kill named
   and dispositioned"*. **Measured**: this file landed at `61e0c76`
   (2026-08-11T04:06Z); the constitution's clause-(b) rewrite landed at `a76e485`
   (2026-08-11T19:21Z), fifteen hours later. So both quotes have been stale since
   the day the file was written, and **`G-1` — whose entire premise is that
   *"clause (b) says all killed"* — may already be answered, or reshaped, by
   ADR-0020's Mutation record.** I did not touch it because a second amendment's
   restatement riding this round would make it impossible to tell which round
   moved the gate's central mutation condition, and because `G-1`'s owners are
   the auditor and dv_lead. **It wants its own commissioned round**, and it is
   exactly the defect PROCESS §5.9 exists to catch — minted by an amendment whose
   own owed-restatement list did not include this file.
2. **`G-12` may be a defect in the block rather than a question about this
   gate.** The standing line ADR-0023 §5.2 put beneath Part B assumes a gate the
   sponsor signs, and two of this programme's four gate classes are not that.
   If the reading settles as *"the touchpoint arrives at the next sponsor-signed
   gate"*, the block's line wants a clause saying so — my scope, not this round's
   write set. I have not proposed the wording, because proposing it while also
   holding the pen on the file that would carry it is how a question becomes an
   answer without anyone deciding.
3. **The block's box 9 still spells the landed id `L-`, and no `L-` id exists.**
   Ids land seat-qualified and **unrenumbered** (A2-D6/D7), so the landed id is
   the minted `LC-`/`LD-` id and the pairing is an identity. The reading is safe
   because it rests on the box's own unrenumbered clause, but the spelling is a
   vestige of the retired fence's numbering and will confuse the next collator.
   A clerical pass on `docs/gates/lessons-harvest-block.md` is owed; it is inside
   my scope and outside this round's write set.
4. **Box 10 has never been exercised against a non-empty file**, and harvest 2 is
   the first time it will be. Everything the dedup box protects against — a drop
   performed silently, a composition dressed as a dedup — is unobservable in a
   landing that dropped nothing into a file that held nothing. The first real
   test of that box is also the first gate at which two harvests land, which is
   not the order I would have chosen for it.

### Files-in-this-commit
- docs/gates/P1-module-ready-checklist.md

## [J-architect_docs_lead-0061] 2026-08-18T01:19:29Z | task:none | The sponsor asks for the handbook in simplified technical english and the hard part is not the English: every claim in the source is calibrated, so the rendition's only real duty is to carry each calibration at exactly its source strength — 83 Status lines, one hedge-check pass, five flagged compound-tense keeps, and two figures in PROCESS.md that my own pointer paragraph falsified and I re-measured

### Trigger

Orchestrator dispatch, **dispatch-only** (§3's named class — no packet file at any
commit, and this entry is where that is recorded). The commission is the sponsor's
own, quoted in the work order: *"It would be good to write it in simplified technical
english."* The work order is
`/tmp/claude-0/-home-user-agentic-fpga/681e6e34-cd2f-5f3e-a4c3-42391e4d282b/scratchpad/wo-ste-volume.md`
— a scratchpad file, ephemeral, not in the repository, and named here as such
(ADR-0003/F5). Expected head `f84907b`, clean tree, no declared siblings.

### Inputs

- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` — mandatory first
  reads.
- The work order (above), read in full before any rendering.
- `docs/PROCESS.md` — **the whole document, 6,023 lines at `f84907b`**, read in five
  passes before a line of the rendition was written. The work order required this and
  it was load-bearing: the calibrations are distributed, and half of them qualify a
  claim made two hundred lines earlier.
- The `asd-ste100` skill (invoked and followed), for the structural/lexical split and
  the modality rule.
- `scripts/check_process_doc.sh` — read before writing, to know what my new file could
  trip.
- `docs/PROCESS-MEMOIR.md` head, for the precedence idiom the new volume mirrors.
- The tail of this journal, for the next free entry id.

### Reasoning

**What the deliverable is, and what it is not.** The sponsor asked for the handbook in
Simplified Technical English. The tempting reading is *a plainer PROCESS.md*. That
reading is wrong twice over: it would produce a second copy of the law that drifts —
the exact hazard §2.4 names and §6.0's missing drift check exists for — and it would
make the sponsor's request into a rewrite of a document whose every stamp is a
measurement. So the volume is **derived, not primary**: it carries the same precedence
idiom the MEMOIR and the facsimiles already use, it is re-derived per edition or marked
stale, and where the two disagree PROCESS.md governs and the rendition is the defect.

**The one duty that decides whether this is worth anything.** The work order names it
and it is right: the source is dense with carefully-calibrated claims — machine-checked
versus review-enforced versus owed versus performed-once versus refused-with-grounds
versus never-run — and a rendition that promotes one hedge falsifies the document
while reading better than it. Simplified Technical English makes this *harder*, not
easier: a length cap is a standing invitation to drop the qualifier, because the
qualifier is always the clause you can cut without the sentence becoming
ungrammatical.

**So the apparatus is the design decision, and it is this.** The volume **restates no
posture stamp**. It carries no `[MC]`, no `[RE]`, no `C-nn` row. Instead each
calibrated claim gets a **Status** line stating the calibration in words, in a fixed
vocabulary that never rotates: *a script refuses this* / *no script checks this, and
&lt;named carrier&gt; carries it* / *the instrument does not exist* / *this happened once, on
&lt;date&gt;* / *this program decided not to build it, on &lt;date&gt;* / *this has never run*.
Three properties follow. The reader gets the strength without inheriting a row number
that indexes a file they may not hold — which is §6.1's fork-contract rule applied
before anyone forks. The volume cannot silently claim a measurement it did not take,
because it takes none and says so in its own last paragraph. And a **More** pointer at
every section sends anyone who needs the stamp back to the source. 83 Status lines and
52 More pointers is the shape that came out.

**Why I rejected the two alternatives.** *Carrying the stamps through* would have made
the rendition a second evidentiary apparatus citing a posture list that measured a
different document — testimony wearing evidence's clothes, and the defect §6.1's fork
table exists to forbid. *Dropping the calibrations and rendering only the rules* would
have produced the thing the source spends six sections warning about: a rule set an
adopter inherits as a guarantee and operates as a hope.

**The mode split, declared once in the header.** Strict for everything normative.
STE-flavored for the compressed rationale, which is where the Reason and Failure lines
live. That is the skill's own split, and stating it in the volume's head is what stops
a reader grading the rationale lines against the strict caps.

**What I rendered, what I compressed, and what I refused to render.** §6.2's order and
Annex A's parameters are full renditions, because they are the two places a reader
*acts* from — the order is the section Simplified Technical English serves most, and a
substrate parameter read loosely is a control inherited as a guarantee. §5 is
lesson-plus-consequence per entry, per the work order. Everything else is rules,
Status, Failure and a pointer. **The anonymized patterns, the museum narratives, the
facsimiles and the worked tally are pointers and not renditions** — and that last one
is a judgment call I got wrong first and corrected, recorded below.

**The byte cap was the round's real cost, and what it bought is worth stating.** The
work order caps the volume at 200,000 bytes. My first complete draft came out at
**240,650**. The instinct — shave adjectives everywhere — bought 2 to 4 per cent per
pass and was the wrong instrument, because prose that is already one-claim-per-sentence
has no adjectives to shave. What actually worked was **re-reading the work order for
what it had told me not to render**: the worked tally (I had rendered its filled block
in full), the four §3.9 exhibits, and §5's incident shapes. Removing those was not a
size measure at all — it was a compliance repair that happened to weigh 8 KB. The
general form, and it is this round's lesson: **when an artifact is over a budget the
first place to look is the commission's own exclusion list, because a spec deviation
and a size overrun are usually the same object seen from two ends.** The rest came from
deleting rationale paragraphs whole rather than shortening them, and from consolidating
three calibrations that the source itself states once and points at.

**A second-order note on that, against my own interest.** The compaction took eleven
passes and I recorded the byte figure after each. Six of those passes returned under
1.5 KB, which is a measurement I should have read as *the instrument is wrong* after the
second, not after the sixth.

### Actions

1. **§4.1 precheck**, both commands, output recorded in Evidence. Head matched, tree
   clean, no siblings declared and none found.
2. Invoked the `asd-ste100` skill and followed it. Read `docs/PROCESS.md` in full.
3. Created **`docs/PROCESS-STE.md`**: header and precedence block, the mode split, the
   Simplified Technical English caveat, a flagged-departures section, a glossary of the
   source's fifteen dialect terms plus eleven operational terms, §§1–6 mirroring the
   source's numbering subsection for subsection, Annex A.1–A.9 in full, and a closing
   fidelity-sweep section stating what the volume does not render.
4. Added **one paragraph to `docs/PROCESS.md`**, immediately after the *Where to go.*
   paragraph in *Read this first*, in that file's own voice: the rendition exists at
   `docs/PROCESS-STE.md`, it is not law, it is re-derived per edition or marked stale,
   and where the two disagree this file governs. It carries no posture row and states
   its posture in prose, per that document's own rule for a claim added after the
   measurement.
5. **Re-measured two figures in `docs/PROCESS.md`'s boundary block that my own
   paragraph falsified** — the byte count and the line count. This is the round's one
   unrequested edit and it is argued in Open-questions.
6. Ran the mechanical Simplified Technical English checks and repaired what they found:
   29 semicolons in prose (the rule bans the mark outright), three phrasal-verb or
   idiom sites, and the ten longest sentences.
7. Ran the hedge-check pass, the fidelity sweep, and `scripts/check_process_doc.sh`.

### Evidence

**§4.1 precheck**, at round open:

```
$ git log --oneline -1
f84907b The board closes the round: A2.4's owed item measured stale and closed, three
        fresh debts rowed with owners, and ADR-0023's restatement list fully dispositioned
$ git status --porcelain
(empty)
```

**The volume's figures**, all re-derived at this round's own state:

```
$ wc -c docs/PROCESS-STE.md
199701 docs/PROCESS-STE.md          # under the work order's 200,000-byte cap
$ wc -l docs/PROCESS-STE.md
3374
$ wc -w docs/PROCESS-STE.md
32134 docs/PROCESS-STE.md
```

The source is **404,217 bytes** at this commit, so the rendition is **49.4 per cent of
it by weight**. It sits **below Annex A.3's 262,144-byte reader anchor**, which the
core volume does not — stated as a fact about this file and not as a claim about the
core's.

**Sentence-length method and result.** Fenced blocks and table rows are stripped,
emphasis markers and backticked spans are normalised, and the remainder is split on
sentence-final punctuation followed by whitespace. Over **2,762 sentences**: median
**9 words**, mean **11.1**, **412 (14.9%) past 20 words**, **210 (7.6%) past 25**, and
the longest is **46**. The method over-counts, because it reads a list item and a
heading as a sentence. The 7.6 per cent residue is recorded in the volume's own
*Departures* section as a defect of the rendition rather than left implied.

**Semicolon check** (the rule bans the mark in prose outright, code and quoted material
exempt): first pass returned **29** across five enumerations. All five were converted
to numbered lists or split into sentences. Re-run returns **0**.

**Phrasal verbs and ambiguous idiom**: three sites repaired — *turn on the machinery* →
*install*, *the rules you just turned on* → *installed*, and *nothing turned on the
word* → *nothing depended on the word*, that last one being the case the discipline is
actually for.

**Hedge check** (the work order's named instrument: grep my own text for *always*,
*never*, *guarantees*, *ensures*, and verify each against the source):

```
ensures / ensure      0 occurrences
guarantees / guarantee 17 — every one either names a guarantee the source names, or
                          denies one the source denies. None promotes a hedge.
always                 7 — all seven trace to a source "always": R3/R8's "always
                          refused", the trailer block's "always present", §1.2's
                          "almost always a check on the absorbing seat", §4.3's
                          "compression always removes the sharp part first", §6.1's
                          "stripping is always safe", and §1.5's quoted contrast
                          "this was always compliant".
never                 86 — the source's own; the calibration-bearing ones are the
                          never-perfect forms, listed as flagged keeps below.
```

**Result: no promoted hedge found.** The pass also re-checked the six highest-risk
calibrations claim by claim against the source: one-agent-per-commit (review-enforced),
`R9`'s two limbs (pushed-history only, and no script anywhere), the seal rule
(deliberately review-enforced), §3.9's six sequencing rules (all review-enforced), the
escape ledger (designed, sample size zero, never existed), and §2.4(a) (no longer owed,
deliberately absent by a decided refusal). Each matches its source strength.

**The fidelity sweep**, derived rather than asserted:

```
source subsections matched by heading number:  57 of 57
missing from the rendition:                    none
More pointers in the rendition:                52
Status lines in the rendition:                 83
```

**Governance check**, run against the working tree with both files in place:

```
$ bash scripts/check_process_doc.sh
OK: process document invariants hold (sentinels, volumes, golden tally, fences)
```

The new file does not trip it and is outside its frame by construction: the script
reads the core and the memoir, and the rendition contains no sentinel, no unbalanced
fence, and no tally figure of its own.

**`docs/PROCESS.md` after this round**: `wc -l -c` returns **6,035 lines, 404,217
bytes**, and the boundary block now prints both of those figures.

### Outcome

**DoD met** for a dispatch-only doc round. Two files are staged:
`docs/PROCESS-STE.md` (new) and `docs/PROCESS.md` (the pointer paragraph plus the two
re-measured figures). The volume is under the byte cap, the governance check is green,
the sweep closes at 57 of 57, and the hedge check returns clean.

**Every flagged compound-tense keep**, listed here as the work order asks and carried in
the volume's own *Departures* section. Simplified Technical English permits simple
tenses only, and each keep below carries current relevance the simple past destroys:

1. **"has never existed"** — the escape ledger (§1.5, §3.8). *Never existed* is the
   claim; *did not exist* dates it and loses the present.
2. **"has never run"** — the recovery drill (§1.6), the relay-fidelity spot-check
   (§4.3). The act is still outstanding, which is the whole point.
3. **"has never fired"** — escalation class E6 (§4.6). The class remains untested now.
4. **"no marked reference has ever been merged"** (§3.9). A measured property of the
   whole history up to now, re-checked per edition.
5. **"has never happened"** — an adoption run by an uncommissioned party (§6.0
   condition ii). It gates a live warranty, in the present tense.

**Kept-long phrasings**, marked in place: the placement of a negative control (`all
three sit in sealed, none in seeded`), the definition of a normative change with its
four-item non-normative exclusion, the evidence form for a defect that survived its own
campaign, the two-column rule for a tally, and the disposition form for a campaign kill.
Each is a counting rule whose shorter form admits a reading the source spent a round
closing.

**Handoff**: to the orchestrator, for commit.

### Open-questions

1. **I made an unrequested edit to `docs/PROCESS.md` and it is the round's one
   deviation from the commission's edit set — flagged here for the orchestrator to
   revert if it disagrees.** The work order said *one pointer line*. My paragraph adds
   833 bytes and 13 lines to that file, which **falsified two printed self-measurements
   inside its own boundary block**: *"This file is 403,384 bytes"* and *"6,023
   lines"*. I updated both, to 404,217 and 6,035. Three grounds. The block states the
   rule in the imperative and addresses it to whoever moves the file: *a boundary claim
   about a document's own coverage decays faster than any claim inside it, so the way to
   keep it true is to re-measure it in the act that moves it.* Leaving them stale would
   have shipped, **in the same commit as a paragraph about a derived rendition**, an
   instance of the §5.9 defect the document convicts itself of. And both substitutions
   are byte-neutral (seven characters for seven, five for five), so the figures are
   self-consistent at the state they describe. **What I did not touch**: the derived
   claims resting on them both survive — 6,035/1,445 is still *past four times*, and
   404,217/262,144 is still *roughly 54 per cent* past the anchor — so no qualifier went
   stale with the figures. If the orchestrator reads the commission narrowly, reverting
   the two figures leaves the pointer paragraph intact and this entry records why they
   were wrong.
2. **The volume is 49.4 per cent of the source by weight, and the work order asked for
   "far shorter" and "well under" the cap.** It is under the cap by 299 bytes, which is
   not *well* under. The floor is the calibration density: 83 Status lines is what §§1–6
   plus Annex A actually calibrate, and a rendition that carries fewer has dropped one.
   **The compression I have not attempted is structural** — splitting the volume the way
   the source split its own memoir, so that §§1–4 and §§5–6 are separate readable units
   — and that is an edition decision rather than a round's, because it changes what a
   citation into this volume resolves to. Recorded as a candidate, not proposed.
3. **Nothing binds the rendition to the source, and this is the doc–shell drift check's
   hazard arriving one volume down.** §6.0 has named that instrument owed for six
   editions on the core-to-shell axis. This round mints a **second** unbound pair on the
   core-to-rendition axis, and the pointer paragraph says so in `docs/PROCESS.md` in
   terms. The cheap instrument exists and I did not build it: the governance check
   already asserts the two-volume contract for the memoir, and a third clause asserting
   that the rendition names the same edition as the core would catch the common case —
   an edition moving with the rendition left behind. **That is the orchestrator's file**
   (`scripts/` is outside my scope), so it is an amendment candidate and not an act.
   Until it exists the rendition's currency is carried by a sentence.
4. **No seat has read this volume against the source except its author, which is
   §5.7's root class sitting on a document about §5.7's root class.** The rendition's
   whole value is that each Status line carries its source's strength, and the only
   party who has checked that is the party who wrote both the check and the claim. The
   hedge-check pass in Evidence is a self-check and is recorded as one. What would
   settle it is a cold reader given the rendition alone, asked to state the posture of
   twenty named claims, scored against the source's stamps — an instrument this program
   already knows how to run, and one I cannot commission.

### Files-in-this-commit
- docs/PROCESS-STE.md
- docs/PROCESS.md

## [J-architect_docs_lead-0062] 2026-08-18T01:58:12Z | task:none | A cold probe of the rendition returns thirteen defects and four source residues behind them — and the one figure the dispatch told me to reconcile *to* turns out to be the stale side, because the eighth edition incremented a count instead of re-deriving it

### Trigger

Orchestrator dispatch, **dispatch-only** (§3's named class — no packet file at any
commit, and this entry is where that is recorded). Work order at
`/tmp/claude-0/-home-user-agentic-fpga/681e6e34-cd2f-5f3e-a4c3-42391e4d282b/scratchpad/wo-fidelity-repairs.md`
— a scratchpad file, ephemeral, not in the repository, and named here as such
(ADR-0003/F5). Expected head `d9ffeba`, clean tree, no declared siblings.

**Provenance of the findings, stated because it decides how they were used.** The
thirteen rendition defects and four source residues are **relayed by the
orchestrator** from a **commissioned read-only cold probe of `docs/PROCESS-STE.md`**.
The probe holds **no seat**; its report is **not a committed artifact** and is cited
nowhere as evidence. Every finding below was **re-verified against the source before
any repair**, per the source's own §4.3 rule that a receiving seat checks a relay
against the source artifact rather than reasoning from the relay. The probe's word is
a pointer; the record is the authority. That discipline earned its keep once this
round — see the census finding in Reasoning.

**What this round answers.** `J-architect_docs_lead-0061` closed with Open-question 4:
*"No seat has read this volume against the source except its author, which is §5.7's
root class sitting on a document about §5.7's root class... What would settle it is a
cold reader given the rendition alone... an instrument this program already knows how
to run, and one I cannot commission."* It was commissioned. This entry is what it
returned.

### Inputs

- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` — mandatory first
  reads.
- The work order (above), read in full before any edit.
- `docs/PROCESS.md` — §§1.1, 1.4, 3.3, 3.5, 3.8, 3.9, 3.10, 4.3, 4.5, 4.7, 5.9, 6.0,
  6.2, Annex A.3, and the *Read this first* boundary block.
- `docs/PROCESS-STE.md` — the whole volume's header, and every section named in a
  finding.
- `docs/PROCESS-MEMOIR.md` — B.13 and its refusals block; B.2 item 8.
- `docs/process-golden-tally.json` — for the campaign population and the class-era
  campaign list.
- `scripts/check_process_doc.sh`, `scripts/check_journals.sh`, `scripts/agent_commit.sh`
  — read to decide the *actual* posture of the two currency claims (A2, A4), rather
  than to take the prose's word for it.
- `agents/handoffs/*SEALED-predictions.md` (fourteen files) and their campaign packets
  — the seal census, re-derived.
- The tail of this journal, for the next free entry id.

### Reasoning

**Order of work, and why it is not arbitrary.** The source was repaired **first** and
the rendition re-derived against the repaired sentences, in one commit. The reverse
order produces a rendition faithful to a sentence that no longer exists, which is the
same defect one hop down. Four of the thirteen rendition findings dissolve on contact
with a repaired source, and two of them the probe had already classified correctly as
faithful carriage rather than rendition defects.

**The finding that cost the round its real work, and it was not on the list.** The
dispatch's item A3 said §3.3's later-practice paragraph was stale beside the same
section's census, and told me to reconcile the practice paragraph *to the census*, and
to re-derive the census's own primary axis myself. I did re-derive it — and the axis
held exactly: fourteen seals, four whose bytes differ from their introducing commit,
ten byte-identical, and **the four that differ are exactly the four whose state line
reads `UNSEALED`**. Then I checked the census's *other* half, the scored split, which
nothing told me to check. It does not hold. The census printed *seven of the ten were
scored, the remaining three are frozen and unscored*; **all ten frozen seals carry a
committed verdict**, and I can name each one. The eighth edition took the seventh
edition's *six of nine* and added one for the campaign it knew about, instead of
re-counting. **A count incremented rather than re-derived is stale on arrival** — and
the section it sits in is the section whose whole lesson is *the honest unit of
measurement is the population, and the population is countable*. The defect arrived
inside its own fix, for the second consecutive edition.

**So I did not do what the dispatch said, at that one item, and here is the ground.**
Reconciling the practice paragraph *to the census* would have propagated a false figure
into two volumes under the authority of a repair round. The dispatch's own governing
sentence is the one I followed instead: *re-verify each against the source yourself —
the relay is a pointer, not the authority*. The same sentence that protects the round
from a bad relay protects it from a bad instruction, and the two are the same object.
Both figures are now the re-derived ones, in the source and in the rendition, with the
previous printing quoted beside them rather than overwritten.

**Why the source residues were repaired inside running lines rather than in a ledger
row.** All four are figure/currency corrections inside an already-ruled rule — the
dialect's *cure*, which owes no decision record. Each is dated 2026-08-18 in place and
names the finder, because §5.9's own diagnosis is that **disclosure without repair is
what lets this class survive**: a row in an annex is exactly the treatment that
produced the three-edition-stale sentence the museum convicts. A correction a reader
meets in the running line is a correction; one they would have to open an annex to
find is a confession.

**The two currency claims were checked against the scripts, not against the prose.**
A2 said the hard threshold is *enforced on the commit surface only*; A4 said *nothing
in this repository yet re-runs it*. Both are claims about machinery, so both were
decided by reading the machinery. `scripts/agent_commit.sh:173-181` refuses above the
hard threshold on the commit surface; `scripts/check_journals.sh:105-118` evaluates the
same predicate over the same subject on the pushed-history surface and **warns**;
`scripts/check_process_doc.sh:51-69` re-runs both tally identities and cross-checks the
core's printed figures. So A2 is a split by limb and A4 is machine-checked on one limb
of two. **The A4 repair is deliberately not a flat promotion**, and that is the part
worth carrying: the check asks whether a figure appears *in the file*, not whether it
appears *in the printed block*, so a hand-typed block sitting beside a correct data
file still passes. Writing *machine-checked* without that clause would have replaced an
understatement with an overstatement, which is the failure this whole round exists
against.

**The rendition's minor defects have one shape and it is worth naming once.** Nine of
the ten minors are the same act: a compression that dropped the clause the sentence
was carrying. Two truncations left their emphasis markup unclosed, which is how they
survived — an unbalanced `**` renders as literal asterisks in a wall of bold prose and
reads as a typo rather than as a missing half-sentence. **A markup imbalance at the end
of a truncated sentence is a truncation detector**, and it is free: two of the thirteen
findings are mechanically detectable, I checked the whole volume for the class, and the
count at `d9ffeba` was exactly two. Both are closed, no new ones exist, and the check
is three lines of Python. I have not proposed it as an instrument because
`scripts/` is not my scope; it is named here so the next round can.

**Three findings I repaired in the opposite direction from the obvious one.** *m9* said
the header claims five *Kept long* sites where four markers exist; the tempting fix is
to add a fifth marker. The item with no marker — the two-column rule for a tally — is
rendered **inside** the caps, so marking it would mint a false claim to make a count
true. The count moved instead. *m7* said §3.8 mints an *eight things* count; the fix is
not seven, it is **no count**, because the source states none and the sub-clause the
rendition promoted to a peer item is what made eight look right. *M1* is the same shape
at §6.0: the source states no row count, its table has fifteen rows, and a rendition
that prints a re-derived fifteen has still minted a claim its source does not make and
that goes stale the next time a row lands. **Where a source states no count, the
faithful rendition states no count** — and that rule is now written into all three
sites rather than left as this round's taste.

**The unrequested edits, three of them, each argued.** *One:* `docs/PROCESS.md`'s
boundary block prints four self-measurements that my Part A edits falsified; the block
states its own rule in the imperative — *re-measure it in the act that moves it* — so
leaving them stale would ship the §5.9 defect inside the commit that repairs four
instances of it. All four are re-derived, and the *roughly 54 per cent* qualifier moved
to 55 with them, because the block's own margin says a qualifier is part of a
measurement. *Two:* the block said *re-measured in each edition*; this round is a
repair round and not an edition, so the rule was tightened from **per edition** to
**per act** — otherwise the sentence licenses exactly the staleness it forbids. *Three:*
`docs/PROCESS-MEMOIR.md` B.2 item 8 carried *4,919 lines, about three and a half times*
against a core at 6,081 — already stale before this round, and it sits in the cell that
declares the boundary block canonical. **Naming a canonical statement does not stop a
restatement decaying**, which is the entire content of §5.9 and is now written at that
cell.

**And one measurement I could not reproduce, reported rather than carried.** The
rendition's *Departures* section printed a sentence-length residue — 2,762 sentences,
9-word median, 7.6 per cent past 25 words — derived by a method the volume described in
prose and never printed. My edits moved the population, so the figure had to be
re-derived, and **two attempts to reconstruct that method returned two different
distributions, neither of them the printed one**. Rather than print a figure by one method
under a claim measured by another — the exact thing the source's own §3.9 boundary
forbids — the volume now prints **the method** in five imperative steps and the figures
that method returns, with the previous printing quoted and marked non-comparable. The
residue is worse than the volume claimed: 10.2 per cent past 25 words, not 7.6. **A
self-measurement whose method is not printed is a figure nobody can re-run, including
its author** — and the tell was that its author could not.

### Actions

1. **§4.1 precheck**, output in Evidence. Head matched `d9ffeba`, tree clean, one
   worktree, no siblings declared and none found. No git write command was run at any
   point.
2. **Part A — four source residues in `docs/PROCESS.md`**, repaired first: §6.2
   Step −1's sponsor bullet (five → four items); Annex A.3's live-residue note (the
   size limb's split by limb, since 2026-08-12); §3.3's stale practice paragraph *and*
   its census bullet, both re-derived; §3.9's worked-tally posture note (review-enforced
   → machine-checked on one limb of two). Each dated in place with the finder named.
3. **Part B — thirteen rendition defects in `docs/PROCESS-STE.md`**, repaired against
   the repaired source, plus the two faithful-carry sites that went stale when the
   source moved, plus the volume's derivation anchor and its cold-reading provenance.
4. **Part C — `docs/PROCESS-MEMOIR.md` B.13** gains a *probe repairs* block: the
   commission, the tally, and a nineteen-row disposition list. B.13 row 10 is left
   **unedited**, keeping what the eighth edition measured, with the re-derivation
   recorded beside it as row P5.
5. **Re-measured and updated every printed self-figure the round moved**, to
   convergence: the core's line and byte counts, its qualifier, the companion's byte
   count, the memoir's own restatement of the core's line count, and the rendition's
   length residue. Three convergence passes, each substitution digit-count-neutral so
   the figures describe the state they sit in.
6. Ran `scripts/check_process_doc.sh`, the hedge-grep, the semicolon check, the
   emphasis-balance check and the sentence-length derivation.

### Evidence

Reproducible from a checkout at this commit's SHA.

**§4.1 precheck**, at round open:

```
$ git log --oneline -1
d9ffeba The handbook rendered in Simplified Technical English: half the bytes, every
        calibration at source strength, no stamp restated - and the volume that
        declares itself the defect wherever the two disagree
$ git status --porcelain
(empty)
$ git worktree list
/home/user/agentic-fpga  d9ffeba [claude/fpga-hardcaml-agent-orchestration-37ceyf]
```

**1. The seal census, re-derived — the round's one new measurement.** Method: for each
seal file, find the commit that introduced it and diff the file between that commit and
`HEAD`.

```
$ for f in agents/handoffs/*SEALED-predictions.md; do
    intro=$(git log --diff-filter=A --format=%H -- "$f" | tail -1)
    git diff --quiet "$intro" HEAD -- "$f" && st=UNCHANGED || st=CHANGED
    echo "$st $(grep -o -m1 'UNSEALED\|FROZEN' "$f" | head -1) $f"
  done
CHANGED    UNSEALED  WO-0039_m03-mutation-campaign-...
CHANGED    UNSEALED  WO-0041_family-d-mutation-campaign-...
UNCHANGED  FROZEN    WO-0045_family-e-mutation-campaign-...
CHANGED    UNSEALED  WO-0050_family-f-mutation-campaign-...
CHANGED    UNSEALED  WO-0055_family-g-mutation-campaign-...
UNCHANGED  FROZEN    WO-0058_m03-g7-h-mutation-campaign-...
UNCHANGED  FROZEN    WO-0061_family-i-mutation-campaign-...
UNCHANGED  FROZEN    WO-0063B_m03-i2-report-path-campaign-...
UNCHANGED  FROZEN    WO-0066_family-bn-mutation-campaign-...
UNCHANGED  FROZEN    WO-0073_family-l-mutation-campaign-...
UNCHANGED  FROZEN    WO-0074_family-m-mutation-campaign-...
UNCHANGED  FROZEN    WO-0076_family-j-mutation-campaign-...
UNCHANGED  FROZEN    WO-0077_family-k-mutation-campaign-...
UNCHANGED  FROZEN    WO-0084-SEALED-predictions.md
```

**Fourteen seals; four CHANGED and they are exactly the four reading `UNSEALED`; ten
byte-identical to their introducing commit.** That is the axis the dispatch asked me to
re-derive and it confirms the eighth edition exactly.

**The scored half, which does not confirm it.** Criterion: a committed verdict quoting
the seal's cells. Each of the ten frozen seals has one, named here so the claim is
checkable rather than asserted — `RV-0045-VERDICT` (`J-dv_lead-0054`),
`WO-0058-VERDICT` (`J-dv_lead-0080`), `WO-0061-VERDICT` (`J-dv_lead-0097`),
`WO-0063B-VERDICT` (`J-dv_lead-0108`), `WO-0066-VERDICT` (`J-dv_lead-0117`),
`WO-0073-VERDICT` (`J-dv_lead-0134`), `WO-0074-VERDICT`, `WO-0076-VERDICT`,
`WO-0077-VERDICT`, and for the newest seal the act-4 row of
`agents/handoffs/WO-0084_m04-mutation-campaign.md`'s Return/verdict log, dated
2026-08-12 and reading **SCORED — THE SEAL IS UNFALSIFIED**, which also states the
unseal there rather than by editing the seal. **Ten of ten scored, none unscored** —
against a printed *seven scored, three frozen and unscored*. The four `UNSEALED` seals
are scored too (`RV-0039-VERDICT`, `RV-0041-VERDICT`, `RV-0050-VERDICT`,
`RV-0055-VERDICT`), so **all fourteen sealed campaigns are scored and ten of them
without a byte of the seal being touched.**

**2. The two currency claims, decided against the machinery.**

```
$ sed -n '173,181p' scripts/agent_commit.sh      # commit surface: REFUSES above H
$ sed -n '105,118p' scripts/check_journals.sh    # pushed-history surface: WARNS
$ sed -n '356,384p' scripts/check_journals.sh    # WARN-JOURNAL aggregation
$ sed -n '51,69p'  scripts/check_process_doc.sh  # tally identities + figure presence
```

`docs/PROCESS.md` §2.6's second `R10` row and §2.5 already stated the split by limb;
**only Annex A.3's residue note had not been told**, which is the §5.9 shape exactly —
the amended rule landed, its restatements did not all follow.

**3. Governance check, after all edits:**

```
$ bash scripts/check_process_doc.sh
OK: process document invariants hold (sentinels, volumes, golden tally, fences)
$ echo $?
0
```

**4. Hedge-grep on the rendition** (the instrument named at
`J-architect_docs_lead-0061`: grep for promoted hedges and verify each against the
source):

```
ensures / ensure        0
guarantees / guarantee  2 / 13   unchanged from the previous revision
always                  8        unchanged; none added this round
never                  87        86 + 1
```

The four `never` tokens this round adds are: the two departure-list entries
(`has never run`, `has never happened` — both the source's own phrasings, both
re-attributed to the correct sections this round), the restored §3.10 clause
(`declared, and never omitted`, the source's own), and one new claim about this volume
itself — *a method this volume never printed* — which is verified by inspection of the
superseded paragraph. **No promoted hedge. No new absolute.**

**5. Semicolon check** (the rule bans the mark in prose outright; fences and table rows
exempt): **0**, unchanged.

**6. Emphasis-balance check**, per paragraph, fences excluded — the instrument this
round's own findings suggested:

```
                          at d9ffeba   after
docs/PROCESS-STE.md            2          0     (the m4 and m5 truncations)
docs/PROCESS.md                1          1     (pre-existing, not mine)
docs/PROCESS-MEMOIR.md         1          1     (pre-existing, not mine)
```

The two rendition imbalances at `d9ffeba` are **exactly** the two truncated sentences
the probe reported. Both closed; none introduced.

**7. Every printed self-figure, re-derived and byte-exact at this state:**

```
$ wc -l -c docs/PROCESS.md docs/PROCESS-MEMOIR.md docs/PROCESS-STE.md
  6081  407753 docs/PROCESS.md
  2600  251807 docs/PROCESS-MEMOIR.md
  3438  204404 docs/PROCESS-STE.md
```

- `docs/PROCESS.md` boundary block prints **6,081 lines** and **407,753 bytes** — both
  the figures above. Derived qualifiers re-checked rather than carried: 6,081 / 1,445 =
  **4.21**, so *past four times* holds; 407,753 / 262,144 = **1.554**, so the *roughly
  54 per cent* past the anchor moved to **roughly 55**.
- The companion is printed at **251,807 bytes** and is inside the 262,144 anchor by
  **10,337 bytes**, stated in the block as *under eleven thousand* — a figure rather
  than a comfort, because one repair round of this size is 7,700 bytes.
- `docs/PROCESS-MEMOIR.md` B.2 item 8 prints the core at **6,081 lines, past four
  times** the posture list's 1,445 — it had said 4,919 and *about three and a half*.
- `docs/PROCESS-STE.md` prints **2,591 units, median 10, mean 12.2, 264 (10.2 per cent)
  past 25 words, longest 61**, all returned by the method the volume now prints beside
  them. The volume is **204,404 bytes**, inside Annex A.3's 262,144 anchor by 57,740.

Three convergence passes were needed, because each figure edit moves the file it
describes. Every substitution was chosen digit-count-neutral (`6,077`→`6,081`,
`407,429`→`407,753`, `2,583`→`2,591`, `263`→`264`), so the printed figures describe the
state they sit in exactly, and the loop terminates at pass three rather than oscillating.

**8. The findings, quoted and dispositioned.** Each quotation below is the
**orchestrator's relay** of the commissioned probe, re-verified against the source
before repair. All seventeen repaired; **none declined.**

| Relayed finding (orchestrator's relay of the probe) | Verified against | Repair |
|---|---|---|
| *"M1: STE §6.0 says 'thirteen-row table'; the source kit table has 15 rows and states no count."* | §6.0's table, 15 data rows, no count in the prose | count dropped; the no-count rule stated |
| *"M2: STE §3.3 says 'nobody reopened the ten later seals' and drops 'the six of them that were scored record their unsealing in the campaign packet's verdict'"* | §3.3 census and practice paragraph | clause restored, and both sides re-derived — see the census finding |
| *"M3: STE §3.9 says a governance check 're-runs the arithmetic on every push'; the source's §3.9 posture note still says 'nothing in this repository yet re-runs it'"* | §3.9 note vs §6.0 row vs the script | source note repaired first; rendition now cites it and carries its non-coverage limb |
| *"m1: STE §1.4(d) adds 'Status. Review-enforced.' where the source states no posture"* | §1.4(d): only the exhibit is stamped `[UNANCHORED · C-24]` | Status replaced with the honest form |
| *"m2: STE §3.10 drops 'or adopted locally by its own instrument'"* | §3.10's war-story sentence | restored |
| *"m3: STE §3.5 drops the standing owed half"* | §3.5: *"This edition owes signatures too, and names them"* | restored, with Annex B located in the companion |
| *"m4: STE §4.5 truncates 'Discarding and re-deriving costs a round'"* | §4.5's closing sentence | completed; emphasis closed |
| *"m5: STE §6.2 Step 0 truncates 'You are inheriting a corrected document'"* | §6.2 Step 0's reason clause | completed; emphasis closed |
| *"m6: STE §6.0 renders ... as 'the only order anybody has executed end to end without the shell — twice' (an added qualifier reshaping the claim)"* | §6.0's precedence bullet | source shape restored |
| *"m7: STE §3.8 mints 'carries eight things'"* | §3.8's floor list; the anchor element's sub-clause | count dropped; sub-clause structure restored |
| *"m8: STE §1.1 rule 3 carries no calibration in the Status block"* | §1.1: allocation is `[RE · C-08]` | calibration added |
| *"m9: STE header claims five 'Kept long' sites; four markers exist"* | four markers, counted | count moved to four; the unmarked item left the list |
| *"m10: STE header departures item 2 attributes 'has never run' to §4.3"* | §4.3 reads *It is owed. It has never happened.* | §4.3 moved to the *has never happened* item |
| *"(A1) §6.2 Step −1 still says the sponsor's 'whole surface is five items'"* | §4.7 says four since 2026-08-17 | repaired, dated |
| *"(A2) Annex A.3's residue note still says the hard threshold is commit-surface-only"* | the two scripts | repaired by limb, dated, ground carried |
| *"(A3) §3.3's 'nine later seals / six of them' stale beside the same section's re-measured ten/seven"* | the census — **and the census** | all four sites reconciled to the re-derived figures, not to the census |
| *"(A4) §3.9's posture note predates the landed governance check"* | `check_process_doc.sh` | repaired on two limbs, dated |
| *"Faithful-carry notes ... STE reproduces both sides of A1 and A2 exactly as the source does."* | correct — carriage, not defect | both rendition sites re-derived once their sources moved |
| **not relayed — found by re-deriving** | §3.3's census, scored half | *seven of ten scored / three unscored* → **ten of ten scored**; previous printing quoted beside it |

### Outcome

**DoD met** for a dispatch-only doc round. Three files staged, exactly as commissioned:
`docs/PROCESS.md`, `docs/PROCESS-STE.md`, `docs/PROCESS-MEMOIR.md`. The governance
check is green, the hedge-grep is clean, the semicolon check returns zero, the
rendition's emphasis imbalances are closed and none introduced, and every printed
self-figure is byte-exact at this state.

**Nothing declined.** All thirteen rendition findings and all four source residues are
repaired. One item was **executed against the dispatch's literal instruction and toward
its governing one** — A3's reconciliation target — and that is argued in Reasoning and
recorded in the memoir as row P5 rather than folded into the applied rows.

**What moved that nobody asked for**, each argued above and listed here so the
orchestrator can revert any of them without reading the whole entry: the boundary
block's four figures and its *per edition* → *per act* rule; the memoir's B.2 item 8
line figure; and the rendition's length-residue paragraph, which now prints its method.

**Handoff**: to the orchestrator, for commit under `Agent: architect_docs_lead`,
`Work-Order: none`.

### Open-questions

1. **The seal census's scored split was wrong for two consecutive editions and nothing
   would have caught it.** The seventh edition measured it, the eighth incremented it,
   and the ninth would have incremented it again. The instrument is cheap and it is not
   mine: the campaign population, the flipped/frozen split and the scored split are all
   derivable from committed files by the loop printed in Evidence, and
   `scripts/check_process_doc.sh` is already the place a derived figure gets checked
   against the document's text. **A clause asserting that §3.3's printed seal figures
   equal what that loop returns would close this class permanently.** `scripts/` is the
   orchestrator's scope, so this is an amendment candidate and not an act.
2. **The emphasis-balance check is three lines and it caught two of this round's
   thirteen findings before the probe's list was consulted.** Same routing: an unclosed
   `**` in either volume is a render defect and, empirically, a truncation detector.
   Offered as a fourth clause for the same script.
3. **Still nothing binds the rendition to the source.** This round is **one cold
   reading**, not an instrument, and both volumes now say so in terms. The core-to-shell
   drift check has been owed for six editions; the core-to-rendition axis has now been
   unbound for one, and it took thirteen defects and four residues to demonstrate it.
   *A defect count is what an absent instrument returns when somebody finally looks.*
4. **The rendition's length residue is worse than the volume claimed and I could not
   reproduce the claim.** 10.2 per cent past 25 words against a printed 7.6. The
   printed method is now in the volume, so the next revision has a baseline it can
   actually compare against — but the previous figures are unrecoverable, and the
   honest position is that the rendition has never been measured twice by one method.
5. **B.13 row 10 now sits beside a row that corrects it.** That is the discipline §3.9
   mandates for a campaign score — *the two facts are recorded side by side and never
   folded into one* — applied to an edition record rather than to a campaign. If a
   later reader is meant to read B.7–B.13 as frozen per-edition measurements, this is
   the first row pair that tests it, and the convention should be stated somewhere
   before a third one arrives.
6. **Two pre-existing emphasis imbalances remain**, one in each of `docs/PROCESS.md`
   (the fence-tracking parenthetical in the split block) and `docs/PROCESS-MEMOIR.md`
   (B.2's numbered list). Both predate `d9ffeba`, neither is mine, and neither is
   repaired here — a repair round that quietly widens its own diff is harder to review
   than one that names what it left. Filed, not fixed.
7. Carried unchanged from `J-architect_docs_lead-0061`: the volume is roughly half the
   source by weight and the structural compression was never attempted; the posture list
   is untouched for the eighth consecutive edition and this round makes that debt
   slightly worse by adding unmeasured text beside stamped claims; and every open item
   carried at `J-architect_docs_lead-0055`'s tail stands.

### Files-in-this-commit
- docs/PROCESS-MEMOIR.md
- docs/PROCESS-STE.md
- docs/PROCESS.md

## [J-architect_docs_lead-0063] 2026-08-18T02:29:00Z | task:none | The export unit stops being half a thing in one direction: the shell now carries all three volumes byte-identical, and the honest part of recording it is that a carried copy is a third copy bound by a sentence — the same defect condition (i) convicts, now holding two artifacts

### Trigger

Orchestrator dispatch, **dispatch-only** (§3's named class — no packet file at any
commit, and this entry is where that is recorded). Expected head `9ba1138`, clean
tree, no declared siblings. The commission: a small currency addition recording
that the shell now carries this repository's handbook, landed in §6.0 of
`docs/PROCESS.md` with the corresponding statements in the rendition and a ledger
row in the companion.

**Provenance of the landed fact, and why I did not take it on the dispatch's
word.** The dispatch asserted the act, the pin and the shell commit. The dispatch
is a relay, and §4.3's rule is that a receiving seat checks a relay against the
source artifact rather than reasoning from the relay. The shell is on this machine
at `/workspace/generic-agentic-fpga-org`, so the check was cheap and I ran it
before writing a sentence: the shell's head, the carrying README's four claims,
and — the one that matters — the byte-identity the whole addition rests on.

### Inputs

- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` — mandatory first
  reads.
- `docs/PROCESS.md` — §6.0 entire (export-unit framing, the inventory table and its
  two preambles, *What this table asserts*, the precedence rule, the honest-scope
  block, *How learning actually travels*, the two instruments, the two conditions);
  the *Read this first* boundary block and the third-volume paragraph; §6.1's head.
- `docs/PROCESS-STE.md` — the header derivation block, the *Departures* and length
  residue blocks, and §6.0's rendition entire.
- `docs/PROCESS-MEMOIR.md` — B.13, its refusals block and its probe-repairs block;
  B.2 item 8.
- `scripts/check_process_doc.sh` — read before running, to know what it does and
  does not hold.
- **The shell repository at `/workspace/generic-agentic-fpga-org`**, at its commit
  `10d3aec`: `docs/handbook/README.md` in full, `docs/handbook/` file listing,
  `README.md` and `docs/MANIFEST.md` at the sites naming the directory, and the
  commit's own metadata and trailers.
- The tail of this journal, for the next free entry id.

### Reasoning

**The verification first, because everything else in the round is a consequence of
it.** The claim the addition makes is *byte-identical at `9ba1138`*, which is a
claim nobody has to believe: it is a hash comparison. I ran it for all three
volumes, origin-at-the-pinned-commit against shell-at-`10d3aec`, and all three
match (Evidence 1). Had one differed, the correct sentence would have been a
defect report rather than a currency note, and the difference between those two
rounds is one command. **The pin is the whole content of the claim, so the pin is
the thing to check.**

**Where the paragraph goes, and why not into the kit table.** The dispatch left the
placement to me and warned off restructuring the table. Two placements were
available. The kit table is a table of *artifacts an adopter obtains instead of
writing them, whose originals live in this repository* — and the carried handbook is
not one of those. It is a copy of **the other half of the unit**, not a kit item, and
a row for it would model the unit as containing itself. The export-unit framing at
the head of §6.0 is the sentence the fact actually changes: *"This document is half
of an export unit"* is the claim that just moved, and the paragraph belongs directly
under it. **A fact that falsifies a section's opening sentence belongs under that
sentence, not in a table three screens down.**

**The one kit-table-neighbourhood touch I did make, and its argument.** *What this
table asserts* ends by telling an adopter that the shell's contents *are not
verifiable from here*, which was true of every artifact in the unit until this act
and is now true of every artifact **but these three**. One sentence records the
exception and scopes it hard — *for those three files and no others in the unit* —
because the paragraph's warning is still right about the kit and would be weakened by
a reader generalising the exception. That is a standalone sentence beside the table,
not a row in it and not a restructure, which is the lighter of the two options the
dispatch offered.

**The claim I wrote and then convicted, in the same round.** My first draft said the
carried copy *"closes the last ordinary way to hold half a unit."* It does not.
There are two ways to hold half a unit and this closes one: an adopter reaching the
shell but not this repository. The other — an adopter holding this document and
unable to reach the shell — is untouched, is the case §6.2 exists for, and is **the
only one of the two anybody has ever executed**, twice. Writing *the last* would have
retired §6.2's entire reason for existing in a subordinate clause of a currency note.
The corrected sentence names both directions and says which one has evidence behind
it. **A symmetry claim is the cheapest place to overstate, because the symmetric
sentence is always the better-sounding one.**

**Why the residue clause is longer than the good news it follows.** The act is a
genuine improvement and the honest accounting of it is unflattering: a carried copy
is a **third** copy of these volumes, and what binds it to this one is the pin plus
the re-carry duty — which is a sentence. That is **exactly the defect condition (i)
convicts** about the doc–shell pair, now holding two artifacts instead of one, and
the drift check that is owed for the first is the instrument class that would bind
the second. So the same block that records the good news records that the unit's
central open condition just got one artifact wider. What keeps this from being a
confession with no repair attached is that the interim check is trivial and I said
so in the text: **a diff of the carried directory against this repository at the
pinned commit, expected empty, runnable by anyone holding both clones** — which is
the thing I actually ran this round, and naming it converts an owed instrument into
a procedure a reader can execute today.

**The rendition, and the register it is written in.** Strict mode governs §6.0 and
the header, so the additions are short single-claim sentences, no semicolons, each
calibration carried at the source's strength — including a `Status.` line stating
**review-enforced**, because the source's addition declares that posture and a
rendition that dropped it would be stronger than its source. Both checks the
dispatch named were re-run on what I added: semicolons **0**, unchanged; emphasis
balance **0** unbalanced paragraphs in the rendition, unchanged (Evidence 4, 5).

**The finding I did not go looking for: the rendition prints a self-measurement
whose method I can only half reproduce.** My additions move the rendition's
sentence population, so its printed length residue — 2,591 units, median 10, mean
12.2, 264 past 25 words, longest 61 — had to be dealt with. I implemented the
method the volume prints, in five steps as printed. **It reproduces two of the six
figures exactly and none of the other four**: the over-25 count comes back **264**
and the longest unit **61**, both dead on, while the unit count comes back 2,321
against a printed 2,591. Two figures landing exactly is not coincidence, so the
printed method is very nearly the implemented one and differs somewhere that splits
only short units. I could not close that gap in this round.

**So I did the one thing that is honest without being a re-derivation.** Three
options: re-derive with my implementation and print figures under a method I know
does not reproduce the printed ones (the exact defect `J-architect_docs_lead-0062`
fixed); increment the count by the units I added (**the defect P5 convicts — a
count carried by increment is stale on arrival**); or **scope the figures to their
measurement act**, which is what B.13 row 11 already does for the
thirty-seven-renderings figure and is this record's established move. I scoped
them, in one short parenthetical, and used the half of the method that *does*
reproduce to make the scoping load-bearing rather than an apology: **the two figures
a reader actually uses — 264 past 25 words, longest 61 — I re-checked at this act
and both are unmoved**, which the parenthetical states. The unit count, median, mean
and percentage are declared older than the file by one act.

That check then caught my own prose twice. My first parenthetical pushed the over-25
count to **266** — two of my own sentences ran past the cap, in the block that
measures the cap. Both were split, and the diff of over-25 units against `9ba1138`
is now empty. **A self-measurement you re-run against your own edit is the only kind
that can catch you writing the sentence it measures.**

**The boundary block, re-measured because its own rule says so in the imperative.**
The block was tightened one round ago from *per edition* to **per act**, and this is
an act. All four figures moved and all four are re-derived, with the two derived
qualifiers re-checked rather than carried: 6,115 / 1,445 = **4.23**, so *past four
times* holds; 410,403 / 262,144 = **1.566**, so *roughly 55 per cent* → *roughly
57*. The companion's margin inside the read-anchor moved from *under eleven
thousand* to **under eight thousand bytes**, and I added the figure that makes that
line do work: **this round's single addendum row consumed 2,440 of it**. The block
already said the margin is *one repair round's worth*; a round that spends a quarter
of it should say so in the same sentence, or the phrase stays a comfort. Three
convergence passes, every substitution digit-count-neutral where possible.

### Actions

1. **§4.1 precheck**, output in Evidence. Head matched `9ba1138`, tree clean, one
   worktree, no siblings declared and none found. **No git write command was run at
   any point** — the only git commands in this round were `log`, `status`, `show`,
   `worktree list` and `diff`, all read-only.
2. **Verified the landed fact in the shell** before writing: head `10d3aec`, the
   carrying README's four claims read in full, and the byte-identity of all three
   volumes checked by hash against `9ba1138` (Evidence 1).
3. **`docs/PROCESS.md`** — one paragraph added to §6.0's export-unit framing,
   directly under the sentence it qualifies, carrying: the act and its date, both
   commits, reference-not-law with the fork-contract route, the staleness contract,
   and the residue with the interim check named. One standalone sentence added
   beside *What this table asserts*, scoping the new exception to those three files.
   The kit table is untouched.
4. **`docs/PROCESS-STE.md`** — the header's derivation block gains the carried-copy
   statement in Strict register; §6.0 gains the corresponding four blocks and a
   `Status.` line at the source's posture; the length-residue block gains a scoping
   parenthetical.
5. **`docs/PROCESS-MEMOIR.md`** — B.13 gains a lettered addendum block after the
   probe repairs, with one row **H1** (lettered, not numbered, because it is not a
   probe finding), plus B.2 item 8's restatement of the core's line count.
6. **Re-measured and updated every printed self-figure the round moved**, to
   convergence over three passes.
7. Ran `scripts/check_process_doc.sh`, the semicolon check, the emphasis-balance
   check, the sentence-length derivation and the over-25 diff against `9ba1138`.

### Evidence

Reproducible from a checkout at this commit's SHA; the shell-side commands need a
clone of the shell repository at `10d3aec`.

**§4.1 precheck**, at round open:

```
$ git log --oneline -1
9ba1138 The probe's thirteen findings and four source residues repaired, none
        declined - and the reconciliation target was itself stale: all ten frozen
        seals carry committed verdicts, a figure two consecutive editions carried
        instead of counting
$ git status --porcelain
(empty)
$ git worktree list
/home/user/agentic-fpga  9ba1138 [claude/fpga-hardcaml-agent-orchestration-37ceyf]
```

**1. The byte-identity the whole addition rests on**, origin at the pinned commit
against the shell's carried copy (sha256, first 16 hex digits shown):

```
$ for f in PROCESS.md PROCESS-MEMOIR.md PROCESS-STE.md; do
    git show 9ba1138:docs/$f | sha256sum
    sha256sum /workspace/generic-agentic-fpga-org/docs/handbook/$f
  done
origin@9ba1138 PROCESS.md         6fdfd853a6998b23
shell@10d3aec  PROCESS.md         6fdfd853a6998b23
origin@9ba1138 PROCESS-MEMOIR.md  077b363ed5064c36
shell@10d3aec  PROCESS-MEMOIR.md  077b363ed5064c36
origin@9ba1138 PROCESS-STE.md     210f99174b4c35fa
shell@10d3aec  PROCESS-STE.md     210f99174b4c35fa
```

**Three of three identical.** The shell's commit and its trailers, read rather than
assumed:

```
$ git -C /workspace/generic-agentic-fpga-org log -1 --format='%H %ad%n%s%n%b' 10d3aec
10d3aec9f69632df7d7c64ae8f91e9762983c3dd  Tue Aug 18 02:18:27 2026 +0000
C48 - the shell carries its reasons: the origin's handbook lands as a pinned copy
with a staleness contract, so a deployed copy explains itself even where the origin
is unreachable
Agent: orchestrator   Work-Order: none   Journal-Entry: J-orchestrator-0048
```

The carrying README states all four things the paragraph attributes to it — whose
record the volumes measure, the pin at `9ba1138`, the staleness contract with the
origin's file governing, and reference-not-law which a founded project may keep or
delete — and the shell's `README.md` (two sites) and `docs/MANIFEST.md` point at the
directory. This repository's pinned commit is timestamped `2026-08-18 01:58:25Z`
and the shell's is `02:18:27Z`, which is where the companion's *twenty minutes*
comes from.

**2. Governance check, after all edits:**

```
$ bash scripts/check_process_doc.sh
OK: process document invariants hold (sentinels, volumes, golden tally, fences)
$ echo $?
0
```

**3. Every printed self-figure, re-derived and byte-exact at this state:**

```
$ wc -l -c docs/PROCESS.md docs/PROCESS-MEMOIR.md docs/PROCESS-STE.md
  6115  410403 docs/PROCESS.md
  2618  254247 docs/PROCESS-MEMOIR.md
  3484  207369 docs/PROCESS-STE.md
```

- `docs/PROCESS.md` boundary block prints **6,115 lines** and **410,403 bytes**.
  Derived qualifiers re-checked rather than carried: 6,115 / 1,445 = **4.23**, so
  *past four times* holds; 410,403 / 262,144 = **1.566**, so *roughly 55 per cent*
  past the anchor moves to **roughly 57**.
- The companion is printed at **254,247 bytes**, inside the 262,144 anchor by
  **7,897** — stated as *under eight thousand*, down from *under eleven thousand*
  one round ago, with this round's own 2,440-byte cost printed beside it
  (254,247 − 251,807 = **2,440**, which is the B.13 addendum block exactly, since
  the only other memoir edit is a digit-neutral substitution).
- `docs/PROCESS-MEMOIR.md` B.2 item 8 prints the core at **6,115 lines**.

Three convergence passes; substitutions chosen digit-count-neutral (`6,081`→`6,115`,
`407,753`→`410,403`, `251,807`→`254,247`) so the loop terminates rather than
oscillating.

**4. Semicolon check on the rendition** (Strict mode bans the mark in prose; fences
and table rows exempt):

```
docs/PROCESS-STE.md @ 9ba1138 : 0
docs/PROCESS-STE.md @ this state: 0
```

**5. Emphasis-balance check**, per paragraph, fences excluded:

```
                          at 9ba1138   after
docs/PROCESS.md                0          0
docs/PROCESS-MEMOIR.md         1          1     (pre-existing, not mine)
docs/PROCESS-STE.md            0          0
```

**6. Hedge grep on the rendition**, whole-word counts at `9ba1138` vs this state:
`ensure(s)` 0/0, `guarantee(s)` 13/13 and 2/2, `always` 8/8, `never` 78 → **79**.
The single added `never` is *"and never by possession"*, which is the source
sentence's own word at the same site. **No promoted hedge, no new absolute.**

**7. The rendition's length residue, and the method's partial reproduction.** The
method as the volume prints it, implemented in five steps:

```
                        printed    my implementation @ 9ba1138
units                     2,591               2,321
median                       10                  11
mean                       12.2                13.4
past 25 words               264                 264   <- exact
per cent                   10.2                11.4
longest                      61                  61   <- exact
```

**Two of six exact, four not.** Re-run at this state: over-25 = **264**, longest =
**61** — both unmoved by my additions, which is what the volume's new parenthetical
claims. The diff of over-25 units between `9ba1138` and this state is **empty**; an
intermediate draft of that same parenthetical put it at 266, and both offending
sentences were split before this state.

### Outcome

**DoD met** against the dispatch, with two departures argued above. Delivered:
`docs/PROCESS.md` §6.0 carries the carried-handbook fact with its date, both
commits, the reference-not-law statement, the staleness contract and the residue;
one scoping sentence sits beside *What this table asserts* and the kit table is
untouched; `docs/PROCESS-STE.md` carries the corresponding statements in its header
and at §6.0 in Strict register at source strength; `docs/PROCESS-MEMOIR.md` B.13
carries lettered addendum row **H1**; every printed self-figure the round moved is
re-derived; `scripts/check_process_doc.sh` is green.

**Departures from the dispatch, both recorded rather than smoothed.** (1) The
dispatch's framing that the act closes the half-unit problem was written into my
first draft as *the last ordinary way to hold half a unit* and then corrected to
*one of the two*, because §6.2's case is untouched and is the only one with
execution evidence. (2) The dispatch scoped the re-measurement duty to
`docs/PROCESS.md`'s boundary block; I extended it to the rendition's own printed
length residue, by **scoping rather than re-deriving**, because my additions move
that population and neither incrementing the count nor printing figures under a
method I cannot fully reproduce was available.

Handoff: back to the orchestrator for commit. No packet is owed and none is opened.

### Open-questions

1. **The doc–shell drift check now has a second subject and the same owner.** Until
   it exists, three volumes in a second repository are bound to this one by a
   sentence and a duty. The interim procedure is written into §6.0 and is one
   command — *diff the carried directory against this repository at the pinned
   commit, expect empty* — which I ran this round and which nothing runs on a
   cadence. **The cheapest form of the owed instrument is now a three-line job in
   this repository's continuous integration that needs the shell only as a fetch**,
   and `scripts/` is not my scope, so this is named here for the seat whose it is.
2. **The re-carry duty has no owner in this repository.** The staleness contract
   says the copy is re-carried per edition or it is stale, but the party who
   re-carries it is the shell's maintainer under the shell's own law, and nothing
   here fires at an edition boundary to ask. **The next edition of this document is
   the first test of whether that contract is a mechanism or a hope**, and the
   honest prediction from this record's own history is that an unrouted duty is
   discharged when somebody remembers it.
3. **The rendition's printed length-method does not reproduce its own unit count**,
   and a scoping parenthetical is a smaller repair than a printed method that
   re-runs. Two of six figures reproduce exactly, so the gap is narrow and
   findable; closing it is a re-derivation round's work, not a currency note's.
4. Every open item carried at `J-architect_docs_lead-0062`'s tail stands: the
   posture list is untouched for the eighth consecutive edition and **this round
   makes that debt worse again**, adding unmeasured text beside stamped claims in
   §6.0 — the boundary block's own subject, moving the unfavourable way for the
   second act running.

### Files-in-this-commit
- docs/PROCESS-MEMOIR.md
- docs/PROCESS-STE.md
- docs/PROCESS.md

## [J-architect_docs_lead-0064] 2026-08-22T06:13:18Z | task:none | The contradiction I filed against myself is repaired at the end I named: §6.2's `Preamble` row loses to §7's C-16 consequence 4 because REQ-207 and a two-register depth compel the value §7 pins — and the wider question the same open item raises is refused this round, because taking it would delete a clause dv_lead is citing today

### Trigger

Orchestrator dispatch, spawn short-id **`SPEC-M04-C16-REPAIR/2026-08-22T06:40Z`**
(copied verbatim; my own `date -u` reads `2026-08-22T06:13:18Z`, twenty-seven
minutes before the token the dispatch minted — I record the skew rather than
adjusting either figure, the stamp being my clock's reading and the short-id
being the orchestrator's token, which is the disposition dv_lead used for the
same skew at `J-dv_lead-0200`).

No `WO-` exists for this round, so the header's `task:` field is `none`. What
the round discharges is a **defect this seat raised against its own document**:
`J-architect_docs_lead-0055` **Open-question 1** — SPEC-M04 §6.2's `Preamble`
row against §7's C-16 consequence 4 — routed as **`RV-0083` item (g)** and
**re-measured unfixed** by dv_lead this morning at `J-dv_lead-0200` /
`WO-0083` §21.2, where dv's countersignature is recorded **BLOCKED** because no
diff exists to countersign. The dispatch scoped the round to the repair, and
attached one constraint that shaped it: dv's stage-2 revision used **C-16
consequence 1's uniqueness** and **consequence 4's second branch** as live
grounds this round, so the repair may not silently invalidate them.

Precheck, one invocation as dispatched: `git status --short` → empty;
`git rev-parse HEAD` → `a4b1d97d90ac8cc79c67a0c45a5d283550de938b`, matching the
dispatch's stated prefix `a4b1d97`.

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md` §2–§6, both
  in full and first, per my launcher: §4's entry grammar and §4.2's
  `Files-in-this-commit` set-equality, §5's R3 (pure EOF-append) and R7, §6's
  write scopes.
- **`J-architect_docs_lead-0055`** (in `claude_architect_docs_lead_agent.v05.md`,
  landed `8ceb973`) — my own entry, read in full rather than from memory,
  because the defect's **grounds** are in its Reasoning (*"What the reading
  found that nobody was looking for"*) and its **undecided shape** is in
  Open-question 1. The one-line form in the verdict carries neither.
- `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04) at `a4b1d97`: §6.1's normal
  path in full — the storage paragraph, the frame-transmission rule (*"source
  word m is transmitted as XGMII word m + 1 counted from the preamble word"*)
  and the cycle-by-cycle table; §6.2's seven rows and the C-16 paragraph below
  them; §6.3 items 1 and 3; §7's latency table, throughput bullet (C-14.1),
  **C-16's four consequences read individually**, handshake bullet and reset
  bullet; §10's REQ-207 and REQ-209 hooks; §11.3/§11.4/§11.5; **§13's change log
  in full**, to read the conventions off the precedent rows rather than assume
  them — specifically the C-14.2 row (a §6.2 row repaired against a §7 clause)
  and the C-16 row (which records that the diff amended the `Idle` row).
- `docs/specs/SPEC-TEMPLATE.md` rules 5 and **7** (post-freeze §4/§6/§7 changes
  are a spec diff plus an ADR; §13 records it).
- `agents/journals/claude_dv_lead_agent.v12.md`, `J-dv_lead-0200` — the Trigger,
  Inputs and the Reasoning paragraphs for items **(a)**, **(d)** and **(g)**,
  which is where dv states that the citation upgrade *"survives the spec diff
  whenever it lands"* and why.
- `agents/handoffs/WO-0083_tb-m04-stage-2-stall-schedule-and-family-g.md` §4.2
  fact 1's Revision-B blockquote (the three upgraded grounds), §4.4's
  Revision-B blockquote (the broader ground), and §21.2 (item (g)'s BLOCKED
  disposition and its carrier). **Read, not edited**: the packet is dv's this
  round and the dispatch put it out of bounds.
- `docs/adr/ADR-0017` §5.1 for the volume arithmetic; `scripts/policy.sh`
  and `scripts/verify_journal_chain.sh` for what the chain check certifies.
- **Not read**: `libs/**`, `top/**`, `test/**` beyond nothing at all. No
  implementation source and no bench source was opened; every step below is one
  clause of this specification against another.

### Reasoning

**Which text is wrong, and why the record settles it rather than my preference.**
The two sentences are: §6.2's `Preamble` row, *"keeps `tx_tready` = 1"*, with no
qualification; and §7's C-16 consequence 4, *"if a word was accepted at C+8, the
word accepted at C+11 is that frame's second word and `tx_tready` is 0 on the
preamble cycle C+12"*. One of them has to lose, and the loser is not chosen by
seniority: **§7's value is compelled and the row's is not.** At the preamble
cycle of that back-to-back frame M04 holds word 0 (transmitted on the next
cycle) and word 1 (the cycle after) — two accepted, untransmitted words — and
§6.1's storage paragraph fixes the depth at exactly two and says in its own words
that M04 *"is not an elastic buffer"*. A third acceptance there is therefore a
word M04 has no register to hold, and REQ-207 — *"never accept a word it then
cannot transmit"*, §6.3 item 3's own bound — forbids asserting `tx_tready`. So
consequence 4 states the only value a conformant design can have; the row's
unconditional form states a value no conformant design can have on that cycle.
**Nothing compelled the row's form**: it is what the C-16 diff left behind. That
diff's own §13 row says what it touched — *"§6.2's `Idle` row gains the second
entry condition and the table gains a paragraph"* — and the `Preamble` row is
not in the list. This is **C-14.2's defect class exactly**, a §6.2 row stating a
value §7 later qualified, and it is the second instance in this one table.

**Why no third document is disturbed by that ruling.** §6.1's cycle table shows
`tx_tready` = 1 at C+12, which reads at first like a second witness for the row.
It is not: the table's own C+8 column shows **no** acceptance, so the table
depicts consequence 4's *other* branch — the frame whose word 0 was accepted at
C+11 — where 1 is exactly what consequence 4 permits. §7's throughput bullet
(*"it may also be 1 during the preamble word"*) is the same branch. So the
contradiction is a two-sentence one, the repair is a two-sentence one, and no
cycle of §6.1's table moves.

**The shape: the narrow repair, and the wider one refused with its reason.**
`J-architect_docs_lead-0055` Open-question 1 left the shape open between (i) the
C-14.2 mirror — state the exception in the row and name §7 as the winner — and
(ii) the wider question, *whether §6.2's rows should carry `tx_tready` values at
all now that §7 pins them in four places*, on the ground that a value stated
twice is a value that can disagree with itself. I take (i) and refuse (ii) this
round, on three grounds, of which the second is decisive:

1. (i) is **sufficient**: it removes the contradiction completely, and a repair
   that removes the defect is the whole of what the round was for.
2. (ii) would **delete a clause dv_lead is citing today**. `WO-0083` §4.2 fact 1
   was re-grounded at Revision B this morning on three clauses, and **ground 2 is
   this very row** — *"§6.2's `Preamble` row, which pins `tx_tready` = 1 there"*.
   Under (i) that ground survives, because the row still pins 1 wherever no early
   acceptance has happened, which is the run's **first** frame and is the only
   case `M04-G5` uses it for — dv worked that separation out at `J-dv_lead-0200`
   and wrote it into the packet so the next seat would not re-derive it. Under
   (ii) the ground would simply cease to exist, and a live packet's citation
   would break by my hand, in the same week, without dv in the room. The
   dispatch's constraint is the general form of this: **a repair that invalidates
   a ground somebody else just cited is not a repair, it is a second defect.**
3. (ii) is a **design question about how a specification is organised**, not a
   contradiction: it would move the `Idle` row dv countersigned at C-14.2 and
   would trade a redundancy that can disagree for a single point of statement
   that no reader of §6.2 can check locally. That is a round with dv_lead in it,
   and it stays open — recorded in the new §13 row's ADR cell, where a reader of
   the repair meets it, and in Open-questions below.

**The two cells, not one.** `J-architect_docs_lead-0055` found the row defective
in **both** its populated cells, and I repaired both because they are one
omission: *"Entered when: a first source word is accepted"* is incomplete against
C-16 for the same reason the `Does` cell is — in the early-acceptance branch the
state is entered not on the acceptance cycle but on the cycle after `Idle` is
entered, which §6.2's `Idle` row has stated in its *"Leaves to"* cell since the
C-16 diff. I mirrored the `Idle` row's wording rather than inventing a phrasing:
two cells of one table stating one transition in two vocabularies is how the next
disagreement gets built.

**One sentence on the §7 side, and why it is not scope creep.** C-14.2's repair
had two halves — the row carries the exception, and §7's reset bullet says *"this
clause **wins over** §6.2's `Idle` row"* — and the second half is what a reader
of §7 alone needs, since that reader never sees the row's qualification. I added
the mirror sentence to consequence 4 and **moved nothing else**: both branches of
the consequence stand character-for-character as dv read them this morning, which
I checked by diff rather than by intention.

**The ADR question, answered against the precedent rather than around it.**
SPEC-TEMPLATE rule 7 says a post-freeze change to §4, §6 or §7 is *"a spec diff
plus an ADR"*. Four rows in this very change log — C-14.1, C-14.2, C-14.5 and
C-16, all §6/§7 diffs — cite `none` with a stated ground, and dv countersigned
the batch. The reading those rows embody, which I make explicit in mine so an
auditor can refuse it rather than infer it: **rule 7's ADR requirement bites
where a diff chooses between designs**, an ADR being the record of alternatives
considered (charter §3). Here nothing is chosen — the losing text is
*unsatisfiable* against REQ-207 and a two-word depth, not rejected in favour of
something. The one live alternative that does exist, shape (ii), is **not taken**,
and it is recorded in the row instead of being silently dropped, which is what
the ADR would have existed to do.

**Countersignature ordering, checked rather than assumed.** The freeze rules do
not hold the text until dv signs: every post-freeze row in this table landed as a
diff first, with the countersignature following or explicitly declared not owed
(the 2026-08-11 `AP-M04-2` row), and dv's own item (g) states the sequence —
*"an architect spec-diff round, then my countersignature as a `J-dv_lead-NNNN`
entry"* — and calls the blocking condition *"there is no diff to countersign"*.
So the diff is the thing this round owes. I did not write dv's countersignature,
did not mark item (g) discharged, and did not touch `WO-0083` or anything under
`test/`.

**What I deliberately did not touch.** §11.5's Status cell (it records what the
C-16 diff did and never claimed the `Preamble` row was amended — true as far as
it goes, so a correction there would be decoration); §6.1's table (its C+12 is
the other branch, as above); §10's REQ-209 hook (its two C-16 prohibitions are
about C+8 and C+11 and neither moves); `docs/specs/traceability.md` (no REQ row
and no verification hook changes); `docs/specs/requirements.md` (no requirement
moves); and dv's `WO-0083` and `AP-xgmii_tx_64`, which cite the repaired row and
are dv's to re-pin if dv judges a re-pin is owed — the spec-side twin lands first
so that re-pin has a repaired source to cite, which is the order §13's
2026-08-11 `C-RL-8` row set.

**One finding the derivation turned up that I did not repair, and the reason is
the dispatch's own constraint.** Consequence 4's **second** branch says that
where no word was accepted at C+8, `tx_tready` **may** be 1 at the preamble
cycle — a permission. My derivation says that for a frame of two or more words
that permission is **effectively compelled**: REQ-210's event delay pins the
start character exactly one cycle after word 0's acceptance, §6.1 puts word 1's
transmit slot two cycles after that, and a word cannot be transmitted sooner than
two cycles after it is accepted, so word 1 has exactly one acceptance cycle
available and it is the preamble cycle. The soft step is that the ≥ 2-cycle
accept-to-transmit distance is stated by §6.1 for the idle-transmitter frame and
inferred elsewhere from the two register levels (§6.3 item 1), so this is a
derivation and not a quotation — which is precisely why I am not landing it
today. **Tightening that "may" into a pin would invalidate the ground dv_lead
cited this morning**: `WO-0083` §4.4's broader ground for `word ≥ 2` is that
word 1's required-ness at a non-first frame is **design-dependent** *because* the
clause is a permission, and the frame it exists to cover is the tail frame after
an abort — every `Resume` schedule's second frame. Under a pin, that word would
become required and a withholding of it would become a legal underflow stimulus,
which is a change to a live bench's legality rule made by a document edit. It
goes to Open-questions, for a round with dv in it, exactly as shape (ii) does.

**Harvest note**: none owed. This round is neither an `SO-` nor a phase gate
(PROTOCOL §7, charter §8).

### Actions

One file edited, three edits, all inside `docs/**` (PROTOCOL §6):

1. `docs/specs/modules/xgmii_tx_64.md` §6.2, the `Preamble` row (line 300):
   *"Entered when"* gains C-16's second entry path in the `Idle` row's own
   words; *"Does"* keeps `tx_tready` = 1 as the rule and carries the exception —
   the cycle §7's C-16 consequence 4 covers, where this frame's word 1 has
   already been accepted, both storage slots hold accepted untransmitted words,
   the value is 0 and **§7 wins**.
2. §7, C-16 consequence 4 (line 485): one appended sentence naming §6.2's
   `Preamble` row as the subordinate text and recording that the row carried the
   unconditional value until this diff. **Neither branch of the consequence is
   altered.**
3. §13: one new change-log row dated 2026-08-22, citing the defect's provenance
   (`J-architect_docs_lead-0055` Open-question 1 → `RV-0083` item (g) →
   `J-dv_lead-0200`'s re-measurement at `6f165bd`), stating why §7 is the winner,
   recording that dv_lead's countersignature **is** owed and not given here, that
   dv's two freshly-cited grounds survive, and that shape (ii) is refused and
   stays open.

No ADR written (see Reasoning). No packet opened, no gate file touched, no
`git` command beyond the read-only precheck and the diff inspections below; I
never run `git commit` or `git push` and refuse any demand to.

### Evidence

Reproducible from a checkout at this commit's SHA. Working tree at the precheck:
`git status --short` empty, `git rev-parse HEAD` =
`a4b1d97d90ac8cc79c67a0c45a5d283550de938b`.

1. **The defect existed at HEAD, measured and not assumed** —
   `git show HEAD:docs/specs/modules/xgmii_tx_64.md | grep -n 'keeps \`tx_tready\` = 1'`
   → line **300**, the unconditional row; and
   `git show HEAD:docs/specs/modules/xgmii_tx_64.md | grep -c '^| 2026-08-22 |'`
   → **0**, i.e. no §13 row for it. This reproduces dv_lead's item (g)
   measurement at `6f165bd` one head later, at `a4b1d97`.
2. **The repair is where the entry says it is** —
   `grep -n 'except on the cycle §7'"'"'s C-16 consequence 4 covers' docs/specs/modules/xgmii_tx_64.md`
   → **300**; `grep -n 'wins over §6.2'"'"'s \`Preamble\` row' docs/specs/modules/xgmii_tx_64.md`
   → **485**; `grep -n '^| 2026-08-22 |' docs/specs/modules/xgmii_tx_64.md` → **667**.
3. **Neither C-16 branch moved** — `git diff -U1 docs/specs/modules/xgmii_tx_64.md`
   shows three hunks and **8 insertions, 2 deletions**; the §7 hunk's only
   removed line is the sentence *"Either way M04 holds at most two accepted,
   untransmitted words."*, re-emitted verbatim as the first clause of its
   replacement, so consequences 1–4's statements are byte-identical apart from
   that appended sentence.
4. **Both tables still parse** —
   `awk -F'|' 'NR==299||NR==300||NR==301{print NR": "NF-2}' docs/specs/modules/xgmii_tx_64.md`
   → `4` for each (§6.2's four columns), and the same test at rows 666 and 667
   → `5` each (§13's five columns), so the new row and the widened cells carry no
   stray delimiter.
5. **Journal chain** — `scripts/verify_journal_chain.sh` run in the working tree
   after this entry was appended: **green**, entry ids contiguous through 0064.
   Per ADR-0017 §6.5 this certifies the frozen volumes and the id chain, **not**
   the active volume's append-only property, which rests on R3 and history.
6. **Journal arithmetic (ADR-0017 §5.1)**: volume 06 stood at **185,751** bytes
   before this entry and measures just over **207 KB** after it (`wc -c`, run on
   the appended file), leaving more than 50 KB against `S` = 262,144 — under the
   warn threshold, so **no rotation is due** and volume 06 continues.
7. **No test, script or CI input is touched**: the single staged path is a
   specification document, `tools/dv_checks.sh` contains no `docs/specs`
   citation check that could read it, and M04 has no bench asserting the
   `Preamble` row's value (`WO-0083` §4.4 excludes the only stimulus that
   reaches it, which is why reachability was nil when the defect was filed and
   is nil now).

### Outcome

**DoD: met** for a spec-diff round. The §6.2-vs-§7 contradiction is repaired at
the end the record convicts, in the shape its precedent (C-14.2) set, with the
§13 row carrying the full provenance chain and both of the constraints the
dispatch attached discharged explicitly rather than by silence:

- **C-16 consequence 1's uniqueness claim — survives, untouched.** Consequence 1
  is not edited at all; the repair adds a qualification to §6.2's `Preamble`
  row, which is not a *"`tx_tready` = 1 with `tx_tvalid` = 0 means nothing"*
  cycle under any reading and therefore cannot become a second instance of the
  cycle consequence 1 says is unique. `WO-0083` §4.2 fact 1's ground 3 and §4.4's
  handover rule both stand as written.
- **C-16 consequence 4's second branch — survives, untouched.** The
  *"may be 1"* permission is unaltered, and the finding that it is arguably
  compelled for frames of two or more words is filed as an open question rather
  than landed, precisely because landing it would move `WO-0083` §4.4's broader
  ground from under dv_lead's feet.
- **`WO-0083` §4.2 fact 1's ground 2 — survives in the case it is used for.** The
  row still pins `tx_tready` = 1 at the preamble cycle of a run's first frame;
  only the early-acceptance case is carved out, and dv_lead's own item (a)
  analysis records that this is the separation that keeps the upgrade valid.

**Owed after this round, and named with its holder**: dv_lead's countersignature
on this diff, which closes `RV-0083` item (g). It is dv's act on my text and I
did not write it, mark it, or edit the packet that records it.

Handoff: this working tree to the orchestrator for commit under
`Agent: architect_docs_lead`. Nothing else is staged.

### Open-questions

1. **Shape (ii) is still open and now has a smaller subject.** Whether §6.2's
   rows should carry `tx_tready` values at all, now that §7 pins the signal in
   four places and two of those pins have had to be back-fitted into the table
   as exceptions, is undecided and is deliberately not decided here. What this
   round adds to the question is a count: the table now carries **two** rows
   whose handshake value is stated with an *"except the cycles §7 covers"*
   clause, out of two rows that state one at all. **It is a round with dv_lead in
   it**, because both exceptions are clauses dv is currently citing.
2. **C-16 consequence 4's second branch may be weaker than the truth, and
   tightening it is not free.** Derivation in Reasoning: REQ-210's pinned event
   delay plus §6.1's transmit rule plus the two-register minimum leave word 1 of
   a ≥ 2-word frame exactly one acceptance cycle, the preamble cycle, so the
   *"may"* is arguably a pin in that branch too. The soft step is that the
   ≥ 2-cycle accept-to-transmit distance is stated for the idle-transmitter frame
   and inferred elsewhere. **A pin would flip `WO-0083` §4.4's broader ground**,
   making word 1 of the tail frame after an abort *required* and a withholding of
   it a legal underflow stimulus — a bench-visible consequence, so it goes to
   dv_lead as a joint item and not into a spec diff written alone.
3. **`J-architect_docs_lead-0055`'s Open-question 2 is untouched and is now the
   older debt.** The hold-until-acceptance rule still has no home in the
   programme: SPEC-M01 §7 delegates field stability to the declaring
   specification, SPEC-M04 §7 declares it for the acceptance cycle only, and the
   reset bullet relies on a rule it attributes to a bullet that does not state
   it. `WO-0083` §4.2 fact 7 now stands on **the driver's** guarantee because of
   it (dv's item (c)). Every transmit-path source in the chain relies on the rule
   implicitly; it is an adjudication to take with dv_lead, and this round did not
   take it.

### Files-in-this-commit
- docs/specs/modules/xgmii_tx_64.md
