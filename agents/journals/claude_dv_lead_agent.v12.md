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

## [J-dv_lead-0197] 2026-08-12T10:44Z | task:WO-0084 | The two WO-0084 campaign findings my own act-4 scoring routed to my seat are closed: M04-F6's unreachable "16" struck in place with its grounds, and the cfg_ifg coverage debt closed by adding the abort-gap row that re-homes IC-10 and naming the carrier — the plan carries both rows and a tb WO commissions the axis, no RTL opened

### Trigger

Orchestrator dispatch, WO-0084 campaign follow-ups, dv's half — one round, my
seat. It closes the two findings my own act-4 scoring (`J-dv_lead-0196`) routed
to my seat: `WO-0084-S1` (M04-F6's unreachable Kills-cell figure) and
`WO-0084-S2` (the cfg_ifg config-coverage debt that let class-11 survive the
campaign). WO-0084-S3 is the auditor's, in flight this round as the declared
sibling, disjoint from my scope. The WO-0083 stage-2 revision is explicitly held
back to its own queued round (dispatch item 3).

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — both in full, first, per
  my launcher; §3 (packets/relay), §4 (journal grammar), §6 (write scopes), §7
  (Mutation record), §10 (independence, R-SEAL-1).
- `agents/handoffs/WO-0084_m04-mutation-campaign.md` — the campaign packet, act-4
  Return row (my `J-dv_lead-0196` verdict), where S1 and S2 are filed.
- `agents/handoffs/WO-0084-SEALED-predictions.md` — §2 (the cfg_ifg = 12 census),
  §4.10/§4 traceability, §6 (IC-10 worked in full — the abort-gap arithmetic and
  the `≡ 7 (mod 8)` proof), §10.6, §11.6/§11.7 (S1 pre-committed). Read for the
  frozen grounds; not edited.
- `agents/handoffs/README.md` — the WO- packet template.
- `test/attack_plans/AP-xgmii_tx_64.md` — in full: §0.1(i)(iii) (census/polarity
  rules), §1 (row grammar), §2 (standing obligations), §4 (the identity and
  families A–J), §4.F (M04-F1…F6), §5 (rejected attacks), §6/§6.1 (coverage map
  and homing census), §7 (machinery T-1…T-7), §9 (change log).
- `test/xgmii_tx_64/bench.ml`, `bench.mli` — READ (they are test files, not RTL,
  and read is unrestricted) to answer §0.1(iii)'s polarity question: can a
  committed producer drive `cfg_ifg ≠ 12`? `create ()` drives
  `i.cfg_ifg := bits_of_int ~width:8 12` as a constant (lines 68, 129), the
  decoder is built `~ifg:12` (line 72), and the run-length note (line 366) warns
  a round changing cfg_ifg must re-derive g_max. Answer: no producer can today.
- `test/xgmii_tx_64/test_m04_f.ml` — the family-F units; grepped (not opened for
  RTL) to locate the M04-F6 comment/failure-message that quotes "16" (the
  finding's second site, seal §6).
- **NOT read**: `libs/**` RTL — in particular `xgmii_tx_64.ml` was not opened at
  this or any earlier commit for this work. My tests and rows derive from
  SPEC-M04 §6.1's identity, never from the design; the "16"-unreachable proof is
  the decoder's `≡ 7 (mod 8)` arithmetic, not a read of the gap logic.

### Reasoning

**S1 — the correction, and why the "16" was a phantom.** `M04-F6`'s Kills cell
named a `/E/`-vs-`/T/` design's output as *"(t = 0, gap 16) … one octet from
conformant"*. The figure is unreachable and was so when written: `Tx_decoder.gaps`
measures from the terminate character **on the wire**, which §9 fixes as the
`/T/` in lane 1, and REQ-201 fixes every start character in lane 0, so every gap
this decoder can record after an abort is `8k − 1` — `≡ 7 (mod 8)`: {7, 15, 23,
…}, and 16 is not in the set. The author reached "16" by applying the §4 identity's
`8g − t` with the **design's internal** reference lane (`t = 0`) instead of the
**wire's** (`t = 1`); the decoder always subtracts the wire's 1, so the defect
records `8g − 1`, not `8g`. At this row's `cfg_ifg = 12` the phantom is even
starker: `⌈(12+0)/8⌉ = ⌈(12+1)/8⌉ = 2`, so the `/E/`- and `/T/`-based readings
place the next start character in the **same word** and the decoder records **15
either way** — the design is not one octet from conformant, it is byte-identical.
I struck the sentence in place with its date and grounds (never a silent
overwrite, per the plan's own discipline and the dispatch), and rewrote the cell
to state the row's **real** kill: the word count (7 or 23) via the exact `= 15`
assertion. The struck kill's coverage intent is not dropped — it is **re-homed to
M04-F7**, which is what makes S1 and S2 one piece of work rather than two.

**S2 — M04-F3 already carried the class-11 killer; I did not duplicate it.** The
dispatch's "add the attack-plan row(s) that would kill class-11" reads against a
fact the seal already recorded: `M04-F3` (ASSERT, `cfg_ifg ∈ {12,13,16,20,255}`)
is exactly the row whose Kills cell names *"a design ignoring cfg_ifg and
hard-wiring 16 … 20 is the smallest member that can [distinguish it]"* — the
gap-ignores-ifg killer, on the **normal** path. The plan already **carries** that
row; class-11 survived not because the plan lacked the row but because the row is
**outstanding** (no bench, because no producer drives cfg_ifg ≠ 12). Duplicating
it would be noise. So the class-11 half of S2 closes by (a) confirming M04-F3 is
the carrier's target, not adding a twin, and (b) naming a carrier.

**What genuinely was missing — the abort direction, and why M04-F7 is the new
row.** The sealed IC-10 (ABORT-GAP-FROM-`/E/`) is class-11's abort sibling, and
**nothing** in the plan kills it: M04-F6 drives an abort but pins cfg_ifg = 12,
where the class is invisible; M04-F3 drives the axis but only on normal frames,
which never exercise §9's abort gap. IC-10 becomes killable only on an **abort
frame at a cfg_ifg where the `/E/`(t=0) and `/T/`(t=1) readings separate** — i.e.
`cfg_ifg ≡ 0 (mod 8)`, where `⌈(c+1)/8⌉ ≠ ⌈c/8⌉` and the two place the start
character a **whole word** apart (at 16: conformant 23 vs defect 15; at 24: 31 vs
23). That is `M04-F7`: an abort then a normal frame, swept over `cfg_ifg ∈
{12,16,24}`, 12 the control that proves invisibility and 16/24 the discriminators.
This is the "opposite direction" the dispatch named, and it is the disciplined
home for the coverage S1 struck from M04-F6 — the correction discipline forbids
losing a kill silently, so the strike and the new row are the same act.

**The capability read (§0.1(iii), the polarity rule).** Before authorising
M04-F7's stimulus I read the producer's construction surface rather than inferring
from the spec that a cfg_ifg drive is constructible because it is specifiable.
`bench.ml`'s `create ()` hard-drives cfg_ifg = 12 and the decoder ~ifg:12, so no
committed producer can present another value. I recorded this as a new machinery
item `§7 T-8` — where §7 records capability, naming the file that was read — with
tb_writer the executor via the carrier. This also retroactively homes M04-F3's own
long-standing (undeclared) cfg_ifg-drive dependency.

**The carrier decision — a new standalone WO, not a fold into WO-0083.** The
dispatch gave the choice (new WO vs stage-2 fold) with grounds. I chose a new
standalone WO (`WO-0085`, placeholder) for three grounds: (i) dispatch item 3
holds the WO-0083 stage-2 revision to its own queued round, and folding the
cfg_ifg carrier into WO-0083 **is** touching that packet — the tension resolves
against the fold; (ii) the cfg_ifg axis is a self-contained deliverable (one knob,
two units, one comment fix), cleanly a bench of its own; (iii) a standalone WO
keeps the S2 carrier countable and independent of WO-0083's eleven owed items.
The placeholder-id convention is the established one (`J-orchestrator-0273`): I
name the file at the next free id, list it in Files-in-this-commit, and the
orchestrator commits it byte-true then allocates the real number in its own
commit.

**The bench-side second site of S1 stays out of this round.** `test_m04_f.ml`'s
M04-F6 comment/message quotes the same "16 is one octet from conformant". It is in
`test/**` (my scope generally) but the dispatch restricted THIS round's write
scope to the AP, `agents/handoffs/`, and my journal — not the bench. So I did not
touch it; I folded it into the carrier WO's Deliverable 4 (the worker corrects it
when it next opens that bench), which keeps it named and countable rather than
lost. The assertion itself (`= 15`) is right and unchanged; only the failure-path
text is wrong.

**What I rejected.** Duplicating M04-F3 (noise; the plan already carries it).
Striking M04-F6's "16" without re-homing IC-10 (a silent coverage loss — the very
discipline the correction exists to honour). Folding the carrier into WO-0083
(would touch a packet the dispatch defers). Touching the bench this round (out of
the dispatch's write scope). Widening M04-F6 to carry the axis (its exact `= 15`
against the word-count defect is load-bearing at cfg_ifg = 12 — §5 item 12(c)).
Adding 255 to M04-F7 (255 ≡ 7 mod 8 does not separate /E/ from /T/ — §5 item
12(b)). Editing the seal, WO-0084, or `docs/reports/audit/**` (the auditor's,
and the campaign is closed).

### Actions

1. Read charter + PROTOCOL in full; precheck HEAD = `712002f`, tree clean, branch
   as dispatched — no recovery cure needed (not behind).
2. `AP-xgmii_tx_64.md` edits, all in `test/attack_plans/`:
   - **S1**: struck M04-F6's "(t = 0, gap 16) … one octet from conformant"
     Kills-cell claim in place with date + grounds; rewrote the cell to state the
     word-count kill and re-home IC-10 to M04-F7; named the bench-side second
     site.
   - **S2**: added **M04-F7** (family F 6 → 7, ASSERT) — abort gap tracks cfg_ifg,
     kills IC-10; §5 item 12 (M04-F7's three rejections); §6 coverage-map
     REQ-204 (range F6 → F7), REQ-206, REQ-802 lines (F7 homed); §7 **T-8** (the
     cfg_ifg-drive capability, measured absent at bench.ml); §6.1 census output
     re-run and updated 82 → 83 with a 2026-08-12 re-measurement note; §9
     change-log row.
3. Authored the carrier: `agents/handoffs/WO-0085_tb-m04-cfg-ifg-gap-axis.md`
   (placeholder id) — dv_lead → tb_writer, commissioning the cfg_ifg knob, the
   M04-F3 and M04-F7 units, and the M04-F6 comment correction; RTL deliberately
   omitted and said so.
4. Re-ran the §6.1 homing census and the status-cell pass against the saved file;
   verified table contiguity and working-tree scope; appended this entry.

**Not done, deliberately**: no `git` of any kind (orchestrator is sole committer,
PROTOCOL §2 — I refuse any stop-hook commit demand); no touch to the bench
(`test/xgmii_tx_64/**`), the seal, `WO-0084`, `WO-0083`, `docs/reports/audit/**`,
or RTL; M04-F3 not duplicated; no `SO-xgmii_tx_64.md` opened.

### Evidence

All commands from a checkout at HEAD `712002f`; stamp honest from `date -u`.

    date -u                                   # Wed Aug 12 10:44:10 UTC 2026
    git rev-parse --abbrev-ref HEAD           # claude/fpga-hardcaml-agent-orchestration-37ceyf
    git log --oneline -1                      # 712002f (precheck: matched, not behind)

§6.1 homing census, the plan's own quoted command, re-run against the saved file:

    census: 83 83 []      # 83 declared rows, all 83 homed in §6, none unhomed

Status-cell pass over every row table (grep of the six status values):

    59 ASSERT · 12 NO-ASSERT · 6 NO-STIMULUS · 5 STRUCTURAL · 1 GAP · 0 RULING = 83

Row inventory and structure:

    grep -cE '^\| \*\*M04-[A-Z]+[0-9]+\*\* \|'  test/attack_plans/AP-xgmii_tx_64.md   # 83
    grep -cE '^\| \*\*M04-F7\*\* \|'            test/attack_plans/AP-xgmii_tx_64.md   # 1
    # family F rows contiguous F1..F7 (lines 428-434), "### 4.G" header at 436

The only remaining "gap 16" text in the AP is the STRUCK sentence in M04-F6 and
the change-log row describing the finding — no row claims 16 as a reachable
conformant abort output. Working tree at hand-off:

    git status --short
     M test/attack_plans/AP-xgmii_tx_64.md
    ?? agents/handoffs/WO-0085_tb-m04-cfg-ifg-gap-axis.md

The abort-gap arithmetic asserted by M04-F7, derived from SPEC-M04 §6.1's identity
(t = 1 on §9's /T/; conformant `8·⌈(c+1)/8⌉ − 1`, IC-10 defect `8·⌈c/8⌉ − 1`):

    cfg_ifg   conformant   IC-10 defect   separation
       12         15            15         none (control — why M04-F6 can't see it)
       16         23            15         one whole word (8 octets)
       24         31            23         one whole word (8 octets)

### Outcome

**Both findings closed; DoD met.** `WO-0084-S1`: M04-F6's "16" struck in place
with grounds cited to `J-dv_lead-0196` / `WO-0084-S1` / seal §6, corrected to the
word-count kill, IC-10 re-homed. `WO-0084-S2`: the plan carries the class-11
killer (M04-F3, confirmed, not duplicated) and the IC-10 killer (M04-F7, added),
and a carrier is named (`WO-0085`, placeholder) commissioning the cfg_ifg knob
(§7 T-8), both units, and the S1 bench-side second site. The debt closes on the
dispatch's own terms — the plan carries the rows and a carrier is named. Handoff:
to the orchestrator, to allocate `WO-0085`'s number, commit both files, and (a
later round) spawn tb_writer against the carrier. `Files-in-this-commit` lists the
two non-journal files; this journal volume is my own and is excluded per §4.2.
Trailers `Agent: dv_lead`, `Work-Order: WO-0084`, `Journal-Entry: J-dv_lead-0197`.
Not `Journal-Only` — this commit carries work.

**No lessons harvest is owed this round** — it is neither an `SO-` sign-off nor a
phase gate (PROTOCOL §7 / charter §8 attach the harvest to those). The harvest
span from my last note continues to accrue and is discharged at the next `SO-` or
gate; recording the nil-owed here so a skipped harvest is never read into this
gap.

### Open-questions

1. **M04-F3's cfg_ifg-drive dependency was undeclared until now.** M04-F3 has been
   an ASSERT row since the plan's creation, needing a capability (cfg_ifg ≠ 12
   drive) that no producer had — but §7 carried no machinery item for it until
   this round's T-8. Not a defect I can convict retroactively; recorded so the
   next author knows T-8 covers a pre-existing row, not only the new M04-F7.
2. **The bench-side "16" (S1 second site) is deferred to the carrier round.** It
   is out of this round's write scope; folded into WO-0085 Deliverable 4. If the
   orchestrator prefers it closed sooner in a bench-scoped round, the routing is
   a one-line move — the assertion is already correct, only the text is wrong.
3. **The placeholder number is not mine to allocate** (PROTOCOL §3). `WO-0085` is
   the next free id at this tree; if the orchestrator allocates differently, the
   filename and its self-references (WO title/State, AP §7 T-8, this entry's
   change-log row) move together.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_tx_64.md
- agents/handoffs/WO-0085_tb-m04-cfg-ifg-gap-axis.md

## [J-dv_lead-0198] 2026-08-12T11:12Z | task:ADR-0022 | ADR-0022 row 1 countersigned ACCEPT — the re-scoped warranty guards exactly the rule of what the verification line reads, and the unit-level UNTESTED is calibrated to a composite never assembled: not FIT, not NOT FIT, not upgraded

### Trigger

Orchestrator work order: the §3.5 normative-change countersignature owed by
this seat at row 1 of `docs/adr/ADR-0022-the-warranty-and-the-split.md` §7.
Not a description confirmation — a countersignature of a normative change to
`docs/PROCESS.md`'s central warranty (its class 4, "what the artifact warrants
and to whom"). The question is §3.5's exactly: **is the guard exactly the rule,
or is it wider?** — asked of the constrained-seat's own artifact, with refusal a
first-class outcome. I am the verification line; the claim under signature is a
claim about what verification recognizes as true of an artifact it has read, so
it is squarely my seat's competence and not architect_docs_lead's to self-adjudge
(which is the procedural defect §2.3 bullet 4 and §7 exist to close).

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md` — both in full, both
  first, per my launcher's mandatory order. §3.5-relevant: PROTOCOL §10
  (independence and evidence), §7 (harvest attaches to `SO-`/gate, not this).
- `docs/adr/ADR-0022-the-warranty-and-the-split.md` — in full, all 274 lines,
  with attention as directed to §2 (Decision 1), §2.1 (the decision and its
  measured basis), §2.3 (the four failure-mode bullets and the UNTESTED
  statement), §2.4 (what it explicitly does not decide), and §7 (the table, the
  precedent note, and the difference-this-time paragraph). Read only; **not
  edited** — the acceptance act of §8 is the orchestrator's, citing this entry.
- `docs/PROCESS.md` opening block (lines 1–20) — read at the working tree, to
  check the re-scoped warranty **as it actually stands in the artifact**, not as
  the ADR paraphrases it. The claim sits where §2.1 says it does, in the opening
  paragraph a reader meets first: "one half of an export unit — the half that
  explains … Read on its own, this document is a description … The replication
  claim belongs to the unit, not to this half … the doc–shell drift check does
  not exist … the unit's two halves are bound by nothing but this sentence and
  the pin in §6.0."
- `docs/reports/process-council/round-4/verdict.md` — in full. It commissioned
  decision 2 and set the *condition* on decision 1 ("the re-scoping itself must
  be governed … a normative change to the artifact's central warranty"), and its
  First Principles Thinker made the exact calibration under signature here: "the
  unit verdict is UNTESTED, not FIT or NOT FIT." Its blind-spot section records
  that both executed runs ran where the shell was unreachable, so the with-shell
  path is untested.
- The two cold-adoption run records — the empirical basis I was told to verify
  rather than take from the work order:
  - `docs/reports/process-council/round-2/adoption-run-halt-log.md` — run 1, one
    file handed over (2,973 lines), no shell named. Summary: "roughly one
    hundred percent of the executable layer … is my invention." 18 halts, 3
    STOPPED (HALT-01 no shell, HALT-14 no ratifier, HALT-16 no work).
  - `docs/reports/process-council/round-3/adoption-run-2-halt-log.md` — run 2,
    fourth edition (5,044 lines), shell pinned and verified at ref level
    (`2ad82c3`, byte-identical to §6.0's pin), contents unreachable by the run
    charter. Summary: interfaces transferred as facsimiles (trailer keys, entry
    grammar, chain fields, scope-table semantics, rule numbering, both
    thresholds, large-file figure — none invented); HALT-02: "~850 lines across
    five enforcement scripts plus the hook remained pure invention." 17 halts,
    **0 STOPPED**.
- My own last entry, `J-dv_lead-0197`, for the id to increment and the
  harvest-span boundary.

**Not read**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`. No RTL reached
this round's context — this is a governance countersignature about what an
artifact warrants, judged from the artifact and its measured adoption record,
which is the §3.5 competence of the verification line and not a module verdict.

### Reasoning

**What the two halves of row 1 actually ask, and why they are separable.** Row 1
asks two things and I answer each on its own basis. (a) is the half-level
question: is the re-scoped warranty — *this document read alone is a description,
not a replication kit; replication belongs to the unit* — true of the artifact I
have read? (b) is the composite-level question: is §2.3's *unit-level UNTESTED*
neither too strong nor too weak? A guard can be exact at one level and wrong at
the other, so I refused to collapse them.

**(a) — the guard is exactly the rule, and the measurement is on record twice.**
The re-scoped warranty makes three moves and I checked each against the artifact
rather than the ADR's paraphrase. *Move 1*: "this half is the explaining half of
an export unit." A claim about what the document IS; read alone it is a
description, which both runs confirm operationally — an adopter executing §6.2
with only this text cannot rebuild the executable layer. TRUE. *Move 2*: "read
alone it is a description, not a replication kit." This is the load-bearing
disclaimer, and it is the exact object of measurement: run 1 invented "roughly
one hundred percent of the executable layer"; run 2, handed the same document
with the interfaces now printed as facsimiles, still wrote ~850 lines of
enforcement logic from nothing. Neither run replicated the machinery from the
document alone. The disclaimer is TRUE and is measured, not asserted. *Move 3*:
"the replication claim belongs to the unit, not to this half." This is where an
overclaim could hide, so I tested it hardest. Relocating the claim to "the unit"
could be read as implying the unit CAN replicate — which is UNTESTED and would be
a widening. It is not that: the same opening paragraph discloses that the binding
instrument (the doc–shell drift check) "does not exist" and that "the unit's two
halves are bound by nothing but this sentence and the pin," and §2.3/§2.4
explicitly withhold the unit-level claim. "Belongs to" names *where the claim
would have to be adjudicated*, not that it is proven. So the guard (what this
half warrants about itself) equals the rule (what is true of the artifact): it
warrants description and disclaims replication, both true, and it does not smuggle
in a unit-level warrant. It is also not NARROWER: §2.2 rejected "call it a memoir
with no export function" precisely because the interfaces DID transfer (run 2's
zero stops, every grammar/identifier/threshold/rule number a facsimile), so a
document that disclaimed its export function would underclaim in the other
direction. The chosen scope catches exactly what transferred and disclaims
exactly what did not. **Guard = rule. No widening, no narrowing.**

**A conflation I explicitly refused.** The round-4 verdict's finding 4 convicts a
*different* sentence — "extracted project-free," the shell's domain-agnosticism —
as materially false, a sixth-edition repair item. That is a claim about the
UNIT/shell's de-domaining, not the Decision-1 warranty about this half being the
explaining half. It does not touch row 1's object; if anything it reinforces that
the unit-level claim must stay uncertified, which §2.3 already does. I record
that I checked it and it does not move my verdict, so a later reader cannot think
I missed it.

**(b) — UNTESTED is calibrated to the composite, and the composite was never
assembled.** §2.3 names the unit as a four-part composite: document + shell + a
drift check that does not exist + a with-shell adoption path never executed. I
verified each: the document exists (read); the shell exists as a pinned ref (run
2, ref-level only — contents never read in either run); the drift check does not
exist (PROCESS.md opening `[B.2·9]`; round-4 "built in none" for three editions);
the with-shell path has never run (round-4 blind spot — both executed runs ran
where the shell was unreachable). So no composite-level integration was ever
measured in either direction.

*Too strong?* FIT would assert the unit works — unearned, nothing assembled it.
NOT FIT would assert it fails — also unearned, and actively contradicted by the
one positive datum we have (run 2's interfaces transferred), so a negative
verdict would over-claim a failure we never measured. UNTESTED sits between and
claims neither. Not too strong.

*Too weak?* A weaker calibration would let the re-scoping alone rescue the
replication claim — "provisionally fit," or the claim left standing unqualified.
§2.3 forecloses that in terms ("the honest verdict at the unit level is
UNTESTED, not FIT, and this record does not upgrade it") and §2.4 names the two
gates that would (the drift check built, and a with-shell alien-domain run by an
uncommissioned party). It also does not soften the known hazards: the with-shell
path forks at minute one with no tiebreaker (round-4), and §2.3's other bullets
disclose the sentence-only binding and the quiet-widen risk. UNTESTED-plus-
disclosed-hazards is the honest floor; it does not overstate assurance. Not too
weak.

*A distinction the calibration gets right.* The interface transfer measured in
run 2 is a *half-level* fidelity result — evidence about the document's export of
its own grammar — not a *unit-level* integration result. UNTESTED "at the unit
level" keeps those two objects apart, which is exactly the discipline that keeps
a true partial result from being read as a false whole. **Guard = rule here too:
UNTESTED neither convicts (NOT FIT) nor acquits (FIT/upgraded) a composite that
has no measurement.**

**Why I do not refuse.** I steelmanned three refusals and each fails. (1)
"Relocating to the unit overclaims replication" — no; the document withholds the
unit claim explicitly and discloses the missing binding instrument. (2) "UNTESTED
is too weak given the fork-at-minute-one defect" — no; a known hazard in an
unexecuted path is not a measurement of failure, and the hazard is disclosed
anyway. (3) "UNTESTED is too strong because part of the unit tested" — no;
interface transfer is half-level, the composite was never assembled. None holds,
so ACCEPT is the substantive verdict and not the agreeable one. My signature is
of a normative change, and it is affirmative because on this artifact the guard is
the rule at both levels.

### Actions

1. Read the charter and PROTOCOL in full, first, per the launcher order.
2. Read ADR-0022 in full; read `docs/PROCESS.md`'s opening block to confirm the
   re-scoped warranty as it actually stands in the artifact.
3. Verified the empirical basis independently: the round-4 verdict, and both
   cold-adoption halt logs, against the ADR's §2.1/§2.2 claims — the "~100%
   invented" (run 1) and "~850 lines from nothing after facsimiles" (run 2)
   figures reproduce verbatim in the source records, and run 2's zero-stop /
   interfaces-as-facsimiles result reproduces.
4. Answered §3.5 for both limbs of row 1: (a) guard-exactly-the-rule,
   (b) guard-exactly-the-rule (UNTESTED correctly calibrated). Verdict **ACCEPT**.
5. Appended this entry. **Did NOT** edit ADR-0022 (the §8 acceptance act is the
   orchestrator's), and did **not** run `git add`, `git commit`, `git push`, or
   `scripts/agent_commit.sh` — the orchestrator is the sole committer.

### Evidence

This is a countersignature entry; its "evidence" is the correspondence between
the claims under signature and the committed records, all readable from a
checkout at this SHA.

- Re-scoped warranty text, `docs/PROCESS.md` lines 9–20 — the claim sits in the
  opening paragraph as §2.1 states, and discloses the non-existent drift check
  and the sentence-only binding.
- Run-1 measurement: `docs/reports/process-council/round-2/adoption-run-halt-log.md`
  Summary — "roughly one hundred percent of the executable layer … is my
  invention"; 18 halts / 3 STOPPED.
- Run-2 measurement: `docs/reports/process-council/round-3/adoption-run-2-halt-log.md`
  HALT-02 and Summary — "~850 lines across five enforcement scripts plus the
  hook remained pure invention"; "STOPPED: 0"; interfaces "transferred this time
  as facsimiles"; shell pin verified at ref level `2ad82c3`, contents unreachable.
- Calibration precedent: `docs/reports/process-council/round-4/verdict.md` — "the
  unit verdict is UNTESTED, not FIT or NOT FIT"; the with-shell path untested
  (blind-spot section); the drift check "built in none" for three editions.
- Composite membership: ADR-0022 §2.3 (the four parts) and §2.4 (the two gates
  that would upgrade the verdict), consistent with all of the above.

**Not reproducible from this checkout**: nothing in this entry. Every figure is a
quotation from a committed record readable at this SHA.

### Outcome

**Verdict: ACCEPT** — ADR-0022 §7 row 1, both limbs.

- (a) The re-scoped warranty is one the verification line recognizes as TRUE of
  the artifact it has read. **§3.5 answer: guard exactly the rule** — it warrants
  description and disclaims replication (both measured), and does not widen into a
  unit-level warrant nor narrow into a no-export disclaimer.
- (b) The unit-level UNTESTED statement in §2.3 is neither too strong (not FIT,
  not NOT FIT) nor too weak (not upgraded; the two gates named). **§3.5 answer:
  guard exactly the rule** — UNTESTED is the honest verdict for a composite that
  was never assembled, and the calibration keeps the half-level facsimile evidence
  from being read as unit-level fitness.

**DoD vs the work order: met.** ADR read in full; the basis verified from the
records, not taken from the order; exactly one journal entry appended, id
`J-dv_lead-0198`, pure EOF append, journal-only; ADR-0022 not edited; no git run.

**Handoff**: this entry is the authority the orchestrator's §8 acceptance act
cites to flip row 1 to signed; the file edit to ADR-0022 §7 is the orchestrator's,
not mine. No `SO-`, `BUG-`, `RV-` or `WO-` is produced or owed by this round.

**Harvest**: none due, declared rather than omitted. PROTOCOL §7 and ADR-0018
attach the lessons harvest to every `SO-` and every phase gate; this is a
normative-change countersignature, neither. The span since my last harvest stays
open and continues to tile through this entry, so a skipped harvest would remain a
visible gap and this declaration is what keeps it one interval.

### Open-questions

1. **The unit-level replication claim remains UNTESTED and I have signed that it
   is** — my ACCEPT is not a certification of the unit, and must never be read as
   one. Its two gates are architect_docs_lead's and the program's to build/run:
   the doc–shell drift check (owed, three editions overdue) and a with-shell,
   alien-domain adoption run by an uncommissioned party. Until both exist, no
   seat — this signature included — may upgrade the unit verdict.
2. **No escalation.** No E2 (no scope, requirement, phase or role moves; ADR-0022
   status block says so), no E3 (no toolchain/licensing boundary moves), no E5
   (no lead dispute — my read confirms the ADR's own calibration rather than
   contesting it), no E6. No CRITICAL finding. Refusal was available under §3.5
   and is not taken, on the merits recorded above.

### Files-in-this-commit
- (none)

## [J-dv_lead-0199] 2026-08-22T05:52Z | task:WO-0085 | The cfg_ifg axis is ACCEPTED and the coverage debt is discharged in the suite rather than only in the plan — and the same review finds a fourth site of the struck claim that a site list enumerated on its figure could not reach, then rules the class-11 re-run a disposition check and IC-10 un-re-runnable because it never ran

### Trigger

Orchestrator spawn `WO-0085-REVIEW/2026-08-22T05:15Z`. `WO-0085` — my own packet,
drafted at `J-dv_lead-0197` — RETURNED by tb_writer at `J-tb_writer-0047`,
landing `a0cf4dd`. The review verdict is owed by the issuing lead. The dispatch
additionally asks for two named judgment calls to be ruled explicitly, for the
`dune` edit to be adjudicated for necessity and scope, for the byte-identity
claim to be established by measurement rather than by the worker's word, and for
the seal §10.6 re-run mechanics to be ruled from the campaign's sealing and
scoring seat.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3 packets and relay class,
  §4 journal grammar, §5 R1–R9, §6 write scopes, §7 Mutation record (b.1)–(b.4),
  §10 independence, evidence and R-SEAL-1).
- `agents/handoffs/WO-0085_tb-m04-cfg-ifg-gap-axis.md` in full, including the
  RETURNED log.
- The diff under review, read line by line:
  `git show a0cf4dd -- test/xgmii_tx_64/bench.ml test/xgmii_tx_64/bench.mli test/xgmii_tx_64/dune test/xgmii_tx_64/test_m04_f.ml`,
  plus `git show --stat a0cf4dd` and `git show --name-only --format="" a0cf4dd`.
- **Specification, as the sole basis for every expected value I checked**:
  `docs/specs/modules/xgmii_tx_64.md` §6.1 (the gap paragraph, the identity
  `g = ⌈(cfg_ifg + t)/8⌉` and gap `8g − t`, and the cycle-by-cycle table), §9
  (the abort word, its terminate character, and *"the gap is then served from
  that terminate character"*), §10.
- `test/attack_plans/AP-xgmii_tx_64.md`: rows `M04-F1`, `M04-F2`, `M04-F3`,
  `M04-F6`, `M04-F7` (row text as the contract), §1's status vocabulary, §5 item
  12's three rejections, §6.1's homing census and its command, §7 items `T-2`,
  `T-3`, `T-8`, §9's change log.
- Bench and instrument sources, all inside `test/**` and none of them RTL:
  `test/xgmii_tx_64/bench.ml`, `bench.mli`, `dune`, `test_m04_f.ml`,
  `test/xgmii/tx_decoder.mli` and `tx_decoder.ml` (the latter read to settle
  whether `ifg` can reach anything `wire_frames` returns).
- `agents/handoffs/WO-0084-SEALED-predictions.md` §6 (IC-10 worked in full), §10
  item 6, §11; `agents/handoffs/WO-0084_m04-mutation-campaign.md` Return log rows
  1, 3 and 4 (the operator's procedure, the step-6-not-job rule, the act-4 tally
  and the class-11 survivor evidence form).
- `.github/workflows/build.yml`, to establish what the cited CI run actually
  executed rather than assuming it.
- **RTL exposure, disclosed under charter §8.** I opened
  `docs/reports/audit/WO-0084-mutations/class-11-gap-ignores-ifg.diff` — an audit
  artifact, not RTL source, but one that quotes six context lines of
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`. **Why**: the dispatch requires me
  to name the predicted killing unit of that exact diff, which cannot be done
  without reading the rendering. **When**: after I had already re-derived every
  expected value in both new units from §6.1's identity and checked them against
  the code, so no test expectation in this round is contaminated by it. **No
  file under `libs/`, `top/`, `bin/` or `rtl_snapshots/` was opened**, and
  nothing I saw in that diff is used to justify any assertion, any row, or the
  ACCEPT.

### Reasoning

**Why ACCEPTED and not BOUNCED, when the return does carry a miss.** The four
deliverables are met against the row text, which is the contract, and the
arithmetic is right at all eight members by my own derivation before I read the
worker's table. The one substantive miss I found — a fourth site restating the
claim `WO-0084-S1` struck — sits **outside the deliverable as I wrote it**:
Deliverable 4 enumerated the sites *"that quote `16 is one octet from
conformant`"*, and the surviving banner paraphrases the claim without the figure.
A bounce would charge the worker for the scope of my own instruction. The
correct disposition is therefore ACCEPT, file the miss as my finding, and correct
it myself — the file is in my write scope, the correction is two lines of
comment, and a respawn would cost a round for text no assertion depends on. I
weighed the opposite risk, that a reviewer editing the reviewed artifact blurs
the review boundary, and answered it with disclosure rather than with
abstention: the correction is named in the verdict row, in the `M04-F6` row and
here, and it is in the same diff the auditor will read.

**Why the two judgment calls are upheld on different grounds than the worker
gave, and why that distinction is worth the words.** On `wire_frames`, the
worker's third argument — *every driven gap this round is ≥ 12* — is true and
**contingent**, and a ruling resting on it would have to be re-established by
every future round. The invariant ground is that `Tx_decoder`'s `ifg` feeds the
REQ-204 `violate` branch alone and `wire_frames` returns `frames` while reading
neither `report` nor `is_clean`, so **no value it yields can depend on `ifg`**
at any driven gap, conformant or not. That converts a per-round check into a
stated precondition, which I recorded at `T-8`: the hardcode goes live the moment
a consumer reads that instance's report. On the stall shape, the worker cited
rejection **(c)**, which rejects *widening `M04-F6`* and says nothing about
`M04-F7`'s stimulus. The reuse is right for reasons (c) does not supply: the row
names the same family-G stimulus; §9 fixes `t = 1` for **every** abort, so no
other stall shape reaches a terminate lane the identity does not already cover;
and holding the shape fixed makes `cfg_ifg` the sole varying quantity, which is
what makes a red attributable. Citing a rule that does not say what you need is
a defect even when the conclusion is right, because the next round inherits the
citation and not the reasoning.

**The `dune` edit is the case where the packet is not the only source of
obligation.** Nothing in Deliverables names `dune`. The file's own header rule
does — *"When a packet adds rows, add its line"* — written in with the incident
that taught it. A reviewer who marked the edit out-of-scope because the packet
did not name it would be teaching workers that a directory's standing rules
yield to a packet's silence. Scope is satisfied (`test/**`), risk is measured
(the hunk is comment lines; the `(library …)` stanza is byte-unchanged), so the
edit is necessary, in scope, and correct to have made.

**Why the byte-identity claim had to be re-established rather than accepted.**
The worker could not run `dune runtest` (opam blocked, ADR-0005) and said so
honestly; its substitute was parse-only checks plus hand-derivation. That is not
execution evidence, and a default path claimed byte-identical by the seat that
changed it is exactly the claim a review exists to test. I took three
independent measurements instead: no `[%expect]` line is removed or edited
anywhere in the diff; the other seven `test_m04_*.ml` files are untouched; and CI
at this SHA ran `dune runtest` **and** `git add -A && git diff --cached
--exit-code`, the second being the DoD's own check in a stronger form. Because
every unit here asserts by raising into an **empty** expect block, a perturbed
default has only two exits and both are green. That is as far as the claim goes,
and I wrote its limit into the verdict: **CI green is the first and only
execution evidence for these two units anywhere.**

**Why the §10.6 item is two obligations and not one, and why saying so is the
ruling.** Seal §10.6 item 6 reads *"the day M04-F3 lands, IC-10 must be re-run,
not re-quoted"*. It was written before act 3, when the seal still expected IC-10
to be rendered. It was not: the act-4 tally puts IC-10 in `sealed` and not in
`seeded`, and PROTOCOL §7 (b.1) says such a class *"is not a seeded mutation the
suite failed to kill but a mutation that does not exist"*. **You cannot re-run
what never ran**, and the honest ruling is to say that rather than to dress a
first measurement in the word "re-run". What *is* redeemable, and is owed before
`P1-module-ready`, is `class-11`: it ran, it survived, its disposition under §7
(b.2) has exactly one evidence form, and the axis that was the sole cause of its
survival has now landed. So the item discharges as one mandatory disposition
check plus one optional first measurement, and I separated them in the verdict so
that a later reader cannot satisfy the first by gesturing at the second.

**Why I decline to render IC-10 myself, including in the softened form the
dispatch offered.** A mutant chosen by the seat that commissioned the bench tests
only whether my bench catches the defect my own hand wrote. The parent campaign's
own title is *defects that do not know the predictions*; substituting a
dv-authored rendering would convert an independent measurement into a self-test
and put verification in the position of grading itself, which PROTOCOL §1 exists
to prevent. The auditor is the only seat that may author a manifest (PROTOCOL
§10) and the only seat that may stage `docs/reports/audit/**` (§6), so the
question of *who renders* has one answer and it is not me. I also fixed where it
may **not** go: a new directory under its own WO, never an addition to
`WO-0084-mutations/`, because a closed campaign's manifest set is part of a
frozen measurement and growing it later would let the campaign's denominator move
after its score was published.

**Why this is a qualification check and not a new sealed campaign.** I concur
with the framing and did not take it on faith: R-SEAL-1 attaches to a claim that
a result exists and is withheld, and I withhold nothing — the predicted
disposition, its mechanism and its killing unit are written out in the open,
before any run. A prediction published is not a seal. And the (b.2) form is a
disposition check against a frozen measurement, not a re-measurement of it, so
`WO-0084`'s tally is untouched and the new result is recorded beside it.

**What I deliberately did not do.** No Status cell moved: this plan records a
discharge in its change log and its Status cells carry the six values §1 fixes
and no annotation — minting a discharge marker now, in the notation §6.1's census
selects, is precisely what `FINDING AP-6-2` forbids. No `SO-` is opened or
offered; the module's mutation-disposition limb is unrun and my charter's own
review-time spot-check is not executable in this container, which I wrote into
the verdict rather than leaving as an implied strength. `BAR T1` stays shut and
REQ-206's coverage claims stand where they were — I looked for a reason to move
them and found none: `M04-F7` reaches one point of §9's stream-effect cell and no
other REQ-206 obligation.

### Actions

1. Precheck: `git status --short` (empty) and `git rev-parse HEAD` (`a0cf4dd…`)
   in one invocation, as dispatched.
2. Read the packet in full, then the four-file diff line by line; re-derived
   every gap, start-cycle and run-length figure at all eight sweep members from
   SPEC-M04 §6.1's identity and checked them against the code and against the
   landed `M04-F2` / `M04-F6` figures at the `cfg_ifg = 12` control members.
3. Settled the `wire_frames` question by reading `test/xgmii/tx_decoder.ml`'s
   REQ-204 arm and confirming `ifg` reaches only `violate`.
4. Verified both CI run ids against the run records (not against the dispatch's
   word) and read `.github/workflows/build.yml` to establish what the green
   actually covers.
5. Found the fourth `M04-F6` site by a multiline search (`one\s+octet`), which a
   single-line grep misses because the phrase wraps — filed
   `FINDING WO-0085-R1` and corrected
   `test/xgmii_tx_64/test_m04_f.ml:392–393`.
6. Wrote the ACCEPTED verdict as a new row in the packet's Return / verdict log
   and flipped the packet's State header to `ACCEPTED` with this entry's id, per
   the convention `WO-0082` and `WO-0083` set.
7. Attack-plan bookkeeping: `M04-F6`'s Kills cell records the second site closed
   and the fourth site found; §7 `T-8`'s DOES-NOT-EXIST measurement is marked
   **now false**, dated, kept rather than overwritten, re-measured at the
   producer, and extended with the two limits of the discharge; §6.1's census
   re-run and quoted at its new date; a new §9 change-log row absorbs the round.
8. Re-ran both of the plan's own censuses **after** every edit, to confirm my
   annotations did not join the notation they are measured by.

### Evidence

Commands are runnable from a checkout at this commit; run ids are externally
verifiable (ADR-0003/F5). **No ephemeral artifact is cited.**

- Precheck: `git status --short` → empty; `git rev-parse HEAD` →
  `a0cf4ddd258123d6e382a72efd8d80a7c10100db`.
- **No `[%expect]` block is removed or edited by the round under review**:
  `git show a0cf4dd -- test/ | grep '^-' | grep -i expect` → **no output**.
- **The commit's changed paths** (`git show --name-only --format="" a0cf4dd`):
  `agents/handoffs/WO-0085_tb-m04-cfg-ifg-gap-axis.md`,
  `agents/journals/workers/claude_tb_writer_agent.v03.md`,
  `test/xgmii_tx_64/bench.ml`, `test/xgmii_tx_64/bench.mli`,
  `test/xgmii_tx_64/dune`, `test/xgmii_tx_64/test_m04_f.ml` — the other seven
  `test_m04_*.ml` files are absent from that list, which is the regression
  witness the `dune` header claims.
- **CI at the reviewed SHA**, both re-verified at review from the run records:
  build run **32553311119** — `conclusion: success`, `head_sha
  a0cf4ddd258123d6e382a72efd8d80a7c10100db`,
  `https://github.com/renatom11/agentic-fpga/actions/runs/32553311119`;
  journal-check run **32553311111** — `conclusion: success`, same head SHA,
  `https://github.com/renatom11/agentic-fpga/actions/runs/32553311111`. Per
  `.github/workflows/build.yml`, the green `build` job includes
  `opam exec -- dune runtest` (step *Run tests*) and
  `git add -A && git diff --cached --exit-code` (step *Verify nothing was left
  unpromoted or non-deterministic*).
- **The identity, checked per member** (SPEC-M04 §6.1, `g = ⌈(cfg_ifg + t)/8⌉`,
  gap `8g − t`): `M04-F3`, `t = 0` — `cfg_ifg` 12/13/16/20/255 → `g`
  2/2/2/3/32 → gap **16/16/16/24/256**, next start at `C + 10 + g` =
  **C+12/C+12/C+12/C+13/C+42**. `M04-F7`, `t = 1` — `cfg_ifg` 12/16/24 → `g`
  2/3/4 → gap **15/23/31**, next start at `A + g` with `A = C+6`. The `12`
  members reproduce `M04-F2`'s landed `p1 = 60` row (gap 16, `C+12`) and
  `M04-F6`'s landed figures (gap 15, `C+8`) exactly.
- **Run-length bounds re-derived** with `g_max ~ifg = (ifg + 14)/8`:
  `cycles_for_run` → 51/51/51/53/111; `cycles_for_scheduled_run` at the round's
  stall → 47/47/49. Each is an upper bound with tens of cycles of slack, and each
  collapses at `ifg = 12` onto the pre-round `+4` / `max 3 hold` arithmetic.
- **The plan's own censuses, re-run at this tree after my edits** (§0.1(i):
  measured, never carried forward):
  - status-cell pass over every row table → **83 row lines, 83 distinct ids;
    ASSERT 59, NO-ASSERT 12, NO-STIMULUS 6, STRUCTURAL 5, GAP 1, RULING 0** —
    unchanged, this round adding, converting and striking no row.
  - §6.1's quoted homing command → **`83 83 []`**.
  - Discharged **39 → 41** by the four prior absorption rows' own declared counts
    (13 + 12 + 6 + 8 = 39) plus this round's 2; outstanding **44 of 83 → 42 of
    83**.
- **The fourth `M04-F6` site**, found and corrected:
  `test/xgmii_tx_64/test_m04_f.ml:392–393` read *"The gap after an abort: 15
  octets from the /T/ in lane 1 — the one octet that separates conformant from
  not."* A single-line `grep -rn "one octet" test/` returns **no hit in
  `test/xgmii_tx_64/`** because the phrase wraps; the multiline search
  `rg -U "one\s+octet"` finds it. That is why the site list built from the
  string missed it and why the tool that found it is named here.
- **`wire_frames`' hardcode is inert by construction**: `grep -n ifg
  test/xgmii/tx_decoder.ml` → `ifg` occurs at the record field, at `create`, and
  at lines 136–146 only, which are the REQ-204 `violate` branch; `wire_frames`
  (`test/xgmii_tx_64/bench.ml:478–482`) returns `Tx_decoder.frames d` and reads
  neither `report` nor `is_clean`.
- **Predicted disposition of the owed `class-11` re-run** (published here before
  the run, withholding nothing — R-SEAL-1 does not attach): **KILL**, first at
  `M04-F3` unit `U28` member `cfg_ifg = 20`, raising at
  `assert_instruments_clean_n` through the standing decoder's REQ-204 arm
  (recorded 16 against `~ifg:20`) and independently at that member's exact
  `= 24`; `M04-F7` unit `U29` predicted to redden at `cfg_ifg = 16` (15 against
  23). Procedure, seats and the not-closed criterion are in the verdict row,
  item 9.

### Outcome

**DoD vs the work order: MET.** `M04-F3` and `M04-F7` are asserted and green
under CI's `dune runtest`; the unpromoted/non-deterministic check is clean at the
same SHA; the `cfg_ifg = 12` path is unperturbed for every pre-existing unit by
three independent measurements; the `M04-F6` message is corrected; the worker
journal entry is appended with the spawn short-id; no doc impact beyond
`test/**`. **Verdict: ACCEPTED**, shipped as a row in the packet's own Return /
verdict log with the State header flipped (`RV-0085-VERDICT`), per the convention
`WO-0082` and `WO-0083` set — the verdict is a committed artifact, not a chat
message.

**Owed and named, not closed here**: (1) the `class-11` re-run, the orchestrator's
to operate, mandatory before `P1-module-ready` under PROTOCOL §7 (b.2); (2) my
charter's review-time hand-mutation spot-check, which that re-run discharges and
which no seat can execute in this container; (3) IC-10's first rendering, the
auditor's if it is taken at all, optional because an unrendered class supports no
claim in either direction. **No `SO-xgmii_tx_64.md` is opened or offered; `BAR
T1` stays SHUT; REQ-206's coverage claims are unchanged; no `BUG-` is opened** —
nothing in this round is a divergence of design from spec.

**Harvest**: **none due, declared rather than omitted.** PROTOCOL §7 and
ADR-0018 attach the harvest to every `SO-` and every phase gate; this is a
worker-return review, neither, so the span since my last harvest stays open and
continues to tile through this entry. **One candidate is banked for it**, with
its three admissibility limbs already met so the next harvest need not
reconstruct them: *when a false claim is struck from a document, enumerate the
sites to correct by the claim, not by the string that expressed it* — **LH1**
this commit and `a0cf4dd`; **LH2-g**, no proper noun of any kind in the rule;
**LH3** without it the corrected document keeps teaching the struck claim
wherever it was paraphrased, and a search built from the struck string cannot
find those sites by construction.

### Open-questions

1. **The `class-11` re-run is owed and is not mine to run.** The orchestrator is
   the operator seat (ADR-0019, PROTOCOL §10). If it comes back **step-6
   SUCCESS**, that is a CRITICAL finding against this ACCEPT and against me and
   the round reopens — the criterion and its three near-miss shapes are item
   9(iii) of the verdict row.
2. **IC-10's first rendering needs an auditor spawn, or an explicit decision not
   to take it.** I have ruled it optional at `P1-module-ready` and ruled out
   authoring it myself. The orchestrator decides whether to commission it; if it
   does, I will draft the WO to the auditor rather than the manifest.
3. **`WO-0084-S3` remains routed to the auditor and unanswered here** — class-03
   is a non-compiling manifest and IC-2 is untested. Unchanged by this round,
   restated so it is not read as closed by the S2 close.
4. **No escalation.** No E1 (I supply evidence, I request no approval), no E2
   (no scope, requirement or row moves), no E3, no E5 (no lead dispute — the two
   rulings are mine to make as the packet's issuing and the campaign's scoring
   seat), no E6.

### Files-in-this-commit
- agents/handoffs/WO-0085_tb-m04-cfg-ifg-gap-axis.md
- test/attack_plans/AP-xgmii_tx_64.md
- test/xgmii_tx_64/test_m04_f.ml

## [J-dv_lead-0200] 2026-08-22T06:02Z | task:WO-0083 | The stage-2 revision I owed myself is executed: eleven items dispositioned by letter — nine DONE, one blocked on a spec diff that is not mine to write, one law form overtaken into liveness by the axis that landed since — and the sweep that closes it finds six more sites of a struck claim in my own packet, one of which was leaving a disposition weaker than the truth

### Trigger

Orchestrator spawn `WO-0083-STAGE2-REV/2026-08-22T06:05Z` (copied verbatim; my
`date -u` stamp reads 06:02Z, three minutes before the token the dispatch minted
— I record the skew rather than adjusting either figure, the stamp being my
clock's reading and the short-id being the orchestrator's own token).

The round is **my own owed work**, not a review of anyone else's:
`RV-0083-VERDICT` §6 closed with *"Routed to tb_writer: nothing. Routed to my own
next revision: eleven items, enumerated at §5."* The board has carried it as the
engineering queue's next item since `J-orchestrator-0285`, and `J-dv_lead-0197`
declined to fold it into the `WO-0085` carrier precisely so it would stay
countable as its own round. `WO-0085` closed ACCEPTED this morning; this is the
queue head.

Precheck, one invocation as dispatched: `git status --short` → empty;
`git rev-parse HEAD` → `6f165bd323309cbb29a4097dd10da16e06914987`, matching the
dispatch's stated prefix `6f165bd` **within git's own default abbreviation
length** — which is the rule this very round codifies at §20 item 3 (item (j)),
and the first time it has been applied to a dispatch to me rather than by a
worker to mine.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md` — both in full, first,
  per my launcher. §3 (packet classes and the participant-updates-its-own-packet
  rule), §4 (entry grammar, `Files-in-this-commit` set-equality), §5 (R1–R9,
  and R3's pure-EOF-append), §6 (write scopes), §7 (Mutation record, lessons
  harvest), §10 (independence, evidence, R-SEAL-1).
- **The owed list, read from the record and not from memory** —
  `agents/handoffs/WO-0083_tb-m04-stage-2-stall-schedule-and-family-g.md`, the
  `RV-0083-VERDICT` §5 block in full, which is where the eleven live as items
  **(a)–(k)**; plus §6's closing count that says there are eleven.
- My own journal, `agents/journals/claude_dv_lead_agent.v12.md`:
  `J-dv_lead-0194` (the `RV-0083` ACCEPT that routed them), `J-dv_lead-0195`,
  `J-dv_lead-0196` (the act-4 scoring that struck `M04-F6`'s figure),
  `J-dv_lead-0197` (the S1/S2 closes and the carrier decision that kept this
  round separate), `J-dv_lead-0199` (the `WO-0085` ACCEPT, `FINDING WO-0085-R1`,
  and the banked site rule this round applies).
- **`J-architect_docs_lead-0055`** (in `claude_architect_docs_lead_agent.v05.md`,
  landed `8ceb973`) — the independent §4 read in full, because six of the eleven
  are its items and **the verdict's one-line summaries are not their grounds**.
  Reading the source is what produced the boundary-case reasoning at item (a),
  the two-branch C-16 reading at item (d) and the *"editorial: the closed
  interval is half-open in its own brackets"* correction at item (f) — none of
  which survives in the one-line form.
- **Specification, as the only basis for every clause this revision now cites**:
  `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04) §6.1's storage sentence and
  inter-frame-gap paragraph, §6.2's `Preamble`/`Frame`/`Idle` rows, §7's C-14.1
  bullet and C-16's four consequences read individually, §7's handshake and reset
  bullets, §9's stream-effect row, §11's deferred-item table and **§13's change
  log in full** (to establish, rather than assume, that item (g)'s defect is
  still unfixed).
- `test/attack_plans/AP-xgmii_tx_64.md` — §0.1's three standing rules, §6.1's
  homing census and its quoted command, §7 items `T-2`, `T-3`, `T-8`, §9's change
  log in full.
- `agents/handoffs/WO-0082_tb-m04-two-frame-presenter-and-g10.md` — its head
  block only, for the **revision form**: the register table, the strike-in-place
  discipline, and the sentence that a revision alters no term the executed round
  was judged under.
- `tools/dv_checks.sh` (the docs-citation check's extraction function) and
  `.github/workflows/build.yml`, read to establish what CI will actually do with
  the two files I touched rather than to assume it does nothing.
- **NOT read**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`. No RTL was
  opened at this or any commit for this work, and nothing in this round needed
  any: every correction is a document's own text against a specification clause.

### Reasoning

**Why the items are dispositioned by their §5 letters and reproduced in the
packet.** The verdict enumerated them (a)–(k); a revision that silently applies
"most of them" is unfalsifiable. §21 reproduces the eleven **by letter with the
verdict's own wording**, so a reader diffs two lists instead of trusting a
summary, and each carries **disposition + site + ground**. I fixed the
disposition vocabulary before writing the list — **DONE**, **OVERTAKEN** (with
the citation, per the dispatch), **BLOCKED** (with reason and carrier) — and
deliberately did not mint a *DEFERRED*: an item put off without a carrier is the
exact failure `J-dv_lead-0187` convicted my seat for, three debts carried across
rounds because their permissions never reached their artifacts. Here the
permissions reach: `agents/handoffs/**` and `test/**` are mine.

**The one item I cannot discharge, and why it is BLOCKED rather than carried.**
Item (g) is my countersignature on SPEC-M04 §6.2's `Preamble` row — *"keeps
`tx_tready` = 1"*, unconditionally — against §7's C-16 consequence 4, which says
it is **0** on the preamble cycle of a back-to-back frame whose word 0 was
accepted at the post-`tlast` cycle. I **re-measured the defect at this head
rather than assuming it survived**: the row is still at
`docs/specs/modules/xgmii_tx_64.md:300`, consequence 4 is unchanged, and §13's
change log carries **no row** for it. So there is no diff to countersign, and a
countersignature is an act on a diff. `docs/**` is architect_docs_lead's scope
(PROTOCOL §6), so I could not write it even if I judged the shape — and the shape
is genuinely open: the architect's own Open-question 1 asks whether the repair is
the narrow C-14.2-style exception or the wider question of whether §6.2's rows
should carry `tx_tready` values at all now that §7 pins them in four places. **A
value stated twice is a value that can disagree with itself, and this is the
second time it has.** What I can do is make the debt legible with its carrier,
which §21.2 does.

**Item (a) is the one whose interaction with (g) had to be worked out rather than
noticed.** The citation upgrade routes fact 1 and §4.4 onto three grounds, and
**one of them is the very `Preamble` row item (g) says is defective**. That looks
circular until the frames are separated: C-16 consequence 4's qualification bites
only at a **back-to-back** frame whose word 0 was accepted at the post-`tlast`
cycle, and `M04-G5` — the row the upgrade exists for — withholds word 1 of the
run's **first** frame, where no such acceptance has happened. Grounds 1 (§6.1's
storage sentence, which carries no after-the-start-character qualifier at all)
and 3 (C-16 consequence 1's **uniqueness** claim, false if the preamble cycle
were a second *"means nothing at all"* cycle) are independent of the frame
either way. So the upgrade **survives the spec diff whenever it lands**, and I
wrote that sentence into the packet so the next seat re-reads it instead of
re-deriving it. The upgrade matters because REQ-206's opening clause is
**ambiguous at exactly the cycle the row lives on** — the start character is
emitted *on* `C + 1`, and *"after … has emitted"* does not say whether the
emitting cycle is inside — and a row resting on the weakest of three clauses
makes `U22`'s red **arguable rather than dispositive**.

**Item (b) is where the dispatch's overtaken-rule bit, and it bit in the
strengthening direction.** The item asks for the **law** with the value as its
instance. When it was written that was prophylactic: §6.0(g) pinned `cfg_ifg = 12`
for every unit and no producer could drive anything else (`T-8`'s
DOES-NOT-EXIST measurement). **`WO-0085` has since landed the axis** — the `?ifg`
knob at `a0cf4dd`, `M04-F7` sweeping {12, 16, 24} at this exact abort shape and
measuring 15, 23, 31 by this very law. So the item is not overtaken *away*; the
**ground under it changed from prospective to live**, and the value-only form
would have been falsified by the first member past 12. I dispositioned it DONE
with the citation attached, and marked two neighbouring passages **OVERTAKEN** in
place for the same reason: §5.3(3)'s *"a round that changes `cfg_ifg` … is stage
3 and this sentence is its warning"* (that round was `WO-0085`, not stage 3, and
the warning was **redeemed** — `g_max ~ifg` collapses onto this section's `+ 4`
arithmetic at 12, which is the check a generalisation owes its own special case),
and §5.4's *"no `cfg_ifg` parameterisation"* (overtaken in its `cfg_ifg` half
only; `cfg_tx_enable` is still unbuilt and family K is still its consumer).
**`BM5` I deliberately did not touch**: a bounce condition binds the round it was
written for, and re-reading it against later events is reading a rule backwards.

**Item (f) is a decision to keep, and the reason belongs on the record more than
the decision does.** The architect confirmed fact 8 as a rule and disputed its
ground **in the safe direction**: *"unconstrained"* understates the
specification, because REQ-204's 12-octet minimum plus §6.2's `Idle`→`Preamble`
entry pin non-acceptance shut at `R`, `R + 1` and `A`. I decline the
strengthening, and the ground is arithmetic rather than caution: **the observable
that would catch an early acceptance is the start character at `A + 2`, which
fact 7(a) already asserts** — so the stronger reading buys **no new observable**
and costs one more sentence to defend at every later round. A `NO-ASSERT` that
costs this round nothing is cheaper than a pin I would have to defend forever.

**Item (k) is recorded and not implemented, and I refuse to blur that.** `ST-2`
compares the bench's intention record against `offered.tvalid`, and both are
computed **from the same expression in the same branch** of the driver — so it
**cannot fire against that driver**. It is a regression tripwire; the defect its
own text claims to catch (*"a driver that quietly failed to withhold"*) is
exactly the one a self-comparison cannot see, because the failure moves both
sides together. The stronger form is **count-and-position**: the number of
withheld cycles equals `hold`, and the first of them is the cycle the cursor
reached the target — both terms from the schedule, both read from the drive
record, moved **independently** by a driver defect. **Implementing it edits
`test/xgmii_tx_64/bench.ml`, which is a commissioned round with a CI-executed
result; a packet revision can record a design item and must not pretend to land
one.** I homed it in two places for one reason: the packet is what a stage-3
drafter inherits text from, and `AP-M04` §7 `T-3` is where a seat looks for the
machinery's state — and `T-3` is marked **DISCHARGED**, so a limit recorded only
in a superseded packet would be invisible at the place the discharge is read.
**The discharge is not withdrawn and no state cell moves**; what moves is that
the limit is now written where it will be met.

**Why I swept for the struck claim at all, and why the sweep is not scope
creep.** `J-dv_lead-0199` banked a candidate rule with its three limbs already
met: *when a false claim is struck from a document, enumerate the sites to
correct by the claim, not by the string that expressed it.* This round opens the
one document in the chain that stage 3 inherits its text from, and I had just
finished writing that a fourth site was missed because a site list was built from
a figure. **Not sweeping here would have been the same failure with a better
excuse** — and the sweep is cheap, one multiline search plus a read of every
`M04-F6` mention. It found **six** sites in `WO-0083` and a **seventh** in
`AP-M04`'s own change-log row for the `WO-0083` absorption. **Only three of the
seven quote the figure `16`**, so four were unreachable by either earlier sweep
by construction.

**Two of the seven are worth the words they cost.** Trap `T13` reads *"Measuring
from the `/E/` gives 16 instead of 15"* — and that is **true of a bench** and
false of a design: a bench that measured from the `/E/` really would be one octet
out, which is what a trap is for, while a **design** that does so is recorded by
the decoder at `8g − 1` and is byte-identical at `cfg_ifg = 12`. **A false claim
and a true one were sharing a sentence, which is how it survived three sweeps**,
and the correction keeps the trap and strikes only the design-side half. §15's
class-`D2` disposition is the other: it read *"a `M04-F6` failure at 16 instead
of 15 is as likely to be the decoder as the design"*, and the strike makes it
**stronger, not weaker** — a reading of 16 cannot come from the design at all,
because every gap this decoder can record after an abort is `≡ 7 (mod 8)`, so it
convicts the **instrument or the bench and never rtl_lead**, and the readings a
design defect can produce here are **7** and **23**. That is a second reason to
sweep by claim rather than by string: **a struck claim can leave a judgement
weaker than the truth, not only wronger than it.**

**Why the plan's change-log row is struck in place and not rewritten.** The row
at `AP-M04` §9 is a **dated record of what the `WO-0083` round claimed**;
rewriting it would falsify the history the table exists to keep. Striking marks
the claim false and leaves the record readable — the same discipline
`J-dv_lead-0197` used on `M04-F6`'s Kills cell and `J-dv_lead-0199` used on
`T-8`'s DOES-NOT-EXIST measurement (*kept rather than overwritten*). **What I did
not do** is move a Status cell or mint a discharge marker: this round discharges
no row, and annotating in the notation §6.1's census selects is what
`FINDING AP-6-2` forbids. Both censuses were re-run **after** every edit and are
unchanged, which is the check that my annotations did not join the notation they
are measured by.

**What I rejected.** Folding the revision into a new work order (the items are
defects in **this** packet's text, and `WO-0082` Revision B already ruled that a
correction filed only into an unwritten successor is a promise, not a repair).
Editing `RV-0083-VERDICT`'s own text to mark the items done (a verdict is a
frozen record; the register and §21 carry the movement). Implementing the
stronger `ST-2` (a bench edit needs a CI-executed result and a commissioning
round). Writing the SPEC-M04 §6.2 repair myself (not my scope, and the repair's
shape is an open architect question). Re-running or re-reading `M-21` against its
new phrasing (that would read a rule backwards onto work that could not have
known it). Touching `WO-0084`'s tally, the seal, or `docs/reports/audit/**`.
Opening any RTL.

### Actions

1. Precheck in one invocation (`git status --short` empty; `git rev-parse HEAD`
   `6f165bd…`), then charter and PROTOCOL in full.
2. Located the owed list **in the record**: `RV-0083-VERDICT` §5 items (a)–(k),
   cross-checked against §6's *"eleven items"* count and against
   `J-dv_lead-0194`'s Handoff line.
3. Read `J-architect_docs_lead-0055` in full for the six architect items' actual
   grounds, and SPEC-M04 §6.1/§6.2/§7/§9/§11/§13 for every clause the revision
   now cites.
4. Re-measured item (g)'s defect at this head (row present, consequence 4
   unchanged, no §13 row) before dispositioning it BLOCKED.
5. Wrote **Revision B** into `WO-0083`: the amended `State` bullet, the
   **revision register** with its A/B rows and the strike-in-place discipline,
   §4.2 facts 1/5/7/8, §4.3's two additions, §4.4's broader ground, §5.3(2') and
   §5.3(5)'s `ST-2` note, §5.3(3) and §5.4's overtaken annotations, §12's `M-21`,
   §17's preamble and §17.1's new governing clause plus explicit attachments at
   items 4 and 5, §20 item 3's head-SHA rules, the section-map row and
   changed-passage list, and the new **§21** carrying all eleven dispositions,
   the debts with their carriers, and the site register.
6. Swept for the struck claim **by the claim** (`rg -U "one\s+octet"` plus a read
   of every `M04-F6` mention in the packet), found six sites in `WO-0083` and one
   in `AP-M04`, and corrected all seven in place, struck rather than overwritten.
7. `AP-M04`: extended §7 `T-3`'s cell with item (k)'s limit (discharge **not**
   withdrawn, state cell **not** moved); struck the change-log row's *"one
   octet"* clause in place; appended §9's change-log row for this round.
8. Re-ran both of the plan's censuses after every edit; replicated CI's
   docs-citation extraction over the packet to confirm no new phantom path.

**Not done, deliberately**: no `git commit`, no `git push`, no staging
(PROTOCOL §2). No file under `libs/`, `top/`, `bin/`, `rtl_snapshots/`,
`docs/**` or `docs/reports/audit/**` touched. No `.ml`/`.mli` file touched, so
no assertion, expected value or landed unit moves. No `SO-` opened or offered.
No `BUG-` opened — nothing here is a divergence of design from spec. No Status
cell moved, no row added, converted or discharged.

### Evidence

Commands runnable from a checkout at this commit; no ephemeral artefact is cited
(ADR-0003/F5).

- Precheck: `git status --short` → empty; `git rev-parse HEAD` →
  `6f165bd323309cbb29a4097dd10da16e06914987`. Authoring stamp: `date -u` →
  `Sat Aug 22 06:02:31 UTC 2026`.
- **The tree this round changes**, `git status --short`:
  `M agents/handoffs/WO-0083_tb-m04-stage-2-stall-schedule-and-family-g.md`,
  `M test/attack_plans/AP-xgmii_tx_64.md` — **two paths, both in my scope**.
  `git diff --numstat` → `544 27` and `3 2`.
- **No OCaml file is touched**: `git diff --name-only | grep -cE '\.mli?$'` →
  **0**. This is the measurement behind the claim that no landed assertion moves.
- **Nothing is deleted, only struck**: every one of the 27 removed lines is
  re-emitted inside the new text. Checked by extracting the removed lines and
  searching the new file for each, whitespace-normalised — all seven that a
  line-wise search reported as missing are line-rewraps, and each was then found
  verbatim (`No prior revision, no bounce…`, `the one octet that separates
  conformant from not`, `g = ⌈(12 + 1)/8⌉ = ⌈13/8⌉ = 2` …, `§7's handshake
  bullet holds the source's word stable until acceptance`, `**P' = P_j − 8w
  octets**`, `15 is asserted, not >= 12`, `Measuring from the /E/ gives 16
  instead of 15`).
- **The plan's two censuses, re-run at this tree AFTER every edit** (§0.1(i):
  measured, never carried forward):
  - §6.1's own quoted command → **`83 83 []`**, unchanged.
  - status-cell pass over every row table → **83 row lines, 83 distinct ids;
    ASSERT 59, NO-ASSERT 12, NO-STIMULUS 6, STRUCTURAL 5, GAP 1, RULING 0** —
    unchanged. Discharged stays **41 of 83**, outstanding **42 of 83**.
  - `## 9. Change log` now carries **9 dated rows**, the last this round's.
- **Item (g)'s defect re-measured, not assumed**:
  `grep -n "keeps \`tx_tready\` = 1" docs/specs/modules/xgmii_tx_64.md` → **300**
  (§6.2's `Preamble` row); §7's C-16 consequence 4 still reads *"`tx_tready` is 0
  on the preamble cycle C+12"*; SPEC-M04 §13's change log has **no row** for the
  contradiction. **No diff exists to countersign.**
- **The six sites in the packet**, found by the claim: §1's REQ-id line, §2's
  `M04-F6` index row, §4.2 fact 5's citation of the struck cell, §6.6's `U26`
  assertion 3, §14's trap `T13`, §15's class-`D2` disposition. **Three quote the
  figure `16`** (`U26`, `T13`, class `D2`); three do not, and a sweep built from
  the string could not have reached them. The seventh site is `AP-M04` §9's
  `WO-0083` absorption row.
- **What CI will do with these two files, established by reading rather than
  assumed**: `.github/workflows/build.yml`'s `build` job runs
  `tools/dv_checks.sh`, whose docs-citation check reads **`agents/handoffs/**.md`
  only** and requires every `docs/…` token to resolve. Replicating its extraction
  (`docs/[A-Za-z0-9_./*-]+`, trailing punctuation stripped) over the revised
  packet yields exactly four tokens — `docs/`, `docs/specs/ifc_check/xgmii_tx_64_ifc.ml`,
  `docs/specs/modules/xgmii_tx_64.md`, `docs/specs/requirements.md` — **all
  resolving in `git ls-files`**; the `:300` line suffix is not captured because
  `:` is outside the token class. `dv_checks.sh`'s census check targets
  `test/attack_plans/AP-xgmii_rx_64.md` (the **rx** plan), and
  `tools/precompile_check.sh` skips `attack_plans/` by name, so neither reads
  what I edited.
- **`dune runtest` was NOT run and could not be** — opam is proxy-blocked in this
  container (ADR-0005's documented posture). **It is also not the instrument this
  round needs**: no compiled file is touched. The executable claim this round
  makes is that **CI is unchanged by it**.
- Journal arithmetic (ADR-0017 §5.1): volume 12 stands at **124,181** bytes
  before this entry, leaving **137,963** under the 262,144 soft threshold. **No
  rotation is due**, and no chain header is touched.

### Outcome

**DoD vs the dispatch: met.** The eleven items are enumerated by their §5 letters
and dispositioned — **nine DONE** ((a), (b), (c), (d), (e), (h), (i), (j), and
(f) as a recorded ruling; (k) DONE as a recorded design item and explicitly **not
implemented**), **one BLOCKED with its reason and carrier** ((g), the spec-diff
countersignature), and **one carrying an OVERTAKEN citation inside its DONE**
((b), whose law form the `WO-0085` axis moved from prospective to live). Two
neighbouring passages are marked OVERTAKEN in place with the same citation
(§5.3(3), §5.4's first bullet). **The eleven are all accounted for and none is
silently skipped.**

**Finding filed**: **`FINDING WO-0083-R2-1` (MINOR, mine)** — `WO-0083` carried
**six** live restatements of the claim `WO-0084-S1` struck, and `AP-M04`'s own
change-log row a seventh; **four of the seven are unreachable by any sweep keyed
on the figure `16`**, and one of them (§15's class-`D2` disposition) had left a
routing judgement **weaker than the truth**. All seven are corrected in place.
The finding is against my own artifacts and is the direct yield of the rule
`J-dv_lead-0199` banked.

**Handoff**: `WO-0083` at **Revision B**, `AP-M04` absorbing it, both to the
orchestrator for commit under my seat. **Nothing is routed to any worker**, no
`RV-` is owed, and no spawn is requested by this round.

**Harvest**: **none due, declared rather than omitted.** PROTOCOL §7 and ADR-0018
attach the harvest to every `SO-` and every phase gate; this is neither, so the
span since my last harvest stays open and continues to tile through this entry.
**Two candidates are banked for it**, both with their three limbs met so the next
harvest need not reconstruct them:

1. *(carried, `J-dv_lead-0199`)* **When a false claim is struck from a document,
   enumerate the sites to correct by the claim, not by the string that expressed
   it.** **LH1** `a0cf4dd` and `J-dv_lead-0199`; **LH2-g**, no proper noun;
   **LH3** without it the corrected document keeps teaching the struck claim
   wherever it was paraphrased. **This round is its first independent test and it
   returned four sites no string-keyed sweep could reach**, which is evidence for
   the rule rather than a restatement of it.
2. *(new, this round)* **A correction that strikes a false claim must re-read
   every judgement that rested on it: a struck claim can leave a decision weaker
   than the truth, not only wronger than it.** **LH1** this commit — §15's
   class-`D2` disposition read *"as likely to be the instrument as the design"*
   when the arithmetic that killed the claim makes the design **impossible** as a
   source of that reading; **LH2-g**, no proper noun of any kind; **LH3** without
   it a document is corrected into accuracy while the decisions calibrated
   against its false claim keep routing work to the wrong seat.

### Open-questions

1. **Item (g) is owed and is not mine to write.** The SPEC-M04 §6.2
   `Preamble`-row contradiction needs an architect spec-diff round; my
   countersignature attaches to the diff and cannot precede it. The repair's
   **shape** is itself open (`J-architect_docs_lead-0055` Open-question 1: the
   narrow C-14.2-style exception, or the wider question of whether §6.2's rows
   should carry `tx_tready` values at all). **Orchestrator's to schedule; mine to
   countersign when it exists.**
2. **The hold-until-acceptance rule has no home in the programme** (item (c)'s
   residue). SPEC-M01 §7 delegates field stability to each declaring
   specification; SPEC-M04 §7 declares stability *on the acceptance cycle only*
   and then relies on a hold rule stated once, in its **reset** bullet, and
   attributed to a bullet that does not state it. **Every transmit-path source in
   the chain relies on it implicitly.** It is an adjudication I should take
   **with** architect_docs_lead, not alone, and it is wider than any one packet.
3. **The stronger `ST-2` needs a commissioned round** (item (k)). It is recorded
   at the packet and at `AP-M04` §7 `T-3` with its executor named; it is a
   `bench.ml` edit with a CI-executed result and cannot ride a revision.
4. **`M04-G4` has now missed three consecutive M04 rounds**, still needs nothing
   built, and is still the cheapest outstanding row at this module. **`DVC-1a`
   remains unbuilt and every M04 count in this entry is again a hand count with
   its method stated** — the fourth round running. Both mine.
5. **The `class-11` re-run owed before `P1-module-ready` is untouched by this
   round** and remains the orchestrator's to operate (`J-dv_lead-0199`
   Open-question 1). A packet revision is not a disposition check, and I have not
   treated it as one.
6. **No escalation.** No E1 (I supply evidence and request no approval), no E2
   (no scope, row or requirement moves), no E3, no E5 (no lead dispute — the six
   architect items were adopted, and the one I declined, fact 8, was ruled my
   call by the architect itself), no E6. No CRITICAL finding against any seat;
   the one finding this round files is MINOR and against my own artifacts.

### Files-in-this-commit
- agents/handoffs/WO-0083_tb-m04-stage-2-stall-schedule-and-family-g.md
- test/attack_plans/AP-xgmii_tx_64.md

## [J-dv_lead-0201] 2026-08-22T07:34Z | task:WO-0083 | The countersignature I owed is given — the repair convicts the end my own re-measurement convicted, all three of my grounds survive it, and the finding routed jointly with it is refuted in its derivation and concurred in on a ground the derivation never reached

### Trigger

Orchestrator dispatch, **one round, one seat, narrow**: spawn short-id
**`RV-0083-G-COUNTERSIGN/2026-08-22T07:10Z`**. `RV-0083` item **(g)** — my
countersignature on the SPEC-M04 §6.2-`Preamble`-row-versus-§7-C-16-consequence-4
contradiction — was recorded **BLOCKED** at `J-dv_lead-0200` / `WO-0083` §21.2
for want of a diff to countersign. **The diff now exists**: architect_docs_lead
landed the repair at `18de537` (`J-architect_docs_lead-0064`). The dispatch also
routed the architect's **new** finding to this seat jointly — that consequence 4's
*"may be 1"* is arguably a **pin** — with the explicit instruction **not** to land
it but to disposition it.

**Precheck, one invocation, before reading anything:**

    git status --short   # (empty — clean)
    git rev-parse HEAD   # 18de537ac33ab4c80e9d3c39ff4b1edd42fcc2cc

**Both match the dispatched expectation** (clean tree; head prefix `18de537`), so
neither abort branch was taken and the round proceeded.

### Inputs

**Read at this head, all read-only.** No RTL was opened at any point — this round
judges a **specification diff** and touches no design question that could tempt
it.

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3 packets, §4 entry
  grammar, §6 write scopes, §7 gates and harvest, §10 independence).
- **The repair at source**: `git show 18de537 -- docs/specs/modules/xgmii_tx_64.md`
  — the whole diff, ten changed lines over three hunks — and `git show 18de537
  --stat`, which shows the commit stages **two** paths and no third.
- **The three edited regions in the file at HEAD, read in the file and not only
  in the diff**: §6.2's `Preamble` row (line **300**), §7's C-16 consequence 4
  (lines **481–492**), §13's new row (line **667**).
- **The surrounding clauses the checks turn on**, read in full rather than
  quoted from my own packet: §6.1's cycle table, its storage paragraph and its
  `cfg_tx_enable` paragraph (lines 262–290); §6.2's `Idle` row; §6.3 items 1–5;
  §7's latency bullet and its two-constant table, its throughput bullet, the
  whole C-16 bullet with all four consequences, the handshake bullet and the
  reset bullet (lines 350–530); §9's underflow row; §10's REQ-207 and REQ-210
  hooks; §11.2 and §11.3; §13's four earlier rows that bear on C-14.1, C-14.2,
  C-16.
- **The architect's own round**: `J-architect_docs_lead-0064` — its Outcome
  (which discharges the two constraints the dispatch attached) and its
  **Open-questions 1, 2 and 3**, question 2 being the finding routed here.
- **My own record of the blocked item**: `J-dv_lead-0200` (Reasoning on item (g)
  and on item (a)'s interaction with it, Evidence's re-measurement,
  Open-question 1) and `WO-0083` §21.2, §21.1 items (a) and (d), §4.2 fact 1,
  §4.4, §4.3.
- **The consumers, so the bench consequence is measured rather than guessed**:
  `test/xgmii_tx_64/bench.ml` (`present`, `present_stream`, `accepted_cycles_of`,
  `assert_liveness`, the **P-ACCEPT** precondition at lines 308–335);
  `test/xgmii_tx_64/test_m04_a.ml`, `test_m04_g.ml`; `test/attack_plans/AP-xgmii_tx_64.md`
  §4.G rows `M04-G4`/`G5`/`G9`/`G10`, §4.H rows `M04-H1` … `H6`, §6.1's census
  block, §9's change log.

### Reasoning

**1. What a countersignature is, and what I therefore checked.** It is an act
**on** a diff by the seat whose grounds the diff touches: it says *this repair
does what the record said was owed, at the end the record convicted, without
moving anything I am standing on*. It is not approval of the specification as a
whole and it is not a second diff. So the round has exactly four questions —
does it repair the convicted end; is the shape the one its own precedent set;
does anything landed move; do my three grounds survive — and one obligation the
dispatch added, the disposition of the new finding.

**2. The verdict is `COUNTERSIGNED`, and the first ground is that the direction
is mine.** §7 wins and the row is the defect. **The value §7 pins is compelled**:
with word 0 and word 1 both accepted and untransmitted, §6.1's two-word depth —
*"not an elastic buffer"* — leaves no register for a third acceptance, so REQ-207
(*never accept a word M04 cannot then transmit*) forbids asserting `tx_tready`
there. **Nothing compelled the row's unconditional form**: it is the C-16 diff of
2026-08-02 having amended the `Idle` row and left this row as it stood, which is
**C-14.2's defect class exactly** — a §6.2 row stating a value §7 later
qualified. A repair that convicted the other end would have had to explain how a
design can accept a third word into two registers, and no such explanation
exists.

**3. The shape is the precedent's, which is worth more than its tidiness.** The
row carries the exception, names the covering §7 clause, says §7 wins, and gains
the second entry condition in the `Idle` row's own words; §7's consequence 4
gains one precedence sentence; §13 gains a dated row. That is C-14.2's shape
line for line — and I countersigned C-14.2. **A repair in the shape of the
precedent it cites is a repair a later reader can check against that precedent**,
which is the property that makes the third and fourth of these rows cheaper to
review than the first.

**4. The three ground-survival checks, and why (i) came back stronger than
"survives".** Item (a)'s upgrade routed §4.2 fact 1 and §4.4 onto three grounds,
and **ground 2 is the very row item (g) called defective**. At Revision B I
defended that by **frame separation**: the qualification bites only where an
early acceptance has happened, and `M04-G5` withholds word 1 of the run's
**first** frame, where none has. The repair does better than preserve the
separation — **it writes it into the clause**. The carved exception's premise is
*"this frame's word 1 has already been accepted (word 0 on the **predecessor's**
post-`tlast` cycle, word 1 on the gap's last cycle)"*, and **a run's first frame
has no predecessor**, so the premise has no instance there and the row pins
`tx_tready` = 1 at `C + 1` **by its own text**. What was an argument is now the
clause. `U22`'s red stays dispositive; grounds 1 and 3 are untouched by the diff
and were independent of the row in either case.

Check (ii) is the one where a "yes" could have been lazy, so I checked the
**bytes**: the second hunk **appends** to consequence 4 and edits nothing inside
it — the added text begins after the pre-existing sentence *"Either way M04 holds
at most two accepted, untransmitted words."* — and both branches, the first
branch's `0` and the second's *"may"*, are character-identical to their pre-diff
form. §4.4's broader ground keeps what Revision B put under it. Check (iii) is
the cheapest and is still worth executing: §21.2 named the subject *the §6.2
`Preamble`-row defect* and measured it at `6f165bd` (row at line 300,
consequence unchanged, no §13 row); the diff repairs **the row**, leaves the
consequence unmoved but for a precedence sentence, and adds the §13 row.
**Direction identical, and nothing in the diff repairs an end my re-measurement
did not convict.**

**5. The residual reading I found, and why it is recorded rather than bounced.**
The repair carves **one** exception out of the row, and §7's new sentence
describes the row as keeping `tx_tready` = 1 *"on every other cycle of that
state"*. At the **second** branch's preamble cycle two readings are then
available. **R1**: the precedence attaches to *this consequence*, both branches,
so §7 governs wherever consequence 4 speaks and the *"may"* survives against the
row's default — the reading the sentence's own subject supports and the one I
countersign under. **R2**: a reader of §6.2's table alone takes the single named
exception as exclusive and reads the row's `= 1` onto every preamble cycle it
does not name — including the one §7 leaves permissive. **R2 is item (g)'s defect
class at a second cycle.** I refuse three tempting moves here. I do not
countersign it away, because a countersignature that notices a thing and says
nothing is worth less than one that refuses. I do not refuse the diff over it,
because the disagreement **pre-dates** the repair — the row said `= 1` at that
cycle before it too, with no precedence rule anywhere — and the repair strictly
**improves** it by putting a precedence sentence in §7's own voice. And I do not
ask for it to be repaired now, because **its correct repair depends on an answer
nobody has**: if the *"may"* is a pin, the row's `= 1` is *right* there and wants
a citation rather than an exception; if it is a permission, the row wants a
second exception or the wider shape-(i) deletion. **Repairing it before that
question is decided lands the wrong repair half the time.** It folds into the
joint item.

**6. The joint finding: I refute the derivation and concur in the conclusion on a
ground the derivation never reached.** The architect's ground is REQ-210's event
delay plus §6.1's transmit rule plus a **two-register minimum**, leaving word 1 of
a ≥ 2-word frame exactly one acceptance cycle. It names its own soft step (the
≥ 2-cycle accept-to-transmit distance is *"stated for the idle-transmitter frame
and inferred elsewhere"*). **The step is not soft, it is false**, and §7's own
instances kill it: in consequence 4's first branch word 0 is accepted at `C + 8`
and transmitted at `C + 13` — distance **5** — and word 1 is accepted at `C + 11`
and transmitted at `C + 14` — distance **3** — and consequence 3 states in terms
that §6.1's `C + m + 2` is *"stated for a frame whose first word is accepted into
an idle transmitter with the gap already served"*. **A rule with instances at 2, 3
and 5 fixes no minimum.** So I built the counter-model rather than asserting the
refutation: the **late-accept design** accepts word 0 at `C`, emits `/S/` at
`C + 1` with `tx_tready` **0**, emits frame octets 0–7 at `C + 2` while accepting
word 1 there, emits octets 8–15 at `C + 3`, and continues one word per cycle. Its
wire output is **byte-identical** to the reference cadence; REQ-210's 1-cycle
event delay holds; ΔC = 2 to the first word carrying frame octets holds; REQ-207
holds at every acceptance; REQ-204 and REQ-209 are untouched; and it never holds
more than one accepted untransmitted word, let alone three. It needs **one** word
of storage — which is exactly what §6.1 says the depth of two is *for*: *"The
preamble word is the one output slot that does not consume a source word, and
that is the whole reason the depth is two rather than one."* **Depth two is what
the permission costs, not what compels it**, and that sentence has been read
backwards.

**What actually kills the counter-model is the per-octet latency, not any
register count** — and this is the part the architect could not have reached from
the clauses it cited. In the late-accept design word 0's octets have input octet
time `8C + j` and output octet time `8(C + 2) + j`, giving **L = 16**; word 1's
octets have input `8(C + 2) + j′` and output `8(C + 3) + j′`, giving **L = 8**.
**Two values of L in one frame** — and §7 pins *"L = 16 for every frame octet, of
every frame, at every length"*, with §0.5 requiring L to be single-valued and §7
stating precisely what makes it single-valued here. Because the frame's words are
**contiguous** on the wire once the start character is out, the only acceptance
schedule that holds L at one value is acceptance on consecutive cycles
`C, C + 1, …, C + W − 1` — **whose second member is the preamble cycle**.
**Therefore, for a frame with `W ≥ 2` in L's domain, `tx_tready` = 1 at the
preamble cycle is compelled and the *"may"* is a pin.** So: **plausibly a pin,
yes — and on a ground that makes the open question smaller.**

**7. What is genuinely open is L's DOMAIN, and that reframing is the useful
output.** §10's REQ-210 hook measures *"each into an idle transmitter after the
gap has elapsed"* and §7 puts back-to-back outside REQ-210's domain — which is
right, since in consequence 4's first branch L is demonstrably multi-valued (40
for word 0's octets, 24 for word 1's). Two frames sit squarely **inside** the
domain: a run's **first** frame, and **the frame after an abort** (§4.3's tail
frame, fact 7 branch (b), issued into an idle transmitter). Consequence 4's
**second branch is the doubtful one**: its word 0 is accepted at `C + 11`, which
§7 itself calls a cycle *"inside the gap"*. **So the bench consequence the
architect names does not need consequence 4 at all** — the tail frame is in the
domain directly, and if the L ground holds, §4.4's `word ≥ 2` lower bound is
over-broad **there**, whatever happens to the *"may"*.

**8. What it would cost, measured in my own artifacts rather than estimated.**
Three consumers, and the direction matters in all three. **(a)** §4.4's lower
bound at the tail frame becomes an exclusion of a **legal** underflow stimulus
with a determinate expected strobe at `R = S_j` (fact 1 at `m = 1`, the tail
frame's own preamble cycle) — **a coverage exclusion, never a false red**; no
landed assertion and no expected value moves. **(b)** `AP-M04`'s `M04-H6` asserts
only the first branch's `0` at `C + 12` and routes the second branch away in
terms (*"that half is M04-H5's"*), and `M04-H5` is `NO-ASSERT` on the ground that
the value is unconstrained — **if the pin lands, H5's routing is wrong at exactly
one cycle and H6 gains a second assertable half**. **(c)** The one the architect
could not see, and the strongest reason to take the question: `bench.ml`'s
**P-ACCEPT** precondition on `Bench.present` requires the accepted cycles to be
exactly `C … C + W − 1` **contiguous**, which *is* an acceptance at the preamble
cycle, enforced by a `failwith` at disposition class **D3** on every frame it
drives. **Today that is a precondition the specification does not compel; under
the L ground it becomes spec-compelled** for every frame in L's domain. A landed
suite standing on an uncompelled precondition is exactly the thing a joint item
exists to resolve.

**9. Why it is queued and not landed, and why it gets a name.** Landing it moves
the ground under §4.4 and under a `NO-ASSERT` row, from a seat that cannot edit
`docs/**`; and it is an interpretive question about two clauses of one section,
which is the architect's craft and my consequence. So it is **`JOINT-M04-1`**,
seats dv_lead + architect_docs_lead, carried by the architect's **shape-(i)
round** — already declared *"a round with dv_lead in it"* — which now has three
subjects instead of one: shape (i), this pin question, and §21.6(g.3)'s residual
reading, whose repair this question decides. **A name because the two older joint
debts in this chain have drifted for rounds precisely by being described rather
than named**; the id scheme is minted at §21.6(g.4) with its allocation rule
stated, and the older debts are deliberately **not** renamed into it.

**10. What I did not do.** No spec text edited (`docs/**` is not mine, PROTOCOL
§6, and a countersignature is an act on a diff rather than a further diff). No
`test/xgmii_tx_64/**` edit. No row of `AP-M04` added, converted, struck or
discharged. No bar, verdict or disposition of Revision A or B reversed. No `SO-`
opened or offered. No escalation: this is a two-lead **agreement**, not a
dispute, so no E5 arises, and nothing here is E1–E4 or E6.

### Actions

1. Precheck (one invocation), then read the repair at source and the three
   edited regions in the file at HEAD, plus every surrounding clause the checks
   turn on.
2. Executed the three ground-survival checks **(i)/(ii)/(iii)** against my own
   Revision-B text, the second of them at the byte level.
3. Rendered the verdict **`COUNTERSIGNED`** and recorded it where this practice
   puts it — `WO-0083` §21.2 flipped to its closed state and the full record at
   the new **§21.6**, with the Revision Register gaining row **C** and the
   disposition vocabulary gaining **CLOSED**.
4. Corrected in place the **one** passage of Revision B whose quotation the
   repair made stale — §4.2 fact 1's blockquote, which quoted the row as
   unconditional — struck and re-quoted from the text at `18de537`, and stated
   the rule that found it in the Revision-C discipline paragraph.
5. Dispositioned the joint finding: refutation with counter-model, concurrence on
   the L ground, the domain question, the three consumers, and `JOINT-M04-1` with
   its carrier — `WO-0083` §21.6(g.4).
6. Recorded the plan-side note **(declared, my call under the dispatch's scope
   clause)**: one dated row in `AP-M04` §9. **Ground for taking it**: this plan
   is what a stage-3 seat reads, two of its rows (`M04-H5`, `M04-H6`) are
   consumers of the queued item, and one of them is a `NO-ASSERT` whose stated
   ground is the very *"may"* under question — a consumer that learns of the item
   only from a packet it may not read is a consumer that does not learn.
7. Re-measured both of the plan's censuses **after** the edit rather than
   carrying either forward, and this entry.

### Evidence

**Every command below was run in this working tree at `18de537` and its output is
quoted as observed. No CI run is claimed: this round stages no code and compiles
nothing.**

- **Precheck**: `git status --short` → empty; `git rev-parse HEAD` →
  `18de537ac33ab4c80e9d3c39ff4b1edd42fcc2cc`. Matches the dispatched expectation.
- **The diff, read at source**: `git show 18de537 --stat` → two paths,
  `agents/journals/claude_architect_docs_lead_agent.v06.md` (+329) and
  `docs/specs/modules/xgmii_tx_64.md` (**10 changed lines**, `+8 −2`), **and no
  third path** — so the repair touches no test, no script and no CI input.
- **Check (ii) at the byte level**: in `git show 18de537 -- docs/specs/modules/xgmii_tx_64.md`
  the consequence-4 hunk's only `-` line is the pre-existing sentence *"Either way
  M04 holds at most two accepted, untransmitted words."*, re-emitted as the first
  line of the `+` block with the new precedence sentences appended after it.
  **Both branches of consequence 4 appear in no `-` line and in no `+` line.**
- **The three regions at HEAD, by line number**: `grep -n "keeps \`tx_tready\` = 1"
  docs/specs/modules/xgmii_tx_64.md` → **300** (the row, now carrying its
  exception); consequence 4 at **481–492**; §13's new row at **667**, dated
  2026-08-22 and citing `J-architect_docs_lead-0064`.
- **The "no committed test changes meaning" claim, measured not assumed**:
  `grep -rn 'tx_tready' test/ --include=*.ml` returns **six** hits, all in
  docstrings or comments — `bench.ml:342`, `test_m04_a.ml:372`,
  `test_m04_g.ml:14`, `:15`, `:101`, `:104` — **and three of them say in terms
  that no value of `tx_tready` is asserted**. **No unit in the suite asserts any
  value of `tx_tready` at any cycle**, so nothing landed moves on this diff or on
  either outcome of the queued item.
- **The P-ACCEPT consumer, read at its source**: `test/xgmii_tx_64/bench.ml`
  lines 308–335 — `present` calls `assert_liveness`, then requires
  `accepted_cycles` to equal `List.init w ~f:(fun m -> c + m)` and `failwith`s
  otherwise, its message naming **"P-ACCEPT precondition failed (WO-0080 §5.6,
  disposition class D3)"**. Contiguity from `C` **is** an acceptance at the
  preamble cycle. `present_stream` deliberately omits it (its comment: contiguity
  *"is FALSE against a conformant M04 at the second frame of every run"*).
- **The plan's two censuses, re-run at this tree AFTER the edit** (§0.1(i),
  measured and never carried forward):
  - §6.1's own quoted command → **`83 83 []`**, unchanged.
  - status-cell pass over every row table → **83 row lines, 83 distinct ids;
    ASSERT 59, NO-ASSERT 12, NO-STIMULUS 6, STRUCTURAL 5, GAP 1, RULING 0** —
    unchanged. Discharged stays **41 of 83**, outstanding **42 of 83**.
  - `## 9. Change log` now carries **10 dated rows**, the last this round's.
- **Table well-formedness of every table this round touched**, counted rather than
  eyeballed: the Revision Register rows and both §21 item tables measure **5**
  `|` per line against their own headers; §21.6's ground-check table **5**; its
  late-accept cadence table **4**; the new `AP-M04` §9 row **4**, byte-identical
  in delimiter count to the row above it.
- **Hand-count provenance, again**: `tools/dv_checks.sh` still contains zero
  occurrences of `M04`, `xgmii_tx_64` or `AP-xgmii_tx`, so **no committed
  instrument counts an M04 row** and every count above is a hand count with its
  method stated. **`DVC-1a` is unbuilt for the fifth consecutive M04 round.**
- **Harvest**: **none due, declared rather than omitted.** PROTOCOL §7 and
  ADR-0018 attach the harvest to every `SO-` and every phase gate; this is
  neither, so the span since my last harvest stays open and continues to tile
  through this entry. **Four candidates are now banked for it**, the two carried
  from `J-dv_lead-0200` (enumerate a struck claim's sites by the claim, not the
  string; and re-read every judgement that rested on a struck claim, since a
  strike can leave a decision **weaker** than the truth) and two new ones, both
  with their three limbs met:
  1. **When a document is repaired by carving one named exception out of a rule,
     the carve-out hardens the rule's reading everywhere it does not name — so
     the review of that repair must re-read every other case the rule now reads
     onto, not only the case the exception was written for.** **LH1** this commit
     (`18de537` plus this entry): the exception repaired the branch it named and
     left the row reading as a pin at a second branch where the same section
     calls the value a permission. **LH2-g**, no proper noun of any kind.
     **LH3** without it, a repair that closes one contradiction silently hardens
     the next, and the countersignature approving it becomes the record that
     nobody looked.
  2. **A floor on a quantity may not be inferred from a formula stated for one
     case while the same document exhibits other values of that quantity: count
     the instances before calling it a minimum.** **LH1** this commit — a
     derivation resting on a two-cycle minimum, in a section whose own worked
     cases exhibit three and five. **LH2-g**, no proper noun. **LH3** without it,
     a reading compels a design constraint the specification never imposed, and
     the benches written to it fail conformant designs.

### Outcome

**DoD: met**, for a countersignature round. **Verdict: `COUNTERSIGNED`.**
**`RV-0083` item (g) is CLOSED** — the last of the eleven items
`RV-0083-VERDICT` §5 routed to this packet's revisions, and the only one Revision
B could not discharge. **All three ground-survival checks return YES**, check (i)
returning stronger than survival (the frame separation is now written into the
clause rather than argued around it) and check (ii) verified at the byte level.
**One MINOR residual reading is recorded and deliberately not repaired**, with
the reason it cannot be repaired before `JOINT-M04-1` is answered. **The joint
finding is dispositioned and not landed**: its derivation refuted with a
conformant counter-model, its conclusion concurred in on the per-octet-latency
ground, its real question narrowed to L's domain, its three consumers named, and
`JOINT-M04-1` queued with a carrier that already exists.

**Handoff**: `WO-0083` at **Revision C** and `AP-M04` carrying its §9 row, both to
the orchestrator for commit under my seat. **Nothing is routed to any worker**, no
`RV-` is owed, no spawn is requested, and **no `SO-` is opened or offered**.
`BAR T1` stays **SHUT**; REQ-206 is **not** covered; `M04-G4` is still
outstanding and has now missed **four** consecutive M04 rounds.

### Open-questions

1. **`JOINT-M04-1` — is §7's *"may be 1"* a pin, and does L's domain reach a
   frame whose word 0 was accepted on the gap's last cycle?** Seats: me +
   architect_docs_lead. **Carrier**: the architect's shape-(i) round
   (`J-architect_docs_lead-0064` Open-question 1), which now carries three
   subjects. **Orchestrator to schedule; architect owns any `docs/**` diff; the
   follow-on inside my scope is mine** — `WO-0083` §4.4's lower bound at the tail
   frame, `AP-M04`'s `M04-H5`/`M04-H6`, and P-ACCEPT's grounding.
2. **The residual reading at §21.6(g.3) rides item 1 and must not be repaired
   before it.** Recorded here so that a later seat meeting the row does not file
   it as a fresh finding and get a narrow repair landed in the wrong direction.
3. **The hold-until-acceptance rule still has no home in the programme** — the
   older joint debt, carried unchanged from `J-dv_lead-0200` Open-question 2 and
   `J-architect_docs_lead-0064` Open-question 3. **It is not renamed into the
   `JOINT-` scheme by this round**, which would be tidying rather than
   progressing it.
4. **`DVC-1a` is unbuilt for the fifth consecutive M04 round**, so every count in
   this entry is again a hand count. `M04-G4` has now missed four. `T-2` is still
   unbuilt. All mine.
5. **The `class-11` re-run owed before `P1-module-ready` is untouched** by this
   round and remains the orchestrator's to operate (`J-dv_lead-0199`
   Open-question 1). **A countersignature is not a disposition check, and I have
   not treated it as one.**
6. **No escalation.** No E1, E2, E3, E5 or E6, and no CRITICAL finding against
   any seat: this round agrees with the architect on the repair and disagrees
   with it only on the derivation of a finding it deliberately did not land,
   which is collaboration operating as designed rather than a dispute.

### Files-in-this-commit
- agents/handoffs/WO-0083_tb-m04-stage-2-stall-schedule-and-family-g.md
- test/attack_plans/AP-xgmii_tx_64.md
