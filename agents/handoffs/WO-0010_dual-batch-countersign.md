# WO-0010: Dual-batch countersignature (batches A + B freeze together)
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: docs/specs/modules/{xgmii_rx_64,xgmii_tx_64,eth_mac_10g}.md
  at f78766e (DRAFT, the review targets) and the revised
  {axi64,crc32_eth}.md at the same SHA (§11-reconciled + the §4.1 XGMII
  addition); requirements.md as revised by WO-0008; the WO-0008 Return log
  (deliverable dispositions, the architect's six §9 rulings, its C-1
  resolution); the P1-spec-freeze checklist (C-11; the batch-A
  superseded-evidence note); compile evidence: run 30729342467 (all five
  lifts elaborate at f78766e) and run 30730405776 (bench layer + your own
  C-9 record-vs-appendix checks green at 00d7a7f)
- **Deliverables**:
  - Verdicts in this packet's Return log:
    (a) per batch-B spec — SIGNED or CONTESTED, judged as the reader who
    hands excerpts to a tb_writer who never sees RTL;
    (b) the post-signature SPEC-M01 §4.1 addition (the `Xgmii` record
    home) — accept or contest; your batch-A signature stands either way,
    the question is whether it extends to the addition;
    (c) the architect's C-1 resolution — unit change to ΔC = (L + h)/8,
    allocation 4/3/1/5/4 = 17 stands, 7-cycle slack restored. Your
    explicit judgment here SEALS the sponsor's delegated latency-budget
    decision (board, 2026-08-02) — accept, or contest with numbers;
    (d) the six §9 rulings the architect flagged as its own (error
    character closes a frame; start-during-REQ-108-discard is
    resynchronisation; underflow transmits accepted words before /E/;
    and the remaining three in the WO-0008 Return log);
    (e) C-11 — your own REQ-015 wording: propose the deletion or
    restatement, judged against the 190-word figure's counting
    convention.
  - If (a) through (c) all sign: the sentence, in your journal entry,
    "I countersign batches A and B (SPEC-M01, SPEC-M02, SPEC-M03,
    SPEC-M04, SPEC-M05) for P1-spec-freeze at f78766e" — orchestrator
    transcribes it and both batches flip FROZEN in the gate table.
  - Journal entry J-dv_lead-0005; Files-in-this-commit: exactly this
    packet.
- **Definition of done**: all five verdict groups explicit; the signature
  decision explicit either way; no edits outside this packet + your
  journal.
- **Out of scope**: bench work (your machinery is committed and green);
  batches C–F; re-reviewing unchanged batch-A text.
## Task
The largest single freeze decision of Phase 1: five specs, the sealed
latency budget, and the §9 rulings that will bind M03's bench. Sign only
what you can defend to the auditor.
## Return / verdict log
(dv_lead appends on RETURNED)

### RETURNED — dv_lead, 2026-08-02T09:20Z

- **State**: ISSUED → **RETURNED**
- **Journal**: `J-dv_lead-0005` · **Spawn short-id**: WO-0010/2026-08-02T08:55Z
- **Judged at**: f78766e (the five specs and the five lifts), with compile
  evidence run 30729342467 (conclusion `success`, head_sha f78766e) and run
  30730405776 (conclusion `success`, head_sha 00d7a7f), both confirmed through
  the GitHub API rather than taken from the packet.

#### SIGNATURE: GRANTED

> **I countersign batches A and B (SPEC-M01, SPEC-M02, SPEC-M03, SPEC-M04, SPEC-M05) for P1-spec-freeze at f78766e.**

Nothing is CONTESTED. Three new carry-forwards (C-12, C-13, C-14) and one
disposition (C-11) come with the signature and none of them blocks it: each is
either an editorial diff whose correct reading the same document already
carries, or a ruling gap on a corner that no bench asserts today. Where two
sentences of one spec conflict, the reading I signed against is written down in
§"Readings this signature fixes" below — that is what a countersignature is
for, and it is the record the auditor should hold me to.

#### Verdict table

| # | Item | Verdict |
|---|---|---|
| a | SPEC-M03 `Xgmii_rx_64` | **SIGNED** |
| a | SPEC-M04 `Xgmii_tx_64` | **SIGNED** (with C-14.1, the sharpest of the editorial diffs) |
| a | SPEC-M05 `Eth_mac_10g` | **SIGNED** |
| b | SPEC-M01 §4.1 `Xgmii` record (post-signature addition) | **ACCEPTED** — my batch-A signature extends to it; C-13 raised against requirements.md, not against the record |
| c | C-1 resolution (ΔC = (L + h)/8, 4/3/1/5/4 = 17, slack 7) | **ACCEPTED and SEALED** — recomputed, not accepted |
| d | The six §9 rulings | **all six CONFIRMED**; two of them are compelled rather than chosen, and I say which |
| e | C-11 (REQ-015, my own wording) | **DISPOSED** — deletion of one sentence plus a counting-convention clause, text below |

---

#### (c) C-1 — recomputed from the definitions, then sealed

I re-derived the identity rather than checking the architect's arithmetic.

**The identity.** Let Ci be the cycle of the input measurement event's word and
Co the cycle of the module's first output word for that frame. §0.5's h is the
octet times from the measurement word's octet-time base (8·Ci) to the frame's
first octet at that same input, so that octet's input octet time is 8·Ci + h.
The output is word-aligned (REQ-021), so its output octet time is 8·Co. Then
L = 8·Co − (8·Ci + h) = 8·ΔC − h, i.e. **ΔC = (L + h)/8**, and because octets
are contiguous at both ports the same difference holds for octet j (both sides
gain j). The identity is exact, not approximate.

**M03's numbers, from the spec's own §6.1 pipeline rather than from §7.**

| Start lane | h | Co − Ci | L = 8ΔC − h | L + h | ΔC | §1.1 ceiling |
|---|---|---|---|---|---|---|
| 0 | 8 | 3 | **16** | 24 | **3** | 4 |
| 4 | 12 | 3 | **12** | 24 | **3** | 4 |

Both rows close mod 8 and both sit one cycle under the ceiling. I also checked
that ΔC = 3 is *achievable*, since a spec that pins an unbuildable constant is
worse than one that pins a loose one: the `tkeep` decision for output word m
needs to know whether a terminate character arrives at or before frame-octet
index 8m+11, which lands at input cycle m+2 at **both** start lanes (octet time
8m+19, lane 3, at a lane-0 start; 8m+23, lane 7, at a lane-4 start). One
register after that decision is cycle m+3. The FCS lookahead is therefore
exactly one word, the payload storage is exactly two words (REQ-019), and the
lane-4 realignment costs no extra cycle — which is why L differs by 4 and ΔC
does not.

**The failure of the old unit, reproduced independently.** Taking the largest
L each §1.1 ceiling admitted under floor(L/8) *and* satisfying (L + h) ≡ 0
(mod 8): M03 L = 32 → ΔC 5 (lane 0) and L = 36 → ΔC 6 (lane 4); M06 L = 26 →
5; M08 L = 8 → 1; M14 L = 44 → 8; M17 L = 32 → 5. Sum **24 at a lane-0 start
and 25 at a lane-4 start** — the architect's figures exactly, arrived at
separately. The whole budget, or over it, with every module passing REQ-019.

**The closure and start-lane checks are real checks, not decoration.**
(L + h) ≡ 0 (mod 8) is what makes ΔC a whole number, and the §0.5 start-lane
pair follows by arithmetic: L0 − L4 = 8(ΔC0 − ΔC4) + 4, which is ±4 for
ΔC4 ∈ {ΔC0, ΔC0 + 1} and ±12 — outside REQ-111's 8-octet-time bound — for
anything else. So `ΔC(lane 4) ∈ { ΔC(lane 0), ΔC(lane 0) + 1 }` is exactly
equivalent to the bound it replaces, and both are checkable at freeze.

**Allocation and feasibility.** 4 + 3 + 1 + 5 + 4 = **17**; budget 24
(= 153.6 ns at 6.4 ns/cycle); **slack 7**, and the slack is real again rather
than notional. I am sealing this on more than coherence: M03 needs 3 and has 4;
M08's routing decision comes from a header record and needs 1; M14's 5 is
comfortable because REQ-602's header checksum completes at input word 2 while
the first payload word cannot leave before input word 3, so verify-before-emit
costs M14 nothing it does not already spend on the 20-octet strip; M06 and M17
are the two I would spend slack on, and 7 cycles covers both twice over.

**Sealed.** Under the board's 2026-08-02 delegation this is the joint
resolution, and nothing further goes to the sponsor. Cost to DV is one line per
sign-off packet: quote ΔC computed from the spec's h and the measured L, beside
the §1.1 ceiling.

*One consequence for my own machinery, recorded here because it is the kind of
thing that otherwise surfaces as a wrong number in a packet.* `Octet_time`
already computes the normative unit (`word_cycles ~strip_octets:h L =
(L + h)/8`), so C-1's closure needs no new code — but `Latency.create`'s single
`~strip_octets` parameter is used for two different quantities, and they part
company at exactly M03's lane-4 start: the octet-correspondence term is 8 (the
preamble M03 removes) while §0.5's h is 12. `Latency.report` would print
ΔC = (12 + 8)/8 = 2 for a conformant lane-4 frame whose true ΔC is 3, i.e. it
would understate the hardest module in its own sign-off packet. Fix is mine and
is listed under "DV actions" below; it lands before any M03 bench runs, not
after.

---

#### (a) The three batch-B specs

**SPEC-M03 — SIGNED.** The latency contract survives the recomputation above.
Three further things I checked rather than read:

1. *§8's stress stimulus is realisable exactly as written.* 8 preamble + 64
   frame octets = 72, terminate at octet time 72, +12 gap = next start at octet
   time 84 = cycle 10 lane 4; from there the next start is at octet time 168 =
   cycle 21 lane 0. Start-to-start 10, 11, 10, 11 … with the start lane
   alternating 0, 4, 0 — §0.3's 84-octet budget and REQ-004's alternation fall
   out of the same arithmetic, so the bench's arrival scheduler has one
   parameter and no choices.
2. *The REQ-108 truncation lands exactly on REQ-015's maximum.* 1514 delivered
   octets = 189 full words + a 2-octet final word = **190 words**, `tkeep` =
   0x03 on the `tlast` word. The oversize decision is available at the same
   +2 offset as every other word (the count passes 1518 at input cycle 190 for
   a lane-0 start; word 189 leaves at cycle 192), so REQ-108 costs no extra
   latency and does not perturb the pinned constants. That is a non-trivial
   consistency between three independent numbers, and it holds.
3. *§9's partition is exactly the partition my conservation monitor needs.*
   Rows 1, 2, 4, 6, 7 forward and mark (`frame_out ~aborted:true`); rows 3, 5,
   8 emit nothing (`discarded ~strobes:[…]`). Every zero-output row carries
   exactly one strobe, so C-2's two-strobes-one-frame case arises only in the
   forwarded class where it costs the equation nothing. The strobe cycle is
   pinned to the `tlast` cycle, or to input-word + 2 where no `tlast` exists,
   and both are computable from the input trace alone — which is what makes a
   §0.6 monitor able to attribute a pulse to a frame instead of counting pulses
   into the void.

Directed-test derivability spot checks: the 5-octet runt (1 delivered octet,
FCS checked, `error_runt` alone with a correct FCS) is constructible today —
my REQ-305 reference already reproduces REQ-304's residue at a 1-octet frame
length (`J-dv_lead-0004` Evidence 4), so the bench can build a *valid-FCS runt*
rather than asserting on a frame it cannot construct.

**SPEC-M04 — SIGNED.** REQ-210's 1 cycle = 8 octet times is right and its two
measurement events are named: both sit at octet position 0 of their words
(REQ-201 puts every start character in lane 0), so the figure is 8 × 1 exactly
and not a rounding. The §6.1 cadence closes: preamble at C+1, next preamble at
C+12 → 11 cycles (REQ-209); terminate at C+10 lane 0 → gap of 16 octets from
the terminate inclusive (REQ-204's minimum is 12) → 88 octets between start
characters, which is REQ-204's verification figure. The gap formula is sound:
g = ⌈(cfg_ifg + t)/8⌉ gives 8g − t ≥ cfg_ifg for every t and lands the next
start on lane 0 by construction; t = 0 → 16 and t = 4 → 12 at the default, as
§6.1 claims. The underflow sequencing is derivable to the cycle: a word
accepted at cycle m transmits at m + 2, so on an underflow at cycle U the words
accepted at U−2 and U−1 go out at U and U+1 and the `/E/` `/T/` word occupies
the missing word's slot at U+2 — exactly §9's "two cycles later", and a bench
must not expect the strobe and the `/E/` on the same cycle. Its one real defect
is editorial and is C-14.1.

**SPEC-M05 — SIGNED.** Zero added octet times in both directions is consistent
with everything it inherits: ΔC = 0 means M05's receive-port constants are
M03's unchanged (L = 16/12, h = 8/12, ΔC = 3) and its §1.1 charge is M03's
alone, which is the arithmetic §1.1 needs to stay additive. §9's "the pulse
that leaves M05 *is* the pulse M03 or M04 raised, one cycle wide, on the same
cycle" is what makes a relay test a cycle-equality assertion rather than a
window assertion, and §6.1's wiring table is total, so REQ-208's structural
half is checkable by inspecting the emitted netlist for any receive-to-transmit
edge. The one thing I would have contested — a structural wrapper exempting
itself from a bench by assertion — is answered in the text: §8 states the
condition under which M05 joins §0.4's list (any register, mux or counter
between its ports and its children's), so the exemption is falsifiable.

---

#### (b) The SPEC-M01 §4.1 `Xgmii` addition — ACCEPTED, signature extends

I diffed 22145b5..f78766e over both batch-A specs and both lifts before
judging, so that the extension is scoped to verified diffs rather than to a
description of them. `axi64_ifc.ml` gains the record and nothing else (18 lines
added, none removed); `axi64.md` gains the record, its §4.2 field table, its
§6.1 paragraph, the REQ-017 §3 row, the `cfg_<field>` convention paragraph, and
the C-8/C-9/C-10 repairs; `crc32_eth.md`'s changes are the §11 reconciliation
plus the REQ-010 narrowing that my batch-A signature was **conditioned on** —
so that condition is now discharged against committed text. Nothing I judged at
22145b5 changed meaning.

The record itself is right, and right for the reason given: field names `d` and
`c` under prefixes `xgmii_rx` / `xgmii_tx` emit REQ-017's four names exactly,
and no longer field name can. Two honest limits I record rather than assume
away: the compile lane witnesses the **widths**, not the emitted port names —
`ifc_check` emits no Verilog — so REQ-017's names are established by the
`rtlprefix` rule and confirmed at M20's port-list check, which is what SPEC-M05
§11.2 already says; and the record deliberately has no `valid`, which is
correct (a lane pair carries a value every cycle) and means none of my
`Stream_word` monitors attaches to an XGMII port. The XGMII side needs the
link-partner encoder/decoder, which is on my backlog and is unaffected by this
decision.

**C-13 is what the addition exposes**, and it is against requirements.md, not
against the record: REQ-010's census sentence says "exactly one frame-carrying
port in the architecture.md §4 inventory is not a stream port — M02's `data`
input", and adds "any further non-stream frame-carrying port is a spec diff to
this row". WO-0008 added six such ports (M03, M04, M05 ×2, M20 ×2) and the row
was not diffed. Under REQ-002's own usage ("every frame-carrying interface
SHALL be 64 bits wide", which `d` satisfies) the XGMII pairs are frame-carrying
and are not streams, so the census is false as written. Repair is one clause;
it changes no behaviour and invalidates no test.

---

#### (d) The six §9 rulings — all confirmed, with the argument I would defend

1. **An error character closes the frame, so a following start character pulses
   nothing.** CONFIRM. REQ-105 terminates the output frame, so there is no
   "current frame" for REQ-110's condition to bite on. Also required for
   accounting: the alternative gives one input frame two closing events, and
   §0.6's attribution of a strobe to a frame stops being a function. The
   same-word case is derivable from lane order (REQ-012, lane 0 earliest):
   `/E/` in lane 0 then `/S/` in lane 4 is one `error_bad_frame`; `/S/` in
   lane 0 then `/E/` in lane 4 is `error_start_without_terminate` for the old
   frame and `error_bad_frame` (zero-delivered) for the new one.
2. **A start character during REQ-108's `Discard` is resynchronisation, not a
   second abort.** CONFIRM, and it is compelled rather than chosen: REQ-108
   *commissions* resynchronisation on the next start character, and the frame
   was already closed with `tlast` and `tuser`[0] = 1. A second pulse would be
   a strobe attributable to no discarded frame, which fails REQ-008(a)'s "no
   strobe pulses other than those of the conditions the stimulus creates" on a
   conformant design.
3. **`error_runt` co-occurs with `error_bad_fcs`; `error_bad_fcs` never
   co-occurs with `error_oversize`, `error_bad_frame` or
   `error_start_without_terminate`.** CONFIRM. A 5–63-octet frame ends with a
   terminate character, so REQ-103's precondition for FCS removal is met and
   the residue check runs; the other three end without one, so no FCS exists at
   the closing point and no result exists to report. Both halves are
   benchable: the valid-FCS runt (single strobe) and the bad-FCS runt (two
   strobes, one `tuser` bit — "one bit on one word, not one bit per condition"
   is the sentence that keeps a monitor from double-marking).
4. **On underflow the already-accepted words are transmitted before the
   `/E/`.** CONFIRM, and this one is also compelled, not chosen: REQ-207's
   "SHALL NOT drop a word it has accepted" is unconditional, and REQ-206
   nowhere requires the accepted words to be dropped. So no requirements.md
   diff is owed under either reading — SPEC-M04 §11.2 can close as
   *confirmed*, and I would resist the alternative because it would make
   REQ-207 conditional on a state a bench cannot observe.
5. **No FCS is appended to an underflowed frame.** CONFIRM. Appending one
   would put a well-formed short frame on the wire, which a link partner
   accepts as real; the `/E/` before the terminate character is what makes the
   truncation visible, and it is exactly what M03 detects as REQ-105 at the
   other end of a loopback. That pairing gives Phase 1 a two-sided test for
   free.
6. **REQ-810's receive half is implemented in M03.** CONFIRM. It is the only
   placement from which "no receive-path stream carries a word" follows without
   every module implementing the same control, and it matches machinery already
   committed: `Conservation_monitor.frame_in_exempt ~reason` exists precisely
   because REQ-810 says a frame refused while receive-enable is 0 "creates no
   silent-discard hole under REQ-008". The matrix split (traceability names
   M20) closes at SPEC-M20 per SPEC-M03 §11.2; my SO-M03 will cite SPEC-M03
   §4.3 as the derivation basis and say so.

---

#### (e) C-11 — disposition of my own REQ-015 wording

**The counting convention is settled by the 190 figure and cannot be read the
other way.** 1514 octets = 189 full words + 2, so 190 is the count **inclusive
of the `tlast` word**; the exclusive reading would give 189. Under the
inclusive reading "at least one word" is satisfied by a frame whose only word
carries `tlast` — which REQ-011 makes mandatory for any payload of 1 to 8
octets, and which SPEC-M03 §9 requires outright (a 5-octet runt delivers one
octet). The third sentence forbids exactly that frame. It is also
unenforceable: the only shape it could forbid is `tlast` on a cycle carrying no
word, and SPEC-M01 §6.3 item 5 forbids a monitor from reading `tlast` when
`tvalid` = 0, while REQ-011 already forbids an empty word.

**Proposed replacement** for REQ-015's second and third sentences (deletion of
the third, one clause added to the second):

> A frame comprises at least one word and at most the number of words its
> maximum payload requires, **the `tlast` word included in that count** — for
> example 190 words on the `Xgmii_rx_64` output stream (1514 octets: 189 full
> words and a final two-octet word, REQ-108). A one-word frame, whose single
> word carries `tlast`, is legal and is the mandatory encoding of any payload
> of 1 to 8 octets (REQ-011, §0.7).

**Two restatements move in the same diff**: SPEC-M03 §7's handshake bullet
carries the deleted sentence verbatim ("and never without at least one
preceding word since the previous `tlast`"), and SPEC-M03 §3's REQ-015 row is
correct as written under the inclusive reading and needs no change.
`traceability.md`'s REQ-015 row cites SPEC-M01 §6.1 and SPEC-M03 §7, both of
which remain the right sections afterwards, so the matrix is untouched.

**Class**: editorial. No module's behaviour changes, no test is invalidated, and
the repair is smaller than the argument for it. My protocol monitor already
implements the inclusive reading, enforces nothing from the deleted sentence,
and carries a unit test asserting the one-word frame legal — so the code is
already on the corrected side and the diff makes the text agree with it, not
the reverse.

---

#### Readings this signature fixes

Where two sentences of one spec conflict, I signed against the right-hand
column. A bench asserting the left-hand column would fail a conformant design;
these are C-14's contents and none of them is a behavioural change.

| # | The sentence that misleads | The reading that governs, and why |
|---|---|---|
| C-14.1 | SPEC-M04 §7: "`tx_tready` is 0 during the FCS word, the terminate word and the gap" | §6.1's own table has `tx_tready` = 1 at C+11, which is **inside** the gap (terminate at C+10 lane 0, next start C+12 lane 0 = 16 octets), and REQ-209's 11-cycle cadence *requires* accepting the next frame's word 0 there. §6.3 item 3 declares `tready` unconstrained when no frame is in progress. Governing: §6.1 + §6.3 item 3. Repair: strike "and the gap", or qualify it as "and the part of the gap during which acceptance would break REQ-204" |
| C-14.2 | SPEC-M04 §6.2, `Idle` row: "`tx_tready` = `cfg_tx_enable`" | §7's reset clause pins `tx_tready` = 0 while `clear` = 1 and on the first cycle after. Governing: §7. Repair: add "except on the cycles §7's reset clause covers". A frame presented on that first cycle is still transmitted correctly because the source holds `tvalid` until accepted, which is worth one sentence somewhere |
| C-14.3 | SPEC-M03 §6.1: output may appear "up to and including cycle ΔC after the terminate word" | The tight bound is **ΔC − 1 = 2**. With N octets between `/S/` and `/T/`, N = 8q + r: at a lane-0 start the terminate word is cycle q+1 and the `tlast` word is q+2 (r ≤ 4) or q+3 (r ≥ 5); at a lane-4 start the difference is 1 or 0. Maximum 2. §10's REQ-109 hook and REQ-109 itself already say "from 3 cycles after", which is correct and tight; §6.1 is loose by one and would let a real drain defect through |
| C-14.4 | SPEC-M03 §6.1: "Output word m is emitted on the cycle m + 3 counted from the word carrying the start character" | True on a **gapless** stimulus only (§0.5's own qualifier). §10 commissions the REQ-016 idle-injection wrapper at 0, 1 and 7 cycles against this module, and under it the sentence is false while the per-octet constant still holds. Governing: §7's handshake bullet + §0.5. Repair: add "on a gapless stimulus", and give §6.2's `Frame` row the sentence its own CRC-enable bullet already implies — an input word covering no frame octet holds the frame and is not a condition |
| C-14.5 | SPEC-M03 §4.3 and SPEC-M04 §4.3: "a frame whose start character is accepted at least one cycle after the input changes is governed by the new value" | The same-cycle case is unconstrained **by implication only**. A bench that changes `cfg_rx_enable` on the exact cycle of a start character and asserts either outcome is flaky by construction. Repair: one line in each §6.3 |

---

#### Ledger — dispositions to transcribe (`docs/gates/`)

I did not edit the checklist (PROTOCOL §7).

| id | Disposition |
|---|---|
| C-1 | **CLOSED and SEALED** at this countersignature. ΔC = (L + h)/8 normative; allocation 4/3/1/5/4 = 17; slack 7; budget 24. Sponsor-authorized under the board's 2026-08-02 delegation; no further sponsor touchpoint |
| C-4 | **CONFIRMED CLOSED.** REQ-105/REQ-110's zero-delivered wording and §0.7 are what SPEC-M03 §9 rows 3, 5 and 8 are derived from, and the three rows are benchable as written |
| C-8 | **CONFIRMED CLOSED.** REQ-903's split is determinable — and it unblocks the REQ-903 half of `tools/check_emitted_verilog.sh`, which has been printing PENDING against C-8 since WO-0009. That script is now mine to finish |
| C-9 | **CONFIRMED CLOSED on both halves.** The architect's hook rewording is in SPEC-M01 §10; my script runs green at f44a296 over all five specs (evidence below) |
| C-10 | **CONFIRMED CLOSED.** "Solely" is restored in SPEC-M01 §6.1 with the monitor guidance attached, which is exactly what I asked for at WO-0007 |
| C-11 | **DISPOSED** — replacement text above. Owner architect_docs_lead. Must land before the first `SO-` cites the protocol monitor; SPEC-M03 §7's restatement moves in the same diff |
| **C-12** | **NEW.** An error character arriving during REQ-108's `Discard` state. §9 row 2's condition text ("`/E/` between the start and terminate characters, with ≥ 1 octet already delivered") still reads true after REQ-108 has closed the frame, while §6.2's `Discard` row lists only `/T/` and `/S/` as exits — so the two sections disagree on a corner an attack plan will certainly drive. Ruling 2 settles the `/S/` case and nothing settles this one. **My proposed ruling**, offered so confirmation is cheap: nothing pulses and nothing is emitted, for ruling 2's own reason — the frame is closed, and a pulse attributable to no frame breaks REQ-008(a). Owner architect_docs_lead. Must land before `AP-xgmii_rx_64.md` is committed; until then that row is marked NO-ASSERT |
| **C-13** | **NEW.** REQ-010's census sentence is false since the `Xgmii` record: six frame-carrying non-stream ports exist, not one, and the row's own "any further non-stream frame-carrying port is a spec diff to this row" was not honoured. Repair: name the XGMII lane pairs as governed by REQ-017 and outside REQ-010's census. Editorial. Owner architect_docs_lead. Must land before REQ-010's verification column is cited as coverage in an `SO-` |
| **C-14** | **NEW.** The five readings tabulated above. Each, read alone, commissions an assertion that fails a conformant design; each is contradicted by a normative section of the same specification, which is why they are editorial rather than blocking. Owner architect_docs_lead. Each must land before the corresponding module's `WO-` goes to tb_writer — that is the moment an excerpt leaves my hands and the ambiguity stops being mine to absorb |

#### DV actions this review created (mine, not the architect's)

1. **`Latency.create`'s `~strip_octets` must split into two parameters** —
   octet correspondence (8 at M03, both lanes) and §0.5's front offset h (8 at
   lane 0, **12** at lane 4). Today `report` would print ΔC = 2 for a
   conformant lane-4 frame. Before any M03 bench.
2. **`word_cycles` should refuse (L + h) mod 8 ≠ 0** instead of truncating.
   §0.5 now makes that closure normative, so the machinery should enforce the
   free check C-1 bought rather than silently rounding past it.
3. **Finish the REQ-903 half of `check_emitted_verilog.sh`** — C-8's closure
   gives it the determinable answer it was waiting for.
4. **The link-partner model's arrival scheduler is now fully specified**:
   SPEC-M03 §8's alternation, §0.3's 84-octet budget and the 10/11 cadence
   agree to the octet, so the next bench work order can be written.

#### Evidence

1. Both cited runs confirmed through the GitHub API, not from the packet:
   run **30729342467**, workflow `build`, `head_sha`
   f78766e9b8306f43c8823ec5e61b42cc381a6203, conclusion **success**; run
   **30730405776**, `head_sha` 00d7a7f3af0dddd7c641bed34af3653a70bfcca2,
   conclusion **success**. The first is what discharges SPEC-M01 §11.4: the
   M03 lift names all six `Axi64.Source` fields and the M04 lift names
   `Dest.tready`, so a v0.17.0 spelling divergence would have failed that
   build. SPEC-M03 §11.1 and SPEC-M04 §11.1 close with it.
2. `tools/dv_checks.sh` at f44a296 → exit 0, `8 check(s) run, 0 failure(s)`
   including `modules/{axi64,crc32_eth,eth_mac_10g,xgmii_rx_64,xgmii_tx_64}.md
   §4.1 == ifc_check/*_ifc.ml (byte identical)` — the five §4.1 blocks I
   judged are the five the CI elaborated — plus `Status = §12 (21 strobes)`
   and `Config = §9.1 (12 fields, widths in order)`. X-9 half:
   `3 check(s) run, 0 failure(s), 5 pending`.
3. Diffs read before extending the batch-A signature:
   `git diff 22145b5 f78766e -- docs/specs/ifc_check/axi64_ifc.ml` is the
   `Xgmii` record and nothing else; the two batch-A markdown diffs are the
   §11 reconciliation, C-8, C-9, C-10, the record's §4.2/§6.1 companions and
   the `cfg_<field>` convention paragraph.
4. Arithmetic reproduced in this log rather than asserted: the ΔC identity, the
   M03 lane-0/lane-4 table, the ΔC = 3 feasibility argument at both lanes, the
   24/25-cycle floor(L/8) failure, the 190-word/0x03-`tkeep` REQ-108 landing,
   the §8 arrival schedule, M04's gap formula at t = 0 and t = 4, and the
   drain-window bound of ΔC − 1.

#### DoD check against this packet

- All five verdict groups explicit: **yes** — (a) three SIGNED, (b) ACCEPTED,
  (c) ACCEPTED and SEALED with recomputation, (d) six CONFIRMED, (e) DISPOSED
  with replacement text.
- Signature decision explicit either way: **yes** — GRANTED, and the exact
  sentence is in `J-dv_lead-0005`.
- No edits outside this packet and my journal: **yes** — `docs/specs/**`,
  `test/**` and `tools/**` untouched; `libs/**` never opened, in this or any
  previous activation.
- `git commit` / `git push`: never run.
