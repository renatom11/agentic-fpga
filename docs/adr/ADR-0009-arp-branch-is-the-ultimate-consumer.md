# ADR-0009: the ARP branch is REQ-013's ultimate consumer — learning and replying are gated on the frame's validity mark

- **Status**: Accepted (architect decision, in-role under charter §3 and §7,
  commissioned by WO-0017 deliverable 2 from dv_lead's owed diff **D-2**)
- **Deciders**: architect_docs_lead, on dv_lead's finding and recommendation
  (`J-dv_lead-0008`, WO-0015 Return log §3 and §4/Q2)
- **Work order**: WO-0017 · **Journal**: `J-architect_docs_lead-0007`
- **Affects**: requirements.md REQ-503 (normative, behavioural) and REQ-013
  (the ultimate-consumer clause); SPEC-M13 §2, §6.1, §6.2, §7, §9, §10, §11.3;
  SPEC-M10 §2 and §11.3 (the abort row moves here, and nothing else at M10
  changes). No interface record, no port and no pinned constant of M10 moves.

## Context

`tuser`[0] means, in REQ-013's own words, "this frame was found invalid; **the
ultimate consumer must discard it**". The programme's pattern works as intended
on the UDP path: M03 marks (REQ-104), every stage relays, and REQ-707 carries
the bit to the application, which is the ultimate consumer and discards.

**The ARP branch is the one receive branch with no application.** The mark is
generated at M03, relayed through M06, M08 and M13, ignored by M10 by design —
SPEC-M10 §7 shows `payload_tuser`[0] arriving two or more cycles *after* M10's
pinned report, so acting on it at M10 would make the parse latency a function of
the frame length and fail REQ-005 — and then consumed by nobody. dv_lead raised
this as blocking finding **D-2** at the batch-D countersignature and declined to
close SPEC-M10 §11.3 in the affirmative.

What the un-gated behaviour commits the programme to, stated once because it is
the whole reason this ADR exists: a single corrupt frame whose corruption landed
in the ARP fields writes a **wrong IP → MAC binding** into a cache that holds it
for `entry_lifetime_cycles` — 20 s at the default — during which every datagram
to that IP leaves with a wrong destination MAC and is dropped by the switch,
**with no strobe naming the cause**. That is persistent state committed from a
frame the programme has already declared invalid, and it is the class of defect
that surfaces as a replay divergence three phases later with nobody able to name
its origin.

**A wrong cost estimate is what made this look like a freeze-time trade-off, and
correcting it is half the decision.** SPEC-M10 §11.3 priced the repair as "a new
`Arp_packet` field" — i.e. as a post-freeze *record* addition, i.e. as breaking.
It cannot be one: the bit arrives on the payload `tlast` word, two or more cycles
after the record is emitted, so no field of that record can carry it. M13 already
owns `rx_payload` — it relays that stream into M10 (architecture.md §6.4.1) — so
the bit is already at M13's ports on a wire that exists. The real repair touches
no interface at all.

## Decision

**M13 `Arp` is the ultimate consumer of REQ-013's mark on the ARP branch, and it
discharges the obligation by gating both of its receive-side actions on it.**
Precisely:

1. M13 holds M10's report until the cycle after the **later** of (i) M10's
   `arp_valid` pulse and (ii) that packet's payload `tlast` word on
   `rx_payload`. On that cycle it reads `rx_payload_tuser`[0] of that `tlast`
   word.
2. If the bit is **0**, the REQ-503 learning write is presented and the REQ-502
   reply predicate is evaluated, exactly as before.
3. If the bit is **1**, neither happens: the packet is not learned from and no
   reply is generated.
4. **No strobe pulses at M13 for case 3.** The condition was detected and
   reported by the module that marked the frame — `error_bad_fcs` (REQ-104),
   `error_runt` (REQ-107), `error_bad_frame` (REQ-105), `error_oversize`
   (REQ-108) or `error_start_without_terminate` (REQ-110) — and requirements.md
   §0.6 forbids a module from re-reporting an abort it merely inherited.
5. requirements.md REQ-503 gains the qualifier "**and not marked invalid
   (REQ-013)**" and REQ-013 gains the sentence naming the ultimate consumer per
   branch, so the obligation has a named holder on every receive branch rather
   than on one.

The decision is deliberately about **every** mark and not only about a bad FCS:
a runt, an oversize truncation, a mid-frame error character and a
start-without-terminate all set the same bit and all now keep their ARP packet
out of the cache. That is REQ-013's own semantics applied once rather than five
times.

**Cost, itemised, because the wrong itemisation is what produced the deferral.**
No new port at M10, M11, M12 or M13. No new field of `Arp_packet`. No change to
M10's pinned constant (L = 32, h = 0, ΔC = 4) and no change to M10's §6, §7 or
§9 at all — M10 continues to ignore the bit and continues to report at Cp + 4.
The learning write moves from `arp_valid` + 1 to the gating cycle above, bounded
by REQ-015's 188-word frame, and REQ-502's derived response moves from six cycles
to **seven** against its 64-cycle bound (SPEC-M13 §6.1's table, recomputed
term by term). The five captured `Arp_packet` fields are held for the remainder
of the frame, which REQ-019 explicitly does not count as payload storage
("header fields captured into registers are not payload storage").

## Alternatives

**(a) Keep the behaviour and record it as a programme decision** (dv_lead's
**D-2b**, the minimum repair). SPEC-M10 §11.3 would become a decision citing
REQ-013's first clause, and REQ-013 would gain an exemption sentence for the ARP
branch. Rejected on merit, not on cost — with the cost estimate corrected, the
two repairs cost the same in interface terms and D-2b is *cheaper in text and
more expensive in behaviour*. It writes into the requirements that one receive
branch may commit twenty seconds of persistent state from a frame the programme
has declared invalid, with no observable naming it; and it does so at the one
place in Phase 1 where the consequence is not a dropped frame but a **wrong
answer to a later question**. An exemption that has to be written down in order
to be legitimate is usually the wrong side of the choice.

**(b) Gate at M10 instead**, by holding each record until its frame's `tlast`.
Rejected: it makes M10's parse latency a function of the frame length, which
fails REQ-005's constancy and REQ-611's shape, destroys the one-report-per-opened-
packet cycle §6.1 pins, and re-prices M10's §8 criterion 3 — for a benefit M13
obtains for free two cycles later.

**(c) Carry the bit downstream in a new `Arp_packet` field.** Rejected as
impossible, not merely expensive: the bit arrives after the record is emitted.
This is the estimate SPEC-M10 §11.3 carried and it is corrected in place.

**(d) Give M13 a strobe for a marked ARP packet** (`error_arp_invalid` or
similar). Rejected on three independent grounds: requirements.md §0.6 forbids
re-reporting an inherited abort; §12's twenty-one strobes are a closed
enumeration that REQ-804 and REQ-008 quantify over, so a twenty-second is a
requirements diff and a `Status` record change (SPEC-M01 is FROZEN); and the
event is already reported once, upstream, by the module that detected it. A
second report of one event is what the "SHALL NOT re-report" rule exists to
prevent.

## Consequences

- **REQ-013 now has a named holder on every Phase-1 receive branch**, and a
  branch added later without one is a visible gap in that row rather than a
  silent hole. Batches E and F inherit the question explicitly: M14 and M17
  forward, so the bit passes through them to the application (REQ-707), and no
  further ultimate consumer exists below the application.
- **A bench can assert the gate from the input trace alone.** Drive an ARP
  request whose frame carries `tuser`[0] = 1 on its payload `tlast`; assert no
  cache write, no reply frame, and no ARP-side strobe. The negative half — that
  M13 pulses nothing — is as important as the positive half and is why REQ-503's
  verification column names it.
- **REQ-502's derivation moves by one cycle**, from 6 to 7 against 64. Every
  term is still another specification's pinned constant, so it remains a
  derivation rather than a measurement, and the margin is unchanged in kind.
- **The gating event is constant relative to REQ-502's measurement start.** The
  payload `tlast` word sits a fixed number of cycles after the frame's terminate
  character (three, at a lane-0 terminate) because every stage between has
  constant per-octet latency, so the seven-cycle figure holds at every accepted
  request length and is not a property of the 64-octet stress frame alone.
- **In the composed chain the "later of" rule reduces to `tlast` + 1.** A legal
  minimum-length frame delivers a 46-octet ARP payload in six words, so the
  payload `tlast` (Cp + 5) is always later than `arp_valid` (Cp + 4). The other
  branch of the rule exists for determinacy at an exactly-28-octet ARP payload,
  which arrives only inside a runt — and a runt is marked, so it is excluded by
  this decision anyway.
- **SPEC-M10 is unchanged behaviourally.** Its §2 abort row now names M13 as the
  owner instead of "nobody", and §11.3 closes with the corrected cost estimate
  recorded in place. Its ports, its constant, its state machine and its strobe
  cycle are untouched, which is what made this repair a pre-freeze correction of
  the cheap kind rather than the programme's first behavioural post-freeze diff.
- **What this ADR does not do**: it does not make the ARP branch drop a *frame*.
  Nothing is forwarded on that branch, so there is no frame to drop; frame
  conservation at M10's ports (§0.6) is unaffected, because M10 still reports
  every opened packet exactly once whatever the mark says.
