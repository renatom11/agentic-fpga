# WO-0035: Second spec queue — two M03 questions now load-bearing, one owed cell
- **State**: ACCEPTED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: rtl_lead's WO-0032 Return-log returned questions
  (J-rtl_lead-0005 at d57e028); dv's C-43 (WO-0030 §6, the flagged
  question you answered whose diff you deliberately did not land);
  C-46/C-47 (dv's ledger rows naming requirements.md REQ-810's
  verification column and SPEC-M03 §9 rows 8/9 — both non-blocking,
  both one cell); the ADR-0012 revision discipline as before.
- **Deliverables**:
  1. **rtl Q(a), now load-bearing**: does `error_bad_fcs` pulse for
     a sub-5-octet frame? SPEC-M03 §9 row 6 lists only `error_runt`,
     while the residue form makes the seed a mismatch. rtl_lead kept
     behaviour unchanged from f840475 but the WO-0029 ruling makes
     the frame reachable at REQ-102's newly commissioned stimulus —
     rule it, and state which attack-plan row it creates or kills.
  2. **rtl Q(b)**: the WO-0032 packet's `/S/`-lane-2 example — a
     start character outside lanes 0/4 closes but opens nothing
     (§6.3 item 3, REQ-101). The example was mine, in the WO packet,
     not in any spec; confirm rtl_lead's reading in one sentence in
     your Return log (no spec diff owed unless you find one).
  3. **C-43**: requirements.md §12's `error_ip_bad_header` condition
     cell gains ADR-0013's third disjunct. One cell; the ADR is
     already signed; dv held it non-blocking. requirements.md
     revisions carry the countersign discipline — flag whether this
     cell is normative enough to need dv's signature or is the
     editorial class (your call, stated).
  4. **C-46 and C-47** (optional, dv does not require them now):
     REQ-810's verification-column scope; SPEC-M03 §9 rows 8/9's
     missing classification row. Take them only if the commit stays
     clean.
  - Journal next id in your sequence; Files-in-this-commit exact.
- **Out of scope**: everything else; libs/**, test/**, tools/**;
  committing.
## Task
Small, sharp, and mostly cells — but Q(a) gates a bench row and the
text should decide it before the bench does.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-03T10:05Z (spawn `WO-0035/2026-08-03T10:05Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-architect_docs_lead-0013`
- **Files**: `docs/specs/modules/xgmii_rx_64.md` (FROZEN), `docs/specs/requirements.md`
  (FROZEN), this packet. **8 hunks, no more**; no ADR written; nothing outside
  `docs/**` and `agents/handoffs/**` touched.

#### 1. Q(a) — RULED: `error_bad_fcs` SHALL NOT pulse for a frame below 5 octets

**Row 6 already decides it, and it does not decide it alone** — which is the
honest answer to the question the work order put. Row 6 supplies the antecedent
("**no FCS removal is attempted on a frame with nothing to remove it from**").
The three "never" rulings in §9's co-occurrence list draw their conclusion from
*exactly that antecedent* and state the inference in terms — oversize: "no FCS
is present at the truncation point, so **no check is performed and no result
exists to report**"; `error_bad_frame`: "REQ-103 attempts no FCS removal and
**M03 performs no check**"; `error_start_without_terminate`: "likewise". The
list simply has three "never"s where it should have four, and the hole is what
made the question askable. So: **no ADR, no normative diff, no behavioural
change** — one clarifying cell, which is the ninth ruling appended to that list,
plus the scope on the exit that sequences the check and two §13 rows.

The grounds, in the order that decides them:

1. **REQ-104 settles it one document up.** It defines the strobe as the
   disagreement between a **received FCS** and a CRC computed over the octets
   preceding it, and requirements.md §12 words the condition the same way. A
   frame with nothing to remove an FCS from supplies **neither operand**. No
   comparison, no mismatch, nothing to report. `error_runt` is not a
   *precedence* over `error_bad_fcs` here — `error_bad_fcs`'s condition simply
   does not obtain.
2. **Ruling 1 bounds itself, in its own words**: it admits the pairing because a
   5-to-63-octet frame "ends with a terminate character, so its FCS *is* removed
   and *is* checked (REQ-103)". Below 5 octets row 6 denies the premise.
3. **§6.1's residue recipe has no instance in this class**, so it never said
   otherwise: item 3's coverage is "every received octet of the frame, the four
   FCS octets included", which no frame below 5 octets has; at zero octets item
   2 never updates the register, so item 4's "that final value" is the **seed**
   rather than a CRC over anything; and item 4's consequent names a `tlast` word
   that row 6 and §0.7 say this frame does not have. **This is the site that
   made rtl_lead's reading reachable** and it is why the ruling was worth
   landing as text rather than asserting in a Return log — but §6.1 is
   deliberately **not** edited (see §4 below).
4. **The refused reading is content-dependent in a class §9 has just declared
   content-free** — the argument I judge decisive, and it is checkable. Under
   REQ-301's parameterisation the FCS of an empty message is 0x00000000, so the
   single four-octet frame whose four octets are `00 00 00 00` yields a final
   value of exactly REQ-304's residue 0x2144DF1C, while every other frame in the
   class yields something else. Running the comparison at every terminate
   character would therefore make the strobe a function of octets §9 has just
   said nothing is removed from, and would have **two conformant
   implementations disagree about §10's own commissioned 4-octet frame depending
   on its filler**. That is ADR-0013 alternative (f)'s test — reachable,
   observable, and two implementations would differ — so §6.3 is the wrong home
   and the class must be decided. Reproduce:
   `python3 -c "import zlib; print(hex(zlib.crc32(b'')), hex(zlib.crc32(bytes(4))))"`
   → `0x0 0x2144df1c`.

**Attack-plan consequence (dv applies it).**

- **CREATES one row: `M03-M9`** — "§9 ruling 9", the M03-M family's ninth, on
  the family's own pattern (M03-M2/M3/M4 are the same shape one closure-class
  over). **No new stimulus is owed**: `M03-F2` (0-, 1- and 4-octet frames) and
  `M03-B3` (`/T/` in a preamble position) already drive it. Observable:
  `error_bad_fcs` does **not** pulse. Kill: *a design that runs the residue
  comparison at every terminate character regardless of whether the frame had an
  FCS to check* — M03-M3's kill one class over.
- **KILLS no row**, withdraws nothing, and converts nothing (0 RULING remain).
- **STRENGTHENS three ASSERT rows from a lower bound to an exact strobe set**:
  `M03-F2` and `M03-B3` ("exactly one `error_runt`" → *and no other strobe*),
  and `M03-N2`, whose zero-delivered sub-cases now assert **two** strobes
  exhaustively — which is precisely the count rtl_lead flagged.
- **The ruling was appended LAST on purpose.** `AP-xgmii_rx_64.md` cites the
  co-occurrence rulings **positionally** ("§9 ruling 1" … "§9 ruling 8" at
  M03-M1 … M03-M8). Inserting the new ruling where it belongs semantically —
  after ruling 1, which it bounds — would have renumbered M03-M2 … M03-M8. It is
  ruling **9** and no existing index moves; the bullet locates itself in its
  first clause instead.

**Bench consequence, and it needs routing before those rows run.** rtl_lead
reports that the delivered M03 pulses `error_bad_fcs` alongside `error_runt` for
a `/T/`-closed zero-delivered frame. **That is now a conformance defect against
REQ-104 and §9**, on the same footing as WO-0032's and found the same way. Two
things for the orchestrator, neither of them mine to do:

- rtl_lead owes the repair **and** an answer for the 1-to-4-octet sub-cases,
  which its Return log did not report: the same unscoped comparison presumably
  pulses there too, but I will not assert what the module does. Note the
  4-octet all-zero frame may pass today by accident, so the defect is *not*
  uniform across `M03-F2`'s three lengths — expect two red of three, and do not
  read the third as evidence the module is right.
- If `M03-F2`/`M03-B3`/`M03-N2` are run before the repair they go **red**, and
  the redness is the design's, not the bench's.

#### 2. Q(b) — rtl_lead's `/S/`-lane-2 reading is CONFIRMED

**rtl_lead is right, and it is right for a stronger reason than it gave: §6.3
item 3 puts the whole word outside the specified space, so "closes epoch A and
opens nothing" is one *admissible* response rather than the required one, DV
SHALL assert nothing about it, and the lane-5 `/T/` being ignored under REQ-113
is a consequence of the module's own admissible choice and not an obligation
either** — a different admissible choice (ignore the lane-2 `/S/` entirely)
leaves epoch A open and lets the lane-5 `/T/` terminate it, a different
observable, which is exactly why item 3 exists.

**The example was mine and it was ill-chosen** — WO-0032 deliverable 1 reached
for two lanes that put its own illustration inside §6.3 item 3. The obligation
it was illustrating is undamaged and is what rtl_lead implemented: REQ-102's
third sentence at the **specified** start lanes, `/S/` in lane 0 or lane 4 with
a closure above it. **No spec diff owed**, and constraining the lane-2 case
would be the exact commissioning §6.3 item 3 refuses.

#### 3. C-43 — landed, and I classify it **normative: dv's signature is owed**

The cell now reads: *IPv4 version not 4, header length not 5, or a declared
total length below 20 (**ADR-0013**; SPEC-M14 §4.2, §6.1, §9)*. REQ-601's
normative sentence is untouched, per ADR-0013 alternative (e) and per C-43's own
scope.

**The class and the countersignature question are different axes, and this cell
is where they separate — so I state both rather than picking one word.**

- **Class: editorial**, by §13's own test. No conformant design changes (ADR-0013
  already moved the design at SPEC-M14 and that revision is re-countersigned)
  and no existing test changes meaning (`M14-K7` is already ASSERT with the
  observable pinned).
- **Countersignature: owed.** The discriminator I apply, and will keep applying:
  **normative text takes a signature; a verification column takes concurrence.**
  C-39 and C-41 closed on concurrence because they were verification columns.
  §12 is headed "(normative)", its column is headed "Condition", and it is the
  enumeration REQ-008 quantifies over — REQ-008 is discharged for this discard
  only once the cell moves, which is C-43's own ground. The **REQ-810 row is the
  precedent where both hold at once**: classified editorial in §13 and still
  given a transcribed re-countersignature.
- Applied uniformly this activation: the §9 ruling, §9 row 9, §12's cell and
  REQ-110's gloss are **signature** items; REQ-810's verification column is a
  **concurrence** item.

#### 4. C-46 and C-47 — both TAKEN; and one site deliberately not touched

- **C-46 (taken, concurrence class)**: REQ-810's verification column now scopes
  the injection to `receive enable` = 0 **with no frame in flight**, states the
  reason in the row's own admission language, and points the mid-frame case at
  SPEC-M03 §10's REQ-802/REQ-810 hook where it is already commissioned. Taken
  now rather than at `SO-xgmii_rx_64.md` because the column as written
  commissions an assertion **`M03-N4` directly contradicts** — C-41's
  unpassable-assertion family — and I was editing the document anyway.
- **C-47 (taken, both sites)**: §9 row 9's condition is restated extensionally
  on **row 3's model, which dv named** — "at or before that frame's first octet
  (including in a preamble position)" — so rows 8/9 now partition the REQ-110
  aborts exactly as rows 2/3 partition the REQ-105 ones. **Repaired in place,
  not by adding a row**: dv framed C-47 as "the row that says so" is missing,
  but the in-document model dv itself named handles the sibling case
  *extensionally in one row*, and adding a row would have moved §9 row indices
  that dv's plan, rtl_lead's Return log and my own journal all cite. Its second
  site — requirements.md REQ-110's gloss — moves in the same commit onto
  REQ-105's own wording, and that was **forced, not preferred**: repairing §9
  alone would leave the two documents disagreeing where they currently
  under-describe symmetrically.
- **Not touched, deliberately: §6.1's four-item residue recipe.** Item 4 read
  alone is what made rtl_lead's reading reachable, so the case for a proviso is
  real. I put the scope on **§6.2's `Frame` row** instead — the exit that
  *sequences* the check, which is the site an implementation codes — and left
  §6.1 to the derivation in ruling 9 ("no instance in this class"). Reason:
  §6.1 is the paragraph dv re-countersigned at `06c1eba` after the R1/R2
  withholding, and reopening it costs more than the proviso buys. **If dv
  judges the derivation too thin to leave §6.1 unscoped, it is one clause and I
  will take it** — say so in the re-countersignature rather than as a ledger row.

#### 5. Re-review surface, pre-worded both ways

Confinement: **8 hunks, 2 files.** SPEC-M03 — §6.2's `Frame` row `/T/` exit,
§9 row 9's condition, §9's appended ninth ruling, two §13 rows. requirements.md
— §12's `error_ip_bad_header` condition, REQ-810's verification column,
REQ-110's gloss, three §13 rows. Nothing else in either document moves;
`git diff -U0 -- docs/` shows exactly those eight.

Signature items (pre-worded, in the WO-0022/WO-0031 form):

> "I re-countersign the SPEC-M03 text moved at `<SHA>` — §6.2's `Frame` row,
> §9's row 9 and its ninth co-occurrence ruling, and the two §13 rows — for
> `P1-spec-freeze` testability. SPEC-M03 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0005` for the specification as frozen
> at `f78766e`, on `J-dv_lead-0016` for the `06c1eba` revision, and on
> `J-dv_lead-00NN` for this one."

> "I re-countersign requirements.md **§12's `error_ip_bad_header` condition cell
> and REQ-110's zero-delivered gloss** as revised at `<SHA>`, and their §13
> rows, for `P1-spec-freeze` testability. requirements.md remains FROZEN and its
> testability countersignature stands: on `J-dv_lead-0002` at `b4b4cf4`, on
> `J-dv_lead-0015` for REQ-810, and on `J-dv_lead-00NN` for this one."

Concurrence item (no signature sought): REQ-810's verification column and its
§13 row — C-46, C-41's family, the class C-39's diff established.

**Ledger effect**: **C-43 closes**, **C-46 closes**, **C-47 closes at both
sites**. Nothing new is opened by me this activation except the RTL defect in §1,
which is rtl_lead's and needs a packet.

### ACCEPTED — orchestrator, 2026-08-03T10:40Z, journal `J-orchestrator-0084`

Committed `1fe71ca` (J-architect_docs_lead-0013). All four items
answered, two optional items taken, eight hunks total. The ruling's
craft is on the record: appended as §9 ruling 9 rather than inserted,
because six committed ASSERT rows cite the rulings positionally —
renumbering them silently would have corrupted the plan's citations.
Q(a)'s consequence lands as WO-0036 (rtl: the 1–4-octet cases —
conviction grounded on FROZEN REQ-104, so it does not wait for the
clarifying-diff countersignature, the WO-0032 precedent). The two
pre-worded re-countersignatures + C-43's signature + the §6.1
one-clause offer queue for dv's next sitting, after WO-0034 returns
— one dv agent at a time.
