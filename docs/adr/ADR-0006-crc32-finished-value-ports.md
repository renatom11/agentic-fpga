# ADR-0006: `Crc32_eth` ports carry the finished CRC-32 value, not the raw register

- **Status**: Accepted (architect decision, in-role under charter §3 and §7 —
  not an escalation class; recorded because charter §3 makes every non-obvious
  interface choice ADR material)
- **Deciders**: architect_docs_lead, on the record built by WO-0006 (SPEC-M02
  §6.1) and WO-0007 (dv_lead's independent bit-serial verification)
- **Work order**: WO-0008 · **Journal**: `J-architect_docs_lead-0004`
- **Affects**: SPEC-M02 §4.2, §6.1, §10; requirements.md REQ-301, REQ-303,
  REQ-304, REQ-305; every bench and golden model that touches an FCS

## Context

M02 `Crc32_eth` is a combinational CRC-32 update (REQ-302, REQ-306) shared by
the receiver's FCS check (REQ-104) and the transmitter's FCS generation
(REQ-202). Its ports are `crc_in` (32 bits, the running value), `data`,
`octet_count` and `crc_out`. Something has to say **which** 32-bit value those
ports carry, because CRC-32 as REQ-301 parameterises it — initial value
0xFFFFFFFF, input and output reflected, final XOR 0xFFFFFFFF — has two natural
32-bit representations of "the CRC so far":

- the **finished value**: the CRC-32 of the octet string consumed so far, with
  the final XOR already applied. The identity element is 0x00000000, because
  that is `CRC32(empty string)` — the initial value and the final XOR cancel
  over an empty input;
- the **raw register**: the internal shift-register state, which starts at
  0xFFFFFFFF and needs an XOR with 0xFFFFFFFF to become a CRC value. This is
  the usual choice in Verilog FCS blocks, including the prior art the Phase-1
  decomposition is aligned with.

The two differ by a constant XOR, so either can be implemented; the question is
which one every *other* artefact then has to convert.

This programme has already lost a cycle to exactly this class of error. The
WO-0002 requirements text carried 0xC704DD7B as the Ethernet residue — a real,
published constant, but the **non-reflected** register expression of the same
residue (bitrev32(NOT 0x2144DF1C) = 0xC704DD7B). Two constants had to be
recomputed twice each, by dv_lead and by the orchestrator, and the correction
note now sits in requirements.md §4. The defect was not arithmetic; it was two
conventions in one document.

## Decision

**The ports carry finished CRC-32 values.** A caller seeds a frame with
`crc_in` = 0x00000000; at every update boundary `crc_out` is the CRC-32 of the
whole octet string consumed so far; REQ-303's 0xCBF43926 and REQ-304's
0x2144DF1C are observed **directly at `crc_out` with no adjustment at either
end**. SPEC-M02 §6.1 states the convention, gives the raw-register conversion
(`register = port value XOR 0xFFFFFFFF`) for readers coming from prior art, and
guards the seed in three separate places, because 0xFFFFFFFF is REQ-301's own
initial value and is the number a test writer will otherwise reach for.

## Alternatives

**The raw shift-register convention** (seed 0xFFFFFFFF, XOR at every
comparison). Rejected. It matches the prior art a reader may have open, and it
is what an implementer transcribing an LFSR would produce naturally — but it
puts a conversion at every boundary that matters:

| Boundary | Finished-value convention | Raw-register convention |
|---|---|---|
| REQ-303 known-answer test | compare `crc_out` to 0xCBF43926 | compare `crc_out` XOR 0xFFFFFFFF |
| REQ-304 residue check | compare `crc_out` to 0x2144DF1C | compare `crc_out` XOR 0xFFFFFFFF |
| REQ-305 oracle comparison | identity: `crc_out` = `reference(crc_in, octets)` | conversion at both ends of every one of ≥ 10 000 random cases |
| M04's four wire octets (REQ-202) | slice `crc_out` | XOR then slice |
| verilog-ethernet co-simulation adapter (REQ-901) | one conversion, at the adapter | none — but the adapter is the one place a conversion is *expected* and reviewed |

Every row but the last is a place an inverted or reflected value hides in
plain sight, and the programme's own history says that is not hypothetical.
The one row the rejected convention wins is the co-simulation adapter, which is
DV-owned, written once, and already the boundary where representation
differences are looked for.

**A third option — carry the raw register and state the two constants in raw
form** — was not seriously entertained: it would put constants in
requirements.md that no published table lists, so nobody could check them
against an external source, which is precisely what made the original error
survivable.

## Consequences

- REQ-303 and REQ-304 are directly observable at a module port. dv_lead
  verified this by independent bit-serial computation before countersigning
  batch A (WO-0007): the seed 0x00000000, the intermediate 0x9AE0DAAF, both
  constants, and the residue at five frame lengths.
- The REQ-305 oracle relationship is an identity, so the bit-serial reference
  can be compared to the design with no adapter code between them — and an
  adapter is code that can be wrong in the same direction as the design.
- **The risk this creates, and where it is handled**: REQ-301 says the initial
  value is 0xFFFFFFFF, and this ADR says a caller drives 0x00000000. Both are
  correct; only their *pairing* would be wrong. A test writer who takes
  REQ-301's number as the port seed builds a bench that fails a conformant
  M02 on its first vector. SPEC-M02 §4.2's `crc_in` row, §6.1 note 1 and its
  explicit "this is not a contradiction of REQ-301" sentence exist for that
  reader, and they give the reason rather than the rule so that the guard
  survives being excerpted into a work order.
- Reversing this decision after `P1-spec-freeze` is a breaking interface
  change to SPEC-M02 §4 and counts against post-freeze churn (charter §6),
  even though no port width changes — the values on the wires change meaning,
  which is the harder kind of break to detect.
