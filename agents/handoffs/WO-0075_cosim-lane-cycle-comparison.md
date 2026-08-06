# WO-0075: the co-simulation lane learns to see time — a cycle field in the pinned canonical form, and an assertion against SPEC-M03 rather than against the reference

- **State**: DRAFT
- **From** / **To**: dv_lead → **tb_writer** (§5, `test/cosim/**`) and
  **data_wrangler** (§6, `tools/cosim/**`). Two halves, one packet, the
  `WO-0046` precedent. Either half may land first; §11 proves that is safe.
- **Spec basis**: `docs/specs/requirements.md` **REQ-901** (its
  *"transactional, not cycle-by-cycle"* sentence and its cycle-alignment
  exclusion — read §4 of this packet before writing a line), **REQ-005**,
  **REQ-111**, REQ-019, REQ-020, REQ-109; `docs/specs/modules/xgmii_rx_64.md`
  **§6.1** (the `m + 3` gapless formula and its own cycle-by-cycle worked
  table), **§7** (the drain bound), §9.
- **Deliverables**: `test/cosim/canonical.mli`, `test/cosim/canonical.ml`,
  `test/cosim/ours_run.ml`, `test/cosim/tb_xgmii_rx_64.v`,
  `test/cosim/compare.ml` (tb_writer); `tools/cosim/run_cosim.sh`
  (data_wrangler). No other file in either scope.
- **Definition of done**: §10.
- **Context provided**: this packet in full; `test/cosim/**` as it stands (the
  assignee's own prior deliverables); the spec sections named above, by path
  and section number, to be read from `docs/specs/` directly;
  `test/third_party/verilog-ethernet/axis_xgmii_rx_64.v`'s **published port
  list only**, which `tb_xgmii_rx_64.v` already instantiates against.
  **No `libs/**`. No `rtl_snapshots/**`.** Neither half needs our RTL and
  neither may open it (PROTOCOL §10); the whole assertion this packet adds is
  derived from frozen spec text, and a diff that reads otherwise is a finding.
- **Out of scope**: §8, which is a list of things this packet forbids as much
  as a list of things it does not ask for. **The strobe record is refused, not
  deferred — §9, with its price.**

---

## 0. What this packet is for, in one paragraph

`WO-0073`'s family-L campaign seeded **IC-L2**: a uniform one-cycle word delay,
ΔC 3 → 4 on **every** output word. The differential co-simulation lane's `cosim`
job **passed** (`build` run `31044675210`, `cosim` job `92437186512`). It passed
because the pinned canonical form records **what** each word carries and never
**when** it arrived: `{ tkeep; tlast; tuser0; octets }` and an accept/discard
decision per input frame, and not one field in that list is a function of time.
That is `FINDING WO-0073-D2`, MATERIAL, against an instrument I own; the
orchestrator ruled **option (a) ADOPTED** at `J-orchestrator-0215` — *the lane
gains an explicit cycle comparison*. This packet is that comparison, designed.

It is **not** a cycle-by-cycle differential comparison, and §4 is the whole
argument for why the ruling's own words cannot be taken literally without
asserting something REQ-901 deliberately excludes.

---

## 1. The measurement this packet is priced from

Two mutation campaigns have now run with this lane in the loop. Twelve seeded
classes, every one of them a real defect injected into our M03, every one of
them killed by the unit bench. **The lane's comparison reported a divergence in
zero of the twelve.** Re-derived at this tree, per class, against the lane's own
stimulus (`test/cosim/stimulus_gen.ml`: **one** 64-octet good-FCS frame at a
**lane-0** start, standard 12-octet gap, 24 drain cycles — no second frame, no
error character, no bad FCS, no runt, no oversize, no abort):

| campaign | class | rendered at *the lane's* stimulus? | `cosim` job | what its result was evidence of |
|---|---|---|---|---|
| L | **IC-L1** re-arm between frames | **no** — needs ≥ 2 frames | green | nothing |
| L | **IC-L2** uniform ΔC 3 → 4 | **YES** | green | **the timing blindness — grammar-bound** |
| L | **IC-L3** delay varies with residue, `R = {2}` | **no** — the lane delivers 60 octets, 60 mod 8 = 4 | green | nothing |
| L | **IC-L4** tail word lost to the next start | **no** — needs ≥ 2 frames | green | nothing |
| L | **IC-L5** last word delivered twice | **YES** | **red** | **`ours_run`'s own guard, not the comparison** |
| M | **IC-M1** precedence at a runt with wrong FCS | no — needs a runt and a wrong FCS | green | nothing |
| M | **IC-M2** residue compared at REQ-108 truncation | no — needs an oversize frame | green | nothing |
| M | **IC-M3** residue compared at an `/E/` closure | no — needs an error character | green | nothing |
| M | **IC-M4** residue compared at an `/S/` closure | no — needs a second start character | green | nothing |
| M | **IC-M6** `/S/` in `Discard` reported as an abort | no — needs `Discard` | green | nothing |
| M | **IC-M7** `/E/` in `Discard` reported | no — needs `Discard` | green | nothing |
| M | **IC-M10** residue compared at every terminate | no — differs only below 5 octets | green | nothing |

**Two of twelve are rendered at all.** Of those two, one (IC-L5) was caught by a
consistency guard inside `ours_run` — *"M03 produced an output word with no
admitted frame open"* — and **not** by REQ-901's comparison; the other (IC-L2)
was rendered on the wire, reached the lane, and could not be written down.
**IC-L2 is the one class in twelve that this packet converts from invisible to
visible**, and it is the MATERIAL one.

**Two corrections to my own prior text fall out of that table and are recorded
here rather than left to be discovered:**

1. **`WO-0074-VERDICT` §11 item 1 named the GRAMMAR as the cause of the strobe
   blindness. The binding constraint is the STIMULUS.** All seven family-M
   classes are unreachable at one good frame; a strobe field would have been an
   all-zero column under every one of them. The grammar is *a* cause and not
   *the* cause, and §9 prices the difference.
2. **`WO-0073-VERDICT` §13's "a fixed-length line-rate stress run cannot see a
   residue-keyed latency defect" has a sibling that was never stated: neither
   can a one-frame co-simulation see any defect whose condition needs a second
   frame.** Four of the twelve classes above are unreachable for exactly that
   reason. The lane's stimulus is the smallest one that can exist, which was the
   right call at `WO-0046` and is now a measured bound on everything the lane
   can ever be cited for.

---

## 2. The grammar extension (the pinned form, amended)

`canonical.mli`'s grammar block is **normative** and is amended here — the first
amendment since it was pinned at `WO-0046` §2.3. Two fields, both integers, both
in the **same shared time base** (§3).

```
  F <frame-index> <admit-cycle>
  W <tkeep-hex-2> <tlast 0|1> <tuser0 0|1> <cycle> <octet-hex-2>*
  D <frame-index> <accept|discard>          (UNCHANGED)
```

- `<admit-cycle>` — the time-base index of the input word on which this frame's
  start character was recognised. Both producers already compute the recognition
  at that exact point (`ours_run.ml`'s `Xgmii_word.start_lane` test before
  driving; `tb_xgmii_rx_64.v`'s `rxc_line[0]/[4] == 8'hFB` test before driving),
  so neither side needs new logic to know it — only to record it.
- `<cycle>` — the time-base index at which this output word was observed on the
  DUT's `rx` / `m_axis_t*` stream.

**Both are DECIMAL, unpadded, no `0x`, no leading zeros beyond the digit `0`
itself.** Hex was rejected on purpose: `<cycle>` sits immediately before the
variable-length octet list, and a decimal token there makes an **old-format file
unparseable rather than misparseable**. Feed the current writer's output to the
new reader and `0f` fails `int_of_string` at the cycle position; the octet-count
check against `popcount tkeep` is the second net behind it. A producer left
un-updated therefore produces `compare` exit **3** — NO-VERDICT, a loud
non-result — and can never produce a false green. That property is a
**deliverable**, not an accident: state it in the `.mli` and prove it in the
self-test (§7 case f).

The sidecar (`*.canon.meta`) is untouched and remains never compared.

---

## 3. The time base, and the three tiers

### 3.0 The shared time base

`stimulus.txt` has one line per cycle. Both producers consume it in order, one
line per driven cycle, and both sample the DUT reading associated with the word
driven at that line. **The 0-based stimulus line index is therefore a time base
both sides already own, derived from a file rather than from either design, and
identical by construction.** `ours_run.ml` gets it from the position in the
stimulus list; `tb_xgmii_rx_64.v` already maintains `stimulus_lines` and needs
only `stimulus_lines - 1`. **No new stimulus, no new simulator feature, no
change to either sampling convention** — `~clock_edge:Side.Before` on our side
and `@(posedge clk); #1` on the reference's both stay exactly as they are, and
neither may be touched by this packet (§8).

### 3.1 Tier **T0** — admit-cycle equality. *Asserting. Cross-side. Its subject is the stimulus.*

For every frame index present on both sides, `ours.admit_cycle` **SHALL** equal
`theirs.admit_cycle`.

Both sides derive this number from the same file by the same rule, so T0 makes
**no claim about either design** and REQ-901's cycle-alignment exclusion does not
reach it. It is the calibration check that makes every other timing number in
the run meaningful.

**A T0 red means: the two producers are not indexing the same stimulus the same
way.** The harness is broken, not the design. **On a T0 red the comparator SHALL
withhold T1 and T2 rather than report them** — a timing verdict computed on
unaligned bases is worse than no verdict, and this is the same rule `WO-0049` §8
minted for `compare`'s exit 3.

T0 will hold by construction until someone breaks a counter. **That is its job.**
Its greenness is evidence about the harness and about nothing else, and the
`.mli` says so.

### 3.2 Tier **T1** — our side, against SPEC-M03. *Asserting. This is the tier that pays `WO-0073-D2`.*

For each frame our side reports `accept`, output word *m* **SHALL** be observed
at cycle

```
    admit_cycle + m + 3
```

— `docs/specs/modules/xgmii_rx_64.md` §6.1's gapless formula, read at the start
word. For the lane's current stimulus (one gapless 64-octet frame, start
character at line 0, eight delivered words) the expected set is therefore
**exactly `{3, 4, 5, 6, 7, 8, 9, 10}` with `tlast` at 10**, which is §6.1's own
cycle-by-cycle worked table copied out of the spec — derive it yourself from the
table and confirm my arithmetic agrees before you encode it.

Three constraints on how this is written, each of which is a defect if missed:

- **Derive it from the spec, never from the reference and never from a measured
  run.** ADR-0015 D2 and REQ-901's closing sentence: an exclusion is never a
  licence to take an expected value from the reference. If T1 reds on the first
  CI run, the answer is a `BUG-` or a spec question — **never** an expectation
  edited to agree with what was observed.
- **The formula's antecedents are gaplessness and the start lane.** §6.1 gives
  the same absolute cycles at a lane-0 and a lane-4 start, so the start lane does
  **not** enter the formula; injected idle cycles **do** (§6.1: word *m* is
  emitted as many cycles later as there are idles injected at or before D(m)).
  The lane's stimulus injects nothing. **Implement a guard, not an assumption**:
  if the stimulus ever carries an idle word between a frame's start character and
  its terminate character, T1 **SHALL** refuse to assert and say so, exactly as
  `ours_run` already `failwith`s on a second start character rather than guessing.
  A tier that silently asserts the wrong constant on a stimulus it was not
  designed for is the failure this programme has paid for at
  `RV-0057-VERDICT` Finding 1 and again at `RV-0062` FINDING B-1.
- **T1 runs on the `ours` transaction alone.** It takes no argument from
  `theirs`. This is what keeps it inside REQ-901 (§4).

**A T1 red means: our M03 emitted an output word at a cycle other than the one
SPEC-M03 §6.1 pins for it, on a stimulus whose content both implementations
agree on.** It is a defect against **our** specification — a `BUG-` candidate
against REQ-005/REQ-111 — and it is **not** a differential finding. That
distinction is why it gets its own exit code (§6) and never `EXIT_DIFFERENTIAL`.

**A T1 green means: eight output words landed on their eight spec-pinned cycles,
for one 64-octet good-FCS lane-0 frame.** It is not timing coverage of any other
stimulus class and no `SO-` may cite it as such (§10, and the amended bar in
`test/attack_plans/AP-xgmii_rx_64.md` §7).

### 3.3 Tier **T2** — the reference's cycles. *Recorded, reported, NEVER adjudicated.*

The comparator prints the reference's own per-word cycles and the per-word
`theirs − ours` offset. **It contributes to no exit code, no pass, and no fail.**

This is the disposition REQ-901 itself uses one clause away, for the reference's
handling of a sub-5-octet frame: *"the reference's actual disposition of it is
recorded as data on the first run that drives one, never adjudicated."* T2 is
that clause applied to time.

What it buys, stated so it is not oversold: **the reference's pipeline depth
becomes measured for the first time** — `stimulus_gen.ml`'s own comment records
it today as *"unmeasured (this environment has no iverilog …)"* — and an upstream
re-vendor that changes the reference's timing becomes **visible in the CI log**
rather than silent. What it does not buy: anything at all about our design. **No
`SO-` may cite a T2 figure as evidence of anything**, and the report prints that
sentence beside the numbers rather than leaving it to a reader's discipline.

---

## 4. Why this is NOT a cycle-by-cycle differential comparison — and a correction to the ruling's own wording

**REQ-901, quoted exactly:**

> The comparison SHALL be **transactional, not cycle-by-cycle** … **Cycle
> alignment, internal pipelining and latency constants are deliberately not
> compared: ours are pinned by REQ-005 and REQ-111, the reference's are its own.**

`J-orchestrator-0215` adopted option (a) in the words *"the lane gains an
explicit cycle comparison"*. **Taken literally — ours' cycles compared against
theirs' — that would assert precisely the quantity the frozen requirement
excludes by name, and it would be wrong on the merits as well as on the text:
two independently designed receivers are under no obligation to share a pipeline
depth, so a cross-side cycle equality would red a conformant design, and the only
way to make it green would be to take an expected value from the reference,**
which ADR-0015 D2 and REQ-901's own last sentence forbid outright.

**I therefore implement the ruling's intent and not its wording, and I record the
divergence rather than quietly resolving it.** The intent is *the anchor must be
able to see time*. This packet delivers that: the lane **records** time on both
sides (recording is not comparing, and REQ-901 restricts only the comparison),
**asserts** our side against **our own frozen spec**, and **reports** the
reference's as data. Under IC-L2 — ΔC 3 → 4 on every output word — T1 reds on all
eight words. The blindness is closed at the class that measured it, without a
spec amendment and without a claim the spec forbids.

**Two things follow, and both belong in the record rather than in this packet
alone:**

- **A cross-side timing comparison is not "not yet built" — it is barred.** That
  is a stronger statement than a blindness and it is per-quantity, so it sits
  beside `AP-xgmii_rx_64.md` §7's bar 2 (per-requirement) in kind. It is written
  into §7's banner in this round's companion commit.
- **If a later phase genuinely wants a cross-side timing comparison, the route is
  a REQ-901 spec diff through architect_docs_lead, never a comparator that
  asserts it locally.** REQ-901 amends itself in terms; a lane does not.

**Escalation class**: none. This is a drafting correction inside my own scope,
made against a ruling I asked for, on evidence the ruling did not have. It is not
E5 and I am not disputing the ruling — I am delivering it in the only form the
frozen spec admits. If the orchestrator reads it otherwise, the packet is a
position paper and the ruling stands until re-ruled.

---

## 5. tb_writer's half — `test/cosim/**`

**5.1 `canonical.mli` + `canonical.ml`.**
Extend `type word` with `cycle : int` and `type frame` with `admit_cycle : int`.
Amend the normative grammar block per §2, including the decimal rule and the
old-file-fails-loudly property. `write` gains the two fields; `read` parses them
and rejects a negative cycle. **`compare_transactions` is UNCHANGED in what it
compares** — the four existing `Word_mismatch` fields stay exactly as they are,
and **`cycle` is NOT added to `compare_words`** (that would be the cross-side
comparison §4 bars). Add instead:

```ocaml
type timing_divergence =
  | Admit_cycle_mismatch of { index : int; ours : int; theirs : int }
  | Spec_cycle_mismatch  of { index : int; word_index : int
                            ; expected : int; observed : int }
  | Unassertable of { index : int; why : string }

type timing_report =
  { base_aligned      : bool
  ; spec_divergences  : timing_divergence list
  ; reference_profile : (int * int list) list   (** frame index -> theirs' cycles *)
  ; offsets           : (int * int list) list   (** frame index -> theirs - ours, per word *)
  }

val check_timing : ours:transaction -> theirs:transaction -> timing_report
val timing_report_to_string : timing_report -> string
```

`timing_report_to_string` **SHALL** print, in this order: T0's verdict; T1's
expected-vs-observed table; then T2 under a heading that contains the words
**RECORDED, NEVER ADJUDICATED**. On `base_aligned = false` it prints T0's
divergence and, in place of T1 and T2, the sentence that they are **withheld**
and why — never an empty section, which reads as a pass.

**5.2 `ours_run.ml`.** Carry the line index through `read_stimulus` → the trace →
`accumulate` (the `List.map` over `stimulus` becomes indexed). Record
`admit_cycle` at the point the start character is recognised and `cycle` at the
point a `tvalid` word is captured — both are already single, unambiguous places
in that function. **`accumulate` stays a plain function over
`(Xgmii_word.t * Stream_word.t)` with no Hardcaml dependency**, so it remains
exercisable on a hand-built trace; the index is a third component or a fold
counter, your call, but the property is a deliverable.

**5.3 `tb_xgmii_rx_64.v`.** `stimulus_lines` already exists and is already
incremented before the drive. Write `stimulus_lines - 1` into the `F` line at
`open_frame` and into each `W` line in `write_word`. Use `%0d`. **Read
`WO-0049` §3's note in `write_word` before touching that task** — the printed
width of a `%x` field is set by its argument's bit width, and that is the defect
that cost run `30825741565`; `%0d` on an `integer` has no such trap, which is a
second reason the field is decimal.

**5.4 `compare.ml`.** Call `check_timing` after `compare_transactions`, print
both reports, and return the code §6 pins. Extend `--self-test` per §7. Update
the usage text and the header's exit-code list.

---

## 6. data_wrangler's half — `tools/cosim/run_cosim.sh`

`compare`'s exit-code contract gains two codes. Its existing three are unchanged:

| compare exit | meaning | run_cosim maps to |
|---|---|---|
| 0 | clean: content agrees, T0 aligned, T1 met | continue |
| 1 | **content** divergence (REQ-901's comparison) | `EXIT_DIFFERENTIAL(4)` — unchanged |
| 2 | ambiguous (usage / uncaught) | `EXIT_INTERNAL(9)` — unchanged |
| 3 | could not read a canonical file | `EXIT_NO_VERDICT(8)` — unchanged |
| **4** | **T1 reached a verdict and it was negative** | **`EXIT_TIMING(10)` — new** |
| **5** | **T0 unaligned: no timing verdict reached** | **`EXIT_TIMING_NO_VERDICT(11)` — new** |

**Precedence inside `compare`, pinned here so it is not invented:** content wins.
If content diverges, exit **1** whatever the timing tiers said — the full report
still prints every tier, so nothing is hidden and `1` keeps exactly the meaning
it has today. Otherwise T0 (**5**), otherwise T1 (**4**), otherwise **0**.

`EXIT_TIMING(10)` sits on §8's *reached-a-verdict-and-it-was-negative* side with
4, 5 and 6. `EXIT_TIMING_NO_VERDICT(11)` sits on the *did-not-reach* side with 2,
3 and 8. **Extend the exit-code table in the header with both, in the table's own
voice, including the sentence that a timing red is a defect against OUR spec and
never a disagreement with the MIT reference** — that separation is `WO-0049` §8's
rule applied to a third axis, and it is the reason two new codes exist rather
than one reused.

**The SUMMARY block gains one line, and its wording is load-bearing:**

```
  timing: OUR side asserted against SPEC-M03 §6.1 (T1); the reference's own
          cycles are RECORDED AND NOT ADJUDICATED (T2, REQ-901's exclusion).
          This run's green is timing evidence for the ONE stimulus class it
          drives and for no other.
```

Nothing else in the script changes. The `*)` fail-closed branch stays exactly as
it is (§11 depends on it).

---

## 7. The self-test — where the tier gets its teeth

`compare --self-test` is check 2/3's entire justification: it proves the
production comparison path *reports a difference when one is seeded*. A new tier
shipped without a self-test case is a tier with no teeth, and `WO-0073-D1` is on
the record as the round where a component's declared universe turned out to be
one level too shallow. **Six cases, all through `run_comparison`'s production
path, all against real files on disk:**

| # | case | required outcome |
|---|---|---|
| a | identical pair, cycles correct | exit **0** |
| b | one octet perturbed (existing) | exit **1** |
| c | malformed file (existing) | exit **3** |
| d | **every** word's cycle shifted by **+1** on our side, content untouched — *the exact shape of IC-L2* | exit **4** |
| e | exactly **one** word's cycle shifted by +1 | exit **4** |
| f | an old-format file (no cycle fields) | exit **3**, never 0 and never 1 |

**Case (d) is the most important test in this packet.** An implementation that
compared only *differences between consecutive words* would pass (e) and fail to
catch (d) — and (d) is the defect that motivated the whole finding, because a
uniform shift preserves every inter-word delta. Write (d) first and make sure it
fails before the tier is implemented.

Add a T0 case as well if it costs you nothing: two files whose `admit_cycle`s
disagree → exit **5**, with T1 and T2 visibly withheld.

---

## 8. Out of scope — and these are prohibitions, not omissions

1. **The stimulus does not change.** Not its frame, not its length, not its
   start lane, not its drain. `stimulus_gen.ml` is not in either deliverable
   list. A second frame or an error injection is a *different* work order with a
   different risk profile, and folding it in here would make a failing CI run
   un-diagnosable between two independent changes.
2. **Neither sampling convention changes.** `~clock_edge:Side.Before` and
   `@(posedge clk); #1` stay. If they were wrong, every result this lane has ever
   produced is wrong, and that is not a thing to discover by accident inside a
   grammar change.
3. **`compare_words` does not gain `cycle`.** §4.
4. **No vendored file is edited.** ADR-0015 D2's no-edit rule; `axis_xgmii_rx_64.v`
   and `lfsr.v` are read-only, and the reference's `start_packet`,
   `error_bad_frame` and `error_bad_fcs` outputs stay tied off (§9).
5. **No strobe field.** §9.
6. **No `dune` is run by either assignee and no `git` by anyone but the
   orchestrator.** ADR-0005: this change cannot be executed anywhere in this
   programme's development environment, and **the landing CI is the check** —
   see §10.
7. **`test/attack_plans/**` is not either assignee's to touch.** The bar this
   packet narrows is amended by dv_lead in the same round that drafts it.

---

## 9. The strobe record — REFUSED, with its price stated

`WO-0074-VERDICT` §14 item 2 commissioned a **decision**: *whether the canonical
form gains a strobe record at all, now that a whole eight-class campaign has run
under it invisibly.* **The decision is NO — not now and not as a grammar field —
and it is a refusal rather than a deferral, so here is what it costs and why it
is still right.**

**(a) At the lane's stimulus a strobe record buys zero of twelve.** §1's table:
all seven family-M classes are unreachable at one good frame, and neither
family-L class that *is* rendered is a strobe defect. A strobe column added today
would be **all zeros on every line of every run**.

**(b) The comparable strobe set is bounded above by ONE of M03's five, and the
bound is in the frozen spec, not in the harness.** M03 owns five strobes
(SPEC-M03 §4.1, requirements.md §12): `error_bad_fcs`, `error_bad_frame`,
`error_runt`, `error_oversize`, `error_start_without_terminate`. Against them:

| M03 strobe | reference counterpart | comparable? |
|---|---|---|
| `error_runt` | — | **NO, by specification.** REQ-107 is REQ-901's declared divergence class **(e)**: *"a co-simulation result is not an admissible external anchor for it, and a sign-off packet SHALL NOT offer one"* |
| `error_oversize` | — | **NO, by specification.** REQ-108 is class **(f)**, same sentence |
| `error_start_without_terminate` | — | **NO.** The reference's published port list has no counterpart output at all |
| `error_bad_frame` | `error_bad_frame` | **NO — same name, different signal.** The reference raises it on a bad FCS *as well*; SPEC-M03 §9's table does not. A name-keyed comparison would red a conformant M03 |
| `error_bad_fcs` | `error_bad_fcs` | **the only candidate**, and it still needs a declared mapping and a stimulus that produces a bad FCS |

**(c) An all-zero strobe column is worse than no column.** It would make the lane
*look* strobe-aware to every future reader while asserting nothing — and
`WO-0074-VERDICT` §11 item 1's *"that green is evidence of nothing"* would become
**invisible** instead of merely true. This programme's recurring failure is a
summary sentence left standing while the world it summarises moves
(`RV-0039-VERDICT` F-2, and three more instances catalogued in `AP` §7's own
banner). A field is a summary sentence a machine writes.

**The ordered preconditions, so the refusal is checkable rather than
open-ended.** A strobe record becomes worth building when, and only when, **all
three** hold:

1. **Stimulus** — the lane drives at least one frame whose condition makes a
   comparable strobe pulse on both sides. Today it drives none. This is the
   binding constraint and it is first.
2. **Mapping** — a committed, declared correspondence between our strobe names
   and the reference's, with every non-corresponding strobe listed as
   non-corresponding **and the reason**. Today that mapping has at most one row.
3. **Grammar** — only then a field, carrying only the mapped strobes, with the
   unmapped ones recorded as *not compared* rather than silently absent.

Until all three hold, **the lane is strobe-blind and no `SO-` may cite it as
strobe coverage** — and the reason a `SO-` must give is **the stimulus**, not the
grammar. That bar is written into `test/attack_plans/AP-xgmii_rx_64.md` §7 in
this round's companion commit, beside bar 3, where the next sign-off packet's
author reads it.

---

## 10. Definition of done

**tb_writer:**
- [ ] `canonical.mli`'s normative grammar block amended per §2, including the
      decimal rule and the old-file-fails-loudly property, stated as a contract.
- [ ] `check_timing` implements T0, T1 and T2 exactly as §3 specifies, with T1
      derived from `docs/specs/modules/xgmii_rx_64.md` §6.1 and the derivation
      shown in a comment beside the constant.
- [ ] The §3.2 guard: T1 refuses to assert on a stimulus carrying injected idle
      inside a frame, and says so.
- [ ] `compare_words` unchanged; `cycle` compared nowhere across the two sides.
- [ ] All six §7 self-test cases present and passing, **(d) written first**.
- [ ] Journal entry appended (`agents/journals/workers/claude_tb_writer_agent*.md`),
      spawn short-id in Trigger, `Inputs` naming spec paths and REQ ids and
      **listing no `libs/**` path**.

**data_wrangler:**
- [ ] Both new exit codes mapped and documented in the header table in its own
      voice, including the our-spec-not-the-reference sentence.
- [ ] The SUMMARY line of §6, verbatim in substance.
- [ ] `*)` fail-closed branch untouched.
- [ ] Journal entry appended.

**Both:**
- [ ] No file outside the deliverable list is staged.
- [ ] No `dune`, no `git`, no `iverilog` run locally — none is available and a
      claim that one was is a finding.

**Evidence, and what CI's colours mean (ADR-0005, REQ-906).** Neither assignee
nor I can execute this change: there is no Hardcaml toolchain and no iverilog in
the development container. **The landing CI run is the check, and it is the only
one.** On the landing commit:

- **`cosim` job green** = the extended grammar parses on both sides; T0 holds, so
  the two producers index the same stimulus identically; T1 holds, so our eight
  output words landed on cycles 3 … 10 as SPEC-M03 §6.1 pins them; and the
  self-test's case (d) confirmed the tier reddens on a seeded uniform shift.
  **It is timing evidence for one 64-octet good-FCS lane-0 frame and for
  nothing else.**
- **`cosim` job red at `EXIT_TIMING(10)`** = T1's assertion failed on the
  unmutated design. That is either a defect in our M03 against REQ-005/REQ-111
  (open a `BUG-`) or an error in the constant I derived in §3.2 (a finding
  against this packet). **It is decided by re-reading §6.1, never by editing the
  constant to match the observation.**
- **`cosim` job red at `EXIT_TIMING_NO_VERDICT(11)`** = the harness's two halves
  disagree about the time base. A defect in this packet's own implementation, and
  nothing whatever about the design.
- **`cosim` job red at `EXIT_NO_VERDICT(8)`** = the two halves landed with only
  one of them updated. §11 says this is the safe failure and here it is.
- **`build` job green** with a red `cosim` = the OCaml half compiles and the
  main suite is unaffected, which is the split this lane's `(executables)`
  stanza exists to produce.

**Doc impact**: none in `docs/`. The bar in `test/attack_plans/AP-xgmii_rx_64.md`
§7 is amended by dv_lead in this round's companion commit, not by either
assignee.

---

## 11. Why either landing order is safe

If **tb_writer lands first**: `compare` may return 4 or 5, which the current
`run_cosim.sh` does not recognise. Its `*)` branch fails closed to
`EXIT_INTERNAL(9)` — **never `EXIT_DIFFERENTIAL`**, which is the property
`WO-0049` §8 built that branch for. A timing red would be reported as a machinery
problem: imprecise, and never an over-claim.

If **data_wrangler lands first**: codes 4 and 5 simply never occur. The mapping
is dead until its producer exists.

If **one producer of the grammar lands without the other** — `ours_run.ml`
updated and `tb_xgmii_rx_64.v` not, or the reverse — the un-updated side writes
an old-format file, the new `read` rejects it at the cycle token, and `compare`
exits **3** → `EXIT_NO_VERDICT(8)`. **Loud, correct, and impossible to read as
agreement.** §2's decimal choice is what guarantees this; it is the reason for
the choice.

**The tier may not be cited in any `SO-` until both halves have landed and one
CI run has been green with both present.**

---

## 12. Return / verdict log

*(appended by the assignees on RETURNED, and by dv_lead on ACCEPT/BOUNCE, with
journal-entry refs)*

---

**Drafted by dv_lead at `J-dv_lead-0139`.** Companion commits in the same round:
`tools/dv_checks.sh` (`FINDING M-4`), `tools/cosim/run_cosim.sh`
(`WO-0073-D5`), `test/cosim/dune` (the dangling `test/cost_probe/` reference),
`test/attack_plans/AP-xgmii_rx_64.md` §7 (bar 4, the strobe blindness).
