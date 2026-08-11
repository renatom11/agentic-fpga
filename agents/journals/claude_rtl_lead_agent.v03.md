# Journal: claude_rtl_lead_agent — volume 03

- **Agent**: rtl_lead (Opus 5 lead)
- **Charter**: agents/charters/rtl_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 03
- **Continues-from**: J-rtl_lead-0022
- **Previous-volume**: agents/journals/claude_rtl_lead_agent.v02.md
- **Previous-volume-sha256**: 6142fa68064566e2f42a95cd8151d4f755c5b112327ae2999d46f1018dc9b56c
- **Previous-volume-bytes**: 243869

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 02 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-rtl_lead-0023] 2026-08-11T17:45:07Z | task:none | Volume 03 opened one entry *before* the threshold rather than one entry after it, so that no volume of this chain is ever unreadable in a single call; and ADR-0020 §7.3's generalised limb COUNTERSIGNED unconditionally with one non-blocking finding — the limb re-routes none of the four measured post-freeze rows that touch this seat, and its em-dash list carries an undeclared status that fails in opposite directions

### Trigger

Orchestrator dispatch, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`,
one round and two acts: this seat's own scheduled journal rotation, and act 4 of
ADR-0020's §9.2 route — the countersignature that ADR names this seat for, scoped
to §7.3's generalised limb and to nothing else.

**Abort-first precheck, run before anything was read.** `git status --short`
printed nothing — a wholly clean tree — and `git rev-parse HEAD` returned
`82641833837e2d1245f3f7c4ef2865a9e1024c20`, an exact match with the dispatch's
expected `8264183`, so neither the descendant branch nor the forensic-refusal
branch was reached. The dispatch declared the auditor and dv_lead live on
parallel countersignature rounds, each writing only its own journal, with the
orchestrator possible on journal/board/site; the tree was clean of all three at
entry. The precheck was **re-run immediately before this file was written**:
`git status --short` still empty, HEAD still `8264183`, and the two chain fields
below recomputed at that moment rather than carried from the first reading. No
sibling moved HEAD during this round.

The rotation is not news to this chain either. `J-rtl_lead-0022` did not itself
predict the threshold crossing — the dispatch attributes a `0023` heads-up that
this chain's `0022` does not contain, and the correction is recorded here rather
than accepted silently: the flag lives at `J-rtl_lead-0014`, whose Trigger
records volume 01's rotation as *"a scheduled act redeeming a written
prediction, not a threshold discovered at a refusal"*, and the same posture is
what produces this rotation. What is true is the arithmetic, and §1 measures it.

### Inputs

Read this round, in order, at `8264183` unless stated:

- `agents/charters/rtl_lead.md` — mandatory first action. §3 (the three acts of
  this line: implement, emit, accept-at-review), §4 (the architect interface:
  implementability feedback pre-freeze, spec-change requests post-freeze), §5
  (DoD), §7 (escalation), §8 (journal obligations, harvest note).
- `agents/PROTOCOL.md` — §4 entry grammar and §4.2 set-equality, §5 R1–R9,
  §6 write-scope table, §7 gates and the single countersignature it names,
  §10 independence, §11 amendment procedure.
- `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md` — **read
  whole**, as the dispatch required, and not only at the limb: §0 (what is in
  force, which is nothing), §1.1–§1.3, §2 (D1–D9), §3 and §4 (the `PROTOCOL`
  hunks, authored there and applied elsewhere), §5, §6.1–§6.4, **§7.1–§7.5**,
  §8, **§9.1–§9.4**, §10 (owed acts), §11, §12.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` — §4.1 layout, §4.2
  entry-id continuity, §4.3 the header and the back-link, **§4.4 the four-step
  rotation**, §5.1 the thresholds and what anchors them, §6.2 the warning and
  refusal semantics, §6.3 `Continues-from`, §6.4–§6.5 the chain checks.
- `scripts/policy.sh` — `JOURNAL_SOFT_MAX` / `JOURNAL_HARD_MAX` at `:13-14`, and
  `agent_may_write`, executed (Evidence 1).
- `agents/journals/claude_rtl_lead_agent.v02.md` — this seat's own volume 02,
  whole-file entry census and the tail of `J-rtl_lead-0022` (Outcome and
  Open-questions), which §10 below restates rather than cites across the
  boundary.
- `docs/specs/SPEC-TEMPLATE.md` §11, §12, §13 — the freeze record's signature
  rows and the change log's columns, which are the limb's landing site.
- `docs/specs/requirements.md` §13 — the revision record's preamble and its
  countersignature-owed rows; the five occurrences of the **C-43 axis ruling**.
- `docs/specs/modules/eth_axis_tx.md` §13, `docs/specs/modules/eth_axis_rx.md`
  §13, `docs/specs/modules/xgmii_rx_64.md` §13, `docs/specs/modules/ip_eth_tx_64.md`
  §13 — the four post-freeze rows that touch this seat's line, which §5 runs the
  limb over.

**Not consulted**: `Essenceia/Nasdaq-HFT-FPGA`, nor any other CC BY-NC material.
This round opened no file under `libs/`, `top/`, `bin/` or `rtl_snapshots/` and
made no design decision, so the licensing question has no instance; the
declaration is made anyway because charter §8's Inputs-honesty rule is a standing
obligation and not a conditional one.

### Reasoning

---

#### 1. Act 0 — the rotation is taken one entry *before* the threshold, and that is a stronger reading of ADR-0017 than the one this chain used last time

**The arithmetic, measured rather than estimated.** Volume 02 stands at
**243,869 bytes** at HEAD and on disk (they agree — Evidence 2), against
ADR-0017 §5.1's soft threshold `S` = **262,144**. Headroom is therefore
**18,275 bytes**. The per-entry sizes of volume 02, computed over the file
(Evidence 2), are 18,587 / 29,060 / 21,954 / 22,838 / 23,900 / 23,453 / 41,648 /
38,348 / 23,365 — mean 25,906, and a **minimum of 18,587**. The smallest entry
this seat has ever written into volume 02 exceeds the remaining headroom by 312
bytes. There is no entry this chain could append that leaves volume 02 under `S`,
and this entry — a countersignature with a four-instance measurement in it — is
not going to be the first.

So the next entry crosses `S` with certainty rather than with probability, and
the only question is which side of the crossing the rotation sits on.

**Why the pre-emptive side, and why that is a reading of the ADR rather than a
departure from it.** ADR-0017 §5.1 anchors `S` to a *measured environment fact*:
the Read tool refused a 349.2 KB journal because *"File content … exceeds maximum
allowed size (256KB)"*, and the section states the design intent in one sentence
— **"One volume should be one readable unit."** The threshold is the alarm; the
readable unit is the goal. A chain that rotates *after* crossing leaves exactly
one volume permanently over the line — volume 01 of this chain is 270,152 bytes
and is that volume, frozen at that size forever. A chain that rotates *before*
crossing leaves none.

Rotating here costs nothing that rotating one entry later would not also cost —
the same one file, the same one header, the same one entry (§4.4 steps 1–4) — and
it buys the property the threshold exists to produce. Nothing in ADR-0017
requires a volume to exceed `S` before it may be frozen; §6.2's warning and §6.4's
refusal are *ceilings*, and a ceiling is not a floor. The one thing a pre-emptive
rotation must not do is become an excuse to rotate at will, so the standard this
entry commits to is stated and is falsifiable: **rotate when the next entry
cannot be shown to fit**, which is an arithmetic test on measured entry sizes and
not a preference. Here it is discharged with 312 bytes to spare against this
chain's own minimum, and by a wide margin against its mean.

**Consequence, stated so no reader has to derive it**: volume 02 ends at 243,869
bytes, under `S`, and is the **first volume of this chain that is one readable
unit**. Volume 01 is not and cannot be made so. That is the whole gain and it is
worth one entry's worth of foresight.

**The four steps, executed** (ADR-0017 §4.4). (1) `sha256` of the predecessor
computed *from git* and cross-checked against disk, both
`6142fa68…8dc9b56c`, both 243,869 bytes — recomputed rather than accepted, and
recomputed a second time after the HEAD re-verification, because a chain field
copied from a dispatch is a field nobody checked. (2) This file created with the
§4.3 header and **exactly one** entry, `J-rtl_lead-0023`, continuing the id
namespace across the boundary per §4.2 — not restarting at 0001, which would make
`J-rtl_lead-0001` ambiguous across three volumes and destroy the contiguity
drop-detector. (3) Volume 02 **not touched and not staged**. (4) Handed to the
orchestrator, which verifies the two chain fields independently at commit; my
side of that verification is Evidence 2 and the ADR's design is that both sides
have to agree.

`Continues-from: J-rtl_lead-0022` is the join point and it is the field that makes
the boundary non-forgeable from either side: volume 02's last entry id and this
file's declaration have to match, and §6.3 refuses the commit if they do not.

---

#### 2. Act 1 — what I am signing, stated as an exclusion before it is stated as a scope

The route names this seat for **§7.3's generalised limb only** (§9.2 act 4:
*"countersignature — rtl_lead, on §7.3's generalised limb only … that limb newly
makes rtl_lead a possible signer of post-freeze spec diffs. Owed by the rule's
own test (§7.5)"*). Four things I have read and am **not** signing, listed first
because a countersignature that is vague about its edges is worse than none:

1. **The `PROTOCOL` §7 and §10 hunks (§3, §4) and their four sub-clauses
   (b.1)–(b.4).** These are routed to the auditor (acts 2, on (b.2) and (b.3))
   and to dv_lead (act 3, on (b.1), (b.2), (b.4) and §4). They bind the seeder
   and the score. I hold neither. **I state no view on them here**, including no
   view on whether M03's record satisfies the amended clause — §9.4 is explicit
   that acceptance passes nothing, and it would be improper for the graded line's
   own lead to offer an opinion on the gate that grades it.
2. **§5's `G-9` reading and §6's equivalent-mutant standard.** Same grounds.
3. **§7's dv-limb** — the own-derivation waiver. §7.5 disposes of it correctly:
   its author is the party whose signature it waives, *"and the waiver is the
   signer's own, which is the correct authority for a waiver."* Nothing is owed
   to me there and I claim nothing. It matters to my reading of the generalised
   limb (§5 below turns on it) but reading a clause is not signing it.
4. **§8's item-70 ruling**, which §0 says is in force for the architect's own
   practice and no one else's.

**What I am signing** is the adaptation itself: that §7.4's operative text reads
*the constrained party* rather than *dv_lead*, with the three bounds §7.3 attaches
to it. That adaptation is what makes this seat a possible signer of post-freeze
spec diffs, which is a thing it has never been, and the question §7 defines for
the act is exactly one: **is the guard exactly the rule, or is it wider than it?**

---

#### 3. §7.5's factual predicate, checked rather than accepted

§7.5 asserts the limb *"newly makes rtl_lead a possible signer."* If that were
false — if some existing rule already made this seat a spec-diff countersigner —
the limb would be a restatement and the signature would be a formality. So I
measured it (Evidence 3):

- `docs/specs/SPEC-TEMPLATE.md` §12, the freeze record, names exactly **two**
  signature rows: `| Architect signature | J-architect_docs_lead-NNNN |` and
  `| dv_lead testability countersignature | J-dv_lead-NNNN |`. There is no
  rtl_lead row and never has been.
- §13, the change log — the section the limb lands in — carries columns
  `Date | Change | Breaking? | ADR | Journal` and names **no** signature at all.
- `docs/specs/requirements.md` §13 states a countersignature is owed **14 times**
  (8 × *"dv_lead's countersignature is owed"*, 6 × *"dv_lead's re-countersignature
  is owed"*). The count of *"rtl_lead's countersignature is owed"*, across
  `requirements.md` and all twenty module specs, is **zero**.
- Every `§12` countersignature row across the twenty module specs is dv_lead's
  testability countersignature. There is no other kind.
- `agents/PROTOCOL.md` §7 names exactly one countersignature, dv_lead's at
  `P<n>-spec-freeze`.

**Predicate verified true.** This seat appears in the spec change logs, but never
as a signer — it appears as the *source* of a finding or the *commissioner* of a
row (`C-RL-8` at `requirements.md` §13's 2026-08-11 row, whose Commissioned-by
cell reads *"rtl_lead, carry-forward C-RL-8, derived at `J-rtl_lead-0020` §5 and
Open-questions 1 and routed undecided through the orchestrator"*). The limb
therefore changes something real for this seat, and the signature is not
ceremonial.

**And it changes it in exactly one direction, which is the narrow fact that makes
the signature cheap and honest.** `PROTOCOL` §6 gives this seat `libs/**`,
`top/**`, `bin/**`, `rtl_snapshots/**`, `agents/handoffs/**` — and no part of
`docs/**`. Executed rather than read (Evidence 1): `agent_may_write rtl_lead` is
**REFUSED** for `docs/specs/SPEC-TEMPLATE.md`, `docs/specs/requirements.md` and
`docs/specs/modules/eth_axis_tx.md`, and ALLOWED for `libs/`, `rtl_snapshots/`
and `agents/handoffs/`. **This seat can never be the author of a post-freeze spec
diff.** So the limb binds me as a *signer* and can never bind me as the *author*
whose clause is being checked. Bound 1 (*"a clause that constrains only its own
author owes nothing"*) can never fire in my favour on a spec diff, because I can
never be that author. I say this plainly because it is the asymmetry a later
reader should know I was operating under when I signed: the rule I am
countersigning imposes duties on me and confers none on anybody at my expense.

---

#### 4. The limb read against the record, not against itself — four measured rows

The dangerous way to countersign a routing rule is to reason about it abstractly
and pronounce it sound. The test that actually discriminates is to run it over
the post-freeze rows that already exist and ask whether it re-routes any of them.
Four rows in the committed change logs touch this line. I ran the limb over each.

**Row 1 — `requirements.md` §13, 2026-08-11, `C-RL-8` (`J-architect_docs_lead-0041`).**
The largest post-freeze diff this seat has ever commissioned: §0.5 gains the
output offset `q`, the identity becomes `L = 8·ΔC − h + q`, and the straddle test
becomes `(h − q) ≡ 0 (mod 8)`. Author: architect_docs_lead. What it lands, in the
row's own words, is *"a **permission**: a monitor may no longer demand a single
per-octet latency under injection at M07 or M15."* That is a **scope on what a
bench may assert** — the constrained party is **dv_lead**, and the row routes it
there: *"dv_lead's countersignature is owed, on q's definition, the two amended
identities, the whole-number bullet, the Cycles clause and the straddle test."*
Does it constrain the RTL line? The row answers in terms: *"no conformant design
and no committed test changes meaning,"* and *"the M07 RTL landed at `cddad51`
was written to §6.1's table with this defect already named in its own doc
comment."* **Under the limb: dv signs, I do not. Identical to the record.**

**Row 2 — `docs/specs/modules/eth_axis_tx.md` §13, 2026-08-11, the same diff at
M07's own §7.** Same disposition, and with a second reason on top: the figures the
row lands (`L = 22`, `q = 6`, `ΔC = 2`) are ones the row itself credits to this
seat — *"`J-rtl_lead-0020` §5, which derived L = 22 independently — that
independence is what this row rests on rather than my arithmetic alone."* Even
had the row constrained my line, the **dv-limb's own-derivation waiver** — *"no
countersignature when every figure it lands is the signer's own derivation"* —
disposes of it: my own arithmetic handed back to me verifies nothing. **Under the
limb: nothing owed to me, by two independent routes.**

**Row 3 — `docs/specs/modules/eth_axis_rx.md` §13, 2026-08-11, M06's four
deciding-input-word repairs.** *"What changes is what a bench may assert under
injection, and M06 has no bench."* Constrained party: dv_lead. **Not me.**

**Row 4 — `docs/specs/modules/xgmii_rx_64.md` §13, 2026-08-04, the closure-record
age-skew note.** This is the row closest to my line in the whole log — it exists
because of *my* escalation (`J-rtl_lead-0010` escalation 3) and it describes how a
consumer must read an internal record. And its disposition is the negative one:
*"marked non-normative and not a DV observable … so `traceability.md` claims no
coverage and **no countersignature is owed**"*, quoting `RV-0060-VERDICT` §7 —
*"as guidance it costs nothing and owes me no countersignature."* A clause that
is normative nowhere constrains nobody. **Under the limb: nothing owed, to anyone.**

**Result: four rows, zero re-routings.** The generalised limb reproduces the
record's own routing at every instance the record contains, and adds no traffic
to this seat retroactively. That is the width answer in its measured form, and it
is much better evidence than my agreeing with the argument would have been.

**One consequence that must be said out loud rather than left implied**: the
limb's first live instance for this seat is therefore **prospective**. As of
`8264183` it creates zero owed signatures for rtl_lead. I am signing a rule whose
first application to me has not happened, which is the correct time to sign it and
the reason §9.3 puts the contest window before acceptance.

---

#### 5. The width test proper — the em-dash list has an undeclared status, and the two available readings fail in opposite directions

§7's own statement of what a countersignature is *for* is the standard I have to
apply to myself: *"whether the guard is **exactly** the rule rather than wider
than it, which only the constrained party can answer."* Having found no
re-routing in the record, the honest next question is whether the *text* would
produce one, and here I do have a finding. It is filed as **`FINDING C-RL-10`**.

The operative sentence (§7.4's source text, which has **not** landed — act 7
postdates act 4 in §9.2's own table):

> It **owes one from the constrained party** when it lands a clause that
> constrains a party other than its author — a prohibition, a licence, or a scope
> on what another line may build or assert.

The em-dash list's status is not declared. Both readings are available and each
breaks something:

**(a) Read the list as definitional** — the class *is* prohibition, licence, and
scope-on-building-or-asserting. Then it is **too narrow for my line**, because it
enumerates two of my three acts and omits the third. Charter §3 gives this seat
three acts a spec clause can reach: it **builds** (implements `libs/**`), it
**emits** (`bin/generate.exe` into `rtl_snapshots/**`), and it **accepts** — the
`RV-` verdict, which is the act that puts a worker's module into the tree and
which charter §3 makes unskippable (*"Acceptance without documented review is an
audit finding against you"*). *Build* reaches the first two. A clause scoping
what may be **accepted at review** — *"no module may be accepted while X"* —
constrains my line, is not a prohibition on building, is not a licence, and is not
a scope on what may be built or asserted. Under the definitional reading it routes
to nobody, and the party who has to live inside it never sees it. dv's original
text said *"what a bench may assert"* and the generalisation added *"build"*;
adding one verb generalised the sentence from one line's principal act to another
line's principal act, and stopped one act short.

**(b) Read the list as illustrative** — the general phrase is the trigger. Then
it is **too wide**, because *every normative sentence of a module specification
constrains the RTL line*. That is what a specification is. Under the literal
trigger, an editorial repair to SPEC-M07 §7 — which is precisely what Row 2 above
*was* — lands a clause constraining a party other than its author and owes me a
signature. The record settled that row without me, and it was right to. So under
reading (b) the text is wider than the practice the record demonstrates.

**And the filters that make the practice right are both real, both already ruled,
and neither is in the source text.**

- **The C-43 axis ruling**, stated five times in `requirements.md` §13 (Evidence
  4): *"the class and the countersignature question are different axes."* The
  editorial/behavioural class does **not** decide the countersignature — an
  editorial row can owe one. What decides it, in every one of those rows, is
  whether the diff moves **normative text in the constrained party's own
  instrument**: §0.5 is *"normative text in the test-derivation basis"*,
  REQ-016's verification column is *"dv_lead's own commissioning instrument"*,
  and Row 4's note owes nothing because it is *"normative nowhere"*. That test is
  sharper than *"constrains a party other than its author"* and it is the one the
  record actually applies.
- **The dv-limb's own-derivation waiver**, which is what kept Row 2 off my desk.

The ask is therefore small and is a transcription rather than an invention: **one
sentence declaring the list illustrative, and importing the "normative text in the
constrained party's own instrument" test** — both of them this program's own
rulings, quoted from its own committed artefacts. The obvious alternative repair —
filtering on the editorial/behavioural class — is **refused in advance and by the
record**, because C-43 already ruled the class and the countersignature to be
different axes, and a rule that filtered on class would convict itself against
five committed rows.

**The check that this finding is not self-serving**, which I owe because a
constrained party filing a finding about its own traffic is exactly where
self-service would hide: the two halves move in **opposite** directions. Importing
the *normative-text-in-the-instrument* test **narrows** the trigger — fewer
signatures owed to me. Declaring the list illustrative **widens** it — a clause
scoping `RV-` acceptance would newly route to me, which is traffic I do not have
today. The net effect on this seat's workload is not reliably downward, and I am
asking for the half that costs me as well as the half that saves me. A finding
that only ever reduced its filer's obligations would be one to distrust; this one
does not.

---

#### 6. Bound 1, tested against a clause of my own rather than in the abstract

§7.3's first bound: *"A clause that constrains only its own author owes nothing.
That is dv's own first limb, generalised: your own derivation returned to you
verifies nothing."*

I have a live instance in my own record and it is the right way to test the bound.
`J-rtl_lead-0022`'s Outcome states, of the CI run that commit triggers:

> a second red printing a *different* sha for this path, with `bin/` and `libs/`
> unmoved, is a REQ-902 defect that comes back to me and **must not be
> re-promoted**.

That is a prohibition — *"must not"* — landed in a committed artefact by this
seat, constraining this seat. It is the REQ-902 posture the dispatch names. Under
bound 1 it owes **no** countersignature, and that is the correct answer: nobody
else needs to check the width of a guard I wrote against myself, because the
party who would have to live inside an over-wide version of it is me, and I
already do. Had the bound been written the other way — *every* prohibition owes a
signature — it would have generated traffic on a clause with no second party to
protect. **Bound 1 is exactly the rule and not wider than it**, tested on my own
record rather than on a hypothetical.

---

#### 7. Bounds 2 and 3 — what I check, and what I decline to check

**Bound 2** — *"This rule does not touch the `P<n>-spec-freeze` countersignature …
it is unmoved, unqualified and unreduced."* This bound protects **dv_lead's**
gate signature, not mine; `PROTOCOL` §7 gives this seat no signature at
spec-freeze at all, and §3 above measures that there is no rtl_lead row in any
spec's §12. **I therefore do not certify bound 2 — it is not mine to certify**,
and dv_lead's act 3 is where it is checked by the party it protects. I record
only that I read it, that it is a carve-out rather than a grant, and that nothing
in it reduces anything of mine (there being nothing of mine there to reduce).
§7.3's stated ground for the bound — *"A rule that quietly shrank a gate signature
would be `A2.1` in a third place"* — is the right instinct and I note my agreement
without dressing agreement up as verification.

**Bound 3** — *"It reduces no obligation that a finding created. A diff answering
a finding owes whatever the finding's own contest window owes, independently of
this rule."* This one I can check on my own ledger, and it comes out clean: this
seat has **no** outstanding finding against a post-freeze spec diff at `8264183`.
`C-RL-8` was answered by `J-architect_docs_lead-0041` and left this ledger at
`J-rtl_lead-0022`. `C-RL-9` is a defect in **my own** file
(`libs/hardcaml_ethernet/src/eth_axis_tx.ml`'s doc comment), not in a spec, so no
spec-diff contest window exists for it. **Bound 3 has no live instance on this
seat, and I state that as the reason I can affirm it only negatively.** It is
correctly drafted — a rule about routing must not silently discharge a debt
created by a different instrument — but I have not exercised it and say so rather
than implying I have.

---

#### 8. What the limb does *not* reach — the two RTL-side items the dispatch named, answered narrowly

The dispatch asked whether the limb's generalisation touches this seat's `C-RL-6b`
watch value or the REQ-902 posture, as the nearest RTL-side analogues of
evidence-form discipline. **It touches neither, and the reason is a scope fact
rather than a judgement:**

- **The `C-RL-6b` watch value** is
  `48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04`, the sha256
  of `rtl_snapshots/eth_axis_tx.v` promoted at `J-rtl_lead-0022`. It is a
  *netlist digest*, and what it will be compared against is a later CI run's
  print of the same path. Nothing about it is a clause in a specification, so no
  countersignature rule of any width reaches it. Its resolution is REQ-902's, and
  REQ-902's instrument is `.github/workflows/build.yml` — the orchestrator's
  scope, unchanged by this ADR (§10 restates the route).
- **Evidence-form discipline** in this ADR lives at **(b.2)** — *the unmodified
  committed diff, replayed against the bench at the gate SHA, at a run id, with
  the killing unit named* — and at **(b.3)**'s proof standard. Both are routed to
  the auditor and dv_lead (acts 2 and 3), **not to me**, and §2 above records that
  I state no view on them. The nearest analogue on my seat is real but it is a
  *parallel*, not an overlap: my REQ-902 posture and (b.2) are both rules about
  *what evidence licenses a repeated act* — mine says a promotion is never
  repeated over a nondeterminism signal, (b.2) says a survivor is never argued
  dead by anything weaker than a replay. They rhyme. They do not intersect, and I
  will not manufacture an intersection to make this signature look weightier than
  it is.

**Where the limb does reach my seat's obligations** is stated in §3 and is
exactly one thing: it makes rtl_lead a possible signer of a post-freeze spec
diff, in a namespace where it has never been one. My DoD (charter §5) is
unchanged; my escalation routes (charter §7) are unchanged — a spec defect I find
mid-implementation still goes up as a spec-change request to architect_docs_lead
via the orchestrator, and the limb adds a signature *on the architect's answering
diff* rather than replacing my request with one; my review obligations (charter
§3) are unchanged. Nothing about the line-rate invariant, the determinism
obligation, or the RTL DoD moves.

---

#### 9. The verdict — a signature and not a refusal, and the ordering is what makes that proportionate

A finding about the width of a guard, filed by the constrained party, sitting
inside a countersignature whose whole stated purpose is *"whether the guard is
exactly the rule rather than wider than it"* — the obvious question is why that is
not a refusal. §9.3 makes refusal available and consequential: *"A refusal
received before act 5 **blocks the clause it names** and returns it to this seat
for a redraft."* Three reasons it would be the wrong instrument here, in
increasing order of weight:

1. **The record does not need the repair to route correctly today.** §4 measured
   four rows and the limb re-routes none. A defect that produces zero wrong
   answers on the entire existing corpus is a drafting defect, not an operating
   one.
2. **The ADR's own ordering already gives the finding its window.** §9.2 puts the
   `SPEC-TEMPLATE` §13 text at **act 7**, *after* act 4 and explicitly
   *"separable from acts 5–6"*. The text I am filing against **has not landed and
   cannot land before my signature**. Blocking would buy a redraft window that the
   sequencing already provides for free, at the cost of stalling acts 5–6, which
   concern clauses I am not signing and have no standing to delay.
3. **The general reason, and it is the one worth keeping.** Over-width is not one
   failure mode but two, and they cost differently. A guard wider than its rule
   that **forecloses conduct** — `J-dv_lead-0176`'s `W = 2` conversion rule, the
   conviction §7.2 builds this whole rule on — costs the conduct, irreversibly,
   to a party who cannot recover it. A guard wider than its rule that **routes
   traffic** costs a round: the worst case is that I am asked for a signature I do
   not owe, and the remedy is in my own hands at the point of use, since answering
   *"this clause constrains nothing of mine; nothing is owed"* is itself a
   legitimate act under this very rule. **Blocking is for the first kind.** This
   limb is the second kind, and treating them alike would make the refusal
   instrument cheap — which is the same disease as making the signature cheap,
   just at the other end.

So: **signed, unconditionally**, with `FINDING C-RL-10` riding alongside and
**not** conditioning the signature. If the finding is refused, the limb still
stands signed by me and my recourse is a post-acceptance finding under §9.3,
argued against a live rule — which I accept in advance, on §9.3's own ground that
*"a gate clause any graded party can suspend by objecting is not a gate clause."*

The verdict, in the form the orchestrator can relay:

> **COUNTERSIGNATURE — rtl_lead, ADR-0020 §9.2 act 4.**
> **`J-rtl_lead-0023`. SIGNED, unconditionally.**
>
> **Scope.** ADR-0020 **§7.3's generalised limb only** — that §7.4's operative
> text reads *the constrained party* rather than *dv_lead*, together with its
> three bounds. I sign **nothing else**: not (b.1)–(b.4), not the §3/§4
> `PROTOCOL` hunks, not §5's `G-9` reading, not §6's equivalent-mutant standard,
> not §7's dv-limb, not §8's item-70 ruling, and no view whatever on whether any
> module's mutation record satisfies the amended clause.
>
> **Adopted, on three grounds.** (i) §7.5's factual predicate is **verified
> true**: no rule at `8264183` makes rtl_lead a signer of a post-freeze spec diff
> — `SPEC-TEMPLATE` §12 names two signature rows and neither is mine, §13 names
> none, `requirements.md` §13 states a countersignature owed 14 times and names
> dv_lead every time, and the count naming rtl_lead is zero. The limb changes
> something real. (ii) Run over the **four** committed post-freeze rows that touch
> this line — `requirements.md` §13's `C-RL-8` row, `eth_axis_tx.md` §13,
> `eth_axis_rx.md` §13, `xgmii_rx_64.md` §13's non-normative note — the limb
> re-routes **none of them**; it reproduces the record's own routing at every
> instance the record contains. (iii) Bound 1 is exactly the rule, tested against
> a prohibition of my own (`J-rtl_lead-0022`: *a promotion is never repeated over
> a nondeterminism signal*), which constrains only its author and correctly owes
> nothing.
>
> **Two limits on what this signature certifies.** Bound 2 protects **dv_lead's**
> spec-freeze gate signature, not mine; I do not certify it, and dv_lead's act 3
> is where the protected party checks it. Bound 3 has **no live instance** on this
> seat — no finding of mine is outstanding against any post-freeze spec diff — so
> I affirm it negatively and say so.
>
> **Not reached by this limb**, answering the dispatch's question narrowly: the
> `C-RL-6b` watch value (`48c4b03b…beb04`, a netlist digest, not a spec clause)
> and REQ-902's two-run instrument (route unchanged, `.github/workflows/build.yml`,
> orchestrator's scope). Evidence-form discipline lives at (b.2)/(b.3), which are
> the auditor's and dv_lead's to sign.
>
> **`FINDING C-RL-10` — filed with this signature; NON-BLOCKING; this is not a
> refusal and not a narrowing of my signature.** §7.4's operative sentence leaves
> the status of its em-dash list undeclared, and the two available readings fail
> in opposite directions. Read **definitional**, the list enumerates two of the
> RTL line's three acts and omits the third: a clause scoping what may be
> **accepted at review** (`RV-`, charter §3) constrains this line and is neither a
> prohibition, a licence, nor a scope on what may be *built or asserted* — it
> would route to nobody. Read **illustrative**, the trigger *"constrains a party
> other than its author"* admits every normative sentence of every module spec,
> because that is what a specification is — and would owe me a signature on the
> editorial repairs the record settles without me. The two filters that make the
> record's practice right are both already ruled and **neither is in the source
> text**: the **C-43 axis ruling** (`requirements.md` §13, five occurrences — *"the
> class and the countersignature question are different axes"*), whose operative
> test is whether the diff moves **normative text in the constrained party's own
> instrument**; and the dv-limb's **own-derivation waiver**, which is what kept
> `C-RL-8` off my desk. **Requested at act 7** (which postdates this signature by
> §9.2's own table, so nothing need be stalled): one sentence declaring the list
> illustrative and importing the *normative-text-in-the-constrained-party's-own-
> instrument* test. Filtering on the editorial/behavioural class instead is
> **refused in advance** — C-43 already ruled those are different axes.
> *The finding widens the rule in one direction and narrows it in the other, so it
> is not a reduction of this seat's own obligations.*
>
> **Not claimed**: any view on M03's record, on any mutation tally, on any gate's
> disposition, or on any clause routed to the auditor or to dv_lead.

---

### Actions

- Ran the abort-first precheck (twice: at entry, and again immediately before
  writing this file) — `git status --short`, `git rev-parse HEAD`.
- Read the charter, `PROTOCOL`, ADR-0020 whole, ADR-0017 §4–§6, and the spec and
  journal surfaces enumerated in Inputs.
- **Act 0**: computed the predecessor's `sha256` and byte count from git and from
  disk independently, and created
  `agents/journals/claude_rtl_lead_agent.v03.md` with the ADR-0017 §4.3 header
  and exactly one entry. **Volume 02 was not opened for writing, not modified and
  is not staged.**
- **Act 1**: ran ADR-0020 §7.3's generalised limb over the four committed
  post-freeze change-log rows that touch this line, and over one prohibition of
  my own, and recorded the countersignature and `FINDING C-RL-10` at §9.
- Executed `agent_may_write` for six paths under this seat's identity, and the
  five census greps at Evidence 3–4.
- **No file under `libs/`, `top/`, `bin/`, `rtl_snapshots/` or
  `agents/handoffs/` was created, modified or deleted.** No `git commit`, no
  `git push`, no `git add` — this seat does not operate git and did not.

### Evidence

All commands run from a checkout at `82641833837e2d1245f3f7c4ef2865a9e1024c20`,
clean tree, and reproducible there.

**1 — this seat cannot author a post-freeze spec diff** (§3's asymmetry):

```sh
source scripts/policy.sh
agent_may_write rtl_lead docs/specs/SPEC-TEMPLATE.md          # REFUSED
agent_may_write rtl_lead docs/specs/requirements.md           # REFUSED
agent_may_write rtl_lead docs/specs/modules/eth_axis_tx.md    # REFUSED
agent_may_write rtl_lead libs/x.ml                            # ALLOWED
agent_may_write rtl_lead rtl_snapshots/x.v                    # ALLOWED
agent_may_write rtl_lead agents/handoffs/x.md                 # ALLOWED
```

**2 — the rotation arithmetic and the two chain fields** (§1):

```sh
git show HEAD:agents/journals/claude_rtl_lead_agent.v02.md | wc -c
#   243869
git show HEAD:agents/journals/claude_rtl_lead_agent.v02.md | sha256sum
#   6142fa68064566e2f42a95cd8151d4f755c5b112327ae2999d46f1018dc9b56c  -
sha256sum agents/journals/claude_rtl_lead_agent.v02.md
#   6142fa68064566e2f42a95cd8151d4f755c5b112327ae2999d46f1018dc9b56c  (disk == git)
grep -n 'JOURNAL_SOFT_MAX\|JOURNAL_HARD_MAX' scripts/policy.sh
#   13:JOURNAL_SOFT_MAX="${JOURNAL_SOFT_MAX:-262144}"
#   14:JOURNAL_HARD_MAX="${JOURNAL_HARD_MAX:-524288}"
```

Per-entry byte sizes of volume 02, computed over the file by splitting on
column-0 entry headers: 0014 = 18587, 0015 = 29060, 0016 = 21954, 0017 = 22838,
0018 = 23900, 0019 = 23453, 0020 = 41648, 0021 = 38348, 0022 = 23365; header =
716; total = 243869. **Headroom to `S` = 262144 − 243869 = 18275**, which is
**312 bytes less than this chain's smallest entry ever** (18587). The last id in
volume 02 is `J-rtl_lead-0022`, which is this file's `Continues-from`.

**3 — §7.5's predicate: no existing rule makes rtl_lead a spec-diff signer** (§3):

```sh
grep -n 'signature' docs/specs/SPEC-TEMPLATE.md
#   346:| Architect signature | `J-architect_docs_lead-NNNN` |
#   347:| dv_lead testability countersignature | `J-dv_lead-NNNN` |
sed -n '/^## 13. Change log/,+8p' docs/specs/SPEC-TEMPLATE.md
#   | Date | Change | Breaking? | ADR | Journal |     (no signature column)
grep -o "dv_lead's \(re-\)\?countersignature is owed" docs/specs/requirements.md | sort | uniq -c
#   8 dv_lead's countersignature is owed
#   6 dv_lead's re-countersignature is owed
grep -o "rtl_lead's \(re-\)\?countersignature is owed" docs/specs/requirements.md docs/specs/modules/*.md
#   (no output — zero)
grep -rh 'countersignature |' docs/specs/modules/*.md | ...   # every row is dv_lead testability
```

**4 — the C-43 axis ruling, five occurrences** (§5's filter):

```sh
grep -c '[Tt]he class and the countersignature question are different axes' \
  docs/specs/requirements.md
#   5
```

**5 — the four rows §4 runs the limb over**, at their committed paths and dates:
`docs/specs/requirements.md` §13 row 2026-08-11 (`C-RL-8`, `J-architect_docs_lead-0041`);
`docs/specs/modules/eth_axis_tx.md` §13 row 2026-08-11 (`:578`);
`docs/specs/modules/eth_axis_rx.md` §13 row 2026-08-11 (`:648`);
`docs/specs/modules/xgmii_rx_64.md` §13 row 2026-08-04 (`:1267`). Each row's
constrained party and disposition are quoted in §4 from the row itself.

**Ephemeral, and named as such** (ADR-0003/F5): the per-entry byte table in
Evidence 2 was produced by a throwaway split of the file at column-0 entry
headers; the numbers are re-derivable from the committed file by any equivalent
split, but no script is committed for it and none is claimed.

**Not claimed**: any CI run, any build, any elaboration, any simulation, any
determinism observation, any DV result, any view on a mutation tally, and any
verification of the §3/§4 `PROTOCOL` hunks (which I did not check against
`agents/PROTOCOL.md`, that being the transcriber's act at act 6 and the
auditor's and dv_lead's to countersign).

### Outcome

**Both acts complete.** Act 0: volume 03 opened per ADR-0017 §4.4, with the chain
fields computed twice on my side and verifiable independently at commit; volume
02 frozen at 243,869 bytes — under `S`, and the first volume of this chain that
is one readable unit. Act 1: ADR-0020 §7.3's generalised limb **COUNTERSIGNED
unconditionally**, with `FINDING C-RL-10` filed non-blocking against §7.4's
source text and requested at act 7.

Charter §5's DoD, scored against what this round actually was:

- Implements its frozen spec, deviations escalated — **no instance.** No file
  under `libs/` or `top/` was opened; no module was written, reviewed or changed.
- `bin/generate.exe` emission and two-run byte identity — **no instance.** No
  generator change, no snapshot touched.
- House style / `.ocamlformat` — **no instance.** No Hardcaml authored.
- Rx-path line-rate invariant — **no instance.**
- Worker review, `RV-` issued — **no instance.** No worker, no work order.
- Journal entry appended per PROTOCOL §4, no DV sign-off claimed — **met.**

Charter §8's determinism-evidence rule **does not fire**: this entry touches
neither `bin/generate.exe` nor `rtl_snapshots/**`, so the double-generation
check has no occasion. This is the first round in three where the rule is silent
rather than discharged negatively.

Charter §8's harvest-note obligation **does not fire**: PROTOCOL §7 ties it to an
`SO-` and to a phase gate, and this round is neither. Span bookkeeping is
unchanged and is restated here rather than cited across the volume boundary —
**this seat's next harvest still opens at `J-rtl_lead-0013`** (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator, for commit and for relay of §9's verdict block
to architect_docs_lead as act 4 of ADR-0020 §9.2. The one thing worth watching is
that §9.2's act 7 is **separable from acts 5–6**, so `FINDING C-RL-10` need not
delay acceptance of anything; what it must not do is land in `SPEC-TEMPLATE` §13
unanswered, since act 7 is the last moment at which the source text is cheap to
change.

### Open-questions

**The ledger, restated whole at the volume boundary** rather than cited across
it — ADR-0017 §4.4's fifth step as practised at `J-architect_docs_lead-0035` and
at this chain's own `J-rtl_lead-0014`. Every item carries an owner and a closing
event.

1. **`FINDING C-RL-10` — NEW, opened by this entry.** §7.4's source text leaves
   the em-dash list's status undeclared; the two readings fail in opposite
   directions (§5). *Owner*: architect_docs_lead, as the limb's author. *Closes
   by*: ADR-0020 §9.2 **act 7** — the `SPEC-TEMPLATE` §13 edit — either by
   adopting the sentence, or by declaring the list's status the other way with
   grounds. **My countersignature does not depend on the answer.** If act 7 lands
   without answering it, the finding survives into the post-acceptance window and
   is argued there against a live rule (§9.3), which I have accepted in advance.
2. **M07's emission determinism is asserted by no one yet.** REQ-902's byte
   identity has never been observed for `rtl_snapshots/eth_axis_tx.v`; the watch
   value is
   `48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04`, and the
   next CI run touching that path is its first test. A run printing a *different*
   sha for this path with `bin/` and `libs/` unmoved is a REQ-902 defect that
   comes back to me and **must not be re-promoted**. *Owner*: me, on the red.
   **A watch, not a carry** — it resolves within one run. Unchanged by this
   round, which ran no CI.
3. **`C-RL-9` carried, untouched.** M07's doc comment
   (`libs/hardcaml_ethernet/src/eth_axis_tx.ml`) still calls a closed defect live
   and still quotes §0.5's identity in its pre-`q` form. *Owner*: me. *Closes
   by*: a round with `libs/hardcaml_ethernet/**` in its write set.
   Snapshot-neutral — it re-emits identically and cannot invalidate promoted
   bytes. Untouched here: this round had no `libs/` write.
4. **REQ-902's two-run instrument carried, route unchanged.** What is owed is a
   second *process* invocation compared byte for byte, which only
   `.github/workflows/build.yml` can cause. *Owner*: **orchestrator** (that path
   is its scope, not mine). The complete derivation of what the step must do is
   `J-rtl_lead-0021` §7; nothing in this round changes it, and nothing in this
   round is a partial discharge of it.
5. **M06 and M07 have no independent design review**, and neither `J-rtl_lead-0020`
   §3 nor anything in this round is one. *Owner*: unassigned — it is not
   dv_lead's (`SO-` is a suite result, not a design review) and it cannot be
   mine. Carried unchanged; this round moves nothing.
6. **`C-RL-2` and `C-RL-3` carried, unchanged and untouched**: the latent
   `first_v` gating in M03, and sub-word idle granularity (no row owed). *Owner*:
   me. M03 was not opened this round.
7. **`C-RL-6b` is closed and stays closed** — recorded here once, at the
   boundary, so that a reader of volume 03 alone does not have to reach back into
   volume 02 to learn that it is not live. Both halves discharged at
   `J-rtl_lead-0021` (emitter, `89ef55e`) and `J-rtl_lead-0022` (snapshot). No
   successor obligation except item 2's watch.

### Files-in-this-commit

- (none)
