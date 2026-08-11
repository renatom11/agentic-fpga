# PROCESS — how this organization works

A reference for the way a program is run here: the seats, the rules they work
under, the artifacts they produce, the disciplines they keep, and the failures
each of those exists to prevent.

---

## Read this first

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

Three properties of the stamps, so they are not over-read:

- **A stamp is a measurement at one commit, not a promise.** `[MC]` says a
  refusal exists today in the machinery that was audited. Your machinery is not
  this machinery — see the warning above.
- **`[P1]` is not `[RE]`.** A performed event is not a practice. Where the first
  edition wrote a single dated event in the present indicative, this edition
  writes the event with its date and, separately, whether anything obliges the
  next one.
- **Failure-class prose is not stamped.** The italic *Failure class* passages
  assert nothing about this program's controls — they generalize an incident —
  so they were outside the audit's frame and are outside the stamping. This is
  deliberate and is the one place a reader will see unstamped normative-sounding
  text.

### The dialect

Five terms were absorbed into this program's speech and used here without
definition until a cold reader proved they could not be inferred. They are:

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

---

## How to read this

Every mechanism below is stated twice: **what the rule is**, and **the class of
failure it exists to prevent**. The second half is the load-bearing one.

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
- [Annex B: what this edition owes](#annex-b-what-this-edition-owes)

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

*Margin note — what the first edition claimed here.* It stated the second
monopoly as an unqualified fact of the record `[CORRECTED · C-07]`. The record
contradicts it. The rule became standing only late in the program, after an
episode in which the auditor — the one seat whose whole value is that it does not
touch what it grades — cut, committed and pushed five transient references on the
orchestrator's own dispatch, plus three earlier deviations of the same shape. The
instrument that codifies the rule is, at this writing, still *proposed*. So the
honest statement is: **the committing monopoly is a rule the seats keep, not a
property the machinery holds** — it has been broken, on instruction, by the seat
least able to afford it, and the repair was to write the rule down rather than to
build a check that could not exist. What the machinery does hold is narrower and
real: no seat can commit *outside its write scope* (§2.3), whoever runs the tool.

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
allocation under one authority `[RE · C-08]`. History is serialized on one
branch, so there is a single order of events `[MC · C-09]`.

*Margin note.* The first edition said the numbering was "monotonic by
construction rather than by convention" `[CORRECTED · C-08]`. It is not.
Single-authority allocation makes numbering *administrable*, not monotonic: the
record contains letter-suffixed identifiers outside the numbering scheme, and
four identifiers that are live in reasoning logs and program state with no packet
file ever committed. Construction required improvisation in both directions.
**The generalizable form: centralizing an allocator removes the race, not the
discipline.** A single allocator still needs a rule about what to do when a unit
of work needs an identifier before it needs a packet — and if that rule is absent,
the allocator invents one per incident, which is the convention the sentence
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
applied to the compensating control itself, and it is the single fact underneath
six of the eight owed postures in this edition (§4.3, §1.4(c), §2.1, §2.3, §3.1,
and this row). An adopter should read it as: *if you route a residue to your
auditor, put the routing on a cadence something else enforces, or you have routed
it to nobody.*

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
and what carries it instead.

**Workers.** Spawned per packet, given exactly the context that packet carries,
returning exactly what it asks for. They share a journal template per **role**,
with each spawn identified by a token minted into its prompt. The journal's
identity is the role, not the spawn — which is what reconciles a shared log with
the rule that no agent writes another agent's journal (§2.2): successive spawns
of one role are one journal identity, and the minted token is what preserves
attribution inside it.

**The auditor.** Independent. Audits every seat including the orchestrator.
Writes only its own reports `[MC · C-15]`. Cannot fix what it finds; its verdicts
reach the sponsor unedited `[RE · C-16]`. It is also the seat that authors the
defect manifests of §3.9 — see §1.5, which explains why that is the same duty and
not an extra one.

*A precision the first edition got wrong by one.* It said the auditor writes to
**one** directory. It is two: its report directory, and its own reasoning log —
which every commit it makes must append to, by the coupling rule of §2.1, and
which is carved out of the scope check for exactly that reason. The general
form matters more than the correction: **a write-scope statement that forgets the
journal carve-out describes a seat that cannot legally commit anything.**

**The failure class the fixed roster prevents.** Role drift, where a seat under
schedule pressure absorbs an adjacent duty because it is faster to do it than to
route it — and the absorbed duty is almost always a check on the absorbing seat.
Roles that are written down, versioned, and cited in the work can be audited for
drift; roles that are understood cannot.

### 1.3 Charters — a role is a document, not an understanding

Each seat has a **charter**: a versioned file stating its identity, its mission,
its responsibilities, its interfaces with every other seat (what it receives, what
it delivers), its inputs and outputs, its definition of done, the criteria by
which it will be evaluated, its escalation rules, and its write scope. An agent's
first mandatory action on every spawn is to read its own charter and the shared
rules `[RE · C-17]` — the obligation is written into every launcher prompt, and
nothing verifies that the read occurred except the *Inputs* section of the
resulting reasoning log, whose sampling is itself owed (§1.4(c)).

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

### 1.4 Separation of duties — four separations, each drawn against a specific temptation

*(The first edition's header said "three lines" over a list of four. It was a
count of the organization's three working lines — specifying, building,
verifying — sitting over a list of four separations, only two of which are drawn
between those lines. Four is the count that matches the list.)*

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
through it** — which is §5.7, committed at the document level.

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

*Two corrections this clause owes its own standard.* It is **not the only**
unenforceable read restriction — a consult-only licensing boundary in the same
constitution has identical non-enforceability, and a rule that calls itself
unique invites an adopter to assume every other read restriction is covered. And
the third compensating leg — the audit of recorded reading — **has never run over
the build phase**. Two of the three things this clause says it can check are
checked by nobody. That is the honest posture, and it is why the leg is stamped
owed rather than described in the present tense: the instrument is a sampling
round on the reasoning logs' *Inputs* sections, it exists in a charter, and it
has been performed once, at ratification.

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
Neither could this revision. Under this program's own evidence rule (§3.1), a
claim whose support cannot be re-executed may not be stated as fact — so the
pattern is kept, marked, and owed either an anchor or its removal (**Annex B**).
It is retained rather than deleted because the *rule* it illustrates, (d), is
independently anchored: the same shape is codified in the constitution and
recurs as the first disguise in §5.7. **An unanchored exhibit is a different
defect from an unanchored rule, and collapsing the two is how good rules get
deleted with their bad exhibits.**

### 1.5 The auditor is a different kind of seat

The auditor is not a stricter reviewer. It is structurally distinct in four ways,
each of which is a control:

1. **It can write only its own reports.** Not the specifications it audits, not
   the tests, not the artifacts, not even the shared task packets. This is
   enforced mechanically `[MC · C-25]` — of every "enforced mechanically" claim
   in the first edition, this is the one that survived its own §6.1 test with no
   qualification at all.
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

**The failure class.** An auditor with edit rights on what it audits produces an
unfalsifiable record: after the fact, no reader can distinguish "this was always
compliant" from "this was made compliant by the auditor." The write-scope
restriction is what makes the audit trail evidence rather than testimony.

**The sponsor's standing power over this seat: canaries.** The sponsor may
deliberately plant a process violation — hand-edit a record, ask for an altered
relay — to test whether the auditor catches it, and tells nobody in advance. A
missed canary is a critical finding against the auditor. The mechanism is
documented; **no instance is ever announced in advance, and none is discoverable
by construction before it is caught.** `[RE · C-30]` (Once caught, an instance is
necessarily documented — it becomes a finding like any other. The first edition
said the instances "never are" documented, which contradicted the finding route
in the next clause.)

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
  summary, refreshed at boundaries as a navigation aid `[CORRECTED · C-32]`.

*Margin note on both aids, and it is the same note.* The first edition described
the index as a maintained navigation aid. **It was written once, at ratification,
and never updated**: at the audit it still listed two leads as "not yet
activated" while one of them was eleven volumes deep, and named an entry id some
nineteen entries stale. It was letter-compliant — one boundary had passed — and
materially false as a description of a live aid. The program-state file decayed
in the same direction and needed a census to repair: work-order identifiers that
were live in reasoning logs and never rowed. **The lesson generalizes past both
files: an aid refreshed "at boundaries" degrades exactly as fast as boundaries
are rare, and a stale aid is worse than a missing one, because a missing one
sends the reader to the source.** If you carry a derived index, either derive it
mechanically at read time or state in the file itself the date it was last true.

The recovery procedure is written down: a fresh orchestrator reads the
program-state file, then the shared rules, then the roster file, then the tails
of the logs of any seat with open work. **A drill — kill the orchestrator
mid-program and rehydrate on purpose — is a scheduled obligation of the first
phase and has not yet been performed.** `[CORRECTED · C-33]` The first edition
stated it as an exercised fact; the record contains no drill in any log, gate or
board row, and the constitution schedules it in the future tense. By this
document's own next sentence, the recovery procedure is therefore currently a
**hypothesis**, and the claim that the org survives the loss of its orchestrator
may not presently be made. It is stated here as owed, with its closing event
named, so that a reader can see the debt rather than inherit the confidence.

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

*Honesty note, corrected.* `[CORRECTED · C-40]` The first edition — following the
constitution's own words — said that for seats with narrow write scopes,
one-agent-per-commit *falls out of the scope rules automatically*, because a
commit physically cannot mix two scoped seats' files. **That is false, and it is
the most consequential false claim in the first edition**, because it is the
sentence that tells an adopter it need not audit attribution for scoped seats.

The scopes are **not disjoint**. In the audited scope table, the packet directory
is granted to three leads and all four worker roles; the implementation tree to a
lead and its worker; the test tree to a lead and two worker roles; the tools tree
to a lead and one worker. A commit staging two packets authored by two different
leads passes the path-isolation check under either identity. The emergence is
real only for **disjoint pairs**, and the claim was stated universally.

What is actually true, and what an adopter should carry:

- **One journal append per commit is the mechanical invariant** `[MC · C-59]`.
  That is what the machinery holds, in every case, for every seat.
- **One *agent* per commit is emergent only where the two seats' scopes are
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
frozen and any change to it breaks the successor's recorded hash `[MC · C-45]` —
the whole chain is re-verified on every commit and again over pushed history:
gapless numbering, back-link, digest, and contiguous entry ids across the seam.

*Which of those header fields is structure and which is testimony* `[MC · C-44]`,
because §5.4 demands that a record say so and this one did not. Path and digest
are **checked** on both surfaces. `Volume` and the continuation id are **checked**.
The **byte count is checked by nothing** — it is an author's assertion sitting in
a list of verified fields, which is the precise shape §5.4 warns about. It is
kept because it is cheap to read and it fails loudly against the digest if it is
wrong; it is marked because an unmarked assertion inside a verified block borrows
the block's authority.

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
the third has not run over the build phase** — so the honest reading of this
compensation is that the two static legs exist and nothing has been sampling
them. State it that way in your own document, or you will describe a tripod
standing on two legs.

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

*Corollary, adopted after a measurement.* If a check exists on one surface — the
local commit path — and not on the other — the re-check over pushed history — the
asymmetry is itself the defect. Both surfaces or neither.
`[P1 · 2026-08-04 · C-55]`

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
re-check has **no size check at all**. A commit made with the local hook bypassed
therefore passes the re-check clean. The first edition said "every rule", without
qualification — and the defect is not the missing check so much as the
**unqualified quantifier**, because a reader who trusts it stops looking for
exactly this. What the full-history claim gets right is worth keeping: the
re-check really does run over all of history rather than the new range, for the
reason given below, and everything except the size threshold really is on both
surfaces. A proposed decision record specifies the missing limb; it is **not in
force** (**Annex B**), and this sentence will be true without qualification only
when it lands.

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

**Two things that matters for.** An adopter reading a dependency described as
open will treat their own as open; and *the strongest available evidence for a
control is an attempt that bounced*, which is an artifact you can only have if
someone deliberately tried. Configure it, then attack it, then cite the bounce.

*Failure class.* Undeclared external dependencies in a control. A guarantee that
silently depends on a setting nobody has verified is cited for the life of the
program and has never been true.

### 2.6 The numbered commit rules

The rule set is small, numbered, and cited by number in every later argument
about them. Their functions are what transfers — and so is the column the first
edition did not have: **where each one is actually enforced.** A table headed
"the commit script enforces" that contains rules the commit script does not
enforce is the exact defect §2.4 warns about, and it contained two.

| Rule | Function | Enforced where |
|---|---|---|
| One agent per commit | Mixed-agent changes are split into sequential commits; the mechanical invariant is one journal append per commit | Both surfaces, **as the invariant** — the splitting itself is review-enforced for overlapping scopes and for the unscoped seat (§2.1) `[MC · C-59]` |
| Coupling | Work must stage a pure append to the responsible agent's journal; journal-only commits are legal but must be marked | Both surfaces `[MC · C-60]` |
| Append-only | The previous version of the journal must be a byte prefix of the staged one; journal deletion and renaming are always refused | Both surfaces `[MC · C-61]` |
| Files-list equality | The entry's declared file list must set-equal the commit's changed paths, excluding the author's own journal | Both surfaces `[MC · C-62]` |
| Monotonic entry ids | The new entry's number is exactly the previous one plus one — across volumes, not merely within a file | Both surfaces `[MC · C-63]` |
| Trailers | The fixed metadata block must be present and well-formed; protected keys cannot be shadowed or duplicated | Both surfaces `[MC · C-64]` |
| Path isolation | Every staged non-journal path must be in the committing agent's scope | Both surfaces `[MC · C-65]` |
| Foreign journal seeding only | Another agent's journal may be staged only as a newly created, entry-free file (onboarding); modifying an existing one is always refused | Both surfaces `[MC · C-66]` |
| Journal chain and rotation | Volumes are gapless, each carries its predecessor's path and digest, only the active volume may change | Both surfaces `[MC · C-45]` |
| Journal size thresholds | A soft threshold warns, a hard one refuses, anchored to the reader's single-file limit | **Commit surface only** — the asymmetry of §2.5 `[MC · C-46]` |
| Large-file gate | A staged file over a stated byte threshold is refused, with the journal carved out | Both surfaces — the one place the both-surfaces corollary was applied |
| Merge triviality | A merge commit's tree must equal one of its parents' trees; multi-parent merges beyond two are rejected outright | **Pushed-history re-check only**, not the commit script `[CORRECTED · C-67]` |
| One branch, no rebases, no force pushes | Work lands sequentially on one working branch; pushed history is never rewritten | **No script anywhere.** The hosting platform's branch protection, and nothing else `[CORRECTED · C-67]` |

*Margin note on the last two rows.* The first edition folded them into a single
"serialized history" row sitting under the sentence "the commit script enforces".
Two of that row's four clauses are enforced somewhere other than where the
sentence put them, and one is enforced **outside the repository entirely** — the
dependency §2.5 declares. A reader building this layer from the first edition
would have looked for force-push prevention in the commit script and concluded,
correctly, that it was not there, and then had to guess whether that was an
omission or a design.

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
repository has ninety references is a rule an adopter cannot apply.

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
The record shows the procedure working, twice, and shows its debt: an instrument
in force with its constitutional diffs and its owed test cases still unapplied.

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
committed, so it can be diffed, cited and bounced. The taxonomy is closed, and
this is it:

| Packet | Carries | Written by | Relay class |
|---|---|---|---|
| **Work order** | A commissioned unit of work: basis, deliverables, definition of done, context handed over, what is out of scope | A lead, or the orchestrator | Summarizable |
| **Review verdict** | Accept, or a numbered defect list — file, line, and the clause violated — signed with the reviewer's entry id | The reviewing lead | Summarizable |
| **Sign-off** | The verification line's pass/fail on one artifact, with everything §3.8 lists | The verification lead | **Verbatim** |
| **Defect packet** | One defect found after an artifact was accepted, routed to its owner | The verification lead | **Verbatim** |
| **Sealed prediction** | A frozen expectation, opened only after the evidence exists (§3.3) | Whichever seat will be scored | **Verbatim** |
| **Finding** | A severity-graded defect claim against an artifact, including one's own (§3.4) | Any seat | **Verbatim** when the auditor's |

*Two things the table encodes.* Relay class is a property of the packet **type**,
not of the round — it decides in advance whether the routing seat may compress
it (§4.3). And a review verdict is a *packet type*, but see §3.2: in this
program's record it has never existed as its own file.

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
audit for it. **The honest rule is not "everything is a file" but: *every
commission is a file, or the round says in its own reasoning log that it was
dispatch-only and why*** — which converts an invisible exception into a countable
one.

**The failure class that governs this whole section.** A task, verdict, finding or
agreement that exists only in a chat has no author, no version, no diff and no
addressee of record. It cannot be reviewed against, cannot be bounced, cannot be
cited, and its definition of done is whatever the returning party says it was.
Conversation is where work is coordinated; files are where it exists.

### 3.1 The journal entry

The unit of the reasoning record. **Its structure is machine-checked; the quality
of its narrative is owed to audit sampling** `[PLANNED · C-71]` — the split is
exactly right and the second half is not currently running: narrative sampling
was performed once, at ratification, and not again over the build phase. Read
every "enforced by audit sampling" in this document against §1.1's residue note.

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
where a per-file guarantee silently breaks. An entry body may never contain a
line that looks like its own journal's entry header at the start of a line —
quoted headers are indented or embedded in a sentence — because the parsers are
deliberately simple and would count such a line as a new entry `[MC · C-74]`.

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

A bounced packet carries the numbered defect list and re-issues as a new revision.
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

Before evidence exists, the party that will be scored writes down what it expects
and freezes it. Then the evidence is produced. Then the frozen prediction is
opened and compared.

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
at unsealing), the campaign it belongs to, the base state it was formed against,
and the commit at which it was frozen. **Byte equality between freeze and
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

*Margin note.* The first edition said the file carries "its own hash at that
commit". **A file cannot contain its own hash**, and the record's seals say so in
their own headers — one states outright that it cannot state its hash, because
the seat that writes it never runs the version-control tool and the commit does
not exist until another seat creates it. The document invented a field the
grammar cannot have and omitted the two mechanisms that do the work. **The class
is worth naming: a described mechanism that nobody has tried to execute will
contain steps that cannot be executed**, and the way to catch it is to write the
description from the artifact rather than from the intention.

Nothing below its header is ever edited: a wrong prediction is not amended, it is
adjudicated, and it dies on the record `[RE · C-81]`. The append-only guarantee
covers journals, not packets, so this one is carried by discipline — and the
record's practice is self-disclosing about it, with the state line marked as *the
only line of this file altered since the freeze*. **Who unseals and who
adjudicates** is not left open: the seal is opened by the seat that froze it, at
the round the evidence lands, and scored by the reviewing seat named in the
commissioning packet — never by the party whose work the evidence grades.

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

Severities are fixed and the grading is part of the filing, not of the response.
The scale actually in use has **four** grades — critical, major, minor, and a
non-binding **note** `[CORRECTED · C-82]`. The first edition listed three. The
fourth is not decorative: it is where a filer puts an observation it wants on the
record and does *not* want routed as a defect, and without it those observations
either inflate into minors or vanish. *(This program's founding audit returned 1
critical, 7 major, 7 minor and 2 note. The council that reviewed this document
quoted that tally from a superseded line of the same report — 5 major, 4 note —
which the report itself had corrected in place; the finding stood either way,
since it turns on the number of grades, not the split. The corrected figures are
the ones above.)*

Critical findings from the auditor reach the sponsor verbatim as their own
escalation class (§4.6) `[P1 · 2026-08-01 · C-83]` — exercised once, at the
founding gate, where a critical finding blocked the gate until a decision record
dispositioned it and the auditor re-verified the disposition.

A finding is not closed by being contradicted. It closes when its owner repairs it
or rules on it with grounds, and the ruling is itself an artifact. A finding that
is sustained but whose cure lands elsewhere is recorded with its **route** — the
owner and the trigger — so that a debt cannot be discharged silently or forgotten.

**Findings against one's own seat are ordinary.** The record contains a lead
filing a major finding against a value its own packet specified; a seat offering,
against its own interest, a rule that raised the standard its own artifacts would
be held to; and a seat correcting a residual-risk routing so that its own duties
grew. The process treats these as the normal case rather than as heroism, and one
of its own tests for whether a finding is self-serving is explicit: **check which
way each of the finding's separable clauses moves the filer's own exposure.** A
finding usually has more than one **limb** — one separable clause that can be
sustained or refused on its own (see *The dialect*). A filing whose every limb
reduces its filer's obligations is one to distrust; a filing that **widens** its
filer's exposure in one limb while narrowing it in another has probably been
reasoned about rather than motivated. *(The first edition wrote "the finding's
two halves", which a cold reader could only map onto the rule/failure-class pair
this document uses everywhere else. The test is about limbs, and findings are not
limited to two.)*

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

*Margin note, and this is the correction that most changes what an adopter should
build.* The first edition said signers cannot stage the checklist **because write
scopes forbid it**. They do not. In the audited scope table the specification
lead — who is a gate signer — holds the entire documentation tree, gate
directory included; a live probe of the policy returns **allow**, and four
commits under that identity have staged gate files, one of them the very
checklist that carries this rule. The real control is a **convention written at
the top of the checklist itself** — *no box in this file is checked by its
author* — which is review-enforced, and which the record shows being kept
(including a round where the author of a checklist declined to check its own
boxes and said so).

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
mapping with gaps declared, the stress-test results, the seeded-defect dispositions, and
open defects. It is a merge precondition and it is relayed verbatim.
`[P1 · 2026-08-11 · C-94]` — **the described form is real and the sample size is
one.** Exactly one sign-off exists in this program's record; it carries every
element named above. An adopter should read this section as a form that has been
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
sealed before any defect existed.

**The campaign is placed per artifact, not on a cadence** `[CORRECTED · C-97]`.
Its position is exact and it is stronger than a cadence: **after the implementing
line's review has accepted the artifact, and before the verification line may
issue its sign-off** — so the sign-off itself reports the disposition of every
seeded defect, and the artifact-ready gate merely re-checks what the sign-off
already had to state. A cadence would let an artifact reach sign-off between
campaigns; the placement makes a campaign a **precondition of the merge** rather
than a periodic exercise.

*Margin note.* The first edition said "on a fixed cadence", and said the manifests
are applied **transiently** — in a working state that is reverted. Both are wrong
against this program's record, and the second is wrong in a way worth carrying,
because the constitution still says it too. Every campaign in this program ran as
**ordinary commits pushed to marked references that are never merged** — some
ninety of them — for a reason that is a substrate fact, not a preference: *the
only environment that can run the suite runs on pushed references*. There is no
local run to revert. The first edition contradicted itself on this within
twenty-five lines, describing the transient model here and the pushed-reference
model below. The rule-and-its-check disagreement of §2.4, in a document, about
its own mechanism.

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
failure messages `[RE · C-103]`. **The *set* of units that turns red rarely
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
  was frozen before the run**, never on what the run returned.
- **The unit of the record is the defect class**, not the branch or file that
  delivered it. A ref population grows by infrastructure accident and cannot be a
  denominator.
- **Every non-kill is named individually**; no non-kill is folded into a kill and
  no ratio stands in for the dispositions.
- **A defect that survived its own campaign** and was later caught is dispositioned
  in exactly one evidence form: the *unmodified* committed diff, replayed against
  the suite as it stands now, at a run id, with the killing unit named. Anything
  weaker lets a survivor be argued dead.
- **A campaign kill is a frozen measurement too**, so it is dispositioned by its
  campaign record *together with the named killing unit, present and green now*.
  That form catches a killing check deleted or disabled since; it does not catch
  one weakened, and the clause says so rather than leaving the limit to a
  footnote.
- **Equivalent defects leave the denominator only on a proof.** A defect no
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
without its case is a rule nobody can apply.*

**The column that was not its label.** A tally published a column headed
*sealed*. It **excluded** an item the record had itself declared sealed, and
**included** one that had never been rendered at all, on two grounds that had
never been stated together anywhere. The verdict lines then qualified themselves
with a word — *of the scoreable classes* — that appeared in no normative
document. The defect surfaced only because someone was writing a rule to codify
the practice, and would have frozen the wrong definition: the draft was taken
from the practice's **columns**, while the operative word lived in its **verdict
lines**. It then happened again, at a third item, in the same round. This is why
the naming duty is closed while the list of grounds is open (§5.2).

**The survivor argued dead.** A defect that its own campaign recorded as
surviving was later said to be handled, on the strength of a suite that had grown
since. Every weaker evidence form permits this: a re-run of a *rewritten* patch,
a claim that some unit "would now" catch it, a ratio that no longer names it. The
form the rule demands is the narrow one that cannot be argued — the **unmodified
committed patch**, replayed against the suite as it stands at the gate, at a run
identifier, with the **killing unit named**. And the campaign's own recorded
`survived` count is kept beside it, unedited: two facts, never folded into one.

**The killing unit that had no unique referent.** A clause required a kill to be
dispositioned by naming *the* killing unit — singular — against a record in which
one class was killed by four units, another by nine, and a third by one of three
required together. Two readings were available and they differ materially: *all
of them must still stand*, which is wider than the hazard, or *any one suffices*,
which lets the disposition pick the most durable unit at gate time. The seat that
found it filed against a clause it had itself signed, routed the fix to the seat
the width would fall on, and the one-word repair was **stopped** rather than
applied, because by then the word was live constitutional text and curing it in
the record alone would have left authority and constitution disagreeing (§4.8).
The general form: **a singular noun inside a counting rule is a specification of
uniqueness, and if the record's instances are plural the rule has already been
applied to something it does not fit.**

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
routed. Protected classes — sign-off packets, defect packets, and every auditor
finding — are relayed **unedited**, because fidelity is load-bearing there. The
relay-fidelity spot-check on the protected classes is the auditor's charter duty
`[PLANNED · C-109]`.

*Stated as owed, because it has never happened.* Early in the program the auditor
recorded that fidelity was untestable — no protected-class packet had yet been
relayed. Protected-class packets have existed since, in quantity, and **no
spot-check followed**. This is the same dormancy as §1.1's residue, and it is the
control that the exhibit below exists to justify.

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

*Anonymized pattern, and it is the sharpest one in the record.*
`[P1 · 2026-08-11 · C-110]` A finding about record fidelity was relayed with one
word dropped — the relay of a fidelity complaint itself demonstrating the
fidelity hazard. Nothing turned on the word,
which is exactly why it is worth keeping: the mechanism failed in the benign case
and was therefore visible before it failed in a case that mattered.

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
| **E6** | Budget or schedule anomalies past a stated threshold |

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

The sponsor's surface is deliberately small and completely enumerated: the six
escalation classes, one one-time infrastructure setup (the branch protection
without which the history guarantee is convention `[P1 · 2026-08-01 · C-115]`,
configured and live-fire verified — §2.5), the standing canary power, and the
ratification of the organization itself.

**A single file tells them how to spot-check the whole program by hand**, in five
steps: three version-control commands — every commit title with its one agent,
one agent's entire thread, and any change beside the reasoning that produced it —
plus a two-hop walk from the roster file to a charter to that seat's log tail,
plus a look at the continuous-integration tab. `[CORRECTED · C-114]` *(The first
edition said "four commands". There are three commands; the other two steps are
not commands. The correction is small and the class is not: a specific number is
the part a reader remembers and the part they will check.)*

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

*The qualification is the exhibit, not a hedge.* "A majority of the record" is
true of one measurement and false of the other, and the first edition gave the
headline number and the stronger word without saying which measurement produced
which. **A census is not one number**, and the sentence that reports it has to
carry the band it was measured at, or the next reader will pair the strongest
adjective with the most memorable figure — which is what happened here, in a
document about record fidelity.

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
verdict lines used a qualifier ("of the *scoreable* classes") that appeared in no
normative document. The defect was found only when a rule was being written to
codify the practice: the codification would have frozen the wrong definition,
because it was drafted from the practice's **columns** while the operative word
lived in its **verdict lines**. It then happened a second time, at a third item,
in the same round.

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

*And the correction here is the reason this edition exists.* The first edition
said *each clause* does this. **Exactly three clauses in the constitution carry an
in-clause posture declaration.** Every other clause states its posture in
surrounding prose or not at all — including the honesty note on the
one-agent-per-commit rule, the read-access residue, and the whole of the commit
protocol. It is an excellent practice, applied three times, described as
universal. The same over-generalization is what the first edition did to itself:
it stated the posture rule and stamped nothing. **A practice you have applied
three times is a practice; write the number.**

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
not the episode `[P1 · C-125]`:*

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
clones and starts from. The first edition never mentioned it. That omission is
why its adoption order could put "turn on the mechanical layer" in a single
bullet: with no reference implementation named, the bullet stands in for
building, from prose, several hundred lines of enforcement script whose value is
almost entirely in the incident-hardened details — the failure modes of a
pipeline that swallows an error, enumeration of a journal chain from committed
state rather than from the working tree, protection of the metadata keys against
shadowing — none of which any prose description will regenerate.

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

**What this table asserts, and what it does not.** Every artifact above **exists,
in its original form, in the repository that paid for it** — that is checkable
from a clone. The shell is their extracted, project-free copy in a separate
repository, kept deliberately frozen except for one commit per lessons harvest
(§3.10), and **its contents are not verifiable from here**: an adopter reading
this document should treat the shell as named, not as inspected, until they have
looked at it. Two export vehicles that do not reference each other is §2.4's
"rule and its check that disagree" one level up, and this section exists to make
them reference each other; the check that keeps them honest — a test that the
shell's rule set and this document's §2.6 table have not drifted apart — **does
not exist yet** and is the most useful thing an adopter could build first.

### 6.1 What transfers, and what has to be re-earned

**Transfers directly:** the seat topology and the two monopolies; the write-scope
table; the commit rules and the coupling of work to reasoning; append-only journals
with chained volumes; the packet forms and the work-order state machine; the
countersignature discipline; the decision-record and amendment route; gates as
signed, diffable checklists; sealed predictions; seeded-defect campaigns; the
escalation classes; and the harvest cadence.

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

### 6.2 The order that works

A load-ordered checklist, each step keyed to the kit artifact that performs it
(§6.0). The order is not a preference: each step's failure is unrecoverable once
the following steps have run on top of it.

**Step 0 — verify the reference implementation's claims against its own
machinery.** Before adopting anything, take this document's mechanically-enforced
claims and check them in the shell you have been handed: for each `[MC]` stamp,
find the refusal, and for each numbered rule, find the self-test case that
constructs a violation of it. Anything you cannot find is `[RE]` in your hands
whatever it is stamped here, and belongs in your own residue list. *This step
exists because the program that wrote this document had never performed it, and
performing it returned fifteen false claims. You are inheriting a corrected
document; you are not inheriting the correction of your own copy.*
→ *kit: the self-test, the commit script, the policy module.*

**Step 1 — ratify the roles, adversarially, before anyone works under them.**
Attack the charter set from at least three lenses — role coherence,
enforceability, and readability by the non-specialist who will sponsor it —
and dispose of every finding in a committed artifact. §1.7 is the sequence this
belongs to and §1.3 carries the caveat: run the review **into the repository**,
not before it exists, or its evidence will not survive.
→ *kit: the charter template.*

**Step 2 — turn on the mechanical layer before the first real work.** Coupling,
append-only with the chain, path isolation, files-list equality, monotonic ids,
trailer protection, the large-file gate, and the full-history re-check.
Retrofitting these onto an existing history is far more expensive, and the
history you most want them for is the earliest history — which is also the
history no control will ever have touched if you defer them (§1.7).
→ *kit: the commit script, the history re-check, the policy module, the workflow.*

**Step 3 — configure the out-of-repository dependency and verify it by live
fire.** Branch protection on every protected branch, with an **empty bypass
list** so that the account your own automation pushes with cannot override it,
and then an attempted violation that actually bounces, cited by identifier in the
gate record. An unverified protective setting is a belief. *This program did
this, on both branches, on its first day, and had it re-proved in anger later
when a forced push on a working reference was refused mid-incident — the two best
pieces of evidence it owns for the guarantee the whole append-only design rests
on.* `[P1 · 2026-08-01 · C-128]`
→ *kit: the sponsor guide.*

**Step 4 — run the enforcement self-test green, and bind it to the amendment
procedure**: every amendment that changes enforcement semantics adds a case
(§2.7). A rule whose test case cannot be written has a predicate nobody has
pinned down.
→ *kit: the self-test.*

**Step 5 — instantiate the gate that closes the founding**, including the
retro-audit of the whole bootstrap range by a seat that did not exist during it,
with its own weakness declared, and the sponsor's ratification row. Do not issue
the first real work order until every row is signed (§1.7).
→ *kit: the packet forms, the constitution template.*

**Step 6 — only then start the work**, and start the harvest cadence with it
rather than after it — with the harvest's destination decided on day one (§3.10),
even if that destination is one file in your own repository.

**The definition of done for an adoption**, so that "we adopted it" is a
falsifiable claim rather than a feeling:

- [ ] The self-test runs green from a clean clone, and its case count equals the
      number of numbered rules plus the amendments since.
- [ ] Every `[MC]` claim in **your** copy of this document has been traced to a
      refusal in **your** machinery, and every one that could not be traced has
      been re-stamped `[RE]` or `[PLANNED]` in your copy. Step 0, recorded.
- [ ] The platform dependency has bounced a real attempted violation, and the
      bounce is cited in your founding gate record.
- [ ] The bootstrap range has been retro-audited by a seat that did not write it,
      the audit returned findings, and any critical finding blocked the gate
      until dispositioned and re-verified.
- [ ] Your residue list exists as a file: every control you have that is
      review-enforced, named, with the seat it is routed to — and a cadence for
      each, because §1.1's residue note is the failure that eats the rest.

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

**A.1 — A spawned agent cannot spawn.** *Anchor:* a property of the agent runtime
this was built for, not of any rule here. *What rests on it:* the sole-spawner
monopoly (§1.1) is free — nothing needs to enforce it. *If your substrate
differs:* the monopoly becomes a **policy**, its posture drops from substrate-fact
to review-enforced, and you need a different mechanism for the property it was
buying — attribution of who commissioned what. Nothing else in §1.1 changes; that
paragraph is about attribution, not about the tree shape.

**A.2 — One working tree, one index.** *Anchor:* the version-control tool, not
this design. *What rests on it:* the commit handoff of §2.1, and both precheck
disciplines of §4.1–§4.2, which exist because two seats cannot safely be mid-edit
in one tree. *If your substrate differs* — per-seat clones or worktrees — the
handoff simplifies and the precheck disciplines become **more** important, not
less, because a stale base is no longer visible as a dirty tree.

**A.3 — The reader's single-file limit, and the journal size thresholds anchored
to it.** *Anchor:* the maximum bytes the agents' file-reading tool returns in one
call — 256 KiB in this environment. *Derived:* a journal warns at that figure
(262,144 bytes) and refuses at twice it (524,288). The anchor is the rule *one
volume should be one readable unit*; the numbers are consequences. *If your
substrate differs:* recompute both thresholds from your own limit and restate the
anchor in the same act — the whole point of anchoring is that a parameter change
is an edit with its reason attached rather than an argument about taste. *Note the
live residue:* in this program the hard threshold is enforced on the commit
surface only (§2.2, §2.5).

**A.4 — Read access cannot be denied per path.** *Anchor:* the agent runtime; no
per-path read denial exists. *What rests on it:* the blinding separation of
§1.4(c) and the seeder allow-list of §3.9 are **review-enforced**, carried by
prompt content, packet content and audit of recorded reading — and the document
says so rather than claiming coverage. *If your substrate can deny reads:* those
two postures move to machine-checked, the compensating audit becomes optional
rather than load-bearing, and you should say so in the clause, because a reader
of an inherited document will otherwise keep operating your stronger control as
if it were the weaker one.

**A.5 — Branch protection semantics.** *Anchor:* the hosting platform. What it
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

**A.6 — The only environment that can run the suite runs on pushed references.**
*Anchor:* this program's toolchain decision, recorded in its own decision record;
a local run is impossible. *What rests on it:* the campaign model of §3.9 — marked
references, pushed, never merged — rather than the transient apply-and-revert
model, which is what the constitution originally described and what the first
edition of this document repeated. *If your substrate differs* and you can run the
suite locally, take the transient model: it is strictly better, because the
never-merged property stops being a measured fact someone has to keep measuring.

---

## Annex B: what this edition owes

*This annex is **program-local**. An adopter forking this document deletes it and
starts their own. It is here because §3.5 forbids recording owed traffic as paid
and §5.5 requires a debt to be legible to a later reader, and a ledger whose
entries cannot be resolved to acts is not a ledger — so this is the one section
that names this program's own artifacts.*

**B.1 — Confirmations this edition owes.** The document describes other seats'
disciplines in the specification lead's words. Each seat confirms the description
of its own discipline; the round runs before the next review of this text.

| Text | Owes confirmation from | On what |
|---|---|---|
| §3.9 whole, incl. the seeder seating in §1.5 and the per-artifact placement | **auditor** | that the manifest-authoring reading of its scope is stated correctly, and that the placement and separations match its practice |
| §3.9 scoring block and its three rebuilt exhibits | **dv_lead** | that the rebuilt referents say what the rulings say, and that no exhibit misstates a campaign |
| §3.8 sign-off form; §4.3 relay classes | **dv_lead** | that the described form matches the one sign-off in the record |
| §2.6 rule table incl. the new *enforced where* column and the two added rules | **orchestrator** | that the surface attribution is right for every row |
| §2.1 commit handoff description (steps 1–5) | **orchestrator** | that this is what the committing seat actually does |
| §1.7 genesis sequence | **orchestrator**, **auditor** | the founding sequence and the retro-audit's self-description |
| §6.0 kit table | **orchestrator** | that each named original exists where the table says, and the shell's stated contents |
| Every `[MC]`, `[RE]`, `[P1]`, `[PLANNED]` stamp | **auditor** | transcription fidelity against its own posture list |

**B.2 — Routed, not performed here.** Each is an edit to a file outside the
specification lead's write scope, or an amendment requiring its own instrument.
They are named so the debt is countable; none is applied in this edition.

1. **The constitution's own honesty note on one-agent-per-commit** carries the
   same false disjointness premise corrected at §2.1 (`PROTOCOL` §5 R1). Amendment
   candidate; joins the next §11 batch.
2. **The constitution's gate clause** states that signers cannot stage the gate
   directory *because scopes forbid it* (`PROTOCOL` §7) — the same false premise
   corrected at §3.7, found by this revision. Amendment candidate, same batch.
3. **Narrowing the specification lead's scope** to carve out `docs/gates/**` in
   `scripts/policy.sh`, which would convert §3.7's convention into a refusal.
   Orchestrator scope; option, not recommendation — the residue declaration is
   live either way.
4. **`F-0022-2`'s one-word cure** (the singular *killing unit* against a record of
   plural killing units) remains stopped and owed, as recorded in the round that
   stopped it; it joins the same amendment batch, and §3.9's third exhibit is its
   anonymized form.

**B.3 — Instruments named in the text and not in force.** `ADR-0021` is
**PROPOSED** at `287b5ee` and its route completes per subject. Subject 1
(`WARN-STAMP`, both surfaces) is the instrument named at §2.4(b) and §5.1's
corollary; subject 2 (the journal-size limb on the pushed-history surface) is the
instrument named at §2.2, §2.5 and §2.6. **When and only when those land, rows
C-56, C-46, C-55, C-54 and C-119 change posture — by a later act, on a later
commit.** No stamp in this edition anticipates them.

**B.4 — Exhibits owed an anchor or a removal.** §1.4(d)'s residual-risk routing
and the identical first disguise in §5.7 (`C-24`, NOT SAMPLED); the incident
behind §5.7's third disguise. Both are kept, marked, and owed.

**B.5 — A discrepancy in this edition's own source, flagged rather than
propagated.** The posture list's summary table and its collected-false table both
give **15 FALSE and 8 PLANNED** of 127 rows; the evidence cell of row `C-126`
states "12 FALSE and 4 PLANNED". This edition uses the summary figures, which the
row-by-row tables support. The discrepancy is the auditor's to resolve; it is
recorded here rather than silently averaged, per §4.3's rule that the receiving
seat checks the source rather than reasoning from the relay.

**B.6 — Debts this document still owes its own process.** It has never been
through the packet lifecycle it describes: the first edition landed with no work
order and no countersignature (`C-20`), and this revision was commissioned
dispatch-only (`C-70`) — an instance of the class it names in §3. The
countersignature round of B.1 is the first half of the repair; a review verdict
recorded as a packet would be the second. And the drift check between this
document's §2.6 table and the shell's rule set (§6.0) does not exist.


