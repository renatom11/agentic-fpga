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
