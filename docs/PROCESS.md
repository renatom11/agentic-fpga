# PROCESS — how this organization works

**This is the process handbook of a multi-agent engineering program.** It
states the seats, the rules they work under, the artifacts they produce, the
disciplines they keep, and the class of failure each of those exists to prevent.
The machinery that mechanically enforces any of it is a separate, runnable
companion repository, named and pinned in **§6.0**.

**What that means for what you can do with this half.** It is **one half of an
export unit** — the half that **explains**; §6.0's shell is the half that
**runs**. Read on its own, this document is a **description**: a rationale-rich
account of a working organization, from which you can understand every control
and rebuild none of them cheaply. **The replication claim belongs to the unit,
not to this half** — an adopter handed only this text and told to execute §6.2
reported roughly one hundred percent of the executable layer invented, and a
second adopter, executing the revised order in a world with no shell, still
invented every line of that layer's logic (§6.0, §6.2). And the instrument that
would bind the two halves — the doc–shell drift check — **does not exist**
`[B.2·9]`, so the unit's two halves are bound by nothing but this sentence and
the pin in §6.0. `[B.9·2]`

**Edition anchor — fifth edition · 2026-08-12 · `docs/PROCESS.md` on this
program's working branch, at the commit that carries this line; written against
`1b684c7`, the commit this revision branched from — three sibling landings
(`232f90f`, `144c1fb`, `22c60fb`) intervened during the round and touched no
path of this document, which is §4.2's inward declaration performed rather than
assumed; one of the three moved an artifact every stamp here cites, and what
that costs is stated at **B.2 item 8**.**
This edition's basis is a **sponsor-relayed external grading of the fourth
edition**, committed verbatim
at `docs/reports/process-council/sponsor-report-card-2026-08-12.md`, together
with the two dated conditions the fourth edition scheduled for itself — both now
executed, with their reports committed and cited (**B.0**). The second edition
was measured claim-by-claim at one commit; that measurement is what every `C-nn`
stamp below cites, and **no stamp in this edition has been re-measured.**
Everything the third, fourth and fifth editions added carries no row, is marked
in place, and is listed one by one — each with the condition, verdict item,
numbered adoption halt or graded dimension that produced it — in **B.8**
(third), **B.9** (fourth) and **B.10** (fifth).
*A stamp is a measurement at one commit. So is a document: an edition with no
anchor cannot be cited, and a reader cannot tell which repository state it
describes.*

---

## Read this first

**Where to go.** *Adopting this:* **§6.2**, the ordered checklist, and **§6.0**
for the half of the export unit that runs. *What this is:* **§1.0**, the
organization in one paragraph. *Looking something up:* the **subsection index**
below the Contents. Everything between here and §1.0 is this document's own
epistemology — how to read its stamps, and what they do and do not cover — and
it is worth reading before you cite anything here, and skippable if you only
need to act. `[B.9·7]`

**Do not import any statement in this document that a control is mechanically
enforced. Check it in your own machinery before you repeat it.** A guarantee
inherited from someone else's document and never verified is the failure of
§2.5's declared external dependency, one level up. This warning sat in §6.1 of
the first edition — thirteen hundred lines in, long past the point where a
reader has started copying rules; §5.8 says prohibitions belong at the top of
the document that carries them, in the imperative, and this is that document
obeying its own rule.

The instruction is not hypothetical. It had never been executed against this
program's own machinery until an independent seat executed it: **128 enforcement
and event claims** re-run against the scripts, the workflows, the constitution
and the record. One it declined to grade rather than guess at, and said so. Of
the 127 it graded, **fifteen came back false and eight came back owed.** Every
one of the fifteen is corrected below and carries a marker saying so. That
measurement is the source of this edition, and it is cited throughout as `C-nn`:
the row number in the posture list that decides the claim.

### What this document contains, and what it deliberately excludes

**Excluded: domain nouns.** No modules, no protocol names, no requirements, no
identifiers, no seat names from the program that paid for this. Seats are named
by function. Where a real episode makes a mechanism legible it appears as an
**anonymized pattern** — *a lead once filed a serious finding against a value
its own packet had specified* — never with the nouns of the work it happened in.

**Included: mechanism.** The commit-script contract, the scope-table format, the
entry grammar, the packet forms. These carry no domain and an adopter cannot
build the layer without them. The first edition deleted them along with the
domain nouns, which is how it came to describe a machine no reader could
construct: three independent reviewers, one of them working from the text alone,
each stalled at the same place — the point where a worker's staged changes become
a commit executed by another seat. That mechanism is now written down (§2.1).

**Where mechanism lives, exactly — the rule this document adopts.** `[B.8·13]`
Two hazards pull in opposite directions. Describe a grammar in prose only, and an
adopter under-determines every file-producing rule — which an executed adoption
run measured at roughly **one hundred percent of the executable layer invented**:
entry syntax, trailer keys, marker names, path layouts, table syntax, rule
numbers, one threshold the text called *stated* and never stated. Restate the
grammar as normative prose, and the document becomes a second, unverifiable copy
of the shell's rule set that will drift from it. So:

> **The shell is the normative source of every grammar. This document carries at
> most one *marked, anonymized facsimile* per artifact class — an instance, not
> a norm — written from the real artifact rather than from the intention
> (§3.3's own rule), with its project nouns replaced by function names.**
> *(No posture row — this document's own drafting rule, binding its author and
> no seat. It is not this organization's law and is not proposed as any
> organization's: it decides where a grammar is written down, not what any
> grammar requires.)* `[B.9·3]`

A facsimile is labelled **`FACSIMILE — instance, not norm`**. It exists so a
reader can see the shape of the thing, write a parser against it, and recognize
the real one; it does not define it, and where the shell and a facsimile
disagree, **the shell wins and the facsimile is the defect**. The instrument
that would catch such a disagreement is the doc–shell drift check named in §6.0,
which does not exist yet and is owed by the exporter — §6.0 states the
consequence once, in full, and this is the pointer to it. Until the check
exists, every facsimile here is a claim about another repository, held to the
same standard as every other claim in this document: **check it before you
repeat it.**

**Included: substrate.** Facts about the runtime the design leans on — that a
spawned agent cannot spawn, that a reader has a maximum single-file size, that
read access cannot be denied per path, what a hosting platform's branch
protection does and does not guarantee. **These are not universal.** Each is
stated in **Annex A** with its anchor and the instruction: *measure this from
your own environment; if your substrate differs, the control's posture changes,
and the annex says how.* A control whose substrate assumption is invisible is a
control an adopter will inherit as a guarantee and operate as a hope.

**Included: the reference implementation.** This document is one half of an
export unit. The other half is an executable shell, named in §6.0. The first
edition never mentioned it, which left step 2 of its own adoption order — "turn
on the mechanical layer" — standing in for a substantial engineering effort with
no artifact behind it.

### Every enforcement claim carries its posture

§5.5 is this program's own rule that a clause must declare whether it is
machine-enforced or review-enforced *in its own text*. The first edition stated
that rule and did not apply it to itself, and every false claim found in it
landed exactly where the missing marker would have been. Each claim below now
carries one of these, with the posture-list row that decides it:

| Stamp | Meaning |
|---|---|
| `[MC · C-nn]` | **Machine-checked.** A script or CI step refuses on violation. |
| `[RE · C-nn]` | **Review-enforced.** A named seat, form or artifact carries it; no instrument. |
| `[P1 · date · C-nn]` | **Performed once, dated.** An event, and it happened, on that date. Not a standing practice. |
| `[PLANNED · C-nn]` | **Owed.** The instrument does not exist. The sentence names what is absent and what would close it. |
| `[CORRECTED · C-nn]` | This text replaces a claim the posture list found **false**. What the first edition said, and what refuted it, is stated in the margin. |
| `[UNANCHORED · C-nn]` | An exhibit whose incident could not be located in the committed record. Kept, marked, and owed an anchor or removal. |

Four properties of the stamps, so they are not over-read:

- **A stamp is a measurement at one commit, not a promise.** `[MC]` says a
  refusal exists today in the machinery that was audited. Your machinery is not
  this machinery — see the warning above.
- **`[P1]` is not `[RE]`.** A performed event is not a practice. Where the first
  edition wrote a single dated event in the present indicative, this edition
  writes the event with its date and, separately, whether anything obliges the
  next one.
- **Failure-class prose is not stamped.** The italic *Failure class* passages
  assert nothing about this program's controls — they generalize an incident —
  so they were outside the audit's frame and are outside the stamping.
- **A claim added after the measurement carries no row, and says so.** The
  posture list is a frozen measurement of the text as it stood when it was
  taken. A claim added afterwards has no row to cite, and citing a row that does
  not decide it would be worse than citing none — so such a claim is marked
  *(no posture row — added after the measurement)*, states its posture in prose,
  and is owed a row at the next audit (**Annex B**). Added and corrected
  **exhibits** — claims about episodes rather than about controls — carry no row
  either; each says in its own margin which seat's confirmation produced it, and
  **Annex B** lists the round that filed them.

**And now the boundary of the whole apparatus, which is the thing to read
before you read anything as evidence.** `[B.8·6]`

> **The stamps do not cover this document. They cover the document it used to
> be.** The posture list measured `docs/PROCESS.md` as it stood at one commit,
> at **1,445 lines**. The text you are reading is **about three and a half times
> that — over five thousand lines.** Well over half of it — every line the second
> edition added in response to the measurement, everything the third edition
> added in response to a council and an executed adoption run, and everything
> everything the fourth and fifth editions add in response to a third council
> and to an external grading — **postdates its own evidentiary spine and has
> never been audited against the machinery.** A stamped sentence and an
> unstamped one sit in the same paragraph, in the same voice, and the stamped
> one lends its authority to its neighbour whether or not the neighbour earned
> it.
>
> **What this edition adds is the seam, in the cheapest mechanical form
> available.** The subsection index below carries, per section, `· n`: the
> number of posture-row citations inside that section, derived by a printed
> command rather than asserted. **A section marked `· 0` contains no measured
> sentence at all** — it is wholly outside the spine. A section marked `· n` had
> *n* of its sentences measured and every other sentence in it not. It is a
> count and not a quality judgement, and it is coarse in one direction only: it
> cannot say how much unmeasured text sits beside a measured claim, which is why
> the zero cells are the ones that carry a complete statement. The complete
> repair remains the re-measurement owed at **B.2 item 8**, which is the
> auditor's artifact and not this document's. `[B.10·1]`
>
> *(Re-measured in each edition rather than carried. **A boundary claim about a
> document's own coverage decays faster than any claim inside it** — every edit
> moves the boundary and none of them touches the sentence — so the way to keep
> it true is to re-measure it in the act that moves it.)*

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

What you can rely on, stated exactly:

- A `[MC]`, `[RE]`, `[P1]`, `[PLANNED]`, `[CORRECTED]` or `[UNANCHORED]` stamp
  carrying a `C-nn` row was decided by an independent seat re-executing that
  claim against the machinery **at that one commit**. Those hold as measurements
  of that state, and an independent re-execution of about twenty-five of them
  confirmed the transcription.
- **Anything without a row is unmeasured.** Not false — unmeasured. It states
  its posture in prose because that is the strongest thing available to it.
- The re-measurement of the grown document against its machinery is **owed**,
  and it belongs to the seat that owns the posture list, not to this document
  (**Annex B**).
- **The posture list is a real file with a path**:
  `docs/reports/audit/PROCESS-claims-posture.md` in this program's repository,
  and it is a row in §6.0's kit table. Until this edition every stamp cited an
  artifact the document never located — which, by §3.1's own evidence rule,
  made the entire apparatus testimony for anyone outside this repository.

### The dialect

Nine terms were absorbed into this program's speech and used here without
definition until a cold reader proved they could not be inferred. **Five came
from the first cold reading and four from the second** — and that is the fact
worth carrying, not the list: *cold-readability is a per-edition measurement,
not a fixture.* Each edition invents vocabulary while correcting the last one's,
and the seat that can see the new opacity is the one that was not in the room.
This edition's own review board had auditor, verification-lead and orchestrator
rows and **no cold-reader row**; the four terms below are what that omission
cost, and **Annex B.1** now carries the row so the measurement is re-run rather
than fossilized. The terms:

- **round** — one spawn of one seat against one commissioned unit of work. Not a
  commit (a round may produce several, or none), not a work order (a work order
  may take several rounds). Every discipline in §4 quantifies over rounds.
- **dispatch** — the instruction text a seat receives at spawn. It may carry a
  work order, or be the whole commission by itself (§3, *dispatch-only*). It is
  distinct from the packet: the packet is versioned and diffable, the dispatch
  is not.
- **cure** — the concrete repair of a filed finding, as distinct from the ruling
  that sustains it. "A cure inside an already-ruled rule" means a repair that
  applies a rule already decided, which is why it owes no new decision record
  (§3.6).
- **limb** — one separable clause of a rule, a finding or a signature, which can
  be sustained, refused or signed independently of its siblings. A finding with
  two limbs can be half-right, and saying which half is the point of the word.
- **guard** vs **rule** — the **rule** is the norm intended; the **guard** is the
  text or check that enforces it. They are not the same object, and the whole
  countersignature discipline (§3.5) exists to ask one question about the gap
  between them: *is the guard exactly the rule, or is it wider?*
- **council** — a convened review round, not a standing body: several
  independent reviewers, commissioned at once against one artifact, each
  reading it from a declared seat (hostile, cold, executor, and so on), each
  returning its own committed report, adjudicated by one chair into a single
  verdict with conditions. It is a *review instrument*, not a seat in §1.2's
  roster; it exists for the artifact class §1.4(a) calls the last one anyone
  routes through review — this document is the only artifact this program has
  ever convened one for. A council's value is that its members do not share a
  reading; where they converge independently, the convergence is the finding.
- **census** — an exhaustive re-derivation of one property over every instance
  of it in the record, run as a single act and reported as a distribution rather
  than an example: every dated stamp against its cited entry, every marker
  against its row, every identifier against its packet. It is what a program
  runs when it stops trusting spot-checks about a class of claim. **A census is
  not one number** (§5.1): it reports what it measured, at what band, over what
  population. Who runs one is whoever owns the property; what triggers one is a
  spot-check that came back wrong twice.
- **surface** — one of the two places a rule can be checked: the **commit
  surface**, the local gate that refuses before a commit object exists, and the
  **pushed-history surface**, the re-check that runs in continuous integration
  over all of history. The word is load-bearing because a rule present on one
  and absent from the other is §2.4's asymmetry defect, and because a stamp that
  does not say its surface has not said where its guarantee holds.
- **margin** — an italic passage, labelled *Margin note*, carrying the
  superseded text a correction replaced and what refuted it. This is a flat
  file with no margins in the typographic sense; the word is inherited from the
  practice, and it names the layer, not the place. **The rule that governs a
  margin is one line: the running line carries the current truth and the margin
  carries the history, never the reverse.** A correction that lives only in a
  margin has not been made.
- **the superseded-text sentinel** — **every margin that preserves a claim this
  document no longer asserts opens with one fixed token**, immediately before
  the preserved text: `SUPERSEDED — historical record, not current law:`. The
  token exists for a reader who never sees this page. A retrieval system that
  returns a fragment of this document returns the false sentence **and its
  marker in the same fragment**, because the two are adjacent by construction
  rather than by layout — which the fourth edition's own fork contract warned
  about and left to the reader's care. **Census at this edition: 47 margin sites
  carry the token**, re-derivable by
  `grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS.md`,
  which returns **50** — the extra three are this entry's own two mentions of
  the token and the row at **B.10** that records the convention. **The token is
  never broken across a line**, whatever it does to the wrapping: a marker split
  by a line break is a marker a grep does not find, which is the whole of what
  it was for.
  A margin without the token is a defect of this edition, not a claim that its
  text is current. `[B.10·5]`
- **annex pointer** — a bare bracketed reference in backticks, of the form
  `[B.9·2]` or `[B.2·9]`, meaning *Annex B, sub-item 9, row 2* and *Annex B,
  sub-item 2, item 9*. It exists to get genealogy out of the running line: where
  earlier editions interrupted a sentence with a parenthetical naming the
  edition, the council item and the numbered halt that produced the passage, the
  running line now carries the pointer and the annex row carries the story. The
  backticks are load-bearing — they keep a pointer lexically distinct from a
  posture stamp, which is bracketed too. `[B.10·2]`

---

## How to read this

Every mechanism below is stated twice: **what the rule is**, and **the class of
failure it exists to prevent**. The second half is the load-bearing one.

**A fact, unlike a mechanism, is stated in full exactly once.** The doubling
above is deliberate and stays. A *fact* — a count, a sample size, a dormancy, a
population — is different: it belongs to one section, is stated there with its
derivation, and appears everywhere else as a one-line pointer to that section.
Where you meet a short claim with a section reference attached, the reference is
where the full statement lives, and there is exactly one such place per fact.
`[B.10·12]`

This is not a stylistic choice. A process description that lists only rules
reads, to anyone who did not live through the incidents, as ceremony — a pile of
paperwork obligations of no evident purpose, from which the cheapest-looking items
are dropped first, and the cheapest-looking items are usually the ones holding the
structure up. The failure class is the part a newcomer cannot reconstruct from the
rule, and it is the part that tells them which rules can be adapted and which
cannot. A rule you understand the failure of, you can re-derive under pressure. A
rule you do not, you will drop under exactly that pressure.

Terms this system uses in a particular way are introduced in **bold** at first
use and then used plainly. Five that the first edition used without ever
introducing are defined in *The dialect*, above, because they are used in more
than one section and a definition at first use would have been read once and
forgotten by the section that needed it.

---

## Contents

1. [The shape of the organization](#1-the-shape-of-the-organization)
2. [The constitution and its enforcement](#2-the-constitution-and-its-enforcement)
3. [The artifact grammar](#3-the-artifact-grammar)
4. [The operating disciplines](#4-the-operating-disciplines)
5. [The failure museum](#5-the-failure-museum)
6. [Adopting this](#6-adopting-this)
- [Annex A: substrate parameters](#annex-a-substrate-parameters)
- [Annex B: what this edition owes, and when](#annex-b-what-this-edition-owes-and-when)
- [Annex C: the name map](#annex-c-the-name-map)

### Subsection index

*Six entries over five thousand lines is not a table of contents, and the second
edition convicted itself of that and declined the repair on the ground that a
hand-maintained derived index decays exactly as §1.6 says derived aids decay.
That ground was right about hand-maintenance and wrong about the repair. This
index is **derived mechanically from the document's own headings**, by the
command printed below, and it carries the state it was last derived at — which
is §1.6's own instruction for a derived aid, applied to this document.*
`[B.9·8]`

**The second column is the seam.** Each entry carries `· n`: the number of
posture-row citations inside that heading's span — the count of sentences in it
that a measured row decides. **`· 0` means the section is wholly outside the
measurement**: nothing in it has ever been re-executed against the machinery.
This is the mechanical form of the boundary block in *Read this first*, and it
is derived rather than asserted. Two limits, stated so the column is not
over-read: it counts **citations, not claims** — a section citing one row five
times reads as five — and it cannot see how much unmeasured text sits beside a
measured sentence, which is why the zero cells are the only ones carrying a
complete statement. The complete repair is the re-measurement owed at **B.2
item 8**, which is the auditor's artifact and not this document's.
`[B.10·1]`

**Derived at:** this edition's commit, 2026-08-12 — **86 headings**, this index's
own heading included. Re-derive it rather than editing it; the list below is
this command's output, one entry per output line, in order, with the leading
`#` markers rendered as list depth and nothing else changed:

```
awk '/^[`][`][`]/ { fence = !fence; next }
     !fence && /^##+ / { if (h != "") printf "%s · %d\n", h, n; h = $0; n = 0; next }
     !fence        { n += gsub(/C-[0-9]+/, "&") }
     END           { if (h != "") printf "%s · %d\n", h, n }' docs/PROCESS.md
```

*(The fence-tracking clause is load-bearing twice over: three facsimiles in this
document contain heading-shaped lines inside fenced blocks — the journal entry's
eight sections, the packet skeleton's return log, the seal's integrity note —
and an index that swallows them is an index nobody can navigate by; the same
guard keeps fenced content out of the seam count. **Annex sub-items are now real
headings** — `A.1`–`A.9`, `B.0`–`B.10`, `C.1`–`C.4` — so the anchors this
document cites most often, starting in its own opening paragraph, are reachable
from its only navigation aid. Earlier editions disclosed their unreachability
instead; that disclosure is deleted because it is no longer true.*
`[B.10·15]`)*

- **Read this first** · 0
  - What this document contains, and what it deliberately excludes · 0
  - Every enforcement claim carries its posture · 0
  - The dialect · 0
- **How to read this** · 0
- **Contents** · 0
  - Subsection index · 0
- **1. The shape of the organization** · 0
  - 1.0 The one-paragraph version · 6
  - 1.1 Why one seat holds both monopolies · 22
  - 1.2 The seats, by function · 5
  - 1.3 Charters — a role is a document, not an understanding · 3
  - 1.4 Separation of duties — five separations, each drawn against a specific temptation · 5
  - 1.5 The auditor is a different kind of seat · 6
  - 1.6 Agents are stateless; the repository is the memory · 3
  - 1.7 Genesis — the bootstrap paradox, and the pattern that discharges it · 1
- **2. The constitution and its enforcement** · 4
  - 2.1 One agent per commit, coupled to a journal entry · 6
  - 2.2 Journals are append-only, and a journal is a chain · 5
  - 2.3 Path isolation — every seat has a write scope · 5
  - 2.4 Mechanical refusal over advisory warning — and the exceptions, deliberately · 4
  - 2.5 Continuous integration is the adjudicator · 3
  - 2.6 The numbered commit rules · 13
  - 2.7 The amendment procedure · 1
- **3. The artifact grammar** · 1
  - 3.1 The journal entry · 5
  - 3.2 Work orders, and the loop · 3
  - 3.3 Sealed predictions · 3
  - 3.4 Findings · 2
  - 3.5 Countersignatures · 3
  - 3.6 Decision records · 2
  - 3.7 Gates · 5
  - 3.8 Sign-offs, and why honest failures are preserved · 3
  - 3.9 Seeded-defect campaigns · 8
  - 3.10 The lessons harvest · 2
- **4. The operating disciplines** · 0
  - 4.1 The abort-first precheck · 1
  - 4.2 Declared siblings, in both directions · 1
  - 4.3 Verbatim relay, with the relayer's additions marked · 2
  - 4.4 Push at every landing · 1
  - 4.5 Incident recovery · 1
  - 4.6 Escalation classes · 1
  - 4.7 The sponsor's reserved decisions · 2
  - 4.8 Refusal is a first-class outcome · 2
- **5. The failure museum** · 0
  - 5.1 Remedies decay without mechanical checks · 2
  - 5.2 A column's name is not its definition · 1
  - 5.3 A relay can demonstrate the hazard it reports · 1
  - 5.4 Timestamps are testimony; entry ids are sequence · 1
  - 5.5 A guard that forecloses conduct is enforced differently from one that routes traffic · 1
  - 5.6 Repairs that verify each other belong in one commit · 1
  - 5.7 The author grading its own homework is the root class · 2
  - 5.8 Two smaller ones worth carrying · 0
- **6. Adopting this** · 0
  - 6.0 The export unit — this document plus the shell · 0
  - 6.1 What transfers, and what has to be re-earned · 1
  - 6.2 The order that works · 1
  - 6.3 The failure of exporting rules alone · 0
- **Annex A: substrate parameters** · 0
  - A.1 — A spawned agent cannot spawn · 0
  - A.2 — One working tree, one index · 0
  - A.3 — The reader's single-file limit, and the thresholds anchored to it · 0
  - A.4 — Read access cannot be denied per path · 0
  - A.5 — Branch protection semantics · 0
  - A.6b — There is no reachable hosting platform at all · 0
  - A.6 — The only environment that can run the suite runs on pushed references · 0
  - A.7 — The large-file threshold · 0
  - A.8 — Capability tiers of the agents themselves · 0
  - A.9 — Two parameters this program does not have, re-labelled not invented · 0
- **Annex B: what this edition owes, and when** · 0
  - B.0 — The dated conditions, and what they returned · 0
  - B.1 — Confirmations this edition owes · 2
  - B.2 — Routed, not performed here · 3
  - B.3 — Instruments named in the text and not in force · 5
  - B.4 — Exhibits owed an anchor or a removal · 1
  - B.5 — A discrepancy in the fourth edition's own source, resolved · 1
  - B.6 — Debts this document still owes its own process · 2
  - B.7 — The correction round, item by item · 3
  - B.8 — The third edition, item by item · 2
  - B.9 — The fourth edition, item by item · 0
  - B.10 — The fifth edition, item by item · 0
- **Annex C: the name map** · 0
  - C.1 — Seats · 0
  - C.2 — Artifacts and instruments · 0
  - C.3 — Packet and identifier tokens · 0
  - C.4 — Vocabulary deliberately not aligned · 0

---

## 1. The shape of the organization

### 1.0 The one-paragraph version

A human **sponsor** owns a small, fixed set of decisions and nothing else. One
**orchestrator** — a single long-running session — is the only seat that starts
other agents and the only seat that writes to version control. Under it sit a
handful of **leads**, each owning one discipline (specifying, building, verifying),
each with a permanent reasoning log. Under the leads, logically, sit **workers**:
short-lived agents spawned for exactly one task packet and never reused. Beside
all of them, reporting to nobody they can grade, sits an **auditor** that can
write only its own findings and can never fix what it finds. Work moves as
versioned files, not as conversation. Every commit carries exactly one agent's
work plus that agent's own explanation of it, and the pairing is enforced by a
script and re-checked by continuous integration. Nothing normative changes without
a numbered decision record and a signature from a seat that did not write it.

*Postures of the claims in that paragraph.* Sole-spawner and sole-committer:
`[RE · C-01, C-06]` — no repo instrument binds who runs the version-control tool,
and §1.1 states the exception history. The auditor's write restriction:
`[MC · C-02]`. Work-to-explanation coupling, script and CI: `[MC · C-03]`.
One agent per commit: `[RE · C-04]` — see §2.1, where the first edition's
justification for calling it automatic was false. Countersignature on normative
change: `[RE · C-05]`, and the counterexample is this document's own first
edition, which landed with one seat, no work order and no signature.

### 1.1 Why one seat holds both monopolies

The orchestrator is the **sole spawner** — no other agent starts an agent — and
the **sole committer**: no other agent runs a commit or a push. `[RE · C-06,
C-07]`

**Both monopolies are rules the seats keep, not properties the machinery
holds.** No instrument in this repository binds who runs the version-control
tool. What the machinery does hold is narrower and real: no seat can commit
*outside its write scope* (§2.3), whoever runs the tool. Read the committing
monopoly as a discipline with a scope check underneath it, and you will build
the right compensating control; read it as a guarantee and you will build none.

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

The first monopoly starts as a fact about the substrate: in the environment this
was built for, a spawned agent cannot itself spawn. Rather than fight that, the
design makes it load-bearing. The hierarchy is honored *logically*: a lead writes
a task packet, the orchestrator spawns a worker with that packet, the worker's
output returns to the lead for review, the lead's verdict travels back out through
the orchestrator. The chain of responsibility is reconstructible afterwards from
the packets, the reasoning logs, and the metadata on each commit — which is a
stronger guarantee than a real spawn tree would have given, because a spawn tree
is not in the repository and these three things are.

**The failure class the spawning monopoly prevents.** Uncontrolled fan-out with
no record of who commissioned what. When any agent can start any agent, the
population is unbounded, two agents can be given overlapping mandates by different
parents, and no later reader can determine on whose authority a piece of work was
done. Attribution failure is not a bookkeeping problem; it is the failure that
makes every other control unenforceable, because a control that cannot name the
party it binds cannot be applied.

The second monopoly — one committer — is what makes the numbering, the ordering
and the attribution of the whole record enforceable by a single authority. Packet
numbers are allocated at commit time by the one seat that commits, which puts
allocation under one authority `[RE · C-08]`.

**History is serialized — and that sentence has two limbs with two different
postures, which is why it is written as two.** `[B.8·27]`

- **The limb a machine holds.** A merge into the trunk must introduce no content
  of its own — its tree must equal one of its parents' — and a merge with more
  than two parents is refused outright. That refusal exists, on the
  pushed-history surface, and it is what this sentence's stamp was measured
  against `[MC · C-09]`.
- **The limb no machine holds.** That work lands on *one* branch, that pushed
  history is never rebased, and that nothing is ever force-pushed rest entirely
  on the hosting platform's branch protection (§2.5) and on **no script
  anywhere** — which is exactly what §2.6's row for the same property says
  `[CORRECTED · C-67]`.

*Re-executed in the fourth edition's round rather than quoted, since the split
is a claim
about instruments:* every enforcement script was read for a force-push, rebase
or branch-name check and none carries one; the merge-triviality and octopus
refusals were located in the pushed-history re-check. **The two limbs were true
separately and false together.** A reader of §1.1 alone inherited a
machine-checked guarantee for a property §2.6 says nothing holds, and the
reconciliation lived only in the posture list's evidence cell — which is to say,
outside the document. **A stamp on a compound sentence is a stamp on its
strongest limb, and it will be read as a stamp on its weakest.**

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

*The residue on serialized history, named.* One branch is enforced for the
lineage that merges; the program also carries a large population of marked
references that are pushed and never merged, for the reason §3.9 gives. That
they have never entered the lineage is a measured fact re-checked by an
independent seat, not a mechanical guarantee `[RE · C-100]`.

**The failure class the committing monopoly prevents.** Concurrent identical
identifiers, interleaved histories that cannot be replayed, and the specific
disaster of two agents committing versions of the same file in an order neither
of them chose. It also removes an entire category of temptation: an agent that
cannot commit cannot quietly commit a fix to the thing it was being graded on.

**The cost, stated honestly.** The orchestrator becomes a bottleneck and a single
point of failure, and its own correct behavior is the one thing the machinery
cannot check mechanically — every other seat is constrained by write scopes, and
the orchestrator's scope is everything `[MC · C-10]`. That residue is *routed* to
the auditor, which audits the orchestrator like anyone else, and to the sponsor,
who is the only party the orchestrator reports to.

*How that residue actually behaved, which is the part worth carrying.* The
orchestrator was audited once, at ratification `[P1 · 2026-08-01 · C-11, C-27]`,
and not again for the whole of the build phase that followed — because the
independent seat was commissioned onto production work for that entire span. **A
residue routed to a seat is only as live as that seat's spare capacity**, and
nothing in the design made the gap visible: the routing statement stayed true in
the document while the practice behind it stopped. This is §5.1's decay class
applied to the compensating control itself, and **the summed table below is the
measurement of how far it went.** An adopter should read it as: *if you route a
residue to your auditor, put the routing on a cadence something else enforces,
or you have routed it to nobody.*

**And here is that residue summed, which no single clause of this document has
ever done and which is the number an adopter actually needs.** *(No posture row
— added after the measurement; every line below is re-derived from the record,
not quoted from a clause.)* `[B.9·6]` Each honest gap in this
document names its own compensating control clause by clause, and every one of
those local statements is true. **Summed, the review-enforced tier — the
majority tier — has been substantially dormant since ratification**, and the
sum is a different fact from any of its parts:

| Compensating control | Where it is claimed | How often it has actually operated since ratification (2026-08-01) |
|---|---|---|
| Audit of recorded reading (*Inputs* sampling) | §1.4(c), §2.3 `[PLANNED · C-23, C-51]` | **Once**, at ratification. Not once over the build phase. |
| Narrative / vacuity sampling of entries | §3.1 `[PLANNED · C-71]` | **Once**, at ratification. |
| Attribution splitting for the unscoped seat | §2.1 `[PLANNED · C-41]` | **Once**, at ratification. |
| Relay-fidelity spot-check on protected classes | §4.3 `[PLANNED · C-109]` | **Never.** Two receiving-seat checks fired instead — a different control (§4.3). |
| The escape ledger | §1.5 item 5, §3.8 | **Never instantiated**; the file has never existed (§1.5 item 5). |
| The recovery drill | §1.6 `[CORRECTED · C-33]` | **Never run.** |
| Re-measurement of the posture list against the grown text | *Read this first*, **B.2 item 8** | **Owed**, three editions running — *as read at this edition's own commit; the artifact moved in its owner's lane during this round and this seat did not open it (**B.2 item 8**).* |
| The doc–shell drift check | §6.0 `[PLANNED]`, Annex B.2 item 9 | **Does not exist.** |
| The advisory warning instruments | §2.4(b), §5.1 `[PLANNED · C-53, C-54, C-119]` | **Unbuilt**; specified in a decision record that is still proposed. |
| Evidence re-execution by the independent seat | §1.5 item 4 `[P1 · 2026-08-01 · C-28]` | **Twice** — ratification, and the measurement behind this document's stamps. |
| Audit of the orchestrator | §1.5 item 3 `[P1 · 2026-08-01 · C-27]` | **Once**, at ratification. |

**The cadence owner, named — and the naming is the finding.** Every interval in
that table lives in **the auditor's charter**, and the auditor is spawned by the
orchestrator and by nobody else (§1.1). **A cadence written into a charter is
owned by whoever spawns that seat**, not by the seat that carries the sentence:
a duty phrased *once per phase* is dischargeable only in a round somebody
commissions, so the interval is the spawner's obligation and the charter is only
where it is written down. This document does not enact that as a duty — it is
another seat's file and would need the amendment procedure (§2.7) — so it is
**routed as an amendment candidate** with its closing event named (**Annex B.2**,
item 10). Until it lands, the honest posture of the whole tier is the table
above: *stated in charters, cadenced in nothing, and operated on the occasions
someone happened to commission it.*

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

### 1.2 The seats, by function

Names vary by program. What matters is the function and the separation.

**The sponsor** (human). Owns a short, fixed list of decisions — described in
§4.7 — and is deliberately excluded from everything else. Reads a single status
file to find out whether anything needs them.

**The orchestrator.** Plans, routes, spawns, commits, escalates. Writes the
program-state file. Applies clerical edits to files whose authority lives
elsewhere — gate signatures (§3.7), packet return logs on the auditor's behalf
(§1.5), constitutional text written in a decision record (§3.6). Never authors
the evidence it is asked to judge `[RE · C-12]`.

**The specification lead.** Owns the specifications, the numbered requirements,
the decision records, and all documentation. Nothing is built that this seat has
not specified; nothing merges undescribed. Also adjudicates interface disputes
between the other leads — and its rulings take the form of a specification diff
plus a decision record, never a verbal agreement.

**The implementation lead.** Owns everything that ships as the product artifact.
Reviews worker output in its line. Never writes the tests that grade it
`[MC · C-13]`. Each lead reviews the worker output in its own line; the duty is
not the implementation lead's alone.

**The verification lead.** Owns the tests, the reference models, the replays and
the measurements, and issues the **sign-off** packets (§3.8) that are a
precondition of merge. Derives everything from the specification, never from the
implementation `[RE · C-14]` — see §1.4(c) for why this one cannot be mechanized
and what carries it instead. The reference models this seat owns are themselves
graded before they may grade: §1.4(e).

**Workers.** Spawned per packet, given exactly the context that packet carries,
returning exactly what it asks for. They share a journal template per **role**,
with each spawn identified by a **spawn short-id** minted into its prompt
(§3.1 — the term is the constitution's, and this document uses it). The
journal's identity is the role, not the spawn — which is what reconciles a
shared log with the rule that no agent writes another agent's journal (§2.2):
successive spawns of one role are one journal identity, and the minted short-id
is what preserves attribution inside it.

**The auditor.** Independent. Audits every seat including the orchestrator.
Writes only its own reports `[MC · C-15]`. Cannot fix what it finds; its verdicts
reach the sponsor unedited `[RE · C-16]`. It is also the seat that authors the
defect manifests of §3.9 — see §1.5, which explains why that is the same duty and
not an extra one.

*A precision the first edition got wrong by one.* **SUPERSEDED — historical record, not current law:** it
said the auditor writes to **one** directory. It is two: its report directory,
and its own reasoning log — which every commit it makes must append to, by the
coupling rule of §2.1, and which is carved out of the scope check for exactly
that reason. The general form matters more than the correction: **a write-scope
statement that forgets the journal carve-out describes a seat that cannot
legally commit anything.**

**Seats are staffed at a capability tier, and the allocation is a design
decision with a budget attached.** *(No posture row — added after the
measurement. Posture: **review-enforced**, carried by the launcher definitions,
which name a tier per seat.)* `[B.8·18]` In this program every long-lived seat
that
**reviews, adjudicates, grades or audits** runs on the strong reasoning tier,
and every short-lived seat spawned per packet runs on the cheaper one. The
invariant, which is the part that transfers:

> **The reviewing tier is at least the producing tier.** A seat may be graded by
> an equal or a stronger reasoner; never by a weaker one.

Get it backwards and the review becomes a formality that cannot see the defect
it was convened for — and it fails silently, because a weaker reviewer returns
*accept* fluently. This is a **substrate parameter** in Annex A's declared
sense: what tiers exist, what they cost, and what one call of each can hold are
facts about your runtime, not about this design. Measure them, then allocate.
Note the second-order cost the invariant creates: it makes the review line the
expensive line, which is precisely the line a schedule crunch will try to
downgrade.

**Contingent seats: chartered before they are activated.** *(No posture row.
Posture: **review-enforced**.)* `[B.8·19]` Not every seat in the roster is
staffed on day
one. A seat that a later phase will need — a second lead in one line when the
work splits, a specialist that only a hardening window uses — is **written into
the roster, given a charter and a scope row, and left dormant with its
activation trigger named**, rather than invented at the moment the work arrives.
The trigger is a stated event (a phase boundary, an overlap condition), not a
judgement call. **A seat improvised under load is a seat whose boundaries are
drawn by the load** — which is §1.3's failure class, arriving through the
roster instead of through the charter.

**Onboarding a seat is one act, not four.** *(No posture row. Posture:
**review-enforced**.)* `[B.8·19]` Whether at the founding or mid-life, a seat
becomes real only when four things land **together**: its **charter**, its
**row in the scope table** (§2.3), its **launcher text** (which makes
charter-reading and the §4.1 precheck its first acts), and its **seeded, empty
reasoning log** — the one case where a seat's journal is created by another seat
(§2.2). Split them across commits and every intermediate state is a defect: a
charter with no scope row describes a seat that cannot commit; a scope row with
no charter grants write access to a role nobody has defined; a launcher with no
seeded log spawns an agent whose first commit is refused by the coupling rule.
This is §5.6's *repairs that verify each other belong in one commit*, applied to
the founding act rather than to a repair.

**The failure class the fixed roster prevents.** Role drift, where a seat under
schedule pressure absorbs an adjacent duty because it is faster to do it than to
route it — and the absorbed duty is almost always a check on the absorbing seat.
Roles that are written down, versioned, and cited in the work can be audited for
drift; roles that are understood cannot.

### 1.3 Charters — a role is a document, not an understanding

Each seat has a **charter**: a versioned file with **nine numbered sections**,
the same nine in every charter this program has. An agent's first mandatory
action on every spawn is to read its own charter and the shared rules
`[RE · C-17]` — the obligation is written into every launcher prompt, and
nothing verifies that the read occurred except the *Inputs* section of the
resulting reasoning log, whose sampling is itself owed (§1.4(c)).

**The nine, complete — because the kit defines the exported charter template by
this list, and the list before it was missing two of them.** *(Re-derived by
reading the section headings of all nine charters in this program's charter
directory: the nine are identical across every seat, worker roles included.)*
`[B.9·10]`

1. **Identity** — the seat's name, its capability tier (§1.2, Annex A.8), who it
   reports to, who spawns it, its journal path, and **its write scope**.
2. **Mission** — what it exists to produce, in one paragraph.
3. **Responsibilities** — the standing duties, each with the artifact it lands.
4. **Interfaces** — one row per counterpart: what it receives, what it delivers.
5. **Inputs, outputs, definition of done** — what a unit of work consumes, what
   it produces, and the checklist that decides it is finished.
6. **Evaluation criteria** — falsifiable, as percentages or counts (§1.5).
7. **Escalation rules** — which classes go up (§4.6), and what is decided in-role.
8. **Journaling and commit obligations** — the entry grammar the seat owes, the
   role-specific rules on top of it, and the seat's harvest duty (§3.10).
9. **Context and references** — the sources it works from, and the read
   restrictions it operates under **stated as unenforceable where they are**
   (§1.4(c), Annex A.4).

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

Charters change only by the amendment procedure (§2.7) — a numbered decision
record, not an instruction `[RE · C-18]`. What holds mechanically is narrower:
the charter directory is outside every seat's write scope but the orchestrator's,
so no seat can amend its own charter. That no decision record accompanies the
amendment is checked by no script.

**The failure class.** Two: an agent that does not know its boundaries invents
them at the moment of maximum inconvenience; and a role that exists only in the
person directing the work cannot be audited at all, because there is no artifact
stating what compliance would have looked like. Writing the evaluation criteria
into the charter is what allows a seat to be graded on something other than the
grader's memory.

*Anonymized pattern.* Before ratification, three independent reviewers were set
on the charter set with different lenses — role coherence, enforceability, and
whether a non-specialist sponsor could read them. They returned twenty-six
findings, one of them critical. All were accepted. It is much cheaper to have the
role definitions attacked before anyone is working under them.
`[P1 · 2026-08-01 · C-19]`

*Two caveats this exhibit owes, and they are the interesting part.* First, the
review happened **before the repository existed**, so its evidence — the
reviewers' outputs and the adjudication — does not survive in version control;
it was reconstructed later only because scratch files happened to survive, and
the retro-audit that reconstructed it said so in those words. Second, the
severity split as originally published was **wrong**, and was corrected in place
by its author's own later act rather than quietly. Carry both: **the adversarial
charter review is the highest-value single act in the founding sequence and its
own evidence was the weakest in the record** — if you run it, run it into
committed artifacts. §1.7 states the sequence this belongs to.

### 1.4 Separation of duties — five separations, each drawn against a specific temptation

**There are five separations, and each is drawn against one specific
temptation.** Two of them are drawn *between* the organization's three working
lines — specifying, building, verifying. The other three are drawn against
temptations that live *inside* a single line, which is why the count of the
separations is not the count of the lines. They are: **(a)** no seat reviews its
own work; **(b)** builders never write the tests that gate them; **(c)** the
test author is blinded from the implementation; **(d)** the party a measurement
grades is not that measurement's check; **(e)** the thing that grades is itself
graded, against something the organization did not write. Each is stated below
with its failure class.

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

**(a) No seat reviews its own work.** Every output is accepted by a seat that did
not produce it `[RE · C-20]`. Where the producing seat is the only competent
reviewer, the review is **split by question, not shared on the artifact**: the
competent seat answers *is the substance correct?* — which no other seat can —
and a second seat answers the one question that does not require competence in
the substance, *is the **guard** exactly the **rule**, or is it wider?* (§3.5,
and see *The dialect*). The second question is what keeps this from being the
self-review the clause forbids: it is answerable by the party the guard will
bind, and its honest answer can be *no*.

*The counterexample is this document.* Its first edition was written by one
seat, landed with no work order, no lifecycle, no countersignature and no audit,
and asserted this rule in its own text. The council that reviewed it was the
first review it ever had, and that review found false claims in it. **A document
stating the self-review prohibition is the last artifact anyone thinks to route
through it** (§5.7).

*Failure class.* Self-certification. It is not that agents lie; it is that an
author reads their own artifact for what they meant, and a reviewer reads it for
what it says. The gap between those two readings is where nearly every defect in
this record lived.

**(b) Builders never write the tests that gate their own artifacts.** The
implementation line cannot write in the test tree, and the verification line
cannot write in the implementation tree. This is enforced at the boundary — as a
refusal at commit time — and not as an instruction. `[MC · C-21]` *(Probed in
both directions on both surfaces; this is one of the claims that survives its own
§6.1 test unqualified.)*

*Failure class.* The quiet repair of the failing check instead of the failing
artifact. Under time pressure this is not even experienced as cheating; the test
looks wrong because the implementation looks right, and one edit makes the
problem go away. The boundary removes the option rather than the temptation.

**(c) The reviewer is deliberately blinded from the implementation.** Test
authors are given the specification and not the code. Their task packets omit
implementation source on purpose, and the packet records that omission as a
property of the packet.

*Failure class.* Tests that encode what the code does rather than what the
specification requires. Such a suite is perfectly green and completely worthless:
it will fail if the implementation changes and pass if the implementation is
wrong, which is the exact inverse of what a test is for. This separation cannot
be enforced by file permissions — nothing in the agent runtime this was built for
can deny read access to a path (**Annex A**, and measure it in yours) — and the
process is explicit that it is enforced instead by prompt content, packet content
`[RE · C-22]`, and audit of the *Inputs* section of each reasoning log
`[PLANNED · C-23]`. **Naming an unenforceable control as unenforceable is itself
a control**; the alternative is a compliance claim that nobody has ever checked.

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

**(d) The party a measurement grades cannot be that measurement's own check.**
Where a rule creates a check on a seat, the check is routed to someone else — and
if the natural reviewer of an artifact is the very party the artifact grades,
that routing is a defect regardless of how convenient it is.

*Anonymized pattern.* `[UNANCHORED · C-24]` A residual risk in an amendment was
routed, in the amendment's own text, to "review by the ordinary reviewing lead" —
where that lead was the party the rule under discussion measured. Three seats
independently said so, including the seat whose duty the correction enlarged,
which asked for the enlargement. The routing was corrected to the independent
seat.

*Why that exhibit carries a marker.* The audit of this document could not locate
this episode in the committed record, and said so rather than forcing a posture.
Neither could the fourth edition's round. Under this program's own evidence rule
(§3.1), a
claim whose support cannot be re-executed may not be stated as fact — so the
pattern is kept, marked, and owed either an anchor or its removal (**Annex B**).
It is retained rather than deleted because the *rule* it illustrates, (d), is
independently anchored: the same shape is codified in the constitution and
recurs as the first disguise in §5.7. **An unanchored exhibit is a different
defect from an unanchored rule, and collapsing the two is how good rules get
deleted with their bad exhibits.**

**(e) The thing that grades is itself graded, against something the organization
did not write.** A reference model may not judge an artifact until it has been
shown to agree with an **external anchor**: an independent implementation of the
same specification, obtained from outside the organization that produced both the
artifact and the model. The agreement is established **per stimulus class**, and
what the anchor does *not* cover is stated in the same place as what it does.
**The obligation is an ordering one, which is what makes it checkable**: the
agreement has to be committed *before* the first verdict the model issues, so a
later reader audits it from the order of the record rather than from anyone's
testimony.
*(No posture row — added after the measurement. Its posture is **review-enforced**:
in this program the rule is constitutional, it is a named precondition in the
verification lead's charter — which also makes the ordering a duty of the
independent seat to check — and it is a numbered criterion of the one sign-off in
the record. No script reads any of the three.)*

*Failure class, and it is the one this document came closest to exporting.* A
model and an artifact built inside one organization, from one specification, by
parties who read that specification the same way, **agree with each other exactly
where both are wrong** — and that agreement is reported as a pass. The other four
separations keep the grader away from the thing it grades; this one stops the
grader's own correctness from resting on the same reading that produced the
subject. Without it every mechanism in §3.9 still runs, the sign-off form of §3.8
is still filled in honestly, and the apparatus certifies an artifact against an
oracle nobody ever checked. Note what this costs: an external anchor is something
you must *obtain*, and the rule is therefore the one separation here that can be
defeated by a schedule rather than by a temptation.

*Anonymized pattern, and the honest half is the useful one.* The single sign-off
in this record reports the anchor **per stimulus class** — each anchored class at
its own build and run identifiers, the *absolute* half of the check named
separately from the *agreement* half, and each class's "does **not** anchor" list
carried in the same cell as its claim. It then states, in terms, that the anchor
is **undischarged at the level of the whole artifact**, and it bars the sentence
*"the comparison anchors this artifact"* from appearing anywhere in the packet.
The form worth copying is not the passing anchor; it is the refusal to let five
passing classes be summed into an artifact-level claim nobody measured.

### 1.5 The auditor is a different kind of seat

The auditor is not a stricter reviewer. It is structurally distinct in five ways,
each of which is a control:

1. **It can write only its own reports.** Not the specifications it audits, not
   the tests, not the artifacts, not even the shared task packets. This is
   enforced mechanically `[MC · C-25]` — one of the claims from the first
   edition that survived its own §6.1 test with no qualification at all;
   §1.4(b)'s boundary between the building and verifying lines is another.
   *(**SUPERSEDED — historical record, not current law:** the previous edition called this
   "**the** one" while §1.4(b) called itself
   "**one of** the claims" that survived unqualified. Both could not be right,
   and a reader could not tell which sentence to trust — the singular is
   withdrawn here rather than asserted with a count nobody has re-measured.
   Corrected in the fourth edition.)* `[B.8·35]`
2. **It never fixes what it finds.** A finding is routed to the owner, who
   repairs it. An auditor that repairs is an auditor with an incentive to find
   what it can repair. `[MC · C-26]` — same instrument as (1): it cannot stage
   the artifact it would repair.
3. **It audits the orchestrator too** — including the seat that spawns it.
   `[P1 · 2026-08-01 · C-27]`
4. **It re-executes evidence.** Claims in a reasoning log's evidence section must
   reproduce at that commit, and the auditor is the seat that re-runs samples.
   This is what makes the evidence sections falsifiable rather than decorative.
   `[P1 · 2026-08-01 · C-28]` — **stated as a duty, not as a running practice.**
   Sampling was performed at ratification and, at this writing, twice in the
   program's life; the second instance is the audit that produced this edition's
   stamps. Between them lay the entire build phase. §1.1's residue note explains
   why, and Annex B carries the obligation.
5. **It owns the ledger of what verification missed.** Every divergence
   discovered **after** a sign-off has passed — in a later replay, in an
   integration, in an audit — is recorded in a standing ledger owned by the
   auditor, in the auditor's own report directory, **not by the line whose
   sign-off missed it**. Each entry names the sign-off that let it through, the
   event that surfaced it, and the owning line's own account of the root cause.
   *(No posture row — added after the measurement. Its posture is
   **review-enforced**: the ledger is a mandatory artifact of the auditor's
   charter and a checked item of its definition of done, and no script reads
   it.)* `[B.8·17]`
   **Sample size, disclosed in the same terms §3.8 uses for the sign-off form:
   zero. The ledger has never been instantiated — the file the auditor's charter
   names has never existed, at any commit, in this program's history, and no
   escape has been recorded because there is nowhere to record one.**
   *(Verified by searching the whole history for the path and for any file of
   that name: no such file was ever added.)* `[B.9·6]` Read that against the
   clause above rather than around it: what is described is a **designed**
   control with a named owner, a named artifact and named fields, and **no
   instance**. A reader who cannot tell *no escapes yet* from *ledger running*
   has been told nothing, and the difference is exactly the one a later reader
   most needs (§3.8). The two candidate readings are not equivalent and this
   program cannot presently distinguish them: either verification has missed
   nothing since ratification, or nothing has been looking. The instrument that
   would decide it is the auditor's per-phase replay reproducibility duty, and
   §1.1's summed table says how often that has run.

*Why this is a separation and not bookkeeping.* A verification line that keeps
its own record of its own escapes controls the count of its own misses, which is
§5.7's root class wearing an accountant's coat: the seat with the strongest
motive to grade an escape as "not really an escape" is the seat that signed the
artifact off. Moving the ledger to the seat that cannot repair anything makes
the count adversarial. And it is the only instrument in this document that can
distinguish **"we fixed it"** from **"we never had the problem"** — the
distinction §3.8 says a later reader most needs, and which no sign-off, however
honest, can supply about itself. **A process with sign-offs and no escape ledger
measures its verification by its verification's own opinion of it.**

**And the seat that authors defect manifests is this one.** §3.9's campaigns
need an independent seat to compose the deliberate defects, and a cold reader of
the first edition could prove that seat did not exist: the verification lead is
the subject under test, the orchestrator is the operator, and the auditor was
described as writing *only its own reports*. The resolution is that a defect
manifest **is** one of its own reports — manifests are authored into its report
directory, under its own identity, and are therefore inside the same write scope
that (1) enforces. Nothing is relaxed; the reading is stated because without it
the mechanism has no author. **A roster that forbids more precisely than it
enumerates will eventually forbid a duty it also requires** — and the way to find
those is to hand the roster to a reader who has only the document.

Because the auditor cannot write into shared packets, its verdicts on those
packets are recorded in its own committed report, and the orchestrator transcribes
them into the packet under its own identity — a clerical transcription whose
authority lives in the auditor's artifact, not in the transcription
`[RE · C-29]`. The prohibition half is mechanical; the transcription duty is a
convention, and a transcription that never happens leaves the verdict live in a
report nobody routed.

**What carries all of this is the auditor's charter — and it is the charter an
adopter most needs and least can reconstruct.** `[B.8·20]` This document leans
on that
one charter for a striking share of its **review-enforced** postures: the
relay-fidelity sampling of §4.3, the *Inputs*-section audit that compensates for
unenforceable read restrictions (§1.4(c)), the ordering check on §1.4(e)'s
external anchor, the escape ledger above. An adopter who writes charters from
§1.3's field list alone regenerates none of them — and §1.1's residue lesson
says a control routed to the auditor dies exactly where the auditor's charter
has no cadence. The mechanisms in it that are domain-free and load-bearing are
these:

- **Cadenced duties, not standing intentions.** Duties phrased with their
  interval — *once per phase, re-run one full validation replay from the
  committed manifest and confirm it reproduces the verification line's result* —
  rather than as things the seat does when it can. A duty with no interval is
  the residue §1.1 describes.
- **The escape ledger as a named owned artifact**, with the fields each entry
  must carry (item 5 above).
- **The canary interface, stated as an information rule**: *I am told nothing in
  advance, and there is no other direct contact with the sponsor.* Written into
  the charter, it makes the power of §1.5's canary clause operable without
  making any instance discoverable.
- **No direct interface with workers.** Findings about a worker's output go to
  that worker's lead, never to the worker. Otherwise the auditor becomes a
  second reviewing line, and a seat that can direct work can be argued to own
  some of it.
- **Evaluation criteria written as falsifiable percentages** — *100% of findings
  carry a checkable citation; a finding successfully rebutted as uncheckable
  counts against the seat* — rather than as virtues. A criterion nobody can fail
  grades nobody.

*Margin note.* **SUPERSEDED — historical record, not current law:** through the
fourth edition the line above read *"Four mechanisms in it are domain-free and
load-bearing"* over a list of **five** — a header count standing over its own
list, which is the defect §1.4's margin convicts, recommitted. An independent
record audit filed it; that edition marked it and did not repair it, the repair
being outside the round's commissioned scope. **The fifth edition drops the
count rather than asserting a new one**, and the enumeration is still owed a
round (**B.9**, refusal 3). `[B.10·4]`

*Where the skeleton itself belongs, and why not here.* The **anonymized auditor
charter goes in the kit as a template file** (§6.0), not into this document as a
block of prose. Copying a normative artifact into the explaining half creates a
second copy that drifts — the exact hazard §2.4 names as *a rule and its check
that disagree*, one level up — while the mechanisms above are not a copy of the
charter but the reasons the postures in this document survive. **Export the
artifact once, in the half that runs; export the reasons in the half that
explains.**

**The failure class.** An auditor with edit rights on what it audits produces an
unfalsifiable record: after the fact, no reader can distinguish "this was always
compliant" from "this was made compliant by the auditor." The write-scope
restriction is what makes the audit trail evidence rather than testimony.

**The sponsor's standing power over this seat: canaries.** The sponsor may
deliberately plant a process violation — hand-edit a record, ask for an altered
relay — to test whether the auditor catches it, and tells nobody in advance. A
missed canary is a critical finding against the auditor. The mechanism is
documented; **no instance is ever announced in advance, and none is
discoverable by construction before it is caught.** `[RE · C-30]` Once caught,
an instance is necessarily documented — it becomes a finding like any other.
*(**SUPERSEDED — historical record, not current law:** the first edition said
the instances "never are" documented, which contradicted the finding route in
the clause after it.)*

*And a note about where that correction had to land, because the shape recurs.*
The same contradicted sentence stood, in almost the same words, in the
sponsor-facing guide that this program's holder of the canary power actually
reads. The last revision cured it **here**, in the document describing the
mechanism, and left it standing **there**, in the document operating it. An
independent seat found the pair and filed it. **A contradiction cured in the copy
and left in the source is not cured**: the source is what its own audience reads,
and the next document derived from it inherits the defect with the copy's
correction nowhere in sight. Both now say the same thing (**Annex B**).

*Failure class.* An auditor is the one seat whose failure is invisible by
construction: a silent auditor and a clean program produce identical output. The
canary is the only instrument that distinguishes them.

### 1.6 Agents are stateless; the repository is the memory

Every agent starts each spawn with no memory of the last one. Continuity lives
entirely in committed files:

- **charters** — who you are;
- **reasoning logs** — what was done and why;
- **packets** — what is owed and to whom;
- **the program-state file** — the live picture: current milestone, open work,
  gate status, pending escalations, and the name of the working branch
  `[RE · C-31]`;
- **the roster file** — one row per seat, pointing at its charter and its log:
  the entry point of the recovery sequence below, and the only artifact that
  tells a fresh reader which seats exist at all;
- **a journal index** — one row per log with its last entry and a one-line
  summary, designed as a boundary-refreshed navigation aid and, in this record,
  **written once at the founding and never refreshed since** `[CORRECTED · C-32]`.

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

**FACSIMILE — instance, not norm.** The two files the recovery sequence opens
first, with every seat named by function and every domain noun generalized.
They are here because the sequence below is unexecutable without them and the
previous edition gave neither a shape: a reader could not tell whether the
roster is a table, a directory listing or a paragraph. *(Written from this
program's own two files.)* `[B.9·11]`

```
# --- the roster file ------------------------------------------------------
# One row per seat. The entry point of the recovery sequence, and the only
# artifact that enumerates the seats in one place.

| Seat            | Tier   | Reports to   | Charter        | Journal        | Status            |
|-----------------|--------|--------------|----------------|----------------|-------------------|
| orchestrator    | strong | sponsor      | <path>         | <path>         | Active            |
| <lead>          | strong | orchestrator | <path>         | <path>         | Active            |
| auditor         | strong | orchestrator | <path>         | <path>         | Active            |
| <worker role>   | cheap  | <lead> (log.)| <path>         | <shared path>  | Worker template   |
| <contingent>    | strong | orchestrator | <path>         | seeded at activation | Contingent (<trigger>) |

# The Status column is load-bearing twice: it carries §1.2's contingent seats
# with their activation trigger, and it is what lets a roster row exist for a
# seat whose onboarding act has not landed yet (§6.2 Step 1a) without claiming
# a seat that cannot legally commit.

# --- the program-state file -----------------------------------------------
# The live picture. The committing seat updates it in the same commit as any
# state change it describes.

# Program state
<how a fresh session rehydrates: this file → the constitution → the roster →
 the log tails of seats with open work; and the name of the working branch>
## Current milestone
## Milestone roadmap
## Gates            <one row per gate: gate, status, link to its checklist>
## Open work orders <one entry per live commission, with its state>
## Pending escalations to the sponsor
## Decisions on record
```

The recovery procedure is written down: a fresh orchestrator reads the
program-state file, then the shared rules, then the roster file, then the tails
of the logs of any seat with open work. **A drill — kill the orchestrator
mid-program and rehydrate on purpose — is a scheduled obligation of the first
phase and has not yet been performed.** `[CORRECTED · C-33]`
*(**SUPERSEDED — historical record, not current law:** the first edition stated it as an exercised fact.)*
The record contains no drill in any log, gate or board row, and the
constitution schedules it in the future tense. By this document's own next
sentence, the recovery procedure is therefore currently a **hypothesis**, and
the claim that the org survives the loss of its orchestrator may not presently
be made. It is stated here as owed, with its closing event named, so that a
reader can see the debt rather than inherit the confidence.

**The failure class.** A program whose real state lives in one session's context
window dies with that session, and it dies silently: the replacement session
starts confidently from a partial picture. Everything above exists so that the
loss of any agent, including the orchestrator, costs a re-read and not a restart.
The drill exists because an untested recovery procedure is a hypothesis.

### 1.7 Genesis — the bootstrap paradox, and the pattern that discharges it

Every rule in this document is enforced by a seat that some earlier act created.
Run that backwards and it terminates in an act no rule authorized: **the first
seat writes the constitution that binds it, grants itself the scope it will
operate under, and commits the first commits under a protocol that does not yet
have anyone to check it.** The auditor does not exist during the range it will
eventually audit. The countersignature rule has nobody to countersign. §5.7's
root class — the author grading its own homework — describes the founding
sequence exactly, and no amount of care inside the sequence removes it.

The paradox cannot be dissolved. It can be **paid down**, and the pattern that
pays it is the most portable thing in this section, because every adopter starts
where this program started. Four acts, in this order:

**1. Found it, and mark the founding as self-signed.** The founding commits are
one seat's work, admitted as such rather than dressed as process. What is *not*
deferred is the machinery: the commit rules, the append-only journals, the scope
table and the continuous-integration re-check are turned on **before the first
real work order**, so that the founding range is itself subject to the rules it
introduces `[P1 · 2026-08-01 · C-127]`. The history you most want the guarantees
for is the earliest history, and it is the only history you cannot retrofit them
onto honestly.

**2. Launder the roles through adversarial review, before anyone works under
them.** Three independent reviewers, different lenses — role coherence,
enforceability, readability by the non-specialist who will sponsor it — attacking
the charter set. This is cheap precisely because nothing has been built yet: a
role definition attacked at hour one costs a rewrite, and the same defect found
at the first gate costs everything done under it (§1.3, with the two caveats that
exhibit owes).

**3. Have the one act performed that no seat inside can perform for itself:
ratification by the sponsor.** The organization cannot vote itself legitimate.
This is the whole reason the sponsor seat exists with a surface as small as §4.7
describes — it is not a stakeholder, it is the external act that makes the
internal ones binding.

**4. Retro-audit the entire bootstrap range, as the auditor's first act, with the
audit's own weakness declared in it.** The seat that did not exist during the
window audits the window from artifacts alone and says so in the report: *I
witnessed none of this; discount this audit accordingly, and every audit after it
is stronger.* Two properties make this more than ceremony. It returned findings —
seventeen of them, one critical — which is the evidence that it could have. And
the gate **blocked on the critical finding** until a decision record dispositioned
it and the same seat re-verified the disposition in a second report; a gate that
cannot block is a gate that measures nothing.

The gate itself is the artifact: one checklist, every item owned and signed by a
journal-entry reference, including the two items the sponsor owns and the item
that closes only on the auditor's re-verification. Only when every row is signed
does the first real work order issue.

**The rule that generalizes.** *Legitimacy at the founding is not claimed, it is
amortized: the founder performs the acts it can, and each subsequent act is one
the founder could not have performed for itself.* An adopter who skips act 2 has
roles nobody attacked; who skips act 3 has an organization that authorized
itself; who skips act 4 has a bootstrap range permanently exempt from the rules
everything after it obeys — and that range contains every decision the rest of
the program inherits.

*Failure class.* The self-authorizing founding, whose signature is invisible
because it is everywhere: an organization whose earliest and most consequential
commits are the only ones no control ever touched, defended by the observation
that no control existed yet. The defense is true and is exactly the problem. The
four acts exist to convert "no control existed yet" into "the controls were
applied late, by parties who could return a no, and here is what they returned."

*What this program's own genesis still owes, stated so the pattern is not read as
a clean sheet.* The adversarial review's evidence does not survive in version
control (§1.3). The retro-audit's severity tally was published wrong and
corrected in place by its author. And the recovery drill scheduled at the
founding has still not been run (§1.6). The pattern is sound; this instance of it
is not finished.

---

## 2. The constitution and its enforcement

There is one shared rules document — the **protocol** — that every agent reads
before acting `[RE · C-34]`. It is the constitution: it defines how work moves,
how reasoning is preserved, and how the rules are mechanically enforced. It is
amended only by the procedure in §2.7 `[RE · C-69]`, and only the orchestrator
commits it `[MC · C-35]` — the second limb is scope-enforced and holds; the first
is a procedure no script tests.

Two properties are stated as non-negotiable, and everything else in this section
is machinery for holding them:

1. **Traceability** — for any two commits, the diff between them shows both the
   change and, adjacent in the same diff, the responsible agent's own explanation
   of it. No reasoning is lost. `[MC · C-36]`
2. **Independence** — verification is never graded by the party that built the
   thing, and the auditor is never graded by anyone it audits.

*The strongest evidence for property 1 is this edition.* A reader with no
session context, no participation in any round, and nothing but the repository
was able to take the first edition's claims one at a time and **mechanically
falsify fifteen of them against the program's own record** — in one pass, citing
a file and line for each. That is traceability doing the only thing that makes it
worth its cost: letting a stranger convict the program from its own artifacts.
An organization whose record cannot be turned against it has a record that proves
nothing.

### 2.1 One agent per commit, coupled to a journal entry

Every commit carries exactly one agent's work, and must also carry a pure
end-of-file append to that agent's own reasoning log containing a new entry. Work
without an entry is refused `[MC · C-37]`. An entry without work is allowed only
when explicitly marked as such — the mark is a named trailer on the commit
message, and the entry's file list must be the empty marker `[MC · C-38]`.

The commit message ends in fixed metadata: the agent's name, the work-order
identifier or `none`, and the entry id `[MC · C-39]`. That metadata is what makes
an agent's entire thread of work recoverable with a single log query.

**FACSIMILE — instance, not norm.** The trailer block as this program's
machinery actually writes and checks it, with the seat name anonymized. Three
keys are always present; the fourth appears only on a journal-only commit. All
four are **protected**: they may not be supplied as extra trailers, may not be
duplicated, and may not be shadowed by a later line — the commit gate refuses,
and the pushed-history re-check refuses again.

```
Agent: <seat-name>
Work-Order: <packet-id | none>
Journal-Entry: J-<seat-name>-<NNNN>
Journal-Only: true          # only on a commit with no work products
```

The **empty file-list marker** that must accompany a journal-only commit is the
literal line `- (none)` under the entry's file-list heading — the marker §2.1's
rule above calls *the empty marker* and never names. Informational trailers
(co-authorship, session references) may be appended beside these; the four keys
above are refused as extras precisely so an author cannot mint a second `Agent:`
line and choose which one a reader believes.

*Why an adopter cannot skip this block.* Every rule in §2.6 that quantifies over
"the metadata" is unimplementable without the key names, and an adopter who
invents their own gets a working machine that enforces **a** version of these
rules with no way to show it enforces **this** one. That is not hypothetical: it
is what the first executed adoption run reported, in those terms, as its second
most expensive halt — and the second run, handed this facsimile, did not have to
invent any of it.

**How a commit actually happens**, since every rule above quantifies over an act
the first edition never described. There is one working tree and one index; "each
agent stages only inside its scope" is not a version-control feature and cannot
be one. What happens is:

1. The acting seat edits files and appends its journal entry **in the working
   tree**. It runs no version-control write command of its own.
2. It returns, naming the exact set of paths it touched. That set is also
   declared inside its journal entry (§2.6, files-list equality).
3. The orchestrator stages that set and invokes the commit script **with the
   acting seat's identity as a parameter** — the identity is an argument, not an
   inference from the diff.
4. The script evaluates every rule against *that* identity: is every staged
   non-journal path inside that seat's scope, is the staged journal that seat's
   own and a pure append, is the entry id exactly one past the chain's last, does
   the declared file list set-equal the staged paths. Any failure aborts before a
   commit object exists.
5. On success it writes the commit with the fixed trailers, including the
   identity it was given.

Two consequences worth stating, because they are what make the model work.
**The identity is asserted by the committer and checked against the scope table,
not proven** — so the scope table's value is that a mis-asserted identity gets
refused the moment it touches a path outside the asserted seat's scope, and the
residue is a committer that asserts an identity whose scope covers the paths
anyway. That residue is the orchestrator's, and it is the subject of the honesty
note below. And **serialization is required, not incidental**: one tree and one
index means two seats cannot be mid-edit in the same tree, which is precisely
what §4.1 and §4.2's precheck disciplines police.

**The failure class.** Reasoning that is lost between the decision and the diff.
Six months later, a reviewer looking at a strange line has two options: re-derive
the decision, or assume it was deliberate. Both are wrong roughly as often as they
are right. Coupling makes the third option — read the author's own account, in the
same diff — always available, and makes it impossible for work to land without one.

A second failure class, subtler: **attribution collapse**. When one commit
contains two agents' work, no later reader can tell which seat is answerable for
which hunk, so no review verdict can be aimed and no rule can be applied to the
responsible party.

*Honesty note, corrected.* `[CORRECTED · C-40]` **SUPERSEDED — historical record, not current law:** the
first edition — following the constitution's own words — said that for seats
with narrow write scopes, one-agent-per-commit *falls out of the scope rules
automatically*, because a commit physically cannot mix two scoped seats' files.
**That is false, and it is the most consequential false claim in the first
edition**, because it is the sentence that tells an adopter it need not audit
attribution for scoped seats.

The scopes are **not disjoint**. In the audited scope table, the packet directory
is granted to three leads and all four worker roles; the implementation tree to a
lead and its worker; the test tree to a lead and two worker roles; the tools tree
to a lead and one worker. A commit staging two packets authored by two different
leads passes the path-isolation check under either identity. The emergence is
real only for **disjoint pairs**, and the claim was stated universally.

What is actually true, and what an adopter should carry:

- **One journal append per commit is the mechanical invariant** `[MC · C-59]`.
  That is what the machinery holds, in every case, for every seat.
- **One agent per commit is emergent only where the two seats' scopes are
  disjoint**, which is a property of your scope table, not of the rule. Compute
  it: for every pair of seats, intersect their scopes. Every non-empty
  intersection is a pair for which attribution is review-enforced.
- **For the seat whose scope is everything, splitting is audit-enforced**, and
  that audit is presently owed `[PLANNED · C-41]` — it has been performed once,
  at ratification.

A control that is claimed to be mechanical and is not is worse than a control
known to be advisory, because the claim suppresses the compensating vigilance —
which is exactly what this note's own first edition did.

*Routed, not applied.* The same false premise sits in the constitution's own
honesty note on this rule, in the constitution's own words. Repairing it there is
an amendment: it is another seat's file, and it needs a numbered decision record
rather than a documentation edit. It is recorded as an amendment candidate in
**Annex B** and is not touched here. **Discovering that a document's error was
inherited verbatim from its source does not authorize the reader of the source to
edit it** — that route is §3.6's "the instrument does not edit the file it
governs", read from the other end.

### 2.2 Journals are append-only, and a journal is a chain

Each agent has one reasoning log — a **journal** — that begins with a frozen
header and thereafter grows *only* by whole entries appended at the end. Nothing
above the last byte is ever edited `[MC · C-42]`. No agent writes another agent's
journal `[MC · C-43]` — the one exception being the creation of an empty,
entry-free volume for a seat that has none, which is how a new seat is onboarded.
That seeding is not a step on its own: it is one of the four things §1.2 requires
to land **together** when a seat is created, at the founding or mid-life, and a
seed committed ahead of the seat's charter and scope row describes a seat that
cannot legally commit.
The commit gate verifies the append byte-wise: the version at the previous commit
must be a prefix of the version being committed, and journal deletion and
renaming are refused outright.

Corrections therefore append. A mistake in an earlier entry is corrected by a
later entry that names it, never by editing it. The same discipline extends to any
frozen record: a superseded row is marked, not rewritten.

**The failure class.** A record that can be tidied is not evidence. The damage is
not limited to the edited entry: if any past prediction can be improved after the
result is known, then no prediction in the file can be trusted, including the
honest ones. Append-only is what converts a diary into an audit trail.

**Volumes and the chain.** Journals grow without bound, and a file that exceeds
what a reader (human or agent) can load in one piece stops being read at all. The
remedy is rotation — a new volume file — and rotation is exactly where the
append-only guarantee silently breaks, because a per-file check cannot see a
volume that was dropped. So a journal is defined as a **chain**: each new volume
carries, in its frozen header, the previous volume's path, its SHA-256 and its
byte count. The active volume is the highest-numbered one; every earlier volume is
frozen and any change to it breaks the successor's recorded hash `[MC · C-45]`.

**FACSIMILE — instance, not norm.** The frozen header block of a rotated
volume, with the seat name anonymized. The field names are what the machinery
actually reads; an adopter who invents different ones has a chain no
reimplementation can verify.

```
# Journal: <seat-name> — volume 05

- **Volume**: 05
- **Continues-from**: J-<seat-name>-0045
- **Previous-volume**: journals/<seat-name>.v04.md
- **Previous-volume-sha256**: <64 hex digits>
- **Previous-volume-bytes**: 227077
```

*Which of those fields is structure and which is testimony* `[MC · C-44]`,
because §5.4 demands that a record say so and this one did not. Path and digest
are **checked**. `Volume` and the continuation id are **checked**. The **byte
count is checked by nothing** — it is an author's assertion sitting in a list of
verified fields, which is the precise shape §5.4 warns about. It is kept because
it is cheap to read and it fails loudly against the digest if it is wrong; it is
marked because an unmarked assertion inside a verified block borrows the block's
authority.

**Where the chain is verified, by limb.** *(Re-executed against the scripts
rather than quoted.)* `[B.8·37]`

- On the **commit surface**, the gate verifies the chain **headers on a rotation
  commit** — that the predecessor exists and is untouched, that the declared
  volume number, back-link path, digest and continuation id are right — and
  verifies **entry-id monotonicity across the chain** on every commit. It does
  not walk every volume on every commit.
- On the **pushed-history surface**, the re-check walks the whole chain: gapless
  numbering, back-link, digest, and contiguous entry ids across every seam.
- A **standalone chain verifier** performs the same walk from a bare checkout
  with no history at all, which is what makes the property checkable by a
  stranger who has only a clone. It is the fifth enforcement script, and it is
  in the kit table of §6.0.

The stamp stands; its *scope* is the correction. **SUPERSEDED — historical record, not current law:** the
claim the bullets above replace was *"re-verified on every commit and again
over pushed history"* — two claims wearing one stamp, **true of the part that
changes on that commit and false of the walk**. The distinction matters to
exactly one reader: the one building the layer.

*Failure class.* A guarantee that is checked per file rather than per identity.
Without the chain, "this file is append-only" remains true of every file while an
entire volume of history disappears.

There are two size thresholds: a soft one that warns and a hard one that refuses,
both anchored to a **measured substrate fact** — the largest file the agents'
own reading tool will return in one call — rather than to taste, so that changing
them is a parameter edit with the anchor restated rather than an argument. The
numbers and their anchor are in **Annex A**; measure yours before copying them.
`[MC · C-46]` — **on the local commit surface only.** The re-check over pushed
history contains no size check at all, so an append that bypasses the local hook
lands unnoticed. This is the live instance of §2.4's own both-surfaces corollary,
inside the very rule family that minted it; the instrument that would close it is
a proposed decision record, not in force at this writing (**Annex B**).

### 2.3 Path isolation — every seat has a write scope

Each agent may stage changes only inside its declared scope. The scope table is
part of the constitution, and it is checked at commit time and re-checked in
continuous integration `[MC · C-47]`. Read access is unrestricted except where a
charter says otherwise, and where it does, the document says plainly that the
restriction is enforced by prompt and audit rather than by the filesystem
`[RE · C-48]`.

**The table's format**, since it is mechanism and an adopter needs it: one row
per seat, whose cell is a list of path prefixes that are *allowed*, optionally
with narrower prefixes carved *out* of them. Everything not listed is denied —
the check is an allow-list, for the reason §3.9 gives about allow-lists failing
closed. Two rows are special: the seat whose cell is "everything", and every
seat's own journal path, which is carved out of the scope test entirely because
the coupling rule of §2.1 forces every commit to touch it.

**FACSIMILE — instance, not norm.** This program's table, with every seat named
by function and every domain path generalized. The *contents* are yours to
write; the *shape* is the mechanism.

```
| Seat                 | May stage (non-journal)                                        |
|----------------------|----------------------------------------------------------------|
| orchestrator         | everything — sole owner of the enforcement, workflow, launcher,|
|                      | program-state, constitution and charter trees                   |
| specification lead   | docs/** EXCEPT docs/reports/audit/**, docs/reports/<metrics>/**;|
|                      | README; the roster file; packets/**                             |
| implementation lead  | <product trees>/**; packets/**                                  |
| verification lead    | test/**; tools/**; docs/reports/<metrics>/**; packets/**        |
| auditor              | docs/reports/audit/** ONLY                                      |
| <worker role>        | its line's tree, narrowed further by its own packet; packets/** |
|                      | (its own return log only)                                       |
| <contingent seat>    | as its line's lead, scoped to the sub-domain it activates for   |
```
*Carved out of the test entirely: every seat's own journal path.*

Read the arithmetic off it before you trust it (§2.1): in this table the packet
directory is granted to three leads and every worker role, the product tree to a
lead and its worker, the test tree to a lead and two worker roles. **Four path
classes are shared by two to four seats**, and for every such pair
one-agent-per-commit is review-enforced, not emergent.

The consequences are the separations of §1.4 made physical: the implementation
line cannot stage tests, the verification line cannot stage implementation
`[MC · C-49]`, the auditor cannot stage anything but its own reports, and each
worker is narrowed further by its packet `[RE · C-50]`.

*That last consequence is a residue the first edition left unnamed*, standing
inside a sentence that says scopes are machine-checked. The **class** scope is
machine-checked; the **per-packet narrowing is not** — a worker granted its
line's tree may stage anywhere in that tree, and the narrowing to the two files
its packet names lives only in the packet and its review. A document that names
its residues elsewhere owes this one a name too, and here it is.

**The failure class.** Every incentive-driven boundary violation at once. This is
the single highest-leverage control in the system, because it converts "you must
not" into "you cannot," and the second is the only one that survives a hurried
round. It produces a secondary property **only where two seats' scopes are
actually disjoint**: for such a pair, one-agent-per-commit is automatic. Where
they overlap — and in the audited table four path classes are shared by two to
four seats — it is not. §2.1 carries the correction and the arithmetic.

**The residue, named.** Read restrictions are not mechanizable in the agent
runtime this was built for (**Annex A**). The program states this rather than
implying coverage it does not have, and compensates with three things it can
check: what a packet contained, what an agent recorded reading, and an auditor
that samples both `[PLANNED · C-51]`. **Two of those three are real artifacts and
the third is dormant** — §1.1's summed table carries the count — so the honest
reading of this compensation is that the two static legs exist and nothing has
been sampling them. State it that way in your own document, or you will describe
a tripod standing on two legs.

### 2.4 Mechanical refusal over advisory warning — and the exceptions, deliberately

The default is refusal. A rule with an opt-out is exercised at exactly the moment
it matters: the round where someone is in a hurry, which is the round the rule was
written for. The program's own formulation, used as a test on every proposed
control: **a warning is not a verdict, and its absence is not a clearance.**

Two classes of rule are nevertheless deliberately *not* blocking, and knowing why
is the difference between a designed enforcement layer and a superstition:

**(a) Rules whose predicate is semantic, not lexical.** Some rules cannot be
decided by a script without being decided wrongly. Distinguishing a claim from a
quotation of a claim, or a genuine relay from a summary, is not a string match. For
these, the program mints no machine rule at all — the posture is declared
**review-enforced**, and the document says so in the clause itself `[RE · C-52]`.
A script may emit an advisory note, and the clause states in the same breath that
the note's absence proves nothing `[PLANNED · C-53]` — **the honesty is real and
the note does not exist**: it is contemplated by the clause, drafted inside a
decision record, and emitted by nothing. A qualifier attached to an unbuilt
instrument reads, to a stateless seat at spawn, as a description of a running
one.

*Failure class.* A mechanical check whose predicate is a proxy for the real rule
produces both false convictions and — far worse — a **clearance**: the check
passed, so the reviewer stops looking, and the real rule goes unexamined forever.
An honest "no check exists here, humans and auditors look" keeps the vigilance.

**(b) Rules whose subject is testimony rather than structure.** Where the thing
being checked is an agent's own attestation and the record of it is already
frozen, a blocking check makes a legitimate correction impossible. **A warning is
the correct instrument in that case** — not a weaker version of a refusal, but
the right shape, because the failure it catches is one that must remain fixable.
`[PLANNED · C-54]`

*The posture that clause actually holds.* The designed class has exactly one
implemented member, and that member is a size rule — **structure, not
testimony**. The case that motivated the corollary, an author's own timestamps,
has no warning at all: one was specified after a program-wide census, with
candidate bands, measured false-positive rates and a twenty-entry lead time, and
it was **not built**. So the clause describes a class whose only member is not of
the kind the class is about. Carry the reasoning; do not carry the implication
that the layer exists.

**And the general principle underneath both: a rule without its check is a
suggestion.** The counterpart is equally load-bearing and was learned the hard
way: **a rule and its check that disagree about what compliance is are worse than
either alone**, because the disagreement is invisible from both sides. Every
control here is therefore designed as a pair, and where the pair cannot exist, the
absence is written down.

*Corollary, adopted after a measurement.* If a check exists on one surface —
the local commit path — and not on the other — the re-check over pushed history
— the asymmetry is itself the defect. Both surfaces or neither. `[P1 ·
2026-08-03 · C-55]` *(**SUPERSEDED — historical record, not current law:** this
stamp read 2026-08-04 until the date census re-anchored all of them: the commit
that mirrors the rule into the pushed-history re-check is dated the third. One
day, and the correction is worth the line — §5.4's whole lesson is that a date
in a record is testimony, and a date nobody re-anchored is testimony nobody
tested.)*

*And it was applied once, to one rule, in the act that minted it.* A large-file
gate was mirrored into the pushed-history re-check and given its own numbered
rule and test case. The journal size threshold, in the same rule family, was
**not** mirrored in the same act and is still not mirrored (§2.2, §2.5). So the
corollary stands with a live unrepaired instance inside the family that produced
it — which is the most useful thing about it as an exhibit: **a corollary adopted
without a sweep of its own kind is a corollary adopted for one case.** If you
adopt this one, the adopting act should enumerate every check on either surface
and dispose of each, or the enumeration never happens.

### 2.5 Continuous integration is the adjudicator

Every rule the commit script enforces **but one** is re-verified by continuous
integration over the entire pushed history, not merely over the newly pushed
range `[CORRECTED · C-56]`. A locally bypassed check — and every commit tool has
a bypass flag — still fails before merge `[MC · C-57]`, with that same single
exception.

*The exception, named rather than averaged away.* The commit script refuses an
append that pushes a journal past its hard size threshold; the pushed-history
re-check has **no size check at all**. A commit made with the local hook
bypassed therefore passes the re-check clean. **SUPERSEDED — historical record, not current law:** the
first edition said "every rule", without qualification — and the defect is not
the missing check so much as the **unqualified quantifier**, because a reader
who trusts it stops looking for exactly this. What the full-history claim gets
right is worth keeping: the re-check really does run over all of history rather
than the new range, for the reason given below, and everything except the size
threshold really is on both surfaces. A proposed decision record specifies the
missing limb; it is **not in force** (**Annex B**), and this sentence will be
true without qualification only when it lands.

*And the quantifier in "the entire pushed history" wants delimiting too, in the
section that convicts the first edition for an unqualified one.* The re-check
adjudicates **the lineage**: the working branch and the trunk, over all of
their history rather than the newly pushed range. It does **not** adjudicate
the marked campaign references of §3.9 — pushed and never merged, and counted
there rather than here — which sit outside its frame entirely. That is
defensible (they are not history; nothing accumulates there) and it is not
obvious, and it is half the reconciliation a reader needs for §1.5's mechanical
stamps against §1.1's record of eight acts that ought to have been refused. The
other half: **the commit gate is a wrapper somebody invokes**, and every
version-control tool has a bypass flag — so the gate binds what passes through
it, and the re-check binds what lands in the lineage, and an act that is
neither is bounded by neither. **State your two frames explicitly. A stamp that
does not name its surface has not said where its guarantee holds.** `[B.8·36]`

**The failure class.** A check that runs only where the checked party runs it is
a self-report. And the specific reason for full-history rather than incremental
re-checking: **an incremental range check cannot detect a rewrite of history
before the range.** A rewrite is exactly the attack the append-only property
exists to prevent, so checking only the new range would leave the guarantee's
principal threat unexamined.

**The one out-of-repository dependency, declared — and discharged.** None of this
survives a force push, and force pushes are prevented by branch protection
configured in the hosting platform — a setting the machinery cannot make for
itself. The program names this as a one-time sponsor duty, on a gate checklist,
and states plainly that until it is done the no-rewrite guarantee is convention
rather than enforcement.

*And the record closed it twice, which the first edition never said.*
`[P1 · 2026-08-01 · C-58]` The setting was configured at ratification with an
empty bypass list — so that the administrator account the program itself pushes
with cannot override it — and **verified by live fire on both protected branches
the same day**: an attempted violation that actually bounced, cited by journal
entry on the gate row. It was then re-proved in anger, months of rounds later,
when a force-push-with-lease on a transient reference was **refused by the
platform's rules** in the middle of an unrelated incident. The document that
demands live-fire verification of adopters (§6.2) held the two best instances of
it in its own record and cited neither.

**Two things follow from that.** An adopter reading a dependency described as
open will treat their own as open; and *the strongest available evidence for a
control is an attempt that bounced*, which is an artifact you can only have if
someone deliberately tried. Configure it, then attack it, then cite the bounce.

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

*Failure class.* Undeclared external dependencies in a control. A guarantee that
silently depends on a setting nobody has verified is cited for the life of the
program and has never been true.

### 2.6 The numbered commit rules

The rule set is small, numbered, and cited by number in every later argument
about them. Their functions are what transfers — and so is the column the first
edition did not have: **where each one is actually enforced.** A table headed
"the commit script enforces" that contains rules the commit script does not
enforce is the exact defect §2.4 warns about, and it contained two.

**And so is the column the second edition did not have: the numbers
themselves.** `[B.8·15]` *(**SUPERSEDED — historical record, not current law:**
the text said the rules are "numbered, and cited by number" and never printed a
single number — so an adopter executing the self-test step of §6.2 had to
invent a numbering, and could then evaluate the adoption's own definition of
done only against their own invention.)*

**FACSIMILE — instance, not norm.** The ids below are this program's, and they
are printed so that the rule/case/citation machinery is executable rather than
implied. Yours may differ; what may not differ is that they exist, are stable,
and are what every later argument cites.

**Read the id column with this note, which earlier editions printed only after
the table.** *Thirteen rows, eleven numbers.* Two ids appear twice — `R10` and
`R9` — because one rule has two limbs enforced on **different surfaces**, and
the table is ordered for reading rather than by id. The ids are this program's
real ones and are deliberately not re-numbered to tidy the table: **a facsimile
that renumbers is a facsimile of nothing.** `[B.10·11]`

| Id | Rule | Function | Enforced where |
|---|---|---|---|
| `R1` | One agent per commit | Mixed-agent changes are split into sequential commits; the mechanical invariant is one journal append per commit | Both surfaces, **as the invariant** — the splitting itself is review-enforced for overlapping scopes and for the unscoped seat (§2.1) `[MC · C-59]` |
| `R2` | Coupling | Work must stage a pure append to the responsible agent's journal; journal-only commits are legal but must be marked | Both surfaces `[MC · C-60]` |
| `R3` | Append-only | The previous version of the journal must be a byte prefix of the staged one; journal deletion and renaming are always refused | Both surfaces `[MC · C-61]` |
| `R4` | Files-list equality | The entry's declared file list must set-equal the commit's changed paths, excluding the author's own journal | Both surfaces `[MC · C-62]` |
| `R5` | Monotonic entry ids | The new entry's number is exactly the previous one plus one — across volumes, not merely within a file | Both surfaces `[MC · C-63]` |
| `R6` | Trailers | The fixed metadata block must be present and well-formed; protected keys cannot be shadowed or duplicated | Both surfaces `[MC · C-64]` |
| `R7` | Path isolation | Every staged non-journal path must be in the committing agent's scope | Both surfaces `[MC · C-65]` |
| `R8` | Foreign journal seeding only | Another agent's journal may be staged only as a newly created, entry-free file (onboarding); modifying an existing one is always refused | Both surfaces `[MC · C-66]` |
| `R10` | Journal chain and rotation | Volumes are gapless, each carries its predecessor's path and digest, only the active volume may change | Both surfaces, by limb — headers at rotation plus chain-wide ids on the commit surface, the full walk on the pushed-history surface and in the standalone verifier (§2.2) `[MC · C-45]` |
| `R10` | Journal size thresholds | A soft threshold warns, a hard one refuses, anchored to the reader's single-file limit | **Commit surface only** — the asymmetry of §2.5 `[MC · C-46]` |
| `R11` | Large-file gate | A staged file over **1,000,000 bytes** is refused, with the journal carved out (**Annex A.7**) | Both surfaces — the one place the both-surfaces corollary was applied |
| `R9` | Merge triviality | A merge commit's tree must equal one of its parents' trees; multi-parent merges beyond two are rejected outright | **Pushed-history re-check only**, not the commit script `[CORRECTED · C-67]` |
| `R9` | One branch, no rebases, no force pushes | Work lands sequentially on one working branch; pushed history is never rewritten | **No script anywhere.** The hosting platform's branch protection, and nothing else `[CORRECTED · C-67]` |

**Three things the id column makes visible that thirteen unnumbered rows hid.**
*Thirteen rows, eleven numbers* — stated at the table's head, where a reader
meets the duplicate ids rather than two paragraphs after them. *A row is not a
case*: a self-test grows by cases per
amendment, not per row, which is why any equation between row count and case
count is uncomputable and why §6.2's definition of done no longer contains one.
And *one rule has no script to name it at all* — the branch limb of `R9` — so
the self-test's own form (construct a violation, assert the refusal names the
rule) **cannot be written for it**; what stands in its place is the live-fire
bounce against the platform, cited by identifier, which is a different evidence
form and is worth as much. **A rule set with an id column can be argued about; a
rule set without one can only be agreed with.**

*The threshold that this table called "stated" and never stated.*
**SUPERSEDED — historical record, not current law:** the large-file gate refuses any staged file over
**1,000,000 bytes**, with every journal path carved out of it — journals are
governed by `R10`'s rotation thresholds instead, because a size refusal cannot
apply to a file that `R2` requires in every commit and `R3` requires to
continue its own bytes. The number and its anchor are in **Annex A.7**; an
adopter executing this document from the text alone had to invent one, and
invented a different one.

*Margin note on the last two rows.* **SUPERSEDED — historical record, not current law:** the first edition
folded them into a single "serialized history" row sitting under the sentence
"the commit script enforces". Two of that row's four clauses are enforced
somewhere other than where the sentence put them, and one is enforced **outside
the repository entirely** — the dependency §2.5 declares. A reader building
this layer from the first edition would have looked for force-push prevention
in the commit script and concluded, correctly, that it was not there, and then
had to guess whether that was an omission or a design.

*And the branch topology, which the same row left incoherent.* There are two
branches with different jobs: a **working branch**, where every agent commit
lands in sequence, and a **trunk**, which receives the working branch only at
milestone boundaries and only through a merge that **introduces no content of its
own** — that is what "trivial" means, and it is checked by comparing trees, not
by inspecting the diff. Both are force-push protected. The campaign references of
§3.9 are a third population: pushed, marked, never merged into either, and
therefore not a violation of "one working branch" — the rule is about where
*history* accumulates, not about how many references exist. State that
distinction in your own version; a rule that says "one branch" while the
repository carries a large marked-reference population — §3.9 counts it, at this
revision's own commit, none of them merged — is a rule an adopter cannot apply.

**The files-list rule deserves its own note**, because it is the least obvious and
the most load-bearing. Each entry declares the exact set of files that commit
touches. The check is set equality: an entry cannot claim files it did not touch,
nor silently touch files it did not claim. Deletions count as touches.
`[MC · C-68]`

*Failure class.* Narrative and diff drifting apart while each stays internally
consistent — the defect nobody detects, because reading either one alone shows
nothing wrong. This single check is what binds the explanation to the change; the
coupling rule only guarantees that *an* explanation exists.

### 2.7 The amendment procedure

Any change to the constitution, to a charter, or to the enforcement scripts
requires three things:

1. a **numbered decision record** recording the alternatives considered and the
   rationale;
2. an orchestrator journal entry accepting it;
3. if the change alters enforcement semantics, an updated case in the
   **enforcement self-test** proving the new behavior.

`[RE · C-69]` — **no script tests any of the three.** The coupling rule forces
*an* entry to exist on the amending commit; nothing checks that the entry accepts
anything, that a decision record accompanies it, or that a test case was added.
The record shows the procedure working, twice, and shows its debt: **an
instrument in force whose constitutional diffs are written but not applied.**

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

**The enforcement self-test**, since it is named as a precondition here and as an
adoption step in §6.2 and was never described: a runnable scenario suite that,
for each numbered rule, **constructs a commit that violates it and asserts the
refusal happens and names that rule**. It is the artifact that makes an amendment
falsifiable — a rule whose test case cannot be written is a rule whose predicate
nobody has pinned down. It lives beside the enforcement scripts, in the same
scope, and it grows by one case per semantic amendment, which is why item 3 is a
precondition and not a follow-up.

Program-scope parameters (phases, headline figures, scope limits) are canonically
stated in exactly one place, and everywhere else that repeats them does so for
convenience only. A change to such a parameter updates the canonical statement and
every restatement, and the amending decision record lists the touched files.

**And the process description is inside the amendment procedure, not beside
it.** `[B.8·24]` A fourth requirement joins the three above:

4. if the change alters **enforcement semantics** — what a rule refuses, on
   which surface, under what posture — it obliges either a **re-edition of this
   document** naming the clauses that moved, or a **logged waiver** stating that
   nothing here needs to change and why. Both are acts with an author and a
   date; neither may be silent. The obligation is **owned by the specification
   lead**, discharged in that seat's own reasoning log, and it is
   **review-enforced** — no script reads it. *(No posture row — added after the
   measurement.)*

*Why this rule and not more careful prose.* Every falsehood this edition and the
last one removed had the same life cycle: a sentence that was true when written,
a machine that moved underneath it, and no act that obliged anyone to look at
the sentence again. Per-claim editing of a document this size **does not
converge** — two consecutive editions purged the class and both shipped fresh
instances of it. What converges is binding the document to the event that
invalidates it. The waiver limb matters as much as the re-edition limb: a rule
that can only be discharged by editing a three-thousand-line document will be
discharged by not invoking it.

*Routed, not applied — the half of this rule that is another seat's file.* The
same binding belongs in the constitution's own amendment clause, where it would
bind every seat rather than this document's author. That is an amendment: it
needs a numbered decision record and it touches a file outside this seat's
scope. It is recorded as an amendment candidate in **Annex B.2** and joins the
batch already queued there — by the same route, and for the same reason, as the
two false premises §2.1 and §3.7 corrected here and could not correct at their
source. **A document that discovers a rule its own constitution should carry
proposes it; it does not enact it by writing it down.**

**The failure class.** Constitutional drift by convenience — the constitution
changing because someone needed it to, in a round where nobody was looking at it
as a constitution. Requiring the alternatives to be written down is what makes a
later reader able to tell a decision from a default. And requiring the enforcement
test case is what stops the class of amendment that changes the words while
leaving the machine doing the old thing.

*Failure class for the parameter rule.* One figure living in five documents,
updated in three of them. Each reader is confident; two of them are wrong; and the
disagreement surfaces at the worst possible moment, usually as an apparent
contradiction between two correct-looking sources.

---
## 3. The artifact grammar

**A packet** is a versioned file that carries work or a verdict between seats: it
has an identifier, a state, a named author and a named addressee, and it is
committed, so it can be diffed, cited and bounced.

**The taxonomy is closed by a rule, not by a list.** `[B.8·3]`
*(**SUPERSEDED — historical record, not current law:** the second edition said "the taxonomy is closed, and
this is it" over six types — and the record had already outgrown the list while
the sentence was being written; it is the same defect class §3.2 warns about
two pages further on.)* The rule:

> **PROPOSAL — not this organization's law. It binds nobody; the facts against
> it are stated below the rule, not after twenty lines of it.**
>
> **A new packet type may be minted only by the amendment procedure (§2.7): a
> numbered decision record naming the type, its required fields, its relay class
> and its state vocabulary, accepted by a seat that did not propose it. No seat
> mints a type by using one.** A form that appears in the record without that
> route is not a new type — it is either an instance of an existing one, or an
> unrouted extension, and naming which is the reviewer's job.
>
> **(No posture row.)** *This rule is stated in no binding artifact of this
> program: the constitution defines four
> packet types and contains no minting clause, no relay-class-at-minting duty
> and no state-vocabulary duty; no decision record mints one; no charter carries
> one. And the record's practice is its inverse — **every extension form named
> two paragraphs below was minted by use**, which the next paragraphs say in
> terms. It is carried here as a **proposal**, routed as an amendment candidate
> at **Annex B.2 item 11**, and it binds nobody until that route completes.
> Stated because §2.7 gives the one-line rule for exactly this case, and the
> third edition printed this rule as
> "The rule:" and "the invariant worth exporting" with no stamp, no carrier and
> no route, which is the one place in that edition where the posture apparatus
> was not applied to a norm. Found by an independent record audit; council
> round-3 blocking item 3 — Annex B.9.*

That is the invariant worth **proposing**, and the reason to propose it is in
the table below rather than in its favour. The **list** is an instance, current
at this edition, and it is the kind of thing that goes stale between readings —
which is why the list belongs in the kit, where a drift check can bind it, and
the rule belongs here. **Six forms are in use; four of them are types the
constitution defines, and two are this document's own construction** — a
distinction erased by a phrase this document has withdrawn
(**SUPERSEDED — historical record, not current law:** the third edition's *"Six types are defined"*), which
left a reader unable to tell this organization's law from this document's model
of it:

| Packet | Carries | Written by | Relay class | Where the type is defined |
|---|---|---|---|---|
| **Work order** | A commissioned unit of work: basis, deliverables, definition of done, context handed over, what is out of scope | A lead, or the orchestrator | Summarizable | **Constitutional** — the packet table |
| **Review verdict** | Accept, or a numbered defect list — file, line, and the clause violated — signed with the reviewer's entry id | The reviewing lead | Summarizable | **Constitutional** — the packet table (and see §3.2: zero instances as a file) |
| **Sign-off** | The verification line's pass/fail on one artifact, with everything §3.8 lists | The verification lead | **Verbatim** | **Constitutional** — the packet table |
| **Defect packet** | One defect found after an artifact was accepted, routed to its owner | The verification lead | **Verbatim** | **Constitutional** — the packet table |
| **Sealed prediction** | A frozen expectation, opened only after the evidence exists (§3.3) | Whichever seat will be scored | **Verbatim** | **This document's construction.** The constitution defines the *seal* as an artifact a commit must ship (§3.3's filing rule) and gives it no packet row and no relay class; §4.3's protected-class list is where its verbatim treatment actually comes from |
| **Finding** | A severity-graded defect claim against an artifact, including one's own (§3.4) | Any seat | **Verbatim** when the auditor's | **This document's construction.** The constitution has no finding packet type; the verbatim treatment of an auditor finding comes from the relay clause and the critical-finding escalation class (§4.6), not from a taxonomy row |

*Three things the table encodes.* Relay class is a property of the packet
**type**, not of the round — it decides in advance whether the routing seat may
compress it (§4.3). A review verdict is a *packet type*, but see §3.2: in this
program's record it has never existed as its own file. And the last column is
the one to read first if you are building this layer: **two of the six rows are
a document's model of its own program**, which is a legitimate thing for a
description to carry and an illegitimate thing to inherit as law.

**What the record grew that the list does not contain, named rather than
implied** — per §3.2's own ghost-nouns instruction: where practice has diverged
from the defined form, describe the practice. `[B.8·3]` Two kinds of divergence,
and they
want different responses.

*Forms outside the six.* A **transit packet** carrying a harvest across an
organizational boundary (§3.10, §6.0) — collation record, delivery record and
conformance notes, with its own state vocabulary. An **adjudication companion**
to a work order, holding a ruling too long for a return log. A **pre-run reading
note**, filed before a round begins, recording what its author read. A
**campaign packet** and its **defect manifest** and **campaign brief** (§3.9) —
the manifest doubling as one of the auditor's own reports, which is what seats
it (§1.5). None of these was minted by the route above; each is an **unrouted
extension**, and saying so is the point. The honest posture is not that the
taxonomy is closed but that **these are live forms with no instrument**, and
their routing is owed.

*States outside the five.* §3.2's lifecycle — draft, issued, returned, accepted,
bounced — is the work order's. The record also runs **EXECUTED** (a transit that
has been performed), **CLOSED** (a campaign complete and adjudicated),
**RE-ISSUED / RE-VERDICT** (a sign-off re-run at a new state, with every
superseded verdict preserved in place), **UNSEALED** (§3.3), and
**letter-suffixed splits** of one commission into parts. An adopter who builds
the five states and meets the sixth will assume they have misread the process.
**A state vocabulary is part of a packet type's definition, and a type whose
states are defined only by usage has no definition.**

**FACSIMILE — instance, not norm.** The packet skeleton, the identifier schemes
and the path layout this program actually uses, with domain nouns removed. These
are the carriers an adoption run has to invent otherwise, and inventing them is
what makes an adopter's machinery incomparable with anyone else's.

```
packets/<TYPE>-NNNN_<slug>.md          # numbered types: work orders, defects, verdicts
packets/<TYPE>-<subject>.md            # per-subject types: sign-offs, transits
packets/<TYPE>-NNNN_<slug>-SEALED-predictions.md   # a seal ships beside its own commission

# <TYPE> is a fixed short token per type, not the English name. This program's,
# printed because five of the six had no token anywhere in the last edition and
# a path template with an unbound variable is not a template:
#   WO-   work order          WO-0012_<slug>.md
#   RV-   review verdict      RV-0012_<slug>.md   (defined; zero instances as a file, §3.2)
#   SO-   sign-off            SO-<subject>.md     (per-subject, not numbered)
#   BUG-  defect packet       BUG-0004_<slug>.md
#   <the seal>                <the commissioning packet's own name>-SEALED-predictions.md
#   <a finding>               no file token: findings carry ids inside reports and
#                             packets (F-<origin>-<n>), and have no packet file
#   HT-   harvest transit     HT-01_<slug>.md     (an unrouted extension, §3)

# --- packet skeleton -------------------------------------------------------
# <TYPE>-NNNN — <one-line title>

- **State**: <state> (<what changed, and at which entry>)
- **From** / **To**: <seat> → <seat>  (relay class: <Summarizable | Verbatim>)
- **Basis**: <the specification section or parent record this rests on>
- **Deliverables**: <constrained to the assignee's write scope>
- **Definition of done**: <checkable items>
- **Context handed over**: <exactly what is included>
- **What you may not read**: <the omission, as a property of the packet>
- **Out of scope**: <explicit>

## Return log
- <seat> · <entry-id> · <state transition> · <verdict or defect list>
```

Identifier schemes, in the same spirit: entry ids `J-<seat>-NNNN`; decision
records `ADR-NNNN-<slug>`; findings `F-<origin>-<n>`; per-round gate signatures
carried as entry references. **Numbers are allocated by the sole committer at
first commit, and drafts in flight carry a placeholder rather than a guess**
(§3.2).

*And the placeholder is where this document has been describing an intention
rather than a practice.* **SUPERSEDED — historical record, not current law:**
the previous edition said the placeholder *"is a literal token, not a blank, so
that an unallocated id is greppable"* and named no token. Re-derived from the
record: **there is no literal token.** What the drafting
seat actually does is write the **next free number per prefix, measured at a
stated commit**, into the draft's own filename, and declare in its journal
entry that the id is provisional until the committer allocates — a real,
disciplined practice, and **not a greppable one**, because a provisional id is
lexically indistinguishable from an allocated one. The one literal form the
record does contain sits in a decision record, where a generic seal path is
written `<TYPE>-XXXX_…`; it is used to *describe* the scheme, never to name a
draft. So the greppability property is stated here as what it is: a **parameter
this program does not have and an adopter should choose** — with the
requirement, which is the transferable part, that whatever token you pick be
**fixed, lexically impossible as an allocated id, and used in the filename
rather than only in prose** (**Annex A.9**). *(No posture row.)* `[B.9·5]`

Everything that moves between seats is a versioned file — **with one class of
exception the record institutionalized and the first edition did not name.**
`[CORRECTED · C-70]`

*The dispatch-only round.* Four work-order identifiers in this program's record
have **no packet file at any commit**, while being live in reasoning-log headers
and in program state: a repository-wide cascade, two constitutional-amendment
rounds, and the first journal rotation. The commission was carried by the
dispatch text alone. The audit that produced this edition's stamps was itself
such a round, and so is this revision. The class is real, it is used for exactly
the rounds where the commissioning seat is also the committer, and naming it
costs nothing while pretending it does not exist costs an adopter the ability to
audit for it. **The honest rule is not "everything is a file" but:** *every
commission is a file, or the round says in its own reasoning log that it was
dispatch-only and why* — which converts an invisible exception into a countable
one.

**The failure class that governs this whole section.** A task, verdict, finding or
agreement that exists only in a chat has no author, no version, no diff and no
addressee of record. It cannot be reviewed against, cannot be bounced, cannot be
cited, and its definition of done is whatever the returning party says it was.
Conversation is where work is coordinated; files are where it exists.

### 3.1 The journal entry

The unit of the reasoning record. **Its structure is machine-checked; the quality
of its narrative is owed to audit sampling** `[PLANNED · C-71]` — the split is
exactly right and the second half is dormant. Read every "enforced by audit
sampling" in this document against §1.1's summed table, which counts all of them
in one place.

An entry carries a header line — entry id, timestamp, the work-order id or `none`,
and a one-line title — followed by fixed sections:

- **Trigger** — who invoked this and why.
- **Inputs** — the exact files, specifications, decision records and prior entries
  read, with paths and, where it matters, commit ids.
- **Reasoning** — the decision narrative: options considered, why the winner won,
  what was rejected and why. *This is the section the commit exists to preserve.*
- **Actions** — what was done.
- **Evidence** — exact reproducible commands and their observed results. Claims
  here must reproduce at this commit; the auditor re-executes samples. Only two
  kinds of citation are admissible: commands runnable from a checkout, and
  externally verifiable references such as a CI run id and its conclusion.
  Anything ephemeral must be labelled as ephemeral.
- **Outcome** — status against the work order's definition of done, met or
  partially met with the gaps named, and where the work was handed.
- **Open-questions** — escalations and unresolved items, or an explicit "none".
- **Files-in-this-commit** — the declared file set (§2.6).

**FACSIMILE — instance, not norm.** The entry as this program's parsers actually
read it, with the seat name anonymized. Everything the machinery keys on is on
the header line and in the last section; the rest is carried by the template and
by review.

```
## [J-<seat>-NNNN] <UTC ISO-8601> | task:<packet-id|none> | <one-line title>
### Trigger
### Inputs
### Reasoning
### Actions
### Evidence
### Outcome
### Open-questions
### Files-in-this-commit
- path/to/every/staged/non-journal/file
- (none)                      # the empty marker, for a journal-only commit
```

Worker roles share one journal per role rather than per spawn, so a worker
entry additionally carries the **spawn short-id** in its `task:` field and
quotes it verbatim in *Trigger*: a unique string minted by the spawning seat
into the prompt — packet id plus spawn timestamp, e.g.
`WO-0012/2026-08-01T16:00Z`. That short-id is the whole of what preserves
attribution inside a shared log, and it is **review-enforced**: no script
checks that the short-id in the entry is the one that was minted.
*(**SUPERSEDED — historical record, not current law:** the previous edition
called it a "spawn token" — a synonym this document invented, against **spawn
short-id** in the constitution and in every launcher. The term is aligned
rather than glossed, because §6.2 Step 0 tells an adopter to grep this
document's terms against the shell's machinery and a synonym returns nothing.)*
`[B.9·12]`

*And now §3.1's own parser rule is implementable.* An entry body may never
contain a line beginning `## [J-` at column zero for its own journal — quote a
prior header indented, or inside a sentence — because the parsers are
deliberately simple and count such a line as a new entry `[MC · C-74]`. That
rule was unimplementable in the previous edition for the plain reason that the
reader was never shown what a header looks like.

**Of those eight sections, exactly one is machine-checked** `[RE · C-72]`: the
declared file set. An entry with no *Reasoning* section at all commits clean. The
seven narrative sections are carried by the entry template, by review, and by the
sampling that is owed above — which is the honest statement, and is what the
constitution says at its own version of this list. A reader of the first
edition's list would reasonably infer that a missing *Evidence* section is
refused. It is not.

Entry ids are strictly monotonic **per chain**, across volume boundaries, not
merely within a file `[MC · C-73]` — stronger than the first edition's "per
journal", and the stronger property is the one that matters, since rotation is
where a per-file guarantee silently breaks.

**The failure class of each section, briefly.** *Inputs* is the audit evidence for
the blinding rules of §1.4(c): a test author who read the implementation cannot
both record its inputs honestly and claim independence. *Reasoning* prevents
entries that describe what without why, which the program classes as a finding
category of its own (**vacuity**) — a record of actions with no decisions in it
tells a later reader nothing they could not get from the diff. *Evidence* prevents
the most common and most damaging failure in agent-produced records: a confident
claim that reproduces nowhere. *Open-questions* prevents the loss of everything an
agent noticed and could not act on, which is otherwise the single largest source
of silently dropped work.

*Anonymized pattern.* `[P1 · 2026-08-01 · C-75]` The rule that citations must be
re-executable was reinforced by an audit that re-ran a sample of them and found a
small number false — not fabricated, but decayed: true when written, false at the
current state, with nothing in the record marking the difference. *(The class
recurred at the council that produced this edition: a record auditor quoted a
severity tally from a report that had itself been corrected in place, and quoted
the superseded line. The finding survived the bad citation; the citation still
had to be repaired. **Decay is not a property of careless records — it is a
property of records that are cited later than they are written**, which is all
of them.)*

### 3.2 Work orders, and the loop

A **work order** is a versioned packet: state, from and to, the specification
basis it rests on, the deliverables (constrained to the assignee's write scope),
the definition of done, the exact context handed over, and what is explicitly out
of scope. It carries a return log that the participants append to.

Its lifecycle is a state machine written in the packet header:

**DRAFT → ISSUED → RETURNED → ACCEPTED | BOUNCED**

A bounced packet carries the numbered defect list and re-issues as a new
revision. **What "a new revision" is, literally, since the previous edition left
a reader unable to tell whether it means a new identifier, a suffix or an
in-place edit** *(re-derived from the record; no posture row)* `[B.9·5]`: the
packet
**keeps its identifier and its file**. The state field records the whole chain
rather than the current value — `ISSUED → RETURNED → BOUNCED → RE-ISSUED (rev B)
→ RETURNED → ACCEPTED` is a real state line from this record — the revision is a
**letter suffix on the round, not on the packet's number**, and the verdicts
carry that letter so they stay distinguishable (`RV-<n>-VERDICT`, then
`RV-<n>B-VERDICT`). Every superseded verdict stays in the file, in place, with
the reason it was superseded beside it: a bounce chain is the artifact, not an
embarrassment to be tidied (§3.8). One collision to know about: the same letter
suffix is also used for a **split** of one commission into parts — two packets
`<n>A` and `<n>B` issued together — so a letter means *revision* on a state
line and *part* in a filename, and the record contains both.
The review verdict has the content of a packet — accept, or a numbered defect
list with file, line, and the clause violated, signed with the reviewer's journal
entry id — and **in this program's record it has never existed as its own file**
`[CORRECTED · C-77]`. The constitution defines the type; not one instance exists
in the tree or in history. The practice is a verdict **section appended to the
work order's own return log**, which keeps commission and verdict in one diffable
artifact and is arguably better than the defined form.

*The generalizable point is not which form is right.* It is that a defined
artifact type with zero instances is indistinguishable, to a reader, from one
with a thousand — and a cold adopter will build the file type, find nothing to
put in it, and assume they have misunderstood the process. **Where practice has
diverged from the defined form, the document should describe the practice and say
the form is unused, or the form should be retired.** Carrying both silently is
how a grammar acquires ghost nouns.

Packet numbers are allocated by the sole committer at first commit; drafts in
flight use a placeholder `[RE · C-76]` — see §1.1 on why "by construction" is the
wrong word for this.

**The failure class.** Three, layered. *Without the packet:* a task whose scope
was never fixed, returned as something adjacent to what was wanted, with no
document to compare against. *Without the state machine:* nobody can tell whether
a returned item is finished, in review, or rejected — the most expensive ambiguity
in a multi-agent system, because both parties can believe the other holds it.
*Without the explicit out-of-scope section:* the assignee helpfully does more than
asked, and the extra work lands unreviewed, unspecified, and inside a commit
attributed to a narrower mandate.

**The context section is a control, not a convenience.** Because blinding is
enforced by what a packet contains, the packet states what was handed over. A
packet that must omit something says so `[RE · C-78]` — in the record, as an
explicit section headed *what you may not read*, inside the packet itself.

*Anonymized pattern.* A worker packet for a test author omits implementation
source on purpose and says so in the packet; the omission is a property of the
artifact and is auditable years later, whereas an instruction not to look is not.

### 3.3 Sealed predictions

**The cast, bound to §1.2's functions before the placeholders are used** —
because this section's facsimile and its bullets speak of three seats by role,
and a reader in document order should not have to assemble the cast of the
document's most independence-critical mechanism from two later sections:

- **the scored seat** — the **verification lead** (§1.2). Owns the test suite the
  campaign measures; writes the seal, freezes it, and scores it.
- **the seeding seat** — the **auditor** (§1.5). Composes the deliberate defects,
  and is the one seat the seal is kept from.
- **the operating seat** — the **orchestrator** (§1.2). Applies the defects and
  runs the suite; authors none of the evidence it produces.

`[B.10·10]`

Before any defect diff exists, the party that will be scored writes down what it
expects and freezes it. Then the evidence is produced. Then the frozen prediction
is opened and compared.

*Margin note.* **SUPERSEDED — historical record, not current law:** this
section's opening line read *"Before evidence exists…"* through the fourth
edition — the weaker phrase that edition's own freeze-point bullet withdraws in
terms, left standing in the sentence that introduces the mechanism. A cold
reader of the fourth edition caught the residue and recorded that the bullet
governs. `[B.10·9]`

The rule that makes this real is short and absolute: **a seal is a file in the
commit that claims it, or it is not a seal.** `[RE · C-79]` — deliberately
review-enforced, and the constitution declares that posture in the clause itself,
on the ground that distinguishing a claim from a quotation of a claim is not a
lexical test. A commit may not introduce a claim
that a result already exists and is being withheld from the reader — a sealed
prediction, a sealed sweep, an undisclosed mapping — unless that same commit
stages the artifact holding the withheld result, so that the seal appears in the
commit's own declared file list. **A withheld result that is not a committed
artifact is not a seal; it is a claim.**

Three things the rule deliberately does not reach, each named so the rule is not
over-read: a **forward commitment** ("this will be sealed before any evidence
exists") is a promise, redeemed by the later commit that freezes it — and an
unredeemed promise is not excused, it is adjudicated as *no seal existed*, which
means the claim it was to support may not be made. A **retrospective reference**
to a seal already in history, including quoting one in order to convict it, is not
a new claim. And "sealing" in the sense of finalizing a decision withholds nothing
and is outside the rule.

**What "withheld" means here, since it is not what a reader expects.** The seal
is committed in plaintext, in a repository whose read access is unrestricted.
Nothing is hidden from anyone. The withholding is **temporal, not
cryptographic**: what the seal prevents is not *reading* the prediction, it is
*revising* it after the evidence arrives. Against a self-assessing system that is
the whole threat — and it is why an append-only record with protected history
buys what encryption would not. If your substrate cannot protect history
(**Annex A**), a plaintext seal buys you nothing and you need a different
instrument.

A sealed prediction file carries: its state (and the single line that is flipped
at unsealing), the campaign it belongs to, the **base state it was formed
against, at that state's own identifier**, and **the seat and entry id that
froze it**. It does *not* carry the commit that froze it — it cannot: the
freezing seat never runs the version-control tool, and the commit does not exist
until another seat creates it (see the margin note below).

**FACSIMILE — instance, not norm.** The seal's header, **re-transcribed
verbatim from a real seal in this record, with project nouns replaced by
function names and nothing else changed.** *(**SUPERSEDED — historical record, not current law:** the
edition before the fourth carried a paraphrase here, and the paraphrase
weakened the single most independence-critical phrase in the file — see the
freeze-point clause below.)* `[B.9·1]` Note that the state line says *of
itself* that it is the only line altered since the freeze — the file discloses
its own single mutable point, which is what makes the diff check meaningful.

```
# <PACKET-ID> SEALED: <the scored seat>'s frozen predictions for <campaign>

> **SEALED. <the seeding seat> must not open this file until all <N> defect
> diffs are committed.** <The operating seat> must not relay any part of it
> before then. Reading it earlier does not merely bend a rule — it destroys the
> campaign's only claim to be a test rather than a confirmation, because a
> seeder who knows the predicted kill set can choose a defect site that
> satisfies it. See <the commissioning packet> §0.

- **State**: **UNSEALED <date>**, on <the operating seat>'s word that all <N>
  branches had run. Scored at <the verdict id> in the companion packet,
  <entry-id>. **This state line is the only line of this file that has been
  altered since the freeze** — no prediction, table, message string or
  classification below has been touched, and `git diff` against the freeze
  commit is the check. A freeze edited after its result is worthless; the
  scoring lives in the companion, not here.
- **Frozen against**: <the base state, at its identifier>, green end to end twice
- **Frozen by**: <the scored seat>, <entry-id>, **before any defect diff existed**
- **Companion**: <the commissioning packet> (the seeder-facing brief; intents
  only, no predictions)

## 0. Integrity note — why this is written twice

Everything committed here is also committed, in substance, in <entry-id>.
Two independent append-only copies of a freeze is not redundancy: if either is
later edited to fit a result, the other exposes it.
I have been falsified once already in this artifact's history (<entry-id>), and
the entire value of that episode came from the prediction being un-adjustable
afterwards. Same discipline, made structural.
```

**Byte equality between freeze and
unsealing is established by two mechanisms, neither of which is a field in the
file** `[CORRECTED · C-80]`:

1. **A diff against the freezing commit.** Anyone can run it; the append-only and
   no-force-push guarantees are what make the freezing commit a fixed point. This
   is the check the record's seals name in their own text.
2. **The second-copy discipline.** The frozen content is committed **twice** — in
   the seal file and, in substance, inside the freezing seat's reasoning-log
   entry, which is append-only by a rule the seal file is not covered by. If
   either is later edited to fit a result, the other exposes it. This is the
   strongest anti-tamper property the practice has and the first edition did not
   mention it at all.

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

Nothing below its header is ever edited: a wrong prediction is not amended, it is
adjudicated, and it dies on the record `[RE · C-81]`. The append-only guarantee
covers journals, not packets, so this one is carried by discipline — and the
record's practice is self-disclosing about it, with the state line marked as *the
only line of this file altered since the freeze*.

**Who authors the seal, when it freezes, who is blinded from it, and who scores
it — one paragraph, because the previous edition answered these four questions
in three places and gave three different answers.** *(No posture row — added
after the measurement; every clause below is re-derived from the committed seals
and their verdicts, not quoted from a clause.)* `[B.9·1]`

- **Author — the seat that will be scored.** The seal is written and frozen by
  the seat whose instrument the campaign measures: in this record, the
  verification line, whose test suite is the subject under test (§3.9). §3's
  packet table always said this, and it is the true one of the three.
- **Freeze point — before any defect *diff* exists.** Not "before any evidence
  existed", which is what the previous edition's facsimile said. The weaker
  phrase permits a seal frozen after the defects are rendered and before they
  are run, which is precisely the state in which a prediction can be fitted to a
  patch the author has read. The real seals say *before any defect diff
  existed*, and the campaign brief bars the seeder from running any diff until
  all of them are authored. **De-domaining a document is where load-bearing
  precision dies**, and it died here, in the file this document points at as the
  mechanism's exhibit.
- **Blind direction — against the seeder**, the independent seat that composes
  the defects. Neither the seal nor any part of it reaches that seat until every
  diff is committed, and the routing seat carries the fact of the seal and none
  of its content (§4.3). The hazard runs one way and is stated in the artifact
  itself, in the facsimile above, and is not restated here: a seeder who knows
  the predicted kill set can choose the defect site, and the campaign then
  confirms the prediction instead of testing the suite. It is **not** a blind
  against the seat that froze the seal.
  A careful, hostile cold reader reconstructed it backwards — inside this
  document's own review round, from this document's own text — and only a second
  reader opening the real artifact caught it. That is what a silent divergence
  at an independence boundary looks like when it is finally visible.
- **Scorer — the same seat that froze it. The rule the previous edition stated
  here is false, and the record is what decides it.**

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

*What actually holds a self-scored campaign honest, since it is not the scorer's
identity.* Four constraints, all of them checkable by a stranger:

1. **The prediction is immutable and its immutability is checkable.** The seal is
   frozen in a commit; the check is a diff against that commit; the file
   discloses its own single mutable line.
2. **It is committed twice** — the seal file, and in substance inside the
   freezing seat's append-only reasoning log. Either copy convicts an edit to the
   other.
3. **The scorer's inputs are other seats' artifacts.** The defects are the
   independent seat's, authored blind; the runs are the operating seat's; and
   what the verdict quotes is verbatim tool output at a run identifier, not a
   summary. A self-scorer that must quote someone else's outputs has a narrow
   place to be charitable.
4. **The discriminating content is the expected message text, not the row set**
   (§3.9). A seal that predicts only *these units fail* is one almost any defect
   satisfies, so self-scoring cannot be rescued by reading a vacuous seal
   generously — the vacuity is visible in the seal.

*And the residue, named where it belongs.* Self-scoring **is** §5.7's sixth
disguise — *the measurement that grades the measurer: a campaign whose
subject-under-test is the suite, run by the party that wrote the suite* — which
this document lists in its museum and denied in this section. It is operating in
the open, with the four constraints above and nothing else. What the record shows
of it is worth stating in both directions: the first campaign's two findings were
both **corrections to the scorer's own frozen predictions** rather than to the
suite; one verdict convicted the stated *reason* inside its own seal while the
prediction itself stood; and later campaigns record their own sealed cells as
falsified in their headline. **Admissions against interest are
evidence that self-scoring is being done honestly. They are not a separation, and
a document may not offer them as one.** The separation that is real here is the
seeder's: the party composing the defects neither predicts, nor scores, nor can
repair.

*The repair that is available, stated as an option and not proposed as law.*
The blind's purpose is discharged the moment every diff is committed — after
which the independent seat could score the campaign against the frozen seal
without any loss of blinding, since scoring reads only the seal, the diffs and
the run outputs. That would convert the residue into a separation. It costs a
round of an already-oversubscribed seat (§1.1), and it is **another seat's duty
to accept or refuse**: it is recorded as an option at **Annex B.2 item 12**,
option not recommendation, and nothing in this document enacts it.

**The failure class.** Hindsight scoring, which is the most comfortable and most
corrosive failure available to a self-assessing system. Without a prediction
frozen before the evidence, every outcome is consistent with competence: a suite
that caught the defect and a suite that reported something which was read
charitably afterwards produce indistinguishable records. The seal is what makes
the difference visible — and the file requirement is what stops a "seal" from
being a sentence an agent wrote in its own summary after seeing the answer.

*Second-order note the program records about itself.* The rule makes seals
**countable, not good**. A vacuous prediction — one that selects nothing, or
predicts everything — satisfies the file requirement and is caught later, at
adjudication, where a prediction that discriminates nothing cannot be scored.

### 3.4 Findings

A **finding** is a written, severity-graded defect claim against an artifact,
filed by any seat, including against its own.

Severities are fixed and the grading is part of the filing, not of the
response. The scale actually in use has **four** grades — critical, major,
minor, and a non-binding **note** `[CORRECTED · C-82]`. The first edition
listed three. The fourth is not decorative: it is where a filer puts an
observation it wants on the record and does *not* want routed as a defect, and
without it those observations either inflate into minors or vanish. *(This
program's founding audit returned 1 critical, 7 major, 7 minor and 2 note.
**SUPERSEDED — historical record, not current law:** the council that reviewed
this document quoted that tally from a superseded line of the same report — 5
major, 4 note — which the report itself had corrected in place; the finding
stood either way, since it turns on the number of grades, not the split. The
corrected figures are the ones above.)*

Critical findings from the auditor reach the sponsor verbatim as their own
escalation class (§4.6) `[P1 · 2026-08-01 · C-83]` — exercised once, at the
founding gate, where a critical finding blocked the gate until a decision record
dispositioned it and the auditor re-verified the disposition.

A finding is not closed by being contradicted. It closes when its owner repairs it
or rules on it with grounds, and the ruling is itself an artifact. A finding that
is sustained but whose cure lands elsewhere is recorded with its **route** — the
owner and the trigger — so that a debt cannot be discharged silently or forgotten.

**Findings against one's own seat are ordinary.** The record contains a lead
filing a major finding against a value its own packet specified; a seat
offering, against its own interest, a rule that raised the standard its own
artifacts would be held to; and a seat correcting a residual-risk routing so
that its own duties grew. The process treats these as the normal case rather
than as heroism, and one of its own tests for whether a finding is self-serving
is explicit: **check which way each of the finding's separable clauses moves
the filer's own exposure.** A finding usually has more than one **limb** — one
separable clause that can be sustained or refused on its own (see *The
dialect*). A filing whose every limb reduces its filer's obligations is one to
distrust; a filing that **widens** its filer's exposure in one limb while
narrowing it in another has probably been reasoned about rather than motivated.
*(**SUPERSEDED — historical record, not current law:** the first edition wrote
"the finding's two halves", which a cold reader could only map onto the
rule/failure-class pair this document uses everywhere else. The test is about
limbs, and findings are not limited to two.)*

**The failure class.** In a system where every seat can file, the natural
equilibrium is that only cheap findings against other parties get filed, because
those are the ones with no cost to the filer. The result looks like a healthy
review culture and is one where nothing that matters is ever examined — the
expensive findings are exactly the ones about one's own work. Making self-filing
routine, and stating the direction test out loud, is what keeps the severity scale
meaningful.

### 3.5 Countersignatures

Every normative change is signed by a seat that did not write it `[RE · C-84]`.
Practised for every constitutional amendment in the record — and **not practised
for this document**, whose first edition asserted the rule and landed unsigned.
This edition owes signatures too, and names them: each seat whose discipline is
described here confirms the description of its own discipline (**Annex B**).

Three properties make the signature worth something:

**It is narrow.** The signer states exactly what it checked and exactly what it
did not. A signature whose scope is "this document" tells a later reader nothing;
a signature that names four propositions it verified and one it explicitly did not
reach is evidence about five things.

**It is asked of the constrained party.** The signer is the seat the clause
constrains — the one that will have to live inside the guard. Its question is not
"is this correct?" (the author already believes so, and often did the arithmetic)
but **"is the guard exactly the rule, or is it wider than the rule?"** — which is
a question only the constrained party can answer, because only it knows what the
guard will catch in practice.

**Refusal is a legitimate outcome.** A countersignature that cannot be refused is
a formality. Refusal, or a narrowing, is a *contest*, and contests have a route:
before acceptance, the clause is redrafted; after acceptance, it goes back through
the amendment procedure.

Where a change moves after its signature was given, the signature covers text that
no longer exists. The remedy is a **delta-signature**: the moved clauses are named,
the seats they re-owe are named, and the traffic is recorded as *owed* until it is
paid. The rule the program states about this is one line: the accepting seat may
proceed with the traffic recorded as owed, and **may not record owed traffic as
paid** `[RE · C-85]` — carried by the accepting seat's own discipline; no
instrument reads an owed ledger, which is why the ledger has to be somewhere a
later reader is obliged to look (§5.5).

**The failure class.** An author who is also the only reader writes a guard that
is wider or narrower than the intended rule and never finds out — until the guard
either blocks conforming work or waves through the thing it was written to stop.
The delta-signature exists against a second failure: a signature quietly inherited
by a later version of the text, which converts a real check into a citation.

*Anonymized pattern, on where the value actually comes from.*
`[P1 · 2026-08-11 · C-86]` In one exchange the constrained party signed and, in
the same entry, filed a major finding against the clause it was signing — and separately offered a limb that applied the amendment's
own premise to a case the amendment had exempted, at its own cost. A signature
process that produces findings is working; one that produces only signatures is
measuring nothing.

### 3.6 Decision records

A **decision record** is a numbered document capturing one non-obvious choice: its
status, its deciders, what commissioned it, what it affects, the context, the
decision, the alternatives considered and why each was rejected, the failure modes
it creates or leaves open, and what it explicitly does not decide.

Rules that give it force:

**Every non-obvious choice gets one.** The test is not size. The program's own
ruling on the question: a decision record is owed when a change moves a **reading
rule** — what a figure, a signature or a piece of evidence *means* — and is not
owed for a figure, a scope, or a cure inside an already-ruled rule.

**Alternatives are recorded with their grounds.** Not as a formality: the rejected
options are the part that stops the same idea returning as fresh in six months.

**A record proposes; a different seat accepts.** The proposing seat writes the
instrument. The **acceptance act** is a separate journal entry by the seat with
authority, and it is what flips the record from proposed to in force. *Which seat
has authority is not left to inference*: for anything touching the constitution,
the charters or the enforcement scripts it is the orchestrator, because those are
the files it alone can stage; for anything else it is the seat named in the
record's own deciders block, which must not be the proposing seat.

**The instrument does not edit the file it governs.** Where a record amends the
constitution, the new constitutional text is written *in the record* as source
text, and applied to the constitution by the seat that owns that file — the
orchestrator — in its own commit, citing the record `[MC · C-87]`. The ownership
half is mechanical: no other seat can stage the constitution, so an author
physically cannot apply its own constitutional diff. The writing-it-in-the-record
half is a convention, and the record shows it working, including instruments
whose diffs sit written-but-unapplied while the rule they record is already in
force. This is not deference — it is the rule that an agent which can amend the
constitution by citing its own decision record can amend the constitution.

**Status is dated.** A record states, per clause, what is in force at its own
landing and what act would change that `[RE · C-88]` — and the live test of the
form is a record that says, in its own status block, *proposed, and the rule it
records has been in force since this date*. That shape is what makes a
proposed-but-operating rule measurable at all, instead of quietly true. When the acts land, the status line is
flipped by an act of its own, citing the accepting and applying entries — and the
original status table is preserved rather than rewritten, because a status table
edited on every change stops being a record of how the change happened.

**The failure class.** Verbal agreements. A decision that lives in a conversation
is re-litigated at every later contact with it, by parties who each remember a
slightly different version, and the alternatives that were considered are gone —
so the rejected option returns as a fresh proposal and is rejected again, at full
cost, or accepted this time by accident. The separated acceptance act prevents a
different failure: a seat granting itself a permission slip. And the dated status
prevents the one this document's own program committed and then repaired — a
governance file whose front matter says "not in force" for a week after it came
into force, pointing every new reader at a constitution that no longer exists.

### 3.7 Gates

A **gate** is a committed checklist that a program must fully sign to move to its
next stage. Every signature is a reference to a journal entry, so governance
itself is diffable, and **each signature must reference an entry that states, in
the signer's own log, that it signs that item** `[RE · C-89]`. No script parses a
checklist; the discipline is that a signature which does not resolve to such a
sentence is not a signature, and a reader can check that by following the
reference.

The conventional set is: one org-ratification gate at the start (§1.7), then per
phase a specification-freeze gate, an artifact-ready gate, and a phase-acceptance
gate. Their preconditions are stated in the constitution as clauses, and the
checklist quotes those clauses verbatim rather than paraphrasing them
`[RE · C-90]`.

**FACSIMILE — instance, not norm.** The checklist's shape, written from this
program's founding gate, with seats named by function. It is here because §6.2
Step 5 and §1.7 both terminate in this artifact and no earlier edition gave it a
form. `[B.9·11]`

```
# Gate <name>
<what passing this gate means, and what may not happen until it passes>
<the two declarations that carry this file's own honesty, in its own text:
 "this file states no condition its cited source does not contain" and
 "no box in this file is checked by its author">

| # | Item                                              | Owner  | Status | Signature        |
|---|---------------------------------------------------|--------|--------|------------------|
| 1 | <a precondition, quoted verbatim from its clause> | <seat> | done   | J-<seat>-NNNN    |
| n | **Sponsor**: <the act no seat inside can perform> | sponsor| done   | <the act, dated, transcribed; authority in the transcriber's own entry (§4.7)> |
| n+1| **Gate release**: <critical finding> dispositioned by a decision record **and re-verified by the filing seat> | auditor | open |  |

## Open items
<numbered; each with the seat that owns it and the event that will close it>
```

Three properties of that table are the mechanism and the rest is layout: the
**Signature column holds an entry reference, never a name or a date**; a row
whose reference does not resolve to a sentence saying *I sign this item* is not
signed; and a gate with any row open is a gate that has not passed, which is how
a solo adopter's honest founding stays honest (§6.2 Step 5).

Three rules make a gate more than paperwork:

**A gate file states no condition its cited source does not contain.** This is
written at the top of the checklist itself, because the family has failed exactly
there. `[P1 · 2026-08-11 · C-91]` — the sentence is in place, in the current
checklist, together with the flat declaration that the file adds no condition of
its own.

*Anonymized pattern, and it is the program's most-cited conviction.*
`[P1 · 2026-08-11 · C-92]` A reusable gate block extended a constitutional gate
condition to a second kind of artifact *while citing the constitution for the
extension*. The constitution never said it.
The diagnosis is the memorable part: **the packet quoted its source accurately;
the source was wrong.** A checklist that reads a constitutional clause into
compliance is a checklist that has amended the constitution without an amendment.

**No box in a gate file is checked by its author.** The orchestrator transcribes
every signature; the signature's authority is the referenced entry, and the
checklist edit is clerical `[CORRECTED · C-93]`.

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

**The residue, declared.** A signer *can* stage the file carrying its own
signature. What stops it is a sentence in that file and the reviewing seats. Two
repairs are available and they are not equivalent: narrow the scope table so the
gate directory is carved out of every signer's scope — which converts the
convention into a refusal — or keep the scope and keep declaring the residue. The
first is an amendment to another seat's file and is **routed, not performed
here** (**Annex B**). The same false premise appears in the constitution's own
words, and is routed with it.

*Failure class.* A signer that can edit the record of its own signature can edit
the scope of its own signature. **And the second-order one, which this entire
margin note is an instance of: a control whose enforcement mechanism was never
probed will be described as the strongest mechanism available rather than the one
in place** — nobody chose to overstate it; the sentence was inherited from a
source that had also never probed it.

**Open items are carried with owners and closing events.** A gate's checklist
carries a numbered list of unresolved items, each with the seat that owns it and
the event that will close it — not a vague "to be addressed."

*Failure class.* An unowned open item is a closed item nobody has admitted to
closing. Owner-and-trigger is what makes an unpaid debt visible at the next
reading rather than at the postmortem.

**And the rule that keeps gates honest about themselves:** a gate item is not
closed by a document that proposes its reading, nor by a countersigned one, nor
even by an accepted one. It closes when the gate's own record is repaired and its
row signed.

### 3.8 Sign-offs, and why honest failures are preserved

A **sign-off** is the verification line's verdict on one artifact: pass or fail,
with the suite named, the exact commands to reproduce it, the requirement-to-test
mapping with gaps declared, the stress-test results, the seeded-defect
dispositions, **the external anchor's disposition per stimulus class — with what
the anchor does not cover named beside what it does, and no artifact-level claim
assembled out of passing classes (§1.4(e))** — and open defects.
**This list is a floor, not a description of any packet.** It is the least a
sign-off may contain; the one in this record carries elements it does not name,
and the anonymized pattern below is one of them. A sign-off is a merge
precondition and it is relayed verbatim.
`[P1 · 2026-08-11 · C-94]` — **the described form is real and the sample size is
one.** Exactly one sign-off exists in this program's record; it carries every
element named above, the anchor element included — that element was added to this
list **after** the measurement behind the stamp, on the verification lead's own
correction, and was checked against the packet in the same act *(no posture row;
**Annex B**)*. An adopter should read this section as a form that has been
executed once, well, rather than as a form worn smooth by repetition.

**A sign-off may say FAIL, and a FAIL is preserved.** Failing verdicts are not
withdrawn when the defect is fixed; the repair is recorded beside the verdict. The
same applies to a prediction that was wrong and to a measurement that was later
superseded: the record keeps what it measured. `[P1 · 2026-08-11 · C-95]` — that
one sign-off is a pass that quotes its own two earlier failing verdicts inside
itself, which is the only reason this rule can be said to have been tested at
all.

**And a sign-off's reporting form is not allowed to force a fold.** Where the
honest answer to a question has four columns, a rule demanding one ratio is a rule
that pressures its reporter into collapsing distinctions.

*Anonymized pattern.* `[P1 · 2026-08-11 · C-96]` A verification lead reported a
campaign in five columns rather than the ratio the constitution asked for, on the
stated ground that
collapsing a never-rendered defect class into "killed" would overstate coverage
and into "survived" would libel a suite that was never given anything to catch.
The packet was right and the rule was wrong; the rule moved to where the practice
already was. The general form: **when an honest reporter's output does not fit the
reporting rule, check the rule first.**

**What a sign-off cannot account for is accounted for by someone else.**
`[B.8·17]` A
sign-off is a verdict at one state, by the line that produced the measurements.
It cannot report what it is about to miss. So every divergence found **after**
it passes — in a later replay, an integration, an audit — lands in the
auditor's **escape ledger** (§1.5, item 5), naming the sign-off that let it
through, the event that surfaced it, and the owning line's own root-cause entry.
The verification line's cooperation is a duty; the *record* is not its
property.

Two properties make this the sign-off's necessary companion rather than a
report. It is the only instrument that makes a **pass rate** falsifiable — a
line whose sign-offs are never revisited has an unfalsifiable one — and it puts
the count of the misses **outside the seat whose misses are counted**, which is
§5.7's root class applied to the one number a verification line would most like
to own. *Posture: no row — added after the measurement; **review-enforced**,
carried by the auditor's charter as a mandatory owned artifact and a checked
item of its definition of done.*

**Sample size: zero — the ledger has never existed.** That fact is stated once,
in full, with its check and its two candidate readings, at **§1.5 item 5**; this
is the pointer to it. What it means *here* is the part that belongs to this
section: the pass rate this paragraph calls falsifiable **has not yet been
falsifiable in this record**, so the sentences above describe the instrument's
design and not its operation. State the two facts adjacently or a reader will
take the second from the first — *this is the sign-off's necessary companion*,
and *the one sign-off in this record was issued without one*. `[B.9·6]`

**The failure class.** A sign-off that can only say PASS is a rubber stamp, and
everyone downstream knows it, so it stops being read. Preserving failures is what
makes a pass mean something. Beyond that: a system that erases superseded
measurements loses the ability to distinguish "we fixed it" from "we never had the
problem," which is precisely the distinction a later reader most needs.

### 3.9 Seeded-defect campaigns

This is the mechanism that makes "the tests pass" falsifiable.

A green test suite is consistent with a suite that checks nothing. The only way to
learn whether a suite has teeth is to put known defects in front of it and see
which ones it catches. So the **auditor** — the independent seat of §1.5, for
which a defect manifest is one of its own reports — authors **defect manifests**:
deliberate defects, each in a stated class. The orchestrator applies them in an
isolated state and runs the suite, and the results are scored against predictions
**sealed before any defect diff existed** — by the seat that froze them, under
the four constraints and the one named residue that §3.3 sets out. *(The phrase
read "before any defect existed" in the previous edition, and this section, §3.3
and §3's packet table gave three incompatible accounts of the same mechanism.
They were brought into agreement in the fourth edition and §3.3 is the single
place the mechanism is stated.)* `[B.9·1]`

**The campaign is placed per artifact, not on a cadence** `[CORRECTED · C-97]`.
Its position is exact and it is stronger than a cadence: **after the implementing
line's review has accepted the artifact, and before the verification line may
issue its sign-off** — so the sign-off itself reports the disposition of every
seeded defect, and the artifact-ready gate merely re-checks what the sign-off
already had to state. A cadence would let an artifact reach sign-off between
campaigns; the placement makes a campaign a **precondition of the merge** rather
than a periodic exercise.

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

**FACSIMILE — instance, not norm.** How a reference is *marked*, since the whole
never-merged property rests on the marked population being enumerable and the
previous edition never said what marking is. It is a **reserved name prefix**,
one segment, used for nothing else:

```
<prefix>/<campaign-id>-<class-id>       e.g.  mut/wo-0039-b2
<prefix>/<probe-slug>                   e.g.  mut/bug3-sev-probe
```

The prefix is what turns *"is this reference part of the lineage?"* into a
question a script can ask and a standing duty can answer. **A model that depends
on a population being enumerable needs its enumeration rule written down**, or
the measurement guarding it measures whatever its author remembered to look at.

The sequencing and the separations matter more than the technique:

**The subject under test is the test suite, not the artifact.** The campaign brief says
so explicitly, because a campaign read as a test of the artifact produces the wrong
response to every result. `[RE · C-98]`

**The seeder never operates the repository; the operator never authors the
evidence.** The independent seat composes the defect table and cannot make a defect
land differently from what its manifest says, because it does not push. The
orchestrator executes a table it did not compose, so its own errors — wrong base,
skipped class, wrong order — are checkable against the table by anyone.
`[RE · C-99]`

*And this rule is one day older than the first edition that presented it as
settled discipline.* It became standing after a major finding was sustained
against the commissioning seat's own dispatches, following an episode in which
the auditor did cut, commit and push — on instruction — plus three earlier
deviations. The instrument that records it is still **proposed**. Carry the rule;
do not carry the impression that it has been holding since the founding. **A rule
minted from an incident is at its weakest in the rounds immediately after it,
when nothing has yet tested whether it survives inconvenience.**

*Failure class, from the incident that produced the rule:* an agent whose entire
value is that it did not touch the artifact, touching the artifact — with an
irreversible command, under an identity whose write scope forbids the paths
involved, and with no journal entry to attribute it.

**Mutated artifacts never enter the lineage.** Manifests are applied on marked
references that are never merged (or, where a local run is possible, in a working
state that is reverted); the permanent history contains no commit in which the
artifact is deliberately wrong. The alternative of landing the defect behind a
revert is rejected outright — it puts a wrong artifact in the lineage and makes
every later historical diff untrustworthy. `[RE · C-100]` — **nothing prevents
such a reference from being merged**; that none ever has been is a measured fact,
re-checked reference by reference by an independent seat, not a guarantee. If you
adopt the pushed-reference model, that measurement is the control, and it has to
be someone's standing duty.

**No agent in the graded line is running while a manifest is applied**, where the
graded line is every seat that could repair the artifact under measurement. The
"report, never repair a suspected seeded defect" clauses in the builder charters
are the safety net for a sequencing error, not the normal case. `[RE · C-101]`

**The seeder reads from an allowlist.** The campaign names the complete set of
paths the seeder may read; everything else is out of bounds — **by declaration,
not by construction** `[RE · C-102]`. No read denial exists (§1.4(c), **Annex
A**); the allowlist is carried in the campaign packet, and it is enforceable only
in the same way every read restriction here is.

*Failure class.* A denylist cannot be defeated by a document the author forgot to
enumerate — which is the failure mode denylists actually have. An allowlist fails
closed.

**What is sealed is not the existence of the campaign but the discriminating
part**: which units must go red, which must stay green, and the exact expected
failure messages `[RE · C-103]`. **The set of units that turns red rarely
distinguishes one seeded class from another** — two unrelated defects routinely
light the same units — **so the seal that discriminates is the expected message
text**, taken from whichever assertion speaks first. A seal that predicts only
*"these units fail"* is a seal almost any defect satisfies, which is §3.3's
vacuous-prediction case arriving through the front door.

**Scoring is a discipline of its own**, and it is where most of the program's
hardest reasoning went.

**Import these as rules; do not re-derive them.** Each bullet below is a
compressed ruling from a round that mis-scored something, and the rounds cost far
more than the rules. Every one of them is **review-enforced** — no script reads a
tally, a column, an equivalence proof or the floor, and one citation covers the
whole block `[RE · C-104]` — so the only thing standing between these rules and a
wrong number is a reader who knows what each is for. That is why the referents
below are spelled out rather than left as the shorthand the originating rounds
used: **a rule you cannot picture failing is a rule you will apply to the wrong
object.**

*And a boundary on that instruction, stated by the seat these rules bind, because
without it the instruction reads across into two things it does not govern.*
**These are the properties the record must be able to answer for, not a reporting
form.** The form is the reporter's, and it is expected to move when a campaign
shows it insufficient — in this record the reporting schema moved twice in nine
days, once because the reporter found a column insufficient and once because the
clause being codified forced it. An adopter who imports the bullets and freezes a
column set has imported the rule and lost the calibration. Nor does the
instruction reach the **figures** the rules govern: the standing discipline there
is the opposite one — *a figure carried across rounds is re-derived by the method
its carrier claims, or the carrier states that it was quoted.* **Import the
rules; re-derive the numbers.**

The rules that transfer:

- **The question is present-tense.** The gate asks whether the suite *as it stands
  now* kills what was seeded — not whether every past campaign scored perfectly. A
  campaign's score is a frozen measurement and is never retro-edited; the score and
  the suite's present capability are different objects.
- **Two columns, and the difference itemized.** *Sealed* is every defect class the
  manifest sealed, with nothing removed for any later reason. *Seeded* is the
  subset actually rendered as sealed and run. Every member of the difference is
  named with its ground.
- **The known grounds for a class sitting in one column and not the other** are
  three, and each is spelled out below with what it looks like in practice,
  because the shorthand names are the part that got misapplied.
- **Ground 1 — never rendered.** The manifest sealed the class and no patch for
  it was ever written. This is *not* a defect the suite failed to catch; it is a
  defect that does not exist. Folding it into "caught" overstates coverage;
  folding it into "missed" libels a suite that was never given anything to find.
- **Ground 2 — unscoreable.** A patch was written and run, and inspection
  afterwards showed it did not render the class the seal named: it changed
  something adjacent, or was neutralized by a construct the author had not read.
  Its run is a **scope report** — it tells you what the campaign actually covered
  — and it supports **no claim about the suite in either direction**, because the
  suite was never shown the class in question.
- **Ground 3 — negative control.** A class seeded deliberately so that a *named
  assertion stays green*, to show the campaign's instrument is not simply
  lighting up at everything. Its seal predicts the green and declares in advance
  that the class scores nothing. A campaign with no negative control cannot
  distinguish a suite with teeth from an apparatus that reports failure whatever
  it is fed.
- **The list of grounds is open and the naming duty is not.** A class excluded on
  any ground is named with it, where the reviewer reads the ground and may refuse
  it. Leaving the openness implicit is how a normative property nobody wrote down
  comes into being.
- **A ground that turns on what the seal disclosed holds only where the disclosure
  was frozen before the run**, never on what the run returned. Grounds 2 and 3
  are both of that kind, and naming which they are is the difference between a
  rule and a rule a reader has to reconstruct.
- **The unit of the record is the defect class**, not the branch or file that
  delivered it. A ref population grows by infrastructure accident and cannot be a
  denominator.
- **Every non-kill is named individually**; no non-kill is folded into a kill and
  no ratio stands in for the dispositions.
- **A defect that survived its own campaign** — meaning its seal predicted a kill
  and no unit killed it — and was later caught is dispositioned in exactly one
  evidence form: the *unmodified* committed diff, replayed against the suite as it
  stands now, at a run id, with the killing unit named. Anything weaker lets a
  survivor be argued dead. The asymmetry with the next bullet is the reason for
  the strictness: **a rehabilitation reverses the record's own measurement and so
  needs a new one, while a kill's disposition preserves that measurement and needs
  only that its instrument still stands.**
- **A campaign kill is a frozen measurement too**, so it is dispositioned by its
  campaign record *together with the named killing unit, present and green now*.
  That form catches a killing check deleted or disabled since. **It does not catch
  one weakened, nor a class whose rendering no longer applies to the artifact, nor
  a record whose unit names no longer exist in the suite** — and the distinction
  between those three is the part worth importing: the first is disclosed in the
  clause itself, and **the other two were found afterwards, by applying the
  clause.** In this record five of thirty-seven committed renderings no longer
  apply to the artifact they were scored against — the survivor form replays a
  patch and so self-checks against that drift, while the kill form asks only that
  a unit be present and green and cannot notice that the class's rendering has
  stopped existing — and the unit names the older campaign records carry were
  later retired wholesale, so a literal application of *the named killing unit,
  present and green* fails at every class of four campaigns for a reason that is
  not a missing instrument. **A form whose limits you inherit as complete is more
  dangerous than a form you know to be partial.**
- **Equivalent defects leave the denominator only on a proof.** *(This
  document's **equivalent defect** is the constitution's **equivalent mutant**,
  and the two names are deliberately not unified: this section is de-domained to
  "defect" throughout, and one bullet in the domain's vocabulary would read as a
  different concept. The pairing is carried in the name map, **Annex C**, which
  is what §6.2 Step 0's cross-repository greps read — council round-3,
  vocabulary drift.)* A defect no
  conformant observation can distinguish from the correct artifact is *equivalent*
  — but only where the equivalence is proven in a committed artifact, the proof
  quantifies over the **specification's** legal input space and never over a suite,
  and the seeder records the exclusion in its own artifact. An argument that a
  suite cannot reach the defect is a coverage gap, not an equivalence.
- **Unreachable checks contribute nothing to a coverage claim** while still
  discharging their requirement. A check that **no possible defect of the
  artifact could reach** — because the structure forecloses its case, or the
  specification leaves that case unconstrained — has already been counted once as
  a discharged requirement; counting it again inside a coverage figure counts the
  same single observation twice, and the second count is the one that inflates
  the figure. A check the seeded set merely *happened* not to reach is a
  **seeding gap**, not an unreachable check, and may not be entered in the
  unreachable set. Publish the unreachable set **beside** the tally, so no
  "N out of N" is read as coverage.
- **A floor on the number of seeded classes** — at least three, spanning distinct
  defect classes — measured before any equivalence exclusion, so that the one
  mechanical-shaped bar in the discipline cannot be cleared by subtraction.

*Three anonymized patterns, because the bullets above are rulings and a ruling
without its case is a rule nobody can apply. Two of them are defects the rule was
written **against**; the middle one is a practice the rule was written **from**,
which is the better kind of exhibit and the rarer one — and reading a set like
this as three failures is how the middle one came to be written up as a lapse
that never happened.*

**The column that was not its label.** A tally published a column headed
*sealed*. It **excluded** an item the record had itself declared sealed, and
**included** one that had never been rendered at all, on two grounds that had
never been stated together anywhere. The verdict lines then qualified themselves
with a single word — *scoreable* — that appeared in no normative document. The
defect surfaced only because someone was writing a rule to codify the practice,
and would have frozen the wrong definition: the draft was taken from the
practice's **columns**, while the operative word lived in its **verdict lines**.
A third instance then surfaced by a **different route**, in a later round: not by
walking the record again, but by reading the **drafted clause** against it — the
codification finding one more case of the defect it was being written to cure.
The exact route is the sharper telling and the one worth carrying: **two of the
three were found by looking at the record, and the third by writing against it.**
This is why the naming duty is closed while the list of grounds is open (§5.2).

**The survivor whose rehabilitation expires.** Exactly one defect in this record
survived its own campaign — its seal predicted a kill and no unit killed it —
and it was rehabilitated in the strict form from the first statement of it.
**This is the exhibit written *from* a practice rather than against a lapse**,
which is the rarer and better kind. The hazard it exists to name arrived
afterwards, and it is the one an adopter will actually meet.

The form the rule demands is the narrow one that cannot be argued — the
**unmodified committed patch**, replayed against the suite as it stands at the
gate, at a run identifier, with the **killing unit named** — and the campaign's
own recorded `survived` count is kept beside it, unedited: two facts, never
folded into one. Every weaker form permits a survivor to be argued dead: a re-run
of a *rewritten* patch, a claim that some unit "would now" catch it, a ratio that
no longer names it.

**And the record's real hazard is the mirror image of the one this exhibit used
to describe.** The replay that rehabilitated this program's one survivor was
taken against a suite that has since moved by nearly twenty thousand added lines
across forty-five files. The patch still applies, so the repair costs a single
run — but an independent seat filed the point before anyone needed it: **a
rehabilitation is good only at the state it was taken at, and citing an aged run
identifier is the same defect wearing the approved form.** That is the failure an
adopter will actually meet, because the strong form looks identical on the day it
stops being true. **When you adopt an evidence form because it cannot be argued
with, record its expiry conditions in the same clause.**

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

**The killing unit that had no unique referent.** A clause required a kill to be
dispositioned by naming *the* killing unit — singular — against a record in which
one class was killed by four units, another by nine, and a third by one of three
required together. Two readings were available and they differ materially: *all
of them must still stand*, which is wider than the hazard, or *any one suffices*,
which lets the disposition pick the most durable unit at gate time. The seat that
found it filed against a clause it had itself signed, routed the fix to the seat
the width would fall on, and the one-word repair was **stopped** rather than
applied. Two grounds, and the second is the stronger one: by then the word was
live constitutional text, so curing it in the record alone would have left
authority and constitution disagreeing (§4.8) — **and the constitution was not
the drafting seat's file to stage**, a refusal the scope check performs
mechanically and the commission forbade in its own words. **A refusal a machine
also enforces is a different exhibit from a refusal someone chose**, and the
weaker reading was the one this passage carried. The general form:
**a singular noun inside a counting rule is a specification of uniqueness, and if
the record's instances are plural the rule has already been applied to something
it does not fit.**

**The failure classes, collected.** *Without the campaign:* "the tests pass" is
unfalsifiable and a suite silently rots into a syntax check. *Without the sealing:*
the campaign is scored by hindsight. *Without the separations:* the party whose
work is being measured chooses the measurements. *Without the itemized
dispositions:* a single ratio hides exactly the cases that carry information — the
survivors — and the ratio is what everyone downstream reads. *Without the
equivalence proof standard:* "that one is equivalent" becomes the sentence a party
writes when its suite did not catch something and it would rather not say so; the
definition is unfalsifiable from the losing side, since a blind suite and an
equivalent defect emit identical evidence. The proof standard is what converts most
misuse attempts into admissions of a coverage gap **by their own wording** — a
guard that works on the party trying to evade it.

### 3.10 The lessons harvest

Every sign-off and every gate carries a **lessons harvest**, and it is a
precondition of the gate rather than a follow-up to it `[RE · C-105]` — declared
review-enforced in the constitution's own clause, and practised: the program's
first harvest ran across five seats, and the gate block carries unchecked boxes
that hold the gate closed until they are paid.

Each seat with a permanent journal mines **its own** log over the span since its
last harvest, stated as an entry-id interval so that spans tile and a skipped
harvest is a visible gap. A lead also mines the worker spans it commissioned. A
candidate rule is admissible only if it:

- **cites the incident** that taught it, at the state where a reader can see the
  thing going wrong;
- **states its observable in terms portable beyond the project**; and
- **says what breaks without it** — a concrete outcome a reviewer could recognize
  in someone else's repository, not a virtue.

Portability has two grades: **general**, whose rule statement contains no proper
noun of any kind and must teach a stranger to both the domain and the project; and
**domain**, which may name domain nouns (standards, algorithm families, encodings)
but no project nouns, and must name the domain pack it belongs to. Both are read
with the provenance hidden. Anything passing neither is recorded as a war story —
kept, binding nowhere, re-offerable later — or adopted locally by its own
instrument. **A nil yield is declared, never omitted.**

A **domain pack** is a named bucket of rules that hold for one domain and not
universally — a protocol family, a class of algorithm, an interface standard. A
domain-grade rule names the pack it belongs to so that a later program pulls in
only the packs whose domains are its own. **State where your packs live before you
run your first harvest**, even if the answer is "one file in this repository":
this program routes admissible candidates into a separate reusable repository
(§6.0), and the harvest is worth running from day one only if its output has a
destination on day one.

The classifier is run **by the mining seat, on its own candidates**, in a fixed
order, starting from the most general honest statement: the domain grade is
reached only *through* a general statement that was attempted and found hollow.
The collating seat re-runs it as a check, with the provenance hidden.

Collation is clerical. The collating seat may bounce a defective statement back to
its author and may not improve one `[RE · C-106]`.

**And the harvest is where the sponsor's fifth standing power is exercised.**
*(No posture row — added after the measurement; posture **review-enforced**,
granted by the constitution's harvest clause.)* `[B.8·2]` The collated
candidates are
**sponsor-visible at the gate, and the sponsor may refuse a candidate — one at a
time, by name, with no obligation to refuse the batch or accept it.** That is
why this program's transit takes the form it does (§6.0): the harvest is
delivered to its destination as a *proposed* change that a human can decline
item by item, rather than as a push that has already happened.

*Why the granularity is the whole point.* A batch that can only be accepted or
rejected whole converts the one human judgement in the export path into a
formality — nobody refuses eleven good rules to stop one bad one. **A refusal
power that cannot be exercised at the granularity of the thing being refused is
not a power, it is a notification.** Note also which direction it runs: this is
the only place in the process where the sponsor can stop something that is
*correct by every internal check* and still not wanted outside the program.

**The failure classes.** *Without the cadence:* lessons live in one session's
context and die with it, and the same defect is rediscovered at full price. *Without
the provenance requirement:* a lesson decays into a preference — a strongly held
rule nobody can attach to an incident, which is indistinguishable from taste and
gets argued rather than applied. *Without the portability grades:* the corpus fills
with statements that are true only here, and a later adopter cannot tell which are
which. *Without tiling spans:* a skipped harvest is invisible; with them, it is a
gap in an interval sequence. *Without the clerical rule:* a collator who edits
statements shapes the corpus with no record showing it — the selection becomes
invisible, which is worse than a biased selection that can be seen.

*Two diagnostics the program keeps for the harvest itself.* A harvest whose war
stories are always empty says something about the bar, not the span. A harvest
that yields only domain-grade rules and no general ones says something about the
miner: the domain grade is a rescue for statements that cannot generalize, not a
shortcut past the attempt.

---
## 4. The operating disciplines

The rules in §2 are enforced by machinery. The practices in this section are
enforced by habit and review, and they are the ones most likely to be dropped by
an adopter who has not paid for them. Each is stated with what it costs when it is
missing.

### 4.1 The abort-first precheck

Before opening a single file for editing, an agent checks the state of the working
tree and the current commit against what its instructions said to expect, and
records both in its journal. If the tree is dirty in a way the dispatch did not
declare, or the commit is not the expected one or a descendant of it, the agent
**stops and returns a refusal with the forensic detail**, rather than proceeding.
`[RE · C-107]` — carried by dispatch text and by the *Trigger* and *Actions*
sections of the resulting entry; no instrument enforces it. Both the audit that
produced this edition's stamps and this revision performed it and recorded the
two commands' output.

**The failure class.** An agent that starts editing a tree it has not looked at
does one of two things: it commits someone else's uncommitted work under its own
name, or it builds on a state that has since moved and produces a change that
silently contradicts what landed in between. Both are discovered late, both are
expensive to unpick, and both are prevented by two commands and a habit.

**The refusal must be the default, not the option.** A precheck whose failure
branch is "use judgment" is a precheck that always passes.

### 4.2 Declared siblings, in both directions

**Outward:** a dispatch names every other agent that may be writing concurrently,
and what paths they may touch. An undeclared dirty path is an abort.

**Inward:** if the current commit moves while an agent is working, the agent
verifies rather than assumes — that the new commit is a descendant of the expected
one, which paths it touched, and whether any of them intersect its own — re-runs
any measurement that could have changed, and records all of it in its return.
`[RE · C-108]`

**The failure class.** Two sessions writing concurrently, each assuming it is
alone. Without the outward declaration, a legitimate concurrent landing is
indistinguishable from contamination and either halts a healthy round or waves
through a bad one. Without the inward declaration, a mid-round landing is
invisible: the agent's measurements were taken against a state that no longer
exists, and nothing in its return says so. The second direction is the one usually
forgotten, and it is the one that produces confidently stale evidence.

### 4.3 Verbatim relay, with the relayer's additions marked

Traffic between seats is classified. Routine traffic may be summarized when
routed. Protected classes — sign-off packets, defect packets, **sealed
predictions**, and every auditor finding — are relayed **unedited**, because
fidelity is load-bearing there. The relay-fidelity spot-check on the protected
classes is the auditor's charter duty `[PLANNED · C-109]`.

*The seal's inclusion is a repair, and it carries one extra rule.* §3's relay
table has always marked a sealed prediction **Verbatim**; this section's list of
protected classes omitted it, so an agent implementing relay policy from §4.3
alone would have summarized a seal — and a summarized prediction is a prediction
its author can be argued out of. `[B.8·4]` The extra rule:
**before unsealing, a seal is not relayed at all.** Verbatim is the rule for
traffic that moves; a seal that has not been opened does not move, and the
routing seat's duty is to carry the *fact* of it and none of its content. Both
halves matter — relay it early and the campaign is a confirmation, summarize it
late and the score is negotiable.

*Stated as owed, because it has never happened.* Early in the program the auditor
recorded that fidelity was untestable — no protected-class packet had yet been
relayed. Protected-class packets have existed since, in quantity, and **no
spot-check followed**. This is the same dormancy as §1.1's residue, and it is the
control that the exhibit below exists to justify.

*What that sentence does not say, on the correction of the seat that owns the
traffic.* It names **one instrument** — the auditor's sampling of the protected
classes — and not the whole subject. Two fidelity checks have in fact fired in
this record, **both by receiving seats** reading a relay against its source
artifact — the discipline stated two paragraphs below, and a different control
with a different failure mode: it fires only where a receiver happens to look,
and it cannot sample the relays nobody contested. **The owed instrument stays
owed; the record is not empty.** Both readings are worth having, because an
adopter who hears only the first will build the sampling round and drop the
receiving-seat habit, which is the one that has actually caught things here.

Where a relaying seat adds anything of its own — an interpretation, a
generalization, a gloss that makes a quoted test operable — it is **marked as the
relayer's**, so it can be attacked rather than absorbed.

And where a relay's fidelity matters to an argument, the receiving seat checks the
relay **against the source artifact** rather than reasoning from the relay.

**The failure class.** A relayer softens a finding — not by malice, but by
compression, which always removes the sharp part first. A summarized finding loses
the exact word the finding turned on, and the receiving seat then reasons
correctly from a subtly wrong premise. Marking additions prevents the second-order
version: the relayer's own reasonable-sounding gloss becomes, one hop later,
indistinguishable from the original filer's words and acquires the filer's
authority.

*Anonymized patterns — the benign case first, and then the two that were not.*
`[P1 · 2026-08-11 · C-110]` A finding about record fidelity was relayed with one
word dropped — the relay of a fidelity complaint itself demonstrating the
fidelity hazard. Nothing turned on the word, which is exactly why it is worth
keeping: the mechanism failed where it cost nothing, and was visible there.

*(**SUPERSEDED — historical record, not current law:** this passage previously
closed by saying the mechanism failed in the benign case "and was therefore
visible before it failed in a case that mattered." That is no longer true of
the record, and the seat on the receiving side of both later failures is the
seat that said so. Note what the false half was doing: it made a real exhibit
carry a **reassurance** the record does not support, which is how a document
acquires a claim nobody ever filed.)*

**An unmarked relayer addition.** The same relay reported a killing unit as
**present** under the name the suite uses today, for classes whose campaign
record names that unit in a **retired namespace**. The mapping was correct; it
was performed silently, by the seat least likely to get it wrong; and it is
invisible in the artifact. That is an addition absorbed rather than attacked —
precisely the second-order failure the marking rule above exists to prevent. And
what it silently closed was not a triviality: under a literal reading of the very
clause the relayed finding was about, that namespace difference fails the
disposition of **every class of four campaigns** — a major finding in its own
right, which is what it became once a seat had to state it out loud instead of
absorbing it.

**A faithful relay that omitted three findings.** A later relay in the same round
quoted the committed act accurately and **carried three of its findings not at
all**. Nothing was altered; something was left out — compression removing what
nobody had asked for, which is this section's own failure class in its non-benign
form.

Both were caught the same way, and it is the way the two rules above prescribe:
**a receiving seat read the committed source instead of reasoning from the
relay.** Neither was caught by the relayer, and neither would have been caught by
a sampling instrument that does not exist. The marking rule and the source-check
rule had carried no exhibit at all until the fourth edition; these are theirs.

### 4.4 Push at every landing

Committed is not safe. Work is durable only once it is pushed, and the discipline
is to push at every landing rather than at the end of a session. `[RE · C-111]` —
a habit of the committing seat, with no instrument, and the one discipline in
this section that **was not measured** by the audit behind these stamps: it is
not checkable from a repository copy without comparing against the remote.

**The failure class.** A container, a session or a machine dies with an hour of
uncommitted or unpushed work inside it — and, because agents are stateless, the
replacement has no memory of what was in flight. The cost is not merely the lost
work; it is that the replacement session cannot tell what was lost, so it either
redoes work that already landed or omits work that did not.

### 4.5 Incident recovery

When a session dies mid-round, the recovery has a fixed shape:

1. **Preserve the partial as evidence**, outside the working tree.
2. **Discard it from the tree.** A partial edit is not a draft; it is an artifact
   whose author cannot be asked what it was going to say.
3. **Derive fresh.** The replacement is told explicitly that no prior partial
   exists and everything is derived from the committed record.
4. **Record the incident** in the round's journal entry, including the fact that
   the round is a respawn.

`[RE · C-112]` — no instrument, and executed in full on the round immediately
before the audit that produced these stamps: a round stopped mid-flight, its
uncommitted work preserved outside the tree as evidence, the tree cleaned, and
the replacement told explicitly to trust no prior partial and derive from the
committed record.

**The failure class.** A partial edit resumed as though finished. The specific
hazard is that a half-applied change looks like a complete one — the parts that
would have contradicted it were never written — so the resuming agent's review
finds nothing wrong. Discarding and re-deriving costs a round; resuming costs a
defect nobody can date.

### 4.6 Escalation classes

Escalation is not a mood. There is a fixed, short list of classes that may reach
the sponsor, and everything else is decided inside the organization and recorded:

| Class | What it is |
|---|---|
| **E1** | Phase-gate approval |
| **E2** | Scope changes — adding or dropping a requirement, a phase, or a role |
| **E3** | Toolchain and licensing decisions |
| **E4** | Auditor critical findings — relayed verbatim, never summarized away |
| **E5** | Two-lead deadlock surviving one round of written argument |
| **E6** | Budget or schedule anomalies past a threshold — see below; this program's constitution gives one figure, illustratively, and the class has never fired |

**The E6 threshold, since the previous edition said *a stated threshold* and
stated none.** *(No posture row.)* `[B.9·5]` This program's constitution carries
exactly one figure for it,
and carries it as an example rather than as a bound: **a phase tracking past
twice its estimate**. That is the whole of what exists — there is no budget
figure, no second trigger, and **no round has ever fired this class**, so the
figure has never been applied to anything. Read it accordingly: the number is
**illustrative**, the parameter is **adopter-chosen** (**Annex A.9**), and the
property that transfers is not the multiplier but the requirement that the
threshold be **written down before the first anomaly**, because a threshold
chosen while looking at an overrun is chosen by the party the escalation would
embarrass. **A class whose threshold is decided at its first firing has no
threshold; it has a negotiation.**

`[RE · C-113]` — no instrument routes or counts escalations, and the table is
**partly exercised**: the gate-approval, toolchain-and-licensing and
critical-finding classes have each been used; **scope change, deadlock and budget
anomaly have never been used** in this program's life. A class that has never
fired is not thereby wrong — but an adopter should know which parts of this table
are tested and which are design.

Every escalation arrives **decision-ready**: options, a recommendation, and cost.
One that does not is bounced back. Escalations are batched, not dribbled.

Internally the same discipline applies downward: a lead that wants work done
outside its own scope files a request, and does not do the work.

Deadlock has an explicit terminal state. Where an adjudicating seat's ruling is
rejected by both parties and one round of written argument fails, it **declares
deadlock** rather than ruling again by fiat.

**The failure classes.** *Without fixed classes:* the sponsor is either flooded
with decisions that are not theirs — at which point they stop reading, and the one
that matters arrives in the same undifferentiated stream — or never told about the
one that is, because every individual item looked too small to raise.
*Without decision-ready form:* the sponsor is asked to do the analysis, which is
the work the organization exists to do. *Without a declared deadlock state:* an
adjudicator under pressure re-rules, and re-ruling by the same seat that was
already rejected converts a disagreement into a legitimacy problem.

### 4.7 The sponsor's reserved decisions

The sponsor's surface is deliberately small, and this is it **as of this
edition** — five standing items, closed by the amendment procedure rather than
by assertion:

1. the **six escalation classes** (§4.6);
2. one **one-time infrastructure setup** — the branch protection without which
   the history guarantee is convention `[P1 · 2026-08-01 · C-115]`, configured
   and live-fire verified (§2.5);
3. the standing **canary** power (§1.5);
4. **ratification of the organization itself** (§1.7);
5. **candidate-by-candidate refusal at the lessons harvest** (§3.10) — the human
   gate on what leaves the program. *(No posture row — added after the
   measurement. Posture **review-enforced**, granted by the constitution's
   harvest clause and exercised by the form the transit takes.)* `[B.8·2]`

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

*And how a sponsor signs anything, since they have no reasoning log.* §3.7
requires every gate signature to resolve to an entry in the signer's own log,
and the sponsor — a human, outside the machinery — has none. The practised form:
the sponsor's act happens outside the repository, and the **orchestrator
transcribes it** into the gate row as a dated line naming the act, with the
authority living in the orchestrator's own entry recording that the act
occurred. It is the same clerical-transcription rule §1.5 uses for the auditor's
verdicts, and it has the same residue: the transcription is the only artifact,
so a transcription nobody makes is an act nobody can cite. **State this in your
own version — an adopter reading §3.7 literally concludes the sponsor cannot
sign, which is one step from concluding that someone inside may sign for them.**

**A single file tells them how to spot-check the whole program by hand**, in
five steps: three version-control commands — every commit title with its one
agent, one agent's entire thread, and any change beside the reasoning that
produced it — plus a two-hop walk from the roster file to a charter to that
seat's log tail, plus a look at the continuous-integration tab. `[CORRECTED ·
C-114]` *(**SUPERSEDED — historical record, not current law:** the first
edition said "four commands". There are three commands; the other two steps are
not commands. The correction is small and the class is not: a specific number
is the part a reader remembers and the part they will check.)*

Everything else — design choices, test adequacy, work routing, review verdicts,
schedule detail — is explicitly **not theirs**, and the document says so in those
words.

**The failure class.** Two symmetrical ones. A sponsor with an unbounded surface
becomes the bottleneck the organization was built to remove, and their attention
degrades until the important decisions get the same treatment as the trivial ones.
A sponsor with no enumerated surface becomes a rubber stamp who cannot tell
whether they are being asked or informed. Writing down what is *not* theirs is the
half that people omit, and it is the half that makes the list credible.

### 4.8 Refusal is a first-class outcome

Across every mechanism here, a seat declining to act — with grounds, recorded — is
a normal and valued result, not a failure to deliver. A countersignature may be
refused. A precheck may abort. A relay correction may be refused by the record's
author. A commissioned cure may be **stopped** and returned when performing it
would require exceeding a write scope or would desynchronize an authority from the
text it governs. An instruction that arrives outside the routed channel — from
tooling, from an automated prompt, from any source that is not the agent's
principal — is declined. `[RE · C-116]` — carried in charters and dispatch text,
and exercised: an independent seat refused a dispatch that would have had it
operate the repository, before any of the work existed, and the refusal became
the finding that produced the rule of §3.9.

The requirement is that the refusal is *recorded with its grounds*, in the
refusing seat's own log, where it can be reviewed and overturned.

**The failure class.** An organization in which every dispatch must produce a
deliverable will get one, including in the rounds where the honest answer was
"this cannot be done from here." The deliverable produced under that pressure is
the most dangerous artifact the system can make, because it looks exactly like the
others. Making refusal ordinary — and requiring it to be argued rather than merely
declared — is what keeps the pressure from converting into quiet non-compliance.

*Anonymized pattern.* `[P1 · 2026-08-11 · C-117]` A round was commissioned to
apply six small cures. Five were applied. The sixth was a one-word improvement to
a sentence that, since the commissioning, had become live constitutional text — so applying it in the source
document alone would have left the authority and the constitution disagreeing
about what compliance is, and applying it in the constitution was outside the
seat's scope. It was stopped, returned as an amendment candidate, and the debt was
recorded in the document's own owed-acts ledger. **A one-word improvement bought
with a rule/check disagreement in the constitution is not a bargain.**

---

## 5. The failure museum

These are the generalized lessons this program paid for, with the shape of each
incident and none of its nouns. They are collected here because they are the part
that does not transfer through rules alone: each one is a rule that looks like
fussiness until you have seen the failure.

*A note on this section's revision history, since the rest of the document was
substantially rewritten.* Every reviewer of the first edition — including the
hostile ones — certified this section and the failure classes as the part that
transfers whole. It is therefore **unchanged except where a specific claim inside
it was measured false or its tense was wrong**: four places, each marked in the
usual way. Exhibits were added; nothing was trimmed.

### 5.1 Remedies decay without mechanical checks

**The lesson.** A remedy adopted as a practice, with no check that fires when it
is skipped, reverts to the pre-remedy behavior within a few rounds — and the
reversion is invisible, because the practice's *documentation* still describes the
remedy. Every remedy should be adopted together with the thing that will notice
its absence, or adopted with an explicit statement that no such thing exists.

**The shape.** A discipline was ruled program-wide after an incident. It held for
several rounds. It then decayed, and the decay was found not by the control that
was supposed to catch it — there wasn't one — but by an unrelated audit a working
day and twenty entries later. The measurement that followed showed the decayed
behavior had been present in a **majority of the record when measured as drift
past a stated tolerance** — about two thirds of entries at either of the two
candidate tolerances — and in a **plurality, about two fifths, when measured as
an outright wrong date**. `[P1 · 2026-08-11 · C-118]`

*The qualification is the exhibit, not a hedge.* **SUPERSEDED — historical record, not current law:** "A
majority of the record" is true of one measurement and false of the other, and
the first edition gave the headline number and the stronger word without saying
which measurement produced which. **A census is not one number**, and the
sentence that reports it has to carry the band it was measured at, or the next
reader will pair the strongest adjective with the most memorable figure — which
is what happened here, in a document about record fidelity.

**Its corollary about warnings.** When the appropriate check turns out to be a
warning rather than a refusal (because the subject is testimony, or because a
blocking check would make legitimate corrections impossible), the honest framing
is: the warning does not buy honesty, it buys **latency** — the next decay would
be visible in three entries instead of twenty-four. `[PLANNED · C-119]` —
**stated in the conditional because the warning does not exist.** It was
specified in the same round as the census, with measured bands and a measured
false-positive rate, and it has not been built; the instrument that would build
it is a proposed decision record (**Annex B**). The arithmetic above is a
projection from the census, not an observation of a running control.

**Without it:** every remedy in the record is a claim about the past rather than a
property of the present, and a reader auditing the program's rules cannot tell
which are live.

### 5.2 A column's name is not its definition

**The lesson.** Where a record has columns, the label on a column and the rule
that decides what enters it are two different things, and they drift. A word that
does normative work in a verdict line while appearing in no instrument is a
normative property nobody wrote down.

**The shape.** `[P1 · 2026-08-11 · C-120]` A tally published a column labelled
*sealed*. It excluded an item
the record itself had declared sealed, and included one that had never been
rendered at all — on two grounds that had never been stated together anywhere. The
verdict lines used a single qualifying word — *scoreable* — that appeared in no
normative document. The defect was found only when a rule was being written to
codify the practice: the codification would have frozen the wrong definition,
because it was drafted from the practice's **columns** while the operative word
lived in its **verdict lines**. A third item then turned up by the other route,
in a later round — found by reading the **drafted clause** against the record
rather than by walking the record again.

**The cure that generalizes.** When the same defect appears three times, stop
patching instances. The operative sentence — *every member of the difference is
named with its ground* — is ground-agnostic, and so the rule declares the list of
grounds **open** and the naming duty **closed**. A reviewer reads the ground and
may refuse it.

**Without it:** a reader of a number cannot recover what it counted, and the
number is nonetheless cited as if they could.

### 5.3 A relay can demonstrate the hazard it reports

**The lesson.** A message about fidelity is itself subject to fidelity loss.
Handle a report about a control with the control it reports on.

**The shape.** `[P1 · 2026-08-11 · C-121]` A finding about record fidelity was
relayed accurately but for one dropped word. Nothing turned on that word, which is precisely why it is a good
exhibit: the failure occurred in the benign case, was visible, and was fixed as a
practice — quote the source artifact, not the relay, whenever the quotation is
going into a binding instrument.

**The general form.** Meta-level traffic is not exempt from the hazards it
discusses. The same shape recurs elsewhere: a rule about self-review authored
without review; a document about staleness whose own status line goes stale; a
process that mines lessons and skips its own harvest.

**Without it:** the reports that would repair your controls arrive already damaged
by the defect they describe, and the damage is invisible because everyone is
reading them as reports rather than as artifacts.

### 5.4 Timestamps are testimony; entry ids are sequence

**The lesson.** A timestamp written by an author is an assertion about a clock, and
authors' clocks run wrong. Order must be carried by something mechanically
enforced — a monotonic counter — and not by a stamp. A record should say which of
its fields is testimony and which is structure.

**The shape.** `[P1 · 2026-08-11 · C-122]` Dated rows in a frozen record were
measured against the commit dates of the entries they cited. Eight disagreed — by
a day, by two days, by four. *(Re-measured independently by a later audit: the
eight reproduce row for row, and there is no ninth.)* The
cause was a drifting authoring clock rather than any reordering, and the order was
fully recoverable because a different column was exact and a monotonic id rule made
the chain's sequence structural. **No row was edited**: a frozen record is not
repaired by rewriting it. What was added was a note stating what the date column
means, which fields are exact, and which to read when order matters.

**The complementary ruling.** Stamps are taken honestly at authoring, even when
that makes them read *earlier* than the commit that carries them — because an
honest stamp that is slightly early is evidence, and a stamp adjusted to look
consistent is not.

**Without it:** a reader reconstructs sequence from timestamps, and reconstructs
it wrong, in a record whose whole value is that sequence is recoverable.

### 5.5 A guard that forecloses conduct is enforced differently from one that routes traffic

**The lesson.** Before choosing an enforcement mechanism, ask what kind of rule it
is. A rule that **forecloses conduct** — you may not write here, you may not
rewrite this, you may not stage that — can be enforced at a boundary as a refusal,
and should be, because the refusal makes the act impossible rather than merely
forbidden. A rule that **routes traffic** — this work is owed to that seat, this
finding must reach that party, this debt must be discharged before that gate —
cannot be enforced by refusal at all, because its failure mode is *silence*: an act
that never happens, which no boundary check can observe.

Routing rules need a different instrument entirely: a **named owner**, a **named
triggering event**, and a **visible debt** that some later reader is obliged to
read — a ledger row, an open-items table with a closing event, a gate that will not
close. The enforcement is that the unpaid debt is legible, not that the omission is
blocked.

**The shape.** Two families of control in this program were repeatedly proposed
with the wrong mechanism attached. Prohibitions were offered as advisory warnings —
and a warning on a prohibition is a prohibition with an opt-out. Routing
obligations were offered as blocking checks — and a blocking check for an act that
has not happened blocks the wrong thing, usually a legitimate round, while the
actual omission proceeds untouched. The rule that came out of it is stated in the
constitution as a posture declaration: **a clause says whether it is
machine-enforced or review-enforced in its own text rather than in a footnote.**
`[CORRECTED · C-123]`

**How far the practice actually goes, stated plainly and with its boundary
drawn, because a count is only as good as the thing it counts.** *(The boundary
is the fourth edition's; the count itself is the second edition's and stands.)*
`[B.8·21]`

- **Three clauses** in this program's constitution carry a **labelled** posture
  declaration — a formal *Enforcement:* tag inside the clause, saying
  machine-enforced or review-enforced in so many words.
- **Several more** declare their posture **in the clause's own prose without the
  tag**: a section heading that says *structure machine-checked, narrative
  audit-enforced*; a rule whose own honesty note says it is audit-enforced
  rather than mechanical; a rule that says it is convention until an
  out-of-repository setting exists.
- **The rest** state it in surrounding prose, or not at all — including the
  whole of the commit protocol.

The number to carry is **three**, and the boundary is *labelled*, because a
labelled declaration is the one a reader can find without knowing where to look
and a script could one day count. **A count of a practice needs the practice's
definition beside it**, or the count is contestable in exactly the sentence
whose point is that counts should not be.

*And the correction underneath is the reason the second edition existed.*
**SUPERSEDED — historical record, not current law:** the first edition said
*each clause* does this. It is an excellent practice, applied three times,
described as universal. The same over-generalization is what that edition did
to itself: it stated the posture rule and stamped nothing. **A practice you
have applied three times is a practice; write the number.**

**Without it:** you will build an enforcement layer that is simultaneously
oppressive and porous — refusing things that should be argued, and advising about
things that should be impossible — and its failures will be read as evidence that
process does not work.

### 5.6 Repairs that verify each other belong in one commit

**The lesson.** When two changes are mutually load-bearing — where each becomes
derivable, checkable, or even statable only once the other exists — splitting them
across commits produces an intermediate state in which the record asserts something
that cannot be verified from the tree at that point. Land them together.

**The shape.** `[P1 · 2026-08-11 · C-124]` A long repair arc produced, among other
things, a measurement whose instance was underivable until a table landed later
in the same arc. Read from the
record, the earlier commit contained a claim whose support arrived afterwards — not
false, but unverifiable at its own state, which for an evidence-first record is the
same defect. The arc's closing lesson was stated in one line and generalized
immediately.

**The related discipline.** Evidence is taken at the artifact's own state. Evidence
taken at a neighboring state plus an argument that nothing moved is a claim that
decays unchecked — so where a state moves mid-round, the measurements are re-run
rather than argued forward.

**Without it:** history contains commits that were correct in the author's head and
unverifiable in the repository, and an auditor re-executing evidence at the
recorded state finds failures that are artifacts of the split rather than of the
work.

### 5.7 The author grading its own homework is the root class

**The lesson.** Almost every other failure in this museum is a specialization of
one: somewhere, a party ended up assessing its own work, and the assessment was
structurally incapable of returning "no."

It appears in many disguises, and the disguises are the useful part, because the
obvious form is easy to prevent and the disguised forms are what actually happen.
*Four of the six below are anchored to incidents in this program's record; two
are marked, because an audit of this document could anchor the codification but
not the episode `[P1 · 2026-08-11 · C-125]` — the date being the anchoring
measurement's own, not any one episode's, and the stamp carried none at all until
the census that reads every stamp against its row noticed that this one had
skipped the field its own grammar requires:*

- **The graded party as its own reviewer.** A residual risk routed to "ordinary
  review" where the ordinary reviewer is the party the rule measures.
  `[UNANCHORED · C-24]` — the same episode as §1.4(d), and owed the same anchor
  or removal.
- **The document that reads its own source into compliance.** A checklist quoting a
  constitutional clause accurately and extending it silently — the quotation is
  faithful and the source does not say what the checklist needs it to.
- **The author of an exclusion being the party the exclusion benefits.** An
  equivalence exclusion authored and recorded by the party whose measured yield it
  improved, in that party's own packet, with the independent seat's record never
  updated to carry it. The cure: the exclusion takes effect only when the seat
  whose own count it *shrinks* records it — an admission against interest.
  *(The cure is codified in the constitution; the incident it was codified from
  could not be anchored by the audit of this document. The rule stands on the
  codification; the exhibit is owed.)*
- **The permission slip.** An instrument that authorizes its own author to make the
  change it proposes. The cure is structural: the instrument states the new text,
  and a different seat applies it.
- **The self-inherited signature.** Text that moved after it was signed, carrying
  the old signature forward. The cure is the delta-signature.
- **The measurement that grades the measurer.** A campaign whose subject-under-test
  is the suite, run by the party that wrote the suite.

**The general test to apply to any proposed control:** ask who is made worse off
when the control fires, and whether that party controls whether it fires. If the
answer is the same party, the control does not exist yet, whatever the document
says.

**Without it:** every other guarantee in this document is decorative, because each
of them terminates in some party's assessment of something, and an unexamined
self-assessment is where a green record and a broken one become indistinguishable.

### 5.8 Two smaller ones worth carrying

**A qualification drawn from an author's own practice describes the author.** When
a rule is generalized from the cases its author happens to have met, it fits those
cases and quietly excludes others. The countermeasure used here is to *mark* such a
generalization as the author's own formulation, in the text, so it is attacked
rather than absorbed.

**An absolute prohibition is crossed in a task's opening moves, by habit, before
its text has been read in full.** Prohibitions therefore belong at the top of the
document that carries them, in the imperative, and the enforcement belongs at the
boundary — because the moment of violation is before comprehension, not after.

---

## 6. Adopting this

### 6.0 The export unit — this document plus the shell

**This document is half of an export unit, and it is the half that explains
rather than the half that runs.** The other half is an executable **shell**: the
machinery, extracted project-free into its own repository, which an adopter
clones and starts from.

> **The shell is the repository `generic-agentic-fpga-org`, at
> `github.com/renatom11/generic-agentic-fpga-org`.**
> *(**SUPERSEDED — historical record, not current law:**
> the edition before the fourth promised, in its own opening pages, that the
> shell was "named in §6.0" — and §6.0 named nothing: no repository, no
> location, no identifier of any kind. An adopter handed this document alone
> therefore **stopped at the first minute of the first step of §6.2** and
> reconstructed the entire executable layer from prose instead.)* `[B.8·7]`

**The pin, stated to the limit of what this repository can attest and no
further.** *(No posture row.)* `[B.9·2]`

> **Facsimiles taken at:** this repository, at this edition's own commit — the
> `FACSIMILE` blocks in this document are transcribed from **this program's**
> artifacts, not read from the shell. **Shell observed at:** `main` =
> **`2ad82c3`**, on **2026-08-11**, the state from which this program's
> federation transit branch was cut; that observation is recorded in this
> repository's own transit packet and is checkable from a clone of it.
> **Shell current through:** **unknown from here, by construction.** The shell
> is an independently maintained repository with its own maintainer, its own
> federation law and its own commit count; at the one transit this program has
> performed it was found **thirty-one commits ahead** of this program's picture
> of it. **Fetch before you rely on anything below.**

*Why the pin is worded that way rather than as a tag.* A pin is only worth what
the pinning party measured, and **this party measured its own repository**. The
mechanism-placement rule at the top of this document says the shell is the
normative source of every grammar — but every facsimile here was written from a
local artifact, which means each one is a claim that this program's artifact and
the shell's extracted copy agree, and **nothing has ever checked that**. The
instrument that would is the drift check below, which does not exist. So the
honest form of "pinned" here is: *one dated observation of the shell's head, one
statement of where the facsimiles actually came from, and an explicit refusal to
assert the shell's current contents.* **A pin naming a SHA nobody re-read is a
stronger-looking claim and a weaker one.**

The name is a **program noun**, deliberately, and it is one of the few in §1–§6:
an identifier a reader cannot resolve is worth nothing, and the whole argument
of this section is that half of the unit must be obtainable. A fork replaces
this line with its own (§6.1, the fork contract).

The first edition never mentioned the shell at all. That omission is why its
adoption order could put "turn on the mechanical layer" in a single bullet: with
no reference implementation named, the bullet stands in for building, from
prose, several hundred lines of enforcement script whose value is almost
entirely in the incident-hardened details — the failure modes of a pipeline that
swallows an error, enumeration of a journal chain from committed state rather
than from the working tree, protection of the metadata keys against shadowing —
none of which any prose description will regenerate. **That prediction has now
been tested twice.** The first cold adopter executing §6.2 with this document and
nothing else reported the machinery as *roughly one hundred percent invention*: every script
line, every file format, every identifier scheme, every marker name, the rule
numbering and one enforcement threshold, "constrained but never determined by
never determined by the prose." The second adopter, running against a document
that had since printed the formats, the identifiers, the numbering and the
thresholds, reported the split this bet actually predicts: **the interfaces
transferred and the implementation did not** — some eight hundred and fifty
lines of enforcement script and push-hook logic still written from nothing,
because that world could not reach the shell either (§6.2). The prediction was
in the text before both runs, and both runs returned it.

The unit's contents, and what each is for:

| Kit artifact | What it is | Where its original lives |
|---|---|---|
| **The commit script** | The gate: every numbered rule of §2.6, evaluated against a given seat identity before a commit object exists | this repository, enforcement directory |
| **The history re-check** | The same rules over all pushed history, run by continuous integration | this repository, same directory |
| **The policy module** | The scope table as executable data, plus the journal-path carve-out and the size parameters of **Annex A** | this repository, same directory |
| **The enforcement self-test** | One scenario per rule, each constructing a violation and asserting the refusal names that rule (§2.7) | this repository, same directory |
| **The continuous-integration workflow** | What runs the re-check, on every push, over the whole history | this repository, workflow directory |
| **The constitution template** | §2's rules as a document a program can amend, with the posture declarations already in the clauses | this document's companion constitution |
| **The charter template** | §1.3's fields, one file per seat | this repository, charter directory |
| **The launcher prompts** | The spawn-time text that makes charter-reading and the §4.1 precheck the first acts of every round | this repository, launcher directory |
| **The packet forms** | The taxonomy of §3, as skeletons with their required sections | this repository, packet directory |
| **The sponsor guide** | §4.7's surface, in the sponsor's language, including the spot-check steps and the one-time platform setup | this repository, sponsor file |
| **The chain verifier** | The fifth enforcement script: the whole journal chain walked from a bare checkout with no history — gapless volumes, back-links, digests, contiguous ids — so the property is checkable by a stranger holding only a clone (§2.2) | this repository, enforcement directory |
| **The posture list** | The claim-by-claim measurement every `C-nn` stamp in this document cites: one row per enforcement or event claim, its posture, and the evidence that decided it | this repository, `docs/reports/audit/PROCESS-claims-posture.md` |
| **The anonymized auditor charter** | The one charter whose mechanisms this document leans on and cannot delegate: cadenced duties, the escape ledger, the canary information rule, no direct worker interface, falsifiable evaluation criteria (§1.5) | this repository, charter directory |

*Three rows added in the fourth edition.* The chain verifier and the posture
list were both **absent from a table that claimed to list the unit's contents**
— the first meaning an enforcement reconstruction from this document ships
without the auditor's chain instrument, the second meaning all ~135 stamps cited
an artifact with no path, which under §3.1's own evidence rule made the
document's entire evidentiary spine testimony for its declared audience.
`[B.8·8]`

**What this table asserts, and what it does not.** Every artifact above **exists,
in its original form, in the repository that paid for it** — that is checkable
from a clone. The shell is their extracted, project-free copy in a separate
repository, and **its contents are not verifiable from here**: an adopter reading
this document should treat the shell as named, not as inspected, until they have
looked at it.

**How the export actually moves, which this document did not describe.**
`[B.8·5]` **SUPERSEDED — historical record, not current law:** the edition
before the fourth said the shell was *"kept deliberately frozen except for one
commit per lessons harvest."* That was never a property of the shell; it was a
rule this program wrote for **its own writes into** the shell. The shell is an
independently maintained repository with its own maintainer and its own law,
and at the first transit it was found **thirty-one commits ahead** of this
program's picture of it. What actually happens:

1. The origin program collates a harvest (§3.10) and freezes it as an **export
   packet** in its own outbox — a versioned file, in the origin's repository,
   under the origin's rules, with its provenance citations bound to a stated
   base.
2. The packet is delivered to the shell as an **inbox pull request** — one
   branch, one file, byte-identical to the outbox copy — which is a *proposal*,
   not a landing. It carries no commit to the shell's own corpus.
3. The shell's maintainer screens it under the shell's **federation law**, maps
   identifiers into the shell's own scheme, and lands whatever conforms, in
   commits that are the shell's, counted at the shell.
4. **There is no privileged lane for the origin.** The program that seeded the
   shell enters by the same inbox as any other program, and the sponsor's
   candidate-by-candidate refusal (§3.10, §4.7) is exercisable precisely because
   the delivery is a proposal a human can decline item by item.

*Why the correction matters more than the mechanism.* An adopter told the shell
is frozen will treat it as a fixed artifact and will not look for its law; an
adopter told the truth builds the fetch-first habit that caught the drift here.
And note what the record was doing while the document said "frozen": it had
already built a working transfer pipeline between organizations — outbox packet,
inbox proposal, no origin privilege — **invisible in the chapter about
exporting**. The document believed it was the primary artifact with an
executable appendix. The record shows it is the rationale half of a
shell-primary unit, and it fails exactly where it impersonates the machine half.

**The instrument that binds the two halves, named and owed.** A **doc–shell
drift check**: a test that this document's §2.6 rule table — ids, functions and
enforcing surfaces — agrees with the shell's actual rule set, failing loudly when
either moves. `[PLANNED — no posture row; the instrument does not exist]`

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

### 6.1 What transfers, and what has to be re-earned

**Transfers directly** — *subject, throughout, to the substrate parameters of
Annex A, which is where this list would otherwise overstate itself: the
sole-spawner monopoly is a substrate fact in A.1 and becomes a policy needing
new mechanism if yours differs, and three of the six escalation classes have
never fired here (§4.6)*: the seat topology and the two monopolies; the write-scope
table; the commit rules and the coupling of work to reasoning; append-only journals
with chained volumes; the packet forms and the work-order state machine; the
countersignature discipline; the decision-record and amendment route; gates as
signed, diffable checklists; sealed predictions; seeded-defect campaigns; **the
external anchoring of any model that grades** (§1.4(e)); the escalation classes;
and the harvest cadence.

**Has to be re-earned:** the judgment about which rules in a given program need to
be machine-enforced, which are review-enforced, and which should not exist. That
judgment came from incidents. An adopter who imports the whole rule set on faith
gets the ceremony without the calibration, and the first schedule crunch removes
the wrong half.

**The one thing that must not be imported as a claim** is stated at the top of
this document, in the imperative, where a prohibition belongs (§5.8): any
statement here that a control is mechanically enforced is a measurement of
someone else's machinery. `[P1 · 2026-08-11 · C-126]`

*And here is what executing that instruction actually returns*, since this
program executed it against itself for the first time in the round that produced
this edition: of 127 claims carrying a posture, **15 were false and 8 were owed**.
Not one of the false ones was a judgement call — every one was refuted by a file
the reader could open. Two lessons for an adopter, in the order they will need
them. The first is that **a document's false claims cluster where it describes
artifacts, not where it describes scripts**: this document's most accurate
section is the one about the enforcement machinery, and its least accurate was
the one about packets, gates and campaigns, because scripts refuse and artifacts
merely testify. The second is that the cost of finding all fifteen was **one
seat, one round**, against a record that made every claim checkable — which is
the return on the traceability property, collected in a single payment.

**The fork contract — what a fork does with every mark on this page.** This
document's central imperative — *do not import any statement that a control is
mechanically enforced* — had no companion telling a forker what to do with the
~135 stamps that carry exactly such statements. `[B.8·23]` Every stamp, margin
and annex on this page
is a measurement of **this** program, and each becomes false-by-inheritance the
moment a fork's machinery diverges — which is on the fork's first commit. So the
fork operation is defined, per mark, and it is one of exactly two acts:

| Mark | What a fork does |
|---|---|
| `[MC · C-nn]`, `[RE · C-nn]` | **Re-anchor or strip.** Trace the claim to a refusal in *your* machinery (§6.2 Step 0). Traced → re-stamp against **your** posture list's row. Not traced → re-stamp `[RE]` or `[PLANNED]`, whichever is true of you. Never carry a `C-nn` row number: it indexes a file you do not have. |
| `[P1 · date · C-nn]` | **Strip.** A performed, dated event of another organization is not a fact about yours. Where the event is one you also intend to perform, it becomes an item in your own gate record, not a stamp here. |
| `[CORRECTED · C-nn]` and its margin | **Strip, or keep as history and say so.** These narrate an edition you never held. Keeping them is legitimate — the corrections are often the lesson — but only under a heading that says *this is the exporting program's revision history*, so a retrieval-fed reader cannot pattern-match a superseded claim as a current one. |
| `[UNANCHORED · C-nn]` | **Strip with its exhibit**, unless you can anchor it in *your* record. An exhibit nobody can locate in the forking program's history is not evidence anywhere. |
| `FACSIMILE` blocks | **Replace with your own, or delete.** A facsimile is an instance of another program's artifacts; keeping it while your shapes differ manufactures exactly the drift the label warns about. |
| **Annex B** | **Delete whole and start your own.** It is program-local by construction, and its debts are not yours. Its *shape* — dated conditions with owners, owed confirmations, routed-not-performed items, instruments named and not in force — is the part to copy. |
| **Annex C** | **Delete whole and write your own**, as the first act of Step 0. It maps this document's function names onto **this** program's seats, paths and tokens; yours are different, and a trace run against an inherited map traces nothing. Its *shape* — seats, artifacts, packet tokens, and the vocabulary you chose not to align — is the part to copy, and writing it is how you discover which of your own names disagree. |
| The edition anchor | **Replace**, with your own edition, date and commit. |

**The rule under the table**: *a fork inherits the rules and the reasons, and
inherits no measurement.* Stripping is always safe and re-anchoring is always
work; a fork that does neither ships a document whose evidence apparatus points
at a repository its readers cannot open — which is the defect this edition spent
three of its own repairs removing.

### 6.2 The order that works

A load-ordered checklist, each step keyed to the kit artifact that performs it
(§6.0). The order is not a preference: each step's failure is unrecoverable once
the following steps have run on top of it.

**This order has been executed twice, both times by somebody who did not write
it.** `[P1 · 2026-08-11/12 and 2026-08-12 — no posture row; both performed after
the measurement]` A cold adopter is handed this document alone, in an empty
repository, and told to run §6.2 literally and to log a halt at every point
where the text under-determines, contradicts itself, or fails against the
platform. Both halt logs are committed artifacts of this program.

| Run | Executed against | Halts | STOPPED | Log |
|---|---|---|---|---|
| **one** | the second edition's order | 18 | **3** | `docs/reports/process-council/round-2/adoption-run-halt-log.md` |
| **two** | the fourth edition's restructured order, acts 1a–1d | 17 | **0** | `docs/reports/process-council/round-3/adoption-run-2-halt-log.md` |

**Read the stop column, not the halt column.** The raw count barely moved; the
composition changed completely. Run one's stops were world-reconstruction
failures — no shell named, no rule numbers printed, no threshold stated — and
run two had none of them: **every grammar, identifier, threshold and rule number
transferred as a facsimile, where run one had reported "roughly one hundred
percent invention."** What run two still invented was the executable layer's
*logic*, some eight hundred and fifty lines of enforcement script and one push
hook, because its world could not reach the shell. **The unit's own bet — ship
the reasons here, ship the machine in the shell — is therefore half-vindicated
and half-untested**: the reasons half now transfers, and nothing about the
machine half was verifiable from that world. `[B.10·6]`

*Two things this pair does not license anyone to say.* Neither run closed the
replication claim: **run two proceeded by improvisation seventeen times**, and
five of the seventeen are order defects rather than substrate facts — the
founding range, the committing seat's roster row that no act activates, the
program-state file no step schedules, the roster-column mismatch between act 1a
and §1.6's facsimile, and the undefined bootstrap range at Step 5. And a run
that reaches deeper finds new halts: several of run two's are new *only* because
it got far enough to touch machinery run one never reached — the amendment
procedure live-fired, the gate signature mechanics, a push hook's environment.
**A falling stop count over a flat halt count is a document that has stopped
being unexecutable and has not yet become determinate.**

**What the order costs, budgeted from the two runs rather than from optimism.**
An adopter should plan for three things this edition names as steps rather than
as accidents. **Most of a day** for the executable layer, if they have no shell.
**About an hour each** for the five order defects above, which should be zero and
are not. And — the line no previous edition budgeted — **one live-fire failure of
the adopter's own machinery.** Run two's first push through its own
just-committed hook failed outright: the hook ran with a relative repository path
and quarantined object directories, so the adjudicator was blind at its first
contact with real traffic. **Repairing enforcement machinery mid-adoption is not
a hiccup, it is an amendment**, and its route is the procedure you author at act
1d and bind at Step 4 — a sandbox proof taken *outside* the repository, a
numbered decision record, and a separate accepting commit by the seat that owns
the file. Budget it as a step. An order that treats its own first failure as an
accident invites the adopter to bypass the gate they have just installed, on the
day they are least able to judge whether that is safe. *(HALT-12. `[B.10·14]`)*

**Step 0 — verify the reference implementation's claims against its own
machinery.** Before adopting anything, take this document's mechanically-enforced
claims and check them in the shell (§6.0 names it): for each `[MC]` stamp,
find the refusal, and for each numbered rule, find the self-test case that
constructs a violation of it. Anything you cannot find is `[RE]` in your hands
whatever it is stamped here, and belongs in your own residue list. *This step
exists because the program that wrote this document had never performed it, and
performing it returned fifteen false claims. You are inheriting a corrected
document; you are not inheriting the correction of your own copy.*
→ *kit: the self-test, the commit script, the policy module, the posture list.*
*(HALT-01: the first execution of this step stopped here — nothing in the
previous edition named the shell, so nought of thirty-four stamps was traceable
and nought self-test cases were findable. The step's own fallback sentence was
then executed, which is the one thing about the run that went right.)*

**Step 1 — derive the roster, turn on the mechanical layer, seat the
organization, and author the constitution — in four ordered acts, before the
first commit you intend to keep.** *(Restructured in the fourth edition: the
order before it began at act **1b** and so consumed two artifacts no step
produced — the scope table needs a roster nobody had derived, and Steps 4 and 5
quote a constitution nobody had authored.)* `[B.9·4]`

- **1a — Derive the roster, and write it down first.** Decide the seats by
  function (§1.2) and land the **roster file**: one row per seat with its
  function, tier, charter path, journal path, the scope it will hold, and a
  **Status** column (§1.6's facsimile). Nothing later in this order is writable
  without it — **the scope table is the roster's scope column made
  executable**, the launcher set is one file per row, and the founding gate's
  signature rows are addressed to its seats. A row here is a **plan**, not a
  seat: its Status stays *planned* until 1b or 1c makes it real, which is what
  keeps a roster row from being the scope-row-without-a-charter that §1.2
  forbids.
- **1b — Land the machinery, and with it the one seat that cannot be onboarded
  under it.** Coupling, append-only with the chain, path isolation, files-list
  equality, monotonic ids, trailer protection, the large-file gate, and the
  full-history re-check — with the policy module carrying **exactly one scope
  row**, the committing seat's, because that seat is the one whose first commit
  cannot be gated by a gate it is installing. In the same act, that seat's four
  things land together (§1.2): charter, its scope row, launcher text, seeded
  empty log. **Acts 1a and 1b together are the named, minimal founding range**
  of the bullet below.
- **1c — Onboard every remaining seat, one act per seat, under the gate.** For
  each: charter draft, its scope row added to the policy module, launcher text,
  and its seeded empty log (the foreign-journal seeding rule exists for exactly
  this), landing **together**, with the roster row flipped *planned → active*
  in the same commit. Every one of these commits passes the layer 1b installed.
  Split them and §1.2's four intermediate defects are yours in turn; the
  charters are **drafts** here, and Step 2 is what attacks them.
- **1d — Author the constitution, from the machinery rather than from
  intention.** The rules you just turned on, written as a document a program can
  amend — each clause carrying its own posture declaration (§5.5), the scope
  table restated as its canonical statement (§2.7), and the numbered rule set
  printed. Write it by reading what your scripts actually refuse, not by
  transcribing this document: **a constitution written from a description is a
  second copy that drifts from the machine on its first amendment.** This act
  exists because Step 4's amendment binding and Step 5's checklist both quote
  constitutional clauses verbatim, and until this edition no step produced one.
→ *kit: the commit script, the history re-check, the policy module, the workflow,
the chain verifier, the charter template, the launcher prompts, the constitution
template.*

*Two things this step has to say out loud, both learned by watching it fail.*

- **This was Step 2 in the previous edition, and Step 1 was the adversarial
  review.** That order contradicted §1.7, contradicted this program's own
  founding record, and — when executed literally — manufactured exactly the
  ungated early history both of them warn about: the review landed in four
  commits made before the layer existed, and the full-history re-check then
  convicted all four. The adopter's cure was a recorded baseline exempting the
  founding range, *which is the very thing §1.7 act 1 exists to prevent.* The
  order is now machinery-first, so that no literal executor needs that
  improvisation. *(HALT-05; council verdict Tier 2 — Annex B.8.)*
- **The commit that introduces the gate cannot pass the gate**, because no
  journal exists yet for it to couple to. This is not a defect, it is the
  bootstrap paradox arriving at commit granularity, and it has one honest
  handling: land the machinery in a **named, minimal founding range**, declare
  that range self-signed in your founding gate (§1.7 act 1), and have the
  retro-audit of Step 5 examine it specifically.

  **And here is the mechanism, which the previous edition owed and did not
  give.** It said only what you may **not** do — exempt the range quietly — while
  prescribing nothing that is not a recorded baseline, which is the thing it
  brands forbidden. Adoption run two met that gap and built the missing piece;
  this edition adopts its form, credited to the run. **A committed founding
  declaration**: one file, in the repository, carrying the range's commit count
  as data; **read by the re-check from committed state**, never from a flag, an
  environment variable or an argument the pusher supplies; **announced in a
  banner on every run of the re-check**, in the re-check's own output, saying in
  words that this is a declaration and not a quiet exemption; **quoted verbatim
  in the founding gate's own row**; and **examined by name in the Step 5
  retro-audit**, which states how many commits it found outside the gate and
  whether that number matches. That is still a recorded baseline, and the
  distinction the previous edition could not state is now stateable: **a baseline
  is quiet when only the tool that reads it knows it exists, and loud when the
  gate record, the audit and every run of the re-check say so.** If you build a
  different resolution, the property to preserve is that one: the exemption's
  existence, size and boundary are all readable from artifacts a stranger opens,
  not from the tool's behaviour. *(HALT-05's sub-problem, and HALT-06 of run two,
  whose invention this is —
  `docs/reports/process-council/round-3/adoption-run-2-halt-log.md`.
  `[B.10·13]`)*

**Step 2 — launder the roles through adversarial review, into the now-gated
repository.** Attack **the charter drafts of act 1c and the constitution of act
1d** — that is what this step consumes, and until this edition no step produced
either — from at least three lenses: role coherence, enforceability, and
readability by the non-specialist who will sponsor it. Dispose of every finding
in a committed artifact. §1.7 act 2 is the sequence this belongs to; §1.3
carries the caveat and the nine sections a charter must have, and now the step is
satisfiable rather than paradoxical: run the review **into the repository**,
whose machinery is on as of act 1b, so its evidence survives *and* is gated.
→ *kit: the charter template, the anonymized auditor charter.*
*(HALT-04: a solo adopter has one actor, so three independent reviewers is
structurally unachievable and the review is §1.4(a)'s forbidden self-review by
construction. What that adopter did is the right shape and worth copying: write
all three lens reviews, **declare the non-independence inside the review
artifact itself**, file it as a critical finding against your own founding, and
carry it into the retro-audit. The findings are real even when the independence
is not — and a declared fiction is a debt; an undeclared one is a lie.)*

**Step 3 — configure the out-of-repository dependency and verify it by live
fire — after your continuous integration has run green at least once.** Branch
protection on every protected branch, with an **empty bypass list** so that the
account your own automation pushes with cannot override it, and then an
attempted violation that actually bounces, cited by identifier in the gate
record. An unverified protective setting is a belief. *This program did this, on
both branches, on its first day, and had it re-proved in anger later when a
forced push on a working reference was refused mid-incident — the two best
pieces of evidence it owns for the guarantee the whole append-only design rests
on.* `[P1 · 2026-08-01 · C-128]`
→ *kit: the sponsor guide.*

*Two platform facts this program's own founding record carries and the previous
edition dropped, both of which make this step executable or not (Annex A.5).*
**Use rulesets rather than classic branch protection**, because an empty bypass
list makes a ruleset admin-proof by default. And **the required-status-check half
cannot be configured before the check has run once** — the platform's picker
lists only checks it has seen, so a sponsor following the old order arrived at
an empty picker with no explanation. That is why this step now sits after the
layer and its workflow exist. *(Council verdict Tier 2; the ordering constraint
is recorded in this program's own founding checklist and was lost in export.)*

**Step 4 — run the enforcement self-test green, and bind it to the amendment
procedure**: every amendment that changes enforcement semantics adds a case
(§2.7). A rule whose test case cannot be written has a predicate nobody has
pinned down. The amendment procedure this binds to is a clause of **your own
constitution, authored at act 1d** — the kit's template is what you wrote it
from, not what you bind to.
→ *kit: the self-test (the constitution template was consumed at act 1d).*
*(HALT-10 and HALT-11, and both are worth knowing before you start. This step is
unexecutable until your rules have **numbers** — §2.6 now prints this program's,
as a facsimile. And one rule will resist the self-test's own form: the branch
limb of `R9` has no script whose refusal could name it, so no violating
construction exists. Do not invent an instrument to satisfy the count. Record
that case as discharged by Step 3's live-fire bounce instead, and say so in the
suite. Expect also that one construction is intercepted by a different rule
before the rule under test can fire — which is not a bug in the suite but the
suite discovering, correctly, that the rule's real invariant is narrower than
its name.)*

**Step 5 — instantiate the gate that closes the founding**, including the
retro-audit of the whole bootstrap range by a seat that did not exist during it,
with its own weakness declared, and the sponsor's ratification row. Do not issue
the first real work order until every row is signed (§1.7 acts 3 and 4). The
checklist quotes its conditions **verbatim from the constitution act 1d
produced** (§3.7) — which is the second place the previous order sent a reader to
a source no step had written.
→ *kit: the packet forms, the gate-checklist facsimile at §3.7.*

*What a solo adopter can and cannot do here, stated because leaving it silent
makes the definition of done unsatisfiable in a way nobody warns them about.*
Two acts in this step **cannot be performed from inside**: ratification, which
§1.7 says exists precisely because an organization cannot vote itself legitimate,
and the retro-audit's independence, which needs a seat that did not witness the
range. A solo cold boot has neither.

> **The honest result, and it is a result rather than a failure:** found the
> organization **self-signed**, with the ratification and independence rows left
> **open** in the gate record and the limitation declared in the gate file
> itself. The gate stays open; by §1.7 the first real work order does not issue
> until an external party closes those rows. **Do not self-sign as the
> sponsor** — that is §5.7's permission slip wearing a gate's clothes, and §1.7
> forecloses it in terms. Do not stage a fictional independent seat either;
> perform the audit in persona if you must, and have it declare in its own text
> that its author witnessed everything it audits. *The findings are then
> checkable by a stranger even though the independence is fiction — and the
> fiction is written down.*

*(HALT-14 and HALT-15: the adopter refused both evasions and recorded the
refusal in a decision record, which is what §4.8 asks of any seat that cannot
perform what it was commissioned to. HALT-16 follows from it: the first work
order never issued, because the gate never closed. That is the design working.)*

**Step 6 — only then start the work**, and start the harvest cadence with it
rather than after it — with the harvest's destination decided on day one (§3.10),
even if that destination is one file in your own repository.

**The definition of done for an adoption**, so that "we adopted it" is a
falsifiable claim rather than a feeling:

- [ ] The self-test **runs green from a clean clone**, and carries **at least one
      case per numbered rule**, verified by reading the suite against your rule
      table — plus one case per semantic amendment since.
      *(**SUPERSEDED — historical record, not current law:** the previous
      edition asked that the case count **equal** the number of numbered rules
      plus amendments. That equation is uncomputable and was dropped: rows are not
      rules — this program's thirteen rows carry eleven numbers — and cases are
      not rows, since one rule can need several constructions and one rule can
      admit none at all. **A falsifiability instrument that cannot be evaluated
      is worse than none**, because it is checked off anyway. Source: council
      verdict Tier 2; HALT-10.)*
- [ ] Every `[MC]` claim in **your** copy of this document has been traced to a
      refusal in **your** machinery, and every one that could not be traced has
      been re-stamped `[RE]` or `[PLANNED]` in your copy. Step 0, recorded.
      *(A trace table beside the document, rather than stamp-by-stamp edits
      inside it, is a form deviation and an acceptable one — say which you did.
      Expect the trace to find defects in **your own** machinery as well as
      untraceable claims in this one; the first adopter's did, and left the gap
      open and declared rather than silently patched.)*
- [ ] The platform dependency has bounced a real attempted violation, and the
      bounce is cited in your founding gate record.
- [ ] The bootstrap range has been retro-audited by a seat that did not write it,
      the audit returned findings, and any critical finding blocked the gate
      until dispositioned and re-verified. *(Or: the independence is declared
      unachievable in your environment, the audit is performed with its own
      weakness in its text, and this row stays **open**. An open row is a true
      row.)*
- [ ] Your residue list exists as a file: every control you have that is
      review-enforced, named, with the seat it is routed to — and a cadence for
      each, because §1.1's residue note is the failure that eats the rest.

**FACSIMILE — instance, not norm.** A residue row, because the checkbox above
demands a file the previous edition never gave a shape to, and demands a routing
field that presupposes seats Step 2 has not yet created. Open the file at Step 0
with the routing columns empty, and fill them at Step 2 — the file exists from
the first act, which is the point. *(HALT-02.)*

```
| Id | Control (review-enforced) | Why no instrument | Routed to | Cadence | Closing event |
|----|---------------------------|-------------------|-----------|---------|---------------|
| B.1| <the control, in one line>| <semantic? no substrate?> | <seat>  | <interval> | <what would make it machine-checked> |
```

*The cadence column is the one that matters and the one an adopter will leave
blank.* A residue routed to a seat with no interval attached is routed to
nobody — §1.1's own lesson, and this program's six owed postures are what it
costs.

### 6.3 The failure of exporting rules alone

This document exists because rule sets extracted from working programs do not
transplant. The rules survive the move; the reasons do not. What arrives at the new
program is a list of obligations of no evident purpose, which reads as ceremony —
and the parts that look most like ceremony are, reliably, the parts that were
purchased at the highest price: the append-only constraint, the files-list equality
check, the sealed prediction, the countersignature from the party who would rather
not sign.

So the failure classes above are not commentary on the rules. They **are** the
export. A rule whose failure class you can state is a rule you can adapt, defend,
and enforce. A rule whose failure class you cannot state is one you will drop, and
you will drop it in the round where it would have mattered.

*And the counterweight this program's own history supplies, because the sentence
above is too comfortable on its own.* It took the seats that had the reasons
firsthand — who lived every incident in the museum — twenty-one numbered decision
records, a self-test grown to fifty-one cases, and repeated
green-locally-red-in-the-re-check incidents to get from those reasons to working
mechanisms. **Reasons did not regenerate
mechanisms even for the people who owned them.** That is the argument for §6.0:
the failure classes are why a rule survives contact with a schedule, and the
shell is what stops an adopter re-deriving a commit gate from first principles at
the exact moment they are least able to afford it. Ship both, or the half you
ship will be the half that reads as ceremony.

---

## Annex A: substrate parameters

Every control in this document rests on facts about the runtime it was built for.
They are collected here because a control whose substrate assumption is invisible
is a control an adopter inherits as a guarantee and operates as a hope. **Measure
each of these from your own environment.** Where yours differs, the posture of the
control changes, and this annex says how.

### A.1 — A spawned agent cannot spawn

*Anchor:* a property of the agent runtime
this was built for, not of any rule here. *What rests on it:* the sole-spawner
monopoly (§1.1) is free — nothing needs to enforce it. *If your substrate
differs:* the monopoly becomes a **policy**, its posture drops from substrate-fact
to review-enforced, and you need a different mechanism for the property it was
buying — attribution of who commissioned what. Nothing else in §1.1 changes; that
paragraph is about attribution, not about the tree shape.

### A.2 — One working tree, one index

*Anchor:* the version-control tool, not
this design. *What rests on it:* the commit handoff of §2.1, and both precheck
disciplines of §4.1–§4.2, which exist because two seats cannot safely be mid-edit
in one tree. *If your substrate differs* — per-seat clones or worktrees — the
handoff simplifies and the precheck disciplines become **more** important, not
less, because a stale base is no longer visible as a dirty tree.

### A.3 — The reader's single-file limit, and the thresholds anchored to it

*Anchor:* the maximum bytes the agents' file-reading tool returns in one
call — 256 KiB in this environment. *Derived:* a journal warns at that figure
(262,144 bytes) and refuses at twice it (524,288). The anchor is the rule *one
volume should be one readable unit*; the numbers are consequences. *If your
substrate differs:* recompute both thresholds from your own limit and restate the
anchor in the same act — the whole point of anchoring is that a parameter change
is an edit with its reason attached rather than an argument about taste. *Note the
live residue:* in this program the hard threshold is enforced on the commit
surface only (§2.2, §2.5).

### A.4 — Read access cannot be denied per path

*Anchor:* the agent runtime; no
per-path read denial exists. *What rests on it:* the blinding separation of
§1.4(c) and the seeder allow-list of §3.9 are **review-enforced**, carried by
prompt content, packet content and audit of recorded reading — and the document
says so rather than claiming coverage. *If your substrate can deny reads:* those
two postures move to machine-checked, the compensating audit becomes optional
rather than load-bearing, and you should say so in the clause, because a reader
of an inherited document will otherwise keep operating your stronger control as
if it were the weaker one.

### A.5 — Branch protection semantics

*Anchor:* the hosting platform. What it
buys, exactly: refusal of force pushes and of branch deletion, on named branches,
with an **empty bypass list** so that the privileged account the program itself
pushes with cannot override it. What it does not buy: it does not stop a bad
commit, only a rewrite of history. One asymmetry worth copying: a required
status check makes *direct* pushes impossible on a branch (a new commit cannot
already have a passing check), so the check requirement binds the trunk, while
the working branch is guarded by force-push and deletion blocking plus a
publicly-failing check as the detector. *If your substrate differs:* §2.5's
no-rewrite guarantee drops to **convention**, and the append-only property of
§2.2 — which everything else in §2 rests on — becomes unenforced. Verify it by
live fire (§6.2 step 3) rather than by reading the settings page.

*Two mechanics of the platform this was built for, carried because dropping them
made §6.2 unexecutable in sequence.* **Use the platform's newer *rulesets*
rather than its classic branch-protection form** — on this platform an empty
bypass list makes a ruleset admin-proof by default, which the classic form does
not give you. And **the required-check binding is not configurable until the
check has run at least once**: the picker offers only checks the platform has
already seen, so the setting cannot precede the first green run. That is a
sequencing constraint on the adoption order, not a detail: it is why §6.2's
platform step now follows the machinery step rather than preceding it. *If your
platform differs*, the constraint may not exist — but assume it does until you
have watched the picker, because the failure mode is a sponsor staring at an
empty list with no explanation in the document that sent them there.

### A.6b — There is no reachable hosting platform at all

*Anchor:* your
environment, not this design. *What rests on it:* everything in A.5, plus the
continuous-integration surface of §2.5 and the whole of §6.2 Step 3. *If your
substrate differs this way:* both fall to **convention**, and say so rather than
substituting. A local stand-in — a bare remote with a hook refusing
non-fast-forward pushes and deletions — reproduces the *bounce* and is worth
building for the live-fire evidence, but declare the two material differences:
the empty-bypass-list concept has no analogue, and any actor with filesystem
access can remove the hook. **A guarantee whose enforcement anyone in the room
can delete is convention wearing a refusal's clothes**, and the honest posture
for every claim resting on it drops accordingly. Likewise a re-check run by hand
after each push is not continuous integration: it converts the adjudicator into
the committing seat's self-report, which is the exact failure §2.5 names.
*(From adoption run one's own environment — HALT-08, HALT-09.)* `[B.8·32]`

### A.6 — The only environment that can run the suite runs on pushed references

*Anchor:* this program's toolchain decision, recorded in its own decision record;
a local run is impossible. *What rests on it:* the campaign model of §3.9 — marked
references, pushed, never merged — rather than the transient apply-and-revert
model, which is what the constitution originally described and what the first
edition of this document repeated. *If your substrate differs* and you can run the
suite locally, take the transient model: it is strictly better, because the
never-merged property stops being a measured fact someone has to keep measuring.

### A.7 — The large-file threshold

*Anchor:* what your version-control host and your reviewers can carry; in this
program, **1,000,000 bytes** per staged file, with every journal path carved
out. *Derived:* nothing — unlike A.3's journal thresholds, this one is a policy
choice rather than a consequence, which is exactly why it has to be **stated**
rather than described. *What rests on it:* `R11` of §2.6, on both surfaces. *If
your substrate differs:* pick your number and state it in the same act.
*(**SUPERSEDED — historical record, not current law:** the row before the
fourth edition's called the threshold "stated" without stating it anywhere, and
an adopter executing from the text invented one.)* **A parameter a document
calls stated and does not state is worse than an unstated one**: the reader
stops looking. `[B.8·14]`

### A.8 — Capability tiers of the agents themselves

*Anchor:* the model
family available to you, and its price. In this program every long-lived seat
that reviews, adjudicates, grades or audits runs on the stronger reasoning tier
(`opus`-class), and every short-lived, packet-scoped worker on the cheaper one
(`sonnet`-class); the assignment is declared per seat in the launcher
definitions and nowhere else. *What rests on it:* the invariant of §1.2 — **the
reviewing tier is at least the producing tier** — which is what stops a review
from being a formality that cannot see the defect it was convened for. *If your
substrate differs:* the invariant is the part that transfers, not the tier
names. Two consequences to price on day one: the review line is the expensive
line, so a schedule crunch will attack exactly the seats the invariant protects;
and a seat's tier bounds what one round of it can hold, which is a second
parameter worth measuring beside A.3's file limit. `[B.8·18]`

### A.9 — Two parameters this program does not have, re-labelled not invented

*Anchor:* neither is a substrate fact; both are policy choices this
program's own text called *stated* or *literal* while stating nothing. They are
collected here in the annex's idiom because the alternative — writing a number
into a running line to close a finding — would be this document inventing a
practice and then describing it, which is the class the whole edition exists to
remove. *(The other two of the four are stated in the text, at §3 and §3.2,
because the record had them.)* `[B.9·5]`

- **A.9(a) — The draft-identifier placeholder token.** *What rests on it:*
  §3's greppability property — that an unallocated identifier can be found by
  search before the sole committer allocates the real one. *What this program
  has:* no token. Its practice is the next free number per prefix, measured at
  a stated commit and declared provisional in the drafting seat's own entry —
  disciplined, and lexically indistinguishable from an allocated id, so the
  greppability the property claims does not exist here. *Choose yours, and the
  requirement is the transferable part:* a **fixed literal**, **impossible as an
  allocated id** (so that a forgotten placeholder is a search hit and not a
  plausible number), carried **in the filename** and not only in prose.
- **A.9(b) — The E6 escalation threshold.** *What rests on it:* the sixth
  escalation class of §4.6 — the only class with a quantity in it. *What this
  program has:* one figure, in its constitution, introduced by *for example* —
  a phase tracking past twice its estimate — and **zero firings**, so the figure
  has never been tested against an actual overrun. *Choose yours*, from your own
  cost structure, and write it down **before your first anomaly**: a threshold
  set while looking at the overrun is set by the party the escalation would
  embarrass (§5.7's general test).

---

## Annex B: what this edition owes, and when

*Program nouns appear in this annex, and several of them appear before **Annex
C** defines them — seat names, entry ids, decision-record ids, the constitution's
own filename. That is deliberate and it is the boundary: **§1–§6 speak in
function names and this annex names this program's own artifacts.** Annex C is
the map; a name here that you cannot resolve is resolved there.*

*This annex is **program-local**. An adopter forking this document deletes it and
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

**B.0.3 — the dated condition this edition carries forward.** *This edition was
written single-seat, by the sponsor's own direction, with no council preceding
it. That is a fact about it and not a defence of it: **the seat that chose the
repairs is the seat that judged whether they were the right repairs**, which is
§5.7's root class at the document level, disclosed rather than removed.*

| # | Condition | Owner (performs) | Commissioner | Due | Status |
|---|---|---|---|---|---|
| **B.0.3** | **Council rounds four and five audit this edition under the full process** — specifically: whether the dedupe removed anything load-bearing; whether the demoted provenance is fully recoverable from the annex rows the pointers name; whether the seam column measures what it claims; and whether the sentinel census is complete. | a council — independent reviewers, none of whom wrote this | the sponsor, relayed by the orchestrator, on this edition's landing **2026-08-12** | **before any sixth edition is drafted**, and before this edition's conciseness or readability is asserted anywhere | **OPEN — CONDITION** |

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
| **The whole text, read cold — one row per edition, standing** | **a reader with no session context, no participation in any round, and access to this document only** | that the terms it uses are inferable from the text, that its sections are reachable from its contents, that a first reader can follow it without the edition it corrects, and that a stranger can locate every artifact it cites | **edition 2: NOT RUN** — the confirmation matrix carried auditor, verification-lead and orchestrator rows and no cold reader, and the four dialect terms of *The dialect*, the unnamed shell and the unlocated posture list are what that omission cost. **edition 3: NOT RUN** — skipped a second consecutive time; the round-3 council's cold- and hostile-lensed readers independently returned the cold-open failure, the six-entry contents and the absent reading paths, which the chair recorded as *what this row would have returned*. **edition 4: RUN, and run twice** — two independent cold readers, reports at `round-3/cold-reader-A.md` and `…/cold-reader-B.md`, grades and consequences at **B.0.1**. Three consecutive editions carried this row unrun; the fourth is the first that paid it. **edition 5: owed, and scheduled** at **B.0.3** |
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
   auditor's scope. Named, not performed.
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
   list measured 1,445 lines; the document is now nearly three times that, and the
   preamble says so in terms. The re-measurement — new rows for every claim
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


