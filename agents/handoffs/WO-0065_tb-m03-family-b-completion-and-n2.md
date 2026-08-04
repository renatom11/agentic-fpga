# WO-0065: Family B completed, and the row that has been named seventeen times and driven never — M03-N2 gets a unit

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it and records
  every state transition (PROTOCOL §3); I do not. The packet id is the
  orchestrator's to allocate at first commit (PROTOCOL §3, "Packet numbering");
  `0065` is used throughout on the orchestrator's own instruction and is not a
  claim of allocation.
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/requirements.md` **REQ-102** (the preamble is not
  validated; a lane marked control in a preamble position is not preamble, and
  any control character other than `/S/` and `/T/` there routes to REQ-105),
  **REQ-105**, **REQ-107**, **REQ-110** (the abort rule and its zero-delivered
  clause), **REQ-113** (ordered sets and out-of-frame control characters
  ignored), **REQ-018** (the link-partner contract), plus REQ-101, REQ-008,
  REQ-011, REQ-016, REQ-103, REQ-104; **§0.3** (the gap convention and the start
  lanes), **§0.5** (octet time, the front offset, the deciding input word),
  **§0.6** (the strobe window and C-23's counting convention), **§0.7** (the
  zero-delivered class), **§2** (the control-character codes), **§12** (the five
  strobe names); `docs/specs/modules/xgmii_rx_64.md` **§6.1** (the preamble
  positions at each start lane, the one-word lookahead, **consequence 1 and its
  landed six-row cycle table**, D(m) as re-ruled at `1f3c04c`), **§6.2** (the
  `Preamble` row — which names `/I/` **and `/Q/`** by name), **§6.3** items 3
  and 8, **§7**, **§9** (the closure list, the nine-row table, the
  no-output-word pin, ruling 9 at `1fe71ca`, the co-occurrence rulings),
  **§10**'s REQ-102 and REQ-110 hooks, and the **REQ-102 traceability row** at
  `docs/specs/modules/xgmii_rx_64.md:1197`.
- **Rows**: **three, all ASSERT, none new.** `AP-xgmii_rx_64.md` §4.B —
  **M03-B4** (its second member) and **M03-B2** (its `/I/` and `/Q/` members);
  §4.N — **M03-N2** (its first unit, all six sub-cases). **M03-B1 and M03-B3 are
  not touched. M03-B4's landed member (a) and M03-B2's landed `/E/` members are
  not touched, re-ordered or re-worded.**
- **Deliverables**, and nothing else:
  1. `test/xgmii_rx_64/test_m03_b.ml` — extended in place: B4's member (b),
     B2's `/I/` members and B2's `/Q/` members.
  2. `test/xgmii_rx_64/test_m03_n.ml` — **new file**, M03-N2's six sub-cases.
     §3.3.1 rules why it is a new file and not a section of `test_m03_b.ml`.
  3. `test/xgmii_rx_64/dune` — this packet's header line only, comment-only.
  4. **The one unpaid half of an owed bench note**: the count-blindness caveat
     at `delivered_samples`' **definition**, comment-only (§6.1 debt 2).
  5. **Two stale-ground repairs in `test/xgmii/`**, comment-only, authorised in
     this packet and nowhere else (§6.1 debt 4).
  6. Your journal entry, and this packet's Return log.

---

## 1. Why this round, and why it is one round rather than three — the queue read

**Because the three items are the same derivation, and splitting them would make
the third one pay for the first two twice.** B4's member (b), B2's `/I/`
members and M03-N2's six sub-cases all place a control character at a **preamble
position** and all read their report cycle off **the input word carrying the
closing character**. The arithmetic is one arithmetic; the trap is one trap
(§5 T3); and the row that has gone longest without a unit is the one that needs
the other two's geometry in front of it.

**M03-N2 is the reason this round exists at all, and its cost was measured, not
argued** (`J-dv_lead-0106`, transcribed into the plan at `J-dv_lead-0109`).
`grep -rn "M03-N2" test/ --include=*.ml --include=*.mli` returns **three** hits,
all in `test/xgmii/` library files, **none a bench unit**; the row appears in
**zero** `%expect_test` titles and **zero** `Strobe_monitor` registrations. Two
independent sweeps — a registration sweep and a titled-unit sweep, run for
different purposes — agree. What that absence costs is stated in the plan and is
what this packet buys back:

> **One correction against my own artefact, made here rather than left for you to
> trip over.** `AP-xgmii_rx_64.md` §4.N says the row *"is named **17** times in
> this plan"*. Measured at HEAD: `grep -c "M03-N2" test/attack_plans/
> AP-xgmii_rx_64.md` = **25** lines, **26** occurrences. The 17 was measured
> **before** the same round's own edits added §4.N's closing note and §6's two
> entries — a count taken at one state and published about another. **The
> measured facts above are unaffected** (they are about `test/`, not the plan),
> and the plan's sentence is dv_lead's to correct at the `RV-0065` round. Cite
> the measurement, never the 17.

- §6's **REQ-102** and **REQ-110** rows name M03-N2 and today say in terms that
  it supplies **no coverage** to either. Those are the plan's **only two explicit
  no-coverage marks**; this round is what removes them.
- A cell at a non-existent unit is **unscoreable in both directions**. A
  MUST-STAY-GREEN denominator containing M03-N2 is simply wrong, and **one did**
  contain it until the phase-B seal was measured instead of recalled. Landing the
  unit takes that cell out of the next campaign's denominator by making it real.
- The machinery has existed since **WO-0033**. `test/xgmii/injection.mli` states
  in its own header that the two-events-in-one-word cases — *"dv_lead's row
  **M03-N2**"*, by name — are **ordinary** for `Injection.outcomes`, each
  character evaluated at its own octet time. Nothing is missing but the bench.

**Why not family J, again.** Unchanged from `WO-0062` §1: `bench.mli`'s `create`
holds `cfg_rx_enable` at 1 for the whole run and exposes no schedule for it, so
J1–J3 need a **new bench capability** before one row can be written, and J's
observables are entangled with M03-N4's ADR-0014 admission-versus-datapath
ruling. Three members that need no new capability and remove the plan's only
no-coverage marks beat three rows that need a capability and remove none. J moves
to the head of the queue the moment a bench-capability round is scheduled.

---

## 2. Standing bars — carried from `WO-0062` §2, restated only where they bite here

`WO-0062` §2 bars 1–13 are in force **unchanged** and are not re-copied. Read
them there. Five bite differently this round and are restated:

1. **Independence (PROTOCOL §10, charter §3).** Do not open `libs/**`,
   `rtl_snapshots/**`, or `docs/reports/audit/**`. Your journal `Inputs` lists
   specs, this packet, `AP-xgmii_rx_64.md` and existing `test/**` files, and
   nothing else. A leaked-context violation must be visible in the diff; that is
   the enforcement.
2. **Two derivations, in this order** (bar 2). Derive every expected value from
   the specification text first, **then** cross-check against
   `Dv_xgmii.Injection.outcomes`. **Never take the model's number as the
   expectation.** This bar is load-bearing this round in a way it has not been
   before: `Injection.outcomes` is the *only* object in the tree that already
   models the two-events-in-one-word case, so the temptation to let it be the
   derivation is at its maximum here. If your spec-derived figure and the model
   disagree, that is a **finding**, and the Return log is where it goes.
3. **No unauthorised machinery** (bar 10), **with two named exceptions**.
   `bench.ml`/`bench.mli` and everything under `test/xgmii/` and
   `test/monitors/` are frozen for this round **except** the two comment-only
   repairs authorised at §6.1 debts 2 and 4, which are bounded there in terms.
   Anything else you cannot write without an addition: **stop and report it**
   with the smallest addition that would work (`WO-0059` §8.1 is the precedent
   for authorising one, and it was authorised *in the packet*, not taken).
4. **Report, never repair, a row you cannot satisfy** (bar 11). If the
   specification text and this packet's derivation disagree, **the specification
   wins and this packet is the thing that is wrong.** Do not invent a row, do not
   widen a stimulus, do not edit `AP-xgmii_rx_64.md` — it is dv_lead's.
5. **Every failure message names the row id and the member, character-exact**
   (bar 8) — e.g. `M03-N2 (S lane 4, A lane 0, delivered): …`. Campaign seals are
   written against these strings.

---

## 3. The rows

Every figure below is **a derivation to check, not an instruction** (`WO-0059` §4
item 3): re-derive it from the cited text, and **if your derivation disagrees
with mine, your derivation and the Return log win.** The arithmetic uses
`Bench.frames_at`'s lane mapping — `first_start` = 8 at a lane-0 start, 12 at a
lane-4 start (`bench.mli`) — so both start words are **cycle 1**; octet time `t`
lies in cycle `t / 8` at lane `t mod 8`; `Injection`'s `At_preamble p` places a
character at `start_ot + p` and `At_octet i` at `start_ot + 8 + i`
(`injection.mli`, placement).

### 3.1 M03-B4 member (b) — the same `At_preamble 4` at a **lane-4** start

**Row text** (`AP` §4.B, note **B-i**): the identical placement lands in **lane 0
of the following word** — a **cross-word** abort of a frame **already open on
entry** to that word, alignment transition **4 → 0**, and the only stimulus in
this plan whose preamble-position control character lies **outside its own
frame's start word**.

**Construction** — one `Injection` frame case, one corruption, at a **lane-4
start**:

- array = **4 filler octets** followed by a clean 64-octet frame, i.e. **68**
  array octets — the *same array* member (a) uses;
- corruption = `Place { placement = At_preamble 4; character = start_char }`;
- `first_lane:4`.

**Derivation to check** (note B-i's table, re-derive it, do not copy it):

| | Member (a), landed | **Member (b), this member** |
|---|---|---|
| Frame A's `/S/` | octet time 8 — cycle 1, lane 0 | octet time **12** — cycle 1, lane 4 |
| The aborting `/S/` (`At_preamble 4`) | octet time 12 — cycle 1, **lane 4**: the *same* word | octet time **16** — cycle **2**, **lane 0**: the *next* word |
| A open on entry to that word? | **No** — A opened in it | **Yes** — A consumed preamble positions 1 … 3 in lanes 5 … 7 of cycle 1 |
| Alignment transition | 0 → 4 | **4 → 0** |
| Frame B's first octet | octet time 20 = array index 4 | octet time **24** = array index 4 |
| `Arrival`'s auto-terminate | 16 + 68 = 84 | **20 + 68 = 88** |
| Frame B receives | 84 − 20 = **64** | 88 − 24 = **64** |
| A's report (§9's no-output-word pin, two cycles after the **closing** word) | cycle **3** | cycle **4** |

**The figures are identical at both members because the array is identical** —
64 received, **60** delivered in **8** words, final `tkeep` **0x0F**,
`tuser`[0] = **0**, **no strobe** on B. The members differ in exactly **one
stimulus parameter** (the first frame's start lane) and **one observable cycle**.
That is what makes the pair a controlled comparison rather than two tests, and it
is also the check: **if your member (b) figures differ from member (a)'s in
anything but the strobe cycle and frame B's start lane, the geometry is wrong.**

**Assert, in this order**: construction/landing at both sites → frame A delivers
no word at all and pulses exactly one `error_start_without_terminate` at the
pinned cycle (**and no other strobe over the whole run**) → frame B's delivered
octets **content for content** → frame B's per-word `tkeep`, `tlast` and cycles →
the run-wide exact strobe set → conservation (A dropped, B clean) → monitors
clean.

**What this member pays, exactly, and what it does not.**

- **Pays**: the **first point in the opposite direction** on the
  alignment-transition instrument. `WO-0058` §9 **bound 6** asked for a second
  point and member (a) supplied one — but `run_h2`'s lane-0 member and member (a)
  are **both 0 → 4**. Member (b) is the bench's only **4 → 0**. It is also the
  plan's **first preamble-position control character outside its frame's own
  start word** (`WO-0062` §5's T6 geometry: at a lane-4 start, preamble positions
  4 … 7 lie in the **next** word).
- **Does NOT pay `WO-0058` bound 7**, and this is trap **T1**. Bound 7's words:
  > *"The in-word (epoch B/C) REQ-110 abort is exercised at one unit, in one
  > geometry. M03-H4's word `c` is the bench's only in-word abort, and only in
  > the nothing-open-on-entry form; **no unit drives an in-word abort with a
  > frame already open**."*

  Bound 7 has **two conjuncts** — *in-word* **and** *already open on entry*.
  Member (b) has the second and not the first: its `/S/` is in **lane 0**, the
  word's first lane, so the abort is at a **word boundary**, not in-word. Member
  (a) has the first and not the second (nothing was open when its word arrived).
  **Neither member of M03-B4 pays bound 7.** Do not write that it does; a member
  that looks as though it closes a bound and does not is exactly how a bound gets
  quietly dropped. **Bound 7 is paid in this packet — by M03-N2, at §3.3.**

**Bench notes owed at this member**: the count-blindness caveat (§6.1 debt 2) at
this member's own count guard — it is at a **lane-4 start**, which is the lane
the caveat is about.

### 3.2 M03-B2's `/I/` and `/Q/` members — the two characters that separate REQ-102's third sentence from REQ-113's ignore rule

**Row text** (`AP` §4.B, note **B-ii**): three character members at **preamble
position 3**, each at **both** start lanes, the placement held fixed and the
character the variable — (a) `/E/` **landed**, (b) `/I/`, (c) `/Q/`.

**Construction**: `Place { At_preamble 3; character }` at **both** start lanes,
each followed by a second clean case, with `character` =
`Dv_xgmii.Xgmii_word.idle_char` (0x07) and
`Dv_xgmii.Xgmii_word.sequence_char` (0x9C). **Four members**: {`/I/`, `/Q/`} ×
{lane 0, lane 4}.

**Derivation to check.** The landed `/E/` members' exact placement, unchanged: at
a lane-0 start the character is at octet time `8 + 3` = **11** → cycle **1**,
lane **3**; at a lane-4 start at `12 + 3` = **15** → cycle **1**, lane **7**.
Both lie in the **start word**, so both report at **W + 2** = cycle **3**, §0.6
window **[1, 4]**, at both lanes. **The observable is identical to the landed
`/E/` members', figure for figure** — no output word at all for that frame,
exactly one `error_bad_frame`, next frame received intact — because the row's own
Observable cell says so: *"members differ in exactly one variable, so their
observables are identical figure for figure — a difference between them is this
row's own defect signature."* **Do not re-derive `run_e5`'s arithmetic and do not
touch `run_e5`** (`WO-0062` §5 T1: its message is sealed into a closed campaign).

**What `/I/` kills that `/E/` cannot** (note B-ii's substantive ground, and the
whole reason these members exist): an `/E/` in a preamble position routes to
REQ-105 **under REQ-102's third sentence** *and* under a design that simply
treats preamble positions as frame positions — same observable, both readings, so
the landed members test the **outcome** and not the **rule**. `/I/` separates
them, because **REQ-113** orders a control character other than the start
character occurring **outside** a frame to be ignored — no output word, no header
effect, no strobe — while a preamble position is **inside an open frame**, where
REQ-102's third sentence demands one `error_bad_frame` and no output word. **A
design carrying REQ-113's ignore rule into the preamble is silent where the
specification demands a report** — REQ-008's silent-discard hole — and nothing
else in this plan sees it.

**What `/Q/` kills that `/I/` cannot**, which is why it is a member and not a
duplicate: a design whose preamble-position routing is a **closed code table**
(`/T/` → REQ-107, `/S/` → REQ-110, `/E/` → REQ-105, `/I/` → REQ-105) and which
**falls through** on any code outside it. REQ-102's third sentence is
**extensional** — *"any other control character"* — and SPEC-M03 §6.2's
`Preamble` row says the same in the same shape: the exit is taken *"on **any
other control character in a preamble position** — `/I/` and `/Q/` included"*.
`/Q/` is the only character in this plan that tests that the routing is
**by the control bit**, not by an enumeration. `/I/` cannot see it, because a
closed table would contain `/I/`.

#### 3.2.1 RULING — `/Q/` is DRIVEN, and note B-ii obligation 1 is discharged here

Note B-ii carried `/Q/` as a **declared, not driven** sub-member pending one
derivation: *whether REQ-018's link-partner contract admits a `/Q/` at an
arbitrary preamble position.* That derivation is made here and it comes out
**admitted**. Grounds, in order of weight:

1. **The module specification states the design's obligation on this exact
   input, twice, naming `/Q/`.** SPEC-M03 §6.2's `Preamble` row: the state leaves
   to `Idle` *"on **any other control character in a preamble position** — `/I/`
   and `/Q/` included, which REQ-102's third sentence routes to REQ-105 and which
   therefore ends the frame the same way (§6.1, §9's third row)"*. And the
   REQ-102 traceability row (`xgmii_rx_64.md:1197`): *"control characters in
   preamble positions routed to §9 — `/T/` to REQ-107, `/S/` to REQ-110,
   **anything else, `/I/` and `/Q/` included, to REQ-105**"*. **A specification
   that fixes the design's obligation on an input has constrained that input.**
   M03-O5's prohibition — a bench asserting a fact about a space the
   specification does not constrain — therefore does not bite, and it was the
   only thing holding the sub-member.
2. **REQ-018 limb (ii) reaches it through REQ-102's own composition.** The
   contract requires the model to inject *"each condition named in REQ-104,
   REQ-105, REQ-107, REQ-108 and REQ-110"*. REQ-105's condition, **as REQ-102's
   third sentence composes it**, is *any* control character other than `/S/` and
   `/T/` in a preamble position. The composition is the specification's own, not
   mine: §6.2 and the traceability row both perform it in terms.
3. **REQ-018's limbs are a floor, not a ceiling.** Read as a closed admission
   set, the contract would refuse M03-B3's `/T/` at **position 5** and M03-B2's
   `/E/` at **position 3** — no requirement names either position — and both are
   committed, green rows. The plan's own §3 draws exactly **one** prohibition
   from REQ-018 (a `/S/` in a lane other than 0 or 4 is never driven) and draws
   no other. There is no ground in §3 to refuse `/Q/`.
4. **The vocabulary this programme actually froze treats `/Q/` as a per-lane
   control character code.** `requirements.md` §2 defines *"`/Q/` sequence
   ordered set = 0x9C"* as one of the five control-character codes and `xgmii_rxc`
   bit k marks lane k as control (`xgmii_rx_64.md:180`). **The four-character
   structure of a sequence ordered set is an 802.3 fact and is stated in no
   frozen specification of this programme** — it appears only in my own note
   B-ii. Deferring a stimulus that the module spec names by name, on the strength
   of a structural fact no frozen spec states, is deriving from **outside** the
   spec, which is the opposite failure from the one the deferral was guarding
   against. **The correction is mine and it is recorded here rather than only in
   my journal.**

**What I refuse to claim with it.** `/Q/` at position 3 is a *single control
character at a named preamble position*, not an ordered set: REQ-113's
*"sequence ordered sets … occurring **outside** a frame"* case is **untouched**
by these members, is family I's (M03-I3), and no message, comment or Return-log
sentence may say this member tests it.

**The asymmetry, stated so a reader does not have to find it.** `/I/`'s admission
rests on **two** independent sites — §6.2's `Preamble` row **and** the REQ-102
traceability row's verification column, which names *"one frame with an **idle**
character in a preamble lane, asserting REQ-105's zero-delivered behaviour
(**M03-N3**)"*. `/Q/`'s rests on **one** — §6.2's `Preamble` row, by name. One
site fixing the design's obligation is enough. **If architect_docs_lead later
rules REQ-018 limb (ii) a closed list keyed on each requirement's literally-named
conditions, `/Q/` converts to a declared gap naming that clause — never to
silence** (note B-ii's own words), and `/I/` survives that reading on its second
site.

**M03-N3 is untouched and stays untouched** (note B-ii obligation 3). Its binding
constraint is on the **wrapper** — *the idle-injection wrapper of M03-I4 SHALL
NOT inject between a start character and the frame's first octet.* These members
place a **single character** at a named preamble position through
`Injection`'s `At_preamble`; they do not inject an idle **word** through M03-I4's
wrapper. **Nothing here relaxes the wrapper rule**, and if you read it as licence
to, you have misread the note.

### 3.3 M03-N2 — two closure characters in one input word, all six sub-cases

**Row text** (`AP` §4.N): two closure characters in one input word **W** where
the second falls **inside the new frame's preamble** — `/S/` in lane 0 or lane 4
of W, and `/T/` in a **higher lane of the same W**. **Six sub-cases, not four**:
the discriminators are the **aborting `/S/`'s lane**, the **aborted frame A's own
start lane**, and **whether A delivered an octet**.

**Reading (i) is RULED** (WO-0029 §3a, endorsed on a second independent ground at
REQ-101, converted at `06c1eba`): the `/S/` aborts the open frame A — one
`error_start_without_terminate`, `tuser`[0] = 1 on its `tlast` **where it emitted
one**, no FCS removed — and the `/T/` closes the frame **that same `/S/` opened**,
with **zero delivered octets**: no output word, one `error_runt` (REQ-107,
§9 ruling 9's sub-5 class).

#### 3.3.1 The unit lives in a NEW file, `test/xgmii_rx_64/test_m03_n.ml`

Three grounds. (i) **Family N has no file** and M03-N1 and M03-N4 are also
outstanding ASSERT rows; this creates their home. (ii) **The `dune` stanza is a
`library` with `(inline_tests)` and no `modules` field**, so a new module needs
**no dune change** — only the header comment's per-packet line (§7). (iii)
**M03-N2 is not a family-B row, and putting it in `test_m03_b.ml` repeats a
mistake that has already cost this programme a wrong number.** `M03-M10` shares
`M03-B3`'s `%expect_test` title in that file, and that sharing is exactly why
`WO-0063B-VERDICT` §9 item 1.1 attributed the discharge count's move to the wrong
cause (`J-dv_lead-0109` §7 — my correction against my own verdict). A row filed
under another family's title is a row a mechanical census miscounts.

#### 3.3.2 The six sub-cases, and how to build them

Both closure characters are placed as corruptions **on frame A**, because frame B
is opened by the *stimulus* and has no catalogue entry of its own —
`injection.mli` says so in terms (*"a frame the stimulus opens … gets an outcome
even though no entry of the catalogue describes it"*). So:

```
Place { placement = <A-relative>; character = start_char }      (* opens B *)
Place { placement = <A-relative, same word, higher lane>; character = terminate_char }
```

and B's preamble position for the `/T/` is **(the `/T/`'s octet time) − (the
`/S/`'s octet time)**, which must be in **1 … 7** and in the **same input word**.

**The landed cycle table** (`AP` §4.N, matching SPEC-M03 §6.1 row for row). **W**
is the input word carrying the aborting `/S/`; **A**'s last delivered octet is
the octet immediately before the `/S/` (REQ-110) — lane 7 of **W − 1** for a
lane-0 `/S/`, **lane 3 of W itself** for a lane-4 one, since a lane-4 start
character leaves lanes 0 … 3 of its word to the aborted frame. Frame B delivers
nothing, so §9's pin puts its report **two cycles after W, always**.

| # | `/S/` lane | A's start lane | A delivered | A's `error_start_without_terminate` | B's `error_runt` | Same cycle? | Pays bound 7? |
|---|---|---|---|---|---|---|---|
| 1 | 0 | 0 | ≥ 1 octet | W + 1 | W + 2 | no | no |
| 2 | 0 | 4 | ≥ 1 octet | W + 1 | W + 2 | no | no |
| 3 | 0 | either | 0 octets | W + 2 | W + 2 | **yes** | no |
| **4** | **4** | **0** | **≥ 1 octet** | **W + 2** | **W + 2** | **yes** | **YES** |
| **5** | **4** | **4** | **≥ 1 octet** | W + 1 | W + 2 | no | **YES** |
| 6 | 4 | either | 0 octets | W + 2 | W + 2 | **yes** | at the lane-4-start instance only — derive it |

**Sub-case 4 is the plan's own minimal witness for defect M03-R1** and its
geometry is given there in terms, so build it from that text: *"A opens with `/S/`
in lane 0 of word W − 1; word W carries A's octets 0 … 3 in lanes 0 … 3, a `/S/`
in lane 4 and a `/T/` in lane 6. A delivers **four** octets, so its `tlast` word
(`tkeep` = 0x0F, `tuser`[0] = 1) is output word 0 and leaves on
(W − 1) + 3 = **W + 2**, and B's `error_runt` is also on **W + 2**."*

**A worked placement for sub-case 4, to check and not to copy.** A at a lane-0
start: `/S/`(A) at octet time 8 (cycle 1, lane 0); A's octet *i* at octet time
16 + *i*. Put the aborting `/S/` at octet time **20** → cycle **2**, lane **4** →
`At_octet 4`; put the `/T/` at octet time **22** → cycle 2, lane 6 →
`At_octet 6`, which is B's **preamble position 2**. A delivered octets 0 … 3 =
**four**. **Derive the other five yourself from the same two rules** (octet time
→ cycle/lane; A-relative index → octet time), and state each sub-case's derived
`(W, /S/ lane, /T/ lane, A delivered, both report cycles)` tuple in a comment
above its own runner.

#### 3.3.3 What M03-N2 pays: `WO-0058` bound 7, in full and for the first time

Bound 7 wants **an in-word abort with a frame already open on entry**. Sub-cases
**4 and 5** have both conjuncts by construction:

- **in-word** — the aborting `/S/` is in **lane 4**, not lane 0, so it lands
  mid-word, not at a word boundary; and
- **already open on entry** — A delivers octets in **lanes 0 … 3 of W itself**
  (REQ-110's own sentence: *"a start character in lane 4 leaves lanes 0 to 3 of
  that word belonging to the aborted frame"*), which A can only do if it entered
  W in `Frame` state.

Today `M03-H4`'s word `c` is the **bench's only in-word abort**, and only in the
**nothing-open-on-entry** form; this is the dimension `FINDING GH-2` turned on
and it is unbenched everywhere else. **Sub-cases 4 and 5 close bound 7.** They
are also the bench's first REQ-110 aborts with a **marked `tlast` word** in a
two-events-in-one-word setting, which is why T7 exists.

**Sub-case 6 is split and you must derive the split, not assume it.** At a
**lane-0** start the aborting `/S/` in lane 4 lands at A's **preamble position
4** — A opened in that same word, so **nothing was open on entry** (this is
M03-B4 member (a)'s geometry, epoch B) and it does **not** pay bound 7. At a
**lane-4** start, A's preamble straddles the word boundary, so A **is** open on
entry (in `Preamble`) and the abort is in-word — a third bound-7 instance, in the
zero-delivered form. **Derive which of the two you built and say so.** If your
derivation disagrees with this paragraph, yours wins and the Return log records
it.

#### 3.3.4 Assert, in this order, per sub-case

1. **Construction/landing at both sites, for both characters** (T12): each lands
   at its intended octet time and lane **in the schedule's own word** *and* in the
   cycle `run` actually drove, and **both are in the same input word W**.
2. `Injection.errors` is **empty** — a non-empty list is a construction failure,
   not a result (`injection.mli`).
3. **Structural**: frame B produces **no output word at all**; on sub-cases 3 and
   6 frame A produces none either.
4. **A's delivered side**, on sub-cases 1, 2, 4, 5 only: the delivered octet
   count (the octet immediately before the `/S/` is the last), `tkeep` on the
   `tlast` word, and **`tuser`[0] = 1** (REQ-110's main clause).
5. **The run-wide exact strobe set**: exactly two pulses, `error_start_without_
   terminate` at A's cycle and `error_runt` at B's, **and nothing else over the
   whole run, drain included** — in particular **no `error_bad_fcs` for either
   frame** (T9).
6. **Both report cycles individually pinned**, and on the coinciding sub-cases
   (3, 4, 6) that the two pulses are **on the same cycle under different strobe
   names** — asserted as a fact of that sub-case, with §6.3 item 8 **not** cited
   as tested (T10).
7. **Conservation**: A dropped, B dropped — **both** frames are reported under a
   strobe and **neither** is a clean frame (`WO-0062` §2 bar 13). There is no
   clean frame in this stimulus unless you add a following one.
8. **Monitors clean.**

---

## 4. Risk ranking — highest value first, and the ranking is the review order

| Rank | Item | Why it ranks there |
|---|---|---|
| **1** | **M03-N2 (§3.3)** | Removes the plan's **only two explicit no-coverage marks** (§6's REQ-102 and REQ-110 entries), takes an unscoreable cell out of the next campaign's denominator, and **pays `WO-0058` bound 7** — the one bound this programme has carried open across five packets. Also the highest construction risk in the round: six sub-cases whose discriminators are three independent axes, in a new file |
| **2** | **M03-B4 member (b) (§3.1)** | The bench's only **4 → 0** alignment transition and the plan's only preamble-position control character outside its frame's own start word. Low construction risk (the array and every figure are member (a)'s), high trap risk (**T3**: the report word is the *next* word, not the start word) |
| **3** | **M03-B2's `/I/` and `/Q/` (§3.2)** | Two distinct kills — REQ-113's ignore rule carried into the preamble (`/I/`), and a closed-code-table routing (`/Q/`) — on a placement already landed and already green at both lanes. Lowest construction risk; the ruling at §3.2.1 is the part that took the work |
| **4** | **The four debts (§6.1)** | Comment-only, and two of the four are already discharged (measured, §6.1). They land with whichever unit opens their file |

---

## 5. Derivation traps — the twelve that decide this round

- **T1 — bound 7 is M03-N2's, not M03-B4's.** §3.1. Member (b) is a **cross-word**
  abort (its `/S/` is in lane 0). Do not write, in a comment, a message or the
  Return log, that any M03-B4 member closes bound 7.
- **T2 — member (b)'s array arithmetic** (carried, `WO-0062` T4). Frame B's octets
  begin at **array index 4** and `Arrival`'s auto-terminate lands after the
  **whole** array. A 64-octet array gives frame B **60** received octets — a
  **runt**, with a completely different observable, and the member would pass as a
  different test. **Guard the received count against 64 before asserting
  anything.**
- **T3 — the pin is relative to the word carrying the *closing* character, and
  which word that is depends on the start lane.** Member (a) reports at cycle
  **3** (its own start word + 2); member (b) at cycle **4** (the *next* word + 2).
  Deriving member (b)'s pin from member (a)'s cycle is the single failure this
  member exists to expose, and a bench that makes it is green on member (a) and
  wrong here.
- **T4 — `Injection` accepts `/I/` and `/Q/` only at `At_preamble`.** *"inside an
  open frame it is outside the specified space and is refused"* (`injection.mli`).
  A refusal lands in `Injection.errors`, which **a bench must treat as a
  construction failure, not as a result**. Assert `errors` is empty at every
  member in this packet.
- **T5 — B2's new members' figures must equal the landed `/E/` members', figure
  for figure.** The row's own Observable says a difference between members **is
  the defect signature**. If your `/I/` derivation gives a different cycle,
  `tkeep` or count from `/E/`'s, you have found either a defect or an error in
  your derivation — **report it, do not reconcile it.**
- **T6 — the count guard is blind at a lane-4 start.** At a lane-4 start the
  emitted word count equals `W` **by identity**, so a count-guard disagreement is
  impossible there and the `tlast`-position check is blind with it. Every new
  member at a lane-4 start (B4 (b), B2's lane-4 members, N2's sub-cases 2, 5 and
  6) carries the caveat at its **own** guard.
- **T7 — `tuser`[0] exists on sub-cases 1, 2, 4, 5 and does not exist on 3, 6.**
  Assert `tuser`[0] = 1 on A's `tlast` word where A delivered; **never assert
  `tuser`[0] on a frame with no `tlast` word** (M03-E2's prohibition, `WO-0062`
  §2 bar 12) on sub-cases 3 and 6, on either B4 member, or on any B2 member.
- **T8 — A's strobe set on the delivered sub-cases is `error_start_without_
  terminate` ALONE — even where A delivered fewer than five octets.** Sub-case 4's
  A delivers **four**. §9's runt rows key on *"octets between start and
  terminate"*, and an aborted frame has **no terminate**: the runt check is
  sequenced at REQ-106's exit, which this frame never takes. **Derive it from §9's
  table and §6.2's `Frame` row exits, assert the exact set, and if your derivation
  says otherwise, report it.** This is where a design classifying by delivered
  count alone pulses a second strobe, and it is a kill this row buys.
- **T9 — `error_bad_fcs` absence is an assertion, not an omission** (carried,
  `WO-0062` T9). *"no FCS removal is attempted on a frame with nothing to remove
  it from"*, and the aborted frame has no FCS stripped (REQ-110, REQ-103). Assert
  that it pulses for **neither** frame in **every** sub-case.
- **T10 — the coincidences are same-cycle, DIFFERENT-name.** A's strobe is always
  `error_start_without_terminate` and B's is always `error_runt`, so **no
  sub-case creates a SPEC-M03 §6.3 item 8 instance** (two frames reported on one
  cycle under the **same** name). The carve-out stays untested by this packet and
  **no comment, message or Return-log sentence may claim otherwise.**
- **T11 — the cycles are read at W, and two `.mli` docstrings say otherwise.**
  `test/xgmii/injection.mli:33` and `:60–63` and
  `test/xgmii/idle_injection.mli:64–77` carry the **withdrawn** ground (§7's
  per-octet constant as gap-invariant — withdrawn as false at `SCR-M03-I4`) and
  the **withdrawn** clause (injection moves the two lane-0-`/S/` rows *earlier*,
  widening their separation — re-based to **W** at `1f3c04c`, countersigned
  `J-dv_lead-0086`). **Derive from SPEC-M03 §6.1's landed table, never from those
  docstrings.** Repairing them is §6.1 debt 4 and is a deliverable of this packet.
- **T12 — both landing sites, for both characters, and the same word.** Carried
  (`WO-0047` §6 item 7, `WO-0062` §2 bar 3) and sharpened: a sub-case whose two
  characters silently land in **different input words** is a different row with a
  different table, and it will pass its own arithmetic. Guard `W` explicitly.

---

## 6. Interactions with owed items

### 6.1 The riding bench debts — measured at HEAD, and two of the four have evaporated

**All four were re-measured from the tree before this packet was written, not
carried from memory.** Two are already discharged and are recorded as such rather
than re-commissioned; one is half paid; one is new, found this round.

**Debt 1 — the three stale `RV-0059-VERDICT §8` citation sites in
`test_m03_i.ml` (`:41–42`, `:1336`, `:1368`): EVAPORATED. Nothing is owed.**
They were repaired at `WO-0063A` (`J-tb_writer-0023`, commit `c00771f`).
Measured now: `grep -c "RV-0059-VERDICT §8" test/xgmii_rx_64/test_m03_i.ml` = **2**,
and both survivors are the *"keep the history, re-cite the rule"* form the repair
was supposed to produce — `:49` and `:1328` each cite **SPEC-M03 §6.1's D(m)
(`1f3c04c`)** as the rule and name `RV-0059-VERDICT §8` as history. **Correct as
written; do not touch them.**

**Debt 2 — the count-blindness note: PAID at the call sites, UNPAID at the
definition. That residue is deliverable 4.** `J-dv_lead-0094` owed the note *"at
the count guard's own sites (`test_m03_i.ml:290`, `:445`; **definition at
`bench.ml:222`**)"*. The call-site half landed at `WO-0062` §6.1(i): the note is
present at **five** sites in `test_m03_i.ml` (`:314`, `:489`, `:1055`, `:1493`,
`:2030`). The **definition** half never landed: `bench.ml:222` and
`bench.mli`'s `delivered_samples` docstring say nothing about it.

> **Commissioned, comment-only**: add to `bench.mli`'s `delivered_samples`
> docstring (and, if you judge the definition needs it too, `bench.ml` at the
> same function) a sentence in this shape — *at a lane-4 start the emitted word
> count equals `W` by identity, so a disagreement in this count is impossible
> there and a `tlast`-position check built on it is blind with it; the instrument
> is present and blind at one lane, not missing, and no packet may cite "the
> count was right" as evidence about word integrity.* **No `val`, no type, no
> expression may change.**

**Why the definition and not one more call site.** The rule now sits where the
**last incident** was journalled and not where the **next reader** will meet the
instrument — and this round proves the point by creating that reader: every new
lane-4 member in §3 calls `delivered_samples` from a file that carries no caveat
at all. This is `J-dv_lead-0108`'s banked rule applied a second time (*a rule
belongs where the next pass will be run, not where the last one was recorded*),
and it is the same move `tools/dv_checks.sh` got at `J-dv_lead-0109` §6.

**Debt 3 — the guard-ordering note: PAID, with a per-cascade obligation that
travels.** It is present at `test_m03_i.ml:447` over the four-guard cascade, in
the form `WO-0062` §6.1(ii) commissioned. **Nothing is owed on the landed site.**
But the note is **per-cascade, not per-file**, and this round adds guard cascades
in `test_m03_b.ml` and in a brand-new `test_m03_n.ml`.

> **Commissioned**: every **new** multi-guard cascade this packet adds carries
> the note at its own site, in the landed form — *an earlier `fail`-raising guard
> prevents a later, independently sufficient instrument from ever speaking; which
> instrument convicts is a control-flow fact, not a coverage fact* — and names
> the guards in the cascade in order.

**Debt 4 — NEW, found while deriving §3.3: three stale doc sites in
`test/xgmii/`, all of them addressed to a bench driving M03-N2, which is the
bench this packet creates.** This is deliverable 5.

| Site | What it says | Why it is stale |
|---|---|---|
| `injection.mli:33` | *"the strobe cycles come from §7's per-octet constant and §9's no-output-word clause, which are **gap-invariant**"* | The per-octet constant's gap-invariance is **withdrawn as false** — `SCR-M03-I4`, ruled at `requirements.md` §0.5 and SPEC-M03 §6.1 (`a77017c`), `J-dv_lead-0085`. That constant does **not** survive injection at either start lane |
| `injection.mli:60–63` | *"both pinning rules used here are gap-invariant, and dv_lead's WO-0031 scope note applies unchanged: of §6.1's six two-events sub-cases, injection moves the two lane-0-`/S/` rows **earlier**, widening their separation from the new frame's report, and never onto it"* | Both halves withdrawn. The ground is §6.1's **scope note and the named input word**, not the constant; and the named word is **W in every row of the table, the two whose octets lie in the word before W included** — re-based at `1f3c04c`, countersigned `J-dv_lead-0086`. Injection before W therefore moves **both** reports **together**, by the same amount |
| `idle_injection.mli:64–77` | the same withdrawn clause at length, under a heading that says it is *"repeated here because a bench driving **M03-N2** inside this wrapper needs it"* | Same withdrawal. This is the single most dangerous site in the tree for this packet: it is addressed by name to the reader this packet creates |

> **Commissioned, comment-only**: re-ground all three. Keep the **conclusion**,
> which is unchanged and must be stated as unchanged — *the six rows, the three
> coincidences, and §6.3 item 8's having no instance here all stand* — and
> replace the **ground**: each cycle is pinned relative to a **named input word**,
> that word is **W** in every row, so idle injection before W moves both reports
> together and the coincidence column is unchanged at **every** `k`; the row may
> still be run inside the M03-I4 wrapper. **Keep the history** (name
> `WO-0031`'s scope note as the superseded form, do not delete it) — that is the
> repair pattern `J-tb_writer-0023` executed correctly on debt 1 and it is the
> pattern here. **No `val`, no type, no expression may change in either file.**

**The frozen-seal collision check is already run, and it is clear.** My own
`J-dv_lead-0105` banked the rule that *before instructing an edit to a string, a
proposal establishes whether that string is quoted by any frozen artefact*. Run
at this tree: `grep -rn "injection moves the two lane-0\|both pinning rules used
here are gap-invariant" agents/handoffs/` returns, **discounting this draft's own
three quotations of the strings it is repairing**, exactly **one** hit —
`WO-0033_dv-machinery.md:10`, my own original machinery instruction — and
**zero** hits in any `*SEALED*` file. `BUG-0002` paraphrases the clause and quotes
no string. **No frozen seal is falsified by this repair**, and neither packet is
edited (they are packets; a packet records a judgement at a time).

### 6.2 Earned but NOT commissioned here — footnoted, on the `WO-0058`/`WO-0061` §12 precedent

Recorded so the debt is legible. **Do not write them**, and do not treat their
absence as an omission in your return.

1. **M03-N2 with `/E/` as the second closure character.** The row's cell says
   *"`/T/` (or `/E/`)"* and its Attacks cell cites REQ-105. This packet commissions
   `/T/` at all six sub-cases — the character the landed cycle table is written
   for. The `/E/` variant is earned and not commissioned because it buys **no
   coverage REQ-105 lacks** (family E and M03-B2 both drive it) and creates **no**
   §6.3 item 8 instance either (B's strobe merely changes name from `error_runt`
   to `error_bad_frame`, so the coincidences stay different-name). It becomes
   worth writing the day a same-name coincidence is constructible, which is not
   this row.
2. **B-2's and B-3's remedies on the LANDED M03-B2 and M03-B3 members.** Both are
   bars on the **new** members here (§8) and remain **debts** on the landed ones:
   B-2's is a suite-wide deepening and rides a round that can run the suite; B-3's
   is a **stimulus** change to committed, green, sealed-message units. Not this
   packet's, and §7's scope forbids touching them.
3. **B-4** — the stale M03-B4 forward reference in `test_m03_h.ml`'s module
   docstring. It rides the next round that opens `test_m03_h.ml`. **This is not
   that round**; `test_m03_h.ml` is not a deliverable and must not be staged.

---

## 7. What you produce, and how it returns

1. `test/xgmii_rx_64/test_m03_b.ml` extended: **one** new runner + expect block
   for B4 member (b); B2's `/I/` and `/Q/` members added to B2's existing
   both-lanes shape (a new runner or a widened `character` parameter on
   `run_b2` — **your call**, stated in the Return log with the reason; if you
   widen `run_b2`, its landed `/E/` behaviour must be bit-identical and you say
   how you checked). **B1, B3, B4 member (a) and B2's `/E/` members untouched.**
2. `test/xgmii_rx_64/test_m03_n.ml` — new: six runners (or one runner over a
   concrete six-element list traversed by `List.iter`, ascending — `WO-0062` §2
   bar 7) and their expect blocks, each naming its sub-case in its title by the
   three discriminators.
3. `test/xgmii_rx_64/dune` — one header line for this packet, comment-only, in
   the existing per-packet convention.
4. The count-blindness caveat at `delivered_samples`' definition (§6.1 debt 2).
5. The three stale-ground repairs in `test/xgmii/` (§6.1 debt 4).
6. Your journal entry, with the spawn short-id in `Trigger`, spec paths and REQ
   ids in `Inputs`, and **no `libs/**` path anywhere** in it.
7. This packet's **Return log**, carrying: every derivation where yours differs
   from §3's; every guard you added and why; the derived
   `(W, /S/ lane, /T/ lane, A delivered, both cycles)` tuple for each of the six
   sub-cases; anything you could not write without a machinery change beyond §2
   bar 3's two exceptions; and any row-text disagreement — **reported, not
   repaired**.

**Evidence to quote in the Return log**: `dune runtest` output and
`git diff --exit-code` at the tree you hand back, plus the per-member unit names
as they appear in the runners, so the next campaign's denominator is countable
from your return rather than from a re-read of the file.

**Your journal is `agents/journals/workers/claude_tb_writer_agent.v02.md`** and
your next entry is **`J-tb_writer-0024`**. Measured at HEAD: v02 is **109,462
bytes**, well under `JOURNAL_SOFT_MAX` (262,144), so **no rotation is due** and
you must not create a v03. `claude_tb_writer_agent.md` is **volume 01 and is
FROZEN** — appending to it breaks R3/R10 and the chain hash. Append to v02 only.

---

## 8. Pass criteria — and B-2 and B-3 are BARS here, not debts

1. **Three items, all members green, no unpromoted drift** (`dune runtest` green
   **and** `git diff --exit-code` clean).
2. Every expected value derived from spec text **and** cross-checked against
   `Injection.outcomes`, with **both** visible in the source (§2 bar 2).
3. **BAR B-2 — cross-check depth is M03-B4's, on every new member.** The
   following/clean frame is cross-checked against `Dv_xgmii.Injection.outcomes`
   on **all five delivered-side fields plus `received`**: `received`,
   `delivered`, `words`, `last_tkeep`, `tlast_cycle`, `abort`. The suite's
   standing depth for a following clean frame is `delivered` + `reports` **only**
   — two fields — measured at HEAD at `test_m03_h.ml:244–256` and `:476` (note
   B-2 cites `:307`/`:539`, which are **pre-`WO-0064` line numbers and are stale**;
   the described fact is unchanged). **That standing depth is not sufficient
   here** and a member that uses it fails this bar.
4. **BAR B-3 — frames must be discriminable by content.**
   `Bench.directed_frame_octets ~length` is deterministic in `length`, so two
   64-octet frames carry the **same 64 octets** and a content comparison cannot
   distinguish *frame 2 delivered correctly* from *frame 1's content delivered in
   frame 2's place*. **Every two-frame stimulus in this packet** must either give
   the two frames **different declared lengths** or build them with
   `Injection.frame_of_length ~sequence` so they differ, and the member must say
   at its own site which mechanism it used. A member whose two frames are
   byte-identical fails this bar even if it is green.
5. Both landing sites verified for every injected character, and for M03-N2 the
   **same-word** guard as well (T12).
6. Every absence assertion carries its vacuity guard (`WO-0062` §2 bar 4).
7. **Exact strobe sets over the whole run** at every member (§2 bar 5, T9).
8. M03-B4 member (b) asserts frame B's **content**, not its count (§3.1).
9. The six sub-cases are **six**, each with its own derived tuple in a comment,
   and sub-case 4's four-octet delivery is asserted (T8).
10. Deliverables 4 and 5 present, **comment-only**: `git diff` on `bench.ml`,
    `bench.mli`, `injection.mli` and `idle_injection.mli` shows changed lines
    inside comments/docstrings and **nothing else** — no `val`, no type, no
    expression, no `[%expect]` movement.
11. Nothing outside the six deliverables is staged.

---

## 9. Pre-committed BOUNCE conditions

I commit to these before seeing the return, so the verdict is not written to fit
what arrives.

1. **Any M03-B4 member (b) comment, message or Return-log sentence claiming it
   closes `WO-0058` bound 7** (T1).
2. **Member (b)'s report pinned to cycle 3** — its own start word + 2 — rather
   than to cycle 4 (T3). This is the defect the member exists to expose, and a
   bench that commits it is asserting the thing it was written to detect.
3. **Any B2 `/I/` or `/Q/` member whose derived figures differ from the landed
   `/E/` members' and which reconciles the difference instead of reporting it**
   (T5).
4. **Fewer than six M03-N2 sub-cases**, or six sub-cases that do not span all
   three discriminators, or any sub-case without its derived tuple stated.
5. **Any `tuser`[0] assertion on a frame with no `tlast` word** (T7) — on
   sub-cases 3 and 6, on either B4 member, or on any B2 member.
6. **A lower-bound strobe assertion anywhere** ("at least one …"), or any
   sub-case that does not assert `error_bad_fcs`'s absence (T9).
7. **Any claim that this packet tests SPEC-M03 §6.3 item 8**, or that a `/Q/`
   member tests REQ-113's ordered-set case (T10, §3.2.1).
8. **A cycle derived from `injection.mli` or `idle_injection.mli`'s docstrings**
   rather than from SPEC-M03 §6.1's landed table (T11) — including a repair at
   §6.1 debt 4 that re-states the withdrawn clause in new words.
9. **Any non-comment change** in `bench.ml`, `bench.mli`, `injection.mli` or
   `idle_injection.mli`, or **any** change in `test_m03_h.ml`, `test_m03_e.ml`
   (`run_e5` in particular), `test_m03_i.ml`, or `AP-xgmii_rx_64.md`.
10. **A new member with the suite's standing two-field cross-check depth** (bar
    B-2) or **two byte-identical frames in one stimulus** (bar B-3).
11. **A journal entry listing any `libs/**` or `rtl_snapshots/**` path in
    `Inputs`**, or an entry appended to the frozen volume 01.
12. **Unpromoted expect drift** at the tree handed back.

A BOUNCE returns the defect list with file:line and respawns as a new ISSUED
revision; it is not a judgement on the work, it is the packet's own contract
doing what it was written to do.

---

## 10. What this packet does not close

- **`SO-xgmii_rx_64.md` does not issue and is not offered.** **42** of the plan's
  62 ASSERT rows carry a discharge today (`J-dv_lead-0109`, measured from the
  tree). This round should move that to **43** by discharging M03-N2 — B2 and B4
  are already inside the count, because **qualification and member-addition move
  no discharge count; only a row's first titled unit does.** That figure is
  **derived, not measured**, and the verdict for this round **must re-measure it
  from the tree** rather than inherit it — a number can be right and its cause
  wrong, and the cause is the part a later reader reasons with.
- **The plan is not edited in this packet's commit and cannot be.** §4.B's cells,
  notes B-i and B-ii, §4.N's closing note, §6's REQ-102 and REQ-110 entries and
  §9's change log all need edits when this work lands — including striking the
  two no-coverage marks and discharging note B-ii obligation 1 with §3.2.1's
  ruling. Those are **dv_lead's**, and they ride the `RV-0065` round.
- **M03-N2's two standing prohibitions stay in force until the unit LANDS.** No
  `SO-` may cite M03-N2 as coverage of REQ-102 or REQ-110, and no campaign may
  place it in a denominator, until the row is discharged and the plan says so.
  Issuing this packet lifts nothing.
- **Nothing here is mutation-qualified by being written.** These members enter a
  denominator for the first time at the next freeze, and no claim about what they
  kill may be made before a campaign scores them (`WO-0058` §8's weighting
  paragraph governs).
- **`WO-0061` §8 bound 1's `tkeep` half** at an injected run stays unmeasured;
  nothing here touches family I's instruments.
- **`run_i2_member`'s deliberate citation exception** stays as it is: its string
  is quoted verbatim in a scored campaign's frozen seal, and repairing it would
  falsify that seal. It is not this packet's and must not be touched.
- **Family J** stays behind a bench-capability round (§1).
