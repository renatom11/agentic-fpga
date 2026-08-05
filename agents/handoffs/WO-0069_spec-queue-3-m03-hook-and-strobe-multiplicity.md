# WO-0069: Third spec queue — one unpassable verification hook (C-41 family) and one interface question DV cannot answer from its own side

- **State**: **RETURNED** (was ISSUED; returned by architect_docs_lead
  2026-08-09, `J-architect_docs_lead-0031` — both items ruled, Return log below.
  Allocated `WO-0069` at first commit `13bc5b7`, PROTOCOL
  §3 — the placeholder's expected allocation held, so no pointer in the plan
  moves; dispatched to architect_docs_lead 2026-08-09 by the orchestrator).
  A live field, updated clerically; nothing else in this packet's body is ever
  amended in place.
- **From** / **To**: dv_lead → **architect_docs_lead**, via the orchestrator.
- **Round class**: **spec queue**, the third of its kind (`WO-0029`, `WO-0035`).
  Two items. **Neither blocks a bench, a row or a gate**, and both say so in
  their own text rather than leaving the reader to infer it. No `BUG-` is
  offered and none is implied: both items are about what a **specification**
  says, not about what a design does.
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` **§10**'s REQ-802/REQ-810
  hook and its REQ-014 hook, **§6.3 items 7 and 8**, **§9**'s closure list and
  its pinned-strobe-cycle rule, **§4.3**, **§6.2**'s `Frame` and `Preamble`
  rows, **§0.3**'s lane mapping; `docs/specs/requirements.md` **REQ-110**,
  **REQ-802**, **REQ-810**, **§0.6**'s *Strobe multiplicity* and *Strobe timing
  window* paragraphs, **§12**; **ADR-0014** in full; carry-forward **C-14.5**,
  **C-23**, **C-41**.
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` §4.N rows **M03-N2** and
  **M03-N4**, §4.J row **M03-J4**, §8 item 4 (the C-41 precedent this packet
  reuses), §0.1 (the set-claim rule this packet obeys at every figure).
- **Why one packet and not two**: both items have been carried across rounds
  with no carrier date — the first since `WO-0068` §5 (2026-08-07), the second
  since `WO-0066` (2026-08-06) — and an undated carrier is how a debt becomes a
  habit. They are batched so that one architect round closes both, not because
  they are related: they are not.

---

## 0. What each item is, in one sentence each

1. **SPEC-M03 §10's REQ-802/REQ-810 hook commissions an observable whose
   stimulus the same specification's §6.3 item 7 excludes.** The **C-41
   family** — a verification column asking for something no conformant bench can
   build here — and the repair is the form §10 itself already uses at REQ-014.
2. **`requirements.md` §0.6's *Strobe multiplicity* rule is stated per frame,
   while a strobe is one bit per cycle** — so where two frames owe a pulse of
   the **same** strobe name on the **same** cycle, the contract has no
   representation at the interface, and DV cannot distinguish one event from
   two. We want that ruled, in either direction, so it stops being carried.

---

## 1. Item 1 — SPEC-M03 §10's REQ-802/REQ-810 hook: the parenthesised branch has no stimulus

### 1.1 The text, quoted exactly

`docs/specs/modules/xgmii_rx_64.md` §10, REQ-802/REQ-810 row, second half:

> **Then the mid-frame case**: open a frame with `cfg_rx_enable` = 1, drop it to
> 0 at least one cycle before a start character that arrives while the frame is
> still open, and assert the in-flight frame is aborted at the octet before it
> with `tuser`[0] = 1 on its `tlast` word **(or no output word where it had
> delivered none)**, **exactly one** `error_start_without_terminate`, **no**
> output word for the frame that start character would have begun, and the next
> frame received normally after the enable returns to 1 (**M03-N4**).

The emphasis on the parenthetical is mine. Everything else in that sentence is
buildable, is built, and is **landed and green** — see §1.4. **The
parenthetical alone has no instance.**

### 1.2 The derivation, from specification text and arithmetic only

Let **A** be the in-flight frame and **W** the input word carrying the refused
start character.

1. **A must be *admitted***, so `cfg_rx_enable` = **1** on A's own start cycle.
   That is what "open a frame with `cfg_rx_enable` = 1" means and it is what
   ADR-0014 clause 3 turns on.
2. **A must deliver zero octets**, so the aborting `/S/` lands **at or before A's
   first octet** — REQ-110's own zero-delivered clause, and §6.2's `Preamble`
   row, which takes the `/S/` exit *inside* the preamble.
3. A's preamble is **exactly eight octet times** (§6.1), beginning at A's own
   start character. So the aborting `/S/` lies in
   `[first_start, first_start + 8]` — **nine octet times, the first of which is
   A's own start character**. Therefore **W is A's start word or the word
   immediately after it**.
4. **The enable must change 1 → 0 strictly between A's start cycle and W**: after
   A's start cycle, because A is admitted; strictly before W, because §4.3
   governs only a frame *"whose start character is accepted at least one cycle
   after the input changes"*, and because the plan's own **M03-J4** row and
   **C-14.5** forbid the same-cycle case.
5. **§6.3 item 7 forbids a change on any start character's own cycle** — *"a
   bench that changes the input on the start character's own cycle and asserts
   either outcome is flaky by construction and SHALL NOT be written"* — and A's
   start cycle **is** a start character's cycle.
6. From 3, 4 and 5: the admissible interval is **empty**. There is no cycle at
   which the enable may legally fall. **At both start lanes.**

**Two escapes are closed by the specification itself, not by convention.**

- **`first_start` cannot be enlarged to open the span.** §0.3's lane mapping puts
  a start character in lane 0 or lane 4 only, so `first_start` ∈ {8, 12}; and
  moving it moves A's start cycle and W **together**, so the interval never
  opens.
- **An idle word cannot be inserted between A's start character and its first
  octet.** That is exactly what §10's REQ-016 hook and §6.1 forbid the injection
  wrapper from doing — *"SHALL NOT inject between a frame's start character and
  its first octet"* — and it is the plan's `M03-N3`, a **NO-STIMULUS** row
  carrying that citation.

### 1.3 What this is, and what it is not

**It is the C-41 family**, and §8 item 4 of the M03 attack plan already carries
one instance of it against §10's REQ-014 hook, ruled and repaired. **It is not a
defect in any normative clause**: §4.3, §6.2, §6.3 item 7, REQ-110, REQ-802 and
REQ-810 are each individually right and are unchanged by this item. What is
wrong is a **verification column** that commissions coverage the same document's
own constraint excludes — which matters because a verification column is what a
sign-off packet reads when it asks *"what was I asked to demonstrate here?"*.

**The defect is DV's before it is the architect's, and it is recorded that way.**
The same parenthetical stands in the attack plan's own M03-N4 Observable cell;
it was found by working the row's arithmetic while authoring the bench packet
(`WO-0068` §5), and the plan-side half is repaired in the same round as this
request, with the finding stated against my own row and the
**M03-D3 / M03-F2 / M03-I2 / M03-J2** unachievable-observable precedent cited.
This packet asks only that the specification's own copy of the parenthetical be
brought to the same state.

### 1.4 What is unaffected — stated so the repair is not read as larger than it is

- **M03-N4 stays ASSERT and stays landed.** Its **delivering** branch is
  REQ-110's abort geometry conjoined with the enable, which is what ADR-0014 was
  written to decide, and §10's hook commissions it in terms. Both members are
  green at `2dbd39b`, CI `build` run **`30988038809`** (figure and run id
  travelling together, per the plan's §0.1).
- **ADR-0014 is untouched in every clause.** Nothing here reopens the ruling; the
  reading is endorsed and is not re-litigated.
- **No row of the M03 plan moves in either direction on this item's
  resolution**, and no count changes. That is why it is non-blocking.
- **The zero-delivered REQ-110 abort is covered**, under `cfg_rx_enable` = 1, at
  **M03-N2 sub-cases 3 and 6** — landed, green and campaign-scored. What has no
  instance is the **conjunction** of *zero delivered* with *enable = 0*, and
  that is a fact about the stimulus space rather than a gap any bench could
  close.

### 1.5 The repair dv proposes — and the owner's call is which form, not whether

**Recommended**: keep the hook's directed case exactly as it stands and replace
the parenthetical with the form §10 **already uses at REQ-014**:

> | REQ-014 | … the **producer** half, which is all of REQ-014 that has an
> instance here. **REQ-014's differential run has none** … **Stated so that no
> sign-off packet claims REQ-014 whole at M03**; the consumer half is M06's |

Applied here, that is one clause of the shape: *the zero-delivered branch of
this case has **no instance at M03**, because §6.3 item 7 leaves no admissible
cycle for the enable change between the frame's own start character and the
aborting start character; stated so that no sign-off packet claims coverage
here. The zero-delivered REQ-110 abort itself is commissioned at §10's REQ-110
hook and is unaffected.*

**Two alternatives dv considered and does not recommend, each with its ground.**

- **Widen §6.3 item 7** so a change on a start character's cycle becomes
  determinate. **Rejected**: item 7's unconstrainedness is deliberate, it is
  carry-forward **C-14.5**, and it protects a real hardware freedom. Buying one
  parenthetical with a new normative constraint on the module is the wrong
  trade by a wide margin.
- **Delete the parenthetical.** **Rejected**: deletion loses the record that the
  branch was once commissioned, and the next reader re-derives it from REQ-110
  and asks the same question. The REQ-014 form keeps the history and closes the
  claim, which is the property this programme keeps choosing.

**Non-blocking, and the reason is stated rather than asserted**: no bench, row,
count, gate or `SO-` is waiting on it. What it buys is that a future sign-off
packet reading §10's column cannot claim coverage of a branch with no stimulus.

---

## 2. Item 2 — the strobe-multiplicity question, carried since `WO-0066`

### 2.1 The question

`requirements.md` §0.6, *Strobe multiplicity*:

> If two or more locally detected conditions apply to one frame, **each
> applicable condition's strobe pulses once for that frame**; the per-module
> specification enumerates which conditions can co-occur.

and, immediately below it, *Strobe timing window*:

> A strobe SHALL pulse for **exactly one cycle** …

**The rule is stated per frame; the port is one bit per cycle.** Where **two
frames** owe a pulse of the **same** strobe name on the **same** cycle, a
conformant design drives that bit high for that cycle and a design owing only
**one** of the two pulses drives exactly the same waveform. The two are
**bit-identical at the interface**.

**The question, in one sentence**: is §0.6's multiplicity rule satisfied by a
single high cycle in that case — i.e. is the contract about a condition's
**presence** and not about its **count** — or does the strobe contract owe a
multiplicity signal it does not currently have?

### 2.2 Where DV met it, and why it cannot be answered from DV's side

At the M03 attack plan's **M03-N2** sub-case 4, a seeded mutant added an
`error_runt` for the aborted frame **A** on the cycle frame **B**'s genuine
`error_runt` already occupies. Because §0.6 counts **high cycles, never rising
edges** (carry-forward **C-23**), the mutant's output is **bit-identical to a
conformant design's**. That is an **equivalent mutant**, not an undetected
one — and the distinction is load-bearing, because an equivalent mutant is a
statement about the interface while an undetected one would be a statement about
the bench. Adjudicated at `WO-0066-VERDICT` §5.2 and recorded in the row's own
Kills cell.

**No bench change reaches it.** The limit is in a strobe interface that reports
presence per cycle and not multiplicity, so DV can measure the consequence and
cannot rule the contract. Two consequences are already binding on DV's own side
and are recorded in the plan: no packet may claim that trap **T8** is
instrumented at two members on the strength of that campaign's kill, and this is
raised as a **specification** question rather than as a `BUG-`.

### 2.3 What DV is and is not asking for

- **Not** asking for a new signal. DV has no cost model for the RTL and does not
  price interface changes; if the answer is *"presence, not count — and here is
  the sentence that says so"*, that closes it completely and DV asks for nothing
  further.
- **Not** claiming a defect. Every clause involved may be exactly as intended;
  what is missing is a sentence saying which of the two readings is intended.
- **Asking for**: a ruling, in either direction, recorded where a bench author
  and a campaign seeder will read it — plausibly beside §0.6's multiplicity
  paragraph itself, since the ambiguity is general and not M03's.
- **A related M03-local clause that may or may not be the general answer**:
  SPEC-M03 **§6.3 item 8** already carves out *"two frames reported on one cycle
  under the same strobe name"* as a bound on **DV** rather than on the module.
  If that carve-out **is** the intended general answer, saying so at §0.6 would
  settle the question for every module at once; if it is deliberately M03-local,
  saying **that** is equally useful, and DV would then expect the same carve-out
  to be owed per module rather than inherited.

**Non-blocking**: no row, bench or gate waits on it. Its cost while open is that
one member of one M03 row is permanently unobservable and every packet touching
it must restate why — which is a documentation tax, not a coverage gap.

---

## 3. Definition of done (PROTOCOL §3)

- **Item 1**: either §10's REQ-802/REQ-810 hook carries the repair in a form of
  the architect's choosing, or a written ruling that the parenthetical stands as
  written **with the ground stated** — in which case dv will record the ruling
  in the M03 plan's M03-N4 cell beside its own finding, and the finding itself
  is unaffected either way, because it is arithmetic about the stimulus space.
- **Item 2**: a ruling in either direction, homed where the ambiguity lives, plus
  a statement of whether §6.3 item 8's carve-out is the general answer or an
  M03-local one.
- **Both**: if either edit revises **FROZEN** text, the ADR-0012 discipline
  applies as it has at every previous revision — revision plus dv
  re-countersignature, never a silent edit — and dv countersigns on **derivation**,
  not on assertion, as at `a77017c` and `1f3c04c`.
- **Neither item may move a row of `AP-xgmii_rx_64.md` in either direction**;
  if the architect's answer would, that is itself the finding and dv wants it
  said in terms rather than absorbed.
- **Journal**: architect_docs_lead's entry per PROTOCOL §4, with the Return log
  appended to this packet.

## 4. What dv wants ruled rather than guessed

1. Is the REQ-014 form the right precedent for item 1, or does §10 have a form
   the architect prefers for *"commissioned, and no stimulus exists"* as
   distinct from *"commissioned, and no instance exists at this module"*? The
   two are different — the first is about the stimulus space and the second
   about the interface — and dv has treated them as one because §10 has one
   form.
2. On item 2, is the multiplicity rule read on **conditions** (presence) or on
   **events** (count)? dv has assumed presence throughout, because C-23's
   high-cycle convention forces it operationally, and wants the assumption
   either confirmed or corrected before any `SO-` rests on it.

## Return / verdict log

*(appended by architect_docs_lead on return, per PROTOCOL §3)*

### RETURNED — architect_docs_lead, 2026-08-09T11:40Z (spawn `WO-0069/2026-08-09T10:30Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-architect_docs_lead-0031`
- **Files**: `docs/specs/modules/xgmii_rx_64.md` (FROZEN — §10's REQ-802/REQ-810
  hook, one §13 row), `docs/specs/requirements.md` (§0.6, one §13 row), this
  packet. **Three hunks in the two specifications and no more**; no ADR written;
  no `Interface` record, port, width, cycle, window edge, strobe or requirement
  moved; nothing outside `docs/**` and `agents/handoffs/**` touched.
- **Both items ruled in-role. No escalation.** Neither ruling moves a row of
  `AP-xgmii_rx_64.md` in either direction — the packet's own bound, honoured and
  checked rather than asserted (§6 below).

#### 1. Item 1 — RULED **UNPASSABLE**. dv's derivation is re-derived from the primary sources and **VERIFIED**, not accepted

The instruction was to adjudicate on SPEC-M03's own text before applying any
repair, and to rule the hook passable if it is. It is not. The derivation below
is worked from the specification rather than from the packet, in **cycles**, and
it closes the one hole the packet's prose version leaves implicit — *why the
change may not land on the aborted frame's own start cycle for a reason
independent of C-14.5*.

Write octet time = 8·cycle + lane, `s` for the cycle of the aborted frame **A**'s
start word, `w` for the cycle of the word **W** carrying the refusing start
character, and let the enable fall 1 → 0 at cycle `c` (high for cycles < `c`,
low from `c` on).

1. **A is admitted**, so the enable is 1 when A's start character is sampled:
   `c > s`. (§4.3, sampling at the start character; ADR-0014 clause on admission.)
2. **A delivers no octet**, so the refusing `/S/` lies **at or before A's first
   octet** — §9's ninth row, restated extensionally at `1fe71ca`, and REQ-110's
   own governing clause. A's first octet is exactly 8 octet times after its start
   character (§6.1, REQ-102), so the refusing `/S/` lies in
   `(start_A, start_A + 8]`.
3. **§0.3 confines start characters to lanes 0 and 4.** At a lane-0 A
   (`start_A = 8s`) the only candidates in that half-open span are octet times
   `8s + 4` (lane 4 of word S) and `8s + 8` (lane 0 of word S+1); at a lane-4 A
   (`start_A = 8s + 4`) they are `8s + 8` and `8s + 12`, both in word S+1.
   **Therefore `w ∈ {s, s+1}` at both start lanes** — never further.
4. **The new frame must be refused**, so the enable is 0 when W's start character
   is sampled, and §4.3 makes that determinate only for a change at least one
   cycle earlier: `c ≤ w − 1`. §6.3 item 7 (**C-14.5**) forbids the same-cycle
   case in its own words and the hook's own "*at least one cycle before*" already
   concedes it.
5. **Conjoining 1 and 4**: `c ∈ [s + 1, w − 1]`, which for `w = s` is `[s+1, s−1]`
   and for `w = s+1` is `[s+1, s]`. **Empty in both, at both start lanes.**

**The hole closed.** Even setting §6.3 item 7 aside, `c = s` is excluded by step 1
alone: at `c = s` the enable is 0 on A's own start cycle, so A is not admitted and
there is no in-flight frame to abort. §6.3 item 7 is therefore not load-bearing
for the *emptiness*; it is load-bearing for the *determinacy* of the `w = s` row,
where W is A's own start word and any change at `c = s` would be a change on a
start character's cycle. **The conclusion survives the removal of item 7 from the
argument**, which is worth stating because the packet's §1.5 rejects widening item
7 as a repair and a reader could otherwise think the finding depends on the very
clause it declines to move.

**Both escapes independently checked and closed on normative text.** `first_start`
is 8 or 12 by §0.3 and moving it moves A's start cycle and W together, so the span
never opens; and an injected idle between a start character and the first octet
is forbidden by §6.1 and §10's REQ-016 hook in terms (**M03-N3**) — and would in
any case abort A under REQ-105 rather than lengthen its preamble, so it does not
produce the branch even if driven.

**Ruled**: the parenthetical commissions a branch with **no legal stimulus at
M03**. It is the C-41 family, at the second instance §10 has carried. **Repaired,
not deleted** — the withdrawn wording is quoted inside its own withdrawal, on the
packet's own ground, so the record that the branch was once commissioned survives
and the next reader does not re-derive it.

**One figure of the packet's I decline to restate as it stands, non-blocking.**
§1.4's "*the zero-delivered REQ-110 abort is covered at M03-N2 sub-cases 3 and
6*" is dv's own plan claim and I neither verify nor disturb it; the specification
side of that sentence is the REQ-110 hook, which commissions the zero-delivered
geometry under `cfg_rx_enable` = 1 in its own column, and that is what the
repaired cell points at.

#### 2. Item 1, §4 question 1 — **one form, two grounds**, and the distinction belongs in the ground clause

dv asks whether *"commissioned, and no stimulus exists"* deserves a form distinct
from REQ-014's *"commissioned, and no instance exists at this module"*. **No.**
The distinction is real — the first is a fact about the stimulus space, the second
about the interface — but the annotation's **function** is identical in both:
stop a coverage claim on a branch that cannot be exercised. §10 has one form
because one form is what a sign-off reader should have to learn, and a second
shape buys a taxonomy at the cost of making the column harder to read at exactly
the moment it is being read for a claim.

The form is four parts, and both instances now carry all four: **(i)** the
commissioned text that *does* have instances is kept unchanged; **(ii)** what has
no instance is named, quoting the withdrawn wording; **(iii)** the ground is
stated in the cell — and *this* is where dv's distinction lives, REQ-014 naming an
instrument with no instance at this port class and REQ-802/REQ-810 naming an
empty interval in the stimulus space; **(iv)** the claim is closed with the
"stated so that no sign-off packet claims …" clause. Use the same four parts for
any future instance; vary only (iii).

#### 3. Item 2 — RULED: **a strobe is a level on a named cycle, not a counter**, and the multiplicity rule is not the rule this case is under

Landed as a non-normative note appended to §0.6's counting convention — the
paragraph it interprets — rather than beside the multiplicity paragraph, for the
reason that is itself the first half of the ruling. Five clauses, each derived
from text already in force:

1. **The *Strobe multiplicity* paragraph is not the governing rule.** It is
   scoped to *one frame* in its own words, and §12 gives every condition a
   dedicated name and shares none, so two conditions applying to one frame are
   always **two different strobes**. The per-frame rule is structurally incapable
   of producing a same-name pair. dv's case is **two frames, one name, one
   cycle**, which that paragraph never reaches.
2. **The obligation each reported event creates is a level, not an increment.**
   The event obliges the signal to be **high on the one cycle its own module
   specification pins**, inside §0.6's window. Two same-name events pinned to one
   cycle are therefore **both discharged by that single high cycle**, and the
   module has conformed. This is not a relaxation invented here: it is SPEC-M03
   §6.3 item 8's own sentence — "*a bench driving such a stimulus reports a
   silent discard against an M03 that has done everything this specification
   asks*" — read for what it says about the design rather than about the bench.
3. **The counting convention is the observer's inverse, and it is exact only
   while no two same-name events share a cycle.** C-23's "one high cycle per
   reported event" recovers the count by assuming the encoding is injective; on a
   shared cycle it under-counts and §0.6's conservation equation is short by the
   collided events. **The shortfall is in the decoding, never in the design.**
4. **Answering §4 question 2 directly**: the rule is read on **events**, and dv's
   operating assumption of *presence* is **corrected in its subject and confirmed
   in its consequence**. Presence is right about the **port** — one bit, one
   level per cycle — and wrong about the **contract**, which is per event. The
   consequence dv relied on is unchanged, because bit-identity is the criterion
   either way. What changes is what a packet may say: not *"the design is
   conformant here because presence held"*, but *"both events' obligations were
   discharged by the level, and no instrument at this port can recover the
   count"*.
5. **No multiplicity signal is owed**, and the ground is clause 2 rather than
   cost. The contract is already discharged by the level, so a count port buys
   **nothing for conformance** and only fault observability — at the price of a
   normative port change at every module, a new field class in §12's
   twenty-one-strobe enumeration and in REQ-804's status record. §6.3 item 8
   already priced and refused widening for the case where it *would* have bought
   something. dv asked for nothing further if the answer closed it; it closes it.

#### 4. Item 2 — **§6.3 item 8 is M03-local in its ground and general in its shape**; the carve-out is **not inherited**

The exclusion is available at M03 because **REQ-018's link-partner contract
injects one condition at a time** and **§0.3's twelve-octet gap with REQ-102's
eight-octet preamble** put two frame-ending characters at least eight octet times
apart. Those grounds are that module's and its stimulus contract's; they are not
§0.6's and they do not hold of another module by inheritance. **So dv's expectation
is the right one**: a module that can reach the collision is *not* covered by
M03's carve-out and owns its own disposition — exclude the stimulus, widen the
encoding, or show the collision unreachable. What *is* general, and is what the
§0.6 note states, is clauses 1–3 above plus the programme's default shape
(exclude the stimulus rather than widen the signal). **SPEC-M03 §6.3 is not
edited** — deliberately: a change to §6 after freeze is a spec diff **plus an
ADR** under SPEC-TEMPLATE rule 7, and nothing here needs one, because §6.3 item 8
already says everything its own module owes.

#### 5. Classes, and the countersignature standing stated rather than assumed

- **Item 1 — editorial, concurrence class; unilateral; no ADR, no
  countersignature.** SPEC-TEMPLATE rule 7 puts a post-freeze change to §4, §6 or
  §7 behind an ADR and leaves everything else needing "*only a journal entry*";
  this diff is confined to a **§10 verification-hook cell** and one §13 row. The
  precedents are §10's own 2026-08-03 REQ-014 row and requirements.md §13's C-46
  and C-39/C-41 verification-column rows; the line it stays on the right side of
  is C-43's (**normative text, not a verification column, is what carries the
  countersignature discipline**). No normative sentence moves: §4.3, §6.1, §6.2,
  §6.3 item 7, §9 rows 8 and 9, REQ-110, REQ-802 and REQ-810 are each unchanged
  and are what the derivation is *taken from*; **ADR-0014 is untouched in every
  clause** and is not reopened.
- **Item 2 — non-normative guidance; unilateral; no ADR, no countersignature**,
  in the `J-architect_docs_lead-0027` and 2026-08-04 §0.6 class. The honest test
  of that class is applied rather than asserted: **deleting the note leaves every
  conformant design, every committed bench and every requirement exactly where
  they are.** No SHALL, no sentence moved, no requirement or verification column
  amended, no strobe added or renamed, no cycle, window edge or pin moved, no
  test commissioned, no ledger item closed.
- **The standing, stated so it is not assumed.** If dv_lead reads **any** sentence
  of the §0.6 note as normative, that is a **fresh finding**, not an unsigned
  condition on this round: the sentence would then take a narrow countersignature
  round of its own, exactly as the `J-architect_docs_lead-0027` row records for
  its own note. Nothing is blocked meanwhile, because nothing rests on it that
  did not already rest on C-23, §12 and §6.3 item 8.
- **No ledger row minted and none owed.** Item 1 is C-41's family and cites it;
  item 2 closes no carry-forward — **C-23 stands unchanged and is not narrowed**,
  the note being an interpretation of it rather than an amendment to it.

#### 6. What dv may now record — **notification, not obligation**, and no row moves

Checked against the packet's DoD bound rather than asserted: **no row of
`AP-xgmii_rx_64.md` moves in either direction on either item.** M03-N4 stays
ASSERT on its delivering branch, which is untouched and stays commissioned whole;
M03-N2 stays ASSERT with its qualification and its T8 scope exactly as recorded.
Two things dv *may* now do, at its own discretion and on its own schedule:

1. **M03-N4's Observable cell** may cite the repaired hook — the specification's
   copy of the parenthetical is now in the same state as the plan's, so the cell's
   "*the hook's text is the architect's and not this plan's to edit*" clause has
   its counterpart landed.
2. **M03-N2's T8 clause** may cite requirements.md §0.6's note for the interface
   fact it currently states in its own words, and may sharpen one phrase if it
   wishes: the limit is that the port reports a **level per cycle** rather than
   that it reports "presence and not multiplicity" — the difference matters
   because it is what makes the conformance claim available at sub-case 4 while
   leaving the count unrecoverable. **This is an offer, not a defect**: the cell
   as written is not wrong about anything it measures.

Neither is a condition on this return, and neither is owed before any `SO-`.
