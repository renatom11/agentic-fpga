# WO-0003 findings: testability review of `docs/specs/requirements.md`

- **From** / **To**: dv_lead → orchestrator (for relay to architect_docs_lead)
- **Work order**: `WO-0003_requirements-testability-review.md` (ISSUED at 02e38e7)
- **Review target**: `docs/specs/requirements.md` at **08899d3** (verified
  unchanged between 08899d3 and 81acc2c)
- **Context read**: `architecture.md`, `SPEC-TEMPLATE.md`, `traceability.md`
  (all at 08899d3), `ADR-0004`, `ADR-0005`, `README.md`, `ORG_CHART.md`,
  `agents/PROTOCOL.md`, `agents/charters/dv_lead.md`
- **Journal**: `J-dv_lead-0001`
- **Verdict**: **countersignature withheld pending 16 spec diffs** (§13)

---

## 1. How to read this review

### 1.1 Dispositions

Every one of the 108 REQs carries exactly one disposition. No sampling.

| Disposition | Meaning |
|---|---|
| **TESTABLE** | I can hand a tb_writer an excerpt of this row and get back a bench whose pass/fail I would defend at a gate. One line names the test shape. |
| **AMBIGUOUS** | Two reasonable test writers, given only this row, build benches that disagree about whether a *spec-conformant* design passes. Each entry quotes the wording, states the reading I would enforce today, and phrases the fix as a spec diff. |
| **UNTESTABLE** | The requirement names no observable I can reach at a module or top-level port, so no bench can distinguish compliance from violation. Each entry names the missing observable. |

Two REQs (REQ-303, REQ-304) carry numeric constants that are **wrong**, not
merely ambiguous: a test derived literally from them fails a conformant design.
That is not one of the three buckets, so I file them as AMBIGUOUS and label the
finding `DEFECT`. The required action — a spec diff by the owner — is identical,
and the counts stay honest.

### 1.2 Severity

- **blocking** — I will not countersign `P1-spec-freeze` until this is resolved.
  Either I cannot determine pass/fail for a conformant design, or the REQ has no
  DV observable at all, or the stated method provably cannot detect the very
  violation the REQ prohibits.
- **should-fix** — I can proceed under the reading stated here, but the reading
  should be in the document rather than in my head, and it should land before
  the owning module's per-module spec is written.
- **editorial** — the correct reading is not genuinely in dispute; the text is
  merely loose.

### 1.3 The standing principle behind most of the findings

**A verification method I do not intend to execute must be fixed in the
document, not silently ignored.** `traceability.md` binds each REQ to the tests
that cover it, and the auditor checks my tests against the Verification column.
If that column names a bench I will never build (because it would fail a
conformant design, or because it cannot detect its own violation), then either
the matrix lies or my signature does. So a defective Verification cell is a spec
diff request, exactly like a defective Requirement cell. Roughly a third of the
findings below are of that kind, and the WO asked for precisely this: *"a REQ
whose stated method cannot detect its own violation is AMBIGUOUS at best."*

### 1.4 The reader I reviewed for

Per PROTOCOL §10 my tb_writer workers receive **spec excerpts only, never RTL
and never the whole document**. So the test I applied to every row is: *given
this row and nothing else, can a competent worker who has never seen the design
build the right bench?* That test is stricter than "is this requirement clear to
someone who has read all 108", and it is what drives findings X-2, X-3, X-6 and
X-9 below — each is a case where the information a bench needs exists in the
programme but not in the excerpt the worker will hold.

---

## 2. Cross-cutting findings

Ten root causes account for most of the per-REQ findings. Each is referenced by
id from the rows in §3–§12.

**X-1 — "receive path" is used normatively but never defined.**
REQ-003, REQ-004, REQ-005, REQ-007, REQ-019, REQ-112, REQ-208, REQ-905 and
SPEC-TEMPLATE §3/§8 all quantify over "receive-path modules" or "receive-path
streams". The set is derivable only from `architecture.md` §4's Path column
(R/T/S), which a tb_writer excerpt does not contain — and which does not answer
the interesting cases: is `Nic_top` (which carries an application *transmit*
stream with a `Dest`) a receive-path module? Is `Eth_mac_10g`? Is `Crc32_eth`?
REQ-905 makes this set a **gate condition** ("every receive-path module SHALL
have its own line-rate stress bench"), so I cannot currently enumerate my own
obligations at `P1-module-ready`.

**X-2 — the document uses two frame-length conventions and two of its worked
examples are arithmetically wrong.** §0 fixes "64 octets of frame (DA through
FCS)", and REQ-108 says "1518 octets (destination address through FCS)". But
REQ-203 measures "destination-address-through-payload length", and two
Verification cells compute payload sizes that are only right if the FCS is
excluded from the stated frame length. Details in REQ-408 and REQ-605 below.
The corroborating check: 1518 − 14 − 4 = 1500 = REQ-612's maximum IP total
length, which confirms DA-through-FCS as the intended convention and therefore
confirms both examples as errors.

**X-3 — §0's "sole test-derivation basis" claim is false as written.**
"This file is the **sole test-derivation basis** for Phase 1 (PROTOCOL §10)."
But REQ-019 needs the per-module latency ceilings (architecture §4), REQ-111 /
REQ-210 / REQ-611 / REQ-610 need "the constant pinned in the module spec",
REQ-808 needs the architecture inventory table, REQ-901 needs the
module↔counterpart pairing, and REQ-705 needs a request handshake that only the
module spec defines. This is not a defect in the design of the programme — it is
correct that constants live in module specs — but the claim as phrased will be
read by a worker as "everything you need is here", and by the auditor as a
promise. Diff: restate as "this file plus the owning module's frozen
specification are the test-derivation basis; no test derives from RTL", and add
the pointers named above.

**X-4 — the silent-discard prohibition (REQ-008) is unenforceable by its own
method.** REQ-008 forbids *every* undeclared discard; its Verification tests
only the strobes that were declared. A module that drops frames under a
condition nobody named passes every test in the document. The only method that
detects the prohibited thing is frame conservation across the whole run. See
D-6.

**X-5 — abort-versus-discard precedence and strobe multiplicity are
unspecified.** REQ-007 says a frame invalid after forwarding began is marked
`tuser[0]=1` and propagated; REQ-404/REQ-601/REQ-604/REQ-607/REQ-612 say
offending frames are *discarded* (no output frame at all). The document never
states which wins when both apply, and never states whether two applicable
conditions produce two strobes or one. Concrete case a bench hits on day one: a
frame with a bad FCS (REQ-104: forwarded with `tuser[0]=1`) whose corrupted bit
lands inside the IPv4 header, so the header checksum also fails (REQ-602:
discarded). Does `Ip_eth_rx_64` emit an aborted payload frame or nothing? Do one
or two strobes pulse? REQ-008's "no other strobe asserts" makes this a pass/fail
question, not a curiosity.

**X-6 — latency measurement points are undefined, and REQ-111 as written is
unsatisfiable.** REQ-005 asks for "the delay from a word entering a module to
that word leaving it", but at any realigning module (REQ-021: Ethernet strips
14, IPv4 strips 20) an input word's octets appear in *two* output words, so
"that word leaving it" names no event. Worked case for REQ-111: with a lane-0
start, the first output word of `Xgmii_rx_64` is assembled from input word N+1
alone; with a lane-4 start the same output word needs octets from input words
N+1 *and* N+2. The start-word-to-first-output-word delay therefore **differs by
one cycle between the two start lanes**, and REQ-111 demands it be "independent
of ... start lane". No conformant design can satisfy the literal reading. See
D-4 for the formulation that is both satisfiable and stronger.

**X-7 — strobes have no timing window.** Twenty strobe names are normative and
every ERR REQ says the strobe "pulses once", but nothing bounds *when* relative
to the frame. "Exactly one pulse" is an assertion over an unbounded interval; two
writers pick two windows, and a design that reports 50 cycles late passes one
bench and fails the other. Folded into D-5.

**X-8 — the DV link-partner model has obligations in `architecture.md` §3 and no
REQ.** REQ-018 says "the link partner SHALL be a simulation model owned by DV
under `test/`" but does not state its contract (emit lane-0 and lane-4 starts
including the REQ-004 alternation; inject the REQ-104/105/107/108/110
conditions; decode transmit-side XGMII well enough for REQ-201–205). Since that
model is the thing that makes half the receive-path REQs executable, its contract
should be citable from requirements.md. should-fix.

**X-9 — six REQs are verified by inspecting emitted Verilog, and the document
never says who runs those checks.** REQ-001, REQ-017, REQ-018, REQ-306, REQ-808
and REQ-903 are verified by inspection of `rtl_snapshots/` or of `libs/`.
`rtl_snapshots/` is rtl_lead's write scope; the checks are not benches; and
PROTOCOL §10 constrains DV's relationship to design source. My position: reading
a *build product* (emitted Verilog) to check a port list is not deriving a test
from RTL, and I am willing to own these as mechanical scripts under `tools/`
run in CI — but that has to be a written decision, not my unilateral reading,
because the auditor checks my Inputs sections for exactly this. should-fix, with
a request that the orchestrator ratify the executor.

**X-10 — a zero-length payload has no encoding on the `Axi64` stream.** REQ-011
forbids `tkeep = 0` with `tvalid = 1`, so a frame with no payload octets cannot
be represented. But the document requires exactly that in at least five places:
REQ-402's "0-octet frame" test case; a 14-octet Ethernet frame (header only,
REQ-401); an IPv4 datagram with total length 20 (REQ-605's "exactly (total
length − 20) payload octets"); a UDP datagram with length 8 (REQ-703's "exactly
(length − 8) payload octets"); and REQ-703's "abort the payload frame with
`tuser[0]=1` on its last word" for a length-below-8 datagram that has no last
word. Every one of these is a stimulus I would be asked to build and cannot.

---

## 3. Block 1 — Programme invariants (REQ-001 … REQ-021)

**REQ-001 — TESTABLE.** Test shape: a script in `tools/` over
`rtl_snapshots/*.v` asserting that every `always @(posedge …)` edge expression
names `clock` and that no other signal appears in an edge position; run in CI
(X-9 on the executor). "Nominally 156.25 MHz" carries no simulation observable
and needs none — the cycle-count REQs (004, 006) carry the real content.

**REQ-002 — AMBIGUOUS (should-fix).**
*Quoted*: "SHALL carry at most one word per cycle" verified by "a throughput
bench measuring **exactly** one word accepted per cycle".
*Reading I enforce*: REQ-002 is a width and interface requirement only. "At most
one word per cycle" is structurally unfalsifiable — a stream has one `tvalid`,
so two words in a cycle is unrepresentable. The Verification cell's "exactly one
word per cycle" is a *different and stronger* claim that a conformant module
fails whenever its input has idle gaps (which REQ-016 explicitly permits), so
that bench would produce false failures on `Eth_demux`, `Ip_eth_rx_64` and
`Udp_ip_rx_64`.
*Spec diff*: replace the Verification cell with "interface compile check that
every frame-carrying port is `Axi64.Source`/`Dest` with `data_bits = 64`
(REQ-010)"; move all throughput obligation to REQ-004.

**REQ-003 — AMBIGUOUS (blocking, X-1).**
*Quoted*: "no `Dest` record anywhere on the receive path".
*Reading I enforce*: the receive path is the M03 → M06 → M08 → {M10, M14} → M17
→ application chain of architecture §6.1; a structural module is a receive-path
module with respect to those of its ports that lie on that chain, so `Nic_top`'s
application *transmit* `Dest` does not violate REQ-003.
*Spec diff (D-1)*: add a normative definition of "receive path" to §0 listing the
modules and the streams, and state the structural-module rule above.

**REQ-004 — AMBIGUOUS (blocking, X-1, D-2, D-3).** The programme's central
invariant, and the row I most need fixed.
*Quoted*: "mandatory for every receive-path module", stated entirely in XGMII
terms ("start characters alternating between lane 0 and lane 4"), with pass
criterion "no `tready`-like stall exists to observe".
*Readings I enforce*: (a) at a module that does not see XGMII, the stimulus is
the stream that a 64-octet frame arriving at the XGMII rate *produces at that
boundary*, with the idle gaps preserved — derived by construction from the XGMII
case, not re-invented per module; (b) the stress stimulus is 10 000 frames every
one of which the module under test accepts and forwards, so "frames out = frames
in" is well-defined (a mixed stimulus makes the pass criterion undefined for
`Eth_demux` and `Ip_eth_rx_64`, which legitimately discard); (c) the third pass
criterion is vacuous — if no `tready` exists, "asserted no backpressure" cannot
fail — and the real failure mode of a zero-backpressure path is silent word
loss, which criteria (1) and (2) already catch.
*Spec diff*: (i) add the per-boundary stimulus rule (a) and the all-accepted rule
(b); (ii) delete "asserting no backpressure" from the requirement and "no
`tready`-like stall exists to observe" from the Verification cell, replacing them
with "the module exposes no `tready` on the stream under test (REQ-003,
structural)"; (iii) see D-3 — the arrival rate itself is currently ambiguous.

**REQ-005 — AMBIGUOUS (blocking, X-6, D-2, D-4).**
*Quoted*: "The delay from a word entering a module to that word leaving it SHALL
be a constant of the module" · "frames of 64, 65, 71, 72, 73, 1500 octets".
*Readings I enforce*: measure per *octet*, not per word — the latency of octet n
is (cycle of the output word carrying octet n) − (cycle of the input word
carrying octet n), and REQ-005 holds iff that value is identical for every octet
of every frame. This is well-defined across realignment, it is the only reading
that survives REQ-101's two start lanes, and it is free to compute inside the
REQ-004 scoreboard (see §13.3).
*Second finding*: the stated length set is incomplete against its own sibling.
REQ-011 demands "frame lengths of each length modulo 8"; {64, 65, 71, 72, 73}
produces output payloads of 60, 61, 67, 68, 69 octets — residues 4, 5, 3, 4, 5 —
leaving `tkeep` patterns for residues 0, 1, 2, 6, 7 on the `tlast` word untested.
*Spec diff (D-2)*: replace the set with "64 through 71 inclusive (which covers
all eight `tlast` `tkeep` patterns), plus 1518"; align REQ-103's set with it, and
use 1518 rather than 1500 so the maximum case is the maximum legal frame.

**REQ-006 — TESTABLE.** Test shape: cycle-tagged end-to-end bench at `nic_top`
— tag the XGMII word carrying `/S/`, tag the first application `tvalid` word,
assert difference ≤ 24, report the value for both start lanes (they may
legitimately differ by one cycle, X-6). Editorial: say "report the value for each
start lane" so the freeze record is unambiguous.

**REQ-007 — AMBIGUOUS (blocking, X-5, D-5).**
*Quoted*: "every downstream module SHALL mark the corresponding final word of its
own output stream `tuser`[0] = 1".
*Reading I enforce*: a module that has already emitted a word of a frame when it
detects an error forwards the frame and marks its `tlast`; a module that detects
its own discard condition before emitting any word of that frame emits no output
frame at all and REQ-007 does not apply to it; where an inherited `tuser`[0] and
a local discard condition both apply, the local discard wins and its strobe
pulses.
*Spec diff (D-5)*: state that precedence rule normatively, and state whether a
module ever re-reports an inherited abort with a strobe (my reading: no).

**REQ-008 — AMBIGUOUS (blocking, X-4, D-6).** The method cannot detect the
violation the REQ prohibits.
*Quoted*: requirement "Every condition under which a module discards or truncates
a frame SHALL be reported by a dedicated one-cycle-high output strobe" versus
method "For each **named** strobe in this document, a directed test drives the
condition".
*Reading I enforce*: the directed tests establish that declared strobes work;
they say nothing about undeclared silent discards, which is the entire point of
the REQ.
*Spec diff (D-6)*: add to the Verification cell — "plus a frame-conservation
monitor active in every bench: over the whole run, (frames presented to the
module) = (frames emitted) + (discard-strobe pulses), with aborted-but-forwarded
frames counted as emitted. A discrepancy is a silent discard." This one addition
also repairs REQ-020, and it is cheap: the scoreboard that REQ-004 needs already
holds both counts.
*Second finding (should-fix)*: "dedicated ... strobe named for that condition"
is contradicted by REQ-105 and REQ-110, which share `error_bad_frame` between two
distinct conditions. Either give REQ-110 its own strobe or amend REQ-008 to
permit a strobe covering an enumerated condition set.
*Third finding (X-7, should-fix)*: "asserts for exactly one cycle and no other
strobe asserts" has no observation window — see D-5 clause (c).

**REQ-009 — AMBIGUOUS (blocking, D-8).**
*Quoted*: "assert `clear` mid-frame, deassert, immediately drive a valid frame,
check it is received correctly and **no partial frame is emitted**".
*The contradiction*: the receive path is cut-through (REQ-005), so when `clear`
asserts mid-frame the earlier words of that frame have **already left** the
module. A partial frame necessarily exists downstream, with no `tlast` — which
is precisely what REQ-015's monitor forbids on the following frame.
*Reading I enforce*: `clear` truncates the in-flight output frame without a
terminating word, and every downstream protocol monitor resets its
frame-in-progress state on `clear`; the assertion is on words emitted *after*
`clear`, not before.
*Spec diff (D-8)*: choose and state one of — (a) `clear` forces a final word with
`tlast = 1`, `tuser[0] = 1` on every output stream, or (b) `clear` truncates
without termination and monitors are explicitly exempted across a clear. Also
tighten "within one cycle of `clear` deasserting": state "on every cycle in which
`clear` = 1 and on the first cycle in which it is 0, every `tvalid` and every
strobe SHALL be 0; a frame whose first word is presented on the first cycle after
`clear` returns to 0 SHALL be received correctly."

**REQ-010 — AMBIGUOUS (should-fix).**
*Quoted*: "Ad-hoc per-module stream records are prohibited", verified by
"Interface compile check".
*Reading I enforce*: a compile check cannot detect the prohibited thing — a
hand-written record with the same six fields compiles perfectly. What compiles is
the *specification's* lifted block, not the RTL, so as written REQ-010 constrains
the spec only.
*Spec diff*: require the `ifc_check` file to contain a type-identity witness per
stream port (e.g. `let _check (x : Signal.t Axi64.Source.t) = x` applied to the
record field), which does fail on an ad-hoc record; and state explicitly that the
RTL-side binding is rtl_lead's obligation, evidenced by the module's `.mli`.

**REQ-011 — AMBIGUOUS (editorial).**
*Quoted*: "On every word except the one carrying `tlast`, `tkeep` SHALL be 0xFF."
*Reading I enforce*: every `tkeep` obligation is conditioned on `tvalid` = 1 (as
REQ-013 does explicitly for `tuser`). A monitor written literally fails a
conformant design that drives `tkeep` = 0 on idle cycles.
*Spec diff*: insert "on every word with `tvalid` = 1" into the two sentences.
Note this row is also the source of X-10.

**REQ-012 — AMBIGUOUS (should-fix).**
*Quoted*: "presented in header records as numeric values with network byte order
already decoded (ethertype 0x0800 reads as the value 0x0800)".
*Reading I enforce*: the first wire octet of a multi-octet field is the most
significant octet of the numeric value, so MAC `00:11:22:33:44:55` reads as
`0x001122334455` and IPv4 `192.0.2.1` reads as `0xC0000201`.
*Spec diff*: add exactly those two examples. The single ethertype example is
symmetric under byte swapping and therefore does not pin the convention for the
48-bit and 32-bit fields, which is where a test writer actually goes wrong.

**REQ-013 — AMBIGUOUS (blocking, X-5, D-5).**
*Quoted*: "`tuser`[0] SHALL mean 'this frame is invalid, discard it'".
*Reading I enforce*: it is advisory metadata for the ultimate consumer. No
Phase-1 module drops or alters a frame because its input carried `tuser`[0] = 1
— REQ-104 forwards, REQ-403 propagates, REQ-707 delivers to the application.
Read literally, "discard it" instructs every downstream module to do the opposite
of REQ-007.
*Spec diff (D-5)*: "…SHALL mean 'this frame was found invalid; the ultimate
consumer must discard it'. No Phase-1 module SHALL drop or alter a frame solely
because `tuser`[0] = 1 on its input (REQ-007, REQ-403)."

**REQ-014 — TESTABLE.** Test shape: producer side, monitor `tstrb` = 0 on every
`tvalid` word of every stream; consumer side, a differential run of the same
stimulus with `tstrb` = 0x00 and `tstrb` = 0xFF, asserting the two output traces
are byte-identical. "Changes nothing observable" is unusually well-phrased —
it names a falsifiable experiment.

**REQ-015 — UNTESTABLE (should-fix).**
*Missing observable*: frame identity. A single `Axi64` stream carries no frame
tag, so "frames SHALL NOT interleave" has nothing to observe on — words between
two `tlast`s *are* one frame by construction. The stated method ("Protocol
monitor") therefore monitors a tautology. Interleaving is only observable where
two distinguishable sources merge, which is REQ-406.
*Spec diff*: restate REQ-015 as the checkable residue — "between two successive
words carrying `tlast` = 1 a stream SHALL carry at least one and at most 189
words, and SHALL NOT assert `tlast` without at least one preceding word since the
last `tlast`" — and cross-reference REQ-406 for merge atomicity. Also see D-8:
the monitor's behaviour across `clear` must be stated.

**REQ-016 — TESTABLE.** Test shape: idle-injection wrapper around any directed
bench, parameterised 0/1/7 idle cycles between every pair of words, asserting the
output word sequence is unchanged. Note this row is what forces D-4's per-octet
latency definition (a stalled input word delays its output word by the same
amount, so latency is constant in octets, never in absolute cycles) — and it is
what collides with REQ-206 (see D-13).

**REQ-017 — TESTABLE.** Test shape: parse the port list of the emitted `nic_top`
module in `rtl_snapshots/` and set-compare against the port list of the frozen
SPEC-M20 §4.1. Executor per X-9. The expected set only exists once SPEC-M20
freezes, which is the right ordering.

**REQ-018 — AMBIGUOUS (should-fix).**
*Quoted*: "Emitted-Verilog inspection for vendor primitive names".
*Reading I enforce*: the enumerable check is a **whitelist, not a blacklist** —
the set of vendor primitive names is unbounded and no two reviewers would pick
the same grep list, whereas the set of legal module names is exactly the
architecture §4 inventory.
*Spec diff*: replace the method with "(a) the emitted Verilog SHALL instantiate
no module outside the architecture §4 inventory — this catches every vendor
primitive by construction; (b) the repository SHALL contain no `.xdc`, `.sdc`,
`.qsf` or equivalent constraint file at the freeze SHA". Also: §11 records "PTP
timestamping | Out of scope | REQ-018", but REQ-018's text never mentions PTP —
add it to the prohibition list or repoint the §11 row.

**REQ-019 — UNTESTABLE (blocking, D-4).**
*Missing observable*: buffer depth. The stated method is "structural review at
spec freeze plus REQ-005 constant-latency evidence (a deeper buffer shows up as
variable or excessive latency)" — but a three-deep pipeline that always delays by
three cycles has *perfectly constant* latency and passes REQ-005, and "excessive"
has no threshold anywhere in this document. Structural review is the architect
reading prose, not a DV observable, and I do not read RTL pre-verdict (PROTOCOL
§10). As written I would have to declare REQ-019 a `GAP` in every receive-path
sign-off packet.
*Spec diff (D-4 clause c)*: import architecture §4's latency allocation table
into requirements.md as a normative per-module ceiling, and restate REQ-019 as
"each receive-path module's pinned latency constant SHALL be no greater than its
ceiling in <table>" — which is testable, is what the invariant actually protects,
and makes an over-budget module a visible spec diff exactly as architecture §4
intends. Keep the structural sentence as design guidance explicitly marked
not-DV-verifiable, so the traceability matrix does not claim coverage it lacks.

**REQ-020 — AMBIGUOUS (should-fix, D-6).**
*Quoted*: "check the received sequence is 0, 1, 2, … with no gaps or repeats".
*Reading I enforce*: over an all-accepted stimulus, which is the only stimulus
for which "no gaps" is true — any frame legitimately discarded by REQ-404 /
REQ-604 / REQ-607 / REQ-703 / REQ-704 creates a gap that this method cannot
distinguish from a bug.
*Spec diff (D-6)*: "the delivered sequence SHALL be a strictly increasing
subsequence of the injected sequence, and every omitted value SHALL be accounted
for by exactly one discard-strobe pulse" — the same conservation monitor that
repairs REQ-008, so one diff fixes both.

**REQ-021 — TESTABLE.** Test shape: at each stripping stage, inject payloads of
every residue modulo 8 and assert the first payload octet lands in `tdata`[7:0]
of the output's first word and the octet stream is preserved. Cumulative offsets
14, 20, 8 make the interesting realignments 6, 4 and 0 octets. A model row.

### Block 1 summary

Six of twenty-one are clean. The invariants block is where the document is
simultaneously strongest and weakest: the *intent* is unusually well chosen —
cut-through, zero backpressure, no deep buffering, everything observable — but
several of these invariants are stated as structural facts whose violation
produces no port-visible symptom, and their Verification cells then reach for
methods that cannot fail. REQ-004's "no backpressure asserted" cannot fail
because there is no `tready` to assert; REQ-008's strobe tests cannot detect the
undeclared discard the REQ exists to forbid; REQ-019's constant-latency evidence
cannot detect a constant-but-deep buffer; REQ-015's monitor watches a tautology.
The fix in every case is the same move — replace an unfalsifiable structural
assertion with the port-visible symptom it is supposed to prevent (word loss,
frame non-conservation, latency over ceiling) — and in the REQ-004/REQ-008 cases
the needed machinery is one scoreboard that the line-rate bench needs anyway.
Separately, three cross-cutting definitions are missing outright: what "receive
path" means (X-1), what a stated frame length includes (X-2), and where latency
is measured (X-6). Those three are worth more than any single row, because they
recur in every later block.

---

## 4. Block 2 — XGMII receive (REQ-101 … REQ-113)

**REQ-101 — AMBIGUOUS (should-fix, X-6).**
*Quoted*: "SHALL produce **identical output streams** for the same frame received
at either alignment" verified by "compare output words, `tkeep` and `tlast` for
equality".
*Reading I enforce*: identical as the ordered sequence of (`tdata`, `tkeep`,
`tlast`, `tuser`) tuples over words with `tvalid` = 1 — **not** cycle-aligned
waveform equality, which no conformant design can achieve (see X-6: a lane-4
start needs one more input word before the first output word can be assembled).
*Spec diff*: add "compared as the ordered sequence of valid words; the absolute
cycle of the first output word may differ by one cycle between start lanes".

**REQ-102 — AMBIGUOUS (blocking, D-9).**
*The collision*: REQ-102 says the receiver "SHALL NOT validate" the seven octets
after `/S/`. REQ-105 says an `/E/` "between the start character and the terminate
character" aborts the frame. The preamble octets are between the start and
terminate characters. So an `/E/` in a preamble lane is both ignored (REQ-102)
and fatal (REQ-105), and two writers will build opposite expectations for a case
that a fuzzing bench reaches immediately.
*Reading I enforce*: REQ-102 governs the *data* octets in preamble positions; a
lane marked as **control** in a preamble position is an error character and
REQ-105 applies.
*Spec diff (D-9)*: state that, or state the opposite — but state it. Add the case
to REQ-102's Verification cell either way.

**REQ-103 — AMBIGUOUS (should-fix, X-2, D-2).**
*Quoted*: "Directed tests at lengths 64, 65, 71, 72, 73 and 1518 octets".
*Reading I enforce*: lengths are destination address through FCS inclusive (§0's
convention), so the delivered payloads are 60, 61, 67, 68, 69 and 1514 octets.
*Spec diff (D-2)*: state the convention once in §0, and replace the length set
with 64–71 inclusive plus 1518 so that all eight `tlast` `tkeep` patterns are
covered — as REQ-011's own Verification cell already demands and this set does
not deliver.

**REQ-104 — TESTABLE.** Test shape: inject a frame with one payload bit flipped;
assert the same octet count is delivered, `tuser`[0] = 1 on the `tlast` word,
`error_bad_fcs` pulses once. Clean, falsifiable, and the CRC oracle is externally
anchored via REQ-303/305. Multi-error interaction deferred to D-5.

**REQ-105 — AMBIGUOUS (blocking, D-9).**
*Quoted*: "termination of the output frame **at the word containing the error**".
*The ambiguity*: if `/E/` arrives in lane 3 of an input word, does the output's
last word carry lanes 0–2 with `tkeep` = 0x07, or is the whole word suppressed?
And when `/E/` is in lane 0, there are no preceding octets in that word at all.
*Reading I enforce*: identical in structure to REQ-106's terminate rule — the
last output octet is the one immediately preceding the error character; an error
character in lane 0 means the previous word carried `tlast`.
*Spec diff (D-9)*: say exactly that, by cross-reference to REQ-106 ("as REQ-106,
with the error character in place of the terminate character"). Then extend the
Verification cell beyond lanes 0 and 7 to all eight lanes, since the boundary
cases are the ones that break.

**REQ-106 — TESTABLE.** Test shape: choose frame lengths so `/T/` lands in each
of lanes 0–7 and assert `tkeep`/`tlast` placement in all eight. Exhaustive over
its own domain — the strongest row in this block, and the template REQ-105 and
REQ-110 should follow.

**REQ-107 — AMBIGUOUS (blocking, X-2, X-10, D-9).**
*Quoted*: "A frame carrying fewer than 64 octets … SHALL be forwarded with
`tuser`[0] = 1 **on the `tlast` word**" verified by "16-, 60- and 63-octet frames
with valid FCS".
*Two defects*: (a) for a frame of fewer than 4 octets there is no FCS to strip
(REQ-103) and no payload octet to carry, so there is no `tlast` word on which to
set the abort bit — the requirement is unsatisfiable at the bottom of its own
range, and X-10 says the stream cannot represent the zero-length result; (b) "16
octets with valid FCS" does not say whether the 16 includes the four FCS octets,
which changes the expected delivered length from 12 to 16.
*Reading I enforce*: lengths are DA-through-FCS (so a "16-octet frame" delivers
12 payload octets), and frames shorter than 5 octets are outside the specified
domain.
*Spec diff (D-9)*: state the convention (D-2), and specify the sub-5-octet case
explicitly — my recommendation is "a frame carrying fewer than 5 octets between
the start and terminate characters SHALL produce no output words and SHALL pulse
`error_runt` once", which is representable and testable.

**REQ-108 — AMBIGUOUS (blocking, D-9).**
*Quoted*: "SHALL be truncated at 1518 octets".
*The ambiguity*: is the delivered payload 1518 octets or 1514? REQ-103 strips
four FCS octets from the end of a frame — but a truncated frame has no FCS at the
truncation point, so there is nothing to strip and no way for a test writer to
know which number to assert.
*Reading I enforce*: 1514 delivered octets, matching the payload length of a
maximum legal frame, with no FCS-stripping attempted on a truncated frame — so
downstream sees the same length envelope it sees for a legal 1518-octet frame.
*Spec diff (D-9)*: state the delivered octet count as a number, and state whether
`error_bad_fcs` also pulses (X-5: the truncated frame's FCS check necessarily
fails).

**REQ-109 — AMBIGUOUS (should-fix).**
*Quoted*: "While idle characters are present the receiver SHALL hold `tvalid` = 0".
*The problem*: false failure on a conformant design. The receiver's pipeline is
still draining the previous frame during the first idle cycles, so `tvalid` is
legitimately high while idles are on the wire. A monitor written literally fails
every correct implementation.
*Reading I enforce*: the obligation begins once the pipeline has drained — i.e.
from k cycles after the terminate character, where k is the module's pinned
latency constant.
*Spec diff*: "While idle characters are present **and no frame remains in flight
in the receiver**, …", and make the 1000-idle-cycle test start its assertion k
cycles in.

**REQ-110 — AMBIGUOUS (should-fix, D-9).**
*Quoted*: "a single `error_bad_frame` pulse" — the same strobe REQ-105 uses for a
different condition, which contradicts REQ-008's "a **dedicated** … strobe named
for that condition".
*Reading I enforce*: `error_bad_frame` covers both conditions and a bench cannot
use the strobe alone to distinguish them.
*Spec diff*: either add `error_start_without_terminate`, or amend REQ-008 to
permit one strobe over an enumerated condition set and say so here. Also inherits
D-9's truncation-boundary rule: a start character in lane 4 leaves lanes 0–3 of
that word belonging to the aborted frame.

**REQ-111 — AMBIGUOUS (blocking, X-6, D-4).**
*Quoted*: "a fixed constant … independent of frame length, frame content **and
start lane**".
*Why no design can satisfy it literally*: with a lane-0 start the first output
word is assembled from one input word; with a lane-4 start it needs two. The
delay from the start-character word to the first output word therefore differs by
one cycle between lanes, necessarily.
*Reading I enforce*: the per-octet definition of D-4 — the delay from the input
word carrying octet n to the output word carrying octet n — which *is* constant
across both start lanes and is the property the invariant actually wants.
*Spec diff (D-4)*: adopt the per-octet definition in REQ-005 and reference it
here; state the measurement events explicitly rather than as "word in to word
out".

**REQ-112 — TESTABLE.** Test shape: interface compile check that the `I` record
contains no `tready` field, plus the REQ-004 stress as the behavioural half. The
only observable failure mode is word loss, which the stress bench catches; the
structural half cannot fail once the type is fixed, and that is fine — it is
honest structural enforcement rather than a bench pretending to test it.

**REQ-113 — TESTABLE.** Test shape: drive a local-fault ordered-set sequence for
100 cycles, assert no `tvalid` and no strobe, then send a frame and compare it
against the same frame received after idles only. Editorial: "no state change" is
not port-observable and should be restated as that comparison, which is what the
Verification cell already implies.

### Block 2 summary

Four of thirteen are clean, and the block's structure is good — the receive
module's error taxonomy (bad FCS, mid-frame error, runt, oversize, start without
terminate, ordered sets) is complete enough that I do not expect to find a
missing category during attack-plan work. What is missing is boundary precision
at exactly the places a 64-bit-word receiver is hard: which output word carries
the last octet when an error or a new start character interrupts mid-word
(REQ-105, REQ-110), what happens at the bottom of the runt range where no output
word exists at all (REQ-107), what the truncation length is for an oversize frame
(REQ-108), and whether a control character in a preamble lane is ignored or fatal
(REQ-102). Each of those is a one-sentence fix, and each is a case my attack plan
must enumerate exhaustively — so they will be found by a bench in Phase 1
whether or not they are fixed now; the only question is whether they surface as a
spec diff before RTL is written or as a `BUG-` and a dispute after. Separately,
REQ-111 is the sharpest single defect in the document: it demands a constant that
provably cannot exist under the natural measurement, and the fix (D-4) is the
same one REQ-005 and REQ-019 need.

---

## 5. Block 3 — XGMII transmit (REQ-201 … REQ-210)

**REQ-201 — TESTABLE.** Test shape: decode 100 transmitted frames from the XGMII
output; assert `/S/` is in lane 0 in every case and the eight preamble octets are
exactly `/S/`, 0x55 × 6, 0xD5.

**REQ-202 — AMBIGUOUS (should-fix, D-10).**
*Quoted*: "Feed the transmitted frame into the REQ-304 residue check **and into
the receiver**; the FCS validates."
*Why the method is weak*: both halves are self-referential — the receiver and the
transmitter share the same `Crc32_eth` engine, so a systematically wrong but
self-consistent CRC passes. The independent oracle is the software bit-serial
reference of REQ-305 and the known-answer constant of REQ-303.
*Spec diff*: "the four FCS octets SHALL be compared octet-for-octet against a
CRC-32 computed by the DV software reference (REQ-305), not only against the
receiver's own check". **Also**: the octet order of the FCS field on the wire is
never stated. It is recoverable only from REQ-304, and only because the residue
property holds for exactly one ordering — I verified that the residue is constant
across messages when the FCS is appended least-significant-octet-first and varies
per message otherwise (§13.5). State it: "the FCS SHALL be transmitted least
significant octet first."

**REQ-203 — TESTABLE.** Test shape: transmit a 20-octet frame; assert the wire
carries 60 octets before the FCS with zeros from octet 21 to 60, and 64 octets
DA-through-FCS total.

**REQ-204 — AMBIGUOUS (blocking, D-3).** This is the finding I would have most
regretted missing, because it silently determines whether my line-rate bench
stresses the design at all.
*Quoted*: "Between the terminate character of one frame and the start character
of the next, the transmitter SHALL emit at least `cfg_ifg` **idle** octets
(default 12)" — i.e. the terminate character sits *outside* the 12.
*The collision*: §0 and REQ-004 require the opposite convention. §0 computes "8
octets of preamble+SFD, 64 octets of frame … and at least 12 octets of
inter-frame gap = 84 octets = 10.5 cycles", and claims the 10/11-cycle
alternation. I walked that arrival pattern lane by lane: with a lane-0 start at
cycle T the frame ends at lane 7 of T+8 and `/T/` lands in lane 0 of T+9; the
next start can only be at lane 4 of T+10 (10 cycles) if `/T/` **counts inside**
the 12-octet gap, giving exactly 12 IFG octets. Continuing from that lane-4 start,
the next lane-0 start falls 11 cycles later, again with `/T/` counted. That
reproduces 10, 11, 10, 11 — average 10.5, exactly §0's claim. Under REQ-204's
wording (12 idles *after* `/T/`) the minimum spacing becomes 11 and 11, and the
"worst case the receive path must survive" is **9.5 % slower than specified**.
*Reading I enforce*: the inter-frame gap is measured from the terminate character
inclusive to the next start character exclusive, minimum 12 octets; my REQ-004
stimulus generator will produce the 10/11 alternation.
*Spec diff (D-3)*: state that convention once in §0, and restate REQ-204 as "at
least `cfg_ifg` octets counted from the terminate character inclusive". REQ-204's
own expected answer (88 octets start-to-start) is unaffected — it rounds to the
same value under either convention, which is exactly why this would have survived
review without a lane-by-lane walk.

**REQ-205 — TESTABLE.** Test shape: frame lengths placing `/T/` in each of lanes
0–7; assert the control-lane encoding of the terminate word and that all
subsequent lanes and gap words carry idle. With lane-0 starts, `/T/`'s lane is
(DA-through-FCS length) mod 8, so the eight cases are directly constructible.

**REQ-206 — AMBIGUOUS (blocking, D-13).**
*The contradiction*: REQ-016 says "every consumer SHALL tolerate arbitrary idle
gaps within a frame without corrupting it". REQ-206 says "if the source stream
stops mid-frame the transmitter SHALL emit an error character followed by a
terminate character". The XGMII transmitter is a consumer, and once it has begun
emitting on the wire it cannot tolerate any gap at all — the wire has no idle
concept mid-frame. So the two requirements are in direct conflict, and the
threshold ("stops" = how many cycles?) is unstated.
*Reading I enforce*: REQ-016 does not apply to `Xgmii_tx_64`'s source interface;
a single cycle in which the transmitter asserts `tready`, requires a word, and
does not receive one is an underflow.
*Spec diff (D-13)*: scope REQ-016 to receive-path and internal frame streams
explicitly, and define "stops mid-frame" in REQ-206 as the single-cycle condition
above — or, if an elastic buffer is intended, state its depth so the threshold is
derivable. As written I cannot build the stimulus that provokes the strobe
without guessing the threshold.

**REQ-207 — TESTABLE.** Test shape: drive a continuous source; record the
sequence of words for which `tvalid & tready` held; decode the wire and assert the
payload octet sequence equals the accepted-word octet sequence exactly once, in
order. Editorial: the first clause ("SHALL deassert `tready` whenever it cannot
accept a word") describes an internal condition and carries no independent
observable; the second clause is the whole testable content.

**REQ-208 — TESTABLE.** Test shape: hold the transmitter busy with a maximum-length
frame while driving the receive path at the REQ-004 rate; assert REQ-004 still
holds and `error_arp_reply_dropped` fires. Editorial: "discarded and **counted**"
implies a counter, but REQ-804 provides one-cycle strobe fields, not counters —
say "reported by the strobe named in REQ-510". Reachability of the drop condition
depends on REQ-510 (D-14).

**REQ-209 — TESTABLE.** Test shape: sustained transmit of 10 000 minimum frames;
assert mean cycles per frame equals 11 at the default gap. Editorial: "at a rate
of at least one frame per 11 cycles" is a bound, but REQ-204 fixes the spacing at
exactly 11, so state it as an equality and the bench becomes a much sharper
detector.

**REQ-210 — AMBIGUOUS (should-fix, X-6).**
*Quoted*: "The delay from the first accepted source word to the XGMII word
carrying the start character SHALL be a fixed constant."
*The problem*: it is constant only from idle. When frames are streamed
back-to-back the transmitter must hold the next start until REQ-204's gap is
satisfied, so a bench that measures over a sustained run sees a varying delay and
fails a conformant design.
*Reading I enforce*: measured with the transmitter idle and the REQ-204 gap
obligation already satisfied.
*Spec diff*: add that qualification, and name the measurement events explicitly
per D-4.

### Block 3 summary

Six of ten are clean, and the transmit block is the most mechanically precise
part of the document — REQ-201, REQ-203 and REQ-205 state exact octet values and
exact lane placements, and their Verification cells name the decode that checks
them. The block's two real problems are both about *when* rather than *what*.
REQ-204 carries an inter-frame-gap convention that contradicts the arithmetic §0
uses to derive the programme's headline invariant, and because REQ-204's own
expected answer is insensitive to the difference, the error hides; the
consequence lands entirely on my side of the fence, as a line-rate bench that
would have under-driven every receive-path module by roughly ten percent forever.
REQ-206 collides head-on with REQ-016 — a transmit adapter that has begun
emitting cannot tolerate the idle gaps the invariants block promises every
consumer will tolerate — and until that is resolved I cannot build the stimulus
that provokes `error_underflow`, which is one of the twenty strobes REQ-804
requires me to demonstrate at the top level.

---

## 6. Block 4 — CRC-32 / FCS (REQ-301 … REQ-306)

**REQ-301 — TESTABLE.** Test shape: the parameterisation (poly 0x04C11DB7, init
0xFFFFFFFF, reflected in and out, final XOR 0xFFFFFFFF) is fully specified, so
the software reference is written from this row alone and REQ-303/304 anchor it
externally. Exemplary requirement — one sentence, no reader judgement required.

**REQ-302 — TESTABLE.** Test shape: for each valid-octet count 1–8, compare the
parallel update against an octet-at-a-time software reference over 10 000 random
inputs; assert exact equality. A genuine differential with an independent oracle.

**REQ-303 — AMBIGUOUS (blocking) — `DEFECT`: the stated constant is wrong.**
*Quoted*: "The CRC of the nine ASCII octets '123456789' SHALL be **0xCBF43F26**."
*Computed under REQ-301's own parameterisation*: **0xCBF43926**. The canonical
CRC-32/ISO-HDLC check value is 0xCBF43926; the document has 0x3F where 0x39
belongs. Reproduced in §13.5.
*Consequence if unfixed*: this is the known-answer test that anchors the entire
FCS chain. Written literally it fails a correct engine on day one, and the
failure looks like an RTL bug — I would have opened a CRITICAL `BUG-` against
rtl_lead for a defect that is in the specification.
*Spec diff (D-10)*: 0xCBF43F26 → 0xCBF43926.

**REQ-304 — AMBIGUOUS (blocking) — `DEFECT`: constant and convention do not
match.**
*Quoted*: "The CRC computed over a frame concatenated with its own correct FCS
SHALL equal the constant **0xC704DD7B**."
*Computed under REQ-301's convention* (reflected in and out, final XOR, FCS
appended least-significant-octet-first): **0x2144DF1C**, constant across every
message length I tried. 0xC704DD7B is not wrong in the world — it is the same
residue expressed in the *non-reflected* register convention: bitrev32(¬0x2144DF1C)
= bitrev32(0xDEBB20E3) = 0xC704DD7B, verified in §13.5. The document pairs the
reflected algorithm of REQ-301 with the non-reflected constant of REQ-304.
*Reading I enforce*: REQ-301's convention governs, so the residue is 0x2144DF1C.
*Spec diff (D-10)*: either change the constant to 0x2144DF1C, or state that
REQ-304's constant is the residue of the internal non-reflected register before
output reflection and final XOR — and if the latter, say which internal signal a
test is supposed to observe, because from the module's ports only the REQ-301
value is visible. My recommendation is the constant change; it keeps every stated
value on the same convention. Note this residue is also what pins the FCS wire
octet order (REQ-202) — it is constant only for least-significant-octet-first.

**REQ-305 — TESTABLE.** Test shape: randomised comparison of the parallel engine
against a bit-serial reference across all octet counts over ≥10 000 frames. The
external anchor for the whole FCS chain and correctly identified as a formal
candidate.

**REQ-306 — TESTABLE.** Test shape: the emitted `crc32_eth` module has no `clock`
port and contains no `always @(posedge …)` — a crisp mechanical check on the
snapshot (X-9 on the executor), stronger than the "inspection" the cell names.

### Block 4 summary

Four of six clean, and this block would otherwise be the best-written in the
document — REQ-301 pins every CRC parameter, REQ-302 and REQ-305 both name
independent software oracles rather than self-comparison, and REQ-306 states a
structural property with a genuinely mechanical check. The two failures are
therefore all the more consequential: both known-answer constants that anchor the
chain are unusable as written, one a single-hex-digit transcription error and one
a convention mismatch that is subtle enough to survive several careful readings
(0xC704DD7B is a real and widely published Ethernet residue — just not the one
REQ-301's parameterisation produces). I want to be explicit about what this pair
means for the programme rather than just for the document: these are the two
values a test writer would have hard-coded, they would have failed against
correct RTL, and the resulting `BUG-` packets would have consumed rtl_lead's time
and the orchestrator's dispute path before anyone thought to question the spec.
Verifying arithmetic constants against an independent implementation before
freeze — rather than after a bench turns red — is the single highest-value thing
this review did, and I intend to repeat it on every constant in the per-module
specs as they arrive.

---

## 7. Block 5 — Ethernet framing (REQ-401 … REQ-410)

**REQ-401 — AMBIGUOUS (blocking, X-10, D-7).**
*Quoted*: "a header record whose `valid` field is high for exactly one cycle per
frame, no later than the first payload word of that frame".
*The gap*: a frame of exactly 14 octets has a header and **no payload words**, so
"no later than the first payload word" references an event that never occurs, and
REQ-011 forbids representing a zero-length payload frame at all.
*Reading I enforce*: `valid` asserts on or before the cycle carrying the first
payload word, and for a header-only frame it asserts within the module's pinned
latency of the input `tlast`; no payload frame is emitted.
*Spec diff (D-7)*: resolve X-10 programme-wide and state the header-only case
here explicitly, including whether downstream modules must tolerate a header
record with no accompanying payload frame.

**REQ-402 — AMBIGUOUS (blocking, X-10, D-7).**
*Quoted*: "Inject **0-**, 8- and 13-octet frames."
*The gap*: a 0-octet frame cannot be presented on an `Axi64` stream — REQ-011
forbids `tkeep` = 0 with `tvalid` = 1, so the stated test case is unbuildable.
*Reading I enforce*: the smallest presentable frame is one octet; I would test 1,
8 and 13.
*Spec diff (D-7)*: replace "0-" with "1-", or specify the zero-length encoding
per D-7 and keep the case.

**REQ-403 — AMBIGUOUS (should-fix, X-5, D-5).**
*Quoted*: "An input frame whose last word carries `tuser`[0] = 1 SHALL produce an
output payload frame whose last word carries `tuser`[0] = 1."
*Reading I enforce*: subject to the frame producing an output frame at all — a
13-octet aborted frame is discarded under REQ-402 and there is nothing to mark.
*Spec diff (D-5)*: add "…where an output payload frame is produced; a frame
discarded under REQ-402 produces no output and its strobe is the only report".

**REQ-404 — TESTABLE.** Test shape: drive ethertypes 0x0800, 0x0806, 0x8100 and
0x86DD; assert routing to the IPv4 port, the ARP port, and discard with a single
`error_unknown_ethertype` for the last two. The demux decides from the header
record before any payload word, so the discard is clean and needs no abort
interaction.

**REQ-405 — TESTABLE.** Test shape: build a frame from a known header record and
payload; compare octet-for-octet against a hand-assembled reference frame.

**REQ-406 — TESTABLE.** Test shape: two-port bench issuing simultaneous frames
with distinguishable payloads; assert no interleaving on the output and that the
losing port is granted within one cycle of the winner's `tlast`. Editorial: which
port wins a tie is deliberately unconstrained and the bench must not assert one —
worth one sentence in the module spec's "deliberately unconstrained" section.
This row also carries the only *observable* content of REQ-015.

**REQ-407 — TESTABLE.** Test shape: send a frame with a foreign destination MAC
and a matching destination IP; assert it is delivered to the application. A
negative requirement given a positive observable — the right way to state one.

**REQ-408 — AMBIGUOUS (blocking, X-2, D-2) — arithmetic error in the Verification
cell.**
*Quoted*: "64-octet frame carrying a 20-octet IPv4 datagram: the Ethernet payload
is **50 octets**."
*The arithmetic*: under §0's convention a 64-octet frame is DA through FCS, so
`Xgmii_rx_64` strips the 4 FCS octets (REQ-103) and `Eth_axis_rx` sees 60 octets,
of which 14 are header — the Ethernet payload is **46 octets**, not 50. The
figure 50 is 64 − 14, which omits the FCS. The alternative reading (that "64-octet
frame" here means 64 octets *excluding* FCS) makes the number right but implies a
68-octet wire frame, which is not the minimum-length frame the row is obviously
about, and contradicts §0 and REQ-108.
*Reading I enforce*: 46 octets. Corroborated at the other end of the range:
1518 − 14 − 4 = 1500 = REQ-612's maximum IPv4 total length, which only works under
the DA-through-FCS convention.
*Spec diff (D-2)*: 50 → 46, and state the convention in §0.

**REQ-409 — AMBIGUOUS (should-fix).** Inherits REQ-012's gap: this row is
precisely about numeric field presentation, and the 48-bit MAC fields are where a
test writer picks the wrong endianness. Same diff as REQ-012 — add the MAC and
IPv4 examples.

**REQ-410 — TESTABLE.** Test shape: two frames with zero idle cycles between
them; assert both are delivered intact with correct header records.

### Block 5 summary

Five of ten clean. The framing block is where the document's zero-length-payload
blind spot first becomes concrete — a 14-octet Ethernet frame is legal, arrives
in any real capture, and has no representation on the stream type the programme
chose (X-10) — and it is also where the frame-length convention finally produces
a wrong number rather than just an ambiguity (REQ-408's 50 should be 46). Both
are cheap to fix and both are the kind of defect that, left in place, surfaces as
a test writer and an implementer confidently building to different arithmetic and
neither of them wrong. The rest of the block is solid: REQ-404's discard set
includes VLAN explicitly, REQ-406 bounds arbitration latency rather than merely
requiring fairness, and REQ-407 states a negative requirement (no MAC filtering)
in terms of a positive observable, which is the pattern I wish REQ-015 and
REQ-019 followed.

---

## 8. Block 6 — ARP (REQ-501 … REQ-512)

**REQ-501 — AMBIGUOUS (should-fix, X-4).**
*Quoted*: "ARP packets SHALL be accepted only with hardware type 1, protocol type
0x0800, hardware length 6 and protocol length 4; any other combination SHALL be
discarded."
*Two silent holes*: (a) the **operation** field is not part of the acceptance
test, so an ARP packet with operation 3, 4 or 0 is "accepted" — REQ-503 then
learns from it and nothing else happens, with no strobe. That is a silent discard,
which REQ-008 forbids. (b) A truncated ARP packet (fewer than 28 octets after the
ethertype) has no specified treatment and no strobe.
*Reading I enforce*: operations other than 1 and 2 are learned-from but produce no
reply and no strobe; a truncated ARP packet is discarded silently. Both readings
are ones I dislike and would rather the architect overrule.
*Spec diff*: extend the acceptance test to the operation field and to a minimum
packet length, with `error_arp_unsupported` covering both.

**REQ-502 — AMBIGUOUS (blocking, D-14).**
*Quoted*: "an ARP reply (operation 2) with the configured local MAC and IP as
**sender fields**, unicast to the requester's hardware address", verified by
"decode the transmitted frame **field by field**".
*The gap*: the reply's **target** hardware address and target protocol address are
never specified, yet the Verification cell demands a field-by-field decode. A test
writer has no expected value for two of the packet's six address fields.
*Reading I enforce*: target hardware address = the request's sender hardware
address; target protocol address = the request's sender protocol address (RFC 826).
*Spec diff (D-14)*: state both. Also name the two measurement events for the
64-cycle bound (my reading: from the cycle carrying the request's last XGMII word
to the cycle carrying the reply's start character).

**REQ-503 — TESTABLE.** Test shape: inject a request from an unknown host, then
trigger a transmit to that host; assert no ARP request is issued and the frame
carries the learned MAC. Note this specifies *promiscuous* learning (every
accepted packet, not only those addressed to us) — deliberate and clearly stated.

**REQ-504 — TESTABLE.** Test shape: insert two addresses whose low four bits of
the least significant octet collide; assert the first is evicted and the second
resolves. The index function is stated exactly, which is what makes collision
behaviour derivable rather than emergent — architecture §2.5 chose this over the
reference's LRU precisely so it would be testable, and the choice pays off here.

**REQ-505 — AMBIGUOUS (blocking, D-14).**
*Quoted*: "the datagram SHALL be discarded **without buffering**".
*The gap*: the application is mid-stream when the miss is detected. Does the
transmit path keep asserting `tready` and sink the remaining payload words to the
floor, or does it deassert `tready` and stall the application until it gives up?
The two produce completely different benches, and the second would violate the
programme's no-stall spirit while satisfying the literal text.
*Reading I enforce*: the transmit path continues to accept and discard the
remainder of that datagram's payload words, so the application is never stalled by
a resolution failure.
*Spec diff (D-14)*: state that. Also state whether every miss broadcasts a request
or whether requests are rate-limited — as written, 1 000 datagrams to an unresolved
host broadcast 1 000 requests, which no test writer would guess is intended.

**REQ-506 — AMBIGUOUS (should-fix).**
*Quoted*: "retried up to a configured retry count at a configured interval, and
entries SHALL expire after a configured lifetime".
*The gaps*: no default values, no permitted ranges, and no statement of what
happens **after** the retry count is exhausted — does a subsequent datagram to
that address start a fresh request burst, or is the address negatively cached?
*Reading I enforce*: each new miss starts a fresh retry sequence; nothing is
negatively cached.
*Spec diff*: state the three defaults and the post-exhaustion behaviour. The
"compile-time parameters so tests can use short values" clause is excellent and I
want more of it elsewhere in the document.

**REQ-507 — AMBIGUOUS (should-fix, D-14).**
*Quoted*: "When the destination address is outside the configured subnet…".
*The gap*: REQ-507, REQ-508 and REQ-509 all match on destination address and their
domains overlap — 255.255.255.255 and every 224.0.0.0/4 address are both "outside
the configured subnet". Evaluation order is unstated.
*Reading I enforce*: limited broadcast → subnet broadcast → multicast → on-subnet
cache lookup → gateway.
*Spec diff*: state that order, and state the subnet predicate explicitly
(`(dst & mask) = (local_ip & mask)`).

**REQ-508 — TESTABLE.** Test shape: transmit to 255.255.255.255 and to the
configured subnet broadcast address; assert destination MAC ff:ff:ff:ff:ff:ff and
no ARP request on the wire. Editorial: define the subnet broadcast address as
`local_ip | ~mask` so the test writer does not have to infer it.

**REQ-509 — TESTABLE.** Test shape: transmit to 239.1.2.3 and assert destination
MAC 01:00:5E:01:02:03. I checked the mapping: 239.1.2.3 = 0xEF010203, low 23 bits
= 0x010203, so the stated expected MAC is correct. Coverage note for my own attack
plan rather than a spec diff: the example never exercises the 23-bit mask, since
bit 23 of this address is 0 — I will add an address such as 239.129.2.3, which
must map to the same MAC.

**REQ-510 — UNTESTABLE (blocking, D-14).**
*Missing observable*: the condition under which a reply is dropped. REQ-406
guarantees the arbiter grants within one cycle of the current frame's `tlast`, so
the longest an ARP reply can wait is one maximum-length frame (~191 cycles), and
REQ-502 only promises a 64-cycle response "when the transmit path is idle".
Nothing states the depth of the reply queue or the timeout that turns waiting into
dropping. A design that simply waits — never dropping — satisfies every other row
in this block, and I cannot construct any stimulus that is *guaranteed* to provoke
`error_arp_reply_dropped`. Since REQ-804 requires me to demonstrate every strobe
at the top level, this makes a gate item unreachable.
*Spec diff (D-14)*: specify the drop condition concretely. My recommendation,
because it is minimal and directly testable: "the ARP module SHALL hold at most one
pending reply; an accepted request arriving while a reply is still pending SHALL
cause the newly generated reply to be discarded with a single
`error_arp_reply_dropped` pulse." Two back-to-back requests then provoke it
deterministically.

**REQ-511 — TESTABLE.** Test shape: inject gratuitous ARPs for a foreign address
and for the configured local address; assert cache update in both cases and a
reply only in the second. Editorial: it is worth confirming in the module spec
that a gratuitous ARP claiming *our own* address really is meant to create a cache
entry keyed on our own IP — the text requires it and I will test what it says, but
it reads like an unintended consequence rather than a decision.

**REQ-512 — TESTABLE.** Test shape: inject requests for three foreign target
addresses; assert no transmit activity. Consistent with REQ-503's learning, which
produces no transmit.

### Block 6 summary

Six of twelve clean, one untestable. ARP is the block where the *specification
technique* is at its best and its worst in the same table. At its best: REQ-504
pins the cache index function arithmetically so collisions are a derivable test
rather than an emergent property, REQ-506 mandates that timers be compile-time
parameters so benches can use short values, and REQ-509's multicast mapping is
stated as an exact bit operation with a worked example I was able to check by
hand. At its worst: REQ-510 requires a strobe for a condition the document never
makes reachable — every other requirement in the block conspires to ensure the
arbiter always eventually grants, so a design that never drops a reply passes
everything and the strobe can never be demonstrated, which blocks a REQ-804 gate
item. The remaining findings are all of one family: the ARP module sits at the
junction of receive, transmit and configuration, and the document specifies what
it does on the happy path far more carefully than what it does to the *other*
side's stream when something goes wrong — the reply's target fields (REQ-502),
the fate of the application's remaining payload words on a cache miss (REQ-505),
and the precedence among overlapping address classes (REQ-507).

---

## 9. Block 7 — IPv4 (REQ-601 … REQ-612)

**REQ-601 — TESTABLE.** Test shape: inject version 6, IHL 6 and IHL 4 datagrams;
assert each is discarded with a single `error_ip_bad_header` pulse.

**REQ-602 — TESTABLE.** Test shape: inject a datagram with one header bit flipped;
assert discard and a single `error_ip_bad_checksum` pulse. The embedded note about
the reference design not verifying this checksum, and the resulting restriction on
co-simulation stimulus, is exactly the kind of forward-looking statement that
makes REQ-901 executable — I would like more divergence classes handled this way
(see D-16). Editorial: cite RFC 791 §3.1 for the checksum algorithm, since
requirements.md does not carry architecture.md's reference list.

**REQ-603 — TESTABLE.** Test shape: inject a more-fragments-set datagram and a
non-zero-fragment-offset datagram; assert discard and a single `error_ip_fragment`
pulse each. DF and the reserved bit are left unconstrained, correctly.

**REQ-604 — TESTABLE.** Test shape: four accept cases (local IP, subnet broadcast,
255.255.255.255, configured multicast group with multicast enabled) and three
reject cases including the multicast group with multicast disabled; assert
`error_ip_not_for_us` on the rejects.

**REQ-605 — AMBIGUOUS (blocking, X-2, X-10, D-2, D-7) — arithmetic error in the
Verification cell.**
*Quoted*: "**64-octet frame carrying a 46-octet datagram (padding present)** and a
frame truncated 10 octets early".
*The arithmetic*: by REQ-408's corrected figure, a 64-octet frame yields a
46-octet Ethernet payload — so a 46-octet datagram fills it exactly and there is
**no padding at all**. The case as written tests the opposite of what it says it
tests. To exercise padding removal the datagram must be smaller than 46 octets;
e.g. a 28-octet datagram leaves 18 octets of padding.
*Second finding*: "exactly (total length − 20) payload octets" is zero octets for
a datagram with total length 20, which X-10 says cannot be represented.
*Reading I enforce*: 46-octet Ethernet payload; I will use a 28-octet datagram for
the padding case; a total length of exactly 20 is out of the specified domain until
D-7 is resolved.
*Spec diff (D-2, D-7)*: replace the example with one that actually has padding,
and resolve the zero-payload encoding.

**REQ-606 — TESTABLE.** Test shape: known-datagram test comparing source address,
destination address, protocol, TTL, DSCP and total length, plus `valid` high for
exactly one cycle no later than the first payload word.

**REQ-607 — TESTABLE.** Test shape: inject protocol 1 and protocol 6 datagrams;
assert discard with a single `error_ip_bad_protocol` pulse. Multi-condition
interaction (a non-UDP datagram that is also not-for-us) deferred to D-5.

**REQ-608 — TESTABLE.** Test shape: transmit three datagrams; decode and compare
every header field against the stated constants and assert the identification
sequence is 0, 1, 2 after clear. One of the best rows in the document — it pins
every field including the ones a reader would assume, and it makes a stateful
counter observable from the wire.

**REQ-609 — TESTABLE.** Test shape: verify the transmitted header against an
independently computed one's-complement checksum, and loop back through REQ-602.
Correctly names an *independent* oracle rather than the design's own checker.

**REQ-610 — AMBIGUOUS (blocking, D-11).**
*Quoted*: "Total length SHALL be 20 plus the **UDP length** supplied by the
application", where REQ-705 says the application supplies "**payload length**".
*The off-by-eight*: if "payload length" P means UDP payload octets, then UDP length
is P + 8 and total length is P + 28. If "payload length" means the UDP datagram
length, total length is P + 20. The document uses both terms for the same
interface field and never defines either.
*Reading I enforce*: the application supplies the count of **UDP payload octets**,
excluding the 8-octet UDP header; total length = payload length + 28; UDP length =
payload length + 8.
*Spec diff (D-11)*: define the field once, in REQ-705, and restate REQ-610's
arithmetic in terms of it. This is a wire-format defect: a bench built on the wrong
reading produces a plausible-looking `BUG-` against correct RTL.

**REQ-611 — AMBIGUOUS (should-fix, X-6, D-4).**
*Quoted*: "The receiver's **header-parse latency** SHALL be a fixed constant."
*Reading I enforce*: from the input word carrying the first octet of the IPv4
header to the cycle on which the header record's `valid` asserts, counted in words
rather than absolute cycles so that REQ-016's permitted idle gaps do not break the
constant.
*Spec diff (D-4)*: name the two measurement events, and state the word-counted
qualification.

**REQ-612 — TESTABLE.** Test shape: inject a datagram with total length 1501;
assert discard and a single `error_ip_oversize` pulse. Consistent with the 1518
maximum frame (1518 − 14 − 4 = 1500), which is the arithmetic that corroborates
X-2's convention.

### Block 7 summary

Nine of twelve clean — the strongest block in the document by a clear margin. The
IPv4 requirements read as though written by someone testing each row against the
question "could a stranger build the stimulus and compute the expected answer from
this sentence alone", and mostly they can: REQ-608 enumerates every constructed
header field including the identification counter's reset value and increment,
REQ-609 explicitly reaches for an independent checksum oracle instead of the
design's own, and REQ-602 anticipates a co-simulation divergence and states how it
will be handled. The three findings are all inherited rather than local: REQ-605's
padding example is wrong because of the frame-length convention (X-2), REQ-611
needs the same measurement-point definition every other latency REQ needs (X-6),
and REQ-610's "UDP length" versus REQ-705's "payload length" is one undefined
interface field producing an eight-octet error in every transmitted header. Fix
the three cross-cutting items and this block needs almost nothing of its own.

---

## 10. Block 8 — UDP (REQ-701 … REQ-709)

**REQ-701 — TESTABLE.** Test shape: known-datagram test asserting source port,
destination port, length and checksum fields and `valid` high for exactly one cycle
no later than the first payload word.

**REQ-702 — TESTABLE.** Test shape: inject a datagram with a deliberately wrong
non-zero UDP checksum; assert it is delivered unchanged, with no abort bit and no
strobe. A negative requirement with a fully positive observable — the model for how
to state a deliberate omission.

**REQ-703 — AMBIGUOUS (blocking, X-10, D-7).**
*Quoted*: "A UDP length below 8 … SHALL abort the payload frame with `tuser`[0] = 1
**on its last word**" and "Otherwise **exactly (length − 8)** payload octets SHALL
be delivered", verified by "Inject **length 0**, length 7, …".
*Two gaps*: (a) for a length below 8 there is no payload frame and therefore no last
word to carry the abort bit — unsatisfiable as written; (b) for length exactly 8 the
delivered payload is zero octets, which X-10 says the stream cannot represent.
*Reading I enforce*: a UDP length below 8 produces no output frame at all and only
the strobe; length exactly 8 is out of the specified domain until D-7 is resolved.
*Spec diff (D-7)*: state the sub-8 case as "no payload frame is emitted; the strobe
is the only report", and resolve the zero-payload encoding for length 8.

**REQ-704 — TESTABLE.** Test shape: three cases — matching port, non-matching port
(assert `error_udp_port`), non-matching port with accept-all enabled (assert
delivery).

**REQ-705 — AMBIGUOUS (should-fix, D-11, X-3).**
*Quoted*: "a test measuring the first wire octet appears **before the last
application word is accepted**".
*Why this fails a conformant design*: for a short payload the transmit path
legitimately accepts every application word within a few cycles while the wire is
still emitting preamble. The stated criterion is then false for a design that does
exactly what the requirement wants, and true only for payloads above some unstated
length.
*Reading I enforce*: the no-buffering property is better stated as invariance — the
number of application words accepted before the first wire octet is emitted SHALL be
the same for every payload length. That is testable at *every* length, including the
short ones, and it is a strictly stronger detector of a store-and-forward FIFO than
the ordering criterion.
*Spec diff*: adopt the invariance formulation here and in REQ-610. Separately, the
request **handshake** (how the fields are presented, when they must be stable, how
acceptance is signalled) is not stated anywhere in requirements.md; deferring it to
SPEC-M18/M20 is correct, but §0's sole-basis claim should acknowledge it (X-3).

**REQ-706 — TESTABLE.** Test shape: decode transmitted datagrams and assert the
checksum field is 0x0000.

**REQ-707 — TESTABLE.** Test shape: interface compile check for the absence of
`tready`, plus an end-to-end payload comparison at the application boundary with
`tuser`[0] propagation checked against an injected bad-FCS frame. Inherits X-10 for
zero-length payloads.

**REQ-708 — AMBIGUOUS (should-fix, D-2).**
*Quoted*: "SHALL deliver **minimum-size UDP datagrams** arriving at the REQ-004 rate".
*The ambiguity*: minimum-size meaning a minimum-length Ethernet frame, or meaning UDP
length 8? These are different stimuli and only the first is what REQ-004 is about.
*Reading I enforce*: minimum-length (64-octet) Ethernet frames each carrying an
IPv4/UDP datagram with IPv4 total length 46 and 18 octets of UDP payload — which is
the largest UDP payload that fits a minimum frame with no Ethernet padding, and
leaves room for the 4-octet sequence number REQ-020 needs.
*Spec diff (D-2)*: state that stimulus explicitly. It is the single most-executed
stimulus in Phase 1 and should not be left to inference.

**REQ-709 — AMBIGUOUS (blocking, D-15).**
*Quoted*: "If the application delivers **fewer or more** payload octets than it
declared, the transmit path SHALL terminate the frame **per REQ-206**".
*Why "more" cannot work that way*: by the time the excess arrives, the transmitter
has already emitted the declared octets, appended the FCS and sent the terminate
character. There is no frame left to terminate with an error character; the frame on
the wire is complete and well-formed. REQ-206's remedy applies only to the
under-delivery case.
*Reading I enforce*: under-delivery invokes REQ-206 (error character, terminate,
`error_underflow`) plus `error_tx_length_mismatch`; over-delivery completes the frame
normally, discards the excess words, and pulses `error_tx_length_mismatch` only.
*Spec diff (D-15)*: split the requirement into the two cases and state each
explicitly, including whether `error_underflow` also pulses in the under-delivery
case (X-5).

### Block 8 summary

Five of nine clean. UDP is a short block carrying two of the programme's most
important interface promises, and both are stated in ways that a literal bench would
get wrong. REQ-705 tries to test "no buffering" with an ordering criterion that a
conformant design fails whenever the payload is short — replacing it with an
invariance criterion (the same number of application words accepted before the first
wire octet, at every length) is both a truer statement of the architectural claim in
architecture §2.7 and a stronger detector. REQ-709 prescribes a single remedy for two
error cases that are physically different: you cannot retroactively poison a frame
that has already been terminated on the wire. Beyond those, the block inherits the
zero-length-payload problem in its sharpest form — REQ-703 requires an abort bit on
the last word of a frame that has no words — and REQ-708 leaves the definition of the
programme's most-executed stimulus to inference. REQ-702 deserves specific credit as
the cleanest negative requirement in the document.

---

## 11. Block 9 — Top level and configuration (REQ-801 … REQ-809)

**REQ-801 — TESTABLE.** Test shape: interface compile check plus the REQ-017
port-list comparison against SPEC-M20 §4.1. The exact expected set only exists once
M20 freezes, which is correct ordering rather than a defect (X-3).

**REQ-802 — UNTESTABLE (blocking, D-12).**
*Missing observable*: **`receive enable` and `transmit enable` have no behavioural
requirement anywhere in the document.** Every other configuration field is given
meaning by a REQ — local MAC/IP/mask/gateway by REQ-502/504/507/508, multicast group
and enable by REQ-604, listen port and accept-all by REQ-704, TTL by REQ-608,
inter-frame gap by REQ-204 — but nothing states what happens when receive enable is
0. Does the receiver hold `tvalid` low? Discard frames silently, contradicting
REQ-008? Ignore XGMII entirely? Meanwhile REQ-802's own Verification cell demands
"one directed test per field showing an observable effect", so it commissions two
tests that cannot be written.
*Spec diff (D-12)*: either give both fields a behavioural REQ (my recommendation:
"when receive enable is 0 the receive path SHALL emit no output words and SHALL
assert no strobe; the effect takes place at the next frame boundary per REQ-803" —
which is testable and does not create a silent-discard hole because no frame is
accepted at all), or delete the fields. Also add permitted ranges and defaults for
every field: `cfg_ifg` below 12 is currently permitted by the type and prohibited by
nothing, and REQ-204's rounding behaviour for such a value is undefined.

**REQ-803 — AMBIGUOUS (should-fix).**
*Quoted*: "a change SHALL take effect no later than the next **frame boundary**".
*The ambiguity*: at the top level a receive frame and a transmit frame can be in
flight simultaneously, and an ARP exchange spans both, so "the next frame boundary"
names no single event.
*Reading I enforce*: receive and transmit paths independently — a configuration
change applies to every frame whose first word is accepted at least one cycle after
the change, on each path separately, and never to a frame already in flight on that
path.
*Spec diff*: state that.

**REQ-804 — TESTABLE.** Test shape: for each of the twenty distinct strobe names in
this document, drive its condition at the top level and assert exactly that status
field pulses for exactly one cycle. I enumerated the set while reviewing —
`error_bad_fcs`, `error_bad_frame`, `error_runt`, `error_oversize`,
`error_underflow`, `error_short_frame`, `error_unknown_ethertype`,
`error_arp_unsupported`, `error_arp_miss`, `error_arp_reply_dropped`,
`error_ip_bad_header`, `error_ip_bad_checksum`, `error_ip_fragment`,
`error_ip_not_for_us`, `error_ip_truncated`, `error_ip_bad_protocol`,
`error_ip_oversize`, `error_udp_bad_length`, `error_udp_port`,
`error_tx_length_mismatch` — twenty names for twenty-one conditions, since
`error_bad_frame` serves both REQ-105 and REQ-110. **Should-fix**: add that table to
the document as a normative appendix (name, condition, owning REQ, owning module).
It makes REQ-008 and REQ-804 enumerable, gives the status record its field list, and
gives the traceability matrix something to check against. One strobe in the set is
currently unreachable — `error_arp_reply_dropped`, see REQ-510.

**REQ-805 — TESTABLE.** Test shape: interface compile check that the application
receive stream carries no `tready`. The second sentence places an obligation on the
Phase-2 consumer and has no Phase-1 observable; that is correctly acknowledged in the
Verification cell rather than pretended away.

**REQ-806 — TESTABLE.** Test shape: a process check — the number produced by the
REQ-006 bench appears, in cycles and nanoseconds, in the `nic_top` freeze record and
in the Phase-1 report. Note the split of duties: I produce the number and commit it
under `docs/reports/latency/`; the architect transcribes it into the freeze record.

**REQ-807 — TESTABLE.** Test shape: system-level test injecting an ARP request for
the configured local IP on XGMII and decoding the reply from the XGMII output,
validating preamble, every ARP field, FCS and inter-frame gap.

**REQ-808 — AMBIGUOUS (should-fix).**
*Quoted*: "**Every** module named in the architecture inventory SHALL appear as a
distinct module in the emitted Verilog."
*Why a literal check fails a conformant design*: M01 `Axi64` is a types-only module
and architecture §6.3 says explicitly that it "appears in every port record rather
than in the instance hierarchy" — it will never appear in the emitted Verilog. A
check written from this row fails on correct output.
*Reading I enforce*: every inventory module whose role is not types-only.
*Spec diff*: add that qualification, or exclude M01 by name.

**REQ-809 — TESTABLE.** Test shape: system-level test in both directions — a UDP
datagram to the configured local IP and listen port appears as payload octets on the
application stream; an application transmit request appears on XGMII as a well-formed
Ethernet/IPv4/UDP frame with a valid FCS. The transmit direction must prime the ARP
cache first (REQ-503) or REQ-505 discards it, which is derivable from the block.

### Block 9 summary

Six of nine clean, one untestable. The top-level block does its main job well: it
closes the port list (REQ-801/017), aggregates every strobe into an observable status
record (REQ-804), and states the two end-to-end behaviours that make Phase 1 mean
anything (REQ-807, REQ-809). The one hard failure is REQ-802, and it is a
specification-completeness failure rather than a wording one — two of the twelve
configuration fields exist in the record and nowhere else in the document, while the
row's own Verification cell promises a directed test per field. That is the clearest
instance in the whole review of a Verification cell commissioning work that the
Requirement cell has not made possible, and it is why I treat defective Verification
cells as spec diffs rather than as something I can quietly route around: had I done
so, `traceability.md` would have shown REQ-802 `COVERED` with ten of twelve fields
tested and no record anywhere that two were untestable. REQ-804's strobe enumeration
is worth extracting into a normative table for the same reason — the enumeration
currently exists only as a property of the prose, and I had to reconstruct it by hand
to know what the status record contains.

---

## 12. Block 10 — Verification and process (REQ-901 … REQ-906)

**REQ-901 — AMBIGUOUS (blocking, D-16).** This one is aimed directly at me, and I
cannot execute it as written.
*Quoted*: "Phase-1 MAC, IPv4 and UDP paths SHALL be **differentially co-simulated**
against alexforencich/verilog-ethernet".
*Three gaps*: (a) **comparison granularity** is unstated. A cycle-by-cycle port
comparison will diverge immediately — the reference's internal pipelining is its own
and our latency constants are pinned independently — so the only meaningful comparison
is transactional: for the same stimulus, the same sequence of output frames (octets,
`tkeep` extents, abort bits) and the same discard decisions. That has to be written
down before anyone can call a divergence a bug. (b) The **module pairing** lives in
architecture §4's counterpart column, not here (X-3). (c) The **divergence classes**
are under-declared: the row names only REQ-602 (IPv4 checksum verification), but
architecture §2.5 and §5 create at least three more by design — the direct-mapped ARP
cache versus the reference's LRU (REQ-504), discard-on-miss versus the reference's
handling (REQ-505), and the zero UDP transmit checksum (REQ-706) — plus the merged
wrapper levels, which change where a comparison can even be taken.
*Reading I enforce*: transactional comparison at the module boundaries architecture §4
pairs, with the four divergence classes above declared in advance.
*Spec diff (D-16)*: state the comparison granularity, cross-reference the pairing
table, and enumerate the known divergence classes rather than leaving them to be
discovered as failures. Tooling consequence in §13.4.

**REQ-902 — TESTABLE.** Test shape: already implemented as the `build` workflow's
determinism step — regenerate the snapshots and assert byte-identical output. Not my
scope to run, but the observable is real and the evidence form satisfies REQ-906.

**REQ-903 — TESTABLE.** Test shape: mechanical check that each inventory module has
an `.mli` and a `hierarchical` entry point taking a `Scope.t`. Executor per X-9.

**REQ-904 — TESTABLE.** Test shape: a script comparing the REQ id set extracted from
requirements.md against the row id set of traceability.md, asserting exact set
equality — which I would commit under `tools/` and wire into CI so currency is
continuous rather than checked once per gate. Note the counts table in
traceability.md (108, block by block) already matches requirements.md exactly; I
verified that while dispositioning.

**REQ-905 — AMBIGUOUS (blocking, X-1, D-1).**
*Quoted*: "**Every receive-path module** SHALL have its own line-rate stress bench
satisfying REQ-004."
*The gap*: the set is not enumerable from this document (X-1). Architecture §4's Path
column marks five modules R — M03, M06, M08, M14, M17 — but says nothing about whether
the structural wrappers that contain them (M05, M16, M19, M20) inherit the obligation,
and REQ-004 separately names `nic_top` explicitly, implying they do.
*Reading I enforce*: the five R-path modules plus `nic_top`, with structural wrappers
covered by their children's benches unless the wrapper introduces its own datapath
logic.
*Spec diff (D-1)*: enumerate the modules that owe a stress bench, by name, in
requirements.md. This is a gate condition; it should not require a chain of inference
across two documents.

**REQ-906 — TESTABLE.** Test shape: auditor sampling of journal Evidence sections
against the ADR-0005 rule. Worth stating plainly what this costs my side: it means no
DV verdict of mine can be evidenced by a local run, so every bench iteration is a CI
round trip and the toolchain gaps in §13.4 are on the critical path for every test in
Phase 1, not merely for co-simulation.

### Block 10 summary

Four of six clean. The process block is short, and its two failures are the two rows
that describe work I personally owe. REQ-905's obligation is stated over a set the
document does not define, so at `P1-module-ready` the question "did DV deliver every
required stress bench" currently has no checkable answer — which is precisely the
kind of ambiguity that becomes an audit finding against me rather than against the
document. REQ-901 is the more serious of the two: differential co-simulation against
verilog-ethernet is my charter's hard precondition for any Phase-1 MAC/UDP `SO-` PASS,
and the row does not say what "differential" compares, at which boundaries, or which
divergences are expected by design. Left as is, the first co-simulation run produces a
list of differences with no principled way to sort intended from defective, and the
programme's most important external anchor degrades into a judgement call. Fixing it
is mostly transcription — the pairing table and three of the four divergence classes
already exist in architecture.md §4 and §5.

---

## 13. REQ-004 / REQ-005 bench feasibility

### 13.1 Verdict

**The 10 000-frame line-rate stress is practical in Cyclesim and does not force the
Verilator lane early.** Verilator is needed for REQ-901 co-simulation and for the
Phase-2 replay, not for REQ-004. I recommend Phase 1 stress and latency work land on
Cyclesim, with `hardcaml_verilator` introduced on the co-simulation schedule rather
than the stress schedule.

### 13.2 The arithmetic behind that verdict

10 000 frames at the corrected 10.5-cycle spacing (D-3) is **105 000 cycles**, plus
pipeline drain — call it 110 000 cycles per module bench. For a single module of
`Xgmii_rx_64`'s size that is a fraction of a second of Cyclesim at any plausible
cycles-per-second figure; at `nic_top`, with all twenty modules elaborated, it is
seconds to tens of seconds. Neither is a problem for a CI job whose round trip is
already minutes (ADR-0005).

The real constraints are not cycle count:

1. **Waveform capture must be off.** `hardcaml_waveterm` recording 110 000 cycles
   across a few hundred signals is hundreds of megabytes and would dominate both
   runtime and memory. Waves belong to the short directed tests, where they are the
   readable red/green currency; the stress bench must run headless and print a
   summary.
2. **The expect block must hold a summary, not a trace.** A stress bench whose
   expected output is 10 000 frames of anything is unreviewable and unpromotable. The
   expect block holds counts and the first divergence only.
3. **Determinism.** Payload contents come from a seeded PRNG so the summary is
   byte-stable across runs and CI can promote it per ADR-0005.
4. **The OCaml-side checker, not the simulator, is the thing to watch.** Building
   10 000 frames with software CRC-32 and comparing every octet is ~640 kB of CRC work
   and ~1.3 MB of comparison — negligible, provided the scoreboard is not doing list
   appends per octet.

**Honesty about this estimate**: ADR-0005 means I cannot measure any of it locally —
no Hardcaml runs in this container. Every number above is an engineering estimate, and
the first real figure will come from CI. I therefore recommend a cheap **cost probe**
before the DV plan commits: a throwaway bench that runs a trivial existing module for
110 000 cycles in CI and reports wall-clock, giving a cycles-per-second figure for this
runner. That is one small work order and it de-risks every subsequent sizing decision.
If the probe shows `nic_top` stress is unaffordable in CI, reducing the frame count is
an **E2 scope decision** with measured numbers attached (charter §7) — not something I
narrow quietly.

### 13.3 Bench architecture I intend

**Layer 1 — the XGMII link-partner model** (`test/xgmii/`, spec-derived from
REQ-101/102/106/109/113 and architecture §3's stub contract; no RTL consulted). Two
independent halves:

- An *encoder* that takes a frame as an octet list, a start-lane selector, and an
  optional injection directive (bad FCS, `/E/` at lane k of word n, terminate replaced
  by a start character, oversize, runt), and produces the `(xgmii_rxd, xgmii_rxc)`
  word pairs including preamble, FCS, terminate and idle fill. It owns the **arrival
  scheduler**: emit frame i with a lane-0 start and frame i+1 with a lane-4 start,
  computing the idle count so that start-to-start alternates 10 and 11 cycles. That
  alternation is the whole point of REQ-004 and it is exactly what D-3 must settle
  before the scheduler can be written correctly.
- A *decoder* that turns `(xgmii_txd, xgmii_txc)` back into frames plus the observed
  preamble, terminate placement and inter-frame gap facts, serving REQ-201–205,
  REQ-807 and REQ-809.

Both halves are pure OCaml, DUT-independent, and are the same code the co-simulation
harness will drive against the reference — which is what makes REQ-901 an exercise in
swapping the DUT rather than writing a second bench.

**Layer 2 — the software golden reference** (`test/golden/`, my scope, deliberately
outside data_wrangler's `tools/**`). Bit-serial and table-driven CRC-32 anchored on
REQ-303/305 *before* it judges anything; Ethernet/IPv4/UDP header builders and
parsers; and a frame factory that turns a declarative frame description into the
triple (wire octets, expected application payload, expected strobe set). Directed
tests and the stress bench consume the same factory, so a stimulus bug shows up in
both rather than in neither.

**Layer 3 — the scoreboard.** A FIFO of expected frames pushed at injection and popped
at each output `tlast`, plus a per-cycle protocol monitor (REQ-011/013/014 checks and
the REQ-015 residue of D-8), plus a **per-octet latency tagger**. The tagger is the
piece that matters: tag every input octet with the cycle it entered and every output
octet with the cycle it left; the latency of octet n is the difference. REQ-005 and
REQ-111 pass iff that difference is identical for all n. This has three consequences
worth stating:

- It is the only formulation that survives realignment and both start lanes (X-6), and
  it is what D-4 asks the architect to adopt.
- **REQ-005's evidence becomes a by-product of the REQ-004 stress run rather than a
  separate six-frame bench** — so the constant-latency claim gets 10 000 frames of
  evidence instead of six, at no extra cost.
- The same scoreboard yields the frame-conservation counts that D-6 needs to make
  REQ-008's silent-discard prohibition enforceable. One structure discharges three
  invariants.

**Layer 4 — the drivers.** Directed, packet-level tests use
`hardcaml_step_testbench` (charter §9), where a test reads as a coroutine that sends a
frame and awaits a response. The stress bench bypasses that and drives `Cyclesim`
directly in a tight loop for speed, with waves off. Both sit behind the same scoreboard
and the same golden model.

**Layer 5 — reporting.** The stress bench's expect block prints: frames in, frames
out, octets compared, the per-octet latency (single value if constant, otherwise the
histogram and the first offender), the strobe histogram, the conservation residual, and
the first divergence as (frame index, octet index, expected, observed). Under a hundred
bytes when green, and immediately diagnosable when red.

### 13.4 Tooling the orchestrator needs to size

Checked against `agentic_fpga.opam` at 81acc2c:

| Need | Status today | Consequence |
|---|---|---|
| `hardcaml`, `hardcaml_axi`, `hardcaml_waveterm`, `ppx_expect` | present | fine |
| `hardcaml_step_testbench` | **absent** | every packet-level directed bench in my plan needs it; it is the framework my charter §9 names |
| `hardcaml_verilator` | **absent** | needed for REQ-901 co-simulation and Phase-2 replay, **not** for REQ-004 |
| `verilator` system binary in the CI image | **absent** | prerequisite for the above; an apt step in `build.yml` |
| A Verilog simulator for the reference design | **absent** | REQ-901 must run alexforencich's Verilog; Verilator covers it |

Two requests, in priority order: (1) add `hardcaml_step_testbench` now, since it gates
the first per-module benches; (2) schedule `hardcaml_verilator` plus the `verilator`
binary against REQ-901, which is a Phase-1 sign-off precondition but not a Phase-1
*first-bench* precondition. Both are subject to the same opam-availability reality
ADR-0005 documents, so both should be proven by a CI run before anything depends on
them.

### 13.5 Reproducing the CRC findings in §6

```
python3 - <<'EOF'
import zlib, struct
print("%08X" % (zlib.crc32(b"123456789") & 0xFFFFFFFF))          # CBF43926, not CBF43F26
m = bytes(range(60)); c = zlib.crc32(m) & 0xFFFFFFFF
print("%08X" % (zlib.crc32(m + struct.pack("<I", c)) & 0xFFFFFFFF))  # 2144DF1C, not C704DD7B
print("%08X" % int('{:032b}'.format(0x2144DF1C ^ 0xFFFFFFFF)[::-1], 2))  # C704DD7B
EOF
```

`zlib.crc32` is exactly REQ-301's parameterisation (poly 0x04C11DB7, init 0xFFFFFFFF,
reflected in and out, final XOR 0xFFFFFFFF). Observed with Python 3.11.15. The residue
is 0x2144DF1C for every message length tried (9, 46, 60 octets) when the FCS is
appended least-significant-octet-first, and varies per message otherwise — which is
what pins the wire octet order in the REQ-202 finding. The third line shows that
REQ-304's 0xC704DD7B is the same residue in the non-reflected register convention.

---

## 14. Overall verdict

### 14.1 Counts

| Disposition | Count |
|---|---|
| TESTABLE | **55** |
| AMBIGUOUS | **49** |
| UNTESTABLE | **4** |
| **Total** | **108** |

By block: invariants 6/13/2 · XGMII rx 4/9/0 · XGMII tx 6/4/0 · CRC 4/2/0 ·
Ethernet 5/5/0 · ARP 6/5/1 · IPv4 9/3/0 · UDP 5/4/0 · top level 6/2/1 ·
process 4/2/0 (TESTABLE/AMBIGUOUS/UNTESTABLE).

Thirty of the fifty-three non-TESTABLE rows are **blocking**; they consolidate into the
sixteen spec diffs below, because most share a root cause.

### 14.2 Can requirements.md as written anchor the P1-spec-freeze countersignature?

**Not yet — but it is close, and the gap is smaller than the counts suggest.**

The honest assessment: this is a good requirements document. Fifty-five rows I would
hand to a worker unchanged; a further nineteen need only the reading written down.
Its structure is right in the ways that matter most — one testable fact per REQ,
permanent ids, normative strobe names, explicit non-requirements in §11, and
Verification cells that in the best cases (REQ-608, REQ-609, REQ-702, REQ-506) name
independent oracles and parameter overrides rather than gesturing at "test it". Nothing
here needs rewriting.

What it cannot yet anchor is a *signature*, for three reasons:

1. **Two constants are wrong** (REQ-303, REQ-304). A signature saying "these
   requirements can anchor tests" would be false the moment the FCS bench runs, and
   the failure would be misattributed to RTL.
2. **Three definitions the whole document quantifies over are missing** — what "receive
   path" means (X-1), what a stated frame length includes (X-2), and where latency is
   measured (X-6) — plus a fourth convention collision (D-3) that silently changes the
   line-rate invariant by ten percent. These are not clarity issues; they change what
   the benches do.
3. **Four rows commission work that cannot be done** — REQ-019 (no DV observable),
   REQ-510 (strobe unreachable), REQ-802 (two fields with no behaviour), REQ-901 (no
   comparison definition). Signing testability over them would put `COVERED` in the
   traceability matrix for things nothing covers.

I would sign a post-diff revision. None of the sixteen diffs is a redesign; the
majority are one sentence, and several are transcriptions of material that already
exists in `architecture.md`.

### 14.3 Must become spec diffs before I countersign

| id | Diff | REQs affected |
|---|---|---|
| **D-1** | Define "receive path" normatively in §0 (modules and streams), and enumerate by name the modules owing a stress bench | 003, 004, 005, 019, 905 |
| **D-2** | State the frame-length convention (DA through FCS) in §0; fix REQ-408's 50 → 46 and REQ-605's padding example; extend the length sets to 64–71 + 1518 so all eight `tlast` `tkeep` patterns are covered; state REQ-708's stimulus exactly | 005, 103, 107, 108, 408, 605, 708 |
| **D-3** | State the inter-frame-gap convention once: measured from the terminate character **inclusive**, minimum 12 octets; restate REQ-204 accordingly. Without this the line-rate stress runs ~10 % slow forever | §0, 004, 204 |
| **D-4** | Define latency per **octet** (input word carrying octet n → output word carrying octet n); apply to REQ-005/111/210/611; drop REQ-111's unsatisfiable "independent of start lane" under the old reading; import architecture §4's per-module ceilings so REQ-019 gains an observable | 005, 006, 019, 101, 111, 210, 611 |
| **D-5** | State abort-versus-discard precedence and strobe multiplicity; restate REQ-013's "discard it" as advisory; add a strobe timing window (X-7) | 007, 013, 403, all ERR rows |
| **D-6** | Add the frame-conservation monitor to REQ-008 so silent discards are detectable, and restate REQ-020's "no gaps" in terms of it | 008, 020 |
| **D-7** | Resolve the zero-length-payload encoding (X-10) and fix the cases that depend on it | 011, 401, 402, 605, 703, 707 |
| **D-8** | State what `clear` mid-frame does to an in-flight output frame, and exempt REQ-015's monitor accordingly | 009, 015 |
| **D-9** | XGMII boundary cases: control character in a preamble lane (102 vs 105); truncation boundary for `/E/` and for an early start character (105, 110); frames below 5 octets (107); oversize truncation length (108) | 102, 105, 107, 108, 110 |
| **D-10** | Fix the CRC constants: REQ-303 → 0xCBF43926; REQ-304 → 0x2144DF1C (or restate the convention); state the FCS wire octet order in REQ-202 | 202, 303, 304 |
| **D-11** | Define the application's "payload length" field once and restate REQ-610's arithmetic in terms of it (currently an 8-octet wire-format ambiguity) | 610, 705 |
| **D-12** | Give `receive enable` and `transmit enable` a behavioural REQ or delete them; add ranges and defaults for every configuration field | 802, 204 |
| **D-13** | Resolve REQ-206 versus REQ-016: scope idle tolerance to receive-path/internal streams and define the transmit underflow threshold | 016, 206 |
| **D-14** | ARP completeness: reply target fields (502); payload draining on a cache miss (505); a reachable drop condition for `error_arp_reply_dropped` (510) | 502, 505, 507, 510 |
| **D-15** | Split REQ-709 into under-delivery and over-delivery; REQ-206's remedy cannot apply to a frame already terminated on the wire | 709 |
| **D-16** | REQ-901: state the comparison granularity (transactional, at the architecture §4 pairing boundaries) and enumerate all four known divergence classes, not only REQ-602 | 901 |

### 14.4 Recommended but not blocking

Highest value first: add a **normative strobe appendix** (name, condition, owning REQ,
owning module) — it makes REQ-008 and REQ-804 enumerable and gives the status record
its field list (§11 REQ-804); qualify all `tkeep` obligations by `tvalid` = 1 (REQ-011);
add MAC and IPv4 examples to REQ-012's byte-order rule (REQ-012, REQ-409); replace
REQ-018's vendor-primitive blacklist with an instantiation whitelist and add PTP to its
text; restate REQ-010's compile check as a type-identity witness; qualify REQ-109 by
pipeline drain and REQ-210 by transmitter idle; exclude types-only modules from REQ-808;
name an independent CRC oracle in REQ-202; adopt the invariance formulation of
"no buffering" in REQ-705; correct §0's sole-basis claim (X-3); state the ARP address
class precedence (REQ-507) and REQ-506's defaults; give REQ-501 an operation-field and
minimum-length check; and record the DV link-partner contract as a citable REQ (X-8).

### 14.5 Open questions for the orchestrator

1. **X-9 — who runs the emitted-Verilog inspections?** Six REQs are verified by
   inspecting `rtl_snapshots/` or `libs/`. I am willing to own them as scripts under
   `tools/` run in CI, on the position that reading a *build product* is not deriving a
   test from RTL — but that should be a ratified decision, not my unilateral reading,
   because the auditor samples my Inputs sections for exactly this.
2. **Toolchain (§13.4)** — `hardcaml_step_testbench` now; `hardcaml_verilator` plus the
   `verilator` binary on the REQ-901 schedule.
3. **Cost probe (§13.2)** — one throwaway CI bench to measure Cyclesim cycles-per-second
   on this runner, before the DV plan commits to 10 000-frame stress at `nic_top`.
4. **Sequencing** — D-1 through D-4 and D-10 change what benches *do*, not merely what
   they are called. I would rather they land before Batch B specs (M03/M04) are written
   than as a later correction, since M03 is the module they most affect.

---

*Signed: dv_lead, journal `J-dv_lead-0001`. This is a testability review of
specification text only. No RTL was read, no test code was written, and no golden model
exists yet; the CRC constants in §6 and §13.5 were checked against an independent
implementation (Python `zlib`), which is a specification-arithmetic check, not a design
verification result.*
