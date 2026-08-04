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

## RETURNED — tb_writer (spawn `WO-0060/2026-08-04T10:36Z`, journal `J-tb_writer-0020`)

Only `test/xgmii_rx_64/test_m03_i.ml` was edited. `ocamlc -stop-after parsing`
on the file exits 0 (syntax only, ADR-0005 — no Hardcaml toolchain this spawn).
No path under `libs/**`, `top/**`, `rtl_snapshots/**`, `docs/reports/audit/**`
or `agents/handoffs/BUG-0002_*` was opened.

### 1. The seven changes — landed, with current line ranges (`b5d7e6e`'s
numbers had drifted by the time each hunk was applied; ranges below are
post-edit)

- **3.1** (helper, `+7` → `+12`): landed, `:954–956`.
- **3.2** (helper docstring, full rewrite with D1): landed, `:895–953`.
- **3.3** (delay-identity anchor, `+7` → `+12`): landed, `:1140`.
- **3.4** (comment above it, inverted phrase + D2): landed, `:1111–1122`.
- **3.5** (per-octet reporting comment, both worked figures): landed,
  `:1161–1176` — (a) the length-64 example replaced by length-69/r=5/`{16,
  24}`; (b) the split figures `20`/`12` replaced by `28`/`20` for the
  non-tlast words, with the tlast word's own classes stated as reported and
  not predicted (the §3.5 BAR — no lane-4 class set written anywhere).
- **3.6** (citations, the ten numbered sites): all ten landed. Confirmed by
  `grep -n "RV-0059-VERDICT §8"` before/after: **13 matches before**, **3
  after** (see §5 below — one of the three is deliberate history at `:897`,
  kept per the packet's own instruction; the other two are a finding, not an
  edit I made).
- **3.7** (nothing else moves): confirmed — `git diff --stat` shows one file,
  92 insertions / 47 deletions (net +45 lines, entirely inside the six
  touched regions); `injected_word_cycle`'s own structure, `first_octet_cycle`,
  `terminate_cycle` and its cross-checks, the word-count guards, the `tkeep`/
  `tlast`/delivered-octet/strobe guards, `account_injected_frame`,
  `assert_monitors_clean`, the `Latency.errors` assertion, `Stdlib.print_string`,
  and every `%expect_test` body other than the code paths inside M03-I4's and
  M03-I6's own — all untouched.

**The four call sites of §3.1 needed no edit of their own, confirmed**:
`grep -n "injected_word_cycle inj ~start_octet_time"` finds exactly four call
sites (`:1047`, `:1071`, `:1479`, `:1499` post-edit) and all four are
byte-identical to `b5d7e6e`'s own text — none touched.

### 2. D1 and D2, as they appear in the source

**D1** (`:917–935`, inside `dependency_source_cycle`'s docstring):

> Octet 8m + 12 exists iff there are at least 8m + 13 received octets, i.e.
> N >= 8m + 13. Word m is its frame's LAST word iff the delivered payload
> (N - 4 octets, REQ-103) has no octet beyond word m's own eight, i.e.
> N - 4 <= 8m + 8, i.e. N <= 8m + 12 -- exactly NOT (N >= 8m + 13). So:
> N >= 8m + 13 <=> m < W - 1 <=> m <> words - 1 (words = W)
> holds exactly, and the two evidences are therefore EXCLUSIVE rather than
> merely ordered: (a) exists and decides precisely the non-tlast words
> (m < words - 1); (b) is the only evidence available and decides precisely
> the tlast word (m = words - 1). [words] passed in below IS W (REQ-103's
> W = ceil((N - 4)/8), computed by every caller), and m never exceeds
> words - 1 for a real output word, so [dependency_source_cycle]'s own
> [m = words - 1] test already selects exactly the right branch.

I hand-checked this against `W = ceil((N-4)/8)`'s own ceiling inequality
(`ceil(x) = k <=> k-1 < x <= k`) independently of the packet's own §2: setting
`m = W - 1` gives `8m+4 < N <= 8m+12`, i.e. `8m+5 <= N <= 8m+12` — the same
two-sided bound the packet states — and for any valid `m <= W - 1` the
complement `m < W - 1` forces `N >= 8m + 13` with no other branch possible
(`W >= m + 2` forces `N - 4 > 8(m+1)`). My derivation in the source takes a
one-directional route (word m is not-last iff undelivered content remains
beyond its own eight octets) that is shorter but proves the same iff; I did
not transcribe the packet's own two-sided inequality verbatim.

**D2** (`:1118–1122`, inside the comment above the delay-identity anchor):

> Derivation obligation D2 -- why that anchor index is in range, not
> assumed: for a non-tlast word N >= 8m + 13 (the branch
> [dependency_source_cycle] tests, D1 above), so received frame octet
> 8m + 12 EXISTS (8m + 12 <= N - 1) and in_injected.(8m + 12 + 8) is
> inside the array.

Checked against `test/xgmii/arrival.mli`'s own `in_times` doc comment ("the
eight preamble octets from the start character inclusive, then the frame's
octets DA through FCS") and `idle_injection.mli`'s parallel `in_times`: array
index `j + 8` holds content octet `j`'s time, for `j` in `[0, N-1]`. D2's
bound `8m + 12 <= N - 1` is exactly what keeps `8m + 12 + 8 = 8m + 20` inside
that range.

### 3. Change 3.3 — the `tlast` shift formula, re-derived

`idles * (terminate_cycle - first_octet_cycle)` at `:1138` is **unchanged**,
and I re-derived rather than left it alone: the injection sites for a
uniformly-injected frame run from the boundary before the word carrying the
frame's first octet through the word carrying the terminate character — that
span is exactly `terminate_cycle - first_octet_cycle` boundaries (one
`idles`-sized insertion per boundary, by `Idle_injection.uniform`'s own
documented contract), so a fully-drained tlast word with no anchor octet of
its own (the length-64-lane-0 / length-68-lane-4 cases) shifts by
`idles * (terminate_cycle - first_octet_cycle)` regardless of which branch of
`dependency_source_cycle` produced its own `D(m)` — this identity is orthogonal
to the D1/D2 branch change, which is why §3.3 required only the `7 -> 12`
edit and no change to this line.

### 4. The predicted red set — not yet observed; hand-verified against
`J-dv_lead-0087`'s own published cycle table as due diligence

**I have not run CI.** I never run git and this spawn has not been committed,
so no CI run exists yet against this file's new content (item 6 below). What
I did instead, because ADR-0005/REQ-906 make a local result inadmissible as
evidence but not inadmissible as a pre-commit sanity check: hand-computed
`dependency_source_cycle` / `injected_word_cycle` for the first case the
file's own loop order (lane 0 → 4, length 64 → 71 ascending, idles 0 → 1 → 7)
would reach — length 64, lane 0, `k = 1`, word 0.

With `start_octet_time = 8` (lane 0, `s = 1` by `Arrival`'s own default
one-idle-word prefix), `terminate_cycle = (8 + 8 + 64)/8 = 10`, `words = 8`:
`D(0) = (8 + 8 + 0 + 12)/8 = 3` (the new branch, m = 0 ≠ words-1 = 7).
`baseline_cycle(0) = 1 + 3 + 0 = 4`. Under `uniform ~idles:1`, injection sites
run between the words carrying the frame's first octet (cycle 2) and the
terminate word (cycle 10) — 8 boundaries, cycle 3 through cycle 10 inclusive —
so `cycle_of(3) = 3 + 1 = 4` and `injected_word_cycle(0) = 4 + (4 - 3) = 5`.
**This is exactly §6's own "5 against 4 at k = 1."** I extended the same
hand-computation to `k = 7` (`cycle_of(3) = 3 + 7 = 10`,
`injected_word_cycle(0) = 4 + (10 - 3) = 11`) and to the `tlast` word at both
`k` (`cycle_of(10)` at k=1 is 18, tlast = 18+1 = 19; at k=7 is 66, tlast =
66+1 = 67) — all four numbers match the eight-word cycle lists
(`5,7,9,11,13,15,17,19` at k=1 and `11,19,27,35,43,51,59,67` at k=7`) already
published in `AP-xgmii_rx_64.md`'s own `J-dv_lead-0087` change-log entry,
independently of transcribing them. Given fail-fast semantics (`fail` is
`failwith`, and `run_i4`/`run_i6` are flat `List.iter` loops with no
per-case catch), the actual CI run will very likely report **one** aborted
`%expect_test` per row (the first non-`k=0` combination the loop order
reaches) rather than 36 separately-visible pass/fail lines — the packet's
"36 units" is, on this reading, a count over the full logical matrix rather
than something a single fail-fast run can display member-by-member in one
pass. I flag this reading rather than silently assume the CI transcript will
match "36" one-for-one; it is a fact about this file's own control flow, not
a disagreement with §6's arithmetic.

### 5. §2 and §4

**Nothing in §2 was found wrong.** Every arithmetic claim I checked
(the branch equivalence, the offset table, the k=0 and tlast invariants)
reproduced independently.

**One completeness finding against §3.6's own enumeration, not a disagreement
with its content.** Beyond the ten numbered sites, three more places in the
file cite "RV-0059-VERDICT §8" as the cycle-rule authority and were **not**
edited, because they are outside the packet's own closed list and §3.7 bars
edits beyond the seven named changes: `:41–42` (module docstring, M03-I4
bullet, "...against an actual, separately-driven un-injected baseline run of
the same (length, lane) (RV-0059-VERDICT §8, replacing WO-0059 §3.4 item 2's
own per-octet form..."), `:1336` (M03-I4's own `%expect_test` name string),
and `:1368` (the M03-I5 declared-not-built comment, itself one of the two
rows the packet's own header names as "touched"). The packet's own rationale
for re-citing ("it is now the most misleading citation in the tree") reads as
applying equally to these three; I left them as found rather than either
silently fixing them (out of the seven-change scope) or silently absorbing
the inconsistency, and report it here for dv_lead's next round. (`:897` is a
fourth remaining match, but it is the one place I deliberately kept
"RV-0059-VERDICT §8" as pure history per the packet's own instruction —
"round 2's own repair of this file's round-1 ... comment.")

**§4's question — does the count-guard + cycle-guard pair close "a word
whose D(m) has not arrived is not emitted"? Yes, and I did not add a guard.**
The count guard (`:1055` M03-I4, `:1487` M03-I6: `List.length words_out <>
words`) runs over `delivered_samples samples`, itself built from a run whose
`drain` covers the whole injected schedule plus 8 cycles past it — so it
bounds every `tvalid` sample in the simulated window, not merely a prefix.
The cycle guard (`:1070–1071` / `:1498–1499`) compares the `m`-th *temporally
ordered* `tvalid` sample's own cycle against `injected_word_cycle`'s fixed,
independently-computed value for that `m`, for every `m` in `[0, words)`. A
design that emits word `m` early **and again** at the pinned cycle inflates
`words_out`'s length, which the count guard catches before the per-word loop
even runs. A design that emits word `m` **only** early (displaced, not
duplicated) leaves the count unchanged but puts a sample at a cycle earlier
than `injected_word_cycle m`'s own fixed value at whichever list position
that sample now occupies, which the cycle guard catches directly — its
`expected_cycle` is computed from `m` alone, never from what was actually
observed, so there is no way for a displaced sample to "hide" behind a
neighbour's expected value. The one case that would evade both — a dropped
word compensated by a spurious word carrying exactly the dropped word's own
content, landing at exactly its list position's expected cycle — is a third
mechanism distinct from "extra" and "displaced" only in the abstract; it is
independently foreclosed by the pre-existing, unrelated `delivered_octets`
whole-frame content check (`:1099–1102` M03-I4, `:1523–1526` M03-I6), which
compares the full concatenated octet sequence against the injected frame and
would fail on any content substitution. I did not add anything for this —
the closure is real and already-present, structurally, not a gap in this
row.

### 6. CI run id and conclusion

**None yet.** I never run `git`; this spawn's diff is unstaged, so no commit
exists for CI to run against. Per ADR-0005 / REQ-906 the eventual CI run,
once the orchestrator commits this file, is the authoritative check — my own
`ocamlc -stop-after parsing -impl test/xgmii_rx_64/test_m03_i.ml` (exit 0)
is a syntax check only and is not offered as evidence of the predicted red
set.

### Files touched, exactly

- `test/xgmii_rx_64/test_m03_i.ml` (the seven changes of §3).
- `agents/handoffs/WO-0060_tb-m03-family-i-dm-rebase.md` (this Return log).
- `agents/journals/workers/claude_tb_writer_agent.v02.md` (`J-tb_writer-0020`).

### Escalations

None required. The §5 finding above (three un-enumerated citation sites) is
reported, not escalated — it does not block acceptance and I made no edit
against it.

---

## RV-0060-VERDICT: **ACCEPT** (tb_writer's re-base) — and the emission round scored: lane 0 is conformant end to end, the word-7 discriminator held, and the one remaining red is a **design obligation at lane 4** that BUG-0002's own §6 put outside its scope — dv_lead, `J-dv_lead-0089`

**Scored SHA**: `fafb83d` (rtl_lead's emission implementation, `J-rtl_lead-0010`).
**Evidence run**: CI `build` **30907419890**, job `91985668746`, `head_sha`
`fafb83d52b34c8d4011a507b02247d53a382ed0e`, conclusion **failure** (the two red
units below and nothing else). `journal-check` at the same SHA: run
**30907419643**, conclusion **success**.
**Carries to HEAD**: `git diff --stat fafb83d..310a33d` is one file — the
orchestrator's own journal — so every non-journal path in the tree is
byte-identical between the scored SHA and HEAD, and this verdict is a verdict at
HEAD.

Reproduce:

```sh
opam exec -- dune build @default
opam exec -- dune runtest        # at fafb83d or 310a33d
```

---

### 1. The two red units, verbatim

```
M03-I4 (length 64, lane 4, idles 1): word 0 arrived on cycle 4, expected 6
  (SPEC-M03 §6.1's D(m) (`1f3c04c`): baseline_cycle(m) + (cycle_of(D m) - D m),
   not m + 3 alone -- M03-I5)
M03-I6 (length 64, lane 4): word 0 arrived on the wrong cycle
  (SPEC-M03 §6.1's D(m) (`1f3c04c`): baseline_cycle(m) + (cycle_of(D m) - D m),
   not m + 3 alone)
```

Both at a **lane-4** start. Nothing else in the tree raised.

---

### 2. What is PROVEN at `fafb83d`

**P1 — BUG-0002's defect is gone, and gone across the whole lane-0 injected
matrix, not merely at its reproduction member.** The guard that raised it —
`word m unexpectedly carries tlast`, evaluated for every `m < words − 1` of
every completed run — is silent on **25 of M03-I4's 48 runs** and **2 of
M03-I6's 4**, which is every lane-0 member of both rows plus M03-I4's lane-4
`k = 0` member. That set contains both units the packet named: `M03-I4 (length
64, lane 0, idles 1)` and `M03-I6 (length 64, lane 0)` at `k = 7`.

**P2 — the lane-0 acceptance cycle sets are met.** At length 64 / lane 0 the
eight `tvalid` cycles are **5, 7, 9, 11, 13, 15, 17, 19** at `k = 1` and
**11, 19, 27, 35, 43, 51, 59, 67** at `k = 7` — the sets pinned at
`J-dv_lead-0086` point 4 and published in `AP-xgmii_rx_64.md` §9 at
`J-dv_lead-0087`. The per-word cycle guard evaluates
`baseline_cycle(m) + (cycle_of(D m) − D m)` from the specification alone and
compares it against the design for every `m`; it passed for all eight words at
both figures, and at all of lengths 65–71 as well.

**P3 — the word-7 discriminator held.** Word 7 left at **19** (`k = 1`) and
**67** (`k = 7`). A hold **without** `closure_aligned` — the naive
implementation of the same sanctioned change — emits it at **18** and **66**,
and the per-word cycle guard would have raised there. It did not. This is the
one measurement in the round that separates rtl_lead's fix from the fix it
would have been natural to write, and it is the payoff of its second root cause
(the closure record ageing one cycle out of skew with the octet stream).

**P4 — nothing outside `test/xgmii_rx_64/test_m03_i.ml` moved.** The run's own
promotion block runs `dune promote` and then `git diff --name-only`; it lists
**exactly one file**. So **34 of the 36 M03 expect-test units** and **all 80
non-M03 units in the tree** (116 total; `grep -rc 'let%expect_test' test/`)
produced byte-identical expect output at `fafb83d`. Families A–H, M03-I1/I2/I3,
M03-structural, the co-simulation lane, the monitors, the golden references and
the probes are unmoved. This is the strongest empirical form available of
rtl_lead's gapless bit-identity claim, and it is what its "a single moved
gapless result convicts this change" test asked for.

**P5 — REQ-019's DV-observable half is green at both lanes and unmoved.** The
run prints, from its own latency tagger: lane 0 `h=8 L=16 word_delay=3`;
lane 4 `h=12 L=12 word_delay=3`. §1.1's ceiling on M03's ΔC is **4** at both
lanes. Measured ΔC **3 / 3**, one cycle of headroom at each. The elastic hold
did not move the gapless word delay.

---

### 3. What is NOT proven, said before anyone asks

**O1 — the seven-case gapless argument is corroborated, not verified.** P4
proves bit-identity over *the stimulus the committed suite drives*. It proves
nothing about stimuli it does not. rtl_lead's own case 6 (a partial lookahead
with an age-0 record) is asserted **unreachable**, and no row in
`AP-xgmii_rx_64.md` distinguishes reachable from unreachable there. I record
this as an argument I did not check rather than one I checked and granted — I
judge behaviour against spec, not case analyses against source.

**O2 — the line-rate rows L1–L5 do not exist.** rtl_lead's "what the next CI run
should show" names them as unchanged. They are **unwritten** (standing debt from
`WO-0038` §8), so the line-rate invariant at `fafb83d` is *argued* (`hold ≡ 0`
gapless, no backpressure introduced) and **not measured**. No claim in this
verdict rests on them.

**O3 — `rtl_snapshots/**` was not regenerated.** `fafb83d` stages the module and
the journal only. rtl_lead's Verilog-side prediction (one enable term on two
existing registers, no new register and no new `always` block, the same deltas
reappearing in `eth_mac_10g.v`) and **REQ-902**'s double-generation
byte-identity check are both **unverified and owed** by the next run that emits.

**O4 — M03-I4's cross-run assertions never executed.** The row's tail checks —
exactly two front-offset classes, `h = 8` and `h = 12`, 24 accumulated frames
each — and the accumulated per-octet class report run *after* all 48 cases. The
loop aborted at the 26th. Those structural facts are **unmeasured** at
`fafb83d`, and the lane-4 class data the row exists to *report* was not printed.

**O5 — everything at lane 4 past word 0's cycle.** `fail` raises, so at the
failing member I know exactly two things: the drained window carried **exactly 8
`tvalid` words** (the count guard passed), and word 0's cycle was **4** against
the spec-derived **6**. `tkeep`, `tlast`, `tuser`, the 60 delivered octets, the
five strobes and the monitor verdicts are unmeasured there. **22 of M03-I4's
runs and 1 of M03-I6's were never driven at all.**

**O6 — §6's `k = 0` invariant is 9 of 16, not 16 of 16.** §6 predicted "all 16
of M03-I4's `k = 0` members stay green". Measured: the 8 lane-0 members and the
1 lane-4 member that ran, all green; the remaining 7 lane-4 `k = 0` members were
not reached. The clause is **unrefuted and partially measured**, and I will not
report it as met.

**O7 — family I carries no qualification.** No mutation campaign has opened on
these rows. `SO-xgmii_rx_64.md` remains unopened and is not offered.

---

### 4. Two deviations from my own §6, reported rather than absorbed

**D-1 — §6's characterisation of the *design* at lane 4 is UNSCORED, and could
not have been scored.** §6 said word 0 moves "to `s + 3 + 2k` at lane 4 against
the design's `s + 3 + k`". The design's lane-4 injected behaviour was **never
measured** at `51b9920` — that run aborted at lane 0 — and at `fafb83d` the
design is a different design. The spec side of the clause is confirmed
(`s + 3 + 2k = 6` at `s = 1, k = 1`, and that is exactly the bench's expected
value); the design side named a quantity nothing ever observed. Measured at
`fafb83d` the design gives **4 = `s + 3`**, delta **2 = 2k**, not the `5` §6
guessed. A prediction about an unmeasured configuration is a guess wearing a
prediction's clothes, and I am recording it as one.

**D-2 — the measured lane-4 defect is NOT the defect rtl_lead's escalation 1
describes, and this matters for what gets dispatched.** Escalation 1 predicts
output word m split into two disjoint half aligned words (`al_keep` 0x0F then
0xF0) that one register plus a hold cannot rejoin. If half words reached the
output, `delivered_samples` — which filters on `tvalid` alone and counts short
words like any other — would have inflated the count and the **count guard would
have raised first**. It did not: **8 words, the conformant count.** What is
measured is a **cycle** defect with the tuple count intact, not a tuple-sequence
defect. Whether the split is real and absorbed internally, or the mechanism is
something else, is rtl_lead's to establish in a Root-cause section. **The
follow-on packet states the measured observable and does not adopt the
mechanism** — a bug packet that prejudges the root cause is a bug packet written
from the design.

---

### 5. RULING — the lane-4 gap is **(a) a design obligation**. Not (b), not (c).

Derived from the frozen text, clause by clause. Every citation is to text in
force at `155c9b2` or earlier.

1. **REQ-016's normative sentence has no lane qualifier**: "*every consumer
   SHALL tolerate arbitrary idle gaps within a frame without corrupting it: k
   idle cycles before an input word delay every octet that word carries by
   exactly 8k octet times and change nothing else*". Its one carve-out is
   `Xgmii_tx_64`'s source interface (REQ-206). This is not that port.
2. **REQ-016's verification column commissions lane 4 by name**: "*at every
   start lane the module has*". REQ-101 gives M03 lanes 0 and 4. Lane 4 under
   injection is **commissioned, countersigned coverage** (`J-dv_lead-0084`,
   in force from `a77017c`), not a frontier the programme wandered into.
3. **§0.5's *What survives idle injection* forecloses the split in text**: the
   ordered `(tdata, tkeep, tlast, tuser)` sequence "*is unchanged, and every
   octet keeps its byte position within its word*", and "*an output word …
   leaves **whole** — REQ-011 forbids `tkeep` = 0 and gives no encoding for half
   a word*". A half word is not a permitted output object at all.
4. **REQ-101 convicts independently**: "*SHALL produce identical output streams
   for the same frame received at either alignment*", compared as the ordered
   tuple sequence. A lane-4 stream that differs from lane 0's on the same
   stimulus class fails it whatever the cycles do.
5. **REQ-011 convicts any short mid-frame word independently**: on every
   `tvalid` word `tkeep` is contiguous from bit 0, and 0xFF on every word but the
   `tlast` one. 0x0F on a non-`tlast` word fails the second; 0xF0 fails the
   first.
6. **§6.3 closes option (c) textually.** "*Anything not listed here is
   constrained by this specification, and a test may rely on it.*" Lane-4 under
   injection is not listed. It is constrained, so it cannot be declared
   unconstrained without a spec diff — and a spec diff is option (b), not
   option (c).
7. **REQ-019 does not bar the fix and may not be invoked to.** Its
   payload-storage sentence is, by its own words, "*design guidance and …
   explicitly not a DV observable, so `traceability.md` claims no test coverage
   for it*" — I have no instrument for it and will not pretend one. Its
   DV-observable half is ΔC ≤ 4, measured **3 at both lanes** at `fafb83d`
   (P5), so even a merge that cost a gapless cycle would still clear the
   ceiling — and it should cost none, because the merge fires only where an
   aligned word is split, which never happens on a gapless stimulus.

**Why option (b) does not trigger, stated against the architect's own reserve.**
`J-architect_docs_lead-0025` held option 2 as E2 with an explicit condition:
"*if the emission rule proves unaffordable, rtl_lead returns with the cost and I
take it up as E2*". rtl_lead did not return a cost. It returned a
**recommendation to build** (its option (a)), reported that it "did not need a
third word of storage, so I have no rule-convicting finding to raise on that
head", and named REQ-019 as **met**. There is therefore nothing for an E2 to
weigh, and routing one now would ask the sponsor to drop countersigned coverage
on an unpriced claim. **Option (b) is not foreclosed for ever**, and I name the
condition that revives it precisely so it cannot be revived on assertion: a
**returned, quantified cost** — a third payload storage word, a gapless ΔC that
moves off 3, or any gapless expect block in the tree that moves. Any one of
those and I carry it to architect_docs_lead as E2 **myself, that same round**,
with the numbers.

**Why this is a new packet and not a widening of WO-0060.** The merge is more
than the elastic hold this round sanctioned, and rtl_lead was right to stop and
report rather than build it — that is charter §6's no-silent-deviation rule
working. But "the sanctioned change was smaller than the obligation" is a
**work-order** scope question, not a specification scope question, and its
answer is a packet, not an escalation.

**Dispatch**: `agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md`
(number subject to the orchestrator's allocation, PROTOCOL §3), dv_lead →
rtl_lead, VERBATIM relay class. Severity **MAJOR**, argued in the packet
against BUG-0002's CRITICAL. Its acceptance is: the lane-4 half of M03-I4's 48
runs and M03-I6's 4 green, **with every one of the 34 green M03 units and all 80
non-M03 units still byte-identical** — a moved gapless expect block converts the
round from a fix into a regression.

---

### 6. RULING — rtl_lead's escalation 2 (sub-word granularity): **nothing**. No row, and none owed.

**No commissioned row drives it, and no instrument this programme has can
reach it.**

- **The granularity is forced, not chosen.** REQ-010 declares the six XGMII
  lane-pair ports **not stream ports**: "*a lane pair carries a value on every
  cycle, so it has no valid indication, no octet mask, no end-of-frame
  indication and no abort bit to be a stream with*". REQ-016's "*a producer MAY
  deassert `tvalid` between words*" therefore has **no sub-word realisation at
  M03's input**. The injection wrapper's whole-word granularity is a consequence
  of the port, not a simplification I chose.
- **REQ-018 hands the link-partner model's contract to DV and enumerates it**:
  start characters in lanes 0 and 4 with the REQ-004 alternation, plus each
  condition named in REQ-104, REQ-105, REQ-107, REQ-108 and REQ-110. A
  partial-lane idle inside an open frame is not in that list.
- **The L-series cannot reach it either**: L1–L5 are back-to-back line-rate
  stress, gapless by construction.
- **And no clause decides the observable.** In `Frame` state every §6.2 exit —
  `/T/` (REQ-106), `/E/` (REQ-105), `/S/` (REQ-110) — *closes or aborts*, so the
  only characters that could truncate coverage without closing are `/I/` and
  `/Q/` in a **data-lane** position of an open frame. REQ-113 governs control
  characters *outside* a frame; REQ-102's third sentence governs a *preamble*
  position; §6.2's `Frame` row decides hold-versus-advance ("*a word covering one
  or more frame octets is never held*") and says nothing about where the covered
  octets go; §6.3 does not list the case. That is a **specification silence**,
  which this plan's own status vocabulary calls **RULING** — and a RULING row
  needs an architect ruling before it can be a bench, not a bench that invents
  one.

**And the harm it names is already guarded, unconditionally.** rtl_lead's
concern is a short mid-frame word ("*a short mid-frame word that REQ-011 does not
admit either*") — correct, and REQ-011 is asserted by the protocol monitor on
every stream in every bench:

```
test/monitors/protocol_monitor.ml:99
  "tkeep = 0x%02x on a word without tlast; only the tlast word may be partial"
```

Any design change that produced one **anywhere**, on stimuli that already exist,
raises there. No new row buys coverage that instrument does not already hold.

**Recorded as considered and rejected, with the reason** (charter §8 — the
rejected list is what the auditor mines). If the org ever wants the
configuration constrained, the order is: architect ruling on the observable
first, then a row, then a bench. Not a bench first.

---

### 7. RULING — rtl_lead's escalation 3 (the `closure_aligned` trap): **route to architect_docs_lead, YES — with one condition that is mine to state**

No objection, and it is worth carrying: a trap rediscovered is a defect, and
rtl_lead found this one by building against it.

**Condition**: it lands in SPEC-M03 §9 as an **implementation note explicitly
marked non-normative and not a DV observable**, in the manner REQ-019's storage
sentence already uses ("*design guidance and … explicitly not a DV observable,
so `traceability.md` claims no test coverage for it*"). The reason is
testability, which I countersign at every spec freeze: **§6.3 item 2 already
declares "the placement of the two register levels … and every internal
encoding" deliberately unconstrained.** A *normative* sentence in §9 about how a
future consumer must read the closure record would constrain exactly that, and
would commission a test I cannot write from the specification — the module's
observable is the emitted stream, not the age of an internal record.

As guidance it costs nothing and owes me no countersignature. If it lands as
normative text it revises the test-derivation basis and **I countersign
narrowly**, on that sentence alone.

---

### 8. BUG-0002: **CLOSED**. The verdict of record is in the packet's own `Fix verdict` section.

`agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`,
**Fix verdict: ACCEPT — CLOSED**, `J-dv_lead-0089`. In one sentence: the
packet's defect is *tlast on a non-final word under injection*, it is measured
absent across every lane-0 member of both rows, and the packet's own §6 says in
its own words that it "*does not claim any coverage at lane 4*" — so the lane-4
finding is outside its scope by its author's declaration and carries as its **own
item**, not as a hold on an old packet whose defect is discharged.

---

### 9. Count and row states at `fafb83d` / `310a33d`

**Discharge count: 36 of 62 — re-derived, not inherited.** Method unchanged
since `J-dv_lead-0084`: 37 ASSERT rows named in a committed `%expect_test` title
under `test/xgmii_rx_64/`, plus M03-F5 by citation (`test_m03_f.ml:833`) = **38
carrying a discharge**; minus **M03-I4** and **M03-I6**, red at this SHA = **36
of 62**. Plan totals unchanged and counted from the file, not added to: **78
rows — 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP.**

| Row | Status | Discharge | State at `fafb83d` |
|---|---|---|---|
| **M03-I4** | ASSERT | **NOT discharged** | **Red at lane 4 only.** 25 of 48 runs completed green (all 24 lane-0, plus lane-4 `k = 0` length 64); 1 red; 22 undriven. Its lane-0 half is met in full. |
| **M03-I5** | NO-ASSERT | n/a | Unchanged. Its scope held: neither `m + 3` nor a single per-octet `L` was asserted anywhere in the round. |
| **M03-I6** | ASSERT | **NOT discharged** | **Red at lane 4 only.** 2 of 4 runs green — both lane-0, **including the 1518-octet member at `k = 7`**; 1 red; 1 undriven. |
| **M03-I1/I2/I3** | ASSERT | discharged | Unchanged, green. |

**No partial discharge, deliberately.** The method is per row, and a row with a
red unit carries none. Inventing a fractional discharge to reflect that the red
has shrunk from "everything" to "lane 4" would make the count a narrative
instead of a measurement. **The number is unchanged; what changed is its
content**, and that belongs in prose, which is where it is.

**Forward figure: 38 of 62** the moment the lane-4 merge lands green. BUG-0003
is the whole of the distance.

**No attack-plan edit this round, and the reason stated loudly.** No ruling here
requires one. §5's ruling adds no row, converts none and moves no status —
M03-I4's and M03-I6's `Observable` cells already state, at both start lanes, the
exact clause lane 4 fails, so they are correct as written and the red is theirs
to hold. §6's ruling adds no row by construction. The architect's single-word
observation (§10 below) reaches no cell: M03-I4's class table is scoped "*for a
frame of more than one output word*" and every commissioned length is
multi-word. **Owed at the next round that opens the plan**: a §9 change-log row
recording §6's no-row ruling, so the rejected attack sits on the plan's own
record and not only in my journal.

---

### 10. Carried items disposed

1. **The architect's single-word / lane-4 observation** (`J-architect_docs_lead-0026`,
   downstream 2) — **verified and accepted against myself.** The
   COUNTERSIGNATURE scope note in BUG-0002 says "*a single-word frame has one
   class trivially at either lane*"; that is true at lane 0 and **false at lane
   4** whenever the single output word carries more than four octets — `N` ∈
   {9, 10, 11} give `W = 1` with bytes 0–3 at `12 + 8k` and bytes 4…r+3 at 12,
   and `N` = 12 gives the full `12 + 16k` / `12 + 8k` split in one word.
   Recorded in BUG-0002's Fix verdict under my own authorship. **The signature
   block itself is not edited** — a signature of record is corrected forward,
   never amended in place. **No AP cell inherits the error.** Closed.
2. **N-1** (REQ-016's column gates per module while survival is per
   (start lane, residue)) — **still non-blocking, and it still licenses nothing
   at M03**: M03 fails **both** of §0.5's tests at **both** lanes (the `tlast`
   word is late-decided at either start, and `h = 12` straddles at lane 4), so a
   per-module gate and a per-lane gate give the same answer here — do not assert
   the per-octet constant. Carried forward **with BUG-0003**, which is the next
   packet that opens REQ-016's reach, exactly as N-1 was offered.
3. **tb_writer's §5 finding** — three `RV-0059-VERDICT §8` citation sites beyond
   §3.6's enumeration (`test_m03_i.ml` `:41–42`, `:1336`, `:1368`). **Accepted
   as a finding against my own packet's enumeration, not against the worker's
   execution**: §3.6 claimed a closed list and the list was not closed, while
   §3.7 forbade edits beyond it, so the worker was right to report rather than
   fix. **Not repaired this round, deliberately**: a bench edit inside an open
   design round is the confound this whole sequence exists to avoid. Rides with
   the next family-I bench work order.
4. **Adjudicator RTL exposure** — ruled at §11.
5. **Unchanged standing debts**: `WO-0038` §8's mutation spot-check; L1–L5;
   family I's qualification campaign; the epoch-A no-output-word class; AP-M14's
   §6 invariant; M03-F5's discharge-by-citation qualification; the RFC 1071
   anchor; X-7, X-10, X-11. `SO-xgmii_rx_64.md` remains unopened and is not
   offered.

---

### 11. RULING — adjudicator RTL exposure, for the next campaign packet

**The independence bar is on *test derivation*, not on *adjudication*, and the
two are separated by ordering rather than by pretence.**

- Charter §8 **requires** me to verify a Root-cause section exists before
  writing ACCEPT. A Root-cause section that names a mechanism will quote RTL.
  Adjudication exposure is therefore compelled by my own charter, and a rule
  forbidding it would be a rule I break every time I do my job — PROTOCOL §10's
  honest-enforcement note exists to stop exactly that kind of fiction.
- **The safe form is mechanically checkable: the bench that judges a fix must be
  frozen at a SHA strictly earlier than the RTL it judges.** Here it is —
  `test_m03_i.ml` froze at `51b9920` and the RTL under judgment is `fafb83d`,
  two commits later. **No expectation in this round was written after any RTL
  was read**, because no expectation was written at all: this round edits no
  file under `test/`.
- **Two bars stay absolute and are not relaxed by this ruling.** (i) tb_writer's
  work orders omit RTL **and** omit the journal entries that quote it — `WO-0060`
  §7.2 is the model and it held. (ii) In a **mutation campaign**, the adjudicator
  does not read the manifest's patch bodies before the seal is frozen; there the
  seal is the instrument and exposure destroys it, which is a different failure
  mode from fix adjudication and does not inherit this licence.
- **Declared for this round**: I opened `agents/journals/claude_rtl_lead_agent.md`
  at `fafb83d` (`J-rtl_lead-0010`) **in full**. It quotes six lines of
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` verbatim (`ev12`,
  `closure_aligned`, `decided`, the three `emit_*` arms, `hold`, `al_data_d`) and
  describes the module's structure in prose. I did **not** open `libs/**`,
  `top/**`, `rtl_snapshots/**` or `docs/reports/audit/**`.

This clause goes into the next campaign packet as written.

---

### 12. tb_writer's return: **ACCEPT**

All seven changes landed; the four call sites needed no edit and the return says
so; **D1** and **D2** are in the source with derivations that take a different
route from the packet's and reach the same `iff`; §3.3's `T − f` was re-derived
rather than left alone; the §3.5 BAR held (no lane-4 class set appears anywhere
in the file); the expect blocks were committed exactly as CI produced them and
**no expectation was amended to agree** (ADR-0015 D2); §4's guard pair was
analysed and **no third guard was added**, with the analysis returned instead —
which is what §4 asked for and the harder thing to do. The one finding returned
(§5) is a finding **against my packet**, correctly scoped and correctly not
acted on. The fail-fast caveat in its §4 was right and is now the reason §3 of
this verdict is as long as it is.

