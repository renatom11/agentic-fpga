# WO-0004: Apply the WO-0003 spec diffs (D-1 … D-16)
- **State**: RETURNED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: agents/handoffs/WO-0003_testability-findings.md at 9a6195a
  (the sixteen diffs D-1…D-16, §14.3, and the cross-cutting findings
  X-1…X-10 that motivate them); docs/specs/requirements.md at 08899d3 (your
  file under revision); WO-0003's ACCEPTED entry (orchestrator rulings,
  including the confirmed CRC constants)
- **Deliverables**:
  - Revised `docs/specs/requirements.md` — all sixteen diffs applied or
    individually contested (see Task). The two constants are already
    adjudicated: REQ-303 check value → `0xCBF43926`, REQ-304 residue →
    `0x2144DF1C` under REQ-301's stated convention (independently confirmed
    by the orchestrator with zlib; do not re-litigate, do cite).
  - Revised `docs/specs/traceability.md` — rows updated wherever a diff
    renumbers, splits, adds, or deletes a REQ; the REQ-set/row-set equality
    must survive (the orchestrator re-checks it at acceptance).
  - `docs/specs/architecture.md` and/or `docs/specs/SPEC-TEMPLATE.md` edits
    ONLY where a diff explicitly requires transcription or reconciliation
    (e.g. the D-3 IFG/line-rate convention must end up stated identically in
    §0 and REQ-004/REQ-204 — one convention, both documents).
  - A `## Spec-diff record — WO-0004` section appended to the findings
    file? NO — the findings file is dv_lead's; instead record the
    disposition table (D-n → applied/contested, one line each) in the
    Return log below and the detail in your journal entry.
  - Journal entry `J-architect_docs_lead-0002` per PROTOCOL §4;
    Files-in-this-commit listing exactly the docs/specs files you touched
    plus this packet.
  - Return log entry below (state → RETURNED).
- **Definition of done**: every one of D-1…D-16 either applied or contested
  with a stated technical reason (a contest is not a veto — it goes back to
  dv_lead with the orchestrator arbitrating); the D-3 convention collision is
  resolved to ONE stated IFG/line-rate convention used consistently
  everywhere (your §0 derivation and REQ-204 currently disagree — pick the
  one you can defend against IEEE 802.3 deficit-idle-count behavior and
  restate the other); the four UNTESTABLE rows (REQ-019, REQ-510, REQ-802,
  REQ-901) each end up testable, deleted, or explicitly re-scoped; the two
  arithmetic slips (REQ-408 "50 octets"→46; REQ-605 padding example) fixed;
  REQ/traceability set equality holds.
- **Context provided**: dv_lead judged 55 rows immediately workable and
  called the document good — this is a surgical revision, not a rewrite.
  Most diffs are one sentence; several are transcriptions of material
  already in architecture.md. dv_lead's countersignature will be sought
  against your post-diff text (follow-up WO), so precision here shortens
  the loop.
- **Out of scope**: new requirements beyond what the diffs demand; RTL;
  tests; per-module specs; edits outside docs/specs/** and this packet.
## Task
Apply the review. Where you disagree with a diff, contest it explicitly in
the Return log with the technical reason — silent partial application is the
one unacceptable outcome, because dv_lead re-reviews against the diff list.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-02T02:35Z, journal `J-architect_docs_lead-0002`

**All sixteen diffs applied. None contested outright. One (D-4) is applied with
a corrected metric — the stated formulation is not satisfiable and the note
below is a partial contest of the wording, not of the intent.**

#### Per-diff disposition

| id | Disposition | Where it landed / why |
|---|---|---|
| **D-1** | applied | New normative §0.4: receive-path chain, its streams, the structural-module rule (a wrapper is receive-path only on the ports that lie on the chain, so `Nic_top`'s application transmit `Dest` is not a REQ-003 violation), and the stress-bench list **by name**. Restated in REQ-003, REQ-004, REQ-905 and SPEC-TEMPLATE §3/§8. One correction to the findings: the list is **seven** modules, not five plus `nic_top` — M10 `Arp_eth_rx` is marked **R** in architecture §4 and was omitted from §14.3's enumeration. Final list: M03, M06, M08, M10, M14, M17, M20, with M10's stimulus stated as 10 000 minimum-length ARP packets. |
| **D-2** | applied | §0.3 states the DA-through-FCS convention once, with the three consequences a test writer needs. REQ-408 `50` → **46**. REQ-605's example replaced with a **total length 28** datagram, which leaves 18 octets of Ethernet padding to remove — the old example had none. REQ-005 and REQ-103 length sets replaced with **64 through 71 inclusive plus 1518** (all eight `tlast` `tkeep` patterns; delivered 60–67 and 1514). REQ-708's stimulus stated exactly: IPv4 total length 46, UDP length 26, **18 octets** of UDP payload. |
| **D-3** | applied | Resolved to **one** convention: the gap is measured **from the terminate character inclusive**, minimum 12 octets. Stated identically in requirements §0.3, REQ-004, REQ-204 and architecture.md §1 — all four sites, no stale copy. Defence and the DIC argument are in the note below. |
| **D-4** | applied, metric corrected | Adopted per-octet latency, but measured in **octet times** (§0.5), not in cycles. Applied to REQ-005, REQ-006, REQ-101, REQ-111, REQ-210, REQ-611 and SPEC-TEMPLATE §7. REQ-019 gains its observable: architecture §4's ceilings are transcribed into requirements §1.1 and made normative, compared as floor(L / 8). **Partial contest of the stated formulation**: the cycle-counted per-octet difference is *not* constant under a lane-4 start. With a lane-4 start, frame octets 0–3 arrive in input word N+1 and octets 4–7 in word N+2, while both leave in output word 0 — so the per-octet latency in cycles alternates between two values *inside one frame*, and a bench built on §5's wording would fail a conformant `Xgmii_rx_64`. In octet times (8 × cycle + lane, or 8 × cycle + byte position) the realignment cancels exactly: a module stripping h octets has L = 8(Co − Ci) − h for every octet, at every start lane and every header length. This is dv_lead's intent, made satisfiable; the tagger described in findings §13.3 needs only to record lane/byte position alongside the cycle. |
| **D-5** | applied | §0.6 states precedence normatively: a module that has emitted a word forwards and marks `tuser`[0]; a module that detects its condition first emits nothing and its strobe is the only report; a local discard beats an inherited abort; an inherited abort is **never** re-reported with a strobe; each locally detected applicable condition pulses once. Strobe timing window added (not before the condition is decidable, not later than the module's latency in cycles after the frame's last input word). REQ-007, REQ-013 ("this frame was found invalid; the ultimate consumer must discard it", plus the explicit no-Phase-1-module-drops-on-it rule) and REQ-403 restated; SPEC-TEMPLATE §9 now requires each spec to state which conditions co-occur. |
| **D-6** | applied | Frame conservation is normative in §0.6 and is clause (b) of REQ-008's verification; REQ-020 restated as "strictly increasing subsequence, every omission accounted for by exactly one discard-strobe pulse". The conservation identity carries a third term for zero-payload frames reported by a header pulse (§0.7), so it stays exact. **Also resolved** the `dedicated strobe` contradiction the finding raises rather than weakening REQ-008: REQ-110 gets its own **`error_start_without_terminate`**, so §12 is twenty-one names for twenty-one conditions and no strobe is shared. |
| **D-7** | applied | Resolved in favour of keeping REQ-011 intact: a zero-length payload has **no** stream encoding, and a stage whose output would be a zero-octet frame emits **no payload frame**. Where the stage emits a header record (M06, M14, M17) the header `valid` pulse is the report and downstream modules SHALL tolerate a header with no payload frame; where it does not (M03) a strobe is the report. §0.7 lists every governed case. REQ-011, REQ-401, REQ-402 (`0-` → `1-`), REQ-605, REQ-703 and REQ-707 all restated against it. Rejected the alternative (permit `tkeep` = 0 on a `tlast` word): it weakens the strongest interface invariant in the document and complicates every monitor to encode an event the header channel already carries. |
| **D-8** | applied | Chose option **(b)**: `clear` truncates the in-flight output frame without a terminating word. Option (a) — forcing a final `tlast`/`tuser` word — contradicts REQ-009's own "every `tvalid` is 0 while `clear` is 1". REQ-009 carries the tightened wording verbatim from the finding; REQ-015 is restated as the checkable residue (at least one word, at most the stream's pinned maximum, no `tlast` without a preceding word) and its monitor is explicitly exempted across a clear. |
| **D-9** | applied | REQ-102: a **control** lane in a preamble position is not preamble — `/T/` goes to REQ-106/107, `/S/` to REQ-110, anything else to REQ-105, with test cases added. REQ-105: last delivered octet is the one preceding the error character (the REQ-106 rule), verification extended to all eight lanes. REQ-107: frames below 5 octets produce no output word and pulse `error_runt` once. REQ-108: **1514** delivered octets, and `error_bad_fcs` explicitly does **not** pulse (no FCS exists at the truncation point). REQ-110: same boundary rule, lane-4 case called out. Unified by one new sentence in REQ-103: FCS stripping applies **only** to a frame that ends with a terminate character. |
| **D-10** | applied | REQ-303 → **0xCBF43926**; REQ-304 → **0x2144DF1C**. Not re-litigated: a provenance note under §4 records both independent computations (dv_lead findings §13.5; the orchestrator's zlib re-verification in the WO-0003 ACCEPTED entry) and explains that 0xC704DD7B is the same residue in the non-reflected convention. REQ-202 now states the FCS is transmitted **least significant octet first** and requires comparison against the REQ-305 software reference, with the receiver/residue loopback demoted to a supplementary check. |
| **D-11** | applied | REQ-705 defines **payload length** once: the count of UDP payload octets, excluding the 8-octet UDP header and every lower-layer header. REQ-610 restated as total length = payload length + 28 and UDP length = payload length + 8. REQ-705's ordering criterion replaced by the **invariance** criterion (same number of application words accepted before the first wire octet, at every payload length), which REQ-610 also cites. |
| **D-12** | applied | New **REQ-810** gives both enables a behavioural, testable requirement (receive enable 0: no output word, no header `valid`, no strobe — no frame is accepted, so no silent-discard hole; transmit enable 0: no new frame started, `tready` held low, an ARP reply meanwhile dropped under REQ-510; both effective at the next frame boundary on their own path). New normative §9.1 gives all twelve configuration fields a width, reset value, permitted range and the REQ that gives the field meaning — `cfg_ifg` below 12 is now prohibited rather than merely unmentioned. REQ-802's verification no longer commissions tests it cannot name. |
| **D-13** | applied | REQ-016 scoped to receive-path and internal frame streams, with `Xgmii_tx_64`'s source interface excluded by name, and its idle-tolerance obligation quantified (k idle cycles delay the octets by exactly 8k octet times). REQ-206's threshold defined as the single cycle in which the transmitter asserts `tready`, requires a word and does not get one; "there is no elastic buffer" stated explicitly so the stimulus is constructible. |
| **D-14** | applied | REQ-502: target hardware and protocol addresses are the request's sender fields (RFC 826), plus the two measurement events for the 64-cycle bound. REQ-505: the transmit path keeps accepting and discarding the datagram's remaining words (never stalls the application), and a further miss for an address with a resolution already outstanding issues no additional request — so 1 000 datagrams produce 1 000 strobes and one request. REQ-507: full class precedence (limited broadcast, subnet broadcast, multicast, on-subnet, gateway) and the subnet predicate stated. REQ-510: **at most one pending reply**, a reply generated while one is pending is dropped with a single strobe — provoked deterministically by two back-to-back requests, so the REQ-804 gate item is reachable. |
| **D-15** | applied as a split | REQ-709 is now under-delivery only (REQ-206 remedy, both `error_underflow` and `error_tx_length_mismatch`). New **REQ-710** covers over-delivery: the frame is already complete and well formed on the wire, so it is finished at the declared count, the excess words are accepted and discarded (no application stall), `error_tx_length_mismatch` pulses and `error_underflow` explicitly does not. |
| **D-16** | applied | REQ-901 now states the comparison is **transactional** (same ordered output frames — octets, `tkeep` extents, `tuser`[0] — and the same accept/discard decision per input frame), explicitly excludes cycle alignment and latency constants, cross-references architecture §4's counterpart column and §5's merged wrappers as the comparison boundaries, and enumerates all **four** divergence classes (REQ-602 checksum, REQ-504 cache organisation, REQ-505 discard-on-miss, REQ-706 zero checksum) with the rule that a later class must be added by spec diff before a sign-off packet may cite it. |

#### The D-3 convention, and why this one

Chosen: **the inter-frame gap is measured from the terminate character
inclusive, minimum 12 octets.** dv_lead's lane-by-lane walk is confirmed; the
independent reason to prefer it is the frame budget. 8 octets of preamble and
SFD + 64 octets of frame + 12 octets of gap = 84 octets = 67.2 ns = 14.88 Mpps,
which is the minimum-frame rate IEEE 802.3 fixes and which is identical at
1 Gb/s, where there is no terminate character and all twelve gap octets are
idle. Counting `/T/` inside the twelve is what keeps the budget speed-invariant;
the alternative makes 10 Gb/s the only speed whose minimum-frame budget is 88
octets.

Against deficit idle count, which is the reason the collision was subtle:
because XGMII start characters may sit only in lane 0 or lane 4, a gap must be
rounded up to a multiple of 4, and IEEE 802.3 clause 46 lets a transmitter
recover that rounding later (never going below 9 octets) so its **average** gap
is 12. Phase 1 takes the two sides of that asymmetrically, and both REQ-004 and
REQ-204 are now correct simultaneously:

- **Receive** assumes a DIC-capable partner alternating lane-0 and lane-4
  starts, which realises 84 octets exactly — spacing 10, 11, 10, 11 cycles.
  That is the worst case the receive path must survive, so it is what REQ-004
  and every stress bench drive.
- **Transmit** has DIC out of scope (§11) and starts on lane 0 only, so it
  rounds every gap up to the next lane-0 boundary: 16 octets from `/T/`
  inclusive, one minimum frame per 11 cycles. REQ-204's "88 octets start to
  start" and REQ-209's 11 cycles are unchanged and are now stated as equalities.
  A transmitter that never shortens a gap below 12 is 802.3-legal; it
  under-uses the link rather than violating the standard.

#### The four UNTESTABLE rows

| REQ | Outcome |
|---|---|
| **REQ-019** | **Testable, plus an explicit re-scope.** The DV-verifiable half is now the per-module latency ceiling (§1.1, normative, compared as floor(L / 8)); the buffer-depth sentence is kept as design guidance and is **marked in the REQ itself** as not a DV observable, with a matching note in `traceability.md`'s open dependencies so no sign-off packet can read `COVERED` as evidence about buffer depth. |
| **REQ-510** | **Testable.** The drop condition is now concrete and reachable: at most one pending reply, and a reply generated while one is pending is discarded with a single strobe. Two back-to-back requests provoke it deterministically, which also unblocks the REQ-804 gate item and REQ-208's verification. |
| **REQ-802** | **Re-scoped, with the missing behaviour added.** REQ-802 is now purely the record contract against the new normative §9.1 table (width, reset value, permitted range, owning REQ per field); the two fields that had no behaviour got one, as **REQ-810**. Its verification cell no longer commissions two tests that cannot be written. |
| **REQ-901** | **Testable.** Comparison granularity, boundaries and all four divergence classes are stated (see D-16). |

#### Beyond the sixteen — applied, flagged here for dv_lead's re-review

These are not new requirements beyond what the diffs demand; they are the
findings' own §14.4 items and cross-cutting notes, applied because they are
entangled with the sixteen and because leaving them would cost a second round.

1. **New §12, normative strobe appendix** — twenty-one strobes with condition,
   owning REQ and owning module. This is what makes REQ-008 and REQ-804
   enumerable and gives the status record its field list; it adds no REQ.
2. **§0.1 replaces the false "sole test-derivation basis" claim** (X-3) with
   "this file plus the owning module's frozen specification", and names the four
   classes of fact that deliberately live in the module spec — latency
   constants, the transmit request handshake, per-stream maximum word counts,
   and the co-simulation module pairing.
3. **REQ-018 now restates the DV link-partner contract** (X-8) so it is citable
   from requirements.md alone, and its method is a **whitelist** (no module
   outside the architecture §4 inventory) instead of an unbounded vendor-name
   blacklist; PTP is named in the prohibition list, which repairs the §11 row.
4. Editorial rows applied as the findings phrase them: REQ-002 (compile check
   only; kind corrected INV → IFC, and the traceability row with it), REQ-010
   (type-identity witness), REQ-011 (`tvalid` = 1 qualification), REQ-012 and
   REQ-409 (MAC and IPv4 worked examples), REQ-014 (differential `tstrb` run),
   REQ-101 (ordered sequence of valid words, not waveform equality), REQ-104,
   REQ-109 (pipeline drain), REQ-113, REQ-202, REQ-207, REQ-208 (strobe, not
   counter), REQ-209 (equality), REQ-210 (measured from idle), REQ-406 (tie
   deliberately unconstrained), REQ-501 (operation field and minimum length),
   REQ-503, REQ-506 (three defaults, ranges, post-exhaustion behaviour),
   REQ-508 (subnet broadcast defined), REQ-509 (a bit-23 test address),
   REQ-602 (RFC 791 §3.1), REQ-806 (per start lane), REQ-808 (types-only M01
   excluded), REQ-903/REQ-904 (mechanical checks).

#### Companion-document reconciliation

- `architecture.md` §1 — the IFG convention and the DIC asymmetry, stated
  identically to requirements §0.3 (D-3's "one convention, both documents").
  §4 — the Path column marked descriptive with the normative definition pointed
  at §0.4; the latency table marked as transcribed into §1.1 with a
  change-together note. §3 — the stub contract marked as restated in REQ-018.
- `SPEC-TEMPLATE.md` §3 (receive-path membership decided by §0.4), §7 (latency
  in octet times, per start lane, against the §1.1 ceiling), §8 (the stress
  obligation rewritten to the corrected IFG convention, the per-boundary
  stimulus rule, the all-accepted rule, and the vacuous "asserts no
  backpressure" criterion replaced by the structural statement), §9 (each spec
  must state which conditions co-occur).

#### Set equality and counts

REQ count **108 → 110** (REQ-710, REQ-810 added; nothing renumbered, nothing
withdrawn — ids stay permanent). `traceability.md` counts table, block ranges
and rows updated; re-checked mechanically at this working tree:

```
diff <(grep -o '^| \*\*REQ-[0-9]\{3\}' docs/specs/requirements.md   | grep -o 'REQ-[0-9]*' | sort) \
     <(grep -o '^| REQ-[0-9]\{3\}'     docs/specs/traceability.md   | grep -o 'REQ-[0-9]*' | sort)
  -> no output (REQ set equals row set; 110 each)
awk -F'|' '/^\| \*\*REQ-/ && NF!=6 {print} /^\| REQ-/ && NF!=9 {print}' \
    docs/specs/requirements.md docs/specs/traceability.md | wc -l
  -> 0 (no malformed requirement or matrix row)
```

#### For the orchestrator

1. **Two REQs were added** (REQ-710, REQ-810). Charter §7 makes adding a
   requirement an E2 class. My reading is that neither is a scope change —
   REQ-810 gives observable meaning to two fields REQ-802 already declared, and
   REQ-710 splits an existing obligation into the two physically different cases
   D-15 identifies — so I applied them in-role rather than blocking the WO. If
   you read either as scope, it needs a sponsor decision before freeze.
2. **`error_start_without_terminate` is a new normative strobe name** (21 total,
   §12). No RTL exists yet, so this costs nothing now and it keeps REQ-008's
   "dedicated strobe" wording literally true.
3. **Nothing was changed in dv_lead's findings file**, and nothing outside
   `docs/specs/**`, this packet and my journal was touched.

**Handoff**: ready for the dv_lead re-review WO against this post-diff text.
`docs/specs/ifc_check/` is unaffected by this work order — no interface record
changed, so the green `build` run at 81acc2c still stands as the compile
evidence.
