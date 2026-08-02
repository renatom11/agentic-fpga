# WO-0020: Batch F testability countersignature (SPEC-M17–M20) — the last
- **State**: ACCEPTED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: SPEC-M17 (`Udp_ip_rx_64`), SPEC-M18 (`Udp_ip_tx_64`),
  SPEC-M19 (`Udp_complete_64`), SPEC-M20 (`Nic_top`) as drafted at
  **aaa55b2** (WO-0019, `J-architect_docs_lead-0008`); ADR-0010
  (consumer conventions), ADR-0011 (under-delivery leaves the transmit
  path unterminated); architecture.md §6.4 (now 119 edges — one added
  row, `cfg_tx_enable → M18`); the C-24…C-30 landings in the same
  commit; the WO-0019 Return log's seven ordered questions.
- **Deliverables**, in order:
  1. **Countersignature verdicts for the four batch-F specs**, per
     your charter, recomputing rather than trusting: M17's L=8/h=8/
     ΔC=2 against ceiling 4 (identity realignment — no shifter) and
     its precedence scoping; M18's `Udp_tx_request` record, the
     derived stall count **W−J = 1, not W−J+1** (output word 0
     accepted same-cycle as first application word — verify the
     derivation), ADR-0008 obligations; M19's ΔC=0, 15 strobes, and
     the frames-not-pulses conservation fact (first scope with two
     double-pulsing modules); M20's **REQ-006 closure at 13 cycles /
     83.2 ns at both start lanes** vs 24 allocated — re-derive by both
     routes (stage sum 3+3+1+4+2 and (L+h)/8 = 104/8 at each lane)
     and check the 11-cycle slack itemisation; C-3's answer
     (`app_rx_hdr_valid` as the zero-payload observable).
  2. **The architect's seven questions, answered in their order**:
     (1) **ADR-0011** — the sharpest: REQ-709's remedy left M18/M15/
     M09 holding an unterminated frame and its own verification
     column failed a conformant design; the decision is
     abandon-in-place + `clear` recovers + REQ-709's column gains the
     `clear`, with the M04 consume-and-discard repair priced and
     deferred (it contradicts REQ-207 and changes a frozen §6).
     Judge the decision AND the pricing. (2) the `cfg_tx_enable → M18`
     edge (one application word slips through otherwise). (3) M18's
     W−J = 1. (4) REQ-006 = 13 at both lanes. (5) M17's ΔC=2.
     (6) M17's precedence scoping sentence. (7) SPEC-M04 §9's "pulse
     together" bullet — frozen batch-B text the architect deliberately
     did not edit; your call whether it needs a §13 diff or stands.
  3. **Reaffirm or contest C-24…C-30 as landed** at aaa55b2 (each a
     §13-recorded diff on frozen text; none touched a lift — verified
     at acceptance). Also the eleven further §11 closures the
     architect made (items whose Closes-by named M18/M20/batch F) and
     ADR-0010's two conventions answers.
  4. New carry-forwards C-31+ with must-land-before gates.
  5. If all four verdicts positive: the countersignature sentence for
     batch F at aaa55b2 for transcription — **this is the last one;
     on it, all twenty Phase-1 specifications are FROZEN and the gate
     goes to the sponsor for signature.** If any negative: the exact
     owed-diff list.
  - Journal **J-dv_lead-0010**; Files-in-this-commit = exactly what
    you touch plus this packet.
- **Definition of done**: four verdicts + seven answers + ledger
  reaffirmation; sentence or owed diffs.
- **Out of scope**: editing specs/requirements/ADRs (architect's);
  docs/gates/ (orchestrator's); RTL; tests.
- **Evidence**: CI `build` run **30742781586**, conclusion
  **`success`**, SHA **aaa55b2** — the batch-F lifts' first
  elaboration (all four, `nic_top_ifc` the widest in the programme;
  head SHA = spec commit, no witnessing owed), dv_checks step green.
  Run **30742821837** on 7185649 (the acceptance commit, specs
  unchanged) also green.
## Task
The sixth and final countersign cycle of P1-spec-freeze. Twenty
specifications, six batches, every freeze behind a compile proof and
your adversarial signature. Finish it.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-02T15:05Z, journal `J-dv_lead-0010`

**Batch-F countersignature WITHHELD at `aaa55b2`.** SPEC-M18, SPEC-M19 and
SPEC-M20 are **SIGNED**. **SPEC-M17 is CONTESTED** on one behavioural item,
**F-1**, stated in full in §2 with its exact owed diff. Six new carry-forwards,
**C-31 … C-36**, are raised; C-24 … C-30 are all **REAFFIRMED as landed**; the
§11 closures are **REAFFIRMED — and there are twelve of them, not eleven**;
ADR-0010's two answers are **ACCEPTED**; ADR-0011's decision **and** its pricing
are **ENDORSED**, with one factual correction owed against the ADR's own
Consequences section (C-31).

**This is the last signature of the gate, and that is a reason to hold the line
rather than to relax it.** The packet says that on this countersignature twenty
specifications freeze and the gate goes to the sponsor. F-1 costs one architect
activation and one CI run to repair in DRAFT text; after the flip the identical
repair is a post-freeze **§6 behavioural** diff — which is the second of the
three grounds ADR-0011 itself gives for not taking its own alternative (a). I am
not willing to create at M17, in the last hour of the gate, the cost the batch's
own ADR spends three paragraphs refusing to pay at M04.

---

#### 0. What I verified before reading anything, and with what

- **The specs-unchanged claim, checked rather than accepted.**
  `git diff --stat aaa55b2 7185649 -- docs/specs/ docs/adr/` is **empty**; the
  five paths that moved are the WO-0019 packet, the WO-0020 packet, the
  orchestrator journal, the gate checklist and `tasks/BOARD.md`. Batch F at the
  working tree **is** batch F at `aaa55b2`, so this review's SHA is `aaa55b2`.
- **Both CI runs fetched through the GitHub API, not taken from the packet.**
  Run **30742781586**: workflow `build`, event `push`, head SHA
  `aaa55b288e4ea580dfb157132c8aa478a10133b9`, conclusion **`success`**, twelve
  steps all green including `Build` and `DV mechanical checks`. Head SHA = the
  spec commit, so **no witnessing argument is owed anywhere in batch F**. Run
  **30742821837**: head SHA `7185649…`, conclusion **`success`**. The four new
  lifts are in the single `ifc_check` library (21 `.ml` files, one `dune`), so a
  green `Build` at `aaa55b2` **is** their first elaboration — including
  `nic_top_ifc.ml`'s `Config`/`Status` witnesses and
  `udp_complete_64_ifc.ml`'s `open! Udp_ip_tx_64_ifc` of a sibling declared in
  the same batch. §12's evidence rows are dischargeable from this run.
- **Re-run locally at the working tree**: `tools/check_records_vs_appendix.sh`
  → **23 checks, 0 failures** (all four batch-F lifts byte-identical to their
  §4.1 blocks); `tools/dv_checks.sh` → **exit 0**, 4 checks, 0 failures, 4
  pending, `check_emitted_verilog.sh: OK`.
- **REQ set equality recomputed by script, not read**: requirements.md **110**
  bolded row leaders, traceability.md **110** rows, **110** distinct — no
  duplicate row, symmetric difference **empty**. The six `pending` strings in
  traceability.md are all prose about the file's own history; **no
  Spec-section cell reads `pending`**.
- **architecture.md §6.4 recounted by strict row shape**: **119** edges =
  **26 + 40 + 31 + 22**, matching §6.4's own claim and its four subsection
  headers. The added row `M20.cfg_tx_enable → M18.cfg_tx_enable` is present at
  §6.4.3 beside the pre-existing `M20.cfg_tx_enable → M04.cfg_tx_enable`.
- **`libs/**` was not opened, in this or any previous activation.** Every
  number below is arithmetic I did by hand from specification text, or a script
  that already existed. No RTL exists for any batch-F module and none was read.

---

#### 1. The four verdicts

**SPEC-M17 `Udp_ip_rx_64` — CONTESTED (F-1). Everything else in it recomputes.**

What I recomputed and what held:

- **L = 8, h = 8, ΔC = 2 against a ceiling of 4: confirmed by both of §0.5's
  routes.** h = 8 because M17 strips eight octets and its input is word-aligned,
  so §0.5's second term is 0 — and requirements.md §0.5 states "8 at M17"
  normatively, so this is not M17's claim to make wrongly. Per-octet: UDP
  payload octet *i* enters at octet time 8Ci + 8 + i and leaves at
  8(Ci + 2 + ⌊i/8⌋) + (i mod 8) = 8Ci + 16 + i, so **L = 8 for every i**, one
  value and not a mean. Word delay: first application word at Ci + 2 against the
  measurement event Ci gives **ΔC = 2**, and (L + h)/8 = 16/8 = **2**. The two
  routes agree and (L + h) = 16 is a multiple of 8 as §0.5 requires of a
  conformant module.
- **The identity realignment is real and is the reason for the reserve.**
  Application word *j* **is** input word *j* + 1 octet for octet, so REQ-021 is
  discharged by arithmetic and no shifter exists. Two cycles is the minimum with
  a registered output (input word 1 arrives at Ci + 1; a registered output emits
  it at Ci + 2), and the alternative is a combinational path from
  `ip_payload_tdata` to `payload_tdata`, which SPEC-M14 §7 rejects for itself.
  **Two cycles of reserve inside M17's own allocation: I sign the reserve as
  reserve**, and I agree it should not be re-allocated here (question 5).
- **The precedence scoping over the whole 8-octet header: endorsed** (question
  6, argued below).
- **§8's stress arithmetic**: four payload words per datagram against
  start-to-start spacing of 10 and 11 cycles leaves **6 and 7** idle cycles on
  the payload stream, with the header pulse falling inside the idle run rather
  than occupying a fifth cycle. Correct, and it is the M10 §8 correction applied
  before the fact rather than after it.
- **The directed set is the best in the programme**: C-26's extensional branch,
  C-30's `clear` exemption and C-17(e)'s length-16 `0xFF` case are all written in
  **before** a bench exists to fail on them, and the 1-to-7-delivered band is
  correctly distinguished from the lengths-9-to-15 band a reader would confuse
  it with.

**F-1 — SPEC-M17 §6.1 and §6.2 direct M17 to copy an input bit it has not yet
received, on a class of datagrams this specification declares reachable and
commissions a directed test for.**

The `Tail` state exists for a UDP length that **under**-declares what IPv4
delivered (§6.2: "*`Tail` is not dead code and the case is worth naming*"), and
§8 drives it: IPv4 total length 46 with UDP length 20. §6.2's `Payload` row says
the application `tlast` word carries "`tuser`[0] **copied from the input `tlast`
word**", unconditionally. In the `Tail` case that word has not arrived.

Derivation, from this specification's own formulas and nothing else. Let *N* be
the octets IPv4 delivered, *N′* ≤ *N* the UDP length, *K* = ⌈*N*/8⌉ input words
and *M* = ⌈(*N′* − 8)/8⌉ application words:

- the input `tlast` is presented on cycle **Ci + K − 1**;
- application word *j* leaves on **Ci + 2 + j** (§6.1), so the application
  `tlast` word — index *M* − 1 — leaves on **Ci + M + 1**.

The bit is available to a registered output only if Ci + M + 1 > Ci + K − 1,
i.e. **M ≥ K − 1**, i.e. **⌈*N′*/8⌉ = ⌈*N*/8⌉**. Three regimes follow:

| Regime | Application `tlast` vs input `tlast` | Verdict |
|---|---|---|
| ⌈*N′*/8⌉ = ⌈*N*/8⌉ (includes *N′* = *N*) | one cycle **after** | implementable; this is §6.1's "margin is exactly zero", and it is correct |
| ⌈*N′*/8⌉ = ⌈*N*/8⌉ − 1 | **same cycle** | needs a combinational `ip_payload_tuser` → `payload_tuser` path on the emitting cycle. No section sanctions one; §7's registered-output argument excludes it. **§8's own under-declaring datagram is this case**: *N* = 26, *N′* = 20, *K* = 4, *M* = 2 — input `tlast` at Ci + 3, application `tlast` at Ci + 3 |
| ⌈*N′*/8⌉ ≤ ⌈*N*/8⌉ − 2 | **strictly before** | impossible for any implementation. Worst case *N* = 1480, *N′* = 9: the application `tlast` leaves **182 cycles** before the input `tlast` arrives |

**§6.1's proof of the opposite runs one inequality the wrong way.** It argues
"Since *N′* ≤ *N*, *M* + 1 ≥ ⌈(*N* − 8)/8⌉ + 1 ≥ *K*". *N′* ≤ *N* gives
*M* ≤ ⌈(*N* − 8)/8⌉, not ≥. The residue algebra beside it is right — writing
*N* = 8q + r, ⌈(*N* − 8)/8⌉ = *K* − 1 for every r — and it proves the **equality**
case, which is exactly the *N′* = *N* case and no more. The conclusion "the
application `tlast` never leaves before the input `tlast` has been seen" is
therefore true of full-delivery datagrams and false of the `Tail` class.

**Why this is a contest and not a carry-forward, by the line I set at WO-0015
and applied in both directions at WO-0018.** I carry a finding when a document
one level up states the correct reading (C-26, settled by REQ-605) or when no
committed hook asserts the wrong one (C-24). Neither holds here. **Five sites
state the unimplementable rule** — §3's REQ-007 row, §4.2's `payload_tuser` row,
§6.1's proof and its conclusion, §6.2's `Payload` row, and §10's REQ-007/REQ-013
hook — and **no site anywhere states what M17 emits instead**. §6.3 does not
list the value among the deliberately unconstrained. requirements.md REQ-007
settles it in the *impossible* direction: "every downstream module that emits an
output frame for it SHALL mark the corresponding final word of its own output
stream `tuser`[0] = 1". That is D-1's shape exactly, and D-1 is why batch D was
withheld.

**The defect does not need an abort to bite.** Even with `tuser`[0] = 0
upstream, §6.2 instructs a copy from a word that has not arrived, so the value
of `payload_tuser` on the application `tlast` word is **unspecified for every
under-declaring datagram** and a monitor has nothing to assert. With an abort
upstream it is worse: the combination is reachable — a bad-FCS frame carries
`tuser`[0] = 1 down the whole chain (REQ-104, REQ-007) and its corrupted UDP
length field may under-declare by any amount — and then a conformant M17
*cannot* satisfy REQ-007.

**Owed diff (F-1), three clauses plus one optional, all in DRAFT text:**

1. **§6.1** — scope the availability argument to ⌈*N′*/8⌉ = ⌈*N*/8⌉, correct the
   inequality's direction, and state the `Tail`-class outcome. The residue
   algebra needs no change; only the quantifier over *N′* does.
2. **§6.2 `Payload` (and `Tail`) rows** — qualify the copy: `tuser`[0] is copied
   from the input `tlast` word when the application `tlast` is emitted **on or
   after** the cycle that word arrives; where the declared count completes
   first, the application `tlast` word carries `tuser`[0] = **0**, because no
   abort has been observed at that point. **0 is the only implementable value**;
   if the architect prefers to make it unconstrained instead, §6.3 must say so
   and §10's hook must exclude the class — but silence is not an option, because
   an implementer must emit something.
3. **A §11 row** recording the consequent REQ-007 scoping — a datagram whose UDP
   length under-declares by at least one whole word cannot carry an abort
   detected after its application frame has ended — with the reader's assumption
   stated, and §10's REQ-007/REQ-013 hook excluding that class from its "with the
   bit set on its last word" assertion.
4. *(Optional, and I would take it)* — §8's under-declaring directed datagram
   gains the explicit `tuser`[0] = 0 assertion, fixing the case in a test rather
   than in prose, which is what §8 did for C-26 at M14.

**No requirements diff is owed** on my reading: REQ-007's subject is "every
downstream module that **emits an output frame for it**", and the under-declaring
datagram's application frame is a frame for the *declared* datagram rather than
for the delivered one. That reading needs to be **stated** at M17 rather than
inferred, which is what clause 3 does. If the architect judges otherwise, the
alternative is a REQ-007 scoping clause and that is a normative diff — say so
and I will re-review on that basis instead.

---

**SPEC-M18 `Udp_ip_tx_64` — SIGNED.** Two editorial corrections owed (C-34,
C-35); neither is a condition of this signature, and both land free in the F-1
repair commit since the batch flips together.

- **`Udp_tx_request`: accepted as declared, at the right module.** Five fields,
  `valid` and no `ready`, declared at M18 under the declare-once rule rather than
  added to a FROZEN M01 — which would have been the programme's first breaking
  post-freeze interface change. `payload_length` counting **UDP payload octets
  only** is stated at the port, in §4.2, in §5 and in the lift comment; it is the
  one field a bench gets wrong and it is stated four times, correctly, everywhere.
- **The stall count W − J = 1 is right, and I derived it rather than checked
  it** (question 3, in full below).
- **ADR-0008's obligations discharge as claimed.** Decisions 1 and 2 are stated
  at the port; **decision 4 is genuinely unreachable rather than tolerated** —
  output word 0 is the UDP header, which every frame has — and I verified the
  independent reason it cannot be dodged: a zero-octet application payload has no
  `Axi64` encoding (REQ-011 forbids `tkeep` = 0), so the smallest transmittable
  datagram has UDP length 9. Decision 3's stronger-commitment clause is correctly
  scoped to a monitor **at this port** under ADR-0008's C-22 precedence clause,
  which I raised at WO-0015 and which is being used here exactly as intended.
  M18 is the third and last source and the enumeration SPEC-M07 §11.2, SPEC-M09
  §11.3 and SPEC-M11 §11.2 track is closed.
- **§8's six substitute obligations are the right six**, and item 1's invariance
  test is the strongest form of REQ-705 anywhere in the programme: **zero**
  application words accepted before the first output word is accepted, at every
  length. A store-and-forward implementation fails it at length 1.
- **The head cost of two cycles is M15's resolution wait relayed**, verified
  against SPEC-M15 §6.1 step 3 and §7 — M18 adds zero and says so.

**SPEC-M19 `Udp_complete_64` — SIGNED.**

- **ΔC = 0 and the chain figure check out.** M16's 8 = 3 + 1 + 4 and M17's 2 give
  **10** cycles against (3 + 1 + 5) + 4 = **13** allocated; the front offset
  42 = 34 + 8. M19 holds no payload storage and the wiring tables are total in
  both directions — I walked them for orphans and found none: every port of §4.2
  appears exactly once as a source or a sink.
- **Fifteen strobes: 12 + 2 + 1 = 15**, and M16's twelve decompose as M06's 1 +
  M08's 1 + M13's 3 + M14's 7. Fifteen plus M05's six is **21**, which is the
  whole of requirements.md §12, asserted at M20 rather than assumed here.
- **The frames-not-pulses conservation fact is the right instruction** and I sign
  it. Its *locality claim* is wrong and is carried as **C-33**: the difference
  between counting frames and counting pulses is reachable by a single frame at
  **M14 alone** (SPEC-M14 §9's independent evaluation, driven by SPEC-M14 §8's
  two-condition datagram) and at M17 alone, not first at M19. What is first at
  M19 is the *coexistence of two double-pulsing modules in one scope*, which is a
  true and different fact. The claim as written tells a monitor writer at M14 and
  M16 that the trap does not bite there, and it does.
- §9 fact 3 (separating the transmit strobe from the receive equation) is a real
  catch and is the kind of thing found only by writing the equation out.

**SPEC-M20 `Nic_top` — SIGNED.**

- **REQ-006 = 13 cycles at both start lanes, re-derived by both routes from the
  five children's pinned constants** — which I re-read at SPEC-M03 §7, SPEC-M06
  §7, SPEC-M08 §7, SPEC-M14 §7 and SPEC-M17 §7 rather than from M20's table:

  | Stage | h (lane 0 / lane 4) | L (lane 0 / lane 4) | ΔC | ceiling |
  |---|---|---|---|---|
  | M03 | 8 / 12 | 16 / 12 | 3 | 4 |
  | M06 | 14 | 10 | 3 | 3 |
  | M08 | 0 | 8 | 1 | 1 |
  | M14 | 20 | 12 | 4 | 5 |
  | M17 | 8 | 8 | 2 | 4 |
  | **chain** | **50 / 54** | **54 / 50** | **13** | **17** |

  Stage sum: 3 + 3 + 1 + 4 + 2 = **13**. Octet route: (54 + 50)/8 = 104/8 = **13**
  at lane 0 and (50 + 54)/8 = **13** at lane 4; (L + h) = 104 is a multiple of 8
  in both, as §0.5 requires. **13 × 6.4 ns = 83.2 ns** against 24 cycles /
  153.6 ns. The h totals also match requirements.md §1.1's own row (Σ h = 50 /
  54), which is a third, independent check the architect did not claim.
- **The three structural wrappers really do add zero**, verified at SPEC-M05 §7
  (M05 adds 0 on top of M03), SPEC-M16 §7 (0 on top of M06+M08+M14), SPEC-M19 §7
  and SPEC-M20 §7 — so the five-term sum is the whole chain with nothing omitted.
- **The lane-independence claim is correct and is the sharper assertion the
  architect says it is.** M03's two per-octet constants differ by 4 octet times
  and its two (L + h) sums are both 24, so ΔC = 3 at both lanes and the whole
  chain is lane-independent in cycles. REQ-006's verification column permits a
  one-cycle difference; this chain does not exhibit one, so **13 at one lane and
  14 at the other is a defect**. I sign that as normative for my own bench.
- **The 11-cycle slack itemisation audits exactly**: 24 = 13 spent + 4 module
  reserve + 7 architect's slack; reserve = (4−3) + (3−3) + (1−1) + (5−4) + (4−2)
  = 1 + 0 + 0 + 1 + 2 = **4**, held at M03, M14 and M17 with M06 and M08 at zero;
  architect's slack = 24 − 17 = **7**. Every term is where the table says it is,
  and the reserve-versus-slack distinction (spendable by a module's own §7 diff
  versus requiring requirements.md §1.1 **and** architecture.md §4 together) is
  the property that makes the table worth keeping. **Not re-allocating at this
  gate is correct** and §11.3's reasoning is the reasoning I would have given.
- **C-3's answer is accepted.** `app_rx_hdr_valid` **is** a top-level port
  (§4.2), a zero-payload datagram is accounted for by its pulse, and the two
  zero-payload cases landing in **different terms** — UDP length exactly 8 in
  term 2, IPv4 total length 20 in term 3 via `error_udp_bad_length` — is the
  distinction that makes the equation writable. Term 3 counting **frames** and
  term 4 being **supplied by the stimulus** are both right, and the sentence "a
  consumed frame is not a discarded one" is the one that stops the equation
  looking broken. C-3 stays **open** until the top-level stress bench, as its own
  row says. One decision-procedure gap is carried as **C-32**.
- **REQ-806's fifth §12 row** is the right shape: derived pair stated, measured
  pair pending, and "a measured figure that differs from 13 is a defect rather
  than a correction" is REQ-019's own rule applied in the right direction.

---

#### 2. The seven questions, in the architect's order

**(1) ADR-0011 — the decision is right and the pricing is right. ENDORSED, with
one correction owed against the ADR's own text.**

*On the decision.* Abandon-in-place with `clear` as the recovery is the correct
disposition, and I would have reached it from the other end. The test of a
recovery mechanism at spec-freeze is not whether it is elegant but whether a
bench can **drive it and observe it**, and `clear` scores on both: it is a
top-level port (SPEC-M20 §4.2), every module on the chain already states its
effect in its own §7, and the recovery is therefore *already specified* at five
modules rather than newly invented at one. Alternative (c)'s back-signal would
have added an unobservable coupling — four modules abandoning a frame on a
signal from a fifth, with no port at which the abandonment is visible — and
would have invalidated four freeze records' compile evidence. **The decision
makes REQ-709's test writable**, which is the whole point: declare 100, supply
90, check the wire and both strobes, assert `clear`, then check the next frame.
Every step of that is observable at a port.

*On the pricing of the deferred M04 repair.* The three grounds compound
correctly and in the right order. Ground 1 is the strongest and is the one I
would have led with: SPEC-M04 §11.2 records **my own** WO-0010 classification of
the REQ-206/REQ-207 interaction as *compelled by REQ-207's unconditional
wording*, and alternative (a) makes REQ-207's verification column false — "the
decoded wire octet sequence equals the accepted-word octet sequence exactly once,
in order" cannot survive M04 discarding accepted words. Reversing a closed item
of mine at the freeze gate would need a fresh argument, and "a real NIC would
want it" is not one at this phase. Ground 3 is the honest one: the path is not
taken unless a bench deliberately drives it, and the Phase-2 application is our
own code. **I confirm the deferral and I confirm the price**: SPEC-M18 §11.4
carries it with the cost named, and the closing gate — Phase-2 hardening or the
first real-hardware attach — is the right gate. When real hardware attaches, (a)
is the repair and REQ-207 gains a scoping clause in the same diff.

*Is a design needing a global reset after an application error
"testable-in-good-conscience"?* **Yes, at Phase 1, and I say so as the person who
would have to write the bench.** Three reasons, stated so the answer is not a
shrug: the path is entered only by a violation of REQ-705's contract by our own
application; the wire behaviour — `/E/`, `/T/`, no FCS, one `error_underflow` —
is *correct* and fully observable, so the requirement's normative sentence is
discharged without the recovery; and the residual state is **quiescent, not
corrupt** — no spurious frame, no lost word, no silent discard. A bench asserting
`clear` between the error case and the next frame is asserting a documented
recovery, not papering over an unknown. What would *not* be testable in good
conscience is the state ADR-0011 found and removed: a verification column
commissioning "check the next frame transmits correctly" from a wedged chain.

*The correction owed (**C-31**).* ADR-0011's **Consequences** says of SPEC-M04
§9's co-occurrence bullet: "it **now says** ordered-and-unpinned", and its
**Affects** header lists SPEC-M04 §9 as affected. SPEC-M04 §9 at `aaa55b2` says
the two strobes "pulse **together**, from different modules, for one event",
bolded, and was not edited — as the WO-0019 Return log item 5(b) correctly states
it was not. requirements.md REQ-709's new verification column compounds it by
citing "SPEC-M18 §9, SPEC-M04 §9" for the not-simultaneous reading. So **two
committed documents now cite SPEC-M04 §9 for a proposition SPEC-M04 §9
contradicts**, and one of them asserts a diff that does not exist. That is worse
than the original ambiguity, because a bench writer following the citation finds
the opposite of what sent them.

**(2) The `cfg_tx_enable → M18` edge — ACCEPTED, and on the same ground I
accepted `cfg_subnet_mask → M14` at batch E.**

I checked the mechanism rather than the argument. Without an enable at M18: M18
offers the header (it cannot know transmit is disabled), M15 issues its query and
at Q + 2 **accepts the frame's first payload word whichever answer arrives**
(SPEC-M15 §6.1 step 3 — "whichever answer arrives" is unconditional, and I
re-read it), so M18's `payload_tready` is 1 for that one cycle. Downstream, M04's
`Idle` row drives `tx_tready` = `cfg_tx_enable` = 0, so M07 fills, M09 stalls,
M15 stays in `Header` holding body word 0 and accepts no further payload word.
**Exactly one application word, exactly once** — the architect's figure, and it
is exact rather than approximate. REQ-810's verification column says "`tready`
stays low", so a bench written from the requirement fails a conformant design on
the first cycle, and §8 item 6's "0 on every cycle — not 'falls within N cycles'"
is the right assertion to want.

The edge costs one input on a **DRAFT** module, one wire in a DRAFT wrapper and
one architecture row; **no frozen text moves, no record changes, no REQ moves,
nothing is renamed**. Rewording REQ-810's verification column instead would have
moved a requirement to accommodate a topology — the same trade I refused at
batch E — and "one word may be accepted while transmit is disabled" is a sentence
that would have to be defended forever. **Not E2**: no requirement is added,
dropped or weakened. The three-halves split (M03 receive, M04 XGMII, M18
application-interface, M13's ARP clause unaffected) is correctly stated at four
places and `traceability.md`'s REQ-810 row names all four modules — I checked the
row. One composed consequence of the two readers is unstated and is carried as
**C-36**.

**(3) M18's W − J = 1 — CONFIRMED. Recomputed from the events, not from the
formula, and the difference from M15 is exactly the one event the architect
names.**

M18 adds **exactly one word at every payload length with no residue classes**:
W = ⌈(P + 8)/8⌉ = ⌈P/8⌉ + 1 = J + 1. Over a frame, application words are accepted
on cycles **C … C + J − 1** and output words are emitted on **C … C + J**, so the
emission window is C … C + W − 1 and contains exactly J acceptance cycles; the
stalled cycles are W − J = **1**, at C + J. For §6.1's own frame (P = 18, J = 3,
W = 4): acceptances at C, C+1, C+2; emissions at C, C+1, C+2, C+3;
`payload_tready` = 0 on C+3 alone. **One cycle.**

The contrast with M15 is structural and I verified it at M15's own text rather
than accepting the summary. M15's first body word leaves at **C + 1**, one cycle
*after* the acceptance that starts the frame, so its emission window is
C + 1 … C + W and contains only J − 1 acceptance cycles: stalls =
W − (J − 1) = **W − J + 1**. SPEC-M15 §6.1's worked frame (J = 4, W = 6) shows
`payload_tready` = 0 at C+4, C+5, C+6 — three cycles = W − J + 1. Both are right,
they differ by exactly one, and the one is **whether the first emission coincides
with the first acceptance**. M18's does because output word 0 was offered two
cycles earlier and was waiting; M15's does not.

**"W − J + 1 is not a programme constant; it is a consequence of where the first
output word sits relative to the first acceptance, and each module derives it" is
the correct generalisation of C-17(b)**, and it is a better statement of the
lesson than the one I wrote when I raised it. A bench carrying M15's formula to
M18 fails a conformant design **on every frame**, which is the same failure mode
C-17(b) caught at M07 with the opposite sign. Scope note for the sign-off packet:
the one-cycle figure is the **`Drain`** path; `Excess` holds `payload_tready` = 1
and `Short` holds it 0 indefinitely, both by design (§6.2), so "exactly one cycle
at each frame's end" is a statement about conformant frames and a monitor should
be told which state it is in. That is not a defect — §6.2 states both — but it is
the sentence a bench writer needs beside §7's, and I will put it in
`AP-udp_ip_tx_64.md`.

**(4) REQ-006 = 13 at both start lanes — CONFIRMED by both routes and by a third
the architect did not claim.** The stage sum 3 + 3 + 1 + 4 + 2 = 13; the octet
route (54 + 50)/8 = (50 + 54)/8 = 13; and requirements.md §1.1's own Σ h row
(50 / 54) independently agrees with M20 §7's h totals. 83.2 ns against 153.6 ns.
**The lane claim is the sharper assertion and I endorse making it**: because M03
pins ΔC = 3 at both lanes, a per-lane difference is a defect, not the "legitimate
difference of one cycle" REQ-006's column permits — and stating it where it is
derived is right, because a bench that measured 13 and 14 would otherwise
**pass**. My REQ-006 bench will assert 13 at each lane, per frame, over all
10 000, and my `SO-nic_top.md` will report the measured pair against 13 with the
REQ-019 rule naming which document the evidence contradicts if they differ.

**(5) M17's ΔC = 2 and its two cycles of reserve — CONFIRMED, and the decision
not to re-allocate is right.** Two is the floor with a registered output;
anything less is a combinational `tdata` path the programme rejects twice over.
The reserve exists because §1.1's allocation was written before any specification
had observed that the UDP header is the one header on the chain that is a whole
number of words — a stage with no realignment to perform costs about two cycles
less than one that has it — and that explanation is *checkable*: M06 strips 14
and holds 0, M14 strips 20 and holds 1, M17 strips 8 and holds 2. **Re-allocating
now would move numbers in three documents to give cycles to stages that have not
asked for them, immediately before a freeze gate**, and would destroy the
property that makes the table useful. The right moment is after the first
`P1-module-ready`, when measured word delays exist for all five stages —
SPEC-M20 §11.3's own answer, and I sign it.

**(6) M17's precedence scoping over the whole 8-octet header — ENDORSED as
given.** This is the scoping sentence I asked for at WO-0018 answer (iii) item 4,
and the shape is the right one. The argument that decides it is testability, not
tidiness: a rule with **two** thresholds — port test suppressed below 4 octets,
length test below 6 — is a rule with two boundary cases a bench must enumerate
and an implementer must get right in the same order, and the two thresholds are
one octet apart in a header that arrives in a single word. **Nothing observable
is lost by the wider scope**, because a datagram delivering 1 to 7 octets has no
complete header of either kind and `error_udp_bad_length` is the report either
way; what is gained is that the rule is a function of one predicate a bench
computes from its own stimulus. The narrower rule the architect says is "one
clause away" would be defensible and would buy nothing, and I would bounce it on
review. The independent-evaluation half — no precedence, both strobes pulse, and
the reason (a precedence order would be **unobservable at the port**) — is copied
from M14 correctly, and §8's two-condition datagram fixes it in a test.

**(7) SPEC-M04 §9's "pulse together" bullet — the §13 diff is OWED. It does not
stand, and the reason is stronger than when the architect asked.**

Had the question been only "can a bench writer misread 'pulse together' as
same-cycle?", I would have carried it: SPEC-M18 §6.3 item 5, SPEC-M18 §9 and
requirements.md REQ-709's column all state the correct reading, and the neighbour
paragraph in SPEC-M04 §9 already shows the spec being careful about cycle-level
claims ("a bench must not expect the strobe and the `/E/` on the same cycle").
That is the C-26 pattern and it carries.

It does not carry, because **ADR-0011 as committed says the change was already
made**. Its Consequences bullet reads "it **now says** ordered-and-unpinned" and
its Affects header lists SPEC-M04 §9. Neither is true at `aaa55b2`. An ADR that
describes a diff nobody made is a worse artifact than an unedited bullet, and it
is the kind of thing an auditor finds by grep. So one of two things is owed, and
the architect chooses which:

- **preferred** — a one-row §13 editorial diff at SPEC-M04 replacing "pulse
  **together**" with the ordered-and-unpinned wording (M18's on the cycle it
  accepts the short `tlast`, M04's later by an unpinned number of cycles, a bench
  asserts one pulse of each and nothing about the separation), `ADR: ADR-0011`,
  `Breaking? no` — the diff ADR-0011 already claims exists; **or**
- a correction to ADR-0011's Consequences bullet and Affects header saying the
  M04 text was deliberately left and naming the two documents that carry the
  correct reading.

The first is one line and makes three documents agree; the second is two lines
and leaves a frozen spec saying the wrong thing. **I recommend the first**, and
it lands free in the F-1 repair commit. Tracked as **C-31** either way, gated
before `SO-xgmii_tx_64.md` and before any bench asserting REQ-709.

---

#### 3. Ledger reaffirmation

**C-24 … C-30: all seven REAFFIRMED as landed, and I re-derived rather than
re-read the two that carry arithmetic.**

- **C-24 — REAFFIRMED, derivation independently reproduced.** With N the request
  length DA through FCS, terminate at cycle 1 + ⌊N/8⌋ and payload `tlast` at
  6 + ⌈(N − 18)/8⌉, the gap is 5 + ⌈(N − 18)/8⌉ − ⌊N/8⌋. Writing N = 8q + r:
  ⌈(N − 18)/8⌉ = q − 2 for r ∈ {0, 1, 2} and q − 1 for r ∈ {3 … 7}, giving a gap
  of **3** and **4** and a response of **7** and **8**. N = 64 → 7, N = 67 → 8,
  N = 1518 (r = 6) → 8. Reproduces my WO-0018 figures exactly. Naming the
  mechanism — an octet time converted to a cycle by division discards the residue
  a *difference between two events at different octet positions* depends on — is
  the right generalisation, and it is C-1's class one level up.
- **C-25 — REAFFIRMED.** Five four-word ARP payloads of 28–32 octets give frames
  of 46–50 octets DA through FCS (14 + payload + 4), all four words, all runts,
  all excluded by the gate. §6.2 (D)'s restructuring into two independent capture
  events with the gating cycle reading the *captured* bit is the repair the old
  three-row table needed, and it names a holder in both branch orders.
- **C-26 — REAFFIRMED**, and written into SPEC-M17 §8 and §9 from the start,
  which is the point of the item.
- **C-27 — REAFFIRMED.** L = 12 named as the gap-invariant constant is the right
  discharge for REQ-611's gap clause. See **C-32**: M17's claim to be immune to
  C-27's class is half right and half wrong.
- **C-28 — REAFFIRMED.** The two halves tile: `SO-arp.md` claims the strobe and
  request half, `SO-ip_eth_tx_64.md` the discard-and-drain half, and §8 item 1's
  clause is stated at the port that has it. The double claim is now impossible.
- **C-29 — REAFFIRMED.** M15 emits body word 0 at C + 1, M09 relays
  combinationally at ΔC = 0, M07 emits at C + 2: one cycle after M15 emits, two
  after M15 accepts. Both readings stated, so a monitor is buildable from either.
- **C-30 — REAFFIRMED**, at M14 as a §13 row and at M17 from the start.

**Count correction, offered as a correction and not a complaint.** WO-0019's
Return log item 2 says "**Six** are §13-recorded post-freeze spec diffs (SPEC-M13
three, SPEC-M14 three, SPEC-M16 one)". Three plus three plus one is seven, and
seven §13 rows exist — I counted them in the three files. **All seven of
C-24 … C-30 are §13-recorded**; the parenthetical is right and the word "six" is
wrong. No diff is owed to any specification; the correction belongs in this log
so the ledger's arithmetic is not carried forward wrong.

**The §11 closures: REAFFIRMED, and there are TWELVE, not eleven.**
`grep -c "CLOSED (WO-0019)"` over `docs/specs/modules/` returns twelve rows:
SPEC-M03 §11.2, SPEC-M05 §11.2, SPEC-M06 §11.3, SPEC-M08 §11.2, SPEC-M10 §11.2,
SPEC-M10 §11.4, SPEC-M13 §11.5, SPEC-M14 §11.4, SPEC-M15 §11.3, SPEC-M16 §11.2,
SPEC-M16 §11.3, SPEC-M16 §11.4. The architect's own table lists all twelve and
counts them as eleven. Each closure is substantively earned and I checked them
individually rather than as a block:

- the two record-placement items close **affirmatively** — the moment named for
  promoting `Arp_packet` to M01 arrived and declined, which is a real disposition
  and not a lapse;
- the two pulse/level items close on a fact batch F established rather than
  assumed: `Udp_header` has a receive discipline and **no transmit instance at
  all**, because M18 builds from a `Udp_tx_request` — I verified there is no
  `Udp_header` port anywhere on the transmit side;
- SPEC-M05 §11.2 closes correctly: `nic_top_ifc.ml` and `eth_mac_10g_ifc.ml` both
  carry `[@rtlprefix "xgmii_rx"]` and `[@rtlprefix "xgmii_tx"]` **without**
  trailing underscores, so M05 and M20 emit identical wire-side names by
  construction and REQ-017's port-list check confirms rather than establishes
  them;
- SPEC-M08 §11.2 closes on M20 §9's equation while **C-3 itself stays open** to
  its own gate — that distinction is exactly right and is the one a reader is
  most likely to collapse;
- SPEC-M03 §11.2 closes with REQ-810's four implementers named in
  `traceability.md`, which I read;
- the two configuration-hop items and SPEC-M16 §11.2's strobe-container item
  close on statements I verified exist at M19 §4.3 and M20 §4.3/§6.1;
- SPEC-M15 §11.3 and SPEC-M16 §11.4 close on REQ-610's and REQ-807's second
  halves, both of which exist, name their own and disclaim the other's — the
  condition I set at WO-0018 answer (iv), met.

**ADR-0010's two answers: both ACCEPTED, and (b) is the better decision of the
two.** (a) `open! Axi64` as the single house form: right answer, and the three
pinned consequences — `open!` not `open`, open only the record modules a
module's ports use, mixing the forms is a bounce — are what makes it enforceable
at review rather than aspirational. Recording (a2) (rename the inner module to
`Stream`) as *rejected on cost with the repair queued behind any future reopening
of SPEC-M01 §4.1* is the right treatment of a known wart. (b) is the one I would
have argued hardest for: a named `S` would be a **second** statement of the module
surface that nothing forces to agree with the `.mli` — a module whose `S` and
`.mli` disagree still compiles — and REQ-903(b)'s mechanical check reads the
`.mli`. Two statements of one fact drift, and this drift would be **invisible to
a script**, which is the property that decides it. The refusal to functorise M03
and M04 over the CRC engine is right for a reason that is mine to confirm:
REQ-305 already requires the engine to agree with a **bit-serial software
reference** over 10 000 randomised frames, so the independent oracle DV needs is
a software model I own, not a second RTL engine — and a hierarchy parameterised
by an unspecified functor argument cannot be checked by
`tools/check_emitted_verilog.sh`'s REQ-018 whitelist, which is mechanical today.
**Batch-B RTL is unblocked on both answers from my side.**

**Still open and unchanged by this batch**: C-2 (now load-bearing at three
modules and stated at each), C-3 (answered in text at SPEC-M20 §9, closing at the
top-level stress bench), C-5, C-7, C-9's REQ-903 half.

---

#### 4. New carry-forwards C-31 … C-36

| # | Item | Must land before |
|---|---|---|
| **C-31** | **ADR-0011's Consequences asserts a SPEC-M04 §9 diff that does not exist** ("it now says ordered-and-unpinned"; Affects lists SPEC-M04 §9), and requirements.md REQ-709's new column cites SPEC-M04 §9 for the same reading. SPEC-M04 §9 says the strobes "pulse **together**". Two committed documents cite a frozen spec for the opposite of what it says. **Repair: the one-row §13 editorial diff at SPEC-M04 (preferred), or a correction to ADR-0011.** | `SO-xgmii_tx_64.md`, and any bench asserting REQ-709. Lands free in the F-1 repair commit |
| **C-32** | **The one-cycle lead of `hdr_valid` over application word 0 is gapless-only, and is stated unconditionally at four sites** (SPEC-M17 §4.2 and §7's handshake rules, SPEC-M19 §4.2/§7, SPEC-M20 §4.2/§7). M17's *header-record latency* (input word 0 → `hdr_valid` = 1 cycle) **is** gap-invariant, correctly; the **lead** is not — an idle cycle between input words 0 and 1 delays application word 0 while `hdr_valid` stays at Ci + 1, so the lead grows by the injected count. §6.1 scopes its cycle formulas to a gapless stimulus, so the correct reading exists; §7's "a bench may assert this figure under idle injection at any depth" is one antecedent away from licensing the wrong assertion. **Consequence at the top level**: SPEC-M20 §9 term 2 ("an `app_rx_hdr_valid` pulse **not** followed by a payload frame") is one-cycle-decidable only on a gapless stimulus; under REQ-016 gaps the decision point is the next `app_rx_hdr_valid` pulse, and no document says so. This is C-27's class one module down, half-anticipated | the M17 idle-injection bench and `SO-udp_ip_rx_64.md`; the top-level conservation monitor (also C-3's closing gate) |
| **C-33** | **SPEC-M19 §9 fact 2's locality claim is false.** "M19 is the first module at which the difference between [frames discarded and strobe pulses] is reachable by a single frame" — it is reachable at **M14 alone**, by SPEC-M14 §8's own two-condition directed datagram, and at M17 alone by SPEC-M17 §8's. What *is* first at M19 is two double-pulsing modules in one scope. The instruction (count frames) is right; the claim tells monitor writers one and two levels down that the trap does not bite there, and requirements.md §0.6 makes the conservation monitor active in **every** bench. SPEC-M14 §9 and SPEC-M17 §9 state the *counting* convention (high cycles per strobe, C-23) but neither states the frames-versus-pulses rule for a conservation equation | the M14 and M17 conservation monitors; `SO-ip_eth_rx_64.md` |
| **C-34** | **SPEC-M18 §6.2's `Body` exits overlap when the declared count ends mid-word.** A word that completes the declared count *and* carries octets beyond it satisfies both the `Drain` condition ("the word that completes the declared count") and the `Excess` condition ("a word beyond it"), and no precedence is stated. **§8 item 4's own stimulus is exactly this case** — declare 100, supply 110: application word 12 carries declared octets 96–99 and excess octets 100–103. Only the `Excess` reading satisfies REQ-710 and §8's own assertions; the `Drain` reading pulses no strobe, drops `payload_tready` to 0 with the application's `tlast` still pending, and returns to `Idle` where the stale word is consumed as the next frame's word 0. §9's pinned strobe cycle ("the first word beyond the declared count") implies the right reading, so this is a wording fix: **`Excess` takes precedence whenever the accepted word carries any octet beyond the declared count; `Drain` applies only when the word's last octet is the declared count's.** Also §8 item 4's "the ten excess **words**" — they are ten excess *octets*, in the tail of word 12 and the whole of word 13 | `SO-udp_ip_tx_64.md`. Lands free in the F-1 repair commit |
| **C-35** | **SPEC-M18 §3's REQ-015 bound contradicts §10's and its own parenthetical**: §3 says "at most **184** words between two `tlast` words on the output stream (1472 + 8 = 1480 octets, **185** words), the `tlast` word included" while §10 says "at most **185** output words at the maximum declared length". 1480/8 = 185 exactly, so 185 is right. REQ-015 makes the maximum "pinned in the owning module's spec", and a protocol monitor built from §3 flags a conformant maximum-length frame | `SO-udp_ip_tx_64.md`. One character; lands free in the F-1 repair commit |
| **C-36** | **`cfg_tx_enable`'s two readers are unstated when composed.** M18 samples it only in `Idle` and M04 only in its own `Idle`, so an enable that drops **after** M18 accepts a request and **before** M04 starts that frame leaves M04 holding `tx_tready` = 0 and the frame stalled across M18/M15/M09/M07 until re-enable. No word is lost and no strobe is owed — the behaviour is benign and arguably desirable — but it is stated at no module, and SPEC-M18 §10's REQ-802/803 hook ("change `cfg_tx_enable` mid-frame and assert the frame in flight completes") is true at M18's isolated ports and **not** at M20's. A top-level bench composing the hook with the enable finds a stall it has no document for | the first top-level transmit bench; `SO-nic_top.md` |

---

#### 5. The countersignature is withheld — what is owed, and the bounded re-review

**No sentence is offered at `aaa55b2`.** What is owed for batch F to flip:

1. **F-1's three clauses (plus the optional fourth) at SPEC-M17** — §1 above
   states them exactly. This is the only item blocking the countersignature.
2. **C-35's one character** at SPEC-M18 §3 (184 → 185) and **C-34's precedence
   clause** at SPEC-M18 §6.2 with §8 item 4's units — free in the same commit,
   and I will check them there rather than carry them to a sign-off.
3. **C-31's one-row §13 diff at SPEC-M04** (or the ADR-0011 correction) — I
   recommend taking it in the same commit; if it goes to its own gate instead,
   say so in the Return log and C-31 stands as a ledger row.
4. A **CI `build` run green at the repair commit**, whose head SHA is that
   commit, so batch F's four §12 evidence rows fill with no witnessing argument
   owed — the standard batches A through E all met.

**The re-review surface, bounded in advance so the architect can price it**
(WO-0015's precedent, which held at WO-0018 and will hold here). At re-review I
will re-derive **only**: SPEC-M17 §6.1's corrected inequality and its scope;
§6.2's `Payload` and `Tail` rows; the new §11 row; §10's REQ-007/REQ-013 hook;
§8's under-declaring datagram if it gains an assertion; and byte-wise, the two
SPEC-M18 corrections and — if present — SPEC-M04's §13 row. I will **not**
re-open M17's L/h/ΔC, its precedence scoping, its strobe cycles or its stress
arithmetic; nor anything in SPEC-M18, SPEC-M19 or SPEC-M20 that this log signs.
If a repair reaches outside that surface I will say so and re-derive what moved,
as I did at C-28.

**The sentence I will write when the repair lands**, pre-worded here so the
orchestrator can plan the transcription and so my standard is fixed before I see
the text:

> "I countersign batch F (SPEC-M17, SPEC-M18, SPEC-M19, SPEC-M20) for
> P1-spec-freeze at `<repair SHA>`." — dv_lead, journal `J-dv_lead-0011`.

On that sentence all twenty Phase-1 specifications are FROZEN and the gate goes
to the sponsor. It is one architect activation away.

**What I did not do.** I did not touch `docs/specs/**`, `docs/adr/**` or
`docs/gates/**`, though every owed diff above is written out to the clause. I
added no `test/**` or `tools/**` machinery: every check in this review was
arithmetic I did by hand or a script that already existed, and a commit carrying
a contest, three signatures and six ledger items is easier to audit without code
in it. `libs/**` was not opened.

### ACCEPTED — orchestrator, 2026-08-02T15:20Z, journal `J-orchestrator-0057`

Committed as `14e8999` (dv_lead, `J-dv_lead-0010`). Verdicts transcribed
(batch-F row WITHHELD; the withheld block; C-31…C-36 on the ledger).
The withholding is endorsed without reservation: F-1's repair in DRAFT
costs one activation; after the flip it is a post-freeze §6 behavioural
diff — the exact cost class ADR-0011 refuses at M04, applied
consistently at M17. WO-0021 issues the owed diff set (three clauses
+1 optional at SPEC-M17; the SPEC-M04 §13 row for C-31; C-34/C-35
landing free) with dv's bounded re-review surface and pre-worded
sentence quoted. One architect activation from 20/20.
