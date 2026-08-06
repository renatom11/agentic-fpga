# Journal: claude_dv_lead_agent — volume 07

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 07
- **Continues-from**: J-dv_lead-0148
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v06.md
- **Previous-volume-sha256**: 3b452395ea153af91d5a860b62787af011cd52ec5b306ff42a466790c6dd01ce
- **Previous-volume-bytes**: 268356

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 06 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0149] 2026-08-11T08:10Z | task:none | The programme's longest-lead item designed at last — and the census I was made to run by my own worst finding is what decided the packet's shape, by turning up two refusal guards no reading of the stimulus generator could have seen

### Trigger

Orchestrator dispatch, sole agent in flight. The commission is my own, dated at
`WO-0077-VERDICT` §13 item 7 — *"`RV-0075-1/2/3`'s owed repairs ride the Phase-2/3
stimulus-widening work order, which I draft after this campaign scores and which
is dated by the commit that carries it"* — and it is the longest-lead item this
programme holds before `SO-xgmii_rx_64.md`, in `WO-0046`'s adjudication's own
words at its §5 item 3.

**HEAD verified as my first action, before reading anything**: `git rev-parse
HEAD` → `beb9c2ad143a2bc9e36eaeab0ffc15c52bd0fbd8`, exactly the spawn head, with
`19de5dd` as its parent. Neither rollback disposition fired and no descendant
check was needed.

**This entry opens volume 07.** v06 crossed ADR-0017 §5.1's soft threshold at
`beb9c2a` (268 356 bytes) and `J-dv_lead-0148` declared in its own Outcome that
it would not rotate and that this entry would. The chain header above was
computed rather than transcribed: `git show HEAD:agents/journals/claude_dv_lead_agent.v06.md`
piped to `sha256sum` and to `wc -c`, both agreeing with the values the dispatch
carried. v06 is not staged and is not touched.

### Inputs

Read at `beb9c2a`, all read-only:

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` — mandatory first actions,
  both in full.
- `agents/handoffs/WO-0077_family-k-mutation-campaign.md` — the pre-run reading
  note's `RN-6` ruling block, and **`WO-0077-VERDICT`** §9.1
  (`FINDING WO-0077-A1`, both halves, in full), §9.2, §9.3 and §13's nine-item
  owed list.
- `agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md` in full: the packet
  (§0–§12, especially §3's three tiers, §6's exit-code table, §7's six self-test
  cases, §8's seven prohibitions, §9's strobe refusal, §10's DoD, §11's
  landing-order argument) and **`RV-0075-VERDICT`** (§2's `FINDING RV-0075-1` and
  `FINDING RV-0075-2`, §3's process-gap repair, §4.1's three-part ruling and its
  case-(e) closing paragraph, §4.2, §6's four standing bars, §7.1's
  `FINDING RV-0075-3`, §7.2's three-item owed list).
- `agents/handoffs/WO-0044_cosim-lane-opening.md` §§1–7 — **the lane's own
  phasing**, which is what "Phase 2–3" names in this commission.
- `agents/handoffs/WO-0046_cosim-phase-1-adjudication.md` §5 (not discharged) and
  §9 (what buys most per round); `agents/handoffs/WO-0046_cosim-phase-1.md` §9.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` — §§0-bis, 2-bis, 5, 6 (the frozen
  V1–V7 predictions and their phase distribution), 7, 8, 9.
- `test/attack_plans/AP-xgmii_rx_64.md` §7 in full — bars 1–4, `RV-0075`'s three
  landed placements, and `FINDING WO-0077-A1`'s standing census repair as
  landed at `J-dv_lead-0148`.
- `docs/specs/requirements.md` — **REQ-901** in full (its divergence classes
  (a)–(f), the 64-to-1518 bound, and the never-a-licence sentence), REQ-107,
  REQ-108, REQ-602, and the three REQ-901 change-log rows.
- `docs/specs/modules/xgmii_rx_64.md` — §6.1's formula and injection clause, via
  the quotations `WO-0075` §3.2 and `RV-0075` §2 carry, re-read at source.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §§4.3–4.4;
  `docs/adr/ADR-0015-...` §§D1–D3 headings and D2's no-edit rule.
- **My own lane, measured rather than remembered** — `test/cosim/stimulus_gen.ml`
  in full, `test/cosim/ours_run.ml` (`:30–50`, `:95–148`, `:150–205`),
  `test/cosim/canonical.mli` (`:1–120`), `test/cosim/tb_xgmii_rx_64.v`
  (`:120–145`, `:260–300`), `tools/cosim/run_cosim.sh` (`:443–453`, `:755–800`),
  `test/xgmii/arrival.mli` (`:74–100`, `:125–156`),
  `test/third_party/verilog-ethernet/PROVENANCE.md`.
- `tasks/BOARD.md` rows for `WO-0075` and `WO-0077`.

**No `libs/**` and no `rtl_snapshots/**` were opened**, this round or in the
derivation of anything in the packet. Every expected value the packet pins is
spec-derived and cited to a spec section; the vendored reference was read only
for its pin and its file list.

### Reasoning

**1. The naming collision had to be cleared before anything else, because I own
both sides of it.** "Phase 2" and "Phase 3" name the *lane's* phases in
`WO-0044` §4 and the *programme's* phases in `RV-0075-VERDICT` §6 item 4, and the
second of those is a sentence I wrote to keep an anchor claim honest — *"Phase 2's
anchor is a different instrument entirely."* A packet titled "Phase 2–3" that did
not say which would be read as commissioning an ITCH-side instrument that does
not exist. §0.1 clears it and §10 item 11 restates it as a prohibition, because a
collision cleared once in an opening section and then left to memory is not
cleared.

**2. The central design decision, and it is the one thing in this packet I would
defend hardest: the lane gets a case SET with case 0 FROZEN, not a widened
stimulus.** The obvious shape is to edit `stimulus_gen.ml` until it drives more.
That shape destroys `FINDING WO-0077-A1`'s positive half. The finding established
that this anchor is *"blind to seven of nine, and SIGHTED for exactly the two
whose defect lands on a start character sitting on a reset-release cycle"*, and I
went looking for the mechanical cause rather than accepting the description:
`Arrival.create`'s `?first_start` **defaults to 8** — lane 0 of cycle 1, *"so that
a bench sees one idle word before any frame"* — and `stimulus_gen.ml` passes
**0**. That one argument is the whole of why the co-sim lane admits on cycle 0 and
`test/xgmii_rx_64/` never does. **Every natural widening move overwrites it**: a
prologue idle, a `~first_start:12` lane-4 start, a two-frame schedule at the
default. And the overwrite would be invisible — the job stays green and the next
campaign finds the lane blind again with nothing in the record saying when it
stopped being sighted. Freezing case 0 also keeps every result the lane has ever
produced citable, and it converts `WO-0075` §8 item 1's diagnosability bar from a
prohibition into a mechanism.

**3. Obeying my own census repair is what decided the authorisation boundary, and
that is the evidence for the repair rather than a restatement of it.**
`FINDING WO-0077-A1`'s standing rule requires a universal to be measured over
every producer that drives the DUT. Applied to a packet about the lane, the
direction reverses: I had to measure what bounds the lane's *stimulus space* over
every producer, not over the generator. The result is §2.2's table, and it
contains two entries no reading of `stimulus_gen.ml` could produce —
`ours_run.ml:118` and `tb_xgmii_rx_64.v:274` both **refuse a second start
character while a frame is open**, in two independently written accumulators,
each citing REQ-110's abort case as out of Phase 1's authorised stimulus. **So
V5 is not a stimulus change; it is a change to an admission algorithm in two
producers that must agree, or the comparison compares nothing.** That is a
different risk class from everything else in the packet, and it is why co-sim
Phase 2 is authorised and co-sim Phase 3 is scoped-not-authorised. **The staging
is a direct product of running the census the way the finding demands.** The
same census produced the cheap half too: both guards fire only *while a frame is
open*, so a second frame after the first closes passes both, and
`Arrival.create` already takes a frame list — co-sim Phase 2 needs no accumulator
change at all.

**4. `FINDING WO-0078-1`, minted here, and the care about what I may claim.**
Our side's refusals are `failwith` and reach a non-zero exit that `run_pipeline`
maps to `EXIT_BUILD`. The reference side's are `$display` then `$finish`, and the
harness's check is `rc -ne 0 || ! -e theirs.canon` — a normal termination after
the file is opened satisfies neither disjunct. **I did not claim to have observed
this**: ADR-0005 puts no `iverilog` in this container and I executed nothing. What
the packet claims is narrower and is the claim that matters — *the rc check
cannot be assumed to catch a reference-side refusal, and the assumption has never
been tested because no stimulus has ever tripped one*. It is harmless at
`beb9c2a` and stops being harmless at the first case that can reach a guard. I put
the repair in **Stage 1**, not in Phase 3 where the guard is needed: a guard whose
failure mode is discovered in the round that needs it has failed twice.

**5. Staging, and the precedent I followed rather than invented.** `WO-0044` §4
authorised Phase 1 and scoped Phase 2 — *"Nothing past Phase 1 is authorised by
this packet"* — for a stated reason: the earlier phase teaches what the next one
costs. I did the same one phase later, and with a sharper reason than "we will
learn something": the C9 admission-rule problem is real, measured and named. Stage
3's re-authorisation gate requires the admission rule to be **written as spec-derived
text before either producer is opened**, because two producers implementing it
from each other is a circularity that would make the comparison compare a shared
assumption rather than two designs.

**6. Batching C1 + C2 and refusing to batch C3 and C4.** `WO-0075` §8 item 1
barred stimulus change on the ground that folding two changes together makes a
failing run un-diagnosable. That reasoning is correct and it is *conditional on
there being no per-case attribution* — which there now is, by §3.2's per-case
lines. So I allowed the two clean-frame cases into one landing and kept the two
predicted-divergence cases apart, because each of those may resolve to branch γ
and force a REQ-901 spec diff, and a spec-diff conversation held about two cases
at once is a conversation about neither. **The saving is bought by a mechanism,
not by optimism**, and I said so in the packet where a reviewer will meet it.

**7. Bar 4 moves at C3 and I refused to pay it, which is the point of writing
preconditions in order.** `WO-0075` §9 refused the strobe record on three ordered
preconditions — stimulus, then mapping, then grammar — and recorded them unmet at
the first. **C3 is the first stimulus in this lane's history that makes
`error_bad_fcs` pulse**, so precondition (1) becomes met for exactly one strobe.
(2) and (3) stay unmet: `error_bad_frame` on the reference is a different signal
that also raises on a bad FCS, where SPEC-M03 §9 gives that event to
`error_bad_fcs` alone, so a name-keyed comparison would red a conformant M03.
**A strobe field added by any stage of this packet is a defect against it** (§10
item 4). What changed is that a future packet starts at the second precondition
instead of the first — which is the only reason to write preconditions in an
order.

**8. R-SEAL-1, considered and found not engaged, stated rather than assumed.**
§7's dispositions are frozen predictions, and the reflex from ten campaigns is to
seal them in a companion file. **Nothing here is withheld**: the predictions are
written in the open in the packet, and the CD instances §6.2 requires are
committed before the runs they govern. ADR-0016 reaches a claim that a result
exists and is being withheld from the reader; this packet makes none, so there is
no seal to ship and none is promised. Saying so is cheaper than having a reviewer
work out that the rule does not bite.

**9. Cost, and the band that refuses the wrong conversation.** The `cosim` job's
own duration and the marginal cost of a second case **have never been measured**
and I cannot measure them. Rather than estimate, Stage 1 carries a cost probe —
`WO-0070`'s precedent, where the first bench with a non-trivial runtime opened its
packet with a measurement. The bands are pre-committed with the answer not in
hand, and **Band B exists to stop a specific bad conversation**: superlinear
per-case cost is a machinery finding (something is re-doing per case what it
should do once — the `dune build`, the `iverilog` compile, the provenance checks),
**not** a reason to reduce the case set. Only Band C makes the set a scope
question, and then it goes up as E2 with options, never narrowed inside DV.

**10. What I routed rather than absorbed, and why each.** The CD domain instances
are a hard precondition on Stage 2 and are **mine**, not an assignee's — CD §9
still reads *"frozen for Phase 1 as written"* and CD §0 bars moving an entry after
a run has probed it, so a case that runs before its instance is committed is void.
This round writes one file, so CD does not move here and §13 dates the obligation
instead. `FINDING K-1`'s message repair does **not** ride: no stage of this packet
opens any file under `test/xgmii_rx_64/`, and pretending otherwise would be the
carrier-shopping I warned against one entry ago. **`RN-6`'s `tools/dv_checks.sh`
resolve-check I came close to absorbing and did not** — Stage 1's data_wrangler
half does open `tools/`, which would make it the ruling's literal "first commit
that opens `tools/`" — because the check is a governance instrument over
`agents/handoffs/**` and is mine to write rather than a data-preparation worker's,
and because RN-6's own ruling already names the practical carrier: *"in practice
the `SO-` round's own accounting, which re-runs that script anyway."* I recorded
the near-absorption in §13 rather than only the decision, so a reader can see the
question was asked.

**11. What I rejected.** A single-stage packet building the whole case set at
once (rejected: it would put a spec-diff-forcing case and a machinery repair in
one diff). Adding the strobe field at C3 (rejected: item 7). Writing the packet
against a widened `stimulus_gen.ml` with case 0's *content* preserved but its
*call site* edited (rejected: the sha256 criterion is only checkable because the
construction expression is untouched — a re-derived-but-equal stimulus makes
criterion 1 a matter of inspection instead of a matter of arithmetic). And a
tenth pass criterion asserting the whole authorised set green (rejected: it is
not falsifiable by an observation, it is a restatement of the DoD).

**Harvest.** **Not due this round and the span stays open** — PROTOCOL §7 places
the harvest at every `SO-` and every phase gate, and this is a work-order draft.
**Banked, not minted, as candidate (J)** — the tenth: *when an instrument is
measured capable on exactly one configuration, that configuration is frozen and
new ones are added beside it; widening it in place destroys the only evidence of
capability the instrument has, and destroys it invisibly, because the widened run
still passes.* **LH1**: `WO-0077`'s `IC-K3` and `IC-K5` co-simulation reds, whose
sighted condition is a property of the base configuration, together with this
round's measurement of its mechanical cause (a schedule default of one idle word
overridden to zero at exactly one call site). **LH2-g** holds — no proper noun of
any kind in the rule statement. **LH3**: without it, a widening round trades its
one measured capability for coverage and cannot tell that it did, because the
trade leaves no red. The nine candidates `WO-0077-VERDICT` §13 item 8 records are
unchanged and unmerged; this makes ten.

### Actions

- Verified HEAD, then the v06 chain-header inputs, before reading any artefact.
- Read the artefacts listed under Inputs; measured the lane's own files at
  `beb9c2a` rather than quoting figures from prior packets.
- **Wrote one new file**:
  `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — a DRAFT work
  order in fourteen sections, authorising Stage 1 (machinery, case 0 only) and
  Stage 2 (co-sim Phase 2, four cases in three landings), scoping Stage 3
  (co-sim Phase 3, five cases) without authorising it.
- Opened journal volume 07 with the ADR-0017 §4.3 chain header and this entry.
- **Ran no `git` command that writes.** No `test/`, `tools/`, `libs/` or
  `docs/` file moved this round; `AP-xgmii_rx_64.md` and
  `CD-xgmii_rx_64_cosim.md` were read and not edited.

### Evidence

All commands are runnable from a checkout at this commit's parent (`beb9c2a`)
unless stated. **No CI run, no simulator and no `dune` was executed this round;
none is available (ADR-0005), and this round's product is a document.**

1. **Head check**, first action:
   `git rev-parse HEAD` → `beb9c2ad143a2bc9e36eaeab0ffc15c52bd0fbd8`;
   `git log --oneline -3` → `beb9c2a` / `19de5dd` / `d6fdf92`.
2. **Chain-header inputs, recomputed rather than transcribed**:
   `git show HEAD:agents/journals/claude_dv_lead_agent.v06.md | sha256sum` →
   `3b452395ea153af91d5a860b62787af011cd52ec5b306ff42a466790c6dd01ce`;
   the same pipeline to `wc -c` → `268356`. Both agree with the dispatch's
   values and with the header above.
3. **The refusal census (§2.2 of the packet)** —
   `grep -n "failwith\|FAIL\|\$fatal\|\$finish\|exit 2\|prerr" test/cosim/ours_run.ml test/cosim/stimulus_gen.ml test/cosim/tb_xgmii_rx_64.v`
   returns the six refusals the packet tabulates, at
   `ours_run.ml:63`, `:118`, `:133`; `stimulus_gen.ml:46`;
   `tb_xgmii_rx_64.v:274`, `:288` (plus three file-open `$finish`es at `:240`,
   `:245`, `:250` and the terminating `$finish` at `:320`, which are not
   refusals and are excluded from the table deliberately).
4. **The two accumulators' second-start refusals, quoted from the files**:
   `ours_run.ml:118` — *"ours_run: a second start character arrived while a
   frame was open -- REQ-110 abort handling is out of Phase 1's authorised
   stimulus (WO-0046 section 9)"*; `tb_xgmii_rx_64.v:274` — the same sentence in
   `$display` form, followed by `$finish` at `:276`.
5. **The mechanical cause of the sighted placement** —
   `sed -n '74,100p' test/xgmii/arrival.mli` shows `?first_start` documented as
   *"the octet time of the first start character (default 8, i.e. lane 0 of cycle
   1, so that a bench sees one idle word before any frame). Must be a multiple of
   4"*, and `test/cosim/stimulus_gen.ml:42` passes `~first_start:0`. **The
   multiple-of-4 constraint is what makes `~first_start:4` a lane-4 start that
   still sits on cycle 0**, which is §4.2 instruction 2 of the packet.
6. **The harness's reference-side rc check (`FINDING WO-0078-1`)** —
   `sed -n '755,800p' tools/cosim/run_cosim.sh`: `run_pipeline` guards both
   producers with `if [ "$rc" -ne 0 ] || [ ! -e "$dir/<file>" ]`, and echoes the
   captured output through `say` regardless. **Claim marked in the packet as
   derivation, not observation**, with the reason stated there.
7. **Exit-code space** — `grep -n "EXIT_" tools/cosim/run_cosim.sh` shows
   `EXIT_OK=0` … `EXIT_TIMING_NO_VERDICT=11` at `:443–453`; **12 is unallocated**,
   which is what `RV-0075-VERDICT` §4.1(b) reserved it for.
8. **The sidecar field criterion 1 rests on** — `run_cosim.sh:755` calls
   `require_field "stimulus_sha256"` and prints it, so case 0's frozen-ness is
   checkable against a prior green run's log with no new machinery.
9. **The reference pin** —
   `grep -n "77320a9" test/third_party/verilog-ethernet/PROVENANCE.md` →
   `77320a9471d19c7dd383914bc049e02d9f4f1ffb`; the vendored closure is two files
   plus `COPYING` and `PROVENANCE.md`.
10. **`FINDING WO-0077-A1`'s two halves, quoted from committed artefacts, not
    re-derived**: the census repair as landed in `test/attack_plans/AP-xgmii_rx_64.md`
    §7 at `19de5dd`, and the positive half's sentence from `WO-0077-VERDICT` §9.1
    at `d6fdf92`. **I re-executed nothing on `api.github.com` this round**; the two
    `cosim` job ids the finding rests on are the adjudicating verdict's readings
    and are cited as such in the packet.
11. **The packet itself**: `wc -l agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md`
    at this tree; fourteen numbered sections plus a section map, nine pass
    criteria at §12, twelve prohibitions at §10, six routed items at §13.

### Outcome

**DoD met for the round as commissioned.** `WO-0077-VERDICT` §13 item 7's owed
list is discharged into one draft packet:

1. **The co-sim Phase 2–3 scope**, per `WO-0044` §4's phasing and CD §6's V1–V7
   distribution, with the naming collision cleared first. ✔
2. **`WO-0075`'s accepted three-tier design carried forward** — T0/T1/T2,
   `EXIT_TIMING=10`, `EXIT_TIMING_NO_VERDICT=11` — with the aggregate precedence
   pinned for a case set (§3.3) and the tiers' meanings unchanged. ✔
3. **The one-frame-bound scope statement**, restated and staged: what each stage
   does to it, and §12 criterion 9 forbidding any claim outside the driven set. ✔
4. **The exit-12 / `EXIT_TIMING_UNASSERTABLE` decision**, allocated, placed on the
   did-not-reach side, and made **required** in the stage that lifts §8 item 1,
   exactly as `RV-0075-VERDICT` §4.1(c) dated it. ✔
5. **The case-(e) rebuild** on a ≥ 3-word frame with an interior shift, plus case
   (e′) at the boundary, with `FINDING RV-0075-3`'s no-optional rule applied to
   both. ✔
6. **`FINDING RV-0075-1` and `-2`** absorbed into Stage 1, `-2`'s mechanism
   constrained by bar 4's stimulus→mapping→grammar ordering. ✔
7. **`FINDING WO-0077-A1`, BOTH halves** — the census repair obeyed and
   demonstrated (§2.2, §4.1), and the positive half turned into three checkable
   construction rules plus pass criterion 2 (§4.2). ✔
8. **Standing conventions**: frozen inputs with a re-measurement bar (§1),
   falsifiable pass criteria (§12), what-this-does-NOT-do (§10), cost with the
   unmeasured part named and a pre-committed band (§9), and the dating rule
   stated in the header. ✔
9. **Items that do not belong here are routed by name, not absorbed** (§13, and
   Reasoning item 10). ✔

**No `SO-xgmii_rx_64.md` is opened and none is offered. No stage of this packet is
issued by this round** — it is a DRAFT, and the orchestrator issues Stage 1 when
it chooses to, subject to §6.2's CD precondition for Stage 2.

**Handoff**: the file set below goes to the orchestrator for commit under trailer
`Agent: dv_lead`, `Work-Order: none`, `Journal-Entry: J-dv_lead-0149`. **The
packet is dated by that commit and asserts no date of its own**, per the rule that
commissioned it. I ran no git command that writes.

### Open-questions

1. **The CD domain instances are now the gating item for Stage 2, and they are
   mine.** `test/attack_plans/CD-xgmii_rx_64_cosim.md` §9 still reads *"frozen for
   Phase 1 as written"*, and §6.2 of the new packet makes a case void if it runs
   before its instance is committed. **That is a dv_lead round that does not
   exist yet.** Recommend it be scheduled between Stage 1 and Stage 2 rather than
   discovered as a blocker when Stage 2 is dispatched.
2. **Whether Stage 1 should be issued before or after the `SO-` round.** The
   packet does not decide it and cannot: Stage 1 pays four repairs the `SO-`
   would otherwise have to cite around, but the `SO-` is also the named practical
   owner of three routed items (`FINDING K-1`, `RN-6`, the census repair's
   ownership). **A sequencing call for the orchestrator, and it wants the two
   orders priced against each other rather than defaulted.**
3. **C3's branch γ is the likeliest spec-diff trigger this programme has
   scheduled.** If the reference drops bad-FCS frames, REQ-901 needs a seventh
   declared class by spec diff through architect_docs_lead, and family D's whole
   subject matter leaves the comparison domain. **Worth warning architect_docs_lead
   that the request may be coming, before it arrives as a surprise inside a
   stage.**
4. **`FINDING WO-0078-1` is a claim I could not test.** Whether `$finish` leaves
   `vvp`'s exit status at 0 is the sort of thing one run settles and no amount of
   reading does. If the orchestrator has a cheaper way to settle it than Stage 1's
   self-test — a one-line CI probe, say — it is worth settling early, because the
   repair's shape depends on the answer.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md

## [J-dv_lead-0150] 2026-08-11T11:30Z | task:WO-0078 | Stage 1 accepted on both halves — and the freeze it exists to protect was pinned against a run that already carried the change, so I re-anchored it against the last run that did not

### Trigger

Orchestrator dispatch, sole agent in flight: `RV-STAGE1`, the review my own packet
schedules at §6.1/§9 for the stage's two landings, and the round that flips the
`State` field at the packet's head per §14's own note. Two halves to review:
tb_writer's at `3ec0efe` (`J-tb_writer-0033`) and data_wrangler's at `8c6429e`
(`J-data_wrangler-0005`).

**HEAD verified as my first action, before reading anything**: `git rev-parse
HEAD` → `8c6429ec0e36fe6aabab13d883c036cdae0b76ee`, exactly the spawn head.
Neither rollback disposition fired and no descendant check was needed.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, both in full.
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` in full — my own
  packet, including both Return logs appended since I wrote it.
- `agents/handoffs/WO-0075_cosim-lane-cycle-comparison.md` — `WO-0075` §§3, 6, 7,
  9, 11 and `RV-0075-VERDICT` §§4.1, 5, 6, 8, for the four owed repairs' original
  text and for my own verdict form.
- The two commits under review, read as diffs and as landed sources at `8c6429e`:
  `test/cosim/stimulus_gen.ml`, `canonical.ml`, `canonical.mli`, `compare.ml`,
  `ours_run.ml`, `tb_xgmii_rx_64.v`; `tools/cosim/run_cosim.sh`.
- `docs/specs/modules/xgmii_rx_64.md` §6.1 (the preamble-position paragraph, the
  idle-injection prohibition, *"Injection begins at the frame's first octet"*) and
  its §10 **REQ-016** hook — read **directly**, because tb_writer's re-measurement
  claimed text stronger than my own FI-14 quotation and I do not take a spec
  reading from a Return log. That hook is what grounds `FINDING RV-0078-S1-1`.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` §9, to confirm the freeze sentence is
  still there (it is).
- `agents/journals/workers/claude_tb_writer_agent.v02.md` `J-tb_writer-0033` and
  `agents/journals/workers/claude_data_wrangler_agent.md` `J-data_wrangler-0005`,
  `Inputs` sections in particular (charter §6 criterion 7).
- CI, read-only through the GitHub API: runs `31087657064` (`8c6429e`),
  `31084252734` (`3ec0efe`) and **`31080871169` (`55e16ae`)**, and the `cosim` job
  logs `92570843774` and **`92549154623`**.
- **NOT read**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`,
  `docs/reports/audit/**`. No expected value in this verdict comes from RTL; the
  successor rule I state in `FINDING RV-0078-S1-1` is derived from REQ-016's own
  row and SPEC-M03 §6.1 and from nothing else.

### Reasoning

**1. I did not accept the freeze on the freeze-checker's word, and that is the
whole reason this round was worth a lead's time.** Criterion 1 is the criterion
that fails the entire run when it fails, and Stage 1's green rests on it. But the
pinned literal `CASE0_PINNED_SHA256` was sourced from run `31084252734` at
`3ec0efe` — **after tb_writer's half had already landed**. That is circular by
construction: had the new case table moved case 0, the pin would have recorded the
*moved* value, the comparison would have matched, and criterion 1 would have
passed **vacuously and greenly**, with nothing in the log to distinguish that from
a real pass. So I fetched the last run that predates the widening entirely —
`31080871169`, job `92549154623`, commit `55e16ae` — and its `SUMMARY` prints the
same hash. Then I closed it a second way that needs no CI at all: everything in
`stimulus_gen.ml` from byte 0 through `write_stimulus`'s closing `;;` is
byte-identical between `55e16ae` and `8c6429e`, 3 121 bytes either side. **Two
independent closures, one of them offline.** The verdict records the anchor run
and instructs every later round to cite *that run*, never the literal — because
from `8c6429e` forward the literal is the single point of failure for the whole
freeze and an edit to it defeats the freeze silently.

**2. The rejected alternative here was "the harness printed `[ok] byte-identical`,
so criterion 1 is discharged."** It is the reading the log invites and it is
exactly wrong: the harness can only compare against what it was told, and what it
was told came from a round that could have been the one that moved the thing. A
freeze check is only as good as the independence of its baseline, and that
independence is not visible from inside the run.

**3. `FINDING RV-0078-S1-1` is the finding I nearly did not make, and my own §5.4
caused it.** tb_writer changed the T1 guard from *any broken inter-word delta
refuses* to *exactly one refuses; two or more assert*. The premise is true — a
single injection breaks at most one delta. The conclusion is not: **two** idles at
two distinct interior positions break two deltas, carry `injected_idle_before_d0`
= 0, and are therefore asserted against §6.1's gapless formula — reddening a
conformant design. REQ-016's §10 hook says of exactly this: *"a wrapper asserting
it fails a conformant design, **and one did**."* I checked whether my packet
compelled the change and it did: §5.4 demanded case (e) *assert* on a ≥ 3-word
interior shift, and under the old guard no interior shift can assert — indeed the
only realisation that asserts has a **zero delta** (3/5/5), two words on one
cycle, physically impossible. **So I convict my own §5.4 rather than the worker's
reading of it**, and I state a successor rule instead of leaving the repair open:
with carried count `c` and `d_m = o_m − (admit_cycle + m + 3)`, refuse when
`c > 0`; pass when `d ≡ 0`; refuse when `d_0 = 0` and `d` is non-decreasing and
non-zero somewhere; assert otherwise. I checked it against all six landed
fixtures by hand before writing it down — (d) asserts, (e) asserts, (e′) refuses,
the carried case refuses, the clean case passes — **and it refuses the two-idle
stimulus the landed rule asserts.** A finding that names the defect and not the
repair costs the next round the same derivation I just did.

**4. Criterion 2's printed half exists in §12 and in no assignee's list, and I
found it by reading §12 against the DoD rather than against the log.** Neither
§6.1's item lists nor §11's boxes name *"the harness prints that case's frame-0
`admit_cycle` as 0"*, and the landed report prints an admit-cycle value only on
the T0-**red** path. Criterion 4 has the same shape: §12 says *"every accepted
frame in every case"* where my §5.1 said *"`spec_divergences = []`"*. **Both are
defects in my packet's decomposition, both bite at the same landing (C1 needs the
first, C2 needs the second), both have one owner and one file.** I record them as
one finding with two limbs for that reason, and I make Stage 2's dispatch
conditional on commissioning them — a criterion assigned to nobody is not a
criterion, and discovering that at C1 would mean discovering it with C1's answer
already in hand.

**5. On the wildcard, I amended my own §6.1 rather than let Stage 2 meet the
contradiction.** §6.1 asked for a per-case working directory *and* zero `+`/`-`
lines inside a `*)` arm whose body names `$WORK/run1` literally. At one case both
hold; above one they cannot. The worker took the reading that preserves the
harder-pinned requirement and **flagged the collision in the round that could
still be believed about it**. The right response is not to praise the flag and
leave the trap set: the byte-identity form was a *proxy* for a behaviour, adopted
when a proxy was free, and **a proxy that forbids the rename its own container
requires has outlived its subject.** So I retire it as of Stage 2's first landing
and replace it with the behaviour it stood for — last arm, dumps the case's
directory, reports `EXIT_INTERNAL` and never a differential or timing code, never
falls through.

**6. On OQ2 I accepted the exception and refused the argument offered for it.**
The worker justified the wildcard's lost per-case line partly on the branch being
unreachable. **Unreachability is not a ground I will put in the record**: a branch
whose only defence is that it cannot fire is a branch nobody notices when it does,
and this lane has already been surprised once by a guard nobody had run
(`FINDING WO-0078-1` is that surprise, in this very packet). The ground I accept
is that a `tier=` for a code the script cannot classify would be a *fabricated*
classification, and a fabricated tier is worse than an absent line. Then I added
the bound the worker did not state — at N > 1 that `die` also costs **every
subsequent** case its line — and folded it into the same amendment.

**7. Both disclosed extensions ruled in-packet-spirit, and the first one convicts
my own census.** §2.3's repair is a universal over producers; §2.2's six-row table
is *evidence* for it, not its definition — which is precisely `FINDING
WO-0077-A1`'s standing rule, the rule this packet was the first artefact drafted
under. A seventh instance found while executing the repair is inside the
universal. **And a worker executing my repair found a producer refusal my own
census missed**, which is the second time inside one packet that that repair has
paid. It does not move §6.3's staging argument (a file-open failure is not a
stimulus-admission guard), and I say so rather than let the correction imply more
than it does. The second extension is not an addition at all: a carried record
whose length can silently disagree with the frames admitted would make the carried
antecedent *worse* than the inferred one it replaces, so refusing is the only
disposition consistent with §5.2's own reasoning.

**8. What I refused to do.** I did not repair anything — §6.1 gives `test/cosim/`
and `tools/cosim/` to the assignees and a reviewer that repairs what it reviews
has stopped being one. I did not run a simulation (ADR-0005), and I did not treat
data_wrangler's scratchpad stub runs as evidence: they are disclosed worker
testing, they are not a CI result, and the verdict says so where criterion 3 is
read. I did not declare Band A met — **linearity cannot be measured at one case**,
and the honest statement is that nothing in the loop is superlinear *by
construction*, which is a reading of the control flow rather than a measurement.

### Actions

- Verified HEAD; read the charter, PROTOCOL, my own packet in full, both Return
  logs and both worker journal entries.
- Reviewed both diffs line by line against §6.1's item lists and §11's DoD boxes.
- **Four mechanical re-derivations of my own**, none taken from a Return log:
  (a) the `*)` wildcard arm extracted from `3ec0efe` and `8c6429e` and compared
  character for character — equal, indentation included; (b) `stimulus_gen.ml`'s
  prefix through `write_stimulus` compared between `55e16ae` and `8c6429e` —
  byte-identical, 3 121 bytes; (c) the self-test's mandatory `&&`-chain read in
  source to confirm neither new case is optional; (d) `timing_report_to_string`
  and `report_to_string` read to establish that no `admit_cycle` value is printed
  on the clean path.
- Read three CI runs and two job logs read-only through the GitHub API. The
  direct `curl` route to the job-logs endpoint 302s to a
  `productionresultssa*.blob.core.windows.net` host this session's egress denies
  with `403`; used the server-side logs tool instead — a different transport onto
  the same public artefact, not a retry of a policy denial. The same workaround
  data_wrangler journaled, independently reproduced.
- **Wrote two things and nothing else**: the `RV-STAGE1` verdict appended to
  `WO-0078` §14, and the `State` field at that packet's head, flipped to
  **STAGE 1 — ACCEPTED** with Stage 2 authorised-not-issued and Stage 3
  scoped-not-authorised. The prior `DRAFT` text is preserved inside the field
  rather than overwritten, because a lifecycle field that erases its own history
  cannot be audited. **No `test/**`, no `tools/**`, no `test/attack_plans/**`.**
- Ran no git command that writes.

### Evidence

All CI references are externally verifiable at the run/job ids given
(ADR-0003/F5); the four re-derivations are runnable from a checkout at `8c6429e`.

- **`git rev-parse HEAD`** → `8c6429ec0e36fe6aabab13d883c036cdae0b76ee`.
- **Run `31087657064`** (workflow "build", head_sha `8c6429e`) — `conclusion:
  success`. Job `92570843774` (`cosim`) success, step *"Run the co-simulation lane
  (WO-0046 Phase 1)"* 09:10:34 → 09:10:40. Job `92570843776` (`build`) success.
- **Job `92570843774` log, quoted verbatim** —
  `=== CASE SET (WO-0078 §6.1 Stage 1: 1 case(s) — 0) ===`;
  `[ok]   case 0's stimulus is byte-identical to the last green pre-widening run`;
  `CASE 0: stimulus_sha256=c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051 compare_exit=0 tier=CLEAN`;
  `T1: clean -- …` then `frame 0:` / `word 0: expected 3, observed 3` … `word 7:
  expected 10, observed 10`; `=== AGGREGATE (WO-0078 §3.3) ===` then `every case
  in the set reached a verdict and every verdict was clean.`;
  `[cost] case 0 pipeline wall time (run1): 0.635s`;
  `[cost] run_cosim.sh wall time (this invocation): 6.273s`; `compare --self-test:
  OK` after ten `PASS` lines including `(e)` exit 4, `(e')` exit 6, the
  carried-idle case exit 6 and the refusal sentinel exit 3; and
  `[case 0 run1] vvp: …/tb_xgmii_rx_64.v:389: $finish called at 234600 (1ps)` on a
  run that then proceeds green — the observation that settles
  `J-dv_lead-0149` Open-question 4 in the finding's favour.
- **Run `31084252734`** (`3ec0efe`, tb half alone) — both jobs `success`.
- **Run `31080871169`, job `92549154623`, commit `55e16ae` — the pre-widening
  anchor.** Log prints `stimulus sha256:
  c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051`, identical to
  the pinned value. **This is the citation the freeze rests on from now on.**
- **Re-derivation (a)**, wildcard byte-identity: the eight-line `*)` arm from
  `git show 3ec0efe:tools/cosim/run_cosim.sh` and from
  `git show 8c6429e:tools/cosim/run_cosim.sh` compare **equal**, character for
  character, including its two-space indentation.
- **Re-derivation (b)**, case 0 frozen: `git show
  55e16ae:test/cosim/stimulus_gen.ml` and `git show
  8c6429e:test/cosim/stimulus_gen.ml`, prefixes through `write_stimulus`'s closing
  `;;` — **identical, 3 121 bytes each.**
- **Re-derivation (c)**: `compare.ml`'s self-test returns 0 only under
  `a_ok && b_ok && c_ok && d_ok && e_ok && e'_ok && f_ok && t0_ok &&
  idle_carried_ok && refusal_ok` — neither new case optional.
- **Re-derivation (d)**: `canonical.ml`'s only `admit_cycle`-valued print is
  `"frame %d: admit-cycle mismatch (ours=%d, theirs=%d)"`, reachable only when T0
  is red. Nothing prints it on the clean path — `FINDING RV-0078-S1-2`(a).
- **Spec citation**, `docs/specs/modules/xgmii_rx_64.md` §10 REQ-016 hook, read
  directly: *"**Not** §6.1's gapless `m + 3` formula (C-14.4) and **not** §7's
  per-octet constant … a wrapper asserting it fails a conformant design, and one
  did."* This is the text `FINDING RV-0078-S1-1` rests on.
- **`test/attack_plans/CD-xgmii_rx_64_cosim.md`** at `8c6429e` still reads *"This
  document is frozen for Phase 1 as written."* — §13 item 1 remains open.
- **No simulator, no `dune`, no `iverilog` was run by me** (ADR-0005). Nothing in
  this entry is offered as a local execution result.

### Outcome

**DoD met for the round as commissioned.** Deliverables:

1. **`RV-STAGE1` appended to `WO-0078` §14** — ten sections: the CI reading at the
   source, the two line reviews against §6.1/§11, the two extension rulings, the
   two open-question rulings plus one amendment to my own §6.1, four numbered
   findings, the nine pass criteria read one disposition each, what the green does
   **not** mean, the next gate with its dated condition, and the verdict. ✔
2. **The `State` field flipped**: STAGE 1 — ACCEPTED (both halves); STAGE 2 —
   AUTHORISED, NOT ISSUED, conditional on §13 item 1 and on
   `FINDING RV-0078-S1-2`; STAGE 3 — SCOPED, NOT AUTHORISED. ✔
3. **Verdict: ACCEPT, both halves.** Four `RV-0075` repairs delivered;
   `FINDING RV-0075-1`, `FINDING RV-0075-2` (for the class it named) and
   `RV-0075-VERDICT` §4.1's case-(e) defect **CLOSED**;
   `RV-0075-VERDICT` §4.1(b)/(c)'s dated successor code **DELIVERED**. ✔
4. **Four findings raised**, all MINOR at this tree, none blocking Stage 1, each
   with an owner and a carrier: `-S1-1` (T1's guard fail-open in the multi-break
   direction; successor rule stated; tb_writer; owed before any idle-injecting
   case), `-S1-2` (criteria 2 and 4 assigned to nobody; tb_writer; **blocks
   Stage 2's dispatch until commissioned**), `-S1-3` (the cost probe times one of
   two runs; Band A's linearity clause unmeasurable at N = 1; data_wrangler),
   `-S1-4` (criterion 7's producer half unexecuted; no repair owed until C9). ✔
5. **Three of the four are defects in my own packet, not in either half's work**
   — `-S1-1`'s proximate cause is §5.4, `-S1-2` is §6.1/§11's decomposition, and
   the wildcard collision is §6.1's. Said plainly, in the verdict, where a later
   reader meets it. ✔

**Harvest.** **Not due this round and the span stays open** — PROTOCOL §7 places
the harvest at every `SO-` and every phase gate, and this is a review verdict.
**Banked, not minted**, two candidates, taking the running set to twelve:

- **Candidate (K)**: *a frozen baseline recorded as a literal inside the artefact
  that enforces it has no independent anchor; the record must cite the run that
  produced the value, and a review that accepts it must re-read that run rather
  than the literal.* **LH1**: this round's own commits — the pin was taken from a
  run at a revision that already carried the change the pin exists to detect, and
  only re-reading the last revision that did not carry it closed the circle.
  **LH2-g** holds: no proper noun of any kind in the rule statement. **LH3**:
  without it, a freeze check passes vacuously whenever the pinning round is
  downstream of what it freezes against, and the passing run contains nothing that
  distinguishes that from a real pass.
- **Candidate (L)**: *when a fixture is rebuilt to separate two dispositions a
  guard could not tell apart, the guard's new predicate must be checked against
  every input the narrowing now admits, not only against the two fixtures it was
  rebuilt to separate.* **LH1**: this round's (e)/(e′) split, which closed one
  blind direction and opened another. **LH2-g** holds. **LH3**: without it, a
  repair proves only that two fixtures differ, and the suite that proves it is the
  same suite that will pass while the guard admits a conformant subject as a
  defect.

**Handoff**: the two files below go to the orchestrator for commit under trailer
`Agent: dv_lead`, `Work-Order: WO-0078`, `Journal-Entry: J-dv_lead-0150`. The
verdict is verbatim-relay material for both workers.

### Open-questions

1. **`§13 item 1` is now the immediate next gate and nothing stands in front of
   it.** `CD-xgmii_rx_64_cosim.md` §9 still reads *"frozen for Phase 1 as
   written"*, and §6.2 makes any case that runs before its domain instance is
   committed **void — re-run, not adjudicated**. The condition is dated in this
   programme's idiom: **owed before Stage 2's first case runs, i.e. before the
   C1+C2 landing is dispatched, not before it is reviewed.** It is a dv_lead round
   of its own and it does not exist yet.
2. **Stage 2's dispatch now carries three preconditions, not one**, and the
   orchestrator should see them together: the CD instance (item 1);
   `FINDING RV-0078-S1-2`'s printer repair, both limbs, commissioned to tb_writer;
   and §5's replacement of the wildcard byte-identity requirement with its
   behavioural successor, which I restate in the dispatch.
3. **The sequencing question from `J-dv_lead-0149` Open-question 2 is still
   open and is now sharper.** Stage 1 has paid four repairs, so the `SO-` no
   longer has to cite around them — but the `SO-` remains the named practical
   owner of `FINDING K-1`, `RN-6` and `FINDING WO-0077-A1`'s census ownership, and
   `FINDING RV-0078-S1-1` has just added a fourth item whose natural carrier is
   whichever round next opens `test/cosim/canonical.ml`. **If that round is the
   Stage-2 landing, one dispatch can carry `-S1-1` and `-S1-2` together.** Worth
   pricing before Stage 2 is dispatched rather than after.
4. **`FINDING RV-0078-S1-1` deserves a second reader.** It is a claim that a
   landed, green, self-tested guard admits a conformant design as a defect on a
   stimulus nothing currently drives — exactly the shape that is easy to assert
   and hard to falsify until the stimulus exists. The derivation is written out in
   the verdict against REQ-016's own row so that it can be checked rather than
   trusted, and I would rather the auditor check it now than have it discovered at
   the first idle-injecting case.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md
