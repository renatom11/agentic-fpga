# Journal: claude_dv_lead_agent

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.

---

## [J-dv_lead-0001] 2026-08-02T00:28:00Z | task:WO-0003 | Testability review of the 108 Phase-1 REQs: 55 TESTABLE, 49 AMBIGUOUS, 4 UNTESTABLE; countersignature withheld pending 16 spec diffs

### Trigger
Orchestrator spawn under work order WO-0003 (ISSUED at 02e38e7), spawn short-id
`WO-0003/2026-08-02T00:25Z`. First activation of the verification function. The
architect proposed and the orchestrator accepted that this review land *before*
the `P1-spec-freeze` checklist opens, so my objections arrive as spec diffs
rather than as gate blockers. This entry records the review that is supposed to
make my later freeze countersignature (charter §3, PROTOCOL §7) an honest
signature rather than a ceremonial one.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (whole, working from §4
  grammar, §6 scopes, §7 gates, §10 independence).
- `agents/handoffs/WO-0003_requirements-testability-review.md` (at 02e38e7);
  `agents/handoffs/README.md` (packet forms).
- **Review target: `docs/specs/requirements.md` at 08899d3.** Verified unchanged
  between 08899d3 and HEAD 81acc2c before reviewing it (command in Evidence).
- Context at 08899d3: `docs/specs/architecture.md`, `docs/specs/SPEC-TEMPLATE.md`,
  `docs/specs/traceability.md`.
- `docs/adr/ADR-0004-toolchain-lane.md`, `docs/adr/ADR-0005-build-environment.md`,
  `README.md`, `ORG_CHART.md`.
- For the feasibility note only: `agentic_fpga.opam`, `dune-project`,
  `test/hardcaml_ethernet/dune`, the `.github/workflows/` file listing.
- **No RTL was read.** `libs/**` was never opened and `rtl_snapshots/**` was never
  opened. Independence discipline per PROTOCOL §10 and charter §8: every
  disposition below derives from specification text alone.

### Reasoning
The unit of work was a judgement call repeated 108 times, so what matters here is
the standard I applied and the standards I rejected.

**The reader I reviewed for.** I did not ask "is this row clear to someone who has
read all 108 rows and both companion documents". I asked "can a tb_writer who
receives *this excerpt and nothing else*, and who is deliberately denied RTL
(PROTOCOL §10), build the right bench". That is a stricter test and it is the one
that matches how the work will actually be delegated. It is what produced four of
the ten cross-cutting findings: "receive path" is quantified over but never
defined (X-1), the frame-length convention is never stated (X-2), §0's claim to be
the *sole* test-derivation basis is false because latency constants and module
pairings live elsewhere (X-3), and latency measurement points are named nowhere
(X-6). None of those would have surfaced from a whole-document read.

**A defective Verification cell is a spec diff, not something to route around.**
This was the central methodological decision and it drives roughly a third of the
findings. The alternative I rejected was tempting and cheaper: where the stated
method is wrong, simply build the bench I know is right and leave the document
alone. I rejected it because `traceability.md` binds each REQ to the tests
covering it and the auditor checks my tests against the Verification column — so
silently substituting my own method makes either the matrix or my signature
false, and does it invisibly. REQ-802 is the proof case: its cell commissions "one
directed test per field", two of its twelve fields have no behavioural
requirement anywhere in the document, and had I routed around that, the matrix
would have read `COVERED` with no record anywhere that two fields were untestable.
The same logic applies to methods that cannot detect their own violation
(REQ-008's silent-discard prohibition tested only via declared strobes, REQ-019's
constant-latency evidence which a constant-but-deep buffer passes, REQ-004's
"no backpressure asserted" which cannot fail when no `tready` exists, REQ-015's
monitor watching a tautology). The WO asked for exactly this class and I treated
it as first-class rather than as commentary.

**Severity ladder.** I graded each finding blocking / should-fix / editorial.
Rejected: calling every divergence blocking — thirty of fifty-three non-TESTABLE
rows are blocking as it is, and inflating that would have made the must-fix list
unusable and dishonest about relative cost. Also rejected: only flagging things
that would break a conformant design — that would have let the unfalsifiable
methods through, which is precisely the failure mode the countersignature exists
to prevent. The line I settled on: blocking iff I cannot determine pass/fail for a
conformant design, or the REQ has no DV observable, or the method provably cannot
detect the violation it prohibits.

**Consolidation.** Thirty blocking rows became sixteen spec diffs, because most
share a root cause. That was deliberate: the architect has to *apply* these, and
sixteen grouped diffs with affected-REQ lists is actionable where thirty bullets
is a backlog.

**Checking arithmetic instead of trusting it.** I chose to actually compute the
two CRC constants against an independent implementation rather than accept them.
Both are wrong: REQ-303's check value is 0xCBF43F26 where CRC-32/ISO-HDLC gives
0xCBF43926, and REQ-304's residue is stated as 0xC704DD7B where REQ-301's own
parameterisation (reflected in and out, final XOR) yields 0x2144DF1C —
0xC704DD7B being the same residue in the non-reflected register convention. The
second is the instructive one: it is a real, widely published Ethernet constant,
so it survives any amount of careful reading; only computation catches it. Both
would have been hard-coded into the FCS bench, both would have failed against
correct RTL, and both would have produced a CRITICAL `BUG-` against rtl_lead for
a defect living in the specification. I am adopting this as standing practice for
every numeric constant in the per-module specs.

**Walking the line-rate arithmetic instead of accepting it.** Same reasoning
applied to §0's claim that a minimum frame occupies 84 octets and arrives every
10.5 cycles. Walking the XGMII lanes cycle by cycle reproduces the 10/11
alternation *only* if the terminate character is counted inside the 12-octet
inter-frame gap — but REQ-204 requires 12 *idle* octets after the terminate
character, the opposite convention, under which the minimum spacing becomes 11
and 11. REQ-204's own expected answer (88 octets start-to-start) is insensitive to
the difference because of lane-0 rounding, which is exactly why it hides. Left
unfixed, every line-rate stress bench in Phase 1 would have under-driven every
receive-path module by about ten percent while reporting green forever. This is
D-3 and it is the finding I would have most regretted missing.

**The latency definition (D-4).** REQ-005 asks for "the delay from a word entering
a module to that word leaving it", which names no event at a realigning module
because one input word's octets appear in two output words; and REQ-111 demands a
constant "independent of start lane", which no design can satisfy, since a lane-4
start needs one more input word before the first output word can be assembled. I
considered keeping a per-word measurement with a start-lane exemption and rejected
it: it leaves REQ-019 with no observable at all. The per-octet formulation I
propose instead is well-defined across realignment and both start lanes, gives
REQ-019 a real ceiling test once architecture §4's allocation table is imported,
and — the reason I like it most — makes REQ-005's evidence a by-product of the
REQ-004 stress run, so the constant-latency claim gets ten thousand frames of
evidence instead of six, at no extra cost. One scoreboard then discharges REQ-004,
REQ-005/111 and (with D-6's conservation counts) REQ-008.

**Feasibility.** I concluded Cyclesim carries the 10 000-frame stress comfortably
(~110 000 cycles per bench) and refused to force the Verilator lane early. The
rejected option was adopting `hardcaml_verilator` now "to be safe": it front-loads
a CI system-binary dependency onto the first bench when it actually belongs to
REQ-901 co-simulation and the Phase-2 replay. The real constraints are waveform
capture (must be off at this cycle count) and expect-block content (summary, not
trace), not simulator throughput. Because ADR-0005 means I cannot measure anything
locally, I labelled the figures as estimates and proposed a cheap CI cost probe as
their falsification point rather than presenting them as measurements.

**What I deliberately did not raise.** Several rows where the correct reading is
not genuinely in dispute — REQ-014's `tstrb` differential, REQ-016's idle-cycle
counts, REQ-509's multicast example, REQ-406's tie-breaking — I recorded as
editorial or as coverage notes for my own attack plans rather than as spec diffs.
Keeping the must-fix list to things that actually block is what makes it worth
acting on. Likewise I did not edit `docs/specs/**`: it is outside my write scope
(PROTOCOL §6) and R7 would reject the commit, which is the correct outcome —
findings are requests to the architect, not edits by the adversary.

### Actions
- Dispositioned every one of the 108 REQs individually, no sampling, grouped by
  the ten blocks, with a one-paragraph summary per block.
- Wrote `agents/handoffs/WO-0003_testability-findings.md`: ten cross-cutting
  findings (X-1 … X-10), ten per-block sections, the REQ-004/REQ-005 bench
  feasibility section (verdict, arithmetic, five-layer bench architecture,
  toolchain gaps), and the verdict with sixteen must-fix spec diffs (D-1 … D-16)
  plus a non-blocking recommendation list.
- Verified the two CRC constants against an independent implementation.
- Walked the REQ-004 XGMII arrival pattern lane by lane to check the 10.5-cycle
  claim against REQ-204's stated gap convention.
- Cross-checked the deliverable's REQ id set against `requirements.md` and
  recomputed the per-block disposition counts mechanically.
- Appended the RETURNED entry to WO-0003's Return log.
- Wrote nothing under `test/`, `tools/`, `libs/`, `docs/specs/` or `docs/gates/`.

### Evidence
All commands runnable from a repo checkout at this SHA (PROTOCOL §4.1 form (a)).

1. Review target unchanged before review —
   `git diff --stat 08899d3 HEAD -- docs/specs/requirements.md` → no output
   (empty diff); `git log --oneline -1 -- docs/specs/requirements.md` →
   `08899d3 WO-0002: Phase-1 requirements (108 REQs), architecture, spec template, traceability`.

2. Full coverage, no sampling —
   `grep -cE '^\*\*REQ-[0-9]+ — ' agents/handoffs/WO-0003_testability-findings.md`
   → `108`; and the id sets are identical:
   `diff <(grep -oE '^\| \*\*REQ-[0-9]+\*\*' docs/specs/requirements.md | grep -oE 'REQ-[0-9]+' | sort -u) <(grep -oE '^\*\*REQ-[0-9]+' agents/handoffs/WO-0003_testability-findings.md | sed 's/^\*\*//' | sort -u)`
   → no output.

3. Disposition counts —
   `grep -oE '^\*\*REQ-[0-9]+ — (TESTABLE|AMBIGUOUS|UNTESTABLE)' agents/handoffs/WO-0003_testability-findings.md | awk '{print $3}' | sort | uniq -c`
   → `49 AMBIGUOUS`, `55 TESTABLE`, `4 UNTESTABLE` (total 108). Blocking rows:
   `grep -cE '^\*\*REQ-[0-9]+ — .*\(blocking' …` → `30`. Per-block counts
   (T/A/U): invariants 6/13/2, XGMII rx 4/9/0, XGMII tx 6/4/0, CRC 4/2/0,
   Ethernet 5/5/0, ARP 6/5/1, IPv4 9/3/0, UDP 5/4/0, top level 6/2/1, process
   4/2/0 — block totals 21/13/10/6/10/12/12/9/9/6, matching `traceability.md`'s
   counts table exactly.

4. CRC constant defects (Python 3.11.15, `zlib.crc32` is exactly REQ-301's
   parameterisation) —
   ```
   python3 - <<'EOF'
   import zlib, struct
   print("%08X" % (zlib.crc32(b"123456789") & 0xFFFFFFFF))
   m = bytes(range(60)); c = zlib.crc32(m) & 0xFFFFFFFF
   print("%08X" % (zlib.crc32(m + struct.pack("<I", c)) & 0xFFFFFFFF))
   print("%08X" % int('{:032b}'.format(0x2144DF1C ^ 0xFFFFFFFF)[::-1], 2))
   EOF
   ```
   → `CBF43926` (REQ-303 states `CBF43F26`), `2144DF1C` (REQ-304 states
   `C704DD7B`), `C704DD7B` (showing REQ-304's constant is the same residue in the
   non-reflected register convention). The residue was `2144DF1C` for every
   message length tried (9, 46, 60 octets) with the FCS appended
   least-significant-octet-first, and varied per message otherwise — which is what
   pins the FCS wire octet order in the REQ-202 finding.

5. **No build or test evidence is claimed.** ADR-0005 makes CI the authoritative
   build environment and no Hardcaml toolchain is installable in this container;
   this unit of work compiled nothing and ran no bench. The §13 feasibility
   figures are explicitly labelled engineering estimates in the deliverable, with
   a proposed CI cost probe named as their falsification point.

### Outcome
DoD of WO-0003 met. All 108 REQs dispositioned with no sampling; every AMBIGUOUS
and UNTESTABLE finding carries the quoted wording, the reading I would enforce,
and a concrete spec-diff request the architect can apply without asking me
anything; the REQ-004/REQ-005 feasibility note is delivered with the bench
architecture in prose and the toolchain gaps named; no RTL, no test code and no
golden model were written; nothing was touched outside `agents/handoffs/**` and
this journal. Handoff: `agents/handoffs/WO-0003_testability-findings.md`, with
WO-0003's Return log moved to RETURNED. **Verdict: testability countersignature
withheld pending sixteen spec diffs (D-1 … D-16); I would sign a post-diff
revision.** Fifty-five rows I would hand to a worker unchanged today.

### Open-questions
1. **X-9 — executor of the emitted-Verilog inspections.** Six REQs (001, 017, 018,
   306, 808, 903) are verified by inspecting `rtl_snapshots/` or `libs/`. My
   position is that reading a *build product* to check a port list is not deriving
   a test from RTL, and I will own these as scripts under `tools/` run in CI — but
   that should be a ratified decision, not my unilateral reading, since the auditor
   samples my Inputs sections for exactly this.
2. **Toolchain**: `hardcaml_step_testbench` is absent from `agentic_fpga.opam` and
   gates the first per-module benches; `hardcaml_verilator` plus a `verilator`
   binary in the CI image are needed for REQ-901 but not before it.
3. **Cost probe**: one throwaway CI bench measuring Cyclesim cycles-per-second on
   this runner, before the DV plan commits to 10 000-frame stress at `nic_top`.
   If it comes back badly, reducing the frame count is an E2 with numbers
   attached, not a silent narrowing.
4. **Sequencing**: D-1 … D-4 and D-10 change what benches *do*. They should land
   before Batch B (M03/M04) specs are written, since M03 is the module they most
   affect.
5. **Re-review**: my countersignature must be against the post-diff text. I expect
   a short follow-up work order to re-check the sixteen diffs before the
   `P1-spec-freeze` checklist opens; flagging it so it is scheduled rather than
   assumed.

### Files-in-this-commit
- agents/handoffs/WO-0003_testability-findings.md
- agents/handoffs/WO-0003_requirements-testability-review.md

## [J-dv_lead-0002] 2026-08-02T03:20:00Z | task:WO-0005 | Re-review of the sixteen applied spec diffs at b4b4cf4: all sixteen CLOSED, D-4 deviation adopted against my own formulation, P1-spec-freeze testability countersignature SIGNED

### Trigger
Orchestrator spawn under work order WO-0005 (ISSUED at 8259699), spawn short-id
`WO-0005/2026-08-02T02:55Z`. Second activation. WO-0003 ended with my
countersignature withheld pending sixteen spec diffs; the architect applied them
under WO-0004 and the orchestrator accepted at b4b4cf4. This entry records the
narrow re-review that turns that withheld signature into a decision — sixteen
dispositions, three named judgments, sign or withhold. My own open question 5 in
`J-dv_lead-0001` asked for exactly this work order, so the loop closes where I
asked it to.

### Inputs
- `agents/charters/dv_lead.md` (refresh); `agents/PROTOCOL.md` §4 (entry
  grammar), §6 (scopes), §7 (gates and signature transcription), §10.
- `agents/handoffs/WO-0005_spec-diff-re-review.md` (my work order).
- `agents/handoffs/WO-0003_testability-findings.md` at 9a6195a — my own review,
  re-read in full, in particular §2 (X-1 … X-10), §3–§12 (the per-REQ readings I
  said I would enforce), §13.3 (bench architecture) and §14.3 (D-1 … D-16).
- `agents/handoffs/WO-0004_requirements-spec-diffs.md` — the architect's Return
  log (per-diff disposition table, the D-3 defence, the four UNTESTABLE rows,
  the "beyond the sixteen" list) and the orchestrator's ACCEPTED entry with
  rulings 1–4.
- `docs/specs/requirements.md` at b4b4cf4 — read whole, all 110 rows plus the
  new normative §0.1 … §0.7, §1.1, §9.1 and §12.
- `docs/specs/architecture.md` at b4b4cf4 — §1 (scope parameters and the IFG
  convention), §4 (module inventory, Path column, latency allocation table).
- `docs/specs/SPEC-TEMPLATE.md` at b4b4cf4 — §3, §7, §8, §9.
- `docs/specs/traceability.md` at b4b4cf4 — counts, matrix rows, open
  dependencies (in particular item 4, REQ-019's declared partial coverage).
- No RTL. No `libs/` file was opened; `rtl_snapshots/` was not read. This unit
  of work is specification text only, as WO-0003 was.

### Reasoning
The question this work order asks is not "is the document better" — it is "is
the post-diff text one I can honestly countersign", and the charter makes that
signature a merge-blocking artefact rather than a courtesy. So I re-derived
rather than re-read: for every diff whose fix is arithmetic or timing, I
recomputed the number before accepting it, and for the three items the WO named
I redid the underlying walk from the spec text.

**The D-4 deviation. I adopted it and refuted my own formulation, because the
architect is right and I was wrong.** My WO-0003 metric was (cycle of the output
word carrying octet n) − (cycle of the input word carrying octet n). Under a
lane-4 start `/S/` sits at lane 4 of word N, the eight preamble octets run to
lane 3 of word N+1, frame octets 0–3 arrive in word N+1 and octets 4–7 in word
N+2, and all eight leave in output word 0 — so my metric takes two values inside
one frame, and a monitor built on findings §5 fails a conformant `Xgmii_rx_64`
on its first lane-4 frame. The reason the defect survived my own review is
worth recording, because it is the kind of mistake I will make again: I checked
constancy *across* the two start lanes (that was X-6, and it was right) and
never checked constancy *within* the lane-4 frame. Octet times fix it by
construction — with octet time 8·cycle + lane on XGMII and 8·cycle + byte
position on `Axi64`, a module stripping h octets has L = 8(Co − Ci) − h for
every octet at both start lanes — and the fix costs my tagger one extra field.
I considered whether to accept the intent while contesting the metric (my
original text is the one traceability will cite) and rejected that: a
formulation that fails a conformant design is exactly what I spent WO-0003
objecting to in other people's rows, and the honest record is that the
architect caught in my review the same class of defect I caught in the document.

Adopting it surfaced a unit question I do own: §1.1's ceilings are word-cycle
allocations, but §0.5 compares floor(L/8), which understates a stripping stage's
word-cycle delay by exactly ceil(h/8). I worked the consequence out rather than
guessing at it — a chain sitting on every ceiling consumes all 24 cycles of
REQ-006's budget and none of the architect's declared 7-cycle slack. That is
lenient, not false: no conformant design fails, and REQ-006's end-to-end bench
is the binding backstop. So it became carry-forward C-1 rather than a contest,
to land when the first module spec pins a constant — which is the moment the
arithmetic first matters and the cheapest moment to fix it.

**The D-1 seven-module list. Adopted; the omission was mine.** My REQ-003
reading spelled the chain M03 → M06 → M08 → {M10, M14} → M17, which contains
M10, and my REQ-905 entry then said the Path column marks five R modules,
omitting it. Architecture §4 marks M10 R. My §14.3 therefore contradicted my own
§3 and its source table, and seven is right. Checking the stimulus rather than
just the list turned up C-6: M10 emits parsed fields, not a payload octet
stream, so two of REQ-004's four pass criteria have no observable at its output.
That belongs in SPEC-M10 (SPEC-TEMPLATE §8 already commissions the statement),
not in requirements.md, so it is a carry-forward I raise rather than a diff I
demand now.

**The D-3 resolution. Confirmed by re-walking, and it corrects me twice.** The
84-octet budget with the gap counted from `/T/` inclusive reproduces starts at
(0,lane 0), (10,lane 4), (21,lane 0), … — the 10/11 alternation — and the
lane-0-only transmitter rounds to 16 octets from `/T/`, 88 start to start,
exactly 11 cycles. My "9.5 %" figure in WO-0003 mixed two comparisons and the
architect's 4.5 % average / 10 % on the tight frames is the correct statement.
More importantly, I checked the DIC argument independently instead of accepting
it, and it is stronger than the one I made: because `/T/` and the next `/S/` both
sit in lane 0 or lane 4, the gap from `/T/` inclusive is quantised to multiples
of 4, so the candidates below 12 are 4 and 8 — both under clause 46's 9-octet
floor. Twelve is therefore the smallest gap any compliant partner can present,
which makes the 10/11 alternation not a plausible worst case but *the* worst
case. That is a stronger foundation for the line-rate bench than I had.

**Sign or withhold.** Seven residuals surfaced (C-1 … C-7). The temptation is
to treat their count as a blocker; the honest test is the one I set myself in
WO-0003 §1.2 — I withhold when I cannot determine pass/fail for a conformant
design, when a REQ has no DV observable, or when a stated method cannot detect
its own violation. None of the seven meets it: each has an unambiguous fix
direction that any careful reader converges on, each is a false-failure edge or
an unstated accounting term rather than a missing observable, and each can land
in a module spec or a one-clause diff before the gate it affects. Against that,
every one of the three conditions I named in §14.2 as blocking a signature is
discharged: the two constants are fixed and their provenance recorded, the three
missing definitions plus the IFG collision are stated normatively in §0.3–§0.5,
and the four rows that commissioned impossible work are testable. Withholding
over seven one-clause items after sixteen substantive diffs landed would be
signature theatre in the opposite direction — treating my own caution as
evidence — and it would stall Batch B for items that Batch B is the right place
to fix. I also considered signing quietly and raising the residuals later, and
rejected that as worse than either alternative: the value of a countersignature
is that what it does *not* cover is written down at the moment it is given. So:
signed, with C-1 … C-7 in the packet, each named against the gate it must land
before, and each mine to raise.

I did not contest the two added REQs or the 21 strobe names. REQ-710 and
REQ-810 buy me two observables and cost me nothing, and the orchestrator's
not-an-E2 ruling matches my reading. `error_start_without_terminate` is the name
I would have chosen; having §12 at all is what makes REQ-008 and REQ-804
enumerable, and I had to reconstruct that enumeration by hand last time.

### Actions
- Re-read the four `docs/specs/` files at b4b4cf4 in full, plus my own findings
  and the WO-0004 Return log; dispositioned each of D-1 … D-16 against the
  applied text rather than against the architect's description of it.
- Re-walked the XGMII lane arithmetic for D-4 (both start lanes, two metrics)
  and D-3 (receive alternation and transmit rounding) with a throwaway Python
  model written from the spec text; worked the §1.1 unit consequence out stage
  by stage.
- Re-checked the derived numbers in D-2 (46, 18/8, 60–67, 46/26/18), D-8 (190
  words), D-9 (1/12/56/59 delivered) by hand.
- Re-ran the REQ/traceability set-equality check.
- Appended the RETURNED verdict entry to
  `agents/handoffs/WO-0005_spec-diff-re-review.md` (sixteen verdicts, the three
  named judgments, C-1 … C-7, the signature) and set its header state to
  RETURNED.
- Wrote no test code, no golden model and no RTL; touched nothing outside that
  packet and this journal.

### Evidence
1. **D-4 and D-3 lane walk** (self-contained; runnable from any checkout):
   ```
   python3 - <<'EOF'
   def walk(start_lane, d, n=64):
       N = 10; t0 = 8*N + start_lane + 8
       inp = {k: t0 + k for k in range(n)}
       Co  = (t0 + 7)//8 + d
       out = {k: 8*(Co + k//8) + (k % 8) for k in range(n)}
       return (sorted({out[k]//8 - inp[k]//8 for k in inp}),
               sorted({out[k]     - inp[k]     for k in inp}))
   for lane in (0, 4): print(lane, walk(lane, d=2))
   p = 0; s = []
   for _ in range(6): s.append((p//8, p % 8)); p += 8 + 64 + 12
   print(s)
   EOF
   ```
   → lane 0: cycle-metric `[2]`, octet-time `[16]`; lane 4: cycle-metric
   **`[2, 3]`** (two values inside one frame — my WO-0003 formulation is
   unsatisfiable there), octet-time `[20]` (constant). The two lane constants
   differ by 4 octet times, inside §0.5's 8-octet-time bound, and floor(L/8) = 2
   for both. Gap walk → `[(0,0),(10,4),(21,0),(31,4),(42,0),(52,4)]`, spacings
   10, 11, 10, 11, 10 — §0.3's alternation reproduced. Observed with Python
   3.11.15 in this container.
2. **§1.1 unit consequence.** With ΔC = (L + h)/8, floor(L/8) ≤ ceiling permits
   ΔC of 5 (M03 lane-0, h = 8), 6 (M03 lane-4, h = 12), 5 (M06, h = 14), 1 (M08,
   h = 0), 8 (M14, h = 20), 5 (M17, h = 8) — sum 24, exactly REQ-006's budget,
   leaving none of the declared 7-cycle slack. Arithmetic only; recomputable
   from §1.1 and §0.5 by hand.
3. **Set equality at b4b4cf4** —
   ```
   diff <(grep -o '^| \*\*REQ-[0-9]\{3\}' docs/specs/requirements.md | grep -o 'REQ-[0-9]*' | sort) \
        <(grep -o '^| REQ-[0-9]\{3\}'     docs/specs/traceability.md | grep -o 'REQ-[0-9]*' | sort)
   ```
   → no output; 110 REQs, 110 rows.
4. **M10's Path marking**, the fact my §14.3 enumeration contradicted —
   `grep -n '^| M10' docs/specs/architecture.md` → `| M10 | Arp_eth_rx | R |
   ARP packet parse into fields. | arp_eth_rx.v | 501 |`.
5. **No build or test evidence is claimed.** ADR-0005 makes CI authoritative and
   no Hardcaml toolchain exists in this container; this unit of work compiled
   nothing, elaborated nothing and ran no bench. The Python above is
   specification arithmetic, not a design-verification result — the same class
   of check as the CRC constants in `J-dv_lead-0001`.

### Outcome
DoD of WO-0005 met. All sixteen dispositions judged — **D-1 … D-16 all
CLOSED, none contested** — with the three named items judged explicitly: the
D-4 deviation **adopted and my own formulation refuted** with the lane-4 walk
that refutes it; the D-1 seven-module stress list **adopted**, the omission
being an internal contradiction in my own WO-0003 text; the D-3 resolution
**confirmed** against a fresh lane walk, with two corrections to my own figures
(the 9.5 % slowdown, and a stronger DIC argument than I made). Signature
decision explicit and affirmative, in the sentence PROTOCOL §7 requires the
orchestrator to transcribe:

> I sign the P1-spec-freeze testability precondition at b4b4cf4.

Seven carry-forward items C-1 … C-7 are recorded in
the packet, none a condition of the signature, each named against the gate it
must land before and each mine to raise as a spec diff. Handoff:
`agents/handoffs/WO-0005_spec-diff-re-review.md`, state RETURNED, for the
orchestrator to transcribe the signature sentence into the `P1-spec-freeze`
checklist under PROTOCOL §7.

### Open-questions
1. **C-1 … C-7 are open by design**, not escalations: C-1 (compare pinned
   latency as (L + h)/8, not floor(L/8) — before SPEC-M03), C-2 (conservation
   counts discarded frames, not strobe pulses; plus `clear` and receive-enable
   exemptions — before the first `SO-`), C-3 (top-level accounting of a
   zero-payload datagram — before the `nic_top` stress bench), C-4 (REQ-105 and
   REQ-110 zero-delivered-octet wording — before SPEC-M03), C-5
   (`error_underflow`'s vacuous window bound — editorial, before SPEC-M04), C-6
   (M10's stress pass criteria — in SPEC-M10), C-7 (a fifth REQ-901 divergence
   class for REQ-510's reply drop — before the first co-simulation run).
2. **Still open from `J-dv_lead-0001`, untouched by this WO**: the X-9 executor
   ruling for the six emitted-Verilog inspections; `hardcaml_verilator` plus a
   `verilator` binary against REQ-901; and the Cyclesim cost probe before the DV
   plan commits to 10 000-frame stress at `nic_top`. The probe is now on the
   critical path for sizing REQ-004 at M20 and REQ-708.
3. **Sequencing request**: my bench-setup work order should follow the freeze
   closely. §0.4's stress list, §0.5's octet-time tagger and §0.6's conservation
   monitor are one piece of machinery serving REQ-004, REQ-005, REQ-008, REQ-019
   and REQ-020, and C-1 … C-3 all land inside it — building it once, early, is
   what keeps them cheap.

### Files-in-this-commit
- agents/handoffs/WO-0005_spec-diff-re-review.md
