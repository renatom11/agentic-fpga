# WO-0005: Re-review of the applied spec diffs (countersign or contest)
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your own findings (WO-0003, 9a6195a); the architect's
  application of them at b4b4cf4 (docs/specs/* + the WO-0004 Return log's
  per-diff disposition table); WO-0004's ACCEPTED entry (orchestrator
  rulings 1–4)
- **Deliverables**:
  - A verdict entry in this packet's Return log: for each of D-1…D-16,
    CLOSED (the applied text satisfies the finding) or CONTESTED (what
    still fails, phrased as a spec-diff request). Explicitly judge the
    two deviations: the D-4 octet-times metric correction and the D-1
    seven-module stress list (your enumeration said five plus nic_top).
    Also judge the D-3 resolution against your own lane walk.
  - Your testability countersignature decision for the post-diff
    requirements.md at b4b4cf4: SIGNED (with the sentence "I sign the
    P1-spec-freeze testability precondition at b4b4cf4" in your journal
    entry, which the orchestrator transcribes to the gate checklist) or
    WITHHELD (with the blocking list).
  - Journal entry J-dv_lead-0002 per PROTOCOL §4;
    Files-in-this-commit: exactly this packet.
- **Definition of done**: all sixteen dispositions judged; the
  countersignature decision is explicit either way; no edits outside this
  packet + your journal.
- **Out of scope**: new full review of unchanged rows; bench work; the
  cost probe (comes with your bench-setup WO).
## Task
Verify your review was honored. This is deliberately narrow: sixteen
dispositions and a signature decision. If the architect's application is
faithful, say so and sign; if not, the contest loop runs again.
## Return / verdict log
(dv_lead appends on RETURNED)

### RETURNED — dv_lead, 2026-08-02T03:20Z, journal `J-dv_lead-0002`

**All sixteen diffs CLOSED. None contested. Testability countersignature
SIGNED against `docs/specs/requirements.md` at b4b4cf4.** Seven carry-forward
items (C-1 … C-7) are recorded below; none is a condition of this signature,
each is a one-clause diff, and each is named with the gate it must land before.

Re-review target: `docs/specs/requirements.md`, `architecture.md`,
`traceability.md`, `SPEC-TEMPLATE.md` at **b4b4cf4** (verified unchanged at
8259699). Basis: my own WO-0003 findings at 9a6195a (§14.3's D-1 … D-16 and the
cross-cutting X-1 … X-10 that motivate them) and WO-0004's Return log.

#### The sixteen verdicts

| id | Verdict | Judgment |
|---|---|---|
| **D-1** | **CLOSED** | §0.4 is normative and self-contained: the chain, the streams, the structural-module rule, and the stress list **by name**. REQ-003, REQ-004, REQ-905, SPEC-TEMPLATE §3/§8 and architecture §4 all point at it rather than restating it. The seven-module correction is **adopted** — see below. Carry-forward C-6. |
| **D-2** | **CLOSED** | §0.3 states DA-through-FCS once with the three consequences a bench needs. Checked every derived number: REQ-408 46 ✓ (64 − 14 − 4); REQ-605's total-length-28 example leaves 18 padding octets and delivers 8 ✓; REQ-005/REQ-103's 64–71 set delivers 60–67, residues 4,5,6,7,0,1,2,3 — all eight `tlast` `tkeep` patterns ✓; REQ-708's stimulus 46/26/18 is arithmetically closed ✓ and leaves room for REQ-020's four-octet sequence number ✓. |
| **D-3** | **CLOSED** | One convention at all four sites. My lane walk re-run and confirmed; the architect's defence is stronger than my original argument and corrects one of my figures — see below. |
| **D-4** | **CLOSED** | The deviation is **adopted, my formulation refuted**. Octet times are satisfiable where my cycle-counted per-octet difference is not — see below. Carry-forward C-1 on the ceiling comparison unit. |
| **D-5** | **CLOSED** | §0.6 states precedence, multiplicity and a timing window normatively; REQ-007, REQ-013 ("was found invalid; the ultimate consumer must discard it", plus the explicit no-Phase-1-module-drops rule) and REQ-403 restated; SPEC-TEMPLATE §9 now forces each module spec to state which conditions co-occur, which is the only place that question can be answered. Carry-forward C-5. |
| **D-6** | **CLOSED** | Frame conservation is normative in §0.6 and is clause (b) of REQ-008's method, so the silent-discard prohibition finally has a detector; REQ-020 restated as a strictly increasing subsequence with every omission accounted for. The `dedicated strobe` contradiction was resolved the strong way — REQ-110 gets `error_start_without_terminate`, so §12 is 21 names for 21 conditions and no bench has to disambiguate a shared strobe. Carry-forward C-2 on the identity's third term. |
| **D-7** | **CLOSED** | Resolved in the direction I would have chosen: REQ-011 stands intact and a zero-octet payload is encoded as a header record with no payload frame (§0.7), with the governed cases enumerated. REQ-011, REQ-401, REQ-402 (`0-` → `1-`), REQ-605, REQ-703 and REQ-707 all restated consistently; §11 records the non-representability as a decision. Carry-forward C-3 at the top-level boundary. |
| **D-8** | **CLOSED** | Option (b) chosen and the reason given (option (a) contradicts REQ-009's own all-`tvalid`-zero rule). REQ-009 carries the tightened wording; REQ-015 is the checkable residue with the monitor exempted across a clear. The architect's 190-word bound on the `Xgmii_rx_64` output is right and my 189 was wrong: 1514 octets is ceil(1514/8) = 190 words. Adopted. |
| **D-9** | **CLOSED** | All four boundary questions answered: control-in-preamble routed by character (REQ-102), `/E/` truncation as the REQ-106 rule with all eight lanes in the method (REQ-105), sub-5-octet frames producing no output word and one `error_runt` (REQ-107), oversize delivering **1514** with `error_bad_fcs` explicitly silent (REQ-108), and one unifying sentence in REQ-103 (FCS stripping only for a frame that ends in `/T/`) that I did not ask for and that closes the class rather than the four instances. REQ-107's method arithmetic checks: 5/16/60/63 deliver 1/12/56/59 ✓. Carry-forward C-4. |
| **D-10** | **CLOSED** | REQ-303 = 0xCBF43926, REQ-304 = 0x2144DF1C, both on REQ-301's convention, with a provenance note recording the two independent computations and explaining 0xC704DD7B rather than deleting it — which is what stops this being re-litigated in six months. REQ-202 states the FCS wire order (least significant octet first) and now names REQ-305's software reference as the oracle, with the receiver/residue loopback demoted to supplementary. This was the highest-value pair in the review and it landed exactly. |
| **D-11** | **CLOSED** | REQ-705 defines payload length once (UDP payload octets, excluding the UDP header and every lower-layer header); REQ-610 restated as +28 and +8 against it. The eight-octet wire-format ambiguity is gone, and REQ-705's ordering criterion is replaced by the invariance criterion, which is the stronger detector I asked for. |
| **D-12** | **CLOSED** | REQ-810 gives both enables a port-visible behaviour, and §9.1 gives all twelve fields width, reset, range and owning REQ — so REQ-802 commissions no test it cannot name, and `cfg_ifg` < 12 is prohibited rather than merely unmentioned. REQ-810's method is directly buildable as written. Its `tready`-low-when-disabled clause is an rtl_lead question, not a testability one; the orchestrator has already parked it. |
| **D-13** | **CLOSED** | REQ-016 scoped to receive-path and internal streams with `Xgmii_tx_64`'s source interface excluded **by name**, and its tolerance quantified (k idle cycles = 8k octet times, which is what makes it composable with §0.5). REQ-206's threshold is the single required cycle and "there is no elastic buffer" is stated, so the underflow stimulus is now constructible — `error_underflow` was one of the strobes I could not reach. |
| **D-14** | **CLOSED** | REQ-502's six address fields are all pinned and the 64-cycle bound has two named events; REQ-505 drains rather than stalls and suppresses duplicate requests while a resolution is outstanding, with a method (100 datagrams → 1 request, 100 strobes) that is deterministic; REQ-507's class precedence and subnet predicate are explicit; REQ-510's one-pending-reply rule makes `error_arp_reply_dropped` reachable by two back-to-back requests, which also unblocks REQ-208 and the REQ-804 gate item. |
| **D-15** | **CLOSED** | Split as requested. REQ-709 is under-delivery with both strobes; REQ-710 states what physics actually permits for over-delivery (frame already terminated on the wire → complete at the declared count, accept and discard the excess, `error_tx_length_mismatch` only, `error_underflow` explicitly not). Both methods are directly buildable. |
| **D-16** | **CLOSED** | REQ-901 now says what "differential" compares (transactional: ordered output frames — octets, `tkeep` extents, `tuser`[0] — plus the accept/discard decision per input frame), what it deliberately does not (cycle alignment, pipelining, latency constants), where the boundaries are (architecture §4 counterparts, §5 merged wrappers), and which four divergences are expected by design — plus the rule that a fifth must be added by spec diff *before* a sign-off packet may cite it, which is the clause that keeps this anchor honest. Carry-forward C-7. |

#### (a) The D-4 deviation — adopted; my own formulation refuted

The architect is right and my WO-0003 formulation is wrong. I re-walked both
start lanes rather than accepting the claim.

Under a **lane-4** start, `/S/` sits at lane 4 of word N, the eight preamble
octets run to lane 3 of word N+1, and frame octets 0–3 arrive in word N+1 while
octets 4–7 arrive in word N+2. All eight leave in output word 0. So my metric —
(cycle of the output word carrying octet n) − (cycle of the input word carrying
octet n) — takes **two values inside a single frame**, alternating 4-and-4
across every output word. A monitor built literally on findings §5 would fail a
conformant `Xgmii_rx_64` on its first lane-4 frame. Under a lane-0 start the
same metric is constant, which is exactly why the defect survived my review: I
checked constancy *across* the two start lanes (X-6) and never checked
constancy *within* the lane-4 frame.

Octet times remove the failure rather than papering over it. With octet time
8·cycle + lane on XGMII and 8·cycle + byte position on `Axi64`, a module
stripping h octets that takes its first input word at Ci and emits its first
output word at Co has, for input octet j at octet time 8Ci + j and output octet
j − h at 8Co + (j − h), latency L = 8(Co − Ci) − h **independent of j** — at
every header length and both start lanes. Verified numerically (command in
`J-dv_lead-0002` Evidence): lane 0 gives one octet-time value {16} against
cycle-metric {2}; lane 4 gives one octet-time value {20} against cycle-metric
**{2, 3}**. The two lane constants differ by 4 octet times, inside §0.5's
8-octet-time bound, and floor(L/8) = 2 for both, so the §1.1 ceiling comparison
is start-lane independent — a property my formulation did not have.

Cost to my side is what the architect says it is: the §13.3 tagger records lane
or byte position alongside the cycle. No bench is redesigned.

**C-1 (carry-forward, should-fix, before SPEC-M03 pins a constant).** The
conversion floor(L/8) understates a stripping stage's word-cycle delay by
exactly ceil(h/8) — the delay ΔC = Co − Ci satisfies ΔC = (L + h)/8. Checked
against §1.1 stage by stage: the ceilings permit ΔC of 5 (M03 lane-0), 6 (M03
lane-4), 5 (M06), 1 (M08), 8 (M14), 5 (M17), and a chain sitting exactly on
every ceiling consumes **24 cycles — the whole of REQ-006's budget, with none
of the architect's declared 7-cycle slack left**. Nothing fails a conformant
design and REQ-006's end-to-end bench at `nic_top` is the binding backstop, so
this is not a signature condition; but the per-module ceilings should be
compared as (L + h)/8, with h stated per module, or REQ-019 will pass every
stage while REQ-006 fails at the top and no packet will say which module owes
the cycles. I will raise it as a spec diff when the first module spec pins a
constant.

#### (b) The D-1 stress list — seven modules, adopted

Adopted without reservation, and the omission was mine. My own REQ-003 reading
in findings §3 spelled the chain **M03 → M06 → M08 → {M10, M14} → M17**, which
contains M10; my REQ-905 entry then said "architecture §4's Path column marks
five modules R — M03, M06, M08, M14, M17". Architecture §4 marks **M10
`Arp_eth_rx` as R** (row: `| M10 | Arp_eth_rx | R | ARP packet parse into
fields. | arp_eth_rx.v | 501 |`), so my §14.3 enumeration contradicted my own
§3 and the source table. Seven is right: M03, M06, M08, M10, M14, M17, M20.

The stimulus statement is coherent too: a minimum ARP frame is 14 header + 28
ARP + 18 pad + 4 FCS = 64 octets, so "10 000 minimum-length ARP packets at the
REQ-004 arrival rate" is the same 10/11 alternation seen at M08's ARP output,
and every packet is REQ-501-acceptable, satisfying REQ-004's all-accepted rule.

**C-6 (carry-forward, should-fix, in SPEC-M10).** M10 emits parsed fields, not
a payload octet stream, so two of REQ-004's four pass criteria — "payload
octets compare equal" and "per-octet latency is constant" — have no direct
observable at its output. Frame conservation and no-loss are well defined
(10 000 packets in → 10 000 accepted-field pulses plus `error_arp_unsupported`
pulses out), and the latency analogue is REQ-611's shape (input word carrying
the first ARP octet → the cycle `valid` asserts). SPEC-TEMPLATE §8 already
obliges the module spec to state the exact stimulus and criteria, so this lands
in SPEC-M10; it needs no requirements.md change and I own raising it there.

#### (c) The D-3 resolution — confirmed against my own lane walk

Re-walked from scratch, not re-read. Minimum frame 64 octets, preamble and SFD
8, gap 12 counted from `/T/` inclusive = 84 octets = 10.5 cycles. Starting at
lane 0 of cycle T: preamble occupies lanes 0–7 of T, frame octets 8–71 run to
lane 7 of T+8, `/T/` lands in lane 0 of T+9, the gap covers octets 72–83, and
the next start is at octet 84 = **lane 4 of T+10**. From there the next start is
octet 168 = **lane 0 of T+21**. Spacings 10, 11, 10, 11 — reproduced
mechanically as `[(0,0),(10,4),(21,0),(31,4),(42,0),(52,4)]`. The transmit side
reproduces as stated: rounding up to lane 0 gives 16 octets from `/T/`
inclusive, 88 octets start to start, exactly 11 cycles, and 16 ≥ 12 so it never
shortens a gap. REQ-204's "88 octets" and REQ-209's "exactly 11 cycles" are
therefore consistent equalities, not a bound and a wish.

Two corrections to my own text, both accepted:

1. My "**9.5 % slower**" figure mixed two comparisons. The correct statement is
   the architect's: the twelve-idles-after-`/T/` reading gives 11 and 11, i.e.
   **4.5 % slower on average** (11 vs 10.5) and **one full cycle, 10 %, slower
   on the frames that would otherwise arrive 10 cycles apart**. §0.3 states it
   that way; my figure should not survive anywhere.
2. The DIC argument is stronger than the one I made, and I checked it
   independently rather than taking it. Because `/T/` sits in lane 0 or lane 4
   and the next `/S/` must also sit in lane 0 or lane 4, the gap measured from
   `/T/` inclusive is quantised to multiples of 4 octets. The candidates below
   12 are 4 and 8; both are under clause 46's 9-octet floor as well as under our
   12. So **12 is the smallest gap any 802.3-compliant partner can present**,
   and the 10/11 alternation is not merely a plausible worst case — it is the
   worst case, unbeatable by a DIC-capable partner. That is what I need the
   stress bench to drive, and it is what §0.3 and REQ-004 now say.

The receive/transmit asymmetry (rx assumes a DIC partner, tx rounds up and never
shortens) is the right split: it puts the pessimism on the side that must
survive it and the simplicity on the side that only has to stay legal.

#### Carry-forward items C-2 … C-5, C-7

None blocks the signature. Each is a false-failure or an unstated-accounting
edge, each has an unambiguous fix direction, and each is named against the gate
it must land before. I raise them now so that they are the architect's to
schedule rather than mine to discover in a bench.

- **C-2 (from D-6 and D-12; before the first `SO-` cites the monitor).** §0.6's
  conservation identity counts **discard-strobe pulses**, but §0.6's own
  multiplicity rule says every locally detected applicable condition pulses once
  — so a datagram that is both fragmented (REQ-603) and not-for-us (REQ-604)
  pulses two strobes for one discarded frame and a literal monitor fails a
  conformant M14. The third term should count **frames discarded** (each
  discarded frame pulsing at least one discard-class strobe), not pulses.
  Separately, the monitor needs the two exemptions REQ-015's monitor already
  got: across a `clear` (REQ-009 truncates without terminating) and while
  `receive enable` = 0 (REQ-810 accepts no frame and asserts no strobe, so
  frames-in exceeds every accounting term by construction).
- **C-3 (from D-7; before the `nic_top` stress bench).** §0.7's accounting term
  is a header-record `valid` pulse, but REQ-801 exposes no application-side
  receive header record at M20, so a zero-payload UDP datagram (length exactly
  8) is accounted for at M17's boundary and is invisible at `nic_top`'s. Either
  state that the top-level conservation identity excludes zero-payload
  datagrams, with M17's bench carrying that evidence (my recommendation — no
  interface change), or give the status record a counting strobe.
- **C-4 (from D-9; before SPEC-M03).** REQ-105 and REQ-110 still say
  "`tuser`[0] = 1 on the `tlast` word" unconditionally, but an error or start
  character in a preamble lane, or in the first frame-octet position, leaves
  **zero** delivered octets and therefore no word to mark — the same hole
  REQ-107 had and now closes explicitly. §0.6 and §0.7 make the answer
  determinable (no output frame; the strobe is the only report), so this is
  wording, not a hole; but REQ-102's new method cell commissions exactly that
  case ("one frame with `/E/` in a preamble lane, asserting REQ-105's
  behaviour"), so the clause should be in REQ-105.
- **C-5 (from D-5; editorial, before SPEC-M04).** The strobe window's upper
  bound is "the module's latency in cycles after the input word carrying the
  last octet of the offending frame". For `error_underflow` that word by
  definition never arrives, so the bound is vacuous; REQ-206 pins the pulse to
  the detection cycle, so no bench is blocked.
- **C-7 (from D-16; before the first co-simulation run cites REQ-901).** ARP is
  inside the comparison boundary (the §5 merged wrapper is `ip_complete_64`,
  which contains M10–M13 — which is also why classes (b) and (c) are ARP
  behaviours), so REQ-510's one-pending-reply drop rule is a **fifth** divergence
  class: the reference does not drop a reply under that condition. REQ-901's own
  "added here by spec diff before any sign-off packet may cite it" clause is the
  right mechanism; I am flagging it before the run rather than after.

#### Mechanical re-checks at b4b4cf4

```
diff <(grep -o '^| \*\*REQ-[0-9]\{3\}' docs/specs/requirements.md | grep -o 'REQ-[0-9]*' | sort) \
     <(grep -o '^| REQ-[0-9]\{3\}'     docs/specs/traceability.md | grep -o 'REQ-[0-9]*' | sort)
  -> no output; 110 REQs, 110 rows
```

The four rows I called UNTESTABLE are each resolved and I accept all four
outcomes: REQ-019 (ceiling is the DV observable; the buffer-depth sentence is
marked not-DV-verifiable in the REQ *and* in `traceability.md`'s open
dependencies, so no packet can read `COVERED` as evidence about depth),
REQ-510 (reachable by construction), REQ-802 (record contract against §9.1, with
the missing behaviour added as REQ-810), REQ-901 (granularity, boundaries and
divergence classes stated). The two added REQs cost me nothing and buy two
observables; I do not contest the orchestrator's not-an-E2 ruling. The 21 strobe
names in §12 are contested in no part — `error_start_without_terminate` is the
name I would have chosen, and having the appendix at all is what makes REQ-008
and REQ-804 enumerable.

#### Signature

**SIGNED.** The sentence PROTOCOL §7 requires, carried in `J-dv_lead-0002` for
the orchestrator to transcribe to the `P1-spec-freeze` checklist, is:

> I sign the P1-spec-freeze testability precondition at b4b4cf4.

The signature says what my charter says it says and nothing more: given this
text plus the owning module's frozen spec, I can hand a tb_writer an excerpt of
any row and defend the resulting bench's verdict at a gate; the two known-answer
constants that would have produced false `BUG-`s against correct RTL are fixed;
the line-rate invariant now drives the worst case a compliant partner can
present rather than one 4.5 % slower; and the four rows that commissioned
impossible work are testable. It does not certify the RTL, the module specs, or
the seven carry-forward items — C-1 … C-7 are open and named, and I will raise
each as a spec diff at the point recorded above.

**Handoff**: orchestrator, for the `P1-spec-freeze` checklist transcription and
for scheduling my bench-setup work order (the WO-0003 §14.5 open questions — X-9
executor, `hardcaml_step_testbench`, the Cyclesim cost probe — are still open and
are unaffected by this review).
