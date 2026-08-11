# Journal: claude_dv_lead_agent — volume 08

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 08
- **Continues-from**: J-dv_lead-0160
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v07.md
- **Previous-volume-sha256**: 3f118f98bb04ed9691e49e0638cfec8346df26474ec5a34f81eab5a9a5a9217e
- **Previous-volume-bytes**: 281357

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 07 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0161] 2026-08-10T22:21Z | task:none | The sign-off designed one commit before it is written — and drafting its harvest is what found that the span every recent note quotes is not the span that tiles, and that the bank I was told held eleven candidates holds four labelling regimes with three accounting defects between them

### Trigger

Orchestrator dispatch, sole agent in flight, with a **declared sibling**
(architect_docs_lead, concurrently ruling the ECS-4/ECS-5 spec-diff request and
writing the operator ADR in `docs/specs/` and `docs/adr/`). The commission is to
**draft `SO-xgmii_rx_64.md`** — the module sign-off packet — as a design, with a
later round executing it. It is the document `RV-C4` §13 item 3, `RV-SWEEP` §8
item 2 and every campaign absorption round since `J-dv_lead-0137` has been
routing obligations to, and it is the first round in this programme whose write
set is a **new** file in `agents/handoffs/`.

**HEAD verified as my first action, before reading anything**: `git rev-parse
HEAD` → `49d87af799c03ae49ff5e79f05d46f6ffc41dcc2`, exactly the stated spawn-head
(*"Seventeen classes answered from one reading…"*). **Match**; neither the
ancestor nor the descendant branch of the abort procedure ran.

**This entry opens volume 08.** `J-dv_lead-0160` declared at its own Outcome that
the `WARN-JOURNAL` fired on its commit and that v08 would open at this entry, per
ADR-0017 §5 R10. **The chain header above was computed, not transcribed**: `git
show HEAD:agents/journals/claude_dv_lead_agent.v07.md` piped to `sha256sum` →
`3f118f98bb04ed9691e49e0638cfec8346df26474ec5a34f81eab5a9a5a9217e`, and to `wc
-c` → `281357`, both agreeing with the values the dispatch carried. **v07 is
FROZEN, is not staged and is not touched.**

### Inputs

Read at `49d87af`, all read-only. **No `libs/**`, no `top/**`, no
`rtl_snapshots/**`, no `docs/reports/audit/**`, no
`test/third_party/verilog-ethernet/**`, and no line of `docs/**` was opened this
round** — the last of those is the sibling boundary honoured as a read discipline
as well as a write one, so that nothing in my draft can have been shaped by a
document the sibling is mid-way through changing.

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, both in full — mandatory
  first actions.
- `agents/handoffs/README.md` — the `SO-` template, and the packet-numbering and
  relay-class rules.
- `test/attack_plans/AP-xgmii_rx_64.md`: §0.1 in full (the re-measure-at-citation
  rule and its two minting instances, plus `DVC-1`'s commission), §7 **entire** —
  the stale-gap banner, bars 1–4, `RV-0075`'s three placements,
  `FINDING WO-0077-A1`'s record and its positive half, `FINDING RV-0078-S2-13`'s
  filed rule, **bar 1's four lift cells with their *"does NOT anchor"* lists**,
  bar 4's precondition record, bars 2 and 3 restated, the §0.1 re-measurement
  with its five commands and its consequence, the X-row table (X-1 … X-7), the
  `U-1`/`U-2` table, `U-3`'s declaration and the *"Not gaps"* note — and §9's
  change log rows for the family-M, family-J and family-K/N absorptions.
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` §14: `RV-C3ALPHA`
  §5 and §8 (`S2-7`'s closure and residue, `S2-11`, `S2-12`, the standing-set
  table), `RV-C4` §10 (what Stage 2's completion does not mean, including the
  `SO-`'s owed list), §11 (`FINDING K-1` ruled — terminal carrier, paid before
  the family-K rows), §12 (the `AP-` round's six ruled items and the lift-cell
  form), §13; **`RV-SWEEP` entire** — §2's unit argument and seventeen-class
  table, §2.4's tally, §2.5's `S-1`, §3's two candidate classes, §5's gate
  re-read, §6's eight `ECS-` findings, §7's three refusals, §8's sequencing, §9's
  verdict; and `FINDING RV-0078-S2-2`'s and `S2-3`'s original text at §14's
  earlier entries.
- `agents/handoffs/WO-0077_family-k-mutation-campaign.md`: §5 item 1
  (`FINDING K-1` in full), §6 (**`RN-6`'s ruling in full** — errata of record,
  class, durable carrier, and the in-window prohibition), §7's conduct table,
  §13, §14 (the era tally fixed before the run), §15's eight owed items.
- `agents/handoffs/WO-0072_m03-family-k-clear.md` §4 — the 62-of-62 census block,
  **what it does and does not mean, and its five riders** — and §5's commissioning
  order.
- `docs/gates/lessons-harvest-block.md` **in full** — the instantiation rules, the
  three-tier bar, §2.1's classifier, §3's block and its eleven checkboxes, §4's
  transcriber notes. **This is a `docs/` path and I read it**; it is a frozen
  template the sibling's scope does not touch, and I record the read rather than
  leaving it inferable.
- `docs/adr/ADR-0017-…` §4 and §5 (the volume header, the rotation, the
  thresholds) and `docs/adr/ADR-0018-…` §3.4–§3.6, §4.1–§4.4, §7 (the harvest's
  criteria, its two destinations, the shell's one-commit rule, sponsor
  ratification). **Same disclosure**: both are frozen ADRs, neither is in the
  sibling's write set for this round, and neither bears on the ECS-4/ECS-5
  question.
- `ORG_CHART.md` (the sponsor node), `agents/charters/orchestrator.md` §§2–4 (the
  gate ladder and the sole-escalation channel), and
  `agents/journals/claude_orchestrator_agent.md` `J-orchestrator-0133` — the
  sponsor's own words for his role, *"sets vision and direction, final sign off at
  each stage"*, which is the only first-person statement of it in the record.
- **My own chain, for the harvest span and the bank**:
  `claude_dv_lead_agent.v07.md` (`J-dv_lead-0149` … `-0160`, every harvest note
  and every banked candidate at its source), `.v06.md` (`J-dv_lead-0137` …
  `-0148`, ditto), `.v05.md` (`J-dv_lead-0125` … `-0136`, the unlabelled
  `(LH2-g)` bullets), `.v04.md` (`J-dv_lead-0121` … `-0124`, the running
  inventory figures and the span statement *"J-dv_lead-0001 … 0124, first harvest
  still firing at `SO-M03`"*), and `.v03.md`'s first harvest-note occurrences.
- **Worker journal headers only, for span endpoints**:
  `agents/journals/workers/claude_tb_writer_agent{,.v02,.v03}.md`,
  `claude_data_wrangler_agent.md`, `claude_formal_dv_agent.md`,
  `claude_rtl_module_dev_agent.md` — entry-header counts, not bodies.
- `.github/workflows/build.yml` (the step list and the two jobs), `tools/`
  directory listing, `test/` directory listing, `agents/handoffs/` listing.

### Reasoning

**1. Why a draft is the right artefact, and the argument is one I have made
against myself before.** The obvious objection is that a design round for a
document I am also going to write is ceremony. It is not, and the reason is the
same one that made me withhold Stage 2's completion for one round at `RV-C4` §9:
**a condition whose author may discharge it by declaring it discharged is not a
condition.** The `SO-` is the first document in this programme that may not
discover its own shape while being written — a dozen obligations name it as their
**terminal** carrier, and a round that opened a blank packet would meet them in
the order it happened to remember them. That is precisely the failure mode this
programme has already paid for four times (`RV-0039-VERDICT` F-2, §0.1's two
minting instances, `FINDING WO-0077-A1`). **Writing the criteria before the round
can see its own result is the same discipline every campaign seal in this
programme was written under**, and it is the only reason a `PASS` written by the
adversary is worth anything.

**2. The criteria's hardest design problem was not what to include but how many
to allow.** A short list reads well and hides the module-specific obligations
inside "coverage"; a long list becomes a checklist nobody reads back. I settled
on **fourteen**, on one rule: **a criterion exists iff a `PASS` could be written
that satisfied every other criterion and still be dishonest.** That test is what
produced `SC-5`'s *"every non-kill column named rather than folded"* (a ratio
satisfies "mutation kills reported" and destroys the void and blindness columns
that four campaigns fought to open), `SC-6`'s *per class and never per module*,
`SC-8`'s unreachable-instrument register (five landed green assertions no
mutation can reach — a coverage claim counting them has counted one observation
twice), `SC-10`'s three-dimension census rule, and `SC-14`. It also **rejected**
three candidates: a criterion asserting "the suite is comprehensive" (not
falsifiable by an observation), a criterion asserting "no known defect remains"
(false of every honest sign-off in this programme and would force the packet to
lie or to fail), and a percentage coverage figure (which is `SC-5`'s defect
wearing a number).

**3. `SC-14` is the one I expect to be argued with, so I wrote its reason into
it.** *A verdict that needs a qualifier in the same sentence is a `FAIL` whose
author has not admitted it.* This module carries a genuinely long list of things
it has not earned — an undischarged charter §3 anchor, three unmet Stage-3 gate
conditions, five unreachable instruments, one surviving mutant, one void class,
two rows unqualifiable by specification. **The honest structure is a `PASS` whose
bounds are listed inside it, or a `FAIL`** — never a `PASS` with an adverb. I do
not know today which of the two the executing round will write, and the draft is
deliberately written so that both are reachable from it.

**4. The owed ledger's ordering is the part of this round that is actually
engineering rather than drafting, and two of its edges are load-bearing.**
`FINDING K-1` before the family-K rows is ruled (`RV-C4` §11) and I merely
carried it — but working the sequence turned up a second edge nobody had stated:
**`RN-6`'s resolve-check changes `tools/dv_checks.sh`, and that script is what
produces the row census the packet quotes.** Take the census first and patch the
tool after, and the packet quotes a figure from a tool that does not exist at the
sign-off SHA. So `RN-6` pays at step 3 and every census is taken at step 6, after
it. **That edge is not in any verdict; it comes out of putting the two carriers
in one round and asking which one's output the other reads** — which is the whole
value of designing the order before executing it. A third, smaller edge:
`S2-11`'s repair decision (step 4) determines how REQ-104's row may be **worded**,
so it precedes the row rather than following it.

**5. And I applied `FINDING K-3`'s rule to my own new bar rather than waiting to
be caught by it.** `RN-6`'s check is a bar whose pass condition is a universal
over a whole tree — *every `docs/**` path cited in `agents/handoffs/**` resolves*
— and `FINDING K-3` says a bar that has never been run against its own base is not
a bar, it is a hope. **So the draft says in terms that the check is expected to
report failures on its first run**, that they are data rather than a blocker, and
that each unresolved citation gets a disposition. **A check whose first run is
green tells you nothing about the check.** I did not run it this round, and could
not have: building it is `test/`-and-`tools/`-side work, and this round's write
set is one new markdown file and this journal.

**6. THE HARVEST IS WHERE THIS ROUND EARNED ITS SEAT, and the first thing it
found is that the span every recent note of mine quotes is the wrong span.**
Twelve consecutive entries — `J-dv_lead-0149` through `-0160` — declare the span
*"open since `J-dv_lead-0148`"*. That is the span since the last **banking note**.
**The harvest's span is the span since the last HARVEST**, and no dv_lead harvest
has ever fired; the harvest block's own checklist says a first harvest's span
opens at the agent's **first entry**, and my own `J-dv_lead-0121` … `-0124`
notes say exactly that in terms: *"cumulative untiled span J-dv_lead-0001 … 0124,
first harvest still firing at `SO-M03`."* **So the span is `J-dv_lead-0001` … the
signing entry, and twelve of my own notes have been quoting an interval that does
not tile.** It is not a harmless shorthand: a span that starts at 0148 silently
drops a hundred and forty-seven entries' worth of mining, and the tiling property
— *spans tile, so a skipped harvest is a visible gap* — is the whole mechanism
ADR-0018 §3.3 relies on. **Recorded here, corrected in the draft at §4.2, and it
is a finding against my own recent notes rather than against anything the
programme did to me.**

**7. The second thing it found is that the bank is not eleven candidates in one
scheme; it is FOUR labelling regimes with three accounting defects between
them.** `J-dv_lead-0159` §9(b) caught the edge of this — *"eleven labelled
candidates `LH-cand-A` … `LH-cand-K` alongside a later note calling one 'a
tenth'; the totals disagree, a total is a set claim, and the honest move is to
quote no total"* — and routed the enumeration here. Enumerating **at the source**,
as the dispatch required and as §0.1 requires of any set claim, the picture is:

- **Regime 1** — `LH-cand-A` … `LH-cand-K`, eleven, all in v07, minted at
  `J-dv_lead-0152` … `-0156`.
- **Regime 2** — a *different* sequence, also starting at `(A)`, running
  `J-dv_lead-0137` (three, unlabelled `(i)(ii)(iii)`), `-0139` (two, unlabelled),
  `-0140` `(A)`,`(B)`, `-0141` `(C)`, `-0142` `(D)`,`(E)`, `-0143` `(F)`,
  `-0144` `(G)`,`(H)`, `-0145` `(I)`, `-0147` **`(I)` again — a different rule
  under the same label**, `-0149` `(J)` *"the tenth"*, `-0157` (unlabelled, also
  called *"a tenth"*), `-0160` (unlabelled).
- **Regime 3** — the unlabelled `(LH2-g)` bullets of v05, banked at
  `J-dv_lead-0126` … `-0135`. **None appears in any regime-2 enumeration.**
- **Regime 4** — the running inventory figures of v03–v04, *"~19 … ~20 … ~24 …
  ~25 LH2-g candidates plus the war stories"*. **A tilde is not a measurement,
  and the entries knew it: they used one.**

**Three defects, each checkable at the cited entry**: `(I)` names two different
rules; `J-dv_lead-0145` writes *"the eight candidates"* and then enumerates nine,
which `J-dv_lead-0147` carries forward as *"nine"* over the same list plus one
more; and each regime silently truncates the bank at a volume boundary — regime 2
begins at `-0137` and omits regime 3 entirely and the two banked at `-0139`
besides, while regime 1 restarts at `A`.

**8. What I did about it, and what I deliberately did not do.** The temptation
was to produce the reconciled number here — it is a few hours of walking the
chain, and a number is what a reader wants. **Refused, twice over.** First, this
round's write set is the draft and this journal; producing the reconciliation
would mean writing the harvest, and the harvest is a **precondition of the
sign-off**, which is the executing round's. Second and more important: **a total
produced by a design round would be quoted by the executing round instead of
measured**, which is `AP-M03` §0.1's exact defect at a fifth instance, committed
by the author of the rule inside the document that makes obeying it a criterion.
**So the draft specifies a METHOD and not a number**: walk from `J-dv_lead-0001`
forward, re-label the whole bank once into a single `LC-`/`LD-` sequence in entry
order, keep the old label beside each so every prior citation resolves, merge only
where two entries state the **same rule** (never where they merely share a
letter), and record both provenances on a merge because a candidate that gained a
second incident is stronger, not shorter. **The count is a product of that walk.**

**9. The three things about the harvest's form that a reader would otherwise get
wrong, so the draft states them.** (a) **The transit is the orchestrator's and
the content is mine** — dv_lead stages nothing outside its four paths and nothing
outside this repo, so the inbox PR against the generic shell is not something I
can offer to do. (b) **Exactly one shell commit per harvest**, which is what makes
the shell's history a list of harvests and the sponsor's review one diff. (c)
**Ratification means the sponsor may refuse a candidate** — the shell commit is
not a fait accompli — and a refusal is recorded in the disposition column rather
than deleted. I also carried the block's two self-diagnostics into the draft
because they bear on me and not on the span: **an empty war-stories table says
something about the bar**, and **a yield that is all `LD-` and no `LC-` says
something about the miner.**

**10. The Stage-3 statement had to say two different things and I kept them
apart.** *Refused* and *off the critical path* are independent, and collapsing
them is the likeliest misreading of the whole packet. Refused is a reading of the
gate: three of five conditions unmet, (c) reshaped by `FINDING ECS-3` from
REQ-110's abort rule to the span-closing rule and widened from one case to five
classes. Off the critical path is a **measurement**: bar 1 gates a row iff its
expected values come from X-1(ii), no benched row does, re-measured at `e51ca52`
over both producers. **And the measurement carries its expiry into the draft
rather than being inherited from it** — the moment a row takes an expected value
from the outcome model, the claim is stale. The draft says the executing round
**re-measures it and does not inherit it**, which is the only way §0.1 can be
obeyed by a document that quotes a prior round's census.

**11. The (g)/(h) dependency is recorded as pending, and writing it that way cost
me the most drafting time of anything in §6.** The pull is to write *"if the
architect rules as recommended, C8 and C9 land in classes (g) and (h)"* — which
would be a prediction of a concurrent sibling's ruling, inside a document that
sibling cannot see and cannot correct. **Refused.** The draft records that the
request is routed, that the ruling is not yet made, that REQ-901's class list is
`requirements.md`'s and its amendment carries the countersignature discipline,
and — the load-bearing clause — **that no criterion at §1 is contingent on the
ruling.** That last is what makes the two documents safe to be in flight at once:
if my packet's pass conditions depended on the sibling's ruling, the sibling
would be adjudicating my sign-off without knowing it.

**12. Two things I nearly got wrong and caught by checking rather than
recalling.** (a) I drafted `FINDING J-1`'s second half into the owed ledger from
memory of `RV-C4` §10's list — and then read `AP-M03` §4.J at the source, where it
is **PAID at `J-dv_lead-0148`, CLOSED in both halves**, at the carrier it named,
before the `SO-` rather than at it. It is now listed only so a reader does not go
looking for it. **The ledger of a sign-off is a set claim like any other, and I
was one paragraph from quoting a debt that had been discharged.** (b) I drafted
the sponsor's role from `ORG_CHART.md`'s node text and then went looking for a
first-person statement; the only one in the record is in the orchestrator's
volume-01 journal, quoting the sponsor's own rewrite — *"sets vision and
direction, final sign off at each stage"* — and it is materially different in
emphasis from the chart. **The draft quotes both and cites where each comes
from.**

**13. What I refused to put in the draft, stated rather than omitted.** No
verdict and no criterion adjudicated. **No CD edit — the ninth consecutive
refusal**, on `CD` §10.7 item 3's own ground; the temptation this round is
structural rather than local (a `SO-` draft is exactly where a reader would expect
the co-sim design document to be brought up to date) and it is refused for the
reason the previous eight were. **No `AP-` edit**, so `FINDING ECS-1`'s
three-character note repair still rides the next commit that opens the plan, and
the draft carries `ECS-1`'s bound instead — *a lift of the stale bullet without
the repair is a finding whose class is NOT MINOR*. **No `WO-0078` edit**: no
`State` field, no Return-log entry. **No `docs/**` byte.** **No carrier paid** —
`K-1`, `RN-6`, `S2-11`'s repair and `U-1`/`U-2`'s pricing are designed at §3 and
paid at §7's steps, because a design round that pays a carrier has widened its own
write set mid-round, which is the thing I convict others for (`RV-C4` §12).
**Nothing was run.**

### Actions

- **Created `agents/handoffs/SO-xgmii_rx_64.md`** — the draft, ten sections:
  §0 what a draft may not do, with the three-dimension census rule (SHA, domain,
  polarity) that binds the packet's own text; **§1 the fourteen sign-off criteria
  `SC-1` … `SC-14`**, each in block-quoted normative form; §2 the evidence map —
  the bench era's census with its **five riders**, the ten-campaign era in **five
  columns** with every non-kill named individually, the anchor's **five classes**
  at run and job ids in absolute/agreement form, the **seventeen-class** error
  table with `ECS-1`'s correction and `ECS-2`'s reachable window, the bar summary,
  the **`U-1` … `U-5`** register, and open defects; **§3 a twelve-item owed ledger**
  with a payment plan per item and `FINDING K-1` positioned before the family-K
  rows; **§4 the first lessons harvest** — form, two destinations, id scheme, the
  span corrected to `J-dv_lead-0001` …, the worker spans, **the bank enumerated at
  its sources across four regimes with three accounting defects named**, and a
  re-labelling **method** rather than a total; §5 the prohibition register in
  seven parts; §6 the Stage-3 statement — refused on three unmet conditions, off
  the critical path by measurement, with the expiry and the (g)/(h) dependency
  recorded as **pending**; §7 the twelve-step execution order, the gate ladder and
  the sponsor's gate; §8 verdict **UNSET**; §9 what the draft does not do; §10 the
  change log.
- **Nothing else was staged.** No `SO-` verdict. **No CD edit — the ninth
  consecutive refusal.** No `AP-` edit. No `WO-0078` edit, no `State` change. **No
  `docs/**` path written.** **Nothing was run**: no `dune`, no `iverilog`, no
  `vvp`, no CI trigger, no `tools/` script executed.

### Evidence

**No command in this section builds, simulates or triggers CI.** Every citation
reproduces from a checkout at `49d87af` by a static read.

- **Head**: `git rev-parse HEAD` → `49d87af799c03ae49ff5e79f05d46f6ffc41dcc2`;
  `git log --oneline -3` shows `c1f98ff` and `e7aeff7` beneath it. **Match to the
  stated spawn-head; no mismatch procedure ran.** `git status --porcelain` empty
  at entry; at exit it carries this round's one new file plus this journal.
- **Volume-chain header, computed rather than transcribed**:
  `git show HEAD:agents/journals/claude_dv_lead_agent.v07.md | sha256sum` →
  `3f118f98bb04ed9691e49e0638cfec8346df26474ec5a34f81eab5a9a5a9217e`; the same
  blob piped to `wc -c` → `281357`. **Both agree with the dispatch's values**, so
  the mismatch branch did not fire. v07's on-disk size is the same 281 357 bytes,
  confirming it is unmodified in the working tree.
- **The harvest span, at its source**: `grep -n "harvest" ` over
  `claude_dv_lead_agent.v04.md` returns, at four entries, *"cumulative untiled
  span **J-dv_lead-0001 … 0121 / 0122 / 0123 / 0124**, first harvest still firing
  at `SO-M03`"*. Against it, `grep -n "J-dv_lead-0148" claude_dv_lead_agent.v07.md`
  returns the *"open since `J-dv_lead-0148`"* wording at **twelve** consecutive
  entries. **The two intervals are stated in my own chain and disagree**; the
  harvest block's checklist (*"First harvest: the span opens at the agent's first
  entry"*) settles it in favour of the first.
- **The bank, enumerated at its sources.** `grep -rn "LH-cand-" agents/journals/`
  → hits only in `claude_dv_lead_agent.v07.md`, at `J-dv_lead-0152` (A, B),
  `-0153` (C), `-0154` (D, E), `-0155` (F, G, H), `-0156` (I, J, K), plus three
  later back-references. The parenthesised regime is read at
  `claude_dv_lead_agent.v06.md`'s harvest notes for `J-dv_lead-0137`, `-0139`,
  `-0140`, `-0141`, `-0142`, `-0143`, `-0144`, `-0145`, `-0147` and at v07's
  `-0149`, `-0157`, `-0160`. The v05 regime is read at that volume's ten
  *"BANKED, not harvested"* notes.
- **The duplicate label, at both sites**: `claude_dv_lead_agent.v06.md`'s
  `J-dv_lead-0145` note banks **`(I)`** — *an assertion that names its expected
  value without reporting the observed one…* — and `J-dv_lead-0147`'s note banks
  **`(I)`** again — *a universal asserted over one stimulus producer…* — as a new
  candidate, over an enumeration that repeats the earlier list unchanged.
- **The internal count disagreement**: `J-dv_lead-0145`'s note reads *"the **eight**
  candidates banked against it … the three at `J-dv_lead-0137`, (C) at
  `J-dv_lead-0141`, (D) and (E) at `J-dv_lead-0142`, (F) at `J-dv_lead-0143`, (G)
  and (H) at `J-dv_lead-0144`"* — **the list enumerates nine.**
- **`FINDING J-1` is CLOSED**, contrary to my own first draft of the ledger:
  `AP-xgmii_rx_64.md` §4.J's `M03-J1` cell, *"**PAID 2026-08-11, AT THE FIRST
  `AP-` ROUND SCHEDULED AFTER IT WAS RAISED** (`J-dv_lead-0148`) … **`FINDING J-1`
  is CLOSED in both halves**"*, and §9's change-log row for the family-K/N
  absorption, item (8).
- **Worker span endpoints**, by entry-header count:
  `claude_tb_writer_agent.md` 16, `.v02.md` 18, `.v03.md` 6 — last header
  `J-tb_writer-0040`; `claude_data_wrangler_agent.md` 8 — last header
  `J-data_wrangler-0008`; `claude_formal_dv_agent.md` and
  `claude_rtl_module_dev_agent.md` **0 entries each**.
- **Figures quoted into the draft, each marked `RE-MEASURE` there and each carrying
  its measuring entry here, none re-derived this round**: 62 of 62 with inventory
  78 / 62 / 7 / 4 / 4 / 1 and suite 59 / 139 (`WO-0072` §4, `J-dv_lead-0131`; CI
  `build` run `31032021108`); the era tally 63 / 61 / 1 / 0 / 1 with 61+1+0+1 = 63
  (`WO-0077-VERDICT` §14, `J-dv_lead-0147`); the five anchored classes' run and job
  ids (`AP-M03` §7's lift cells, `J-dv_lead-0159`); the seventeen-class tally
  5 / 12 / 9 with one anchored (`RV-SWEEP` §2.4, `J-dv_lead-0160`); the reachable
  window `n ≤ 132` from `ceil((n−4)/8) ≤ 16` (`FINDING ECS-2`). **I ran no census
  and claim none.**
- **The sponsor's role, at its only first-person source**:
  `claude_orchestrator_agent.md` `J-orchestrator-0133`, *"new intro (sets vision
  and direction, final sign off at each stage)"*; the third-person form is
  `ORG_CHART.md`'s sponsor node, *"final authority: phase gates, scope, toolchain
  & licensing, org changes"*.
- **Independence**: this round's derivation chain contains no RTL path. `git
  status --porcelain` at exit lists exactly `agents/handoffs/SO-xgmii_rx_64.md`
  and `agents/journals/claude_dv_lead_agent.v08.md`.

### Outcome

**DoD met, against the dispatch's three deliverables.**

- [x] **`agents/handoffs/SO-xgmii_rx_64.md` — the draft**, ten sections, with the
      fourteen criteria, the evidence map over all five evidence classes the
      dispatch named, the twelve-item owed ledger with per-item plans, the harvest
      design with the bank enumerated at its sources, the prohibition register, the
      Stage-3 statement with its (g)/(h) dependency recorded as pending, and the
      execution order with the sponsor's gate.
- [x] **Volume 08 opened** with a computed chain header — `Continues-from:
      J-dv_lead-0160`, `Previous-volume-sha256` and `-bytes` both verified against
      the predecessor's blob at this commit — and this entry inside it.
- [x] **Prohibitions honoured**: no verdict; no bar lifted; no sentence of the
      form *"the co-simulation anchors this module"*; **no `docs/**` byte**, so the
      declared sibling's write set and mine are disjoint by construction and the
      disjointness is provable from this round's two-file diff; no CD edit; no
      `AP-` edit; no `WO-0078` edit; **nothing run**; and no total quoted for the
      harvest bank.

**Handoff**: `agents/handoffs/SO-xgmii_rx_64.md`, to the orchestrator for commit.
**Nothing is dispatched by me and nothing is committed by me.** The next round is
the `SO-`'s execution, whose order is §7 of the draft.

**Lessons harvest (ADR-0018, PROTOCOL §7)**: **not due at a draft round** — the
cadence is every module **sign-off** and every phase gate, and a design for a
sign-off is neither; the packet this round produces carries no verdict, so no
sign-off exists to carry a harvest. **The span stays open and is declared rather
than skipped — and it is CORRECTED here rather than repeated**: it is
`J-dv_lead-0001` … the signing entry of the executing round, not *"open since
`J-dv_lead-0148`"*, which twelve of my own recent notes have been quoting and
which does not tile. **This round banks no new candidate**; what it produces is
the **enumeration and the reconciliation method** the harvest was owed
(`J-dv_lead-0159` §9(b)), recorded in the draft at §4.3, and **no total is quoted
here or there.**

### Open-questions

1. **The harvest's reconciliation will change how prior citations resolve, and I
   have bounded that rather than solved it.** Re-labelling the bank into one
   `LC-`/`LD-` sequence is the only way to get a measured total, but every
   existing citation of `(C)`, `(I)`, `LH-cand-K` and the rest lives in committed
   journal text that is append-only and cannot be updated. **The draft's method
   keeps the old label beside each new id for exactly that reason**; if the
   executing round finds a case where two regimes' labels collide in a way the
   side-by-side form cannot disambiguate, that is a finding and I would rather it
   be anticipated here than discovered mid-harvest.
2. **Criterion 3's unexercised plural property is routed to the auditor and the
   routing has not been answered.** `J-dv_lead-0159` asked for the auditor's ruling
   on whether an unexercised aggregate-continuation path is acceptable in a
   sign-off, and no ruling has landed. **The draft records the question rather than
   answering it**, because the packet that benefits from the answer may not supply
   it — but if no ruling exists when the executing round runs, it will have to
   write something, and *"recorded, unresolved, routed"* is the only honest thing I
   can see it writing.
3. **`FINDING RV-0078-S2-3`'s §7 repair has exactly one carrier and that carrier is
   `SCOPED, NOT AUTHORISED`.** If co-sim Phase 3 is deferred past this packet, the
   defective exhaustiveness claim outlives `WO-0078`'s active life with no owner in
   flight. **The draft makes the executing round check and record that**; it does
   not manufacture a round for it, on `J-orchestrator-0225`'s standing ruling
   against exactly that.
4. **The `U-1`/`U-2` pricing decision is genuinely open and I have not pre-empted
   it.** The draft requires the executing round to answer in one of two forms —
   commission with a cost, or refuse **with an expiry** — and deliberately does not
   say which. `LH-cand-K`'s rule is the reason the expiry is mandatory in the
   refusal branch: this would be the second refusal of the same repair, and a
   second unconditioned *"not yet"* is how a live judgement becomes a settled *"no"*
   nobody decided.
5. **Date drift**: this entry uses the machine clock (2026-08-10T22:21Z), which
   agrees with the spawn-head commit's own date (2026-08-10T22:13Z);
   `FINDING CD-P2-2` records the underlying inconsistency and nothing here rests on
   a calendar literal.

### Files-in-this-commit

- agents/handoffs/SO-xgmii_rx_64.md

## [J-dv_lead-0162] 2026-08-10T22:52Z | task:none | Countersigned at the line the architect nominated — the lookahead held under three checks, not one; and the same delay chain that held it shows the reference DOES abort at a lane-4 mid-frame start, so the ruling's own reason for declining a class is false for half the family it declines it for

### Trigger

Orchestrator spawn: the **countersignature round** on the ECS-4/ECS-5 spec-diff
request, ruled at `3526e79` (`J-architect_docs_lead-0032`) — both classes IN,
both AMENDED. Per the 2026-08-03 precedent the diff is **NOT IN FORCE until my
countersignature is transcribed**, so this round decides whether REQ-901's class
list grows. Sole agent on my files; a declared disjoint orchestrator commit
(board + its own journal) may land mid-round.

**Abort-first head check, before anything else.** `git rev-parse HEAD` →
`3526e792d5bfcc1265e9764e96936f861d397f78`, byte-equal to the spawn-head
`3526e79`. No divergence, no rollback, no merge-base call needed. Proceeded.

**The attack point was named for me, which is the only reason this round could be
short.** The ruling's Open-questions say: *"the derivation at Evidence 3 is the
thing to attack: if the terminate path's residue arithmetic is read differently,
my alignment falls and (g)'s bound falls with it."* I attacked exactly there.

### Inputs

- `agents/charters/dv_lead.md` (whole) and `agents/PROTOCOL.md` (whole) — §4.1,
  §4.2, §6 and §10 load-bearing; §6 is what decides the deliverable's *location*
  (see Reasoning).
- `agents/journals/claude_architect_docs_lead_agent.v02.md`
  `J-architect_docs_lead-0032` in full (lines 2988-3470) — the ruling, its three
  amendments, its Evidence 2-6, its Outcome and its Open-questions.
- `git diff 49d87af..3526e79 -- docs/specs/requirements.md` — all four sites read
  as added text: REQ-105's row, REQ-110's row, REQ-901's row, and §13's new row
  at `:1004`. Plus `docs/specs/requirements.md` `:986-994` at HEAD — the seven
  2026-08-03 rows, of which `:992` (the (e)/(f) diff) and **`:993` (the
  countersignature transcription)** are the precedent this round is written on.
- **`test/third_party/verilog-ethernet/axis_xgmii_rx_64.v` at pin `77320a9`, read
  directly at `:100-171`, `:193-201`, `:203-307` and `:311-445`** — the whole
  combinational block and the whole clocked block, not the cited lines alone.
  This is the MIT reference, my Phase-1 differential oracle (charter §9), not our
  RTL: **no independence rule is touched by reading it**, and it is the same
  artefact `RV-SWEEP` §3 read to file `ECS-4`/`ECS-5`.
- `agents/handoffs/WO-0046_cosim-phase-1.md` `:969-1050` — `J-dv_lead-0057`'s
  COUNTERSIGNATURE block, read **for its form**, which is the thing my spawn's
  instruction and the actual precedent disagree about.
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — my own
  `RV-SWEEP` at §14: `##### 2.3` (the seventeen-class table), `§3.1`, `§3.2`,
  `§3.4`, `§3.5`, `§4.3`'s per-case construction table, `§5` (the gate re-read in
  full), `§6`'s findings block for the naming convention, `§9`'s verdict.
- `agents/handoffs/SO-xgmii_rx_64.md` `:990-1030` — §8's UNSET verdict, §9's
  five prohibitions (item 2 records the (g)/(h) dependency as **pending**), and
  the §10 log row.
- `test/cosim/stimulus_gen.ml:185-215` — read to settle whether `FINDING CSG-2`
  is live or theoretical.
- `agents/journals/claude_dv_lead_agent.v08.md` header and `J-dv_lead-0161`'s
  tail, for the entry id and the open-questions I inherit.

### Reasoning

#### 1. Where the deliverable goes — my spawn and the precedent disagree, and the precedent wins

My spawn says *"Your files: `docs/specs/requirements.md` ONLY for the
countersignature transcription per the 2026-08-03 precedent's form."* **The
2026-08-03 precedent's form is the opposite of that**, and it says so in its own
text. `J-dv_lead-0057`'s block opens: *"`docs/specs/**` is outside my write
scope, so this is the signature of record and the orchestrator transcribes it."*
requirements.md `:993` — the transcription row itself — carries journal-ref
**`J-orchestrator-0126`**, not a dv id, and states that *"the signature's
authority rests on its text and on `J-dv_lead-0057`, not on the carrying
commit."*

So the precedent is: **the signature lives in the handoff packet and my journal;
the §13 row is clerical and lands under `Agent: orchestrator`.** Writing
`docs/specs/` myself would have failed **R7** outright (PROTOCOL §6 gives me
`test/`, `tools/`, `docs/reports/latency/`, `agents/handoffs/`) and, worse, would
have been a *misreading of the very precedent it invoked*. My spawn's own
alternative — *"the WO-0078 packet §14 ONLY if your conventions put the
countersignature record there"* — is the lawful branch, and it is where every
countersignature this programme has produced already lives (`WO-0046:969`,
`WO-0057:985`, `WO-0059:1876`, `BUG-0002:660`). **Taken, deliberately, and stated
in the block's first paragraph so the orchestrator knows what it is transcribing.**

#### 2. The attack point, and why one check was not enough

The ruling rests the whole of Amendment 1 on one arithmetic check: `:255` keeps
`4 + term_lane` octets of the emitted word, which is the correct FCS-strip
residue **only** under a one-word lookahead. I re-derived the alignment from the
clocked block first (`:357`/`:341` → `xgmii_rxd_d0 = W_{c−1}`; `:422` →
`xgmii_rxd_d1 = W_{c−2}`; `:234` emits `xgmii_rxd_d1`; `:362`/`:346` →
`framing_error_reg = fe(W_{c−1})`; `:412` → `framing_error_d0_reg = fe(W_{c−2})`),
then tested it.

**Check 1 confirms and, better, the competing reading is nonsense rather than
merely unattractive**: if `term_lane_reg` described the emitted word, `:255`
would keep `4 + tl` octets of a word holding only `tl` frame octets — four past
the terminate character at every lane, and four octets of a word holding none at
`tl = 0`. **Check 2** — `:280`'s complementary `tl − 4`, reached through
`term_lane_d0_reg`, the *delayed* copy — is consistent only if the undelayed one
leads by a word. **Check 3, which the ruling does not cite and which I went
looking for precisely because a single check is a single point of failure**: the
CRC residue selection. `crc_next` is CRC over `xgmii_rxd_d0`, and at the
terminate cycle `:257-261` pick `crc_valid[tl−1]` for `tl = 1…4` (last octet in
the word just absorbed) but **`crc_valid_save[7]`** at `tl = 0` (last octet in
the *preceding* word); `:287-289` then pick `crc_valid_save[tl−1]` for
`tl = 5,6,7`. Three registers, three delays, one alignment.

**Why this matters and is not ceremony.** A countersignature is the instrument by
which a verdict rule moves from *defect* to *excluded* inside my own comparison.
If the alignment were wrong, (g) would exclude the wrong set and either convict
our design for a reference difference or hide a real one. **One check is a
prediction; three independent ones are a measurement.** I record the third
because the next round to doubt this should not have to re-find it.

**One slip found and deliberately not made a finding.** The ruling's prose calls
`4 + tl` an *index*; it is a *count* (last index `3 + tl`). Nothing in the
derivation turns on it. Recording a wording slip as a numbered finding would
debase the register I use for things that change verdicts.

#### 3. Where I nearly filed a contest on an off-by-one of my own

Tracing Amendment 2's preamble path for a **lane-4** start, I first read `:329`
(`xgmii_start_d0 <= xgmii_start_swap`) as sampling the value `:386` assigns in
the same cycle. That puts the admitting `STATE_IDLE` cycle one earlier, leaves
`fe(R_0)` — the realigned start word's framing error from `:346`, which carries
the `/S/` bit in `swap_rxc` and is therefore unconditionally true — sitting in
`framing_error_d0_reg` at the *first payload* cycle, and produces a spurious
abort on every lane-4-started frame. **That would have been a contest filed
against a correct ruling**, and the only thing that stopped it was noticing that
the reference would then be unable to receive any swapped frame at all, which
contradicts a lane the programme has already run green.

Correcting the sampling restores the ruling exactly, and it also supplies the
reason the ruling asserts rather than derives: the reference **must** discard a
start word's framing error, because at a lane-4 start `:346` sets it
unconditionally. **I journal my own error because the discipline that caught it —
"if my reading implies a landed green lane cannot work, my reading is wrong" — is
worth more than the appearance of a clean derivation.**

#### 4. What the same delay chain then showed, which the ruling got wrong

Having the chain traced, I ran it on the case Amendment 3 declines to declare a
class for: a start character inside an open frame that has already delivered an
octet. **The ruling says the reference "does not abort at all" and merges the two
frames.** That is right at a **lane-0** mid-frame start — `:375` sets
`lanes_swapped <= 0`, so `:346` is never reached, the error is never recomputed,
and `xgmii_start_d1` rises while `STATE_PAYLOAD` is ignoring it, so the pulse is
lost and the frames merge.

**It is wrong at a lane-4 mid-frame start.** `:390`'s exclusion holds for one
cycle; the next cycle the swapped branch recomputes the framing error from
`{xgmii_rxc[3:0], swap_rxc}` and `swap_rxc` **is** the `/S/` lane. The reference
aborts, emitting the word carrying the masked start character with `tkeep`
all-ones — and **the second frame is received**, because the abort drops the
state into `STATE_IDLE` exactly one cycle before `xgmii_start_d1` rises. **The
abort the ruling says does not happen is what saves the second frame from being
eaten.**

**Why this is MATERIAL and not a footnote.** The ruling's stated reason for
declining a class is that the divergence is *"in the ordered sequence of output
frames, which no exclusion stated on one frame's extent covers"* and that a class
*"buys no anchoring"*. At a lane-4 mid-frame start the sequence **agrees** and the
divergence is a **four-octet extent** divergence — the exact shape (g) is stated
on. A class widened by four words would cover `H-2` and keep `tuser`[0] **and the
decision** compared: the same two anchors Amendment 1 was written to preserve in
family E. **The reason fails where the disposition still holds.**

**And I chose not to let that hold the diff out of force.** Three grounds. The bar
is what operates and the bar is wide enough — *"a start character inside an open
frame that has already delivered an octet"* catches `H-2` as squarely as `H-1`.
The stimulus is unreachable at this tree (`FI-4`, `FI-6`), so no run can hit it
and no anchor is lost today. And refusing a ruling over a recital that changes no
verdict is the over-wide refusal `J-dv_lead-0057` exists against — I would be
doing to the architect precisely what the architect correctly refused to let me
do to family E. **Rejected alternative: contest Amendment 3.** It would have cost
a round, unblocked nothing, and the carrier for the repair (the round that lifts
`FI-4`/`FI-6`) is already named in the ruling itself.

**Yield I did not go looking for**: this settles `RV-SWEEP` §3.4, which I had
recorded as *"outcome not settleable by a static read."* It is settleable — `H-3`
is **lost** at a lane-0 mid-frame start and **received** at a lane-4 one. My
"not settleable" was too pessimistic: it needed the delay chain traced, not the
state graph inspected. **Declaring a question unanswerable is a claim like any
other, and it can be wrong in the direction that costs coverage.**

#### 5. The finding that decided how much of the ruling I could take on trust

(g)'s carve-out is stated on *"lane 0 of **its word**"*. Two readings exist and
they select different members. Within (g)'s own paragraph, "its word" refers back
to *"the word carrying the aborting character"* in the sentence above — the
**reference's** word, i.e. the realigned/output word — and on that reading the
exclusion covers exactly the diverging set. But **this document's lane convention
is XGMII lanes** (REQ-110's *"a start character in lane 4"*; REQ-105's *"each of
the eight lanes of a mid-frame word"*), and REQ-105's amended verification column
projects the bound onto that sweep as *"the **lane-0** member."*

Derived per start lane: in a lane-4-started frame the reference's words are
`R_j = {W_{j+1}[0-3], W_j[4-7]}`, so the **agreeing** member is the `/E/` at
**XGMII lane 4** and the **XGMII lane 0** member **diverges** by four octets and
one output word. **The verification column is therefore false for half of
`M03-E1`**, and it is the sentence a bench writer reads.

**I checked whether it was live rather than assuming.** `stimulus_gen.ml:185-202`
records that case C2's frame 1 *"start lane (lane 4 …) falls out of that
arithmetic rather than being chosen."* Any C8 schedule built on `Arrival.create`
places later frames at whatever lane the gap arithmetic yields. **`M03-E1` is
C8's class. It is live.** Left alone, REQ-901's *"any divergence outside the
declared classes is a defect"* would convict our design for the reference's
word-boundary truncation — the exact failure mode the ruling exists to prevent,
reappearing in the ruling's own projection.

**Disposition chosen: countersign, bind the reading, file the repair as
editorial.** The class text in REQ-901 is correct on its own reading, so the
normative object I am asked to countersign is sound; the defect is in a
*verification column*, which §13's own test puts in the concurrence class the
2026-08-03 REQ-107/REQ-108 pointer row closed under — repairable without a fresh
countersignature. **Rejected alternative: contest (g).** It would hold C8 hostage
to a wording that (g)'s own paragraph already resolves in the safe direction, and
my block binds the reading my instrument uses in the meantime.

#### 6. One correction of record, made because the next dispatch will read it

The ruling's Outcome says *"Stage 3 may therefore be authorised for C8."* Against
the gate as `RV-SWEEP` §5 states it, that is one condition too strong: **(b) —
the CD's co-sim Phase-3 domain instance — is UNMET and is a stage condition, not
a per-case one.** What the ruling discharges for C8 is the **class** blocker,
which `RV-SWEEP` §5 said in terms was *"not a sixth gate condition"*. C8 no
longer selects branch γ; Stage 3 is still unauthorised on (b), which is **mine**.
Recorded in the block rather than as a finding: a finding needs a repairable
artefact and a carrier, and the claim lives in an append-only journal. **What
matters is that my instrument's gate reading is the correct one, and it is.**

### Actions

- Head check; read charter, protocol, the ruling in full, the four diff sites,
  and the 2026-08-03 precedent rows.
- **Re-derived the one-word-lookahead alignment from the reference's clocked
  block** and tested it against `:255`, `:280` and the CRC lane selection at
  `:257-261`/`:287-289` — three independent checks.
- Traced `STATE_IDLE` admission cycle-exactly for a lane-4 start (`:329`'s
  old-value sampling, `:346`'s `swap_rxc`), confirming Amendment 2's
  consumed-at-admission mechanism after correcting my own off-by-one.
- Traced the mid-frame start-character cases at both start lanes; found the
  lane-4 abort (`FINDING CSG-1`) and settled `RV-SWEEP` §3.4.
- Derived the realigned-word geometry for `M03-E1` at both start lanes; found the
  verification-column projection defect (`FINDING CSG-2`) and confirmed it live
  against `test/cosim/stimulus_gen.ml:185-202`.
- **Appended one COUNTERSIGNATURE block** to §14 of
  `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md`: the signature,
  the three-check derivation, per-amendment dispositions, the bound reading, two
  findings, the correction of record, the restated `RV-SWEEP` §2.3 dispositions,
  and the verdict.
- **Wrote no `docs/` path.** Edited no `SO-`, no `AP-`, no CD, no `State` field.
- Ran no build and no simulation. ADR-0005: the toolchain is unavailable and CI
  is the only authority; this round is a source reading and a signature, and
  commissions nothing.

### Evidence

Every command below runs from a checkout at this commit.

1. **Head check.** `git rev-parse HEAD` →
   `3526e792d5bfcc1265e9764e96936f861d397f78`; spawn-head `3526e79`. Match.

2. **The alignment, from the registers.**
   `sed -n '311,445p' test/third_party/verilog-ethernet/axis_xgmii_rx_64.v`
   shows `:357` `xgmii_rxd_d0 <= xgmii_rxd_masked`, `:362`
   `framing_error_reg <= xgmii_rxc != 0`, `:412`
   `framing_error_d0_reg <= framing_error_reg`, `:422`
   `xgmii_rxd_d1 <= xgmii_rxd_d0`; with `:234`
   `m_axis_tdata_next = xgmii_rxd_d1`. Emitted word at cycle `c` is `W_{c−2}`;
   `framing_error_reg` is `fe(W_{c−1})`; `:244` reads *fe(next) OR fe(this)*.

3. **Check 1 — `:255`.** `{KEEP_WIDTH{1'b1}} >> (CTRL_WIDTH-4-term_lane_reg)`
   with `CTRL_WIDTH = 8` has `4 + tl` ones. For a terminate at lane `tl ≤ 4` of
   `W_m`, the surviving payload in `W_{m−1}` after a four-octet FCS strip is
   `8 − (4 − tl) = 4 + tl`. Exact. Under the same-word reading it would keep four
   octets past the terminate character at every lane and four octets of an empty
   word at `tl = 0` — **arithmetically impossible, not merely unlikely.**

4. **Check 2 — `:280`.** `>> (CTRL_WIDTH+4-term_lane_d0_reg)` has `tl − 4` ones,
   taken with the **delayed** lane register in `STATE_LAST`, which is the
   complementary `tl ≥ 5` case and consistent only under the same alignment.

5. **Check 3 — the CRC lane selection, not cited in the ruling.** `:187`
   `.data_in(xgmii_rxd_d0)`; `:257-261` select `crc_valid[tl−1]` for `tl = 1…4`
   and **`crc_valid_save[7]`** at `tl = 0`; `:287-289` select
   `crc_valid_save[tl−1]` for `tl = 5,6,7`. Coherent only under the one-word
   lookahead.

6. **Amendment 3's control-lane exclusions, at the source.** `:382`
   `framing_error_reg <= xgmii_rxc[7:1] != 0;` (lane-0 start) and `:390`
   `framing_error_reg <= xgmii_rxc[7:5] != 0;` (lane-4 start) — both confirmed,
   both landing after `:362`'s unconditional `xgmii_rxc != 0` and overriding it.

7. **`FINDING CSG-1`, the line that falsifies the recital.** `:346`
   `framing_error_reg <= {xgmii_rxc[3:0], swap_rxc} != 0;` in the
   `if (lanes_swapped)` branch, with `:325` `swap_rxc <= xgmii_rxc[7:4]`. At a
   lane-4 start `swap_rxc = 4'b0001` — the `/S/` control bit — so the cycle after
   `:390`'s exclusion the framing error is **true**. In `STATE_IDLE` that is
   consumed (Amendment 2); in `STATE_PAYLOAD` it **aborts**.

8. **`FINDING CSG-2` is live, not theoretical.**
   `sed -n '185,202p' test/cosim/stimulus_gen.ml` →
   *"frame 1's own start lane (lane 4, a consequence of the 84-octet spacing not
   dividing 8, CD §10.2's own recorded consequence) falls out of that arithmetic
   rather than being chosen."* `M03-E1` is C8's class (`RV-SWEEP` §4.3's table).

9. **Table integrity in what I wrote**, on the check the ruling's own Evidence 6
   shows catching a real defect. Pipe counts via
   `awk 'NR>9815 && /^\|/ {print NR": "gsub(/\|/,"|")}'
   agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` → `9919-9922`
   all **5**; `10095-10101` all **4**; `10125-10134` all **3**. Three tables,
   each internally uniform; no literal pipe splits a cell.

10. **`git status --porcelain` at the end of this round** reports exactly
    ` M agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` and
    ` M agents/journals/claude_dv_lead_agent.v08.md`. **Nothing in `docs/`.** A
    declared disjoint orchestrator commit (`tasks/BOARD.md` + its journal) may
    land beside this; those are the orchestrator's and are excluded below.

11. **No build, no simulation, no CI figure quoted.** ADR-0005 governs.

### Outcome

**DoD met. COUNTERSIGNED — all three amendments. The (g)/(h) diff is IN FORCE on
transcription.**

- **AMENDMENT 1 — COUNTERSIGNED.** The one-word-lookahead alignment holds under
  three independent checks; the lane-0 carve-out is right and preserves three
  anchors my own `ECS-4` filing would have destroyed. **Bound reading**: the
  carve-out is on **lane 0 of the output word** — XGMII lane 0 at a lane-0 start,
  XGMII lane **4** at a lane-4 start. Two anchorable members of `M03-E1`'s
  sixteen; the ruling's count is right and its identification needs the gloss.
- **AMENDMENT 2 — COUNTERSIGNED.** `:236` is airtight; the start word's framing
  error is consumed on the admitting `STATE_IDLE` cycle, traced cycle-exactly.
- **AMENDMENT 3 — DISPOSITION COUNTERSIGNED, RECITAL FALSIFIED.** The bar is
  right and wide enough; the "reference does not abort at all" ground holds for
  `H-1`/`H-5` and **not** for `H-2`. `FINDING CSG-1`.
- **`FINDING CSG-1`** (MATERIAL, mine): the reference **aborts** at a lane-4
  mid-frame start via `:346`'s `swap_rxc`, and the second frame is received — so
  the sequence agrees and the divergence is a four-octet extent, which a widened
  (g) would cover and would keep two anchors. Owner dv_lead (reading) /
  architect_docs_lead (text); carrier the round that lifts `FI-4`/`FI-6`. Costs
  nothing today; bound against being cited as covering family H generally.
- **`FINDING CSG-2`** (MATERIAL, mine, **editorial class**): REQ-105's amended
  verification column projects (g)'s bound onto the wrong member of the
  lane-4-started half of `M03-E1`. Live at C8. Repair named; no
  re-countersignature owed; bound until repaired.
- **`RV-SWEEP` §3.4 DISCHARGED**: `H-3` is lost at a lane-0 mid-frame start and
  received at a lane-4 one.
- **CORRECTION OF RECORD**: C8's **class** blocker is discharged; **Stage 3
  remains unauthorised on gate condition (b)**, a stage condition and mine.
- **`SO-xgmii_rx_64.md` §6.3's pending marker resolves** to *ruled, both classes
  IN, both amended, countersigned here* — **noted for the SO- execution round;
  the draft was NOT edited**, per its own §9 items 1 and 5.
- **Nothing ran, nothing was anchored, no bar moved.** `AP-M03` §7's bars 1-4
  stand exactly as at `J-dv_lead-0160`.
- **Handoff**: to the orchestrator, for commit and for **transcription of the
  §13 countersignature row** under its own trailer (the `:993` precedent); then
  `CSG-1` and `CSG-2` to architect_docs_lead as spec-diff requests.
- **No lessons harvest is due at this entry.** PROTOCOL §7 and charter §8 place
  it at every `SO-` and every phase gate; this is neither. The span since my last
  harvest stays **open** and is declared rather than skipped — the `SO-`
  execution round designed at `J-dv_lead-0161` is the one that closes it.

### Open-questions

1. **`FINDING CSG-1`'s repair has a named carrier and that carrier is
   unscheduled.** The round that lifts `FI-4`/`FI-6` owes the `H-2` class request
   on its own merits now, not the open-ended request the ruling anticipated. If
   family H stays unreachable indefinitely, the recital outlives its repair with
   no round in flight — the same shape as `FINDING RV-0078-S2-3`'s orphaned
   carrier, and I record it rather than manufacture a round, on
   `J-orchestrator-0225`'s standing ruling.
2. **`FINDING CSG-2` is bound but not repaired, and the bound lives in a packet
   rather than in the document a bench writer opens.** Until the column is fixed,
   a reader who opens `requirements.md` and not `WO-0078` §14 gets the wrong
   member. **This is exactly the "one document up" hazard `FINDING ECS-1`
   convicted `AP-M03` for**, and I am now on the other side of it.
3. **The architect flagged one sentence against himself and I answer it here**:
   the new stimulus bar reads on **co-simulation stimulus only** and does **not**
   reach the directed benches. I read it as he intended and nothing in my
   instrument treats it otherwise. **No fresh finding.**
4. **My spawn's file-scope instruction was wrong and I did not follow it**
   (Reasoning §1). If the orchestrator's convention has genuinely moved and
   `docs/specs/` transcription is now expected from signers, that needs an ADR
   amending PROTOCOL §6, not a spawn-prompt sentence — and until it exists R7
   would refuse the commit anyway.
5. **Date drift**: this entry uses the machine clock (2026-08-10T22:52Z), later
   than my `J-dv_lead-0161` (22:21Z) and than the spawn-head commit
   (22:38:39Z), and **earlier** than the ruling entry it countersigns
   (`J-architect_docs_lead-0032`, stamped 23:40Z). `FINDING CD-P2-2` records the
   underlying inconsistency; nothing here rests on a calendar literal, and the
   countersignature's authority is its text and this entry, not its timestamp.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md

## [J-dv_lead-0163] 2026-08-10T23:19Z | task:none | Four carriers paid in the order my own draft fixed — the message gains its relatum, the citation bar gains teeth proved by two negative controls, the comparator learns to print what was agreed, and a "not yet" is priced by the instrument that would measure it rather than by the change

### Trigger

Orchestrator dispatch: **SO- EXECUTION, ROUND 1** — §7.1 steps **1–5** of my own
draft's twelve-step order, `agents/handoffs/SO-xgmii_rx_64.md` (landed `b80fef1`,
drafted at `49d87af`, `J-dv_lead-0161`). The dispatch states, and I accept, that
**the draft governs over the dispatch**. Steps 6–12 follow in a second round because
step 7's CI run needs steps 2–3 landed first — the draft's own 3→6 edge.

The dispatch also declares a **sibling in flight**: architect_docs_lead repairing
`CSG-1`/`CSG-2`'s recitals in `docs/specs/requirements.md`. I touched no `docs/**`
path.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §5, §6, §7, §10).
- `agents/handoffs/SO-xgmii_rx_64.md` — the whole draft; §0.2, §3.1, §3.2, §3.5,
  §3.8, §3.9, §5, §7.1 load-bearing here.
- `agents/handoffs/WO-0077_family-k-mutation-campaign.md` §6 (**`RN-6`'s ruling in
  full**), §6.6 (**`FINDING K-1` in full**); `WO-0077_..._SEALED-predictions.md`
  §6.6-adjacent text.
- `agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md` (`FINDING RV-0075-1`,
  `-2` at their source); `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md`
  §5, §5.1, §5.2.
- `agents/journals/claude_orchestrator_agent.v02.md` — `J-orchestrator-0225` ruling 2
  (`FINDING K-1`'s carrier).
- `agents/journals/claude_dv_lead_agent.v06.md` (`FINDING K-1`'s two measurements),
  `.v07.md` (Stage-1 absorption of `RV-0075-1`/`-2`), `.v08.md` (tail, for the id).
- `test/attack_plans/AP-xgmii_rx_64.md` §7 — `U-1`, `U-2`, and the paragraph pricing
  them.
- My own artefacts, opened to change them: `test/xgmii_rx_64/test_m03_k.ml`,
  `test/xgmii_rx_64/test_m03_n.ml` (read only, for the repair's model at `:1305`),
  `tools/dv_checks.sh`, `test/cosim/canonical.ml`, `test/cosim/canonical.mli`,
  `test/cosim/compare.ml` (read only), `test/cosim/dune`, `tools/cosim/run_cosim.sh`
  (grepped only, to confirm nothing parses the comparator's log text).

**Independence (PROTOCOL §10, charter §8).** **No RTL source was opened.** No file
under `libs/**`, `top/**` or `rtl_snapshots/**` was read. `libs/` appears in this
round exactly once, inside `git diff --name-only … -- libs/`, which prints **paths
and no content** and is the freeze verification my own draft's step 1 names.

### Reasoning

**1. Step 1 — the base, and a head that moved under me.**

The abort-first check passed: HEAD was the spawn-head `4e7331b` at the round's
opening. I declare the **base = `4e7331b`**, and the draft's freeze verification:

- `git diff --name-only 49d87af HEAD -- test/ libs/ tools/` → **empty**. Every figure
  the draft quotes was measured on this tree.
- `git diff --name-only e51ca52 HEAD -- libs/ tools/` → **empty**; over `test/`, one
  path, `test/attack_plans/AP-xgmii_rx_64.md` — the `AP-` round's own lift cells
  (`3526e79`, `J-dv_lead-0159`). So bar 1's set claim, measured at `e51ca52` over both
  producers, has had no producer change under it.

**Mid-round, HEAD advanced to `ce5674d`.** I applied the dispatch's own disjointness
test rather than treating a moved head as a stop: `git merge-base HEAD 4e7331b` =
`4e7331b`, so the spawn-head is an **ancestor**; the single new commit is the
**declared sibling's** and touches `docs/specs/requirements.md` and
`agents/journals/claude_architect_docs_lead_agent.v02.md` — **disjoint from all five
of my files**. I re-ran both freeze verifications and the whole of `dv_checks.sh` at
the new head; every result above is stated **at `ce5674d`**, not inherited from the
opening tree. A denominator measured against a tree that has since moved is the thing
step 1 exists to prevent, and it nearly happened here by accident rather than by
error.

**2. Step 2 — `FINDING K-1`, and why the repair is smaller than the defect.**

The finding, at its source (`WO-0077` §6.6), quoted rather than paraphrased:

> **`FINDING K-1` (MAJOR, against my own `WO-0072` §9 and, secondarily, against a
> bench message).** `WO-0072` §9 pre-committed **D1**, **D2** and **D3** as three
> distinct disposition classes with three distinct `BUG-` citations, to be applied
> *"against the CI `build` run at the landing commit"*. **All three move which cycles
> carry a delivered word, so all three raise `M03-K2`'s first DUT-observable
> assertion, whose message names the expected list and prints nothing it observed.**
> Four of this section's six classes land there. The same bench contains the same
> assertion shape at `M03-N4` **printing its observed list**
> (`test_m03_n.ml:1300–1311`), so this is a defect in one message and not a limitation
> of the form.

Carrier ruled at `J-orchestrator-0225` ruling 2: *the repair rides the `SO-` round,
because the `SO-` owns the next commit that opens `test_m03_k.ml` and the carrier rule
names the next opener, not a manufactured one.* **This round is its terminal carrier**
and it is paid at `test_m03_k.ml:466–500`.

Two choices inside the repair, neither cosmetic. **First**, I bound the expected list
to a name and let both the comparison and the message read it. The old message
hard-coded the literal in prose beside a literal in code — two copies of one fact,
which is the drift hazard that produced `FINDING M-4` and the `dune` header's own
staleness. **Second**, and this is the part a repair like this usually gets wrong: I
wrote **what the repair does not do** into the comment. `WO-0077`'s seal §8 collision
3 pre-committed, and the run confirmed, that IC-K1 at site (i) and IC-K6 with one
leaked cycle produce the **same observed list**, separated only by a `tlast` bit no
assertion in this unit reaches. **So the repair turns one message into several, not
into four.** A comment claiming the classes are now distinguishable would have been a
second `K-1` in the same file. The residual is a stimulus/assertion question, not a
message one, and it is recorded as an observation below rather than repaired here —
repairing it would widen this round's write set mid-round, which is the move `RV-C4`
§12 convicts.

**3. Step 3 — `RN-6`, and the one design decision that mattered: gate or report.**

`RN-6`'s ruling names the carrier exactly: *"a resolve-check in `tools/dv_checks.sh`
— at minimum, every `docs/**` path cited in `agents/handoffs/**` resolves at the tree,
and a citation that does not is reported by the same command whose output is already
this programme's census provenance."*

`tools/dv_checks.sh` already sorts its blocks into two classes, and the file argues
the distinction in its own comments: **CHECKS gate**, **REPORTS cannot manufacture a
green and cannot redden one**. The inventory and the row census are reports *because
an asserted count goes stale every packet and would redden the suite for doing its
job*. **A path either resolves or it does not — that is an invariant, not a count**,
so it belongs in the check class. And the decisive argument is `RN-6`'s own history:
a note-carrier repaired the instance at `WO-0076` and did not bind the drafting, and
the same broken path was copied into the very next packet **by the agent that ruled
it**. A non-gating disposition has now been tried once and failed once. **It gates.**

Four sub-decisions, each against a way this could have been theatre:

- **Scope is the ruled minimum: `agents/handoffs/**/*.md`, not widened to journals.**
  Journals are append-only by PROTOCOL §4, so a broken citation in one is unrepairable
  by construction and a bar over them could only ever accumulate exceptions. **A bar
  whose only possible response to a finding is to grow its exception list is not a
  bar.**
- **Three non-failure classes, each printed so the judgement is checkable rather than
  inherited.** `GLOB` for an **interior** `*` — trailing `*`s are stripped first,
  because markdown bold is emphasis and not a pattern, and that strip is exactly why a
  **bolded** broken path is still caught. `PREFIX` for a citation by id
  (`docs/adr/ADR-0001`) that is a **unique** filename prefix — with uniqueness as the
  whole guard: an **ambiguous** prefix is reported `MISSING`, never quietly accepted.
  Each accepted prefix is listed with what it resolved to.
- **The errata table, and why it is a table and not a cleverer regex.** The check
  cannot tell a **citation** from a **quotation-to-convict** — my own draft §3.2 quotes
  the broken `ADR-0014` path in order to state the defect. That is the same distinction
  PROTOCOL §10's R-SEAL-1 draws between making a claim and quoting one, and it says in
  terms that *distinguishing a claim from a quotation is not a lexical test*. So it is
  a signed, diffable disposition, not a pattern. The bodies of the three issued packets
  are **not rewritten**: `RN-6` ruled that editing an instrument another agent has
  already worked under makes its compliance statement unverifiable against the text it
  cites.
- **Staleness is a failure.** A declared erratum that stops firing reddens. An
  allowlist with no staleness check is how a bar decays into a comment, and I would
  rather be forced to delete an entry deliberately than let one rot.

**And the anti-vacuity, which I owed to myself.** My draft §3.2 said *"expect the check
to report failures on first run… a check whose first run is green tells you nothing
about the check"* — `FINDING K-3`'s rule applied to its author's own new bar. **What
actually happened is worth stating precisely, because the honest version is less
flattering than the planned one**: I extracted the citation set with the same regex
**before** wiring the gate, found the seven unresolved tokens, dispositioned them, and
**then** wired the check — so the gating check's first run was **green**, and that
green is evidence of nothing. The teeth come from two places instead: an **inline
self-test** with six classifier assertions (four of them negative) plus two extractor
assertions, all on fixtures because nothing in this tree can demonstrate that an
ambiguous prefix is refused; and **two negative controls run against the real tree** —
delete one erratum entry and the check reddens with an undeclared broken citation;
add a key that never fires and it reddens on staleness. **Both directions, on real
data.** The self-test is invoked directly rather than through `run_and_label`, for two
reasons stated in the file: it has no gate it can stand down at, so the `SKIPPED`
branch would be unreachable and misleading; and an indirectly-invoked function reads
to a static analyser as dead code, and the file was `shellcheck`-clean before this
block.

**4. Step 4 — `FINDING RV-0078-S2-11`: I opened the comparator. And the cost I was
carrying for that decision was wrong.**

The choice the draft fixed: open `test/cosim/**` and print the agreed value on the
clean path, **or** decline and write REQ-104's row as the pair. My own `LH-cand-I`
says *where the interesting fact is a value rather than a relation, print the agreed
value on the passing path*, so the burden was on declining.

The price I expected to pay for opening was a second carrier: my draft §3.9 lists
`FINDING RV-0075-1` (T1's printer) in the standing set with carrier *"the next commit
opening `test/cosim/**`"*. **It is closed.** `WO-0078` §5.1 absorbed it into Stage 1;
the repair is landed in `canonical.ml`'s `timing_report_to_string`, which cites the
finding by name and was further extended by `FINDING RV-0078-S1-2` limb (b); the
Stage-1 verdict records it **CLOSED**. **My draft carried a discharged debt as
standing, and that mispricing sat directly under a decision this round had to make.**
It is raised as a finding against §3.0 of my own packet. I did **not** rewrite §3.9:
`FINDING RV-0075-2` is closed only *for the class it named* and its residual limb is a
separate question, and correcting a standing set from one spot-check is the defect this
packet convicts elsewhere. §3.9 is `RE-MEASURE` at step 9.

Three properties of the repair, each chosen against a defect already paid for here:

- **`cycle` is absent from the agreed record.** `WO-0075` §4 bars a cross-side cycle
  comparison as the quantity REQ-901's closing sentence excludes by name, so
  `compare_words` never reads it. **A quantity that was not compared may not sit inside
  a record of what was agreed**, where a reader would take it for one — which is why
  `agreed_word` is its own type and not a `word list`. Bar 3 is untouched.
- **Per frame, never gated on the transaction's divergence list.** Gating a per-frame
  print on the whole transaction is precisely `FINDING RV-0078-S1-2` limb (b)'s defect
  in the sibling printer in this same file — unreachable at a one-frame case,
  reachable from the first multi-frame case on. Not reintroduced.
- **`agreed` accumulates in the same branch, off the same predicate, that increments
  `frames_matching`**, so count and values cannot drift, and it is taken from *ours*,
  which **is** *theirs* on every compared field by that very predicate.

**What it is not.** Not a lift (§5.1 item 4): no row status, no coverage-map line, no
discharge count moves. No new anchored class. The lane still asserts **no figure of its
own** — the absolute half stays with an X-1 bench row (`FINDING RV-0078-S2-2`). And it
does **not** improve the landed logs: the five lift runs were produced by the old
printer and are not re-run, so the agreed value becomes quotable **only** from step 7's
own `cosim` job at the sign-off SHA, where a re-observation is not a lift and renews
none. If that job does not produce the line, REQ-104's row **falls back to the pair
form**. §5.5 binds either way, and I wrote that consequence into §3.5 now, before the
row exists, precisely so it cannot be worded loosely later.

**One thing I deliberately did not do.** I did not add a self-test case to
`compare.ml` for the ungated property. The established precedent in this file for a
**printer** repair is `RV-0075-1`'s own, whose comment says the property is *"verified
by eyeball against the printed report below, not by this exit-code check alone: see
the journal entry's Evidence"* — a printer asserts nothing and cannot redden anything,
so `FINDING K-3`'s rule about bars does not reach it. I followed that precedent and
produced the eyeball evidence as a declared transient. **The committed self-test does
not exercise "a matched frame beside a content-diverged frame"**, and that gap is named
below with a carrier rather than left for someone to discover.

**5. Step 5 — `U-1`/`U-2`: refused, and the refusal is priced by the measurement, not
by the change.**

`AP-M03` §7 records that neither is blocked on machinery: *"both of them changes to
assertion ordering or stimulus separation, not new capability"*. So the implementation
is cheap — one `WO-` to tb_writer, two units, one bench round. **The implementation is
not the price.**

The price is the **campaign**. What the change buys is that two assertions become
**reachable by mutation**, and reachability is a *measurement* whose only instrument is
a seeded campaign. **The class-based era closed at `WO-0077`; no seal is drafted and
none is scheduled** — my own §3.7 owns that measurement. So a unit landed now arrives
**unqualified**, and the packet's claim moves from *"this assertion is unreachable,
MEASURED under five classes"* — which is what `U-1`'s cell records today — to *"this
assertion should now be reachable, DERIVED from an ordering argument."* **That is a
worse position for a sign-off, not a better one**: it trades a measured blindness for
an unmeasured hope, which is `FINDING K-3`'s rule and `LH-cand-J`'s
(*reproduction earns confidence, never jurisdiction*) pointing the same way. `SC-8`
exists to **publish** the register, not to empty it.

**So: form (b), refused — with the bound intact and an expiry that is not a date.**
The bound is `AP-M03` §7's dispositions unchanged: `M03-L4` is qualified by citation to
`M03-L1`'s pairing or not at all; `M03-L3`'s ΔC content is discharged by `WO-0070` §6's
derivation and by no run; and no packet may count a `U-`-marked assertion and its
preceding sibling as two observations. The expiry has **three triggers, whichever fires
first**: (1) the next seeded campaign commissioned against this module — the separation
rides *that* order, so the new units are qualified by the campaign that measures them;
(2) the next round that opens `test_m03_l.ml` for any other reason — the same carrier
logic `J-orchestrator-0225` ruling 2 used on `FINDING K-1`; (3) `P1-phase-accept` as a
backstop, where the refusal **expires and is re-decided in the open**. Trigger 3 is the
one that matters: it is what stops this becoming, in `LH-cand-K`'s words, *a permanent
"no" that nobody decided.*

**6. On touching the packet at all this round.** The draft writes §3 at step 9, and I
have not written §3 — I appended two clearly-delimited `RULED` blocks to the §3.5 and
§3.8 that already exist, a §3.0 execution record, a header Execution bullet and a
change-log row. Nothing in §1, §2, §5, §6 or §8 moved. **State stays DRAFT, §8 stays
UNSET, and a carrier payment adjudicates no criterion of §1** — the draft's §9 item 5
says a *draft* pays no carrier, and this is the executing round, which does.

### Actions

- Step 1: abort-first head check; base declared `4e7331b`; freeze verified; head
  movement to `ce5674d` detected mid-round, tested for disjointness, all measurements
  re-taken at the new head.
- Step 2: `test/xgmii_rx_64/test_m03_k.ml` — `FINDING K-1` paid at `M03-K2`'s first
  DUT-observable assertion.
- Step 3: `tools/dv_checks.sh` — `RN-6`'s gating resolve-check, its self-test, its
  errata table and its staleness guard; script re-run; every unresolved citation
  dispositioned.
- Step 4: `test/cosim/canonical.ml` + `canonical.mli` — `FINDING RV-0078-S2-11`'s
  repair; built and self-tested locally with plain `ocamlc`.
- Step 5: `U-1`/`U-2` answered, form (b).
- Packet: `agents/handoffs/SO-xgmii_rx_64.md` — §3.0, the two `RULED` blocks, the
  header Execution bullet, the change-log row.

### Evidence

**All commands run from a clean checkout at `ce5674d` with this round's five files
modified in the working tree. Nothing below is a `dune runtest` result: steps 6–7 take
those, in round 2.**

**(a) Base and freeze — step 1.**

```
$ git rev-parse HEAD                                    (at the round's opening)
4e7331b609a40763394822405e09fb170cc2e5e9                 == the spawn-head
$ git diff --name-only 49d87af HEAD -- test/ libs/ tools/
                                                         (empty)
$ git diff --name-only e51ca52 HEAD -- libs/ tools/
                                                         (empty)
$ git diff --name-only e51ca52 HEAD -- test/
test/attack_plans/AP-xgmii_rx_64.md
$ git merge-base HEAD 4e7331b                            (after HEAD moved)
4e7331b609a40763394822405e09fb170cc2e5e9
$ git log --oneline 4e7331b..HEAD
ce5674d Both findings verified and both corrected by the deeper trace: …
$ git diff --name-only 4e7331b HEAD
agents/journals/claude_architect_docs_lead_agent.v02.md
docs/specs/requirements.md
```

**(b) `RN-6`'s check — step 3.** `bash tools/dv_checks.sh` → **exit 0**. Its two new
blocks, observed:

```
=== docs/** citation resolve-check --self-test (RN-6) ===
  ok    a resolving path is OK             docs/adr/ADR-0001-org-design.md -> OK
  ok    RN-6 shape is caught               docs/adr/ADR-0001.md -> MISSING …
  ok    a bolded broken path is caught     docs/adr/ADR-0001.md -> MISSING …
  ok    an interior glob is a pattern      docs/reports/*/x.md -> GLOB
  ok    a unique id prefix resolves        docs/adr/ADR-0001 -> PREFIX docs/adr/ADR-0001-org-design.md
  ok    an AMBIGUOUS prefix is refused     docs/adr/ADR-0090 -> MISSING AMBIGUOUS prefix — 2 names …
  ok    extractor finds and attributes the broken citation
  ok    extractor strips markdown bold from a good citation
=== docs-citation resolve-check self-test: OK ===
…
  302  docs/** citations in agents/handoffs/**/*.md (file x path, unique)
  293  resolve at the tree
    0  patterns (interior glob) — not citations, not checked
    5  resolve by UNIQUE id prefix (listed above)
    4  declared errata (listed above; each ruled, none rewritten)
    0  UNDECLARED broken citations
    0  stale errata (declared, did not fire)
=== docs/** citation resolve-check: OK ===
```

**The seven unresolved tokens the first extraction found, each dispositioned**
(`302 = 293 + 5 + 4`):

| token | citing packet(s) | disposition |
|---|---|---|
| `docs/adr/ADR-0001`, `ADR-0006`, `ADR-0007`, `ADR-0010`, `ADR-0017` | `WO-0002`, `WO-0008` ×2, `WO-0019`, `WO-0077` | **RESOLVED BY UNIQUE PREFIX** — citation by ADR id; each is a unique filename prefix and the check prints what it resolved to. Not the `RN-6` defect and not an erratum |
| `docs/adr/ADR-0006/0007` | `WO-0008` | **ERRATUM** — compressed prose shorthand for two ADRs, both of which resolve and both of which the same packet cites in full in its own return table. Body not rewritten. No carrier: the targets exist |
| `docs/adr/ADR-0014.md` | `WO-0076`, `WO-0077` | **ERRATUM OF RECORD** — `RN-6`'s two instances, ruled at `WO-0076` §4 and `WO-0077` §6. Target `docs/adr/ADR-0014-an-enable-gates-admission-not-the-wire.md`. Bodies not rewritten, by ruling |
| `docs/adr/ADR-0014.md` | `SO-xgmii_rx_64.md` | **ERRATUM — quotation-to-convict**, not a citation: §3.2 quotes the broken path in order to state the defect. Not lexically separable from a citation, hence a disposition and not a pattern |

**The two negative controls, run against the real tree in a symlinked scratch copy —
ephemeral, deleted, and declared as such (ADR-0003/F5):**

```
NEGCTL A — one erratum entry deleted:
  BROKEN   agents/handoffs/WO-0077_family-k-mutation-campaign.md
    3  declared errata …
    1  UNDECLARED broken citations
=== docs/** citation resolve-check: FAILED ===

NEGCTL B — a key added that never fires:
  STALE ERRATUM — declared and did not fire: agents/handoffs/NOSUCH.md|docs/adr/NOSUCH.md
    1  stale errata (declared, did not fire)
=== docs/** citation resolve-check: FAILED ===
```

`bash -n tools/dv_checks.sh` → clean. `shellcheck tools/dv_checks.sh` → **exit 0**,
matching the file's pre-round baseline (`shellcheck` on `git show HEAD:tools/dv_checks.sh`
→ exit 0). CI does not run `shellcheck`; this is a local property I chose not to
regress.

**(c) `test/cosim` — step 4, the plain-`ocamlc` path.** `canonical.ml`/`.mli` and
`compare.ml` need nothing beyond the standard library, by the `dune` stanza's own
design note, so they build outside the Hardcaml toolchain:

```
$ ocamlc -version
4.14.1
$ ocamlc -w @1..3@5..28@30..39@43@46..47@49..57@61..62@67@69-40-41-42-44-45-48-58-59-60-66-68-70 \
    -strict-sequence -strict-formats -short-paths -g \
    -c canonical.mli && … -c canonical.ml && … -c compare.ml && … -o compare canonical.cmo compare.cmo
   (clean; no warning, no error)
$ ./compare --self-test
   … 13 cases …
compare --self-test: OK                                  (exit 0)
```

**All thirteen existing self-test cases pass unchanged**, including (a) exit 0, (b)
exit 1, (c)/(f)/`WO-0078-1` exit 3, (d)/(e)/`S1-1` exit 4, T0 exit 5, (e′)/`5.2` exit
6, `S1-2` limb (b) exit 4 and `S2-8` exit 0.

**The new block, observed on the clean path** (self-test case (a)):

```
frames compared: 1
frames matching: 1
divergences: none
agreed values (what REQ-901's comparison found EQUAL; this lane asserts no figure of its own -- FINDING RV-0078-S2-11)
  frame 0: decision = accept, 2 word(s), 12 octet(s)
    word 0: tkeep = ff  tlast = 0  tuser0 = 0  octets = 00 01 02 03 04 05 06 07
    word 1: tkeep = 0f  tlast = 1  tuser0 = 0  octets = 08 09 0a 0b
```

**The property the committed self-test does NOT exercise, demonstrated as a declared
transient** (hand-authored two-frame canonical pair in a scratch directory, **deleted;
ephemeral, ADR-0003/F5**): frame 1's last word perturbed by one octet on the `theirs`
side —

```
frames compared: 2
frames matching: 1
divergences: 1
  DEFECT: frame 1 word 1: octets mismatch (ours=18 19 1a 1b, theirs=18 19 1a bb)
agreed values (…)
  frame 0: decision = accept, 2 word(s), 12 octet(s)
    word 0: tkeep = ff  tlast = 0  tuser0 = 0  octets = 00 01 02 03 04 05 06 07
    word 1: tkeep = 0f  tlast = 1  tuser0 = 0  octets = 08 09 0a 0b
                                                          (exit 1)
```

— the matched frame's agreed values print **beside** a diverged frame, and the diverged
frame contributes **no** agreed entry. And the same pair compared against itself
prints the REQ-104 shape this repair exists for: `frame 1 … word 1: tkeep = 0f
tlast = 1  tuser0 = 1 …` on the clean path, exit 0. **This is a transient
demonstration and not committed evidence**; the committed evidence is step 7's own
`cosim` job at the sign-off SHA.

**(d) `test_m03_k.ml` — step 2. CI-DEFERRED, and named as such.** This directory is
Hardcaml-dependent; `tools/precompile_check.sh`'s STUBBABLE set does not cover
`hardcaml_ethernet`, so the directory is **excluded from that harness by
construction** (`test/xgmii_rx_64/dune`'s own header, `WO-0038` §6 rule 2), and **CI's
`dune build @default` / `dune runtest` is the only compiler that reaches it**
(ADR-0005). The only local check available is a parser pass, and it is weak evidence
which I do not dress up as more:

```
$ ocamlc -stop-after parsing -c test_m03_k.ml
                                                         (exit 0 — parses; type-check NOT performed)
```

**The type-check, the expect promotion and the suite verdict for this file are owed to
CI at the sign-off SHA, and per §3.1 the run id quoted at `SC-3` must be a run taken
AFTER this repair — not an earlier green.**

**(e) What did not change.** `git status --porcelain` lists exactly five modified
paths and no untracked file. No `docs/**` path, no `libs/**`, `top/**` or
`rtl_snapshots/**` path, no `docs/gates/**`, no `.github/**`. No `git commit`, no
`git push`, no `dune`, no `iverilog`, no `vvp`, no CI trigger.

### Outcome

**Steps 1–5 met. Steps 6–12 owed to round 2, unchanged.**

Ledger items **1** (`FINDING K-1`), **2** (`RN-6`), **5** (`S2-11`'s repair) and **10**
(`U-1`/`U-2` pricing) are **PAID** — recorded in the packet at §3.0. Items 3, 4, 6, 7,
8, 9, 11 and 12 are untouched and stay owed. The packet's **State remains DRAFT and §8
remains UNSET**; no criterion of §1 is adjudicated, no bar lifted, no count asserted,
no anchor claimed, no harvest taken.

**Handoff**: the five files below, staged-ready, to the orchestrator, trailer
`Agent: dv_lead`. **One consequence the orchestrator should relay rather than absorb**:
`tools/dv_checks.sh` is a `build.yml` step, so from this commit on **a new `docs/**`
citation in ANY `agents/handoffs/**` packet that does not resolve at the tree reddens
CI for every agent, not only for me.** That is the bar working as ruled, and it is
also a coordination fact every packet-writing agent now needs.

**Harvest — status, not the harvest.** `SC-12` and my draft's §4 place the programme's
first dv_lead harvest at **step 10**, in the **signing** entry, over the span
`J-dv_lead-0001 … <signing entry>`. **The span stays OPEN and is not tiled here.** What
this round owes the walk is its own candidates, banked **at this entry** so the
step-10 walk finds them rather than reconstructing them; ids continue regime 1's
sequence (which ended at `LH-cand-K`) and **will be re-labelled once**, with the old
label recorded beside, when step 10 re-labels the whole bank into one `LC-`/`LD-`
sequence:

- **`LH-cand-L`** — *a bar over a corpus whose entries may not be edited needs a
  declared exception list, and an exception that no longer fires must fail: an
  exception list with no staleness check is how a bar decays into a comment.*
  **LH1**: this round's `RN-6` check, and the two rounds that carried the same broken
  citation under a non-gating disposition. **LH2-g**: no proper noun. **LH3**: without
  it the list grows silently and the bar stops measuring anything, while still printing
  a green.
- **`LH-cand-M`** — *a carried-obligation list is a claim about the present and goes
  stale like any other measurement; re-measure an obligation's state at its source
  before pricing a decision on it.* **LH1**: this round found a discharged debt listed
  as standing, directly under the decision it mispriced. **LH2-g**: holds. **LH3**:
  without it a round pays twice, or declines a cheap thing believing it expensive.
- **`LH-cand-N`** — *a record of what two implementations agreed on may contain only
  the quantities that were compared; admitting an uncompared quantity into it converts
  a non-comparison into an apparent agreement.* **LH1**: this round's agreed-value
  record and the excluded time field. **LH2-g**: holds. **LH3**: without it a reader
  cites, in good faith, a value no comparison ever established.
- **`LH-cand-O`** — *when a change is cheap but the instrument that would give it
  meaning is expensive, the refusal is priced by the instrument, not by the change —
  and a measured blindness is worth more to a verdict than an unmeasured repair.*
  **LH1**: this round's `U-1`/`U-2` answer. **LH2-g**: holds. **LH3**: without it a
  programme buys cheap changes that move a claim from *measured* to *derived* and
  reports the trade as progress.

**One war story, kept and not offered**: my own anti-vacuity plan for the `RN-6` check
said its first run would be red; I dispositioned the findings before wiring the gate,
so the first gating run was green and proved nothing. The lesson generalises only into
`LH-cand-L`, which already carries it; as a rule of its own it fails **LH2** by being a
restatement of *test your test*.

### Open-questions

1. **The residual `K-1` collision.** After the repair, IC-K1 at site (i) and IC-K6 with
   one leaked cycle still produce identical messages, because their **observed lists are
   equal** and the separating fact is a `tlast` bit no assertion in this unit reaches
   (`WO-0077` seal §8 collision 3, sealed before the run and confirmed by it).
   **Carrier: step 8's family-K rows**, which must state it rather than let the repair
   imply four-way discrimination.
2. **`compare.ml`'s self-test does not exercise the agreed block's ungated property** —
   a matched frame beside a **content**-diverged frame. The existing multi-frame case
   diverges in T1, not in content. Demonstrated transiently above; **carrier: the next
   round that opens `test/cosim/compare.ml`.** I declined to widen this round's write
   set for it, on this file's own precedent for a printer repair.
3. **§3.9's standing set is `RE-MEASURE` at step 9**, not corrected here.
   `FINDING RV-0075-1` is closed; `FINDING RV-0075-2` is closed only for the class it
   named. **The whole list needs walking at its sources**, and the count is a product of
   that walk.
4. **The sibling's commit `ce5674d` moves `docs/specs/requirements.md`**, whose title
   line reads *"the widening withdrawn on sign"*. **REQ-901's class list and the
   (g)/(h) recitals are inputs to §2.4, §5.6 and §6.3**, all of which round 2 writes.
   Round 2 must re-read that file at the sign-off SHA rather than inherit this draft's
   reading; §6.3 records the ruling as **PENDING** and I have not anticipated it.
5. **Criterion 3's unexercised plural property** (`§3.6`) is unchanged and still routed
   to the auditor, unanswered — I have not self-adjudicated it in the packet that
   benefits from the answer.

### Files-in-this-commit

- agents/handoffs/SO-xgmii_rx_64.md
- test/cosim/canonical.ml
- test/cosim/canonical.mli
- test/xgmii_rx_64/test_m03_k.ml
- tools/dv_checks.sh

## [J-dv_lead-0164] 2026-08-10T23:58Z | task:none | The bar's first run on a runner convicted two things at once — the citation really was broken for every reader outside this container, and the instrument was measuring the container: one tracked file pays the first, `git ls-files` pays the second

### Trigger

Orchestrator dispatch, **sole agent in flight**, opened by the runner's verdict on
`J-dv_lead-0163`'s own payment. `RN-6`'s resolve-check — ledger item 2 of
`agents/handoffs/SO-xgmii_rx_64.md`, landed one commit ago — reached CI for the first
time and **failed**: `build` run **`31442295998`**, step *"DV mechanical checks"*,
**4 UNDECLARED broken citations**, every one of them citing `docs/reports/latency/`.
The same script at the same commit in this container reports **0**.

**HEAD verified as my first action, before reading anything**: `git rev-parse HEAD` →
`ee3da9c06bb77099edbfe6f8bff7f949f61c7d4c`, exactly the stated spawn-head (*"Four
carriers paid in the draft's own order…"*). **Match**; neither branch of the abort
procedure ran.

This is **not a step of §7.1**. It is a repair round against a payment already made,
and I record it as `round 1R` so the two-round shape of the `SO-` execution stays
legible and a reader can see that no step was executed out of order.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §5, §6, §7, §10).
- `agents/handoffs/SO-xgmii_rx_64.md` — §0.2, §1 (`SC-1`, `SC-3`, `SC-10`, `SC-13`),
  §3 ledger, §3.0, §3.2, §7.1, §7.2, §10.
- **The four citing packets, at the citing lines**:
  `agents/handoffs/WO-0003_testability-findings.md` (REQ-806's testability finding),
  `agents/handoffs/WO-0015_batch-d-countersign.md` (carry-forward `C-23`),
  `agents/handoffs/WO-0018_batch-de-countersign.md` (carry-forward `C-24`),
  `agents/handoffs/SO-xgmii_rx_64.md` (§7.1 write scope, §7.2 gate ladder).
- **The CI evidence itself**: the failed job log of `build` run `31442295998`
  (job `93629331615`), read for the printed block rather than for its conclusion —
  an externally verifiable reference, ADR-0003/F5 sense.
- `docs/specs/requirements.md` — REQ-004, REQ-005, REQ-006, REQ-019, REQ-806 and
  §0.5/§1.1, for the README's statement of where latency figures live today.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.L row headers (`M03-L1` … `M03-L6`), for
  the same purpose; `docs/specs/modules/` path list, for `nic_top`'s spec existing.
- `tasks/BOARD.md` §Gates, for the gate state the README asserts.
- `agents/journals/claude_dv_lead_agent.v08.md` (tail, for the id and the banked
  candidate sequence).
- My own artefacts, opened to change them: `tools/dv_checks.sh`,
  `agents/handoffs/SO-xgmii_rx_64.md`.

**Independence (PROTOCOL §10, charter §8).** **No RTL source was opened.** No file
under `libs/**`, `top/**` or `rtl_snapshots/**` was read, and no path from those trees
appears in this round's derivation chain at all.

**Git discipline, stated because this round used git heavily.** Against the programme
repository I ran **read-only** git only — `rev-parse`, `ls-files`, `status`,
`log`, `archive`, `remote`. **I ran no `git add`, no `git commit` and no `git push`
against it, and I did not touch its index.** Every `git init`/`git add` in this round
happened inside throwaway directories under the session scratchpad, which is also
where the script's own new self-test fixture lives (`mktemp -d`).

### Reasoning

**1. The red is right, and that has to be said before anything about the instrument.**

`docs/reports/latency/` exists in this container as an **empty, untracked directory**,
created 2026-08-01. `git ls-files docs/reports/latency` → **0 entries**. **Git cannot
track an empty directory**: there is no tree entry for it, so it is not in HEAD, not in
`git archive`, and **not in any fresh clone**. The four packets therefore cite a path
that does not exist for anyone who is not sitting in this one container — which is
every reader the citations were written for. **The gate's first catch is a true
positive, and if I had repaired only the instrument I would have deleted a real
finding to make my own tool green.** That inversion is the thing I most wanted to
avoid, and it is why the disposition was ruled before the resolver was touched.

**2. And the instrument is wrong at the same time, in a way I have convicted before.**

The resolver asked `[ -e "$root/$p" ]`. That is a question about **the filesystem the
check happens to be running on**; the thing the check governs is **committed text**. So
the same command gave two different answers on the same commit, and the *flattering*
one was the one its author saw. **This is the circular-pin lesson in another costume**:
an instrument whose reading is a function of its own environment rather than of the
artefact under test. Its symptom is never a wrong-looking number — 0 and 4 both look
fine — it is a **divergence between environments**, invisible until two of them differ
and unattributable from inside either.

**3. The resolver repair, and the one design decision inside it that is not obvious.**

The universe is now what **git can carry in a commit**, and the classifier is a pure
function over that list — no `-e`, no `-d`, no disk glob:

- **TRACKED** = `git ls-files --cached`. In a clean tree this **is** HEAD's tree, which
  is exactly what a checkout materialises. This half is why a local run can now
  reproduce a runner's answer.
- **COMMITTABLE** = TRACKED + `git ls-files --others --exclude-standard`.

**The decision: the check GATES on COMMITTABLE, not on TRACKED.** Gating on TRACKED is
the purer statement and it is wrong in practice, because *the round that repairs a
citation writes the target file before the orchestrator commits it* — I never stage,
so the repair is untracked at the moment the check runs. A TRACKED-only gate reddens
every repair round **for having done the repair**, and a bar that punishes its own
remedy gets bypassed. **What makes COMMITTABLE safe is the property both halves share:
`--cached` lists blobs and `--others` lists files, so NEITHER can contain an empty
directory.** The exact defect that reddened `31442295998` is not expressible in either
universe, on any machine. A directory citation resolves iff something git carries lives
under it — precisely the condition under which a checkout creates the directory.

**The residual gap is real and is printed rather than argued away.** A citation that
resolves *only* through the untracked half is reported `PENDING-COMMIT` with its path
and the sentence *"CI resolves this if and only if that path is in this round's
commit."* It is a notice, not a failure — but it is **computed every run**, so unlike a
declared exception it cannot rot, and it names the single remaining way a local green
can differ from a runner green. I considered and rejected leaving it silent: the whole
finding above is that a silent divergence is the dangerous kind.

**Two smaller repairs ride the same rebuild.** The **citing** side is now enumerated
from `git ls-files` too — a stray or ignored `.md` in `agents/handoffs/` can no longer
inject a citation CI will never see, which is the same defect in the other direction.
And a citing file git lists but the working tree lacks is reported `UNREADABLE` and
**fails**, because when the two sides of the measurement disagree no count below them
is trustworthy.

**4. The four dispositions: one tracked file, zero errata — and why the cheap route is
the wrong one.**

All four citations name the **space**, not a document. That already separates them from
`RN-6`'s own class (a pointer to a document living under another name): there is no
mis-typed target to disclose, there is a directory the write-scope table in PROTOCOL §6
and my charter §1 both name and which no clone has ever contained. Four errata were
available, cheap, and inside a table built exactly for this — and I refused them on
three grounds:

- **(a) The exception is repairable from inside my own write scope.** An erratum
  declares a citation permanently broken *by ruling*. Ruling something unrepairable
  when one file in `docs/reports/latency/**` repairs it is a false statement about the
  world dressed as a disposition.
- **(b) The expiry is already on the gate ladder.** `P1-phase-accept` requires the
  latency report **committed under this exact path**. So the moment the first report
  lands, four declared errata stop firing and this same check reddens on
  **staleness** — the guard `LH-cand-L` mints, turned against a repair. **A disposition
  whose expiry is already fixed by a scheduled obligation is a deferred failure with a
  known date, not a disposition.**
- **(c) One of the four citers is the sign-off packet itself.** A packet whose `SC-10`
  demands every set claim carry provenance cannot ship carrying a **declared-broken
  citation of its own**; the bar would be teaching its readers that it is optional.

**The README is written to make the citation resolve TRUTHFULLY, which is a stronger
requirement than making it resolve.** It states the space's purpose and owner, that
**no latency report has yet been written** (measured, with the command), and where
latency figures live *today*: REQ-005's per-octet constancy asserted inside the REQ-004
line-rate stress rows (`AP-M03` §4.L — `M03-L2`, `M03-L3`, `M03-L5`), and REQ-019's ΔC
ceilings checked at `P1-spec-freeze` as arithmetic on the specifications. **REQ-006's
end-to-end budget is a different quantity, defined at `nic_top` across §0.4's whole
chain, and no bench has produced it** — so the reader who follows one of these four
citations learns why the directory is empty instead of finding a hole. It also lists
what each of the four citers obliges of the first artefact written there.

**And it quotes no latency figure at all, deliberately.** `C-23` and `C-24` both gate on
the first artefact in that directory that quotes REQ-502's number; a README that quoted
one would discharge neither carry-forward and trip both. Writing the *gate* into the
README while refusing to write the *figure* is the whole distinction, and I have said so
in the file so a later author cannot mistake the silence for an oversight.

**5. What I did not do.** I did not rewrite a single citing packet body — `RN-6`'s
ruling that an already-issued instrument is not silently edited is untouched and none of
the four needed it. I did not widen the check's scope past the ruled minimum. I did not
move a ledger item, adjudicate a criterion, lift a bar or take the harvest. The `SO-`
stays **DRAFT** with §8 **UNSET**.

### Actions

1. **Repaired the resolver** in `tools/dv_checks.sh`: new `docs_cit_universe` (two
   modes), `docs_cit_files`, `docs_cit_unreadable`, and `docs_cit_classify_in` (pure,
   awk, over the universe) replacing the filesystem-based `docs_cit_classify`;
   `docs_cit_pairs` now takes the root and the universe. Added the `PENDING-COMMIT`
   pass, the `UNREADABLE` guard, a not-a-work-tree failure branch, and the
   header block recording run `31442295998` and the general rule.
2. **Rebuilt the self-test in two halves** — the classifier over a synthetic universe,
   and **the measurement inside a throwaway git repository** where the CI condition is
   physically reconstructed: empty directory on disk, nothing tracked, a filesystem
   resolver *shown* to answer "exists", and the check required to answer MISSING.
3. **Wrote `docs/reports/latency/README.md`** — the disposition of all four citations.
4. **Recorded the round in the packet**: header Execution bullet, §3.0.1 (the round and
   its two findings, `FINDING RN-6-CI-1` / `RN-6-CI-2`), §3.2.1 (the repair, the four
   dispositions, eight evidence rows), §10 change log.
5. Ran the check locally, in a **constructed fresh checkout**, and under **three
   negative controls**; ran `bash -n` and `shellcheck`.

### Evidence

**(a) The CI verdict this round answers.** `build` run **`31442295998`**, job
`93629331615`, step *"DV mechanical checks"* — **failed**, printed:

```
   302  docs/** citations in agents/handoffs/**/*.md (file x path, unique)
   289  resolve at the tree
     0  patterns (interior glob) — not citations, not checked
     5  resolve by UNIQUE id prefix (listed above)
     4  declared errata (listed above; each ruled, none rewritten)
     4  UNDECLARED broken citations
     0  stale errata (declared, did not fire)
=== docs/** citation resolve-check: FAILED ===
```

with four `BROKEN` lines, all `cites docs/reports/latency/`. **Externally verifiable
reference, not a local artefact** (ADR-0003/F5).

**(b) The root cause, measured rather than described.**

```
$ git ls-files docs/reports/latency | wc -l
0
$ ls -d docs/reports/latency
docs/reports/latency                              (present on disk, empty)
$ git archive HEAD | tar -t | grep -c '^docs/reports/latency'
0                                                 (absent from HEAD's tree entirely)
```

**(c) The divergence, closed at its source.** The repaired check, run **locally in this
container on the tree exactly as the runner saw it** (before the README existed):

```
$ bash tools/dv_checks.sh
   302  docs/** citations in agents/handoffs/**/*.md (file x path, unique)
   289  resolve at the tracked tree
     0  patterns (interior glob) — not citations, not checked
     5  resolve by UNIQUE id prefix (listed above)
     4  declared errata (listed above; each ruled, none rewritten)
     4  UNDECLARED broken citations
     0  stale errata (declared, did not fire)
     0  resolve ONLY via a not-yet-committed path (PENDING-COMMIT, above)
=== docs/** citation resolve-check: FAILED ===          (exit 1)
```

**Character-for-character the counts of run `31442295998`, from the container that used
to report 0.** That is the whole repair, stated as a measurement.

**(d) After the disposition, locally, at this round's final content:**

```
$ bash tools/dv_checks.sh
   396  paths git carries here            (git ls-files)
     1  further paths a commit would add  (git ls-files --others --exclude-standard)
   304  docs/** citations in agents/handoffs/**/*.md (file x path, unique)
   295  resolve at the tracked tree
     0  patterns (interior glob) — not citations, not checked
     5  resolve by UNIQUE id prefix (listed above)
     4  declared errata (listed above; each ruled, none rewritten)
     0  UNDECLARED broken citations
     0  stale errata (declared, did not fire)
     6  resolve ONLY via a not-yet-committed path (PENDING-COMMIT, above)
=== docs/** citation resolve-check: OK ===              (exit 0; script exit 0)
```

The six `PENDING-COMMIT` lines are the four original citers plus the two citations this
round's own §3.0.1/§3.2.1 text adds (`docs/reports/latency` and
`docs/reports/latency/README.md`), each naming the README as its condition. **The
`302 → 304` move is my own text and is declared, not drift**: 302 is the figure
comparable to the CI run, 304 is the figure at the sign-off SHA.

**(e) A FRESH CHECKOUT, CONSTRUCTED — this is how the "same counts a fresh clone
reports" claim was verified rather than asserted.**

```
$ git archive HEAD | tar -x -C $FC          # pristine HEAD tree
$ ls $FC/docs/reports/                       -> audit          (no latency/ — the root cause)
$ cp tools/dv_checks.sh docs/reports/latency/README.md agents/handoffs/SO-xgmii_rx_64.md  ->  $FC
$ git init -q $FC && git -C $FC add -A       # everything TRACKED, as after the commit
$ bash $FC/tools/dv_checks.sh
   397  paths git carries here            (git ls-files)
     0  further paths a commit would add  (git ls-files --others --exclude-standard)
   304  docs/** citations …
   295  resolve at the tracked tree
     0 / 5 / 4 / 0 / 0                       (glob / prefix / errata / UNDECLARED / stale)
     0  resolve ONLY via a not-yet-committed path
  The two universes are IDENTICAL at this tree (nothing uncommitted), so
  these counts are the counts a fresh clone of this commit reports.
=== docs/** citation resolve-check: OK ===              (exit 0)
```

**Identical citation counts to (d).** This is the `SC-13` form — a command executed from
a checkout rather than from a container. **Transient and declared ephemeral**
(ADR-0003/F5): the scratch trees are deleted and are not evidence anyone else can
re-open; the reproducible form is the four commands above, runnable at the commit SHA.

**(f) Negative controls, all three at the final content, all three ephemeral.**

```
NEGCTL C — the CI condition rebuilt: README removed from git AND from disk,
           the empty directory left present on disk:
  BROKEN   agents/handoffs/SO-xgmii_rx_64.md            (x3 tokens)
  BROKEN   agents/handoffs/WO-0003_testability-findings.md
  BROKEN   agents/handoffs/WO-0015_batch-d-countersign.md
  BROKEN   agents/handoffs/WO-0018_batch-de-countersign.md
     6  UNDECLARED broken citations
=== docs/** citation resolve-check: FAILED ===

NEGCTL A — one declared erratum entry deleted:
  BROKEN   agents/handoffs/WO-0077_family-k-mutation-campaign.md
     3  declared errata …
     1  UNDECLARED broken citations
=== docs/** citation resolve-check: FAILED ===

NEGCTL B — a declared key that can never fire:
  STALE ERRATUM — declared and did not fire: agents/handoffs/NOSUCH.md|docs/adr/NOSUCH.md
     1  stale errata (declared, did not fire)
=== docs/** citation resolve-check: FAILED ===
```

**A and B are last round's two controls, re-proven against the repaired resolver — the
teeth were not lost in the rebuild. C is this round's own**, and it is the one that
matters: the repaired instrument still catches the true positive, **in the exact shape
the runner saw it**, and is not fooled by the directory being present on disk.

**(g) The self-test — 21 assertions, all `ok`**, including, in a throwaway repository:
`fixture: docs/reports/latency/ is on disk, empty, untracked` · `a FILESYSTEM resolver
would answer "exists" for it` · `the TRACKED universe has no such path — git carries no
empty dir` · `so the check says MISSING for it` · `an uncommitted FILE enters the
COMMITTABLE universe` · `committable: the file resolves it` / `tracked: it does NOT yet
resolve` · `an untracked packet injects nothing into the tracked pass`. **The second
control is the anti-regression one**: it asserts that a `-e` test *would* have said yes,
so reintroducing one fails the suite rather than silently restoring the defect.

**(h) Static checks.** `bash -n tools/dv_checks.sh` → clean.
`shellcheck tools/dv_checks.sh` → **exit 0**, matching the file's pre-round baseline
(`shellcheck` on `git show HEAD:tools/dv_checks.sh` → exit 0). CI does not run
`shellcheck`; this is a local property I chose not to regress. Two `SC2016`s that the
first draft of the fixture introduced (backticks inside a single-quoted `printf`) were
removed by moving both fixtures to quoted here-documents, which is the form this file
already used.

**(i) What did not change.** `git status --porcelain` lists exactly two modified paths
and one untracked path, all three in this entry's files list. No `libs/**`, `top/**`,
`rtl_snapshots/**`, `docs/specs/**`, `docs/adr/**`, `docs/gates/**`, `.github/**` or
`test/**` path. No `git commit`, no `git push`, no `git add` against this repository, no
`dune`, no CI trigger.

### Outcome

**Both halves of the dispatch met.**

- **The resolver repair**: `tools/dv_checks.sh` resolves against the tracked tree, gates
  on the committable universe, prints `PENDING-COMMIT` for the one remaining divergence
  mode, and reproduces run `31442295998` exactly when run on that run's tree.
- **The four dispositions**: one tracked file, `docs/reports/latency/README.md`, zero
  new errata, zero rewritten packet bodies. **The `SO-`'s own citation ends this round
  RESOLVING** — verified in a constructed fresh checkout, not asserted.
- **The printed provenance moved with the counts**: the census block now prints the
  universe it measured above the citation counts and closes with whether those counts
  *are* a fresh clone's or are conditional on the commit.

**Ledger unchanged.** Items 3, 4, 6, 7, 8, 9, 11, 12 stay OWED to round 2. **State
DRAFT, §8 UNSET, no criterion adjudicated, no bar lifted, no count asserted, no anchor
claimed, no harvest taken.**

**One consequence the orchestrator should relay rather than absorb**: the commit MUST
carry `docs/reports/latency/README.md`. It is the only thing standing between the
current green and a repeat of `31442295998` — and the check now says so itself, by name,
on every run until the file is tracked.

**Handoff**: the three files below, staged-ready, trailer `Agent: dv_lead`.

**Harvest — status, not the harvest.** `SC-12` and the draft's §4 place the programme's
first dv_lead harvest at **step 10**, in the **signing** entry, over the span
`J-dv_lead-0001 … <signing entry>`. **The span stays OPEN and is not tiled here.** Four
candidates banked at this entry, continuing regime 1's sequence (`LH-cand-O` was the
last), **to be re-labelled once** at step 10 with the old label recorded beside:

- **`LH-cand-P`** — *a check that judges committed artefacts must resolve every
  reference against the version-controlled tree, never against the working filesystem;
  otherwise it measures the environment it runs in and its green is true only there.*
  **LH1**: this commit; the identical command reporting 4 on a runner and 0 in a
  container at one SHA. **LH2-g**: no proper noun. **LH3**: without it two environments
  disagree with no way to tell from inside either which is right — and the
  environment-flattering answer is the one the author sees first, so the defect surfaces
  only when somebody else runs it.
- **`LH-cand-Q`** — *a store that records only leaf objects cannot represent an empty
  container, so a namespace that must be citable needs a committed leaf inside it saying
  what the namespace is for.* **LH1**: this commit; four citations of a directory that
  existed in exactly one filesystem. **LH2-d**, domain pack **version control** —
  **not** claimed as LH2-g on purpose: the rule is only true of stores with that
  property, and stating it without naming the domain would over-generalise it into
  something false elsewhere. **LH3**: without it, a namespace agreed in governance is
  absent from every clone and every reference to it is broken while looking fine to its
  author.
- **`LH-cand-R`** — *an entry on an exception list whose expiry is already fixed by a
  scheduled obligation is not a disposition but a deferred failure with a known date;
  prefer the repair that removes the need for the entry.* **LH1**: this commit; four
  errata refused because the phase-accept gate requires an artefact at exactly the cited
  path, which would have staled all four on a scheduled date. **LH2-g**: no proper noun.
  **LH3**: without it, an exception list fills with entries guaranteed to rot and the
  staleness guard that protects the bar becomes the thing that reddens a build for
  performing a repair. **Composes with `LH-cand-L`**, which mints that guard; this one
  says when not to use the list at all.
- **`LH-cand-S`** — *an instrument that grades documents by a rule may not itself
  violate that rule; where it must, the violation is repaired rather than exempted.*
  **LH1**: this commit; the sign-off packet was one of the four citers of its own
  gate's broken path. **LH2-g**: no proper noun. **LH3**: without it a bar teaches its
  readers, by its author's own example, that it is optional — which is cheaper to learn
  than the bar. **Overlap risk declared**: step 10's walk should test it against
  `LH-cand-R` and against `(C)`'s observable before admitting both.

**Nil-yield declaration**: none — this round yields four candidates and no war story;
nothing was considered and rejected as unportable.

### Open-questions

1. **The commit must carry `docs/reports/latency/README.md`.** If it is dropped from the
   file set, CI reddens with **6** UNDECLARED broken citations — worse than the 4 that
   opened this round, because this entry's own packet text adds two more. The check
   prints the condition, so the failure mode is loud, but the dependency is real and I
   cannot stage it myself.
2. **`PENDING-COMMIT` is the last environment-dependent line in this check**, and it is
   a notice rather than a gate. I judged that correct — gating on TRACKED alone punishes
   the repair round — but it is a judgement, and the auditor may reasonably want the
   opposite for packets that are *not* repairing a citation. No carrier named; raising
   it rather than deciding it alone.
3. **Ledger item 7 (`FINDING WO-0077-A1`, the census repair's ownership) is untouched**
   by this round and stays owed to round 2. This round moved no census figure other than
   the `302 → 304` its own text causes, which is declared in (d).
4. **Round 2's inputs are unchanged and one of them moved under round 1**: `ce5674d`
   touched `docs/specs/requirements.md`, and §2.4, §5.6 and §6.3 must be written against
   that file at the sign-off SHA rather than against any earlier reading.

### Files-in-this-commit

- agents/handoffs/SO-xgmii_rx_64.md
- docs/reports/latency/README.md
- tools/dv_checks.sh
