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
