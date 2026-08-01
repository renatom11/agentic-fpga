# Phase-1 Requirements — 10G Ethernet subsystem (XGMII MAC + ARP/IPv4/UDP)

- **Status**: DRAFT — candidate for `P1-spec-freeze`
- **Owner**: architect_docs_lead · **Work order**: WO-0002
- **Countersignature required**: dv_lead (testability, PROTOCOL §7)
- **Companion documents**: [`architecture.md`](architecture.md) (structure),
  [`traceability.md`](traceability.md) (REQ → spec → test),
  [`SPEC-TEMPLATE.md`](SPEC-TEMPLATE.md) (per-module spec form)
- **Decision context**: `docs/adr/ADR-0001` (program scope), `ADR-0004`
  (Hardcaml v0.17.x), `ADR-0005` (CI is the authoritative build environment)

---

## 0. How to read this document

This file is the **sole test-derivation basis** for Phase 1 (PROTOCOL §10):
dv_lead and tb_writer derive tests from REQ text, never from RTL. It is
therefore written to stand alone — a reader who has never seen the design must
be able to build a test from a single row.

**Conventions**

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
  `501–512` ARP · `601–612` IPv4 · `701–709` UDP · `801–809` top level and
  configuration · `901–906` verification and process. Blocks are sparse on
  purpose: new requirements are appended inside their block.
- **Kind** tags: `INV` architectural invariant · `IFC` interface contract ·
  `FUNC` functional behaviour · `ERR` error/exception behaviour ·
  `PERF` timing or throughput · `PROC` process/evidence obligation.
- "Strobe" means a **one-cycle-high output** naming a specific event, per
  REQ-008. Strobe names quoted below (`error_bad_fcs`, …) are normative: the
  per-module spec must use exactly these names.
- Cycle counts are in clock cycles of the single 156.25 MHz clock; one cycle
  is 6.4 ns.

**Fixed numeric facts used throughout.** A 64-bit datapath at 156.25 MHz
carries 8 octets per 6.4 ns = 10.0 Gb/s. On the wire a minimum-length frame
occupies 8 octets of preamble+SFD, 64 octets of frame (DA through FCS) and at
least 12 octets of inter-frame gap = 84 octets = **10.5 cycles**. Because the
XGMII start character may only occupy lane 0 or lane 4, 84 octets is exactly
achievable by alternating lane-0 and lane-4 starts, so a compliant link
partner may deliver minimum-length frames every 10 and 11 cycles alternately.
This is the worst case the receive path must survive (REQ-004).

---

## 1. Program invariants (REQ-001 … REQ-021)

These bind every Phase-1 module. A per-module spec restates the ones that
apply to it (SPEC-TEMPLATE §"REQ coverage") rather than paraphrasing them.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-001** | INV | **Single clock domain.** All Phase-1 RTL SHALL be synchronous to one clock port named `clock`, nominally 156.25 MHz, with no gated clocks, no derived clocks and no clock-domain-crossing structures. | Inspect the emitted Verilog snapshot: exactly one clock signal reaches every sequential element; simulation runs on a single Cyclesim clock. |
| **REQ-002** | INV | **Datapath width.** Every frame-carrying interface SHALL be 64 bits wide and SHALL carry at most one word per cycle. | Interface compile check (`ifc_check`) plus a throughput bench measuring exactly one word accepted per cycle. |
| **REQ-003** | INV | **No receive-path backpressure.** No receive-path stream SHALL carry a `tready` signal, and no receive-path module SHALL be able to stall its producer. A consumer SHALL accept every word presented with `tvalid` = 1. | Interface compile check: receive-path ports expose `Source` records only, with no `Dest` record anywhere on the receive path; plus REQ-004 stress. |
| **REQ-004** | PERF | **Line-rate invariant.** The receive path SHALL sustain minimum-length (64-octet) frames separated by the minimum 12-octet inter-frame gap, with start characters alternating between lane 0 and lane 4 (one frame per 10.5 cycles average), for at least 10 000 consecutive frames, dropping no frame, losing no word and asserting no backpressure. | Line-rate stress bench, mandatory for every receive-path module and again at `nic_top`; pass criterion is frame count out equals frame count in, payload octets compare equal, and no `tready`-like stall exists to observe. |
| **REQ-005** | INV | **Cut-through, not store-and-forward.** No receive-path module SHALL withhold a payload word until the end of its frame. The delay from a word entering a module to that word leaving it SHALL be a constant of the module, independent of frame length and content. | Latency bench: measure word-in to word-out delay for frames of 64, 65, 71, 72, 73, 1500 octets and for both start lanes; all measurements equal. |
| **REQ-006** | PERF | **Receive latency budget.** The delay from the XGMII word containing the start character to the first UDP payload word at the application boundary SHALL be at most 24 cycles (153.6 ns). | Cycle-tagged end-to-end bench at `nic_top`; the measured value is reported in the module spec freeze record and in the Phase-1 latency report. |
| **REQ-007** | INV | **Abort propagation.** When a frame is found invalid after forwarding has begun, its final word SHALL be marked `tuser`[0] = 1, and every downstream module SHALL mark the corresponding final word of its own output stream `tuser`[0] = 1. | Error injection at each stage (bad FCS, mid-frame error character, truncation); check the abort bit appears on the last word of every downstream stream. |
| **REQ-008** | ERR | **Every discard is observable.** Every condition under which a module discards or truncates a frame SHALL be reported by a dedicated one-cycle-high output strobe named for that condition. Discarding silently is prohibited. | For each named strobe in this document, a directed test drives the condition and checks that strobe asserts for exactly one cycle and no other strobe asserts. |
| **REQ-009** | INV | **Reset behaviour.** All state SHALL be held in registers with a synchronous `clear`. Within one cycle of `clear` deasserting, every `tvalid` output SHALL be 0, every strobe SHALL be 0 and the module SHALL accept a new frame. | Reset test: assert `clear` mid-frame, deassert, immediately drive a valid frame, check it is received correctly and no partial frame is emitted. |
| **REQ-010** | IFC | **Typed stream fabric.** All frame-carrying ports SHALL use the program stream types `Axi64.Source` and `Axi64.Dest` (`Hardcaml_axi.Stream.Make` with `data_bits` = 64, `user_bits` = 1). Ad-hoc per-module stream records are prohibited. | Interface compile check of every module spec's `I`/`O` records against the pinned toolchain. |
| **REQ-011** | IFC | **tkeep semantics.** `tkeep` SHALL be contiguous from bit 0. On every word except the one carrying `tlast`, `tkeep` SHALL be `0xFF`. On the `tlast` word `tkeep` SHALL be 1 to 8 contiguous ones. `tkeep` = 0 with `tvalid` = 1 SHALL never be produced. | Protocol monitor asserted on every stream in every bench; directed tests for frame lengths of each length modulo 8. |
| **REQ-012** | IFC | **Byte and field order.** The first octet received from the wire SHALL appear in `tdata`[7:0] and the eighth in `tdata`[63:56]. Multi-octet protocol fields SHALL be presented in header records as numeric values with network byte order already decoded (ethertype 0x0800 reads as the value 0x0800). | Directed test with a known captured frame: compare every extracted header field against hand-computed values. |
| **REQ-013** | IFC | **tuser semantics.** `tuser`[0] SHALL mean "this frame is invalid, discard it", SHALL be meaningful only on the word carrying `tlast`, and SHALL be ignored by consumers on all other words. | Monitor plus a test driving `tuser` = 1 on a non-last word and checking the frame is still delivered intact. |
| **REQ-014** | IFC | **tstrb unused.** Every producer SHALL drive `tstrb` to 0 and every consumer SHALL ignore it. | Monitor on every stream; a test driving non-zero `tstrb` into a consumer changes nothing observable. |
| **REQ-015** | IFC | **One frame at a time.** A stream SHALL carry the words of exactly one frame between successive `tlast` words; frames SHALL NOT interleave on a stream. | Protocol monitor. |
| **REQ-016** | IFC | **Idle words permitted.** A producer MAY deassert `tvalid` between words of a frame; every consumer SHALL tolerate arbitrary idle gaps within a frame without corrupting it. | Bench that injects 0, 1 and 7 idle cycles between every pair of words of a frame at each module boundary. |
| **REQ-017** | INV | **XGMII closure.** The only wire-side ports of the Phase-1 top level SHALL be `xgmii_rxd`[63:0], `xgmii_rxc`[7:0], `xgmii_txd`[63:0] and `xgmii_txc`[7:0]; all other top-level ports SHALL be clock, clear, configuration, application streams and status. | Port-list check against the emitted `nic_top` Verilog module in `rtl_snapshots/`. |
| **REQ-018** | INV | **XGMII boundary is simulation-only.** Phase-1 RTL SHALL contain no PMA, serdes, PCS, 64b/66b, scrambler, auto-negotiation or link-training logic, no vendor-specific primitive and no device constraint file. The link partner SHALL be a simulation model owned by DV under `test/`. | Emitted-Verilog inspection for vendor primitive names; repository inspection at the freeze SHA showing no constraint files; the XGMII driver lives under `test/`. |
| **REQ-019** | INV | **No deep receive buffering.** No receive-path module SHALL contain payload storage deeper than two datapath words. Header fields captured into registers are not payload storage; the ARP cache is not on the payload path. | Structural review at spec freeze plus REQ-005 constant-latency evidence (a deeper buffer shows up as variable or excessive latency). |
| **REQ-020** | FUNC | **Order preservation.** Frames SHALL be delivered to the application in the order their start characters arrived, with no duplication and no reordering. | Stress run with a sequence number in each payload; check the received sequence is 0, 1, 2, … with no gaps or repeats. |
| **REQ-021** | IFC | **Producer-side word alignment.** Every stream SHALL be word-aligned at its producer: the first octet of the payload a module emits SHALL occupy `tdata`[7:0] of that stream's first word. A module that strips a header whose length is not a multiple of 8 octets SHALL realign the remaining payload. | Directed tests at every stripping stage (Ethernet strips 14, IPv4 strips 20, UDP strips 8 octets) covering payload lengths of every residue modulo 8. |

---

## 2. XGMII receive (REQ-101 … REQ-113)

Owning module: `Xgmii_rx_64`. XGMII control characters referenced here:
`/I/` idle = 0x07, `/S/` start = 0xFB, `/T/` terminate = 0xFD, `/E/` error =
0xFE, `/Q/` sequence ordered set = 0x9C. A lane is "control" when the
corresponding `xgmii_rxc` bit is 1.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-101** | FUNC | **Start lanes.** The receiver SHALL detect a start character in lane 0 or lane 4 and SHALL produce identical output streams for the same frame received at either alignment. | Send the same frame with a lane-0 start and with a lane-4 start; compare output words, `tkeep` and `tlast` for equality. |
| **REQ-102** | FUNC | **Preamble handling.** The receiver SHALL treat the start character and the following seven octets as preamble and SFD and SHALL strip them. It SHALL NOT validate their contents. | Drive a frame whose six preamble filler octets and SFD octet are arbitrary values; the frame is still delivered unchanged. |
| **REQ-103** | FUNC | **Frame extraction.** The output stream SHALL begin with the first destination-address octet and SHALL end with the last octet before the four FCS octets; the FCS SHALL be stripped and SHALL NOT appear in the output. `tkeep` on the `tlast` word SHALL mark exactly the valid octets. | Directed tests at lengths 64, 65, 71, 72, 73 and 1518 octets: compare the delivered octet string against the injected frame minus its FCS. |
| **REQ-104** | ERR | **FCS check.** The receiver SHALL compute the CRC-32 FCS over the destination address through the last payload octet and compare it against the received FCS. On mismatch it SHALL set `tuser`[0] = 1 on the `tlast` word and pulse `error_bad_fcs`. The frame SHALL still be forwarded (cut-through, REQ-005). | Inject a frame with one payload bit flipped: the same octet count is delivered, `tuser`[0] = 1 on the last word, `error_bad_fcs` pulses once. |
| **REQ-105** | ERR | **Error character inside a frame.** An `/E/` control character between the start character and the terminate character SHALL cause `tuser`[0] = 1 on the `tlast` word, a single `error_bad_frame` pulse, and termination of the output frame at the word containing the error. | Inject `/E/` at lane 0 and at lane 7 of a mid-frame word; check output truncation, abort bit and strobe. |
| **REQ-106** | FUNC | **Terminate in any lane.** The receiver SHALL accept the terminate character in any lane 0 through 7. The frame's last octet is the one immediately preceding the terminate character; a terminate in lane 0 means the previous word carried the last octet. | Frame lengths chosen so the terminate character lands in each of the eight lanes; check `tkeep` and `tlast` placement in all eight cases. |
| **REQ-107** | ERR | **Runt frames.** A frame carrying fewer than 64 octets between the start and terminate characters SHALL be forwarded with `tuser`[0] = 1 on the `tlast` word and a single `error_runt` pulse. | Inject 16-, 60- and 63-octet frames with valid FCS; check the abort bit and the strobe. |
| **REQ-108** | ERR | **Oversize frames.** A frame exceeding 1518 octets (destination address through FCS) SHALL be truncated at 1518 octets, marked `tuser`[0] = 1 on its `tlast` word, and reported by a single `error_oversize` pulse; the receiver SHALL resynchronise on the next start character. | Inject a 1600-octet frame followed immediately by a valid frame; check truncation, strobe, and correct reception of the following frame. |
| **REQ-109** | FUNC | **Idle between frames.** While idle characters are present the receiver SHALL hold `tvalid` = 0 and SHALL assert no strobe. | Drive 1000 idle cycles; assert no output activity of any kind. |
| **REQ-110** | ERR | **Start without terminate.** A start character appearing before the current frame's terminate character SHALL abort the current frame with `tuser`[0] = 1 and a single `error_bad_frame` pulse, and SHALL begin a new frame at that start character. | Inject a frame whose terminate character is replaced by a new start character; check the first frame aborts and the second is received intact. |
| **REQ-111** | PERF | **Constant receive latency.** The delay from an XGMII word entering the receiver to the corresponding output word SHALL be a fixed constant, pinned in the module spec, independent of frame length, frame content and start lane. | Latency measurement over the REQ-005 frame set at both start lanes; all values equal the pinned constant. |
| **REQ-112** | INV | **No stall.** The receiver SHALL have no `tready` input and SHALL accept an XGMII word on every cycle unconditionally. | Interface compile check plus REQ-004 stress. |
| **REQ-113** | FUNC | **Ordered sets ignored.** Sequence ordered sets and any control character other than the start character occurring outside a frame SHALL be ignored: no output, no strobe, no state change. | Drive a local-fault ordered set sequence for 100 cycles followed by a valid frame; check silence, then correct reception. |

---

## 3. XGMII transmit (REQ-201 … REQ-210)

Owning module: `Xgmii_tx_64`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-201** | FUNC | **Preamble and start lane.** The transmitter SHALL emit a start character followed by six 0x55 octets and one 0xD5 SFD octet before the destination address, and in Phase 1 SHALL place the start character in lane 0 only. | Decode the XGMII output of 100 transmitted frames; every start character is in lane 0 and the eight preamble octets are exact. |
| **REQ-202** | FUNC | **FCS generation.** The transmitter SHALL append a four-octet CRC-32 FCS computed over the destination address through the final payload or pad octet. | Feed the transmitted frame into the REQ-304 residue check and into the receiver; the FCS validates. |
| **REQ-203** | FUNC | **Padding.** Frames whose destination-address-through-payload length is below 60 octets SHALL be padded with zero octets to 60 octets before the FCS is appended, producing a 64-octet frame. | Transmit a 20-octet frame; the XGMII output carries 60 octets plus FCS, with zeros in the pad region. |
| **REQ-204** | FUNC | **Inter-frame gap.** Between the terminate character of one frame and the start character of the next, the transmitter SHALL emit at least `cfg_ifg` idle octets (default 12) and SHALL round the gap up so the next start character lands in lane 0. Deficit idle count is out of Phase-1 scope. | Transmit back-to-back minimum frames; measure the octet distance between successive start characters is exactly 88 octets (11 cycles) at the default gap. |
| **REQ-205** | FUNC | **Terminate and fill.** The transmitter SHALL emit the terminate character in the lane immediately after the last FCS octet and SHALL fill all remaining lanes of that word and subsequent gap words with idle characters. | Frame lengths placing the terminate character in each of the eight lanes; check control-lane encoding in every case. |
| **REQ-206** | ERR | **Underflow.** If the source stream stops mid-frame the transmitter SHALL emit an error character followed by a terminate character and SHALL pulse `error_underflow` once. | Stall the source mid-frame; check the error character, the terminate character and the strobe, and that the next frame transmits correctly. |
| **REQ-207** | IFC | **Transmit-side backpressure.** The transmitter SHALL deassert `tready` whenever it cannot accept a word (during preamble, padding, FCS and inter-frame gap) and SHALL NOT drop a word it has accepted. | Drive a continuous source and check every accepted word appears on the wire exactly once, in order. |
| **REQ-208** | INV | **Backpressure containment.** No transmit-side condition SHALL propagate backpressure into the receive datapath. Receive-originated traffic that cannot be transmitted SHALL be discarded and counted (REQ-510), never queued against the receive path. | Hold the transmitter busy for a long burst while driving the receive path at line rate; check REQ-004 still holds and the drop strobe fires. |
| **REQ-209** | PERF | **Transmit throughput.** With the default gap the transmitter SHALL accept and transmit minimum-length frames at a rate of at least one frame per 11 cycles. | Sustained transmit bench of 10 000 minimum frames; measure cycles per frame. |
| **REQ-210** | PERF | **Constant transmit latency.** The delay from the first accepted source word to the XGMII word carrying the start character SHALL be a fixed constant pinned in the module spec. | Latency measurement over several frame lengths; all values equal. |

---

## 4. CRC-32 / FCS (REQ-301 … REQ-306)

Owning module: `Crc32_eth`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-301** | FUNC | **Algorithm.** The FCS engine SHALL implement IEEE 802.3 CRC-32: polynomial 0x04C11DB7, initial value 0xFFFFFFFF, input and output reflected, final XOR 0xFFFFFFFF. | Known-answer tests, REQ-303 and REQ-304. |
| **REQ-302** | FUNC | **Parallel update.** The engine SHALL update the running CRC by 1 to 8 octets in a single cycle, selected by a valid-octet count, producing the same result as applying the octets one at a time. | Compare every octet-count variant against an octet-at-a-time software reference over 10 000 random inputs. |
| **REQ-303** | FUNC | **Check value.** The CRC of the nine ASCII octets "123456789" SHALL be 0xCBF43F26. | Directed test. |
| **REQ-304** | FUNC | **Residue property.** The CRC computed over a frame concatenated with its own correct FCS SHALL equal the constant 0xC704DD7B. | Directed test over frames of several lengths; also used as the receiver's FCS check oracle. |
| **REQ-305** | FUNC | **Reference equivalence.** The parallel engine SHALL agree with a bit-serial CRC-32 reference for all octet counts over at least 10 000 randomised frames. | Randomised comparison test; candidate for a `formal_dv` exhaustive proof during Phase-1 hardening. |
| **REQ-306** | IFC | **Stateless function.** The engine SHALL be a pure combinational function of (current CRC, data word, octet count) with no internal state; sequencing belongs to its callers. | Interface compile check plus inspection: no register in the emitted module. |

---

## 5. Ethernet framing (REQ-401 … REQ-410)

Owning modules: `Eth_axis_rx`, `Eth_axis_tx`, `Eth_demux`, `Eth_arb_mux`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-401** | FUNC | **Header extraction.** The Ethernet receiver SHALL extract destination address, source address and ethertype into a header record whose `valid` field is high for exactly one cycle per frame, no later than the first payload word of that frame. | Directed test with a known frame: fields compare equal and `valid` is high for exactly one cycle. |
| **REQ-402** | ERR | **Short frames.** A frame carrying fewer than 14 octets SHALL produce no header `valid` and no payload words, and SHALL pulse `error_short_frame` once. | Inject 0-, 8- and 13-octet frames. |
| **REQ-403** | ERR | **Abort passthrough.** An input frame whose last word carries `tuser`[0] = 1 SHALL produce an output payload frame whose last word carries `tuser`[0] = 1. | Error-injection test. |
| **REQ-404** | FUNC | **Ethertype demultiplex.** Ethertype 0x0800 SHALL be routed to the IPv4 port and 0x0806 to the ARP port. Any other ethertype, including 0x8100 (VLAN, unsupported in Phase 1), SHALL be discarded with a single `error_unknown_ethertype` pulse. | Directed frames with ethertypes 0x0800, 0x0806, 0x8100 and 0x86DD; check routing and the strobe. |
| **REQ-405** | FUNC | **Header insertion.** The Ethernet transmitter SHALL emit the 14 header octets from the header record followed by the payload stream, preserving payload octet order. | Compare the built frame against a hand-assembled reference frame. |
| **REQ-406** | FUNC | **Frame-atomic arbitration.** The transmit arbiter SHALL never interleave words of frames from different input ports, and a request waiting at one port SHALL be granted no later than one cycle after the `tlast` of the frame in progress. | Two-port bench issuing simultaneous frames; check atomicity and measure grant delay. |
| **REQ-407** | FUNC | **No Ethernet-layer address filtering.** The Ethernet receive path SHALL NOT filter on destination MAC address; destination filtering is performed at the IPv4 and UDP layers (REQ-604, REQ-704). | Send a frame with a foreign destination MAC and a matching destination IP; it is delivered. |
| **REQ-408** | FUNC | **Payload extent.** The payload stream SHALL carry every octet after the ethertype through the end of the frame, including any Ethernet padding; padding removal belongs to IPv4 (REQ-605). | 64-octet frame carrying a 20-octet IPv4 datagram: the Ethernet payload is 50 octets. |
| **REQ-409** | IFC | **Field decoding.** Header record fields SHALL be presented as numeric values per REQ-012. | Covered by REQ-401's known-frame test. |
| **REQ-410** | PERF | **Back-to-back frames.** The Ethernet receiver SHALL accept a new frame whose first word arrives on the cycle immediately after the previous frame's `tlast`. | Two frames with zero idle cycles between them; both delivered intact. |

---

## 6. ARP (REQ-501 … REQ-512)

Owning modules: `Arp_eth_rx`, `Arp_eth_tx`, `Arp_cache`, `Arp`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-501** | FUNC | **Packet acceptance.** ARP packets SHALL be accepted only with hardware type 1, protocol type 0x0800, hardware length 6 and protocol length 4; any other combination SHALL be discarded with a single `error_arp_unsupported` pulse. | Directed packets varying each field. |
| **REQ-502** | FUNC | **Request response.** An ARP request (operation 1) whose target protocol address equals the configured local IP SHALL produce an ARP reply (operation 2) with the configured local MAC and IP as sender fields, unicast to the requester's hardware address, transmitted within 64 cycles of the request's last word when the transmit path is idle. | Inject a request; decode the transmitted frame field by field; measure the response delay. |
| **REQ-503** | FUNC | **Learning.** The sender protocol address and sender hardware address of every accepted ARP packet SHALL be written into the cache. | Inject a request from a new host, then trigger a transmit to that host; no new ARP request is issued and the frame carries the learned MAC. |
| **REQ-504** | FUNC | **Cache organisation.** The cache SHALL hold 16 entries, direct-mapped, indexed by the low four bits of the least significant octet of the IPv4 address; an insert into an occupied slot with a different address SHALL overwrite it. | Insert two addresses colliding in the index; check the first is evicted and the second resolves. |
| **REQ-505** | ERR | **Lookup miss.** On a cache miss for an outgoing datagram the datagram SHALL be discarded without buffering, `error_arp_miss` SHALL pulse once, and an ARP request for the target address SHALL be broadcast. | Transmit to an unknown host; check the discard, the strobe and the broadcast request contents. |
| **REQ-506** | FUNC | **Retry and ageing.** Unanswered requests SHALL be retried up to a configured retry count at a configured interval, and entries SHALL expire after a configured lifetime. All three values SHALL be compile-time parameters so tests can use short values. | Parameter-overridden test with short interval and lifetime: count retries, then check the entry expires. |
| **REQ-507** | FUNC | **Off-subnet routing.** When the destination address is outside the configured subnet the resolution target SHALL be the configured gateway address, not the destination. | Transmit to an off-subnet address; the ARP request and the resulting frame's destination MAC target the gateway. |
| **REQ-508** | FUNC | **Broadcast destinations.** Destination 255.255.255.255 and the configured subnet broadcast address SHALL resolve to MAC ff:ff:ff:ff:ff:ff without consulting the cache and without issuing a request. | Transmit to both; check the destination MAC and that no ARP request appears. |
| **REQ-509** | FUNC | **Multicast destinations.** Destinations in 224.0.0.0/4 SHALL resolve to the MAC address formed as 01:00:5E followed by 0 and the low 23 bits of the IPv4 address, without consulting the cache and without issuing a request. | Transmit to 239.1.2.3; check the destination MAC is 01:00:5E:01:02:03. |
| **REQ-510** | ERR | **Reply drop over stall.** An ARP reply that cannot be handed to the transmit arbiter SHALL be discarded with a single `error_arp_reply_dropped` pulse and SHALL NOT stall the receive path. | Hold the arbiter busy with a long frame while injecting an ARP request; check the strobe and that REQ-004 still holds. |
| **REQ-511** | FUNC | **Gratuitous ARP.** A gratuitous ARP (operation 1 with target protocol address equal to sender protocol address) SHALL update the cache and SHALL produce a reply only if that address equals the configured local IP. | Inject gratuitous ARPs for a foreign address and for the local address; check cache update and reply/no-reply. |
| **REQ-512** | FUNC | **No proxy ARP.** Requests targeting any address other than the configured local IP SHALL NOT be answered. | Inject requests for three foreign addresses; no transmit activity results. |

---

## 7. IPv4 (REQ-601 … REQ-612)

Owning modules: `Ip_eth_rx_64`, `Ip_eth_tx_64`, `Ip_complete_64`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-601** | ERR | **Version and header length.** Datagrams whose version is not 4 or whose header length is not 5 words (options present) SHALL be discarded with a single `error_ip_bad_header` pulse. | Inject version 6, header length 6 and header length 4 datagrams. |
| **REQ-602** | ERR | **Header checksum.** The receiver SHALL verify the IPv4 header checksum and SHALL discard a datagram whose checksum is wrong with a single `error_ip_bad_checksum` pulse. | Inject a datagram with one header bit flipped. Note for co-simulation: the reference design does not verify this checksum, so this REQ is verified against the spec by directed test, and co-simulation stimulus is restricted to datagrams with correct header checksums. |
| **REQ-603** | ERR | **Fragments.** Datagrams with the more-fragments flag set or a non-zero fragment offset SHALL be discarded with a single `error_ip_fragment` pulse. | Inject both fragment forms. |
| **REQ-604** | FUNC | **Destination filter.** The receiver SHALL accept datagrams whose destination is the configured local IP, the configured subnet broadcast address, 255.255.255.255, or the configured multicast group when multicast is enabled; all others SHALL be discarded with a single `error_ip_not_for_us` pulse. | One test per accepted case and three rejected cases. |
| **REQ-605** | FUNC | **Length handling.** The receiver SHALL deliver exactly (total length − 20) payload octets, discarding any Ethernet padding beyond that. If the frame ends before total length is satisfied, the payload's last word SHALL carry `tuser`[0] = 1 and `error_ip_truncated` SHALL pulse once. | 64-octet frame carrying a 46-octet datagram (padding present) and a frame truncated 10 octets early. |
| **REQ-606** | FUNC | **Header record.** The receiver SHALL present source address, destination address, protocol, TTL, DSCP and total length in a header record valid for exactly one cycle, no later than the first payload word. | Known-datagram test comparing every field. |
| **REQ-607** | ERR | **Protocol filter.** Datagrams whose protocol is not 17 (UDP) SHALL be discarded with a single `error_ip_bad_protocol` pulse. ICMP is out of Phase-1 scope. | Inject protocol 1 and protocol 6 datagrams. |
| **REQ-608** | FUNC | **Header construction.** Transmitted datagrams SHALL carry version 4, header length 5, DSCP and ECN 0, flags 0, fragment offset 0, protocol 17, TTL from configuration (default 64) and an identification field that starts at 0 after clear and increments by 1 per transmitted datagram. | Transmit three datagrams; decode and compare every header field, checking the identification sequence 0, 1, 2. |
| **REQ-609** | FUNC | **Transmit checksum.** The transmitter SHALL compute and insert the IPv4 header checksum. | Verify the transmitted header with an independent checksum computation and by loopback through REQ-602. |
| **REQ-610** | FUNC | **Transmit length.** Total length SHALL be 20 plus the UDP length supplied by the application; the transmitter SHALL NOT buffer the payload to derive it. | Transmit datagrams of several payload lengths; check the field and that the first wire octet appears within the module's constant latency. |
| **REQ-611** | PERF | **Constant parse latency.** The receiver's header-parse latency SHALL be a fixed constant pinned in the module spec. | Latency measurement over several payload lengths. |
| **REQ-612** | ERR | **Maximum size.** Datagrams with total length above 1500 octets SHALL be discarded with a single `error_ip_oversize` pulse. | Inject a 1501-octet total-length datagram. |

---

## 8. UDP (REQ-701 … REQ-709)

Owning modules: `Udp_ip_rx_64`, `Udp_ip_tx_64`, `Udp_complete_64`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-701** | FUNC | **Header record.** The receiver SHALL present source port, destination port, length and checksum in a header record valid for exactly one cycle, no later than the first payload word. | Known-datagram test. |
| **REQ-702** | FUNC | **Checksum not verified.** The receiver SHALL NOT verify the UDP checksum: a datagram with an incorrect non-zero checksum SHALL be delivered to the application unchanged. Frame integrity is covered by the Ethernet FCS (REQ-104). | Inject a datagram with a deliberately wrong UDP checksum; check it is delivered with no abort bit and no strobe. |
| **REQ-703** | ERR | **Length checks.** A UDP length below 8, or a length exceeding the octets the IPv4 layer delivers, SHALL abort the payload frame with `tuser`[0] = 1 on its last word and a single `error_udp_bad_length` pulse. Otherwise exactly (length − 8) payload octets SHALL be delivered. | Inject length 0, length 7, length one octet too long, and three correct lengths. |
| **REQ-704** | FUNC | **Port filter.** Datagrams SHALL be accepted when the destination port equals the configured listen port or when accept-all-ports is enabled; otherwise they SHALL be discarded with a single `error_udp_port` pulse. | Matching port, non-matching port, and non-matching port with accept-all enabled. |
| **REQ-705** | IFC | **Transmit request form.** The application SHALL supply destination address, destination port, source port and payload length before the first payload word; the transmit path SHALL NOT buffer the payload to derive any header field. | Interface compile check plus a test measuring the first wire octet appears before the last application word is accepted. |
| **REQ-706** | FUNC | **Transmit checksum zero.** The transmitted UDP checksum field SHALL be 0x0000, which RFC 768 permits for IPv4. | Decode transmitted datagrams; the field is zero. |
| **REQ-707** | IFC | **Application receive stream.** The application receive stream SHALL carry UDP payload octets only, word-aligned per REQ-021, with `tuser`[0] propagated per REQ-007, and SHALL have no `tready`. | Interface compile check plus an end-to-end payload comparison. |
| **REQ-708** | PERF | **Application-boundary line rate.** The application receive stream SHALL deliver minimum-size UDP datagrams arriving at the REQ-004 rate without loss. | End-to-end line-rate stress at `nic_top` with sequence-numbered payloads. |
| **REQ-709** | ERR | **Declared-length mismatch.** If the application delivers fewer or more payload octets than it declared, the transmit path SHALL terminate the frame per REQ-206 and pulse `error_tx_length_mismatch` once. | Declare 100 octets and supply 90, then declare 100 and supply 110. |

---

## 9. Top level and configuration (REQ-801 … REQ-809)

Owning module: `Nic_top`.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-801** | IFC | **Top-level ports.** `Nic_top` SHALL expose exactly: `clock`, `clear`, the four XGMII ports of REQ-017, a configuration record, an application receive stream (`Source` only), an application transmit stream (`Source` and `Dest`) with its request fields, and a status record. | Interface compile check plus the emitted-Verilog port-list check of REQ-017. |
| **REQ-802** | IFC | **Configuration record.** Configuration SHALL carry: local MAC (48), local IP (32), subnet mask (32), gateway IP (32), multicast group (32), multicast enable (1), listen port (16), accept-all-ports (1), TTL (8), inter-frame gap (8), receive enable (1) and transmit enable (1). | Interface compile check; one directed test per field showing an observable effect. |
| **REQ-803** | IFC | **Configuration stability.** Configuration inputs SHALL be treated as static while a frame is in flight; a change SHALL take effect no later than the next frame boundary and SHALL never corrupt a frame in progress. | Change local IP mid-frame; the in-flight frame completes under the old value and the next frame uses the new one. |
| **REQ-804** | ERR | **Status aggregation.** Every strobe named in this document SHALL appear in the top-level status record, one field per strobe, one cycle high per event. | For each strobe, drive its condition at the top level and observe exactly that field pulse. |
| **REQ-805** | INV | **Application must keep up.** The application receive stream SHALL have no `tready`; the consumer is required to accept one word per cycle indefinitely. | Interface compile check; stated as an obligation on the Phase-2 feed handler. |
| **REQ-806** | PERF | **End-to-end latency measurement.** The measured latency of REQ-006 SHALL be reported in cycles and in nanoseconds in the `nic_top` spec freeze record and in the Phase-1 report. | Cycle-tagged bench; number recorded in the freeze record. |
| **REQ-807** | FUNC | **ARP connectivity.** An ARP request for the configured local IP arriving on XGMII SHALL result in a well-formed ARP reply on XGMII, with correct preamble, FCS and inter-frame gap. | System-level test decoding the XGMII output and validating the FCS. |
| **REQ-808** | PROC | **Hierarchy and naming.** Every module named in the architecture inventory SHALL appear as a distinct module in the emitted Verilog, with the name given in the inventory table. | Compare module names in `rtl_snapshots/` against the inventory table. |
| **REQ-809** | FUNC | **End-to-end datagram path.** A UDP datagram addressed to the configured local IP and listen port SHALL appear on the application receive stream as its payload octets, and an application transmit request SHALL appear on XGMII as a well-formed Ethernet/IPv4/UDP frame with a valid FCS. | System-level test in both directions with payload comparison. |

---

## 10. Verification and process (REQ-901 … REQ-906)

These are obligations on the programme, not on the hardware; they exist here so
they are countable and citable at the gates.

| REQ | Kind | Requirement | Verification |
|---|---|---|---|
| **REQ-901** | PROC | **Differential co-simulation.** Phase-1 MAC, IPv4 and UDP paths SHALL be differentially co-simulated against alexforencich/verilog-ethernet (MIT) configured with deficit idle count disabled, padding enabled, minimum frame length 64, PTP disabled and transmit checksum generation disabled. Divergence classes arising from deliberate specification differences (REQ-602) SHALL be declared in the sign-off packet. | dv_lead co-simulation run cited in the module sign-off packets. |
| **REQ-902** | PROC | **Deterministic emission.** Regenerating the RTL snapshots from unchanged sources SHALL produce byte-identical files. | The existing `build` workflow determinism step. |
| **REQ-903** | PROC | **Module surface.** Every module in the inventory SHALL have an `.mli` and a `hierarchical` entry point taking a `Scope.t`. | Repository inspection at each module-ready gate. |
| **REQ-904** | PROC | **Traceability currency.** Every REQ in this document SHALL have a row in `traceability.md` before its owning module's `P1-module-ready` gate. | Row count and id set compared against this document. |
| **REQ-905** | PROC | **Per-module stress.** Every receive-path module SHALL have its own line-rate stress bench satisfying REQ-004, not only the top level. | Sign-off packets list the stress test per module. |
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
| Deficit idle count on transmit | Out of scope; transmit starts on lane 0 only | REQ-204 |
| Link fault signalling and ordered-set generation | Out of scope; ordered sets ignored | REQ-113 |
| Jumbo frames | Out of scope; frames above 1518 octets truncated | REQ-108 |
| Destination MAC filtering | Deliberately promiscuous | REQ-407 |
| PTP timestamping | Out of scope | REQ-018 |
| Proxy ARP | Out of scope | REQ-512 |
| IGMP membership reports | Out of scope; multicast reception is configured statically | REQ-604 |
| PMA, PCS, 64b/66b, serdes | Phase-3 stretch, below the XGMII boundary | REQ-018 |
