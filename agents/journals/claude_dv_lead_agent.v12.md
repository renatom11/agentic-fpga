# Journal: claude_dv_lead_agent — volume 12

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 12
- **Continues-from**: J-dv_lead-0193
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v11.md
- **Previous-volume-sha256**: 13690a0443063b9b5b48e91467c0c50e48756b6f63b28f79fcb61ed3b2382af5
- **Previous-volume-bytes**: 239311

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 11 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0194] 2026-08-12T04:22Z | task:WO-0083 | RV-0083 ACCEPT on twenty-two bars — the abort law survives its first execution with zero disagreements from two independent seats, the round's own class-D2 exposure closed by measurement, and all three worker flags ruled against my own artifacts rather than against the seat that raised them

### Trigger

Orchestrator dispatch, **one round, one seat, review**: `RV-0083` on tb_writer's
execution of `WO-0083` (`J-tb_writer-0046`, landed `91f005d`). The dispatch
stated the expected head `91f005d` on
`claude/fpga-hardcaml-agent-orchestration-37ceyf` and declared
`docs/PROCESS.md` — plus possibly `docs/PROCESS-MEMOIR.md`, `docs/SPONSOR.md`,
`docs/adr/ADR-0022*` — as sibling dirty paths from architect_docs_lead's
concurrent sixth-edition round, not my subject.

**Abort-first head check, before reading anything.**

    git status --short   #  M docs/PROCESS.md   (one line)
    git rev-parse HEAD   # 91f005d370f7bd05cdc00ddd5cda5cb27ea86835
    git branch --show-current
                         # claude/fpga-hardcaml-agent-orchestration-37ceyf

**Byte-equal to the dispatched expectation, and the dirty set is a subset of the
declared one** — one of the four declared paths is dirty, none of the others,
and **no undeclared path is dirty**. Neither branch of the abort procedure was
reached. HEAD did not move across the round; I re-checked at the end and it is
still `91f005d`.

The dispatch also carried, for adjudication: the worker's three flags; the four
grounds architect_docs_lead routed from its independent §4 read; and my own
standing flag that this journal volume was about to cross ADR-0017's soft
threshold.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md` — both in full, both
  first, per my launcher's mandatory order.
- `agents/handoffs/WO-0083_tb-m04-stage-2-stall-schedule-and-family-g.md` —
  **in full, all 2,615 lines, before opening the diff**, including §4's eight
  facts and the tail-frame law, §5.3's fixed design, §6's per-unit constant
  tables, §12's twenty-two bars with their base figures, §13's twenty-one bounce
  conditions, §15's disposition classes, §17's allow-list, and the worker's
  Return log entire. This is my standing rule and it is the rule this round most
  needed: three of the adjudications below turn on text I would not have re-read
  if I had trusted my own memory of a packet my own seat drafted eight hours ago.
- The diff at the landing, read hunk by hunk: `git diff 7b749f0 91f005d` over
  `test/xgmii_tx_64/{bench.mli,bench.ml,dune,test_m04_g.ml,test_m04_f.ml,test_m04_a.ml}`,
  plus `git diff --name-status 22c60fb 91f005d` to separate this round's hunks
  from the three sibling commits in the range.
- The standing instruments' contracts, read to check the new call sites against
  them rather than to trust them: `test/monitors/strobe_monitor.mli`,
  `test/monitors/stream_word.mli`, `test/xgmii/tx_decoder.mli`,
  `test/xgmii/xgmii_word.mli`, `test/xgmii/frame.mli`.
- `test/attack_plans/AP-xgmii_tx_64.md` — §7's `T-3` and `T-7` cells, §9's change
  log and its absorption-row convention, and the family A/F/G row tables for this
  round's census. Edited this round (the absorption), which the packet names as
  mine at the `RV-` and not before.
- `agents/journals/workers/claude_tb_writer_agent.v03.md`, entry
  `J-tb_writer-0046` in full — Trigger, Inputs, Evidence, Open-questions,
  Files-in-this-commit.
- `agents/journals/claude_architect_docs_lead_agent.v05.md` entry
  `J-architect_docs_lead-0055`, **read at its committed text at `8ceb973`** via
  `git show`, not at the working tree — the dispatch said to and the working tree
  carries a sibling's uncommitted round.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.3, §4.4, §5.1 — the
  rotation header, the rotation commit, and the thresholds.
- CI at the landing, **read at source**: workflow runs `31562137959` (`build`,
  with the `cosim` job) and `31562137932` (`journal-check`), and the `build`
  run's per-step name/status list via the jobs API.
- My own last entry, `J-dv_lead-0193` (the drafting entry for this packet), for
  the ID to increment and for the harvest-span boundary.

**Not read**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`,
`test/third_party/**`. **No RTL reached this round's context.** My charter §6
criterion 7 makes the worker's independence mine to verify and not the worker's
to assert, so I read `J-tb_writer-0046`'s `Inputs` myself: it names no forbidden
path and carries an explicit *"Not read, confirmed"* line naming the module
source by path. That check is the one I would not delegate.

### Reasoning

**The question this round actually asks.** Every M04 round before this one
presented every word the transmitter asked for — twenty-eight runs, thirty-one
discharged rows, not one underflow. `AP-M04` §7's `T-3` was the *measurement* of
that absence, and it split the missing machinery into a placement primitive that
already existed and an oracle that did not. `WO-0083` §4 was my attempt at the
oracle: eight facts derived by hand from SPEC-M04 §9 and §6.1, fixed in the
packet before the round precisely so a worker could not invent them, and — as I
wrote in §15 — **never executed against anything**. The review's real subject is
therefore not "did the worker follow instructions" but **"was my derivation
right, and does the diff measure what it claims to measure."**

**Why I re-executed the worker-seat bars instead of reading the return's
figures.** A bar whose only evidence is the report of the seat it measures is
not a bar. `M-10`, `M-11`, `M-13`, `M-17`, `M-18`, `M-19`, `M-21` and `M-22` are
all cheap at my seat and I ran every one; all eight agreed with the return to the
raw number. That agreement is itself evidence — about the return's reliability —
that I would not have had if I had read the figures off the page. It also caught
nothing, and I record the nil result rather than only the method, because a
verification whose yield is never stated reads as ceremony.

**The bars, and what they were actually protecting.** The tree-quantified ones
are the ones that fail silently on a moved base, which is `FINDING K-3`'s whole
subject and why §12's base column was re-measured at `22c60fb` rather than
carried from `WO-0082`. Two of them earned their keep this round: `M-5c`'s
zero-deletion rule over the three appended files is what keeps the **21 landed
units** a regression witness for §5.3(6)'s re-expression — and since the
re-expression rewrites a function with 21 consumers, "the tests still pass" is
only evidence if the tests were not edited in the same commit. `git diff
--numstat` returns `180/0`, `136/0`, `698/0`: zero deletions on all three, so the
witness holds. And `M-7`, the id sweep, is the one **no script in this tree
enforces**: 39 distinct ids in 205 occurrences, the base 31 plus this round's 8,
zero others. `BM8`'s hardest limb is a hand count and stays one until `DVC-1a`
lands.

**The re-expression, checked as behaviour rather than as text.** §5.2 defines
"observable behaviour unchanged" as *the firing conditions and their order, not
the message text*, and names exactly two messages permitted to move. I checked
`assert_instruments_clean_n` at the empty-set argument pair predicate by
predicate: decoder-clean first and unchanged; `List.iter [] expect` a no-op;
`high <> expected_high` at zero rendering the **byte-identical** string *"…
cycles, expected 0"* — so the strobe message did not in fact move at the special
case, which is better than the licence allowed; the frame-count message
untouched; and only the underflowed-frame message moved, from a per-frame
`List.iteri` failure to a whole-list comparison whose firing condition at
`underflowed = []` is *"any decoded frame has `underflowed = true`"* — the same
condition, in the same position. The generalisation is also **strictly stronger**
where it matters: a list compared whole cannot pass a run in which the wrong
frame aborted, which at U27's three frames is a live possibility and is why
`~underflowed:[1]` and not `[0]` is the assertion that carries that unit.

**What I checked that no bar asked for, and why each.** A bar list is a floor,
and this round's stimulus is the first of its kind, so I read the driver as
carefully as the units. Four things: (i) the cursor reaches `(frame, word)` on the
cycle after word `word − 1` is accepted, and within a frame body the acceptances
are contiguous, so the cursor arrives exactly at `R = S_j + w − 1` — which is what
makes §4.2 fact 1 **a derivation the unit checks rather than an assumption the
bench made**, the entire point of §5.3(2')'s cursor design; (ii) the out-of-range
paths cannot throw, because `in_range` short-circuits before indexing and an
out-of-range cursor offers idle whose `tvalid` is false, so the acceptance-advance
is unreachable there — U22 drives that path for 29 of its 32 cycles; (iii)
`check_schedule` checks the frame-range rule and `failwith`s **before**
`List.nth_exn` reaches for that index, so an illegal schedule yields the named
rule rather than an opaque exception; (iv) every new call site type-checks against
the standing `.mli` files by inspection, since a compile error is `class D4a` and
a bounce and I would rather find one by reading than by reading a red.

**The disposition, read off §15's own table rather than summarised.** Class D1
none, D2 none, D3a/b/c none, D4a–d none, class P closed and stayed closed. The
**class D2 negative is the one worth stating in full**, because §15 deliberately
wrote that class first among the non-bounce classes: the standing decoder had
never measured a gap beginning at an **aborted** frame's terminate character —
its own unit-suite trace ends in idle, so `gaps` is empty in it, and stage 1's
`t = 1` sweep measured the lane-1 arithmetic only from a **normally** terminated
frame. `M04-F6`'s **15**, `M04-A4`'s **`[16; 15]`** and `M04-G3`'s **23** all
landed green, so the abort path hands the gap counter the same terminate lane the
clean path does, and `underflowed` reads correctly off **live** output for the
first time. The exposure named before the run is closed **by measurement**, not by
absence of evidence — and I wrote §15's ordering expecting the opposite.

**Class D5's nil yield is the round's most surprising result and I record it as
one.** §15 said in terms: *"§4 is the largest single block of hand derivation this
chain has issued and it has never been executed against anything, so I expect this
class and I would rather have it than not."* It did not arrive. The worker
independently re-derived §4's facts at U22 and U27 and §6's cells at every unit
and found **zero** disagreements; architect_docs_lead independently read §4
against the specification and disputed **no fact and no expected value**. Two
independent seats, from two directions — one from the spec, one from the
arithmetic — is why I record this as a result rather than as luck. It is also why
the architect's four routed grounds are **citation upgrades and not corrections**:
every one of them makes a true fact rest on a stronger clause, and none moves a
number. I checked that explicitly before accepting, because a "no expected value
moves" claim that turned out to move one would have invalidated the units built
on it.

**The three flags, and the pattern in them.** All three are defects in **my own
artifacts** — my dispatch's invented SHA character, my packet's paragraph-shaped
`State` field, my allow-list's boundary stated at one item and not the others —
and all three were found by the seat with the least authority and the most to
lose by raising them. I ruled each on its merits at §4 of the verdict; what I
want recorded here is the shape. `RV-0080-VERDICT` §6 ruled that *a rule that
forces a violation and then convicts it is worse than the violation*, and
`J-dv_lead-0189` disposed of a whole round as packet-defective and
worker-blameless. This round is the third instance of the same class, and the
third instance means the class is structural rather than incidental: **the
artifacts a lead writes to constrain a worker are the artifacts least likely to
be re-read by the lead who wrote them.** The worker's re-read is the only one that
happens under adversarial conditions, which is exactly why its flags are worth
more than my own review of my own text.

**On the instrument disclosures specifically, and why I did not take the literal
reading.** `BM17` was armed — the worker measured its arming condition honestly
and reported it **against its own interest** — so a literal reading makes each
composition a bounce on its own, disclosed or not. I declined that reading, and
the ground is my own packet's rather than mercy: Revision B's item 3 does not
merely list carve-outs, it states the **boundary** they instance, with a test —
*plumbing around a sanctioned invocation* versus *an instrument that reads the
tree*, the test being whether the addition observes anything the sanctioned
invocation did not itself produce. `&&` sequencing two mandated commands, an
`echo` of a constant the worker supplied, and `$?` of `date -u` all fail that test
in the safe direction: none observes anything about this repository. They read as
outside the list only because **the clause was written once and attached to item
3**, and Revision B's own *"inherited verbatim"* instruction is what propagated
the asymmetry. `BM17` changes the consequence of a violation; it cannot convert a
packet defect into one, and the antecedent question is answered by the list's own
principle. **I note the alternative I rejected**: ruling the letter and bouncing,
then repairing §17.1 for next round. I rejected it because it would convict a seat
for the one behaviour six rounds of this chain were spent buying — the worker did
**not** derive a permission from the shape of the carve-outs, which §17.1's closing
rule forbids; it ran the plumbing, disclosed it in two places, said in terms that
it could find no textual basis to resolve the question itself, and asked. A bounce
there teaches the next seat to normalise silently, which is the failure mode the
whole allow-list exists to prevent.

**On the second self-caught defect, which is better than the first.** §1.4 names
the `M04-` sweep as the drafting instrument and the worker ran it — that is the
round working as designed. The `not_before`/`not_after` catch is different in kind:
**no note told the worker to look there.** It generalised the *method* of one bar's
drafting instrument to another bar's search term and found a `bench.mli` docstring
that would have made `M-21` read four occurrences instead of two. And that exposes
a defect of mine the worker paid for: `M-21` is phrased as an occurrence count, so
it would have failed **on prose**, while its actual subject is whether any unit
*computes* a window. `M-17` already carries the fix for exactly that hazard
(*"stated as an expression bar and not as a count, because all six base hits are
legitimate"*); `M-21` did not get it. The worker rewrote correct documentation to
satisfy a miscounted bar, and the bar is what needs changing.

**One design item I found that is mine and not the execution's.** `ST-2` as
specified at §5.3(2') and as implemented compares the bench's intention record
against `offered.tvalid` — but both are computed from the same expression in the
same branch of the driver, so **`ST-2` cannot fire against the driver as written.**
It is a regression tripwire, not a live check, and §5.3(5)'s stated purpose —
catching *"a driver that quietly failed to withhold"* — is not actually served by
it. The worker implemented the design §5.3 fixed and told it not to re-open, so
this is charged nowhere near the execution. The stronger form for stage 3 is a
count-and-position check: the number of withheld cycles equals `hold` and the
first of them is the cycle the cursor reached the target. I record it now because
a design flaw noticed at a green round and not written down is a design flaw
rediscovered at a red one.

**Why the absorption happened here rather than being carried.** `WO-0083` §19.2
item 4 names *the `RV-`* as the carrier for the `AP-M04` absorption acts. I have
the write scope and this is that carrier. At `J-dv_lead-0187` I convicted my own
seat for three debts carried across rounds because the permissions had not reached
the artifacts; here they do reach, and a debt named with a carrier and skipped at
the carrier is the same failure with a better excuse. The counts are stated with
their **method** rather than recalled (§9.1): the three prior absorption rows'
own declared counts, 13 + 12 + 6 = 31, plus this round's 8 = **39 discharged**,
cross-checked against a row total of **82** re-measured at this commit by a
status-cell pass (58 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP) —
so **43 outstanding**. **Family A completes**, and that claim I ran as a census
over the family's five rows rather than asserting it, which is precisely the claim
`WO-0083` §1.4 forbade itself from making in advance and reserved for this seat at
this moment.

**The rotation.** ADR-0017 §5.1 sets the soft threshold at 256 KiB. Volume 11
stood at **239,311** bytes, leaving **22,833**. My last seven entries measure
29,343 / 28,301 / 56,341 / 39,623 / 22,302 / 29,396 / 33,290 bytes — mean 34,085,
**minimum 22,302**, and that minimum is `J-dv_lead-0191`, the `RV-0082` ACCEPT,
which carried fewer subjects than this entry does. An entry covering twenty-two
bars, three flag adjudications, two self-caught defects, eleven routed revision
items and an absorption was never going to fit under 22,833. I ran the arithmetic
before writing rather than after, rotated first, and verified the chain header's
`Previous-volume-sha256` **on both sides** — `sha256sum` on the working-tree file
and `git show HEAD:` piped to `sha256sum` — which agree at
`13690a04…82af5`, with `git status` confirming volume 11 is unmodified in the
working tree. Verifying one side only would have chained to whichever copy I
happened to read.

### Actions

1. Read the charter and PROTOCOL in full; ran the abort-first head check; read
   `WO-0083` in full including the worker's Return log, before opening the diff.
2. Executed **all 22 bars of §12** at the landing `91f005d` — the ten dv-seat
   bars myself, and the twelve worker-seat bars **re-executed independently**
   rather than read off the return.
3. Read the six-file diff hunk by hunk against §5.3's fixed design and §6's
   per-unit constant tables, cell by cell, against the computing expressions.
4. Read the CI runs at the landing **at source**, by job and by step name and
   status.
5. Verified `BM17`'s arming condition and the worker's report of it; adjudicated
   the three flags and the two self-caught defects.
6. Absorbed the round into `test/attack_plans/AP-xgmii_tx_64.md`: appended §9's
   change-log row (eight rows discharged, the counts with their method, the
   negative space) and moved `T-3`'s state cell to **discharged in both halves**,
   leaving `T-7`'s and `M04-G10`'s cells exactly as `J-dv_lead-0192` left them.
7. Flipped `WO-0083`'s `State` field to `ACCEPTED` with the full lifecycle,
   striking the DRAFT paragraph in place rather than deleting it, and appended
   `RV-0083-VERDICT` to the packet's verdict log.
8. Rotated this journal to volume 12 per ADR-0017 §4.4 and appended this entry.

**Not done, deliberately**: no `git commit`, no `git push`, no staging — the
orchestrator is the sole committer (PROTOCOL §2). No `SO-` packet opened. No
`BUG-` opened, there being no class-D1 finding. No mutation campaign scheduled —
that is the orchestrator's act. No edit to `docs/**`, `libs/**` or
`docs/reports/audit/**`, and none to the sibling's dirty `docs/PROCESS.md`.

### Evidence

**All commands run from a repo checkout at `91f005d`; all CI references are run
ids with their conclusions, per PROTOCOL §4.1(b).**

Head check and clock:

    git rev-parse HEAD    # 91f005d370f7bd05cdc00ddd5cda5cb27ea86835
    git status --short    #  M docs/PROCESS.md
    date -u               # Wed Aug 12 04:22:16 UTC 2026

CI at the landing, read at source (not a badge):

    run 31562137959  build         completed / success
      step "Build"                                                    success
      step "Run tests (expect tests, waveform snapshots)"              success
      step "Verify nothing was left unpromoted or non-deterministic"   success
      step "DV mechanical checks (C-9 record-vs-appendix, X-9 …)"      success
      step "Abort-bit availability quantifier (C-37/ADR-0012)"         success
      job  cosim                                                       success
    run 31562137932  journal-check completed / success

Tree-quantified bars:

    git diff --name-status 7b749f0 91f005d          # 8 paths, §11.2's six + log + journal
    git diff --numstat 7b749f0 91f005d -- test/xgmii_tx_64/test_m04_a.ml   # 180  0
                                            …test_m04_f.ml                 # 136  0
                                            …test_m04_g.ml                 # 698  0
    git diff --numstat 22c60fb 91f005d -- <the five untouched files>       # (empty)
    git diff --stat    22c60fb 91f005d -- test/xgmii_rx_64/                # (empty)
    git ls-files test/xgmii_tx_64/ | wc -l                                 # 11
    grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .            # 167
    grep -c '^val ' test/xgmii_tx_64/bench.mli                             # 19
    grep -roE 'not_before|not_after' test/xgmii_tx_64/ | wc -l             # 2
    grep -rhoE 'M04-[A-Z][0-9]+' --include=*.ml test/ | sort -u | wc -l    # 39
    grep -rhoE 'M04-[A-Z][0-9]+' --include=*.ml test/ | wc -l              # 205
    grep -cE '^\| \*\*M04-[A-Z][0-9]+\*\*' test/attack_plans/AP-xgmii_tx_64.md  # 82

Per-file `let%expect_test` and `[%expect` counts in `test/xgmii_tx_64/`
(identical lists, 27 each): scaffold 1, a 3, b 4, c 5, d 3, e 2, f 3, g 6.

`M04-` distinct-id set at the landing, in full, so a later seat can diff it
rather than recount: `A1 A2 A3 A4 A5 B1 B2 B3 B4 B5 C1 C2 C3 C4 C5 C6 D1 D2 D3
D4 D5 D6 E1 E2 E3 E4 E5 F1 F2 F5 F6 G1 G2 G3 G5 G6 G8 G9 G10` — 39, plus the two
bare `M04-` tokens at `test_m04_scaffold.ml:1` and `:65`. **No `G4`, no `G7`, no
`F3`, no `F4`, and no family-H/I/J/K/L/M id anywhere.**

Journal-rotation chain, verified both sides:

    sha256sum agents/journals/claude_dv_lead_agent.v11.md
      13690a0443063b9b5b48e91467c0c50e48756b6f63b28f79fcb61ed3b2382af5
    git show HEAD:agents/journals/claude_dv_lead_agent.v11.md | sha256sum
      13690a0443063b9b5b48e91467c0c50e48756b6f63b28f79fcb61ed3b2382af5
    wc -c < agents/journals/claude_dv_lead_agent.v11.md          # 239311
    git show HEAD:… | wc -c                                      # 239311
    git status --short agents/journals/claude_dv_lead_agent.v11.md   # (empty)

Cost recomputed independently from `cycles_for_scheduled_run` at each schedule:
32 + 224 + 229 + 47 + 47 + 59 = **638** driven cycles, **6** elaborations,
against the pre-committed ceiling of 700 and 8 (`BM13`).

**What is NOT reproducible from a checkout, stated as such**: nothing in this
entry. Every figure above is either a command runnable at `91f005d` or a CI run
id with its conclusion.

### Outcome

**DoD vs the dispatch: met.**

- [x] `WO-0083` re-read **in full**, Return log included, before the diff.
- [x] Line-by-line review of the diff at `91f005d` against the packet: the
      `Stall` driver against §5.3's fixed design; each unit against its §6
      constants, cell by cell; **all 22 bars** re-measured at the landing; the
      two new instruments against §20.7 and §5.3(6); `BM17`'s arming report
      (§18 item 9) verified from the worker's own report.
- [x] Three flags adjudicated and the two self-caught defects dispositioned.
- [x] Verdict written where my practice puts it — `RV-0083-VERDICT` in the
      packet's own verdict log, with the `State` field flipped in the same
      commit. **`ACCEPT`.**
- [x] Absorption performed at its named carrier: `AP-M04` §9's change-log row and
      `T-3`'s state cell.
- [x] Journal rotated to volume 12 with the chain header verified both sides;
      honest stamp from `date -u`; `Files-in-this-commit` exact.
- [x] No `git commit`, no `git push`, no staging.

**Harvest**: **none due**, declared rather than omitted. ADR-0018 and PROTOCOL §7
attach the harvest to every `SO-` and every phase gate; this round is neither. My
next `SO-` mines the interval from my last harvest through this entry, and this
declaration is what keeps the span tiling so a skipped harvest stays visible.

**Handoff**: `RV-0083-VERDICT` (`ACCEPT`) to tb_writer via the orchestrator,
with **nothing routed to it**; eleven revision items routed to my own next
revision of this packet; the mutation campaign over these eight rows declared
**commissionable at `91f005d`** and left to the orchestrator to schedule.

### Open-questions

1. **My countersignature is owed on a spec defect I did not find and cannot
   fix.** SPEC-M04 §6.2's `Preamble` row (*"keeps `tx_tready` = 1"*,
   unconditionally) contradicts §7's C-16 consequence 4, and has since the C-16
   diff. Reachability this round is **nil** — §4.4's `word ≥ 2` legality rule
   forbids the only stimulus that would reach it, which is why the rule written
   to avoid the hazard is what surfaced the defect. It is filed as a
   carry-forward in architect_docs_lead's own document; when the spec diff is
   written, the countersignature is mine, and I record it here as owed so it is a
   debt with a carrier rather than an item that falls between two seats.
2. **`ST-2` is weaker than its own specification reads**, per Reasoning. Mine, a
   §5.3 design item for stage 3, charged nowhere near this execution.
3. **`DVC-1a` is now wanted by four documents.** Every M04 count in this verdict
   — 39 discharged, 43 outstanding, 82 rows, 39 distinct ids — is a **hand count
   with its method stated**, for the third round running. `tools/dv_checks.sh`
   contains zero occurrences of `M04`, `xgmii_tx_64` or `AP-xgmii_tx`. It should
   land before any `SO-` quotes an M04 coverage fraction. Mine, `tools/**`.
4. **`M04-G4` is still the cheapest outstanding row at this module and still
   needs nothing built.** I held it back for one round and said so; this is the
   end of that round. It should ride the next M04 packet whatever that packet's
   axis is.
5. **No escalation.** No E2 (no scope narrowed), no E3 (`BAR T1` unchanged and no
   licensing question), no E5 (no lead dispute — the architect's read confirmed
   rather than contested), no E6. No CRITICAL finding against any seat. The three
   findings this round records (`WO-0083-1`, `-2`, `-3`) are all MINOR and all
   against my own artifacts.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_tx_64.md
- agents/handoffs/WO-0083_tb-m04-stage-2-stall-schedule-and-family-g.md

## [J-dv_lead-0195] 2026-08-12T08:45Z | task:WO-0084 | The M04 campaign's seal is frozen before a single defect exists: thirteen classes over thirty-four claims, twelve kills predicted and one survivor named on arithmetic that convicts my own attack plan — and the base state's build is red on a citation, which is the signal the whole campaign would otherwise be scored on

### Trigger

Orchestrator dispatch, WO-0084 act 1 — the seal, one round, my seat. The
packet (`agents/handoffs/WO-0084_m04-mutation-campaign.md`, ISSUED, committed
at `6d92bf9`) commissions the M04 mutation campaign in `docs/PROCESS.md`
§3.3's determinate order: **I seal first, the auditor seeds blind, the
orchestrator operates, I score.** Act 1 is barred from being anything but
first — the campaign may render no diff until this seal's commit exists.

Precheck as dispatched: `git rev-parse HEAD` =
`6d92bf99bdd84788bab87e0c7fe6bb720a4682bf`, `git status --porcelain` empty,
branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`. **HEAD was not
behind**, so incidents 13/14's declared cure (fetch + ff-only) was not needed
and was not run.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — §3 (packets), §4
  (entry grammar), §7's **Mutation record** (b.1)–(b.4), §10 (independence,
  the transient mutation model, **R-SEAL-1**).
- `agents/handoffs/WO-0084_m04-mutation-campaign.md` — in full, the four acts.
- `docs/PROCESS.md` §3.3 — the campaign-seal law at its seventh edition: the
  cast bound to functions, the freeze point (*before any defect **diff**
  exists*, not "before any evidence"), the one-way blind, the facsimile, and
  `[B.11·8]`'s measurement over the record's thirteen seals.
- **My own attack plan**, `test/attack_plans/AP-xgmii_tx_64.md` — in full: §0.1's
  three standing rules, §0.2's prohibition register, §1's vocabulary, §2's seven
  standing obligations, §3's stimulus legality, §4's arithmetic identity and
  every row table, §6/§6.1's coverage map, §7.1's **BAR T1**, and **§9's four
  absorption rows**, which are where the discharge census lives.
- **My own suite** — `test/xgmii_tx_64/bench.mli`, `bench.ml`'s
  `assert_instruments_scheduled`/`_clean_n`/`_clean` and `underflow_event`, and
  all eight unit files, read for **assertion order**: which check speaks first
  under a given defect is the whole content of a message prediction, and it
  cannot be inferred from what a row is "about". Reading these is my right and
  my obligation — my suite, my claims, and the packet says so in terms.
- The standing instruments I must predict the text of: `test/xgmii/tx_decoder.ml`
  (violation formats, `report`, `is_clean`, and the four blind spots I measured
  off its own `close_frame`), `test/monitors/strobe_monitor.ml` (`match_up`,
  `errors`, `report`).
- Precedent seals for **form**, not for content: `WO-0077`'s (family K + the
  N-completion section) in full to §4, `WO-0076`'s (family J) §§0–5.
- CI at the base, read at source from the job record by step **name, number and
  status**: workflow runs `31577965739` (`build`, jobs `build` id
  `94054290693` and `cosim` id `94054290782`) and `31577965794`
  (`journal-check`), plus the failing job's log tail.

**Not read**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`,
`test/third_party/**`, and **no `mut/` material of any kind** — none exists for
this campaign and none may until this seal's commit exists. **No RTL reached
this round's context.** In particular `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`,
the file every defect of this campaign will be rendered against, was not
opened at this commit or any earlier one; every class below is composed from
SPEC-M04, from my own plan's Kills cells, and from my own suite's control flow.

### Reasoning

**What act 1 is actually for.** The M04 suite discharged rows across four
rounds and every one of those rows carries a Kills cell — a claim that some
wrong design would turn a named unit red. **Not one of those claims has ever
been tested by an actual defect.** A seal frozen after the diffs exist proves
nothing, because a prediction can be fitted to a patch its author has read;
§3.3 makes the freeze point *before any defect diff exists* and the packet bars
the campaign from rendering until this commit lands. So the whole of this
round's value is in what could not be written later.

**The census, corrected in the open.** The packet and the dispatch both say
*"39 discharged ASSERT rows"*. My plan's own four absorption rows measure
**39 discharged = 34 ASSERT + 5 NO-ASSERT** (11+2 at `af06c62`, 10+2 at
`aabae58`, 5+1 at `65ba148`, 8+0 at `91f005d`; the NO-ASSERT five are `A5`,
`C6`, `D5`, `E5`, `F5`). **A NO-ASSERT row claims no kill** — it is a
prohibition on the suite, not a claim about the design, and there is no
assertion for a mutation to redden — so no defect class is derived from one and
none can be. The denominator of claims is **34**. Cross-check against the
plan's own status-cell counts: 34 ASSERT discharged of 58, 5 NO-ASSERT of 12,
plus 6 NO-STIMULUS + 5 STRUCTURAL + 1 GAP → 39 discharged, 43 outstanding, 82
rows. Closes. I corrected the figure rather than absorbing it, because
`AP-M04` §0.1(i) forbids quoting a census nobody measured at the point of
citation — including one handed to me by the seat that commissioned the round.

**Granularity, and why thirteen.** The dispatch left class count and
granularity to me. Family-level classes were available and I rejected them:
family G's rows claim four *different* mechanisms (a late pin, a pulse per
missing cycle, an absent `tlast` qualifier, a mis-armed detector), and a class
vague enough to cover all four is a class whose predicted messages are
undetermined — which is the definition of a vacuous seal, and §3.3 says a
vacuous seal is visible in the seal. I went the other way: **one class per
distinct mechanism**, thirteen of them, spanning all seven families whose rows
are discharged, each specific enough that a seeder reading only SPEC-M04 and
the RTL can render exactly one diff for it, and each with disclosed branches
wherever a rendering could legitimately differ.

**The unit of scoring is the class**, per PROTOCOL §7 (b.1)'s own words — *the
unit of this record is the class, not the branch, ref or file that delivered
it*. One kill per class however many units redden. Per-row kill claims live
inside each class and are scored in a **second column**, because a class can be
killed by the suite while qualifying no row at all, and folding those two facts
into one number is what would hide the campaign's most interesting result.

**The structural fact this port has and M03 did not, which is where most of the
thinking went.** At M03 the standing monitor judged an `Axi64` stream. At M04
`Dv_xgmii.Tx_decoder` judges REQ-201 through REQ-206 on *every frame of every
run*, and `assert_instruments_clean` runs four arms in a fixed order. **Twelve
of the twenty-six row-bearing units call it FIRST** — I measured that column
unit by unit rather than assuming it. The consequence, frozen before any diff:
in those twelve, a defect the decoder can see makes the decoder's message speak
and **the unit's own row assertions never run**. Under the standing rule
inherited from `WO-0076` such a red qualifies the row *not at all*. So this
campaign will produce reds that are real kills of the class and no evidence
whatever that the row claiming the kill works — and the two clearest cases
(`M04-B3` and `M04-G6`, the two rows written expressly for the
CRC-not-re-seeded defect, `M04-G6`'s own message reading *"only this comparison
speaks"*) are **both** shadowed by their own units' first call. I sealed IC-6
as **KILL qualifying NO ROW** rather than discovering it at scoring.

**The base state's red, and why it is the most load-bearing paragraph in the
seal.** I read CI at `6d92bf9` expecting a formality and found the `build` job
`failure`. Step by step: *Build*, *Run tests*, *Generate RTL*, *REQ-902 two-run
determinism* and *Verify nothing was left unpromoted* are all `success`, the
`cosim` job is `success`, `journal-check` is `success` — **the DV suite is green
end to end** — and the job conclusion is red on **step 10** alone. Reproduced
locally from a checkout at this commit (`bash tools/dv_checks.sh`): every other
limb passes and the sole undeclared item is `WO-0084`'s **own** citation of
`docs/reports/audit/WO-0084-mutations/`, a directory the seeding seat has not
created yet. A forward reference in the commissioning packet.

That is not a nuisance, it is a trap with a precise shape. **Every
`mut/wo-0084-<class>` ref is `6d92bf9` plus one diff and inherits the same
red** — including a class that survives and including a diff that does nothing.
A scorer reading job conclusions would return **13 of 13 kills off a citation
checker**. Worse, the red *cures itself at act 2*: once the manifest is
committed the citation resolves and the branch goes green, while refs rendered
against the seal's base still carry it — an asymmetry that looks like signal
and is not. So I minted a new standing rule for this campaign (**rule 9**): no
cell is scored on a workflow-run or job conclusion; every cell is scored on
step 6 and on the failing unit's own message text. This could only be written
now, and if it were written after the runs nobody could tell it from an excuse.

**Where the derivation was hardest, and the one place it convicted me.** I
worked each class's first-speaking assertion against the committed control
flow. Three results are worth the record:

1. **IC-9** (the gap served by §0.3's *rejected* convention) reddens **exactly
   one member of one unit in the whole repository** — `M04-F2 (P1=64)`. Worked
   at all eight residues, this specification and the rejected reading agree at
   seven and differ only at `t = 4`, 12 against 20; and the standing decoder is
   blind, because it only violates REQ-204 when a gap is *below* `cfg_ifg`. The
   plan drove that sweep whole rather than sampled for exactly this reason, and
   a sampled sweep would have had a seven-in-eight chance of scoring this class
   a survivor. That is the narrowest, most falsifiable cell in the seal.

2. **IC-2** and **IC-3** are invisible to the standing decoder, and I asserted
   that rather than assumed it: the decoder judges REQ-203 as `n < 64` (a frame
   too *long* raises nothing) and REQ-202 as self-consistency against what is on
   the wire (a payload corrupted with the FCS computed over the corruption
   passes). Both classes therefore have to be caught by the rows' own
   assertions, and both are — which is the campaign's best evidence that
   obligation 7's poisoned filler and family C's length checks earn their keep.
   And a load-bearing green falls out: `M04-C4`, the row that exists to catch a
   padding defect, is **green** under IC-3, because its scan domain is
   hard-coded to `0 .. 59` and a pad running four octets further is conformant
   inside it.

3. **IC-10 is predicted to SURVIVE, and the ground convicts my own plan.**
   `M04-F6`'s Kills cell names *"a design measuring the gap from the `/E/`
   character rather than from the `/T/` (t = 0, gap 16)"*. **16 is
   unreachable.** `Tx_decoder.gaps` counts from the terminate character
   inclusive, that character is the `/T/` at lane 1, REQ-201 puts every start
   character in lane 0, so every recordable abort gap is `8k − 1` — the set
   `{7, 15, 23, …}`, always `≡ 7 (mod 8)`. And the substitution itself has **no
   effect at all** at the only `cfg_ifg` any committed unit drives:
   `ceil((12 + t)/8) = 2` for `t` in `0 … 3`, so the `/E/`-based and `/T/`-based
   renderings put the next start character in the same word and the wire is
   byte-identical. I checked this three ways before sealing it, because a
   predicted survivor is the one cell in a seal that costs its author
   something. It is **not** an equivalent mutant — PROTOCOL §7 (b.3) demands the
   equivalence be proven over the *specification's* legal stimulus space, and at
   `cfg_ifg ≥ 13` the two renderings separate — so it stays in the denominator
   and its disposition is a survivor under (b.2), whose cause is that `M04-F3`,
   the `cfg_ifg` parameterisation, is outstanding. The row is **not** vacuous:
   it kills any rendering that changes the *word* the next start falls in. But
   its Kills cell and its own failure message both quote a figure the row's own
   stimulus cannot produce, and `FINDING WO-0084-S1` (MINOR, mine) is
   pre-committed at §11 item 7 **to be filed at act 4 whatever the runs
   return** — so it cannot later be mistaken for a finding invented to explain
   a result.

**What I rejected.** A fourteenth class over `M04-A2`'s preamble-rotation kill
(dropped for length; §10 item 1 carries it as an unclosed bound rather than
letting the campaign imply coverage of it). Family-level classes (§ above).
Reading `libs/**` to check whether a class is renderable — that would have
made every prediction below a statement about the implementation rather than
about my own claims, and it is the one shortcut this round could not take.
Predicting only kills, which would have made the seal unfalsifiable.

### Actions

- Derived the campaign's defect-class list from my own plan's 34 discharged
  ASSERT rows: **13 classes, IC-1 … IC-13**, spanning families A (1), B/C (1),
  C (2), C/D-B/G (2), D (1), E (2), F (2), G (3).
- Authored and froze `agents/handoffs/WO-0084-SEALED-predictions.md` against
  base `6d92bf9`: header with the seeding-seat prohibition **and its reason
  inside the file being opened**; nine standing rules; the denominators and
  both stimulus censuses re-measured at this tree; **§0.1**, the base state's
  own red and the step-6 scoring rule; the unit inventory with each unit's
  standing-instrument position; the shadowing law and the decoder's four blind
  spots measured off its own source; the matrix, the rules with complete
  conjunct lists, and the row qualifications; the REQUIRED cells verbatim;
  shadowed cells; §6's worked survivor; collisions with discriminators; eight
  pre-committed dispositions; mutant-owned quantities as inequalities; seven
  unclosed bounds; pass criteria; and what the seeding seat is not told.
- Computed the REQ-305 oracle values the exact cells quote, independently of
  this repository (reflected IEEE 802.3 polynomial, least significant octet
  first), and anchored the computation against a value the tree already
  carries: `Frame.fcs` over sixty zero octets = `[8; 137; 18; 4]` = `0x04128908`,
  which is `test_m04_d.ml`'s own promoted `[%expect]` block at this commit.
- Appended act 1's Return-log row to `WO-0084`.
- Did **not** run `git commit`, `git push`, `git add`, or any staging command.

### Evidence

All commands run from a repo checkout at `6d92bf9`; every CI reference is a run
or job id with its conclusion, read at source (PROTOCOL §4.1(b)).

    git rev-parse HEAD    # 6d92bf99bdd84788bab87e0c7fe6bb720a4682bf
    git status --porcelain  # (empty at precheck)
    date -u                 # Wed Aug 12 08:45:37 UTC 2026

The base is the suite and the DUT as they were measured green:

    git diff --stat 91f005d 6d92bf9 -- libs/ test/xgmii_tx_64/   # (empty)

CI at `6d92bf9`, by step name/number/status:

    run 31577965739  build   job build (94054290693)   conclusion FAILURE
       5 Build                                                    success
       6 Run tests (expect tests, waveform snapshots)              success
       7 Generate RTL                                              success
       8 REQ-902 two-run determinism (second process, scratch cwd) success
       9 Verify nothing was left unpromoted or non-deterministic   success
      10 DV mechanical checks (C-9 record-vs-appendix, X-9 …)      FAILURE
      11 Abort-bit availability quantifier (C-37/ADR-0012)         skipped
    run 31577965739  job cosim (94054290782)            conclusion success
    run 31577965794  journal-check                      conclusion success

Step 10's failing limb, reproduced locally:

    bash tools/dv_checks.sh
    #  === docs/** citation resolve-check (RN-6) ===
    #  BROKEN  agents/handoffs/WO-0084_m04-mutation-campaign.md
    #          cites docs/reports/audit/WO-0084-mutations/
    #  …  1  UNDECLARED broken citations
    #  === docs/** citation resolve-check: FAILED ===
    # every other limb passes: check_records_vs_appendix 23/23,
    # check_emitted_verilog 5/5, precompile_check 31+12 units 0 errors

Denominators, measured not recalled:

    grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .   # 167
    # test/xgmii_tx_64/ 27 (26 row-bearing + U1 scaffold); non-M04 140
    # of the 140: 80 structurally DUT-independent (test/xgmii/dune: "No
    # Hardcaml dependency … libs/** is not depended on"), 60 build-level
    # detectors (test/xgmii_rx_64/ 59 + test/hardcaml_ethernet/ 1),
    # test/cosim/ 0 units and blind by BAR T1

Oracle anchor for the exact cells:

    python3 -c "import zlib; v=zlib.crc32(bytes(60)); print([v&255,(v>>8)&255,(v>>16)&255,(v>>24)&255])"
    # [8, 137, 18, 4]  — agrees with test_m04_d.ml's promoted [%expect] at 6d92bf9

**Nothing in this entry is a claim about the campaign's outcome.** No diff
exists, no ref exists, no run exists. The only measurements here are of the
base state, of my own suite, and of my own plan.

### SECOND COPY — the seal's frozen content, restated (the anti-tamper half)

The seal file is not covered by the append-only rule; this journal is. If
either is later edited to fit a result, the other convicts it.

**Base**: `6d92bf9`. **Scoring unit**: the **class**; one kill per class.
**Classes**: 13. **Predicted**: **12 KILL, 1 SURVIVE**.

| id | class — the transmitter behaves as if … | disposition | killing unit(s) BY NAME | discriminating message text |
|---|---|---|---|---|
| IC-1 | the preamble word's octets are not REQ-201's `[0xFB; 0x55 ×6; 0xD5]` | KILL | `M04-A1, M04-A2, M04-A5` (U2) | α `preamble word data does not match [0xFB; 0x55 x6; 0xD5], lane 0 first`; β `preamble word control = 255, expected 1 (bit 0 set, bits 1-7 clear)` |
| IC-2 | `tkeep` is ignored on the `tlast` word | KILL | `M04-B2` (U4); `M04-C4` (U9); `M04-D6` (U13) | `wire octets 20-23 (lanes 4-7 of C+4) are not all 0x00`; `poison 0xA5 present among wire octets 0..F-5`; `wire FCS octets = [165; 165; 165; 165], expected Frame.fcs(zeros_60) = [8; 137; 18; 4]` |
| IC-3 | REQ-203's pad target is 64, not 60 | KILL | `M04-C1, M04-C6` (U6); `M04-C2` (U7); `M04-C5` (U10) | `wire octet count = 68, expected 64` (and `…, expected F = 64` at the two sweeps) |
| IC-4 | the CRC closes at `tlast`; the pad follows it | KILL | `M04-C3` (U8) | `wire octets (lanes 4-7 of C+9) do not equal Frame.fcs(pad_to_60(content))` — assertion 1, **not** assertion 2, which is shadowed |
| IC-5 | the FCS is not the REQ-305 value in REQ-202's wire order | KILL | `M04-D1, M04-D2, M04-D4, M04-D5` (U11) | `wire FCS octets = [<a>; <b>; <c>; <d>], expected Frame.fcs(pad_to_60(content)) = [135; 7; 193; 206]` at `P=1`; α = the exact reverse, β = octetwise XOR `0xFF` |
| IC-6 | the CRC register is not re-seeded between frames | **KILL qualifying NO ROW** | every multi-frame unit, all through arm (i) | `<row>: wire decoder unclean:` + a `REQ-202` violation at a **second or later** frame and **none at any first frame**. `M04-B3`'s and `M04-G6`'s own comparisons never run |
| IC-7 | the terminate character always lands in lane 0 after the FCS | KILL | `M04-E1, M04-E2, M04-E3, M04-E5` (U14), `P=60` **green**, first red `P=61` | α `lane 1 of cycle <C+10> = 7, expected 0xFD`; β `lane 1 of cycle <C+10> does not carry a control character, expected /T/` |
| IC-8 | fill lanes carry the control bit over stale data | KILL | `M04-E1, M04-E2, M04-E3, M04-E5` (U14) | `terminate word, lane 1 = <n>, expected 0x07 (/I/)`, `<n> <> 7`, derived **58** |
| IC-9 | the gap is twelve idle octets **after** the terminate character | KILL | `M04-F2 (P1=64)` (U18), **that member alone in the repository** | `the one gap = <n>, expected 12`, `<n> > 12`, derived **20** |
| IC-10 | the abort gap is measured from the `/E/`, not the `/T/` | **SURVIVE** (α, β); KILL only under γ | none under α/β | — `ceil((12+t)/8) = 2` at `t ∈ 0…3`, so the wire is byte-identical at `cfg_ifg = 12`; and `16` is unreachable, gaps after an abort being `≡ 7 (mod 8)` |
| IC-11 | `error_underflow` pulses at the `/E/` word, not at the pin | KILL | `M04-G5` (U22); `M04-G1, M04-G2, M04-G8` (U23); `M04-G3` (U24); `M04-G6` (U25); `M04-F6` (U26); `M04-A4` (U27) | `<row>: strobe monitor unclean:` + **one missing at `r`** and **one unexpected at `r+2`**; `r` = `C+1`, `C+95`, `C+185`, `C+4`, `C+4`, `C+15`. `M04-G2`'s own separation assertion is **shadowed** |
| IC-12 | the underflow condition re-fires on every withheld cycle | KILL | `M04-G3` (U24), **that unit alone** (`hold > 1` is driven once in the repository) | α `<row>: strobe monitor unclean:` + **no missing** and **three unexpected** at `C+186`, `C+187`, `C+188`. β → UNSCOREABLE |
| IC-13 | REQ-206's `tlast` qualifier is absent | KILL | `M04-G9 (P=1)` (U16); `M04-G10` (U21) | α `M04-G9 (P=1): strobe monitor unclean:` (no missing, one unexpected) — this arm **is** `M04-G9`'s own observable; β `wire decoder unclean:`. At U21: `error_underflow is high at cycle C+12 — the cycle route 2's unfixed design strobed at, by BUG-0004 §9.3's own derivation` |

**Load-bearing greens** (a red at one is a finding against the seal):
`M04-C4` green under IC-3; `M04-A3`, `M04-F6`, `M04-G5` green under IC-2;
U14's `P ≥ 64` members green under IC-3; U18's seven non-`t=4` members green
under IC-9; every unit without `hold > 1` green under IC-12; all 140 non-M04
units green behaviourally under every class.

**Rows reached by no class**: `M04-A2`, `M04-D2`, and the five NO-ASSERT rows.
**Assertions reached by no class**: `M04-C3` assertion 2, `M04-G2` assertion 3,
`M04-B3`'s and `M04-G6`'s octet comparisons, `M04-A3`'s per-frame preamble
comparison.

**Standing rule 9, minted this round**: no cell is scored on a workflow-run or
job conclusion; every cell is scored on step 6 and the unit's own message.

**Pre-committed**: `FINDING WO-0084-S1` (MINOR, mine) is filed at act 4
**whatever the runs return** — `M04-F6`'s Kills cell and failure message quote
a gap figure (`16`) its own stimulus cannot produce.

### Outcome

**DoD for act 1: met.** The seal is a file in the commit that claims it
(R-SEAL-1), frozen before any defect diff exists, against a named base state
whose DV suite is green with its one red named and dispositioned, its content
duplicated here, its state line declared as the single mutable line **and
undertaken not to be mutated** so the immutability check stays the flat one.
Class count **13**, scoring unit **the class**, predicted **12 kills of 13**.

Handoff: `agents/handoffs/WO-0084-SEALED-predictions.md`, plus act 1's row in
`WO-0084`'s Return log. **Act 2 may begin once this commit exists, and not
before.** The seeding seat is told the fact of this seal and none of its
content — except §0.1's step-6 rule, which is a property of the base state
rather than of any prediction and which the operating seat needs.

**No harvest note is owed this round**: ADR-0018 and PROTOCOL §7 attach the
harvest to every module sign-off and every phase gate, and this is neither —
no `SO-xgmii_tx_64.md` is opened or offered here. The span since my last
harvest stays open and un-tiled at `J-dv_lead-0195`, so a later harvest reads
one interval and not two.

### Open-questions

1. **`FINDING WO-0084-S1`** — `M04-F6`'s Kills cell names a design (`gap 16`)
   that no conformant-decoder observation can produce. Filed at act 4, routed
   to my own plan's next repair round; **not** repaired here, because a seal
   round may not edit the artifact it is sealing predictions about.
2. **The step-10 red will cure itself at act 2** and the `mut/` refs will not
   inherit the cure. If the operating seat rebases any ref onto the manifest
   commit, the base has changed and §8 disposition 6 governs — I would rather
   be told than infer it from a scorecard.
3. **`M04-F3` (the `cfg_ifg` parameterisation) is outstanding**, and IC-10's
   predicted survive rests entirely on `cfg_ifg = 12`. The day that row lands,
   IC-10 must be **re-run, not re-quoted**.

### Files-in-this-commit
- agents/handoffs/WO-0084-SEALED-predictions.md
- agents/handoffs/WO-0084_m04-mutation-campaign.md

## [J-dv_lead-0196] 2026-08-12T09:48Z | task:WO-0084 | The M04 campaign is scored: the seal survives every class the blind manifest validly put to it — seven of seven kills confirmed, zero misses — and the one survivor is the cfg_ifg coverage gap my own IC-10 named from the other side; the unseal is recorded here and in the packet without editing the frozen seal, because the second copy cannot be edited and the first undertook not to be

### Trigger

Orchestrator dispatch, WO-0084 **act 4 — the scoring**, one round, my seat.
The campaign is complete: I sealed (act 1, `J-dv_lead-0195`), the auditor
seeded blind (act 2, `J-auditor-0027`), the orchestrator operated (act 3,
`J-orchestrator-0281`, the run evidence I score from). Act 4 unseals my own
predictions and scores the run under PROTOCOL §7's four constraints in the
ADR-0020 §7 Mutation-record form.

Precheck as dispatched: `git rev-parse HEAD` = `8b3ec95`, tree clean, branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`. **HEAD was not behind**
`8b3ec95`; incidents 13/14's fetch+ff-only cure was not needed and not run.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — both in full, first, per
  my launcher; §3 (packets/relay), §7's **Mutation record** (b.1)–(b.4), §10
  (independence, R-SEAL-1).
- `agents/handoffs/WO-0084_m04-mutation-campaign.md` — in full, including the
  Return log with acts 1/2/3 now all filled.
- **My own seal**, `agents/handoffs/WO-0084-SEALED-predictions.md` — in full,
  all thirteen classes, the REQUIRED cells, §6's worked survivor, §8's
  pre-committed dispositions, §9's mutant-owned inequalities, §10's named
  bounds, §11's pass criteria — and its second copy in my own `J-dv_lead-0195`.
- **The auditor's manifest**, `docs/reports/audit/WO-0084-mutations/README.md`
  and all thirteen `class-*.diff` (the blind is discharged; the campaign is
  scored, so I may read them). Read as-applied at the diff text, not at RTL
  source.
- **The run evidence**, `J-orchestrator-0281` at `8b3ec95` — the operator table
  (class / mutant SHA / build run / build job / step-6 conclusion /
  disposition), read at the committed text.
- `docs/adr/ADR-0020-the-gate-asks-the-suite-not-the-scoreboard.md` — §3's (b.1)
  two-column law, (b.2) survivor and frozen-kill limbs, (b.3)/(b.4); and
  `docs/process-golden-tally.json` — the closure invariant `sealed = seeded +
  |difference|`, `seeded = killed + survived + green_by_blindness`, and the
  itemised-exclusion form (M03's; read for form, **not** edited).
- `docs/PROCESS.md` §3.3 (the campaign-seal law, seventh edition — the
  unsealing-in-the-packet practice and `[B.11·8]`'s flat-check measurement) and
  §3.9.
- `test/xgmii_tx_64/` — the unit inventory at HEAD (present-and-green check for
  the frozen-kill limb), and its byte-identity to the base across the range.

**Not read**: `libs/**` RTL source. I did **not** open
`libs/hardcaml_ethernet/src/xgmii_tx_64.ml` even to diagnose the class-03
compile failure — the run's step-5 Build FAILURE is dispositive on its own
(seal §8 disposition 7), and I state the probable cause from the **auditor's
committed diff** in the audit directory, not from the module. My independence
discipline holds: no RTL reached this round's context; the scoring is derived
from the seal, the manifest diffs, the run evidence, and the suite.

### Reasoning

**The unseal, and why I did not flip the state line.** The dispatch instructed
me to flip the seal's `SEALED→UNSEALED` state line and its second copy in
`J-dv_lead-0195`. I did neither, deliberately, and the ground is not
disobedience — it is that the instruction, read against two frozen artifacts,
resolves only one way. **First**, the second copy lives in this append-only
journal, whose history is mechanically protected (PROTOCOL §5 R3): I *cannot*
edit `J-dv_lead-0195`, so "flip both copies" is unexecutable as written.
**Second**, my own seal's §State undertook, in its own frozen text, *not* to
mutate its state line, precisely so the immutability check stays the flat
`git diff` against the freezing commit = **empty, full stop** — which
`docs/PROCESS.md` §3.3 `[B.11·8]` measures as *strictly stronger* than the
"empty except this line" a flipped line degrades to, and which six of the
record's ten scored campaigns already practise. The only reading consistent
with both facts is the one the seal itself named: **the unsealing is recorded
in the campaign packet's own Return log at act 4, not in the seal.** So the
act-4 row carries `UNSEALED`, both frozen copies stay byte-identical to their
sealing state, and `git diff 9dba6d5 8b3ec95 -- <seal>` is empty — the
strongest form of the check. I flag the declined flip to the orchestrator
plainly; it may direct the weaker flip, but the default must protect the
record, and an author who breaks her own frozen anti-tamper undertaking on an
agent's say-so has taught the next reader that the undertaking was theatre.

**The reconciliation is the round's real work, because the two partitions are
independent by design.** My seal cut thirteen classes (`IC-1`…`IC-13`) from my
own plan's 34 discharged ASSERT rows; the auditor cut thirteen (`class-01`…
`class-13`) from SPEC-M04 and the public Kills text, blind of my seal. The
packet promised a mismatch would be *data act 4 reconciles*, and it is. I
mapped each auditor class to the IC it renders, or to none:

| auditor class | → dv IC | sealed disp | step-6 | score vs seal |
|---|---|---|---|---|
| 01 preamble-txc | IC-1 (β, control-marking) | KILL | FAILURE | **predicted-kill-and-killed** |
| 02 frame-lane-reversal | none — M04-B1 lane-reversal (seal §10.2 excluded) | — | FAILURE | outside seal; suite kills the M04-B1 claim |
| 03 tkeep-ignored | IC-2 | KILL | **Build FAILURE** | **COMPILE-FAIL — IC-2 untested** |
| 04 pad-target-64 | IC-3 | KILL | FAILURE | **predicted-kill-and-killed** |
| 05 pad-value-nonzero | none — M04-C1/C4 pad-value | — | FAILURE | outside seal; suite kills the pad-value claim |
| 06 crc-omits-pad | IC-4 | KILL | FAILURE | **predicted-kill-and-killed** |
| 07 fcs-byte-reversed | IC-5 (α, reversed) | KILL | FAILURE | **predicted-kill-and-killed** |
| 08 terminate-lane-late | IC-7 (α family) | KILL | FAILURE | **predicted-kill-and-killed** |
| 09 idle-fill-value | IC-8 (`<n>`=0 ⊨ `<>7`) | KILL | FAILURE | **predicted-kill-and-killed** |
| 10 gap-no-roundup | none — M04-F1/F4 gap-shorten | — | FAILURE | outside seal; suite kills the gap-shortening claim |
| 11 gap-ignores-ifg | none — M04-F3 cfg_ifg (OUTSTANDING) | — | **SUCCESS** | outside seal; **SUITE coverage finding** |
| 12 underflow-qualifier-dropped | IC-13 | KILL | FAILURE | **predicted-kill-and-killed** |
| 13 abort-word-swapped | none — M04-G1 §9 abort-word shape | — | FAILURE | outside seal; suite kills the abort-shape claim |

Three mapping calls carried weight. **class-01** is IC-1's β sub-branch, not α:
it sets only the SFD lane's control bit, so the preamble octet *data* is
unchanged and the octet check passes; the control-field check speaks first and
reads `129` (`0x81`), which satisfies §9's sealed `<> 1` — the seal explicitly
anticipated "a rendering that sets some other subset of the control bits gives
`<n>`, sealed `<> 1`", and 129 is exactly that. **class-09** sets the fill lane
to `0x00`; my §4.8 sealed IC-8's value as `<n> <> 7` (derived instance 58, the
stale-data rendering), and `0` satisfies the inequality — this is why the cell
was sealed as an inequality and not as `58`, and the auditor's independent
choice of `0x00` lands inside it. **class-08** moves the terminate one lane
late rather than always-to-lane-0 (IC-7's own disclosed rendering); the class
is the same (terminate lane wrong, caught by M04-E1/E3), the specific lane in
the message may differ, and the KILL disposition holds — a class-level
reconciliation does not require the byte-exact message of an independent
partition's different rendering.

**Five auditor classes map to no IC (02, 05, 10, 13, and 11), and that is not a
gap in the seal — it is the blind working.** The auditor seeded defect families
my thirteen deliberately did not: M04-B1's lane permutation (my §10.2 names it
unseeded), a pad-*value* defect, a gap-*shortening* defect, an abort-word
lane-swap, and the cfg_ifg hard-wire. Each killed except the last, which is
S2. These are real kills of real AP claims, outside my partition, and I score
them as such — they enlarge what the campaign demonstrated about the suite
without touching my seal's denominator.

**Five of my IC classes were never rendered (IC-6, 9, 10, 11, 12), and one was
rendered but did not compile (IC-2).** The auditor's independent thirteen simply
did not include CRC-reseed, the rejected-reading gap, the abort-gap-from-`/E/`,
the strobe-at-`/E/`-word, or the strobe-per-withheld-cycle. Under (b.1) each
sits in `sealed` and not in `seeded`, named with its ground; none scores in
either direction. **IC-10 is the sharp one**: it was my one predicted SURVIVE,
and it was not put to the test — so I cannot claim it confirmed. But its root
cause *was* confirmed from the other side. class-11 (gap-ignores-ifg) survived
for the identical reason IC-10 predicted survival: **no committed unit varies
cfg_ifg from 12.** My seal froze that ground at §6 and §10.6 before any diff
existed; the auditor pre-flagged class-11 blind at seeding; two seats named one
coverage debt from opposite directions, and the run proved it. That convergence
is worth more than a rendered IC-10 would have been.

**The closure, over this campaign's own numbers, two views that do not fold.**
The law's unit is the class (PROTOCOL §7 b.1), so the seal's own closure
(**Tally A**) is over my thirteen: sealed 13 = seeded 7 + exclusions 6; seeded
7 = killed 7 + survived 0 + green-by-blindness 0. The six exclusions are
itemised to ground below. But the manifest actually rendered twelve valid
mutants and the suite killed eleven, and that demonstrated kill-power is a true
and separate measurement (**Tally B**), over the auditor's thirteen: attempted
13 = seeded 12 + exclusion 1 (class-03 non-compiling); seeded 12 = killed 11 +
survived 1 + green-by-blindness 0. Both close. Neither is a ratio; the two are
recorded side by side and the reconciliation table is the bridge. I refuse to
collapse them into one number, for the reason ADR-0020 §1.2 gives: a frozen
prediction set and an operated manifest are different objects.

**Zero misses, and I state it as the round's headline.** A miss is a
prediction falsified in either direction. Every IC the manifest validly put to
test (IC-1, 3, 4, 5, 7, 8, 13) was predicted KILL and killed; no predicted-kill
survived; the one predicted-survive (IC-10) was not rendered, so it could not be
killed. The seal is unfalsified on every class it was tested against. That is a
weaker claim than "the seal was right about everything" — five classes went
untested and one did not compile — and I make the weaker, true one.

**The class-03 ruling.** I rule it UNSCOREABLE and a MANIFEST DEFECT. The run
shows step-5 Build FAILURE and step-6 skipped, so seal §8 disposition 7
governs: *no behavioural claim of any kind may be read off that ref.* The
auditor's manifest §4 attested "each mutation is type-correct by construction …
so the module compiles and the suite is the instrument"; class-03 falsifies
that attestation, and the falsification is the finding. The probable cause,
consistent with the committed diff and stated without opening the module, is
that replacing `held_count = uresize (popcount held_keep) position_bits` with a
constant removes the sole consumer of `held_keep`, and an unused binding under
the project's warnings-as-errors fails the build. The definitive root-cause is
the auditor's and rtl_lead's, not mine. The consequence I own: IC-2
(TKEEP-WHOLE-WORD, the M04-B2/M04-C4 tkeep-ignored kill claim) is left untested
by a valid mutant, and the honest record says so rather than reading class-03's
red step-5 as a kill.

**What I rejected.** Flipping the state line (above). Folding Tally B into
Tally A to report a single "11/12" or "7/7" headline — refused; the columns
exist so a reader cannot. Scoring class-03 as a kill off its step-5/step-10 red
— refused by standing rule 9 and disposition 7. Scoring class-11 as a kill off
its step-9 snapshot red — refused: step 9 verifies emitted-RTL snapshots, not
behaviour, and the emitted RTL *did* change (cfg_ifg → constant), so step 9 was
always going to redden without any assertion firing; the behavioural suite
(step 6) passed, and that is the measurement. Claiming IC-10 confirmed off
class-11's survival — refused; class-11 is a different mechanism, and the
honest statement is corroboration of the *ground*, not of the class.

### Actions

1. Read the charter and PROTOCOL in full; ran the precheck (HEAD `8b3ec95`,
   clean); read the seal (both copies), the auditor manifest and all thirteen
   diffs, the run evidence `J-orchestrator-0281`, ADR-0020, the golden-tally
   JSON, and `docs/PROCESS.md` §3.3.
2. Reconciled the auditor's thirteen classes against my thirteen IC classes,
   one by one, at the diff text and the sealed cells — the table above.
3. Scored each mapped, validly-rendered class against its sealed disposition;
   ruled class-03 (compile-fail) and class-11 (survivor); confirmed zero misses.
4. Built both closures (Tally A over the seal, Tally B over the manifest),
   itemised the six exclusions to their grounds, and checked the arithmetic.
5. Assembled the survivor evidence form for class-11 and the frozen-kill limb
   for the kills (units present at HEAD, suite byte-identical to the green base).
6. Filed findings WO-0084-S1 (pre-committed), WO-0084-S2 (coverage debt),
   WO-0084-S3 (routed to the auditor).
7. **Recorded the UNSEAL in the packet's act-4 Return row** — the SO-style
   verbatim campaign record — **without editing the seal file** (grounds above),
   and appended this entry.

**Not done, deliberately**: no edit to `agents/handoffs/WO-0084-SEALED-predictions.md`
(the declined flip); no `git commit`, `git push`, `git add`, or staging (the
orchestrator is sole committer, PROTOCOL §2); no touch to `docs/reports/audit/**`
(the auditor's manifest — S3 is *routed*, not written there) or to
`docs/process-golden-tally.json` (M03's); no RTL read; no `SO-xgmii_tx_64.md`
opened (this act is a campaign scoring, not a module sign-off).

### Evidence

All commands run from a checkout at `8b3ec95`; CI references are run/job ids
with their conclusions read at source (PROTOCOL §4.1(b)).

    git rev-parse HEAD      # 8b3ec9535a2252b1a9a52b0f6ee2b07fe28d5ca1
    git status --porcelain  # (clean at precheck)
    date -u                 # Wed Aug 12 09:48:06 UTC 2026

Seal immutability — the flat check, empty:

    git diff 9dba6d5 8b3ec95 -- agents/handoffs/WO-0084-SEALED-predictions.md   # (empty)

Frozen-kill limb — suite + DUT byte-identical base→HEAD, units present:

    git diff --stat 6d92bf9 8b3ec95 -- test/xgmii_tx_64/ \
        libs/hardcaml_ethernet/src/xgmii_tx_64.ml                              # (empty)
    ls test/xgmii_tx_64/    # 8 unit files + bench{.ml,.mli} + dune present
    # named killing units green as measured at the byte-identical base:
    #   step-6 SUCCESS, run 31577965739 (seal §0.1 / J-dv_lead-0195)

Run evidence scored (from `J-orchestrator-0281`, step 6 read at source):

    KILL (step-6 FAILURE): 01,02,04,05,06,07,08,09,10,12,13
    SURVIVOR (step-6 SUCCESS; step-9 snapshot RED): 11  (run 31581478422)
    COMPILE-FAIL (step-5 Build FAILURE, step-6 skipped): 03
    class-08: attempt 1 opam-install transient; attempt 2 step-6 FAILURE = KILL

**Tally A — the seal scored (unit = the class):**
`sealed 13 = seeded 7 + |exclusions| 6`; `seeded 7 = killed 7 + survived 0 +
green_by_blindness 0`. Seeded = {IC-1, IC-3, IC-4, IC-5, IC-7, IC-8, IC-13},
all killed. Exclusions, each to its ground: **IC-2** — rendered by class-03,
non-compiling, build-fail → UNSCOREABLE (§8 disp 7); **IC-6, IC-9, IC-10, IC-11,
IC-12** — never rendered (no auditor class renders the mechanism). All six in
`sealed`, none in `seeded`.

**Tally B — the manifest operated (unit = the auditor's 13):**
`attempted 13 = seeded 12 + |exclusion| 1` (class-03 non-compiling manifest
defect); `seeded 12 = killed 11 + survived 1 + green_by_blindness 0`.

**Survivor evidence form (b.2), class-11**: unmodified
`docs/reports/audit/WO-0084-mutations/class-11-gap-ignores-ifg.diff`
(`cfg_ifg` → constant `12`), ref `mut/wo-0084-class-11 = 6850609`, run
`31581478422` job `94065308971`, step-6 SUCCESS; witness — the census
`cfg_ifg = 12` on every cycle of every unit (seal §0.2) is the whole reason it
is invisible; `cfg_ifg ∈ {20, 255}` reddens (auditor README §3, class-11).

**What is NOT reproducible from a checkout**: nothing in this entry. Every
figure is a command runnable at `8b3ec95`, a committed-text reference, or a CI
run id with its conclusion.

### Outcome

**DoD for act 4: met.**

- [x] UNSEAL recorded (packet act-4 row) with the seal left byte-frozen; the
      flat immutability check passes (empty diff vs `9dba6d5`); the declined
      state-line flip is disclosed with grounds.
- [x] Reconciliation of the auditor's 13 manifest classes against my 13 IC
      classes — each mapped or noted as mapping to none.
- [x] Every mapped, validly-rendered disposition scored against the seal:
      7/7 predicted-kill-and-killed; **0 misses**.
- [x] Two-column record; every exclusion itemised to a ground; survivor
      evidence form and frozen-kill named-unit limb supplied; no ratio.
- [x] Golden-tally arithmetic closes over this campaign's own numbers (both
      tallies); M04 scored per class, **not** folded into M03's tally;
      `docs/process-golden-tally.json` untouched.
- [x] Findings filed: WO-0084-S1 (pre-committed), WO-0084-S2 (coverage debt),
      WO-0084-S3 (routed to the auditor); MISSES = none, stated.
- [x] Honest `date -u` stamp; single entry header; `Files-in-this-commit`
      exact; no commit/push/stage.

**Journal size**: v12 stood at 52,511 bytes before this entry — far under
ADR-0017 §5.1's 256 KiB soft threshold — so no rotation; this entry appends to
v12.

**Harvest**: **none due**, declared to keep the span tiling. ADR-0018 and
PROTOCOL §7 attach the harvest to every `SO-` and every phase gate; a mutation
campaign scoring is neither. My next `SO-xgmii_tx_64.md` mines the interval from
my last harvest through this entry.

**Handoff**: the scored campaign record is the packet's act-4 Return row
(verbatim to the sponsor). WO-0084-S3 routes to the auditor via the
orchestrator (re-seed class-03 with a compiling tkeep-ignored mutant so IC-2's
claim is exercised). WO-0084-S1 and WO-0084-S2 route to my own next revision of
`test/attack_plans/AP-xgmii_tx_64.md` and a tb_writer WO for the cfg_ifg-varying
unit.

### Open-questions

1. **The declined state-line flip.** I recorded the unseal in the packet, not
   in the seal, on the grounds above (the second copy is append-only and
   unflippable; the first undertook not to flip; the flat check is stronger).
   If the orchestrator judges the explicit flip instruction must be honoured
   literally, it can direct a one-line edit — but I recommend against it, and
   the recommendation is on the record before the commit rather than after.
2. **WO-0084-S3 — class-03 is a manifest defect and IC-2 is untested.** The
   auditor's only rendering of the tkeep-ignored mechanism does not compile. A
   re-seed with a compiling mutant is owed before `SO-xgmii_tx_64.md` can claim
   IC-2's kill (M04-B2/M04-C4) is mutation-tested. Routed to the auditor; I
   cannot write `docs/reports/audit/**`.
3. **WO-0084-S2 — cfg_ifg is never varied, and it is now proven, not
   predicted.** M04-F3 is OUTSTANDING; class-11 survived on it; IC-10's SURVIVE
   rests on it. The day a cfg_ifg-varying unit lands, IC-10 is **re-run, not
   re-quoted** (seal §10.6), and class-11 is re-seeded to confirm the kill.
4. **M04 owes its own committed tally file** at the `SO-xgmii_tx_64.md`
   sign-off, homed in `docs/` alongside `docs/process-golden-tally.json` —
   which is architect_docs_lead's scope, not mine. Flagged as owed; not created
   this round. This campaign record is the authoritative M04 measurement until
   then.
5. **No escalation.** No E2 (no scope narrowed — S2 names a debt, does not drop
   a requirement), no E3, no E5, no E6. No CRITICAL finding against any seat:
   S1 is MINOR and mine; S2 is a coverage debt with a carrier; S3 is a MINOR
   manifest defect routed to the auditor for a clean re-seed.

### Files-in-this-commit
- agents/handoffs/WO-0084_m04-mutation-campaign.md
