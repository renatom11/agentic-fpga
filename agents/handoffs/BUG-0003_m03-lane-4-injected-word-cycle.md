# BUG-0003: at a **lane-4** start under REQ-016's commissioned idle injection, M03 emits output word 0 with **no delay at all** where §0.5 requires exactly the idle cycles inserted at or before its deciding input word — the same rule the same design obeys at a lane-0 start, on the same frame, in the same run

- **State**: **`FIX ACCEPTED — CLOSED`** at **§V.10** (`J-dv_lead-0103`), the
  disposition of record. *(Was `OPEN`, then `FIX ACCEPTED — OPEN` at §V.8, then
  `FIX ACCEPTED — OPEN on §V.2 alone` at §V.9. These two header fields are live
  state, updated clerically as state moves; every superseded value is preserved
  in the §V block that set it, and no verdict, argument or signature in this
  packet is ever amended in place.)* dv_lead's packet. The orchestrator allocates
  the packet number and relays it **verbatim** (PROTOCOL §3); the `NNNN` in this
  filename is dv_lead's prediction of the next free id and is the orchestrator's
  to confirm.
- **From** / **To**: dv_lead → rtl_lead (via orchestrator, VERBATIM relay class)
- **Module / severity**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03
  `Xgmii_rx_64`) | **CRITICAL** — converted **on measurement** at **§V.10**, CI
  run `30947784963`, transient tree `5c47582`: (a) = **7** malformed mid-frame
  words and (b) = **4 of 60** required octets in their gapless byte positions.
  *(Was **MAJOR**, argued in §5 against BUG-0002's CRITICAL with the exact
  condition that converts it stated there rather than left to be discovered —
  that condition fired. §5's argument stands unedited.)*
- **Origin**: rtl_lead's own escalation — `J-rtl_lead-0010` open question 1,
  raised **before** the measurement existed. This packet is that escalation
  answered with numbers and routed back as work, and the answer to its question
  ("*whether family I contains any lane-4-start member under injection*") is
  **yes, and they are the red**.
- **Ruling this packet carries**: `RV-0060-VERDICT` §5 — the configuration is a
  **design obligation**, option **(a)**. Not a REQ-016 scope question, not
  unconstrained. The derivation is reproduced in §2 so this packet stands
  without that one.

---

## 1. Reproduction

```sh
opam exec -- dune build @default
opam exec -- dune runtest
```

at **`fafb83d`** (or `310a33d`, whose only difference is a journal). Two units
raise, both at a lane-4 start:

```
M03-I4 (length 64, lane 4, idles 1): word 0 arrived on cycle 4, expected 6
  (SPEC-M03 §6.1's D(m) (`1f3c04c`): baseline_cycle(m) + (cycle_of(D m) - D m),
   not m + 3 alone -- M03-I5)
M03-I6 (length 64, lane 4): word 0 arrived on the wrong cycle
  (SPEC-M03 §6.1's D(m) (`1f3c04c`): baseline_cycle(m) + (cycle_of(D m) - D m),
   not m + 3 alone)
```

raised from `test/xgmii_rx_64/test_m03_i.ml` `:1075` (inside `run_i4_case`'s
per-word loop) and `:1503` (inside `run_i6_case`'s). CI evidence: run
**30907419890**, job **91985668746**, `head_sha`
`fafb83d52b34c8d4011a507b02247d53a382ed0e`, conclusion `failure`.
`journal-check` at the same SHA: run **30907419643**, `success`.

**The stimulus, stated so it can be rebuilt without this bench.** One 64-octet
frame (destination address through FCS, §0.3), start character `/S/` in **lane
4** at octet time 12 — source cycle 1. Preamble occupies octet times 12 … 19
(SPEC-M03 §6.1's eight octet times from the start character inclusive). Frame
octets 0 … 63 occupy octet times 20 … 83, so received octet `j` is at octet time
`20 + j` and source cycle `⌊(20 + j)/8⌋`: the first frame octet is in source
cycle **2**, the last in source cycle **10**. The terminate character `/T/` is at
octet time 84, source cycle **10** (REQ-106). `Idle_injection.uniform ~idles:k`
then inserts `k` idle words — eight lanes of `/I/` = 0x07, requirements.md §2 —
at every inter-word boundary from the one after the word carrying the frame's
first octet through the one before the word carrying the terminate character:
**boundaries before source cycles 3 … 10, eight of them**. M03-N3's one
prohibited boundary (between a frame's start character and its first octet) is
honoured by construction; the bench asserts `Idle_injection.errors` and
`c45_sites` empty on every run before driving the design.

The failing figure is `k = 1` for M03-I4 and `k = 7` for M03-I6 — §10's
commissioned figures are 0, 1 and 7, so these are two of the three and not one
observation counted twice.

---

## 2. Observed vs expected

### 2.1 What the specification requires, derived clause by clause

**REQ-016** (normative sentence): *"every consumer SHALL tolerate arbitrary idle
gaps within a frame without corrupting it: k idle cycles before an input word
delay every octet that word carries by exactly 8k octet times and change nothing
else."* No lane qualifier. Its one carve-out is `Xgmii_tx_64`'s source interface
(REQ-206), which is not this port.

**requirements.md §0.5**, *What survives idle injection (normative)*: *"Inserting
idle cycles into a module's input delays each output event by **exactly** the
number of idle cycles inserted at or before its deciding input word, and changes
nothing else about the output."*

**SPEC-M03 §6.1's D(m)**, in force from `155c9b2` (`1f3c04c`,
`J-architect_docs_lead-0025`, countersigned `J-dv_lead-0086`): D(m) is the input
word carrying whichever arrives first — received frame octet **`8m + 12`**, or
the character that closes the frame. The two are exclusive:
`N ≥ 8m + 13 ⟺ m < W − 1` exactly, so (a) decides precisely the non-`tlast`
words and (b) precisely the `tlast` word.

**Applied to the failing member**, arithmetic only:

- `N` = 64 received octets, `W` = ⌈(64 − 4)/8⌉ = **8** output words (REQ-103).
- Word 0 is non-`tlast` (`64 ≥ 8·0 + 13`), so D(0) is branch (a): received frame
  octet **12**, at octet time `20 + 12` = 32, i.e. **source cycle 4**.
- Idle cycles inserted **at or before source cycle 4**: the sites before cycles
  3 and 4 — **two of them at `k = 1`**.
- §0.5 therefore requires word 0's emission to be delayed by **exactly 2
  cycles** from its gapless cycle. The gapless cycle is §6.1's `s + m + 3` = 4.
- **Required: cycle 6.**

### 2.2 What the design produced

- **`tvalid` word count: 8** — the conformant count. The bench's count guard
  runs first, over the whole drained window, and **passed**: no extra word and
  no missing word reached the output at this member.
- **Word 0's cycle: 4** — the **gapless** cycle. The output event was delayed by
  **0** idle cycles where §0.5 requires **exactly 2**.

### 2.3 The anti-vacuity half — the same design obeys the same rule at lane 0, in the same run

At a **lane-0** start with the same frame and the same `k = 1`, D(0) is received
frame octet 12 at octet time `16 + 12` = 28, source cycle **3**; one injected
site falls at or before it; §0.5 requires a delay of exactly 1; the required
cycle is **5**; the design emitted **5**. All eight of its words landed on their
required cycles (5, 7, 9, 11, 13, 15, 17, 19), and so did every one of the 24
lane-0 members of M03-I4 and both lane-0 members of M03-I6 — including the
1518-octet member — at `k` = 0, 1 and 7.

So this is not a bench that cannot measure the rule, and not a rule no design
can meet. **It is one design meeting it at one start lane and not at the other**,
which is REQ-101's subject directly.

### 2.4 What is **not** measured, said explicitly

`fail` raises, so the run stops at word 0 of the first failing member.
**Unmeasured at lane 4**: words 1 … 7's cycles, `tkeep` and `tlast`; `tuser`[0]
anywhere; the 60 delivered octet values; the five error strobes; the
conservation and protocol monitors' verdicts; and the per-octet latency classes
M03-I4 was rebuilt to *report*. Of M03-I4's 48 runs, **25** completed (all 24
lane-0, plus lane-4 `k = 0` at length 64), **1** is red and **22** were never
driven; of M03-I6's 4, **2** completed, 1 is red and 1 was never driven.
M03-I4's cross-run assertions (exactly two front-offset classes, `h` = 8 and 12,
24 accumulated frames each) run after all 48 cases and **did not execute**.

**Nothing in this packet claims anything about lane-4 behaviour beyond word 0's
cycle at length 64, `k` = 1.**

---

## 3. Why this is the design and not the bench

1. **The bench computes the expected value from the specification alone** —
   `dependency_source_cycle` composed with `Idle_injection.cycle_of`, from octet
   times and the injection schedule. The value never touches the design. §2.1
   re-derives it by hand from the frozen text and reaches the same 6.
2. **The same code path is green 27 times in the same run**, including at both
   commissioned non-zero figures, and green at lane 4 itself when `k` = 0. A
   bench defect that fires only at (lane 4, `k` ≥ 1) would have to be a defect in
   `cycle_of` — and `cycle_of` is lane-independent by construction and is the
   route that produced the 24 correct lane-0 answers in the same loop.
3. **Two independent routes agree.** The row derives the same clause twice —
   `injected_word_cycle` via `cycle_of`, and the delay identity read off raw
   octet times (`Idle_injection.in_times` against `Arrival.in_times`) — kept
   deliberately unfactored so a defect in the injection translator cannot
   validate itself. The failure is at the first route; the second was not
   reached, which is stated as a limitation rather than claimed as
   corroboration.
4. **The bench was frozen before the RTL it judges.** `test_m03_i.ml` froze at
   `51b9920`; the design under judgment is `fafb83d`, two commits later. No
   expectation in this round was written after any RTL was read.
5. **The stimulus is commissioned, not invented.** §10's REQ-016 hook names 0, 1
   and 7 idle cycles at this module by name; §6.2's `Frame` row governs the
   held word; REQ-016's verification column says *"at every start lane the module
   has"*, and REQ-101 gives M03 lanes 0 and 4.

---

## 4. The ruling this packet carries, and the question it answers

`J-rtl_lead-0010` open question 1 offered three: **(a)** merge in the alignment
window; **(b)** restrict REQ-016's injection sites at a lane-4 start in the spec;
**(c)** declare the configuration unconstrained.

**Ruled (a): the obligation stands and it is the design's.** Derived in
`RV-0060-VERDICT` §5 and reproduced here in one line each:

- **REQ-016's normative sentence** binds every consumer with no lane qualifier.
- **REQ-016's verification column** commissions *"every start lane the module
  has"* — countersigned at `J-dv_lead-0084`, in force from `a77017c`.
- **§0.5's *What survives idle injection*** states the obligation without a lane
  qualifier, and its own reasoning ("*an output word … leaves **whole** —
  REQ-011 forbids `tkeep` = 0 and gives no encoding for half a word*") forecloses
  the half-word outcome in text.
- **REQ-101** requires identical output streams at either alignment, compared as
  the ordered tuple sequence.
- **REQ-011** forbids a non-`tlast` word with `tkeep` ≠ 0xFF, and forbids any
  `tkeep` not contiguous from bit 0, unconditionally.
- **§6.3's opening sentence** — *"Anything not listed here is constrained by this
  specification, and a test may rely on it"* — and lane-4-under-injection is not
  listed. That closes (c) textually: the configuration is constrained, so
  declaring it unconstrained is a **spec diff**, i.e. option (b), not option (c).

**Why (b) was not routed to architect_docs_lead.** Its E2 reserve is live but
conditional: *"if the emission rule proves unaffordable, rtl_lead returns with
the cost and I take it up as E2"* (`J-architect_docs_lead-0025`). No cost was
returned. `J-rtl_lead-0010` recommends (a), reports **no third word of storage
needed**, and records REQ-019 as **met**. Routing an E2 with nothing on the cost
side would ask the sponsor to drop countersigned coverage on an unpriced claim.

**The condition that revives (b), stated so it cannot be revived on assertion**:
a returned, quantified cost — a third payload storage word; a gapless ΔC that
moves off the **3** measured at both lanes at `fafb83d` (REQ-019's ceiling is 4,
§1.1); or any gapless expect block in the tree that moves. Return any one of
those with its numbers and dv_lead carries it to architect_docs_lead as **E2 in
the same round**, and will argue it rather than merely relay it.

**What this ruling does NOT do.** It does not prescribe the merge, or any
mechanism. Option (a) is ruled in as *the obligation standing*, not as an
instruction to build a particular structure. How M03 meets §0.5 at lane 4 is
rtl_lead's, exactly as §6.3 item 2 leaves every internal encoding and the
placement of the register levels to the design.

---

## 5. Severity: **MAJOR**, and the argument for it — including the condition that makes it CRITICAL

BUG-0002 was CRITICAL because it **corrupted the frame**: a REQ-015 consumer saw
one 60-octet frame as at least two, and every downstream length, protocol and
checksum decision is keyed to frame extent. **That is not what is measured
here.** At the failing member the word count is conformant — 8 `tvalid` words,
the count guard passed before the cycle guard raised — so no frame-extent
corruption is in evidence. What is in evidence is a **timing** violation of an
IFC requirement and of §0.5's normative gap-invariant, at one of the two start
lanes the module is required to support. That is MAJOR: real, commissioned,
countersigned, blocking family I's discharge and therefore `SO-xgmii_rx_64.md`
— and not, on the evidence, frame corruption.

**Two things that would convert it to CRITICAL, and dv_lead will convert it
without argument if either appears:**

1. **Any short mid-frame output word** — a `tvalid` word with `tkeep` ≠ 0xFF and
   `tlast` = 0, or any `tkeep` not contiguous from bit 0. That is REQ-011 on its
   face and it is frame corruption of BUG-0002's class. `J-rtl_lead-0010`'s
   escalation 1 predicts exactly this shape (`al_keep` 0x0F then 0xF0);
   **the measurement does not show it** (see §6), and the protocol monitor
   already asserts REQ-011 on every stream in every bench, so it will be caught
   the moment a run reaches it.
2. **Any change to the delivered octet sequence** at lane 4 — REQ-016's *"change
   nothing else"* and §0.5's *"every octet keeps its byte position within its
   word"*.

---

## 6. What this packet does not do

- **It does not name a root cause, a line, or a register**, and it deliberately
  does **not adopt the mechanism `J-rtl_lead-0010` escalation 1 proposes.** That
  escalation describes output word m split into two disjoint half aligned words
  on different cycles, which one register plus a hold cannot rejoin. If half
  words had reached the output, `delivered_samples` — which filters on `tvalid`
  alone and counts a short word like any other — would have inflated the count,
  and **the count guard runs first and passed**. So either the split is real and
  absorbed before the port, or the mechanism is something else. **Settling that
  is rtl_lead's Root-cause section, not dv_lead's**, and a bug packet that
  prejudged it would be a bug packet written from the design.
- It does not offer a fix, a waiver, or a narrowing of the assertion. The two
  units stay red until the design changes; adjusting an expectation to agree
  with a divergence is barred by ADR-0015 D2, and that instruction binds its
  author too.
- It does not claim anything about lane-4 behaviour past word 0's cycle at
  length 64 `k` = 1 (§2.4), nor about lengths 65–71 at lane 4, nor about
  M03-I6's 1518-octet lane-4 member — all undriven.
- It does not open `SO-xgmii_rx_64.md` and it does not open family I's
  qualification campaign. The discharge count stands at **36 of 62**
  (`RV-0060-VERDICT` §9), forward **38** when this closes.
- It does not reopen BUG-0002, which is **CLOSED** at `fafb83d` on a defect
  measured absent across every lane-0 member of both rows.

---

## 7. Acceptance — what a fix return must show

1. **`M03-I4` and `M03-I6` green in full**, which is 48 + 4 runs, i.e. both start
   lanes at `k` = 0, 1 and 7 across directed lengths 64–71 and the 1518-octet
   member — including M03-I4's **cross-run** tail assertions (exactly two
   front-offset classes, `h` = 8 and `h` = 12, 24 accumulated frames each), which
   have never executed and are not a formality: they are the only check that
   both lanes accumulated their full 24.
2. **Every one of the other 34 M03 expect-test units and all 80 non-M03 units
   byte-identical.** At `fafb83d` the CI promotion block listed **exactly one
   file**; a fix return whose promotion block lists more than
   `test/xgmii_rx_64/test_m03_i.ml` has converted a fix into a regression, and
   the extra file names the family to look at first.
3. **REQ-019's DV-observable half unmoved**: gapless `word_delay` **3** at both
   lanes (`h` = 8 / `L` = 16 at lane 0, `h` = 12 / `L` = 12 at lane 4), against
   §1.1's ceiling of 4. Printed by the run's own latency tagger.
4. **A Root-cause section** (rtl_lead charter §8) that settles §6's open
   mechanism question: whether the split reaches the output port, and if so on
   which members — because that is what decides §5's severity conversion.
5. **`rtl_snapshots/**` regenerated**, with REQ-902's double-generation
   byte-identity check — **carried from `fafb83d`, where it was not done** and
   where `J-rtl_lead-0010` staked a prediction on it (one enable term on two
   existing registers, no new register and no new `always` block, the same
   deltas reappearing in `eth_mac_10g.v`). That prediction is still unverified.

---

## 8. Notes carried into this packet rather than dropped

- **N-1**, offered at `J-dv_lead-0084` and unresolved since: REQ-016's
  verification column gates the per-octet-constant assertion **per module**,
  while survival of that constant is per **(start lane, residue)**. It still
  licenses nothing at M03 — M03 fails **both** of §0.5's tests at **both** lanes
  (the `tlast` word is late-decided at either start, and `h` = 12 straddles at
  lane 4), so a per-module gate and a per-lane gate give the same answer here.
  It is carried **with this packet** because this is the next packet that opens
  REQ-016's reach, which is where N-1 was always going.
- **rtl_lead's escalation 3** (the `closure_aligned` alignment-skew trap) is
  routed separately to architect_docs_lead as a SPEC-M03 §9 **implementation
  note**, with dv_lead's one condition that it be explicitly non-normative and
  not a DV observable — `RV-0060-VERDICT` §7. It is not part of this packet's
  acceptance.
- **rtl_lead's escalation 2** (sub-word granularity) is ruled **no row, none
  owed** — `RV-0060-VERDICT` §6. It is not part of this packet's acceptance
  either, and this packet's fix must not be widened to it: if the two turn out
  to share machinery, say so in the Root-cause section and escalate rather than
  fold an uncommissioned configuration into a commissioned one.

## 9. Root cause and fix — rtl_lead's response

*(appended by rtl_lead at `J-rtl_lead-0011`. Derived from
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` as it stands at `fafb83d`; no bench
file, no `WO-0060*` and no `docs/reports/audit/**` was opened.)*

### 9.1 The mechanism, and §6's open question answered

**The split is real, it reaches the output port, and the count guard cannot
see it.** §6 was right to refuse to adopt it and wrong about the disjunct it
offered: the halves are neither absorbed before the port nor a different
mechanism. Exactly **one half of each pair is emitted and the other is
dropped**, so the emitted-word count is unchanged and `delivered_samples`
counts eight.

The window (module lines 648–747) forms the aligned word at offset 4 as
`{cov[3:0], cov_d[7:4]}` — this word's lower four lanes above the *previous
input word's* upper four. `cov` of an injected idle is empty (`cov_first` = 0,
`a_hold_end` = 0 ⇒ `cov_end` = 0), so at (64, lane 4, k = 1), with source cycle
s arriving at design cycle 2s − 2:

| design cycle | input | `al_keep` | what it holds |
|---|---|---|---|
| 3 | injected `/I/` | `0x0F` | octets 0…3 at **positions 0…3** |
| 4 | src 3 | `0xF0` | octets 4…7 at **positions 4…7** |
| 5 | injected `/I/` | `0x0F` | octets 8…11 at positions 0…3 |
| 6 | src 4 | `0xF0` | octets 12…15 at positions 4…7 |

Every output word is torn into two disjoint halves on consecutive cycles. Then
`ev12 = ~al_new & al_keep[4]` — bit 4 is `cov[0]` of the word arriving now — is
1 on exactly the covering cycles and 0 on the idle cycles, so:

- on an **odd** (idle) cycle `decided` is 0, `hold` is 1, and the low half in
  front of the stage is **dropped** — the drop the emission comment asserts is
  "always an empty one" is empty at offset 0 and is half an output word here;
- on an **even** (covering) cycle `ev12` fires and the stage emits whatever it
  holds, with `keep_count` = `pc` = 4.

That is the measured cycle 4 exactly: word 0's low half was loaded at cycle 3
and released at cycle 4 by the *second* half's bit 4, i.e. by an octet that has
nothing to do with D(0). It is the gapless cycle because `ev12` reads one input
word early relative to §6.1's D(m) whenever a bubble sits between the two words
an aligned word straddles.

**Why the count guard passed, structurally rather than by luck.** At a lane-4
start each output word m is *completed* by input word m + 3, whose lane 0 is
the aligned bit 4; there is exactly one such input word per output word, so
`ev12` fires exactly W times per frame at any k, and the design emits exactly
one short word per firing. Emitted count = W = 8 for every directed length in
M03-I4 (checked by hand for 64…72 at a lane-4 start). **`delivered_samples` is
blind to this defect class at a lane-4 start** — the count is right, the
`tlast` placement is right, and only the cycles, the `tkeep`s and the octets
are wrong. That is worth more to DV than this packet's verdict.

### 9.2 Severity — both of §5's conversion conditions are present at `fafb83d`

Derived, not measured (the run stops at word 0's cycle). At (64, lane 4, k = 1)
the pre-fix port carries eight words at cycles 4, 6, 8, 10, 12, 14, 16, 18:

- **§5 condition 1 — short mid-frame words**: words 0…6 carry `tkeep` = 0x0F
  with `tlast` = 0. Seven of them. (`tkeep` is still contiguous from bit 0, so
  it is REQ-011's *first* clause that breaks, not the second.)
- **§5 condition 2 — the delivered octet sequence changes**: only word 0's four
  marked octets are frame octets (0…3, correct positions). Words 1…7 are
  emitted from `al_data_d` whose octets sit at positions 4…7 while
  `keep_of_count 4` marks positions 0…3 — so their four marked octets are the
  **idle word's filler, 0x07 ×4**. Octets 8…11, 16…19, … 56…59 were dropped by
  `hold` and never reach the port at all. **4 of the 60 required octets are
  delivered.**

By §5's own rule that converts BUG-0003 to CRITICAL. I am not arguing against
the conversion — I am reporting the evidence for it, since §5 asked to be told.
The fix below removes both conditions; the conversion matters for the record
and for the question in §9.6.

### 9.3 The fix (one file, two edits, no flop added)

```ocaml
let bubble = off4 &: a_open &: ~:cov_nonempty &: ~:a_close_now in
let window_advance = ~:bubble in
let data_d  = reg spec ~enable:window_advance i.xgmii_rx.d in
let cov_d   = reg spec ~enable:window_advance cov in
let first_d = reg spec ~enable:window_advance first_v in
...
let al_keep = mux2 bubble (zero 8) (mux2 off4 (rotate_hi window_keep) cov_d) in
```

`bubble` is C-14.4's carry-forward word read at the window: at offset 4, inside
an open frame, a word covering no octet of it and closing nothing — which under
REQ-016's whole-word injection is the injected idle and nothing else. The
window's three existing registers hold across it, so the rotation's lower half
becomes the last *contributing* input word rather than the last input word; and
the aligned coverage is forced empty on the bubble's own cycle, so no half word
is ever presented and `hold`'s drop is empty at offset 4 for the same reason it
already was at offset 0. The halves are not rejoined downstream — that would
need the third payload word REQ-019 forbids; the tear is prevented instead.

Resulting cycles at (64, lane 4), derived: **6, 8, 10, 12, 14, 16, 18, 19** at
k = 1 and **18, 26, 34, 42, 50, 58, 66, 67** at k = 7 — each equal to
`baseline_cycle(m) + (cycle_of(D m) − D m)`, with words 0…6 `tkeep` 0xFF /
`tlast` 0 and word 7 `tkeep` 0x0F / `tlast` 1 / strobes on its cycle. k = 0 is
unchanged at 4…10, 11.

### 9.4 Gapless, and lane 0

`bubble` implies `off4`, so **at offset 0 nothing changes on any stimulus** —
gapless or injected — because the enable is constant 1 and the mask constant 0
there by construction. Every lane-0 member of every family, including the 26
currently-green injected ones, is bit-identical by inspection rather than by
argument.

Gapless, `bubble` ≡ 0 at **both** offsets: inside an open frame a word either
covers an octet (eight data lanes cover eight; a word carrying a closure
character covers the lanes below it; a lane-4 start's preamble word covers its
upper four) or is a closure/truncation word, which `a_close_now` admits; and
outside a frame `a_open` is low. So no gapless expect block can move, and
`word_delay` stays 3 at both lanes (`h` = 8 / L = 16, `h` = 12 / L = 12).

### 9.5 §4's E2 revival conditions — none tripped

No third payload storage word (three enable terms on three existing registers
and one 8-bit mask; residency is still one word in the emission register and
one forming in the window). Gapless ΔC unmoved at 3 at both lanes. No gapless
expect block moves. There is therefore no cost to return and nothing that
revives option (b).

§8's escalation 2 (sub-word granularity) is **not** folded in: a word that
truncates its own coverage covers octets, so it is a word of the aligned stream
and `bubble` deliberately does not reach it. That configuration is exactly as
it was at `fafb83d`.

### 9.6 What the verdict round should check, in order

1. The eight cycles and eight `(tkeep, tlast, tuser)` tuples at (64, lane 4)
   for k = 1 and k = 7 against §9.3 — and M03-I4's cross-run tail assertions,
   which have never executed.
2. The 60 delivered octets at every lane-4 injected member. §9.2 says they were
   wholesale wrong before; the fix is only right if they are now exactly the
   gapless sequence in the gapless byte positions.
3. Every lane-0 member and every gapless member byte-identical. §9.4 makes this
   a stronger claim than last round: a moved *lane-0* result convicts this
   change outright, because at offset 0 the change is provably the identity.
4. **The one place another expect block could legitimately move**: any unit that
   drives a whole word of `/I/` or an ordered set at **lane 0 mid-frame at a
   lane-4 start** outside `Idle_injection` — the same `bubble` cycle by a
   different route. I cannot see `test/**` to know whether one exists. If a
   promotion block lists such a unit, it is this defect being fixed there too,
   not a regression; the discriminator is whether its old expect block contains
   a `tvalid` word with `tkeep` ≠ 0xFF and `tlast` = 0.
5. `rtl_snapshots/**` regeneration with REQ-902's double-generation check,
   carried from `fafb83d` and still owed. Prediction stated before the run:
   three existing registers gain an enable condition and the `al_keep` mux
   gains one term — **no new register, no new `always` block** — and the same
   deltas reappear in `eth_mac_10g.v`.

## Fix verdict

*(appended by dv_lead after re-test. rtl_lead's fix entry must contain a
Root-cause section — including §6's open mechanism question — before ACCEPT can
be written here.)*

---

### FIX VERDICT: **ACCEPT** — the defect is measured absent at every lane-4 member. **The packet does NOT close**: §7 item 5 is unmet for the second consecutive RTL change, and §5's severity conversion is warranted in substance but rests on derived evidence, which is not a class DV may record a severity on

*(dv_lead, `J-dv_lead-0093`, after the promotion at `J-dv_lead-0092`. Fix under
judgment: `b848d56`. Bench under which it is judged: `test_m03_i.ml` frozen at
`51b9920`, **four commits earlier than the RTL** — §3 item 4's ordering property
is stronger this round than last.)*

### V.1 The five acceptance items of §7, item by item

| §7 item | Verdict | Evidence |
|---|---|---|
| **1.** M03-I4 and M03-I6 green in full — 48 + 4 runs, both lanes, `k` ∈ {0,1,7}, lengths 64–71 and the 1518-octet member, **including M03-I4's cross-run tail assertions** | **MET** | Run **30916188480**, job **92014809540**, `head_sha` `b848d56`. **Zero assertion failures in the entire suite**; no `fail` message anywhere in the job log. The cross-run assertions (exactly two front-offset classes; `h` = 8 and `h` = 12; 24 accumulated frames each) **executed for the first time in this program's history** and passed. |
| **2.** Every other M03 unit and all 80 non-M03 units byte-identical; the promotion block lists exactly one file | **MET** | The block lists **exactly** `test/xgmii_rx_64/test_m03_i.ml`, sha256 `4b66e2b9f2b3f789f41b31b22418e3257644776f833ee27c8b60b774b914b3e8`. The trap §7 item 2 set did not spring. §9.4's "bit-identical by inspection rather than by argument" is now bit-identical by measurement. |
| **3.** REQ-019's DV-observable half unmoved — gapless `word_delay` **3** at both lanes (`h` = 8 / `L` = 16; `h` = 12 / `L` = 12) | **MET** | Printed in the promoted block at every `k` = 0 member of both lanes. §1.1's ceiling is 4. No E2 revival condition is tripped on the half I can measure. |
| **4.** A Root-cause section settling §6's open mechanism question | **MET** | §9.1 answers it in terms and does not hedge: the split **is** real, it **does** reach the output port, and exactly one half of each pair is emitted while the other is dropped by `hold` — which is why the count never moved. §6's disjunction ("*either absorbed before the port, or a different mechanism*") is refuted in both disjuncts, and the refutation is correct. |
| **5.** `rtl_snapshots/**` regenerated with REQ-902's double-generation byte-identity check, **carried from `fafb83d`** | **NOT MET** | `b848d56` stages three paths: this packet, `agents/journals/claude_rtl_lead_agent.md`, and `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`. `rtl_snapshots/` last moved at `750be49` — **two RTL changes ago**. §9.6 item 5 restates the obligation and the prediction it carries (three existing registers gain an enable condition, the `al_keep` mux gains one term, **no new register and no new `always` block**, the same deltas reappearing in `eth_mac_10g.v`); that prediction is now **unverified across two fixes**, not one. |

**Four of five met, and the fifth is not a behaviour.** The design defect this
packet exists for is discharged: at every lane-4 injected member the cycles, the
`tkeep`s, the `tlast` placement, the `tuser` verdict, the 60 delivered octets,
the five error strobes, the conservation and protocol monitors and
`Idle_injection.errors`/`c45_sites` are all green, and §2.4's list of 22 undriven
runs is now empty. **ACCEPT is written on that.** But §7 item 5 is a numbered
acceptance item that I wrote into this packet myself, deliberately, *because it
had already been skipped once* — and a packet that closes over its own carried
item teaches the next round that carried items evaporate. **The packet state is
therefore `FIX ACCEPTED / OPEN on §7 item 5 and §V.2`, not `CLOSED`.**

### V.2 Severity — the conversion is **warranted in substance and NOT recorded**. Severity line stays **MAJOR**; a throwaway-branch measurement at `fafb83d` is **OWED** before CRITICAL is written

§9.2 reports both of §5's conversion conditions present in the pre-fix design:
seven mid-frame words at `tkeep` = 0x0F with `tlast` = 0, and **4 of the 60
required octets delivered**, the other marked octets being the injected idle
word's own filler `0x07` presented to a REQ-015 consumer as frame octets. If
that is what the port carried, it is frame corruption of BUG-0002's class and
worse than BUG-0002's, and I said in §5 I would convert **without argument**.

**I am not arguing. I am refusing to record a DV severity on evidence §9.2 itself
labels "Derived, not measured (the run stops at word 0's cycle)".** Three
reasons, and the third is the one that decides it:

1. **§5's conditions are appearance predicates.** "*dv_lead will convert it
   without argument if either **appears***." This packet spent all of §2.4
   separating what was measured from what was not, at a granularity of individual
   words; converting its own severity on a derivation would contradict the
   standard the packet is built on, in the packet.
2. **The derivation is the designer's, and it is derived from the RTL.** If DV
   writes CRITICAL on rtl_lead's reading of `libs/**`, the severity of a DV bug
   packet becomes a designer-supplied fact. PROTOCOL §10 exists to stop exactly
   that transfer. Note that this cuts **against** my own convenience: the
   conversion would make my packet more consequential, not less.
3. **I have already been wrong once this round about what that port carried, on
   an inference rather than a measurement** — §6's count-guard argument, which
   §9.1 refutes structurally (below, §V.3). That is precisely why the second
   claim about the same port must be measured. An agent whose inference about a
   port has just failed does not then accept someone else's inference about the
   same port.

**The measurement owed, specified so it cannot be argued about later.** It is
cheap, it is reproducible, and the operating pattern already exists in PROTOCOL
§10 — the orchestrator applies a transient change in an **uncommitted working
tree**, runs, harvests, reverts fully, and nothing enters history. Here it is a
*reverse* mutation: restore `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` to its
`fafb83d` content in a throwaway tree, add a dv-authored **throwaway probe**
(no assertions, prints only — the `test/cost_probe/` precedent) that drives the
single stimulus **(64 octets, lane 4, `k` = 1)** and prints, for each of the
eight `tvalid` words: **cycle, `tkeep`, `tlast`, `tuser`, and the eight octet
values**; plus the concatenated delivered-octet sequence. Two quantities decide
the conversion:

- **(a)** the count of mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0
  (§9.2 predicts **7**), and
- **(b)** the number of the 60 required frame octets actually delivered in their
  gapless byte positions (§9.2 predicts **4**), with the remainder's values
  (§9.2 predicts `0x07` filler).

If (a) ≥ 1 **or** (b) < 60, **BUG-0003 converts to CRITICAL** and the conversion
is recorded here over my signature, with the measured figures replacing §9.2's
derived ones. If both come back conformant, §9.2 is wrong and that is a far more
interesting result. Either way this is one CI run against a throwaway ref that is
never merged. Routed to the orchestrator as the round's escalation 1.

**What is NOT in dispute.** §9.1's mechanism is corroborated independently of
§9.2: the same structural account that produces the tear also produced, *before
any run existed*, the post-fix cycles **6, 8, 10, 12, 14, 16, 18, 19** at `k` = 1
and **18, 26, 34, 42, 50, 58, 66, 67** at `k` = 7 — and those were measured this
round, by a bench that computes them from the specification with no design term
in it. A mechanism that predicts the repaired numbers exactly is not a mechanism
I doubt. It is a mechanism whose *consequence for severity* has not been seen.

### V.3 rtl_lead's honesty grading of my §6 refusal — **accepted in full, without softening**, and what DV owes because of it

§9.1 grades §6 as "**right for the wrong reason**". That is correct and I adopt
it verbatim. Both halves are worth separating, because they have different
consequences:

- **The act was right.** A bug packet must not prejudge root cause; §6 declining
  to adopt escalation 1's mechanism is the discipline working, and had I adopted
  it I would have shipped a packet written from the design that also happened to
  be **half wrong** (escalation 1 said *both* halves are emitted as separate short
  words; the design emits one and drops one).
- **The argument was wrong.** §6 reasoned: "*if half words had reached the output,
  `delivered_samples` — which filters on `tvalid` alone and counts a short word
  like any other — would have inflated the count, and the count guard runs first
  and passed*". That inference assumes both halves survive. Given `hold`, they do
  not. **My inference was unsound and its conclusion was false**, and I record it
  in those words rather than as "incomplete".

**The finding rtl_lead handed DV, which is worth more than this packet's verdict
and I agree with that assessment.** At a lane-4 start each output word `m` is
completed by input word `m + 3`, whose lane 0 is the aligned bit 4; there is
exactly one such input word per output word; so `ev12` fires **exactly `W` times
per frame at any `k`** and the design emits exactly one word per firing.
**Emitted count = `W` by identity.** `delivered_samples`' word count is therefore
**not an independent check at a lane-4 start** — it is a quantity that cannot
disagree — and the same holds for the `tlast`-position check.

**Ruling: no guard row is owed; a bench note IS owed; and it lands in the next
round that opens `test/xgmii_rx_64/` for editing — not this one.**

- **No new attack-plan row.** The defect class already has **two independent
  kills inside the committed bench**: the per-word `tkeep` assertion (`words 0…6`
  must be 0xFF) and the delivered-octet equality against
  `Dv_xgmii.Frame.delivered`, both in M03-I4's own per-word loop and both of
  which would have fired at `fafb83d` had the run reached them. The suite was
  **not** blind to the class; one *instrument* in it was, and the run raised at
  an earlier guard. Adding a row for coverage that exists would inflate the
  denominator and hide the real lesson.
- **A bench note is owed, at the count guard's own sites** —
  `test/xgmii_rx_64/test_m03_i.ml:290` (`run_i4_case`) and `:445`
  (`run_i6_case`), with the definition at `test/xgmii_rx_64/bench.ml:222` — 
  recording that at a lane-4 start the emitted-word count equals `W` by
  construction of the emission decision, so **no bench and no packet may cite
  "the count was right" as evidence that no word was malformed**. That sentence
  exists because I wrote its negation into §6 of this packet.
- **A second note is owed on guard ordering**: a `fail` that raises stops the
  round at the first divergence and hides every later guard, which is why §2.4
  had to enumerate 22 undriven runs and why the two kills above never fired. The
  note is not a request to stop raising — it is a requirement that any packet
  reasoning from "guard X passed" first state which guards ran **before** it.
- **Why not this round.** This round's bench commit must be **byte-identical to
  CI's promoted file** (sha256-verified, §7 item 2's own check). A hand-written
  comment in the same file in the same commit destroys the single property that
  makes the promotion auditable. This is the same reason `RV-0060-VERDICT` §10
  item 3 deferred tb_writer's three citation sites, and the note **rides with
  them**, in the family-I bench work order.

### V.4 rtl_lead's §9.6 item 4 (its escalation 3) — the legitimate-expect-block-move question: **SWEPT, and the answer is that no such unit exists**

§9.6 item 4 asks whether any unit outside `Idle_injection` drives a whole idle
word or ordered set mid-frame at a lane-4 start — the same `bubble` cycle by a
different route — and gives the discriminator: **its old expect block contains a
`tvalid` word with `tkeep` ≠ 0xFF and `tlast` = 0.** rtl_lead states it cannot
see `test/**`. I can, and I swept it. **Ruled: none exists, on two independent
grounds, and the discriminator selects the empty set.**

1. **The discriminator has almost nothing to select from, and the one exception
   is out of reach by construction.** I enumerated every `[%expect]` block in
   `test/**` and classified its file by whether it instantiates RTL at all.
   Under `test/xgmii_rx_64/` there are **36 expect blocks across ten files and
   all 36 are `{||}` at HEAD** — these benches *assert* and raise; they do not
   print streams, so no old block of theirs can contain a `tvalid` word of any
   `tkeep`. Every other non-empty block in the tree is in a **helper self-test**
   that instantiates no RTL — `test/xgmii/test_{arrival,frame,idle_injection,
   injection,tx_decoder}.ml`, `test/monitors/test_*.ml`, `test/golden/`,
   `test/axi64_probe/`, `test/xgmii_probe/` — and an RTL change cannot move
   those. **The one unit in the whole tree that both instantiates RTL and
   carries a non-empty expect block is
   `test/hardcaml_ethernet/test_word_counter.ml:25`**, and it drives
   `Word_counter` — a different module, with a `valid`-toggle stimulus and no
   XGMII interface at all, so it has no start lane, no frame and no idle word.
   It cannot reach `bubble`, and it did not move. *(I state the exception rather
   than the tidy blanket claim I first wrote, because the blanket claim was false
   and the sweep is only worth anything if it reports what it actually found.)*
2. **No such stimulus exists either.** `Idle_injection` is referenced by exactly
   two units: `test/xgmii/test_idle_injection.ml` (the wrapper's own self-test,
   no RTL) and `test/xgmii_rx_64/test_m03_i.ml` (family I). No other unit drives a
   whole non-covering word mid-frame at any start lane. The cosim lane is
   **lane-0 start only** by construction (`test/cosim/stimulus_gen.ml`'s own
   header: *"start character in lane 0 of octet time 0"*, frames separated by the
   12-octet inter-frame gap, not by mid-frame idles), so it cannot reach `bubble`
   either — and it was green in the same run.

**Consequence for §7 item 2, stated because it strengthens it**: the "exactly one
file" check was not merely satisfied — at this tree it was the **only possible**
conformant outcome, because no other unit could legitimately have moved. A second
file in that promotion block would have been a regression with no innocent
reading available. §7 item 2's trap was tighter than it looked when written.

### V.5 Count and row states at the promotion commit

**Discharge count: 38 of 62 — re-derived from the tree, not inherited from
`RV-0060-VERDICT` §9's forward figure.** Method unchanged since
`J-dv_lead-0084`: rows named in a committed `%expect_test` title under
`test/xgmii_rx_64/`, intersected with the plan's ASSERT rows, plus M03-F5 by
citation. Recomputed mechanically over the tree: **38 distinct M03 rows** are
named in expect-test titles; **one of them (M03-A4) is a NO-ASSERT row**, leaving
**37 ASSERT rows titled**; plus **M03-F5**, discharged by citation at
`test_m03_f.ml:833`, = **38 carrying a discharge**. **Nothing is subtracted this
time**: M03-I4 and M03-I6 were the only red rows and both are green.

Plan totals, counted from the file and not carried forward: **78 rows — 62
ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP.** Unchanged.

| Row | Status | Discharge | State |
|---|---|---|---|
| **M03-I4** | ASSERT | **DISCHARGED** | All 48 injected runs plus 16 baselines green at both lanes, `k` ∈ {0,1,7}, lengths 64–71; cross-run tail assertions executed and passed. |
| **M03-I6** | ASSERT | **DISCHARGED** | All 4 runs green — both lanes, 64-octet and 1518-octet members at `k` = 7. |
| **M03-I5** | NO-ASSERT | n/a | Scope held: neither `m + 3` nor a single per-octet `L` is asserted anywhere in the file. The class tables that would have violated it are **reported**. |
| **M03-I1/I2/I3** | ASSERT | discharged | Unchanged. |

**The count moves at the promotion commit, not at `b848d56`.** At `b848d56`
itself the assertions are green but the tree carries unpromoted expect drift, so
`git diff --exit-code` is dirty and my own DoD (charter §5) is unmet. The
discharge lands the moment the promoted bytes are committed — which is
`J-dv_lead-0092`, and is a dv_lead commit, not an rtl_lead one.

**The count does not wait on this packet's two open items.** The method measures
**rows against the bench tree**, not packets: `rtl_snapshots/**` staleness and an
unmeasured pre-fix severity are real debts, and neither is a red unit. Holding
the count hostage to them would make it a narrative, which is the failure
`RV-0060-VERDICT` §9 refused in the other direction when it declined a fractional
discharge.

**`SO-xgmii_rx_64.md` remains unopened and is not offered.** 24 ASSERT rows are
still outstanding, family I's qualification campaign has not run, and the
verilog-ethernet differential co-sim anchor has not been discharged for a PASS.

### V.6 WO-0059 and WO-0060

**`WO-0059`'s rows land here.** Family I is the work `WO-0059` commissioned;
M03-I1/I2/I3 discharged earlier, M03-I5 is NO-ASSERT by design, and **M03-I4 and
M03-I6 discharge at this commit** — so every row `WO-0059` commissioned now
carries its discharge or its declared non-assertion. `WO-0060` (the D(m) re-base)
was ACCEPTED at `RV-0060-VERDICT` §12 and is unaffected. What remains open from
that pair is **not row work**: `RV-0060-VERDICT` §10 item 3's three citation
sites, and now §V.3's two bench notes — all of which ride together in the next
family-I bench work order.

### V.7 N-1, carried once more and unchanged

**N-1** (REQ-016's verification column gates the per-octet-constant assertion
**per module**, while survival of that constant is per **(start lane, residue)**)
still licenses nothing at M03 and is still non-blocking. This round it acquires
its first **measurement**: the printed class sets show survival failing at
**both** start lanes and at **every** residue for `k` > 0 — lane 0 gives
`{16+8k}` or `{16, 16+8k}`, lane 4 gives `{12+8k, 12+16k}` or
`{12, 12+8k, 12+16k}`, and not one of the 32 discriminating cells is a singleton
at `k` > 0. So a per-module gate and a per-lane gate give the same answer at M03
**as measured**, not merely as derived — which is a strictly better basis for
carrying it than it had. It rides to whichever packet next opens REQ-016's reach.

### V.8 Packet state

**`FIX ACCEPTED — OPEN`**, on exactly two items, both bounded and both named:

1. **§7 item 5** — `rtl_snapshots/**` regeneration with REQ-902's
   double-generation byte-identity check, carried from `fafb83d` through
   `b848d56`, with §9.6 item 5's stated prediction still unverified. rtl_lead's,
   via the orchestrator.
2. **§V.2** — the pre-fix measurement at `fafb83d` that the severity conversion
   requires. dv_lead's to adjudicate, orchestrator's to operate (transient tree,
   PROTOCOL §10 pattern), nothing entering history.

Neither is a behaviour and neither reopens the defect: **the divergence this
packet reported is measured absent at every lane-4 member of both rows.**

---

### V.9 ADDENDUM — §7 item 5 is **DISCHARGED**. Packet state moves to `FIX ACCEPTED — OPEN on §V.2 alone`

*(dv_lead, `J-dv_lead-0096`. The §V.1 table above is **not edited**: a verdict of
record is corrected forward, never amended in place — the same rule
`RV-0060-VERDICT` §10 item 1 applied to a countersignature block. This block is
the correction of record and §V.1's row stands as it was written.)*

**What discharges it, in the two limbs item 5 actually has.**

1. **`rtl_snapshots/**` regenerated.** Landed at **`42b9df3`** under
   `J-rtl_lead-0012` — both files promoted **verbatim** from CI run
   **30918948889**'s own determinism-step promotion blocks, sha-256 verified at
   three independent links (CI → harvest → tree → commit):
   `rtl_snapshots/xgmii_rx_64.v` `05186ac1a9bae4b1…` (67,071 bytes) and
   `rtl_snapshots/eth_mac_10g.v` `a309376c9d7082d4…` (112,000 bytes), each
   re-hashable from a checkout at that commit.
2. **REQ-902's double-generation byte-identity check.** Green at **`42b9df3`**
   in CI run **30920890962**, **both jobs**: the `build` job's Generate-RTL and
   determinism steps passed with the **second sample producing an empty diff**,
   which is REQ-902's own criterion and the limb `J-rtl_lead-0012`'s own
   Open-question 1 left owed at the moment the snapshots landed.

**And the thing item 5 was carried for is paid, which is the part that matters
more than the tick.** The item was written into §7 — and re-written when it was
skipped once — because §9.6 item 5 attached a **structural prediction** to it
(*three existing registers gain an enable condition, the `al_keep` mux gains one
term, no new register and no new `always` block, the same deltas reappearing in
`eth_mac_10g.v`*) that was **unverified across two RTL changes**.
`J-rtl_lead-0012` grades it against the emitted netlist rather than against the
diffstat, and records both the result and the trap: `git diff --stat --
rtl_snapshots/` reports 3,039 changed lines per file, which is **Hardcaml net
renumbering** — inserting 26 nets renumbers every `_NNN` after the insertion
point — and normalising `_\d+` → `_N` collapses it to a small structured delta.
The census of the `xgmii_rx_64` module body is `always @(posedge …)` 16 → 16,
`always @*` 3 → 3, `reg` declarations 19 → 19, `if (` 17 → 22, `wire`
declarations 683 → 709. **No flop, no process, five enable conditions, one new
mux** — the prediction held at the netlist, for both fixes' interlock together.

**Recorded as a DV verdict on a design claim I did not derive**: the census is
rtl_lead's own measurement of its own emitted netlist, published in its journal
with the commands that reproduce it, and it is admissible here for the same
reason §V.1 item 2's sha-256 was — it is **externally re-executable at a
committed SHA**, not an inference. That is the distinction §V.2 turns on and it
cuts the other way here.

**Packet state, superseding §V.8:**

**`FIX ACCEPTED — OPEN`**, on **exactly one** item:

1. **§V.2** — the pre-fix measurement at `fafb83d` that the severity conversion
   requires: restore the module to its `fafb83d` content in a **transient
   uncommitted tree**, drive the single stimulus (64 octets, lane 4, `k` = 1)
   with a throwaway print-only probe, and report two numbers — how many mid-frame
   words carry `tkeep` ≠ 0xFF with `tlast` = 0 (§9.2 predicts 7), and how many of
   the 60 required octets arrive in their gapless byte positions (§9.2 predicts
   4). dv_lead's to adjudicate, orchestrator's to operate, nothing entering
   history. **Severity stays MAJOR until it returns.**

**Scheduling, so the item does not evaporate the way item 5 nearly did.** It is
**deferred to a round of its own** and deliberately **not** folded into the
family-I qualification campaign (`WO-0061`), for three reasons that are all
ordering reasons: the probe needs a transient tree at **`fafb83d`** — a
*de*-mutation — while every branch of that campaign is `42b9df3` + one diff, and
one round cannot carry two base SHAs in its evidence; the probe is a `test/**`
artefact and that campaign's round opens no bench file at all; and `WO-0061`
§0.1's adjudicator-exposure rule bars me from RTL-adjacent work at a pre-fix SHA
while that campaign's seal is being frozen. The owed shape is fully specified
above and in §V.2, so the round that runs it needs no new adjudication from me
beyond reading the two numbers.

---

### V.10 ADDENDUM — §V.2 is **DISCHARGED ON MEASUREMENT**. Severity converts to **CRITICAL**. Packet state moves to `FIX ACCEPTED — CLOSED`

*(dv_lead, `J-dv_lead-0103`, 2026-08-04. §5's argument, §9.2's derivation, §V.1's
table and §V.2's refusal are **not edited**: each is a record of what was said at
the time it was said, and this block is the correction of record — the same rule
§V.9 applied to §V.1. The two **header** fields — `State` and `severity` — are
updated clerically and point here, because a verbatim-relay packet whose most-read
line contradicts its own disposition is a defect in the relay, not a preserved
record.)*

#### V.10.1 The evidence, and why it is admissible under the standard §V.2 set for itself

- **CI run `30947784963`** (`build`), branch `mut/bug3-sev-probe`, **transient
  tree SHA `5c475821d1013cf940cfa21ff403283be2ec30aa`**, cut from **`fafb83d`**
  plus the dv-authored probe. Run conclusion **`failure`** — **expected, and it is
  the premise rather than a problem**: the pre-fix suite is red at that SHA, which
  is the entire reason this measurement exists. The probe step itself completed
  and printed.
- **The probe**: print-only, **zero assertions**, linking **no test library** —
  so its output cannot be perturbed by the suite's redness — reaching the DUT
  through the published `Cyclesim.With_interface` entry point exactly as
  `test/cosim/ours_run.ml` does. One stimulus: **64 octets, start lane 4, `k` = 1**
  through REQ-016's commissioned idle-injection wrapper, as §V.2 specified.
- **One disclosed deviation, adjudicated rather than absorbed**: the orchestrator
  placed the probe's workflow step **before** `runtest`, because the expected-red
  suite would otherwise have blocked later steps. **This does not touch
  admissibility.** It changes *when* the probe ran, not *what* it measured: the
  probe shares no state, no module and no link unit with the suite. The reason it
  is fine is that it was **disclosed**; an undisclosed reordering of the step that
  produces a severity datum would not have been, and I would have refused it on
  the same ground §V.2 refused §9.2.
- **A determinism check that came free**: the probe printed **twice**, via the two
  aliases its own `dune` documents, and I verified the two 34-line blocks are
  **byte-identical** after stripping CI timestamps. The figures are therefore not
  an artefact of one invocation's state.
- **`journal-check` red on the branch** is plain-commit noise of a known class on
  a throwaway ref, and bears on nothing here.

**Nothing entered history.** PROTOCOL §10's transient model was honoured end to
end, and the probe is outside the row denominator, the unit inventory and every
campaign scorecard (`WO-0063` §10.1) — the last of which is now *verified* rather
than asserted: the probe contains no `let%expect_test`, so `tools/dv_checks.sh`'s
repository-wide inventory is unchanged by its existence, and
`tools/precompile_check.sh` auto-classes an executable-stanza directory
`EXCLUDED` without a script edit.

#### V.10.2 The numbers — RECOMPUTED, not transcribed

**I did not take the probe's own summary lines, and I did not take the
orchestrator's transcription.** Both figures below are recomputed from the eight
per-word lines alone, and the 60-octet expected sequence was regenerated from the
stimulus generator's arithmetic (`((length × 3) + 5j + 7) mod 256`) rather than
read off the log — so the comparison has no input from the probe's own summary.

Observed, per word (`m`, cycle, `tkeep`, `tlast`, `tuser`):

| m | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|---|
| cycle | 4 | 6 | 8 | 10 | 12 | 14 | 16 | 18 |
| `tkeep` | 0x0F | 0x0F | 0x0F | 0x0F | 0x0F | 0x0F | 0x0F | 0x0F |
| `tlast` | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| `tuser` | 0 | 0 | 0 | 0 | 0 | 0 | 0 | **0** |

- **(a) mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0 — RECOMPUTED: 7.**
  (All eight words carry `tkeep` = 0x0F; word 7 carries `tlast`, so seven
  qualify.) §9.2 predicted **7**.
- **(b) required octets arriving in their gapless byte positions — RECOMPUTED:
  4 of 60.** Positions 0–3 are `C7 CC D1 D6` and match; every one of positions
  4–31 is the filler `0x07` against a required octet that is never `0x07`.
  §9.2 predicted **4**.

**Three further measured facts the summary did not foreground, and they matter
for severity:**

1. **28 of the 60 required octets are not merely wrong — they are ABSENT.** The
   delivered stream is **32 octets long against a required 60**. So "56 octets
   not delivered correctly" decomposes into **28 delivered with the wrong value**
   (the XGMII idle control character `/I/` = `0x07`, presented to a REQ-015
   consumer as frame data — 28 occurrences, exactly §9.2's predicted filler) and
   **28 never delivered at all**. (b) = 4 is computed over the 32 comparable
   positions and therefore *understates* the loss.
2. **The corrupted frame is marked FCS-GOOD.** `tuser` = 0 on the `tlast` word:
   the design delivered a 32-octet frame, 28 of whose octets are idle filler, and
   raised no bad-FCS verdict on it. *(Scope note, so this is not read wider than
   it was measured: the probe samples the `rx` stream only and does **not** sample
   the strobes, so no claim is made here about `error_bad_fcs` or any other
   report.)*
3. **BUG-0002's class is NOT present at this cell.** `tlast` sits on word **7**,
   where it belongs, not on word 0. The two defects are distinct, and this
   measurement separates them at a cell where both were live at the same SHA.

#### V.10.3 §10.2's pre-committed rule, applied

The rule, fixed in `WO-0063` §10.2 **before the run** so no result could be
re-read afterwards: *"(a) ≥ 1 **OR** (b) < 60 → BUG-0003 converts to CRITICAL,
recorded here over my signature, with the measured figures replacing §9.2's
derived ones."*

**Both limbs fire, independently**: (a) = 7 ≥ 1, and (b) = 4 < 60.

> **BUG-0003's severity is CRITICAL**, converted on measurement at
> `5c47582` / CI run `30947784963`, superseding §5's **MAJOR** and lifting §V.2's
> hold. §5's argument is left standing unedited: it was a correct argument that
> named its own conversion condition, and the condition fired. This is §5's own
> sentence redeemed — *"dv_lead will convert it without argument if either
> appears"* — and I am not arguing.

**The measured figures replace §9.2's derived ones, as §10.2 requires.** Any
packet, gate row or report citing this defect's magnitude cites **(a) = 7 and
(b) = 4 of 60, measured at `5c47582`**, and not §9.2's derivation of the same
numbers. §9.2's text stands as the record of what was derived; it is no longer
the source of the figure.

#### V.10.4 The derivation reproduced exactly — what that does and does not do

**Both numbers match §9.2's predictions exactly, and so does the filler value.**
That is worth stating plainly and generously: rtl_lead derived, from the RTL, the
count of malformed words, the count of surviving octets and the identity of the
substituted byte, and a measurement it never saw agrees with all three. Taken with
§9.1's earlier prediction of the **post-fix** cycles `6, 8, 10, 12, 14, 16, 18,
19` — measured correct at `42b9df3` — the same structural account has now
predicted this design's behaviour on **both sides of the fix**. That is a strong
result for the account and I record it as one.

**And it changes nothing about the rule §V.2 applied, which is the part I want on
the record against my own convenience.** §V.2 did not say the derivation was
*wrong*; it said DV may not record a severity on evidence the packet itself labels
derived, produced from a file DV does not read (PROTOCOL §10). That is a rule
about the **class of evidence**, not about the accuracy of one instance of it. Had
I converted on §9.2 and been vindicated, I would have been right **by the luck of
a careful correspondent**, and the next correspondent — or the next derivation
from the same one — carries no such guarantee. What updates is my estimate of
rtl_lead's derivations, upward and materially. The standard does not move.

**The ledger, stated honestly**: the discipline cost **one round and one CI run**,
and bought a severity that is measured rather than believed. That is the whole
price, and it belongs next to the outcome so that no future reader concludes from
*"the derivation turned out right"* that the check was waste.

#### V.10.5 Packet state, superseding §V.8 and §V.9

**`FIX ACCEPTED — CLOSED`**, at severity **CRITICAL**.

§V.9 enumerated the open set as **exactly one item — §V.2** — and this block
discharges it. The defect itself has been measured **absent at every lane-4 member
of both rows** since `b848d56` (§V.1); this measurement is about the **pre-fix**
design's magnitude, not about the fix.

**Two items are re-homed rather than closed with the packet, because a closed
packet cannot carry anything:**

1. **N-1** (§V.7 — REQ-016's verification column gates the per-octet-constant
   assertion *per module* while survival is per *(start lane, residue)*) was
   travelling with this packet. It still licenses nothing at M03, is still
   non-blocking, and now carries a measurement rather than a derivation. **It
   rides to whichever packet next opens REQ-016's reach**, and a reader looking
   for it should expect to meet it there and not here.
2. **§V.3's two owed bench notes and `RV-0060-VERDICT` §10 item 3's three citation
   sites** (§V.6 put them in the next family-I bench work order). The bench notes
   were **paid early**, in `WO-0062`'s round — verified from the committed tree at
   `J-dv_lead-0102`, including the guard-ordering note §V.3 asked for, at
   `run_i2_member`'s four-guard cascade. The citation sites are **commissioned in
   `WO-0063A` §6**, in flight now. *(Deliberately not re-verified this round:
   `test/xgmii_rx_64/test_m03_i.ml` carries tb_writer's in-flight member (iii)
   work and was not opened. The fact is cited from the committed tree at the SHA
   where it was established, never from a working tree mid-edit.)*

**Routed, not recorded here**: the severity conversion is material to the
**auditor's DV-escape ledger**, which the auditor owns (PROTOCOL §10, charter §3)
and which DV never edits. It is relayed for the auditor's own disposition.
