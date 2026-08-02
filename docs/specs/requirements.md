# Phase-1 Requirements — 10G Ethernet subsystem (XGMII MAC + ARP/IPv4/UDP)

- **Status**: DRAFT — candidate for `P1-spec-freeze`
- **Owner**: architect_docs_lead · **Work orders**: WO-0002 (original),
  WO-0004 (revision applying the WO-0003 testability diffs D-1 … D-16)
- **Countersignature required**: dv_lead (testability, PROTOCOL §7) — against
  this post-diff text
- **Companion documents**: [`architecture.md`](architecture.md) (structure),
  [`traceability.md`](traceability.md) (REQ → spec → test),
  [`SPEC-TEMPLATE.md`](SPEC-TEMPLATE.md) (per-module spec form)
- **Decision context**: `docs/adr/ADR-0001` (program scope), `ADR-0004`
  (Hardcaml v0.17.x), `ADR-0005` (CI is the authoritative build environment)

---

## 0. How to read this document

### 0.1 What this document is a basis for

This file **plus the owning module's frozen specification** is the
test-derivation basis for Phase 1 (PROTOCOL §10): dv_lead and tb_writer derive
tests from that text, never from RTL. Every row here is written to stand alone —
a reader who has never seen the design must be able to build a test from a
single row — but four classes of fact deliberately live in the module spec and
are named here rather than duplicated:

- the **pinned latency constant** of each module (REQ-005, REQ-111, REQ-210,
  REQ-611), bounded by the ceilings in §1.1;
- the **application transmit request handshake** — how the REQ-705 fields are
  presented, when they are stable, how acceptance is signalled — which SPEC-M18
  and SPEC-M20 define;
- the **maximum word count** of each stream (REQ-015), which follows from the
  maximum payload that stream carries;
- the **module pairing** used for co-simulation (REQ-901), which is
  architecture.md §4's counterpart column.

Nothing else requires a second document, and no test derives from RTL.

### 0.2 Conventions

- **SHALL** — mandatory, tested. **SHALL NOT** — mandatory prohibition, tested
  by attempting the prohibited thing. **MAY** — permitted, never required;
  a MAY clause always sits next to a SHALL obligation on the *other* side of
  the interface (what the counterpart must tolerate).
- One REQ states **one** testable fact. Where a behaviour has several
  observable consequences, each consequence gets its own REQ.
- REQ ids are **permanent**. A requirement is never renumbered or reused; a
  retired requirement stays in place marked `WITHDRAWN (ADR-nnnn)`.
- Numbering blocks: `001–021` program invariants · `101–113` XGMII receive ·
  `201–210` XGMII transmit · `301–306` CRC-32/FCS · `401–410` Ethernet framing ·
  `501–512` ARP · `601–612` IPv4 · `701–710` UDP · `801–810` top level and
  configuration · `901–906` verification and process. Blocks are sparse on
  purpose: new requirements are appended inside their block.
- **Kind** tags: `INV` architectural invariant · `IFC` interface contract ·
  `FUNC` functional behaviour · `ERR` error/exception behaviour ·
  `PERF` timing or throughput · `PROC` process/evidence obligation.
- "Strobe" means a **one-cycle-high output** naming a specific event, per
  REQ-008. Strobe names quoted below (`error_bad_fcs`, …) are normative: the
  per-module spec must use exactly these names. §12 enumerates all twenty-one.
- Cycle counts are in clock cycles of the single 156.25 MHz clock; one cycle
  is 6.4 ns.

### 0.3 Frame lengths and the inter-frame gap (normative)

**Frame length convention.** Every frame length stated in this document is
measured in octets from the first destination-address octet through the last
FCS octet inclusive (**DA through FCS**). Preamble, SFD, the terminate
character and the inter-frame gap are never included. Where a length means
something else the sentence says so in those words (REQ-203 says
"destination-address-through-payload"; REQ-605 and REQ-703 use the protocol
fields' own definitions). Consequences a test writer needs directly:

- a 64-octet frame carries **46** octets of Ethernet payload — 64 minus the
  14-octet header minus the 4 FCS octets (REQ-408);
- the maximum frame, 1518 octets, carries 1500, which is REQ-612's maximum
  IPv4 total length;
- the octet string a stream carries after FCS stripping (REQ-103) is always
  four octets shorter than the stated frame length.

**Inter-frame gap convention — one convention, used everywhere.** The
inter-frame gap is measured **from the terminate character inclusive** to the
next start character exclusive, and its minimum is **12 octets**. The terminate
character occupies the first octet position of the gap.

*Why this convention.* It is the one that reproduces IEEE 802.3's frame budget.
A minimum-length frame occupies 8 octets of preamble and SFD, 64 octets of
frame and 12 octets of gap = **84 octets = 10.5 cycles = 67.2 ns**, which is the
14.88 Mpps minimum-frame rate 802.3 fixes for every speed from 1 Gb/s upward. At
1 Gb/s there is no terminate character and all 12 gap octets are idle; counting
the terminate character inside the 12 at 10 Gb/s is exactly what keeps the
budget identical across speeds. The alternative reading — twelve *idle* octets
*after* the terminate character — makes the minimum spacing 88 octets, i.e.
4.5 % slower on average and one full cycle (10 %) slower on the frames that
would otherwise arrive 10 cycles apart. Because the receive path is specified
against the worst case it must survive, that reading would under-drive every
line-rate stress bench permanently while reporting green.

*Against deficit idle count.* XGMII start characters may occupy only lane 0 or
lane 4, so a gap must be rounded up to a multiple of 4 octets. IEEE 802.3
clause 46 resolves this with the deficit idle count (DIC), which lets a
transmitter shorten a later gap — never below 9 octets — so the **average** gap
stays 12. Phase 1 splits the two sides of that behaviour deliberately:

- **Receive (REQ-004)**: the link partner is assumed DIC-capable and to
  alternate lane-0 and lane-4 starts, which realises the 84-octet budget
  exactly — start-to-start spacing alternating **10 and 11 cycles**, 10.5
  average. This is the worst case the receive path must survive, and it is what
  the DV link-partner model emits (REQ-018).
- **Transmit (REQ-201, REQ-204, REQ-209)**: DIC is out of Phase-1 scope (§11)
  and the transmitter starts frames on lane 0 only, so it rounds every gap up to
  the next lane-0 boundary — a minimum-length frame every **11 cycles**, with a
  gap of 16 octets counted from the terminate character inclusive. That is
  802.3-legal (the gap is never shorter than 12); it under-uses the link, it
  does not violate it.

### 0.4 The receive path (normative)

The **receive path** is the chain of modules and streams carrying received
frame octets from the XGMII receive lanes to the application receive stream
(architecture.md §6.1):

> M03 `Xgmii_rx_64` → M06 `Eth_axis_rx` → M08 `Eth_demux` →
> { M10 `Arp_eth_rx` , M14 `Ip_eth_rx_64` } → M17 `Udp_ip_rx_64` →
> application receive stream

**Receive-path streams** are the XGMII receive lane pair (`xgmii_rxd`,
`xgmii_rxc`), every `Axi64` stream on that chain, and the header records those
modules emit.

**Structural modules.** M05 `Eth_mac_10g`, M16 `Ip_complete_64`,
M19 `Udp_complete_64` and M20 `Nic_top` are receive-path modules **with respect
to the ports that lie on that chain**, and are bound by every receive-path
requirement on those ports only. Their transmit ports are not receive-path
ports: `Nic_top`'s application *transmit* stream carries an `Axi64.Dest` and
does not violate REQ-003.

**Modules owing a line-rate stress bench** (REQ-004, REQ-905), by name:
**M03, M06, M08, M10, M14, M17 and M20**. M10 `Arp_eth_rx` sees only ARP
packets, so its stimulus is 10 000 minimum-length ARP packets at the REQ-004
arrival rate. Structural wrappers M05, M16 and M19 are covered by their
children's benches unless the wrapper introduces datapath logic of its own, in
which case it joins this list by a spec diff.

### 0.5 Latency, measured per octet (normative)

**Octet time.** The octet time of an octet on an XGMII lane pair is
8 × (its cycle) + (its lane index, 0 to 7). The octet time of an octet on an
`Axi64` stream is 8 × (the cycle of the word carrying it) + (its byte position
within `tdata`, where byte position k is `tdata`[8k+7 : 8k]). Octet time is
observable at every port this document constrains.

**Latency.** The latency of octet n at a module is
(octet time of n at the module's output) − (octet time of n at its input). A
module has **constant latency** iff that value is a single constant L for every
octet of every frame, at every frame length and content the module accepts.

*Why per octet in octet times, and not word-in to word-out.* At a module that
strips a header whose length is not a multiple of 8 (REQ-021: Ethernet strips
14, IPv4 20, UDP 8), and at a lane-4 XGMII start, one output word is assembled
from two input words — so "the cycle that word left minus the cycle that word
entered" names no single event, and the cycle-counted per-octet difference
alternates between two values within a single frame. In octet times the
realignment cancels exactly: a module stripping h octets that takes its first
input word at cycle Ci and emits its first output word at cycle Co has
L = 8(Co − Ci) − h for **every** octet.

**Front offset h (normative).** The front offset of a module, at a given start
lane, is the number of octet times between the octet time of its **input
measurement event** and the octet time, *at that same input*, of the first
octet the module emits for that frame. Equivalently: h = (the octets the module
removes from the front of the frame) + (the position, within the input word
named by the measurement event, of the frame's first octet). For a
word-aligned `Axi64` input the second term is 0 by REQ-021, so h is simply the
header length the module strips: 14 at M06, 0 at M08, 20 at M14, 8 at M17. At
M03 the measurement event is REQ-006's XGMII word carrying the start character,
so h is **8** for a lane-0 start (the start character plus its seven preamble
octets) and **12** for a lane-4 start (four lanes of that word precede the
start character). h is a property of the module and the start lane, is stated
in the module's specification §7, and is not a free choice.

**Word delay ΔC (normative).** The word delay of a module is

> ΔC = (L + h) / 8 cycles,

which is exactly (the cycle of the module's first output word for a frame) −
(the cycle of the input word named by the measurement event), because
L = 8·ΔC − h is the identity the paragraph above derives. Three consequences a
reader needs:

- **ΔC is a whole number.** (L + h) is therefore a multiple of 8 for every
  conformant module. A specification pinning an L for which it is not describes
  a module that cannot exist, and that is checkable by arithmetic at spec
  freeze, before any RTL.
- **ΔC is additive along a chain and floor(L / 8) is not.** Each module's input
  measurement event is the previous module's first output word, so the sum of
  ΔC over the receive chain of §0.4 is exactly the cycle count REQ-006
  measures end to end. floor(L / 8) understates a stripping stage's word delay
  by up to ⌈h / 8⌉ cycles and adds up to nothing in particular.
- **ΔC, not floor(L / 8), is the unit of §1.1's ceilings and REQ-006's
  budget.** They are stated in cycles, and this is which cycles they are.

*Provenance and authority.* The identity and the additivity failure of
floor(L / 8) are dv_lead's finding, raised in the WO-0005 re-review and tracked
as carry-forward **C-1**; the resolution — keeping §1.1's allocated numbers and
changing the unit they are compared in — is the architect's, applied under
WO-0008 with the sponsor's 2026-08-02 delegation of the receive-latency budget
to architect_docs_lead and dv_lead jointly, and sealed by dv_lead's batch-B
countersignature.

**Cycles.** A latency constant is converted to cycles as its word delay ΔC
above. Where h = 0 — every module that strips nothing, and every stream-to-
stream measurement of a non-stripping stage — ΔC = L / 8 = floor(L / 8) and the
two readings coincide; the change of unit only ever moves a stripping stage,
and it always moves it upward.

**Gapped stimulus.** L is measured on a gapless stimulus. REQ-016 requires that
inserting k idle cycles before an input word delays every octet that word
carries by exactly 8k octet times, so L remains well defined on a gapped
stimulus by subtraction.

**Start lanes.** At the XGMII boundary the two start lanes yield two constants
differing by the 4-octet-time difference in the start character's position
within its word; both are pinned in the module spec and SHALL differ by no more
than 8 octet times (one cycle). Everywhere else L is a single value.

In word-delay terms that bound is exactly **ΔC(lane 4) ∈ { ΔC(lane 0),
ΔC(lane 0) + 1 }**, because h differs by 4 between the lanes: equal word delays
make the two L constants differ by 4 and a one-cycle-longer lane-4 word delay
makes them differ by 4 the other way, while any larger gap makes them differ by
12 and breaks the bound above. A module spec pinning a lane-4 word delay
outside that pair is stating something §0.5 forbids, which is again checkable
by arithmetic before any RTL.

### 0.6 Aborts, discards and strobes (normative)

**Abort versus discard.** A module that has already emitted at least one word of
a frame when it detects an error SHALL forward the remainder of that frame and
mark `tuser`[0] = 1 on the word carrying its `tlast` (REQ-007). A module that
detects a discard condition **before** emitting any word of that frame SHALL
emit no output frame at all; REQ-007 does not apply to it and its strobe is the
only report. Where an inherited `tuser`[0] = 1 and a locally detected discard
condition both apply to the same frame, **the local discard wins**: no output
frame is emitted and the local strobe pulses.

**Strobe multiplicity.** A strobe reports a condition the strobing module
detected itself. A module SHALL NOT pulse a strobe to re-report an abort it
merely inherited on `tuser`[0]. If two or more locally detected conditions apply
to one frame, each applicable condition's strobe pulses once for that frame; the
per-module specification enumerates which conditions can co-occur
(SPEC-TEMPLATE §9).

**Strobe timing window.** A strobe SHALL pulse for exactly one cycle, not
earlier than the cycle on which its condition first becomes decidable from the
module's inputs, and not later than the module's latency in cycles (§0.5) after
the input word carrying the last octet of the offending frame. Outside that
window the strobe SHALL be 0.

**Frame conservation.** Over any bench run, at every module:

> (frames presented at the input) = (frames emitted at the output)
> + (zero-payload frames reported by a header-record `valid` pulse with no
> payload frame, §0.7) + (discard-strobe pulses)

with aborted-but-forwarded frames counted as emitted. Any discrepancy is a
silent discard and a REQ-008 violation. This monitor is active in every bench.

### 0.7 Zero-length payloads (normative)

A payload of zero octets **has no encoding on an `Axi64` stream**: REQ-011
forbids `tkeep` = 0 with `tvalid` = 1, and that prohibition stands. A stage
whose output would be a frame of zero payload octets therefore emits **no
payload frame**, and:

- where the stage emits a header record (M06, M14, M17), the header record is
  emitted normally and its `valid` pulse is the frame's only report; every
  downstream module SHALL tolerate a header record that is not followed by a
  payload frame;
- where the stage emits no header record (M03), the event is reported by a
  strobe: a frame carrying fewer than 5 octets between the start and terminate
  characters produces no output words and pulses `error_runt` once (REQ-107).
  The same holds for a frame aborted with zero delivered octets under REQ-105
  (an error character at or before the first frame octet) or REQ-110 (a start
  character arriving inside the previous frame's preamble): no output word,
  no `tlast` word to carry `tuser`[0], and that frame's own strobe as its only
  report.

The cases this rule governs are: a 14-octet Ethernet frame (REQ-401), an IPv4
datagram of total length 20 (REQ-605), a UDP datagram of length 8 (REQ-703,
REQ-707), and any frame whose length leaves zero octets after the headers this
document strips. Frame conservation (§0.6) counts such a frame as accounted for
by its header `valid` pulse.

---

## 1. Program invariants (REQ-001 … REQ-021)

These bind every Phase-1 module. A per-module spec restates the ones that
apply to it (SPEC-TEMPLATE §"REQ coverage") rather than paraphrasing them.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-001** | INV | **Single clock domain.** All Phase-1 RTL SHALL be synchronous to one clock port named `clock`, nominally 156.25 MHz, with no gated clocks, no derived clocks and no clock-domain-crossing structures. | Mechanical check over the emitted Verilog snapshot: every `always @(posedge …)` edge expression names `clock` and no other signal appears in an edge position; simulation runs on a single Cyclesim clock. |
| **REQ-002** | IFC | **Datapath width.** Every frame-carrying interface SHALL be 64 bits wide; a stream carries at most one word per cycle, which the stream type makes structural. | Interface compile check that every frame-carrying port is an `Axi64.Source` or `Axi64.Dest` with `data_bits` = 64 (REQ-010). Throughput obligations belong to REQ-004 and REQ-209, not here. |
| **REQ-003** | INV | **No receive-path backpressure.** No receive-path stream (§0.4) SHALL carry a `tready` signal, and no receive-path module SHALL be able to stall its producer. A consumer SHALL accept every word presented with `tvalid` = 1. | Interface compile check: every receive-path port per §0.4 exposes an `Axi64.Source` record with no matching `Axi64.Dest`; a structural module's transmit ports are excluded by §0.4. Behavioural half is the REQ-004 stress. |
| **REQ-004** | PERF | **Line-rate invariant.** The receive path SHALL sustain minimum-length (64-octet) frames separated by the minimum 12-octet inter-frame gap counted from the terminate character inclusive (§0.3), with start characters alternating between lane 0 and lane 4 — start-to-start spacing alternating 10 and 11 cycles, one frame per 10.5 cycles average — for at least 10 000 consecutive frames, dropping no frame and losing no word. | Line-rate stress bench, mandatory for every module in §0.4's stress-bench list and again at `nic_top`. At a module that does not see XGMII the stimulus is the stream this arrival pattern produces at that boundary, idle gaps preserved, derived by construction from the XGMII case and never re-invented per module. Every one of the 10 000 frames SHALL be one the module under test accepts and forwards, so that frames-out equals frames-in is well defined at a module that legitimately discards. Pass criterion: frame count out equals frame count in, payload octets compare equal, per-octet latency is constant (REQ-005), and frame conservation holds (§0.6). The module exposes no `tready` on the stream under test (REQ-003, structural). |
| **REQ-005** | INV | **Cut-through, not store-and-forward.** No receive-path module SHALL withhold a payload word until the end of its frame. Each receive-path module SHALL have constant per-octet latency as defined in §0.5, independent of frame length and frame content. | Per-octet latency tagger inside the REQ-004 stress bench: tag every input octet with its octet time and every output octet with its octet time; the difference SHALL be identical for every octet. Directed lengths 64 through 71 inclusive (covering all eight `tlast` `tkeep` patterns) plus 1518, at both start lanes. |
| **REQ-006** | PERF | **Receive latency budget.** The delay from the XGMII word containing the start character of a frame to the first word of that frame's UDP payload on the application receive stream SHALL be at most 24 cycles (153.6 ns). This delay is the sum of the **word delays** ΔC (§0.5) of the modules on §0.4's receive chain, which is what makes §1.1's per-module ceilings an allocation of this budget rather than a separate quantity. | Cycle-tagged end-to-end bench at `nic_top`. Measurement events: the cycle of the XGMII word carrying the start character, and the cycle of the first application `tvalid` word of the same frame — the same two events §0.5's word delay is defined between, at the two ends of the chain. The value is measured and reported separately for a lane-0 and a lane-4 start (they may legitimately differ by one cycle, §0.5); both are recorded in the module spec freeze record and in the Phase-1 latency report. |
| **REQ-007** | INV | **Abort propagation.** When a frame is found invalid after forwarding of that frame has begun, its final word SHALL be marked `tuser`[0] = 1, and every downstream module that emits an output frame for it SHALL mark the corresponding final word of its own output stream `tuser`[0] = 1. Precedence against discard conditions is §0.6. | Error injection at each stage (bad FCS, mid-frame error character, truncation); check the abort bit appears on the last word of every downstream stream that emits a frame, and that a stage which discards the frame under §0.6 emits no frame and pulses only its own strobe. |
| **REQ-008** | ERR | **Every discard is observable.** Every condition under which a module discards or truncates a frame SHALL be reported by a dedicated one-cycle-high output strobe named for that condition (§12). Discarding silently is prohibited. | Two halves. (a) For each strobe in §12, a directed test drives the condition and checks that strobe pulses for exactly one cycle inside the §0.6 window, and that no strobe pulses other than those of the conditions the stimulus creates. (b) A frame-conservation monitor per §0.6 active in every bench: a discrepancy between frames presented and frames emitted plus zero-payload header pulses plus discard-strobe pulses is a silent discard and a failure. |
| **REQ-009** | INV | **Reset behaviour.** All state SHALL be held in registers with a synchronous `clear`. On every cycle in which `clear` = 1 and on the first cycle in which it is 0, every `tvalid` output SHALL be 0, every header-record `valid` SHALL be 0 and every strobe SHALL be 0. `clear` asserted mid-frame truncates the in-flight output frame without a terminating word; no `tlast` and no strobe is emitted for it. A frame whose first word is presented on the first cycle after `clear` returns to 0 SHALL be received correctly. | Reset test: assert `clear` mid-frame, deassert, immediately drive a valid frame, check that frame is received correctly and that no output word or strobe appeared while `clear` was high or on the first cycle after. Protocol monitors reset their frame-in-progress state on `clear` (REQ-015). |
| **REQ-010** | IFC | **Typed stream fabric.** Every frame-carrying **stream** port SHALL use the program stream types `Axi64.Source` and `Axi64.Dest` (`Hardcaml_axi.Stream.Make` with `data_bits` = 64, `user_bits` = 1). A *frame-carrying stream port* is a port that carries frame octets **together with the per-word framing signals** — a valid indication, an octet mask, an end-of-frame indication and the abort bit (`tvalid`, `tkeep`, `tlast`, `tuser`). Ad-hoc per-module stream records are prohibited. Exactly one frame-carrying port in the architecture.md §4 inventory is **not** a stream port and is outside this requirement's subject: M02 `Crc32_eth`'s `data` input, whose 64 bits are a function argument accompanied by an octet count and by none of the framing signals, because REQ-306 forbids M02 the state that would give them meaning. Any further non-stream frame-carrying port is a spec diff to this row, not a local reading. | Interface compile check of every module spec's `I` and `O` records against the pinned toolchain, including a type-identity witness per stream port — `let _check (x : Signal.t Axi64.Source.t) = x` applied to the record field — which fails to compile for a hand-written record with the same fields. At M02 the check is the converse and is equally mechanical: its lift declares no stream record at all. The RTL-side binding is rtl_lead's obligation, evidenced by each module's `.mli`. |
| **REQ-011** | IFC | **tkeep semantics.** On every word with `tvalid` = 1, `tkeep` SHALL be contiguous from bit 0; on every such word except the one carrying `tlast` it SHALL be `0xFF`; on the `tlast` word it SHALL be 1 to 8 contiguous ones. `tkeep` = 0 with `tvalid` = 1 SHALL never be produced, so a zero-octet frame is not representable and is encoded per §0.7. | Protocol monitor asserted on every stream in every bench, evaluated only on words with `tvalid` = 1; directed tests at frame lengths covering every payload residue modulo 8 (REQ-005's 64 through 71 set). |
| **REQ-012** | IFC | **Byte and field order.** The first octet received from the wire SHALL appear in `tdata`[7:0] and the eighth in `tdata`[63:56]. Multi-octet protocol fields SHALL be presented in header records as numeric values with network byte order already decoded: the first wire octet of a field is the most significant octet of the value. Ethertype 0x0800 reads as 0x0800; MAC 00:11:22:33:44:55 reads as 0x001122334455; IPv4 192.0.2.1 reads as 0xC0000201. | Directed test with a known captured frame: compare every extracted header field against the hand-computed values, including a MAC field and an IPv4 field, which are the cases a single symmetric ethertype example does not pin. |
| **REQ-013** | IFC | **tuser semantics.** `tuser`[0] SHALL mean "this frame was found invalid; the ultimate consumer must discard it". It SHALL be meaningful only on the word carrying `tlast` and SHALL be ignored by consumers on all other words. No Phase-1 module SHALL drop or alter a frame solely because `tuser`[0] = 1 on its input (REQ-007, REQ-104, REQ-403, REQ-707); it is advisory metadata carried to the application. | Monitor plus a test driving `tuser` = 1 on a non-last word and checking the frame is still delivered intact, and a test driving `tuser`[0] = 1 on a `tlast` word and checking every downstream stage still forwards the frame with the bit set. |
| **REQ-014** | IFC | **tstrb unused.** Every producer SHALL drive `tstrb` to 0 and every consumer SHALL ignore it. | Monitor on every stream; a differential run of the same stimulus with `tstrb` = 0x00 and `tstrb` = 0xFF, asserting the two output traces are byte-identical. |
| **REQ-015** | IFC | **One frame at a time.** A stream SHALL carry the words of exactly one frame between successive `tlast` words. Between two successive words carrying `tlast` = 1 a stream SHALL carry at least one word and at most the number of words its maximum payload requires, pinned in the owning module's spec — for example 190 words on the `Xgmii_rx_64` output stream (1514 octets, REQ-108). A stream SHALL NOT assert `tlast` without at least one preceding word since the previous `tlast`. Merge atomicity is REQ-406. | Protocol monitor over the residue above, on every stream in every bench. The monitor resets its frame-in-progress state on `clear` and makes no assertion across a clear (REQ-009). |
| **REQ-016** | IFC | **Idle words permitted.** On every receive-path stream (§0.4) and every internal frame stream, a producer MAY deassert `tvalid` between words of a frame, and every consumer SHALL tolerate arbitrary idle gaps within a frame without corrupting it: k idle cycles before an input word delay every octet that word carries by exactly 8k octet times and change nothing else. This does not apply to `Xgmii_tx_64`'s source interface, where a missing word after transmission has begun is an underflow (REQ-206). | Idle-injection wrapper around any directed bench, parameterised at 0, 1 and 7 idle cycles between every pair of words at each module boundary, asserting the output word sequence is unchanged and per-octet latency shifts by exactly the injected amount. |
| **REQ-017** | INV | **XGMII closure.** The only wire-side ports of the Phase-1 top level SHALL be `xgmii_rxd`[63:0], `xgmii_rxc`[7:0], `xgmii_txd`[63:0] and `xgmii_txc`[7:0]; all other top-level ports SHALL be clock, clear, configuration, application streams and status. | Port-list check parsing the emitted `nic_top` module in `rtl_snapshots/` and set-comparing against SPEC-M20 §4.1. |
| **REQ-018** | INV | **XGMII boundary is simulation-only.** Phase-1 RTL SHALL contain no PMA, serdes, PCS, 64b/66b, scrambler, auto-negotiation, link-training or PTP-timestamping logic, no vendor-specific primitive and no device constraint file. The link partner SHALL be a simulation model owned by DV under `test/` whose contract is: it emits start characters in lane 0 and lane 4 including the REQ-004 alternation; it injects each condition named in REQ-104, REQ-105, REQ-107, REQ-108 and REQ-110; and it decodes transmit-side XGMII well enough to validate REQ-201 through REQ-205. | Whitelist check, not a blacklist: the emitted Verilog SHALL instantiate no module outside the architecture.md §4 inventory, which catches every vendor primitive by construction. Plus repository inspection at the freeze SHA showing no `.xdc`, `.sdc`, `.qsf` or equivalent constraint file, and that the XGMII driver lives under `test/`. |
| **REQ-019** | INV | **Bounded receive latency, no deep buffering.** Each receive-path module's **word delay** ΔC = (L + h)/8, computed per §0.5 from its pinned latency constant L and its stated front offset h, SHALL be no greater than its ceiling in §1.1 — at **every** start lane where the module's constants differ by lane. No receive-path module SHALL contain payload storage deeper than two datapath words; header fields captured into registers are not payload storage and the ARP cache is not on the payload path — that second sentence is design guidance and is explicitly **not** a DV observable, so `traceability.md` claims no test coverage for it. | Two checks, both against ΔC. At spec freeze: the module spec's pinned L and stated h are converted per §0.5 and compared against §1.1, which is arithmetic on the specification and needs no design. In each sign-off packet: the per-octet latency measured by the REQ-004 stress run (REQ-005) is converted the same way, with h taken from the spec, and compared against the same ceiling. The two must agree; a disagreement is a defect in whichever of the two the evidence contradicts, and the packet says which. |
| **REQ-020** | FUNC | **Order preservation.** Frames SHALL be delivered to the application in the order their start characters arrived, with no duplication and no reordering. | Stress run with a sequence number in the first four payload octets: the delivered sequence SHALL be a strictly increasing subsequence of the injected sequence, and every omitted value SHALL be accounted for by exactly one discard-strobe pulse (§0.6). Over an all-accepted stimulus this reduces to 0, 1, 2, … with no gaps or repeats. |
| **REQ-021** | IFC | **Producer-side word alignment.** Every stream SHALL be word-aligned at its producer: the first octet of the payload a module emits SHALL occupy `tdata`[7:0] of that stream's first word. A module that strips a header whose length is not a multiple of 8 octets SHALL realign the remaining payload. | Directed tests at every stripping stage (Ethernet strips 14, IPv4 strips 20, UDP strips 8 octets) covering payload lengths of every residue modulo 8; assert the first payload octet lands in `tdata`[7:0] and the octet stream is preserved. |

### 1.1 Receive-path latency ceilings (normative, REQ-019)

Transcribed from architecture.md §4, where the same table allocates REQ-006's
24-cycle budget. Each module spec pins its exact latency constant L; the
ceilings below are on the module's **word delay** ΔC = (L + h)/8 (§0.5), which
is the unit REQ-006's budget is in and the unit that adds up along the chain.
Slack is released only by a spec diff, so an over-budget module is a visible
decision rather than an accumulation.

| Stage | Front offset h (octets) | Ceiling on ΔC (cycles) | Largest L the ceiling permits (octet times) |
|---|---|---|---|
| M03 `Xgmii_rx_64` | 8 (lane-0 start) / 12 (lane-4 start) | 4 | 24 / 20 |
| M06 `Eth_axis_rx` | 14 | 3 | 10 |
| M08 `Eth_demux` | 0 | 1 | 8 |
| M14 `Ip_eth_rx_64` | 20 | 5 | 20 |
| M17 `Udp_ip_rx_64` | 8 | 4 | 24 |
| **Allocated** | Σ h = 50 (lane 0) / 54 (lane 4) | **17** | |
| Slack held by the architect | | 7 | |
| Budget (REQ-006) | | 24 | |

**Why this table is now arithmetic and not aspiration (carry-forward C-1).**
Because ΔC is additive (§0.5), a receive chain sitting exactly on every ceiling
costs 4 + 3 + 1 + 5 + 4 = **17 cycles** end to end, which is what REQ-006's
24-cycle budget minus the architect's 7 cycles of slack says it costs. Under
the previous unit, floor(L / 8), the same table permitted word delays of 5, 5,
1, 8 and 5 cycles — **24 cycles at a lane-0 start and 25 at a lane-4 start** —
so every module could pass REQ-019 while REQ-006 failed at the top level with
no packet able to name the module that owed the cycles. Nothing about a
conformant design changed; what changed is that the per-module gate now
measures the quantity the top-level gate measures.

The last column is a convenience, not a second normative statement: it is
8 × ceiling − h, which is always a whole number of octet times and always
satisfies (L + h) ≡ 0 (mod 8). The normative pair is the ceiling and h.

M10 `Arp_eth_rx` is a receive-path module but is not on the application receive
chain REQ-006 measures, so it carries no allocation here; its latency constant
is pinned in SPEC-M10 and is bounded only by REQ-005's constancy requirement.

---

## 2. XGMII receive (REQ-101 … REQ-113)

Owning module: `Xgmii_rx_64`. XGMII control characters referenced here:
`/I/` idle = 0x07, `/S/` start = 0xFB, `/T/` terminate = 0xFD, `/E/` error =
0xFE, `/Q/` sequence ordered set = 0x9C. A lane is "control" when the
corresponding `xgmii_rxc` bit is 1.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-101** | FUNC | **Start lanes.** The receiver SHALL detect a start character in lane 0 or lane 4 and SHALL produce identical output streams for the same frame received at either alignment. | Send the same frame with a lane-0 start and with a lane-4 start; compare the output as the ordered sequence of (`tdata`, `tkeep`, `tlast`, `tuser`) tuples over words with `tvalid` = 1. The absolute cycle of the first output word may differ by one cycle between the start lanes (§0.5); waveform equality is not required and SHALL NOT be asserted. |
| **REQ-102** | FUNC | **Preamble handling.** The receiver SHALL treat the start character and the following seven octets as preamble and SFD and SHALL strip them. It SHALL NOT validate the *data values* of those seven octets. A lane marked **control** in a preamble position is not preamble: a terminate character there is handled by REQ-106 and REQ-107, a start character by REQ-110, and any other control character by REQ-105. | Drive a frame whose six preamble filler octets and SFD octet are arbitrary data values; the frame is still delivered unchanged. Plus one frame with `/E/` in a preamble lane, asserting REQ-105's behaviour, and one with `/T/` in a preamble lane, asserting REQ-107's sub-5-octet behaviour. |
| **REQ-103** | FUNC | **Frame extraction.** The output stream SHALL begin with the first destination-address octet and SHALL end with the last octet before the four FCS octets; the FCS SHALL be stripped and SHALL NOT appear in the output. `tkeep` on the `tlast` word SHALL mark exactly the valid octets. FCS stripping applies only to a frame that ends with a terminate character (REQ-106): a frame aborted under REQ-105, truncated under REQ-108 or cut short under REQ-110 delivers every octet decoded up to its abort point, with no FCS removal attempted. | Directed tests at lengths 64 through 71 inclusive (which covers all eight `tlast` `tkeep` patterns) and 1518 octets, DA through FCS per §0.3: compare the delivered octet string against the injected frame minus its four FCS octets, i.e. 60 through 67 and 1514 octets delivered. |
| **REQ-104** | ERR | **FCS check.** The receiver SHALL compute the CRC-32 FCS over the destination address through the last payload octet and compare it against the received FCS. On mismatch it SHALL set `tuser`[0] = 1 on the `tlast` word and pulse `error_bad_fcs`. The frame SHALL still be forwarded (cut-through, REQ-005). | Inject a frame with one payload bit flipped: the same octet count is delivered, `tuser`[0] = 1 on the last word, `error_bad_fcs` pulses once inside the §0.6 window, and no other strobe pulses unless the stimulus also creates that strobe's condition. |
| **REQ-105** | ERR | **Error character inside a frame.** An `/E/` control character between the start character and the terminate character SHALL cause `tuser`[0] = 1 on the `tlast` word, a single `error_bad_frame` pulse, and termination of the output frame with the last delivered octet being the one immediately preceding the error character — the REQ-106 rule with the error character in place of the terminate character, so an error character in lane 0 means the previous word carried the last octet. No FCS is stripped (REQ-103). **Where the error character leaves zero delivered octets** — an `/E/` at or before the frame's first octet, which includes an `/E/` in a preamble position (REQ-102) — no output word is emitted for that frame, there is **no `tlast` word to mark** and the clause above about `tuser`[0] does not apply; the `error_bad_frame` pulse is the frame's only report, the pattern §0.7 fixes for a stage that emits no header record. Frame conservation counts that frame under its strobe (§0.6). | Inject `/E/` in each of the eight lanes of a mid-frame word; check the delivered octet count, `tkeep` and `tlast` placement, the abort bit and the strobe in all eight cases. Then inject `/E/` in a preamble lane and in the first frame-octet position: check that no output word appears, that `error_bad_frame` pulses exactly once, and that a monitor asserting "every abort is marked on a `tlast` word" is not driven — that assertion is false for these two cases by this row's own text. |
| **REQ-106** | FUNC | **Terminate in any lane.** The receiver SHALL accept the terminate character in any lane 0 through 7. The frame's last octet is the one immediately preceding the terminate character; a terminate in lane 0 means the previous word carried the last octet. | Frame lengths chosen so the terminate character lands in each of the eight lanes; check `tkeep` and `tlast` placement in all eight cases. |
| **REQ-107** | ERR | **Runt frames.** A frame carrying at least 5 and fewer than 64 octets between the start and terminate characters SHALL be forwarded with `tuser`[0] = 1 on the `tlast` word and a single `error_runt` pulse. A frame carrying fewer than 5 octets SHALL produce no output words at all and SHALL pulse `error_runt` once (§0.7); there is no `tlast` word for it to mark. | Inject 5-, 16-, 60- and 63-octet frames with valid FCS and check the abort bit, the delivered octet counts (1, 12, 56, 59 after FCS stripping) and the strobe; inject 0-, 1- and 4-octet frames and check no output word appears and `error_runt` pulses once. Lengths are DA through FCS per §0.3. |
| **REQ-108** | ERR | **Oversize frames.** A frame exceeding 1518 octets (DA through FCS) SHALL be truncated so that exactly **1514** octets are delivered — the payload length of a maximum legal frame — marked `tuser`[0] = 1 on its `tlast` word, and reported by a single `error_oversize` pulse. No FCS stripping is attempted on a truncated frame (REQ-103) and `error_bad_fcs` SHALL NOT pulse for it, since no FCS is present at the truncation point. The receiver SHALL resynchronise on the next start character. | Inject a 1600-octet frame followed immediately by a valid frame; assert exactly 1514 octets delivered, `tuser`[0] = 1 on the last word, exactly one `error_oversize` pulse, no `error_bad_fcs` pulse, and correct reception of the following frame. |
| **REQ-109** | FUNC | **Idle between frames.** While idle characters are present **and no frame remains in flight in the receiver**, the receiver SHALL hold `tvalid` = 0 and SHALL assert no strobe. A frame still draining through the receiver's pipeline may legitimately produce output words during the first idle cycles. | Drive 1000 idle cycles; assert no output activity of any kind from k cycles after the terminate character onward, where k is the module's pinned latency in cycles (§0.5). |
| **REQ-110** | ERR | **Start without terminate.** A start character appearing before the current frame's terminate character SHALL abort the current frame with `tuser`[0] = 1 and a single `error_start_without_terminate` pulse, and SHALL begin a new frame at that start character. The aborted frame's last delivered octet is the one immediately preceding the new start character (the REQ-106 rule), so a start character in lane 4 leaves lanes 0 to 3 of that word belonging to the aborted frame; no FCS is stripped from it (REQ-103). **Where the new start character leaves the aborted frame zero delivered octets** — a start character arriving while the aborted frame is still inside its own eight preamble octets, the case REQ-102 routes here — no output word is emitted for the aborted frame, there is **no `tlast` word to mark** and the clause above about `tuser`[0] does not apply; the single `error_start_without_terminate` pulse is that frame's only report (§0.7), and the new frame is received normally. Frame conservation counts the aborted frame under its strobe (§0.6). | Inject a frame whose terminate character is replaced by a new start character, in lane 0 and in lane 4; check the first frame's delivered octet count and abort bit, the single strobe, and that the second frame is received intact. Then inject a start character in lane 4 of a word whose lane 0 carried a start character: check that no output word appears for the first frame, that `error_start_without_terminate` pulses exactly once, and that the second frame is received intact. |
| **REQ-111** | PERF | **Constant receive latency.** Measured per octet in octet times (§0.5), the receiver's latency SHALL be a fixed constant pinned in the module spec, independent of frame length and frame content. The lane-0 and lane-4 constants are each pinned and SHALL differ by no more than 8 octet times (one cycle); the difference is the start character's position within its word and is not a defect. | Per-octet latency measurement over the REQ-005 frame set at both start lanes; all values within a start lane equal the pinned constant for that lane. |
| **REQ-112** | INV | **No stall.** The receiver SHALL have no `tready` input and SHALL accept an XGMII word on every cycle unconditionally. | Interface compile check that the `I` record contains no `tready` field, plus the REQ-004 stress as the behavioural half — word loss is the only observable failure mode and the stress bench catches it. |
| **REQ-113** | FUNC | **Ordered sets ignored.** Sequence ordered sets and any control character other than the start character occurring **outside** a frame SHALL be ignored: no output word, no header effect and no strobe. | Drive a local-fault ordered-set sequence for 100 cycles, assert no `tvalid` and no strobe, then send a frame and compare it word for word against the same frame received after idles only. |

---

## 3. XGMII transmit (REQ-201 … REQ-210)

Owning module: `Xgmii_tx_64`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-201** | FUNC | **Preamble and start lane.** The transmitter SHALL emit a start character followed by six 0x55 octets and one 0xD5 SFD octet before the destination address, and in Phase 1 SHALL place the start character in lane 0 only. | Decode the XGMII output of 100 transmitted frames; every start character is in lane 0 and the eight preamble octets are exact. |
| **REQ-202** | FUNC | **FCS generation.** The transmitter SHALL append a four-octet CRC-32 FCS computed over the destination address through the final payload or pad octet, transmitted **least significant octet first** — the ordering for which REQ-304's residue is constant. | Compare the four FCS octets, in wire order, octet for octet against a CRC-32 computed by the DV software reference (REQ-305) — an oracle independent of the design. Feeding the frame back through the receiver and through the REQ-304 residue check is a supplementary check only: both share the design's own `Crc32_eth` engine, so a systematically wrong but self-consistent CRC would pass them. |
| **REQ-203** | FUNC | **Padding.** Frames whose destination-address-through-payload length is below 60 octets SHALL be padded with zero octets to 60 octets before the FCS is appended, producing a 64-octet frame (DA through FCS, §0.3). | Transmit a 20-octet payload frame; the XGMII output carries 60 octets before the FCS with zeros from octet 21 to 60, and 64 octets DA through FCS. |
| **REQ-204** | FUNC | **Inter-frame gap.** Between successive frames the transmitter SHALL emit a gap of at least `cfg_ifg` octets **counted from the terminate character inclusive** (§0.3, default 12) and SHALL round the gap up so the next start character lands in lane 0. Deficit idle count is out of Phase-1 scope, so gaps are only ever rounded up, never shortened. | Transmit back-to-back minimum-length frames; measure the octet distance between successive start characters as exactly 88 octets (11 cycles) at the default gap, and the gap from the terminate character inclusive to the next start character as 16 octets, which satisfies the 12-octet minimum. |
| **REQ-205** | FUNC | **Terminate and fill.** The transmitter SHALL emit the terminate character in the lane immediately after the last FCS octet and SHALL fill all remaining lanes of that word and subsequent gap words with idle characters. | Frame lengths placing the terminate character in each of the eight lanes; check the control-lane encoding of the terminate word and that all subsequent lanes and gap words carry idle. |
| **REQ-206** | ERR | **Underflow.** If, on any cycle after the transmitter has emitted a frame's start character and before it has accepted that frame's `tlast` word, the transmitter asserts `tready`, requires a word, and no word is presented (`tvalid` = 0), the transmitter SHALL emit an error character followed by a terminate character and SHALL pulse `error_underflow` once. The threshold is that single cycle: there is no elastic buffer, and REQ-016's idle tolerance does not extend to this interface. | Stall the source for exactly one required cycle mid-frame; check the error character, the terminate character and the strobe, and that the next frame transmits correctly. |
| **REQ-207** | IFC | **Transmit-side backpressure.** The transmitter SHALL deassert `tready` whenever it cannot accept a word (during preamble, padding, FCS and inter-frame gap) and SHALL NOT drop a word it has accepted. | Drive a continuous source; record the sequence of words for which `tvalid` and `tready` both held; decode the wire and assert the payload octet sequence equals the accepted-word octet sequence exactly once, in order. The first clause describes an internal condition and carries no independent observable. |
| **REQ-208** | INV | **Backpressure containment.** No transmit-side condition SHALL propagate backpressure into the receive datapath. Receive-originated traffic that cannot be transmitted SHALL be discarded and reported by the strobe named in REQ-510, never queued against the receive path. | Hold the transmitter busy with a maximum-length frame while driving the receive path at the REQ-004 rate; check REQ-004 still holds and `error_arp_reply_dropped` fires. Reachability of the drop condition is guaranteed by REQ-510's one-pending-reply rule. |
| **REQ-209** | PERF | **Transmit throughput.** With the default gap the transmitter SHALL accept and transmit minimum-length frames at exactly one frame per 11 cycles, which REQ-204's lane-0-only rounding fixes (§0.3). | Sustained transmit bench of 10 000 minimum-length frames; assert mean cycles per frame equals 11 and that no inter-frame spacing differs from 11. |
| **REQ-210** | PERF | **Constant transmit latency.** Measured per octet in octet times (§0.5), the delay from the first accepted source word to the XGMII word carrying that frame's start character SHALL be a fixed constant pinned in the module spec, measured with the transmitter idle and REQ-204's gap obligation already satisfied. Back-to-back transmission legitimately delays a start character until the gap is served and is out of this requirement's domain. | Latency measurement over several frame lengths, each issued into an idle transmitter after the previous gap has elapsed; all values equal the pinned constant. |

---

## 4. CRC-32 / FCS (REQ-301 … REQ-306)

Owning module: `Crc32_eth`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-301** | FUNC | **Algorithm.** The FCS engine SHALL implement IEEE 802.3 CRC-32: polynomial 0x04C11DB7, initial value 0xFFFFFFFF, input and output reflected, final XOR 0xFFFFFFFF. | Known-answer tests, REQ-303 and REQ-304. |
| **REQ-302** | FUNC | **Parallel update.** The engine SHALL update the running CRC by 1 to 8 octets in a single cycle, selected by a valid-octet count, producing the same result as applying the octets one at a time. | Compare every octet-count variant against an octet-at-a-time software reference over 10 000 random inputs. |
| **REQ-303** | FUNC | **Check value.** The CRC of the nine ASCII octets "123456789" SHALL be **0xCBF43926**. | Directed test. This is the canonical CRC-32/ISO-HDLC check value and the known-answer test that anchors the whole FCS chain; see the provenance note below. |
| **REQ-304** | FUNC | **Residue property.** The CRC computed over a frame concatenated with its own correct FCS, appended least significant octet first (REQ-202), SHALL equal the constant **0x2144DF1C** under REQ-301's parameterisation. | Directed test over frames of several lengths; also used as the receiver's FCS check oracle. See the provenance note below. |
| **REQ-305** | FUNC | **Reference equivalence.** The parallel engine SHALL agree with a bit-serial CRC-32 reference for all octet counts over at least 10 000 randomised frames. | Randomised comparison test; candidate for a `formal_dv` exhaustive proof during Phase-1 hardening. This bit-serial reference is the independent oracle REQ-202 requires. |
| **REQ-306** | IFC | **Stateless function.** The engine SHALL be a pure combinational function of (current CRC, data word, octet count) with no internal state; sequencing belongs to its callers. | Interface compile check plus a mechanical check of the emitted `crc32_eth` module: it has no `clock` port and contains no `always @(posedge …)` block. |

**Provenance of the two constants (REQ-303, REQ-304).** Both were wrong in the
WO-0002 text — 0xCBF43F26 and 0xC704DD7B — and were corrected here under
WO-0004. Each was computed independently twice against Python `zlib`, whose
parameterisation is exactly REQ-301's: once by dv_lead
(`WO-0003_testability-findings.md` §13.5) and once by the orchestrator before
accepting that review (`WO-0003_requirements-testability-review.md`, ACCEPTED
entry). 0xC704DD7B is a real published Ethernet residue, but it is the same
residue expressed in the **non-reflected** register convention —
bitrev32(NOT 0x2144DF1C) = 0xC704DD7B — and REQ-301 specifies the reflected
convention. Every constant in this document is now on one convention, and the
residue is constant only when the FCS is appended least significant octet
first, which is what pins REQ-202's wire order.

---

## 5. Ethernet framing (REQ-401 … REQ-410)

Owning modules: `Eth_axis_rx`, `Eth_axis_tx`, `Eth_demux`, `Eth_arb_mux`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-401** | FUNC | **Header extraction.** The Ethernet receiver SHALL extract destination address, source address and ethertype into a header record whose `valid` field is high for exactly one cycle per frame, on or before the cycle carrying the first payload word of that frame. For a frame of exactly 14 octets there are no payload words: `valid` SHALL assert within the module's pinned latency of the input `tlast`, no payload frame is emitted, and downstream modules tolerate the header without a payload frame (§0.7). | Directed test with a known frame: fields compare equal and `valid` is high for exactly one cycle. Plus a 14-octet frame: header record valid, no payload word, no strobe, and the demux downstream still routes on the ethertype. |
| **REQ-402** | ERR | **Short frames.** A frame carrying fewer than 14 octets SHALL produce no header `valid` and no payload words, and SHALL pulse `error_short_frame` once. | Inject 1-, 8- and 13-octet frames. One octet is the shortest frame presentable on an `Axi64` stream (REQ-011, §0.7); a 0-octet frame has no encoding and is not a test case. |
| **REQ-403** | ERR | **Abort passthrough.** An input frame whose last word carries `tuser`[0] = 1 SHALL produce an output payload frame whose last word carries `tuser`[0] = 1, where an output payload frame is produced at all. A frame discarded under REQ-402, or one whose payload is zero octets under §0.7, produces no output frame and its strobe or header pulse is the only report (§0.6). | Error-injection test on a frame long enough to produce payload words, plus a 13-octet aborted frame asserting no output frame and exactly one `error_short_frame` pulse. |
| **REQ-404** | FUNC | **Ethertype demultiplex.** Ethertype 0x0800 SHALL be routed to the IPv4 port and 0x0806 to the ARP port. Any other ethertype, including 0x8100 (VLAN, unsupported in Phase 1), SHALL be discarded with a single `error_unknown_ethertype` pulse. | Directed frames with ethertypes 0x0800, 0x0806, 0x8100 and 0x86DD; check routing and the strobe. The demux decides from the header record before any payload word, so the discard is clean and needs no abort interaction. |
| **REQ-405** | FUNC | **Header insertion.** The Ethernet transmitter SHALL emit the 14 header octets from the header record followed by the payload stream, preserving payload octet order. | Compare the built frame against a hand-assembled reference frame, octet for octet. |
| **REQ-406** | FUNC | **Frame-atomic arbitration.** The transmit arbiter SHALL never interleave words of frames from different input ports, and a request waiting at one port SHALL be granted no later than one cycle after the `tlast` of the frame in progress. | Two-port bench issuing simultaneous frames with distinguishable payloads; check atomicity and measure grant delay. Which port wins a simultaneous tie is deliberately unconstrained and SHALL NOT be asserted; SPEC-M09 §6.3 records that. |
| **REQ-407** | FUNC | **No Ethernet-layer address filtering.** The Ethernet receive path SHALL NOT filter on destination MAC address; destination filtering is performed at the IPv4 and UDP layers (REQ-604, REQ-704). | Send a frame with a foreign destination MAC and a matching destination IP; it is delivered to the application. |
| **REQ-408** | FUNC | **Payload extent.** The payload stream SHALL carry every octet after the ethertype through the end of the frame, including any Ethernet padding; padding removal belongs to IPv4 (REQ-605). | 64-octet frame (DA through FCS, §0.3) carrying a 20-octet IPv4 datagram: `Xgmii_rx_64` strips the four FCS octets, `Eth_axis_rx` sees 60 octets and strips the 14-octet header, so the Ethernet payload is **46 octets** — 26 of which are Ethernet padding. |
| **REQ-409** | IFC | **Field decoding.** Header record fields SHALL be presented as numeric values per REQ-012, including the 48-bit MAC fields, whose byte order is the case a test writer most often gets wrong. | Covered by REQ-401's known-frame test, which compares a MAC field against the REQ-012 worked example. |
| **REQ-410** | PERF | **Back-to-back frames.** The Ethernet receiver SHALL accept a new frame whose first word arrives on the cycle immediately after the previous frame's `tlast`. | Two frames with zero idle cycles between them; both delivered intact with correct header records. |

---

## 6. ARP (REQ-501 … REQ-512)

Owning modules: `Arp_eth_rx`, `Arp_eth_tx`, `Arp_cache`, `Arp`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-501** | FUNC | **Packet acceptance.** An ARP packet SHALL be accepted only when hardware type is 1, protocol type is 0x0800, hardware length is 6, protocol length is 4, the operation is 1 (request) or 2 (reply), and at least 28 octets follow the ethertype. Any other combination, including an unsupported operation and a truncated packet, SHALL be discarded with a single `error_arp_unsupported` pulse. A discarded packet SHALL NOT be learned from (REQ-503). | Directed packets varying each field in turn, including operations 0, 3 and 4 and a 27-octet packet; check the strobe and that no cache entry appears. |
| **REQ-502** | FUNC | **Request response.** An ARP request (operation 1) whose target protocol address equals the configured local IP SHALL produce an ARP reply (operation 2) whose sender hardware and protocol addresses are the configured local MAC and IP, whose **target hardware address is the request's sender hardware address** and whose **target protocol address is the request's sender protocol address** (RFC 826), unicast to the requester's hardware address, transmitted within 64 cycles when the transmit path is idle. | Inject a request; decode the transmitted frame field by field against all six address fields; measure the response delay from the cycle carrying the request's last XGMII word to the cycle carrying the reply's start character. |
| **REQ-503** | FUNC | **Learning.** The sender protocol address and sender hardware address of every **accepted** ARP packet (REQ-501) SHALL be written into the cache, whether or not the packet is addressed to us. | Inject a request from a new host, then trigger a transmit to that host; no new ARP request is issued and the frame carries the learned MAC. |
| **REQ-504** | FUNC | **Cache organisation.** The cache SHALL hold 16 entries, direct-mapped, indexed by the low four bits of the least significant octet of the IPv4 address; an insert into an occupied slot with a different address SHALL overwrite it. | Insert two addresses colliding in the index; check the first is evicted and the second resolves. |
| **REQ-505** | ERR | **Lookup miss.** On a cache miss for an outgoing datagram the datagram SHALL be discarded without buffering, `error_arp_miss` SHALL pulse once, and an ARP request for the resolution target SHALL be broadcast. The transmit path SHALL continue to accept and discard the remaining payload words of that datagram, so a resolution failure never stalls the application. While a resolution for a given target address is outstanding — request sent, retry count not yet exhausted (REQ-506) — a further miss for that same address SHALL discard and pulse `error_arp_miss` without issuing an additional request. | Transmit to an unknown host; check the discard, the strobe, the broadcast request contents, and that every application word of the datagram is accepted rather than stalled. Then transmit 100 further datagrams to the same host within one retry interval and assert exactly one request appeared on the wire and 100 strobes pulsed. |
| **REQ-506** | FUNC | **Retry and ageing.** Unanswered requests SHALL be retried up to a configured retry count at a configured interval, and entries SHALL expire after a configured lifetime. Defaults: retry count 4 (range 0 to 15); retry interval 156 250 000 cycles, i.e. 1.0 s (range 1 to 2^32 − 1 cycles); entry lifetime 3 125 000 000 cycles, i.e. 20 s (same range). All three SHALL be compile-time parameters so tests can use short values. After the retry count is exhausted the resolution is abandoned and nothing is negatively cached: a later datagram to the same address starts a fresh request sequence. | Parameter-overridden test with a short interval and lifetime: count retries, check the sequence stops at the retry count, check a later datagram starts a fresh sequence, then check the entry expires after the lifetime. |
| **REQ-507** | FUNC | **Destination class precedence and off-subnet routing.** The resolution target for an outgoing datagram SHALL be selected by evaluating these classes in this order: limited broadcast 255.255.255.255 (REQ-508), the configured subnet broadcast address (REQ-508), multicast 224.0.0.0/4 (REQ-509), on-subnet — meaning (destination AND subnet mask) equals (local IP AND subnet mask) — which resolves through the cache, and finally off-subnet, which resolves the **configured gateway address** rather than the destination. | Transmit to one address of each class, including 255.255.255.255 and a multicast address that are both outside the configured subnet, and assert the class each is resolved under; for the off-subnet case assert the ARP request and the resulting frame's destination MAC target the gateway. |
| **REQ-508** | FUNC | **Broadcast destinations.** Destination 255.255.255.255 and the configured subnet broadcast address — the address formed from the local IP by setting every bit not covered by the subnet mask to 1 — SHALL resolve to MAC ff:ff:ff:ff:ff:ff without consulting the cache and without issuing a request. | Transmit to both; check the destination MAC and that no ARP request appears. |
| **REQ-509** | FUNC | **Multicast destinations.** Destinations in 224.0.0.0/4 SHALL resolve to the MAC address formed as 01:00:5E followed by 0 and the low 23 bits of the IPv4 address, without consulting the cache and without issuing a request. | Transmit to 239.1.2.3 and check the destination MAC is 01:00:5E:01:02:03; transmit to 239.129.2.3, whose bit 23 is set, and check it maps to the same MAC, which is what actually exercises the 23-bit mask. |
| **REQ-510** | ERR | **Reply drop over stall.** The ARP module SHALL hold at most one pending reply. An accepted request arriving while a reply is still pending SHALL cause the newly generated reply to be discarded with a single `error_arp_reply_dropped` pulse, and SHALL NOT stall the receive path. This is the only condition under which a reply is dropped, and it is reachable by construction. | Hold the arbiter busy with a maximum-length frame while injecting two back-to-back ARP requests; check exactly one strobe pulse, that the first reply is transmitted once the arbiter frees, and that REQ-004 still holds throughout. |
| **REQ-511** | FUNC | **Gratuitous ARP.** A gratuitous ARP (operation 1 with target protocol address equal to sender protocol address) SHALL update the cache and SHALL produce a reply only if that address equals the configured local IP. | Inject gratuitous ARPs for a foreign address and for the configured local address; check cache update in both cases and a reply only in the second. |
| **REQ-512** | FUNC | **No proxy ARP.** Requests targeting any address other than the configured local IP SHALL NOT be answered. | Inject requests for three foreign addresses; no transmit activity results, though REQ-503 learning still occurs. |

---

## 7. IPv4 (REQ-601 … REQ-612)

Owning modules: `Ip_eth_rx_64`, `Ip_eth_tx_64`, `Ip_complete_64`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-601** | ERR | **Version and header length.** Datagrams whose version is not 4 or whose header length is not 5 words (options present) SHALL be discarded with a single `error_ip_bad_header` pulse. | Inject version 6, header length 6 and header length 4 datagrams. |
| **REQ-602** | ERR | **Header checksum.** The receiver SHALL verify the IPv4 header checksum — the one's-complement sum of the ten header halfwords per RFC 791 §3.1 — and SHALL discard a datagram whose checksum is wrong with a single `error_ip_bad_checksum` pulse. | Inject a datagram with one header bit flipped. This is declared divergence class (a) of REQ-901: the reference design does not verify this checksum, so the REQ is verified against the spec by directed test and co-simulation stimulus is restricted to datagrams with correct header checksums. |
| **REQ-603** | ERR | **Fragments.** Datagrams with the more-fragments flag set or a non-zero fragment offset SHALL be discarded with a single `error_ip_fragment` pulse. | Inject both fragment forms. DF and the reserved bit are deliberately unconstrained. |
| **REQ-604** | FUNC | **Destination filter.** The receiver SHALL accept datagrams whose destination is the configured local IP, the configured subnet broadcast address, 255.255.255.255, or the configured multicast group when multicast is enabled; all others SHALL be discarded with a single `error_ip_not_for_us` pulse. | One test per accepted case and three rejected cases, including the configured multicast group with multicast disabled. |
| **REQ-605** | FUNC | **Length handling.** The receiver SHALL deliver exactly (total length − 20) payload octets, discarding any Ethernet padding beyond that. Where that count is zero (total length 20) no payload frame is emitted and the header record's `valid` pulse is the only report (§0.7). If the frame ends before total length is satisfied, the payload's last word SHALL carry `tuser`[0] = 1 and `error_ip_truncated` SHALL pulse once. | A 64-octet frame carrying a datagram of **total length 28**: the Ethernet payload is 46 octets (REQ-408), so 18 octets of Ethernet padding are removed and 8 payload octets are delivered — a case that actually exercises padding removal. Plus a datagram of total length 20 (header record, no payload frame) and a frame truncated 10 octets early. |
| **REQ-606** | FUNC | **Header record.** The receiver SHALL present source address, destination address, protocol, TTL, DSCP and total length in a header record valid for exactly one cycle, on or before the cycle carrying the first payload word. | Known-datagram test comparing every field and the `valid` timing. |
| **REQ-607** | ERR | **Protocol filter.** Datagrams whose protocol is not 17 (UDP) SHALL be discarded with a single `error_ip_bad_protocol` pulse. ICMP is out of Phase-1 scope. | Inject protocol 1 and protocol 6 datagrams. Where a datagram matches more than one discard condition, §0.6 governs which strobes pulse. |
| **REQ-608** | FUNC | **Header construction.** Transmitted datagrams SHALL carry version 4, header length 5, DSCP and ECN 0, flags 0, fragment offset 0, protocol 17, TTL from configuration (default 64) and an identification field that starts at 0 after clear and increments by 1 per transmitted datagram. | Transmit three datagrams; decode and compare every header field, checking the identification sequence 0, 1, 2. |
| **REQ-609** | FUNC | **Transmit checksum.** The transmitter SHALL compute and insert the IPv4 header checksum. | Verify the transmitted header against an independently computed one's-complement checksum, and by loopback through REQ-602. |
| **REQ-610** | FUNC | **Transmit length.** Total length SHALL be the application's **payload length** (REQ-705) plus 28 — 20 octets of IPv4 header plus the 8-octet UDP header plus the payload — and the UDP length field SHALL be payload length plus 8. The transmitter SHALL NOT buffer the payload to derive either. | Transmit datagrams of several payload lengths; check both fields against the arithmetic above, and check the no-buffering property by the invariance criterion of REQ-705. |
| **REQ-611** | PERF | **Constant parse latency.** The receiver's header-parse latency SHALL be a fixed constant pinned in the module spec, measured from the input word carrying the first octet of the IPv4 header to the cycle on which the header record's `valid` asserts, counted per §0.5 so that REQ-016's permitted idle gaps do not break the constant. | Latency measurement over several payload lengths and both start lanes; all values equal the pinned constant. |
| **REQ-612** | ERR | **Maximum size.** Datagrams with total length above 1500 octets SHALL be discarded with a single `error_ip_oversize` pulse. | Inject a 1501-octet total-length datagram. 1500 is 1518 minus the 14-octet Ethernet header minus the 4 FCS octets (§0.3). |

---

## 8. UDP (REQ-701 … REQ-710)

Owning modules: `Udp_ip_rx_64`, `Udp_ip_tx_64`, `Udp_complete_64`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-701** | FUNC | **Header record.** The receiver SHALL present source port, destination port, length and checksum in a header record valid for exactly one cycle, on or before the cycle carrying the first payload word. | Known-datagram test comparing every field and the `valid` timing. |
| **REQ-702** | FUNC | **Checksum not verified.** The receiver SHALL NOT verify the UDP checksum: a datagram with an incorrect non-zero checksum SHALL be delivered to the application unchanged. Frame integrity is covered by the Ethernet FCS (REQ-104). | Inject a datagram with a deliberately wrong UDP checksum; check it is delivered with no abort bit and no strobe. |
| **REQ-703** | ERR | **Length checks.** A UDP length below 8, or a length exceeding the octets the IPv4 layer delivers, SHALL cause a single `error_udp_bad_length` pulse. Where the module has already emitted a payload word for that datagram the payload frame is aborted with `tuser`[0] = 1 on its last word; where it has not — which is always the case for a length below 8 — no payload frame is emitted and the strobe is the only report (§0.6). Otherwise exactly (length − 8) payload octets SHALL be delivered, and where that count is zero (length exactly 8) no payload frame is emitted and the header record's `valid` pulse is the only report (§0.7). | Inject length 0 and length 7 (no payload frame, one strobe each), length 8 (header record, no payload frame, no strobe), a length one octet longer than the IPv4 layer delivers (abort plus strobe), and three correct lengths. |
| **REQ-704** | FUNC | **Port filter.** Datagrams SHALL be accepted when the destination port equals the configured listen port or when accept-all-ports is enabled; otherwise they SHALL be discarded with a single `error_udp_port` pulse. | Matching port, non-matching port, and non-matching port with accept-all enabled. |
| **REQ-705** | IFC | **Transmit request form.** The application SHALL supply destination address, destination port, source port and **payload length** before the first payload word, where payload length is the number of **UDP payload octets** it will supply, excluding the 8-octet UDP header and every lower-layer header (REQ-610). The transmit path SHALL NOT buffer the payload to derive any header field. The request handshake — how the fields are presented, how long they stay stable and how acceptance is signalled — is defined in SPEC-M18 and SPEC-M20 (§0.1). | Interface compile check, plus the no-buffering test stated as an **invariance**: the number of application words accepted before the first octet of that frame appears on the wire SHALL be the same for every payload length. That is testable at every length, including short ones, and is a strictly stronger detector of a store-and-forward FIFO than an ordering criterion, which a conformant design fails whenever the payload is short. |
| **REQ-706** | FUNC | **Transmit checksum zero.** The transmitted UDP checksum field SHALL be 0x0000, which RFC 768 permits for IPv4. | Decode transmitted datagrams; the field is zero. |
| **REQ-707** | IFC | **Application receive stream.** The application receive stream SHALL carry UDP payload octets only, word-aligned per REQ-021, with `tuser`[0] propagated per REQ-007, and SHALL have no `tready`. A datagram with zero payload octets appears as a UDP header record with no payload frame (§0.7). | Interface compile check for the absence of `tready`, plus an end-to-end payload comparison at the application boundary with `tuser`[0] propagation checked against an injected bad-FCS frame, plus one zero-payload datagram asserting header record and no payload word. |
| **REQ-708** | PERF | **Application-boundary line rate.** The application receive stream SHALL deliver, without loss, the datagrams produced by minimum-length (64-octet) Ethernet frames arriving at the REQ-004 rate: each frame carries an IPv4 datagram of total length 46 and a UDP datagram of length 26, i.e. **18 octets of UDP payload** — the largest UDP payload a minimum-length frame carries with no Ethernet padding, leaving room for REQ-020's four-octet sequence number. | End-to-end line-rate stress at `nic_top` with that exact stimulus and sequence-numbered payloads; 10 000 frames, frame conservation and order preservation checked per §0.6 and REQ-020. |
| **REQ-709** | ERR | **Under-delivery of a declared length.** If the application delivers **fewer** payload octets than it declared (REQ-705) — signalled by `tlast` before the declared count is reached — the transmit path SHALL terminate the frame per REQ-206, emitting an error character followed by a terminate character, and SHALL pulse both `error_underflow` (REQ-206) and `error_tx_length_mismatch` once. | Declare 100 octets and supply 90; check the wire encoding, both strobes, and that the next frame transmits correctly. |
| **REQ-710** | ERR | **Over-delivery of a declared length.** If the application delivers **more** payload octets than it declared, the transmit path SHALL complete the frame normally with exactly the declared octet count — the frame on the wire is well formed, its FCS is valid and its terminate character has already been sent, so REQ-206's remedy cannot apply — SHALL discard the excess words while continuing to accept them so the application is never stalled, and SHALL pulse `error_tx_length_mismatch` once. `error_underflow` SHALL NOT pulse. | Declare 100 octets and supply 110; check the wire frame carries exactly 100 payload octets with a valid FCS, that the ten excess words are accepted and discarded, that `error_tx_length_mismatch` pulses once and `error_underflow` does not, and that the next frame transmits correctly. |

---

## 9. Top level and configuration (REQ-801 … REQ-810)

Owning module: `Nic_top`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-801** | IFC | **Top-level ports.** `Nic_top` SHALL expose exactly: `clock`, `clear`, the four XGMII ports of REQ-017, a configuration record, an application receive stream (`Source` only), an application transmit stream (`Source` and `Dest`) with its request fields, and a status record. | Interface compile check plus the emitted-Verilog port-list check of REQ-017 against SPEC-M20 §4.1. |
| **REQ-802** | IFC | **Configuration record.** Configuration SHALL carry exactly the twelve fields of §9.1, at the widths, reset values and permitted ranges stated there. A value outside a field's permitted range is a configuration error and its behaviour is unspecified; `cfg_ifg` below 12 SHALL NOT be driven. | Interface compile check of the record against §9.1. Each field's observable effect is verified by the REQ named in §9.1's last column, so this row commissions no test it cannot name. |
| **REQ-803** | IFC | **Configuration stability.** Configuration inputs SHALL be treated as static while a frame is in flight. Receive and transmit are evaluated **independently**: a configuration change applies to every frame whose first word is accepted at least one cycle after the change, on each path separately, and never to a frame already in flight on that path. | Change the local IP mid-frame on the receive path and again mid-frame on the transmit path; each in-flight frame completes under the old value and the next frame on that path uses the new one. |
| **REQ-804** | ERR | **Status aggregation.** Every strobe in §12 SHALL appear in the top-level status record, one field per strobe, one cycle high per event. | For each of the twenty-one strobes in §12, drive its condition at the top level and observe exactly that field pulse for exactly one cycle. §12 is the field list. |
| **REQ-805** | INV | **Application must keep up.** The application receive stream SHALL have no `tready`; the consumer is required to accept one word per cycle indefinitely. | Interface compile check. The second sentence is an obligation on the Phase-2 feed handler and has no Phase-1 observable, which is stated rather than pretended away. |
| **REQ-806** | PERF | **End-to-end latency measurement.** The measured latency of REQ-006 SHALL be reported in cycles and in nanoseconds, for each start lane, in the `nic_top` spec freeze record and in the Phase-1 report. | Process check: the numbers produced by the REQ-006 bench appear in both places. dv_lead produces and commits the numbers under `docs/reports/latency/`; the architect transcribes them into the freeze record. |
| **REQ-807** | FUNC | **ARP connectivity.** An ARP request for the configured local IP arriving on XGMII SHALL result in a well-formed ARP reply on XGMII, with correct preamble, every ARP field per REQ-502, valid FCS and a conforming inter-frame gap (§0.3). | System-level test decoding the XGMII output and validating preamble, all six ARP address fields, FCS and gap. |
| **REQ-808** | PROC | **Hierarchy and naming.** Every module named in the architecture.md §4 inventory **whose role is not types-only** SHALL appear as a distinct module in the emitted Verilog, with the name given in the inventory table. M01 `Axi64` is types-only and appears in port records rather than in the instance hierarchy (architecture.md §6.3), so it is excluded. | Compare module names in `rtl_snapshots/` against the inventory table with M01 excluded. |
| **REQ-809** | FUNC | **End-to-end datagram path.** A UDP datagram addressed to the configured local IP and listen port SHALL appear on the application receive stream as its payload octets, and an application transmit request SHALL appear on XGMII as a well-formed Ethernet/IPv4/UDP frame with a valid FCS. | System-level test in both directions with payload comparison. The transmit direction primes the ARP cache first (REQ-503), or REQ-505 discards the datagram. |
| **REQ-810** | FUNC | **Enable controls.** When `receive enable` is 0 the receive path SHALL accept no frame: it emits no output word on any receive-path stream, asserts no header-record `valid` and asserts no strobe — no frame is accepted, so this creates no silent-discard hole under REQ-008. When `transmit enable` is 0 the transmitter SHALL begin no new frame on XGMII: it emits only idle characters and holds `tready` deasserted at the application transmit interface; an ARP reply generated meanwhile is dropped under REQ-510. Both take effect at the next frame boundary on their own path (REQ-803). | Drive `receive enable` = 0 and inject 100 frames: assert no output word, no header `valid` and no strobe anywhere; re-enable and check the next frame is received correctly. Drive `transmit enable` = 0 and issue an application transmit request: assert no start character appears on XGMII and `tready` stays low; re-enable and check the frame transmits. |

### 9.1 Configuration fields (normative, REQ-802)

Reset values are the values the record holds after `clear` when nothing drives
it. The address and port fields reset to 0 and must be configured by the bench
or the platform before the first frame; the behavioural fields have working
defaults.

| Field | Width | Reset value | Permitted range | Behaviour given by |
|---|---|---|---|---|
| local MAC | 48 | 0 | any unicast MAC (bit 0 of the first octet clear) | REQ-502, REQ-503 |
| local IP | 32 | 0 | any unicast IPv4 address | REQ-502, REQ-507, REQ-604 |
| subnet mask | 32 | 0 | a contiguous prefix mask, that is 2^32 minus 2^(32−n) for n in 0 to 32 | REQ-507, REQ-508 |
| gateway IP | 32 | 0 | any unicast IPv4 address on the configured subnet | REQ-507 |
| multicast group | 32 | 0 | 224.0.0.0 to 239.255.255.255 when multicast enable is 1 | REQ-604, REQ-509 |
| multicast enable | 1 | 0 | 0 or 1 | REQ-604 |
| listen port | 16 | 0 | 0 to 65535 | REQ-704 |
| accept-all-ports | 1 | 0 | 0 or 1 | REQ-704 |
| TTL | 8 | 64 | 1 to 255 | REQ-608 |
| inter-frame gap | 8 | 12 | 12 to 255; values below 12 are prohibited (§0.3) | REQ-204, REQ-209 |
| receive enable | 1 | 1 | 0 or 1 | REQ-810 |
| transmit enable | 1 | 1 | 0 or 1 | REQ-810 |

---

## 10. Verification and process (REQ-901 … REQ-906)

These are obligations on the programme, not on the hardware; they exist here so
they are countable and citable at the gates.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-901** | PROC | **Differential co-simulation.** Phase-1 MAC, IPv4 and UDP paths SHALL be differentially co-simulated against alexforencich/verilog-ethernet (MIT) configured with deficit idle count disabled, padding enabled, minimum frame length 64, PTP disabled and transmit checksum generation disabled. The comparison SHALL be **transactional, not cycle-by-cycle**: for the same stimulus the two designs SHALL produce the same ordered sequence of output frames — payload octets, the `tkeep` extent of each word, and `tuser`[0] on each `tlast` — and the same accept-or-discard decision per input frame. Cycle alignment, internal pipelining and latency constants are deliberately not compared: ours are pinned by REQ-005 and REQ-111, the reference's are its own. The comparison boundaries are the module pairs in architecture.md §4's counterpart column; where §5 records a merged wrapper level the comparison is taken at the outer wrapper. Four divergence classes are declared in advance, are expected by design, and are excluded from the comparison rather than reported as failures: (a) IPv4 header checksum verification, which the reference does not perform (REQ-602), so co-simulation stimulus is restricted to datagrams with correct header checksums; (b) the direct-mapped ARP cache versus the reference's LRU (REQ-504), so eviction order is not compared; (c) discard-on-miss versus the reference's queued resolution (REQ-505), so transmit behaviour after a cache miss is not compared; (d) the zero UDP transmit checksum (REQ-706), so that field is not compared. Any divergence outside these four classes is a defect. A divergence class discovered later SHALL be added here by spec diff before any sign-off packet may cite it. | dv_lead co-simulation run cited in the module sign-off packets, reporting per boundary: frames compared, frames matching, and every divergence with the class it falls in or the defect it is. |
| **REQ-902** | PROC | **Deterministic emission.** Regenerating the RTL snapshots from unchanged sources SHALL produce byte-identical files. | The existing `build` workflow determinism step. |
| **REQ-903** | PROC | **Module surface.** Every module in the architecture.md §4 inventory SHALL have an `.mli`. Every such module **whose role is not types-only** SHALL additionally have a `hierarchical` entry point taking a `Scope.t`. M01 `Axi64` is the only types-only module: it instantiates nothing and appears in no instance hierarchy (architecture.md §6.3), so it owes the `.mli` and not the entry point — the same exclusion REQ-808 makes for the emitted-Verilog module list, now stated for this requirement in its own words rather than borrowed from that one. The `.mli` half is **not** waived for M01: that file is what fixes which of M01's records are exported and at what widths, which is the surface every other module's REQ-010 compile check binds to. | Mechanical repository check at each module-ready gate, in two parts: (a) an `.mli` exists for every inventory module, M01 included; (b) `hierarchical` is exported by every inventory module except M01. Part (b)'s exclusion list is one name and is stated here so the check has a determinable answer rather than an argument. |
| **REQ-904** | PROC | **Traceability currency.** Every REQ in this document SHALL have a row in `traceability.md` before its owning module's `P1-module-ready` gate. | A script comparing the REQ id set extracted from this file against the row id set of `traceability.md` and asserting exact set equality, run in CI so currency is continuous rather than checked once per gate. |
| **REQ-905** | PROC | **Per-module stress.** Every module in §0.4's stress-bench list — M03, M06, M08, M10, M14, M17 and M20 — SHALL have its own line-rate stress bench satisfying REQ-004, not only the top level. Structural wrappers M05, M16 and M19 are covered by their children's benches unless the wrapper introduces datapath logic of its own, which puts it on the list by spec diff. | Sign-off packets list the stress test per module against that enumeration, so the gate question has a checkable answer. |
| **REQ-906** | PROC | **Evidence form.** All Phase-1 build and test evidence SHALL cite a CI run identifier and conclusion, per ADR-0005; a local build result is not acceptable evidence. | Auditor sampling of journal Evidence sections. |

---

## 11. Explicit non-requirements (Phase 1)

Recorded so that their absence is a decision, not an omission. Each is
testable in the negative sense stated in the referenced REQ.

| Item | Status | Where recorded |
|---|---|---|
| VLAN tag parsing (0x8100) | Out of scope; such frames are discarded | REQ-404 |
| IPv4 options (header length > 5) | Out of scope; such datagrams are discarded | REQ-601 |
| IPv4 fragmentation and reassembly | Out of scope; fragments discarded | REQ-603 |
| ICMP (including echo reply) | Out of scope; non-UDP protocols discarded | REQ-607 |
| UDP receive checksum verification | Deliberately not performed | REQ-702 |
| UDP transmit checksum generation | Deliberately zero | REQ-706 |
| Deficit idle count on transmit | Out of scope; transmit starts on lane 0 only and rounds gaps up | REQ-204, §0.3 |
| Link fault signalling and ordered-set generation | Out of scope; ordered sets ignored | REQ-113 |
| Jumbo frames | Out of scope; frames above 1518 octets truncated to 1514 delivered octets | REQ-108 |
| Destination MAC filtering | Deliberately promiscuous | REQ-407 |
| PTP timestamping | Out of scope; named in the REQ-018 prohibition list | REQ-018 |
| Proxy ARP | Out of scope | REQ-512 |
| IGMP membership reports | Out of scope; multicast reception is configured statically | REQ-604 |
| PMA, PCS, 64b/66b, serdes | Phase-3 stretch, below the XGMII boundary | REQ-018 |
| Zero-length payload encoding on a stream | Deliberately unrepresentable; encoded as a header record with no payload frame | REQ-011, §0.7 |
| Elastic buffering on the transmit source interface | Out of scope; a missing word is an underflow on the cycle it is required | REQ-206, REQ-016 |

---

## 12. Strobe appendix (normative)

Every strobe named in this document, with the condition it reports, the REQ that
owns it and the module that raises it. This table is the field list of the
top-level status record (REQ-804) and the enumeration REQ-008 quantifies over.
Twenty-one strobes for twenty-one conditions: each condition has a dedicated
name, and no name is shared.

| Strobe | Condition | REQ | Module |
|---|---|---|---|
| `error_bad_fcs` | received FCS does not match the computed CRC-32 | REQ-104 | M03 |
| `error_bad_frame` | error character between start and terminate | REQ-105 | M03 |
| `error_runt` | fewer than 64 octets between start and terminate | REQ-107 | M03 |
| `error_oversize` | more than 1518 octets between start and terminate | REQ-108 | M03 |
| `error_start_without_terminate` | start character before the current frame terminated | REQ-110 | M03 |
| `error_underflow` | source word required and not presented mid-frame | REQ-206 | M04 |
| `error_short_frame` | frame shorter than the 14-octet Ethernet header | REQ-402 | M06 |
| `error_unknown_ethertype` | ethertype neither 0x0800 nor 0x0806 | REQ-404 | M08 |
| `error_arp_unsupported` | ARP field combination, operation or length not accepted | REQ-501 | M10 |
| `error_arp_miss` | outgoing datagram with no cache entry for its resolution target | REQ-505 | M13 |
| `error_arp_reply_dropped` | reply generated while a reply is already pending | REQ-510 | M13 |
| `error_ip_bad_header` | IPv4 version not 4 or header length not 5 | REQ-601 | M14 |
| `error_ip_bad_checksum` | IPv4 header checksum wrong | REQ-602 | M14 |
| `error_ip_fragment` | more-fragments set or non-zero fragment offset | REQ-603 | M14 |
| `error_ip_not_for_us` | IPv4 destination not accepted by the destination filter | REQ-604 | M14 |
| `error_ip_truncated` | frame ended before IPv4 total length was satisfied | REQ-605 | M14 |
| `error_ip_bad_protocol` | IPv4 protocol not 17 | REQ-607 | M14 |
| `error_ip_oversize` | IPv4 total length above 1500 | REQ-612 | M14 |
| `error_udp_bad_length` | UDP length below 8 or beyond the octets delivered | REQ-703 | M17 |
| `error_udp_port` | UDP destination port not accepted by the port filter | REQ-704 | M17 |
| `error_tx_length_mismatch` | application supplied fewer or more octets than declared | REQ-709, REQ-710 | M18 |
