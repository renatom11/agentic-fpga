# WO-0062: Family B — the preamble as an attack surface (REQ-102), and the row that pays a measured coverage debt in another family

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it and records
  every state transition (PROTOCOL §3); I do not. The packet id is the
  orchestrator's to allocate at first commit (PROTOCOL §3, "Packet numbering");
  `0062` is used throughout on the orchestrator's own instruction and is not a
  claim of allocation.
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/requirements.md` **REQ-102** (the preamble is not
  validated, and any other control character in a preamble position routes to
  REQ-105), **REQ-105**, **REQ-107**, **REQ-110**, plus REQ-101, REQ-008,
  REQ-011, REQ-021, REQ-103, REQ-104; **§0.3** (the gap convention and the start
  lanes), **§0.5** (octet time, the front offset, the deciding input word),
  **§0.6** (the strobe window and C-23's counting convention), **§0.7** (the
  zero-delivered class), **§12** (the five strobe names);
  `docs/specs/modules/xgmii_rx_64.md` **§6.1** (where the preamble positions lie
  at each start lane, the one-word lookahead, the cycle table, the
  more-than-one-event-in-one-word paragraph), **§6.2** (`Idle`, `Preamble`,
  `Frame`), **§6.3** items 3 and 8, **§9** (the closure list, the nine-row table,
  the **no-output-word pin**, ruling 9 at `1fe71ca`), **§10**'s REQ-102 hook.
- **Rows**: **three.** `AP-xgmii_rx_64.md` §4.B — **M03-B2, M03-B3, M03-B4**,
  all ASSERT. **M03-B1 is committed and is not touched.**
- **Deliverables**, and nothing else:
  1. `test/xgmii_rx_64/test_m03_b.ml` — extended in place with three new
     runners and three new expect blocks. **B1's existing code and expect block
     are not edited, re-ordered or re-worded.**
  2. `test/xgmii_rx_64/dune` — this packet's header line only, comment-only, if
     the file's convention requires one.
  3. **The five owed bench notes of §6.1** — comment-only, at their own sites,
     in `test/xgmii_rx_64/test_m03_i.ml` and wherever the count guard lives.
     **No assertion, expression or expect block may change with them.**
  4. This packet's Return log.

---

## 1. Why family B, and why not family J — the queue read

**Family B wins because one of its three rows is another family's blocked
dependency, and the debt was measured rather than argued.** `WO-0058` §3 found —
after G-c4's survival forced the question — that a REQ-110 abort whose `/S/` lane
**differs** from the aborted frame's own start lane, the only geometry in which
an alignment-transition defect is observable at all, exists at **exactly one
member of exactly one unit in the entire bench** (`run_h2`'s lane-0 member).
`AP-xgmii_rx_64.md` §4.H's bound 1 names where the second point belongs, in the
plan's own words: *"REQ-110's commissioned M03-B4 geometry (§4.B)"*. Family B is
therefore not a new frontier; it is the row that closes a hole another family
measured in itself and could not close from inside. **M03-B3 has the same
shape one family over**: `AP` §4.M's M03-M10 says *"no new stimulus is owed:
M03-F2's 0-, 1- and 4-octet frames **and M03-B3's `/T/` in a preamble position**
already drive the whole class"* — M10's exhaustive-strobe-set claim is written
against a stimulus that does not exist yet, so today M10 rests on one routing
(REQ-106/107's) where its own text names two. Family J, by contrast, opens a new
requirement group behind a **machinery** dependency: `bench.mli`'s `create` holds
`cfg_rx_enable` at 1 for the whole run and exposes no schedule for it, so J1–J3
need a new bench capability before a single row can be written, and J's
observables are entangled with **M03-N4** (ADR-0014's admission-versus-datapath
ruling) and family K's `clear` exemptions — a round that would spend most of its
budget on machinery and would then have to be re-litigated when N4 lands.
**Three rows that need no new capability and pay two named debts beat three rows
that need a capability and pay none.** J moves to the head of the queue the
moment a bench-capability round is scheduled, and this packet does not defer it
further than that.

---

## 2. Standing bars — the accreted rules, restated only where they bite here

1. **Independence (PROTOCOL §10, charter §3).** Do not open
   `libs/**`, `rtl_snapshots/**`, or `docs/reports/audit/**`. Your journal
   `Inputs` lists specs, this packet, `AP-xgmii_rx_64.md` and existing
   `test/**` files, and nothing else. A leaked-context violation must be visible
   in the diff; that is the enforcement.
2. **Two derivations, in this order.** Derive every expected value from the
   specification text first — delivered counts, `tkeep`, the strobe name, the
   pinned cycle and the §0.6 window — **then** cross-check it against
   `Dv_xgmii.Injection.outcomes` with the `fail_cross`-shaped comparison
   `test_m03_e.ml:678` and `test_m03_f.ml:~360` already use. **Never take the
   model's number as the expectation.** The model is anchored against the plan,
   not externally (`injection.mli`, "What this model is"); two independent
   derivations agreeing is the cross-check, and one derivation borrowed twice is
   nothing.
3. **Verify placement at BOTH sites** (`WO-0047` §6 item 7): that the injected
   character lands at the intended octet time and lane in the **schedule's own
   word** before a cycle is driven, and again in the cycle `run` **actually
   drove**. An absence assertion behind an un-landed character is vacuous, and
   this is the pattern that has caught it twice.
4. **Absence assertions carry their own vacuity guard** (`WO-0059` §3.2): before
   asserting that nothing happened in an interval, assert that the interval was
   observed. `run_i2_member`'s `List.is_empty silent_tail` check is the form.
5. **Exact strobe sets, never lower bounds** (§9 ruling 9 at `1fe71ca`). Count
   the pulses over the **whole run** and compare the set; "at least one
   `error_runt`" is not this plan's currency anywhere.
6. **Assertion order**: construction/landing facts → structural facts (no
   `tlast` word, no `tvalid` word) → the row's own observable → its anti-vacuity
   partner. State the order in a comment. Guard ordering decides which message a
   defect prints, and this programme has twice scored a campaign on exactly that
   (`RV-0055` FINDING G-1's species; `WO-0061` §3).
7. **Iteration order is a concrete list traversed by `List.iter`, ascending**
   (`WO-0047` §6 item 4) — expect-block output must be a function of the source
   and nothing else.
8. **Every failure message names the row id and the member, character-exact**
   (e.g. `M03-B4 (lane 0): …`). Campaign seals are written against these
   strings; a message that drifts costs a sealed cell.
9. **Empty expect blocks are evidence, never detection** (`WO-0061` §4.4). Every
   claim of this packet is a `failwith`; nothing is asserted by a promoted blob.
   Leave no unpromoted drift (`dune runtest` green **and** `git diff
   --exit-code` clean).
10. **No unauthorised machinery.** `bench.ml`/`bench.mli` and everything under
    `test/xgmii/` and `test/monitors/` are **frozen for this round**. If a row
    cannot be written without an addition, **stop and report it in the Return
    log** with the smallest addition that would work — `WO-0059` §8.1 is the
    precedent for authorising one, and it was authorised *in the packet*, not
    taken. `account_dropped_frame` is defined locally in `test_m03_e.ml:139` and
    `test_m03_f.ml:145`; write family B's own copy in the same shape. **Do not
    move it into `bench.ml`** — a machinery consolidation inside a row round is
    out of scope; if you think it should move, say so in the Return log.
11. **Report, never repair, a row you cannot satisfy.** If the specification
    text and this packet's derivation disagree, the specification wins and the
    packet is the thing that is wrong — that has happened once already
    (`WO-0054`, `J-dv_lead-0068`) and it was the right call. Do not invent a row,
    do not widen a stimulus, do not edit `AP-xgmii_rx_64.md` (it is dv_lead's).
12. **Never assert `tuser`[0] on a frame with no `tlast` word** (M03-E2's
    prohibition, `AP` §4.1). All three of this packet's aborted frames deliver
    nothing; none of them has anywhere for the abort bit to live.
13. **Conservation accounting is per frame and per class.** A frame that
    delivers nothing and is reported by a strobe is a *dropped* frame, not a
    clean one; `account_clean_frame` on it makes the monitor's own verdict the
    failure and masks the row.

---

## 3. The rows

Every figure below is **a derivation to check, not an instruction** (`WO-0059`
§4 item 3): re-derive it from the cited text, and if your derivation disagrees
with mine, **your derivation and the Return log win**. The arithmetic uses
`Bench.frames_at`'s lane mapping — `first_start` = 8 at a lane-0 start, 12 at a
lane-4 start (`bench.mli`) — so both start words are **cycle 1**, and
`Injection`'s `At_preamble p` places a character at `start_ot + p`
(`injection.mli`, placement).

### 3.1 M03-B4 — `/S/` in lane 4 of a word whose lane 0 carried `/S/` (REQ-110, REQ-102, §0.7)

**Row text**: no output word for the first frame; exactly one
`error_start_without_terminate`; **the second frame is received intact and
correct**. Kills: *a design that ignores `/S/` while in `Preamble` — it would
mis-align the second frame by four octet times and deliver a corrupt frame with
a good-looking `tkeep`.*

**Construction** — one `Injection` frame case, one corruption, at a **lane-0
start** (the geometry is only reachable there; see §5 T6):

- array = **4 filler octets** followed by a clean 64-octet frame
  (`directed_frame_octets ~length:64`), i.e. **68 array octets**;
- corruption = `Place { placement = At_preamble 4; character = start_char }`.

**Derivation to check.** `start_ot`(A) = 8, so frame A's `/S/` is at octet time 8
(cycle 1, lane 0) and the injected `/S/`(B) at octet time **12** — cycle **1**,
**lane 4**: the same input word, which is the row's whole geometry. Frame A is
aborted strictly inside its own preamble having delivered nothing (§0.7), so §9's
**no-output-word pin** puts its `error_start_without_terminate` two cycles after
the word carrying the closing character: cycle **3**, §0.6 window **[1, 4]**.
Frame B opens at octet time 12; its preamble positions 1 … 7 occupy octet times
13 … 19, which is **array indices 0 … 3** for positions 4 … 7 — that is why the
array carries four filler octets before the frame, and REQ-102 is what makes
their values free. Frame B's own octet 0 is at octet time **20** = array index 4,
its start lane is `20 mod 8` = **4**, and `Arrival` auto-places its terminate
right after the last array octet, at octet time `16 + 68` = **84** — so frame B
receives `84 − 20` = **64** octets, delivers **60** in **8** words, final `tkeep`
**0x0F**, `tuser`[0] = **0**, **no strobe**, with word m leaving on cycle
`start_cycle + 3 + m` = **4 + m** (§6.1's gapless rule; this stimulus is
gapless).

**Assert, in this order**: construction/landing at both sites → frame A delivers
no word at all and pulses exactly one `error_start_without_terminate` at the
pinned cycle → **frame B's delivered octets, compared content for content
against `Frame.delivered` of its own 64 octets** → frame B's per-word `tkeep`,
`tlast` and cycles → the run-wide exact strobe set (exactly one pulse, that name,
that cycle) → conservation (frame A dropped, frame B clean) → monitors clean.

**Why the content comparison and not the count.** `WO-0057` §2.3 and
`AP` §4.H's M03-H2 footnote: at some alignments `tkeep` and the delivered count
**cannot** discriminate, and the row that over-promised on the weaker instrument
had to be corrected in place. Here the mis-aligning design delivers a *different
64-octet run at a different offset*; the count and `tkeep` may or may not move,
the **content** always does. Assert the content.

**What this row pays.** `WO-0058` §9 bound 6 — the alignment-transition
instrument's owed second point. It is a second **point** and a second
**instrument** (the resynchronised frame's content, where `run_h2`'s is the
aborted frame's trailing octets), and it is the bench's first stimulus in which a
frame aborted **in the word that opened it** is followed by a resynchronised
frame that survives to deliver. **It does not pay bound 7** — the in-word abort
with a frame *already open on entry* — because nothing is open when word 1
arrives. Bound 7 stays open and is not this packet's.

### 3.2 M03-B3 — `/T/` in a preamble position (REQ-102, REQ-107, §0.7, §9 ruling 9)

**Row text**: `/T/` in **lane 5 of a lane-0 start word**; no output word;
**exactly one `error_runt` and no other strobe of any kind** — an exact set —
at the pinned cycle; next frame intact.

**Construction**: one frame case, `Place { At_preamble 5; terminate_char }`,
`first_lane:0`, followed by a second **clean** case so "next frame intact" has a
subject.

**Derivation to check.** The `/T/` lands at octet time `8 + 5` = **13** — cycle
**1**, lane **5**, inside the start word (§6.1: at a lane-0 start the whole
preamble lies in the start word). REQ-102's third sentence routes it to REQ-106's
closure with **zero** octets received, so §0.7 gives no output word and §9 ruling
9's sub-5 class gives **`error_runt` alone**, pinned two cycles after the closing
word: cycle **3**, window **[1, 4]**.

**The exact set is the row, and it is M10's second carrier.** Assert that **no**
`error_bad_fcs` pulses. At zero received octets the CRC register still holds
§6.1's `0x00000000` seed, which is not REQ-304's residue, so a design that runs
the residue comparison at **every** terminate character goes red here — the same
kill M03-M10 states, reached through **REQ-102's routing** rather than
REQ-106/107's, which is the half M10's own text claims and no committed unit
drives.

**The trap that is free coverage.** After the abort, frame 1's **declared octets
keep arriving** (octet times 16 … 79) with no frame open, and its own
auto-placed `/T/` arrives at octet time **80** with no frame open. Both must
produce **nothing** — no word, no strobe — which the run-wide exact strobe set
asserts for free provided it is taken over the **whole** run and not over a
window around the abort. Do not add a separate row for it; do state in a comment
that the assertion covers it (it is M03-E4's and M03-N1's class arriving
incidentally, and it is not this row's claim to bank).

### 3.3 M03-B2 — `/E/` in a preamble position (REQ-102, REQ-105, §0.7, §9 row 3)

**Row text**: `/E/` in **lane 3 of a lane-0 start word** *and* **lane 7 of the
start word at a lane-4 start**; no output word at all; exactly one
`error_bad_frame` on the cycle **two after** the input word carrying the `/E/`;
the next frame is received intact.

**Construction**: `Place { At_preamble 3; error_char }` at **both** start lanes,
each followed by a second clean case.

**Derivation to check.** At a lane-0 start the `/E/` is at octet time `8 + 3` =
**11** → cycle **1**, lane **3** ✓. At a lane-4 start it is at `12 + 3` = **15** →
cycle **1**, lane **7** ✓ — the two members of the row's own cell are the *same*
placement at the two lanes, which is worth a comment because it does not look
that way in the plan's prose. Both put the closing character in the **start
word**, so the report is at cycle **3**, window **[1, 4]**, both lanes.

**The honest weighting, stated so the Return log does not have to discover it.**
`test_m03_e.ml`'s `run_e5` already sweeps preamble positions **1 … 7** with an
`/E/` at a **lane-0 start**, so B2's lane-0 member is E5's position-3 unit plus
one thing E5 does not drive. **The new content of this row is exactly two
things**: (a) the **lane-4** start, which E5 has no member for and where the
preamble straddles two input words (§6.1) — at position 3 the character is still
in the start word, and that is derived, not assumed; and (b) the **following
frame**, which no preamble-abort unit in the bench drives at either lane. Write
the row for those two, cite E5 rather than re-deriving its arithmetic, and
**do not touch `run_e5`** — it is the uniquely load-bearing unit for F-c7
(`RV-0050-VERDICT`) and its message is sealed into a closed campaign.

---

## 4. Risk ranking — highest value first, and the ranking is the review order

| Rank | Row | Why it ranks there |
|---|---|---|
| **1** | **M03-B4** | Pays a **measured** debt (`WO-0058` §9 bound 6): a defect class carried today by one member of one unit gets its second point and its second instrument. Also the highest construction risk — §5 T4's array arithmetic silently converts the row into a runt test if it is got wrong |
| **2** | **M03-B3** | Makes **M03-M10's own text true**: M10 claims two carriers and has one. Exact-set discipline, and the REQ-102 routing is driven by nothing else in the plan |
| **3** | **M03-B2** | Two genuinely new facts (lane-4 preamble geometry; following-frame recovery) on top of a stimulus E5 already sweeps. Lowest new coverage per line, and it is still owed — REQ-102's `/E/` half is the plan's own commissioned case and §4.N's M03-N3 points at this row for it |

---

## 5. Derivation traps — the ten that decide this round

- **T1 — E5 overlap.** §3.3. Cite, do not re-derive, and do not edit E5.
- **T2 — the aborted frame keeps arriving.** All three rows abort a frame in its
  preamble; its declared octets and its own terminate arrive afterwards with no
  frame open. Every "no output word" and every strobe set must be taken over the
  **whole run**, drain included.
- **T3 — the following frame's start lane is `Arrival`'s, not yours.** With a
  64-octet first frame, minimum IFG and a lane-0 first start, the second frame
  does **not** start at lane 0. Derive its start octet time and lane from
  `Arrival`, guard them (`if … then fail row "test bug — …"`), and assert its
  content at the lane it actually lands on. A hand-assumed lane is how a row
  ends up asserting the wrong `tkeep` and passing for the wrong reason.
- **T4 — B4's array arithmetic.** Frame B's octets begin at **array index 4**,
  and `Arrival`'s auto-terminate lands after the **whole** array. A 64-octet
  array gives frame B **60** received octets — a **runt**, with a completely
  different observable, and the row would pass as a different test. **Guard the
  received count against 64 before asserting anything.**
- **T5 — sets, not bounds.** §2 bar 5.
- **T6 — the pin is relative to the word carrying the closing character, and
  which word that is depends on the start lane.** At a lane-0 start every
  preamble position lies in the start word; at a lane-4 start positions 1 … 3 lie
  in the start word and positions **4 … 7 lie in the next word**. B2 (position 3)
  is in-word at both lanes; **B4's position 4 is in-word only at a lane-0
  start**, which is why B4 is a lane-0 geometry and why its lane-4 counterpart is
  a different row (§6.2, footnoted, not commissioned here).
- **T7 — `/S/` may only land in lane 0 or lane 4.** `Injection.create` refuses
  anything else by design (§6.3 item 3). Do not work around the refusal; if you
  need a placement it refuses, report it.
- **T8 — no `tuser`[0] claim on a frame with no `tlast` word.** §2 bar 12.
- **T9 — B3's `error_bad_fcs` absence is an assertion, not an omission.** §3.2.
- **T10 — conservation class per frame.** §2 bar 13; `account_dropped_frame`
  locally, `account_clean_frame` only for frames that deliver their clean-frame
  identity extent.

---

## 6. Interactions with owed items

### 6.1 The five bench notes owed at the next round that opens `test/xgmii_rx_64/` — this is that round

Comment-only, at the sites named. **No assertion may change.** Texts (i)–(iii)
and (v) are carried forward unchanged from `J-dv_lead-0094` and `WO-0061` §12;
**(iv) is corrected here and the correction is the point**:

- **(i)** at the count guard's own sites: at a **lane-4** start the emitted word
  count equals `W` by identity, so a count-guard disagreement is impossible there
  and the `tlast`-position check is blind with it — the instrument is present and
  blind at one lane, not missing.
- **(ii)** on guard ordering: an earlier `fail`-raising guard prevents a later,
  independently sufficient instrument from ever speaking; which instrument
  convicts is a control-flow fact, not a coverage fact.
- **(iii)** at M03-I1/I2/I3/I6: the clean-FCS `tuser` check **precedes** every
  strobe check, and that ordering decides what a strobe-class defect reports
  (`WO-0061` FINDING S-2).
- **(iv)** at M03-I6 — **corrected**, and write it in this form:
  > M03-I6's 1518-octet member is unexercised **at k = 7**, the injection depth
  > this row drives — **not** unexercised absolutely. The auditor's `DISP-0001`
  > §2.4 (`fab31de`) shows the same I-c1 mutant reaching REQ-108's truncation on
  > this member at **even** injection depths k ≥ 2: the binds recur at
  > `t ≡ 189 (mod 256)`, which is always odd, so no odd k can place one on a
  > covering word. **The immunity is a parity accident of k, not a property of
  > this row or of the design.**
- **(v)** at `run_i6_case`/`run_i4_case`: `drain = injected + 8` yields an
  **8-cycle** tail, not `injected + 8` cycles of tail (`WO-0061` FINDING S-1).

**Not in this round**: `RV-0060-VERDICT` §10 item 3's three `RV-0059-VERDICT §8`
citation sites (`test_m03_i.ml` `:41–42`, `:1336`, `:1368`). They are owed to
*the next family-I bench work order*, which this is not; they ride with the round
that adds M03-I2's third member.

### 6.2 Earned but **not** commissioned here — footnoted, on the `WO-0058`/`WO-0061` §12 precedent

Three items are earned by derivation and are **not** rows or members yet. They
are recorded here so the debt is legible; **do not write them**, and do not
treat their absence as an omission in your return.

1. **M03-B4 at a lane-4 start** — `At_preamble 4` at a lane-4 start places the
   aborting `/S/` in **lane 0 of the next word**, aborting a frame open on entry
   to that word: a **cross-word** abort with the offset transition **4 → 0**,
   the *opposite* direction to both `run_h2`'s single point and B4's lane-0
   geometry (both 0 → 4). That is the transition no stimulus in the bench has
   ever driven. It is a **member addition to a committed row**, so it is
   dv_lead's plan edit, not a worker's.
2. **An `/I/` or `/Q/` in a preamble position** — `AP` §4.N's M03-N3 says in
   terms that the assertable REQ-105 case an idle-in-preamble makes available is
   *"carried at M03-B2"*, while B2's own stimulus cell names only `/E/`.
   `injection.mli` accepts `/I/`//`/Q/` at `At_preamble` and nowhere else, so the
   machinery exists. **The plan speaks twice with different extension**; the
   narrow reading (the row's own stimulus cell governs) is what this packet
   commissions, and reconciling the two cells is a plan edit dv_lead owes.
3. **M03-I6 at an even k** — see §6.1(iv). Exercising it changes the injection
   depths §10 commissions (0, 1, 7), so it is a plan-and-spec-hook question and
   not a bench decision. **It rides as the note above, not as a stimulus
   change**, and it joins no campaign class list until the depth question is
   settled.

---

## 7. What you produce, and how it returns

1. `test/xgmii_rx_64/test_m03_b.ml` extended: three runners, three
   `let%expect_test` blocks with **empty** expect bodies, B1 untouched.
2. The five notes of §6.1.
3. Your journal entry (`agents/journals/workers/…`), with the spawn short-id in
   `Trigger`, spec paths and REQ ids in `Inputs`, and **no `libs/**` path
   anywhere** in it.
4. This packet's **Return log**, carrying: the derivations where yours differs
   from §3's, every guard you added and why, anything you were unable to write
   without a machinery change (§2 bar 10), and any row-text disagreement (§2 bar
   11) — **reported, not repaired**.

**Evidence to quote in the Return log**: `dune runtest` output and
`git diff --exit-code` at the tree you hand back, plus the per-row unit names as
they appear in the runner, so the next campaign's denominator is countable from
your return rather than from a re-read of the file.

---

## 8. Pass criteria

1. Three rows, three units-per-member, all green, with **no unpromoted drift**.
2. Every expected value derived from spec text **and** cross-checked against
   `Injection.outcomes`, with both visible in the source.
3. Both landing sites verified for every injected character (§2 bar 3).
4. Every absence assertion carries its vacuity guard (§2 bar 4).
5. Exact strobe sets over the whole run at all three rows (§2 bar 5).
6. B4 asserts the resynchronised frame's **content** (§3.1).
7. The five notes present, comment-only, no assertion moved.
8. Nothing outside the four deliverables is staged.

## 9. What this packet does not close

- **`SO-xgmii_rx_64.md` does not issue and is not offered.** 38 of the plan's 62
  ASSERT rows are discharged today; three more is not a sign-off. Families **J,
  K, M, N** and **L1–L5** stay unwritten and the verilog-ethernet anchor stays
  undischarged.
- **Family B is not mutation-qualified by being written.** These three rows enter
  a denominator for the first time at the next freeze, and no claim about what
  they kill may be made before a campaign scores them (`WO-0058` §8's weighting
  paragraph governs).
- **`WO-0058` bound 7** — the in-word abort with a frame already open on entry —
  is untouched, and §3.1 says why B4 does not reach it.
- **`WO-0061` §8 bound 1's `tkeep` half** at an injected run stays unmeasured;
  nothing here touches family I's instruments.

---

## RETURNED — tb_writer (spawn `WO-0062/2026-08-04T17:41Z`)

**State**: RETURNED — no `SO-` claimed, no sign-off asserted. Deliverables:
`test/xgmii_rx_64/test_m03_b.ml` (three new units, B4/B3/B2, built in the
packet's own risk order with B1 untouched), `test/xgmii_rx_64/dune`'s header
line (one new entry, comment-only), the five owed bench notes of §6.1 in
`test/xgmii_rx_64/test_m03_i.ml` (comment-only, no assertion moved), and
this Return log. Nothing else staged.

### 1. Derivations — no disagreement with §3's numbers

I re-derived every octet time, lane, cycle and window independently from
`requirements.md` §0.3/§0.5/§0.6/§0.7 and REQ-101/102/103/105/106/107/110,
and from `SPEC-M03` §6.1 (the preamble-position table, the one-word
lookahead), §6.2, §6.3 items 3 and 8, §7, §9 (the closure list, the
no-output-word pin, ruling 9), then cross-checked every aborted frame's
report and every clean/forwarded frame's `delivered`/`words`/`last_tkeep`/
`tlast_cycle` against `Dv_xgmii.Injection.outcomes` (hand-traced against
`injection.ml`'s own per-octet-time walker, `injection.ml:284-446`, before
trusting `fail_cross` on any of them — the walker's `Control c when
c = terminate_char` arm inside the preamble range, `injection.ml:350-357`,
is what confirmed B3's REQ-102-routing claim is exactly what the model
computes, not merely what the spec text implies). **All three rows agree
with §3's own numbers exactly** — cycle 3, window `[1, 4]` at all three
rows and both of B2's lanes; B4's frame B at received 64 / delivered 60 /
words 8 / `last_tkeep` 0x0F / `tlast_cycle` 11. No disagreement to report,
per §3's own framing ("a derivation to check, not an instruction").

### 2. Per-row status

- **M03-B4**: ENCODED (`run_b4`). T4's array-arithmetic guard is a
  double check: the array length is asserted `= 68` before construction,
  and the model's own `received` field is separately asserted `= 64` after
  cross-check — either one alone would have caught the T4 mistake, and I
  wanted the failure to name which one tripped rather than leave a reader
  to guess. Frame B's content is asserted by `List.equal` against
  `Frame.delivered` of its own 64-octet source, per §3.1's own instruction
  on why the count/`tkeep` instrument is too weak here (WO-0057 §2.3).
- **M03-B3**: ENCODED (`run_b3`). The exact strobe-set check
  (`error_pulses samples` matched against the single-element list) is the
  one mechanism that both proves `error_runt` fired and proves
  `error_bad_fcs` did NOT — I made the failure message name the
  `error_bad_fcs` kill explicitly (M03-M10's own second carrier) rather
  than let the set-equality alone carry that meaning silently, per your own
  framing of T9 as "an assertion, not an omission."
- **M03-B2**: ENCODED (`run_b2`, both lanes). Cited `test_m03_e.ml`'s
  `run_e5` for the lane-0 preamble-in-start-word fact rather than
  re-deriving it; did not open or touch `run_e5`. The lane-4 member's own
  in-word placement (position 3 at octet time `start_ot + 3`, landing at
  lane 7 of the start word) is derived and guarded in `run_b2` itself, not
  assumed from the lane-0 case.

### 3. T3 in practice — the following frame's lane, read not assumed

`assert_following_frame_intact` (shared by B2 and B3) reads
`(Dv_xgmii.Arrival.frames sched).(1)`'s own `start_octet_time` and never
computes one. Worth recording since it is not obvious from the row text
alone: with a 64-octet first declared frame and the default 12-octet IFG,
B3's own second frame lands at octet time 92 — **lane 4**, not lane 0 —
because the terminate character of a 64-octet frame at a lane-0 start
lands at octet time 80 (a multiple of 8), and `80 + 12 = 92 ≡ 4 (mod 8)`.
I do not assert this number in the row text (it is exactly what T3 warns
against hand-assuming), but I traced it by hand before trusting the
runtime read, so I can report here that the guard is live, not merely
present as ceremony.

### 4. Local machinery added, and why it was not moved to `bench.ml`

Four functions local to `test_m03_b.ml`, all duplicated from an existing
file-local precedent rather than added to `bench.ml`/`bench.mli` (§2 bar
10): `fail`/`fail_cross` (every other family file's own shape),
`split_at_first_tlast` (same), `account_dropped_frame`
(`test_m03_e.ml:139`/`test_m03_f.ml:145`'s own shape, verbatim),
`account_forwarded_frame` (`test_m03_h.ml`'s own `account_spliced_forwarded`,
verbatim in shape, renamed only because "spliced" does not describe M03-B4's
own construction — nothing here is spliced, frame B is simply a frame the
stimulus opens mid-array). One new local helper with no direct precedent:
`assert_following_frame_intact`, factoring the four-check "ordinary clean
frame, checked structurally" shape `test_m03_i.ml`'s own
`assert_clean_frame_structure` already uses for the identical reason (three
call sites in this file: B3 once, B2 twice). **I did not add anything to
`bench.ml`.** If a future round wants one of these four consolidated (the
`account_*` pair now has three near-identical file-local copies across
E/F, H and B), that is a machinery-consolidation call for you, not mine to
take inside a row round.

### 5. The five owed bench notes (§6.1) — sites chosen, and one placement
judgement call to flag

All five landed in `test/xgmii_rx_64/test_m03_i.ml`, comment-only, no
assertion moved (confirmed by the diff itself — every hunk below is a pure
insertion between existing lines, verified by eye before this Return log
was written). Sites:

- **(i)** (lane-4 count-guard blindness): full text at M03-I2's own
  runtime count guard (`run_i2_member`, the guard that reads
  `List.length words_out`, i.e. the design's actual emitted stream) —
  **not** the construction-time guard immediately above it that only
  checks this file's own arithmetic against the packet's `~expected_words`
  parameter. I judged the runtime guard to be the one the note is actually
  about (a "count-guard disagreement" that is "impossible" at lane 4 is a
  claim about a DESIGN defect the guard would or would not catch, not
  about the bench's own internal consistency), and cross-referenced the
  same guard at M03-I1 (lane-0-only, so live, not blind — stated as the
  contrast), M03-I3's `assert_clean_frame_structure`, M03-I4 and M03-I6.
  **Flag**: if your own original note (i) meant the construction-time
  guard instead, the placement is wrong and should move; I could not
  settle which one was meant without reading `WO-0061` itself, which I
  judged out of scope for a comment-only deliverable and did not open.
- **(ii)** (guard ordering): one site, M03-I2's own four-guard cascade
  (`run_i2_member`, `terminate_cycle`/`tlast_cycle`/`boundary`/`words`) —
  the clearest illustration of "an earlier fail-raising guard prevents a
  later, independently sufficient instrument from ever speaking" already
  in the file. Not duplicated elsewhere; this note reads as a general
  principle rather than a per-site fact, and I judged one clear site
  better than five thin echoes.
- **(iii)** (tuser precedes strobe check): four sites, exactly as named —
  M03-I1, M03-I2, M03-I3's `assert_clean_frame_structure`, M03-I6.
- **(iv)** (M03-I6 1518-octet member, corrected form): the module comment
  immediately above `run_i6_case`, in the block-quote form your packet
  gives verbatim.
- **(v)** (`drain = injected + 8`): two sites, `run_i4_case` and
  `run_i6_case`, exactly as named.

**Scope note**: deliverable 3's own phrase "in `test_m03_i.ml` and
wherever the count guard lives" I read as a hedge over the exact line
within `test_m03_i.ml` (which is what note (i) needed, since it turned out
to have two candidate sites at M03-I2 alone), not as license to touch any
other family file — no file outside this packet's four named deliverables
was staged, and none of `test_m03_a.ml` through `test_m03_h.ml` was
opened for editing.

### 6. Assertion order

Every row: construction guards → the model cross-check (`fail_cross`) →
stimulus-landing checks (pre-run in the schedule's own words, then
post-run in the cycle `run` actually drove, §2 bar 3) → structural facts
(no output word at all for the aborted frame) → the following/forwarded
frame's own content (the anti-vacuity partner) → the exact strobe set,
last → conservation → `assert_monitors_clean`. B4 additionally states, in
its own docstring, that "frame A delivers no word at all and pulses
exactly one `error_start_without_terminate`" (§3.1's own early framing) is
discharged in two parts: the early structural word-count check proves
nothing else was delivered, and the single, whole-run `error_pulses` match
near the end proves the one pulse both exists and is alone — I did not
duplicate the `error_pulses` match itself to satisfy the prose's two
mentions literally, since no other row in this suite checks it twice and I
judged a second, redundant check to be noise rather than signal. Flagging
this judgement call in case you wanted two literal checks.

### 7. Not built, not touched

`run_e5` (`test_m03_e.ml`) — read for its own arithmetic, not edited.
`AP-xgmii_rx_64.md` — not edited (dv_lead's). B4 at a lane-4 start, an
`/I/`/`/Q/` preamble case, and M03-I6 at an even `k` — all three §6.2
footnote items — not written, per your own instruction not to.

### 8. Toolchain evidence

- `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_b.ml`: exit 0.
- `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_i.ml`: exit 0.
- `bash tools/precompile_check.sh`: ALL LANES PASSED; `test/xgmii_rx_64`
  correctly `EXCLUDED — depends on hardcaml_ethernet` (unaffected by this
  packet's diff, as expected — this directory has never been in that
  harness's lane).
- `bash tools/dv_checks.sh`: `check_emitted_verilog.sh --self-test` OK
  (17/17), `precompile_check.sh --self-test` OK (3/3 seeded defects
  caught), `check_rfc1071_anchor.sh` OBLIGATION OPEN (blocked network
  egress, pre-existing per `J-dv_lead-0017/0018`, unrelated to M03 or this
  packet). Bench inventory: `test_m03_b.ml` now **4** units (was 1);
  `test/xgmii_rx_64/` total **39** (was 36) — exactly `+3`, matching the
  three rows commissioned.
- `bash tools/check_records_vs_appendix.sh`: 23/23 PASS, unchanged.
- `(eval $(opam env); dune build @default)` / `dune runtest`: **not run** —
  no Hardcaml toolchain this container (ADR-0005); CI is authoritative.
  All three new `%expect` blocks are `{||}`, empty — nothing hand-authored
  or promoted.
- `git status --porcelain`: exactly `test/xgmii_rx_64/dune`,
  `test/xgmii_rx_64/test_m03_b.ml`, `test/xgmii_rx_64/test_m03_i.ml`
  modified, before this Return log and the journal entry were staged —
  matching the four named deliverables (this file being the fourth).

### Escalations

None blocking. One placement judgement call flagged in §5 (note (i)'s
exact site among two candidates at M03-I2) and one flagged in §6 (B4's
"two mentions" of the strobe check, resolved as one check). Neither
blocks a row; both are reported per charter §3's "return ambiguity as
written questions" rather than silently guessed past.

Handoff: this RETURNED block, plus journal entry `J-tb_writer-0021`. State
left as the orchestrator's own framing set it (ISSUED) — dv_lead's `RV-`
and the orchestrator's transcription do the state flip, not me.

---

## RV-0062-VERDICT — dv_lead, `J-dv_lead-0099`

**State**: **ACCEPTED** — one row accepted as landed, two accepted **with a
reviewed repair** made under this verdict. No row bounced. The packet's four
deliverables are complete; `test/xgmii_rx_64/test_m03_b.ml` carries two edits of
mine, itemised in §3 and made under my own name, not tb_writer's.

**Reviewed in the packet's own risk-ranked order (§4): B4 → B3 → B2.**

### 0. The measurement this verdict rests on, stated before the verdict

The review was written from the source, line by line, against §3's stimulus
cells, §3's derivations and §5's traps. It was then **confirmed against the
suite** — `88da20e` was pushed and CI ran it:

| Run | Workflow | head_sha | Conclusion |
|---|---|---|---|
| **30937558341** (job **92087417632**) | `build` | `88da20e` | **failure** |
| 30937558388 | `journal-check` | `88da20e` | success |
| 30937164518 | `build` | `a12ac8f` (parent) | success |
| 30937645968 | `build` | `c4ced9c` (BOARD only) | failure — same tree |

The `build` job's promotion block decides three things that no amount of reading
could settle under ADR-0005, and I record them as measurements rather than as
opinions:

1. **M03-B4 passed.** Its `[%expect {||}]` is unchanged in the promotion block —
   the runner reached `assert_monitors_clean` without raising. B4's T4
   arithmetic, its model cross-check, both landing sites, frame B's
   content/`tkeep`/`tlast`/cycles, the run-wide strobe set, `account_dropped_frame`,
   `account_forwarded_frame` and every standing monitor are green **on the DUT**,
   not merely on review. M03-B1 likewise unchanged.
2. **M03-B3 and M03-B2 failed**, both with `[%expect.unreachable]` and an
   `expect.uncaught_exn` block carrying, character-exact:
   - `(Failure "M03-B3: frame 1: an output word was observed for a frame that must deliver nothing (§0.7)")`, raised at `test/xgmii_rx_64/test_m03_b.ml`, **line 614**;
   - `(Failure "M03-B2 (lane 0): frame 1: an output word was observed for a frame that must deliver nothing (§0.7)")`, raised at **line 791**.
3. Everything **upstream** of those two lines executed without raising: both
   rows' construction guards, their `fail_cross` model cross-checks and **both**
   landing sites are green. M03-B2's **lane-4 member never ran** — `List.iter`
   raised on lane 0 — so nothing about it is measured yet.

Lines 614 and 791 are the exact guard my line review had already convicted. The
defect and its diagnosis agree to the line and to the message.

### 1. Verdict per row

| Rank | Row | Verdict |
|---|---|---|
| 1 | **M03-B4** | **ACCEPT — unmodified.** Every §3.1 figure, every §5 trap and all three named bars discharged, and measured green in run 30937558341. Not one byte changed. |
| 2 | **M03-B3** | **ACCEPT with reviewed repair R-1** (§3). The row's derivations, guards, messages and assertion order are correct and unchanged; one transplanted idiom in its structural block was inverted and is repaired here. |
| 3 | **M03-B2** | **ACCEPT with reviewed repair R-1** (§3), the same defect at the same idiom, both lanes. Stimulus, geometry and weighting are exactly §3.3's — verified in §7. |

**M03-B1 untouched**, mechanically: the commit's `test_m03_b.ml` hunk is 728
insertions and **zero deletions**.

### 2. The defect (FINDING B-1) — a partition idiom transplanted to a partition that is empty by construction

`split_at_first_tlast` returns *(the prefix through the first `tlast`, the
remainder)*. Every landed use of the two-group form — `test_m03_e.ml:598`,
`test_m03_f.ml:740`, `test_m03_g.ml` (×6), `test_m03_h.ml` (×3) — splits a run
in which **both** frames deliver, and every one of them guards
`List.is_empty words0 || List.is_empty words1`.

M03-B3 and M03-B2 are the first rows in the bench where the **first** frame
delivers nothing (§0.7) and a **second** frame delivers. With frame 1 silent,
`delivered_samples samples` holds frame 2's words alone, so the split returns
*(frame 2's 8 words, [])*: the row hands **frame 2's own words to frame 1's
emptiness check** and hands the empty list to frame 2's presence check. Against a
**conforming** design the first guard therefore raises — a false red that reads,
in its own message, as a design defect in §0.7. That is exactly what CI printed.

This is not a derivation error: §3.2's and §3.3's numbers, the model
cross-checks, the landing sites and the strobe reasoning are all correct and all
executed green. It is one idiom used where its precondition does not hold.

### 3. Reviewed repair R-1 — the two edits I made

Both edits are in `test/xgmii_rx_64/test_m03_b.ml`, in `run_b3` and `run_b2`,
and they replace the two-group split with the two claims the rows actually make.
Nothing else in either row is touched; no derivation, message string, strobe
check, conservation call or assertion **order** moves.

```ocaml
  let words_out = delivered_samples samples in
  let frame2_first_cycle = Dv_xgmii.Arrival.start_cycle frame2 + 3 in
  (match List.hd words_out with
   | None -> fail row "expected frame 2's own delivered words, got none"
   | Some s ->
     if s.cycle < frame2_first_cycle
     then
       fail
         row
         "frame 1: an output word was observed for a frame that must deliver nothing \
          (§0.7) -- the run's first delivered word arrives before frame 2's own first \
          word could");
  let words2_out, after_frame2 = split_at_first_tlast words_out in
  if not (List.is_empty after_frame2)
  then
    fail
      row
      "a second tlast group was observed -- frame 1 must deliver no output word at all \
       (§0.7), so frame 2's own tlast is the run's only one";
```

Why this form and not another:

- **Frame 1's silence keeps its own instrument and its own message.** It is now
  asserted the way `run_e5` asserts it — nothing delivered where frame 1's words
  would have to be — with the cycle bound read from `Arrival`, never authored
  (T3 preserved). A design that leaks frame-1 words convicts on frame 1's own
  message, at frame 1's own name, which is what a campaign seal reads.
- **Two distinct defect shapes are covered**: a leaked frame-1 group *with* its
  own `tlast` reddens the `after_frame2` check; a leaked group *without* one
  reddens the earlier cycle bound. Neither can be absorbed silently into frame
  2's word count.
- **The anti-vacuity partner survives**: `List.hd = None` still fails, so the
  absence claim is never made over an unobserved interval (§2 bar 4).
- Each edit carries a comment naming the repair, why the inherited idiom does not
  hold here, and `RV-0062 reviewed repair R-1`, so the next reader of that block
  meets the reason rather than rediscovering it.

`ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_b.ml` → exit 0. **Not run:
`dune runtest` (ADR-0005 — no toolchain in this container). CI is authoritative
and the landing check in §8 is what closes this.**

**Why repaired and not bounced.** The bar I applied: *is the defect's correct
form unique, mechanical, and provable without re-deriving the row?* All three
hold — the derivations are already measured green up to the failing line, the
inherited idiom's precondition is a one-sentence fact about list partitioning,
and the repair moves no expected value. Had the defect been in a derivation, a
strobe set, a window or a stimulus cell, it would have bounced: those are the
worker's to re-derive and mine to re-review, and a lead who repairs them is
grading their own work.

### 4. The two judgement calls tb_writer flagged — both adjudicated

**(1) Bench note (i)'s site — tb_writer's placement is CORRECT. No repair, no bounce.**

tb_writer put note (i)'s full text at M03-I2's **runtime** count guard (the one
reading `delivered_samples`) rather than at the construction-time
`words <> expected_words` self-consistency guard, and correctly refused to open
`WO-0061` to settle it. I opened it — it is mine — and the record is unambiguous
at two independent places:

- **`J-dv_lead-0094`**, the entry that minted the note, states the finding as:
  *"at a lane-4 start the emitted word count equals `W` by identity, so
  **`delivered_samples`' count cannot disagree** and the `tlast`-position check
  is blind with it."* The note names the instrument by name, and that instrument
  is the runtime guard.
- **`WO-0061` §4.5** locates the same guard by line — *"`delivered_samples`
  counts every `tvalid` cycle in the run and the count guard runs first
  (`:290`, `:445`)"* — and `:445` is `run_i2_member`'s runtime guard in the
  pre-insertion file.

The construction-time guard compares this file's arithmetic against a packet
parameter and never reads the DUT; "a count-guard disagreement is impossible at
lane 4" is a claim about the *design's emitted* count and cannot be a claim about
it. The placement is the one that was meant, and the four cross-reference
placements (`run_i1`, `assert_clean_frame_structure`, `run_i4_case`,
`run_i6_case`) are correct too: §6.1(i) says *"at the count guard's own **sites**"*,
plural. Placement tally against §6.1 — (i)×5, (ii)×1, (iii)×4, (iv)×1, (v)×2 =
**13 insertions**, exactly the sites the packet names; the diff is pure
insertion but for one comment-terminator move in M03-I6's docstring, so **no
assertion moved**. Note (iv) is carried in its corrected form, verbatim.

**(2) B4's docstring mentions strobe exactness twice — ONE `error_pulses` check
discharges it, and tb_writer's resolution is RIGHT. Its reasoning understates
its own work.**

§3.1's assertion list mentions the fact twice because it names **two claims**,
not two checks of one claim: (a) frame A pulses *exactly one*
`error_start_without_terminate* **at the pinned cycle**, and (b) the **run-wide**
exact set — nothing else anywhere, drain included (T2/T5). Both are already
discharged, by **two distinct instruments**, and the second instrument is one
tb_writer did not credit itself with:

- **(a)** is carried by `Strobe_monitor.expect { cycle; not_before; not_after; why }`
  plus `assert_monitors_clean` — the pin **and** §0.6's window, checked by the
  standing monitor, on a per-frame event record.
- **(b)** is carried by the single `error_pulses samples` set match over the
  whole run.

A second `error_pulses` check would be a duplicate of (b), not a discharge of
(a): it would add a second message for one fact and a second control-flow order
to reason about — precisely the hazard owed note **(ii)** exists to warn about.
**Ruling: one check, as built. No edit.**

### 5. Helper duplication — DISPOSITION: accepted for this round, consolidation now OWED and commissioned

tb_writer was right to report and not take it (§2 bar 10), and right that the
count has crossed a line. Inventory, from the tree:

| Helper | Copies |
|---|---|
| `account_dropped_frame` | `test_m03_e.ml:139`, `test_m03_f.ml:145`, `test_m03_b.ml:190` (3) |
| forwarded-with-no-`Arrival`-record (`account_spliced_forwarded` / `account_forwarded_frame`) | `test_m03_h.ml:210`, `test_m03_b.ml:204` (2) |
| `account_spliced_dropped` / `account_resync_runt_frame` (same shape, different names) | `test_m03_h.ml:227`, `test_m03_g.ml` (2) |
| `split_at_first_tlast` | 6 files |

**Accepted for this round, with the reason stated so it is not read as
indifference**: a machinery consolidation inside a row round mixes a refactor's
blast radius with a row's evidence, and this round has just demonstrated why
that matters — B-1 was found because the row's own diff was small enough to read
line by line. **Owed**: a standalone consolidation round, mine to draft, with
three binding conditions: (i) pure refactor — no assertion, no message string and
no argument value changes, so every campaign seal keeps its exact text; (ii) it
lands alone, on its own CI run, with no row in the same commit; (iii) it does
**not** consolidate `split_at_first_tlast` into `bench.ml` without also
recording FINDING B-1's precondition at the definition, because a shared copy of
an idiom with an unstated precondition is worse than six local copies of it.
That third condition is the round's actual justification, and it is what moves
this from housekeeping to a debt worth paying.

### 6. Findings recorded, not repaired

- **B-2 — the Return log's §1 claim is broader than the code, for B3/B2.** §1
  says every clean/forwarded frame's `delivered`/`words`/`last_tkeep`/`tlast_cycle`
  was cross-checked against `Injection.outcomes`. That is true of **B4's frame B**
  (all five fields plus `received`), and **not** of B3's/B2's frame 2, where the
  cross-check reads `delivered` and `reports` only. **No repair, and the row still
  meets §8 criterion 2 at the suite's own standing depth**: `test_m03_h.ml`'s
  following clean frame is cross-checked at exactly that depth (`:307`, `:539`),
  and the `start_cycle + 3 + m` rule the helper asserts is independently anchored
  by `test_m03_i.ml`'s `assert_clean_frame_structure`, which is landed, green and
  driven at **both** start lanes. Deepening the following-frame cross-check to
  B4's is a suite-wide strengthening, not this row's debt; it goes to the next
  family-B round. I deliberately did **not** add it here: an unrunnable new
  assertion is how a green row is turned red by its reviewer.
- **B-3 — frame 1 and frame 2 carry identical content in B3 and B2.**
  `directed_frame_octets ~length:64` is deterministic in `length`, so both frames
  are the same 64 octets. Frame 2's content comparison therefore cannot
  distinguish *frame 2 delivered correctly* from *frame 1's content delivered in
  frame 2's place*; only the per-word **cycle** checks discriminate provenance.
  The row is sound (the cycles do discriminate) but the content instrument is
  weaker than it reads. Remedy, owed to the next family-B round: give frame 2 a
  different declared length, or `Injection.frame_of_length ~sequence`. **Not
  repaired**: it is a stimulus change, which is mine to commission in a packet,
  not to make inside a review.
- **B-4 — a stale forward reference in `test_m03_h.ml`'s module docstring.** It
  says the ordinary two-`frame_case` layout *"is the stimulus M03-B4 already
  uses for an ordinary two-frame run"*. Written before B4 existed; the landed B4
  uses the one-case 68-octet spliced array §3.1 commissions. Comment-only, no
  assertion affected; owed to the next round that opens `test_m03_h.ml`.

### 7. The four traps and the three named checks — verified

- **T4 (B4's array).** `b4_filler` is 4 octets; `base = b4_filler @ frame_b_octets`
  is guarded `<> 68` **before** construction, and the model's own
  `ob.received <> 64` is guarded separately with a message naming the runt the
  mistake would have produced. Two guards, two messages. Frame B's octets begin
  at array index 4 and the auto-terminate lands at `16 + 68` = 84, so
  `84 − 20` = **64 received**, 60 delivered — §3.1's number, and CI's.
- **T3 (the following frame's lane).** No hand-coded lane constant anywhere.
  B3/B2 read `(Arrival.frames sched).(1)` and take `start_cycle` from it;
  `tkeep` is computed from the frame's own length, never from an assumed lane.
  B4's frame B has no `Arrival` record by construction, and its geometry is
  derived from `frame_a.start_octet_time` (itself guarded `= 8`) + 4, not
  authored. Repair R-1 keeps this: the new cycle bound is read from `Arrival`.
- **T2 (whole-run strobe sets).** All three rows match `error_pulses samples`
  over the full run including the `drain:8` tail; no window-scoped accounting
  anywhere in the file. B3's comment correctly banks the aborted frame's
  continuing octets (16 … 79) and its own auto-terminate (80) as covered *for
  free* by that set, and correctly declines to bank it as the row's own claim.
- **T6 (position 4 in-word only at a lane-0 start).** B4 is lane-0 only and says
  why, with the lane-4 counterpart correctly footnoted to §6.2 item 1 as **my**
  plan edit. B2 is §3.3's geometry and **not** `run_e5`'s sweep restated: one
  position (3) at two lanes, with `expected_close_lane` derived per lane
  (3 at lane 0, 7 at lane 4) and the in-start-word fact guarded rather than
  assumed at both. `run_e5` is cited, not re-derived, and **not touched** — the
  commit's file list proves it.
- **B4's frame B is asserted by delivered CONTENT** — `List.equal Int.equal`
  against `Frame.delivered frame_b_octets` — with `tkeep`/`tlast`/cycles as
  *additional* checks, not as the instrument. WO-0057 §2.3's lesson is applied,
  not merely cited.
- **B3's exact set is an exact set** and the `error_bad_fcs` absence is asserted,
  not omitted: the single-element match excludes it mechanically, and the failure
  message names M03-M10's kill so a reader of a red knows what was being claimed.
- **B2 encodes §3.3's honest weighting and nothing more**: lane-4 geometry plus
  the following frame, E5 cited for the lane-0 arithmetic, no swept positions,
  no extra members, no `/I/`//`/Q/` extension (§6.2 item 2 correctly left alone).

### 8. What I commission next

1. **The CI landing is the orchestrator's to operate, and it is the condition of
   this ACCEPT.** Commit the working tree — `test/xgmii_rx_64/test_m03_b.ml`
   (repair R-1) and this packet — under `Agent: dv_lead`,
   `Journal-Entry: J-dv_lead-0099`, and push. **The landing check owed to me is a
   green `build` run at that commit**, whose promotion block leaves all four
   `%expect` blocks in `test_m03_b.ml` empty and `git diff --exit-code` clean.
   Report the run id and its conclusion. Baseline for comparison: `build`
   **30937558341** at `88da20e` = failure; **30937164518** at `a12ac8f` = success.
2. **If that run is red**, it is mine, not tb_writer's: bounce it to me with the
   promotion block, do not re-spawn the worker.
3. **Not claimed by this verdict**, restating §9: no `SO-xgmii_rx_64.md`, and no
   claim about what family B kills — these three rows enter a mutation
   denominator for the first time at the next freeze, and `WO-0058` §8's
   weighting governs.
4. **Queued behind the landing**, in order: (a) the machinery-consolidation round
   of §5, with its three binding conditions; (b) `WO-0063` phase A, which carries
   the `RV-0060` §10 item 3 citation sites; (c) my two owed plan edits (§6.2
   items 1 and 2) and findings **B-2**/**B-3**, which ride with the next
   family-B round; (d) family J, at the bench-capability round the orchestrator
   schedules.
