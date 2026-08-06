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

## [J-dv_lead-0153] 2026-08-06T11:48Z | task:WO-0078 | Two obligations discharged before the next run rather than in the reading of it — and the recommendation I was executing rested on a fact about my own harness that turned out to be wrong in the direction that made it stronger

### Trigger

Orchestrator dispatch, the **pre-re-run round** my own `RV-C1C2` sequenced: the
two obligations that must be committed **before** the C2 re-run fires, since the
re-run rides the tb_writer repair's landing CI and this round has to land first.
Both obligations are mine as the defective claim's author —
`FINDING RV-0078-S2-4`'s CD annotation and `FINDING RV-0078-S2-5`'s settlement —
plus a ruled question on whether `FINDING RV-0078-S2-3` needs a `WO-0078` §7
annotation to be readable by the re-run's adjudicator. Sole agent in flight.

**HEAD verified as my first action, before reading anything**: `git rev-parse
HEAD` → `99561ea40dbbe0f921eb5024b2bfd2f6ced8accd`, exactly the spawn head.
Neither rollback disposition fired and no descendant check was needed.

### Inputs

Read this round, all read-only except the two files in Files-in-this-commit:

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4.1–4.2, §5, §6, §7,
  §10 — R-SEAL-1 in particular, checked and not engaged: this round withholds
  nothing).
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — the header and
  `State` field, the section map, §2.2's census, §2.3's `FINDING WO-0078-1` and
  its repair text (**criterion 7's ancestor**), §7 in full, §12 in full, §14's
  `RV-STAGE1` §5 (the amendment precedent) and `RV-C1C2` §4, §5, §6, §8 and §12.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` in full at `99561ea` — §0, §0-bis,
  §0-ter, §1, §5.1/§5.2, §9, §9-bis's four items, §10.0, §10.1, §10.2, §10.5,
  §10.6, §10.7.
- `agents/journals/claude_dv_lead_agent.v07.md` — my own `J-dv_lead-0152`, which
  is the round this one executes.
- **`tools/cosim/run_cosim.sh` at `99561ea`, read to check my own recommendation
  before executing it**: the exit-code table (lines ~769–781), the `BUILD` die
  sites (1094, 1107, 1115), `produce_reason`'s full header comment (893–930),
  `record_case_refusal` (1172–1188), the per-case refusal sites (1263, 1306) and
  the reference-side rc check FI-8 (1160). **A `tools/` file inside my own write
  scope, read and not written.** **No `libs/**`, no `top/**`, no
  `rtl_snapshots/**` was opened at any point in this round**, and nothing below is
  derived from RTL.
- `docs/specs/` was not re-opened this round: no expected value, no REQ mapping
  and no test is created here. The two edits are records and a criterion's
  wording.

### Reasoning

**Three decisions, and the middle one is the one I nearly got wrong by trusting
my own verdict's parenthetical.**

**1. The CD annotation — where its authority comes from, since I refused a
different addition to the same document one round ago.** `J-dv_lead-0152` refused
to record the T2 `+1` offset in the CD, on the ground that §9-bis's addition-only
lift is scoped by its own words to *"co-sim Phase 2's domain instances"* and that
*"using an addition-only lift for content it did not name is precisely how such a
lift becomes general."* That refusal makes this round's annotation look like the
same move unless the distinction is written down, so I wrote it down in the note
itself: **this annotation is made under §9's four-item change discipline, not
under §9-bis's lift.** The proof that §9 reaches it without any lift is §0-ter —
written while the whole document was still frozen for Phase 1, under §9 alone. And
the distinction between the two contents is the one §10.7 item 3 already draws:
**a defect in this document's own text is what §9 exists for; a result about the
two implementations is what §10.7 item 3 bars outright** (*"This document freezes
the questions; it answers none of them"*). The note answers none of them, and item
4 of its own four is where that is checked rather than asserted — C2 was driven
once and compared zero times, the prediction is unspent, bar 1 has not lifted.

**The bound I set myself in `RV-C1C2` was the easy part; the freeze origin was
the part I could have broken without noticing.** §10.2's instance is frozen from
`5c01af0`, and `§12` criterion 8's whole force at the re-run is that the
instance's commit is an **ancestor of the run**. An annotation that read as
re-freezing §10.2 at this commit would have reset that ancestry to a commit
*later* than the failed run — and criterion 8 would then have voided the re-run
for a reason I created. So the note says in terms that the freeze origin does not
move. That is the single most load-bearing sentence in it and it is there because
I went looking for what an annotation could break, not because the finding asked
for it.

**On the re-run's hash bind: the dispatch left it to the CD's own form, and the
CD's own form refuses it.** §10.0 declines to copy case 0's pinned literal into
§10 for a stated reason — *"a second literal is a second thing that can drift"* —
and a stimulus hash is exactly such a literal. So the bind is cited by reference
to `RV-C1C2` §5 item 4 and not restated by value. **A document that already
refused to copy one hash for a reason does not get to copy a different one
because the second is mine.**

**2. `FINDING RV-0078-S2-5` — I executed my own recommendation and found its
stated ground was false, which is the part of this round worth reading.**
`RV-C1C2` recommended amending criterion 7's wording, closing with: *"the one
distinction that is load-bearing (BUILD versus PRODUCE — did the binary run?) is
already a code-level one."* **Measured at this SHA, that is wrong.** `BUILD` and
`PRODUCE` both map to `EXIT_BUILD=3`; the distinction is a **stage name inside one
code**, deliberately, by `WO-0073-D5`'s own repair, whose comment says so — *"Same
code, same axis (§8: the lane did not reach a verdict), different pointer."* I had
written a parenthetical from memory of the harness rather than from the harness,
which is the same species of error as the §2.2 census that caused this whole
round. **I corrected it in the settlement rather than quietly executing a
recommendation whose ground had evaporated**, and the corrected fact turned out to
support the amendment *more* strongly: the code namespace **already** draws the one
line criterion 7's failing observation cares about — *did the run produce what a
comparison needs*, code 3 against 4/8/10/11/12, every one of which disposes of a
comparison that was attempted. So no code split is owed and none is routed.

**And reading `produce_reason` gave the settlement the ground it actually needed,
which is a document older than the run.** Its comment states the rule in capitals:
*"WHERE ONE EXIT CODE COVERS SEVERAL STAGES, THE STAGE MUST BE NAMED IN THE TEXT,
BECAUSE THE CODE IS READ BY A MACHINE AND THE TEXT IS READ BY THE PERSON WHO HAS
TO FIX IT."* That rule went through the `RV-` loop at `WO-0049` §8 and landed at
`WO-0073-D5`. **Criterion 7's per-guard literal is therefore a drift against a
rule this lane had already adjudicated — not a requirement the implementation
failed to meet.** That reframing is what makes the amendment defensible despite
being written after a run the literal failed: **its ground is a committed artefact
that predates the run**, and my own bar was about settling *in the reading of* a
run, not about the calendar. Two further grounds are independent of any run: the
criterion's own failing observation selects the weaker of its two readings, and my
own named alternative route (*"split the codes per producer"*) does not satisfy the
per-guard literal either, since FI-4 and FI-5 share a producer — **so at no point
did the author mean per-guard**, and that is a fact about the packet, not about
the run.

**The check that kept the amendment honest: what does it make green that was
red?** Almost nothing, and deliberately. Limbs (a) and (c) were already observed
met; limb (b) — attribution — is met **on our side only**, because `ours_run`'s
`Failure` text distinguishes FI-4 from FI-5 in the case's own printed record. **The
reference side meets neither (b) nor, on `FINDING WO-0078-1`'s reading, reliably
(c)**: `$display` + `$finish` is a normal termination and FI-8's rc check cannot be
assumed to catch it. **So criterion 7 goes from two gaps to one, and the gap that
survives is the one that always mattered** (`FINDING RV-0078-S1-4`, first
dischargeable at C9). An amendment that had closed the reference-side gap by
wording would have been exactly the hazard `S2-5` named; this one leaves it
standing, and I wrote limb (b) so that it **bites** at the reference side rather
than describing what our side already does.

**3. `FINDING RV-0078-S2-3` — I ruled against annotating §7, and the reasoning is
a cost/benefit I want in the diff because the easy answer was yes.** The benefit
is readability for the re-run's adjudicator; that is already discharged twice
before §7 is reached — the `State` field's own first screen says C2 *"reached no
comparison and selects no branch"*, and `RV-C1C2` says it four more times. The
cost is that **§7's table IS the frozen prediction criterion 8 protects**, and
criterion 8 *"earned its keep on this landing"* only because both instances were
frozen at an ancestor of the run. Editing that table between a case's void run and
its re-run — even harmlessly, even without touching any case's predicted
disposition — makes the table's innocence something a later auditor must
**reconstruct** instead of something they can **see**. Against a benefit already
banked twice, that trade is all cost. **And the finding's own carrier list already
routed the §7 repair to the co-sim Phase 3 CD instance round**, where C9 makes the
cell load-bearing by construction and no case's prediction is in flight; widening
my own finding's carriers a round later, with a run pending, is a smaller version
of what this packet convicts assignees for. What I did instead costs nothing: the
operative rule is stated in one sentence **in §14**, where a ruling belongs and
where a prediction does not.

**One more thing I checked rather than assumed.** The `State` field says C2 is
re-run *"under CD §10.2 **unamended**"*. After this round that sentence must still
be true or the field has drifted — and it is, because the annotation is **beside**
§10.2 and §10.2 is unchanged byte for byte. So the field is untouched, and the
check is recorded rather than the absence of an edit being left to look like
inattention.

### Actions

- Wrote **`CD` §10.2-bis**, an annotation beside §10.2 in §0-ter's form, under
  §9's four-item discipline, with an explicit authority statement distinguishing
  it from the addition I refused last round, a per-item record of what did not
  move, and a six-item "what this does NOT do" list covering the freeze origin,
  the hash bind, the prediction quote and the dispatch surface.
- **Amended `WO-0078` §12 criterion 7 in place**, three lettered limbs and three
  failing observations, with **the superseded wording quoted verbatim beneath it**
  rather than overwritten, marked as the text the `53fa1de` run was read against,
  and marked **PROSPECTIVE**.
- Appended **`RV-C1C2-SETTLEMENT`** to `WO-0078` §14: the settlement's four
  grounds, the correction to my own recommendation's false parenthetical, the
  per-limb statement of what the settlement does not discharge, the `S2-3` ruling
  with the one-sentence rule for the re-run's adjudicator, the `S2-4` discharge
  against each bound the finding set, and a list of what this round does not move.
- **Read `tools/cosim/run_cosim.sh` before executing my own recommendation** and
  corrected it against the source rather than against my memory of it — the rule
  `RV-C1C2` §7 states for assignees, applied to myself.
- **Wrote no `test/cosim/**` and no `tools/**` file, dispatched no worker, ran no
  case, and edited no prior verdict.** The `State` field is untouched by decision,
  recorded above.

### Evidence

Reproducible at this commit's SHA, or externally verifiable:

- `git rev-parse HEAD` → `99561ea40dbbe0f921eb5024b2bfd2f6ced8accd` (unmoved
  through the round).
- `git status --porcelain` → exactly two modified paths, both in
  Files-in-this-commit; `git diff --stat` → `385 insertions(+), 5 deletions(-)`,
  the five deletions being criterion 7's superseded sentence, which is re-quoted
  verbatim in the same hunk.
- **The settlement's decisive ground, checkable in the tree at this SHA**:
  `tools/cosim/run_cosim.sh`'s `produce_reason` comment — *"WHERE ONE EXIT CODE
  COVERS SEVERAL STAGES, THE STAGE MUST BE NAMED IN THE TEXT …"* — and its
  provenance line naming `WO-0073-D5` and `WO-0049` §8.
- **The corrected fact**: `EXIT_BUILD=3` at line 770-ish of the same file is the
  code for `BUILD (dune build failed …)` (line 1094), `BUILD (missing source …)`
  (1107) and `BUILD (iverilog compile failed …)` (1115) **and** for
  `PRODUCE (stimulus_gen, case …)` (1263) and `PRODUCE ($PIPE_FAIL_REASON)`
  (1306) — one code, two stage names, by that repair's own design.
- **Limb (b)'s our-side discharge**: `ours_run.ml`'s FI-4 text (*"a second start
  character arrived while a frame was open"*) and FI-5 text (*"M03 produced an
  output word with no admitted frame open"*, quoted inside `produce_reason`'s own
  comment) differ, and both reach the case's printed record through `say "$out"`
  before the `CASE …` line.
- **Limb (b)/(c)'s reference-side gap**: the rc check at line 1160,
  `if [ "$rc" -ne 0 ] || [ ! -e "$dir/theirs.canon" ]`, against `$display` +
  `$finish` — `FINDING WO-0078-1`'s subject, unchanged.
- **The run this round records but does not read**: `build` run `31096150983` at
  `53fa1de`, `cosim` job `92598555141` — externally verifiable, cited from
  `RV-C1C2` §1's own reading, **not re-fetched and not re-adjudicated here**.
- **No CI run exists for this commit**, and none is claimed: this round lands
  documents only and dispatches nothing.

**I executed no simulation** (ADR-0005) and claim none. **I ran no case and read
no new run.**

### Outcome

**DoD vs the dispatch: met, all three items.**

1. **`FINDING RV-0078-S2-4` — DISCHARGED.** `CD` §10.2-bis exists, in §0-ter's
   form, under §9's four items, touching **nothing** in §10.2's INSIDE list,
   expected values, frozen prediction or branch cells, and **not moving the
   instance's `5c01af0` freeze origin**. The prediction stays frozen and unspent.
2. **`FINDING RV-0078-S2-5` — SETTLED, by amending the wording**, executed as
   recommended but on corrected grounds. The superseded text is quoted, not
   overwritten; the amendment is prospective; criterion 7 stays **PARTIALLY
   DISCHARGED** with one gap where it had two. **No code split is owed and no
   data_wrangler work is routed.**
3. **`FINDING RV-0078-S2-3` — RULED: no §7 annotation.** The `RV-` text plus the
   `State` field suffice; the §7 repair stays owed at the co-sim Phase 3 CD
   instance round. **The finding stands open.**

**One correction issued against my own prior verdict** (`RV-C1C2` §6's
recommendation parenthetical), recorded in the settlement rather than silently
worked around.

**Handoff**: the two files below go to the orchestrator for commit under
`Agent: dv_lead`, `Work-Order: WO-0078`, `Journal-Entry: J-dv_lead-0153`. **The
C2 re-run's two pre-conditions are now discharged on my side**; what remains
before it is `FINDING RV-0078-S2-1`'s tb_writer repair over both producers, which
this round does not dispatch.

**Lessons harvest**: **not due at this round** — PROTOCOL §7 places it at every
`SO-` and every phase gate, and this is neither. **The span stays open** (open
since `J-dv_lead-0148`, declared rather than skipped). **One candidate banked,
joining LH-cand-A and LH-cand-B from the entry above:**

- **LH-cand-C (LH2-g)**: *"When a review recommends a settlement on a stated
  ground, the round that executes it re-measures that ground at the source before
  acting on it. A recommendation's reasoning is not evidence for the recommendation
  — it is a claim of the same class as the one under repair, made by the same
  author, in the same sitting."* **LH1**: this round — `RV-C1C2` §6's
  recommendation asserted that a distinction was carried by an exit code, the
  source showed it carried by a label inside a shared code, and the corrected fact
  changed the argument's shape (though not its direction). **LH3**: without it, a
  correction round inherits the defective round's unchecked assertions and
  launders them into settled text, where the next reader meets them as adjudicated.

### Open-questions

1. **Criterion 7's limb (b) is now falsifiable at the reference side and has never
   been exercised there.** I wrote it to bite where the criterion's remaining gap
   is, which means the C9 round that first trips a reference-side guard is also the
   first test of the limb's own wording. If `$finish`'s replacement turns out to
   carry no per-guard text at all, limb (b) fails at the same moment
   `FINDING RV-0078-S1-4` closes — and I would rather that be anticipated here
   than discovered as a surprise in the C9 verdict.
2. **`FINDING RV-0078-S2-3`'s §7 repair now has exactly one carrier**, the co-sim
   Phase 3 CD instance round, which is `SCOPED, NOT AUTHORISED`. If Phase 3 is
   deferred past the `SO-`, the defective exhaustiveness claim in §7 outlives the
   packet's active life with no owner in flight. **The `SO-` round should check
   whether it is still unrepaired and say so**, rather than letting a not-yet-
   authorised stage hold the only carrier indefinitely.
3. **The three open questions of `J-dv_lead-0152` are unchanged and none is
   addressed here** — the reference-side limb of `S2-1` still awaits the repair
   round's own run, criterion 3's plural content is still unexercised in CI, and
   `FINDING RV-0078-S2-2` still deserves the auditor's eye before the `SO-`.
4. **The date drift is unchanged and unrepaired.** This entry uses the machine
   clock (2026-08-06), as `J-dv_lead-0151` and `J-dv_lead-0152` did;
   `FINDING CD-P2-2` records the underlying inconsistency, and no committed
   adjudication in this round rests on any calendar literal — both artefacts
   written here are dated by their commit and by this entry.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md
- test/attack_plans/CD-xgmii_rx_64_cosim.md

## [J-dv_lead-0154] 2026-08-06T12:29Z | task:WO-0078 | Both producers produced and the READER refused — the grammar was pinned when this lane drove one frame, and the second time two frames arrived it broke one layer below the guard I had just repaired

### Trigger

Orchestrator dispatch, sole agent in flight: adjudicate the C2 **re-run**, the run
my own `RV-C1C2` §10 sequencing ordered. `build` run `31100435961` at `9de61f1`
(`cosim` job `92612412697`, aggregate exit 8; `build` job green; journal-check
green). The dispatch's own framing — *"the producers were repaired and both
produced, but the comparison STILL did not happen — this time the READER refused"*
— named six questions: C2's disposition again, the new finding with its owners and
carrier, whether my `S2-1` closure stands, whether `S1-2`(b) is still owed, the
criterion reads, and the sequencing.

**Abort-first head check, my first action**: `git rev-parse HEAD` →
`9de61f15417af2d7f8df3f074a6019bf7f19f1bc`, exactly the stated spawn-head. Neither
rollback disposition fired. `git status --porcelain` empty at entry.

### Inputs

**Read, at `9de61f1`:**

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md`.
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — the `State`
  field, §7 (frozen dispositions), §8 (bars), §12 (all nine criteria, criterion 7
  as amended last round), §13, and §14's `RV-STAGE1`, `RV-C1C2`,
  `RV-C1C2-SETTLEMENT` and the tb_writer `S2-1` repair Return log.
- `agents/handoffs/WO-0046_cosim-phase-1.md` §2.2, §2.3 (**the grammar pin**), §3,
  §4 — read because §4 of my verdict turns on what that pin says and when it was
  written, and I would not take my own prior quotation of it on trust.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` — §10.2 and §10.2-bis (mine, last
  round), §5.2 X1, §0, §9/§9-bis, §10.7.
- **DV-side sources, all inside my own write scope**: `test/cosim/canonical.mli`
  (the pinned grammar block and the `E` contract), `test/cosim/canonical.ml`
  (`read`'s `parse_state`, `check_timing`'s idle map), `test/cosim/compare.ml`
  (`run_comparison`'s read order, `read_idle_sidecar`,
  `reference_refusal_canon_text`), `test/cosim/ours_run.ml` (the single
  `Canonical.write_file`), `test/cosim/tb_xgmii_rx_64.v` (every `$fwrite` call
  site, `open_frame`, `close_delivery_*`, the end-of-stimulus `$finish` at line
  514), `test/cosim/stimulus_gen.ml` (`build_c2`, `c2_meta`),
  `tools/cosim/run_cosim.sh` (the exit-code table, the per-case `case "$DIFF_RC"`
  dispatch, the SUMMARY block, the AGGREGATE section).
- `agents/journals/claude_dv_lead_agent.v07.md` tail (`J-dv_lead-0153`).
- **CI**: `cosim` job `92612412697`'s log in full, and the run/job metadata, via
  the server-side GitHub logs tool.

**NOT read, at any point in this round: `libs/**`, `top/**`, `rtl_snapshots/**`.**
No RTL was opened. Every expected value cited in the verdict comes from
`docs/specs/` text quoted in frozen documents of mine, from the pinned grammar, or
from a prior committed verdict. **I executed no simulation** (ADR-0005) and claim
none.

### Reasoning

**1. The temptation this round had to survive was to reopen `S2-1`, and the
argument against it is what organises everything else.**

Two consecutive landings, both C2, both reaching no comparison — the cheap reading
is *"the repair did not work."* **Measured, that reading is false.** `ours.canon`
and `theirs.canon` each carry `F 0 0` … `D 0 accept`, `F 1 10` … `D 1 accept`: two
frames, eight words each, both `Accept`, on **both** sides. No `E` sentinel
anywhere in `theirs.canon`; no raise from `accumulate`; `vvp` terminating at line
514, which I read at source and confirmed is the **end-of-stimulus** `$finish` and
not a guard's. The repair's own subject — *which schedules the guards admit* — is
verified on live stimulus, including the reference-side half its round could not
execute. **So `S2-1` closes, and the new defect gets its own number.** Merging them
would erase a verified repair and would make the next round's scope unreadable.

**And the S2-1 round's structural invariance argument is now vindicated by
measurement**: that round could execute neither case 0 nor C1 and argued
bit-identity from unmoved write sites. Both cases reproduce their stimulus hash,
their whole T1 profile and their whole T2 offset vector across the repair. **An
argued invariance that was falsifiable at the next run and held is worth recording
as a fact about the argument** — it is the standard I want the next such argument
held to.

**2. What actually happened, verified at four sources rather than inferred from the
error message.** `canonical.mli`'s pinned grammar says *"Per frame, in the literal
order the grammar block above states: one [F] line, then its [W] lines … then its
[D] line."* `canonical.ml`'s `read` implements exactly that: `parse_state` is
`No_frame_open | Frame_open of {…}` — **at most one frame open at a time** — and
raises on an `F` while one is open. `tb_xgmii_rx_64.v` `$fwrite`s each record at
the instant of its own event: `F` inside `open_frame` at admission, `W` per output
word, `D` inside `close_delivery_accept` at output `tlast`. At C2 frame 1 is
admitted on cycle 10 and frame 0's last word is delivered on cycle 10, so `F 1 10`
lands inside frame 0's block. Our side has no such shape because `ours_run.ml`
accumulates a whole transaction and emits it through one `Canonical.write_file`.

**The reader is conformant; the reference-side writer is not.** That ordering
matters for the repair, and it is why I refused to write the finding as "the reader
refused" even though that is the dispatch's own (accurate) description of the
symptom.

**3. The observation I did not expect to make, and which changed the finding's
shape: the reader's strictness prevented the exact misreport `WO-0049` exists to
prevent.** Had the grammar tolerated the interleave and attributed positionally,
frame 0 would have parsed with seven words and frame 1 with nine, and
`compare_transactions` would have reported `Word_count_mismatch` on both —
`EXIT_DIFFERENTIAL`, *"our RTL diverged from the MIT reference"*, for a defect in
our own testbench's writer. `run_cosim.sh`'s header names run `30825741565` by id
as the reason `EXIT_NO_VERDICT` exists. **This is that code's first production
firing, and it did precisely its job.** A round that reports only "the lane went
red again" would lose the fact that the lane's most expensive prior lesson was
being paid off in front of us.

**4. The design point that decides what the repair may and may not be, and which I
had to derive rather than assume: the `W` record carries NO frame index.** Its
attribution is positional. With two frames open there is **no grammatical fact of
the matter** about which frame a `W` belongs to. So "teach the reader interleaved
attribution" is not a parser change: the obvious rule (*attribute to the oldest
open frame*) is a **behavioural assumption about the design under test** —
in-order, non-interleaved delivery on one stream — installed inside the comparator.
**A comparator that assumes a property cannot detect that property's violation.**
That is the single most important sentence in this verdict, and it is why my
finding states preserved *properties* and leaves the *route* to its owner: I can
rule that a heuristic attribution is barred without deciding between buffering the
writer and amending the grammar, and deciding the latter for tb_writer would be me
designing the instrument I am supposed to be judging.

I also checked, and recorded, that **grouping loses no evidence**: `F` carries
`admit_cycle`, every `W` carries its own `cycle`, so the temporal interleave is
fully recoverable from a grouped file. That is offered to the owner as a weighing
fact, not as the answer.

**5. Whose blindness it is, and why I say so in my own verdict rather than leave it
to the auditor.** The grammar is pinned at `WO-0046` §2.3 — mine — in a packet
whose §3 says *"What Phase 1 drives: one 64-octet good-FCS frame."* A
one-frame-at-a-time record grammar was correct there. **`WO-0078` §3 and §6.2
widened the case set to two frames whose spans overlap by construction — also mine
— without re-deriving the writer's obligation under the grammar that widening would
now bind it to.** That is the **same species** as `S2-1` one round earlier: I
enumerated what a mechanism is *for* instead of what it *does* when two frames are
in flight. **Two instances of one species in consecutive rounds is the finding's
most important content**, and it is what produced §10's new instruction: the repair
round must *enumerate, statically and in its Return log, every remaining place a
one-frame assumption could still be load-bearing.* Naming them costs one reading;
discovering them costs one round each — and this lane has now paid that price
twice.

**6. The root cause of the LATE discovery, stated separately from the defect
itself.** The `S2-1` fixture pair asserted *admit* and *refuse*. It asserted
nothing about the FILE the newly-admitted schedule causes a producer to write. **A
guard decides which inputs a component accepts; it says nothing about what the
component then emits — and a repair that changes the first necessarily changes the
second.** Only the first was checked. That is a property of the verification scope,
not a defect in tb_writer's work, and I wrote it that way because the assignee met
its finding's terms exactly.

**7. Findings I minted that the dispatch did not ask for, because I read rather
than assumed.**

- **`S2-7`**: C2 printed a **SUMMARY block** this round — *"OUR side asserted
  against SPEC-M03 §6.1 (T1)"*, *"This case's own result is timing evidence for the
  ONE stimulus class it drives"* — for a case that computed no T1, no T2 and no
  result. `RV-C1C2` §8 had recorded that C2 *"printed no SUMMARY — correctly"*;
  that was true of the PRODUCE-REFUSAL arm, which `continue`s, and **the NO-VERDICT
  arm falls through**. Newly reachable **because of my own `RV-STAGE1` §5 OQ1/OQ2
  record-and-continue amendment**, which moved no-verdict cases onto the
  fall-through path without asking what the fall-through prints. MINOR — the
  `tier=NO-VERDICT` line is two lines above it — but it is precisely the sentence
  form criterion 9 polices, and the `SO-` will cite this log.
- **`S2-8`**: nothing anywhere exercises `tb_xgmii_rx_64.v` except the `cosim` job.
  `compare --self-test` synthesises files by hand; `ours_run --self-test` exercises
  our side. Under ADR-0005 the reference producer's first execution is always CI,
  so **each of its defects costs a full round**. That is the structural reason
  `S1-4` has stood since Stage 1 and the structural reason `S2-6` arrived late. The
  recommended partial repair — a hand-written **golden file** of what the writer
  intends to emit for a two-frame overlap, fed to `Canonical.read` in the self-test
  — executes no Verilog and is only as good as the hand that writes it, **and I said
  so**; what it buys is turning the writer's record order from an unstated
  assumption into an artefact a reviewer can diff against the `$fwrite` call sites,
  which is where this defect was visible all along, statically.

**8. Two things I deliberately did NOT do, each of which was the easy move.**

- **I did not amend criterion 7 again.** The run produced a genuinely new
  observation in its neighbourhood — the reference producer **failed without
  refusing**: wrote a grammar-violating file, exited normally, and the harness's
  rc/existence check (FI-8) passed. That is a failure mode criterion 7 does not
  reach. It does not need to: the reader is the designed net and the net held.
  **Amending a criterion in the reading of a run is what `FINDING RV-0078-S2-5`
  barred, and it binds me twice as hard the round after I amended it.** Recorded as
  an observation in the criterion-7 row, not as a wording change.
- **I made no CD edit, and ruled it rather than omitting it.** This run falsifies no
  CD clause — §10.2 says nothing about record order and §10.2-bis already carries
  the one falsified sentence. A second annotation recording *"the re-run also
  reached no comparison"* would be a **result**, barred by §10.7 item 3 (*"This
  document freezes the questions; it answers none of them"*) and the
  left-standing-summary class §0-ter tabulates payments for. §9-bis's addition-only
  lift is scoped to domain instances and a result is not one — `RV-C1C2` §3's own
  ruling, applied to my own round for the second time.

**9. The check I ran on myself, because last round's banked LH-cand-C demands it.**
`J-dv_lead-0153` asserted that §10.2-bis touches §10.2 *"in no way whatever"*.
**This round measures it instead of repeating it**:
`git diff --numstat 5c01af0 9de61f1 -- test/attack_plans/CD-xgmii_rx_64_cosim.md`
→ `129  0`, **one hunk, zero deletions**, entirely appended after §10.2. So the
annotation I wrote between C2's void run and its re-run is **provably** innocent of
the prediction it sits beside — the property I said last round a reader should not
have to reconstruct, now checkable in one command. Criterion 8 moves from
*asserted* to *measured*.

**10. Where the frame-1 `+1` offset lives — the question the dispatch handed me
explicitly.** Reading the dumped files by hand: frame 0's cycles are equal on both
sides; frame 1's are `13 … 20` ours against `14 … 21` theirs. C2's frame 1 starts
in lane 4 (84 octet-times, not a multiple of 8), so this is C1's already-recorded
lane-4 `+1`, at a second occurrence. **Three layers of status, and the middle one
is what stopped me from filing it beside C1's**: (i) CD §5.2 X1 — outside the
domain, data never adjudicated, `AP-M03` §7 bar 3 untouched; (ii) **it is not an
instrument output** — no T2 ran, this is my own eyeball reading of a printed dump,
so it does **not** join C1's T2 record and does **not** go to the `SO-` as a
measured datum; (iii) its one legitimate forward use is as an
**instrument-stability note** for the next adjudicator, explicitly **not** a §7-class
prediction, because an out-of-domain quantity does not acquire branch-selecting
force by being written down early. A hand reading printed beside instrument output
without that distinction attached is how a dump becomes a result.

**11. The stopping rule, pre-registered with the answer not in hand.** Two
landings, two instrument defects, zero comparisons. A third would stop being a
sequence of unrelated defects and start being evidence about the instrument. So I
wrote the rule **before** the run it governs: a third C2 landing reaching no
comparison is **not** a fourth worker repair round — it becomes a design question
about whether the pinned transaction form can express overlapping frames at all
(CD §3, `WO-0046` §2.3), owned by me, with options and cost, reaching the sponsor
as **E2** if any option narrows the case set. **Narrowing the case set inside DV
stays barred** (`RV-C1C2` §10). This is the same discipline §7's table applies to
dispositions, applied one level up to my own re-dispatch behaviour.

### Actions

- **Read the `cosim` job log in full** through the server-side GitHub logs tool
  (the direct blob fetch remains blocked by this session's egress, as at the two
  prior rounds), and the run/job metadata from the same API.
- **Ran four mechanical checks** on the checkout rather than taking them from any
  Return log: the `5c01af0` ancestry, the CD diff `numstat`/hunk/deletion count,
  the `53fa1de..9de61f1` changed-path set, and a source reading of the four files
  the mechanism turns on.
- **Appended `RV-C2RERUN` to `WO-0078` §14** — twelve sections: what I executed,
  the CI reading, the `S2-1` closure, the mechanism at four sources, the `+1`
  offset's three-layer status, three new findings with owners and carriers and
  seven preserved properties, the CD no-edit ruling, the nine criteria one
  disposition each, cost, sequencing with the pre-registered stopping rule, what
  the run does not mean, and the verdict.
- **Updated the `State` field**, keeping the superseded `RV-C1C2` text quoted
  beneath it rather than overwriting it — this packet's own rule that a lifecycle
  field which erases its own history cannot be audited.
- **Wrote no `test/**` file, no `tools/**` file, and no `test/attack_plans/**`
  file; dispatched no worker; ran no case; edited no prior verdict.** The CD is
  untouched **by ruling** (§7 of the verdict), not by omission.

### Evidence

Reproducible at this commit's SHA, or externally verifiable:

- `git rev-parse HEAD` → `9de61f15417af2d7f8df3f074a6019bf7f19f1bc` (unmoved
  through the round).
- **The run**: `build` `31100435961`, `head_sha` `9de61f1`, conclusion `failure`;
  `cosim` job `92612412697` `failure` with `Process completed with exit code 8`;
  `build` job green. Externally verifiable.
- **The three case lines, verbatim from the log**:
  `CASE 0: stimulus_sha256=c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051 compare_exit=0 tier=CLEAN`;
  `CASE C1: stimulus_sha256=5ae9e4f501251c38d0c2d386bd792e07cbcf9cf107cf7e75c378e21b1ce3bd7c compare_exit=0 tier=CLEAN`;
  `CASE C2: stimulus_sha256=cc1e85a4c5f871226f07b4792446d63c523577dcf172d6c4a80b8a3e845b44a7 compare_exit=3 tier=NO-VERDICT (compare could not read a canonical file/idle sidecar, exit 3)`;
  aggregate `run_cosim: FAILED CHECK: NO-VERDICT (case C2: compare could not read a canonical file, exit 3)`.
- **The reader's own message**: `compare: could not read theirs canonical file
  …/case_C2/run1/theirs.canon: Canonical.read: line 9: F line while frame 0 is
  still open (missing its D line) (line was "F 1 10")`.
- **`S2-1`'s closure, in the dumped files**: `ours.canon` = `F 0 0` … `D 0 accept`
  … `F 1 10` … `D 1 accept`; `theirs.canon` = same two frames, same two `accept`
  decisions, **no `E` line**; `[case C2 run1] vvp: …tb_xgmii_rx_64.v:514: $finish
  called at 298600`, and line 514 read at source is the end-of-stimulus `$finish`.
- **Invariance across the repair**: case 0 and C1 reproduce their stimulus hashes,
  `T1 {3 … 10}` each, and `T2 [0 × 8]` / `[1 × 8]` respectively — identical to run
  `31096150983`.
- **The grammar, at source**: `test/cosim/canonical.mli` — *"Per frame, in the
  literal order the grammar block above states: one [F] line, then its [W] lines
  (zero or more) in emission order, then its [D] line."*; `test/cosim/canonical.ml`
  line 196–200 — `| "F" :: _, Frame_open { index; _ } -> parse_error … "F line
  while frame %d is still open (missing its D line)"`.
- **The writer, at source**: `test/cosim/tb_xgmii_rx_64.v` — `$fwrite(out_fd, "F
  %0d %0d\n", next_index, stimulus_lines - 1);` inside `open_frame`;
  `$fwrite(out_fd, "D %0d accept\n", …)` inside `close_delivery_accept`;
  `test/cosim/ours_run.ml`'s single `Canonical.write_file output_path transaction;`.
- **The four mechanical checks**: `git merge-base --is-ancestor 5c01af0 9de61f1` →
  true; `git diff --numstat 5c01af0 9de61f1 -- test/attack_plans/CD-xgmii_rx_64_cosim.md`
  → `129  0` with one `@@` hunk and zero `^-` lines;
  `git diff --name-only 53fa1de 9de61f1` → six paths, code paths exactly
  `test/cosim/ours_run.ml` and `test/cosim/tb_xgmii_rx_64.v`
  (**`stimulus_gen.ml` did not move**).
- **`S2-7`, at source**: `tools/cosim/run_cosim.sh`'s `hdr "SUMMARY (case
  $CASE_ID)"` block sits after the determinism check, inside the case loop, reached
  by every arm from the `compare` dispatch onward; the two PRODUCE-REFUSAL arms
  `continue` before it.
- **Cost**: case 0 `1.296s`, C1 `1.298s`, C2 `1.306s` (run1+run2 sums), invocation
  `9.947s` against Band A's 300 s; linearity ratio `1.008` against a bound of 2.
- **No CI run exists for this commit** and none is claimed: this round lands
  documents only and dispatches nothing.

**I executed no simulation** (ADR-0005). **I ran no case.** The `+1` offset in §5
of the verdict is explicitly recorded as a hand reading of a printed dump, not as
instrument output.

### Outcome

**DoD vs the dispatch: met, all six items.**

1. **C2's disposition — ruled: VOID AGAIN, RE-RUN OWED**, under CD §10.2
   **unamended**, selecting no branch, prediction frozen and **unspent**. **The sha
   bind carries forward unchanged** and is promoted from a check to a measured
   invariant, having held across two landings and one repair of both producers.
2. **The new finding — `FINDING RV-0078-S2-6` (MATERIAL)**, stated with its
   mechanism verified at four sources, its design-gap owner (**dv_lead**), its
   repair owner (**tb_writer**, `test/cosim/tb_xgmii_rx_64.v`, plus the grammar's
   own files only if the chosen route amends it), its carrier (**a tb_writer repair
   round before C2 re-runs**), and **seven properties any repair must preserve** —
   led by *an ambiguously-attributable file must fail to read rather than be
   attributed by a heuristic*.
3. **`FINDING RV-0078-S2-1` — CLOSED; the closure STANDS.** The guard repair did
   what its fixture pair claimed, on both sides; the fixture pair's scope simply
   never reached the writer order.
4. **`FINDING RV-0078-S1-2`(b)'s production instance — STILL OWED**, unchanged, at
   the next C2 re-run: C2 printed no T1 at all.
5. **Nine criteria read, one disposition each.** Criterion 3 materially advanced
   (first production firing of `compare` exit 3, of `dump_run`, and of
   `EXIT_NO_VERDICT` as an aggregate) with its plural gap **deferred a second time**
   and one new debit (`S2-7`); criterion 8 **measured rather than asserted for the
   first time**; criterion 7 **not engaged by any case** and deliberately not
   amended again.
6. **Sequencing restated**: tb_writer repair round (with `S2-8`'s golden file and a
   static enumeration of remaining one-frame assumptions) → my `RV-` → C3 alone.
   `S2-7`'s runner repair rides with C3's runner half. Removing C2 to make a run
   green stays barred. **A stopping rule is pre-registered for a third
   no-comparison landing.**

**Two new MINOR findings raised beyond the dispatch's ask** (`S2-7`, `S2-8`), both
with dv_lead as owner of the defect.

**Handoff**: the file below goes to the orchestrator for commit under
`Agent: dv_lead`, `Work-Order: WO-0078`, `Journal-Entry: J-dv_lead-0154`.

**Lessons harvest**: **not due at this round** — PROTOCOL §7 places it at every
`SO-` and every phase gate, and this is neither. **The span stays open** (open
since `J-dv_lead-0148`, declared rather than skipped). **Two candidates banked,
joining LH-cand-A, LH-cand-B and LH-cand-C:**

- **LH-cand-D (LH2-g)**: *"A repair that changes which inputs a component ACCEPTS
  also changes which outputs it PRODUCES. A fixture pair that checks only the
  accept-or-refuse decision has verified half the repair; the round that widens an
  acceptance boundary states, and checks, what the newly-accepted input causes the
  component to emit."* **LH1**: this round — the guard repair was verified by a
  fixture pair asserting admit and refuse, and the file the newly-admitted schedule
  caused the other producer to write violated a pinned format, costing a full
  round. **LH3**: without it, every acceptance-widening repair discovers its own
  output consequence one integration run later, one layer at a time, and the
  sequence looks like bad luck rather than an unexamined scope.
- **LH-cand-E (LH2-g)**: *"A record format in which a record's owner is implied by
  position rather than named is unambiguous only while one owner can be open at a
  time. Before widening a system so that two owners can be open at once, re-derive
  the format's attributability from the format, rather than re-reading the prose
  that was written when one was the only case."* **LH1**: this round — a grammar
  whose per-record owner is positional was pinned when the system drove one entity,
  carried into a two-entity case, and became genuinely ambiguous rather than merely
  unconventional; the only reader rule that would parse it embeds a behavioural
  assumption about the system under test. **LH3**: without it, the first reader
  either refuses (a lost round) or guesses — and a guess installs an assumption
  inside the very instrument whose job is to detect that assumption's violation.

### Open-questions

1. **`S2-6`'s repair route is genuinely open, and the two visible routes have very
   different costs I could not settle from the reviewer's chair.** Buffering the
   reference writer is local and touches one file; amending the grammar to carry a
   per-`W` frame index touches the pinned interface and **both** producers, and
   `canonical.mli` records that `WO-0075` §2 was *"the first amendment since
   pinning"*. **If the assignee proposes the grammar amendment, my `RV-` will hold
   it to the old-format-trap property (preserved property 4) most severely**, since
   that trap is the reason an un-updated producer cannot produce a false green.
2. **Criterion 3's plural content has now been deferred twice by the same
   accident** — C2 last in the array both times. It closes the first time a
   not-clean case is followed by another case. **The C3 landing is that occasion
   only if C2 is still not clean**, which is the opposite of what the repair round
   is for. If C2 goes green, the property stays unexercised indefinitely and the
   `SO-` should say so rather than let it lapse.
3. **`FINDING RV-0078-S2-3`'s §7 repair still has exactly one carrier** (the co-sim
   Phase 3 CD instance round, `SCOPED, NOT AUTHORISED`), and it now owes **two**
   species of the fourth outcome rather than one. The concern of
   `J-dv_lead-0153`'s open question 2 is unchanged and one degree worse.
4. **`FINDING RV-0078-S2-2` still deserves the auditor's eye before the `SO-`**, and
   `S2-8` is a second structural finding of the same "instrument I own, blind spot I
   own" family. **Two of the three findings raised this round are against my own
   prior work.** That is the second consecutive round with that property, and it is
   either the process working or a signal that my instrument design is running ahead
   of my instrument review — I cannot tell from inside, and I would rather the
   auditor rule on it than assert the charitable reading myself.
5. **The date drift is unchanged and unrepaired.** This entry uses the machine
   clock (2026-08-06), as `J-dv_lead-0151` through `0153` did; `FINDING CD-P2-2`
   records the underlying inconsistency, and no adjudication in this round rests on
   any calendar literal — the verdict is dated by its commit and by this entry.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md

## [J-dv_lead-0155] 2026-08-06T13:20Z | task:WO-0078 | The comparison finally happened and the prediction is spent — two frames agreed on every observable REQ-901 names, and the census that produced the green had a blind spot on the axis it was never asked about

### Trigger

Orchestrator dispatch, sole agent in flight, spawn-head `2efd7f9` — verified as my
first action before anything else was read (`git rev-parse HEAD` →
`2efd7f970edb467b7e5b444b5c76416be8c736f0`, exact match, neither rollback
disposition fired; `git status --porcelain` empty). The commission: adjudicate C2's
**third** landing, at `build` run `31103977231`, the first wholly green run this
lane has had since the case set widened. Seven questions were put to me: C2's
branch selection, `FINDING RV-0078-S2-6`'s closure, `FINDING RV-0078-S1-2`(b)'s
production instance, the ten-item one-frame-assumption census, the coverage claim
and whether `AP-M03` §7 bar 1's lift is lawful to write this round, C2's final
ledger and the stopping rule's disposition, and sequencing.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §6, §7, §10).
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — §0 header and
  `State` field, §3, §6.1–6.3, §7's frozen branch table, §8's bar table, §12's nine
  criteria, §13's routing items, and §14 in full: `RV-STAGE1`, `RV-C1C2`,
  `RV-C1C2-SETTLEMENT`, `RV-C2RERUN`, and tb_writer's `FINDING RV-0078-S2-6` repair
  round return with its ten-item static enumeration.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` §10.0 (what binds every instance,
  including the β-unreachable derivation), §10.1, §10.2, §10.2-bis, §10.7.
- `test/attack_plans/AP-xgmii_rx_64.md` §7 (the four bars, and their per-unit
  composition) — read to rule on the edit, not edited.
- `agents/journals/claude_dv_lead_agent.v07.md`, entry `J-dv_lead-0154` in full,
  including its open question 2, which predicted this round's criterion-3 problem.
- **CI, at the API**: `build` run `31103977231` metadata; `cosim` job
  `92624287637`'s complete log, fetched through the server-side GitHub logs tool and
  read end to end (800 lines; the co-simulation output occupies lines 396–775, the
  remainder being the opam solve and install).
- **Source, at `2efd7f9`, all DV-side and all in my own scope**:
  `test/cosim/tb_xgmii_rx_64.v` (`capture_word`, `write_word_line`, `open_frame`,
  `close_delivery_accept`, `close_delivery_discard`, both `localparam` bounds, all
  five `E`-sentinel call sites), `test/cosim/canonical.mli` (the `divergence` type
  and the grammar block), `test/cosim/canonical.ml` (the `"E"` arm),
  `test/cosim/compare.ml` (fixture construction only).
- **No `libs/**`, no `top/**`, no `rtl_snapshots/**` was opened at any point in this
  round.** PROTOCOL §10's independence rule is intact: every expected value I
  adjudicated against comes from `docs/specs/` text quoted in the packet and the CD,
  or from the comparator's own pinned interface.

### Reasoning

**1. The branch selection, and why "green" is not the argument.** The temptation at
a wholly green run is to read the colour and write α. The colour is the weakest
evidence in the log. What makes C2's α a **branch selection** rather than a green
light is a three-step chain I checked rather than assumed. First, CD §10.0's INSIDE
list for this instance — payload octets, each word's `tkeep` extent, `tuser`[0] on
each `tlast`, and the accept-or-discard decision per input frame. Second, that the
instrument actually compares **all** of it: `canonical.mli`'s `divergence` type has
exactly four constructors (`Missing_frame` keyed by index, `Decision_mismatch`,
`Word_count_mismatch`, `Word_mismatch` over `tkeep|tlast|tuser0|octets`), which
covers the INSIDE list item for item — so `divergences: none` is agreement across
the whole domain, not across a subset a reader might hope is the whole. Third,
CD §10.0's own derivation that β is **unreachable** at 64 octets, which makes the
outcome space two-valued before the run. Only with all three does `compare_exit=0`
select a branch.

**2. What spends a prediction.** The through-line of C2's whole saga is that a
prediction survived two landings. I have said twice that it was unspent; I had to
say **why** the third time spends it, in terms that generalise. A prediction is
spent by **a comparison that could have falsified it** — not by a dispatch, not by a
run, not by both producers producing. C2's first landing had a refusal, its second
had an unreadable file, and each of those is a fact about the instrument, not about
the two designs. **Count comparisons, not runs.** That is why criterion 8's
measurement mattered so much this round: `5c01af0` an ancestor, 129 insertions and
**zero** deletions in the CD across the span, and no CD movement at all in the
repair commit — so the text that could have been falsified is provably the text that
was frozen, and α is a selection under it rather than beside it.

**3. Where the branch's record lives — the CD refused a third time.** I refused a
CD addition at `RV-C1C2` and again at `RV-C2RERUN`, both times on §10.7 item 3
(*"This document freezes the questions; it answers none of them"*). The temptation
this round is stronger, because what I would be adding is a **success**, and a
success feels like it belongs beside the prediction it vindicates. It does not: a
result is a result whichever way it falls, and a freeze document that accumulates
outcomes stops being a freeze. The record lives in §14 and in the `State` field.
Consistency here is not pedantry — a rule I keep only when the answer disappoints me
is not a rule.

**4. The AP edit — earned, and still not owed here.** The bar movement is real: bar
1 lifts for C2's class. I nonetheless did not open `AP-xgmii_rx_64.md`, on §13 item
2's routing (*"owed to the `AP-` round that follows each landed stage"*) and on
`J-dv_lead-0112`'s rule about plan rounds. **Stage 2 is not landed** — C3 and C4 are
not issued — so a bar cell written now must be reopened twice more, and a cell
reopened twice is the left-standing-summary drift `AP-M03` §7 has itself paid for
four times. What I did instead is write the coverage table in the verdict in the
exact form the AP round can lift verbatim, including the class the compound case
does **not** separately anchor. That is the useful half of the work, done in the
document where a result belongs.

**5. The one over-read I had to bar in my own favour.** C2's frame 1 lands in lane 4
at a non-zero admit cycle, so it is tempting to bank a fourth class. CD §10.2 says
in terms that a red at C2 *"could not be attributed between the start lane and the
re-arm path"* — and a **green** cannot be attributed within a case any better than a
red can. Per-case reporting attributes a result **to** a case, never **within** one.
So C2 anchors the compound class as driven and nothing finer. I barred this shape of
claim twice when the runs were red; barring it when the run is green is the only
version of the bar that counts.

**6. The census — adjudicated, not adopted, and the one cell that failed.** Both of
my MATERIAL findings came from this census being incomplete, so accepting its ten
dispositions on the assignee's word would have reproduced the exact failure the
census exists to prevent. Eight items I adopted, one I corrected (item 4's *"already
exercised at two entries in production"* was true of two hops and false of the
third — `compare` never read C2's sidecar at `9de61f1`, which my own criterion-5 row
last round recorded; it is true of all three as of this run, and the evidence is
dated here), and **one I amended, with a finding**. Item 9 introduces
`MAX_WORDS_PER_FRAME = 16` and dispositions it *"inert for every case this lane
ships today"*. That sentence is true and it is the wrong test. 16 words is **128
delivered octets**; REQ-102's range runs to **1518**, a maximum frame delivering
**190 words**; and §6.3's own C7 drives an oversize frame by construction. **This is
the third instance in three rounds of one species: a quantity fixed against today's
stimulus, inside an instrument whose entire purpose is to widen the stimulus.** The
defect is mine — `RV-C2RERUN` §6 property 5 demanded a bound and never stated the
range it must cover, and a worker given a bound with no range picks the range it can
see. What is different this time, and worth more than the finding: **it cost a
reading rather than a landing.**

**7. Completeness, and the axis nobody asked about.** The census answers *where
could a one-frame assumption still be load-bearing*, and it answers it well. C3 and
C4 drive one 64-octet frame, so against that shape every item is inert or already
exercised across three landings; they are authorised. **Stage 3 does not break the
frame-count axis at all** — it breaks **frame length** (C5, C7) and **admission
legality** (C9). `S2-9` is the first hit on the length axis and it was found by
putting a different question to the same code, which is precisely the evidence that
a second census will find more. I converted that from a worry into a **gate
condition** — §6.3 gains (d) a second census and (e) the bound's own repair with its
covering range stated beside it — because a worry recorded in a verdict is a worry
and a condition on a gate is a stop.

**8. `S1-2`(b) — closing a debt that cannot be paid in the currency it was
denominated in.** The finding has two limbs and I separated them rather than ruling
on the pair. Limb (i), per-frame profiles printed for a multi-frame transaction in
production, is discharged here for the first time. Limb (ii), a clean frame's
numbers surviving a divergent sibling, **cannot** be produced in production by any
case in the designed set: C2 is the only multi-frame case and both its frames are
clean by prediction and by observation; every other case drives one frame. The
options were to leave a standing debit that no planned work can pay, or to mint a
stimulus case purely to exercise an instrument property. I took neither: I closed
limb (ii) **on the fixture**, which passed again this run, and attached two things
to the closure — the `SO-` must **say** the limb rests on a fixture rather than on
production evidence, and the closure **re-arms automatically** if a case that could
produce it ever exists. A debit that no work can discharge decays into decoration;
a closure with its residue named and its re-arm stated is a real disposition.

**9. `S2-10` — ruling on my own property against myself.** The repair attributes
every observed output word to `delivery_head`, the oldest open frame. That is
**verbatim** the rule I named one round ago as an unacceptable heuristic. I could
have let it pass unremarked, since the property as written names the reader and the
reader is byte-unchanged. Letting it pass would have been the comfortable reading
and the wrong one. The honest ruling is that the rule is **lawful in a probe and
unlawful in a parser**, and the distinction is epistemic rather than verbal: a
writer at the AXI-Stream boundary reads its attribution off the interface's own
`tlast` framing contract, where a parser downstream of a file in which that framing
was never recorded is guessing. Same rule, different position, and only one position
has a contract behind it. The residue — that head-attribution additionally assumes
in-order delivery, and that a reordering reference would surface as a content
divergence attributable to our RTL — is real, is unstated anywhere pinned, and gets
a **reading rule that binds from this verdict** rather than a repair that would
delay C3.

**10. The stopping rule.** It never fired. The lazy dispositions are to let it lapse
silently or to keep it armed forever. Neither is right: its **question** is answered
— the pinned transaction form **can** express two frames whose admission and
delivery spans overlap, at the grammar unamended — so it is retired **on an answer,
not on a timeout**, which is the only honest way to retire a pre-registered rule.
Its **form** is re-armed for C3 and C4 at the same threshold, written down before
those runs and with the answer not in hand, because the value of pre-registration is
entirely in its date.

**11. Sequencing, and the one amendment that closes a thrice-deferred criterion.**
C3 alone, per §6.2, unchanged. But criterion 3's plural property has now been
deferred **three** times, every time for the same accident — the only not-clean case
was last in the array — and my own open question last round predicted that a green
C2 would leave it unexercised indefinitely. The fix costs one line in the runner:
**the case array becomes `0 C1 C3 C2`**. If C3 diverges as §7 predicts it may, a
not-clean case is followed by another case for the first time in this lane's
history; if C3 is clean, nothing is lost. I checked it is lawful: case 0 stays
first (its sha gate is precedence 1), no stimulus moves so no sha bind is touched
(a bind is per case, never per position), and per-case isolation was established at
`RV-C1C2` §5. A side effect worth having: **C2 becomes a standing regression case**
at every later landing.

**12. What I did not do.** No code. No CD edit. No AP edit. No `SO-` opened. And I
declined a cheap instrument improvement I nonetheless think is right — printing a
`theirs.canon` sha256 per case, which would turn producer-side invariance from a
two-part argument into a measurement — because the existing prints already pin every
field of the record and the format strings are diff-checkable, and because landing
an instrument change inside an adjudication round is the habit this lane has been
paying for. It is recorded as a one-line recommendation for the next round that
opens the runner for its own reasons.

### Actions

- Verified HEAD against the spawn-head before reading anything; proceeded on match.
- Read the charter, PROTOCOL, the work order in full, the CD's §10 instances, and
  `AP-M03` §7's bar table.
- Fetched `build` run `31103977231`'s metadata and `cosim` job `92624287637`'s
  complete log through the server-side GitHub tool; read the co-simulation output
  end to end.
- Ran four mechanical checks on the checkout (below) and one source-level
  spot-check of the repaired writer **against the diff**, which is my charter §3
  review obligation discharged in the only form ADR-0005 permits for this file.
- Appended verdict `RV-C2ALPHA` to `WO-0078` §14 (fourteen sections) and updated
  the packet's `State` field, preserving the superseded text as a quoted historical
  block per the field's own rule.
- Wrote this entry. **Committed nothing and pushed nothing** (PROTOCOL §2).

### Evidence

**All commands run from a repo checkout at `2efd7f9`; all CI references are a run
id and a job id with their conclusions, per PROTOCOL §4.1(b).**

- `git rev-parse HEAD` → `2efd7f970edb467b7e5b444b5c76416be8c736f0`.
- `git merge-base --is-ancestor 5c01af0 2efd7f9` → **true**.
- `git diff --numstat 5c01af0 2efd7f9 -- test/attack_plans/CD-xgmii_rx_64_cosim.md`
  → `129  0` (**zero deletions**).
- `git diff --name-only 9de61f1 2efd7f9` → seven paths; the only code paths are
  `test/cosim/compare.ml` and `test/cosim/tb_xgmii_rx_64.v`. **`canonical.ml`,
  `canonical.mli`, `ours_run.ml` and `stimulus_gen.ml` are absent**, so *the grammar
  is unamended* and *the stimulus did not move* are measurements here.
- `git diff --numstat 53fa1de 2efd7f9 -- test/cosim/stimulus_gen.ml` → **empty**.
- `git diff --numstat 9de61f1 2efd7f9 -- test/cosim/tb_xgmii_rx_64.v test/cosim/compare.ml`
  → `179 48` and `133 2`.
- `git diff 9de61f1 2efd7f9 -- test/cosim/tb_xgmii_rx_64.v | grep -E '^[-+].*"E '`
  → **one line, an addition**: `+ $fwrite(out_fd, "E word-buffer-exhausted\n");`.
  No pre-existing sentinel changed by value; I checked all **four** that exist,
  one more than the Return log's own property-3 accounting names.
- The same diff filtered on `$fwrite` shows the `F`, `W` and `D` format strings
  unchanged in **format**; the only in-string edits move an argument from a live
  wire to a stored `reg` of identical declared width, preserving WO-0049 §3's
  `[8*k +: 8]` fixed-width part-select.
- **CI**: `build` run **`31103977231`**, `head_sha` `2efd7f9…`, run number 508,
  event `push`, conclusion **`success`**; `cosim` job **`92624287637`** green.
  Decisive lines, quoted in `RV-C2ALPHA` §1 with their context:
  `CASE 0: stimulus_sha256=c675517…4cc051 compare_exit=0 tier=CLEAN`;
  `CASE C1: stimulus_sha256=5ae9e4f5…3bd7c compare_exit=0 tier=CLEAN`;
  `CASE C2: stimulus_sha256=cc1e85a4…5b44a7 compare_exit=0 tier=CLEAN`, with
  `frames compared: 2` / `frames matching: 2` / `divergences: none`, `T0: aligned`
  (`frame 0: admit_cycle = 0`, `frame 1: admit_cycle = 10`), `T1: clean` with
  frame 0 at `3 … 10` and frame 1 at `13 … 20`, `T2` `frame 0: [0 × 8]` and
  `frame 1: [1 × 8]`, and `case C2: ours.canon/theirs.canon byte-identical between
  run1 and run2`. Aggregate: *"every case in the set reached a verdict and every
  verdict was clean."* Invocation wall time **`9.665s`**.
- Self-test in the same job: `grep -c 'PASS:'` = **13**, `grep -c 'FAIL:'` = **0**,
  `compare --self-test: OK`, including the new `FINDING RV-0078-S2-8` golden-file
  case (exit 0) and `FINDING RV-0078-S1-2` limb (b)'s case (exit 4).
- **`S2-9`, at source**: `test/cosim/tb_xgmii_rx_64.v` line 258,
  `localparam MAX_WORDS_PER_FRAME = 16`; its guard at lines 317–327 writes
  `E word-buffer-exhausted` last before `$fclose`/`$finish`. 16 words × 8 octets =
  **128 delivered octets**; REQ-102's range is 64 … 1518, a maximum frame delivering
  **190 words** after REQ-103's FCS strip.
- **`S2-10`, at source**: `capture_word` opens `slot = delivery_head % DELIVERY_DEPTH`
  (line 315); only `delivery_head` is closed by `close_delivery_accept`/`_discard`
  (lines 448, 461).
- **Comparator coverage, at source**: `test/cosim/canonical.mli` lines 159–181 —
  four `divergence` constructors covering index presence, decision, word count, and
  `tkeep|tlast|tuser0|octets`.
- **`Canonical.read`'s E arm**: `test/cosim/canonical.ml` line 226,
  `| "E" :: rest, _ ->` — any reason, **regardless of parse state**.
- **I executed no simulation** (ADR-0005) and ran no case. **No CI run exists for
  this commit** and none is claimed: this round lands documents only and dispatches
  nothing.

### Outcome

**DoD vs the dispatch: met, all seven items.**

1. **C2 — ACCEPTED, branch α**, under CD §10.2 unamended, with the three-step chain
   (INSIDE list → the comparator's own four constructors → β unreachable) checked
   rather than assumed. **The prediction is CONFIRMED and SPENT**, and *what spends a
   prediction* is stated generally: a comparison that could have falsified it.
2. **`FINDING RV-0078-S2-6` — CLOSED**, on four independent grounds including a
   diff-level check of the sentinel and format-string contract that goes past what
   the Return log asserted.
3. **`FINDING RV-0078-S1-2`(b) — CLOSED**, limbs separated: (i) discharged in
   production, (ii) closed on the fixture with the reason stated, an `SO-` obligation
   attached, and an automatic re-arm.
4. **The census — eight ADOPTED, one ADOPTED WITH CORRECTION, one AMENDED**, the
   amendment carrying `FINDING RV-0078-S2-9`. **Complete enough for C3 and C4;
   NOT complete for Stage 3**, whose axes it never asked about — converted into
   §6.3 gate conditions (d) and (e).
5. **Coverage — three anchored classes, tabulated per class at per-run ids**, with
   the compound sub-class C2 does **not** separately anchor stated. **Bar 1's lift
   is earned and recorded; the `AP-M03` cell is NOT written this round** (§13 item
   2), the third consecutive refusal of the same edit on the same ground. **No CD
   edit** (§10.7 item 3), also the third.
6. **C2's ledger, corrected**: dispatched **three** times, driven three times,
   `compare` invoked twice, **compared once, agreed once**. **The stopping rule is
   RETIRED on an answer, not a timeout**, and its form is re-armed for C3/C4.
7. **Sequencing — C3 alone, confirmed**, with `S2-7`'s runner repair riding and
   **one amendment: the case array becomes `0 C1 C3 C2`**, closing a criterion
   deferred three times at the cost of one line.

**Two new MINOR findings raised beyond the dispatch's ask** (`S2-9`, `S2-10`), both
with dv_lead as owner of the defect. **That is the third consecutive round in which
the findings I raise are mostly against my own prior work** — see Open-questions.

**Handoff**: the file below goes to the orchestrator for commit under
`Agent: dv_lead`, `Work-Order: WO-0078`, `Journal-Entry: J-dv_lead-0155`.

**Lessons harvest**: **not due at this round** — PROTOCOL §7 places it at every
`SO-` and every phase gate, and this is neither. **The span stays open** (open since
`J-dv_lead-0148`, declared rather than skipped). **Three candidates banked, joining
LH-cand-A through LH-cand-E:**

- **LH-cand-F (LH2-g)**: *"A bound introduced to make a buffer finite is sized
  against the workload in front of its author. In a component whose purpose is to
  widen that workload, state the range the bound must cover in the same change that
  introduces it — the number is not the defect, the missing range is."* **LH1**:
  this round — a per-frame buffer bound landed with its headroom argued against
  today's eight-word frame, in a lane whose own scoped next stage drives a frame
  twenty times longer. **LH3**: without it, every headroom constant is correct until
  the first widening and then costs a full integration round to find, at exactly the
  moment the widening's own result is what everyone is trying to read.
- **LH-cand-G (LH2-g)**: *"The same attribution rule can be sound in a probe and
  unsound in a parser. Judge it by what the component can still see: a probe at an
  interface reads the rule off that interface's own framing contract; a parser
  downstream of a record in which the framing was never written down is guessing.
  When a format loses a fact, move the fix upstream to where the fact is still
  observable, never downstream into a reader taught to infer it."* **LH1**: this
  round — a repair moved per-record attribution out of an ambiguous file and into
  the producer at the interface, and the very rule that had been named unacceptable
  for the reader is the interface's own framing contract for the writer. **LH3**:
  without the distinction a team either forbids a sound repair or permits an unsound
  one, deciding on the rule's wording instead of on its position.
- **LH-cand-H (LH2-g)**: *"A frozen prediction is spent by a comparison that could
  have falsified it — never by a run happening, a job going green, or both sides
  producing output. Count comparisons, not runs; a coverage claim that cites a run
  id instead of a comparison is citing the wrong thing."* **LH1**: this round and
  the two before it — one prediction survived two landings that produced complete
  artefacts on both sides and compared nothing, and was spent by the third. **LH3**:
  without it, an instrument defect is quietly scored as a test of the design, and a
  case's coverage rests on the fact that something ran.

### Open-questions

1. **Criterion 3's plural property is now addressed by an ordering amendment rather
   than discharged, and it may still never fire.** If C3 agrees with the reference,
   no case in the set is ever not-clean and the property stays unexercised through
   the whole of Stage 2. The `SO-` must then state it as a **harness property CI has
   never run** rather than let it lapse — and I would rather the auditor rule on
   whether an unexercised aggregate-continuation path is acceptable in a sign-off
   than assert the convenient answer myself.
2. **`FINDING RV-0078-S2-9` is the third instance of one species and the first found
   by reading.** That is the census working. It is also, read the other way, three
   consecutive rounds in which a quantity sized against the current stimulus was
   found inside an instrument built to widen the stimulus — **by me, in properties I
   wrote.** The second census I have gated Stage 3 on will find more or it will not,
   and either result is informative about my instrument-design review rather than
   about the assignee.
3. **Three of the last five findings I have raised are against my own prior work,
   and this is the third consecutive round with that shape.** I said last round I
   could not tell from inside whether that is the process working or a signal that
   my instrument design is running ahead of my instrument review. **A green run does
   not settle it** — this round's green was produced by an instrument whose own new
   code carried the next defect. The concern is unchanged and I still want the
   auditor's ruling on it rather than my own charitable reading.
4. **`FINDING RV-0078-S1-4` now stands over five never-fired reference-side guards**
   rather than four, and its only discharge point is C9, in a stage that is not
   authorised. A sentinel contract that grows faster than it is exercised is worth
   the auditor's eye before the `SO-` cites the self-test's synthesised fixtures as
   though they were the guards.
5. **`FINDING RV-0078-S2-3`'s §7 repair still has exactly one carrier** (the co-sim
   Phase 3 CD instance round, `SCOPED, NOT AUTHORISED`), unchanged and unscheduled;
   this round adds no third species of the fourth outcome, which is the first round
   that has not made it worse.
6. **The date drift is unchanged and unrepaired.** This entry uses the machine clock
   (2026-08-06), as `J-dv_lead-0151` through `0154` did; `FINDING CD-P2-2` records
   the underlying inconsistency, and no adjudication in this round rests on any
   calendar literal — the verdict is dated by its commit and by this entry.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md

## [J-dv_lead-0156] 2026-08-06T14:21Z | task:WO-0078 | The one to watch was watched and the reference did not drop it — the prediction spent by being wrong, the branch selected by a document that could not have known, and the half of the claim this lane never actually measured

### Trigger

Orchestrator dispatch: adjudicate Stage 2's C3 landing of `WO-0078` — the first
execution of case C3, `CD-xgmii_rx_64_cosim.md` §6's **V7**, *"the one to watch"* —
at spawn-head `9685c52`, `build` run `31108528759`, `cosim` job `92639903296`,
**wholly green**. Six questions were put to me: C3's branch selection under CD §10.3
and `FINDING CD-P2-1`'s own polarity resolution; the disposition of
`FINDING RV-0078-S2-7` and of the worker's disclosed widening beyond it; worker
conduct on a fourth dispatch-citation catch; coverage and whether the `AP-` edit is
lawful this round; sequencing; and whether the accumulating lane-4 offset earns a
standing note anywhere lawful. Sole agent in flight.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §6, §10).
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — the State field,
  §7's branch table and definitions, §8's bar table, §12's nine criteria, §13's
  routing, and §14 in full including `RV-STAGE1`, `RV-C1C2`, `RV-C1C2-SETTLEMENT`,
  `RV-C2RERUN`, `RV-C2ALPHA` and both C3-landing Return-log halves.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` — §5.1/§5.2 (D1–D5, X1–X5), §6's
  frozen V1–V7 table, §9/§9-bis, §10.0, **§10.3**, §10.4, **§10.5**, §10.6, §10.7.
- `test/attack_plans/AP-xgmii_rx_64.md` §7 — the banner's per-class restatement and
  bars 1–4; §9's change log for the bar's provenance.
- `docs/specs/requirements.md` — **REQ-104** verbatim, REQ-005, REQ-013, REQ-901.
- Inside my own scope, read as instruments and never as a source of an expected
  value: `test/cosim/canonical.mli` (the four `divergence` constructors),
  `test/cosim/canonical.ml` (the clean-path report printer, lines 447–458),
  `test/cosim/stimulus_gen.ml` (`build_c2`, `build_c3`, `known_cases`),
  `tools/cosim/run_cosim.sh` (`print_case_summary` at 1382 and its four call sites;
  `CASE_HAS_RESULT` in all seven `DIFF_RC` arms; the `CASES` array),
  `test/xgmii/arrival.mli` (the 84-octet spacing and lane alternation contract), and
  `test/xgmii_rx_64/test_m03_d.ml` (M03-D1's REQ-104 assertions and its anti-vacuity
  partner).
- CI, through the server-side GitHub tool: `build` run **`31108528759`** metadata
  and `cosim` job **`92639903296`**'s complete log, read end to end; and — for the
  cross-run comparison §5 of the verdict rests on — the **previous** landing's
  `cosim` job **`92624287637`** (run `31103977231`, at `2efd7f9`).
- **No RTL.** `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` were not opened.

### Reasoning

**1. The question this round was actually asked, and the one it should have been
asked.** The dispatch asked me to *"say plainly what the measured fact is: the pinned
reference passes bad-FCS frames through marked, as REQ-104's model does."* Half of
that sentence is a measurement and half of it is not, and finding the seam took most
of the round. **The pass-through half is measured on the reference's own side of the
record**: T2 prints `theirs cycles = [3 4 5 6 7 8 9 10]`, eight words, absolute, and
the frame is present at index 0 with an agreeing decision and word count. Nothing
from our side is needed for it. **The marked half is not printed anywhere.**
`Canonical`'s clean-path report emits `frames compared` / `frames matching` /
`divergences: none` and never a value. So *"divergences: none"* on the `tuser0` field
is consistent with both sides setting the mark **and** with both sides omitting it —
the second of which would additionally mean our RTL violates REQ-104. The run cannot
tell those worlds apart. Family D's M03-D1 can, and does, at both start lanes, under
a mutation campaign, with an anti-vacuity partner asserting the bit **clear** on a
good frame so the assertion is not satisfiable by a constant. **So the claim is true
and it is a pair**, and I wrote it as a pair with both instruments cited rather than
as a measurement this lane made. That is `FINDING RV-0078-S2-11`, and it is against my
own comparator design.

**2. Why I did not soften that into a footnote.** The temptation was real: the
conclusion is not in doubt, the inference is two steps and both are solid, and writing
"the reference forwards and marks" would have been read by everyone as correct. It
*is* correct. But **CD §6's V7 row and REQ-104's own verification column both turn on
the mark**, and this lane is the programme's external anchor. An anchor that is cited
for a value it never printed is exactly the failure the charter's anchor-before-judge
rule exists to prevent, one level up: not a model judging without an anchor, but an
anchor being credited with a measurement it did not make. **The cost of stating it as
a pair is one sentence. The cost of not stating it is that a later `SO-` cites the
co-sim for REQ-104's mark and nobody can find where the value was read.**

**3. The branch, and the part of it that is not mine to decide.** C3's cell pair in
§7 is the one `FINDING CD-P2-1` convicted: γ sits under *"branch if it fails"* for a
prediction **of divergence**, and the agreement outcome is *"—"*. Read literally, a
falsified prediction selects γ — and γ is defined as *"the divergence falls outside
every declared class"* when **there is no divergence**. A branch whose definition has
no instance cannot be selected by a column heading. **CD §10.5 resolved this at
`5c01af0`, from §7's own definitions, three landings before C3 ran**, and I checked
rather than assumed: `5c01af0` is an ancestor, and the CD diff across the span is one
hunk, 129 insertions, **zero deletions**, entirely §10.2-bis. **So α is a reading,
not a choice.** This is the first case in this lane where criterion 8 did work that
mattered: had the blank still been blank, an adjudicator holding a green C3 and a
table naming only γ would have been free to write the branch with the answer in hand.
The finding is therefore **DISCHARGED AS TO C3** and stands at C4, C8 and C9 — and I
recorded C4's agreement outcome as α **before C4 runs**, which costs nothing now and
cannot be bought later.

**4. A prediction spent by being wrong, which is the only kind worth writing.** CD §6
called V7 *"the one to watch"* and predicted the reference would drop bad-FCS frames —
*"the commonest store-and-forward instinct"*. It does not. **The prediction graded
wrong, and that is the outcome that makes §6 worth having**: a prediction section that
is never wrong is a section nobody was risking anything on. It is spent for the reason
`RV-C2ALPHA` fixed generally — a comparison that could have falsified it took place —
and here the falsification route was the most visible one available, a `Missing_frame`
divergence at index 0. It did not fire.

**5. The refusal I made for the fourth time, and the reason I had to replace.** Three
prior rounds refused the `AP-M03` §7 bar-1 cell on **cost**: a cell written now must
be reopened twice more. **That arithmetic expired this round** — C4 is one landing
away, so it would be reopened once. I could have kept the conclusion and left the dead
reason standing, which is precisely the left-standing-summary defect §7's own banner
was corrected for and which this plan has paid for four times. So I said the ground had
expired and moved to a better one: **§13 item 2's own routing rule — the `AP-` round
follows a landed *stage*, not a landed case** — and Stage 2 is not landed. **And a
refusal repeated four times needs a condition or it becomes a habit**, so I attached
one: the `AP-` round may not be deferred past C4, and if it is, that is a finding
against me, recorded now so it is checkable rather than remembered.

**6. The widening, and the axis it turned on.** data_wrangler implemented
`FINDING RV-0078-S2-7`'s repair across **every** did-not-reach-a-verdict tier rather
than the two the finding's own diagnosis named, and **disclosed the gap as an open
question**. I adopted it, and the ground I put most weight on is the fourth: **the
widening can only ever subtract a claim.** Every case it newly reaches loses a
sentence asserting timing evidence and coverage and gains one asserting neither. A
change whose only possible effect is to remove assertions cannot manufacture a false
coverage claim, which is the one direction criterion 9 polices. The second ground
matters too and I checked it at source in all seven arms: the flag keys on **reached a
verdict**, not on **was clean**, so exits 1 and 4 — a content divergence and a
T1-negative — still print the full SUMMARY. Keyed on cleanness it would have
suppressed the coverage sentence for exactly the cases whose results matter most.

**7. And reading that repair produced a second finding I did not go looking for.**
`compare` reaches a **content** verdict before T0 and T1 run. At exit 5 (T0 unaligned)
and exit 6 (T1 unassertable), content has therefore already been compared and only the
timing tiers were withheld — yet the SUMMARY prints *"it did not reach a comparison
verdict"*. That is stronger than the truth. The direction is safe: it discards a claim
rather than inventing one, so nothing adjudicated to date is affected. **The future
cost is real** — a case agreeing on every REQ-901 observable while T1 declines has
genuinely anchored its class for content, and a `SO-` reading the SUMMARY as the
authority would throw that anchor away. One bit is spanning two questions. That is
`FINDING RV-0078-S2-12`, and the axis is mine.

**8. What I refused to bank, again.** C2's frame 1 is a lane-4 start at a **non-zero**
admit cycle, and I re-derived it this round from `arrival.mli`'s own contract (*"84 is
not a multiple of 8, so the start lane alternates 0, 4, 0, 4"*) rather than carrying it
on my own prior sentence. It remains tempting to bank a separable class from it and it
remains barred: per-case reporting attributes a result **to** a case, never **within**
one. I barred this shape twice when the runs were red and once when C2 went green;
barring it a third time on a run where a fourth class arrived by a legitimate route is
the only version of the bar that counts.

**9. The offset, and the trap on the far side of consistency.** The dispatch called
this the fourth consistent recording; measured against the logs it is the **fifth**,
and I corrected the count for the same reason I commend a worker for correcting a
citation. More useful than the count: the five span **two different geometries** of a
lane-4 start — C1's on the reset-release cycle at `admit_cycle = 0`, C2 frame 1's
mid-stream at `admit_cycle = 10` after the re-arm — so the consistency is across
constructions, not repetitions. **The vessel ruling is unchanged and the reasoning is
the point: accumulation changes how well-established a datum is, never what the datum
is.** It is X1, outside the domain, five times over exactly as it was once — the run
is the primary record, this verdict the adjudicative one, the `SO-` the forward
carrier; not the CD (a result is not a question) and not the `AP-` (a cross-side cycle
datum beside the bar forbidding cross-side cycle comparison is misread as the bar
lifting). What accumulation *does* earn is a reading aid — a provenance tripwire on
the reference pin — and the trap beside it is that a stable, reproducible datum is
exactly what someone will want to assert. **Bar 3 forbids that comparison whichever
door it arrives through, including a regression check's.**

**10. The check that carried the most weight, and it is one line of `git`.**
`git diff --numstat 2efd7f9 9685c52` over `compare.ml`, `canonical.{ml,mli}`,
`ours_run.ml` and `tb_xgmii_rx_64.v` is **empty**. **C3 was judged by an instrument
byte-identical to the one that had already agreed on C2 under adjudication and that
passes thirteen seeded self-test fixtures, and nothing in the comparison path moved in
the commit that produced C3's green.** A green produced by a freshly-edited comparator
would have been worth much less, and this is the round where that distinction was
cheap to establish and would have been expensive to have to argue later.

**11. The prediction of mine that came true in the direction I did not want.**
`J-dv_lead-0155` Open-question 1 said that if C3 agreed, criterion 3's plural property
would stay unexercised through the whole of Stage 2. **C3 agreed.** The `0 C1 C3 C2`
amendment bought the capability and C3's cleanness meant it did not fire, so the
property is unexercised after **four** landings. The amendment was still right — one
line, lawful, armed for C4 — but I recorded plainly that it has not paid, that I said
in advance it might not, and that the `SO-` must state it as a harness property CI has
never run. I repeat the request that the **auditor** rule on whether an unexercised
aggregate-continuation path is acceptable in a sign-off, rather than assert the
convenient answer myself.

**12. Worker conduct, and the count that is now load-bearing.** data_wrangler caught
a dispatch of mine citing *"the amended criterion 7"* where the finding invokes
criterion **9**, read the packet directly, corrected the script's comments and its
Return log to 9, and flagged it. **Harder than the first catch of this species**,
because a wrong criterion number in a comment produces **nothing observable**: the
script runs identically and the damage is entirely downstream, in a reader who follows
a citation to a criterion that does not say what the comment claims. In a lane whose
entire output is documents citing each other, that is the more expensive failure and
the one nobody is forced to notice. **No new rule**: the existing obligation — a
dispatch quotes a section number from the file — covers it exactly, and minting a
second rule for the fourth instance of a species the first rule already covers makes
the rule set larger without making it stronger. **But the obligation hardens in
form**: a dispatch carrying a finding SHALL carry the finding's own text as a block
quotation rather than a paraphrase with citations. That removes the opportunity
instead of policing it, costs the dispatching round nothing, and addresses the real
structural fact — a dispatch prompt is not a committed artefact, so nothing checks it
and nothing can annotate it afterwards. **All four errors are mine; all four were
caught by assignees. A control that runs from worker to lead is working, and is the
wrong direction to design around.**

### Actions

- Verified HEAD against the spawn-head before reading anything; proceeded on match.
- Read the charter, PROTOCOL, `WO-0078` (State field, §7, §8, §12, §13, §14 in full),
  CD §5/§6/§9-bis/§10 in full, `AP-M03` §7's banner and bar table, REQ-104's row.
- Fetched `build` run `31108528759`'s metadata and `cosim` job `92639903296`'s
  **complete** log through the server-side GitHub tool; de-escaped and read all 699
  lines. **Additionally fetched the previous landing's job `92624287637`** so the
  has-result SUMMARY could be diffed across the repair in production rather than in a
  stub.
- Ran six mechanical `git` checks on the checkout and four source-level reads inside
  my own scope (`canonical.mli`'s constructors, `canonical.ml`'s report printer,
  `run_cosim.sh`'s repaired printer and all seven `DIFF_RC` arms, `arrival.mli`'s lane
  contract) — my charter §3 review obligation discharged in the only form ADR-0005
  permits here.
- Appended verdict `RV-C3ALPHA` to `WO-0078` §14 (fifteen sections, 0–14) and updated
  the packet's `State` field, preserving the superseded text as a quoted historical
  block per the field's own rule.
- Wrote this entry. **Committed nothing and pushed nothing** (PROTOCOL §2).

### Evidence

**All `git` commands run from a repo checkout at `9685c52`; all CI references are a
run id and a job id with their conclusions, per PROTOCOL §4.1(b).**

- `git rev-parse HEAD` → `9685c521f689dee3f9136f931655d79efbda984b`.
- `git merge-base --is-ancestor 5c01af0 9685c52` → **true**.
- `git diff --numstat 5c01af0 9685c52 -- test/attack_plans/CD-xgmii_rx_64_cosim.md`
  → **`129  0`** (one hunk, **zero deletions**; it is §10.2-bis, after §10.2). §10.3
  and §10.5 are byte-unmoved since the freeze.
- `git diff --numstat 5c01af0 9685c52 -- test/attack_plans/AP-xgmii_rx_64.md`
  → **empty**.
- `git diff --numstat 50983b1 9685c52` → five paths; the only two code paths are
  `test/cosim/stimulus_gen.ml` (`55 1`) and `tools/cosim/run_cosim.sh` (`191 13`).
- `git diff --numstat b10546c 9685c52 -- test/cosim/stimulus_gen.ml` → **empty** (the
  runner half did not touch the stimulus half's file).
- **`git diff --numstat 2efd7f9 9685c52 -- test/cosim/compare.ml test/cosim/canonical.ml
  test/cosim/canonical.mli test/cosim/ours_run.ml test/cosim/tb_xgmii_rx_64.v` →
  EMPTY.** The comparator, grammar, our producer and the reference testbench are
  byte-unchanged from the tree that produced C2's α.
- `grep -n '"C3"' tools/cosim/run_cosim.sh` → the literal appears in the `CASES` array
  (line 903) and in header commentary; **in no conditional**.
- **CI, run `31108528759`** (`head_sha` `9685c52`, run number 511, event `push`,
  conclusion **`success`**, `13:58:54Z → 14:04:36Z`); **`cosim` job `92639903296`**.
  Decisive lines, quoted with their context in `RV-C3ALPHA` §1:
  `=== CASE SET (WO-0078 §6.2 Stage 2: 4 case(s) — 0 C1 C3 C2) ===`;
  `CASE 0: stimulus_sha256=c675517…4cc051 compare_exit=0 tier=CLEAN`;
  `CASE C1: … 5ae9e4f5…3bd7c … tier=CLEAN`;
  **`CASE C3: stimulus_sha256=1512d30b6aa186ca89d55ce40fbcfdee01590a5a47e2a497eb4389c2bc6c4dce compare_exit=0 tier=CLEAN`**
  with `frames compared: 1` / `frames matching: 1` / `divergences: none`,
  `T0: aligned` (`frame 0: admit_cycle = 0`), `T1: clean` with words at `3 … 10`,
  `T2` `frame 0: theirs cycles = [3 4 5 6 7 8 9 10]` and `theirs - ours per word =
  [0 0 0 0 0 0 0 0]`, and `case C3: ours.canon/theirs.canon byte-identical between
  run1 and run2`;
  `CASE C2: … cc1e85a4…5b44a7 … tier=CLEAN` with `frames compared: 2` /
  `frames matching: 2`, `frame 0: admit_cycle = 0` / `frame 1: admit_cycle = 10`,
  T1 clean at `3 … 10` and `13 … 20`, T2 `[0 × 8]` and `[1 × 8]`.
  Aggregate: *"every case in the set reached a verdict and every verdict was clean."*
  Invocation wall time **`8.965s`**.
- **Self-test in the same job**: `compare --self-test: OK`; `grep -c 'PASS:'` = **13**,
  `grep -c 'FAIL:'` = **0**.
- **The cross-run SUMMARY comparison** — job `92624287637` (run `31103977231`, at
  `2efd7f9`, **pre-repair**) versus job `92639903296` (**post-repair**): the
  `=== SUMMARY (case N) ===` blocks for case 0, C1 and C2 are **identical line for
  line** — `reference pin`, `simulator`, `stimulus sha256` and all four lines of the
  `timing:` block — with exactly one field differing, `runner image: ci:ubuntu24
  (GitHub Actions 1000001556)` → `(GitHub Actions 1000001569)`, which is a property of
  the GitHub runner and not of the script.
- **The lane-4 offset, five recordings**: `[1 1 1 1 1 1 1 1]` at C1 frame 0 in run
  `31096150983` / job `92598555141` (quoted at `RV-C1C2` §3); at C1 frame 0 **and**
  C2 frame 1 in run `31103977231` / job `92624287637`; and at C1 frame 0 **and** C2
  frame 1 in run `31108528759` / job `92639903296`. Four of the five read by me this
  round from the two job logs.
- **`S2-11`, at source**: `test/cosim/canonical.ml` lines 447–451 print
  `frames compared` / `frames matching` / `divergences: none` and **no agreed value**;
  `canonical.mli` lines 159–181 confirm `tuser0` **is** inside `Word_mismatch`'s
  compared field set, so the comparison is real and only the record is relational.
- **The mark's independent authority, at source**: `test/xgmii_rx_64/test_m03_d.ml`
  lines 140–141 — `if s.out.…tuser <> 1 then fail row "tuser[0] is not set on a
  bad-FCS frame (REQ-104)"` — with its anti-vacuity partner at lines 381–382 asserting
  `tuser`[0] = 0 on a legal good-FCS frame.
- **`S2-12`, at source**: `tools/cosim/run_cosim.sh` — `print_case_summary` at line
  **1382**; call sites at **1418**, **1463**, **1655**, **1689**; `CASE_HAS_RESULT` =
  1 at exits 0, 1, 4 and = 0 at exits 3, 5, 6 and the wildcard (lines 1548–1601). The
  `has_result = 0` text reads *"it did not reach a comparison verdict"* while exits 5
  and 6 have reached a **content** verdict.
- **C2 frame 1's start lane, re-derived rather than carried**: `test/xgmii/arrival.mli`
  lines 34–36 — *"84 is not a multiple of 8, so the start lane alternates 0, 4, 0, 4"*.
- **REQ-104, verbatim** (`docs/specs/requirements.md`): *"On mismatch it SHALL set
  `tuser`[0] = 1 on the `tlast` word and pulse `error_bad_fcs`. The frame SHALL still
  be forwarded (cut-through, REQ-005)."*
- **I executed no simulation and ran no case** (ADR-0005). **No CI run exists for this
  commit and none is claimed**: this round lands one document and dispatches nothing.

### Outcome

**DoD vs the dispatch: met, all six items.**

1. **C3 — ACCEPTED, branch α**, under CD §10.3 unamended, selected from §7's branch
   **definitions** via CD §10.5's pre-committed resolution rather than from the
   table's backwards polarity. **CD §6's V7 is ANSWERED and its prediction FALSIFIED
   and SPENT — the reference did NOT drop the bad-FCS frame.** The measured fact is
   stated in its two halves: **forwards** (measured on the reference's own side) and
   **marks** (this run's `tuser0` agreement **paired with** family D's M03-D1, not the
   co-simulation alone). `FINDING CD-P2-1` **DISCHARGED AS TO C3**; standing at C4,
   C8, C9, with C4's α recorded before C4 runs.
2. **`FINDING RV-0078-S2-7` — CLOSED at the limb it repairs**, on **production**
   byte-identity across the repair plus the negative control, with the structural
   residue named (the no-result branch has never run in CI), an `SO-` obligation
   attached, and an automatic re-arm. **The disclosed widening — ADOPTED**, on four
   grounds; the run2-refusal sub-decision **ruled CORRECT**; one reading rule now
   binds (a tier is not a coverage warrant without its SUMMARY and determinism line).
3. **Worker conduct — CORRECT and COMMENDED**, and harder than the first catch of the
   species because it produced nothing observable. **No new rule** for the
   orchestrator's fourth dispatch-citation error; the existing obligation **hardens in
   form** to block-quotation of a finding's own text.
4. **Coverage — FOUR anchored classes**, tabulated per class at run ids, with five
   things class 4 does **not** anchor stated beside it. **`AP-M03` §7 bar 1's owed
   lifts number three.** **The `AP-` cell is NOT written — the fourth refusal**, on
   **§13 item 2's routing rule** after the cost ground expired, **with a condition
   attached**. **No CD edit** — also the fourth.
5. **Sequencing — C4 alone, CONFIRMED unamended**, its stimulus and observables quoted
   from CD §10.4 (X4 excludes the octet **values**, never the **decision** they
   cause). **The stopping rule's re-armed form needs no re-arming**: C3 reached a
   comparison on its first landing.
6. **The lane-4 offset — five recordings across three runs and two geometries**,
   count corrected against the logs from the dispatch's four. **Vessel ruling
   UNCHANGED**: run, verdict, `SO-`; not the CD, not the `AP-`. Accumulation earns a
   provenance tripwire and **never** an assertion — bar 3 forbids that comparison
   whichever door it arrives through.

**Two new MINOR findings, both against my own instrument design** (`S2-11`, `S2-12`).
**That is the fourth consecutive round with that shape** — see Open-questions, where I
note the one respect in which this round's two differ from the previous rounds' and
decline to grade myself on it.

**Handoff**: the file below goes to the orchestrator for commit under
`Agent: dv_lead`, `Work-Order: WO-0078`, `Journal-Entry: J-dv_lead-0156`.

**Lessons harvest**: **not due at this round** — PROTOCOL §7 places it at every `SO-`
and every phase gate, and this is neither. **The span stays open** (open since
`J-dv_lead-0148`, declared rather than skipped). **Three candidates banked, joining
LH-cand-A through LH-cand-H:**

- **LH-cand-I (LH2-g)**: *"A comparison that reports only whether two sides agree
  cannot tell you what they agreed on. Where the interesting fact about a case is a
  value rather than a relation, print the agreed value on the passing path — and until
  you do, write the claim as the pair of instruments it actually rests on, naming
  both."* **LH1**: this round — a differential case whose entire subject was a status
  bit was reported as agreeing without the bit's value appearing anywhere in the
  record. **LH3**: without it, a green differential run is credited with measuring a
  value it never printed, and the coverage claim rests on an inference nobody wrote
  down and a later reader cannot locate.
- **LH-cand-J (LH2-g)**: *"A quantity whose comparison is barred does not become
  assertable by reproducing. Reproduction earns confidence, never jurisdiction — and
  the likeliest breach is not an argument for lifting the bar but a regression check
  quietly asserting the stable value."* **LH1**: this round — a cross-side latency
  offset reproduced five times across three runs and two independent constructions,
  under a standing bar on comparing that quantity at all. **LH3**: without it a
  deliberate exclusion decays into an assertion through a side door, and the bar ends
  up lifted by nobody's decision and recorded in no document.
- **LH-cand-K (LH2-g)**: *"When the reason a standing refusal rested on expires, say so
  and replace the reason before restating the conclusion — and attach a condition, or
  a repeated 'not yet' becomes a permanent 'no' that nobody ever decided."* **LH1**:
  this round — a fourth refusal of the same edit whose original cost argument had
  ceased to be true, re-grounded on a routing rule and given an expiry. **LH3**:
  without it a live judgement is carried by a dead reason, which reads as settled to
  everyone downstream and is unfalsifiable because the reason is no longer checked.

### Open-questions

1. **Criterion 3's plural property is unexercised after FOUR landings, exactly as I
   predicted a green C3 would leave it.** The ordering amendment armed it and cost one
   line; C3's cleanness meant it did not fire. If C4 also agrees, no case in Stage 2 is
   ever not-clean and the property goes to the `SO-` never having run in CI. **I want
   the auditor's ruling on whether an unexercised aggregate-continuation path is
   acceptable in a sign-off**, not my own charitable reading of it.
2. **The fourth consecutive round in which the findings I raise are mostly against my
   own prior work — and the shape has changed in one respect I do not know how to
   weigh.** `S2-9` and `S2-10` were bounds and attribution defects that could have
   produced a **wrong** result. `S2-11` and `S2-12` can only produce a **weaker** one:
   both under-inform and neither can over-claim. That may be evidence that my
   instrument review is catching up with my instrument design, or it may be the same
   problem in a corner where it happens to be harmless. **A green run does not settle
   it and neither does my own reading of the trend.** The concern is unchanged and the
   ruling I want is still the auditor's.
3. **`FINDING RV-0078-S2-11`'s repair has no scheduled carrier.** No authorised round
   is due to open `compare.ml` or `canonical.ml`. If none opens before the `SO-`, the
   `SO-` round inherits it — and it will need the value to write REQ-104's row
   honestly, so the debt is genuinely payable rather than decorative. Recorded so it is
   not rediscovered at the sign-off.
4. **`FINDING RV-0078-S1-4` still stands over five never-fired reference-side guards**
   and its only discharge point remains C9, in a stage that is not authorised.
   Unchanged this round — no refusal fired at any case — and worth the auditor's eye
   before the `SO-` cites the self-test's synthesised fixtures as though they were the
   guards.
5. **`FINDING RV-0078-S2-3`'s §7 repair still has exactly one carrier** (the co-sim
   Phase 3 CD instance round, `SCOPED, NOT AUTHORISED`), unchanged and unscheduled;
   this round adds no new species of the fourth outcome, which is the second
   consecutive round that has not made it worse.
6. **The `AP-` debt now has an expiry and it is the first one I have attached to my own
   refusal.** If C4 lands and the `AP-` round does not immediately follow, that is a
   finding against me by the terms I wrote this round. Recorded here so the auditor can
   check it against the commit that carries C4 rather than take my word for it later.
7. **The date drift is unchanged and unrepaired.** This entry uses the machine clock
   (2026-08-06), as `J-dv_lead-0151` through `0155` did; `FINDING CD-P2-2` records the
   underlying inconsistency, and no adjudication in this round rests on any calendar
   literal — the verdict is dated by its commit and by this entry.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md

## [J-dv_lead-0157] 2026-08-06T14:51Z | task:WO-0078 | The hook was one directory over the whole time — a worker's correct four-module negative superseded by a landed, reviewed, mutation-scored bench that builds the exact stimulus, both remediation paths refused, and the census rule given the third dimension it was missing: polarity

### Trigger

Orchestrator dispatch, sole agent in flight, a RULING round. tb_writer returned
`WO-0078` Stage 2's C4 landing **NOT BUILT** at `ad32dff` with a construction-surface
gap and two named-but-unchosen remediation paths, and the choice was routed to me:
*"C4's construction surface has a gap and the choice of remediation path is yours."*
Four questions were put — the path with its exact scope, whether the gap itself needs
a finding, how my own `RV-C3ALPHA` §10 condition reads under a delay the `AP-` question
did not cause, and the sequencing after the ruling.

### Inputs

- **Abort-first head check**: `git rev-parse HEAD` = `ad32dffc6749a71cb3f3f08283b3cdb14d503831`,
  exactly the stated spawn-head (*"C4 stops before it starts…"*). Match; no mismatch
  procedure. Working tree clean at entry.
- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, both in full this round.
- `agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md` — §2.2 (the two-producer
  refusal census), §5, §6.1–§6.3, §7, §10, §11, §12, §13, and §14 at `RV-C2ALPHA` §7
  (the ten-item one-frame census and its completeness ruling), `RV-C3ALPHA` §10 (my own
  `AP-` condition) and §12 (the C4 sequencing and its restatement of CD §10.4), and
  tb_writer's C4 Return-log entry in full.
- `agents/journals/workers/claude_tb_writer_agent.v03.md`, `J-tb_writer-0039` in full.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` — §10.0, §10.4, §10.5, §10.7.
- **Re-derived rather than adopted** — the four modules tb_writer's negative rests on,
  read at this tree at the lines its Return log cites: `test/xgmii/arrival.mli`
  (`create`'s three optional arguments at :88-93; `in_times`'s contract at :111-116;
  `word_at`'s totality at :124-127), `test/xgmii/arrival.ml` (:17 `preamble_octets`,
  :101-107 the unconditional 0x55/0xD5 emission, :157-172 `check`'s five-octet floor and
  REQ-304 residue), `test/xgmii/frame.mli`, `test/xgmii/injection.mli` (the two-
  constructor public `corruption` type) and `injection.ml` (:60-66 `is_control_char`,
  :96-101 the `Place` refusal, :175 `Control` not `Data`), `test/xgmii/xgmii_word.mli`.
- **The read that reversed the round, and it is the one nobody asked for**:
  `test/attack_plans/AP-xgmii_rx_64.md`'s family-B rows — `M03-B1` (REQ-102, ASSERT) —
  and `test/xgmii_rx_64/test_m03_b.ml:1-100`, which discharges it.
- `test/cosim/stimulus_gen.ml` in full, for the case idiom C4 must match.
- **REQ ids and spec sources this ruling derives from**: REQ-102 (the eight preamble
  octets and the prohibition on validating them), REQ-103, REQ-304 (the residue),
  REQ-901 (the comparison domain and its closing sentence), SPEC-M03 §6.1's cycle table
  (the 0x55 filler / 0xD5 SFD literals the C4 values are derived to differ from).
- **No `libs/**`, no `top/**`, no `rtl_snapshots/**`, and no line of
  `test/third_party/verilog-ethernet/**` was opened this round by any means.** The
  stimulus values fixed in the ruling are derived from SPEC-M03 §6.1 and from a landed
  DV-side bench, never from the implementation this lane compares against.

### Reasoning

**I do not adopt a negative on a Return log's assertion.** tb_writer made a
*capability* claim — *"no lawful hook exists"* — and a whole round was about to be
built on it, so I re-derived all four of its module readings at the lines it cites.
**All four are exact**: `Arrival`'s preamble emission is hardcoded and unreachable from
`create`; `Frame` disclaims the preamble; `Injection`'s public `corruption` type has
two constructors, one addressed to frame octets and one validated against five control
characters and written as `Control`, never `Data`; `Idle_injection` is orthogonal. The
worker read the `.ml`s rather than the docstrings, which is the right standard for a
negative, and it declined an in-scope bypass rather than take it silently. **That stop
is worth commending on its own terms: had it built path (b), I would be adjudicating a
green run on an unreviewed construction instead of choosing one.**

**But the conclusion is wider than the measurement.** *"No lawful hook exists"* was
asserted over *"the full set reachable"* and measured over **four modules of
`test/xgmii/`**. The set that governs is *every landed construction of this stimulus*,
and it has a member no module census could see, because it is a bench.

**`M03-B1`.** My own `AP-M03`, REQ-102, status ASSERT: *"64-octet frame whose six
filler octets and SFD octet are arbitrary non-standard **data** values, both start
lanes."* **That is CD §10.4's stimulus word for word, and it is discharged** —
`test/xgmii_rx_64/test_m03_b.ml` builds it, landed, reviewed, and inside the `WO-0066`
family-B/N campaign's scored set. Its header reaches tb_writer's exact conclusion about
`Arrival`, cites the same `.mli` sentence, and then builds the stimulus anyway by
composition through `Bench.run`'s `?word_at` — characterising it at the time as
*"machinery composition, not a new capability."*

**Three properties of `test_m03_b.ml:28-51` decided the path, and each is checkable at
the line.** Its `is_preamble_lane` derives from `frame.start_lane` and
`Arrival.start_cycle frame` — `Arrival`'s **own published accessors** — against
SPEC-M03 §6.1's text, so it re-derives no private literal. It leaves the start
character and the whole `control` field untouched. And it is mutation-scored.

**Path (a), `Arrival.create ?preamble`, refused, and the first ground would have
refused it even without `M03-B1`.** A shared-machinery affordance is warranted when no
existing mechanism expresses the stimulus; one does. `?preamble` would create a second
mechanism for one stimulus while the first stays in use at a bench I would not reopen
to migrate — **permanent duplication, which is the definition of the creep and not an
exception to it.** Beyond that: a census at this tree puts **fourteen** consumers of
`Arrival` across five directories, so the no-op-default property, though mechanically
checkable by four stimulus shas plus the M03 suite, costs a landing's review to reach a
capability that already exists; and it reverses a decision `arrival.mli` states under
the heading *"What the model does not decide"* — a decision, not a gap — to serve one
case in one lane.

**Path (b) as tb_writer framed it, refused on the worker's own reasoning, upheld
unchanged**: a second copy of a geometry is a second thing that can drift, and a
stimulus file whose emitter's `report`/`check` describe a different schedule has
provenance a reviewer cannot reconstruct.

**Path (c), authorised, and the thing that makes it not-path-(b) is a public accessor
neither the worker nor I had looked at.** `arrival.mli:111-116` publishes `in_times`,
whose contract says in terms: *"the eight preamble octets from the start character
inclusive, then the frame's octets."* **`Arrival` already tells a caller where its own
preamble lies.** So the override reads its positions from `in_times` entries 1-7 —
reaching *through* the public contract rather than *around* it, which is precisely the
distinction tb_writer's objection did not draw and which `in_times` draws for it. The
one remaining constant, that the preamble is eight octets, is REQ-102's own figure and
is tied back to `Arrival` by a length tripwire that fails construction with a message
naming REQ-102 if the model's preamble count ever moves.

**What path (c) costs, stated rather than waved.** Every case comment in
`stimulus_gen.ml` states *the file written out IS `Arrival.create`'s own schedule,
nothing hand-patched* — and C4 is the first case to depart from it. I paid it three
ways rather than deny it: the departure is **named** in the case comment with
`test_m03_b.ml` cited as precedent; it is **bounded** by a mandatory three-part check
(exactly seven differing octet positions, at exactly `in_times`'s seven, `/S/` intact,
`control` bit-identical, nothing outside the preamble moved) which `M03-B1` itself does
not carry and which C4 needs because it has no receiver assertions of its own to catch
a misplacement; and `Arrival.check` is **preserved and still meaningful**, since
`fcs_valid` defaults true and the override touches no frame octet, so the REQ-304
residue verification still stands over C4's frame. **A stated, bounded, checked
exception is not the hazard the invariant guards against; a silent one is** — which is
what the worker's own objection said.

**The octet values, and why I froze them rather than delegating "arbitrary".**
`0xA0 lor d` for d = 1…7, SFD position `0xA7`. Two derivations, both required in the
source: **nonstandard** against SPEC-M03 §6.1's own table (0x55 filler, 0xD5 SFD —
every one of the seven differs at its own position, and `0xA7 ≠ 0xD5` is the octet the
case is about), and **provenance** from `test_m03_b.ml:28`, whose
`nonstandard_preamble_octet lane = 0xA0 + lane` is the same function at a lane-0 start.
**Driving the identical pattern as the landed bench means the two instruments differ in
the design under test and not in the stimulus**, which is what makes a divergence
between them attributable; a different pattern would have been the cheapest way to make
C4's result unreadable against the row it shares a requirement with. Frozen in the
verdict before any C4 stimulus exists — the discipline §12 criterion 8 asks of a
disposition, applied to a stimulus, which is a case criterion 8 was not written for and
now covers.

**The finding, and why it is against me.** `RV-C2ALPHA` §7 ruled *"YES for C3 and C4 …
structural rather than optimistic"*, naming the preamble octets as C4's new ground and
clearing them. **That census enumerated ten items and every one is a CONSUMPTION
layer** — reader, writer, record order, sidecar indexing, timing maps, determinism,
runner, `DELIVERY_DEPTH`, `MAX_WORDS_PER_FRAME`, grammar text. **Zero are construction
surfaces. I cleared a case on a census that never asked whether the stimulus could be
emitted.** Same species as `FINDING WO-0077-A1` at its fourth instance. And the
worker's *"no lawful hook exists"* is the same defect with the sign flipped, which is
what gave the rule its shape: **the census obligation does not care about polarity.** A
negative universal is exactly as wide as the set it was measured over.

**Class MINOR, deliberately, and the reason is arithmetic rather than generosity**:
nothing has been adjudicated under it, no case has run, no coverage claim is false, and
under path (c) **C4's distance is unchanged at one landing**. The whole cost is one
investigative seat that returned a verified four-module negative I would have had to
buy anyway. What earns the mint is the species count, not the consequence.

**My own condition, read.** Its trigger is *"if C4 lands"*; C4 did not land, and its
escape clause is *"for any reason short of C4 itself failing to land"* — which is
exactly what occurred. **The literal reading and the purposive reading agree, and that
agreement is the only reason I let the literal one stand**: the ground the deferral
rested on was *"C4 is one landing away, so writing now costs one reopening, not two"*,
and under path (c) that arithmetic is unchanged. **I restated the ground rather than let
a stale reason carry a conclusion I still hold** — the exact defect `RV-C3ALPHA` §10
corrected itself for, one round later.

**But this is a fifth refusal, so it gets a new bound and not a new excuse.** A
condition whose escape clause is satisfied by the debtor's own delay is not a
condition. **So the escape clause is spent and does not re-arm, and the deferral is
re-bound in ROUNDS rather than in an event I control**: the `AP-` round follows C4's
landing immediately as before, **and** becomes owed regardless of C4's state at the end
of the remediation round commissioned here, with C4's cell written as an explicit
BLOCKED cell if it has not landed. A later deferral is a finding against me and its
class is not MINOR, because by then the rule will have been stated twice and broken
twice.

**Rejected, and recorded because the rejected list is what the auditor mines**: minting
a second finding for the `arrival.mli` doc sentence (the doc is accurate — it disclaims
*judgement*, not *emission*; the misreading is the finding's mechanism, not a separate
defect); minting a finding against tb_writer (the set boundary was drawn by its
dispatch, which is mine, and the worker exceeded its brief in the direction of rigour);
editing the CD to record the construction method (a construction method is not a domain
instance, and §9-bis's lift is scoped to instances — it would be an edit inside a
frozen section); editing the `AP-` to add the `M03-B1` ↔ C4 cross-reference now (the
`AP-` round's own work, and writing it before C4's result exists would assert a link
whose bound is not yet measurable); flipping the packet's `State` field (Stage 2 did
not transition); and drafting the `FINDING K-1` sibling work order from inside a
verdict (a verdict is not where a work order is minted — I named and recommended it
instead).

### Actions

No code was written and no command was executed against the design. One ruling,
`RV-C4GAP`, appended to `WO-0078` §14, carrying: the source-level re-derivation of
tb_writer's four module claims (§1); the `M03-B1` discovery with its three deciding
properties (§2); the path ruling, (a) and (b) refused with grounds, (c) authorised
(§3); **`AMENDMENT WO-0078-A1`** — C4's construction contract, its two-file two-round
scope, the frozen octet values with both derivations, and the preserved invariants
including the four bind shas (§4); the pre-registered branches and the four things α
does not buy, plus the ruling that this round does not advance the stopping rule's
counter (§5); **`FINDING RV-0078-S2-13`** with its rule, its portable form and its
three carriers (§6); the condition's reading and its new round-bound (§7); the CD/`AP-`
no-edit rulings (§8); the sequencing and the declared siblings (§9); §12's engaged
criteria (§10); six things the ruling does not mean (§11); and the verdict (§12).

### Evidence

**This round executed nothing and claims no colour.** ADR-0005 puts no `dune`, no
Hardcaml switch and no `iverilog` in this container, and `WO-0078` §10 item 12 makes a
claim that one was run a finding. Every claim below is a claim about **source read at
`ad32dff`**, reproducible by reading the cited line at that SHA:

```
test/xgmii/arrival.mli:88-93     create's complete optional set: ?ifg ?first_start ?fcs_valid
test/xgmii/arrival.mli:111-116   in_times: "the eight preamble octets from the start
                                 character inclusive, then the frame's octets DA through FCS"
test/xgmii/arrival.ml:17         let preamble_octets = 8
test/xgmii/arrival.ml:101-107    Xgmii_word.Data (if d = preamble_octets - 1 then 0xD5 else 0x55)
                                 -- unconditional, inside `else if d < preamble_octets`
test/xgmii/arrival.ml:157-162    check refuses a frame below five octets
test/xgmii/injection.ml:60-66    is_control_char: exactly /S/ /T/ /E/ /I/ /Q/
test/xgmii/injection.ml:96-101   Place with any other character -> construction error
test/xgmii/injection.ml:175      Hashtbl.replace overrides octet_time (Xgmii_word.Control character)
test/attack_plans/AP-xgmii_rx_64.md   row M03-B1 | REQ-102 | "...arbitrary non-standard
                                      data values, both start lanes" | ASSERT
test/xgmii_rx_64/test_m03_b.ml:6-23   "builds a normal schedule and then substitutes a
                                      non-standard data pattern into exactly the
                                      preamble-position lanes ... machinery composition,
                                      not a new capability"
test/xgmii_rx_64/test_m03_b.ml:28     let nonstandard_preamble_octet lane = 0xA0 + lane
test/xgmii_rx_64/test_m03_b.ml:30-51  preamble_override, derived from frame.start_lane and
                                      Arrival.start_cycle, control field passed through
```

**The fourteen-consumer census of `Arrival`, measured at this tree** by
`grep -rln 'Arrival\.' test/` less the module's own files and the two attack plans:
`test/xgmii/{test_arrival,test_idle_injection,test_tx_decoder,injection,idle_injection}.ml`,
`test/xgmii_probe/test_xgmii_probe.ml`, `test/xgmii_rx_64/bench.{ml,mli}` and
`test_m03_{a,b,c,d,e,f,g,h,i,j,k,l,n,structural}.ml`,
`test/cosim/{stimulus_gen,ours_run}.ml`.

**The four binds this ruling requires preserved** are quoted in `AMENDMENT WO-0078-A1`
from `RV-C3ALPHA`'s own landing record and from tb_writer's reproduction of all four at
`ad32dff`; case 0's independent anchor remains `build` run `31080871169` / job
`92549154623` / `55e16ae`, never the literal in the file the freeze constrains.

**Nothing in this entry is a measurement of the design.** The one prospective claim —
that Stage 3's C6 cannot be built by the landed `Arrival.create` + `check_conformant`
idiom — is derived from `arrival.ml:157-162` and `stimulus_gen.ml`'s
`check_conformant`, by reading, and is offered as the evidence that the third census
axis pays rather than as a Stage-3 ruling (Stage 3 is unauthorised).

### Outcome

**DoD vs the ruling round's own four questions — MET, all four:**

- [x] **The path**: (c), neither named alternative; exact scope, owner, review chain and
      preserved invariants at `AMENDMENT WO-0078-A1` — two files, two rounds,
      tb_writer then data_wrangler, reviewed by my `RV-C4`, preserving the four binds,
      case 0's unedited construction expression, the sighted placement and CD §10.4's
      stimulus terms.
- [x] **The finding**: `FINDING RV-0078-S2-13`, MINOR, owner dv_lead, three carriers,
      with the operative rule and its portable form.
- [x] **The condition**: NOT FIRED; escape clause SPENT and non-re-arming; re-bound in
      rounds; the escalation class of a later deferral pre-stated as not-MINOR.
- [x] **The sequencing**: seven steps, with the declared siblings named on both sides of
      the bar and the reason for each.

**Handoff**: `WO-0078` §14, `RV-C4GAP`, for the orchestrator to dispatch step 2
(tb_writer, `test/cosim/stimulus_gen.ml`) carrying §4 and §5 whole rather than
paraphrased.

**Lessons harvest**: **not due at a ruling round** — PROTOCOL §7 places it at every
`SO-` and every phase gate, and this is neither. **The span stays open and declared
rather than skipped**, unchanged since `J-dv_lead-0148`, and this round **banks a tenth
candidate without minting it**: *a readiness census over the layers that consume an
input is not a readiness census; a case is not constructible because it is specifiable,
and "no mechanism exists" is a measurement over a stated set or it is a guess.*
**(LH1)** `ad32dff` (this round) and `2efd7f9` (`RV-C2ALPHA` §7's clearance); **(LH2-g)**
no proper noun in the statement; **(LH3)** without it, a frozen case is dispatched to a
worker who cannot build it, or is built a second time by a second method while a
reviewed first method sits unnoticed one directory away.

### Open-questions

1. **The `M03-B1` ↔ C4 cross-reference is owed and unpaid**, booked as carrier (ii) of
   `S2-13` to the post-Stage-2 `AP-` round. Two documents of mine commission one
   stimulus for two instruments and neither points at the other; until the `AP-` round
   pays it, the only record of the link is this entry and the ruling.
2. **Stage 3's owed second static census now has three axes** — frame length, admission
   legality, and construction surface — and only the third has a worked example
   (`arrival.ml:157-162` versus C6). The other two remain unmeasured, and §6.3's
   re-authorisation gate is where that comes due.
3. **`FINDING K-1`'s message repair remains the oldest unpaid carrier in this module**
   and remains unscheduled. I named it as the one lawful sibling of the C4 round and
   recommended it be commissioned; I did not draft it, because a verdict is not where a
   work order is minted. If it is not commissioned alongside C4 it falls to the `SO-`
   round, which will need it.
4. **`RV-0078-S1-4` is still standing over five never-fired reference-side guards**,
   first dischargeable at C9, which is unauthorised. C4 cannot reach it and does not
   advance it.
5. **The date drift is unchanged and unrepaired.** This entry uses the machine clock
   (2026-08-06), as `J-dv_lead-0151` through `0156` did; `FINDING CD-P2-2` records the
   underlying inconsistency, and nothing adjudicated here rests on a calendar literal —
   this ruling is dated by its commit and by this entry.

### Files-in-this-commit

- agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md
