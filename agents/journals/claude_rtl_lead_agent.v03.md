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

---

## [J-rtl_lead-0024] 2026-08-11T20:52:06Z | task:none | `C-RL-9` closed at the only place it lived: M07's doc comment now records `C-RL-8` as UPHELD instead of live, keeps whole the L = 22 derivation SPEC-M07 §13's *editorial* row rests on, and quotes the identity in its `q` form — with snapshot-neutrality argued from an emitter path this container cannot run, stated as an argument rather than a measurement, and made falsifiable at the next run by a named step

### Trigger

Orchestrator dispatch, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`,
one round and one act: `C-RL-9`, the carry this seat filed at `J-rtl_lead-0021`
and restated at `J-rtl_lead-0022` and `J-rtl_lead-0023`. The dispatch is not a
new finding routed to me; it is my own ledger item coming back with a write set
wide enough to discharge it, which is the closing event item 3 named for itself.

**Abort-first precheck, run before anything was read.** `git status --short`
printed three paths — `docs/reports/audit/WO-0041-mutations/README.md` modified,
`agents/journals/claude_auditor_agent.v03.md` and
`docs/reports/audit/ADR-0020-auditor-countersignatures.md` untracked — and
`git rev-parse HEAD` returned
`53ada46e2d257347d9e1d3bb6e84ce875e710fd6`, the dispatch's expected value
exactly. All three dirty paths lie inside declared sibling (1), the auditor's
mid-round lane (`docs/reports/audit/**` plus its new v03 journal). **Nothing
outside the declared set was dirty, so the precheck passes rather than refuses.**
Declared siblings (2) dv_lead — `agents/handoffs/**` and its journal v11 — and
(3) the read-only council workflow over `docs/PROCESS.md` had produced no tree
change at precheck time and none appeared during the round; I record their
absence rather than inferring anything from it, since a sibling that has not yet
written is not a sibling that will not.

**HEAD did not move during this round.** The dispatch warned it might and
required re-verification if it did. `git rev-parse HEAD` at the end of the round
returned the same `53ada46`, so the re-verification the dispatch conditions on
was not owed and is not claimed.

### Inputs

Read in this order, all at `53ada46`:

- `agents/charters/rtl_lead.md` — the whole charter. §7's "spec defects found
  mid-implementation … never patch RTL around a wrong spec silently" is the rule
  the original comment was written under; §8's Inputs-honesty and journaling
  rules govern this entry.
- `agents/PROTOCOL.md` — the whole protocol. §4.1's grammar, §4.2's set-equality,
  §6's write-scope table (the row that makes `libs/**` mine and
  `rtl_snapshots/**` mine but out of scope *by dispatch* this round).
- `agents/journals/claude_rtl_lead_agent.v02.md` — `J-rtl_lead-0021`'s
  Open-questions 3 (the filing of `C-RL-9`, its two clauses and its
  snapshot-neutrality claim), `J-rtl_lead-0022`'s §6 and its Open-questions 3.
- `agents/journals/claude_rtl_lead_agent.v03.md` — `J-rtl_lead-0023`'s
  Open-questions 1–7, the live ledger this entry updates.
- `libs/hardcaml_ethernet/src/eth_axis_tx.ml` — the whole file, the one thing
  written this round.
- `docs/specs/modules/eth_axis_tx.md` — §7 whole (the repaired two-constant
  table, the two §0.5 verdicts, the D table), §12, and §13's 2026-08-11 row
  whole. That row is the reason the repair is an update and not a deletion, and
  I read its exact wording rather than my memory of it.
- `docs/specs/requirements.md` §0.5 whole, **as it stands now** — the dispatch
  instructed me to read the current text before writing, and it was right to:
  §0.5 has moved twice since `cddad51`, and the second movement (`43c0087`) is
  not in `C-RL-8`'s answer at all.
- `bin/generate.ml` (the emission path for this module), `bin/dune`,
  `.github/workflows/build.yml` (step names and the regenerate-then-diff step),
  `.ocamlformat`, `.gitignore`, `tasks/BOARD.md`'s current head paragraph.
- **No Essenceia material was consulted for anything in this round** (charter
  §8, Inputs honesty). Nor any external reference at all: the round is a
  status correction to a comment, and every fact in it is from this repo.

### Reasoning

#### 1. What was actually false, and as of when — four statements, not one

`J-rtl_lead-0021` filed `C-RL-9` as two defects. Reading the file against the
current specs found **four** false or missing statements, in two eras, and the
distinction matters because only the first era is `C-RL-8`'s answer:

**False since `0b7be1f` (the `C-RL-8` answer):**

1. *"{b What §7 calls that figure is a live spec defect and is raised, not
   absorbed}"* — the defect is not live. It was raised, it was **upheld**, and
   it was repaired. A comment asserting a live defect against a repaired
   specification is not merely stale: it invites the next reader to re-route a
   finding that already has an answer, which costs a round.
2. The present tense throughout the convicting paragraph — *"§7's bullet {e is}
   titled 'Latency' and {e converts} the figure"* — describes text that no
   longer exists. §7's bullet is now titled *"Latency. Two constants, and naming
   which is which is the requirement."*
3. *"§0.5's identity L = 8·ΔC − h returns 16 for it"* — quoted as **the**
   identity. §0.5's identity now reads **L = 8·ΔC − h + q** and returns 22 at
   M07. The old form is the q = 0 case of the new one, which is exactly why no
   figure stated before the repair moved.

**Missing since `43c0087`, and never in the comment at all:**

4. §0.5's **default was halved** and **q's subject is the port pair**. Neither
   is part of `C-RL-8`'s answer — they arrive with `FINDING Q-3`, one structural
   level up — but the first of them lands directly on this module. Under the old
   default, silence assigned q = 0 everywhere; under the halved default, silence
   assigns q = 0 only where the insertion is nothing or a whole number of words,
   and assigns **nothing** elsewhere. M07 inserts 14, which is neither. So M07's
   q is a figure its specification must **state**, not one a reader may default,
   and a doc comment that leaves the reader with the pre-`43c0087` mental model
   of q would leave them thinking silence would have sufficed here. It would
   not.

**This is why the dispatch's instruction to read the current §0.5 before writing
was load-bearing rather than procedural.** Had I repaired only what
`J-rtl_lead-0021` filed, the comment would have been correct as of `0b7be1f` and
stale as of `43c0087` — I would have closed a carry by writing a fresh one, four
hours old at the moment of writing.

#### 2. Why the repair is an UPDATE and never a rewrite — the constraint is not mine to relax

`J-rtl_lead-0021` bound this round in advance: the comment *"must be updated to
record that the finding was raised and upheld; it does not delete it, because
SPEC-M07 §13's row cites that comment as the independent derivation its
editorial classification rests on."* Having read the row's actual text this
round, that constraint is **stronger** than my own filing made it sound. §13's
breaking-column reads, in the architect's words:

> the M07 RTL landed at `cddad51` was written to §6.1's table with this defect
> already named in its own doc comment (`J-rtl_lead-0020` §5, which derived
> L = 22 independently — that independence is what this row rests on rather than
> my arithmetic alone)

So the row's *editorial* classification — the claim that no property of the
hardware was chosen by the repair — is supported by two artifacts of this seat:
the journal entry, and **the comment in the file the row is about**. The journal
is append-only and safe. The comment is not: it is an ordinary source file, and
a future round could have deleted the derivation without noticing what it
carried. Three consequences I took:

- **The derivation stays, and is now stated in fuller form than before.** The
  old comment asserted L = 22 with a one-clause gloss (*"payload octet k enters
  at octet time 8C + k and leaves at 8C + k + 22"*). The new one carries the
  whole mapping — input octet time 8C + k; frame octet 14 + k; output word
  ⌊(14 + k)/8⌋ at byte position (14 + k) mod 8; output word n at C + 1 + n; and
  therefore output octet time 8C + 8 + 14 + k. **A citation to an independent
  derivation should be able to survive its source being read**, and a reader who
  follows §13's row to this file should find the derivation, not a claim that
  one was made.
- **The convicting quotes stay.** *"Latency"*, *"exactly 8 octet times"*, *"sit
  at octet position 0 of their words"* are §7's pre-repair words. Deleting them
  would leave §13's row citing a comment that no longer contains what the row
  says it contains — the record would still assert the independence while the
  artifact underwriting it had been emptied. They are now explicitly labelled as
  the pre-repair text so no reader mistakes a quotation for the live spec.
- **The status is corrected in the heading, not buried.** The section heading now
  ends `— UPHELD`, and the first sentence of the body says so. A status
  correction a reader must reach paragraph three to find is a status correction
  that fails the next reader in a hurry, which is the reader `C-RL-9` was filed
  against.

#### 3. The one place the repair moves attribution against this seat, deliberately

The old comment predated q entirely and so claimed nothing about it. The new one
had to introduce q to state the identity correctly, and at that moment it became
possible to imply that q is part of what this file found. **It is not, and the
comment says so in terms**: *"The instrument of the repair is §0.5's {b output
offset q}, which is the {e architect's} and not this seat's."*

This mirrors §0.5's own provenance paragraph, which splits the same way — the
conflation at a fourth site, the three figures, and the observation that the
identity and the definition disagree at a non-multiple-of-8 insertion are
rtl_lead's; the output offset, its extension to the whole-number consequence, to
**Cycles** and to the straddle test, and the refusal of the scoping alternative,
are the architect's. **I wrote the comment's attribution to match the
specification's rather than to match my own convenience**, and I note that the
error this guards against is the cheap one: a comment in my own file, read by
nobody who would contest it, is exactly where an over-claim survives.

#### 4. Snapshot-neutrality: what I claimed, what I can show, and the gap between them

`J-rtl_lead-0021` asserted the repair is *"snapshot-neutral — a comment reaches
no signal"*. The dispatch required me to **verify** that rather than re-assert
it. I could not verify it by execution, and the honest report is in three parts.

**(a) The instrument that would settle it does not exist in this container.**
`dune build bin/generate.exe` fails at library resolution: `Library "hardcaml"
not found` and `Library "ppx_jane" not found`. The opam switch `fpga`
(ocaml-system 4.14.1) contains `dune` and nothing else under `lib/`. So the
emitter cannot be run here, this round produced **no** regenerated bytes, and
**no claim in this entry rests on a local emission**. (This is an environment
observation about the container, not a property of the repo; it will not
reproduce identically elsewhere and I mark it as such rather than dressing it as
evidence.)

**(b) The emitter-path argument, stated precisely, in five links.** The claim is
that the edited text cannot reach `rtl_snapshots/eth_axis_tx.v`.

1. **The change is confined to the leading `(** … *)` block, mechanically.**
   Not by inspection of a diff — by comparing the two files with that block
   removed. Everything after the doc comment's terminator hashes to
   `182585641db5de14849c8acb650754c788199418617c5571fdd946f00bc4cd66` on **both**
   sides of the edit. Zero non-comment bytes changed.
2. **A comment yields no token.** OCaml's lexer discards comments, so the token
   stream the parser sees is unchanged, and with it the typed AST and the
   compiled behaviour of `Eth_axis_tx.create`. The lexer's one exception is that
   it scans string literals *inside* comments — an unpaired `"`, or a nested
   `(*`/`*)` imbalance, is a **lexical error**. That failure mode is fail-loud:
   the build stops and no bytes are emitted at all. It is not a silent byte
   change, and it is the only way a comment can affect compilation. Checked
   rather than assumed: the comment region holds **12** double-quotes (even),
   exactly **one** `(*` (line 1's own `(**` opener) and exactly **one** `*)`
   (the terminator).
3. **Nothing in this program captures source positions.** A longer comment
   shifts every line number below it, so link 2 alone is not enough — the shifted
   positions must reach nothing. `grep -rn` for `[%here]`, `__LINE__`,
   `__FILE__`, `__POS__` and `Source_code_position` over `libs/` and `bin/`
   returns **no hits**. This check is load-bearing and not decorative: `bin/dune`
   preprocesses with `ppx_jane`, which *bundles* `ppx_here`, so the capability to
   embed a source position is present in the preprocessor set and is simply never
   invoked. Had one call site used it, link 2 would hold and the claim would
   still fail.
4. **The emitter writes no provenance.** `Rtl.output` over
   `Circuit.create_exn ~name:"eth_axis_tx" (Eth_axis_tx.create scope)` is the
   whole path (`bin/generate.ml`). The artifact it has already produced contains
   **zero** `//` and **zero** `/*` sequences, and no match for `2026`, `.ml`,
   `libs/` or `generated`. So the emitted file has no comment, no banner, no
   timestamp and no source path — **there is no field in the output for comment
   text or file position to differ in.** This is a necessary condition, checked
   on the artifact itself rather than argued from the library's documentation.
5. **The names that do reach the netlist are code.** Port names come from the
   `[@@deriving hardcaml]` record fields and the five `[@rtlprefix]` attributes
   in this file; internal net numbering follows signal-construction order. Both
   are determined by the tokens link 2 leaves untouched.

**(c) What that argument is worth, said plainly.** Links 1, 3 and 4 are
executed checks on artifacts; links 2 and 5 are arguments from the language's
and the library's semantics. **The composite is an argument supported by
necessary conditions, not a measurement**, and I will not call it one. Two
specific things it does not do: it does not exclude a defect in a link I did not
think to check, and it is not a re-emission. `48c4b03b…beb04` is what the
snapshot hashes to at HEAD and at `c06f475`; what I claim is that a re-emission
**would** return it, and the claim's status is *predicted, with the falsifier
named*, not *observed*.

**I also looked for an in-repo precedent and found none.** Every commit in this
branch's history touching `libs/hardcaml_ethernet/src/` staged **zero**
snapshots — the two-commit source-then-promotion pattern, run thirteen times. So
this repository contains no instance of "comment-only `libs/` change → verified
byte-identical re-emission" to lean on. I record the absence rather than
implying the pattern has been observed before.

#### 5. Why this round cannot trip the `C-RL-6b` watch — and the one thing it does cost

The watch (`J-rtl_lead-0023` Open-questions 2) is armed on
`48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04`, and its
convicting form is: a CI run printing a *different* sha for
`rtl_snapshots/eth_axis_tx.v` is a REQ-902 defect to root-cause and **must not
be re-promoted**. Three reasons this round cannot trip it, in increasing
strength:

1. **The watched artifact is not in this round's write set and was not opened for
   writing.** Its sha at HEAD is still the watch value. The dispatch excluded
   `rtl_snapshots/**` and `bin/**` explicitly, and the write set is one file.
2. **The watch's trigger is a CI event, and this round ran no CI.** The earliest
   possible trip is the next run — exactly where it sat before this round.
3. **The trigger clause survives the edit intact, once its subject is read
   correctly.** I wrote it as *"a run printing a different sha for this path with
   `bin/` and `libs/` unmoved"*, and after this round `libs/` **has** moved
   textually — `git diff --stat c06f475 53ada46 -- bin/ libs/ rtl_snapshots/` is
   empty, so my comment is the **first** movement in `libs/` since the watch was
   armed. A literal reading of my own clause would therefore **disarm** the
   watch, which is not what it was for. **The predicate's subject is the
   circuit, not the file's bytes**: a comment moves the file and not the
   circuit, so the watch stays armed at the same value, and a differing sha
   remains a defect to root-cause and never a promotion. I restate it in that
   form in Open-questions rather than leaving the ambiguity for a reader to
   resolve in the direction that costs nothing.

**The cost, which is real and which I will not describe as free.** Before this
round a differing sha had exactly **one** candidate cause: nondeterminism in
emission. After it there are **two**: nondeterminism, or a comment-sensitivity of
the emitter that would falsify links 3 and 4 of §4(b). Both are REQ-902 defects
and neither licenses a promotion, so the watch's *verdict* is unchanged — but its
*diagnostic sharpness* is reduced, and that is a genuine if small loss. It is
recoverable: the two causes are distinguished by re-emitting at `53ada46`, the
parent, where the comment is absent and everything else is identical. I record
the loss, the reason it was worth paying (a carry that outlives its round becomes
furniture), and the procedure that recovers it.

#### 6. What this round makes better than an assertion: a named falsifier, in advance

`build.yml`'s step *"Verify nothing was left unpromoted or non-deterministic"*
runs `git diff` **after** `dune exec bin/generate.exe`, so the next run
regenerates this path into the tree and fails if the fresh bytes differ from the
committed ones. That makes the next run a **direct and sufficient** test of §4's
neutrality claim — not of REQ-902's cross-run determinism, which still needs a
second *process* invocation and is still owed, but of exactly the property this
round asserts, because at that SHA the only change since `c06f475` is this
comment.

So I state the falsifier before the run rather than after it: **if that step goes
red naming `rtl_snapshots/eth_axis_tx.v`, this entry's §4 is wrong.** The correct
response is to root-cause the emitter's comment sensitivity — and the first two
things to check are links 3 and 4, since a provenance banner or a captured
position are the only mechanisms I can name by which it could happen. It is
**not** to promote the new bytes.

#### 7. What this entry does not claim

- **No verification, no simulation, no `SO-`.** Nothing was elaborated,
  simulated, co-simulated, linted or run against a testbench this round. The
  emitter did not run. The module's behaviour is untouched and unexamined.
- **`.ocamlformat` clean is asserted by construction, not by execution.**
  `ocamlformat` is not installed in this container and I could not run it; no CI
  step enforces formatting (`grep -n 'fmt' .github/workflows/*.yml` returns
  nothing). What I can show: the new text matches the file's established
  hand-wrapping — every new line ≤ **80** characters against the file's
  pre-existing maximum of 81 — uses only odoc vocabulary already present in this
  comment (`{2 …}`, `{3 …}`, `{b …}`, `{e …}`, `{v … v}`, `[…]`), and adds no
  trailing whitespace. `profile = janestreet` at ocamlformat 0.26.2 does not
  reformat docstrings, but I have not executed that and so state it as the
  reason I expect cleanliness rather than as evidence of it.
- **This is not an independent design review of M07**, and nothing here revisits
  §6.1's cycle table. Open-questions item 5 is unmoved.
- **No lessons-harvest note is owed**: charter §8 attaches one to every `SO-` and
  every phase gate, and this round is neither. Declared rather than omitted.

### Actions

1. Ran the abort-first precheck (`git status --short`, `git rev-parse HEAD`)
   before opening any file; classified all three dirty paths against the
   dispatch's declared sibling list and found them inside lane (1).
2. Read the charter and the protocol in full, then `J-rtl_lead-0021`'s and
   `J-rtl_lead-0022`'s filings of `C-RL-9` and `J-rtl_lead-0023`'s ledger.
3. Read SPEC-M07 §7 whole, SPEC-M07 §13's 2026-08-11 row whole, and
   requirements.md §0.5 whole **at HEAD** — the current text, per the dispatch —
   before writing a byte, and found a fourth false-or-missing statement
   (`43c0087`'s halved default) that my own filing had not anticipated (§1).
4. Verified every SHA the comment cites resolves in this repository: `508eea2`,
   `816e187`, `0b7be1f`, `43c0087`, `cddad51`. None is quoted from memory.
5. Attempted a local regeneration — `dune build bin/generate.exe` under the
   `fpga` switch — and recorded its failure as the reason §4's claim is argued
   rather than measured. Confirmed the attempt left the tree clean (`_build/` is
   `.gitignore` line 2).
6. Rewrote the comment's final section as a **record of a closed finding**:
   status UPHELD in the heading and the first sentence, the pre-repair quotations
   preserved and labelled, the L = 22 derivation preserved and expanded, the
   identity restated as L = 8·ΔC − h + q with 8·2 − 0 + 6 = 22 evaluated at M07,
   `43c0087`'s two movements added, q's authorship attributed to the architect,
   and the closing paragraph restated as *what did not move*.
7. Proved the edit comment-only by hashing both files with the leading doc
   comment stripped (§4(b) link 1), then ran the lexical-safety, position-capture
   and netlist-provenance checks (links 2–4).
8. Re-ran `git rev-parse HEAD` at the end of the round: unchanged at `53ada46`.
9. Opened **no** file under `top/`, `bin/`, `rtl_snapshots/`, `test/`, `tools/`,
   `docs/` or `agents/handoffs/` for writing. The write set is one source file
   and this journal.
10. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no
    `scripts/agent_commit.sh`, no git write of any kind.** A stop-hook commit
    demand, had one arrived, would have been refused: PROTOCOL §2 makes the
    orchestrator the sole operator of git and no hook can amend that.

### Evidence

Reproducible from a checkout at this commit unless marked otherwise.

1. **Precheck**: `git rev-parse HEAD` → `53ada46e2d257347d9e1d3bb6e84ce875e710fd6`
   (dispatch's expected value). `git status --short` → the three auditor paths
   named in Trigger, plus — after the edit —
   `M libs/hardcaml_ethernet/src/eth_axis_tx.ml`.
2. **The edit is comment-only, by hash and not by inspection**:

   ```
   awk 'f{print} /^.*\*\)$/&&!f{f=1}' libs/hardcaml_ethernet/src/eth_axis_tx.ml | sha256sum
   git show 53ada46:libs/hardcaml_ethernet/src/eth_axis_tx.ml \
     | awk 'f{print} /^.*\*\)$/&&!f{f=1}' | sha256sum
   ```

   Both → `182585641db5de14849c8acb650754c788199418617c5571fdd946f00bc4cd66`.
   `git diff --stat` on the file → `81 insertions(+), 24 deletions(-)`, all of
   them inside the leading doc comment.
3. **Lexical safety of the new comment** (the only route by which a comment can
   affect compilation): double-quotes in the comment region = **12** (even);
   `(*` occurrences = **1** (line 1's `(**`); `*)` occurrences = **1** (the
   terminator); trailing-whitespace lines = **0**; maximum line width over the
   rewritten region (lines 103–183) = **80** characters, file maximum 81 on a
   pre-existing line.
4. **No source position can reach anything**:
   `grep -rn '\[%here\]\|__LINE__\|__FILE__\|__POS__\|Source_code_position' libs/ bin/`
   → no output.
5. **The emitted artifact has no field for comment text or provenance**:
   `grep -c '//' rtl_snapshots/eth_axis_tx.v` → `0`;
   `grep -c '/\*' rtl_snapshots/eth_axis_tx.v` → `0`;
   `grep -nE '2026|\.ml|libs/|[Gg]enerated' rtl_snapshots/eth_axis_tx.v` → no
   output.
6. **The watch value is intact and my edit is the first `libs/` movement since it
   was armed**: `sha256sum rtl_snapshots/eth_axis_tx.v` →
   `48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04`, equal to
   `git show c06f475:rtl_snapshots/eth_axis_tx.v | sha256sum`; and
   `git diff --stat c06f475 53ada46 -- bin/ libs/ rtl_snapshots/` → empty.
7. **Every SHA the comment cites resolves**: `git rev-parse --verify` succeeds
   for `508eea2`, `816e187`, `0b7be1f`, `43c0087`, `cddad51`.
8. **Local emission is impossible here** — *ephemeral, environment-specific, and
   load-bearing for nothing except the honesty of §4(a)*:
   `dune build bin/generate.exe` under the `fpga` switch →
   `Error: Library "hardcaml" not found.` and
   `Error: Library "ppx_jane" not found.` No regenerated bytes exist in this
   round and none are cited.
9. **The next run is the test, and its falsifier is named in §6**: `build.yml`'s
   step *"Verify nothing was left unpromoted or non-deterministic"* runs
   `git diff` after `dune exec bin/generate.exe`. Not run here; this is a
   forward statement, not a result.

### Outcome

**`C-RL-9` CLOSED.** The comment records `C-RL-8` as raised-and-upheld rather
than live, quotes §0.5's identity in its current `q` form with the M07
evaluation, carries `43c0087`'s two movements, and preserves — expanded — the
derivation SPEC-M07 §13's editorial classification rests on. DoD, against a
carry rather than a work order: the module implements its frozen spec unchanged
(no signal-reaching byte moved); no REQ is affected; house style holds by
construction with the ocamlformat caveat of §7 stated; no DV sign-off is
claimed or implied. Handoff: to the orchestrator for commit, write set of one
non-journal file, no packet owed to anyone.

**Snapshot-neutrality: predicted, argued in five links, falsifier named — not
measured.** §4(c) says exactly how much that is worth.

### Open-questions

The ledger, carried forward from `J-rtl_lead-0023` with one item closed and one
restated. Every item carries an owner and a closing event.

1. **`FINDING C-RL-10` — open, unchanged.** ADR-0020 §7.4's source text leaves
   the em-dash list's status undeclared. *Owner*: architect_docs_lead. *Closes
   by*: ADR-0020 §9.2 act 7. Untouched this round.
2. **The `C-RL-6b` watch — armed, unchanged in value, and its trigger clause
   restated so this round cannot be read as disarming it.** The value remains
   `48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04`. **Restated
   trigger**: a CI run emitting a different sha for
   `rtl_snapshots/eth_axis_tx.v` while the **circuit** is unmoved is a REQ-902
   defect that comes back to me and **must not be re-promoted**. The original
   wording said "`bin/` and `libs/` unmoved"; `libs/` has now moved by this
   round's comment, and the clause is about the circuit rather than the file's
   bytes, so the watch stands (§5). Two candidate causes now instead of one, and
   they separate by re-emitting at `53ada46`. *Owner*: me, on the red. **A
   watch, not a carry** — it resolves within one run.
3. **`C-RL-9` — CLOSED by this entry.** Recorded closed here so no later reader
   has to infer it from silence. No successor obligation; item 2 is a different
   object and was already separate.
4. **REQ-902's two-run instrument — carried, route unchanged.** A second
   *process* invocation compared byte for byte, which only
   `.github/workflows/build.yml` can cause. *Owner*: **orchestrator**. The
   complete derivation of what the step must do is `J-rtl_lead-0021` §7. Nothing
   in this round is a partial discharge of it: §6's next-run test settles
   neutrality, which is a different property from cross-run determinism.
5. **M06 and M07 have no independent design review.** *Owner*: unassigned — not
   dv_lead's (`SO-` is a suite result), and it cannot be mine. Carried unchanged.
6. **`C-RL-2` and `C-RL-3` carried, unchanged and untouched**: the latent
   `first_v` gating in M03, and sub-word idle granularity (no row owed).
   *Owner*: me. M03 was not opened this round.

### Files-in-this-commit

- libs/hardcaml_ethernet/src/eth_axis_tx.ml
