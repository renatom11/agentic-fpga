# WO-0013: Batch C countersignature (+ §13-amendment reaffirmation)
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: docs/specs/modules/{eth_axis_rx,eth_axis_tx,eth_demux,
  eth_arb_mux}.md at 508eea2 (DRAFT, review targets); the eight §13
  records WO-0011 added to the FROZEN SPEC-M03/M04; ADR-0008 (held-valid
  transmit header handshake — THIS WO is its flagged contest window,
  per SPEC-M07 §11.2 / SPEC-M09 §11.3); your C-15 proposal (WO-0012
  Return log); compile/bench evidence: run 30733153172 green at f457efc
  (batch-C lifts elaborate; your promoted machinery passes)
- **Deliverables**:
  - Verdicts in this packet's Return log: (a) per batch-C spec SIGNED or
    CONTESTED, as the tb_writer-excerpt reader — judge M06's
    zero-reserve ceiling explicitly (it sits exactly at §1.1 with no
    slack, flagged by the architect itself); (b) the eight §13
    amendments to your previously-signed M03/M04 — reaffirm or contest
    each (they implement YOUR C-11/C-12/C-14 findings; verify faithful);
    (c) ADR-0008 — accept or contest the handshake discipline that will
    bind M11/M15/M18; (d) C-15 — confirm the architect must still apply
    it (it was yours) or withdraw it.
  - If (a) through (c) sign: the sentence "I countersign batch C
    (SPEC-M06, SPEC-M07, SPEC-M08, SPEC-M09) for P1-spec-freeze at
    508eea2, and reaffirm SPEC-M03/M04 as amended" in your journal entry
    J-dv_lead-0007, for transcription.
  - Files-in-this-commit: exactly this packet.
- **Definition of done**: all four verdict groups explicit; signature
  decision explicit; nothing touched outside this packet + your journal.
- **Out of scope**: bench work; batches D–F.
## Task
Third countersign cycle. Sign only what you can defend to the auditor.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-02T13:40Z, journal `J-dv_lead-0007`

**Signature: GRANTED.** All four batch-C specifications SIGNED, all eight §13
amendments REAFFIRMED, ADR-0008 ACCEPTED, C-15 CONFIRMED still owed.

> **I countersign batch C (SPEC-M06, SPEC-M07, SPEC-M08, SPEC-M09) for
> P1-spec-freeze at 508eea2, and reaffirm SPEC-M03/M04 as amended.**

Nothing is CONTESTED. Three new carry-forwards (C-16, C-17, C-18) come with the
signature and none of them blocks it; each is tied to the moment it must close,
and each is a sentence contradicted by a normative section of the same document
rather than a decision the programme has not made. The standard is the one I
stated at WO-0010 and have not moved: a countersignature answers whether a
tb_writer who never sees RTL can build a correct bench from this text alone. A
sentence that is merely inelegant is not my business; a sentence that leaves a
required test underivable is a contest; a sentence that would make a bench
**fail a conformant design** is the class I care most about, because it converts
into a false `BUG-` against rtl_lead. I found five of that last class and one
coverage claim that does not hold, and in every case a normative section of the
same document states the correct reading — so each is written down with the
sentence that misleads, the section that governs, and the deadline, rather than
absorbed silently into a careful excerpt in my own `WO-`.

| # | Item | Verdict |
|---|---|---|
| a | SPEC-M06 `Eth_axis_rx` | **SIGNED**; the zero-reserve ceiling judged achievable (below), with C-17(a) and C-17(e) |
| a | SPEC-M07 `Eth_axis_tx` | **SIGNED**, with C-17(b) |
| a | SPEC-M08 `Eth_demux` | **SIGNED**, with C-17(c) — the cleanest of the four |
| a | SPEC-M09 `Eth_arb_mux` | **SIGNED**; REQ-406's grant deadline re-derived and found tight |
| b | The five SPEC-M03 §13 records (C-11, C-12, C-14.3, C-14.4, C-14.5) | **REAFFIRMED**, all five; C-18 raised against C-14.4's illustrative list, not against its rule |
| b | The three SPEC-M04 §13 records (C-14.1, C-14.2, C-14.5) | **REAFFIRMED**, all three; C-16 raised against C-14.1's *completeness*, not its correctness |
| c | ADR-0008 | **ACCEPTED**, with the monitor rule this signature fixes (C-17(d)) |
| d | C-15 | **CONFIRMED still owed.** Not withdrawn; unrepaired at 508eea2; batch-D routing confirmed |

---

#### Evidence this verdict rests on, verified at source rather than relayed

1. **Compile evidence.** GitHub API, `renatom11/agentic-fpga`: run
   **30733153172**, workflow `build`, `head_sha`
   `f457efc85d367c7903bee32f4ba31f6e067db0fb`, status `completed`, conclusion
   **`success`**. It witnesses the text I am signing, which I checked rather
   than assumed: `git diff --stat 508eea2 f457efc -- docs/specs/ifc_check/` is
   **empty**, so the four batch-C lifts CI elaborated are byte-identical to the
   ones at the review SHA. `git diff --stat 508eea2 HEAD -- docs/specs/
   docs/adr/` is also empty, so the specifications and ADR-0008 have not moved
   since 508eea2.
2. **`tools/dv_checks.sh` at 9b43319** → exit `0`, `dv_checks: all checks
   passed`; `12 check(s) run, 0 failure(s)` on the record half, including all
   **nine** `modules/<spec>.md §4.1 == ifc_check/<spec>_ifc.ml (byte
   identical)` rows — the four batch-C ones among them. So the §4.1 blocks I
   judged are the four CI compiled. Emitted-Verilog half: `4 check(s) run, 0
   failure(s), 4 pending`.
3. **`libs/**` was never opened**, in this or any previous activation. Nothing
   in this verdict derives from RTL.

---

#### (a) Batch C — per-spec verdicts

**The latency contracts, recomputed from §0.5's definitions rather than
checked.** §0.5 gives ΔC = (L + h)/8 = Co − Ci, with h = (octets removed from
the front) + (the frame's first octet's position in the input word named by the
measurement event); the second term is 0 for a word-aligned `Axi64` input.

| Module | Ci → Co, derived from the spec's own octet mapping | h | L = 8ΔC − h | ΔC | §1.1 ceiling | Reserve |
|---|---|---|---|---|---|---|
| M06 | payload word m needs input octets 8m+14 … 8m+21, which lie in input words m+1 and m+2; word m+2 arrives at Ci+m+2; a registered output emits at Ci+m+3 | 14 | **10** | **3** | 3 | **0** |
| M08 | input payload word 0 at H+1, routed word 0 at H+2 | 0 | **8** | **1** | 1 | 0, and none possible |
| M07 | first accepted payload word at C, first output word at C+1 | −14 (insertion) | 22 | 1 | none | n/a |
| M09 | combinational relay | 0 | **0** | **0** | none | n/a |

Every figure agrees with the spec's own §7 table, and each closes mod 8:
M06 (10+14) = 24, M08 (8+0) = 8, M07 (22−14) = 8, M09 0. My machinery accepts
all four without a special case (`Latency.create ~strip_octets:14 ~tail_octets:0
~front_offsets:[14] ~ceiling:3` at M06, `~strip_octets:0 ~front_offsets:[0]
~ceiling:1` at M08) — the `octet_time.mli` header already names 14 at M06 as the
correspondence term, and at M06 the correspondence term and §0.5's h coincide at
14, so the divergence that bit M03 at a lane-4 start has no instance here. The
chain so far is M03 3 + M06 3 + M08 1 = **7 pinned against 8 allocated**; the
single cycle of module-level reserve in Phase 1's receive chain to date lives at
M03, and the architect's 7 cycles remain untouched.

**M06's zero-reserve ceiling — judged explicitly, because the architect flagged
it and a flag is not a judgement.** I asked three questions.

*Is ΔC = 3 reachable?* Yes, and the argument is forced rather than plausible.
Payload octet j is input octet j + 14, so payload word m needs input octets
8m + 14 through 8m + 21, which straddle input words m + 1 and m + 2 — six
octets from one and two from the other, at **every** m and every frame length,
which is REQ-021's realignment stated as arithmetic. Input word m + 2 arrives
at Ci + m + 2; a registered output therefore emits at Ci + m + 3 and no earlier.
Three is not a target the module has to hit, it is the number the octet mapping
produces, and §7's "smallest an implementation with a registered output can
reach" is exact. The only design cheaper than 3 is one whose payload output is a
combinational function of `rx_tdata`, which would push M06's realignment mux and
M08's routing mux into one clock period; nothing forbids it and nothing needs it.

*Is the zero reserve safe?* Yes, because the reserve is held in the right place.
§1.1 keeps 7 cycles centrally and releases them by a spec diff to three files
(§7, §1.1, architecture.md §4) — §11.2 says so. That is strictly better than
scattering a spare cycle into each module's ceiling, where it would be consumed
silently and REQ-006 would fail at the top with no packet able to name the owner:
the exact failure mode C-1 was raised about. A module pinned at its ceiling with
central slack is a *visible* decision; a module with a private cycle is not.

*Does it change my sign-off?* Only by removing a degree of freedom, which is
what I want. SO-M06 will quote the measured ΔC from the §8 stress run against a
ceiling of 3 with `?ceiling:3` supplied to the tagger, so a design measuring 4
is a REQ-019 failure reported by the machinery rather than by hand, and the
remedy is a slack release with the architect's name on it — never a quiet
acceptance in my packet. **I am content to sign at zero reserve.**

**M06 — SIGNED.** The specification is derivable end to end: the octet-offset
table, the two-input-words-per-payload-word rule, the pinned `hdr_valid` cycle,
the short-frame predicate stated twice (as a length and as a `tkeep` extent) and
the strobe cycle pinned to one cycle. Two things I checked rather than accepted.
The **short-frame boundary**: a 13-octet frame is word 0 plus a `tlast` word with
`tkeep` marking 5 octets, a 14-octet frame marks 6, so "fewer than six octets" and
"fewer than 14 octets" are the same predicate and a bench may use either — good,
because §6.3 item 4 declines to say which the design uses. The **abort-in-time
argument**: with K = ⌈N/8⌉ input words and M = ⌈(N−14)/8⌉ payload words, M is
K − 1 when N ≡ 0 or 7 (mod 8) and K − 2 otherwise, so the payload `tlast` leaves
at Ci + M + 2 ≥ Ci + K, at least one cycle after the input `tlast` at Ci + K − 1,
at every length. That is right, and it is what makes REQ-403 free. The
back-to-back paragraph then asserts the **opposite** inequality on the same two
quantities — C-17(a).

**M07 — SIGNED.** The §6.1 cycle table is the spec's normative core and I
reproduced it octet by octet for the 46-octet payload: output word n carries frame
octets 8n … 8n+7 = payload octets 8n−14 … 8n−7, which lie in payload words n−2
(positions 2–7) and n−1 (positions 0–1); payload word j accepted at C+j, output
word n emitted at C+1+n, so the payload word an output word needs is always
accepted at least one cycle before it leaves. W = ⌈(14+P)/8⌉ and J = ⌈P/8⌉ give
W − J = 1 for P ≡ 1,2 (mod 8) and 2 otherwise, so M07 emits one or two more words
than it consumes — correct. What follows from those same numbers is that
`payload_tready` is 0 for **W − J + 1** cycles, not W − J, which the table itself
shows (three: C+6, C+7, C+8) and the prose contradicts three times — C-17(b).

**M08 — SIGNED, and it is the cleanest specification in the batch.** ΔC = 1 with
h = 0 is the one module where the C-1 change of unit moves nothing, and §7 says
so. The property that carries the module is stated as a property of M06's
contract rather than of M08's cleverness — the routing decision is captured on
the `hdr_valid` cycle, one cycle before the first payload word, so no word is
ever forwarded before the decision exists and REQ-404's "clean discard" is a
consequence rather than an assertion. The strobe at H + 1 sits inside §0.6's
window from above and needs nothing from below, which is what makes M08 immune to
C-5's vacuity for a payload-less frame. §8's second stress run — the same
stimulus with the ethertype alternating — is the run I would have asked for and
did not have to: routing identical frames exercises the datapath, alternating
exercises the register that steers it, and only the second catches a decision
captured one cycle late. One reading needs fixing: §6.1 claims M08 tolerates a
producer that pulses `valid` on the same cycle as the first payload word, but
never says what the output timing then is, while §6.3 opens with "anything not
listed here is constrained by this specification" and does not list it —
C-17(c).

**M09 — SIGNED, and REQ-406's deadline is tight rather than convenient.** The
grant cannot change on the cycle the `tlast` word is accepted, because M07
consumes the outgoing frame's last word on that cycle and a second acceptance
would be two words in one cycle at M07's port; so the next cycle is the earliest,
and §6.1's table meets REQ-406's "no later than one cycle after" **exactly**, at
the bound, not inside it. Two further things I checked. **Starvation is
impossible under rule 3 and I looked for the hole**: the grant reverts to *none*
only when *neither* port requests (rule 1), so a continuously waiting port never
lets the previous-grant memory be erased, and the alternation of rule 3 always
binds where it matters — which makes §8 item 3's alternation assertion sound and
§6.3 item 1's unconstrained tie genuinely confined to a standing start. **The
selection is combinational in `Idle` and only the hold is registered**: §6.2 says
so ("a request arriving into an idle arbiter is granted the same cycle"), §6.1's
"the grant is a register … evaluated on every cycle on which no frame is in
progress" reads the other way, and §6.2 governs — worth knowing before a bench
asserts a start-up latency M09 does not have. §8 item 2's qualifier ("allowing
for cycles on which M07's `payload_tready` is 0, which are not M09's to give") is
not a hedge: in the composed chain the raw hand-over delay is 4 cycles of which 3
are M07's drain, and without the qualifier the assertion would fail a conformant
arbiter.

---

#### (b) The eight §13 amendments to the FROZEN SPEC-M03 / SPEC-M04

All eight **REAFFIRMED**. I verified each against what I supplied at WO-0010, and
re-derived the two the work order named.

| § | Record | Verdict and what I checked |
|---|---|---|
| M03 §13 r1 | **C-11**, REQ-015 (my own wording) | **REAFFIRMED — landed faithfully, and improved.** requirements.md REQ-015 carries my replacement verbatim *plus* the clause "pinned in the owning module's spec" that my draft accidentally dropped; the deleted third sentence is gone from REQ-015 **and** from SPEC-M03 §7's restatement, in one diff, as I asked. §7 additionally ties the one-word frame to REQ-107's 5-octet runt — the module-local instance of what requirements.md states generally as REQ-011's 1-to-8-octet payload. Counting convention: 1514 octets = 189 full words + a two-octet word = 190 inclusive, stated in both places |
| M03 §13 r2 | **C-12**, closure list | **REAFFIRMED — the closure-list rule matches my supplied ruling and is broader than it, correctly.** I asked for one corner (an `/E/` in REQ-108's `Discard`); the architect generalised it to "while no frame is open" and then *defined* openness: from the accepted start character until the earliest of the terminate character (REQ-106), an error character while open (REQ-105), a new start character (REQ-110), REQ-108's truncation on the cycle the count passes 1518, or `clear` (REQ-009). I checked that list for completeness against every §9 row and every REQ-101…REQ-113 path and found nothing missing — in particular `cfg_rx_enable` falling mid-frame is correctly **absent**, because §4.3 lets an in-flight frame complete. Every §9 condition is now evaluated only while the frame is open, which is exactly what §0.6's conservation equation needs: a strobe pulsed after closure would be attributable to a frame already counted, which was my stated reason. §6.3 item 6 records the internal state as unobservable, both encodings producing the same observable, so DV asserts nothing about it — right |
| M03 §13 r3 | **C-14.3**, drain window | **REAFFIRMED, and it is the tight bound — re-derived independently.** With N = 8q + r octets between `/S/` and `/T/`: at a lane-0 start the terminate word is cycle q+1, the delivered count N−4 gives ⌈(N−4)/8⌉ = q output words for r ≤ 4 and q+1 for r ≥ 5, so the `tlast` word leaves at q+2 or q+3 — **1 or 2** cycles after the terminate word. At a lane-4 start the terminate word is q+1 (r ≤ 3) or q+2 (r ≥ 4) and the same count gives **0 or 1**. Maximum **2 = ΔC − 1**, and it is *attained* (N = 13 at a lane-0 start: terminate word cycle 2, `tlast` word cycle 4), so REQ-109's "no output activity from 3 cycles after the terminate character onward" is exact and not conservative. The spec's own derivation reproduces this and is correct as written |
| M03 §13 r4 | **C-14.4**, gapless qualifier | **REAFFIRMED as to its rule** — an input word covering no frame octet holds the frame, advances no m, is not a condition, holds the CRC register by its enable, and delays later octets by 8 octet times per cycle. That is exactly what I asked for and it is right. Its **illustrative list** is not — C-18 |
| M03 §13 r5 | **C-14.5**, same-cycle `cfg_rx_enable` | **REAFFIRMED.** §4.3 now says the same-cycle case is outside its sentence, §6.3 item 7 says it is deliberately unconstrained, and §10's REQ-802/810 hook carries the operative instruction: drive the change at least one cycle away from any start character and SHALL NOT assert on the same-cycle outcome. A bench that would have been flaky by construction now cannot be written by accident |
| M04 §13 r1 | **C-14.1**, `tx_tready` | **REAFFIRMED as to its correctness.** The false "0 … during the gap" is gone; `tx_tready` = 1 on the gap's last cycle is right **and tight**, which I re-derived: an acceptance at C+10 would place the start character at C+11, giving a gap of 8 octets from the terminate character inclusive against REQ-204's 12, so C+11 is the earliest legal acceptance and REQ-209's 11-cycle cadence is unachievable one cycle sooner or later. The two obligations named for the earlier gap cycles (REQ-207, REQ-204) are the right pair and they bound the freedom without pinning it. What the record **over-claims** is completeness — §7 does not in fact state "exactly when `tx_tready` is 0" — and the uncovered cycle is the one the whole transmit chain's cadence turns on: C-16 |
| M04 §13 r2 | **C-14.2**, reset vs `Idle` row | **REAFFIRMED.** The `Idle` row now carries the exception *and* §7 declares itself the winner, which is the half that matters — two sections that merely both exist would have left a reader to guess. The first-cycle-after-`clear` mechanism is explained rather than asserted (the word is not accepted, the source holds it, M04 accepts on the next cycle), and §10's REQ-009 hook is now the tight benchable form: present a word on the first cycle after and assert it is accepted on the **second** |
| M04 §13 r3 | **C-14.5**, same-cycle configuration change | **REAFFIRMED, and wider than I asked.** I raised the general case; the record covers both sampling events separately — the frame boundary for `cfg_tx_enable`, the terminate character for `cfg_ifg` — which is right, because they are different cycles and a bench needs to know which one it must avoid |

**Also verified, though not among the eight**: **C-13** landed in requirements.md
REQ-010, correcting the census from one non-stream frame-carrying port to
**seven** in two classes (M02's `data`; the six `Xgmii` lane pairs at M03, M04,
M05 ×2 and M20 ×2). I recounted and seven is right, and the verification column
now states the converse check for all seven. **CONFIRMED CLOSED.** One sentence
of that row is ungrammatical and should be repaired when something else touches
it ("… — the clause class (b) was added without honouring, and which this
revision honours"); it is unreadable rather than wrong and I am not spending a
ledger item on it.

---

#### (c) ADR-0008 — **ACCEPTED**

This binds M11, M15 and M18 before they are written, so I judged it as a
convention rather than as a local fix.

**What makes it acceptable is that the acceptance event is a wire that already
exists.** A port learns it is granted when its first payload word is accepted,
on `payload_tready` — one signal, already in the record for REQ-207's sake. There
is no second handshake for a monitor to watch and therefore no way for two
handshakes to disagree, which is the failure mode that makes header/payload
protocols expensive to verify. Decision 1's simultaneity is the load-bearing
part: it deletes the "granted, but nothing to send" state outright, so M09 never
has to represent it and no bench has to drive it. Rejected alternative (d) is
declined for exactly that reason and I agree with the reasoning.

**Decision 4 checks out arithmetically, which I verified rather than accepted.**
Every Phase-1 transmit frame's Ethernet payload is at least 28 octets — an ARP
packet (REQ-501), or a 20-octet IPv4 header plus an 8-octet UDP header (REQ-610)
— so at least one payload word always exists and the header-without-payload case
is unreachable rather than undefined. The asymmetry with the receive path is real
(§0.7 *requires* a header with no payload frame for a 14-octet Ethernet frame),
it is a consequence of §0.7 rather than of this ADR, and both directions say so.

**Alternative (a) was rightly rejected and I would have argued the same.** Adding
a `ready` to records that also travel receive-path ports would force REQ-003's
structural check — "a receive-path port exposes `Source` with no matching
`Dest`" — to grow an exception, and a structural invariant with an exception
stops being structural. That check is one of the few things in this programme
enforced by the type system rather than by a bench, and it is worth more than the
convenience it would buy.

**The DV cost is one monitor parameter and I accept it.** A header-record monitor
takes its discipline from the port's direction, which the bench already knows;
M06 §7, M07 §7, M08 §7 and M09 §7 each state which binds their own ports. Frame
conservation stays computable in both directions: at M07 §0.6 reduces to the
identity, and at M09 to the sum identity with no discard term, both of which §9
states.

**One reading this acceptance fixes**, because the ADR permits what a monitor
would naturally forbid: decision 3 says the source **may** drop `valid` on the
cycle after acceptance — *may*, not shall. A transmit-side header monitor
therefore keys on the **acceptance event** and never on a `valid` edge, and SHALL
NOT assert that `hdr_valid` falls after acceptance or that it is low between
frames. C-17(d) asks for the one sentence that makes this the text's reading and
not only mine.

---

#### (d) C-15 — **CONFIRMED still owed, not withdrawn**

Unrepaired at 508eea2, verified against the file: §0.5's "Latency" paragraph
still defines constant latency as "a single constant L for every octet of every
frame", and the "Start lanes" paragraph that carves out the two-constant XGMII
case sits **seventy lines below it**. Batch C does not close it and could not:
SPEC-M06 §7 and SPEC-M08 §7 each say locally "there is one constant and not two
… §0.5's start-lane pair has no instance here", which is the right *local*
statement and leaves the definition itself intact for anyone reading it against
M03 or M04. The evidence that this is not hypothetical remains what it was at
WO-0012: I built the single-L monitor from that definition, and a conformant M03
failed it on frame 2 of an alternating-lane run. The repair is unchanged and is
one clause — "…a single constant L … (at the XGMII boundary, one constant per
start lane — see **Start lanes** below)". Owner architect_docs_lead; batch-D
routing (WO-0011 Return log) confirmed.

---

#### Readings this signature fixes

Where two sentences of one document conflict, I signed against the right-hand
column. A bench asserting the left-hand column would fail a conformant design,
or would claim coverage it does not have. None of these is a behavioural change.

| # | The sentence that misleads | The reading that governs, and why |
|---|---|---|
| C-16 | SPEC-M04 §7 (as amended): "It is 0 on the FCS word and on the terminate word … 1 again on the last cycle of the gap" — presented as stating *exactly* when `tx_tready` is 0 | §6.1's cycle table governs, and it asserts `tx_tready` = **1 at C+8** — the cycle after the frame's last source word is accepted (C+7) and before the FCS word (C+9). That value is load-bearing, not incidental: SPEC-M07 §6.2's `Idle` row accepts a frame's first payload word only on a cycle with `tx_tready` = 1, and C+8 is the only such cycle at which M07 is already back in `Idle` (frame k−1's last output word was accepted at C+7) and still early enough to present output word 0 by M04's next acceptance. Were it 0, M07 would accept at C+11, emit output word 0 at C+12, and M04's start characters would be **12** cycles apart — failing REQ-209 and failing the very assertion SPEC-M07 §8 and SPEC-M09 §8 item 5 commission. What is missing is what M04 does with a word actually presented there: §6.2's only first-word acceptance transition is `Idle` → `Preamble`, and `Idle` is entered only once the gap has been served, so no state in the table accepts at C+8; and §6.1's "a source word accepted on cycle C+m is transmitted on C+m+2" cannot hold for it, since C+10 is the terminate word. M04's own §8 REQ-209 bench, driven by a continuous source, drives exactly this case |
| C-17(a) | SPEC-M06 §6.1: "the previous frame's last payload word left at Ci + M + 2 **≤** Ci + K" | The abort paragraph two paragraphs earlier asserts **≥** on the same two quantities, and it is the correct one: M = K − 1 for N ≡ 0 or 7 (mod 8) and K − 2 otherwise, so M + 2 ≥ K always and M + 2 ≤ K only at equality. A REQ-410 bench asserting the previous frame's payload completes by the next frame's first input word fails on any 64-octet input frame. The conclusion is unaffected and its real argument is in the same sentence: M06 emits fewer words than it consumes, so M + 2 < K + 3 always |
| C-17(b) | SPEC-M07 §6.1 "`payload_tready` falls for the last **two** cycles"; §6.2 `Drain` "emits the remaining **one or two** output words"; §7 "0 for the frame's last one or two cycles" | §6.1's own table governs: `payload_tready` is 0 at C+6, C+7 **and** C+8 — three cycles. The count is **W − J + 1**, not W − J: the last payload word is accepted at C + J − 1 and the last output word leaves at C + W. With W − J ∈ {1, 2} the drain is **two or three** cycles and two or three output words. A throughput assertion built from the prose fails every conformant design |
| C-17(c) | SPEC-M08 §6.1: "a producer that pulsed `valid` on the same cycle as the first payload word … M08 tolerates that too" | Nothing states M08's output timing in that case, and §6.3 — whose opening sentence is "anything not listed here is constrained by this specification" — does not list it. The governing fact is that M06 is M08's only producer and always leads by one cycle (SPEC-M06 §7), so the case is unreachable. It belongs on §6.3's list, worded as M07 §6.3 item 3 and M09 §6.3 item 4 already word their unreachable cases |
| C-17(d) | ADR-0008 decision 3: "the source **may** drop `valid` on the next [cycle]" | Permissive, so a monitor SHALL NOT assert that `hdr_valid` falls after acceptance, nor read the header fields outside the offer window, nor treat a `valid` edge as a frame boundary. A transmit-side header monitor keys on the acceptance of the first payload word and on nothing else. One sentence in ADR-0008's Consequences or SPEC-M07 §7 makes this the text's reading |
| C-17(e) | SPEC-M06 §8: directed lengths "**14 through 21** octets inclusive, which cover … all eight payload residues modulo 8 and therefore all eight `tkeep` patterns on the payload `tlast` word" | The residues are covered; the **patterns are not**. Residue 0 in that range is the 14-octet frame, whose payload is zero octets and which emits **no** payload word and therefore no `tlast` and no `tkeep`. The full-word pattern `0xFF` needs a payload length that is a positive multiple of 8 — a **22**-octet input frame — and neither the directed set nor the 60-octet stress frame (payload 46, `tkeep` = 0x3F) nor the 1514-octet case (payload 1500, `tkeep` = 0x0F) produces one. Repair: "14 through 22 octets inclusive". The set is correct as written for REQ-021, whose eight cases are input residues; it is short by one for the `tkeep` claim, and this one matters because it is a **coverage claim that would otherwise be transcribed into SO-M06's coverage table** as a row no test drives |
| C-18 | SPEC-M03 §6.1 and §6.2 `Frame` row (as amended by C-14.4): an input word covering no frame octet is exemplified by "the second word of a lane-4 start's preamble" and by "a terminate character in a **low lane**"; "gapless" is defined as "every XGMII word from the start word onward carrying frame octets" | All three are contradicted by §6.1's own worked examples. **(i)** At a lane-4 start the preamble is cycle 0 lanes 4–7 and cycle 1 lanes 0–3, and §6.1's own "The same frame at a lane-4 start" paragraph says frame octets 0–3 occupy lanes 4–7 of cycle 1 — so the second preamble word covers **four** frame octets, is in `Preamble` rather than `Frame`, and taken literally the row would hold the CRC register across them and fail the FCS check of **every** lane-4 frame (§6.1's CRC bullet 2 and §6.2's closing paragraph both say the enable follows "cycles covering at least one frame octet"). **(ii)** A terminate character in lane k leaves lanes 0…k−1 carrying frame octets, so only **lane 0** gives a word covering none. **(iii)** Under the stated definition of "gapless" no stimulus is ever gapless — the start word carries only preamble — and §6.1's own 64-octet table, whose terminate character is in lane 0 of cycle 9, would not qualify while the table applies the m + 3 formula to it. The **rule** is right and is reaffirmed; the examples and the definition are what need one line each |

---

#### Ledger — dispositions to transcribe (`docs/gates/`)

I did not edit the checklist (PROTOCOL §7).

| id | Disposition |
|---|---|
| C-11 | **CONFIRMED CLOSED.** Replacement text landed in requirements.md REQ-015 and SPEC-M03 §7 in one diff, faithfully and with a clause of the original my draft had dropped |
| C-12 | **CONFIRMED CLOSED.** My proposed ruling adopted and correctly generalised to a closure list; the list is complete against every §9 row and every REQ-101…REQ-113 path. The `AP-xgmii_rx_64.md` row that has been held **NO-ASSERT** since WO-0010 is released: a 1600-octet frame with an `/E/` past the truncation point SHALL show exactly one `error_oversize`, no `error_bad_frame`, and the following frame intact |
| C-13 | **CONFIRMED CLOSED.** Census corrected to seven in two classes; recounted and correct. One ungrammatical sentence noted, no ledger item |
| C-14 | **CONFIRMED CLOSED on all five readings.** 14.1 and 14.2 in SPEC-M04, 14.3 and 14.4 in SPEC-M03, 14.5 in both. C-16 and C-18 are new findings adjacent to 14.1 and 14.4, not a reopening of either |
| C-15 | **CONFIRMED OPEN, not withdrawn.** Unrepaired at 508eea2; one clause; owner architect_docs_lead; batch D |
| **C-16** | **NEW.** SPEC-M04 §7's amended `tx_tready` bullet is correct but not complete, and the uncovered cycle (C+8 in §6.1's table) is the one SPEC-M07's and SPEC-M09's composed cadence turns on; §6.2 has no state that accepts a source word there and §6.1's C+m+2 transmit rule cannot hold for one. Derivation and repair above. Class: **editorial** — §6.1's table already asserts the governing value, and §7's REQ-210 bullet already permits a delayed start character ("back-to-back transmission legitimately delays a start character until the gap is served"). Post-freeze diff to SPEC-M04 with a §13 record. Owner architect_docs_lead. **Must land before SPEC-M04's or SPEC-M07's tb_writer `WO-` leaves my hands** — the composed REQ-209 bench is derivable today only by reading §6.1's table as governing, and I should not be the only place that is written down |
| **C-17** | **NEW.** Five batch-C readings and coverage claims that do not hold as written, tabulated above: (a) SPEC-M06 §6.1's back-to-back inequality, (b) SPEC-M07's drain count in three places, (c) SPEC-M08 §6.1's same-cycle-header claim missing from §6.3, (d) ADR-0008's permissive `valid` drop with no monitor rule, (e) SPEC-M06 §8's directed set short of the `0xFF` `tkeep` pattern. Each is one line. Owner architect_docs_lead. Each must land before the corresponding module's `WO-` goes to tb_writer; (e) additionally before SO-M06 quotes a coverage table |
| **C-18** | **NEW.** The C-14.4 amendment's illustrative list and "gapless" definition in SPEC-M03 §6.1/§6.2 — one wrong example, one loose one, one self-defeating definition. The **rule** is faithful and is reaffirmed; only the illustrations are wrong. Class: editorial, post-freeze diff to SPEC-M03 with a §13 record. Owner architect_docs_lead. **Must land before `AP-xgmii_rx_64.md` and SPEC-M03's tb_writer `WO-`** — example (i) read literally would fail every lane-4 frame's FCS check, which is the sharpest single sentence in this review |

---

#### Answer to SPEC-M07 §11.3, asked of me at this countersignature

**Declined, and the item closes as CONFIRMED rather than deferring to a
requirements.md diff.** §11.3 asks whether M07's bench obligation should be
written as a REQ, since §0.4's stress list is receive-path only and REQ-209's
sustained bench is written against M04. It should not. SPEC-M07 §8 already states
both the obligation and the stimulus, SPEC-M09 §8 item 5 commissions the same
run independently, and a REQ reading "run REQ-209's bench through M09 and M07"
would add no testable fact that either specification does not already carry —
requirements.md §0.2's "one REQ states one testable fact" is the test it would
fail. What §8 gets right is the part a REQ would have obscured: a bench that
drives M04 directly proves nothing about M07, because M07's one-or-two-cycle
backpressure is invisible without it in the loop. I would rather that sentence
live where a reader of SPEC-M07 finds it than be paraphrased into a numbered row.
Note that C-16 is what the composed run's central assertion currently depends on.

---

#### DV actions this review creates for me

1. **`AP-xgmii_rx_64.md`'s C-12 row is released from NO-ASSERT** and becomes a
   positive assertion; the attack plan records the ruling and its §9 citation.
2. **The transmit-side header monitor takes a discipline parameter** (pulse or
   level) from the port's direction, per ADR-0008, and keys the level form on the
   acceptance of the first payload word — never on a `valid` edge (C-17(d)).
3. **`Latency` needs a stated convention for an *inserting* stage.** §0.5 defines
   h as octets removed from the front; M07 adds fourteen. The arithmetic works
   with h = −14 (L = 22, ΔC = 1, closing mod 8, which I verified against M07's
   §6.1 table octet by octet), but the convention is nowhere written and I will
   not invent one silently in a sign-off packet. M07 §7 pins its two measurement
   events explicitly, so no specification change is owed; this is machinery work
   and a documentation line in `octet_time.mli`.
4. **SO-M06 supplies `?ceiling:3` to the tagger** so a ΔC of 4 is a REQ-019
   failure reported by the machinery, and quotes the measured value against the
   zero-reserve ceiling explicitly.
5. **SO-M06's coverage table must not carry the `0xFF` `tkeep` row** until
   C-17(e) lands or the directed set is extended to 22 octets in my own `WO-`.

---

#### For the orchestrator

1. **Stage exactly two paths**: this packet and my journal. Nothing else was
   touched; `docs/`, `libs/`, `test/`, `tools/`, `scripts/` and `tasks/` are
   untouched by me in this activation.
2. **Transcribe the ledger table above** into
   `docs/gates/P1-spec-freeze-checklist.md` (C-11/C-12/C-13/C-14 closures
   confirmed; C-15 confirmed open; C-16, C-17, C-18 new) and the batch-C
   countersignature row, citing `J-dv_lead-0007`. I did not edit the checklist.
3. **C-16 and C-18 are post-freeze diffs to FROZEN specifications** and each
   needs a SPEC-M04 / SPEC-M03 §13 record; both are editorial and neither is
   breaking (no §4 record changes), so the batch-B `ifc_check` evidence still
   witnesses both interfaces.
4. **No new CI run is cited for this commit** — it carries one packet and my
   journal, no code and no spec, so there is nothing for a build to verify
   beyond the journal check itself.
5. `git commit` / `git push`: never run.
