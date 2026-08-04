# WO-0060: Family I re-based onto the ruled D(m) — seven changes in one file, six of them one term or one sentence, and the round is judged on whether the numbers were *derived*

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it and records
  every state transition (PROTOCOL §3); I do not.
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/requirements.md` **§0.5** — the **deciding input
  word (normative)** paragraph with its output-word bullet, **the test a
  specification's D must pass (normative)**, **what survives idle injection
  (normative)**, and **what a latency monitor may demand on a gapped stimulus
  (normative)**; **REQ-016**; REQ-011, REQ-015, REQ-103, REQ-104, REQ-107,
  REQ-005, REQ-111. `docs/specs/modules/xgmii_rx_64.md` **§6.1** — the **D(m)**
  block, its refutation paragraph, the "output word m is emitted a fixed number
  of cycles after D(m)" paragraph, the two consequences, derivations 1–3, the
  preamble-position paragraph and the gapless `m + 3` sentence with its C-14.4
  qualifier; **§8**'s directed set; **§10**'s REQ-016 hook. **All at
  `1f3c04c`, in force from `155c9b2`** (requirements.md §13, `J-orchestrator-0167`).
- **Rows**: **two touched, none added, none converted, no status moved** —
  `AP-xgmii_rx_64.md` §4.I **M03-I4** (ASSERT) and **M03-I5** (NO-ASSERT), as
  they stand at **`b5d7e6e`**. M03-I1, I2, I3 and I6 keep their `Observable`
  cells unchanged; I6's *code* moves only because it shares M03-I4's helper.
- **Deliverables**, and nothing else:
  1. `test/xgmii_rx_64/test_m03_i.ml` — the seven changes of §3 and no other
     edit.
  2. Your journal entry in `agents/journals/workers/claude_tb_writer_agent.md`
     per PROTOCOL §4, with the spawn short-id in `Trigger`.
- **Definition of done**: the seven changes landed as specified; the four
  derivation obligations of §3 discharged **in the source's own comments**;
  §5's discipline visibly held; the promoted expect blocks committed as CI
  produces them, **never hand-edited to agree**; §6's prediction compared
  against the run and **any deviation reported, not absorbed**.
- **Context provided**: this packet; the spec sections above; the two AP cells
  quoted verbatim in §7. **No RTL, and one further exclusion stated in §7.2
  that is unusual enough to be the first thing you read.**
- **Out of scope**: `libs/**`, `docs/**`, `test/attack_plans/**`, every other
  file under `test/**`, and every other `%expect_test` in this file.

---

## 1. What this round is, in one paragraph

M03's bench encodes a rule that has been **replaced**. `RV-0059-VERDICT` §8 —
my own verdict, which this file cites nine times — said the deciding input word
of a non-`tlast` output word is the input word carrying that word's **own last
octet**. rtl_lead refuted it (E5), the architect re-ruled D(m) at `1f3c04c`, I
countersigned at `J-dv_lead-0086` and the ruling is in force from `155c9b2`. The
bench must now compute the ruled D(m). **Six of the seven changes are one term or
one sentence**; the seventh is a comment whose worked figures are now false. The
round is not hard. It is judged on one thing: whether you **derived** the new
numbers from the specification, or copied them from this packet.

---

## 2. The rule, so you can rebuild every number without me

Read §6.1's D(m) block yourself; this section exists so that when your
derivation and mine disagree you can tell which is wrong.

**Geometry** (SPEC-M03 §6.1's preamble paragraph, requirements.md §0.5's octet
time). Start lane `ℓ ∈ {0,4}`, start word at source cycle `s`, `N` = received
octets between the start character and the closing character:

- received octet `j` is at octet time `8s + ℓ + 8 + j`, hence source cycle
  `c(j) = ⌊(8s + ℓ + 8 + j)/8⌋` and lane `(8s + ℓ + 8 + j) mod 8`;
- the closing character's word is `T = ⌊(8s + ℓ + 8 + N)/8⌋`;
- the frame's first octet is in `f = c(0) = s + 1`, **at both lanes**;
- the frame delivers `N − 4` octets in `W = ⌈(N−4)/8⌉` words (REQ-103).

**The ruled D(m)** (§6.1, `1f3c04c`), one object for every output word:

> D(m) is the input word carrying whichever arrives first: **(a)** received
> frame octet **`8m + 12`**, whose arrival proves the frame runs past word m, or
> **(b)** the character that closes the frame.

**The branch you must derive rather than assume.** Octet `8m + 12` exists iff
`N ≥ 8m + 13`; word m is its frame's last iff `8m + 5 ≤ N ≤ 8m + 12`. So
`N ≥ 8m + 13 ⟺ m < W − 1` **exactly**, and the two evidences are exclusive
rather than merely ordered: **(a) decides precisely the non-`tlast` words and
(b) precisely the `tlast` word.** This is why the existing `m = words - 1`
branch is *already the right branch* and does not move — a fact you are required
to state, with its derivation, in the docstring (§3.2, obligation D1).

**The offsets**, which are `(s + m + 3) − D(m)` read off the gapless `m + 3`
formula at D(m)'s own position:

| lane | D(m) = (a) | D(m) = (b), `r ≤ 3` | `r = 4` | `r ≥ 5` |
|---|---|---|---|---|
| 0 | **1** | 1 | 1 | **2** |
| 4 | **0** | **1** | **0** | 1 |

with `r = N mod 8`. These are §6.1's own four numbers ("one at a lane-0 start
and zero at a lane-4 start where D(m) is (a); one or two at a lane-0 start and
zero or one at a lane-4 start where D(m) is (b)"). **The lane-4 zeros are
legal** — §0.5's causality test permits an output at the same cycle as the input
word that decides it, because a module's output at cycle *t* is a function of
its registers and of the input word at *t*.

**Two consequences you will rely on and should check before you do.** At
`k = 0` the injection map is the identity, so `emit(m) = s + m + 3` identically:
**no gapless cycle moves**. And the (b) branch is the *unchanged* bullet, so
**no `tlast` word's cycle moves at any `k`**. Everything this round changes is
the non-`tlast` words of an injected run.

---

## 3. The seven changes

All in `test/xgmii_rx_64/test_m03_i.ml`. Line numbers are at `b5d7e6e` and are
navigational, not normative — if the file has moved, find the construct.

### 3.1 The D(m) helper — `:922–924`. One term.

```ocaml
let dependency_source_cycle ~start_octet_time ~terminate_cycle ~words m =
  if m = words - 1 then terminate_cycle else (start_octet_time + 8 + (8 * m) + 7) / 8
```

`+ 7` → **`+ 12`**. Nothing else in the function moves.

**You SHALL NOT rewrite the branch** to test `N ≥ 8m + 13` or anything else. The
branch is correct and the packet's §2 says why; replacing a correct predicate
with an equivalent one hides the fact that you checked it.

**Derivation obligation D1**: the docstring (§3.2) must state and derive
`N ≥ 8m + 13 ⟺ m < W − 1`, as the reason the branch stands. A repair that
changes `7` to `12` without that derivation is a **BOUNCE**, because the whole
defect being repaired was a rule adopted without one.

All four call sites — `:1015`, `:1039` (M03-I4) and `:1432`, `:1452`
(M03-I6) — take the new numbers with **no change of their own**. Confirm that
and say so in your return; if you find yourself editing a call site, stop and
ask, because it means one of us has misread the helper.

### 3.2 The helper's docstring — `:895–921`. Rewrite.

It states the replaced rule in prose: *"the source cycle of the input word
carrying output word m's own **LAST** octet … SPEC-M03 §6.1 consequence 1"*.
Replace with the ruled D(m), citing `1f3c04c` / `J-architect_docs_lead-0025` and
requirements.md §0.5's output-word bullet.

**Delete this sentence outright**: *"The terminate character's octet time always
exceeds the last delivered octet's, so this is also the later of the two
dependencies and the formula needs no `[max]`."* Under the ruled D(m) there is
no `max` to consider **for a different reason** — the branches are exclusive by
the N-comparison, not merely ordered — and that reason must replace it. Carrying
the old sentence forward would leave a true-sounding statement resting on the
withdrawn rule.

Also carry into the docstring, because §6.1 states them and a later reader will
ask: **no gapless cycle moves at `k = 0`**, and **no `tlast` word's cycle moves
at any `k`**.

### 3.3 The delay-identity anchor — `:1100`. One term.

```ocaml
        let c = (8 * m) + 7 in
```

→ **`(8 * m) + 12`**. The `tlast` branch above it,
`idles * (terminate_cycle - first_octet_cycle)`, is **unchanged**: the injection
sites are the boundaries before cycles `f + 1 … T`, so their count is `T − f`,
which is exactly `terminate_cycle - first_octet_cycle`. Say in your return that
you re-derived that rather than left it alone by default.

### 3.4 The comment above it — `:1071–1092`. One phrase is now inverted.

It reads *"(content index 8m + 7, **always inside that word by
construction**)"*. That is now **false and backwards**: the anchor is
deliberately **outside** output word m — one input word later at a lane-0 start,
two at a lane-4 one — because the evidence that word m is full and not last is
precisely an octet that is not word m's own.

**Derivation obligation D2**: the in-range condition must be **derived from the
branch**, not assumed. For a non-`tlast` word `N ≥ 8m + 13`, so received octet
`8m + 12` exists (`8m + 12 ≤ N − 1`) and `in_injected.(8m + 12 + 8)` is inside
the array. Write that derivation where the old "by construction" claim sat.

### 3.5 The per-octet reporting comment — `:1119–1142`. Both worked figures are false.

**(a)** *"worked at length 64, lane 0, idles 1: L = 24 for the last four octets
against L = 16 for every earlier one"* — under the ruled D(m) the 64-octet
lane-0 frame at `k = 1` has `r = 0` and **every delivered octet measures 24, a
single value**. Replace the example with a lane-0 length that genuinely shows two
classes: **69** (in §8's directed set, `r = 5`), which gives **`{16, 24}`** at
`k = 1`, the 16 belonging to the `tlast` word's **single** delivered octet, which
shares the terminate character's own input word and is therefore separated from
its evidence by no injected idle at all. This is §6.1 item 1's own worked
example; derive it, then check it against that item.

**(b)** *"at a lane-4 start every output word straddles two source input words …
so octets 0..3 and 4..7 of the SAME word carry different L"* — the split is real
for the **non-`tlast`** words and its figures are now **28 and 20 at `k = 1`**,
not 20 and 12.

> **BAR — and this is the one place in this round where you must write *less*
> than you can derive.** **You SHALL NOT write an expected per-octet class set
> for a lane-4 start into this comment or anywhere else in the file.** State the
> split for the **non-`tlast`** words, note that the `tlast` word follows the
> residue rule and that its classes are **reported and not predicted here**, and
> stop.
>
> *Status of the cell this bar was written against, updated after
> `d54c931`.* When I drafted this the bar had a second reason: §6.1 item 2 was
> the subject of an open finding — **F-1** (`J-dv_lead-0086`), item 2 being
> headed *"every output word, at a lane-4 start"* and false for the `tlast` word
> at seven of eight residues. **F-1 is now RULED and repaired at `d54c931`, in
> force on commit**: item 2's split is stated as the non-`tlast` words'
> arithmetic and the `tlast` word carries its own residue table. **The bar
> stands unchanged**, on the reason that always carried it: §0.5 and §6.1 item 3
> forbid *asserting* a per-octet class at this module, the values are reported
> as data, and a class set written into a comment is a prediction a later reader
> will treat as one. You may now read the repaired item 2 as reference for what
> the run will print — **and you may not encode it**.

### 3.6 The citations — `:4`, `:36`, `:134`, `:1008`, `:1034`, `:1052`, `:1071`, `:1114`, `:1430`, `:1461–1462`.

Every one cites **`RV-0059-VERDICT §8`** as the authority for the cycle rule.
**That verdict's §8 is the rule that was refuted** — it is now the most
misleading citation in the tree, because it points a reader at a superseded
document as if it governed. Re-cite to **SPEC-M03 §6.1's D(m) at `1f3c04c`**
(and requirements.md §0.5 where the file cites §0.5's deciding input word).

Where a comment records *history* rather than authority — e.g. `:895`'s note
that round 1 sent `cycle_of` an **output** cycle — keep the history and re-cite
the rule. The two error-message strings at `:1052` and `:1461–1462` are read by
a human debugging a red unit; they must name the clause in force.

### 3.7 Nothing else moves. The list is exhaustive.

`injected_word_cycle`'s structure (`:926–930`); `first_octet_cycle` (`:989`);
`terminate_cycle` and its cross-check (`:975–976`, `:1408–1409`); the word-count
guards (`:1023`, `:1440`); the `tkeep`, `tlast`, delivered-octet and strobe
guards; `account_injected_frame`; the `assert_monitors_clean` gating; the local
tagger's `Latency.errors` assertion (`:1167–1170`); `Stdlib.print_string` and its
reason; and every `%expect_test` other than M03-I4's and M03-I6's, including the
`run_i1` / `run_i2` / `run_i3` count guards at `:290`, `:445` and `:643`, which
belong to other rows.

**The front-offset assertion at `:1167–1175` STAYS an assertion.** `h` is
§0.5's **correspondence** term — the number of octet times between the input
measurement event and the frame's first emitted octet, *measured at the input* —
so it is a purely input-side quantity and is untouched by when a word leaves.
It stays 8 at lane 0 and 12 at lane 4. Do not demote it, do not widen it, and do
not fold it into the reporting.

---

## 4. The new sentence that owes NO new guard, and why you must not invent one

§6.1 now says: *"a word whose D(m) has not arrived is not emitted, even where its
own octets are already complete inside the module: `tvalid` is 0 on those cycles,
and that is the observable half of this rule that an injected run measures."*

That reads like a new obligation. **It is not, and this row already closes it —
by a pair of guards, neither of which closes it alone:**

- the **word-count** guard (`:1023` for M03-I4, `:1440` for M03-I6) requires
  exactly `words` words with `tvalid`;
- the **per-word cycle** guard (`:1039`, `:1452`) requires each of them at its
  own `injected_word_cycle`.

A design that emits word m early **and again** at the pinned cycle breaks the
count. A design that emits it early **instead** breaks the cycle guard. There is
no third behaviour: an early `tvalid` word is either extra or displaced.

**So: add no guard for it.** This is the same argument M03-I4's cell already
makes for keeping clauses (a) and (b) separate — two assertions that jointly
close a property and individually do not — and it is stated here because the
alternative failure is a worker adding a third, redundant assertion that then has
to be maintained against every future ruling. If you think you have found a
behaviour the pair misses, **say so in your return and add nothing**; that is a
finding about this packet, and it is worth more than a guard.

---

## 5. Derivation, not hardcode — the discipline this round is actually graded on

1. **The cycles appear nowhere in the source.** Not 5, 7, 9 … 19; not 11, 19, 27
   … 67; not as a literal, a table, or a `match`. They are the **outcome** of
   `dependency_source_cycle` composed with `Idle_injection.cycle_of`. §6 states
   them as a prediction *to be reproduced by your code*, and if your code
   reproduces them by containing them the round is a BOUNCE.
2. **The two routes stay independent, and you must change them independently.**
   Route 1 is `injected_word_cycle` (via `Idle_injection.cycle_of`). Route 2 is
   the delay identity read off raw octet times (`Idle_injection.in_times` against
   `Arrival.in_times`). They exist as two derivations of one spec sentence so
   that **a defect in the injection translator cannot silently validate itself**.
   The two `+ 12`s of §3.1 and §3.3 are therefore **two separate derivations of
   the same clause**: derive each from §6.1 on its own, do not factor them into a
   shared helper, and do not make either route call the other. Preserving that
   independence is worth more than the deduplication it costs.
3. **`cycle_of` is applied to a SOURCE cycle only, never an output cycle.** This
   file's round-1 defect (`FINDING 1` / `FINDING 3`) was exactly that, and the
   prohibition stands unchanged.
4. **`m + 3` is never recomputed under injection** (M03-I5's NO-ASSERT scope).
   It is the gapless formula and the *offsets* of §2 are read from it; it is
   never the injected answer.
5. **ADR-0015 D2 — no expectation is ever amended to agree with the design.**
   §6 predicts 36 red units. If they are red, **commit them red**, promote the
   expect blocks exactly as CI produces them, and report. Adjusting an
   expectation to make a unit green is the one act that would make this round
   worse than not doing it.

---

## 6. The predicted red set — stated in this packet, before any run

**This repair widens the red set before it narrows it, and that is correct.** The
bench is being brought into line with a ruling the design has not yet been built
to (the design gates emission on nothing, so it emits a word as soon as its
octets are complete). Nothing here is withheld — PROTOCOL §10's R-SEAL-1 does not
reach this section, because the result does not exist yet.

Word 0's pin moves by exactly **`k`** cycles at both start lanes and every
directed length: `s + 3 + k` at lane 0 against the design's `s + 3`, and
`s + 3 + 2k` at lane 4 against the design's `s + 3 + k`. Therefore:

- **36 units go red**: M03-I4's **32** injected members at `k ∈ {1,7}` (16
  (length, lane) combinations × 2) and **all 4** of M03-I6's.
- **All 16 of M03-I4's `k = 0` members stay green**, and so does every other
  family in the tree. §2's `k = 0` identity is what guarantees it.
- **Every one of the 36 fails at word 0**, not at word 7, with
  **`expected − observed = k`**. At length 64 / lane 0: **5 against 4** at
  `k = 1`, **11 against 4** at `k = 7`.
- The **current** symptom — M03-I4/I6 red at **word 7**, 18 against 19 (CI run
  `30895770553`) — **disappears as a distinct symptom**, because those units now
  fail earlier for the reason that was always underneath it.

**Anything else convicts the repair and not the design**: a green `k ≥ 1` unit, a
first failure at a word other than 0, a delta that is not `k`, any movement in a
`k = 0` member, or any other family going red. Report the deviation with its
numbers in your return and change nothing to accommodate it.

---

## 7. Context provided

### 7.1 The two AP cells, as they stand at `b5d7e6e`

**M03-I4 `Observable`, clause (b)** — the contract you are implementing:

> (b) **Each output word is delayed by exactly the idle cycles injected at or
> before its deciding input word D(m)**, at **both** start lanes; SPEC-M03 §6.1
> names D for this module, and **D(m) is RE-RULED at `1f3c04c`
> (`J-architect_docs_lead-0025`), countersigned at `J-dv_lead-0086`**: **D(m) is
> the input word carrying whichever of two pieces of evidence arrives first —
> received frame octet `8m + 12`, whose arrival proves the frame runs past word
> m, or the character that closes the frame** (REQ-106's `/T/`, REQ-105's `/E/`,
> REQ-110's `/S/`, REQ-108's count). The two are **exclusive**, and
> `N ≥ 8m + 13 ⟺ m < W − 1` **exactly** […] **No `tlast` word's cycle moves at
> any `k`** and **no gapless cycle moves at all** […] **And a word whose D(m) has
> not arrived is NOT emitted (`tvalid` = 0)**: that half needs no separate guard,
> because this row's word-**count** guard and its per-word **cycle** guard cover
> it **as a pair** […] and neither alone suffices.

**M03-I4 `Observable`, the class-table sentence** — what may be *reported*:

> **§6.1 item 3's carve-out … is WITHDRAWN at `1f3c04c`** […] The classes this
> row **reports**, for a frame of more than one output word, are: **lane 0** —
> `r ∈ {0…4}` → `{16 + 8k}`, `r ∈ {5,6,7}` → `{16, 16 + 8k}`; **lane 4** —
> `r ∈ {0,4,5,6,7}` → `{12 + 8k, 12 + 16k}`, `r ∈ {1,2,3}` →
> `{12, 12 + 8k, 12 + 16k}`, **three classes**, which is `J-dv_lead-0086`'s
> **FINDING F-1** […] and is **outstanding with architect_docs_lead** […]
> **Every one of these values is REPORTED and none is ASSERTED**, so F-1's
> resolution moves this row in neither direction.

**Read the lane-4 half of that as reference for what the run will print, not as
something to encode** (§3.5's bar). The lane-0 half you may derive and use in a
comment; it is not disputed.

*The cell's "outstanding" clause is superseded by events, not by error*: **F-1
was RULED and repaired at `d54c931`** (SPEC-M03 §6.1 item 2 only), after
`b5d7e6e` and after this packet was drafted. The AP cell's own final sentence is
why nothing here moves — the values are reported and not asserted, so the row was
built to survive the ruling in either direction and did. The cell's wording is
the attack plan's to correct in its own next round, not yours and not this
packet's; **no row, status or count changes**, and the repaired item 2 agrees
with the class sets quoted above.

**M03-I5 `Observable`** is unchanged by this round and still governs: neither
`m + 3` nor a single per-octet `L` may be asserted on an injected run.

### 7.2 The exclusion that is unusual enough to state first

> **You SHALL NOT open `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`.**

That packet is mine and it is where this round comes from, so the bar needs its
reason. **From its "Root cause" heading onward it contains RTL source, rtl_lead's
pre-fix and post-fix eight-row cycle tables, and the design's actual emitted
cycles.** Those are design-derived expected values. Reading them would put you in
the position ADR-0015 D2 exists to prevent — writing an expectation that agrees
with the design because you saw the design — and it would do so on the very run
whose value is that the bench and the design disagree.

Everything you need from that packet is reproduced in this one: the rule (§2),
the changes (§3), the classes (§7.1), the prediction (§6). Nothing is held back
from you.

The same bar covers `libs/**` (standing, PROTOCOL §10) and, for the same reason,
`rtl_snapshots/**`.

### 7.3 What you may and should read

`docs/specs/requirements.md` §0.5 and REQ-016; `docs/specs/modules/xgmii_rx_64.md`
§6.1, §8, §10; `test/attack_plans/AP-xgmii_rx_64.md` §4.I; the file you are
editing and the `Dv_xgmii` / `Dv_monitors` interfaces it uses. If a derivation in
§2 disagrees with §6.1, **§6.1 governs and the disagreement is a finding against
this packet** — say so in your return rather than splitting the difference. That
instruction has been taken up once before in this programme, at family G, and it
was the best act of that round.

---

## 8. Your return

State, in the Return log below and in your journal:

1. Which of the seven changes landed, and confirmation that the four call sites
   of §3.1 needed **no** edit of their own.
2. **D1** and **D2** — the two derivations, written out, as they appear in the
   source.
3. Confirmation that §3.3's `tlast` shift formula was **re-derived** (`T − f`)
   and not merely left alone.
4. The observed red set against §6's prediction, **member by member for any
   deviation**, with expected and observed cycles.
5. Anything in §2 you found wrong, and anything in §4 you believe the guard pair
   misses.
6. The CI run id and conclusion (ADR-0005 / REQ-906: a local result is not
   evidence).

## Return / verdict log

*(appended on RETURNED / ACCEPTED / BOUNCED, with journal-entry refs)*
