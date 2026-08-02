# WO-0014: Batch D specifications (ARP family) + the WO-0013 diff set
- **State**: RETURNED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: architecture.md §4 rows M10–M13 and §8 batch D; the
  FROZEN batches A–C (M06/M08 records are batch D's upstream vocabulary);
  the WO-0013 Return log at the countersign commit (C-16, the five C-17
  items, C-18 — dv supplies exact analyses there); dv's C-15 text
  (WO-0012 Return log); requirements.md ARP block REQ-501–512;
  ADR-0008 (binds M11's header handshake)
- **Deliverables**, in order:
  1. The WO-0013 diff set, each a §13-recorded spec diff on frozen text:
     C-16 (complete the SPEC-M04 §7 tx_tready bullet — the C+8 cycle);
     C-17's five items (fix or defend each explicitly); C-18 (repair the
     C-14.4 example so the §6.2 Frame row cannot read as holding CRC
     across lane-4 frame octets); C-15 (the §0.5 constancy-definition
     repair, per dv's supplied clause).
  2. SPEC-M10 (arp_eth_rx), SPEC-M11 (arp_eth_tx), SPEC-M12 (arp_cache),
     SPEC-M13 (arp): DRAFT, template-complete, lifts byte-identical,
     open! Axi64_ifc. M10 carries C-6's pass-criteria obligation (the
     parsed-fields module under the REQ-004 bench — the ledger row is
     yours to close here). M11 applies ADR-0008. M12 states the 16-entry
     direct-mapped index function exactly (REQ-506). C-12's closure-list
     pattern applies to M10's §9.
  3. traceability.md rows for the ARP block; set equality survives.
  - Journal J-architect_docs_lead-0006; Files-in-this-commit = exactly
    what you touch plus this packet. Return log with per-item
    dispositions.
- **Definition of done**: all four C-items dispositioned; four specs
  template-complete; C-6 closed in SPEC-M10 §8; set equality holds.
- **Out of scope**: batches E–F; RTL; tests; test/** and tools/**.
## Task
Batch D plus the third post-freeze diff cycle. The ARP family is the
first protocol-logic batch — independent of IPv4, contestable in
parallel with batch E later.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-02T14:55Z, journal `J-architect_docs_lead-0006`

**All three deliverables complete.** Four C-items dispositioned (one of the five
C-17 sub-items defended in part rather than simply applied — the table below
judges each explicitly); four batch-D specifications drafted and
template-complete with byte-identical lifts; twelve traceability rows filled
with set equality re-verified mechanically at 110 = 110.

**No `§4.1` lift changed on any frozen specification.** `git diff` touches no
`ocaml` block of SPEC-M01 … SPEC-M09, so CI run 30729342467 (batches A/B at
f78766e) and CI run 30733153172 (batch C at f457efc) still witness every frozen
interface, and no post-freeze churn is counted against charter §6. The four new
lifts are additions.

---

#### Deliverable 1 — the WO-0013 diff set, in the order the packet named

| id | Disposition | Where it landed |
|---|---|---|
| **C-16** | **FIXED.** SPEC-M04 §7 now pins `tx_tready` = 1 at C+8 and states the four things that follow from a word presented there | SPEC-M04 §6.2 (`Idle` row + a paragraph), §7 (throughput bullet), §10 (REQ-209 hook), §11.5, §13 row |
| **C-17(a)** | **FIXED** | SPEC-M06 §6.1, §10 (REQ-410 hook), §11.4, §13 row |
| **C-17(b)** | **FIXED** in all three places, plus two dv did not name | SPEC-M07 §6.1, §6.2 `Drain`, §7, §8, §10 (REQ-207 hook), §11.4, §13 row |
| **C-17(c)** | **FIXED** | SPEC-M08 §6.1 (claim withdrawn), §6.3 item 5 (new), §11.3, §13 row |
| **C-17(d)** | **FIXED** | ADR-0008 Consequences, one new bullet |
| **C-17(e)** | **FIXED** | SPEC-M06 §8, §10 (REQ-005 and REQ-021 hooks), §11.4, §13 row |
| **C-18** | **FIXED**, and one twin sentence dv did not cite moved with it | SPEC-M03 §3 (REQ-016 row), §6.1 (definition + two non-instances), §6.2 `Frame` row, §11.6, §13 row |
| **C-15** | **FIXED**, using dv's supplied clause | requirements.md §0.5 "Latency" paragraph + a §13 revision row |
| **C-6** | **CLOSED** | SPEC-M10 §8 — see deliverable 2 |

**C-17, judged each as the packet required.**

| item | Judgement | Reasoning |
|---|---|---|
| **(a)** M06 §6.1's `M + 2 ≤ Ci + K` | **dv is right; fixed as stated.** | Re-derived independently: M = K − 1 for N ≡ 0 or 7 (mod 8) and K − 2 otherwise, so M + 2 ∈ {K, K + 1}. `≤ K` therefore holds only at the equality case and is false for every input length that is a multiple of 8 — including §8's own 60-octet stress frame, which is the sharpest part of the finding. The paragraph now states **M + 2 ≤ K + 1**, derives both directions side by side so the abort paragraph's `≥` and this paragraph's `≤` cannot drift apart again, and names the stimulus the old wording failed on. §10's REQ-410 hook carries the prohibition |
| **(b)** M07's drain count in three places | **dv is right; fixed in five places, not three.** | The stall count is W − J + 1, not W − J: the last payload word is accepted at C + J − 1 and the last output word leaves at C + W, so the zero cycles are C+J … C+W inclusive — three for the 46-octet frame the table itself shows. dv named §6.1's prose, §6.2's `Drain` row and §7's throughput bullet; **§8 and §10's REQ-207 hook carried the same figure** and move with them. §6.1 now separates the two quantities explicitly — W − J is the *word surplus* and is correctly 1 or 2; W − J + 1 is the *stall count* and is 2 or 3 — because conflating them is what produced the error. §8 additionally ties M07's return to `Idle` at its own C+9 to SPEC-M04's C+8, so the two findings are one composed statement rather than two local ones |
| **(c)** M08 §6.1's same-cycle-header claim | **dv is right; fixed as stated, and the sentence is withdrawn rather than completed.** | Completing it would have specified output timing for a case M06 cannot produce, commissioning a test for a stimulus the programme has decided not to generate — the objection §6.3 items already make elsewhere. The claim is deleted from §6.1, the reason it was unreachable is stated there, and §6.3 gains item 5 in exactly the form SPEC-M07 §6.3 item 3 and SPEC-M09 §6.3 item 4 use, as dv asked |
| **(d)** ADR-0008's permissive `valid` drop | **dv is right; fixed in ADR-0008 and not in SPEC-M07.** | dv offered either home. ADR-0008 is the right one because the rule binds M11, M15 and M18 as well as M07, and a sentence in one module's §7 would have to be copied into three more specifications to bind them. The new Consequences bullet states the four SHALL NOTs (no assertion that `valid` falls, none that it is low between frames, no `valid` edge as a frame boundary, no field read outside the offer window), names the one event a monitor may key on, **and** names what a monitor *may* still assert — the source's side of decisions 1 and 2 — so the rule does not read as a blanket exemption |
| **(e)** M06 §8's directed set | **dv is right; fixed as stated.** | Verified independently: an input frame of N octets gives a payload of N − 14, so N = 14 gives zero payload octets and no payload word at all, and the `0xFF` pattern needs a positive multiple of 8, that is **N = 22**. The set becomes 14–22 and the residue claim is separated from the `tkeep`-pattern claim in the text, because they are different claims over different ranges and merging them is what hid the gap. §10's REQ-005 and REQ-021 hooks follow. dv's constraint on SO-M06 (no `0xFF` row until this lands) is satisfied |

**One item beyond the packet, disclosed rather than folded in.** C-18's wrong
example — "an XGMII word carrying no frame octet ... happens at a lane-4 start" —
appears **twice** in SPEC-M03: in §6.2's `Frame` row (which dv cited) and in
§3's REQ-016 row (which dv did not). Fixing one and leaving the other would have
left the sentence that fails every lane-4 frame's FCS check still in the
document, so both moved in the same diff and §13's row says so.

**The batch-C freeze flip, performed here and flagged.** The gate checklist has
recorded batch C as **FROZEN at 508eea2** since 55e78f2, with the compile run
and `J-dv_lead-0007` transcribed, while SPEC-M06 … SPEC-M09 still read
"Status: DRAFT" and carried `pending` in all four §12 rows. That contradiction
is a doc-truthfulness failure against charter §6 and it would have made every
§13 record in this commit read as a change to a draft. §12 is the architect's
section (charter §5), not a gate signature, so the flip is mine to make: all
four now read **FROZEN at 508eea2** with run **30733153172** at f457efc and
`J-dv_lead-0007`, and each §11.1 closes with the evidence that
`git diff --stat 508eea2 f457efc -- docs/specs/ifc_check/` is empty — the run
elaborated byte-identical records. SPEC-M07 §11.3 also closes, in the negative,
recording dv's declined answer at WO-0013. **I did not touch `docs/gates/`**
(PROTOCOL §7); the ledger dispositions below are for orchestrator transcription.

---

#### Deliverable 2 — SPEC-M10, M11, M12, M13

All four DRAFT, template-complete (§1 … §13, no section deleted), lifts
byte-identical, `open! Axi64_ifc` where a programme type is used. Verified
mechanically: `tools/dv_checks.sh` at this tree reports **16 checks run, 0
failures**, including four new
`modules/<spec>.md §4.1 == ifc_check/<spec>_ifc.ml (byte identical)` rows.

**The one structural decision batch D had to make, stated for countersignature.**
SPEC-M01 is FROZEN at f78766e, so `Arp_packet` and the four cache/resolution
records could not be added there without a breaking post-freeze interface change
that would invalidate five freeze records' compile evidence. Batch D therefore
declares each record **once, at the module that owns it**, and opens it
elsewhere: `Arp_packet` in SPEC-M10 §4.1; the three cache records in SPEC-M12
§4.1; `Arp_query` and `Arp_response` in SPEC-M13 §4.1. `arp_eth_tx_ifc.ml` and
`arp_ifc.ml` are the first lifts to `open!` another lift — an ordinary
intra-library reference with no cycle. architecture.md §6.4 records the rule and
SPEC-M10 §11.2 tracks promoting the records into M01 if a later phase reopens it.

| Spec | Key contracts |
|---|---|
| **SPEC-M10 `Arp_eth_rx`** | Nine RFC 826 fields at fixed payload offsets; REQ-501's six criteria; **exactly one report per opened packet** — one `arp_valid` pulse XOR one `error_arp_unsupported` pulse, never both and never neither — on the cycle after the earlier of payload word 3 and the closing event. Parse latency **L = 32 octet times, h = 0, ΔC = 4**, one constant at every length and every field content; **no §1.1 ceiling** (requirements.md §1.1 excludes M10 from REQ-006's chain in its own words). C-12's closure-list device applied in §9: a packet is open from its `hdr_valid` pulse until the earliest of the payload `tlast`, the next `hdr_valid` or `clear`. `Arp_packet` carries five fields, not nine: the four constants are acceptance criteria, so **`valid` = 1 means REQ-501-accepted by construction** and nothing downstream re-checks |
| **SPEC-M11 `Arp_eth_tx`** | The transpose of M10's table, with the four constants written from REQ-501. One derivation rather than a copy: **`hdr_dst_mac` = `target_mac` for operation 2, broadcast for operation 1** (REQ-502 and REQ-505 respectively; RFC 826 leaves a request's target hardware address unused). Four payload words, `tkeep` = 0x0F on word 3, `tuser` = 0 always, **`payload_tvalid` never deasserted inside a frame**. ADR-0008 decisions 1, 2 and 4 restated as source obligations. **L = 8 octet times, h = 0, ΔC = 1** |
| **SPEC-M12 `Arp_cache`** | **index(a) = a[3:0]** — the low four bits of the address's least significant octet — stated with five worked examples including the 192.168.1.10 / 192.168.1.26 collision REQ-504's test needs and the 10.0.0.16 → slot 0 case. Full-address comparison decides the hit. **1-cycle lookup, hits and misses alike.** A write accepted on cycle T is visible to every query presented on **T + 1 or later and to none on T** — one rule about cycles, not a same-slot special case. Lifetime stated as an **observable**: a write at T answers hits for queries presented on T+1 … T+L and misses from T+L+1; the mechanism is §6.3-unconstrained. **A miss is not an error here** |
| **SPEC-M13 `Arp`** | REQ-507's five classes in order, first match wins, with the multicast MAC as bits (`mac`[23] forced 0, `mac`[22:0] = `d`[22:0]) and both REQ-509 test addresses worked. **`tx_response_valid` at Q + 2 for every query in every class**, uniform on purpose so M15 need not know the class; for classes 1–3 `cache_query_valid` = 0, which makes "without consulting the cache" observable at M12's port rather than assumed. REQ-505: one outstanding resolution, duplicate suppression for the same target, discard-without-buffering. REQ-506 retry half: one initial request plus up to `retry_count` retries, interval measured **from M11's acceptance**. REQ-510: a reply is pending from generation to M11's acceptance; a second is dropped; the receive path cannot be stalled because `rx_payload` has no `tready`. **REQ-511 and REQ-512 need no rule of their own** — both fall out of the single reply predicate, and the spec says so explicitly so no bench looks for a `gratuitous` or `proxy` signal. REQ-502's 64-cycle deadline **derived at 6 cycles** from six other specs' pinned constants, stage by stage |

**C-6 closes in SPEC-M10 §8**, as the DoD required. REQ-004's four criteria are
restated in their parsed-fields form: (1) conservation becomes *reports =
packets opened*, one per packet; (2) "payload octets compare equal" becomes
**field equality**, which is strictly stronger because it also checks REQ-012's
decode and the sender-IP field's word-boundary crossing; (3) "per-octet latency
constant" becomes the REQ-611-shaped **constant parse latency = 4 cycles for all
10 000, one value not a mean**; (4) the no-`tready` criterion is unchanged and
structural. The stimulus is derived by construction from M08's ARP-port output
under SPEC-M03 §8's run — 6 words then 4 or 5 idle cycles alternately — with a
per-frame sequence number in the sender protocol address so a stuck register
cannot pass.

**architecture.md §6.4 confirmed its own batch-D rows in this commit**, as §6.4
requires. Every row naming M10 … M13 stands **unchanged in its port names**,
with **one** amendment: `M11.arp_ready → M13.arp_tx_ready` (`bit`, tx). The
table is now **117 edges: 26 rx, 40 tx, 29 control, 22 status**, recounted
mechanically. §6.4's internal-signal note is extended to M13's six internal
endpoints, which are not M13 ports and appear in neither `I` nor `O`.

---

#### Deliverable 3 — traceability

Twelve ARP rows filled (REQ-501 … REQ-512); REQ-507's short title corrected to
match requirements.md. **Set equality re-verified mechanically at this tree**:
the REQ id set extracted from requirements.md and the row id set of
traceability.md are both 110 and their symmetric difference is empty. No row
added, none retired, none renumbered. Two rows carry two owning modules on
purpose (REQ-503, REQ-506) and the matrix's preamble now says why.

---

#### Ledger dispositions to transcribe (`docs/gates/`) — I did not edit the checklist

| id | Disposition |
|---|---|
| **C-6** | **CLOSED.** SPEC-M10 §8 states the stimulus and REQ-004's four criteria in their parsed-fields form; the section names C-6 and closes it in place |
| **C-15** | **CLOSED.** dv_lead's clause applied verbatim in requirements.md §0.5's "Latency" paragraph, with the observed failure recorded; requirements.md §13 carries the revision row, class editorial |
| **C-16** | **CLOSED.** SPEC-M04 §7 pins C+8 and states what a word presented there does; §6.2 carries the acceptance; §10's REQ-209 hook forbids the assertion that would fail a conformant design; §11.5 and the §13 row record it |
| **C-17** | **CLOSED on all five items**, each judged explicitly in the table above; (b) landed in five places rather than the three dv named, and (d) landed in ADR-0008 rather than SPEC-M07, for the reason given |
| **C-18** | **CLOSED.** "Gapless" redefined in octet times; the two non-instances stated with their `octet_count` values; §6.2's `Frame` row says a word covering ≥ 1 frame octet is never held; §3's twin sentence moved in the same diff |
| — | **New (batch-C freeze flip)**: SPEC-M06 … SPEC-M09 §12 completed and their status flipped to FROZEN at 508eea2, matching what the checklist has recorded since 55e78f2. No gate file touched |

---

#### Open questions for dv_lead at the batch-D countersignature

Four, each written into a spec's §11 with a "what a reader assumes meanwhile"
so nothing downstream is blocked, and each named here so it is not discovered.

1. **SPEC-M11 §11.3 — the ADR-0008 substitution.** M11's `arp` input has no
   payload stream travelling with it, so the ADR's acceptance event does not
   exist there; §7 substitutes `arp_valid` & `arp_ready` and applies decisions 2
   and 3 against it. I read this as an *instantiation* of ADR-0008 in a place
   the ADR anticipated, not a supersession. A monitor built for the ADR's
   literal wording would look for a payload word that is not there, which is why
   this is dv's call and not only mine.
2. **SPEC-M10 §11.3 — a bad-FCS frame is learned from.** REQ-104 marks it,
   REQ-013 forbids dropping solely for the mark, REQ-501's acceptance list omits
   it, and `payload_tuser`[0] arrives on the payload `tlast` word — two or more
   cycles **after** M10's pinned report, so acting on it costs REQ-005's
   constant. Meanwhile: such a packet is accepted and M13 learns from it. If the
   programme wants otherwise the cheapest place is M13, and it needs a
   requirements.md diff plus a new `Arp_packet` field.
3. **SPEC-M13 §11.2 — REQ-810's ARP clause.** It reads as though every reply
   generated while transmit is disabled is dropped; the mechanism here drops the
   **second and later** ones and holds the first in M11 until transmit resumes.
   Dropping the first would need a `cfg_tx_enable` input at M13 that §6.4.3 does
   not route there — a port addition, hence breaking if it lands after freeze,
   which is why it is raised now rather than later.
4. **SPEC-M13 §11.3 — a miss for a *different* target replaces the outstanding
   resolution.** REQ-505 constrains only the same-target case. The rule is
   stated normatively with its rejected alternative (a per-slot table of
   outstanding resolutions); if dv judges it a missing requirement rather than a
   specification decision, the repair is a requirements.md diff plus a spec diff
   and no port moves.

Also carried, unchanged by this work order: **C-3** (SPEC-M08 §11.2), **C-5**
(SPEC-M04 §11.3), and SPEC-M06 §11.2's zero-reserve ceiling, which dv signed at
zero reserve and which is untouched here.

---

#### For the orchestrator

1. **Stage nineteen paths**: this packet, my journal, and the seventeen under
   `docs/` listed in `Files-in-this-commit`. Nothing outside `docs/**` and
   `agents/handoffs/**` was touched; `test/**` and `tools/**` are untouched, as
   the packet required — `tools/dv_checks.sh` was **run**, not edited.
2. **A CI `build` run is owed for this commit** and is what closes §11.1 in all
   four batch-D specs: four new lifts elaborate for the first time,
   `arp_eth_tx_ifc.ml` and `arp_ifc.ml` being the first to `open!` another lift.
   The §12 rows of SPEC-M10 … SPEC-M13 stay `pending` until that run's id and
   conclusion exist.
3. **Transcribe the ledger table above** into
   `docs/gates/P1-spec-freeze-checklist.md` (C-6, C-15, C-16, C-17 and C-18
   closed) and set the batch-C row's spec status to match the flip §12 now
   carries. I did not edit the checklist.
4. **Batch D is ready for a dv_lead countersignature work order** once the CI run
   is green; the four open questions above are what that packet should ask about
   by name.
5. `git commit` / `git push`: never run.
