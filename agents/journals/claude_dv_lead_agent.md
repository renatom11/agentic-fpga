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

## [J-dv_lead-0003] 2026-08-02T05:55:00Z | task:WO-0007 | Batch A countersigned at 22145b5: SPEC-M01 and SPEC-M02 both SIGNED; every number in SPEC-M02 §6.1 recomputed from REQ-301 rather than checked; three new carry-forwards C-8 … C-10

### Trigger
Orchestrator spawn under work order WO-0007 (ISSUED at 920ff24), spawn short-id
`WO-0007/2026-08-02T05:20Z`. Third activation. `J-dv_lead-0002` signed the
*requirements* testability precondition; this work order asks for the per-spec
half on the first two module specifications — the condition
`docs/gates/P1-spec-freeze-checklist.md` makes item (b) of a batch being FROZEN.
Sign or contest, per spec, with three named items judged explicitly.

### Inputs
- `agents/charters/dv_lead.md` (§5 DoD, §6 evaluation criteria, refreshed);
  `agents/PROTOCOL.md` §4 (entry grammar), §7 (gates, signature transcription),
  §10 (independence and evidence).
- `agents/handoffs/WO-0007_batch-a-countersign.md` at 920ff24 — my work order.
- **Review targets at 22145b5**: `docs/specs/modules/axi64.md` (SPEC-M01) and
  `docs/specs/modules/crc32_eth.md` (SPEC-M02), both read whole, all thirteen
  sections each.
- `docs/specs/ifc_check/axi64_ifc.ml`, `docs/specs/ifc_check/crc32_eth_ifc.ml`,
  `docs/specs/ifc_check/template_ifc.ml`, `docs/specs/ifc_check/dune` — the
  lifts whose compile is the freeze evidence.
- `docs/specs/requirements.md` at b4b4cf4 (the text I signed) — §0.1 … §0.7,
  §1 REQ-001 … REQ-021, §4 REQ-301 … REQ-306 and its provenance note, §9.1,
  §9's REQ-802/804/808, §10's REQ-903/905/906, §12 the strobe appendix.
- `docs/specs/SPEC-TEMPLATE.md` at b4b4cf4 — the "How to use" rules (in
  particular rules 3, 4, 5, 6 and 7) and every numbered section's obligation.
- `docs/specs/architecture.md` §4 inventory rows M01 and M02.
- `agents/handoffs/WO-0006_batch-a-specs.md` — the architect's RETURNED log
  (four contested items, four batch-B open questions, the three places it asked
  me to look hardest) and the orchestrator's ACCEPTED entry with dispositions
  1–6, including the REQ-010 narrowing agreed for batch B.
- `docs/gates/P1-spec-freeze-checklist.md` — batch table, carry-forward ledger
  C-1 … C-7, the two sponsor decisions.
- My own `agents/handoffs/WO-0003_testability-findings.md` and
  `WO-0005_spec-diff-re-review.md` for the standards I set myself.
- **No RTL.** `libs/**` and `rtl_snapshots/**` were never opened. This unit of
  work is specification text and arithmetic, as the previous two were.

### Reasoning
**The reader I judged for, again.** Not "is this document good" but "can a
tb_writer who receives these sections as an excerpt, and who is denied RTL
(PROTOCOL §10), produce stimulus and an expected result from them alone". I ran
that test section by section rather than document by document, because the
excerpt is the unit that will actually be delegated.

**I recomputed every number rather than checking that the architect computed
them.** WO-0006's Return log says the numbers "were computed, not recalled", and
that claim is exactly the kind I am not entitled to accept. So I wrote a
bit-serial CRC-32 from REQ-301's parameterisation as stated in requirements.md
§4 — polynomial 0x04C11DB7, init 0xFFFFFFFF, reflected in and out, final XOR
0xFFFFFFFF — with no table and without using `zlib` in the definition, then
cross-checked it against `zlib` afterwards. Every number in SPEC-M02 §6.1 is
right: the derived intermediate 0x9AE0DAAF for `CRC32("12345678")`, REQ-303's
0xCBF43926 at `crc_out` after the second update, the octet packing
0x3837363534333231, REQ-304's 0x2144DF1C over frame-plus-FCS at five different
frame lengths, and both raw-register conversions in note 3 (0x340BC6D9 and
0xDEBB20E3, the latter reproducing requirements.md §4's 0xC704DD7B under a
further bit reversal).

What I was actually hunting there was not the constants but **the seed**.
REQ-301 says the initial value is 0xFFFFFFFF; SPEC-M02 says a caller seeds
`crc_in` with 0x00000000. A test writer who takes REQ-301's number as the port
seed builds a bench that fails a conformant M02 on its first vector — the same
defect class as the two wrong constants I caught in WO-0003, one level down and
harder to see, because both numbers are individually correct and only their
*pairing* is wrong. The spec defends against it in three separate places
(§4.2's `crc_in` row, §6.1 note 1, and the explicit "this is not a contradiction
of REQ-301" sentence) and gives the reason rather than the rule. I verified the
premise it rests on — `CRC32(empty) = 0x00000000` — instead of accepting it.

**Why I endorse the finished-value convention rather than merely tolerate it.**
It is the minority convention in prior art, so the cheap review is to note the
divergence and move on. The reason it is right is a DV reason: my REQ-305 oracle
takes a running value and returns a running value, so under this convention the
comparison is `crc_out = reference(crc_in, octets)` with no conversion at either
end. Every conversion is a place an endianness or complement error hides, and
this programme has already lost a cycle to precisely that class (0xC704DD7B was
the same residue in a different convention and survived careful reading). I also
confirmed the spec is right that a `zlib`-shaped table-driven implementation is a
cross-check *of* my reference and not a substitute *for* it: REQ-305 names
bit-serial so the oracle shares no structure with the design, so my anchor run —
the one PROTOCOL §10 and charter §3 require before the model may judge RTL — must
be the bit-serial one reproducing 0xCBF43926, with `zlib` as a second opinion
only. That is now a written obligation on me, not a preference.

**The Status check was mechanical, not visual.** Twenty-one names is exactly the
length at which reading is unreliable, and `error_start_without_terminate` versus
`error_start_without_terminator` is a defect no amount of care catches by eye. So
I extracted both lists and compared them as ordered sequences, character for
character: 21 for 21, same order, no extra field, no missing strobe, no
duplicate. I extended the same treatment to `Config` against §9.1 (twelve fields,
twelve rows, every width equal), to the three header records against SPEC-M01
§4.2's field tables, and to both §4.1 blocks against their lifts (byte
identical). The reason for extending it is SPEC-M01 §4.2's own decision not to
restate the twenty-one names — "a second copy of twenty-one normative names is a
second place for them to drift". That is the right call, and its consequence is
that the record *is* the only copy, so the record is the thing that has to be
checked, by script, at every SHA. I am claiming that script under `tools/`.

**The "not applicable" sweep, and what I was looking for.** Eleven NA/None
answers across the two specs (six in M01, five in M02). The failure mode I was
hunting is an obligation that lands somewhere real being answered with a
sentence about why this module is special. Ten are honest, and two of those are
ones I fully expected to be dodges: SPEC-M02 §9, where a module that could
plausibly have invented a strobe for an out-of-domain `octet_count` instead
argues why inventing one would put a field in the §12 record for a condition
§12 does not name; and SPEC-M02 §5, which meets REQ-506's
timeouts-must-be-parameters rule head-on and shows it has no instance rather
than ignoring it. SPEC-M01 §7 answers all five template clauses separately and
names where each contract does live — that is the form I want the other eighteen
specs to copy, and I said so in the packet.

The one that is not clean is **SPEC-M01 §4.1's `create`/`hierarchical`
bullet**, and it is worth recording precisely because the engineering answer is
right and the citation is not. A types-only module genuinely has no entry point;
nobody disputes that. But the bullet cites REQ-808 as excluding it, and
REQ-808's exclusion is written for the emitted-Verilog module list only. REQ-903
— "Every module in the inventory SHALL have an `.mli` and a `hierarchical` entry
point taking a `Scope.t`" — carries no types-only exclusion and quantifies over
architecture.md §4's inventory, where M01 is row one. SPEC-M01 §10 has no
REQ-903 row at all, so nothing else in the spec covers it. And the obligation
splits: the `hierarchical` half is genuinely impossible, but the `.mli` half is
not — a types-only OCaml module can carry an `.mli` — and the spec does not
address that half. The REQ-903 repository check therefore has no determinable
answer for M01 from the frozen text set.

**Why that is carry-forward C-8 and not a contest.** It meets the letter of the
test I set myself in WO-0003 §1.2 — I cannot determine pass/fail for a
conformant design — which is why I am naming it rather than waving at it. But
the standard for what a *signature* blocks, which I set in `J-dv_lead-0002`, is
a defect the batch itself must fix. This one is fixed by one clause in
requirements.md, a document this work order puts out of scope and which is
signed at b4b4cf4; the affected check is a repository-surface script at
`P1-module-ready`, a gate away; and no tb_writer is blocked by it, because no
bench derives from REQ-903. Contesting a module spec over a quantifier in
another document would be the signature theatre I refused last time, in the
opposite direction.

**SPEC-M02 judged against the agreed REQ-010 narrowing, as instructed — and the
dependency named.** Under the agreed batch-B wording (REQ-010's subject narrowed
to frame-carrying *stream* ports, naming M02 as the non-stream case), SPEC-M02's
§3 REQ-010 row, its §4.1 `Source`-without-`Dest` bullet and its §10 REQ-010 row
are all correct and my signature covers them. Under the literal b4b4cf4 wording
they are not, and I would not sign them. I am recording that asymmetry rather
than letting a countersignature quietly convert an agreement-in-principle into a
settled fact: if the narrowing does not land in batch B, three claims in a
FROZEN SPEC-M02 become false and template rule 7 makes their repair a spec diff
plus an ADR. Naming the dependency is what keeps the cost of that visible.

**Sign or withhold.** Three new carry-forwards, eight standing open questions
across the two specs, and one CI verification that is still not done. I checked
the last one instead of assuming it: the green run 30727252770 elaborates the
functor application and every hand-written record in both lifts, but **no lift
names an `Axi64.Source` or `Dest` field anywhere outside a comment**, so
SPEC-M01 §11.4 is exactly as open as it was before the run — as §11.4 itself
predicts, and batch B's M03 lift is what settles it. None of these stops me
handing an excerpt to a tb_writer, which is the only question a testability
countersignature answers.

Two alternatives rejected. **Withholding until the eight open questions close**:
four of them close in batch B by construction, and batch B's specs are written
in M01's vocabulary, so that makes my signature a circular dependency and stalls
the programme on items batch B is the correct place to fix. **Signing quietly
and raising C-8 … C-10 later**: the value of a countersignature is that what it
does not cover is written down at the moment it is given, which is the standard
`J-dv_lead-0002` set and the one the auditor will hold me to.

**One governance conflict I will not sign past silently.** SPEC-TEMPLATE §11
says a FROZEN spec may not carry open questions. Both batch-A specs carry four
each, and none of the eight closes before batch B or before the gate itself. The
gate checklist's FROZEN condition lists only (a) a green `ifc_check` run and (b)
my countersignature — so satisfying both does not make the DRAFT → FROZEN status
flip legal under the form the auditor checks against. That is the architect's
and the orchestrator's to resolve, not mine, and it is not a reason to withhold.
But my signature is one of the two named conditions, and I will not have it read
as endorsing a flip the template forbids.

### Actions
- Read both specs whole at 22145b5, all thirteen sections each, against
  SPEC-TEMPLATE's per-section obligations rather than against a general
  impression of completeness.
- Wrote a bit-serial CRC-32 from REQ-301's stated parameterisation and verified
  by computation: `CRC32(empty)` = 0x00000000; worked example 1 including its
  derived intermediate; worked example 2's residue at five frame lengths; both
  update decompositions of worked example 2 (M04's 7×8 + 1×4 over 60 octets,
  M03's 8×8 over 64); REQ-302 serial equivalence over 3000 random cases across
  all eight octet counts; both raw-register conversions in note 3.
- Compared, mechanically: `Status` against §12 as ordered character-for-character
  sequences; `Config` against §9.1 field for field with widths; the three header
  records against SPEC-M01 §4.2's tables; both §4.1 blocks against their lifts.
- Swept all eleven "not applicable"/"None" answers against the obligation each
  section carries in the template and in requirements.md.
- Checked template rule 5's banned phrasing, section completeness, and every
  open question's stated close target in both specs.
- Verified that no lift names an `Axi64.Source`/`Dest` field outside a comment,
  which is what leaves SPEC-M01 §11.4 undischarged by run 30727252770.
- Appended the RETURNED verdict entry to
  `agents/handoffs/WO-0007_batch-a-countersign.md` and set its header state to
  RETURNED.
- Wrote no test code, no golden model and no RTL; edited nothing under
  `docs/specs/**`, `docs/gates/**` or `libs/**`.

### Evidence
All commands runnable from a repo checkout at this SHA (PROTOCOL §4.1 form (a)),
run from the repository root.

1. **CRC verification, self-contained, no `zlib` in the definition** (Python
   3.11.15 in this container):
   ```
   python3 - <<'EOF'
   P=0x04C11DB7
   def rev(x,n): return int(('{:0%db}'%n).format(x)[::-1],2)
   def upd(c,bs):                      # SPEC-M02 port convention: finished in, finished out
       r=c^0xFFFFFFFF; rp=rev(P,32)
       for b in bs:
           r^=b
           for _ in range(8): r=(r>>1)^rp if r&1 else r>>1
       return r^0xFFFFFFFF
   def ser(m):                         # REQ-301 verbatim: non-reflected reg, reflected in/out
       r=0xFFFFFFFF
       for b in m:
           r^=rev(b,8)<<24
           for _ in range(8): r=((r<<1)^P)&0xFFFFFFFF if r&0x80000000 else (r<<1)&0xFFFFFFFF
       return rev(r,32)^0xFFFFFFFF
   import zlib,random; random.seed(7)
   assert all(ser(m)==upd(0,m)==zlib.crc32(m)&0xFFFFFFFF for m in
              [b"",b"123456789",b"12345678",bytes(range(60)),b"\x00"*64])
   print("CRC32(empty)      %08X"%upd(0,b""))
   u1=upd(0,b"12345678"); print("wex1 update1      %08X (spec 9AE0DAAF)"%u1)
   print("wex1 update2      %08X (REQ-303 CBF43926)"%upd(u1,b"9"))
   print("packing '12345678' %016X (spec 3837363534333231)"%int.from_bytes(b"12345678","little"))
   res=set()
   for n in (60,46,26,9,1500):
       m=bytes(random.randrange(256) for _ in range(n))
       res.add(upd(0,m+upd(0,m).to_bytes(4,"little")))
   print("wex2 residue      %s (REQ-304 2144DF1C)"%["%08X"%v for v in res])
   m=bytes(random.randrange(256) for _ in range(60)); c=0
   for i in range(0,56,8): c=upd(c,m[i:i+8])
   c=upd(c,m[56:60]); rx=m+c.to_bytes(4,"little"); d=0
   for i in range(0,64,8): d=upd(d,rx[i:i+8])
   print("M04 7x8+1x4 == whole:",c==upd(0,m)," M03 8x8 residue %08X"%d)
   bad=0
   for _ in range(3000):
       n=random.randrange(1,9); ci=random.getrandbits(32)
       ds=bytes(random.randrange(256) for _ in range(n)); s=ci
       for b in ds: s=upd(s,bytes([b]))
       bad+=(upd(ci,ds)!=s)
   print("REQ-302 serial equivalence failures:",bad)
   print("note 3: %08X %08X"%(0xCBF43926^0xFFFFFFFF,0x2144DF1C^0xFFFFFFFF))
   print("provenance: %08X"%rev(0x2144DF1C^0xFFFFFFFF,32))
   EOF
   ```
   → `CRC32(empty) 00000000`; `wex1 update1 9AE0DAAF`; `wex1 update2 CBF43926`;
   packing `3837363534333231`; `wex2 residue ['2144DF1C']` (one value across all
   five lengths); `M04 7x8+1x4 == whole: True  M03 8x8 residue 2144DF1C`;
   `REQ-302 serial equivalence failures: 0`; `note 3: 340BC6D9 DEBB20E3`;
   `provenance: C704DD7B`. Every number SPEC-M02 §6.1 states is reproduced.

2. **`Status` against §12, ordered and character-for-character**:
   ```
   diff <(sed -n '/^## 12. Strobe appendix/,$p' docs/specs/requirements.md \
            | grep -oE '^\| `error_[a-z_]+`' | tr -d '|` ') \
        <(sed -n '/^module Status = struct/,/deriving hardcaml/p' docs/specs/modules/axi64.md \
            | grep -oE '(error_[a-z_]+) :' | cut -d' ' -f1)
   ```
   → no output. Counts on both sides (same two extractions piped to
   `grep -c`) → `21` and `21`.

3. **`Config` against §9.1**:
   `sed -n '/^module Config = struct/,/deriving hardcaml/p' docs/specs/modules/axi64.md | grep -cE "^\s*[{;] [a-z_]+ : 'a"`
   → `12`;
   `sed -n '/^### 9.1 Configuration fields/,/^---$/p' docs/specs/requirements.md | grep -E '^\|' | grep -vE '^\| Field|^\|---' | wc -l`
   → `12`. Widths compared row by row (48/32/32/32/32/1/16/1/8/8/1/1) — all
   equal, in §9.1's order.

4. **§4.1 blocks byte-identical to their lifts**:
   ```
   diff <(sed -n '/^```ocaml$/,/^```$/p' docs/specs/modules/axi64.md | sed '1d;$d') \
        docs/specs/ifc_check/axi64_ifc.ml
   diff <(sed -n '/^```ocaml$/,/^```$/p' docs/specs/modules/crc32_eth.md | sed '1d;$d') \
        docs/specs/ifc_check/crc32_eth_ifc.ml
   ```
   → no output from either.

5. **SPEC-M01 §11.4 is not discharged by run 30727252770** — no lift names a
   `Source`/`Dest` field outside a comment:
   ```
   for f in docs/specs/ifc_check/*.ml; do printf '%s: ' "$f"; \
     awk '/\(\*/{c=1} {if(!c) print} /\*\)/{c=0}' "$f" \
     | grep -cE 'tvalid|tdata|tkeep|tstrb|tlast|tuser|tready'; done
   ```
   → `0` for `axi64_ifc.ml`, `crc32_eth_ifc.ml` and `template_ifc.ml`.

6. **Template conformance**:
   `grep -ciE 'as needed|appropriately|should normally|obviously|TBD' docs/specs/modules/axi64.md docs/specs/modules/crc32_eth.md`
   → `0` and `0` (rule 5);
   `grep -c '^| 11\.' docs/specs/modules/axi64.md docs/specs/modules/crc32_eth.md`
   → `4` and `4` (the eight open questions behind the SPEC-TEMPLATE §11 point);
   both files carry all thirteen numbered `##` sections.

7. **REQ-903's quantifier, the C-8 evidence**:
   `grep -n 'REQ-903\|REQ-808' docs/specs/requirements.md` → REQ-808 carries
   "**whose role is not types-only** … M01 `Axi64` is types-only … so it is
   excluded"; REQ-903 reads "Every module in the inventory SHALL have an `.mli`
   and a `hierarchical` entry point taking a `Scope.t`" with no exclusion.
   `grep -n 'REQ-903' docs/specs/modules/axi64.md` → one hit, the §4.1 bullet;
   no §10 row.

8. **No build or test evidence is claimed by me.** ADR-0005 makes CI the
   authoritative build environment and no Hardcaml toolchain exists in this
   container; this unit of work compiled nothing, elaborated nothing and ran no
   bench. The compile evidence for both lifts is the externally verifiable CI
   `build` run **30727252770**, conclusion green, recorded in the gate
   checklist's batch table (PROTOCOL §4.1 form (b), REQ-906). The Python above
   is specification arithmetic, the same class of check as the CRC constants in
   `J-dv_lead-0001`, not a design-verification result.

### Outcome
DoD of WO-0007 met. Both specs judged as the reader who will hand excerpts to a
tb_writer who never sees RTL:

- **SPEC-M01 `Axi64` — SIGNED.**
- **SPEC-M02 `Crc32_eth` — SIGNED**, judged against the REQ-010 narrowing already
  agreed for batch B (WO-0006 ACCEPTED, disposition 1), which I state explicitly
  because under the literal b4b4cf4 wording of REQ-010 I would not sign §3, §4.1
  and §10's REQ-010 claims.

The three named items, judged:

(a) **SPEC-M02's finished-CRC port convention — correct, and verified by
computation rather than recall.** Seed 0x00000000 is `CRC32(empty)`; REQ-303's
0xCBF43926 and REQ-304's 0x2144DF1C are both read directly at `crc_out` with no
adjustment; init 0xFFFFFFFF and the final XOR are internal and cancel over an
empty input. The derived intermediate 0x9AE0DAAF, the octet packing
0x3837363534333231, the residue at five frame lengths, both update
decompositions and both raw-register conversions all reproduce. The convention
is also the right one for DV: it makes the REQ-305 oracle comparison an identity
with no conversion at either end, and conversions are where this programme has
already lost a cycle.

(b) **SPEC-M01's `Status` record against requirements.md §12 — exact.** All
twenty-one strobe names, character for character, in §12's order, checked
mechanically as ordered sequences: no missing strobe, no extra field, no
duplicate, no reordering. Extended to `Config` versus §9.1 (twelve fields,
widths equal, in order), the three header records versus §4.2's tables, and both
§4.1 blocks versus their lifts (byte identical).

(c) **The "not applicable" answers — eleven in total, ten honest, one
unsupported.** SPEC-M01 §4.2, §4.3, §6.2, §7 (all five clauses answered
separately with the owner of each named), §8 and §9 are honest; so are SPEC-M02
§4.1's `Source`-without-`Dest` bullet, §4.3, §5, §6.2, §7's two NA clauses, §8
and §9. The exception is SPEC-M01 §4.1's `create`/`hierarchical` bullet: the
engineering answer is right, but it cites REQ-808's types-only exclusion, which
is written for the emitted-Verilog module list only, while REQ-903 quantifies
over the whole inventory with no exclusion and is not covered anywhere else in
the spec — and its `.mli` half, which a types-only module *can* satisfy, is not
addressed. Recorded as C-8, not a signature block.

The signature, in the sentence PROTOCOL §7 requires the orchestrator to
transcribe into `docs/gates/P1-spec-freeze-checklist.md`:

> I countersign batch A (SPEC-M01, SPEC-M02) for P1-spec-freeze at 22145b5

Handoff: `agents/handoffs/WO-0007_batch-a-countersign.md`, state RETURNED,
carrying both verdicts, the three judgments and carry-forwards C-8 … C-10.

### Open-questions
1. **New carry-forwards, none a condition of the signature.** **C-8** — REQ-903
   quantifies over every inventory module and carries no types-only exclusion,
   while SPEC-M01 §4.1 declares `create`/`hierarchical` not applicable citing
   REQ-808; the repository check has no determinable answer for M01, and the
   `.mli` half needs a decision of its own (exempt M01 from both halves, or only
   from `hierarchical`). One clause in requirements.md, owner
   architect_docs_lead with rtl_lead; must land before `P1-module-ready`.
   **C-9** — SPEC-M01 §10's hooks for REQ-802 and REQ-804 name "the interface
   compile check" as the mechanism for comparing the records against
   requirements.md §9.1 and §12; an OCaml compile cannot read a markdown table,
   so the hook names an artefact that cannot perform it. Editorial: name the
   script instead. I am claiming that script under `tools/` — it is the one in
   Evidence items 2 and 3 — and it must exist before the first `SO-` cites those
   hooks. **C-10** — SPEC-M01 §6.1's `tuser` paragraph drops REQ-013's word
   "solely" ("No Phase-1 module drops or alters a frame because this bit is
   set"), which a monitor writer holding only the M01 excerpt could turn into a
   false failure against a requirements.md §0.6 local discard that legitimately
   suppresses an aborted frame. One word, or one clause pointing at §0.6; must
   land before the shared protocol monitor does.
2. **Two editorial nits raised in the packet, no ledger id.** SPEC-M02 §6.1
   worked example 2 labels frame octets 0–7 "(destination address)" where the
   destination address is six octets, so 0–7 is DA plus the first two
   source-address octets — the numeric ranges are unambiguous, so no test is
   affected. SPEC-M02 §6.3 item 3 sits under "Deliberately unconstrained" but
   states a prohibition (no internal register, ever); its content belongs in §6.1
   or §7, and §10's REQ-306 row already commissions the check, so no coverage is
   lost.
3. **SPEC-TEMPLATE §11 versus the FROZEN status flip.** A FROZEN spec may not
   carry open questions; both batch-A specs carry four each and none closes
   before batch B or before the gate itself. The gate checklist's FROZEN
   condition names only the green run and my countersignature, so satisfying both
   does not make the flip legal under the form the auditor checks. Architect and
   orchestrator to reconcile — either the specs stay DRAFT with the
   countersignature banked, or the questions close, or the gate text says which
   rule governs. Flagged because my signature is one of the two named conditions.
4. **SPEC-M01 §11.4 is not discharged by run 30727252770**, which I verified
   rather than assumed: no lift names an `Axi64.Source`/`Dest` field outside a
   comment, so `hardcaml_axi` v0.17.0's field names remain unverified by any
   compile. Batch B's M03 lift is the first that will name one. A divergence is
   editorial per §11.4, but it lands in text I have now countersigned, so I want
   it settled in batch B rather than at first bench.
5. **The REQ-010 narrowing is now load-bearing on my signature for SPEC-M02.**
   If it does not land in batch B, three claims in a frozen SPEC-M02 become false
   and their repair is a spec diff plus an ADR under template rule 7.
6. **Unchanged and still open from earlier entries**: C-1 … C-7 as recorded in
   the gate ledger (C-1 and C-4 remain batch-B scoped and have no instance in
   batch A — neither spec pins a latency constant, which I checked); the X-9
   ruling on who executes the six emitted-Verilog and repository inspections,
   which C-8 and C-9 both now touch; `hardcaml_step_testbench` absent from
   `agentic_fpga.opam`; and the Cyclesim cost probe before the DV plan commits to
   10 000-frame stress at `nic_top`.
7. **Sequencing request, restated because it is now overdue.** My bench-setup
   work order should follow this gate closely: §0.4's stress list, §0.5's
   octet-time tagger, §0.6's conservation monitor, the record-versus-appendix
   scripts of C-9, and the REQ-305 bit-serial reference with its REQ-303 anchor
   run are one piece of machinery, and C-1 … C-3 and C-9 all land inside it.

### Files-in-this-commit
- agents/handoffs/WO-0007_batch-a-countersign.md
