# ADR-0011: an application under-delivery leaves the transmit path holding an unterminated frame, and `clear` is its specified recovery

- **Status**: Accepted (architect decision, in-role under charter §3 and §7,
  forced by writing SPEC-M18's REQ-709 half at WO-0019)
- **Deciders**: architect_docs_lead. **Flagged for dv_lead's batch-F
  countersignature as the single hardest item in the batch** — it is the one
  decision here that makes a requirement's verification column change rather
  than a specification's prose.
- **Work order**: WO-0019 · **Journal**: `J-architect_docs_lead-0008`
- **Affects**: SPEC-M18 §6.1, §6.2, §9, §11.2 (the decision and its statement);
  requirements.md REQ-709's **verification column** and §11's non-requirements
  table (both editorial, both recorded in requirements.md §13); SPEC-M04 §9's
  co-occurrence bullet (editorial: the two strobes are a few cycles apart, not
  simultaneous). **No interface record, no port and no pinned constant moves,
  and no module's normative behaviour changes** — what changes is that a
  consequence nobody had written down is now written down.

## Context

REQ-709 says that when the application delivers **fewer** payload octets than it
declared (REQ-705), "the transmit path SHALL terminate the frame per REQ-206,
emitting an error character followed by a terminate character, and SHALL pulse
both `error_underflow` (REQ-206) and `error_tx_length_mismatch` once". SPEC-M04
§9's co-occurrence bullet, written at batch B before M18 existed, already names
the mechanism: "M18 stops presenting words and M04 underflows".

Writing SPEC-M18 forced the question that neither document asked: **what state is
the transmit path in afterwards?** Trace it. M18 has offered a frame to M15 and
sized it from the declared length (REQ-610), so it never reaches the declared
count and never marks `ip_payload_tlast`. M15 sits in its `Body` state waiting
for a payload `tlast` that will not come (SPEC-M15 §6.2). M09 has granted the
IPv4 port and arbitration is frame-atomic, so the grant does not return
(REQ-406). M07 has nothing to forward. M04 requires a word, does not get one,
pulses `error_underflow`, emits `/E/` then `/T/`, serves the gap and returns to
`Idle` — the wire is correct and REQ-709's two strobes have both pulsed.

Everything above M04 is then **quiescent but not idle**: nothing is presented
anywhere, so no spurious frame reaches the wire, and no word is lost. But M09's
grant is held, so an ARP reply waiting at the other port is never transmitted and
is eventually dropped under REQ-510, and the next application datagram is never
accepted. REQ-709's own verification column then says "check ... that the next
frame transmits correctly", which no conformant design can do from that state.

So the requirement, as written, commissions a test that fails a conformant
design. That is the defect class this programme's countersignature cycles exist
to find, and it is better found by the architect writing the module than by
dv_lead reading it.

## Decision

**The under-delivered frame is abandoned in place, and `clear` is the recovery.**
Precisely:

1. **M18's half is exactly what SPEC-M04 §9 already said.** On the cycle M18
   accepts an application payload word carrying `tlast` before the declared
   payload count has been delivered, it pulses `error_tx_length_mismatch` once,
   emits that word's octets in the ordinary way **without** `ip_payload_tlast`,
   and then presents no further word for that frame — ever. It does not
   fabricate octets, does not pad, and does not terminate the frame short.
2. **M04's remedy runs unchanged** and produces REQ-709's wire encoding: `/E/`,
   `/T/`, no FCS, one `error_underflow` pulse, then the gap (SPEC-M04 §6.2's
   `Abort` row, §9).
3. **The path above M04 is left holding an unterminated frame** — M18 in its
   body state, M15 in `Body`, M09 granted to the IPv4 port — and **`clear` is
   what recovers it**. REQ-009 already gives `clear` exactly this power: "`clear`
   asserted mid-frame truncates the in-flight output frame without a terminating
   word; no `tlast` and no strobe is emitted for it", and every module on the
   chain states it in its own §7 (SPEC-M18 §7, SPEC-M15 §7, SPEC-M09 §7,
   SPEC-M07 §7, SPEC-M04 §7). No new mechanism is invented; an existing one is
   named as the one that applies.
4. **requirements.md REQ-709's verification column names the `clear`**, so the
   test it commissions is one a conformant design passes: declare 100 octets,
   supply 90, check the wire encoding and both strobes, **assert `clear`**, then
   check that the next frame transmits correctly.
5. **requirements.md §11 records the absence of a finer recovery as a decision**,
   not an omission, in the table that exists for exactly that.

The scope of the decision is narrow and worth stating in one line: **it governs
one path, and that path is an application contract violation.** REQ-705 obliges
the application to supply the number of octets it declared. Over-delivery
(REQ-710) is handled cleanly and needs none of this — the frame on the wire is
already complete and correct, M18 discards the excess while continuing to accept
it, and nothing is left holding.

## Alternatives

**(a) Make M04 consume and discard the remainder of an aborted frame**, so the
path drains itself: M18 terminates its frame late, M15 completes, and M04 accepts
the tail without emitting it. This is the answer a real NIC would want, and it is
rejected on three grounds that compound.

1. **It contradicts REQ-207 as written.** "The transmitter ... SHALL NOT drop a
   word it has accepted" is unconditional, and REQ-207's verification column
   asserts that the decoded wire octet sequence equals the accepted-word octet
   sequence exactly once, in order — an assertion this alternative makes false.
   Fixing that is a **normative** requirements diff, not an editorial one, and
   SPEC-M04 §11.2 already records that dv_lead classed the REQ-206/REQ-207
   interaction as *compelled by REQ-207's unconditional wording* rather than
   chosen. Reversing that reading at the freeze gate reopens a closed item.
2. **It is a post-freeze §6 change to a frozen batch-B specification.** SPEC-M04
   is FROZEN at f78766e; its §6.2 `Abort` row and §9 would both move, which under
   SPEC-TEMPLATE rule 7 is a spec diff plus an ADR — this one — landing on a
   module that already has RTL work queued against its frozen text.
3. **It buys recovery from a path the programme never takes without a bench
   deliberately driving it.** The line-rate stress runs (REQ-004, REQ-708,
   REQ-209) never under-deliver, and the Phase-2 application is our own code.
   Paying a requirements diff and a frozen-spec behavioural diff to automate
   recovery from a bug in our own application, at the last gate before freeze, is
   the wrong trade **now** — and this paragraph is what a later phase reads when
   the trade changes. If real hardware ever attaches, (a) is the repair, and it
   is one ADR and two sections away.

**(b) Have M18 terminate the frame short** — relay the application's early
`tlast` as its own `ip_payload_tlast` with `tuser`[0] = 1, let M15 complete the
body and let the frame reach the wire well formed. No wedge, no `clear`, one
strobe. **Rejected, and the argument is already in the programme's own text**:
SPEC-M04 §9 says appending a valid FCS to a truncated frame "would put a
**well-formed short frame** on the wire, which the link partner would accept as a
real frame with a real (wrong) length", which is precisely what this produces —
an Ethernet frame with a valid FCS carrying an IPv4 datagram whose total length
over-declares its contents. The `/E/` before the terminate character is the only
thing that makes the truncation visible to a receiver, and REQ-709 mandates it
for that reason. This alternative also contradicts the split dv_lead's WO-0003
diff D-15 made between REQ-709 and REQ-710 — over-delivery is the case where "a
frame already terminated on the wire cannot take REQ-206's remedy", which says in
so many words that under-delivery *can* and *does*.

**(c) A back-signal from M04 to the chain** — an `aborted` output at M04 that
M07, M09, M15 and M18 each consume to abandon the frame in flight. It is the
complete fix and it is rejected on cost and blast radius: five specifications,
four of them frozen, gain a port at the last gate; M09's frame-atomicity rule
(REQ-406) gains an exception; and the emitted-Verilog port lists of four modules
change, invalidating the compile evidence their freeze records cite. For an
application-error path, at spec-freeze, this is not proportionate.

**(d) Say nothing and let the residual be discovered later.** Rejected on
principle. The residual exists under every alternative that keeps REQ-709's wire
encoding; the only question was whether it is written down before RTL or found
by a bench afterwards. Charter §6 counts untraceable design choices against the
architect, and "the transmit path needs a `clear` after an application
under-delivery" is exactly the kind of fact a phase report should not be the
first place to state.

## Consequences

- **REQ-709's test is writable and passes a conformant design**, which it was not
  before: the `clear` is in the verification column and SPEC-M18 §8's directed
  item drives the same sequence.
- **The two strobes of one event are a few cycles apart, and no bench should
  assert otherwise.** `error_tx_length_mismatch` pulses at M18 on the cycle it
  accepts the short `tlast`; `error_underflow` pulses at M04 on the first cycle
  M04 requires a word the path can no longer supply, which is later by the number
  of words in flight between M18 and M04 and is **not pinned** — it depends on
  how far M15's drain had progressed. SPEC-M04 §9's co-occurrence bullet said
  they "pulse together", which a bench writer may read as same-cycle; it now says
  ordered-and-unpinned. A bench asserts **one pulse of each per under-delivered
  frame** and asserts nothing about their separation.
- **Frame conservation is unaffected.** The datagram is reported twice, by two
  modules, for two different conditions it genuinely has — the length mismatch at
  M18 and the underflow at M04 — which requirements.md §0.6 permits explicitly
  ("if two or more locally detected conditions apply to one frame, each
  applicable condition's strobe pulses once"), and it is not an inherited-abort
  re-report because M04 detects its own condition at its own port.
- **`clear` is a top-level input** (SPEC-M20 §4.2), so the recovery is available
  to the bench and to the platform without any new port anywhere.
- **REQ-810's transmit clause is unaffected and is not this mechanism.** Holding
  `tready` low while transmit is disabled is M18's `cfg_tx_enable` refusal
  (SPEC-M18 §4.3, §6.1), which happens *before* a frame is opened; this ADR
  governs a frame already open. The two never interact: M18 accepts no request
  while disabled, so no frame exists to under-deliver into.
- **The item is on the ledger, not closed by this ADR.** SPEC-M18 §11.2 carries
  it with the reader's assumption stated, and the closing gate is Phase-2
  hardening or the first real-hardware attach — whichever first makes
  alternative (a) worth its price.
