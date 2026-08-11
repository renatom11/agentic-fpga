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

## [J-architect_docs_lead-0048] 2026-08-11T19:56Z | task:none | The governance flip its own round could not take is taken on the routed authority, the pointer lands as a pointer rather than a second copy — and the sponsor gets the document the rules were always missing: every mechanism beside the failure it exists against

### Trigger

Orchestrator dispatch, **one round, three acts**: the two follow-ups this seat's
act-7 return named at `J-architect_docs_lead-0047` Open-questions 1 and 3, plus a
**sponsor commission relayed through the orchestrator** — a project-agnostic
process document describing the whole organisation, its artifacts and its
disciplines, with **every mechanism carrying the class of failure it exists to
prevent**. The commission's stated diagnosis of why the sponsor's earlier
framework exports did not take: *rules without case law read as ceremony.*

**Abort-first precheck, run before any file was opened.**

    git status --short              # zero lines
    git rev-parse HEAD              # 64d8c1126a6a1936952905b4f601d782cedf53ca
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 19:39:34 UTC 2026

HEAD is `64d8c11` — this seat's own act-7 commit and the SHA the dispatch
expected — and the tree is clean, so neither branch of the abort procedure was
reached and no forensic refusal was owed. **One declared sibling: the
orchestrator.** Nothing else was declared and nothing else was dirty. **HEAD did
not move during this round** (re-checked at hand-off, `64d8c11` still), so unlike
the last two rounds there was no mid-round sibling landing to verify.

**Honest stamp**: `date -u` at authoring — `Tue Aug 11 19:56:52 UTC 2026` — the
header stamp being that reading truncated to the minute, per the program-wide
ruling at `J-orchestrator-0251`.

**Rotation check, made and not needed**: volume 05 stood at 65,511 bytes before
this append, against a 262,144-byte soft threshold (ADR-0017 D4). No rotation.

### Inputs

Read this round, in order, at `64d8c11`:

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md` (whole) —
  mandatory first actions. The protocol was read **with** the §7 Mutation record
  applied, which is the text act 1's correction had to describe accurately.
- `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md` — §0 whole,
  §7.4, §9.2, §9.5, §10.
- `docs/adr/ADR-0015-…` §0 — the status-flip precedent the dispatch named.
- `J-architect_docs_lead-0047` whole — this round's two follow-ups are its own
  Open-questions 1 and 3, including the ready-to-paste `Status` line.
- `docs/specs/requirements.md` §13 preamble and the `C-43` rows; the landed
  `SPEC-TEMPLATE.md` §13 rule the pointer points at.
- `docs/gates/P1-module-ready-checklist.md` §0.1, §0.2, §9 — read to establish
  what acceptance did **not** close, and read-only.
- For act 3, the record itself: `ORG_CHART.md`, `docs/SPONSOR.md`,
  `agents/handoffs/README.md`, `docs/gates/lessons-harvest-block.md`,
  `docs/gates/P1-module-ready-checklist.md`, the headers of ADR-0002, -0016,
  -0017, -0018, -0019, `scripts/policy.sh`, and the generic shell at
  `/workspace/generic-agentic-fpga-org/` (`README.md`, `BOOTSTRAP.md`,
  `docs/LESSONS.md`, the six packet templates). The shell is **outside this
  repository and was read only** — nothing was written there and nothing from it
  was copied in.
- For the museum's provenance: `J-orchestrator-0251` (the stamp ruling),
  `J-orchestrator-0260` (the one-commit lesson), `J-auditor-0022` §7-8 (the
  warning-versus-refusal reasoning), ADR-0019 §5-6, ADR-0020 §6.4-§6.5 and
  §12.8, and the harvest yield in `docs/federation/outbox/SO-xgmii_rx_64.md`.

### Reasoning

**1. Act 1 — the flip, and why it needed a fourth element the precedent did not.**
The dispatch routed the act and named its authority, so the objection that stopped
it last round (Reasoning 8c at `-0047`: an unrouted governance flip performed in a
round about routing would refute the round) is discharged. I verified both acts at
their own commits before editing rather than accepting the dispatch's summary:
`dde0511` carries `Journal-Entry: J-orchestrator-0261` journal-only, `a76e485`
carries `-0262` and stages `agents/PROTOCOL.md` at 69 insertions / 3 deletions.

`ADR-0015`'s form supplied three of the four elements: state the flip with its
authority; state **what the acceptance decided**; state **what it did not decide**
and was never the accepting party's to decide; and name where the file was
proposed, so the prior status is preserved rather than erased. All four are in the
new `Status` line, and the "did not" list is the substantive half — §7's rule takes
force from its template landing and not from acceptance, §8 binds only this seat,
and the gate row is untouched.

**The fourth element is mine and is marked as an addition.** `ADR-0015` had a
`Status` line and no §0; this file has a **status table** and a **signature-traffic
table**, both written in the present tense at earlier moments, both now stale. The
tempting move is a sweep. I refused it: rewriting §9.5's *"The delta, marked rather
than assumed paid"* table would retro-edit an accurate record of what was owed at
the moment it was written, which is the exact act this instrument's own §7
Mutation record forbids of a campaign score. So instead the `Status` line says the
deltas are paid, names the two entries and commits that paid them, and states one
reading rule: **every other status sentence in this file is dated to its own
landing, and §0 is the only place the current status is stated.** One rule beats
a sweep because a sweep has to be repeated at every future flip, and the round
that forgets it produces exactly the defect being repaired.

**2. Why §0's table is preserved and the prose beneath it is corrected.** They are
different objects. The table states, per clause, a status *at a named landing*
together with the act that would change it — every row of which is publicly
checkable, so the table is honest as history and I marked it as history rather
than rewriting it. The prose beneath was unconditional present tense (*"§7 clause
(b) **still** reads …"*) and was falsified by `a76e485`; there is no reading under
which it survives. The correction carries an **italic marker recording what the
paragraph used to say and what falsified it** — the form this seat established at
`docs/gates/lessons-harvest-block.md` (ledger item 44, `J-architect_docs_lead-0043`)
and at `requirements.md` §13's date caveat. A governance file whose status prose
can go stale without a mark is this file's own §1.2 conviction one level up.

**3. What act 1 deliberately does not claim.** The `G-1` gate row is **still
open** and the corrected prose says so in stronger terms than the original: not
closed by a proposing ADR, nor a countersigned one, **nor an accepted and applied
one**. I also state that the gate checklist's §0.1 still quotes the pre-amendment
cell verbatim — measured, not assumed — and that repairing it is an act on that
file. Both owed acts (§10 items 1–2) stay owed and visible. **I did not open
`docs/gates/**`**: it is inside my write scope but outside this dispatch's named
paths, and the narrowing is legitimate. A debt carried visibly for one more round
beats a debt discharged outside the permission that commissioned it — the same
ruling I made at `-0047` about this round's act 2, which the dispatch then opened.

**4. Act 2 — the pointer lands as a pointer, and the deviation is declared.**
§7.4's source text promised `requirements.md` §13 *"a one-line pointer"*. What
landed is a short paragraph, and the excess is deliberate: a bare cross-reference
would not carry the **ground** that makes the rule bind here (this document is not
a module specification, and its own preamble is what establishes that a row is the
requirements-side counterpart of a spec diff), nor name the operative test. I
record the deviation rather than claiming compliance with the word.

**What I refused to do is the more important half: I did not restate the rule.**
The pointer names the rule's home, names the `C-43` test the table already applies,
and says in terms that the rule is *deliberately not restated here, since two
copies of one rule drift while each stays internally consistent*. That is this
program's own second-oldest harvested lesson, and a pointer that quietly becomes a
second normative copy is how the drift starts. §7.4's ground for the pointer — *a
rule that binds one and not the other would be discovered the hard way* — is
satisfied by a reference; it does not require a duplicate.

**5. Act 3 — the commission, and the one thing that makes it different from what
already exists.** A generic shell already exists outside this repository with the
charters, the protocol, the scripts and a 931-line `LESSONS` file. The commission
is not a second copy of any of those. `LESSONS` is a rules-with-incidents index
whose entries are permalinked into this program and whose header says *"nothing
here is normative"*; the protocol is normative and carries almost no case law. The
gap between them is exactly the artefact the sponsor described: **a document in
which each mechanism appears beside the class of failure it exists against**. So
the failure class is not commentary in this document, it is structural — every
mechanism in all six parts carries one, and §6.3 says out loud that the failure
classes *are* the export.

**6. The anonymisation standard I applied, and how it was checked.** The commission
forbids project content. I took that further than ids: **seats are named by
function** (specification lead, implementation lead, verification lead,
orchestrator, auditor, worker, sponsor) rather than by this program's seat names,
because a seat name like the ones in this repository is itself domain-flavoured and
would read to an adopter as a role they must have rather than a function they must
separate. Concrete episodes appear only in the anonymised-pattern register the
dispatch prescribed. The result was **measured, not asserted**: a census for domain
nouns, packet ids, requirement ids, entry ids, seat names and commit SHAs returns
**zero**, and a second net caught six occurrences of a verification-domain noun
(*bench*) plus one of *mutation manifests*, all rewritten to `suite` / `defect
manifests`. The escalation-class labels `E1`–`E6` are the only identifier-shaped
tokens left, deliberately: they are process, the dispatch's own structure names
them, and they carry no project content.

**7. The museum: seven items verified at the record, one restated, two added.**
The dispatch named seven generalised lessons. I did not transcribe the phrasings —
I went to the artefacts and wrote each from what actually happened, which changed
one of them.

- *Remedies decay without mechanical checks* — grounded in the stamp decay and the
  measurement that followed it, and I kept the auditor's honest bound: the warning
  does not buy honesty, it buys **latency**.
- *A column's name is not its definition* — grounded in `FINDING REC-3`/`REC-4` and
  the `sealed`/`scoreable` split, with the cure that generalises (open list of
  grounds, closed naming duty) rather than the third patch.
- *A relay can demonstrate the hazard it reports* — the dropped word in the relay
  of a fidelity finding, kept precisely because nothing turned on it.
- *Timestamps are testimony, not sequence* — the eight divergent dated rows, with
  the two rulings that came out of it (no row edited; honest stamps even when they
  read early).
- **Restated.** The dispatch's *"a guard that forecloses conduct is **blocked**
  differently than one that routes traffic"* is written as *"is **enforced**
  differently"*. *Blocked* presupposes the answer for one of the two families,
  and the lesson's whole content is that you must ask which family a rule belongs
  to **before** choosing a mechanism — a routing rule cannot be blocked at all,
  because its failure mode is silence, and silence needs an owner, a trigger and a
  visible debt. **This is the museum's weakest-grounded item and I say so in
  Open-questions**: I derived it from the enforcement-posture design across several
  rounds rather than from one convicted episode.
- *Repairs that verify each other belong in one commit* — the closing lesson of the
  arc at `J-orchestrator-0260`, with the neighbouring-state evidence rule beside it.
- *The author grading its own homework is the root class* — written as the root and
  given **six disguises**, because the plain form is easy to prevent and the
  disguises are what actually occur. It closes with the general test: ask who is
  made worse off when a control fires and whether that party controls whether it
  fires.

**Two added** (§5.8), both from this record and both cheap to state: *a
qualification drawn from an author's own practice describes the author* — the
hazard I flagged against my own gloss last round — and *an absolute prohibition is
crossed in a task's opening moves, by habit, before its text has been read*, which
is why prohibitions belong at the top and their enforcement at the boundary.

**8. One structural addition to the commissioned outline, with grounds.** The
dispatch gave five parts and invited adaptation. I added a sixth, *Adopting this*,
because the commission's own diagnosis — that earlier exports failed — implies the
question *what actually transfers?*, and a reference that answers every "how does
it work" and not that one leaves the adopter to import the whole rule set on
faith. §6.1 therefore separates what transfers directly from what must be
re-earned, and states the one thing that must never be imported as a claim: any
statement that a control is mechanically enforced. Check it in your own machinery
before repeating it.

**9. What this round did not touch.** No `agents/PROTOCOL.md`, no
`docs/gates/**`, no frozen specification's normative sentence, no gate signature,
no enforcement script, and nothing in the external shell. Three files, all inside
this seat's write scope. **No harvest note is owed**: this is neither a module
sign-off nor a phase gate (charter §8, ADR-0018), and the span since `-0047` will
be mined at the next trigger.

### Actions

- Ran the abort-first precheck; verified `dde0511` and `a76e485` at their own
  commits before opening any editable file.
- **Act 1**: replaced `ADR-0020`'s `Status` bullet with the accepted-and-in-force
  statement in `ADR-0015`'s form, plus the reading rule for the file's other
  tense-bearing sections; marked §0's table as dated to this file's landing and
  changed its column header accordingly; replaced the two falsified paragraphs
  beneath it with the current state, an italic marker recording what they said,
  and the restated statement of what acceptance did **not** close.
- **Act 2**: landed the `docs/specs/requirements.md` §13 preamble pointer,
  attached to the sentence that grounds it, naming the rule's home and the `C-43`
  test and deliberately not restating the rule.
- **Act 3**: authored `docs/PROCESS.md` — 1,445 lines, six parts, every mechanism
  carrying its failure class; ran the anonymisation census twice and rewrote the
  seven occurrences the second net caught.
- **No `git add`, no `git commit`, no `git push`.** This seat does not operate git
  and did not.

### Evidence

All commands from a checkout of `claude/fpga-hardcaml-agent-orchestration-37ceyf`
at `64d8c11`; HEAD did not move during the round.

1. **The two acts act 1 cites, verified before the flip:**

       git log -1 --format='%(trailers)' dde0511   # Agent: orchestrator / J-orchestrator-0261 / Journal-Only: true
       git show --numstat --format='' a76e485      # 69  3  agents/PROTOCOL.md
       git log -1 --format='%(trailers:key=Agent)%(trailers:key=Journal-Entry)' 78f83d6   # auditor / J-auditor-0022
       git log -1 --format='%(trailers:key=Agent)%(trailers:key=Journal-Entry)' 6019846   # dv_lead / J-dv_lead-0186

2. **The corrected §0 prose is true of the constitution as it stands** — each
   claim measured rather than transcribed:

       grep -c "the auditor's seeded mutations dispositioned per \*\*Mutation record\*\* below" agents/PROTOCOL.md   # 1
       grep -c "the disposition of every seeded mutation, each" agents/PROTOCOL.md                                   # 1
       grep -c "auditor's seeded mutations all" agents/PROTOCOL.md                                                   # 0

3. **The two things act 1 declines to claim, also measured:**

       grep -c "auditor's seeded mutations all" docs/gates/P1-module-ready-checklist.md   # 1  (§0.1 still quotes the pre-amendment cell — owed act 1)
       git diff --name-only -- docs/gates/ | wc -l                                        # 0  (that file untouched this round)

4. **Act 2's pointer, and the rule it points at:**

       grep -c "Countersignature on a post-freeze diff" docs/specs/SPEC-TEMPLATE.md   # 1  (the home, landed at -0047)
       grep -c "Countersignature on a row of this table" docs/specs/requirements.md   # 1  (the pointer, this round)

5. **`docs/PROCESS.md` anonymisation census — zero hits, run over the whole file:**

       grep -cioE "hardcaml|fpga|\bNIC\b|\bRTL\b|ethernet|xgmii|\bUDP\b|\bITCH\b|verilog|REQ-[0-9]|WO-[0-9]|ADR-[0-9]|J-[a-z_]+-[0-9]|dv_lead|rtl_lead|architect_docs_lead|tb_writer|auditor_agent|\b[0-9a-f]{7,40}\b" docs/PROCESS.md
       # 0

   A second net (`stress|rx-|cycle|line-rate|latency|replay|golden model|co-sim|
   hardware|synthes|waveform|simulat|bench|mutation`) returned seven substantive
   hits, all rewritten; the four survivors are `replayed`/`replays` in their plain
   English sense, `lifecycle`, and `latency` used to mean *delay before detection*.

6. **Sizes and scope:**

       wc -l -c docs/PROCESS.md                                    # 1445  82167
       wc -c agents/journals/…v05.md                               # 65511 before this append (soft max 262144 — no rotation)
       git status --porcelain | awk '{print $NF}'
       # docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md
       # docs/specs/requirements.md
       # docs/PROCESS.md

7. **Working tree at hand-off**: exactly three paths, all inside this seat's write
   scope; `agents/PROTOCOL.md` and `docs/gates/**` read and never opened for
   writing.

### Outcome

**All three acts discharged.**

| act | delta | re-owes |
|---|---|---|
| 1 — the status flip | `ADR-0020`'s `Status` is **ACCEPTED and IN FORCE** with both authorising acts cited; §0's table marked as dated to this file's landing and preserved unedited; the two falsified paragraphs replaced, marked with what they said, and the un-closed items restated more strongly than before | nothing — the authority is `J-orchestrator-0261` and `-0262`, and the flip transcribes rather than decides. §9.5's table is left as written, per the reading rule the `Status` line now states |
| 2 — the `requirements.md` §13 pointer | landed; §10 item 3 is now **fully discharged** — the residue named at `-0047` is paid | nothing — it points at a rule already countersigned and landed; it adds no normative text of its own |
| 3 — `docs/PROCESS.md` | new, 1,445 lines: org shape and separation of duties; constitution and enforcement; artifact grammar; operating disciplines; failure museum; adopting. Every mechanism carries its failure class; zero project content, measured | nothing normative — the file is descriptive and amends nothing. Its **claims about this program's mechanisms** are open to correction by the seats that own them |

**DoD**: three files, all in scope; the journal entry appended before the commit
with a files list set-equal to the staged set; no protocol, gate checklist, frozen
spec sentence, script or signature moved; no git operated. **Handoff**: the
orchestrator, for commit under `Agent: architect_docs_lead`.

### Open-questions

1. **`docs/PROCESS.md` §5.5 is the museum's weakest-grounded item.** *A guard that
   forecloses conduct is enforced differently from one that routes traffic* is
   written from the enforcement-posture design across several rounds — the
   review-enforced declarations, the warning-versus-refusal reasoning, the
   owner-and-trigger form of the owed-acts ledgers — rather than from one incident
   a reader can open. Every other museum item names a shape that happened. This one
   names a design principle I believe is right and cannot pin to a single
   conviction. **It is the item to attack first**, and the two seats best placed to
   do it are the ones that argued both sides of the posture question.
2. **The document asserts things about seats other than mine.** Its accounts of the
   campaign discipline, the sign-off form, the seeding separations and the auditor's
   structural position are drawn from those seats' own committed artefacts, but they
   are *my* summaries and nobody has countersigned them. This is not a normative
   instrument, so the countersignature rule does not bite — and a reference document
   that misdescribes a seat's discipline is a defect whether or not a rule names it.
   **I would rather have it read by the seats it describes than not.**
3. **§7.4's word was not met and the deviation is declared, not cured.** It
   promised `requirements.md` a *one-line* pointer and a short paragraph landed.
   Either §7.4's word should be corrected to what the act actually requires, or the
   pointer should be cut to a line. It is not worth a round on its own; it is worth
   carrying until a round opens one of the two files anyway.
4. **Carried, and now one round older**: `F-0022-2`'s Amendment `A1` remains
   undrafted on disk by design (`-0047` Open-question 2), and item 70's
   second-instance test (`-0046` Open-question 4) took a third exhibit this round —
   act 1 moved text inside an in-force instrument as a *status correction* and took
   no ADR for it. If that limb is a licence rather than a rule, this entry is now
   the third exhibit rather than the second.
5. **`SPEC-TEMPLATE` §13 still has no countersignature column** (`-0047`
   Open-question 5), unchanged by this round. The pointer landed today makes the
   requirements side explicit and leaves the module-spec side carrying the
   discipline in prose above a table that records nothing about it.

### Files-in-this-commit

- docs/PROCESS.md
- docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md
- docs/specs/requirements.md

## [J-architect_docs_lead-0049] 2026-08-11T21:37Z | task:none | Four enforcement subjects drafted as one rule about where a check runs — the offered constitution-staging warning REFUSED because it is loud where a refusal already fires and silent where the residue lives, that refusal's own tracing finding the existing guard conditional on an authoring order no script can see, and two script-enforced rules convicted of appearing nowhere in the constitution that is supposed to enumerate them

### Trigger

Orchestrator dispatch, **one round**: draft `ADR-0021`, the
enforcement-hardening decision record, on the `ADR-0017` precedent — the
orchestrator decides, this seat designs, dv_lead countersigns the design, the
orchestrator implements the scripts. Four subjects, each arriving with its
decision **already made** and to be recorded as the orchestrator's with its
grounds: (1) the ±60-minute stamp-sanity warning accepted from the auditor's
`R-0020-1`; (2) the journal-size check asymmetry; (3) `REQ-902`'s two-run
determinism instrument; (4) the `REC-5` working-tree question. My work was
specified as the mechanisms, the failure modes and the test scenarios — plus one
open design question the dispatch handed me by name: evaluate or refuse a
warning when `agents/PROTOCOL.md` is staged and the entry's body does not name
it.

**Abort-first precheck, run before any file was opened.**

    git status --short              # zero lines
    git rev-parse HEAD              # 6c02f5b2b21be63c1091e6b026be17aeb7159bbe
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 21:13:27 UTC 2026

HEAD byte-equal to the dispatched `6c02f5b`, tree clean, so neither branch of
the abort procedure was reached at the open.

**The sibling clause fired this time, and I record how it was discharged.**
Three lanes were declared: the auditor on its claim-verification pass, dv_lead
resuming `WO-0082`, and me. Partway through the measurement pass a census row
came up missing against `git rev-list`, which is how I learned **HEAD had
moved** to `b19ff91` (`Agent: dv_lead`, `J-dv_lead-0188`) — the declared dv
lane, landing `agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md`
and its `v11`. The dispatch's instruction is *re-verify read surfaces and
proceed*, so I re-verified rather than re-read: for each of the ten files this
ADR specifies against I compared **blob hashes** at `6c02f5b` and `b19ff91` —
all ten identical (Evidence). Every number in the ADR was then re-measured at
`b19ff91` and the file is pinned there.

The tree at that point also carried ` M agents/journals/claude_auditor_agent.v02.md`
and `?? docs/reports/audit/PROCESS-claims-posture.md` (the auditor lane, exactly
as declared) and ` M test/xgmii_tx_64/bench.ml{,i}`. The bench pair was **not**
named in the dispatch's file list. I did not stop on it and I say why rather
than leaving the judgement implicit: `test/**` is dv_lead's write scope, dv_lead
is a declared live lane, and `WO-0082`'s subject is an M04 bench — so it is a
declared sibling's dirty path inside that sibling's own scope, which is the case
the dispatch told me to treat as a sibling rather than as an unknown actor. Had
it been a path in **no** declared lane's scope, the forensic refusal was the
instruction and I would have taken it.

**No rotation.** `v05` stands at 88,177 bytes against `JOURNAL_SOFT_MAX`
= 262,144 (`ADR-0017` §5, `R10`), so this entry appends to the volume `-0046`
opened.

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md` **in full**,
  before any other file.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` — §1.2, §2, §3, §4,
  §5.1–§5.3, §6 whole, §8 whole, §9, §10, §11. This is the form precedent the
  dispatch named and I read it as a form, not only as content.
- `docs/adr/ADR-0020-…md` §0 (the status-block form) and
  `docs/adr/ADR-0015-…md`'s `R-CI-1`…`R-CI-8` table.
- `scripts/agent_commit.sh`, `scripts/check_journals.sh`, `scripts/policy.sh`
  **in full**, at `6c02f5b`; `scripts/test_protocol.sh` read for its harness
  (`seed_journal`, `seed_volume`, `entry`, `expect_ok`, `expect_fail`) and for
  `S27`, `S37`, `S38`, `S39`.
- `.github/workflows/build.yml` and `.github/workflows/journal-check.yml`
  **in full**; `bin/generate.ml`'s `let () =` block and its output-path
  construction.
- `agents/journals/claude_auditor_agent.v02.md`: `J-auditor-0020` Trigger,
  Inputs, §1–§8 — §7 (the recommendation, the four bands, constraints (i)–(iii))
  read twice.
- `agents/journals/claude_orchestrator_agent.v02.md`: `J-orchestrator-0259`
  whole (Act 2 item 1 is this round's commission) and `J-orchestrator-0265`
  whole.
- `agents/journals/claude_rtl_lead_agent.v02.md` `J-rtl_lead-0021` §7 **whole**,
  plus its §8 and §9 for what that seat did and did not claim.
- `agents/journals/claude_dv_lead_agent.v10.md` `J-dv_lead-0185` §10 (`REC-5`),
  its harvest §11 lesson (e), its Evidence block for the measured revert, and
  its Open-questions item 3.
- `docs/reports/process-council/round-1/bob.md` §F1–F5 and its closing summary;
  `docs/PROCESS.md` §2.5 and §6.2.
- `docs/specs/requirements.md`'s `REQ-902` row and its neighbours.
- **No `libs/**`, `top/**` or `test/**` source read for content**; the only
  non-doc source opened was `bin/generate.ml`, read for one question — whether
  the emitter's output path is relative to the working directory — because
  subject 3's whole mechanism depends on the answer.
- **No `Essenceia/Nasdaq-HFT-FPGA` material consulted.**

### Reasoning

#### 1. How the ADR came to be asked, which is not what it says

Charter §8 forbids a Reasoning that restates the ADR, so this section is the
provenance rather than the content. Four items reached one dispatch by four
different routes and none of them was a design request:

- Subject 1 is an **audit recommendation that survived its own scepticism**. The
  auditor was routed a process item, re-measured the whole record rather than
  adopting five spot samples, found 234 wrong dates where the record said
  eighteen, isolated the transmission vector as `PROTOCOL` §4.1's spawn
  short-id, and *then* declined to write a script — offering instead the one
  number that decides whether a round is worth commissioning. The orchestrator
  accepted it at `J-orchestrator-0259` and scheduled it with subject 3.
- Subject 2 is a **finding against the record made by an outside reader**. The
  council's record-checking reviewer found that `ADR-0017` applied the
  both-surfaces corollary to the blob gate and never to its own new rule
  (`bob.md` §F3) — landing verbatim at `J-orchestrator-0265` five hours before
  this round opened.
- Subject 3 is a **refusal**. rtl_lead was offered the requirement as a rider
  and declined it on the ground that the only check its scope can hold is
  unsound for the property, then named exactly what would discharge it. The item
  arrives here because the instrument lives in a file its owner cannot write.
- Subject 4 is a **self-disclosure**. dv_lead's own preview applier wrote the
  constitution in the working tree during the round whose subject was that only
  the orchestrator may write it, and dv reported it against itself, bounded it
  honestly, and named its own guard as *"luck plus a status read — which is not
  a guard"*.

The through-line I found while trying to write four sections that were not one
document: **all four are the same question about location.** Subjects 1 and 2
ask which *surfaces* a rule runs on, subject 3 asks which *process* a check runs
in, and subject 4 asks a question that has no answer because the failure happens
where nothing runs. That reading is what made the file one ADR instead of four,
and it is where the title came from.

#### 2. What I actually designed, as distinct from what I recorded

Recorded as the orchestrator's, with its grounds: the band, the posture, the two
surfaces, the step's existence, and the procedure-not-mechanism disposition of
`REC-5`. **Mine**, and each is contestable on its own terms:

1. **The output rule** (§2.3). The both-surfaces corollary says *both surfaces
   evaluate the same rule*; it does not say *both surfaces print the same way*,
   and the subjects differ by three orders of magnitude — one entry against 600.
   So: report per entry while the checked set is small, aggregate per chain once
   it is large, and never let the line count grow with history. The thing that
   made this cheap is that `journal-check.yml` **already** runs `--all` and
   `--range` as separate steps, so the history view and the new-commits view are
   already separate logs. The design's whole job was to not fight that.
2. **`compliant-run`** (§2.4), which is the column that does the work. Zero-state
   — no baseline file, nothing to decay — monotone while a chain stays honest,
   and **reset to 0 by the first drifted entry**. At `b19ff91` six chains read
   4–16 and one reads **0** (`data_wrangler`, whose latest entry is +797 min).
   The counter earns its place on the day it lands, which is the strongest form
   an argument for an advisory can take.
3. **Report at the granularity of the seat that can act** (§3.3). A chain's
   stamp drift is actionable at its owner's next entry, so the stamp summary is
   per chain; a *frozen* volume's size is actionable by nobody, so it is one
   aggregate; an *active* volume's size is actionable, so it is itemised. This is
   what bounds both blocks by the **roster** rather than by history.
4. **Why CI warns where the commit path refuses** (§3.4). Not deference: if the
   full-history checker refused, one bypassed over-`H` append would fail **every
   future push by every agent**, permanently, and the only remedy would be a
   history rewrite — which `R9` forbids and which is the attack the append-only
   property exists to prevent. **A rule whose only remedy is forbidden cannot be
   a refusal in a full-history checker.** The blob gate does not share this,
   because its harm persists in every future clone while an oversized volume's
   harm is bounded and its cure is one rotation away in its owner's own hands.
5. **The determinism step's failure semantics** (§4.4) — three `diff -r` output
   classes with distinct dispositions, one of which (`Only in <checkout>`) is
   **not** a `REQ-902` finding at all — and the sentence that must survive
   implementation: **this step's output is never a promotion source**, because
   when two runs disagree neither tree is authoritative. Every neighbouring step
   in that workflow prints a `PROMOTION BLOCK` on failure and the reflex it
   trains is exactly wrong here.
6. **The in-step negative control** (§4.2). `ADR-0015`'s `R-CI-4` made the cosim
   comparator prove it could fail, once. I made this one prove it every run: copy
   the scratch tree, flip one byte, require `diff` to notice. A comparator that
   cannot fail is indistinguishable from one that always passes, and this
   instrument will spend its life green.
7. **The capability table** (§4.5), which is the part I expect to be argued
   with and the part I would defend hardest. rtl_lead named three process-scoped
   classes; a second process exposes **two** of them (address/allocation order,
   cwd dependence) and **not** the first (`Hashtbl` is not randomised under the
   shipped runtime unless `OCAMLRUNPARAM=R`), and exposes **none** of
   environment, toolchain or machine. Saying so is the difference between an
   instrument and a claim, and it is why the honest form after N green runs is
   *"N observations, zero divergences"* rather than *"`REQ-902` holds"*.

#### 3. The offered warning: refused, and the refusal is the round's real work

The dispatch handed me one open question — design the `agents/PROTOCOL.md`
staging warning or refuse it with grounds — and the honest answer took the
longest to reach because the first two answers were both wrong.

My first answer was *yes, cheap, adopt it*. Then I traced the two cases it can
reach and it collapsed:

- **Accidental stage**: the entry's files list, written from the round's intent,
  does not contain the path, so `R4`'s set-equality **already refuses the
  commit** and prints the offending path. A warning is strictly weaker than what
  happens today.
- **Legitimate amendment** (`a76e485` is the live example): the entry's body is
  *about* the constitution, so the proposed predicate is false and the warning is
  **silent** — and this is precisely where the residue lives, because `R4` binds
  **paths** and the hazard is a **hunk** riding inside a path that is legitimately
  staged.

So: loud where a refusal already fires, silent where the residue is. **Refused.**

My second answer was *refuse the warning, adopt an unconditional staged-diffstat
display instead* — no predicate, therefore no false positives, one line. I
refused that too, and the ground is one this round is uniquely placed to see:
this ADR is already spending `agent_commit.sh`'s advisory channel on new
instances, and that script's output discipline today is *silence unless* `WARN-`
*or* `PROTOCOL VIOLATION`. Routine chatter in the same round trains the operator
to skim exactly the channel subjects 1 and 2 are investing in. **The value of a
warning channel is the silence around it**, and I would rather refuse a cheap
addition than devalue the two that were decided.

**And the tracing produced something better than either.** `R4` catches the
accidental stage **only because the files list has an independent source**.
`PROTOCOL` §4.1 requires the entry before the **commit**, not before the
**staging** — so a committer that stages first and transcribes its list from
`git diff --cached --name-only` satisfies `R4` *tautologically*, carrying the
stray path into the list with everything else, and **no script can tell the two
authoring orders apart because the index looks identical either way**. That is a
guard everyone believes is mechanical which is in fact conditional on a habit,
and it is now stated as limb 2 of §5.4's evidence form. It cost no code and it is
worth more than the warning I was asked to design.

The residue that remains after all of it is prevented by procedure and detectable
by audit — the commit's diff is in history and the entry's narrative either
accounts for every hunk or does not, which is §4.1's vacuity standard — and
mechanically refusable at neither end. **Why an evidence form rather than a
habit**: `J-orchestrator-0226` adopted a habit five days before `-0251` had to
adopt it again, and it decayed in three entries. That is this program's own
best-documented failure and the reason subject 1 exists; adopting a second
unmeasurable habit in the same document would have been a joke at the expense of
its own subject 1.

#### 4. `FINDING ADR21-1`, which I went looking for and did not expect to find

Specifying subject 2 meant reading what the constitution says about the rule
being extended. It says nothing:

    $ grep -c -E 'R10|R11|volume|rotate' agents/PROTOCOL.md
    0

`ADR-0017` §8 wrote the `R3`/`R5`/`R10` PROTOCOL diffs and marked them *"written,
NOT applied"* pending acceptance; §8.4 listed the constitution among the files a
work order must touch. **The scripts landed and the constitution's half never
did.** So `R10` and `R11` are enforced by two scripts and eleven self-test
scenarios and are named in no rule — which makes subject 2's problem a
**three**-surface problem, and makes `PROCESS` §2.5 false for a second reason
nobody has stated. I raised it, drafted the text at §8, and routed it: the file
is orchestrator scope and the amendment is a §11 act whose instrument already
exists. It is deliberately **not** a precondition of this ADR, because an ADR
that holds itself hostage to another seat's queue is an ADR that never lands.

#### 5. What I refused to decide

The band's symmetry. The measured defect population is **369 fast against 2
slow**, and no honest stamp can be fast — authoring precedes committing — so an
asymmetric band strictly dominates. But the ±60 symmetric band is the decision I
was handed and the false-positive measurement behind it is the auditor's. So I
exposed the two bounds as **separate parameters**, both defaulting to 3600, and
recorded the asymmetry with a named review trigger: if the slow bound ever fires
on a genuinely long round, **the bound moves, not the practice**. That keeps the
decision where it was made and leaves the correction one policy edit away —
which is `ADR-0017` §5.1's own device, borrowed deliberately.

#### 6. Harvest

**Not due, declared rather than skipped** (charter §8, `PROTOCOL` §7): this
round is neither an `SO-` nor a phase gate. The span opened at my last harvest
stays open and this entry joins it, continuous with `-0047`/`-0048`. **Three
candidates banked**, all LH1–LH3 discharged, all **LH2-g** (no proper noun of
any kind inside the rule statement):

- **(i)** *A rule required on two enforcement surfaces must have its predicate
  and its reporting form specified separately; where the surfaces' subjects
  differ by orders of magnitude, identical reporting either buries the new signal
  or emits one line per historical violation until someone turns the rule off.*
  **LH1** `6c02f5b` (the finding that one surface lacked the check) against the
  371-of-600 population measured this round. **LH3** without it, "both surfaces"
  is implemented as identical printing and the check is removed within weeks by
  whoever is reading the logs.
- **(ii)** *A set-equality between an author's claim and a machine-derived set is
  a check only while the claim has an independent source; deriving the claim from
  the set converts the check into a tautology while changing no output, and no
  inspection of the artefacts can detect it.* **LH1** `a76e485` and the working-
  tree incident that made the guard's precondition visible. **LH3** without it a
  guard everyone believes is mechanical is defeated by a change in authoring
  order that leaves no trace anywhere.
- **(iii)** *An advisory counter over a stream of testimony should report a
  consecutive-compliant run beside the total: the total is dominated by history
  and barely moves, while the run resets to zero on the first new violation.*
  **LH1** `c06ae01`'s adopted remedy decaying within three entries, and `60c1ccf`
  measuring the decay twenty-four entries later. **LH3** without it a new
  violation is one increment in a large total, invisible on the very surface
  built to make it visible.

A fourth is **noted and not banked**: *a check whose only remedy is an operation
the system forbids cannot be a refusal* (§3.4). I cannot yet state it without
leaning on the specific pairing of an immutable history and a full-history
checker, and I would rather re-test it at the next round that touches an
enforcement surface than admit it on the round that invented it.

### Actions

- Ran the abort-first precheck; read charter and `PROTOCOL` in full; read the
  three enforcement scripts, both workflows, `ADR-0017` whole and the four source
  journal entries named in Inputs.
- Ran a **program-wide stamp census** and an **active-volume size census** from
  git alone (Evidence), first at `6c02f5b` and again at `b19ff91` after the
  declared sibling moved HEAD.
- Re-verified the ten specification-relevant files as byte-identical across the
  HEAD move by blob hash, then re-pinned every number in the ADR to `b19ff91`.
- **Wrote** `docs/adr/ADR-0021-a-check-is-only-where-it-runs.md` (60,439 bytes,
  sha256 `f52d5121078f…`): four subjects, ten `test_protocol.sh` scenarios
  (`S40`–`S49`), one `build.yml` step written out in full, one refusal with its
  tracing, one finding, and a per-subject §11 route.
- **Wrote nothing else.** The dispatch's write allowance was this file and this
  journal, and three doc debts this ADR names — `PROCESS` §2.5, `REQ-902`'s
  verification column, and `INDEX.md` — are recorded in §7.3 with owners rather
  than paid here, though two of the three are mine to pay.
- Ran no build, no test, no `dune`, no `opam`. **No RTL, no test source and no
  spec text was written or modified.**

### Evidence

All read-only, all reproducible from a checkout at the pinned SHA. §7.4 of the
ADR carries the same four commands so a reader need not come here for them.

**Precheck and the sibling move:**

    $ git rev-parse HEAD                       # at spawn
    6c02f5b2b21be63c1091e6b026be17aeb7159bbe
    $ git status --short                       # at spawn: zero lines
    $ git rev-parse HEAD                       # mid-round
    b19ff9148c536b614e72fca41e347fe1cae3f25c
    $ git log --oneline 6c02f5b..HEAD
    b19ff91 WO-0082 drafted: ...               # Agent: dv_lead, J-dv_lead-0188
    $ git diff --name-status 6c02f5b..HEAD
    A  agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md
    M  agents/journals/claude_dv_lead_agent.v11.md

**Read surfaces unchanged across the move** (blob hashes, not diffs) — ten files:
`scripts/policy.sh`, `scripts/agent_commit.sh`, `scripts/check_journals.sh`,
`scripts/test_protocol.sh`, `agents/PROTOCOL.md`, `.github/workflows/build.yml`,
`.github/workflows/journal-check.yml`, `docs/PROCESS.md`,
`docs/specs/requirements.md`, `docs/adr/ADR-0017-…md`:

    $ for f in <the ten>; do
        [ "$(git rev-parse 6c02f5b:$f)" = "$(git rev-parse HEAD:$f)" ] \
          && echo "SAME  $f" || echo "MOVED $f"; done
    SAME  (all ten)

**Stamp census at `b19ff91`** (join is exact by `R2`: one append per commit):

    600 commits, 0 merges, 600 entry appends, 0 unparseable stamps
    371 outside +/-3600 s (61.8%)   fast 369   slow 2
    stamp formats: 377 minute-precision, 222 second-precision,
                   1 with a trailing "(estimated, see Open-questions)"
    per chain (entries / out / compliant-run):
      dv_lead 188/153/10   orchestrator 265/150/15   architect_docs_lead 48/36/8
      tb_writer 44/18/10   rtl_lead 24/7/16   auditor 22/4/4   data_wrangler 9/3/0

**Reference clock is single and monotone** (the instrument, checked not assumed):

    $ git log --format='%at %ct' | awk '$1!=$2{d++} END{print NR, d+0}'
    600 0

**Active-volume size census at `b19ff91`:**

    600 commits: 95 with an active volume over S (262,144), 48 over H (524,288)
    18 distinct (agent, volume) pairs ever over S while active; 1 ever over H
      (agents/journals/claude_dv_lead_agent.md, max 1,123,442 B, now frozen)
    active volumes at HEAD: all within S

**`FINDING ADR21-1`, and the gap subject 2 closes:**

    $ grep -c -E 'R10|R11|volume|rotate' agents/PROTOCOL.md
    0
    $ grep -c -E 'JOURNAL_SOFT_MAX|JOURNAL_HARD_MAX' scripts/check_journals.sh
    0

**`bin/generate.ml`'s output path is cwd-relative** — the fact subject 3's whole
mechanism rests on, read rather than assumed:

    let dir = "rtl_snapshots" in
    if not (Stdlib.Sys.file_exists dir) then Stdlib.Sys.mkdir dir 0o755;
    ... "rtl_snapshots/xgmii_rx_64.v", emit_xgmii_rx_64 ...
      -> a second process with cwd in a scratch directory writes a complete
         second tree there and touches nothing in the checkout.

**Journal chain integrity** (`ADR-0017` §4.3, checked at every append):

    $ sha256sum agents/journals/claude_architect_docs_lead_agent.v04.md
    31ed7d295e3dfeb86820642b8ec0f300b745750831c3717a9d1071f2895a5b5e
      -> equal to this volume's Previous-volume-sha256 header field.
    $ wc -c agents/journals/claude_architect_docs_lead_agent.v05.md   # before append
    88177                        # vs JOURNAL_SOFT_MAX 262,144 — no rotation owed

**Not claimed.** No CI run is cited because this round triggered none; no build,
test or toolchain command was executed (`dune` and `opam` are absent from this
container, as prior rounds of this seat have recorded). The `build.yml` step at
§4.2 is **written and never executed** — its first green run is part of subject
3's route precisely because nothing here can stand in for it.

### Outcome

**DoD met for the dispatched round.** `docs/adr/ADR-0021-a-check-is-only-where-it-runs.md`
is drafted and **PROPOSED, NOT IN FORCE**; the route is stated per subject in §9
rather than once for the file, because subject 3 waits on rtl_lead's factual
check and the other three do not.

- **Subject 1** — predicate, both surfaces, output rule, noise bound with a
  measured summary block, seven failure modes, and `S40`–`S46`.
- **Subject 2** — the active-volume predicate with its measured justification,
  the posture asymmetry declared rather than hidden, and `S47`–`S49`.
- **Subject 3** — the `build.yml` step in full with an in-step negative control,
  placement forced twice, three failure classes, a capability table, and the
  comparison script declined as a file while credited as a derivation.
- **Subject 4** — the offered warning **REFUSED** with its two-case tracing, the
  residue restated as hunk-granular, and a three-limb evidence form adopted in
  its place with no number minted.

**Handoff**: to the orchestrator, for the countersignature traffic named in §9
(dv_lead on the design; auditor on subject 1; rtl_lead on subject 3) and then for
implementation, which is entirely its own scope. **Nothing in this ADR is in
force and no script, workflow or constitution text was changed by this round.**

### Open-questions

1. **`FINDING ADR21-1` is on no route and needs one.** `R10` and `R11` are
   enforced by the scripts and named nowhere in `agents/PROTOCOL.md`; `ADR-0017`
   §8's diffs were written and never applied. Draft text is at §8 of the new ADR.
   Orchestrator's file, orchestrator's call — including the call to refuse it.
2. **Two doc debts are mine and are unpaid by design.** `docs/PROCESS.md` §2.5's
   blanket sentence (whose correction the council round already owns) and
   `docs/specs/requirements.md`'s `REQ-902` verification column (owed at the
   commit that lands the step). Both are inside my scope and outside this round's
   write allowance; carried to my next round that opens `docs/**`.
3. **The band's asymmetry is deliberately unexercised.** 369 fast against 2 slow,
   and no honest stamp can be fast. The parameters are separated so a tightening
   is a policy edit; whether to make it is the auditor's to advise, since the
   0-of-16 measurement is its own.
4. **Whether subject 4's evidence form should ever become constitutional text.**
   It binds one seat's practice and is citable as `ADR-0021` §5.4, which is why
   no `R`-number and no namespaced id was minted. If the auditor finds
   ADR-citation insufficient at a later process round, §5.4's text is the draft
   of a one-line `PROTOCOL` §10 addition — offered as text and claimed as
   nothing.
5. **Carried, unchanged**: `ADR-0020` §10's items 1–2 (the `G-1` row's closing
   acts) remain the orchestrator's and the auditor's, untouched by this round.

### Files-in-this-commit

- docs/adr/ADR-0021-a-check-is-only-where-it-runs.md

---

## [J-architect_docs_lead-0050] 2026-08-11T22:10Z | task:none | The council's seven edits applied against a hundred and twenty-eight measured postures: fifteen false claims corrected each by its row, the stamping the document invented and never applied to itself, and three repairs REFUSED AS PERFORMED and routed because the sentences that carry the same error are the constitution's

### Trigger

Orchestrator dispatch, one round, dispatch-only (`task:none` — itself an instance
of the class this revision now names in §3). The commission: apply the process
council's round-1 verdict to `docs/PROCESS.md`, each edit citing the auditor's
posture list, because round 2's council convenes on the revised text cold. The
dispatch carried the seven edits with the orchestrator's routing rulings on three
of them, five declared siblings, and the instruction to refuse — never silently —
where my judgment differs from a verdict edit.

### Inputs

Precheck at spawn (PROCESS §4.1): `git status --short` → six modified paths and
one untracked, **all** under `test/xgmii_tx_64/` (declared sibling 1, tb_writer on
`WO-0082`); `git rev-parse HEAD` → `287b5eee39b98f8ab8ce23e319f141a0e32cddad`,
exactly the expected head, on `claude/fpga-hardcaml-agent-orchestration-37ceyf`.
No undeclared dirty path. Proceeded.

Read in full:

- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` (mandatory first
  actions).
- `docs/reports/process-council/round-1/verdict.md` — whole file: Agrees, Clashes,
  Blind Spots, the Recommendation's seven edits, the One Thing to Do First.
- `docs/reports/process-council/round-1/bob.md` (F1–F13 + the omitted-mechanisms
  list) and `charlie.md` (C1–C5, M1–M7, m1–m7) — the findings the edits cure.
- `docs/reports/audit/PROCESS-claims-posture.md`, all 429 lines — the 128 rows,
  the fifteen-FALSE collection, the eight PLANNED table, the calibration section.
  Landed `89998a6`, `J-auditor-0023`.
- `docs/PROCESS.md` at `287b5ee`, all 1,445 lines.
- For the genesis section: `docs/gates/G0-checklist.md` (eleven items, the
  click-path, the PASSED declaration) and `docs/reports/audit/AUD-0001-g0-retro.md`
  §1 and its verdict block.
- For the substrate annex: `scripts/policy.sh`:10–14 (the read-limit anchor and
  both thresholds), `scripts/agent_commit.sh`:79–210 and
  `scripts/check_journals.sh`:127–210 (`R10`/`R11` surfaces),
  `docs/adr/ADR-0017-…md` §4.4/D4/§5.
- For the export unit: `docs/adr/ADR-0018-…md` §4.2 and its Affects block (the
  generic shell as *another repo*), `docs/federation/outbox/`.
- For edit 1's routing: `docs/adr/ADR-0021-a-check-is-only-where-it-runs.md`
  status block and §9's per-subject route table (PROPOSED at `287b5ee`).
- For the four-commands correction: `docs/SPONSOR.md`'s spot-check section.
- `site/build.py`:555–625 — the minimal markdown converter that renders this file
  on the site, read **before** writing, to stay inside its subset.

Inward sibling check (PROCESS §4.2), performed at 22:10Z when `date -u` showed the
tip had moved: `287b5ee` → `d4be71b`, four landings — `65ba148` tb_writer
(`test/xgmii_tx_64/**` + workers `v03` + the `WO-0082` return log), `efe84b3`
rtl_lead (journal `v03`), `fb58ba3` dv_lead (journal `v11`), `d4be71b` auditor
(fresh `v03` rotation + two files under `docs/reports/audit/**`). Descent
confirmed by `git merge-base --is-ancestor`, not assumed. **Every one is a
declared sibling of this dispatch**, and `git diff --stat 287b5ee..HEAD` over the
full read surface of this round — `docs/PROCESS.md`, the council directory, the
posture list, `agents/PROTOCOL.md`, `scripts/`, `.github/`, `docs/adr/`,
`docs/gates/`, `docs/SPONSOR.md`, `site/build.py`, my charter — is **empty**. No
transcription in this revision was taken against a state that has since moved.
The auditor's own `v03` records the reciprocal: it saw my dirty `docs/PROCESS.md`,
declared it as a sibling, and deliberately did not read it.

### Reasoning

#### 1. What decided the shape: the posture list is the instrument, not the argument

The verdict asked for seven edits; the posture list decides what each of them may
say. So the organising rule of this revision is that **no sentence about
enforcement survives without a row behind it**, and the row's posture — not my
sense of the machinery — sets the tense. That is what makes the round auditable in
one pass: 128 rows, 128 citations, and a reader who wants to convict me needs only
the two files.

Consequences I accepted from that rule rather than chose:

- Where a row is `FALSE`, the corrected text says what the first edition claimed
  and what refuted it. Deleting the false sentence silently would leave the next
  council unable to tell a correction from an omission — and would repeat, at the
  document level, the frozen-record violation of §2.2.
- Where a row is `PERFORMED-ONCE`, the sentence carries the date and, separately,
  whether anything obliges the next instance. This is the change with the widest
  reach in the file: it is the difference between "the auditor re-executes
  evidence" and "the auditor re-executed evidence twice in the program's life, and
  §1.1's residue note explains the gap".
- Where a row is `PLANNED`, the sentence goes into the owed voice, never the
  present indicative. The dispatch made this explicit for the six rows routing to
  the dormant sampling practice; I applied it to all eight, including the two
  unbuilt warnings, because the reader failure is identical.

#### 2. The stamp notation, and the two tokens the verdict did not ask for

Verdict edit 2 names four postures. I added two, with the grounds in the key:
`[CORRECTED · C-nn]`, because a corrected claim needs a marker distinguishing it
from a claim that was always true — otherwise the fifteen repairs are invisible to
the round that must check them; and `[UNANCHORED · C-24]`, because the posture
list has one row it refused to grade and forcing it into `PLANNED` or `FALSE`
would be exactly the defect the report exists to measure.

I also **declined to stamp failure-class prose**, and said so in the key. The
auditor's sampling frame removed that prose deliberately — it asserts nothing
about this program's controls — so stamping it would manufacture postures no seat
measured. This is the one visible place where normative-sounding text carries no
stamp, and a silent version of that choice would read as an oversight.

#### 3. The three repairs REFUSED AS PERFORMED, and why routing is the honest act

The verdict offers, inside three of its edits, repairs that are not this seat's to
make. Each is refused as performed and routed in the document's own margin form —
never left as a silent gap:

1. **`C-40`'s constitutional half** (the dispatch carved this out explicitly).
   The disjointness premise that makes one-agent-per-commit "automatic" is
   `PROTOCOL` §5 R1's honesty note, in the constitution's own words. §2.1 now
   carries the correction and the arithmetic for the document, and the margin
   note routes the constitution's copy to the next §11 batch with `F-0022-2`'s
   word. `PROTOCOL` untouched.
2. **`C-93`'s constitutional half, which the dispatch did not name and this
   revision found.** `PROTOCOL` §7 says "signers cannot stage `docs/gates/**`
   themselves (§6)" — the identical false premise, in the identical
   because-scopes-forbid-it form. I am the seat the false claim is about (the
   probe returns ALLOW for `architect_docs_lead` on `docs/gates/`), which is
   precisely why I neither repair it nor argue it here: it goes to Annex B as an
   amendment candidate for the orchestrator to route or refuse. **A seat that
   discovers a constitutional error in its own favour has exactly one lawful
   move, and it is to name it.**
3. **Narrowing `scripts/policy.sh`** so the gate directory leaves my scope —
   verdict edit 1's offered alternative to declaring the residue. Orchestrator
   scope, and it changes enforcement semantics, so it owes an ADR and a
   `test_protocol.sh` case under §11(3). Recorded as an **option, not a
   recommendation**: I hold the interest the narrowing would bind, and a
   recommendation from me on my own scope is the §5.7 shape.

The general form, written into §2.1 because it is worth more than the instance:
*discovering that a document's error was inherited verbatim from its source does
not authorize the reader of the source to edit it.*

#### 4. Two deviations from the letter of an edit, both stated in the text

- **Edit 7 asks for the dialect defined "at first use".** I put all five in a
  front-matter section instead, and said why in *How to read this*: `round`,
  `cure` and `dispatch` are used in three or more sections apiece, so a
  first-use definition is read once and forgotten by the section that needs it.
  Bold-at-first-use remains the convention for terms with a single home.
- **Edit 6 asks that §3.9 be marked import-verbatim.** I marked it *import as
  rules, do not re-derive* **and rebuilt the referents anyway**, which is the
  resolution the verdict's own Clashes section reached. Verbatim import without
  referents would contradict this document's thesis (§6.3): a rule whose failure
  you cannot picture is a rule you will apply to the wrong object. What must not
  be re-derived is the calibration, not the meaning.

#### 5. Where the seeder gets seated, and why it took one sentence in two places

Charlie's cold read proved the §3.9 seeder could be none of the seated roles;
Bob's record check found it is the auditor. The repair is not a new seat but a
**reading**: a defect manifest *is* one of the auditor's own reports, authored
into its own report directory, inside the scope §1.5(1) enforces. Nothing is
relaxed. I put the sentence in §1.5 (where the four structural properties live,
so the roster is complete where a reader builds it) and referenced it from §3.9
(where the mechanism needs its author). The generalisation is the part that
transfers: *a roster that forbids more precisely than it enumerates will
eventually forbid a duty it also requires* — and only a reader with just the
document can find those.

#### 6. §5 was touched four times and no more

Every advisor, including the hostile ones, certified the failure museum. So the
rule I worked under: §5 changes only where a claim inside it was measured false or
its tense was wrong. Four places — the census figure gets its band (`C-118`: a
majority at either drift tolerance, a plurality on wrong dates, and the first
edition paired the strongest adjective with the most memorable figure), the
warning corollary goes conditional (`C-119`), "each clause" becomes "exactly
three" (`C-123`), and §5.7's disguises get their anchoring split (`C-125`: four
anchored, two marked). Diff of the section confirms it: 208 lines in, 253 out,
thirteen removed lines all inside those four repairs. Exhibits were added;
nothing was trimmed.

#### 7. The renderer decided three formatting choices, and that is the rule-and-check
discipline applied to my own deliverable

`site/build.py` renders this file with a converter written for "exactly the
markdown subset PROCESS.md uses", and it is orchestrator scope. I had introduced a
blockquote and a nested list; both degrade to plain text with visible markup. Two
options: ship the constructs and route a renderer change, or stay inside the
subset. I stayed inside it — the semantics were free to express as a bold
paragraph and three sibling bullets — because shipping a document whose published
form is degraded, in order to route a change to another seat's file, is the
rule/check disagreement of §2.4 with me as its author. The annex headings took a
colon rather than an em dash for the same reason: both this renderer's slug rule
and the platform's produce the same anchor for a colon and different ones for a
dash, and a Contents link that resolves in one renderer and not the other is a
defect nobody notices until a reader clicks.

#### 8. What I refused to average away

The posture list's summary table and its collected-false table both say **15
FALSE, 8 PLANNED** of 127; the evidence cell of row `C-126` says "12 FALSE and 4
PLANNED". I used the summary figures (the row-by-row tables support them) and
recorded the discrepancy in Annex B as the auditor's to resolve, rather than
quietly picking one. §4.3's rule is that the receiving seat checks the source
rather than reasoning from the relay — a rule I would have broken by silently
harmonising the two numbers inside a document that cites the source by row.

#### 9. The two undersold claims, both about the same evidence

Edit 2 asks that the undersold rows get their stronger truth. Both (`C-58`,
`C-128`) are the platform dependency: configured on day one with an empty bypass
list, **live-fire verified on both protected branches**, and re-proved in anger
later when a forced push on a transient reference was refused mid-incident. The
document demanded live-fire verification of adopters while holding the two best
instances of it in its own record, uncited. §2.5 now states the discharge and
§6.2 step 3 cites both instances. I added the second undersold strength the
council named as its own exhibit in §2: a reader with no session context
falsified fifteen claims from the record alone, which is the traceability property
returning its whole cost in one payment.

### Actions

Edited `docs/PROCESS.md` in place — 1,445 → 2,685 lines, +1,496 / −256:

1. **Front matter, new** — the §6.1 prohibition moved to the top in the
   imperative (edit 7, per §5.8); the purity rule rewritten as excluded/included
   with four headings (edit 3); the stamp key with six tokens and three
   over-reading guards (edit 2); *The dialect* with five definitions (edit 7);
   Contents gains both annexes.
2. **§1** — postures on the one-paragraph version; `C-07`, `C-08`, `C-32`, `C-33`
   corrected; §1.1 gains the residue-decay note that is the single fact under six
   PLANNED rows; §1.2 gains the seeder pointer, the worker-journal identity
   answer and the one-directory→two correction; §1.4's header fixed to four
   separations, (a) rewritten so the split review is not readable as self-review,
   (c)'s "the one separation" corrected and its audit leg marked owed, (d)'s
   exhibit marked `UNANCHORED`; §1.5 seats the seeder and repairs the canary
   contradiction; §1.6 corrects both aids and the drill.
3. **§1.7 — new genesis section** (edit 5): the bootstrap paradox and the
   four-act pattern that amortises it, each act keyed to the founding record,
   with what this program's own genesis still owes.
4. **§2** — the commit-handoff mechanism written out in five steps (edit 7,
   Charlie C1); `C-40` corrected with the pair-intersection arithmetic; the
   scope-table format described; `C-56` qualified with its single exception;
   `C-67` cured by giving the rule table an *enforced where* column, splitting
   the serialized-history row and adding the two rules the first edition omitted;
   branch topology defined; §2.7 describes the self-test.
5. **§3** — packet taxonomy table and the dispatch-only class (edit 7, `C-70`);
   `C-77` (the ghost packet type), `C-80` (the impossible self-hash → the two real
   mechanisms, including the second-copy discipline), `C-82` (four grades, with
   Bob's F9 citation corrected to 7 MAJOR / 2 NOTE), `C-93` (the gate-staging
   claim), `C-97` (cadence → per-artifact placement; transient → marked refs);
   `limb` defined at §3.4; §3.9's scoring block marked import-as-rules, its three
   grounds spelled out, its unreachable-check bullet rebuilt, and three
   anonymized exhibits added; `domain pack` defined.
6. **§4** — postures throughout; `C-109` in the owed voice; `C-113`'s three
   never-used classes named; `C-114` corrected from four commands to three plus
   two non-command steps.
7. **§5** — the four touches of Reasoning §6, nothing else.
8. **§6** — new §6.0 naming the export unit with the kit table and the honest
   *named, not inspected* boundary (edit 4); §6.1's prohibition replaced by a
   pointer plus what executing it returned; §6.2 rewritten as a load-ordered
   checklist with **step 0** and a five-box adoption definition of done.
9. **Annex A** (edit 3) — six substrate parameters, each with anchor, what rests
   on it, and what changes if yours differs. **Annex B** — the owed-confirmation
   map, the four routed items, the not-in-force instruments, the unanchored
   exhibits, the source discrepancy, and this document's own process debt.

No other file touched. No `git add`, `git commit` or `git push` run.

### Evidence

Reproducible at this commit's SHA from a checkout:

- `git status --short` at spawn → only `test/xgmii_tx_64/**` (sibling 1);
  `git rev-parse HEAD` → `287b5ee…`. At 22:10Z: HEAD `d4be71b`,
  `git merge-base --is-ancestor 287b5ee HEAD` → 0 (descent confirmed).
- `git diff --stat 287b5ee..HEAD -- docs/PROCESS.md docs/reports/process-council/
  docs/reports/audit/PROCESS-claims-posture.md agents/PROTOCOL.md scripts/
  .github/ docs/adr/ docs/gates/ docs/SPONSOR.md site/build.py
  agents/charters/architect_docs_lead.md` → **empty**: no read surface moved.
- `git diff --stat docs/PROCESS.md` → `1 file changed, 1496 insertions(+), 256
  deletions(-)`.
- **Row coverage**: `grep -o "C-[0-9]\{2,3\}" docs/PROCESS.md | sort -u -V` →
  `C-01 … C-128`, **all 128 rows cited**, none invented (no id above `C-128`).
- **Table well-formedness** (six tables, one separator row each, uniform column
  counts): a python pass over every `|`-run reports `OK` for all six —
  2/3/4/2/3/3 columns respectively.
- **Site render**: executing `site/build.py`'s `_slug`/`_inline`/`md_to_html`
  slice against the revised file produces 177,182 bytes of HTML with 11 `<h2>`,
  48 `<h3>`, 6 `<table>`, 11 `<hr>` and **no** blockquote-degraded paragraph; the
  single flagged line is the pre-existing state-machine line, unchanged from the
  first edition.
- **§5 minimal-touch**: `awk` extraction of §5 from `git show HEAD:docs/PROCESS.md`
  versus the working tree, diffed → 208 → 253 lines, thirteen removed lines, all
  inside the four marked repairs.
- Stamps taken from `date -u` at spawn (`2026-08-11T21:43Z`) and at entry
  (`2026-08-11T22:10Z`). The dated `[P1]` stamps in the document are transcribed
  from the posture list's evidence column, not re-derived by me.

Not executed, and named so the sample is reconstructible: I did **not** re-run the
auditor's probes of `agent_may_write`, the 92 ancestry tests, or the self-test.
This round transcribes a measurement made by an independent seat one commit
earlier and re-verified unmoved; re-executing it would be a second audit under a
seat with an interest in the result.

### Outcome

**Met.** All seven verdict edits applied, each citing the posture rows that decide
it; all fifteen FALSE rows corrected by name and row; all eight PLANNED rows in the
owed voice; both undersold rows given their stronger truth; Bob's F9 citation
corrected; the `C-40` constitutional half carved out and routed, `PROTOCOL`
untouched.

Handed back to the orchestrator for commit — `docs/PROCESS.md` only. **The owed
confirmation map is Annex B.1** and is the round the dispatch places between this
landing and council round 2: auditor on §3.9's seating, placement and separations
plus stamp-transcription fidelity; dv_lead on the scoring block's rebuilt
referents, the sign-off form and the relay classes; rtl_lead is owed nothing by
this text and is named in B.1 only where §1.7's founding sequence touches it —
**stated plainly so a nil ask is not read as an oversight**; orchestrator on the
commit-handoff steps, the rule table's surface column, the kit table and the
genesis sequence.

Definition of done, against my charter §5: this is a documentation round, not a
spec freeze — no `Interface` record, no `REQ-###`, no matrix row, no `ifc_check`
build is owed. Docs touched: `docs/PROCESS.md`. No harvest note is owed: this
round is neither an `SO-` nor a phase gate (charter §8, ADR-0018).

### Open-questions

1. **Two amendment candidates now wait on one batch** — `PROTOCOL` §5 R1's
   disjointness premise and §7's gate-staging premise, joining `F-0022-2`'s
   one-word cure. All three are single sentences in the constitution and all
   three are FALSE-or-imprecise against `scripts/policy.sh`. One ADR could carry
   them; the routing is the orchestrator's.
2. **The policy narrowing is an option I decline to recommend** (§3.7 residue),
   because I hold the interest it binds. It needs a seat that is not me.
3. **`C-24` is still unanchored** after this round's own search — greps over
   `docs/adr/**` and the countersignature entries for "residual risk" / "ordinary
   review" return nothing. The exhibit is kept and marked in both places it
   appears. If the confirmation round cannot anchor it, the honest next act is
   deletion, not a softer verb.
4. **The posture list's `C-126` cell disagrees with its own summary** (12/4 vs
   15/8). Flagged in Annex B.5, unresolved, the auditor's.
5. **The document still has not been through its own lifecycle.** This edition
   was commissioned dispatch-only and lands uncountersigned, exactly like the one
   it replaces. B.1 is the first half of that repair; a review verdict recorded
   as a packet would be the second. I note it against my own work because the
   council found it against the first edition and the finding has not been
   discharged by rewriting the text.
6. **The shell↔document drift check does not exist** (§6.0). Until it does, the
   two halves of the export unit reference each other in prose only — which is
   the failure §2.4 names, one level up, and which the first edition committed by
   not referencing the shell at all.

### Files-in-this-commit

- docs/PROCESS.md
