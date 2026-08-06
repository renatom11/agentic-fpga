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

## [J-dv_lead-0151] 2026-08-06T09:42Z | task:WO-0078 | The Phase-1 freeze discharged by the per-run clause it was always a special case of — four domain instances frozen before any is dispatched, and my own §7 convicted of leaving the likelier of two outcomes with no branch at all at C3 and C4

### Trigger

Orchestrator dispatch, CD-INSTANCE round. The commission is `WO-0078` §13 item 1
— *"`CD-xgmii_rx_64_cosim.md`'s co-sim Phase 2 and Phase 3 domain instances …
**dv_lead's own**, and a **hard precondition** on §6.2 … Owed before Stage 2's
first case runs, in a dv_lead round of its own"* — restated by my own
`RV-STAGE1` §9 as the **immediate** next gate with nothing standing in front of
it, and by that verdict's Open-question 1. `WO-0078` §6.2's stop rule makes a
case that runs before its instance is committed **void — re-run, not
adjudicated**, so this round is what stands between the programme and a Stage-2
dispatch whose result could not be used.

**HEAD verified as my first action, before reading anything**: `git rev-parse
HEAD` → `965f6ee39382a3fa991c8a87783eceab79f1dd45`, exactly the spawn head
(`RV-STAGE1` landed). Neither rollback disposition fired and no descendant check
was needed.

**A declared sibling was in flight** (tb_writer, repairing `FINDING
RV-0078-S1-2` in `test/cosim/**`). I opened no file in `test/cosim/`, no worker
journal and **not the `WO-0078` packet** — which is the one restriction that cost
this round something, and §5 of Outcome below says what and where it is routed.

### Inputs

Read this round, all read-only, none of it RTL:

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4.1–4.2, §6, §7, §10).
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` **in full** at `965f6ee` — the
  document this round writes into: §0's freeze discipline and its move rule,
  §0-bis's ruling that REQ-901 governs the permitted set, §0-ter's three-scope
  table, §1's governing clause, §2/§2-bis, §3's transaction form, §4, §5.1/§5.2,
  §6's V1–V7, §7, §8's Phase-1 instance, §9's four-item change discipline.
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — §0.1, §1
  (FI-1/-2/-9/-10/-13/-14), §2.2, §3.1–3.3, §4.2, §6.1–6.3, **§7 in full**, §8,
  §13, and my own `RV-STAGE1` in §14 (§1's citation rule, §6's four findings, §7's
  criterion table, §8, §9). **Read, not written** — the sibling holds §14.
- `docs/specs/requirements.md` — **§0.3** (gap convention, the 84-octet budget),
  **REQ-005**, **REQ-101**, **REQ-102**, **REQ-103**, **REQ-104**, **REQ-107**,
  **REQ-108**, **REQ-901** (classes (a)–(f) and the 64-to-1518 sentence).
- `docs/specs/modules/xgmii_rx_64.md` — **§6.1** (start lanes, preamble
  positions, the injection clause), **§7** (the ΔC table at both start lanes),
  **§9** (the error table, row 1).
- `test/xgmii/arrival.mli` header only — DV-side (REQ-018's link-partner model),
  for the `?ifg`/`?first_start` contract `WO-0078` FI-2 states. **Not RTL.**
- `agents/journals/claude_dv_lead_agent.v07.md` — `J-dv_lead-0149` and
  `J-dv_lead-0150` (the banked-candidate set and the open questions this round
  inherits).

**No `libs/**`, no `top/**`, no `rtl_snapshots/**`, no `test/cosim/**`.** Every
expected value written into §10 is derived from frozen spec text named above.

### Reasoning

**1. The lift had to come from the document's own text, and it did — from §0, not
from §9.** §9's sentence is *"This document is frozen for Phase 1 as written."*
The tempting reading is that lifting it is a governance act needing an ADR or an
architect ruling. It is not, and the reason is one clause earlier: **§0 says *"The
domain is frozen **before each run**"* — a **per-run** obligation.** §9's sentence
is that obligation's instance for Phase 1's run, not a bar on later instances.
Read as a bar it would make this lane unable to **advance** rather than unable to
**fail**, which inverts the property §0 exists to protect. So the lift is: §8's
instance becomes permanently frozen (it has been probed — `30988038809` at
`2dbd39b`), and the document opens **for addition only**. I wrote it as §9's own
four items in §9's own order, in an annotation **beside** §9 rather than an edit
inside it, which is §0-ter's form at its second use.

**2. Rejected: editing §9's sentence to say "for Phase 1 and Phase 2".** It is one
character-count cheaper and it is the exact failure this document has already paid
for twice — §0-ter's left-standing summary and `run_cosim.sh`'s propagated
"EMPTY" comment. A frozen sentence that gets re-scoped in place leaves no record
of what it meant when the run that probed it happened. **Rejected: a new file.**
The stop rule names *this* document; splitting the domain across two files is how
a comparison ends up with two answers.

**3. Freezing all four instances in one commit, when the stop rule is per case.**
`WO-0078` §6.2 lands C1+C2, then C3, then C4, and requires only that each case's
instance precede *that* case. I froze all four now anyway, and the argument is not
convenience: **C3's and C4's predictions written after C1+C2 had run would be
predictions written with partial knowledge of the reference's behaviour.** §7's
own discipline — *"an unpredicted divergence is a finding against **this
document**"* — is only worth something if the prediction predates every result it
could have been fitted to. One commit, four instances, none of them run.

**4. The finding I did not expect to make, and it is against my own packet.**
Writing C3's instance I went to copy §7's branch structure verbatim and found the
*"branch if the prediction holds"* cell is **"—"**. C1 and C2 are coherent — their
prediction column asserts **agreement**, so holds → α and fails → γ. C3's and C4's
prediction column asserts a **divergence** (*"the reference may DROP it"*, *"the
reference may reject the frame"*), so the same two column headings now say that
the divergence is the prediction **failing** and that the prediction **holding**
selects nothing at all. **Agreement at C3 or C4 has no branch**, against §7's own
opening sentence *"every case's result resolves to exactly one"*.

**Why I graded it material rather than a typo.** §10.0's own arithmetic makes it
one: every frame in this stage is 64 octets, REQ-901's (e) and (f) *"exclude
nothing in the 64-to-1518-octet range"*, and (a)–(d) have no instance at this
boundary — so **branch β is unreachable in co-sim Phase 2** and C3's outcome space
is exactly two-valued. **A table that names a branch for one of two possible
outcomes leaves the adjudicator to pick the other after the run**, which is
verbatim what §12 criterion 8 voids a case for and what §0 exists to prevent. The
blank is not a missing decoration; it is the half of the table a green result
would land in.

**How I resolved it without amending anything.** §7's branch **definitions** —
not its table — already decide it: α is *"the observable agrees inside the
domain"*. So the agreement outcome **is** α by §7's own words, and §10.3/§10.4
read it so while carrying §7's γ text and its blank **verbatim**, with the blank
labelled as the finding rather than silently filled. No expected value moves and
no prediction is rewritten. **And I bounded the reading in the document**: naming
α does **not** predict agreement — §7's frozen prediction says the reference may
drop the frame, and a prediction may not be sharpened after it is frozen. The
branch is a home for an outcome, not a forecast of one. Recorded as
`FINDING CD-P2-1`, MINOR, mine, carrier the Stage-2 dispatch; noted as reaching
§7's C8 and C9 rows too, where no repair is owed because Phase 3 is
scoped-not-authorised and this document carries no Phase-3 instance.

**5. Three things I checked against spec rather than carrying from my own packet,
because a domain instance that quotes its own work order is not an instance.**
(a) **C1's absolute cycles.** SPEC-M03 §7's table pins ΔC = **3 at both start
lanes** — (L + h) = 24 in both rows — so §6.1's gapless `admit_cycle + m + 3` with
`admit_cycle` = 0 gives `{3 … 10}` at a lane-4 start exactly as at lane 0. §7's
C1 cell survives its own re-derivation. I also wrote down the trap beside it:
**REQ-101's verification column permits a one-cycle difference between our own two
start lanes and SPEC-M03 §7 pins it tighter**, so a T1 red at C1 is adjudicated
against §7's table on the ours-vs-spec axis and is **never** a co-simulation
divergence. (b) **C3's delivered count.** §9 row 1 forwards the frame; REQ-104's
verification column says *"the same octet count is delivered"*; REQ-103's
no-FCS-removal exceptions are REQ-105, REQ-108 and REQ-110 aborts and **a bad FCS
is not among them** — so 60 delivered octets, marked, not 64. (c) **C2's second
start lane.** §0.3's own budget arithmetic — 8 + 64 + 12 = **84 octet times =
10.5 cycles** — puts frame 1's start character in **lane 4**. That matters: C2
drives a lane-4 start as a by-product, and I wrote into §10.2 why that does
**not** make C1 redundant (C2's lane-4 frame is the second frame at a non-zero
admit cycle, so a red there could not be attributed between the start lane and the
re-arm path).

**6. X4 at C4 — recorded, not moved.** C4's whole observable is the
accept-or-discard decision, and §5.2's X4 excludes *"preamble and SFD octet
values"*. The trap is reading X4 as covering C4's result: it does not. **Those
octets are stripped by REQ-102 and appear in no delivered stream on either side**,
so X4 removes nothing from the delivered-octet comparison — and **it does not
exclude the decision those octets cause**. If the reference validates the preamble
and rejects the frame, that is a decision divergence inside REQ-901's list and
outside every declared class: **γ**, exactly as §7's C4 cell says. I recorded that
scope beside the instance and recorded, per §9 item 4, that **no run has probed
X4** — family B's stimulus has never been driven here — so even had this been a
narrowing it would have been lawful. It is not one: no entry moves.

**7. The citation rule from my own `RV-STAGE1` §1 binds and is written into
§10.0.** The freeze's anchor is **run `31080871169`, job `92549154623`, at
`55e16ae`** — the last green run predating the widening — **never the
`CASE0_PINNED_SHA256` literal inside the file the freeze constrains**. I
deliberately did **not** copy the hash value into the CD: a second literal is a
second thing that can drift, and `RV-STAGE1` §1 already carries it with its
provenance.

**8. Dating, and a records defect I found while deciding it.** §0-ter is headed
*"(2026-08-09 …)"*; the commits carrying this document's history are dated
**2026-08-06** by git, and this journal volume heads `J-dv_lead-0149`/`0150`
**2026-08-11** against commits (`beb9c2a` … `965f6ee`) all dated 2026-08-06. **A
calendar literal that disagrees with its own commit is not a date but a second,
weaker record of one.** I had three options: copy the drifted convention (writes a
known-false field), silently reconcile it (an edit inside frozen sections, barred),
or **assert no calendar date and let the commit date the annotation** — which is
`WO-0078`'s own dating rule, written for exactly this. I took the third, said so
in §9-bis, and recorded the drift as `FINDING CD-P2-2` (MINOR, records defect,
nothing adjudicated rests on it). **This entry's own header carries the machine
clock (`date -u`), not the drifted convention**, and the resulting apparent
backwards jump from the previous entry's header is the drift becoming visible
rather than a new error — which is why it is flagged here and in Open-question 3
rather than smoothed over.

### Actions

- Verified HEAD; read the charter, the protocol, the CD in full, `WO-0078`
  (§§0–13 and §14's `RV-STAGE1`), and the spec sections listed in Inputs.
- **Appended two sections to `test/attack_plans/CD-xgmii_rx_64_cosim.md`, a pure
  end-of-file append — 467 lines added, 0 removed, nothing above the previous EOF
  touched:**
  - **§9-bis** — the Phase-1 freeze discharged, written as §9's four items in
    §9's own order (the section; what moved — *no entry, in either direction*; the
    four justifying clauses, §0's per-run sentence first; and the probe question
    answered **separately for the freeze sentence's area (YES, Phase 1 ran) and
    for §10's area (NO, nothing has ever been driven)**), plus the dating rule and
    a four-item *what this lift does NOT do*.
  - **§10** — co-sim Phase 2's domain instances. §10.0 (what binds every instance:
    §0's bar restated verbatim per case, the empty permitted set **at the scope of
    these four instances**, β shown unreachable, the run-`31080871169` citation
    rule, the void rule); **§10.1 C1**, **§10.2 C2**, **§10.3 C3**, **§10.4 C4**,
    each with its stimulus, its spec-derived inside-domain expectation, its named
    exclusions and its **frozen prediction and branch carried verbatim from
    `WO-0078` §7**; **§10.5 `FINDING CD-P2-1`**; **§10.6 `FINDING CD-P2-2`**;
    **§10.7 what §10 does not do** (seven prohibitions, including that it lifts
    `AP-M03` §7 bar 1 for **nothing** by itself).
- Opened no file in `test/cosim/`, no worker journal, and not the `WO-0078`
  packet — the sibling holds all three this round.
- Ran no git command that writes. **Executed no simulation** (ADR-0005).

### Evidence

Every command below is runnable from a checkout at this commit; the CI references
are externally verifiable at the run/job ids given (ADR-0003/F5).

- **`git rev-parse HEAD`** → `965f6ee39382a3fa991c8a87783eceab79f1dd45` — the
  spawn head, unmoved.
- **`git diff --numstat test/attack_plans/CD-xgmii_rx_64_cosim.md`** →
  `467  0  test/attack_plans/CD-xgmii_rx_64_cosim.md`. **Zero deletions: the edit
  is a pure EOF append and no frozen section is touched.**
- **`git status --short`** → my one file, plus `test/cosim/canonical.ml`,
  `canonical.mli` and `compare.ml` **modified by the declared sibling in the same
  working tree**. I staged nothing and touched none of those three; the commit
  carrying this entry must contain **only** the file listed below (PROTOCOL §5
  R1/R4).
- **`grep -n '^## ' test/attack_plans/CD-xgmii_rx_64_cosim.md`** → the previous
  section list unchanged through `## 9. Change discipline` at line 381, then
  `## 9-bis …` at 390 and `## 10. …` at 469.
- **Spec citations, each re-read directly this round** —
  `docs/specs/modules/xgmii_rx_64.md` §7: *"| lane 0 | 8 | **16** | **3** cycles
  | 4 |"* and *"| lane 4 | 12 | **12** | **3** cycles | 4 |"*, with *"(L + h) = 24
  in both rows"*; §9 row 1: *"Received FCS does not match the computed residue |
  `error_bad_fcs` | frame forwarded in full, `tuser`[0] = 1 on `tlast` |
  REQ-104"*; `docs/specs/requirements.md` REQ-104: *"the same octet count is
  delivered"*; REQ-103: *"a frame aborted under REQ-105, truncated under REQ-108
  or cut short under REQ-110 delivers every octet decoded up to its abort point,
  with no FCS removal attempted"* (a bad FCS is in none of the three); REQ-101:
  *"SHALL produce identical output streams for the same frame received at either
  alignment"* and its verification column's *"The absolute cycle of the first
  output word may differ by one cycle between the start lanes"*; REQ-102's
  verification column: *"Drive a frame whose six preamble filler octets and SFD
  octet are arbitrary data values"*; §0.3: *"8 octets of preamble and SFD, 64
  octets of frame and 12 octets of gap = **84 octets = 10.5 cycles**"*; REQ-901:
  *"Classes (e) and (f) exclude **nothing** in the 64-to-1518-octet range"* and
  *"an exclusion is never a licence to take an expected value from the
  reference"*.
- **The freeze anchor, cited as `RV-STAGE1` §1 requires and not from the
  literal**: `build` run **`31080871169`**, job **`92549154623`**, commit
  **`55e16ae`** — the last green run predating the widening. **Not re-quoted as a
  hash value anywhere in the CD**, deliberately.
- **The Phase-1 probe, for §9-bis item 4**: `build` run **`30988038809`** at
  `2dbd39b`, `cosim` job **`92247281222`** (as §0-ter records).
- **The no-run claim for §10's area** rests on `RV-STAGE1` §8 items 1–2 at
  `8c6429e` — *"The landed case set is `{case 0}`"*, *"The one-frame stimulus
  bound is UNCHANGED"* — and on run `31087657064`'s log line
  `=== CASE SET (WO-0078 §6.1 Stage 1: 1 case(s) — 0) ===`.
- **No simulator, no `dune`, no `iverilog`, no `git` write command was run by
  me.** Nothing in this entry is offered as a local execution result.

### Outcome

**DoD met for the round as commissioned.** Five items:

1. **The freeze lifted lawfully and dated by this commit** — §9-bis, written as
   §9's own four items, in an annotation beside §9 rather than an edit inside it,
   with the probe question answered separately for the two areas it covers. ✔
2. **Four co-sim Phase 2 domain instances committed — C1, C2, C3, C4 — each with
   its spec-derived inside-domain expectation and its frozen prediction and branch
   carried verbatim from `WO-0078` §7.** All four before any is dispatched, which
   is stronger than the per-case stop rule requires. ✔
3. **§0's bar is the operative rule for every instance, restated verbatim and
   per case**, with the two γ routes (a `BUG-` or a REQ-901 spec diff) named as
   the only resolutions and an entry here excluded explicitly. ✔
4. **Two findings raised against my own artefacts, neither against any
   assignee's work**: `FINDING CD-P2-1` (§7's branch table leaves C3's and C4's
   agreement outcome unbranched and its holds/fails polarity reads backwards;
   MINOR; mine; carrier the Stage-2 dispatch and the first C3/C4 `RV-`) and
   `FINDING CD-P2-2` (§0-ter's calendar literal disagrees with its commit; MINOR,
   records defect). ✔
5. **`WO-0078` §13 item 1 is discharged for co-sim Phase 2 and DECLARED OPEN for
   co-sim Phase 3.** §6.3's re-authorisation gate (b) stays unmet and §9-bis and
   §10.7 both say so rather than omitting it. ✔

**The one thing this round could not do, routed rather than done.** The sibling
holds the `WO-0078` packet, so I did not open it. **Owed to the next round that
may write it**: the `State` field's Stage-2 precondition *"it may not be issued
until §13 item 1's CD domain instance is committed"* is **discharged by this
commit** for co-sim Phase 2, and §13 item 1 should be marked so with this entry's
id. **This is a record, not a permission**: Stage 2's dispatch still carries its
other two preconditions (`FINDING RV-0078-S1-2`'s printer repair, both limbs, and
§5's wildcard successor), and neither moves here.

**Harvest.** **Not due this round and the span stays open** — PROTOCOL §7 places
the harvest at every `SO-` and every phase gate, and this is neither. **Banked,
not minted**, two candidates, taking the running set from twelve to fourteen:

- **Candidate (M)**: *a decision table keyed on whether a prediction "holds" or
  "fails" must enumerate a branch for every outcome the subject can physically
  produce, not for every way the prediction can be graded; where the prediction
  asserts a difference, its two gradings are not the two outcomes.* **LH1**: this
  round's `FINDING CD-P2-1` — two rows whose prediction was of a divergence left
  the agreement outcome with no branch, in a table whose own prose says every
  result resolves to exactly one. **LH2-g** holds: no proper noun of any kind in
  the rule statement. **LH3**: without it the unbranched outcome is adjudicated
  after the run, and the adjudication is invisible because the table looks
  complete — which is the failure a frozen prediction exists to prevent.
- **Candidate (N)**: *a document that must be frozen before each use should state
  its freeze per use, not per era; a freeze stated as an era ends by argument, a
  freeze stated per use ends by the next use existing.* **LH1**: this round — the
  same document carried both forms, and the per-use sentence discharged the
  per-era one without an amendment. **LH2-g** holds. **LH3**: without it every
  later use pays a governance round to prove it is allowed to add, and the
  cheapest way through that round is to edit the frozen text in place rather than
  add beside it.

**Handoff**: the two files below go to the orchestrator for commit under trailer
`Agent: dv_lead`, `Work-Order: WO-0078`, `Journal-Entry: J-dv_lead-0151`. The
sibling's `test/cosim/**` changes are a **separate commit under its own agent**
(PROTOCOL §5 R1) and are not mine to stage.

### Open-questions

1. **`FINDING CD-P2-1` wants the second reader `FINDING RV-0078-S1-1` also
   wanted.** It is a claim that a table I wrote is incomplete in the half a green
   result would land in, and I resolved it from the same document's prose. If the
   auditor reads §7's C3/C4 cells and concludes the *"—"* meant something I have
   not seen — for instance that agreement at C3 was thought impossible — then my
   §10.3/§10.4 have named a branch the packet deliberately withheld, and that is a
   different and worse defect than the one I recorded. **I would rather that be
   checked before C3 runs than after.**
2. **The Stage-2 dispatch now carries two preconditions, not three.** This commit
   discharges §13 item 1 for co-sim Phase 2. Outstanding:
   `FINDING RV-0078-S1-2`'s printer repair (both limbs — and limb (a) is what
   makes §12 criterion 2 checkable at C1, which is §10.1's own note), and §5's
   replacement of the wildcard byte-identity requirement. `J-dv_lead-0150`
   Open-question 3's pricing question — whether one dispatch carries
   `-S1-1` and `-S1-2` together — is unchanged and still worth answering **before**
   the dispatch.
3. **The date drift is real and is now recorded in two places.** This journal's
   entries and the CD's §0-ter carry calendar literals (2026-08-11, 2026-08-09)
   that disagree with the commits carrying them (2026-08-06 by git). **This entry
   uses the machine clock**, so its header appears to move backwards from the
   previous entry's — deliberately, and flagged here so it is not read as a
   transcription error. Whether the convention is corrected going forward, and by
   whom, is the orchestrator's call; **no committed adjudication rests on any of
   these literals**, which is why I recorded it as MINOR and repaired nothing.
4. **Co-sim Phase 3's domain instance is owed and unwritten**, and `WO-0078`
   §6.3's gate (b) will block Stage 3's re-authorisation until it exists. It is
   deliberately not written here: C5–C9's predictions should be frozen against
   whatever co-sim Phase 2's four results turn out to be **only** in the sense that
   the round writing them will know more about the harness — **not** about the
   reference's dispositions on those classes, which §7 has already frozen.

### Files-in-this-commit

- test/attack_plans/CD-xgmii_rx_64_cosim.md

## [J-dv_lead-0152] 2026-08-06T11:32Z | task:WO-0078 | Lane 4 agrees and the two-frame case never reached the comparison — because my census wrote down what each guard's message says instead of what state it tests, and the minimum gap puts the next frame's start on the exact cycle the first frame's last word comes out

### Trigger

Orchestrator dispatch, `RV-C1C2` round: adjudicate Stage 2's first landing
(§6.2's C1+C2 pair), which has RUN. Two commits returned — `a822f46`
(tb_writer's stimulus half, `J-tb_writer-0035`) and `53fa1de`
(data_wrangler's runner half, `J-data_wrangler-0006`) — and the run is red at
the `cosim` job with one case clean, one case never reaching a comparison at
all. Sole agent in flight.

**HEAD verified as my first action, before reading anything**: `git rev-parse
HEAD` → `53fa1de2814e4841715ddeaa2b79590afd5ece41`, exactly the spawn head.
Neither rollback disposition fired and no descendant check was needed.

### Inputs

Read this round, all read-only except the two files in Files-in-this-commit:

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4.1–4.2, §5, §6, §7,
  §10).
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — header/`State`,
  §0.1–0.2, §2.1–2.3, §3.1–3.3, §6.1–6.3, §7 in full, §8, §9's cost bands, §12's
  nine criteria, §13, and §14's four prior entries (my own `RV-STAGE1`, the
  Stage-1 repair round, and both Stage-2 Return logs).
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` in full at `53fa1de` — §0's freeze
  discipline and move rule, §0-bis, §0-ter, §1, §2/§2-bis, §3's transaction form,
  §5.1/§5.2 (X1 and X4), §6's V1–V7, §8, §9 and §9-bis's four items, **§10.0
  through §10.7**.
- **CI, through the server-side GitHub logs tool** (the direct log leg 302s to a
  `productionresultssa*.blob.core.windows.net` host this session's egress denies
  with `403` — the same blocked transport `RV-STAGE1` §0 recorded): `build` run
  **`31096150983`** at `53fa1de` (conclusion `failure`), `cosim` job
  **`92598555141`** (`failure`, step 6) read line by line, and `build` job
  **`92598555210`** (`success`, all steps) read at its step list.
- **DV-side sources at `53fa1de`, read to diagnose the refusal**:
  `test/cosim/ours_run.ml` (`accumulate`, lines ~152–200),
  `test/cosim/tb_xgmii_rx_64.v` (the driving loop, ~285–370),
  `test/cosim/canonical.mli` (the `divergence` type, ~155–200),
  `tools/cosim/run_cosim.sh` (the exit-code table and the per-case loop).
  **All four are test/tooling files inside my own write scope. NO `libs/**`, NO
  `top/**`, NO `rtl_snapshots/**` was opened at any point in this round**, and no
  expected value below is derived from RTL.
- `docs/specs/requirements.md` §0.3 (the 12-octet gap counted from the terminate
  character inclusive) and REQ-901; `docs/specs/modules/xgmii_rx_64.md` §6.1
  (`admit_cycle + m + 3`), §7 (ΔC = 3 at both start lanes), §9 — as the frozen
  basis for §2 and §4 of the verdict.
- `agents/journals/claude_dv_lead_agent.v07.md` — `J-dv_lead-0150` and
  `J-dv_lead-0151` (the open questions and the banked-candidate set this round
  inherits).

### Reasoning

**Four decisions, and the second is the one this round exists for.**

**1. C1's branch, adjudicated on the terms frozen before the run rather than on
the colour of the run.** α is defined at §7 as *agreement inside the domain*, and
CD §10.1 adds one rider — T1's expected set unchanged from case 0's `{3 … 10}`. I
checked the two separately because they are different kinds of claim: the first is
a differential statement, the second an assertion of ours against SPEC-M03 §7 that
is deliberately **not** comparison content. Both hold on the printed record. I
also checked that *"divergences: none"* is a statement over REQ-901's whole
operative list rather than a subset, by reading `canonical.mli`'s `divergence`
constructors — `Missing_frame`, `Decision_mismatch`, `Word_count_mismatch` and
`Word_mismatch` over `tkeep | tlast | tuser0 | octets` — because an α selected on
a comparator that only compares octets would be worth nothing, and the whole
programme's last fortnight is about instruments that agreed vacuously.

**What I would not let α mean, and it is `FINDING RV-0078-S2-2`.** α is an
**agreement** predicate; CD §10.1 also states **absolute** expected values, and
this lane checks our side against none of them. From the printed record only two
of six are independently confirmed for our side (accept; 8 output words). A
common-mode error satisfies α and violates the instance. The mitigation is real
and lives in the X-1 bench family, not here — so the `SO-` must say per class
which instrument discharges which half rather than letting one green stand for
both. I recorded that instead of adding absolute checks to the comparator, which
would duplicate the bench family's job inside the instrument least able to justify
its own expected values.

**2. C2's refusal — the message names REQ-110 and the mechanism is not REQ-110's,
and I would not have found that from the log alone.** The stimulus is two
well-formed frames whose input-side spans do not overlap: CD §10.2's own
arithmetic puts frame 0's terminate at octet 72 (input line 9) and frame 1's start
at octet 84 (input line 10, lane 4). So on the input side a full cycle separates
them and REQ-110's condition — a second `/S/` **inside** an open frame — is never
presented. Reading `ours_run.ml` showed why it refused anyway: `open_frame` is
**set at the input start character** and **cleared only at the output `tlast`**,
so the state the guard tests spans `/S/ →` OUTPUT-`tlast` — the union of the two
frame spans — which at ΔC = 3 outlives the input terminate by exactly one cycle.
This same run measured frame 0's last output word at cycle 10 (case 0 is the
identical construction), and the minimum inter-frame gap puts frame 1's start
character on **cycle 10**. The two collide by one cycle, and the start-character
arm runs before the output word is attached inside one fold iteration.

**The part I nearly under-called.** My first instinct was "repair `ours_run.ml`".
Reading `tb_xgmii_rx_64.v` stopped it: `frame_open` there is set by the
`open_frame` task at the input start character and cleared in
`close_frame_accept` on `m_axis_tlast`, with the admission check ahead of the
drive — its own comment says *"exactly as ours_run.ml checks Xgmii_word.start_lane
before driving the same word."* **The reference side has the identical defect and
will refuse at the same line.** It did not this run only because `ours_run` runs
first and `run_pipeline` stops there. A repair to one producer would have moved
the refusal, not removed it, and the second red would have looked like a new
defect. So the repair is specified over **both** producers in one round, on §6.3's
own gate-(c) reasoning applied a stage early: two producers implementing one rule
from one written derivation is a review problem; from each other it is a
circularity.

**Why this is a defect in my packet and not in either half's work.** §2.2's census
enumerated **refusals** — file, line, message, trigger, effect — which is exactly
what `FINDING WO-0077-A1`'s standing repair asked for, and it is not enough. *"A
start character arriving while a frame is open"* is ambiguous between two spans
that differ by the pipeline latency, and I recorded the message rather than
measuring the state. §6.2's *"needs no accumulator change"* and CD §10.2's
restatement of it both inherit the error. **The census I was made to run by my own
worst finding is the thing that failed here, and it failed in the one way its own
form invited.**

**3. Where the T2 `+1` fact lives — and the CD ruling, which is a refusal to
write.** The reference delivers one cycle later at a lane-4 start (`theirs - ours
= [1 × 8]`, against `[0 × 8]` at case 0). That is CD §5.2 **X1**, outside the
domain: data, recorded, never adjudicated. The dispatch left me the option of
recording it — or C1's branch selection — in the CD, and I ruled against both, for
reasons I want in the diff rather than in my head. CD §10.7 item 3 says *"This
document freezes the questions; it answers none of them"*; a results record inside
a frozen-question document destroys the one property that makes a frozen
prediction worth anything, which is that a reader can tell a prediction from an
outcome without checking a date. §9-bis's addition-only lift is scoped in its own
words to *"co-sim Phase 2's domain instances"*, and a result is not one — using an
addition-only lift for content it did not name is precisely how such a lift becomes
general. And a restatement of a run's outcome can drift where the run cannot: that
is the left-standing-summary class §0-ter tabulates four payments for. `AP-M03` §7
is worse still: a recorded cross-side cycle datum sitting beside **bar 3**, which
forbids comparing cross-side cycles, is the exact shape a later reader misreads as
the bar having lifted. So the fact lives in the run (permanent, externally
verifiable), in this verdict (quoted with its status attached), and forward in the
`SO-`.

**And the thing I did not expect to be able to say: X1 has now excluded something
for the first time.** At case 0 the offset was zero, so the exclusion removed
nothing observable. At C1 it is one cycle on every word — had cycle indices been
inside the domain, C1 would have reported eight divergences on a frame where every
REQ-901 observable agreed. CD §3's stated reason for the transaction-level
canonical form has stopped being an argument and become a measurement. Recording
that moves nothing and is worth more than the sentence it costs.

**4. C2's void, and the C3 sequencing.** §12 criterion 8's void does **not** fire —
CD §10.1/§10.2 were frozen at `5c01af0`, a verified ancestor of the run — and
saying so mattered, because the criterion that did not fire is the reason C1's α is
a *selection* rather than a *choice* and C2's silence is a *void* rather than an
opening to write a disposition now with the answer in hand. What voids C2 is
simpler: no comparison happened, so there is nothing to adjudicate and nothing may
be constructed. C2 selects no branch at all — which is `FINDING RV-0078-S2-3`,
because §7 claims *"every case's result resolves to exactly one"* and the branch
set partitions **comparisons**, not **cases**. The harness had this right where my
packet did not, on `WO-0049` §8's reached-a-verdict / did-not-reach-one axis. I
bound the re-run to the printed stimulus hash so that *"the same stimulus"* is
checkable rather than asserted.

**On C3 I separated principle from readability rather than picking one.** In
principle C3 is unblocked: one frame cannot present a second start character, so
the defect is inert at both producers, and C3's content is independent of C2's.
In practice I sequenced it behind the repair, because with C2 red and ordered
first the aggregate is red whatever C3 does and **C3's own per-case line becomes
the sole carrier of a possibly spec-diff-grade result** — and that is exactly
criterion 3's plural content, which **CI has still never exercised**, because C2
was last in the array and no case has ever run after a red one. Leaning a
spec-diff conversation on an unexercised harness property to save one cheap round
is a bad trade. I also named the route that is barred before anyone finds it
attractive: C3 may not be landed by removing C2 from the case set. Removing a case
to make a run green is the co-sim equivalent of widening the permitted-divergence
list to absorb a result.

**One thing I deliberately did not do.** CD §10.2's *"needs no accumulator
change"* rationale is now measured false inside a frozen section, and one
annotation beside it in §0-ter's and §9-bis's form is owed — `FINDING
RV-0078-S2-4`. I did not write it: this round's authorised write set is the
verdict, the `State` field and this journal, and a reviewer who widens its own
write set mid-round is doing the thing it convicts assignees for. It is routed
with an owner (mine), a carrier (the CD round accompanying the C2 re-run dispatch)
and an explicit bound on what the annotation may touch — nothing in §10.2's INSIDE
list, expected values, prediction or branches, so the re-run runs under the
identical instance.

**And one thing I refused to settle in hindsight.** Criterion 7 asks for a
*distinct non-zero exit code* per refusal; the landed design discriminates by tier
and message inside `EXIT_BUILD(3)`. The purpose is met and the wording is not. I
would not amend the criterion's wording in the reading of the run that failed it —
that is `CD` §0's own hazard one level up from a case — so `FINDING RV-0078-S2-5`
names both lawful routes, recommends one, and requires the settlement **before**
the next run.

### Actions

- Adjudicated Stage 2's C1+C2 landing and appended `RV-C1C2` to `WO-0078` §14 —
  twelve sections: the CI reading at the source, C1's branch selection, the T2
  offset's home, C2's mechanism, C2's void-and-re-run ruling, five findings, the
  worker-conduct ruling, the nine-criterion table, the cost-band read, the C3
  sequencing ruling, what the landing does not mean, and the verdict.
- Updated the `State` field per stage, keeping the prior Stage-2 text quoted
  rather than overwriting it (the field's own auditability rule).
- Ran three mechanical checks of my own rather than taking either Return log's
  word: `git merge-base --is-ancestor 5c01af0 53fa1de` (true — criterion 8 holds
  by commit ordering); `git log --oneline 5c01af0..53fa1de` (four commits, none
  touching `test/attack_plans/`); and the source reading of both producers' guards
  that produced the finding.
- **Wrote no `test/**` and no `tools/**` file, and made no CD edit.** Every defect
  is a finding with a named owner and a named carrier round.

### Evidence

Reproducible at this commit's SHA, or externally verifiable:

- `git rev-parse HEAD` → `53fa1de2814e4841715ddeaa2b79590afd5ece41`.
- `git merge-base --is-ancestor 5c01af0 53fa1de; echo $?` → `0`.
- `git log --oneline 5c01af0..53fa1de` → `53fa1de`, `a822f46`, `c06ae01`,
  `8427b12`; `git log --name-only 5c01af0..53fa1de -- test/attack_plans/` → empty.
- **CI, externally verifiable**: `build` run **`31096150983`** at `53fa1de`,
  conclusion **failure**; job **`92598555141`** (`cosim`) **failure** at step 6
  *"Run the co-simulation lane (WO-0046 Phase 1)"*; job **`92598555210`**
  (`build`) **success**, all steps including `dune runtest`, the unpromoted/
  non-determinism check, the DV mechanical checks and the C-37 quantifier.
- The `cosim` log's decision lines, quoted verbatim in `RV-C1C2` §1:
  `CASE 0: … compare_exit=0 tier=CLEAN` with `frame 0: admit_cycle = 0`,
  `word 7: expected 10, observed 10` and `theirs - ours per word = [0 0 0 0 0 0 0 0]`;
  `CASE C1: stimulus_sha256=5ae9e4f5…3bd7c compare_exit=0 tier=CLEAN` with
  `frame 0: admit_cycle = 0`, T1 `{3 … 10}` and
  `theirs - ours per word = [1 1 1 1 1 1 1 1]`;
  `CASE C2: stimulus_sha256=cc1e85a4…5b44a7 compare_exit=N/A tier=PRODUCE-REFUSAL`
  preceded by `Failure("ours_run: a second start character arrived while a frame
  was open …")` at `test/cosim/ours_run.ml`, line 172, and followed by
  `run_cosim: FAILED CHECK: PRODUCE`, process exit 3.
- Cost lines: `case 0 … (run1+run2, sum …): 1.356s`; `case C1 …: 1.349s`;
  `run_cosim.sh wall time (this invocation): 8.266s`.
- Source facts behind `FINDING RV-0078-S2-1`, checkable at this SHA:
  `test/cosim/ours_run.ml`'s `accumulate` sets `open_frame` in the
  `Xgmii_word.start_lane` arm and clears it in `close_frame` under
  `out.tvalid && out.tlast`; `test/cosim/tb_xgmii_rx_64.v` sets `frame_open` in the
  `open_frame` task at the input start character and clears it in
  `close_frame_accept` on `m_axis_tlast`, with the admission check ahead of the
  drive.
- `test/cosim/canonical.mli`'s `divergence` type carries `Missing_frame`,
  `Decision_mismatch`, `Word_count_mismatch` and `Word_mismatch` over
  `["tkeep" | "tlast" | "tuser0" | "octets"]` — the basis for reading
  `divergences: none` as a statement over REQ-901's whole operative list.

**I executed no simulation** (ADR-0005) and claim none.

### Outcome

**DoD vs the dispatch: met.** `RV-C1C2` is appended to §14 with the `State` field
flipped per stage; **C1 ACCEPTED on branch α**, **C2 VOID with a re-run owed under
CD §10.2 unamended**, **C3 unblocked in principle and sequenced behind the C2
repair**, the nine criteria read one disposition each, the worker-conduct ruling
made, and this entry written.

**Five findings raised** — `RV-0078-S2-1` (MATERIAL, blocks C2; repair owner
tb_writer, both producers, one round, before C2 re-runs), `-S2-2`, `-S2-3`,
`-S2-4`, `-S2-5` (all MINOR, all mine as the defective claim's author).
**Four closed** — `RV-0078-S1-1`, `-S1-2`(a), `-S1-2`(b) at the mechanism, and
`-S1-3` with **Band A declared met** (1.356 s and 1.349 s per case; 8.266 s for the
invocation against a 300 s bound). **`RV-0078-S1-4` stands**, still first
dischargeable at C9.

**Handoff**: the file below goes to the orchestrator for commit under
`Agent: dv_lead`, `Work-Order: WO-0078`, `Journal-Entry: J-dv_lead-0152`. The next
dispatch is a **tb_writer repair round** carrying `FINDING RV-0078-S2-1`'s
successor rule over both producers and `FINDING RV-0078-S2-5`'s settlement; a
**dv_lead CD round** carrying `FINDING RV-0078-S2-4`'s annotation rides beside it,
before the C2 re-run.

**Lessons harvest**: **not due at this round** — PROTOCOL §7 places it at every
`SO-` and every phase gate, and this is a stage verdict. **The span stays open**
(open since `J-dv_lead-0148`, declared rather than skipped), and this round
**banks two candidates rather than minting them**:

- **LH-cand-A (LH2-g)**: *"A census of a system's refusal guards records, for each
  guard, the state variable it tests and the interval over which that variable is
  true — never the condition its message names. The message is documentation; the
  interval is the behaviour."* **LH1**: the census at this packet's §2.2, and the
  run at `53fa1de` that refused a conformant schedule. **LH3**: without it, a
  team concludes a guard cannot fire on a class of input it never checked against
  the guard's actual interval, and authorises work on that conclusion.
- **LH-cand-B (LH2-g)**: *"In a differential harness, the bookkeeping layers on
  the two sides are common-mode: a defect deliberately written identically into
  both is invisible to the comparison, which can only ever compare what the
  bookkeeping admits. The independence that makes the comparison worth having is a
  property of the two implementations under test, never of the two harness
  halves."* **LH1**: the same run — both producers carry the same guard defect by
  design, and only the execution order decided which one reported it. **LH3**:
  without it, a team credits the differential structure for catching a class of
  defect it is structurally unable to catch.

### Open-questions

1. **`FINDING RV-0078-S2-1`'s reference-side limb is a source-derived prediction,
   not a measurement**, and I want it checked rather than assumed: I claim
   `tb_xgmii_rx_64.v` would refuse C2 at its own guard for the same reason, and the
   only evidence is that its state variable has the same span and its check the same
   placement. **The repair round's own run falsifies or confirms it.** If the
   reference side turns out **not** to refuse, my reading of one of the two
   producers is wrong and the finding needs re-derivation before the repair lands.
2. **Criterion 3's plural content may never be exercised by ordinary luck.** It
   needs a case that does not reach a clean verdict **followed by another case in
   the array**, and every red so far has been last. Whether the programme should
   deliberately order a case set to exercise it — or accept that the property rests
   on stub testing and code reading — is a question I am raising rather than
   answering, because the obvious fix (reorder the array to put a known-red case
   first) is uncomfortably close to arranging evidence.
3. **`FINDING RV-0078-S2-2` deserves the auditor's eye before the `SO-` is
   drafted.** I have claimed that agreement between two implementations plus a
   spec-derived bench elsewhere adds up to a discharged obligation per class. If
   the two halves do not in fact cover the same classes — for instance if no X-1
   row confirms the absolute delivered values at a **lane-4** start — then C1's α
   is anchoring less than the `SO-` will want to say, and I would rather that be
   found now than in the sign-off round.
4. **The date drift is unchanged and unrepaired.** This entry uses the machine
   clock (2026-08-06), as `J-dv_lead-0151` did; `FINDING CD-P2-2` records the
   underlying inconsistency and no committed adjudication rests on any calendar
   literal.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md
