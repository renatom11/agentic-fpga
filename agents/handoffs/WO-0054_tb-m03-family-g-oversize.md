# WO-0054: Family G — oversize frames (REQ-108), and the constant that is not the frame's

- **State**: **DRAFT** (dv_lead-authored; the orchestrator issues)
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's **`Discard`**
  row and the `Frame` row's exits, §6.3 item 6, §7, §9 (the **second**, **sixth**
  and **seventh** co-occurrence rulings and the strobe-cycle pin), §10's REQ-108
  hook **and its REQ-901 row**; `docs/specs/requirements.md` REQ-108, REQ-103,
  REQ-104, REQ-105, REQ-110, REQ-008, REQ-011, REQ-015, §0.3, §0.6, §0.7.
- **Rows**: **six.** `AP-xgmii_rx_64.md` §4.G — **M03-G1, G2, G3, G4, G6**
  (ASSERT) and **M03-G5 (NO-ASSERT — declared, not built, §3.4)**.
- **Deliverables**: `test/xgmii_rx_64/test_m03_g.ml`, plus any bench addition §5
  authorises and nothing else.

---

## 1. What this family closes, and what it cannot borrow

### 1.1 Nothing in the suite has ever driven a frame longer than 1518 octets

M03-C3 drives **1518** — the legal maximum — and M03-C5 drives 1513 and 1516.
**No unit anywhere drives 1519 or above**, so every REQ-108 observable is
unverified in both directions today.

> **The silently-always-pass class for this family is: an oversize frame
> truncated correctly, at exactly the right octet, and never reported.**
> REQ-008 forbids silent discard and §9 requires the `error_oversize` pulse;
> **nothing in the bench today would notice.** That is **G-c5** in §7, and it is
> what this packet exists to close.

### 1.2 The co-simulation lane cannot help you here, and that is settled

REQ-901's declared divergence class **(f)** excludes a frame exceeding 1518
octets **entirely — including the octets between the truncation point and the
next start character**. Inside that exclusion the co-simulation anchors nothing,
**a sign-off packet SHALL NOT offer a co-simulation result as REQ-108's external
anchor**, and an exclusion is never a licence to take an expected value from the
reference (ADR-0015 D2). Ruled at `J-dv_lead-0060`; the scope is at the plan's
§4.G family note.

**The consequence for you is simple and freeing: the directed rows below are the
whole of REQ-108's verification.** There is no later run that will confirm them
and none you are waiting on.

### 1.3 This family has no no-output-word frame, and you may not borrow the claim that says otherwise

Every oversize frame here delivers **1514 octets**, so every one of them has a
`tlast` word and every strobe in this family is pinned to **its own frame's
`tlast` cycle**, §9's ordinary pin. **M03-G6's "no output word between the
truncation point and the next start character" is a statement about an
*interval*, not about a no-output-word frame**, and it must be asserted as such.

> **Binding, and stated because a neighbouring claim of mine is currently
> unsafe**: `WO-0047` §1.2's shared-no-output-path claim is **UNESTABLISHED and
> uncitable** (`J-dv_lead-0065`, §8 item 5 of the plan). **No row here may rest
> on it, and none needs to** — see the paragraph above; family G's pins are
> ordinary. If you find yourself reaching for it, that is a signal you have
> mis-derived a pin, not a licence.

---

## 2. The trap of this family, stated before anything else

**It is the fourth stimulus trap in four families and it is the sharpest, because
it produces a false DUT finding rather than a crash.**

`Dv_xgmii.Frame.delivered` implements **REQ-103's FCS removal** — "every octet
from the first destination-address octet through the last octet before the four
FCS octets". Every family before this one calls it, correctly.

**REQ-108 says no FCS stripping is attempted on a truncated frame.** A frame
above 1518 octets is truncated at exactly **1514 delivered octets**, and those
are the frame's **first 1514 octets as received** — the FCS is neither removed
nor present at the truncation point.

> **So `Frame.delivered` is the WRONG oracle for every truncated member of this
> family.** On a 1519-octet frame it returns **1515** octets, one too many, with
> `tkeep` = 0x07 where the truth is 0x03. A row built that way **fails a
> conformant design** and reads exactly like a REQ-108 defect while being
> nothing of the kind.

**And the trap is baited, which is why it gets its own section.** At **1518** —
the legal maximum, M03-G2's first member — `Frame.delivered` is **right**, and it
returns 1514, because 1518 − 4 = 1514 is arithmetically the same as the
truncation constant. **One helper gives the right answer for G2's first member
and the wrong answer for its second.** A worker who picks one helper per row
rather than per member gets the sharpest row in the family wrong by one octet.

**Deliverable (§8): state, per member of every row, which clause governs its
delivered set — REQ-103's removal or REQ-108's truncation — and cite it.**

---

## 3. The rows

### 3.1 M03-G1 — a 1600-octet frame followed immediately by a valid 64-octet frame (ASSERT)

Exactly **1514** octets delivered; `tuser`[0] = 1 on the `tlast` word; **exactly
one `error_oversize`** and no other strobe; **no `error_bad_fcs`** (§9 ruling 2);
the following frame received **intact and complete**.

**Governance**: REQ-108's truncation. Delivered = the frame's first 1514 octets.
**Kills**: truncation at 1518 delivered (the received-count constant used as the
delivered-count constant), and a design that resynchronises only on `/T/` and
loses the next frame.

**Note for free, and use it**: `Protocol_monitor`'s standing
`~max_words_per_frame:190` is exactly the bound a correct truncation produces
(1514 = 189×8 + 2 → **190 words**, final `tkeep` = **0x03**). A design that fails
to truncate emits more and the standing monitor fires — so the monitor is a
**second, independent** detector of this row's headline kill, and you should say
in the Return log whether it or the row's own count assertion speaks first.

### 3.2 M03-G2 — the adjacent pair 1518 and 1519, both lanes (ASSERT)

**The strongest row in the family**, for the reason the plan gives: both deliver
exactly **1514** octets, so **only the strobe, the abort bit and the FCS verdict
separate a legal maximum frame from an oversize one.**

- **1518**: no strobe, `tuser`[0] = 0, FCS verdict **good**. Governance:
  **REQ-103's removal**.
- **1519**: exactly one `error_oversize`, `tuser`[0] = 1, and **no
  `error_bad_fcs`**. Governance: **REQ-108's truncation**.

**Drive both at both start lanes.** I am scoping the lane axis in the row text
this time rather than leaving it to a Return-log question, which is what it cost
at M03-D2 and M03-F2.

**Cross-check available and worth taking**: M03-C3 (`test_m03_c.ml`) already
drives 1518 at both lanes and asserts 1514 octets in 190 words. **Derive your
1518 member independently and then compare against C3's constants**, reporting
the comparison — do not import them.

### 3.3 M03-G3 and M03-G4 — the resynchronisation window (ASSERT)

Both take the 1600-octet frame and inject one character **100 octets past the
truncation point**:

- **M03-G3**, a new `/S/`: exactly one `error_oversize` and **no
  `error_start_without_terminate`** (§9's sixth ruling, C-12); the new frame is
  received normally.
- **M03-G4**, an `/E/`: exactly one `error_oversize`, **no `error_bad_frame`**
  (§9's seventh ruling, C-12); nothing emitted after the truncation; the
  following frame intact.

**Both rows' teeth are the NEGATIVE assertion** — the strobe that must *not*
pulse — so the exact-strobe-set check is the row, not a formality. Assert the set
exhaustively, as §9 ruling 9's precedent has family F do.

### 3.4 M03-G5 — NO-ASSERT. Declare it; do not build it.

"The **internal state** after absorbing the `/E/` in `Discard` is not asserted;
both encodings produce the pinned observable identically" (§6.3 item 6, C-12).
Declare it in the file in the shape `test_m03_d.ml` uses for M03-D4 and
`test_m03_a.ml` for M03-A4 — a comment stating what is deliberately not
asserted and the clause that forbids it. **No code.**

### 3.5 M03-G6 — a 1600-octet frame never closed before the next `/S/` (ASSERT)

No output word and **no strobe of any kind** between the truncation point and the
next start character, whatever arrives. Kills a design that emits the tail of the
discarded frame, or pulses a second strobe on an eventual `/T/`.

> **§2's rule applies to me here and I am obeying it: I specify the observable
> and leave the mechanism to you.** The stimulus in specification terms is *a
> frame exceeding 1518 octets that is not closed by a terminate character before
> the next start character arrives*. **I do not know whether
> `Dv_xgmii.Injection`'s catalogue can express it** — `placement` offers
> `At_preamble`, `At_octet` and `At_terminate`, and `Place` *replaces* a
> character rather than removing one.
>
> **Establish whether it can, and RETURN THE QUESTION rather than inventing
> machinery.** If it takes a bench addition, §5 applies: return the request, do
> not add it. A row built on machinery I did not authorise and you did not flag
> is how a stimulus defect enters as a silent assumption — and I have now put a
> worker into a wall once by specifying a mechanism I had not traced
> (`RV-0047-VERDICT` §1).

### 3.6 The §0.6 strobe window — the convention, and the one case it does not decide

**New rows use the literal §0.6 formula** (`RV-0047` ruling 2, standing): not
earlier than the cycle the condition first becomes decidable; not later than
ΔC = 3 after the input word carrying the frame's **last received** octet.

**For M03-G6 that upper bound is not computable from the frame alone**, because
the frame has no last octet until the next start character arrives. **Ruling, on
`RV-0047` ruling 2's own ground**: the window is a *secondary* bound — every row
asserts its pinned cycle **exactly** in its own `error_pulses` check, and a
looser window admits nothing the exact check would let through. **So for G6 use
the widest defensible upper bound** (the octet before the next start character,
or the run's end), **state which you used and why**, and let the exact pin carry
the assertion. Raised for the architect as §9 open question 1 either way.

---

## 4. Sampling, ordering, and the two things the F campaign taught

1. **Assertion order is part of a row's contract** (`WO-0047` §4.2). State each
   row's order and each loop's iteration order in the Return log. **The first
   failing assertion is what a mutation campaign is scored against**, and at
   WO-0050 the difference between two defect classes was *which assertion
   spoke*, not which row died.
2. **Iteration order decides the message where a row loops** — F-c3 and F-c5 hit
   the same unit at different loop indices and that distinction carried a
   finding. If a G row sweeps lanes or lengths, say which member runs first.
3. **Order structural first, specific after**: word count → `tlast` cycle →
   `tkeep` → `tuser` → delivered content → exact strobe set. The strobe set is
   this family's whole point in G3/G4/G6, so it goes last where it is the claim.

---

## 5. Machinery

`Bench`'s exported surface is bounded as before, and `RV-0043-VERDICT` §7 is
precedent: **the budget bounds `Bench`'s exported surface, not a row's own
helpers.** Expect a file-local helper for the truncated-frame extent.

**Two things to establish and report rather than assume:**

- **The latency tagger on a truncated frame.** `AP` §7's **X-5** was built at
  WO-0033 to give `Octet_time.Latency.frame_out` a per-frame expected output
  extent, precisely because the clean-frame identity (`output = input − strip −
  tail`) is false for truncated and aborted frames. **Family G is the first
  family to truncate.** Confirm X-5's entry point accepts a 1514-octet extent
  from a 1600-octet input and say so; if it does not, that is a finding to
  return, not to work around.
- **`Injection`'s reach for §3.5.** As above.

**If you believe an exported `Bench` addition is required, return the question
rather than adding it.**

---

## 6. What you may NOT read

- **Never open `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**`** — any path,
  manifests included. Scope every `grep` to `test/` and `docs/specs/`.
- Derive every expected value from **SPEC-M03 and requirements.md**, never from
  the design, and never from `Injection`'s **computed outcome model**. `AP` §7's
  X-1 row now separates the two halves explicitly: **the placement machinery is
  free to use; the computed outcome is an oracle and is gated.** Use it only as
  a **reported cross-check**, with the `fail_cross` idiom (`test_m03_e.ml`,
  `test_m03_f.ml`) — raises, names its finding class, routes to dv_lead, and
  bars resolution by adopting either side.
- **`docs/reports/audit/**` is out of bounds** for this packet.
- `test/third_party/**` holds the co-simulation reference. **It is not a source
  for any expected value here** and REQ-901 class (f) is why (§1.2).

---

## 7. Family G's qualification — five defect classes, ROW MAPPING SEALED

Qualified by a blinded campaign under the WO-0045/WO-0050 protocol. **The classes
are published so you write against them; which of your rows is predicted to catch
which is sealed before any diff exists.**

| | defect class |
|---|---|
| **G-c1** | truncation at the wrong count — 1518 delivered rather than 1514, the received-count constant used as the delivered-count constant |
| **G-c2** | the oversize threshold off by one — "more than 1518" implemented as "1518 or more", so a legal maximum frame is truncated and marked |
| **G-c3** | `error_bad_fcs` pulsed for a truncated frame, the residue checked at a truncation point where no FCS is present (§9 ruling 2) |
| **G-c4** | the `Discard` state not gated — a character arriving after the truncation point reopens the frame or re-reports it (C-12, §9 rulings 6 and 7) |
| **G-c5** | an oversize frame **truncated correctly and never reported**: no `error_oversize`, ever |

**G-c5 is the class this packet exists for.** It agrees with every content
assertion a correct design satisfies and violates only REQ-008 and §9. **Expect
it to look quiet — that is the defect class, not a weak diff.** The same warning
applied to D-M1, E-c5 and F-c5, and each was the mutation its campaign most
needed.

---

## 8. What I expect back

A Return log appended to this packet plus your journal entry. **Do not write an
`SO-`.** Structure it as WO-0047's: row disposition with no silence; what you
changed with file and line; every derivation with its spec section cited;
anything UNVERIFIED with the reason; expected CI as a labelled prediction; open
questions; and a scope statement with `git status --porcelain`, `git diff
--exit-code` on files you claim untouched, an explicit no-forbidden-path line,
and every `/root/.opam/**` read.

**Deliverables, not background:**

1. **§2's governance declaration** — per member of every row, whether REQ-103's
   removal or REQ-108's truncation governs its delivered set, with the clause.
2. **§3.5's answer** — whether `Injection` can express an unterminated frame, and
   the question returned if it cannot.
3. **§3.6's choice** — which upper bound you used for G6's window and why.
4. **§5's X-5 confirmation** — the tagger's behaviour on a truncated extent.
5. **§4's assertion and iteration orders**, per row.
6. **§3.1's answer** — whether the protocol monitor or the row's own count
   assertion speaks first when truncation fails.

## 9. Open questions I am carrying upward, not to you

1. **§0.6's upper bound for a frame with no last octet** (§3.6) — the formula
   names "the input word carrying the last octet of the offending frame", which
   an unterminated frame does not have until the next start character. Routed to
   architect_docs_lead as a scope question; **it blocks no row**, since the pin
   is asserted exactly and the window is secondary.
2. **`Protocol_monitor`'s `~max_words_per_frame:190` is exactly the truncation
   bound**, so at REQ-108 the monitor and the requirement coincide numerically by
   construction. That is convenient and slightly uncomfortable — a single wrong
   constant would move both. Noted for the campaign design, not for you.

## 10. What this packet does not do

`SO-M03` does not issue on family G. After it, **26 of the plan's 60 ASSERT rows**
would be discharged — G1, G2, G3, G4 and G6 newly, G5 being NO-ASSERT. Families
**H, I, J, K, M, N** and **L1–L5** remain unwritten. Per `J-dv_lead-0060`,
families F and G are **not** gated on the differential co-sim: REQ-901's classes
(e) and (f) mean the lane can never anchor REQ-107 or REQ-108, and these directed
rows are the whole of their verification.

---

## RETURNED — tb_writer (spawn `WO-0054/2026-08-03T17:55Z`)

**State**: RETURNED — no `SO-` claimed, no sign-off asserted. One deliverable
written (`test/xgmii_rx_64/test_m03_g.ml`, new), one file-header comment fixed
in the same directory (`test/xgmii_rx_64/dune`, §"scope statement" below),
plus this Return log and my journal entry `J-tb_writer-0013`. State left for
dv_lead: review and RV-.

### Row disposition (no silence)

| Row | Req | Disposition |
|---|---|---|
| M03-G1 | REQ-108, REQ-103 | ASSERT, built (`run_g1`), both lanes |
| M03-G2 | REQ-108, REQ-103, §0.3 | ASSERT, built (`run_g2_legal`/`run_g2_oversize`), 1518 then 1519, both lanes |
| M03-G3 | REQ-108, REQ-110, §9 ruling 6, C-12 | ASSERT, built (`run_g3`), both lanes |
| M03-G4 | REQ-108, REQ-105, §9 ruling 7, C-12 | ASSERT, built (`run_g4`), both lanes |
| M03-G5 | §6.3 item 6, C-12 | NO-ASSERT, declared (file footer, no code) — reuses M03-G4's stimulus, asserts nothing about the `Discard`/`Idle` encoding choice |
| M03-G6 | REQ-108 | ASSERT, built (`run_g6`), both lanes |

### §2's deliverable — the governance declaration, per member

The trap the packet names is real and is guarded against explicitly in code:
every truncated member below asserts delivered content as `List.take octets
1514` (the frame's own first 1514 octets), **never** `Frame.delivered octets`
(which implements REQ-103's identity and is wrong by one octet on every
member here that actually exceeds 1518).

| Row / member | Governs | Delivered | Oracle used |
|---|---|---|---|
| G1 — 1600-octet frame | REQ-108 truncation | 1514 | literal constant |
| G1 — following 64-octet frame | REQ-103 removal | 60 | `Frame.delivered` |
| G2 — 1518-octet member | REQ-103 removal | 1514 | `Frame.delivered` (coincides numerically with the truncation constant — the row's own sharp point) |
| G2 — 1519-octet member | REQ-108 truncation | 1514 | literal constant, **never** `Frame.delivered` (which returns 1515) |
| G3 — 1600-octet frame | REQ-108 truncation | 1514 | literal constant |
| G3 — resynchronised new frame | REQ-103 removal | 60 | `Frame.delivered` |
| G4 — 1600-octet frame | REQ-108 truncation | 1514 | literal constant |
| G4 — following frame | REQ-103 removal | 60 | `Frame.delivered` |
| G6 — 1600-octet frame | REQ-108 truncation | 1514 | literal constant |
| G6 — following frame | REQ-103 removal | 60 | `Frame.delivered` |

`truncated_delivered`/`truncated_words`/`truncated_tkeep` (1514/190/0x03) are
derived once, at file top, so every truncated member cites the same
computation. G2's 1518 member deliberately uses a *separately* derived
`expected_tkeep_for ~delivered:1514` rather than reusing `truncated_tkeep`,
even though the two numbers are identical, so the governance distinction
(REQ-103 vs REQ-108) stays visible in the code and not only in prose.

### §3.5's deliverable — can `Dv_xgmii.Injection` express an unterminated frame?

**Yes.** `test/xgmii/injection.ml`'s `create` function places no restriction
on `Place{placement=At_terminate; character}` beyond `is_control_char
character` — the `At_terminate` arm of the placement-validation match is a
bare `()` (lines 102–124), unlike `At_octet`'s lane-legality check and
`At_preamble`'s range check. `Xgmii_word.idle_char` is one of requirements.md
§2's five control characters, so `Place{placement=At_terminate;
character=Xgmii_word.idle_char}` is accepted without complaint: it replaces
the wire octet at exactly the frame's own natural terminate position with an
idle character, so no `/T/` ever appears on the wire for that frame — exactly
"a frame exceeding 1518 octets that is not closed by a terminate character
before the next start character arrives" (§3.5's own specification-terms
restatement). This was established by reading `injection.ml`'s own committed
source (already-sanctioned `test/` reading, never `libs/`), not invented, and
no bench addition or new `Injection` constructor was needed to answer it.

**`run_g6` does not build with it**, and the reason is stated in the file's
own header rather than left implicit: `Dv_xgmii.Arrival.terminate_octet_time`
already computes the exact same octet time with no `Injection` object at all,
so overriding it via `Bench.run`'s own `?word_at` hook (`test_m03_e.ml`'s
`run_e4` precedent, generalised) needs no `Injection.create` call, no
validation pass and no cross-check idiom for a fact the schedule already
hands the bench directly. This is a "simpler machinery already suffices"
finding — the same shape M03-E4's own trap answer 3 recorded — not a finding
that `Injection` cannot do it; §3.5's capability question and this file's own
construction choice are answered separately and are not conflated.

### §3.6's deliverable — the §0.6 window's upper bound for G6

**Superseded before this spawn began, and I used the newer citation rather
than the packet's own fallback.** `docs/specs/modules/xgmii_rx_64.md` §9
gained three paragraphs on 2026-08-04 (`J-architect_docs_lead-0021`),
explicitly captioned as answering *"dv_lead's row M03-G6, raised as
`WO-0054` §9.1 open question 1"*: the §0.6 window's reference word for a
frame no terminate character closes is the input word on which REQ-108's own
truncation closed it, fixed at the truncation cycle, independent of whatever
follows (and explicitly *not* an instance of carry-forward C-5's genuine
vacuity). This is **tighter** than §3.6's own instructed fallback ("use the
widest defensible upper bound") — every row in this file uses the tighter,
now-normative reference word: `not_before` = the cycle of the input word
carrying the 1519th received octet (array index 1518, zero-based);
`not_after` = that same cycle + ΔC (3). This is the identical shape at every
row (G1, G2's oversize member, G3, G4, G6), since every one of them truncates
via the same REQ-108 mechanism regardless of what follows. I did not need to
invent a "widest defensible bound" because the spec had already closed the
gap by the time I read it — flagged prominently in the file's own header so
a reviewer does not read my citations against the packet's own §3.6
framing and wonder why they diverge.

### §5's deliverable — X-5 confirmed

`Dv_monitors.Octet_time.Latency.frame_out`'s `?expected_octets` parameter
already names M03's own rows E1, F1, G1, G2, H1, H2 as its intended customers
in its own committed docstring (`test/monitors/octet_time.mli`), and
`test_m03_e.ml`'s `account_aborted_frame` already exercises it for a
partially-delivered extent (M03-E1). `account_truncated_frame` in this
file is the same primitive, called with the literal constant 1514 rather
than a per-row-computed one — confirming it accepts a 1514-octet extent from
an input trace many hundreds of octets longer (1519 up to 1700, across this
file's rows) exactly as its own docstring predicts. Nothing needed building
or changing; this is a confirmation, not a discovery, per §5's own framing.

### §4's deliverable — assertion order and iteration order, per row

All five built rows follow the same shape: **structural first, specific
after, the exact strobe set last** (word-count → the truncated frame's own
`tlast` cycle → `tkeep` → `tuser` → delivered content → the same five facts
for the row's second frame, where one exists → the exact strobe set across
the whole run). No row here reorders anything from an already-committed
sibling file. Iteration is lane 0 then lane 4 at every row, with M03-G2's own
inner order (1518 then 1519 ascending, the row's own "adjacent pair" wording)
the only row carrying a second axis.

### §3.1's deliverable — which speaks first, the protocol monitor or the row's own count assertion

**This file's own explicit word-count check speaks first**, at every row.
Each row function asserts `List.length words1 <> truncated_words` (or the
per-row equivalent) directly in its own body, well before
`assert_monitors_clean` — which is the only call that reaches
`Protocol_monitor`'s `~max_words_per_frame:190` — is invoked at the very end
of the function. A `fail` raise inside the row's own check therefore stops
the function before the protocol monitor is ever consulted. This falls out
of "structural checks first" (§4 item 3) applied literally, not from a
deliberate choice to race the two checks.

### M03-G3/G4's construction — stimulus choices considered and rejected

Neither row builds through `Dv_xgmii.Injection`, and the reasoning (with the
alternatives considered) is in the file's own header docstring in full;
summarised here. Both rows need a character to land some distance past the
truncation point (100 octets, per the row text). Three routes were weighed:

1. **Splice a self-contained second frame inside one longer array** (an
   `At_terminate`-shaped construction with a fake preamble and a genuine
   `Frame.with_fcs` tail spliced in). Workable in principle for M03-G3, but
   makes the "new frame"'s own FCS correctness a fact about exactly where
   the splice lands rather than about an independently-schedulable frame —
   rejected as more moving parts than the row needs.
2. **`Place` an injected character at `At_octet k` on a longer array, via
   `Injection.create`.** For M03-G3's `/S/` this is actually **impossible at
   the literal offset**: `At_octet`'s own validation additionally requires a
   placed `start_char` to land in lane 0 or lane 4, and content-index 1618
   ("100 octets past truncation" literally) is `1618 mod 8 = 2` at **either**
   start lane — REQ-101 forbids a start character there regardless of
   mechanism, so some rounding is unavoidable whichever route is taken. For
   M03-G4's `/E/` (no lane restriction) this route would work, at the cost of
   extending the base array well past 1600 octets purely to make index 1618
   addressable (`At_octet` requires the index to be in-bounds).
3. **An ordinary, separately-scheduled second `Arrival` frame, with a custom
   `ifg`, plus (for M03-G4 only) a single `?word_at` override for the stray
   `/E/` — no `Injection` at all.** This is what both rows use. It needs no
   array extension (M03-G4's array stays literally 1600 octets, matching the
   row's own words) and, for M03-G3, the "new frame" is a genuinely
   independent, ordinarily-scheduled `Arrival` frame — its FCS correctness is
   a structural fact about `Frame.with_fcs`, not about where a splice landed.

M03-G3's own `/S/` therefore lands at the **nearest REQ-101-legal offset** to
"100 octets past truncation" — content-index 1620 (102 octets past; 1618 and
1616 are equidistant, and 1620 mod 8 = 4 is the one this file picked),
verified at runtime against the schedule's own numbers rather than assumed.
M03-G4's `/E/` lands at the **literal** 100-octets-past-truncation octet
time, since `/E/` carries no lane restriction at all.

### A bug I found and fixed against my own first pass, worth recording

My first draft of every two-frame row (G1, G3, G4, G6) asserted the
following/new frame's `tkeep` as `0xFF`. That is wrong: the following frame
is 64 octets DA-through-FCS, delivering 60 octets, and 60 mod 8 = 4, so its
own `tlast` word's `tkeep` is `(1 lsl 4) - 1 = 0x0F`, not a full word.
`test_m03_f.ml`'s own `run_f4` computes this correctly for the identical
64-octet frame (`expected_tkeep1` via the same `if Int.rem delivered 8 = 0
then 0xFF else …` formula) — I had not re-derived it independently for this
file and instead pattern-matched the WRONG constant from a different row's
own tkeep (G1/G2's truncated member, whose 1514-octet delivery genuinely
happens to be a non-full word coincidentally shaped differently). Caught by
re-reading my own draft against `expected_tkeep_for`'s own formula (already
defined at file top for exactly this purpose) rather than by any compiler —
this container has no Hardcaml toolchain to catch a wrong constant that
still type-checks. Fixed at all four sites (`run_g1`, `run_g3`, `run_g4`,
`run_g6`) by introducing `expected_tkeep2 = expected_tkeep_for
~delivered:delivered2` and comparing against that instead of the literal
`0xFF`. Flagged here rather than silently corrected because it is exactly
the class of defect this container's own tooling (`ocamlc -stop-after
parsing`, syntax only) cannot catch, and because a wrong oracle here would
have certified a real M03 defect as a pass, or failed a conformant design,
depending on which way the RTL actually rounds.

### Cross-check taken, not imported — M03-G2's 1518 member vs `test_m03_c.ml`'s `run_c3`

Derived independently in `run_g2_legal`: `delivered = 1518 - 4 = 1514`,
`words = (1514 + 7) / 8 = 190`, `expected_tkeep = expected_tkeep_for
~delivered:1514 = 0x03`, `expected_tlast_cycle = start_cycle + 3 + 189`.
`test_m03_c.ml`'s `run_c3` (already-committed, already-accepted) drives the
identical 1518-octet frame and asserts 190 output words, `tkeep = 0x03` on
the last word, `tuser = 0`, no strobe — the same four facts, by a
byte-identical derivation path (§6.1's per-octet constant, §7's ΔC = 3). The
two agree. This file calls nothing in `test_m03_c.ml`; the comparison is
reported here, not executed as shared code, per WO-0054 §3.2's own
instruction ("do not import them").

### UNVERIFIED, and why

- **`dune build @default` / `dune runtest` for `test_m03_g.ml`**: UNVERIFIED
  locally. `test/xgmii_rx_64/` depends on `hardcaml_ethernet` (the DUT),
  which ADR-0005 keeps out of this container; `tools/precompile_check.sh`'s
  own LANE 3a still EXCLUDES this directory by name after this packet's own
  edit (confirmed by re-running it post-edit, Evidence below). CI's `dune
  build @default` / `dune runtest` is authoritative here, as at every prior
  round.
- **`ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_g.ml`**: run
  repeatedly through the drafting process (after the initial draft, after
  the dune-header edit, and after the tkeep fix above) — exit 0 every time,
  syntax only, no name resolution (ADR-0005).
- Every arithmetic claim in the file (the 1514/190/0x03 constants, M03-G3's
  ifg-to-content-offset derivation, M03-G2's 1518-member cross-check figures)
  was hand-traced against `test/xgmii/arrival.ml`'s own committed `create`/
  `round_up_4`/`terminate_octet_time` source before being written into the
  bench, not merely pattern-matched from a sibling row — the tkeep bug above
  is exactly the kind of error that survives pattern-matching and does not
  survive re-deriving from the formula.

### Expected CI (labelled prediction)

- `dune build @default`: **predicted green**. Every call site was checked
  field-by-field against `bench.mli`'s and `Dv_xgmii`'s/`Dv_monitors`' own
  committed `.mli` signatures, not pattern-matched against a sibling file
  without checking the signature — see the tkeep-bug note above for the one
  place pattern-matching alone would have shipped a wrong oracle.
- `dune runtest`: **predicted green with empty `[%expect]` blocks** — no
  promotion performed or owed (every block is `{||}`). If CI prints
  non-empty output at any of the five new blocks, that is either (a) a
  genuine M03 finding, most legibly at G-c5 or G-c1's own class (§7's own
  warning that these look quiet is heeded), or (b) an arithmetic error in
  this packet's hand-derivation despite the re-derivation discipline above —
  either way a finding to report, not something to fix by promoting.

### Open questions

None new. WO-0054's own two open questions (§9.1) were both already resolved
by the time of this spawn: item 1 (the §0.6 window's reference word for
M03-G6) by `J-architect_docs_lead-0021`, used throughout this file rather
than the packet's own fallback (§3.6's deliverable, above); item 2 (the
`Protocol_monitor`/REQ-108 numerical coincidence) was explicitly "not for
you" in the packet's own text and is untouched here.

### Scope statement

```
$ git status --porcelain
 M test/xgmii_rx_64/dune
?? test/xgmii_rx_64/test_m03_g.ml
$ git diff --stat -- test/xgmii_rx_64/dune
 test/xgmii_rx_64/dune | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)
$ git diff --exit-code -- . ':!test/xgmii_rx_64/dune' ':!test/xgmii_rx_64/test_m03_g.ml'
(exit 0 — nothing else in the tree differs from HEAD)
```

The `dune` edit is two things in one hunk: my own required line (`WO-0054
G1-G4, G6 ASSERT, G5 declared`), and a repair of a **pre-existing**
staleness this file's own header found before I added mine — the standing
per-packet list was already missing WO-0043 (family E) and WO-0047 (family
F)'s own lines, the exact defect class the header's own comment warns
against ("this comment is wrong and a reader has no way to tell"). I did not
introduce that staleness (confirmed: `git diff` on `dune` shows only the
list additions, nothing removed that I did not add back correctly), and
fixing it in the same edit rather than adding G's line beside a
known-stale list seemed the less-wrong choice; flagged here as a
beyond-my-own-WO addition per this programme's own disclosure convention,
not a silent scope creep — dv_lead's call whether it should have been left
for a separate packet.

No path under `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**` was opened,
read or staged at any point in this spawn — confirmed by reviewing every
Read/Grep/Glob/Bash invocation of this session; none named those paths.
`/root/.opam/**` reads: none directly (the same `tools/precompile_check.sh`
internal LANE 2b consultation as every prior round, not a read I performed
myself).

Self-checks run (all clean except the pre-existing, unrelated network
obligation):
```
$ ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_g.ml   # exit 0
$ bash tools/precompile_check.sh   # ALL LANES PASSED; xgmii_rx_64 still EXCLUDED, unchanged
$ bash tools/dv_checks.sh          # every check that could run passed;
                                   # check_rfc1071_anchor.sh: OBLIGATION OPEN
                                   # (pre-existing, on record since J-dv_lead-0017/0018,
                                   #  unrelated to M03/family G)
$ (eval $(opam env); dune build @default)   # FAILS: ppx_hardcaml/hardcaml not found
                                             # (ADR-0005, confirmed absent, not merely assumed)
```

