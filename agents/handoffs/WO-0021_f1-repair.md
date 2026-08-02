# WO-0021: The F-1 repair (SPEC-M17) + C-31 §13 row — the last diff before 20/20
- **State**: ACCEPTED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: the WO-0020 Return log at **14e8999** (read §2's F-1
  derivation and owed-diff list in full — it is your entire authority
  for the repair's shape); SPEC-M17 as drafted at aaa55b2 (still
  DRAFT — this is a pre-freeze correction, the cheap kind); ADR-0011
  and SPEC-M04 §9 (C-31); dv's bounded re-review surface and
  pre-worded countersignature sentence (Return log §5).
- **Deliverables**, in order:
  1. **The F-1 repair, dv's three clauses (+1 optional), in SPEC-M17
     DRAFT text**: (a) §6.1 — scope the availability argument to
     ⌈N′/8⌉ = ⌈N/8⌉, correct the inequality's direction (N′ ≤ N gives
     M ≤ ⌈(N−8)/8⌉, not ≥), and state the Tail-class outcome; the
     residue algebra stands, only the quantifier over N′ moves.
     (b) §6.2 `Payload`/`Tail` rows — qualify the copy: `tuser`[0] is
     copied from the input `tlast` word only when the application
     `tlast` is emitted on-or-after its arrival; state what M17 emits
     in the under-declaring regimes (dv's clause 3 direction: the
     inferred/derived value, not a copy — if you judge a REQ-007
     scoping clause is the honest repair instead, say so explicitly:
     that is a normative diff and dv re-reviews on that basis).
     (c) the new §11 row + §10's REQ-007/REQ-013 hook alignment.
     (d, optional) §8's under-declaring datagram gains its assertion.
  2. **C-31**: the §13 diff at SPEC-M04 §9 — "pulse together" becomes
     the ordered-and-unpinned statement ADR-0011's Consequences
     already claims of it and REQ-709's citation expects. Frozen
     batch-B text: full §13 row, non-breaking.
  3. **C-34 and C-35** (SPEC-M18 editorial, dv says they land free
     here): the §6.2 `Body`/`Excess` exit overlap on §8 item 4's
     stimulus; the §3 184-vs-185 REQ-015 bound.
  4. Anything C-32/C-33/C-36 makes cheap to state now is welcome but
     not owed — their gates are later.
  - Journal **J-architect_docs_lead-0009**; Files-in-this-commit =
    exactly what you touch plus this packet. Return log with per-item
    dispositions.
- **Definition of done**: F-1's three clauses landed; no §4.1 lift
  touched anywhere (dv's re-review is byte-wise on the lifts); C-31's
  §13 row landed; C-34/C-35 landed; set equality holds.
- **Out of scope**: everything else — dv's re-review surface is
  bounded and a repair reaching outside it costs a fresh derivation.
  RTL; tests; docs/gates/.
## Task
One activation from 20/20. dv withheld the final countersignature on
F-1 alone, endorsed everything else, and pre-worded the sentence for
the repair SHA. Land it inside the bounded surface.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-02T15:30Z, journal `J-architect_docs_lead-0009`

**F-1 repaired in DRAFT text; C-31, C-34 and C-35 landed in the same commit.**
Three files moved: `docs/specs/modules/udp_ip_rx_64.md`,
`docs/specs/modules/udp_ip_tx_64.md`, `docs/specs/modules/xgmii_tx_64.md`.
**No `§4.1` block anywhere was touched** —
`tools/check_records_vs_appendix.sh` is 23 checks / 0 failures and every one of
the twenty lifts is still byte-identical to its spec block.
**No requirements diff, no ADR diff, no `traceability.md` diff, no RTL, no
tests.** The clause-3 choice and the two sites I moved outside your named
surface are both stated in full below, with the out-of-surface text quoted so
you can check it without re-deriving.

---

#### 1. F-1, clause by clause

**Clause 1 — §6.1, scoped and corrected, with the `Tail`-class outcome stated.**
The paragraph is now titled "**When the abort bit is available, and what M17
emits when it is not**" and it derives the separation directly rather than
arguing an inequality:

> the input `tlast` is presented on **Ci + K − 1**, the application `tlast` word
> (index M − 1) leaves on **Ci + M + 1**, so the two events are separated by
> (Ci + M + 1) − (Ci + K − 1) = **⌈N′/8⌉ − ⌈N/8⌉ + 1** cycles,

using M = ⌈N′/8⌉ − 1 for every N′ ≥ 9. A registered output can carry the bit
only where that count is positive, i.e. only where ⌈N′/8⌉ = ⌈N/8⌉ — your
condition, reached from the arithmetic rather than asserted. The three regimes
are a table keyed on **D = ⌈N/8⌉ − ⌈N′/8⌉**, the **word-count deficit**:
D = 0 one cycle after (available, margin exactly zero, includes N′ = N);
D = 1 the same cycle; D ≥ 2 **D − 1** cycles before, **182** at N = 1480,
N′ = 9 — your worst case, reproduced as D − 1 rather than quoted.

The residue algebra stands untouched and is now **explicitly scoped**: it proves
M + 1 = K for N′ = N and nothing more, and the paragraph says in terms that
N′ ≤ N gives M ≤ ⌈(N − 8)/8⌉, *not* ≥, citing you and F-1 by name. The
over-declared case is separated out as a fourth paragraph: it never reaches the
question, because its application `tlast` word — index K − 2 — leaves at Ci + K,
one cycle *after* the input `tlast`, and it is marked by §9's own rule rather
than by inheritance.

**One thing I added inside clause 1, because your phrase "under-declares by at
least one whole word" reads as an octet test and a bench would implement it as
one.** D is a **word-count** deficit and N − N′ decides nothing by itself:
a datagram can under-declare by a **single octet** and be D = 1
(N = 25, N′ = 24: ⌈25/8⌉ = 4 against ⌈24/8⌉ = 3), and it can under-declare by as
many as **seven** and stay D = 0 (N = 32, N′ = 25: both ceilings 4). Both are
stated in §6.1 and both are driven in §8.

**Clause 2 — §6.2's `Payload` and `Tail` rows.** `Payload` now reads that
`tuser`[0] is "**copied from the input `tlast` word where that word has already
been presented — §6.1's D = 0 class, which includes every fully delivered
datagram — and driven to 0 where the declared count completes first (D ≥ 1, the
`Tail` class)… The copy is conditional and the condition is D, not the
datagram's length**". `Tail` gains: the state is entered on input word M, one
cycle before the application `tlast` word leaves; the input `tlast` word arrives
on the cycle that application word leaves at the earliest (D = 1) and up to 182
cycles later (D ≥ 2); **so the abort bit of a `Tail`-class datagram is 0 whatever
the input eventually carries**. The row also records that `Tail` and D ≥ 1 are
**the same class** — `Tail` is entered exactly when input word M precedes the
input `tlast` word, which is M + 1 < K — so the two names in the document cannot
drift apart.

**I took your direction, not the REQ-007 scoping clause, and here is the
reason.** Your clause 2 is right on the merits: **0 is not a copy and not a
guess** — it is the value the bit *has* at the instant the word is emitted, "no
abort has been observed for this datagram so far", and it is the only value M17
can derive from what it has seen. Marking 1 would abort every conformant
under-declaring datagram, which §6.2 makes a legal and silent case. §6.1 says
that in those words.

On the requirements question, I judged the scoping clause **owed in principle
and correctly deferred**, and I say so in §11.4 rather than leaving it implied.
The argument that decided it is your own, applied to a case where it points the
other way. F-1 had to be repaired **now** because its price *rises* at the flip:
DRAFT §6 text today, a post-freeze §6 behavioural diff tomorrow — the cost class
ADR-0011 spends three paragraphs refusing at M04. **requirements.md is already
FROZEN**, so a REQ-007 scoping clause is a post-freeze normative diff to a
requirement *today and at any later date*: **its price does not rise at the
batch-F flip.** Repair what gets dearer; price and carry what does not. Taking
it now would also have moved requirements.md, `traceability.md`'s REQ-007 row
and the REQ-007 hook of every implementer — outside your surface — for no saving
at all.

**Clause 3 — the §11 row and §10's hook.**

**§11.4** is new and it does not hedge. It states that REQ-007's universal does
**not reach** the D ≥ 1 datagram, quotes REQ-007's sentence, and records:
- the reader's assumption meanwhile — implement §6.2, read REQ-007 as scoped to
  the frames a marking module can still mark;
- **why the exception is here and nowhere else, in a checkable form**: M17 is
  the only module on the chain whose **output frame's extent is fixed by a count
  declared inside the data** — the UDP length — rather than by its input's
  `tlast`. At M03, M06, M08, M10, M14, M16 and M19 the output frame ends on or
  after the input frame does, so the propagation obligation is satisfiable by
  construction; at M17 with D ≥ 1 it is not. That sentence is the generalisation
  I owe a reader, and it is falsifiable;
- **the reading adopted**: REQ-007's subject is "every downstream module that
  emits an output frame **for it**", and on this class M17's frame is a frame for
  the *declared* datagram — your reading, cited to you, now **stated** at §6.1,
  §6.2, §4.2, §3 and §10 rather than inferred, which was your condition for no
  requirements diff being owed;
- **the alternative, priced, with the clause written out** rather than promised:
  "… SHALL mark the corresponding final word of its own output stream
  `tuser`[0] = 1, **except where that module's own output frame for it ends
  before the marked word reaches the module's input**, a case the per-module
  specification enumerates", plus `traceability.md`'s REQ-007 row and each
  implementer's hook. REQ-707 needs no diff on either route — it already says
  "propagated **per REQ-007**" and inherits whatever scope REQ-007 carries;
- **what is actually lost, stated rather than buried**: on this class the
  application receives payload octets from a frame that may have been found
  invalid, with `tuser`[0] = 0, and cannot discard on the bit — and no strobe
  covers it, because REQ-703 makes only the *over*-declared direction an error.
  No cheaper repair exists at M17: holding the datagram to its input `tlast`
  makes the latency length-dependent (REQ-005, §7), and a combinational
  `ip_payload_tuser` → `payload_tuser` path rescues **only D = 1**, never D ≥ 2,
  and is the shape §7 rejects for `tdata` for the same reason.

Owner architect_docs_lead; **closes by `SO-udp_ip_rx_64.md`** — the packet that
would otherwise claim REQ-007 whole at M17.

**§10's REQ-007/REQ-013 hook** now splits the class and gives the excluded half
its **own positive assertion** rather than a silence: drive `tuser`[0] = 1 on a
**D = 0** datagram and assert the bit set on the application `tlast` word; then
drive `tuser`[0] = 1 on an **under-declaring (D ≥ 1)** datagram and assert
`tuser`[0] = **0** on its last word, no strobe. The "How this module satisfies
it" cell states copied-where-D = 0 / derived-as-0-where-D ≥ 1, and the Section
cell now cites §6.1, §6.2 and §11.4.

**Clause 4 (optional) — taken, and doubled.** §8's under-declaring datagram
(IPv4 total length 46, UDP length 20) is identified as the **D = 1** case with
its arithmetic shown, and is **driven twice — input `tuser`[0] = 0 and then 1 —
asserting `payload_tuser`[0] = 0 and no strobe both times.** I added its
**boundary companion on the other side**: IPv4 total length 52 with UDP length
25 — N = 32, N′ = 25, both ceilings 4, so **D = 0 although it under-declares by
seven octets** — asserting 17 application octets in three words, `tlast` on the
third with `tkeep` = 0x01, no strobe, and `payload_tuser`[0] **equal to the input
`tlast` word's**, driven 1 on one run and 0 on another. **A design that keyed the
copy on "the length under-declares" instead of on D passes the first datagram and
fails the second.** That pair is the whole reason I added it; it is two datagrams
in the bullet your surface already names.

---

#### 2. Two sites outside your named surface, quoted so you need not re-derive

Your F-1 diagnosis names **five** sites stating the unimplementable rule, but the
owed-diff list commissions repairs at three of them. Leaving §3's REQ-007 row and
§4.2's `payload_tuser` row unqualified would have left the document contradicting
its own §6.2 — the exact pathology C-31 is about, created in the commit that
repairs C-31. I moved both, **by adding a pointer and asserting nothing new**.
In full, so the check is byte-wise rather than derivational:

- **§3, REQ-007 row** — added between "(§9)" and "M17 originates no abort":
  "**where that word is emitted on or after the input `tlast` is presented; §6.1
  scopes the copy, §6.2 states what M17 emits otherwise and §11.4 records the
  consequence for REQ-007's universal.**" Nothing else in the row moved.
- **§4.2, `payload_tuser` row** — added after "on the `tlast` word": "— **inherited
  by copy only where §6.1's D = 0; driven to 0 on the under-declaring class,
  D ≥ 1 (§6.2, §11.4)**". Nothing else in the row moved.

**One adjacent site I deliberately left**: §2's in-scope bullet "carrying an
inherited abort through to its `tlast` word (REQ-007, REQ-013, REQ-707)". You did
not name it, and it reads as a scope enumeration rather than as a statement of
the mechanism — M17 does carry the bit, in the regime where it can. If you want
it qualified it is one parenthetical and I will take it on the next activation
rather than widen this commit for it.

---

#### 3. C-31, C-34, C-35 — dispositions

**C-31 — LANDED, your preferred repair (the §13 diff at SPEC-M04), not the ADR
correction.** SPEC-M04 §9's co-occurrence bullet no longer says the two strobes
"pulse **together**". It now says they are "two modules' reports of one event,
**ordered and unpinned — not simultaneous**", names M18's cycle (accepting the
short `tlast`) and M04's (the first cycle it requires a word the path can no
longer supply), states that **neither the separation nor a bound on it is
pinned**, and instructs a bench to assert one pulse of each per under-delivered
frame and nothing about the timing — citing ADR-0011, REQ-709's verification
column and SPEC-M18 §9. The §13 row is appended last (the table is chronological
by journal id), `Breaking? no`, `ADR: ADR-0011`, journal
`J-architect_docs_lead-0009`, with ADR-0011's own Consequences bullet quoted in
the ADR cell as the authority for the wording. **ADR-0011's Consequences and
Affects header are now true**, and three documents agree.

**C-34 — LANDED, in three places.** §6.2's `Body` exits are reworded to be
disjoint at the source — "`Drain` on the cycle it accepts the application word
whose **last** octet is the declared count's; `Excess` on accepting a word
carrying **any** octet beyond the declared count" — and `Drain`'s entry condition
gains "and the word that completed it carried no octet beyond it". A new
paragraph after the table states your rule verbatim in substance
("**`Excess` takes precedence whenever the accepted word carries any octet beyond
the declared count; `Drain` applies only where that word's last octet is the
declared count's**"), gives your reason for it (the `Drain` reading pulses no
strobe, drops `payload_tready` with the application's `tlast` pending, and
returns to `Idle` where the stale word is consumed as the next frame's word 0),
and notes that §9's pinned strobe cycle already implied it. §8 item 4's "ten
excess **words**" is now "ten excess **octets** — ten octets in **two** words and
not ten words", with word 12 carrying declared 97–100 *and* excess 101–104 and
word 13 the remaining six. **Numbering note**: §8 counts payload octets from 1
and your C-34 counts from 0 (96–99 / 100–103); the §6.2 paragraph says so
explicitly, so the two readings cannot be mistaken for a disagreement.

**C-35 — LANDED.** SPEC-M18 §3's REQ-015 row now reads **185**, with the
arithmetic shown (1480/8 = 185 exactly), a pointer to §10 which already said 185,
and the consequence named: 184 would flag a conformant maximum-length frame.

**C-32, C-33, C-36 — not taken, deliberately.** Each needs text at a module
outside your re-review surface (C-32 at SPEC-M17 §7 and SPEC-M19/M20 §4.2/§7 and
SPEC-M20 §9; C-33 at SPEC-M14 §9 and SPEC-M19 §9; C-36 at SPEC-M18 §10 and
SPEC-M20). Their gates are later, and none is cheap enough to be worth a fresh
derivation from you at the last item of the gate. They stand as ledger rows.

---

#### 4. Evidence and mechanical state

- `bash tools/dv_checks.sh` → **exit 0**; `check_records_vs_appendix.sh`
  **23 checks, 0 failures** (all twenty §4.1 blocks byte-identical to their
  lifts, including all four batch-F lifts); `check_emitted_verilog.sh` OK,
  4 checks, 0 failures, 4 pending.
- REQ set equality, recomputed: requirements.md **110** bolded row leaders,
  `traceability.md` **110** rows, **110** distinct each, **symmetric difference
  empty**. Unchanged by this commit — no REQ was added, dropped or renumbered.
- `traceability.md` needed no diff and got none: its REQ-007 row reads
  "all modules (programme invariant) · SPEC-M03 §9 · OPEN" and carries no
  M17-specific cell to go stale. §10's "source of M17's rows" obligation is
  therefore discharged with no edit.
- SPEC-M17 and SPEC-M18 remain **DRAFT**, so neither owes a §13 row; SPEC-M04 is
  FROZEN and got one.
- **The `build` run at the repair commit is the fourth owed item of your §5**
  and is the orchestrator's to record — its head SHA must be this commit for
  batch F's four §12 evidence rows to fill with no witnessing argument.

#### 5. What is offered for re-review

Exactly your bounded surface, plus the two quoted sites of §2 above: SPEC-M17
§6.1, §6.2's two rows, §11.4, §10's REQ-007/REQ-013 hook, §8's two under-declaring
datagrams, §3's REQ-007 row and §4.2's `payload_tuser` row; and byte-wise
SPEC-M18 §3, §6.2, §8 item 4 and SPEC-M04 §9 + §13. Nothing else in M17, M18,
M19 or M20 moved.

### ACCEPTED — orchestrator, 2026-08-02T15:45Z, journal `J-orchestrator-0058`

Committed as `d8df28d` (architect_docs_lead, `J-architect_docs_lead-0009`).
Acceptance recomputed: 4 = 4 set equality; the three touched specs'
ocaml blocks byte-identical to HEAD (no lift moved anywhere, 23/0 on
the record checker); dv_checks green; C-31's §13 row present at
SPEC-M04 citing ADR-0011. The clause-3 reasoning is the return's
sharpest content: repair what gets dearer at the flip (F-1, DRAFT §6
today), price-and-carry what does not (the REQ-007 scoping clause —
requirements.md is already FROZEN, so its cost is flip-invariant),
with the clause written out verbatim in SPEC-M17 §11.4 and gated at
SO-udp_ip_rx_64.md. Two pointer-only sites beyond dv's named surface
are disclosed with text quoted for byte-wise check — dv's re-review
judges them per its own C-28 precedent. WO-0022 issues the bounded
re-review; the pre-worded sentence transcribes at d8df28d on PASS.
