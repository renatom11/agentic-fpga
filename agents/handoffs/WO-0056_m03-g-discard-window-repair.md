# WO-0056: M03's REQ-108 window — the epoch the family never drove

- **State**: **DRAFT** (dv_lead-authored; the orchestrator issues)
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/requirements.md` **REQ-108** (its
  "Between the truncation point and that start character …" sentence in
  particular), REQ-103, REQ-105, REQ-107, REQ-110, REQ-008, §0.3, §0.6, §0.7;
  `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's `Discard` row, **§6.3 item 6**,
  §7, §9 (the **sixth** and **seventh** co-occurrence rulings, the closure list,
  and the truncation-closure paragraphs at `1004384`), §10's REQ-108 hook.
- **Rows**: **two new** — **M03-G7** and **M03-G8**, appended inside family G —
  plus a **scoping amendment** to M03-G3's and M03-G4's `Kills` cells. The
  attack-plan edit is **mine and lands before you are spawned** (§7).
- **Deliverables**: additions to `test/xgmii_rx_64/test_m03_g.ml` and nothing
  else.
- **Trigger**: `RV-0055-VERDICT` **FINDING G-2**. The G-c4 mutation survived the
  whole twenty-five-unit suite.

---

## 1. What the finding actually is — and a correction to my own verdict first

`RV-0055-VERDICT` §4 said M03-G3 and M03-G4 *"place their injected character in
the inter-frame gap while citing the clauses that govern the `Discard` window"*,
and called their characters **outside** REQ-108's window. **That wording is
wrong and I am correcting it here before commissioning anything on top of it.**

REQ-108's own sentence fixes the window's ends:

> **Between the truncation point and that start character** the receiver SHALL
> emit no output word and SHALL pulse no strobe, **whatever characters arrive**:
> the frame is already closed and already reported, so **neither a terminate
> character nor an error character reopens it** (REQ-105, carry-forward C-12).

The window runs from the truncation point to **the next start character** — so
the oversize frame's **own terminate character is inside it**, and so is the
inter-frame gap that follows. **M03-G3's and M03-G4's characters at content
index 1618 are inside REQ-108's window, not outside it.** My verdict conflated
REQ-108's window (a **stimulus interval**, fixed by the specification) with the
`Discard` state (an **implementation state**, which §6.3 item 6 and M03-G5 make
explicitly unobservable). Those are not the same object and I should not have
equated them.

**The finding survives the correction, sharper and differently shaped:**

> **REQ-108's window has two epochs, and family G drives only the second.** The
> first runs from the truncation point to the frame's **own terminate
> character**; the second from that terminate to the **next start character**.
> M03-G3, M03-G4 and M03-G1 all place their characters in the second. **No row
> in this programme has ever driven a character into the first**, and a defect
> confined to it is invisible to all twenty-five units — which is what G-c4
> measured.

**And that is why this is an ADD, not a repair-in-place.** Moving G3's and G4's
offsets earlier would buy the first epoch by giving up the second, which is real
coverage of the same REQ-108 sentence. **Net zero is not a repair.** Their ids,
observables and kills are correct as far as they go; what was wrong is that their
`Kills` cells claim the whole window. §7 scopes those cells and leaves everything
else standing.

## 2. The two rows

**Both are stated as octet-time facts about the stimulus, never as claims about
the receiver's state**, and you must keep them that way. §6.3 item 6 makes the
`Discard`-versus-`Idle` distinction **unobservable**, and M03-G5 exists to say
so; a row that asserted "the receiver is discarding" would assert exactly what
that item forbids. **The commissioned fact is a position on the wire**, and the
observable is REQ-108's own.

### M03-G7 — a start character inside the first epoch (ASSERT)

**Stimulus.** A frame exceeding 1518 octets in which a **start character arrives
strictly between the truncation point and the frame's own terminate character**.
For the family's 1600-octet frame that interval is content indices **1518 … 1599
inclusive** — derived, not given: content 1518 is the 1519th received octet, the
first that makes the frame exceed 1518 (REQ-108); content 1599 is the last octet
before the frame's terminate. **State the index you choose and show it inside
that interval**, as `run_g4` already shows its own with a guard.

**Observable.** Exactly one `error_oversize` for the oversize frame, on its own
`tlast` cycle; **no `error_start_without_terminate`** (§9's sixth ruling, C-12 —
the frame is already closed and already reported, so the resynchronising start
character is not a second abort); nothing emitted for the oversize frame beyond
its 1514 truncated octets.

> **The consequence you must derive rather than assume**: REQ-108 says the
> receiver **resynchronises on that start character**. So the octets after it —
> the remainder of the original frame, and its terminate — belong to the **frame
> that start character opens**, and that frame has its own disposition under
> REQ-106/REQ-107. **Derive it and assert it.** If it lands in the runt band its
> own `error_runt` is a legitimate part of this row's exact strobe set, not a
> surprise, and the row is stronger for asserting it — a design that did *not*
> resynchronise would produce a different set.

**Kills.** A design that treats the resynchronising start character as a second
abort **while still discarding** — the reading §9's sixth ruling forbids, in the
epoch where nothing has yet tested it.

### M03-G8 — an error character inside the first epoch (ASSERT)

**Stimulus.** The same frame with an **error character** in the same interval —
strictly between the truncation point and the frame's own terminate character.

**Observable.** Exactly one `error_oversize`, on the oversize frame's own `tlast`
cycle, and **no `error_bad_frame`** (§9's seventh ruling, C-12); no output word
after the truncation; the following frame received intact. **An exact strobe
set**, not a lower bound.

**Kills.** An `/E/` handler that reads REQ-105's "between the start and terminate
characters" literally and reports for a frame already closed and already
reported — **in the epoch where M03-G4's character never reaches.**

> **M03-G8 is the row that lifts the standing consequence** (§6). M03-G7 is
> commissioned alongside it because the same gap has two characters in it and
> closing one is not closing the gap.

### 2.1 If M03-G7's observable will not derive, return the question

M03-G7 is the harder of the two: resynchronisation mid-frame makes the second
frame's own disposition part of the observable, and if you cannot derive that
disposition from the specification — as opposed to guessing it — **say so and
return the question rather than asserting something weaker.** In that case G7
lands as a **RULING** row pending an architect ruling and **M03-G8 proceeds
alone**; the standing consequence lifts on G8's evidence and G7 follows.

**M03-G8 has no such difficulty** — an error character does not reopen anything
and nothing resynchronises on it.

## 3. Mechanism — yours, and I am not naming one

**I specify the observable and the stimulus position; the construction is
yours.** The rule is `J-dv_lead-0065`'s and it has now been right twice: at
WO-0054 §3.5 you established `Injection`'s reach yourself and chose a simpler
route, and the capability finding you kept separate from the construction choice
is what tells me the seedable space is not bounded here.

**Establish and report** whether the interval is reachable with today's
machinery — `Bench.run`'s `?word_at`, `Injection`'s placement catalogue, or a
schedule construction — and **return the question rather than adding to `Bench`**
if it is not. One caution, stated as a fact about the stimulus and not as a
design: the interval you are aiming at lies **before** the frame's own terminate,
so a construction that appends or overrides *after* the frame will miss it, which
is precisely how M03-G3 and M03-G4 came to test the second epoch.

**Verify at both failure sites** (`WO-0047` §6 item 7): that the character lands
where the row means it to in the schedule's own words, and that the cycle `run`
actually drove carries it. Both existing G rows already do this and it is why
this finding took one read to diagnose.

## 4. Derivation discipline, and the rule this packet is modelling

1. **A claim about the receiver's state must cite the stimulus fact that
   establishes it — or not be made.** This is the rule I adopted at
   `J-dv_lead-0070` after two branches of my own sealed mapping asserted "in
   `Discard`" without checking where the frame's terminate fell. **These rows are
   written to need no state claim at all**, which is the strongest form of
   obeying it. Keep them that way: if a comment in your file says "the receiver
   is still discarding", replace it with the octet-time fact that matters.
2. **Assertion order is part of the row's contract** (`WO-0047` §4.2). State each
   row's order and iteration order in the Return log; the first failing assertion
   is what a campaign is scored against.
3. **Governance per member**, as `WO-0054` §2 required and your file already
   does: the oversize frame's delivered set is REQ-108's truncation
   (`List.take octets 1514`), never `Frame.delivered`.
4. **The §0.6 window** uses the architect's truncation-closure ruling
   (`1004384`): the reference word is the input word on which REQ-108's
   truncation closed the frame. That ruling stands and every existing G row uses
   it.
5. **`WO-0047` §1.2's shared-no-output-path claim remains UNESTABLISHED and
   uncitable.** No row here needs it — every frame in family G delivers 1514
   octets and has a `tlast`.

## 5. What you may NOT read

- **Never open `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**`.** Scope every
  `grep` to `test/` and `docs/specs/`.
- **`docs/reports/audit/**` is out of bounds for this packet.** It contains the
  WO-0055 mutation diffs, including the one these rows exist to catch. **A row
  written against a mutation is worth nothing**; these rows are commissioned from
  REQ-108's own sentence and §9's sixth and seventh rulings, and that is the only
  place their expected values may come from.
- Derive every expected value from the specification, never from the design and
  never from `Injection`'s **computed outcome model** (`AP` §7's X-1 row: the
  placement machinery is free, the outcome model is an oracle and is gated). Use
  it only as a **reported cross-check** with the `fail_cross` idiom.

## 6. Re-qualification — how the standing consequence lifts

`RV-0055-VERDICT` put a bar on the record: **no packet, verdict or sign-off may
claim family G verifies REQ-108's window for an `/E/` or a `/S/`** beyond the
no-terminate case. **Green rows do not lift it.** M03-G3 and M03-G4 have been
green since they landed and they were green for the wrong reason; a green M03-G8
proves only that it passes, which is the same thing they proved.

**The instrument is the mutation that already exists.** After the repaired rows
land green, the orchestrator applies the **existing `g-c4` diff** — already
committed at `762ae49`, no new seeding round and no auditor spawn required — to a
throwaway branch off the repair's landed SHA and runs the `build` job.

**Published prediction, and it is deliberately NOT sealed.** R-SEAL-1 binds a
claim that a result exists and is being **withheld**; nothing is withheld here —
the diff is committed, its predicate is disclosed in the auditor's own README,
and the check is arithmetic rather than adversarial. Stating it openly is the
honest form and a seal would be theatre:

- **M03-G8 SHALL redden.** That is the whole of the lift condition.
- **M03-G7 is expected to stay green**, the diff being gated on an error
  character; if it reddens, that is informative and is adjudicated, not scored.
- The five existing G rows behave as at WO-0055 — all green under this class.
- The `cosim` job will be red, by design, and is not scored.

**If M03-G8 does not redden, the repair failed and the consequence stands.** No
re-interpretation of the row, and no second attempt at the same offset.

> **On the WO-0055 seal, since these rows change what a future mutation should
> hit**: that seal's falsified `/E/` and `/S/` branches **stand unedited**. A
> mapping is re-derived fresh at the next campaign's freeze, against the bench as
> it then is; it is never retro-fitted to a result. `J-dv_lead-0044`'s rule and
> `RV-0045-VERDICT` §2's precedent both say so.

## 7. Sequencing, the denominator, and what is NOT touched

- **The attack-plan rows land before you are spawned.** ADR-0001 and charter §3
  require the row before the bench; M03-G7 and M03-G8 will exist in
  `AP-xgmii_rx_64.md` §4.G, with the M03-G3/G4 `Kills` scoping, in the commit
  that issues this packet or immediately after it. **Cite the plan, not this
  packet, for the rows' canonical text.**
- **Denominator discipline**: this is a repair packet. Its rows re-enter the
  denominator **at the next campaign's freeze**, measured then. **No campaign
  scoring is touched** — WO-0055 is closed, adjudicated and unsealed, and nothing
  here reopens it.
- **Not touched**: M03-G1, G2, G5 and G6; every row of families A–F; the §0.6
  window convention; `tools/**`; `test/cosim/**`.

## 8. What I expect back

A Return log appended to this packet plus your journal entry. **No `SO-`.**
Structure it as WO-0054's, with these as deliverables rather than background:

1. **The chosen index for each row and the guard that shows it inside
   1518 … 1599** — the fact this whole packet exists because nobody checked.
2. **M03-G7's second-frame disposition**, derived with its clauses cited, or the
   returned question of §2.1.
3. **Whether today's machinery reaches the interval**, established rather than
   assumed, and the construction you chose with the alternatives you rejected.
4. **Assertion and iteration order** per row.
5. **The unit count you observe**, measured with `tools/dv_checks.sh`'s inventory
   block, not recalled.
6. Anything you found that this packet did not authorise you to fix — **report
   it, do not fix it.**
