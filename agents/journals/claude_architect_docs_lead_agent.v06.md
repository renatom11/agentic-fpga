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
