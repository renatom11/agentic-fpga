# HALT LOG — cold-boot execution of PROCESS.md §6.2 "The order that works"

Executed 2026-08-11/12 by a cold adopter. World: `cold-boot-run/` only;
handover: `received/PROCESS.md` (one file, 2,973 lines). The adoption
repository is `cold-boot-run/adoption/` (15 commits on branch `work`, pushed
to the improvised protected remote `cold-boot-run/origin.git`).

---

## RAN-CLEAN — clauses executable from the text alone, as written

- **Step 0, fallback clause** ("Anything you cannot find is [RE] in your
  hands"): executed exactly; produced `adoption/residue/step0-mc-demotions.md`
  (all 34 [MC] rows demoted).
- **Step 1, the three lens names and the disposal duty** ("role coherence,
  enforceability, readability by the non-specialist"; "dispose of every
  finding in a committed artifact"): the review content and disposal ran as
  written; produced `adoption/reviews/charter-review.md` (11 findings) and
  `charter-review-disposition.md` (11/11 dispositioned).
- **Step 3, the verification protocol** ("an attempted violation that
  actually bounces, cited by identifier"): executed as written against the
  improvised remote — a real force push and a real branch deletion both
  bounced; `adoption/evidence/live-fire-bounce.txt`, cited in gate row G0.3.
- **Step 4, the case semantics** ("constructs a commit that violates it and
  asserts the refusal happens and names that rule"): executable once a
  numbering existed; produced `adoption/enforcement/selftest.sh`, 13/13 green
  from a clean clone.
- **Step 5, the blocking semantics** ("a critical finding blocked the gate
  until a decision record dispositioned it and the same seat re-verified"):
  executed as written — A-0001 finding 1 (critical) → DR-0002 → A-0002
  re-verification; the gate genuinely blocked and remains open.
- **Step 6, the harvest-destination clause** ("even if that destination is
  one file in your own repository"): executed as written;
  `adoption/docs/lessons/PACKS.md`.
- **The Definition of Done**: evaluable as written; results in
  `adoption/evidence/dod-evaluation.md` — 2 MET, 2 PARTIAL, 1
  MET-with-deviation; by the document's own falsifiable bar, "we adopted it"
  may NOT be claimed (gate open, sponsor rows unsignable).

Everything else below required stopping or inventing.

---

## HALT-01 — §6.2 Step 0 / §6.0: the shell does not exist in the handover
- **Text:** "verify the reference implementation's claims against its own
  machinery... check them in the shell you have been handed"; §6.0: "The
  other half is an executable **shell**... named in §6.0."
- **Attempted:** searched the entire document for any identifier of the
  shell — a name, URL, path, clone command.
- **What happened:** §6.0 never names it. It says "this repository,
  enforcement directory" for the originals (a repository I was not given)
  and "a separate repository" for the shell, adding "its contents are not
  verifiable from here." No identifier exists anywhere; I was handed one
  Markdown file. Every kit row of §6.0's table — commit script, re-check,
  policy module, self-test, workflow, constitution template, charter
  template, launcher prompts, packet forms, sponsor guide — is absent.
- **Disposition: STOPPED** on the verification path (0 of 34 [MC] stamps
  traceable, 0 self-test cases findable). The step's own fallback sentence
  was then executed (see RAN-CLEAN). The whole of Steps 2, 4 and 5 became
  reconstruction instead of adoption as a consequence.

## HALT-02 — Step 0: the residue list is demanded before it can exist
- **Text:** "belongs in your own residue list"; DoD checkbox 5 defines that
  list as "every control ... named, with the seat it is routed to — and a
  cadence for each."
- **Attempted:** to file the 34 demotions in a residue list at Step 0.
- **What happened:** no residue-list format appears anywhere in the
  document, and the required routing field presupposes seats that are only
  created at Step 1. The step's output has nowhere well-formed to land.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — invented the file format
  (`step0-mc-demotions.md`), deferred routing/cadence to
  `residue/RESIDUE.md` once seats existed, and invented every cadence value
  there (the source demands cadences and supplies none).

## HALT-03 — Step 1: charter template, roster, worker roles, sponsor journal
- **Text:** "→ kit: the charter template"; §1.3 lists charter fields; §1.6
  lists roster/program-state files; §2.1 references "all four worker roles."
- **Attempted:** instantiate charters for the §1.2 seat roster.
- **What happened / missing:** no charter template (kit absent); §1.3 gives
  a field list but no format, naming scheme, or directory layout; the four
  worker roles are referenced but never enumerated anywhere; §1.6's roster
  and program-state files are load-bearing artifacts that no §6.2 step ever
  schedules; and the sponsor has no journal while §3.7 requires every gate
  signature to reference a journal entry — the document never says how a
  journal-less human signs (found as review finding RC-2).
- **Disposition: PROCEEDED-BY-IMPROVISATION** — invented: charter file
  format and paths (`charters/*.md`), four worker role names (worker_impl,
  worker_verif, worker_tools, worker_docs), one shared worker charter file,
  `roster.md` and `state.md` formats, and the ruling "sponsor has no
  journal; sponsor rows are transcribed dated lines" (which then stayed
  unsignable for a different reason — HALT-14).

## HALT-04 — Step 1: "three lenses" with one actor
- **Text:** "Attack the charter set from at least three lenses"; §1.7 act 2:
  "Three independent reviewers, different lenses."
- **Attempted:** adversarial review with independent reviewers.
- **What happened:** a cold boot has exactly one actor. Independence is
  structurally unachievable; the review is §1.4(a)'s forbidden self-review
  by construction.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — one actor wrote all three
  lens reviews, declared the non-independence inside the review artifact
  itself, filed it as finding RC-1 (critical), and carried it into the
  retro-audit (A-0001 finding 3). The findings are real (11, incl. two
  defects of the source document itself); the independence is not.

## HALT-05 — Step 1 vs Step 2 vs §1.7: the order contradicts itself
- **Text:** Step 1 (before Step 2): "run the review **into the
  repository**"; Step 2: "the history you most want them for is the
  earliest history — which is also the history no control will ever have
  touched if you defer them (§1.7)"; §1.7 act 1: the machinery is turned on
  first so "the founding range is itself subject to the rules it
  introduces."
- **Attempted:** both orders. Followed §6.2 literally: review committed at
  Step 1, machinery at Step 2; then ran the full-history re-check.
- **What happened:** the re-check convicted all four pre-machinery commits
  (`evidence/recheck-from-root-at-machinery-on.txt`, 4× FAIL R06) —
  §6.2's own sequence manufactures exactly the untouched early history §1.7
  and Step 2 warn about. Sub-problem the document never addresses: the
  commit that introduces the gate cannot itself pass the gate (no journals
  exist yet to couple to).
- **Disposition: PROCEEDED-BY-IMPROVISATION** — DR-0001: a recorded
  baseline (`enforcement/recheck-baseline`) exempting the 4-commit founding
  range from the re-check, in direct tension with §1.7 act 1; the exemption
  is routed to the retro-audit (A-0001 finding 2). The alternatives
  (rewrite history; reorder the steps) are refused in the DR with grounds.

## HALT-06 — Step 2: the mechanical layer must be regenerated from prose
- **Text:** "Coupling, append-only with the chain, path isolation,
  files-list equality, monotonic ids, trailer protection, the large-file
  gate, and the full-history re-check. → kit: the commit script, the
  history re-check, the policy module, the workflow." §6.0 itself: without
  the shell this step "stands in for a substantial engineering effort...
  none of which any prose description will regenerate."
- **Attempted:** build the gate, re-check and policy module from §2 alone.
- **What happened / missing:** the semantics are well described; the
  concrete carriers are entirely absent. Invented, with no textual basis:
  the entry grammar's syntax (`## E<id> | <ts> | <wo> | <title>` + section
  labels); the trailer key names (`Agent:`, `Work-Order:`, `Entry:` — §2.1
  names the fields, never the keys); the journal-only marker's name
  (`Journal-Only: yes` — "the mark is a named trailer" whose name is never
  given); the empty files-list marker (`- (none)` — "the entry's file list
  must be the empty marker", marker unspecified); journal layout
  (`journal/<seat>/vNN.md`); volume-header field names (Prev-Volume,
  Prev-SHA256, Prev-Bytes, Continues-From-Entry); the scope-table syntax
  and its concrete rows; seat identity strings; branch names (`work`,
  `trunk`). Also: Step 2's own enumeration omits four §2.6 rows
  (journal-only marking, foreign seeding, size thresholds, merge
  triviality); reconciled by implementing the full table.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — ~200-line
  `enforcement/commit-gate.sh`, ~130-line `recheck-history.sh`,
  `policy.sh`; every listed item is invention. The layer works (11 gated
  commits under three seat identities, re-check green), but nothing
  guarantees it matches the
  original's "incident-hardened details" — which is §6.0's stated point.

## HALT-07 — Step 2 / Annex A.3: unmeasurable anchor, unstated threshold
- **Text:** Annex A.3: "the maximum bytes the agents' file-reading tool
  returns in one call — 256 KiB in this environment... measure each of
  these from your own environment." §2.6 large-file row: "a staged file
  over **a stated byte threshold** is refused."
- **Attempted:** measure my own reader's single-file byte limit; find the
  large-file threshold in the document.
- **What happened:** my reading tool exposes a line-count default, not a
  byte ceiling; no clean measurement was obtainable. And the large-file
  threshold is never stated anywhere in the document — the row calls it
  "stated."
- **Disposition: PROCEEDED-BY-IMPROVISATION** — adopted the reference
  262144/524288 journal thresholds with the anchor restated (contrary to
  the annex's measure-first instruction, said so in `policy.sh`), and
  invented 1 MiB for the large-file gate.

## HALT-08 — Step 2: "continuous integration" with no platform
- **Text:** §2.5: "Every rule the commit script enforces but one is
  re-verified by continuous integration over the entire pushed history."
  Kit: "the workflow."
- **Attempted:** stand up CI.
- **What happened:** no hosting platform or CI service is reachable from
  this environment; the workflow kit artifact is absent anyway.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — `recheck-history.sh` run by
  hand after every push, plus an unrunnable `ci/workflow.yml` stub. This
  converts the adjudicator into the committing seat's self-report — the
  exact failure class §2.5 names — recorded as residue row B.1.

## HALT-09 — Step 3: branch protection without a hosting platform
- **Text:** "Branch protection on every protected branch, with an **empty
  bypass list**... → kit: the sponsor guide." §2.5: "configured in the
  hosting platform — a setting the machinery cannot make for itself,"
  a "one-time sponsor duty."
- **Attempted:** configure platform branch protection.
- **What happened:** no platform exists; the sponsor guide is absent; the
  sponsor who owns the duty is unstaffed.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — local bare `origin.git`
  with a pre-receive hook refusing non-fast-forward and deletion on
  `work`/`trunk`; live fire executed and both attempts bounced (RAN-CLEAN).
  Material differences declared: the "empty bypass list" concept has no
  analogue, and any actor with filesystem access can delete the hook — the
  guarantee is convention wearing a refusal's clothes. Residue row B.2.

## HALT-10 — Step 4: the "numbered rules" have no numbers
- **Text:** §2.6: "The rule set is small, numbered, and cited by number in
  every later argument about them." DoD: "case count equals the number of
  numbered rules."
- **Attempted:** find the numbers to cite and count.
- **What happened:** the document never prints a single rule number; the
  §2.6 table has no id column. (B.2's `PROTOCOL §5 R1` glimpse confirms an
  R-scheme existed and was withheld with the domain nouns.)
- **Disposition: PROCEEDED-BY-IMPROVISATION** — invented R01–R13 mapped
  onto the §2.6 table's 13 rows; declared in `constitution/PROTOCOL.md §R`.
  The DoD's count is only evaluable against my own invention.

## HALT-11 — Step 4: self-test cases for rules that have no script
- **Text:** the self-test "for each numbered rule, constructs a commit that
  violates it and asserts the refusal happens and names that rule." §2.6
  rows: merge triviality — "pushed-history re-check only"; one branch/no
  force pushes — "**No script anywhere.** The hosting platform's branch
  protection, and nothing else."
- **Attempted:** one violating-construction case per rule, 13/13.
- **What happened:** for R13 the specified case cannot exist — there is no
  script whose refusal could name the rule. Additionally, the first run
  revealed that a two-agent R01 construction is intercepted by R08 before
  R01 can fire: "one agent per commit" is not a reachable refusal, exactly
  as §2.1's correction says (the invariant is one journal APPEND).
- **Disposition: PROCEEDED-BY-IMPROVISATION** — R12 asserted against the
  re-check, R13 against the improvised hook (an instrument the source says
  should not exist as script), R01 rebuilt as one-agent-two-appends on the
  re-check surface. 13/13 green, but two cases test improvised instruments
  and one tests a reformulated predicate.

## HALT-12 — Steps 4–5: no step authors the constitution
- **Text:** Step 4: "bind it to the amendment procedure (§2.7)"; §3.7: the
  gate checklist "quotes those clauses verbatim" from the constitution;
  Step 5 kit: "the constitution template."
- **Attempted:** bind the self-test at Step 4 and quote gate preconditions
  at Step 5.
- **What happened:** the amendment procedure and the quotable clauses live
  in a constitution that no step of §6.2 ever creates — the order assumes
  the kit template, which is absent; and Step 4 needs the binding one step
  before the constitution's kit artifact appears at all.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — wrote a minimal
  `constitution/PROTOCOL.md` from §2's content (rules with postures,
  amendment procedure with the self-test binding, §G gate preconditions
  authored specifically so the gate could quote something verbatim — which
  inverts §3.7's intent: the "source" was written to fit the checklist).

## HALT-13 — Step 5: packet forms, gate format, identifier schemes
- **Text:** "→ kit: the packet forms, the constitution template"; §3's
  taxonomy table and field lists; §3.7's gate properties.
- **Attempted:** instantiate the founding gate and packet skeletons.
- **What happened:** no form skeletons, no identifier grammar (the source
  deliberately excludes its identifier schemes as domain nouns), no gate
  file layout, no signature syntax.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — `packets/forms.md` (six
  skeletons from prose field lists), id schemes WO/SO/DP/SP/F-nnnn,
  `docs/gates/G0-org-ratification.md` layout, and the signature form
  `SIGNED <seat> <journal-entry-ref>`.

## HALT-14 — Step 5 / §1.7 act 3: ratification has no ratifier
- **Text:** "the sponsor's ratification row"; §1.7: "Have the one act
  performed that no seat inside can perform for itself: ratification by
  the sponsor. The organization cannot vote itself legitimate."
- **Attempted:** close gate rows G0.3 (platform duty) and G0.4
  (ratification).
- **What happened:** no human sponsor exists in a cold boot. Self-signing
  as "sponsor" was considered and refused — it is §5.7's permission-slip
  disguise, and §1.7 forecloses it explicitly. DR-0002 records the refusal
  of both evasions.
- **Disposition: STOPPED** — G0.3/G0.4 unsigned, gate permanently OPEN in
  this environment. By §1.7's own rule the first real work order may never
  issue. This is the halt that makes the adoption unfinishable by the
  document's own Definition of Done, and no improvisation can cure it.

## HALT-15 — Step 5: "a seat that did not exist during it"
- **Text:** "the retro-audit of the whole bootstrap range by a seat that
  did not exist during it, with its own weakness declared."
- **Attempted:** independent retro-audit.
- **What happened:** the auditor is the same single actor as every audited
  seat. The identity requirement is unfillable; only the weakness
  declaration is executable.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — the audit was performed in
  persona (`audit/A-0001-retro-audit.md`), returned 6 real, re-executable
  findings (1 critical, 2 major), and declares in its own text that its
  author witnessed and performed everything it audits. The findings are
  checkable by a stranger; the independence is fiction and says so.

## HALT-16 — Step 6: "only then start the work"
- **Text:** "Step 6 — only then start the work, and start the harvest
  cadence with it."
- **Attempted:** issue the first real work order.
- **What happened:** the gate is open (HALT-14), and §1.7 forbids issuing
  the first work order until every row is signed. Independently: this
  exercise has no program domain — there is no work to commission even if
  the gate closed.
- **Disposition: STOPPED** at the step's first clause. The
  harvest-destination clause was executed (RAN-CLEAN);
  `docs/lessons/PACKS.md` exists with a declared nil state.

## HALT-17 — Definition of Done: form deviations and a self-inflicted gap
- **Text:** checkbox 2: "every one that could not be traced has been
  re-stamped `[RE]` or `[PLANNED]` **in your copy**."
- **Attempted:** the full 34-row trace against my machinery.
- **What happened:** performed as a trace table
  (`residue/dod-mc-trace.md`: 28 traced, 3 re-stamped, 1 partial) rather
  than stamp-by-stamp edits inside `docs/PROCESS.md` — a form deviation.
  The trace also caught a defect this adoption itself introduced: my
  re-check does not re-verify the journal chain (R09) over pushed history,
  a §2.5-class one-surface asymmetry created while faithfully reproducing
  the source's *other* declared asymmetry (R10). Logged as residue and
  amendment candidate.
- **Disposition: PROCEEDED-BY-IMPROVISATION** (recorded deviation, plus
  the discovered gap left open and declared rather than silently patched —
  per the source's own §2.4 corollary discipline).

## HALT-18 — A posture contradiction inside the source, met at the trace
- **Text:** §1.1: "History is serialized on one branch, so there is a
  single order of events `[MC · C-09]`" versus §2.6's corrected row for the
  same property: "**No script anywhere.** The hosting platform's branch
  protection, and nothing else `[CORRECTED · C-67]`" — while the stamp
  legend defines [MC] as "a script or CI step refuses on violation."
- **Attempted:** decide which posture to inherit for C-09 in the DoD trace.
- **What happened:** both cannot be true under the document's own stamp
  grammar; a cold adopter has no way to know which row the audit actually
  measured.
- **Disposition: PROCEEDED-BY-IMPROVISATION** — adopted the §2.6 reading
  (platform-held, no script), re-stamped C-09 locally as stand-in-held, and
  recorded the contradiction here as a finding against the source document.

---

## Summary

**Total halts: 18** — **3 STOPPED** (HALT-01 verification path, HALT-14
ratification, HALT-16 start-the-work), **15 PROCEEDED-BY-IMPROVISATION**.

**The three most expensive halts:**
1. **HALT-01 (no shell).** The document is explicitly half of a two-part
   export unit and names its other half without any identifier. That single
   omission converted Steps 0, 2, 4 and half of 5 from "adopt and verify"
   into "reconstruct from prose" — the precise failure §6.0 predicts of
   itself ("none of which any prose description will regenerate").
2. **HALT-06 (the unexported carriers).** Rule semantics are stated with
   unusual precision, but every concrete carrier — entry syntax, trailer
   keys, marker names, path layouts, table syntax, rule numbers, one
   threshold — had to be invented. My machinery enforces *a* version of the
   rules; nothing can show it enforces *their* version.
3. **HALT-14 (no sponsor).** The one act the document says nobody inside
   can perform has nobody outside to perform it. It is the only halt that
   no amount of invention could close, and it makes the document's own
   Definition of Done formally unsatisfiable for a solo cold boot — which
   the document, to its credit, would call the honest result.

**Could a blank adopter replicate this process from this document alone?**
The organization's *design* — yes, to a striking degree: the seats, the
separations, the rule semantics, the failure classes, the gate/audit/
disposition choreography all executed coherently from the text, and the
document's habit of declaring its own residues meant most contradictions I
hit were ones it had already named somewhere else. The organization's
*machinery* — no: roughly one hundred percent of the executable layer
(every script line, every file format, every identifier scheme, every
marker name, the rule numbering, one enforcement threshold) is my invention,
constrained but never determined by the prose; and the two acts that give
the machinery authority — a verified reference implementation and an
external ratifier — are absent from the handover by construction. As a
process description this is the most self-aware document I have executed;
as an export unit it shipped the half that explains and not the half that
runs, and §6.2 Step 0 fails in the first minute for exactly the reason the
document's first edition was convicted by its own audit: a claim about an
artifact the reader cannot reach is [RE] in the reader's hands, whatever it
is stamped.
