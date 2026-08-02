# Journal: claude_architect_docs_lead_agent

- **Agent**: architect_docs_lead (Opus 5 lead)
- **Charter**: agents/charters/architect_docs_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.

---

## [J-architect_docs_lead-0001] 2026-08-01T23:48:00Z | task:WO-0002 | Phase-1 requirements (108 REQ-###), top-level architecture, spec template, traceability skeleton

### Trigger
Orchestrator spawn for WO-0002 (`agents/handoffs/WO-0002_p1-requirements-architecture.md`,
ISSUED at a5e367c), spawn short-id WO-0002/2026-08-01T23:20Z. This is spawn #2:
spawn #1 (WO-0002/2026-08-01T20:58Z) was killed by a session interruption before
writing anything, and the incident note in the packet's Return log (committed at
162d53c) records that no partial state existed. Nothing was inherited; `docs/specs/`
did not exist at HEAD 162d53c. First activation of the architecture function.

### Inputs
Repo at HEAD 162d53c, branch claude/fpga-hardcaml-agent-orchestration-37ceyf.
- `agents/charters/architect_docs_lead.md` (my charter, §3 responsibilities, §5 DoD, §7 escalation, §9 references)
- `agents/PROTOCOL.md` (§3 packets, §4 journal grammar, §6 write scopes, §7 gates, §10 independence, §11 amendments)
- `agents/handoffs/WO-0002_p1-requirements-architecture.md`, `agents/handoffs/README.md`
- `agents/charters/dv_lead.md` (the reader I am writing REQs for: attack plans, SO- coverage form, anchor rules)
- `docs/adr/ADR-0001-org-design.md`, `ADR-0004-toolchain-lane.md`, `ADR-0005-build-environment.md`
- `README.md`, `ORG_CHART.md`, `tasks/BOARD.md`
- Existing Hardcaml skeleton, read for house style only: `dune-project`, `agentic_fpga.opam`,
  `libs/hardcaml_ethernet/src/word_counter.{ml,mli}`, `libs/hardcaml_ethernet/src/dune`,
  `test/hardcaml_ethernet/{dune,test_word_counter.ml}`, `bin/{dune,generate.ml}`, `.ocamlformat`
- `scripts/check_journals.sh`, `scripts/policy.sh` (to get this entry's Files section shape right)
- External, MIT, read 2026-08-01: `alexforencich/verilog-ethernet` README source-file listing
  (all 80 `rtl/*.v` names and descriptions); `rtl/axis_xgmii_rx_64.v` and `rtl/axis_xgmii_tx_64.v`
  parameter and port declarations (`ENABLE_DIC`, `ENABLE_PADDING`, `MIN_FRAME_LENGTH`,
  `PTP_TS_ENABLE`, `cfg_ifg`, `start_packet`, `error_bad_frame`, `error_bad_fcs`, `error_underflow`).
- External, MIT: `janestreet/hardcaml_axi` v0.17.0 `src/stream_intf.ml` (Config/Source/Dest/Make)
  and `hardcaml_axi.opam` (deps: hardcaml_circuits, hardcaml_handshake; OCaml >= 5.1.0).
- `Essenceia/Nasdaq-HFT-FPGA` (CC BY-NC) was NOT opened for this work order; it has no Phase-1
  relevance and consulting it would have created a licensing question for nothing.

### Reasoning
The packet asked for four files; the decisions worth preserving are the ones behind them.

**Requirement form.** dv_lead countersigns testability and tb_writer will see excerpts with RTL
withheld, so a REQ that needs the design to interpret it is worthless. I made every row carry
its own verification method and a Kind tag, forbade multi-fact requirements, and added §11
"explicit non-requirements": every absence (VLAN, IP options, fragments, ICMP, jumbo, DIC, proxy
ARP, IGMP, PTP) is a numbered decision testable in the negative. Rejected: a prose specification
with requirements extracted afterwards — it is faster to write and impossible to keep in bijection
with the traceability matrix.

**Cut-through with late abort (the load-bearing choice).** FCS validity is only known at frame end,
so the receive path forwards payload before it can be judged and reports failure as tuser[0] on the
tlast word (REQ-007, REQ-013, REQ-104), which every stage propagates. Rejected: store-and-forward,
which is what a general-purpose NIC does and which would let the application trust every delivered
byte — at a cost of a full frame time per stage (1500 octets = 188 cycles = 1.2 us), which defeats
the programme's entire purpose. The cost is pushed onto Phase 2: the ITCH handler must be able to
throw away work it has begun. To stop this decision eroding during implementation I added REQ-019
(no payload buffer deeper than two datapath words) and REQ-005 (constant, frame-length-independent
per-module latency) — both structurally observable, so an implementer cannot silently reintroduce
buffering.

**No backpressure, expressed in the type.** Receive ports carry `Axi64.Source` only; `Axi64.Dest`
(tready) exists solely on transmit paths (REQ-003, REQ-112). Rejected: conventional AXI-Stream with
tready and elastic buffers everywhere — it tolerates a slow consumer, but converts "did we drop a
frame" from a structural impossibility into a runtime question with an untested overflow path. The
value of encoding it in the interface record is that a receive module wanting backpressure cannot
be written without a spec diff, which is exactly the visibility PROTOCOL §7 wants at freeze.

**Fabric type: hardcaml_axi vs a local record.** My charter names `hardcaml_axi` typed streams, and
its v0.17.0 `Stream.Make` gives {tvalid; tdata; tkeep; tstrb; tlast; tuser} + {tready}, which is our
shape plus an unused `tstrb`. I considered defining a local `Axi64.Source` without tstrb: a tighter
fit, no new dependency, and no risk to CI. I rejected it because the saving is eight tied-off bits
per boundary against duplicating a library the charter names, and because a charter deviation needs
an ADR (PROTOCOL §11) which is a poor trade for cosmetics. The real cost is a prerequisite I cannot
discharge myself: `hardcaml_axi` is not in `agentic_fpga.opam` and pulls `hardcaml_circuits` and
`hardcaml_handshake` (OCaml >= 5.1, which the CI switch already satisfies since hardcaml_waveterm
requires 5.1). That is an orchestrator work order, recorded in architecture.md §7 with the local
record named as the fallback if CI cannot install it — a fallback that would then need an ADR, so
the reversal stays visible.

**Module inventory: mirror the reference.** Phase-1 sign-off requires differential co-simulation
against verilog-ethernet, so matching module boundaries is what makes a failing comparison
localisable instead of a single top-level equivalence check. I took its decomposition (from the
README source listing) and its co-simulation-relevant parameters, not its code. Rejected: one module
per protocol layer — fewer specs to write, but each becomes a mixed receive/transmit state machine
and the co-simulation degrades to top-level only. Deliberate deviations, all recorded in
architecture.md §5: `ip_64`/`ip_complete_64` and `udp_64`/`udp_complete_64` collapse to one wrapper
each (the inner one exists in the reference to arbitrate multiple clients; we have exactly one), the
arb/demux/mux family for IP and UDP is dropped for the same reason, `udp_checksum_gen_64` is dropped
because it requires buffering, and the FCS insert/check modules fold into the XGMII adapters as they
do in the reference's own 10G MAC. Result: 20 deliverables (M01 types module, M02-M20 circuits).

**ARP.** Chose a full resolver: respond, learn, cache, request, retry, with broadcast, subnet
broadcast, multicast-derived MAC (RFC 1112) and off-subnet gateway handling. Rejected (a)
responder-only with a statically configured peer MAC — genuinely sufficient for a receive-only
market-data NIC, since multicast MACs are arithmetic and need no ARP at all, but ARP is named in
ADR-0001's scope and this would leave nothing testable behind it; rejected (b) the reference's
LRU/hashed cache in favour of a 16-entry direct-mapped cache with an exactly stated index function
(REQ-504) so that collision behaviour is derivable by a test writer rather than emergent. On a
lookup miss the pending datagram is discarded, never queued (REQ-505) — the no-buffering rule wins
over convenience, and the discard is observable per REQ-008.

**Two places I deliberately diverge from the reference, with the consequence declared.**
(1) We verify the IPv4 header checksum (REQ-602); the reference does not. Rather than drop the
check I declared the divergence class inside the REQ: co-simulation stimulus is restricted to
correct-checksum datagrams and the behaviour is verified against the spec by directed test. (2) We
do not verify UDP checksums (REQ-702) and transmit them as zero (REQ-706, RFC 768 permits it for
IPv4) — receive-side because the Ethernet FCS already covers integrity, transmit-side because
generating one requires buffering the payload, which contradicts the cut-through invariant. I judged
this not to be an E2 scope reduction (the scope statement says "UDP", not "UDP checksum offload")
but I flagged it for the orchestrator rather than deciding silently.

**Line rate, stated as arithmetic rather than adjectives.** 8 octets of preamble + 64 of frame + 12
of IFG = 84 octets = 10.5 cycles, and because the XGMII start character may sit in lane 0 or lane 4,
84 is exactly realisable by alternating the start lane. So the worst case a compliant link partner
can present is minimum frames every 10 and 11 cycles alternately, and REQ-004 makes that the stress
stimulus for every receive-path module, not a top-level afterthought. The transmitter is the
asymmetric side: I scoped deficit idle count out (REQ-204), so it starts frames on lane 0 only and
emits at most one minimum frame per 11 cycles. Rejected: implementing DIC in Phase 1 — it buys ~4.5%
of minimum-frame transmit throughput on a path that only carries ARP replies and application
datagrams, and it costs a fiddly state machine plus a co-simulation configuration match. The
reference's `ENABLE_DIC=0` setting is recorded in REQ-901 so the comparison is apples to apples.

**Latency budget.** REQ-006 sets 24 cycles (153.6 ns) from the XGMII start word to the first
application payload word, and architecture.md §4 allocates ceilings summing to 17, leaving 7 cycles
of slack held by me. Slack is released only by a spec diff, so an over-budget module becomes a
visible decision instead of an accumulation. The number is mine, derived from the plausible stage
count, not sponsor-set — flagged below.

**Word alignment as a general rule.** Stripping 14, then 20, then 8 octets leaves payloads at
non-word offsets, so every stripping stage must realign (REQ-021). I wrote it as a programme
invariant rather than as three module-local remarks because it is the same problem Phase 2 hits with
36-50 octet ITCH messages straddling 64-bit words; specifying it once here means the hard block is
already named when we get there.

**Scope hygiene.** The XGMII stub is stimulus, so I specified its *contract* in architecture.md §3
and left it owned by dv_lead under `test/` — writing it into the RTL inventory would have created a
deliverable in a scope neither the RTL line nor I can stage. Per-module specs stayed out (packet
says so); instead architecture.md §8 orders all twenty into six dependency-respecting batches.
Traceability rows were generated mechanically from requirements.md by a throwaway script so the row
set is a bijection with the REQ set by construction rather than by proofreading. I did not touch
README even though PROTOCOL §11 now makes architecture.md the canonical home of the scope
parameters, because the packet named four files; the README follow-up is an open question below.

### Actions
Created (all new files, none existed):
- `docs/specs/requirements.md` — 108 requirements in ten numbered blocks, each a single testable
  SHALL/SHALL NOT with a Kind tag and a verification method, plus a table of explicit
  non-requirements. Line-rate invariant is REQ-004; the XGMII boundary is REQ-017 (closure) and
  REQ-018 (simulation-only), as the packet's DoD requires — numbered, not prose.
- `docs/specs/architecture.md` — canonical scope-parameter table, datapath arithmetic, eight
  architectural decisions each with its rejected alternative, XGMII boundary and stub contract,
  the 20-entry module inventory with verilog-ethernet counterparts and REQ ranges, the latency
  budget allocation, deliberate deviations from the reference, three Mermaid diagrams (receive,
  transmit, hierarchy), freeze prerequisites, and the six-batch spec plan.
- `docs/specs/SPEC-TEMPLATE.md` — 13-section per-module form with a compilable OCaml Interface
  block targeting Hardcaml v0.17 conventions ([@@deriving hardcaml], [@bits n], [@rtlprefix],
  entry points declared inside a `module type S` so the whole block compiles as one .ml file),
  a mandatory line-rate stress section, an errors/strobes table, a REQ-coverage table, and a
  freeze record whose interface-compile row demands a CI run id per ADR-0005.
- `docs/specs/traceability.md` — 108 rows, one per REQ, with Kind, short title, owning module(s),
  spec section (`pending`), empty test column and OPEN status, plus per-block counts and the
  rules for who fills what.
Appended the RETURNED entry to the WO-0002 Return log, below the existing incident note.
No RTL, no tests, no files outside `docs/specs/`, the packet and this journal. No git commands run.

### Evidence
All commands below run from a repo checkout at this commit's SHA (bash, for process substitution):

    grep -c '^| \*\*REQ-' docs/specs/requirements.md
      -> 108
    grep -c '^| REQ-' docs/specs/traceability.md
      -> 108
    diff <(grep -o '^| \*\*REQ-[0-9]\{3\}\*\*' docs/specs/requirements.md | grep -o 'REQ-[0-9]*' | sort) \
         <(grep -o '^| REQ-[0-9]\{3\}' docs/specs/traceability.md | grep -o 'REQ-[0-9]*' | sort)
      -> no output: the REQ id set of requirements.md and the row set of traceability.md are equal
    awk -F'|' '/^\| \*\*REQ-/ && NF!=6 {print} /^\| REQ-/ && NF!=9 {print}' \
        docs/specs/requirements.md docs/specs/traceability.md | wc -l
      -> 0 (no malformed requirement or matrix row)

Honest limits on this evidence:
- No OCaml was compiled and no CI run was triggered by this work order. The Interface block in
  SPEC-TEMPLATE.md §4.1 is written to Hardcaml v0.17 conventions but is NOT yet compile-verified;
  `docs/specs/ifc_check/` does not exist. Per ADR-0005 the only acceptable evidence for that check
  is a CI `build` run id, and per the packet it happens before freeze, not in this work order.
  Charter §5's "records compile in the scratch lib" DoD item is therefore open, not met.
- The traceability matrix was produced by a generator script written to an ephemeral scratchpad
  directory outside the repository. That script is not committed and does not reproduce; the
  reproducible claim is the set-equality command above, which checks the committed artefact.
- Prior-art citations (verilog-ethernet module list and port declarations, hardcaml_axi v0.17.0
  interface) are externally verifiable at the URLs named in architecture.md §10.

### Outcome
DoD vs WO-0002: **met**, with one item deferred by the packet's own terms.
- Four deliverables written and commit-ready: yes.
- Every requirement individually testable, written for dv_lead: yes — each carries a verification
  method; dv_lead's testability countersignature is a `P1-spec-freeze` step, not a WO-0002 step.
- Line-rate invariant and XGMII simulation-only boundary as numbered REQs: yes (REQ-004; REQ-017,
  REQ-018), with REQ-003, REQ-005 and REQ-019 supporting them structurally.
- Module inventory names every Phase-1 RTL deliverable: yes, 20 entries M01-M20 with counterparts.
- Docs runnable-truthful: no command is quoted in the four deliverables that does not run; the only
  build claim points at CI per ADR-0005.
- Deferred (packet-scoped out): interface compile check in `docs/specs/ifc_check/`; per-module specs.
Handoff: `agents/handoffs/WO-0002_p1-requirements-architecture.md` state RETURNED, awaiting
orchestrator ACCEPT/BOUNCE and dv_lead testability review.

### Open-questions
1. **hardcaml_axi dependency (blocking for freeze)** — orchestrator work order needed to add
   `hardcaml_axi` to `agentic_fpga.opam` and to `libs/hardcaml_ethernet/src/dune`; it pulls
   `hardcaml_circuits` and `hardcaml_handshake`. If CI cannot install it, the fallback is a local
   stream record and I will raise an ADR. Every module spec's interface depends on this answer.
2. **`docs/specs/ifc_check/` wiring (blocking for freeze)** — the `dune` stanza and build inclusion
   are orchestrator-owned; the `.ml` sources are mine. Needed before batch A specs can be frozen.
3. **UDP checksums** — transmit checksum is specified as zero (REQ-706) and receive checksums are
   not verified (REQ-702). I judged this in-role rather than E2, since the scope statement says
   "UDP" and RFC 768 permits zero for IPv4. If the orchestrator reads it as a scope reduction, it
   needs a sponsor decision before freeze.
4. **Spec batching** — architecture.md §8 proposes six work orders for twenty specs. Ordering is not
   negotiable (interfaces are reused downstream); batch size is the orchestrator's call.
5. **README vs canonical scope parameters** — PROTOCOL §11 makes the top-level spec canonical from
   M1, so README's phase table is now a restatement. I did not touch README (outside this packet's
   deliverable list); request a small follow-up doc work order to point it at architecture.md §1.
6. **Latency budget authority** — REQ-006's 24 cycles is my figure, not a sponsor requirement.
   Confirm it should stand as a specification requirement rather than an internal target.
7. **dv_lead review timing** — I recommend the testability review of `requirements.md` lands before
   the `P1-spec-freeze` checklist is opened, so objections arrive as spec diffs rather than as gate
   blockers.

### Files-in-this-commit
- agents/handoffs/WO-0002_p1-requirements-architecture.md
- docs/specs/SPEC-TEMPLATE.md
- docs/specs/architecture.md
- docs/specs/requirements.md
- docs/specs/traceability.md

## [J-architect_docs_lead-0002] 2026-08-02T02:35:00Z | task:WO-0004 | Apply the sixteen WO-0003 testability diffs: IFG convention resolved, latency redefined per octet, four UNTESTABLE rows closed, 108 to 110 REQs

### Trigger
Orchestrator spawn for WO-0004 (`agents/handoffs/WO-0004_requirements-spec-diffs.md`,
ISSUED at ebe41dc), spawn short-id WO-0004/2026-08-02T01:40Z. Second activation of the
architecture function. The work order is the return path of dv_lead's testability review:
countersignature for `P1-spec-freeze` was withheld pending sixteen spec diffs, and this
unit of work either applies each one or contests it with a technical reason. Silent partial
application was named as the one unacceptable outcome, because dv_lead re-reviews against
the diff list.

### Inputs
Repo at HEAD ebe41dc, branch claude/fpga-hardcaml-agent-orchestration-37ceyf.
- `agents/charters/architect_docs_lead.md` (re-read: §3 adjudication and ADR duties, §5 DoD, §7 E2)
- `agents/PROTOCOL.md` §4 (entry grammar, files-list set-equality), §6 (write scopes), §7, §10
- `agents/handoffs/WO-0004_requirements-spec-diffs.md` (my work order, at ebe41dc)
- `agents/handoffs/WO-0003_testability-findings.md` at 9a6195a, read in full (1659 lines):
  dispositions for all 108 REQs, cross-cutting findings X-1 to X-10, the sixteen diffs
  D-1 to D-16 in section 14.3, the bench-feasibility section 13, and the CRC reproduction
  in section 13.5
- `agents/handoffs/WO-0003_requirements-testability-review.md` Return log: dv_lead's
  RETURNED entry and the orchestrator's ACCEPTED entry at 9723207 — the latter carries the
  independent zlib re-verification of both CRC constants and the five open-question rulings
- `docs/specs/requirements.md`, `traceability.md`, `architecture.md`, `SPEC-TEMPLATE.md`
  at 08899d3/ebe41dc (my own WO-0002 output, the text under revision)
- My own `J-architect_docs_lead-0001` for the WO-0002 mechanical-check commands, reused here

### Reasoning
Sixteen diffs, one document, and a reviewer who will re-read against the list. Three
decisions carried the work; the rest were transcription.

**1. The IFG collision (D-3) — which convention, and how to defend it.** My section 0
derivation and REQ-204 disagreed: 8 + 64 + 12 = 84 octets only works if the terminate
character sits *inside* the twelve, and REQ-204 said "at least cfg_ifg idle octets" after
it. dv_lead walked it lane by lane and got 10/11 alternation only under the inclusive
reading. I confirmed that walk and then looked for a reason that does not depend on our own
arithmetic, because the whole point of the finding is that our arithmetic disagreed with
itself. The independent reason is the frame budget: 84 octets is 67.2 ns is 14.88 Mpps, the
minimum-frame rate IEEE 802.3 fixes, and it is the same 84 octets at 1 Gb/s — where there
is no terminate character at all and the twelve gap octets are all idle. Counting /T/
inside the twelve is exactly what makes the budget speed-invariant; the exclusive reading
would make 10 Gb/s the one speed whose minimum-frame budget is 88 octets. So: gap measured
from the terminate character inclusive, minimum 12.

Deficit idle count is where this could still have gone wrong, and it is why I did not
simply restate REQ-204 and stop. Start characters may sit only in lane 0 or lane 4, so a
real gap must round up to a multiple of 4; clause 46 lets a transmitter give the rounding
back later (never below 9) so the *average* stays 12. That single mechanism explains why
receive and transmit need different numbers, and the document previously conflated them.
I split them explicitly: receive assumes a DIC-capable partner alternating start lanes and
therefore realising 84 octets exactly (10, 11, 10, 11 — the worst case the receive path
must survive, and what every stress bench drives), while our transmitter has DIC out of
scope and starts on lane 0 only, so it rounds every gap up to 16 octets from /T/ and emits
one frame per 11 cycles. Both are now stated as the same convention with different rounding
behaviour, which is the only way REQ-004's 10.5 and REQ-209's 11 are simultaneously true.
Four sites carry it identically — requirements section 0.3, REQ-004, REQ-204, and
architecture.md section 1 — because the failure mode this diff exists to prevent is exactly
a stale second copy.

**2. Latency (D-4) — I applied the diff and corrected its metric.** dv_lead's per-octet
definition is right in intent and unsatisfiable as stated. Their own worked case shows why:
with a lane-4 start, frame octets 0-3 arrive in input word N+1 and octets 4-7 in word N+2,
yet both leave in output word 0 — so the per-octet difference *in cycles* alternates
between two values inside a single frame, and a bench written from that sentence fails a
conformant `Xgmii_rx_64`. The fix that preserves the intent is to measure in octet times
(8 times cycle, plus lane index or byte position). Then the realignment cancels exactly: a
module stripping h octets that takes its first input word at Ci and emits its first output
word at Co has L = 8(Co - Ci) - h for every octet, at every start lane, at every header
length. I checked it against all three stripping stages and both start lanes before writing
it. That is a strictly better invariant than the one requested, it costs the DV tagger only
a byte position alongside each cycle, and it is what makes REQ-005, REQ-111, REQ-210 and
REQ-611 one property rather than four. I flagged it as a partial contest in the Return log
rather than silently improving it, because dv_lead re-reads against the list and because
their scoreboard design in findings section 13.3 depends on the metric.

**3. Zero-length payloads (D-7) — two options, and why the stream type won.** Either permit
`tkeep` = 0 on a `tlast` word, or say a zero-octet frame is simply not emitted. I chose the
second. REQ-011's prohibition is one of the strongest interface invariants in the document
and every protocol monitor depends on it; the alternative buys uniform frame counting at
the price of complicating every monitor to encode an event the header record already
carries. So a stage whose output would be zero octets emits no payload frame: where it has
a header record (M06, M14, M17) the `valid` pulse is the report and downstream must
tolerate a header with no payload; where it does not (M03) a strobe is the report, which is
what fixes REQ-107's sub-5-octet hole. The cost is a third term in the frame-conservation
identity (D-6), which I wrote into section 0.6 rather than leaving the identity approximate.

**Two requirements added, deliberately and visibly.** D-12 offered "give the enables a
behavioural REQ or delete them"; deleting configuration fields is a scope reduction, so I
added REQ-810. D-15 said "split REQ-709", and under this document's own one-fact-per-REQ
rule an under-delivery and an over-delivery are two facts with different observables — a
frame already terminated on the wire cannot take REQ-206's remedy, which is precisely
dv_lead's point — so REQ-710 exists. Charter section 7 makes adding a requirement an E2
class and I considered escalating. I did not, because neither adds capability: REQ-810
gives observable meaning to two fields REQ-802 already declared, and REQ-710 is a split, not
an addition of behaviour. Blocking a sixteen-diff work order on an E2 round for that would
have been a worse call than applying it and flagging it, which is what I did in the Return
log's final section.

**What I did not do.** I did not re-derive the CRC constants. They were computed
independently twice (dv_lead, then the orchestrator with zlib before accepting the review),
the ruling says cite and do not re-litigate, and a third computation by the party whose
document was wrong adds nothing. Instead I wrote a provenance note under section 4
recording both computations and explaining that 0xC704DD7B is the same residue in the
non-reflected convention, so the next reader who recognises that published constant does
not reopen it. I also declined to weaken REQ-008 to permit a shared strobe: giving REQ-110
its own `error_start_without_terminate` costs nothing pre-RTL and keeps "dedicated strobe
named for that condition" literally true, which matters because REQ-008 is the row the
whole silent-discard argument rests on.

**One correction to the review.** Section 14.3's D-1 enumerates five R-path modules;
architecture section 4 marks six — M10 `Arp_eth_rx` was omitted. The stress-bench list is
seven modules including `nic_top`, and I stated M10's stimulus explicitly so the addition
is actionable rather than an argument.

### Actions
All edits inside `docs/specs/**` plus the WO-0004 packet. No git operations.
- `docs/specs/requirements.md` — rewritten in place. Section 0 restructured into 0.1
  (test-derivation basis, correcting the false sole-basis claim), 0.2 (conventions),
  0.3 (frame-length and IFG conventions), 0.4 (receive path, normative, plus the
  stress-bench list by name), 0.5 (octet time and per-octet latency), 0.6 (abort/discard
  precedence, strobe multiplicity, strobe timing window, frame conservation), 0.7
  (zero-length payloads). New section 1.1 (receive-path latency ceilings, transcribed from
  architecture section 4 and made normative), 9.1 (twelve configuration fields with widths,
  reset values, ranges and owning REQ), 12 (normative strobe appendix, twenty-one entries).
  Two REQs added (REQ-710, REQ-810); REQ-002 re-kinded INV to IFC; roughly sixty rows
  restated. REQ-303 to 0xCBF43926, REQ-304 to 0x2144DF1C, REQ-408 50 to 46, REQ-605's
  padding example to a total-length-28 datagram.
- `docs/specs/traceability.md` — counts table (UDP 10, top level 10, total 110) with a note
  on why two rows were added; rows REQ-710 and REQ-810 added; REQ-002 kind and REQ-019
  short title updated; REQ-709 owner extended to M04; a fourth open dependency records
  REQ-019's declared partial coverage so no packet can read COVERED as buffer-depth
  evidence.
- `docs/specs/architecture.md` — section 1 datapath arithmetic restated with the IFG
  convention and the DIC asymmetry; section 3 stub contract marked as restated in REQ-018;
  section 4 Path column marked descriptive with the normative definition at requirements
  0.4, and the latency table marked as transcribed into requirements 1.1 with a
  change-together note.
- `docs/specs/SPEC-TEMPLATE.md` — section 3 (receive-path membership decided by 0.4),
  section 7 (latency in octet times, per start lane, against the 1.1 ceiling), section 8
  (stress obligation rewritten: corrected IFG convention, per-boundary stimulus rule,
  all-accepted rule, vacuous no-backpressure criterion replaced by the structural
  statement), section 9 (each spec must state which error conditions co-occur).
- `agents/handoffs/WO-0004_requirements-spec-diffs.md` — state ISSUED to RETURNED; Return
  log appended with the sixteen-row disposition table, the D-3 defence, the four
  UNTESTABLE outcomes, the beyond-the-sixteen list, the companion-document reconciliation,
  and the two flags for the orchestrator.

### Evidence
Run from a repo checkout at this working tree:

    diff <(grep -o '^| \*\*REQ-[0-9]\{3\}' docs/specs/requirements.md | grep -o 'REQ-[0-9]*' | sort) \
         <(grep -o '^| REQ-[0-9]\{3\}'     docs/specs/traceability.md | grep -o 'REQ-[0-9]*' | sort)
      -> no output: the REQ id set of requirements.md equals the row id set of traceability.md

    grep -c '^| \*\*REQ-' docs/specs/requirements.md   -> 110
    grep -c '^| REQ-'     docs/specs/traceability.md   -> 110

    grep -o '^| \*\*REQ-[0-9]\{3\}' docs/specs/requirements.md | grep -o 'REQ-[0-9]*' | sort | uniq -d
      -> no output (no duplicate ids); the same list is already sorted, so block ordering holds

    awk -F'|' '/^\| \*\*REQ-/ && NF!=6 {print} /^\| REQ-/ && NF!=9 {print}' \
        docs/specs/requirements.md docs/specs/traceability.md | wc -l
      -> 0 (no malformed requirement or matrix row; no stray pipe inside any cell)

    git status --porcelain
      -> exactly five modified paths, all inside docs/specs/** and agents/handoffs/;
         dv_lead's findings file is not among them

Honest limits on this evidence:
- No OCaml was compiled and no CI run was triggered. This work order changed no Interface
  record, so the green `ifc_check` build cited at 81acc2c (CI `build` run 30724505231) is
  still the applicable compile evidence; I did not re-run it and do not claim a new one.
- The two CRC constants are cited, not re-derived here — provenance is dv_lead's findings
  section 13.5 and the orchestrator's independent zlib run recorded in the WO-0003 ACCEPTED
  entry. Anyone can re-run that snippet; I deliberately did not add a third computation.
- The IEEE 802.3 arguments in section 0.3 and in the Return log are specification reasoning
  against a standard I did not have open in this container; they are checkable against
  clause 4 (frame format, interpacket gap) and clause 46 (XGMII, deficit idle count), which
  architecture.md section 10 already cites, and against the widely published 14.88 Mpps
  minimum-frame figure. The lane-by-lane walk that produces 10/11 alternation is reproduced
  in the Return log and can be checked by hand.
- The per-octet latency algebra (L = 8(Co - Ci) - h) was verified by hand for the three
  stripping stages and both start lanes, not by simulation. It is a specification-arithmetic
  claim, and the first executable check of it will be dv_lead's tagger.

### Outcome
DoD vs WO-0004: **met**.
- All sixteen diffs applied; none contested outright; D-4 applied with a corrected metric
  and the correction stated explicitly in the Return log, per the packet's requirement that
  disagreement be visible rather than silent.
- D-3 resolved to one convention, stated identically at all four sites (requirements 0.3,
  REQ-004, REQ-204, architecture section 1), with the defence against DIC behaviour written
  down rather than assumed.
- The four UNTESTABLE rows: REQ-019 testable on the ceiling half with the buffer-depth half
  explicitly re-scoped as non-DV-verifiable (and the matrix told so); REQ-510 testable via
  the one-pending-reply rule; REQ-802 re-scoped to the record contract with the missing
  behaviour added as REQ-810; REQ-901 testable via transactional comparison, named
  boundaries and four declared divergence classes.
- Both arithmetic slips fixed: REQ-408 50 to 46; REQ-605's example replaced by a
  total-length-28 datagram, which actually leaves 18 octets of padding to remove.
- REQ set / traceability row set equality holds at 110 each, re-checked mechanically above.
Handoff: `agents/handoffs/WO-0004_requirements-spec-diffs.md` state RETURNED, awaiting the
dv_lead re-review work order against this post-diff text and then the `P1-spec-freeze`
checklist.

### Open-questions
1. **Two REQs added (REQ-710, REQ-810)** — charter section 7 classes a requirement addition
   as E2. My in-role judgement is that neither is a scope change (one gives observable
   meaning to fields REQ-802 already declared; the other is a split of an existing
   obligation), so I applied them rather than blocking the work order. If the orchestrator
   reads either as scope, it needs a sponsor decision before freeze.
2. **New normative strobe name `error_start_without_terminate`** — twenty-one strobes now,
   not twenty. Free today because no RTL exists; it must be settled before Batch B (M03) is
   specified, since M03 owns five of the twenty-one.
3. **REQ-506's defaults are mine, not a sponsor requirement** — retry count 4, retry
   interval 1.0 s, entry lifetime 20 s, all compile-time parameters. They are chosen to be
   plausible and to fit 32-bit counters; if the programme wants the reference design's
   values instead, that is a one-line diff.
4. **REQ-810's transmit-disable behaviour holds `tready` low at the application boundary.**
   That is backpressure on the transmit path, which REQ-207 permits, but it means an
   application that ignores the enable can stall indefinitely. The alternative — discard
   with a strobe — would need a twenty-second strobe. I chose the stall; worth a second
   opinion from rtl_lead when M18/M20 are specified.
5. **REQ-015's per-stream maximum word count is deferred to each module spec** rather than
   stated as one number here, because the maximum differs per stage (1514, 1500, 1480, 1472
   octets). Section 0.1 now declares that deferral honestly. If dv_lead would rather have
   the four numbers in this file, it is a small addition.
6. **No ADR was written for this work order.** These are pre-freeze spec diffs against a
   DRAFT document, not post-freeze changes, so charter section 3's "spec diff plus ADR" rule
   does not bite yet. The three decisions that would be ADR-worthy if reversed later — the
   IFG convention (0.3), the zero-length-payload encoding (0.7) and the octet-time latency
   metric (0.5) — are recorded here and in the Return log; I will fold them into the
   pre-freeze ADR sweep architecture section 2 already promises.

### Files-in-this-commit
- agents/handoffs/WO-0004_requirements-spec-diffs.md
- docs/specs/SPEC-TEMPLATE.md
- docs/specs/architecture.md
- docs/specs/requirements.md
- docs/specs/traceability.md

## [J-architect_docs_lead-0003] 2026-08-02T04:40:00Z | task:WO-0006 | Batch A specs: SPEC-M01 Axi64 (types only) and SPEC-M02 Crc32_eth, with both §4.1 blocks lifted into ifc_check

### Trigger
Work order `agents/handoffs/WO-0006_batch-a-specs.md` (state ISSUED, committed at
1f541a9), spawn short-id `WO-0006/2026-08-02T03:45Z`, third activation of this
identity. The order: the first two per-module specifications, the ones the other
eighteen copy their form from, plus the first two real entries in the interface
compile-check lane.

### Inputs
- `agents/charters/architect_docs_lead.md` (§5 definition of done, §6 evaluation).
- `agents/PROTOCOL.md` §4 (entry grammar), §6 (write scope), §7 (gates), §10.
- `agents/handoffs/WO-0006_batch-a-specs.md` at 1f541a9.
- `docs/specs/SPEC-TEMPLATE.md` — the normative form; rules 1 (not-applicable
  plus one sentence of why), 4 (every behavioural claim traces to a REQ), 5
  (banned phrasing), 6 (verbatim lift, entry points inside `module type S`).
- `docs/specs/requirements.md` at b4b4cf4 — verified byte-identical to the
  working tree (`git diff b4b4cf4 -- docs/specs/requirements.md` empty), so the
  SIGNED text and the text I wrote against are the same text. Read in full:
  §0.1–§0.7, §1 REQ-001…021, §4 REQ-301…306 and the provenance note, §9.1, §12.
- `docs/specs/architecture.md` §1, §2.3, §4 (M01/M02 rows, latency ceilings),
  §6.3, §7, §8, §10.
- `docs/gates/P1-spec-freeze-checklist.md` — carry-forward ledger; C-1 and C-4
  are batch-B scoped and were not touched.
- `docs/specs/traceability.md` header and the rows for REQ-010…014, REQ-301…306,
  REQ-802 (all `pending` in the Spec-section column).
- `docs/specs/ifc_check/dune` and `template_ifc.ml` — the proven-compiling form
  and, decisively, the library name `ifc_check`.
- No external repository was read for this work order. `verilog-ethernet` is
  cited only through architecture.md §4/§5, which already records what was taken
  from it; `Essenceia/Nasdaq-HFT-FPGA` was not consulted and has no Phase-1
  relevance.

### Reasoning

**1. M01 is a specification of a vocabulary, and the template is written for
circuits.** Six sections have no circuit to describe: §4.2's port table, §6.2's
state machine, §7's timing contract, §8's stress obligation, §9's error table,
and the `create`/`hierarchical` clause of §4.1. The template's rule 1 says these
are answered, never deleted, and I took "one sentence of why" seriously in each
— the alternative I rejected was a single blanket "M01 has no circuit" at the
top and six pointers to it, which is cheaper to write and worse to read, because
the reader who arrives at §7 looking for a latency figure needs to be told there,
not three pages earlier, and to be told where the figure does live. §4.2 is the
one section I did not answer with a bare "not applicable": a types module still
has a field table, and that table is the thing the other nineteen specs quote, so
I kept the template's five columns and replaced Dir with a stated reason
(direction is fixed at the instantiation site — the same `Eth_header` is M06's
output and M07's input).

**2. What M01 must NOT contain.** Architecture §4's M01 row lists the stream
types plus `Eth_header`, `Ip_header`, `Udp_header`, `Config` and `Status`, and I
declined to add anything to that list. Two candidates presented themselves. The
application transmit request (REQ-705) belongs to SPEC-M18/M20 by requirements.md
§0.1's explicit deferral, so putting it here would have contradicted a signed
document. The XGMII lane pair is the more interesting one: four later specs (M03,
M04, M05, M20) will each restate `xgmii_rxd`[63:0]/`xgmii_rxc`[7:0], which is
exactly the duplication REQ-010 rejects for streams — but architecture §4 gives
M01 no such record, architecture.md is read-only under this WO, and inventing one
now would make batch B's authors quote a record no inventory row authorises. I
raised it as open question 11.1 against batch B instead, where the cost of four
restatements becomes visible in a diff rather than in an argument.

**3. The Status record settles a name-versus-port question.** REQ-804 needs one
field per strobe and requirements.md §0.2 makes the twenty-one strobe names
normative. Field names I fixed exactly (`error_bad_fcs`, …, in §12's order); the
`rtlprefix` M20 applies I deliberately left unconstrained (§6.3), because no REQ
pins the *port* names and I would rather leave a hole a later spec fills than
assert something the toolchain might contradict. `Config` is the opposite case: I
constrained its prefix to `cfg_` at every site, because REQ-802 names `cfg_ifg`
in its own text, and field `ifg` under prefix `cfg_` is the only way that name is
true. So M01 fixes one prefix and exactly one.

**4. M02's central decision: the ports carry finished CRC values, not the raw
shift register.** This is the decision the rest of the spec hangs on and it went
the minority way relative to prior art. Under REQ-301's parameterisation the
finished value C and the internal register R satisfy R = C XOR 0xFFFFFFFF, so
either can be carried and the hardware cost is identical (an XOR with a constant
folds into the surrounding logic). What differs is how many conversions the rest
of the programme has to get right:

- With finished values, `crc_in` = 0x00000000 is the CRC-32 of the empty string,
  REQ-303's 0xCBF43926 is read directly at `crc_out`, REQ-304's 0x2144DF1C is
  read directly at `crc_out`, and the REQ-305 oracle comparison is the identity
  `crc_out = reference(crc_in, octets)` with no adjustment at either end.
- With the raw register, the seed is 0xFFFFFFFF and every one of those four
  comparisons carries an XOR that a bench author, a formal harness and a
  co-simulation adapter must each apply and none may forget. requirements.md §4's
  provenance note exists because this programme has *already* lost a review cycle
  to a convention error on exactly these two constants (0xC704DD7B is the same
  residue in the non-reflected convention). Removing the remaining conversions
  from the interface is the cheapest defence against a repeat.

I checked the arithmetic rather than asserting it — see Evidence — including that
the residue holds at two frame lengths and that the chained 8-then-1 update
reproduces REQ-303. The rejected convention is recorded in the spec (§6.1 note 3
gives the conversion in both directions, for a reader comparing against
`axis_eth_fcs_64.v`), and the decision is booked as an ADR I owe (11.1), since
charter §3 makes a non-obvious interface choice ADR material and this WO's file
set excludes `docs/adr/`.

**5. `octet_count` is a 4-bit count with an unconstrained region, and I did not
close the region by fiat.** A 3-bit count-minus-one would have made the function
total, which is genuinely attractive for a `formal_dv` proof — no assumption to
state. I rejected it because it puts an off-by-one at every call site in M03 and
M04 and in every bench, and an off-by-one that silently computes the CRC of seven
octets instead of eight is precisely the defect class this module exists to
prevent. Having chosen the count, the values 0 and 9–15 are outside REQ-302's
stated domain, and template rule 4 gives two honest options: raise the missing
requirement, or record it as unconstrained in §6.3. I did both halves — §6.3
records it unconstrained today with an explicit instruction that DV assert
nothing there and that formal assume the domain, and 11.2 proposes REQ-307 for
the zero case *if and only if* M03 or M04 turns out to need an update-by-zero
cycle. Only those two specs can answer that, so inventing the requirement now
would be guessing on behalf of a module that does not exist yet.

**6. REQ-010 versus M02, contested rather than glossed.** REQ-010 says all
frame-carrying ports SHALL use `Axi64.Source`/`Axi64.Dest`. M02's `data` port
carries frame octets and is deliberately not a stream — REQ-306 forbids it the
state that would make `tvalid`/`tlast`/`tkeep`/`tuser` mean anything, and its
interface compile check therefore has no `Axi64` port to witness. Read literally,
M02 is the single Phase-1 module that cannot satisfy an invariant it is bound by,
which is a standing audit finding waiting to be written. requirements.md is
read-only under this WO and the WO says to contest rather than edit, so the
proposed narrowing ("frame-carrying *stream* ports", naming M02) is in the Return
log and in SPEC-M02 §11.3. I considered the alternative of giving M02 an
`Axi64.Source` port and ignoring four of its fields; that is worse, because it
would put fields on a boundary where no requirement gives them meaning and would
invite an implementer to start using them.

**7. The lift factoring, and a template defect found by doing it.** SPEC-TEMPLATE
§4.1's comment tells later specs to write `open Ifc_check_axi64`. No such module
can exist: rule 6 names the file `<module>_ifc.ml` and `docs/specs/ifc_check/dune`
declares `(name ifc_check)`, so the file is `axi64_ifc.ml` and the module a
sibling lift opens is `Axi64_ifc`. Both lifts use the real name; the template
needs a one-line editorial diff (11.3 in SPEC-M01), which is out of this WO's
file set. In `crc32_eth_ifc.ml` the open is `open! Axi64_ifc` with the bang and a
comment saying exactly why: M02 legitimately takes no type from M01, and an
unbanged open of a module nothing references is a dev-profile warning-33 build
failure. I considered forcing a real dependency by writing
`[@bits Axi64_config.data_bits]`, which would have tied M02's word width to M01's
constant structurally — I rejected it because no block in this repository has yet
proved that ppx_hardcaml accepts a non-literal `[@bits]` payload, hardcaml is not
installed in this container (see Evidence), and ADR-0005 makes CI the only place
that finding could surface. A red CI on the orchestrator's commit is a worse
trade than a normative sentence in §4.2 saying `data` is one `Axi64` word.

**8. `open!` on both lines of `axi64_ifc.ml`, deviating from the template
example's `open Hardcaml`.** That file declares no `module type S`, so it names
neither `Scope` nor `Signal`; whether `Hardcaml` is referenced at all depends on
whether ppx_hardcaml's generated code qualifies its references, which I cannot
check here. `open!` costs nothing and removes the failure mode. The comment in
the file says this, so a reader does not have to re-derive it.

**9. What I did not do.** SPEC-TEMPLATE §10 says the traceability matrix is
updated in the same commit as the spec; WO-0006 fixes Files-in-this-commit to
five paths, `traceability.md` not among them. I obeyed the work order and
recorded the conflict in three places rather than resolving it silently: both
specs' §10 note it below the table, SPEC-M01 §11.2 owns it, and the Return log
raises it. Eleven REQ rows (010–014, 301–306, 802) still read `pending`. C-1 and
C-4 in the gate ledger are batch-B scoped; I neither attempted nor regressed
them, and nothing in either spec pins a latency constant that C-1's unit question
would govern — M01 and M02 both contribute zero.

### Actions
- Wrote `docs/specs/modules/axi64.md` (SPEC-M01, DRAFT): all thirteen template
  sections; §4.2 as five field tables (Source, Dest, three header records,
  Config) plus a pointer for Status; §4.1 declaring `Axi64_config`, `Axi64`,
  `Eth_header`, `Ip_header`, `Udp_header`, `Config` (twelve fields) and `Status`
  (twenty-one fields); "not applicable" with a reason in §4.2's Dir column, §6.2,
  §7 (all five clauses individually), §8, §9 and the `create`/`hierarchical`
  clause of §4.1; four open questions.
- Wrote `docs/specs/modules/crc32_eth.md` (SPEC-M02, DRAFT): the update contract
  as an equation over CRC32(·) with the value convention stated explicitly, two
  worked examples with real numbers (REQ-303 in two updates; a 64-octet frame in
  eight, both transmit and receive), the REQ-305 oracle relationship including
  its anchoring obligation, "not applicable" with a reason in §5, §6.2, §8, §9
  and three clauses of §7; four open questions.
- Wrote `docs/specs/ifc_check/axi64_ifc.ml` and
  `docs/specs/ifc_check/crc32_eth_ifc.ml` as byte-identical lifts of the two
  §4.1 blocks.
- Appended the RETURNED entry to `agents/handoffs/WO-0006_batch-a-specs.md`.
- Ran no git command.

### Evidence
All commands below run from a checkout at this commit's SHA.

1. **The requirements text I specified against is the SIGNED text.**
   `git diff b4b4cf4 -- docs/specs/requirements.md` → empty output.
2. **Both lifts are byte-identical to their spec's §4.1 fenced block** (template
   rule 6, "lifted verbatim"), checked mechanically for both pairs — the spec
   contains exactly one fenced OCaml block and it equals the `.ml` file byte for
   byte. Re-runnable, written so the fence characters need no quoting:
   `python3 -c "import re;F=chr(96)*3;md=open('docs/specs/modules/axi64.md').read();b=re.findall(F+'ocaml\n(.*?)'+F+'\n',md,re.S);print(len(b)==1 and b[0]==open('docs/specs/ifc_check/axi64_ifc.ml').read())"`
   → `True`; the same command with `crc32_eth` substituted for `axi64` in both
   paths → `True`.
3. **Both lifts parse as OCaml.** `ocamlc -stop-after parsing -c axi64_ifc.ml`
   and `... crc32_eth_ifc.ml` → no output, exit 0, on the container's
   `ocaml-system.4.14.1` switch. This is a **syntax** result only and is
   explicitly **not** the compile evidence charter §5 and ADR-0005 require:
   hardcaml, hardcaml_axi and ppx_hardcaml are not installed in this container
   (`ocamlfind list | grep -i hardcaml` → no matches), so type checking and ppx
   elaboration have not run anywhere yet. The freeze record of both specs says
   `pending` for exactly this reason; the authoritative evidence is the `build`
   workflow run on the orchestrator's commit, and its run id belongs in §12 when
   it is green.
4. **Every constant in SPEC-M02 §6.1 was computed, not recalled.**
   `python3 -c "import zlib;print(hex(zlib.crc32(b'123456789')),hex(zlib.crc32(b'12345678')),hex(zlib.crc32(b'')),hex(zlib.crc32(b'9',zlib.crc32(b'12345678'))))"`
   → `0xcbf43926 0x9ae0daaf 0x0 0xcbf43926`. The first confirms REQ-303 at the
   port with no adjustment, the second is the intermediate in worked example 1,
   the third is the seed convention (CRC-32 of the empty string is 0x00000000),
   the fourth confirms the 8-then-1 chaining REQ-302 requires.
   `python3 -c "import zlib;f=bytes(range(60));print(hex(zlib.crc32(f+zlib.crc32(f).to_bytes(4,'little'))))"`
   → `0x2144df1c`, confirming REQ-304's residue at a 64-octet frame with the FCS
   appended least significant octet first (REQ-202); the same computation at
   1514 payload octets also gives `0x2144df1c`. Python's `zlib` is REQ-301's
   parameterisation and is the same oracle requirements.md §4's provenance note
   used; it is a cross-check here, not the REQ-305 bit-serial reference, which
   dv_lead owns.
   The two raw-register figures quoted in §6.1 note 3 are one XOR away:
   0xCBF43926 XOR 0xFFFFFFFF = 0x340BC6D9 and 0x2144DF1C XOR 0xFFFFFFFF =
   0xDEBB20E3, the latter being the published Ethernet residue in that
   convention, which is an independent confirmation that the two conventions were
   not mixed.
5. **Record cardinalities match the normative sources.** `Config` has twelve
   fields against requirements.md §9.1's twelve rows; `Status` has twenty-one
   fields against §12's twenty-one rows, in §12's order, with the names copied
   character for character.

### Outcome
DoD vs WO-0006: **met**, with one deliberate deferral.
- Both specs are template-complete: every numbered section 1–13 is present, and
  every section that does not apply says so with a reason rather than being
  dropped (SPEC-M01: §4.1's entry-point clause, §4.2's Dir column, §6.2, §7 all
  five clauses, §8, §9; SPEC-M02: §4.1's stream clause, §5, §6.2, §8, §9 and
  three clauses of §7).
- Every behavioural claim cites a REQ from the b4b4cf4 text; REQ-303/304 are
  cited with the provenance note pointed at rather than its history restated,
  as the WO asked.
- Both lifts are verbatim and parse; `crc32_eth_ifc.ml` opens `Axi64_ifc` and
  restates nothing.
- Status is DRAFT in both, with the four freeze rows explicitly `pending`.
- C-1 and C-4 were not attempted and are not regressed.
- **Deferral**: `traceability.md`'s Spec-section column for REQ-010…014,
  REQ-301…306 and REQ-802 still reads `pending`, because the WO's file set
  excludes the matrix. SPEC-TEMPLATE §10 wants it in the same commit; the WO
  wins, and the debt is booked (SPEC-M01 §11.2, Return log).
Handoff: `agents/handoffs/WO-0006_batch-a-specs.md`, state RETURNED, to the
orchestrator for commit and then to dv_lead for the batch-A testability
countersignature.

### Open-questions
1. **Two ADRs owed before freeze, both requested from the orchestrator** (this
   WO's file set excludes `docs/adr/`): (a) SPEC-M02's finished-value CRC port
   convention, with the raw-register alternative and the reason the conversion
   count decided it; (b) `octet_count` as a 4-bit count with domain 1–8, with the
   count-minus-one alternative. Charter §3 makes both ADR material and charter §6
   counts untraceable design choices against me.
2. **REQ-010's wording versus SPEC-M02's non-stream frame-carrying port** — the
   proposed spec diff narrows REQ-010 to frame-carrying *stream* ports and names
   M02. Raised, not applied, because requirements.md is read-only under this WO;
   it needs dv_lead's countersignature since it changes what the interface
   compile check quantifies over. Left unresolved, M02 is a literal invariant
   violation on the record.
3. **`Axi64.Source`'s field names are still unverified by any compile.**
   `tvalid`/`tdata`/`tkeep`/`tstrb`/`tlast`/`tuser`/`tready` are transcribed from
   `hardcaml_axi` v0.17.0's `stream_intf.ml` via architecture.md §10, and the
   green run 30724505231 used the type without naming a field, so a divergence
   would not have been caught. SPEC-M01 §4.2 and §6.1 quote them normatively and
   REQ-011/013/014's monitors will be written against them. Batch B settles it.
4. **`traceability.md` is eleven rows stale** (see Outcome). Either batch B's WO
   carries the matrix update for A and B together, or a small architect WO does
   batch A alone. This is a REQ-904 currency obligation with a CI script behind
   it at the row-set level, but the Spec-section column is not machine-checked,
   so it will not fail loudly.
5. **`SPEC-TEMPLATE.md` names a module that cannot exist** (`Ifc_check_axi64`;
   the real name is `Axi64_ifc`). Editorial one-line diff, outside this WO's file
   set, owed before batch B authors copy the wrong name.
6. **Whether M01 should home an XGMII lane-pair record** — deferred to batch B,
   where four restatements of the same two widths become visible (SPEC-M01
   §11.1). Adding it later is a spec diff to this file and to architecture.md §4.

### Files-in-this-commit
- agents/handoffs/WO-0006_batch-a-specs.md
- docs/specs/ifc_check/axi64_ifc.ml
- docs/specs/ifc_check/crc32_eth_ifc.ml
- docs/specs/modules/axi64.md
- docs/specs/modules/crc32_eth.md
