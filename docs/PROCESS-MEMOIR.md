# PROCESS-MEMOIR — the companion volume

**What this file is.** It is the **history half** of `docs/PROCESS.md`. That file
states the law this organization works under; this one holds everything the law
used to say and no longer does — every corrected claim preserved beside what
refuted it, every edition's item-by-item ledger of what it changed and what it
refused, the debts each edition owed and to whom, and the map from that
document's function names onto this program's own seats, paths and tokens.

**What this file is not.** It states **no rule**. Nothing here binds any seat,
and nothing here is current. Every claim preserved in Part I is preserved
*because it was found false*, and every one of them is marked as such at the
point a reader meets it.

> **The core governs.** Where this volume and `docs/PROCESS.md` disagree about
> what any rule is, `docs/PROCESS.md` is right and this file is stale. There is
> no case in which a sentence here overrides a sentence there. If you find a
> disagreement, it is a defect of this volume, and the repair is always to this
> volume.

**Why the two files exist.** For five editions the law and its history were one
document, interleaved at paragraph granularity: a reader wanting *what is the
rule now* had to separate the running line from preserved false claims, edition
genealogy and annex archaeology in nearly every section. Three consecutive
councils named it; the document's own graders scored readability B− and
conciseness C+; the separation was recorded in the document itself as **NOT
ATTEMPTED, for the second consecutive edition**. The sixth edition performed it.
The governing decision record is **`docs/adr/ADR-0022`**, which carries the
alternatives considered, the failure modes the split creates, and what it
explicitly does not decide.

**Who this volume is for.** Three readers, and it is worth naming them because
the core is not written for any of them. An **auditor** checking whether a
correction was actually made rather than merely announced. A **reviewer of the
split itself**, verifying that nothing was lost — Part 0 is written for exactly
that act. And a **later edition's author**, who needs to know which repairs have
already been tried and why the refused ones were refused, so that a rejected
option does not return as a fresh proposal and get rejected again at full cost.

**Edition anchor — companion to the sixth edition · 2026-08-12 · this program's
working branch, at the commit that carries this line; created by the split
recorded in Part 0, from `docs/PROCESS.md` as it stood at the fifth edition plus
that edition's repairs. Written against `7b749f0` with one sibling landing at
`91f005d` verified as touching no path of either volume.** This volume carries
no posture stamps of its own: every `[MC]`, `[RE]`, `[P1]`, `[PLANNED]`,
`[CORRECTED]` and `[UNANCHORED]` mark appearing below is quoted material from a
core passage as it stood when the quoted claim was superseded, and none of them
has been re-measured.

---

## Part 0 — the split, its manifest, and how to falsify it

The sixth edition executed §6.1's fork contract once, exporter-side, on the
exporter's own copy. `docs/PROCESS.md` states the rule and the falsifiers where
its readers meet them; this part carries the manifest, which is the artifact a
reviewer needs.

### 0.1 — The rule, in four clauses

- **S1 — the sentinel is the strip-marker.** Every passage opening with the
  fixed token `SUPERSEDED — historical record, not current law:` moved whole,
  under the heading of the core section it was anchored to. **32 blocks.**
- **S2 — the program-local annexes move whole.** **Annex B** and **Annex C**
  moved intact, **752 lines**, on the fork contract's own instruction for both
  (*delete whole and write your own*). They are made entirely of program nouns;
  §1–§6 exclude those by construction.
- **S3 — three blocks of pure edition-archaeology carrying no token moved by
  name**, listed individually in §0.2 below so the exception is countable rather
  than discretionary. **A rule with an enumerated exception list is auditable;
  a rule with an unstated exception is not.**
- **S4 — nothing was deleted.** Every moved line is below. Every moved block
  records the core section it came from.

### 0.2 — The manifest

**35 blocks, 330 lines**, plus the 752 annex lines, **1,082 lines total**. The
line numbers are positions in `docs/PROCESS.md` **as it stood immediately before
the split** — after the sixth edition's repairs and before the strip — which is
the only state against which they resolve.

| Lines (pre-split) | Count | Anchored at | Clause |
|---|---|---|---|
| 232–241 | 10 | *Every enforcement claim carries its posture* | S1 |
| 607–617 | 11 | §1.1 | S1 |
| 656–663 | 8 | §1.1 | **S3** — the limb-split re-execution note |
| 665–676 | 12 | §1.1 | S1 |
| 745–759 | 15 | §1.1 | S1 |
| 808–814 | 7 | §1.2 | S1 |
| 898–908 | 11 | §1.3 | S1 |
| 954–964 | 11 | §1.4 | S1 |
| 1057–1067 | 11 | §1.4 | S1 |
| 1245–1252 | 8 | §1.5 | S1 |
| 1276–1279 | 4 | §1.5 | S1 |
| 1313–1331 | 19 | §1.6 | S1 |
| 1654–1660 | 7 | §2.1 | S1 |
| 1766–1770 | 5 | §2.2 | S1 |
| 1915–1919 | 5 | §2.4 | S1 |
| 1949–1951 | 3 | §2.5 | S1 |
| 1998–2013 | 16 | §2.5 | S1 |
| 2029–2032 | 4 | §2.6 | S1 |
| 2082–2084 | 3 | §2.6 | S1 |
| 2086–2093 | 8 | §2.6 | S1 |
| 2157–2171 | 15 | §2.7 | S1 |
| 2608–2613 | 6 | §3.3 | S1 |
| 2755–2764 | 10 | §3.3 | S1 |
| 2815–2830 | 16 | §3.3 | S1 |
| 3205–3215 | 11 | §3.7 | S1 |
| 3347–3360 | 14 | §3.9 | S1 |
| 3362–3377 | 16 | §3.9 | S1 |
| 3635–3644 | 10 | §3.9 | S1 |
| 3862–3868 | 7 | §4.3 | S1 |
| 4002–4011 | 10 | §4.7 | S1 |
| 4085–4091 | 7 | §5 | **S3** — the failure museum's revision-history note |
| 4110–4116 | 7 | §5.1 | S1 |
| 4255–4260 | 6 | §5.5 | S1 |
| 4483–4489 | 7 | §6.0 | **S3** — the *three rows added* note |
| 4567–4576 | 10 | §6.0 | S1 |
| 5227–5978 | 752 | Annexes B and C | S2 |

### 0.3 — The arithmetic, so it closes

```
pre-split source                     5,976 lines
  − S1/S3 blocks moved                 330
  − S2 annexes moved                   752
  − blank lines swallowed at each
    extraction point (35 + 1 trailing)  36
                                     -------
core body after strip                4,858 lines
  + front matter the split itself adds
    (the derivation block, the Contents
     re-pointing, the boundary re-measure,
     the re-derived subsection index)      62
                                     -------
docs/PROCESS.md, sixth edition       4,920 lines
```

*Two figures in that sum are worth checking rather than trusting.* The **36
swallowed blanks** are one blank line per extraction point (35) plus the file's
trailing blank; and the **62 added** are the only lines in the core that the
fifth edition's text does not contain, all of them in the front matter, all of
them about the split. Every other line of the sixth edition is either fifth-
edition text, a repair listed in **B.11**, or one of the 1,082 lines below.

### 0.4 — Four falsifiers

Any of them coming back wrong is a defect of the split, **not** a claim that the
matched text is law:

1. **`grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS.md`
   returns 0.** Against this file it returns the census in §0.5.
2. **Every anchor resolves**: each Part I heading names a section of
   `docs/PROCESS.md`, and that section exists there.
3. **The arithmetic in §0.3 closes.**
4. **A diff of the sixth edition against the fifth contains no removal that is
   not either a block in §0.2's manifest or a named repair in B.11.** This is
   the strongest of the four and the only one that catches a silent deletion;
   it is a reviewer's act and no script performs it.

### 0.5 — The sentinel, and its census

- **the superseded-text sentinel** — **every passage in this volume that
  preserves a claim the core no longer asserts opens with one fixed token**,
  immediately before the preserved text:
  `SUPERSEDED — historical record, not current law:`. The token exists for a
  reader who never sees this page: a retrieval system returning a fragment of
  this file returns the false sentence **and its marker in the same fragment**,
  because the two are adjacent by construction rather than by layout. **The
  token is never broken across a line**, whatever that does to the wrapping — a
  marker split by a line break is a marker a grep does not find, which is the
  whole of what it was for. A preserved claim without the token is a defect of
  this volume, not an assertion that its text is current. `[B.10·5]`
- **Census at this edition: 33 preserved passages carry the token** — **32 in
  Part I and 1 inside Annex B** (B.1's own note on the third edition's
  unrowed claims). Re-derivable by
  `grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS-MEMOIR.md`,
  **which returns 38**: the other **5** are mentions of the token rather than
  uses of it — **4 in this Part 0** (clause S1, falsifier 1, and this entry's
  two) and **1 in B.10's row** recording the convention's adoption. *A census
  that does not reconcile its own grep count to its own claim is a census
  nobody can run.*

*And the property the split bought that the sentinel never could.* The core now
contains **no preserved superseded claim at all**, so no fragment of it can
carry one. **A retrieval-safety property held by construction beats one held by
a marker.** The marker was the cheapest form available before the split; it was
never the best one, and it remains the right instrument here, where preserved
false claims are the point of the file.

---

## Part I — the superseded record, by core section

Every passage below was a **running line or a margin of an earlier edition of
`docs/PROCESS.md`**, is preserved here verbatim as it stood when it was
superseded, and is **not current law**. Each is filed under the core section it
was anchored to. Read them for one purpose: to see what the document used to
claim, what refuted it, and what class of error it was — which is the only way
to tell a document that corrects itself from one that has never been checked.

### Anchored at — Every enforcement claim carries its posture

**SUPERSEDED — historical record, not current law:** the two sentences the block above
replaces were the sharpest false claims in the second edition, and they were
false in the most expensive direction — they told a reader the unmeasured
surface was small and locatable. They said the
failure-class prose is *"the one place a reader will see unstamped
normative-sounding text"*, and that *"exactly two rules"* were added after the
measurement. Both were true of the text when they were written and were left
standing while the document doubled around them. **A boundary claim about a
document's own coverage decays faster than any claim inside it**, because every
edit moves the boundary and none of them touches the sentence.


### Anchored at — 1.1 Why one seat holds both monopolies

*Margin note — what the first edition claimed here, and what refuted it.*
**SUPERSEDED — historical record, not current law:** it stated the second monopoly as an
unqualified fact of the record
`[CORRECTED · C-07]`. The record contradicts it. The rule became standing only
late in the program, after an episode in which the auditor — the one seat whose
whole value is that it does not touch what it grades — cut, committed and pushed
five transient references on the orchestrator's own dispatch, plus three earlier
deviations of the same shape. The instrument that codifies the rule is, at this
writing, still *proposed*. It has been broken, on instruction, by the seat least
able to afford it, and the repair was to write the rule down rather than to
build a check that could not exist.

*How the limb split was established, and it was re-executed rather than quoted:*
every enforcement script was read for a force-push, rebase or branch-name check
and none carries one; the merge-triviality and octopus refusals were located in
the pushed-history re-check. **The two limbs were true separately and false
together.** A reader of §1.1 alone inherited a machine-checked guarantee for a
property §2.6 says nothing holds, and the reconciliation lived only in the
posture list's evidence cell — which is to say, outside the document.

*Margin note.* **SUPERSEDED — historical record, not current law:** the first
edition said the numbering was "monotonic by construction rather than by
convention" `[CORRECTED · C-08]`. It is not. Single-authority allocation makes
numbering *administrable*, not monotonic: the record contains letter-suffixed
identifiers outside the numbering scheme, and four identifiers that are live in
reasoning logs and program state with no packet file ever committed.
Construction required improvisation in both directions. **The generalizable
form: centralizing an allocator removes the race, not the discipline.** A
single allocator still needs a rule about what to do when a unit of work needs
an identifier before it needs a packet — and if that rule is absent, the
allocator invents one per incident, which is the convention the sentence
claimed to have eliminated.

*Margin note — the count the paragraph above used to carry, demoted here so
that the running line rests on the re-derived table rather than on a disputed
enumeration.* **SUPERSEDED — historical record, not current law:** through the
fourth edition the running line added that the dormancy is *"the single fact
underneath six of the eight owed postures in this edition (§4.3, §1.4(c), §2.1,
§2.3, §3.1, and this row)"* — and then interrupted itself, mid-clause, with the
news that an independent record audit had filed that count as wrong: its
reading is that the posture list carries five audit-sampling rows and three
unbuilt-warning rows, and that the sixth item enumerated was a performed-once
row rather than an owed one. That edition marked the dispute and did not repair
it, the repair being outside its commissioned scope — and in doing so asked a
reader to disbelieve a sentence from inside that sentence, which two
independent cold readers named as the passage most needing repair. **The fifth
edition removes the count from the running line rather than arguing about it.**
The enumeration is still owed a round (**B.9**, refusal 3). `[B.10·3]`


### Anchored at — 1.2 The seats, by function

*A precision the first edition got wrong by one.* **SUPERSEDED — historical record, not current law:** it
said the auditor writes to **one** directory. It is two: its report directory,
and its own reasoning log — which every commit it makes must append to, by the
coupling rule of §2.1, and which is carved out of the scope check for exactly
that reason. The general form matters more than the correction: **a write-scope
statement that forgets the journal carve-out describes a seat that cannot
legally commit anything.**


### Anchored at — 1.3 Charters — a role is a document, not an understanding

*Why the two that were missing are the two that mattered.*
**SUPERSEDED — historical record, not current law:** the previous edition's list ran identity, mission,
responsibilities, interfaces, inputs and outputs, definition of done,
evaluation criteria, escalation rules, write scope — nine items, but not these
nine: it counted the write scope as a section when it is a field of section 1,
and it dropped **8** and **9** entirely. Section 8 is where the coupling rule
reaches an individual seat, and section 9 is where a read restriction is
written down *as unenforceable*, which §1.4(c) calls a control in its own
right. **An adopter generating charters from the previous list produced a seat
set with no journaling clause and no honest-enforcement layer at all** — and
the failure is silent, because such a charter reads complete.


### Anchored at — 1.4 Separation of duties — five separations, each drawn against a specific temptation

*Margin note — this list's own count was wrong twice, and the second correction
is the more interesting one.* **SUPERSEDED — historical record, not current law:** the first edition's
header said "three lines" over a list of four: a count of the working lines
standing over a list of separations. Four was the count that matched the list —
until the second edition added **(e)**, on the verification lead's own
correction. That separation is drawn by the constitution and executed by the
one sign-off in the record, and this document carried it **nowhere**: not in
this list, not in the sign-off form of §3.8, not anywhere. **The seat that
found it is the seat the separation constrains** — which is the shape §3.4
calls the finding worth trusting, and which is also why the number in a header
is worth checking against the list under it.

*Two corrections this clause owes its own standard.* **SUPERSEDED — historical record, not current law:**
it is **not the only** unenforceable read restriction — a consult-only
licensing boundary in the same constitution has identical non-enforceability,
and a rule that calls itself unique invites an adopter to assume every other
read restriction is covered. And the third compensating leg — the audit of
recorded reading — **is dormant**: the instrument is a sampling round on the
reasoning logs' *Inputs* sections, it exists in a charter, and §1.1's summed
table is where every interval in this tier is counted, once, for the whole
tier. Two of the three things this clause says it can check are checked by
nobody, which is why the leg is stamped owed rather than described in the
present tense.


### Anchored at — 1.5 The auditor is a different kind of seat

*Margin note.* **SUPERSEDED — historical record, not current law:** through the
fourth edition the line above read *"Four mechanisms in it are domain-free and
load-bearing"* over a list of **five** — a header count standing over its own
list, which is the defect §1.4's margin convicts, recommitted. An independent
record audit filed it; that edition marked it and did not repair it, the repair
being outside the round's commissioned scope. **The fifth edition drops the
count rather than asserting a new one**, and the enumeration is still owed a
round (**B.9**, refusal 3). `[B.10·4]`

**SUPERSEDED — historical record, not current law:** the first edition said the canary instances "never
are" documented, which contradicted the finding route in the clause after it.
The same contradicted sentence stood in the sponsor-facing guide, and was cured
there too.


### Anchored at — 1.6 Agents are stateless; the repository is the memory

*Margin note on both aids, and it is the same note.* **SUPERSEDED — historical record, not current law:**
the first edition described the index as a maintained navigation aid — and
until the fourth edition the running line above still described it as
*refreshed at boundaries*, with the whole correction left to this margin. That
is its own small defect and it was caught by the census that re-read every
marker: **a `[CORRECTED]` marker means the running line has been repaired and
the first edition's claim preserved beside it, or it means nothing.** The
correction itself: **it was written once, at ratification, and never updated**:
at the audit it still listed two leads as "not yet activated" while one of them
was eleven volumes deep, and named an entry id some nineteen entries stale. It
was letter-compliant — one boundary had passed — and materially false as a
description of a live aid. The program-state file decayed in the same direction
and needed a census to repair: work-order identifiers that were live in
reasoning logs and never rowed. **The lesson generalizes past both files: an
aid refreshed "at boundaries" degrades exactly as fast as boundaries are rare,
and a stale aid is worse than a missing one, because a missing one sends the
reader to the source.** If you carry a derived index, either derive it
mechanically at read time or state in the file itself the date it was last
true.


### Anchored at — 2.1 One agent per commit, coupled to a journal entry

*Honesty note, corrected.* `[CORRECTED · C-40]` **SUPERSEDED — historical record, not current law:** the
first edition — following the constitution's own words — said that for seats
with narrow write scopes, one-agent-per-commit *falls out of the scope rules
automatically*, because a commit physically cannot mix two scoped seats' files.
**That is false, and it is the most consequential false claim in the first
edition**, because it is the sentence that tells an adopter it need not audit
attribution for scoped seats.


### Anchored at — 2.2 Journals are append-only, and a journal is a chain

The stamp stands; its *scope* is the correction. **SUPERSEDED — historical record, not current law:** the
claim the bullets above replace was *"re-verified on every commit and again
over pushed history"* — two claims wearing one stamp, **true of the part that
changes on that commit and false of the walk**. The distinction matters to
exactly one reader: the one building the layer.


### Anchored at — 2.4 Mechanical refusal over advisory warning — and the exceptions, deliberately

**SUPERSEDED — historical record, not current law:** that stamp read 2026-08-04 until the date census
re-anchored all of them: the commit that mirrors the rule into the pushed-history
re-check is dated the third. One day, and the correction is worth the line —
§5.4's whole lesson is that a date in a record is testimony, and a date nobody
re-anchored is testimony nobody tested.


### Anchored at — 2.5 Continuous integration is the adjudicator

**SUPERSEDED — historical record, not current law:** the first edition said "every rule", without
qualification. The defect is not the missing check so much as the **unqualified
quantifier**, because a reader who trusts it stops looking for exactly this.

*Margin note — a two-word repair with a one-round delay, kept because the delay
is the lesson.* **SUPERSEDED — historical record, not current law:** this line
read **"Two things that matters for"** in the second and third editions: a
sentence that lost its subject in an edit and kept the verb's agreement with
it. The defect was **found and reported by this document's own author in the
round that produced the third edition, and deliberately not corrected**, on the
ground that the seat could not establish which edit dropped the subject and
would not repair a running line on a basis it could not cite — §3.1's evidence
rule, applied by a seat to its own prose. **The dispatch for this edition
supplied the attribution the report lacked**, and the repair lands here with
its source named. *(Source: `J-architect_docs_lead-0052`, this seat's own
round-3 report; attributed by the round-4 dispatch — Annex B.9.)* The
generalizable half: **a defect a seat reports and refuses to fix is not a
defect it has excused — it is one whose route was missing**, and the route is a
party willing to attribute it. Refusal with grounds (§4.8) is what keeps such
an item countable instead of lost.


### Anchored at — 2.6 The numbered commit rules

**SUPERSEDED — historical record, not current law:** an earlier edition said the rules are "numbered, and
cited by number" and never printed a single number — so an adopter executing the
self-test step of §6.2 had to invent a numbering, and could then evaluate the
adoption's own definition of done only against their own invention.

**SUPERSEDED — historical record, not current law:** an earlier edition's table called this threshold
*stated* and stated it nowhere; an adopter executing the document from the text
alone had to invent one, and invented a different one.

*Margin note on the last two rows.* **SUPERSEDED — historical record, not current law:** the first edition
folded them into a single "serialized history" row sitting under the sentence
"the commit script enforces". Two of that row's four clauses are enforced
somewhere other than where the sentence put them, and one is enforced **outside
the repository entirely** — the dependency §2.5 declares. A reader building
this layer from the first edition would have looked for force-push prevention
in the commit script and concluded, correctly, that it was not there, and then
had to guess whether that was an omission or a design.


### Anchored at — 2.7 The amendment procedure

*Margin note — a false limb, deleted in the fourth edition, and it is the
sharpest lesson of the round that deleted it.* **SUPERSEDED — historical record, not current law:** the
sentence above previously ended: *"an instrument in force with its
constitutional diffs **and its owed test cases** still unapplied."* The
test-case half was **false**. Those cases landed, at a commit an independent
reader could open, and they run green inside the very self-test count §6.3
quotes back at the reader — so the document simultaneously counted them and
called them unapplied. *(Refuted by execution against the suite; source:
council verdict Tier 1 and the re-execution behind it. The constitutional-diffs
half is true and survives alone — Annex B.8.)* **The class is the one that
edition existed to purge, and it survived a claim-by-claim census** because the
census measured *postures* — is there a script? — and this limb is a claim
about **events**, which is the tissue §6.1 says false claims cluster in. A
compound sentence with one true half is the hardest false claim to find,
because the true half is what the reader remembers checking.


### Anchored at — 3.3 Sealed predictions

*Margin note.* **SUPERSEDED — historical record, not current law:** this
section's opening line read *"Before evidence exists…"* through the fourth
edition — the weaker phrase that edition's own freeze-point bullet withdraws in
terms, left standing in the sentence that introduces the mechanism. A cold
reader of the fourth edition caught the residue and recorded that the bullet
governs. `[B.10·9]`

*Margin note.* **SUPERSEDED — historical record, not current law:** the first
edition said the file carries "its own hash at that commit". **A file cannot
contain its own hash**, and the record's seals say so in their own headers —
one states outright that it cannot state its hash, because the seat that writes
it never runs the version-control tool and the commit does not exist until
another seat creates it. The document invented a field the grammar cannot have
and omitted the two mechanisms that do the work. **The class is worth naming: a
described mechanism that nobody has tried to execute will contain steps that
cannot be executed**, and the way to catch it is to write the description from
the artifact rather than from the intention.

*The withdrawn rule, and why it is withdrawn rather than excused.*
**SUPERSEDED — historical record, not current law:** this section previously closed: *"the seal is opened
by the seat that froze it, at the round the evidence lands, and scored by the
reviewing seat named in the commissioning packet — never by the party whose
work the evidence grades."* The first half is the practice. **The final clause
is contradicted by every scored campaign in this record**: each was scored in a
verdict appended to its own commissioning packet, authored by the seat that
froze the seal and whose suite was the subject under test, under that seat's
own entry id. Re-derived for this edition rather than quoted: **thirteen sealed
campaigns exist, every seal frozen by that same seat; ten have been scored, all
ten by it; three are drafted and unscored.** No exception, and **none marked as
a deviation at the time** — which is the part that makes it a divergence rather
than a disclosed choice. **A rule that has never once been kept is not a rule
with a deviation — it is a description of a different organization**, and the
honest act is to withdraw it rather than to restate it with an apology
attached.


### Anchored at — 3.7 Gates

*Margin note, and this is the correction that most changes what an adopter
should build.* **SUPERSEDED — historical record, not current law:** the first
edition said signers cannot stage the checklist **because write scopes forbid
it**. They do not. In the audited scope table the specification lead — who is a
gate signer — holds the entire documentation tree, gate directory included; a
live probe of the policy returns **allow**, and four commits under that
identity have staged gate files, one of them the very checklist that carries
this rule. The real control is a **convention written at the top of the
checklist itself** — *no box in this file is checked by its author* — which is
review-enforced, and which the record shows being kept (including a round where
the author of a checklist declined to check its own boxes and said so).


### Anchored at — 3.9 Seeded-defect campaigns

*Margin note.* **SUPERSEDED — historical record, not current law:** the first
edition said "on a fixed cadence", and said the manifests are applied
**transiently** — in a working state that is reverted. Both are wrong against
this program's record, and the second is wrong in a way worth carrying, because
the constitution still says it too. Every campaign in this program ran as
**ordinary commits pushed to marked references that are never merged** —
**eighty-six such references at this revision's own commit, none merged,
grouped under fifteen campaign prefixes and two probes** — for a reason that is
a substrate fact, not a preference: *the only environment that can run the
suite runs on pushed references*. There is no local run to revert. The first
edition contradicted itself on this within twenty-five lines, describing the
transient model here and the pushed-reference model below. The
rule-and-its-check disagreement of §2.4, in a document, about its own
mechanism.

*(**SUPERSEDED — historical record, not current law:** the figure read "some
ninety" until an independent seat re-measured it, and the imprecision mattered
more here than its size suggests, for two reasons. This is the one section that
**rules a reference population cannot be a denominator** — and a section that
rules so may not quote its own reference count loosely, or the next reader will
divide by it. And the count is of *references*: not of campaigns, of which
there are fifteen, and still less of defect classes, which is the unit every
rule below insists on. The shape an adopter will actually find in this record
is a run of campaigns against one artifact, interleaved with defect packets and
their repairs — not one campaign sitting in one gap. The count was re-measured
once more at this edition's own commit, by the same method — a count of pushed
references under the reserved prefix — and is unchanged: **eighty-six, and none
of them an ancestor of the working branch's head.** The campaign/probe split
below it is **quoted, not re-derived this round**, and says so, because
re-deriving a figure by a different method and reporting it as the same figure
is the defect this bracket exists to correct.)*

*Margin note — what this exhibit said before, and why the correction is worth
keeping.* **SUPERSEDED — historical record, not current law:** it previously
opened on a defect *"later said to be handled, on the strength of a suite that
had grown since"* — **an event this record does not contain.** Both seats
confirming this section returned that correction independently, one of them the
seat whose campaigns the exhibit describes: no weaker form was ever used here.
Crediting a record with a fault it did not have is the same class of false
claim this edition exists to remove, and it is the worst kind to find,
**because it is attached to a rule that is correct** — the rule survives the
audit and carries the invented lapse along with it.


### Anchored at — 4.3 Verbatim relay, with the relayer's additions marked

*(**SUPERSEDED — historical record, not current law:** this passage previously
closed by saying the mechanism failed in the benign case "and was therefore
visible before it failed in a case that mattered." That is no longer true of
the record, and the seat on the receiving side of both later failures is the
seat that said so. Note what the false half was doing: it made a real exhibit
carry a **reassurance** the record does not support, which is how a document
acquires a claim nobody ever filed.)*


### Anchored at — 4.7 The sponsor's reserved decisions

*Margin note — the quantifier that had to go.* **SUPERSEDED — historical record, not current law:** the
second edition called this list *"completely enumerated"* and then omitted the
fifth item, which was already granted by the constitution and already being
exercised. **A document that convicts its own first edition of unqualified
quantifiers asserted complete enumeration over an incomplete list** — and the
omitted item was the one human check on the document's own subject, the export.
*(Source: council verdict Tier 1 — Annex B.8.)* The repair is both halves: the
item is added, and the claim is dated. **"Complete as of this edition, closed
by amendment" is a claim a later reader can test; "completely enumerated" is
one they can only believe.**


### Anchored at — 5. The failure museum

*A note on this section's standing, since the rest of the document has been
rewritten repeatedly around it.* Every reviewer of the first edition — including
the hostile ones — certified this section and the failure classes as the part
that transfers whole, and every council since has fenced it. It is therefore
**changed only where a specific claim inside it was measured false or its tense
was wrong**. Exhibits have been added; nothing has been trimmed.


### Anchored at — 5.1 Remedies decay without mechanical checks

*The qualification is the exhibit, not a hedge.* **SUPERSEDED — historical record, not current law:** "A
majority of the record" is true of one measurement and false of the other, and
the first edition gave the headline number and the stronger word without saying
which measurement produced which. **A census is not one number**, and the
sentence that reports it has to carry the band it was measured at, or the next
reader will pair the strongest adjective with the most memorable figure — which
is what happened here, in a document about record fidelity.


### Anchored at — 5.5 A guard that forecloses conduct is enforced differently from one that routes traffic

*And the correction underneath is the reason the second edition existed.*
**SUPERSEDED — historical record, not current law:** the first edition said
*each clause* does this. It is an excellent practice, applied three times,
described as universal. The same over-generalization is what that edition did
to itself: it stated the posture rule and stamped nothing. **A practice you
have applied three times is a practice; write the number.**


### Anchored at — 6.0 The export unit — this document plus the shell

*Why the chain verifier and the posture list are rows rather than assumptions.*
Both were once **absent from a table that claimed to list the unit's contents** —
the first meaning an enforcement reconstruction from this document ships without
the auditor's chain instrument, the second meaning every stamp cited an artifact
with no path, which under §3.1's own evidence rule made the document's entire
evidentiary spine testimony for its declared audience. `[B.8·8]`

*And it is the **exporter's** to build, not the adopter's.*
**SUPERSEDED — historical record, not current law:** an earlier edition called it "the most useful thing an
adopter could build first." That is the wrong party: **the exporter holds both
halves of the export unit and the adopter holds one.** Asking the party with
the least information to perform the verification the party with the most
information skipped is not a residue, it is a shirk. It is recorded as owed by
this document's own seat, in **Annex B**, with its closing event named. Until
it lands, every facsimile in this document and every row of the table above is
a claim about another repository — held to the same rule as every other claim
here: **check it before you repeat it.**

---

## Part II — Annex B: what each edition owed, and when

*This annex was `docs/PROCESS.md`'s Annex B through the fifth edition and moved
here whole at the split (Part 0, clause S2). It is **program-local**: an adopter
forking the core deletes it and starts their own. Its rows below are preserved
as they stood, with the sixth edition's additions marked in place — **B.0.3's
status**, **B.2's new items**, and the new **B.11** table, which is the sixth
edition's own item-by-item record and the destination of every `[B.11·n]`
pointer in the core.*

## Annex B: what each edition owed, and when

*Program nouns appear in this annex, and several of them appear before **Annex
C** defines them — seat names, entry ids, decision-record ids, the constitution's
own filename. That is deliberate and it is the boundary: **§1–§6 speak in
function names and this annex names this program's own artifacts.** Annex C is
the map; a name here that you cannot resolve is resolved there.*

*This annex is **program-local**. An adopter forking the core deletes it and
starts their own. It is here because §3.5 forbids recording owed traffic as paid
and §5.5 requires a debt to be legible to a later reader, and a ledger whose
entries cannot be resolved to acts is not a ledger — so this is the one section
that names this program's own artifacts.*

**In the fourth edition it stopped being a ledger and became a schedule.**
`[B.9·14]` The change is one column wide and it is the difference between a
debt and a confession. A ledger records that something is owed; three editions
of this annex have done that faithfully, and an independent reader read the same
faithfulness as the defect: **the cold-reader row was recorded *owed* twice
running, and nothing in the document made either round come due.** §5.5 says a
routing rule is enforced by a **named owner, a named triggering event and a
visible debt**, and this annex has been carrying one of the three. So the two
debts the council made conditions of this edition are written below as **dated
conditions with owners and commissioners**, not as rows; and the standing
confirmations table gains the same treatment where an owner exists for it.
**A named debt is not a discharged one** — but a named debt with no due date is
not even a debt, it is a preference.

### B.0 — The dated conditions, and what they returned

*Neither of the fourth edition's two conditions was performed by this document's
seat, and that was the point: both are acts this seat cannot perform for itself
— the first because it requires a reader who has not read it, the second because
it requires an executor who did not write it (§1.7's amortization pattern,
applied to a document).* Both were commissioned by the orchestrator on that
edition's landing. **Both are now executed with committed reports**, and this
table is where a later reader checks whether a scheduled condition came due.

| # | Condition | Owner (performed) | Due | Status, with its anchor |
|---|---|---|---|---|
| **B.0.1** | **Execute B.1's standing cold-reader row against the fourth edition** — a reader with no session context, no participation in any round and access to this document only, answering that row's four questions: terms inferable, sections reachable, followable without the edition it corrects, every cited artifact locatable. | **two** cold readers, independently, neither with prior contact with this program | before any fifth edition is drafted | **EXECUTED-WITH-ANCHORS, run twice over, 2026-08-12.** Reports committed at `docs/reports/process-council/round-3/cold-reader-A.md` and `…/cold-reader-B.md`. Returned grades, verbatim: *"accurate, navigable, and not yet hospitable"* and *"readable with sustained effort, roughly a B-minus."* Their two three-passage repair lists are what §1.1's demoted count, §1.5's demoted count, §3.3's cast list and opening line, §3's `PROPOSAL` token and this document's annex headings were written from. |
| **B.0.2** | **Cold adoption run number two, against the revised §6.2** — the order restructured into acts 1a–1d, executed literally by a seat that did not write it, in a clean world, logging a halt at every under-determination, contradiction or platform failure. | a cold adopter, not this seat | before the replication claim is made in any form | **EXECUTED-WITH-ANCHORS, 2026-08-12.** Halt log committed at `docs/reports/process-council/round-3/adoption-run-2-halt-log.md`. **17 halts, ZERO STOPPED**, against run one's 18 and 3. Interfaces — grammars, identifiers, thresholds, rule numbering — transferred as facsimiles; the executable layer's implementation was still invented end to end. §6.2 carries both runs, the budget they imply, and what the pair does and does not license anyone to claim. |

*What B.0.2 was for, since it is easy to read as ceremony.* **The trend of the
halt count across runs is the only empirical form the replication claim can
honestly take** — not a reviewer's grade, not this annex's own count of applied
conditions, and certainly not the document's opinion of itself. One run is a
measurement of one edition; two runs are the first derivative. The condition
deliberately named the log rather than a target, so that a flat or worse result
would be reportable. **What it returned is a flat halt count over a stop count
of zero**, and the honest reading of that pair is §6.2's: the order has stopped
being unexecutable and has not yet become determinate.

*And the acceptance test the fourth edition could not run for itself is now
run.* B.9 item 1 recorded its own test as *"two independent cold readers
reconstruct the same information flow — not yet run."* B.0.1's two readers ran
it, on §3.3's seal passage. **Both reconstructed author, freeze point, blind
direction, scorer and residue identically**, both located the same governing
passage, and both independently flagged the same two residues — the opening
line's withdrawn phrase and the *seeded seat* slip in B.1. **The test passes**,
and the two residues it surfaced are repaired in this edition. `[B.10·8]`

**B.0.3 — the fifth edition's carried-forward condition, now returned.** *That
edition was written single-seat, by the sponsor's own direction, with no council
preceding it. That was a fact about it and not a defence of it: **the seat that
chose the repairs was the seat that judged whether they were the right
repairs**, which is §5.7's root class at the document level. The condition below
is what came back, and it did not confine itself to the questions the condition
asked — which is the strongest thing that can be said for having scheduled it.*

| # | Condition | Owner (performs) | Commissioner | Due | Status |
|---|---|---|---|---|---|
| **B.0.3** | **Council rounds four and five audit the fifth edition under the full process** — specifically: whether the dedupe removed anything load-bearing; whether the demoted provenance is fully recoverable from the annex rows the pointers name; whether the seam column measures what it claims; and whether the sentinel census is complete. | a council — independent reviewers, none of whom wrote this | the sponsor, relayed by the orchestrator, on that edition's landing **2026-08-12** | before any sixth edition is drafted | **EXECUTED-WITH-ANCHORS, round four, 2026-08-12.** Eight reports plus a framework and a verdict, committed at `docs/reports/process-council/round-4/`. **No CRITICAL filed.** The self-counts were re-derived and reproduced to the digit — sentinel census, seam column across all 86 values, pointer count, reference population, seal population, self-test case count — and an independent enforcement-tier matrix over fourteen sampled `[MC]` claims found **zero false machine-enforcement claims**, which the chair recorded as the single most important negative result of the round. **The round's own scope was refused**: the verdict declined this row's four apparatus questions as the frame, on the ground that a condition pre-scoping its own audit is the author choosing its grader's questions. What it returned instead is the sixth edition's work order. Round five is now carried at **B.0.4**. |

**B.0.4 — the dated conditions the sixth edition carries forward, and they are
the first that gate a verdict rather than an edition.** The fourth council set
two, and set them as a **gate on any future FIT-at-unit-level** rather than as
homework for the next revision. Neither is a document edit, and this volume
records them so that a later reader can see whether they came due. *Note what
that changes: for five editions the conditions asked "is the document better?"
These ask "is the claim true?", and neither can be answered by writing.*

| # | Condition | Owner (performs) | Commissioner | Due | Status |
|---|---|---|---|---|---|
| **B.0.4a** | **Build the doc–shell drift check** — a test reading the core's §2.6 rule table against the shell's actual rule set and failing loudly when either moves. Named in three consecutive editions, built in none; the sixth edition does not build it either (**B.11**, refusal 2). | **this document's own seat** — the exporter holds both halves, the adopter holds one | the fourth council's verdict, on this edition's landing **2026-08-12** | **before any unit-level replication claim is certified** — the gate the verdict set, replacing the fifth edition's *before any sixth edition is drafted*, which came and went | **OPEN — CONDITION, and now four editions old** |
| **B.0.4b** | **One with-shell, alien-domain adoption run**, executed by a party **not commissioned by this orchestrator**, with its halt log returned through the federation inbox. | an external adopter | the fourth council's verdict | **before any unit-level replication claim is certified** | **OPEN — CONDITION.** Both executed runs to date happened in worlds that could not reach the shell, so the only tested path is the one no adopter with network access will take. This is the condition that makes the tested world the real one. |

*Why these two and not a sixth-edition audit.* The council's own reasoning,
which this volume records rather than paraphrases into something more
comfortable: **the constraint has not been the prose for two editions.** Three
of its five advisors argued that no further document round was the right
answer at all, and the verdict sequenced rather than chose — determinism first,
the split second, and then *stop editing and go test the claim*. A seventh
edition commissioned to polish prose would be this program spending its budget
where it has already been measured to have the least left to gain.

### B.1 — Confirmations this edition owes

The document describes other seats'
disciplines in the specification lead's words. Each seat confirms the description
of its own discipline; the round runs before the next review of this text.

| Text | Owes confirmation from | On what | Status |
|---|---|---|---|
| §3.9 whole, incl. the seeder seating in §1.5 and the per-artifact placement | **auditor** | that the manifest-authoring reading of its scope is stated correctly, and that the placement and separations match its practice | **CONFIRMED** `J-auditor-0025`, with six MINOR findings |
| §3.9 scoring block and its three rebuilt exhibits | **dv_lead** | that the rebuilt referents say what the rulings say, and that no exhibit misstates a campaign | **CONFIRMED** `J-dv_lead-0190`, with two corrections and two precisions |
| §3.8 sign-off form; §4.3 relay classes | **dv_lead** | that the described form matches the one sign-off in the record — and, added after the answer and marked as such, that §4.3's classification and its two rules match the practice this seat exercises and polices | **CONFIRMED** `J-dv_lead-0190`, with two corrections, one of them the ship-blocker below |
| §2.6 rule table incl. the new *enforced where* column and the two added rules | **orchestrator** | that the surface attribution is right for every row | owed |
| §2.1 commit handoff description (steps 1–5) | **orchestrator** | that this is what the committing seat actually does | owed |
| §1.7 genesis sequence | **orchestrator**, **auditor** | the founding sequence and the retro-audit's self-description | auditor half **CONFIRMED** `J-auditor-0025`; orchestrator half owed |
| §6.0 kit table | **orchestrator** | that each named original exists where the table says, and the shell's stated contents | owed |
| Every `[MC]`, `[RE]`, `[P1]`, `[PLANNED]` stamp | **auditor** | transcription fidelity against its own posture list | **CENSUSED** `J-auditor-0025`: 135 stamp occurrences against 128 rows, all 26 dated stamps re-anchored; three defects, all cured in the correction round |
| **The whole text, read cold — one row per edition, standing** | **a reader with no session context, no participation in any round, and access to this document only** | that the terms it uses are inferable from the text, that its sections are reachable from its contents, that a first reader can follow it without the edition it corrects, and that a stranger can locate every artifact it cites | **edition 2: NOT RUN** — the confirmation matrix carried auditor, verification-lead and orchestrator rows and no cold reader, and the four dialect terms of *The dialect*, the unnamed shell and the unlocated posture list are what that omission cost. **edition 3: NOT RUN** — skipped a second consecutive time; the round-3 council's cold- and hostile-lensed readers independently returned the cold-open failure, the six-entry contents and the absent reading paths, which the chair recorded as *what this row would have returned*. **edition 4: RUN, and run twice** — two independent cold readers, reports at `round-3/cold-reader-A.md` and `…/cold-reader-B.md`, grades and consequences at **B.0.1**. Three consecutive editions carried this row unrun; the fourth is the first that paid it. **edition 5: RUN** — the round-four council seated a cold-reading lens, reading the full 5,446 lines and nothing else; its report is at `docs/reports/process-council/round-4/charlie.md`. It returned the structural verdict the row exists to catch — *the current law is not extractable without processing five editions of archaeology* — plus the count-over-non-matching-list cluster, the undefined *seat*, and the countersignature's missing artifact form. **Every one of those is repaired in the sixth edition**, and the first of them is what the split is. **edition 6: owed**, and the row stands: a split is exactly the kind of change whose readability gain only an outsider can measure, and the seat that performed it cannot. |
| §3.3's rewritten seal passage — author, freeze point, blind direction, scorer, the withdrawn rule and the four constraints | **verification lead** (the scored seat, whose practice it now describes) and **auditor** (the seeding seat, whose blinding it states) | that the mechanism is stated as both seats actually operate it, and that the residue is named neither too strongly nor too weakly | owed from both seats — but **the acceptance test on the passage has now passed**: two independent cold readers reconstructed the mechanism identically, including the blind's direction (**B.0.1**). A passed reconstruction test is evidence that the passage is *unambiguous*; it is not the confirmation of *accuracy* that the two seats it describes still owe, and the row stays open until they answer |
| §1.1's summed compensating-control table and its cadence-owner statement | **auditor** (the intervals are its charter's) and **orchestrator** (the spawner the statement names) | that every "how often" cell is right, and that the cadence-ownership reading is one the spawning seat recognizes rather than one this document assigned it | owed |
| §1.3's nine charter sections | **orchestrator** (owns the charter directory and the exported template) | that the nine are the nine, and that the kit's template generates all of them | owed |
| §6.0's pin — facsimile provenance, the dated shell observation, and the refusal to assert the shell's current contents | **orchestrator** (performed the transit the observation comes from) | that `2ad82c3` and its date are what the transit recorded, and that no later shell observation exists in this repository | owed |

*Why that last row is standing rather than one-off, and it is the most portable
thing in this annex.* An edition **corrects what insiders can see** — accuracy,
postures, counts — and **regenerates what only outsiders can see**: new
vocabulary, new forward references, new artifacts cited by names only the author
can resolve. The second edition swapped the outsider out of its own quality
check and then invented a dialect. **Cold-readability is a per-edition
measurement, and this edition treated it as a fixture.** Any confirmation matrix
staffed entirely by seats whose own disciplines are being described is measuring
one axis and calling it review. `[B.8·25]`

*What the two confirmation rounds returned, since a confirmation that returns
nothing is a signature and not a check.* **Sixteen filed items** — four
corrections and six routed recommendations from the verification lead, six
findings from the auditor, all six MINOR — plus three referents the auditor would
have carried and one figure the committing seat found repeated in a second place.
**All twenty were applied; none was declined.** Every applied one lands as a
repair of a **running line**, with the superseded text preserved beside it and
the confirming seat named. Two are worth naming here. The
**ship-blocker** was an omission rather than an error: the external-anchor
separation, constitutional and executed in the one sign-off, appeared **nowhere**
in this document — §3.8 therefore exported a sign-off form under which an
unanchored oracle may grade an artifact. It is now §1.4(e), an element of §3.8's
list, and a line of §6.1. And **both** confirming seats independently returned the
same correction on the same exhibit — §3.9's survivor — each reading it as
describing an incident this record does not contain; the anticipated disagreement
between them did not exist, and one written round settled it.

*Two claims in the **third** edition have no posture row*, both added by the
round above after the posture list was measured: §1.4(e) and the anchor element
in §3.8's list. They are marked in place, their posture is stated in prose, and
they are owed rows at the next audit. **The fourth edition adds more, and does
not count them here**: every claim it added is marked *(no posture row)* in
place and enumerated by site at **B.9**, and the whole of the unmeasured
surface is what the boundary block in *Read this first* is about — a running
count in this annex would be a second, decaying copy of it.
*(**SUPERSEDED — historical record, not current law:** the sentence said "this edition" and would have been
false the moment an edition succeeded it, which is the decay class §5.1
names.)* *Two existing rows have referents that grew after they were measured*,
which changes no posture and is recorded so a later reader does not mistake the
row for the text: `C-104` was measured over thirteen scoring bullets and the
block now carries fifteen, and `C-94` was measured against a §3.8 element list
that has since gained the anchor element. Both rows belong to the auditor and
are its to re-measure.

### B.2 — Routed, not performed here

Each is an edit to a file outside the
specification lead's write scope, or an amendment requiring its own instrument.
They are named so the debt is countable; none is applied in this edition.

1. **The constitution's own honesty note on one-agent-per-commit** carries the
   same false disjointness premise corrected at §2.1 (`PROTOCOL` §5 R1). Amendment
   candidate; joins the next §11 batch.
2. **The constitution's gate clause** states that signers cannot stage the gate
   directory *because scopes forbid it* (`PROTOCOL` §7) — the same false premise
   corrected at §3.7, found in the fourth edition's round. Amendment candidate,
   same batch.
3. **Narrowing the specification lead's scope** to carve out `docs/gates/**` in
   `scripts/policy.sh`, which would convert §3.7's convention into a refusal.
   Orchestrator scope; option, not recommendation — the residue declaration is
   live either way.
4. **`F-0022-2`'s one-word cure** (the singular *killing unit* against a record of
   plural killing units) remains stopped and owed, as recorded in the round that
   stopped it; it joins the same amendment batch, and §3.9's third exhibit is its
   anonymized form.
5. **Two cures the auditor filed against its own artifact** at `J-auditor-0025`,
   recorded here because this document cites that artifact on every stamp and a
   debt is only enforceable where a later reader is obliged to see it (§5.5).
   Row `C-126`'s evidence cell states "12 FALSE and 4 PLANNED" against a recount
   of 15 and 8; row `C-117`'s anchor points at an entry whose *sixth* item is the
   sixth check of a countersignature rather than the sixth cure of a cure basket,
   a text-similarity match the row's author says it did not falsify at the time —
   **the stamp in this document is correct and the row's anchor is wrong.** Both
   cures are **appended dated notes, never rewritten cells**, by §5.4's own rule
   and by the precedent §1.7 cites; and both are the auditor's to make, in the
   auditor's scope.

   **PERFORMED, and this row was stale when it said "named, not performed."**
   `[B.11·19]` The auditor appended both notes to the posture list at `22c60fb`
   — one of the sibling landings the fifth edition declared and deliberately did
   not read — in exactly the idiom prescribed: appended dated notes, no
   rewritten cells. An independent audit of the fifth edition confirmed it, and
   confirmed the other half too: those appended notes state in terms that they
   **do not re-measure the list**, so **item 8's debt remains genuinely open**.
   The fifth edition's self-imposed blindness was therefore *accurate in both
   directions* — item 5's cells were stale by one landing and item 8's were not
   — which is the strongest available evidence that a declared blind spot is
   worth more than a guess, and the reason the discipline is kept rather than
   traded for the convenience of reading the file.
6. **The relay-fidelity sampling instrument of §4.3 (`C-109`)** stays owed and is
   listed here as well as stamped there, because it is the one instrument whose
   absence was argued about in the confirmation round: two receiving-seat checks
   have fired and neither is the sampling duty. A control that has a partial
   substitute is the kind most likely to be quietly written off.
7. **Binding the constitution's own amendment clause to this document** — the
   rule §2.7 now states for the specification lead (an amendment altering
   enforcement semantics obliges a re-edition of the process description or a
   logged waiver) belongs in `PROTOCOL` §11, where it would bind every seat and
   not only this document's author. Amendment candidate; joins the same batch as
   items 1 and 2. **Filed in the fourth edition, applied nowhere:** enacting it
   here
   would be a document declaring a constitutional duty for seats that never
   agreed to it, which is §3.7's checklist-amending-the-constitution defect run
   from the other end.
8. **The re-measurement of the posture list against the grown document.** The
   list measured 1,445 lines; the core is now **4,919 lines, about three and a
   half times that**, and the boundary block in *Read this first* carries that
   figure and re-measures it in every act that moves it. *(This cell said
   "nearly three times" against a preamble saying "about three and a half" —
   two live figures for one measurement, in the passage governing the
   evidentiary boundary itself. Reconciled at the sixth edition;
   the core's boundary block is the canonical statement and this cell points
   at it.)* `[B.11·20]` The re-measurement — new rows for every claim
   added since, and a re-execution of the existing ones against the current
   machinery — is the **auditor's**, in the auditor's own artifact and scope.
   Named here because this document cites that artifact on every stamp and a
   debt is only enforceable where a later reader is obliged to see it (§5.5).
   Not performed here, and **not touched**: an author who edits the measurement
   that grades its own document is §5.7's root class in one act.

   *And a fact this edition can state about that artifact without opening it,
   because leaving it silent would be worse.* **The posture list changed during
   this round**, in its owner's own lane, landing at `22c60fb` — 162 lines
   added, a figure taken from the commit's file statistics and not from its
   contents. **This seat did not read it, then or now**, so this document cannot
   say whether the re-measurement is discharged, partly discharged or untouched
   by that landing, and it does not guess. Two consequences, stated rather than
   absorbed: every *"owed"* cell about this artifact in §1.1's table and in this
   annex is **true as this seat last read the record and may be stale by one
   landing**; and the party that can close the question is the artifact's owner,
   not this document. **A document that cites an artifact it refuses to read
   owes its reader the date of the refusal, not a claim about the contents.**
9. **The doc–shell drift check** (§6.0) is owed by **this document's own seat**,
   not by an adopter — the reassignment was made in the third edition and the
   instrument still does not exist. **Closing event, unchanged and now dated:** a
   test that reads this document's §2.6 rule table and the shell's rule set and
   fails on disagreement, landing in whichever of the two repositories can run
   it — **owed before any sixth edition is drafted**, which is the first due date
   this item has ever carried. Until it exists, every `FACSIMILE` block in this
   document is an unverified claim about another repository, and §6.0's pin says
   so in terms. **Named in three consecutive editions and built in none; it is
   the oldest unpaid item in this annex.**

   *Margin — the grading this debt drew, quoted rather than paraphrased.* An
   external grading of the fourth edition scored debt management **B+**, with
   its reason attached: *"Annex B's ledger→schedule conversion is the right
   move; undercut by the drift check being named in two editions and built in
   neither."*
   (`docs/reports/process-council/sponsor-report-card-2026-08-12.md`.) The
   hazard the grade names is the one this seat's own round-3 return had already
   stated against itself: **a named debt can substitute for the repair, and an
   annex that converts naming into scheduling has moved the substitution one
   level up rather than removed it.** This edition does not build the check
   (**B.10**, refusal 2), so the quotation stands beside the debt as the
   strongest thing available: an outside reader's sentence, unedited, in the
   ledger row it convicts. `[B.10·7]`
10. **Binding a charter's cadence to the seat that spawns it** (§1.1's summed
    residue). Every interval in the review-enforced tier lives in the auditor's
    charter, and a duty phrased *once per phase* is dischargeable only in a round
    somebody commissions — so the interval belongs to the spawning seat and is
    presently written where it cannot fire. Amendment candidate; joins the batch
    with items 1, 2 and 7. Closing event: a constitutional clause or an
    orchestrator-charter duty naming the spawn cadence for each routed control,
    at which point §1.1's table acquires a "next due" column instead of a
    "how often" one. **Filed in the fourth edition, applied nowhere** — enacting
    it
    here would bind a seat that never agreed to it.
11. **The packet-type minting rule** (§3's blockquote). Proposed by this
    document and stated in no binding artifact of this program: the constitution
    defines four types and no minting route, and every extension form in the
    record was minted by use. Amendment candidate, same batch. Closing event: a
    numbered decision record naming the route and accepted by a seat that did not
    propose it — after which §3's blockquote takes a posture and stops being a
    proposal. Until then the blockquote carries the marker and binds nobody.
    *(Filed in the fourth edition, on an independent record audit's finding.)*
12. **Scoring a seeded-defect campaign by the independent seat rather than by
    the seat that froze the seal** (§3.3). The blind runs against the seeder and
    is discharged the moment every diff is committed, so the seeder could score
    the campaign afterwards against the frozen seal without any loss of
    blinding — converting §3.3's named residue into a real separation. **Option,
    not recommendation**: it costs a round of the most oversubscribed seat in the
    program (§1.1), and the four constraints §3.3 names are doing real work
    meanwhile. It belongs to the seats that would carry it. Closing event: either
    an amendment routing the scoring act, or a recorded refusal with grounds —
    **both are outcomes; silence is not.**
13. **The constitution's transient-mutation clause is false against the record,
    and until this edition it was the only disclosed constitutional falsehood
    with no route.** `[B.11·21]` `PROTOCOL` §10 still prescribes that the
    operating seat *applies each manifest transiently in an uncommitted working
    tree, runs the suite against it, reverts fully* — while **every campaign in
    this record ran as commits pushed to marked references that are never
    merged**, for the substrate reason Annex A.6 gives: the only environment
    that can run the suite runs on pushed references, so there is no local run
    to revert. The core's §3.9 has acknowledged the divergence for four editions
    **and never routed it**, while routing the two directly analogous false
    constitutional premises as items 1 and 2 of this list. By §5.5's own law — a
    routing rule is enforced by a named owner, a named triggering event and a
    visible debt — a disclosed-but-unrouted falsehood is routed to nobody.
    **Owner: the orchestrator**, whose file it is. **Amendment candidate, joining
    the batch with items 1, 2, 7 and 10. Closing event:** a numbered decision
    record amending §10 to the pushed-reference model with the substrate fact
    stated as its ground, accepted by a seat that did not propose it. *Filed by
    the fourth council's record audit; routed here rather than performed,
    because the constitution is not this seat's file to stage.*
14. **The kit's packet-forms original still teaches the ratio the constitution
    outlaws.** `[B.11·22]` The core's §6.0 kit table points an adopter at this
    program's packet-form skeletons as the original of "the packet forms". The
    sign-off skeleton there demands **`Mutation kills: N/N`** — the pre-amendment
    form that `PROTOCOL` §7(b.2) now forbids in terms (*no ratio stands in for
    the dispositions*, *no `N/N` figure is read as coverage*) and that the one
    sign-off in this record deliberately refused to produce, reporting five
    columns instead. **An adopter pulling the named original inherits a template
    whose first use commits the thing the constitution beside it prohibits.**
    This is §2.4's *a rule and its check that disagree* living inside the export
    unit's own kit row. **Repaired in the core**, whose §3 packet facsimile now
    prints the lawful disposition block; **routed for the original**, which is a
    packet-directory file and inside this seat's standing write scope but
    **outside this round's declared scope** — the honest disposition is a
    refusal with grounds (§4.8), not a quiet widening of the round. **Owner:
    this seat. Closing event:** the skeleton's disposition line replaced with
    the itemized form, in a round commissioned for it.
15. **The shell's core-plus-domain-pack refactor**, which converts the export
    unit's one materially false sentence into its architecture. `[B.11·23]` The
    core's §6.0 now states the true sentence — the shell is FPGA-generic, not
    domain-free — with a file-by-file inventory of which kit surfaces carry
    domain load. The **repair** the inventory implies is the one the fourth
    council's expansionist lens connected and no auditor had: **§3.10's domain
    packs are already this document's own taxonomy for exactly this**, so the
    shell splits into a general core plus an FPGA pack, making every later
    domain an additive pack rather than a fork. **Owner: the shell's
    maintainer**, not this seat and not this repository. **Closing event:** a
    shell release whose core carries no domain noun and whose FPGA surfaces are
    a named pack — at which point §6.0's sentence changes again, in the other
    direction, and this row closes.
16. **A per-seat index of the charter clauses the core relies on elsewhere.**
    `[B.11·24]` The core exports the auditor's charter mechanisms in prose and
    routes the artifact to the kit, which is the right split. But it leans on
    charter-carried duties of **other** seats that neither §1.3's nine-section
    list nor any facsimile regenerates — the anchor-ordering precondition named
    as living in the verification lead's charter, the *report, never repair a
    suspected seeded defect* clause named as living in the builder charters.
    An adopter authoring charters at act 1c from §1.3's list alone puts none of
    them in. **The repair is not more charter prose** — it is an index: one row
    per seat, naming every clause this document relies on that seat's charter to
    carry, so completeness is checkable at the act that writes them. **Owner:
    this seat. Closing event:** the index landing in the core's §1.3 or as a kit
    row. *Filed by the fourth council's adoption lens.*

### B.3 — Instruments named in the text and not in force

`ADR-0021` is
**PROPOSED** at `287b5ee` and its route completes per subject. Subject 1
(`WARN-STAMP`, both surfaces) is the instrument named at §2.4(b) and §5.1's
corollary; subject 2 (the journal-size limb on the pushed-history surface) is the
instrument named at §2.2, §2.5 and §2.6. **When and only when those land, rows
C-56, C-46, C-55, C-54 and C-119 change posture — by a later act, on a later
commit.** No stamp in this edition anticipates them.

### B.4 — Exhibits owed an anchor or a removal

§1.4(d)'s residual-risk routing
and the identical first disguise in §5.7 (`C-24`, NOT SAMPLED); the incident
behind §5.7's third disguise. Both are kept, marked, and owed.

### B.5 — A discrepancy in the fourth edition's own source, resolved

The posture list's summary table and its
collected-false table both give **15 FALSE and 8 PLANNED** of 127 rows; the
evidence cell of row `C-126` states "12 FALSE and 4 PLANNED". This edition used
the summary figures, which the row-by-row tables support, and recorded the
disagreement rather than silently averaging it, per §4.3's rule that the
receiving seat checks the source rather than reasoning from the relay.

*Resolved for 15 and 8*, by the seat that owns the artifact and against its own
cell: a mechanical recount, posture cell by posture cell, over all 128 rows,
agreeing with the summary table, the per-section table, the collected-FALSE table
and the PLANNED table, with the row-total identity closing at 128. The wrong
figure is in the auditor's own row and its cure is an **appended dated note**
(B.2, item 5) — not an edited cell, because the record already names in-place
correction by an author as a weakness of exactly this artifact class (§1.7, §5.4).
The provenance of "12/4" could not be established and is not reconstructed; the
seat that could not find it said so rather than inventing one. **The general form
is the part to carry: a discrepancy between a document and its source is resolved
by the source's owner, in the source's own idiom of correction, and the copy
records the resolution rather than performing it.**

### B.6 — Debts this document still owes its own process

It has never been
through the packet lifecycle it describes: the first edition landed with no work
order and no countersignature (`C-20`), and every revision since — including
this one — was commissioned dispatch-only (`C-70`), an instance of the class it
names in §3. The countersignature round of B.1 is the first half of the repair;
a review verdict recorded as a packet would be the second. And the drift check
between this document's §2.6 table and the shell's rule set (§6.0) does not
exist.

*And what the fourth edition added to that count.* A **third council** read the
third edition and returned six blocking revisions with acceptance tests; the
fourth edition was written from that verdict. That brought the anchor count to
three, and the pattern held in the direction that matters: **the anchor moved on
contact every time.** Its two dated conditions (**B.0**) were the first time the
document scheduled its own external checks rather than recording that it owed
them.

*And what the fifth edition adds, including the part against its own interest.*
Three further external anchors landed before it: **two independent cold readers**
of the fourth edition, **a second cold adoption run**, and **a sponsor-relayed
external grading** produced by a party outside this organization (**B.0**,
**B.10**). Six anchors now, and the pattern still holds: **the anchor moved on
contact every time.** What did not change is this edition's largest single
exposure, stated here rather than left to be found: **it was written single-seat,
by the sponsor's own direction, with no council preceding it**, so the seat that
chose the repairs is the seat that judged whether they were the right repairs —
§5.7's root class at the document level, disclosed and scheduled for audit at
**B.0.3** rather than removed. Unchanged besides: no packet, no lifecycle, no
countersignature on this revision either; it too was commissioned
dispatch-only.

*What changed in the third edition, and what did not.* The document acquired its
**first two external anchors**, which is the thing §1.4(e) demands of anything
that grades and which this document had never had: a **council** — eight
independent readers, hostile and cold, none of whom wrote it, adjudicated into
one verdict with conditions — and an **executed adoption run** by a seat that
did not author it, in a clean world, whose eighteen halts were the third
edition's work order. Both are the evidence form this document teaches: *an attempt that
bounced, cited by identifier.* **The anchor moved on first contact both times.**
What did not change: no packet, no lifecycle, no countersignature on this
revision; the confirmations of B.1 remain the only signatures this text has ever
carried, and they are confirmations of *description*, by seats describing their
own disciplines. **A document about independence whose only reviewers are the
parties it describes is still, at this edition, its own weakest exhibit** — and
the correct reading of the two anchors is that they raise the floor and close
nothing.

### B.7 — The correction round, item by item

Every item the two confirmations
filed, where it landed, and its disposition. It is here rather than in the
margins because the margins name the *correcting seat* by function, as the rest
of the document does, and a finding identifier is a program noun. Nothing below
was refused; where a repair went further than the item asked, the row says so.

| Item | Filed by | Landed at | Disposition |
|---|---|---|---|
| `F-0025-A` | auditor | §2.4 corollary | Applied. Stamp date 2026-08-04 → **2026-08-03**, re-anchored to the mirroring commit; the superseded date is kept in the margin beside it. |
| `F-0025-B` | auditor | §5.7 disguise list | Applied. `[P1 · C-125]` → `[P1 · 2026-08-11 · C-125]`, the date being the anchoring measurement's own; the omission is named where it happened. |
| `F-0025-C` | auditor | §1.6 index bullet | Applied. The correction moves into the **running line**; the first edition's claim stays in the margin. Extended beyond the item: the margin now states the general rule a `[CORRECTED]` marker implies. |
| `F-0025-D` | auditor | §3.9 margin | Applied. *"some ninety"* → **eighty-six** references, fifteen campaign prefixes, two probes, **none merged**, re-measured at this revision's own commit. Extended: the reference/campaign/class distinction is stated, because this is the section that rules a reference population cannot be a denominator. |
| — second instance of the same figure | committing seat, mid-round | §2.6 branch topology | Applied. Same measurement, same cure. Recorded because a round that repairs one instance of a figure and passes another has repaired nothing. |
| `F-0025-E` **and** `J-dv_lead-0190` correction 1 | auditor **and** dv_lead, independently | §3.9 exhibit 2 | Applied as one repair. Both seats read the exhibit as describing an incident this record does not contain; the anticipated disagreement between them did not exist. The exhibit is rebuilt on the filed hazard — a rehabilitation expires when the bench moves — and keeps every element of the evidence form. |
| `F-0025-F` | auditor | §1.5 canary clause, and the sponsor guide itself | Applied **in the source**, not rowed as a debt: the guide is inside the specification lead's write scope, the contradiction was live in the document its own audience reads, and routing a cure one can perform is how a copy stays corrected while a source stays wrong. |
| `J-dv_lead-0190` correction 2 | dv_lead | §3.9 frozen-kill bullet | Applied. One disclosed limit → **three**, with which were disclosed and which were found by applying the clause. |
| `J-dv_lead-0190` correction 3 | dv_lead | §1.4(e); §3.8 element list; §1.2; §6.1 | Applied — the round's ship-blocker, and an omission rather than an error. Four sites, because a separation that exists only in the sign-off form is a separation an adopter will not build. |
| `J-dv_lead-0190` correction 4 | dv_lead | §4.3 exhibit | Applied. The false reassurance is dropped, the benign exhibit keeps its opening, and the marking rule and the source-check rule get the two exhibits they had never had. |
| Precision A (*"in the same round"*) | dv_lead | §3.9 exhibit 1; §5.2 | Applied at **both** accounts of the episode. A document that corrects one of its two tellings has manufactured a contradiction. |
| Precision B (the italicised qualifier) | dv_lead | §3.9 exhibit 1; §5.2 | Applied at both. The record's word is the single word. |
| Import-as-rules boundary | dv_lead | §3.9 import paragraph | Applied in the filer's own words: properties, not a reporting form; import the rules, re-derive the numbers. |
| §3.8 element list is a floor | dv_lead | §3.8 | Applied, and stated as a sentence rather than the four words asked for, because the stamped claim beside it reads at speed as a description of the packet. |
| Exhibit 3's second ground | dv_lead | §3.9 exhibit 3 | Applied. The stop was also **mechanically** refused, which is a different exhibit from a chosen refusal. |
| `C-109` precision | dv_lead | §4.3 | Applied. The owed instrument stays owed; two receiving-seat checks have fired; different control, different failure mode. |
| Three referents the auditor would have carried | auditor | §3.9 bullets | Applied. Which grounds turn on the seal's disclosure; what *survived its own campaign* means; the rehabilitation asymmetry under the frozen-kill limb. Filed as carried-forward observations rather than findings, and cheap enough that declining them would have been an economy against the reader. |

### B.8 — The third edition, item by item

The sources are a **council** — eight
independent reviewers of the second edition, adjudicated into one verdict of
*pass with conditions* in four tiers — and the **adoption run** those conditions
demanded be performed first: one cold adopter, one day, this document alone in
an empty repository, executing §6.2 literally and logging a halt at every
under-determination. Eighteen halts, three of them stops. Its log is committed
at `docs/reports/process-council/round-2/adoption-run-halt-log.md`, beside the
verdict and the eight reports.

*The rule this table obeys, which is the same one B.7 obeyed:* every applied
change lands as a repair of a **running line**, with the superseded text
preserved beside it, and every change carries the condition or the halt that
produced it. **Nothing below was applied because it seemed better.**

| # | Item and source | Landed at | Disposition |
|---|---|---|---|
| 1 | **Tier 1** · the false limb about the amendment machinery — *"owed test cases still unapplied"*, refuted by execution against the suite that counts them | §2.7 | **Applied.** Limb deleted, surviving limb (constitutional diffs unapplied) stated alone, the false half preserved in the margin with what refuted it. |
| 2 | **Tier 1** · the sponsor's fifth standing power, and *"completely enumerated"* over an incomplete list | §4.7, §3.10 | **Applied at both sites.** The power is added, the harvest section acquires the sponsor it had omitted entirely, and the quantifier becomes *complete as of this edition, closed by amendment*. |
| 3 | **Tier 1** · *"the taxonomy is closed, and this is it"* | §3 | **Applied.** Replaced by the closure **rule** — who may mint a type, by what route. Practiced extensions (transit, adjudication companion, reading note, campaign packet) and practiced states (executed, closed, re-issued, unsealed, letter-split) named as unrouted, per §3.2's own ghost-nouns instruction. |
| 4 | **Tier 1** · §4.3's protected classes omit sealed predictions, which §3's table marks Verbatim | §4.3 | **Applied**, with the extra rule the reconciliation needs: before unsealing, a seal is not relayed at all. |
| 5 | **Tier 1** · *"kept deliberately frozen"* against a shell found thirty-one commits ahead; the federation transit missing from the chapter about exporting | §6.0 | **Applied.** The freeze claim was never a property of the shell but a rule for this program's writes into it. The transit is described in four steps, including *no privileged lane for the origin*. |
| 6 | **Tier 1** · the stamp-coverage claims — *"the one place"*, *"exactly two"* | *Read this first* | **Applied**, as the boundary block: the stamps measured 1,445 lines, the document is now nearly three times that, well over half is unmeasured, and there is no visible seam. This is the council's sharpest catch and the one no auditor made. |
| 7 | **Tier 2**, **HALT-01** · the shell is never named | §6.0 | **Applied.** Named, with its repository and location, as a deliberate program noun. The run's most expensive halt: this omission converted Steps 0, 2, 4 and half of 5 from *adopt and verify* into *reconstruct from prose*. |
| 8 | **Tier 2** · the posture list has no path, no kit row; the fifth enforcement script is named nowhere | §6.0, *Read this first*, §2.2 | **Applied.** Three kit rows added — the chain verifier, the posture list with its path, the anonymized auditor charter. |
| 9 | **Tier 2** · no edition anchor | document head | **Applied.** Edition, date and commit-bearing line, with the explicit statement that no stamp in this edition has been re-measured. |
| 10 | **Tier 2**, **HALT-05** · §6.2's order contradicts §1.7 and the founding record, and manufactured ungated founding history when executed | §6.2 | **Applied.** Machinery first, adversarial review second, platform third. The founding-commit paradox (the commit that introduces the gate cannot pass it) is stated with its honest handling, so no literal executor needs the baseline exemption the source forbids. |
| 11 | **Tier 2**, council · the platform sequencing facts dropped in export | §6.2 Step 3, Annex A.5 | **Applied at both.** Rulesets rather than classic protection; the required-check picker is empty until the check has run once — which is *why* the step moved. |
| 12 | **Tier 2**, **HALT-10** · the DoD's uncomputable case-count equation | §6.2 | **Applied by replacement.** *Runs green from a clean clone, at least one case per numbered rule, verified by reading the suite* — with the counting rule stated (thirteen rows, eleven numbers, cases ≠ rows). |
| 13 | **Tier 3**, **HALT-06** · not one literal grammar in a document promising mechanism | §2.1, §2.2, §2.3, §2.6, §3, §3.1, §3.3, §3.9, §6.2 | **Applied** as the placement rule plus nine marked facsimiles: trailer block and protected keys, volume header, scope-table row, rule-id column, packet skeleton and id/path templates, entry header and spawn token, seal state line, marked-reference prefix, residue row. Each labelled *instance, not norm*; the shell remains the normative source. |
| 14 | **Tier 3**, **HALT-07** · a threshold the text calls *stated* and never states | §2.6, Annex A.7 | **Applied.** 1,000,000 bytes, journals carved out, with its anchor. |
| 15 | **Tier 3**, **HALT-10** · rules *"numbered and cited by number"*, no numbering printed | §2.6 | **Applied.** Id column, with the three things it makes visible — the row/number mismatch, cases-are-not-rows, and the one rule no self-test case can exist for. |
| 16 | **Tier 3** · the doc–shell drift check assigned to the adopter | §6.0, B.2 item 9 | **Applied by reassignment.** Named as the owed instrument binding the two halves, `[PLANNED]`, owed by **this document's seat**: the exporter holds both halves and the adopter holds one. |
| 17 | **Tier 3** · the DV-escape ledger absent | §1.5 item 5, §3.8 | **Applied at both.** A fifth structural distinction of the auditor, and the sign-off's necessary companion. |
| 18 | **Tier 3** · model-tier allocation absent | §1.2, Annex A.8 | **Applied.** The invariant — *the reviewing tier is at least the producing tier* — in §1.2; the tiers and their price as a substrate parameter in the annex. |
| 19 | **Tier 3** · the contingent-seat and mid-life onboarding patterns absent | §1.2, §2.2 | **Applied.** Chartered-and-dormant with a named activation trigger; and onboarding as one act — charter, scope row, launcher, seed — landing together. |
| 20 | **Tier 3** · an auditor-charter skeleton for the kit | §1.5, §6.0 | **Applied in the split form, and the split is a judgement — see the refusals below.** The *mechanisms* in prose here; the *skeleton* as a kit row. |
| 21 | **Tier 3** · errata occupying the structural position of the plain rule | §1.1, §1.4, §3.9 exhibit 2, §5.5 | **Applied.** Rule first, archaeology behind it, at all four named sites. §5.5's count additionally acquires the boundary it needed — *labelled* declarations — since a count is only as good as its definition. |
| 22 | **Tier 3** · four undefined terms of this edition's own coinage | *The dialect* | **Applied.** council, census, surface, margin — with the reason they existed: cold-readability is a per-edition measurement that was run once and treated as a fixture. |
| 23 | **Tier 3** · the fork contract | §6.1 | **Applied** as a per-mark table: strip or re-anchor, one act per stamp class, with the rule underneath — *a fork inherits the rules and the reasons, and inherits no measurement.* |
| 24 | **Tier 4** · bind this document into the amendment procedure | §2.7 | **Applied for this seat; routed for the constitution** (B.2 item 7). An amendment altering enforcement semantics now obliges a re-edition or a logged waiver, owned by the specification lead. The waiver limb is deliberate: a duty dischargeable only by editing three thousand lines is discharged by not invoking it. |
| 25 | **Tier 4** · a per-edition cold-reader row | B.1 | **Applied**, standing rather than one-off, with edition 2 recorded as **NOT RUN** and edition 3 as owed. |
| 26 | **Tier 4** · §6.2 stamped performed, dated, by whom | §6.2 | **Applied.** `[P1 · 2026-08-11/12]`, no posture row, citing the halt log — and every step now carries the halts it was rewritten from. |
| 27 | **HALT-18** · the `C-09`/`C-67` posture contradiction met at the adopter's trace | §1.1 | **Applied by limb split, re-executed rather than quoted.** Merge triviality and octopus refusal are machine-held on the pushed-history surface; one-branch, no-rebase and no-force-push are held by the platform and by no script anywhere — verified this round by reading every enforcement script. §2.6's row was the true side; §1.1's compound sentence was the wrong one. |
| 28 | **HALT-14/15/16** · the definition of done is formally unsatisfiable for a solo adopter, and the document was silent | §6.2 Step 5 | **Applied.** What a solo adopter *can* do — found self-signed, gate rows open, limitation declared — stated in the adopter's own framing: the open gate is the honest result. Both evasions (self-signing as sponsor; staging a fictional independent seat) are foreclosed by name. |
| 29 | **HALT-02** · the residue list is demanded before it can exist, with no form and no cadence values | §6.2 DoD | **Applied.** A residue-row facsimile, opened at Step 0 with routing columns empty and filled at Step 2. |
| 30 | **HALT-03** · the sponsor has no journal, while every gate signature must reference one | §4.7 | **Applied.** The practised form — the act happens outside, the orchestrator transcribes, the authority is the transcriber's own entry — with its residue named. |
| 31 | **HALT-04** · three independent lenses with one actor | §6.2 Step 2 | **Applied** as the declared-fiction pattern: write all three, declare the non-independence inside the artifact, file it as a critical finding against your own founding. |
| 32 | **HALT-08/09** · no platform, no continuous integration, in the adopter's world | Annex A.6b | **Applied** as a new substrate parameter, including what a local stand-in does and does not buy, in the adopter's own terms. |
| 33 | **HALT-11** · a self-test case for a rule with no script | §6.2 Step 4 | **Applied.** Do not invent an instrument to satisfy a count; record the case as discharged by the live-fire bounce and say so in the suite. |
| 34 | **HALT-12** · no step of the order authors the constitution the later steps quote | §6.2 Steps 4–5 | **Applied minimally** — the constitution template is added to Step 4's kit line, where the amendment binding first needs it. *This is the thinnest repair in the table and it is named as such:* the order still assumes the template rather than scheduling its authorship, and an adopter without the kit will still write a constitution backwards from the checklist that quotes it. Carried as owed. |
| 35 | council precision · *"the one that survived"* against §1.4(b)'s *"one of the claims"* | §1.5 item 1 | **Applied.** The singular is withdrawn rather than replaced with an unmeasured count. |
| 36 | council · *"the entire pushed history"* undelimited over the reference population | §2.5 | **Applied.** The re-check adjudicates the lineage and not the marked references; the gate binds what passes through it. The reconciliation the council had to assemble is now in the text. |
| 37 | council (F9) · the chain claim *"re-verified on every commit and again over pushed history"* | §2.2 | **Applied by limb split**, re-executed against the scripts this round. Headers at rotation plus chain-wide ids locally; the full walk in the re-check and the standalone verifier. |

**Refusals and deferrals, with grounds — because a revision that records only
what it did is a revision nobody can audit** *(these are the third edition's;
the fourth edition's are at the end of B.9)*.

1. **The constitution's own amendment binding: ROUTED, not performed.** Enacting
   in this document a duty binding every seat would be §3.7's
   checklist-amending-the-constitution defect run from the other end. Amendment
   candidate, B.2 item 7.
2. **Re-measuring the posture list against the grown document: REFUSED as this
   seat's act.** It is the auditor's artifact and the auditor's scope, and an
   author who edits the measurement grading its own document is §5.7's root
   class in one act. The preamble states the coverage boundary instead; the
   re-measurement is rowed at B.2 item 8. **No line of that file was touched in
   this round.**
3. **The auditor-charter skeleton in-document: DECLINED in favour of a kit row
   plus mechanisms in prose.** Copying a normative artifact into the explaining
   half creates a second copy that drifts — the hazard §2.4 names one level up,
   and the same hazard that produced this edition's whole mechanism-placement
   rule. The mechanisms are exported because this document's own review-enforced
   postures rest on them; the artifact is exported once, where it runs.
4. **A subsection index for the Contents: DECLINED this round, with the ground
   stated rather than the omission left silent.** The defect is real — six
   entries over three thousand lines, with the sponsor's obligations, the gate
   rules and the adoption checklist all unreachable from the top. But a
   hand-maintained derived index is precisely the artifact §1.6 convicts: *an
   aid refreshed at boundaries decays exactly as fast as boundaries are rare,
   and a stale aid is worse than a missing one.* The right repair is an index
   derived mechanically at read time, or one carrying the date it was last true.
   That is a round of its own and it is named here so the debt is countable.
5. **The worker-role enumeration and the roster/program-state file formats
   (HALT-03's remaining half): ROUTED to the kit, not written here.** Role
   *names* are a program's own decomposition — enumerating this program's four
   would export a domain, and enumerating none is why the adopter invented four.
   The honest placement is a kit template with the roles left as slots. Named as
   owed; not applied in either direction this round.
6. **The adopter's own discovered gap — that their re-check does not re-verify
   the journal chain over pushed history: NOT ADOPTED as a defect of this
   document.** It is a finding against the adopter's machinery, and a true one
   of exactly the class §2.4's corollary names. What is applied is the general
   form, in the DoD: expect the trace to convict your machinery as well as this
   text, and leave what it finds open and declared rather than silently patched.
7. **Everything the council filed that the verdict did not make a condition, and
   this table does not list: NOT APPLIED.** The chairman's four tiers plus the
   halt log were the work order. Items outside them — the spawn-side mechanics
   of the loop, the countersignature's physical form, the canary's collision
   with the append-only gate, the self-acceptance edge when the orchestrator
   proposes its own instrument, an escalation threshold nobody states — are
   real, are named in the council's committed reports, and are **owed a
   round**. **A revision that quietly widens its own scope is a revision whose
   scope nobody can check.**

### B.9 — The fourth edition, item by item

The source is a **third council** —
a standards framework, three record-and-readability reviewers, five advisors
from declared seats, adjudicated by one chair into a verdict of
**description-grade for the document alone**, with six blocking revisions each
carrying a defect site and an acceptance test, a cheap non-blocking batch, an
explicit fence of things not to do, and two dated conditions. The verdict is
committed at `docs/reports/process-council/round-3/verdict.md`, beside the nine
reports it adjudicates.

*The rule this table obeys, unchanged from B.7 and B.8:* every applied change
lands as a repair of a **running line**, with the superseded text preserved
beside it, and every change carries the verdict item that produced it.
**Nothing below was applied because it seemed better.** Two things are new in
this edition's discipline: the verdict's items carried **acceptance tests**, so
each row below records the test's outcome rather than only the edit; and the
verdict fenced this edition explicitly, so the refusals below include things
this seat was **told not to do** and did not.

| # | Item and source | Landed at | Disposition, and its acceptance test |
|---|---|---|---|
| 1 | **Blocking 1** · the campaign seal — three passages, three incompatible answers on who authors, when it freezes, who is blinded and who scores; the one confirmed silent divergence at an independence boundary, converged on by all five advisors | §3.3, §3 packet table, §3.9 | **Applied, and it is this edition's centre.** Written from the committed seal and its verdict rather than from the previous text: **author** = the scored seat (§3's table row was the true one of the three); **freeze point** = *before any defect diff existed*, restoring the phrase the de-domaining had weakened to "before any evidence existed"; **blind direction** = against the **seeder**, with the reason quoted from the artifact; **scorer** = the same seat that froze it, and **the rule that said otherwise is withdrawn as false**, because every campaign in this record was scored that way and none was marked a deviation — a rule kept zero times is a description of a different organization. What replaces it: four checkable constraints, and the residue named as §5.7's sixth disguise operating in the open. The facsimile is re-transcribed verbatim-minus-nouns from the real seal. *Test — two independent cold readers reconstruct the same information flow:* **RUN, and PASSED** — B.0.1's two readers, working independently and from the document alone, returned the same author, the same freeze point, the same blind direction, the same scorer and the same named residue; each also flagged the same two residues in the passage, both repaired in the fifth edition (**B.0.1**, **B.10** items 8–9). Reports at `round-3/cold-reader-A.md` and `…/cold-reader-B.md`. |
| 2 | **Blocking 2** · the executable half of the export unit is unpinned — the document anchors its own edition to a commit and the shell to nothing | §6.0, and the document's opening | **Applied in both limbs the verdict named.** The pin states what this repository can actually attest and refuses to state more: facsimiles taken **from this repository's own artifacts** at this edition's commit; the shell **observed at `main` = `2ad82c3` on 2026-08-11**, the state the federation transit branch was cut from; **shell current through: unknown from here, by construction.** Because the drift check is not landed, the second limb is taken: the **document's opening paragraph is re-scoped explicitly to the export unit**, and says in terms that the replication claim belongs to the unit and not to this half. *Test — C10.2 against the shell half:* **cannot be run from this seat**; the honest report is that the shell is named, dated once, and not inspected, and the document now says so where a reader meets it first. |
| 3 | **Blocking 3** · the packet-minting blockquote is invented law: unstamped, uncarried, unrouted, and the inverse of the record's practice; plus *"Six types are defined"* matching neither the constitution's four nor the practice | §3, Annex B.2 item 11 | **Applied in all three limbs, plus the sweep.** The blockquote carries **(no posture row — proposal, not this organization's law)** with the contradicting facts stated inside the marker; it is routed as an amendment candidate; and the table gains a **"where the type is defined"** column — four constitutional rows, two this document's own construction, with what each construction actually rests on. *Test — Bob's F1 acceptance test per blockquote, over §§2–4:* **run. Census: seven blockquote blocks document-wide; two in §§2–4, of which one is facsimile content inside a fenced block and the other is this one. Exactly one unstamped normative blockquote existed in §§2–4 and it is the one filed.** Outside the swept range the same test was applied anyway: §1.2's tier invariant already carried its posture; the preamble's stamp-boundary block is descriptive; §6.2 Step 5's block is adopter instruction derived from stamped sections; **the preamble's mechanism-placement blockquote was the one further catch — a rule with no marker — and it is now marked as this document's own drafting rule, binding its author and no seat.** |
| 4 | **Blocking 4** · §6.2 Steps 1–2 manufacture the state §1.2 forbids, and no step authors the constitution the later steps quote (B.8 item 34's admitted half) | §6.2 Step 1, Step 2, Step 4 | **Applied by restructuring Step 1 into four ordered acts** — **1a** derive the roster and write it down first (the scope table is its scope column made executable); **1b** land the machinery carrying exactly one scope row, the committing seat's, with that seat's four things together; **1c** onboard every remaining seat one act per seat **under the gate**, four things together, roster row flipped; **1d** author the constitution from the running machinery. Step 2 now states what it consumes; Step 4 binds to *your* constitution rather than to the kit's template. *Test — paper-execute Steps 0–4; no intermediate state violates §1.2 and no step consumes an artifact no earlier step produced:* **run, and it passes with the repair and fails without it.** The two failures it found in the previous order are exactly the two acts added: Step 2 consumed charters nobody authored, and Step 4 consumed a constitution nobody authored. Two consumptions remain external and are named in place: the shell (Step 0) and the platform (Step 3). The walk is recorded in this seat's reasoning log for this round. |
| 5 | **Blocking 5** · four parameters the text calls *stated*, *literal* or *fixed* and never states | §3, §3.2, §4.6, Annex A.9 | **Applied, split two and two by what the record could honestly support.** **Stated**: the packet `<TYPE>` file tokens, all six forms plus the transit, printed in the path facsimile where the template's variable was previously unbound; and the bounce revision scheme — the packet keeps its identifier and file, the state field records the whole chain, the revision is a **letter suffix on the round**, verdicts carry the letter, superseded verdicts stay in place, and the same suffix means *part* in a split filename. **Re-labelled adopter-chosen in Annex A's idiom**: the draft placeholder token, because **this program does not have one** — its practice is the next free number declared provisional in a journal entry, which is disciplined and not greppable, so the greppability property is stated as a requirement to choose rather than a fact to inherit; and the E6 threshold, because the constitution's only figure is introduced *for example* and the class has never fired. *Test — Charlie F2's:* **passes.** Each of the four now either exists as a literal in the text or is re-labelled in the annex with the property it must satisfy. |
| 6 | **Blocking 6** · the escape ledger described in the running indicative with no zero-instance disclosure; and no aggregate anywhere of which compensating controls have actually operated | §1.5 item 5, §3.8, §1.1 | **Applied at all three sites.** The ledger's sample size is disclosed in the same terms §3.8 already used for the sign-off form — **zero instances, the file has never existed at any commit in this program's history** (verified by searching the whole history for the path and for any file of that name), with the two candidate readings named and the statement that this program cannot presently distinguish them. And §1.1's residue note gains **the summed table**: eleven rows, each re-derived rather than quoted, giving how often each compensating control has actually operated since ratification — four *once*, three *never*, two *owed*, one *unbuilt*, one *twice* — under the finding that **a cadence written into a charter is owned by whoever spawns that seat**, routed as an amendment candidate rather than enacted. *Test — a reader can distinguish "no escapes yet" from "ledger running", and can state the operational status of the review-enforced tier from one paragraph:* **passes on the text; the second half is one table rather than one paragraph, a form deviation stated here rather than hidden.** |
| 7 | **Cheap batch 1** · no routing sentence; a cold reader meets 240 lines of epistemology before the organization | *Read this first* | **Applied.** One block at the top: adopting → §6.2 and §6.0; what this is → §1.0; looking something up → the subsection index; and an explicit statement that everything before §1.0 is skippable if you only need to act. |
| 8 | **Cheap batch 2** · no subsection index (B.8 refusal 4 named the repair and built nothing) | after the Contents | **Applied, and built the way that refusal demanded rather than the way it refused.** The index is **mechanically derived** from the document's own subsection headings by a command printed beside it, and it carries **the date and commit it was last derived at** — which is precisely §1.6's rule for a derived aid. A hand-maintained index was refused twice for a good reason; a derived one with its derivation printed is a different artifact. |
| 9 | **Cheap batch 3** · the two-column name map (function names ↔ constitution and shell names), doubling as the federation identifier map | **Annex C**, new | **Applied as a new annex, not as a section**, because it is made entirely of program nouns and §1–§6 exclude those by construction. It carries seats, artifacts, scripts, packet tokens, and the harvest and federation identifier families — the last being what §6.2 Step 0's cross-repository greps need. Annex C joins Annex B in the fork contract as *delete whole and write your own*. |
| 10 | **Cheap batch 4** · §1.3's field list omits two of the nine real charter sections, and the kit defines the exported template by that list | §1.3 | **Applied.** The nine are printed, re-derived by reading the section headings of all nine charters in this program's charter directory (they are identical across every seat). The two that were missing are named as the two that mattered: **journaling and commit obligations**, and the section where a read restriction is written down **as unenforceable**. An adopter generating charters from the previous list produced seats with neither. |
| 11 | **Cheap batch 5** · no form for the roster file, the program-state file or the gate checklist — C5's recovery and gate legs are unexecutable without them | §1.6, §3.7 | **Applied as two facsimiles** (roster and program-state, side by side, since the recovery sequence opens both) **and one more** (the gate checklist, at §3.7, where §1.7 and §6.2 Step 5 both terminate). The roster facsimile carries the **Status** column that lets §6.2 act 1a exist without violating §1.2. |
| 12 | **Vocabulary drift**, multiply confirmed | §1.2, §3.1, §3.9, Annex C | **Applied by the two routes the dispatch allowed.** *Aligned*: **spawn token → spawn short-id**, the constitution's and every launcher's term, at both sites — a synonym this document invented, and one that returns nothing when §6.2 Step 0 greps the machinery. *Mapped rather than aligned*: **equivalent defect ↔ equivalent mutant**, because §3.9 is de-domained to *defect* throughout and one bullet in the domain's vocabulary would read as a second concept; the pairing and its family sit in Annex C, with a pointer at the bullet. |
| 13 | **Attributed by dispatch** · §2.5's *"Two things that matters for"* — a prose defect this seat reported in the round-3 round and **refused as unattributable** | §2.5 | **Applied, with the refusal preserved as the lesson.** The running line is repaired and the margin carries what it said, why it was not repaired then (the seat could not cite which edit dropped the subject, and would not repair a running line on a basis it could not cite — §3.1's evidence rule turned on its own prose), and the source the dispatch supplied. The general form: **a defect a seat reports and refuses to fix is one whose route was missing, not one it has excused.** |
| 14 | **The verdict's closing instruction** · convert Annex B from ledger to schedule | Annex B intro, **B.0** | **Applied.** The two debts the council made conditions are written as **dated conditions with owners and commissioners** at B.0 — the cold-reader row and cold adoption run number two — and B.1's standing cold-reader row records **edition 3 as NOT RUN** rather than *owed*, which is what it actually was. The ground is §5.5's own: a routing rule needs a named owner, a named triggering event and a visible debt, and this annex had been carrying one of the three. |

**Refusals and deferrals of the fourth edition, with grounds.**

1. **The core/memoir separation: NOT ATTEMPTED, and endorsed as the next
   structural act.** Executing the fork contract once, exporter-side, to produce
   a stripped rule-first adopter's edition beside this one is the **fifth
   edition's** act — the verdict says so in terms, and sequences it behind the
   line-level blockers precisely so this round stays shippable. It is named here
   so the endorsement is countable: **the correction apparatus of a document
   this size does not converge by per-claim editing** (§2.7 says so about
   itself, and two consecutive editions proved it), and the structural repair is
   the thing that would. Closing event: a fifth edition run against B.0.1's
   cold-reader row.
2. **The three fenced items: NOT DONE, deliberately.** The charters are not
   inlined (the kit row plus §1.5's mechanisms stand); the failure museum and
   the rule-plus-failure-class dual statement are untouched — §5 gains nothing
   and loses nothing in this edition; and §3.9's scoring block is **not frozen**,
   its own instruction that the reporting form is expected to move left intact.
   These were the verdict's fence, and a revision that crosses its own fence
   while citing it is the defect §3.7 convicts.
3. **Round-3 findings the verdict did not make conditions: NOT APPLIED, named,
   owed a round.** The independent record audit filed several beyond the six —
   among them the shared-scope arithmetic quoted rather than re-derived in the
   passage that says *compute it*; a header count of four standing over a list
   of five in §1.5; the *six of the eight owed postures* enumeration; Annex
   A.8's *and nowhere else*; the contingent seat's trigger described as more
   deterministic than the record has it; two incident-born mechanisms exported
   without their incidents; an artifact class with no home in the grammar; and
   two small precision overstatements of machine behaviour. **Two of them sit
   adjacent to text this edition added, and those two are marked in place**
   rather than left to borrow their paragraph's authority. The rest are real,
   are named in the council's committed reports, and are unapplied. **A revision
   that quietly widens its own scope is a revision whose scope nobody can
   check** — and the corollary this round adds: *a revision that leaves a filed
   defect unmarked beside its own new text has widened nothing and hidden
   something.*
4. **The posture list: NOT TOUCHED, for the third consecutive edition**, on the
   ground stated once at B.2 item 8. **No line of that file was read into this
   round as editable and none was changed.**
5. **The doc–shell drift check: STILL NOT BUILT.** It was named as this seat's
   debt in the third edition and is named again here, and naming it twice is the
   thing this annex's own conversion to a schedule was meant to stop. It is not
   built because building it requires landing a test in one of two repositories
   at a round commissioned for a document revision, and this seat will not
   quietly widen a revision into an engineering round. **That is a reason and
   not an excuse**, and the honest consequence is stated at §6.0: every
   facsimile here is an unverified claim about another repository.

---

### B.10 — The fifth edition, item by item

The source is a **sponsor-relayed external grading of the fourth edition**,
committed verbatim at
`docs/reports/process-council/sponsor-report-card-2026-08-12.md` — thirteen
graded dimensions with a comment on each, produced by an agent outside this
organization and relayed with the instruction to incorporate it directly, **not**
through a council round. Two further sources landed with it and are the fourth
edition's own dated conditions coming due: the **two cold-reader reports** and
the **second adoption run's halt log**, all three at
`docs/reports/process-council/round-3/` (**B.0**).

*The rule this table obeys, unchanged from B.7, B.8 and B.9:* every applied
change lands as a repair of a **running line**, with the superseded text
preserved beside it, and every change carries the graded dimension, cold-reader
repair or numbered halt that produced it. **Nothing below was applied because it
seemed better.** What is new in this edition's discipline is the reverse of B.9's:
the source carries **no acceptance tests**, because a grade is not a verdict —
so each row records what was changed and what would falsify the change, and the
audit of whether the change was the right one is scheduled at **B.0.3** rather
than claimed here.

| # | Item and source | Landed at | Disposition |
|---|---|---|---|
| 1 | **Precision of claims (A−)** · *">half the text postdates its evidentiary spine, unmeasured, with no visible seam"* | *Read this first*; the subsection index | **Applied as a derived seam column.** Every index entry carries `· n`, the count of posture-row citations inside that heading's span, produced by a printed command and not by hand. `· 0` marks a section wholly outside the spine. Two limits are stated where the column is declared: it counts citations rather than claims, and it cannot see unmeasured text sitting beside a measured sentence — so only the zero cells carry a complete statement. **Falsified by:** running the printed command and getting different numbers. The complete repair remains the auditor's re-measurement at **B.2 item 8**. |
| 2 | **Human readability (B−)** · *"provenance parentheticals interrupt nearly every paragraph"*, and both cold readers' first repair passage | throughout; convention declared in *The dialect* | **Applied by demoting provenance out of running text.** A new convention — the **annex pointer**, a bare backticked `[B.9·2]` — replaces the parenthetical that used to name the edition, the council item and the halt inside the sentence. **Seventy pointers were minted** — 52 into B.8 and B.9, 16 into B.10, 2 into B.2 — and the genealogy they replaced is in the annex row each one names, which B.8 and B.9 already tabulated before this edition. **Falsified by:** a pointer whose annex row does not contain the provenance it replaced, or a running line still carrying a genealogy parenthetical. |
| 3 | **Cold reader repair 2** · §1.1's self-annulling residue sentence: a claim, its refutation and its non-repair inside one sentence, asking a reader to disbelieve it from inside it | §1.1 | **Applied by inversion.** The re-derived summed table now leads and the running line rests on it; the disputed *six of the eight owed postures* enumeration is demoted to a margin beneath the table, under the sentinel, still owed a round at **B.9** refusal 3. Nothing is deleted and nothing is newly asserted: the count that was contested is still contested and is no longer in the running line. |
| 4 | **Same shape, §1.5** · a header count of four standing over a list of five, marked-not-repaired in the running line | §1.5 | **Applied the same way.** The header count is dropped rather than replaced with a new one — this seat cannot re-count another seat's filing inside a round that did not commission it — and the marked dispute moves to a margin beneath the list. |
| 5 | **Retrieval/chunked safety (C)** · *"superseded false claims preserved verbatim in margins; the doc warns but doesn't structurally prevent"* | *The dialect*; every preserved margin | **Applied as a uniform sentinel.** Every margin preserving a claim this document no longer asserts opens with one fixed token — `SUPERSEDED — historical record, not current law:` — immediately before the preserved text, so that any retrieval fragment containing the false sentence contains the marker too. The convention and its **census** are declared in *The dialect*, re-derivable by one `grep -c`. **Falsified by:** a preserved superseded quotation with no token in front of it — which is a defect of this edition, not a claim that the quotation is current. |
| 6 | **Adoptability with shell (B+)** · the *"one iteration of fix, zero of re-test"* cell, whose premise predates adoption run two | §6.2; **B.0.1**, **B.0.2**; **B.1** | **Applied by recording the runs, not by arguing with the grade.** §6.2 now carries both runs in one table — 18 halts / 3 stops, then **17 halts / 0 stops** — with the composition change stated (interfaces transferred as facsimiles; implementation still invented end to end) and with the two things the pair does *not* license anyone to say. B.0's rows move from `OPEN — CONDITION` to **EXECUTED-WITH-ANCHORS** with their committed logs cited. |
| 7 | **Debt management (B+)** · *"the drift check being named in two editions and built in neither"* | **B.2 item 9** | **Restated, not built** — see refusal 2. The item now carries a due date for the first time (*before any sixth edition is drafted*), and the grading's own sentence is quoted **unedited beside the debt**, together with the hazard this seat had already filed against itself: a named debt can substitute for the repair, and converting naming into scheduling moves the substitution one level up rather than removing it. |
| 8 | **B.9 item 1's acceptance test**, recorded as *not yet run* | **B.0**; **B.9** item 1; **B.1** | **Recorded as PASSED.** Two cold readers, independently and from the document alone, reconstructed §3.3's author, freeze point, blind direction, scorer and residue identically. The row that owes the *seats'* confirmation of accuracy stays open: a passed reconstruction test shows the passage is unambiguous, not that it is true. |
| 9 | **Accumulated ledger** · §3.3's opening line still carried the withdrawn weaker phrase *"Before evidence exists…"*, convicted by its own bullet | §3.3 | **Applied.** The opening line now reads *before any defect diff exists*, matching the bullet that withdrew the weaker phrase; the superseded opening is preserved in a margin under the sentinel. |
| 10 | **Cold reader repair, §3.3's placeholder cast** · *the seeding seat / the operating seat / the scored seat* used before §1.5 and §3.9 reveal who they are | §3.3 head | **Applied as a three-line cast list** binding each placeholder to its §1.2 function, at the head of the section, before the facsimile that uses them. This is the passage where a hostile reader of an earlier edition reconstructed the blind's direction backwards. |
| 11 | **Accumulated ledger** · duplicate `R9`/`R10` ids in §2.6's table explained only after it | §2.6 | **Applied by moving the note to ride the table**, not by re-numbering: the ids are this program's real ones, and **a facsimile that renumbers is a facsimile of nothing**. The *thirteen rows, eleven numbers* note now sits above the table where a reader meets the duplicates. |
| 12 | **Conciseness (C+)** · *"the ledger fact recurs at four sites"*, and the general dedupe it stands for | §3.8, §1.4(c), §2.3, §3.1, §2.5, §2.6, §3, §3.3, **B.9** | **Applied as pointerization, never deletion.** Seven facts that recurred at three or more sites were each collapsed to **one canonical statement plus one-line pointers**: the escape ledger's zero sample size (canonical §1.5 item 5); the review-enforced tier's dormancy (canonical §1.1's summed table); the marked-reference population (canonical §3.9); the propose-don't-enact rule (canonical §2.7); the seal's blind-direction quotation (canonical: the facsimile); the root-class ground for not touching the posture list (canonical B.2 item 8); and the facsimile/drift-check consequence (canonical §6.0). The rule the pass obeyed is stated in *How to read this*. **The round-3 fence held**: the failure museum, the rule-plus-failure-class doubling and §3.9's scoring block are untouched. |
| 13 | **Adoption run two, HALT-06** · the founding-range contradiction survives the §6.2 reorder — the text brands a recorded baseline forbidden while prescribing no mechanism that is not one | §6.2 Step 1 | **Applied by adopting the run's own invention as the named mechanism, credited to it.** A committed founding declaration carrying the range's commit count as data, read by the re-check from committed state, announced in a banner on every run, quoted in the founding gate's row, and examined by name in the Step 5 retro-audit. The distinction the previous edition could not state is now stated: **a baseline is quiet when only the tool that reads it knows it exists, and loud when the gate record, the audit and every run of the re-check say so.** |
| 14 | **Adoption run two, HALT-12** · the adopter's own machinery breaking at first live fire is a cost class §6.2 never budgets | §6.2 preamble | **Applied as a budget line.** The order now tells an adopter to expect one live-fire failure of their own machinery, names the repair route as the amendment procedure they authored at act 1d and bound at Step 4 — sandbox proof outside the repository, decision record, separate accepting commit — and says why the omission was dangerous: an order that treats its own first failure as an accident invites a bypass of the gate just installed. |
| 15 | **Structure and navigation (B)** · the document's most-cited anchors are unreachable from its only navigation aid | Annexes A, B, C; the subsection index | **Applied.** Every annex sub-item — `A.1`–`A.9`, `B.0`–`B.10`, and Annex C's four groups, now `C.1`–`C.4` — is a real heading rather than a bold line, so the mechanically derived index reaches the targets the document cites most often (*"Annex B.2 item 9"* appears in the opening paragraph). The index is re-derived by its own printed command, and the disclosure that annex sub-items are unreachable is deleted because it is no longer true. |
| 16 | **"Cool" (A)** · *"occasionally tips into self-parody"* | §1.4(a), §2.7, §6.0 | **Applied at three sites, content unchanged.** Three flourishes that restated a point already made in the sentence before them are quieted to plain pointers. Nothing was added or removed except temperature; every claim, stamp and pointer in those passages is intact. |
| 17 | **Accumulated ledger, two small ones** · the *seeded seat* slip at B.1's confirmation row, and program nouns used in B.1 before Annex C defines them | **B.1**; head of **Annex B** | **Applied.** *Seeded* → **seeding**, the term every other passage uses. And Annex B opens by stating the boundary it *is*: §1–§6 speak in function names, this annex names this program's artifacts, and **Annex C is the map** — so a name a reader cannot resolve has a stated destination rather than a silent one. |

**Refusals and deferrals of the fifth edition, with grounds.**

1. **The core/memoir separation: NOT ATTEMPTED, for the second consecutive
   edition, and the endorsement is now overdue rather than merely open.** B.9's
   first refusal named it *the fifth edition's act*. It is not this edition's
   act, and the ground is the commission: this round was directed
   **single-seat and explicitly without a council**, to incorporate one graded
   report — and executing the fork contract exporter-side to produce a stripped
   rule-first edition beside this one is a structural act that would change what
   the document *is*, which is exactly the class of decision a single seat
   grading its own work should not take. **That is a reason and not an excuse**,
   and it costs something real: the grading's two lowest structural marks —
   conciseness and read-through readability — are the two the separation would
   move most, and this edition moved them by pointerization and demotion only.
   Closing event: a council round that either commissions the separation or
   records its refusal with grounds (**B.0.3**).
2. **The doc–shell drift check: STILL NOT BUILT, for the third consecutive
   edition.** Same ground as B.9's refusal 5, and it does not improve with
   repetition: building it means landing a test in one of two repositories
   during a round commissioned for a document revision, and this seat will not
   quietly widen a revision into an engineering round. What is new is that the
   item now carries a **due date** and the grading's criticism **quoted beside
   it** (**B.2 item 9**). **Naming a debt three times is the pattern the report
   card scored, and this edition has named it a third time.**
3. **The posture list: NOT TOUCHED, for the fourth consecutive edition**, on the
   ground stated once at **B.2 item 8**. It was **modified in its owner's own
   lane while this round was running**, landing at `22c60fb`; **no line of it was
   read into this round and none was changed**, and the consequence — that this
   document's *"owed"* cells about it may be stale by one landing — is recorded
   at **B.2 item 8** rather than resolved by reading. The seam column added at
   item 1 is derived from *this document's own* citations and touches nothing in
   that file.
4. **Round-3 findings the fourth edition's verdict did not make conditions:
   STILL NOT APPLIED**, and now unapplied across two editions — the shared-scope
   arithmetic quoted rather than re-derived in the passage that says *compute
   it*; Annex A.8's *and nowhere else*; the contingent seat's trigger described
   as more deterministic than the record has it; two incident-born mechanisms
   exported without their incidents; an artifact class with no home in the
   grammar. Two of them — the §1.1 and §1.5 counts — **were** the subject of
   cold-reader repairs and are demoted rather than repaired (items 3 and 4),
   which is a different act and is recorded as one. The rest are named in the
   council's committed reports and are owed a round. **A revision that quietly
   widens its own scope is a revision whose scope nobody can check.**
5. **The grades themselves: NOT ARGUED WITH, anywhere.** The report card is
   quoted where it is used and is not rebutted, including where its premise is
   dated — the *"zero of re-test"* cell predates adoption run two by hours, and
   this edition updates the schedule rows rather than contesting the cell.
   **A document that answers its own grading is a document grading itself**,
   which is §5.7 arriving through the review channel.
6. **No new normative claim carries a posture row.** Everything this edition
   adds is marked *(no posture row)* or is a pointer, a heading, a sentinel or a
   demotion — none of which asserts anything about the machinery. The stamp
   boundary in *Read this first* is where that is stated, and this edition moved
   the boundary and re-measured it in the same act rather than carrying the
   previous sentence forward.

---

### B.11 — The sixth edition, item by item

The source is a **fourth council** — a standards framework, three record- and
readability-lensed auditors, five advisors from declared seats, adjudicated by
one chair into a verdict of **FIT WITH REPAIRS for the document as it now scopes
itself**, **NOT FIT** for the claim originally commissioned, and **UNTESTED** at
the level of the export unit. The verdict is committed at
`docs/reports/process-council/round-4/verdict.md`, beside the nine reports it
adjudicates. It commissions this edition with a **closed, ordered scope**:
*determinism first, the split second, no new confession machinery.*

*The rule this table obeys, unchanged from B.7 through B.10:* every applied
change lands as a repair of a **running line**, with the superseded text
preserved beside it — **now in this volume rather than in the core, which is the
edition's one structural act** — and every change carries the verdict item that
produced it. **Nothing below was applied because it seemed better.**

*What is new in this edition's discipline, and it is the reversal the verdict
demanded.* The council's central diagnosis was that **confession had replaced
repair**: five order defects budgeted at an hour each per adopter instead of
being fixed; a known-false line standing unmarked for two editions; the
count-over-non-matching-list class convicted by name in three margins and
shipped fresh five times. Its instruction was blunt — *the first time in three
editions that a known one-line defect is repaired instead of eloquently
disclosed.* So this table's dispositions are **repairs**, and where an item is
not repaired it is **routed with an owner and a closing event**, never disclosed
in place. **The confession paragraph that enumerated the five order defects is
deleted**, because the defects it describes no longer exist and a preserved
present-tense claim that a document is broken is not history, it is a false
statement about the current text.

| # | Item and source | Landed at | Disposition |
|---|---|---|---|
| 1 | **Charlie F7 / the Executor's day-2 cliff** · no rule routes acceptance of a lead's ordinary output — the exact tier §5.7 calls the root class | §1.4(a) | **Applied as a routing table**, one row per output class, naming the accepting seat and the artifact the acceptance lands in. The lead-tier row takes the split-by-question form the section already had for the case where the producer is the only competent reviewer. |
| 2 | **Charlie F7, second limb** · *normative* is constitutive in §1.0 and delimited nowhere | §1.4(a) | **Applied as a four-class definition with its complement stated in the same breath** — a figure, a scope, a schedule and a cure inside an already-ruled rule are **not** normative. The complement is the load-bearing half: without it the boundary fails permissively and the countersignature becomes a formality, or restrictively and every figure edit needs a record. |
| 3 | **Charlie F6 / BILL-03 / the Executor's item 2** · two authoritative disagreeing shapes for the roster, the first artifact an adopter lands | §1.6, §6.2 act 1a | **Applied at both sites, one shape.** §1.6's facsimile is declared the single authority and act 1a cites it instead of restating it. The disagreement is resolved *in favour of the transcribed artifact*: the roster carries six columns and no scope column, and the false sentence *the scope table is the roster's scope column made executable* is repaired to the true chain — **roster → charters → policy module**, with each seat's scope living in its charter's section 1. |
| 4 | **Charlie F3 / the Executor's day-2 cliff** · *phase* and *milestone* are undefined primitives, so the trunk-merge trigger and the gate cadence cannot be operated | **§1.8**, new; pointers from §2.6 | **Applied as a definitions subsection.** A milestone is the planning unit; a phase is a milestone carrying a full gate triple; the trunk-merge trigger is **a gate row landing**, not a cadence and not a judgement. What transfers is stated as the requirement to fix a parameterization, not this program's parameterization. |
| 5 | **Bob F7** · the large-file gate's designed remedy appears nowhere, so an adopter meets a refusal with no lawful exit | §2.6, Annex A.7 | **Applied at both.** The route the enforcement messages already name — **a fetch script plus a checksum manifest**, both committed, payload not — is stated with its property: what the repository carries is the thing that makes the payload verifiable. **A refusal that names no remedy will be answered by bypassing the gate.** |
| 6 | **Charlie F8(4)** · §2.7 opens *requires three things* and later adds a fourth | §2.7 | **Applied.** Four, counted over the whole list, with the fourth marked as the only one that is not in the constitution. |
| 7 | **Charlie F8(5)** · *Six forms are in use* over a list that names more forms two paragraphs down | §3 | **Applied by scoping the count to what it actually counts** — six forms *have a definition* — with the extras named as unrouted extensions, which was already the next paragraph's subject. |
| 8 | **Bob F3** · §3.3 states the seal's *single line flipped at unsealing* as the artifact's form; the record's dominant and current practice never flips it | §3.3, and its facsimile | **Applied by re-derivation, not by hedging.** Re-measured seal by seal at this round's own commit: **thirteen seals; four early ones flip to `UNSEALED`; nine never do, and six of those nine were scored** — so six of the ten scored campaigns were scored without one byte of their seal being touched. The facsimile is re-transcribed **from one of the nine**. The correction runs in the safe direction and is still a correction: **the later form has no mutable point at all**, which makes the check flat — `git diff` against the freezing commit, expected empty — instead of a check whose runner must decide which difference is allowed. Also recorded: the early seals state the *reason* for the blind inside the seal and the later ones moved it to the commissioning packet, which is the one respect in which the practice moved the wrong way. |
| 9 | **Charlie F4 / the Executor's item 3** · the countersignature is constitutive in §1.0 and has no artifact form, no location, and no address for the owed ledger — the only load-bearing artifact class with no facsimile, and the terminus of the day-one failure path §6.2 budgets | §3.5 | **Applied as the round's unblocking repair: two facsimiles and an address.** A countersignature is written **twice** — the authority is a sentence in the signer's own append-only log, the routed copy is a verdict section in the commissioning packet — and everything that cites one cites the **entry id**. The facsimile forces a per-limb verdict table and an explicit *what I did not reach*. The delta-signature facsimile carries the property that distinguishes it: it is formed **against a diff**, naming which hunks moved and which did not. And **the owed ledger has an address — a numbered section of the instrument whose own clauses moved** — chosen because it is *obliged reading* for anyone accepting, citing or amending that instrument, so §5.5's legibility requirement is satisfied by position rather than by diligence. |
| 10 | **Charlie F5** · §3.7's flat rule *the Signature column holds an entry reference, never a name or a date* is contradicted by its own facsimile's sponsor row, ten lines above | §3.7 | **Applied inside the rule sentence**, where the verdict asked for it, rather than two sections away. Both the opening rule and the three-properties note now carry the sponsor exception. **A stated grammar with a non-conforming example in the same block is a grammar nobody can generate against.** The facsimile's broken bold and stray delimiter are repaired in the same act (**Charlie F14**). |
| 11 | **BILL-01 / the Executor** · *extracted project-free* is the document's one materially false load-bearing sentence | §6.0 | **Applied as the true sentence plus an inventory plus a commitment.** The shell is **FPGA-generic, not domain-free**; a nine-row table splits every kit surface by domain load, so a cross-domain adopter knows what they are buying. And the repair is **committed to rather than apologized for**: §3.10's own **domain packs** are the taxonomy for exactly this, so the shell splits into a general core plus an FPGA pack — stated as intent, marked as not done, owner named, routed at **B.2 item 15**. The posture is declared weak in place: **this seat has not inspected the shell**, and the statement rests on three committed council reports that did. |
| 12 | **BILL-02 / the Executor's item 1** · two adoption orders exist, the document never names the second, and the only tested path is the one no adopter with the shell would take | §6.0 kit table and the **precedence rule** | **Applied as a kit row plus a precedence rule.** `BOOTSTRAP.md` enters the kit table named as *a second order that does not agree with this one*. The rule: **with the shell in hand its own order governs the sequence; §6.2 governs as the shell-less fallback and as the grounds underneath either order.** The one known concrete disagreement — platform protections early versus after CI has run green once — is named, and **§6.2's placement is declared right**, with its ground a measured founding failure (the empty status-check picker). The honest scope is stated in the same block: the with-shell path is **untested**, the rule is reasoned rather than measured, and closing it is **B.0.4b**. |
| 13 | **Self-convicted order defect (1 of 5)** · *bootstrap range* used in three places against a defined *founding range*, neither defined | §1.7, and every site | **Applied as one name and one definition.** The founding range is defined once, at §1.7 act 1, as the range from the first commit to the completion of the machinery — acts 1a and 1b — *named, minimal, declared and audited by name*. Six occurrences of the undefined term were replaced mechanically; the one surviving instance is inside the definition that records the superseded name. |
| 14 | **Self-convicted order defects (all 5) and the paragraph that confessed them** · the verdict's *one thing to do first* | §6.2 | **All five repaired in place, and the confession deleted.** What replaces it is one dated line recording *that* the repair happened and *when*, citing the verdict — **not what was wrong**, because nothing is. The budget line that charged an adopter *about an hour each* for the five is deleted with them. **The deletion is lawful precisely because the confession described defects that no longer exist**: preserving a present-tense claim that this document is broken would not be preservation, it would be a false statement about the current text, and the preservation discipline is served by the history line plus this row. |
| 15 | **The Executor's preflight gap** · three steps consume things that are not in the repository and one of them is a person; Step 5 discloses at the end that a solo adopter cannot finish | **§6.2 Step −1**, new | **Applied as a four-item preflight before Step 0**: a recruited human sponsor, a platform whose protections you have looked at, a CI surface that can run, and **network reach to the shell, tested rather than assumed**. The last is stamped with its own evidence: **both executed adoption runs failed this check and neither knew that was a finding.** The general form is stated: *an order whose first step is inside the repository has already assumed everything outside it.* |
| 16 | **Self-convicted order defect** · Step 1's preamble *before the first commit you intend to keep* is unsatisfiable as written | §6.2 Step 1 | **Applied.** Every commit from act 1a onward is one you intend to keep; acts 1a and 1b are the founding range, and the bootstrap paradox is handled by **declaring** the range, not by discarding the commits. An adopter following the old preamble literally either discarded the roster or stopped. |
| 17 | **Self-convicted order defects** · the committing seat's roster row that no act activates, and the program-state file and journal index that no step schedules | §6.2 acts 1b and **1e**, new | **Applied as one flip and one new act.** Act 1b now flips the committing seat's roster row *planned → active* in the same commit, by the identical rule 1c applies to every other seat — the row an earlier order left permanently *planned* in the file the recovery sequence opens first. Act 1e lands the **program-state file** and the **journal index**, each with the cadence rule that keeps it true: the first updated in the same commit as any state change it describes, the second either derived at read time or carrying the date it was last true. A definition-of-done row is added, because a scheduled act no checklist reads is a scheduled act that gets skipped. |
| 18 | **Preservation repair discovered by the split** · the marked-reference population lived only in two margins that the split moves, while §2.5 and §2.6 both point at §3.9 for it | §3.9 | **Applied by promoting the figure into a running line** before the margins left. **Eighty-six references, none an ancestor of the working branch's head, fifteen campaign prefixes, two probes** — with the unit spelled out, because this is the one section that rules a reference population cannot be a denominator. *This is the class of defect a split is most likely to create, and finding one is the reason the manifest exists.* |
| 19 | **Bob F10** · B.2 item 5's *named, not performed* was performed mid-round at `22c60fb` | **B.2 item 5** | **Applied.** Both cures landed in the prescribed idiom. Recorded with the half that matters more: the appended notes state they **do not re-measure the list**, so item 8's debt is genuinely open — and the fifth edition's declared blindness was therefore accurate in both directions. |
| 20 | **Charlie F8(3)** · two live figures for the document's own size, in the passage governing the evidentiary boundary | *Read this first*; **B.2 item 8** | **Applied by making one of them canonical.** The boundary block carries the figure and re-measures it in the act that moves it; B.2's cell points at it. The block also states what the split did **not** do: 1,082 lines of unmeasured text moved out, **no stamp was re-measured**, and a file getting shorter is not a file getting better evidenced. |
| 21 | **Bob F2** · a false constitutional clause the document itself identifies is the only one of its kind with no route | **B.2 item 13**, new | **Routed, never touched.** The constitution's transient-mutation model is contradicted by every campaign in the record; the core has acknowledged it for four editions and routed it never, while routing the two analogous premises as items 1 and 2. Owner, batch and closing event named. **A document that discovers an error in its source does not thereby acquire the right to edit the source.** |
| 22 | **Bob F6** · the kit's packet-forms original still teaches the `N/N` ratio the constitution outlaws | §3 facsimile; **B.2 item 14** | **Repaired in the core, routed for the original.** The core's packet facsimile now prints the lawful disposition block — two columns, the difference itemized, per-class rows, the unreachable set beside the tally — so an adopter building from the facsimile builds the lawful shape. The original is a packet-directory file **inside this seat's standing write scope but outside this round's declared scope**, so it is refused with grounds rather than taken quietly (§4.8). |
| 23 | **Charlie F8(1)(2) and F9; Charlie F14** · the count-over-non-matching-list cluster and three verbatim-fidelity defects, in a document whose apparatus is verbatim fidelity | *The dialect*; *How to read this*; §2.7; §3; §3.7; §6.0; *Read this first* | **Applied, all of them.** *The dialect* states **twelve** over its own list of twelve and gains **seat** — the document's most load-bearing noun, undefined for six editions. *How to read this* drops its stale five. The three stutters are repaired: the doubled *everything everything* inside the boundary block, the doubled clause inside a **quotation** in §6.0 — which by §4.3's own standard a reader could not attribute to source or transcription — and §3.7's broken bold with its stray delimiter, inside a facsimile the document says exists so a reader can write a parser against it. |
| 24 | **Bob F1**, endorsed by every seat at the council table | **`docs/SPONSOR.md`** | **Performed, not routed** — the guide is inside this seat's write scope and the verdict said so. The guide called itself *the complete list of what is genuinely yours* and omitted **two** of the sponsor's five powers: ratification, and the candidate-by-candidate refusal at the harvest. Both are added, with a five-line summary at the top so the two lists can be compared at a glance. The refusal power gets the space it earns: it is the only place in the process where a human can stop something **correct by every internal check** and simply not wanted outside the program, and its holder could not read about it in the one document written for them. **A contradiction cured in the copy and left in the source is not cured.** |
| 25 | **The verdict's governance condition** · the warranty re-scoping and the split are normative changes to the artifact's central claim and must get the record and signature §1.0 demands of everything else | **`docs/adr/ADR-0022`**, new | **Applied.** Both decisions in the four-element form — decision, alternatives with grounds, failure modes created or left open, what it explicitly does not decide — with the countersignature route named (**dv_lead** and **auditor**, per the established precedent) and **owed**, and the acceptance act reserved to the orchestrator. The record states in its own status block that **both rules were already operating when it was written**, which is what makes its lateness measurable instead of invisible. |

**Refusals and deferrals of the sixth edition, with grounds.**

1. **The doc–shell drift check: STILL NOT BUILT, for the fourth consecutive
   edition.** The ground has not improved and is not offered as though it had:
   building it means landing a test in one of two repositories during a round
   commissioned for a document revision, and this seat will not quietly widen a
   revision into an engineering round. What has changed is the **due date**. The
   fifth edition dated it *before any sixth edition is drafted* — **that date
   came and went, in this round, unmet**, which is the first time this debt has
   actually failed a date rather than merely carried one. The fourth council
   moved the gate to where it bites: **no unit-level replication claim may be
   certified until it exists** (**B.0.4a**). *Naming a debt four times is the
   pattern two graders have now scored, and this edition has named it a fourth.*
2. **The posture list: NOT TOUCHED, for the fifth consecutive edition**, on the
   ground stated once at **B.2 item 8**: an author who edits the measurement
   grading its own document is §5.7's root class in one act. **No line of it was
   read into this round as editable and none was changed.** The re-measurement
   it owes is now a live cost rather than a theoretical one — the core is three
   and a half times the measured text and the split moved the boundary again.
3. **The round-3 and round-4 findings the verdict did not make conditions: NOT
   APPLIED, named, owed a round.** Among them: Annex A.8's *and nowhere else*,
   false and known-false for **three** editions now and still unmarked in its
   running line; the contingent seat's trigger described as more deterministic
   than the record has it; the shared-scope arithmetic quoted rather than
   re-derived in the passage that says *compute it*; §1.6's *two leads* against
   an index listing three; the two overlapping halt-numbering sequences cited
   bare; Annex A.6b preceding A.6; the *margin* definition being narrower than
   the sentinel census that quantifies over it. **A revision that quietly widens
   its own scope is a revision whose scope nobody can check** — and the corollary
   this round owes: *A.8 is the third edition in a row this row has carried the
   same item, and a refusal repeated three times is a decision, not a deferral.*
4. **The grades and the verdict: NOT ARGUED WITH.** The council's reports are
   quoted where used and rebutted nowhere, including where this seat would have
   answered — the diagnosis that confession replaced repair is the sharpest
   sentence ever written about this document and it is applied rather than
   contested. **A document that answers its own grading is a document grading
   itself.**
5. **The split's §5 judgement: TAKEN, and declared rather than buried.** The
   verdict's enumeration of the core did not name §5. It was kept, on three
   grounds stated in `ADR-0022` §4, and the sentence that would overrule it is
   named there too. **A one-section scope difference passed over in silence is
   how a commission quietly becomes whatever its executor preferred.**
6. **No new normative claim carries a posture row.** Everything this edition
   adds is marked *(no posture row)* with its posture in prose, or is a pointer,
   a heading, a definition or a repair of an existing claim. The split moved the
   stamp boundary and the boundary block was re-measured in the same act.

---

## Annex C: the name map

*This annex is **program-local**, like Annex B, and a fork **deletes it whole and
writes its own**. It exists for one reader: the one executing §6.2 Step 0, who
is told to trace this document's claims into machinery whose files, seats and
identifiers carry different names. A trace that greps a function name against a
repository that uses a program name returns nothing, and returning nothing is
indistinguishable from finding nothing. It doubles as this program's federation
identifier map.* `[B.9·9]`

### C.1 — Seats

This document names seats by function; the record names them by role.

| Function name (§1.2) | This program's name | Where it is declared |
|---|---|---|
| the orchestrator | `orchestrator` | roster, charter directory, launcher directory |
| the specification lead | `architect_docs_lead` | same |
| the implementation lead | `rtl_lead` | same |
| the verification lead | `dv_lead` | same |
| the auditor | `auditor` | same |
| workers (per packet, shared journal per role) | `rtl_module_dev`, `tb_writer`, `data_wrangler`, `formal_dv` | same |
| a contingent seat (§1.2) | `rtl_lead_md` | roster, and a section of the implementation lead's charter |

### C.2 — Artifacts and instruments

| This document's term | This program's path |
|---|---|
| the constitution / the shared rules | `agents/PROTOCOL.md` |
| charters | `agents/charters/<seat>.md` — nine sections each (§1.3) |
| reasoning log / journal / volume chain | `agents/journals/claude_<seat>_agent[.vNN].md` |
| packets | `agents/handoffs/` |
| the roster file | `ORG_CHART.md` |
| the program-state file | `tasks/BOARD.md` |
| the journal index | `agents/journals/INDEX.md` |
| the commit script (the gate) | `scripts/agent_commit.sh` |
| the history re-check | `scripts/check_journals.sh` |
| the policy module (scope table as data) | `scripts/policy.sh` |
| the enforcement self-test | `scripts/test_protocol.sh` |
| the chain verifier (the fifth script) | `scripts/verify_journal_chain.sh` |
| the continuous-integration workflow | `.github/workflows/journal-check.yml` |
| the posture list | `docs/reports/audit/PROCESS-claims-posture.md` |
| the escape ledger | `docs/reports/audit/dv_escapes.md` — **named in the auditor's charter; never created** (§1.5 item 5) |
| the sponsor guide | `docs/SPONSOR.md` |
| the shell (the export unit's other half) | `generic-agentic-fpga-org` — see §6.0's pin |

### C.3 — Packet and identifier tokens

The forms are printed at §3; this is the mapping a grep needs.

| This document's term | Token in the record |
|---|---|
| work order | `WO-NNNN_<slug>.md` |
| review verdict (defined; zero instances as a file) | `RV-NNNN_<slug>.md`; in practice a `RV-<n>-VERDICT` section appended to the work order's own return log |
| sign-off | `SO-<subject>.md` |
| defect packet | `BUG-NNNN_<slug>.md` |
| sealed prediction | `<the commissioning packet's name>-SEALED-predictions.md` |
| finding | no file; ids of the form `F-<origin>-<n>` inside reports and packets |
| decision record | `ADR-NNNN-<slug>.md` |
| entry id | `J-<seat>-NNNN` |
| harvest transit (an unrouted extension) | `HT-NN_<slug>.md` |
| a marked campaign reference | `mut/<campaign-id>-<class-id>` |

### C.4 — Vocabulary deliberately not aligned

De-domaining these would break either the prose or the grep. Align your own copy
in whichever direction your machinery reads.

| This document's term | The constitution's / the shell's term |
|---|---|
| spawn short-id | **spawn short-id** — *aligned in this edition; the previous editions' "spawn token" was this document's own coinage* |
| seeded defect / defect class | seeded mutation / mutation class |
| defect manifest | mutation manifest |
| seeded-defect campaign | mutation campaign |
| **equivalent defect** | **equivalent mutant** (§3.9's bullet points here) |
| a marked reference | a `mut/` branch |
| the harvest's admissibility tests (cites the incident / states its observable portably / says what breaks without it) | `LH1` / `LH2` / `LH3` |
| the harvest's portability grades (general, domain) | `LH2-g` / `LH2-d` |
| collated harvest candidates, by tier | `LC-` (tier 1), `LD-` (tier 2, with its pack named), `L-` (the shell's own seeded corpus) |
| the export packet and its delivery | the outbox packet, and the inbox pull request under the shell's federation law (§6.0) |


---

## Part IV — the edition genealogy

Six editions, each driven by a committed external measurement, in the order they
landed. It is here in one place because the per-edition tables above answer
*what changed* and none of them answers *what kept changing it* — and that is
the only part of this volume an adopter has any use for.

| Edition | What produced it | What it changed, in one line |
|---|---|---|
| **first** | nothing — written by one seat, no work order, no lifecycle, no countersignature, no audit | It asserted the self-review prohibition in its own text and was the counterexample to it. Its false claims all landed exactly where a posture marker would have been. |
| **second** | a claim-by-claim posture measurement: **128 enforcement and event claims** re-executed against the scripts, workflows, constitution and record by an independent seat — **15 false, 8 owed** | The stamp apparatus. Every enforcement claim acquired a declared posture and a row number, which is the asset every council since has certified. |
| **third** | a **council** of eight independent readers, plus the **first executed cold adoption run** — 18 halts, 3 stops | The shell was named for the first time; nine facsimiles landed; the adoption order was rewritten machinery-first. |
| **fourth** | a **second council** with six blocking revisions carrying acceptance tests | The campaign seal rewritten from the record at an independence boundary; the shell pinned to what this repository can attest; Annex B converted from ledger to schedule. |
| **fifth** | a **sponsor-relayed external grading**, thirteen dimensions, no council; plus two cold readers and a **second adoption run** — 17 halts, 0 stops | Provenance demoted out of running text into annex pointers; the sentinel put in front of every preserved false claim; the unmeasured surface given a derived seam. |
| **sixth** | a **fourth council** — FIT WITH REPAIRS for the document, UNTESTED for the unit — with a closed, ordered scope | Determinism first: the five order defects repaired and their confession deleted, the preflight added, the countersignature given a form. Then **the split**, which created this volume. |

**The pattern worth carrying, and it is the one thing here that generalizes.**
Every edition was produced by a measurement the document could not perform on
itself, and **the anchor moved on contact every time** — six for six. No edition
was produced by its author noticing something. That is not a compliment to the
authors; it is the argument for the instrument: *a document about a process
cannot audit itself, and the only editions that improved it are the ones that
followed somebody else's committed report.*

**And the counter-pattern, which is this volume's own best evidence against the
program that wrote it.** Read the refusal lists end to end: the doc–shell drift
check is named in four consecutive editions and built in none. The posture list
has gone un-re-measured for five. The recovery drill scheduled at the founding
has never run. The escape ledger has never existed. **The editions converge on
prose and diverge on instruments** — which is exactly what §5.1 predicts about
remedies with no mechanical check, applied to the document that contains §5.1.
The fourth council's gate is the first structural answer anyone has proposed to
it: stop grading the writing, and make the next claim wait on the two
instruments (**B.0.4**).
