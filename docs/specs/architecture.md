# Phase-1 Architecture — XGMII 10G MAC + ARP/IPv4/UDP

- **Status**: DRAFT — candidate for `P1-spec-freeze`
- **Owner**: architect_docs_lead · **Work order**: WO-0002
- **Companion documents**: [`requirements.md`](requirements.md) (REQ-###),
  [`traceability.md`](traceability.md), [`SPEC-TEMPLATE.md`](SPEC-TEMPLATE.md)
- **Decision context**: `docs/adr/ADR-0001` (programme scope), `ADR-0004`
  (Hardcaml v0.17.x), `ADR-0005` (CI is the authoritative build environment)

This document is the **canonical statement of Phase-1 scope parameters** from
M1 onward (PROTOCOL §11). README's phase table and the charters restate these
values for convenience; a change to any of them updates this file *and* every
restatement, under an ADR.

---

## 1. Scope parameters (canonical)

| Parameter | Value |
|---|---|
| Datapath width | 64 bits |
| Clock | one domain, nominally 156.25 MHz, 6.4 ns per cycle |
| Line rate | 10.0 Gb/s (8 octets per 6.4 ns) |
| Hardware attach point | XGMII, simulation-only in Phase 1 |
| Protocols in scope | Ethernet II framing, CRC-32 FCS, IFG, ARP, IPv4, UDP |
| Maximum frame | 1518 octets, destination address through FCS; no jumbo, no VLAN |
| Receive discipline | cut-through, zero backpressure |
| Receive latency budget | 24 cycles (153.6 ns), XGMII start word to first application payload word |
| Toolchain | released Hardcaml v0.17.x (ADR-0004), built and tested in CI (ADR-0005) |
| Differential reference | alexforencich/verilog-ethernet (MIT) |
| Out of scope | PMA/PCS/serdes (Phase 3), MoldUDP64/ITCH/order book (Phase 2) |

**Datapath arithmetic, stated once.** A minimum-length frame occupies 8 octets
of preamble and SFD, 64 octets of frame, and at least 12 octets of inter-frame
gap: 84 octets, or 10.5 cycles. XGMII start characters may occupy lane 0 or
lane 4, so 84 octets is exactly realisable by alternating the start lane, and a
compliant link partner can therefore deliver minimum-length frames every 10 and
11 cycles alternately. **The receive path is designed for that arrival rate**
(REQ-004). The Phase-1 transmitter is simpler: it starts frames on lane 0 only,
so it emits at most one minimum-length frame per 11 cycles (REQ-204, REQ-209).

---

## 2. Architectural decisions

Each decision below is stated with the alternative that was rejected. The
decisions marked *ADR candidate* are the ones whose reversal would be a
breaking interface change; they are extracted into `docs/adr/` before or at
`P1-spec-freeze`.

### 2.1 Cut-through receive path with late abort (*ADR candidate*)

The receive path forwards every payload word as soon as it is decoded. Frame
validity — FCS, length, error characters — is only known at the end of the
frame, so it is signalled **after** the payload has already been delivered, as
`tuser`[0] = 1 on the word carrying `tlast` (REQ-007, REQ-013, REQ-104). Every
downstream module propagates that bit; the application must treat a frame as
speculative until it sees `tlast`.

*Rejected*: store-and-forward, where each stage buffers a whole frame and only
emits validated frames. It is simpler to consume and it is what a general
purpose NIC does, but it costs at least a full frame time of latency
(1500 octets = 188 cycles = 1.2 µs) at every stage, which contradicts the whole
point of the programme. The cost of the choice is real and is pushed onto
Phase 2: the ITCH feed handler must be able to discard work it has already
started. REQ-019 (no payload buffer deeper than two words) exists so this
decision cannot quietly erode during implementation.

### 2.2 No backpressure anywhere on the receive path (*ADR candidate*)

Receive-path ports carry `Axi64.Source` records only. There is no `tready` to
assert, so there is no receive queue, no queue overflow condition, and no
possibility of the transmit path stalling the receive path (REQ-003, REQ-112,
REQ-208). The obligation this creates is placed explicitly on the consumer,
including the Phase-2 feed handler (REQ-805).

*Rejected*: full AXI-Stream with `tready` on the receive path, with elastic
buffers. That is the conventional choice and it tolerates a slow consumer, but
it makes "did we drop a frame" a runtime question rather than a structural
guarantee, and every buffer added is latency and an untested overflow path.
Making the absence of `tready` visible in the *type* is what makes REQ-003
mechanically checkable: a receive module that wants backpressure cannot be
written without changing its interface record, which is a spec diff.

### 2.3 Stream types come from `hardcaml_axi` (*prerequisite, see §7*)

The fabric type is `Hardcaml_axi.Stream.Make` instantiated once, programme
wide, as `Axi64` with `data_bits = 64` and `user_bits = 1`. That functor yields
`Axi64.Source` = { `tvalid`; `tdata`; `tkeep`; `tstrb`; `tlast`; `tuser` } and
`Axi64.Dest` = { `tready` }. Receive ports use `Source` alone; transmit ports
use `Source` plus `Dest`. `tstrb` is not used by this design and is driven to
zero (REQ-014).

*Rejected*: a local hand-written stream record without `tstrb`. It would be a
slightly tighter fit — eight fewer tied-off bits at every module boundary — but
it duplicates a Jane Street interface the charter names explicitly, and the
saving is cosmetic. **Prerequisite**: `hardcaml_axi` (which pulls
`hardcaml_circuits` and `hardcaml_handshake`) is *not yet* in
`agentic_fpga.opam`; adding it is an orchestrator action (§7). If it cannot be
installed in CI, the fallback is the local record and that reversal needs an
ADR, not a quiet edit.

### 2.4 Module decomposition mirrors verilog-ethernet

The inventory in §4 is aligned name-for-name with the 64-bit modules of
alexforencich/verilog-ethernet, because Phase-1 sign-off requires differential
co-simulation against it (REQ-901, dv_lead charter §3): matching boundaries
means the comparison can be made at each module, not only at the top.

*Rejected*: a decomposition organised by protocol layer as one module per layer
(one "ethernet" module, one "ip" module, one "udp" module). Fewer modules to
spec, but each becomes a large state machine with a mixed receive/transmit
concern, and the differential comparison degrades to a single top-level
equivalence check with no localisation when it fails.

Deliberate deviations from the reference are listed in §5.

### 2.5 ARP is a full resolver, not a responder-only stub

ARP answers requests for the configured address, learns from observed packets,
serves transmit-side lookups from a cache, and issues requests on a miss, with
special handling for broadcast, subnet-broadcast, multicast and off-subnet
destinations (REQ-501 … REQ-512). On a cache miss the pending datagram is
*discarded*, never queued (REQ-505) — the no-buffering rule wins over
convenience.

*Rejected (a)*: responder-only ARP with a statically configured peer MAC for
transmit. It is enough for a receive-only market-data NIC — multicast MACs are
derived arithmetically (REQ-509) and need no ARP at all — but it leaves the
programme without a testable ARP cache, and ARP is named in the programme scope
(ADR-0001). *Rejected (b)*: the reference design's LRU cache with hashing.
Phase 1 uses a 16-entry direct-mapped cache with an exactly specified index
function (REQ-504) so that collision behaviour is a derivable test rather than
an emergent property; the LRU version is a Phase-2-or-later refinement if
anything ever needs it.

### 2.6 Filtering happens at IPv4 and UDP, not at the MAC

The Ethernet receive path is promiscuous (REQ-407); acceptance is decided by
IPv4 destination (REQ-604) and UDP destination port (REQ-704). This matches the
reference design's behaviour, which keeps co-simulation stimulus simple, and it
puts multicast group acceptance in the layer that actually knows about groups.

*Rejected*: a MAC-layer address filter. It would drop foreign traffic one stage
earlier, saving nothing in a simulation-only design, and it would introduce a
co-simulation divergence class on the very first stage.

### 2.7 The application transmit interface declares its length up front

The application supplies destination address, ports and payload length before
the first payload word (REQ-705). This is what lets IPv4 and UDP build their
headers without buffering (REQ-610, REQ-706).

*Rejected*: deriving the length by buffering the payload, as a
checksum-generating UDP transmitter must. That would put a store-and-forward
FIFO on the transmit path and is the reason UDP transmit checksums are zero in
Phase 1 (REQ-706), which RFC 768 permits for IPv4.

### 2.8 Single clock domain

Receive and transmit share one clock (REQ-001). Real XGMII has independent
receive and transmit clocks; the Phase-1 design is simulation-only at that
boundary (REQ-018), so a second domain would add CDC structures that verify
nothing about the design under test.

*Rejected*: two domains with an asynchronous FIFO at the boundary. Deferred to
whatever future work attaches real hardware; that work owns the CDC.

---

## 3. The XGMII boundary and its stub

Phase 1 is **closed at XGMII** (REQ-017). The top level's only wire-side ports
are `xgmii_rxd`[63:0], `xgmii_rxc`[7:0], `xgmii_txd`[63:0], `xgmii_txc`[7:0].
Everything below XGMII — PMA, serdes, 64b/66b PCS, scrambler, link training,
fault signalling — is out of scope (REQ-018, REQ-113) and is where the Phase-3
stretch goal would attach.

The **stub** is the simulation-side link partner: a model that encodes frames
into XGMII lanes (preamble, start lane selection, terminate placement, idle
fill, error injection) and decodes them back. It is **owned by dv_lead under
`test/`**, not by the RTL line — it is stimulus, not design. This architecture
document fixes only its contract:

- It SHALL be able to emit start characters in lane 0 and lane 4, including the
  alternating pattern required by REQ-004.
- It SHALL be able to inject each error condition named in REQ-104, REQ-105,
  REQ-107, REQ-108 and REQ-110.
- It SHALL decode transmit-side XGMII well enough to validate preamble, FCS,
  terminate placement and inter-frame gap (REQ-201 … REQ-205).

Because the RTL side is closed at XGMII, no RTL deliverable in §4 depends on
the stub's internals, and the stub can be replaced by the verilog-ethernet
reference driver for co-simulation (REQ-901).

---

## 4. Module inventory

Every Phase-1 RTL deliverable appears here. Modules live under
`libs/hardcaml_ethernet/src/` (rtl_lead's write scope); the emitted Verilog
module name is the snake-case module name (REQ-808). "Path" is R for the
receive datapath, T for transmit, S for shared or structural.

| # | Module | Path | Role | verilog-ethernet counterpart | Primary REQs |
|---|---|---|---|---|---|
| M01 | `Axi64` | S | Programme stream types: `Hardcaml_axi.Stream.Make` at 64 bits, plus the `Eth_header`, `Ip_header`, `Udp_header` and `Config`/`Status` records. Types only, no circuit. | (none — Verilog uses flat ports) | 010, 011, 012, 013, 014, 802 |
| M02 | `Crc32_eth` | S | Combinational CRC-32 update for 1 to 8 octets per cycle. | `lfsr.v`, `axis_eth_fcs_64.v` | 301–306 |
| M03 | `Xgmii_rx_64` | R | XGMII lanes to frame stream: start-lane detection, preamble strip, terminate handling, FCS check, error marking. | `axis_xgmii_rx_64.v` | 101–113 |
| M04 | `Xgmii_tx_64` | T | Frame stream to XGMII lanes: preamble, padding, FCS append, terminate, inter-frame gap, underflow. | `axis_xgmii_tx_64.v` | 201–210 |
| M05 | `Eth_mac_10g` | S | Structural wrapper binding M03 and M04 to one XGMII port pair. | `eth_mac_10g.v` | 017, 018, 808 |
| M06 | `Eth_axis_rx` | R | Frame stream to Ethernet header record plus payload stream; realignment after the 14-octet header. | `eth_axis_rx.v` | 401–403, 407–410, 021 |
| M07 | `Eth_axis_tx` | T | Ethernet header record plus payload to frame stream. | `eth_axis_tx.v` | 405, 409 |
| M08 | `Eth_demux` | R | Ethertype routing: IPv4, ARP, discard. | `eth_demux.v` | 404 |
| M09 | `Eth_arb_mux` | T | Frame-atomic two-port arbitration between ARP and IPv4 transmit traffic. | `eth_arb_mux.v` | 406 |
| M10 | `Arp_eth_rx` | R | ARP packet parse into fields. | `arp_eth_rx.v` | 501 |
| M11 | `Arp_eth_tx` | T | ARP fields to packet. | `arp_eth_tx.v` | 502 |
| M12 | `Arp_cache` | S | 16-entry direct-mapped IPv4-to-MAC cache with ageing. | `arp_cache.v` | 503, 504, 506 |
| M13 | `Arp` | S | ARP state machine: respond, learn, resolve, request, retry, special-address handling. | `arp.v` | 502, 505, 507–512 |
| M14 | `Ip_eth_rx_64` | R | IPv4 parse, validation, padding strip, payload realignment. | `ip_eth_rx_64.v` | 601–607, 611, 612, 021 |
| M15 | `Ip_eth_tx_64` | T | IPv4 header construction and checksum. | `ip_eth_tx_64.v` | 608–610 |
| M16 | `Ip_complete_64` | S | Structural wrapper: M08, M10–M13, M14, M15, M09 — the IPv4-with-ARP subsystem. | `ip_complete_64.v` (with `ip_64.v` folded in) | 807, 808 |
| M17 | `Udp_ip_rx_64` | R | UDP parse, length checks, port filter, payload realignment. | `udp_ip_rx_64.v` | 701–704, 707, 021 |
| M18 | `Udp_ip_tx_64` | T | UDP header construction from the application request. | `udp_ip_tx_64.v` | 705, 706, 709 |
| M19 | `Udp_complete_64` | S | Structural wrapper: M16, M17, M18 — the full stack below the application. | `udp_complete_64.v` (with `udp_64.v` folded in) | 708 |
| M20 | `Nic_top` | S | Phase-1 top: M05 plus M19, configuration and status aggregation, application streams. | (assembled from `eth_mac_10g` + `udp_complete_64` in the reference's examples) | 801–809, 006 |

**Latency budget allocation** against REQ-006 (24 cycles). Each module spec
pins its exact constant; these are the ceilings the specs must fit inside.

| Stage | Ceiling (cycles) |
|---|---|
| `Xgmii_rx_64` | 4 |
| `Eth_axis_rx` | 3 |
| `Eth_demux` | 1 |
| `Ip_eth_rx_64` | 5 |
| `Udp_ip_rx_64` | 4 |
| Allocated | 17 |
| Slack held by the architect | 7 |

Slack is released only by a spec diff, so an over-budget module is a visible
decision rather than an accumulation.

---

## 5. Deliberate deviations from the reference decomposition

| Deviation | Reason |
|---|---|
| `ip_64.v` and `ip_complete_64.v` merged into M16; `udp_64.v` and `udp_complete_64.v` merged into M19 | The reference keeps two wrapper levels so that multiple IP and UDP clients can be arbitrated. Phase 1 has exactly one client, so the inner wrapper would be a pass-through. Co-simulation still pairs at the outer wrapper. |
| `ip_arb_mux.v`, `ip_demux.v`, `udp_mux.v`, `udp_demux.v` omitted | Same reason: one client, one port. Protocol filtering is a comparison inside M14 (REQ-607) and port filtering inside M17 (REQ-704). |
| `udp_checksum_gen_64.v` omitted | It requires buffering the payload; Phase 1 transmits a zero checksum instead (REQ-706, §2.7). |
| `axis_eth_fcs_insert.v` / `axis_eth_fcs_check.v` folded into M03 and M04 | The reference's 10G MAC also computes FCS inside the XGMII adapters; the standalone variants exist for its 1G paths. |
| `eth_mac_phy_10g*.v`, `xgmii_baser_*.v` omitted | Below the XGMII boundary (REQ-018); Phase-3 territory. |
| PTP ports omitted throughout | Out of scope (REQ-018). |
| Direct-mapped ARP cache instead of `arp_cache.v`'s LRU | §2.5. |

**Provenance and licensing.** The counterpart column and the deviations above
were derived from the source-file listing in the verilog-ethernet README and
from the module and parameter declarations of `axis_xgmii_rx_64.v` and
`axis_xgmii_tx_64.v` (repository `alexforencich/verilog-ethernet`, MIT, read
2026-08-01). What was taken is **decomposition and naming**: which modules
exist, what each is responsible for, and which configuration knobs matter for
co-simulation (`ENABLE_DIC`, `ENABLE_PADDING`, `MIN_FRAME_LENGTH`,
`PTP_TS_ENABLE`). No Verilog source was copied into this specification, and all
behaviour above is stated as requirements to be implemented from scratch in
Hardcaml. `Essenceia/Nasdaq-HFT-FPGA` (CC BY-NC, consult-only under PROTOCOL
§10) was **not** consulted for this work order; it has no Phase-1 relevance.

---

## 6. Dataflow

### 6.1 Receive path

```mermaid
flowchart TD
    W["XGMII wire lanes<br/>xgmii_rxd 64, xgmii_rxc 8<br/>simulation-only boundary"]
    M03["M03 Xgmii_rx_64<br/>strip preamble, check FCS<br/>mark abort on tlast"]
    M06["M06 Eth_axis_rx<br/>strip 14-octet header<br/>realign payload"]
    M08["M08 Eth_demux<br/>route by ethertype"]
    M10["M10 Arp_eth_rx"]
    M13["M13 Arp<br/>respond, learn, resolve"]
    M12["M12 Arp_cache"]
    M14["M14 Ip_eth_rx_64<br/>verify checksum, strip padding<br/>realign payload"]
    M17["M17 Udp_ip_rx_64<br/>length and port checks<br/>realign payload"]
    APP["Application boundary<br/>Phase 2: MoldUDP64 and ITCH"]
    D1["discard: error_unknown_ethertype"]

    W --> M03
    M03 -->|"Axi64.Source, frame octets"| M06
    M06 -->|"Eth_header plus payload"| M08
    M08 -->|"ethertype 0x0806"| M10
    M08 -->|"ethertype 0x0800"| M14
    M08 -->|"any other ethertype"| D1
    M10 --> M13
    M13 --> M12
    M14 -->|"Ip_header plus payload"| M17
    M17 -->|"Udp_header plus payload, no tready"| APP
```

### 6.2 Transmit path

```mermaid
flowchart TD
    APP["Application transmit request<br/>dst ip, dst port, src port, length<br/>Axi64.Source plus Axi64.Dest"]
    M18["M18 Udp_ip_tx_64<br/>build UDP header<br/>checksum zero"]
    M15["M15 Ip_eth_tx_64<br/>build IPv4 header<br/>header checksum"]
    M13["M13 Arp<br/>cache lookup"]
    M09["M09 Eth_arb_mux<br/>frame-atomic arbitration"]
    M11["M11 Arp_eth_tx<br/>ARP replies and requests"]
    M07["M07 Eth_axis_tx<br/>insert 14-octet header"]
    M04["M04 Xgmii_tx_64<br/>preamble, pad, FCS, IFG"]
    WT["XGMII wire lanes<br/>xgmii_txd 64, xgmii_txc 8"]
    D2["discard: error_arp_miss"]

    APP --> M18
    M18 --> M15
    M13 -->|"resolved MAC or miss"| M15
    M15 -->|"on miss"| D2
    M15 --> M09
    M11 --> M09
    M09 --> M07
    M07 --> M04
    M04 --> WT
```

### 6.3 Hierarchy

```mermaid
flowchart TD
    T["M20 Nic_top"]
    MAC["M05 Eth_mac_10g"]
    UDPC["M19 Udp_complete_64"]
    M03["M03 Xgmii_rx_64"]
    M04["M04 Xgmii_tx_64"]
    CRC["M02 Crc32_eth"]
    IPC["M16 Ip_complete_64"]
    M17["M17 Udp_ip_rx_64"]
    M18["M18 Udp_ip_tx_64"]
    M06["M06 Eth_axis_rx"]
    M07["M07 Eth_axis_tx"]
    M08["M08 Eth_demux"]
    M09["M09 Eth_arb_mux"]
    M14["M14 Ip_eth_rx_64"]
    M15["M15 Ip_eth_tx_64"]
    ARP["M13 Arp"]
    M10["M10 Arp_eth_rx"]
    M11["M11 Arp_eth_tx"]
    M12["M12 Arp_cache"]

    T --> MAC
    T --> UDPC
    MAC --> M03
    MAC --> M04
    M03 --> CRC
    M04 --> CRC
    UDPC --> IPC
    UDPC --> M17
    UDPC --> M18
    IPC --> M06
    IPC --> M07
    IPC --> M08
    IPC --> M09
    IPC --> M14
    IPC --> M15
    IPC --> ARP
    ARP --> M10
    ARP --> M11
    ARP --> M12
```

`Axi64` (M01) is a types module and appears in every port record rather than in
the instance hierarchy.

---

## 7. Prerequisites for `P1-spec-freeze`

These are outside the architect's write scope and are requested from the
orchestrator as work orders (charter §7):

1. **`hardcaml_axi` dependency** — add to `agentic_fpga.opam` and to the
   `libraries` field of `libs/hardcaml_ethernet/src/dune`. It pulls
   `hardcaml_circuits` and `hardcaml_handshake` and needs OCaml ≥ 5.1, which
   the CI switch already satisfies (`hardcaml_waveterm` requires 5.1).
   Blocking for §2.3; the fallback if CI cannot install it is a local stream
   record plus an ADR.
2. **`docs/specs/ifc_check/` dune wiring** — a scratch library whose sources
   are the Interface records lifted out of the module specs. The `.ml` contents
   are the architect's (inside `docs/**`); the `dune` stanza and its inclusion
   in the build are the orchestrator's. Charter §5 makes a green `ifc_check`
   build a freeze precondition, and ADR-0005 makes the CI run identifier the
   only acceptable evidence for it.
3. **dv_lead testability review** of `requirements.md` before the freeze
   checklist is opened, so objections land as spec diffs rather than as gate
   blockers.

---

## 8. Per-module specification plan

Twenty specifications, in dependency order, grouped into six batches. Each
batch is proposed as one work order — batching is the orchestrator's call, but
the ordering is not: a spec may only be written after the specs it depends on
are drafted, because the dependant reuses their interface records.

| Batch | Specs | Depends on | Note |
|---|---|---|---|
| **A** | M01 `Axi64`, M02 `Crc32_eth` | — | Establishes the fabric records every later spec quotes; the first `ifc_check` compile happens here. Prerequisite 7.1 must be resolved first. |
| **B** | M03 `Xgmii_rx_64`, M04 `Xgmii_tx_64`, M05 `Eth_mac_10g` | A | The hardest receive module (M03) is specified early on purpose: its constant-latency and start-lane behaviour set the pattern the rest follow. |
| **C** | M06 `Eth_axis_rx`, M07 `Eth_axis_tx`, M08 `Eth_demux`, M09 `Eth_arb_mux` | A, B | Introduces the header-record convention and the realignment obligation (REQ-021). |
| **D** | M10 `Arp_eth_rx`, M11 `Arp_eth_tx`, M12 `Arp_cache`, M13 `Arp` | C | Independent of the IPv4 datapath; can run in parallel with E if two spec work orders are in flight. |
| **E** | M14 `Ip_eth_rx_64`, M15 `Ip_eth_tx_64`, M16 `Ip_complete_64` | C, D | M16 is structural and is specified after its children. |
| **F** | M17 `Udp_ip_rx_64`, M18 `Udp_ip_tx_64`, M19 `Udp_complete_64`, M20 `Nic_top` | E | M20 pins the measured end-to-end latency (REQ-806) and the configuration record (REQ-802). |

Every spec follows [`SPEC-TEMPLATE.md`](SPEC-TEMPLATE.md) and is frozen only
with a green `ifc_check` build and a dv_lead testability countersignature.

---

## 9. Forward look (non-binding)

Phase 2 attaches at the application receive stream of M20: MoldUDP64 and ITCH
5.0 parsing consume `Axi64.Source` words with no `tready` (REQ-805), which is
why the realignment obligation (REQ-021) is specified as a general rule here
rather than as an ITCH-specific trick later — 36-to-50-octet ITCH messages
straddling 64-bit words are the same problem one layer up. Phase 3 attaches
below the XGMII ports of M20, replacing the DV stub with a 64b/66b PCS. Neither
imposes a requirement on Phase 1 beyond what is already stated.

---

## 10. References

- `alexforencich/verilog-ethernet` (MIT) — README source-file listing;
  `rtl/axis_xgmii_rx_64.v` and `rtl/axis_xgmii_tx_64.v` module and parameter
  declarations. Read 2026-08-01 as decomposition ground truth; no source
  copied.
- `janestreet/hardcaml_axi` v0.17.0 — `src/stream_intf.ml` (`Config`, `Source`,
  `Dest`, `Make`) and `hardcaml_axi.opam` (dependency and OCaml constraints).
- IEEE 802.3 clause 46 (XGMII), clause 4 (frame format, FCS, inter-frame gap);
  RFC 826 (ARP), RFC 791 (IPv4), RFC 768 (UDP), RFC 1112 §6.4 (IPv4 multicast
  MAC mapping).
- `docs/adr/ADR-0001`, `ADR-0004`, `ADR-0005`; `agents/PROTOCOL.md` §7, §10, §11.
