# ADR-0012: the abort bit M14 cannot copy — a conditional copy at IPv4, and the residual it leaves at the application

- **Status**: Accepted (architect decision, in-role under charter §3 and §7,
  forced by dv_lead's ledger item **C-37** at WO-0022)
- **Deciders**: architect_docs_lead. **The programme's first post-freeze
  *behavioural* spec diff**: SPEC-M14 is FROZEN at `3f6accc` under
  `J-dv_lead-0009`, and this ADR is what SPEC-TEMPLATE rule 7 and PROTOCOL §7
  require before its §6 may move.
- **Work order**: WO-0023 · **Journal**: `J-architect_docs_lead-0010`
- **Affects**: SPEC-M14 §6.1, §6.2, §8, §10 and new §11.5 (the decision and its
  statement), with §2, §3 and §4.2 swept to match — all recorded in SPEC-M14
  §13; SPEC-M17 §11.4 (its "here and nowhere else" enumeration is false and is
  corrected, recorded in SPEC-M17 §13). **No interface record, no port, no width
  and no pinned constant moves** — L = 12, h = 20, ΔC = 4, the 3-cycle parse
  latency and all seven strobe cycles are untouched, so §12's compile evidence
  still witnesses this revision and `tools/check_records_vs_appendix.sh`
  re-passes. **requirements.md is not diffed by this ADR** (see Consequences).

## Context

REQ-007 is the programme's abort-propagation invariant: "When a frame is found
invalid after forwarding of that frame has begun, its final word SHALL be marked
`tuser`[0] = 1, and **every downstream module that emits an output frame for it
SHALL mark the corresponding final word of its own output stream**
`tuser`[0] = 1." On the UDP receive branch the chain is REQ-104 (M03 marks a bad
FCS) → REQ-007 (every stage relays the mark) → REQ-707 (the application receives
it and discards on it).

At WO-0020 dv_lead found that M17 cannot always obey it: where the UDP length
under-declares what IPv4 delivered by a whole datapath word, M17's application
`tlast` word leaves before the input `tlast` word carrying the bit has been
presented, so a registered output has nothing to copy. That was **F-1**; it was
repaired at WO-0021 by making the copy conditional and emitting a derived 0 on
the class, and SPEC-M17 §11.4 wrote out, priced and carried a REQ-007 scoping
clause rather than diffing a frozen requirement at the gate.

§11.4 justified confining the exception to M17 in a deliberately **falsifiable**
form: "M17 is the only module on the chain whose output frame's extent is fixed
by a count declared *inside the data* … At M03, M06, M08, M10, M14, M16 and M19
the output frame ends on or after the input frame does, so the propagation
obligation is satisfiable by construction."

**dv_lead falsified it at M14** (WO-0022 Return log §3, ledger **C-37**). M14's
output extent is fixed by the **IPv4 total length** — a count declared inside the
data — and its `Tail` state exists for exactly one purpose, consuming the
Ethernet padding that count exposes. From SPEC-M14's own cycle formulas, with N
the octets of the Ethernet payload (padding included, REQ-408) and N′ the total
length, K = ⌈N/8⌉ input words and M = ⌈(N′ − 20)/8⌉ payload words, the input
`tlast` is presented on Ci + K − 1 and the payload `tlast` word leaves on
Ci + M + 3, so the separation is

  ⌈(N′ − 20)/8⌉ − ⌈N/8⌉ + **4** cycles,

and the bit is available to a registered output only where that is positive.
**On a 64-octet minimum-length Ethernet frame — N = 46, the commonest frame on
the wire — the threshold is N′ ≥ 37, so every IPv4 total length from 21 to 36 is
in the unavailable class**, the smallest UDP datagram the programme admits (UDP
length 9, total length 29) among them. The worst case is 183 cycles. SPEC-M14
§6.1 argued the opposite from an inequality that ran backwards — "Since N′ ≤ N,
M + 3 ≥ ⌈(N − 20)/8⌉ + 3 ≥ K" — character for character F-1's error, and its
worked example reproduced only because that example carries no padding at all.

Two things make this worse than F-1 was, and both are dv_lead's:

1. **A committed hook asserted the unsatisfiable reading.** SPEC-M14 §10's
   REQ-007/REQ-013 row commissioned "assert the payload frame is delivered
   intact with the bit set on its last word", unscoped, and §8's directed set is
   "each inside a 64-octet Ethernet frame" including "total lengths 20 through 28
   inclusive" — every one of them inside the defective band. A tb_writer
   following that hook writes an assertion **no conformant design can pass**.
2. **The system consequence is reachable by ordinary traffic.** M17's class needs
   a UDP length field that under-declares — in the aborted case, a corrupted one.
   M14's needs only Ethernet padding, which every frame shorter than 60 octets
   carries by definition.

The question this ADR answers is therefore not *whether* SPEC-M14 §6.1 is wrong.
It is what M14 shall emit on the class it cannot mark, and whether the resulting
hole at the application is carried or repaired.

## Decision

**1. The copy at M14 becomes conditional, and the condition is a cycle deficit
the specification names.** Writing **D = ⌈N/8⌉ − ⌈(N′ − 20)/8⌉ − 3 = K − M − 3**,
the separation is exactly 1 − D and M14 copies the input `tlast` word's
`tuser`[0] onto the payload `tlast` word **iff D ≤ 0**. This is F-1's resolution
transposed to M14, and the rule is deliberately worded so that it is the *same*
rule at both modules: at M17, D ≤ 0 collapses to D = 0 because M17's D cannot be
negative.

**2. On D ≥ 1 the payload `tlast` word carries a derived 0.** It is neither a
copy nor a guess: 0 is the value the bit *has* at the instant that word is
emitted — no abort has been observed for this datagram so far — and it is the
only value M14 can derive from what it has seen.

**3. M14's D is *not* M17's D, and the specification says so in terms.** M17
strips eight octets, a whole datapath word, so its cycle deficit and its
word-count deficit ⌈N/8⌉ − ⌈N′/8⌉ coincide. M14 strips twenty, which is not, and
the two differ by one at N′ mod 8 ∈ {0, 5, 6, 7}. The consequence is stated
where a bench writer will trip over it: **M14's `Tail` state is a proper superset
of the derived-0 class**, where M17's is exactly equal to it. SPEC-M14 §8 drives
the adjacent pair — IPv4 total lengths 36 and 37 inside a 64-octet frame, which
agree on padding, on `Tail` and on the word deficit and disagree on D — so a
design keyed on any of the three wrong quantities fails one of them.

**4. §10's hook is split and the excluded class gets a positive assertion.** The
hook that commissioned an unpassable assertion now commissions two: the bit set
on a D ≤ 0 datagram, and the bit **0** on a D ≥ 1 datagram, each driven twice
with opposite input bits. An exclusion that is asserted is a scoped requirement;
an exclusion that is silent is an untested hole.

**5. REQ-007's scoping clause is now OWED at two modules and is still carried,
not taken here.** SPEC-M17 §11.4 wrote the clause out, priced it and gated it at
`SO-udp_ip_rx_64.md`; SPEC-M14 §11.5 is its **second customer** and adds
`SO-ip_eth_rx_64.md` as a second gate on the same instrument. The corrected
generalisation is recorded in both: the exception is exactly the modules whose
output frame's extent is fixed by an in-data count — **M14 and M17, and those two
only**. M10 is safe for a reason §11.4 did not give and which holds
independently (SPEC-M10 §3: M10 emits no stream, so there is no `tlast` word to
set); M03, M06, M08, M16 and M19 have no in-data count.

**6. The residual — a bad-FCS minimum-length frame reaching the application
unmarked — is carried, with the repair that would close it named and its
escalation class stated.** The reasoning is in Consequences below rather than
compressed into this list, because it is the part of this decision a later phase
will want to re-open.

## Alternatives

**(a) Hold M14's payload `tlast` word until the input `tlast` has been
presented.** The mark is then always available and REQ-007 needs no scope.
**Rejected.** It makes the latency length-dependent, which kills REQ-005's
per-octet constant (L = 12 at every length and content), REQ-019's pinned
ΔC = 4 and §1.1's allocation, and the pinned figures appear in three documents.
The delay is not small: at N = 1500 against N′ = 21 the last word would be held
183 cycles. This is the trade SPEC-M17 §11.4 already rejects at M17, and at M14
it is worse, because the class is entered by ordinary padding rather than by a
malformed length.

**(b) A combinational `payload_tuser` → `ip_payload_tuser` path**, so the bit
can be forwarded on the cycle it arrives. **Rejected.** It rescues **only
D = 1** and never D ≥ 2, and at M14 D ≥ 2 is the *common* member of the class —
a 64-octet frame carrying total length 28 is D = 2. It also introduces exactly
the combinational input-to-output shape §7 refuses for `ip_payload_tdata`, for
which it gives an independent reason.

**(c) Store and forward the datagram** until its input `tlast` is seen, then emit
the payload frame with the bit correct. **Rejected.** It is REQ-005's explicit
prohibition ("no payload word is withheld to the end of its datagram"), it makes
ΔC a function of length, and it puts up to 188 words of buffer in a receive path
whose whole design premise is cut-through with zero backpressure (REQ-003).

**(d) Mark `tuser`[0] = 1 on the class instead of 0** — fail safe, let the
application discard whatever might have been aborted. **Rejected, and this is
the alternative that is far worse at M14 than at M17.** The class is every padded
datagram short enough to be in it, so this would abort the *ordinary* small
frame: a conformant, valid, correctly received 64-octet frame would reach the
application marked invalid. REQ-013 makes `tuser`[0] mean "this frame was found
invalid"; asserting it on frames that were not is a false statement in the
programme's own vocabulary, and it would make REQ-707's discard useless by making
it fire constantly.

**(e) Add a strobe at M14** — `error_abort_not_propagated`, pulsed when an
inherited abort arrives after the payload frame has been closed — so the loss is
reported even though it cannot be attributed to a frame on the stream.
**Rejected now, named as the repair if the residual's price ever changes.** It is
the only alternative that recovers information rather than trading latency for
it, and its cost is structural: a new output port on M14 (a §4.1 change, hence
**breaking**, invalidating §12's compile evidence), a twenty-second name in
requirements.md §12's normative appendix, a new field in SPEC-M01's `Status`
record and its `ifc_check` lift, relay rows at M16, M19 and M20, a row in
`test/monitors/strobes.ml`, and a new REQ to own it — which under charter §7 is
an **E2** scope change and is not the architect's to freeze in-role. Against
that: it still would not let the application discard the frame, because the
application's only per-frame mechanism is REQ-707's bit. It buys attribution for
an operator, not correctness for a consumer.

**(f) Take the REQ-007 scoping clause in this commit**, so no frozen requirement
stands while two specifications state exceptions to it. **Rejected on the same
test §11.4 uses, applied consistently.** requirements.md is FROZEN, so that diff
is a post-freeze normative change to a requirement **today and at any later
date** — its price does not rise. Taking it here would additionally move
`traceability.md`'s REQ-007 row and the REQ-007 hook of nine implementers, eight
of them frozen and each owing its own §13 row, inside the commit that carries the
programme's first post-freeze behavioural repair — a large surface bought for no
saving. It is written out and priced in two §11 rows with two named gates, which
is the difference between deferring an item and losing it.

## Consequences

- **SPEC-M14 §10's hook is now passable.** The single most concrete effect of
  this ADR is that a tb_writer working from SPEC-M14 can no longer be
  commissioned to write an assertion no conformant design passes. §8's directed
  total lengths 20 … 28, which are all inside the band, now carry an explicit
  note that they assert nothing about `tuser`[0], and the pair that does assert
  it is stated with both outcomes.

- **REQ-605's own verification column is unaffected and no requirements diff is
  owed for it.** requirements.md REQ-605 commissions "a 64-octet frame carrying a
  datagram of **total length 28**" — D = 2, squarely inside the band — but it
  asserts only the octet counts and the padding removal, and says nothing about
  `tuser`[0]. It was checked rather than assumed.

- **The residual, stated plainly: on this class a bad-FCS frame reaches the
  application with `tuser`[0] = 0 and cannot be discarded on the bit.** For a
  padded frame REQ-104 → REQ-007 → REQ-707 is broken end to end. This is carried
  rather than repaired, and the four grounds are:

  1. **The event is still reported where it was detected.** `error_bad_fcs`
     (REQ-104, M03) pulses and reaches the top-level `Status` record (REQ-804),
     so nothing is silent at the NIC. What is lost is the **attribution of the
     loss to one frame** at the application port — a smaller thing than a silent
     discard, and requirements.md §0.6's prohibition is on the latter.
  2. **The class is entered only by a frame that is already invalid.** No valid
     frame's data is corrupted and no valid frame is dropped; the failure is a
     failure to *warn*. Alternative (d) would have converted it into a failure to
     deliver, which is strictly worse.
  3. **It does not compound down the chain.** M14's consumer is M17, which since
     the F-1 repair re-derives its own D and takes the inherited bit as data
     rather than relying on its timing. A derived 0 from M14 is inert at M17: it
     is copied where M17's own D = 0 and replaced by M17's own derived 0
     otherwise. The composite statement, which neither specification could make
     alone and which §11.5 and §11.4 now let a reader assemble, is that **the
     application sees the mark iff both M14 and M17 can carry it** — that is, iff
     the datagram is fully delivered at both stages to within their windows.
  4. **Nothing is bought by blocking on it.** SPEC-M14 is already frozen and
     requirements.md is already frozen, so every instrument that would close the
     residual — the scoping clause of (f), the strobe of (e) — costs exactly what
     it costs today at `SO-ip_eth_rx_64.md`.

  **What would change the judgement**, stated so a later phase does not have to
  re-derive it: a Phase-2 feed handler that treats an unmarked datagram as
  authoritative market data, or a real link partner whose bad-FCS rate is not
  negligible. In Phase 1 the application is our own replay bench and every
  injected bad FCS is injected deliberately by a test that already knows which
  frame it corrupted. If either changes, (e) is the repair, and it is one E2 and
  one interface diff away.

- **SPEC-M17 §11.4's generalisation was false and is corrected rather than
  deleted.** It is corrected in the same shape it was written — checkable module
  by module — because that shape is what let dv_lead falsify it. The lesson is
  recorded here rather than left implicit: **a generalisation written so it can
  be checked is worth more than one written so it cannot**, and this ADR exists
  because §11.4 invited the check that produced C-37.

- **dv_lead's escape is dv_lead's to record and the auditor's to own.** SPEC-M14
  was countersigned at WO-0018 with this text in front of both of us; dv_lead has
  journalled the root cause in `J-dv_lead-0011` and PROTOCOL §10 puts the
  DV-escape ledger in `docs/reports/audit/`. Nothing in this ADR is a finding
  against dv_lead — the architect wrote the false inequality, at two modules.

- **Post-freeze churn**: this is one behavioural row at one frozen module, with
  no interface change, and it is countable as such (charter §6). SPEC-M14 §13's
  preamble now separates the breaking column from the behavioural class so the
  tally is not read off the wrong one.
