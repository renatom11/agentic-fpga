# ADR-0014: an enable gates admission, not the wire — `cfg_rx_enable` = 0 with a frame in flight

- **Status**: Accepted (architect decision, in-role under charter §3 and §7;
  raised as a reading by rtl_lead at WO-0024 and as a RULING row by dv_lead at
  WO-0027)
- **Deciders**: architect_docs_lead. It resolves a conflict between **two frozen
  requirements** (REQ-810 and REQ-803) and therefore carries a requirements.md
  diff as well as a SPEC-M03 diff; SPEC-M03 is FROZEN at `f78766e` under
  `J-dv_lead-0005`, so SPEC-TEMPLATE rule 7 and PROTOCOL §7 require this record
  before its §4.3, §6.1 and §6.2 may move.
- **Work order**: WO-0029 · **Journal**: `J-architect_docs_lead-0011`
- **Affects**: SPEC-M03 §4.3, §6.1, §6.2 (`Frame`, `Preamble` and `Discard`
  rows), §9's closure list and §10's REQ-110 and REQ-802/REQ-810 hooks, recorded
  in SPEC-M03 §13; requirements.md **REQ-810**, recorded in its §13. **No
  interface record, no port, no width, no strobe name and no pinned constant
  moves.** The transmit-side instance of the same question is ledger **C-36**
  and is deliberately *not* decided here (see Consequences).

## Context

`cfg_rx_enable` is the receive half of REQ-810. SPEC-M03 §4.3 described it in
two sentences that point in opposite directions on one reachable stimulus:

> "when `cfg_rx_enable` = 0, M03 accepts no frame — it **treats every start
> character as absent**, emits no output word, and pulses no strobe (REQ-810).
> It is sampled at the start character: a frame whose start character is
> accepted at least one cycle after the input changes is governed by the new
> value, and **a frame already in flight completes under the old one**
> (REQ-803)."

The stimulus that separates them, raised by rtl_lead as a returned question
(WO-0024 §6 item 4, flagged as "a reading, not asserted as obvious") and written
out by dv_lead as row **M03-N4** of `AP-xgmii_rx_64.md`: a frame is open, the
enable goes to 0 at least one cycle before a start character, and that start
character arrives while the frame is still open — REQ-110's condition.

- **Reading (i)** — the enable gates only the beginning of a frame. The `/S/`
  still closes the open frame: `error_start_without_terminate` pulses,
  `tuser`[0] = 1 on the aborted frame's `tlast` word where one exists, and the
  new frame does not begin.
- **Reading (ii)** — §4.3's first sentence read literally. The start character
  is absent for every purpose, so it neither begins nor aborts anything and the
  open frame runs on through that word.

They differ in the in-flight frame's delivered octet count, in one strobe and in
one abort bit — three observables — so a bench commissioned under either would
fail a design written to the other. The same conflict exists one document up:
REQ-810's "it emits no output word on any receive-path stream … and asserts no
strobe" against REQ-803's "a configuration change … never [applies] to a frame
already in flight on that path".

## Decision

**An enable gates the *admission* of a frame. It does not blind the module to
the wire, and it does not reach a frame already admitted.**

1. While `cfg_rx_enable` = 0, **no start character is accepted**: no frame
   begins, no output word is emitted for a frame that would have begun, and no
   strobe pulses for one. That is REQ-810, and it is what "treats every start
   character as absent" means — absent *as the beginning of a frame*.
2. M03 continues to **decode** the lane pair while the enable is 0. It must:
   REQ-803 makes a change take effect at the next start character, so a module
   that stopped looking could not tell when the next frame begins.
3. A frame **already in flight** is governed by the value in force when its own
   start character was accepted, and completes under **every** rule that ends it
   — its terminate character (REQ-106), an error character (REQ-105), REQ-108's
   truncation, and a **new start character (REQ-110)**.
4. Therefore a start character arriving while the enable is 0, with a frame
   open, **aborts that frame exactly as REQ-110 says** — truncated at the octet
   before it, `tuser`[0] = 1 on its `tlast` word where one exists, one
   `error_start_without_terminate` — and the **new frame does not begin**.
   That strobe belongs to a frame admitted while the enable was 1.
5. **requirements.md REQ-810 gains the scope in its own words**: its three
   receive-side prohibitions are stated over *the frames the disable refuses*,
   with the admission principle and REQ-803's precedence written out.

## Alternatives

**(a) Reading (ii): the start character is absent for every purpose.** It has
the better claim on §4.3's first sentence in isolation, and it needs no
implementation state at all. Rejected on two grounds, the second decisive.

*What it does to the in-flight frame.* The `/S/` is ignored, so the frame stays
open and consumes what follows it — the refused frame's preamble and octets —
as its own. It then ends at the refused frame's terminate character, with a
length and a CRC computed over two frames' octets, so it reaches M06 either as a
bad-FCS frame or (past 1518 octets) as an oversize truncation. A frame that was
admitted, was valid, and was being forwarded correctly is **corrupted by the
arrival of a frame the module refused**. Reading (i) truncates the same frame at
exactly the octet where the link partner stopped sending it, which is what
REQ-110 exists to do and is the strictly more informative outcome.

*What the requirement that motivates it actually says.* Reading (ii) is
attractive only if REQ-810's prohibitions are unscoped. But an unscoped reading
does not stop at the start character: "emits no output word on any receive-path
stream … asserts no strobe" would also suppress the in-flight frame's own
remaining words and its own terminate-time report, so the frame would vanish
mid-delivery with no `tlast` and no strobe. That is a **silent discard** — the
precise hole REQ-810's own next clause claims not to create ("no frame is
accepted, so this creates no silent-discard hole under REQ-008"). The unscoped
reading is self-defeating, and once REQ-810 is read as scoped to the frames it
refuses — the only coherent reading — REQ-803 governs the in-flight frame, and
REQ-110 is one of the rules it completes under. Reading (i) follows.

**(b) Make the enable take effect only at a frame boundary, i.e. latch it while
a frame is open.** This is reading (i) plus extra state, and on this stimulus it
gives the same three observables. Rejected as unnecessary: the enable is already
*sampled* at each start character (§4.3), so the latch would be a second
mechanism computing the same predicate, and it would additionally have to decide
what happens to a change that arrives and reverts inside one frame — a question
nothing asks.

**(c) Suppress the abort but keep the frame.** Close the in-flight frame
normally at its own terminate character and ignore the start character, i.e.
reading (ii) with the corruption engineered away by re-synchronising the octet
count. Rejected: it requires the module to know where the refused frame's octets
begin, which is to *process* the refused frame — the one thing REQ-810 forbids —
and it delivers an in-flight frame whose octets are a subset of what the wire
carried with no mark to say so.

**(d) Declare the stimulus unconstrained in §6.3.** Rejected. §6.3 item 7
already carries the genuinely indeterminate neighbour — a change landing on the
start character's *own cycle* — and that item's justification is that no bench
can drive it repeatably. This stimulus is one cycle away from it and is
perfectly repeatable, REQ-810's verification column already drives an enable to
0 around live traffic, and leaving it open would leave rtl_lead's declaration
load-bearing, which is the condition WO-0029 exists to end.

## Consequences

- **No delivered design changes.** rtl_lead implemented and declared reading (i)
  at WO-0024 ("`cfg_rx_enable` gates only the *beginning* of a frame. A REQ-110
  `/S/` arriving while it is 0 still aborts and still pulses
  `error_start_without_terminate`"). This ADR confirms that reading on its
  merits, against the two requirements rather than against the implementation,
  and it is worth recording that the same activation **rejected** the same
  agent's declared reading on a different question (SPEC-M03 §6.3 item 8, one
  closure per input word). A declaration is evidence of what was built, never of
  what is required.
- **`AP-xgmii_rx_64.md` row M03-N4 converts from RULING to ASSERT** on reading
  (i), and SPEC-M03 §10's REQ-802/REQ-810 hook commissions the directed case in
  the specification so the row is derivable from spec text alone: abort the
  in-flight frame, exactly one strobe, no output word for the refused frame,
  next frame received after re-enable.
- **The conservation monitor needs no new exemption.** No frame is *presented*
  to the module while the enable is 0 in §0.6's sense — nothing is accepted — so
  the equation balances across the disabled window with the in-flight frame
  counted under its own strobe. This is unlike `clear` (ledger C-2), which
  abandons an **admitted** frame and therefore does need one.
- **The transmit instance is not decided here, deliberately.** `cfg_tx_enable`
  has two readers (M04 and M18) and the joint observable of its disable window
  is ledger **C-36**, open and gated at `AP-udp_ip_tx_64.md` and the M20 bench
  WO. This ADR gives that question its principle — an enable gates admission,
  and a frame already admitted completes under the value that admitted it — but
  the transmit side has a second axis this one does not (two modules must agree
  on *which* event admits a frame), so it is decided there, on its own evidence,
  citing this record.
- **What would change this judgement.** A requirement that made the receive
  enable a safety interlock — "when disabled, nothing whatever leaves the
  receive path within N cycles" — would invert it, because clause 3 would then
  have to yield to a bounded silence. Phase 1 has no such requirement, and
  adding one is an E2 scope change, not a reading.
