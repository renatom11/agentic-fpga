# WO-0022: Batch-F bounded re-review — the last signature
- **State**: ACCEPTED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: the WO-0021 return at **d8df28d** (F-1 repaired;
  C-31/C-34/C-35 landed; no §4.1 lift touched anywhere); your own
  WO-0020 Return log §5's bounded surface and pre-worded sentence.
- **Deliverables**:
  1. **The re-review, on exactly the surface you bounded**: SPEC-M17
     §6.1's corrected availability argument (now a separation formula
     keyed on D = ⌈N/8⌉ − ⌈N′/8⌉, the word-count deficit — including
     the architect's added octet-vs-word distinction: N=25/N′=24 is
     D=1, N=32/N′=25 is D=0); §6.2's Payload/Tail rows (conditional
     copy, driven-0 on D ≥ 1, Tail ≡ D ≥ 1 pinned); the new §11.4
     (the REQ-007 scoping clause written out, priced, and carried at
     the SO-udp_ip_rx_64.md gate — judge the carry logic: the clause's
     cost is flip-invariant because requirements.md is already FROZEN,
     where F-1's was not); §10's split hook with the D=0 boundary
     companion; §8's paired opposite-assertion datagrams; byte-wise,
     the two SPEC-M18 corrections (C-34 at three sites, C-35's
     184→185) and SPEC-M04's §13 row (C-31, citing ADR-0011).
  2. **The two disclosed out-of-surface sites**: SPEC-M17 §3's REQ-007
     row and §4.2's payload_tuser row gained pointers only, text
     quoted verbatim in the Return log — your C-28 precedent governs
     (say so and re-derive what moved, or accept the quoted text).
  3. If the repairs hold: your pre-worded sentence at d8df28d for
     transcription — "I countersign batch F (SPEC-M17, SPEC-M18,
     SPEC-M19, SPEC-M20) for P1-spec-freeze at `d8df28d`."
     (J-dv_lead-0011). On it, ALL TWENTY specifications are FROZEN.
     If not: the exact residual list.
  - Journal **J-dv_lead-0011**; Files-in-this-commit = exactly what
    you touch plus this packet.
- **Definition of done**: re-review verdict on the bounded surface +
  the out-of-surface judgment; sentence or residuals.
- **Out of scope**: everything signed at WO-0020 (per your own §5:
  L/h/ΔC, precedence scoping, strobe cycles, stress arithmetic, and
  all of M18/M19/M20 beyond the two byte-wise corrections).
- **Evidence**: CI `build` run **30744579228**, conclusion
  **`success`**, SHA **d8df28d** — head SHA = the repair commit, so
  batch F's four §12 rows fill from it with no witnessing argument
  owed. Run **30744608560** on fa7eac5 (the acceptance commit, specs
  unchanged) also green.
## Task
The re-review you pre-priced. On your sentence the gate's sign-off
section reduces to one line: the sponsor's signature.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-02T16:00Z, journal `J-dv_lead-0011`

**F-1 is repaired. I countersign batch F at `d8df28d`.** Every clause of the
owed diff landed, the arithmetic re-derives from the specification's own
formulas, and the repair is better than what I commissioned in two places
(the octet-vs-word distinction and the D = 0 boundary companion). Four
carry-forwards come out of this review, **C-37 … C-40**, and one of them —
**C-37** — is the most consequential finding I have raised in the programme.
It is at **SPEC-M14**, which is frozen and outside batch F, and it does not
block this signature; §3 below states exactly why, and why I would have
contested it had it been in a DRAFT batch.

---

#### 0. What I verified mechanically, before judging any text

- `git diff d8df28d..fa7eac5 -- docs/specs/ docs/adr/` → **empty**. The
  specs-unchanged claim holds; the working tree's only spec-relevant delta from
  the repair commit is this packet and the orchestrator's own files. I checked
  it rather than accepted it.
- `git diff d8df28d^..d8df28d --stat` → **three spec files**
  (`udp_ip_rx_64.md`, `udp_ip_tx_64.md`, `xgmii_tx_64.md`), no
  `requirements.md`, no `traceability.md`, no ADR, no `libs/`, no `test/`.
  Hunk offsets confirm **no `§4.1` block is inside any hunk** in any of the
  three.
- `bash tools/dv_checks.sh` → **exit 0**; `check_records_vs_appendix.sh`
  **23 checks / 0 failures** (all twenty lifts byte-identical);
  `check_emitted_verilog.sh` OK, 4 checks / 0 failures / 4 pending.
- CI `build` run **30744579228**: `head_sha` =
  `d8df28dfe3722cd8950fdf753a6019b65cbb6966`, `conclusion` = **`success`**,
  `event` = push, workflow `.github/workflows/build.yml`. **Head SHA is the
  repair commit**, so §5 item 4 of my WO-0020 log is met and batch F's four §12
  evidence rows fill with no witnessing argument owed.

**The standard my signature carries.** `P1-spec-freeze` asks me for
**testability**: can a bench be derived from this text, and does a conformant
design pass it while a non-conformant one fails? That is the line that
separates every contest I have raised from every item I have carried. F-1
failed it — the commissioned assertion was unsatisfiable by any implementation
and no site said what to emit instead. Each item below is dispositioned against
that test explicitly.

---

#### 1. The bounded surface, item by item

**(a) §6.1's corrected availability argument — CORRECT, and it re-derives.**

I recomputed the separation from the section's own cycle formulas rather than
reading the architect's. Input word j is presented on Ci + j so the input
`tlast` is on **Ci + K − 1**, K = ⌈N/8⌉; application word j leaves on Ci + 2 + j
(§6.1's own rule, unchanged) so the application `tlast` word, index M − 1,
leaves on **Ci + M + 1**. With M = ⌈(N′ − 8)/8⌉ = ⌈N′/8⌉ − 1 — an identity for
every N′, since 1 is an integer, and the section correctly scopes it to N′ ≥ 9
where an application frame exists at all — the separation is

  (M + 1) − (K − 1) = ⌈N′/8⌉ − ⌈N/8⌉ + 1 = **1 − D**.

A registered output carries the bit iff 1 − D ≥ 1, i.e. **D = 0**. The three
regimes follow exactly as tabulated: D = 0 one cycle after; D = 1 the same
cycle; D ≥ 2 by D − 1 cycles before. **The 182 checks**: N = 1480, N′ = 9 gives
D = 185 − 2 = 183 and D − 1 = **182**, and it is now *reproduced* as D − 1
rather than quoted, which is what I asked for.

The three defects of the old paragraph are all gone: the inequality's direction
is corrected and **named as the error it was** ("N′ ≤ N gives M ≤ ⌈(N − 8)/8⌉,
*not* ≥"), the residue algebra is kept and **explicitly scoped** to the N′ = N
equality it actually proves, and the `Tail`-class outcome is stated. The
over-declared case is correctly separated out: its application `tlast` word is
index K − 2, emitted at Ci + K, one cycle *after* the input `tlast` at
Ci + K − 1, and §9 marks it — that arithmetic is right and it is the reason the
over-declared regime never reaches the availability question.

**(b) The octet-vs-word distinction — ACCEPTED, and it is a genuine improvement
on my own text.** My phrase "under-declares by at least one whole word" reads as
an octet test and the architect is right that a bench would implement it as one.
Both worked cases check: **N = 25, N′ = 24** → ⌈25/8⌉ = 4 against ⌈24/8⌉ = 3,
**D = 1** on a single octet of under-declaration; **N = 32, N′ = 25** → both
ceilings 4, **D = 0** on seven. Seven is also the *maximum* under-declaration
that stays D = 0 (N = 8q against N′ = 8q − 7 keeps the ceiling at q), so the
pair bounds the class from both sides rather than illustrating it. This is the
correction that stops a design keying the copy on `N − N′`.

**(c) §6.2's `Payload` and `Tail` rows — CORRECT, and the `Tail` ≡ D ≥ 1 pin is
proved, not asserted.** `Payload`'s copy is now conditional on D = 0 and the
condition is named as D rather than as length. `Tail` gives the derived 0 and
the reason. The equivalence I most wanted pinned re-derives: `Tail` is entered
when the input word carrying the declared count's last octet — input word M —
is not the last input word, i.e. M + 1 < K, i.e. M + 2 − K < 1, i.e. 1 − D < 1,
i.e. **D ≥ 1**. The two names in the document cannot now drift apart, which was
the whole point.

I also checked the two places the new rows could have contradicted something
that did not move. §6.1's cycle table (line 360) still says the last application
word carries "`tuser`[0] = the input `tlast` word's" — that worked datagram is
IPv4 total length 46 delivering 26 − 8 = 18 application octets, so N′ = N = 26,
**D = 0**, and the unqualified copy there is right. §9's over-declared row is
untouched and stays correct.

**(d) §11.4 — the carry logic is SOUND and I endorse it. One sentence inside it
is false; that is C-37 and it is dispositioned in §3.**

The asymmetry is real and correctly applied. F-1's price rises at the flip
(DRAFT §6 text today, post-freeze §6 *behavioural* diff tomorrow); the REQ-007
scoping clause's does not, because `requirements.md` is already FROZEN and a
normative diff to a frozen requirement costs the same today and at any later
date. Repair what gets dearer, price and carry what does not. That is my own
argument turned on a case where it points the other way, and it is right.

Two things I checked rather than accepted. **First, the flip-invariance is not
quite total**: the clause's cost includes "the REQ-007 hook of each
implementer", and M19's hook is DRAFT today and post-freeze tomorrow. That
component *does* get dearer. It is one editorial hook against a normative
requirements diff plus a `traceability.md` row, and every other implementer's
hook is frozen already, so the dominant term is flip-invariant and the
conclusion survives. I note it so nobody later mistakes "flip-invariant" for
"free". **Second, and decisively for me**: the deferral leaves neither an
implementer nor a bench writer without an instruction. My WO-0020 condition was
that my reading of REQ-007 be **stated at M17 rather than inferred**; it is now
stated at §3, §4.2, §6.1, §6.2, §10 and §11.4 — six sites — and §10 asserts both
halves. The clause is written out verbatim rather than promised, priced with
what is lost ("the application receives payload octets from a frame that may
have been found invalid, with `tuser`[0] = 0, and cannot discard on the bit"),
and gated at `SO-udp_ip_rx_64.md`, the packet that would otherwise claim REQ-007
whole at M17. That is the correct gate and I bind myself to it.

The two rejected repairs are correctly rejected and for the right reasons:
holding the datagram to its input `tlast` makes the latency length-dependent
(REQ-005), and a combinational `ip_payload_tuser` → `payload_tuser` path rescues
**only D = 1** — which my own regime table confirms, since D ≥ 2 emits the
application `tlast` word D − 1 cycles before the bit exists at any port.

**(e) §10's split hook and the D = 0 boundary companion — CORRECT, and this is
the item that makes the class testable.** The hook no longer asserts one thing
and stays silent on the complement: it drives `tuser`[0] = 1 on a **D = 0**
datagram and asserts the bit set, then drives `tuser`[0] = 1 on a **D ≥ 1**
datagram and asserts **0** with no strobe. The excluded class gets a positive
assertion instead of an exemption, which is the difference between a scoped
requirement and an untested hole. The Section cell cites §6.1, §6.2 and §11.4.

**(f) §8's paired opposite-assertion datagrams — CORRECT, and clause 4 was taken
and doubled.** Both re-derive:

- **D = 1**: IPv4 total length 46, UDP length 20 → N = 26, N′ = 20, ⌈26/8⌉ = 4
  against ⌈20/8⌉ = 3 ✔; 12 application octets in 2 words, `tlast` with
  `tkeep` = 0x0F ✔; 6 surplus octets ✔; separation M + 2 − K = 2 + 2 − 4 = 0,
  the same cycle ✔. Driven **twice with opposite input bits**, asserting 0 both
  times — which is what fixes "derived, not copied" in a test rather than in
  prose.
- **D = 0 companion**: IPv4 total length 52, UDP length 25 → N = 32, N′ = 25,
  both ceilings 4 ✔; 17 application octets in 3 words, `tlast` with
  `tkeep` = 0x01 ✔; 7 surplus ✔; separation 3 + 2 − 4 = 1 ✔. And it is a
  sharper case than it looks: the declared count's last octet is the *first*
  octet of input word 3, which is also the input `tlast` word, so `Tail` is
  never entered (M + 1 = 4 = K) even though the datagram under-declares by
  seven. **This datagram is the executable proof of the `Tail` ≡ D ≥ 1 pin**,
  not merely a second stimulus.

The architect's claim for the pair — "a design that keyed the copy on *the
length under-declares* passes the first and fails the second" — is exactly
right, and it is the reason I asked for the boundary rather than the class.

**(g) SPEC-M18, C-34, three sites — CORRECT byte-wise.** `Body`'s exits are now
disjoint **at the source** ("whose **last** octet is the declared count's" vs
"carrying **any** octet beyond"), `Drain`'s entry gained the matching qualifier,
the precedence paragraph states my rule in substance, and §8 item 4's units are
fixed. The numbering note is right and worth having: declaring 100 and supplying
110 puts the boundary in **application word 12** on both counts —
1-indexed 97–100 declared against 101–104 excess (§8's convention), 0-indexed
96–99 against 100–103 (my C-34's) — the same word, and word 13 carries the
remaining six. Ten excess **octets in two words**, as owed.

**(h) SPEC-M18, C-35 — CORRECT byte-wise.** §3's REQ-015 row reads **185** with
1480/8 = 185 shown, §10's row already read 185, and the consequence of 184 is
named. One character, and the contradiction is closed.

**(i) SPEC-M04, C-31 — CLOSED.** §9's co-occurrence bullet no longer says
"pulse **together**"; it says ordered-and-unpinned, names M18's cycle and M04's,
states that neither the separation nor a bound on it is pinned, and instructs a
bench to assert one pulse of each and nothing about timing. I checked all four
documents now agree: ADR-0011's Consequences bullet ("it now says
ordered-and-unpinned") and its Affects header are **true for the first time**;
`requirements.md` REQ-709's verification column says the same; SPEC-M18 §9 and
§6.3 item 5 say it from the other end. The §13 row is well formed against §13's
own five-column header, `Breaking? no`, ADR cell **ADR-0011**, journal
`J-architect_docs_lead-0009`. C-31 is off the ledger.

---

#### 2. The two disclosed out-of-surface sites — my C-28 precedent applied

Per C-28 I may accept the quoted text or say so and re-derive. **I re-derived
both.** One is right; one is wrong at the boundary, and the error is **mine**.

- **§4.2's `payload_tuser` row — ACCEPTED, byte-identical to the quote, and
  correct.** "inherited by copy only where §6.1's D = 0; driven to 0 on the
  under-declaring class, D ≥ 1 (§6.2, §11.4)". D = 0 is pinned; nothing else in
  the row moved.
- **§3's REQ-007 row — byte-identical to the quote, and the quoted text is
  wrong at D = 1.** It scopes the copy to "where that word is emitted **on or
  after** the input `tlast` is presented". "On or after" admits the same cycle,
  which is **D = 1** — and at D = 1 a registered output cannot carry the bit.
  §6.1's own derivation is tighter and correct ("only where that number is
  **positive**"), so §3 now over-includes by exactly one boundary case relative
  to the five sites that pin D = 0.

  **The phrase is mine.** My WO-0020 clause 2 said "copied … when the
  application `tlast` is emitted **on or after** the cycle that word arrives",
  and the architect transcribed my clause faithfully. The architect's own §6.1
  is the text that catches my error. §10's hook uses the same loose phrase but
  immediately pins it — "on or after the input `tlast` (**§6.1's D = 0**)" — so
  §3 is the single unpinned instance.

  **Disposition: carry, as part of C-40, not a contest.** By the testability
  test: no bench derives from §3 — §10 carries the hooks, it asserts 0 for
  D ≥ 1 explicitly, and §8 drives the D = 1 datagram twice with opposite input
  bits. Five sites say D = 0 and one says "on or after"; an implementer
  following the §6 state machine cannot act on the loose one. It is a one-word
  fix ("on or after" → "after"), and I will not spend a gate on a word I wrote
  wrong myself when the document's own derivation already corrects it.

**§2's in-scope bullet, which the architect offered to take next time: I accept
the offer, and there are three more like it.** Grepping every `tuser` mention in
SPEC-M17 turns up four statements of unqualified relay that no longer match
§6.2: §2's in-scope bullet ("carrying an inherited abort through to its `tlast`
word"), §2's not-my-job row ("M17 relays `tuser`[0] to its own `tlast` word"),
**§3's REQ-013 row** ("read on the input `tlast` word and **written on the
application `tlast` word**"), and **§4.2's `ip_payload_tuser` *input* row**
("copied out, never acted on"). All four are scope- or meaning-statements
carrying no hook; all four are one parenthetical. They go on the ledger as
**C-40** with §3's "on or after" — one sweep, one activation, gated at
`SO-udp_ip_rx_64.md`.

---

#### 3. C-37 — F-1's twin at SPEC-M14, which is FROZEN

**§11.4 offers a falsifiable generalisation. I falsified it, and what is on the
other side is the same defect as F-1, at a module whose spec froze at 3f6accc
under my own countersignature.**

§11.4 states: "M17 is the only module on the chain whose output frame's extent
is fixed by a count declared *inside the data* … At M03, M06, M08, M10, M14,
M16 and M19 the output frame ends on or after the input frame does, so the
propagation obligation is satisfiable by construction". **That is false at
M14.** M14's output frame extent is fixed by the **IPv4 total length** — a count
declared inside the data — and its `Tail` state exists for exactly one purpose:
"consumes the Ethernet padding" (SPEC-M14 §6.2). Ethernet padding is M14's
D ≥ 1.

**The derivation, from SPEC-M14's own formulas.** Input N octets (the Ethernet
payload, padding included — REQ-408 leaves padding in place at M06 and SPEC-M14
§2 says so), K = ⌈N/8⌉, input `tlast` at Ci + K − 1; output M = ⌈(N′ − 20)/8⌉
words for total length N′, payload `tlast` word at **Ci + M + 3** (SPEC-M14
§6.1, confirmed against its own worked example: total length 46 puts payload
word 3 at Ci + 7). Separation:

  (M + 3) − (K − 1) = ⌈(N′ − 20)/8⌉ − ⌈N/8⌉ + **4**,

available to a registered output iff ≥ 1. **The concrete case, which is the
most ordinary frame on Ethernet**: a 64-octet minimum frame → N = 46, K = 6,
input `tlast` at Ci + 5. An IPv4 datagram of total length **28** inside it
(8 payload octets, 18 octets of padding) → M = 1, payload `tlast` word at
**Ci + 4** — **one cycle before the abort bit is presented.** M14 cannot copy
it. The threshold for N = 46 is N′ ≥ 37, so **every IPv4 datagram of total
length 21 … 36 in a minimum-length frame is affected**, including the smallest
UDP datagram the programme admits (UDP length 9 → total length 29, separation
exactly 0). Worst case N = 1500 against N′ = 21: the payload `tlast` leaves
**184 cycles** before the bit exists.

**SPEC-M14 §6.1 makes F-1's error character for character**: "Since N′ ≤ N,
M + 3 ≥ ⌈(N − 20)/8⌉ + 3 ≥ K" — N′ ≤ N gives M ≤ ⌈(N − 20)/8⌉, **not ≥**. The
second inequality holds; the first is backwards. For N′ = N the separation is
1 or 2 at every length, which is why the claim looked sound and why its worked
example (no padding) reproduces. And §6.2's `Payload` row directs `tuser`[0]
"copied from the input `tlast` word", unconditionally, exactly as M17's did.

**Why this is worse than F-1 was, on two counts.** First, a **committed hook
asserts the unsatisfiable reading**: SPEC-M14 §10's REQ-007/REQ-013 row
commissions "drive `tuser`[0] = 1 on an accepted datagram's `tlast`; assert the
payload frame is delivered intact with **the bit set on its last word**" —
unscoped — and §8's directed set is "each inside a **64-octet Ethernet frame**"
and includes "**total lengths 20 through 28 inclusive**", every one of which is
inside the defective band. A tb_writer following that hook writes an assertion
no conformant design can pass. Second, the **system consequence**: a bad-FCS
64-octet frame carrying a short UDP datagram loses its abort mark at M14, so
REQ-104 → REQ-007 → REQ-707 is broken end to end for the commonest small frame
and the application receives it as clean. M17's D ≥ 1 class needs a corrupted
UDP length to be reached; M14's needs only ordinary Ethernet padding.

**Scope of the falsification, checked rather than assumed.** Exactly three specs
in the programme have a `Tail` state: M10, M14, M17. **M10 is safe for a reason
§11.4 does not give but which holds** — SPEC-M10 §3's REQ-007 row: "M10 emits no
stream, so there is no `tlast` word on which to set `tuser`[0]". M03, M06, M08,
M16 and M19 have no in-data count and are correctly listed. **M14 is the sole
falsification**, which makes the finding precise: §11.4's sentence needs M14
moved from the safe list to the exception list, and the generalisation restated
as "a module whose output frame's extent is fixed by a count declared inside the
data" — which is M14 **and** M17, not M17 alone.

**Disposition: this does NOT block batch F, and here is the full reasoning
rather than a conclusion.**

1. **The defect is not in batch F.** Its substance is SPEC-M14 §6.1, §6.2 and
   §10 — frozen at 3f6accc at a gate that has passed. Batch F's four specs are
   M17, M18, M19, M20. Withholding batch F would not repair one line of M14.
2. **Its batch-F footprint is one non-normative sentence** in a Deferred-items
   rationale cell. It constrains no implementer, commissions no test and
   contradicts nothing in §6. By the testability test SPEC-M17 passes: every
   bench §10 commissions at M17 is satisfiable by a conformant design and
   discriminating against a non-conformant one. The sentence's correction is a
   post-freeze editorial §13 row at SPEC-M17 — the same class as C-31, which I
   explicitly declined to make a condition of anything.
3. **The M14 repair's price is flip-invariant**, exactly as §11.4 teaches:
   SPEC-M14 is already frozen, so the diff costs the same today and at
   `SO-ip_eth_rx_64.md`. There is nothing to buy by blocking.
4. **The repair is a real design decision and must not be squeezed into a
   gate-closing commit.** It is a choice between holding M14's payload `tlast`
   to the input `tlast` (which costs REQ-005's constant latency — the trade
   §11.4 rejects at M17) and scoping REQ-007 with M14 emitting a derived 0
   (which is F-1's resolution one module up). That deserves its own ADR and its
   own activation, with SPEC-M14 §6.1's inequality, §6.2's `Payload` row, §10's
   hook and §8's directed set all moving together.
5. **Had SPEC-M14 been DRAFT today I would have contested it**, on the same two
   grounds that made F-1 a contest and not a carry: `requirements.md` REQ-007
   settles it in the *impossible* direction, and a committed hook asserts the
   wrong reading. Both hold. The reason it is a ledger row is its **location**,
   not its severity — and I am recording that distinction so that nobody later
   reads this signature as a judgment that C-37 is small.

**C-37 closes at `SO-ip_eth_rx_64.md`, and it joins `SO-udp_ip_rx_64.md` as a
second gate on §11.4's carried REQ-007 scoping clause.** I recommend to the
orchestrator that it be the **next architect activation after this gate**, ahead
of any receive-chain RTL. It very likely converts §11.4's priced alternative
from optional to owed — a scoping clause covering two modules rather than a
per-module note covering one — which **strengthens** the architect's
price-and-carry decision rather than undermining it: the carried instrument was
always the right shape, and it now has a second customer.

**My own miss, stated plainly.** This text was in front of me at WO-0018 and I
countersigned batch D/E without catching it. I found it now only because F-1's
derivation taught me the shape — an output frame whose extent is set by an
in-data count cannot inherit a bit that arrives with the input frame — and
because the architect wrote §11.4's generalisation in a **falsifiable** form
that invited the check. Both halves of that deserve recording: the escape is
mine, and the repair's own text is what surfaced it. The auditor owns the
DV-escape ledger (PROTOCOL §10); I journal the root cause in `J-dv_lead-0011`
and will cooperate with its recording.

---

#### 4. C-38, C-39, C-40

| # | Item | Must land before |
|---|---|---|
| **C-37** | **SPEC-M14 §6.1's abort-availability claim is false in the padding regime — F-1's defect at a FROZEN spec.** Separation is ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4; for a padded 64-octet frame (N = 46) every total length **21 … 36** emits the payload `tlast` word on or before the cycle the input `tlast` is presented, so §6.2's unconditional "`tuser`[0] copied from the input `tlast` word" is unimplementable there. §6.1's inequality runs the wrong way exactly as F-1's did. **§10's REQ-007/REQ-013 hook commissions an assertion no conformant design passes**, and §8's directed total lengths 20–28 in 64-octet frames are all inside the band. Consequence: a bad-FCS minimum-length frame carrying a short UDP datagram reaches the application unmarked (REQ-104 → REQ-007 → REQ-707 broken). **Falsifies SPEC-M17 §11.4's "here and nowhere else" enumeration**, which lists M14 as safe. Repair is a design decision (hold the `tlast`, at REQ-005's cost; or scope REQ-007 and derive 0, F-1's resolution) and wants an ADR. M10 checked and safe (emits no stream); M03/M06/M08/M16/M19 correctly listed | **`SO-ip_eth_rx_64.md`**, and any M14 bench asserting REQ-007; §11.4's sentence at SPEC-M17's own §13. **Recommended as the next architect activation, ahead of receive-chain RTL** |
| **C-38** | **SPEC-M18 §6.2 lets a word-aligned over-delivery escape REQ-710 entirely.** When the declared count is a multiple of 8 the word completing it carries no octet beyond it, so `Body` exits to **`Drain`** — which drops `payload_tready` to 0 with the application's `tlast` still pending, pulses no strobe, and returns to `Idle` where the stale word is consumed as the next frame's word 0. Declare 96 and supply 104 is the case. That is precisely the pathology C-34 names, on the trigger C-34 did not name, and the C-34 repair **hardens** it by making `Drain` unambiguously the exit. `requirements.md` REQ-710 (FROZEN) states the correct reading — "SHALL discard the excess words while continuing to accept them **so the application is never stalled**, and SHALL pulse `error_tx_length_mismatch` once" — and §10's REQ-710 hook asserts it correctly, so this is a carry and not a contest by the C-26 line. **Repair**: `Drain`'s entry needs the completing word to carry `tlast`; a completing word without it stays in `Body` with `payload_tready` = 1 until the next word, which is necessarily beyond the count → `Excess`. Plus a §8 directed **declare 96 / supply 104** datagram — §8 item 4's declared 100 is not a multiple of 8 and never drives it | `SO-udp_ip_tx_64.md`; the M18 REQ-710 bench. It is on my M18 attack plan as a mandatory row |
| **C-39** | **`requirements.md` REQ-710's verification column carries C-34's units error, unrepaired because it is frozen**: "Declare 100 octets and supply 110 … that **the ten excess words** are accepted and discarded". They are ten excess *octets* in two words, as SPEC-M18 §8 item 4 now says. The two halves of the same sentence disagree; a bench writer resolves it by the stimulus, so it is misleading rather than test-breaking. Flip-invariant cost (frozen today and later), so price-and-carry by §11.4's own rule. SPEC-M18 §9's "an application that presents ten excess words" is a legitimate hypothetical and is **not** part of this item | `SO-udp_ip_tx_64.md`; `requirements.md` §13 |
| **C-40** | **SPEC-M17's one-word boundary error plus four unqualified relay statements.** (i) **§3's REQ-007 row scopes the copy to "on or after" the input `tlast`, which admits D = 1 where a registered output cannot carry the bit** — the sole unpinned instance of a phrase §10 pins with "(§6.1's D = 0)"; fix is "on or after" → "after". **The phrase is dv_lead's own, from the WO-0020 owed-diff text.** (ii) Four sites still state unqualified relay against the new §6.2: §2's in-scope bullet, §2's not-my-job row, §3's REQ-013 row ("written on the application `tlast` word"), §4.2's `ip_payload_tuser` **input** row ("copied out"). One parenthetical each; the architect offered §2's and I accept. No hook derives from any of the five, which is why this is a sweep and not a contest | `SO-udp_ip_rx_64.md` |

**Still open and unchanged by this review**: C-2, C-3, C-5, C-7, C-9's REQ-903
half, and C-32, C-33, C-36 — correctly not taken at WO-0021, since each needs
text at a module outside this surface and each has a later gate. **C-31, C-34
and C-35 are closed** by this commit.

---

#### 5. The countersignature

The bounded surface holds. The repair discharges F-1 in full, improves on my
own commissioned text twice, and its one false sentence and one wrong word are
both carry-class under the line I set at WO-0015 and have applied in both
directions at WO-0018, WO-0020 and here.

> **"I countersign batch F (SPEC-M17, SPEC-M18, SPEC-M19, SPEC-M20) for
> P1-spec-freeze at `d8df28d`."** — dv_lead, journal `J-dv_lead-0011`.

With batches A through F signed, **all twenty Phase-1 specifications are
FROZEN** and the gate's sign-off section reduces to the sponsor's signature.
The four §12 evidence rows of batch F fill from CI run **30744579228**
(`success`, head SHA `d8df28d`) with no witnessing argument owed.

**What I did not do.** I did not touch `docs/specs/**`, `docs/adr/**`,
`docs/gates/**` or `docs/reports/audit/**`. I added no `test/**` or `tools/**`
code: every check above is arithmetic re-derived by hand from spec text, three
`git diff` invocations, one existing script and one CI API read. `libs/**` was
not opened — C-37 was found in `docs/specs/modules/ip_eth_rx_64.md`, not in RTL.

### ACCEPTED — orchestrator, 2026-08-02T16:30Z, journal `J-orchestrator-0059`

Committed as `0536819` (dv_lead, `J-dv_lead-0011`). The sentence is
transcribed; batch F is FROZEN at d8df28d; the checklist's
all-six-batches box is checked. **ALL TWENTY Phase-1 specifications
are FROZEN. The sponsor's signature is the gate's only open line.**
C-37…C-40 transcribed to the ledger — C-37 (F-1's twin at frozen
SPEC-M14, dv's self-reported escape with the root cause journaled) is
the next architect activation, WO-0023, ahead of M14 RTL.
