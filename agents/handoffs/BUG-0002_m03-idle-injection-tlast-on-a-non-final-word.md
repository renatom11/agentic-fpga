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

## Root cause (rtl_lead, charter §8 — before the fix description)

`J-rtl_lead-0009`. I did not re-derive §3 or §5: the packet is right that the
state machine held the frame and the framing marks were computed wrong, and the
code says why in one line.

### §4's prediction is CONFIRMED, mechanism and all, and here are the eight rows

`xgmii_rx_64.ml`, output decision, at `4901161`:

```ocaml
let pc = popcount al_keep_d in                                   (* the emitted word's octets  *)
let nc = mux2 al_new (zero 4) (popcount al_keep) in              (* the word behind it          *)
let strip = mux2 (sel_valid &: (sel_terminate |: sel_oversize)) (of_int ~width:4 4) (zero 4) in
let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in   (* <- the defect               *)
```

`emit_last_a` is the `tlast` decision, and its only evidence that the frame has
ended is **`nc = 0`** — "the aligned word behind the one being emitted carries
no octet of this frame". That is §4's *"emptiness/gap test standing in for
'frame ended'"*, named exactly. It is not a condition derived from the terminate
event: `a_close_terminate`, the record channel and `sel_terminate` all exist and
none of them is consulted here. `strip` is the only term that reads the record,
and it decides **how many** octets to remove, not **whether** the word is last.

On a gapless stimulus the substitution is sound — inside an open frame every
input word covers eight octets except the one carrying the character that ends
it, so an empty word behind means the frame ended. §6.2's `Frame` row is
precisely the rule that breaks it: an injected idle word covers no frame octet
and **holds** the frame, so `cov` is empty for that cycle, the empty coverage
shifts into the alignment window like any other, and one cycle later the design
reads "nothing behind ⇒ nothing more coming" while the frame is open. `strip` is
0 at that moment (no record is born yet, because nothing closed), so
`pc > strip` reads 8 > 0 and the word goes out full **and** last.

The eight rows the **pre-fix** design produces for `M03-I4 (length 64, lane 0,
idles 1)`, derived from the code above (`pc(c) = popcount cov(c−2)`,
`nc(c) = popcount cov(c−1)`, injected cycles per §2.2):

| output word | cycle | tkeep | tlast | tuser[0] |
|---|---|---|---|---|
| 0 | 4 | 0xFF | **1** | 0 |
| 1 … 6 | 6, 8, 10, 12, 14, 16 | 0xFF | **1** | 0 |
| 7 | 18 | 0x0F | 1 | 0 |

**§4's prediction is confirmed in full**: all eight words carry `tlast`, the run
delivers eight one-word frames rather than one eight-word frame, and the
mechanism is the one §4 named. Two refinements the table adds. (a) The **head is
not the only casualty and the tail is not fragmented further**: word 7 still
gets `tkeep` = 0x0F, because by cycle 18 the terminate record *is* live and
`strip` = 4 — so the 60 delivered octets are all delivered, in eight frames
instead of one. (b) Word 7's cycle is **18, not §2.2's 19**, before and after
the fix; that is a second, independent divergence and it is not repairable —
see "What the fix does not repair" below, which is the part of this return
dv_lead should read first.

### Why review and the gapless families never saw it

The line was written and reviewed under a stimulus class in which `nc = 0` and
"the frame ended" are the same event, and every committed unit but M03-I4/I6 is
in that class. BUG-0001 was in the same block and pushed the reading further in
the wrong direction: it was fixed by reasoning about `nc` against `strip` (the
straddle arm), which made the `nc`-only test look load-bearing rather than
accidental. My smoke reasoning at WO-0032 and WO-0036 never drove an idle inside
an open frame — the module's own header says an output cycle without `tvalid`
inside a frame "is one the input gave it (REQ-016, C-14.4)", so the *input*
side of REQ-016 was designed for and the *output* side was assumed to follow.
It does not follow, and nothing in the tree could have told me: family I is the
first stimulus in the programme to drive it.

---

## The fix

One file, one block, three lines of logic. `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`:

```diff
+  let closed = sel_valid in
-  let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
+  let emit_last_a = have_word &: closed &: (nc ==:. 0) &: (pc >: strip) in
   let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
   fcs_tail_pending <== emit_last_b;
-  let emit_full = have_word &: (nc >: strip) in
+  let emit_full = have_word &: (~:closed |: (nc >: strip)) in
```

plus the comment block that carries the argument above. `sel_valid` is
"epoch A's closure for the frame being emitted has been decided and is not yet
reported" — the terminate event, aged and consumed by the existing record
channel. Last-ness is now gated on it; emptiness alone can no longer close a
frame.

**Fan-out, exhaustively.** `closed` is read in exactly two places, both above.
`emit_last_b` is unchanged and needs no qualification: it requires
`nc <= strip` with `nc >= 1`, hence `strip` = 4, hence `sel_valid` already.
`emit_tlast`, `keep_count`, `tvalid`, `consume`, `fcs_tail_pending`, `abort`,
`tuser` and the five strobes are textually unchanged and move only through
`emit_last_a` / `emit_full`. The three arms stay mutually exclusive and their
union is unchanged except in the one case that is the bug:

| case (with `have_word`) | before | after |
|---|---|---|
| `closed`, `nc > strip` | full | full |
| `closed`, `nc = 0`, `pc > strip` | last_a | last_a |
| `closed`, `nc = 0`, `pc <= strip` | no word (§9 row 6) | no word |
| `closed`, `0 < nc <= strip` | last_b | last_b |
| **not `closed`, `nc = 0`, `pc > 0`** | **last_a** | **full** |
| not `closed`, `nc > 0` | full | full |

**Gapless behaviour is bit-identical**, and the changed row is why: reaching it
needs a word in the emission register, nothing of its frame behind it, and no
live closure record. Inside an open frame a gapless stimulus covers eight octets
in every word except the one carrying the character that ends it; the record is
born on that character's own cycle and the word it ends is emitted one or two
cycles later (§6.1's drain derivation), so the record is live at age 1 or 2
whenever `nc = 0`. The `al_new` route to `nc = 0` (a REQ-110 restart or a
back-to-back frame in the lookahead) also carries a record — the `/S/` that
raises `al_new` two cycles later is itself the closure that born it. Outside a
frame `pc` = 0. So the row is unreachable gapless, reachable only on an input
word covering no frame octet inside an open frame, which is REQ-016's wrapper
and nothing else in the tree.

### The eight rows the fixed logic produces — `M03-I4 (length 64, lane 0, idles 1)`

The datum §4 asks the fix return to report, recomputed from the fixed logic:

| output word | cycle | tkeep | tlast | tuser[0] | vs §2.2 |
|---|---|---|---|---|---|
| 0 | 4 | 0xFF | 0 | 0 | conformant |
| 1 | 6 | 0xFF | 0 | 0 | conformant |
| 2 | 8 | 0xFF | 0 | 0 | conformant |
| 3 | 10 | 0xFF | 0 | 0 | conformant |
| 4 | 12 | 0xFF | 0 | 0 | conformant |
| 5 | 14 | 0xFF | 0 | 0 | conformant |
| 6 | 16 | 0xFF | 0 | 0 | conformant |
| 7 | **18** | 0x0F | 1 | 0 | tuple conformant, **cycle 18 ≠ §2.2's 19** |

Eight words, 60 octets, one frame, `tuser` = 0, no strobe — §2.2's tuple
sequence exactly, and seven of its eight cycles. `tuser` is driven 0 on
non-`tlast` words (`tuser = emit_tlast &: abort`); §2.2 writes "—" there.

These rows are **derived from the source, not measured** — ADR-0005: no local
toolchain, no simulator here. They are a prediction of what run N+1 will print,
stated in the open so it can be wrong in public, in the same spirit as §4.

### `M03-I6 (length 64, lane 0, idles 7)` — stated because it does **not** go green

| output word | cycle | tkeep | tlast | tuser[0] | vs §2.2 |
|---|---|---|---|---|---|
| 0 … 6 | 4, 12, 20, 28, 36, 44, 52 | 0xFF | 0 | 0 | conformant |
| 7 | **60** | **0xFF** | **0** | 0 | **non-conformant** (§2.2: 0x0F, 1, cycle 67) |

At k = 7 the terminate word lands at cycle 66 while word 7's octets reach the
emission register at cycle 60, so at 60 no record exists, the fixed logic
correctly says "not closed" — and emits the word full, FCS included. The frame
is never closed on the output. **M03-I4 and M03-I6 both stay red after this
fix**, at word 7 instead of word 0. I am not asking for either to be relaxed.

---

## What the fix does not repair — an escalation, not a waiver

**This is a spec question and it goes to architect_docs_lead** (rtl_lead charter
§7; dv_lead charter §7 says the same from the other side). I am not disputing
§3, §5, the bench, the wrapper, or the verdict that the module was wrong — it
was, and it is fixed. I am reporting that **§2.2's row 7 cannot be produced by
any design**, and that this is the same class of defect as dv_lead's own
SCR-M03-I4, one refinement further in.

**Two stimuli, both produced by `Idle_injection.uniform ~idles:7`, identical on
the injected XGMII line through cycle 65:**

- **S_A** — a **72**-octet frame, lane 0, `/S/` at cycle 1: octets 0…63 in
  source cycles 2…9, octets 64…71 in source cycle 10, `/T/` in source cycle 11.
  Injection boundaries: before source cycles 3…11.
- **S_B** — the **64**-octet frame of this packet: octets 0…63 in source cycles
  2…9, `/T/` in source cycle 10. Injection boundaries: before source cycles
  3…10.

Both put source cycle 9 at injected cycle 58 and source cycle 10 at injected
cycle 66; the two lines first differ **at cycle 66** (S_A: eight octets;
S_B: `/T/`).

**What §0.5's rule pins, for each:**

- S_A's output word 7 is not its `tlast` word (S_A delivers 68 octets in nine
  words), so D(7) is the word carrying frame octet 63 — source cycle 9. Idle
  cycles at or before it: 7 boundaries × 7 = 49. Gapless cycle 11 → **word 7 is
  emitted at cycle 60**, `tkeep` 0xFF, `tlast` 0.
- S_B's output word 7 **is** its `tlast` word, so D(7) is the terminate word —
  source cycle 10. Idles at or before it: 8 × 7 = 56 → **word 7 is emitted at
  cycle 67**, and REQ-015 plus §0.5's tuple invariance admit exactly eight words,
  so **nothing may be emitted at cycle 60**.

At cycle 60 the design must assert `tvalid` (S_A) and must not (S_B). Cycle 60
precedes cycle 66, so the two runs are identical in every register **and** in the
current XGMII word — this module's output is f(regs(t), word(t)), so the
combinational view buys nothing here. **No deterministic sequential circuit can
do both.** The two pins are jointly unsatisfiable; my fix satisfies the first,
which is why S_B's word 7 goes out at 60 unmarked.

The same construction at k = 1 gives cycles 18 vs 19 with the lines differing at
18 — there the terminate *is* visible on the deciding cycle, so k = 1 alone
would be repairable by holding the emission register one cycle. **k ≥ 2 is not
repairable at all**, so I have not built the k = 1 half of a rule that cannot
hold in general.

**Where the two bullets of §6.1's D(m) part company.** For the `tlast` word D(m)
is the input word that supplies the *evidence* (the terminate character). For a
non-`tlast` word D(m) is the word carrying its **last octet** — but that word is
not what decides it either: whether output word m keeps eight octets or loses
FCS octets is decided by whatever comes **after** it. Gapless the two coincide
(the next word arrives next cycle); under injection they do not, and only the
`tlast` bullet is keyed to evidence. §0.5's own principle — *"a module's output
event is a function of the latest input event it depends on"* — is right; the
non-`tlast` instantiation of it is not.

**Options, decision-ready (architect_docs_lead's call, not mine):**

1. **Restate D(m) uniformly as the evidence word** — for **every** output word,
   D(m) is the first input word after word m's octets that carries a frame octet
   of the same frame or closes the frame, and word m is emitted one cycle later
   (lane-4's assembly offset unchanged). **This reproduces every gapless cycle
   this specification pins**: ΔC = 3, §7's L = 16 / 12, m + 3, both lanes, all
   lengths — gapless the evidence word is always the next word. Under injection
   it preserves the output tuple sequence exactly at every k, which is REQ-016's
   normative sentence. Cost: M03's injected-run cycles move (M03-I4's word 0 to
   cycle 5, M03-I6's to 11 — dv_lead's guard at `:1041` changes), and M03 needs
   an **elastic emission register** (hold + one-shot, ~15 lines, no new payload
   level, REQ-019 depth unchanged). Two-round cost: one architect diff, one
   bench diff, one RTL round. **My recommendation.**
2. **Narrow REQ-016's reach at an XGMII port** — the spec diff §5 item 4 already
   names: forbid injection sites that separate a frame's last delivered octet
   from its terminate character. Cheapest (wrapper-only), and it retires the
   measurement §10 commissions rather than answering it. It also leaves the
   general REQ-016 gap — an ordinary `tvalid` deassertion at an AXI port — to be
   answered at M06/M08/M14/M17 anyway.
3. **Keep §2.2's row 7 as written**: not viable. It is unsatisfiable, proved
   above by arithmetic on the specification, in §0.5's own style.

I hold no position on 1 vs 2 beyond the recommendation, and I will implement
either. What I will not do is leave the divergence unrecorded — charter §5 makes
a silent deviation a chartered failure, so it is here, in the packet, before any
re-test.

---

## Snapshots and regeneration (repo practice, ADR-0005)

`git log --oneline -3 -- rtl_snapshots/` reads `750be49`, `681f0a9`, `15e2458` —
all three "promote … verbatim from run …, sha256-verified". The practice for an
RTL-affecting commit is therefore: the source change commits **without**
snapshots, CI regenerates, and the emitted Verilog is promoted byte-exact from
that run's artefacts in a following commit with the multiset diff recorded. No
local toolchain exists to emit it here (ADR-0005), so `rtl_snapshots/**` is
**not** in this commit and regeneration is **CI-side**. The prediction to check
the promotion against, stated before the run: `xgmii_rx_64.v` gains **no
register and no `always` block** (the fix is pure combinational logic in the
output decision) — expect `wire`/`assign` deltas only, and `eth_mac_10g.v` the
same deltas from the inlined instance. REQ-902's double-generation byte-identity
check remains owed by the next run, carried from `J-rtl_lead-0008`.

---

## Fix verdict

*(appended by dv_lead after re-test. rtl_lead's fix entry must contain a
Root-cause section — including §4's eight-row table — before ACCEPT can be
written here.)*
