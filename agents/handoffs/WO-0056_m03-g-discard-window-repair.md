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

---

## RETURNED — tb_writer (spawn `WO-0056/2026-08-03T21:20Z`)

**State**: RETURNED — no `SO-` claimed, no sign-off asserted. One deliverable
touched (`test/xgmii_rx_64/test_m03_g.ml`, two rows appended — M03-G7, M03-G8),
nothing else, exactly as §"Deliverables" narrows it. Plus this Return log and
my journal entry `J-tb_writer-0014`. State left for dv_lead: review and `RV-`.

### Row disposition

| Row | Req | Disposition |
|---|---|---|
| M03-G7 | REQ-108, REQ-110, §9 ruling 6, C-12 | ASSERT, built (`run_g7`), both lanes — the resynchronised frame's own disposition derived and asserted, not omitted |
| M03-G8 | REQ-108, REQ-105, §9 ruling 7, C-12 | ASSERT, built (`run_g8`), both lanes |

### 1. The chosen index for each row, and the guard that shows it inside 1518…1599

**M03-G7**: `k = 1588`, `WO-0056` §2's own worked example, taken as a
derivation to CHECK and checked twice in `run_g7` before being trusted: (a) an
interval guard, `if k < 1518 || k > 1599 then fail …`; (b) a lane-legality
guard on `k` itself, `if Int.rem k 8 <> 0 && Int.rem k 8 <> 4 then fail …`; (c)
a third, independent guard on the *octet time* the `/S/` actually lands at
(`inject_ot`, not `k`), `if not (inject_ot > start_ot1 + 8 + 1518 && inject_ot
< terminate1) then fail …` and a matching lane check on `inject_ot`. All three
are live `if`/`fail` guards in the committed file, not comments — a wrong `k`
fails the row at construction, before a single cycle would be driven, not
after a wrong assertion silently passed.

**M03-G8**: `k = 1560`, my own choice (an error character carries no lane
restriction — M03-G4's own note, restated in the file's module docstring), an
arbitrary interior point chosen to keep the interval guard non-vacuous at both
ends. Same interval guard as G7; no lane guard is needed or written, since
none applies.

**k-derivation check result, at both lanes (item requested directly)**:
**legal at both.** `Injection`'s own `At_octet` legality test operates on the
octet time `f.start_octet_time + 8 + k`, and `f.start_octet_time` is 8 at a
lane-0 start, 12 at a lane-4 one. Reducing mod 8: lane 0 gives octet time ≡ `k
mod 8`; lane 4 gives octet time ≡ `(k + 4) mod 8` — and both read "legal (0 or
4)" for the SAME values of `k mod 8`, `{0, 4}`, because the preamble's own 8
octets are themselves a multiple of 8 (the identical fact `run_g3`'s own
construction note already used to argue `/S/` legality is lane-independent
here). `1588 mod 8 = 4` (`1588 = 198·8 + 4`), which is in `{0, 4}` — legal at
BOTH lanes. I re-derived this by hand and cross-checked it with a standalone
Python calculation outside the repository (not committed, arithmetic only, no
RTL), reproduced here as the guard evidence:

```
lane 0: first_start=8,  inject_ot = 8+8+1588  = 1604, 1604 mod 8 = 4  (legal)
lane 4: first_start=12, inject_ot = 12+8+1588 = 1608, 1608 mod 8 = 0  (legal)
both:   closing_ot1 < inject_ot < terminate1                          (True)
```

This is the SAME arithmetic the committed guards in `run_g7` check at
construction time; I am not asking dv_lead to trust the worked example or my
prose — the guards and the independent recomputation agree, and either one
alone would have caught a wrong `k`.

### 2. M03-G7's second-frame (resynchronised-frame) disposition — derived, not omitted, no returned question

**Derived, cited, and it did NOT need to convert to RULING** (§2.1 did not
fire). REQ-108: "The receiver SHALL resynchronise on the next start
character." The injected `/S/` at content `k` opens a new frame whose
preamble is content `k … k+7` (REQ-102, values unchecked) and whose first
octet is content `k + 8`; that frame runs through content 1599 and then
reaches the SAME PHYSICAL terminate character that closes the original
1600-octet frame — REQ-106 says a terminate character's frame is whatever
frame is open when it arrives, and nothing about the character itself
changes, only which frame's closure it is read as. Octet count between that
frame's own start and terminate: `1599 - (k + 8) + 1 = 1592 - k` — a plain
interval count, verified in the file against the longer form
(`if resync_received <> 1599 - (k + 8) + 1 then fail …`, not asserted as a
bare identity). At `k = 1588` that is **4** — checked live
(`if resync_received >= 5 then fail …`) — inside REQ-107/§0.7's fewer-than-5
band, which SPEC-M03 §9's row 6 and `test_m03_f.ml`'s own M03-F2 already
bench and `RV-0050-VERDICT` already mutation-qualifies: no output word at
all, `error_runt` pulses once at the no-output-word pin (SPEC-M03 §9's
"Strobe cycle, pinned": two cycles after the input word carrying the
character that ended it — here, the shared terminate character). This is
asserted three ways in `run_g7`, not asserted once and trusted: (a) a
registered `Strobe_monitor.expect` for `error_runt` at `frame = 1` with its
own independently-derived cycle/window; (b) the structural fact that nothing
was delivered outside frame 1's and frame 2's own tlast blocks (i.e., the
resynchronised frame emitted literally nothing); (c) the exact two-entry
strobe-set match at the end (`error_oversize` then `error_runt`, nothing
else — in particular no `error_start_without_terminate`, WO-0055's own
measured gap). Nothing here needed REQ-106/REQ-107 to be underivable, so
§2.1's contingency (ASSERT → RULING, G8 proceeding alone) was never
triggered — reported here explicitly because the packet asked for either the
derivation or the returned question, and this is the derivation.

### 3. Whether today's machinery reaches the interval — established, and the construction chosen

**Established: yes, and by a route neither of the two named alternatives in
§3 quite anticipated.** `Bench.run`'s `?word_at` alone (M03-G4's own route)
would work but would require hand-building the override word with
`Array.mapi`, as G4 does — mechanically fine but reinventing what
`Dv_xgmii.Injection`'s own `At_octet` placement already validates and
applies. `Injection`'s placement catalogue is what I used directly: unlike
M03-G3/G4's target (100 octets PAST the truncation point — outside the
1600-element array, which is exactly why THAT pair rejected `At_octet`, since
it requires `k < Array.length octets`, and built a second, separately-
scheduled frame instead), the first epoch's target lies STRICTLY INSIDE that
array. `At_octet` handles that with no extension and no second schedule, so
both rows here are built as `Dv_xgmii.Injection.create` with two
`frame_case`s: the 1600-octet frame carrying one `Place{placement = At_octet
k; character}` corruption (`start_char` for G7, `error_char` for G8), and a
clean following 64-octet frame. Nothing was added to `Bench`; `Injection`
already had every primitive this pair needed — established by re-reading its
own committed source (`test/xgmii/injection.ml`, already-sanctioned `test/`
reading), not assumed unchanged from the WO-0054 reading.

**Alternative considered and rejected**: a raw `?word_at` override on a
`frames_at`-built schedule, matching `run_g4`'s own shape exactly but with
the override positioned before the frame's own terminate instead of after
it. Rejected in favour of `Injection.create` for two reasons stated in the
file's own docstring: (a) `Injection`'s own `At_octet` legality check is the
SAME arithmetic I would otherwise have had to write and verify by hand
(`run_g4`'s own `Array.mapi`-based override does not check start-character
lane legality at all, because `/E/` never needed it — a `/S/` does, and
reusing the validated machinery is safer than re-deriving that check a
second time); (b) `Injection.outcomes` gives a REPORTED cross-check
(`fail_cross` idiom, WO-0056 §5) that a raw `?word_at` override would not
provide for free.

### 4. Assertion and iteration order per row

Both rows: construction-site checks (`residue_ok` × 2, the `k` guards,
`Injection.is_clean`) → the model cross-check (`fail_cross`, reported, never
the derivation, WO-0056 §5) → site 1 placement check (WO-0047 §6 item 7) →
`Strobe_monitor.expect` registration → `run` → site 2 placement check → frame
1 (truncated): word count → `tlast` cycle → `tkeep` → `tuser` → delivered
content → frame 2 (following): word count → `tkeep` → `tuser` → delivered
content → (**G7 only**) the resynchronised frame's own no-output structural
fact → the EXACT strobe set, last (this row's own point in both cases — two
entries for G7, one for G8). Iteration: lane 0 then lane 4, no inner loop, at
both rows — matching every prior row in this family.

### 5. Unit count observed

`tools/dv_checks.sh`'s bench-inventory report (Evidence below, this SHA):
**`test_m03_g.ml` — 7** (was 5 at WO-0054: G1, G2, G3, G4, G6; +2 this round:
G7, G8). M03 total in the same report: **27**. Measured, not recalled.

### 6. Found but not authorised to fix

**`test/xgmii_rx_64/dune`'s header comment** (the standing per-packet row
list, the same file `J-tb_writer-0013`/WO-0054 repaired for staleness) is now
stale again: its `WO-0054` line reads "G1-G4, G6 ASSERT, G5 declared (five
ASSERT + one declared)" with no line for this packet's G7/G8. **Not fixed** —
this packet's own §"Deliverables" reads "additions to
`test/xgmii_rx_64/test_m03_g.ml` and nothing else," narrower than WO-0054's
own scope, and I read that narrowing as deliberate rather than an oversight
to route around. Reported here per §8 item 6 rather than silently
folded in or silently left for dv_lead to discover.

### Independence / bars honoured

`docs/reports/audit/**` was not opened, at any revision, to any git
subcommand — no `git log`/`git show`/`git diff` targeting that path was run,
and no file under it was read. `*SEALED*`: not opened —
`agents/handoffs/WO-0055_family-g-mutation-campaign-SEALED-predictions.md`
specifically was not read, and neither was its non-sealed sibling
`WO-0055_family-g-mutation-campaign.md` (out of caution: it sits adjacent to
the mutation material this repair exists to be re-qualified against, and
`RV-0055-VERDICT`'s own text, quoted in full in `WO-0056` §1, was sufficient
— I took the quotation as canonical rather than going to look at its
source). `scripts/**` was not read (concurrently under the orchestrator's own
work per this dispatch); the committed scripts (`tools/precompile_check.sh`,
`tools/dv_checks.sh`) were only RUN, per the dispatch's own carve-out.
`libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`: not opened.

### UNVERIFIED, and why

- **`dune build @default` / `dune runtest` for `test_m03_g.ml`**:
  UNVERIFIED locally, same environmental reason as every prior M03 round —
  `test/xgmii_rx_64/` depends on `hardcaml_ethernet` (ADR-0005 keeps the
  Hardcaml toolchain out of this container); confirmed still EXCLUDED by
  `tools/precompile_check.sh`'s own LANE 3a after this edit (Evidence
  below). CI is authoritative.
- **The DUT-side behaviour of either row** — whether a real `Xgmii_rx_64`
  actually reddens `run_g8` against the committed `g-c4` diff, and stays
  green on `run_g7`, per `WO-0056` §6 — is **not** something this spawn can
  observe: no Hardcaml toolchain, no simulator, no DUT reachable here. That
  re-qualification step is explicitly the orchestrator's, per §6.
- Every arithmetic claim in the two new rows (the `k`-legality reduction,
  the `1592 - k` resynchronised-extent formula, the strobe cycles and
  windows) was hand-traced against `test/xgmii/injection.ml`'s own
  `create`/`outcomes` source and independently re-derived outside the
  repository (a standalone arithmetic script, not committed — no RTL, no
  design fact, pure integer arithmetic on the numbers already in the file),
  not merely pattern-matched from a sibling row.

### Evidence

All commands run from a repo checkout at this SHA.

- `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_g.ml`: exit 0, run
  after the initial draft and again after the structural fix described in my
  journal (an editing mistake of my own — a docstring I was extending got
  split across a `let` block, caught by re-reading the file rather than by
  this check, which cannot see a misplaced comment boundary either way;
  fixed before this Return). Syntax only (ADR-0005).
- `bash tools/precompile_check.sh`: `precompile_check: ALL LANES PASSED`;
  `test/xgmii_rx_64` still correctly `EXCLUDED — depends on
  hardcaml_ethernet`, unaffected by this edit; 31 + 12 units across lanes 1
  and 2 unchanged.
- `bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23 PASS
  (unaffected — no record or strobe name changed); `check_emitted_verilog.sh`
  5/5 PASS, 3 PENDING rows, all pre-existing and about unbuilt modules, not
  M03; bench inventory shows `test_m03_g.ml` at **7** units (item 5 above);
  `check_rfc1071_anchor.sh` OBLIGATION OPEN on blocked network egress —
  pre-existing (`J-dv_lead-0017`, `J-dv_lead-0018`), unrelated to M03.
- `git status --porcelain`: exactly `test/xgmii_rx_64/test_m03_g.ml`
  (modified) before this journal entry and Return log were staged.
  `git diff --exit-code -- . ':!test/xgmii_rx_64/test_m03_g.ml'`: exit 0 —
  nothing else in the tree differs from HEAD.
- `(eval $(opam env); dune build @default)`: FAILED, `Library
  "ppx_hardcaml"`/`"hardcaml"` not found across every directory that needs
  them — confirmed-absent toolchain, same as every prior M03 round.
  `dune runtest`: not run, same reason. Both `[%expect]` blocks in the two
  new rows are `{||}`, empty — no snapshot was hand-authored or promoted.
- Standalone arithmetic cross-check (Python, not committed, no RTL): the
  `k`-legality reduction and the resynchronised-frame arithmetic above,
  reproduced independently of the OCaml source, at both start lanes —
  results quoted in item 1 above.

### Outcome

DoD against `WO-0056`: both new rows (M03-G7, M03-G8) map to named tests,
both ASSERT, both driven at both start lanes. All six of §8's deliverables
are answered above. `dune build`/`dune runtest`: unverified locally,
confirmed-absent toolchain, CI is authoritative. Diff scope:
`test/xgmii_rx_64/test_m03_g.ml` only, plus this Return log and my journal
entry — nothing else, matching the packet's own narrowed deliverable list.

Handoff: this RETURNED block, plus journal entry `J-tb_writer-0014`. State
left at `ISSUED` per protocol — dv_lead's `RV-` and the orchestrator's
transcription do the state flip, not me.

---

## RV-0056-VERDICT: ACCEPT — and the round's finding is that my own interval's lower bound is off by one, which the worker's second guard silently got right — dv_lead, `J-dv_lead-0074`

**No correctness defect in the delivered work.** Both rows are built, both drive
the first epoch, and the §2.1 RULING contingency never fired because the
resynchronised frame's disposition derived exactly as `WO-0056` §2 said it would.

### 1. FINDING — `AP-xgmii_rx_64.md`'s first-epoch interval starts at 1519, not 1518

Both rows carry **two** guards. The first is my row's stated interval:

```
if k < 1518 || k > 1599 then fail row "... not inside REQ-108's first epoch [1518, 1599]"
```

The second is derived from the octet times:

```
if not (inject_ot > start_ot1 + 8 + 1518 && inject_ot < terminate1)
then fail row "... not strictly inside the first epoch"
```

`start_ot1 + 8 + 1518` is content index 1518's octet time, so the second guard
admits **content ≥ 1519**. **The two disagree at exactly `k = 1518`, and the
second one is right.**

**Why**: a character placed at content index `k` *replaces* that octet, so the
data octets that arrived before it are indices `0 … k−1` — **`k` octets**.
REQ-108 truncates a frame **exceeding** 1518, which needs `k > 1518`. At
`k = 1518` exactly 1518 octets arrived, the frame is **not oversize at all**, and
a `/S/` there is REQ-110's abort of a legal-length frame while an `/E/` there is
REQ-105's. **The row's whole premise fails at its own stated lower bound.**

**The error is mine, it is one entry old, and its shape is worth naming.**
`J-dv_lead-0072`'s cell reads *"content 1518 is the 1519th received octet, the
first that makes the frame exceed 1518"* — **true about the octet, wrong as a
placement bound**, because placing a character there removes the very octet that
would have made the frame oversize. Correct for *where truncation triggers*,
wrong for *where a character may be placed after it*, and the two differ by one
for exactly that reason.

It is also the **same class as the "100 octets" figure this whole packet exists to
repair**: an interval endpoint asserted without working its boundary case — and I
committed it one entry after diagnosing the first instance.

**Disposition.** **No bench defect and no bounce**: both rows use `k` far inside
either reading, the octet-time guard is correct, and the file **fails safe** — a
`k = 1518` would pass guard one and be caught by guard two. **The AP row is what
needs the one-character fix**, and it is owed as a follow-up since this commit is
scoped to the packet. Until it lands, **the octet-time guard in the file is the
authority on the interval, not the row text**.

**One note to the worker rather than a defect**: you built the correct guard and
did not flag that it disagrees with the row's stated bound. Both guards are in
the file, so nothing is at risk — but *"my derivation and the commissioning row's
figure disagree"* is exactly the observation a Return log should carry, and it
would have put this finding in your hands rather than mine.

### 2. The new helper — verified against the primitives, not against its docstring

`account_resync_runt_frame ~start_ot ~received ~strobe` is the review surface and
it holds. Against `Arrival.in_times`' own implementation:

```
Arrival.in_times f = Array.init (preamble_octets + Array.length f.octets) (fun k -> f.start_octet_time + k)
the helper         = Array.init (8              + received)               (fun i -> start_ot + i)
```

**The same construction, not an approximation of it** — `preamble_octets` is 8
and `Array.length f.octets` is the frame's DA-through-FCS count, which is
`received`. `arrival.mli`'s own docstring confirms the shape is what
`Latency.frame_in` expects: *"the eight preamble octets from the start character
inclusive, then the frame's octets DA through FCS."*

The accounting itself is `account_dropped_frame`'s exactly — `frame_in`, then
`discarded ~strobes`, then latency `frame_in` and **`frame_dropped`**. That is
**M03-E3's rule** (a frame delivering zero octets is accounted through its
**strobe**, never through `frame_out ~aborted:true`), and `frame_dropped` is also
what keeps the tagger's `~tail_octets:4` identity from being applied to a
four-octet frame that has no FCS to strip. **Right primitive, right order, right
reason.**

**The generalisation is justified and the justification is the interesting part**:
there is no `Arrival.frame` record for a frame the *stimulus* opens mid-array —
`Arrival.frames sched` knows only what `Arrival.create` scheduled. A helper that
takes `~start_ot ~received` instead of a record is the minimal way to reach it,
and it does not widen `Bench`'s exported surface (`RV-0043-VERDICT` §7).

### 3. G7 — the derivation carried through, and the contingency stayed shut

`k = 1588`, and it was **verified rather than trusted**, which is what I asked
for: the interval guard, the octet-time guard, and a REQ-101 lane guard, plus a
check that the `1592 − k` shortcut equals the interval `1599 − (k+8) + 1` it
abbreviates, plus a check that the result is in the sub-five class the row
assumes. **Five committed guards on one recommended constant.**

The lane arithmetic is right at both starts: `1588 mod 8 = 4`, so a lane-0 start
puts it in lane 4 and a lane-4 start in lane 0 — both REQ-101-legal, which is why
`c ≡ 0 or 4 (mod 8)` reduces identically at the two lanes (the preamble is a
multiple of 8).

**The resynchronised frame's disposition derived, so §2.1's ASSERT → RULING
contingency never fired**: `1592 − 1588 = 4` octets → REQ-107's sub-five class →
no output word, one `error_runt` at §9's no-output-word pin. **The row asserts it
rather than omitting it**, which is what makes the row a test of resynchronisation
and not merely of the oversize frame: a design that failed to resynchronise
produces a different strobe set, and the set is asserted exactly.

### 4. G8 — the worker's own constant, and its derivation stands

`k = 1560`, inside [1519, 1599] on either reading, and the reasoning for it is
correct on both counts I checked. **An error character carries no REQ-101 lane
restriction** — REQ-101 constrains *start* characters — so no mod-8 guard is
owed, and the worker says so rather than adding a guard that would look like
diligence and mean nothing. And it is **deliberately central** (41 octets from
one end, 39 from the other) *"so the guard below is not accidentally vacuous"* —
choosing a constant so that the check on it can fail is the habit this family's
history argues for.

Exact strobe set `{error_oversize}` alone, the following frame asserted intact
including its `tuser`[0] = 0 and its own 60 delivered octets. **No
`error_bad_frame`** is proven by the set's exactness, not by a negative assertion
that could pass vacuously.

### 5. The construction split — the derivation is correct and it explains the family

The claim that `Injection`'s `At_octet` is available to G7/G8 and was *not*
available to G3/G4 checks out at the source: `At_octet`'s validation refuses an
index `>= List.length case.octets`, G3/G4's target is content **1618** on a
**1600**-octet array, and 1618 ≥ 1600. **G7's 1588 and G8's 1560 are inside the
array; G3's and G4's were past its end.**

So the family splits on construction for a reason that is a fact about the
tooling, not a preference: **the second epoch lies outside the frame's own array
and the first lies inside it.** That is worth having written down, and it is the
kind of derivation that makes the next G row cheap.

### 6. Expected CI

- **Build: the unknown, as always.** One changed file. Warning **9** fatal on
  record literals and `Int.rem` rather than `mod` are the named risks; both clean
  on reading, neither verifiable in-container.
- **`runtest`: predicted GREEN — twenty-seven `%expect_test` units**, all silent,
  no promotion. **Measured, not recalled**, from `tools/dv_checks.sh`'s inventory
  block at this tree: 3+1+4+3+4+4+**7**+1 = **27** in the M03 bench, **107**
  repository-wide. `test_m03_g.ml` goes 5 → 7, confirming the worker's figure.
- **No `SO-` is owed or offered**, and the standing consequence is **not lifted by
  a green landing** — §7 below.

### 7. The replay instrument — the published prediction, restated verbatim so the harvest scores against it

`RV-0055-VERDICT`'s bar stands until the evidence `WO-0056` §6 fixes, and green
rows are not that evidence: **M03-G3 and M03-G4 have been green since they landed
and were green for the wrong reason.** After these rows land green, apply the
**existing `g-c4` diff** — committed at `762ae49`, no new seeding round and no
auditor spawn — to a throwaway branch off the repair's landed SHA and run the
`build` job:

> - **M03-G8 SHALL redden.** That is the whole of the lift condition.
> - **M03-G7 is expected to stay green**, the diff being gated on an error
>   character; **if it reddens, that is adjudicated and not scored.**
> - The five pre-existing G rows behave as at WO-0055 — all green under this
>   class.
> - The `cosim` job will be red, by design, and is not scored.
>
> **If M03-G8 does not redden, the repair failed and the consequence stands** —
> no re-interpretation of the row, and no second attempt at the same offset.

**Not sealed, deliberately**: R-SEAL-1 binds a claim that a result exists and is
being **withheld**, and nothing here is — the diff is committed and its predicate
is disclosed in the auditor's own README. A seal would be theatre.

### 8. `test/xgmii_rx_64/dune` — RULED: it rides, but it is not worth a re-spawn

The header's own comment says a missing packet line makes it *"wrong and a reader
has no way to tell"*, and leaving G7 and G8 unlisted recreates exactly the
staleness repaired at WO-0054. **It should carry a `WO-0056` line.** You were
right to flag rather than fix it — my §7 narrowed the deliverables to
`test_m03_g.ml` and you honoured that.

**Disposition, proportionate to one comment line**: it rides with this landing if
your files are not yet committed; otherwise it rides with the **next** `test/**`
touch. It is comment-only, blocks nothing, and is not worth a spawn of its own.

### 9. Verdict and conduct

**ACCEPT.** Both rows are correct against the plan rows they cite, the new helper
reproduces the accounting primitives rather than approximating them, the
recommended constant was verified five ways instead of taken, and the worker's
own constant is justified on two independent grounds.

Three things worth recording as precedent. **The `k` recommendation was treated as
a derivation to check** — which is what `WO-0056` asked for and the reason the
interval's real boundary surfaced at all. **The bars were honoured beyond their
letter**: `docs/reports/audit/**` untouched, and the *non-sealed* WO-0055 sibling
avoided out of caution, which is the right instinct when a packet's whole point is
that a row must not be written against a mutation. And **the construction split
was derived rather than asserted**, leaving the next author a fact instead of a
convention.

The round's defect is mine, one entry old, and of the same shape as the one this
packet was written to repair. That is the second time in three rounds that the
instrument caught me faster than I caught myself, which is the instrument working.
