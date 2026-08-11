# Journal: claude_architect_docs_lead_agent — volume 05

- **Agent**: architect_docs_lead (Opus 5 lead)
- **Charter**: agents/charters/architect_docs_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 05
- **Continues-from**: J-architect_docs_lead-0045
- **Previous-volume**: agents/journals/claude_architect_docs_lead_agent.v04.md
- **Previous-volume-sha256**: 31ed7d295e3dfeb86820642b8ec0f300b745750831c3717a9d1071f2895a5b5e
- **Previous-volume-bytes**: 227077

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Volume 05 of a chain (ADR-0017 §4.3).
Enforced by scripts/agent_commit.sh and CI.
Volume 04 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-architect_docs_lead-0046] 2026-08-11T18:37Z | task:none | The clause I froze last round is redrafted twice before it can be accepted — a negative control taken out of `seeded` at the score-owner's finding, and the frozen-kill asymmetry adopted as a limb because the amendment's own premise never distinguished the outcome it excuses from the one it audits; volume 05 opened one entry before the threshold on a test I did not invent

### Trigger

Orchestrator dispatch, **one round, narrow**: the **pre-acceptance redraft of
`ADR-0020` (b.1)** on dv_lead's `FINDING REC-4`, plus **one decision** — dv_lead's
offered frozen-kill asymmetry, to adopt as a (b.2) limb, adapt, or refuse with
grounds. A **respawn after INCIDENT TEN**: a container restart killed this round's
first spawn mid-write, its partial ADR edit was preserved as evidence in the
orchestrator's scratchpad and **discarded from the tree**. The dispatch's
instruction was that no prior partial exists and everything is derived fresh, and
that is how it was done — the ADR was read whole from the tree at HEAD, not
resumed.

**Abort-first precheck, run before any file was opened.**

    git status --short              # zero lines
    git rev-parse HEAD              # 7611b542fbb0e80804d9d9a045c16308de37f6da
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 18:19:15 UTC 2026

HEAD is `7611b54` — the auditor's act-2 countersignature commit and the SHA the
dispatch expected — the tree is clean, so neither branch of the abort procedure
was reached and no forensic refusal was owed. **One declared sibling: the
orchestrator** (journal/board/site). Nothing else was declared and nothing else
was dirty.

**Honest stamp**: `date -u` at authoring — `Tue Aug 11 18:37:39 UTC 2026`. The
header stamp is that reading truncated to the minute, in the honest direction the
auditor's timestamp round fixed (`J-auditor-0021` §8): stamp before commit, same
date.

**Rotation taken, one entry before the threshold** (§1 measures it): this entry
opens **volume 05** rather than closing volume 04 over the soft ceiling.

### Inputs

Read this round, in order, at `7611b54`:

- `agents/charters/architect_docs_lead.md` — mandatory first action; §3
  (ADR ownership, dispute adjudication), §5 (DoD), §7 (escalation classes), §8
  (journal obligations, ADR coupling, harvest note).
- `agents/PROTOCOL.md` **in full** — §4/§4.1/§4.2 grammar and set-equality, §5
  `R1`–`R9`, §6 write scopes, §7 gates and the `P<n>-module-ready` row the
  amendment moves, §10 mutation discipline and `R-SEAL-1`, §11 amendment
  procedure.
- `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md` **whole**, at
  the tree rather than from any account of it — §0 through §13, with §3's hunk 2
  read twice, once as constitutional text and once as a diff body.
- **The three countersignature acts, verbatim at their commits**, read before a
  character of the redraft was written:
  - `J-rtl_lead-0023` at `62ad337` (act 4, §7.3's generalised limb; `FINDING
    C-RL-10`; the volume-03 rotation and its arithmetic-fit test),
  - `J-dv_lead-0185` at `95c5e2a` (act 3, (b.1)/(b.2)/(b.4)/§4; `FINDING REC-4`;
    the frozen-kill offer; `FINDING REC-5` against itself),
  - `J-auditor-0021` at `7611b54` (act 2, (b.2)/(b.3); `F-0021-1` … `F-0021-5`;
    the merge refusal sustained; the `D-M3` debt accepted and enlarged).
- `scripts/policy.sh` — `JOURNAL_SOFT_MAX`/`JOURNAL_HARD_MAX` at `:13-14` and
  `volume_header_field` at `:154`; `scripts/agent_commit.sh` `:118-142`, the `R10`
  rotation-header checks this file has to satisfy.
- `agents/journals/claude_architect_docs_lead_agent.v04.md` — my own
  `J-architect_docs_lead-0045` Open-questions and ledger rows 70–80, and the
  whole-file entry census §1 measures.

**Not read, and the declaration is standing rather than conditional** (charter
§9): no `libs/**`, `top/**`, `bin/**` or `test/**` source; no mutation branch
fetched and no manifest applied; **no `Essenceia/Nasdaq-HFT-FPGA` material**. This
round made no design decision and reached no module spec.

### Reasoning

---

#### 1. The rotation — taken pre-emptively, on a test another seat minted three commits ago, and honest about which population it measures

**The arithmetic, measured rather than estimated.** Volume 04 stands at **227,077
bytes** on disk and at HEAD (equal — Evidence), against ADR-0017 §5.1's soft
threshold `S` = **262,144**. **Headroom: 35,067 bytes.** Volume 04's four entries
are 58,680 / 60,699 / 66,213 / 40,671 — **minimum 40,671**, mean 56,565. The
smallest entry I have written into this volume exceeds the remaining headroom by
**5,604 bytes**, and this entry — a clause redraft carrying three quoted
countersignatures, a decision with four grounds, and a delta table — is not going
to be the first one smaller than that.

**The test I am applying is `J-rtl_lead-0023` §1's, and I adopt it rather than
inventing my own**: *rotate when the next entry cannot be shown to fit*, which is
an arithmetic test on measured entry sizes and not a preference. Its ground is
ADR-0017 §5.1's design sentence — *"one volume should be one readable unit"* — and
the observation that a chain rotating *after* the crossing leaves exactly one
volume permanently unreadable in a single call, while a chain rotating *before* it
leaves none. My volume 01 (270,152) and volume 03 (296,364) are already two such
volumes; volume 04 need not be a third.

**And one honest complication rtl's own round did not face, which I state rather
than let a later reader find.** rtl measured over its *active volume's* entries.
Measured that way the test is unambiguous here (40,671 > 35,067). Measured over
the **chain's last two volumes**, volume 03's minimum entry is **34,611** — which
would fit the headroom, by 456 bytes, a margin of 1.3%. So the test's answer
depends on the population, and I say which I used and why: **the active volume's
own distribution**, because that is what rtl's precedent measures and because a
456-byte margin against a single outlier entry from a different volume is not a
demonstration that an entry *fits* — it is a hope. The falsifiable form of the
standard I am committing to is rtl's, unchanged: *if the smallest entry in the
active volume does not fit the headroom, rotate.* That is checkable by anyone,
against numbers in the file.

**The four steps, executed** (ADR-0017 §4.4). (1) The predecessor's sha256
computed **from git and from disk independently**, both
`31ed7d29…895a5b5e`, both 227,077 bytes. (2) This file created with the §4.3
header and exactly one entry, `-0046`, continuing the id namespace across the
boundary (§4.2) rather than restarting. (3) Volume 04 **not touched and not
staged**. (4) The two chain fields are re-verified by the committing seat at
commit time; `agent_commit.sh:118-142` is the check both sides have to agree on
and my side of it is in Evidence.

---

#### 2. What I read before touching a word of the clause, and why the order mattered

The dispatch stated the three acts were paid and told me to read all three
verbatim before editing. I did, at their commits, and the order was not
ceremonial: **two of the three findings are against text I wrote**, and the third
is a raise offered by the party it costs. A redraft written from a dispatch's
summary of those would have been a redraft of the summary.

Three things came out of the reading that the dispatch did not contain and that
changed the draft:

- **dv's fourth ground for the §6.4 adaptation, which is against dv's own offered
  clause and which I had not thought of** — *numerator* and *denominator* are the
  vocabulary of a ratio that `SC-5` forbids by name, so a rule stated in that
  vocabulary *"will be applied by forming the forbidden object."* It is the
  strongest of the four grounds and it is the signer's, not mine. It is why §6.5's
  cure is expressed as a **subtraction with itemised members** rather than as
  another sentence about counting.
- **The auditor's `F-0021-5` measurement**, taken for the survivor's sake — the
  bench moved 8,505 insertions / 151 deletions across 15 files since the replay
  base — which is **not survivor-specific**, and which turned dv's frozen-kill
  offer from a symmetry argument into a measured one (§6 below).
- **rtl's `C-RL-10`**, filed against §7.4's em-dash list, whose two readings fail
  in opposite directions. Not this round's — routed to act 7 — but reading it told
  me what a countersignature filed *with* a signature rather than *against* it
  looks like, which is the shape §9.5 had to record for all three.

---

#### 3. `FINDING REC-4` — SUSTAINED, and the third ground is not the whole of the cure

**The finding.** (b.1) defined `seeded` as *the subset rendered against the module
as sealed and run*. `IC-2` (`WO-0063B`) was rendered exactly as sealed and ran; it
reddened eighteen units; **its sealed prediction at its own target is a green**
and its campaign scores it *"0 kills, by design"* under the headline *"one
scoreable class."* Under my definition it is `seeded`, its reds make it *killed*,
the numerator moves 61 → 62, and §10's three-class floor becomes clearable by a
class seeded to stay green.

**Sustained on three grounds, and the third is the one that changed the shape of
the cure rather than its content.**

1. **The numerator consequence is (b.4)'s own sin one level up.** (b.4) forbids an
   assertion no mutation can reach from contributing to a coverage claim, because
   *counting it counts one observation twice*. A class whose seal predicts a green
   at its own target is the same object at the level of a class: its reds are blast
   radius its seal already predicted, and they cannot be evidence that the suite
   catches defects at the thing the class was cut to qualify. **An instrument that
   forbids this at the assertion and permits it at the class disagrees with
   itself** — the defect this file convicts at §1.2 and refuses at §11 alternative
   3. I would have shipped it.
2. **The floor consequence decides it, and it decides it because of *what kind of
   object* a floor is.** A numerator is inspectable: a reader who distrusts it can
   walk the itemised dispositions. A floor is a **pass/fail token** — read once,
   never re-derived. A relief a reader cannot see is worth more to a party under
   pressure than one he can, and §4's floor is the only mechanical-shaped bar in
   the entire mutation discipline.
3. **The pattern is three-for-three, and a third patch was the wrong answer.**
   `REC-3` was the practice's word *scoreable* doing normative work with no
   instrument carrying it. `REC-4` is the same word at a third class. Both times
   the draft was taken from the practice's **columns** while the word lived in its
   **verdict lines**. So the cure is not only the third ground: **the clause now
   says that the list of grounds is open and the naming duty is not** — a class
   excluded on any ground is named at the tally with it, where the gate reads that
   ground and may refuse it. dv's own signature supplies the authority for saying
   so: the operative sentence is *"ground-agnostic and therefore does not need its
   list of grounds to be complete to be correct."* **Leaving that openness implicit
   would have been the third version of the same defect** — a normative property
   nobody wrote down.

**The alternative I rejected and the reason it is not close.** Redefining `seeded`
as *rendered as sealed and run **to be scored*** cures the case in five words. It
also moves the exclusion out of the itemised subtraction and back into an
adjective, so a reader of the seeded number cannot recover which classes the
adjective removed or why — **the unrecoverability §6.4(i) convicts, re-entered
through the definition instead of through a missing column.** Recorded at §11
alternative 15.

**Three adaptations of dv's offered clause, each with its ground** (§6.5):

- **(i) The seal must declare both halves** — the green prediction *and* that the
  class scores nothing. dv's text keys the ground on the prediction alone; a seal
  may predict a green at one assertion while claiming kills elsewhere, and that is
  an ordinary class with a mixed prediction, not a control. `IC-2`'s seal carries
  both halves in terms, so the narrowing costs the record nothing and closes a hole
  the wider form leaves open.
- **(ii) §12.5's pre-run guard becomes a condition rather than advice**, for
  `UNSCOREABLE` and the control ground alike. The negative-control ground needs it
  *more*: `UNSCOREABLE` at least turns on a **falsified** disclosure, which
  requires the disclosure to exist, while a control is simply **declared**. The
  raise convicts nothing in the record — `I-c1`'s pre-run disclosure is on record
  and `IC-2`'s control status is in its sealed-predictions file before either lane
  ran — so it takes no grandfathering clause, unlike (b.3), whose prospectivity
  exists because `D-M3` fails a limb.
- **(iii) Third item of one list, not a clause of its own** — §6.4(ii)'s ground
  applied a second time: one disposition with a list of grounds cannot drift.

---

#### 4. The knock-on arithmetic — confirmed as arithmetic, and still not published as a figure

The dispatch asked me to confirm or correct dv's arithmetic in the ADR's own
worked example. **The ADR carries one**, at §1.1: *63 sealed − 1 never seeded = 62
seeded = 61 killed + 1 survived.*

**Under the cured definitions that partition is wrong, and the direction is
counter-intuitive**: the numbers that move are not the ones a reader expects.
dv's derivation (`J-dv_lead-0185` Reasoning §4) gives **sealed 65** — 64 classes
rendered, one per branch, all diffs distinct, plus `IC-M5` sealed and never
rendered — with **three itemised exclusions** (`IC-M5`, `I-c1`, `IC-2`), leaving
**seeded 62 = 61 killed + 1 survived**. **The seeded figure and the kill count do
not move at all.** What moves is `sealed`, 63 → 65, because two classes that today
sit in *no column* are restored to the one that records sealing.

**What I did and did not do with it.** I **confirm the arithmetic**: 65 − 3 = 62,
61 + 1 = 62, internally consistent; and I note it **disposes of the auditor's
Open-question 4 by construction** — 64 refs against a 63-row tally was two kinds of
object being counted, and 64 rendered + 1 never rendered = 65 is the class-side
count the refs were never a proxy for. I **do not assert the figures**: the
class-level walk behind the 64 is dv's, I have not re-walked ten campaign packets,
and §13's rule stands — a rule author who publishes the numbers his rule produces
has graded his own instrument. So §1.1 now carries the re-partition **quoted to the
seat and the entry that own it**, and it carries it *there* rather than in §6
because a reader who meets the exact `63 − 1 = 62` first must not be able to carry
it forward as the partition the clause now prescribes.

---

#### 5. The decision — the frozen-kill asymmetry, ADOPTED as a (b.2) limb

**The offer** (dv, against its own interest, site left to me): the clause applies
the score ≠ capability premise to survivals only; *"a campaign kill is also a
frozen measurement, and the honest cure is that a campaign-killed class is
dispositioned by its campaign record **plus the named killing unit present and
green at the gate SHA**."*

**ADOPTED as a limb.** Four grounds, in increasing weight, at §6.6:

1. **The premise does not distinguish the outcomes.** §1.2's argument is that a
   frozen score and a present capability are different objects. Nothing in it is
   about survivals. 61 of 62 dispositions are frozen measurements from transient
   trees that no longer exist, offered as answers to a present-tense question.
2. **The hazard is measured, by a seat that owns neither the score nor the
   suite.** The auditor measured 8,505 insertions / 151 deletions across 15 files
   and 248 RTL insertions since the replay base — for the *survivor's* sake. That
   movement is not survivor-specific. **The same 8,505 lines sit under all 61
   kills**, and the drafted clause would have accepted every one by citation.
3. **A §12 note would name the hazard and leave the constitution accepting frozen
   answers for 61 of 62 dispositions.** §12 is where this file records what its
   clauses *cannot* reach. And the general rule was reached **twice in one round by
   two independent seats** — the auditor banked it as a harvest candidate in almost
   the same words (*a present-tense requirement decays into a citation rule*) — and
   a rule two seats reach independently is not a footnote.
4. **It was offered by the constrained party against its own interest**, which is
   §7.2's own account of a countersignature worth having. Refusing a raise offered
   by the party that pays for it, inside an amendment whose §9.4 must answer a
   charge of self-service, would be indefensible.

**Calibration, and it is dv's not mine**: the kill form is *presence and
greenness*, **not a replay**. The ground is worth stating because it is what stops
the limb from being either theatre or ruin: **a rehabilitation reverses the
record's own measurement and therefore needs a new one; a kill's disposition
preserves that measurement and needs only that the instrument which made it still
stands.** Demanding 61 replays would also collide with §10's transient model — each
replay is an orchestrator-applied manifest in an uncommitted tree — and would turn
a gate into a campaign.

**Bound, written into the clause and not into §12**: presence-and-greenness
catches a killing unit **deleted or disabled**; it does **not** catch one
**weakened**. That sentence lives in the clause deliberately, because a form whose
limits are recorded in a different document is exactly how a raised bar decays
into the citation rule ground 3 names. §12.8 records what the residue costs and
who catches it (review, in `test/**`, where a loosened assertion is visible in a
diff).

**One cost I do not minimise and have not verified.** The limb lands work on the
gate record this amendment enables: the killing unit must be named per killed
class. dv says that is *"one table"* because *"the campaigns already name the
units."* **That estimate is the score-owner's and I have not checked it.** If it is
wrong the cost falls on dv's own packet — which is where the offer came from, and
is why the unverified estimate is not a reason to hesitate. Recorded at §13 as
undecided, not assumed.

---

#### 6. The two readings — written into the clauses, per clause, and one word adapted against the signer

The dispatch offered a choice: write the readings in, or record them as
signature scope with a pointer. **Both written in**, for different reasons (§6.7).

**(b.2)'s survivor definition.** The trigger was undefined, and its natural
reading — *a seeded diff the suite did not kill* — is wider than the set the
evidence form was built for. **An undefined trigger inside an evidence clause is
the surface a party under gate pressure works on**; the auditor named the identical
hazard on the same clause's other side and answered it with a construction in its
journal. A construction in a journal binds a reading; a sentence in the clause
forecloses it. And (b.2) was being reopened for the frozen-kill limb anyway, so
both movements travel on one delta-signature rather than two.

**The half deliberately left out, because the cure delivers it structurally**: *a
control is not a survivor* is now a consequence of (b.1) — a control is not in
`seeded`, and (b.2) quantifies over seeded mutations. Restating it inside (b.2)
would give one disposition two homes, which is the shape §6.4(ii) refuses.

**The one word adapted, and it is adapted against the signer.** dv's definition
says the seal predicted a kill *at a named unit*; my clause says the seal predicted
a kill. **Adding *at a named unit* would narrow the survivor set** — a seal
predicting a kill without naming a unit would put its mutation outside the
definition and therefore outside the heavier evidence form. That is a relief, and
**a relieving qualification does not travel on the ground offered for a defining
one.** The narrower form remains available on its own ground; it does not ride
this one. Marked in the delta.

**(b.4)'s predicate**, written in **in the signer's own words**, because the
disagreement dv found is between this instrument's **narrative** (§5: *unreachable
by any mutation*) and its **operative text** (*no seeded mutation can reach*) — a
rule/check disagreement of exactly the kind this file convicts twice. An instrument
that ships with one of its own has argued itself out of its own authority. The
predicate now reads *no mutation of the module can reach — because the design's
structure forecloses it, or because the specification leaves its case
unconstrained*, which are the two grounds the record actually contains
(`DECLARATION WO-0074-D1`; `M03-J4`'s `UNQUALIFIABLE BY SPECIFICATION`).

**And the residue is routed on its own ground rather than by symmetry.** dv's
sentence disposes of the merely-unreached assertion as *"a seeding gap and …
dispositioned as one"*, and (b.3) routes its analogue to (b.2). **(b.2) is the
wrong home here and I decline the symmetry**: (b.3)'s residue is a *mutation*,
which (b.2) quantifies over; (b.4)'s residue is an *assertion*, which (b.2) does
not reach at all. The clause therefore states the consequence actually available —
**such an assertion may not be entered in the unreachable set** — instead of
pointing at a clause that cannot dispose of it. That formulation is mine, not the
signer's, and it is marked in the delta accordingly.

---

#### 7. What I did not take, and why the routes are the point

Three items reached this round that a redraft could have absorbed. **None was
taken**, and the reason is the same in each case: **each was routed by its own
filer to a place that is not a clause**, and a redraft that quietly absorbed
findings routed elsewhere would make the routes unreadable and the filers' own
dispositions untrue.

- **`F-0021-3`** (auditor, MAJOR): (b.3) requires publication nowhere while (b.1)
  and (b.4) both require it. **The finding is right** — and its filer routed it to
  the gate-record form owed at §10 item 2, expressly *"not to a redraft"*, having
  first stated the construction under which it countersigns. It is my ledger row 78
  and it lands with the form, after acts 5–6.
- **`C-RL-10`** (rtl_lead, non-blocking): §7.4's em-dash list has an undeclared
  status and its two readings fail in opposite directions. Routed to **act 7**,
  which is where the text it is filed against actually lands, and which postdates
  the signature that filed it.
- **`F-0021-1`** (auditor, MINOR, against the orchestrator's dispatch): (b.3) was
  described as carrying the `G-9` adaptation; the instrument puts it in **(b.4)**.
  **The instrument was right and is unchanged.** I recorded it at §9.5 because a
  route error that lives only in traffic will be inherited by the next
  transcription of that traffic — and the transcription in question is the one that
  writes the constitution.

**One thing I did take, and it is a correction to my own prose**: dv's §4.1 note
that *"the floor survives verbatim in substance"* overstates it, because the
floor's **unit** moved from *kills* to *seeded classes* — so a module now clears
it with two campaign-time kills where the survivor is rehabilitated. Offered as *"a
precision I would want on the record next to a floor"* and not as a condition of
signature. **Taken**, with the movement stated as intended and defensible, and with
the two guards that keep it from cheapening further named beside it. And while
rewriting that section I found a transposition in my own arithmetic prose — it said
the third hunk's offset reflected *"the 34 lines the second adds"* where the offset
was 43. **Never in a header**, which is why both prior checks were green; corrected
and stated rather than silently fixed.

---

#### 8. The delta, and why marking it is the whole of the honesty here

Three clauses moved **after** three signatures were formed against them. A
signature covers the text at the SHA it was formed against, so:

- **(b.1)** re-owes **dv_lead** — the finder's own cure, adapted in three
  respects; §9.2 act 3's ground applies word for word (*the adaptation is exactly
  the seat that filed it to check*), and this is the second consecutive round in
  which that is true.
- **(b.2)** re-owes **the auditor a delta-signature, plainly.** Act 2 signed it as
  *"my own `G1-b` returned unwidened"*, and the frozen-kill limb is a thing `G1-b`
  did not contain. The constrained party has not seen it. **I say this in the
  instrument in those words** (§9.5, and D3 names it too) because the one thing
  §9.2 forbids absolutely is recording traffic as paid before it is.
- **(b.4)** re-owes **nobody on the predicate** — signer's own words, moving
  toward the offering seat's original text — and **dv_lead on the seeding-gap
  sentence**, which is my formulation.

**What the delta does not do**, and I state it because a redraft can otherwise
look like a reset: it does not unpay the three acts. Every verdict stands on the
text it was formed against, no clause moved *against* the seat that signed it —
(b.1) moved as its finder asked, (b.2) as its offerer asked, (b.4) as its signer
read it — and act 5 is not gated: the orchestrator may accept with owed traffic
recorded as owed. **The contest window reopens on the moved text only** (§9.3),
because each answer preceded its clause's movement.

---

#### 9. The self-serving check, re-run against the redraft

§9.4 offers four checks a later reader can run rather than assurances, and a
redraft performed mid-route by the amendment's author is exactly where a fifth
would be wanted. So I ran the existing four again and recorded the result in the
file: **item 3's tally moves.** (b.1) now narrows on a **third** ground that is
*not* derivable from the word `seeded` — a negative control **is** rendered as
sealed and run — so this is a genuine relief and not a reading of an existing word.

**The direction is the answer.** The third ground moves the numerator **down**,
62 → 61, on the very record this file was drafted around; it makes the floor
**harder** to clear; and (b.2)'s new limb lands a present-tense evidence duty on
**all 61 kills** where the drafted clause demanded one for a single survivor.
**The redraft costs the token it was accused of buying**, at the request of the
seat whose score pays for it. That is not proof of good faith — nothing is — but
it is a check that would have failed had the redraft gone the other way.

---

#### 10. Harvest

**Not due, and declared rather than skipped** (charter §8, `PROTOCOL` §7): this
round is neither an `SO-` nor a phase gate. My open span continues —
`J-architect_docs_lead-0042` … (open) — and this entry joins it, so the spans tile
and a skipped harvest would be a visible gap. **Two candidates banked now**, both
LH1–LH3 discharged, both **LH2-g** (no proper noun of any kind):

- **(f)** *A rule that lists the grounds on which items leave a scored population
  must say whether the list is closed; a list left silently open is discovered by
  the third item that needs a ground the list does not have, and each discovery
  arrives after the rule has been signed.* **LH1**: this round's `REC-4`, arriving
  against a clause corrected one round earlier by `REC-3` for the same underlying
  reason. **LH2-g**: no proper noun. **LH3**: without it, every new case is a fresh
  amendment round and the parties in between either mis-file the case or exclude it
  on a ground no instrument carries.
- **(g)** *When a rule demands that evidence be current at a decision point, it
  must say so for every outcome the decision reads, or it has silently made the
  unfavourable outcome expensive and the favourable one free.* **LH1**: this
  round's frozen-kill asymmetry — a replay demanded of the one survivor and
  citation accepted for sixty-one kills, under a premise that distinguishes
  neither. **LH2-g**: no proper noun. **LH3**: without it the cheap direction
  becomes the default answer and the expensive one becomes the thing parties avoid
  producing, which inverts what the evidence rule was for.

A third is **noted and not banked**, because I cannot yet state it without a
project noun: the observation at §1 that a threshold test's answer depends on the
population it is measured over, and that the population must therefore be part of
the test rather than of its application. I will re-test it at the next rotation.

### Actions

- Ran the abort-first precheck; read charter and `PROTOCOL` in full; read
  `ADR-0020` whole at the tree; read all three countersignature entries verbatim
  at `62ad337`, `95c5e2a` and `7611b54` before editing.
- **Redrafted `ADR-0020` §3 hunk 2**: (b.1) gains the negative-control ground, the
  both-halves requirement, the pre-run-freezing condition and the
  open-list/closed-duty sentence; (b.2) gains the survivor definition and the
  frozen-kill limb with its bound; (b.4)'s predicate narrowed to
  structural-or-specification unreachability with the seeding-gap sentence.
- **Re-derived the three hunk headers and re-ran the ADR's own machine check**:
  hunk 2 `@@ -264,5 +264,69 @@`, hunk 3 `@@ -338,5 +402,7 @@`, `git apply --check`
  exit 0 with no offsets. Updated §4.1's table, its recipe and its stat line to the
  measured figures, and added the two properties of the recipe that
  `J-dv_lead-0185`'s `REC-5` shows are load-bearing.
- Wrote §6.5 (`REC-4` sustained, three adaptations), §6.6 (the frozen-kill
  decision), §6.7 (the two readings, per clause), §9.5 (the traffic paid and the
  delta owed), §12.7 and §12.8 (two new failure modes), six new §11 alternatives,
  four new §13 items; amended §1.1's worked example, §4.1's floor paragraph, §2's
  D3 and new D10/D11, §0's table note, the Status and Deciders blocks, and §10's
  owed acts 2–4 so that the debts stay truthful (item 2 gains the third ground and
  `F-0021-3`'s routed cure, item 3 gains `C-RL-10`, item 4 records its owner's
  acceptance and enlargement).
- **Renumbered nothing.** §7–§13 keep their numbers because three committed
  countersignatures cite them.
- Built every preview **outside the repository** and ran `git apply --check` only;
  `agents/PROTOCOL.md` was never written and the tree carries exactly one modified
  path.
- Wrote this entry, opening volume 05. **No `git commit`, no `git push`, no
  staging. No stop-hook commit demand was honoured.**

### Evidence

All commands from the checkout at `7611b54`; the working tree carried exactly one
modified path (the ADR) from the first edit to this line.

**Precheck and stamps:**

    $ git status --short                 # zero lines, at entry
    $ git rev-parse HEAD
    7611b542fbb0e80804d9d9a045c16308de37f6da
    $ git rev-parse --abbrev-ref HEAD
    claude/fpga-hardcaml-agent-orchestration-37ceyf
    $ date -u                            # entry 18:19:15Z, authoring 18:37:39Z

**The three countersignature acts, read at their commits** (not from the
dispatch's account of them):

    $ git show 62ad337 --stat            # rtl_lead v03, 755 insertions, journal-only
    $ git show 95c5e2a --stat            # dv_lead v10, 719 insertions, journal-only
    $ git show 7611b54 --stat            # auditor v02, 672 insertions, journal-only
      → all three Journal-Only: true, Files-in-this-commit "- (none)"

**The ADR's own §4.1 machine check, re-derived at this HEAD after the redraft**
(patch bodies extracted from the ADR's own text, so a retyped copy cannot pass;
extraction written **outside the repository**, apply is `--check` only):

    $ python3 - <<'EOF'   # same extraction as §4.1's awk, writing to the scratchpad
      ... blocks: 3 ; h1: old=3 new=3 ; h2: old=5 new=69 ; h3: old=5 new=7
    EOF
    $ { headers @@ -254,3 +254,3 @@ , @@ -264,5 +264,69 @@ , @@ -338,5 +402,7 @@
        interleaved with h1/h2/h3.diff } | git apply --check -v -
    Checking patch agents/PROTOCOL.md...          APPLY_CHECK_EXIT=0
    $ ... | git apply --stat
     agents/PROTOCOL.md | 72 ++++++++++++++--  1 file changed, 69 insertions(+), 3 deletions(-)
      → exit 0, no offsets, no fuzz. Pre-redraft the figures were 48 insertions and
        headers @@ -264,5 +264,48 @@ / @@ -338,5 +381,7 @@; both prior checks were
        green and both are superseded by these.
    $ git status --short
     M docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md
      → agents/PROTOCOL.md untouched in the tree, before and after.

**Rotation arithmetic** (ADR-0017 §4.4, §5.1; the test at `J-rtl_lead-0023` §1):

    $ wc -c agents/journals/claude_architect_docs_lead_agent.v04.md
    227077                                  # vs JOURNAL_SOFT_MAX 262144 → headroom 35067
    $ per-entry byte sizes of v04 (computed over the file)
    0042: 58680   0043: 60699   0044: 66213   0045: 40671   → min 40671, mean 56565
      → min − headroom = +5604: no entry of this volume's own distribution fits.
    $ per-entry minimum of v03, stated because it complicates the test
    34611                                   # would fit, by 456 bytes (1.3%)
    $ sha256sum agents/journals/claude_architect_docs_lead_agent.v04.md
    31ed7d295e3dfeb86820642b8ec0f300b745750831c3717a9d1071f2895a5b5e
    $ git show HEAD:agents/journals/claude_architect_docs_lead_agent.v04.md | sha256sum
    31ed7d295e3dfeb86820642b8ec0f300b745750831c3717a9d1071f2895a5b5e
      → equal, and equal to this volume's Previous-volume-sha256 header field;
        Continues-from J-architect_docs_lead-0045 = v04's last entry id.
    $ wc -c agents/journals/claude_architect_docs_lead_agent.v05.md
    42630                                   # this entry, measured before this line
      → the pre-emptive test is confirmed after the fact as well as before it:
        appending 42,630 bytes to v04 would have crossed S by 7,563. The estimate
        was the volume's own minimum (40,671) and the realised entry exceeded it.

**No suite was run and none is claimed.** This round touched no file under
`test/`, `libs/`, `top/` or `bin/` and can move no test result; the whole-suite
verdict remains CI's (ADR-0005). The extracted hunk files and the assembled patch
are **ephemeral artefacts** in the session scratchpad (ADR-0003/F5), staged
nowhere; the reproducible part is the extraction recipe printed at ADR §4.1 and
the `git apply --check` above.

### Outcome

**DoD met for the dispatched round: the (b.1) redraft is written, the decision is
taken with grounds, the knock-on arithmetic is checked, both stated readings are
disposed of per clause, and the delta the movement re-owes is marked in the
instrument rather than left to a reader to notice.**

**The delta, clause by clause, as it must be relayed:**

> **(b.1)** — third ground added (**negative control**: seal predicts a named
> assertion stays green *and* declares the class scores nothing → sits in `sealed`,
> not in `seeded`, named at the tally with its ground; its run supports the
> qualification it was cut for and no coverage claim in either direction).
> Pre-run **freezing of the disclosure** made a condition of both
> disclosure-grounded exclusions. **List of grounds declared open; naming duty
> closed; the gate may refuse a ground.** **Re-owes dv_lead.**
>
> **(b.2)** — *survived its own campaign* **defined** (seal predicted a kill and
> no unit killed it; *at a named unit* deliberately not carried, because it
> relieves). **Frozen-kill limb ADOPTED**: a class killed in its own campaign is
> dispositioned by its campaign record **plus the named killing unit, present and
> green at the gate SHA**, with the honest bound in the clause (catches deletion
> and disablement, not weakening; not a re-run). **Re-owes the auditor a
> DELTA-SIGNATURE** — act 2 signed `G1-b` returned unwidened and this limb is not
> in `G1-b` — **and dv_lead** on the adapted word.
>
> **(b.4)** — predicate narrowed to **no mutation of the module can reach**, by
> structure or by the specification leaving the case unconstrained; an assertion
> the seeded set merely happened not to reach **may not be entered in the
> unreachable set**. **Re-owes nobody on the predicate** (signer's own words,
> moving toward the auditor's original `G-9` text); **re-owes dv_lead** on the
> seeding-gap sentence, which is this seat's formulation.
>
> **(b.3), §4's hunk, §5, §7, §8 — unmoved.** `F-0021-3` and `C-RL-10` are left on
> the routes their filers chose (gate-record form; act 7).
>
> **Apply-check at `7611b54`: exit 0, no offsets**, headers
> `@@ -254,3 +254,3 @@` / `@@ -264,5 +264,69 @@` / `@@ -338,5 +402,7 @@`,
> 69 insertions / 3 deletions. **The §4.1 figures quoted in the two
> countersignatures (48 insertions) are pre-redraft and superseded.**

**Handoff**: to the orchestrator for commit — one work product, this journal's new
volume, trailers `Agent: architect_docs_lead`, `Work-Order: none`,
`Journal-Entry: J-architect_docs_lead-0046`, and a rotation commit under `R10`
(volume 04 frozen and unstaged; the two chain fields are verified independently at
commit time). **Nothing is in force and no gate item closes.** The clause the
orchestrator would apply at act 6 is the one checked above, not the one the
countersignatures quote.

### Open-questions

Ledger rows 76 and 78–80 carry from `-0045`; only moved and new rows are
reproduced, for the reason stated there.

| # | Item | Owner | Closes by | Status this round |
|---|---|---|---|---|
| 76 | The three wrapper transmit composites are derivable and unpinned | me | the round that pins them at SPEC-M16/M19/M20 §7, or says in terms that it will not | carried, untouched: this round reached no module spec |
| 78 | **The gate-record form owed by `ADR-0020` (b.1) and (b.4)** — the explicit `seeded` number, the itemised `sealed − seeded` difference with each ground, the unreachable set beside the tally, §0.1's stale quotation | me | the round after the orchestrator applies the §3/§4 hunks | **grown, not moved.** The difference now has **three** grounds to itemise, and the auditor's `F-0021-3` routes the **equivalence exclusions** into the same form — its filer's chosen cure. Still not taken: §0.2 forbids the checklist carrying a condition its source does not yet contain |
| 79 | **`SPEC-TEMPLATE` §13's countersignature rule is source text in an ADR, not where its readers are** | me | act 4 (paid), then the template edit + the `requirements.md` §13 pointer | **unblocked and enlarged.** rtl_lead's act-4 signature is paid, so act 7 may proceed — and it now carries `C-RL-10`, which asks that the em-dash list's status be declared and the *normative-text-in-the-constrained-party's-own-instrument* test imported. Both are that round's, not this one's |
| 80 | **`D-M3`'s exclusion is sound and its seeder never recorded it** | auditor | one paragraph in `docs/reports/audit/WO-0041-mutations/README.md` | **accepted and enlarged by its owner** (`J-auditor-0021` §9): the note must also record that the README's own divergence claim at `:325-326` and `:354-360` is falsified by the proof, as an **added note, never an edit** of the frozen pre-run text |
| 81 | **The delta this redraft re-owes** — the auditor's delta-signature on (b.2), dv_lead's on (b.1), on (b.2)'s adapted word and on (b.4)'s seeding-gap sentence | those two seats | their next entries, or act 5 landing with the traffic recorded as owed | **new this round.** Marked in the instrument at §9.5 and in D3. It does not gate act 5 and it must not be recorded as paid before it is |

1. **The redraft re-owes signatures and the round that pays them has not been
   commissioned.** §9.2 permits acceptance with owed traffic; the auditor has not
   seen (b.2)'s new limb at all, and it is the limb that constrains **its** future
   gate acts alongside dv's. **If act 5 lands first**, the constitution acquires an
   evidence duty over 61 dispositions that neither constrained party has read in
   its final form. That is permitted, it is the `FINDING Q-3` precedent, and it is
   worth a second look for the same reason it was last round: the precedent is
   mine.
2. **The negative-control ground is the cheapest exit from a denominator this
   instrument now contains**, and its guards are pre-run disclosure and
   publication at the tally (§12.7). **Neither is decisive against a party willing
   to declare a real defect class a control before the run.** The structural
   compensator — that a control's own qualification fails loudly if its target
   reddens — is a property of how controls are used here, not a rule, and I could
   not make it one without inventing a duty nobody offered.
3. **`REC-3` and `REC-4` are the same defect at two classes and I have no way to
   know whether there is a third.** The cure (an open list with a closed naming
   duty) is designed for that ignorance rather than against it. **The check I could
   not run** is a walk of the campaign verdict *lines* — as against their columns —
   across all ten campaigns, which is where both missing words lived. It is dv's
   record and would be dv's walk; I record the shape of the check rather than
   commissioning work I cannot commission.
4. **Item 70's ruling now has a second instance and I should say so before someone
   else does.** The ruling is that an ADR is owed when a change moves a **reading
   rule**. This round moved three: what `seeded` means, what *survived its own
   campaign* means, and what *unreachable* means. **All three moved inside an ADR,
   pre-acceptance, which is the one place the ruling is trivially satisfied** — but
   the next such movement that arrives as a cure inside an already-ruled rule will
   test whether the ruling's second limb (*not owed for a cure inside a rule already
   ruled*) is doing work or is a licence.

### Files-in-this-commit

- docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md

## [J-architect_docs_lead-0047] 2026-08-11T19:34Z | task:none | Act seven lands the rule its own filer widened against himself, and the cure basket pays four of six — one stopped at the constitution's edge because the word it would fix is now applied text, and one added back that the relay dropped

### Trigger

Orchestrator dispatch, **one round**: `ADR-0020` §9.2 **act 7** — the
`SPEC-TEMPLATE` §13 landing the route scheduled after act 4 — plus the **cure
basket** the acceptance act routed to this seat (`J-orchestrator-0261`): `C-RL-10`
(rtl_lead), `REC-6` and `REC-7` (dv_lead), `F-0022-1` and `F-0022-2` (auditor).
`ADR-0020` is **in force**: acceptance at `J-orchestrator-0261` (`dde0511`),
hunks applied at `J-orchestrator-0262` (`a76e485`). The dispatch required both to
be **verified before editing**, and required that any cure touching the applied
constitution text **stop** and return as an Amendment `A1` candidate rather than
be performed.

**Abort-first precheck, before any file was opened.**

    git status --short              # zero lines
    git rev-parse HEAD              # a76e485d1abbdb56eff40acadb1b35f6574330e2
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 19:22:18 UTC 2026

**The declared sibling landed mid-round and was re-checked rather than assumed.**
HEAD moved to `95bf07b` (`J-orchestrator-0263`, the board flip) while this entry
was being written. Verified: a descendant of `a76e485`; touching
`tasks/BOARD.md`, `site/**` and the orchestrator's own journal; **zero files under
`docs/`**. My two working-tree files were unaffected, and both of this round's
measurements were re-run at `95bf07b` and returned identical figures.

### Inputs

- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` (whole, at
  `a76e485` — i.e. **with** the §7 Mutation record applied, which is the text this
  round had to avoid contradicting).
- `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md` — §0, §2, §3,
  §7 whole, §9.2, §9.4, §9.5, §10, §12.7, §12.8, §13.
- `docs/specs/SPEC-TEMPLATE.md` (whole); `docs/specs/requirements.md` §13 rows
  applying `C-43` (five occurrences of *"different axes"*).
- The four filings, read at their own committed artefacts and not from the
  dispatch's summary: `J-rtl_lead-0023` (`C-RL-10`, `62ad337`);
  `J-dv_lead-0186` (`REC-6`, `REC-7`, and the concurrences, `6019846`);
  `J-auditor-0022` (`F-0022-1` … `F-0022-5`, `78f83d6`).
- `J-orchestrator-0261` and `-0262` — the acceptance act and the application act,
  read for what they put in force and for the owed-traffic list.

### Reasoning

**1. The two dispatch claims were verified before a byte moved, and one of them is
what stopped a cure.** `dde0511` carries `Journal-Entry: J-orchestrator-0261`
under `Agent: orchestrator`, journal-only; `a76e485` carries `-0262` and stages
`agents/PROTOCOL.md` at **69 insertions / 3 deletions**. So (b.2) is no longer a
proposal in an ADR: **its words are the constitution's words**, and
`agents/PROTOCOL.md:307` now reads *"together with the named killing unit, present
and green at the gate SHA"* — the exact phrase one of the routed cures would have
edited.

**2. `F-0022-2` is therefore STOPPED and returned, not performed.** The cure
(*"the named killing unit"* → *"unit or units"*) is right on the merits: the
auditor measured three of eight classes in one campaign with no unique referent
(`F-c1` four units, `F-c2` nine, `F-c8` one of three required), dv_lead sustained
it, withdrew its own construction `C3`, and both constrained parties now sign
under the plural reading. But the phrase exists in exactly two places, and they
are **the same sentence**: §3's source-text hunk and `PROTOCOL` §7. Editing the ADR
alone would leave the authority and the constitution disagreeing about what
compliance is — **the precise defect this instrument convicts three times**
(§1.2, ADR-0017 §1.2, and its own §11 alternative 3) — and editing `PROTOCOL` is
outside this seat's write scope, refused mechanically by `policy.sh`, and
forbidden by the dispatch. A one-word improvement bought with a rule/check
disagreement in the constitution is not a bargain. **The honest route is the one
§9.3 states for exactly this case**: after acceptance a contest routes to an
**Amendment `A1`**, drafted by this seat under §11, whose hunk the orchestrator
applies. I hold the draft rather than smuggling it. **The finding is not left
unattended meanwhile**: its filer routed the *width* question to dv_lead, dv_lead
adopted the auditor's construction (*the referent is the campaign record's own
naming*) and owes the plural naming in its own disposition table
(`J-dv_lead-0186` Open-question 4) — so the operative half is already being paid
in the packet where the width actually falls.

**3. `C-RL-10`: sustained in both halves, and the half that costs its filer is the
half that proves it is not self-serving.** rtl_lead's finding is that §7.4's
em-dash list had **no declared status and both readings break** — definitional it
omits the RTL line's third act (`RV-` acceptance) and routes such a clause to
nobody; illustrative-with-the-general-phrase-as-trigger it reaches every normative
sentence of every specification and would have owed rtl_lead a signature on
editorial rows the record settled without one. I sustained both halves and I
re-ran the filer's own self-service check rather than accepting it: **the two
halves move in opposite directions** — declaring the list illustrative *widens*
the trigger (new traffic to rtl_lead, which it asked for), importing `C-43`'s test
*narrows* it. A finding that only ever reduced its filer's obligations would be
one to distrust.
**Why the imported test and not a class filter**: rtl_lead refused the
editorial/behavioural filter **in advance**, and the record refutes it
independently — five committed `requirements.md` §13 rows are editorial by that
table's own test **and** owe dv_lead's re-countersignature, so a class filter would
convict five conformant rows. `C-43`'s ruling is that *the class and the
countersignature question are different axes*, and the landed text now says so in
terms so the next author meets the refusal instead of rediscovering it.
**What I added beyond transcription is marked as mine**: the gloss *the document
that party builds from, commissions from, or derives tests from* generalises
`C-43`'s *"own instrument"* from its two committed instances to a class, because
the test is otherwise inoperable for a line that neither derives tests nor
commissions them. It is marked in §7.6 as this seat's formulation precisely so it
can be attacked rather than absorbed — the practice §6.7 established when a
signer's word was adapted.

**4. What act 7 re-owes: nothing, and the argument is measured.** Both halves are
the constrained party's own words in the constrained party's own committed
artefact. No signature dv_lead holds is reduced: **the rule being amended has
never been in force anywhere** (§0's §7 row — its landing *is* this act), so no
traffic that ever ran is redirected; the imported test is the one dv_lead's own
instrument already states and under which dv_lead's re-countersignature was ruled
**owed** five times; and §7.3's bound 2 (`P<n>-spec-freeze` unmoved) is restated
verbatim in the landed text. The one thing dv_lead has not seen is the gloss, and
I named that as a contestable sentence rather than letting it ride.

**5. `REC-6` — the six-word cure, and why a MINOR copy-edit was worth the round.**
`D5` recited *"no seeded mutation can reach"*, the exact predicate dv_lead's act-3
narrowing convicted and the redraft removed from (b.4), which now reads *"no
mutation of the module can"*. Under the superseded wording an assertion the seeded
set merely happened not to reach would qualify as unreachable — which is the
**seeding gap** (b.4) expressly bars from the unreachable set. So the recital was
not merely stale: it licensed the miscount the clause exists to block. Cured to
match §3 exactly. **I took dv_lead's explicit warning and did not "fix" §5**: its
*"the clause deliberately does not distinguish"* is a claim about **consequence**
— both causes yield the same treatment — and survives a predicate that names both.
Census after the edit: `no seeded mutation` returns **zero** hits outside journals.

**6. `F-0022-1` and `REC-7` — two uncaught modes, named where their filers routed
them, and re-measured rather than transcribed.** The auditor's 5-of-37 and
dv_lead's `T-`/`M03-` split both reproduce at this HEAD under the filers' own
methods. I state them in §12.8 with the **counter-argument each filer supplied**,
because a failure-mode section that reports only the prosecution case is an
advocacy document: (b.1) makes the record's unit the **class**, not the diff, so a
stale rendering is not proof of a stale class, and **nobody has measured which of
the five are which** — I say so rather than implying the five are dead classes.
The `git apply --check` cure is named as **available, not imposed**, because
`P1-module-ready-checklist.md` §0.2 forbids that file from carrying a condition
its cited source does not contain and this source contains none; imposing it would
be the `lessons-harvest-block.md` line-5 defect a third time. `REC-7`'s
disposition stays dv_lead's — the era mapping per class belongs in its table, and
the sentence here names the mode, which is all its filer asked for.
**Both are recorded as re-owing no signature**, which is what both filers said in
their own artefacts: narrative, not source text, no window reopened.

**7. `F-0022-5` was added back after the relay dropped it, and that is the
judgement call of this round.** The dispatch's basket and the acceptance act's
OWED list both omit it. Its filer's committed artefact routes it to **`ADR-0020`
§12.8 / architect_docs_lead** — the same section, the same seat, the same round —
and dv_lead concurred *against its own independence* (*"I do not contest the
enlargement; I ask for it"*). The defect is real and I was editing the convicted
sentence: §12.8 routed the weakening residue to `RV-`/`SO-` review as *"visible in
`test/**`"*, and `PROTOCOL` §6 gives `test/**` to dv_lead and makes dv_lead
tb_writer's reviewing lead — **the party the mutation record grades cannot be its
own check**. Shipping a rewritten §12.8 that kept that routing, with three seats
on record against it, would have been worse than exceeding a basket by one
sustained finding. **It re-owes nothing**: it enlarges its own filer's duty at its
filer's request, and the concurring party is the one relieved of a control it did
not want. I record the addition here rather than performing it quietly — a relay
that drops a routed finding is corrected against the record, which is the same
move §9.5 made when a relay error entered from the other direction.

**8. What I refused to do, recorded because refusals are the load-bearing part.**
(a) **`agents/PROTOCOL.md`** — not opened, not staged; zero files outside `docs/`.
(b) **`docs/specs/requirements.md` §13's pointer**, which §10 item 3 makes the
other half of act 7. It is inside my write scope but the dispatch opened two paths
and named no third. A dispatch narrower than a write scope is a legitimate
narrowing, and the cost of honouring it is one visible round of debt — so I marked
item 3 **half discharged** in the ADR's own owed-acts ledger, with the residue
named and §7.4's own ground (*a rule that binds one and not the other would be
discovered the hard way*) quoted against it. A debt carried visibly beats a debt
discharged outside the permission that commissioned it.
(c) **The `Status: PROPOSED. NOT IN FORCE.` line**, which is now false — see
Open-questions 1. It is a governance flip whose authority is another seat's
committed entry, in a round whose whole subject is that acts are routed and
signed; performing it unrouted would be the quotable contradiction. Named, not
taken.

### Actions

- Ran the abort-first precheck; verified `dde0511`'s and `a76e485`'s trailers,
  journal entries and file lists before opening any editable file.
- Read the four filings at their own committed artefacts (`62ad337`, `6019846`,
  `78f83d6`) rather than from the dispatch's summary; read `J-orchestrator-0261`
  and `-0262` for what acceptance put in force.
- **Act 7**: landed §7.4's rule in `docs/specs/SPEC-TEMPLATE.md` §13, between the
  change-log preamble and the row table, carrying `C-RL-10`'s two halves.
- Amended `ADR-0020` §7.4's source text to what actually landed, and added
  **§7.6** recording `C-RL-10`'s disposition, its two-direction check, the marked
  gloss, and what it re-owes.
- Cured **§2 `D5`**'s predicate (`REC-6`); rewrote **§12.8** — heading, the
  `F-0022-5` routing correction, and the two further modes (`F-0022-1`, `REC-7`)
  with their counter-arguments; marked **§10 item 3** half discharged with the
  `requirements.md` residue named as still owed.
- Re-measured both findings at `a76e485` and again at `95bf07b`; verified the
  landed template text byte-identical to the ADR's source text.
- **No `git add`, no `git commit`, no `git push`** — this seat does not operate
  git and did not. `agents/PROTOCOL.md` was read and never opened for writing.

### Evidence

All commands from a checkout of `claude/fpga-hardcaml-agent-orchestration-37ceyf`;
the first two at `a76e485`, re-run identically at `95bf07b` after the sibling
commit landed.

1. **The two dispatch claims.**

       git log -1 --format='%s%n%(trailers)' dde0511
       # THE ACCEPTANCE ACT … / Agent: orchestrator / Journal-Entry: J-orchestrator-0261 / Journal-Only: true
       git show --numstat --format='' a76e485
       # 69  3  agents/PROTOCOL.md
       # 29  0  agents/journals/claude_orchestrator_agent.v02.md

2. **`F-0022-1` re-measured** (check-only; tree verified clean before and after):

       for f in docs/reports/audit/WO-*-mutations/*.diff; do git apply --check "$f"; done
       # total=37  apply=32  fail=5
       # WO-0039/M3.diff, WO-0039/M5.diff, WO-0045/E-c2.diff, WO-0050/f-c3.diff, WO-0050/f-c6.diff
       git diff --stat b6c8a2f..a76e485 -- libs/ test/ docs/reports/audit/   # empty

   The empty third command is what makes the auditor's `b6c8a2f` figure quotable
   at this HEAD: none of the three input populations moved between the two SHAs.

3. **`REC-7` re-measured**, by the filer's own method (matching lines under
   `test/`), which reproduces its published figures exactly:

       for u in T-F2 T-I4 T-G7 T-E5 T-C4;             do grep -rn "$u" test/ | wc -l; done   # 0 0 0 0 0
       for u in M03-F2 M03-I4 M03-G7 M03-E5 M03-C4;   do grep -rn "$u" test/ | wc -l; done   # 42 132 34 26 15

4. **The landed text is byte-identical to the ADR's source text** — the check §3
   made procedure for the constitution, applied to the template:

       awk '/^> \*\*Countersignature on a post-freeze diff\*\*/,/which is unmoved\./' <ADR> | sed 's/^> //' > a
       awk '/^\*\*Countersignature on a post-freeze diff\*\*/,/which is unmoved\./'    <TPL>            > b
       diff a b   # no output; 21 lines each; sha256 7375fa78bd2c0e84… both sides

5. **`REC-6` discharged, censused:**

       grep -rn 'no seeded mutation' docs/ agents/ README.md ORG_CHART.md | grep -v '/journals/' | wc -l
       # 0   (was 1: ADR-0020 §2 D5)

6. **The constitution is untouched and still agrees with its authority** — the
   check that proves `F-0022-2` was correctly stopped rather than quietly half-done:

       git diff --name-only -- agents/PROTOCOL.md   # empty
       grep -c 'together with the named killing unit, present and green at the gate SHA' \
            agents/PROTOCOL.md docs/adr/ADR-0020-*.md
       # agents/PROTOCOL.md:1   docs/adr/ADR-0020-…:1

7. **Sibling verification** (mid-round HEAD move):

       git merge-base --is-ancestor a76e485 95bf07b      # exit 0
       git diff --name-only a76e485..95bf07b -- docs/    # empty
       git log -1 --format='%(trailers)' 95bf07b         # Agent: orchestrator / J-orchestrator-0263

8. **Working tree at hand-off**: exactly two modified paths, both in this seat's
   write scope (`git status --short`).

### Outcome

**Act 7 landed; four of the six routed cures paid; one stopped with grounds; one
sustained finding added back that the relay dropped.**

| # | routed cure | disposition | re-owes |
|---|---|---|---|
| 1 | act 7 proper — §7.4 → `SPEC-TEMPLATE` §13 | **LANDED**, byte-identical to the ADR's source text | nothing |
| 2 | `C-RL-10` (rtl_lead) | **SUSTAINED, both halves**, in the filer's own words; class filter refused as the filer asked; §7.6 records it | nothing — the constrained party's own words; the marked gloss is contestable at dv_lead's next entry |
| 3 | `REC-6` (dv_lead, MINOR) | **CURED** in `D5`; §5 deliberately untouched | nothing — the filer's own cure, aligning a summary to text already countersigned |
| 4 | `F-0022-1` (auditor, MAJOR) | **CURED** — §12.8 now names the second mode with its measurement and its counter-argument | nothing — narrative, as its filer routed it |
| 5 | `REC-7` (dv_lead, MAJOR) | **CURED** — §12.8 names the mode; the mapping stays dv_lead's table | nothing — narrative; the disposition is the filer's |
| 6 | `F-0022-2` (auditor, MAJOR) | **STOPPED — returned as an Amendment `A1` candidate.** The word is now applied constitution text; curing it in the ADR alone would desynchronise authority from constitution, and `PROTOCOL` is not this seat's to stage | the `A1` round owes the auditor and dv_lead a countersignature on the amended clause; meanwhile dv_lead's disposition table carries the operative half |
| + | `F-0022-5` (auditor, MINOR) | **CURED, beyond the basket and declared** — §12.8's residue routing corrected from the graded party's own review to the auditor's charter §3 duty | nothing — enlarges its own filer's duty, at its filer's request, with the relieved party concurring |

**DoD**: the dispatch's act 7 and its basket are discharged except where stopped
with grounds; both files are inside this seat's write scope; the journal entry is
appended before the commit; no `PROTOCOL`, no gate checklist, no frozen spec's
normative sentence moved. **Handoff**: the orchestrator, for commit under
`Agent: architect_docs_lead`.

### Open-questions

1. **`ADR-0020` still reads `Status: PROPOSED. NOT IN FORCE.`, and that is now
   false.** §0's *table* is honestly built — it states a status *at that landing*
   with the acts that would change it, and each act is publicly checkable — but the
   `Status` line is unconditional and wrong, and §0's prose asserts `PROTOCOL` §7
   *"still reads 'auditor's seeded mutations all killed by the DV suite'"*, which
   `a76e485` falsified. **Not taken this round** (Reasoning 8c): the precedent for
   the flip is this seat's (`ADR-0015`, `J-architect_docs_lead-0015`), but its
   authority is `J-orchestrator-0261`, and an unrouted governance flip performed in
   this particular round would refute the round. **Proposed line, ready to land in
   one act**: `**Status**: **ACCEPTED and IN FORCE** — accepted at
   J-orchestrator-0261 (dde0511), §3/§4 hunks applied to agents/PROTOCOL.md at
   J-orchestrator-0262 (a76e485). §0's table below states what was in force at this
   file's own landing and is preserved as a historical record.` **This is the
   highest-value follow-up of the round**: it is what a later reader meets first,
   and today it points them at a constitution that no longer exists.
2. **`F-0022-2`'s `A1` is drafted in my head and unwritten on disk**, deliberately
   — an ADR draft naming a cure it has not routed is a claim, not a seal. What it
   would carry: (b.2)'s *"the named killing unit"* → *"the unit or units the
   campaign record names"*, one hunk to `agents/PROTOCOL.md` for the orchestrator,
   countersignatures from the auditor (the form binds its future acts) and dv_lead
   (the width falls on its packet). **Whether it is worth a §11 round for one
   phrase is the orchestrator's call, not mine** — the alternative is that the
   construction lives in two journals and the clause stays singular, which is
   exactly what §6.7 convicted: *a construction in a journal binds a reading; a
   sentence in the clause forecloses it.*
3. **`requirements.md` §13's pointer is the un-landed half of act 7** (§10 item 3,
   now marked). One line, one path, and the ADR's own ground for it is already
   written. It needs a dispatch that opens `docs/specs/requirements.md`.
4. **The gloss in §7.6 is the sentence most likely to be wrong.** Generalising
   `C-43`'s *"own instrument"* from two committed instances to a class is the kind
   of move this round twice convicted in others' text (a qualification drawn from
   the author's own practice describes the author). I marked it rather than
   trusting it; dv_lead and rtl_lead are the two seats who can measure whether it
   is wider or narrower than the five rows' actual application.
5. **`SPEC-TEMPLATE` §13's table has no countersignature column**, and the rule now
   sitting above it decides a question no column records. Requirements' §13 carries
   the discipline inside its class cell; module specs would need either the same
   habit or a column. **Not invented here** — adding a column to the template
   changes every module spec's §13 and would be an unrequested obligation on the
   seats that fill them, which is the thing dv_lead declined to do at (b.4) and I
   decline for the same reason. It is a real gap and it is named.
6. **Carried**: item 70's second-instance test (`J-architect_docs_lead-0046`
   Open-question 4) is now live rather than hypothetical — this round moved text
   inside an in-force instrument as *cures inside an already-ruled rule* and took
   no ADR for any of them. If that limb is a licence rather than a rule, this entry
   is the exhibit; the cure that would have tested it hardest, `F-0022-2`, is the
   one I stopped.

### Files-in-this-commit

- docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md
- docs/specs/SPEC-TEMPLATE.md
