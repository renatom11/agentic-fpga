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

## [J-architect_docs_lead-0004] 2026-08-02T07:40:00Z | task:WO-0008 | Batch B (SPEC-M03/M04/M05), the §11 freeze reconciliation, four requirements diffs including the C-1 latency unit, and ADR-0006/0007

### Trigger
Orchestrator spawn for WO-0008 (`agents/handoffs/WO-0008_batch-b-specs.md`,
ISSUED at 2665a04), spawn short-id WO-0008/2026-08-02T05:55Z. Fourth
activation. The packet's ordering is load-bearing and I kept it: a batch that
dv_lead has already countersigned is sitting un-frozen because SPEC-TEMPLATE
§11 forbids open questions in a FROZEN spec and both batch-A specs carry four
each, so the reconciliation had to land before anything else could.

### Inputs
Repo at HEAD 2665a04, branch claude/fpga-hardcaml-agent-orchestration-37ceyf.
- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` §4, §6, §7, §10
- `agents/handoffs/WO-0008_batch-b-specs.md` (my packet)
- `agents/handoffs/WO-0006_batch-a-specs.md` — my own Return log and the
  orchestrator's ACCEPTED dispositions 1–6
- `agents/handoffs/WO-0007_batch-a-countersign.md` — dv_lead's verdicts, the
  finished-CRC verification table, the eleven "not applicable" judgements, and
  C-8/C-9/C-10
- `agents/handoffs/WO-0005_spec-diff-re-review.md` — the C-1 derivation
  (ΔC = (L + h)/8, and the stage-by-stage 24/25-cycle result)
- `docs/gates/P1-spec-freeze-checklist.md` — the ledger and the sponsor's
  2026-08-02 delegation of the latency budget
- `tasks/BOARD.md` — the same delegation, and WO-0009 running in parallel
- `docs/specs/modules/axi64.md`, `crc32_eth.md` at 22145b5 (SIGNED);
  `docs/specs/requirements.md` at b4b4cf4 (SIGNED); `architecture.md` §1, §2,
  §4, §6.3, §8; `SPEC-TEMPLATE.md`; `traceability.md`;
  `docs/specs/ifc_check/{dune,axi64_ifc.ml,crc32_eth_ifc.ml,template_ifc.ml}`
- `docs/adr/ADR-0004` (for ADR form)
- Not read: `libs/**`, `test/**`, `tools/**`, `rtl_snapshots/**`. No RTL exists
  and dv_lead is writing under `test/` and `tools/` in parallel (WO-0009).

### Reasoning

**1. What "FROZEN carries no open question" should mean.** The naive
reconciliations were both wrong. Forcing every §11 item closed before a freeze
would mean batch A cannot freeze until a CI run and a dv-owned script exist,
which makes the gate hostage to work that is not the spec's; deleting §11 at
freeze would destroy the tracking. What actually makes a spec unfreezable is
not that something is left — it is that a *reader is blocked*. So the amended
SPEC-TEMPLATE §11 distinguishes an open question (answer unknown, someone
downstream cannot proceed) from a deferred item (decision made and stated in
the spec's own normative sections; remaining work tracked elsewhere), and it
requires every deferred item in a FROZEN spec to state three things, of which
the second is the whole test: **what a reader assumes meanwhile**, in one
sentence they can act on today. An item that cannot state it is an open
question whatever it is called. I also made item numbers permanent with closed
rows kept in place, because dv_lead's countersignature and two Return logs cite
"§11.3" and "§11.4" by number and a renumbered table would make those citations
lie. Result: SPEC-M02 has four closed rows and nothing else; SPEC-M01 has three
closed and two deferred (the pending compile witness, and C-9's script), and
both now satisfy the amended rule.

**2. C-1, and why I kept dv_lead's identity but not the obvious remedy.**
dv_lead's finding is exact: for a stage stripping h octets, the word-cycle
delay is ΔC = (L + h)/8, so comparing floor(L/8) against §1.1 understates a
stripping stage by up to ⌈h/8⌉ cycles, and a chain sitting on every ceiling
costs 24 cycles at a lane-0 start and 25 at a lane-4 start — the entire REQ-006
budget or more — while every module passes REQ-019 individually. I recomputed
that stage by stage before adopting it and reproduced both totals.

The tempting remedy is to *lower the ceilings* until they fit under floor(L/8).
I rejected it: it changes five numbers to preserve a unit that is wrong, and
the unit is what is wrong. floor(L/8) is not additive; the quantity REQ-006
measures is a sum of word delays. So the resolution keeps the allocation
(4/3/1/5/4 = 17, slack 7, budget 24) and changes the unit the ceilings are
compared in, which makes §1.1 arithmetic rather than aspiration: the per-module
gate and the top-level gate now measure the same thing. I checked feasibility
before committing to it — the five stages need roughly 3, 3, 1, 4 and 2 cycles
of word delay to do their jobs, against ceilings of 4, 3, 1, 5 and 4, so the
allocation is not merely coherent but comfortable, and I pinned M03 at 3 rather
than at its ceiling of 4 so the hardest module keeps a cycle of its own.

Two further things fell out and are now stated normatively because they are
free checks: (L + h) must be a multiple of 8, so a spec pinning an impossible
constant is caught by arithmetic at freeze; and the §0.5 bound on the two
start-lane constants is exactly ΔC(lane 4) ∈ {ΔC(lane 0), ΔC(lane 0) + 1}.
Both copies of the table (requirements.md §1.1, architecture.md §4) changed
together, as architecture.md §4 itself requires.

**3. The three deferred batch-B design questions.**

*XGMII lane-pair home.* SPEC-M01 §11.1 said "batch B is where the cost becomes
visible", and it was: M03, M04 and M05 all needed the pair and M20 would have
been the fourth restatement of two widths. I homed an `Xgmii` record in M01.
The field names are `d` and `c` — terse, and deliberately so: `[@rtlprefix
"xgmii_rx"]` plus field `d` emits `xgmii_rxd`, which is REQ-017's exact port
name, and no longer field name can produce it. The cost is that I edited a spec
dv_lead has countersigned; it is an addition rather than a change to anything
they judged, it lands before the FROZEN flip, and it is flagged for their
batch-B countersignature rather than slipped in.

*`octet_count` = 0.* SPEC-M02 §11.2 deferred this to whoever could say whether
an update-by-zero actually occurs. Writing M03's and M04's sequencing answered
it: neither needs one, because the running-CRC register has an enable and a
cycle covering no frame octet is a cycle in which it holds. That left the
question of whether to define 0 as the identity anyway, for totality. I decided
against, and the deciding argument is not cost — an identity is free to build —
but observability: with 0 unconstrained, a sequencer that accidentally drives 0
produces a visibly wrong CRC in its own bench; with 0 defined as the identity,
the same accident is indistinguishable from correct behaviour. The value of a
total function is that no input is wrong, and that is exactly its cost here.

*M03's FCS-check formulation.* I chose the residue form. Both forms use M02
unchanged and neither is observable at the ports, so this is a specification
choice made for the reader: the residue needs no capture register and, more
importantly, no octet-order reassembly of the four received FCS octets — the
precise operation whose convention error this programme has already paid for
once (requirements.md §4's provenance note). It is one equality against one
constant dv_lead has independently reproduced at five frame lengths. Because it
is unobservable I recorded the alternative in §6.3 as admissible rather than
pretending a bench could catch it, which is the honest form of "specified, not
discovered in RTL".

**4. Numbers I had to derive rather than transcribe.** M03's constants come
from a pipeline argument I worked through rather than picked: to strip the FCS
without varying latency the module needs exactly one word of lookahead, so
output word 0 needs input through the second word after the start word at
*both* start lanes — which is why ΔC = 3 at both, and why L is 16 octet times
at a lane-0 start and 12 at a lane-4 start (the lane-4 frame's octets arrive
four octet times later while its first output word leaves on the same cycle).
The two differ by 4, inside §0.5's 8-octet-time bound. I checked the tightest
case for the residue comparison (terminate in lane 4, where the final CRC
update and the `tlast` word are formed on the same cycle) and it closes. M04's
constant is 1 cycle because an inserted preamble word is exactly one output
slot, which also fixes its storage at two words and makes `tready` bubble-free;
its 11-cycle frame period then follows from REQ-204's lane-0 rounding rather
than being asserted.

**5. Two co-occurrence rulings in SPEC-M03 §9 that requirements.md does not
make.** An error character *closes* a frame, so a start character after it
begins a new frame and pulses no `error_start_without_terminate`; and a start
character during REQ-108's post-truncation discard is the resynchronisation
REQ-108 demands, not a second abort. Both are readings a bench would otherwise
guess at, both are stated normatively, and both are flagged in the Return log
for dv_lead — I would rather have them contested now than discovered in a
sign-off packet.

**6. What I did not touch.** `docs/gates/**`: PROTOCOL §7 says signers do not
stage the gate checklist and the orchestrator transcribes, so the four ledger
dispositions (C-1, C-4, C-8, C-10 closed; C-5 and C-9 restated) are in the
Return log for transcription, not applied by me. `test/**` and `tools/**`:
dv_lead is in them right now under WO-0009. `docs/specs/ifc_check/dune`: it has
no `(modules)` field, so the three new lifts are picked up automatically and no
orchestrator action is needed — I checked rather than assumed.

### Actions
- Amended `docs/specs/SPEC-TEMPLATE.md`: §11 rewritten (deferred items versus
  open questions, the three required statements, permanent numbering, a
  recommended table form); §7's latency bullet restated in front offset and
  word delay; §4.1's `Ifc_check_axi64` → `Axi64_ifc`, with the same one-line
  fix in `template_ifc.ml` so the lift stays verbatim.
- SPEC-M01 `axi64.md`: added the `Xgmii` record (§2, §3, §4.1, §4.2, §6.1);
  restored REQ-013's "solely" with a §0.6 clause (C-10); corrected the
  `create`/`hierarchical` bullet and added a REQ-903 row (C-8); split the
  REQ-802/REQ-804 verification hooks into compile check plus the dv-owned
  script (C-9); added the `cfg_<field>` programme convention; §11 converted
  (three closed, two deferred); §12 filled as far as evidence allows.
- SPEC-M02 `crc32_eth.md`: §11 converted (four closed); §2, §3, §6.3, §10
  updated for the REQ-010 narrowing, the residue choice and the closed
  `octet_count` question; §12 filled as far as evidence allows.
- `requirements.md`: REQ-010 narrowed to frame-carrying *stream* ports naming
  M02; REQ-903 split into an `.mli` half and a `hierarchical` half with M01
  excluded from the second only; REQ-105 and REQ-110 given their
  zero-delivered-octet cases and §0.7 extended to match (C-4); §0.5 given the
  front offset, the word delay and the start-lane corollary; REQ-019, REQ-006
  and §1.1 restated in word delay with an h column (C-1).
- `architecture.md`: §4's ceiling table restated in word delay with h, plus the
  reason; M01's inventory row now names the `Xgmii` record and REQ-017.
- New: `docs/adr/ADR-0006-crc32-finished-value-ports.md`,
  `docs/adr/ADR-0007-octet-count-encoding.md`.
- New: `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03),
  `xgmii_tx_64.md` (SPEC-M04), `eth_mac_10g.md` (SPEC-M05), all DRAFT and
  template-complete, with lifts `xgmii_rx_64_ifc.ml`, `xgmii_tx_64_ifc.ml`,
  `eth_mac_10g_ifc.ml`. The M03 lift names all six `Axi64.Source` fields and
  the M04 lift names `Axi64.Dest.tready`, in compile-time witnesses.
- `traceability.md`: Spec-section column filled for 53 rows (batch A and batch
  B), plus the convention for invariant rows and a currency note.
- Appended the RETURNED entry to `agents/handoffs/WO-0008_batch-b-specs.md`.

### Evidence
All commands run from a clean checkout of the working tree at this commit's
content. Hardcaml is **not installed in this container**, so no lift was type
checked or ppx-elaborated here; per ADR-0005 the CI `build` run on the
orchestrator's commit is the only acceptable evidence for that, and every
freeze record says `pending` accordingly.

1. **Lifts are byte-identical to their §4.1 blocks** (extract the first
   ```ocaml fence from each spec, compare to the lift):
   `python3 -c` script comparing the five pairs — result `OK` for
   axi64/crc32_eth/xgmii_rx_64/xgmii_tx_64/eth_mac_10g (4121, 1139, 1732, 1573
   and 1493 bytes respectively, equal on both sides). The template's own lift
   differs only in its pre-existing four-line header comment, as it did before
   this work order; the body, including the corrected `open! Axi64_ifc` line,
   is identical.
2. **All six lifts parse**: `ocamlc -stop-after parsing docs/specs/ifc_check/*.ml`
   → `parse OK` for all six. Parsing only — no typing, no ppx.
3. **REQ set equality survives every requirements.md diff**: ids extracted from
   requirements.md's tables and from traceability.md's rows → 110 and 110,
   symmetric difference empty, `SET EQUAL`. The strobe appendix still
   enumerates 21 strobes, matching SPEC-M01's `Status` record, which this work
   order did not touch.
4. **Template completeness**: sections 1–13 present in all five module specs
   (`axi64`, `crc32_eth`, `xgmii_rx_64`, `xgmii_tx_64`, `eth_mac_10g`).
5. **Strobe-name conformance**: every `error_*` name used in the three new
   specs is in requirements.md §12 — 5 names in SPEC-M03, 2 in SPEC-M04, 6 in
   SPEC-M05, none outside the appendix.
6. **C-1 arithmetic, recomputed rather than transcribed.** Under floor(L/8) the
   §1.1 ceilings admit L = 32, 26, 8, 44, 32 octet times (largest values with
   (L + h) ≡ 0 mod 8), i.e. word delays 5, 5, 1, 8, 5 at a lane-0 start
   (total 24) and 6, 5, 1, 8, 5 at a lane-4 start (total 25) — reproducing
   dv_lead's WO-0005 figures exactly. Under the word-delay unit the same table
   admits 4 + 3 + 1 + 5 + 4 = 17, leaving REQ-006's declared 7 cycles of slack.
7. **M03's constants check against §0.5**: (L + h) = 16 + 8 = 24 and
   12 + 12 = 24, both multiples of 8, both giving ΔC = 3 ≤ the ceiling of 4;
   |16 − 12| = 4 ≤ 8 octet times, satisfying REQ-111 and §0.5's start-lane
   bound. M04: 8 octet times = 1 cycle, and the §6.1 cycle table closes at 11
   cycles per minimum-length frame with a 16-octet gap, which is REQ-209's and
   REQ-204's figures.
8. **No out-of-scope writes**: `git status --porcelain` shows my seventeen
   paths plus dv_lead's concurrent `agents/handoffs/WO-0009_bench-machinery.md`,
   `test/**` and `tools/**`, which I did not create, open for writing or
   modify. `docs/gates/**` is unmodified.
9. `git commit` and `git push` were never run.

### Outcome
DoD vs WO-0008: **met**, with one item that evidence rather than work
completes.
- Deliverable 1 (§11 reconciliation): done. Both batch-A specs carry zero OPEN
  items under the amended wording; C-10 folded in; the template naming fix
  applied in both the template and its lift.
- Deliverable 2 (requirements diffs): done — REQ-010, REQ-903 (C-8), REQ-105 and
  REQ-110 (C-4), with set equality re-verified.
- Deliverable 3 (C-1): resolved by keeping the allocation and changing the unit
  to the word delay, stated in one place (§0.5) and cross-referenced from
  REQ-006, REQ-019, §1.1, architecture.md §4 and each module spec's §7.
- Deliverable 4: ADR-0006 and ADR-0007 written, each with the rejected
  alternative and the deciding argument.
- Deliverable 5: traceability Spec-section column filled, 53 rows.
- Deliverable 6: SPEC-M03, SPEC-M04, SPEC-M05 DRAFT and template-complete, with
  byte-identical lifts; the M03 lift names the `Source` fields and the M04 lift
  names `Dest.tready`; the three deferred design questions resolved and
  recorded.
- **Not completed here, and not completable here**: the batch-A DRAFT → FROZEN
  flip. It needs a green `ifc_check` run naming this commit and the SHA that
  run cites (ADR-0005), neither of which exists before the orchestrator
  commits. Both specs' §12 carry everything else, and the flip is a two-row
  edit with nothing left to decide.

I sign SPEC-M01 and SPEC-M02 for `P1-spec-freeze` as architect, conditional on
the `ifc_check` run for this commit reporting `success`; dv_lead's
countersignature is `J-dv_lead-0003` plus the batch-B countersignature over
this revision's diffs. Handoff:
`agents/handoffs/WO-0008_batch-b-specs.md`, state RETURNED.

### Open-questions
1. **C-1's resolution needs dv_lead's explicit judgment**, which the sponsor's
   delegation makes decisive: what the two of us converge on at the batch-B
   countersignature is authorised without a further touchpoint. I adopted the
   identity and rejected the alternative remedy of lowering the ceilings; if
   dv_lead prefers the ceilings move instead, that is a §1.1 diff and my
   pinned M03 constants survive either way.
2. **SPEC-M01 §4.1 changed after dv_lead countersigned it** (the `Xgmii`
   record). It is an addition, not a change to a judged section, and it lands
   before the FROZEN flip — but it is a signed artifact and dv_lead should say
   so explicitly rather than have it inferred from silence.
3. **Two SPEC-M03 §9 co-occurrence rulings and one SPEC-M04 §9 ruling are
   mine, not requirements.md's**: an error character closes a frame so a
   following start character pulses nothing; a start character during REQ-108's
   discard is resynchronisation, not a second abort; and on underflow the
   already-accepted words are transmitted before the `/E/` because REQ-207
   forbids dropping them. Each is a bench-visible decision.
4. **`Axi64.Source`/`Dest` field names are still unverified by any compile at
   the moment I hand this over.** The witnesses are written and will fail the
   build if a name is wrong — which is the point — but a red run on this commit
   is a possible and intended outcome, and the repair is editorial.
5. **M06's §1.1 ceiling of 3 is exactly its feasible word delay** (h = 14 means
   output word 0 spans two input words, so 2 cycles combinational and 3
   registered). Batch C should know it has no headroom there before it pins a
   constant; the architect's 7 cycles of slack are the release valve and
   releasing them is a spec diff.
6. **`error_underflow`'s §0.6 window is vacuous** (ledger C-5) because the
   offending frame never receives its last octet. SPEC-M04 §9 pins the pulse
   cycle exactly so nothing depends on the window, but the editorial repair to
   §0.6 is still owed.

### Files-in-this-commit
- agents/handoffs/WO-0008_batch-b-specs.md
- docs/adr/ADR-0006-crc32-finished-value-ports.md
- docs/adr/ADR-0007-octet-count-encoding.md
- docs/specs/SPEC-TEMPLATE.md
- docs/specs/architecture.md
- docs/specs/ifc_check/axi64_ifc.ml
- docs/specs/ifc_check/eth_mac_10g_ifc.ml
- docs/specs/ifc_check/template_ifc.ml
- docs/specs/ifc_check/xgmii_rx_64_ifc.ml
- docs/specs/ifc_check/xgmii_tx_64_ifc.ml
- docs/specs/modules/axi64.md
- docs/specs/modules/crc32_eth.md
- docs/specs/modules/eth_mac_10g.md
- docs/specs/modules/xgmii_rx_64.md
- docs/specs/modules/xgmii_tx_64.md
- docs/specs/requirements.md
- docs/specs/traceability.md

## [J-architect_docs_lead-0005] 2026-08-02T11:05:00Z | task:WO-0011 | Batch C (SPEC-M06/M07/M08/M09), the first post-freeze spec-diff cycle (C-11 to C-14), the 116-edge topology table and ADR-0008

### Trigger
Orchestrator spawn for WO-0011 (`agents/handoffs/WO-0011_batch-c-specs.md`,
ISSUED at 482b03a), spawn short-id WO-0011/2026-08-02T09:50Z. Fifth activation.
The packet's ordering is load-bearing and I kept it: the four WO-0010
carry-forwards come first because they touch FROZEN specs and are the §13
machinery's first real exercise, and a diff cycle that goes wrong is worse than
a batch that lands late.

### Inputs
Repo at HEAD 482b03a, branch claude/fpga-hardcaml-agent-orchestration-37ceyf.
- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` §4, §6, §7, §10
- `agents/handoffs/WO-0011_batch-c-specs.md` (my packet)
- `agents/handoffs/WO-0010_dual-batch-countersign.md` — dv_lead's whole Return
  log: the C-1 recomputation, the three batch-B verdicts, the §4.1 `Xgmii`
  acceptance, the six §9 ruling confirmations, C-11's replacement text, C-12's
  proposed ruling, C-13, and the five C-14 readings with the reading each
  signature fixes
- `docs/gates/P1-spec-freeze-checklist.md` — the ledger, the per-batch freeze
  table (A and B FROZEN at f78766e), and both transcribed countersignatures
- `docs/specs/modules/{axi64,crc32_eth,xgmii_rx_64,xgmii_tx_64,eth_mac_10g}.md`
  — the FROZEN batch A+B text, read in full before editing any of it
- `docs/specs/{requirements,architecture,traceability,SPEC-TEMPLATE}.md`
- `docs/specs/ifc_check/{dune,axi64_ifc.ml,crc32_eth_ifc.ml,xgmii_rx_64_ifc.ml,eth_mac_10g_ifc.ml}`
- `docs/adr/ADR-0007-octet-count-encoding.md` (for ADR form)
- `tools/check_records_vs_appendix.sh` and `tools/dv_checks.sh` — **read and
  run, never edited**: they are dv_lead's, and I needed to know exactly what
  "byte identical" means mechanically before writing four new §4.1 blocks
- Not read: `libs/**`, `rtl_snapshots/**`. No RTL exists. `test/**` was not
  opened for writing; dv_lead is in it under WO-0012 right now.

### Reasoning

**1. The five frozen specs said DRAFT, and I fixed that before anything else.**
The gate table has said FROZEN at f78766e since 482b03a; all five spec files
still carried `Status: DRAFT` and `pending` freeze records. Nobody asked me to
flip them. But SPEC-TEMPLATE §13 is defined as "post-freeze changes only", and I
was about to write §13 rows into two specs whose own header denied they were
frozen — a §13 row in a DRAFT spec is either meaningless or a lie about when the
freeze happened. The flip is transcription, not decision: every value in the
four §12 rows already existed in committed artefacts (run 30729342467 at
f78766e; `J-architect_docs_lead-0004`; `J-dv_lead-0005`). I closed six deferred
items in the same pass, each against evidence rather than by assertion — the two
field-name witnesses that the green run settles, the two §9/§11 ruling items
dv_lead confirmed, and C-9's script which is now live, CI-wired and green. I did
**not** touch `docs/gates/**`: PROTOCOL §7 makes signature transcription the
orchestrator's, and although `docs/gates` is technically inside my write scope,
the whole point of that rule is that a signer does not edit the record of its
own signature.

**2. C-12 needed a requirements diff, and working out why is most of the value
in this entry.** dv_lead's proposed ruling is right and I adopted it unmodified:
an error character during REQ-108's `Discard` pulses nothing, because the frame
is closed and a strobe attributable to an already-counted frame breaks §0.6's
conservation equation. The tempting move was to land it only in SPEC-M03 §9,
which is what the packet's literal words asked for. I rejected that: REQ-105's
own text says "an `/E/` between the start character and the terminate
character", and REQ-108 closes the frame **without a terminate character ever
arriving**, so REQ-105 reads true during `Discard`. A tb_writer holding the REQ
excerpt and not the spec — which is exactly the reader PROTOCOL §10 constructs —
would derive the assertion the ruling forbids. So the ruling had to reach the
requirement, and the general form of it is what I actually wrote down: SPEC-M03
§9 now carries an explicit **closure list** (terminate, error-while-open, new
start, REQ-108 truncation, `clear`) and states that every row of §9 is evaluated
only while the frame is open. That converts a one-corner ruling into a rule with
no remaining corners, which is the difference between answering C-12 and
answering the class of question C-12 is an instance of.

**3. C-14: I fixed all five and defended none, and the packet invited me to
defend.** Judged one at a time, the reason to fix was different each time and
worth separating. C-14.1 is not a loose sentence, it is a sentence that forbids
what REQ-209 requires — no conformant design can have `tx_tready` = 0 across the
whole gap and still emit a frame every 11 cycles — so there was nothing to
defend. C-14.3 looked at first like harmless conservatism (a drain window one
cycle wider than necessary), and I nearly defended it on that basis; what
changed my mind is that REQ-109's own verification column already says "no
output activity from 3 cycles after the terminate character onward", so §6.1
permitted precisely the cycle REQ-109 forbids. That is a contradiction between
two normative texts, not a margin. I re-derived the tight bound before adopting
dv's figure — with N = 8q + r octets between start and terminate, the terminate
word is cycle q + 1 and the `tlast` word is q + 2 for r ≤ 4 and q + 3 for r ≥ 5
— and got 2 at both start lanes independently. C-14.4 is §0.5's own qualifier
dropped, and defending it would have meant withdrawing the idle-injection hook
§10 commissions against the same module. C-14.2 and C-14.5 are completeness
defects in tables a bench reads directly; an implication is not a permission a
test writer can rely on. **Every one of the eight §13 rows is non-breaking**,
which is the part I care about for the churn count: §4.1 is byte-for-byte
unchanged in both specs, and dv_lead's own record-versus-lift script confirms it
at this commit.

**4. The transmit-side header handshake — the one real design decision in batch
C.** M01's header records carry `valid` and no `ready`, frozen at f78766e. On the
receive path that is not just fine but forced: REQ-003 forbids backpressure on a
receive-path port, and a header record travelling with a receive-path payload is
one. Batch C put those records on the transmit path for the first time, where
M07 must be able to refuse a frame (M04 stalls it every frame) and M09 must be
able to grant one of two — and arbitration *is* refusal. The obvious repair is to
add `ready` to the records, and I rejected it on two independent grounds: it puts
a backpressure field on a record used at receive-path ports, so REQ-003's
structural check would need an exception and an invariant with an exception stops
being a guarantee; and it is a breaking change to a frozen spec for a problem
with a non-breaking answer. The alternative I spent longest on was keeping
`valid` a one-cycle pulse with mandatory capture — it looks workable until you
write the arbiter, where two sources pulsing simultaneously means the loser's
header is lost and its payload arrives orphaned. What I chose instead:
**the header record and the frame's first payload word are offered on the same
cycle and held together until that word is accepted, and the acceptance of the
word is the acceptance of the header.** The grant becomes observable on
`payload_tready`, a wire REQ-207 already requires, so there is no second
handshake for a bench to monitor and no way for two handshakes to disagree. The
cost is real and I wrote it down rather than hiding it: `valid` now has two
disciplines, chosen by port direction, and every affected §7 says which one binds
its own ports. This is ADR-0008, because it binds five modules across three
future batches and no single spec can own it.

**5. Numbers I derived rather than picked.** M06's ΔC = 3 is forced: payload
octets 0–7 span input words 1 and 2 because the header is 14 octets, input word 2
arrives at Ci + 2, and a registered output emits at Ci + 3. L = 8·ΔC − h =
24 − 14 = **10** octet times, and §1.1's independently written "largest L the
ceiling permits" column also says 10 — two numbers agreeing without being copied
from each other, which is the check C-1 bought. M08 is the one module with h = 0,
so ΔC = L/8 = 1 and L = 8, and it is the one module where the C-1 change of unit
moves nothing at all; I said so in its §7 because a reader wondering why one row
of §1.1 looks different deserves the answer in place. Two consequences of M06's
arithmetic that I checked rather than assumed: stripping 14 octets removes one or
two words, so M ∈ {K − 1, K − 2}, from which both the abort bit's availability
(the input `tlast` always arrives at least one cycle before the output `tlast`
word leaves) and REQ-410's back-to-back non-collision follow — neither needed a
design choice, both needed the inequality. **M06 sits exactly on its ceiling with
no cycle in reserve**, which is the position SPEC-M03 §7 deliberately avoided for
M03. I chose to state that as a decision with its consequence attached — a fourth
cycle is a slack release against the architect's 7, touching §7, §1.1 and
architecture.md §4 in one diff — rather than quietly spending a slack cycle now.
Slack spent "just in case" is slack gone; dv_lead named M06 as one of the two
modules it would spend slack on, which is a reason to keep the seven cycles
liquid, not a reason to spend one.

**6. The connection table: what to enumerate, and where I refused to.** The
packet asked for one row per edge for all twenty modules. Enumerated completely
at port granularity — including every configuration field at every wrapper hop
and every strobe at every wrapper hop — that is about 165 rows, of which ~90 are
status and configuration relays through wrappers that relay everything unchanged
by name. A block diagram with 150 status edges teaches nobody anything, and rows
that restate a rule are rows that can drift from it. So the datapath is
enumerated **completely** (26 rx + 39 tx, every edge of §6.1 and §6.2 expanded
through the wrapper levels §6.3 implies), control is enumerated completely
(29 rows), and status is the one summarised class: one row per strobe at the
module that raises it, plus the top-level aggregation, with the relay rule stated
so a renderer can compute the hops. I wrote down that this is a summary, in the
section, because an unlabelled summary in a table called "connection table" is
the kind of thing an auditor is right to find. Two other honesty items went in
the prose rather than being left to inference: M01 appears in **no** row (it has
no ports, so it has no edges — it is in the type column of nearly every row
instead), and M02's eight rows name an internal signal of M03 and M04 on one
side, because M02 is a combinational function instantiated inside them and a
table that dropped it would be missing an inventory module. Rows naming M10–M20
are provisional in their **port names only** — the edges and types are what the
diagrams already commit to — and each later batch confirms or amends its own rows
in the same commit as its specs, which is the same rule SPEC-TEMPLATE §10 already
imposes on the traceability matrix. I put a fifth column for provisionality in a
draft and took it out again: the orchestrator parses this table, and a variable
column count is a worse defect than a rule stated in prose.

**7. requirements.md gained a §13.** It is not a module spec and SPEC-TEMPLATE's
§13 does not bind it, but dv_lead's testability countersignature at b4b4cf4 is
what the entire test-derivation basis rests on, and REQ-level churn after it
should be countable by the auditor without reading four journals. Seven rows,
every diff since that signature, each with its class — all editorial so far —
the ledger item that commissioned it, and the journal entry. It cost twelve lines
and it makes "how much has moved since DV signed" a question with an answer.

**8. What I did not touch.** `docs/gates/**` — reason in item 1. `test/**` and
`tools/**` — dv_lead is in them under WO-0012 right now; I ran two of its scripts
read-only and edited neither. `docs/specs/ifc_check/dune` — it has no `(modules)`
field, so the four new lifts are picked up automatically; I re-checked rather
than remembering. SPEC-M01 §6.1 — dv_lead analysed it under C-11 and found it
already on the corrected side, and a frozen spec should not be opened for a
sentence it does not contain.

### Actions
- **Freeze transcription**: `Status` → FROZEN at f78766e and §12's four rows
  filled in `axi64.md`, `crc32_eth.md`, `xgmii_rx_64.md`, `xgmii_tx_64.md`,
  `eth_mac_10g.md`; six deferred items closed (SPEC-M01 §11.4 and §11.5;
  SPEC-M03 §11.1 and §11.3; SPEC-M04 §11.1 and §11.2); §13 statements added to
  the three specs with no post-freeze change.
- **C-11**: `requirements.md` REQ-015 — third sentence deleted, the count made
  inclusive of the `tlast` word, the one-word frame stated legal and mandatory;
  SPEC-M03 §7's handshake bullet moved in the same diff with a note recording
  the deletion.
- **C-12**: `requirements.md` REQ-105 (open-frame clause) and REQ-108 (nothing
  emitted or pulsed between truncation and the next start character), both
  verification columns extended; SPEC-M03 §9 gained a closure list, a third
  table row and an `error_oversize`/`error_bad_frame` bullet; §6.2's `Discard`
  row and §6.3 item 6 added; §11.4 opened and closed.
- **C-13**: `requirements.md` REQ-010 — census corrected to seven ports in two
  classes, the six XGMII lane pairs named, the converse compile check stated.
- **C-14**: SPEC-M03 §6.1 (drain bound derived; gapless qualifier), §6.2
  (`Frame` row), §6.3 item 7, §4.3, §10's REQ-016/REQ-109/REQ-802 rows, §11.5;
  SPEC-M04 §7 (throughput and reset bullets rewritten), §6.2 `Idle` row, §6.3
  item 5, §4.3, §10's REQ-009/REQ-209 rows, §11.4. Eight §13 rows in total,
  all non-breaking.
- **New specs**: `docs/specs/modules/{eth_axis_rx,eth_axis_tx,eth_demux,eth_arb_mux}.md`
  (SPEC-M06 … SPEC-M09), DRAFT and template-complete, with lifts
  `{eth_axis_rx,eth_axis_tx,eth_demux,eth_arb_mux}_ifc.ml` generated **from** the
  §4.1 fences so byte-identity is mechanical rather than careful.
- **New ADR**: `docs/adr/ADR-0008-transmit-header-handshake.md`.
- **architecture.md**: new `### 6.4 Connection table` (116 rows in four
  sub-tables plus its parsing contract, class definitions and completeness
  rule); §8 gained a dated currency note on batch status.
- **traceability.md**: ten rows filled (REQ-401 … REQ-410); currency bullet
  extended; a bullet recording that the four REQ diffs preserve set equality.
- **requirements.md**: new `## 13. Revision record`, seven rows.
- Appended the RETURNED entry to `agents/handoffs/WO-0011_batch-c-specs.md`.

### Evidence
All commands run from the working tree at this commit's content. Hardcaml is
**not installed in this container**, so no lift was type checked or
ppx-elaborated here; per ADR-0005 the CI `build` run on the orchestrator's
commit is the only acceptable evidence, and all four batch-C freeze records say
`pending` accordingly.

1. `tools/check_records_vs_appendix.sh` → `12 check(s) run, 0 failure(s)`, up
   from 8 before this work order. The four new pairs report
   `modules/<m>.md §4.1 == ifc_check/<m>_ifc.ml (byte identical)`; the five
   pre-existing pairs still pass, so no frozen §4.1 moved; and
   `Status record = requirements.md §12 (21 strobes, same order)` plus
   `Config record = requirements.md §9.1 (12 fields, widths equal in order)`
   still pass over the edited requirements.md — the new §13 does not disturb
   §12's extraction, which was the one mechanical risk in appending to that
   file.
2. `tools/dv_checks.sh` → exit 0, `4 check(s) run, 0 failure(s), 4 pending`.
3. `ocamlc -stop-after parsing` over `docs/specs/ifc_check/*.ml` → parse OK for
   all ten. Parsing only — no typing, no ppx, no elaboration.
4. REQ set equality, recomputed from the edited files: **110 ids in
   requirements.md, 110 in traceability.md, symmetric difference empty**.
5. Template completeness: sections 1–13 present in all nine module specs
   (mechanical check for the nineteen required headings). Strobe-name
   conformance: every `error_*` name used in the four new specs is in
   requirements.md §12 — 1 in SPEC-M06, 3 in SPEC-M07 (all as cross-references
   to other modules' strobes), 1 in SPEC-M08, 1 in SPEC-M09 — none outside the
   appendix.
6. Connection table re-parsed from the committed architecture.md with a
   four-column reader: **116 rows, 0 syntax-irregular, 0 duplicate edges**,
   class counts rx 26 / tx 39 / control 29 / status 22, nineteen inventory
   modules present, M01 absent as the section documents, three pseudo-nodes
   (`WIRE`, `APP`, `EXT`).
7. Arithmetic derived rather than transcribed: M06 (L + h) = 10 + 14 = 24, a
   multiple of 8, ΔC = 3 against a ceiling of 3, and §1.1's independently
   written "largest L" column gives 10; M08 (8 + 0) = 8, ΔC = 1 against a
   ceiling of 1, largest-L column 8. C-14.3's drain bound reproduced
   independently: terminate word at cycle q + 1, `tlast` word at q + 2 (r ≤ 4)
   or q + 3 (r ≥ 5) at a lane-0 start and one less at a lane-4 start, maximum
   **2** = ΔC − 1. M06's M ∈ {K − 1, K − 2} checked at N = 14, 15 and 22.
8. `git status --porcelain` shows my eighteen paths plus dv_lead's concurrent
   `test/**` and `tools/**` under WO-0012, which I did not create, open for
   writing or modify. `docs/gates/**`, `libs/**` and `rtl_snapshots/**` are
   unmodified.
9. `git commit` and `git push` were never run.

### Outcome
DoD vs WO-0011: **met**, with one item that evidence rather than work completes.
- Deliverable 1 (the four diff sets, first): done. C-11 applied with one clause
  retained and the reason stated; C-12 adopted and landed in three places
  because the ruling contradicts REQ-105's literal text; C-13 applied; C-14 all
  five fixed with a per-reading judgment table in the Return log. Eight §13
  rows, all non-breaking; post-freeze interface churn after this cycle is zero.
- Deliverable 2 (SPEC-M06 … M09): done. DRAFT, template-complete, lifts
  byte-identical, `open! Axi64_ifc`, no record restated; realignment latency in
  octet times (M06 L = 10 / h = 14 / ΔC = 3; M08 L = 8 / h = 0 / ΔC = 1) under
  the sealed unit and inside §1.1's ceilings. **The `ifc_check` compile evidence
  is pending** — the one item work cannot complete here (ADR-0005).
- Deliverable 3 (connection table): done. 116 rows, re-parsed, with its parsing
  contract, class definitions, provisionality rule and the one summarised class
  labelled as such.
- Deliverable 4 (traceability): done. Ten rows; set equality verified at 110.
- Extra, not asked for: the five frozen specs' Status and §12 rows now agree
  with the gate table; six deferred items closed; ADR-0008; requirements.md
  §13.
- Handoff: `agents/handoffs/WO-0011_batch-c-specs.md`, RETURNED, with the
  ledger dispositions for the orchestrator to transcribe into `docs/gates/`.

### Open-questions
1. **Batch C needs an `ifc_check` run** on the commit carrying it — four
   `pending` §12 rows are waiting for its id, and it is the only thing between
   these specs and a countersignature request.
2. **ADR-0008 binds three unwritten specs** (M11, M15, M18) through their
   source-side obligation. If dv_lead reads the held-`valid` transmit discipline
   differently, batch C's countersignature is the cheap moment to say so; it is
   flagged in SPEC-M07 §11.2 and SPEC-M09 §11.3.
3. **M06 is pinned exactly at its §1.1 ceiling** with no cycle in reserve. No
   action today; recorded so that a later request for a fourth cycle arrives as
   a slack release against the architect's seven and not as a surprise.
4. **C-3 and C-5 remain open**, unchanged by this work order and both tracked
   in specs (SPEC-M08 §11.2, SPEC-M04 §11.3).

### Files-in-this-commit
- agents/handoffs/WO-0011_batch-c-specs.md
- docs/adr/ADR-0008-transmit-header-handshake.md
- docs/specs/architecture.md
- docs/specs/ifc_check/eth_arb_mux_ifc.ml
- docs/specs/ifc_check/eth_axis_rx_ifc.ml
- docs/specs/ifc_check/eth_axis_tx_ifc.ml
- docs/specs/ifc_check/eth_demux_ifc.ml
- docs/specs/modules/axi64.md
- docs/specs/modules/crc32_eth.md
- docs/specs/modules/eth_arb_mux.md
- docs/specs/modules/eth_axis_rx.md
- docs/specs/modules/eth_axis_tx.md
- docs/specs/modules/eth_demux.md
- docs/specs/modules/eth_mac_10g.md
- docs/specs/modules/xgmii_rx_64.md
- docs/specs/modules/xgmii_tx_64.md
- docs/specs/requirements.md
- docs/specs/traceability.md

## [J-architect_docs_lead-0006] 2026-08-02T14:55:00Z | task:WO-0014 | Batch D (SPEC-M10/M11/M12/M13), the third post-freeze diff cycle (C-15 to C-18), the batch-C freeze flip and the 117-edge topology

### Trigger

Orchestrator work order `agents/handoffs/WO-0014_batch-d-specs.md` (ISSUED at
55e78f2), my sixth activation. Three numbered deliverables in a stated order:
the WO-0013 diff set first, then the four ARP-family specifications, then the
traceability rows. The ordering is not decoration — C-16 and C-18 are corrections
to text SPEC-M10 and SPEC-M13 quote and rely on, and writing batch D first would
have meant citing sentences I already knew were wrong.

### Inputs

- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` (§3, §4, §6, §7,
  §10).
- `agents/handoffs/WO-0014_batch-d-specs.md` — the work order.
- `agents/handoffs/WO-0013_batch-c-countersign.md` Return log at 76906e6 —
  dv_lead's `J-dv_lead-0007` verdict, read in full: the four batch-C
  signatures, the eight §13 reaffirmations, ADR-0008's acceptance, and the exact
  analyses for C-16, C-17(a)…(e) and C-18. This is the document the diff set is
  derived from and I re-derived every arithmetic claim in it rather than
  transcribing.
- `agents/handoffs/WO-0012_dv-wave2.md` Return log — dv's C-15 clause.
- `docs/specs/requirements.md` §0.3 … §0.7, §1.1, §6 (REQ-501 … REQ-512), §9,
  §9.1, §10, §12, §13.
- `docs/specs/architecture.md` §2.5, §4, §5, §6.3, §6.4, §8.
- `docs/specs/SPEC-TEMPLATE.md`; `docs/specs/traceability.md`.
- FROZEN `docs/specs/modules/{xgmii_rx_64,xgmii_tx_64,eth_mac_10g}.md`
  (batches A/B) and `{eth_axis_rx,eth_axis_tx,eth_demux,eth_arb_mux}.md`
  (batch C, at 508eea2 — verified unmoved: `git diff --stat 508eea2 HEAD --
  docs/specs/ docs/adr/` is empty).
- `docs/adr/ADR-0008-transmit-header-handshake.md`;
  `docs/gates/P1-spec-freeze-checklist.md`.
- `docs/specs/ifc_check/{dune,axi64_ifc.ml,eth_demux_ifc.ml,eth_arb_mux_ifc.ml}`
  for the lift conventions; `tools/check_records_vs_appendix.sh` (read only, to
  match its extraction rule exactly).
- GitHub API, `renatom11/agentic-fpga`, run **30733153172**: `name` `build`,
  `head_sha` `f457efc85d367c7903bee32f4ba31f6e067db0fb`, `status` `completed`,
  `conclusion` `success` — fetched myself rather than relayed from dv's packet.
- `libs/**`, `test/**` and `top/**` were **not** opened. Nothing here derives
  from RTL or from a bench.

### Reasoning

**Why the diff set came first, and what it cost to do it honestly.**

*C-16* was the item I had to think hardest about, because dv's finding is not
"this sentence is wrong" but "this sentence is incomplete, and the cycle it omits
is the one the whole transmit cadence turns on". SPEC-M04 §6.1's table has
asserted `tx_tready` = 1 at C+8 since the specification was written; §6.2 has no
state that accepts a first source word there; and §6.1's "accepted at C+m,
transmitted at C+m+2" cannot hold for a word accepted there, because C+10 is the
terminate word. Three sections, each individually defensible, jointly silent.

I considered making C+8 a 0 cycle, which would have made §6.2 and the C+m+2 rule
true as written. I rejected it after composing the chain: M07 re-enters `Idle` at
its own C+9 — one cycle after M04 accepts its `tlast` output word — and M07 §6.2's
`Idle` row asserts `payload_tready` only on a cycle with `tx_tready` = 1. With
`tx_tready` = 0 at C+8 the next chance is C+11, M07 emits its output word 0 at
C+12, M04 accepts at C+12 and starts at C+13: twelve cycles between start
characters, REQ-209 failed, and the composed assertion SPEC-M07 §8 and SPEC-M09
§8 item 5 both commission failed with it. dv's derivation and mine agree.

So the value is 1 and the question is what a word presented there *does*. The
answer that survives every other frozen sentence is: it is the **next** frame's
first word, it takes the storage slot the current frame's word 6 vacates on that
same cycle (so the two-word depth is untouched — at the end of C+8 M04 holds the
`tlast` word and the new word 0), and it is transmitted at C+13, because back to
back it is REQ-204's rounded gap and not M04's depth that fixes the start
character — which §7's REQ-210 bullet already said and which I had not connected
to this cycle. The start character is at C+12 whether the first word arrived at
C+8 or at C+11, so REQ-209 holds either way; and the two cannot both fill both
slots, which is what the existing "may also be 1 during the preamble word"
sentence is now carrying explicitly. I also checked that C+8 is *not* an
underflow cycle: §9's condition and §7's handshake bullet both end at the
acceptance of the `tlast` word, which happened at C+7. That was the piece that
made the whole thing consistent rather than a new freedom — the specification had
already excluded the cycle from REQ-206 and simply never said what it had
included it in. §6.2's `Idle` row needed one clause and the table one paragraph;
no constant, no strobe, no gap arithmetic and no record moved.

*C-17* I judged item by item rather than applying, because the packet asked for
"fix or defend each explicitly" and because two of the five were larger than
stated.

(a) I re-derived M and K from scratch: M = K − 1 for N ≡ 0 or 7 (mod 8) and
K − 2 otherwise, so M + 2 ∈ {K, K + 1}. dv is right that `M + 2 ≤ Ci + K` is the
inversion of the inequality the abort paragraph two paragraphs earlier proves,
and right that it fails on any 64-octet input — which is §8's own stress frame,
the worst possible place for it. I wrote **both** directions into the repaired
paragraph rather than only the one this argument needs, because the two
paragraphs drifting apart is exactly how the defect arose.

(b) dv named three places. I found five: §8's "one-or-two-cycle backpressure" and
§10's REQ-207 hook carry the same figure. The underlying confusion is worth
naming and the repair now names it: W − J is the *word surplus* and is correctly
1 or 2; the *stall count* is W − J + 1 and is 2 or 3, because the cycle the last
payload word is accepted on is not stalled and the cycle the last output word
leaves on is. I also tied §8's figure to SPEC-M04's C+8, so C-16 and C-17(b) read
as one composed statement about the same handover instead of two local ones —
they are, and a tb_writer holding only one excerpt should still be able to see it.

(c) dv asked for the case to be moved to §6.3 as unreachable. I went slightly
further and **withdrew** the §6.1 claim rather than completing it: specifying
M08's output timing for a producer M06 cannot be would commission a test for a
stimulus the programme has decided not to produce, which is the objection §6.3's
existing items make elsewhere in the same document.

(d) dv offered ADR-0008's Consequences or SPEC-M07 §7. I chose the ADR, because
the rule binds M11, M15 and M18 as well as M07 and a sentence in one module's §7
would have to be copied into three more specs to bind them — and M11, written in
this same commit, is the first module that needed it. I added what a monitor
**may** assert (the source's side of decisions 1 and 2) alongside the four SHALL
NOTs, so the bullet does not read as a blanket exemption from checking the
handshake at all.

(e) Verified independently: N = 14 gives a zero-octet payload and no payload word,
so residue 0 in 14–21 produces no `tkeep` at all; `0xFF` needs a payload that is a
positive multiple of 8, hence N = 22. Fixed as stated, and I separated the
residue claim from the pattern claim in the text, because merging two claims over
two different ranges is what hid the gap.

*C-18* is the sharpest finding of the three and the repair is the smallest.
"Gapless" was defined as "every XGMII word from the start word onward carrying
frame octets", which no stimulus satisfies — the start word carries preamble, and
§6.1's own 64-octet table has `/T/` in lane 0 of cycle 9 carrying no frame octet
while the m + 3 formula is applied to it. Defining it in **octet times** (the
frame's octets occupy consecutive octet times from the start character onward)
makes both words fall outside the span and makes the table qualify, which is what
a definition of a term used by a worked example has to do. The two wrong
illustrations I stated as explicit **non**-instances with their `octet_count`
values, because that is the form that cannot be misread: the second preamble word
of a lane-4 start covers four frame octets and the CRC enable is asserted for it
with `octet_count` = 4; a terminate character in lane k > 0 leaves k frame octets
below it. dv's point that the literal reading fails every lane-4 frame's FCS check
is correct and I did not want a repair that merely removed the wrong example
without saying why it was wrong. I also found the same wrong example in §3's
REQ-016 row, which dv did not cite; fixing one and leaving the other would have
been indefensible, so both moved and §13's row says so.

*C-15* is dv's own clause and I applied it as supplied, adding two sentences of
provenance: the failure was **observed** (a conformant M03 failed dv's single-L
monitor on frame 2 of an alternating-lane run), and the observation belongs next
to the definition so the next reader does not have to find WO-0012 to know why
the qualifier is there.

**The batch-C freeze flip, which the work order did not ask for.**

The gate checklist has recorded batch C as FROZEN at 508eea2 since 55e78f2, with
run 30733153172 and `J-dv_lead-0007` transcribed. The four specs still said
"Status: DRAFT" with `pending` in all four §12 rows. The work order calls them
"frozen text" and asks for §13 records against them, and a §13 change log on a
document that declares itself DRAFT is incoherent — §13's own preamble says
"post-freeze changes only". §12 is the architect's section under charter §5, not
a gate signature under PROTOCOL §7, so the flip is mine to make and the gate file
is not: I completed all four §12 blocks, flipped the status lines, and closed
each §11.1 with evidence I checked rather than accepted —
`git diff --stat 508eea2 f457efc -- docs/specs/ifc_check/` is empty, so the run
that went green elaborated byte-identical records to the ones frozen at 508eea2.
SPEC-M07 §11.3 closed at the same time, in the negative, recording dv's declined
answer. I did not touch `docs/gates/`.

**Batch D: the four decisions worth an appeal record.**

*Where the new records live.* SPEC-M01 is FROZEN at f78766e and five freeze
records cite its compile evidence, so adding `Arp_packet` or the cache records to
its §4.1 would be a breaking post-freeze interface change — the exact churn
charter §6 counts and the exact thing ADR-0008 was written to avoid doing to the
header records. I considered it anyway, because a single types home is the
cleaner end state; I rejected it because the cost is paid now and the benefit is
cosmetic, and because the alternative is reversible. The rule batch D adopts —
declare each record once at the module that **produces or owns** it, open it
everywhere else — gives a cycle-free dependency chain (M10 declares `Arp_packet`;
M12 declares the three cache records; M13 opens both and declares
`Arp_query`/`Arp_response`; M11 opens M10's) and mirrors the connection table's
own direction. SPEC-M10 §11.2 tracks promoting them into M01 if batch F reopens
it, which would be a rename.

*`Arp_packet` carries five fields, not nine.* Hardware type, protocol type and
the two lengths are REQ-501 *acceptance criteria*, each fixed to one value.
Carrying them would create a second place a wrong constant could enter and would
oblige every bench to assert that M13 relayed four constants unchanged. Dropping
them buys a much stronger invariant instead: an `Arp_packet` with `valid` = 1 is
REQ-501-accepted **by construction**, and nothing downstream re-checks. M11
writes the same four from the requirement, so an M11 packet is acceptable to M10
by construction too — which is why §8's cheapest test is the M10 loopback.

*The ADR-0008 substitution at M11's input, and the one connection-table
amendment.* ADR-0008's acceptance event is the acceptance of the frame's first
payload word. At M11's `arp` port there is no payload stream: M11 *generates* the
payload. I considered three ways out. Adding a `ready` to `Arp_packet` fails for
ADR-0008's own reason — the record also travels a receive-path port at M10, where
REQ-003 forbids one and where the structural check would have to grow an
exception. Letting M11 accept unconditionally is ADR-0008's rejected alternative
(c) and fails at exactly the place that ADR predicted, since M13 can have a reply
and a request wanting the same port. So M11 exposes an explicit `arp_ready`
output and §7 states the substitution: the acceptance event is
`arp_valid` & `arp_ready`, decisions 2 and 3 bind against it verbatim, decision 1
has no instance and is not claimed. That costs architecture.md §6.4 exactly one
new edge, which §6.4's own "provisional rows" rule obliges this batch to make in
the same commit; I recounted the whole table mechanically afterwards (26 + 40 +
29 + 22 = 117). I flagged the substitution in SPEC-M11 §11.3 rather than
absorbing it, because a monitor written to ADR-0008's literal wording will look
for a payload word that is not there, and that is dv's call as much as mine.

*Constants where a constant is real, and honesty where it is not.* M10's parse
latency I expressed the way §0.5 would if it could: two named measurement events
(the octet time of ARP octet 0 on the payload stream; the octet time of the
`arp_valid` pulse), L = 32, h = 0, ΔC = 4, closing mod 8. M11's is the same shape
with L = 8, h = 0, ΔC = 1 — and I stated explicitly that the fourteen Ethernet
header octets M11 causes to exist are **not** an insertion at its port, because
they leave on the `hdr` record and become frame octets at M07, whose §7 owns that
arithmetic. But M12's one-cycle lookup and M13's two-cycle response carry **no**
octet, so I stated in both places that §0.5's octet times have no instance there
and did not claim ΔC = (L + h)/8 for them. dv's own open item about an
*inserting* stage (its WO-0013 note 3: "the convention is nowhere written and I
will not invent one silently") is the reason I would rather say "no instance"
than produce arithmetic without a referent.

*Two places where a rule was tempting and none was needed.* REQ-511 and REQ-512
do not get rules in SPEC-M13. A gratuitous ARP is operation 1 with target
protocol address equal to sender protocol address, and the single reply predicate
(`operation` = 1 and `target_ip` = `cfg_local_ip`) fires exactly on REQ-511's
condition; REQ-512 is the same predicate read in the negative. Writing a
`gratuitous` predicate would have created a signal a bench could look for and a
second place the behaviour could diverge. The spec says so in as many words, so
that a tb_writer does not go looking.

*What I had to decide with no REQ behind it.* REQ-505 constrains duplicate
suppression only for the *same* target. A miss for a different target while one
is outstanding is undecided, and it cannot be left unconstrained — a bench must
know whether a second request appears. I chose replacement (abandon the old,
start the new at retry 0) because REQ-506 already states that nothing is
negatively cached and a later datagram starts a fresh sequence, which makes
abandonment costless; the alternative, a per-slot table of outstanding
resolutions, buys suppression for interleaved destinations at the price of
sixteen retry timers and a second eviction policy, in a phase with one
application client. Stated normatively in §6.1 with the rejected alternative, and
raised in §11.3 for dv, because the template's rule is that a behaviour with no
REQ is either a missing requirement or explicitly unconstrained and this is
neither until dv says which.

*C-6, closed where the DoD asked.* dv's original observation was that two of
REQ-004's four criteria have no observable at a module whose output is a record.
The parsed-fields forms are: conservation becomes *reports = packets opened*
(and SPEC-M10 §6.1's one-report rule is what makes that a theorem rather than a
hope); octet comparison becomes **field equality**, which is strictly stronger
because it also tests REQ-012's decode and the sender-IP field's word-boundary
crossing; per-octet constancy becomes REQ-611-shaped constant parse latency, one
value over 10 000 packets and not a mean. The no-`tready` criterion is unchanged
and structural. I put a per-frame sequence number in the sender protocol address
for the same reason SPEC-M06 §8 puts one at payload octets 0–3: a field that
crosses a word boundary and changes every frame is the one a stuck register
cannot survive.

### Actions

- **Diff set (7 files).** SPEC-M04: §6.2 `Idle` row + new paragraph, §7 new
  sub-bullet (four numbered consequences + the composed derivation), §10 REQ-209
  hook, §11.5, §13 row (C-16). SPEC-M06: §6.1 back-to-back paragraph, §8 directed
  set 14→22, §10 REQ-005/REQ-021/REQ-410 hooks, §11.4, two §13 rows (C-17 a, e).
  SPEC-M07: §6.1 prose + derivation, §6.2 `Drain` row, §7 throughput, §8 new
  paragraph, §10 REQ-207 hook, §11.4, §13 row (C-17 b). SPEC-M08: §6.1 claim
  withdrawn + replacement paragraph, §6.3 item 5, §11.3, §13 row (C-17 c).
  ADR-0008: one Consequences bullet (C-17 d). SPEC-M03: §3 REQ-016 row, §6.1
  gapless definition + two non-instances, §6.2 `Frame` row, §11.6, §13 row
  (C-18). requirements.md: §0.5 "Latency" paragraph + §13 revision row (C-15).
- **Batch-C freeze flip (4 files, same as above plus SPEC-M09).** Status lines,
  §12 blocks and §11.1 closures in SPEC-M06 … SPEC-M09; SPEC-M07 §11.3 closed.
  SPEC-M09 takes no C-17 item and its §13 stays empty, stated in place.
- **Batch D (8 new files).** `docs/specs/modules/{arp_eth_rx,arp_eth_tx,
  arp_cache,arp}.md`, each §1 … §13 with no section deleted, and their four
  lifts under `docs/specs/ifc_check/`, generated from the specs' first fenced
  `ocaml` block by the same `awk` rule `tools/check_records_vs_appendix.sh`
  uses, so byte-identity is produced rather than hoped for.
- **architecture.md.** §6.4 type-column note (batch-D record homes), the M13
  internal-signal note, the batch-D confirmation paragraph, one new §6.4.2 row,
  the edge counts (116 → 117, tx 39 → 40), §6.4.2 heading, §8 currency.
- **traceability.md.** Twelve ARP rows' owning-module and spec-section columns;
  REQ-507's short title; the currency bullet; the set-equality bullet (C-15
  added); a new bullet explaining the two two-module rows.
- **`agents/handoffs/WO-0014_batch-d-specs.md`.** State ISSUED → RETURNED and the
  Return log, with the per-item table, the C-17 judge-each table, the four open
  questions and the ledger dispositions for transcription.
- Nothing under `test/**`, `tools/**`, `libs/**`, `scripts/**`, `.github/**`,
  `tasks/**` or `docs/gates/**` was written. `git` was not run except to read.

### Evidence

All commands runnable from a checkout at this commit.

1. **Lift byte-identity, the four new pairs and the nine existing ones**:
   `bash tools/dv_checks.sh` → exit `0`, `dv_checks: all checks passed`;
   record half **`16 check(s) run, 0 failure(s)`**, including
   `PASS  modules/arp.md §4.1 == ifc_check/arp_ifc.ml (byte identical …)`,
   `PASS  modules/arp_cache.md §4.1 == ifc_check/arp_cache_ifc.ml …`,
   `PASS  modules/arp_eth_rx.md §4.1 == ifc_check/arp_eth_rx_ifc.ml …`,
   `PASS  modules/arp_eth_tx.md §4.1 == ifc_check/arp_eth_tx_ifc.ml …`.
   Emitted-Verilog half: `4 check(s) run, 0 failure(s), 4 pending`.
2. **REQ set equality after the traceability edit**: the REQ id set of
   `docs/specs/requirements.md` (ids in `**REQ-nnn**` form) and the row id set of
   `docs/specs/traceability.md` are both **110** with an empty symmetric
   difference, checked by comparison rather than by counting rows.
3. **Connection-table arithmetic**: rows counted per subsection —
   rx **26**, tx **40**, control **29**, status **22** = **117**, matching §6.4's
   restated header and §6.4.2's heading.
4. **Batch-C freeze evidence, fetched at source**: GitHub API
   `/repos/renatom11/agentic-fpga/actions/runs/30733153172` → `"name": "build"`,
   `"head_sha": "f457efc85d367c7903bee32f4ba31f6e067db0fb"`,
   `"status": "completed"`, `"conclusion": "success"`. And
   `git diff --stat 508eea2 f457efc -- docs/specs/ifc_check/` → **empty**, so
   that run elaborated records byte-identical to the ones frozen at 508eea2.
   `git diff --stat 508eea2 HEAD -- docs/specs/ docs/adr/` was **empty** before
   this commit's edits, confirming the review text had not moved.
5. **No frozen `§4.1` block changed**: `git diff` on this working tree touches no
   line inside the first fenced `ocaml` block of SPEC-M01 … SPEC-M09, which is
   also what check 1's nine pre-existing PASS rows re-assert. The batch-A/B
   evidence (run 30729342467 at f78766e) and the batch-C evidence (run
   30733153172) therefore still witness every frozen interface, and post-freeze
   interface churn stays at **zero**.
6. **Not yet available, and stated as such**: no CI run exists for the four new
   lifts. `arp_eth_tx_ifc.ml` and `arp_ifc.ml` are the first lifts to `open!`
   another lift in the same library, and `arp_cache_ifc.ml` is the first
   `module type S` with an optional parameter on both entry points — none of
   which I can compile locally (ADR-0005). Each batch-D §12 row reads `pending`
   and each §11.1 says exactly what a reader assumes meanwhile.

### Outcome

**DoD met.** All four C-items dispositioned (C-15, C-16, C-17 in five judged
parts, C-18) with a §13 record on every frozen-spec edit and a §13 revision row
on requirements.md; four specs template-complete with byte-identical lifts and
`open! Axi64_ifc` where a programme type is used; C-6 closed in SPEC-M10 §8; set
equality holds at 110 = 110. Two things beyond the stated deliverables, both
disclosed in the Return log rather than folded in: the batch-C freeze flip
(charter §5's §12 rows, the gate file untouched) and C-18's twin sentence in
SPEC-M03 §3. Handoff: `agents/handoffs/WO-0014_batch-d-specs.md`, RETURNED,
with the per-item dispositions, the C-17 judge-each table, the ledger
dispositions for orchestrator transcription and four named open questions.

### Open-questions

1. **SPEC-M11 §11.3 — the ADR-0008 substitution at a record-only port.** I read
   `arp_valid` & `arp_ready` as an instantiation of ADR-0008, not a supersession.
   dv_lead's call at the batch-D countersignature; a monitor built for the ADR's
   literal wording would hunt for a payload word that does not exist there.
2. **SPEC-M10 §11.3 — a bad-FCS frame is parsed, accepted and learned from.**
   `payload_tuser`[0] arrives after M10's pinned report, so acting on it costs
   REQ-005's constant. If the programme wants it excluded, the cheapest gate is
   M13 and it needs a requirements.md diff plus an `Arp_packet` field.
3. **SPEC-M13 §11.2 — REQ-810's ARP clause.** The first reply waits in M11 and
   later ones are dropped; dropping the first needs a `cfg_tx_enable` port at
   M13, which would be a breaking change after freeze — hence raised now.
4. **SPEC-M13 §11.3 — replacement on a miss for a different target.** Decided
   here with no REQ behind it; dv_lead judges whether it is a missing
   requirement.
5. Unchanged by this work order and still tracked in specs: **C-3**
   (SPEC-M08 §11.2), **C-5** (SPEC-M04 §11.3), SPEC-M06 §11.2's zero-reserve
   ceiling, and SPEC-M12 §11.2's lifetime-counter cost.
6. **A CI `build` run is owed** before any batch-D §12 row can stop reading
   `pending` and before a dv_lead countersignature work order should issue.

### Files-in-this-commit
- agents/handoffs/WO-0014_batch-d-specs.md
- docs/adr/ADR-0008-transmit-header-handshake.md
- docs/specs/architecture.md
- docs/specs/ifc_check/arp_cache_ifc.ml
- docs/specs/ifc_check/arp_eth_rx_ifc.ml
- docs/specs/ifc_check/arp_eth_tx_ifc.ml
- docs/specs/ifc_check/arp_ifc.ml
- docs/specs/modules/arp.md
- docs/specs/modules/arp_cache.md
- docs/specs/modules/arp_eth_rx.md
- docs/specs/modules/arp_eth_tx.md
- docs/specs/modules/eth_arb_mux.md
- docs/specs/modules/eth_axis_rx.md
- docs/specs/modules/eth_axis_tx.md
- docs/specs/modules/eth_demux.md
- docs/specs/modules/xgmii_rx_64.md
- docs/specs/modules/xgmii_tx_64.md
- docs/specs/requirements.md
- docs/specs/traceability.md

---

## [J-architect_docs_lead-0007] 2026-08-02T20:10:00Z | task:WO-0017 | The first contested-verdict repair cycle (D-1 by R-1, D-2 by D-2a + ADR-0009), five §11 closures, C-19…C-23, and batch E (SPEC-M14/M15/M16)

### Trigger

Orchestrator work order `agents/handoffs/WO-0017_batch-e-specs.md`, spawn
short-id `WO-0017/2026-08-02T07:40Z`, seventh activation. dv_lead **withheld**
the batch-D countersignature at a9993ff — the first withheld countersignature
since WO-0005 — signing M10, M11 and M12 but contesting M13 on two behavioural
items, and pre-wording the signature for the commit that carries the repairs.
This work order is that commit's content: the two repairs, the diff set owed
regardless of the verdicts, five carry-forwards, and batch E drafted in parallel
because dv explicitly cleared it (neither owed diff moves a port, a record or a
latency constant).

### Inputs

- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` (§4 grammar, §6
  scope, §7 gates, §10 independence).
- `agents/handoffs/WO-0017_batch-e-specs.md` (the work order) and
  **`agents/handoffs/WO-0015_batch-d-countersign.md` at 619afa7 read in full** —
  the primary input: §0 (what witnesses the specs), §1 (four verdicts), §2 (the
  arithmetic recomputed), §3 (owed diffs D-1 and D-2 with two repairs each), §4
  (Q1–Q5 answered by name), §5 (ledger: C-6/15/16/17/18 reaffirmed, C-19…C-23
  raised), §6 (six below-threshold readings), §7 (dv's own actions), §8 (the
  pre-worded countersignature and the bounded re-review surface).
- `docs/specs/SPEC-TEMPLATE.md` (§11's DRAFT-versus-FROZEN rule, rule 6's lift
  obligation, rule 7's post-freeze rule); `docs/specs/requirements.md` in full;
  `docs/specs/architecture.md` in full; `docs/specs/traceability.md`.
- All four batch-D specs in full (`modules/arp_eth_rx.md`, `arp_eth_tx.md`,
  `arp_cache.md`, `arp.md`); `modules/eth_axis_rx.md`, `eth_axis_tx.md`,
  `eth_mac_10g.md` and `eth_demux.md` §6–§7 and `eth_arb_mux.md` §4.1/§7/§11 as
  the models batch E copies; `docs/adr/ADR-0008-transmit-header-handshake.md`;
  `docs/specs/ifc_check/axi64_ifc.ml` and `dune`.
- `docs/gates/P1-spec-freeze-checklist.md` (read only — the ledger's C-item
  wording and the batch table); `tools/check_records_vs_appendix.sh` and
  `tools/dv_checks.sh` (read, then run read-only).
- **`libs/**` was not opened**, in this or any previous activation of mine.

### Reasoning

**D-1: R-1, because the cheaper repair is also the one that leaves fewer
documents to keep in step.** dv traced the mechanism port by port and it
reproduces: SPEC-M11 §6.2's `Idle` row asserts `arp_ready` unconditionally, so a
blocked transmit path leaves reply 1 inside M11 with M13 back in `Idle`, reply 2
merely `Pending` with no strobe, and reply 3 the first drop — the family holds
**two** replies where REQ-510 says one, and four counting sites across two
documents commission a strobe a conformant design does not pulse. R-2 (keep the
mechanism, move the counts from two to three) would have cost a **behavioural**
requirements.md diff to a normative ERR requirement plus four spec-side count
changes, and would have left the module two deep in stale replies; R-1 costs one
state in machine (A), one clause in §6.1, and makes all four sites correct **as
written**. I recorded R-2 permanently as SPEC-M13 §11.6 rather than only in this
entry, because a countersignature and a work-order log both cite D-1 by name and
a reader who finds only the winner cannot check the choice — that is the
adjudication-record obligation in my charter §8 applied to a repair rather than
to a dispute.

R-1 needed one thing dv's recommendation did not state: the **boundary cycle**.
A reply generated on the exact cycle the pending reply's `tlast` is accepted sits
inside a window that is closing. I pinned it as *dropped*, matching the register
semantics of machine (A)'s state (it is in `Transmitting` for the whole of that
cycle), and stated that the coincidence is arithmetically unreachable from the
composed chain. The alternative — leaving it open — would have handed a bench
writer two defensible answers, which is precisely the class of ambiguity the
whole batch-D return was about.

**D-2: D-2a, decided on merit once the cost estimate was corrected — and the
correction is half the decision.** SPEC-M10 §11.3 priced the repair as "a new
`Arp_packet` field", i.e. as a post-freeze record addition, i.e. as breaking. It
cannot be one: the bit arrives on the payload `tlast` word, two or more cycles
*after* the record is emitted, so no field of that record could carry it. Read
literally the item priced the repair as unaffordable, and that wrong price is
what would have made this decision get made under gate pressure for the wrong
reason. With the price corrected the two repairs cost the same in interface terms
— nothing — so the choice is on merit, and D-2b writes into the requirements that
one receive branch may commit twenty seconds of persistent state from a frame the
programme has already declared invalid, with no observable naming it. The failure
mode is not a dropped frame; it is every datagram to that IP leaving with a wrong
destination MAC, which is the kind of thing that surfaces as a replay divergence
three phases later with nobody able to name its origin. An exemption that has to
be written down in order to be legitimate is usually the wrong side of the
choice. I wrote **ADR-0009** because requirements.md §13 requires a behavioural
row to name an ADR, and because D-2's rejected alternative is exactly the
material my charter says an ADR exists to preserve.

Three things the repair needed that the recommendation did not supply, each
decided here. **(i) The gating cycle is one after the *later* of `arp_valid` and
the payload `tlast`**, not simply `tlast` + 1: for an exactly-28-octet ARP
payload the `tlast` precedes M10's report, and a rule that only said `tlast` + 1
would act before the record existed. In the composed chain the rule reduces to
`tlast` + 1 (a legal minimum frame delivers six payload words), and the other
branch exists for determinacy — its only instance is inside a runt, which is
marked anyway. **(ii) A marked packet ends no outstanding resolution**: it
produces no cache write, so ending the retry sequence on it would abandon a
resolution on the strength of an invalid frame and the next datagram would miss
with nothing outstanding. **(iii) REQ-502's derivation moves from 6 to 7
cycles**, and I disclosed that at the top of the Return log rather than letting
the re-review find it, because it is the one number dv signed in §2 that both
repairs were expected not to move. It is still a derivation and still constant at
every accepted request length: the payload `tlast` sits a fixed three cycles
after a lane-0 terminate character, because every stage between has constant
per-octet latency, so a longer request moves the measurement start and the gate
together.

**Whether D-2a violates REQ-013's own "solely" clause.** It does not, and I made
requirements.md say why rather than relying on the reading being obvious: the
prohibition binds a module that *forwards* — it exists so no stage drops a frame
from a stream it is relaying — and the ARP branch forwards nothing. REQ-013's
*first* clause, the one that names an ultimate consumer, is the clause D-2a
discharges. So REQ-013 gained one sentence naming the consumer per branch
(application on the UDP path, M13 on the ARP branch) and declaring an unnamed
branch a gap in that row. That sentence is worth more than the repair itself: it
is what stops the same hole reopening at a branch nobody has written yet.

**C-23's home: requirements.md §0.6, not SPEC-M13 §9.** dv offered either. The
convention — one high cycle per event, consecutive events give consecutive high
cycles, count high cycles and never rising edges — is a statement about every
strobe and every monitor in the programme; M13 is merely the first module where a
strobe can legitimately be high on consecutive cycles. Putting it in §0.6 also
puts it where §0.6's existing "a strobe SHALL pulse for exactly one cycle"
sentence lives, which is the sentence a bench writer would otherwise read as a
promise that the signal falls — so the two now travel together, which is the same
argument C-15 made for the start-lane exception.

**Batch E's design decisions, briefly, with what each rejected.** M14's ΔC = 4
against a ceiling of 5 is the minimum a registered output reaches (payload octets
0–7 span input words 2 and 3), and I stated the spare cycle as **M14's own
allocation** rather than as architect slack, so that a future revision to 5 is an
ordinary spec diff and only a move past 5 is a slack release — the distinction
SPEC-M06 §11.2 needed and did not have. M14's seven strobes forced a decision
§0.6 does not make for us: whether a bad checksum suppresses the other checks. I
chose **independent evaluation, every applicable strobe pulses**, because a
precedence order is unobservable at the port (one strobe looks the same whichever
rule suppressed the others), so a bench could not tell a conformant design from a
broken one and every implementer would have to guess the order. The single
exception — a frame not delivering a complete header pulses `error_ip_truncated`
alone — exists because otherwise the pulse set would be a function of *where* the
frame ended rather than of the datagram.

M15's structure follows from one thing: it must not buffer (REQ-610) and it must
not stall the application on a miss (REQ-505). So the resolution query goes out
on the offer cycle, `payload_tready` stays 0 for exactly two cycles, and the
first payload word is accepted on the response cycle **whichever answer arrives**
— which makes the head-of-frame behaviour independent of the outcome and makes
REQ-705's invariance criterion hold at this port too (one word accepted before
the first body word leaves, at every length). I applied C-17(b)'s lesson before
the fact: the word surplus (2 or 3) and the stall count (3 or 4) are named
separately, because conflating them is what produced the M07 defect and a
throughput assertion built from the surplus fails every conformant design.

M16 copies SPEC-M05's shape deliberately, including the total wiring table and
the "nothing else is unconstrained" clause — with seven children rather than two,
the temptation to slip in one register is larger, so the table being total is
what makes such a register a visible diff. Two things are M16's own rather than
M05's: REQ-807's loop is *closed* inside it, so I gave it one bench obligation of
its own and was explicit that it is not a substitute for M20's XGMII-level test;
and its receive path **forks**, so §9 states the conservation fact a monitor
needs (an ARP frame is not emitted at `ip_rx_payload` and looks like a silent
discard unless the branch is counted separately).

**Two architecture.md amendments, and I resisted making a third.** M14's output
rows had to be renamed because the provisional table gave its input and output
header pairs the same names, which emits `hdr_valid` twice in one Verilog module
— a real defect in the table, found by writing the record. The `cfg_subnet_mask`
row had to be *added* because REQ-604 accepts the subnet-broadcast address and
that arithmetic needs the mask; this is the one place batch E adds an edge rather
than confirming one, and I recorded it as an amendment with its reason rather
than letting the count drift. The third change I did **not** make: expanding
§6.4.3's configuration rows into per-wrapper hops. That inconsistency pre-dates
batch E, thirty-odd rows is a lot of table for no reader's benefit, and the
honest fix was to state the summary rule explicitly — as §6.4.4 already does for
strobes — and track the expansion in SPEC-M16 §11.3.

**Scope discipline.** Three §11 items closed that this packet did not name
(SPEC-M07 §11.2, SPEC-M09 §11.3, SPEC-M11 §11.2) because all three read "Closes
by: SPEC-M15 (batch E)" and SPEC-M15 §7 discharges them; two of those files are
FROZEN, and a §11 closure is not a §4/§6/§7 change, so no §13 row is owed — the
disposition SPEC-M06 §11.1 took at WO-0014. I disclosed it in the Return log
rather than folding it in silently.

### Actions

- **requirements.md**: REQ-503 (behavioural — the "and not marked invalid"
  qualifier, the no-strobe consequence, the bad-FCS verification case); REQ-013
  (the ultimate consumer named per branch, the "solely" clause scoped to
  forwarding modules); REQ-810 (the ARP clause reworded — first reply held, later
  ones dropped); REQ-502 (measurement start pinned to the terminate character);
  §0.6 (the strobe counting convention); six §13 revision rows.
- **ADR-0009** written (D-2's decision, four rejected alternatives, the corrected
  cost estimate, six consequences). **ADR-0008** gained C-22's precedence clause
  on the C-17(d) bullet.
- **SPEC-M13**: R-1 (§6.1's REQ-510 block, §6.2 machine (A)'s third state, §7,
  §9, §10, §8 item 2, §11.6 new); D-2a (§6.1's validity gate, §6.2 (D) new stage
  table, §2, §3, §7, §9, §10); REQ-502's table recomputed to 7 cycles; §11.1,
  §11.2 and §11.3 closed; §12 filled; §8 item 1's 101 pulses and §6.1's
  class-4 competitor corrected.
- **SPEC-M10**: §2's abort row (owner M13), §6.1's `clear` exception (C-21) and
  report-cycle qualifier, §6.3 item 4's constant (C-20), §8's idle count and
  conservation exemption (C-21), §10's hook, §11.1 and §11.3 closed, §12 filled.
- **SPEC-M11**: §3's REQ-015 wording, §6.1's `arp_ready` clarification, §8 item
  2's one-cycle lead (C-19), §11.1/§11.2/§11.3 closed, §12 filled.
- **SPEC-M12**: §11.1 and §11.3 closed, §12 filled, §6.1's table cell repaired.
- **SPEC-M07 §11.2** and **SPEC-M09 §11.3** closed (ADR-0008 restatement).
- **Batch E written**: `docs/specs/modules/ip_eth_rx_64.md`, `ip_eth_tx_64.md`,
  `ip_complete_64.md`, each template-complete, with the three §4.1 blocks lifted
  byte-identically into `docs/specs/ifc_check/*_ifc.ml`.
- **architecture.md**: batch-E confirmation paragraph, two amendments, the
  configuration-fan-out summary rule, M16's internal-signal note, edge count
  117 → 118 (26/40/30/22), §8 currency rewritten.
- **traceability.md**: twelve batch-E rows filled, three rows given a second
  owning module (REQ-505, REQ-610, REQ-807), the currency and two-module notes
  extended.
- **WO-0017 Return log** written with per-item dispositions and five open
  questions; packet State flipped to RETURNED.

### Evidence

Runnable from a checkout at this commit's SHA:

- `bash tools/check_records_vs_appendix.sh` → **19 check(s) run, 0 failure(s)**.
  Sixteen as at a9993ff plus three new rows — `modules/ip_complete_64.md §4.1 ==
  ifc_check/ip_complete_64_ifc.ml`, and the same for `ip_eth_rx_64` and
  `ip_eth_tx_64` — all "byte identical". The four batch-D rows still PASS, which
  is the mechanical evidence that the D-1 and D-2 repairs touched no §4.1 block
  and that run 30736107842's compile evidence still witnesses those records.
- `bash tools/dv_checks.sh` → exit 0, `dv_checks: all checks passed` (the
  emitted-Verilog half reports 4 pending items, all of them unbuilt-module
  conditions unrelated to this work order).
- REQ set equality, run mechanically:
  `grep -oE '\*\*REQ-[0-9]{3}\*\*' docs/specs/requirements.md | tr -d '*' | sort -u`
  → **110**; `grep -oE '^\| REQ-[0-9]{3} \|' docs/specs/traceability.md | grep -oE 'REQ-[0-9]{3}' | sort -u`
  → **110**; `diff` of the two → **empty**; 110 row lines, no duplicate.
- architecture.md §6.4 recount by strict row shape:
  `awk '/^\| `(M[0-9]+|WIRE|APP|EXT)\./ {…}' docs/specs/architecture.md` →
  **118 rows: 26 rx, 40 tx, 30 control, 22 status**, matching §6.4's summary line.
- **Externally verifiable**: CI `build` run **30736107842**, conclusion
  **`success`**, head SHA **2f29888** — the run the four batch-D §12 rows now
  cite, fetched and re-verified by dv_lead from the GitHub API at WO-0015 (§0 of
  its Return log), with `git diff a9993ff 2f29888 -- docs/specs/` empty.
- **No `ifc_check` run exists yet for the three batch-E lifts**, and each spec's
  §11.1 and §12 says so in those words. Per ADR-0005 a local build is not
  acceptable evidence and I ran none; the batch-E freeze flip waits on that run.

### Outcome

**DoD met.** D-1 landed as R-1 and D-2 as D-2a, each with a §13-recorded
requirements diff where it touches DRAFT requirement text and an ADR where it is
behavioural; the five §11 closures are recorded in place with their numbers and
rows kept; the four §12 `Interface compile check` rows are filled from run
30736107842 / success / 2f29888 and the four §11.1 items closed on it;
C-19 … C-23 all landed, C-23 in requirements.md §0.6 by my choice of home; both
non-blocking editorial items and all six below-threshold readings taken; batch E
is template-complete with byte-identical lifts and no new record; set equality
holds at 110 = 110. Handoff: `agents/handoffs/WO-0017_batch-e-specs.md`,
RETURNED, with per-item dispositions, the two repair choices argued, the two
architecture.md amendments disclosed as amendments, and the re-review surface
restated. dv_lead's pre-worded countersignature sentence applies to the commit
carrying this entry.

### Open-questions

1. **REQ-502's derivation is now 7 cycles, not 6.** The one signed number that
   moves under either repair, and it moves by exactly D-2a's gate. If dv_lead
   judges the gate should delay only the learning write and not the reply, the
   derivation returns to 6 at the cost of replying to a frame the programme has
   declared invalid; dv's own D-2a wording gates both and this is written to it.
2. **D-1's boundary cycle** — a reply generated on the cycle the pending reply's
   `tlast` is accepted is dropped. Unreachable from the composed chain, pinned
   for determinacy; one word in §6.1 and one row in §6.2 (A) reverse it.
3. **M14's `error_ip_truncated`-alone rule** for a frame not delivering a
   complete 20-octet header — the only precedence rule in batch E, argued from
   §0.6's word "applicable".
4. **Two matrix rows now name a module whose specification is unwritten**
   (REQ-610 → M18, REQ-807 → M20), with the second half reading `pending` so the
   debt is visible. A single-owner row until batch F lands is a matrix edit and
   no spec change, if dv prefers it.
5. **`cfg_subnet_mask` at M14 is an added edge**, not a rename: REQ-604's
   subnet-broadcast clause cannot be evaluated without the mask. The alternative
   topology — M20 computing the address once and routing the result — is
   E2-shaped and was not taken.
6. **A CI `build` run is owed** before any batch-E §12 row can stop reading
   `pending`, and before a batch-E countersignature work order should issue. The
   three new lifts are the first to be elaborated across a batch boundary
   (`ip_eth_tx_64_ifc.ml` opens `Arp_ifc`).
7. Unchanged and still tracked in specs: **C-2** (now load-bearing at SPEC-M10
   §8), **C-3**, **C-5**, **C-7**, **C-9's REQ-903 half**, SPEC-M06 §11.2's
   zero-reserve ceiling, SPEC-M12 §11.2's lifetime-counter cost, SPEC-M13 §11.4's
   combinational relay.

### Files-in-this-commit
- agents/handoffs/WO-0017_batch-e-specs.md
- docs/adr/ADR-0008-transmit-header-handshake.md
- docs/adr/ADR-0009-arp-branch-is-the-ultimate-consumer.md
- docs/specs/architecture.md
- docs/specs/ifc_check/ip_complete_64_ifc.ml
- docs/specs/ifc_check/ip_eth_rx_64_ifc.ml
- docs/specs/ifc_check/ip_eth_tx_64_ifc.ml
- docs/specs/modules/arp.md
- docs/specs/modules/arp_cache.md
- docs/specs/modules/arp_eth_rx.md
- docs/specs/modules/arp_eth_tx.md
- docs/specs/modules/eth_arb_mux.md
- docs/specs/modules/eth_axis_tx.md
- docs/specs/modules/ip_complete_64.md
- docs/specs/modules/ip_eth_rx_64.md
- docs/specs/modules/ip_eth_tx_64.md
- docs/specs/requirements.md
- docs/specs/traceability.md

## [J-architect_docs_lead-0008] 2026-08-02T13:10:00Z | task:WO-0019 | Batch F (SPEC-M17/M18/M19/M20) closes the 20-module inventory; batches D+E flipped FROZEN at 3f6accc; C-24…C-30 landed; ADR-0010 (conventions) and ADR-0011 (REQ-709's residual)

### Trigger

WO-0019, `agents/handoffs/WO-0019_batch-f-specs.md`, issued by the orchestrator
after dv_lead granted **both** countersignatures at `3f6accc` (WO-0018,
`J-dv_lead-0009`), putting batches D and E FROZEN on the gate checklist at 16 of
20. My eighth activation, spawn short-id `WO-0019/2026-08-02T10:35Z`. Five
deliverables: the batch-D/E Status-line flips with their §12 fills and §11.1
closures; dv's seven carry-forwards C-24 … C-30 as spec diffs on newly frozen
text; answers to rtl_lead's two conventions questions, both blocking batch-B RTL
issuance; the last four specifications; and the batch-F traceability rows. This
is the packet that, if it holds, leaves `P1-spec-freeze` needing only dv's
countersignature and the sponsor's signature.

### Inputs

- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` (§3, §4, §6, §7,
  §10, §11), `agents/handoffs/WO-0019_batch-f-specs.md`.
- **The WO-0018 Return log in full** (`agents/handoffs/WO-0018_batch-de-countersign.md`)
  — dv_lead's `J-dv_lead-0009`: §0's evidence, §1's four verdicts, §2's re-check
  of the D-1/D-2 landing sites, §3's five answers, §4's batch-E recomputation and
  four below-threshold readings, §5's ledger with C-19 … C-23 reaffirmed and
  C-24 … C-30 raised, §6's DV actions, §7's two countersignature sentences.
- **The WO-0016 Return log §5** (`agents/handoffs/WO-0016_m01-m02-implementation.md`)
  — rtl_lead's two conventions questions, and §6's compile-risk register and §7's
  self-review for what the library actually looks like today.
- `docs/specs/requirements.md` in full (§0.1 … §0.7, §1.1, the UDP and top-level
  blocks, §9.1, §11, §12, §13); `docs/specs/architecture.md` in full (§1, §2.3,
  §4, §5, §6.1 … §6.4.4, §8); `docs/specs/SPEC-TEMPLATE.md`;
  `docs/specs/traceability.md`.
- The seven specs I was flipping — `modules/{arp_eth_rx,arp_eth_tx,arp_cache,arp,
  ip_eth_rx_64,ip_eth_tx_64,ip_complete_64}.md` — plus `modules/{axi64,crc32_eth,
  xgmii_rx_64,xgmii_tx_64,eth_mac_10g,eth_axis_rx,eth_demux}.md` for the pinned
  constants SPEC-M20 §7 sums, for M04's underflow semantics, and for the eleven
  deferred items whose closing gate this batch is.
- `docs/adr/ADR-0008` (the transmit header handshake, restated at M18) and
  `ADR-0009` (the ARP branch's ultimate consumer); `docs/gates/P1-spec-freeze-checklist.md`
  read-only for the ledger rows C-1 … C-30 and the per-batch record.
- `tools/check_records_vs_appendix.sh` (read, to learn the extraction rule the
  §4.1 lifts must satisfy) and `tools/dv_checks.sh`, both executed read-only.
- **Not read**: `libs/**`. Not opened in this activation or any previous one.

### Reasoning

**The flips, and one thing I added.** Seven Status lines to FROZEN at `3f6accc`
citing `J-dv_lead-0009`. The packet said to leave batch D's §12 compile rows
carrying run 30736107842 at 2f29888, and I left them — but I **appended** run
30739442056 at 3f6accc to each of the four. 2f29888 is not the freeze SHA, so
those rows would otherwise have carried compile evidence for a tree two commits
before the one their Status line names, resting on a `git diff` emptiness
argument. dv fetched the 3f6accc run through the GitHub API and confirmed every
lift elaborates in it, so appending it makes all seven rows carry evidence at
their own SHA and retires the witnessing argument from batches D and E entirely.
More evidence, not different evidence, and the alternative — a freeze record that
needs a prose argument to connect to its own text — is the kind of thing the
auditor eventually asks about.

**The eleven deferred items I closed that the packet did not list.** Every §11
row in the programme whose "Closes by" cell named SPEC-M20, SPEC-M18 or batch F
had its gate arrive in this commit. I closed all of them, each in place with its
number kept. The reasoning is that a deferred-item table earns its keep only if
its gates are honoured when they come; a row that says "closes at SPEC-M20" and
is still DEFERRED after SPEC-M20 exists teaches every later reader that the
column is decoration. Two of the closures are affirmative decisions rather than
bookkeeping and are argued in place: the batch-D records are **not** promoted
into M01 (a post-freeze §4.1 diff to the spec five freeze records cite, for a
rename that changes no behaviour and no emitted port name), and the header
records' two-discipline question is closed because batch F found no consumer
needing the distinction carried in the type — `Udp_header` turns out to have a
receive discipline and **no transmit instance at all**, since M18 builds its
header from a `Udp_tx_request`.

**C-24, and why I wrote the mechanism down and not just the number.** dv's figure
is right and I re-derived it independently rather than transcribing it: terminate
character at cycle 1 + ⌊N/8⌋, payload `tlast` at 6 + ⌈(N − 18)/8⌉, gap 3 for
N ≡ 0, 1, 2 (mod 8) and 4 otherwise, response = gap + 4 = 7 or 8. What matters
more than the correction is *why* the old sentence was wrong, because the error
recurs: §0.5's machinery makes a **per-octet** latency residue-invariant, and
REQ-502 measures a **cycle difference between two events at different octet
positions**, which division discards the residue of. That is C-1's class one
level up, and SPEC-M13 §6.1 now says so in those words. The alternative — patch
the number and move on — would have left the next person to make the same
mistake with nothing to recognise it by.

**C-25's sharper half was the real one.** The five-lengths and 46-to-50-octet
corrections change no conclusion (all five are runts, all marked, all excluded).
The defect worth repairing is that §6.2 **(D)**'s three-stage model named no
stage that held `rx_payload_tuser`[0] in branch (1), where the `tlast` word has
already passed by the gating cycle. I restructured (D) into two **independent
capture events** — 0a at `arp_valid`, 0b at the payload `tlast`, either order —
plus the gating cycle, which reads the captured bit and never the port. The
observable never moved; the model an implementer builds from was unimplementable
in one of the two branch orders, and now is not.

**C-26 and the rule I extracted from it.** The extensional branch is settled by
requirements.md REQ-605 one document up, so this was the specification agreeing
with its requirement rather than a choice. The part I had to decide was the
boundary dv flagged: at exactly 20 delivered octets with a larger declared total
length, does `ip_hdr_valid` pulse? I decided **no**, and stated the general rule
behind it rather than the case — **a header record is never emitted for a
datagram whose payload frame cannot follow** — because that rule then wrote
itself into SPEC-M17 from the start, where the same case exists at 8 delivered
octets. Deciding the case would have fixed one document; stating the rule fixed
two and gave the next header-stripping stage its answer in advance.

**C-27, C-28, C-29, C-30** are corrections of the same kind: a figure whose scope
was overclaimed (M14's parse latency is gap-sensitive and L is not), a two-half
split that did not tile on one side (M13's REQ-505, whose §8 item 1 commissioned
an observable at a port M13 does not have), an anchor summed from the wrong event
(M16's transmit chain), and an exemption owed to a monitor (M14's `clear`). Each
is a §13 row with `ADR: none` and the reason, which is the batch-C precedent. I
wrote C-30's paragraph into **SPEC-M17 §8 as well**, before any bench exists to
fail on it — the third module to carry ledger C-2's exemption, and the first to
carry it prospectively.

**The conventions answers, and the one I recorded as a wart.** `open! Axi64` is
adopted as rtl_lead proposed. The interesting decision was *where* to put it:
SPEC-M01 §4 is FROZEN, so a conformance note there is a post-freeze §4 diff
needing an ADR anyway, and it would put the answer inside the document whose
§4.1 block is byte-compared against a lift. An ADR plus a restatement in
architecture.md §2.3 — which is unfrozen and is where the fabric decision already
lives — gives a citable normative home at zero churn on the most-cited spec.
The alternative I want on the record is **(a2)**: renaming the inner module to
`Stream` removes the `Axi64.Axi64` nesting at its root, and it is rejected only
because SPEC-M01 §4.1 is frozen and five freeze records cite the run that
elaborated it. ADR-0010 says the rename is the **first** thing to do in any
future diff that reopens that block. A wart recorded as a wart is cheaper than a
wart that looks like a decision.

On `module type S`: no. Two independent grounds, and the second is the one that
settles it — a named `S` in the library would be exported module surface **that
no frozen specification binds**, which is what spec-before-RTL exists to prevent.
The functorisation it would enable is not wanted either: REQ-305's oracle is a
*software* bit-serial reference, and a hierarchy that depends on a functor
argument no specification pins cannot be checked by the REQ-018 whitelist, which
is mechanical today.

**M17, and the fact that shaped it.** The UDP header is exactly eight octets —
one datapath word — so at the third and last stripping stage REQ-021's
realignment is the **identity**: application word j *is* input word j + 1, and
there is no shifter in the module. That gives ΔC = 2 against a ceiling of 4, the
largest reserve on the chain, and the honest explanation is that §1.1's
allocation was written before any specification had noticed that the one
word-aligned header costs about two cycles less than the two that are not. I did
**not** re-allocate. Moving numbers in three documents to give cycles to stages
that have not asked for them, immediately before a freeze gate, would destroy the
property that makes the table useful: a module that later needs a cycle takes it
from its own reserve by a diff to its own §7, and only a slack release touches
§1.1 and architecture.md §4 together. SPEC-M20 §11.3 records the same reasoning
at the level where the eleven unspent cycles are itemised by holder.

**M18 forced the hardest decision in this batch, and I took the conservative
side of it.** REQ-709 requires an under-delivered frame to be terminated per
REQ-206, and SPEC-M04 §9 already named the mechanism. What neither document asks
is what state the path is in afterwards — and the answer is that M18, M15 and M09
are all still holding the frame, so no further datagram is accepted and no ARP
reply is granted the transmit port. REQ-709's own verification column then
commissions "the next frame transmits correctly", which no conformant design can
do from there. I considered four dispositions. Terminating the frame short puts a
well-formed short frame on the wire, which SPEC-M04 §9 already argues is the
worse outcome and which is exactly why REQ-709 mandates the `/E/`. A back-signal
from M04 to four modules is not proportionate at this gate. Making M04 consume
and discard the aborted frame's remainder is what a real NIC would do — and it
contradicts REQ-207's unconditional no-drop sentence, whose reading SPEC-M04
§11.2 records dv_lead as having classed **compelled**, so taking it reopens a
closed item and changes a frozen §6 for a path no bench takes unless driven. I
chose the fourth: state the residual, name `clear` as the recovery REQ-009
already provides, put the `clear` into REQ-709's verification column so the test
passes a conformant design, and record the absence of a finer recovery in
requirements.md §11. **ADR-0011 says in terms that the M04 repair is the right
one the day this design meets real hardware**, and SPEC-M18 §11.4 carries the
item with its price. The thing I was unwilling to do was ship a requirement whose
own verification column fails a conformant design; the thing I was unwilling to
do *unilaterally* was change a frozen spec's §6 and a requirement's normative
reading at the last gate.

**The `cfg_tx_enable → M18` edge, for the same reason in miniature.** REQ-810's
transmit clause names two observables and one of them — `tready` at the
application transmit interface — is a port three modules from the enable. Without
an edge at M18, propagation would let exactly one application word through (M15
accepts its first payload word unconditionally on its resolution cycle), and a
bench written from REQ-810's own column would fail a conformant design by one
cycle. One control row makes the requirement true at the port it names. The
alternative was to reword the requirement to permit the accepted word, which
moves a requirement to accommodate a topology; batch E's `cfg_subnet_mask → M14`
amendment is the precedent for the shape I chose.

**M20's derivation, checked twice because it is the number the phase is judged
on.** ΔC is additive along the chain and per-octet L is additive too, so I
computed the end-to-end figure both ways: ΔC = 3 + 3 + 1 + 4 + 2 = **13**, and
L = 54 (lane 0) / 50 (lane 4) with h = 50 / 54, giving (L + h)/8 = 104/8 = 13 at
each lane. Both routes agree at both lanes and (L + h) is a multiple of 8 in
both. The lane-independence is worth more than the number: REQ-006 *permits* the
two lanes to differ by a cycle, and here they do not, because M03 pins ΔC = 3 at
both — so a measurement of 13 and 14 is a defect rather than a legitimate
variation, which is a sharper assertion than REQ-006 alone licenses and is stated
where it is derived.

**C-3 answered, and answered honestly.** The top-level conservation equation has
four terms. A zero-payload datagram is accounted for by its `app_rx_hdr_valid`
pulse, which **is** a top-level port — the observable C-3 said was missing exists
and what was missing was a document naming it. Discards are counted as **frames**
and not as pulses, because M14 and M17 both evaluate their conditions
independently and one frame can raise two strobes (ledger C-2's first clause).
And the fourth term — frames consumed on the ARP branch — is **supplied by the
stimulus and not observed**, which I wrote plainly rather than hiding behind an
approximation: a consumed frame is not a discarded one, REQ-008 is about
discards, and conflating them is what would make the equation look broken.

**What I did not do.** I did not touch `docs/gates/` (orchestrator transcribes),
`libs/`, `test/` or `tools/`. I did not edit SPEC-M04 §9's "pulse together"
bullet, which is batch-B frozen text a bench writer may misread as same-cycle:
the correction is stated at SPEC-M18 §9 and at requirements.md REQ-709, which are
the two documents a bench is built from, and I flagged the one-line editorial
diff at M04 for dv to call. I did not re-allocate §1.1's ceilings.

### Actions

- **Flips (7 specs)**: Status → **FROZEN at 3f6accc** with `J-dv_lead-0009` at
  SPEC-M10 … M13 and SPEC-M14 … M16; §12 countersignature and `Frozen at` rows
  completed on all seven; batch E's three `Interface compile check` rows filled
  with run **30739442056 / `success` / 3f6accc**; batch D's four rows gained the
  same run appended beside 30736107842 / 2f29888; §11.1 closed at M14, M15, M16.
- **Eleven further §11 closures** at SPEC-M03, M05, M06, M08, M10 (×2), M13, M14,
  M15, M16 (×3), each in place with its number kept.
- **C-24 … C-30 landed** as six §13-recorded spec diffs (SPEC-M13 ×3, SPEC-M14
  ×3, SPEC-M16 ×1), touching §6.1, §6.2, §7, §8, §9 and §10 as each item
  required; no §4.1 block moved.
- **ADR-0010** written (consumer conventions: `open! Axi64`; `module type S`
  stays a lift device), restated in architecture.md §2.3.
- **ADR-0011** written (an under-delivery leaves the transmit path unterminated;
  `clear` recovers), with three rejected alternatives priced.
- **Four specifications written**: `docs/specs/modules/{udp_ip_rx_64,
  udp_ip_tx_64,udp_complete_64,nic_top}.md`, template-complete, DRAFT, with four
  new lifts under `docs/specs/ifc_check/` **generated from the specs by the same
  `awk` the checker uses**, so byte-identity is by construction.
- **requirements.md**: REQ-502's and REQ-709's verification columns diffed;
  three §11 non-requirement rows added; a non-normative currency table added to
  §1.1; five §13 revision rows recorded.
- **architecture.md**: §2.3's convention paragraph; §6.4's batch-F confirmation
  with one added control row (`M20.cfg_tx_enable → M18.cfg_tx_enable`), the edge
  census 118 → **119** and the §6.4.3 heading 30 → 31; §8's currency rewritten.
- **traceability.md**: twenty batch-F rows filled, plus REQ-001/006/020,
  REQ-610's and REQ-807's second halves, REQ-805 and REQ-810's further owners,
  REQ-802/804/808 extended, and the four PROC rows given process homes; two
  explanatory bullets added.
- **README.md**: the Status section corrected from "M0 … no RTL exists yet" to
  M1 with the true spec count, and the repository map's `specs/` line updated.
- **WO-0019 Return log** written: State → RETURNED, per-item dispositions, both
  conventions answers stated for rtl_lead, the two larger decisions argued, the
  verification results, and nine open questions for dv.

### Evidence

Reproducible from a checkout at this commit:

- `bash tools/check_records_vs_appendix.sh` → **`23 check(s) run, 0 failure(s)`**,
  including four new PASS rows
  `modules/{udp_ip_rx_64,udp_ip_tx_64,udp_complete_64,nic_top}.md §4.1 ==
  ifc_check/<name>_ifc.ml (byte identical, SPEC-TEMPLATE rule 6)` and the
  unchanged `Config`/`Status`/§9.1/§12 checks.
- `bash tools/dv_checks.sh` → exit 0, final line `dv_checks: all checks passed`;
  `check_emitted_verilog.sh` section `OK` with `4 check(s) run, 0 failure(s), 4
  pending` (the four PENDING rows are REQ-306, REQ-808, REQ-017 and REQ-903,
  all awaiting RTL, unchanged by this commit).
- **REQ set equality**, recomputed mechanically over both files: requirements.md
  **110** ids, traceability.md **110** rows, **0** duplicate rows, symmetric
  difference **empty**, and **0** rows whose Spec-section cell reads `pending`.
- **architecture.md §6.4 recounted by strict row shape**: `{'tx': 40,
  'control': 31, 'rx': 26, 'status': 22}`, **total 119** — the previous 118 plus
  the single `cfg_tx_enable → M18` row, matching §6.4's own claim.
- **Freeze evidence cited, not produced by me**: CI `build` run **30739442056**,
  conclusion **`success`**, head SHA **3f6accc** — externally verifiable, fetched
  through the GitHub API by dv_lead (`J-dv_lead-0009` §0) rather than taken from
  a packet; and run **30736107842** / `success` / **2f29888** for batch D's first
  elaboration.
- **Owed and not available at this commit**: a CI `build` run over the four new
  lifts. Every batch-F §12 `Interface compile check` row reads `pending` and
  every batch-F §11.1 says so; per ADR-0005 a local build would not be acceptable
  evidence and none was attempted.
- `libs/**` was not read or written in this activation; `test/**` and `tools/**`
  were not written.

### Outcome

**DoD met.** (1) D/E flips and §12 fills recorded, with §11.1 closed at batch E
and the 3f6accc run added to batch D's rows. (2) C-24 … C-30 all landed as
§13-recorded diffs, none breaking, none touching a §4.1 lift. (3) Both
conventions questions answered decisively and normatively in ADR-0010; batch-B
RTL is unblocked on them. (4) Four batch-F specifications template-complete with
byte-identical lifts, declare-once honoured (one new record, `Udp_tx_request`, at
its owning module), the two-half pattern applied at REQ-708 and REQ-709 and
tiled at REQ-610, REQ-807 and REQ-505, ADR-0008 restated at M18, and M20's
end-to-end budget derived by both routes at both start lanes. (5) Set equality
holds at 110 = 110 with no `pending` cell. **The 20-module inventory is fully
drafted; sixteen specifications are FROZEN and four are DRAFT.**

Handoff: `agents/handoffs/WO-0019_batch-f-specs.md`, **RETURNED**, with per-item
dispositions, the two conventions answers written for rtl_lead to cite, the two
larger decisions argued in full, and nine open questions ordered by how much I
want them tested. Next: a CI `build` run at this commit, then a batch-F
countersignature work order to dv_lead. dv_lead has already stated the condition
it will apply — no one-sided REQ-610, REQ-807 or REQ-505 row — and all three are
now two-sided with no `pending` cell anywhere in the matrix.

### Open-questions

1. **ADR-0011 is the item I most want contested.** An application under-delivery
   leaves the transmit path holding an unterminated frame and `clear` is the
   recovery. The alternative — M04 consumes and discards the aborted frame's
   remainder — is better hardware and costs a REQ-207 scoping diff plus a
   post-freeze §6 change at a frozen batch-B spec. I priced it and deferred it;
   if dv judges that a design needing a reset after an application error is not
   testable in good conscience, the (a) diff is drafted next.
2. **The `cfg_tx_enable → M18` control edge**, added so REQ-810's `tready` clause
   is true at the port it names rather than approximately true by backpressure
   propagation. Same shape as batch E's `cfg_subnet_mask → M14`.
3. **M18's stall count is W − J = 1, not W − J + 1 = 2**, derived rather than
   copied, because M18's output word 0 is accepted on the same cycle as its first
   application word while M15's leaves one cycle after. If that derivation is
   wrong every transmit bench inherits the error.
4. **REQ-006 = 13 cycles at *both* start lanes**, 83.2 ns against 153.6 ns. Both
   of §0.5's routes agree; the lane-independence makes a per-lane difference a
   defect rather than a legitimate variation, which is sharper than REQ-006 says.
5. **M17's two cycles of reserve** and the decision **not** to re-allocate §1.1's
   17 down to the 13 actually spent, at this gate.
6. **M17's truncated-alone precedence rule is scoped over the whole 8-octet
   header** rather than over the four octets the port test needs. A narrower rule
   is defensible and is one clause away.
7. **SPEC-M04 §9's "pulse together" bullet** is misleading now that M18 exists —
   the two strobes are ordered and their separation is unpinned. I stated the
   correction at SPEC-M18 §9 and requirements.md REQ-709 and did **not** edit the
   frozen batch-B text; dv's call whether the one-line diff at M04 is owed.
8. **A CI `build` run over the four new lifts is owed** before any batch-F §12
   row can be filled. `nic_top_ifc.ml` is the first lift to carry `Config` and
   `Status` field-name witnesses and the first to open two lifts at once;
   `udp_complete_64_ifc.ml` is the first to open a record declared by a sibling
   in its own batch.
9. **Unchanged on the ledger**: **C-2** (now load-bearing at M10, M14 and M17,
   and stated at each), **C-3** (answered in text at SPEC-M20 §9; closes at the
   top-level stress bench), **C-5**, **C-7**, **C-9's REQ-903 half**. C-24 … C-30
   are all landed.
10. **SPEC-M17 §11.3 and SPEC-M18 §11.3 are Phase-2 scoping items (E2-shaped) and
    are recorded before anyone assumes otherwise**: the application receives no
    IPv4 source address, and REQ-705 has no upper bound on the declared payload
    length.

### Files-in-this-commit
- README.md
- agents/handoffs/WO-0019_batch-f-specs.md
- docs/adr/ADR-0010-consumer-conventions-for-the-frozen-records.md
- docs/adr/ADR-0011-under-delivery-leaves-the-transmit-path-unterminated.md
- docs/specs/architecture.md
- docs/specs/ifc_check/nic_top_ifc.ml
- docs/specs/ifc_check/udp_complete_64_ifc.ml
- docs/specs/ifc_check/udp_ip_rx_64_ifc.ml
- docs/specs/ifc_check/udp_ip_tx_64_ifc.ml
- docs/specs/modules/arp.md
- docs/specs/modules/arp_cache.md
- docs/specs/modules/arp_eth_rx.md
- docs/specs/modules/arp_eth_tx.md
- docs/specs/modules/eth_axis_rx.md
- docs/specs/modules/eth_demux.md
- docs/specs/modules/eth_mac_10g.md
- docs/specs/modules/ip_complete_64.md
- docs/specs/modules/ip_eth_rx_64.md
- docs/specs/modules/ip_eth_tx_64.md
- docs/specs/modules/nic_top.md
- docs/specs/modules/udp_complete_64.md
- docs/specs/modules/udp_ip_rx_64.md
- docs/specs/modules/udp_ip_tx_64.md
- docs/specs/modules/xgmii_rx_64.md
- docs/specs/requirements.md
- docs/specs/traceability.md

## [J-architect_docs_lead-0009] 2026-08-02T15:30:00Z | task:WO-0021 | F-1 repaired in SPEC-M17 DRAFT text (the abort bit the `Tail` class cannot carry); C-31's §13 diff at frozen SPEC-M04; C-34/C-35 at SPEC-M18

### Trigger

WO-0021, `agents/handoffs/WO-0021_f1-repair.md`, issued by the orchestrator after
dv_lead **withheld** the batch-F countersignature on exactly one item (WO-0020
Return log at `14e8999`, `J-dv_lead-0010`). SPEC-M18, SPEC-M19 and SPEC-M20 were
SIGNED; SPEC-M17 was CONTESTED on **F-1**, and six carry-forwards C-31…C-36 were
raised. This activation is the one architect activation dv_lead priced between
the withheld signature and 20/20 FROZEN.

### Inputs

- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` (§4 grammar,
  §6 scope, §7 gates) — re-read at spawn.
- `agents/handoffs/WO-0021_f1-repair.md` (the work order) and
  `agents/handoffs/WO-0020_batch-f-countersign.md` **in full** — §2's F-1
  derivation and four-clause owed-diff list, §4's C-31…C-36 table, §5's bounded
  re-review surface and pre-worded countersignature sentence.
- `docs/specs/modules/udp_ip_rx_64.md` (SPEC-M17, all thirteen sections),
  `docs/specs/modules/udp_ip_tx_64.md` (SPEC-M18 §3, §6.2, §8, §9, §13),
  `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04 §9, §13, status header).
- `docs/specs/requirements.md` — REQ-007, REQ-013, REQ-703, REQ-707, REQ-709,
  §0.6's abort/discard and strobe-multiplicity paragraphs, the §13 change log.
- `docs/adr/ADR-0011-under-delivery-leaves-the-transmit-path-unterminated.md` —
  Affects header and Consequences (the authority for C-31's wording).
- `docs/specs/traceability.md` — REQ-007 and REQ-013 rows, to establish that
  neither carries an M17-specific cell and so no traceability diff is owed.
- `libs/**` was not read and no RTL exists for any batch-F module.

### Reasoning

**F-1 is real and the derivation is dv_lead's, reproduced rather than accepted.**
With N the octets IPv4 delivered, N′ the UDP length, K = ⌈N/8⌉ input words and
M = ⌈(N′−8)/8⌉ application words, the input `tlast` is presented on Ci + K − 1
and the application `tlast` word leaves on Ci + M + 1. Using M = ⌈N′/8⌉ − 1 for
every N′ ≥ 9, the separation is **⌈N′/8⌉ − ⌈N/8⌉ + 1** cycles, so a registered
output can carry the bit only where ⌈N′/8⌉ = ⌈N/8⌉. I rewrote the paragraph
around that quantity rather than around the inequality, because the failure mode
of the original text was precisely that it argued a direction instead of
computing a number: "Since N′ ≤ N, M + 1 ≥ ⌈(N − 8)/8⌉ + 1 ≥ K" runs backwards —
N′ ≤ N gives M ≤ ⌈(N − 8)/8⌉ — and the residue algebra beside it is right but
proves only the N′ = N case. A separation formula cannot be run the wrong way.

**Keying everything on D = ⌈N/8⌉ − ⌈N′/8⌉ was the choice that made the rest
fall out.** Once the word-count deficit has a name, `Tail` and D ≥ 1 are provably
the same class (`Tail` is entered exactly when input word M precedes the input
`tlast` word, i.e. M + 1 < K), the three regimes are a table rather than prose,
the 182-cycle worst case is D − 1 at N = 1480 / N′ = 9 rather than a quoted
figure, and — the part I judged worth adding beyond the owed diff — **the class
is visibly a word test and not an octet test**. dv_lead's own phrase, "under-
declares by at least one whole word", reads as N − N′ ≥ 8, which is wrong in both
directions: N = 25 / N′ = 24 under-declares by one octet and is D = 1, and
N = 32 / N′ = 25 under-declares by seven and is D = 0. A bench built on the octet
reading fails a conformant design on the first and passes a broken one on the
second, so §8 now drives one datagram of each and the assertion differs between
them. That pair is the only thing in this commit that was neither owed nor asked
for, and it exists because the boundary is the part a test writer gets wrong.

**The clause-3 fork: dv_lead's reading, not a REQ-007 scoping clause — and the
reason is dv_lead's own test applied to a case where it points the other way.**
dv_lead offered both routes and committed to re-review on either. The
substantive question is whether requirements.md REQ-007 ("every downstream module
that emits an output frame **for it** SHALL mark the corresponding final word …
`tuser`[0] = 1") should gain an exception, or whether M17 should state that the
under-declaring datagram's application frame is a frame for the *declared*
datagram and that REQ-007's universal does not reach it.

I record that I do **not** think dv_lead's subject reading is forced. It is
available — "for it" can individuate by what the frame purports to be rather than
by what arrived — but the plain reading binds M17, and a design that delivers
octets from an invalid frame with `tuser`[0] = 0 has lost something REQ-007
exists to provide. So the honest disposition is: the scoping clause is owed **in
principle**, and the question is only *when*.

What decided *when* is the asymmetry between this item and F-1 itself.
**F-1's price rises at the flip**: it is DRAFT §6 text today and a post-freeze §6
behavioural diff the moment batch F freezes — the exact cost class ADR-0011
spends three paragraphs refusing to pay at M04, which is why dv_lead was right to
withhold and why the repair had to be now. **requirements.md is already FROZEN**,
so a REQ-007 scoping clause is a post-freeze normative diff to a requirement
today and at any later date: **its price does not rise at the batch-F flip.**
Repair what gets dearer; price and carry what does not. Taking it in this commit
would additionally have moved requirements.md, traceability.md's REQ-007 row and
the REQ-007 hook of every implementer — all outside dv_lead's bounded re-review
surface, costing a fresh derivation at the last item of the gate — for no saving
whatever. So §11.4 carries it, with the clause **written out** rather than
promised, the price itemised, the closing gate named (`SO-udp_ip_rx_64.md`, the
packet that would otherwise claim REQ-007 whole at M17), and the residual hole
stated in terms rather than buried: on this class the application cannot discard
on the bit, and no strobe covers it either.

**The rejected alternatives at M17 are recorded because an implementer will
propose them.** Marking `tuser`[0] = 1 on the class instead of 0 aborts every
conformant under-declaring datagram, which §6.2 makes legal and silent; holding
the datagram to its input `tlast` makes the latency length-dependent and kills
REQ-005; a combinational `ip_payload_tuser` → `payload_tuser` path rescues only
D = 1, never D ≥ 2, and is the shape §7 already rejects for `tdata`. **0 is the
only implementable value**, and — the sentence I wanted the spec to carry — it is
not a copy and not a guess: it is the value the bit *has* at the instant the word
is emitted.

**§11.4 also states why the exception is at M17 and nowhere else, in a form that
can be falsified.** M17 is the only module on the chain whose output frame's
extent is fixed by a count declared *inside the data* — the UDP length — rather
than by its input's `tlast`. At M03, M06, M08, M10, M14, M16 and M19 the output
frame ends on or after the input frame does, so the propagation obligation is
satisfiable by construction. Without that sentence the item reads as a local
quirk; with it, a reader can check the claim module by module.

**Two sites moved outside dv_lead's named surface, deliberately.** dv_lead's F-1
diagnosis names **five** sites stating the unimplementable rule but commissions
repairs at three. Leaving §3's REQ-007 row and §4.2's `payload_tuser` row
unqualified would have left SPEC-M17 contradicting its own §6.2 — which is
exactly the pathology C-31 exists to fix, manufactured in the commit that fixes
C-31. Both were moved by adding a pointer to §6.2/§11.4 and asserting nothing
new, and both are quoted verbatim in the Return log so dv_lead's check is
byte-wise rather than derivational. §2's in-scope bullet was **left** and the
decision is stated in the Return log: dv_lead did not name it, and it reads as a
scope enumeration rather than as a statement of the mechanism.

**C-31: the §13 diff at SPEC-M04, not the ADR-0011 correction.** dv_lead
recommended the first and the reasoning holds independently — the second leaves a
frozen specification saying the wrong thing and makes ADR-0011's Affects header
false in a different way. One row, `Breaking? no`, appended last because the
table is chronological by journal id; ADR-0011's own Consequences bullet is
quoted in the ADR cell as the authority for the wording, so the diff and the
document that claims it now agree word for word.

**C-34 was landed at three sites rather than one**, because the overlap is
visible in the state table, in the rule, and in the stimulus that exercises it:
`Body`'s exits are reworded to be disjoint at the source, `Drain`'s entry
condition excludes the mid-word case, a new paragraph states the precedence with
dv_lead's reason for it, and §8 item 4's "ten excess words" becomes "ten excess
octets — ten octets in two words". The octet-numbering convention differs
between §8 (from 1) and dv_lead's C-34 (from 0), so the paragraph says so; an
unexplained 96–99 against 97–100 would read as a disagreement.

**C-32, C-33 and C-36 were not taken.** Each needs text at modules outside the
bounded surface (SPEC-M14, M19, M20, and M18 §10), their gates are later, and
none is cheap enough to justify a fresh derivation from dv_lead at the last item
of the gate. Their cost does not rise at the flip either — the same test applied
consistently.

### Actions

- `docs/specs/modules/udp_ip_rx_64.md` (SPEC-M17, DRAFT — no §13 row owed):
  §6.1's availability paragraph replaced by the corrected derivation, the D-keyed
  regime table, the scoped residue algebra, the words-not-octets note and the
  `Tail`-class outcome, plus a new paragraph separating the over-declared case;
  §6.2's `Payload` and `Tail` rows qualified; §3's REQ-007 row and §4.2's
  `payload_tuser` row given the §6.2/§11.4 pointer; §8's under-declaring datagram
  given the two-run `tuser`[0] = 0 assertion and a D = 0 boundary companion
  (IPv4 total length 52, UDP length 25); §10's REQ-007/REQ-013 hook split with a
  positive assertion for the excluded class; **new §11.4**.
- `docs/specs/modules/udp_ip_tx_64.md` (SPEC-M18, DRAFT — no §13 row owed):
  §3's REQ-015 bound 184 → **185** with the arithmetic and the consequence
  (C-35); §6.2's `Body` exits and `Drain` entry reworded plus a new precedence
  paragraph (C-34); §8 item 4's units corrected to octets with the two-word
  breakdown and the numbering convention named (C-34).
- `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04, **FROZEN**): §9's co-occurrence
  bullet rewritten as ordered-and-unpinned; one **§13 row** appended
  (`Breaking? no`, `ADR: ADR-0011`) (C-31).
- `agents/handoffs/WO-0021_f1-repair.md`: Return log with per-item dispositions,
  the clause-by-clause repair, the clause-3 choice and its reason, the two
  out-of-surface sites quoted verbatim, and the re-review offer.
- **No `§4.1` block was touched anywhere**, dv_lead's re-review being byte-wise
  on the lifts. No requirements diff, no ADR diff, no traceability diff, no
  `docs/gates/`, no RTL, no tests. No git command was run.

### Evidence

Reproducible from a checkout at this commit's SHA:

- `bash tools/dv_checks.sh` → **exit 0**. `check_records_vs_appendix.sh`:
  **23 checks run, 0 failures** — all twenty §4.1 blocks byte-identical to their
  `docs/specs/ifc_check/*.ml` lifts (including `udp_ip_rx_64_ifc.ml`,
  `udp_ip_tx_64_ifc.ml`, `udp_complete_64_ifc.ml`, `nic_top_ifc.ml`), the
  `Status`/`Config` records equal to requirements.md §12/§9.1, and
  `test/monitors/strobes.ml` in agreement. `check_emitted_verilog.sh`: **OK**,
  4 checks, 0 failures, 4 pending (REQ-306, REQ-808, REQ-017, REQ-903 — all
  P1-module-ready conditions, unchanged by this commit).
- REQ set equality, recomputed by script rather than read:
  `grep -oE '^\| \*\*REQ-[0-9]{3}\*\*' docs/specs/requirements.md` → **110**
  rows, 110 distinct; the REQ row leaders of `docs/specs/traceability.md` → **110**
  rows, 110 distinct; `diff` of the two sorted sets → **empty**. No REQ was
  added, dropped or renumbered by this commit.
- `git diff --stat` → three specification files, **+107 / −22** lines, and
  `git diff -- docs/specs/modules/` contains **no** OCaml source line (no
  `module I = struct`, no `[@@deriving …]`, no `open! …`) — the mechanical form
  of "no §4.1 lift was touched".
- The **CI `build` run at this commit** is owed and is the orchestrator's to
  record: its head SHA must be this commit for batch F's four §12 evidence rows
  to fill with no witnessing argument, which is item 4 of dv_lead's §5 list.
  That run does not exist at the time this entry is written and is not claimed
  here.

### Outcome

**DoD met.** F-1's three owed clauses plus the optional fourth are landed in
SPEC-M17 DRAFT text; C-31's §13 row is landed at SPEC-M04; C-34 and C-35 are
landed at SPEC-M18; set equality holds; no §4.1 lift moved. The one judgement
the work order left to me — dv_lead's clause-3 direction versus a REQ-007 scoping
clause — went to dv_lead's direction, with the scoping clause written out,
priced and carried as SPEC-M17 §11.4 rather than dismissed, and the reasoning
stated in the Return log so dv_lead can re-review the choice and not merely the
text. Two sites beyond the bounded surface moved and are quoted verbatim for a
byte-wise check. Handoff: `agents/handoffs/WO-0021_f1-repair.md` Return log →
orchestrator → dv_lead for the bounded re-review and, if it holds, the
pre-worded batch-F countersignature at this commit's SHA.

### Open-questions

- **REQ-007's scoping clause is owed in principle and deferred on price**
  (SPEC-M17 §11.4). If dv_lead or the auditor judges that a frozen requirement
  may not stand while a module states an exception to it, the clause is written
  out in §11.4 and I will take it as a requirements diff with traceability's
  REQ-007 row and each implementer's hook — one activation, and its cost is the
  same before and after the freeze flip.
- **§2's in-scope abort bullet at SPEC-M17** was left unqualified as a scope
  enumeration. One parenthetical if dv_lead wants it.
- C-32, C-33 and C-36 remain open ledger rows with later gates; C-2, C-3, C-5,
  C-7 and C-9's REQ-903 half are unchanged by this commit.

### Files-in-this-commit

- agents/handoffs/WO-0021_f1-repair.md
- docs/specs/modules/udp_ip_rx_64.md
- docs/specs/modules/udp_ip_tx_64.md
- docs/specs/modules/xgmii_tx_64.md

## [J-architect_docs_lead-0010] 2026-08-02T16:50:00Z | task:WO-0023 | C-37 repaired at FROZEN SPEC-M14 (the abort bit ordinary Ethernet padding makes uncopyable) — ADR-0012, the programme's first post-freeze behavioural spec diff; C-39/C-40; batch F flipped FROZEN

### Trigger

WO-0023, `agents/handoffs/WO-0023_c37-repair.md`, issued by the orchestrator
after dv_lead countersigned batch F at `d8df28d` (WO-0022 Return log at
`0536819`, `J-dv_lead-0011`) and raised **C-37** — the finding dv_lead called
the most consequential of the programme, self-reported as its own escape from
WO-0018. Spawn short-id WO-0023/2026-08-02T16:50Z, tenth activation. dv_lead
recommended it as the next architect activation ahead of receive-chain RTL and
the orchestrator sequenced it that way, in parallel with WO-0024 (batch-B RTL,
`libs/**`, disjoint).

### Inputs

- `agents/charters/architect_docs_lead.md`, `agents/PROTOCOL.md` (§3 packets,
  §4 grammar, §6 scope, §7 gates) — re-read at spawn.
- `agents/handoffs/WO-0023_c37-repair.md` and
  `agents/handoffs/WO-0022_batch-f-rereview.md` **in full** — §3 is C-37's whole
  statement and my only authority for the defect's shape; §4's C-37…C-40 table;
  §2's C-40 site list; §5's CI figures (run 30744579228, `success`, head SHA
  d8df28d).
- `docs/specs/modules/ip_eth_rx_64.md` (SPEC-M14, all thirteen sections, FROZEN
  at `3f6accc`), `docs/specs/modules/udp_ip_rx_64.md` (SPEC-M17 §2, §3, §4.2,
  §6.1, §6.2, §8, §10, §11.4, §12, §13 — the F-1 repair as the wording model),
  `docs/specs/modules/udp_ip_tx_64.md` (SPEC-M18 §6.2, §7, §8 item 4, §11.1,
  §12, §13 — to price C-38), `docs/specs/modules/udp_complete_64.md` and
  `docs/specs/modules/nic_top.md` (§11.1, §12, §13 only, for the freeze flip).
- `docs/specs/requirements.md` — REQ-007, REQ-013, REQ-104, REQ-408, REQ-605,
  REQ-702, REQ-707, REQ-710, §0.6, §12's strobe appendix, §13's revision record.
- `docs/specs/traceability.md` — REQ-007, REQ-013 and REQ-710 rows, to establish
  that none carries an M14- or M17-specific cell and so no traceability diff is
  owed.
- `docs/adr/ADR-0011-...md` as the ADR form to follow; my own
  `J-architect_docs_lead-0009` for the F-1 reasoning this repair transposes.
- `tools/dv_checks.sh`, `tools/check_records_vs_appendix.sh` (its Status-vs-§12
  check reads SPEC-M01's `Status` **record**, not a spec's status header — which
  is why the freeze flip cannot break it). `tasks/BOARD.md` for programme state.
- `libs/**` was not opened: rtl_lead is mid-flight there on WO-0024 and C-37 is a
  defect in `docs/specs/modules/ip_eth_rx_64.md`, not in RTL.

### Reasoning

**C-37 re-derives, and I checked it rather than accepted it.** With N the octets
of the Ethernet payload (padding included, REQ-408) and N′ the IPv4 total length,
K = ⌈N/8⌉ input words and M = ⌈(N′−20)/8⌉ payload words, the input `tlast` is at
Ci + K − 1 and the payload `tlast` word at Ci + M + 3, so the separation is
⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4. For a 64-octet frame (N = 46) the threshold is N′ ≥ 37,
so total lengths 21 … 36 all lose the bit; total length 28 sits at separation −1
and UDP length 9 (total length 29) at exactly 0. The frozen §6.1 argued the
opposite from "Since N′ ≤ N, M + 3 ≥ ⌈(N − 20)/8⌉ + 3 ≥ K" — the second
inequality holds, the first runs backwards, character for character F-1's error.
Its worked example reproduced only because that example carries no padding at
all, which §8 says in terms; the sentence that followed ("where padding is
stripped the inequality is slack") inverted the dependence outright — padding is
what closes the window, since every padding octet raises K and none raises M.

**The one number I could not reproduce, and the reconciliation is worth more than
either figure.** dv_lead's worst case is 184 cycles; mine is 183. Both are right
and they measure to different events: M17's regime table — the convention this
repair copies — measures against the cycle the input `tlast` is *presented*,
while 184 is the distance to the cycle the bit is *readable by a registered
output*, one later. I put 183 in the table in the M17 convention and named 184 in
the same cell, because a later reader finding two numbers in two documents would
otherwise have to redo the derivation to learn that neither is wrong.

**The design decision was never really open, and the ADR says why in the order the
alternatives will actually be proposed.** Holding the payload `tlast` to the
input `tlast` costs REQ-005's per-octet constant, REQ-019's pinned ΔC = 4 and
§1.1's allocation — three documents — to buy a delay of up to 183 cycles; a
combinational path rescues only D = 1, and at M14 D ≥ 2 is the *common* member of
the class (total length 28 in a minimum frame is D = 2), so it rescues almost
nothing; store-and-forward is REQ-005's explicit prohibition. The alternative I
spent the most thought rejecting is **marking 1** on the class. At M17 it is
merely wrong; at M14 it is a different order of wrong, because the class is
ordinary Ethernet padding — a conformant, valid, correctly received 64-octet
frame would reach the application marked invalid, and REQ-013's vocabulary
("this frame was found invalid") would become a false statement made constantly.
So the derived 0 wins, and the sentence I wanted M14 to carry is M17's: it is not
a copy and not a guess, it is the value the bit *has* at the instant the word is
emitted.

**Keying M14 on a cycle deficit rather than reusing M17's word deficit is the
judgement in this repair, and it is forced by arithmetic rather than taste.**
M17 strips eight octets — a whole datapath word — so M = ⌈N′/8⌉ − 1 identically
and its D is simultaneously a word deficit, a cycle deficit and the `Tail`
predicate. M14 strips twenty. Working through the residues, ⌈(N′−20)/8⌉ is
⌈N′/8⌉ − 2 at N′ mod 8 ∈ {0,5,6,7} and ⌈N′/8⌉ − 3 at {1,2,3,4}, so M14's cycle
deficit is the word deficit **less one** at four residues in eight. Three
consequences, all of which had to be written down or a bench would get them
wrong: (i) M14's D can be −1, so the ordinary fully delivered datagram sits one
cycle clear of the boundary here and exactly on it at M17; (ii) the *rule* is
nevertheless identical at both modules — copy iff D ≤ 0 — and collapses to M17's
"D = 0" there, which is what lets one scoping clause cover both; and (iii)
**`Tail` and the derived-0 class are NOT equal at M14**, where M17 pins them
equal. `Tail` is entered on the word deficit, the copy is lost on the cycle
deficit, and the first is the larger set — a padded datagram can enter `Tail` and
still carry the bit. Pinning the two names equal at M14 by analogy would have
been the single most likely error in this repair, and it would have been
invisible: it fails only at four residues.

**That is also why §8's directed pair is 36 and 37 rather than one member of the
class.** The two datagrams agree on everything a wrong design keys on — same
frame, both padded, both in `Tail`, word deficit exactly 1 for both — and differ
only in D. A design that copies unconditionally fails 36; a design keyed on "the
datagram is padded", on `Tail`, or on M17's word deficit drives 0 on both and
fails 37. dv_lead's own M17 pair bounds a class from both sides; this pair bounds
a *different* boundary, and it exists because the M14/M17 analogy is the trap.

**The residual is the part of this activation I am least comfortable signing, and
the discomfort is recorded rather than resolved away.** A bad-FCS 64-octet frame
carrying a short datagram now reaches the application with `tuser`[0] = 0 and
cannot be discarded on the bit: REQ-104 → REQ-007 → REQ-707 is broken end to end
for the commonest small frame. I carry it, on four grounds and with the boundary
named. (1) The *event* is still reported where it was detected — `error_bad_fcs`
at M03 reaches the top-level `Status` record — so what is lost is the attribution
of the loss to one frame at the application port, which is strictly smaller than
the silent discard §0.6 prohibits. (2) The class is entered only by a frame that
is already invalid: no valid frame's data is corrupted and none is dropped; the
failure is a failure to warn, and the alternative that "fixes" it (marking 1)
converts it into a failure to deliver. (3) It does not compound, and this is the
hinge the work order handed me: M14's consumer is M17, which since the F-1 repair
re-derives its own D and treats the inherited bit as data rather than relying on
its timing, so a derived 0 from M14 is inert there. The composite statement —
that the application sees the mark iff **both** modules can carry it — is one
neither specification could make alone, and §11.5 with §11.4 now let a reader
assemble it. (4) Nothing is bought by blocking: both documents that would move
are frozen already. What would change the judgement is written into the ADR — a
Phase-2 feed handler treating an unmarked datagram as authoritative, or a real
link partner with a non-negligible bad-FCS rate — and the repair then is a strobe
at M14, which is a new port, a twenty-second name in §12, a `Status` field, three
relay rows and a new REQ, hence **E2** and not mine to freeze in-role.

**REQ-007's scoping clause is now owed at two modules and is still carried, and I
applied my own §11.4 test rather than reaching for the bigger instrument because
the finding felt big.** requirements.md is FROZEN, so the diff costs the same
today and at either gate: its price does not rise. Taking it here would have
moved requirements.md, traceability.md's REQ-007 row and the REQ-007 hook of nine
implementers — eight of them frozen, each owing its own §13 row — inside the
commit carrying the programme's first post-freeze behavioural repair, for no
saving whatever. It would also have reversed a disposition dv_lead priced and
bound itself to, in a commit dv_lead has not been asked to review for that. So
§11.5 carries it as §11.4's **second customer**, with the corrected
generalisation, the second gate (`SO-ip_eth_rx_64.md`) and the note that whichever
gate comes first decides both.

**§11.4's falsified sentence is corrected in the same falsifiable form it was
written in, not retreated from.** That sentence is why C-37 exists: dv_lead
checked it module by module because it *could* be checked, found M14, and
verified M10's safety on a ground §11.4 had not given (M10 emits no stream, so
there is no `tlast` word to set). Rewriting it as a hedge would remove the
property that made the escape findable. The corrected claim is exactly as
checkable: the exception is the modules whose output extent is fixed by an
in-data count — M14 and M17 and those two only.

**The relay sweep was landed at M14 in the same commit as the behaviour, on
purpose.** dv_lead raised the equivalent five sites at M17 as C-40; M14 has the
same five (§2's in-scope bullet, §2's not-my-job row, §3's REQ-007 and REQ-013
rows, §4.2's two `tuser` rows). Repairing §6 and leaving them unqualified would
have manufactured, at M14, exactly the pathology C-31 exists to fix — a
specification contradicting its own §6.2 — in the commit that fixes it one module
over. So M14 never needs a C-40 of its own.

**C-38 was not taken, and the reason is the test I have just applied twice.**
dv_lead's repair is precise and I agree with it, but it is not the one-clause
change the work order's "if genuinely cheap" condition contemplates: it moves
`Body`'s Does cell, both its forward exits, `Drain`'s entry and Does cells, and
`Excess`'s "completes the output frame exactly as `Drain` does" sentence, which
stops being true once the output `tlast` has already been emitted from `Body`
under §7's pinned 1-cycle latency — and the whole thing must be re-derived
against §9's pinned strobe cycle. That is a second post-freeze *behavioural*
repair, at a different module, under a different gate, inside the commit carrying
the first. SPEC-M18 is already FROZEN, so its price is flip-invariant and nothing
is bought by taking it now.

**The freeze flip was the one thing I did that no one asked for, and I flag it as
such.** Batch F's four specifications still carried `DRAFT` headers,
`pending — CI run <id>` in every §12 row and "This spec is DRAFT and has none"
over every §13, while `tasks/BOARD.md` and the gate checklist say all twenty are
FROZEN. Writing post-freeze §13 rows into SPEC-M17 under a preamble asserting it
has none is incoherent, so the flip is presupposed by this work order's own
deliverables. I flipped all four rather than the two this WO touches, because a
split batch signed by one sentence at one SHA would be a new inconsistency where
there was one; the §12 evidence is dv_lead's own (run 30744579228, `success`,
head SHA d8df28d) and each §11.1 `ifc_check` item closes against it. It is the
same act I performed for batches D and E at WO-0019, it is inside `docs/specs/**`,
and the Return log says plainly that it is cheap to revert.

### Actions

- **New `docs/adr/ADR-0012-the-abort-bit-m14-cannot-copy.md`**: Context (the
  falsification and the derivation), Decision (six numbered clauses), six priced
  Alternatives (hold the `tlast`; combinational path; store-and-forward; mark 1;
  add a strobe — E2; take the REQ-007 clause now), Consequences (the residual's
  four grounds, what would change the judgement, REQ-605's directed case checked,
  the escape's ownership, the churn tally).
- `docs/specs/modules/ip_eth_rx_64.md` (SPEC-M14, **FROZEN**): §6.1's
  availability paragraph replaced by the separation formula, the D-keyed regime
  table, the named error, the under-fill threshold and the M17-D distinction;
  §6.1's cycle table pinned as the D = −1 case; §6.2's `Payload` copy made
  conditional and `Tail` pinned as a proper superset; §8 gains the 36/37 boundary
  pair and a band note on the 20 … 28 set; §10's REQ-007/REQ-013 hook split with
  a positive assertion for the excluded class; new **§11.5**; §2, §3 and §4.2
  swept at five sites; §13 gains one **behavioural** row citing ADR-0012, and its
  preamble now separates breaking from behavioural.
- `docs/specs/modules/udp_ip_rx_64.md` (SPEC-M17): §11.4's enumeration corrected
  with M10's independent ground and the second customer, its Tracked-as and
  Closes-by cells extended; **C-40** landed at five sites (§3's "on or after" →
  "after", pinned to D = 0; §2 ×2, §3's REQ-013 row, §4.2's input row); status
  header, §11.1, §12 and §13 flipped to FROZEN with two §13 rows.
- `docs/specs/requirements.md`: **C-39** — REQ-710's verification column's units
  corrected to octets-in-two-words with the reason; one §13 revision-record row,
  class editorial. REQ-710's normative sentence untouched.
- `docs/specs/modules/udp_ip_tx_64.md`, `udp_complete_64.md`, `nic_top.md`:
  freeze flip only (status header, §11.1 closure, §12's four/five rows, §13
  preamble). No §6, §7, §8, §9 or §10 text touched in any of the three.
- `agents/handoffs/WO-0023_c37-repair.md`: State ISSUED → RETURNED; Return log
  with the ADR's decision, the residual judgement, the per-section diff table,
  the 183/184 reconciliation, the C-39/C-40 confirmations, the C-38 refusal and
  the flagged freeze flip.
- **No `§4.1` block was touched anywhere**; no ADR was edited; no
  `traceability.md`, `architecture.md`, `docs/gates/`, `docs/reports/`, `libs/`,
  `test/` or `tools/` file was touched. No git command was run.

### Evidence

Reproducible from a checkout at this commit's SHA:

- `bash tools/dv_checks.sh` → **exit 0**. `check_records_vs_appendix.sh`:
  **23 checks run, 0 failures** — all twenty §4.1 blocks byte-identical to their
  `docs/specs/ifc_check/*.ml` lifts, the `Status`/`Config` records equal to
  requirements.md §12/§9.1, and `test/monitors/strobes.ml` in agreement.
  `check_emitted_verilog.sh`: **OK**, 4 checks, 0 failures, 4 pending (REQ-306,
  REQ-808, REQ-017, REQ-903 — all `P1-module-ready` conditions, unchanged here).
- REQ set equality, recomputed by script rather than read:
  `grep -oE '^\| \*\*REQ-[0-9]{3}\*\*' docs/specs/requirements.md` → **110** rows,
  110 distinct; the REQ row leaders of `docs/specs/traceability.md` → **110** rows,
  110 distinct; `diff` of the two sorted sets → **empty**.
- **No lift touched**: `docs/specs/ifc_check/` does not appear in
  `git diff --stat`, and the byte-identity check above is the mechanical witness
  that no `§4.1` block moved.
- Markdown-table integrity of every edited file re-checked by script: each table
  row's unescaped-pipe count equals its own header separator's — **0 mismatches**
  across the six edited documents and the ADR; and every `**` span on a table row
  balances, which is what a nested-bold edit breaks silently.
- Arithmetic re-derived by hand and checkable from the spec text alone: the
  64-octet worked example (K = 6, M = 4, D = −1, separation 2, matching §6.1's
  own cycle table at Ci + 5 and Ci + 7); the threshold N′ ≥ 8⌈N/8⌉ − 11 giving 37
  at N = 46 and 1493 at N = 1500; the §8 pair (36 → M = 2, `tlast` at Ci + 5;
  37 → M = 3, `tlast` at Ci + 6; word deficit 1 for both); the worst case
  (K = 188, M = 1, D = 184, 183 cycles before presentation).
- **CI is owed and is not claimed here.** The `build` run at this commit does not
  exist as this entry is written; the run cited in the four batch-F §12 rows is
  **30744579228** at **d8df28d**, dv_lead's own figure from the WO-0022 Return
  log §0, verified there against the GitHub API rather than by me.

### Outcome

**DoD met.** ADR-0012 exists and decides the M14 abort-bit question with the
residual argued rather than asserted; SPEC-M14's diff set is landed at every
section the work order names plus the five relay sites it did not, under one
§13 row marked behavioural and citing the ADR; SPEC-M17 §11.4's falsified
enumeration is corrected with the second customer cross-referenced; C-39 and C-40
are landed with their §13 rows; no §4.1 lift moved and REQ set equality holds.
C-38's spec half was judged **not cheap** and declined with reasons, which the
work order permitted. One act beyond the list — flipping batch F's four
specifications to FROZEN — is flagged in the Return log for reversal if the
orchestrator wants it in its own commit. Handoff:
`agents/handoffs/WO-0023_c37-repair.md` Return log → orchestrator → dv_lead, with
a bounded re-review surface named in §8 of that log.

### Open-questions

- **The residual is carried, not closed** (ADR-0012, SPEC-M14 §11.5): on the
  D ≥ 1 class a bad-FCS frame reaches the application unmarked. If dv_lead or the
  auditor judges that unacceptable for Phase 1, the repair is the M14 strobe of
  alternative (e) and it is an **E2** escalation, not an in-role decision.
- **REQ-007's scoping clause is owed at two modules and gated at two packets.**
  If a frozen requirement may not stand while two specifications state exceptions
  to it, I will take it as one activation: requirements.md REQ-007,
  traceability.md's REQ-007 row and nine implementers' hooks, each frozen spec
  owing a §13 row.
- **C-38 remains open** on dv_lead's M18 attack plan as a mandatory row, gated at
  `SO-udp_ip_tx_64.md`, with my pricing of it in the Return log §6 for dv_lead to
  contest.
- **`requirements.md`'s own status header still reads "DRAFT — candidate for
  `P1-spec-freeze`"** while §13 treats it as frozen behind `J-dv_lead-0002`. That
  is arguably correct (the gate is unsigned by the sponsor), but the two readings
  should be reconciled once the sponsor signs; I did not touch it here.
- C-2, C-3, C-5, C-7, C-9's REQ-903 half, C-32, C-33 and C-36 remain open ledger
  rows with later gates, unchanged by this commit.

### Files-in-this-commit

- agents/handoffs/WO-0023_c37-repair.md
- docs/adr/ADR-0012-the-abort-bit-m14-cannot-copy.md
- docs/specs/modules/ip_eth_rx_64.md
- docs/specs/modules/nic_top.md
- docs/specs/modules/udp_complete_64.md
- docs/specs/modules/udp_ip_rx_64.md
- docs/specs/modules/udp_ip_tx_64.md
- docs/specs/requirements.md
