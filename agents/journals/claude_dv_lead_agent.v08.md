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
