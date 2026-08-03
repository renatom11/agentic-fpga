# WO-0040: Family D — the FCS check, and the first bad-FCS frame this programme has ever driven

- **State**: DRAFT (id assumes WO-0040 is next free; orchestrator allocates)
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03) at the
  countersigned SHA — §4.1 ports, §6.1 (the residue check, the `Preamble`
  seeding rule, the drain paragraph), §6.2's `Frame` and its `/T/` exit, §6.3
  item 1, §7, §9 (row 1, the strobe-cycle pin, ruling 9); and
  `docs/specs/requirements.md` §0.3, §0.6, §0.7.
  REQ ids in scope: **REQ-104, REQ-304, REQ-005, REQ-007, REQ-013, REQ-103,
  REQ-101**.
  Attack-plan rows: `test/attack_plans/AP-xgmii_rx_64.md` §4.D — **four rows**,
  M03-D1, M03-D2, M03-D3 (ASSERT) and M03-D4 (NO-ASSERT).
- **Deliverables**: `test/xgmii_rx_64/test_m03_d.ml`, plus a **named, bounded**
  addition to `bench.{ml,mli}` (§3.2) and a `dune` stanza update if the new
  file needs one.
- **Bench SHA this builds on**: the WO-0039-qualified tree. The existing
  fifteen `%expect_test`s must all stay green; you may not modify any of them.

## Task

Write family D. It is four rows and it is small on purpose — the review loop
that just ran six rounds on twelve rows gets one more turn on a small family
before the D–H wave commits to a shape.

**Why this family leads the wave, in one sentence you should keep in view the
whole time**: all fifteen existing tests assert `tuser`[0] = 0 and *no* strobe
**on good frames**, nothing anywhere drives a bad-FCS frame, and therefore **a
design that hardwired the FCS verdict to good and never pulsed `error_bad_fcs`
would pass this entire suite today.** REQ-104's positive direction is
unverified. M03-D1 is its closure. You are not adding coverage at the margin;
you are closing a hole that the WO-0039 mutation campaign could not find,
because none of its five mutations made the design *silently agree with every
existing assertion*.

## 1. The four rows

| Row | Status | What it asserts |
|---|---|---|
| **M03-D1** | ASSERT | A 64-octet frame with **one payload bit flipped after the FCS was computed**, both start lanes: the same 60 octets still delivered (forwarded in full, REQ-005), `tuser`[0] = 1 on the `tlast` word, **exactly one `error_bad_fcs` high cycle on the `tlast` cycle** (§9's pin), and **no other strobe of any kind** |
| **M03-D2** | ASSERT | The anti-vacuity partner: good-FCS frames carry `tuser`[0] = 0 and no `error_bad_fcs`. **Largely discharged by citation** — see §2 |
| **M03-D3** | ASSERT | Two frames at the **§0.3 minimum gap**, in **both orderings**, killing a design that reads the CRC register at the `tlast` cycle instead of carrying the verdict with the frame. **The attack-plan row is corrected by this packet — read §4 before writing it** |
| **M03-D4** | NO-ASSERT | Residue-versus-capture is unobservable (§6.3 item 1). **Declare it and assert nothing**, in the shape M03-A4 and M03-L6 already use |

## 2. M03-D2 — state the citation extent, do not re-drive it

D2's stimulus column in the plan reads "every good-FCS frame in this plan". The
existing suite already drives a large extent of that and asserts exactly D2's
observable. **Cite it; do not re-run it.** A row discharged by citation is
honest only if the citation is exact, so the packet you return must name the
extent, and the extent is:

- **lengths 64–71 at both start lanes** — `M03-C1/C2` (`outcome_ok` requires
  `observed_tuser = Some 0` and `error_pulse_count = 0`), and `M03-A3/A4`.
- **64 octets at both lanes** — `M03-A1/A2` (explicit `tuser` check and
  `error_pulses` empty), and `M03-A5` (position-dependent filler).
- **a 60-octet payload with nonstandard preamble filler, both lanes** —
  `M03-B1`.
- **1518 octets at both lanes** — `M03-C3`.
- **1513 and 1516 at both lanes** — `M03-C5`.

**Excluded from the citation, deliberately**: `M03-C4`'s 5-octet runt, which
carries `tuser`[0] = 1 by REQ-107 and is not a good-FCS clean case; and §9's
ruling 9 puts `error_bad_fcs` out of reach below 5 received octets anyway.

**What D2 must add on top of the citation**: the good-FCS partners of D1's and
D3's *own* frames — i.e. D1's uncorrupted 64-octet frame asserted clean at both
lanes, and D3's good member asserted clean in both orderings. Without that, D1
and D3 rest on the claim that their construction produces a bad frame *and only*
a bad frame, and that claim should be asserted where it is used rather than
inherited from a different test.

## 3. Machinery — what exists, and the one thing you add

### 3.1 Nothing is owed from the library

`AP` §7 reads as a gap list; it is **stale** and now carries a banner saying so.
X-1 through X-5 were all built at WO-0033. Everything family D needs exists:

- **`Dv_xgmii.Frame`** — `with_fcs`, `residue_ok`, `delivered`, `fcs`.
  `residue_ok` runs REQ-304's residue, which is the check M03 performs.
- **`Dv_xgmii.Arrival.create ?ifg ?first_start ?fcs_valid frames`** — takes a
  **list** of frames, so D3's pair needs no new scheduling primitive, and `ifg`
  defaults to §0.3's minimum of 12 octets counted from the terminate character
  inclusive, which is exactly D3's stimulus.
- **`Dv_monitors.Strobe_monitor.expect`** — pinned cycle plus a
  `not_before`/`not_after` window plus a `why` string. `M03-C4` already
  exercises this shape against `error_runt`; copy its call structure.
- **`Bench.account_clean_frame ... ~aborted:false`** — a bad-FCS frame is
  **forwarded in full** (§9 row 1), so its delivered extent is the ordinary
  clean-frame identity extent and `~aborted:false` is correct. Do **not** reach
  for the truncated-frame path; family D has no truncated frame in it.

### 3.2 `fcs_valid` is a trap, and it is the one you are most likely to fall into

`Arrival.create`'s `?fcs_valid` defaults to **true**, and when set, **`check`
verifies the REQ-304 residue over each frame**. `Bench.run` discharges
obligation 5 by calling `Arrival.check`. So:

> **Scheduling a bad-FCS frame without `~fcs_valid:false` makes the STIMULUS
> self-check fail.** The failure will look like a DUT finding and it is not one.

And `fcs_valid` is a property of the **schedule**, not of a frame: it says
"every frame carries a correct FCS". D3's pair is mixed, so it must be built
with `~fcs_valid:false`, **which switches the residue check off for the good
member too**. Therefore:

> **Wherever you pass `~fcs_valid:false`, assert the frames' FCS status
> yourself at construction, in both directions**: `Frame.residue_ok good` must
> be **true** and `Frame.residue_ok bad` must be **false**, each with a message
> saying "test bug" rather than naming M03. `M03-B1` already does the positive
> half of this and is the pattern to follow.

The negative half is the anti-vacuity guard that matters: if your bit-flip
silently failed to land — wrong index, wrong list, flipped in a copy — the
frame would still be good, D1 would assert `tuser`[0] = 1 against a conformant
design, and the row would fail for a reason that has nothing to do with M03.

### 3.3 The one bench addition you are authorised to make

`Bench.one_frame` hardcodes the lane → `first_start` mapping (0 → 8, 4 → 12)
and takes a single frame. D3 needs two frames and a cleared `fcs_valid`. Add:

```
val frames_at : lane:int -> fcs_valid:bool -> int list list -> Dv_xgmii.Arrival.t
```

with the same §0.3 lane mapping and `Arrival.create`'s default `ifg`, and
**re-express `one_frame` in terms of it** so the mapping has exactly one home.
That re-expression is a **behaviour-preserving refactor** and its entire
acceptance evidence is that **all fifteen existing tests stay green** — if any
of them moves, the refactor was not behaviour-preserving and you must say so
rather than adjust the test.

Do not add anything else to `Bench`. If you believe a second addition is
required, **stop and return the question** rather than adding it; an unbudgeted
bench surface is a review round, and this packet is trying to be short.

## 4. M03-D3 — the attack-plan row is WRONG, and this packet corrects it

`AP` row M03-D3 specifies *"a **bad**-FCS 64-octet frame followed at the
minimum 12-octet gap by a **good**-FCS frame"* and claims it kills a design
that reads the CRC register at the `tlast` cycle. **It does not.** I worked the
arithmetic while writing this packet, and the ordering is inverted. Build the
corrected row below; the plan is being corrected in the same commit.

**The arithmetic.** At a lane-0 start with `first_start = 8`, frame 1's start
character is at octet time 8, `start_cycle` = 1; its 64 octets occupy octet
times 16–79; its terminate character is at octet time **80**, cycle **10**,
lane **0**. Its `tlast` word is word 7, emitted at `start_cycle + 3 + 7` =
cycle **11**. With `ifg` = 12 counted from the terminate inclusive, frame 2's
start character lands at octet time **92** — cycle **11**, lane 4. **Frame 2's
start character arrives on the very cycle frame 1's `tlast` word is emitted**,
and §6.1 seeds the CRC register in `Preamble`. That coincidence is the row's
whole mechanism and the plan got it right.

**What the plan got wrong is which ordering discriminates.**

| ordering | correct design (verdict carried with the frame) | wrong design (register read at `tlast`) | discriminates? |
|---|---|---|---|
| **bad** then good | frame 1 → bad | reads frame 2's fresh seed; seed ≠ REQ-304's residue → **bad** | **NO** — both say "bad". The row as written passes against the design it names |
| **good** then bad | frame 1 → **good** | reads frame 2's fresh seed → **bad** | **YES** — the wrong design marks a good frame invalid |

So **the killing pair is good-then-bad**, and the assertion that fires on the
wrong design is *frame 1 carries `tuser`[0] = 0 and no strobe*.

**Drive both orderings anyway**, because the second one is not redundant — it
kills a different design:

- **Pair A — good then bad.** Frame 1: `tuser`[0] = 0, no strobe. Frame 2:
  `tuser`[0] = 1, exactly one `error_bad_fcs` on **its own** `tlast` cycle.
  *Kills the register-read design.*
- **Pair B — bad then good.** Frame 1: `tuser`[0] = 1, one `error_bad_fcs` on
  its `tlast` cycle. Frame 2: `tuser`[0] = 0, **no strobe**. *Kills a design
  that latches the abort bit and fails to clear it between frames* — a real
  and different defect, and the reason the plan's original ordering still earns
  its place.

Run both at **both start lanes**: four schedules.

**Do not repair the attack plan yourself.** `test/attack_plans/**` is dv_lead's;
the correction is in this commit. Cite this section, not the plan's row text,
where the two differ.

## 5. The age-0 declaration — and a correction to my own wording

`AP` §8 requires the first D–H bench to state which of its rows depend on an
**age-0 closure record**. For family D the answer is stated here so you do not
have to derive it:

> **No family-D row depends on an age-0 closure record.** §9 pins every strobe
> to the cycle M03 emits that frame's `tlast` word. For D1's 64-octet frames
> the `tlast` word is at `start_cycle + 10` while the terminate character
> arrives at cycle 10 — **one cycle earlier, at both start lanes**. The verdict
> and its strobe are therefore never co-timed with the closing input word in
> this family's stimulus, and since WO-0038 round 6 the bench samples at
> `~clock_edge:Side.Before`, where they would be visible even if they were.

**What the two lanes do differ in**, and it is the built-in control that makes
D1 worth driving twice: at a **lane-0** start the terminate character arrives in
a word carrying **no frame octets** (`terminate_lane` = 0), which per §6.2's
`Frame` row **holds** the frame — that word produces no output. At a **lane-4**
start the terminating word carries **four** frame octets and is not held. Same
frame, same `tlast` cycle, two structurally different closing words.

> **Correcting `J-dv_lead-0037`**, where I wrote that D1's lane-0 case is "in
> the age-0 class" and lane 4 is out. That was loose. Lane-0/64 shares
> `terminate_lane = 0` with R-1's disagreement class but is **not in it** —
> R-1's class additionally requires a **full** final delivered word, and
> lane-0/64's final word carries four octets (`tkeep` = 0x0F). It is explicitly
> excluded by `expected_disagree`'s second conjunct, which I verified entry by
> entry at `RV-0038-R7-VERDICT` §4. The distinction that survives is the one
> above: whether the terminating word carries frame octets. Build against this
> section, not against that journal sentence.

## 6. Row-by-row expected values, so you are not deriving these under review

**M03-D1**, both lanes, from `directed_frame_octets ~length:64` with **bit 0 of
the octet at index 20 flipped** after `with_fcs` (index 20 is inside the
payload: DA 0–5, SA 6–11, length/type 12–13, payload 14–59, FCS 60–63):

- **8 output words**, word *m* on cycle `start_cycle + 3 + m`.
- `tkeep`: words 0–6 = 0xFF, word 7 = 0x0F. `tlast` on word 7 only.
- **`tuser`[0] = 1** on the `tlast` word.
- **Delivered octets = `Frame.delivered corrupted`** — the **corrupted** frame's
  first 60 octets, *including the flipped one*. REQ-005 forwards in full; a
  design that repaired or dropped the frame fails here.
- **Exactly one strobe pulse, `error_bad_fcs`, on cycle `start_cycle + 10`** —
  the `tlast` cycle, §9's pin. `Strobe_monitor.expect` with
  `not_before = terminate_cycle`, `not_after = terminate_cycle + 3`, where
  `terminate_cycle = Arrival.terminate_octet_time frame / 8` = 10 at both lanes.
  **And no other strobe of any kind** — assert the exact set, not a lower
  bound, as `M03-C4` does.
- `account_clean_frame ... ~aborted:false`, then `assert_monitors_clean`, and
  `Conservation_monitor.strobe_pulse ~name:"error_bad_fcs"` as `M03-C4` does for
  its runt.

**M03-D3**, four schedules (two orderings × two start lanes), each built with
`frames_at ~lane ~fcs_valid:false [first; second]`. Assert per frame: delivered
octets, `tuser`[0], and the exact strobe set with each pulse on **its own
frame's** `tlast` cycle. The second frame's `start_cycle` comes from
`Arrival.frames sched).(1)`, not from arithmetic you do by hand.

## 7. What you may NOT read

Unchanged from WO-0038, and non-negotiable:

- **Never open `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**` — any path,
  manifests included**, targeted or swept. Scope every `grep` to `test/` and
  `docs/specs/`.
- Derive every expected value from **SPEC-M03 and requirements.md**, never from
  the design.
- **Third-party sources at the opam switch (`/root/.opam/**`) are readable** for
  signatures and semantics — the boundary I set at `RV-0038-R7-VERDICT` §6 —
  and every such read must be listed by path in your journal `Inputs`.
- `test/**` and `docs/specs/**` are readable in full. `test/attack_plans/**` is
  readable but **not writable by you**.

## 8. Expected-CI discipline — the regime facts already paid for

Do not rediscover these. Each cost this programme a round.

1. **ADR-0005: no toolchain reaches this directory.** You cannot compile. CI is
   authoritative. Say "UNVERIFIED" about anything you have not compiled, and
   never call a prediction a fact.
2. **The warning string is `-w @1..3@5..28@30..39@43@46..47@49..57@61..62-40
   -strict-sequence`.** Warning **9** (missing record fields) and warning **33**
   (unused open) are **fatal**. Warning 69 is **not** enabled. **Alerts are
   errors**, which is why `Base`'s `mod` is unusable — use **`Int.rem`**;
   `(%)` is *not* equivalent.
3. **A record pattern gets no type-directed label resolution from an
   unannotated scrutinee.** Annotate, or qualify the field.
4. **`Base.List.init` evaluates `~f` from the highest index down to 0** and
   returns ascending. If your `~f` has a side effect, the order will surprise
   you.
5. **Promotion discipline.** Every `[%expect]` block in this suite is empty and
   stays empty: a passing test prints nothing, and an empty block matching
   empty output is the intended green. **Never harvest a promotion.** If
   `runtest` produces a diff, that is a finding to report, not a snapshot to
   accept — and no promotion enters this tree without dv_lead's conformance
   review.
6. **Nothing timing-derived may be snapshotted.** Assert it in code and let the
   expect block stay empty. WO-0038 §6 rule 5, unchanged.
7. **Run a guard against the defect it names before shipping it.** If you write
   a check to catch condition X, construct X and confirm the check fires.
8. **Trace a change against the code it will run beside**, not against the code
   you imagine is there.

## 9. Family D's own mutation qualification — named now, so you know what "teeth" means

Family D will be qualified by a blinded mutation campaign exactly as WO-0038
was, under the WO-0039 protocol: behavioural intents to a seeder who cannot see
the predictions, predictions frozen and sealed before any diff exists,
throwaway branches parented on the frozen bench SHA. **The mutations are named
now so you write against them rather than around them**, one per row's declared
Kill:

| | mutation | must die |
|---|---|---|
| **D-M1** | **hardwire the FCS verdict good; never pulse `error_bad_fcs`** | **M03-D1** |
| **D-M2** | hardwire the verdict bad | **M03-D2**, and much of the WO-0038 suite |
| **D-M3** | report the verdict from the CRC register at the `tlast` cycle instead of carrying it with the frame | **M03-D3 pair A** (good-then-bad) |
| **D-M4** | pulse `error_bad_fcs` on the terminate cycle instead of the `tlast` cycle | **M03-D1** on the pinned-cycle check |

**D-M1 is the reason this packet exists.** It is the *silently-always-pass*
class — a mutation that agrees with every assertion the suite already makes —
and the WO-0039 campaign contained no such mutation, which is why it could not
find this hole. A row that does not die on D-M1 has not closed anything.

## 10. What I expect back

**A Return log appended to this packet**, plus your journal entry. **Do not
write an `SO-` packet**: the sign-off is dv_lead's under PROTOCOL §3, and
`SO-M03` does not issue on family D — families E–H remain unwritten and the
verilog-ethernet differential co-sim (charter §3's external anchor) has not run.

Structure the Return log as WO-0038's rounds did:

1. **Row disposition** — every row in §1, no silence. Row, test name, state,
   note.
2. **What you changed**, file and line, with the `frames_at` refactor's
   behaviour-preservation evidence stated separately.
3. **Every derivation you made from the spec**, with the section cited — so I
   can check the derivation and not just the number.
4. **Anything you could not verify**, marked UNVERIFIED with the reason.
5. **Expected CI, checked vs predicted** — predictions, labelled as such.
6. **Open questions** — including anything in §4's correction you think I got
   wrong. I have withdrawn four of my own claims in the last three days and
   would rather you found the fifth than that CI did.
7. **Scope statement** — `git status --porcelain` and `git diff --exit-code` on
   the files you claim are untouched, plus an explicit line that no `libs/**`,
   `top/**`, `bin/**` or `rtl_snapshots/**` path was opened, and the full list
   of any `/root/.opam/**` reads.

**How I will review it.** An `RV-` verdict with file:line defects, then the
blinded mutation campaign of §9 before any of these rows can carry a sign-off.

---

## Return log

### RETURNED (tb_writer, spawn WO-0040/2026-08-06T15:00Z)

State left as **ISSUED** — dv_lead's `RV-` flips it, per PROTOCOL §3.

#### 1. Row disposition

| Row | Status | Test | State | Note |
|---|---|---|---|---|
| **M03-D1** | ASSERT | `test_m03_d.ml`, `%expect_test "M03-D1: 64-octet frame, one payload bit flipped post-FCS, both start lanes …"` (`run_d1`) | Written, predicted PASS | Both lanes; corrupted-frame construction, bit 0 of octet index 20 flipped after `with_fcs`; `frames_at ~fcs_valid:false`; residue checked both directions by hand at construction |
| **M03-D2** | ASSERT | Citation extent: **already discharged**, no new test (see §2 below). New content: `test_m03_d.ml`, `%expect_test "M03-D2: good-FCS frames stay clean …"` (`run_d2_d1_partner`, `run_d2_d3_good_member`) | Written, predicted PASS | D1's own uncorrupted frame at both lanes (fresh drive, not inherited from D1's test); D3's good member, both orderings, lane 0 |
| **M03-D3** | ASSERT | `test_m03_d.ml`, `%expect_test "M03-D3: two 64-octet frames at the minimum gap, both orderings, both start lanes …"` (`run_d3`) | Written, predicted PASS | Four schedules — pair A / pair B × lane 0 / lane 4 — via `frames_at`, WO-0040 §4's corrected ordering table |
| **M03-D4** | NO-ASSERT | `test_m03_d.ml`, trailing comment block, no test function | Declared | No stimulus, nothing to assert (§6.3 item 1); shape follows M03-A4/M03-L6 as directed |

#### 2. What I changed

- `test/xgmii_rx_64/bench.mli` — added `val frames_at : lane:int -> fcs_valid:bool -> int list list -> Dv_xgmii.Arrival.t` with its doc comment; rewrote `one_frame`'s doc comment to state it is now `frames_at ~lane ~fcs_valid:true [ octets ]`. No other declaration touched.
- `test/xgmii_rx_64/bench.ml` — added `frames_at` (13 lines including its comment); replaced `one_frame`'s 8-line body with the one-line re-expression `let one_frame ~lane octets = frames_at ~lane ~fcs_valid:true [ octets ]`. No other binding touched. Full diff is 27 insertions / 6 deletions across the two files, `git diff --stat` confirmed.
- `test/xgmii_rx_64/test_m03_d.ml` — new file, 445 lines: `run_d1`, the `d3_ordering` type and `run_mixed_pair`/`assert_frame`/`split_at_first_tlast` machinery shared by D2's D3-partner check and D3, `run_d2_d1_partner`/`run_d2_d3_good_member`, `run_d3`, four `%expect_test`s (D1, D2, D3, plus D4's trailing declaration comment — no test function for D4).
- No `dune` change: `test/xgmii_rx_64/dune`'s `(library …)` stanza carries no `(modules …)` field, so it already includes every `.ml`/`.mli` in the directory, including the new file. `git diff --exit-code -- test/xgmii_rx_64/dune` is clean (confirmed in §7 below).
- `test/attack_plans/AP-xgmii_rx_64.md` — **not touched by me**. Its family-D correction was already committed in this packet's own commit per the task framing ("as just revised at the same commit") and confirmed by `git diff --exit-code` below; I only read and cited it.

**The `frames_at` re-expression's behaviour-preservation argument, line by line** (§3.3's acceptance evidence — all fifteen existing tests stay green because this is a pure re-expression):

```
OLD                                                  NEW
let one_frame ~lane octets =                         let frames_at ~lane ~fcs_valid octets_lists =
  let first_start =                                     let first_start =
    match lane with                                       match lane with
    | 0 -> 8                                              | 0 -> 8
    | 4 -> 12                                             | 4 -> 12
    | _ -> failwith "Bench.one_frame: ..."                | _ -> failwith "Bench.frames_at: ..."
  in                                                     in
  Arrival.create ~first_start [ octets ]                  Arrival.create ~first_start ~fcs_valid octets_lists
                                                       let one_frame ~lane octets =
                                                         frames_at ~lane ~fcs_valid:true [ octets ]
```

1. **The `match lane with 0 -> 8 | 4 -> 12 | _ -> failwith …` block is copied verbatim** into `frames_at`, with only the string literal inside the `failwith` changed (`"Bench.one_frame: …"` → `"Bench.frames_at: …"`). This is the ONLY textual difference in the shared block. For any call with `lane = 0` or `lane = 4`, `first_start` computes identically in both versions — the string change is unreachable on those two inputs. For `lane` outside `{0, 4}`, both versions raise `Failure`; only the message text differs. **None of the fifteen existing tests calls `one_frame` with a lane outside `{0, 4}`** (every call site in `test_m03_a.ml`, `test_m03_b.ml`, `test_m03_c.ml`, `test_m03_structural.ml` and `bench.ml`'s own `run_directed_lengths` passes `~lane:0` or `~lane:4` literally), so this path is never exercised by the passing suite and the message-text change cannot move any `[%expect]` block.
2. **`Arrival.create ~first_start [ octets ]` (old) is definitionally `Arrival.create ~first_start ~fcs_valid:true [ octets ]`** for the new call, because `Arrival.create`'s `?fcs_valid` parameter defaults to `true` (`arrival.mli`: "`[fcs_valid]` states whether every frame carries a correct FCS (default `true`)"; `arrival.ml`: `let create ?(ifg = 12) ?(first_start = 8) ?(fcs_valid = true) frame_octets = …`). `one_frame`'s new body is `frames_at ~lane ~fcs_valid:true [ octets ]`, which calls `Arrival.create ~first_start ~fcs_valid:true [ octets ]` — passing the SAME default value explicitly. An explicitly-passed default and an omitted optional argument are the same call at the value level; there is no third state `Arrival.create` can observe.
3. **The `[ octets ]` singleton-list wrapping is identical** — old code builds `Arrival.create ~first_start [ octets ]` directly; new code builds `frames_at ~lane ~fcs_valid:true [ octets ]`, and `frames_at`'s own body passes `octets_lists` (bound to `[ octets ]` at this call site) straight through to `Arrival.create` unmodified. Same single-element list reaches `Arrival.create` in both versions.
4. **`ifg` is untouched in both versions** — neither the old `one_frame` nor the new `frames_at` passes `?ifg`, so both rely on `Arrival.create`'s own default (12, §0.3's minimum) identically.
5. **Conclusion**: for every `(lane, octets)` pair any of the fifteen existing tests actually supplies (all with `lane ∈ {0, 4}`), `one_frame ~lane octets` calls `Arrival.create ~first_start ~fcs_valid:true [octets]` in the new code where it called `Arrival.create ~first_start [octets]` (implicit `fcs_valid:true`) in the old — the identical call, by (2). Every downstream consumer of the returned `Arrival.t` (`Arrival.frames`, `Arrival.start_cycle`, `Arrival.terminate_octet_time`, `Arrival.check`, `Bench.run`) is a pure function of that value, so nothing downstream can distinguish old from new. **I could not run the fifteen tests to confirm this mechanically (ADR-0005, no toolchain reaches `test/xgmii_rx_64/`)** — this argument is the acceptance evidence in its place, as the packet's §3.3 anticipates.

#### 3. Every derivation, with the section cited

- **D1's corruption construction** (bit 0 of the octet at index 20, flipped after `with_fcs`) — WO-0040 §6, copied verbatim (the packet supplies this exact construction so it is not re-derived).
- **D1's 8-word, `start_cycle + 3 + m` output timing and `word 7 = start_cycle + 10`** — WO-0040 §6, and independently confirmed by REQ-104's own text (`docs/specs/requirements.md` line 422: "Inject a frame with one payload bit flipped: the same octet count is delivered, `tuser`[0] = 1 on the last word, `error_bad_fcs` pulses once inside the §0.6 window, and no other strobe pulses unless the stimulus also creates that strobe's condition") and by SPEC-M03 §9's "Strobe cycle, pinned" (`docs/specs/modules/xgmii_rx_64.md` line 756: "Each strobe pulses for exactly one cycle, on the cycle M03 emits that frame's `tlast` word" — the general rule; D1's frame produces output, so the "no output word" clause of the same paragraph does not apply to it).
- **D1's `not_before`/`not_after` window** (`terminate_cycle`, `terminate_cycle + 3`, `terminate_cycle = Arrival.terminate_octet_time frame / 8`) — WO-0040 §6, copied verbatim; cross-checked against `test/xgmii/arrival.ml`'s own definitions (`start_cycle f = f.start_octet_time / 8`; `terminate_octet_time f = f.start_octet_time + preamble_octets + Array.length f.octets`) which give `terminate_cycle = 10` at both lanes for a 64-octet frame at `frames_at`'s default `first_start` (8 or 12) — matching WO-0040 §5's stated figure exactly.
- **`account_clean_frame … ~aborted:false`** for a bad-FCS frame — WO-0040 §3.1, verbatim ("a bad-FCS frame is forwarded in full (§9 row 1), so its delivered extent is the ordinary clean-frame identity extent and `~aborted:false` is correct").
- **The `~fcs_valid:false` trap and the both-directions `residue_ok` guard** — WO-0040 §3.2, verbatim; implemented as `good_and_bad_64` (raises "test bug" on either direction failing, never an M03-named failure).
- **D3's four-schedule construction, the pair-A/pair-B kill argument, and which pulse belongs to which ordering** — WO-0040 §4's corrected table, copied verbatim into `run_mixed_pair`'s `good_first`/`bad_index` logic and `d3_ordering`'s two constructors.
- **D3's per-frame pulse-cycle formula (`bad_start_cycle + 10`) applied regardless of whether the bad frame is first or second in the schedule** — **my own extension of D1's formula, not verbatim from the packet** (WO-0040 §6 states the `start_cycle + 10` formula for D1's single-frame case only). I applied it unchanged to whichever frame is bad in a two-frame schedule, reasoning from REQ-004/§8's "zero rx backpressure, one 64-bit word/cycle" invariant and REQ-019's fixed ΔC = (L+h)/8: since the datapath has no internal buffering and a fixed per-octet delay, each frame's own output timing is a pure function of that frame's own input octet times, independent of a neighbouring frame's presence — which is also the premise WO-0040 §8 check 1's 10 000-frame back-to-back stress run already rests on. **Flagged as open question 1 below** for dv_lead to confirm or correct.
- **D3's pulse-to-frame attribution partition (`cycle ≤ tlast_cycle0` ⇒ frame 1's own)** — my own construction, not from the packet; reasoned in the code comment at `run_mixed_pair`'s `all_pulses` binding (frame 2's own cycles necessarily follow frame 1's `tlast` cycle even under the coincidence WO-0040 §4 works out, since only frame 2's *start* character, not its own `tlast`/pulse cycle, coincides with frame 1's `tlast` cycle).
- **D2's citation extent** — WO-0040 §2, copied verbatim (lengths and rows named, `M03-C4` and the sub-5-octet class excluded for the reasons given there).
- **D2's "must add" content** (D1's own frame clean at both lanes; D3's good member clean, both orderings) — WO-0040 §2, verbatim instruction; my choice to check D3's good member at **lane 0 only** (not lane 4, which the packet's D1 instruction explicitly asks for but the D3 instruction's wording — "asserted clean in both orderings" — does not) is a judgement call, flagged as open question 2 below.
- **D4's disposition** — AP-xgmii_rx_64.md row M03-D4 and WO-0040 §1's table, both verbatim; no stimulus exists to build against (Stimulus cell is "—"), so nothing is driven.
- **The age-0 non-dependency of family D** — WO-0040 §5, cited, not re-derived, per the task framing's explicit instruction.

#### 4. UNVERIFIED (could not check, ADR-0005)

- **Everything past parsing.** `ocamlc -stop-after parsing` was run on all three changed/new files (`bench.mli`, `bench.ml`, `test_m03_d.ml`) — exit 0 on each, verbatim in §5. This confirms only that the files tokenise and parse as valid OCaml structure/signature items; it performs no name resolution, no type-checking, and cannot see `Hardcaml_ethernet.Xgmii_rx_64`, `Dv_xgmii`, `Dv_monitors`, `Hardcaml` or `Cyclesim` at all.
- **`tools/precompile_check.sh` does not reach `test/xgmii_rx_64/` at all** — its own LANE 3a output classifies the directory `EXCLUDED — depends on hardcaml_ethernet, which this harness cannot transcribe` (its `STUBBABLE` set is `hardcaml hardcaml_axi ifc_check`, not `hardcaml_ethernet`), exactly as `test/xgmii_rx_64/dune`'s own header comment documents ("this directory is EXCLUDED from that harness by construction (WO-0038 §6 rule 2)"). So neither `bench.mli`, `bench.ml` nor `test_m03_d.ml` received ANY real type-check locally this round — the harness's green result (§5) is evidence only that the **unmodified** libraries my file calls into (`dv_xgmii`, `dv_monitors`) still compile as documented, which derisks but does not verify my usage of their signatures.
- **No simulation ran, no waveform was produced, nothing was eyeballed.** I therefore made no expect-test promotion — every `[%expect]` block in `test_m03_d.ml` is empty, per WO-0040 §8 rule 5, and none was harvested from any tool output (there was no tool output to harvest from). The charter's "never promote without eyeballing" obligation has no live instance in this round for that reason, not because I judge it satisfied by inspection.
- **Whether `dune runtest` is green, and whether the four `%expect_test`s pass against real `Xgmii_rx_64`.** Predicted PASS (§5), never confirmed.
- **Whether every field/function name and arity I used against `Dv_xgmii.Frame`, `Dv_xgmii.Arrival`, `Dv_monitors.Stream_word`, `Dv_monitors.Strobe_monitor`, `Dv_monitors.Conservation_monitor` and `Bench` itself is exactly right.** I cross-checked every call site by hand against the `.mli` files listed in the journal Inputs, and independently against `test/xgmii/arrival.ml`'s implementation for the cycle arithmetic, but a hand cross-check is not a compiler.

#### 5. Expected CI, checked vs predicted

Self-checks run this round, verbatim:

```
$ ocamlc -stop-after parsing test/xgmii_rx_64/bench.mli   → exit 0
$ ocamlc -stop-after parsing test/xgmii_rx_64/bench.ml    → exit 0
$ ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_d.ml → exit 0
```

```
$ bash tools/precompile_check.sh
… LANE 1 — RESULT: 31 units compiled, 0 errors
… LANE 2 — RESULT: 12 units compiled, 0 errors
… LANE 2b — ifc_check.ml fields agree (6/6); hardcaml.ml 6/6 found verbatim
    against /root/.opam/fpga/.opam-switch/sources/hardcaml/src; two
    UNVERIFIED-TRANSCRIPTION lines (Axi64.Source/Dest, base.ml), pre-existing
… LANE 3a — EXCLUDED xgmii_rx_64 — depends on hardcaml_ethernet, which this
    harness cannot transcribe   [my changed/new files are inside this
    excluded directory and were NOT type-checked by this run]
    RESULT: 43 files in compiled directories, all 43 materialised and compiled
… LANE 3b — RESULT: no unqualified sibling-library reference
… SUMMARY: precompile_check: ALL LANES PASSED
    2 transcription(s) remain UNVERIFIED here and are settled only by CI
```

```
$ bash tools/dv_checks.sh
… all three --self-test lanes: OK
… check_records_vs_appendix.sh: 23/23, OK
… check_emitted_verilog.sh: 5 checks, 0 failures, 3 PENDING (pre-existing,
    unrelated to M03: REQ-808/REQ-017/REQ-903 module-inventory gaps)
… precompile_check.sh: OK (as above)
… check_rfc1071_anchor.sh: OBLIGATION OPEN — blocked egress in this
    container (pre-existing, documented J-dv_lead-0017/0018, unrelated to
    this WO)
dv_checks: every check that COULD run passed, and 1 obligation is still
    OPEN … This run is a green light for the checks it ran and for nothing
    else.
```

**Predictions** (labelled as such, not facts): `dune build @default` and `dune runtest` succeed against the real toolchain; all four fifteen-plus-four `%expect_test`s in `test/xgmii_rx_64/` (the fifteen from WO-0038/WO-0039 plus this round's four) pass with empty output; `git diff --exit-code` stays clean after `dune runtest` (no unpromoted drift), because every `[%expect]` block here is empty by construction and none of the fifteen existing blocks was touched.

#### 6. Open questions

1. **D3's bad-frame pulse-cycle formula, extended to whichever frame is bad.** WO-0040 §6 states `start_cycle + 10` for D1's single-frame case. I applied the identical formula to the bad frame in each of D3's four schedules regardless of whether it is frame 1 or frame 2, reasoning from REQ-004/§8's zero-backpressure, fixed-ΔC invariant (see §3 above). If M03's actual output timing for the SECOND frame in a closely-spaced pair differs from this — e.g. if the coincidence WO-0040 §4 works out at the CRC register also perturbs the output pipeline's own word-emission cycle, not just the FCS verdict — my `Strobe_monitor.expect` pin would be wrong and the row would report a false CI finding against a conformant design. I believe this cannot happen under REQ-019's fixed ΔC and the §8 stress invariant, but I would rather you confirm this than have CI discover it.
2. **M03-D2's D3-partner check: lane 0 only, not both lanes.** WO-0040 §2 says "D3's good member asserted clean **in both orderings**" (no "both lanes" clause, unlike its D1-partner instruction, which does say "at both lanes"). I read the omission as deliberate — D3's own test already exercises both lanes for the full discriminating claim, so D2's redundant check need only satisfy the literal wording — and drove D2's D3-partner check at lane 0 only, both orderings. If you intended both lanes there too, it is a two-line addition to the `%expect_test`'s call list, not a redesign.
3. **`run_mixed_pair`/`assert_frame`/`split_at_first_tlast`/the two `mixed_pair_*` types are test-file-local to `test_m03_d.ml`, not exported via any `.mli`.** I read WO-0040 §3.3's "the one bench addition you are authorised to make" and "do not add anything else to `Bench`" as scoped to `Bench`'s own public surface (`bench.mli`), the same way `test_m03_c.ml`'s `length_outcome`/`outcome_line`/`run_c1_c2` or `test_m03_a.ml`'s `tuple_of_sample`/`assert_own_deltac` are ordinary per-file test machinery, not `Bench` additions. I am confident in this reading but flag it explicitly since it is the one place this round's diff is largest.
4. None of WO-0038's or WO-0039's carried-forward open questions are reopened; this round touches none of their subject matter.

#### 7. Scope statement

```
$ git status --porcelain
 M test/xgmii_rx_64/bench.ml
 M test/xgmii_rx_64/bench.mli
?? test/xgmii_rx_64/test_m03_d.ml

$ git diff --exit-code -- test/xgmii_rx_64/test_m03_a.ml \
    test/xgmii_rx_64/test_m03_b.ml test/xgmii_rx_64/test_m03_c.ml \
    test/xgmii_rx_64/test_m03_structural.ml test/xgmii_rx_64/dune \
    test/attack_plans/AP-xgmii_rx_64.md
exit: 0
```

No `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**` path was opened this round, at any point — targeted or swept; every `grep`/read this round was scoped to `test/`, `docs/specs/`, `agents/` and `tools/`.

`/root/.opam/**` reads: **one**, by `tools/precompile_check.sh` itself (LANE 2b, `hardcaml_source_dir` against `/root/.opam/fpga/.opam-switch/sources/hardcaml/src`, checking `hardcaml.ml`'s six transcribed signatures verbatim) — not a read I performed directly; it is the tool's own documented mechanism, reported in its output (§5). I did not open any `/root/.opam/**` path myself this round.

