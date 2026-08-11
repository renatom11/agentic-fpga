# AP-M14 — attack plan for `Ip_eth_rx_64`

- **Module**: M14 `Ip_eth_rx_64` · spec `docs/specs/modules/ip_eth_rx_64.md`
- **Status**: **OPEN** — committed before the first M14 bench (charter §3,
  ADR-0001). Rows are added by appending; no row is ever renumbered.
- **Spec basis**: SPEC-M14 **FROZEN at `3f6accc`**, **as revised by ADR-0012 at
  `8641455`** — §2, §3, §4.2, §6.1, §6.2, §8, §10 and the new §11.5, which I
  re-countersigned at `J-dv_lead-0012` (WO-0025); plus the C-26, C-27 and C-30
  rows of §13. requirements.md §0.3 … §0.7, §1.1, §7 (REQ-601 … REQ-612), §12;
  SPEC-M01 §6.1/§6.3; **ADR-0012** (the decision, its four rejected alternatives
  and the residual). Carry-forwards realised as rows: **C-37** (family A),
  **C-26** (family E), **C-27** (family F), **C-30** (family H), **C-2**,
  **C-17(e)**, **C-23**.
- **Derivation (PROTOCOL §10)**: every row is derived from specification text
  alone. `libs/**` was not opened by the author of this plan; no M14 RTL exists
  at this commit in any case. The D arithmetic below was re-derived by hand at
  WO-0025 and quantified exhaustively by `tools/check_abort_availability.sh`
  (8 720 452 checks, exit 0) — a **specification** instrument, run against
  SPEC-M14's own formulas and against no design.
- **Format**: identical skeleton to `AP-xgmii_rx_64.md`, which defines it. §0
  and §1 there are the template; the §1 status vocabulary is restated below in
  one line and is not re-argued.
- **Author**: dv_lead, journal `J-dv_lead-0013` (WO-0027)

---

## 0. Why family A comes first

Every other family in this plan attacks a behaviour that M14 has always been
specified to have. Family A attacks the one the specification got **wrong** and
that ADR-0012 repaired: the abort bit M14 cannot copy. It is first because

- the previous §10 hook commissioned an assertion **no conformant design
  passes**, over a directed set (§8's total lengths 20 … 28) every member of
  which sits inside the defective band. A bench written before the repair would
  have been red against a correct M14 and the defect would have been argued from
  the wrong side;
- the class is entered by **ordinary Ethernet padding**, not by a malformed
  field, so it is the commonest small frame on the wire rather than a corner;
  and
- three plausible wrong keys — "the datagram carries padding", "the module is in
  `Tail`", and SPEC-M17's **word** deficit — agree with the correct rule on
  almost every datagram and disagree on a two-member boundary pair. If that pair
  is not driven, all three ship green.

The residual ADR-0012 carries — a bad-FCS 64-octet frame reaching the
application with `tuser`[0] = 0 — is **not** a row here: it is a system-level
consequence at the application port, and §11.5 gates its disposition on
`SO-ip_eth_rx_64.md`. Family A's job is to make sure M14 does exactly what the
repaired specification says, and that the excluded class is **asserted** rather
than left as a silence.

## 1. Reading a row

Six cells — **Row · Attacks · Stimulus · Observable · Kills · Status** — with
`AP-xgmii_rx_64.md` §1's meanings. Status is one of **ASSERT** (a bench must
assert it), **NO-ASSERT** (drivable, but the named property must not be
asserted; the forbidding clause is cited), **NO-STIMULUS** (do not drive it at
all), **RULING** (the frozen text does not decide; every reading is recorded and
none is asserted until a ruling lands — the C-12 precedent), **GAP** (an attack
wanted and not mountable; the reason is named and the row is carried so no
sign-off claims the coverage by silence), **STRUCTURAL** (a compile or script
check, not a waveform).

**The D arithmetic, once, since eleven rows use it.** With N the octets the
Ethernet payload delivers (**padding included**, REQ-408) and N′ the datagram's
declared IPv4 total length, the input has K = ⌈N/8⌉ words and the payload frame
has M = ⌈(N′ − 20)/8⌉ words. The input `tlast` is presented on Ci + K − 1; the
payload `tlast` word leaves on Ci + M + 3. The **cycle deficit** is
D = K − M − 3 and the separation is exactly **1 − D**. M14 copies the input
`tuser`[0] onto the payload `tlast` word **iff D ≤ 0**, and drives a derived 0
where D ≥ 1 (§6.1, §6.2, ADR-0012 decision 1–2). Inside a 64-octet Ethernet
frame N = 46 and K = 6, so D = 3 − ⌈(N′ − 20)/8⌉.

## 2. Standing obligations

Attached to **every** M14 bench; not repeated per row.

1. **Protocol monitor** on the `ip_payload` output stream with
   `~max_words_per_frame:185` (REQ-015, §3, §7).
2. **Frame-conservation monitor** (§0.6) with the **`clear` exemption**
   (**C-30**, C-2 at its second module): §7 states that `clear` inside an open
   datagram abandons it with no `tlast` and no strobe, so a monitor asserting
   conservation without the exemption **fails a conformant M14** in family H. In
   the stress run the exemption never fires and §8 criterion 1 stands as
   written for all 10 000 datagrams.
3. **Per-octet latency tagger** with `~strip_octets:20 ~front_offsets:[20]
   ~ceiling:5`, and a **per-datagram** removed tail of N − N′ octets — which the
   tagger cannot express today (§7, X-9).
4. **Strobe accounting counts high cycles, never rising edges** (§0.6 as revised
   by **C-23**). §9 argues that the *same* M14 strobe cannot be high on
   consecutive cycles *because consecutive datagrams are at least ten cycles
   apart at REQ-004's arrival rate* — a property of the **producer**, not of
   M14, which is why §3 below constrains the stimulus rather than relying on it.
5. **Both header records are read as their own direction's discipline**:
   `hdr_valid` and `ip_hdr_valid` are **one-cycle pulses** here. The same
   `Ip_header` record's `valid` on the transmit side (M15) is a level held until
   the first payload word is accepted (§7, ADR-0008). A monitor written for one
   and attached to the other reports a defect that is not there.
6. **No bench reads** `ip_payload_tdata` where `tkeep` is 0, any output field on
   a `tvalid` = 0 cycle, or the six `ip_hdr` fields on a cycle where
   `ip_hdr_valid` = 0 (§6.3 item 2).

## 3. Stimulus legality

M14 does not see XGMII, so REQ-004's rule binds this plan directly: the stimulus
is **what M08 emits on its `ip_*` ports**, "derived by construction from the
XGMII case and never re-invented" (§8). Three consequences:

- Every datagram in this plan is presented as **one `hdr_valid` pulse exactly
  one cycle before payload word 0**, followed by the frame's payload words
  (SPEC-M06 §7, preserved by SPEC-M08 §6.1). A bench that pulses `hdr_valid` on
  the same cycle as word 0, or two cycles before, is testing a producer that
  does not exist.
- **Idle gaps are preserved, not closed up**: the stress run's six words per
  frame are on consecutive cycles with 4 and 5 idle cycles alternating between
  frames (§8). A bench that packs words back to back is testing a rate the
  receive path never sees.
- Datagram **adjacency is bounded by the producer**: two datagrams may not be
  presented closer than the XGMII layer can deliver them. This is why standing
  obligation 4's convention matters and §9's consecutive-cycle claim is not
  itself a target: driving adjacency to falsify it would be attacking a
  stimulus M08 cannot produce.
- Streams that violate REQ-011 or REQ-015 (`tkeep` = 0 with `tvalid` = 1, a
  `tlast` with no preceding `hdr_valid`, a non-contiguous `tkeep`) are **never
  driven**: §6.3 item 5 leaves M14's response unconstrained because its producer
  cannot emit them.

---

## 4. The rows

### 4.A The abort bit M14 cannot copy — REQ-007, REQ-013, §6.1, §6.2, §11.5, ADR-0012, **C-37**

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-A1** | REQ-007, REQ-013, §6.1's regime table, §6.2's `Payload` row, §8's directed pair, ADR-0012 decisions 1–3 | **The adjacent pair, both inside a 64-octet Ethernet frame** (N = 46, K = 6, input `tlast` presented at Ci + 5, both entering `Tail` with a word deficit of exactly 1). **(a)** IPv4 total length **36**: M = ⌈16/8⌉ = 2, **D = 1**, payload `tlast` leaves at Ci + 5 — the *same* cycle. **(b)** total length **37**: M = ⌈17/8⌉ = 3, **D = 0**, payload `tlast` leaves at Ci + 6 — one cycle after. **Each driven twice, with `payload_tuser`[0] = 0 and = 1 on the input `tlast` word** (four runs) | **(a)** 16 payload octets in 2 words, `tlast` on word 1 with `tkeep` = 0xFF, 10 octets of padding dropped, **no strobe**, and `ip_payload_tuser`[0] = **0 on both runs**. **(b)** 17 payload octets in 3 words, `tlast` on word 2 with `tkeep` = 0x01, 9 octets of padding dropped, **no strobe**, and `ip_payload_tuser`[0] **equal to the input bit** — 1 on one run, 0 on the other | **Six wrong designs, on two datagrams.** (i) *unconditional copy* — copies at (a), where the bit is not available to a registered output: fails (a). (ii) *keyed on "the datagram carries padding"* — both carry it: drives 0 at (b), fails (b). (iii) *keyed on being in `Tail`* — both enter it: fails (b); §6.2 pins `Tail` as a **proper superset** of the derived-0 class precisely here. (iv) *keyed on SPEC-M17's **word** deficit* ⌈N/8⌉ − ⌈N′/8⌉ — equals 1 for both: fails (b). This is the M17 substitution trap, and it is wrong at **four residues in eight** (N′ mod 8 ∈ {0, 5, 6, 7}), always in the direction that predicts a derived 0 where a conformant design must copy. (v) *copy iff D ≤ 1* — the generous off-by-one: copies at (a), fails (a). (vi) *copy iff D ≤ −1* — the strict off-by-one: drives 0 at (b), fails (b). **Only a design keyed on the cycle deficit D passes all four runs.** (a) additionally kills ADR-0012's rejected alternative (b), a combinational `payload_tuser` → `ip_payload_tuser` path, which rescues exactly D = 1 and would copy here | ASSERT |
| **M14-A2** | §6.1's residue split, ADR-0012 decision 3 | **IPv4 total length 40 inside a 64-octet frame**: N′ mod 8 = **0**, M = ⌈20/8⌉ = 3, **D = 0** (copy), while the word deficit ⌈46/8⌉ − ⌈40/8⌉ = **1**. Driven twice with opposite input bits | 20 payload octets in 3 words, `tlast` on word 2 with `tkeep` = 0x0F, 6 octets of padding dropped, no strobe, and `ip_payload_tuser`[0] **equal to the input bit** | The word-deficit design **again, at a different residue**, so M14-A1(b)'s kill is not a coincidence of one length: the specification's claim is that D and the word deficit differ at four residues in eight, and one witness proves an instance while two witnesses at different residues (5 and 0) test the claim | ASSERT |
| **M14-A3** | REQ-007, §6.1's D ≤ 0 regime | **The ordinary fully delivered datagram**: total length **46** in a 64-octet frame (N′ = N = 46), M = ⌈26/8⌉ = 4, **D = −1**, payload `tlast` at Ci + 7 against an input `tlast` at Ci + 5. Driven twice with opposite input bits | 26 payload octets in 4 words, `tlast` on word 3 with `tkeep` = 0x03, no padding, no strobe, `ip_payload_tuser`[0] **equal to the input bit** | A design that drives 0 unconditionally on the whole class — the anti-vacuity partner of M14-A1(a), without which the "0 both times" assertions pass against a design that never copies anything. This is also the datagram §6.1's cycle table walks and the one whose worked example made the original defect reproduce | ASSERT |
| **M14-A4** | REQ-007, §6.1's D ≤ 0 regime at zero margin | **Total length 1500 fully delivered** (a 1518-octet Ethernet frame): K = ⌈1500/8⌉ = 188, M = ⌈1480/8⌉ = 185, **D = 0** — the tightest point of the copy class, separation exactly one cycle. Driven twice with opposite input bits | 1480 payload octets in **185** words (all `tkeep` = 0xFF, `tlast` on word 184), no strobe, `ip_payload_tuser`[0] equal to the input bit | A design keyed on a **length** threshold rather than on D: at D = 0 with a 1480-octet payload, any rule of the form "copy for short datagrams" is on the wrong side. Also the REQ-015 maximum on this stream, exercised with the abort bit live | ASSERT |
| **M14-A5** | REQ-007, §6.1's D ≥ 2 regime, ADR-0012 alternative (b) | **Total length 28 inside a 64-octet frame**: M = 1, **D = 2** — the *common* member of the unavailable class, and REQ-605's own padding example (18 octets removed, 8 delivered). Driven twice with opposite input bits | 8 payload octets in **one** word, `tkeep` = 0xFF, `tlast` = 1, no strobe, `ip_payload_tuser`[0] = **0 on both runs** | A design that special-cases only D = 1 (ADR-0012's rejected alternative (b) again, from the other side): it drives 0 at total length 36 and copies here, where the input `tlast` has not been presented at all when the payload frame closes | ASSERT |
| **M14-A6** | §11.5, §8's band note, REQ-007's universal | **The whole directed set of total lengths 21 … 28 inside a 64-octet frame** (M14-D1) | These datagrams assert **nothing whatever** about `ip_payload_tuser`[0]: every one of them is in the D ≥ 1 class, and inside a 64-octet frame **every total length from 21 to 36 is** (the threshold is N′ ≥ 8⌈N/8⌉ − 11 = 37). Any `tuser` assertion on this set belongs in M14-A5's form (derived 0, both input bits) and nowhere else | The bench this plan replaces: §10's pre-ADR-0012 hook commissioned "the bit set on its last word" over exactly this set, an assertion **no conformant design passes**. The row exists so that a later reader of the directed set cannot re-introduce it | NO-ASSERT |
| **M14-A7** | §11.5, REQ-007 | — | **No `SO-ip_eth_rx_64.md` may claim REQ-007 whole at M14.** The D ≥ 1 class is outside REQ-007's universal as REQ-007 is written; §11.5 gates the scoping clause on this very packet, jointly with `SO-udp_ip_rx_64.md`. The sign-off states the exclusion, cites §11.5 and ADR-0012, and reports M14-A1/A5 as the **positive** assertions that cover the excluded class | A sign-off that reports REQ-007 as covered because every row it ran was green | STRUCTURAL |
| **M14-A8** | REQ-605, §6.1's last paragraph | The truncation rows of family E | M14's **own** abort — REQ-605's truncation mark — is **always available** to it and is unaffected by D: it is detected at the input `tlast` itself. The band rows assert `tuser`[0] = **1** on the emitted payload word regardless of the datagram's D | A design that routes its own truncation mark through the inherited-copy path and loses it on the D ≥ 1 class, which would make a truncated small datagram indistinguishable from a clean one | ASSERT |

### 4.B Header rejection classes — REQ-601 … REQ-604, REQ-607, REQ-612, §9

Every row's strobe is one high cycle on **Ci + 3** — the cycle `ip_hdr_valid`
would have occupied — with **no `ip_hdr_valid` and no payload word** for that
datagram (§9's pinned cycles; every rejection at M14 is a discard-before-
emission).

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-B1** | REQ-601 | Version **6**, IHL 5; version 4 IHL **6**; version 4 IHL **4** | One `error_ip_bad_header` each, at Ci + 3; nothing emitted | A design checking only the version nibble, or only IHL; a design accepting IHL > 5 and then reading the payload from the wrong offset | ASSERT |
| **M14-B2** | REQ-602, §6.1's checksum arithmetic | A datagram with **one header bit flipped** after the checksum was computed | One `error_ip_bad_checksum` at Ci + 3; nothing emitted | A design that does not verify the checksum at all (this is REQ-901 divergence class (a) — the reference does not verify it, so this REQ is verified against the **spec** by directed test only, §11.3) | ASSERT |
| **M14-B3** | REQ-602's "fold **every** carry" | **(b) only, and it is constructed by search rather than by hand**: a header, otherwise valid, whose ten-halfword raw total exceeds 0xFFFF so that its folded sum reaches 0xFFFF **by way of an end-around carry**. Built by `Dv_golden.Ipv4_ref.end_around_carry`, which searches the identification field — sixteen bits nothing in Phase 1 receives on, so varying them changes no other outcome | (b) verifies and is **accepted**, with `ip_hdr_valid` and the payload delivered exactly as for the unmodified datagram | A design that adds the ten halfwords **modulo 2^16 with no end-around carry at all**: its sum for (b) is not 0xFFFF, so it rejects a valid datagram — a silent connectivity failure reported as `error_ip_bad_checksum`. §6.1's "fold **every** carry out of bit 15 back into bit 0" is that word made executable. **Sub-case (a) is WITHDRAWN as unbuildable — ledger C-48, found by building the X-8 oracle at WO-0033 and stated against dv_lead's own row.** It commissioned "one whose ten-halfword sum needs **two** folds", to kill a 32-bit accumulator folded once. No such header exists and the defect is not one: writing g(T) = (T mod 2^16) + ⌊T/2^16⌋ and f = g to a fixpoint, both preserve T mod 65535; a 20-octet header is ten halfwords so ⌊T/2^16⌋ ≤ 9 and g(T) ≤ 0xFFFF + 9; a header verifies iff f(T) = 0xFFFF, i.e. T ≡ 0 (mod 65535) with T > 0, whence g(T) ∈ {0, 0xFFFF} and g(T) = 0 forces T = 0, which does not verify — so g(T) = 0xFFFF, and conversely g(T) = 0xFFFF stops the fixpoint at once. **The two arithmetics make the same accept/reject decision on every 20-octet header**, so fold-once is unkillable at M14 *because it is not a defect there*. `test_ipv4_ref.ml` runs the search that confirms it over the whole identification field and expects `None`. This is the **third** instance of dv_lead's own named failure mode — a universal about killability asserted over arithmetic that does not support it (C-44 and the WO-0031 prose correction were the first two) | ASSERT |
| **M14-B4** | REQ-603 | More-fragments set (octet 6 bit 5); fragment offset **0x0001** (octet 7 only); fragment offset **0x0100** (octet 6 bits 4:0 only, octet 7 zero) | One `error_ip_fragment` each, at Ci + 3; nothing emitted | The third stimulus kills a design reading the fragment offset from **octet 7 alone** — it accepts and mis-delivers every fragment whose offset is a multiple of 256, which is most of them | ASSERT |
| **M14-B5** | REQ-603, §6.3 item 4 **as revised at `541ea43`**, §8's flag-bit pair, §10's REQ-603 hook | Two datagrams identical to the stress run's accepted datagram except that one sets **DF** (octet 6 bit 6) and the other sets the **reserved** bit (bit 7); MF clear, fragment offset 0, and **the header checksum recomputed for each** — without the recompute REQ-602 rejects the stimulus and the comparison is vacuous (the architect's addition to dv's proposed sentence, WO-0029 Return §2) | Each is **accepted exactly as the unmodified datagram**: the same `ip_hdr_valid` cycle, the same six field values, the same 26 payload octets in the same words, **no strobe of any kind**, and in particular **no `error_ip_fragment`**. The two bits themselves are never read out — M14 has no port and no `Ip_header` field for either, which is the whole of what §6.3 item 4 still leaves unconstrained | A design that discards on *any* non-zero flag bit (`flags != 0`), or that tests bit 6 or bit 7 **in addition to** bit 5 for more-fragments. That class is exactly the one **M14-B4 cannot reach**, because B4's MF-set datagram is discarded by the over-broad design and by the correct one alike. A design reading bit 6 **instead of** bit 5 is already killed by M14-B4 (it *accepts* B4's MF-set datagram); the original claim that this pair was the *only* stimulus for a wrong-bit read was dv's own and is **false** — carried as **C-44** | ASSERT |
| **M14-B6** | REQ-604, §4.3's subnet-broadcast formula | **Four accepted**: `cfg_local_ip`; the subnet broadcast `cfg_local_ip` \| ~`cfg_subnet_mask`; 255.255.255.255; `cfg_multicast_group` with `cfg_multicast_enable` = 1 | Each accepted: `ip_hdr_valid` pulses at Ci + 3 with `ip_hdr_dst_ip` equal to the injected address, payload delivered, **no strobe** | A filter that accepts only the local IP (the three others then fail silently as `error_ip_not_for_us`) | ASSERT |
| **M14-B7** | REQ-604 | **Three rejected**: a foreign unicast address; `cfg_multicast_group` with `cfg_multicast_enable` = **0**; an address **on the local subnet** that is neither `cfg_local_ip` nor the subnet broadcast — the subnet's own network address `cfg_local_ip` & `cfg_subnet_mask` is the sharpest choice | One `error_ip_not_for_us` each, at Ci + 3; nothing emitted | A design that accepts any address matching the subnet prefix (a masked comparison instead of the four exact tests); and a design ignoring `cfg_multicast_enable` | ASSERT |
| **M14-B8** | REQ-607 | Protocol **1** (ICMP) and protocol **6** (TCP) | One `error_ip_bad_protocol` each, at Ci + 3; nothing emitted; **no reply of any kind** for the ICMP datagram (requirements.md §11) | A design that forwards non-UDP datagrams to M17 with the protocol number in the record and lets M17 decide — REQ-607 places the check here | ASSERT |
| **M14-B9** | REQ-612, REQ-605 | The adjacent pair **total length 1501** and **total length 1500**, each in a frame long enough to deliver it | 1501: one `error_ip_oversize` at Ci + 3, nothing emitted. 1500: accepted, 1480 payload octets in 185 words, no strobe | The off-by-one on "above 1500" (`>= 1500` for `> 1500`), which would reject the maximum legal datagram — a failure that looks like a link problem, not a filter problem | ASSERT |
| **M14-B10** | REQ-606, REQ-607 | Every accepted datagram in this plan | `ip_hdr_protocol` = **17** on every accepted datagram (REQ-607 discards the rest, so no other value is reachable at this port) | A record that carries a stale or zeroed protocol field — cheap, and it is the field M17 has the least ability to re-check | ASSERT |

### 4.C The header record — REQ-606, REQ-012, REQ-611, §7

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-C1** | REQ-012, REQ-606, §6.1's field table | One known datagram with **every field distinct and asymmetric**: source 10.1.2.3, destination = `cfg_local_ip` = 192.0.2.1, TTL 64, DSCP 0x2A, ECN 0b11, total length 46, protocol 17 | All six fields compare equal to hand-computed values: `ip_hdr_src_ip` = 0x0A010203, `ip_hdr_dst_ip` = 0xC0000201 (first wire octet most significant), `ip_hdr_total_length` = 46, `ip_hdr_ttl` = 64, `ip_hdr_protocol` = 17, `ip_hdr_dscp` = 0x2A | A byte-swapped address decode — invisible against a palindromic test address, which is why both addresses are asymmetric and different from each other. **The ECN bits are the trap**: `ip_hdr_dscp` is octet 1 bits 7:2 only, so a design carrying octet 1 whole reports 0xAB and this row catches it | ASSERT |
| **M14-C2** | REQ-606, REQ-611, §7's parse latency | The stress stimulus (M14-I1) and the directed set | `ip_hdr_valid` is high for **exactly one cycle** per accepted datagram, on cycle **Ci + 3**, which is **exactly one cycle before** that datagram's first payload word; the parse latency from input word 0 to the pulse is **3** for all 10 000 | A `valid` held as a **level** — the transmit-side (M15) discipline of the same record (§7, ADR-0008). It would pass every field comparison and break M17, which is written against the one-cycle lead | ASSERT |
| **M14-C3** | REQ-606, §6.2 | Three datagrams in sequence with **different** field values, the middle one **rejected** on its header (protocol 1) | The first and third records carry their own datagram's values; the rejected datagram pulses no record and leaves **no residue** in the third's fields | A stuck or partially updated field register, and a design that writes the field registers before the accept decision and lets a rejected datagram's values leak into the next record | ASSERT |
| **M14-C4** | §6.3 item 2 | — | The six `ip_hdr` fields are **not read** on cycles where `ip_hdr_valid` = 0; no monitor samples them | A snapshot that freezes an unconstrained value into an accidental requirement | NO-ASSERT |

### 4.D Payload extent, realignment and padding — REQ-021, REQ-605, REQ-011, REQ-015

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-D1** | REQ-021, REQ-605, REQ-011, **C-17(e)** | **Total lengths 20 … 28 inclusive**, each inside a 64-octet Ethernet frame | Payloads of 0 … 8 octets. Payload octet 0 at `ip_payload_tdata`[7:0] of payload word 0 at **every** length; `tkeep` on the `tlast` word marks exactly the octets that exist (0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F for 21 … 27, and **0xFF at 28**); total length **20** emits `ip_hdr_valid` and **no payload frame** and no strobe (§0.7) | Two different claims that a shorter set conflates (C-17(e)'s lesson, applied here before the fact rather than after it at M06): 20 … 27 cover every **residue** modulo 8, and only **28** covers the full-word `tkeep` pattern, because a payload of 0 emits no word at all. A design whose realignment is right at seven residues and wrong at one is exactly what this set is shaped to find | ASSERT |
| **M14-D2** | REQ-605, REQ-408 | A 64-octet frame carrying **total length 28** (REQ-605's own example) | Exactly **8** payload octets delivered; **18** octets of Ethernet padding consumed and dropped; no strobe | A design that delivers the whole Ethernet payload and lets M17 sort it out — REQ-605 places padding removal here, and the datagram's own length field is what exposes it | ASSERT |
| **M14-D3** | REQ-021, §6.1's realignment identity | A datagram whose payload octets are **position-dependent** (octet j = f(j), f injective over the frame), total length 46 | Payload word j carries payload octets 8j … 8j+7, assembled from input words j + 2 (positions 4–7) and j + 3 (positions 0–3); the delivered octet string equals the injected one exactly | A rotation by the wrong amount, a word swap, or a shift that is right for the first payload word and wrong thereafter. **All three are invisible under uniform payload**, which is why the pattern is position-dependent and stated | ASSERT |
| **M14-D4** | REQ-015, REQ-011 | Total length 1500 (M14-A4) | 185 payload words, the `tlast` word included in the count; the protocol monitor's `max_words_per_frame` = 185 is not exceeded and is **reached** | A REQ-015 bound of 184 or 186 in the monitor; a design that emits a spurious final word | ASSERT |
| **M14-D5** | §8's bench-writer note, REQ-012 | The stress stimulus | The 32-bit sequence number at M14 payload octets 8–11 lands in `ip_payload_tdata`[31:0] of **payload word 1**; the source address at IPv4 octets 12–15 lands in **input word 1** positions 4–7 — a field entirely inside one word — while the destination at 16–19 is the field whose decode sits at the head of the word the realignment splits | A design that gets the whole-word field right and the split field wrong: the two are worth asserting separately for that reason, and §8 says so | ASSERT |

### 4.E Truncation, the extensional branch — REQ-605, §9, **C-26**

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-E1** | REQ-605, §9's truncation row, **C-26** | **The 21-to-27-delivered band**: seven frames, each declaring total length **46** and delivering only 21, 22, … 27 IPv4 octets — every residue in the band | Each emits **exactly one** payload word at **Ci + 4** carrying the 1 … 7 payload octets that arrived, `tkeep` marking exactly them, `tlast` = 1, `tuser`[0] = **1**, and exactly one `error_ip_truncated` at **Ci + 3** | **The temporal reading**, which emits nothing for this band: at the detection cycle no payload word has *left* (input `tlast` at Ci + 2, strobe at Ci + 3, payload word 0 not due until Ci + 4), so a design branching on "have I emitted yet" drops the frame while REQ-605 says "the payload's last word SHALL carry `tuser`[0] = 1", which presupposes a word. This is the eight-octet-wide band the two readings disagreed over and C-26 settled extensionally | ASSERT |
| **M14-E2** | REQ-605, §9's boundary decision, **C-26** | **Exactly 20 delivered IPv4 octets** with a declared total length of 46: the header is complete and zero payload octets exist | **No `ip_hdr_valid`**, no payload word, exactly one `error_ip_truncated` | The reading in which `Header` routes to `Payload` because the header was accepted and the declared payload is non-empty — it would pulse a record promising a payload frame that cannot follow. §9's generalising rule: *a header record is never emitted for a datagram whose payload frame cannot follow* | ASSERT |
| **M14-E3** | REQ-605, §0.7, §9's closing paragraph | **The confusable partner of M14-E2**: total length exactly **20**, fully delivered | `ip_hdr_valid` **pulses**, no payload frame, and **no strobe** | A design keyed on "zero payload octets" rather than on **declared** versus **delivered**. E2 and E3 are adjacent and opposite — declared-empty pulses the record, declared-non-empty-and-delivered-empty pulses the strobe — and a design that conflates them passes whichever of the two a lazier plan drove | ASSERT |
| **M14-E4** | REQ-605, §9's only precedence rule | A frame ending **inside the 20-octet header** — 12 IPv4 octets delivered — whose **version nibble is 6** | Exactly one `error_ip_truncated` and **nothing else**: none of the other six conditions is evaluated on a partial header | A design that evaluates version/IHL on input word 0 as it arrives and reports independently of completeness: it pulses `error_ip_bad_header` too, making the pulse set a function of *where the frame ended* rather than of the datagram. The version-6 payload is what turns this from a silence into a positive assertion | ASSERT |
| **M14-E5** | REQ-401, REQ-605, §6.1's payload-less clause, §0.7 | **A 14-octet Ethernet frame routed here**: a `hdr_valid` pulse with **no payload frame at all** | No `ip_hdr_valid`, no payload word, exactly one `error_ip_truncated`, pulsed **one cycle after the next `hdr_valid` pulse** (the closing event for a frame that never delivers one), and the next datagram parsed intact | A design that never reports the payload-less frame — a silent discard under REQ-008 and an unbalanced §0.6 equation — and a design that reports it at a cycle no bench can compute from the input trace | ASSERT |
| **M14-E6** | REQ-605, REQ-007, §9's aborted-and-forwarded class | A datagram declaring total length **200** inside a frame that ends after **100** delivered IPv4 octets, i.e. after several payload words have already left | The payload frame is completed and **aborted**: `tlast` on the word carrying the last octet that arrived, `tkeep` marking exactly it, `tuser`[0] = 1, one `error_ip_truncated` one cycle after the input `tlast` word, and the word "leaves at its ordinary cycle whether or not it had already left when the frame closed" | A design that emits words up to the *declared* length (inventing octets), and a design that drops the partial frame after emitting part of it — the second is the silent discard §0.6 forbids | ASSERT |
| **M14-E7** | REQ-605, §9, §6.2's `Header` row | A frame ending **exactly at the end of the header** while the declared payload is non-empty, and a frame ending **mid-header** (both branches of §6.2's `Header` → `Idle` list) | Both give **one** `error_ip_truncated` and **no** `ip_hdr_valid` | A design that distinguishes the two internally and reports them differently — §6.2 pins them equal at the port | ASSERT |

### 4.F Gapped stimulus — REQ-016, §7's two constants, **C-27**

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-F1** | REQ-016, **§7's per-output-event table**, §10's REQ-016 hook | The directed set of M14-D1 through an idle-injection wrapper at **0, 1 and 7** cycles between input words, **after** the header — and the sites are enumerated rather than left to a bench writer: **(a)** between input words **2 and 3**, the first payload gap and the site where this row's repair bites, and **(b)** between later input word pairs | **Repaired 2026-08-11 — this row asserted a quantity no straddling module has, and it is mine** (see the struck text below). What it asserts now, all of it from §7's own table: **(i)** the ordered sequence of (`tdata`, `tkeep`, `tlast`, `tuser`) tuples on `ip_payload` is **unchanged**, and every octet keeps its byte position within its word; **(ii)** each output event is delayed by **exactly the number of idle cycles injected at or before its deciding input word** — payload word `j` from input word `j + 3` at 1 cycle; the last payload word, where the frame ends at input word `j + 2`, from the input `tlast` word at 2 cycles; `ip_hdr_valid` and §9's first six strobes from input word **2** at 1 cycle; `error_ip_truncated` from the word carrying the closing event at 1 cycle; **(iii)** `ip_hdr_valid` is high for exactly one cycle per accepted datagram. **Per-octet latencies on an injected run are REPORTED as data and asserted nowhere.** ~~Struck: *"the **per-octet constant L = 12** is unchanged for every octet; every octet is delayed by exactly 8 octet times per injected cycle"*~~ — **that assertion fails a conformant M14 at every k ≥ 1**: h = 20 is no multiple of 8, so M14 fails requirements.md §0.5's **straddle** test (ruled 2026-08-04, a week before this row was read again), every payload word is assembled from positions 4–7 of one input word and 0–3 of the next, and an idle injected between them gives one output word two latencies — which REQ-011 forbids resolving by splitting the word. ~~Struck: *"`ip_hdr_valid` still leads payload word 0 by one cycle"*~~ — **also falsified at injection site (a)**: `ip_hdr_valid` moves with input word **2** and payload word 0 with input word **3**, so `k` idles between them make the lead `1 + k`. **That lead is asserted nowhere until `FINDING AP-M14-1` is ruled** (§8 item 3) — the finding is precisely that SPEC-M14 §7's handshake bullet still states the adjacency unscoped while its own per-event table contradicts it at this one injection site; the row asserts what **both** readings agree on and is therefore unmoved by the ruling either way | A design that treats an idle cycle as a word (advancing the word index) — it mis-assembles the realignment and delivers garbage from the next datagram's position. **And the bench itself**: a REQ-016 wrapper asserting a single per-octet `L` under injection is the `SCR-M03-I4` failure mode at a second module, in my own landed plan, and this row is where it was caught before a bench was built from it rather than after | ASSERT |
| **M14-F2** | REQ-611, §7's scoping, **C-27** | The same wrapper with the idle cycles landing **inside the header** — between input words 0 and 2 — at 1 and 7 cycles | The parse latency measured from **input word 0** is **3 + k**, exactly the number of injected cycles, and that grown value is **asserted** — the half this repair **strengthens** rather than narrows. **And the quantity that discharges REQ-611's gap clause is asserted with it, added 2026-08-11**: the delay from `ip_hdr_valid`'s **deciding input word — input word 2, the word completing the 20-octet header — is exactly 1 cycle on every stimulus, gapped or not** (§7 as restated, §10's REQ-611 hook). C-27's growth rule is the same fact from the other end: the figure measured from input word 0 grows by the injected count **because** the figure measured from input word 2 does not move. ~~Struck 2026-08-11: *"L = 12 is unchanged"*~~ — the same defect as `M14-F1`'s, from the same retired reading: M14 straddles (h = 20), so no per-octet constant survives injection, and REQ-611's gap clause is no longer discharged by one | Two things at once. (i) A design whose header parse is cycle-counted rather than word-counted: it reports the record early and mis-decodes the destination. (ii) **The bench itself** — a REQ-611 + REQ-016 bench asserting 3 under injection fails a conformant M14, which is exactly what C-27 found; this row turns C-27's scoping from a silence into a positive assertion | ASSERT |
| **M14-F3** | REQ-016, §6.1's gapped paragraph, requirements.md §0.5's straddle test | — | **§6.1's cycle formulas (`Ci + m`, `Ci + 3`, `Ci + 4 + j`) are NOT asserted under injection.** They are stated on a gapless stimulus. **Ground repaired 2026-08-11**: ~~*"the gap-invariant quantity is L = 12 and that is what M14-F1 asserts"*~~ — **there is no gap-invariant per-octet constant at this module**, `M14-F1` no longer asserts one, and the retired reading was being carried here as this row's whole reason. The gap-invariant quantity is **the delay from each output event's deciding input word** (§7's per-output-event table), and that is what `M14-F1` asserts now. **The prohibition is unchanged and is now grounded on the quantity that exists** rather than on one §0.5 retired on 2026-08-04 | — (a row whose only job is to stop a bench asserting a gapless formula under injection — the C-14.4 distinction at this port. It is the cheapest row in this plan to leave stale, because nothing fails when its *reason* rots: the prohibition still reads correctly, which is exactly why the rot survived a week) | NO-ASSERT |
| **M14-F4** | REQ-016, REQ-605, §6.2 | A datagram of total length 46 with **7** idle cycles injected between every pair of payload words | No strobe pulses at all; exactly 26 payload octets delivered; the padding boundary is unmoved | A design counting **cycles** rather than **octets** against total length − 20: under 7-cycle injection it truncates the datagram early and pulses `error_ip_truncated` on a frame that arrived complete | ASSERT |

### 4.G Configuration — REQ-802, REQ-803, §4.3, §6.3 item 6

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-G1** | REQ-803, §4.3 | `cfg_local_ip` changed **between** two datagrams (at least one cycle before the second's input word 2), the first addressed to the old value and the second to the new | The first datagram completes and is **accepted** under the old value; the second is accepted under the new one; neither pulses `error_ip_not_for_us` | A design that samples the configuration continuously and re-evaluates the destination test mid-datagram, rejecting a datagram it had already accepted | ASSERT |
| **M14-G2** | REQ-803, §4.3's sampling word | `cfg_local_ip` changed to a value that would **reject** the datagram in flight, landing one cycle **after** its input word 2 | The in-flight datagram is **accepted** — the test was evaluated on word 2 — and the following datagram is rejected | A design sampling at the input `tlast`, or at `hdr_valid`, rather than on the word carrying IPv4 octets 16–19 | ASSERT |
| **M14-G3** | REQ-604, REQ-802 | `cfg_multicast_enable` toggled 1 → 0 between two datagrams addressed to `cfg_multicast_group`; and `cfg_subnet_mask` widened so that a previously foreign address becomes the subnet broadcast | The same destination address is accepted under one configuration and rejected with one `error_ip_not_for_us` under the other; the subnet-broadcast address tracks the mask | A filter with the multicast group or the broadcast address computed once at reset | ASSERT |
| **M14-G4** | §4.3, §6.3 item 6, **C-14.5**'s rule at this module | — | A configuration change landing on **input word 2's own cycle** has no determinate outcome and **SHALL NOT** be driven-and-asserted. Every change in this plan lands at least one cycle away | — | NO-STIMULUS |

### 4.H Reset — REQ-009, §7, **C-30**

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-H1** | REQ-009 | `clear` = 1 for five cycles with no datagram open | `ip_payload_tvalid` = 0, `ip_hdr_valid` = 0 and **all seven** strobes 0 on every `clear` cycle and on the first cycle after | A strobe register that survives `clear`; a design needing a second settling cycle | ASSERT |
| **M14-H2** | REQ-009, §7's reset bullet, §8 criterion 1's exemption, **C-30**, **C-2** | `clear` asserted **mid-datagram**, deasserted, and a new datagram opened by a `hdr_valid` pulse on the **first** cycle after `clear` returns to 0 | The abandoned datagram produces **no record, no payload `tlast` and no strobe**; the new datagram parses intact and is delivered completely. The conservation monitor runs **with the `clear` exemption** — **without it a conformant M14 fails**, which is precisely what C-30 was raised for | A design that emits a `tlast` on `clear` (a phantom frame at M17); a design that needs an idle cycle before it can open a datagram; and a **monitor** built from §0.6's unqualified text, which counts the abandonment as a silent discard | ASSERT |
| **M14-H3** | REQ-009, REQ-015 | (same as M14-H2) | The protocol monitor resets its frame-in-progress state on `clear` and makes **no assertion across** it | — | NO-ASSERT |

### 4.I Line rate, constancy and order — REQ-004, REQ-005, REQ-019, REQ-020, REQ-611, §8

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-I1** | REQ-004, §8 checks 1–2 | §8's stress run, derived by construction from SPEC-M03 §8 with ethertype 0x0800: **10 000** datagrams, each a 46-octet payload in **6 words** (five `tkeep` = 0xFF, one 0x3F with `tlast`), one `hdr_valid` one cycle before word 0, **4 and 5 idle cycles alternating** between frames; total length 46, identification n mod 65536, source 10.0.0.0 + n, protocol 17, destination = `cfg_local_ip`, **checksum recomputed per datagram**, `payload_tuser`[0] = 0, zero error injection | 10 000 payload frames out for 10 000 in; 10 000 `ip_hdr_valid` pulses, each exactly one cycle; the 26 delivered octets of every datagram equal input octets 20–45; sequence numbers 0, 1, 2, … with no gap or repeat; conservation holds; **no strobe pulses anywhere in the run** | Word loss under sustained rate; a design holding more than one datagram's header (order is otherwise not expressible, §6.2). The **recomputed** checksum is load-bearing: identification changes per datagram, so a fixed checksum would fail every frame and a design that ignores the checksum would pass a run a conformant design fails | ASSERT |
| **M14-I2** | REQ-005, REQ-019, §8 check 3 | (the same run, through the tagger) | Per-octet latency = **12** octet times for **every** octet of all 10 000 — one value, not a mean; ΔC = (12 + 20)/8 = **4** against the §1.1 ceiling of **5**, with the spare cycle reported as M14's **reserve**, not as programme slack (§7, §11.2) | A design with length-dependent latency; and a sign-off that reports the spare cycle as slack, which would invite it to be spent by someone who does not own it | ASSERT |
| **M14-I3** | REQ-611, §8 check 4 | (the same run) | The parse latency from input word 0 to `ip_hdr_valid` equals **3** for all 10 000 — the scope condition holds by construction here, since §8 delivers each header on three consecutive cycles | A design whose parse latency depends on field content (e.g. an early-out on the destination test) | ASSERT |
| **M14-I4** | REQ-005, §6.1's "not emitted early" paragraph | The stress datagram, examined at its final payload word | Payload octets 24–25 arrive in input word 5 at Ci + 5 and their word leaves at **Ci + 7**, not Ci + 6: payload octet 24's input octet time is 8Ci + 44 and constant latency fixes its output octet time at 8Ci + 56 | A design that emits the last word as soon as it has the octets — it would have **length-dependent** latency, pass every octet-comparison row, and fail only the per-octet tagger. §6.1 states this case for exactly that reason | ASSERT |
| **M14-I5** | REQ-003 | — | Neither stream carries a `tready` and neither record contains an `Axi64.Dest`. Structural (§8 check 5) | — | STRUCTURAL |

### 4.J Multiplicity and precedence — §9, §0.6

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-J1** | §0.6's multiplicity rule, §9 | One datagram with **protocol 1 and a foreign destination** (§8's own directed case) | **Both** `error_ip_bad_protocol` and `error_ip_not_for_us` pulse, on the same cycle Ci + 3 | A precedence or first-match design. §9 rejects precedence deliberately: one strobe looks the same whichever rule suppressed the others, so a bench could not tell a conformant design from a broken one | ASSERT |
| **M14-J2** | §9's checksum corollary | One datagram with a **bad checksum and a foreign destination**, and one with a **bad checksum and version 6** | Both strobes pulse in each case: a bad checksum does **not** suppress the other checks | The reading a reader most often doubts — a design that treats the checksum as a gate on the rest of the header. It is unobservably wrong on every single-fault datagram and observably wrong here | ASSERT |
| **M14-J3** | §0.6's multiplicity rule | One datagram failing **three** conditions: version 6, protocol 1, foreign destination | Exactly three strobes, all on Ci + 3, one high cycle each | A design with a two-deep report path, or one that pulses the first two and drops the third | ASSERT |
| **M14-J4** | §9's `error_ip_truncated` interaction | (a) M14-E4's short frame; (b) a datagram rejected on a complete header whose frame then ends early | (a) `error_ip_truncated` **alone**. (b) the header rejection's strobes only — the datagram was never emitted, so there is nothing to fall short of, and its remaining octets are consumed and pulse nothing | A design that keeps the truncation check live after a header rejection and double-reports one datagram, unbalancing §0.6 | ASSERT |
| **M14-J5** | §0.6's no-re-report rule, REQ-013 | A datagram that is **rejected** on its header and carries `payload_tuser`[0] = **1** on its input `tlast` word | The local discard wins: **no payload frame**, the local strobe(s) pulse, and M14 pulses **nothing extra** for the inherited abort | A design that re-reports an inherited abort with a strobe of its own — forbidden by §0.6, and it would attribute a second report to a frame already counted | ASSERT |
| **M14-J6** | REQ-013 | An **accepted** datagram carrying `payload_tuser`[0] = 1 (families A1(b), A3, A4) | The datagram is delivered **intact** — M14 never drops or alters a frame because the bit is set (REQ-013's own sentence); it is advisory metadata bound for the application (REQ-707) | A design that treats the inherited abort as a discard condition, which would silently delete every frame M03 marked bad instead of relaying it | ASSERT |

### 4.K Structural, declared no-instance and out-of-space

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M14-K1** | REQ-003, REQ-010, §4.1 | — | Interface compile check: both streams are the programme `Axi64.Source` with no `Dest`; both header records are SPEC-M01's, unchanged; M14 declares **no** record of its own; the first compile-time witness of `Ip_header`'s seven field names | A hand-rolled record; a field name that drifted from SPEC-M01 §4.2 | STRUCTURAL |
| **M14-K2** | REQ-014 | — | `payload_tstrb` is ignored on the input and `ip_payload_tstrb` is driven 0 on the output (standing obligation 1). **REQ-014's differential run has an instance here** — the input `tstrb` exists at this port — and it is the run with the same stimulus at `tstrb` = 0x00 and 0xFF asserting byte-identical output traces | A consumer that decodes `tstrb` as a second octet mask | ASSERT |
| **M14-K3** | REQ-404, REQ-810, §6.3 item 7, §10 | — | **No instance at M14**: M14 does not re-check the ethertype (M08 routed on it) and reads no enable. Nothing is asserted, and **no `SO-` claims coverage of either REQ here** | — | STRUCTURAL |
| **M14-K4** | §6.3 item 5 | — | A payload stream violating REQ-011 or REQ-015 is **never driven**: its producer cannot emit one, so no requirement names the case and DV asserts nothing about it | — | NO-STIMULUS |
| **M14-K5** | REQ-901 class (a), §11.3 | — | Co-simulation stimulus at this boundary is **restricted to correct-checksum datagrams**: the reference performs no header-checksum verification, so a bad-checksum datagram would diverge by design. REQ-602's rejection path is verified against the **spec** by directed test only (M14-B2, M14-B3), and the co-simulation report must name class (a) | A co-simulation run that reports a divergence at this boundary as a design defect | STRUCTURAL |
| **M14-K6** | REQ-903, REQ-808 | — | `ip_eth_rx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli`; the name appears in `rtl_snapshots/` | — | STRUCTURAL |
| **M14-K7** | REQ-601, REQ-605, §6.1's partition table, §6.2's `Payload` entry condition, §9's first row, **ADR-0013** | A datagram with version 4, IHL 5, a **correct** checksum, protocol 17, an accepted destination, MF = 0, offset = 0 and a declared **total length 0, 5 and 19**, each inside a 64-octet Ethernet frame (SPEC-M14 §8's rejection-class set). **Anti-vacuity partner in the same run: total length 20** on the same frame | The three short-declared datagrams: **one `error_ip_bad_header` at Ci + 3, no `ip_hdr_valid`, no payload word** — REQ-601's discard class as SPEC-M14 §6.1 extends it (**ADR-0013**), decided on input word 0 and reported with the other header conditions. Total length **20**: **accepted** — `ip_hdr_valid` pulses at Ci + 3, no payload frame follows, no strobe (§0.7). The pair pins the partition's boundary and not merely the rejection | A design comparing total length only against REQ-612's 1500 and leaving the field's lower end unchecked; a design folding 0 … 19 into §6.2's declared-empty branch, which emits a header record for a datagram declaring a length shorter than the header it declares; a design evaluating M = ⌈(N′ − 20)/8⌉ without the guard, which enters `Payload` with a negative count. **Boundary discipline**: the 19/20 pair is the one that separates all three | ASSERT |

---

## 5. Attacks considered and rejected

Charter §8's rejected list. Each entry says why it is not a row.

1. **Random datagram fuzz over the header space.** Rejected as a substitute for
   the directed rejection classes, and for one specific reason at this module:
   §9's pulse set is a **function of the injected header bits** with no
   precedence, so a fuzz oracle is exactly as much work as the ten directed rows
   and buys coverage only of *combinations*. Worth revisiting once the header
   builder (X-8) can compute the expected pulse set, at which point J1–J3
   generalise to a sweep for free.
2. **A datagram whose IPv4 total length exceeds what the Ethernet frame can
   carry (N′ > N) *and* which is in the D ≥ 1 class.** Rejected as
   unconstructible: N′ > N is REQ-605's truncation, which §6.1 says "never
   reaches this question" — the frame is closed on the last octet that arrived
   and marked by M14's own rule (M14-A8), not by inheritance.
3. **Asserting anything about a DF-set or reserved-flag datagram** (M14-B5) —
   **withdrawn at WO-0030.** §6.3 item 4 as revised at `541ea43` narrows the
   silence to the two bits' *representation* and states the datagram's
   **outcome**, so the entry is no longer a rejection: M14-B5 is an ASSERT row.
   What survives of it is narrower and still binding — **no monitor may read DF
   or the reserved bit out of M14**, because no port and no `Ip_header` field
   carries either, so the row asserts the datagram's acceptance and never the
   bits themselves.
4. **Asserting the internal realisation** — register placement inside the
   four-cycle pipeline, the FSM encoding, how the 20-octet shift is built,
   whether the checksum accumulator is a two-halfword adder tree, whether the
   delivered count is a counter or a word index with `tkeep` (§6.3 items 1 and
   3). All are unobservable; the rows attack their consequences instead.
   Specifically, `Tail` is **not** asserted as a state — M14-A1 attacks the
   `Tail`-keyed design through its output on total length 37.
5. **Driving `hdr_valid` on the same cycle as payload word 0, or two cycles
   before it.** Outside the producer's contract (§3): SPEC-M06 §7 and SPEC-M08
   §6.1 pin the one-cycle lead and M17 is written against it. A bench that
   varied it would be testing M08, not M14.
6. **Driving two datagrams closer than the XGMII layer can deliver them**, to
   falsify §9's "the same strobe cannot be high on consecutive cycles at M14"
   (§3). The claim is conditional on the producer and the specification says so;
   attacking it needs a producer the programme does not have. The **convention**
   it depends on is still enforced — standing obligation 4 counts high cycles.
7. **A non-contiguous `tkeep` or a `tlast` with no preceding `hdr_valid`**
   (M14-K4) — §6.3 item 5.
8. **An ethertype other than 0x0800 at this port** (M14-K3) — §6.3 item 7.
9. **Asserting that the residual of ADR-0012 is harmless at the application.**
   It is not harmless and the plan does not pretend otherwise: a bad-FCS
   64-octet frame reaches the application with `tuser`[0] = 0. That is a
   system-level observable at `nic_top`, is recorded in §11.5 and ADR-0012, and
   belongs to the top-level plan and to `SO-ip_eth_rx_64.md`'s REQ-007
   statement (M14-A7) — not to a row here, which could only re-assert what
   M14-A1 and M14-A5 already assert.
10. **Loopback of M15's transmit checksum through M14's REQ-602 check** as an
    oracle for either. Rejected on REQ-202's own principle, applied one layer
    up: a systematically wrong but self-consistent checksum passes a loopback.
    The oracle is an independent one's-complement implementation anchored on a
    published worked example (X-8).

## 6. Coverage map — REQ to rows

Every REQ SPEC-M14 §10 lists appears exactly once.

| REQ | Rows |
|---|---|
| REQ-001 | M14-K1 (emitted-Verilog edge check) |
| REQ-003 | M14-I5, M14-K1 |
| REQ-004 | M14-I1 |
| REQ-005 | M14-I2, M14-I4 — **and no longer M14-F1, 2026-08-11.** F1 homed here for its *"L = 12 is unchanged under injection"* clause, which requirements.md §0.5's straddle ruling retired: M14 has **no** gap-invariant per-octet constant (h = 20), so F1 now reports per-octet latencies on an injected run as data and asserts none, and it homes under REQ-016 alone. **REQ-005's coverage is unweakened in substance** — I2 and I4 assert the constant where it holds, on the gapless stress run, which is the only stimulus on which the requirement has an instance at this module |
| REQ-007, REQ-013 | **M14-A1 … M14-A8**, M14-J5, M14-J6 |
| REQ-008 | families B, E and J (one directed test per rejection class, plus the multi-condition datagrams); standing obligation 2 |
| REQ-009 | M14-H1, M14-H2, M14-H3 |
| REQ-010 | M14-K1 |
| REQ-011 | M14-D1, M14-E1; standing obligation 1 |
| REQ-012 | M14-C1, M14-D5 |
| REQ-014 | M14-K2; standing obligation 1 |
| REQ-015 | M14-D4; standing obligation 1 |
| REQ-016 | M14-F1 … M14-F4 |
| REQ-019 | M14-I2 |
| REQ-020 | M14-I1 |
| REQ-021 | M14-D1, M14-D3, M14-D5 |
| REQ-401 | M14-E5 |
| REQ-404 | M14-K3 (declared no instance) |
| REQ-601 | M14-B1, M14-E4, **M14-K7** (the total-length lower bound, REQ-601's class as SPEC-M14 §6.1 extends it — ADR-0013) |
| REQ-602 | M14-B2, M14-B3, M14-J2, M14-K5 |
| REQ-603 | M14-B4, M14-B5 |
| REQ-604 | M14-B6, M14-B7, M14-G1, M14-G2, M14-G3 |
| REQ-605 | M14-A8, M14-D1, M14-D2, M14-E1 … M14-E7 |
| REQ-606 | M14-C1, M14-C2, M14-C3, M14-C4 |
| REQ-607 | M14-B8, M14-B10, M14-J1, M14-J3 |
| REQ-611 | M14-C2, M14-F2, M14-I3 |
| REQ-612 | M14-B9, **M14-K7** (the upper end of the same partition; K7 drives its lower end and its 20 boundary) |
| REQ-802, REQ-803 | M14-G1 … M14-G4 |
| REQ-810 | M14-K3 (declared no instance) |
| REQ-901 | M14-K5 |
| REQ-903, REQ-808 | M14-K6 |

## 7. Machinery this plan requires and does not have

Named here, **not built here** (WO-0027 deliverable 4). X-1 … X-5 are
`AP-xgmii_rx_64.md` §7's; the numbering continues from there so the two plans'
items never collide.

| # | Machinery | Which rows need it | Note |
|---|---|---|---|
| **X-6** | **An `Axi64` stream *driver*.** `test/axi64_probe/` samples a live `Source`; nothing drives one. M14's bench must drive `payload` and pulse `hdr` | every row | The counterpart of X-2 on the stream side |
| **X-7** | **The M08-output stimulus model** — the thing §8 means by "derived by construction from the XGMII case and never re-invented": an Ethernet frame from `Dv_xgmii.Frame`, minus FCS, minus the 14-octet header, presented as one `hdr_valid` pulse and the payload words, with §8's 4-and-5 idle alternation preserved | every row; M14-I1 in particular | Composing it from the existing link-partner model is what keeps the two benches' stimuli provably the same frames |
| **X-8** | **An IPv4 header builder and an independent one's-complement checksum oracle**, in `test/golden/` (the oracle's home, deliberately outside `tools/**`). It must (a) build a header from field values, (b) compute the checksum by an implementation that shares no structure with any design, (c) verify by §6.1's residue form (all ten halfwords, including the checksum, sum to 0xFFFF), and (d) be **anchored on a published worked example** before it judges anything — RFC 1071's, which is exactly the discipline `Crc32_ref` follows against REQ-303's 0xCBF43926 | every row; M14-B2, M14-B3, M14-I1 decisively | Charter §3's anchor-before-judge rule. M14-B3's two-fold headers must be **constructed** by search over the field space, which is the builder's job, not the bench's |
| **X-9** | **Per-datagram removed-tail support in the latency tagger.** `Latency.create` takes `~tail_octets` as a **run** constant and `frame_out` requires the output length to equal (input − strip − tail). At M14 the removed tail is the Ethernet padding **N − N′, which varies per datagram**, and on the truncation rows the output is shorter still. Needed: a per-frame expected output extent | M14-I2 and every directed length row; family E entirely | The same repair as X-5 at M03 (where the short frames are aborts rather than padding). One item, two customers — worth doing once |
| **X-10** | **An OCaml D oracle** — `D = ⌈N/8⌉ − ⌈(N′ − 20)/8⌉ − 3` and the expected `ip_payload_tuser`[0] — so family A asserts against a computed value rather than against six hand-copied constants, and so a later reader adding a length gets the right expectation for free. `tools/check_abort_availability.sh` already computes this exhaustively from spec text and stays as the **independent cross-check**, not as the bench's oracle | M14-A1 … M14-A6 | Two implementations of one formula, one in each language, is the cheapest protection this plan has against the arithmetic error that created C-37 in the first place |
| **X-11** | **The strobe monitor (X-3)**, with M14's seven names and their pinned cycles: Ci + 3 for the six header conditions, one cycle after the input `tlast` for `error_ip_truncated`, and one cycle after the **next** `hdr_valid` for a payload-less frame | families B, E and J | X-3's (b) expected-cycle check is what makes M14-E5's unusual pinned cycle testable at all |

Not gaps: `Conservation_monitor`'s exemptions (C-2/C-30) exist and M14-H2 uses
them; `Protocol_monitor`'s `max_words_per_frame` covers REQ-015's 185.

## 8. Open questions and rulings requested

Routed through the orchestrator to architect_docs_lead. Neither blocks the other
rows.

> **Both ANSWERED at `541ea43` (WO-0029) and countersigned at WO-0030**
> (`J-dv_lead-0015`). Question 1 → **ADR-0013**, dv's recommendation accepted
> with a **better ground** than the one recommended: requirements.md decides the
> disposition one document up, because REQ-605's "deliver exactly
> (total length − 20) payload octets" has no satisfying behaviour on the class,
> so the datagram cannot be *delivered*, and REQ-008/§0.6 then forbid discarding
> it silently — leaving only *which* of §12's seven names, which is the whole of
> what the ADR chooses. That scoping of REQ-605 to *accepted* datagrams is not
> an assumption: REQ-612 is its internal precedent, since a 1501-octet
> declaration is discarded without REQ-605 demanding 1481 delivered octets.
> M14-K7 **RULING → ASSERT**. Question 2 → §6.3 item 4 rewritten, M14-B5
> **NO-ASSERT → ASSERT**; the architect added the checksum recompute, without
> which dv's proposed stimulus is rejected by REQ-602 and the comparison is
> vacuous. **Two residues, both carried, neither blocking**: **C-43** (the diff
> that *is* owed, and it is not REQ-601's normative sentence) and **C-44**
> (dv's own "only stimulus" overclaim in question 2 below, false as written).
> §5 item 3 is withdrawn accordingly.

1. **M14-K7 (RULING) — a declared IPv4 total length below 20.** SPEC-M14 §6.1's
   field table justifies "total length ≥ 20" as holding "by construction of
   REQ-601's IHL check". **It does not**: IHL constrains the header length, and
   the total-length field is 16 independent bits an adversary controls. A
   datagram with version 4, IHL 5, a correct checksum, protocol 17, an accepted
   destination, MF = 0, offset = 0 and total length 0 passes all six header
   conditions and reaches §6.2's `Header` row, which branches on *declared
   payload empty* (total length 20) versus *non-empty* — and this datagram is
   neither. §6.1's own M = ⌈(N′ − 20)/8⌉ is negative for it, so the D arithmetic
   is undefined on the class as well. This is C-26's family (a reachable band
   the branch conditions do not cover) and it is **found by writing the attack
   plan rather than by a bench going red**, which is what attack plans are for.
   Three readings are enumerated in the row. **Recommendation**: fold it into
   REQ-601's class — `error_ip_bad_header`, nothing emitted, decided on input
   word 0 with the version and IHL checks — because the datagram is malformed in
   the same way and at the same cycle, it needs no new strobe, no new REQ and no
   port, and §9's Ci + 3 pinned cycle already covers it. The alternative
   readings each add a case to a branch that C-26 has just been repaired to make
   exhaustive.
2. **M14-B5 — a coverage hole §6.3 item 4 creates, stated so it is not
   discovered later.** REQ-603 constrains more-fragments (octet 6 bit 5) and the
   fragment offset; §6.3 item 4 forbids DV from asserting **anything** about a
   datagram that sets DF (bit 6) or the reserved bit (bit 7). The consequence:
   a design that reads the **wrong bit** of octet 6 for more-fragments is
   **unkillable at M14** — the only stimulus that distinguishes it is a DF-set
   or reserved-set datagram, on which no assertion may be made. The cheap repair
   is one sentence in §6.3 item 4 or in §9: a datagram with DF or the reserved
   bit set, MF clear and offset 0 meets **no** discard condition and is
   therefore accepted — which is already what REQ-603 and §9's row list say
   between them, and which would convert an unkillable defect into a one-line
   row here. Not blocking: the plan carries the hole as a declared gap either
   way.

   **Correction to this question, made against myself (C-44).** The sentence
   "the only stimulus that distinguishes it is a DF-set or reserved-set
   datagram" is **false** for the defect it names. A design reading octet 6 bit
   6 *instead of* bit 5 for more-fragments **accepts** M14-B4's MF-set datagram,
   which §8's rejection-class set already drives and which the plan already
   asserts is discarded with one `error_ip_fragment` and nothing emitted — so
   that defect was never unkillable at M14. What the flag-bit pair uniquely
   kills is the **over-broad** read: a design testing `flags != 0`, or bit 6 or
   bit 7 *in addition to* bit 5. That class really is invisible to every other
   row, so the pair earns its place; the justification, not the row, was wrong.
   The overclaim travelled into SPEC-M14 §6.3 item 4 and §10's REQ-603 hook at
   `541ea43`, which is why it is carried as a ledger row rather than corrected
   only here.

3. **`FINDING AP-M14-1` (MINOR, mine, against SPEC-M14 §7 — filed 2026-08-11
   while repairing this plan's own family F, and NOT decided here).** §7 states
   two things about `ip_hdr_valid` that cannot both hold under REQ-016 injection
   at one site, and the site is the first payload gap:
   - **(A) the adjacency**, stated unscoped: `ip_hdr_valid` is *"high for exactly
     one cycle per accepted datagram, on the cycle before that datagram's first
     payload word"* — and §6.1 says in terms that *"the lead is normative here and
     not incidental"*, M17 being written against it;
   - **(B) the per-output-event table**, in the same section: `ip_hdr_valid`'s
     deciding input word is **input word 2** at a delay of **1** cycle, and
     payload word 0's is **input word 3** at a delay of **1** cycle.

   With `k ≥ 1` idle cycles injected **between input words 2 and 3**, (B) puts the
   pulse at `C₂ + 1` and payload word 0 at `C₃ + 1 = C₂ + k + 2` — a lead of
   **1 + k** — while (A) demands a lead of exactly 1. **Everywhere else the two
   agree**, because gaplessly `C₃ = C₂ + 1`; and **no committed stimulus reaches
   the conflict**: §8's stress run puts its idle cycles *between frames* and
   delivers each datagram's words on consecutive cycles, which is why this
   survived the 2026-08-11 repair that rewrote the same bullet.

   **Consequence, and it is a bench consequence and not a design one.** M14 has no
   RTL and no bench, and no pinned number moves on either reading. What moves is
   what `M14-F1` may assert at injection site (a), so **that row asserts neither
   lead** and is unmoved by the ruling in either direction — the discipline
   `AP-M04-1`, `AP-M04-2`, `CSG-3` and `ABS-1` all used at the sibling plan.

   **Recommendation, offered because a finding without one is a complaint.**
   Scope (A) the way §7 already scopes its own 3-cycle parse latency under C-27:
   *exactly one cycle before the first payload word on a datagram delivered
   without idle cycles between input words 2 and 3; under REQ-016 injection at
   that site the lead grows by the injected count.* Nothing downstream loses by
   it — REQ-606 asks for the record *on or before* the first payload word, and a
   lead of `1 + k` satisfies that **a fortiori**, giving M17 more time and not
   less, while §6.3 item 2's rule (the six field values are valid only on the
   pulse cycle) is a validity rule that does not depend on the lead's length.
   **The sites, listed by grep so the ruling's site list is not one entry short**:
   §5's `ip_hdr_valid` interface-record row, §6.1's *"therefore falls exactly one
   cycle before"* paragraph, §7's handshake bullet, §10's REQ-606 hook, and §8's
   stress paragraph (gapless by construction — a note, not a change).
   **Route**: architect_docs_lead, spec-diff request via the orchestrator.

## 9. Change log

| Date | Change | Author |
|---|---|---|
| 2026-08-02 | Created (WO-0027). **63 rows** across 11 families (A 8, B 10, C 4, D 5, E 7, F 4, G 4, H 3, I 5, J 6, K 7) — 49 ASSERT, 5 NO-ASSERT, 2 NO-STIMULUS, 1 RULING, 6 STRUCTURAL. Family A is C-37/ADR-0012 and comes first (§0). | dv_lead, `J-dv_lead-0013` |
| 2026-08-03 | **WO-0030, on the SPEC-M14 revisions COUNTERSIGNED at `541ea43`.** **M14-K7 RULING → ASSERT** (ADR-0013): stimulus unchanged — total lengths 0, 5, 19 — with the observable now pinned (one `error_ip_bad_header` at Ci + 3, no `ip_hdr_valid`, no payload word) and a **total-length-20 anti-vacuity partner** added so the row pins the partition boundary rather than only the rejection. **M14-B5 NO-ASSERT → ASSERT** (§6.3 item 4 as revised), with the architect's **checksum recompute** carried into the stimulus and the *Kills* cell narrowed to the over-broad-read class. §5 item 3 **withdrawn**; §6's REQ-601 and REQ-612 rows lose their `(RULING)` marks; §8 gains the answer block and the C-44 self-correction. Row count and family structure unchanged; the plan is now **51 ASSERT, 4 NO-ASSERT, 2 NO-STIMULUS, 0 RULING, 6 STRUCTURAL**. | dv_lead, `J-dv_lead-0015` |
| 2026-08-03 | **WO-0033, the machinery.** §7's items **X-8** (`test/golden/ipv4_ref.ml`, the IPv4 header builder and one's-complement oracle, anchored on **RFC 1071 §3**'s numerical example — embedded with its citation and, at this SHA, **unconfirmed**: this environment's proxy refuses `rfc-editor.org` and `datatracker.ietf.org` with 403, so re-fetching the quotation is an open obligation on `SO-ip_eth_rx_64.md`) and **X-9** (the per-frame output extent on `Dv_monitors.Octet_time.Latency.frame_out`, one repair shared with M03's X-5) are **built**. **X-6** (the `Axi64` stream driver, `test/axi64_probe/axi64_driver.ml`) is built and is the counterpart this plan's every row needs. **X-7**, **X-10** and **X-11** are **deferred** to a second sitting, with reasons in the WO-0033 Return log. **One row changes**: **M14-B3** sub-case (a) is **WITHDRAWN as unbuildable** and the row's kill restated — new ledger row **C-48**, found by building the oracle rather than by a bench going red, and stated against dv_lead's own text. Sub-case (b) carries the row and is now constructed by search rather than by hand. Status counts unchanged: 49 ASSERT, 5 NO-ASSERT, 2 NO-STIMULUS, 1 RULING→ASSERT at WO-0029, 6 STRUCTURAL. | dv_lead, `J-dv_lead-0017` |
| 2026-08-03 | **WO-0037, the anchor confirmed and one of its claims withdrawn.** The WO-0033 row above recorded X-8's RFC 1071 anchor as **embedded and unconfirmed** after five 403s. Run **30764198256** — the first on an open-egress runner — fetched RFC 1071 (53,524 B, sha256 `e10dfd68…`) and returned **NOT CONFIRMED**, correctly, against dv_lead's own extractor. Two defects, both dv_lead's, both repaired: (1) the extractor matched §3's column-aligned `Byte 0/1:    00   01` as a single-spaced literal and its prose probes could not survive the RFC's line wrapping; (2) **`rfc1071_example_checksum` was cited to §3, which does not print it — the token `220d` occurs nowhere in RFC 1071.** The constant is correct and is now recorded as **DERIVED** from §3's quoted sum by §1 item (2)'s rule, not quoted. The check now gates on five scoped claims (octets + sum in §3, the checksum's defining sentence and the residue sentence in §1, byte-order independence in §2), a negative control, and the gated absence of `220d`. **§2's citation for byte-swap invariance is CONFIRMED** — property (B), §2's second — where it had been asserted from memory. **No row changes and no status-count change**: M14-B2/B3/I1's stimuli are untouched, because the arithmetic was never in doubt (the local lane proved the constants consistent throughout) — what was wrong was a provenance claim about where one of them came from. | dv_lead, `J-dv_lead-0021` |
| 2026-08-11 | **Family F repaired against requirements.md §0.5's straddle ruling — three rows that had been stale for a week, one of them an `ASSERT` that fails a conformant M14.** The rows were written against the reading that M14's per-octet constant **L = 12** is gap-invariant; §0.5 retired that reading on **2026-08-04** (M14 straddles, h = 20 being no multiple of 8, so every payload word is assembled from positions 4–7 of one input word and 0–3 of the next and an idle between them gives one output word two latencies), and SPEC-M14 §7, §3's REQ-016 row, §6.1's gapped paragraph and §10's REQ-016/REQ-611 hooks were all repaired at `816e187`. **This plan was not**, and nothing in the repository recorded it until `J-dv_lead-0170` read the requirement the rows derive from. **`M14-F1`** — its struck clauses are *"the per-octet constant L = 12 is unchanged for every octet; every octet is delayed by exactly 8 octet times per injected cycle"* and *"`ip_hdr_valid` still leads payload word 0 by one cycle"* — now asserts what §7's **per-output-event table** supplies: the ordered (`tdata`, `tkeep`, `tlast`, `tuser`) sequence unchanged with every octet keeping its byte position, and each output event delayed by exactly the idles injected **at or before its deciding input word** (payload word `j` ← input word `j + 3`, 1 cycle; the last payload word of a frame ending at input word `j + 2` ← the input `tlast` word, 2 cycles; `ip_hdr_valid` and §9's first six strobes ← input word 2, 1 cycle; `error_ip_truncated` ← the closing event's word, 1 cycle). Per-octet latencies on an injected run are **reported as data and asserted nowhere**, on §10's own hook. Its stimulus now **enumerates its injection sites** rather than leaving them to a bench writer, because the first payload gap — between input words 2 and 3 — is the only site at which the repair bites and a wrapper that skips it tests the easy case. **`M14-F2`** keeps and **strengthens** its parse-latency half (3 + k from input word 0, asserted) and gains the quantity that actually discharges REQ-611's gap clause — **the delay from `ip_hdr_valid`'s deciding input word, input word 2, exactly 1 cycle on every stimulus** — while its trailing *"L = 12 is unchanged"* is struck. **`M14-F3`**'s ground *"the gap-invariant quantity is L = 12 and that is what M14-F1 asserts"* is replaced by the per-output-event table; **its prohibition is unchanged**, and it is the row that shows why this class rots quietly — nothing fails when a *reason* goes stale, because the rule it supports still reads correctly. **§6's coverage map: `M14-F1` is removed from REQ-005's line** (it no longer asserts a per-octet constant anywhere) and REQ-005 stands on `M14-I2` and `M14-I4`, the gapless stress rows, which is the only stimulus on which that requirement has an instance here; F1 stays homed under REQ-016. **STATUS COUNTS AND ROW COUNT ARE UNCHANGED, re-measured at this tree before and after: 63 rows, 51 ASSERT, 4 NO-ASSERT, 2 NO-STIMULUS, 6 STRUCTURAL, 0 RULING** — `M14-F1` stays an `ASSERT` of a **different observable**, which is the whole shape of this repair. **ONE FINDING MINTED, ROUTED AND NOT DECIDED: `FINDING AP-M14-1` (MINOR, mine, §8 item 3)** — SPEC-M14 §7 states the `ip_hdr_valid` adjacency (*"the cycle before that datagram's first payload word"*, normative per §6.1 because M17 is written against it) unscoped, while its own per-event table puts the pulse at input word 2 + 1 cycle; under `k ≥ 1` idles injected between input words 2 and 3 the two cannot both hold, the lead being `1 + k`. **Found by repairing my own row**, unreachable by any committed stimulus (§8's stress run gaps *between* frames), and `M14-F1` is written to be unmoved by either ruling. **Owed before any M14 bench, and no M14 bench exists**; the recommendation offered is to scope the adjacency exactly as §7 already scopes its own parse latency under C-27, since REQ-606 asks for the record *on or before* the first payload word and a grown lead satisfies it a fortiori. Carrier for the residue: architect_docs_lead, via the orchestrator. | dv_lead, `J-dv_lead-0177` |
