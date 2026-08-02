# WO-0019: Batch F specifications (M17–M20, the last four) + closeout diffs
- **State**: RETURNED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 rows M17–M20 and §8 batch F; the
  FROZEN batches A–E (D and E countersigned at 3f6accc, J-dv_lead-0009,
  WO-0018 — the gate checklist records both flips); the WO-0018 Return
  log (dv's five answers and C-24…C-30, your primary input for the
  diff set); the WO-0016 Return log §5 (rtl_lead's two conventions
  questions); requirements.md UDP + top-level blocks; ADR-0008/0009.
- **Deliverables**, in order:
  1. **Batch-D/E spec Status-line flips** (the batch-C precedent, done
     at WO-0014): SPEC-M10…M13 and SPEC-M14…M16 flip from DRAFT to
     **FROZEN at 3f6accc**, each §12 completed — batch D's four rows
     already carry run 30736107842/2f29888; batch E's three rows fill
     with run **30739442056 / success / 3f6accc** (head SHA = spec
     commit, no witnessing sentence owed) and their §11.1 items close.
     dv countersignature reference: `J-dv_lead-0009` for both batches.
  2. **The C-24…C-30 diff set** (each now a §13-recorded spec diff on
     frozen text — none touches a §4.1 lift; full statements in the
     WO-0018 Return log §5): C-24 (REQ-502's figure becomes "7 or 8 by
     residue" in SPEC-M13 §6.1/§7 and REQ-502's verification column);
     C-25 (the "later of" branch: five lengths not one, 46–50-octet
     pricing, and the §6.2 (D) stage-model note); C-26 (M14 §9
     truncation branch goes extensional per REQ-605 + the `Header`
     row's Idle-list addition for the zero-payload-octets case); C-27
     (M14 §7 scopes the parse-latency constant to gap-free headers;
     §10's REQ-016 hook names L); C-28 (M13's REQ-505 header gains
     "(the strobe and request half)", §10 row gains the disclaimer,
     §8 item 1 names its assertion level); C-29 (M16 §7's transmit
     anchor: 1 cycle after M15 emits, 2 after acceptance); C-30 (M14
     §8 gains the `clear` conservation exemption, M10 §8's new
     paragraph as the wording model). dv's answer (iii) also asks one
     scoping sentence so M17 copies the independent-evaluation rule.
  3. **Answers to rtl_lead's two conventions questions** (WO-0016
     Return log §5; both block batch-B RTL issuance): (a) is
     `open! Axi64` the house consumer convention for the `Axi64.Axi64`
     nesting — rtl_lead proposes yes; state it normatively where
     future rtl_module_dev packets can cite it (SPEC-M01 §4
     conformance note or an ADR, your call); (b) should SPEC-M02's
     `module type S` exist as a named library artifact (e.g. for
     functorising M03/M04 over the CRC engine)? Decide and record.
  4. **SPEC-M17 (`Udp_ip_rx_64` — UDP parse/length checks/port
     filter/realignment, REQ-701–704/707/021), SPEC-M18
     (`Udp_ip_tx_64` — UDP header construction, REQ-705/706/709; the
     parked REQ-810 tready semantics question from the board resolves
     here or is explicitly §11'd), SPEC-M19 (`Udp_complete_64` —
     structural, M16+M17+M18, REQ-708), SPEC-M20 (`Nic_top` — Phase-1
     top, M05+M19, config/status aggregation, application streams,
     REQ-801–809 + REQ-006's end-to-end budget)**: DRAFT,
     template-complete, lifts byte-identical, declare-once records,
     the REQ-506 two-half pattern where REQs span modules (note C-28's
     tiling lesson: name the half in the header AND disclaim in §10).
     M20 §1.1: the receive-chain budget closes here — the five-stage
     allocation 4/3/1/5/4 = 17 of 24 plus M14's reserve; state the
     end-to-end derivation. M17 copies M14's independent-evaluation
     rule with dv's scoping sentence. ADR-0008 binds M18's header
     handshake (restate source obligations as SPEC-M11/M15 did).
  5. traceability.md rows for batch F; set equality survives —
     after this batch every REQ row names its owning spec.
  - Journal **J-architect_docs_lead-0008**; Files-in-this-commit =
    exactly what you touch plus this packet. Return log with per-item
    dispositions and the two conventions answers stated for rtl_lead.
- **Definition of done**: D/E flips + §12 fills recorded; C-24…C-30
  landed as §13-recorded diffs; both conventions questions answered;
  four batch-F specs template-complete; set equality holds; the
  20-module inventory fully drafted.
- **Out of scope**: RTL (`libs/**`); tests; `test/**`, `tools/**`;
  `docs/gates/` (orchestrator transcribes).
## Task
The last spec batch. When this returns and dv countersigns it, all
twenty Phase-1 specifications are FROZEN and the P1-spec-freeze gate
needs exactly one thing: the sponsor's signature.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-02T13:10Z, journal `J-architect_docs_lead-0008`

**All five deliverables are complete. Twenty of twenty Phase-1 specifications now
exist**; sixteen are FROZEN at their SHAs and four are DRAFT awaiting a green
`ifc_check` run and dv_lead's batch-F countersignature. `traceability.md` has no
`pending` cell left, REQ set equality holds at 110 = 110, and
`tools/check_records_vs_appendix.sh` passes 23 checks with the four new lifts in
it.

Two things in this return are larger than the packet asked for and are flagged at
the top rather than buried: **ADR-0011**, which records a hole in REQ-709's
composed path that writing SPEC-M18 exposed, and the **`cfg_tx_enable → M18`
edge**, which is the one architecture.md amendment this batch makes. Both are
argued in full below and both are the items I most want dv_lead's
countersignature to test.

---

#### 1. Batch-D and batch-E flips, §12 fills, §11.1 closures

**Seven Status lines flipped to FROZEN**, four at batch D and three at batch E,
all at **`3f6accc`**, all citing `J-dv_lead-0009` (WO-0018):

| Spec | §12 compile evidence | §12 countersignature row |
|---|---|---|
| SPEC-M10, M11, M12, M13 | run **30736107842** / `success` / **2f29888** (kept, as the packet directed) **plus** run **30739442056** / `success` / **3f6accc** appended to each row | `J-dv_lead-0009`, batch D COUNTERSIGNED at 3f6accc |
| SPEC-M14, M15, M16 | run **30739442056** / `success` / **3f6accc**, filled | `J-dv_lead-0009`, batch E COUNTERSIGNED at 3f6accc |

**One thing I added to batch D's four rows and want on the record.** The packet
said batch D's rows "already carry run 30736107842/2f29888" and to leave them.
I left them and **appended** the 3f6accc run to each, because 2f29888 is not the
freeze SHA: those four rows would otherwise have carried compile evidence for a
tree two commits before the one the Status line names, resting on a
`git diff … -- docs/specs/` emptiness argument. dv_lead verified run 30739442056
at 3f6accc through the GitHub API and confirmed every lift elaborates in it
(`J-dv_lead-0009` §0), so the frozen text now has compile evidence **at its own
SHA** on all seven rows and no witnessing argument is owed anywhere in batches D
and E. This is strictly more evidence, not different evidence.

**§11.1 closed at SPEC-M14, M15 and M16** on that run. Batch D's four §11.1 rows
were already CLOSED at WO-0017.

**Eleven further deferred items closed**, every one whose "Closes by" cell named
SPEC-M20, SPEC-M18 or batch F. Leaving them open would have been the cheap move
and the wrong one — a closing gate that arrives and is not honoured is how a
deferred-item table stops meaning anything:

| Item | Disposition |
|---|---|
| SPEC-M10 §11.2, SPEC-M13 §11.5 | **CLOSED affirmatively.** `Arp_packet`, `Arp_query` and `Arp_response` stay outside M01. SPEC-M20 was the moment named for promoting them and declines it: a post-freeze §4.1 diff to the spec five freeze records cite, for a rename that changes no behaviour, no port name and no emitted Verilog. Batch F extended the rule instead (`Udp_tx_request` at SPEC-M18) |
| SPEC-M10 §11.4, SPEC-M06 §11.3 | **CLOSED affirmatively.** Batch F found no consumer needing the pulse/level discipline carried in the type. Four records, no exception; `Udp_header` turns out to have a receive discipline and **no transmit instance at all**, because M18 builds its header from a `Udp_tx_request` |
| SPEC-M05 §11.2 | **CLOSED.** SPEC-M20 §4.1 declares the two `Xgmii` records with the same two prefixes M05 uses, and §10 commissions REQ-017's port-list check |
| SPEC-M08 §11.2 | **CLOSED.** SPEC-M20 §9 states the top-level conservation equation for every discard on the chain at once (see item 4's C-3 answer). **Ledger C-3 itself stays open** until its own gate, the top-level stress bench — what closes is M08's dependency on somebody stating the equation |
| SPEC-M03 §11.2 | **CLOSED.** SPEC-M20 §4.3 and §10 name M03, M04 and M18 as REQ-810's three implementers and `traceability.md`'s row lists all four modules |
| SPEC-M14 §11.4, SPEC-M16 §11.3 | **CLOSED.** SPEC-M19 §4.3 and SPEC-M20 §4.3 write the two wrapper hops of the configuration fan-out; every hop of every field is now stated at the module that performs it |
| SPEC-M16 §11.2 | **CLOSED.** The programme rule is settled: strobes travel as named scalars and are aggregated **once**, at M20. No partial record anywhere |
| SPEC-M15 §11.3, SPEC-M16 §11.4 | **CLOSED.** REQ-610's and REQ-807's second halves exist, name their own and disclaim the other's — the condition dv_lead set at WO-0018 answer (iv) |

---

#### 2. The C-24 … C-30 diff set, item by item

All seven landed. **Six are §13-recorded post-freeze spec diffs** (SPEC-M13
three, SPEC-M14 three, SPEC-M16 one) and **none is breaking**: no §4.1 block
moved, `tools/check_records_vs_appendix.sh` re-passes, and every §12 compile
evidence row still witnesses its own interface. Every §13 row carries
`ADR: none` with the reason, which is the batch-C precedent for a correction that
changes no conformant design.

**C-24 — REQ-502's figure is 7 or 8, not 7.** SPEC-M13 §6.1 now derives it from
first principles rather than asserting constancy: with N the request length DA
through FCS, the terminate character sits in cycle 1 + ⌊N/8⌋ and the payload
`tlast` word at M13's `rx_payload` in cycle 6 + ⌈(N − 18)/8⌉, so the gap is **3
for N ≡ 0, 1, 2 (mod 8) and 4 for N ≡ 3 … 7**, and the response is that gap + 4
= **7 or 8**, over 64 ≤ N ≤ 1518. I re-derived it independently of dv's numbers
and reproduce them exactly, including N = 64 → 7, N = 67 → 8, N = 1518 → 8.
§6.1's cost paragraph and §7's reply-latency bullet follow. **The mechanism is
named** — an octet time converted to a cycle by division discards the residue the
*difference between two events at different octet positions* depends on, which is
C-1's class one level up — because that error will recur. requirements.md
REQ-502's verification column gains the residue rule and forbids quoting a single
number.

**C-25 — the "later of" branch, and the stage that holds the bit.** SPEC-M13
§6.1's branch (1) is now stated for **all five four-word ARP payloads** (28–32
octets, frames of **46–50** octets DA through FCS, not 42), all five runts, all
five excluded by the gate — the conclusion is unchanged and the stimulus a bench
writer derives is not. The sharper half is repaired in §6.2 **(D)**, which is
restructured into **two independent capture events** (0a: the `arp_valid` pulse
captures the five fields; 0b: the payload `tlast` word captures
`rx_payload_tuser`[0] into a one-bit register, and **may precede 0a**) plus the
gating cycle, which reads the *captured* bit and never the port. That was the
real defect: the old three-row table named no stage that held the bit in branch
(1), so the stage model a bench writer builds from was unimplementable in the
order the branch actually occurs.

**C-26 — M14 §9's truncation branch goes extensional.** The row now selects on
"the datagram declared payload octets and at least one was delivered" rather than
on whether a payload word has *left*, which fixes the 21-to-27-delivered band
where the two readings disagreed. **requirements.md REQ-605 settles it** — "the
payload's last word SHALL carry `tuser`[0] = 1" presupposes a word — so this is
the specification agreeing with its requirement, not a choice between designs.
The `Header` row's `Idle` list gains the zero-delivered case and §6.2's `Payload`
entry condition gains "and at least one payload octet was delivered", which
decides the boundary case the old text left undecided: at exactly 20 delivered
octets with a declared total length above 20, **no `ip_hdr_valid`**, one
`error_ip_truncated`. The rule behind it generalises and is stated as such — **a
header record is never emitted for a datagram whose payload frame cannot
follow** — and M17 is written to it from the start. §8 gains both directed sets
(the seven-frame band and the boundary frame) and §10's REQ-605 hook names them.

**C-27 — M14 §7's parse constant is gap-sensitive.** §7 now scopes the 3-cycle
figure to a header delivered without internal idle cycles, states that it grows
by exactly the injected count when idle lands between input words 0 and 2, and
names **L = 12** as the constant that is gap-invariant and therefore the one
REQ-611's gap clause is discharged by. §3's REQ-016 row, §6.1's gapless
paragraph, §10's REQ-016 hook and §10's REQ-611 hook all follow. A bench built
from REQ-611 + REQ-016 now asserts L under injection and asserts 3 only on the
stress stimulus, which delivers each header on three consecutive cycles by
construction.

**C-28 — REQ-505's split tiles at last.** SPEC-M13's header reads "REQ-505 (the
strobe and request half)", §10's row disclaims M15's half by name, and §8 item 1
states that the "every application word accepted rather than stalled" clause is
asserted at **M15's `payload_tready`** — a port M13 does not have — or at M16 and
above where both modules are in one scope, and **not** at M13's ports. The
consequence dv named is now impossible: `SO-arp.md` claims the strobe-and-request
half and `SO-ip_eth_tx_64.md` the discard-and-drain half, and the drain is
claimed once.

**C-29 — M16 §7's transmit anchor.** §7 now writes the chain out cycle by cycle
(M15 emits body word 0 at C + 1, M09 relays combinationally, M07 emits at C + 2)
and states **both** readings: `tx` carries the first body word **one** cycle
after M15 emits it and **two** cycles after M15 accepts the frame's first payload
word. A monitor can be built from either and neither has to be guessed. The three
children's constants were right; only the event they were summed from was wrong.

**C-30 — M14 §8's `clear` exemption.** Criterion 1 gains the conservation
exemption on SPEC-M10 §8's wording model, naming ledger **C-2** as the root,
§7's silent-abandonment sentence as the case, §10's REQ-009 hook as the
commissioned test that would fail without it, and stating that the exemption
never fires in the stress run itself. §10's REQ-009 hook names it. **The same
paragraph is written into SPEC-M17 §8 from the start**, before a bench exists to
fail on it — the third module to carry it.

---

#### 3. rtl_lead's two conventions questions, answered

Both answers are normative in **`docs/adr/ADR-0010`**, with a one-paragraph
restatement in architecture.md §2.3 so the convention is findable beside the
fabric decision. **`rtl_module_dev` packets cite ADR-0010 by number for both.**
SPEC-M01 and SPEC-M02 are untouched, so no freeze evidence moves and post-freeze
churn stays at zero for both.

**(a) `open! Axi64` is the house convention, and it is the only one.** Every
module under `libs/hardcaml_ethernet/src/` opens `Axi64` — with the bang, and
only the record modules its own ports use — and then writes `Axi64.Source.t`,
`Eth_header.t`, `Ip_header.t`, `Udp_header.t`, `Xgmii.t`, `Config.t` and
`Status.t` unqualified. rtl_lead's proposal is adopted as written. Three things
the ADR pins beyond the bare answer: `open!` rather than `open` (dune's dev
profile makes the unused-open warning fatal, and every lift already uses the
bang); a module opens the record modules its ports use and **no others**, which
is SPEC-M12 §4.1's rule applied to the library; and mixing the two forms in one
file is a review defect for rtl_lead to bounce.

**The alternative I did not take is recorded rather than dismissed.** Renaming
the inner module to `Stream` — giving `Axi64.Stream.Source.t` with no shadowing —
removes the wart at its root and is rejected **on cost, not on taste**: SPEC-M01
§4.1 is FROZEN at f78766e, its block is lifted byte-identically, and five freeze
records cite the run that elaborated it, so the rename is the programme's first
breaking post-freeze interface change for a readability gain one `open!` line per
file obtains for nothing. ADR-0010 says explicitly that if a later phase reopens
SPEC-M01 §4.1 for any other reason, **the rename is the first thing to do in the
same diff**. Nobody should find this in year two and think nobody noticed.

**(b) `module type S` does not become a named library artifact.** It stays a
SPEC-TEMPLATE rule 6 device — the thing that lets a §4.1 block compile as a
standalone `.ml` with no implementation to seal — and the library's module
surface stays the `.mli`, which is what REQ-903(b)'s mechanical check reads. Two
independent grounds: a named `S` would be a **second** statement of the module
surface that nothing forces to agree with the `.mli` (a module whose `S` and
`.mli` disagree still compiles), and it would be exported structure **that no
frozen specification binds**, which is what spec-before-RTL exists to prevent.

**M03 and M04 are not functorised over the CRC engine.** REQ-305 already requires
the engine to agree with a bit-serial *software* reference over 10 000 randomised
frames, so the independent oracle DV needs is a software model and not a second
RTL engine; against that, REQ-808 requires `crc32_eth` to appear as a distinct
emitted module instantiated inside both parents, and architecture.md §6.4.3's
eight control edges name **M02** on one end of each — a hierarchy that depends on
an unspecified functor argument cannot be checked by
`tools/check_emitted_verilog.sh`'s REQ-018 whitelist, which is mechanical today.
A programme-wide `S` was also considered and rejected: the shape is not uniform,
because M12, M13, M16, M19 and M20 take three optional REQ-506 parameters and the
other fourteen do not.

**Both answers are decisive and batch-B RTL is unblocked on them.**

---

#### 4. Batch F — the four specifications

All four are template-complete, DRAFT, with byte-identical lifts
(`tools/check_records_vs_appendix.sh`: 23 checks, 0 failures) and no `pending`
row anywhere in `traceability.md`.

**SPEC-M17 `Udp_ip_rx_64`** — receive, owns REQ-701 … REQ-704 and REQ-707.
- **L = 8, h = 8, ΔC = 2 against a §1.1 ceiling of 4.** The module's shaping fact
  is that **the UDP header is exactly one datapath word**: application word j
  *is* input word j + 1, octet for octet, so REQ-021's realignment is the
  identity at the third and last stripping stage and there is no shifter in the
  module. That is why it holds **two** cycles of reserve, the largest on the
  chain — §1.1's allocation was written before any specification had noticed that
  the one word-aligned header on the chain costs about two cycles less than the
  two that are not. §11.2 records it as a decision and states that re-allocating
  is deliberately not done here.
- `hdr_valid` pulses one cycle before application word 0 (Ci + 1 against Ci + 2),
  preserving the lead SPEC-M06 and SPEC-M14 give downstream. **Unlike M14's parse
  latency this figure is gap-invariant** — M17's header is one word, so no idle
  cycle can land inside it — and §7 says so explicitly, which is C-27 applied
  before the fact.
- **M14's independent-evaluation rule is copied with dv's scoping sentence
  (answer (iii)).** REQ-703's length test and REQ-704's port test are evaluated
  independently on the received header bits and each that holds pulses, both at
  Ci + 1; the one precedence rule is that a datagram not delivering a complete
  **8-octet** header pulses `error_udp_bad_length` alone and the port test is not
  evaluated. **The rule is scoped over the whole 8-octet header rather than over
  the four octets the port test strictly needs**, because the length field needs
  the other four and a rule with two thresholds is a rule a bench gets wrong.
- C-26's extensional branch is written in from the start, with the 1-to-7-octet
  band and the exactly-8-delivered boundary both in §8's directed set; C-30's
  `clear` exemption is in §8 criterion 1 from the start.
- §11.3 records something nobody has asked for yet and will: **the application
  receives no IPv4 metadata**. `Udp_header` carries four fields, so a datagram's
  source address reaches no port of M20. Phase 1 needs none; Phase 2 may, and the
  repair is priced there (a new record at M17's output, **not** a field on the
  frozen `Udp_header`).

**SPEC-M18 `Udp_ip_tx_64`** — transmit, owns REQ-705, REQ-706, REQ-709's
detection half, REQ-710, REQ-610's UDP half and REQ-810's application-interface
half.
- Declares **`Udp_tx_request`** — batch F's only new record, at the module
  REQ-705 makes its owner, opened by SPEC-M19 and SPEC-M20. `payload_length`
  counts **UDP payload octets only**, and its width, unit and the two sums it
  feeds (P + 8 into the UDP length field, P + 28 into `ip_hdr_total_length`) are
  stated at the port and in §5.
- **ADR-0008 restated as decisions 1, 2 and 4**, closing the enumeration
  SPEC-M07 §11.2, SPEC-M09 §11.3 and SPEC-M11 §11.2 track. Decision 4 is
  **unreachable rather than tolerated**: output word 0 is the UDP header, which
  every frame has. §7 additionally states the obligation at the port the
  *application* sees, because a bench driving M20 is a source under ADR-0008 and
  should be told so at the top level (SPEC-M20 §7 repeats it).
- **The stall count is W − J = one cycle, not W − J + 1 = two, and the derivation
  is in §6.1 with a C-17(b) warning.** M15 and M07 both drain for W − J + 1
  because their first output word leaves *after* the acceptance that starts the
  frame; M18's output word 0 is **accepted on the same cycle** as its first
  application word, because it was offered two cycles earlier and was waiting. A
  bench that carries M15's formula here fails a conformant M18 on every frame.
  This is the one number in batch F I would most like recomputed.
- **REQ-810's `cfg_tx_enable` edge** — see item 5.
- **REQ-709 and ADR-0011** — see item 5.

**SPEC-M19 `Udp_complete_64`** — structural, M16 + M17 + M18; owns REQ-808 and
REQ-708's application-boundary half.
- ΔC = 0 added; the receive chain across it is (3 + 1 + 4) + 2 = **10** cycles
  against (3 + 1 + 5) + 4 = 13 allocated.
- Fifteen strobes relayed (12 + 2 + 1), and §6.1 states that fifteen plus M05's
  six is twenty-one — asserted at SPEC-M20 §6.1 rather than assumed.
- **§9 carries three conservation facts**, and the second is the one I most want
  read: at M19 a monitor must count **frames discarded, not strobe pulses**,
  because this is the first scope containing two modules (M14 and M17) that can
  each legitimately double-pulse on one frame. That is ledger **C-2**'s first
  clause becoming reachable by a single frame. The third fact separates the
  transmit strobe from the receive equation.

**SPEC-M20 `Nic_top`** — structural, M05 + M19; owns REQ-801 … REQ-806,
REQ-809, REQ-810's configuration source, REQ-807's XGMII half, REQ-708's
end-to-end half, and **REQ-006**.
- **The receive budget closes here, and the derivation is stated twice over.**

  | Stage | h | L | ΔC | ceiling |
  |---|---|---|---|---|
  | M03 (lane 0 / lane 4) | 8 / 12 | 16 / 12 | **3** | 4 |
  | M06 | 14 | 10 | **3** | 3 |
  | M08 | 0 | 8 | **1** | 1 |
  | M14 | 20 | 12 | **4** | 5 |
  | M17 | 8 | 8 | **2** | 4 |
  | **chain** | **50 / 54** | **54 / 50** | **13** | 17 |

  **REQ-006's end-to-end word delay is 13 cycles at both start lanes = 83.2 ns**,
  against 24 cycles / 153.6 ns. Checked by both of §0.5's routes: per-octet
  latency is additive, so L = 54 at lane 0 and 50 at lane 4, h = 50 and 54, and
  ΔC = (L + h)/8 = 104/8 = **13** at each lane. (L + h) = 104 is a multiple of 8
  in both, as §0.5 requires of a conformant chain. **The two lanes give the same
  cycle figure**, because M03 pins ΔC = 3 at both — so a bench measuring 13 at one
  lane and 14 at the other has found a defect, which is a sharper assertion than
  REQ-006 alone permits and is stated where it is derived.
- **The eleven unspent cycles are itemised by holder**: M03 1, M14 1, M17 2 (all
  module reserve, spendable by an ordinary spec diff to that module's §7) and the
  architect's 7 (released only by changing requirements.md §1.1 **and**
  architecture.md §4 together). M06 and M08 hold none. requirements.md §1.1 gains
  a **non-normative currency table** carrying the same five numbers; §11.3 records
  why the allocation is not being tightened at this gate.
- **REQ-802 and REQ-804 get their only user.** M20 is the one module whose ports
  carry `Config` and `Status`; §4.1 adds compile-time witnesses of `Config`'s
  twelve field names and `Status`'s twenty-one, which makes a rename in
  SPEC-M01 §4.1 fail to **compile** as well as fail
  `tools/check_records_vs_appendix.sh`. The aggregation is a **rename, not a
  reduction** — §12 gives each strobe exactly one raising module, so there is no
  OR gate, no priority and no cycle on which two events collide into one field.
- **Ledger C-3 is answered** (SPEC-M08 §11.2's closing condition). §9 states the
  top-level conservation equation with all four terms and each term's
  observability: a zero-payload datagram is accounted for by its
  `app_rx_hdr_valid` pulse, **which is a top-level port** — the observable C-3
  said was missing exists, and what was missing was a document naming it. Term 3
  counts **frames**, not pulses (C-2). Term 4 — frames consumed on the ARP branch
  — **is supplied by the stimulus and not observed**, and that is stated plainly:
  a *consumed* frame is not a *discarded* one, REQ-008 is about discards, and
  conflating them is what would make the equation look broken. The transmit-side
  equation is given separately.
- REQ-806's measured figures cannot exist at spec freeze, so §12 carries a
  **fifth row** for them (REQ-806 requires them in this freeze record) reading
  `pending` with the derived pair beside it, and §11.2 states that a measured
  figure differing from 13 is a defect rather than a correction.

---

#### 5. The two decisions in this batch that are larger than a spec section

**(a) `cfg_tx_enable` is routed to M18 — one added row in architecture.md
§6.4.3.** REQ-810's transmit clause has two observables in one sentence: "emits
only idle characters" (M04's, which has the enable) and "holds `tready`
deasserted at the application transmit interface" — a statement about **M18's**
`payload_tready`, three modules from M04. Without an enable at M18 the second
clause is satisfied only by backpressure propagation, and propagation is not
exact: SPEC-M15 §6.1 step 3 accepts a frame's first payload word
**unconditionally** on its resolution cycle, so exactly **one** application word
would be accepted while transmit is disabled. REQ-810's own verification column
says "`tready` stays low", so a bench written from it would fail a conformant
design by one cycle.

The alternative — leave it to propagation and reword REQ-810's verification
column to permit one accepted word — was rejected because it moves a
**requirement** to accommodate a topology, and because "one word may be accepted
while transmit is disabled" is not a sentence anyone should have to defend. One
input at M18 makes the requirement true as written, at the port it names, for one
control row and no rename. **No requirements diff is owed**, and REQ-810's four
implementers are now named in `traceability.md`: M20 (source), M03 (receive),
M04 (XGMII transmit), M18 (application interface), with M13's ARP clause
unaffected.

**(b) ADR-0011 — an application under-delivery leaves the transmit path holding
an unterminated frame, and `clear` is its recovery.** This is the item I would
bounce myself for if it were not written down, so it is written down.

Writing SPEC-M18's REQ-709 half forced a question neither REQ-709 nor SPEC-M04
§9 asks: **what state is the transmit path in after the remedy?** REQ-709
requires the path to terminate the frame per REQ-206, and SPEC-M04 §9 already
names the mechanism ("M18 stops presenting words and M04 underflows"). Trace it
through: M18 never reaches the declared count so it never asserts
`ip_payload_tlast`; M15 waits in `Body` for a payload `tlast` that will not come;
M09 holds the IPv4 grant, because arbitration is frame-atomic and the frame never
ends; M04 underflows, emits `/E/` `/T/`, serves the gap and idles. **The wire is
correct and both strobes pulse.** But nothing is presented anywhere afterwards,
so no further application datagram is accepted and no ARP reply is granted the
transmit port — and REQ-709's own verification column says "check that the next
frame transmits correctly", which no conformant design can do from that state.

**The requirement, as written, commissioned a test that fails a conformant
design.** The decision: the frame is abandoned in place and `clear` recovers it —
REQ-009 already gives `clear` exactly that power and every module on the chain
already states it. requirements.md REQ-709's verification column gains the
`clear` (editorial: it names a recovery REQ-009 already provides and REQ-709's
normative sentence is untouched), and requirements.md §11 records the absence of a
finer recovery as a decision.

The alternatives are in the ADR with their costs. The sharpest is **(a) M04
consumes and discards an aborted frame's remainder**, which is what a real NIC
would want and which is rejected on three compounding grounds: it contradicts
REQ-207's unconditional "SHALL NOT drop a word it has accepted" (whose reading
SPEC-M04 §11.2 records dv_lead as having classed **compelled**, so reversing it
reopens a closed item), it is a post-freeze §6 change to a frozen batch-B spec,
and it buys automatic recovery from a path no bench takes unless it is
deliberately driven. **The ADR says in terms that (a) is the right repair the day
this design meets real hardware**, and SPEC-M18 §11.4 carries the item with its
price so nobody pays it by accident. Also rejected: terminating the frame short
(it puts a well-formed short frame on the wire, which SPEC-M04 §9 already argues
is the worse outcome and which is why REQ-709 mandates the `/E/`), and a
back-signal from M04 to four modules.

**One editorial consequence at a frozen spec**: SPEC-M04 §9's co-occurrence
bullet says the two strobes "pulse together", which a bench writer may read as
same-cycle. They are not: M18's pulses on the cycle it accepts the short `tlast`
and M04's some cycles later, by an amount that depends on how far M15's drain had
progressed and is **not pinned**. SPEC-M18 §6.3 item 5 and §9 state it, and
requirements.md REQ-709's verification column states it. I have **not** edited
SPEC-M04 §9 in this commit — it is batch-B frozen text and the correction is
stated at the two documents a bench is built from — and I flag it here as a
one-line editorial diff dv_lead may want at M04 instead.

---

#### 6. Verification I ran, and its results

Reproducible from a checkout at this commit:

- `bash tools/check_records_vs_appendix.sh` → **23 checks, 0 failures**, including
  the four new rows `modules/{udp_ip_rx_64,udp_ip_tx_64,udp_complete_64,nic_top}.md
  §4.1 == ifc_check/<name>_ifc.ml (byte identical)`. The four lifts were
  **generated from the specs by the same `awk` the checker uses**, so identity is
  by construction rather than by transcription.
- `bash tools/dv_checks.sh` → exit 0, `dv_checks: all checks passed`.
- **REQ set equality, recomputed**: requirements.md **110** ids (bolded row
  leaders), traceability.md **110** rows, **no duplicate row**, symmetric
  difference **empty**, and **zero** rows whose Spec-section cell reads
  `pending`.
- **architecture.md §6.4 recounted by strict row shape**: **119 edges = 26 rx +
  40 tx + 31 control + 22 status**, which is the previous 118 plus the one
  `cfg_tx_enable → M18` row and matches §6.4's own claim.
- **`libs/**`, `test/**` and `tools/**` were not written.** `tools/` was executed
  read-only; `libs/` was not opened in this activation.

**What I could not check**: the four new lifts have never been elaborated. A CI
`build` run at this commit is owed before any batch-F §12 row can stop reading
`pending` and before a countersignature work order should issue.

---

#### 7. Open questions for dv_lead's countersignature

Ordered by how much I want them tested.

1. **ADR-0011.** Is abandoning the frame and recovering with `clear` the right
   disposition of REQ-709's composed path, or should alternative (a) — M04
   consumes and discards the aborted frame's remainder — be taken now, at the
   price of a REQ-207 scoping diff and a post-freeze §6 change at M04? I have
   recorded (a) as the repair a later phase should take. If dv judges that a
   design which needs a global reset after an application error is not
   testable-in-good-conscience, say so and I will draft the (a) diff.
2. **The `cfg_tx_enable → M18` edge.** An added control edge to make a
   requirement true at the port it names. The E2-shaped alternative was to change
   REQ-810's verification column instead, and I did not take it. This is the same
   shape as batch E's `cfg_subnet_mask → M14` amendment, which dv accepted, and I
   would like it checked the same way.
3. **M18's stall count of W − J = 1**, derived rather than copied from M15's
   W − J + 1, with the reason for the difference stated. Recompute it; if I am
   wrong, every transmit bench inherits the error.
4. **REQ-006's 13 cycles**, and the claim that the figure is **identical at both
   start lanes**. Both routes of §0.5 are shown and both agree; the lane claim
   rests on M03 pinning ΔC = 3 at both lanes, which makes a per-lane difference a
   defect rather than a legitimate variation — a sharper assertion than REQ-006
   itself makes.
5. **M17's ΔC = 2 and its two cycles of reserve.** The largest reserve on the
   chain, and it exists because the UDP header is the one header on the chain
   that is a whole number of words. I did **not** re-allocate the two cycles;
   §11.2 and SPEC-M20 §11.3 argue why not.
6. **M17's scoping of the truncated-alone precedence rule over the whole 8-octet
   header** rather than over the four octets the port test strictly needs. Dv
   asked for a scoping sentence at M17 (answer (iii) item 4) and this is the
   shape I gave it; a narrower rule is defensible and is one clause away.
7. **SPEC-M04 §9's "pulse together" bullet**, which I did not edit — see item
   5(b). A one-line editorial diff at a frozen batch-B spec, dv's call whether it
   is owed.
8. **Still open on the ledger and unchanged by this batch**: **C-2** (now
   load-bearing at three modules — M10, M14 and M17 — and stated at each),
   **C-3** (answered in text at SPEC-M20 §9, closing at the top-level stress
   bench), **C-5**, **C-7**, and **C-9's REQ-903 half**. **C-24 … C-30 are all
   landed** and are the seven §13 rows and §8/§10 edits itemised in item 2.
9. **A CI `build` run at this commit is owed** before the batch-F §12 rows can be
   filled. Three of the four new lifts are ordinary; `nic_top_ifc.ml` is the
   first to carry `Config` and `Status` witnesses and the first to open two lifts
   at once, and `udp_complete_64_ifc.ml` is the first to open a record declared
   by a **sibling in its own batch**.
