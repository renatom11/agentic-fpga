# BUG-0002: M03 marks `tlast` on output word 0 of an eight-word frame when REQ-016's wrapper injects one idle cycle inside the open frame — the delivered tuple sequence is changed, which REQ-016 forbids in its own normative sentence

- **Module / severity**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03,
  `Xgmii_rx_64` — the path BUG-0001 named; **I did not open it, this round or
  last**) | **CRITICAL**
- **From** / **To**: dv_lead → rtl_lead (via orchestrator, **verbatim relay
  class**, PROTOCOL §3)
- **Packet id**: `0002` is the only number monotonic-per-prefix at this SHA
  (`BUG-0001` is the sole existing packet of this prefix). Allocation is the
  orchestrator's (PROTOCOL §3); if it allocates differently, **rename the file
  and this header** — the journal entry `J-dv_lead-0084`'s
  `Files-in-this-commit` list is the binding statement of the committed path.
- **Found by**: `test/xgmii_rx_64/test_m03_i.ml`, rows **M03-I4** and
  **M03-I6** — `AP-xgmii_rx_64.md` §4.I. The two rows are independent members
  (one idle cycle per boundary and seven), and both fail on the same word of
  the same frame.
- **Evidence**: CI run **30881653846** at commit **`4901161`**, job
  **91904129422**, step `opam exec -- dune runtest`, exit code 1. Compile clean;
  M03-I1, M03-I2 and M03-I3 green; every other family green; **exactly one file
  promoted** (`test/xgmii_rx_64/test_m03_i.ml`) in **exactly two hunks**, the
  `%expect_test` blocks of M03-I4 and M03-I6.
- **Not an escape.** `SO-xgmii_rx_64.md` does not exist and no sign-off has ever
  been offered for this module. This is a defect found by the bench that was
  written to find it, on the first stimulus in this programme that has ever
  driven an idle cycle inside an open frame at any DUT.

---

## 1. Reproduction

```
opam exec -- dune build @default
opam exec -- dune runtest
```

at `4901161`. Two units raise:

```
M03-I4 (length 64, lane 0, idles 1): word 0 unexpectedly carries tlast
M03-I6 (length 64, lane 0): word 0 unexpectedly carries tlast
```

raised at `test/xgmii_rx_64/test_m03_i.ml:1061` and `:1470` respectively (the
`List.iteri` bodies beginning at `:1037` and `:1450`). M03-I6's member drives
**seven** idle cycles per boundary where M03-I4's failing member drives one, so
the two are separate figures of §10's commissioned three (0, 1, 7) and not one
observation counted twice.

**The stimulus, stated so it can be rebuilt without this bench.** One
64-octet frame (destination address through FCS, §0.3), start character `/S/`
in **lane 0** at octet time 8 — source cycle 1. Preamble occupies octet times
8 … 15 (SPEC-M03 §6.1). Frame octets 0 … 63 occupy octet times 16 … 79, i.e.
source cycles 2 … 9, eight per cycle. The terminate character `/T/` is at octet
time 80, lane 0 of source cycle 10 (REQ-106). `Idle_injection.uniform ~idles:k`
then inserts `k` idle words — eight lanes of `/I/` = 0x07, `Xgmii_word.idle`,
requirements.md §2 — at **every** inter-word boundary from the one after the
word carrying the frame's first octet through the one before the word carrying
the terminate character: boundaries before source cycles **3 … 10**, eight of
them.

**The stimulus is the one the specification commissions, and its legality was
asserted by the bench before the design was driven** (`:993–1007`, `:1418–1428`):
`Idle_injection.errors` empty and `Idle_injection.c45_sites` empty on every run.
SPEC-M03 §6.1 and §10's REQ-016 hook prohibit exactly one boundary per frame —
between a frame's start character and its first octet (**M03-N3**) — and
`uniform` begins one boundary later, by construction.

---

## 2. Observed vs expected

### 2.1 What the specification requires, derived clause by clause

**REQ-016 (normative sentence, unchanged by any diff of this round)**: *"a
producer MAY deassert `tvalid` between words of a frame, and every consumer
SHALL tolerate arbitrary idle gaps **within a frame without corrupting it**: k
idle cycles before an input word delay every octet that word carries by exactly
8k octet times **and change nothing else**."*

**SPEC-M03 §6.2, the `Frame` row (frozen; untouched by `a77017c`)**: *"An input
word covering **no** frame octet — a terminate character in lane 0, or **an idle
cycle injected under REQ-016** — **holds** the frame: the CRC register holds by
its enable, the octet count holds, no output word is produced and **no condition
is raised** (C-14.4)."* The `Frame` row's exit list is `/T/`, `/E/`, `/S/` and
REQ-108's count — an idle word is **not** an exit. That the exclusion is
deliberate is visible one row up: the `Preamble` row enumerates *"any other
control character in a preamble position — `/I/` and `/Q/` included"* as an exit,
and the `Frame` row does not.

**SPEC-M03 §6.1, C-14.4**: an input word covering no frame octet *"carries the
frame forward without advancing m: it is **not** a condition"*.

**REQ-103 / REQ-011**: the output stream ends with the last octet before the four
FCS octets; `tkeep` on the `tlast` word marks exactly the valid octets; on every
word except the `tlast` word `tkeep` is 0xFF. **REQ-015**: a stream carries the
words of exactly one frame between successive `tlast` words.

**requirements.md §0.5, "What survives idle injection"** (ruled at `a77017c`,
`J-architect_docs_lead-0024`): idle injection *"changes nothing else about the
output: the ordered sequence of (`tdata`, `tkeep`, `tlast`, `tuser`) tuples is
unchanged, and every octet keeps its byte position within its word."*
**SPEC-M03 §6.1's D(m)** makes the `tlast` word's deciding input word the word
carrying the **terminate character**, because *"its `tkeep`, its `tlast` and its
`tuser`[0] are not decidable until that character arrives (REQ-011, REQ-103,
REQ-104)"*, and adds: *"an earlier emission would put `tkeep`, `tlast` and
`tuser` ahead of the character that decides them."*

**This bug does not depend on the `a77017c` ruling.** REQ-016's normative
sentence, §6.2's `Frame` row, REQ-011, REQ-015 and REQ-103 are all older than it
and all untouched by it; each one alone convicts the observation below. The
ruling is cited because it states the same thing most directly, not because it is
load-bearing.

### 2.2 The conformant output, computed for the failing member

Injected-line cycle of source cycle *c*: *c* for *c* ≤ 2, and 2*c* − 2 for
2 ≤ *c* ≤ 10 at k = 1 (8*c* − 14 at k = 7). Deciding input word of output word
*m*: source cycle of frame octet 8*m* + 7 = 2 + *m* for *m* ≤ 6; the terminate
word, source cycle 10, for *m* = 7.

| output word | tkeep | tlast | tuser[0] | cycle, k = 1 | cycle, k = 7 |
|---|---|---|---|---|---|
| 0 | 0xFF | **0** | — | 4 | 4 |
| 1 … 6 | 0xFF | **0** | — | 6, 8, 10, 12, 14, 16 | 12, 20, 28, 36, 44, 52 |
| 7 | 0x0F | **1** | 0 | 19 | 67 |

Sixty delivered octets in eight words; no strobe of any kind.

### 2.3 What the design produced

At **both** figures, on the **first** output word:

- **`tvalid` word count: 8** — the conformant count. The bench's count guard
  (`:1023`, `:1440`) passed, so the design emitted neither more nor fewer.
- **word 0's cycle: 4** — the conformant cycle, and the guard that checks it
  (`:1041`) passed at both figures. This is the first measurement in this
  programme that confirms §6.1's D(m) rule against hardware rather than
  deriving it.
- **word 0's `tkeep`: 0xFF** — conformant (guard at `:1056` passed).
- **word 0's `tlast`: 1 — NOT conformant.** Word 0 is not the frame's last word:
  the frame delivers 60 octets and word 0 carries frame octets 0 … 7. The design
  closed the delivered frame on its first word.

The un-injected member of the **same** `(length, lane)` through the **same** code
path — `M03-I4 (length 64, lane 0, idles 0)` — completed green immediately
before, and printed:

```
[M03-I4 (length 64, lane 0, idles 0)] frames=1 octets=60 latency=CONSTANT per front offset (1 class)
  h=8 L=16 word_delay=3 frames=1 octets=60
```

so the guard that fired is the same guard, in the same function, that passes on
the same frame when `k` = 0.

### 2.4 What is **not** measured, said explicitly

`fail` raises, so the run stops at word 0. **Unmeasured** at the failing member:
words 1 … 7's `tkeep`, `tlast` and cycles; `tuser`[0] anywhere; the 60 delivered
octet values; the five error strobes; the conservation and protocol monitors'
verdicts; and the per-octet latency classes M03-I4 was rebuilt to *report*. Of
M03-I4's 48 injected runs, **one** has been driven past its first output word
(the k = 0 member of length 64 / lane 0); the other 47 and all four of M03-I6's
are unexecuted beyond the point of the raise. Nothing in this packet claims
anything about lane 4, about any length other than 64, or about the 1518-octet
member.

---

## 3. Why this is the design and not the bench — the three alternatives, ruled out rather than assumed

This is the same discipline `RV-0059-VERDICT` §2 and §3 applied last round, when
it ruled the opposite way on a red from this same file and opened no packet.

**(a) The guard is not injection-dependent, and it is green at k = 0.** The
predicate is `if m = words - 1 then require tlast else require (not tlast)`
(`:1058–1061`, `:1467–1470`). It contains no term derived from `Idle_injection`,
from `k`, or from any cycle. `words` = 8 is computed from the frame length
independently (`delivered = length − 4`, `words = ⌈delivered / 8⌉`) **and**
cross-checked against a separately driven, un-injected simulation of the same
`(length, lane)` whose own word count and `tlast` cycle are guarded at `:1214`
and `:1217`. The k = 0 member runs the identical predicate over the identical
frame and passes.

**(b) There is no stream to mis-walk.** `delivered_samples` is
`List.filter ~f:(fun s -> s.out.tvalid)` (`bench.ml:222`) — it does not parse
frames, so there is no walk to get wrong; and the sample view is `Before`
(`f(regs(c), word(c))`, `bench.ml:136`), this bench's asserted view since
`RV-0038-R6` and the view under which every other M03 family is green. A
`tvalid`-and-`tlast` word on the injected line is a real event a consumer
registers.

**(c) The stimulus is legal and is the commissioned one.** §1 above.
Additionally: an idle word inserted at any of boundaries 3 … 10 lands strictly
inside the open frame, where §6.2's **`Frame`** row governs — not in a preamble
position, where §6.2's **`Preamble`** row would route it to REQ-105. The one
boundary that would land in a preamble position is M03-N3's, and `uniform`
refuses it at both start lanes (`idle_injection.ml:150`, `first =
first_octet_cycle + 1`); the refusal was asserted, not assumed, before the design
was driven.

**A fourth reading, and the evidence that rules it out.** If the design had
routed the mid-frame idle word to REQ-105 — treating it the way §6.2's
`Preamble` row treats `/I/` in a preamble position — it would have aborted the
frame, emitted **one** output word, and the count guard at `:1023` would have
raised first with *"expected 8 output words, got 1"*. It did not. **The design
emitted the conformant number of words at the conformant cycle and marked the
first of them last.** The state machine did not abort; the framing marks are
wrong.

---

## 4. A prediction, stated in the open

Nothing is withheld here and PROTOCOL §10's **R-SEAL-1** does not reach this
paragraph — there is no result in existence that this packet is holding back.

I predict the design asserts `tlast` on **every** output word whose immediately
following input word covers no frame octet, i.e. that at length 64 / lane 0 /
k = 1 all eight words carry `tlast` and the run delivers eight one-word frames
rather than one eight-word frame. It is a prediction about a mechanism I have
not observed and cannot observe without either a diagnostic run or reading RTL I
have not read, and it may be wrong; it is written down so that it can be wrong in
public.

**What would settle it in one run**, and what I ask the fix return to report in
its Root-cause section: the full `(cycle, tkeep, tlast, tuser)` list the design
produces for `M03-I4 (length 64, lane 0, idles 1)` at `4901161` — eight rows.
That single table distinguishes "the whole frame is fragmented" from "only its
head is mismarked", and it is the datum the re-test verdict will be written
against.

---

## 5. Severity: CRITICAL, and the argument for it

1. **It corrupts a frame at the head of the receive chain.** A consumer that
   honours REQ-015 sees the 60-octet frame as at least two frames, the first of
   8 octets. M06, M08, M14 and M17 are all downstream of this port; every
   length, protocol and checksum decision they make is keyed to frame extent.
2. **REQ-016 is an unconditional IFC requirement**, and its normative sentence
   says *"without corrupting it"*. The requirement is not conditioned on how the
   idle arose.
3. **BUG-0001 is the precedent and this is at least its equal**: over-delivery of
   `k − 4` octets on the final word was CRITICAL; changing which word is final is
   the same class of harm reached from the other side.
4. **The counter-consideration, stated rather than suppressed.** On a real 802.3
   link an idle character does not appear inside a frame, so a reader may ask
   whether the stimulus is reachable. Three answers, and none of them lowers the
   verdict. REQ-018 makes this boundary **simulation-only** and hands the link
   partner's contract to DV. §6.2's `Frame` row and §6.1's C-14.4 paragraph
   specify the behaviour **unconditionally**, and §10's REQ-016 hook commissions
   the measurement at 0, 1 and 7 cycles at this module by name. And REQ-016 binds
   *every* receive-path stream, where the same gap is produced by an ordinary
   `tvalid` deassertion. If the org wishes to narrow REQ-016's reach at an XGMII
   port, that is a **spec diff** with a countersignature, not a ground for
   closing this packet.

**If rtl_lead disputes this as spec ambiguity, it goes to architect_docs_lead
immediately** (dv_lead charter §7), and I will carry it there myself rather than
argue it in a return.

---

## 6. What this packet does not do

- It does not name a root cause, a line, or a register. §4's prediction is
  labelled as one.
- It does not offer a fix, a waiver, or a narrowing of the assertion. The two
  units **stay red** until the design changes: adjusting an expectation to agree
  with a divergence is barred by REQ-901's own clause (ADR-0015 D2 —
  *"never by amending an expectation to agree"*) and by `RV-0059-VERDICT` §12
  item 5, which told the worker in this same round to report a disagreement
  rather than absorb it. That instruction binds its author too.
- It does not claim any coverage at lane 4, at lengths other than 64, or on the
  1518-octet member; §2.4 says what was not measured.
- It does not open `SO-xgmii_rx_64.md`, and family I's qualification campaign
  does not open. The discharge count stands at **36 of 62** (`J-dv_lead-0084`).

---

## Fix verdict

*(appended by dv_lead after re-test. rtl_lead's fix entry must contain a
Root-cause section — including §4's eight-row table — before ACCEPT can be
written here.)*
