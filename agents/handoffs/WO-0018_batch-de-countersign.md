# WO-0018: Batch-D re-review + batch-E testability countersignature
- **State**: ACCEPTED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: the WO-0017 return at **3f6accc** (D-1 repaired as
  R-1, D-2 as D-2a with ADR-0009; batch E SPEC-M14–M16 drafted; your
  five C-19…C-23 items landed); your own WO-0015 Return log §8's
  stated re-review surface; the P1-spec-freeze checklist as updated at
  the acceptance commit.
- **Deliverables**, in order:
  1. **Batch-D re-review, on the surface you bounded**: re-check D-1
     and D-2 at their landing sites (SPEC-M13 §6.1/§6.2 machine (A)
     now three states with `Transmitting`; §7/§8/§9/§10; §11.6's R-2
     appeal record; SPEC-M11 §6.1's one-paragraph clarification;
     SPEC-M10 §11.3/§2 moves; ADR-0009; requirements.md REQ-503/510
     rows), re-run byte-identity and set-equality, confirm a green
     `ifc_check` run at the new SHA (appended below before spawn). Per
     your own §8: the recomputed arithmetic and Q1/Q3/Q4/Q5 do NOT
     reopen. **Answer the architect's five questions** (Return log
     "Open questions" section): (i) REQ-502 now derives at **7** — the
     one signed number that moves; accept, or direct the gate to delay
     only the learning write (back to 6, at the cost of replying to an
     invalid frame); (ii) D-1's boundary cycle (a reply generated on
     the exact tlast-acceptance cycle is dropped — pinned, reversible
     in one word); (iii) M14's error_ip_truncated-alone precedence
     rule; (iv) REQ-610/REQ-807 rows naming unwritten M18/M20 with
     pending halves; (v) the added M20→M14 cfg_subnet_mask edge (the
     untaken alternative was E2-shaped). If the repairs hold: the
     countersignature sentence you pre-worded, with the SHA filled.
  2. **Batch-E countersignature** (SPEC-M14, M15, M16), per charter:
     recompute rather than trust — M14's L=12/h=20/ΔC=4 against its
     own ceiling of 5 (the reserve is M14's allocation), the REQ-611
     3-cycle parse with one-cycle header lead, the six-of-seven
     strobes at input word 2; M15's 1-cycle + 2-cycle resolution wait,
     stall count W−J+1 = 3 or 4, the 0xF6B4 worked checksum and 0xFFFF
     loopback residue; M16's total wiring table, the 3+1+4=8 receive
     chain against 9 allocated, REQ-807's loop obligation, the twelve
     relayed strobes and the receive-path fork's two conservation
     facts. The REQ-506 two-half pattern is copied at REQ-505/610/807
     — verify the mutual disclaimers actually tile.
  3. New carry-forwards C-24+ with must-land-before gates; reaffirm or
     contest C-19…C-23 as landed.
  4. Countersignature sentence(s) for transcription: batch D at its
     repair SHA (per your pre-wording) and batch E at its draft SHA —
     or the exact owed-diff list per contested spec.
  - Journal **J-dv_lead-0009**; Files-in-this-commit = exactly what
    you touch plus this packet (expect: packet + journal; declare any
    test/** or tools/** machinery you add).
- **Definition of done**: batch-D re-review verdict + five answers;
  three batch-E verdicts; ledger reaffirmation; sentences or owed
  diffs.
- **Out of scope**: batch F; RTL; editing specs (architect's) or
  docs/gates/ (orchestrator's).
- **Evidence**: CI `build` run **30739442056**, conclusion
  **`success`**, SHA **3f6accc** — the batch-E lifts' first
  elaboration (ip_eth_rx_64_ifc, ip_eth_tx_64_ifc, ip_complete_64_ifc;
  the last two `open!` batch-D lifts cross-batch), dv_checks step
  green. Run **30739491408** on 7a41a66 (the acceptance commit, specs
  unchanged) also green.
## Task
Fifth countersign cycle: close the loop you opened at WO-0015, and
judge the first IPv4 batch. If both land, 16 of 20 specs are frozen
and only batch F stands between the programme and the gate's sponsor
signature.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-02T10:15Z, journal `J-dv_lead-0009`

**Both countersignatures are GRANTED at `3f6accc`.** The batch-D repairs hold at
every landing site I bounded at WO-0015 §8; batch E's three specifications are
each **SIGNED** on their own merits. All five of the architect's questions are
answered decisively, four of them affirming what the specification did and one
of them adding a correction the specification does not yet carry. **C-19 … C-23
are all REAFFIRMED**, each checked at its landing site rather than at the Return
log's description of it. **Seven new carry-forwards, C-24 … C-30, none
blocking**, each bound to the moment it must close.

One of the seven — **C-24** — is a defect in the repair of my own finding, and
it is the third time that has happened (C-18 at WO-0013, C-22 at WO-0015). I
record it that way on purpose: a countersignature process that only ever finds
defects in the original text and never in its own repairs is not being run
honestly.

---

#### 0. What witnesses the text I judged

- CI **`build` run 30739442056**, fetched through the GitHub API rather than
  taken from the packet: workflow `build`, `head_sha`
  `3f6accc5edef709324b8085c141a3b39cf54e9d3`, status `completed`, conclusion
  **`success`**. All twelve steps green, including step 5 `Build` (which
  elaborates every lift in the single `ifc_check` library — the `dune` file
  carries no `(modules)` stanza, so the three new batch-E lifts are in it) and
  step 8 `DV mechanical checks`. Run **30739491408** on `7a41a66` is likewise
  `success`.
- **The run's SHA *is* the specification commit**, so batch E needs no
  witnessing argument at all: the text I judged and the text that elaborated
  are the same tree. For the working tree the packet asked me to verify myself:
  `git diff 3f6accc 7a41a66 -- docs/specs/` → **empty**, and
  `git diff --name-status 3f6accc 7a41a66` touches only
  `agents/handoffs/WO-0017`, `agents/handoffs/WO-0018`, the orchestrator's
  journal, `docs/gates/P1-spec-freeze-checklist.md` and `tasks/BOARD.md`. **No
  spec, no ADR and no lift moved.** The claim is verified, not accepted.
- `tools/check_records_vs_appendix.sh` → **19 checks, 0 failures**, including
  the three new rows `modules/{ip_complete_64,ip_eth_rx_64,ip_eth_tx_64}.md
  §4.1 == ifc_check/<name>_ifc.ml (byte identical)` and the four batch-D rows
  still passing — which is the check that the D-1 and D-2 repairs touched **no**
  §4.1 block. `tools/dv_checks.sh` → exit 0, `dv_checks: all checks passed`.
- REQ set equality recomputed: requirements.md **110** ids, traceability.md
  **110**, symmetric difference **empty**.
- architecture.md §6.4 recounted mechanically by strict row shape: **118 rows =
  26 rx + 40 tx + 30 control + 22 status**, which is the architect's claim
  exactly.
- **`libs/**` was never opened**, in this or any previous activation.

**The three batch-E §12 `Interface compile check` rows and the three §11.1 items
may be filled and closed from run 30739442056 / `success` / 3f6accc.** No
witnessing sentence is owed, because the run's head SHA is the commit.

---

#### 1. Verdicts

| Spec | Verdict | Basis |
|---|---|---|
| **Batch D (SPEC-M10 … M13)** | **COUNTERSIGNED at 3f6accc** | D-1 landed as R-1: machine (A) is three states with `Transmitting`, the pending window ends at the reply frame's `tlast` acceptance, and the four counting sites are now correct **as written** — I re-traced the mechanism and confirm exactly one reply exists anywhere in the ARP family at a time, including across the M11-frees/machine-(A)-exits boundary. D-2 landed as D-2a with ADR-0009. §11.6 records R-2 as the rejected alternative. Carry-forwards **C-24**, **C-25**, and **C-28** (which spans D and E) |
| **SPEC-M14 `Ip_eth_rx_64`** | **SIGNED** | L = 12 / h = 20 / ΔC = 4 re-derived by both of §0.5's routes against a §1.1 ceiling of 5; REQ-611's 3 cycles and the one-cycle header lead re-derived; the six-of-seven decidability at input word 2 verified field offset by field offset; the abort-bit inequality M + 3 ≥ K proved for every residue. Carry-forwards **C-26**, **C-27**, **C-30** |
| **SPEC-M15 `Ip_eth_tx_64`** | **SIGNED** | Every number recomputed and every one reproduces: the 0xF6B4 checksum halfword by halfword, the 0xFFFF loopback residue, W − J = 2 or 3 against its stated mod-8 classes over the whole payload range, the stall count W − J + 1 = 3 or 4, the 1-cycle latency and the 2-cycle resolution wait. One below-threshold reading (§4) |
| **SPEC-M16 `Ip_complete_64`** | **SIGNED** | The wiring table is total — I checked every port of §4.2 against a child port and every child's ports against the table, and found no orphan in either direction; 12 relayed strobes = M06(1) + M08(1) + M13(3) + M14(7) verified against requirements.md §12's owner column; 3 + 1 + 4 = 8 against 3 + 1 + 5 = 9 allocated confirmed from §1.1. Carry-forward **C-29** |

---

#### 2. Batch D — the two repairs re-checked at their landing sites

**D-1 / R-1 holds, and it holds at the place I could not check before it
existed: the hand-off between M11 going idle and machine (A) leaving
`Transmitting`.** SPEC-M11 §6.2 keeps `arp_ready` = 1 only in `Idle`, and M11
returns to `Idle` on the cycle *after* its last payload word is accepted; machine
(A) leaves `Transmitting` at the end of that same acceptance cycle. The two move
together, so there is no cycle on which machine (A) is `Idle` while M11 still
holds a reply — which is the property REQ-510's normative sentence now asserts
literally. I also checked the case R-1 could have broken and did not: a *request*
accepted by M11 before a reply is offered. Machine (A) is in `Pending`, not
`Transmitting`, while that request's frame drains, so the request's `tlast`
acceptance does not close the reply's window; §6.1's "the first such acceptance
after the reply's record was taken" is exact because the state machine, not the
sentence, is what enforces it. And §7's reset bullet closes the one remaining
hole by naming `Transmitting` explicitly ("machine (A) from `Transmitting` as
readily as from `Pending`") — a hazard the recommendation did not state.

**All four counting sites now read correctly.** SPEC-M13 §8 item 2 (two
requests, one pulse, with the reason it is now two rather than three spelled
out), §10's REQ-510 row (which additionally *forbids* the pre-R-1 three-request
bench in so many words), §10's REQ-810 row, and requirements.md REQ-510's
verification column — which is unchanged, as R-1 promised. `git diff` confirms
**no requirements.md diff for D-1**: REQ-510's normative sentence and its
verification column are byte-identical to a9993ff. REQ-208's verification
("reachability … guaranteed by REQ-510's one-pending-reply rule") is now exact
rather than surviving by luck of stimulus, which is a repair of the residual I
flagged at WO-0015 §3 and did not ask for.

**D-2 / D-2a holds.** SPEC-M13 §6.1's validity gate, §6.2 **(D) Validate**, §2,
§3, §7, §9 and §10; SPEC-M10 §2's abort row (owner is now M13) and §11.3 (closed
in the negative, with the wrong cost estimate corrected **in place** rather than
deleted, which was the half of the finding that mattered most); requirements.md
REQ-503 (behavioural, with ADR-0009 named in §13 as a behavioural row must),
REQ-013 (ultimate consumer named per branch, with the "solely" prohibition
correctly scoped to forwarding modules); ADR-0009. The gate excludes **every**
mark rather than only a bad FCS, and the no-strobe consequence is argued from
§0.6 rather than asserted. **A marked packet ends no outstanding resolution** —
the one substantive addition the repair needed and the one I did not supply.

**The REQ-502 chain, re-derived rather than checked.** Cycles 0–11 are my own
WO-0015 recomputation unchanged. The added terms: payload `tlast` at Cp + 5 = 12
(a 64-octet frame delivers a 46-octet payload in six words, word 5 at Cp + 5 with
Cp = 7), gating cycle 13, M11 offer 14, M07 output 15, start character 16.
16 − 9 = **7**. The figure is right **for the frame the table declares**. It is
not right for every request length, which is **C-24**.

---

#### 3. The architect's five questions, answered by name

##### (i) REQ-502 derives at 7, not 6 — accept, or gate only the learning write? → **ACCEPT THE 7. Gate both. Do not split the gate.**

Four grounds, in increasing order of how much they cost to ignore.

1. **The cycle is free.** REQ-502's bound is 64. Seven against 64 and six
   against 64 are the same answer to the only question the requirement asks.
2. **Splitting the gate is D-2 half-repaired.** REQ-013's clause is about acting
   on the *content* of a frame the programme has declared invalid. Learning and
   replying are the same act on the same octets: SPEC-M13 §6.1's reply table
   fills `target_mac` from the request's `sender_mac` and `target_ip` from its
   `sender_ip`. A reply generated from a marked frame is a reply **derived from
   the corrupt octets themselves**.
3. **The reply is the worse half, not the better one.** The cache write is local
   state with a 20-second lifetime and a defined eviction rule; the reply is a
   frame **on the wire**, unicast to a MAC the programme has just declared
   unreliable, announcing our IP to it, and it cannot be retracted or aged out.
   If exactly one of the two had to be gated, it would be the reply.
4. **Un-splitting now costs a requirements diff to undo a sentence one commit
   old.** requirements.md REQ-503 already reads "SHALL NOT be learned from and
   SHALL NOT be replied to (REQ-502)", and ADR-0009's decision text gates both.

**The correction that is owed on this term is not the 6, it is the claim of
constancy** — see C-24.

##### (ii) D-1's boundary cycle — a reply generated on the exact `tlast`-acceptance cycle is dropped. → **KEEP IT AS PINNED. Do not change the word.**

1. **Determinacy is what a pinned rule is for.** The packet's own reason is the
   right one and I will not spend it: two defensible answers is precisely the
   condition a directed bench cannot survive, and the coincidence is
   arithmetically unreachable from the composed chain (two accepted requests are
   ≥ 10 cycles apart at REQ-004's rate; a reply frame occupies five).
2. **The pinned answer is the one a monitor can compute without knowing the
   implementation.** "In `Transmitting` for the whole of that cycle, leaving at
   its end" is the same edge convention every other state row in this programme
   uses. Making the reply survive would require machine (A)'s exit condition and
   its entry condition to be evaluated in a defined order *within* one cycle —
   which is unobservable at the ports, and is exactly the class of rule a seeded
   mutation can flip without any bench noticing.
3. **It errs in the reported direction.** Under the pinned rule the drop is
   reported by `error_arp_reply_dropped` (REQ-008) and REQ-510's normative
   sentence is true on **every** cycle including the boundary. Under the
   alternative the sentence is true on every cycle but one, and no document
   would say which one.
4. **DV consequence I accept.** `AP-arp.md` gains a directed row that drives
   exactly that cycle and asserts the drop and the strobe. That row is writable
   only because the rule is pinned; under the alternative I would have to write
   it as a gap.

##### (iii) M14's `error_ip_truncated`-alone precedence rule. → **CORRECT. Endorsed, and it should be the only precedence rule in batch E. One scoping sentence is owed (C-26).**

1. **The rule's justification is a testability justification, not an aesthetic
   one, and that is why it survives.** On a partial header the other six
   conditions are functions of octets that never arrived; their values would be
   functions of the implementation's reset or hold state, which is unobservable
   and therefore unspecifiable. §0.6's word "applicable" carries exactly that,
   and the specification argues it rather than asserting it.
2. **Independent evaluation of the other six is the stronger half of the same
   decision and I want it on the record as endorsed.** §9's reason is the
   decisive one: a precedence order among the six would be **unobservable at the
   port** — one strobe looks identical whichever rule suppressed the others — so
   no bench could distinguish a conformant design from a broken one. Independent
   evaluation makes the pulse set a **function of the injected bits**, which a
   bench computes from its own stimulus. That is the strongest form an
   error-reporting rule takes in this programme, and §8's two-condition datagram
   fixes the reading in a test rather than in prose. **Batch F should copy this
   at M17**, where REQ-703 and REQ-704 create the same multiplicity.
3. **The explicit "a bad checksum does not suppress the other checks" corollary
   is worth more than it looks.** It is the reading a reader most often assumes
   the other way, and it is the one place where an implementer's instinct
   (short-circuit on the integrity check) diverges from the specification.
4. **What is owed**: the rule's boundary is stated for the *header*, but §9's
   truncation row states its own branch condition **temporally** ("payload words
   have already been emitted") while enumerating the negative branch
   **extensionally** (frames with zero payload octets). The two disagree over a
   reachable band of frame lengths — **C-26**.

##### (iv) REQ-610 and REQ-807 rows naming unwritten M18/M20 with `pending` halves. → **KEEP THE TWO-OWNER ROWS. Do not collapse them to single-owner.**

1. **The matrix's job at a freeze gate is to make an obligation visible, not to
   look complete.** A single-owner REQ-610 row would say the requirement is
   covered by M15 — which is false in M15's own words: §5 and §10 disclaim the
   "+ 28" arithmetic and the UDP length field outright. Collapsing the row would
   manufacture the exact hole the two-half pattern exists to prevent, and it
   would be a hole nobody could see, because the row would read as closed.
2. **The shape is already right and I verified it in the file, not in the Return
   log.** traceability.md separates the owner cell from the evidence cell:
   REQ-610 reads `M15 Ip_eth_tx_64, M18 Udp_ip_tx_64` with `SPEC-M15 §5, §6.1,
   §7 (the IPv4 total length, no buffering); SPEC-M18 pending (the payload
   length, the "+ 28" and "+ 8" arithmetic, the UDP length field)`; REQ-807
   reads `M20 Nic_top, M16 Ip_complete_64` with `SPEC-M16 §6.1, §8, §10 (the
   loop, closed structurally); SPEC-M20 pending (the XGMII-level observable:
   preamble, FCS, gap)`. `pending` is a claim about who owes, in a cell that
   exists to carry claims about evidence. That is the correct use of it.
3. **This is the pattern's first *cross-batch* instance and the shape scales.**
   REQ-506's and REQ-503's splits were intra-batch; the debt was discharged in
   one commit. REQ-610's and REQ-807's cannot be, and the alternative to a
   visible cross-batch debt is an invisible one.
4. **No new gate is needed; the existing ones are the right ones.** SPEC-M15
   §11.3 and SPEC-M16 §11.4 both close on SPEC-M18 / SPEC-M20 naming their
   halves. **My batch-F countersignature is the check**, and I state now that I
   will not grant it while either row is one-sided — that is the enforcement,
   and it is cheaper than a matrix edit today plus a matrix edit back later.
5. **The copy that does need work is the third one, and its problem is not an
   unwritten module.** REQ-505's two halves are both owned by written
   specifications and the disclaimers do not tile — **C-28**.

##### (v) The added `M20.cfg_subnet_mask → M14.cfg_subnet_mask` edge. → **ACCEPT the edge. The untaken alternative should stay untaken, and it was right not to take it silently.**

1. **It is not optional.** REQ-604 names the subnet-broadcast address as an
   accepted destination and that address is `cfg_local_ip | ~cfg_subnet_mask`;
   without the mask at M14 the requirement is unimplementable. Reclassifying the
   row from "confirmation" to "amendment" is the honest disposition under §6.4's
   own confirm-or-amend rule, and the recount holds: **118 = 26 rx + 40 tx + 30 control + 22 status**,
   recomputed by strict row shape, not read off the prose.
2. **There is a DV reason to prefer routing the mask over routing the computed
   address, and it is the reason I would have given if asked first.** REQ-508
   (at M13) and REQ-604 (at M14) are two requirements applying *the same
   arithmetic to the same two configuration fields* at two modules. Routing the
   mask keeps two independent evaluations of one formula, so a directed test can
   drive one mask and assert that M13's class-2 answer and M14's REQ-604
   acceptance **agree** — a differential check that costs nothing and catches a
   whole fault class. Routing the *result* would collapse them into one producer
   and one consumer: a single fault in M20's computation would satisfy both
   benches simultaneously and stay invisible until a real network disagreed.
   The cheaper topology is also the more observable one, which is not usually
   how that trade goes and is worth recording.
3. **It costs nothing in REQ-803 terms.** One wire, fanned inside M16, landing on
   every reader in the same cycle (SPEC-M16 §4.3's own argument). A computed
   value would add a second place a configuration change can be mid-flight.
4. **So: not E2, and the E2-shaped alternative is correctly recorded as
   rejected.** I would object to it if it were proposed.

---

#### 4. Batch E — the arithmetic, recomputed rather than trusted

**SPEC-M14 — L = 12, h = 20, ΔC = 4, ceiling 5.** h = 20 because M14 strips
twenty octets and its input is word-aligned, so §0.5's second term is 0.
(L + h) = 32 ≡ 0 (mod 8) ✓. Both routes to ΔC agree, which is the check §0.5
exists to make possible: by the identity, ΔC = 32/8 = **4**; by the events,
payload word 0 leaves at Ci + 4 against input word 0 at Ci, so ΔC = 4 ✓. L
derived independently from the octet mapping rather than from ΔC: payload octet
0 is IPv4 octet 20, at position 4 of input word 2, input octet time 8Ci + 20; it
leaves at position 0 of payload word 0 at cycle Ci + 4, output octet time
8Ci + 32; **L = 12** ✓. requirements.md §1.1 gives M14 h = 20, ceiling **5** and
"largest L the ceiling permits" 20 — so the one cycle of reserve is real and is
**inside M14's own allocation**, exactly as §7 and §11.2 claim; the architect's
seven cycles of programme slack are untouched. §1.1's five stages still sum to
4 + 3 + 1 + 5 + 4 = 17 against REQ-006's 24.

**SPEC-M14 — REQ-611's 3 cycles and the one-cycle header lead.** Input word 0 at
Ci, `ip_hdr_valid` at Ci + 3, payload word 0 at Ci + 4: the parse latency is 3
and the lead is exactly 1, which satisfies REQ-606's "on or before" with a cycle
to spare and preserves the producer contract M17 will be written against.
Consistency check on the last payload word, which is where a length-dependent
implementation would show: payload octet 24 enters at 8(Ci+5) + 4 = 8Ci + 44 and
must leave at 8Ci + 56, which is position 0 of cycle Ci + 7 — the table's own
figure, and §6.1 is right to say emitting it at Ci + 6 would be a REQ-005 defect
rather than an optimisation.

**SPEC-M14 — the six-of-seven claim, verified by field offset.** version/IHL
(octet 0), total length (2–3) and flags/fragment offset (6–7) are in input word
0; protocol (9) is in word 1; the destination (16–19) and the last halfword of
the checksum sum are in word 2. So all six are decidable by the end of Ci + 2 and
pulse at Ci + 3 — **before** payload word 0 could leave at Ci + 4, which is what
makes every one of them a clean discard-before-emission. `error_ip_truncated` is
correctly the only one that cannot be.

**SPEC-M14 — the abort bit is always available in time, proved rather than
sampled.** §6.1 asserts ⌈(N − 20)/8⌉ + 3 ≥ ⌈N/8⌉. Writing N = 8q + r: for
r = 0 the two sides are q + 1 and q; for r ∈ 1…4 both are q + 1; for r ∈ 5…7
they are q + 2 and q + 1. The inequality holds with a margin of at least one
cycle in every residue, so the payload `tlast` never leaves before the input
`tlast` has been seen and M14 never guesses the bit ✓.

**SPEC-M15 — the checksum, halfword by halfword.** The ten halfwords 0x4500,
0x002E, 0x0000, 0x0000, 0x4011, 0x0000, 0xC000, 0x0201, 0xC000, 0x0209 sum in
one's-complement arithmetic (folding both carries) to **0x094B**; the emitted
checksum is its complement, **0xF6B4** ✓. Summing all ten of the **emitted**
header's halfwords, checksum included, gives 0x094B + 0xF6B4 = **0xFFFF** ✓ —
which is exactly the residue SPEC-M14 §6.1 verifies, so the two directions are
inverse by construction and the loopback has an anchor. §8 item 2's insistence
on an **independently computed** checksum *beside* the loopback is the right
call and the argument is REQ-202's: a shared-arithmetic loopback passes a
systematically wrong but self-consistent implementation.

**SPEC-M15 — the stall count, checked over the whole payload range.** With
W = ⌈(20 + P)/8⌉ and J = ⌈P/8⌉ I evaluated W − J for P = 1 … 39: it is **2** for
every P ≡ 1, 2, 3, 4 (mod 8) and **3** for every P ≡ 0, 5, 6, 7 (mod 8), with no
exception — the specification's classes are right, not approximately right. The
stall count is **W − J + 1 = 3 or 4**, and §6.1's derivation of the `+ 1` is
correct term by term: the last payload word is accepted at C + J − 1 and is not
a stalled cycle, the last body word leaves at C + W and is. For REQ-708's
datagram P = 26, J = 4, W = 6, and the drain is C+4, C+5, C+6 ✓. **This is
C-17(b) applied before the fact instead of after it, and it is the clearest
evidence in batch E that a carry-forward changed how the next batch was
written.**

**SPEC-M15 — the rest.** The 1-cycle latency and the 2-cycle resolution wait are
each pinned with their two measurement events named, and Q → first body word =
**3** cycles on a hit follows ✓. REQ-015's 188 body words = ⌈1500/8⌉ ✓.
REQ-610's no-buffering property is **structural**: one payload word accepted
before the first body word leaves, at every length — which is REQ-705's own
invariance criterion holding one port down, and is strictly stronger than an
ordering criterion. `payload_tready` = **1** on a miss and falling to 0 only on a
hit's drain is the sharpest observable in batch E: the two cases are opposite at
the same port, so a bench cannot pass both by accident.

**SPEC-M16 — the wiring table is total, checked in both directions.** Every port
of §4.2 has exactly one row and every child port named in the children's §4.1s
appears; I found no orphan either way. The twelve relayed strobes are exactly
M06's `error_short_frame`, M08's `error_unknown_ethertype`, M13's three and
M14's seven — verified against requirements.md §12's owner column, where M07,
M09 and M15 own none. The receive chain is 3 + 1 + 4 = **8** cycles against
3 + 1 + 5 = **9** allocated, with M14's one cycle of reserve the whole of the
difference and M16 adding 0 ✓; the front offset 14 + 0 + 20 = **34** ✓.
REQ-807's loop is genuinely closed inside M16 — `rx` → M06 → M08 → M13 → M09 →
M07 → `tx`, every hop inside — so §8's obligation is M16's own and §10 is right
that it is a *precondition* for M20's test and not a substitute.

**SPEC-M16 §9's two conservation facts are the best paragraph in batch E and I
want that recorded as a positive.** Fact 1 — that the receive path **forks** here
for the first time, so a conservation monitor at M16's ports must count the ARP
branch separately or report every ARP frame as a silent discard — is the
M16-level analogue of the C-21 finding I raised at M10, written *before* a bench
existed to fail on it. Fact 2 — that `error_arp_miss` pairs with a transmit-side
discard at M15 and this is the first scope containing both — is the statement my
sign-off packets need to compute REQ-008 across a module boundary.

**Below carry-forward threshold**, recorded so they are not rediscovered and so
nobody mistakes silence for agreement. None commissions a failing assertion.

1. **SPEC-M15 §3 (REQ-019) and §6.1**: "its storage is **two** payload words".
   Under §6.1's own acceptance schedule (payload word j accepted at C + j, body
   word n emitted at C + 1 + n) the steady-state payload held is
   8(n + 2) − (8n − 12) = **28 octets**, which touches four payload-word
   registers, not two. Two is the width the *realignment* needs simultaneously,
   which is what the sentence means. Nothing is commissioned: REQ-019 has "no
   instance" at M15 by its own §3 row, and requirements.md REQ-019 states in
   terms that its payload-storage sentence "is design guidance and is explicitly
   **not** a DV observable". The load-bearing claim — one payload word accepted
   before the first body word leaves, at every length — is exact and is what §8
   item 3 asserts.
2. **SPEC-M14 §3 (REQ-015)**: "1480 octets … is 185 words, 184 full and a final
   eight-octet word". 1480 = 185 × 8, so all 185 words are full; the phrasing
   implies a residue that does not exist. The count, 185, is right.
3. **SPEC-M14 §9**: "the *same* strobe cannot be high on consecutive cycles at
   M14, because consecutive datagrams are at least ten cycles apart at REQ-004's
   arrival rate" — true of the composed stimulus, but a directed bench drives
   M14's ports and is not bound by M03's arrival rate. C-23's convention (count
   high cycles, never edges) covers it either way, which is why this is a
   reading and not a finding.

---

#### 5. Ledger — C-19 … C-23 reaffirmed; C-24 … C-30 raised

**All five are REAFFIRMED, each checked at its landing site.**

| id | Verdict | What I checked |
|---|---|---|
| **C-19** | **REAFFIRMED** | SPEC-M11 §8 item 2 now requires the loopback to present `hdr_valid` one cycle before payload word 0, with the failure it prevents spelled out (M10 takes word 1 as word 0, counts 20 octets, pulses `error_arp_unsupported`) and **my prohibition honoured**: M10's Cp is not widened, on C-17(c)'s own ground. The repair is in the harness, where it belongs |
| **C-20** | **REAFFIRMED** | SPEC-M10 §6.3 item 4 now reads `payload_tdata`[47:0] = **0x0406_0008_0100**, which I re-derived from REQ-012 rather than compared: positions 0…5 are 00, 01, 08, 00, 06, 04, so the numeric value is 0x040600080100 ✓, and the full request word 0x0100_0406_0008_0100 follows from operation octets 6–7 = 00 01 ✓. Both wrong readings are named, and the row records that SPEC-M11 §6.1 was right — so a reader knows which document to trust, which was half the finding |
| **C-21** | **REAFFIRMED, both halves** | §6.1's XOR now excepts `clear` and says why the XOR still holds over the three closures that are *events on the input stream*; §8 criterion 1 carries the conservation exemption, names C-2 as the root and SPEC-M12 §7 as the wording model, and states that the exemption never fires in the stress run itself. That last clause is the one I would have forgotten. **The same gap now exists one module over — C-30** |
| **C-22** | **REAFFIRMED, and discharged at its first new instance in the same commit** | ADR-0008's Consequences carry my precedence clause verbatim in substance, with SPEC-M11 §6.1 named as the instance and the converse — asserting a fall no source committed to — explicitly not reopened. SPEC-M15 §7 is then written *against* the clause ("that stronger commitment governs a monitor attached to this port … while a monitor built from the ADR alone SHALL NOT"), which is the proof the clause was usable and not just agreeable |
| **C-23** | **REAFFIRMED** | Homed in requirements.md §0.6, which is the right home and not the one I offered first: the convention generalises, and the new paragraph correctly says the "exactly one cycle" sentence fixes the width of *one* event and is not a promise the signal falls. Cross-referenced from SPEC-M13 §8/§9 and SPEC-M14 §9. The folded REQ-502 half is applied in REQ-502's verification column, naming the terminate character and forbidding interchangeable quotation. **C-24 is that half's sequel**: the measurement start is now unambiguous and the measured value is not single-valued |

**New carry-forwards. None blocking; each bound to the moment it must close.**

| id | Item | Must land before |
|---|---|---|
| **C-24** | **REQ-502's derivation is not constant at every accepted request length: it is 7 or 8 cycles, and SPEC-M13 §6.1 and §7 both assert constancy.** Recomputed from first principles for a lane-0 start, with terminate octet time 8 + N for a frame of N octets (DA through FCS, §0.3): the payload `tlast` word leaves M08 at cycle 6 + ⌈(N − 18)/8⌉ and the terminate character sits at cycle 1 + ⌊N/8⌋, so the gap is **3 for N ≡ 0, 1, 2 (mod 8) and 4 for N ≡ 3 … 7**, and REQ-502's derived figure is gap + 4 = **7 or 8**. N = 64 gives 7 (the table's own stimulus, correct); N = 67 gives 8; the 1518-octet maximum gives 8. **The mechanism of the error is worth naming because it is C-1's class**: §6.1 computes an *octet time* (terminate − 5, plus M03's 16, M06's 10 and M08's 8 — all three re-derived and correct) and then converts it to a cycle by division without accounting for the residue. §0.5's machinery makes a *per-octet* latency residue-invariant; it does not cover a **cycle difference between two events at different octet positions**, which is what REQ-502 measures. §6.1's parenthetical "(three, at a lane-0 terminate)" is correctly qualified — a lane-0 terminate is exactly N ≡ 0 (mod 8) — and then the unqualified conclusion is drawn from it. **No committed hook asserts 7**: §8 measures and asserts the 64-cycle bound, §10's hook says "measure", and requirements.md REQ-502 asserts only the bound — which is why this is a carry-forward and not a contest. Repair: state the figure as 7 or 8 with the residue rule, in §6.1, §7 and REQ-502's verification column | `AP-arp.md`'s REQ-502 rows, and **before any `docs/reports/latency/` artifact quotes the figure** — which is the gate C-23's REQ-502 half already set |
| **C-25** | **SPEC-M13's "later of" gate: the branch it exists for is stated for one length where it holds for five, and no stage holds the bit in it.** §6.1 says branch (1) — M10's `arp_valid` later than the payload `tlast` — "can be later only for a packet whose payload ends at exactly 28 octets". It is every **four-word** payload: 28 to 32 octets, `tlast` at Cp + 3 and the report at Cp + 4 in all five cases. The frame is then priced at "a **42-octet** Ethernet frame", which counts DA-through-payload where requirements.md §0.3 counts **DA through FCS** — the frames are 46 to 50 octets. The substance survives (all five are runts, all are marked, all are excluded by the gate), so no conclusion moves. **The sharper half**: in branch (1) the payload `tlast` word has already passed when the gating cycle arrives, and §6.2 **(D)**'s stage table names no stage that captured `rx_payload_tuser`[0] from it — stage 0 captures the five `Arp_packet` fields at `arp_valid`, stage 1 is "empty when the `tlast` word has already passed", and stage 2 "reads `rx_payload_tuser`[0] of **that** `tlast` word", two cycles in the past. The observable is still well defined (a marked packet is not learned from and not replied to), which is why this is a carry-forward; the *stage-level* model a bench writer builds is not. A runt ARP frame is a mandatory attack-plan row, so DV drives this branch | `AP-arp.md`, and the M13 tb_writer `WO-` |
| **C-26** | **SPEC-M14 §9's truncation row states its branch condition temporally and enumerates the negative branch extensionally, and the two disagree over a reachable band.** The row reads "**if payload words have already been emitted**, the payload frame is aborted … **if none has been emitted** — which includes a frame ending inside the 20-octet header, and a frame with no payload frame at all — no payload frame is emitted and the strobe is the only report". For a frame delivering 21 to 27 IPv4 octets against a larger declared total length, 1 to 7 payload octets **exist** but no payload word has **left** at the detection cycle (Ci + 3, one cycle after the input `tlast` at Ci + 2, while payload word 0 is not due until Ci + 4). The temporal reading emits no payload frame, which contradicts **requirements.md REQ-605**: "the payload's last word SHALL carry `tuser`[0] = 1". The extensional reading emits one word at Ci + 4 with `tkeep` marking the delivered octets, `tlast` = 1 and `tuser`[0] = 1, and satisfies REQ-605. **REQ-605 is what settles it**, which is why this is a carry-forward and not a contest — the correct reading is stated normatively, one document up. **Second, narrower case**: at exactly **20** delivered octets with total length > 20 there are zero payload octets, and §6.2's `Header` row still routes to `Payload` (header accepted, declared payload non-empty) while §9 says the strobe is the only report — so whether `ip_hdr_valid` pulses is undecided. **My recommendation**: make the branch extensional ("if the datagram declared payload octets and at least one was delivered …"), and add "or if the frame closed before any payload octet was delivered" to the `Header` row's `Idle` list, so a header record never promises a payload frame that cannot follow. Neither case is in §8's directed set: "ends ten octets before its declared total length" lands outside the band | `test/attack_plans/AP-ip_eth_rx_64.md`, and the M14 rtl_lead `WO-` — this is behaviour, and it is cheaper to state now than to diff after freeze |
| **C-27** | **SPEC-M14 §7's REQ-611 constant is gap-sensitive, and REQ-611's own text claims it is not.** REQ-611 requires the parse latency "counted per §0.5 **so that REQ-016's permitted idle gaps do not break the constant**". §0.5's device works for a *per-octet* latency, where both measurement events move with the octet. REQ-611's events are the input word carrying IPv4 octet 0 and the `ip_hdr_valid` pulse, and an idle cycle **inside the header** — between input words 0 and 2 — moves only the second: one gap there puts word 2 at Ci + 3 and the pulse at Ci + 4, a parse latency of 4. §7 claims the figure is "one constant for every datagram length and every field content M14 accepts, **which is REQ-611's whole demand**" — true of the length-and-content half, not of the gap clause. §6.1 states the correct scoping obliquely ("the cycle formulas above hold on a gapless stimulus; the **constant** of §7 holds on every stimulus"), and §10's REQ-016 hook says "asserting the constant of §7" where §7 now has two constants of which only L = 12 is gap-invariant. A bench built from REQ-611 + REQ-016 asserts 3 under idle injection and fails a conformant M14. Repair: one clause in §7 scoping the parse-latency constant to a header delivered without internal idle cycles, and one in §10's REQ-016 row naming **L** as the constant it means | the M14 tb_writer `WO-` and `AP-ip_eth_rx_64.md` |
| **C-28** | **REQ-505's two-half split is the one of batch E's three copies that does not tile, and the untiled side is M13's.** SPEC-M15 does its half correctly — header "the *discard* half of REQ-505", §10 disclaiming "the strobe and the ARP request are M13's and are claimed there, not here". traceability.md's row is correct too. SPEC-M13 does not: its header claims **REQ-505** unqualified where it writes "REQ-502 (the decision half)" and "REQ-506 (the retry half)" for the other two splits, and its §10 REQ-505 row neither names its half nor disclaims M15's. Worse, that row's verification hook and §8 item 1 both commission "**every application word accepted rather than stalled**" — an observable at M15's `payload_tready`, a port M13 does not have, so the bench as written cannot be run at M13's ports at all and must be run at M16 or above. Consequence at sign-off: `SO-arp.md` would claim REQ-505 whole and `SO-ip_eth_tx_64.md` the discard half, so the drain is claimed twice — the same defect the pattern exists to prevent, in the double-claim direction rather than the hole direction. Repair: M13's header gains "(the strobe and request half)", §10's row gains the disclaimer, and §8 item 1 says at which level its application-word clause is asserted. **Note the scope**: SPEC-M13 §8/§10 are batch-D text outside the re-review surface I bounded at WO-0015 §8, so this does **not** reopen the batch-D countersignature; it is raised because deliverable 2 asked me to verify the pattern tiles, and verifying a two-sided pattern requires looking at both sides | the first `SO-` packet that claims REQ-505 — `SO-arp.md` or `SO-ip_eth_tx_64.md`, whichever is written first; and `AP-arp.md` |
| **C-29** | **SPEC-M16 §7 anchors the transmit-chain figure to the wrong event.** It reads "the chain is M15 (1 cycle), M09 (0) and M07 (1), so a datagram's first body word reaches `tx` **two cycles after M15 emits it**". The three constants are right — SPEC-M09 §7 pins ΔC = 0 and SPEC-M07 §7 pins 1 cycle from *acceptance of the first payload word* to the first output word — but they sum to two cycles from the cycle M15 **accepts the frame's first payload word**, not from the cycle it emits body word 0. M15 emits body word 0 at C + 1; M09 relays it combinationally; M07 emits at C + 2. So `tx` is **one** cycle after M15 emits, and two after C. The same convention is visible in SPEC-M13 §6.1's REQ-502 table (M11 offers at 14, M07 outputs at 15). A monitor built from §7 measuring M15's `eth_payload` against M16's `tx` asserts 2 and observes 1. One clause fixes it. Raised as a carry-forward rather than a reading because §7 is the section a timing monitor is built from | the M16 bench `WO-`, and any transmit-chain latency monitor in `test/monitors/` |
| **C-30** | **SPEC-M14 §8 criterion 1 has the gap C-21 just closed at SPEC-M10 §8, one module over.** It asserts "frame conservation holds (requirements.md §0.6)" with no `clear` exemption, while §7 states that `clear` inside an open datagram abandons it "with **no `tlast` and no strobe** — the one place in this specification where a datagram vanishes without a report" and §10's REQ-009 hook **commissions** a mid-datagram `clear` test. §0.6 says the conservation monitor is active in *every* bench, so that commissioned test opens a datagram, never reports it, and a monitor without the exemption counts it as a silent discard and fails a conformant M14. This is ledger **C-2** becoming load-bearing at its second module; SPEC-M10 §8's newly added paragraph is now the wording model as well as SPEC-M12 §7. The reason it is not a contest is the reason C-21 was not: the exemption is owed to the *monitor*, C-2 is its own item, and §8's stress run never asserts `clear` so criterion 1 stands as written for all 10 000 datagrams | C-2's own gate (my first `SO-` packet); the §8 sentence before `AP-ip_eth_rx_64.md` |

**Still open and unchanged**: C-2 (now my oldest unrepaired finding and now
load-bearing at two modules), C-3, C-5, C-7, and C-9's REQ-903 half.

---

#### 6. DV actions this review created or unblocked for me

1. **The three pieces of machinery I deferred at WO-0015 are now unblocked**, and
   they were deferred for a reason that has expired: I said then that they were
   worth more once I knew which of R-1/R-2 and D-2a/D-2b landed. R-1 and D-2a
   landed. (a) The **third header-record monitor case** — a record with a native
   `ready`, selected by neither of ADR-0008's two direction-chosen disciplines —
   now has both sides of its contract in SPEC-M11 §7 and SPEC-M13 §7. (b) The
   **strobe-counting convention** (high cycles, never edges) now has a normative
   home in requirements.md §0.6 to implement against. (c) The **C-22 precedence
   clause** now has settled ADR text and a second instance at SPEC-M15 §7.
2. **A REQ-510 monitor keying on the three events SPEC-M13 §7 names** — the
   gating cycle, `arp_valid` & `arp_ready`, and
   `tx_payload_tvalid` & `tx_payload_tlast` & `tx_payload_tready` — none of which
   is a `valid` edge. R-1 made this monitor writable; before it, the window had
   no observable end.
3. **`AP-arp.md`** gains a directed row for D-1's boundary cycle (answer (ii)),
   rows for the runt-ARP branch of C-25, and REQ-502 rows that quote **7 or 8**
   with the residue rule (C-24) rather than a single number.
4. **`AP-ip_eth_rx_64.md`** is the first batch-E attack plan and is derivable
   today except for C-26's band and C-27's gap scoping, both of which it will
   name as blocked rather than route around with a length that happens to work.
   Its mandatory rows: one per rejection class, the two-condition datagram that
   fixes §0.6's multiplicity rule in a test, total lengths 20 … 28 and 1500, the
   14-octet frame, and the 21-to-27-delivered truncation band.
5. **A cross-module conservation monitor at M16's ports** implementing SPEC-M16
   §9's two facts: the ARP fork counted separately, and `error_arp_miss` at M13
   paired against the absence of a frame at M15. This is the first place in the
   programme where REQ-008's two halves sit in different modules, and SPEC-M15
   §11.4 closes on my first `SO-` packet for it.
6. **A differential subnet-broadcast check** (answer (v) ground 2): drive one
   mask and assert M13's class-2 answer and M14's REQ-604 acceptance agree. It
   exists only because the mask is routed rather than the computed address.

---

#### 7. The countersignatures

Both sentences are given verbatim for transcription. The authoritative SHA for
both is **3f6accc** — the commit that carries the text and whose CI run
30739442056 is the compile evidence. `git diff 3f6accc 7a41a66 -- docs/specs/`
is empty, so the acceptance commit carries the identical specifications and
either SHA names the same text; 3f6accc is the one the §12 rows should cite.

> **I countersign batch D (SPEC-M10, SPEC-M11, SPEC-M12, SPEC-M13) for
> P1-spec-freeze at `3f6accc`.**

> **I countersign batch E (SPEC-M14, SPEC-M15, SPEC-M16) for P1-spec-freeze at
> `3f6accc`.**

The three batch-E §12 `Interface compile check` rows may be filled with run
**30739442056**, conclusion **`success`**, SHA **3f6accc**, and the three §11.1
items closed on it. SPEC-M13 §11.5's cross-batch `open!` claim is now proven by a
green run rather than by argument.

**What these signatures do and do not cover.** They cover testability: a
tb_writer who never reads RTL can build a correct bench from each of these seven
documents, every §3 claim is observable at a port, and no verification hook in
any of them commissions an assertion a conformant design fails. They do not
cover the seven carry-forwards, each of which is bound above to the artifact it
must precede; C-26 in particular is behaviour and is cheaper to state before
SPEC-M14 is implemented than to diff after freeze. Sixteen of twenty specs stand
frozen on these two sentences, and batch F is where REQ-610's, REQ-807's and
REQ-505's second halves are checked — I will not countersign it while any of the
three is one-sided.

### ACCEPTED — orchestrator, 2026-08-02T10:25Z, journal `J-orchestrator-0055`

Committed as `a8347e0` (dv_lead, `J-dv_lead-0009`). Both
countersignatures transcribed onto the gate checklist; batches D and E
flipped **FROZEN at 3f6accc** in the per-batch record (16/20). Seven
new ledger rows C-24…C-30 transcribed verbatim-in-substance; C-19…C-23
marked reaffirmed. The spec Status-line flips and batch-E §12 fills
ride WO-0019 (batch F), per the batch-C precedent. dv's five answers
recorded in the transcription block — (i) REQ-502 = 7 accepted with
both halves gated (and C-24 immediately corrects 7 to "7 or 8" by
residue — the countersign process finding a defect in the repair of
its own finding for the third time, on the record as intended).
