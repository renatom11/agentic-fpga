# SPEC-M17 — `Udp_ip_rx_64`

- **Status**: **FROZEN** (`P1-spec-freeze`, SHA `d8df28d`) — batch F, dv_lead
  countersignature `J-dv_lead-0011` (WO-0022), **SIGNED** on the bounded
  re-review of the F-1 repair with every number re-derived. Changes to §4, §6 or
  §7 after this point are spec diffs recorded in §13 (SPEC-TEMPLATE rule 7)
- **Inventory id**: M17 (architecture.md §4) · **Path**:
  `libs/hardcaml_ethernet/src/udp_ip_rx_64.ml`
- **Datapath role**: receive
- **Owns REQs**: REQ-701, REQ-702, REQ-703, REQ-704, REQ-707 (the producer half
  — see §5), and the last instance of REQ-021's realignment obligation, which
  is where it turns out to be free (§7)
- **Prior-art counterpart**: `udp_ip_rx_64.v` (MIT) — consulted for
  decomposition and port naming only; behaviour below is stated independently
  and no source was copied. No REQ-901 divergence class lives here: the
  reference does not verify the UDP receive checksum either (REQ-702), so this
  boundary compares without exclusions
- **Depends on specs**: SPEC-M01 (`Axi64`, `Ip_header`, `Udp_header`), SPEC-M14
  (`Ip_eth_rx_64`, its producer, whose one-cycle header lead this module is
  written against), SPEC-M16 (`Ip_complete_64`, which relays that pair
  unchanged), SPEC-M06 and SPEC-M08 (the two stages above M14, for the
  open/close device §6.1 reuses)
- **Author**: architect_docs_lead, journal `J-architect_docs_lead-0008`

## 1. Purpose

M17 turns the payload stream of an accepted IPv4 datagram into a UDP **header
record** plus the **application receive stream**: it reads the four UDP header
fields, checks the datagram's length against what IPv4 actually delivered,
filters on the destination port, strips the 8-octet UDP header and presents what
remains as the octets the application consumes. It is the last stage of the
receive chain and the module whose output port is Phase 2's attach point
(architecture.md §9).

It exists as a separate module for the same reason M06 and M14 do — a header has
to be stripped and the remainder realigned (REQ-021) — with one difference worth
stating at the top because it shapes §7: **the UDP header is exactly eight
octets, so at this stage the realignment is the identity.** M17 is the third and
last stripping stage (M06 strips 14, M14 strips 20, M17 strips 8) and the only
one whose header is a whole number of datapath words.

Its upstream is M14 `Ip_eth_rx_64` (through M16's `ip_rx_*` relay ports,
architecture.md §6.4.1); its downstream is the application, reached through
M19's and M20's `app_rx_*` relays. It instantiates nothing.

## 2. Scope

**In scope.**

- Presenting source port, destination port, length and checksum in a
  `Udp_header` record whose `valid` pulses for exactly one cycle per accepted
  datagram (REQ-701, REQ-012).
- Checking the datagram's length against the two things REQ-703 makes acceptance
  criteria — a length below 8, and a length exceeding the octets the IPv4 layer
  delivered — and reporting each with `error_udp_bad_length` (§9).
- Filtering on the destination port (REQ-704) against `cfg_listen_port`, or
  accepting every port when `cfg_accept_all_ports` = 1, and reporting a
  rejection with `error_udp_port`.
- Delivering exactly (length − 8) payload octets on the application receive
  stream, word-aligned (REQ-021, REQ-707), and carrying an inherited abort
  through to its `tlast` word (REQ-007, REQ-013, REQ-707) **on the class that
  word can still carry it — §6.1's D = 0 — and driving a derived 0 on the
  under-declaring class, D ≥ 1 (§6.2, §11.4)**.
- **Not** verifying the UDP checksum (REQ-702), which is a deliberate behaviour
  and not an omission: the field is carried in the record and is never compared
  against anything.
- Doing all of that at the single pinned per-octet constant of §7 (REQ-005,
  REQ-019).

**Not this module's job.**

| Behaviour a reader might expect here | Owner |
|---|---|
| Deciding whether the datagram is for us at the IP layer, checking the IPv4 header checksum, stripping Ethernet padding | M14 `Ip_eth_rx_64` (REQ-601 … REQ-607, REQ-612). By the time a payload reaches M17 the datagram is accepted and its padding is gone; M17 never re-checks any of it |
| Verifying the UDP checksum | **nobody** — REQ-702 says so in terms, and requirements.md §11 records the absence as a decision. Frame integrity is the Ethernet FCS's job (REQ-104). M17 carries the field and compares it to nothing |
| Building a UDP header for transmission, or the "+ 8" arithmetic | M18 `Udp_ip_tx_64` (REQ-705, REQ-706, REQ-610's UDP half). M17 and M18 share the `Udp_header` record's *type* and nothing else — and in fact M18 does not use that record at all (SPEC-M18 §4.1), so `Udp_header` is the one M01 record with a receive discipline and no transmit instance |
| Consuming or acting on the abort bit | the **application** (REQ-707, REQ-013, ADR-0009 names it as this branch's ultimate consumer). M17 relays `tuser`[0] to its own `tlast` word — where §6.1's D = 0 lets that word carry it, and a derived 0 otherwise (§6.2, §11.4) — and acts on nothing |
| Buffering, reordering or de-duplicating datagrams | **nobody** — REQ-005, REQ-019 and REQ-020. M17 holds one datagram's header at a time and no payload beyond §7's one word |
| Telling the application to slow down | **nobody, structurally.** The application receive stream has no `tready` (REQ-707, REQ-805); the obligation is on the consumer and requirements.md says so |

## 3. Programme invariants that bind this module

M17 is a receive-path module under requirements.md §0.4 — it is the last stage of
the chain — and both its payload input and the application receive stream it
produces are receive-path streams. It is one of the seven modules owing a
line-rate stress bench (§0.4, REQ-905).

| REQ | Consequence for M17 |
|---|---|
| REQ-001 | One `clock`. Every register in §7's pipeline is synchronous to it. |
| REQ-002 | Input and application output are 64-bit `Axi64` streams, at most one word per cycle each. |
| REQ-003 | The application output is `Axi64.Source` **without** `Axi64.Dest`, and the input carries no `tready`: the application cannot stall M17 and M17 cannot stall M14, structurally (§4.1). This is the port at which REQ-805's obligation on the Phase-2 consumer becomes visible in the type. |
| REQ-004 | M17 is on requirements.md §0.4's stress-bench list. Its stimulus is what M14 emits on its `ip_payload` port under REQ-004's arrival pattern, relayed unchanged by M16, derived by construction and never re-invented (§8). |
| REQ-005 | Cut-through: no payload word is withheld to the end of its datagram. The per-octet latency is the single constant **L = 8 octet times** of §7, at every datagram length and content M17 accepts. A rejected datagram is rejected before any word is emitted, so REQ-005 has no instance for it. |
| REQ-007 | An abort inherited on the input `tlast` word is carried to the application stream's own `tlast` word (§9) **where that word is emitted *after* the input `tlast` is presented — §6.1's D = 0, and not "on or after", which would admit D = 1 where a registered output cannot carry the bit (ledger C-40); §6.1 scopes the copy, §6.2 states what M17 emits otherwise and §11.4 records the consequence for REQ-007's universal.** M17 originates no abort of its own except REQ-703's over-declared length, which it marks the same way. |
| REQ-008 | M17 owns **two** of the twenty-one strobes (requirements.md §12) and §9 pins every pulse cycle. |
| REQ-009 | Synchronous `clear`. On every cycle `clear` = 1 and on the first cycle it is 0: `payload_tvalid` = 0, `hdr_valid` = 0 and both strobes are 0. A datagram in flight is abandoned with no `tlast` and no strobe; a datagram whose first word arrives on the first cycle after `clear` returns to 0 is received correctly (§7). |
| REQ-010 | Both streams are the programme `Axi64.Source`; the input header is SPEC-M01's `Ip_header` and the output header is SPEC-M01's `Udp_header`, both unchanged. **M17 declares no record of its own** (§4.1). |
| REQ-011 | `payload_tkeep` is `0xFF` on every application word except the `tlast` word, where it is 1 to 8 contiguous ones from bit 0. |
| REQ-012 | Input octet position k is `ip_payload_tdata`[8k+7:8k], UDP octet 0 at k = 0 of input word 0; every header field is presented as a numeric value with network byte order already decoded (§6.1). |
| REQ-013 | `ip_payload_tuser`[0] is read on the input `tlast` word and written on the application `tlast` word **where §6.1's D = 0 puts that word after the input `tlast`; on D ≥ 1 that word leaves on or before the input `tlast` is presented and carries a derived 0 (§6.2, §11.4)**. M17 never drops a datagram because it is set, and it is **not** the ultimate consumer on this branch — the application is (REQ-707, ADR-0009). |
| REQ-014 | `ip_payload_tstrb` is ignored on the input and `payload_tstrb` is driven to 0 on the output. |
| REQ-015 | One `tlast` per application frame, the `tlast` word included in the count; at most **185** words between two `tlast` words (1480 octets — the 1500-octet maximum IPv4 total length less the 20-octet IPv4 header — less the 8-octet UDP header is 1472 octets, which is **184** words, 184 full; the 185-word bound is inherited from the input stream and is never reached at this output). At least one word. |
| REQ-016 | The input may carry idle cycles inside a datagram and M17 tolerates them: k idle cycles before an input word delay every octet that word carries by exactly 8k octet times and change nothing else (§7). §6.1's cycle formulas are stated on a gapless stimulus; §7's per-octet constant L holds on every stimulus. |
| REQ-017, REQ-018 | No instance: M17 sees no lane, no control character and nothing below XGMII. |
| REQ-019 | Word delay ΔC = (L + h)/8 = (8 + 8)/8 = **2** cycles against a ceiling of **4** (requirements.md §1.1) — M17 holds **two cycles of reserve inside its own allocation**, the largest reserve on the chain, which §7 and §11.2 state as a decision rather than leave to be discovered. Payload storage is **one** datapath word: the input is word-aligned and the header is a whole word, so no payload octet ever has to wait for a second input word (§7). |
| REQ-020 | Datagrams leave in the order they arrived; M17 holds one datagram's header at a time (§6.2), so reordering is not expressible. |
| REQ-021 | **The realignment obligation, third and last instance — and the one where it is the identity.** M17 strips 8 octets, which *is* a multiple of 8, and its input is word-aligned at its producer (M14, REQ-021), so UDP payload octet 0 is at position 0 of input word 1 and is emitted at position 0 of application word 0 with no shift at all. Every application word is one input word, not two. REQ-021 is satisfied here by arithmetic rather than by machinery, and §7 states what that is worth in cycles. |

## 4. Interface

### 4.1 Interface records

```ocaml
(* SPEC-M17 §4.1, lifted verbatim into docs/specs/ifc_check/udp_ip_rx_64_ifc.ml
   (SPEC-TEMPLATE.md rule 6). Records and signatures only — no logic, no
   implementation.

   [Axi64_ifc] is M01's types home (SPEC-M01 §4.1): [Axi64], [Ip_header]
   and [Udp_header] all come from there and are restated nowhere. M17
   declares NO record: M01 froze [Udp_header] at f78766e with no user
   until this batch, and this module's two header ports are exactly M01's
   two records. Batch F declares one record in total and it is M18's
   ([Udp_tx_request], SPEC-M18 §4.1, at the module REQ-705 makes its
   owner), under the declare-once rule batch D adopted (SPEC-M10 §4.1,
   §11.2).

   Receive-path module: [ip_payload] and [payload] are [Axi64.Source] and
   there is no [Axi64.Dest] anywhere in either record, which is REQ-003
   structurally — and this is the port at which REQ-805's obligation on
   the Phase-2 consumer becomes a statement about the type. Both header
   records carry a [valid] and no [ready] for the same reason.

   The input pair carries the [ip_] prefix and the output pair is bare —
   the mirror image of M14, whose inputs are bare and whose outputs carry
   [ip_] (SPEC-M14 §4.1). Either arrangement keeps the emitted names
   distinct inside one Verilog module, which is the property that matters;
   architecture.md §6.4.1 gave M17 this shape before either spec existed,
   so this batch confirms those rows rather than amending them. *)

open! Base
open Hardcaml
open! Axi64_ifc

module I = struct
  type 'a t =
    { clock : 'a
    ; clear : 'a
    ; ip_hdr : 'a Ip_header.t [@rtlprefix "ip_hdr_"]
    ; ip_payload : 'a Axi64.Source.t [@rtlprefix "ip_payload_"]
    ; cfg_listen_port : 'a [@bits 16]
    ; cfg_accept_all_ports : 'a
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { hdr : 'a Udp_header.t [@rtlprefix "hdr_"]
    ; payload : 'a Axi64.Source.t [@rtlprefix "payload_"]
    ; error_udp_bad_length : 'a
    ; error_udp_port : 'a
    }
  [@@deriving hardcaml]
end

module type S = sig
  val create : Scope.t -> Signal.t I.t -> Signal.t O.t
  val hierarchical : ?instance:string -> Scope.t -> Signal.t I.t -> Signal.t O.t
end

(* REQ-010 type identity at both stream ports, and the first compile-time
   witness that [Udp_header]'s five field names are what SPEC-M01 §4.2
   writes — the record was frozen at f78766e with no user until this
   batch, exactly as [Ip_header] was until batch E (SPEC-M14 §4.1). *)

let _witness_streams_are_the_programme_type
      (x : Signal.t Axi64.Source.t)
      (y : Signal.t Axi64.Source.t)
  =
  x, y
;;

let _witness_udp_header_field_names (h : Signal.t Udp_header.t) =
  let open Udp_header in
  [ h.valid; h.src_port; h.dst_port; h.length; h.checksum ]
;;
```

Conformance of this block to the template's rules for §4.1:

- Scalar fields carry `[@bits n]` unless they are one bit wide: `clock`,
  `clear`, `cfg_accept_all_ports` and the two strobes are one bit;
  `cfg_listen_port` carries 16, and every other field is inside a nested record
  carrying its own widths.
- Nested interfaces carry `[@rtlprefix]`: `ip_hdr` emits `ip_hdr_valid` …
  `ip_hdr_total_length`, `ip_payload` emits `ip_payload_tvalid` …
  `ip_payload_tuser`, `hdr` emits `hdr_valid` … `hdr_checksum`, and `payload`
  emits `payload_tvalid` … `payload_tuser`. No two emitted names collide,
  which is the check M14's rename existed to satisfy and which this module
  passes without one.
- **Receive-path `Source` without `Dest`: held.** Neither record contains an
  `Axi64.Dest` and neither contains a `tready` field. An M17 that wanted
  backpressure could not be written without changing this record, which is a
  spec diff — REQ-003, and at this port also REQ-707 and REQ-805.
- Both `create` and `hierarchical` are declared (REQ-903, REQ-808).

### 4.2 Port table

Every port in §4.1 appears exactly once. Direction is with respect to M17.

| Port | Dir | Width | Meaning | REQ |
|---|---|---|---|---|
| `clock` | in | 1 | 156.25 MHz single domain | REQ-001 |
| `clear` | in | 1 | synchronous clear | REQ-009 |
| `ip_hdr_valid` | in | 1 | an accepted IPv4 datagram begins; this pulse **opens** a datagram (§6.1). One of the two fields of this record M17 reads | REQ-606 |
| `ip_hdr_src_ip` | in | 32 | present because M14 emits the whole record; **read by nothing** here — the source address is the application's business and reaches it through no Phase-1 port (§11.3) | REQ-606 |
| `ip_hdr_dst_ip` | in | 32 | same; read by nothing — REQ-604's destination filter was M14's and is not revisited | REQ-604 |
| `ip_hdr_protocol` | in | 8 | same; read by nothing — **17** on every datagram that reaches here, because REQ-607 discarded the rest at M14 | REQ-607 |
| `ip_hdr_ttl` | in | 8 | same; read by nothing — Phase 1 does not forward | REQ-606 |
| `ip_hdr_dscp` | in | 6 | same; read by nothing | REQ-606 |
| `ip_hdr_total_length` | in | 16 | the datagram's IPv4 total length. **Read by nothing**: REQ-703 measures the UDP length against *the octets the IPv4 layer delivers*, which M17 counts on the payload stream itself rather than deriving from a declaration — the two differ exactly when M14 aborted a truncated datagram, and the delivered count is the one REQ-703 names (§6.1) | REQ-703 |
| `ip_payload_tvalid` | in | 1 | this cycle carries a payload word | REQ-016 |
| `ip_payload_tdata` | in | 64 | payload octets; UDP octet 0 at position 0 of input word 0 | REQ-012, REQ-021 |
| `ip_payload_tkeep` | in | 8 | valid octet positions, contiguous from bit 0; read to count delivered octets against the UDP length | REQ-011 |
| `ip_payload_tstrb` | in | 8 | reserved; ignored | REQ-014 |
| `ip_payload_tlast` | in | 1 | this word carries the datagram's final octets; **closes** a datagram (§6.1) | REQ-015 |
| `ip_payload_tuser` | in | 1 | bit 0: inherited abort, meaningful only on the `tlast` word; **copied out where §6.1's D = 0 and dropped where D ≥ 1** (§6.2, §11.4), never acted on | REQ-013, REQ-007 |
| `cfg_listen_port` | in | 16 | the one destination port accepted when `cfg_accept_all_ports` = 0 | REQ-704, REQ-802 |
| `cfg_accept_all_ports` | in | 1 | 1 removes the port test entirely; `cfg_listen_port` is then irrelevant | REQ-704, REQ-802 |
| `hdr_valid` | out | 1 | one cycle high per **accepted** datagram, one cycle before its first application word; the other four fields are that datagram's | REQ-701 |
| `hdr_src_port` | out | 16 | source port, first wire octet most significant | REQ-701, REQ-012 |
| `hdr_dst_port` | out | 16 | destination port as received; equal to `cfg_listen_port` unless `cfg_accept_all_ports` = 1 | REQ-701, REQ-704 |
| `hdr_length` | out | 16 | UDP length as received, in octets, the 8-octet UDP header included | REQ-701, REQ-703 |
| `hdr_checksum` | out | 16 | UDP checksum as received, **carried and never verified** (REQ-702); 0x0000 means the sender computed none, which RFC 768 permits and which is what this design's own transmitter emits (REQ-706) | REQ-701, REQ-702 |
| `payload_tvalid` | out | 1 | this cycle carries an application word | REQ-016, REQ-707 |
| `payload_tdata` | out | 64 | UDP payload octets, the first octet after the UDP header at position 0 | REQ-021, REQ-707 |
| `payload_tkeep` | out | 8 | valid octet positions, contiguous from bit 0 | REQ-011 |
| `payload_tstrb` | out | 8 | reserved; driven to 0 | REQ-014 |
| `payload_tlast` | out | 1 | this word carries the payload's final octets | REQ-015 |
| `payload_tuser` | out | 1 | bit 0: the inherited abort, or REQ-703's over-declared length, on the `tlast` word — **inherited by copy only where §6.1's D = 0; driven to 0 on the under-declaring class, D ≥ 1 (§6.2, §11.4)**. **This is the bit the application discards on** (REQ-013, REQ-707, ADR-0009) | REQ-007, REQ-013, REQ-707 |
| `error_udp_bad_length` | out | 1 | one-cycle strobe: UDP length below 8, or above the octets IPv4 delivered | REQ-703 |
| `error_udp_port` | out | 1 | one-cycle strobe: the destination port is not accepted | REQ-704 |

### 4.3 Configuration inputs

M17 reads **two** fields of the `Config` record (requirements.md §9.1), as
scalars, exactly as architecture.md §6.4.3 routes them.

| Field | Effect | When a change takes effect (REQ-803) |
|---|---|---|
| `cfg_listen_port` | REQ-704's accepted destination port when `cfg_accept_all_ports` = 0 | sampled on the input word carrying UDP octets 0–7 — input word 0 — which is the cycle the port test is evaluated. A change landing at least one cycle before that word applies to that datagram; a change landing on the word itself is deliberately unconstrained (§6.3 item 5) |
| `cfg_accept_all_ports` | 1 removes the port test from REQ-704 entirely; the listen port is then irrelevant | same word, same rule |

Both are sampled on **one** cycle, and the whole port decision is a function of
that one cycle's values, so a configuration change can never land inside a port
test: either the datagram is judged wholly by the old values or wholly by the new
ones. That is REQ-803's "static while a frame is in flight" made structural at
this module rather than promised, and it is the same argument SPEC-M15 §4.3 makes
for its own three fields.

## 5. Parameters

**None.** REQ-506's rule — timeouts and ageing intervals must be compile-time
parameters so tests can use short values — has no instance: M17 has no timeout,
no interval and no retry. Its numeric constants (8, the field offsets of §6.1)
are pinned by RFC 768's header format and by REQ-703, and making any of them
overridable would let a test configure a protocol the programme does not have.

| Parameter | Type | Default | Range | Why a test overrides it |
|---|---|---|---|---|
| (none) | — | — | — | — |

**REQ-707 is owned in one place and stated in three, and this is the producer
half.** REQ-707 constrains the *application receive stream*: UDP payload octets
only, word-aligned per REQ-021, `tuser`[0] propagated per REQ-007, and no
`tready`. Every octet on that stream is produced here, and M19 and M20 relay it
without touching a field (SPEC-M19 §6.1, SPEC-M20 §6.1), so **M17 owns the
requirement and the two wrappers own nothing of it** — this is not a two-half
split like REQ-610's or REQ-807's, and `traceability.md`'s REQ-707 row names M17
alone for that reason. The distinction matters at sign-off: `SO-udp_ip_rx_64.md`
claims REQ-707 whole, and no wrapper's packet may claim any part of it.

## 6. Behaviour

### 6.1 Normal path

**The UDP header M17 reads**, with the octet offsets and widths a test writer
needs to hand-assemble stimulus without RFC 768 open. Offsets are from UDP
octet 0, which is IPv4 payload octet 0 — the first octet after the 20-octet IPv4
header, which is where M14 puts it (REQ-021, SPEC-M14 §6.1).

| Field | Octet offset | Width | Record field | Checked against |
|---|---|---|---|---|
| source port | 0–1 | 16 bits | `hdr_src_port` | any |
| destination port | 2–3 | 16 bits | `hdr_dst_port` | `cfg_listen_port`, unless `cfg_accept_all_ports` = 1 (REQ-704) |
| length | 4–5 | 16 bits | `hdr_length` | ≥ **8**, and ≤ the octets IPv4 delivered (REQ-703) |
| checksum | 6–7 | 16 bits | `hdr_checksum` | **nothing** — carried, never verified (REQ-702) |

Every multi-octet field is presented as a **numeric value with the first wire
octet most significant** (REQ-012): a destination port of 0x1F 0x90 reads 8080,
and a length of 0x00 0x1A reads 26.

**The whole UDP header is input word 0**, which is the single fact that shapes
this module: eight octets, four fields, one word, no field split across a word
boundary and no field whose decode has to wait. Compare M14, where the header
spans three words and the destination address sits at the head of the word the
realignment splits.

| Input word | Octet positions 0 … 7 |
|---|---|
| 0 | source port (0–1), destination port (2–3), length (4–5), checksum (6–7) |
| m ≥ 1 | UDP payload octets 8m − 8 … 8m − 1 |

**Emitting the payload (REQ-021, REQ-707).** Application word j **is** input word
j + 1, octet for octet and position for position: payload octet i is emitted at
`payload_tdata` position i mod 8 of application word ⌊i / 8⌋, which is exactly
where it arrived. The payload stops at **length − 8** octets, whatever the frame
carries after that; `payload_tkeep` marks exactly the octets that exist on the
last word. In practice nothing follows, because M14 has already delivered exactly
total length − 20 octets and REQ-703 requires length − 8 ≤ that — so unlike M06
and M14 this module has no padding to consume in the accepted case, and its
`Tail` state exists only for the datagram whose UDP length under-declares what
IPv4 delivered.

**Opening and closing a datagram.** A datagram is **open** from the cycle M17
sees an `ip_hdr_valid` pulse until the earliest of: the input payload `tlast`
word; the next `ip_hdr_valid` pulse; or `clear` (REQ-009). This is SPEC-M03 §9's
closure-list device as SPEC-M10 §6.1 and SPEC-M14 §6.1 apply it upstream, and it
is what makes each report a function of the datagram rather than of whatever
follows it. The "next `ip_hdr_valid`" clause is not a hedge: an IPv4 datagram of
total length exactly 20 has no payload frame at all (requirements.md §0.7,
SPEC-M14 §6.2's `Header` row) and is closed that way.

**On a gapless stimulus**, with Ci the cycle of the input word carrying UDP
octet 0 — the first cycle after the opening `ip_hdr_valid` pulse with
`ip_payload_tvalid` = 1:

- input word m is presented on cycle **Ci + m**;
- `hdr_valid` pulses on cycle **Ci + 1** for an accepted datagram, and every
  strobe of a datagram rejected on its header pulses on that same cycle (§9);
- application word j is emitted on cycle **Ci + 2 + j**.

`hdr_valid` therefore falls **exactly one cycle before** that datagram's first
application word, which satisfies REQ-701's "on or before" with one cycle to
spare and gives the application a whole cycle to act on the record — the same
lead SPEC-M06 §7 gives M08 and SPEC-M14 §7 gives this module. **Phase 2's feed
handler is written against that lead**, so it is normative here and not
incidental (architecture.md §9).

**Cycle by cycle, the datagram a minimum-length Ethernet frame produces.** A
64-octet Ethernet frame carrying an IPv4 datagram of total length 46 — REQ-708's
own stimulus — reaches M17 as a 26-octet payload in 4 words (three with
`tkeep` = 0xFF, one with `tkeep` = 0x03 and `tlast` = 1) and delivers
26 − 8 = **18** application octets in 3 words.

| Cycle | Input | Output |
|---|---|---|
| H | `ip_hdr_valid` = 1 (the datagram opens) | `hdr_valid` = 0, both strobes 0 |
| Ci = H+1 | input word 0: UDP octets 0–7 (the whole header) | nothing yet |
| **Ci+1** | input word 1: octets 8–15 (payload 0–7) | **`hdr_valid` = 1**, all four fields |
| Ci+2 | input word 2: octets 16–23 (payload 8–15) | application word 0: payload octets 0–7, `tkeep` = 0xFF |
| Ci+3 | input word 3: octets 24–25 (payload 16–17), `tkeep` = 0x03, `tlast` = 1 | application word 1: payload octets 8–15 |
| Ci+4 | idle | application word 2: payload octets 16–17, `tkeep` = 0x03, `tlast` = 1, `tuser`[0] = the input `tlast` word's `tuser`[0] |
| Ci+5 onward | idle | `payload_tvalid` = 0 |

**The last application word is not emitted early, and that is REQ-005 rather than
pedantry.** Payload octets 16–17 arrive in input word 3 at Ci + 3 and leave at
Ci + 4 — one cycle later, not zero — because payload octet 16's input octet time
is 8(Ci+3) + 0 = 8Ci + 24 and constant latency fixes its output octet time at
8Ci + 32, which is position 0 of cycle Ci + 4. An implementation that emitted it
at Ci + 3 because it happened to hold every octet would have length-dependent
latency and would fail REQ-005's per-octet tagger. This is the same argument
SPEC-M14 §6.1 makes at its own last word, one header down.

**When the abort bit is available, and what M17 emits when it is not (REQ-007,
REQ-013).** Let N be the octets the IPv4 layer delivered and N′ the UDP length.
The input has K = ⌈N/8⌉ words and the application frame has M = ⌈(N′ − 8)/8⌉
words, so at every length that produces an application frame at all (N′ ≥ 9)
M = ⌈N′/8⌉ − 1. The input `tlast` is presented on cycle **Ci + K − 1** and the
application `tlast` word — index M − 1 — leaves on **Ci + M + 1**, so the two
events are separated by

> (Ci + M + 1) − (Ci + K − 1) = ⌈N′/8⌉ − ⌈N/8⌉ + 1 cycles,

and a **registered** output (§7) can carry the bit only where that number is
positive — that is, only where **⌈N′/8⌉ = ⌈N/8⌉**. Writing
**D = ⌈N/8⌉ − ⌈N′/8⌉ ≥ 0**, the datagram's **word-count deficit**, three regimes
exhaust the datagrams that produce an application frame under an
**under**-declared or exact length:

| Regime | Application `tlast` vs input `tlast` | The abort bit |
|---|---|---|
| **D = 0**, which includes every fully delivered datagram (N′ = N) | one cycle **after** | available; **copied** from the input `tlast` word. The margin is exactly zero |
| **D = 1** | the **same** cycle | not available to a registered output |
| **D ≥ 2** | D − 1 cycles **before** — up to **182** at N = 1480, N′ = 9 | not available to any implementation |

For N′ = N the deficit is zero at every residue — writing N = 8q + r,
⌈(N − 8)/8⌉ = q − 1 + ⌈r/8⌉ and K = q + ⌈r/8⌉, so M + 1 = K exactly — which is
why a fully delivered datagram's bit is available on the cycle it is needed and
not before. **That equality is the whole of what this argument proves**, and the
scope matters: N′ ≤ N gives M ≤ ⌈(N − 8)/8⌉, *not* ≥, so the residue algebra
reaches the D = 0 case and no further. It does not reach the `Tail` class, and an
earlier draft of this paragraph that claimed it did ran the inequality the wrong
way (dv_lead, WO-0020 Return log **F-1**).

**D is a deficit in words, not in octets, and a bench computes it as one.** A
datagram can under-declare by a single octet and be in the D = 1 class
(N = 25, N′ = 24: ⌈25/8⌉ = 4, ⌈24/8⌉ = 3), and it can under-declare by as many as
seven and stay in D = 0 (N = 32, N′ = 25: both ceilings are 4). N − N′ decides
nothing by itself; §8 drives one datagram of each kind.

**Outcome for the `Tail` class (D ≥ 1): `tuser`[0] = 0 on the application `tlast`
word.** It is not a copy and it is not a guess. 0 is the value the bit *has* at
the instant that word is emitted — "no abort has been observed for this datagram
so far" — and it is the only value M17 can derive from what it has seen; marking
1 instead would abort every conformant under-declaring datagram, which §6.2's
`Tail` row makes a legal, silent and correct case. §6.2's `Payload` and `Tail`
rows state it, §10's hook asserts it, and §11.4 records what it costs REQ-007's
universal and what the alternative would cost.

**An over-declared length (N′ > N) never reaches this question.** It is REQ-703's
error: the application frame is closed by the input `tlast` instead, on the word
carrying the last octet that arrived — application word K − 2, emitted at
Ci + K, one cycle *after* the input `tlast` — and it is marked `tuser`[0] = 1 by
§9's own rule rather than by inheritance.

**Gapped stimulus.** A cycle carrying no payload word holds every state and every
register: it is not a condition, it advances no word index, and it delays every
later octet by exactly 8 octet times per cycle (REQ-016). The cycle formulas
above hold on a gapless stimulus; the **per-octet constant L = 8** of §7 holds on
every stimulus, and that is what a bench asserts. **M17 has no second constant to
confuse with it**: unlike SPEC-M14 §7's parse latency, which is measured between
an input word and an output pulse and therefore grows when idle lands inside the
header (carry-forward **C-27**), M17's header is one word, so no idle cycle can
land *inside* it and `hdr_valid` sits one cycle behind that word at every
stimulus. The distinction is stated rather than left for a bench to discover.

**When `ip_hdr_valid` opens a datagram with no payload frame.** M14 emits a
header record with no payload frame for an IPv4 datagram of total length 20
(requirements.md §0.7, SPEC-M14 §6.2). Such a datagram carries **zero** UDP
octets: no header can be decoded, no `hdr_valid` pulses, no application word is
emitted, and the datagram is closed by the next `ip_hdr_valid` pulse and reported
one cycle after it with a single `error_udp_bad_length` pulse (§9) — the strobe
REQ-703 names for a length that cannot be read at all, which a datagram of zero
UDP octets certainly has. This is the device SPEC-M14 §6.1 uses for the same case
one header up.

### 6.2 State machine

Reset state and `clear` state are both `Idle`. **The state machine advances on
the input side**; the output is the fixed-delay pipeline of §7 running behind it.

| State | Entered when | Does | Leaves to |
|---|---|---|---|
| `Idle` | reset; `clear`; the input `tlast` of the previous datagram; an `ip_hdr_valid` pulse that ends a payload-less datagram | ignores the payload stream; `hdr_valid` = 0, `payload_tvalid` = 0, both strobes 0 | `Header` on an `ip_hdr_valid` pulse (the datagram opens) |
| `Header` | an `ip_hdr_valid` pulse | captures UDP octets 0–7 into the four field registers from input word 0; evaluates REQ-703's length-below-8 test and REQ-704's port test on that word; makes the one report of §6.1 on cycle Ci + 1 | `Payload` on the report cycle if the datagram was accepted, its length exceeds 8 and at least one payload octet was delivered; `Idle` on the report cycle if it was rejected, if its length is exactly 8 (no payload octets, requirements.md §0.7), if the frame closed before the 8-octet header completed, or if the frame closed before any payload octet was delivered |
| `Payload` | the header was accepted with a non-empty payload of which at least one octet arrived | forwards payload octets at the fixed delay of §7, counting them against length − 8; marks `payload_tlast` on the word carrying the last of them, with `tkeep` marking exactly the octets that exist and `tuser`[0] **copied from the input `tlast` word where that word has already been presented — §6.1's D = 0 class, which includes every fully delivered datagram — and driven to 0 where the declared count completes first (D ≥ 1, the `Tail` class; §6.1, §11.4). The copy is conditional and the condition is D, not the datagram's length** — or, where the frame closed before the declared count, on the word carrying the last octet that arrived, with `tuser`[0] = 1 (§9) | `Idle` on the input `tlast` — the state leaves immediately and the pipeline drains behind it; `Tail` if the declared count completes while the frame still runs |
| `Tail` | the declared payload has been delivered and the frame has not ended — a UDP length that **under**-declares what IPv4 delivered | ignores every remaining input octet, emits nothing, pulses nothing. REQ-703 makes only an *over*-declared length an error, so this datagram is accepted and its surplus octets are dropped. **This state is entered on the input word carrying the declared count's last octet — input word M, one cycle before the application `tlast` word leaves. The input `tlast` word arrives on the cycle that application word leaves at the earliest (D = 1) and up to 182 cycles later (D ≥ 2), so its `tuser`[0] is never on the application `tlast` word: the abort bit of a `Tail`-class datagram is 0 whatever the input eventually carries** (§6.1, §11.4). **This state and §6.1's D ≥ 1 are the same class**, because `Tail` is entered exactly when input word M precedes the input `tlast` word, which is M + 1 < K | `Idle` on the input `tlast`; `Header` on an `ip_hdr_valid` pulse |

An input cycle carrying no payload word holds every state and every register: it
is not a condition and it advances nothing (§6.1).

`clear` asserted in any state abandons the datagram: no record, no application
`tlast`, no strobe, straight to `Idle` (REQ-009, §7).

**`Tail` is not dead code and the case is worth naming**, because a reader who
knows that M14 delivers exactly total length − 20 octets may think a UDP length
below that is unreachable. It is not: nothing in the programme obliges a *sender*
to fill its IPv4 datagram, and REQ-703 makes only the over-declaring direction an
error. A datagram whose IPv4 total length is 46 and whose UDP length is 20
delivers 12 application octets and drops 6, silently and correctly — no strobe,
because no condition applies. §8's directed set drives it.

### 6.3 Deliberately unconstrained

Anything not listed here is constrained by this specification, and a test may
rely on it.

1. **The placement of the register levels** inside the two-cycle pipeline and
   every internal encoding: the FSM state encoding, whether the header is
   captured into one register or four, whether the delivered-octet count is a
   counter or is derived from the word index and `tkeep`. §7's constants are what
   is fixed.
2. **The value of the four `hdr` fields on cycles where `hdr_valid` = 0**, the
   value of `payload_tdata` at positions where `payload_tkeep` is 0, and every
   output field on a cycle with `payload_tvalid` = 0 (SPEC-M01 §6.3 item 5). No
   monitor may read them.
3. **Everything about the checksum field except that it is carried.** REQ-702
   forbids verification, so M17 neither compares `hdr_checksum` against anything
   nor treats 0x0000 differently from any other value, and DV SHALL assert
   nothing about a datagram's fate as a function of its checksum. What *is*
   constrained is that the field arrives at `hdr_checksum` unchanged (§6.1).
4. **M17's response to a payload stream that violates REQ-011 or REQ-015** — a
   word with `tvalid` = 1 and `tkeep` = 0, a `tlast` with no preceding
   `ip_hdr_valid`, a non-contiguous `tkeep`. Its producer is M14, relayed by M16,
   neither of which can emit any of them (SPEC-M14 §7, SPEC-M16 §7), so no
   requirement names the case and DV SHALL assert nothing about it.
5. **The outcome of changing either configuration input on the exact cycle of the
   input word that samples them** (§4.3, input word 0). §4.3 governs a change
   landing at least one cycle earlier; the same-cycle case is left open there and
   is left open deliberately here. A bench that changes a configuration input on
   the sampling word's own cycle and asserts either outcome is flaky by
   construction and SHALL NOT be written. This is carry-forward **C-14.5**'s rule
   applied to this module.
6. **M17's response to an `ip_hdr_valid` pulse whose `ip_hdr_protocol` is not
   17.** M14 discards a non-UDP datagram before any word is emitted (REQ-607), so
   this port receives only protocol 17; M17 does not re-check it (§4.2) and DV
   SHALL assert nothing about a datagram delivered here with any other value.

## 7. Timing contract

- **Latency.** Front offset **h = 8** octet times: M17 removes eight octets from
  the front of the datagram and its input is word-aligned (REQ-021), so §0.5's
  second term is 0 and h is exactly the header length. The pinned per-octet
  constant is

  | Quantity | Value |
  |---|---|
  | L (octet times) | **8** |
  | h (octet times) | **8** |
  | Word delay ΔC = (L + h)/8 | **2** cycles |
  | §1.1 ceiling | **4** cycles |

  (L + h) = 16, a multiple of 8 as requirements.md §0.5 requires. There is one
  constant and not two: M17 sees no XGMII, so §0.5's start-lane pair has no
  instance here and L is a single value.

  **The two measurement events**, named explicitly: the input event is the octet
  time, on the `ip_payload` stream, of the octet being measured; the output event
  is the octet time of that same octet on the `payload` stream. For the word
  delay the two events are the cycle of the input word carrying UDP octet 0 and
  the cycle of the datagram's first application word — the previous stage's
  output word and this stage's, which is what makes ΔC additive along the chain
  (§0.5). Checked both ways, as §0.5 exists to allow: payload octet i enters at
  octet time 8Ci + 8 + i and leaves at 8Ci + 16 + i, so L = 8 for every octet;
  and ΔC = (Ci + 2) − Ci = 2, which equals (8 + 8)/8. The two routes agree.

  **Two cycles is what the octet mapping produces, and the other two are
  reserve.** Application word 0 **is** input word 1, which arrives at Ci + 1, and
  a registered output emits it at Ci + 2; nothing cheaper exists without making
  `payload_tdata` a combinational function of `ip_payload_tdata`, which is the
  shape SPEC-M14 §7 rejects for itself and this specification rejects for the
  same reason. requirements.md §1.1 allocates M17 a ceiling of **4**, so this
  specification pins **two** cycles inside its own allocation — the largest
  reserve of any stage on the chain, and larger than M03's one and M14's one
  together. §11.2 records why that is a decision and not an accident: the
  allocation was written before anyone had noticed that the UDP header is the
  one header on the chain that is a whole number of words, and a stage with no
  realignment to do costs two cycles less than a stage that has one.

- **Header-record latency**, stated separately because REQ-701 asks for the
  `valid` timing and a reader should not have to derive it: **1 cycle** from the
  input word carrying UDP octet 0 to the cycle on which `hdr_valid` asserts, one
  cycle less than the payload's word delay, which is what puts `hdr_valid` one
  cycle before application word 0 (§6.1). **Unlike SPEC-M14 §7's parse latency,
  this figure is gap-invariant**: M14's grows when an idle cycle lands between
  the input words of its three-word header (carry-forward **C-27**), and M17's
  header is one word, so there is nowhere for such a cycle to land. A bench may
  assert this figure under idle injection at any depth. It is not a second
  constant to be careful with; it is the same constant seen one cycle earlier.

- **Throughput.** One input word accepted every cycle, unconditionally and with
  no handshake (REQ-003). At most one application word emitted per cycle, and
  never more than one per input word: M17 removes exactly one word's worth of
  octets and therefore emits exactly **one fewer** word than it consumes for
  every datagram, which is why no backpressure is needed anywhere and why a
  datagram whose first word arrives on the cycle after the previous datagram's
  `tlast` cannot collide at the output.

- **Handshake rules.** `payload_tvalid` = 1 exactly on cycles carrying
  application octets. `payload_tkeep` is `0xFF` except on the `tlast` word, where
  it is 1 to 8 contiguous ones. `payload_tlast` = 1 on the word carrying the
  payload's last octet, that word included in the frame's word count (REQ-015); a
  one-word application frame is legal and is the mandatory encoding of a payload
  of 1 to 8 octets. `payload_tuser`[0] is meaningful only on the `tlast` word.

  `hdr_valid` is high for **exactly one cycle per accepted datagram**, on the
  cycle before that datagram's first application word, and the four field values
  are valid only on that cycle (§6.3 item 2). For a datagram of length exactly 8
  it pulses on the same cycle it would have anyway and **no application frame
  follows**: every consumer of this record SHALL tolerate a header with no
  payload frame (requirements.md §0.7, REQ-707). Phase 2's feed handler is that
  consumer, and this sentence is the one it is written against.

  **`Udp_header`'s `valid` has a receive discipline and no transmit instance.**
  REQ-701 makes it a one-cycle pulse here; unlike `Eth_header`, `Ip_header` and
  `Arp_packet` there is no port anywhere in Phase 1 at which this record is held
  as a level, because the transmit side builds its UDP header from a
  `Udp_tx_request` and never from a `Udp_header` (SPEC-M18 §4.1, ADR-0008). A
  monitor for this record therefore needs no discipline parameter at all — it is
  the one M01 header record for which the direction question does not arise
  (SPEC-M10 §11.4, SPEC-M06 §11.3).

  Idle gaps on the input (REQ-016) delay everything by exactly 8 octet times per
  cycle and change nothing else.

- **Reset.** While `clear` = 1 and on the first cycle after it returns to 0:
  `payload_tvalid` = 0, `hdr_valid` = 0, both strobes 0, state `Idle`, the
  captured header fields irrelevant because the next datagram overwrites them.
  `clear` asserted inside an open datagram abandons it with **no `tlast` and no
  strobe** — the one place in this specification where a datagram vanishes
  without a report, permitted by REQ-009 and not by REQ-008, and the reason §8
  criterion 1 carries a conservation exemption. A datagram whose `ip_hdr_valid`
  pulse arrives on the first cycle after `clear` returns to 0 is parsed
  correctly.

- **Configuration sampling.** §4.3's table: both inputs on the input word
  carrying UDP octets 0–7, which is input word 0. A change landing on that word's
  own cycle is unconstrained (§6.3 item 5).

## 8. Line-rate stress obligation

**Mandatory: M17 is in requirements.md §0.4's stress-bench list** (M03, M06,
M08, M10, M14, M17, M20).

**Stimulus, derived by construction from the XGMII case and not re-invented**
(REQ-004's own rule for a module that does not see XGMII). Drive M17's `ip_hdr`
and `ip_payload` ports with exactly what M14 emits on its `ip_*` ports — relayed
unchanged by M16 (SPEC-M16 §6.1) — when M03 is driven by SPEC-M03 §8's stress run
and M14 by SPEC-M14 §8's:

- 10 000 consecutive datagrams, each the IPv4 payload of a **64-octet** Ethernet
  frame carrying an IPv4 datagram of total length 46, which M14 delivers as a
  **26-octet payload in 4 words** (three with `tkeep` = 0xFF, one with
  `tkeep` = 0x03 and `tlast` = 1);
- one `ip_hdr_valid` pulse per datagram, exactly one cycle before that
  datagram's first payload word (SPEC-M14 §7, preserved by SPEC-M16 §7);
- the four words of a datagram occupy **consecutive cycles**, and **between
  datagrams 6 and 7 idle cycles alternately**: M03's start characters alternate
  lane 0 and lane 4 at 10 and 11 cycles apart (REQ-004, requirements.md §0.3),
  four of those cycles carry payload words at this port, leaving 6 and 7. The
  figure is counted **on the payload stream** and the header pulse falls inside
  the idle run, one cycle before payload word 0 — it does not occupy a fifth
  cycle of the payload stream, and reading it as one would give 5 and 6. **6 and
  7 is the operative figure**, and the arithmetic is stated because SPEC-M10 §8
  had to correct exactly this reading at its own port (dv_lead, WO-0015 Return
  log §6 item 1). Idle gaps are preserved rather than closed up;
- **datagram contents**, chosen so that a stuck field register cannot pass:
  source port n modulo 65 536, **destination port equal to `cfg_listen_port`**
  with `cfg_accept_all_ports` = 0, **length 26** — REQ-708's own figure, 8 octets
  of UDP header plus 18 of payload, which fills the 46-octet IPv4 datagram
  exactly and leaves nothing for the `Tail` state — a checksum of
  0xBEEF (a deliberately **wrong** non-zero value, which REQ-702 requires to be
  delivered unchanged and which a design that verified the checksum would
  discard: the stress run is where that would show as 10 000 losses rather than
  as one directed failure), and 18 octets of UDP payload whose **first four
  octets carry a 32-bit sequence number** (REQ-020, REQ-708);
- `ip_payload_tuser`[0] = 0 on every `tlast` word. **Error injection rate: zero
  in this run** — every rejection class is a directed test below, because
  REQ-004's conservation criterion is stated over the datagrams the module
  accepts.

Note for the bench writer: the sequence number at UDP payload octets 0–3 lands in
`payload_tdata`[31:0] of **application word 0**, which is the simplest position
it occupies anywhere in the programme — at M14 the same four octets are in the
middle of payload word 1 (SPEC-M14 §8). If the sequence numbers are right here
and wrong at M14, the fault is between the two modules; if they are wrong at
both, it is upstream of M14.

**Checks.**

1. 10 000 application frames out for 10 000 datagrams in, 10 000 `hdr_valid`
   pulses, each exactly one cycle; no word dropped; frame conservation holds
   (requirements.md §0.6), with no strobe pulsing anywhere in the run.

   **The one exemption that monitor needs, and where it bites** (ledger **C-2**,
   applied here before the fact rather than after it; the wording model is
   SPEC-M10 §8 criterion 1 and SPEC-M14 §8 criterion 1, which carry the same
   exemption one and two stages up). §0.6 says the conservation monitor is active
   in **every** bench, and §10 commissions a mid-datagram `clear` test at this
   module — in which a datagram is opened and, correctly, never reported (§7).
   A monitor asserting conservation without a `clear` exemption counts that
   datagram as a silent discard and fails a conformant M17. In the stress run
   itself the exemption never fires — `clear` is not asserted — so criterion 1
   stands exactly as written for all 10 000 datagrams.
2. The 18 delivered payload octets of every datagram compare equal to input
   octets 8–25, and the sequence numbers arrive as 0, 1, 2, … with no gap and no
   repeat (REQ-020).
3. Per-octet latency is constant and equals **8** octet times for every octet of
   all 10 000 datagrams (REQ-005, REQ-019) — one value, not a mean, and converted
   to ΔC = (8 + 8)/8 = 2 against the §1.1 ceiling of 4 in the sign-off packet,
   with the two cycles of reserve reported as reserve rather than as slack (§7).
4. Every `hdr_valid` pulse carries the four fields of the datagram whose first
   application word follows on the next cycle, the interval from input word 0 to
   that pulse equals **1** cycle for all 10 000, and `hdr_checksum` equals
   0xBEEF on every one of them — the strongest single check that REQ-702 is
   implemented as stated rather than as an oversight.
5. The module exposes no `tready` on either stream under test. This is structural
   (REQ-003, REQ-707, REQ-805, §4.1) — a statement about the type, not an
   assertion that could fail.

**Directed datagrams alongside the stress run**, each inside a 64-octet Ethernet
frame unless its own length forbids it:

- **one per rejection class** (§9): UDP length 0 and UDP length 7 (no application
  frame, one `error_udp_bad_length` each, no `hdr_valid`); a UDP length one octet
  longer than the IPv4 layer delivered (abort plus strobe); a destination port
  that is neither `cfg_listen_port` nor accepted by `cfg_accept_all_ports` (one
  `error_udp_port`, no record, no word);
- **the port filter's three cases** (REQ-704): matching port, non-matching port,
  and non-matching port with `cfg_accept_all_ports` = 1 — the last delivering the
  datagram with its foreign port carried unchanged in `hdr_dst_port`;
- **UDP length exactly 8** (requirements.md §0.7): `hdr_valid` pulses, **no**
  application frame, **no** strobe. This is the case a bench most easily confuses
  with the length-7 case above it, which pulses a strobe and no record;
- **an IPv4 header record with no payload frame** — an IPv4 datagram of total
  length 20 routed here (SPEC-M14 §6.2): no `hdr_valid`, no application word,
  exactly one `error_udp_bad_length` pulse one cycle after the *next*
  `ip_hdr_valid`, and the next datagram parsed intact;
- **the truncation band, 1 to 7 delivered octets beyond the header** — UDP
  lengths 9 through 15 against an IPv4 payload that delivers only 9 through 15
  octets is *not* the band; the band is a **UDP length that over-declares**, so
  drive UDP length 26 against an IPv4 payload of 9 … 15 octets, one frame each.
  Each emits one application word carrying the 1 to 7 octets that arrived, with
  `tkeep` marking exactly them, `tlast` = 1, `tuser`[0] = 1, and one
  `error_udp_bad_length`. This is carry-forward **C-26**'s lesson applied before
  the fact rather than after it: the extensional branch is what §9 states and
  this set is what fixes it in a test;
- **UDP length 26 against an IPv4 payload of exactly 8 octets**: the UDP header
  is complete, zero payload octets were delivered, so **no** `hdr_valid`, no
  application word and one `error_udp_bad_length` — the boundary case §9 decides,
  and the analogue of SPEC-M14 §9's exactly-20-delivered case;
- **UDP lengths 8 through 16 inclusive, plus 1472** (REQ-021, REQ-703, REQ-011).
  Lengths 9 … 15 give payloads of 1 … 7 octets and cover every residue modulo 8;
  length **16** is what covers the `0xFF` `tkeep` pattern, because a payload of 0
  emits no word at all and the full-word pattern needs a payload length that is a
  positive multiple of 8. *This is carry-forward C-17(e)'s lesson, applied at the
  third stripping stage after M06 needed it and M14 anticipated it.* Length 1472
  is the maximum the chain admits — 1500 less the 20-octet IPv4 header less the
  8-octet UDP header — and gives a 1464-octet payload in 183 words;
- **an under-declaring length** (§6.2's `Tail` state): IPv4 total length 46 with
  UDP length 20, asserting 12 application octets delivered, `tlast` on the second
  word with `tkeep` = 0x0F, **no strobe**, and the six surplus octets dropped.
  This datagram is §6.1's **D = 1** case — N = 26, N′ = 20, ⌈26/8⌉ = 4 against
  ⌈20/8⌉ = 3 — so **drive it twice, once with `ip_payload_tuser`[0] = 0 on the
  input `tlast` word and once with 1, and assert `payload_tuser`[0] = 0 on the
  application `tlast` word and no strobe both times.** The bit is derived, not
  copied, and this is the assertion that fixes it in a test rather than in prose
  (§6.1, §6.2, §11.4);
- **the D boundary from the other side, so the class is bounded rather than
  named**: IPv4 total length 52 with UDP length 25 — N = 32, N′ = 25, both
  ceilings 4, so **D = 0** although the datagram under-declares by **seven**
  octets. Assert 17 application octets in three words, `tlast` on the third with
  `tkeep` = 0x01, **no strobe**, the seven surplus octets dropped, and
  `payload_tuser`[0] **equal to the input `tlast` word's** — driven 1 on one run
  and 0 on another. A design that keyed the copy on "the length under-declares"
  rather than on D fails this datagram and passes the one above it;
- **a bad UDP checksum** (REQ-702): a datagram with a deliberately wrong non-zero
  checksum, delivered with no abort bit and no strobe, its checksum carried
  unchanged in `hdr_checksum`;
- **one datagram failing two conditions at once** — a UDP length below 8 *and* a
  foreign destination port — asserting that **both** strobes pulse on cycle
  Ci + 1, which is the multiplicity rule §9 states and which this module copies
  from SPEC-M14 §9 at dv_lead's direction (WO-0018 answer (iii)).

## 9. Errors and discards

Strobe names are normative (requirements.md §12). M17 owns two of the
twenty-one.

| Condition | Strobe (one cycle) | Stream effect | REQ |
|---|---|---|---|
| The UDP length field is below 8, or the datagram delivered fewer than 8 octets so that no length field could be read at all | `error_udp_bad_length` | **no `hdr_valid` and no application word**; nothing is emitted for this datagram | REQ-703 |
| The UDP length exceeds the octets the IPv4 layer delivered | `error_udp_bad_length` | **if at least one payload octet was delivered**, an application frame is emitted and **aborted**: its last word carries `tuser`[0] = 1 and the `tkeep` the delivered octets imply. **If none was delivered** — a datagram delivering exactly 8 octets while declaring more — **no application frame is emitted**, `hdr_valid` does not pulse, and the strobe is the only report (requirements.md §0.6, §0.7) | REQ-703 |
| The destination port is neither `cfg_listen_port` nor accepted under `cfg_accept_all_ports` = 1 | `error_udp_port` | **no `hdr_valid` and no application word** | REQ-704 |

Silent discard is prohibited (REQ-008): every row has a strobe. The `clear`
mid-datagram case of §7 is REQ-009's, not REQ-008's.

**Strobe cycles, pinned.** The length-below-8 test and the port test are both
decidable from input word 0, which is the whole UDP header, so each pulses for
exactly one cycle on cycle **Ci + 1** — the cycle `hdr_valid` would have occupied,
and one cycle before the first application word would have left. **Both of those
rejections are therefore discards-before-emission**, cleanly, with no abort
interaction. The over-declared-length condition is decidable only at the input
`tlast` and pulses one cycle after the input word carrying it, except for a
datagram with no payload frame at all, where the closing event is the next
`ip_hdr_valid` pulse and the strobe pulses one cycle after it (§6.1, the device
SPEC-M14 §9 uses one stage up). All are computable from the input trace alone and
all lie inside requirements.md §0.6's window.

**Which conditions can co-occur on one datagram, and what then pulses.** M17
copies SPEC-M14 §9's rule exactly, at dv_lead's direction (WO-0018 answer (iii),
"batch F should copy this at M17, where REQ-703 and REQ-704 create the same
multiplicity"), and requirements.md §0.6's sentence applies with its plain force:
*"If two or more locally detected conditions apply to one frame, each applicable
condition's strobe pulses once for that frame."* So:

- **The length test and the port test are evaluated independently on the received
  header bits, and each one that holds pulses**, both on cycle Ci + 1. A datagram
  with UDP length 3 sent to a foreign port pulses `error_udp_bad_length` **and**
  `error_udp_port`. There is no precedence order and no first-match rule, and
  that is deliberate for the reason SPEC-M14 §9 gives and dv_lead endorsed as the
  stronger half of that decision: a precedence order would be **unobservable at
  the port** — one strobe looks identical whichever rule suppressed the other —
  so a bench could not distinguish a conformant design from a broken one, and
  every implementer would have to guess the order. Independent evaluation makes
  the pulse set a **function of the injected bits**, which a bench computes from
  its own stimulus.
- **A bad length does not suppress the port test and a foreign port does not
  suppress the length test.** This is the corollary a reader most often doubts,
  because an implementer's instinct is to short-circuit on the first failure;
  §8's two-condition datagram fixes the reading in a test rather than in prose.
- **One exception, and it is the only precedence rule in this section, and it is
  scoped**: a datagram that does not deliver a complete **8-octet UDP header**
  pulses `error_udp_bad_length` **alone**, and the port test is not evaluated.
  The reason is the one §0.6's word "applicable" carries: the destination port
  occupies octets 2–3, and on a datagram that delivered fewer than four octets
  those bits never arrived, so a port test would be a function of the
  implementation's reset or hold state — unobservable, and therefore
  unspecifiable. **The rule is stated over the whole 8-octet header rather than
  over the four octets the port test strictly needs**, because the length field
  at octets 4–5 is what the other condition needs and a rule with two thresholds
  is a rule a bench gets wrong; this is the scoping sentence dv_lead asked batch F
  to add when it endorsed M14's version (WO-0018 answer (iii), item 4).
- **The over-declared-length condition with the port test**: cannot occur. The
  port test rejects at Ci + 1 and nothing is emitted, so there is no delivery to
  fall short of; a rejected datagram's remaining octets are consumed and dropped
  and pulse nothing.
- **A rejection with an inherited `ip_payload_tuser`[0] = 1**: the local discard
  wins (requirements.md §0.6), no application frame is emitted, the local strobes
  pulse, and M17 pulses **nothing** extra for the inherited abort — it did not
  detect it, and re-reporting an inherited abort is forbidden.

**Aborted-and-forwarded versus discarded-before-emission.** Three of the four
rows are the second kind. The over-declared length is the only condition M17 can
detect *after* it has begun emitting, and it is then the first kind: the
application frame is completed with `tuser`[0] = 1 on its last word, which is
REQ-007's own rule and is what REQ-703 states in terms.

**Counting these strobes** (requirements.md §0.6, carry-forward C-23). Each is
one **high cycle** per datagram. The two *different* M17 strobes may be high on
the same cycle, which is the co-occurrence rule above; the *same* strobe can be
high on consecutive cycles only if two consecutive datagrams both fail the same
way, which the composed stimulus never produces (datagrams are at least ten
cycles apart at REQ-004's arrival rate) but a directed bench driving M17's ports
directly may. A monitor counts **high cycles per strobe, never rising edges**,
which is §0.6's convention and needs no exception here.

## 10. REQ coverage

| REQ | How this module satisfies it | Section | Verification hook for DV |
|---|---|---|---|
| REQ-001 | one clock; no gated or derived clock | §3 | the emitted-Verilog edge-expression check |
| REQ-003 | both streams are `Axi64.Source` with no `Dest`; no `tready` in either record | §4.1 | interface compile check |
| REQ-004 | sustains M14's output pattern — 1 header pulse, 4 words, 6 or 7 idle cycles, alternating — for 10 000 datagrams | §8 | line-rate stress bench |
| REQ-005 | fixed-delay pipeline; no application word withheld to the datagram's end; the last word is not emitted early | §6.1, §7 | per-octet latency tagger inside the stress bench; directed UDP lengths 8–16 and 1472 |
| REQ-007, REQ-013 | inherited `tuser`[0] reaches the application `tlast` word and is never acted on — **copied** where that word is emitted on or after the input `tlast` (§6.1's D = 0), **derived as 0** where the declared count completes first (D ≥ 1; §6.2, §11.4). The ultimate consumer is the application (REQ-707, ADR-0009), not this module | §3, §6.1, §6.2, §9, §11.4 | drive `tuser`[0] = 1 on an accepted **D = 0** datagram's `tlast` and assert the application frame is delivered intact with the bit set on its last word and no strobe pulses; then drive `tuser`[0] = 1 on an **under-declaring (D ≥ 1)** datagram and assert the application frame is delivered with `tuser`[0] = **0** on its last word and no strobe. The second is the class REQ-007's universal does not reach (§11.4): it is **excluded from the "bit set on its last word" assertion and given its own**, so the exclusion is tested rather than left as a silence. §8's two under-declaring datagrams are the D = 1 and D = 0 boundary pair |
| REQ-008 | three conditions, two strobes, every pulse cycle pinned, co-occurrence stated | §9 | one directed test per rejection class plus the two-condition datagram; frame-conservation monitor with §8 criterion 1's `clear` exemption |
| REQ-009 | `clear` empties the pipeline; mid-datagram `clear` abandons it silently | §7 | reset test: assert mid-datagram, deassert, open a datagram on the next cycle and assert it parses intact. The conservation monitor runs with §8 criterion 1's exemption in this test |
| REQ-010 | both streams are the programme `Axi64.Source`; both header records are SPEC-M01's, unchanged; M17 declares no record | §4.1 | interface compile check, including the first witness of `Udp_header`'s five field names |
| REQ-011 | `payload_tkeep` `0xFF` except on `tlast`, contiguous from bit 0 | §7 | protocol monitor on the application stream, every bench |
| REQ-012 | every header field decoded to a numeric value, first wire octet most significant | §6.1 | known-datagram directed test comparing all four fields against hand-computed values |
| REQ-014 | `tstrb` ignored in, driven 0 out | §4.2 | protocol monitor; REQ-014's differential run |
| REQ-015 | one `tlast` per application frame, the `tlast` word included; at most 184 words | §3, §7 | protocol monitor |
| REQ-016 | input idle cycles delay octets and change nothing else; §6.1's cycle formulas are gapless-only | §6.1, §7 | idle-injection wrapper at 0, 1 and 7 cycles, asserting the per-octet constant **L = 8** — and, unlike at M14, the 1-cycle header-record latency too, because M17's header is one word and no idle cycle can land inside it (§7) |
| REQ-019 | ΔC = 2 against a ceiling of 4, two cycles of reserve inside M17's own allocation; one word of payload storage | §7, §11.2 | ΔC computed from the pinned L and h at freeze; measured ΔC from the stress run in the sign-off packet, quoted against the ceiling of 4 |
| REQ-020 | one datagram at a time; order not expressible otherwise | §6.2 | the sequence numbers in the stress run |
| REQ-021 | payload octet 0 at `payload_tdata`[7:0] at every datagram length, **by arithmetic rather than by machinery**: the stripped header is a whole word and the input is word-aligned | §3, §6.1 | directed UDP lengths 8–16: 9–15 cover every residue modulo 8 and 16 covers the `0xFF` `tkeep` pattern (C-17(e)'s lesson) |
| REQ-606 | consumer side: `ip_hdr_valid` is treated as a one-cycle pulse opening a datagram, and a header with no payload frame is tolerated | §6.1, §7 | inject an IPv4 datagram of total length 20: exactly one `error_udp_bad_length`, no `hdr_valid`, next datagram intact |
| REQ-607 | consumer side: M17 does not re-check the protocol and asserts nothing about a datagram delivered here with another value | §4.2, §6.3 item 6 | none — stated so that no sign-off packet claims protocol coverage here |
| REQ-701 | four fields in a record whose `valid` is one cycle high, one cycle before the first application word | §6.1, §7 | known-datagram test comparing every field and the `valid` timing |
| REQ-702 | the checksum is carried and compared against nothing; 0x0000 is not special | §6.1, §6.3 item 3 | a datagram with a deliberately wrong non-zero checksum delivered with no abort bit and no strobe, plus §8 check 4's 10 000-datagram assertion that `hdr_checksum` arrives unchanged |
| REQ-703 | length below 8 and length above the delivered octets each pulse `error_udp_bad_length`; exactly length − 8 octets delivered otherwise; length exactly 8 emits a record and no frame | §6.1, §6.2, §9 | lengths 0, 7, 8, one octet over the delivered count, the 1-to-7-delivered band, the exactly-8-delivered boundary, and three correct lengths |
| REQ-704 | destination port compared against `cfg_listen_port` unless `cfg_accept_all_ports` = 1; rejection pulses `error_udp_port` and emits nothing | §4.3, §6.1, §9 | matching port, non-matching port, non-matching port with accept-all enabled |
| REQ-707 (whole) | the application receive stream carries UDP payload octets only, word-aligned, with `tuser`[0] propagated and **no** `tready` in the type | §4.1, §5, §6.1 | interface compile check for the absence of `tready`; end-to-end payload comparison at the application boundary; `tuser`[0] propagation from an injected bad-FCS frame; one zero-payload datagram asserting a header record and no application word. **M19 and M20 relay this stream and claim no part of REQ-707** (§5) |
| REQ-708 | contributes but does not own: M17 produces the stream REQ-708 measures, and the measurement is at M19's and M20's ports | §8 | none of its own — SPEC-M19 §8 and SPEC-M20 §8 own it. Stated so that no sign-off packet claims application-boundary line rate at this module |
| REQ-805 | the obligation on the consumer is visible in this module's output type and nowhere else in Phase 1 | §4.1 | interface compile check. The second sentence of REQ-805 binds Phase 2 and has no Phase-1 observable, which requirements.md states rather than pretends away |
| REQ-802, REQ-803 | two configuration inputs, each sampled on input word 0; the same-cycle change unconstrained | §4.3, §6.3 item 5 | change `cfg_listen_port` between two datagrams and assert the port filter follows it at the next datagram, not the one in flight |
| REQ-810 | no instance: REQ-810's receive half is M03's (SPEC-M03 §4.3), and M17 reads no enable | §4.3 | none — stated so that no sign-off packet claims coverage here |
| REQ-901 | **no divergence class lives here.** The reference does not verify the UDP receive checksum either, so this comparison boundary excludes nothing | header, §2 | the co-simulation report names this boundary with an empty exclusion list |
| REQ-903, REQ-808 | `udp_ip_rx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli` | §4.1 | repository surface check and the `rtl_snapshots/` name comparison |

This table is the source of M17's rows in [`traceability.md`](../traceability.md),
updated in the same commit.

## 11. Deferred items

Item numbers are permanent; a closed item keeps its row (SPEC-TEMPLATE §11).

| # | Item | Status · what a reader assumes meanwhile | Tracked as | Owner | Closes by |
|---|---|---|---|---|---|
| 11.1 | **The `ifc_check` compile evidence for this lift is pending**: `udp_ip_rx_64_ifc.ml` is new in this commit and carries the first compile-time witness of `Udp_header`'s five field names — the record was frozen at f78766e with no user until this batch, exactly as `Ip_header` was until batch E. | **CLOSED (WO-0022).** CI `build` run **30744579228** at **d8df28d** reports `success` with all twenty lifts in it, this one included, and the run's head SHA **is** this specification's freeze SHA — so the text frozen here and the text that elaborated are the same tree and no witnessing argument is owed. The witness of `Udp_header`'s five field names compiled on its first run. `tools/check_records_vs_appendix.sh` re-passes the byte-identity check on every later commit, this one included. | the `Interface compile check` row of §12 | architect_docs_lead, rtl_lead | closed |
| 11.2 | **M17 pins ΔC = 2 against a §1.1 ceiling of 4**, so it holds **two** cycles of reserve — the largest of any stage on the receive chain, and more than M03's one and M14's one together. | **DEFERRED — the number is decided and buildable, and the reserve is deliberate.** A reader implements ΔC = 2 today, and §7 gives the argument that two is the minimum with a registered output. The reserve exists because §1.1's allocation was written before any specification had observed that the UDP header is the **one header on the chain that is a whole number of datapath words**: a stage with no realignment to perform costs about two cycles less than one that has it, and the allocation charged M17 as though it did. The reserve is **M17's own allocation**: a later revision to ΔC = 3 or 4 is an ordinary spec diff to §7 with §1.1 and architecture.md §4 untouched, whereas going beyond 4 would be a slack release and would change both copies of the allocation table. **Re-allocating the two cycles to another stage is deliberately not done here** — it would move a number three documents cite for the benefit of a stage that has not asked for it. | this item; requirements.md §1.1; SPEC-M20 §7 | architect_docs_lead | M17's `P1-module-ready` |
| 11.3 | **The application receives no IPv4 metadata.** `Udp_header` carries the four UDP fields and nothing else, so the source IP address of a datagram — which a Phase-2 feed handler may legitimately want, to distinguish two multicast sources — reaches no port of M20. M17 reads `ip_hdr_src_ip` and drops it (§4.2). | **DEFERRED — Phase 1 needs none of it and nothing is blocked.** A reader wires `ip_hdr_src_ip` to nothing today. REQ-701 enumerates the record's four fields and REQ-707 says the application stream carries "UDP payload octets only", so both are satisfied as written; no Phase-1 requirement asks for the address and no Phase-1 bench can observe its absence. If Phase 2's feed handler needs it, the repair is a **new** record at M17's output or an added field on `Udp_header` — the second being a post-freeze change to SPEC-M01 §4.1 and therefore breaking, so the first is the one to cost first — plus a REQ in the 700 block. Recorded now, before anyone assumes it is there. | this item; architecture.md §9 | architect_docs_lead | Phase-2 scoping (E2) |
| 11.4 | **REQ-007's universal does not reach the datagram whose UDP length under-declares the delivered octet count by at least one word** (§6.1's D ≥ 1). REQ-007 reads "every downstream module that emits an output frame for it SHALL mark the corresponding final word of its own output stream `tuser`[0] = 1"; on this class M17's application `tlast` word leaves on or before the cycle the input `tlast` word is presented, so **no implementation can mark it** and §6.2 makes M17 emit 0. requirements.md states no scope. | **DEFERRED — the behaviour is decided, stated at every site in this specification that mentions the bit (§2 twice, §3 twice, §4.2 twice, §6.1, §6.2, §10 and this row; the four scope- and meaning-statements among them were swept by ledger C-40) and asserted on two directed datagrams; what is deferred is whether REQ-007's own text gains the scope.** A reader implements §6.2 today — copy where D = 0, 0 where D ≥ 1 — and reads REQ-007 as scoped to the frames a marking module can still mark. **Where the exception is, stated so it is checkable rather than asserted — and corrected, because the first version of this sentence was false** (ledger **C-37**, dv_lead, WO-0022 Return log §3; **ADR-0012**). It read "M17 is the only module on the chain whose output frame's extent is fixed by a count declared *inside the data* … at M03, M06, M08, M10, M14, M16 and M19 the output frame ends on or after the input frame does". The generalisation was right; **the enumeration was wrong at M14**, whose output extent is fixed by the IPv4 total length — a count declared inside the data — and whose `Tail` state exists to consume the Ethernet padding that count exposes. The correct statement: the exception is exactly the modules whose output frame's extent is fixed by an in-data count, which is **M14 and M17, and those two only**. **M10 is safe for a reason this row did not give and which holds independently** — SPEC-M10 §3's REQ-007 row, "M10 emits no stream, so there is no `tlast` word on which to set `tuser`[0]" — and M03, M06, M08, M16 and M19 have no in-data count and were correctly listed. SPEC-M14 §11.5 is this clause's **second customer**, and its class is entered by ordinary Ethernet padding where M17's needs an under-declaring UDP length, so the residual is larger there than here. **This sentence was written in falsifiable form on purpose and dv_lead falsified it**; the correction keeps that form rather than retreating from it. **The reading this specification adopts**: REQ-007's subject is "every downstream module that emits an output frame **for it**", and on this class M17's application frame is a frame for the *declared* datagram rather than for the delivered one — dv_lead's reading (WO-0020 Return log §2), which §6.1, §6.2, §4.2, §3 and §10 now **state** rather than leave to be inferred, that statement being the condition under which dv_lead judged no requirements diff owed. **The alternative, priced.** It is a scoping clause on REQ-007 itself — for example "… SHALL mark the corresponding final word of its own output stream `tuser`[0] = 1, **except where that module's own output frame for it ends before the marked word reaches the module's input**, a case the per-module specification enumerates" — plus `traceability.md`'s REQ-007 row and the REQ-007 hook of each implementer. requirements.md is **FROZEN**, so that diff is a post-freeze normative change to a requirement **now and at any later date: its price does not rise at the batch-F flip**, which is the asymmetry that decides the sequencing. F-1 itself is repaired in this commit precisely because *its* price does rise — DRAFT §6 text now, a post-freeze §6 behavioural diff after the flip, the cost class ADR-0011 spends three paragraphs refusing at M04. REQ-707 needs no diff on either route: it already says "`tuser`[0] propagated **per REQ-007**" and inherits whatever scope REQ-007 carries. **What is actually lost, stated rather than buried**: on this class the application receives payload octets taken from a frame that may have been found invalid, with `tuser`[0] = 0, and cannot discard on the bit — and no strobe covers it either, because REQ-703 makes only an *over*-declared length an error. No cheaper repair exists at M17: holding the datagram to its input `tlast` would make the latency length-dependent (REQ-005, §7), and a combinational `ip_payload_tuser` → `payload_tuser` path would rescue only D = 1, never D ≥ 2, and is the shape §7 rejects for `tdata` for the same reason. The class is reachable only through a UDP length field that under-declares — in the aborted case, a corrupted one — which is why the residue is priced rather than treated as blocking. **The clause now has two customers and its price is unchanged by that** — it quantifies over modules and enumerates per module, so covering M14 as well as M17 adds one enumerated entry and no new instrument, and the diff is still a post-freeze normative change to a FROZEN requirement whose cost does not rise. Whichever of the two gates comes first decides it for both. | this item; **ADR-0012**; SPEC-M14 §11.5; requirements.md REQ-007; §6.1, §6.2, §10 | architect_docs_lead | `SO-udp_ip_rx_64.md` — the packet that would otherwise claim REQ-007 whole at M17 — **jointly with `SO-ip_eth_rx_64.md`** (SPEC-M14 §11.5). One clause, two gates |

## 12. Freeze record

Filled in at `P1-spec-freeze`. All four rows are required (charter §5).

| Item | Value |
|---|---|
| Interface compile check | CI `build` run **30744579228**, conclusion **`success`**, SHA **d8df28d** — every lift in the single `ifc_check` library elaborates, the four batch-F lifts among them; per ADR-0005 a local build is not acceptable evidence. **The run's head SHA is the F-1 repair commit, which is also this specification's freeze SHA**, so no witnessing argument is owed. This run is also §11.1's closure record |
| Architect signature | `J-architect_docs_lead-0008`; the F-1 repair of §6.1, §6.2, §8, §10 and the new §11.4 `J-architect_docs_lead-0009`; the C-37 and C-40 diffs of §13 `J-architect_docs_lead-0010` |
| dv_lead testability countersignature | **`J-dv_lead-0011`** (WO-0022) — batch F **COUNTERSIGNED at d8df28d**, this specification **SIGNED** on the bounded re-review of the F-1 repair: the separation formula recomputed from this section's own cycle rules rather than read, the `Tail` ≡ D ≥ 1 equivalence proved rather than accepted, §11.4's carry logic endorsed, and both unasked additions — the octet-vs-word distinction and the D = 0 boundary companion — judged improvements on dv_lead's own commissioned text |
| Frozen at | SHA **d8df28d**, gate `docs/gates/P1-spec-freeze-checklist.md` |

## 13. Change log

Post-freeze changes only. Each row cites the ADR that authorised it, or states
why none is owed; a breaking interface change is counted against post-freeze
churn (charter §6). **No row below is breaking**: §4.1's record is byte-for-byte
unchanged since the freeze SHA, so the `ifc_check` evidence of §12 still
witnesses this revision's interface, and `tools/check_records_vs_appendix.sh`
re-passes on this commit. **Both rows below are editorial**: no conformant design
and no existing assertion changes meaning, and §6's normative text is untouched.

| Date | Change | Breaking? | ADR | Journal |
|---|---|---|---|---|
| 2026-08-02 | §11.4's "here and nowhere else" enumeration **corrected**: it listed M14 as safe, and M14's output extent is fixed by the IPv4 total length — an in-data count — so the exception covers **M14 and M17 and those two only**. The generalisation is restated in the same falsifiable form; M10's independent reason (it emits no stream) is recorded; SPEC-M14 §11.5 is named as the carried REQ-007 scoping clause's **second customer** and `SO-ip_eth_rx_64.md` is added as a second gate on it; the "stated at four sites" count corrected (ledger **C-37**, dv_lead) | no | **ADR-0012** — the ADR is at SPEC-M14, where the behaviour changes; nothing normative moves here, and this row is the falsified sentence's own correction | `J-architect_docs_lead-0010` |
| 2026-08-02 | §3's REQ-007 row scoped the copy to "**on or after** the input `tlast`", which admits D = 1 where a registered output cannot carry the bit — the sole unpinned instance of a phrase §10 pins; corrected to "after" and pinned to §6.1's **D = 0**. Four statements of unqualified relay swept to match §6.2: §2's in-scope bullet, §2's not-my-job row, §3's REQ-013 row and §4.2's `ip_payload_tuser` **input** row, one parenthetical each (ledger **C-40**, dv_lead) | no | none — five sites already said D = 0 and no hook derives from any of these five, so no conformant design and no commissioned assertion changes; the document's own §6.1 was already the correcting text. The "on or after" phrase originated in dv_lead's WO-0020 owed-diff clause 2 and was transcribed faithfully | `J-architect_docs_lead-0010` |
