# ADR-0013: a declared IPv4 total length below 20 — making the field's domain total at M14

- **Status**: Accepted (architect decision, in-role under charter §3 and §7,
  forced by dv_lead's attack-plan row **M14-K7** at WO-0027)
- **Deciders**: architect_docs_lead. The programme's **second** post-freeze
  *behavioural* spec diff: SPEC-M14 is FROZEN at `3f6accc` under
  `J-dv_lead-0009` and revised at `8641455` under `J-dv_lead-0012`, so
  SPEC-TEMPLATE rule 7 and PROTOCOL §7 require this record before its §6 may
  move again.
- **Work order**: WO-0029 · **Journal**: `J-architect_docs_lead-0011`
- **Affects**: SPEC-M14 §6.1 (the false justification, the derivation and a
  partition table over the whole field domain), §6.2's `Header` row and
  `Payload` entry condition, §9's first row, §4.2's strobe meaning, §2's
  in-scope bullet, §8's rejection-class set and §10's REQ-601 hook — all
  recorded in SPEC-M14 §13. **No interface record, no port, no width, no strobe
  name and no pinned constant moves** (L = 12, h = 20, ΔC = 4, the 3-cycle parse
  latency and all seven strobe cycles are untouched), so §12's compile evidence
  still witnesses this revision and `tools/check_records_vs_appendix.sh`
  re-passes. **requirements.md is not diffed by this ADR** (see Consequences).

## Context

SPEC-M14 §6.1's header field table carried, in the total-length row's
*Checked against* cell, the clause "≥ 20 by construction of REQ-601's IHL
check". dv_lead read the cell while writing `test/attack_plans/AP-ip_eth_rx_64.md`
and found it false. The two are independent fields of the same header:

- **IHL** is octet 0 bits 3:0. REQ-601 requires it to be exactly 5, which fixes
  the **header** length at 20 octets.
- **Total length** is octets 2–3. It is sixteen bits, chosen by the sender,
  and nothing in the header constrains it to be at least as large as the header
  it accompanies. RFC 791 expects total length ≥ IHL × 4; it is not a
  representable constraint, it is a well-formedness condition on the sender.

So a datagram with version 4, IHL 5, a **correct** header checksum (computed by
the sender over whatever header it chooses), protocol 17, an accepted
destination, more-fragments clear, fragment offset 0 and a declared total length
of 0, 5 or 19 passed **all six** of SPEC-M14 §9's header conditions and reached
§6.2's `Header` row. That row branched on *declared payload empty* (total length
20) versus *non-empty* — and this datagram is neither: its declared payload is
−15 octets. Downstream of that branch, M = ⌈(N′ − 20)/8⌉ is negative and §6.1's
cycle deficit D = K − M − 3 is undefined, so the emitting arithmetic has no
value for it either.

The class is **reachable and adversary-controlled**. It arrives inside an
ordinary 64-octet Ethernet frame with room to spare, it requires no cooperation
from any other stage, and every field but one is exactly what a valid datagram
carries. It is C-26's family — a band the branch conditions do not cover — and
like C-26 it was found by **writing the attack plan rather than by a bench going
red**, which is the outcome attack plans exist for.

**What requirements.md decides, one document up, and what it leaves open.**
REQ-605 says the receiver "SHALL deliver exactly (total length − 20) payload
octets", which is unsatisfiable on this class — there is no such count — so the
datagram cannot be *delivered* under the requirement that governs delivery.
REQ-008 and §0.6 then forbid dropping it silently: every discard has a strobe.
So requirements.md forces the class into "discarded, with one of the seven
strobe names requirements.md §12 fixes for this module", and the only open
question is **which name**. That is the question this ADR answers.

## Decision

1. **A datagram whose declared total length is below 20 is discarded as a
   malformed header, with a single `error_ip_bad_header` pulse.** No
   `ip_hdr_valid`, no payload word, nothing emitted for it — the same stream
   effect the other five header rejections have.
2. **The condition joins REQ-601's class at M14** and is stated in §9's first
   row, in §4.2's meaning for the strobe and in §2's in-scope bullet. REQ-601's
   own text in requirements.md is **not** diffed: it states a sufficient
   condition for the strobe ("version is not 4 or header length is not 5 words
   … SHALL be discarded with a single `error_ip_bad_header` pulse") and not an
   exhaustive one, and §12's strobe appendix fixes the strobe's *name*, not its
   condition set.
3. **It is decided on input word 0**, with version, IHL and REQ-612's upper
   bound: octets 2–3 lie in that word. It is **reported on cycle Ci + 3** with
   every other header condition, under §9's existing pinned cycle. No new
   strobe, no new port, no new REQ, no new state and no change to any pinned
   number.
4. **§9's independent-evaluation rule applies unchanged**: a datagram that is
   both short-declared and, say, addressed elsewhere pulses
   `error_ip_bad_header` **and** `error_ip_not_for_us` on Ci + 3. There is no
   precedence order, for the reason §9 already gives.
5. **The total-length field's whole domain is now partitioned**, and SPEC-M14
   §6.1 carries the partition as a table: 0 … 19 rejected here, 20 accepted with
   no payload frame (§0.7), 21 … 1500 accepted with a payload frame,
   1501 … 65 535 rejected by REQ-612. Every later arithmetic statement in §6.1 —
   M, D, the separation formula, the under-fill threshold — is **scoped to the
   accepted domain N′ ≥ 20 and is well defined there because of this
   partition**, and §6.1 says so, because the dependence was implicit while the
   false sentence stood.
6. **§6.2's `Payload` entry condition is pinned at N′ ≥ 21.** "Declared payload
   non-empty" is no longer doing work a reader has to guess at.

## Alternatives

**(a) Accept the datagram and treat it as declared-empty** — change §6.2's
branch to "total length ≤ 20", emit `ip_hdr_valid` and no payload frame.
Cheapest edit of all: one comparison. Rejected on three grounds. It **accepts** a
datagram no sender can have produced honestly, so the NIC's own accepted-datagram
count includes it and REQ-606's record carries `ip_hdr_total_length` = 5 to M17
and thence to a Phase-2 consumer that has no rule for it. It **normalises an
adversary-controlled field into a legal value**, which is the one operation a
header validator exists to refuse. And it converts a report into a silence:
nothing anywhere would say the datagram was malformed, which is not a REQ-008
violation (nothing is discarded) but is the same loss of attribution ADR-0012
spends its Consequences arguing about.

**(b) Treat it as truncated — `error_ip_truncated`.** Rejected: the frame does
not end early. It delivers *more* than the datagram declares, which is the
opposite condition, and REQ-605's strobe means "the frame ended before total
length was satisfied". It would also move the report off Ci + 3 onto the input
`tlast` + 1 cycle for a condition decidable at input word 0, which §9 pins
precisely to keep every header rejection on one cycle.

**(c) Treat it as oversize — `error_ip_oversize`.** Rejected without argument
beyond naming it: REQ-612 is a bound above and the strobe says so.

**(d) A new strobe and a new REQ** — `error_ip_bad_length`, a twenty-second
name in requirements.md §12, an eighth output port at M14, a `Status` field, the
relay rows at M16/M19/M20 and a traceability row. Rejected, and it is the
alternative worth pricing rather than dismissing: it is the *most* precise
report, and precision at the port is what §9's seven-names-for-seven-conditions
design already buys at this module. But it is an **E2** escalation (a new
requirement), it moves five frozen documents, and it buys a distinction —
"malformed header of kind A versus kind B" — that no Phase-1 consumer acts on,
because every one of the seven leads to the same stream effect: nothing emitted.
The distinction a consumer *can* act on, "this datagram's header was malformed",
is already carried by `error_ip_bad_header`.

**(e) Diff REQ-601 in requirements.md to name the third condition.** Rejected
for now, and the reasoning is §11.4's own test applied again: requirements.md is
FROZEN, so the diff costs the same today and at `SO-ip_eth_rx_64.md`, and
nothing is bought by taking it early. REQ-601's text is not *falsified* by this
decision the way §6.1's sentence was — it remains true, it is simply not the
whole of what the strobe reports at M14, which is the ordinary relationship
between a requirement and a specification that implements it. If dv_lead judges
at re-countersignature that a strobe may not report a condition its requirement
does not name, the diff is one row plus this module's §10 hook and I will take
it; the ledger row is the place to record that, not this ADR.

**(f) Leave it unconstrained in §6.3.** Rejected outright, and it is worth
saying why since §6.3 is where three other M14 corners live. Those corners are
either unobservable (item 1, item 3), unproducible by the module's own producer
(item 5, item 7) or deliberately flaky (item 6). This class is none of those: it
is reachable by an adversary across the wire, it is observable at three ports,
and two conformant implementations would disagree about it in a way a
differential co-simulation would report as a defect in whichever side was
written second.

## Consequences

- **A conformant design changes.** Anything built to one of the three readings
  the frozen text admitted now discards. **No RTL exists for M14** — WO-0024
  delivered M03, M04 and M05 only — so the change is priced against a
  specification and an attack plan, not against a build. That is the whole of
  the churn cost and it is why this row was worth taking now rather than at
  `P1-module-ready`.
- **`AP-ip_eth_rx_64.md` row M14-K7 converts from RULING to ASSERT**, with the
  stimulus dv_lead already wrote (total lengths 0, 5 and 19) and the observable
  this ADR fixes: one `error_ip_bad_header` at Ci + 3, no `ip_hdr_valid`, no
  payload word. SPEC-M14 §8 carries the same three lengths in its rejection-class
  set and §10's REQ-601 hook names them, so the row is commissioned from the
  specification and not only from the plan. The kill is precise: it kills a
  design that compares total length only against 1500, and a design that folds
  the class into the declared-empty branch.
- **The `Header` row's branch conditions are now exhaustive over the field**,
  which is what C-26's repair achieved for the *delivered*-octet axis. The two
  repairs together mean every (declared, delivered) pair at M14 has exactly one
  branch: C-26 covers "the frame ended before the declaration was met", this ADR
  covers "the declaration is not a length at all".
- **Nothing propagates downstream.** M08 never reads the field; M17 sees no
  datagram for this class, because nothing is emitted; the strobe reaches the
  top-level `Status` record through the relay rows that already carry
  `error_ip_bad_header`. No other specification moves.
- **What would change this judgement.** A Phase-2 consumer that needed to
  distinguish a short-declared datagram from a bad-version one — for instance a
  feed-handler health counter that alarmed on one and not the other — would make
  alternative (d) worth its E2 price. Nothing in Phase 1 does.
- **The escape's ownership.** The false sentence is mine (`J-architect_docs_lead-0007`,
  batch E), it survived dv_lead's batch-E countersignature and my own C-37
  revision of the same section, and it was found by dv_lead writing a directed
  attack plan against frozen text. That is the second finding of that shape in
  three activations, both at §6.1 of this module, and both were justifications
  attached to a number rather than the numbers themselves — which is where I now
  expect the third to be.
