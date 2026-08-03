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
