# ADR-0007: `octet_count` is a 4-bit count with domain 1–8, and 0 stays unconstrained

- **Status**: Accepted (architect decision, in-role under charter §3 and §7)
- **Deciders**: architect_docs_lead, with the second half decided in batch B
  once M03 and M04 could answer it (SPEC-M02 §11.2 deferred it there on
  purpose)
- **Work order**: WO-0008 · **Journal**: `J-architect_docs_lead-0004`
- **Affects**: SPEC-M02 §4.2, §6.1, §6.3; SPEC-M03 §6.1; SPEC-M04 §6.1;
  requirements.md REQ-302, REQ-305; any `formal_dv` proof over M02

## Context

M02 `Crc32_eth` updates a running CRC by **1 to 8** octets in one cycle
(REQ-302). Eight legal values need three bits of information, and the port has
to encode them. Two encodings were available, and once one was chosen a second
question followed immediately: what, if anything, does the encoding say about
an update covering **zero** octets?

## Decision

**Two parts.**

1. **`octet_count` is a 4-bit unsigned count whose permitted values are 1
   through 8.** The value is the number of octets covered, read directly: 8
   means eight octets. The encodings 0 and 9–15 are outside REQ-302's domain
   and SPEC-M02 §6.3 records `crc_out` as unconstrained for them.

2. **`octet_count` = 0 is not given the identity meaning, and there is no
   REQ-307.** M03 and M04 hold the running CRC in a register with an
   **enable**: a cycle that covers no frame octet — an idle cycle, a preamble
   or gap word, an XGMII word whose terminate character sits in lane 0 — is a
   cycle in which the accumulator holds and M02's result is ignored. An
   update-by-zero therefore never reaches these ports, which is exactly the
   question SPEC-M02 §11.2 deferred to the modules that could answer it.

## Alternatives

**A 3-bit count-minus-one** (`octet_count` = n − 1, domain 0–7). Rejected. It
is total — every encoding is legal, so there is no unconstrained region, no
assumption in a `formal_dv` proof, and nothing for §6.3 to say. That is a real
advantage and it is why the option was considered rather than dismissed. It
loses on one thing: it puts an off-by-one at **every** call site and in **every**
bench vector, on a signal whose whole job is to say how many octets are covered.
The two call sites are the two modules that must agree bit for bit about the
FCS (SPEC-M02 §1), and the bench side writes the same value by hand thousands
of times in the REQ-302 and REQ-305 randomised runs. A convention that reads
wrong at a glance and is written by hand at scale is a convention that will be
written wrong.

**Giving 0 the identity meaning** (`crc_out` = `crc_in`) as a new REQ-307.
Rejected, and this is the closer call of the two:

- *For*: it makes the function total, removes the assumption
  1 ≤ `octet_count` ≤ 8 from a formal proof, and costs nothing to implement —
  a zero-octet update through the XOR network is already the identity in most
  formulations.
- *Against, and decisive*: it converts a caller defect into a silent success.
  With 0 unconstrained, a sequencer that accidentally drives 0 on a cycle it
  should have skipped is a defect **detectable in that caller's own bench** —
  the running value is garbage and the frame's FCS check fails visibly. With
  0 defined as the identity, the same accident is indistinguishable from
  correct behaviour at M02's ports, and the error surfaces only if the missing
  update happens to matter. The value of a total function is that no input is
  wrong; the cost is that no input is wrong.
- Secondary: a REQ-307 would need a matrix row, a directed test and a place in
  every sign-off packet's enumeration, all for a stimulus the design never
  produces. requirements.md §0.2's rule is that one REQ states one testable
  fact — this one would be testable and never true in operation.

## Consequences

- SPEC-M02 §6.3 item 1 stands unchanged: DV asserts nothing about
  `octet_count` outside 1–8, and a `formal_dv` proof of REQ-302 or REQ-305
  assumes the domain. This is now a decision with a reason attached rather
  than an omission.
- SPEC-M03 §6.1 and SPEC-M04 §6.1 carry the corresponding obligation on the
  callers: the accumulator register is enabled only on cycles covering at
  least one frame octet, and the specifications say so in the state-machine
  tables rather than leaving it to the implementer to discover from M02's
  domain.
- The 4-bit width leaves seven illegal encodings. That is the price of a count
  that reads as a count, and it is paid in an unconstrained region rather than
  in a checkable error, because M02 detects nothing and raises no strobe
  (SPEC-M02 §9): a strobe for an out-of-domain count would put a field in the
  top-level status record (REQ-804) for a condition requirements.md §12 does
  not name.
- If a later module genuinely needs an update-by-zero — a plausible case is a
  Phase-3 PCS-side adapter with a different word alignment — part 2 reopens as
  a spec diff plus a superseding ADR, and REQ-307 becomes available. Part 1
  does not reopen: it is a port encoding and changing it is a breaking
  interface change.
