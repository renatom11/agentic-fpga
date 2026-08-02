# ADR-0008: the transmit-side header handshake — `valid` is held until the first payload word is accepted

- **Status**: Accepted (architect decision, in-role under charter §3 and §7)
- **Deciders**: architect_docs_lead
- **Work order**: WO-0011 · **Journal**: `J-architect_docs_lead-0005`
- **Affects**: SPEC-M07 §6.1, §7; SPEC-M09 §4.1, §6.1, §6.3, §7; SPEC-M06 §11.3;
  SPEC-M11, SPEC-M15 and SPEC-M18 when batches D–F write them; `Eth_header`,
  `Ip_header` and `Udp_header` as used on the transmit path (SPEC-M01 §4.1,
  FROZEN at f78766e)

## Context

M01's three header records — `Eth_header`, `Ip_header`, `Udp_header` — each
carry a `valid` field and **no `ready`**. On the receive path that is settled
and correct: `valid` is a one-cycle pulse (REQ-401, REQ-606, REQ-701) and a
`ready` could not exist there at all, because REQ-003 forbids any receive-path
stream from carrying backpressure and a header record travelling with a
receive-path payload is a receive-path port (requirements.md §0.4).

Batch C put the same records on the **transmit** path for the first time. M07
`Eth_axis_tx` consumes an `Eth_header` and must be able to refuse it — it holds
at most one frame, and M04 downstream of it stalls routinely during the FCS,
the terminate character and the inter-frame gap (SPEC-M04 §7). M09
`Eth_arb_mux` is sharper still: arbitration *is* refusal, and the two things an
arbiter needs are a request signal and a grant signal. With `valid` and no
`ready`, neither module has an acceptance event, and a source has nothing to
wait on.

The question this ADR answers is therefore: **what is a transmit-side header
record's acceptance event, given a record that cannot carry a `ready`?**

## Decision

**A transmit-side frame is offered as its header record and its first payload
word together, and both are held until that word is accepted.** Precisely:

1. A source offers a frame by asserting the header record's `valid` = 1 **and**
   `tvalid` = 1 for the frame's first payload word **on the same cycle**.
2. It holds both, with every header field and the payload word's contents
   stable, until the cycle on which that first payload word is accepted
   (`tvalid` = 1 and `tready` = 1).
3. **The acceptance of the first payload word is the acceptance of the header
   record.** The consumer captures the header on that cycle; the source may
   drop `valid` on the next.
4. A source SHALL NOT offer a header record for a frame with no payload word.
   Phase 1 produces none: every transmit frame carries at least 28 octets — an
   ARP packet (REQ-501) or a 20-octet IPv4 header plus an 8-octet UDP header
   (REQ-610).

The header record therefore needs no `ready`, and M01's records serve both
datapath directions **unchanged** — which matters because they were frozen at
f78766e and a field addition would be a breaking interface change to a frozen
spec (SPEC-TEMPLATE rule 7, charter §6's post-freeze churn count).

The consequence a reader must carry: **`valid` has two disciplines, decided by
the direction of the port it appears on.** A one-cycle pulse on the receive
path, a held level on the transmit path. A monitor written for one and attached
to the other reports a defect that is not there, so each specification states
which discipline binds its own ports (SPEC-M06 §7, SPEC-M07 §7, SPEC-M09 §7).

## Alternatives

**(a) Add a `ready` field to the three header records in SPEC-M01 §4.1.** The
obvious move, and rejected on two independent grounds. First, it puts a
backpressure field on records that travel on receive-path ports, where REQ-003
forbids one — so REQ-003's structural check ("a receive-path port exposes
`Source` with no matching `Dest`") would have to grow an exception for header
records, and an invariant with an exception is not a structural guarantee any
more. Second, it is a breaking change to a spec frozen at f78766e for a problem
that has a non-breaking answer, and post-freeze churn is counted (charter §6).

**(b) A separate transmit-only header record type, `Eth_header_tx`, carrying
`valid` and `ready`.** Rejected. It duplicates four field definitions to add one
bit, and REQ-010's whole argument — one vocabulary rather than nineteen
dialects — applies to header records exactly as it applies to streams. It would
also mean M07 and M06 no longer share a type, so the "M07 is M06 run backwards"
property that makes the pair reviewable would stop being visible in the types.

**(c) Let `valid` be a one-cycle pulse on the transmit path too, with the
consumer required to capture it unconditionally.** Rejected, and this is the one
that looks workable until you write the arbiter. It requires every consumer to
have a free slot at all times — M07 would need a header register that is never
occupied when a pulse arrives, which is only true if it can never be stalled,
which is false (M04 stalls it every frame). At M09 it fails outright: two
sources pulsing simultaneously into an arbiter that can grant one would lose the
other's header, and the loser's payload stream would then arrive with no header
at all. The held level exists precisely so the loser can wait.

**(d) Offer the header one or more cycles before the first payload word, as the
receive side does.** Rejected as an *additional* freedom rather than as a
mechanism: it creates a state in which a frame is granted but has no word to
transmit, which M09 would have to represent and which a bench would have to
drive. Requiring the two to be asserted together (decision 1) removes that state
entirely at no cost to any source, because every transmit-side source builds its
header before its payload — M15 computes the IPv4 checksum from fields it has
before the first payload octet arrives (REQ-610), and M11 assembles an ARP
packet from a cache lookup that has already completed.

## Consequences

- **M01 is untouched.** No record changes, no lift changes, and the batch-B
  freeze evidence (CI run 30729342467 at f78766e) still witnesses the interface
  the transmit path uses.
- **The grant is observable on a wire that already exists.** At M09 a port
  learns it has been granted when its first payload word is accepted — one
  signal, `payload_tready`, already in the record for REQ-207's sake. There is
  no second handshake for a bench to monitor and no way for the two to disagree.
- **Sources carry the obligation.** SPEC-M11, SPEC-M15 and SPEC-M18 must each
  restate decisions 1, 2 and 4 in their own §7 when batches D–F write them.
  SPEC-M07 §11.2 and SPEC-M09 §11.3 track that; if any source cannot meet the
  obligation, the repair is a supersession of this ADR plus spec diffs, never a
  local exception.
- **One case becomes unreachable rather than undefined.** A header offered with
  no payload frame — legal and required on the *receive* path (requirements.md
  §0.7, a 14-octet Ethernet frame) — cannot occur on the transmit path under
  decision 4, so SPEC-M07 §6.3 records it as unreachable and DV asserts nothing
  about it. That asymmetry between the two directions is real, is a consequence
  of §0.7 rather than of this decision, and is stated in both places.
- **The DV cost is one monitor parameter, not two monitors.** A header-record
  monitor takes the discipline (pulse or level) from the port's direction, which
  the bench already knows.
- **A transmit-side header monitor keys on the acceptance event and on nothing
  else** (carry-forward **C-17(d)**, added 2026-08-02 under WO-0014, journal
  `J-architect_docs_lead-0006`). Decision 3 is *permissive*: the source **may**
  drop `valid` on the cycle after acceptance, and may equally hold it, re-assert
  it for the next frame on that same cycle, or leave it high between frames. A
  monitor therefore **SHALL NOT** assert that `valid` falls after acceptance,
  **SHALL NOT** assert that it is low between frames, **SHALL NOT** treat a
  `valid` edge as a frame boundary, and **SHALL NOT** read the header fields on
  any cycle outside the offer window (from the cycle `valid` is asserted to the
  cycle the first payload word is accepted, inclusive). The one event a monitor
  keys on is the acceptance of the frame's first payload word — `tvalid` = 1 and
  `tready` = 1 — which is decision 3's own definition of the header's
  acceptance. What a monitor **may** assert is the source's side of decisions 1
  and 2: that `valid` and the first payload word's `tvalid` rose together, and
  that every header field and that word's contents were stable from then until
  acceptance. This bullet is a rule about tests, not a change to the decision;
  no conformant source or consumer is affected.

  **Precedence, when a source specifies more than this ADR requires**
  (carry-forward **C-22**, dv_lead's finding against this bullet's own wording,
  added 2026-08-02 under WO-0017, journal `J-architect_docs_lead-0007`). The
  prohibitions above bind a monitor built **from this ADR alone** — that is,
  attached to a port whose source this ADR is the only statement about. Where the
  source's own specification commits to a **stronger** discipline, that
  specification's cycle table governs a monitor attached to *that* source, and
  the monitor may assert what the table states. SPEC-M11 §6.1 is the first
  instance and the reason this clause exists: it says "M11 may drop `hdr_valid`
  on the next cycle **and does**", and SPEC-M11 §6.2's `Body` row makes it
  normative, so a monitor attached to M11 **may** assert the fall that a monitor
  built from this bullet alone SHALL NOT assert. The two are not in conflict once
  the order is stated: this ADR fixes the floor every transmit-side source meets,
  and a source may stand above its own floor and be tested there. What no
  specification may do is assert the *converse* — that a source which has not
  committed to dropping `valid` does so — which is the failure this bullet was
  written to prevent and which the clause does not reopen.
