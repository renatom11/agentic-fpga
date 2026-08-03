# AP-M03 — attack plan for `Xgmii_rx_64`

- **Module**: M03 `Xgmii_rx_64` · spec `docs/specs/modules/xgmii_rx_64.md`
- **Status**: **OPEN** — committed before the first M03 bench, as charter §3 and
  ADR-0001 require. Rows are added by appending; no row is ever renumbered.
- **Spec basis**: SPEC-M03 **FROZEN at `f78766e`**, *plus every §13 row through
  the C-18 diff* — the frozen text and its recorded diffs together are the
  specification (WO-0024's own formulation). requirements.md §0.3, §0.4, §0.5,
  §0.6, §0.7, §1.1, §2 (REQ-101 … REQ-113), §12; SPEC-M01 §6.1/§6.3 (the stream
  encoding the output must obey); SPEC-M02 §6.1 + ADR-0006/ADR-0007 (the
  finished-value convention and the 1-to-8 `octet_count` domain M03 must never
  leave). Carry-forwards realised as rows: **C-11**, **C-12**, **C-14.3**,
  **C-14.4**, **C-14.5**, **C-18**, **C-2**, **C-23**.
- **Derivation (PROTOCOL §10)**: every row below is derived from specification
  text alone. `libs/**` was not opened by the author of this plan, at this
  commit or at any earlier one. Where a row exists *because* rtl_lead returned a
  question (family N), the question is cited as a question — the expected
  observable in that row is derived from the specification, never from the
  answer rtl_lead gave.
- **Author**: dv_lead, journal `J-dv_lead-0013` (WO-0027)

---

## 0. What this document is, and the format it defines

This is the programme's **first** attack plan, so its shape is the template
every later `test/attack_plans/AP-<module>.md` follows. Sections 1 to 9 below
are the fixed skeleton; a later plan may add rows and families but not drop a
section.

An attack plan is **not** a test list. A test list says what will be run; an
attack plan says, for each attack, **which wrong design it kills**. That last
column is the one the plan exists for: a row whose "kills" cell says only "a
broken design" is a row that has not been thought about, and the auditor is
invited to mine this document for exactly that failure.

The plan is written **before** any bench, so that the bench is commissioned by
a reviewed adversarial argument rather than by whatever the bench writer
happened to think of. The `SO-` packet's coverage section maps each test back to
a row id here, and every row must end in one of: a named test, a declared gap,
or a NO-ASSERT/NO-STIMULUS ruling with the clause that forbids it.

## 1. Reading a row

Each row has six cells.

| Cell | Meaning |
|---|---|
| **Row** | Stable id, `M03-<family letter><index>`. Ids are permanent: a superseded row is struck in §9's change log and keeps its id; new rows append inside their family. Tests and `SO-` packets cite these ids. |
| **Attacks** | The REQ ids and specification sections the row attacks. A row that cannot name one is not an attack, it is an opinion. |
| **Stimulus** | What the link-partner model drives, in the specification's own units (octet times, lanes, frame lengths DA through FCS per §0.3). |
| **Observable** | Exactly what a bench asserts, at the ports only. Nothing internal ever appears here. |
| **Kills** | The wrong design this row detects, stated concretely enough that a reader can see the row fail against it. |
| **Status** | See below. |

**Status vocabulary** (the same six values in every plan):

- **ASSERT** — a bench must assert the Observable. The default.
- **NO-ASSERT** — the stimulus may be driven but the named property must **not**
  be asserted; the clause that forbids it is cited in the Observable cell.
  Asserting it would fail a conformant design, or would freeze an unconstrained
  choice into an accidental requirement.
- **NO-STIMULUS** — the stimulus must **not** be produced at all: it lies
  outside the space the specification constrains or outside REQ-018's
  link-partner contract.
- **RULING** — the frozen text does not decide the observable. The row records
  every reading and its consequence, and is **not asserted** until a ruling
  lands (the precedent is C-12, which `test/xgmii/arrival.mli` already held as
  NO-ASSERT until requirements.md settled it). A `RULING` row blocks no bench
  except its own.
- **GAP** — an attack this plan wants and cannot mount. The reason is named and
  the row is carried, not deleted, so a sign-off packet cannot claim the
  coverage by silence.
- **STRUCTURAL** — discharged by a compile-time or script check, not by a
  waveform. Recorded so no `SO-` claims a behavioural test that does not exist.

## 2. Standing obligations

These attach to **every** M03 bench and are not repeated per row.

1. **Protocol monitor** (`Dv_monitors.Protocol_monitor`) on the `rx` output
   stream, with `~max_words_per_frame:190` (REQ-015, SPEC-M03 §7). It carries
   REQ-011's contiguity and full-word rules and REQ-014's producer half.
2. **Frame-conservation monitor** (`Dv_monitors.Conservation_monitor`), §0.6.
   Two exemptions are **mandatory** and are C-2's machinery becoming
   load-bearing at its first module: a frame presented while `clear` = 1
   (REQ-009, family K) and a frame presented while `cfg_rx_enable` = 0
   (REQ-810, family J) are `frame_in_exempt`, never `frame_in`. A monitor
   without them fails a conformant M03 — that is not a hypothetical, it is what
   §7's "the one place in this specification where a frame vanishes without a
   strobe" means for a counter.
3. **Per-octet latency tagger** (`Dv_monitors.Octet_time.Latency`) configured
   `~strip_octets:8 ~tail_octets:4 ~front_offsets:[8; 12] ~ceiling:4`
   (REQ-102, REQ-103, SPEC-M03 §7, §1.1). Constancy is judged **per front-offset
   class**, never as one L across a two-lane run (§0.5 "Start lanes", C-15).
4. **Strobe accounting** follows requirements.md §0.6's counting convention as
   revised by **C-23**: a monitor counts **high cycles, never rising edges**.
   M03 is not exempt from that convention — see **M03-H4**, which produces two
   `error_start_without_terminate` events on consecutive cycles.
5. **Every frame the link partner emits is checked against the requirement it
   encodes before it is presented** (`Arrival.check`, `Frame.residue_ok`). A
   stimulus generator nobody has checked is an unverified assertion about the
   design.
6. **No bench reads `tdata` at positions where `tkeep` is 0, or any output field
   on a cycle with `tvalid` = 0** (SPEC-M01 §6.3 item 5, SPEC-M03 §6.3 item 4).

## 3. Stimulus legality

REQ-018 fixes the link partner's contract: it emits start characters **in lane 0
and lane 4 only**, including REQ-004's alternation; it injects each condition
named in REQ-104, REQ-105, REQ-107, REQ-108 and REQ-110; and it decodes
transmit-side XGMII. Three consequences bind every row below.

- A start character in a lane other than 0 or 4 is **never driven** (§6.3 item
  3, row M03-O4). Rows that would otherwise want one are re-expressed at lane 0
  or lane 4 or they are not written.
- The six preamble filler octets and the SFD octet may hold **any** value
  (REQ-102 forbids M03 from validating them), so no bench may assert on them at
  the receiver even though the model emits 0x55/0xD5.
- The inter-frame gap is measured **from the terminate character inclusive**,
  minimum 12 octets (§0.3). Every spacing figure in this plan is in that
  convention.

---

## 4. The rows

### 4.A Start detection, alignment and byte order — REQ-101, REQ-012, REQ-021, §6.1

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-A1** | REQ-101, REQ-103, §6.1 cycle table | One 64-octet frame, lane-0 start, gapless, correct FCS | 8 output words; words 0–6 `tkeep` = 0xFF, word 7 `tkeep` = 0x0F carrying octets 56–59 with `tlast` = 1 and `tuser`[0] = 0; output word m on cycle m + 3 counted from the start word; no strobe | A pipeline one cycle early or late (ΔC ≠ 3); an FCS strip that removes 4 octets from the wrong end | ASSERT |
| **M03-A2** | REQ-101, REQ-021, §6.1's lane-4 paragraph, **C-18** | The same 64 octets, lane-4 start (`/S/` in lane 4 of cycle 0; frame octets 0–3 in lanes 4–7 of cycle 1) | The same eight words with the same `tdata`/`tkeep`/`tlast`/`tuser` tuples; output word 0 on cycle 3; **FCS verdict good** (`tuser`[0] = 0, no `error_bad_fcs`) | **The C-18 defect made executable**: a design that treats the second preamble word of a lane-4 start as covering no frame octet holds the CRC register across frame octets 0–3 and fails the FCS check of *every* lane-4 frame. Also kills a barrel shifter that aligns to the input word rather than to the frame | ASSERT |
| **M03-A3** | REQ-101 | The directed length set of M03-C1 driven twice, once per start lane | Equality of the two runs as **ordered sequences of (`tdata`, `tkeep`, `tlast`, `tuser`) tuples over words with `tvalid` = 1** | A design whose lane-4 path drops or duplicates a word, or reorders octets within word 0 | ASSERT |
| **M03-A4** | REQ-101, §6.1, §10's REQ-101 hook | (same runs as M03-A3) | **The absolute cycle of the first output word is NOT asserted equal between the lanes.** §6.1: the equality M03 happens to achieve "is a property of the constants §7 pins, not an obligation, and a bench SHALL NOT assert it as one for other modules"; §10 repeats it for this module | — (a row that exists to stop a bench freezing an unrequired property into a snapshot) | NO-ASSERT |
| **M03-A5** | REQ-012, REQ-021 | A 64-octet frame whose octets are **position-dependent** (`Frame.stress_frame`'s default filler), at both start lanes | Frame octet j appears at `tdata`[8·(j mod 8)+7 : 8·(j mod 8)] of word ⌊j/8⌋; octet 0 at `tdata`[7:0] of word 0 | Lane reversal, a byte-swapped word, or a rotation by 4 at a lane-0 start — **all three are invisible under uniform filler**, which is why the filler is position-dependent and stated | ASSERT |

### 4.B Preamble and SFD — REQ-102, §6.1, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-B1** | REQ-102 | 64-octet frame whose six filler octets and SFD octet are arbitrary non-standard **data** values, both start lanes | The frame is delivered unchanged: same 60 octets, same `tkeep`, `tuser`[0] = 0, no strobe | A receiver that validates the SFD or the filler and drops a legal frame from a nonstandard-but-legal link partner (REQ-102's own reason for forbidding the check) | ASSERT |
| **M03-B2** | REQ-102, REQ-105, §0.7, §9 row 3 | `/E/` in a preamble position — lane 3 of a lane-0 start word, and lane 7 of the start word at a lane-4 start | **No output word at all** for that frame; exactly one `error_bad_frame` high cycle, on the cycle two after the input word carrying the `/E/`; the next frame is received intact | A design that recognises `/E/` only in `Frame` state and emits nothing *and* pulses nothing (a silent discard, REQ-008); and a design that emits a zero-octet word (`tkeep` = 0, REQ-011) | ASSERT |
| **M03-B3** | REQ-102, REQ-107, §0.7, §9 ruling 9 | `/T/` in a preamble position (lane 5 of a lane-0 start word) | No output word; **exactly one `error_runt` high cycle and no other strobe of any kind** (an exact set, strengthened from a lower bound by §9 ruling 9 at `1fe71ca` — this frame delivers zero octets and is therefore in the sub-5 class) at the pinned cycle; next frame intact | A design routing a preamble `/T/` to REQ-106 (which would either emit a frame from preamble octets or close silently); and, through the exhaustive strobe set, a design that runs the residue comparison at every terminate character (M03-M10) | ASSERT |
| **M03-B4** | REQ-102, REQ-110, §0.7 | `/S/` in lane 4 of a word whose lane 0 carried `/S/` (§10's own hook) | No output word for the first frame; exactly one `error_start_without_terminate`; the second frame is received intact and correct | A design that ignores `/S/` while in `Preamble` — it would mis-align the second frame by four octet times and deliver a corrupt frame with a good-looking `tkeep` | ASSERT |

### 4.C Frame extraction, terminate lanes and `tkeep` — REQ-103, REQ-106, REQ-011, REQ-015

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-C1** | REQ-103, REQ-106, REQ-011 | Frames of **64 … 71 octets** DA through FCS, at **both** start lanes (16 frames) | Delivered octets = length − 4 (60 … 67); the eight `tlast` `tkeep` patterns 0x0F, 0x1F, 0x3F, 0x7F, 0xFF, 0x01, 0x03, 0x07 occur exactly once each; the terminate character lands in lane (length mod 8), covering all eight lanes; `tuser`[0] = 0 and no strobe throughout | An FCS strip that is right at one residue and wrong at others; a `tkeep` generator that saturates at 0xFF; a terminate decoder that only looks at lane 0 | ASSERT |
| **M03-C2** | REQ-106, §6.1's second non-instance, **C-18**, ADR-0007 | The subset of M03-C1 whose terminate character lands in lane k > 0 | The k octets in lanes 0 … k−1 of the terminate word are delivered, and the FCS verdict is good | **The C-18 twin**: a design that holds the CRC register on any word containing a control character loses k octets from the CRC and fails the FCS check of seven of the eight terminate lanes. Also kills a design driving M02 with `octet_count` = 0 on the lane-0 case (ADR-0007's prohibition) | ASSERT |
| **M03-C3** | REQ-103, REQ-015, REQ-011 | One **1518**-octet frame, both start lanes | 1514 delivered octets in **190** words — 189 words of `tkeep` = 0xFF and a final word with `tkeep` = 0x03 and `tlast` = 1; FCS verdict good; no strobe | A design whose one-word lookahead breaks at the maximum length; a REQ-015 monitor bound set to 189 or 191 | ASSERT |
| **M03-C4** | REQ-015, **C-11** | The 5-octet runt of M03-F1 | A **one-word** frame whose single word carries `tlast`, `tkeep` = 0x01 — legal on this stream, and the deleted REQ-015 sentence would have forbidden it | A protocol monitor that requires a word before every `tlast`; the exact assertion C-11 deleted from REQ-015 and from SPEC-M03 §7 | ASSERT |
| **M03-C5** | REQ-103, REQ-011, **BUG-0001**, prediction **P-1** | Frames of **1513** and **1516** octets DA through FCS, at **both** start lanes (4 frames), driven through the same outcome-table machinery as M03-C1 | Delivered octets = length − 4 exactly (**1509**, **1512**); the `tlast` word's `tkeep` = **0x1F** and **0xFF**; `tuser`[0] = 0; no strobe | **A BUG-0001 fix confined to the minimum-frame region.** The two lengths are chosen so the final output word's fill is k = 5 and k = 8 — the two values BUG-0001's invariant says over-deliver by +1 and +4 — three orders of magnitude away from the 64-octet region where the defect was found, so a fix that repairs the neighbourhood rather than the rule fails here. **1516 at lane 4 additionally has terminate_lane = 0 with a full final word**, making it the second instance of R-1's observation class and the place that account is tested away from length 68 | ASSERT |

### 4.D The FCS check — REQ-104, §6.1

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-D1** | REQ-104, §9 row 1 | A 64-octet frame with **one payload bit flipped** after the FCS was computed, both start lanes | The same 60 octets delivered (the frame is forwarded in full, REQ-005), `tuser`[0] = 1 on the `tlast` word, exactly one `error_bad_fcs` high cycle **on the `tlast` cycle** (§9's pinned cycle), no other strobe | A design that drops a bad-FCS frame instead of forwarding it (store-and-forward by the back door); a design that reports on the terminate cycle instead of the `tlast` cycle | ASSERT |
| **M03-D2** | REQ-104, REQ-304 | Every good-FCS frame in this plan | `tuser`[0] = 0 and no `error_bad_fcs`, at all lengths and both lanes | A design that marks every frame invalid — the anti-vacuity partner of M03-D1, without which D1 passes against a design that always asserts the bit | ASSERT |
| **M03-D3** | REQ-104, §6.1's seeding rule, §6.1's drain paragraph | A **bad-FCS** 64-octet frame followed at the **minimum** 12-octet gap by a **good-FCS** frame (start-to-start 10 or 11 cycles, §0.3) | The bad verdict lands on the first frame's `tlast` word and the second frame is clean: `tuser`[0] = 0, no strobe | A design that reads the CRC register at the `tlast` cycle rather than carrying the verdict with the frame. §6.1 seeds the register in `Preamble`, and §6.1's drain paragraph puts the first frame's `tlast` word up to two cycles after its terminate word — so at the minimum gap the next frame has already re-seeded the register, and the wrong design reports the **second** frame's residue on the **first** frame's word | ASSERT |
| **M03-D4** | REQ-104, §6.3 item 1 | — | **The realisation is not asserted.** Residue-versus-capture is unobservable (§6.3 item 1); a bench asserts the verdict, never the mechanism | — | NO-ASSERT |

### 4.E Error character inside a frame — REQ-105, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-E1** | REQ-105, REQ-103's no-removal clause | `/E/` in **each of the eight lanes** of a mid-frame word of a 64-octet frame (8 frames, lane-0 start; repeated at lane-4 start) | The last delivered octet is the one immediately preceding the `/E/` (the REQ-106 rule with `/E/` in place of `/T/`, so `/E/` in lane 0 means the previous word carried the last octet); `tkeep` marks exactly those octets; `tuser`[0] = 1 on the `tlast` word; exactly one `error_bad_frame` on the `tlast` cycle; **no FCS removal** — the four octets before the error character **are** delivered | A design that applies FCS removal on the abort path (REQ-103 forbids it): it would deliver four octets too few and the row's octet-count assertion catches it at every lane | ASSERT |
| **M03-E2** | REQ-105, §0.7, §9 row 2 | `/E/` at exactly the frame's first octet position (zero delivered octets) | No output word at all; exactly one `error_bad_frame`, on the cycle **two after** the input word carrying the `/E/` — the cycle that frame's `tlast` word would have occupied | A design that emits a `tkeep` = 0 word, or a one-word frame of preamble octets, to have somewhere to put the abort bit | ASSERT |
| **M03-E3** | REQ-105, §0.6, §9's "aborted-and-forwarded versus discarded-before-emission" | (same as M03-E2) | A monitor asserting "every abort is marked on a `tlast` word" **must not be driven for this frame** — REQ-105's own verification column says so, and the frame is accounted for in §0.6 by its strobe | — (a bench-side rule, not a design property) | NO-ASSERT |
| **M03-E4** | REQ-105's closure clause, REQ-113, **C-12** | `/E/` **after** a terminate character, in the gap between two frames | Nothing emitted, **no strobe of any kind**, and the following frame received intact | A design whose `/E/` handler is not gated on frame-open: it pulses `error_bad_frame` for a frame already counted and breaks §0.6's conservation equation | ASSERT |

### 4.F Runt frames — REQ-107, §0.7

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-F1** | REQ-107, REQ-103 | Frames of **5, 16, 60 and 63** octets DA through FCS, correct FCS, both start lanes | 1, 12, 56 and 59 delivered octets; `tuser`[0] = 1 on each `tlast` word; exactly one `error_runt` per frame on the `tlast` cycle; **the FCS is removed and checked** — these frames end with `/T/`, so REQ-103 applies to them | A design that suppresses FCS removal on a runt (delivering four octets too many), and a design that suppresses the output entirely | ASSERT |
| **M03-F2** | REQ-107, §0.7, §9 ruling 9 | Frames of **0, 1 and 4** octets between start and terminate. The 4-octet frame's filler SHALL NOT be `00 00 00 00` — or both fillers are driven — for the reason M03-M10 gives | No output word at all; **exactly one `error_runt` and no other strobe of any kind** (an exact set, strengthened from a lower bound by §9 ruling 9 at `1fe71ca`), at the pinned no-output cycle | A design that emits a `tkeep` = 0 word; a design that attempts FCS removal on a frame with nothing to remove it from and underflows its counter; and, through the exhaustive strobe set, a design that runs the residue comparison at every terminate character (M03-M10) | ASSERT |
| **M03-F3** | REQ-107, REQ-104, §9's first co-occurrence ruling | A **63-octet** frame with a **wrong** FCS | **Both** `error_runt` and `error_bad_fcs` pulse once; `tuser`[0] is set **once** — it is one bit on one word, not one bit per condition | A first-match or precedence design that reports only the runt; and a design that sets the abort bit twice or widens the pulse | ASSERT |
| **M03-F4** | REQ-107, §0.3 | The adjacent pair **63** and **64** octets, correct FCS, both lanes | 63 → `error_runt` and `tuser`[0] = 1 with 59 delivered; 64 → no strobe, `tuser`[0] = 0, 60 delivered | The off-by-one threshold (`< 64` implemented as `<= 64` or as a delivered-octet rather than a received-octet count) — the two frames differ by one octet and by everything else | ASSERT |
| **M03-F5** | REQ-107, §0.7 | The 5-octet frame of M03-F1 | Exactly **one** delivered octet in one word (`tkeep` = 0x01, `tlast` = 1) | A design that treats "fewer than 5" as "fewer than or equal to 5" and emits nothing for the boundary frame REQ-107 requires to be forwarded | ASSERT |

### 4.G Oversize frames — REQ-108, §6.2's `Discard`, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-G1** | REQ-108, REQ-103 | A **1600**-octet frame followed immediately by a valid 64-octet frame | Exactly **1514** octets delivered; `tuser`[0] = 1 on the `tlast` word; exactly one `error_oversize`; **no `error_bad_fcs`**; the following frame received intact | Truncation at 1518 delivered (the received-count constant used as the delivered-count constant); a design that resynchronises only on `/T/` and loses the next frame | ASSERT |
| **M03-G2** | REQ-108, REQ-103, §0.3 | The adjacent pair **1518** and **1519** octets, each with a correct FCS over its own length | Both deliver exactly **1514** octets. 1518: no strobe, `tuser`[0] = 0, FCS verdict good. 1519: one `error_oversize`, `tuser`[0] = 1, **no** `error_bad_fcs` | The off-by-one on "more than 1518". The pair is adversarial precisely because the **delivered octet count is identical** — only the strobe, the abort bit and the FCS verdict separate a legal maximum frame from an oversize one | ASSERT |
| **M03-G3** | REQ-108, REQ-110, §9's sixth ruling, **C-12** | A 1600-octet frame in which a new `/S/` arrives 100 octets past the truncation point | Exactly one `error_oversize` and **no** `error_start_without_terminate`; the new frame is received normally | A design that treats the resynchronising start character as a second abort — it would double-count the frame against §0.6 | ASSERT |
| **M03-G4** | REQ-108, REQ-105, §9's seventh ruling, **C-12** | The same 1600-octet frame with an `/E/` injected 100 octets past the truncation point | Exactly one `error_oversize`, **no `error_bad_frame`**, nothing emitted after the truncation, following frame intact | The reading §9 row 2's condition text invited before C-12 landed: an `/E/` handler that reads "between the start and terminate characters" literally and pulses for a frame already closed and already reported | ASSERT |
| **M03-G5** | §6.3 item 6, **C-12** | (same as M03-G4) | The **internal state** after absorbing the `/E/` in `Discard` is not asserted; both encodings produce the pinned observable identically | — | NO-ASSERT |
| **M03-G6** | REQ-108 | A 1600-octet frame with **no** further character until the next `/S/` (no `/T/` at all) | No output word and **no strobe of any kind** between the truncation point and the next start character, whatever arrives | A design that emits the tail of the discarded frame, or that pulses a second strobe on the eventual `/T/` | ASSERT |

### 4.H Start without terminate — REQ-110, §9

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-H1** | REQ-110, REQ-103 | A 64-octet frame whose terminate character is **replaced by a new `/S/` in lane 0**, followed by a complete frame | The aborted frame's last delivered octet is the one immediately preceding the new `/S/`; `tuser`[0] = 1; exactly one `error_start_without_terminate`; **no FCS removed** (four octets more delivered than a clean frame of the same length); the second frame received intact | A design that strips the FCS on the abort path; a design that loses the second frame | ASSERT |
| **M03-H2** | REQ-110, REQ-101, REQ-021 | A new `/S/` in **lane 4** of a mid-frame word, i.e. lanes 0–3 of that word still belong to the aborted frame | Those **four** octets are delivered as part of the aborted frame (`tkeep` and the delivered count prove it); one strobe; the new frame begins at lane 4 and is received intact and correctly aligned | The highest-value row in this family: a design that switches its alignment offset on the **same** cycle it accepts the new start character rotates the aborted frame's trailing four octets by the *new* offset and **loses four delivered octets silently** — a REQ-008 hole with no strobe, invisible to every row that does not count the aborted frame's octets | ASSERT |
| **M03-H3** | REQ-110, REQ-105, §9's fifth ruling | `/E/` mid-frame, then a `/S/` two cycles later | Exactly one `error_bad_frame` and **no** `error_start_without_terminate`; the frame the `/S/` opens is received normally | A design in which `/E/` marks the frame but does not **close** it: the following `/S/` would then abort a frame that is already reported, breaking §0.6 | ASSERT |
| **M03-H4** | REQ-110, §0.7, §0.6's counting convention, **C-23** | `/S/` in **lane 0 and lane 4 of one word** (cycle c), then `/S/` in **lane 0 of the next word** (cycle c + 1), then a complete frame. Frame A opens at 8c and is aborted at 8c + 4, strictly inside its own preamble; frame B opens at 8c + 4, its preamble runs 8c+4 … 8c+11, and it is aborted at 8c + 8 — also strictly inside. Both are §9's zero-delivered row, and both start characters are in a contract-legal lane (§3) | Two zero-delivered aborts. §9's pinned no-output cycle — two cycles after the input word carrying the closing character — puts their `error_start_without_terminate` high cycles at **c + 2 and c + 3, consecutively**; no output word for either; the final frame is received intact | **A rising-edge strobe counter**: it sees one event where a conformant M03 reported two. C-23's convention was homed in §0.6 on M13's evidence and is stated there as generalising; this row is the proof that it is load-bearing at M03 as well, and it is the row that makes the strobe monitor's counting rule testable rather than assumed | ASSERT |

### 4.I Silence, ordered sets and idle — REQ-109, REQ-113, REQ-016

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-I1** | REQ-109 | 1000 idle cycles with no frame in flight | `tvalid` = 0 and all five strobes 0 on every one of them | A design that emits a spurious word or strobe out of an empty pipeline | ASSERT |
| **M03-I2** | REQ-109, §6.1's drain derivation, **C-14.3** | A 64-octet frame followed by idle | No output activity of any kind **from 3 cycles after the terminate word onward** — the tight ΔC − 1 = **2**-cycle drain window §6.1 derives, *not* ΔC | A real drain defect one cycle long. A bench using ΔC = 3 as the bound is one cycle loose and lets it through; that looseness is the defect C-14.3 removed from the specification and this row keeps out of the bench | ASSERT |
| **M03-I3** | REQ-113 | 100 cycles of a `/Q/` sequence ordered set between two frames, then a frame | No `tvalid`, no strobe during the ordered set; the frame after it compares **word for word** against the same frame received after idles only | A decoder that treats an unrecognised control character as data (it would open or corrupt a frame) | ASSERT |
| **M03-I4** | REQ-016, §6.1's gapless qualifier, **C-14.4**, **C-18** | The directed set of M03-C1 driven through an idle-injection wrapper at **0, 1 and 7** idle cycles inside the frame (§10's own figures) | The output **word sequence** is unchanged; the **per-octet** constant of §7 is unchanged (16 at lane 0, 12 at lane 4); every octet is delayed by exactly 8 octet times per injected cycle; FCS verdicts unchanged | A design that decodes an idle word inside an open frame as eight data octets: the CRC is then corrupted and **every** frame the wrapper touches reports a false `error_bad_fcs`. This is the C-14.4 hold rule made executable | ASSERT |
| **M03-I5** | REQ-016, §6.1, **C-14.4** | (same runs as M03-I4) | **§6.1's `m + 3` cycle formula is NOT asserted under injection.** It is scoped to a gapless stimulus in octet times; a bench asserting it under idle injection fails a conformant design. The gap-invariant quantity is the per-octet constant, and that is what M03-I4 asserts | — | NO-ASSERT |
| **M03-I6** | REQ-016, REQ-107, REQ-108, §6.2's `Frame` row | A 64-octet frame and a 1518-octet frame, each with **7** idle cycles injected between every pair of words | No strobe pulses at all: the octet counts governing REQ-107 and REQ-108 are unchanged by idle cycles, so neither frame changes class | A design that counts **cycles** rather than **octets** toward the runt and oversize thresholds. Under 7-cycle injection a 1518-octet frame occupies ~1500 cycles and the wrong design pulses `error_oversize`; the 64-octet frame is the anti-vacuity partner | ASSERT |

### 4.J Configuration — REQ-802, REQ-803, REQ-810, §4.3

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-J1** | REQ-810, §4.3 | `cfg_rx_enable` = 0 held, 100 frames injected (REQ-810's own figure) | No output word, no header effect and **no strobe** anywhere; the conservation monitor records all 100 as `frame_in_exempt` (C-2), not as discards | A design that gates the output but leaves the strobe path live — it would report 100 discards for frames it never accepted, and a monitor without the exemption would report a silent-discard hole where REQ-810 says there is none | ASSERT |
| **M03-J2** | REQ-803, §4.3 | `cfg_rx_enable` 0 → 1 at least one cycle before a start character; then frames | The first frame whose start character is accepted at least one cycle after the change is received correctly and completely | A design that samples the enable continuously and truncates the frame it just admitted | ASSERT |
| **M03-J3** | REQ-803, §4.3 | `cfg_rx_enable` 1 → 0 **mid-frame**, at least one cycle away from any start character; the frame ends with `/T/` | The in-flight frame **completes under the old value**: its words, its `tlast`, its FCS/runt verdict and its strobes are exactly those of the same frame with the enable held at 1. The **next** frame's start character is not accepted | A design that gates the datapath rather than the start character: it truncates the in-flight frame with no `tlast` and no strobe, which is a silent discard REQ-009 does **not** license (only `clear` may do that) | ASSERT |
| **M03-J4** | §4.3, §6.3 item 7, **C-14.5** | — | A change landing on the **exact cycle** of a start character has no determinate outcome and **SHALL NOT** be driven-and-asserted; every enable change in this plan is placed at least one cycle away from any start character | — | NO-STIMULUS |

### 4.K Reset — REQ-009, §7

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-K1** | REQ-009 | `clear` = 1 for 5 cycles while no frame is in flight | `tvalid` = 0 and all five strobes 0 on every `clear` cycle **and on the first cycle after it returns to 0** | A design whose strobe registers survive `clear`, or that needs a second cycle to settle | ASSERT |
| **M03-K2** | REQ-009, §7's reset bullet | `clear` asserted **mid-frame**, deasserted, and a new frame whose start character arrives on the **first** cycle after `clear` returns to 0 | The in-flight frame vanishes with **no `tlast` and no strobe**; the new frame is received correctly and completely. The conservation monitor records the abandoned frame as `frame_in_exempt ~reason:"clear"` — without that exemption a conformant M03 fails (C-2 at its first module) | A design that emits a `tlast` on `clear` (a phantom frame downstream); a design that needs one idle cycle before it can accept a start character; a monitor that counts the abandonment as a silent discard | ASSERT |
| **M03-K3** | REQ-009, REQ-015 | (same as M03-K2) | The protocol monitor's frame-in-progress state is reset on `clear` and **no assertion is made across the clear** | — | NO-ASSERT |

### 4.L Line rate, constancy and order — REQ-004, REQ-005, REQ-111, REQ-019, REQ-020, REQ-112, §8

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-L1** | REQ-004, §8 checks 1–2 | §8's stress run: **10 000** consecutive 64-octet frames, start lanes alternating 0 and 4, start-to-start spacing alternating **10 and 11** cycles, minimum 12-octet gap, zero error injection | 10 000 frames out for 10 000 in; every frame's 60 delivered octets equal the injected octets 0–59; the four-octet sequence numbers arrive 0, 1, 2, … with no gap and no repeat; conservation holds; no strobe pulses anywhere in the run | Word loss under sustained line rate — the only observable failure mode REQ-112 has (§10). A design with any internal backpressure or a one-cycle recovery between frames fails within the first hundred frames | ASSERT |
| **M03-L2** | REQ-005, REQ-111, §8 check 3, §0.5 | (the same run, through the latency tagger) | **One** L per front-offset class across all 10 000 frames: L = **16** at h = 8 (lane 0) and L = **12** at h = 12 (lane 4). Not a mean, not one L for the run | A design whose latency depends on frame content or on which frame it is; and a monitor asserting a single L across a two-lane run, which fails a conformant M03 on frame 2 (C-15 — observed, not hypothetical) | ASSERT |
| **M03-L3** | REQ-019, §1.1, §7 | (the same run) | Measured ΔC = (L + h)/8 = **3** in both classes, against the §1.1 ceiling of **4**; the one unspent cycle is reported as M03's reserve. The observed front offset of every frame is 8 or 12 and no other value | A ΔC computed from the octet-correspondence term instead of §0.5's front offset, which reports **2** at a lane-4 start and understates the hardest receive module by a cycle in its own sign-off packet (the WO-0012 tagger defect, fixed; this row keeps it fixed) | ASSERT |
| **M03-L4** | REQ-020, §8 check 2 | (the same run) | The delivered sequence is exactly 0 … 9999 | A design holding more than one frame, or reordering across the alternating start lanes | ASSERT |
| **M03-L5** | REQ-005, REQ-103, §8's directed set | Frames of 64 … 71 and 1518 octets at both start lanes (M03-C1, M03-C3) through the tagger | The same two constants as M03-L2 at every one of those lengths | A pipeline whose delay varies with the final `tkeep` residue — length-dependent latency that a fixed-length stress run cannot see | ASSERT |
| **M03-L6** | REQ-112, REQ-003 | — | The module exposes **no `tready`** on the stream under test and no `tready` input exists. Structural: a statement about the type, not an assertion that can fail (§8 check 4) | — | STRUCTURAL |

### 4.M Co-occurrence — §9's rulings, §0.6

Each row is one of §9's co-occurrence statements about which conditions may
co-occur, made into an assertion. Stimuli are reused from the families above.
**Row-index warning**: M03-M1 … M03-M8 correspond to §9's rulings 1 … 8
positionally, and **that correspondence ends there**. M03-M9 is the §0.6
inheritance row and predates the ninth ruling; §9's **ruling 9** is therefore
**M03-M10**, not M03-M9. The mismatch is deliberate — renaming a committed row
id would break this plan's own §5 citation of M03-M9 — and it is stated here
because the obvious inference is the wrong one.

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-M1** | §9 ruling 1 | M03-F3 | `error_runt` **and** `error_bad_fcs` both pulse once for one frame; `tuser`[0] set once | A precedence design | ASSERT |
| **M03-M2** | §9 ruling 2, REQ-108 | M03-G1 | `error_bad_fcs` does **not** pulse for the truncated frame | A design that checks the residue at the truncation point, where no FCS is present | ASSERT |
| **M03-M3** | §9 ruling 3, REQ-105 | M03-E1 | `error_bad_fcs` does **not** pulse for a frame ended by `/E/` | A design that runs the residue comparison on every frame closure regardless of how it closed | ASSERT |
| **M03-M4** | §9 ruling 4, REQ-110 | M03-H1 | `error_bad_fcs` does **not** pulse for a frame ended by a new `/S/` | (as M03-M3) | ASSERT |
| **M03-M5** | §9 ruling 5 | M03-H3 | Exactly one `error_bad_frame`; no `error_start_without_terminate` | A design in which `/E/` does not close the frame | ASSERT |
| **M03-M6** | §9 ruling 6 | M03-G3 | Exactly one `error_oversize`; no `error_start_without_terminate` | A design that re-opens a truncated frame | ASSERT |
| **M03-M7** | §9 ruling 7, **C-12** | M03-G4 | Exactly one `error_oversize`; no `error_bad_frame` | (the C-12 ruling, as M03-G4) | ASSERT |
| **M03-M8** | §9 ruling 8 | — | `error_runt` and `error_oversize` cannot co-occur: the octet ranges are disjoint, so **no stimulus exists** and none is written | — | NO-STIMULUS |
| **M03-M9** | §0.6, §9's closing paragraph | Every row in families E–H | M03 **inherits** no abort and never pulses a strobe to re-report one: it is the origin of `tuser`[0] on this chain, and there is no input bit to re-report | A design that would need this rule is not expressible at M03; the row is stated so no `SO-` claims §0.6's inheritance clause as tested coverage here. **Not §9's ruling 9** — see the row-index warning above | STRUCTURAL |
| **M03-M10** | §9 **ruling 9** (`1fe71ca`), §9's sixth row, §6.2's `Frame` row `/T/` exit, REQ-104, REQ-107 | **No new stimulus is owed**: M03-F2's 0-, 1- and 4-octet frames and M03-B3's `/T/` in a preamble position already drive the whole class. Drive them and assert the strobe set **exhaustively** | `error_bad_fcs` does **not** pulse for any frame of fewer than 5 octets between start and terminate: `error_runt` pulses **alone**, an exact set and not a lower bound. REQ-104 supplies neither operand for such a frame — no FCS is removed (§9's sixth row), so no comparison is made and there is no mismatch to report — and §6.2's `/T/` exit says the check is **not sequenced** in this class | A design that runs the residue comparison at **every** terminate character regardless of whether the frame had an FCS to check — M03-M3's kill one closure-class over. **The kill is sharp and it is not uniform across M03-F2's three lengths**: at 0 octets the register still holds §6.1 item 1's 0x00000000 seed, and at 1–3 octets a partial CRC, none of which equal REQ-304's residue, so the wrong design goes red; at **4 octets it depends on the filler**, and the single frame `00 00 00 00` yields exactly 0x2144DF1C and passes by accident. **A bench SHALL therefore use a non-zero 4-octet filler**, or drive both and assert the pair identically — an all-zero 4-octet frame alone is a vacuous test of this row | ASSERT |

### 4.N Questions returned by rtl_lead — WO-0024 Return log §6

These three rows exist because rtl_lead declared readings rather than leaving
them to be discovered (WO-0024 Return log §6, items 2–4). The **expected
observable in each row is derived from SPEC-M03's text**, independently of the
answer rtl_lead gave; where the text does not decide, the row is `RULING` and is
not asserted until the architect rules. That is the C-12 precedent, applied
before a bench exists rather than after one has been written against the wrong
reading.

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-N1** | §9's closure list, REQ-113, REQ-105 | Two closure characters in one input word where the **second arrives after the frame is already closed** and no frame is open: `/T/` in lane 0 and `/E/` in lane 5 | The `/T/` closes the frame normally (REQ-106, FCS checked); the `/E/` finds **no open frame** and produces nothing and pulses nothing (§9's third row, C-12) | A design evaluating every control lane of a word against the state the word *started* in | ASSERT |
| **M03-N2** | §6.1's "more than one event in one input word" paragraph and its cycle table, §9's closure-list clause (a) and §9's repaired "Strobe cycle, pinned" rule — all at `06c1eba`; REQ-102, REQ-107, REQ-105, REQ-110, REQ-101 | Two closure characters in one input word **W** where the second falls **inside the new frame's preamble**: `/S/` in lane 0 or lane 4 of W, and `/T/` (or `/E/`) in a higher lane of the same W. **Six sub-cases, not four** — the discriminators are the *aborting* start character's lane, the **aborted frame's own** start lane (it enters through §7's L) and whether the aborted frame delivered an octet; the table below this table enumerates them and each must be driven | **Reading (i) RULED (WO-0029 §3a), ENDORSED on a second independent ground (REQ-101, below), and now fully pinned.** The `/S/` aborts the open frame (one `error_start_without_terminate`, `tuser`[0] = 1 on its `tlast` where it emitted one, no FCS removed) and the `/T/`/`/E/` closes the frame that same `/S/` opened with zero delivered octets — no output word, one `error_runt` (REQ-107) or `error_bad_frame` (REQ-105). **Cycles, from SPEC-M03 §6.1's table**: the new frame's report is **W + 2** always; the aborted frame's is **W + 1** except when the aborting `/S/` is in lane 4 *and* the aborted frame began at lane 0, where it is **W + 2**; a zero-delivered aborted frame is **W + 2** at both lanes. So the two reports coincide in **three of the six** combinations, always under **different** strobe names — §6.3 item 8, which excludes only a same-name coincidence, has **no instance** here. **Both cycles are gap-invariant** (§7's per-octet constant pins one, the ending character's own word pins the other), and idle injection before W moves the two lane-0-`/S/` reports **earlier**, further from the new frame's and never onto it — so the coincidence column is injection-proof and the row may be run inside the M03-I4 wrapper. **Strobe set, exhaustive** (§9 ruling 9 at `1fe71ca`): on the zero-delivered sub-cases the two reports are **exactly** `error_start_without_terminate` (the aborted frame — no FCS check, §9 ruling 4) and `error_runt` (the new frame — sub-5 class, ruling 9), **and nothing else**; `error_bad_fcs` pulses for neither, which is what turns this row's strobe assertion from a lower bound into a count | Reading (ii), which rtl_lead declared and the ruling rejected: killed by the presence of the second strobe at all. Beyond it, the six sub-cases kill a design that reports both frames on one fixed offset from W regardless of the aborted frame's start lane or delivered count — the sub-case pair (lane-4 `/S/`, lane-0-started A) against (lane-4 `/S/`, lane-4-started A) differ by one cycle on otherwise identical stimulus and no other row separates them | ASSERT |
| **M03-N3** | REQ-016, REQ-102's third sentence, REQ-105, §6.1's preamble-position paragraph and §10's REQ-016 hook (both `541ea43`) | An idle word placed **between a frame's start character and its first octet** | **The stimulus is decided, not out of the specified space** — the architect declined dv's requested §6.3 sentence and gave something stronger (WO-0029 §3b), and the correction is accepted: an idle character in a preamble position is "any other control character" in REQ-102's third sentence, so it is routed to **REQ-105** and ends the frame with one `error_bad_frame` and no output word (§9's third row). The constraint that is actually owed binds the **wrapper**, and §6.1 and §10's REQ-016 hook now carry it: **the idle-injection wrapper of M03-I4 SHALL NOT inject between a start character and the frame's first octet.** The row therefore stays **NO-STIMULUS for the REQ-016 family**, now with a spec citation instead of an inference; the assertable case it makes available is REQ-105's, commissioned by §10's REQ-102 hook and carried at **M03-B2**. **Caveat carried as C-45**: at a **lane-0** start the whole preamble lies inside the start word (§6.1 says so in the same paragraph), so an injected idle word at the first inter-word boundary occupies **no preamble position** and is §6.2's ordinary C-14.4 hold — the prohibition is over-broad there and its stated ground does not hold at that lane. The constraint is honoured as written until the scope lands | A wrapper that injects uniformly across the whole frame including the preamble: at a **lane-4** start it puts idle characters in preamble positions 4 … 7 and measures REQ-105's abort while claiming to measure REQ-016's tolerance — a failure that is the bench's, not the design's | NO-STIMULUS |
| **M03-N4** | REQ-810 (revised `541ea43`), REQ-803, REQ-110, §4.3, §6.2's three rows, §9's closure-list clause (b), §10's REQ-110 and REQ-802/REQ-810 hooks, **ADR-0014** | `cfg_rx_enable` goes 0 **mid-frame**, and a new `/S/` (REQ-110's condition) arrives while it is 0, at least one cycle away from the change (§6.3 item 7, C-14.5) | **Reading (i) RULED (ADR-0014) and ENDORSED** — an enable gates the *admission* of a frame and nothing else. The commissioned observable, taken from §10's REQ-802/REQ-810 hook and not from the row's own prose: the in-flight frame is **aborted at the octet before the `/S/`** with `tuser`[0] = 1 on its `tlast` word (or **no output word at all** where it had delivered none), **exactly one** `error_start_without_terminate`, **no** output word for the frame that `/S/` would have begun, and the next frame received normally after the enable returns to 1. The ruling is decided **against the two requirements**, not against the implementation — and it is worth recording that the same activation rejected the same agent's declared reading on M03-N2. **Held at RULING for one reason only, and it is not this row's**: SPEC-M03's revisions are WITHHELD at WO-0030 on the M03-N2 defects, so the §4.3/§6.2/§9 text this row derives from is not yet in force. **Converted at `06c1eba` exactly as pre-committed at WO-0030, with no change to the observable**: the R1/R2 repair touches neither §4.3, §6.2, §9's clause (b) nor §10's hooks, which `git diff 541ea43 06c1eba -- docs/specs/` confirms in three hunks | Reading (ii): the open frame is carried across a character §6.1 routes to REQ-110 and its octet count absorbs a refused frame's octets, reaching M06 with a bad FCS or (past 1518) an oversize truncation. Also a design that gates the datapath rather than admission, which suppresses the in-flight frame's own remaining words and its report — the silent-discard hole REQ-810's next clause disclaims | ASSERT |

**M03-N2's report cycles — derived here at WO-0030, repaired into SPEC-M03 §6.1
at `06c1eba`, and re-derived by a second route at WO-0031.** The table below is
the bench's, and it is now also the specification's: §6.1's landed table matches
it row for row. Let **W** be the input word carrying the aborting `/S/`, **S**
the aborted frame **A**'s own start word. A's last delivered octet is the octet
immediately before the `/S/` (REQ-110): lane 7 of W − 1 for a lane-0 `/S/`, lane
3 of W itself for a lane-4 one, since a lane-4 start leaves lanes 0 … 3 of its
word to the aborted frame. Frame **B** — opened by that `/S/` and closed by the
`/T/` or `/E/` in a higher lane of the same W — delivers nothing, so §9's
repaired rule pins its report **two cycles after W**, always.

Two routes give the same six rows and the second is the one to keep:

- *Route 1, WO-0030's* — §6.1's gapless "output word m is emitted on cycle
  **m + 3** counted from the word carrying the start character". Correct, and
  **scoped to a gapless stimulus**, so it cannot be quoted inside the M03-I4
  wrapper.
- *Route 2, `06c1eba`'s and the one this plan now uses* — §7's **per-octet
  constant**: an output octet at lane k of input word U leaves on cycle
  `U + ⌊(k + L)/8⌋`, with L = 16 at a lane-0 start and 12 at a lane-4 one. That
  gives 2 for every lane when L = 16, and 1 for lanes 0 … 3 / 2 for lanes 4 … 7
  when L = 12 — which is exactly why **the aborted frame's own start lane is a
  discriminator**, and it is **gap-invariant**, so the table holds under idle
  injection as well. I verified both routes agree on all six rows.

| `/S/` lane | A's start lane | A delivered | A's `error_start_without_terminate` | B's `error_runt` | Same cycle? |
|---|---|---|---|---|---|
| 0 | 0 | ≥ 1 octet | W + 1 | W + 2 | no |
| 0 | 4 | ≥ 1 octet | W + 1 | W + 2 | no |
| 0 | either | 0 octets | W + 2 | W + 2 | **yes** |
| **4** | **0** | **≥ 1 octet** | **W + 2** | **W + 2** | **yes** |
| 4 | 4 | ≥ 1 octet | W + 1 | W + 2 | no |
| 4 | either | 0 octets | W + 2 | W + 2 | **yes** |

1. **Defect M03-R1 — a false universal in text a bench is told it may rely on.**
   §6.1's new consequence 1 ends "…and **only where it delivered no octet** do
   the two fall together, on different strobe names", under the heading "Two
   consequences a bench may rely on". Row 4 of the table above falsifies it.
   **Minimal witness**: A opens with `/S/` in lane 0 of word W − 1; word W
   carries A's octets 0 … 3 in lanes 0 … 3, a `/S/` in lane 4 and a `/T/` in
   lane 6. A delivers **four** octets, so its `tlast` word (`tkeep` = 0x0F,
   `tuser`[0] = 1) is output word 0 and leaves on (W − 1) + 3 = **W + 2**, and
   B's `error_runt` is also on **W + 2**. A bench following the sentence asserts
   the two are one cycle apart and fails a conformant M03. The parenthetical
   that precedes it — "the input word before a lane-0 start character" — is
   correct and is exactly the scope the closing clause drops.
2. **Defect M03-R2 — §9 pins B's strobe to two different cycles in one
   sentence.** §9's "Strobe cycle, pinned" reads: "For a frame that produces no
   output word, it pulses **two cycles after the input word carrying the
   character that ended the frame** — *the cycle on which that frame's `tlast`
   word would have been emitted*." For any frame whose ending character lies in
   its **own start word**, the two halves disagree by one cycle: the rule gives
   W + 2, while §6.1's m + 3 puts that frame's output word 0 at start word + 3 =
   **W + 3**. That class was a single instance before this ruling — REQ-110's
   own commissioned "`/S/` in lane 4 of a word whose lane 0 carried a `/S/`",
   frozen since batch A and **missed by me at `J-dv_lead-0005`** — and the
   ruling makes it a family. It is **already load-bearing on committed ASSERT
   rows**: M03-B2 drives `/E/` in lane 3 of a lane-0 start word *and* in lane 7
   of a lane-4 start word — both inside the frame's own start word — and pins
   the strobe "on the cycle two after the input word carrying the `/E/`", i.e.
   it has already chosen W + 2, resting on the half of §9's sentence that the
   other half contradicts; M03-B3 is the same shape and says only "at the
   pinned cycle", which §9 does not uniquely supply for it. B here is the third
   instance. The repair of R1 has to state cycles, and no cycle can be stated
   for B — or defended for B2 — while §9 says both.

Neither defect touches M03-N1, M03-N3 or M03-N4, and neither touches the
ADR-0014 material; the repair surface is two sentences.

**Both repaired at `06c1eba`, verified, and re-countersigned** (`J-dv_lead-0016`,
WO-0031). R1: the false clause is replaced by the six-row table above, derived in
the specification from route 2, carrying this row's minimal witness and stating
that the coinciding strobes always have different names. R2: the gloss is
**withdrawn**, on a ground stronger than "one half is normative" — the gloss
*cannot* be a rule, because a frame delivering no octet has no octet for §7's
constant to delay and the only thing that made the phrase look defined (`m + 3`)
is gapless-qualified while §10 commissions injection at 0, 1 and 7 cycles, so
reading it as the rule would leave a strobe cycle unpinned on a commissioned
stimulus. **M03-B2 and M03-B3 are vindicated, not moved**: W + 2 is now the only
reading of §9 for a frame ended inside its own start word.

Three things the repair added that this plan adopts rather than re-derives, each
checked here:

1. **The disagreement ran the other way too, in exactly one case** the WO-0030
   analysis did not reach: a **lane-4**-started frame whose `/T/` is in lane 0 of
   the *second* word after its start word — four octets received, none delivered,
   §9's sixth row — where the rule gives S + 4 and `m + 3` gives S + 3. I
   enumerated the no-output-word frames to confirm it is the only one: the ending
   character lies in S (differ, `m + 3` later), in S + 1 (agree), or, only there,
   in S + 2; nothing reaches S + 3, because fewer than five delivered octets puts
   every terminate character at or before lane 0 of S + 2 and REQ-105's and
   REQ-110's zero-delivered clauses reach only S + 1.
2. **That case sits at the far edge of requirements.md §0.6's window and inside
   it** — the frame's last octet is at lane 7 of S + 1 and ΔC = 3, so §0.6's
   bound is S + 4 and the report is on S + 4. Re-derived; it holds. **M03-I2's
   drain assertion is unaffected** (it is scoped to a frame that ends normally).
3. **The coincidence column is injection-proof.** Only the two lane-0-`/S/` rows
   depend on the word *before* W, so injecting an idle word there moves that
   report earlier and widens the separation; the coinciding rows are pinned to W
   itself or to the closing character's word and move with it. No injection turns
   a `no` into a `yes` or the reverse, so M03-N2 may be driven inside the M03-I4
   wrapper. **This is a different injection point from C-45's** (which is the
   first inter-word boundary after a *lane-0 start word*), so C-45 is untouched by
   the repair and carries unchanged.
4. **A fourth item the architect offered and I accept, rewidened — ledger
   C-47.** §9's rows 8 and 9 classify a REQ-110 abort by "≥ 1 octet already
   delivered" and "still inside its own preamble", and a frame that is **past its
   eighth preamble position with zero delivered octets** — the `/S/` landing
   exactly on the frame's first octet, lane 0 of S + 1 at a lane-0 start, lane 4
   of S + 1 at a lane-4 one — satisfies neither literally. The architect framed it
   as a hairline between two rows; it is sharper than that, and it has a model
   **in the same table**: §9's **row 3** states the REQ-105 sibling
   *extensionally* — "at or before the frame's first octet (including in a
   preamble position)" — which is exactly the phrase rows 8/9 want, and the two
   phrasings differ by precisely one octet time at each start lane. A **second
   site** the offer did not name: requirements.md **REQ-110**'s zero-delivered
   clause carries the same narrow gloss ("while the aborted frame is still inside
   its own eight preamble octets"), though its *governing* words ("Where the new
   start character leaves the aborted frame zero delivered octets") are
   extensional and therefore decide the outcome. **Nothing is ambiguous and no row
   of this plan is at risk** — REQ-110's governing clause plus §0.7 force no
   output word and one strobe for that frame, which is what M03-N2's rows 3 and 6
   and M03-B4 assert. What is missing is the row that says so. One phrase, and it
   is the R2 shape once more: a correct rule with a gloss narrower than itself.

**One correction against myself, and it is why the row says six and not four**
(`J-dv_lead-0016`). The table above has always been right, and the landed
specification follows it. My **prose** summary of it at WO-0030 — "three of the
four sub-cases", and "one cycle apart only for a lane-0 `/S/`" — collapsed a
three-axis classification onto two by dropping the aborted frame's **own** start
lane, and then quantified over the collapse: it reads row 4 (lane-4 `/S/`,
lane-0-started A, coincides) as the whole of the lane-4-with-delivery cell and
silently absorbs row 5 (lane-4 `/S/`, **lane-4**-started A, does **not**
coincide, W + 1 against W + 2). Of the **six** combinations, three coincide. The
architect flagged it; I concur. It is the same failure mode as C-44 — a
generalisation asserted over a table that did not support it — committed by me
twice in two activations, once about killability and once about my own arithmetic,
and it is the reason this plan now states the axes before the count.

### 4.O Structural and declared no-instance

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M03-O1** | REQ-003, REQ-010, REQ-112, §4.1 | — | Interface compile check: `O` carries `Axi64.Source` with no `Dest`, `I` carries no `tready`; the six `Source` field names witness (SPEC-M01 §11.4) | A hand-rolled stream record with the same fields | STRUCTURAL |
| **M03-O2** | REQ-014, §10's REQ-014 hook (repaired `541ea43`) | — | **No instance at M03 for REQ-014's differential run**, and SPEC-M03 §10 now says so in the form SPEC-M14 §10 uses for REQ-404/REQ-810 — the request is **landed and editorial**, so no re-countersignature was owed for it and the row's citation is now the specification rather than this plan's inference. REQ-014's verification column commissions "the same stimulus with `tstrb` = 0x00 and `tstrb` = 0xFF"; M03's input is an XGMII lane pair, which has no `tstrb` to vary (REQ-010 class (b)). The **producer** half — `tstrb` driven 0 on every output word — is asserted by the standing protocol monitor. The consumer half belongs to M06 | — (stated so no `SO-` claims REQ-014 whole at M03) | GAP |
| **M03-O3** | REQ-017, REQ-018, REQ-903, REQ-808 | — | Emitted-Verilog port names `xgmii_rxd`/`xgmii_rxc`; the module whitelist (`tools/check_emitted_verilog.sh`); `.mli`, `create` and `hierarchical` present; the module name appears in `rtl_snapshots/` | A record whose `[@rtlprefix]` drifted; an instantiated primitive outside the §4 inventory | STRUCTURAL |
| **M03-O4** | §6.3 item 3 | — | A start character in a lane other than 0 or 4 is **never driven** and nothing is asserted about it | — | NO-STIMULUS |
| **M03-O5** | §6.3 items 2, 4, 5 | — | Nothing is asserted about register placement, FSM encoding, counter direction, `tdata` where `tkeep` is 0, or any field on a `tvalid` = 0 cycle. §9's strobe **cycle**, by contrast, is pinned and **is** asserted (§6.3 item 5 says so explicitly) | A snapshot that freezes an unconstrained value into an accidental requirement | NO-ASSERT |

---

## 5. Attacks considered and rejected

Charter §8 requires the rejected list, because that is what the auditor mines
for blind spots. Each entry names why the attack is *not* a row.

1. **A random-frame fuzz campaign** (random lengths, random control-character
   placement, random gaps). Rejected as a *substitute*, not on principle: every
   observable in §9 is a function of the input trace, so a fuzz run needs the
   same golden model the directed rows need, and until that model exists a fuzz
   run can only assert protocol legality — which the standing monitors already
   do on every directed row. Revisit once the link-partner model can compute a
   frame's expected §9 outcome; at that point fuzz becomes cheap and is worth a
   row of its own.
2. **Asserting the absolute-cycle equality of the two start lanes** (M03-A4) —
   forbidden by §6.1 and §10.
3. **Asserting which FCS realisation is used** (M03-D4) — §6.3 item 1 makes it
   unobservable.
4. **A start character in lane 1, 2, 3, 5, 6 or 7** (M03-O4) — §6.3 item 3 plus
   REQ-018's contract. Driving it would commission a test for a stimulus the
   programme has decided not to produce.
5. **Two frames overlapping in the same word other than through `/S/`** — not
   expressible on an XGMII lane pair; the lane pair carries one character per
   position and §9's closure list is total over them.
6. **A gap shorter than §0.3's 9-octet DIC floor.** SPEC-M03 §2 says explicitly
   that reacting to a short gap is *nobody's* job on the receive path; a bench
   asserting anything about it would be asserting a requirement that does not
   exist. The link-partner model's own `check` refuses to emit one.
7. **`tuser`[0] driven on M03's input.** M03 has no input abort bit — it is the
   origin of the chain (§9's closing paragraph, M03-M9). The attack belongs to
   M06 and above.
8. **Asserting the CRC register's intermediate values, the `octet_count` M02
   sees, or the state M03 occupies in `Discard`.** All internal; ADR-0007's
   1-to-8 domain is enforced observably instead — by M03-C2 (a held CRC fails
   seven of eight terminate lanes) and M03-A2 (a held CRC fails every lane-4
   frame). This is the deliberate choice to attack an internal invariant
   **through** its observable consequence rather than by reaching inside.
9. **A frame longer than 1600 octets, or a 9000-octet jumbo.** REQ-108's
   behaviour is already exercised at 1519 and 1600; a longer frame adds cycles,
   not classes. If a `Discard`-state counter can overflow it does so at a length
   no requirement admits, and the attack would be against an unspecified space.
10. **Deliberately illegal `xgmii_rxc` patterns** (e.g. every lane marked
    control with data values). Outside REQ-018's contract; the closest legal
    attack is M03-I3's ordered set, which is a row.
11. **Preamble longer or shorter than eight octets.** §6.1 fixes it at exactly
    eight octet times from the start character inclusive; a different preamble
    is a different stimulus, not a variant of this one, and REQ-102 forbids the
    receiver from noticing the contents anyway. M03-N3 is the boundary of this
    argument and is a NO-STIMULUS row for the same reason.

## 6. Coverage map — REQ to rows

Every REQ SPEC-M03 §10 lists appears exactly once. A REQ with no behavioural
row carries the reason.

| REQ | Rows |
|---|---|
| REQ-003 | M03-L6, M03-O1 (structural) |
| REQ-004 | M03-L1 |
| REQ-005 | M03-L2, M03-L5, M03-I4 |
| REQ-007 | M03-D1, M03-E1, M03-F1, M03-G1, M03-H1 (set); M03-E3, M03-F2, M03-B2, M03-B4 (the zero-delivered cases where the bit has no word — §0.7) |
| REQ-008 | M03-B2, M03-B3, M03-B4, M03-E2, M03-F2, M03-G6, M03-H4 (every discard has a strobe); standing obligation 2 (conservation) |
| REQ-009 | M03-K1, M03-K2, M03-K3 |
| REQ-011 | M03-C1, M03-C3, M03-C4; standing obligation 1 |
| REQ-012 | M03-A5 |
| REQ-014 | standing obligation 1 (producer half); **M03-O2 declares the differential half has no instance here** |
| REQ-015 | M03-C3, M03-C4; standing obligation 1 |
| REQ-016 | M03-I4, M03-I5, M03-I6, M03-N3 |
| REQ-017, REQ-018 | M03-O3 |
| REQ-019 | M03-L3 |
| REQ-020 | M03-L4 |
| REQ-021 | M03-A2, M03-A5, M03-H2 |
| REQ-101 | M03-A1, M03-A2, M03-A3, M03-A4 |
| REQ-102 | M03-B1, M03-B2, M03-B3, M03-B4, **M03-N2** (the lane-0-start placement, where the whole preamble lies inside the start word — the instance the WO-0029 ruling turns on), M03-N3 (the idle-in-preamble routing) |
| REQ-103 | M03-C1, M03-C3, M03-E1, M03-F1, M03-G1, M03-H1 |
| REQ-104 | M03-D1, M03-D2, M03-D3, M03-D4, M03-M2, M03-M3, M03-M4, **M03-M10** (the sub-5 class, where REQ-104 supplies neither operand) |
| REQ-105 | M03-B2, M03-E1, M03-E2, M03-E3, M03-E4, M03-G4, M03-M5, M03-M7, M03-N1 |
| REQ-106 | M03-C1, M03-C2 |
| REQ-107 | M03-B3, M03-F1 … M03-F5, M03-M1, **M03-M10** |
| REQ-108 | M03-G1 … M03-G6, M03-M2, M03-M6, M03-M7 |
| REQ-109 | M03-I1, M03-I2 |
| REQ-110 | M03-B4, M03-H1 … M03-H4, M03-M4, M03-M5, M03-M6, **M03-N2** (the abort half), **M03-N4** (the abort under a disabled receive path, ADR-0014) |
| REQ-111 | M03-L2, M03-L5 |
| REQ-112 | M03-L1, M03-L6 |
| REQ-113 | M03-E4, M03-I3 |
| REQ-802, REQ-810 | M03-J1 … M03-J4, **M03-N4** |
| REQ-803 | M03-J2, M03-J3, M03-N4 |
| REQ-903, REQ-808 | M03-O3 |

## 7. Machinery this plan requires and does not have

Deliverable 4 of WO-0027: named here, **not built here**. Each is a candidate
for the next DV work order; the numbering is local to this plan.

| # | Machinery | Which rows need it | Note |
|---|---|---|---|
| **X-1** | **The link partner's error-injection catalogue** — REQ-018's second contract clause, deliberately deferred by `test/xgmii/arrival.mli` until this plan existed. Needs: per-frame corruption of one payload bit (bad FCS); replacement of the terminate character by `/S/` or `/E/` at a chosen octet time; placement of `/E/`, `/T/` or `/S/` at a chosen **preamble** position; over-length and under-length frames; and, per injected frame, the **expected §9 outcome** (delivered octet count, `tkeep`, abort bit, strobe name and pinned cycle) so a bench compares against the model rather than against hand-copied constants | B2–B4, D1, D3, E1–E4, F1–F5, G1–G6, H1–H4, M1–M7, N1 | The largest single item. Its expected-outcome side is what makes the fuzz campaign of §5 item 1 possible later |
| **X-2** | **An XGMII probe** — the `Xgmii_word`-to-live-port sampler, the counterpart of `test/axi64_probe/` on the wire side. `test/xgmii/dune` already records that it "lands with the first M03 bench" | every row | One function, same shape as `Axi64_probe.of_refs` |
| **X-3** | **A strobe monitor.** No monitor today counts strobes: `Conservation_monitor.strobe_pulse` is a call a bench makes by hand. Needed: (a) **high-cycle** counting per §0.6 as revised by **C-23** — never rising edges; (b) an **expected-cycle** check against §9's pinned cycles (the `tlast` cycle, or two cycles after the closing input word for a frame with no output); (c) the §0.6 window check; (d) "no strobe other than those the stimulus creates" | every strobe row; **M03-H4** is the row that makes (a) load-bearing at this module | C-23's convention was homed in requirements.md §0.6 on M13's evidence and stated there as generalising. M03-H4 is the second instance and the first on the receive chain |
| **X-4** | **An idle-injection wrapper** at 0, 1 and 7 cycles (§10's figures), with the **M03-N3 constraint** built in: injection never lands between a frame's start character and its first octet. The constraint now has a spec citation — SPEC-M03 §6.1 and §10's REQ-016 hook at `541ea43` — rather than this plan's inference, and the wrapper SHALL implement it as written even where **C-45** shows it over-broad (a lane-0 start's first inter-word boundary occupies no preamble position); if the scope lands, the wrapper gains that boundary back and M03-I4 gains a case | I4, I5, I6 | The constraint is the deliverable as much as the wrapper is |
| **X-5** | **A truncated-frame entry point on the latency tagger.** `Latency.frame_out` requires the output length to equal (input − `strip_octets` − `tail_octets`), which holds for a clean frame and is false for **every** aborted or truncated frame — families E, F, G and H all deliver a short frame. `frame_dropped` covers only the no-output case. Needed: a per-frame expected output extent | E1, F1, G1, G2, H1, H2 | Same repair serves M14 (see AP-M14 X-9), where the tail varies per datagram rather than per frame class |

Not gaps: `Conservation_monitor`'s exemption machinery (C-2) exists and is used
by M03-J1 and M03-K2; `Protocol_monitor`'s `max_words_per_frame` covers
REQ-015's 190; `Latency`'s three-quantity split (WO-0012) is what M03-L3 asserts
against; `Frame`/`Arrival` already produce the §8 stress schedule and check
themselves against §0.3.

## 8. Open questions and rulings requested

Routed through the orchestrator to architect_docs_lead. None blocks a bench
other than its own row.

> **All four ANSWERED at `541ea43` (WO-0029); dv's countersignature WITHHELD at
> WO-0030** (`J-dv_lead-0015`). Item by item:
>
> - **1 (M03-N2)** — ruled for reading (i), **against rtl_lead's declared
>   reading**, on REQ-102 one document up rather than on a preference, and dv's
>   own §9-versus-§6.3 recommendation is superseded by a better instrument: the
>   ruling costs no new text at all, and the one stimulus it cannot report
>   (**two frames reported on one cycle under the same strobe name**) is carved
>   out at new §6.3 item 8 as a bound on DV, not on the module. **Endorsed, with
>   a second and independent ground the ruling did not use**: REQ-101 requires
>   *identical output streams for the same frame received at either alignment*,
>   and the one-closure-per-word reading breaks it — a `/T/` or `/E/` at
>   preamble position 4 … 7 shares the start word at a **lane-0** start (so it
>   is swallowed) and lies in the **following** word at a lane-4 start (so it is
>   recognised), giving two different output streams for one frame. **The row
>   does not convert**: the reading is settled, the report **cycles** are not —
>   defects **M03-R1** and **M03-R2**, derived under §4.N, are the withholding
>   ground. **Repaired at `06c1eba` and re-countersigned** (`J-dv_lead-0016`,
>   WO-0031), confinement verified across the whole tree: `docs/specs/**` moves
>   in one file and three hunks. **M03-N2 → ASSERT**, six sub-cases, cycles from
>   §6.1's landed table.
> - **2 (M03-N3)** — the requested §6.3 sentence **declined and bettered**: the
>   stimulus is *decided*, not unconstrained, so §6.3 was the wrong home and the
>   constraint that is owed binds the wrapper. Accepted. Residue **C-45**: the
>   prohibition is over-broad at a lane-0 start and its stated ground ("such a
>   cycle occupies preamble positions") does not hold there.
> - **3 (M03-N4)** — ruled for reading (i), **ADR-0014**; the enable gates
>   admission and nothing else. Endorsed on its merits, and the argument that
>   carries it is the right one: the unscoped reading of REQ-810 is
>   self-defeating, because it would suppress the in-flight frame's own words
>   and its own report and open the silent-discard hole REQ-810's next clause
>   disclaims. **M03-N4 → ASSERT at `06c1eba`**, unchanged, exactly as
>   pre-committed at WO-0030 — the repair touches none of the text it derives
>   from.
> - **4 (M03-O2)** — landed, editorial, no re-countersignature owed.
>
> **Consequence outside this plan, and it is not dv's to route**: the M03 RTL at
> `f840475` recognises one closure per input word, so it is non-conformant
> against **frozen** REQ-102 and §10's REQ-102 and REQ-110 hooks. That is an RTL
> defect against text frozen since batch A, not a change this ruling makes, and
> it is rtl_lead's under its own packet.

1. **M03-N2 (RULING, from rtl_lead's returned question 2)** — two closure
   characters in one input word where the second falls inside the new frame's
   preamble. §6.1 routes a control character in a preamble position to §9 in
   terms; rtl_lead has implemented one closure per word. The readings differ in
   exactly one observable (whether `error_runt` pulses), and under the
   one-closure reading a frame is opened and never reported, which is a hole in
   §0.6's conservation equation. **Cheapest repair either way: one row in §6.3
   (unconstrained) or one row in §9 (specified).** Recommendation: §9, because
   the text-strict reading is already what §6.1 says and the conservation
   equation prefers it.
2. **M03-N3 (from returned question 3)** — an idle word inside a frame's own
   preamble. §6.1's "exactly 8 octet times" already decides it; the request is
   one sentence in §6.3 confirming the stimulus is outside the specified space,
   which closes the last place REQ-016 and §6.1 can be read against each other
   and pins the idle-injection wrapper's contract (X-4).
3. **M03-N4 (RULING, from returned question 4)** — `cfg_rx_enable` = 0 arriving
   with a REQ-110 start character while a frame is open. §4.3's two sentences
   point opposite ways and the observable differs in a delivered octet count, a
   strobe and an abort bit. REQ-810's own "no frame is accepted, so this creates
   no silent-discard hole" is an argument for the reading in which the in-flight
   frame **is** reported.
4. **M03-O2 (editorial, one cell)** — SPEC-M03 §10's REQ-014 hook names
   "REQ-014's differential run", which has no instance at M03: the input is an
   XGMII lane pair with no `tstrb` (REQ-010 class (b)). This is the C-41 family
   — a verification column commissioning something a bench cannot build here —
   and the repair is the form SPEC-M14 §10 already uses for REQ-404 and REQ-810:
   "none — stated so that no sign-off packet claims coverage here", with the
   producer half left where it is.
5. **The carry-forward ledger's unnumbered dv-machinery row** (`P1-spec-freeze`
   checklist, the row between C-14 and C-15: "Latency.create's single
   strip_octets conflates two quantities") **was discharged at WO-0012** and
   carries no id and no closure mark. Clerical, and the orchestrator's to
   transcribe; noted here because this plan's M03-L3 is the row that keeps the
   fix honest and a reader of the ledger cannot tell it is done.

> **Carried in from `BUG-0001` (rtl_lead's open question 2), for families D–H
> — dv_lead, `J-dv_lead-0032`.** The bench observes M03's outputs at
> `Cyclesim`'s `~clock_edge:After` position, which pairs the post-edge register
> state with the *previous* input word. Any observable that is combinational in
> the **current** XGMII word is therefore read in a state that never exists in
> hardware. At M03-C1 this bit exactly once in sixteen (lane 4, length 68 — the
> `terminate_lane = 0` entry, R-1). **rtl_lead's warning is that in the
> error-injection families the coincidence is common rather than rare**: a
> strobe consumed from an age-0 closure record — an `/E/`, a `/T/` or an `/S/`
> whose §9 outcome is decided in the same cycle the closing word is emitted —
> is invisible at that sampling position. Round 6 of WO-0038 moves the
> asserted view to `~clock_edge:Before`; **no family D–H row may be written
> against the old position**, and the first D–H bench must state which of its
> rows depend on an age-0 record, because a silently-missed strobe is a
> NO-ASSERT row that looks like a PASS.

## 9. Change log

| Date | Change | Author |
|---|---|---|
| 2026-08-02 | Created (WO-0027). **73 rows** across 15 families (A 5, B 4, C 4, D 4, E 4, F 5, G 6, H 4, I 6, J 4, K 3, L 6, M 9, N 4, O 5) — 55 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 2 RULING, 1 GAP, 4 STRUCTURAL; the format defined in §0–§1 becomes the template for every later `AP-`. | dv_lead, `J-dv_lead-0013` |
| 2026-08-03 | **WO-0030, on the SPEC-M03 revisions WITHHELD at `541ea43`.** **No row converts**, and the reason is recorded rather than the conversion: both rulings are endorsed, but the text they land in carries two defects — a false universal in §6.1's consequence 1 (**M03-R1**) and §9's strobe-cycle sentence pinning a no-output-word frame to two different cycles when its ending character lies in its own start word (**M03-R2**, which already reaches the committed ASSERT rows M03-B2 and M03-B3). **M03-N2** stays RULING with the ruling recorded, the four sub-cases enumerated and the report cycles derived from §6.1's own m + 3 formula — including the correction of the architect's own correction of dv's original claim: the two strobes coincide in **three** of the four sub-cases and are one cycle apart only for a lane-0 `/S/` aborting a frame that delivered at least one octet. **M03-N4** stays RULING with the ADR-0014 reading endorsed and its conversion **pre-committed, unchanged**, at the re-countersignature. **M03-N3** stays NO-STIMULUS, now citing SPEC-M03 §6.1 and §10's REQ-016 hook instead of an inference, with **C-45** on the constraint's over-breadth at a lane-0 start; X-4 carries the same. **M03-O2** cites its landed §10 repair. §6's REQ-102, REQ-105, REQ-110 and REQ-802/REQ-810 rows gain the N-family entries they were missing. Status counts unchanged. | dv_lead, `J-dv_lead-0015` |
| 2026-08-03 | **WO-0031, on the R1/R2 repair COUNTERSIGNED at `06c1eba`.** Confinement verified across the whole tree, not only the claim: `docs/specs/**` moves in one file and **three hunks** — §6.1's consequence 1, §9's "Strobe cycle, pinned", one appended §13 row — and `docs/gates/**` only under the orchestrator's own trailer. **M03-N2 RULING → ASSERT** with the cycles taken from §6.1's landed table (which matches this plan's row for row) and re-derived by the specification's **second** route, §7's per-octet constant `U + ⌊(k + L)/8⌋`, which is gap-invariant where `m + 3` is not; the row is restated as **six** sub-cases, the coincidence count as **three of six**, and the coincidence column recorded as injection-proof so the row may run inside the M03-I4 wrapper. **M03-N4 RULING → ASSERT**, unchanged, exactly as pre-committed at WO-0030. **Self-correction against my own WO-0030 prose** (the architect flagged it and I concur): "three of the four sub-cases" and "one cycle apart only for a lane-0 `/S/`" collapsed the aborted frame's own start lane out of a three-axis classification and then quantified over the collapse, absorbing the (lane-4 `/S/`, lane-4-started A) row; the **table** was always right and the row above is left standing rather than tidied, per this programme's own rule for a recorded miss. New ledger row **C-47** proposed on §9's rows 8/9 (offered by the architect, accepted and rewidened to name requirements.md REQ-110 as a second site). Counts: **57 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL** (73 rows, unchanged). | dv_lead, `J-dv_lead-0016` |
| 2026-08-03 | **WO-0033, the machinery.** All five of §7's items are **built** and no row of this plan is now blocked on machinery. **X-1** `test/xgmii/injection.ml` — the error-injection catalogue, whose expected §9 outcome is **computed** by running §6.2's state machine and §9's closure list over the emitted octet-time line rather than tabulated, so §6.1's two-events-in-one-word cases are ordinary and a frame the *stimulus* opens gets an outcome too; its strobe cycles come from §7's per-octet constant and §9's no-output-word clause, both gap-invariant, so the outcomes survive idle injection under `Idle_injection.cycle_of` and the WO-0031 scope note applies unchanged. `test_injection.ml` drives §6.1's consequence-1 **minimal witness** and confirms both reports on **W + 2** with different names — the row M03-N2 exists for and the one dv's own WO-0030 prose got wrong. **X-2** `test/xgmii_probe/` (drive and sample, both directions of the boundary). **X-3** `test/monitors/strobe_monitor.ml` — C-23 high-cycle counting, the §9 pinned-cycle comparison, the §0.6 window checked **against the pin itself** (a pin outside its window is a *specification* defect, the M03-R2 class), and "no strobe the stimulus created". **X-4** `test/xgmii/idle_injection.ml` — §10's 0, 1 and 7 cycles, carrying the **M03-N3 constraint as repaired at `06c1eba`**, refusing exactly one boundary per frame at both start lanes, with **C-45**'s lane-0 instances named in `c45_sites` and released only by `~allow_c45:true`, which defaults false and may be set only if C-45 lands. **X-5** the per-frame output extent on `Octet_time.Latency.frame_out` (one repair, shared with M14's X-9). **Standing limit, stated so no packet blurs it**: X-1's outcome model is cross-checked against this plan's hand-derived rows and is **not** the charter §3 external anchor — that is the verilog-ethernet differential co-sim, and no `SO-xgmii_rx_64.md` PASS may rest on the model until it has run. Status counts unchanged: 57 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL. | dv_lead, `J-dv_lead-0017` |
| 2026-08-03 | **WO-0035, on the SPEC-M03 additions COUNTERSIGNED at `1fe71ca`.** Confinement verified against the tree: 8 hunks, 2 files, nothing outside `docs/**` and `agents/handoffs/**`. §9's **ruling 9** — `error_bad_fcs` NEVER below 5 received octets — endorsed; the architect's content-free-class ground reproduced independently (`zlib.crc32(bytes(4))` = `0x2144df1c` = REQ-304's residue, and it is the **unique** 4-octet member; at 0 octets §6.1 item 1's seed `0x00000000` is what item 4 would compare). **CREATES one row, and NOT the one the Return log named**: the ruling's row is **M03-M10**, because **M03-M9 is already taken** by the §0.6 inheritance row this plan cites in its own §5 — the architect protected §9's *ruling* indices by appending last and then proposed a colliding *row* index; the M-family index/ruling correspondence therefore ends at 8 and §4.M now warns of it. **STRENGTHENS three rows from a lower bound to an exact strobe set**: **M03-F2** and **M03-B3** ("exactly one `error_runt`" → *and no other strobe of any kind*), and **M03-N2**, whose zero-delivered sub-cases now assert exactly {`error_start_without_terminate`, `error_runt`} and nothing else. **One anti-vacuity constraint added that the ruling's own ground implies and neither packet stated**: M03-F2's 4-octet frame SHALL NOT use an all-zero filler, since that single frame passes a wrong design by accident — the content-dependence the ruling names is also a hole in the bench that tests it. Converts nothing; kills nothing; 0 RULING remain. New counts: **58 ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL (**74 rows**). Ledger **C-49** and **C-50** raised, both non-blocking, C-50 against text I signed myself at `06c1eba`. | dv_lead, `J-dv_lead-0020` |
| 2026-08-05 | **BUG-0001's fix round: one row added, no row changed.** New row **M03-C5** — 1513- and 1516-octet frames at both start lanes, commissioned by dv_lead's locked prediction **P-1** in `BUG-0001` and by rtl_lead's **R-1**. It exists because BUG-0001's invariant (`excess = max(0, k − 4)`, k = the final output word's fill) is a rule about the *last word*, not about frame length, and every length that found it lay in 64…71: a fix that repairs the neighbourhood rather than the rule passes M03-C1 and fails M03-C5. **1516 at lane 4 carries terminate_lane = 0 with a full final word** — the second instance of the class in which R-1 says the closure is unobservable at `~clock_edge:After`, so the same row tests the sampling-position account away from length 68. **Also recorded, for families D–H's planning** (§8): rtl_lead's open question 2 — a strobe consumed from an age-0 closure record is invisible at the current sampling position, and in the error-injection families that coincidence is common rather than 1-in-16. Row and status counts: **75 rows**, 59 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 RULING→ASSERT. | dv_lead, `J-dv_lead-0032` |
