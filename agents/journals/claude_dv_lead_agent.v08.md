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

## [J-dv_lead-0165] 2026-08-11T01:42Z | task:none | The sign-off is executed and it says FAIL — not because the module failed anything, but because two of the fourteen conditions I wrote before I could see the result are unmet, and the harvest that was supposed to close the arc found the specification had moved under my largest table

### Trigger

Orchestrator dispatch, **sole agent in flight**, the **SO- EXECUTION, FINAL ROUND** —
steps 6 through 12 of `agents/handoffs/SO-xgmii_rx_64.md` §7.1, the order my own draft
fixed at `J-dv_lead-0161`. Steps 1–5 were paid at `J-dv_lead-0163` (base `4e7331b`)
with the resolver repair at `J-dv_lead-0164` (base `ee3da9c`).

**HEAD verified as my first action, before reading anything**: `git rev-parse HEAD` →
`2183d71834b6cd5d077c6d7059de4bd7c8fc1f82`, exactly the stated spawn-head **and the
candidate sign-off SHA**. **Match**; neither branch of the abort procedure ran, and no
disjoint commit landed during the round — `git status --porcelain` returns one modified
path at exit and it is this packet.

**The candidate is green at that SHA and I verified it rather than accepting it**:
`build` run `31444471834`, job `93635620822` `success` (all thirteen steps), job
`93635620959` `success`, `journal-check` run `31444471838` `success`, all four at
`head_sha` `2183d71`.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §5, §6, §7, §8, §10).
- `agents/handoffs/SO-xgmii_rx_64.md` **in full** — the draft is what governs this round
  and I read all fourteen criteria, the twelve-item ledger, §4's harvest design, the
  prohibition register and §7's order before measuring anything.
- `docs/gates/lessons-harvest-block.md` **in full** — §1's instantiation rules, §2's
  three-tier bar, §2.1's classifier, §3's block and its eleven checkboxes, §4's
  transcriber notes. **A `docs/` read, recorded rather than left inferable.**
- `docs/specs/requirements.md` — **REQ-901 at this SHA**, its whole (g)/(h) paragraph
  and its four change-log rows for (e)/(f)/(g)/(h); REQ-105, REQ-107, REQ-108, REQ-110,
  REQ-004, REQ-005, REQ-019, REQ-112, REQ-003. **This is the input that moved and it is
  the reason §2.4's tally does not survive.**
- `docs/specs/modules/xgmii_rx_64.md` §10 (the REQ hooks, extracted mechanically);
  `docs/specs/traceability.md` (the matrix, measured — this is where the verdict turns).
- `test/attack_plans/AP-xgmii_rx_64.md` — §0.1, §1's status vocabulary, every row table
  (status-cell pass), §4.G, §4.J, §4.L, §6's coverage map, §7's bars, `U-` register and
  bar-1 measurement block, §9's change log.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` §10 (the instance list, for gate (b)).
- `agents/handoffs/` — `BUG-0001`, `BUG-0002`, `BUG-0003` (state fields);
  `WO-0039`, `WO-0041`, `WO-0042`, `WO-0045`, `WO-0050`, `WO-0055`, `WO-0056`,
  `WO-0058`, `WO-0061`, `WO-0063B`, `WO-0066`, `WO-0073`, `WO-0074`, `WO-0076`,
  `WO-0077` (the fourteen campaigns' own tallies, walked); `WO-0078` (`RV-SWEEP` §2.3's
  seventeen-class table, §7's branch taxonomy); `WO-0002` §9 (the matrix skeleton's
  origin).
- `test/xgmii_rx_64/test_m03_j.ml`, `test_m03_l.ml`, `test_m03_f.ml`;
  `test/xgmii/test_idle_injection.ml`; `test/cosim/tb_xgmii_rx_64.v` (the bound),
  `test/cosim/stimulus_gen.ml:309`; `tools/dv_checks.sh`. **All DV artefacts, all mine.**
- **My own chain, end to end, because the harvest's span is the whole of it**:
  `claude_dv_lead_agent.md` and `.v02` … `.v08` — every harvest note at its own entry.
- **The worker journals I commissioned**: `workers/claude_tb_writer_agent{,.v02,.v03}.md`
  (bodies, for the nine candidates and the nil-yield note), `claude_data_wrangler_agent.md`,
  `claude_formal_dv_agent.md`, `claude_rtl_module_dev_agent.md` (header counts).
- **CI, as externally verifiable references**: run `31444471834` (both jobs, step
  conclusions), the `cosim` job log read for its printed blocks, run `31444471838`.

**Independence (PROTOCOL §10, charter §8). No RTL source was opened.** No file under
`libs/**`, `top/**` or `rtl_snapshots/**` was read, and no path from those trees appears
in this round's derivation chain. The RTL path in the packet's header **names the module
the verdict is about** and is not a document this round derived from.

**Git discipline.** Read-only git only against this repository — `rev-parse`,
`status`, `log`, `ls-files`, `merge-base`, `rev-list`, `grep`, `diff --stat`,
`show`. **No `git add`, no `git commit`, no `git push`, and the index was not touched.**

### Reasoning

**1. The round's shape: measure first, write second, and let the measurements decide the
verdict rather than the other way round.**

§7.1's order has three load-bearing edges and I honoured all three. 3→6: the census is
taken with the script **as it exists at the sign-off SHA**, after `RN-6`'s resolver
landed — so every `SC-1`/`SC-10` figure in the packet comes from the repaired
instrument. 2→8: `FINDING K-1`'s message repair was paid two rounds ago, so family K's
rows were written by a reader who could see what the assertion observed. 10→11: the
harvest is taken before the verdict, because it is a **precondition** of the sign-off.

**2. What re-measurement actually cost, and it is the round's justification.**

Of the figures the draft carried, three did not survive and one whole tally did not.

- **The 22-assertion breadth figure does not reproduce.** Counted under a stated rule —
  DUT-observable assertion sites in the three J units' own bodies, excluding
  stimulus-integrity sites and bench-driven read-backs — the denominator is **29**, not
  22. **The direction matters more than the number**: the carried figure *understated*
  the denominator, so the campaign's breadth was **smaller** than the plan claimed, and
  `AP-M03` §4.J's *"Five kills at four units is not breadth"* survives a fortiori.
  A carried figure that is wrong in the conservative direction is still wrong, and I
  would rather find it here than have the auditor find it in a `PASS`.
- **`FINDING M-4`'s contaminated figure moved from 140 to 141 while the honest figure
  stayed at 139.** That is the most economical demonstration of the finding I could have
  asked for: *the number that is wrong is the one that moved.*
- **`AP-M03` §7's bar-1 row (b) prints a figure its own quoted command does not
  produce** — 24 raw matches, 17 executable call sites. The **17 is right**; the command
  is not reproducible to it. This is `FINDING ECS-6`'s mention-versus-mechanism
  distinction committed inside the block that mints it, and it cost me twenty minutes of
  believing the tree had moved before `git diff e51ca52 HEAD -- test/` showed it had not.
- **And the seventeen-class tally does not survive at all**, because **REQ-901 gained
  classes (g) and (h)** — in force at `4e7331b`, corrected at `ce5674d` — between the
  sweep's reading and this SHA. **Five inside / twelve outside becomes nine inside /
  eight outside.** I re-derived every class's disposition against REQ-901's text at this
  SHA rather than adjusting the old tally: E-1 into **(g)**, E-2, E-3 and H-5 into
  **(h)**, and H-1/H-2 additionally **barred as stimulus** by REQ-901's new restriction.

**3. The direction of the (g)/(h) landing, said plainly because I countersigned it and
the flattering reading is available.**

Declaring two divergence classes **reduces** what the co-simulation can ever anchor at
this boundary: four classes moved from *"a divergence here is a defect"* into *"a
divergence here is excluded"*, and *inside an exclusion the comparison anchors nothing*
is REQ-901's own sentence. The draft's §6.3 predicted that C8 and C9 would select branch
γ and that γ lifts nothing; **the outcome is worse than γ** — they now select **β**,
which cannot even be escalated into a defect. What the landing bought is that two
behaviours are **written down** instead of unknown, plus one carve-out where an abort
still anchors: (g)'s lane-0-of-the-output-word member, **which no case has driven**.
Anyone reading the landing as an expansion of the anchor has read it backwards, and the
packet says so.

**4. The harvest, which was the largest single piece of the round and found more than a
count.**

I walked `J-dv_lead-0001` forward across all eight volumes. **The first ninety entries
yield nothing** — ADR-0018 landed 2026-08-04, my first harvest note is at `-0098`, and
every *"harvest"* string in volumes 01–02 is the **other** sense of the word, which is
ADR-0018 §7.5's own named hazard observed in my own chain. **Nil for `0001 … 0097`,
declared with its cause.**

**98 bankings walked; 3 merged; 95 distinct candidates; 94 `LC-`, one `LD-` (pack
`version-control`); 9 war stories.** The count is a product of the walk and of nothing
else — no prior figure in this chain equals 95, and none was consulted.

**Two accounting defects that no prior note names, and both are mine.** *(a)* The same
rule is banked **twice under two regimes, nine entries apart**: `J-dv_lead-0107`'s
n-values rule and `J-dv_lead-0116`'s *"malformed question"* candidate, the latter banked
as new and called *"the sharpest candidate this round"*. Merged, and the merged candidate
carries **four** incidents. *(b)* `J-dv_lead-0120` banks *"a measurement is a claim about
a tree"* as new when `J-dv_lead-0118` had already restated the census rule with exactly
that second half — and `J-dv_lead-0124` closes the loop itself by calling it *"a second
confirming instance for the set-claim rule"*. Merged, five incidents. **Both merges make
the candidate stronger, not shorter, which is why the method required both provenances.**

**And a third thing, about the war stories**: the carried set was **silently replaced,
never extended**. Through `-0103` it was `{the six-versus-seven miscount, the
operator-precedence reproduction}`; from `-0119` every note says *"both war stories"* and
means `{Idle_injection, the strike notation}`. Four further war-story-shaped items were
recorded once and never entered the carried set. **The walk recovers all nine.** Nine
refusals against ninety-eight bankings — one item in eleven, refused by its author before
any collator saw it — is where this chain's bar actually bit, and I say so because a
yield of 94 `LC-` to one `LD-` is the mirror of the block's *"all `LD-` says something
about the miner"* warning and deserves the same suspicion.

**5. THE VERDICT, and the two hours of the round I spent trying to talk myself out of
it.**

Reading §1 back criterion by criterion, **twelve are met** and the module's behavioural
evidence is the strongest in the programme. **Two are not.**

- **`SC-2`'s third clause**: *"The test-side rows of the traceability matrix are
  delivered to architect_docs_lead."* Measured — `docs/specs/traceability.md` carries
  **110 REQ rows and 110 empty `Test(s)` cells**, `Status` `OPEN` on every one, and
  `WO-0002` §9 describes the column as *"empty pending DV"* on 2026-08-02. **No dv_lead
  artefact has ever delivered those rows.** Worse than the omission: **no step of my own
  §7.1 order pays it, and it is not on §3's twelve-item ledger** — the ledger whose whole
  purpose is that nothing owed is discovered by the round that needs it. It was
  discovered at step 8, by the round being graded on it, which is `SC-11`'s own named
  failure mode quoted against its author.
- **`SC-12`**: *"the programme's first lessons harvest is complete … every box checked."*
  My half is complete and is the fullest thing in the packet. **The harvest is not**:
  PROTOCOL §7 makes it a **five-agent** act at every module sign-off, and
  `architect_docs_lead`, `rtl_lead`, `auditor` and `orchestrator` have **never harvested
  and have never been asked to**. Six of the block's eleven boxes are unchecked in
  consequence, four of them the orchestrator's own later acts.

**The escape route was available and I refused it twice.** For `SC-2` I could have
written a 34-row REQ→row table into §2.8 and declared the clause discharged —
`agents/handoffs/**` is inside my write scope and nothing mechanical would have stopped
me. **That is a deliverable manufactured inside the document graded by its existence, at
the moment the grading discovers it missing**, which is `RV-C4` §9's defect and the exact
sentence my own §0.0 quotes: *a condition whose author may discharge it by declaring it
discharged is not a condition.* For `SC-12` I could have ruled the *"every box checked"*
clause a mis-transcription of PROTOCOL §7's **gate** condition onto a **packet** — and it
**is** one, which I record as `FINDING SO-5`. But the criterion also fails on
**substance**: a first harvest that declares itself complete at one agent of five, in the
document the gate reads to decide whether the harvest happened, is the tiling rule
defeated at its first application.

**And the general form of the two failures is the same, which is the round's real
lesson**: I wrote fourteen criteria and a twelve-step order in one sitting and **never
asked, criterion by criterion, whether the order contained a step that pays it, or
whether its executor could perform it at all**. Two of fourteen failed that test. That is
banked below.

**6. What the FAIL is not, stated because the token is blunt and the routing default is
wrong here.** It is **not** a statement that the module is defective — nothing in §2
convicts the design, and §1.1 scores its evidence. It **does not route to rtl_lead**:
neither failure names anything rtl_lead can fix, so **no `BUG-` is opened and none is
owed**, and the packet says so rather than letting the default carry it to the wrong
seat. It is not an escalation (charter §7). Two bounded acts clear it — deliver the
traceability rows, and commission the other four harvests — after which the packet is
**re-issued with its verdict re-read at the new SHA**, never amended in place.

### Actions

1. **Step 6 — re-measured every set claim** with SHA, domain and polarity: the row
   census and status inventory by a status-cell pass; the suite inventory; the era
   tally by walking fourteen campaign packets; bar 1's set claim by five commands over
   both producers; the 22-assertion figure under a stated counting rule; the open-`BUG-`
   set over the directory glob; the seventeen-class tally against REQ-901 **at this SHA**.
2. **Step 7 — captured the CI evidence** at run `31444471834`: `build` job `93635620822`
   with its thirteen step conclusions, `cosim` job `93635620959` **separately**,
   `journal-check` `31444471838`; read the `cosim` job log for the S2-11 agreed-values
   print and quoted case C3's block verbatim.
3. **Steps 8–9 — wrote §1.1's read-back, §2's six measured blocks and four new sections
   (§2.8–§2.11), §3.9-M, §3.10's closed ledger, §5.8's declined sentences and §6.4's
   re-measured Stage-3 statement.**
4. **Step 10 — took the harvest**: walked the chain, re-labelled the bank once into a
   single `LC-`/`LD-` sequence in entry order with old labels beside, applied three
   merges with both provenances each, mined the worker spans, ran the classifier,
   recorded nine war stories, instantiated the block.
5. **Step 11 — wrote the verdict**, one token, after reading §1 back criterion by
   criterion against what the packet actually says.
6. **Step 12 — this entry.**
7. **Ran nothing that builds or simulates.** `tools/dv_checks.sh` was run (it is a static
   reader); `opam exec -- dune build @default` was attempted **once**, to establish for
   `SC-3` that the local half is unavailable, and it failed at library resolution as
   ADR-0005 predicts; its `_build` directory was removed and the tree is clean.

### Evidence

**(a) HEAD and tree.** `git rev-parse HEAD` → `2183d71834b6cd5d077c6d7059de4bd7c8fc1f82`.
`git status --porcelain` → **empty at entry**; at exit, exactly two modified paths, both
in this entry's files list.

**(b) The CI evidence — externally verifiable references (ADR-0003/F5), not local
artefacts.** `build` run **`31444471834`**, `head_sha` `2183d71`, run number 530,
conclusion **`success`**. Job **`93635620822`** (`build`), `success`, **13 of 13 steps
`success`** — including step 5 *Build*, step 6 *Run tests (expect tests, waveform
snapshots)*, step 8 *Verify nothing was left unpromoted or non-deterministic*, step 9
*DV mechanical checks*, step 10 *Abort-bit availability quantifier*. Job
**`93635620959`** (`cosim`), `success`. `journal-check` run **`31444471838`**, `success`.

**(c) The suite command, and why its local half is a reference and not a run.**

```
$ opam exec -- dune build @default
Error: Library "ppx_hardcaml" not found.   (docs/specs/ifc_check/dune:9)
Error: Library "ppx_hardcaml" not found.   (libs/hardcaml_ethernet/src/dune:4)
Error: Library "hardcaml" not found.       (bin/dune:3)
```

**ADR-0005 keeps the Hardcaml toolchain out of this container**, so
`opam exec -- dune runtest` cannot execute here. **This is exactly why `SC-3` makes the
run id the evidence** — the pass is run `31444471834` step 6, and the tree-clean half is
step 8 plus `git status --porcelain` returning zero lines locally.

**(d) The census, with the repaired script.**

```
$ bash tools/dv_checks.sh
   397  paths git carries here            (git ls-files)
   305  docs/** citations in agents/handoffs/**/*.md (file x path, unique)
   296  resolve at the tracked tree
     0  UNDECLARED broken citations       0  stale errata      0  PENDING-COMMIT
=== docs/** citation resolve-check: OK ===
   59  test/xgmii_rx_64/ (the M03 bench)
  139  test/**/*.ml (repository-wide, FILE-TYPE scoped — FINDING M-4)
   78  row ids declared in the plan
   62  named in a unit title — TRAILING-DIGIT BOUNDARY match
```

**The `304 → 305` step is this round's own packet text** — §6.4 adds one resolving
`docs/specs/**` citation — **declared, not drift**, and annotated beside §3.2.1's own
`+2` declaration rather than rewriting it.

**(e) The status-cell pass (SC-1), the measurement the packet quotes.**

```
$ awk -F'|' '/^\| \*\*M03-[A-Z]+[0-9]+\*\* \|/ { id=$2; gsub(/[* ]/,"",id);
      st=$(NF-1); gsub(/[* `]/,"",st); print id"\t"st }' \
    test/attack_plans/AP-xgmii_rx_64.md | sort | cut -f2 | sort | uniq -c
     62 ASSERT      7 NO-ASSERT      4 STRUCTURAL      4 NO-STIMULUS      1 GAP
```

**78 rows.** ASSERT rows **not** named in a unit title: exactly `{M03-F5}` (discharged by
citation, `test_m03_f.ml:811`). Titled rows that are not ASSERT: `{M03-A4}` in the bench
domain; `{M03-A4, M03-N3}` over every tracked `test/**/*.ml`, where the boundary matcher
returns **63** rather than 62 — **`FINDING SO-2`**, the domain rule fired against my own
census block. **Either way, 62 of 62 ASSERT rows are discharged and the outstanding set
is EMPTY.**

**(f) Attack-plan precedence (SC-1).**

```
$ git log --diff-filter=A --format='%h %ad' --date=short -- test/attack_plans/AP-xgmii_rx_64.md | tail -1
  df3e474 2026-08-02
$ git log --diff-filter=A --format='%h %ad' --date=short -- 'test/xgmii_rx_64/*.ml' | tail -1
  026a71f 2026-08-02
$ git merge-base --is-ancestor df3e474 026a71f && echo ANCESTOR ; git rev-list --count df3e474..026a71f
  ANCESTOR
  49
```

**(g) The criterion the verdict turns on (SC-2), measured.**

```
$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             if(t=="") e++} END{print n, e}' docs/specs/traceability.md
  110 110          (110 REQ rows; 110 EMPTY Test(s) cells)
```

And the coverage half, which **is** met:

```
$ awk '/^## 10\./{f=1} f&&/^## 11\./{f=0} f' docs/specs/modules/xgmii_rx_64.md \
    | grep -oE 'REQ-[0-9]+' | sort -u | wc -l        -> 35
$ awk '/^## 6\. Coverage map/{f=1} f&&/^## 7\./{f=0} f' \
    test/attack_plans/AP-xgmii_rx_64.md | grep -oE 'REQ-[0-9]+' | sort -u | wc -l -> 35
```

Symmetric difference two tokens: `REQ-010` (a cross-reference **inside REQ-014's own
cell**, not a hook) and `REQ-803` (the plan covering more than §10 hooks).

**(h) Bar 1's set claim, re-measured over both producers, in mechanism form.**
`expected_strobes` → **zero call sites outside `test/xgmii/`**;
`Injection.outcomes` outside `test/xgmii/` → **24 raw matches, 17 EXECUTABLE call sites**
in 6 files, 7 being comment mentions; outcome fields bound to a name in
`test/xgmii_rx_64` → **ZERO**; family I → **X-1(i) only**; `test/cosim` → **one
docstring line saying the model is absent**. `git diff --stat e51ca52 HEAD -- test/`
shows the six files unchanged, so **the tree did not move and the claim survives**.

**(i) The agreed-value print (`FINDING RV-0078-S2-11` redeemed), from `cosim` job
`93635620959`, case C3:**

```
frames compared: 1 / frames matching: 1 / divergences: none
agreed values (what REQ-901's comparison found EQUAL; this lane asserts no figure
  of its own -- FINDING RV-0078-S2-11)
  frame 0: decision = accept, 8 word(s), 60 octet(s)
    word 7: tkeep = 0f  tlast = 1  tuser0 = 1  octets = 38 39 3a 3b
```

REQ-104's row is written **as the pair** — this lane's agreement together with
`M03-D1`'s absolute assertion — and the log's own line says the lane asserts no figure.

**(j) The era tally, re-walked rather than quoted.** 41/40/1 → **+8/+7/+1 void** (family
M, `WO-0074` §12) → 49/47/1/0/1 → **+5/+5** (family J, `WO-0076` §12) → 54/52/1/0/1 →
**+9/+9** (family K/N, `WO-0077` §12) → **63 / 61 / 1 / 0 / 1**, and 61+1+0+1 = 63.
**Domain**: the ten class-based campaigns `WO-0050` … `WO-0077`. The four earlier
campaigns are **outside those columns** and score **15 of 15** with `D-M3` ruled an
equivalent mutant and excluded from the denominator.

**(k) The survivor, and the run at which its defect dies.** `G-c4` survived all
twenty-five units at `WO-0055` and the reason was a real coverage gap in my own plan
text: REQ-108's first epoch for a 1600-octet frame is **82 octets wide** (1518 … 1599)
and `AP-M03` §4.G's *"100 octets past the truncation point"* lands at index **1618**,
overshooting by nineteen. `WO-0056` added `M03-G7`/`M03-G8`, and the repair was proved
**by the mutation**: branch `mut/wo-0056-gc4-replay` = `c95c9f4`, the **unmodified**
`g-c4.diff`, **CI run `30852220315`**, `runtest` **RED**, **`M03-G8` the only failing
unit of twenty-seven**. **The column stays 1 and the defect is dead; neither sentence may
be quoted without the other.**

**(l) Stage-3 gate conditions, re-measured.** (a) **SATISFIED** — run `31444471834`
`cosim`, five cases `0 C1 C3 C2 C4`, all `compare_exit=0 tier=CLEAN`. (b) **UNMET** —
`CD` §10 carries C1–C4 and its §10.7 item 3 says so in terms. (c) **UNMET** — no
span-closing rule in `docs/specs/**`, and REQ-901 now **bars C9's delivered-octet
stimulus outright**. (d) **MET**. (e) **UNMET** — `test/cosim/tb_xgmii_rx_64.v:258`,
`localparam MAX_WORDS_PER_FRAME = 16`, reachable window **64 ≤ n ≤ 132**.

**(m) The harvest's own measurements.** Harvest markers per volume: v01 **0**, v02 **0**,
v03 38, v04 77, v05 29, v06 31, v07 62, v08 43. Worker span endpoints by entry-header
count: `claude_tb_writer_agent.md` **16**, `.v02.md` **18**, `.v03.md` **6** → last
header `J-tb_writer-0040`; `claude_data_wrangler_agent.md` **8**;
`claude_formal_dv_agent.md` and `claude_rtl_module_dev_agent.md` **0 each**. tb_writer
harvest notes exist at `-0021` … `-0030` **only**: **ten of forty entries**, `-0021`
declaring nil and `-0022` … `-0030` banking one candidate each.

**(n) What did not change.** No `libs/**`, `top/**`, `rtl_snapshots/**`, `docs/**`,
`test/**`, `tools/**`, `docs/gates/**` or `.github/**` path was written. No `git commit`,
no `git push`, no `git add`. No CI trigger. No `iverilog`, no `vvp`, no `dune runtest`.

### Outcome

**The dispatch's three deliverables are met, and the verdict is the one the measurements
produced.**

- [x] **The completed `SO-` packet with its verdict** — `agents/handoffs/SO-xgmii_rx_64.md`,
      State `ISSUED — EXECUTED`, §8 **`FAIL`**, signed with this entry. Twelve criteria
      MET, two NOT MET, scored row by row at §1.1.
- [x] **This signing entry**, with the exact commands and observed results above.
- [x] **Five findings minted, all mine, all against my own artefacts**: `SO-1` (MAJOR —
      the traceability delivery no step of my own order pays), `SO-2` (MINOR — the
      census block's undeclared producer domain), `SO-3` (MATERIAL — the 22-assertion
      figure superseded, 7 of 29), `SO-4` (MINOR — `AP-M03` §7 row (b)'s command does
      not produce its figure), `SO-5` (MAJOR — `SC-12` demands what its executor cannot
      do, and the harvest is one-fifth complete on substance).
- [x] **Prohibitions honoured.** No bar lifted; no class anchored; no row re-statused; no
      count carried without its three dimensions; **no sentence of the form *"the
      co-simulation anchors this module"*** — the four occurrences of that string in the
      packet are all prohibition statements, grep-checkable; the reachable-window
      sentence accompanies every 64-to-1518 citation; §5.8 lists the twelve sentences the
      packet declined to write and the bar that forbade each. **No CD edit — the tenth
      consecutive refusal. No `docs/**` byte.**

**Ledger: twelve of twelve closed** (§3.10). **Harvest: my span walked and my note
complete; the harvest itself one agent of five.**

**Handoff**: the two files below, staged-ready, trailer `Agent: dv_lead`. **The packet is
verbatim relay class** (PROTOCOL §3) — it is a sign-off now, not a draft, and the
orchestrator relays it unedited.

**Two things for the orchestrator to route rather than absorb.** **(1)** The `FAIL` does
**not** go to rtl_lead and opens no `BUG-`; it names two bounded acts — the traceability
row delivery (a dv_lead round) and the other four agents' harvests (an orchestrator
dispatch, since I spawn no one). **(2)** `P1-module-ready` is **not** satisfiable on this
packet: its precondition is per-module `SO-` **PASS**.

**Harvest — the harvest itself is at the packet's §4.4–§4.8; this is the note PROTOCOL
§7 requires in my own entry.**

**Span, as an entry-id interval**: **`J-dv_lead-0001` … `J-dv_lead-0165`.** First
harvest, so it opens at my first entry (harvest block §3 checklist, ADR-0018 §9); closed
gates are not retro-harvested. **This is NOT the *"open since `J-dv_lead-0148`"* interval
twelve of my recent notes quoted** — that is the span since the last **banking**, not
since the last **harvest**, and only one of the two tiles. Corrected at `J-dv_lead-0161`
and discharged here.

**Yield, measured by the walk and by nothing else**: **98 bankings walked (89 mine, 9 in
the worker spans I commissioned), 3 merges, 95 distinct candidates — 94 `LC-`, 1 `LD-`
(pack `version-control`) — and 9 war stories.** Every candidate is listed at its source
in the packet's §4.5 with its old label beside it; LH1 and LH3 are discharged per
candidate at the cited entry; §2.1's classifier was run on all 95 from the most general
honest statement. **Nil declared for `J-dv_lead-0001 … -0097`** (ADR-0018 postdates
them), for `data_wrangler` (8 entries, no notes) and for `formal_dv` (dormant, zero
entries).

**War stories, nine, each with the criterion it failed**: §4.6. Two retired (superseded,
folded into named candidates), seven kept and re-offerable. **Nine refusals against
ninety-eight bankings is where this chain's bar bit**, and I record it because a yield of
94 `LC-` to 1 `LD-` is the mirror of the block's *"all `LD-` says something about the
miner"* warning and deserves the same suspicion.

**Two candidates banked at THIS entry, not minted, and both are about the defect that
produced the verdict:**

- **`LH-cand-T`** — *a set of acceptance criteria and the plan that executes them must be
  checked against each other before either is issued: for every criterion, name the step
  that pays it and the party that can perform it, or the criterion is one the executing
  round will discover it cannot satisfy.* **LH1**: this commit — `SC-2`'s third clause,
  which no step of my own twelve-step order pays and which is absent from the same
  document's owed ledger, and `SC-12`'s *"every box checked"*, four of whose boxes belong
  to another party by the same document's own §4.1. **LH2-g**: no proper noun. **LH3**:
  without it, a round writes conditions it cannot meet and discovers them at the moment
  it is being graded, when the only cheap remedy left is to reinterpret the condition —
  which destroys the pre-commitment the conditions existed to create.
- **`LH-cand-U`** — *a criterion that quantifies over several parties' work cannot be
  discharged by the one party the document belongs to; write it against what its subject
  controls, or route it to the party that can close it.* **LH1**: this commit — `SC-12`
  imports a **gate** condition (*"a gate is not passed while any box is unchecked"*) onto
  a **packet**, and four of the eleven boxes are the collator's later acts while two more
  need four other agents' notes. **LH2-g**: no proper noun. **LH3**: without it a document
  carries a condition nobody can close, and it is closed either by fiat or never — the
  first hides the gap and the second stalls the gate. **Overlap declared**: composes with
  `LH-cand-T`; a later harvest should test whether one statement covers both before
  admitting each separately.

**And one candidate strengthened rather than re-minted**: `LC-…-16` (the set-claim rule)
gains a **sixth** incident here — three carried figures re-measured, three differences,
and one whole tally invalidated by a specification change under it. **The rule is not
sharpened; it is simply right, and this round is the largest bill it has ever presented.**

### Open-questions

1. **The two acts that clear the `FAIL` are not mine to sequence.** The traceability-row
   delivery is a dv_lead round I can execute on dispatch; the other four harvests are
   spawns, and I spawn no one (charter §7). **Recommendation, with its cost**: commission
   the four harvests **first** — they are the longer pole and three of the four chains
   are long — and let the traceability round ride beside them, since the two are
   disjoint in write scope. Whether the re-issued packet is this file or a successor is
   the orchestrator's call; **my recommendation is this file, re-issued with a new
   execution bullet and its verdict re-read at the new SHA**, because a successor would
   orphan every citation of `SO-xgmii_rx_64.md` already in the record.
2. **`FINDING RV-0078-S2-3`'s condition is now true and nobody owns it.** Its single
   carrier is the co-sim Phase 3 CD instance round; Stage 3 is refused on three of five
   conditions and Phase 3 does not open before this packet lands, **so the defect
   outlives the packet's active life with no owner in flight.** The draft required this
   round to check and record that; I have. It needs a carrier assignment and I have none
   to give it.
3. **Criterion 3's unexercised plural property is still unexercised and still routed to
   the auditor, unanswered** since `J-dv_lead-0159`. Run `31444471834`'s five clean cases
   did not fire it either. **I have deliberately not self-adjudicated it in the packet
   that would benefit from the answer**, and the question is now two rounds old.
4. **`FINDING SO-2`'s repair has a carrier but no schedule.** The census block should
   print the producer set beside its count; that rides the next round opening `tools/`,
   and none is scheduled. **The bound holds meanwhile**: no census figure in this packet
   is quoted without its domain.
5. **Whether a `FAIL` whose two causes are both against the DV seat should carry a
   different routing label than a `FAIL` against the design is a protocol question, not
   mine to settle.** PROTOCOL §3 and charter §7 both describe a `FAIL` as flowing to
   rtl_lead; this one does not, and I have said so in the packet rather than inventing a
   new class for it. **Raised for the orchestrator, not decided.**

### Files-in-this-commit

- agents/handoffs/SO-xgmii_rx_64.md

## [J-dv_lead-0166] 2026-08-11T01:24Z | task:none | The rows the sign-off was graded on are delivered — and building them found that the coverage map I wrote homes six of its own rows nowhere, two of them landed green units whose omission would have understated three cells

### Trigger

Orchestrator dispatch to clear **`FINDING SO-1` (MAJOR, mine)** — the finding my own
`SO-xgmii_rx_64.md` raised against its own design round at §2.8, and named as act 1 of
two at §8.2: **`SC-2`'s third clause, the test-side traceability rows delivered to
architect_docs_lead, is paid by no step of the twelve-step execution order I wrote.**
Four declared siblings in flight (auditor, architect_docs_lead, tb_writer,
data_wrangler), each appending only to its own journal; my write set this round is one
new packet and this entry.

**Head check**: spawn-head `a851948` matched `git rev-parse HEAD` exactly. No rollback,
no descendant reconciliation needed.

### Inputs

- `agents/charters/dv_lead.md` (§3 sign-off duties, §4's architect row — *"test-side rows
  of the traceability matrix"*, §6 evaluation, §8 journaling); `agents/PROTOCOL.md` (§3
  packet types and the lead-as-consumer cell, §4 grammar, §6 write scopes, §7 gates and
  the harvest, §10 independence).
- `agents/handoffs/SO-xgmii_rx_64.md` — §1's `SC-2`, §1.1's read-back row, **§2.8 in
  full** (`FINDING SO-1` and its named carrier), §2.1/§2.1-M (the census and its five
  riders), §2.3/§2.3-M (the anchor's five classes), §2.6 (`U-1` … `U-5`), §5 (the
  prohibition register, bars 1–4), §8.2 (the two acts).
- `docs/specs/modules/xgmii_rx_64.md` **§10** (the hook table — the whole spec side of
  this delivery), with §4.1, §4.3, §6.1, §6.2, §6.3, §7, §8, §9 where a hook points.
- `docs/specs/traceability.md` in full — its `How this matrix is used` rules, `Status`
  vocabulary, `Counts` block and `Open dependencies` items 1–4.
- `test/attack_plans/AP-xgmii_rx_64.md` — **§6** (the coverage map), §1 (the six-value
  status vocabulary), §2 (standing obligations), §4's row tables (`Attacks` and `Status`
  cells for all 78 rows), §0.1 (the set-claim rule).
- The suite: every `let%expect_test` title in `test/xgmii_rx_64/` (59 units) and
  `test/xgmii/test_idle_injection.ml`; `test/xgmii_rx_64/test_m03_f.ml:811` (the
  discharge-by-citation comment); `tools/dv_checks.sh` and `tools/check_emitted_verilog.sh`
  for the structural rows' instruments.
- **No `libs/**`, `top/**` or `rtl_snapshots/**` path was opened.** The derivation is
  spec → plan → suite throughout, and that is the standing proof PROTOCOL §10 asks the
  `Inputs` section to carry.

### Reasoning

**1. The refusal that made this a separate round is the reason the round exists, so it is
restated rather than assumed.** The `SO-` could have manufactured these rows inside itself
at §2.8 and asserted its own clause discharged. It refused, on `RV-C4` §9's ground — *a
condition whose author may discharge it by declaring it discharged is not a condition* —
and named a carrier instead. **This round is that carrier, and the whole value of the
refusal is that the mapping now has a reviewer who is not me.** So the packet is built for
architect_docs_lead to *check*, not to accept: every cell carries a provenance column, and
every citation is a `file:line` a reader can open.

**2. Packet class: a `WO-`, not a new prefix.** PROTOCOL §3's table already makes a lead an
admissible consumer of a work order (*"A worker **or lead**"*), and the act I need from
architect_docs_lead is a transcription into a file only it can stage. Minting a fifth
prefix for one delivery would need an ADR (§11) and buy nothing. **Rejected**: a `docs/`
report (outside my scope except `docs/reports/latency/**`, and this is not latency data);
an `SO-` addendum (the `SO-` is `ISSUED — EXECUTED` and is never amended in place); a
chat-only return (PROTOCOL §3 forbids it, and it is precisely what `SC-2` was measuring
the absence of).

**3. What derives the mapping — and the choice here is the round's most consequential
one.** Three candidate sources: (i) `AP-M03` §6's coverage map, (ii) the `Attacks` cells of
§4's 78 rows, (iii) the union. **I measured all three and took a fourth position.** The
`Attacks` relation is broader and reads worse: `M03-L5` names REQ-103 because directed
lengths necessarily extract frames, `M03-I6` names REQ-107 and REQ-108 because an injected
1518-octet frame is neither runt nor oversize — citing them under those requirements would
make one observation look like three. **So the rule is: a row is cited in the cell of the
REQ §6 homes it under, and its incidental attacks are not re-cited; §6's homing is the
tie-break.** That rule is stated in the packet (§2.2) rather than applied silently,
because a reader comparing a cell against the `Attacks` cells will otherwise find rows
missing and cannot tell design from oversight.

**4. And the rule immediately caught its own exception, which is `FINDING SO-1-A`.**
Applying "cite what §6 homes" requires knowing that §6 homes everything. It does not.
Measured over every declared row with §6's four ellipsis ranges expanded — the polarity
dimension, since the claim is that a naming **does not exist** — **six rows are reachable
by neither name nor range**: `M03-C5`, `M03-E5`, `M03-M8`, `M03-M9`, `M03-O4`, `M03-O5`.
**Two of them are landed, green `ASSERT` units.** A mechanical transcription of §6 would
have shipped REQ-103, REQ-011 and REQ-105 with landed evidence missing — **the exact
failure the matrix exists to prevent, arriving through the instrument meant to prevent
it.** The delivery homes `M03-C5` and `M03-E5` explicitly and says in the provenance
column that the homing is this round's, so nobody looks it up in a plan that does not
say it.

**5. Why the `AP-M03` §6 repair does not ride this round.** `test/**` is my scope, so this
is a choice and not a constraint. **A delivery round is not a plan round** (`J-dv_lead-0112`),
and the `SO-` made the identical call two days ago for `FINDING SO-3`'s §4.J figure. A
round that widens its own write set on discovering something is the move `RV-C4` §12
convicts, and the discovery is recorded with a named carrier — the next `AP-` opener —
which is what stops it becoming a habit. **The delivery is not blocked by the deferral**:
the cells are correct *because* the finding was measured, not in spite of it.

**6. The three tiers, and why 21 of the 34 rows stay `OPEN` with a populated cell.** The
matrix's own text says programme-invariant rows record the **system-level** test and that
*"the architect and dv_lead agree the split at the first module-ready gate"* (`Open
dependencies` item 3). **So a `COVERED` on REQ-004 or REQ-011 would be a claim about the
system that one module's bench cannot make.** Tier A (REQ-101 … REQ-113, the 13 rows M03
owns whole) takes `COVERED`; tier B (16 invariants) and tier C (REQ-802, REQ-808, REQ-810,
REQ-901, REQ-903) take `OPEN` with an `M03:`-prefixed cell. **Rejected**: inventing a
`PARTIAL` status — the vocabulary is architect_docs_lead's and extending another agent's
controlled vocabulary from inside a delivery is exactly the overreach the write scopes
exist to prevent. The packet names the 21 rows as the candidate set if the architect wants
one, and says either answer is acceptable to DV without a further round. **This packet is
also `Open dependencies` item 3's occasion**: the split it defers to the gate is proposed
here per row, so the gate ratifies a measured thing instead of negotiating one.

**7. What a traceability cell must NOT be asked to carry.** A cell is a list of names. It
cannot hold *"`M03-B3` is never ruling-9 coverage"*, *"REQ-112's zero-backpressure claim is
structural, not observed"* or *"for REQ-107 and REQ-108 a co-simulation result is not an
admissible anchor, permanently"*. **Eighteen such bounds ride with these 34 cells and every
one is already published**, so the packet restates them in a register (§5) and points the
cells at it, rather than letting a short cell be read as a wide claim. Bar 2's permanence
is stated as a property of the frozen requirement, not as a current state; no sentence of
the packet says the co-simulation anchors a requirement or this module. **`SC-7`'s
discipline is not owed by a delivery packet — I applied it anyway**, because the cells will
outlive the `SO-` in a reader's attention and they are what a later gate quotes.

**8. Form over prose, deliberately.** Only columns 6 and 7 are delivered. Reproducing
columns 1–5 would invite a paste that overwrites the architect's own cells, and a
delivery whose failure mode is *corrupting the file it feeds* is badly built. The unit
titles run to several lines each, so they are printed once in a register (§4) and the
cells carry `row-id → file:line`; the register closes its own identity — **56 cited + 3
bench-machinery units = 59** — so a reader can see nothing was dropped.

**Harvest note (ADR-0018, PROTOCOL §7): none owed, and the span is declared so the tiling
is visible.** This round is neither a module sign-off nor a phase gate. My last harvest
was taken at `J-dv_lead-0165` over the interval `J-dv_lead-0001 … -0165`; **the next span
opens at `J-dv_lead-0166` and this entry is its first member.** No candidate is banked
and no war story is recorded this round.

### Actions

- Wrote `agents/handoffs/WO-0079_m03-traceability-test-rows.md` (placeholder id; next free
  per prefix measured at `a851948`, highest landed `WO-0078`): the 34-row M03 slice as
  transcribable `Test(s)` and `Status` cells in three tiers, a 57-row unit register (56
  units plus the one discharge-by-citation comment) printing every cited title in full, an
  18-item bound register, `FINDING SO-1-A` with its measurement and disposition, and a
  four-item definition of done for architect_docs_lead.
- Measured, rather than quoted: the matrix census, the §10 hook set, the M03-owner column,
  the §6 reachability set with ranges expanded, the unit inventory, and the suite-identity
  check between the sign-off SHA and this one.
- **Touched no `docs/**` byte, no `AP-` row, no `SO-` sentence, no other agent's journal.**
  Ran no simulation and no build.

### Evidence

**All commands run from a checkout at `a851948`; every figure below is the printed
result.**

```
$ git rev-parse --short HEAD
a851948

$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             if(t=="") e++} END{print n, e}'  docs/specs/traceability.md
110 110

$ awk '/^## 10\./{f=1} f&&/^## 11\./{f=0} f' docs/specs/modules/xgmii_rx_64.md \
    | awk -F'|' '/^\| REQ-/{print $2}' | grep -oE 'REQ-[0-9]+' | sort -u | wc -l
34

$ awk -F'|' '/^\| REQ-/{if ($5 ~ /M03/) c++} END{print c}' docs/specs/traceability.md
14

$ grep -c 'let%expect_test' test/xgmii_rx_64/*.ml | awk -F: '{s+=$2} END {print s}'
59

$ git diff --quiet 2183d71..a851948 -- test/ tools/ docs/specs/ ; echo $?
0
```

**The §6 reachability measurement (`FINDING SO-1-A`), with ranges expanded** — the script
is reproduced verbatim in the packet at §6.1:

```
78 72 ['M03-C5', 'M03-E5', 'M03-M8', 'M03-M9', 'M03-O4', 'M03-O5']
```

**Self-check on the packet's own citations, run against the tree rather than trusted**:
every `file:line` in §3 resolves to a real `let%expect_test` site (58 distinct: 56 M03
units, the `test_m03_f.ml:811` citation comment which the packet marks *"not a unit"*, and
`test/xgmii/test_idle_injection.ml:168` which the packet cites as a **bound**, never as
coverage). **Register entries not backed by a unit: exactly one, `test_m03_f.ml:811`, and
it is labelled as such. M03 units absent from the register: exactly three, all in
`test_m03_structural.ml` (lines 49, 78, 110), all bench machinery, all named in §4.**

**The pass the `COVERED` recommendations rest on is an externally verifiable reference and
is marked as one (ADR-0003/F5)**: `build` run **`31444471834`**, job **`93635620822`**,
`head_sha` `2183d71`, conclusion **`success`**, all 13 steps `success`. **`opam exec --
dune runtest` cannot execute in this container** (ADR-0005 — `ppx_hardcaml`/`hardcaml`
absent), which is why the run id is the evidence; the suite-identity check above is what
carries that run's authority forward to `a851948`.

### Outcome

**DoD met.** The delivery `FINDING SO-1` named exists as a committed-ready packet with
the architect as its reviewer: `agents/handoffs/WO-0079_m03-traceability-test-rows.md`,
34 rows, 13 recommended `COVERED` and 21 `OPEN` with an `M03:` cell, 56 units cited, one
declared `GAP` carried in `traceability.md`'s own `GAP: <reason>` form (REQ-014), 18
bounds restated, one finding raised against my own coverage map with a named carrier.

**What this does NOT do, stated because it is the tempting reading**: **it does not make
`SC-2` met and it does not clear the `FAIL`.** `SC-2` is adjudicated by a re-read of
`SO-xgmii_rx_64.md` §1 at a later SHA (§8.2's closing paragraph), after **both** acts —
and act 2, the other four agents' harvests, is the orchestrator's dispatch, not mine. A
delivery is not a verdict on itself; that is the same rule this round exists because of.

**Handoff**: to the orchestrator, for packet-number allocation and dispatch to
architect_docs_lead. Return log is empty and is the architect's to fill.

### Open-questions

1. **The tier-B/tier-C `Status` question is genuinely open and I have deliberately not
   pre-empted it.** 21 rows gain M03 content while staying `OPEN`; whether the matrix
   wants a `PARTIAL` value is architect_docs_lead's vocabulary decision, and the packet
   says either answer is acceptable to DV. **If it says no, the 21 cells read as populated
   `OPEN` rows indefinitely, which is honest but invites a reader to ask why** — worth an
   `Open dependencies` sentence in its file, which is also its to write.
2. **`FINDING SO-1-A`'s repair has a carrier and no schedule** — the next round that opens
   `AP-xgmii_rx_64.md`, and none is scheduled. **The bound holds meanwhile**: the delivery
   homes the two landed rows itself and says so, so no cell is wrong while the map is.
3. **Nineteen of the 34 rows will need a second delivery, from another seat, before they
   can move.** The invariants need M20's system-level tests; REQ-810 needs M04, M18 and
   M20; REQ-802 and REQ-808 need M20. **No mechanism currently tracks a partially
   delivered row**, and the matrix's set-equality script checks row *existence*, not cell
   completeness. Raised for the architect and the gate, not decided here.
4. **`FINDING RV-0078-S2-3`, criterion 3's unexercised plural property, and `FINDING
   SO-2`'s census-domain repair are all still carried unchanged** from `J-dv_lead-0165`
   with no schedule; this round opened none of their carriers and closes none of them.

### Files-in-this-commit

- agents/handoffs/WO-0079_m03-traceability-test-rows.md

## [J-dv_lead-0167] 2026-08-11T02:55Z | task:none | The re-verdict: both acts paid, SC-2 moves to MET on a string comparison I ran against the file rather than against the report of it — and the token stays FAIL because the fifth harvest note banks eighteen rules and discharges LH3 on none of them

### Trigger

Orchestrator dispatch, sole agent in flight, no declared sibling. **The round the
`SO-` itself scheduled**: `SO-xgmii_rx_64.md` §8.2 said, in the round-2 verdict's own
words, *"When both are done, this packet is re-issued with its verdict re-read against
§1 — not amended in place. **Every** criterion is re-checked, because a criterion
satisfied by a later act is satisfied at a later SHA."* Both acts are now claimed paid:
act 1 (the test-side traceability rows) at `a43ac00` + `14615f8`, act 2 (the other four
lessons harvests) at `185ae66`, `d53d795`, `54b2553`, `c55c754`. This entry is the
re-read and the re-signature.

**Abort-first head check, before anything else.** `git rev-parse HEAD` →
`14615f8856918bfc97fe3408523f593c6d7f3467`, byte-equal to the dispatched spawn-head
`14615f8`. Exact match, so neither the `merge-base` ancestor branch nor the descendant
branch was reached. Proceeded.

**Entry id checked at the file, not taken from the dispatch.** The chain's tail at HEAD
is `J-dv_lead-0166`; R5 admits `-0167` and that is what this is. The dispatch nominated
the same id, and I checked it anyway — a stale id has been dispatched once before in
this programme (`J-orchestrator-0231`'s own recorded error) and the check costs one
`grep`.

### Inputs

- `agents/charters/dv_lead.md` in full (§3 sign-off duties and the external-anchor rule,
  §5's DoD checklist, §6 evaluation criteria, §7 escalation, §8's sign-off-entry and
  harvest-note clauses); `agents/PROTOCOL.md` in full (§3 packet classes, §4 grammar and
  §4.2 files-list equality, §5 R1–R9, §6 write scopes, §7 **gates and the lessons-harvest
  paragraph**, §10 independence and R-SEAL-1).
- `docs/gates/lessons-harvest-block.md` **in full** — §1 instantiation (including item 4,
  *"The orchestrator fills the table … and checks the boxes"*), §2's bar table with the
  two LH2 grades, §2.1's classifier, §3's eleven-box block, §4's transcriber notes
  (*"You are not the selector"*).
- `agents/handoffs/SO-xgmii_rx_64.md` — my own packet: §0.0/§0.2 (the design/execution
  separation and the three-dimension rule), §1's fourteen criteria **verbatim**, §1.1's
  round-2 read-back, §2.1-M, §2.2-M, §2.3-M, §2.8 with `FINDING SO-1`, §2.9, §2.10,
  §3.9-M, §3.10, §4.1–§4.8 with `FINDING SO-5`, §5 and §5.8, §7.2, §8.
- `agents/handoffs/WO-0079_m03-traceability-test-rows.md` **in full** — §1's domain and
  three tiers, §2.1's citation atom, §3.A/§3.B/§3.C's 34 rows (the delivered cells
  themselves), §5's bounds, §6.1's `FINDING SO-1-A`, §7's DoD, and **§8.1's return log**
  with `P-1` and `P-2`.
- `docs/specs/traceability.md` **in full at `14615f8`** — the header, the `How this matrix
  is used` rules as rewritten by the transcription, all 110 rows, `Open dependencies`.
- `docs/specs/modules/xgmii_rx_64.md` §10 (the hook table, for the domain re-derivation);
  `test/attack_plans/AP-xgmii_rx_64.md` §4's row tables (the status-cell pass).
- **The four other seats' harvest notes, each read at its own journal, in full**:
  `agents/journals/claude_auditor_agent.v02.md` `J-auditor-0019`;
  `agents/journals/claude_orchestrator_agent.v02.md` `J-orchestrator-0233`;
  `agents/journals/claude_architect_docs_lead_agent.v02.md` `J-architect_docs_lead-0034`;
  `agents/journals/claude_rtl_lead_agent.md` `J-rtl_lead-0013`. Plus, for the worker row,
  the heads of `workers/claude_tb_writer_agent.v03.md` `J-tb_writer-0041` and
  `workers/claude_data_wrangler_agent.md` `J-data_wrangler-0009`.
- `test/xgmii_rx_64/test_m03_f.ml` around lines 304–330 and 490–496 (the `P-1` check);
  the `let%expect_test` lines of every file cited by a populated matrix cell.
- CI, as **externally verifiable references** (ADR-0003/F5): `build` runs `31449924111`
  (`14615f8`) and `31447385249` (`a851948`) with their job breakdowns, and
  `journal-check` `31449924167`.
- **No `libs/**`, `top/**` or `rtl_snapshots/**` path was opened.** No RTL was read in
  this round or in the round that built the delivery it grades; the derivation chain is
  spec → plan → suite → matrix throughout (PROTOCOL §10, charter §8's independence
  clause).

### Reasoning

**1. What a re-verdict is for, and the trap it is walking into.** The previous round
failed this packet on two criteria and named one bounded act for each. Both acts were
performed. **The tempting shape of this round is therefore: confirm the two acts, flip
two rows, write `PASS`.** That shape is wrong for a reason the packet's own §0.0 states
better than I can restate it — *a condition whose author may discharge it by declaring it
discharged is not a condition* — and the risk is at its maximum precisely now, because
with `SC-2` paid there is only one obstacle left and it is cheap to argue away. So I
fixed the method before measuring: **re-read all fourteen, re-measure anything whose
subject could have moved, and verify each paid act at the artefact rather than at the
report of it.**

**2. The identity first, because it is what lets twelve rows say "unmoved" honestly.**
Eleven paths changed between the two sign-off SHAs and I listed all eleven rather than
the ones I expected. **Not one is a census producer**: `test/`, `tools/`, `libs/`,
`test/cosim/`, `docs/reports/audit/`, `docs/specs/requirements.md`, SPEC-M03 and `AP-M03`
are all byte-identical `2183d71..14615f8`. That is what makes "the census is unmoved"
a measurement rather than an assumption, and I still re-ran the census pass, because
identical inputs to a re-run cost nothing and a carried figure costs the packet its own
§0.2 rule. **Domain note**: the identity is stated over `test/` **entire** — cosim and
attack-plans included — so it is `FINDING WO-0077-A1`'s producer-domain rule applied to
the identity claim itself, not only to the counts underneath it.

**3. `SC-2`: I did not accept "34/34 transcribed, 0 refused" from anyone.** The
transcriber's return log says the cells were transcribed verbatim and that it verified
the hook set independently. **That is a report of a comparison, and a report of a
comparison is not the comparison** — the same distinction the auditor's own `-AUD-8`
banks. So I parsed both files myself on the pipe character, took the delivered
`(Test(s), Status)` pair from the packet's columns 2–3 and the transcribed pair from the
matrix's columns 6–7, and compared them as strings. **Zero mismatches.** Then the two
checks a string comparison alone would miss, both stated with their polarity: **no row
was populated that was not delivered** (measured over all 110 rows, not over the 34), and
**every row whose cell changed was empty and `OPEN` before** (measured over the diff
`c55c754 → 14615f8`, so a silently overwritten pre-existing cell could not hide). Then
the domain: re-derived the hook set from SPEC-M03 §10 rather than from `WO-0079`'s claim
about it — 35 tokens, minus `REQ-010` which lives only inside REQ-014's cell, equals the
34 delivered — and cross-checked from the other side that all 14 rows naming M03 as an
owner are present. Then the citations: 48 of 49 land on a `let%expect_test`, and the one
that does not is the discharge-by-citation comment the cell itself declares.
**`SC-2` is MET, and it is MET on five independent measurements rather than on one.**

**4. The two precisions the transcriber returned, and why re-measuring them mattered.**
`P-1` says one citation violates my own §2.1 rule. I checked it and it is **true**, and
my check found something the return did not: the id `M03-M10` is in that file, at line
324, inside the prose of a **different** unit. So the cell is substantively right (the
plan homes `M03-M10` on `M03-F2` *"ON `M03-F2` ALONE"*, and 492 is `M03-F2`'s unit) and
what is wrong is my own generalisation in `WO-0079` §2.1. **Recorded against my own text,
carrier named, cell untouched.** `P-2` is a correction to a ground, not to a
disposition, and it was written into the file that owns the vocabulary. Neither changes a
cell — which is what the dispatch said, and I checked it rather than repeating it.

**5. `SC-12`, and this is the decision the round exists to make.** Four notes landed. The
criterion asks whether the harvest is **complete**, and the block defines completeness as
eleven boxes. So I read each note at its own journal against the block's own words. Three
— auditor, architect_docs_lead, rtl_lead — are conformant, and two of them are among the
most disciplined artefacts this programme has produced: spans as intervals opening at the
first entry, LH1 and LH3 discharged on every candidate (in columns, which discharges the
box — the box asks for the discharge, not the token), grades stated, the classifier run
from step 0 with its nil-`LD-` result declared **and its cause given**, war stories with
the criterion each failed. **The fourth is not.** `J-orchestrator-0233` banks eighteen
candidates; **`LH1` appears eighteen times and `LH3` appears once — inside a war story.**
So the seat applies the criterion to the two statements it refused and to none of the
eighteen it kept. No candidate carries a stated grade; a blanket *"No `LD-`"* stands in
for eighteen classifications; the classifier is nowhere stated as run.

**Why I am not treating that as clerical, having asked myself twice.** PROTOCOL §7 does
not make LH3 a formatting preference: *"A candidate rule is **admissible only if** it
(LH1) … (LH2) … and (LH3) says what breaks without it."* Admissibility is the whole bar.
And the bar is not one I am inventing for this seat: it convicted **nine** of my own
candidates into war stories, **sixteen** of rtl_lead's, **nine** of the architect's and
**five** of the auditor's. A note that banks eighteen and refuses two, without ever
stating what breaks without any of the eighteen, has not run the bar — and if I check
that box anyway, then the bar is a function of **who** is being graded, which is the one
property a bar may not have. **The seat being graded here is the seat that dispatched
me.** That is a reason to state the finding more carefully, not a reason to soften it.

**6. What I refused to do about it, which is the other half of the ruling.** I could have
re-graded the eighteen myself: written the missing LH3 clauses, run the classifier, and
routed two or three of them to a `version-control` pack. **Refused**, on the block's §4:
*"You are not the selector … you may not improve one."* A reader who repairs another
miner's statements has silently shaped the shell without any note showing it — and I am
not even the collator. And I could not have done it anyway without writing another
agent's journal, which PROTOCOL §4 forbids outright. **So it is a finding with a bounded
repair, owned by the only seat that can perform it.**

**7. The four collation boxes, and the ruling I deliberately did not make.**
`FINDING SO-5`'s wording half stands: `SC-12` demands *"every box checked"* of a packet,
while §4.1 and the block's §1 item 4 make shell transcription, `L-` pairing,
sponsor-visibility and the completeness declaration the orchestrator's **later** acts. On
a literal reading no `SO-` can ever satisfy `SC-12`. **I considered ruling it — in either
direction — and refused both.** Ruling them *out* of the criterion while they are the
only thing left standing is the discharge-by-declaration move; ruling them *in* forever
freezes an unmeetable criterion by the same unilateral act. **Both are amendments, and an
amendment belongs in an ADR (PROTOCOL §11), raised by the round that needs it.** It is
not load-bearing today — `SC-12` fails on a box that *is* mine to check — so the honest
act is to record the question with a carrier and leave it for the round where it decides
something. **A re-verdict that finds `SO-6` paid must settle it before it can write
`PASS`.**

**8. The red run, disclosed because the packet's evidence is run ids.** Walking the runs
between the two sign-off SHAs to re-measure `SC-3`, I found `build` `31447385249` at
`a851948` — **the commit that carries round 2's own `FAIL`** — concluding `failure`. It
failed at step 4 *Install dependencies* with the test steps **skipped**, and its `cosim`
job passed. So the suite did not fail; it did not run. Nothing in the packet rests on it,
and it touches no criterion, because `SC-3`'s subject is the sign-off SHA and `a851948`
is neither round's. **But a document whose evidence is run ids owes the reader the runs
between the ones it quotes.** Otherwise the first auditor to walk this branch finds a red
conclusion at the packet's own carrying commit with no sentence anywhere explaining it,
and has to choose between re-deriving the cause and distrusting the packet. §2.9-R states
it, with its polarity: *this is a claim that a red run is not a suite failure*, measured
over every step of both jobs, not over the run's summary line.

**9. Options considered for the round's shape, and why the winner won.** (a) *Amend §1.1
in place, flipping `SC-2`'s row* — rejected: §8.2 said "re-issued … not amended in place",
and a read-back that overwrites its predecessor destroys the only evidence that the
verdict moved for a reason. (b) *Write a new `SO-` packet* — rejected: the module,
criteria and evidence map are the same, PROTOCOL §3 gives the module one `SO-` file, and
a second file would fork the merge precondition. (c) *A short delta section saying "SC-2
now MET, everything else unchanged"* — rejected: that is the carried-figure failure mode
this packet spent a whole round convicting; §0.2's SHA dimension applies to the verdict
as much as to the counts, so all fourteen are re-read at the new SHA. **(d) A `§1.2`
re-read table beside the unedited `§1.1`, section-suffixed `-R` blocks beside the
sections whose measurements moved, and one live token at `§8.0` with round 2's quoted
beneath — chosen**, because it makes the two rounds diffable against each other and
leaves every superseded sentence where its author wrote it.

### Actions

- Ran the head check; read the charter, the protocol, the harvest block, the packet, the
  delivery packet and its return log, the matrix, the spec hook table, the attack plan
  and the four seats' harvest notes.
- **Re-measured** the identity, the census, the unit inventories, the matrix, the hook
  set, the citations, the `BUG-` directory and the CI state at `14615f8`.
- **Wrote, in `agents/handoffs/SO-xgmii_rx_64.md` and nowhere else**: the header's
  State/Verdict fields and a round-3 Execution bullet; **§1.2** (the fourteen re-read,
  with the identity block that licenses every "unmoved" row); **§2.8-R** (the delivery
  and transcription, verified at the matrix, with `P-1`/`P-2` re-measured); **§2.9-R**
  (the CI evidence at the new SHA and the red run between the two); **§3.11** (the
  round's two-item ledger, the standing set re-checked, `FINDING SO-1` closed,
  `FINDING SO-6` minted); **§4.9** (the block re-instantiated, the four notes graded at
  their own journals, `FINDING SO-6`, and the refusal to rule the collation boxes);
  **§5.8-R** (six sentences declined with the bar that forbade each); **§8.0** (the
  re-issued token, its ground, its one routed act, and round 2's verdict quoted beneath
  with §8.1–§8.3 left unedited); and the §10 change-log row.
- **Wrote no `docs/**` byte, no `test/**` byte, no `tools/**` byte.** Opened no RTL.
  Edited no other agent's journal and re-graded no other agent's candidate.

### Evidence

**All commands run from a clean checkout at `14615f8`; the CI facts are externally
verifiable references (run id, job id, conclusion), marked as such per ADR-0003/F5.**

1. **Head and tree.**
```
$ git rev-parse HEAD
14615f8856918bfc97fe3408523f593c6d7f3467
$ git status --porcelain          # before my own edits
(zero lines)
```

2. **The identity the re-read rests on.**
```
$ git diff --name-only 2183d71..14615f8 | wc -l
11                                  # 2 handoffs, 8 journals, docs/specs/traceability.md
$ for p in test tools libs test/cosim docs/reports/audit docs/specs/requirements.md \
           docs/specs/modules/xgmii_rx_64.md test/attack_plans/AP-xgmii_rx_64.md; do
    [ "$(git rev-parse 2183d71:$p)" = "$(git rev-parse 14615f8:$p)" ] && echo "$p IDENTICAL"; done
test IDENTICAL  tools IDENTICAL  libs IDENTICAL  test/cosim IDENTICAL
docs/reports/audit IDENTICAL  docs/specs/requirements.md IDENTICAL
docs/specs/modules/xgmii_rx_64.md IDENTICAL   test/attack_plans/AP-xgmii_rx_64.md IDENTICAL
```

3. **SC-1 — the census, re-run rather than carried.**
```
$ awk -F'|' '/^\| \*\*M03-[A-Z]+[0-9]+\*\* \|/ { id=$2; gsub(/[* ]/,"",id);
      st=$(NF-1); gsub(/[* `]/,"",st); print id"\t"st }' \
    test/attack_plans/AP-xgmii_rx_64.md | sort | cut -f2 | sort | uniq -c
     62 ASSERT     1 GAP     7 NO-ASSERT     4 NO-STIMULUS     4 STRUCTURAL
$ awk -F'|' '/^\| \*\*M03-[A-Z]+[0-9]+\*\* \|/' test/attack_plans/AP-xgmii_rx_64.md | wc -l
78
$ git merge-base --is-ancestor df3e474 026a71f ; echo $?
0
$ git rev-list --count df3e474..026a71f
49
```

4. **Unit inventories (`FINDING M-4` re-measured, both domains).**
```
$ grep -rh 'let%expect_test' test/xgmii_rx_64/*.ml | wc -l          -> 59
$ grep -rh --include=*.ml 'let%expect_test' test/ | wc -l           -> 139
$ grep -rh 'let%expect_test' test/ | grep -c .                      -> 141   (contaminated)
```

5. **SC-2 clause (c) — the matrix, measured.**
```
$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             s=$8; gsub(/^[ \t]+|[ \t]+$/,"",s);
             if(t=="") e++; else p++; c[s]++}
     END{print n" rows: "p" populated, "e" empty"; for(k in c) print "  "k": "c[k]}' \
    docs/specs/traceability.md
110 rows: 34 populated, 76 empty
  OPEN: 97
  COVERED: 13
```

6. **The string comparison — the round's load-bearing check.** *Method, stated because it
   is not honestly a one-liner: both files are parsed on `|`; the delivered pair is
   `(col2, col3)` of every `| REQ-…` row in `WO-0079` §3, the transcribed pair is
   `(col6, col7)` of every `| REQ-…` row in the matrix; both are compared with `==` after
   whitespace-stripping only.*
```
$ python3 -c "<parse both files as above; print the four set/equality results>"
WO-0079 §3 rows: 34      traceability rows: 110      populated in matrix: 34
delivered-but-absent-from-matrix: []
populated-but-not-delivered:      []
CELL MISMATCHES: 0
COVERED set: REQ-101 … REQ-113   (exactly tier A)
$ python3 -c "<same parse over 'git show c55c754:docs/specs/traceability.md' vs HEAD>"
rows old/new: 110 110      changed rows: 34      changed-but-not-in-WO-0079: []
old statuses of changed rows: ['OPEN']      old test-cells all empty? True
```

7. **SC-2 domain — the hook set re-derived from the spec.**
```
$ awk '/^## 10\./{f=1} f&&/^## 11\./{f=0} f' docs/specs/modules/xgmii_rx_64.md \
    | grep -oE 'REQ-[0-9]+' | sort -u | wc -l            -> 35
$ comm -23 <hooks> <delivered>   -> REQ-010          (the cross-reference; nothing else)
$ comm -13 <hooks> <delivered>   -> (empty)
$ awk -F'|' '/^\| REQ-/{if ($5 ~ /M03/) print $2}' docs/specs/traceability.md | wc -l  -> 14
$ comm -23 <M03-owned> <delivered>  -> (empty)
```

8. **Citations resolve.**
```
$ python3 -c "<extract every test/**.ml:<line> from populated cells; open each; test for
              'let%expect_test' on that line>"
distinct file:line citations in matrix: 49
citations NOT landing on let%expect_test: 1
    test/xgmii_rx_64/test_m03_f.ml:811
    (* ---- M03-F5 — DISCHARGED BY CITATION, not built (WO-0047 §3.3) ----------- *)
```

9. **`P-1`, re-measured at the source.**
```
$ sed -n '492,495p' test/xgmii_rx_64/test_m03_f.ml
let%expect_test
  "M03-F2: 0, 1 and 4 octets between start and terminate, both start lanes …"
$ grep -n 'M03-M10' test/xgmii_rx_64/test_m03_f.ml      -> 324:  (prose of the unit at :304)
```

10. **SC-9 — open defects, measured over the directory.**
```
$ ls agents/handoffs/BUG-*.md | wc -l    -> 3
BUG-0001  FIX CONFIRMED (J-dv_lead-0034)
BUG-0002  ACCEPT — CLOSED at fafb83d (J-dv_lead-0089)
BUG-0003  FIX ACCEPTED — CLOSED (J-dv_lead-0103)
→ three packets, three CLOSED, NONE OPEN.
```

11. **SC-3 / SC-4 / SC-6 / SC-13 — CI at the re-verdict SHA (externally verifiable).**
    `build` run **`31449924111`**, `head_sha` `14615f8…`, run number 538, conclusion
    **`success`**; job **`93651991502`** (`build`) **all 13 steps `success`**, including
    step 5 *Build*, step 6 *Run tests*, step 8 *Verify nothing was left unpromoted or
    non-deterministic*, step 9 *DV mechanical checks*, step 10 *Abort-bit quantifier*;
    job **`93651991568`** (`cosim`) **`success`**, quoted separately and load-bearing for
    nothing outside the classes it drove. `journal-check` run **`31449924167`**,
    **`success`**. **Bound**: `opam exec -- dune runtest` cannot execute in this
    container (ADR-0005), which is why `SC-3` makes the run id the evidence.

12. **The red run between the two sign-off SHAs.** `build` run **`31447385249`** at
    `a851948`, conclusion **`failure`**: job `93644410367` (`build`) failed at **step 4
    *Install dependencies***, steps **5–10 `skipped`**; job `93644410325` (`cosim`)
    **`success`**. Runs 532–538 (`2d47871`, `185ae66`, `a43ac00`, `d53d795`, `54b2553`,
    `c55c754`, `14615f8`) are all `success`. **A dependency-resolution failure, not a
    test result.**

13. **SC-12 — the four notes, measured at their own journals.** Token counts within each
    harvest entry (entry sliced at its own header to the next `## [J-` header):

| note | banked | `LH1` occurrences | `LH3` occurrences | LH1/LH3 delivery form | classifier stated |
|---|---|---|---|---|---|
| `J-auditor-0019` | 54 | 59 | 57 | inline, per candidate | yes |
| `J-architect_docs_lead-0034` | 94 | 94-row table column | 94-row table column | table columns, verified populated on **all 94 rows** | yes |
| `J-rtl_lead-0013` | 50 | 50-row table column | 50-row table column | table columns | yes |
| **`J-orchestrator-0233`** | **18** | **18** | **1 — and it is inside a WAR STORY** | `LH1:` lines only | **no** |

```
$ python3 -c "<slice each harvest entry; count tokens>"
orchestrator (J-orchestrator-0233)  LH1=18  LH3=1  LH2-g=1  LH2-d=0  classifier=0
auditor      (J-auditor-0019)       LH1=59  LH3=57 ...
architect    (J-architect…-0034)    94-row bank table, 0 rows missing the LH1 or LH3 cell
rtl_lead     (J-rtl_lead-0013)      50-row yield table with an explicit LH3 column
```

14. **The harvest artefacts that do NOT exist, measured (polarity).**
```
$ grep -rn 'LESSONS' --include=*.md docs/ tasks/ agents/PROTOCOL.md | grep -v 'harvest'
(only ADR-0018's own description of the shell, which is another repository)
$ grep -ln 'Lessons harvest —' docs/gates/*.md agents/handoffs/*.md
docs/gates/lessons-harvest-block.md      agents/handoffs/SO-xgmii_rx_64.md
→ no collation artefact, no `L-` id, no sponsor-visible record, no completeness
  declaration exists at 14615f8. Boxes 8–11 are NOT DONE.
```

### Outcome

**DoD vs the round's own charge: met.** §1 is re-read criterion by criterion at
`14615f8`; §8 carries one token; the prior `FAIL` is preserved and quoted; the §1-readback
and §3-ledger updates the re-read required are written.

**THE VERDICT: `FAIL`. Thirteen of fourteen criteria MET; `SC-12` NOT MET.**

- **`SC-2` — NOT MET → MET.** The rows are delivered (`a43ac00`) and transcribed
  (`14615f8`), verified by string comparison at the file: 34/34 identical, 0 rows
  populated that were not delivered, 34 changed rows all previously empty and `OPEN`,
  hook set re-derived from the spec, 48 of 49 citations landing on a unit with the one
  exception self-declaring. `FINDING SO-1` **DISCHARGED** by the carrier it named.
- **`SC-12` — NOT MET, on a ground round 2 could not reach.** Four spans mined, three
  notes conformant, and `J-orchestrator-0233` banks 18 candidates discharging **LH3 on
  none**, with no stated grade and no classifier run — against PROTOCOL §7's own
  admissibility sentence. Block boxes 2, 3 and 4 cannot be checked at that row.
  **`FINDING SO-6` (MAJOR)** minted against the note, not the seat, with a bounded
  repair owned by the only agent that may append to that journal.
- **The other twelve** re-measured or re-affirmed on a byte-identical subject at a new
  run id; nothing moved.

**Handoff**: `agents/handoffs/SO-xgmii_rx_64.md`, **verbatim** relay class (PROTOCOL §3),
to the orchestrator as the merge precondition. **One act clears the remaining failure**
and it is the orchestrator's own: a successor harvest note over the span it already
walked, discharging LH3 per candidate, running the classifier from step 0, and recording
each candidate's grade. **No `BUG-` opened; nothing routes to rtl_lead; this is not an
escalation** (charter §7).

---

**LESSONS HARVEST — `SO-xgmii_rx_64` re-verdict, dv_lead's second note (ADR-0018,
PROTOCOL §7, charter §8).**

**SPAN: `J-dv_lead-0166` … `J-dv_lead-0167`.** Two entries. **It tiles exactly with my
first harvest**, whose span was `J-dv_lead-0001 … -0165` (recorded at that entry and at
`SO-` §4.2/§4.8): no gap, no overlap. **Ids follow `RULING O-1`** (`J-orchestrator-0233`):
seat-qualified, second harvest — `LC-dv_lead-H2-<n>`. My grandfathered first-harvest range
`LC-SO-xgmii_rx_64-1 … -94` and `LD-SO-xgmii_rx_64-1` are untouched and not renumbered.

**WORKER SPANS COMMISSIONED IN THIS SPAN: NIL, declared.** I commissioned no worker spawn
at `-0166` or `-0167`; both rounds were mine alone. `J-tb_writer-0041` and
`J-data_wrangler-0009` landed in this arc but are the workers' **own** first notes, taken
under a dispatch I did not issue, over spans I already mined at `SO-` §4.7 — so they are
recorded there and are not re-mined here. **A nil declared, not omitted.**

**THE YIELD — three candidates, all tier 1, each with the classifier run from the most
general honest statement.**

- **`LC-dv_lead-H2-1`.** *A map from requirements to the artefacts that satisfy them
  acquires orphans: artefacts land that the map was never updated to name. Before citing
  the map as the coverage claim, re-derive it from the artefacts themselves; the map's own
  last revision is not evidence about the artefacts.* **LH1** `a43ac00` — building the
  delivery found six plan rows homed nowhere, two of them landed, green units whose
  omission would have understated three cells (`FINDING SO-1-A`, `WO-0079` §6.1). **LH3**
  without it the coverage claim is silently short by whatever landed since the map was
  last edited, and the shortfall is invisible precisely because the map looks complete.
- **`LC-dv_lead-H2-2`.** *When a record's evidence is references to external executions,
  it accounts for the failed executions falling between the ones it cites, and says why
  each failed. A failure at the record's own point in history, unexplained, is
  indistinguishable from the failure the record exists to deny.* **LH1** `a851948` — the
  commit carrying this packet's own verdict has a red run whose failure is at dependency
  installation with the test steps skipped, disclosed at §2.9-R this round; the packet
  quoted run ids as evidence for two rounds without ever walking the interval between
  them. **LH3** without it, the first reader to walk the history finds a red result at the
  record's own commit and must choose between re-deriving the cause and distrusting the
  record — and the record's other citations lose their force with it.
- **`LC-dv_lead-H2-3`.** *A party asked to judge whether another's work meets a bar reads
  the work itself, grades the work and never the party, and — where it falls short —
  names the shortfall and the bounded repair rather than performing the repair. A judge
  who repairs the thing being judged has become its author and can no longer report on
  it.* **LH1** `d53d795` + `14615f8` — this round graded four harvest notes against an
  eleven-box bar, found one inadmissible, and refused to write the missing discharges
  itself on the bar's own *"you are not the selector"* clause. **LH3** without it the
  shortfall is absorbed silently by whoever noticed it, no record shows the bar ever
  bit, and the next round inherits an artefact that looks conformant and is not.

**MERGED, NOT BANKED — recorded so no duplicate enters the shell.** *"Verify a claim of
delivered work at the artefact, never at the report of it"* is the rule this round leaned
on hardest (§2.8-R's string comparison, and re-measuring `P-1` rather than accepting it).
**It is already banked twice**: as the auditor's `-AUD-8` at `bd7fbcf`/`8d48084`, and in
my own first harvest as the set-claim/SHA-dimension rule. **This round is a third
provenance for an existing candidate, not a fourth candidate** — offered to the collator
as a merge with both prior ids, per the merge rule that keeps every provenance.

**WAR STORIES — one, with the criterion it failed.**

| # | war story | provenance | criterion failed | why |
|---|---|---|---|---|
| **W-1** | when the last obstacle to a favourable verdict is a criterion you wrote yourself, do not rule on the criterion's wording in the same round | `14615f8` (§4.9's closing note) | **LH2-g**, marginally, and **LH3** | the honest general statement is *"do not amend a rule inside the artefact the rule grades"*, which is **already** the discharge-by-declaration rule my first harvest banked; what is left after removing the duplicate is a piece of situational judgement about timing, and nothing breaks without it that is not already broken without the parent rule. **Subsumed, kept re-offerable** |

**THE COUNT — the product of the walk and of nothing else.** Entries walked: **2**
(`-0166`, `-0167`). Candidate statements extracted: **5**. Merged into an existing
candidate: **1**. War stories: **1**. **DISTINCT CANDIDATES BANKED: 3** — all `LC-`
(tier 1, `LH2-g`), **`LD-`: 0**, no pack minted, no pack normalised. The one pack in use
across the programme (`version-control`, from my first harvest) is unchanged.

**The mirror line, applied to myself as the block's §4 requires.** A second consecutive
all-`LC-`, zero-`LD-` yield from this seat deserves the same suspicion the block aims at
an all-`LD-` one. My reading is that this round's subject matter was *conduct* — how a
verdict is re-read, how another party's artefact is graded — which carries no protocol
nouns to shed. **The place to attack this note is `LC-dv_lead-H2-2`**: if a reviewer
judges *"external executions"* to be a domain noun dressed as a general one, the candidate
belongs at tier 2 in a `continuous-integration` pack, and I would rather be told.

### Open-questions

1. **`SC-12`'s wording defect is unresolved and now blocks a future `PASS`, so it needs an
   amendment rather than a reading (ESCALATION, E-class none — an ADR request via the
   orchestrator, PROTOCOL §11).** `SC-12` demands *"every box checked"* of a **packet**;
   four of the eleven boxes — shell transcription, `LC-`/`LD-` → `L-` pairing,
   sponsor-visibility, the completeness declaration — are the orchestrator's acts **after**
   the packet lands, by §4.1 and the block's §1 item 4. On a literal reading no `SO-` can
   ever satisfy `SC-12`. **This round refused to rule it in either direction** (§4.9), and
   a re-verdict round that finds `FINDING SO-6` paid **cannot avoid it**. **Requested**: an
   ADR-0018 amendment stating which boxes a `SO-`-time instantiation must carry and which
   belong to the gate-time collation, so the criterion becomes satisfiable without any
   packet re-reading its own clause.
2. **`FINDING SO-6`'s repair is owned by a seat I cannot write for.** The successor
   harvest note over `J-orchestrator-0001 … -0232` — LH3 per candidate, the classifier
   from step 0, a stated grade per candidate — is the last **substantive** thing between
   this packet and a `PASS`; open question 1 is the other, and it is a wording defect
   needing an amendment, not a measurement. I spawn no one (charter §7) and no agent writes another's journal (PROTOCOL §4),
   so this is recorded as owed, with its content specified, and dispatched by the
   orchestrator or not at all.
3. **`P-1` leaves `WO-0079` §2.1's citation rule false at one of 49 entries.** The repair
   rides the round that fixes `AP-M03` §6's homing under `FINDING SO-1-A`; until then a
   reader following §2.1 literally at `M03-M10 → test_m03_f.ml:492` will not find the id
   in the unit and must go to the plan. **Unclosed, carrier named, and stated here so it
   is not discovered by whoever meets it.**
4. **Standing and unchanged**: `FINDING SO-2` (census producer domain), `SO-3`, `SO-4`,
   `M-4`, `RV-0078-S2-3` and the rest of §3.9's set — none of their subjects moved this
   round and none of their carriers opened. **`FINDING J-1` remains closed.**

### Files-in-this-commit

- agents/handoffs/SO-xgmii_rx_64.md

## [J-dv_lead-0168] 2026-08-11T03:35Z | task:none | The PASS: both of the things my own FAIL named were done by other seats before this round could read them, and the hardest part of the round was refusing the new ground I found while checking that they had been

### Trigger

Orchestrator dispatch, sole agent in flight, no declared sibling. **The round the previous
verdict scheduled and pre-conditioned.** `SO-xgmii_rx_64.md` §8.0.2, in `J-dv_lead-0167`'s
own words, named one substantive act and one wording question, and fixed the form of the
answer to the second in advance: *"A re-verdict round that finds `SO-6` paid must settle it
before it can write `PASS`, **and it must settle it by amendment, not by reading.**"* Both
are now claimed done — the successor harvest note at `b4814b0`, and ADR-0018 Amendment A2
at `85753b6` with its acceptance act at `41fead6`. This entry is the third read-back and
the third signature.

**Abort-first head check, before anything else.** `git rev-parse HEAD` →
`41fead67b9fa7ec22f54e807f830c0b64faefb9c`, byte-equal to the dispatched spawn-head
`41fead6`; `git status --short` returns zero lines. Exact match, so neither the merge-base
ancestor branch nor the descendant branch was reached. Proceeded.

**Entry id checked at the file, not taken from the dispatch.** The chain's tail at HEAD is
`J-dv_lead-0167`; R5 admits `-0168` and that is what this is. The dispatch nominated the
same id and I checked it anyway, for the reason `J-orchestrator-0231` recorded against
itself: a stale id has been dispatched in this programme once, and the check costs one
`grep`.

### Inputs

- `agents/charters/dv_lead.md` in full (§3 sign-off duties and the external-anchor rule,
  §5's DoD checklist, §7 escalation, §8's sign-off-entry and **harvest-note** clauses);
  `agents/PROTOCOL.md` in full (§3 packet classes and the verbatim relay rule, §4 grammar
  and §4.2 files-list equality, §5 R1–R9, §6 write scopes, §7 **gates and the
  lessons-harvest paragraph**, §10 independence and R-SEAL-1, **§11 the amendment
  procedure**).
- `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md` — **Amendment A2 in full**
  (§§A2.0–A2.9, decisions `A2-D1` … `A2-D12`), plus §§3.2, 3.4, 4.1–4.4, 7.4 and
  **A1.1–A1.5** (the two LH2 grades, the classifier as a decision procedure, `LD-`'s
  regrade and never-reuse rules, the block's third disposition) for the bar the notes are
  read against.
- `docs/gates/lessons-harvest-block.md` **in full** at `41fead6` — the preamble's line-5
  clause A2.1 convicts, §1's instantiation items, §2's bar table, §2.1's classifier, §3's
  eleven boxes verbatim, **§4's transcriber notes** (*"You are not the selector"*, and the
  third bullet obliging the hide test).
- `agents/journals/claude_orchestrator_agent.v02.md` — **`J-orchestrator-0234` in full**
  (the successor note, this round's subject), **`J-orchestrator-0233` in full** (re-read so
  the defect could be confirmed to reproduce before being called repaired), and
  **`J-orchestrator-0235`** (the acceptance act that puts A2 in force).
- `agents/handoffs/SO-xgmii_rx_64.md` — my own packet: §0.0/§0.2, §1's fourteen criteria
  **verbatim**, §1.1, §1.2, §2.1-M/§2.2-M/§2.3-M/§2.8-R/§2.9-R/§2.10/§2.11, §3.9-M/§3.10/
  §3.11, §4.1–§4.9 with `FINDING SO-5` and `FINDING SO-6`, §5 and §5.8/§5.8-R, §6.4, §7.2,
  §8.
- `test/attack_plans/AP-xgmii_rx_64.md` §4's row tables (the status-cell pass);
  `docs/specs/traceability.md` (the matrix parse); `docs/specs/modules/xgmii_rx_64.md`
  §10 (the hook table, for the identity claim); `agents/handoffs/BUG-000{1,2,3}*.md`
  (state strings).
- CI, as **externally verifiable references** (ADR-0003/F5): the branch's complete
  workflow-run list over `14615f8` → `41fead6`, and `build` run `31453108454` with its two
  jobs and their step breakdowns.
- **No `libs/**`, `top/**` or `rtl_snapshots/**` path was opened** — and `top/` does not
  exist in the tree at either SHA, which I checked rather than assumed. **No RTL was read
  in this round.** The derivation chain is spec → plan → suite → matrix throughout
  (PROTOCOL §10, charter §8's independence clause).

### Reasoning

**1. The trap this round walks into is the mirror of round 3's, and naming it first is the
only defence I have against it.** Round 3's temptation was to confirm two acts, flip two
rows and write `PASS`; it refused, and failed the packet on a box that was genuinely
unmet. **This round's temptation is the opposite**: everything the previous verdict named
is paid, so the only way to keep a `FAIL` — and a `FAIL` is the reputationally safe token
for a grader — is to find a **new** ground. One was in reach within twenty minutes of
opening the successor note. **A bar a grader may raise when the last obstacle falls is as
much a function of who is being graded as one he may lower**, and §0.0's rule cuts both
ways or it is not a rule. So I fixed the method before measuring: read every artefact at
its own source, apply the bar I published in §4.9 and no other, and record anything I find
outside that bar as an observation with an owner rather than converting it into a verdict.

**2. `SC-12`'s reading: settled by amendment, and I am careful to say I applied one rather
than made one.** Round 3 refused to rule the wording question in either direction and
routed it to PROTOCOL §11. It went the whole way: architect_docs_lead authored **Amendment
A2**, the orchestrator's `J-orchestrator-0235` is the acceptance act A2.0's own clause
requires, and A2 is in force at the SHA I am signing at. Three things about it are worth
recording because they are what make it usable by the seat it benefits. **(a) It ruled
against my diagnosis, not with it.** `FINDING SO-5` said `SC-12` had imported PROTOCOL §7's
gate condition; A2.1 measured the two sentences and found `SC-12` had imported the **gate
block's line 5**, which extended the condition to sign-offs while citing §7 for a clause §7
does not contain. The defect was in the architect's own file and the amendment says so.
**(b) It cannot flip a token.** A2.0(3) and A2.3 both state, and I re-verified, that all
three boxes round 3 failed are in **Part A** — still the packet's to check — so the
partition removes an impossibility and removes no measured failure. Applied at `14615f8` it
still yields `NOT MET`. **(c) It refused to restate `SC-12`**, explicitly leaving that to
this document (A2.3, A2.9). So §1.3 does the reading and shows four checks that it is not
the discharge-by-declaration move, the strongest being that the obligation to settle it by
amendment was written by me **when doing so cost me the token**.

**3. `SC-12`'s substance: measured at the journal, and the prior defect re-run first.**
`FINDING SO-6` convicted `J-orchestrator-0233` on three counts — LH3 discharged on none of
eighteen, no stated grade, the classifier nowhere stated as run. I re-ran round 3's counts
on that entry before reading the successor, because **a repair is only a repair against a
defect that still reproduces**, and a finding whose measurement has evaporated should be
withdrawn rather than discharged. It reproduces exactly: `LH1`=18, `LH3`=1 (inside a war
story), classifier=0. Then `J-orchestrator-0234`: eighteen numbered items, **every one
matching `<n>. LH2-g. LH3: <consequence>`**, ids `LC-orchestrator-H1-1 … -18` unrenumbered,
the classifier stated as run from step 0 twice, war stories carried with their criteria,
worker-span nil declared with cause. I read each of the eighteen LH3 clauses rather than
counting the token: every one names a concrete breakage a reviewer could recognise in
another repo — a forked numbering, a vacuous green check, a silent mis-attribution, an
unrecoverable container — not a virtue. **Boxes 2, 3 and 4 are checkable at that row and
they check.**

**4. The two-notes-over-one-span structure, and why it is not a dodge.** The harvest of
record for that seat is now a pair: `-0233` the walk, `-0234` the admissibility record. I
accept the pair because **my own repair text asked for exactly that shape** (*"a successor
note … for the same span"*, *"No renumbering"*), and because two independent artefacts read
it the same way without being asked to: **A2.7's census table** lists the seat's note as
*"`J-orchestrator-0233` (walk) + `-0234` (admissibility)"*, and **A2-D6(1)** codifies that
`<k>` counts **spans, not notes**, citing this very case as its evidence and confirming
that `H1` was correctly kept. A structure that three documents authored by two other seats
read identically is not a structure I invented to reach a verdict.

**5. `OBSERVATION SO-O1` — the new ground I found and did not use, which is the decision
this round exists to make.** The block's §4 obliges whoever fills a table to run the
hide-the-provenance test, so I ran it over all eighteen statements with a token scan.
**Two carry a version-control tool noun inside the rule statement while the stated grade is
`LH2-g`**, whose bar bars *"toolchain or library name"*: candidate 8 names
`git show HEAD:<journal>` outright, candidate 2 turns on `HEAD`, `merge-base`, `ancestor`
and `descendant`. The other sixteen carry only common version-control verbs. **Round 3
predicted this almost exactly** — *"one names a version-control command outright, two more
turn on push and merge-base semantics"* — **and in the same breath ruled what to do about
it**: *"None of that can be decided from outside the note: the classifier is run by the
miner … a reader who re-grades another seat's statements has become the selector."* **That
ruling was made when it cost nothing and it binds now that it costs something.** A2-D4
independently codified the same refusal, naming §4.9's act as the behaviour it preserves.
And the two defects differ in kind in the constitution's own words: PROTOCOL §7 makes
LH1+LH2+LH3 the condition of admissibility **at all**, so eighteen candidates with no LH3
were nothing banked and a harvest-level box failed; a **grade** decides which destination
an admissible candidate routes to, routing is a collation act, and the block's own remedy
is per-candidate — bounce at transcription, or A1.4's later-harvest regrade citing the old
id. **So: measured, named by id, given an owner (the miner) and a route (the collator's
hide test at gate-time, which A2-D3 guarantees will happen), and NOT charged.** I name no
pack and assign no grade, because naming the pack is the half of the act that would make me
the selector.

**6. What I re-measured rather than carried, and why the identity block matters more this
round than last.** Five paths moved `14615f8..41fead6` and I listed all five rather than
the ones I expected. None is a census producer — and this round I extended the identity
check to four governing documents a reader might reasonably suspect had moved under a
criterion: `agents/PROTOCOL.md`, my own charter, `docs/gates/lessons-harvest-block.md` and
the traceability matrix. **All four byte-identical.** That matters because the gate block
is still stale: A2.4's five clerical edits are owed and unlanded, so line 5 still carries
the over-reach. I state which file I read the rule from — the ADR, on the block's own
deference clause — rather than letting a reader assume I read the stale short form and got
lucky. **The one governing document that did move is ADR-0018 itself, and that move is this
round's subject**, said in the same breath as the identity so it is not buried.

**7. The CI interval, walked because I banked the rule for it last round.**
`LC-dv_lead-H2-2`, banked at `J-dv_lead-0167`, says a record whose evidence is references
to external executions must account for the failed executions between the ones it cites.
**A rule banked and not applied by its own author in the very next round is a rule nobody
has ever run.** So I walked every run on the branch in the window rather than the endpoints
— and it paid: **`85753b6` has no CI run at all**, because it was pushed together with
`41fead6` and a push event creates one run per workflow on the head commit. Nothing rests
on it and it touches no criterion, but a governing amendment landing with no green beside
it is exactly the thing a later auditor would have to re-derive. Disclosed at §2.9-R2 with
its cause.

**8. Options for the token, and why `PASS` won.** (a) *`FAIL` on `OBSERVATION SO-O1`* —
rejected at §4.10 on three grounds, the first being that round 3 pre-committed the
disposition. (b) *`FAIL` on the four collation boxes, reading `SC-12` literally* — rejected:
A2 is in force and rules that a sign-off instantiates Part A only; ignoring a landed
amendment to preserve my own prior reading would be exactly the unilateral act round 3
refused, in the opposite direction. (c) *`PASS` with the bounds folded into prose* —
rejected: `SC-14` requires everything unearned to be a **listed** bound, and a bound
mentioned in a paragraph is a bound a reader has to hunt for. **(d) `PASS` with a §1.4
re-read of all fourteen at the new SHA, a twelve-row bound list at §8.R4.4, both prior
tokens preserved and quoted, and the one observation recorded with an owner — chosen**,
because it makes the three rounds diffable against each other and leaves every superseded
sentence where its author wrote it.

### Actions

- Ran the head check and the tree check; read the charter, the protocol, **ADR-0018
  Amendment A2 in full**, the gate block in full, the packet, and the orchestrator's three
  entries `-0233`, `-0234`, `-0235` at their own journal.
- **Re-measured** at `41fead6`: the five-path identity plus four governing documents, the
  attack-plan census and precedence, the three suite inventories, the traceability matrix,
  the `BUG-` directory, the barred-sentence occurrences, the complete CI run list for the
  interval, and the LH1/LH2/LH3/classifier token counts over **two** entries of another
  agent's journal.
- **Ran the hide-the-provenance test myself** over all eighteen of the orchestrator's rule
  statements, as `docs/gates/lessons-harvest-block.md` §4 obliges — and recorded the result
  without acting on it.
- **Wrote, in `agents/handoffs/SO-xgmii_rx_64.md` and nowhere else**: the header's
  State/Verdict fields, a round-4 Execution bullet and the live signature line; **§1.3**
  (the `SC-12` reading, with the four checks that it is not a self-service); **§1.4** (the
  fourteen re-read at `41fead6`, with the identity block); **§2.9-R2** (the CI evidence and
  the whole-interval walk, including the `85753b6` hole); **§2.12** (the round-4
  re-measurement with three dimensions per claim); **§3.12** (the ledger, the new standing
  item with its carrier, the standing set re-checked); **§4.10** (the block re-instantiated
  under A2's partition, the successor note measured, `FINDING SO-6` discharged,
  `OBSERVATION SO-O1` minted and not charged, Part B's named deferral line); **§5.8-R2**
  (six sentences declined with the bar that forbade each); **§8.R4** (the live `PASS`, its
  ground, what it is not, what it owes onward, and the twelve listed bounds), with round
  3's token carried **verbatim** into a quotation so the file holds exactly one bare token;
  and the §10 change-log row.
- **Wrote no `docs/**` byte, no `test/**` byte, no `tools/**` byte.** Opened no RTL. Edited
  no other agent's journal, re-graded no other agent's candidate, and edited no prior
  round's section — §1.1, §1.2, §4.8, §4.9 and §8.0.1–§8.0.3 are untouched.

### Evidence

**All commands run from a clean checkout at `41fead6`; the CI facts are externally
verifiable references (run id, job id, conclusion), marked as such per ADR-0003/F5.**

1. **Head and tree.**
```
$ git rev-parse HEAD
41fead67b9fa7ec22f54e807f830c0b64faefb9c
$ git status --short          # before my own edits
(zero lines)
```

2. **The identity the re-read rests on.**
```
$ git diff --name-only 14615f8..41fead6
agents/handoffs/SO-xgmii_rx_64.md
agents/journals/claude_architect_docs_lead_agent.v03.md
agents/journals/claude_dv_lead_agent.v08.md
agents/journals/claude_orchestrator_agent.v02.md
docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md
$ for p in test tools libs test/cosim test/attack_plans docs/reports/audit \
           docs/specs/requirements.md docs/specs/modules/xgmii_rx_64.md \
           test/attack_plans/AP-xgmii_rx_64.md docs/specs/traceability.md \
           agents/PROTOCOL.md docs/gates/lessons-harvest-block.md \
           agents/charters/dv_lead.md; do
    [ "$(git rev-parse 14615f8:$p)" = "$(git rev-parse 41fead6:$p)" ] && echo "$p IDENTICAL"; done
test IDENTICAL 9a8871c89d36        tools IDENTICAL eebfccde25dd
libs IDENTICAL 9714f32260c5        test/cosim IDENTICAL 9c8125280a5c
test/attack_plans IDENTICAL af79ab920296
docs/reports/audit IDENTICAL 0f573595b9ef
docs/specs/requirements.md IDENTICAL 405ad8d7fb6a
docs/specs/modules/xgmii_rx_64.md IDENTICAL 333482659f8f
test/attack_plans/AP-xgmii_rx_64.md IDENTICAL 03cc7e7da6f2
docs/specs/traceability.md IDENTICAL 648311e10ccc
agents/PROTOCOL.md IDENTICAL 6bd8ade4b74b
docs/gates/lessons-harvest-block.md IDENTICAL df304360eb39
agents/charters/dv_lead.md IDENTICAL b70ef37831d9
$ git cat-file -t 41fead6:top
fatal: path 'top' does not exist in '41fead6'        # the tree has no top/ at either SHA
```

3. **SC-1 — the census and the precedence, re-run rather than carried.**
```
$ awk -F'|' '/^\| \*\*M03-[A-Z]+[0-9]+\*\* \|/ { st=$(NF-1); gsub(/[* `]/,"",st); print st }' \
    test/attack_plans/AP-xgmii_rx_64.md | sort | uniq -c
     62 ASSERT     1 GAP     7 NO-ASSERT     4 NO-STIMULUS     4 STRUCTURAL
$ awk -F'|' '/^\| \*\*M03-[A-Z]+[0-9]+\*\* \|/' test/attack_plans/AP-xgmii_rx_64.md | wc -l
78
$ git merge-base --is-ancestor df3e474 026a71f ; echo $?
0
$ git rev-list --count df3e474..026a71f
49
```

4. **Suite inventories (`FINDING M-4` re-measured, all three domains).**
```
$ grep -rh 'let%expect_test' test/xgmii_rx_64/*.ml | wc -l          -> 59
$ grep -rh --include=*.ml 'let%expect_test' test/ | wc -l           -> 139
$ grep -rh 'let%expect_test' test/ | grep -c .                      -> 141   (contaminated)
```

5. **SC-2 — the matrix, re-parsed at the new SHA on a byte-identical blob.**
```
$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             s=$8; gsub(/^[ \t]+|[ \t]+$/,"",s);
             if(t=="") e++; else p++; c[s]++}
     END{print n" rows: "p" populated, "e" empty"; for(k in c) print "  "k": "c[k]}' \
    docs/specs/traceability.md
110 rows: 34 populated, 76 empty
  OPEN: 97
  COVERED: 13
```

6. **SC-9 — open defects, measured over the directory, each string read out of its packet.**
```
$ ls agents/handoffs/BUG-*.md | wc -l    -> 3
BUG-0001  FIX CONFIRMED
BUG-0002  ACCEPT — CLOSED
BUG-0003  FIX ACCEPTED — CLOSED
-> three packets, three CLOSED, NONE OPEN.
```

7. **SC-3 / SC-4 / SC-6 / SC-13 — CI at the sign-off SHA (externally verifiable).**
   `build` run **`31453108454`**, `head_sha` `41fead67b9fa…`, event `push`, conclusion
   **`success`**; job **`93661268366`** (`build`) **all 13 steps `success`** — 5 *Build*,
   6 *Run tests (expect tests, waveform snapshots)*, 7 *Generate RTL*, 8 *Verify nothing
   was left unpromoted or non-deterministic*, 9 *DV mechanical checks*, 10 *Abort-bit
   availability quantifier* among them; job **`93661268386`** (`cosim`) **`success`**, its
   nine steps all `success`, quoted separately and load-bearing for nothing outside the
   classes it drove. **`journal-check` run `31453108435`, `success`.** **Bound**:
   `opam exec -- dune runtest` cannot execute in this container (ADR-0005), which is
   exactly why `SC-3` makes the run id the evidence.

8. **The whole CI interval, walked (`LC-dv_lead-H2-2` applied to its own author).**
```
5d50ab7   build 31451461231 success   journal-check 31451461221 success
b4814b0   build 31451519563 success   journal-check 31451519546 success
85753b6   NO RUN OF ANY WORKFLOW EXISTS  (pushed together with 41fead6; a push event
                                          creates one run per workflow on the head commit)
41fead6   build 31453108454 success   journal-check 31453108435 success
-> 0 red conclusions on build or journal-check anywhere in the interval, measured over
   the branch's complete run list. The two `cancelled` site-deploy runs in the same
   listing (d53d795, 185ae66) are BEFORE 14615f8 and outside this window.
```

9. **SC-12 — the successor note, measured at the journal (the round's load-bearing check).**
   *Method: each entry is sliced at its own header to the next header line; tokens counted
   over the slice; the numbered candidate items matched on the pattern shown.*
```
$ python3 -c "<slice each entry; count tokens; match numbered items>"
J-orchestrator-0233:  LH1=18  LH3=1   LH2-g=1   classifier=0
                      numbered candidate statements = 18 ; 'LH1:' labels = 18
                      -> round 3's measurement REPRODUCES; the defect was real and is real
J-orchestrator-0234:  LH1=2   LH3=21  LH2-g=19  classifier=4
                      items matching '^\s*\d+\. (LH2-[a-z]+)\. (LH3:)'  -> 18
                      ids present 1 … 18, none missing, none duplicated
                      -> 18/18 stated grade AND 18/18 LH3 clause
```

10. **`OBSERVATION SO-O1` — the hide test, run over all eighteen statements.**
```
$ python3 -c "<split -0233's yield into its 18 numbered items; scan the statement text
              (everything before the LH1: label) for version-control tool nouns>"
 2: ['HEAD', 'ancestor', 'descendant', 'merge-base']
 8: ['HEAD', 'git']
 1,4,5,6,9,11,15: common verbs only (commit/diff/push)
 3,7,10,12,13,14,16,17,18: none
-> 2 of 18 statements carry a TOOL noun under a stated LH2-g. Recorded, owner and route
   named, NOT charged (SO- §4.10). No grade assigned; no pack named.
```

11. **The packet's own mechanical claims, checked after writing it.**
```
$ grep -c '^# \(PASS\|FAIL\)' agents/handoffs/SO-xgmii_rx_64.md      -> 1   (# PASS)
$ grep -c '^> *> *# \(PASS\|FAIL\)' agents/handoffs/SO-xgmii_rx_64.md -> 2  (rounds 3, 2, quoted)
$ grep -ci 'co-simulation anchors this module' agents/handoffs/SO-xgmii_rx_64.md -> 4
   all four inside a statement of the prohibition itself (§0.1 item 2, §1.1's SC-6 row,
   §1.2's SC-6 row, §5.1 item 1); round 4 added none.
```

### Outcome

**DoD vs the round's own charge: met.** §1 is re-read criterion by criterion at `41fead6`;
`SC-12`'s reading is settled at §1.3 by applying a landed amendment rather than by making
one; §8 carries one token; both prior `FAIL`s are preserved and quoted; the harvest block
is re-instantiated under A2's partition and its Part A is checked box by box.

**THE VERDICT: `PASS`. Fourteen of fourteen criteria MET.**

- **`SC-12` — NOT MET → MET.** Read against the block **as amended by A2** (in force at
  this SHA on `J-orchestrator-0235`): a sign-off instantiates **Part A's seven boxes**,
  Part B is a named deferral line to `P1-module-ready`. **All seven CHECKED.** The three
  that failed at round 3 are all Part A and are paid by `J-orchestrator-0234` (`b4814b0`) —
  18/18 stated grade, 18/18 LH3, classifier stated as run from step 0, ids unrenumbered.
  **`FINDING SO-6` DISCHARGED** by the carrier it named. **`FINDING SO-5`'s wording half
  SETTLED BY AMENDMENT**; its substantive half is untouched by A2 and re-verified.
- **The other thirteen** re-measured or re-affirmed on byte-identical subjects at a new run
  id; nothing moved.
- **Twelve bounds are listed inside the `PASS`** at §8.R4.4, `SC-14`'s own requirement —
  the undischarged module-level anchor, the structural backpressure discharge, the single
  mutation survivor, the declared `GAP`, the five unreachable instruments, Stage 3's
  refusal, the 76 empty matrix rows, five unrepaired findings, the uncollated Part B,
  `OBSERVATION SO-O1`, and the thirty unmined worker entries.
- **One observation minted and deliberately not charged**: `OBSERVATION SO-O1`, measured,
  owned by the miner, routed to the collator's gate-time hide test.

**Handoff**: `agents/handoffs/SO-xgmii_rx_64.md`, **verbatim** relay class (PROTOCOL §3),
to the orchestrator as the merge precondition. **The packet's DV rows are now supplied to
`P1-module-ready` as satisfied.** No `BUG-` opened; nothing routes to rtl_lead; this is not
an escalation and it is not a gate decision (charter §7, §0.3).

---

**LESSONS HARVEST — `SO-xgmii_rx_64` round 4, dv_lead's third note (ADR-0018 as amended by
A2, PROTOCOL §7, charter §8).**

**SPAN: EMPTY. NIL YIELD, DECLARED.** **The convention is stated, as `A2-D12` requires a
note to state it**: I use **`A2-D10`**, in force at this SHA — *"A harvest's span ends at
the last entry before the note that carries it, and every later span opens at the first
entry not already inside a mined span."* My two landed notes mined `J-dv_lead-0001 …
-0165` (note `-0165`) and `-0166 … -0167` (note `-0167`), both with the inclusive end that
`A2-D12` grandfathers. So the opening is **`-0168`** and the end is **`-0167`** — **the
interval is empty, and there is nothing to mine.** Declared rather than omitted, because a
skipped harvest and a nil harvest are indistinguishable in silence and the tiling rule is
the only instrument that tells them apart.

**CUMULATIVELY, THIS SEAT HAS MINED `J-dv_lead-0001 … -0167`, no gap and no overlap**, and
**the next harvest opens at `-0168`** — this entry, which cannot be mined by the note it
contains (`A2-D10`'s own second reason). That is not a technicality here: this round's
reasoning is the substantive material a later harvest would want — how a verdict behaves
when the last obstacle falls, and what a grader does with a defect that is real and outside
the bar he published. **It is left for a miner who can read it finished.**

**WORKER SPANS COMMISSIONED IN THIS SPAN: NIL, declared** — vacuously, the span being
empty, and substantively: I commissioned no worker spawn in this arc.

**YIELD: NIL.** **`LC-`: 0. `LD-`: 0. War stories: 0. No pack minted, no pack normalised.**
The one pack this programme has in use (`version-control`, from my first harvest) is
unchanged, and **no total is quoted here that was not produced by this walk** — the walk
being over an empty interval, which is the honest reason the totals are zero rather than
small.

**ONE LINE THE BLOCK'S §4 ASKS FOR WHEN A YIELD LOOKS ODD.** A nil is worth the same
suspicion as an all-`LD-` yield. **My reading is that this is structural rather than
substantive**: two of my notes landed within the last three entries of this chain, so the
unmined interval had no room to contain anything. **The signal to watch is a nil declared
over a span that is not empty** — that would say something about the miner. This one says
only that the previous note was recent.

### Open-questions

1. **`A2.4`'s five clerical edits to `docs/gates/lessons-harvest-block.md` are OWED and
   unlanded**, so at `41fead6` the block's line 5 still carries the clause A2.1 convicts,
   still citing PROTOCOL §7 for it. **Carrier: the architect's next `docs/gates/` round**
   (the `P1-module-ready` checklist round already owed; `J-orchestrator-0235` records the
   two items sharing one carrier). **Not mine** — `docs/gates/**` is outside my write scope
   — and I read the rule from the ADR on the block's own deference clause, saying so at
   §1.3 rather than letting a reader assume. **Recorded because a reader of the block alone
   will meet the stale sentence and should not have to re-derive why it does not govern.**
2. **`OBSERVATION SO-O1` is live and owned elsewhere.** Two of `J-orchestrator-0234`'s
   eighteen candidates carry a version-control tool noun under a stated `LH2-g`. **I do not
   contest the grade and I have not re-graded it**; the route is the collator's own
   hide-the-provenance test at gate-time transcription (block §4) with `A1.4`'s
   later-harvest regrade as the instrument. **`A2-D3` guarantees the site exists**: the
   gate re-checks Part A over its own spans. Stated here so that if the collator's test
   agrees with me, nobody has to discover that a dv round saw it and said nothing.
3. **I raise no contest against Amendment A2**, and I say so rather than leaving silence to
   be read either way. A2.0 names the contest route — a finding in the contesting seat's
   own artefact, carried to an Amendment A3 — and states that a contest does not suspend
   A2. **The partition is the four-and-seven I requested, its diagnosis is better than the
   one my own finding offered, and it left the five-seat obligation and every LH criterion
   untouched.**
4. **Part B of the harvest is the only half of `SC-12`'s subject that no packet can carry**,
   and it is unstarted at `41fead6`: no `L-` id in any artefact, no shell commit, no sponsor
   sight, no completeness declaration. **Carrier: the orchestrator as collator at
   `P1-module-ready`**, one shell commit **per harvest** (`A2-D5`). Listed as bound 10 of
   the `PASS`.
5. **Standing and unchanged**: `FINDING SO-2` (census producer domain), `SO-3` (the
   22-assertion figure; measured 7 of 29), `SO-4` (`AP-M03` §7 row (b)), `M-4` (141 vs
   139), `P-1`'s residue (`WO-0079` §2.1 false at 1 of 49 citations) and the rest of §3.9's
   set — **none of their subjects moved this round and none of their carriers opened**, and
   **none is closed by this `PASS`.** `FINDING J-1` remains closed.

### Files-in-this-commit

- agents/handoffs/SO-xgmii_rx_64.md

## [J-dv_lead-0169] 2026-08-11T05:55Z | task:none | The transmit era opens with the receive era's rules already inside its plan — and the converse-homing rule I carried forward convicted its author twice before the commit, once on five unhomed rows of my own draft and once on a check that broke by being quoted

### Trigger

Orchestrator dispatch, with a **declared sibling** (rtl_lead, which implemented M06
`Eth_axis_rx` at `0753735` and whose write set is `libs/**` plus its own journal —
disjoint from mine). Two acts in one round: **Act 1**, the M04 attack plan, whose
qualification era opens with it; **Act 2**, the three owed repairs that named *"the next
round opening `AP-M03`"* as their carrier, which is this round.

**Abort-first head check, before reading anything.** `git rev-parse HEAD` →
`1968bea1332135a60e5968a124d00822d0c2e4c1`, byte-equal to the dispatched spawn-head
`1968bea`; `git status --short` returned **zero lines**. Exact match, so neither branch of
the abort procedure was reached.

**Entry id checked at the file rather than taken from the dispatch.** The chain's tail at
HEAD is `J-dv_lead-0168`; R5 admits `-0169` and that is what this is. The dispatch
nominated the same id and I checked it anyway, for the reason this programme recorded
against itself once: a stale id has been dispatched here before and the check costs one
`grep`.

**Incident seven, and what I did about it: nothing, deliberately.** The dispatch records
that a prior spawn of this round died in a worker restart mid-write, that its partial was
preserved **outside** the repo and the tree cleaned. I did not look for it and did not
reconstruct from it. The tree at `1968bea` is the whole of my input; a partial I cannot
see at a SHA is not evidence, and reading one would have made every derivation below
unciteable.

### Inputs

- `agents/charters/dv_lead.md` in full (§3's attack-plan mandate and the external-anchor
  rule, §5's DoD checklist — including the rx-path stress line that M04 is **not** in —
  §6's write scope, §8's attack-table and harvest clauses); `agents/PROTOCOL.md` in full
  (§3 packet classes, §4 grammar and §4.2 files-list equality, §5 R1–R9, §6 scopes, §7
  gates and the harvest paragraph, §10 independence and R-SEAL-1).
- **`docs/specs/modules/xgmii_tx_64.md` (SPEC-M04) in full** — all thirteen sections,
  including §11's five deferred items and §13's five change-log rows (C-14.1, C-14.2,
  C-14.5, C-16, C-31). Frozen `f78766e`, my own countersignature `J-dv_lead-0005`.
- `docs/specs/requirements.md` — **§0.3 in full** (the frame-length and gap conventions and
  the *Against deficit idle count* paragraph, whose receive and transmit halves are one
  paragraph apart and describe opposite behaviours), **§0.5 in full** (octet time, the
  front offset `h`, the word delay ΔC, the deciding input word `D`, the causality test, the
  straddle and late-decision tests, and what a latency monitor may demand), §0.6's window
  and reference-word clauses, §0.7, §9.1, §11, **REQ-201 … REQ-210 verbatim**, REQ-901
  **whole** (its configuration clause and all eight lettered divergence classes), and the
  §13 rows for `SCR-M03-I4` and its re-ruling.
- `docs/specs/modules/axi64.md` (SPEC-M01) §6.1's `tkeep` rules and §6.3 item 5's
  don't-care positions; `docs/specs/architecture.md` §4's inventory row for M04 (counterpart
  `axis_xgmii_tx_64.v`, REQs 201–210) and §5's deviations table with its provenance note.
- `test/attack_plans/AP-xgmii_rx_64.md` — §0/§0.1, §1, §2, §3, §4.A, §4.I (the M03-I4 and
  M03-I5 cells whole), §4.M's M03-M10 record, §5, §6 whole, §7's banner (the `WO-0077-A1`
  census rule, `RV-0078-S2-13`'s polarity rule, bar 1's four lift cells and X-1's row) and
  §9's change log.
- `agents/handoffs/SO-xgmii_rx_64.md` — §2.8-R whole (the `P-1` and `P-2` precisions),
  §3.9's standing table, §4.5's yield table, §4.6's war stories.
  `agents/handoffs/WO-0079_m03-traceability-test-rows.md` — §2.1, §2.2, §2.3, §3's tiers,
  §6.1 (`FINDING SO-1-A` whole), §8.1, §9.
  `agents/handoffs/BUG-0002_…md` — the *"Two of my own attack-plan cells are now FALSE"*
  section and the countersignature block's point 4.
- `agents/journals/claude_architect_docs_lead_agent.v02.md` — `J-architect_docs_lead-0024`'s
  closing bullets (the carry-forward that made the §4.I cells mine) and `-0025`'s owed
  items; `…v03.md`'s ledger rows 30 and 32 at their three restatements.
  `agents/journals/claude_rtl_lead_agent.v02.md` — **`J-rtl_lead-0015` §5 in full**, the
  sibling's straddle note, read for where frozen specs and §0.5 diverge.
- `docs/adr/ADR-0018…` §A2's decisions `A2-D10` … `A2-D12` (the span convention, read to
  decide whether a harvest note is owed at this round).
- **The machinery surfaces, read to answer §7's capability questions by measurement rather
  than by inference**: `test/xgmii/tx_decoder.mli`, `test/golden/crc32_ref.mli`,
  `test/xgmii/frame.mli`, `test/monitors/octet_time.mli`, `test/axi64_probe/axi64_driver.ml`,
  `test/cosim/canonical.mli`, `test/cosim/dune`, `tools/` and `tools/cosim/` listings,
  `.github/workflows/build.yml`'s `cosim` job, and a **listing** of
  `test/third_party/verilog-ethernet/` with `PROVENANCE.md` read in full.
- **No `libs/**` and no `rtl_snapshots/**` path was opened**; `top/` does not exist at this
  SHA, which I checked rather than assumed. In particular
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` exists and **was not read** — the module this
  plan attacks has been implemented since `WO-0024` and the plan is derived from SPEC-M04
  alone (PROTOCOL §10). **The two vendored `.v` files were not opened either**, for a
  different reason: the module this boundary would compare against is not among them.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

**1. What a first attack plan for a transmit module is, and why it is not `AP-M03` with the
arrows reversed.** The M03 plan's spine is a *receive* spine: a wire arrives and cannot be
slowed down, the module's output is an `Axi64` stream, the protocol monitor watches that
stream, REQ-016 permits idles inside a frame and family I is built on them. **Every one of
those four is false at M04.** The output is not a stream but a lane pair that carries a
value on every cycle; the stream monitors therefore do not apply and the standing
obligation that replaces them is the **wire decoder**; the module sets its own pace, so the
line-rate invariant has no instance and §8 says so in terms; and **REQ-016's idle tolerance
does not extend to this interface at all** — a missing word on a required cycle is an
*underflow*. So the largest family in `AP-M03` (I, idle injection, and the whole
`SCR-M03-I4` apparatus behind it) has **no counterpart** here, and the largest family in
`AP-M04` is **G**, which asserts the opposite thing: that the module does *not* tolerate the
gap. I wrote that asymmetry into §6's REQ-016 line rather than leaving it to be inferred,
because the natural error is to port family I across and discover at the first red that the
specification forbids it.

**2. The identity, derived once, that four families rest on.** With the preamble occupying
exactly one word and frame octet 0 in lane 0 of the next, frame octet `i` is at lane
`i mod 8` of cycle `C + 2 + ⌊i/8⌋`; the terminate character is at octet index `F` and
therefore lane `F mod 8`; and the next start character is `g = ⌈(cfg_ifg + t)/8⌉` words
after the terminate word, an actual gap of `8g − t`. **I checked it against §6.1's own
cycle table at the one length that table states** — `P = 60` gives `t = 0`, terminate at
`C + 10`, `g = 2`, next start at `C + 12`, gap 16, spacing 11 — and every one agrees. That
cross-check is the whole of the corroboration the specification offers, and §4 says so
rather than presenting the formulae as self-evident.

**3. The identity is what makes two rows non-arbitrary, and both would have been sampled
otherwise.** §10's REQ-205 hook says *"frame lengths placing the terminate character in
each of the eight lanes"* and does not say which lengths. From the identity they are
`F ∈ {64 … 71}`, i.e. `P ∈ {60 … 67}` — **derived, not chosen**. And the same sweep is
where the gap convention is decided: I worked §0.3's rejected reading (twelve *idle* octets
*after* the terminate character) against this specification's (twelve *from it inclusive*)
at every residue, and **they agree at seven of the eight and differ only at `t = 4`**, where
this specification gives 12 octets and the rejected reading gives 20. **A bench that samples
that sweep has a seven-in-eight chance of missing the one member that distinguishes the two
conventions**, and §6.1's own numbers — *"16 octets for t = 0 and 12 octets for t = 4"* —
name that member without saying why it is the interesting one. M04-F2 says why.

**4. `FINDING AP-M04-1`, and it is the round's substantive find.** REQ-210 opens *"Measured
per octet in octet times (§0.5)"* and then names two **events** — the acceptance handshake
and the word whose lane 0 carries `/S/` — which SPEC-M04 §7 pins at **1 cycle = 8 octet
times**. But §0.5's per-octet latency is (output octet time) − (input octet time) **for the
same octet**, and frame octet `j` enters at `8C + j` and leaves at `8C + 16 + j`: **`L = 16`
octet times, for every frame octet of every frame at every length.** Both figures are
constants; they are different constants; and **a monitor built from REQ-210's opening clause
together with §7's pinned value asserts 8 per octet and fails a conformant M04 at every
octet.** That is `SCR-M03-I4`'s shape at a new module — a monitor built from a sentence no
conformant design can satisfy — reached this time **from the specification's side, by a
plan, before a bench existed to go red**, which is exactly what §0.5's own *"checkable by
arithmetic at spec freeze"* clause promises and did not deliver here. The second half is
narrower and may be answered separately: §0.5's front offset `h` is defined as *octets the
module removes from the front*, and M04 **removes none and prepends eight**, so ΔC's
*"first output word for a frame"* is ambiguous at a prepending module — the preamble word is
a word M04 emits for the frame that carries none of its octets. **I routed both and decided
neither**, and M04-J1/J3 are written so that nothing moves on the ruling: J1 asserts the
event delay, which is exact and unambiguous because §7 names both events, and J3 reports 16.

**5. Where the sibling's entry sharpened this.** `J-rtl_lead-0015` §5 records SPEC-M06 §7
and §10 still carrying the retired per-octet-under-injection reading that requirements.md
§0.5 replaced, and names the failure mode: a worker building from the frozen spec end to end
builds to a sentence describing something no straddling module can do. **The class is the
same one I found at REQ-210, one document up.** What differs is the direction: M06's is a
*module* spec still carrying a claim `requirements.md` retired, and M04's is
`requirements.md` itself naming a measurement its own §7 does not pin. Reading rtl_lead's
note is what made me check REQ-210's opening clause against §0.5's definition instead of
against §7's number, which is where the two agree and the finding hides.

**6. The co-simulation posture, and why it is a bar in the plan's first commit rather than a
caveat in its ninth.** Charter §3 and PROTOCOL §10 make differential co-simulation a
**precondition of Phase 1 MAC sign-off**, and M04 is a MAC module — so the state of that
lane is a gate condition on this module's `SO-`, not a footnote. I measured its three
components rather than assuming any: (a) `test/third_party/verilog-ethernet/` holds exactly
four files and `axis_xgmii_tx_64.v` is **not** among them, and `PROVENANCE.md`'s own rules
make adding it a separate vendoring commit; (b) the only `iverilog` caller builds an
RX testbench against M03, and `canonical.mli`'s **pinned** grammar is a per-word AXI-stream
record — `tkeep`, `tlast`, `tuser0`, `octets` — **none of which a lane pair has**, so a TX
canonical form is a new grammar and not a re-use; (c) REQ-901's lettered classes are
entirely M03's and the upper stack's, and its own rule forbids citing a class not listed
there. **Then I did the thing the M03 era learned to do late**: I wrote down what the anchor
*would* and *would not* see if all three were paid, so that the claim is pre-refuted rather
than argued over later. It would see octets, padding, the FCS and its order, the terminate
lane and the gap in octets — **and this is the one Phase-1 boundary where the anchor could
see length logic at all**, since classes (e) and (f) exclude it at M03 precisely because the
receive reference has none. It would **not** see the strobe (REQ-901 compares no strobes),
any cycle (REQ-901 excludes cycle alignment and latency constants by name), or `tx_tready`
(a handshake is not an output frame). **So even a fully opened lane leaves REQ-206,
REQ-207's handshake half, REQ-209 and REQ-210 bench-only**, and BAR T1 says so before anyone
can promise otherwise.

**7. On the length-logic claim I could not measure, and how I marked it.** The statement
that the transmit reference has `MIN_FRAME_LENGTH`, `ENABLE_PADDING` and `ENABLE_DIC` comes
from `architecture.md` §5's provenance note and from REQ-901's class (e) text, both written
by the architect from a file read on 2026-08-01. **That file is not in this tree and I did
not fetch it.** §0.1(i) obliges the difference between a record and a measurement to be
marked, so the cell says the claim is carried *at the strength of that record*. This is the
smallest of the round's disciplines and the one most likely to have been skipped, because
the claim is almost certainly true.

**8. The three repairs, and what each turned out to be.** (a) `FINDING SO-1-A`'s §6 homing:
six rows, seven cells, each gaining a **dated appended** homing with the original list left
standing, plus a new §6.1 that states the **converse rule** — a REQ with no row carries the
reason, *and a row with no REQ line carries its home* — and homes `M03-O5`, which no REQ can
reach because it constrains the plan rather than the design. (b) The §4.I cells carried
since the `-0024` ruling: **both were staler in metadata than in substance**, and saying so
is the honest report rather than dressing a citation fix as a repair. M03-I4 called
`FINDING F-1` *outstanding* when it was discharged at `d54c931`; M03-I5 cited §0.5 at
`a77017c` alone where its sibling has carried the `1f3c04c` re-ruling since
`J-dv_lead-0086`. Both substantive claims were already right, and **I refused to re-assert
M03-I4's three-class latency table** while correcting the status beside it: §0.1 binds its
own author, and a status repair is not a licence to re-affirm a set claim it did not
re-measure. (c) `P-1`: §2.1's rule is false at one citation because it **generalised from
the common case and failed to carry §2.2's own exception** — its immediate neighbour — into
its own words. The precision is appended as §2.1-P in this round's voice; not one cell of
§3 moves and `docs/specs/traceability.md` is untouched, because the transcription was never
at fault.

**9. And measuring `P-1`'s reach found a second dimension the finding did not state.** The
literal rule is false at **one of 49 distinct citations** — the figure `SO-` §2.8-R
measured — **and at two of the 110 citation atoms**, the two whose row id is `M03-M10`. The
same line is cited **three further times as `M03-F2`**, where the rule holds, and
**REQ-107's cell carries `test_m03_f.ml:492` under both ids at once**. That single cell is
the sharpest available argument for the exception: **one unit legitimately discharges two
rows**, and a rule keyed on titles can only ever name one of them.

**10. The round's two findings against its own instruments, both caught by running them,
and I would rather record them than have had a tidier round.** `AP-6-1`: `FINDING SO-1-A`'s
script bounds its slice with a **substring** search for `'## 7. Machinery …'`, so the moment
I quoted the script inside §6 the quotation became the first match, the slice ended inside
the code fence, and the check reported a **false** unhomed row. **I wrote the block, ran the
command against the file it was in, and got the wrong answer from the right script.** The
repair is a line-anchored boundary that a fenced quotation cannot satisfy. `AP-6-2`: I wrote
the disposition table's first column in the row tables' own bold notation, which is **exactly
the pattern the row census matches** — the raw count went 78 → 84, and the *set*-based
derivation stayed at 78 only because every id in my table was already a declared row, i.e.
the defect was masked by an accident of content. Backticking the column fixed it, **and the
identical defect was in `AP-M04` §6.1 at the identical table** (81 raw against 80 declared),
which is what makes it a class and not a slip. Both are the same family: *a document
measured by a pattern must not be annotated in the notation that pattern selects*, and *a
checker whose subject can contain the checker's own text needs a match rule its own
quotation cannot satisfy.*

**11. The new plan's own converse rule convicted its author before commit, which is the
best evidence I have that it was worth carrying.** I ran the homing check on my draft of
`AP-M04` and it returned **five** unhomed rows — `M04-B5`, `M04-M5`, `M04-M6`, `M04-O3`,
`M04-O4`. Two of them were REQs (709, 710) that appear at this module only through §9's
co-occurrence bullet and had no line at all; two were prohibition rows whose home is a
requirement they constrain rather than attack; one was simply missed. **`AP-M03` shipped
without that check for nine days and lost six rows**; `AP-M04` failed it in draft and lost
none, at a cost of one command.

**12. On the harvest note: none is owed at this round, and I say so rather than leave
silence to be read.** PROTOCOL §7 and charter §8 attach the note to **every module sign-off
and every phase gate**. This is a plan round and neither. Under `A2-D10` my next span opens
at `J-dv_lead-0168` — the entry my own last note deliberately left for *"a miner who can
read it finished"* — and **this entry joins that span**; both are mined at the next `SO-`
or gate. Recorded because a skipped harvest and a not-owed one are indistinguishable in
silence, and the tiling rule is the only instrument that tells them apart.

**13. What I refused.** I did not open `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`, though
it has existed since `WO-0024` and reading it would have made several rows easier to write
and every one of them worthless. I did not fetch `axis_xgmii_tx_64.v` to strengthen §7.1's
length-logic claim: vendoring is its own commit under ADR-0015 D2 and a plan round taking it
would be the scope-widening move `RV-C4` §12 convicts. I did not re-status a single
`AP-M03` row, lift a bar, or touch `docs/**` — three of the four repairs were tempting
places to do the fourth thing while I was there. And I did not decide `FINDING AP-M04-1`:
the arithmetic is mine and the ruling is the architect's.

### Actions

- **Created `test/attack_plans/AP-xgmii_tx_64.md`** — the M04 attack plan, `AP-M03`'s
  skeleton, **80 rows across 15 families** (A 5, B 5, C 6, D 6, E 5, F 6, G 8, H 6, I 4,
  J 4, K 5, L 5, M 6, N 4, O 5): **56 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL,
  1 GAP, 0 RULING**. §0.1 restates the three standing rules (SHA, domain, polarity); §0.2
  opens the prohibition register at the first commit; §2 carries seven standing obligations
  rewritten for a transmit port; §5 records ten rejected attacks; §6 carries the converse
  homing rule with §6.1; §7 measures six machinery items and states **BAR T1**; §8 routes
  six open items including `FINDING AP-M04-1`.
- **`test/attack_plans/AP-xgmii_rx_64.md`** — seven §6 cells gain a dated appended homing;
  new **§6.1** states the converse rule, homes `M03-O5`, carries the before/after
  measurement and mints `AP-6-1` and `AP-6-2`; new **§4.I-R** discharges the `-0024`-era
  carry-forward with a status correction appended inside each of the two cells; one §9
  change-log row.
- **`agents/handoffs/WO-0079_m03-traceability-test-rows.md`** — new **§2.1-P**, an appended
  precision to §2.1's citation rule with its two-dimension measurement; one §9 change-log
  row. §2.1 itself is unedited.
- Nothing under `test/xgmii_rx_64/`, `test/cosim/`, `libs/`, `docs/` or any other journal
  was touched, which was the dispatch's explicit out-of-scope list and is verified below.

### Evidence

**All commands run from a checkout at this working tree. No OCaml lands in this round**, so
there is nothing for `dune runtest` to say about it; `dune` is absent from this container in
any case (**ADR-0005** — the standing bound, re-checked: `which dune` returns nothing).

```
$ git rev-parse HEAD                       # at spawn, before reading anything
1968bea1332135a60e5968a124d00822d0c2e4c1
$ git status --short                       # at spawn
                                           (empty)
$ git status --short                       # at return
 M agents/handoffs/WO-0079_m03-traceability-test-rows.md
 M test/attack_plans/AP-xgmii_rx_64.md
?? test/attack_plans/AP-xgmii_tx_64.md
```

**The status-cell pass over every row table, both plans, at this tree** (the method
`DVC-1a` would mechanise; described-and-run rather than recalled):

```
$ grep -c '^| \*\*M04-[A-Z]\+[0-9]\+\*\* |' test/attack_plans/AP-xgmii_tx_64.md
80
$ grep -o '^| \*\*M04-[A-Z]\+[0-9]\+\*\* |.*| \(ASSERT\|NO-ASSERT\|NO-STIMULUS\|RULING\|GAP\|STRUCTURAL\) |$' \
    test/attack_plans/AP-xgmii_tx_64.md | sed 's/.*| \([A-Z-]*\) |$/\1/' | sort | uniq -c
     56 ASSERT
      1 GAP
     12 NO-ASSERT
      6 NO-STIMULUS
      5 STRUCTURAL
$ grep -c '^| \*\*M03-[A-Z]\+[0-9]\+\*\* |' test/attack_plans/AP-xgmii_rx_64.md
78
$ grep -o '^| \*\*M03-[A-Z]\+[0-9]\+\*\* |.*| \(ASSERT\|NO-ASSERT\|NO-STIMULUS\|RULING\|GAP\|STRUCTURAL\) |$' \
    test/attack_plans/AP-xgmii_rx_64.md | sed 's/.*| \([A-Z-]*\) |$/\1/' | sort | uniq -c
     62 ASSERT
      1 GAP
      7 NO-ASSERT
      4 NO-STIMULUS
      4 STRUCTURAL
```

**`AP-M03`'s census is unmoved in every cell** — 78 / 62 / 7 / 4 / 4 / 1, the standing
figure, taken from the file before and after the edits and not carried forward.

**The homing check, quotation-stable form, run on both plans after the repair** (the
`(?m)^## (\d)\. ` boundary is `AP-6-1`'s repair; the range-expansion loop is what
`AP-M04`'s ellipsis citations need — without it the same command reports 21 false
unhomed rows there):

```
$ python3 - <<'PY'
import re
for path, pre in (('test/attack_plans/AP-xgmii_tx_64.md', 'M04'),
                  ('test/attack_plans/AP-xgmii_rx_64.md', 'M03')):
    txt = open(path).read()
    declared = set(re.findall(r'^\| \*\*(' + pre + r'-[A-Z]+\d+)\*\* \|', txt, re.M))
    secs = {n: p for p, n in ((m.start(), m.group(1))
                              for m in re.finditer(r'(?m)^## (\d)\. ', txt))}
    s = txt[secs['6']:secs['7']]
    named = set(re.findall(pre + r'-[A-Z]+\d+', s))
    for m in re.finditer(pre + r'-([A-Z]+)(\d+)\s*…\s*' + pre + r'-\1(\d+)', s):
        named |= {f"{pre}-{m.group(1)}{k}"
                  for k in range(int(m.group(2)), int(m.group(3)) + 1)}
    print(path, len(declared), len(named & declared), sorted(declared - named))
PY
test/attack_plans/AP-xgmii_tx_64.md 80 80 []
test/attack_plans/AP-xgmii_rx_64.md 78 78 []
```

**The same check, on the same two files, at the states this round convicted** — recorded
because a green that was never red is not evidence that the instrument works:

| subject | state | result |
|---|---|---|
| `AP-M03` §6 | at `1968bea`, before this round | `78 72 ['M03-C5','M03-E5','M03-M8','M03-M9','M03-O4','M03-O5']` |
| `AP-M04` §6 | my own draft, before commit | `80 75 ['M04-B5','M04-M5','M04-M6','M04-O3','M04-O4']` |
| `AP-M03` §6 | first draft of §6.1, substring-bounded command | `78 77 ['M03-O5']` — **a false unhomed row**, `AP-6-1` |
| `AP-M03` §4 | first draft of §6.1's table in bold notation | raw row count `84` against 78 declared — `AP-6-2` |
| `AP-M04` §4 | same table, same notation | raw row count `81` against 80 declared — `AP-6-2` |

**`P-1`'s reach, both dimensions, at this tree** (the command is quoted in full at
`WO-0079` §2.1-P and is reproduced there with this output):

```
distinct citations                : 49
  not on a let%expect_test        : 1 [('test/xgmii_rx_64/test_m03_f.ml', '811')]
citation atoms (row -> path:line) : 110
  atoms whose title lacks the row id: 2 [('M03-M10', 'test/xgmii_rx_64/test_m03_f.ml', '492'),
                                         ('M03-M10', 'test/xgmii_rx_64/test_m03_f.ml', '492')]
  distinct citations among them   : 1
```

**`FINDING AP-M04-1`'s arithmetic, reproducible from the specification and needing no
tooling.** Frame octet `j` is accepted in source word `⌊j/8⌋` at cycle `C + ⌊j/8⌋`, byte
position `j mod 8` → input octet time `8C + j` (requirements.md §0.5's octet-time
definition). SPEC-M04 §6.1: a source word accepted on `C + m` is transmitted on `C + m + 2`,
lane = byte position (REQ-012, no rotation) → output octet time `8C + 16 + j`. **`L = 16`
octet times at every `j`, every length.** SPEC-M04 §7 pins **8** between the acceptance
cycle and the `/S/` word. Both are constants; the two are not the same quantity; REQ-210's
sentence names the second and calls it the first.

**§4's identity checked against SPEC-M04 §6.1's own cycle table**, at `P = 60`: `F` = 64,
`t` = 0, terminate at `C + 2 + 8 = C + 10` ✓ (table: C+10), `g = ⌈12/8⌉ = 2`, next start at
`C + 12` ✓ (table: C+12), gap `16 − 0 = 16` ✓ (§6.1: *"1 + 7 + 8 = 16"*), start-to-start 11
cycles ✓ (§6.1: *"Eleven cycles"*).

**The two gap conventions, worked at every residue at `cfg_ifg` = 12** — this
specification's *from the terminate character inclusive* against §0.3's rejected *twelve
idle octets after it*: they agree at `t ∈ {0,1,2,3,5,6,7}` and **differ only at `t = 4`**
(12 against 20). Derived by taking the smallest `p ≥ 12` (respectively `≥ 13`) with
`p ≡ −t (mod 8)`; the first column reproduces §6.1's own two stated numbers.

**The co-simulation posture, measured not recalled:**

```
$ ls test/third_party/verilog-ethernet/
COPYING  PROVENANCE.md  axis_xgmii_rx_64.v  lfsr.v
$ grep -n 'cosim\|iverilog' .github/workflows/build.yml | head -3
92:  # Its own job, not a step in `build` (R-CI-1): a cosim failure must be
94:  cosim:
116:        run: sudo apt-get update && sudo apt-get install -y iverilog
```

`axis_xgmii_tx_64.v` is absent; `tools/cosim/run_cosim.sh` is the only `iverilog` caller and
builds `test/cosim/tb_xgmii_rx_64.v`; `test/cosim/canonical.mli`'s pinned record is
`{ tkeep; tlast; tuser0; cycle; octets }`; and REQ-901's lettered classes (a)–(h), read
whole, name no transmit boundary.

**No file outside the declared write set was modified**, which `git status --short` above
shows directly: three paths plus this journal, and the dispatch's explicit exclusions
(`test/xgmii_rx_64/**`, `test/cosim/**`, `libs/**`, `docs/**`, every other journal) are
absent from it.

### Outcome

**DoD vs the round's own charge: met, both acts.**

- **Act 1 — `AP-xgmii_tx_64.md` committed before the first M04 bench**, as charter §3 and
  ADR-0001 require. It reaches every TX surface the dispatch named — preamble and SFD
  construction (A), padding to minimum frame (C), FCS append (D), terminate lane placement
  across **all eight** lanes derived rather than sampled (E), IFG enforcement with the DIC
  question answered from §0.3 and §11's own ruling (F), and underflow (G, the largest
  family) — and states the co-simulation posture explicitly as **BAR T1**, with what the
  anchor could and could not see for TX and the four requirements that stay bench-only even
  if the lane opens.
- **Act 2 — all three repairs discharged at the carrier that named this round.**
  (a) `FINDING SO-1-A`'s §6 homing: six rows homed, converse rule stated, measurement
  re-run before and after. (b) The §4.I cells: `F-1`'s status corrected and §0.5's citation
  completed, with the substantive claims explicitly **not** re-asserted. (c) `P-1`: §2.1
  gains an appended precision and its reach is measured in a second dimension the finding
  did not state.

**Two findings minted against my own instruments this round** (`AP-6-1`, `AP-6-2`) and
**one against the specification** (`AP-M04-1`, routed to architect_docs_lead, deciding
nothing). **Nothing is re-statused anywhere**; no bar lifts; no census moves; no `BUG-` is
opened; this is neither an escalation nor a gate act.

**No harvest note**: not owed at a plan round (PROTOCOL §7, charter §8 attach it to
sign-offs and gates). Under `A2-D10` my next span opens at `J-dv_lead-0168` and now
contains this entry too; both are mined at the next `SO-` or gate.

**Handoff**: the plan and the two repaired documents go to the orchestrator for commit.
`FINDING AP-M04-1` and REQ-901's missing M04-boundary divergence classes are **spec-change
requests for architect_docs_lead**, routed via the orchestrator, neither decided here. The
three BAR T1 conditions are work-order requests, not silent to-dos.

### Open-questions

1. **`FINDING AP-M04-1` is live and is the round's largest.** REQ-210 names a per-octet
   measurement and pins an event delay; the per-octet constant is **16** octet times and
   §7's pinned figure is **8**, and a monitor built from the two together fails a conformant
   M04 at every octet. Its second half — §0.5's front offset `h` being defined only for a
   module that *removes* octets from the front, while M04 *prepends* — may be answered
   separately. **Route**: architect_docs_lead via the orchestrator. **Nothing is blocked**:
   M04-J1 asserts the event delay and M04-J3 reports 16, and neither moves on the ruling.
2. **REQ-901 declares no divergence class at the M04 boundary**, and its own text forbids a
   sign-off citing a class not listed there. Needed before any TX co-simulation result can
   be used. **Route**: architect_docs_lead.
3. **BAR T1's three conditions need work orders, in a stated order**: REQ-901's classes
   (architect) gate what a comparison may compare; vendoring `axis_xgmii_tx_64.v` at a pin
   is its own commit under ADR-0015 D2 and gates the harness entirely; the harness and a
   canonical form for a lane pair follow. **None of the three is a bench round's to do
   inside a bench round**, and charter §3 makes all three preconditions of M04's `SO-`.
4. **`C-5` is still DEFERRED** — §0.6's strobe window is vacuous for `error_underflow`
   (SPEC-M04 §11.3). `AP-M04` obligation 5 is a standing prohibition derived from an
   undischarged deferral, which is a weaker footing than I would like: a reader of §0.6
   alone finds a window, applies it, and gets a green that means nothing.
5. **Machinery `T-2`**, the transmit-side conservation monitor, is **mine**, with an executor
   named (the round that opens `test/monitors/`). No row is blocked; obligation 3 carries
   the counting rule meanwhile, including the part that is easy to get wrong — keying on the
   `tlast` acceptance exempts every underflowed frame.
6. **`DVC-1a` is now wanted by two plans.** Both §6 homing checks and both status censuses
   are described-and-run passes for want of it. Still mine, still unbuilt; the second plan
   is a fact about its priority, not a new commission.
7. **Standing and untouched by this round**: the architect's ledger row 32 (`BUG-0002`
   cannot close on the `-0025` ruling) keeps its own carrier, a bug round, which this was
   not; `SO-xgmii_rx_64.md` §3.9's other standing entries are unmoved; and the `A2.4`
   clerical edits to `docs/gates/lessons-harvest-block.md` remain owed to the architect.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_tx_64.md
- test/attack_plans/AP-xgmii_rx_64.md
- agents/handoffs/WO-0079_m03-traceability-test-rows.md

## [J-dv_lead-0170] 2026-08-11T20:55Z | task:none | Three countersignatures paid at the source and not at the summary — L = 16 re-derived over a wider sweep than the one it checks, the second half of my own C-27 signature withdrawn as false while its conclusion stands, and C9's licence signed with the closure its restriction does not reach filed against it

### Trigger

Orchestrator dispatch, spawn-head `816e187`, **no sibling round in flight**. The
architect's three-item spec round (`J-architect_docs_lead-0038`, diff over
`docs/specs/requirements.md` and four module specifications) states in terms that
**dv's re-countersignature is owed** on the REQ-210 + §0.5 diff and on the REQ-611
diff, and that the REQ-901 diff is **normative and NOT IN FORCE until dv's
countersignature is transcribed**. My act is the one my `(g)`/`(h)` round took
(`J-dv_lead-0162`): verify each derivation **at the source**, countersign or
contest, and write the countersignature text the orchestrator transcribes.

Precheck performed and passed before reading the diff and before any write:

    git status --short              # empty
    git rev-parse HEAD              # 816e187da118708505ce00e04cc72bf5bafebd14
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any edit.
- **The diff under review**: `git diff 8f81568..816e187` over
  `docs/specs/requirements.md`, `docs/specs/modules/xgmii_tx_64.md` (M04),
  `docs/specs/modules/eth_axis_rx.md` (M06), `docs/specs/modules/arp_eth_rx.md`
  (M10), `docs/specs/modules/ip_eth_rx_64.md` (M14) — read hunk by hunk, and then
  each repaired passage read **in place at HEAD** rather than only as a hunk.
- **`docs/specs/requirements.md` at HEAD**: §0.5 entire (octet time, front offset h,
  the new inserting-module clause, word delay ΔC, the deciding input word, the two
  arithmetic tests, what a monitor may demand under injection, **Start lanes**);
  REQ-011, REQ-012, REQ-016, REQ-110, REQ-206, REQ-210, REQ-611, REQ-901 entire;
  §13's four new rows.
- **`docs/specs/modules/xgmii_tx_64.md`**: §3 (the REQ-016 row), §6.1 entire (the
  preamble, frame, padding, FCS, terminate and gap paragraphs, the cycle table and
  the storage paragraph), §6.2, §6.3, §7 entire, §10's REQ-210 hook, §13.
- **`docs/specs/modules/eth_axis_rx.md`**: §6.1 entire (the field table, the
  where-the-fields-lie paragraph, the assembly rule, the gapless cycle formulas,
  the repaired gapped paragraph, the minimum-frame cycle table, the abort-bit
  inequality), §7's latency and handshake bullets with the new four-event table,
  §9's pinned strobe cycle, §10's REQ-016 hook, §13.
- **`docs/specs/modules/ip_eth_rx_64.md`**: §3's REQ-016 and REQ-019 rows, §6.1's
  repaired gapped paragraph, §7's latency, parse-latency and handshake bullets with
  the new four-event table, §10's REQ-016 and REQ-611 hooks, §13.
- **`docs/specs/modules/xgmii_rx_64.md`** §9's *"When a frame is open, and what
  closes it"* paragraph — the five-member closure list, read word for word against
  REQ-901's new span rather than from the architect's citation of it.
- **`docs/specs/modules/nic_top.md`** §7 and §10 and **`docs/specs/modules/udp_ip_rx_64.md`**
  §7, read to test whether the retired per-octet-under-injection reading survives at a
  site the round did not name.
- **My own instruments**: `test/attack_plans/AP-xgmii_tx_64.md` §4.J (rows `M04-J1` …
  `M04-J4`), §6, §7 item T-4, §8 items 1–6, §9; `test/attack_plans/AP-ip_eth_rx_64.md`
  §4.C, §4.F (rows `M14-F1` … `M14-F4`), §4.I, §6, §9; `test/attack_plans/AP-xgmii_rx_64.md`
  §4.H and family I.
- **My own countersigned record**: `agents/handoffs/WO-0020_batch-f-countersign.md`'s
  **C-27** disposition, quoted below verbatim; `agents/handoffs/WO-0078_…§6.3`'s
  Stage-3 re-authorisation gate and §7's branch table; `WO-0078` §14's `RV-SWEEP`
  entry carrying **`FINDING ECS-3`** and the H-4 row; `agents/handoffs/SO-xgmii_rx_64.md`'s
  gate table at `2183d71`; `agents/journals/claude_dv_lead_agent.md`'s C-27 minting
  entry; `claude_dv_lead_agent.v08.md` `J-dv_lead-0169` (the `AP-M04` round that filed
  `FINDING AP-M04-1`, and its harvest-span paragraph).
- **The co-simulation producers, as artefacts of my own line**: `test/cosim/ours_run.ml`
  (the FI-4 admission guard at `:245-262` and the span-closing line `:273`) and
  `test/cosim/tb_xgmii_rx_64.v` (FI-6's mirror). Read to test the diff's claim about
  what today's guards refuse, not to derive a rule from them.
- `agents/journals/claude_architect_docs_lead_agent.v03.md`, `J-architect_docs_lead-0038`
  entire, **read last** — after my own derivations, so that agreement means agreement.

**Independence.** No RTL was opened: `libs/**` was not read at any point in this
round, and `test/third_party/` was not opened. **Every reference-side claim in this
entry is carried from the `(g)`/`(h)` class text I countersigned at `J-dv_lead-0162`
after deriving it from the reference's clocked block in that round** — it is a
retrospective reference to a derivation already in history, not a new static read,
and where I use it below I say so at the point of use.

### Reasoning

---

#### (a) Diff 1 — REQ-210 + §0.5's front offset. **COUNTERSIGNED.**

**What I verified, and it is a re-derivation and not a reading.** The architect's
sweep is arithmetic over the closed form; mine is not. I materialised M04's XGMII
wire stream from §6.1's **construction** rules — the preamble word at C+1 (`/S/`,
0x55 ×6, 0xD5); source word m accepted at C+m transmitted at C+m+2 with lane =
byte position (REQ-012, no rotation); then REQ-203's pad octets to 60, the four FCS
octets, the terminate character — and read the octet times **off the stream**, so
the check is independent of the algebra it tests (Evidence 1). Over **N = 14 …
1514**, all 1501 lengths:

- **L = 16 octet times at every frame octet of every frame**, one value in the set,
  **zero** lengths with a non-single-valued L;
- the **event delay** — acceptance handshake to the word whose lane 0 carries `/S/`,
  both events at octet position 0 — is **8** octet times, one cycle;
- **ΔC = 2**, taken as *(first output word carrying an octet **of the frame**) −
  (source word carrying frame octet 0)*, which is the new clause's own definition
  and not the identity's;
- both identities close: **L = 8ΔC − h** gives 16 = 16 − 0, **ΔC = (L + h)/8** gives
  2, and **(L + h) ≡ 0 (mod 8)**, which is §0.5's whole-number test;
- **L − event delay = 8 octet times = exactly one word**, and the word is the
  preamble word. That is the finding's whole content, arrived at from the other end.

**My sweep is wider than the one it checks, and the extra region is the interesting
one.** The architect swept **1455** lengths, N = 60 … 1514. Mine adds N = 14 … 59 —
the **46 lengths at which REQ-203's padding runs** (1501 − 1455) — and L is still 16 at every
frame octet there. That matters because the padded region is exactly where a
per-octet tagger has wire octets with **no input octet to match**, which is my own
row `M04-J4`'s subject; the sweep confirms that the *frame* octets' latency is
untouched by the pad, and that the domain restriction is a property of the tagger
and not of the constant.

**M04-J1 and M04-J3 remain correctly statused against the repaired text**, checked
row by row rather than asserted:

- **`M04-J1` (ASSERT)** asserts *(cycle of the `/S/` word) − (cycle of the
  acceptance handshake) = 1 cycle = 8 octet times*, citing §7's REQ-210 bullet and
  §10's hook. The repaired §7 pins that same quantity at the same value under the
  name **event delay**, and the repaired §10 hook says *"the **event** interval
  equals 1 cycle at every length"*. **The row's basis survives verbatim and its
  status does not move.**
- **`M04-J3` (NO-ASSERT)** reports 16 and asserts nothing. The repaired §10 hook now
  *permits* an assertion at 16 (*"Where the per-octet latency is asserted at all it
  is asserted against **16**"*); a permission is not a commission, my row's choice to
  report rather than assert is unaffected, and the row's own cell already said it
  *"moves in neither direction on its resolution: it reports 16 either way"*. **Status
  does not move.** What *is* now stale in that row is its **quotation**: it quotes
  REQ-210's opening clause *"Measured per octet in octet times (§0.5)"* as the defect,
  and that clause no longer exists. That is an editorial repair to my own plan, owned
  below at (h).

**The refused alternative, tested on my own ground rather than accepted on the
ruling's.** The live alternative was to repair §7's pinned 8 to 16 and keep REQ-210's
per-octet opening. Given REQ-201's fixed eight-octet preamble the two constrain the
same hardware, so nothing about the design turns on it — which is why I agree there is
no ADR to write. I agree with the refusal on a reason I can state without the ruling:
**the event delay is the only one of the two quantities whose two events are both
named**, and under the alternative it would have become an *unpinned* consequence of a
per-octet figure, so a plan row asserting it (`M04-J1`) would have had no pinned
sentence to derive from. Pinning both is the only repair under which **each of my two
landed rows keeps a basis**. The alternative is recorded with its refusal in §13,
which is the form the C-14 and C-16 repairs used, and that is the right place for it.

**What I countersign, quoted so the transcription has a verbatim source.**

1. `docs/specs/requirements.md` **§0.5**, the paragraph immediately after the front-offset
   paragraph, opening:

   > **A module that *inserts* octets ahead of the frame has h = 0, and ΔC counts to
   > the first output word carrying an octet of the frame** (normative).

   …through its closing sentence *"…refutable by arithmetic on the specification before
   any RTL exists and refuted there (REQ-210, SPEC-M04 §7 and §10)."* — **the whole
   paragraph, unamended.**

2. `docs/specs/requirements.md` **REQ-210**, the repaired Requirement cell, and in
   particular:

   > **This is an event delay between two named events** — the cycle on which
   > `tx_tvalid` and `tx_tready` are both 1 for the frame's first word, and the cycle
   > of the XGMII word whose lane 0 carries the start character — **and it is not
   > §0.5's per-octet latency**, which at M04 is a different constant with a different
   > value. Both are pinned in SPEC-M04 §7 and each is measured in its own terms;
   > **a monitor SHALL NOT assert either one per the other's measurement.**

   and its repaired Verification cell, including *"§0.5's per-octet latency at this
   module is SPEC-M04 §7's own pinned L and is measured against **that** figure or
   reported as data — never against this one."*

3. `docs/specs/modules/xgmii_tx_64.md` **§7**'s two-constant table (event delay 1 cycle
   = 8 octet times; L = 16; h = 0; ΔC = 2; no §1.1 ceiling) and **§10**'s repaired
   REQ-210 hook — **countersigned as the module-side pin of the above**, with the one
   exception filed at (b).

**Verdict: COUNTERSIGNED.** `FINDING AP-M04-1` is **SUSTAINED, CURED and CLOSED** as
to REQ-210 and as to its second half (the ΔC-at-an-inserting-module question, which
§0.5 now answers in the definition rather than at the module — the right site, because
the ambiguity was in the definition's gloss and would have recurred at the next
inserting module).

---

#### (b) `FINDING AP-M04-2` (MINOR against the text; the hazard is a bench) — filed **without** holding diff 1 out of force

SPEC-M04 §7's repaired latency bullet closes:

> Both constants may be asserted — M04 passes both of §0.5's tests, straddle
> (h ≡ 0 mod 8) and late decision (its output framing is decided by the source word it
> is transmitting, never by a later one), so unlike every straddling receive module its
> per-octet constant **does** survive REQ-016's idle injection — but each against its
> own figure.

**The two test verdicts are right and I checked them**: h = 0 ≡ 0 (mod 8), so no output
word straddles two source words; and M04's output framing is carried **in band** on the
source word (`tkeep` and `tlast` on the word itself, REQ-011, §3's REQ-011 row), so no
output event is decided by a later input word. **The conclusion drawn from them has no
instance at this module.** REQ-016 says in its own text: *"This does not apply to
`Xgmii_tx_64`'s source interface, where a missing word after transmission has begun is
an underflow (REQ-206)."* SPEC-M04 §3's REQ-016 row says it a second time
(*"REQ-016's idle tolerance **does not extend to this interface**"*), and §7's own
handshake bullet a third. So the sentence asserts a property over a stimulus class
that this specification twice declares empty — and the shape of the hazard is the one
`FINDING AP-M04-1` just convicted a requirement for: **a bench writer reading §7's
latency bullet is invited to build an idle-injection wrapper at M04's source, where
one injected cycle on a required cycle is REQ-206's underflow — the frame aborts with
`/E/`+`/T/` and no FCS, and no per-octet constant survives that at all.** My own plan
already records the absence as structural (`AP-xgmii_tx_64` §6's REQ-016 row: *"No
instance at this interface … `AP-M03`'s family I … has no counterpart here"*), so the
two documents now disagree about whether the stimulus exists.

**Class: MINOR against the text** — the claim is vacuous rather than false, no
conformant design changes, and no committed test exists at M04. **It does not touch the
countersigned objects**: the two constants, their values, h, ΔC and the prohibition on
cross-measuring are unaffected, and diff 1 stays in force. **Route**: architect_docs_lead,
as a spec-diff request via the orchestrator — the cure is one clause (scope the survival
claim to the module's *gapless* domain, or state that REQ-016 has no instance here and
the survival claim is recorded for the general reader only), and it takes a narrow round
of its own. **Not decided here**, on the same discipline `FINDING AP-M04-1` used.

---

#### (c) Diff 2 — REQ-611, and the correction of record my own signature owes

**The countersigned disposition is mine and I quote it before judging it.**
`agents/handoffs/WO-0020_batch-f-countersign.md`, my batch-F countersignature:

> **C-27 — REAFFIRMED.** L = 12 named as the gap-invariant constant is the right
> discharge for REQ-611's gap clause. See **C-32**: M17's claim to be immune to C-27's
> class is half right and half wrong.

**That sentence carries two claims and only one of them survives.** C-27 as I minted it
(`claude_dv_lead_agent.md`) is *"REQ-611's parse-latency constant is gap-sensitive while
REQ-611 claims otherwise"*, and its disposition — §7 scopes the 3-cycle figure to a
consecutively delivered header and states the growth rule — is **untouched**. The second
claim, that **L = 12 is the gap-invariant constant that discharges REQ-611's gap clause**,
became **false on 2026-08-04**, when §0.5's straddle test retired the per-octet-under-
injection reading at every straddling module. So the architect's *"C-27's conclusion
survives and is strengthened"* is **right about the conclusion and incomplete about my
signature**: the conclusion survives, and **the second half of the sentence I signed is
withdrawn as false**. I record that here rather than let a countersignature keep an
unmarked false clause, which is the standing rule my own `FINDING CSG-1` applied to the
architect's recitals.

**Verified rather than accepted, three claims:**

1. **M14 straddles.** h = 20, 20 mod 8 = 4 ≠ 0. Worked at the module rather than from
   the predicate: payload word j takes payload octets 8j … 8j+7 = IPv4 octets 8j+20 …
   8j+27, which lie in input words j+2 (positions 4–7) and j+3 (positions 0–3) — §6.1's
   own assembly rule, reproduced. **Every payload word is assembled from two input
   words.** Inject k idles between them: the output word leaves whole (REQ-011 forbids
   splitting it) at its deciding input word's delay, so the four octets from word j+2
   take L = 12 + 8k while the four from word j+3 keep L = 12. **Two latencies inside one
   output word** — so no single per-octet L survives, at any k ≥ 1. ✓
2. **REQ-611's old clause was unsatisfiable.** Its two events are *input word 0* and the
   `ip_hdr_valid` *pulse*. One idle inside the header puts input word 2 at Ci+3 and the
   pulse at Ci+4: the figure is 4, not 3. The requirement demanded that this **not**
   happen. ✓ Same defect class as REQ-210's, reached from the other side.
3. **The replacement is achievable and is the same fact from the other end.**
   `ip_hdr_valid`'s deciding input word is **input word 2** — the 20-octet header ends at
   IPv4 octet 19, which is input word 2 position 3, so all six header fields and the
   checksum are decidable there and no later word is needed; causality holds (the pulse
   is pinned at Ci+3, one cycle **after** its cause). With k idles injected at or before
   input word 2, word 2 moves to Ci+2+k and the pulse to Ci+3+k: **the delay from the
   deciding word is 1 on every stimulus**, and the figure measured from word 0 is 3+k.
   *"Grows by exactly the injected count"* and *"is exactly one cycle, always"* are the
   same statement, and the second is the one a monitor can assert. ✓

**What I countersign**, `docs/specs/requirements.md` **REQ-611**, the repaired
Requirement cell, in particular:

> …**on a header whose input words are delivered on consecutive cycles**. Under
> REQ-016's permitted idle injection inside the header that figure grows by exactly the
> injected count, and what is invariant is §0.5's per-output-event delay: the header
> record's `valid` is decided by the input word completing the header, and **the delay
> from that deciding input word to the pulse SHALL be a fixed constant pinned in the
> module spec** — that is the constant REQ-016 does not break, and it is the one a
> monitor asserts on an injected run.

together with its Verification cell (*"Under injection: the delay from the deciding input
word named in the module spec to the pulse, at 0, 1 and 7 injected cycles"*), and — as the
module-side pin — SPEC-M14 §7's parse-latency bullet as repaired and §10's REQ-611 hook.

**Verdict: COUNTERSIGNED**, with the correction of record above: **C-27's conclusion is
REAFFIRMED; the ground under it is replaced; and the second clause of my WO-0020
countersignature is WITHDRAWN as falsified by §0.5's 2026-08-04 ruling.** The
re-countersignature is better than the one it replaces, and it is better for the reason
the architect gives — the discharge is now stated in the quantity §0.5 says survives,
rather than in one it says does not.

---

#### (d) What diff 2 moves in my own bench obligations — and it is not nothing

**`AP-ip_eth_rx_64.md`'s family F still asserts the retired reading, and one of its rows
is `ASSERT`.** Measured at HEAD, not remembered:

- **`M14-F1` (ASSERT)** — stimulus: the M14-D1 directed set through an idle-injection
  wrapper at 0, 1 and 7 cycles between payload words. Observable, verbatim: *"the
  **per-octet constant L = 12** is unchanged for every octet; every octet is delayed by
  exactly 8 octet times per injected cycle"*. **That assertion fails a conformant M14** at
  every k ≥ 1, by (c)'s straddle arithmetic — the exact `SCR-M03-I4` failure mode, in my
  own landed plan, at a second module.
- **`M14-F2` (ASSERT)** — its parse-latency half (*"the parse latency is 3 + k … and that
  grown value is asserted"*) is **correct and is strengthened** by the repair; its trailing
  clause *"L = 12 is unchanged"* carries the same defect as F1.
- **`M14-F3` (NO-ASSERT)** — its ground sentence *"the gap-invariant quantity is L = 12 and
  that is what M14-F1 asserts"* is the retired reading stated as the row's reason.

**Provenance, stated honestly: this diff did not create the defect.** `AP-ip_eth_rx_64.md`
was last touched at `60721cc` (2026-08-03) and §0.5 retired the reading on **2026-08-04**;
the rows have been stale for a week, at a module with no bench, and **nothing in the repo
records it** (`grep -rn "M14-F1"` outside the plan returns nothing). What this round did
was make it visible, by making me read the requirement the rows derive from. **Owner: mine.
Carrier: the round that next opens `AP-ip_eth_rx_64.md`, and it is owed before any M14
bench** — the repair is F1's observable restated as §7's four-event table (output tuple
sequence unchanged; each event delayed by the idles injected at or before its deciding input
word), F2's trailing clause struck, F3's ground replaced, and a change-log row saying which
reading it replaced. **No status count changes**; the plan's `ASSERT` at F1 stays an
`ASSERT` of a different observable.

I record this as a **finding against my own instrument**, not against the diff, and it is
the second time in three rounds that the converse of a repaired requirement has convicted a
landed plan of mine — which is the pattern worth carrying.

---

#### (e) Diff 3 — REQ-901: the admission rule, part (ii), the record-only licence, no class. **COUNTERSIGNED**, with one finding.

**1. The span, checked against the two documents it claims to restate.** REQ-901's new
sentence and SPEC-M03 §9's list are the same list, member for member and citation for
citation — terminate character (REQ-106); an error character arriving while it is open
(REQ-105); a later start character (REQ-110); REQ-108's truncation, on the cycle the
received count passes 1518; `clear` (REQ-009) — differing only in *"a later start
character"* against §9's *"a new start character"* and in REQ-901's module-neutral
*"its start character is admitted"*. **Five members, no drift.** REQ-110's own new clause
carries four of the five and points at SPEC-M03 §9 for the fifth by name, which is honest
about where the whole list lives.

**2. Condition (c) is discharged as `ECS-3` reshaped it, and I measured the reshaping
myself.** `ECS-3` said the obligation is about the **span-closing rule**, not REQ-110's
abort rule, and that its scope is **five classes and not one case**. REQ-901 now states
the span, requires **both** producers to derive their admission logic **from this document,
never from the reference and never from each other**, and records that *"a guard whose span
is closed by the terminate character alone is **wider than this rule** and refuses stimulus
the rule admits"*. **That last sentence is my measurement, and it is still true at HEAD**:
`test/cosim/ours_run.ml:245-262` refuses any start character while `admission_open` is set,
and `:273` clears `admission_open` **only** on `has_terminate word` — so an `/E/` does not
close the span and `M03-H3`'s geometry trips a guard whose subject it is not. **And the
spec text lands before either producer is opened**, which is the order `WO-0078` §6.3
demands: the diff touches no byte of `test/**`. **Condition (c): MET on transcription.**

**3. Part (ii) is necessary, and I checked the necessity rather than accepting it.** Writing
the span down makes *"open"* determinate — and a determinate *"open"* puts the
`/E/`-then-`/S/` geometry **outside** part (i), because the `/E/` closed the frame. Once the
guards are narrowed to the rule (which is the point of writing it), that stimulus becomes
**admissible**, and its reference-side outcome turns on the same one-word look-ahead race
that decides `CSG-1`'s two shapes — where the reference does not close the frame, the frame
that our side receives normally is **swallowed**, and a swallowed frame is a divergence in
the **ordered sequence of output frames**. **No declared class excludes at the sequence
level** — (a) is a stimulus restriction, (b), (c) and (d) are per-field or per-behaviour,
(e) and (f) exclude *a frame*, (g) excludes three per-frame observables and (h) excludes a
per-frame decision — so a merge has no home in the list. Part (ii) closes exactly that, on
its own ground, and states that **neither part reaches a directed bench**, which keeps
`AP-M03` row `M03-H3` (one `error_bad_frame`, **no** `error_start_without_terminate`)
untouched and still assertable. **A clarification that quietly widened what may be driven
would have been the worse half of this diff; it does not.**

**4. No class declared — checked against my own `CSG-1`.** `CSG-1`'s family is four cases
(start lane × the frame's own start lane) producing three outcomes, of which **two are frame
merges** (both lane-0 mid-frame starts), one is exact agreement (a lane-4 start inside a
lane-4-started frame) and one is a four-octet over-delivery with the **opposite sign** to
(g)'s. A single class covering that family would have to exclude at the sequence level for
half of it and at the extent level for a quarter, with a mechanism sentence false of the
rest — which is why I wrote in the `(g)`/`(h)` countersignature that widening (g) would
import a false mechanism. **Declining the class is the same disposition I countersigned,
and the change is that its closing event is now reachable.** I agree, and I note for the
record that the architect declined to mint a sequence-level exclusion *"in a round dv is
not in, reversing a sentence dv countersigned"* — that restraint is the right one and I
would have contested the alternative.

**5. The record-only licence — what it permits and does not, in my own words, so the
two-key record exists.**

**IT PERMITS**, once a producer is authorised to narrow its guard for the case:

- driving either restricted situation — a start character inside an open frame that has
  already delivered an octet, and a start character between an `/E/` closure and that
  frame's following terminate character — as **stimulus at both producers**;
- **emitting both designs' observed dispositions** for the frames involved (words,
  `tkeep` extents, `tlast` placement, `tuser`[0], strobes, and each side's
  accept-or-discard outcome) into the run's report **as data**, in the form classes (e)
  and (f) already use for the frames they exclude entirely;
- using that recorded data as the **measured behaviour** on which a class is afterwards
  declared **by spec diff** — which is the only route to a class that this document has
  ever had, and the deadlock's release.

**IT DOES NOT PERMIT — and each of these is a separate prohibition, not a restatement:**

- **It compares nothing.** No agreement or disagreement verdict may be computed or
  reported for the restricted frames; no `compare` exit code, tier, aggregate or pass
  criterion may be derived from them. **A record-only run selects no branch**: it is not
  an α, not a β and not a γ under `WO-0078` §7, and it is **not a `CD` §10 case instance**
  — if one is ever built it needs its own `CD` instance saying on its face that it compares
  nothing, because `CD` §6's discipline is that a disposition written after a run voids the
  case, and a run with **no** disposition must be marked as such **before** it runs rather
  than reclassified after.
- **It adjudicates nothing.** Nothing observed in such a run may be resolved as a defect,
  as a class, or as a spec diff **by the run**; no `BUG-` may be opened on its output; and
  a divergence seen there is neither "outside the declared classes" nor inside one — it is
  **not a divergence at all**, because nothing was compared.
- **It anchors nothing and is citable by no packet.** No `SO-` may cite it as the external
  anchor for any requirement — expressly not REQ-105's or REQ-110's delivered-octet
  clauses, which continue to rest on their directed tests alone — and no gate evidence row
  may count it as coverage.
- **It licenses no expected value.** No bench expectation, oracle table, golden-model value
  or comparator baseline may be taken from the reference's observed disposition in such a
  run (ADR-0015 D2, and REQ-901's own closing sentence). This is the prohibition most
  likely to be breached by accident, because the data will be sitting in a committed report.
- **It is not self-executing.** It does not lift `FI-4` or `FI-6`: those are producer code
  in my write scope, and narrowing them is a separate authorised act with its own review.
  Until then no run can drive either situation, which is why nothing is blocked by
  transcription and nothing is unblocked by it either.
- **It does not make the two shapes comparable for any other purpose**, and it does not
  narrow, widen or reletter any declared class.
- **A report that omits the on-its-face statement is not a record-only run.** It is an
  unadjudicated comparison, and it is a finding against the round that produced it.

**Verdict: COUNTERSIGNED** — the admission rule, the derive-from-this-document obligation,
the guard-width sentence, restriction parts (i) and (ii), the record-only licence, and
no-class-declared. **IN FORCE on transcription**, with `FINDING CSG-3` filed against a gap
in the restriction's coverage rather than against anything it says.

---

#### (f) `FINDING CSG-3` (MATERIAL, mine, against REQ-901's restriction coverage) — filed **without** holding diff 3 out of force

**The restriction is stated over two of the five closure events, and the third is
explicitly opened.** With the span written down, a frame is closed by any of five events;
part (i) bars a start character **inside an open frame**, and part (ii) bars one after an
**`/E/`** closure. **Neither bars a start character after REQ-108's *truncation* closure**
— and the diff's own lift clause goes further:

> Both parts are lifted for the frame class that class (f) already excludes entirely, where
> nothing is compared in any case.

**The geometry, and it is constructible.** Present a frame that receives more than 1518
octets **with no terminate character**, then a start character in **XGMII lane 0**, then a
normal 64-octet frame with its own terminate. On our side REQ-108 truncates at 1514
delivered, marks the word, pulses `error_oversize`, emits nothing until the start character
(REQ-108's own resynchronisation clause), and receives frame B intact: **two output frames**.
On the reference side — carrying the `(g)`/`(h)` recital I derived and countersigned at
`J-dv_lead-0162`, not a fresh read — there is **no frame-length logic of any kind**, so the
oversize frame is still open, and **at a lane-0 start the reference does not abort at all**:
frame B's octets are appended and the two frames are **one frame**.

**Why class (f) does not cover it.** (f) excludes *"a frame exceeding 1518 octets (DA
through FCS) … entirely at this boundary, including the disposition of the octets between
our truncation point and the next start character"*. **Frame B is not that frame.** Its
octets begin *at* the next start character, so they are outside the excluded region; ours
accepts and delivers it, theirs produces no separate frame for it, and REQ-901's comparison
content includes *"the same accept-or-discard decision **per input frame**"*. **The
divergence is on input frame B, and it is a sequence-level divergence** — precisely the
shape §4(d) of the ruling declines to mint a class for, and precisely what part (ii) was
written to keep out.

**Why the lift's stated reason does not reach it.** *"Where nothing is compared in any
case"* is true of the **oversize** frame and false of the frame the reference merges into
it. The lift is sound for (f)'s **intended** geometry — REQ-108's own verification column's
*"1600-octet frame followed immediately by a valid frame"*, where the oversize frame has a
terminate character, the reference forwards it whole, and both sides then receive the next
frame, so the sequences agree with one excluded member. **It is unsound for the
terminate-less form**, which the written rule newly admits because truncation is now a
closure.

**What this is and is not.** It is **not** a defect in any sentence I countersigned at (e):
the admission rule is right, and it is right *because* truncation closes a frame. It is a
**coverage gap in the restriction stated over that rule**, created by the same diff that
made the rule determinate — the identical mechanism the architect caught for the `/E/`
closure and wrote part (ii) for, at the one closure it did not carry through. **Not live
today**: `FI-4`'s terminate-only span refuses every second start character regardless of
what closed the frame, so no run can drive it, and the diff's own *"a guard wider than the
rule is not a defect"* is what keeps that safe. **It becomes live the moment a producer is
narrowed to the rule as written**, which is the next act this whole sequence is for.

**Two cures, and choosing between them is the architect's, not mine.** Either extend the
restriction to the truncation closure in part (ii)'s own shape (*no start character between
REQ-108's truncation of a frame and that frame's following terminate character*), or narrow
the lift so that it covers stimulus **within** an excluded frame and not stimulus that
**opens a frame the exclusion does not reach**. **Route**: architect_docs_lead, spec-diff
request via the orchestrator. **Bound**: it takes a narrow round of its own; nothing in the
countersigned text moves for it.

**And a binding on my own side, stated so it is not assumed.** `FI-4` and `FI-6` are mine.
**I will not narrow either guard for the truncation-closure geometry until `CSG-3` is
ruled**, whatever a later work order's convenience — the wide guard is the compensating
control while the rule's coverage is short by one closure. The `clear` closure (REQ-009) is
the fifth member and has **no instance** in the co-simulation lane today: `ours_run.ml:450-457`
pulses `clear` once before the trace and never mid-run, and the reference-side testbench
drives no counterpart at all. Recorded as an observation, not a finding.

---

#### (g) Item 1 of the round — the M06/M10/M14 stale-sentence repairs. **Spot-verified, bounded, and stated as such.**

The round asked for a bounded independent check of M06's four-event table against
SPEC-M06 §6.1's own arithmetic. I built the payload-octet-to-input-word map from §6.1's
assembly rule (payload word m from input word m+1 positions 6–7 and input word m+2
positions 0–5; payload octet j = input octet j+14) for **every frame length N = 14 …
1514**, read the deciding input word **off the map** rather than from the closed form,
and compared it with §6.1's gapless emission cycles (`hdr_valid` at Ci+2, payload word m
at Ci+3+m). Results (Evidence 2):

- **ordinary payload word m → D = input word m+2, delay 1 cycle**: single-valued over
  **141 000** payload words, **zero** anomalies — a delay set with two members would have
  convicted the table;
- **the drain word → D = the input `tlast` word, delay 2 cycles**: it exists at exactly
  **N ≡ 0 and N ≡ 7 (mod 8)** and nowhere else (376 of 141 376 words, and 376 is exactly
  the count of those two residues in the range), takes its octets from **one** input word,
  and carries **two** octets at N ≡ 0 and **one** at N ≡ 7 — the table's own claim, term
  for term. The table's reason for stating this case separately is sound and is the sharp
  part of the repair: at those two residues **there is no input word m+2**, so a rule
  written as *"always the later of the two source words"* names a word that never arrives
  and a monitor built from it waits forever at two of eight residues;
- **`hdr_valid` → D = input word 1, delay 1 cycle** ✓ (input word 1 completes the
  ethertype at positions 4–5 and its `tkeep` decides the frame is not short);
- **`error_short_frame` → D = the input `tlast` word, delay 1 cycle** — checked against
  §9's own pin, which is unmoved: *"one after the input word carrying that frame's
  `tlast`"*;
- **straddle**: 141 000 of 141 376 payload words (99.7%) are assembled from **two** input
  words, h = 14 ≡ 6 (mod 8) — the §0.5 verdict the repair states, measured rather than
  quoted. The 376 exceptions are exactly the drain words.

**Scope of this check, stated because a bounded check that does not state its bound is a
claim**: it verifies M06's four-event table and its two §0.5 verdicts. **It is not a check
of M10 or M14's tables** (I checked M14's `ip_hdr_valid` row at (c) because REQ-611
depends on it, and nothing else), and it is not a check of §6.1's field offsets, which I
read but did not re-derive.

**What moves for me at item 1: nothing at M06 and M10** — I hold no attack plan for either
and no committed test drives either module. **At M14 it is (d)'s three rows**, and the
mover there is §0.5's 2026-08-04 ruling rather than this diff.

**Two sites the round did not name, checked and found sound.** `nic_top.md` §7/§10 pins
end-to-end per-octet constants of 54 and 50 and commissions a whole-design tagger, but
makes **no** gap-invariance claim and has no REQ-016 instance at its XGMII input, so it is
not a fifth site. `udp_ip_rx_64.md` §7's *"Unlike SPEC-M14 §7's parse latency, this figure
is gap-invariant"* is **true**: M17's header is one word, so its header-record latency is
already a delay from its own deciding input word, and h = 8 does not straddle.

---

#### (h) What I refused, and what I am carrying rather than doing

- **I refused to widen my write set.** This is a countersignature round: the signatures
  live here, transcription into `docs/specs/**` is the orchestrator's clerical act
  (PROTOCOL §6, the 2026-08-03 and 2026-08-10 precedents), and **not one byte of
  `test/**` or `agents/handoffs/**` is touched** — including the three `AP-M14` rows at
  (d) and the stale quotation in `AP-M04` row `M04-J3`, both of which I could have fixed
  in the same tree and both of which belong to a round that opens those plans with a
  change-log row.
- **I refused to decide `FINDING AP-M04-2` and `FINDING CSG-3`.** Both are routed
  undecided, as `AP-M04-1` was; a countersigner who rules on his own findings is not a
  second key.
- **I refused to read RTL or reference source.** The reference-side claim inside `CSG-3`
  is carried from my own countersigned derivation and is labelled as carried at the point
  of use; a fresh static read would have been the over-reach `RV-C4` §12 convicts.
- **I refused to re-status any plan row from a ruling.** `M04-J1` and `M04-J3` stay where
  my own filing said they would, which is the promise the filing made.
- **Harvest: none owed and I say so rather than leave silence.** PROTOCOL §7 and charter §8
  attach the note to every module sign-off and every phase gate; this is neither. The span
  opened at `J-dv_lead-0168` stays open and **this entry joins it** with `J-dv_lead-0169`;
  all three are mined at the next `SO-` or gate.

### Actions

1. Read the charter and PROTOCOL in full; ran the precheck; read the diff hunk by hunk and
   then each repaired passage in place at HEAD.
2. Wrote and ran the two independent check scripts of Evidence 1 and 2 **before** reading
   `J-architect_docs_lead-0038`, so that agreement is agreement and not transcription.
3. Measured the two co-simulation producers' admission guards at HEAD against the diff's
   claim about them (Evidence 3).
4. Read my own countersigned C-27 disposition, `FINDING ECS-3`, `WO-0078` §6.3 and §7, and
   the `SO-` gate table, at their sources.
5. Checked `AP-xgmii_tx_64` rows `M04-J1`/`M04-J3`/`M04-J4` and `AP-ip_eth_rx_64` rows
   `M14-F1`/`F2`/`F3` against the repaired requirements (Evidence 4).
6. Wrote this entry, carrying three countersignatures, two findings and one correction of
   record. **No `git add`, no `git commit`, no `git push`, no git write of any kind.**

### Evidence

Reproducible from a checkout at this commit. The two scripts read no repo file and depend
only on the specification rules quoted inside them, so they re-run anywhere.

**1. M04, the wire stream materialised from SPEC-M04 §6.1's construction rules and the
octet times read off it** (the check `FINDING AP-M04-1` is sustained by, done the long
way rather than by the closed form):

```python
C = 100
def build(n):                     # returns input/output octet times per frame octet
    i_ot = {j: 8*(C + j//8) + j % 8 for j in range(n)}          # §0.5 Axi64 octet time
    wire = [(C+1, l, "pre") for l in range(8)]                  # REQ-201 preamble word
    o_ot = {}
    for j in range(n):            # §6.1: word m accepted at C+m is sent at C+m+2,
        m, b = divmod(j, 8)       #        lane = byte position (REQ-012, no rotation)
        wire.append((C+m+2, b, ("F", j))); o_ot[j] = 8*(C+m+2) + b
    return i_ot, o_ot, wire
lat, evt, dcs, bad = set(), set(), set(), []
for n in range(14, 1515):
    i_ot, o_ot, wire = build(n)
    ls = {o_ot[j] - i_ot[j] for j in range(n)}
    lat |= ls
    if len(ls) != 1: bad.append(n)
    evt.add(8*(C+1) - 8*C)        # both events at octet position 0 of their words
    dcs.add(min(c for (c, l, t) in wire if isinstance(t, tuple)) - C)
print(sorted(lat), sorted(evt), sorted(dcs), len(bad))
```

Observed, re-run at this working tree (full script, with the pad/FCS/terminate tail
materialised as well, at
`/tmp/claude-0/-home-user-agentic-fpga/681e6e34-cd2f-5f3e-a4c3-42391e4d282b/scratchpad/m04_latency_check.py`
— an **ephemeral** path, stated as such per ADR-0003/F5; the script above is the durable
form and reproduces every number):

```text
lengths swept        : 1501 (N = 14..1514 octets, DA..payload)
sub-sweep 60..1514   : 1455
per-octet L values   : [16]
frames with L not single-valued: [] count 0
event delay (octet times): [8]
Delta C (cycles)     : [2]
identity check       : L = 8*dC - h  ->  16 == 16 True
identity check       : dC = (L+h)/8  ->  2 == 2.0 True | (L+h) mod 8 = 0
event delay vs L     : L - event = 8 octet times = exactly one word (the preamble word)
```

**What it buys, and what it does not.** `deviations: 0` over **1501** lengths sustains the
finding independently of the architect's 1455-length sweep and **extends it over the 46
padded lengths below 60** (1501 − 1455) that sweep excluded. It does **not** measure any design: M04 has
no RTL bench in this repository and none was run.

**2. M06, the four-event table checked against §6.1's assembly rule** (bounded independent
check, `.../scratchpad/m06_event_check.py`, ephemeral path, durable logic below):

```python
for N in range(14, 1515):
    K, P = -(-N//8), N-14
    M, tlast_word = -(-P//8) if P > 0 else 0, K-1
    for m in range(M):
        src = {(8*m+pos+14)//8 for pos in range(8) if 8*m+pos < P}   # §6.1 assembly
        later, emit = max(src), 3+m                                  # §6.1 gapless cycles
        drain = (later == m+1)                                       # no input word m+2
        D = tlast_word if drain else later
        assert emit - D == (2 if drain else 1)                       # §7's table
```

Observed:

```text
N swept                : 1501 (14..1514)
ordinary payload words : delay-from-D histogram: {1: 141000}
drain words, keyed by N mod 8 -> {(delay, #src words, P mod 8)}:
   N mod 8 = 0 -> [(2, 1, 2)]
   N mod 8 = 7 -> [(2, 1, 1)]
hdr_valid delay from input word 1: [1]
payload words assembled from TWO input words: 141000 of 141376 (99.7%)  [h = 14, h mod 8 = 6]
anomalies: [] count 0
```

**3. The two producers' admission guards, measured at HEAD** — the evidence for the diff's
*"a guard closed by the terminate character alone is wider than this rule"*:

```sh
sed -n '245,262p' test/cosim/ours_run.ml   # FI-4: refuses any /S/ while admission_open
sed -n '273p'     test/cosim/ours_run.ml   # span closes ONLY on has_terminate word
grep -n "admission_open" test/cosim/tb_xgmii_rx_64.v | head
grep -n "clear" test/cosim/ours_run.ml     # :450-457 one pulse before the trace, never mid-run
```

Observed: `ours_run.ml:249-255` raises *"a second start character arrived while a frame's
admission span was open"*; `:273` is `if !admission_open && has_terminate word then
admission_open := false;` — **terminate only**, so an `/E/` closure leaves the span open and
`M03-H3`'s geometry is refused by a guard whose subject it is not (`FINDING ECS-3`,
unchanged at HEAD). `clear` is pulsed once at `:454` and cleared at `:457`, never mid-trace.

**4. The plan rows this round measured** (statuses read from the files, not remembered):

```sh
grep -n "M04-J1\|M04-J3\|M04-J4" test/attack_plans/AP-xgmii_tx_64.md
grep -n "M14-F1\|M14-F2\|M14-F3" test/attack_plans/AP-ip_eth_rx_64.md
grep -rn "M14-F1" --include=*.md agents docs test | grep -v AP-ip_eth_rx_64   # returns nothing
git log --oneline -1 -- test/attack_plans/AP-ip_eth_rx_64.md                  # 60721cc, 2026-08-03
```

Observed: `M04-J1` ASSERT / `M04-J3` NO-ASSERT / `M04-J4` NO-ASSERT, all three consistent with
the repaired text; `M14-F1` **ASSERT** asserting *"the per-octet constant L = 12 is unchanged
for every octet"*; the cross-repository search for any record of that staleness returns
**nothing**; and the plan's last commit predates §0.5's 2026-08-04 ruling.

**5. The precheck**, as run — reproduced under Trigger.

### Outcome

**Three countersignatures, all COUNTERSIGNED; nothing contested.** DoD for a
countersignature round: met.

**THE COUNTERSIGNATURE TEXTS — written for the orchestrator to transcribe verbatim into
`docs/specs/requirements.md` §13 (columns: Date | REQ | Change | Class | Commissioned by |
Journal). The orchestrator fills its own journal id in the last column.**

**Row A — REQ-210 + §0.5 (front offset h). IN FORCE from this row.**

```
| 2026-08-11 | REQ-210, §0.5 (**front offset h**) | **Countersignature transcribed — REQ-210's repaired opening clause and §0.5's inserting-module clause are IN FORCE from this row.** dv_lead COUNTERSIGNED at `816e187` by re-derivation and not by reading: M04's wire stream was materialised from SPEC-M04 §6.1's own construction rules — preamble word at C+1, source word m accepted at C+m transmitted at C+m+2 with lane = byte position, then REQ-203's pad, the FCS and the terminate character — and the octet times read **off the stream**, over **1501** frame lengths (N = 14 … 1514), which is the ruling's 1455-length sweep **plus the 46 padded lengths below 60 it excluded** (1501 − 1455), the region where a tagger has wire octets with no input octet to match. Result: **L = 16 at every frame octet of every frame, zero deviations**; event delay **8** octet times; **ΔC = 2** by the clause's own definition (first output word carrying an octet *of the frame*); both identities close and (L + h) ≡ 0 (mod 8); **L − event delay = 8 = exactly the preamble word**. `AP-xgmii_tx_64` rows `M04-J1` (ASSERT, the event delay) and `M04-J3` (NO-ASSERT, reports 16) are correctly statused against the repaired text and **neither moves**. The refused alternative is agreed on dv's own ground: repairing §7's pinned 8 would have left the **only** quantity whose two events are both named as an unpinned consequence, so pinning both is the sole repair under which each landed row keeps a basis. **One finding filed without holding the diff out of force**: `FINDING AP-M04-2` (MINOR) — SPEC-M04 §7's new closing sentence claims M04's per-octet constant *"does survive REQ-016's idle injection"*, a property over stimulus this same specification twice declares has no instance here (§3's REQ-016 row and §7's handshake bullet; REQ-016's own carve-out, REQ-206's underflow), routed to architect_docs_lead as a narrow spec-diff request | transcription — no normative text moves in this row; it records that the row above's condition ("not in force until transcribed") is discharged, with `AP-M04-2` outstanding against one sentence of SPEC-M04 §7 | dv_lead, `FINDING AP-M04-1` at `AP-xgmii_tx_64` §8 item 1; countersignature of record `J-dv_lead-0170` §(a) | `J-orchestrator-NNNN` |
```

**Row B — REQ-611. IN FORCE from this row.**

```
| 2026-08-11 | REQ-611 | **Countersignature transcribed — REQ-611's repaired scoping and its per-event invariant are IN FORCE from this row, and dv's own earlier signature is corrected in the same act.** dv_lead COUNTERSIGNED at `816e187` after verifying all three claims at the module: M14 **straddles** (h = 20; payload word j is assembled from input word j+2 positions 4–7 and input word j+3 positions 0–3, so k injected idles between them give one output word **two** latencies, 12 and 12 + 8k, which REQ-011 forbids resolving by splitting the word); REQ-611's old clause was **unsatisfiable** (one idle inside the header puts input word 2 at Ci+3 and the pulse at Ci+4, a figure of 4 where the requirement demanded 3); and the replacement is **achievable and equivalent** — `ip_hdr_valid`'s deciding input word is input word **2**, the word completing the 20-octet header, at a delay of **1 cycle on every stimulus**, which is the same fact as C-27's growth rule seen from the other end. **Correction of record, dv's own**: the countersigned disposition at `WO-0020` reads *"**C-27 — REAFFIRMED.** L = 12 named as the gap-invariant constant is the right discharge for REQ-611's gap clause"*, and that sentence carries two claims — **C-27's conclusion is REAFFIRMED and untouched**, while **the second clause is WITHDRAWN as falsified** by §0.5's 2026-08-04 straddle ruling. The re-countersignature is on better ground than the one it replaces | transcription — no normative text moves in this row; the pinned 3, the growth rule, L = 12, h = 20 and ΔC = 4 are all unchanged in value | dv_lead, carry-forward **C-27** (dv's own, minted at WO-0018 and countersigned at WO-0020); countersignature of record `J-dv_lead-0170` §(c) | `J-orchestrator-NNNN` |
```

**Row C — REQ-901. THE NORMATIVE ONE: IN FORCE from this row and not before.**

```
| 2026-08-11 | REQ-901 | **Countersignature transcribed — the admission rule, the derive-from-this-document obligation, restriction parts (i) and (ii), the record-only licence and no-class-declared are IN FORCE from this row.** dv_lead COUNTERSIGNED at `816e187` after four checks. **(1) The span** is SPEC-M03 §9's list member for member and citation for citation — five closures, no drift — and REQ-110's new clause carries four and names §9 for the fifth. **(2) Gate condition (c) is MET as `FINDING ECS-3` reshaped it**: the rule is spec text, both producers are required to derive admission from **this document and never from each other**, and it lands before either producer is opened — the diff touches no byte of `test/**`. The guard-width sentence is dv's own measurement and still holds at HEAD (`test/cosim/ours_run.ml:273` closes the span on a terminate character alone, so `M03-H3`'s `/E/` geometry is refused by a guard whose subject it is not). **(3) Part (ii) is necessary, checked and not accepted**: a determinate "open" puts the `/E/`-then-`/S/` geometry outside part (i), and its reference-side outcome is a frame **merge**, which is a divergence in the ordered sequence of output frames — and no declared class excludes at the sequence level, (e) and (f) excluding a frame, (g) three per-frame observables and (h) a per-frame decision. **(4) No class declared** is the same disposition dv countersigned at `4e7331b`, and `FINDING CSG-1`'s four cases/three outcomes/two merges is why. **What the record-only licence permits and does not, stated by dv in its own words so the record has two keys** (`J-dv_lead-0170` §(e)(5)): it permits driving either restricted situation and **emitting both designs' observed dispositions as data**, and it permits a later class to be declared by spec diff on that measurement; it **compares nothing** (no verdict, no exit code, no tier, and it selects **no branch** of `WO-0078` §7 and is **no `CD` §10 case instance**), **adjudicates nothing** (no defect, no class, no `BUG-`), **anchors nothing and is citable by no packet** (expressly not for REQ-105's or REQ-110's delivered-octet clauses, which rest on directed tests alone), **licenses no expected value** (ADR-0015 D2), **does not lift `FI-4`/`FI-6`** by itself, and a report omitting the on-its-face statement **is not a record-only run but an unadjudicated comparison**. **One MATERIAL finding filed without holding the diff out of force — `FINDING CSG-3`**: the restriction is stated over two of the five closure events, and **REQ-108's truncation closure is uncovered** while the lift clause for class (f)'s frames opens it; a >1518-octet frame with **no terminate character** followed by an XGMII-lane-0 start character closes on our side and stays open on the reference's, so the **following** frame — which class (f) does not exclude — is swallowed and its accept-or-discard decision diverges at the sequence level. Not live today (both guards refuse it), live the moment a producer is narrowed to the rule; routed to architect_docs_lead with two candidate cures and decided by neither. dv binds its own side meanwhile: **`FI-4` and `FI-6` are not narrowed for the truncation-closure geometry until `CSG-3` is ruled** | transcription — the normative diff of the row above enters force here; this row itself moves no text | dv_lead, `FINDING ECS-3` and `WO-0078` §6.3's gate condition (c); countersignature of record `J-dv_lead-0170` §(e) | `J-orchestrator-NNNN` |
```

**Handoff.** No packet is written this round (write set: this journal only). The
countersignatures above are the signatures of record, in the form PROTOCOL §6 and the
2026-08-03 / 2026-08-10 precedents use: **authority lives in this entry; the §13 rows are
clerical and commit under `Agent: orchestrator`.**

### Open-questions

1. **`FINDING AP-M04-2`** (MINOR) — SPEC-M04 §7's REQ-016 survival claim over a stimulus
   class this specification twice declares empty. **Route**: architect_docs_lead, narrow
   spec-diff round. **Not blocking**: M04 has no bench, and `AP-xgmii_tx_64` §6's REQ-016
   row already records the absence structurally.
2. **`FINDING CSG-3`** (MATERIAL) — the restriction's coverage is short by the truncation
   closure, and the lift clause opens it. **Route**: architect_docs_lead. **Becomes
   blocking** at the round that narrows either producer's admission guard; until it is
   ruled, dv keeps both guards wide for that geometry (§(f)).
3. **Owed by me, at the round that next opens the plans**: `AP-ip_eth_rx_64` rows
   `M14-F1` (ASSERT of a per-octet L under injection — it fails a conformant M14),
   `M14-F2`'s trailing `L = 12` clause and `M14-F3`'s ground, all three stale since
   §0.5's 2026-08-04 ruling and recorded nowhere until now; and `AP-xgmii_tx_64` row
   `M04-J3`'s quotation of REQ-210's struck opening clause plus a §9 change-log row
   recording `AP-M04-1` as sustained and cured.
4. **Owed by me, in `agents/handoffs/`**: `SO-xgmii_rx_64.md`'s Stage-3 gate table records
   condition **(c) UNMET**; on transcription it becomes **MET**, leaving **(b)** and **(e)**
   as the two outstanding conditions. The table is dated evidence at its own SHA, so it is
   not wrong — but it must be re-measured in the round that next opens the `SO-`, and
   `WO-0078` §6.3's gate paragraph wants the same note.
5. **The record-only run's machinery does not exist**, and it is mine. A run that
   *"compares nothing"* needs a lane that lifts the guard for one case, does **not** invoke
   the adjudicating comparator (or discards its verdict and labels the output), prints the
   on-its-face statement, and registers as **no** `CD` case instance. That is a work-order
   round, sequenced after `CSG-3` is ruled and after `WO-0078`'s conditions (b) and (e).
6. **Standing and untouched by this round**: `DVC-1a` (still unbuilt, still wanted by two
   plans); `AP-M04` §8 items 2–6; `SO-xgmii_rx_64.md` §3.9's carried set, none of whose
   subjects moved.

### Files-in-this-commit
- (none)

## [J-dv_lead-0171] 2026-08-11T22:40Z | task:none | The M04 bench era opens with a work order whose hardest content is a negative — the receive era's schedule model has no counterpart at a handshaken port, so the acceptance cycle is observed rather than derived, and every constant in the packet hangs off that one observation

### Trigger

Orchestrator dispatch, with a **declared sibling** (`architect_docs_lead`, write
set `docs/specs/**` plus its own journal, ruling `FINDING CSG-3` and `FINDING
AP-M04-2` — both mine, both routed undecided at the entry before this one). The
commission is the **first work-order packet of the M04 bench era**, under the
attack plan `AP-xgmii_tx_64` that landed at `8f81568`: choose the round's scope,
specify the bench capability layer, write the regime facts the worker must carry,
and mark what the round does not carry.

**Abort-first head check, before reading anything.** `git rev-parse HEAD` →
`9d68d107bf88525980aaeaffc36cefba742f5d94`, byte-equal to the dispatched
spawn-head `9d68d10`; `git status --short` returned **zero lines**; branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`. Exact match, so neither branch
of the abort procedure was reached.

**Incident eight, and what I did about it: nothing, deliberately.** The dispatch
records that a prior spawn of this round was stopped two minutes in when a
container rollback was detected, and that the repo was restored and re-verified.
I did not look for that spawn's partial and did not reconstruct from it. The tree
at `9d68d10` is the whole of my input.

**HEAD MOVED MID-ROUND, and the reconciliation is recorded rather than absorbed.**
On my final state check — after the packet was written and this entry first
drafted — `git rev-parse HEAD` returned **`ee47eee`**, not the spawn-head. The
**declared sibling** had landed: `J-architect_docs_lead-0039`, touching
`docs/specs/modules/xgmii_tx_64.md`, `docs/specs/requirements.md` and its own
journal — **three paths, all outside my write set, none of them mine**. What I
did, in order and before writing another line of the packet:

1. **Re-verified R3 against the new HEAD.** `git show HEAD:…v08.md` is
   **312,998 bytes** and is a byte-prefix of my staged file (`cmp` clean). The
   sibling did not touch my journal, so the append-only property holds against
   `ee47eee` exactly as it held against `9d68d10`.
2. **Re-measured every base figure in the packet's §12** at the new HEAD:
   `139`, `0`, `17`, `0` — **all four unchanged**, and `git diff --stat
   9d68d10..HEAD -- test/` is **empty**, which is the reason rather than the
   coincidence. The bars were then rebased to cite `ee47eee`.
3. **Read the sibling's diff at the source** and reconciled the packet to it
   (Reasoning 14). **Both findings the dispatch told me were being ruled were
   ruled**, and both are mine: `FINDING AP-M04-2` **SUSTAINED and cured**, with
   carry-forward **C-5 CLOSED** in the same diff, and `FINDING CSG-3`
   **SUSTAINED and cured**.

**The rule I applied, stated because the tempting alternative was to say
nothing**: the packet is the worker's ground truth, so a packet that cites a
specification SHA the tree has moved past is wrong in the one way this
programme's honest-enforcement model cannot catch — it looks right. Rebasing it
cost four edits. Leaving `9d68d10` in eight places would have cost a bounce and a
finding.

**Entry id checked at the file rather than taken from the dispatch.** The chain's
tail at HEAD is `J-dv_lead-0170`; R5 admits `-0171` and that is what this is.

**The journal-size report the dispatch asked for, and it is worse than the
dispatch's estimate.** Measured, not recalled:

- `agents/journals/claude_dv_lead_agent.v08.md` at HEAD: **312,998 bytes**
  (`git cat-file -s` agrees with `stat`, so it is the blob and not a working-tree
  artefact).
- ADR-0017 §5's soft threshold `S` = 256 KiB = **262,144**. The file is
  **50,854 bytes OVER `S`** — the margin is **negative**, not the ~40 KB of
  headroom the dispatch's "~215KB" would have implied.
- The hard threshold `H` = 512 KiB = **524,288**. Still **211,290 bytes under**
  it, so R10's refusal does not fire and this commit is admissible.
- **The WARN fired one entry ago, not this one.** Before the previous entry the
  file was **256,934 bytes** — 5,210 *under* `S`. So `WARN-JOURNAL` first fired on
  that entry's commit, and R10's remedy — *"rotate to volume 09 at your next
  entry"* — names **this** entry. **Rotation is therefore not merely due, it is
  one entry overdue.**
- **I did not rotate, and the reason is scope rather than judgement**: the
  dispatch's write set names `…v08.md` specifically, and a rotation creates a
  **new path** (ADR-0017 §4.3) — outside the declared set. I say so rather than
  rotate silently or leave the arithmetic unstated. **`v09` must open at
  `J-dv_lead-0172`**, and the next dispatch should carry that path in its write
  set. The `WARN-JOURNAL` will fire again on this commit and it will be correct
  both times.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, **in full, before any
  edit** (§3's attack-plan and delegation mandates; §6's write scopes; §10's
  independence rules).
- **`test/attack_plans/AP-xgmii_tx_64.md` at `8f81568`, entire** — §0.1's three
  standing rules, §0.2's prohibition register, §1's reading rules, §2's seven
  standing obligations, §3's stimulus legality, §4's identity and all fifteen row
  tables, §5's ten rejected attacks, §6/§6.1's coverage map and converse rule,
  §7's machinery table and **§7.1's BAR T1**, §8's six open items, §9.
- **`docs/specs/modules/xgmii_tx_64.md` at `816e187`** — the header (freeze SHA,
  implementation path), §1–§3, §4.1/§4.2/§4.3, §5, §6.1 entire including the
  cycle-by-cycle table and the storage paragraph, §6.2's state table, §6.3's five
  unconstrained items, **§7 entire** (the repaired two-constant latency bullet,
  the `tx_tready` bullet with C-14.1, the C-16 bullet with its four consequences,
  the handshake bullet, the reset bullet), §8, §9 with its strobe pin and
  co-occurrence bullets, §10's hook table, §13.
- `docs/specs/requirements.md` §0.3, §0.5, §0.6, §9.1 and REQ-016's own text;
  `docs/specs/ifc_check/xgmii_tx_64_ifc.ml` and `docs/specs/ifc_check/dune`.
- **The machinery surfaces, read to answer §5.1's capability table by measurement
  rather than by inference** (§0.1(iii)): `test/xgmii/tx_decoder.mli`,
  `test/xgmii/frame.mli`, `test/xgmii/xgmii_word.mli`, `test/xgmii/dune`,
  `test/xgmii_probe/xgmii_probe.ml` (header and every top-level `let`),
  `test/axi64_probe/axi64_driver.ml` (header and every top-level `let` — it has
  **no `.mli`**), `test/axi64_probe/dune`, `test/monitors/stream_word.mli`,
  `test/monitors/strobe_monitor.mli`, `test/monitors/conservation_monitor.mli`
  (val list), `test/monitors/dune`, `test/golden/crc32_ref.mli`,
  `test/golden/dune`.
- **`test/xgmii_rx_64/bench.mli` entire and `bench.ml`'s `create` and
  `sample_cycle` bodies** — the landed `Cyclesim` idiom and the `Before`-view
  reasoning, read as the thing the M04 loop adapts.
- **The packet precedents**: `agents/handoffs/WO-0038_tb-m03-first-bench.md`
  §§1–8 (the first-bench form); `WO-0072_m03-family-k-clear.md` §§12–19 (the
  mature form: cost, bars by seat, bounces, traps, the allow-list, the two
  standing clauses, the sequencing rule) and its `FINDING K-3`;
  `WO-0071_m03-family-m-co-occurrence.md`'s section list.
- **`tools/dv_checks.sh`** — the inventory and census blocks read in full, to
  measure what they do and do not see (§9.7 of the packet).
  `.github/workflows/build.yml`'s step names, read so bar M-2 names real steps.
- **My own two prior entries**, `J-dv_lead-0169` (the plan round) and
  `J-dv_lead-0170` (the countersignature round, its §(b) `AP-M04-2`, §(d)'s M14
  rows, §(f) `CSG-3`, §(h)'s refusals).
- `git show 816e187 -- docs/specs/modules/xgmii_tx_64.md` in full — the diff that
  landed **after** the plan and that the packet must carry.
- **No file under `libs/**`, `top/**`, `rtl_snapshots/**` or
  `test/third_party/**` was opened.** One honest qualification: I ran `ls -la
  libs/hardcaml_ethernet/src/` to confirm that
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` exists at this SHA (17,088 bytes) —
  a **directory listing**, no file opened, and the fact I wanted from it is one
  SPEC-M04's own header already states. Recorded because §0.1(i)'s discipline is
  that the difference between a record and a measurement is marked, and because a
  listing is the nearest I came to the boundary.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

**1. The round's real find, and it is structural rather than a defect: there is no
`Arrival` at a handshaken port, and there cannot be.** `AP-M04` §7 item T-3
answered the *placement* question — a driver exists, withholding a word is a bench
presenting `tvalid` = 0 — but it did not ask the question this packet had to
answer, which is what the **schedule** is. At M03 `test/xgmii/arrival.ml`
precomputes the entire cycle table before a cycle is driven, because a wire has no
handshake and the link partner's timing is the bench's to choose. **At M04 whether
a word is accepted on a cycle depends on `tx_tready`, a DUT output.** So there is
nothing to precompute: the presenter is reactive, and the first thing the bench
learns from the design is `C`, the cycle its first word was accepted.

Everything else in the packet follows from that one sentence, and I wrote it as
§0's four numbered consequences rather than leaving it to be discovered:
the `Before`-view read becomes load-bearing for **correctness** and not only for
labelling (an `After` read shifts `C` and silently corrupts every derived
constant); the source must never stop mid-frame, because at this port a withheld
word is REQ-206's underflow and not REQ-016's gap; and the cycle after the `tlast`
acceptance has `tready` = 1 with `tvalid` = 0 and means nothing at all, which
every run in the round passes through.

**2. `C` is observed, and that is what makes `M04-A5` executable rather than
decorative.** SPEC-M04 §6.3 item 4 leaves the idle-word count before the first
frame unconstrained, and §7's reset clause makes the first two cycles' `tready`
zero. So no absolute start cycle is derivable and none may be asserted. The
packet therefore states **every** expected value relative to `C` and adds two
guards that are deliberately *not* assertions: a **liveness bound** (fail if no
acceptance by cycle 16, with the message saying it is a liveness bound and not a
timing claim) and **`P-ACCEPT`**, the acceptance-contiguity precondition.

`P-ACCEPT` is the piece I spent longest on and it is the one I most expect to be
argued with. Mid-frame acceptance contiguity **is** forced — §6.1's *"a source
word accepted on cycle `C + m` is transmitted on cycle `C + m + 2`"* read with
§7's *"one XGMII word emitted every cycle, always"* means the wire cannot gap
mid-frame, so acceptance cannot either. Having derived it, I could have made it
a row. **I refused**: it is REQ-207's territory, REQ-207 is family H's, and a
round that asserts a requirement it did not commission has widened its own scope
by arithmetic. So it ships as a **precondition of the packet's own arithmetic**,
firing before any row assertion and disclaiming REQ-207 coverage in terms, with
its failure routed to me as disposition class D3. The distinction — a guard whose
failure invalidates the reading, versus an assertion about the design — is
`Arrival.check`'s own shape one port over, and the packet says so.

**3. Scope: thirteen rows, and the cut is principled rather than arithmetic.**
The rule is one sentence and it is checkable: **every run drives exactly one frame
into an idle transmitter from a source that presents every word.** That single
rule excludes, without any further judgement, every row that is a property of a
**run** (A3, B3, families F, I) and every row that **perturbs** the clean path
(families G, H, K, L, M). What remains that the rule admits is A1/A2/A5, B1/B2/B4/
B5, all of C, all of D, and E1–E4 — 23 rows. `WO-0038` took 11.

So a further cut was needed and I made it at **D and E**, with grounds:

- **Family D is deferred because it is the cheapest possible second round.** It
  needs **no new capability at all** — every row of it runs on this round's
  scaffolding and its directed-length runner. A capability-heavy first round
  should be followed by the cheapest coverage available, not by another
  capability. And the honest cost is stated rather than hidden: obligation 1's
  decoder judges REQ-202 on **every** frame from unit one, so this round *depends
  on* the FCS being right while *claiming* nothing about it — except at `M04-C3`,
  which the plan's own coverage map homes under REQ-202 as *"the pad's coverage,
  which is REQ-202's clause read at REQ-203's stimulus"*. The packet says that in
  §1.3 and turns it into a bounce (`BM8`) so a clean decoder report can never be
  written up as REQ-202 coverage.
- **Family E is the closest call in the packet and I say so in it.** `M04-E1` is
  the eight-lane terminate sweep — the plan's own centrepiece, *derived* from the
  identity rather than sampled — and four of its eight members are already inside
  `M04-B4`'s directed set, so the marginal stimulus is nearly nothing. It is held
  back on size alone: 17 rows plus a from-scratch reactive presenter is the
  overload the dispatch warned against and `RV-C4` §12 convicts. **The derivation
  is banked rather than lost**: §6.1 tabulates `t` and the terminate cycle for
  every length the round drives, so family E's round inherits a CI-exercised
  arithmetic instead of a fresh derivation.

**4. A derived fact that contradicts the intuition every bench author brings, and
it would have been written wrong.** `⌊F/8⌋ = 8` for every `F` in 64 … 71, so
**seven of the eight lengths in the directed set terminate in the same cycle,
`C + 10`, at seven different lanes.** The lane moves and the cycle does not. I
tabulated the terminate cycle for all eight members explicitly rather than giving
the formula, because a formula is where an author's intuition substitutes itself
for the arithmetic, and this is exactly the cell where it would.

**5. `FINDING AP-M04-3` — MINOR, against my own plan, found while writing the
instrument that would execute it.** `AP-M04` rows `M04-B2` and `M04-C4` state
their observable as *"the poison value appears **nowhere** in the whole run"* and
*"0xA5 appears **nowhere** on the wire"*. **Both universals are falsifiable by
arithmetic**: the four FCS octets are a computed value that may legitimately equal
any octet including the poison, at roughly a one-in-sixty-four chance per frame —
not a theoretical objection, a coin flip a later content change would eventually
lose. The rows' **substance** is right; their **quantifier** is one octet class
too wide.

The packet cures it operationally at §6.0(c): the poison scan's domain is wire
octet indices `0 … F−5` — DA through the last pad octet — with the four FCS
octets **excluded and the exclusion's reason stated**, because the FCS is judged
against the oracle and never by a scan. **The plan's own text is not repaired
here**: `test/attack_plans/**` is outside this round's write set, and the repair
rides with the `M04-J3` quotation repair already owed at the next round that
opens the plan. Class MINOR, mine, cured in the instrument before it was ever
executed — which is the only reason it is a finding rather than an incident.

**6. And the anti-vacuity ground for the poison scan is made *provable* rather
than checked, which is the better half of the same repair.** The round's content
builder is fixed at `content j = 1 + (j mod 127)`, range `0x01 … 0x7F`. Three
properties fall out and each is load-bearing: no content octet is ever `0x00`, so
*"wire octets 20 … 59 are all zero"* stays a claim about **padding** rather than
one that happens to hold of the content; no content octet is ever `0xA5`
(165 > 127), so the poison scan **cannot** be falsified by the stimulus; and the
period 127 is coprime with 8, so a lane reversal, a byte swap and a rotation by 4
all change the string. **The third property is stated with its bound rather than
as a universal** — the smallest word-granular rotation the pattern cannot see is
127 words, 1016 octets — because a claim of "any rotation" would have been the
same over-wide quantifier I had just convicted two rows for.

**7. The regime facts, written as numbered obligations because the packet is the
propagation vehicle.** The first harvest's `L-F02` is that the worker reads its
work order and not the org's history, so §9 restates rather than cites: the
**SHA** rule (a sentence asserting a census is not the census — every count in the
return is a raw measured figure), the **domain** rule (a universal over "the
bench" is measured over every producer — and its instance here is favourable and
stated, because BAR T1 means M04 has exactly **one** producer today and any
universal must be re-measured, not re-quoted, the day a second lands), and the
**polarity** rule from `RV-0078-S2-13`, which §5.1's capability table pays by
naming the file read to establish each absence.

**8. The underflow family does not ride this round, and answering the dispatch's
conditional honestly meant carrying three of its facts anyway.** Family G is
excluded, but REQ-206 is *why* M04's source interface has no idle tolerance, so:
the presenter must never withhold mid-frame and **no idle-injection wrapper may be
built at M04's source** (`BM6` — the condition I would most regret discovering
late, because it manufactures aborted frames while looking like conformance
stimulus); the post-`tlast` cycle is legal and not an underflow; and — the one I
think most valuable — **the round's empty strobe set is NOT a discharge of
`M04-G4`**. Every unit here incidentally satisfies G4's silence half, and G4
additionally asserts `tx_tready` = 1 at that cycle, which this round asserts
nowhere. Naming G4 anywhere is a bounce. The row is the highest-value row in its
family precisely because the defect it kills is REQ-206 read to its first full
stop, and letting it be discharged by accident would have cost the module its
sharpest single test.

**9. The census does not see M04, and I measured that rather than assuming it
either way.** `tools/dv_checks.sh`'s row-discharge census is hard-keyed to
`census_plan='test/attack_plans/AP-xgmii_rx_64.md'`, to the pattern
`M03-[A-Z]+[0-9]+`, and to unit titles under `test/xgmii_rx_64/`; its bench
inventory has a per-file loop over that same directory **and** a repository-wide
figure over `test/**/*.ml`. So **no M04 row is countable by any committed
instrument**, and the only figure that moves when this round lands is the
repository-wide one, `139 → 149`. Two consequences went into the packet: the unit
titles are read by **me** and by no script, which makes §11.1's title rule a real
obligation rather than a mechanical one; and bar M-3 is stated as a **delta**
against a measured base. Extending the census is mine and `tools/**` is outside
this round's write set (§19.3 item 1).

**10. Every tree-quantified bar was executed at the base before it was written,
because my own finding says a bar that has not been is a hope.** `FINDING K-3`
(`RV-0072-VERDICT`) convicted three of my seven bars at the previous first-bench-
class round, all failing the same way. So: M-3's base is **139** measured; M-4's
base is **the directory does not exist**, measured by `git ls-files`; M-5's base
is **17 tracked files** under `test/xgmii_rx_64/`, enumerated; and M-7 — *"zero
occurrences of any `M04-` id anywhere in `test/**/*.ml`"* — is stated as a genuine
universal **only because I measured the base at zero**, which is the one condition
under which such a bar is safe. M-4 is additionally stated as a **set** and not a
count, on `RV-0071-VERDICT` §1's rule that a difference of totals cannot
distinguish "seven gained" from "eight gained and one lost".

**11. The two rulings that landed after the plan, carried rather than left for the
worker to trip over.** `FINDING AP-M04-1` is **CURED and CLOSED** at `816e187`:
SPEC-M04 §7 now pins two constants and names which is which. The packet's §3.1
records it and draws the only consequence that matters at this scope — **no
latency figure for M04 may appear anywhere in a round that measures none**. And
§3.2 discloses that my own plan row `M04-J3` still quotes REQ-210's *retired*
opening clause, so a worker who reads the row and cannot find the sentence in the
specification knows why and does not report it as a defect in their own reading.
That disclosure costs one paragraph and saves a bounce.

**12. What I refused.** I did not open `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`,
which exists and would have made §5's loop specification easier to write and
worthless. I did not commission families D or E although this round's own scope
rule admits them — the size ground is stated and is the whole argument, and
padding a first round with cheap rows is how a six-round review cycle starts. I
did not build the M04 census while writing a packet that depends on measuring its
absence, though `tools/**` is inside my charter scope: it is outside **this
round's** write set and a lead who widens his own set while telling a worker not
to has no standing to enforce `BM14`. I did not repair `AP-M04` for the finding I
minted against it. I did not rotate the journal. And I decided neither
`AP-M04-2` nor `CSG-3` — both are the architect's, both are marked in §19.1 with
their carriers, and a filer who rules on his own findings is not a second key.

**13. What the sibling's landing changed in the packet, and what it did not — and
the asymmetry is the round's cheapest lesson.** `FINDING AP-M04-2` is
**SUSTAINED**: SPEC-M04 §7's survival claim is struck and replaced by *"A bench
SHALL NOT build a REQ-016 idle-injection wrapper at this module's source
interface"*. **My packet had already forbidden that wrapper** — §9.4(1) and
`BM6`, written from REQ-016's own carve-out and §3's REQ-016 row rather than
from a ruling that did not exist. So the ruling did not change a rule; it changed
a rule's **authority**, from a lead's judgement to normative text, and §3.3(a)
now says so. **Not one derived constant, row status or bounce condition moved.**
That is what marking a dependency instead of guessing one buys: the packet was
correct under both outcomes and the landing was an edit rather than a rewrite.

Carry-forward **C-5** closing in the same diff is the half that did move
something, and it moved a **ground** and not a conclusion. `AP-M04` §2's
obligation 5 forbids asserting §0.6's strobe window on `error_underflow` because
the window *"has no reference word"* for a frame that never receives the octet.
Since `ee47eee` **it has one** — §0.6's new fourth clause gives it the cycle the
word was required and not presented, with a ceiling of `+ ΔC = 2`. **The
prohibition survives and is now better founded**: §9's pin sits at the window's
*near* edge, so §0.6 itself states the window carries no independent information
there. I rewrote §5.4(3) to the new ground rather than deleting the obligation,
and I did **not** re-derive §0.6's clause — reading a landed diff as text is not
countersigning it, the packet says so in terms at §19.1's closing paragraph, and
a countersignature is a round of its own.

**The two documents now disagree, and the disagreement is mine.** `AP-M04` §2
obligation 5 and §8 item 3 still describe `C-5` as an undischarged deferral. That
is a third repair owed to my own plan, riding with the `M04-J3` quotation and
`FINDING AP-M04-3` at the round that next opens `test/attack_plans/**`. Three
repairs to one document, all editorial, all found by writing the instrument that
would execute it — which is the argument for writing the work order before the
bench rather than after.

**14. On the harvest note: none is owed at this round, and I say so rather than
leave silence to be read.** PROTOCOL §7 and charter §8 attach the note to **every
module sign-off and every phase gate**. This is a work-order round and neither.
Under ADR-0018 §A2's `A2-D10` the open span still begins at `J-dv_lead-0168`;
`J-dv_lead-0169`, `J-dv_lead-0170` and **this entry** all join it, and all four
are mined at the next `SO-` or gate. Recorded because a skipped harvest and a
not-owed one are indistinguishable in silence, and the tiling rule is the only
instrument that tells them apart.

### Actions

- **Created `agents/handoffs/WO-0080_tb-m04-first-bench.md`** — state **ISSUED**,
  dv_lead → tb_writer, **99,870 bytes**, twenty sections plus a section map and an
  empty Return log. It commissions **13 of `AP-M04`'s 80 rows** — `M04-A1`,
  `A2`, `A5`, `B1`, `B2`, `B4`, `B5`, `C1`, `C2`, `C3`, `C4`, `C5`, `C6` (ten
  ASSERT, three NO-ASSERT) — in **ten `%expect_test` units** across **seven new
  files** under `test/xgmii_tx_64/`, on a **new reactive bench capability layer**
  specified at §5 by behaviour and by per-cycle ordering. Frozen references are
  named by SHA (`AP-M04` at `8f81568`, SPEC-M04 FROZEN `f78766e` with current
  content at `816e187`); §4 **quotes** the plan's arithmetic identity rather than
  citing it; §6 derives every expected cycle, lane, `tkeep`, `F`, `t` and pad
  count for all eight lengths driven; §9 carries the regime facts as seven
  numbered obligations including BAR T1; §12 carries **sixteen** review bars by
  seat, every tree-quantified one with its base figure measured at `9d68d10`;
  §13 carries **sixteen** pre-committed BOUNCE conditions, §14 twelve named
  traps, §15 nine pre-committed disposition classes, §17 the standing allow-list
  and its two clauses, §19 the sibling-ruling dependencies and six owed items.
- **Reconciled the packet to `ee47eee`** after the declared sibling landed
  mid-round (Trigger, Reasoning 13, Evidence 9): eight base-SHA citations rebased,
  two specification pins moved, **§3.3 added** (the `AP-M04-2` ruling and `C-5`'s
  closure, both halves stated for what they change at the bench), §5.4(3)'s
  window-prohibition ground rewritten, §9.4(1) given the specification's own
  normative sentence, §19.1 rewritten from *in flight* to *ruled*, and §19.3
  item 3 widened from one owed plan repair to four.
- **Nothing under `test/**`, `docs/**`, `libs/**`, `tools/**` or any other
  journal was touched** — the dispatch's explicit out-of-scope list, verified
  below.

### Evidence

All commands run from a checkout at this working tree. **No OCaml lands in this
round**, so there is nothing for `dune runtest` to say about it; `dune` is absent
from this container in any case (**ADR-0005**, the standing bound, re-checked:
`which dune` returns nothing).

```
$ git rev-parse HEAD                       # at spawn, before reading anything
9d68d107bf88525980aaeaffc36cefba742f5d94
$ git status --short                       # at spawn
                                           (empty)
$ git rev-parse --abbrev-ref HEAD
claude/fpga-hardcaml-agent-orchestration-37ceyf
$ git status --short                       # at return
?? agents/handoffs/WO-0080_tb-m04-first-bench.md
```

**1. The packet number, checked at the directory and not taken from the
dispatch** (the dispatch said to verify with `ls`, and it was right to):

```
$ ls agents/handoffs/ | grep -oE '^WO-[0-9]{4}' | sort -u | tail -3
WO-0077
WO-0078
WO-0079
```

**`WO-0079` is the highest landed number; this packet is `WO-0080`.**

**2. The base figures every tree-quantified bar in §12 is stated against, each
run at `9d68d10` before the bar was written** (`FINDING K-3`'s obligation):

```
$ grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .
139                                        # bar M-3 base
$ ls -d test/xgmii_tx_64
ls: cannot access 'test/xgmii_tx_64': No such file or directory
                                           # bar M-4 base: 0 tracked files
$ git ls-files test/xgmii_rx_64/ | wc -l
17                                         # bar M-5 base
$ grep -rn --include=*.ml 'M04-' test/ | grep -c .
0                                          # bar M-7 base — the one condition
                                           # under which M-7 may be a universal
```

**3. The census measurement behind packet §9.7** — read at the script, not
recalled:

```
$ grep -n "census_plan=" tools/dv_checks.sh
837:census_plan='test/attack_plans/AP-xgmii_rx_64.md'
$ grep -n "for inv_f in" tools/dv_checks.sh
743:for inv_f in test/xgmii_rx_64/*.ml; do
```

The census's row pattern is `M03-[A-Z]+[0-9]+` (`:847-848`) and its title source
is that same directory. **No M04 row is countable by any committed instrument at
this SHA.**

**4. The CI step names bar M-2 reads by name** — taken from the workflow, so the
bar points at steps that exist:

```
$ grep -n 'name:' .github/workflows/build.yml | sed -n '3,6p'
27:      - name: Build
30:      - name: Run tests (expect tests, waveform snapshots)
54:      - name: Generate RTL
57:      - name: Verify nothing was left unpromoted or non-deterministic
```

**5. The identity checked against SPEC-M04 §6.1's own cycle table at `P = 60`**
— the cross-check bar M-9 asks the worker to redo independently. `F = max(60,60)
+ 4 = 64`; `t = 64 mod 8 = 0`; terminate cycle `= C + 2 + ⌊64/8⌋ = C + 10` against
the table's *"C+10 · `/T/` in lane 0"* ✓; FCS octet indices `60 … 63` → lanes
`4 … 7` of `C + 2 + ⌊60/8⌋ = C + 9` against the table's *"C+9 · octets 56–59 and
the four FCS octets"* ✓; preamble at `C + 1` ✓; frame octet 0 at lane 0 of
`C + 2` ✓; `g = ⌈12/8⌉ = 2`, next start at `C + 12`, gap 16 octets, spacing 11 ✓.
**Six of six agree.**

**6. The eight-length constant table of packet §6.1, spot-checked at the three
members most likely to be wrong.** `P = 61`: `W = ⌈61/8⌉ = 8`, last-word octets
`61 − 56 = 5` → `tkeep` `0x1F`, `F = 65`, `t = 1`, terminate `C + 2 + 8 = C + 10`,
FCS indices `61 … 64` straddling **two words** (lanes 5,6,7 of `C+9` and lane 0
of `C+10`). `P = 64`: `tkeep` `0xFF`, `F = 68`, `t = 4`, FCS whole in lanes 0–3 of
`C+10` — the plan's `M04-D4` second member. `P = 1514`: `W = 190`, last-word
octets `1514 − 1512 = 2` → `tkeep` `0x03`, `F = 1518`, `t = 1518 − 1512 = 6`,
terminate `C + 2 + 189 = C + 191`. **And the fact the table exists to make
unmissable**: `⌊F/8⌋ = 8` for every `F` in 64 … 71, so seven of the eight lengths
terminate at the **same** cycle `C + 10` and at seven different lanes.

**7. The cost derivation of packet §10**, against `WO-0070`'s measured class
(`T` = 2.036 s at **105 010** cycles in one run): run length `= 27 + ⌊F/8⌋` gives
**35** cycles for every `F` in 64 … 71 and **216** for `F` = 1518; summed over
the ten units, **928 driven cycles and 22 elaborations**. `928 / 105 010` =
**0.88%** — two orders of magnitude inside the class, so no probe is required and
`WO-0070` §1.5's band overlap does not need closing here. Ceiling pre-committed
at **≤ 1 500 cycles, ≤ 28 elaborations**, with `BM13` as its enforcement.

**8. The packet's own row census, measured at the file rather than asserted:**

```
$ grep -o 'M04-[A-Z][0-9]*' agents/handoffs/WO-0080_tb-m04-first-bench.md \
    | sort -u | wc -l
25
```

Twenty-five distinct tokens appear; **thirteen are the commissioned ids** (§2's
table) and the other twelve are, exactly and in the matcher's own order:
`M04-A3`, `M04-A4`, `M04-B3` (deferred with grounds, §1.2), **`M04-D`**,
`M04-D1`, **`M04-E`**, `M04-E1` (deferred with grounds, §1.3/§1.4), `M04-G4`
(named in order to **forbid** claiming it, §9.4(3)), `M04-G8` (the
conservation-key rule it justifies, §5.4(2)), `M04-J3` (my own stale quotation,
§3.2), `M04-N4`, `M04-O5` (quoted prohibitions). **Every one of the twelve
appears only in an exclusion, deferral, prohibition or owed-work context, and
none appears in a title instruction.**

**Two of the twenty-five are a matcher artefact and I name it rather than let the
figure read as twenty-five rows.** `M04-D` and `M04-E` are not row ids: they are
the prefixes the pattern `M04-[A-Z][0-9]*` extracts from the packet's own
**family-wildcard** notation `M04-D*` and `M04-E*` at §13's `BM8`. The true
distinct-id count is therefore **23**, of which 13 are commissioned and 10 are
referenced. This is the same class as `FINDING AP-6-2` — *a document measured by
a pattern must not write its annotations in that pattern* — met here in its
mildest form, where the artefact inflates a count rather than a census: the
wildcard is the clearest way to say "no row of family D", so the notation stays
and the artefact is declared beside the figure instead.

**9. The mid-round HEAD move, verified rather than assumed** (Trigger, Reasoning
13). Run at the final state check, before any reconciling edit:

```
$ git rev-parse HEAD
ee47eeecc04f2882821c67c1da0450590ab2bb7a          # NOT the spawn-head
$ git log --oneline 9d68d10..HEAD
ee47eee Both findings sustained and neither offered cure taken: …
$ git diff --stat 9d68d10..HEAD
 .../claude_architect_docs_lead_agent.v03.md | 655 +++++++++
 docs/specs/modules/xgmii_tx_64.md           |  38 +-
 docs/specs/requirements.md                  |  42 +-
 3 files changed, 721 insertions(+), 14 deletions(-)
$ git diff 9d68d10..HEAD -- agents/journals/claude_dv_lead_agent.v08.md
                                                  (empty — my journal untouched)
$ git diff --stat 9d68d10..HEAD -- test/
                                                  (empty — no test path moved)
```

**R3 re-checked against the NEW HEAD**, because an append-only proof against a
superseded parent proves nothing:

```
$ git show HEAD:agents/journals/claude_dv_lead_agent.v08.md > /tmp/…/head_v08_new.md
$ head -c 312998 agents/journals/claude_dv_lead_agent.v08.md \
    | cmp - /tmp/…/head_v08_new.md
                                                  (silent — PREFIX OK, 312,998 B)
```

**Every §12 base figure re-measured at `ee47eee`**, and all four are unchanged
**because** the sibling touched no `test/` path — the reason, not the
coincidence, is the line above:

```
$ grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .   ->  139   (M-3)
$ git ls-files test/xgmii_tx_64/ | wc -l                        ->    0   (M-4)
$ git ls-files test/xgmii_rx_64/ | wc -l                        ->   17   (M-5)
$ grep -rn --include=*.ml 'M04-' test/ | grep -c .              ->    0   (M-7)
```

The packet was then rebased: **eight** `9d68d10` citations became `ee47eee`
(`grep -c '9d68d10'` → 0 after), SPEC-M04's current-content pin and
requirements.md's pin were moved, §3.3 was added, §5.4(3)'s ground was rewritten,
§9.4(1) gained the specification's own prohibition, §19.1 was rewritten from
*in flight* to *ruled*, and §19.3 item 3 was widened from one repair to four.

**10. Independence.** `git status --short` at return lists exactly one untracked
path and one modified path — the packet and my own journal. **No `git add`, no
`git commit`, no `git push`, no git write of any kind**; the sibling's commit is
the sibling's and I neither made it nor merged it.

### Outcome

**DoD met.** The round's four commissioned calls are made and each is stated with
its ground in the packet: **(1) scope** — 13 rows across families A, B and C plus
a new reactive bench capability layer, with the one-frame-per-run rule as the
checkable cut and families D and E deferred with their grounds written down;
**(2) bench architecture constraints** — RTL source omitted and the three
spec-named things (library, module, entry point) supplied instead (§7), SPEC-M04
named by freeze SHA and current SHA with the post-plan diff carried (§3), the
REQ-305 bit-serial oracle named as the FCS source with loopback forbidden (§9.5),
and §4's identity **quoted** as the expected-value instrument; **(3) regime
facts** — seven numbered obligations at §9 carrying the three standing rules, the
underflow family's three binding facts, BAR T1, the FCS-oracle prohibition and
the census measurement, plus the cost-probe expectation at §10 and the enumerated
allow-list at §17 in the `WO-0072` standing form; **(4) what the round does not
carry** — §19.1 marks both sibling-ruling dependencies with their carriers and
records that no row moves on either, §9.6 shuts the co-simulation lane, and
§19.2/§19.3 enumerate what is deferred and what I owe.

**Handoff**: `agents/handoffs/WO-0080_tb-m04-first-bench.md`, state **ISSUED**,
addressed to **tb_writer**, for the orchestrator to spawn against. The Return log
is empty at issue, per PROTOCOL §3.

### Open-questions

1. **Journal rotation is one entry overdue.** `v08` is **312,998 bytes**, 50,854
   over ADR-0017's soft threshold `S` and 211,290 under the hard threshold `H`.
   The `WARN-JOURNAL` first fired on the previous entry's commit and R10's remedy
   names **this** entry as the rotating one; I did not rotate because the
   dispatch's write set names `…v08.md` and a rotation creates a new path.
   **`v09` must open at `J-dv_lead-0172`** and the next dispatch should carry
   `agents/journals/claude_dv_lead_agent.v09.md` in its write set. Not blocking —
   `H` is not reached — but it should not slip a third entry.
2. **`FINDING AP-M04-3` (MINOR, mine, against `AP-xgmii_tx_64` §4.B and §4.C).**
   `M04-B2`'s and `M04-C4`'s observables state *"the poison value appears nowhere
   in the whole run / on the wire"*, and both universals are falsifiable by
   arithmetic because the four FCS octets are a computed value that may
   legitimately equal the poison. Substance right, quantifier one octet class too
   wide. **Cured operationally** in the packet at §6.0(c), which scopes the scan
   to wire octet indices `0 … F−5` and states the exclusion's reason. **Plan text
   not repaired** — outside this round's write set. **Carrier**: the round that
   next opens `test/attack_plans/**`, which now owes **four** editorial repairs to
   one document — this one, the `M04-J3` quotation (§3.2 of the packet), §2
   obligation 5 and §8 item 3's superseded `C-5` deferral (§3.3(b)), and the §9
   change-log row for families A/B/C's landed status. All four were found by
   writing the instrument that would execute the plan, which is the argument for
   drafting the work order before the bench rather than after it.
3. **`FINDING AP-M04-2` and `FINDING CSG-3` were RULED mid-round, at `ee47eee`,
   and both are SUSTAINED.** Marked at packet §19.1, rewritten from *in flight* to
   *ruled*. **No row of this round moved on either**, before or after — `BM6` had
   already forbidden the idle-injection wrapper on REQ-016's own carve-out, and
   the ruling changed that rule's authority rather than its content. **What I owe
   next and am not doing here**: neither ruling is countersigned, and a
   countersignature is a round of its own. `C-5`'s closure in particular changes
   the ground of a standing prohibition in my own plan and I read it as text
   rather than re-deriving §0.6's fourth clause — if that reading is wrong the
   packet says so and asks the worker to say so (§18 item 8), but the proper check
   is a countersignature round against `J-architect_docs_lead-0039`, which I
   request. My `FI-4`/`FI-6` binding is discharged by the `CSG-3` ruling rather
   than by a work order, and I have **not** narrowed either guard in this round.
4. **Owed by me, carried forward and countable**: the M04 census in
   `tools/dv_checks.sh` (measured absent at §9.7; `DVC-1a` is now wanted by three
   plans); the transmit-side conservation monitor (`AP-M04` §7 T-2); the
   `AP-xgmii_tx_64` repairs of item 2 above; and `AP-ip_eth_rx_64`'s family-F rows
   `M14-F1`/`F2`/`F3`, still asserting the retired per-octet-under-injection
   reading and owed before any M14 bench.
5. **For the orchestrator, as scheduling**: the three BAR T1 conditions need work
   orders of their own — vendoring the transmit reference at a pin (its own
   commit, ADR-0015 D2), a transmit harness and a canonical form for a lane pair,
   and REQ-901's divergence classes at this boundary. Sequenced (c) → (a) → (b),
   and **none of the three is a bench round's to do inside a bench round**.
   Charter §3 makes differential co-sim a precondition of Phase 1 MAC sign-off,
   so this is a gate condition on `SO-xgmii_tx_64`, not a nicety.

### Files-in-this-commit
- agents/handoffs/WO-0080_tb-m04-first-bench.md
