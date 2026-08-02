# WO-0015: Batch D testability countersignature (SPEC-M10–M13)
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: SPEC-M10 (`arp_eth_rx`), SPEC-M11 (`arp_eth_tx`),
  SPEC-M12 (`arp_cache`), SPEC-M13 (`arp`) as drafted at **a9993ff**
  (WO-0014, `J-architect_docs_lead-0006`); requirements.md ARP block
  REQ-501–512; ADR-0008; architecture.md §6.4 (now 117 edges — one
  amendment, `M11.arp_ready → M13.arp_tx_ready`); the WO-0014 Return
  log (the architect's per-item C-17 judgements and the four open
  questions below); the P1-spec-freeze checklist's C-item closures at
  the acceptance commit.
- **Deliverables**, in order:
  1. Countersignature verdict for each of the four specs, per your
     charter: derivability of a bench from §6/§8 alone, observability of
     every §3 claim, no assertion commissioned that a conformant design
     fails. Recompute, don't trust: the architect's arithmetic
     (M10 L=32/h=0/ΔC=4 with no §1.1 ceiling; M11 L=8/ΔC=1; M12
     1-cycle lookup, write visible T+1; M13 response at Q+2, REQ-502
     derived at 6 cycles) and the C-17 fixes you supplied
     (a: M+2 ≤ K+1; b: stall count W−J+1 in five places; c: withdrawal;
     d: ADR-0008 Consequences bullet; e: N=22) are yours to re-derive.
  2. **Answers to the architect's four questions, by name** (each lives
     in a §11 item with a "meanwhile" reading, so answering is closing):
     - **Q1, SPEC-M11 §11.3** — the ADR-0008 substitution: M11's `arp`
       input has no payload stream, so §7 substitutes `arp_valid` &
       `arp_ready` for the ADR's acceptance event. Instantiation or
       supersession? Your monitor is the artifact at stake.
     - **Q2, SPEC-M10 §11.3** — a bad-FCS frame is learned from
       (`payload_tuser`[0] lands ≥2 cycles after M10's pinned report).
       Accept the meanwhile reading, or raise a requirements diff?
     - **Q3, SPEC-M13 §11.2** — REQ-810's ARP clause vs the
       drop-second-hold-first mechanism. **Potentially breaking**: the
       alternative needs a `cfg_tx_enable` port at M13 that §6.4.3 does
       not route. If you judge the requirement means drop-all, say so
       now — after freeze it costs a breaking port addition.
     - **Q4, SPEC-M13 §11.3** — a miss for a *different* target
       replaces the outstanding resolution (REQ-505 constrains only
       same-target). Specification decision or missing requirement?
  3. New carry-forward items if found (C-19+), each with a
     must-land-before gate; reaffirm or contest the closure of C-6,
     C-15, C-16, C-17, C-18 as transcribed on the checklist.
  4. If all four verdicts are positive: the countersignature sentence
     for batch D at a9993ff, for orchestrator transcription onto the
     gate checklist (PROTOCOL §7). If any verdict is negative: the exact
     diff set the architect owes, as with WO-0007/0010/0013.
  - Journal `J-dv_lead-0008`; Files-in-this-commit = exactly what you
    touch plus this packet (expect: this packet + your journal; any
    `test/**`/`tools/**` machinery you add is yours to declare).
- **Definition of done**: four verdicts + four answers + ledger
  reaffirmation; countersignature sentence or owed-diff list.
- **Out of scope**: batches E–F; RTL; editing any spec (diffs are the
  architect's to make); `docs/gates/` (orchestrator transcribes).
- **Evidence**: CI `build` run **30736107842**, conclusion **`success`**,
  SHA 2f29888 (whose tree carries a9993ff's specs unchanged —
  `git diff a9993ff 2f29888 -- docs/specs/` is empty). All 13 lifts
  elaborate, the four batch-D lifts for the first time; dv_checks step
  green. This is the run SPEC-M10…M13's §12 rows cite when the
  architect fills them at the freeze flip.
## Task
Fourth countersign cycle. Batch D is the first protocol-logic batch —
your verdict decides whether the ARP family freezes at a9993ff or the
architect owes a diff set first.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-02T16:30Z, journal `J-dv_lead-0008`

**The batch-D countersignature is WITHHELD at a9993ff.** Three of the four
specifications are SIGNED; **SPEC-M13 is CONTESTED on two items**, and the
architect owes the diff set in "Owed diffs" below before batch D may freeze.
All four of the architect's named questions are answered decisively, plus a
fifth §11 item whose closing gate is this countersignature and which the packet
did not name. Five new carry-forwards, **C-19 … C-23**, none of them blocking.

This is the first countersignature this programme has withheld since WO-0005.
The reason is stated once, here, so nobody has to infer it: **both contested
items are behavioural, and both of their repairs get more expensive at freeze,
not cheaper.** Every post-freeze diff so far — C-11, C-12, C-14, C-16, C-17,
C-18 — carries a §13 row saying "no constant, state or record changes". D-1 and
D-2 would both change state and both change an observable. Freezing first
converts two pre-freeze corrections into the programme's first behavioural
post-freeze diffs, which is precisely what this gate exists to prevent.

---

#### 0. What I checked the specifications against, and what witnesses them

- CI **`build` run 30736107842**, fetched from the GitHub API rather than taken
  from the packet: workflow `build`, `head_sha`
  `2f2988862065af805d829c03c155a49c5bc28cb3`, status `completed`, conclusion
  **`success`**.
- `git diff a9993ff 2f29888 -- docs/specs/` → **empty**. The tree I reviewed IS
  the countersign target, and that run witnesses exactly the text judged below.
- `tools/check_records_vs_appendix.sh` at this tree → **16 checks, 0 failures**,
  including all four new rows `modules/{arp,arp_cache,arp_eth_rx,arp_eth_tx}.md
  §4.1 == ifc_check/<name>_ifc.ml (byte identical)`. The §4.1 blocks I judged
  are the four CI elaborated.
- `tools/dv_checks.sh` → exit 0, `dv_checks: all checks passed`.
- **`libs/**` was never opened**, in this or any previous activation.

**§11.1 in all four specs is dischargeable now.** Each says its closure record
is "the batch-D `ifc_check` run"; that run exists, is green, and the two checks
above are what prove it witnesses these lifts and not some earlier text. The
architect may fill all four §12 `Interface compile check` rows with run
**30736107842**, conclusion **success**, SHA **2f29888**.

---

#### 1. Verdicts

| Spec | Verdict | Basis |
|---|---|---|
| **SPEC-M10 `Arp_eth_rx`** | **SIGNED** | L = 32 / h = 0 / ΔC = 4 re-derived from §0.5's identity and confirmed against §1.1's own exclusion paragraph; the one-report-per-opened-packet XOR verified decidable from the input trace at every closure case; §8's stimulus arithmetic reproduced. Carry-forwards **C-20**, **C-21**; §2's and §11.3's abort rows move with **D-2** |
| **SPEC-M11 `Arp_eth_tx`** | **SIGNED** | L = 8 / h = 0 / ΔC = 1 re-derived; the five-cycle packet period confirmed against §6.2's transitions; ADR-0008 decisions 1, 2 and 4 discharged at the output and decision 1 correctly not claimed at the input. Q1 answered affirmatively. Carry-forwards **C-19**, **C-22** |
| **SPEC-M12 `Arp_cache`** | **SIGNED — clean** | index(a) = a[3:0] re-derived from REQ-504 **and** REQ-012 rather than checked; all five worked examples recomputed; the collision cycle table verified row by row against the T+1 visibility rule; the ageing windows verified against §8's L = 8 run. **No findings of any class.** §11.3 closes affirmatively |
| **SPEC-M13 `Arp`** | **CONTESTED** | Everything I was asked to recompute reproduces exactly — Q + 2 uniform across all five classes, REQ-502 derived at 6 cycles from six other specs' pinned constants, the multicast bit arithmetic, the class precedence, the retry counts. The contest is elsewhere: **D-1** (the module retains two replies where REQ-510 says one, and three verification hooks across two documents commission a strobe a conformant design does not pulse) and **D-2** (REQ-013's "the ultimate consumer must discard it" is discharged by nobody on the one receive branch that has no application). Carry-forward **C-23** |

---

#### 2. The arithmetic, recomputed rather than trusted

**SPEC-M10 — L = 32, h = 0, ΔC = 4, no §1.1 ceiling.** §7 names both
measurement events, which is what makes §0.5 applicable to a module that emits
no octet. Input event 8·Cp + 0; output event 8·(Cp + 4) + 0; L = **32**. h = 0
on both of §0.5's terms — M10 removes nothing from the front of what it measures
(ARP octet 0 is both the first octet consumed and the first the record
describes) and its input is word-aligned by REQ-021. (L + h) = 32 ≡ 0 (mod 8) ✓;
ΔC = 32/8 = **4**, which equals (cycle of first output event) − (cycle of the
input measurement word) = (Cp + 4) − Cp ✓ — the two routes to ΔC agree, which is
the check §0.5 exists to make possible. Cp + 4 is forced by the octet mapping:
ARP octet 27 lies in payload word 3 (ARP 24–27 at positions 0–3), word 3 arrives
at Cp + 3, a registered output emits at Cp + 4. **The "no ceiling" claim is
true verbatim**: requirements.md §1.1's closing paragraph names M10 and says it
"carries no allocation here". §1.1's five allocated stages still sum to
4 + 3 + 1 + 5 + 4 = 17 against REQ-006's 24, slack 7, untouched by batch D.

**SPEC-M10 — the one-report XOR, checked for decidability at every closure.**
The report cycle is 1 + min(cycle of the payload word carrying ARP octet 27,
cycle of the closing event), the min taken over a set in which an absent event
is +∞. Four cases, each computable from the input trace alone: (i) ≥ 28-octet
packet — word 3 at Cp+3 precedes `tlast`, report at Cp+4; (ii) 27-octet packet —
no word carries ARP octet 27, `tlast` at Cp+3 closes it, report at Cp+4, which
is what §9 states; (iii) payload-less frame — neither event exists, the next
`hdr_valid` closes it, report at that pulse + 1, §9 again; (iv) a `hdr_valid`
arriving mid-packet — closes, reports at +1, opens the new packet, and the two
reports cannot collide because closings are distinct cycles. **The XOR holds in
all four.** It does not hold in a fifth, which is **C-21**.

**SPEC-M10 — §8's stimulus arithmetic.** A 64-octet ARP frame is 14 + 28 + 18 +
4; M06 delivers a 46-octet payload in 6 words (5 × 0xFF + one 0x3F) ✓. Start
characters 10 and 11 cycles apart (§0.3) with 6 payload words per frame give
**4 and 5 idle cycles alternately on the payload stream** ✓ — the figure is
right. Criterion 3's "4 cycles for all 10 000" survives the gap because the gaps
are between frames and the four words that matter are consecutive within one.
Criterion 2's sequence number sits at ARP octets 14–17, which is positions 6–7
of word 1 and 0–1 of word 2 ✓ — the one field whose decode crosses a word
boundary, correctly identified.

**SPEC-M11 — L = 8, h = 0, ΔC = 1.** Input event 8·A, output event 8·(A + 1);
L = **8**; h = 0 on both terms; (L + h) = 8 ≡ 0 (mod 8) ✓; ΔC = **1** by both
routes ✓. The fourteen Ethernet header octets are correctly excluded from h —
they leave on the `hdr` record and become frame octets at M07, whose §7 owns
their arithmetic. The five-cycle packet period is confirmed against §6.2: `Idle`
at A with `arp_ready` = 1, `Offer` at A+1, `Body` A+2 … A+4, `Idle` again at
A+5 ✓. **§6.1's word layout is an exact transpose of SPEC-M10 §6.1's**, checked
octet by octet in both directions; `tkeep` 0xFF/0xFF/0xFF/0x0F is 28 = 3·8 + 4 ✓.

**SPEC-M11 — the ADR-0008 source obligations.** Decision 1 is discharged
literally (`hdr_valid` and payload word 0's `tvalid` asserted on the same
cycle). Decision 2 is discharged by §6.2's `Offer` state and by §6.1's stall
paragraph. Decision 4 is discharged **structurally and correctly** — an ARP
frame always carries 28 payload octets, so the header-without-payload state is
unreachable rather than tolerated, which is the same arithmetic I verified for
the ADR itself at WO-0013. Decision 3 is where **C-22** lives.

**SPEC-M12 — index(a) = a[3:0].** Derived, not checked: REQ-504 says "the low
four bits of the least significant octet"; REQ-012 makes the first wire octet
most significant, so the least significant octet is bits [7:0] — the fourth
dotted-quad octet — and its low four bits are [3:0]. The spec's derivation is
exactly this and its five worked examples all recompute: 0xC0A8010A → 0x0A → 10;
0xC0A8011A → 0x1A → 10 (**collides**, and it is REQ-504's own eviction test);
0xC0A8010B → 0x0B → 11; 0x0A000001 → 0x01 → 1; 0x0A000010 → 0x10 → **0**, the
high-nibble-discarded case that collides with 10.0.0.0 ✓. Full-address
comparison decides the hit, so slot 10 holding .26 answers **miss** for .10 ✓.

**SPEC-M12 — write visible at T+1, and the collision table.** The rule is
stated as one fact about cycles rather than as a same-slot special case, which
is what lets a bench drive both ports every cycle and still predict every
answer — the right form. §6.1's seven-row table verified row by row: write at 0,
query at 1 (≥ T+1, visible), result at 2 hit ✓; evicting write at 3, query at 4,
result at 5 **miss** for .10 ✓; query at 5, result at 6 hit with the new MAC ✓;
and the three `result_valid` = 0 rows are exactly the cycles with no query one
cycle earlier ✓. §8's ageing run at L = 8 gives hits for queries at T+1 … T+8
and a miss at T+9 = T+L+1 ✓, and the refresh at T+4 moves the window to
T+5 … T+12 ✓. **A miss costs exactly as long as a hit**, which is what keeps
M13's Q+2 constant class-independent.

**SPEC-M13 — response at Q + 2, uniform across all five classes.** Stage 0 at Q
evaluates the class and, for classes 4 and 5 only, presents `cache_query`;
M12 answers at Q+1 (SPEC-M12 §7's one cycle, re-derived above); M13 registers
and drives at Q+2. Classes 1–3 are computed at Q and *delayed* to Q+2. The
uniformity is the right call and the reason given is the right reason: a
class-dependent delay would make M15's timing a function of the network
configuration. **The observability argument is the sharpest thing in batch D**:
for classes 1–3 `cache_query_valid` = 0 at M12's port, so "without consulting
the cache" is checked rather than assumed — REQ-508 and REQ-509 become
assertable instead of aspirational.

**SPEC-M13 — REQ-502 derived at 6 cycles.** Every term recomputed against the
specification that pins it, at a lane-0 start:

| Cycle | Event | Term checked |
|---|---|---|
| 0 | request's start character | stimulus |
| 3 | M03 output word 0 | SPEC-M03 §7 ΔC = 3 (lane 0), ceiling 4 ✓ |
| 5 / 6 | M06 `hdr_valid` / payload word 0 | SPEC-M06 §7 ΔC = 3 ✓, one-cycle header lead ✓ |
| 6 / 7 | M08 `arp_hdr_valid` / payload word 0 | SPEC-M08 §7 ΔC = 1 ✓ |
| 6 / 7 | the same at M10's ports | M13 relay ΔC = 0 ✓ |
| **9** | request's terminate character | 8 preamble octets in cycle 0, frame octets 0–63 in cycles 1–8, `/T/` in lane 0 of cycle 9 — SPEC-M03's own 64-octet table ✓ |
| 11 | M10 `arp_valid` | Cp + 4 with Cp = 7 ✓ |
| 12 | M13 offers the reply; M11 accepts | §6.1 rule 1 + M11 §6.2 `Idle` ✓ |
| 13 | M11 offers header + word 0; M09 grants; M07 accepts | M11 ΔC = 1 ✓, M09 ΔC = 0 ✓ |
| 14 | M07 output word 0; M04 accepts | M07 ΔC = 1 ✓ |
| **15** | reply's start character | SPEC-M04 §6.1: a word accepted at C puts the preamble word at C+1 ✓ |

15 − 9 = **6 cycles** against REQ-502's 64. The derivation is sound and every
term is another specification's committed constant, which is exactly what makes
it a derivation rather than a prediction. The one soft spot is where the
measurement *starts* — **C-24 in the list below is folded into C-23's row as an
editorial note rather than raised separately**; see C-23.

**Other SPEC-M13 arithmetic, all confirmed.** Multicast: `mac`[47:24] =
0x01005E, `mac`[23] = 0, `mac`[22:0] = `d`[22:0]; 239.1.2.3 = 0xEF010203 →
01:00:5E:01:02:03 ✓; 239.129.2.3 = 0xEF810203 has bit 23 set and maps to the
same MAC ✓ — which is the case REQ-509's verification column says "actually
exercises the 23-bit mask". Class precedence matches REQ-507's order exactly ✓.
Retry: `retry_count` = n gives at most n + 1 requests, §8's run at n = 4 expects
5 ✓, interval measured from M11's **acceptance** so a busy M11 does not shorten
it ✓. Defaults: 156 250 000 cycles = 1.0 s and 3 125 000 000 = 20 s at
156.25 MHz ✓, both inside the stated 1 … 2^32 − 1 range ✓.

**Architect bookkeeping, recomputed mechanically.** architecture.md §6.4's edge
table: **117 rows — 26 rx, 40 tx, 29 control, 22 status**, counted by strict row
shape (the 41st `tx` occurrence is the amended row quoted inside §6.4's own
prose, not a table row). traceability.md: REQ id sets of requirements.md and
traceability.md both **110**, symmetric difference **empty**, 110 row lines and
no duplicate. Both claims hold.

---

#### 3. Owed diffs — what blocks the countersignature

##### D-1 (blocking) — the ARP module retains **two** replies where REQ-510 says one, and three verification hooks commission a strobe a conformant design does not pulse

**The mechanism, traced port by port.** SPEC-M11 §6.2's `Idle` row asserts
`arp_ready` = 1 **unconditionally** — it does not depend on `payload_tready`,
and §6.1's unstalled table and §7's reset clause confirm the only thing that
holds it low is `clear` or M11 already holding a packet. SPEC-M13 §6.2 machine
(A) leaves `Pending` "on the cycle M11 accepts the reply", and §6.1 defines a
reply as pending "from the cycle it is generated until the cycle M11 accepts
it". Therefore, with the transmit path blocked and M11 idle:

- reply 1 is generated, offered, and **accepted by M11 on the same cycle**;
  M13's machine (A) returns to `Idle`. Reply 1 now sits in M11's held `Offer`;
- reply 2 is generated; M11's `arp_ready` is now 0; machine (A) enters
  `Pending` and **stays** there. No strobe;
- reply 3 is the first one dropped.

**The ARP module therefore holds two replies, not one**, and every count in the
programme that turns on this is off by exactly one:

| Where | Says | A conformant design does |
|---|---|---|
| SPEC-M13 §8 item 2 | hold M09 busy, inject **two** back-to-back requests, "assert exactly one `error_arp_reply_dropped` pulse" | pulses **zero** |
| SPEC-M13 §10, REQ-810 row | "`cfg_tx_enable` = 0, inject **two** requests, assert one `error_arp_reply_dropped`" | pulses **zero**; and on re-enable **both** replies transmit, not just the first |
| requirements.md REQ-510 verification | "injecting **two** back-to-back ARP requests; check exactly one strobe pulse" | pulses **zero** |
| requirements.md REQ-510 normative | "The ARP module SHALL hold at most **one** pending reply" | holds two |

REQ-208's verification survives (at the REQ-004 arrival rate a third reply
always arrives, so the strobe does fire) — but it survives by luck of stimulus,
not by the rule it cites.

**Why this is a contest and not a carry-forward.** At WO-0010 and WO-0013 I
signed six findings of the "would fail a conformant design" class, each time on
the same ground: *a normative section of the same document stated the correct
reading*. Here no section states it. The correct behaviour must be **derived**
by composing SPEC-M13 §6.1's pending definition with SPEC-M11 §6.2's `Idle`
row, and the wrong count is stated three times across two documents, one of
which is a requirement's own normative sentence. That is the line.

**Two acceptable repairs. The choice is the architect's; the divergence must
close.**

- **R-1 (recommended).** Extend M13's pending window from *M11's acceptance of
  the record* to *the completion of the reply's frame* — the cycle M11's payload
  `tlast` word is accepted, which M13 already observes on `tx_payload_tready`
  and M11's `payload` without any new port. Machine (A) gains one state (or
  `Pending`'s exit condition changes); §6.1's pending paragraph changes one
  clause. **Cost: no port, no record field, no requirements diff.** REQ-510's
  normative sentence becomes literally true of the ARP module, and §8 item 2,
  §10's two hooks and REQ-510's verification column all become correct **as
  written**. I checked it costs nothing in the unblocked case: two accepted
  requests for `cfg_local_ip` are ≥ 10 cycles apart (REQ-004's own spacing), and
  R-1's pending window when unblocked is 5 cycles, so no reply that is sent
  today would be dropped under R-1.
- **R-2.** Keep the mechanism and fix the counts: requirements.md REQ-510's
  normative sentence and verification column, SPEC-M13 §8 item 2, §10's REQ-510
  and REQ-810 rows and §11.2 all move from two to three, and REQ-510's first
  sentence becomes "at most one reply pending at the resolver and at most one
  further reply already accepted for transmission". I judge this worse: it
  weakens a normative ERR requirement to match a decomposition, and it leaves
  the module holding a stale reply two deep.

##### D-2 (blocking) — REQ-013's "the ultimate consumer must discard it" is discharged by nobody on the ARP branch

This is SPEC-M10 §11.3, the architect's Q2, and my answer to it is in §4 below.
The blocking part is structural: §11.3's **Closes by** is this countersignature,
and I am declining to close it in the affirmative, so SPEC-M10 cannot freeze
carrying it (SPEC-TEMPLATE §11 — a FROZEN spec SHALL carry no open question,
and an item whose closing gate has arrived and been refused is open).

**Two acceptable repairs.**

- **D-2a (recommended).** M13 gates the REQ-503 learning write, and the reply,
  on `rx_payload_tuser`[0] = 0 for that packet, observed on the packet's payload
  `tlast` word — **a port M13 already owns**, because it relays `rx_payload`
  into M10. The learning write moves from `arp_valid` + 1 to the packet's
  payload `tlast` + 1 (bounded by REQ-015's 188-word frame). REQ-503 gains the
  qualifier "accepted (REQ-501) **and not marked invalid (REQ-013)**". **Cost:
  no new port anywhere, no new `Arp_packet` field, no change to M10's ports or
  to its pinned constant** — M10 continues to ignore the bit and continues to
  report at Cp + 4.
- **D-2b (minimum).** Keep the behaviour, but convert §11.3 from a deferral into
  a **decision**: state that the ARP branch has no ultimate consumer, cite
  REQ-013's first clause rather than only its "solely" clause, state the
  consequence in the words below, and add the corresponding exemption sentence
  to requirements.md REQ-013 so the gap is a recorded programme decision rather
  than an unclosed §11 item at freeze.

**§11.3's cost estimate is wrong in a way that matters, and correcting it is
half the answer.** It says the repair needs "a new `Arp_packet` field". It
cannot: the bit arrives on the payload `tlast` word, which §7 correctly shows is
two or more cycles **after** the record is emitted, so no field of that record
can carry it. Read literally, §11.3 prices the repair as a post-freeze record
addition — i.e. as breaking — and that price is what would otherwise force this
decision under gate pressure. The real repair (D-2a) touches no interface at
all. **The architect should correct that sentence whichever repair is chosen**,
because a wrong cost estimate in a deferred item is how a decision gets made for
the wrong reason later.

##### Consequential (land with D-1/D-2, not separately contested)

- SPEC-M10 §2's "Acting on the inherited abort bit — **nobody** at this stage"
  row and §11.3 both move under D-2a (the owner becomes M13).
- All five §11 items whose **Closes by** is this countersignature must record
  their closure in place (SPEC-TEMPLATE §11: "a closed item keeps its number and
  its row, with the closure recorded in place"): SPEC-M10 §11.3, SPEC-M11 §11.3,
  SPEC-M12 §11.3, SPEC-M13 §11.2, SPEC-M13 §11.3. **This diff is owed
  regardless of my verdicts**, which is why folding the carry-forwards below
  into the same cycle costs nothing.
- The four §12 `Interface compile check` rows may be filled from run
  **30736107842** / **success** / **2f29888**, and the four §11.1 items closed.

---

#### 4. The architect's questions, answered by name

##### Q1 — SPEC-M11 §11.3: instantiation or supersession? → **INSTANTIATION. No ADR-0008 amendment is owed. §11.3 closes affirmatively.**

ADR-0008's Context states its own problem in one sentence: "what is a
transmit-side header record's acceptance event, **given a record that cannot
carry a `ready`**?" That problem does not arise at M11's `arp` port, because the
`Arp_packet` on the M13 → M11 edge **does** have a native acceptance event —
`arp_ready` is a real output bit in §4.1's `O`, not a field of a record M01
froze. So M11's `arp` port is not a case the ADR governs and then departs from;
it is a case that never needed the ADR's device.

What the ADR contributes there is decisions 2 and 3's *discipline* — hold every
field stable until acceptance, consumer captures on the acceptance cycle, source
may drop `valid` after — which is the ordinary valid/ready contract the ADR
**specialises** for records lacking a `ready`. Applying it against a native
`ready` is the general case, not a substitution. Decisions 1 and 4 are
statements about a header record travelling with a payload stream; neither has
an instance at a port carrying a record and nothing else, and §7 is right to
claim neither rather than to reinterpret them.

Two confirmations I ran rather than assumed. **The substitution is
two-sided**: SPEC-M13 §7's closing bullet states M13's half ("`arp_valid` and
all five fields held stable until `arp_ready` = 1"), so a bench has both sides
of the contract and can monitor the port without inventing either. **And it is
consistent with the state tables**: §6.2's `Idle` → `Offer` transition fires on
`arp_valid` = 1 and `arp_ready` = 1 and captures there, which is decision 3's
capture rule against the substituted event, exactly.

**My monitor is the artifact at stake, and here is what it costs me.**
ADR-0008's Consequences say "the DV cost is one monitor parameter, not two
monitors" — the discipline taken from the port's direction. Batch D adds a
**third** case that direction alone does not select: a record with a native
`ready`, which is neither the receive-side one-cycle pulse nor the transmit-side
level-held-until-first-payload-word. That is machinery work in `test/monitors/`,
mine, not a spec diff, and SPEC-M11 §7 plus SPEC-M13 §7 give me everything I
need to build it. Recorded as a DV action, not as a finding.

##### Q2 — SPEC-M10 §11.3: accept the meanwhile reading, or raise a diff? → **DO NOT ACCEPT AS FINAL. This is D-2, and the repair is far cheaper than §11.3 prices it.**

REQ-013's first clause is normative about what the bit *means*: "`tuser`[0]
SHALL mean 'this frame was found invalid; **the ultimate consumer must discard
it**'", and it closes "it is advisory metadata carried to the application".
REQ-707 shows the programme's pattern working as intended on the UDP path: the
application receive stream carries `tuser`[0] to the application, which is the
ultimate consumer and discards.

**The ARP branch is the one receive branch with no application.** The mark is
generated by REQ-104 at M03, relayed through M06, M08 and M13, ignored by M10 by
design, and consumed by **nobody**. §11.3 cites only REQ-013's "solely" clause —
which is a prohibition on *forwarding* modules and is not in question — and does
not cite the clause that names a consumer. REQ-501's silence is not evidence
either way: REQ-501 is about ARP packet validity, and the FCS is not an ARP
field.

**What the meanwhile reading actually commits the programme to.** A single
corrupt frame whose corruption landed in the ARP fields writes a wrong IP → MAC
binding into a cache that holds it for `entry_lifetime_cycles` — 20 s at the
default — during which every datagram to that IP leaves with a wrong destination
MAC and is dropped by the switch, **with no strobe naming the cause**. That is
persistent state committed from a frame the programme has already declared
invalid, and it is the kind of thing that surfaces as a replay divergence three
phases later with nobody able to name its origin.

I am not ruling on the design; I am ruling that this cannot be *closed* in the
affirmative at a freeze gate on a cost estimate that is wrong. Correct the
estimate (D-2 above: no port, no record field, because M13 already owns
`rx_payload_tuser`), then decide on merit. If the programme decides to keep the
behaviour, D-2b makes it a recorded decision, which is a legitimate close.

##### Q3 — SPEC-M13 §11.2: REQ-810's ARP clause. → **CONSEQUENCE CLAUSE, NOT AN INDEPENDENT OBLIGATION. No `cfg_tx_enable` at M13. NOT BREAKING. §11.2 closes affirmatively.** Answered decisively, as the packet required.

Three grounds, in order of weight.

1. **REQ-810's own verification column does not test it.** It reads: "Drive
   `transmit enable` = 0 and issue an application transmit request: assert no
   start character appears on XGMII and `tready` stays low; re-enable and check
   the frame transmits." Not one word about ARP replies or about
   `error_arp_reply_dropped`. Under §0.2 — "one REQ states one testable fact" —
   the verification column is where a REQ's testable fact lives. A clause with
   no test in its own column, in a document whose every other clause has one, is
   an explanatory pointer, and this one points explicitly: "is dropped **under
   REQ-510**". It names the governing requirement instead of stating a rule.
2. **The alternative does not actually work as a port addition.** Giving M13
   `cfg_tx_enable` cannot retract a reply already inside M11, so reading (B)
   would need either a second port at M11 or a rule that M13 refuses to
   *generate* while disabled — a larger change than "one input", and one that
   would have to be re-derived for M15 and M18 in batches E and F.
3. **The residual hazard is nil.** A late ARP reply carries our own MAC for our
   own IP. It cannot go stale in the way a buffered *datagram* can — which is
   what architecture.md §2.5 and REQ-505 exist to prevent — so there is no
   correctness argument for spending a breaking port addition on it.

**And R-1 closes most of the gap for free**, which is why I can answer this one
without hedging: under D-1's recommended repair, with transmit disabled
**exactly one** reply survives (held inside M11) and every later reply is
dropped with `error_arp_reply_dropped`. That is REQ-810's plain reading minus a
single frame, obtained with no port. The residual is stated here so nobody can
later say it was hidden: **the first reply generated while transmit is disabled
is transmitted, late, when transmit is re-enabled.**

The architect should also repair REQ-810's clause wording so the text matches
the mechanism — "an ARP reply generated meanwhile is dropped under REQ-510" is
false of the first one. requirements.md is DRAFT with a live §13 revision
record, so this is editorial and cheap; I do **not** make it blocking.

##### Q4 — SPEC-M13 §11.3: a miss for a different target replaces the outstanding resolution. → **SPECIFICATION DECISION, correctly made and correctly placed. No requirements.md diff owed. §11.3 closes affirmatively, with one sentence added.**

REQ-505's testable fact is duplicate suppression for the **same** target; a
different-target rule is a second fact and would need its own REQ, so REQ-505's
silence is correct scope rather than omission (§0.2). The programme already has
the device for this: every spec's §6.3 opens "anything not listed here is
constrained by this specification, and a test may rely on it", which is exactly
what a spec-level decision on an unconstrained corner is. And the decision is
fully derivable — §6.2 machine (B)'s three rows are complete for it, and §6.3
item 4 states explicitly that which target ends up outstanding is *constrained*,
not free.

**The one sentence I require added, because a bench writer needs it and it is
not in the document.** Replacement means an application alternating between two
unresolved destinations defeats REQ-505's suppression entirely: every miss
replaces the outstanding target, so **every miss issues a request**, bounded
only by M11's five-cycle packet period. That is not a defect in Phase 1 —
architecture.md §5 has one application client and REQ-505's and REQ-809's
stimuli each use one destination — but a test writer who sees one broadcast
request per datagram must be able to tell that it is conformant, and §11.3's
rejected-alternative paragraph is the natural home for it. It is also the
precise trigger for revisiting the per-slot table: **more than one concurrent
application destination**, which is a Phase-2/3 condition, not a Phase-1 one.

##### Q5 (not in the packet, but its closing gate is this countersignature) — SPEC-M12 §11.3: REQ-506 owned in two halves → **AGREED. No requirements.md diff owed. §11.3 closes affirmatively.**

REQ-506 states its clauses separably — retry count and interval govern
unanswered requests, entry lifetime governs entries — and the split falls on
that seam. Verified mechanically: `traceability.md`'s REQ-506 row lists
`M12 Arp_cache, M13 Arp` with `SPEC-M12 §5, §6.1 (ageing); SPEC-M13 §5, §6.2
(retry)`. Both specs name their half **and disclaim the other's** in §5 and in
their §10 tables, so a sign-off packet can show the whole requirement covered
with neither module claiming the other's part and neither leaving a hole. This
is the pattern I want batches E and F to copy.

---

#### 5. Ledger — C-6, C-15, C-16, C-17, C-18 reaffirmed; C-19 … C-23 raised

**Every one of the five transcribed closures is REAFFIRMED.** I checked each at
its landing site rather than at the Return log's description of it.

| id | Verdict | What I checked |
|---|---|---|
| **C-6** | **REAFFIRMED** | SPEC-M10 §8's four criteria are REQ-004's four in parsed-fields form and criterion 2 is genuinely *stronger* than an octet comparison — it also asserts REQ-012's decode and the word-boundary crossing at ARP octets 14–17. Criterion 3 quotes ΔC = 4 against "no ceiling", which I re-derived above. Criterion 1 needs **C-2**'s `clear` exemption to be exact; see C-21 |
| **C-15** | **REAFFIRMED** | My clause is applied verbatim in requirements.md §0.5's "Latency" paragraph, with the observed failure recorded in place. The definition and its start-lane exception now travel in the same sentence, which was the whole finding. My oldest unrepaired item is closed |
| **C-16** | **REAFFIRMED** | SPEC-M04 §7 pins `tx_tready` = 1 at C+8 and states four consequences. Three are the derivation I supplied at WO-0013; the fourth — that the C+8 and C+11 acceptances cannot both fill both storage slots — I did **not** supply, and I re-derived and confirm it. §10's REQ-209 hook now forbids both wrong assertions (0 at C+11 and 0 at C+8) |
| **C-17(a)** | **REAFFIRMED** | M + 2 ∈ {K, K + 1}; both directions now derived side by side, and the failing stimulus (any length that is a multiple of 8, §8's own 60-octet frame included) is named in the text |
| **C-17(b)** | **REAFFIRMED** | W − J + 1 in all five places. The repair does the thing I wanted but did not ask for: it separates the *word surplus* (W − J, correctly 1 or 2) from the *stall count* (W − J + 1, 2 or 3), because conflating them is what produced the error |
| **C-17(c)** | **REAFFIRMED** | Withdrawn rather than completed, which is the disposition I asked for and the right one: completing it would have specified output timing for a stimulus the programme has decided not to generate. §6.3 item 5 uses SPEC-M07 §6.3 item 3's wording exactly |
| **C-17(d)** | **REAFFIRMED, and the placement judgement is CORRECT — against my own offer of either home** | I offered SPEC-M07 §7 or ADR-0008; the architect chose the ADR because the rule binds M11, M15 and M18 too. Batch D vindicates that at the first opportunity: SPEC-M11 §7 and SPEC-M13 §7 both discharge it **by reference** and restate nothing, where a sentence in SPEC-M07 §7 would have had to be copied into both and into two more specs later. The bullet's own wording has a defect — **C-22**, and it is mine |
| **C-17(e)** | **REAFFIRMED** | Re-derived by enumeration: lengths 14 … 21 give payloads 0 … 7; payload 0 emits no payload word and therefore no `tkeep`; `0xFF` needs a positive multiple of 8, i.e. **N = 22**. The residue claim and the pattern claim are now separated, which is what hid the gap |
| **C-18** | **REAFFIRMED, and the undisclosed twin was correctly moved** | "Gapless" is now defined in octet times and the definition is satisfiable; both non-instances are stated with their `octet_count` values; §6.2's `Frame` row states that a word covering ≥ 1 frame octet is never held. §3's REQ-016 row carried the same wrong example and I did **not** cite it — the architect found it and moved it in the same diff, which is the correct disposition and is disclosed as such |

**New carry-forwards. None blocking; each bound to the moment it must close.**

| id | Item | Must land before |
|---|---|---|
| **C-19** | **SPEC-M11 §8 item 2's M10 loopback cannot be built as written, and as written it fails a conformant pair.** With `payload_tready` held 1, M11 asserts `hdr_valid` and payload word 0 on the **same** cycle (ADR-0008 decision 1) and drops `hdr_valid` the next — a zero-lead producer. SPEC-M10 §6.1 defines Cp as "the first cycle **after** the opening `hdr_valid` pulse with `payload_tvalid` = 1", so M10 would take M11's word **1** as its word 0, count 20 delivered octets, and pulse `error_arp_unsupported` — the exact opposite of what §8 item 2 asserts. The repair is one sentence in §8 item 2: the loopback presents `hdr_valid` **one cycle before** payload word 0, as M08 does, converting the transmit-side offer into the receive-side discipline M10's producer contract assumes. Do **not** widen M10's Cp instead — that would commission behaviour for a stimulus no producer emits, which is what C-17(c) withdrew at M08 | `test/attack_plans/AP-arp_eth_tx.md` and the M11 tb_writer `WO-` |
| **C-20** | **SPEC-M10 §6.3 item 4's word-0 constant is wrong under both readings its own sentence supports, and it is a 64-bit literal assigned to a 48-bit slice.** It says "`payload_tdata`[47:0] = 0x000406000800_0001 read in wire order is the whole check". As a numeric value under REQ-012 the pattern is **0x0406_0008_0100** (positions 5…0 = 04, 06, 00, 08, 01, 00); as a wire octet string ARP octets 0–5 are **00 01 08 00 06 04**, so even the generous "read in wire order" reading gives 0x000108000604. The written value is neither — it is not even a permutation of the correct octets. SPEC-M11 §6.1's word-0 row states the same pattern **correctly**, so the two batch-D tables disagree and M11's is right. The governing statement is SPEC-M10 §6.1's field table, which is correct; §6.3 is the *unconstrained* list, so a careful reader takes no stimulus from it — which is why this is a carry-forward and not a contest. Full word 0 for a request: **0x0100_0406_0008_0100** | `test/attack_plans/AP-arp_eth_rx.md` and the M10 tb_writer `WO-` |
| **C-21** | **SPEC-M10 §6.1's "exactly once … never both, and never neither" does not except the one case §3, §6.2 and §7 all mandate.** §6.1's closure list includes `clear`, and the report rule keys on "the event that closed the packet", so read alone it commissions a report at `clear` + 1; §7 states "no record and **no strobe**", §6.2's `Parse`/`Tail` rows say the same, and §7's reset clause forecloses the pulse mechanically. One clause in §6.1 fixes it. The sharper half is that **§8 criterion 1's "reports = packets opened" is requirements.md §0.6's conservation equation instantiated at M10's ports, and §0.6 says that monitor is active in *every* bench** — including §10's commissioned mid-packet `clear` test, where it would count an opened packet with no report as a silent discard. That is ledger **C-2**'s exemption becoming load-bearing for the first time, at M10; SPEC-M12 §7 states the analogous exemption for a query lost to `clear` and is the model | C-2's own gate (first `SO-` packet); the §6.1 clause before `AP-arp_eth_rx.md` |
| **C-22** | **ADR-0008's C-17(d) Consequences bullet and SPEC-M11 §6.1 disagree about what a monitor may assert, and the bullet is mine.** The ADR says a monitor "**SHALL NOT** assert that `valid` falls after acceptance"; SPEC-M11 §6.1 says "M11 may drop `hdr_valid` on the next cycle **and does**", and §6.2's `Body` row makes it normative. Nothing says which governs. Resolution I ask for, one clause on the ADR bullet: the prohibition binds a monitor built from the ADR alone, **unless the source's own specification commits to a stronger discipline, in which case that specification's cycle table governs a monitor attached to that source**. This is the second time a repair of one of my own findings has carried a defect (C-18 was the first), and I record it that way deliberately | the first transmit-side tb_writer `WO-` (M07, M09 or M11) |
| **C-23** | **M13 is the first module in this programme whose strobe can legitimately be high on consecutive cycles, and nothing states the counting convention.** `tx_query` accepts one query per cycle (§7) and back-to-back queries produce back-to-back responses (§6.2 (C)), so §8 item 1's 100 missing queries can drive `error_arp_miss` high for 100 consecutive cycles — while requirements.md §0.6 says "a strobe SHALL pulse for exactly one cycle" and §8 item 1 asserts "**100** pulses". A monitor counting rising edges sees **1** and fails a conformant design; one counting high cycles sees 100. One sentence in §0.6 (it generalises) or in SPEC-M13 §9: the observable is one high cycle per reported event, consecutive events give consecutive high cycles, and a monitor counts high cycles rather than edges. **Folded in as an editorial note**: REQ-502's measurement start, "the cycle carrying the request's last XGMII word", is ambiguous between the last word carrying frame octets (cycle 8) and the terminate word (cycle 9); SPEC-M13 §6.1 picks cycle 9 and derives 6, the other reading gives 7, both far inside the 64-cycle bound — but a latency report will quote one of them and should not have to choose | before `AP-arp.md`; the REQ-502 half before any `docs/reports/latency/` artifact quotes it |

**Still open and unchanged**: C-2, C-3, C-5, C-7, C-9's REQ-903 half. C-15 is
now closed, so C-2 becomes my oldest unrepaired finding, and C-21 is the first
place it bites concretely.

---

#### 6. Readings this return fixes, below carry-forward threshold

Recorded so they are not rediscovered, and so nobody mistakes silence for
agreement. None of these commissions a failing assertion.

1. **SPEC-M10 §8**: "six of those cycles carry payload words and one carries the
   header pulse" reads as 7 occupied cycles in a 10/11-cycle window, which would
   give 3 and 4 idle cycles. The operative figure — "**4 and 5** idle cycles
   alternately" — is the correct one, counted on the payload stream, and the
   header pulse falls inside that idle run one cycle before payload word 0.
2. **SPEC-M10 §6.1**: "the report cycle is a function of the packet's length
   alone" is exact only for a packet closed by its own `tlast`; a packet closed
   by the next `hdr_valid` has a report cycle that is a function of the *next*
   frame's arrival. The load-bearing half — "a bench computes it without
   decoding the fields" — is true in every case.
3. **SPEC-M11 §3, REQ-015**: "exactly four words between two `tlast` words"
   reads as four *intervening* words; the count is four words **per packet**,
   `tlast` included, which is what §6.1's table and §10's REQ-015 hook both say.
4. **SPEC-M13 §6.1**: "what makes 255.255.255.255 class 1 rather than class 5
   **when the mask is 0**" — with m = 0 every destination satisfies class 4's
   test, so the competitor is class 4, not class 5. The substance is right (with
   an ordinary mask, 255.255.255.255 would fall to class 5); the stated
   condition is the wrong one.
5. **SPEC-M13 §8 item 1 / REQ-505**: the composed run produces **101**
   `error_arp_miss` pulses and 101 responses — one for the initial datagram plus
   100 for the further ones. Both texts are consistent under the word "further";
   a bench counting over the whole run must not assert 100.
6. **SPEC-M12 §6.1**, collision table row 5: nested bold markers around
   `hit` = **0** render badly. Cosmetic.

---

#### 7. DV actions this review created for me

1. **A third header-record monitor case** (Q1): a record with a native `ready`,
   selected by neither of ADR-0008's two disciplines. `test/monitors/`, mine.
2. **A strobe-counting convention** in the conservation and protocol monitors
   (C-23): high cycles, not rising edges, with the per-strobe histogram
   REQ-008(a) and REQ-804 need built on that basis.
3. **`AP-arp_eth_rx.md` rows** for every REQ-501 rejection class, the
   two-criteria-at-once packet, the payload-less frame, and the `clear`
   mid-packet case whose conservation exemption is C-21.
4. **`AP-arp_cache.md`** is derivable today and needs nothing from the architect
   — SPEC-M12 is the first batch-D spec I can write an attack plan against on
   the strength of its own text alone.
5. **`AP-arp.md`'s REQ-510 rows are blocked on D-1** and will say so rather than
   route around it with a carefully chosen request count.

---

#### 8. The countersignature

**Not granted at a9993ff.** The sentence for the orchestrator to transcribe once
D-1 and D-2 land, given verbatim so the next acceptance needs no round trip on
wording:

> **I countersign batch D (SPEC-M10, SPEC-M11, SPEC-M12, SPEC-M13) for
> P1-spec-freeze at `<SHA of the commit carrying the D-1 and D-2 diffs>`.**

**What that re-review will and will not re-do.** It will re-check D-1 and D-2 at
their landing sites, re-run the byte-identity and set-equality checks, and
confirm a green `ifc_check` run at the new SHA. It will **not** re-derive the
arithmetic of §2 above — L, h, ΔC for M10 and M11, M12's index function and both
ordering rules, M13's Q + 2 and the six-cycle REQ-502 chain are recomputed,
correct, and signed off here, and they do not move under either repair. Nor will
it revisit Q1, Q3, Q4 or Q5, which are answered and closed. That is stated so
the architect knows the surface of the re-review before choosing between R-1 and
R-2, and D-2a and D-2b.
