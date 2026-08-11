# PROCESS — how this organization works

A reference for the way a program is run here: the seats, the rules they work
under, the artifacts they produce, the disciplines they keep, and the failures
each of those exists to prevent.

**This document contains no project.** No modules, no domain, no requirements, no
identifiers from any particular piece of work. Everything below is the machinery,
stated so that it can be lifted into a program that has nothing in common with the
one that paid for it. Where a real episode makes a mechanism legible, it appears
as an anonymized pattern — *a lead once filed a serious finding against a value
its own packet had specified* — never with the nouns of the work it happened in.

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
use and then used plainly.

---

## Contents

1. [The shape of the organization](#1-the-shape-of-the-organization)
2. [The constitution and its enforcement](#2-the-constitution-and-its-enforcement)
3. [The artifact grammar](#3-the-artifact-grammar)
4. [The operating disciplines](#4-the-operating-disciplines)
5. [The failure museum](#5-the-failure-museum)
6. [Adopting this](#6-adopting-this)

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

### 1.1 Why one seat holds both monopolies

The orchestrator is the **sole spawner** — no other agent starts an agent — and
the **sole committer** — no other agent runs a commit or a push.

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
numbers are allocated at commit time by the one seat that commits, so they are
monotonic by construction rather than by convention. History is serialized on one
branch, so there is a single order of events.

**The failure class the committing monopoly prevents.** Concurrent identical
identifiers, interleaved histories that cannot be replayed, and the specific
disaster of two agents committing versions of the same file in an order neither
of them chose. It also removes an entire category of temptation: an agent that
cannot commit cannot quietly commit a fix to the thing it was being graded on.

**The cost, stated honestly.** The orchestrator becomes a bottleneck and a single
point of failure, and its own correct behavior is the one thing the machinery
cannot check mechanically — every other seat is constrained by write scopes, and
the orchestrator's scope is everything. That residue is covered by the auditor,
which audits the orchestrator like anyone else, and by the sponsor, who is the
only party the orchestrator reports to.

### 1.2 The seats, by function

Names vary by program. What matters is the function and the separation.

**The sponsor** (human). Owns a short, fixed list of decisions — described in
§4.7 — and is deliberately excluded from everything else. Reads a single status
file to find out whether anything needs them.

**The orchestrator.** Plans, routes, spawns, commits, escalates. Writes the
program-state file. Applies clerical edits to files whose authority lives
elsewhere (see §3.6). Never authors the evidence it is asked to judge.

**The specification lead.** Owns the specifications, the numbered requirements,
the decision records, and all documentation. Nothing is built that this seat has
not specified; nothing merges undescribed. Also adjudicates interface disputes
between the other leads — and its rulings take the form of a specification diff
plus a decision record, never a verbal agreement.

**The implementation lead.** Owns everything that ships as the product artifact.
Reviews worker output in its line. Never writes the tests that grade it.

**The verification lead.** Owns the tests, the reference models, the replays and
the measurements, and issues the **sign-off** packets that are a precondition of
merge. Derives everything from the specification, never from the implementation.

**Workers.** Spawned per packet, given exactly the context that packet carries,
returning exactly what it asks for. They share a journal template per role, with
each spawn identified by a token minted into its prompt.

**The auditor.** Independent. Audits every seat including the orchestrator.
Writes to one directory — its own reports — and to no other, ever. Cannot fix
what it finds; its verdicts reach the sponsor unedited.

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
rules.

Charters change only by the amendment procedure (§2.7) — a numbered decision
record, not an instruction.

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

### 1.4 Separation of duties — three lines, each drawn against a specific temptation

**(a) No seat reviews its own work.** Every output is accepted by a seat that
did not produce it. Where the producing seat is the only competent reviewer, the
review is split: the competent seat checks the substance and a second seat checks
that the guard is exactly the rule and not wider (§3.5).

*Failure class.* Self-certification. It is not that agents lie; it is that an
author reads their own artifact for what they meant, and a reviewer reads it for
what it says. The gap between those two readings is where nearly every defect in
this record lived.

**(b) Builders never write the tests that gate their own artifacts.** The
implementation line cannot write in the test tree, and the verification line
cannot write in the implementation tree. This is enforced at the boundary — as a
refusal at commit time — and not as an instruction.

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
wrong, which is the exact inverse of what a test is for. This is the one
separation that cannot be enforced by file permissions — nothing in a general
agent runtime can deny read access to a path — and the process is explicit that
it is enforced instead by prompt content, packet content, and audit of the
"inputs" section of each reasoning log. **Naming an unenforceable control as
unenforceable is itself a control**; the alternative is a compliance claim that
nobody has ever checked.

**(d) The party a measurement grades cannot be that measurement's own check.**
Where a rule creates a check on a seat, the check is routed to someone else — and
if the natural reviewer of an artifact is the very party the artifact grades,
that routing is a defect regardless of how convenient it is.

*Anonymized pattern.* A residual risk in an amendment was routed, in the
amendment's own text, to "review by the ordinary reviewing lead" — where that
lead was the party the rule under discussion measured. Three seats independently
said so, including the seat whose duty the correction enlarged, which asked for
the enlargement. The routing was corrected to the independent seat.

### 1.5 The auditor is a different kind of seat

The auditor is not a stricter reviewer. It is structurally distinct in four ways,
each of which is a control:

1. **It can write only its own reports.** Not the specifications it audits, not
   the tests, not the artifacts, not even the shared task packets. This is
   enforced mechanically.
2. **It never fixes what it finds.** A finding is routed to the owner, who
   repairs it. An auditor that repairs is an auditor with an incentive to find
   what it can repair.
3. **It audits the orchestrator too** — including the seat that spawns it.
4. **It re-executes evidence.** Claims in a reasoning log's evidence section must
   reproduce at that commit; the auditor re-runs samples. This is what makes the
   evidence sections falsifiable rather than decorative.

Because the auditor cannot write into shared packets, its verdicts on those
packets are recorded in its own committed report, and the orchestrator transcribes
them into the packet under its own identity — a clerical transcription whose
authority lives in the auditor's artifact, not in the transcription.

**The failure class.** An auditor with edit rights on what it audits produces an
unfalsifiable record: after the fact, no reader can distinguish "this was always
compliant" from "this was made compliant by the auditor." The write-scope
restriction is what makes the audit trail evidence rather than testimony.

**The sponsor's standing power over this seat: canaries.** The sponsor may
deliberately plant a process violation — hand-edit a record, ask for an altered
relay — to test whether the auditor catches it, and tells nobody in advance. A
missed canary is a critical finding against the auditor. The mechanism is
documented; the instances never are.

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
  gate status, pending escalations, and the name of the working branch;
- **a journal index** — one row per log with its last entry and a one-line
  summary, refreshed at boundaries as a navigation aid.

The recovery procedure is written down and deliberately rehearsed: a fresh
orchestrator reads the program-state file, then the shared rules, then the org
chart, then the tails of the logs of any seat with open work. This is exercised
once mid-program as a drill — killed and rehydrated on purpose.

**The failure class.** A program whose real state lives in one session's context
window dies with that session, and it dies silently: the replacement session
starts confidently from a partial picture. Everything above exists so that the
loss of any agent, including the orchestrator, costs a re-read and not a restart.
The drill exists because an untested recovery procedure is a hypothesis.

---

## 2. The constitution and its enforcement

There is one shared rules document — the **protocol** — that every agent reads
before acting. It is the constitution: it defines how work moves, how reasoning is
preserved, and how the rules are mechanically enforced. It is amended only by the
procedure in §2.7, and only the orchestrator commits it.

Two properties are stated as non-negotiable, and everything else in this section
is machinery for holding them:

1. **Traceability** — for any two commits, the diff between them shows both the
   change and, adjacent in the same diff, the responsible agent's own explanation
   of it. No reasoning is lost.
2. **Independence** — verification is never graded by the party that built the
   thing, and the auditor is never graded by anyone it audits.

### 2.1 One agent per commit, coupled to a journal entry

Every commit carries exactly one agent's work, and must also carry a pure
end-of-file append to that agent's own reasoning log containing a new entry. Work
without an entry is refused. An entry without work is allowed only when explicitly
marked as such.

The commit message ends in fixed metadata: the agent's name, the work-order
identifier or `none`, and the entry id. That metadata is what makes an agent's
entire thread of work recoverable with a single log query.

**The failure class.** Reasoning that is lost between the decision and the diff.
Six months later, a reviewer looking at a strange line has two options: re-derive
the decision, or assume it was deliberate. Both are wrong roughly as often as they
are right. Coupling makes the third option — read the author's own account, in the
same diff — always available, and makes it impossible for work to land without one.

A second failure class, subtler: **attribution collapse**. When one commit
contains two agents' work, no later reader can tell which seat is answerable for
which hunk, so no review verdict can be aimed and no rule can be applied to the
responsible party.

*Honesty note the program keeps in its own constitution.* For seats with narrow
write scopes, one-agent-per-commit falls out of the scope rules automatically —
a commit physically cannot mix two scoped agents' files. For the orchestrator,
whose scope is everything, correct splitting is enforced by audit and not by
machine. The constitution says so in those words. A control that is claimed to be
mechanical and is not is worse than a control known to be advisory, because the
claim suppresses the compensating vigilance.

### 2.2 Journals are append-only, and a journal is a chain

Each agent has one reasoning log — a **journal** — that begins with a frozen
header and thereafter grows *only* by whole entries appended at the end. Nothing
above the last byte is ever edited. No agent writes another agent's journal. The
commit gate verifies this byte-wise: the version at the previous commit must be a
prefix of the version being committed.

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
frozen and any change to it breaks the successor's recorded hash.

*Failure class.* A guarantee that is checked per file rather than per identity.
Without the chain, "this file is append-only" remains true of every file while an
entire volume of history disappears.

There are two size thresholds: a soft one that warns and a hard one that refuses,
both anchored to a stated reason (one volume should be one readable unit) rather
than to taste, so that changing them is a parameter edit with the anchor restated
rather than an argument.

### 2.3 Path isolation — every seat has a write scope

Each agent may stage changes only inside its declared scope. The scope table is
part of the constitution, and it is checked at commit time and re-checked in
continuous integration. Read access is unrestricted except where a charter says
otherwise, and where it does, the document says plainly that the restriction is
enforced by prompt and audit rather than by the filesystem.

The consequences are the separations of §1.4 made physical: the implementation
line cannot stage tests, the verification line cannot stage implementation, the
auditor cannot stage anything but its own reports, and each worker is narrowed
further by its packet.

**The failure class.** Every incentive-driven boundary violation at once. This is
the single highest-leverage control in the system, because it converts "you must
not" into "you cannot," and the second is the only one that survives a hurried
round. It also produces a useful secondary property: because scopes are disjoint,
one-agent-per-commit is automatic for the scoped seats.

**The residue, named.** Read restrictions are not mechanizable in a general agent
runtime. The program states this rather than implying coverage it does not have,
and compensates with three things it can check: what a packet contained, what an
agent recorded reading, and an auditor that samples both.

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
**review-enforced**, and the document says so in the clause itself. A script may
emit an advisory note, and the clause states in the same breath that the note's
absence proves nothing.

*Failure class.* A mechanical check whose predicate is a proxy for the real rule
produces both false convictions and — far worse — a **clearance**: the check
passed, so the reviewer stops looking, and the real rule goes unexamined forever.
An honest "no check exists here, humans and auditors look" keeps the vigilance.

**(b) Rules whose subject is testimony rather than structure.** Where the thing
being checked is an agent's own attestation and the record of it is already
frozen, a blocking check makes a legitimate correction impossible. A warning is
right there — not as a weaker version of a refusal, but because the failure it
catches is one that must remain fixable.

**And the general principle underneath both: a rule without its check is a
suggestion.** The counterpart is equally load-bearing and was learned the hard
way: **a rule and its check that disagree about what compliance is are worse than
either alone**, because the disagreement is invisible from both sides. Every
control here is therefore designed as a pair, and where the pair cannot exist, the
absence is written down.

*Corollary, adopted after a measurement.* If a check exists on one surface — the
local commit path — and not on the other — the re-check over pushed history — the
asymmetry is itself the defect. Both surfaces or neither.

### 2.5 Continuous integration is the adjudicator

Every rule the commit script enforces is re-verified by continuous integration
over the entire pushed history, not merely over the newly pushed range. A locally
bypassed check — and every commit tool has a bypass flag — still fails before
merge.

**The failure class.** A check that runs only where the checked party runs it is
a self-report. And the specific reason for full-history rather than incremental
re-checking: **an incremental range check cannot detect a rewrite of history
before the range.** A rewrite is exactly the attack the append-only property
exists to prevent, so checking only the new range would leave the guarantee's
principal threat unexamined.

**The one out-of-repository dependency, declared.** None of this survives a force
push, and force pushes are prevented by branch protection configured in the
hosting platform — a setting the machinery cannot make for itself. The program
names this as a one-time sponsor duty, on a gate checklist, and states plainly
that until it is done the no-rewrite guarantee is convention rather than
enforcement.

*Failure class.* Undeclared external dependencies in a control. A guarantee that
silently depends on a setting nobody has verified is cited for the life of the
program and has never been true.

### 2.6 The numbered commit rules

The commit script enforces a small numbered set, cited by number in every later
argument about them. Their functions, which is what transfers:

| Rule | Function |
|---|---|
| One agent per commit | Mixed-agent changes are split into sequential commits; the mechanical invariant is one journal append per commit |
| Coupling | Work must stage a pure append to the responsible agent's journal; journal-only commits are legal but must be marked |
| Append-only | The previous version of the journal must be a byte prefix of the staged one; journal deletion and renaming are always refused |
| Files-list equality | The entry's declared file list must set-equal the commit's changed paths, excluding the author's own journal |
| Monotonic entry ids | The new entry's number is exactly the previous one plus one |
| Trailers | The fixed metadata block must be present and well-formed; protected keys cannot be shadowed or duplicated |
| Path isolation | Every staged non-journal path must be in the committing agent's scope |
| Foreign journal seeding only | Another agent's journal may be staged only as a newly created, entry-free file (onboarding); modifying an existing one is always refused |
| Serialized history | One working branch, no per-agent branches, no rebases of pushed history, no force pushes; merges to the trunk must be trivial and are verified as such |

**The files-list rule deserves its own note**, because it is the least obvious and
the most load-bearing. Each entry declares the exact set of files that commit
touches. The check is set equality: an entry cannot claim files it did not touch,
nor silently touch files it did not claim. Deletions count as touches.

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
   enforcement self-test proving the new behavior.

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

Everything that moves between seats is a versioned file. Nothing that matters
happens only in conversation.

**The failure class that governs this whole section.** A task, verdict, finding or
agreement that exists only in a chat has no author, no version, no diff and no
addressee of record. It cannot be reviewed against, cannot be bounced, cannot be
cited, and its definition of done is whatever the returning party says it was.
Conversation is where work is coordinated; files are where it exists.

### 3.1 The journal entry

The unit of the reasoning record. Its structure is machine-checked; the quality of
its narrative is enforced by audit sampling.

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

Entry ids are strictly monotonic per journal. An entry body may never contain a
line that looks like its own journal's entry header at the start of a line —
quoted headers are indented or embedded in a sentence — because the parsers are
deliberately simple and would count such a line as a new entry.

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

*Anonymized pattern.* The rule that citations must be re-executable was reinforced
by an audit that re-ran a sample of them and found a small number false — not
fabricated, but decayed: true when written, false at the current state, with
nothing in the record marking the difference.

### 3.2 Work orders, and the loop

A **work order** is a versioned packet: state, from and to, the specification
basis it rests on, the deliverables (constrained to the assignee's write scope),
the definition of done, the exact context handed over, and what is explicitly out
of scope. It carries a return log that the participants append to.

Its lifecycle is a state machine written in the packet header:

**DRAFT → ISSUED → RETURNED → ACCEPTED | BOUNCED**

A bounced packet carries the numbered defect list and re-issues as a new revision.
The review verdict itself is a packet (accept, or a numbered defect list with
file, line, and the specification clause violated) signed with the reviewer's
journal entry id.

Packet numbers are allocated by the sole committer at first commit; drafts in
flight use a placeholder.

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
packet that must omit something says so.

*Anonymized pattern.* A worker packet for a test author omits implementation
source on purpose and says so in the packet; the omission is a property of the
artifact and is auditable years later, whereas an instruction not to look is not.

### 3.3 Sealed predictions

Before evidence exists, the party that will be scored writes down what it expects
and freezes it. Then the evidence is produced. Then the frozen prediction is
opened and compared.

The rule that makes this real is short and absolute: **a seal is a file in the
commit that claims it, or it is not a seal.** A commit may not introduce a claim
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

A sealed prediction file carries: its state (and the single line that is flipped
at unsealing), the campaign it belongs to, the base state it was formed against,
the commit at which it was frozen, and its own hash at that commit — so that byte
equality between freeze and unsealing is checkable by anyone. Nothing below its
header is ever edited: a wrong prediction is not amended, it is adjudicated, and
it dies on the record.

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

Severities are fixed — critical, major, minor — and the grading is part of the
filing, not of the response. Critical findings from the auditor reach the sponsor
verbatim as their own escalation class (§4.6).

A finding is not closed by being contradicted. It closes when its owner repairs it
or rules on it with grounds, and the ruling is itself an artifact. A finding that
is sustained but whose cure lands elsewhere is recorded with its **route** — the
owner and the trigger — so that a debt cannot be discharged silently or forgotten.

**Findings against one's own seat are ordinary.** The record contains a lead
filing a major finding against a value its own packet specified; a seat offering,
against its own interest, a rule that raised the standard its own artifacts would
be held to; and a seat correcting a residual-risk routing so that its own duties
grew. The process treats these as the normal case rather than as heroism, and one
of its own tests for whether a finding is self-serving is explicit: **check
whether the finding's two halves move in the same direction.** A filing that only
ever reduces its filer's obligations is one to distrust; a filing that widens its
filer's exposure in one limb while narrowing it in another has probably been
reasoned about rather than motivated.

**The failure class.** In a system where every seat can file, the natural
equilibrium is that only cheap findings against other parties get filed, because
those are the ones with no cost to the filer. The result looks like a healthy
review culture and is one where nothing that matters is ever examined — the
expensive findings are exactly the ones about one's own work. Making self-filing
routine, and stating the direction test out loud, is what keeps the severity scale
meaningful.

### 3.5 Countersignatures

Every normative change is signed by a seat that did not write it.

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
paid**.

**The failure class.** An author who is also the only reader writes a guard that
is wider or narrower than the intended rule and never finds out — until the guard
either blocks conforming work or waves through the thing it was written to stop.
The delta-signature exists against a second failure: a signature quietly inherited
by a later version of the text, which converts a real check into a citation.

*Anonymized pattern, on where the value actually comes from.* In one exchange the
constrained party signed and, in the same entry, filed a major finding against the
clause it was signing — and separately offered a limb that applied the amendment's
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
authority, and it is what flips the record from proposed to in force.

**The instrument does not edit the file it governs.** Where a record amends the
constitution, the new constitutional text is written *in the record* as source
text, and applied to the constitution by the seat that owns that file, in its own
commit, citing the record. This is not deference — it is the rule that an agent
which can amend the constitution by citing its own decision record can amend the
constitution.

**Status is dated.** A record states, per clause, what is in force at its own
landing and what act would change that. When the acts land, the status line is
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
itself is diffable, and each entry must state in the signer's own log that it signs
that item.

The conventional set is: one org-ratification gate at the start, then per phase a
specification-freeze gate, an artifact-ready gate, and a phase-acceptance gate.
Their preconditions are stated in the constitution as clauses, and the checklist
quotes those clauses verbatim rather than paraphrasing them.

Three rules make a gate more than paperwork:

**A gate file states no condition its cited source does not contain.** This is
written at the top of the checklist itself, because the family has failed exactly
there.

*Anonymized pattern, and it is the program's most-cited conviction.* A reusable
gate block extended a constitutional gate condition to a second kind of artifact
*while citing the constitution for the extension*. The constitution never said it.
The diagnosis is the memorable part: **the packet quoted its source accurately;
the source was wrong.** A checklist that reads a constitutional clause into
compliance is a checklist that has amended the constitution without an amendment.

**Signers cannot stage the checklist.** Because write scopes forbid it, the
orchestrator transcribes every signature. The signature's authority is the
referenced entry; the checklist edit is clerical.

*Failure class.* A signer that can edit the record of its own signature can edit
the scope of its own signature.

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

**A sign-off may say FAIL, and a FAIL is preserved.** Failing verdicts are not
withdrawn when the defect is fixed; the repair is recorded beside the verdict. The
same applies to a prediction that was wrong and to a measurement that was later
superseded: the record keeps what it measured.

**And a sign-off's reporting form is not allowed to force a fold.** Where the
honest answer to a question has four columns, a rule demanding one ratio is a rule
that pressures its reporter into collapsing distinctions.

*Anonymized pattern.* A verification lead reported a campaign in five columns
rather than the ratio the constitution asked for, on the stated ground that
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
which ones it catches. So, on a fixed cadence, an independent seat authors
**defect manifests** — deliberate defects, each in a stated class — the
orchestrator applies them transiently and runs the suite, and the results are
scored against predictions sealed before any defect existed.

The sequencing and the separations matter more than the technique:

**The subject under test is the test suite, not the artifact.** The campaign brief says
so explicitly, because a campaign read as a test of the artifact produces the wrong
response to every result.

**The seeder never operates the repository; the operator never authors the
evidence.** The independent seat composes the defect table and cannot make a defect
land differently from what its manifest says, because it does not push. The
orchestrator executes a table it did not compose, so its own errors — wrong base,
skipped class, wrong order — are checkable against the table by anyone.

*Failure class, from the incident that produced the rule:* an agent whose entire
value is that it did not touch the artifact, touching the artifact — with an
irreversible command, under an identity whose write scope forbids the paths
involved, and with no journal entry to attribute it.

**Mutated artifacts never enter history.** Manifests are applied in a working state
that is reverted, or on refs that are never merged; the permanent history contains
no commit in which the artifact is deliberately wrong. Where infrastructure forces
a pushed ref (because the only environment that can run the suite runs on pushed
refs), the ref is marked and never merged, and the alternative of landing the
defect behind a revert is rejected outright — it puts a wrong artifact in the
lineage and makes every later historical diff untrustworthy.

**No agent in the graded line is running while a manifest is applied.** The
"report, never repair a suspected seeded defect" clauses in the builder charters
are the safety net for a sequencing error, not the normal case.

**The seeder reads from an allowlist.** The campaign names the complete set of
paths the seeder may read; everything else is out of bounds by construction.

*Failure class.* A denylist cannot be defeated by a document the author forgot to
enumerate — which is the failure mode denylists actually have. An allowlist fails
closed.

**What is sealed is not the existence of the campaign but the discriminating
part**: which units must go red, which must stay green, and the exact expected
failure messages. Row sets rarely discriminate between defect classes; messages do.

**Scoring is a discipline of its own**, and it is where most of the program's
hardest reasoning went. The rules that transfer:

- **The question is present-tense.** The gate asks whether the suite *as it stands
  now* kills what was seeded — not whether every past campaign scored perfectly. A
  campaign's score is a frozen measurement and is never retro-edited; the score and
  the suite's present capability are different objects.
- **Two columns, and the difference itemized.** *Sealed* is every defect class the
  manifest sealed, with nothing removed for any later reason. *Seeded* is the
  subset actually rendered as sealed and run. Every member of the difference is
  named with its ground.
- **The known grounds for a class sitting in one column and not the other**: a
  class never rendered (not a defect the suite failed to catch — a defect that does
  not exist); a class whose rendering turned out not to render the sealed class,
  which is **unscoreable** and whose run is a scope report supporting no claim in
  either direction; and a class seeded as a **negative control**, whose seal
  predicts a green and declares that the class scores nothing.
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
  discharging their requirement. A check that no possible defect can reach counts
  one observation twice if counted. A check the seeded set merely *happened* not to
  reach is a seeding gap, not an unreachable check.
- **A floor on the number of seeded classes** — at least three, spanning distinct
  defect classes — measured before any equivalence exclusion, so that the one
  mechanical-shaped bar in the discipline cannot be cleared by subtraction.

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
precondition of the gate rather than a follow-up to it.

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

The classifier is run in a fixed order, starting from the most general honest
statement: the domain grade is reached only *through* a general statement that was
attempted and found hollow.

Collation is clerical. The collating seat may bounce a defective statement back to
its author and may not improve one.

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
auditor spot-checks relay fidelity on the protected classes.

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

*Anonymized pattern, and it is the sharpest one in the record.* A finding about
record fidelity was relayed with one word dropped — the relay of a fidelity
complaint itself demonstrating the fidelity hazard. Nothing turned on the word,
which is exactly why it is worth keeping: the mechanism failed in the benign case
and was therefore visible before it failed in a case that mattered.

### 4.4 Push at every landing

Committed is not safe. Work is durable only once it is pushed, and the discipline
is to push at every landing rather than at the end of a session.

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
without which the history guarantee is convention), the standing canary power, and
the ratification of the organization itself. A single file tells them how to spot-
check the whole program by hand in four commands.

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
principal — is declined.

The requirement is that the refusal is *recorded with its grounds*, in the
refusing seat's own log, where it can be reviewed and overturned.

**The failure class.** An organization in which every dispatch must produce a
deliverable will get one, including in the rounds where the honest answer was
"this cannot be done from here." The deliverable produced under that pressure is
the most dangerous artifact the system can make, because it looks exactly like the
others. Making refusal ordinary — and requiring it to be argued rather than merely
declared — is what keeps the pressure from converting into quiet non-compliance.

*Anonymized pattern.* A round was commissioned to apply six small cures. Five were
applied. The sixth was a one-word improvement to a sentence that, since the
commissioning, had become live constitutional text — so applying it in the source
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
behavior had been present in a majority of the record.

**Its corollary about warnings.** When the appropriate check turns out to be a
warning rather than a refusal (because the subject is testimony, or because a
blocking check would make legitimate corrections impossible), the honest framing
is: the warning does not buy honesty, it buys **latency** — the next decay is
visible in three entries instead of twenty-four.

**Without it:** every remedy in the record is a claim about the past rather than a
property of the present, and a reader auditing the program's rules cannot tell
which are live.

### 5.2 A column's name is not its definition

**The lesson.** Where a record has columns, the label on a column and the rule
that decides what enters it are two different things, and they drift. A word that
does normative work in a verdict line while appearing in no instrument is a
normative property nobody wrote down.

**The shape.** A tally published a column labelled *sealed*. It excluded an item
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

**The shape.** A finding about record fidelity was relayed accurately but for one
dropped word. Nothing turned on that word, which is precisely why it is a good
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

**The shape.** Dated rows in a frozen record were measured against the commit dates
of the entries they cited. Eight disagreed — by a day, by two days, by four. The
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
constitution as a posture declaration: each clause says whether it is
machine-enforced or review-enforced, and where it is review-enforced, it says so in
its own text rather than in a footnote.

**Without it:** you will build an enforcement layer that is simultaneously
oppressive and porous — refusing things that should be argued, and advising about
things that should be impossible — and its failures will be read as evidence that
process does not work.

### 5.6 Repairs that verify each other belong in one commit

**The lesson.** When two changes are mutually load-bearing — where each becomes
derivable, checkable, or even statable only once the other exists — splitting them
across commits produces an intermediate state in which the record asserts something
that cannot be verified from the tree at that point. Land them together.

**The shape.** A long repair arc produced, among other things, a measurement whose
instance was underivable until a table landed later in the same arc. Read from the
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
obvious form is easy to prevent and the disguised forms are what actually happen:

- **The graded party as its own reviewer.** A residual risk routed to "ordinary
  review" where the ordinary reviewer is the party the rule measures.
- **The document that reads its own source into compliance.** A checklist quoting a
  constitutional clause accurately and extending it silently — the quotation is
  faithful and the source does not say what the checklist needs it to.
- **The author of an exclusion being the party the exclusion benefits.** An
  equivalence exclusion authored and recorded by the party whose measured yield it
  improved, in that party's own packet, with the independent seat's record never
  updated to carry it. The cure: the exclusion takes effect only when the seat
  whose own count it *shrinks* records it — an admission against interest.
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

**The one thing that must not be imported as a claim:** any statement in this
document that a control is mechanically enforced. Check it in your own machinery
before you repeat it. A guarantee inherited from someone else's README and never
verified is exactly the failure of §2.5's declared external dependency, one level
up.

### 6.2 The order that works

1. **Ratify the roles first, adversarially.** Have the charter set attacked from at
   least three lenses before anyone works under it — role coherence,
   enforceability, and readability by the non-specialist who will sponsor it.
2. **Turn on the mechanical layer before the first real work.** Coupling,
   append-only, path isolation, files-list equality, and continuous-integration
   re-verification. Retrofitting these onto an existing history is far more
   expensive, and the history you most want them for is the early history.
3. **Configure the out-of-repository dependency and verify it by live fire** — an
   attempted violation that actually bounces. An unverified protective setting is a
   belief.
4. **Run the enforcement self-test, and add a case with every amendment that
   changes semantics.**
5. **Only then start the work**, and start the harvest cadence with it rather than
   after it.

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


