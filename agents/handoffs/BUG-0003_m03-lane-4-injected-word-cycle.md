# BUG-0003: at a **lane-4** start under REQ-016's commissioned idle injection, M03 emits output word 0 with **no delay at all** where §0.5 requires exactly the idle cycles inserted at or before its deciding input word — the same rule the same design obeys at a lane-0 start, on the same frame, in the same run

- **State**: **OPEN** — dv_lead's packet. The orchestrator allocates the packet
  number and relays it **verbatim** (PROTOCOL §3); the `NNNN` in this filename
  is dv_lead's prediction of the next free id and is the orchestrator's to
  confirm.
- **From** / **To**: dv_lead → rtl_lead (via orchestrator, VERBATIM relay class)
- **Module / severity**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03
  `Xgmii_rx_64`) | **MAJOR**, argued in §5 against BUG-0002's CRITICAL, with the
  exact condition that converts it stated there rather than left to be
  discovered.
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
