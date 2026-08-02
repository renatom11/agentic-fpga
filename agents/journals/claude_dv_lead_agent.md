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

## [J-dv_lead-0004] 2026-08-02T07:40:00Z | task:WO-0009 | DUT-independent bench machinery built: REQ-305 CRC reference anchored on 0xCBF43926, SPEC-M01 §6.1 protocol monitor, §0.6 conservation monitor, §0.5 octet-time tagger, C-9/X-9 scripts; thirty expect snapshots left empty for CI promotion

### Trigger
Orchestrator spawn under work order WO-0009 (ISSUED at 2665a04), spawn short-id
`WO-0009/2026-08-02T05:55Z`. Fourth activation, and the first that produces work
product rather than a verdict: the three before this one reviewed other agents'
documents, and this one builds the machinery every Phase-1 bench will stand on.
It is the work order I asked for in `J-dv_lead-0002` open question 3 and again,
"restated because it is now overdue", in `J-dv_lead-0003` open question 7.

### Inputs
- `agents/charters/dv_lead.md` (refreshed, §3 golden-model home and
  external-anchor rule, §5 DoD, §9 test stack); `agents/PROTOCOL.md` §4 (entry
  grammar), §6 (write scopes), §10 (independence and evidence).
- `agents/handoffs/WO-0009_bench-machinery.md` at 2665a04 — my work order.
- **Spec basis, committed text only**: `docs/specs/requirements.md` at
  **b4b4cf4** — §0.4, §0.5 (octet time, latency, cycles, start lanes), §0.6
  (aborts, discards, strobe multiplicity, frame conservation), §0.7
  (zero-length payloads), REQ-001 … REQ-021, §1.1, §4 (REQ-301 … REQ-306 and
  the provenance note), §9.1, REQ-802/804/808/810, REQ-901 … REQ-906, §12.
  `docs/specs/modules/axi64.md` (SPEC-M01) and `docs/specs/modules/crc32_eth.md`
  (SPEC-M02) at **22145b5** — §4.1, §4.2, §6.1, §6.3 of each.
  `docs/specs/architecture.md` §4 inventory (for the X-9 module-name list).
- My own `agents/handoffs/WO-0003_testability-findings.md` §13.2 and §13.3 (the
  bench architecture this implements), and the carry-forward ledger C-1 … C-10
  as recorded in `WO-0005_spec-diff-re-review.md`, `WO-0007_batch-a-countersign.md`
  and `docs/gates/P1-spec-freeze-checklist.md`.
- `docs/adr/ADR-0004-toolchain-lane.md`, `docs/adr/ADR-0005-build-environment.md`;
  `agentic_fpga.opam`, `dune-project`, `test/hardcaml_ethernet/dune` and
  `test/hardcaml_ethernet/test_word_counter.ml` (dune conventions and the
  proven-compiling `open! Base` / `open Hardcaml` pattern);
  `.github/workflows/build.yml`; `scripts/check_journals.sh` and
  `scripts/policy.sh` for shell-script house style.
- `docs/specs/ifc_check/axi64_ifc.ml` — the lift of SPEC-M01 §4.1, read as the
  signed public interface my one sanctioned import targets.
- **`rtl_snapshots/word_counter.v`, read deliberately and for the first time.**
  The WO-0003/WO-0007 ACCEPTED rulings settled X-9 by permitting `tools/` to
  parse `rtl_snapshots/**` — a build product — while never opening `libs/**`
  sources. I could not write a Verilog structural checker that actually parses
  Hardcaml's emitter format without looking at one file it emitted. Recording
  it explicitly because my three previous entries all said `rtl_snapshots/` was
  not opened, and a silent change of practice is exactly what the auditor
  samples Inputs sections for.
- **`libs/**` was never opened**, in this or any previous activation. Nothing in
  this commit derives from RTL.

### Reasoning
**The layering decision, which everything else follows from.** The obvious build
is monitors that take a `Cyclesim` handle and an `Axi64.Source` and check it. I
rejected that and made every monitor a pure function over a plain OCaml
`Stream_word.t`, with attachment expressed as a per-cycle closure
(`Protocol_monitor.sink`) over a caller-supplied sampler. Four reasons, in the
order they mattered.

First, *what the tests then prove*. A monitor whose unit tests need a DUT is
tested against a design, so a bug in the monitor and a bug in the design are the
same red. Hand-built traces are OCaml values, so these tests fail when the
monitor is wrong and at no other time — which is the whole reason the WO asked
for legal and illegal traces. Second, *ADR-0005*. No Hardcaml runs in this
container, so anything touching Hardcaml is unverifiable by me and lands on CI
faith. Anything that is standard-library OCaml I can type-check and **execute**
with the system 4.14.1 compiler. Making the layer pure moved roughly nine
hundred lines from "CI will tell us" to "I ran it, here is the output", which on
a work order whose deliverables are the foundation of every later bench is worth
more than any elegance argument. Third, *the driver question stays open*. The
same closure is driven by a `Cyclesim` loop after `Cyclesim.cycle` and by a
`hardcaml_step_testbench` cycle hook, so choosing between them is a bench-level
decision made later rather than baked into the monitors now. Fourth, *the
sanctioned import shrinks to one file*.

**The blast-radius argument for putting `Axi64` in its own library.** SPEC-M01
§11.4 — which I wrote up in `J-dv_lead-0003` after checking rather than assuming
that run 30727252770 did not discharge it — records that the `Source` field
names are transcribed from `hardcaml_axi`'s `stream_intf.ml` and unverified by
any compile, because no lift names a field outside a comment. `axi64_probe.ml`
is the first code in the repository to name them, so it either discharges §11.4
or answers it. I weighed omitting it: it is the one file that can fail to
compile, and if the whole DV layer sat in one library its failure would take the
cost-probe figure, the CRC anchors and every monitor test down with it, turning
a two-line editorial fix into a wasted CI round trip on a work order with five
deliverables. Isolating it in its own dune library makes the failure mode
"delete one directory and re-push", and I added `of_refs` — which names no
stream type at all — so that every bench can attach without depending on the
answer. That is the shape I want: take the risk that produces information, but
pay for it in one file rather than in five deliverables.

Targeting `Ifc_check.Axi64_ifc.Axi64` rather than `Hardcaml_ethernet.Axi64` was
not a preference. The latter does not exist: SPEC-M01 specifies
`libs/hardcaml_ethernet/src/axi64.ml` and rtl_lead has not built it, and
`libs/**` is outside my scope and unopened besides. The lift is the signed
interface, byte-identical to §4.1 and countersigned at 22145b5, which is
precisely what the packet's exception names. When M01 lands, `of_source`
retargets in one line — and I have put that obligation in Open-questions rather
than letting a future agent discover it as a type error.

**Where I chose to disagree with the specification, and why each is a
carry-forward rather than a silent fix.** Three of the four monitors implement
something the frozen text does not literally say, and in each case writing the
literal text would have produced a monitor that fails a conformant design — the
exact defect class I spent WO-0003 objecting to in other people's rows, so I am
not entitled to introduce it in my own code.

*C-2, in the conservation monitor.* §0.6's equation adds "discard-strobe
pulses", but §0.6's own strobe-multiplicity paragraph says two locally detected
conditions on one frame produce two pulses. A frame discarded for two reasons is
then counted twice and a conformant run reports a surplus. The monitor balances
on discarded **frames** and keeps the pulse histogram separately, because
REQ-008(a) and REQ-804 genuinely need per-strobe pulse counts and the two
questions are different. The unit test prints both figures side by side (−1
against 0) so the argument is visible rather than asserted. Its second half is
the exemption: REQ-810 says in terms that a frame refused while receive-enable
is 0 "creates no silent-discard hole under REQ-008", so counting those hundred
injected frames as presented would make every enable and reset test report a
false silent discard.

*C-1, in the tagger.* §0.5 converts to cycles as `floor (L / 8)` and §1.1's
ceilings are word-cycle allocations, which differ by `ceil (h / 8)` at a
stripping stage. I offer both conversions and print both. I specifically
rejected picking one: choosing `floor (L / 8)` silently would make a sign-off
packet quote a figure that understates the stage, and choosing ΔC silently would
have me enforcing a requirement the signed text does not state. Reporting both
is the only option that leaves the question where it belongs — with the
architect — while keeping every packet checkable against whichever wording
lands.

*C-11, new, in the protocol monitor, and the wording is mine.* REQ-015's two
sentences cannot both hold. The 190-word figure it quotes for the
`Xgmii_rx_64` output stream only comes out if words are counted inclusive of the
`tlast` word (1514 octets is 189 full words plus a 2-octet remainder), and under
that convention its second sentence — "SHALL NOT assert `tlast` without at least
one preceding word since the previous `tlast`" — forbids the single-word frame
that REQ-011 and SPEC-M01 §6.1 make mandatory for any payload of 1 to 8 octets.
That sentence is the restatement I proposed in WO-0003 §"REQ-015", so the defect
is mine and I am raising it against myself. It is unenforceable in any case: the
only shape it could forbid is `tlast` on a cycle carrying no word, and §6.3
item 5 forbids a monitor from looking at `tlast` when `tvalid` = 0. The monitor
enforces the inclusive count, enforces nothing from the second sentence, records
the reading at the top of the file, and has a unit test asserting the
single-word frame is legal.

**Making the §6.3-item-5 guard structural instead of conventional.** "No monitor
may assert on an unconstrained value" is a rule that is easy to state and easy to
break by a later edit. I built it into the types and the control flow rather than
into a comment: every rule sits inside one `tvalid` test at the top of `observe`,
so a rule added below it inherits the guard; `Stream_word.octets` returns only
positions whose `tkeep` bit is set and is the only read of `tdata` anywhere; and
`to_string` renders an invalid cycle as the word `idle` and nothing else, so an
unconstrained value cannot reach an expect snapshot and freeze into an accidental
requirement — which would be a worse outcome than a missed check, because it
would be an unwritten requirement enforced by a promoted file. Two unit tests
falsify the guard directly, one driving a trace of deliberately toxic idle cycles
and one a legal word with nonsense above `tkeep`.

**The expect-block discipline, and what I did so that it costs nothing.**
ADR-0005 rule 2 makes hand-authoring a snapshot fabricated evidence, so all
thirty are empty and the first CI run is expected to fail with thirty diffs.
That leaves a real hazard: if the judgement lives in the snapshot, then whoever
promotes a red snapshot promotes a broken check into green. So no judgement
lives in the snapshots. Every case states its expected constants in OCaml,
compares there, prints `ok` or `MISMATCH` / `VERDICT WRONG`, and **raises** on
failure. A promoted red snapshot still fails the run. The same reasoning made
the cost probe an executable on the `runtest` alias rather than an expect test:
a wall-clock figure can never be promoted, because the workflow's
`git diff --cached --exit-code` step would fail on every run forever.

**Determinism, in two places it would have bitten later.** The random cases use
an LCG written out in the test file rather than `Random`, whose algorithm is
neither guaranteed across OCaml versions nor ours; and `random_octets` uses an
explicit loop rather than `List.init`, because the standard library does not
promise the order in which `List.init` applies its function and a stateful
generator inside it would make the snapshot depend on that. Both are cheap now
and unfindable later.

**The CRC reference: I rejected the cheaper constructions twice.** REQ-305 names
a bit-serial reference so the oracle shares no structure with the design, so a
table-driven implementation is a cross-check *of* it and never a substitute *for*
it — a rule I wrote into `J-dv_lead-0003` as a written obligation on myself and
am now bound by. The module is `step_register` stated verbatim from REQ-301: a
non-reflected register, the octet reflected in at bits 31:24, eight shifts. I
added a second, structurally different bit-serial arrangement (reflected
register, reversed polynomial) as a cross-check of my own arithmetic, and I am
careful to say in the code that it is not the external anchor: the anchor is
REQ-303's published 0xCBF43926, and it is asserted before the reference judges
anything, per PROTOCOL §10 and charter §3. The negative case — the residue is
*not* constant when the FCS is appended most-significant-octet-first — is there
because that is what pins REQ-202's wire order, and a bench that packs it the
wrong way should fail in the oracle's own tests rather than as a false BUG-
against rtl_lead.

**The tools scripts got the treatment I demand of tb_writer.** They are the only
deliverables here that run in this container, so I spot-checked them the way my
charter §3 says I must spot-check a worker's bench: I seeded mutations and
confirmed each one fails. Renaming one strobe in the `Status` record, narrowing
one `Config` width, deleting one name from the DV strobe list, a `negedge`, a
gated clock derived from `clock`, a `crc32_eth` with a clock port and a posedge
block, an instantiated `RAMB36E1`, an `.xdc` file, and a `nic_top` with
`xgmii_spare` in place of `xgmii_txc`, a lift drifted away from its spec, and a
deleted lift — eleven seeded defects, eleven kills. Writing
the checker was also where I found and fixed a real defect in my own first
version: the instantiation extractor matched `module word_counter (` and
reported `module` as an instantiated module, which would have been a permanent
false failure once REQ-018's whitelist mattered.

I made the scripts print `PENDING` rather than pass for a check whose subject
does not exist yet (`crc32_eth`, `nic_top`, `test/xgmii/`, and the whole §4
inventory). The alternative — passing vacuously — is the failure mode I called
out in WO-0003 as a method that cannot detect its own violation. `PENDING` lines
are counted, printed and explicitly disqualified from being cited as coverage in
a sign-off packet. The `word_counter` bootstrap allowance is the one place a
real module could hide from REQ-018's whitelist, so it is printed on every run
with "must be empty at P1-module-ready" attached.

**What I did not build, deliberately.** No `hardcaml_step_testbench` code: CI's
dependency install already proves it resolves, which was WO-0003 §13.4's actual
request, and writing a coroutine against an API no local build can check would
put compile risk on this work order for no coverage. No REQ-903 script: C-8
leaves it with no determinable answer for M01, and a check that cannot say
pass or fail is worse than an absent one, so the script's place in
`check_emitted_verilog.sh` is held by a `PENDING` line stating exactly what has
to be decided. No XGMII link-partner model: the WO puts it out of scope while
M03's spec is in flight, and its arrival scheduler depends on §0.3's alternation
which is settled but whose module-level consequences are not. No CI workflow
edit: `.github/**` is the orchestrator's scope, and the dune-rule alternative
inside my own scope was rejected because a dune action runs inside `_build`
where only declared dependencies exist, and a mistake there fails the whole
build in a way ADR-0005 leaves me unable to test.

### Actions
- Built `test/monitors/` (library `dv_monitors`): `stream_word`, `strobes`,
  `protocol_monitor`, `conservation_monitor`, `octet_time`, each with an `.mli`,
  plus thirty-two unit tests across three test modules.
- Built `test/golden/` (library `dv_golden`): the REQ-305 bit-serial CRC-32
  reference with its `.mli` and six anchor/property expect tests.
- Built `test/axi64_probe/` (library `dv_axi64_probe`): the single sanctioned
  `Axi64` import, `of_refs` and `of_source`.
- Built `test/cost_probe/`: the THROWAWAY Cyclesim cost probe, an executable on
  the `runtest` alias with `(deps (universe))`.
- Wrote `tools/check_records_vs_appendix.sh` (C-9: three fixed checks plus one
  discovered §4.1-versus-lift check per module spec),
  `tools/check_emitted_verilog.sh` (X-9, REQ-001/017/018/306/808) and
  `tools/dv_checks.sh` (runner and the documented CI-wiring recommendation).
- Verified the CRC algorithm by transliterating my OCaml into Python and
  reproducing every constant, then type-checked and ran the OCaml itself.
- Seeded eleven mutations across three scratch trees and confirmed the `tools/`
  scripts kill all eleven; fixed one real defect the exercise exposed.
- Left all thirty expect snapshots empty (ADR-0005 rule 2).
- Appended the RETURNED entry to `agents/handoffs/WO-0009_bench-machinery.md`
  and set its header state to RETURNED.
- Wrote nothing under `docs/`, `libs/`, `.github/`, `scripts/` or `tasks/`.

### Evidence
All commands runnable from a repo checkout at this SHA (PROTOCOL §4.1 form (a)),
from the repository root. The authoritative build/test verdict is CI's
(ADR-0005, REQ-906) and is **not** claimed here; what follows is what this
container can honestly establish.

1. **Both `tools/` scripts pass at this SHA** —
   `tools/dv_checks.sh; echo $?` → exit `0`, ending
   `dv_checks: all checks passed`. The C-9 half runs three fixed checks
   (`Status record = requirements.md §12 (21 strobes, same order, REQ-804)`;
   `Config record = requirements.md §9.1 (12 fields, widths equal in order,
   REQ-802)`; `test/monitors/strobes.ml = requirements.md §12`) plus one
   *discovered* §4.1-versus-lift check per `docs/specs/modules/*.md`, so its
   total moves with the spec set by design — a hardcoded batch-A pair list
   would stop checking the moment batch B landed. Against the two committed
   batch-A specs that is `5 check(s) run, 0 failure(s)`; the working tree I ran
   in also carried the architect's three uncommitted batch-B specs, giving
   `8 check(s) run, 0 failure(s)` with all five lifts byte identical. The X-9
   half reports `3 check(s) run, 0 failure(s), 5 pending`: PASS on REQ-001
   (`all 1 edge expression(s) resolve to clock`), on the REQ-018 whitelist and
   on the constraint-file sweep; PENDING on REQ-306, REQ-808, REQ-017, the
   `test/xgmii/` link partner and REQ-903.

2. **Mutation spot-check of the scripts, eleven seeded defects, eleven kills.**
   Reproduce by copying `tools docs test rtl_snapshots` to a scratch tree and
   applying: (a) `sed -i 's/error_start_without_terminate/error_start_without_terminator/' docs/specs/modules/axi64.md`;
   (b) `sed -i "s/; ttl : 'a \[@bits 8\]/; ttl : 'a [@bits 7]/" docs/specs/modules/axi64.md`;
   (c) `sed -i '/"error_udp_port"/d' test/monitors/strobes.ml`; (d)–(i) a
   `rtl_snapshots/seeded.v` containing a `crc32_eth` with a `clock` port and an
   `always @(posedge …)`, a `nic_top` whose XGMII ports are
   `xgmii_rxd/rxc/txd/spare` with an `always @(negedge …)` and a `RAMB36E1`
   instantiation, plus a top-level `nic.xdc`, and separately a
   `xilinx_clock_helper` module clocked off `assign _3 = _2 & 1'b1`.
   Observed: (a) `FAIL Status record != requirements.md §12` with the diff;
   (b) `FAIL Config record widths differ` (`8` vs `7`); (c) `FAIL
   test/monitors/strobes.ml differs from requirements.md §12`; (d) `FAIL
   REQ-306: emitted crc32_eth declares a clock port`; (e) `FAIL REQ-306: …
   contains an always @(posedge …) block`; (f) `FAIL REQ-001 … (negedge)`;
   (g) `FAIL REQ-018 whitelist: instantiation(s) outside the §4 inventory:
   RAMB36E1`; (h) `FAIL REQ-018: device constraint file(s) present`; (i) `FAIL
   REQ-017: nic_top's xgmii_* ports are [xgmii_rxc xgmii_rxd xgmii_spare
   xgmii_txd], expected [xgmii_rxc xgmii_rxd xgmii_txc xgmii_txd]`. The
   gated-clock tree additionally gave `FAIL REQ-001 … (edge signal _3 is not
   clock)` and `FAIL REQ-808: emitted module(s) not in the architecture.md §4
   inventory: xilinx_clock_helper`. Mutations (a) and (b) were also caught a
   second time by the §4.1-versus-lift check, which is the redundancy working.
   Two further mutations exercised the discovered lift check by itself:
   drifting one width inside `docs/specs/ifc_check/axi64_ifc.ml` gave `FAIL
   modules/axi64.md §4.1 == ifc_check/axi64_ifc.ml differs`, and deleting
   `ifc_check/crc32_eth_ifc.ml` gave `FAIL … the lift does not exist
   (SPEC-TEMPLATE rule 6)` rather than a silent skip. Eleven seeded defects in
   total, eleven kills.

3. **The six standard-library modules type-check clean and all thirty expect
   test bodies run green**, using the system OCaml 4.14.1 in this container.
   This is not a substitute for CI — the Hardcaml files are not covered and the
   ppx is stripped mechanically — but it is what makes the claim "these tests
   pass" mine rather than borrowed:
   ```
   T=$(mktemp -d)
   cp test/monitors/*.ml test/monitors/*.mli test/golden/*.ml test/golden/*.mli "$T"/
   ( cd "$T"
     W="-w +a-4-9-40-41-42-44-45-48-67-70"
     for m in stream_word strobes protocol_monitor conservation_monitor octet_time crc32_ref; do
       ocamlc $W -c "$m.mli" && ocamlc $W -c "$m.ml" || echo "MODULE FAILED: $m"; done
     for t in test_protocol_monitor test_conservation_monitor test_octet_time test_crc32_ref; do
       awk '/^let%expect_test /{n++; printf "let _t%d () =\n", n; next}
            {gsub(/\[%expect \{\| \|\}\]/, "()"); print}
            END{printf "let () = "; for (i=1;i<=n;i++) printf "_t%d (); ", i; printf "()\n"}' \
         "$t.ml" > "d_$t.ml"; done
     ocamlc $W -o a1 stream_word.cmo protocol_monitor.cmo d_test_protocol_monitor.ml && ./a1 | grep -c 'VERDICT ok'
     ocamlc $W -o a2 strobes.cmo conservation_monitor.cmo d_test_conservation_monitor.ml && ./a2 | grep -c 'VERDICT ok'
     ocamlc $W -o a3 stream_word.cmo octet_time.cmo d_test_octet_time.ml && ./a3 | grep -c 'VERDICT ok'
     ocamlc $W -o a4 crc32_ref.cmo d_test_crc32_ref.ml && ./a4 | grep -cE ' ok$|as REQ-202 requires$' )
   rm -rf "$T"
   ```
   → `modules type-checked` with **no warning from any of the twelve
   compilations**, then `10`, `7`, `5`, `27`. Every one of the four programs
   exited 0, which is the load-bearing part: each test raises on a wrong
   verdict, so a zero exit means every assertion held. (The counts are of
   printed verdict lines, not of tests: two of the twenty tests in the second
   and third suites print figures rather than a verdict.)

4. **CRC anchors, observed.** From the run above, `./a4` prints in order:
   `REQ-303 CRC32("123456789") 0xCBF43926 ok`; `CRC32(empty) … 0x00000000 ok`;
   `register_of_running 0 — REQ-301's initial value 0xFFFFFFFF ok`;
   `update 1: crc_in=0, 8 octets "12345678" 0x9AE0DAAF ok`;
   `update 2: … 0xCBF43926 ok`; `tdata packing of "12345678" (REQ-012)
   0x3837363534333231 ok`; `REQ-304 residue over {1,9,26,46,60,64,100,1500}-octet
   frame + its FCS 0x2144DF1C ok` (eight lines);
   `FCS appended most-significant-octet-first differs from the residue, as
   REQ-202 requires`; `serial-decomposition mismatches over 3000 cases 0 ok`;
   `cross-formulation mismatches over 3000 cases 0 ok`;
   `M04: 7x8 + 1x4 equals the whole-frame CRC … ok`;
   `M03: 8x8 over frame+FCS reaches REQ-304's residue 0x2144DF1C ok`;
   `REQ-303 in the raw-register convention 0x340BC6D9 ok`;
   `REQ-304 in the raw-register convention 0xDEBB20E3 ok`;
   `§4 provenance: register_of_running(residue) 0xC704DD7B ok`;
   `round trip running -> register -> running 0x2144DF1C ok`.
   The algorithm was independently transliterated into Python and cross-checked
   against `zlib.crc32` (which is exactly REQ-301's parameterisation) before the
   OCaml was written; that cross-check is a second opinion on my arithmetic and
   not the anchor, which is REQ-303's published constant.

5. **The D-4 regression, observed.** `./a3` prints
   `start lane 0: octet-time latencies 16; cycle-metric values 2` and
   `start lane 4: octet-time latencies 20; cycle-metric values 2;3` —
   reproducing `J-dv_lead-0002` Evidence item 1 exactly, now as a test that
   raises if the cycle metric ever stops taking two values inside a lane-4
   frame. Also `lane-0 L = 16, lane-4 L = 20, difference 4 octet times` (§0.5
   permits at most 8), and for the 14-octet stripping stage
   `L = 10 octet times; cycles_floor = 1; word_cycles = 3; 8(Co-Ci)-h = 10`,
   which is C-1's gap shown as a number.

6. **C-2 shown as a number.** `./a2` prints
   `pulses would give residual -1; frames give 0` on the co-occurring-strobe
   case: §0.6's equation read literally reports a surplus on a conformant
   design.

7. **All thirty snapshots are empty and none is hand-authored** —
   `grep -c '\[%expect {| |}\]' test/golden/test_crc32_ref.ml test/monitors/test_*.ml`
   → `6`, `8`, `6`, `10`; and
   `grep -h '%expect' test/golden/test_crc32_ref.ml test/monitors/test_*.ml | grep -v '\[%expect {| |}\]' | grep -c '\[%expect'`
   → `0`.

8. **The two Hardcaml-dependent files parse** —
   `ocamlc -stop-after parsing -c test/axi64_probe/axi64_probe.ml` and the same
   for `test/cost_probe/cyclesim_cost_probe.ml` → both silent. Type-checking
   them needs Hardcaml, which ADR-0005 makes impossible here; **no compile,
   elaboration or simulation claim is made for them**, and CI is the verdict.

9. **No CI run id is cited by me**, because this commit has not been pushed. The
   orchestrator's push produces it; per ADR-0005 and REQ-906 the DoD clause
   "everything compiles and its tests pass in CI" is discharged there and not
   here, and I say so rather than implying my local runs stand in for it.

### Outcome
DoD of WO-0009 met on every deliverable I can complete without a build
environment; the one clause I cannot discharge — CI green — is stated as such
rather than claimed. Twenty-five files created under `test/**` and `tools/**`,
nothing outside my write scope, `libs/**` unopened.

Deliverable status: (1) cost probe **done**, THROWAWAY-marked in four places,
figure to be read from the CI log with `grep COST-PROBE` and journalled with its
run id; (2) REQ-305 reference **done and anchored** on REQ-303's 0xCBF43926 and
REQ-304's 0x2144DF1C at eight lengths, in the charter §3 golden-model home;
(3) SPEC-M01 §6.1 protocol monitor **done**, Cyclesim-attachable through a
per-cycle closure, ten unit tests, §6.3-item-5 guards structural and falsified
by two of them; (4) conservation monitor and octet-time tagger **done** per
findings §13.3, with C-1, C-2 and C-3 landed inside the machinery as the WO
intended and the D-4 walk turned into a regression test; (5) C-9 and X-9 scripts
**done and mutation-checked**, REQ-903's script deliberately withheld behind a
`PENDING` line pending C-8.

Handoff: `agents/handoffs/WO-0009_bench-machinery.md`, state RETURNED, carrying
the per-deliverable detail, the empty-snapshot notice, the Axi64 import
justification, the CI-wiring recommendation and carry-forward C-11.

### Open-questions
1. **Thirty empty expect snapshots await CI promotion.** The first run after
   this commit is expected to fail `dune runtest` with thirty diffs; that diff
   is the promotion source (ADR-0005 rule 2). Nothing needs deciding — it needs
   doing, in a follow-up commit whose only content is the promoted blocks. Note
   the ordering risk: if dune stops scheduling at the first failure, the
   `COST-PROBE` lines may not appear until the run *after* promotion.
2. **`test/axi64_probe/` is the SPEC-M01 §11.4 experiment.** A green build
   discharges §11.4 and I will record it against the run id; a red one is
   §11.4's answer, the fix is editorial and confined to `axi64_probe.ml`, and
   dropping that one directory leaves every other deliverable green.
3. **`of_source` must be retargeted when rtl_lead builds M01.** It imports
   `Ifc_check.Axi64_ifc.Axi64` because `libs/hardcaml_ethernet/src/axi64.ml`
   does not exist at this SHA. Two applications of `Hardcaml_axi.Stream.Make`
   in one tree are incompatible types, so a bench mixing them will not compile;
   `of_refs` names no stream type and covers the interval. One line, but it
   must be scheduled, not discovered.
4. **New carry-forward C-11 — REQ-015 contradicts itself at the one-word
   frame**, and the wording is mine from WO-0003. Delete the second sentence or
   restate it as "a frame comprises at least one word, the `tlast` word
   included". Owner architect_docs_lead; must land before the first `SO-` cites
   the protocol monitor. Full argument in the WO-0009 Return log and at the top
   of `protocol_monitor.ml`.
5. **CI wiring for `tools/dv_checks.sh` is an orchestrator action.** One step in
   `.github/workflows/build.yml`, quoted verbatim in the script header. Until it
   lands, C-9 and X-9 are on-demand checks cited by SHA rather than continuous
   ones, which is weaker than REQ-904's precedent for exactly this class.
6. **Shared working tree.** `docs/specs/**` carries uncommitted modifications
   from the architect's parallel WO-0008. Everything here derives from the
   committed text (requirements.md at b4b4cf4, SPEC-M01/M02 at 22145b5); the
   orchestrator should stage only the paths listed below. One observation from
   running the scripts against the working tree: those edits appear to adopt C-1
   (ΔC = (L + h)/8 becoming normative). If so, `Octet_time.word_cycles` is
   already the normative conversion and no code changes — but C-1's ledger entry
   should be closed against that commit, by whoever owns the ledger, not
   silently by me.
7. **Unchanged and still open**: C-3 (top-level accounting of a zero-payload
   datagram — the monitor supports it, the arithmetic is still owed at the
   `nic_top` bench), C-4 … C-10 as recorded in the gate ledger, `hardcaml_verilator`
   plus a `verilator` binary against REQ-901, and the SPEC-TEMPLATE §11 versus
   FROZEN-flip conflict raised in `J-dv_lead-0003`.
8. **What this machinery still lacks before the first module bench.** The XGMII
   link-partner encoder/decoder and its arrival scheduler (findings §13.3 layer
   1, out of scope here pending SPEC-M03), the frame factory that turns a
   declarative frame description into the triple of wire octets, expected
   payload and expected strobe set (layer 2), and the scoreboard that binds the
   three monitors together at a module boundary (layer 3). Those are the next
   work order, and they are cheap now precisely because the layer under them is
   DUT-independent.

### Files-in-this-commit
- test/axi64_probe/axi64_probe.ml
- test/axi64_probe/dune
- test/cost_probe/cyclesim_cost_probe.ml
- test/cost_probe/dune
- test/golden/crc32_ref.ml
- test/golden/crc32_ref.mli
- test/golden/dune
- test/golden/test_crc32_ref.ml
- test/monitors/conservation_monitor.ml
- test/monitors/conservation_monitor.mli
- test/monitors/dune
- test/monitors/octet_time.ml
- test/monitors/octet_time.mli
- test/monitors/protocol_monitor.ml
- test/monitors/protocol_monitor.mli
- test/monitors/stream_word.ml
- test/monitors/stream_word.mli
- test/monitors/strobes.ml
- test/monitors/strobes.mli
- test/monitors/test_conservation_monitor.ml
- test/monitors/test_octet_time.ml
- test/monitors/test_protocol_monitor.ml
- tools/check_emitted_verilog.sh
- tools/check_records_vs_appendix.sh
- tools/dv_checks.sh
- agents/handoffs/WO-0009_bench-machinery.md

## [J-dv_lead-0005] 2026-08-02T09:20:00Z | task:WO-0010 | Dual-batch countersignature GRANTED at f78766e: M03/M04/M05 SIGNED, the §4.1 Xgmii addition accepted, the C-1 latency budget recomputed and sealed, six §9 rulings confirmed, C-11 disposed; C-12, C-13, C-14 raised

### Trigger
Orchestrator spawn under work order WO-0010 (ISSUED at f44a296), spawn short-id
`WO-0010/2026-08-02T08:55Z`. Fifth activation. This is the largest single freeze
decision of Phase 1 — five specifications, the sponsor-delegated receive-latency
budget, and the §9 rulings that will bind M03's bench — and my signature is the
only thing standing between the batch-B drafts and FROZEN.

### Inputs
- `agents/charters/dv_lead.md` (§5 DoD, §6 evaluation criteria refreshed);
  `agents/PROTOCOL.md` §4 (entry grammar), §7 (gates and the transcription
  rule), §10 (independence and evidence).
- `agents/handoffs/WO-0010_dual-batch-countersign.md` at f44a296 — my work
  order.
- **Review targets at f78766e**: `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03),
  `xgmii_tx_64.md` (SPEC-M04), `eth_mac_10g.md` (SPEC-M05), all DRAFT, read in
  full; `docs/specs/modules/axi64.md` and `crc32_eth.md` as revised, read in
  full and additionally diffed against 22145b5, the SHA my batch-A signature
  names; the five `docs/specs/ifc_check/*_ifc.ml` lifts.
- `docs/specs/requirements.md` as revised by WO-0008 — §0.3 through §0.7, §1.1,
  REQ-001 … REQ-021, REQ-101 … REQ-113, REQ-201 … REQ-210, REQ-301 … REQ-306,
  REQ-808, REQ-810, REQ-903; `docs/specs/traceability.md` (REQ-015, REQ-019 and
  the batch-B rows).
- `agents/handoffs/WO-0008_batch-b-specs.md` Return log — the deliverable
  dispositions, the C-1 resolution, the six §9 rulings and the ledger
  dispositions; `docs/gates/P1-spec-freeze-checklist.md` (C-1 … C-11, the
  batch-A superseded-evidence note, the sponsor's 2026-08-02 delegation).
- My own prior entries `J-dv_lead-0002` (D-4, the octet-time formulation),
  `J-dv_lead-0003` (batch-A signature at 22145b5) and `J-dv_lead-0004` (the
  bench machinery, C-11's provenance), and the machinery itself:
  `test/monitors/octet_time.{ml,mli}` and `conservation_monitor.mli`, re-read
  because (a) required judging the specs against their semantics.
- CI: runs 30729342467 and 30730405776, fetched through the GitHub API to
  confirm conclusion and head SHA rather than accepting them from the packet.
- **`libs/**` was never opened**, in this or any previous activation. Nothing
  in this verdict derives from RTL; `rtl_snapshots/**` was read only by
  `tools/dv_checks.sh`, as at WO-0009.

### Reasoning
**The standard I applied, stated first because every verdict below is an
application of it.** A testability countersignature answers one question: can a
tb_writer who never sees RTL build a correct bench from this text alone? So a
sentence that is merely inelegant is not my business, a sentence that leaves a
required test underivable is a contest, and a sentence that would make a bench
**fail a conformant design** is the defect class I care most about — it converts
into a false `BUG-` against rtl_lead, which costs the programme its credibility
in the direction that is hardest to recover. I found five of that last class
across the three specs. None of them is a contest, and the reason is uniform:
in every case a normative section of the *same* specification states the
correct reading, so the defect is that a summary sentence drifted from the
section it summarises. My remedy is to fix the reading in the countersignature
itself and require the diff, rather than to block a five-spec freeze on
sentences the document already corrects.

I weighed contesting SPEC-M04 on C-14.1 seriously — "`tx_tready` is 0 during
… the gap" is contradicted by its own §6.1 table, which shows `tready` = 1 at
C+11 inside the gap, and by REQ-209's cadence, which *requires* acceptance
there. What decided it for signing was precedent and proportion: at WO-0007 I
signed batch A while raising C-10, a dropped normative word ("solely") whose
absence would have made a monitor assert something false, because the correct
reading was recoverable and the architect fixed it before freeze. Treating a
weaker instance of the same class more harshly now would make my bar depend on
when the defect was found rather than on what it costs. What I refuse to do is
absorb the ambiguity silently by writing careful excerpts into the tb_writer
`WO-` — that hides a spec defect inside my own packet, and the whole point of
`Context provided` sections is that a leaked or papered-over reading is visible
in the diff. So each of the five is written down with the sentence that
misleads, the section that governs, and the reason, and each is tied to the
moment it must close: before the module's `WO-` leaves my hands.

**On C-1 I recomputed rather than checked, because the sponsor delegated a
decision and a delegated decision sealed on someone else's arithmetic is not
sealed.** I re-derived ΔC = (L + h)/8 from §0.5's octet-time definition
(L = 8·Co − (8·Ci + h), so ΔC = Co − Ci exactly), then re-derived the failure
of the old unit from scratch: taking the largest L each §1.1 ceiling admitted
under floor(L/8) subject to (L + h) ≡ 0 (mod 8) gives word delays 5/6, 5, 1, 8,
5 — 24 cycles at a lane-0 start and 25 at a lane-4 start, the second over
REQ-006's budget, with every module passing REQ-019. That reproduces the
architect's figures exactly, from the definitions, without reading its working.
The identity is mine from WO-0005 and the remedy is the architect's; I record
that I would not have reached the remedy myself — my instinct was to lower the
five ceilings, and the architect is right that this changes five numbers to
preserve a unit that is wrong.

I did not stop at coherence, because a spec can pin an arithmetically consistent
constant no design can hit. So I checked M03's ΔC = 3 for *achievability* from
§6.1's pipeline: the `tkeep` decision for output word m needs to know whether a
terminate character arrives at or before frame-octet index 8m+11, which lands
at input cycle m+2 at **both** start lanes (octet time 8m+19, lane 3, at a
lane-0 start; 8m+23, lane 7, at a lane-4 start), so one register after that
decision is cycle m+3. That is why the FCS lookahead is exactly one word, why
payload storage is two words and not three, and why the lane-4 realignment
costs no cycle — L differs by 4 and ΔC does not. The same check landed a
second result I did not expect: REQ-108's truncation at 1514 delivered octets
is 189 full words plus a two-octet word, i.e. exactly REQ-015's 190 with
`tkeep` = 0x03, and the oversize decision is available at the same +2 offset as
every other word. Three numbers written by different requirements agree to the
octet. That is the kind of coincidence that is not one, and it is most of why I
believe these constants were derived rather than chosen.

**Sealing the budget also means judging feasibility, since 17 allocated cycles
now bind five future modules.** M03 needs 3 and holds 4. M08's decision comes
from a header record and needs 1. M14's 5 is comfortable and I checked the one
thing that could have made it not: REQ-602 requires *discarding* a bad-checksum
datagram, and §0.6 requires a discard before the first emitted word — the
20-octet header completes at input word 2 while the first payload word cannot
leave before input word 3, so verify-before-emit costs M14 nothing beyond the
strip it already pays. M06 and M17 are where I would spend slack, and 7 cycles
covers both twice. I am content to seal on that.

**Where the specs' §9 tables meet my conservation monitor, the fit is better
than I expected, and I checked it rather than assumed it.** SPEC-M03 §9's
closing paragraph partitions its eight rows into forwarded-and-marked (1, 2, 4,
6, 7) and emits-nothing (3, 5, 8) — which is exactly the `frame_out
~aborted:true` versus `discarded ~strobes` distinction my monitor is built on,
and the distinction §0.6's literal equation does not make. Every zero-output row
carries exactly one strobe, so C-2's two-strobes-one-frame case arises only in
the forwarded class, where it costs the equation nothing. Ruling 6 lands on
machinery already committed: `frame_in_exempt ~reason` exists because REQ-810
says a frame refused while receive-enable is 0 creates no silent-discard hole,
and ruling 6 puts that gate in M03, which is where the exemption is observable.
Confirming rulings that my own code already assumes is the easy half; the half
that mattered was checking whether any ruling *contradicted* an assumption
buried in the machinery, and none does.

**C-12 is the one gap I found in the rulings, and it is a gap in the same shape
as ruling 2.** The architect enumerated `/S/` arriving during REQ-108's
`Discard` state and ruled it resynchronisation. It did not enumerate `/E/`
arriving there — and §9 row 2's condition text ("`/E/` between the start and
terminate characters, with ≥ 1 octet already delivered") still reads true after
the frame has been closed by truncation, while §6.2's `Discard` row lists only
`/T/` and `/S/` as exits. An attack plan for M03 will drive that case in its
first hour. I offer the ruling I would adopt — nothing pulses, for ruling 2's
own reason — rather than only the objection, because a ruling gap that comes
with a defensible answer costs the architect one line and a ruling gap that
comes as a complaint costs it a round trip.

**C-13 is the cost of the `Xgmii` record, and it is worth paying.** The record
is right: `d` and `c` under `xgmii_rx` / `xgmii_tx` emit REQ-017's four names
exactly and no longer field name can, and homing it in M01 kills four
restatements. But REQ-010's census sentence — "exactly one frame-carrying port
in the inventory is not a stream port", plus "any further non-stream
frame-carrying port is a spec diff to this row" — went from true to false in the
same commit, and the row was not diffed. Under REQ-002's own usage the XGMII
pairs are frame-carrying interfaces, so there are six, not one. I accept the
record and raise the census, because those are two separate decisions and
conflating them would either block a good record or let a false sentence freeze.

**On C-11 I am the defendant.** The contradictory sentence is mine, proposed in
WO-0003 and adopted verbatim. The 190-word figure settles the counting
convention beyond argument — 1514 octets is 189 full words plus 2, which is 190
only when the `tlast` word is counted — and under that convention my sentence
forbids the one-word frame that REQ-011 makes mandatory for any 1-to-8-octet
payload and that SPEC-M03 §9 requires outright for a 5-octet runt. I propose
deletion rather than restatement because the only shape the sentence could
forbid is `tlast` on a cycle carrying no word, which SPEC-M01 §6.3 item 5 puts
outside any monitor's reach and REQ-011 already forbids. Deleting a requirement
I wrote is cheaper than defending it, and the auditor should be able to see that
I applied the same standard to my own text that I applied to the architect's:
the defect class is identical to C-14's — a sentence that would fail a
conformant design — and it gets the same disposition.

**What I did not do.** I did not touch `docs/specs/**` to apply any of the
five editorial diffs, even though each is one clause and I could see exactly
what it should say: they are the architect's text and outside my write scope,
and a countersigner who edits the thing it is countersigning has signed nothing.
I did not fix the `Latency.create` parameter defect that this review exposed,
though it is my own code and inside my scope, because the packet fixes this
commit's file set at one packet and a signature commit that also carries a code
change makes the signature harder to audit; it is listed as a DV action and
lands in the next work order, before any M03 bench can quote a wrong ΔC.

### Actions
- Read the three batch-B specifications and the two revised batch-A
  specifications in full; diffed both batch-A specs and both batch-A lifts
  against 22145b5 before extending my batch-A signature.
- Recomputed the C-1 identity, the M03 lane-0/lane-4 constants, the ΔC = 3
  feasibility argument at both start lanes, the floor(L/8) failure (24 and 25
  cycles), the §1.1 allocation and closure checks, the REQ-108 190-word/0x03
  landing, SPEC-M03 §8's arrival schedule, SPEC-M04's gap formula and 11-cycle
  cadence, SPEC-M04's underflow sequencing, and SPEC-M03's drain-window bound.
- Judged the six §9 rulings against requirements.md and against my committed
  monitors; confirmed all six and identified two as compelled rather than
  chosen (rulings 2 and 4).
- Confirmed both CI runs through the GitHub API; ran `tools/dv_checks.sh` at
  f44a296.
- Appended the RETURNED verdict entry to
  `agents/handoffs/WO-0010_dual-batch-countersign.md` and set its header state
  to RETURNED.
- Wrote nothing under `docs/`, `libs/`, `test/`, `tools/`, `.github/`,
  `scripts/` or `tasks/`.

### Evidence
All commands runnable from a repo checkout at this SHA (PROTOCOL §4.1 form (a))
or externally verifiable references (form (b)).

1. **Compile evidence, verified at source rather than relayed.** GitHub API,
   `renatom11/agentic-fpga`: run **30729342467**, workflow `build`, `head_sha`
   `f78766e9b8306f43c8823ec5e61b42cc381a6203`, status `completed`, conclusion
   **`success`**; run **30730405776**, `head_sha`
   `00d7a7f3af0dddd7c641bed34af3653a70bfcca2`, conclusion **`success`**. The
   first is SPEC-M01 §11.4's closure record: the M03 lift names all six
   `Axi64.Source` fields and the M04 lift names `Dest.tready` in compile-time
   witnesses, so a `hardcaml_axi` v0.17.0 spelling divergence would have failed
   that build. SPEC-M03 §11.1 and SPEC-M04 §11.1 close with it.
2. **`tools/dv_checks.sh` at f44a296** → exit `0`, `dv_checks: all checks
   passed`. C-9 half: `8 check(s) run, 0 failure(s)`, including all five
   `modules/<spec>.md §4.1 == ifc_check/<spec>_ifc.ml (byte identical)` rows —
   so the five §4.1 blocks I judged are the five CI elaborated — plus `Status
   record = requirements.md §12 (21 strobes, same order)` and `Config record =
   requirements.md §9.1 (12 fields, widths equal in order)`. X-9 half:
   `3 check(s) run, 0 failure(s), 5 pending`.
3. **The batch-A diffs I extended my signature over**:
   `git diff 22145b5 f78766e -- docs/specs/ifc_check/axi64_ifc.ml` → the
   `Xgmii` record and nothing else (18 lines added, none removed);
   `git diff --stat 22145b5 f78766e -- docs/specs/modules/axi64.md
   docs/specs/modules/crc32_eth.md` → 149 and 60 lines changed, all of which
   are the §11 reconciliation, C-8, C-9, C-10, the record's §4.2/§6.1
   companions, the `cfg_<field>` convention paragraph, and — in SPEC-M02 — the
   REQ-010 narrowing that my batch-A signature was conditioned on, now
   discharged against committed text.
4. **C-1, reproduced.** ΔC = (L + h)/8 from §0.5's definitions. M03: h = 8,
   ΔC = 3, L = 16, L + h = 24 (lane 0); h = 12, ΔC = 3, L = 12, L + h = 24
   (lane 4); both close mod 8 and both sit one under the ceiling of 4. Old
   unit, largest admissible L per stage subject to (L + h) ≡ 0 (mod 8):
   32→5 / 36→6, 26→5, 8→1, 44→8, 32→5, summing to **24 (lane 0) and 25
   (lane 4)** against a 24-cycle budget. New unit: 4 + 3 + 1 + 5 + 4 = **17**,
   slack **7**. Start-lane bound: L0 − L4 = 8(ΔC0 − ΔC4) + 4 is ±4 for
   ΔC4 ∈ {ΔC0, ΔC0 + 1} and ±12 — outside REQ-111's 8-octet-time bound — for
   anything else, so §0.5's new pair statement is exactly equivalent to the
   bound it replaces.
5. **SPEC-M03 §8's stimulus, checked to the octet.** 8 preamble + 64 frame
   octets = 72; terminate at octet time 72; +12 gap ⇒ next start at octet time
   84 = cycle 10, lane 4; the following start at 168 = cycle 21, lane 0.
   Start-to-start 10, 11, 10, 11 … with lanes alternating 0, 4, 0 — §0.3's
   84-octet budget and REQ-004's alternation from one arithmetic.
6. **Drain window, the tight bound.** With N = 8q + r octets between `/S/` and
   `/T/`: at a lane-0 start the terminate word is cycle q+1 and the `tlast`
   word is q+2 for r ≤ 4, q+3 for r ≥ 5; at a lane-4 start the difference is 1
   (r ≤ 3, r ≥ 5) or 0 (r = 4). Maximum **2 = ΔC − 1**, which is what §10's
   REQ-109 hook already asserts and what SPEC-M03 §6.1 states one cycle
   loosely.
7. **SPEC-M04, checked to the cycle.** Preamble at C+1 and the next at C+12 ⇒
   11 cycles (REQ-209); terminate at C+10 lane 0 ⇒ gap 16 octets from the
   terminate inclusive and 88 octets between start characters (REQ-204's
   verification figure); gap formula g = ⌈(`cfg_ifg` + t)/8⌉ gives 8g − t ≥
   `cfg_ifg` for every t and lands the next start on lane 0, yielding 16 at
   t = 0 and 12 at t = 4 as §6.1 claims. Underflow at cycle U: words accepted
   at U−2 and U−1 transmit at U and U+1, and the `/E/` `/T/` word takes the
   missing word's slot at U+2 — §9's "two cycles later", exactly.
8. **The machinery defect this review found, stated as a number.**
   `Latency.report` computes `word_cycles ~strip_octets` from the same field it
   uses for octet correspondence; at M03's lane-4 start those are 8 and 12
   respectively, so a conformant lane-4 frame with L = 12 would be reported as
   ΔC = (12 + 8)/8 = **2** against a pinned 3. No packet has quoted it yet; it
   is fixed before one can.
9. **No new CI run is cited for this commit** — it carries one packet and my
   journal, no code and no spec, so there is nothing for a build to verify
   beyond the journal check itself.

### Outcome
DoD of WO-0010 met on all five verdict groups, with the signature decision
explicit.

> **I countersign batches A and B (SPEC-M01, SPEC-M02, SPEC-M03, SPEC-M04, SPEC-M05) for P1-spec-freeze at f78766e.**

I further seal the sponsor-delegated receive-latency budget (board, 2026-08-02):
the normative unit is the word delay ΔC = (L + h)/8, the §1.1 allocation stands
at 4/3/1/5/4 = 17 cycles against REQ-006's 24, and the architect's 7 cycles of
slack are real. C-1 is closed and nothing further on it goes to the sponsor.

Verdicts: SPEC-M03 SIGNED, SPEC-M04 SIGNED, SPEC-M05 SIGNED; the SPEC-M01 §4.1
`Xgmii` addition ACCEPTED and my batch-A signature extended over it and over
SPEC-M02's revision; the six §9 rulings CONFIRMED (rulings 2 and 4 compelled by
REQ-108 and REQ-207 rather than chosen); C-11 disposed with replacement text.
Three new carry-forwards raised — C-12 (`/E/` during REQ-108's `Discard`),
C-13 (REQ-010's census versus the `Xgmii` record), C-14 (five readings, each of
which would otherwise commission an assertion that fails a conformant design) —
none blocking, each tied to the moment it must close.

Handoff: `agents/handoffs/WO-0010_dual-batch-countersign.md`, state RETURNED,
carrying the verdict table, the recomputations, the readings this signature
fixes, the ledger dispositions for the orchestrator to transcribe, and the four
DV actions this review created for me.

### Open-questions
1. **C-12 needs a ruling before `AP-xgmii_rx_64.md` is committed.** Until it
   lands, the attack-plan row for an error character arriving during REQ-108's
   `Discard` state is marked NO-ASSERT — a declared gap, not a silent one.
2. **C-14's five diffs are each tied to a module's tb_writer `WO-`.** If one
   has not landed when I draft that packet, I will say so in the packet's
   `Context provided` rather than route around it with a careful excerpt.
3. **`Latency.create`'s two quantities must be separated** (octet
   correspondence versus §0.5's h) and `word_cycles` must refuse
   (L + h) mod 8 ≠ 0 rather than truncating. Both land before the first M03
   bench; item 8 of Evidence is the failure they prevent.
4. **The REQ-903 half of `tools/check_emitted_verilog.sh` is now unblocked** by
   C-8's closure and is mine to finish; it has printed PENDING since WO-0009.
5. **The link-partner model is now fully specified and is the next bench work
   order**: SPEC-M03 §8's alternation, §0.3's budget and the 10/11 cadence
   agree to the octet, and SPEC-M04 §6.1 gives the transmit-side decoder its
   expectations. Also still owed: the frame factory and the scoreboard
   (findings §13.3 layers 2 and 3).
6. **`of_source` still imports `Ifc_check.Axi64_ifc.Axi64`** and must be
   retargeted when rtl_lead builds M01 — unchanged from `J-dv_lead-0004`, and
   now more urgent because M01 is frozen and buildable.
7. **Still open and unchanged**: C-2, C-3, C-5, C-6, C-7 as recorded in the
   gate ledger; `hardcaml_verilator` plus a `verilator` binary against REQ-901.

### Files-in-this-commit
- agents/handoffs/WO-0010_dual-batch-countersign.md

## [J-dv_lead-0006] 2026-08-02T11:05:00Z | task:WO-0012 | Tagger fix landed with the regression that proves both formulations on one trace; XGMII link-partner model (emitter + transmit decoder) built from FROZEN text; REQ-903 check implemented — 24 snapshots left empty for CI promotion

### Trigger
Orchestrator spawn under work order WO-0012 (ISSUED at 482b03a), spawn short-id
`WO-0012/2026-08-02T09:50Z`. Sixth activation. Three deliverables: the fix for
the `Latency.create` defect I found against my own machinery at WO-0010, the
XGMII link-partner model every Phase-1 receive bench will drive, and the REQ-903
half of `tools/check_emitted_verilog.sh` that C-8's closure unblocked.

### Inputs
- `agents/charters/dv_lead.md` (§3 delegation and golden-model rules, §5 DoD,
  §9 honest-enforcement note); `agents/PROTOCOL.md` §4 (entry grammar), §6
  (write scopes), §10 (independence and evidence).
- `agents/handoffs/WO-0012_dv-wave2.md` at 482b03a — my work order; and my own
  `agents/handoffs/WO-0010_dual-batch-countersign.md` Return log, whose "DV
  actions" items 1–4 are three of this commit's deliverables.
- **FROZEN spec text at f78766e, which is byte-identical to HEAD (482b03a) for
  every file I cite**: `docs/specs/requirements.md` §0.3 (the gap convention,
  the DIC paragraph, the 84-octet budget), §0.4, §0.5 (octet time, front offset
  h, word delay ΔC, the start-lane pair rule), §0.6, §0.7, §1.1, REQ-004,
  REQ-005, REQ-011, REQ-012, REQ-016, REQ-018, REQ-019, REQ-020, REQ-021,
  REQ-101 … REQ-113, REQ-201 … REQ-210, REQ-301 … REQ-305, REQ-903, §12;
  `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2, §6.3, §7, §8, §9, §10;
  `docs/specs/modules/xgmii_tx_64.md` §4.3, §6.1, §6.2, §6.3, §7, §9, §10;
  `docs/specs/architecture.md` §4 (the inventory table and its "modules live
  under `libs/hardcaml_ethernet/src/`" sentence).
- My committed machinery, re-read before changing it:
  `test/monitors/octet_time.{ml,mli}`, `stream_word.mli`,
  `conservation_monitor.mli`, `protocol_monitor.mli`, `strobes.mli`,
  `test/golden/crc32_ref.mli`, `test/axi64_probe/dune`, `tools/*.sh`, and the
  four `dune` files whose conventions the new library follows.
- `docs/adr/ADR-0005-build-environment.md` (CI is the authoritative build;
  snapshots are promoted from CI's diff, never authored).
- **`libs/**` was never opened**, in this or any previous activation. The one
  new place any DV artefact touches that tree is the REQ-903 check, which tests
  for the existence of `.mli` files and greps them for a single declaration;
  the boundary and its justification are written into the script's header and
  argued below.

**Independence note on a shared working tree.** `git status` shows the
architect's *uncommitted* WO-0011 edits to `docs/specs/**` in the same tree.
Before deriving anything I diffed every specification I cite against HEAD. The
in-flight edits are the C-11, C-12, C-13 and C-14 repairs I myself
commissioned at WO-0010 plus the FROZEN status flips; **none of them touches a
row this commit derives from** — SPEC-M03 §7's constants, §8's stimulus,
§0.3, §0.5, §1.1, REQ-004, REQ-021, REQ-201 … REQ-206 and REQ-903 are all
unchanged. Everything here is derived from committed FROZEN text, and where a
comment mentions C-12 it says "as of this commit", because the ruling that
closes it is drafted but not committed and I may not derive from uncountersigned
draft text.

### Reasoning

**1. The tagger defect was a naming conflation, and naming it properly is most
of the fix.** `Latency.create ~strip_octets` was one parameter doing three
jobs: octet correspondence (output octet j is input octet j + 8 at M03), the
front offset h that §0.5's word delay ΔC = (L + h)/8 is computed from, and — by
omission — the frame's length change. They coincide at every stream-to-stream
stripping stage in Phase 1, which is why the unit tests never saw it, and they
part company at exactly the module the machinery exists for. So I split them
into three named parameters rather than two: `~strip_octets`, `~tail_octets`
and `~front_offsets`. The tail is not padding of the deliverable — without it
M03's own frame **cannot be handed to the tagger without lying about its input
trace**, because REQ-103 removes four octets from the back as well as eight from
the front, and the old contract could only express a leading strip. A tagger
that cannot express M03 is not a tagger for M03.

**2. h cannot be a static parameter, and finding that out is what made this
more than a one-line fix.** §0.5 states h as "(the octets the module removes
from the front) + (the position, within the input word named by the measurement
event, of the frame's first octet)" — so at M03 it is 8 at a lane-0 start and
**12** at a lane-4 start. SPEC-M03 §8's stress schedule alternates the start
lanes. Therefore h varies **per frame** inside a single run, and no create-time
constant can be right for that run. The tagger now computes the observed h from
each frame's own trace — `in_times.(strip) − 8 × (in_times.(0) / 8)`, the §0.5
definition verbatim — and reports a value outside the spec-declared set as an
error. That turns REQ-019's second check ("the measured latency converted the
same way, **with h taken from the spec**") from a clerical step in a sign-off
packet into a mechanical one, which is what C-1's closure said the cost would
be.

**3. Pulling that thread found a second defect of the D-4 class, and I fixed it
rather than shipping the narrow repair.** If h varies per frame then L varies
too — 16 at a lane-0 start, 12 at a lane-4 start, differing by 4 exactly as
§0.5's "Start lanes" paragraph says. The old `is_constant` demanded a single L
over the whole run, so **a conformant M03 would have failed REQ-005 on its
second frame** of the §8 stress. That is precisely the defect class D-4 was
(a monitor that fails a conformant design), and it was sitting behind the same
parameter. Constancy is now evaluated within each front-offset class, and the
relation between classes is checked against §0.5's own bound: ordered by
ascending h, ΔC(larger) ∈ {ΔC(smaller), ΔC(smaller) + 1}. SPEC-M03 §8's check 3
already asks for exactly this ("one value per start lane across all 10 000
frames, not a mean"), so the specification was on the corrected side and only
my code was not. The *definition* paragraph of §0.5 is not, and that is the one
carry-forward this work created — see Open-questions.

**4. `word_cycles` refuses instead of truncating, and the regression shows why
that matters on the same trace.** §0.5 makes the closure normative: ΔC is a
whole number, so (L + h) is a multiple of 8 for every conformant module and a
spec pinning an L for which it is not "describes a module that cannot exist".
The old helper divided and truncated, which is what let the wrong pairing print
a plausible number rather than object: (12 + 8)/8 = 2 for a frame whose true
word delay is 3. The new helper returns `None` for that pairing. I discovered,
by running the regression, that this makes the obvious formulation of the test
useless — calling the *fixed* helper with the *wrong* offset yields `None`, not
2, so the test would have demonstrated nothing about what the old code did. The
regression therefore restates the removed formula verbatim, truncation included,
and prints both numbers off one trace: conflated = 2, fixed = 3, with the fixed
helper's refusal shown as a third column. It also runs the same comparison at a
lane-0 start, where conflated = fixed = 3 — the line that explains why nobody
caught this: the defect was wrong for exactly one start lane of one module.

**5. The link-partner emitter is a total function of octet time, and that is a
design decision worth defending.** The alternative was a stateful generator
walking a schedule cycle by cycle. I rejected it: a bench may sample a cycle
more than once or out of order (a `hardcaml_step_testbench` coroutine does),
and a stimulus generator with hidden state can then disagree with itself. Here
`word_at ~cycle` maps each of the eight octet times through one binary search
over the frame table and one classification — start character, preamble octet,
frame octet, terminate character, idle. There is no FSM to get wrong, the model
is re-entrant, and the same function serves a 10 000-frame run and a six-frame
unit test.

**6. The §8 schedule is arithmetic, so the tests assert REQ-004 against the
requirement rather than against the generator.** Nothing in the scheduler is
told to alternate start lanes. §0.3's convention — twelve octets counted from
the terminate character **inclusive** — puts 8 + 64 + 12 = 84 octet times
between start characters; 84 is not a multiple of 8, so the lane alternates
0, 4, 0, 4, and it is not a whole number of cycles, so the spacing alternates
10 and 11. Both are REQ-004's own figures and both come out of the gap
arithmetic. A generator that was *instructed* to alternate would have made the
alternation untestable — it would assert its own input back to itself.

**7. Deficit idle count is implemented from §0.3's two sentences and nothing
else.** §0.3 gives exactly two constraints: a start character may occupy only
lane 0 or lane 4 so a gap is rounded **up** to a multiple of four octets, and
the partner may shorten a later gap — **never below 9** — so the average stays
12. I implemented that as a rounding credit banked and spent, and deliberately
did **not** implement IEEE 802.3 clause 46's deficit counter, because clause 46
is referenced by the specification but not stated in it, and a model carrying
detail its spec does not state is a model that can be right in a way no
requirement can check. The §8 schedule never exercises the path (84 is already
a multiple of 4, so the credit never moves), which is exactly why the DIC case
gets its own hand-built schedule with a 65-octet frame.

**8. The generator checks itself, because a stimulus nobody verified is an
unverified assertion about the design.** `Arrival.check` re-derives the model's
contract from §0.3 and REQ-101 — start lanes in {0, 4}, no gap below the 9-octet
floor, a running average never below `ifg`, no overlapping frames — and verifies
**REQ-304's residue over every frame**, which is the check M03 itself performs.
So a frame this model believes valid is provably one M03 must accept, before any
design exists. `~fcs_valid:false` exists so an injection schedule narrows that
check to the frames it deliberately corrupts instead of weakening it for
everyone; the alternative (dropping the check) is how a bad stimulus becomes a
false `BUG-` against rtl_lead.

**9. The transmit decoder judges what a wire can carry and reports what it
cannot.** REQ-201, REQ-202, REQ-203, REQ-204, REQ-205 and REQ-206 are decidable
from the XGMII words alone and are judged, each violation naming its REQ.
REQ-209 is not: "one frame per 11 cycles and no spacing differing from 11" is a
property of a run of minimum-length frames, and only the bench that chose the
lengths may assert it — so the decoder exposes `start_spacings` and judges
nothing. REQ-207 needs the accepted source words, which are not on the wire.
And on an underflowed frame I deliberately do **not** assert REQ-202 or
REQ-203: §9 says no FCS is appended, and its own argument is that appending one
would put a well-formed short frame on the wire; a bench asserting the FCS
there would be demanding the defect the clause exists to prevent.

**10. Two models derived from different sections have to agree on one wire, and
that is the strongest check available without a DUT.** `Arrival` comes from
§0.3 and SPEC-M03 §8; `Tx_decoder` comes from SPEC-M04 §6.1 and §9. Parameterised
with the gap M04's REQ-204 rounding produces for a minimum frame terminating in
lane 0 — 16 octets — the emitter reproduces §6.1's cycle table exactly: start
characters in lane 0, 11 cycles and 88 octet times apart, terminate in lane 0,
FCS matching the REQ-305 oracle, zero violations. And feeding the *receive*
schedule to the transmit decoder produces exactly two REQ-201 violations for its
two lane-4 starts, which is the cheapest available proof that the check is not
vacuous — and documents why the link partner is two models rather than one
loopback.

**11. REQ-903 required deciding where the independence line actually is, and I
would rather argue it than route around it.** REQ-903's subject is the module
*surface*, and the artefact carrying it is the `.mli`. Its verification column
asks for "a mechanical repository check … in two parts". No reading of
`rtl_snapshots/` can answer part (b). So the check opens `.mli` files — never a
`.ml` — greps one declaration, and prints verdicts and module names, never file
contents. Nothing in `test/**` derives anything from those files. I judge that
inside PROTOCOL §10 rather than beside it, because §10 forbids deriving *tests*
from RTL and this derives a *process check* from requirements.md; but it is a
line worth stating out loud in the script header rather than crossing quietly,
and if the auditor reads it differently the remedy is to move this one check to
rtl_lead's scope, which costs nothing already built.

The one design choice inside it: a module with no `.mli` **fails** when its
Verilog has been emitted and is **pending** when it has not. Using the emitted
module set as the "is it built" oracle keeps the check honest before any RTL
exists without letting it go silent afterwards — the same shape as the REQ-808
row above it. M01 is the exception on both halves: it owes the `.mli` (it is
what fixes which records are exported, and every other module's REQ-010 check
binds to it) and not the entry point, and an M01 that *does* export
`hierarchical` gets a note rather than a failure, because REQ-903 excuses M01
from the entry point and does not forbid it.

**12. What I did not do.** I did not write the error-injection catalogue REQ-018
also names (REQ-104, REQ-105, REQ-107, REQ-108, REQ-110). My charter §3 requires
the attack plan to be committed *before* testing of a module starts, and an
injection catalogue written first is a catalogue whose adversarial coverage
nobody has reviewed; one of its rows (an error character during REQ-108's
`Discard`) is also C-12 and is NO-ASSERT until requirements.md settles it. The
frame builder and the emitter are shaped so injection is additive — a corrupted
frame and `~fcs_valid:false` already work today, and the unit test for the
self-check uses them. I also did not build the Hardcaml probe that binds
`Xgmii_word.to_wire` to a live `Xgmii` port: there is no port to bind to until
M03 exists, and ADR-0005 makes an unbuildable probe pure compile risk for no
coverage — the same reasoning that kept `hardcaml_step_testbench` out of
WO-0009.

### Actions
- Rewrote `test/monitors/octet_time.{ml,mli}`: `word_cycles` now takes
  `~front_offset` and returns `int option`; added `front_offset
  ~strip_octets ~start_lane`; `Latency.create` takes `~strip_octets`,
  `~tail_octets`, `~front_offsets` and an optional `?ceiling`; added the
  per-front-offset `observed` record, `word_delay`, the REQ-021 word-alignment
  check, the §0.5 closure and start-lane-pair checks, and the REQ-019 ceiling
  comparison; `report` now prints one line per start-lane class and no longer
  quotes the superseded `floor (L / 8)`.
- Rewrote `test/monitors/test_octet_time.ml`: five new cases (the WO-0010
  divergent case; the §8 alternating-lane run; the start-lane bound; a producer
  that does not realign; an undeclared front offset) and every existing case
  updated to the new contract, with numeric assertions in OCaml so no verdict
  depends on a promoted snapshot.
- Created `test/xgmii/` — `dune`, `xgmii_word.{ml,mli}`, `frame.{ml,mli}`,
  `arrival.{ml,mli}`, `tx_decoder.{ml,mli}` and three test files
  (`test_frame.ml`, `test_arrival.ml`, `test_tx_decoder.ml`), library
  `dv_xgmii`, depending on `dv_golden` (the REQ-305 FCS oracle) and
  `dv_monitors` (the octet-time cross-check) and on no Hardcaml.
- Implemented REQ-903 in `tools/check_emitted_verilog.sh` (single inventory
  parser now serving REQ-808, REQ-018 and REQ-903; the check itself in a
  function so it also runs on the two paths where `rtl_snapshots/` is absent),
  and updated the REQ-903 line in `tools/dv_checks.sh`.
- Appended the RETURNED entry to `agents/handoffs/WO-0012_dv-wave2.md` and set
  its header state to RETURNED.
- Wrote nothing under `docs/`, `libs/`, `top/`, `bin/`, `rtl_snapshots/`,
  `.github/`, `scripts/` or `tasks/`.

### Evidence
Form (a) commands are runnable from a checkout at this SHA. The OCaml
correctness claim is **not** made here: ADR-0005 and REQ-906 put it in CI, and
the authoritative evidence is the `build` run on the orchestrator's push of
this commit.

1. **`tools/dv_checks.sh` at this working tree** → exit `0`,
   `dv_checks: all checks passed`. C-9 half: `12 check(s) run, 0 failure(s)`.
   X-9 half: `4 check(s) run, 0 failure(s), 4 pending` — up from 3 checks and
   5 pending at f44a296, because REQ-903 is now a real check and
   `REQ-018: the XGMII link-partner model lives under test/ (test/xgmii/)`
   flipped from PENDING to **PASS**. The REQ-903 line reads
   `PENDING  REQ-903: 0 of 20 inventory module(s) have an .mli; not written
   yet: axi64 crc32_eth …` — twenty names, M01 included, which is the census
   REQ-903 quantifies over.
2. **REQ-903 exercised against defects, because a check nobody has seen fail is
   a check nobody has verified.** Reproduce by building a synthetic tree —
   copy `tools/check_emitted_verilog.sh` and `docs/specs/architecture.md` into
   an empty root, create `libs/hardcaml_ethernet/src/<name>.mli` per inventory
   row and an `rtl_snapshots/*.v` declaring `module <name>` for the nineteen
   non-M01 rows — and then:

   | Case | Result |
   |---|---|
   | all 20 `.mli` present, `hierarchical` in the 19 non-M01 ones | `PASS REQ-903: .mli for all 20 inventory module(s), M01 included; hierarchical exported by all but M01` |
   | `xgmii_rx_64.mli` deleted while `xgmii_rx_64` is emitted | `FAIL REQ-903(a): emitted module(s) with no .mli: xgmii_rx_64` |
   | `udp_ip_rx_64.mli` without `val hierarchical` | `FAIL REQ-903(b): .mli(s) not exporting hierarchical: udp_ip_rx_64` |
   | `axi64.mli` exporting `hierarchical` | PASS plus a note; not a failure |

   Script exit is non-zero in the two FAIL cases. The synthetic tree itself is
   **ephemeral** (an uncommitted scratch directory, ADR-0003/F5); the recipe
   above is what reproduces it.
3. **A local type-check and test-body run, offered as risk reduction and
   explicitly NOT as evidence of correctness.** The container has `ocamlc`
   **4.14.1**, which is not ADR-0004's pinned toolchain and cannot build
   Hardcaml or run `ppx_expect`. Every module in `dv_monitors`, `dv_golden` and
   `dv_xgmii` is plain stdlib OCaml, so in an ephemeral scratch directory I
   compiled them under dune's dev-profile warning set as errors
   (`-w '@1..3@5..28@30..39@43@46..47@49..57@61..62@67@69-40…-70'
   -strict-sequence -strict-formats`) — clean — and executed the test bodies
   with the `let%expect_test`/`[%expect]` extensions mechanically stripped. All
   twenty-four cases printed `VERDICT ok`. This caught three real defects
   before CI: a record-field ambiguity in `Tx_decoder.report`, the wrong
   expected value in the divergent-case regression (see Reasoning 4), and a
   start-lane sequence I had predicted wrongly by hand in the DIC case. It is
   not evidence under REQ-906 — the pinned compiler is 5.1, the snapshots are
   unpromoted, and no expect block was evaluated. **CI is the verdict.**
4. **The numbers the fixed tagger reports for M03, from the specification's own
   constants.** Lane 0: h = 8, L = 16, ΔC = 3 ≤ ceiling 4. Lane 4: h = 12,
   L = 12, ΔC = 3 ≤ 4. (L + h) = 24 in both rows. The removed formulation gives
   3 at lane 0 and **2** at lane 4. Over a six-frame alternating run the tagger
   reports two classes, two distinct L values and one word delay — and
   `constant` is `None`, which is correct and is why a sign-off packet must
   quote `word_delay` and the per-class table.
5. **The link partner's own figures, all asserted in code.** §8 schedule, six
   frames: start lanes `0 4 0 4 0 4`; start-to-start cycles `10 11 10 11 10`;
   gaps `12 12 12 12 12`; 84 octet times between start characters. DIC schedule,
   six 65-octet frames: start octet times 8, 96, 180, 264, 348, 436 (every one a
   legal lane-0/lane-4 position); gaps `15 11 11 11 15`, minimum 11 ≥ 9, total
   63 ≥ 5 × 12. Transmit side, `ifg = 16`: two frames, zero violations, start
   cycles 1 and 12, spacing 11, gap 16, 88 octet times — SPEC-M04 §6.1's table
   and REQ-204's verification figure, reproduced by a model that was never told
   them.
6. **Snapshots left empty for CI promotion: 24.** `test/monitors/
   test_octet_time.ml` 10 of 11 (the octet-time arithmetic case keeps its
   promoted snapshot — nothing it prints changed); `test/xgmii/test_frame.ml`
   4; `test_arrival.ml` 5; `test_tx_decoder.ml` 5. Count with
   `grep -c '\[%expect {| |}\]' test/monitors/test_octet_time.ml
   test/xgmii/test_*.ml`. The `build` workflow's
   `git diff --cached --exit-code` step will fail on this push and its printed
   diff **is** the promotion source (ADR-0005 rule 2).
7. **Independence.** `libs/**` unopened. The `.mli` reads the REQ-903 check
   performs are bounded and argued in Reasoning 11 and in the script header.
   Every specification cited was diffed against HEAD first (`git diff HEAD --
   docs/specs/...`) to confirm that the architect's in-flight WO-0011 edits
   touch no row this commit derives from.

### Outcome
DoD of WO-0012 met on all three deliverables.

1. **Tagger fixed with its regression.** The three quantities are separate and
   named; ΔC reports 3 for a conformant M03 lane-4 frame; the regression drives
   exactly the WO-0010 trace and shows the removed formulation giving 2 and the
   new one giving 3 on it, plus the refusal that replaces the truncation. A
   second defect of the same class — single-L constancy over an
   alternating-lane run — was found and fixed with it.
2. **Link-partner model committed, DUT-independent**, under `test/xgmii/`:
   REQ-018's first clause (the arrival scheduler and emitter, SPEC-M03 §8's
   schedule at the REQ-004 rate) and its third (the transmit decoder validating
   REQ-201 … REQ-206). The second clause, error injection, is declared open and
   tied to `AP-xgmii_rx_64.md`. Fourteen unit tests on hand-built schedules.
3. **REQ-903 implemented**, both halves, with its M01 exclusion stated in
   REQ-903's own terms; PENDING until rtl_lead writes the modules, FAIL the
   moment an emitted module ships without a surface.

Handoff: `agents/handoffs/WO-0012_dv-wave2.md`, state RETURNED, listing the
snapshots awaiting promotion and one proposed carry-forward.

### Open-questions
1. **Twenty-four snapshots await CI promotion** (Evidence 6). No sign-off packet
   may cite this test suite until they are promoted and `git diff --exit-code`
   is clean at the promoting SHA.
2. **Proposed carry-forward C-15 (editorial, non-blocking, requirements.md
   §0.5).** The "Latency" paragraph defines constant latency as "a single
   constant L for every octet of every frame", and the "Start lanes" paragraph
   four paragraphs later carves out the XGMII boundary where there are two. The
   two are consistent, but a tb_writer reading the definition first builds the
   monitor I have just had to fix — which is not a hypothetical, since I built
   it. Repair is one clause on the definition: "…a single constant L … (at the
   XGMII boundary, one constant per start lane — see Start lanes below)". Owner
   architect_docs_lead; must land before the first tb_writer `WO-` carrying a
   §0.5 excerpt.
3. **REQ-018's injection half is owed and is sequenced behind
   `AP-xgmii_rx_64.md`**, which is itself behind C-12's ruling for the
   error-character-during-`Discard` row (marked NO-ASSERT meanwhile). Next
   cycle, with the attack plan.
4. **The Hardcaml probe for the XGMII boundary is not written.**
   `Xgmii_word.to_wire` / `of_wire` pin REQ-012's packing so the probe is
   mechanical, but it lands with the first M03 bench, when there is a port to
   attach to. `of_source` in `test/axi64_probe/` still imports
   `Ifc_check.Axi64_ifc.Axi64` and must be retargeted when rtl_lead builds M01
   — unchanged from `J-dv_lead-0004` and `J-dv_lead-0005`.
5. **`Latency.frames_compared` changed meaning** from "frames compared" to
   "output frames offered, matched or not", so that the frame index in an error
   message stays stable when a frame does not match. Documented in the `.mli`;
   the surplus-frame case's report line changes from `frames=0` to `frames=1`
   and its snapshot is one of the 24.
6. **Still open and unchanged**: C-2, C-3, C-5, C-6, C-7 on the gate ledger;
   C-11, C-12, C-13, C-14 pending the architect's committed diffs (drafted in
   the working tree, not yet countersigned); `hardcaml_verilator` plus a
   `verilator` binary against REQ-901.

### Files-in-this-commit
- agents/handoffs/WO-0012_dv-wave2.md
- test/monitors/octet_time.ml
- test/monitors/octet_time.mli
- test/monitors/test_octet_time.ml
- test/xgmii/dune
- test/xgmii/xgmii_word.mli
- test/xgmii/xgmii_word.ml
- test/xgmii/frame.mli
- test/xgmii/frame.ml
- test/xgmii/arrival.mli
- test/xgmii/arrival.ml
- test/xgmii/tx_decoder.mli
- test/xgmii/tx_decoder.ml
- test/xgmii/test_frame.ml
- test/xgmii/test_arrival.ml
- test/xgmii/test_tx_decoder.ml
- tools/check_emitted_verilog.sh
- tools/dv_checks.sh

## [J-dv_lead-0007] 2026-08-02T13:40:00Z | task:WO-0013 | Batch C countersigned at 508eea2: M06/M07/M08/M09 SIGNED, M06's zero-reserve ceiling judged achievable from the octet mapping, all eight §13 amendments reaffirmed, ADR-0008 accepted; C-15 confirmed still owed and C-16/C-17/C-18 raised

### Trigger
Orchestrator spawn under work order WO-0013 (ISSUED at 9b43319), spawn short-id
`WO-0013/2026-08-02T12:45Z`. Seventh activation. Third countersign cycle, and
the first in which I am asked to judge my own findings after someone else has
implemented them: the eight §13 amendments to the FROZEN SPEC-M03/M04 are
C-11, C-12 and C-14 made into text, and reaffirming them is a different act
from raising them.

### Inputs
- `agents/charters/dv_lead.md` (§5 DoD and §6 evaluation criteria refreshed);
  `agents/PROTOCOL.md` §4 (entry grammar), §7 (gates, the transcription rule),
  §10 (independence and evidence).
- `agents/handoffs/WO-0013_batch-c-countersign.md` at 9b43319 — my work order.
- **Review targets at 508eea2**, all read in full: `docs/specs/modules/
  eth_axis_rx.md` (SPEC-M06), `eth_axis_tx.md` (SPEC-M07), `eth_demux.md`
  (SPEC-M08), `eth_arb_mux.md` (SPEC-M09), all DRAFT; the four new
  `docs/specs/ifc_check/*_ifc.ml` lifts.
- **The eight §13 amendment records**, read both as committed text and as
  `git diff f78766e 508eea2 -- docs/specs/modules/xgmii_rx_64.md
  docs/specs/modules/xgmii_tx_64.md docs/specs/requirements.md`, so that I
  judged what changed and not only what now stands.
- `docs/adr/ADR-0008-transmit-header-handshake.md` — this work order is its
  flagged contest window (SPEC-M07 §11.2, SPEC-M09 §11.3).
- `docs/specs/requirements.md` at 508eea2: §0.1 … §0.7, §1.1, REQ-001 …
  REQ-021, REQ-101 … REQ-113, REQ-201 … REQ-210, REQ-401 … REQ-410, REQ-802,
  REQ-810, and the new §13 revision record.
- `agents/handoffs/WO-0010_dual-batch-countersign.md` Return log (my C-11
  replacement text, my C-12 proposed ruling, the C-14 table — the three things
  I had to check the amendments against); `agents/handoffs/WO-0011_batch-c-
  specs.md` Return log (per-deliverable dispositions, the C-15 routing);
  `agents/handoffs/WO-0012_dv-wave2.md` Return log (my C-15 proposal);
  `docs/gates/P1-spec-freeze-checklist.md` (the carry-forward ledger, C-1 …
  C-14).
- My own `J-dv_lead-0005` (the batch-B signature and the standard I set there)
  and `J-dv_lead-0006`; `test/monitors/octet_time.mli`, re-read because (a)
  required judging four latency contracts against my machinery's semantics and
  because the WO-0012 fix is what makes M06's h and its correspondence term
  safe to conflate.
- CI: run **30733153172**, fetched through the GitHub API rather than accepted
  from the packet.
- **`libs/**` was never opened**, in this or any previous activation. Nothing
  in this verdict derives from RTL; `rtl_snapshots/**` was read only by
  `tools/dv_checks.sh`, as at WO-0009 and WO-0010.

### Reasoning
**The standard is unchanged, and saying so first matters more this time than
last.** A countersignature answers one question: can a tb_writer who never sees
RTL build a correct bench from this text alone? Inelegance is not my business;
underivability is a contest; and a sentence that would make a bench **fail a
conformant design** is the class I care most about, because it converts into a
false `BUG-` against rtl_lead and costs the programme credibility in the
direction hardest to recover. At WO-0010 I found five of that class across three
specs and signed anyway, because in every case a normative section of the *same*
document stated the correct reading. I found six this time — five readings and
one coverage claim — and every one of them has the same property. Signing them
and contesting nothing is therefore not leniency; it is the same bar applied
twice. Moving the bar because the count rose from five to six would make my
threshold a function of when a defect was found rather than of what it costs,
which is exactly the failure I named at WO-0010 and declined to commit.

**Reaffirming my own findings needed a different discipline from raising them,
and I tried to make that visible.** The temptation with an amendment that
implements your own words is to check that the words are present and stop. So I
checked three things instead: that the replacement landed *faithfully* (C-11 —
and it landed better than I wrote it, retaining a clause of the original my
draft had dropped); that the ruling landed *as ruled* (C-12 — and it landed
wider, generalised from the one `Discard` corner I raised to a defined notion of
an open frame, which I then had to verify was complete rather than merely
larger); and that the tight bounds are actually tight, which I re-derived rather
than compared. C-14.3's drain window: N = 8q + r gives a `tlast` word one or two
cycles after the terminate word at a lane-0 start and zero or one at a lane-4
start, maximum 2 = ΔC − 1, and **attained** at N = 13 — so REQ-109's "from 3
cycles after" is exact and not conservative. C-14.1's `tx_tready` at C+11: an
acceptance one cycle earlier puts the start character at C+11 and leaves an
8-octet gap against REQ-204's 12, so C+11 is the earliest legal acceptance and
REQ-209's cadence is unachievable either side of it. Both bounds hold.

**The sharpest finding came out of composition, not out of any one document, and
it is the one I would defend hardest.** SPEC-M07 §8 and SPEC-M09 §8 item 5 both
commission a run through M09 → M07 → M04 asserting REQ-209's 11-cycle frame
period. That period is not a property of any one module: it depends on the exact
cycle M04 asserts `tx_tready` after a frame's last source word has been accepted
and before the FCS word — C+8 in SPEC-M04 §6.1's table. §6.1 says 1 there;
SPEC-M07 §6.2 accepts its first payload word only when `tx_tready` = 1; and C+8
is the only cycle at which M07 is back in `Idle` and still early enough to have
output word 0 ready for M04's next acceptance. Were it 0, M07 would accept at
C+11, emit at C+12, and the start characters would be **12** cycles apart —
failing REQ-209 and failing the assertion two batch-C specs commission. So the
table's value is right and load-bearing. What is missing is what M04 does with a
word actually *presented* there: §6.2's only first-word acceptance transition
leaves `Idle`, which is entered only once the gap is served, and §6.1's
"accepted at C+m, transmitted at C+m+2" cannot hold for a word whose transmit
slot is the terminate word. M04's own §8 REQ-209 bench, with a continuous
source, drives that case directly. I raise it as C-16 rather than as a contest
because §6.1's table already states the governing value and §7's REQ-210 bullet
already permits a delayed start character — but I record that the C-14.1
amendment's claim to state "exactly when `tx_tready` is 0" is not met, and that
I am currently the only place the composed cadence's derivation is written down,
which is not where it belongs.

**On M06's zero-reserve ceiling I refused to treat the architect's flag as the
judgement.** ΔC = 3 is not a target M06 must hit; it is what the octet mapping
produces. Payload octet j is input octet j + 14, so payload word m needs input
octets 8m+14 … 8m+21, straddling input words m+1 and m+2 at every m and every
frame length — six octets from one and two from the other, which is REQ-021's
realignment as arithmetic rather than as prose. Input word m+2 lands at Ci+m+2;
a registered output emits at Ci+m+3. Three is forced. I then asked whether zero
reserve is *safe*, which is a different question, and concluded it is safe
because the reserve is held in the right place: §1.1 keeps 7 cycles centrally
and releases them by a three-file spec diff, which is strictly better than
scattering a spare cycle into each ceiling where it would be consumed silently
and REQ-006 would fail at the top with nobody able to name the owner — the exact
failure C-1 existed to prevent. A module pinned at its ceiling with central slack
is a visible decision; a module with a private cycle is not. So the zero reserve
is not a risk I am absorbing, it is a property I want, and SO-M06 will supply
`?ceiling:3` to the tagger so a ΔC of 4 is a machine-reported REQ-019 failure
rather than a judgement call in my own packet.

**On ADR-0008 I judged a convention, not a fix, because it binds three
unwritten specifications.** What makes it acceptable is that the acceptance
event is a wire that already exists: a port learns it is granted when its first
payload word is accepted, on `payload_tready`, so there is no second handshake
for a monitor to watch and no way for two handshakes to disagree — the failure
mode that makes header/payload protocols expensive to verify. Decision 1's
simultaneity deletes the granted-but-nothing-to-send state outright, so M09
never represents it and no bench drives it. Decision 4 I verified arithmetically
rather than accepted: every Phase-1 transmit frame's Ethernet payload is at
least 28 octets (ARP packet, or 20-octet IPv4 header plus 8-octet UDP header), so
at least one payload word always exists and the header-without-payload case is
unreachable rather than undefined. And rejected alternative (a) would have made
REQ-003's structural check grow an exception — an invariant with an exception
stops being structural, and that check is one of the few things here enforced by
the type system rather than by a bench. The one thing I had to fix rather than
accept is that decision 3 says the source **may** drop `valid` after acceptance;
a monitor written from the text alone would assert that it falls, and fail a
conformant source. So the reading I sign against is that a transmit-side header
monitor keys on the acceptance event and never on a `valid` edge, and C-17(d)
asks for the sentence that makes that the text's reading rather than only mine.

**C-18 is the finding I least expected, because it is a defect introduced by the
repair of a defect I raised.** C-14.4's *rule* — an input word covering no frame
octet holds the frame, advances no m, is not a condition — is exactly what I
asked for and is right. Its illustrative list is not: "the second word of a
lane-4 start's preamble" covers four frame octets, as §6.1's own lane-4
paragraph says, and read literally the §6.2 `Frame` row would hold the CRC
register across them and fail the FCS check of **every** lane-4 frame. That is
the single sharpest sentence in this review, and it sits inside a fix. I record
it that way deliberately: a countersignature process that only ever finds defects
in the original text and never in its own repairs is not being run honestly.

**What I did not do.** I did not touch `docs/specs/**` or `docs/adr/**` to apply
any of the eight one-line diffs, though I could see exactly what each should
say: they are the architect's text and outside my write scope, and a
countersigner who edits the thing it is countersigning has signed nothing. I did
not extend `test/` or `tools/` in this activation, though C-17(d)'s monitor
parameter and the inserting-stage latency convention are both mine and both
ready to write — the packet fixes this commit's file set at one packet, and a
signature commit that also carries a code change is harder to audit. I did not
answer SPEC-M07 §11.3 by asking for a new REQ, because §8 already states the
obligation and requirements.md §0.2's one-fact-per-REQ rule is what a
"run the bench through M09 and M07" row would fail.

### Actions
- Read the four batch-C specifications and ADR-0008 in full; read the eight §13
  records both as committed text and as diffs against the f78766e freeze SHA.
- Recomputed all four batch-C latency contracts from §0.5's definitions
  (M06 h = 14 / L = 10 / ΔC = 3; M08 h = 0 / L = 8 / ΔC = 1; M07 ΔC = 1 with
  L = 22 under an insertion convention; M09 ΔC = 0), the M06 ΔC = 3
  achievability argument from the octet mapping, C-14.3's drain bound at both
  start lanes, C-14.1's C+11 bound against REQ-204's rounding, M06's
  abort-in-time and back-to-back inequalities, M07's W/J word arithmetic and its
  46-octet cycle table octet by octet, M08's H-relative pipeline and strobe
  window, M09's grant deadline and its starvation argument, and the composed
  M09 → M07 → M04 cadence at 11 cycles.
- Verified the C-12 closure list for completeness against every SPEC-M03 §9 row
  and every REQ-101 … REQ-113 path, and confirmed `cfg_rx_enable` is correctly
  absent from it.
- Recounted REQ-010's corrected seven-port census (C-13) and confirmed it.
- Confirmed CI run 30733153172 through the GitHub API; confirmed by diff that
  the four batch-C lifts are byte-identical between 508eea2 and the run's SHA
  f457efc, and that the specifications and ADR have not moved since 508eea2;
  ran `tools/dv_checks.sh` at 9b43319.
- Appended the RETURNED verdict entry to
  `agents/handoffs/WO-0013_batch-c-countersign.md` and set its header state to
  RETURNED.
- Wrote nothing under `docs/`, `libs/`, `test/`, `tools/`, `.github/`,
  `scripts/` or `tasks/`.

### Evidence
All commands runnable from a repo checkout at this SHA (PROTOCOL §4.1 form (a))
or externally verifiable references (form (b)).

1. **Compile evidence, verified at source.** GitHub API,
   `renatom11/agentic-fpga`: run **30733153172**, workflow `build`, `head_sha`
   `f457efc85d367c7903bee32f4ba31f6e067db0fb`, status `completed`, conclusion
   **`success`**.
2. **That run witnesses the text I signed, checked rather than assumed.**
   `git diff --stat 508eea2 f457efc -- docs/specs/ifc_check/` → **empty**, so
   the four batch-C lifts CI elaborated are byte-identical to those at the
   review SHA. `git diff --stat 508eea2 HEAD -- docs/specs/ docs/adr/` →
   **empty**, so the four specifications and ADR-0008 have not moved since
   508eea2.
3. **`tools/dv_checks.sh` at 9b43319** → exit `0`, `dv_checks: all checks
   passed`. Record half: `12 check(s) run, 0 failure(s)`, including all **nine**
   `modules/<spec>.md §4.1 == ifc_check/<spec>_ifc.ml (byte identical,
   SPEC-TEMPLATE rule 6)` rows — so the four batch-C §4.1 blocks I judged are
   the four CI compiled. Emitted-Verilog half: `4 check(s) run, 0 failure(s),
   4 pending`.
4. **M06's ΔC = 3, reproduced from the octet mapping.** Payload octet j is
   input octet j + 14, so payload word m needs input octets 8m+14 … 8m+21,
   which lie in input words ⌊(8m+14)/8⌋ = m+1 (positions 6, 7) and
   ⌊(8m+21)/8⌋ = m+2 (positions 0–5). Input word m+2 arrives at Ci+m+2; a
   registered output emits at Ci+m+3. Hence Co = Ci+3, ΔC = 3,
   L = 8·3 − 14 = **10**, (L + h) = 24 ≡ 0 (mod 8), ceiling 3, reserve 0.
   M08: Co = Ci+1, h = 0, L = **8**, (L+h) = 8, ΔC = 1, ceiling 1. Chain to
   date: 3 + 3 + 1 = **7 pinned against 8 allocated**, the single cycle of
   module-level reserve being M03's; the architect's 7 cycles are untouched.
5. **C-14.3's drain bound, re-derived and found attained.** N = 8q + r octets
   between `/S/` and `/T/`; delivered N − 4. Lane-0 start: terminate word q+1,
   output words ⌈(N−4)/8⌉ = q (r ≤ 4) or q+1 (r ≥ 5), `tlast` word at q+2 or
   q+3 — **1 or 2** cycles after. Lane-4 start: terminate word q+1 (r ≤ 3) or
   q+2 (r ≥ 4), difference **0 or 1**. Maximum **2 = ΔC − 1**, attained at
   N = 13 lane 0 (terminate word cycle 2, `tlast` word cycle 4). REQ-109's
   "from 3 cycles after" is exact.
6. **C-14.1's C+11, re-derived.** Terminate character in lane 0 of C+10;
   `cfg_ifg` = 12 gives g = ⌈(12+0)/8⌉ = 2 words, an actual gap of 16 octets,
   and the next start character at C+12. An acceptance at C+10 would place the
   start character at C+11 and leave 8 octets < 12, violating REQ-204; an
   acceptance at C+12 would give a 12-cycle spacing, violating REQ-209. C+11 is
   the unique legal cycle.
7. **The composed cadence, and why C+8 is load-bearing.** M07 re-enters `Idle`
   when frame k−1's last output word is accepted (M04's C+7). With
   `tx_tready` = 1 at C+8, M07 accepts frame k's first payload word there,
   emits output word 0 at C+9 and holds it (`tx_tready` = 0 at C+9, C+10) until
   M04 accepts at C+11; M04's start characters land at C+1 and C+12 —
   **11 cycles**, REQ-209. With `tx_tready` = 0 at C+8, M07 accepts at C+11,
   emits at C+12, and the spacing is **12** — REQ-209 fails, and with it the
   assertion SPEC-M07 §8 and SPEC-M09 §8 item 5 both commission. M04's §6.2
   has no state that accepts a source word at C+8.
8. **M07's drain, from its own arithmetic.** W = ⌈(14+P)/8⌉, J = ⌈P/8⌉ give
   W − J = 1 for P ≡ 1, 2 (mod 8) and 2 otherwise. The last payload word is
   accepted at C + J − 1 and the last output word leaves at C + W, so
   `payload_tready` is 0 for **W − J + 1** cycles — three for the 46-octet
   payload of §6.1's table (C+6, C+7, C+8), which the table shows and the prose
   contradicts in three places.
9. **M06's two inequalities, which cannot both hold.** K = ⌈N/8⌉,
   M = ⌈(N−14)/8⌉; M = K − 1 for N ≡ 0 or 7 (mod 8) and K − 2 otherwise. The
   abort paragraph's `Ci + M + 2 ≥ Ci + K` is true at every N; the back-to-back
   paragraph's `Ci + M + 2 ≤ Ci + K` is false whenever M = K − 1 (a 64-octet
   input frame is the first case). The conclusion survives on the adjacent
   sentence's own argument (M06 emits fewer words than it consumes).
10. **M06 §8's `tkeep` coverage claim, disproved by enumeration.** Input frames
    of 14 … 21 octets give payloads 0 … 7. Payload 0 emits no payload word and
    therefore no `tlast` and no `tkeep`; payloads 1 … 7 give `0x01` … `0x7F`.
    The eighth pattern `0xFF` needs a payload length that is a positive multiple
    of 8 — a 22-octet input frame — and neither the stress frame (payload 46,
    `0x3F`) nor the 1514-octet case (payload 1500, `0x0F`) produces one.
11. **C-18's example, disproved against the same section.** At a lane-4 start
    the eight preamble octets occupy cycle 0 lanes 4–7 and cycle 1 lanes 0–3, so
    frame octets 0–3 occupy cycle 1 lanes 4–7 — SPEC-M03 §6.1's own "The same
    frame at a lane-4 start" paragraph says exactly this. The second preamble
    word therefore covers four frame octets; holding the CRC register across it,
    as §6.2's amended `Frame` row instructs by example, would fail REQ-104 on
    every lane-4 frame.
12. **No new CI run is cited for this commit** — it carries one packet and my
    journal, no code and no spec, so there is nothing for a build to verify
    beyond the journal check itself.

### Outcome
DoD of WO-0013 met on all four verdict groups, with the signature decision
explicit.

> **I countersign batch C (SPEC-M06, SPEC-M07, SPEC-M08, SPEC-M09) for P1-spec-freeze at 508eea2, and reaffirm SPEC-M03/M04 as amended.**

Verdicts: SPEC-M06 SIGNED (its zero-reserve ceiling judged achievable and its
reserve position judged correct), SPEC-M07 SIGNED, SPEC-M08 SIGNED, SPEC-M09
SIGNED; all eight §13 amendments REAFFIRMED, with C-11's replacement confirmed
faithful, C-12's closure-list rule confirmed to match my supplied ruling and
verified complete, and C-14.3's and C-14.1's bounds re-derived and found tight;
ADR-0008 ACCEPTED; C-15 CONFIRMED still owed and not withdrawn. Nothing is
CONTESTED. Three new carry-forwards — C-16 (SPEC-M04 §7's amended `tx_tready`
bullet is correct but not complete, and the uncovered cycle is the one the
composed transmit cadence turns on), C-17 (five batch-C readings and coverage
claims that do not hold as written), C-18 (the C-14.4 amendment's illustrative
list and "gapless" definition in SPEC-M03) — none blocking, each tied to the
moment it must close. SPEC-M07 §11.3's question to me is answered in the packet:
declined, no new REQ.

Handoff: `agents/handoffs/WO-0013_batch-c-countersign.md`, state RETURNED,
carrying the verdict table, the recomputations, the readings this signature
fixes, the ledger dispositions for the orchestrator to transcribe, and the five
DV actions this review created for me.

### Open-questions
1. **C-16 must land before SPEC-M04's or SPEC-M07's tb_writer `WO-` leaves my
   hands.** Until it does, the composed REQ-209 bench is derivable only by
   reading SPEC-M04 §6.1's cycle table as governing over §7's enumeration, and
   the only place that derivation is written down is this packet. If the diff
   has not landed when I draft either `WO-`, the packet's `Context provided`
   will say so rather than route around it with a careful excerpt.
2. **C-18's example (i) must land before `AP-xgmii_rx_64.md` and SPEC-M03's
   tb_writer `WO-`.** Read literally it would fail every lane-4 frame's FCS
   check; it is the sharpest single sentence in this review and it sits inside
   the repair of one of my own findings.
3. **C-17(e) must land before SO-M06 quotes a coverage table**, or I extend the
   directed set to 22 octets in my own `WO-` and say why. A coverage row no test
   drives is the one defect class that would be mine rather than the architect's
   once it reaches a sign-off packet.
4. **`Latency` has no stated convention for an inserting stage.** §0.5 defines h
   as octets removed from the front; M07 adds fourteen. h = −14 gives L = 22 and
   ΔC = 1, closing mod 8 and matching §6.1's table octet by octet, but I will
   not invent a sign convention silently in a sign-off packet. SPEC-M07 §7 pins
   its two measurement events explicitly, so no specification change is owed;
   this is machinery work plus a documentation line in `octet_time.mli`.
5. **`AP-xgmii_rx_64.md`'s C-12 row is released from NO-ASSERT** and becomes a
   positive assertion — one `error_oversize`, no `error_bad_frame`, the
   following frame intact. That is the first attack-plan row this programme has
   unblocked by ruling rather than by testing.
6. **C-15 remains open and is now the oldest of my unrepaired findings.** Batch-D
   routing confirmed; the repair is one clause and the evidence that it is not
   hypothetical is still my own WO-0012 fix.
7. **Still open and unchanged**: C-2, C-3, C-5, C-6, C-7 as recorded in the gate
   ledger; `of_source` still imports `Ifc_check.Axi64_ifc.Axi64` and must be
   retargeted when rtl_lead builds M01; `hardcaml_verilator` plus a `verilator`
   binary against REQ-901.

### Files-in-this-commit
- agents/handoffs/WO-0013_batch-c-countersign.md

## [J-dv_lead-0008] 2026-08-02T16:30:00Z | task:WO-0015 | Batch D countersignature WITHHELD at a9993ff: M10/M11/M12 SIGNED, SPEC-M13 CONTESTED on two behavioural items; four architect questions answered decisively plus a fifth; C-6/15/16/17/18 all reaffirmed; C-19 … C-23 raised

### Trigger
Orchestrator spawn under work order WO-0015 (ISSUED at 2f29888), spawn short-id
`WO-0015/2026-08-02T06:45Z`. Eighth activation. Fourth countersign cycle, and
the first protocol-logic batch: batch D is where the ARP family stops being
octet plumbing and starts being a state machine with persistent memory, which is
also where the failure modes stop being local.

### Inputs
- `agents/charters/dv_lead.md` (§3 spec-derived verification, §5 DoD, §6
  evaluation criteria); `agents/PROTOCOL.md` §4 (entry grammar), §6 (write
  scope), §7 (gates and the transcription rule), §10 (independence).
- `agents/handoffs/WO-0015_batch-d-countersign.md` at 2f29888 — my work order.
- **Review targets at a9993ff (= the tree at 2f29888, verified)**, all read in
  full: `docs/specs/modules/arp_eth_rx.md` (SPEC-M10), `arp_eth_tx.md`
  (SPEC-M11), `arp_cache.md` (SPEC-M12), `arp.md` (SPEC-M13), all DRAFT; the
  four new `docs/specs/ifc_check/{arp_eth_rx,arp_eth_tx,arp_cache,arp}_ifc.ml`
  lifts.
- `agents/handoffs/WO-0014_batch-d-specs.md` Return log — the architect's
  per-item C-17 judgements, the C-18 twin-sentence disclosure, the batch-C
  freeze-flip disclosure, and the four open questions; and its ACCEPTED block.
- `docs/gates/P1-spec-freeze-checklist.md` — the C-6/C-15/C-16/C-17/C-18
  closures transcribed at 2f29888, and the full carry-forward ledger C-1 … C-18.
- `docs/adr/ADR-0008-transmit-header-handshake.md`, including the new
  Consequences bullet that is my own C-17(d).
- **The five landing sites of the transcribed closures, read as text rather than
  as descriptions of text**: SPEC-M06 §6.1 and §8 and §10 (C-17(a), C-17(e)),
  SPEC-M07 §6.1/§6.2/§7/§8/§10 (C-17(b)), SPEC-M08 §6.1/§6.3 (C-17(c)),
  SPEC-M04 §6.2/§7/§10 (C-16), SPEC-M03 §3/§6.1/§6.2 (C-18), requirements.md
  §0.5 (C-15).
- `docs/specs/requirements.md` at this tree: §0.1 … §0.7, §1.1, REQ-001 …
  REQ-021 (REQ-013 in full), REQ-104, REQ-105, REQ-208, REQ-403, REQ-501 …
  REQ-512, REQ-604, REQ-707, REQ-802, REQ-803, REQ-807, REQ-810, REQ-901, §9.1,
  §12. `docs/specs/architecture.md` §6.4. `docs/specs/traceability.md`.
  `docs/specs/SPEC-TEMPLATE.md` §11 (the DRAFT-versus-FROZEN rule, which is what
  makes an unclosed §11 item block a freeze).
- SPEC-M03 §7, SPEC-M04 §6.1, SPEC-M06 §7, SPEC-M07 §7, SPEC-M08 §7, SPEC-M09 §7
  — re-read for their pinned ΔC values, because SPEC-M13 §6.1's REQ-502 chain is
  built out of them and I would not check a derivation against a summary.
- My own `J-dv_lead-0005` (the standard I set for signing a "fails a conformant
  design" finding) and `J-dv_lead-0007` (the six batch-C findings and the C-17
  text the architect implemented); `test/monitors/conservation_monitor.mli` and
  `strobes.mli`, re-read because C-21 and C-23 are claims about my own machinery
  as much as about the specs.
- CI: run **30736107842**, fetched through the GitHub API rather than accepted
  from the packet.
- **`libs/**` was never opened**, in this or any previous activation. Nothing in
  this verdict derives from RTL; `rtl_snapshots/**` was read only by
  `tools/dv_checks.sh`.

### Reasoning
**The standard did not move, and this is the activation that proves it can bite.**
A countersignature answers one question: can a tb_writer who never sees RTL
build a correct bench from this text alone? At WO-0010 I found five sentences
that would make a bench fail a conformant design and signed; at WO-0013 I found
six and signed. Both times the ground was identical and I stated it explicitly:
*a normative section of the same document stated the correct reading*, so the
defect costs a careful reader nothing and a careless one a bounce. Holding that
line meant signing when the count rose from five to six, because a threshold
that moves with the count is a threshold that measures when a defect was found
rather than what it costs. It also means the line has to hold in the other
direction, and batch D is where it does. Two of the four findings that matter
have the property the previous eleven did not: **no section anywhere states the
correct reading**, and in one case the wrong reading is stated three times
across two documents, one of them a requirement's own normative sentence.

**D-1 is the finding I would defend hardest, and it came out of composition
rather than out of any one document — the same place SPEC-M04's C+8 came from at
WO-0013.** SPEC-M13's REQ-510 machinery is internally consistent and reads
correctly. SPEC-M11's `Idle` row is internally consistent and reads correctly.
Put them together and the module retains **two** replies: M11's `arp_ready` is 1
in `Idle` *unconditionally* — it does not depend on `payload_tready`, so a
blocked downstream does not stop M11 absorbing the first packet — and M13's
machine (A) leaves `Pending` on M11's acceptance, so the resolver goes idle and
the second reply is held rather than dropped. Only the third drops. REQ-510's
normative sentence says one; SPEC-M13 §8 item 2, §10's REQ-810 row and
requirements.md REQ-510's own verification column each say two requests give one
strobe, and a conformant design pulses zero for all three. I checked the
architect's model against its own words and found where it slips: SPEC-M11 §6.1
says "`arp_ready` remains 0 throughout, so M13 cannot lose a packet by presenting
it **while M11 is busy** — which is the mechanism REQ-510 then acts on at M13".
That is right for the second and later replies and silently assumes the first has
somewhere to be. It hasn't; it is in M11, free of charge.

**Why I contested rather than carried it, when I have carried worse-sounding
things.** The test I applied is not severity, it is *what freezing costs*. Every
post-freeze diff this programme has taken — C-11, C-12, C-14, C-16, C-17, C-18 —
carries a §13 row reading "no constant, state or record changes", and that is not
an accident: they were all readings, not behaviours. D-1's repair adds a state to
machine (A) and changes an observable (how many replies survive a blocked
transmit path). D-2's changes when a cache write happens. Freezing first does not
make either repair expensive in dollars; it makes them **the programme's first
behavioural post-freeze diffs**, and a freeze gate whose signature does not
distinguish those two classes is a signature that means nothing. I would rather
spend one diff cycle now than be the agent who set the precedent that a frozen
spec's behaviour is negotiable.

**D-2 is where I had to be most careful not to overreach, because the honest
finding is about a cost estimate rather than about a design.** SPEC-M10 §11.3
asks me to accept that a bad-FCS ARP frame is learned from, and prices the
alternative at "a requirements.md diff, a new `Arp_packet` field and a spec diff
here and at SPEC-M13" — i.e. as a post-freeze **record addition**, which is
breaking. That price is wrong, and it is wrong in the direction that would have
forced the decision under gate pressure: the abort bit arrives on the payload
`tlast`, two or more cycles after the record is emitted, so no field of that
record could ever carry it — while M13, which relays `rx_payload` into M10,
**already has the bit on a port it owns**. The real repair touches no interface
at all. Having found that, I could not close the item in the affirmative on the
strength of an argument that rests on a cost nobody actually has to pay. And the
substance is not small: REQ-013's first clause says the bit means "the ultimate
consumer must discard it", REQ-707 shows that pattern working on the UDP path,
and the ARP branch is the one receive branch with no application — so the mark is
generated at M03, relayed through four modules and consumed by nobody, while a
single corrupt frame commits a wrong IP-to-MAC binding for twenty seconds with no
strobe naming it. That is the shape of a defect that surfaces as a replay
divergence three phases later with no way back to its origin, which is the class
my charter's escape-rate criterion exists to keep me honest about.

**On Q3 I was asked to be decisive and the packet was right to insist, so I
resolved it on the requirement's own structure rather than on taste.** REQ-810's
verification column tests the enable behaviour and says nothing about ARP
replies; in a document where §0.2 makes one REQ state one testable fact and the
verification column is where that fact's test lives, a clause with no test in its
own column and an explicit pointer at another requirement ("is dropped **under
REQ-510**") is an explanatory consequence, not an independent obligation. Reading
it the other way buys a `cfg_tx_enable` port at M13 that cannot even do the job —
it can't retract a reply already inside M11 — and spends a breaking interface
change on a frame that carries our own MAC for our own IP and therefore cannot go
stale the way a buffered datagram can. What made me comfortable saying so without
hedging is that D-1's recommended repair closes most of the gap for nothing: with
R-1, exactly one reply survives a transmit-disable and every later one is dropped
with the strobe, which is REQ-810's plain reading minus a single frame. I stated
that residual in the packet in the plainest words I could find, because "answered
decisively" and "answered completely" are different, and only the second is worth
anything at a freeze.

**Q1 I answered by going back to the ADR's own problem statement rather than to
its decisions.** ADR-0008 asks "what is a transmit-side header record's
acceptance event, *given a record that cannot carry a `ready`*?" M11's `arp` port
is not that case — `arp_ready` is a real output bit, not a field of a record M01
froze — so the port never needed the ADR's device, and applying decisions 2 and 3
against a native ready is the general valid/ready contract the ADR *specialises*,
not a substitution for it. That is instantiation, and no amendment is owed. The
part that costs me something is the part the architect correctly identified as
mine: my header-record monitor takes its discipline from the port's direction,
and batch D adds a third case direction alone cannot select. Machinery, not a
spec diff, and I said so rather than converting my own work into someone else's
finding.

**Q4 I could have treated as a missing requirement and did not, because the
programme already has the device for it.** Every §6.3 opens "anything not listed
here is constrained by this specification, and a test may rely on it" — that
sentence *is* the licence for a spec to decide an unconstrained corner, and it
was accepted at three previous batches. What I did add is the consequence the
document does not state and a bench writer cannot be left to discover: under
replacement, an application alternating between two unresolved destinations
issues one broadcast request per datagram, defeating REQ-505's suppression
entirely. That is conformant in Phase 1 — one application client — but a test
writer who sees it must be able to tell that it is conformant, and it names the
exact trigger for revisiting the rejected per-slot table.

**SPEC-M12 came out clean, and I want that recorded as a positive rather than as
an absence.** I recomputed the index function from REQ-504 *and* REQ-012 rather
than checking it, recomputed all five worked examples, walked the collision table
row by row against the T+1 visibility rule, and checked both ageing boundaries
against §8's L = 8 run. Everything reproduces. Two things earned it: stating the
write/query ordering as **one rule about cycles** instead of a same-slot special
case, which is what lets a bench drive both ports every cycle and still predict
every answer; and stating the lifetime as an **observable** with the mechanism
explicitly unconstrained, which is the only form of an ageing rule a bench can
assert without reading the implementation. It is also the only batch-D spec I can
write an attack plan against today.

**Two of my five new carry-forwards are defects in the repair of my own
findings, and I record them that way on purpose.** C-22 is my C-17(d) text: I
wrote an unqualified "SHALL NOT assert that `valid` falls after acceptance", and
SPEC-M11 §6.1 then committed M11 to dropping it, so a bench writer holding both
documents is told not to assert the thing the module's own cycle table asserts.
C-18 was the first instance of this at WO-0013 and I said then that a
countersignature process which only ever finds defects in the original text and
never in its own repairs is not being run honestly. The second instance is the
test of whether that was a sentence or a practice.

**What I did not do.** I did not touch `docs/specs/**`, `docs/adr/**` or
`docs/gates/**`, though I can see the exact wording each of the two blocking
diffs needs and wrote it out in the packet — they are the architect's text, and a
countersigner who edits the thing it is countersigning has signed nothing. I did
not add `test/**` or `tools/**` machinery, though C-22's monitor clause, Q1's
third monitor case and C-23's counting convention are all mine and all ready to
write: a withheld-signature commit that also carries code is harder to audit, and
the machinery is worth more once I know which of R-1/R-2 and D-2a/D-2b lands. I
did not withhold the whole batch where three specs earned a signature — the
verdicts are per spec, and only the batch-level countersignature is withheld,
because that is the unit the gate table records.

### Actions
- Read the four batch-D specifications, the four new lifts and ADR-0008 in full;
  read the five transcribed C-item closures at their landing sites rather than at
  the Return log's description of them.
- Recomputed every number the work order named, and several it did not:
  SPEC-M10's L/h/ΔC by both of §0.5's routes and its §1.1 exclusion verbatim;
  the one-report XOR's decidability across all four closure cases; §8's stimulus
  and idle-cycle arithmetic; SPEC-M11's L/h/ΔC, its five-cycle packet period and
  its word layout as an octet-by-octet transpose of M10's; SPEC-M12's index
  function from REQ-504 + REQ-012, all five worked examples, the seven-row
  collision table and both ageing boundaries; SPEC-M13's Q+2 uniformity against
  M12's one-cycle lookup, the eleven-step REQ-502 chain against six other specs'
  pinned constants, the multicast bit arithmetic at both test addresses, the
  class precedence and the retry counts.
- Traced D-1 port by port through SPEC-M11 §6.2's `Idle` row and SPEC-M13 §6.2
  machine (A), and checked the resulting count against all four places the
  programme states it.
- Verified R-1 costs nothing in the unblocked case (reply generations are ≥ 10
  cycles apart under REQ-004's own spacing; R-1's pending window is 5).
- Verified D-2a needs no port by confirming `rx_payload_tuser` is already an M13
  input in §4.1's `I` record.
- Recounted architecture.md §6.4 mechanically (117 = 26 + 40 + 29 + 22) and
  re-verified traceability set equality (110 = 110, symmetric difference empty).
- Confirmed CI run 30736107842 through the GitHub API; confirmed by diff that
  the specifications have not moved between a9993ff and the run's SHA; ran
  `tools/dv_checks.sh` and `tools/check_records_vs_appendix.sh`.
- Appended the RETURNED verdict entry to
  `agents/handoffs/WO-0015_batch-d-countersign.md` and set its header state to
  RETURNED.
- Wrote nothing under `docs/`, `libs/`, `test/`, `tools/`, `.github/`,
  `scripts/` or `tasks/`.

### Evidence
All commands runnable from a repo checkout at this SHA (PROTOCOL §4.1 form (a))
or externally verifiable references (form (b)).

1. **Compile evidence, verified at source.** GitHub API,
   `renatom11/agentic-fpga`: run **30736107842**, workflow `build`, `head_sha`
   `2f2988862065af805d829c03c155a49c5bc28cb3`, status `completed`, conclusion
   **`success`**.
2. **That run witnesses the text I judged.** `git diff a9993ff 2f29888 --
   docs/specs/` → **empty**; `git diff --stat a9993ff 2f29888 --
   docs/specs/ifc_check/ docs/adr/` → **empty**. The countersign target and the
   compiled tree are the same specifications.
3. **`tools/check_records_vs_appendix.sh`** → `16 check(s) run, 0 failure(s)`,
   including `modules/arp.md`, `modules/arp_cache.md`, `modules/arp_eth_rx.md`
   and `modules/arp_eth_tx.md` §4.1 == their lifts, byte identical.
   `tools/dv_checks.sh` → exit 0, `dv_checks: all checks passed`.
4. **SPEC-M10's constants, reproduced.** Input event 8·Cp; output event
   8·(Cp+4); L = **32**. h = 0 on both of §0.5's terms. (L + h) = 32 ≡ 0 (mod 8);
   ΔC = 32/8 = **4** = (Cp+4) − Cp — the two routes agree. Cp+4 is forced: ARP
   octet 27 is at position 3 of payload word 3, which arrives at Cp+3, and a
   registered output emits at Cp+4. requirements.md §1.1's closing paragraph
   names M10 and allocates it nothing, in its own words; §1.1's five allocated
   stages still sum to 4+3+1+5+4 = 17 against REQ-006's 24.
5. **SPEC-M11's constants, reproduced.** L = 8·(A+1) − 8·A = **8**; h = 0;
   (L+h) = 8 ≡ 0 (mod 8); ΔC = **1** by both routes. Packet period from §6.2:
   `Idle` at A, `Offer` A+1, `Body` A+2…A+4, `Idle` A+5 → **5 cycles**.
6. **SPEC-M12's index function, derived not checked.** REQ-012 makes the first
   wire octet most significant, so REQ-504's "least significant octet" is bits
   [7:0] and its low four bits are [3:0]: index(a) = **a[3:0]**. 0xC0A8010A→10;
   0xC0A8011A→10 (collision); 0xC0A8010B→11; 0x0A000001→1; 0x0A000010→**0**.
   Collision table verified row by row: write@0, query@1, hit@2; evicting
   write@3, query@4 → **miss**@5; query@5 → hit@6 with the new MAC. Ageing at
   L = 8: hits for queries T+1…T+8, miss at T+9 = T+L+1; refresh at T+4 moves the
   window to T+5…T+12.
7. **SPEC-M13's Q+2, and the REQ-502 chain, term by term.** Q+2 = M12's one-cycle
   lookup plus M13's output register, with classes 1–3 computed at Q and delayed
   to match. Chain at a lane-0 start: M03 ΔC=3 → word 0 at 3; M06 ΔC=3 → header 5
   / payload 6; M08 ΔC=1 → 6 / 7; M13 relay 0 → 6 / 7; terminate character at
   **9** (8 preamble octets in cycle 0, frame octets 0–63 in cycles 1–8, `/T/` in
   lane 0 of cycle 9 — SPEC-M03's own 64-octet table); M10 Cp+4 → **11**; M13
   offer → 12; M11 ΔC=1 with M09 ΔC=0 → 13; M07 ΔC=1 → 14; SPEC-M04 §6.1 puts the
   preamble word at C+1 → start character at **15**. 15 − 9 = **6** against
   REQ-502's 64.
8. **Multicast, both REQ-509 addresses.** 239.1.2.3 = 0xEF010203, d[22:0] =
   0x010203 → 01:00:5E:01:02:03. 239.129.2.3 = 0xEF810203 has bit 23 set;
   d[22:0] = 0x810203 & 0x7FFFFF = 0x010203 → the **same** MAC.
9. **D-1, traced.** SPEC-M11 §6.2 `Idle`: "`arp_ready` = 1" with no dependence
   on `payload_tready`; §7's reset clause makes `clear` the only thing that holds
   it low in `Idle`. SPEC-M13 §6.2 (A) `Pending` → `Idle` "on the cycle M11
   accepts the reply". Therefore with the transmit path blocked: reply 1 accepted
   by M11 on its offer cycle (machine (A) returns to `Idle`), reply 2 held
   `Pending` with no strobe, reply 3 the first dropped. Four places state
   otherwise: SPEC-M13 §8 item 2 ("two … exactly one pulse"), §10's REQ-810 row
   ("two … one"), requirements.md REQ-510's verification column ("two … exactly
   one strobe pulse") and REQ-510's normative "at most one pending reply".
10. **D-2, traced.** requirements.md REQ-013: "`tuser`[0] SHALL mean 'this frame
    was found invalid; the ultimate consumer must discard it' … it is advisory
    metadata carried to the application." REQ-707 carries it to the application
    on the UDP path. The ARP branch terminates at M13 with no application, and
    SPEC-M10 §2 assigns the bit to "nobody at this stage". SPEC-M10 §7 shows it
    arriving on the payload `tlast`, ≥ 2 cycles after the record — which is why
    §11.3's proposed "new `Arp_packet` field" cannot carry it — while SPEC-M13
    §4.1's `I` record already contains `rx_payload` including `tuser`.
11. **Architect bookkeeping, recomputed.** architecture.md §6.4 strict row count
    = **117**; by class 26 rx / 40 tx / 29 control / 22 status (the 41st `tx`
    occurrence is the amended row quoted inside §6.4's prose, not a table row).
    traceability.md vs requirements.md REQ id sets: **110 = 110**, `comm -3`
    empty, 110 row lines, no duplicates.
12. **C-17(e) re-derived by enumeration.** Input frames 14…21 give payloads 0…7;
    payload 0 emits no payload word and therefore no `tkeep`; `0xFF` needs a
    positive multiple of 8, i.e. **N = 22**. C-17(a) re-derived: M = K−1 for
    N ≡ 0 or 7 (mod 8) and K−2 otherwise, so M+2 ∈ {K, K+1} — `≥ K` for the abort
    argument and `≤ K+1` for the back-to-back argument, both now in the text.
13. **No new CI run is cited for this commit** — it carries one packet and my
    journal, no code and no spec, so there is nothing for a build to verify
    beyond the journal check itself.

### Outcome
DoD of WO-0015 met on all four deliverables, with the signature decision explicit
and negative at the batch level.

Verdicts: **SPEC-M10 SIGNED**, **SPEC-M11 SIGNED**, **SPEC-M12 SIGNED (clean —
no findings of any class)**, **SPEC-M13 CONTESTED**. Therefore:

> **I do NOT countersign batch D at a9993ff.** The countersignature sentence,
> for transcription once the D-1 and D-2 diffs land, is: "I countersign batch D
> (SPEC-M10, SPEC-M11, SPEC-M12, SPEC-M13) for P1-spec-freeze at `<SHA>`."

Two blocking diffs owed: **D-1** (the ARP module retains two replies where
REQ-510 says one; three verification hooks across two documents commission a
strobe a conformant design does not pulse — R-1 recommended, R-2 acceptable) and
**D-2** (REQ-013's "ultimate consumer" clause is discharged by nobody on the ARP
branch, and SPEC-M10 §11.3 prices the repair as breaking when it needs no port at
all — D-2a recommended, D-2b acceptable). Consequential edits owed regardless of
verdict: the five §11 closure records and the four §12 compile rows.

Questions: **Q1 INSTANTIATION** (no ADR amendment owed); **Q2 NOT ACCEPTED as
final** (this is D-2); **Q3 CONSEQUENCE CLAUSE — no `cfg_tx_enable` at M13, not
breaking**, answered decisively as the packet required; **Q4 SPECIFICATION
DECISION** (no requirements diff, one consequence sentence added); and **Q5**,
SPEC-M12 §11.3's REQ-506 split, which the packet did not name but whose closing
gate is this countersignature — **AGREED, no requirements diff**.

Ledger: **C-6, C-15, C-16, C-17 (all five items) and C-18 all REAFFIRMED**, each
checked at its landing site; C-17(d)'s placement in ADR-0008 rather than SPEC-M07
judged **correct against my own offer of either home**, and vindicated by batch D
discharging it twice by reference. Five new carry-forwards, none blocking:
**C-19** (SPEC-M11 §8's M10 loopback is a zero-lead producer and fails a
conformant pair), **C-20** (SPEC-M10 §6.3 item 4's word-0 constant is wrong under
both readings), **C-21** (SPEC-M10 §6.1's report XOR does not except the `clear`
abandonment its own §7 mandates; C-2's exemption becomes load-bearing here),
**C-22** (ADR-0008's C-17(d) bullet versus SPEC-M11 §6.1 — mine), **C-23**
(M13 is the programme's first module whose strobe can be high on consecutive
cycles, with REQ-502's measurement start folded in as an editorial note).

Handoff: `agents/handoffs/WO-0015_batch-d-countersign.md`, state RETURNED,
carrying the four verdicts, the recomputations, the two owed diffs with two
acceptable forms each, the five answers, the ledger table, six sub-threshold
readings and the five DV actions this review created for me.

### Open-questions
1. **D-1 and D-2 block the batch-D freeze and nothing else.** Batch E may be
   drafted in parallel: neither repair moves a port, a record or a latency
   constant, so SPEC-M15's dependencies on SPEC-M11 and SPEC-M13 are unaffected
   whichever form lands.
2. **`AP-arp.md`'s REQ-510 rows are blocked on D-1** and will say so rather than
   choose a request count that happens to work. `AP-arp_eth_rx.md` is blocked on
   C-20 and C-21; `AP-arp_eth_tx.md` on C-19. **`AP-arp_cache.md` is unblocked
   today** — SPEC-M12 is the first batch-D spec whose attack plan I can write
   from its own text alone.
3. **C-2 is now my oldest unrepaired finding**, C-15 having closed. C-21 is the
   first place it bites concretely: §0.6's conservation monitor is active in
   every bench and SPEC-M10 §10 commissions a mid-packet `clear` test whose
   packet is opened and never reported.
4. **Three pieces of machinery are now owed by me**: the third header-record
   monitor discipline (a record with a native `ready`, Q1); the strobe-counting
   convention (high cycles, not rising edges, C-23); and the C-22 monitor clause
   once the ADR text settles. I deferred all three so this commit carries no code
   beside a withheld signature.
5. **Still open and unchanged**: C-3, C-5, C-7, and C-9's REQ-903 half;
   `of_source` still imports `Ifc_check.Axi64_ifc.Axi64` and must be retargeted
   when rtl_lead builds M01; `hardcaml_verilator` plus a `verilator` binary
   against REQ-901; the fifth REQ-901 divergence class C-7 asks for, which
   batch D's REQ-510 discussion makes concrete for the first time.

### Files-in-this-commit
- agents/handoffs/WO-0015_batch-d-countersign.md

## [J-dv_lead-0009] 2026-08-02T10:15:00Z | task:WO-0018 | Batch D countersigned at 3f6accc after re-review on the bounded surface, and batch E countersigned at the same SHA: M14/M15/M16 all SIGNED; the architect's five questions answered; C-19 … C-23 reaffirmed; C-24 … C-30 raised, one of them against my own repair

### Trigger
Orchestrator spawn under work order WO-0018 (ISSUED at 7a41a66), spawn short-id
`WO-0018/2026-08-02T08:35Z`. Ninth activation. Fifth countersign cycle, and the
first one that closes a loop I opened: WO-0015 withheld batch D on two
behavioural items and pre-worded the sentence for the commit carrying the
repairs. This is that commit, plus the first IPv4 batch judged at full depth in
the same cycle.

### Inputs
- `agents/charters/dv_lead.md` (§3 spec-derived verification, §5 DoD checklist,
  §6 evaluation criteria, §8 journaling); `agents/PROTOCOL.md` §4 (entry
  grammar), §6 (write scope), §7 (gates and the transcription rule), §10
  (independence and evidence).
- `agents/handoffs/WO-0018_batch-de-countersign.md` at 7a41a66 — my work order.
- `agents/handoffs/WO-0015_batch-d-countersign.md` §8 — **the re-review surface I
  bound myself to**, re-read first so the scope of this review was fixed before
  I read any repaired text.
- `agents/handoffs/WO-0017_batch-e-specs.md` Return log — the architect's D-1/D-2
  choices, the five §11 closures, the C-19…C-23 dispositions, the two §6.4
  amendments and the five open questions; and its ACCEPTED block.
- **Batch-D repair landing sites at 3f6accc**, read as text: SPEC-M13 (`arp.md`)
  in full — §2, §3, §6.1's REQ-510 block and validity gate and cycle table,
  §6.2 machines (A) and (D), §7, §8, §9, §10, §11.2/§11.3/§11.5/§11.6, §12, §13;
  SPEC-M11 §3, §6.1's new paragraph, §8 item 2, §11.1/§11.2/§11.3, §12, §13;
  SPEC-M10 §2's abort row, §6.1's `clear` exception, §6.3 item 4, §7, §8
  criterion 1, §10, §11.3, §13; `docs/adr/ADR-0009-arp-branch-is-the-ultimate-
  consumer.md`; `docs/adr/ADR-0008` Consequences (the C-22 clause).
- **Batch E at 3f6accc**, all three read in full: `docs/specs/modules/
  ip_eth_rx_64.md` (SPEC-M14), `ip_eth_tx_64.md` (SPEC-M15),
  `ip_complete_64.md` (SPEC-M16); their three lifts in `docs/specs/ifc_check/`.
- `docs/specs/requirements.md`: §0.3, §0.5 in full, §0.6's new counting
  convention, §1.1's ceiling table, REQ-013, REQ-019, REQ-104, REQ-107, REQ-208,
  REQ-407, REQ-408, REQ-502, REQ-503, REQ-505, REQ-506, REQ-510, REQ-601 …
  REQ-612, REQ-705, REQ-708, REQ-807, REQ-810, REQ-901, REQ-905, §9.1, §12, §13.
  `docs/specs/traceability.md` (the REQ-502/503/505/506/610/807 rows and the
  two-owner note). `docs/specs/architecture.md` §6.4 in full.
- SPEC-M03 §7, SPEC-M06 §7, SPEC-M08 §7, SPEC-M09 §7, SPEC-M07 §7 — re-read for
  their pinned L and ΔC values, because the REQ-502 chain and SPEC-M16 §7's
  transmit-chain figure are built out of them and I would not check a derivation
  against a summary.
- `docs/gates/P1-spec-freeze-checklist.md` as updated at 7a41a66.
- My own `J-dv_lead-0008` (the standard I set for contesting rather than
  carrying) and `J-dv_lead-0007` (the C-17 items whose repairs batch E copies).
- CI: runs **30739442056** and **30739491408**, fetched through the GitHub API
  rather than accepted from the packet, including the twelve-step job breakdown.
- **`libs/**` was never opened**, in this or any previous activation. Nothing in
  either verdict derives from RTL; `rtl_snapshots/**` was read only by
  `tools/dv_checks.sh`.

### Reasoning
**The re-review surface held, and holding it was the point.** At WO-0015 I wrote
down in advance what the re-review would and would not re-do, so the architect
could choose between R-1/R-2 and D-2a/D-2b knowing the cost. A bounded surface
is worth nothing if the bounder widens it on arrival, so I re-derived only what
moved — the REQ-502 chain's added terms — and did not re-open M10's and M11's
L/h/ΔC, M12's index function, M13's Q+2, the multicast masking, the class
precedence or the retry counts. The one place the boundary bit is **C-28**:
verifying that REQ-506's two-half pattern "actually tiles" at REQ-505 is a
deliverable of *this* work order, and a two-sided pattern cannot be checked from
one side, so I had to look at SPEC-M13 §8/§10 — batch-D text outside my surface.
I raised what I found and said in the packet that it does **not** reopen the
batch-D countersignature, because a finding reached through a door this work
order opened is not a finding the previous review owed.

**R-1 is a better repair than I recommended, and I want the reason recorded
rather than the compliment.** My recommendation said "machine (A) gains one
state (or `Pending`'s exit condition changes)". The architect took the state, and
the state is what makes the rule *checkable from a trace*: with three states the
window's end is an event at M13's own ports — `tx_payload_tvalid` &
`tx_payload_tlast` & `tx_payload_tready` — and §7 enumerates the three events a
REQ-510 monitor keys on, none of which is a `valid` edge. With a changed exit
condition and two states the same behaviour would have been correct and
unobservable at stage granularity. The repair also closed a hazard I did not
raise: §7's reset bullet names `Transmitting` explicitly, so a `clear` during a
reply frame abandons the window rather than stranding it. I checked the case
R-1 could have broken — a *request* accepted by M11 before a reply is offered,
whose `tlast` might have closed the reply's window early — and the state machine
forecloses it, because machine (A) is in `Pending` and not `Transmitting` while
that request drains.

**On question (i) I gave the number away and kept the requirement.** The
architect offered to buy back the cycle by gating only the learning write. I
refused, and the ground is not that a cycle is cheap (though it is, seven against
sixty-four). It is that the reply is the *worse* half to leave ungated: the reply
table fills `target_mac` and `target_ip` from the request's own sender fields, so
a reply generated from a marked frame is a frame **on the wire**, unicast to a
MAC the programme has just declared unreliable, announcing our IP to it — and
unlike a cache entry it cannot be aged out or evicted. If exactly one of the two
had to be gated it would be the reply, which is the opposite of the split on
offer. That is the whole answer, and it took recomputing nothing.

**On question (ii) I declined to spend a free-looking concession.** The
architect offered to let the boundary-cycle reply survive for one word. I kept
the drop, because the pinned answer is the one a monitor can compute without
knowing where the implementation put its registers: "in `Transmitting` for the
whole of that cycle, leaving at its end" is the edge convention every other state
row in this programme uses, whereas making the reply survive requires machine
(A)'s exit and entry conditions to be ordered *within* a cycle — unobservable at
the ports, and exactly the kind of rule a seeded mutation can flip with no bench
noticing. The pinned rule also errs in the reported direction: the drop carries a
strobe, and REQ-510's normative sentence stays true on every cycle including the
boundary. A rule that is true on every cycle but one, with no document naming
which, is worse than a rule that costs one reply nobody can generate.

**On question (v) the cheaper topology turned out to be the more observable one,
which is not how that trade usually goes.** REQ-508 at M13 and REQ-604 at M14
apply the same arithmetic to the same two configuration fields. Routing the mask
to both keeps two independent evaluations of one formula, so a directed test can
drive one mask and assert the two modules agree — a differential check for free.
Routing the computed subnet-broadcast address instead would collapse them into
one producer, and a single fault in that computation would satisfy both benches
simultaneously and stay invisible until a real network disagreed. I said so
rather than just accepting the amendment, because the untaken alternative was
described as E2-shaped and would come back if the reason it was rejected is only
recorded as "cheaper".

**C-24 is a defect in the repair of my own finding and it is the third of its
kind.** D-2a moved REQ-502's derivation from 6 to 7, and §6.1 and §7 both now
claim the figure is constant at every accepted request length. It is not: it is 7
for frame lengths N ≡ 0, 1, 2 (mod 8) and 8 otherwise. What makes it worth the
ledger row is the *mechanism*, which is C-1's class exactly: §6.1 computes an
octet time (terminate − 5, plus M03's 16, M06's 10 and M08's 8 — all three
correct) and converts it to a cycle by division without accounting for the
residue. §0.5's machinery makes a **per-octet** latency residue-invariant by
construction; it does not cover a **cycle difference between two events at
different octet positions**, which is what REQ-502 measures. §6.1's own
parenthetical "(three, at a lane-0 terminate)" is correctly qualified — a lane-0
terminate is precisely N ≡ 0 (mod 8) — and then the unqualified conclusion is
drawn from it. I carried it rather than contested it because no committed hook
asserts 7: §8 measures and asserts the 64-cycle bound, §10 says "measure", and
requirements.md REQ-502 asserts only the bound. C-18 at WO-0013 and C-22 at
WO-0015 were the first two instances of a repair carrying a defect; recording the
third is the test of whether that was a sentence or a practice.

**Batch E is the strongest batch this programme has drafted, and the evidence for
that is not impressionistic.** Three carry-forwards are applied **before the
fact** rather than after: C-17(b)'s stall-count distinction is in SPEC-M15 §6.1
with the failing assertion named before any bench exists to fail; C-17(e)'s
residue-versus-`tkeep`-pattern lesson is in SPEC-M14 §8's directed set as total
length 28; C-23's counting convention is cross-referenced from SPEC-M14 §9.
SPEC-M16 §9's fork fact is the M16-level analogue of the C-21 finding I raised at
M10, written before a monitor existed to fail on it. And SPEC-M14 §9's argument
for *independent* strobe evaluation is the best piece of reasoning in the batch,
because it is testability reasoning rather than taste: a precedence order among
the six header conditions would be unobservable at the port, so no bench could
distinguish a conformant design from one suppressing the wrong strobe, while
independent evaluation makes the pulse set a function of the injected bits, which
a bench computes from its own stimulus. That pattern should be copied at M17.

**Where I set the line on batch E, and why it is the same line as at batch D.**
C-26 is the item I weighed hardest, because it is *behaviour*: SPEC-M14 §9's
truncation row states its branch condition temporally and enumerates the negative
branch extensionally, and the two disagree for every frame delivering 21 to 27
IPv4 octets against a larger declared total length. That is the shape of a
post-freeze behavioural diff, which is what I contested D-1 and D-2 to prevent.
It is a carry-forward and not a contest for one reason and I state it explicitly:
**requirements.md REQ-605 settles it** — "the payload's last word SHALL carry
`tuser`[0] = 1" forces the extensional reading — so a normative document one
level up states the correct answer, which is the identical ground on which I
signed eleven findings of this class at WO-0010 and WO-0013. D-1's distinguishing
property was that *no* section anywhere stated the correct reading and four sites
stated the wrong one. That distinction is the whole content of my signature, and
it has now cut in both directions in consecutive cycles.

**What I did not do.** I did not touch `docs/specs/**`, `docs/adr/**` or
`docs/gates/**`, though I wrote out the exact repair each of the seven
carry-forwards needs — they are the architect's text and the orchestrator's
checklist. I did not add `test/**` or `tools/**` machinery: the three pieces I
owe from WO-0015 are now unblocked (R-1 and D-2a landed, requirements.md §0.6 has
the counting convention, ADR-0008 has the precedence clause), but none of this
review's verification needed them — every check here was arithmetic I did by hand
or a script that already exists — and a commit carrying two countersignatures,
seven ledger items and code is harder to audit than one carrying the verdicts
alone. I did not widen the batch-D surface beyond the one place deliverable 2
required, and I said so in the packet rather than letting the widening pass
unremarked.

### Actions
- Verified the packet's own claim about the working tree rather than accepting
  it: `git diff 3f6accc 7a41a66 -- docs/specs/` empty and the full name-status
  diff confined to two packets, the orchestrator's journal, the gate checklist
  and the board.
- Confirmed CI runs 30739442056 (3f6accc) and 30739491408 (7a41a66) through the
  GitHub API, including the twelve-step job breakdown of the former; confirmed
  the `ifc_check` `dune` has no `(modules)` stanza, so the three new lifts are in
  the library the `Build` step elaborates.
- Ran `tools/check_records_vs_appendix.sh` (19 checks, 0 failures) and
  `tools/dv_checks.sh` (exit 0).
- Re-traced D-1 through SPEC-M11 §6.2's `Idle` row and SPEC-M13 §6.2 machine (A)
  including the M11-frees / machine-(A)-exits boundary and the
  request-before-reply case; re-checked all four counting sites and confirmed by
  diff that requirements.md REQ-510 did not move.
- Re-derived the REQ-502 chain term by term at N = 64, then generalised it over
  frame length by first principles and found the 7-or-8 alternation (C-24).
- Recomputed SPEC-M14's L = 12 from the octet mapping and ΔC = 4 by both of
  §0.5's routes; checked h = 20 and the ceiling of 5 against requirements.md
  §1.1; verified the six-of-seven decidability by field offset; proved the
  abort-bit inequality M + 3 ≥ K for every residue of N mod 8.
- Recomputed SPEC-M15's checksum halfword by halfword (sum 0x094B, emitted
  0xF6B4, residue 0xFFFF) and evaluated W − J and W − J + 1 over payload lengths
  1 … 39 against the specification's mod-8 classes: no exception.
- Checked SPEC-M16's wiring table for orphans in both directions; counted the
  twelve relayed strobes against requirements.md §12's owner column; confirmed
  3 + 1 + 4 = 8 against 3 + 1 + 5 = 9 and the front offset 34.
- Recounted architecture.md §6.4 mechanically by strict row shape (118 =
  26 + 40 + 30 + 22) and re-verified REQ set equality (110 = 110, symmetric
  difference empty).
- Appended the RETURNED verdict entry to
  `agents/handoffs/WO-0018_batch-de-countersign.md` and set its header state to
  RETURNED.
- Wrote nothing under `docs/`, `libs/`, `test/`, `tools/`, `.github/`,
  `scripts/` or `tasks/`.

### Evidence
All commands runnable from a repo checkout at this SHA (PROTOCOL §4.1 form (a))
or externally verifiable references (form (b)).

1. **Compile evidence, verified at source.** GitHub API,
   `renatom11/agentic-fpga`: run **30739442056**, workflow `build`, `head_sha`
   `3f6accc5edef709324b8085c141a3b39cf54e9d3`, status `completed`, conclusion
   **`success`**; job `build` (id 91474072304) with all twelve steps `success`,
   including step 5 `Build`, step 8 `DV mechanical checks (C-9
   record-vs-appendix, X-9 emitted Verilog)` and step 9 `Verify nothing was left
   unpromoted or non-deterministic`. Run **30739491408**, `head_sha`
   `7a41a6601dcc97c8d24e378c9888cdc8d9bd39d2`, conclusion **`success`**.
2. **The run's SHA is the specification commit**, so batch E needs no witnessing
   argument. For the working tree: `git diff 3f6accc 7a41a66 -- docs/specs/` →
   **empty**; `git diff --name-status 3f6accc 7a41a66` → exactly
   `M agents/handoffs/WO-0017_batch-e-specs.md`,
   `A agents/handoffs/WO-0018_batch-de-countersign.md`,
   `M agents/journals/claude_orchestrator_agent.md`,
   `M docs/gates/P1-spec-freeze-checklist.md`, `M tasks/BOARD.md`.
3. **`tools/check_records_vs_appendix.sh`** → `19 check(s) run, 0 failure(s)`,
   including `modules/ip_complete_64.md`, `modules/ip_eth_rx_64.md` and
   `modules/ip_eth_tx_64.md` §4.1 == their lifts, byte identical, and the four
   batch-D rows still passing. `tools/dv_checks.sh` → exit 0,
   `dv_checks: all checks passed` (4 checks, 0 failures, 4 pending — REQ-306,
   REQ-808, REQ-017 and REQ-903 remain `P1-module-ready` conditions).
4. **REQ set equality and the edge count, recomputed mechanically.**
   requirements.md REQ ids **110**, traceability.md **110**, symmetric
   difference empty. architecture.md §6.4 by strict four-cell row shape:
   **118 rows = 26 rx + 40 tx + 30 control + 22 status**.
5. **REQ-502, recomputed at N = 64 and then generalised.** Lane-0 start:
   terminate character at octet time 8 + 64 = 72, cycle 9. M08's routed payload
   word k of a frame leaves at cycle 7 + k (payload octet p enters XGMII at octet
   time 22 + p and leaves at 22 + p + 16 + 10 + 8 = 56 + p). A 46-octet payload
   is six words, so `tlast` is at cycle **12**, the gating cycle is **13**, M11
   offers at 14, M07 outputs at 15 and the reply's start character is at **16**;
   16 − 9 = **7** ✓, matching §6.1's table. Generalised with
   `tlast_cycle = 6 + ⌈(N − 18)/8⌉` and `terminate_cycle = 1 + ⌊N/8⌋`, REQ-502's
   derived figure is **7** for N ≡ 0, 1, 2 (mod 8) and **8** for N ≡ 3 … 7:
   N = 64 → 7, N = 67 → 8, N = 72 → 7, N = 1514 → 7, N = 1518 → 8. **C-24.**
6. **SPEC-M14's constants, derived not checked.** Payload octet 0 = IPv4 octet
   20, at position 4 of input word 2: input octet time 8Ci + 20, output octet
   time 8Ci + 32 at position 0 of payload word 0 (cycle Ci + 4), so **L = 12**;
   h = **20** (twenty octets stripped, word-aligned input, §0.5's second term 0);
   (L + h) = 32 ≡ 0 (mod 8); ΔC = 32/8 = **4** = (Ci + 4) − Ci — both routes
   agree. requirements.md §1.1 gives M14 h = 20 and ceiling **5**, largest
   permitted L = 20; the five allocated stages sum to 4+3+1+5+4 = **17** against
   REQ-006's 24. REQ-611: Ci → Ci + 3 = **3** cycles, one less than ΔC, which is
   what puts `ip_hdr_valid` one cycle before payload word 0.
7. **SPEC-M14's abort-bit inequality, proved.** ⌈(N − 20)/8⌉ + 3 ≥ ⌈N/8⌉ for
   N = 8q + r: r = 0 → q + 1 ≥ q; r ∈ 1…4 → q + 1 ≥ q + 1; r ∈ 5…7 →
   q + 2 ≥ q + 1. Holds in every residue, so the payload `tlast` never leaves
   before the input `tlast` has been seen.
8. **SPEC-M15's checksum.** Halfwords 0x4500, 0x002E, 0x0000, 0x0000, 0x4011,
   0x0000, 0xC000, 0x0201, 0xC000, 0x0209; one's-complement sum with both carries
   folded = **0x094B**; emitted checksum = **0xF6B4**; residue over the emitted
   header = 0x094B + 0xF6B4 = **0xFFFF** ✓, which is the value SPEC-M14 §6.1
   verifies.
9. **SPEC-M15's stall count, over the range.** For P = 1 … 39 with
   W = ⌈(20 + P)/8⌉ and J = ⌈P/8⌉: W − J = **2** for every P ≡ 1, 2, 3, 4 (mod 8)
   and **3** for every P ≡ 0, 5, 6, 7 (mod 8), no exception; stall count
   W − J + 1 = **3 or 4**. At REQ-708's P = 26: J = 4, W = 6, drain C+4 … C+6 ✓.
10. **SPEC-M15's payload storage, recomputed (below-threshold reading).** At
    cycle C + 1 + n the module has accepted 8(n + 2) payload octets and emitted
    8n − 12, so it holds **28** octets in steady state — four payload-word
    registers, not the two §3 and §6.1 state. Commissions nothing: REQ-019 has
    "no instance" at M15 and requirements.md REQ-019 states its payload-storage
    sentence "is design guidance and is explicitly not a DV observable".
11. **SPEC-M16, checked structurally.** Twelve relayed strobes = M06 (1) + M08
    (1) + M13 (3) + M14 (7), verified against requirements.md §12's owner column
    where M07, M09 and M15 own none. Receive chain 3 + 1 + 4 = **8** against
    3 + 1 + 5 = **9** allocated; front offset 14 + 0 + 20 = **34**. Transmit
    chain: SPEC-M09 §7 pins ΔC = 0 and SPEC-M07 §7 pins 1 cycle from acceptance
    of the first payload word, so `tx` carries M15's body word 0 **one** cycle
    after M15 emits it and **two** after M15 accepts the frame's first payload
    word — §7's anchor names the wrong one of the two events. **C-29.**
12. **C-20 re-derived rather than compared.** ARP octets 0–5 are 00 01 08 00 06
    04; under REQ-012 position k is `tdata`[8k+7:8k], so the 48-bit numeric value
    is 0x**04**06**00**08**01**00 = **0x040600080100** ✓, and with operation
    octets 6–7 = 00 01 the full request word is **0x0100040600080100** ✓ — both
    exactly as SPEC-M10 §6.3 item 4 now states them.
13. **No new CI run is cited for this commit** — it carries one packet and my
    journal, no code and no spec, so there is nothing for a build to verify
    beyond the journal check itself.

### Outcome
DoD of WO-0018 met on all four deliverables, with both signature decisions
explicit and positive.

> **I countersign batch D (SPEC-M10, SPEC-M11, SPEC-M12, SPEC-M13) for
> P1-spec-freeze at `3f6accc`.**

> **I countersign batch E (SPEC-M14, SPEC-M15, SPEC-M16) for P1-spec-freeze at
> `3f6accc`.**

Both sentences are for orchestrator transcription onto
`docs/gates/P1-spec-freeze-checklist.md` (PROTOCOL §7). The three batch-E §12
`Interface compile check` rows may be filled with run **30739442056**,
conclusion **`success`**, SHA **3f6accc**, and the three §11.1 items closed on
it; no witnessing sentence is owed because the run's head SHA is the
specification commit. Verdicts: batch D **COUNTERSIGNED**; **SPEC-M14 SIGNED**,
**SPEC-M15 SIGNED**, **SPEC-M16 SIGNED**.

Answers: **(i) ACCEPT 7 — gate both, do not split the gate**, because the reply
is the worse half to leave ungated, not the better one; **(ii) KEEP the boundary
cycle as pinned** (the reply is dropped), because determinacy and monitor
computability both point the same way; **(iii) the `error_ip_truncated`-alone
rule is CORRECT and endorsed**, and independent evaluation of the other six is
the stronger half of the same decision and should be copied at M17 — one scoping
sentence owed as C-26; **(iv) KEEP the two-owner REQ-610/REQ-807 rows with their
`pending` halves**, because a single-owner row would manufacture an invisible
hole, and my batch-F countersignature is the enforcement; **(v) ACCEPT the
`M20.cfg_subnet_mask → M14.cfg_subnet_mask` edge** — not E2, and the untaken
alternative should stay untaken because routing the mask preserves two
independent evaluations of one formula that a differential test can exploit.

Ledger: **C-19, C-20, C-21, C-22, C-23 all REAFFIRMED**, each checked at its
landing site; C-22 additionally **discharged at its first new instance** in the
same commit that created it (SPEC-M15 §7 is written against the clause). Seven
new carry-forwards, none blocking: **C-24** (REQ-502 derives at 7 **or 8**, not
constant — a defect in the repair of my own finding, and C-1's error class),
**C-25** (SPEC-M13's "later of" branch stated for one length where it holds for
five, priced at 42 octets where §0.3 gives 46–50, and no stage holding
`tuser`[0] in it), **C-26** (SPEC-M14 §9's temporal-versus-extensional truncation
branch, and whether `ip_hdr_valid` pulses at exactly 20 delivered octets),
**C-27** (REQ-611's parse-latency constant is gap-sensitive while REQ-611 claims
otherwise), **C-28** (REQ-505's two-half split does not tile on M13's side, and
its hook asserts at a port M13 does not have), **C-29** (SPEC-M16 §7's
transmit-chain anchor off by one event), **C-30** (SPEC-M14 §8 criterion 1 lacks
the `clear` conservation exemption C-21 just landed at SPEC-M10 §8).

Handoff: `agents/handoffs/WO-0018_batch-de-countersign.md`, state RETURNED,
carrying the four verdicts, the recomputations, the five answers with their
grounds, the ledger table, three below-threshold readings and the six DV actions
this review created or unblocked.

### Open-questions
1. **Sixteen of twenty specifications now stand frozen on two sentences, and the
   remaining risk is concentrated in C-26.** It is the only one of the seven
   carry-forwards that is *behaviour* rather than a number or a wording, and it
   is cheaper to state before SPEC-M14 is implemented than to diff after freeze.
   Its gate is `AP-ip_eth_rx_64.md` and the M14 rtl_lead `WO-`, whichever comes
   first.
2. **Batch F is where three two-half splits are checked, not one.** REQ-610's
   second half is SPEC-M18's, REQ-807's is SPEC-M20's, and REQ-505's already-
   written second half needs C-28's repair at SPEC-M13. I will not countersign
   batch F while any of the three is one-sided, and I have said so in the packet
   so that it is a stated condition rather than a surprise.
3. **The three pieces of machinery I owe are unblocked and I chose not to write
   them here.** The third header-record monitor case (a record with a native
   `ready`), the strobe high-cycle counting convention, and the C-22 monitor
   clause all now have settled text to implement against. They belong in the next
   DV work order, not in a commit carrying two countersignatures.
4. **C-2 is my oldest unrepaired finding and is now load-bearing at two modules**
   — M10 under C-21 and M14 under C-30. The next time it appears it should be
   repaired at requirements.md §0.6 once rather than per module.
5. **Still open and unchanged**: C-3, C-5, C-7, and C-9's REQ-903 half;
   `of_source` still imports `Ifc_check.Axi64_ifc.Axi64` and must be retargeted
   now that rtl_lead has built M01; `hardcaml_verilator` plus a `verilator`
   binary against REQ-901; and the fifth REQ-901 divergence class C-7 asks for —
   batch E declares class (a) at M14 and (c) at M15, which is the first batch
   where the declared classes bind a specification's own stimulus.

### Files-in-this-commit
- agents/handoffs/WO-0018_batch-de-countersign.md

## [J-dv_lead-0010] 2026-08-02T15:05:00Z | task:WO-0020 | Batch-F countersignature WITHHELD at aaa55b2: M18/M19/M20 SIGNED, SPEC-M17 CONTESTED on F-1 (an abort bit copied from a word that has not arrived); seven questions answered, ADR-0011 endorsed with a correction owed against its own text; C-24…C-30 and twelve §11 closures reaffirmed; C-31 … C-36 raised

### Trigger
Orchestrator spawn under work order WO-0020 (ISSUED at 7185649), spawn short-id
`WO-0020/2026-08-02T13:45Z`. Tenth activation. The sixth and final countersign
cycle of P1-spec-freeze: on a positive verdict all twenty Phase-1 specifications
freeze and the gate goes to the sponsor.

### Inputs
- `agents/charters/dv_lead.md` (§3 spec-derived verification, §5 DoD, §6
  evaluation criteria, §7 escalation, §8 journaling); `agents/PROTOCOL.md` §4
  (entry grammar), §6 (write scope), §7 (gates, transcription), §10
  (independence and evidence).
- `agents/handoffs/WO-0020_batch-f-countersign.md` at 7185649 (with the
  orchestrator's uncommitted evidence appendix) — my work order.
- `agents/handoffs/WO-0019_batch-f-specs.md` Return log **in full**, including
  the seven ordered questions, the eleven-claimed §11 closures, the C-24…C-30
  dispositions, the two conventions answers and the ACCEPTED block.
- **Batch F at aaa55b2, all four read in full**: `docs/specs/modules/
  udp_ip_rx_64.md` (SPEC-M17), `udp_ip_tx_64.md` (SPEC-M18),
  `udp_complete_64.md` (SPEC-M19), `nic_top.md` (SPEC-M20); their four lifts in
  `docs/specs/ifc_check/` plus that directory's `dune`.
- `docs/adr/ADR-0010-consumer-conventions-for-the-frozen-records.md` and
  `docs/adr/ADR-0011-under-delivery-leaves-the-transmit-path-unterminated.md`,
  both in full; ADR-0008's C-22 precedence clause.
- **Frozen text re-read for the derivations rather than trusted through
  summaries**: SPEC-M03 §7 (both start lanes), SPEC-M05 §7, SPEC-M06 §7,
  SPEC-M08 §7, SPEC-M14 §7/§8/§9/§13, SPEC-M15 §6.1 (steps 1–4), §6.2, §7,
  §8, §12, SPEC-M16 §7/§13, SPEC-M04 §9 in full and its `cfg_tx_enable` rows,
  SPEC-M13 §13, SPEC-M10 §11.2/§11.4.
- `docs/specs/requirements.md`: §0.5 in full, §0.6, §0.7, §1.1 and its new
  currency table, REQ-004 … REQ-021, REQ-605, REQ-610, REQ-703 … REQ-710,
  REQ-801 … REQ-810, §9.1, §11's non-requirements table, §12, §13's revision
  rows. `docs/specs/traceability.md` (all batch-F rows and the REQ-810,
  REQ-707, REQ-708, REQ-610, REQ-807 rows). `docs/specs/architecture.md` §6.4
  in full.
- `docs/gates/P1-spec-freeze-checklist.md` at 7185649.
- My own `J-dv_lead-0008` (the standard for contesting rather than carrying) and
  `J-dv_lead-0009` (the batch-D/E line, and C-24 … C-30 as I raised them).
- CI: runs **30742781586** (aaa55b2) and **30742821837** (7185649), both fetched
  through the GitHub API with their step breakdowns, not accepted from the
  packet.
- **`libs/**` was never opened, in this or any previous activation.** No RTL
  exists for any batch-F module; every figure below is arithmetic from
  specification text or an existing script.

### Reasoning
**I withheld the last signature of the gate, and the fact that it is the last is
the reason to hold it rather than to grant it.** The work order says that on a
positive verdict twenty specifications freeze and the gate goes to the sponsor.
That framing is exactly the pressure a countersignature exists to resist. F-1
costs one architect activation and one CI run to repair in DRAFT text; after the
flip the identical repair is a post-freeze **§6 behavioural** diff — which is the
second of the three grounds ADR-0011 itself gives for refusing its own
alternative (a) at M04. I am not willing to manufacture at M17, in the last hour,
the cost the batch's own ADR spends three paragraphs declining to pay.

**F-1 is D-1's shape and I applied D-1's test, not D-1's feeling.** The test I
wrote at WO-0015 and applied in both directions at WO-0018 is: carry when a
document one level up states the correct reading (C-26, settled by REQ-605) or
when no committed hook asserts the wrong one (C-24); contest when no section
anywhere states the correct reading and several state the wrong one. At M17,
**five sites** state that the application `tlast` word carries `tuser`[0] copied
from the input `tlast` word — §3's REQ-007 row, §4.2's port row, §6.1's proof and
its conclusion, §6.2's `Payload` row, §10's REQ-007/REQ-013 hook — and **no
site** states what M17 emits when that word has not arrived. §6.3 does not list
the value among the deliberately unconstrained. requirements.md REQ-007 settles
it in the impossible direction. The test returns contest, and I would have had to
argue myself out of my own standard to sign.

**How I found it, because the route matters for the auditor.** I did not go
looking for it. I was recomputing §6.1's abort-availability argument as an
ordinary check of a proof the specification offers — the same way I recomputed
M14's M + 3 ≥ K inequality at WO-0018, which held — and the algebra came out
backwards: the text argues "Since N′ ≤ N, M + 1 ≥ ⌈(N − 8)/8⌉ + 1 ≥ K", and
N′ ≤ N gives M ≤ ⌈(N − 8)/8⌉. The residue identity beside it is correct and
proves the **equality** case, which is the full-delivery case and no more. Then
the `Tail` state — which §6.2 goes out of its way to insist "is not dead code" —
is precisely the class where the equality fails, and §8 drives it with IPv4 total
length 46 against UDP length 20. So the specification commissions a directed test
for a class on which its own feasibility proof does not hold.

**The three regimes, worked out before I decided anything.** With N the octets
IPv4 delivered, N′ the UDP length, K = ⌈N/8⌉, M = ⌈(N′ − 8)/8⌉: the input
`tlast` is at Ci + K − 1 and the application `tlast` at Ci + M + 1. Availability
needs ⌈N′/8⌉ = ⌈N/8⌉. One word of under-declaration makes the two coincide (§8's
own datagram: K = 4, M = 2, both at Ci + 3), which would need a combinational
`ip_payload_tuser` → `payload_tuser` path on the emitting cycle that no section
sanctions; two words or more makes the application `tlast` leave **strictly
before** the input `tlast` arrives, up to 182 cycles early at N = 1480, N′ = 9,
which no implementation can do. I checked that the case is not vacuous before
raising it: a bad-FCS frame carries `tuser`[0] = 1 down the whole chain and its
corrupted UDP length field may under-declare by any amount, so a conformant M17
can be *required* by REQ-007 to mark a bit it cannot have. And I noted that the
defect does not even need an abort — with `tuser`[0] = 0 upstream, §6.2 still
directs a copy from a word that has not arrived, so the emitted value is
unspecified for every under-declaring datagram and a monitor has nothing to
assert.

**Why I priced the repair at three clauses and named the value.** I could have
contested and left the fix open. I did not, because a contest whose repair is
undetermined costs a round trip: at WO-0015 I gave the architect R-1/R-2 and
D-2a/D-2b to choose between and the choice came back better than my
recommendation. Here there is only one implementable value — `tuser`[0] = 0 on
the application `tlast` word when the declared count completes first, because no
abort has been observed at that point — so I named it, said what the alternative
(making it unconstrained in §6.3) would require, and said which REQ-007 reading
avoids a normative requirements diff: REQ-007's subject is "every downstream
module that emits an output frame **for it**", and an under-declaring datagram's
application frame is a frame for the declared datagram rather than the delivered
one. That reading has to be *stated*, which is clause 3, but it keeps the repair
editorial.

**Three specifications signed, and the signatures are not consolation.** M18's
W − J = 1 is the sharpest single derivation in the batch and I recomputed it from
the events rather than the formula: M18 adds exactly one word at every payload
length with no residue classes, acceptances fall on C … C + J − 1 and emissions
on C … C + J, so the emission window contains all J acceptances and exactly one
stalled cycle. Against M15, whose first body word leaves at C + 1 so its window
contains J − 1 acceptances and W − J + 1 stalls — three, in its own worked frame.
The architect's generalisation, "W − J + 1 is not a programme constant; it is a
consequence of where the first output word sits relative to the first
acceptance", is a better statement of C-17(b) than the one I wrote when I raised
it, and I said so in the packet. M20's REQ-006 = 13 checks by the stage sum
(3 + 3 + 1 + 4 + 2), by the octet route ((54 + 50)/8 = (50 + 54)/8) and by a
third route the architect did not claim — requirements.md §1.1's own Σ h row
(50 / 54) agreeing with M20 §7's totals. The 11-cycle itemisation audits term by
term: reserve 1 + 0 + 0 + 1 + 2 = 4 at M03/M14/M17, architect's slack 24 − 17 = 7,
and 13 + 4 + 7 = 24.

**On ADR-0011 I endorsed the decision and then found a defect in the ADR
itself.** The decision is right for a testability reason rather than a design
one: `clear` is a **top-level port** whose effect is already stated at five
modules' §7, so the recovery is observable and drivable without inventing a
mechanism, while alternative (c)'s back-signal would have coupled four modules
through a signal with no port at which the abandonment is visible. The pricing is
right too, and ground 1 is the one I would have led with, because SPEC-M04 §11.2
records **my own** WO-0010 classification of the REQ-206/REQ-207 interaction as
compelled by REQ-207's unconditional wording — reversing that at the freeze gate
would reopen a closed item of mine, and "a real NIC would want it" is not an
argument at this phase. But ADR-0011's Consequences says SPEC-M04 §9 "**now
says** ordered-and-unpinned" and its Affects header lists SPEC-M04 §9, and
neither is true: the bullet still reads "pulse **together**", bolded, exactly as
the WO-0019 Return log correctly says it was left. requirements.md REQ-709's new
column compounds it by citing SPEC-M04 §9 for the same reading. That converts
question 7 from a judgement call into an owed correction: had the question been
only whether a bench writer might misread "pulse together", I would have carried
it, because SPEC-M18 §6.3 item 5, §9 and REQ-709's column all state the correct
reading. It does not carry, because two committed documents now cite a frozen
spec for the opposite of what it says, and an ADR describing a diff nobody made
is a worse artifact than an unedited bullet.

**Where I chose to carry rather than contest, and why each is defensible.** C-32
(the `hdr_valid` lead is gapless-only while four sites state it unconditionally)
carries because §6.1 explicitly scopes its cycle formulas to a gapless stimulus,
so the correct reading exists in the document — and because the figure §7 calls
gap-invariant genuinely **is** gap-invariant; it is the *derived* lead that is
not. C-33 (M19 §9 fact 2's locality claim) carries because the operative
instruction — count frames, not pulses — is correct and is what a monitor needs;
only the claim about where it first bites is wrong. C-34 (M18's `Body` exit
overlap) carries because §9's pinned strobe cycle and §8's own assertions both
imply the `Excess` reading, so a careful implementer gets there. C-35 (184 versus
185) carries because §10 states the right number. Each of the four would have
been a contest if the correct reading existed nowhere; each is a ledger row
because it exists somewhere. That distinction is the whole content of my
signature and it has now cut in both directions in three consecutive cycles.

**Two counting corrections I offer as corrections.** WO-0019's Return log says
"six" §13-recorded diffs and lists three plus three plus one, and seven rows
exist; and it says "eleven" §11 closures where twelve rows read CLOSED (WO-0019).
Both undercount the architect's own work. I recorded them because a ledger whose
arithmetic is carried forward wrong stops being a ledger, which is the same
reason C-24 was worth a row.

**What I did not do.** I did not touch `docs/specs/**`, `docs/adr/**` or
`docs/gates/**`, though every owed diff is written out to the clause in the
Return log — they are the architect's text and the orchestrator's checklist. I
added no `test/**` or `tools/**` machinery: every check here was arithmetic by
hand or an existing script, and a commit carrying a contest, three signatures and
six ledger items is easier to audit without code in it. I bounded the re-review
surface in advance, as I did at WO-0015, so the architect can price the repair
before writing it.

### Actions
- Verified the specs-unchanged claim myself: `git diff --stat aaa55b2 7185649 --
  docs/specs/ docs/adr/` is empty; only the two packets, the orchestrator
  journal, the gate checklist and `tasks/BOARD.md` moved. Review SHA fixed at
  **aaa55b2**.
- Fetched both CI runs through the GitHub API with step breakdowns; confirmed
  run 30742781586 is workflow `build` at head SHA aaa55b2 with conclusion
  `success` and all twelve steps green, and that the four new lifts sit in the
  single `ifc_check` library so `Build` green is their first elaboration.
- Re-ran `tools/check_records_vs_appendix.sh` (23 checks, 0 failures) and
  `tools/dv_checks.sh` (exit 0) at the working tree.
- Recomputed REQ set equality by script (110 = 110 = 110 distinct, symmetric
  difference empty, no Spec-section cell reading `pending`) and recounted
  architecture.md §6.4 by strict row shape (119 = 26 + 40 + 31 + 22, the
  `cfg_tx_enable → M18` row present).
- Re-derived, by hand: M17's L/h/ΔC by both of §0.5's routes; M17's abort
  availability in all three regimes (**F-1**); M18's W − J = 1 against M15's
  W − J + 1 from the two modules' worked frames; M19's chain of 10 against 13
  and its 12 + 2 + 1 = 15 and 15 + 6 = 21; M20's REQ-006 = 13 by the stage sum,
  by the octet route at both lanes and against §1.1's own Σ h row, plus the
  11-cycle itemisation term by term; C-24's residue rule from first principles
  (7 for N ≡ 0,1,2 (mod 8), else 8; N = 64 → 7, 67 → 8, 1518 → 8); C-25's five
  frame lengths 46–50; the one-application-word figure behind the
  `cfg_tx_enable → M18` edge, from SPEC-M15 §6.1 step 3.
- Counted the §13 rows (seven, not six) and the WO-0019 §11 closures (twelve,
  not eleven) by grep across `docs/specs/modules/`.
- Wrote the Return log into `agents/handoffs/WO-0020_batch-f-countersign.md`:
  four verdicts, seven answers, the ledger reaffirmation, C-31 … C-36, the owed
  diff list, the bounded re-review surface and the pre-worded sentence.

### Evidence
Reproducible from a checkout at this commit:

- `git diff --stat aaa55b2 7185649 -- docs/specs/ docs/adr/` → **no output**
  (specs and ADRs byte-identical between the spec commit and the working tree).
- `bash tools/check_records_vs_appendix.sh` → **23 check(s) run, 0 failure(s)**,
  including the four batch-F rows `modules/{udp_ip_rx_64,udp_ip_tx_64,
  udp_complete_64,nic_top}.md §4.1 == ifc_check/<name>_ifc.ml (byte identical)`.
- `bash tools/dv_checks.sh` → exit 0, `4 check(s) run, 0 failure(s), 4 pending`,
  `check_emitted_verilog.sh: OK`, `dv_checks: all checks passed`.
- REQ set equality, recomputed: requirements.md **110** bolded row leaders,
  traceability.md **110** rows and **110** distinct, symmetric difference
  **empty**, zero Spec-section cells reading `pending`.
- architecture.md §6.4 recounted by strict row shape: **119** edges =
  **26 + 40 + 31 + 22**; `M20.cfg_tx_enable → M18.cfg_tx_enable` present in
  §6.4.3 beside the M04 row.
- `grep -c "CLOSED (WO-0019)" docs/specs/modules/*.md` → **twelve** rows across
  nine files (M03, M05, M06, M08, M10 ×2, M13, M14, M15, M16 ×3).
- **Externally verifiable references** (GitHub API, this repository): workflow
  run **30742781586** — workflow `build`, event `push`, head SHA
  `aaa55b288e4ea580dfb157132c8aa478a10133b9`, conclusion **`success`**, steps
  `Build`, `Run tests`, `Generate RTL`, `DV mechanical checks` and `Verify
  nothing was left unpromoted` all `success`; run **30742821837** — head SHA
  `71856497340569733555caef1b5a5607aaec7ac8`, conclusion **`success`**.
- **F-1's arithmetic, reproducible with pencil from SPEC-M17 §6.1 alone**: input
  `tlast` at Ci + K − 1 with K = ⌈N/8⌉; application `tlast` at Ci + M + 1 with
  M = ⌈(N′ − 8)/8⌉; availability iff ⌈N′/8⌉ = ⌈N/8⌉. §8's under-declaring
  datagram (N = 26, N′ = 20) gives K = 4, M = 2 — both `tlast` words on cycle
  Ci + 3. N = 26, N′ = 9 gives K = 4, M = 1 — the application `tlast` leaves one
  cycle **before** the input `tlast` arrives. N = 1480, N′ = 9 gives 182 cycles
  early.
- **REQ-006 = 13, both routes**: 3 + 3 + 1 + 4 + 2 = 13; (16+10+8+12+8) +
  (8+14+0+20+8) = 54 + 50 = 104, 104/8 = 13 at lane 0; (12+10+8+12+8) +
  (12+14+0+20+8) = 50 + 54 = 104, 104/8 = 13 at lane 4. 13 × 6.4 ns = 83.2 ns
  against 24 cycles / 153.6 ns. Slack: (4−3)+(3−3)+(1−1)+(5−4)+(4−2) = 4 module
  reserve, 24 − 17 = 7 architect's slack, 13 + 4 + 7 = 24.
- **M18's stall count**: W = ⌈(P+8)/8⌉ = ⌈P/8⌉ + 1 = J + 1 at every P; for P = 18,
  J = 3 and W = 4, acceptances at C, C+1, C+2 and emissions at C … C+3, so
  `payload_tready` = 0 on C+3 alone — **W − J = 1**. M15's worked frame: J = 4,
  W = 6, `payload_tready` = 0 at C+4, C+5, C+6 — **W − J + 1 = 3**.

No ephemeral artifact is cited. No claim above rests on RTL, which does not exist
for these modules.

### Outcome
**DoD partially met by design, and the gap is the deliverable.** Four verdicts
delivered (three SIGNED, one CONTESTED); the seven questions answered in order;
C-24 … C-30 reaffirmed as landed with two arithmetic corrections to the Return
log's counts; the §11 closures reaffirmed at twelve; ADR-0010's two answers
accepted and ADR-0011's decision and pricing endorsed. **The countersignature
sentence is not given**, because deliverable 5's condition — all four verdicts
positive — is not met; the exact owed-diff list is given instead, with the
re-review surface bounded in advance and the sentence pre-worded for the repair
commit. Handoff: `agents/handoffs/WO-0020_batch-f-countersign.md` Return log, to
the orchestrator for relay to architect_docs_lead.

### Open-questions
- **F-1 blocks the batch-F flip and therefore the gate.** One architect
  activation plus one CI run. No escalation class: this is normal packet flow
  under charter §7, not an E5 — there is no dispute yet, only a finding.
- **C-31 needs the architect to choose** between the SPEC-M04 §13 diff
  (recommended) and a correction to ADR-0011's Consequences and Affects. Either
  closes it; neither is mine to write.
- **If the architect judges that REQ-007 needs a scoping clause** rather than the
  M17-side statement of clause 3, F-1's repair becomes a normative requirements
  diff rather than an editorial one. That is a legitimate answer and I will
  re-review on that basis, but it should be declared in the Return log rather
  than discovered at re-review.
- C-2, C-3, C-5, C-7 and C-9's REQ-903 half remain open and unchanged by this
  batch; C-32 … C-36 join them with the gates stated in the packet.

### Files-in-this-commit
- agents/handoffs/WO-0020_batch-f-countersign.md

## [J-dv_lead-0011] 2026-08-02T16:00:00Z | task:WO-0022 | Batch F countersigned at d8df28d after the bounded re-review — F-1 repaired in full, ALL TWENTY Phase-1 specs FROZEN; the two out-of-surface sites judged under C-28 (one accepted, one wrong at D = 1 and the wrong word is mine); C-37 raised — F-1's twin at the FROZEN SPEC-M14, found by falsifying §11.4's own generalisation; C-38 … C-40

### Trigger
Orchestrator work order `agents/handoffs/WO-0022_batch-f-rereview.md`, spawn
short-id `WO-0022/2026-08-02T16:00Z`, eleventh activation. The bounded batch-F
re-review I pre-priced at the WO-0020 Return log §5, on the repair the architect
landed at `d8df28d` under WO-0021. My eleventh unit of work and the last item of
`P1-spec-freeze` before the sponsor's signature.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §6, §7, §10).
- `agents/handoffs/WO-0022_batch-f-rereview.md` (the work order, in full).
- `agents/handoffs/WO-0021_f1-repair.md` — the architect's Return log in full,
  including its §2 quotations of the two out-of-surface sites.
- `agents/handoffs/WO-0020_batch-f-countersign.md` — my own §1 (the F-1
  derivation and owed-diff list), §4 (C-31 … C-36) and §5 (the bounded surface
  and the pre-worded sentence).
- Specs, at `d8df28d` and at the working tree (verified identical):
  `docs/specs/modules/udp_ip_rx_64.md` (§2, §3, §4.2, §6.1, §6.2, §6.3, §8, §9,
  §10, §11.4), `docs/specs/modules/udp_ip_tx_64.md` (§3, §6.2, §6.3, §8, §9,
  §10, §11.4), `docs/specs/modules/xgmii_tx_64.md` (§9, §13).
- For the C-37 derivation, read **after** the batch-F verdict was formed and
  because SPEC-M17 §11.4 named them as a falsifiable claim:
  `docs/specs/modules/ip_eth_rx_64.md` (§2, §3, §6.1, §6.2, §8, §10) and
  `docs/specs/modules/arp_eth_rx.md` (§3's REQ-007 row, §6.2's `Tail` row).
- `docs/specs/requirements.md` (REQ-007, REQ-013, REQ-707, REQ-709, REQ-710);
  `docs/adr/ADR-0011-under-delivery-leaves-the-transmit-path-unterminated.md`
  (Affects header, Consequences).
- CI: GitHub Actions run **30744579228** (`build`), read via the API.
- **No RTL.** `libs/**`, `top/**` and `rtl_snapshots/**` were not opened at any
  point in this review (PROTOCOL §10). C-37 was derived from
  `docs/specs/modules/ip_eth_rx_64.md` text alone.

### Reasoning

**The standard I applied, stated first because every disposition below turns on
it.** `P1-spec-freeze` asks me for *testability*: can a bench be derived from
this text, and does a conformant design pass it while a non-conformant one
fails? That is the line separating every contest I have raised from every item
I have carried. F-1 failed it outright — five sites commissioned an assertion
no implementation could satisfy and no site said what to emit instead. I made
myself re-apply the test item by item rather than let the momentum of "one
signature from 20/20" do the work.

**The surface held, and in two places the repair beat my own text.** I
re-derived the separation from §6.1's own cycle formulas rather than reading the
architect's: input `tlast` at Ci + K − 1, application `tlast` word at Ci + M + 1,
M = ⌈N′/8⌉ − 1, so the separation is ⌈N′/8⌉ − ⌈N/8⌉ + 1 = 1 − D and a registered
output carries the bit iff D = 0. The regime table, the 182 at N = 1480 / N′ = 9
(reproduced as D − 1, not quoted), the scoped residue algebra, the over-declared
case at application word K − 2 leaving at Ci + K — all reproduce. The two
improvements on what I commissioned are the **octet-vs-word distinction**
(N = 25/N′ = 24 is D = 1 on one octet; N = 32/N′ = 25 is D = 0 on seven, and
seven is the maximum that stays D = 0) and the **D = 0 boundary companion** at
§8. The companion is the sharper of the two: its declared count's last octet is
the first octet of the input `tlast` word, so `Tail` is never entered although
the datagram under-declares by seven — it is the executable proof of the
`Tail` ≡ D ≥ 1 pin, not a second stimulus. I had asked for the class; the
architect gave me the boundary, which is what a bench actually needs.

**Why I endorse §11.4's carry rather than treating it as a dodge.** The
asymmetry is my own argument applied where it points the other way: F-1's price
rises at the flip (DRAFT §6 text now, post-freeze *behavioural* diff later), the
REQ-007 scoping clause's does not (`requirements.md` is already FROZEN, so a
normative requirements diff costs the same today and at any later date). I
checked two things rather than accepting them. The flip-invariance is not
*total* — the clause's cost includes each implementer's REQ-007 hook, and M19's
is DRAFT today — but that is one editorial hook against a normative requirements
diff, so the dominant term is flip-invariant and the conclusion survives; I
recorded the caveat so nobody later reads "flip-invariant" as "free". And
decisively: my WO-0020 condition was that my reading of REQ-007 be **stated**
rather than inferred, and it is now stated at six sites with §10 asserting both
halves. Nothing is left to an implementer's judgment. That was the condition; it
is met.

**The two out-of-surface sites, under C-28.** I re-derived both rather than
accepting the quotes. §4.2's is right and pins D = 0. §3's is **wrong at
D = 1**: it scopes the copy to "on or after" the input `tlast`, and "on or
after" admits the same cycle, which is exactly the D = 1 case a registered
output cannot serve. The architect's §6.1 ("only where that number is
**positive**") is tighter and correct. **The wrong phrase is mine** — my WO-0020
clause 2 said "on or after" and the architect transcribed my clause faithfully.
I considered withholding for it and rejected that: five sites pin D = 0, §10's
hook pins it with a parenthetical, §8 drives the D = 1 datagram twice with
opposite input bits asserting 0 both times, and no bench derives from §3. It is
a one-word fix and it fails no part of the testability test. Spending a
twenty-spec gate on a word I wrote wrong myself, which the architect's own text
already corrects, would be theatre rather than rigour. It goes on the ledger as
C-40 with the four unqualified relay statements I found by grepping every
`tuser` mention in SPEC-M17 (§2 twice, §3's REQ-013 row, §4.2's *input* row) —
one sweep, one activation.

**C-37 is the reason this entry is long, and the reason I want the reasoning in
the diff rather than the conclusion.** §11.4 offers its generalisation as
falsifiable — "that sentence is the generalisation I owe a reader, and it is
falsifiable". I falsified it. M14's output frame extent is fixed by the IPv4
total length, a count declared inside the data, and its `Tail` state exists to
consume Ethernet padding — M14's D ≥ 1. From SPEC-M14's own formulas the
separation is ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4, so for a padded 64-octet frame (N = 46,
K = 6) every total length 21 … 36 emits the payload `tlast` word on or before
the input `tlast` is presented — total length 28 emits it a full cycle early —
and §6.1's "the abort bit is always available in time" runs the identical
backwards inequality F-1 did. It is worse than F-1 on two counts: SPEC-M14 §10's
REQ-007 hook is unscoped and commissions an assertion no conformant design can
pass on §8's own directed frames, and the system consequence is that a bad-FCS
minimum-length frame carrying a short UDP datagram reaches the application
unmarked — REQ-104 → REQ-007 → REQ-707 broken for the commonest small frame,
needing no corrupted length field to reach, unlike M17's class.

I bounded the falsification rather than asserting it: exactly three specs have a
`Tail` state (M10, M14, M17); M10 is safe because it emits no stream at all
(SPEC-M10 §3's REQ-007 row), and M03, M06, M08, M16 and M19 have no in-data
count. **M14 is the sole falsification**, so §11.4's sentence needs M14 moved
from the safe list and the generalisation restated over two modules.

**Why C-37 does not block, argued rather than asserted, because this is the
judgment the auditor should be able to check.** Four reasons and one honest
concession. (1) The substance is at SPEC-M14, frozen at 3f6accc at a passed
gate; withholding batch F repairs nothing there. (2) Its batch-F footprint is
one non-normative sentence in a Deferred-items rationale cell — it constrains no
implementer and commissions no test, so SPEC-M17 passes the testability test;
its correction is a post-freeze §13 row, the same class as C-31, which I
explicitly declined to make a condition of anything. (3) The M14 repair's price
is flip-invariant by §11.4's own rule, so there is nothing to buy by blocking.
(4) The repair is a genuine design decision — hold M14's payload `tlast` to the
input `tlast` at REQ-005's cost, or scope REQ-007 and derive 0 as F-1 resolved
one module down — and it wants an ADR and its own activation with §6.1, §6.2,
§10 and §8 moving together; squeezing that into a gate-closing commit is exactly
how a decision gets made for the wrong reason. **The concession**: had SPEC-M14
been DRAFT today I would have contested it, on the two grounds that made F-1 a
contest — `requirements.md` REQ-007 settles it in the impossible direction, and
a committed hook asserts the wrong reading. It is a ledger row because of its
**location**, not its severity, and I said so in the packet so that this
signature is never read as a judgment that C-37 is small.

**C-37 confirms the architect's carry rather than undermining it**, which is
worth stating because the opposite reading is available: a REQ-007 scoping
clause with two customers is more obviously the right instrument than a
per-module note with one. The carried alternative was the right shape; it now
has a second gate, `SO-ip_eth_rx_64.md`, alongside `SO-udp_ip_rx_64.md`.

**C-38, and why it is a carry where F-1 was a contest — the distinction is the
whole of my line.** SPEC-M18 §6.2 lets a word-aligned over-delivery escape
REQ-710: when the declared count is a multiple of 8, the word completing it
carries no octet beyond it, so `Body` exits to `Drain`, which drops
`payload_tready` with the application's `tlast` pending, pulses no strobe and
returns to `Idle` where the stale word becomes the next frame's word 0. Declare
96 and supply 104 is the case; §8 item 4's declared 100 is not a multiple of 8
and never drives it. That is precisely the pathology my own C-34 named, on the
trigger C-34 did not name — and the C-34 repair I commissioned **hardens** it by
making `Drain` unambiguously the exit where the older wording left room to
argue. So it is partly my doing and it is inside the blast radius of my own
correction, which is why I refused to let its location outside the letter of my
surface decide it. What decides it is the C-26 line: **`requirements.md` REQ-710
states the correct reading one level up** ("SHALL discard the excess words while
continuing to accept them so the application is never stalled, and SHALL pulse
`error_tx_length_mismatch` once") **and §10's REQ-710 hook asserts it
correctly**. Both of my carry criteria are met, where at F-1 neither was and
REQ-007 made things worse rather than better. The difference between an
expensive post-freeze diff and an expensive *undecided* one is the difference I
have contested on all along, and I am not going to blur it in either direction
at the last item of the gate.

**My own escape, recorded before anyone else records it.** SPEC-M14's text was
in front of me at WO-0018 and I countersigned batch D/E without catching it.
Root cause: at WO-0018 I checked M14's abort argument for internal consistency
against its own worked example, which is the *no-padding* case (N′ = N) where
the separation is 1 or 2 and the claim reproduces — I never quantified over the
padding regime that M14's own `Tail` state exists to serve. I found it now only
because F-1's derivation taught me the shape (an output frame whose extent is
set by an in-data count cannot inherit a bit that arrives with the input frame),
and because the architect wrote §11.4's generalisation in falsifiable form and
invited the check. Both halves belong in the record: the escape is mine, and the
repair's own text is what surfaced it. The lesson generalises into my attack
plans — **every module with a `Tail`-like state gets an abort-availability row
computed over the full range of the deficit, not checked against the worked
example** — and it is the first row of the M14 and M17 attack plans. The auditor
owns the DV-escape ledger (PROTOCOL §10); this entry is the root cause it will
want and I will cooperate with its recording.

**What I did not reopen.** Everything WO-0020 signed: M17's L = 8 / h = 8 /
ΔC = 2, its precedence scoping, its strobe cycles and its stress arithmetic; and
all of M18, M19 and M20 beyond the two byte-wise corrections — with the single
exception of C-38, which I raise as a ledger row rather than a verdict precisely
so that the signature stands where I placed it at WO-0020.

### Actions
- Read the charter, the protocol, WO-0022, the WO-0021 Return log in full, and
  my own WO-0020 §1/§4/§5.
- Verified the specs-unchanged claim myself: `git diff d8df28d..fa7eac5 --
  docs/specs/ docs/adr/` is empty; `git diff d8df28d^..d8df28d --stat` shows
  three spec files and no `requirements.md`, `traceability.md`, ADR, RTL or
  test; hunk offsets confirm no `§4.1` block lies inside any hunk.
- Re-derived, by hand from spec text: §6.1's separation formula and its three
  regimes; the 182 worst case; the M = ⌈N′/8⌉ − 1 identity; the
  `Tail` ≡ D ≥ 1 equivalence (M + 1 < K ⟺ D ≥ 1); the over-declared case's
  Ci + K; both §8 datagrams' N, N′, D, word counts, `tkeep` and surplus; the
  D = 0 companion's non-entry into `Tail`; C-34's word-12 boundary under both
  numbering conventions; C-35's 1480/8 = 185.
- Cross-checked C-31 across four documents (SPEC-M04 §9 + §13, ADR-0011's
  Affects and Consequences, `requirements.md` REQ-709, SPEC-M18 §9 and §6.3
  item 5) and confirmed the §13 row is well formed against §13's own header.
- Grepped every `tuser` mention in SPEC-M17 to find residual unqualified relay
  statements; found four, plus §3's "on or after" boundary error.
- Falsified §11.4's generalisation: derived M14's separation
  ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4 from SPEC-M14 §6.1's own cycle rule, validated it
  against that section's worked example, and bounded the falsification by
  checking all three `Tail`-state specs.
- Ran `bash tools/dv_checks.sh`; read CI run 30744579228 via the GitHub API.
- Wrote the Return log into the WO-0022 packet with the countersignature
  sentence at `d8df28d` and C-37 … C-40.
- Wrote no code and touched no spec, ADR, gate or audit file.

### Evidence
- `git diff d8df28d..fa7eac5 -- docs/specs/ docs/adr/` → **no output** (specs
  and ADRs byte-identical between the repair commit and the working tree's HEAD
  `fa7eac5`).
- `git diff d8df28d^..d8df28d --stat` → `agents/handoffs/WO-0021_f1-repair.md`,
  `agents/journals/claude_architect_docs_lead_agent.md`,
  `docs/specs/modules/udp_ip_rx_64.md` (+88 −22 region),
  `docs/specs/modules/udp_ip_tx_64.md`, `docs/specs/modules/xgmii_tx_64.md`;
  **5 files changed**, no `requirements.md`, no `traceability.md`, no ADR, no
  `libs/`, no `test/`.
- `bash tools/dv_checks.sh` → `dv_checks: all checks passed`; within it
  `check_records_vs_appendix.sh` → **23 check(s) run, 0 failure(s)** (all twenty
  §4.1 lifts byte-identical, including all four batch-F lifts);
  `check_emitted_verilog.sh` → **4 checks, 0 failures, 4 pending**.
- CI `build` run **30744579228**:
  `head_sha` = `d8df28dfe3722cd8950fdf753a6019b65cbb6966`,
  `conclusion` = `success`, `status` = `completed`, `run_number` 56,
  `event` = `push`, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`.
  Head SHA **is** the repair commit, so WO-0020 §5 item 4 is discharged.
  (Run 30744608560 on `fa7eac5` also green, per the packet; I verified the
  d8df28d run directly, which is the one the §12 rows cite.)
- Arithmetic reproducible by hand from the cited sections, no tooling required:
  - SPEC-M17 §6.1 separation = ⌈N′/8⌉ − ⌈N/8⌉ + 1 = 1 − D; D = 183 and
    D − 1 = **182** at N = 1480, N′ = 9.
  - §8 D = 1 datagram: N = 26, N′ = 20, K = 4, M = 2, separation 0, 12 octets,
    `tkeep` = 0x0F, 6 surplus.
  - §8 D = 0 companion: N = 32, N′ = 25, K = 4, M = 3, separation 1, 17 octets,
    `tkeep` = 0x01, 7 surplus, `Tail` not entered (M + 1 = K).
  - SPEC-M18 C-34 boundary: application word 12 holds declared 97–100 and excess
    101–104 (1-indexed) = 96–99 and 100–103 (0-indexed); word 13 holds the
    remaining six; ten excess octets in two words.
  - SPEC-M18 C-35: 1472 + 8 = 1480, 1480/8 = **185**; §3 and §10 now agree.
  - **C-37**: SPEC-M14 separation = ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4. Padded 64-octet
    frame N = 46 → K = 6, input `tlast` at Ci + 5. Total length 28 → M = 1,
    payload `tlast` word at Ci + 4 — **one cycle early**. Threshold N′ ≥ 37, so
    total lengths 21 … 36 are all affected; UDP length 9 (total length 29) gives
    separation exactly 0. Worst case N = 1500, N′ = 21 → 184 cycles early. The
    section's own worked example (N′ = N = 46) gives separation 2, which is why
    it reproduces and why the defect hid.
- Verdict artifact: `agents/handoffs/WO-0022_batch-f-rereview.md`, Return log
  dated 2026-08-02T16:00Z, carrying the countersignature sentence at `d8df28d`
  and the C-37 … C-40 table.

### Outcome
**DoD met.** The bounded re-review is complete on every item WO-0022 names, the
two out-of-surface sites are judged under C-28 (one accepted, one found wrong at
the D = 1 boundary and carried, the wrong word being my own), and the
countersignature is given:

> "I countersign batch F (SPEC-M17, SPEC-M18, SPEC-M19, SPEC-M20) for
> P1-spec-freeze at `d8df28d`."

**I sign `P1-spec-freeze`'s testability item for batch F**, and with batches A
through F signed, **all twenty Phase-1 specifications are FROZEN**. Batch F's
four §12 evidence rows fill from CI run 30744579228. The gate's sign-off section
now reduces to the sponsor's signature (E1).

Handoff: `agents/handoffs/WO-0022_batch-f-rereview.md` Return log, to the
orchestrator for gate transcription and for relay of C-37 … C-40 to
architect_docs_lead.

### Open-questions
- **C-37 is the one item I want escalated in attention if not in class.** It is
  normal packet flow — a spec finding at a frozen module, not an E-class
  escalation — but it is the largest finding in the programme to date and it
  must not be lost in the gate's momentum. I recommend it as the **next
  architect activation after the gate, ahead of any receive-chain RTL**, with an
  ADR, because its repair is a design choice (hold M14's payload `tlast` at
  REQ-005's cost, or scope REQ-007 and derive 0) rather than a wording fix. If
  the orchestrator judges the choice itself needs the sponsor, that is E2 and
  its call, not mine.
- **C-37 is also a DV escape of mine** (charter §6 criterion 2). The auditor
  owns the ledger (PROTOCOL §10); the root cause is in Reasoning above and I
  will cooperate fully with its recording. I did not and will not write
  `docs/reports/audit/**`.
- **C-38 will be caught by a bench before it is caught by a reader**: the
  declare-96/supply-104 datagram is a mandatory row of the M18 attack plan, and
  `SO-udp_ip_tx_64.md` is where it closes. If the architect prefers to repair
  §6.2 before M18's RTL rather than after, that is cheaper and I would take it.
- **C-39 and C-40 need no decision from me** — one frozen editorial row and one
  five-site wording sweep, both gated at their modules' sign-off packets.
- C-2, C-3, C-5, C-7, C-9's REQ-903 half and C-32, C-33, C-36 remain open and
  unchanged by this review. C-31, C-34 and C-35 are **closed**.
- **Next for me**: attack plans. With twenty frozen specs there is no further
  spec-freeze work, and my next unit should be `test/attack_plans/` — starting
  with M03 and M14, the latter carrying C-37's abort-availability row as its
  first entry.

### Files-in-this-commit
- agents/handoffs/WO-0022_batch-f-rereview.md

## [J-dv_lead-0012] 2026-08-02T18:25:00Z | task:WO-0025 | SPEC-M14's ADR-0012 text RE-COUNTERSIGNED at 8641455 — C-37 repaired in full and verified exhaustively rather than by hand (8 720 452 checks, 0 failures); the residual disposition endorsed with the application-visible band quantified; C-39 closed, C-40 reaffirmed one site short, C-38's deferral endorsed; C-41 and C-42 raised, both mine to have missed

### Trigger
Orchestrator work order **WO-0025** (`agents/handoffs/WO-0025_m14-recountersign.md`,
State ISSUED), spawn short-id `WO-0025/2026-08-02T17:50Z`, twelfth activation.
The bounded re-countersignature of the text ADR-0012 moved at frozen SPEC-M14 —
my own ledger item **C-37**, raised at WO-0022 and repaired one activation later.
The WO asks for the re-derivation of the moved text only, a judgment on
ADR-0012's carried residual, and reaffirm-or-contest verdicts on C-39/C-40 plus
a judgment on C-38's declared deferral.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md`.
- `agents/handoffs/WO-0025_m14-recountersign.md` (the work order, in full).
- `agents/handoffs/WO-0023_c37-repair.md` — the architect's Return log in full
  and the orchestrator's ACCEPTED entry at `8641455`.
- `docs/adr/ADR-0012-the-abort-bit-m14-cannot-copy.md` — Context, Decision, all
  six Alternatives, Consequences.
- `docs/specs/modules/ip_eth_rx_64.md` (SPEC-M14, FROZEN) — §2, §3, §4.2, §6.1,
  §6.2, §7's handshake bullet, §8, §9, §10, §11.5, §12 and §13, and the full
  `git show 8641455 --` diff of the file.
- `docs/specs/modules/udp_ip_rx_64.md` (SPEC-M17, FROZEN) — §6.1's separation
  formula and regime table, §6.2's `Payload`/`Tail` rows, §10's REQ-007 hook,
  §11.4, §12, §13, and the same commit's diff of the file.
- `docs/specs/requirements.md` — REQ-007, REQ-008, REQ-013, REQ-104, REQ-408,
  REQ-503, REQ-605, REQ-707, REQ-708, REQ-710 and §13's change log; the C-39
  diff.
- `docs/specs/traceability.md` — the REQ-007, REQ-013 and REQ-707 rows and the
  REQ-707 ownership note.
- The batch-F status-flip diffs at `8641455` for `nic_top.md`,
  `udp_complete_64.md`, `udp_ip_tx_64.md`.
- My own `J-dv_lead-0009` (the WO-0018 countersignature and its Evidence item 7)
  and `J-dv_lead-0011` (the C-37 statement and its root-cause paragraph).
- CI `build` run **30746705765** via the GitHub API.
- **No RTL. `libs/**` was neither read nor opened** — rtl_lead is mid-flight
  there and PROTOCOL §10 forbids it to me pre-verdict in any case. Every formula
  below is transcribed from specification text.

### Reasoning

**The method changed, and that is the substantive decision of this activation.**
Twice now the same algebra has produced the same defect: F-1 at M17 (WO-0020)
and C-37 at M14 (WO-0022). Both times the specification's argument reproduced
*on its own worked example* and failed off it — at M17 because the example was
fully delivered, at M14 because the example carried no padding. The worked
example is precisely the point in the space where checking is worthless, and I
have now been fooled by that shape once (my own escape at WO-0018) and rescued
from it once only because the architect wrote §11.4 in falsifiable form. Hand
re-derivation at a handful of points is not a control against this class. So
rather than re-derive the moved text at the four or five points the WO
enumerates, I **quantified over the whole admissible space** and committed the
oracle that does it: `tools/check_abort_availability.sh`, pure bash + awk, every
(N, N′) pair both modules accept, **8 720 452 checks, 0 failures**.

This is the compensating control I promised in `J-dv_lead-0011` ("every module
with a `Tail`-like state gets an abort-availability row computed over the full
range of the deficit, not checked against the worked example"), made mechanical
and re-executable by the auditor at this SHA instead of living as a promise in
an attack plan. I deliberately did **not** wire it into `tools/dv_checks.sh`:
that script's CI step is the orchestrator's to make (`.github/**` is outside my
scope) and changing the shared currency suite mid-flight buys nothing here. It
is an on-demand oracle cited by SHA, exactly as `dv_checks.sh`'s own header
describes for checks that have not been wired.

**The verdict: the moved text holds, at every point, not merely at the ones I
was asked about.** The separation is 1 − D identically; D ranges −1 … 184 so the
negative branch really is live at M14 where it is dead at M17, which is what
makes "copy iff D ≤ 0" one rule rather than two analogous ones; the threshold
N′ ≥ 8⌈N/8⌉ − 11 is an iff, not a sufficient condition; the surviving under-fill
is 4 … 11 octets by residue; the band at the minimum frame is exactly 21 … 36;
D differs from M17's word deficit by exactly one at N′ mod 8 ∈ {0, 5, 6, 7} and
nowhere else, always in the direction that predicts a derived 0 where a
conformant design must copy. The `Tail` superset is **proper** with 5 820
witnesses, and the *first* of them is (N = 46, total length 37) — §8's own case,
which means the specification drives the smallest witness of its own strictness
claim. At M17 the same predicate is an equality at all 1.1 M of its pairs. The
contrast the ADR insists on is real and it is the one a bench writer gets wrong.

**The 183/184 reconciliation is right and is the right *kind* of resolution.**
They are different events, not a disagreement: at N = 1500, N′ = 21 the payload
`tlast` leaves Ci + 4, the input `tlast` is presented Ci + 187 and the bit is
readable by a registered output Ci + 188. 183 is the distance to presentation
(M17's regime-table convention, the spec's figure); 184 is the distance to
readability (my WO-0022 figure). Naming both in one cell is better than picking
one, because a bench measures one of them and a designer reasons about the other.

**Why I judged §8's pair better than I commissioned.** I raised C-37 as a formula
error with a system consequence and named no discriminating stimulus. The pair
36/37 agrees on padding, on `Tail` and on the word deficit and disagrees only on
D, so it kills the three substitutions a reader actually makes; I additionally
checked the two off-by-one D-keyed designs and both fail one member, so the pair
pins the threshold rather than merely separating the classes. Then, computing the
composite, I found something neither document claims: at the 64-octet frame with
a conformant fully packed datagram, the **application-visible** loss band is
IPv4 total lengths **29 … 36** — eight values, all D = 1 — because below 29 the
IPv4 payload is at most a bare UDP header and M17 emits no application payload
frame at all. So §8's total length 36 is the **largest application-visible member
of the residual class**, not an arbitrary probe. That sharpens the residual in
both directions and it is why I endorsed the disposition rather than merely
accepting it.

**The residual, and one correction to the WO's framing.** The WO asked me to
judge the residual "as the owner of the DV-escape ledger". I am not its owner and
said so in the packet: PROTOCOL §10 and charter §3 give that ledger to the
auditor, in `docs/reports/audit/`, and I have written nothing there and will not.
I judged it as the lead whose gate closes it (`SO-ip_eth_rx_64.md`), whose escape
produced it, and who has to write the benches that live with it. On the merits
all four grounds hold: REQ-008/§0.6 prohibit *silent discard* and M14 discards
nothing on this class, so the prohibition has no instance and what is lost is
per-frame attribution — correctly named as the smaller thing; the class is
entered only by an already-invalid frame, so the derived 0 is *right* whenever no
abort occurred; the loss cannot compound because M17's only source for the bit is
M14's output; and the price is flip-invariant, which is the same test I applied
to C-37 itself and the architect applied to C-38. The two E2 reversal conditions
are exactly the conditions under which "eight declared lengths at one frame size"
stops being small, and alternative (e)'s price is honestly stated and genuinely
not the architect's to take in-role.

**Why I raised C-41 rather than letting the re-countersignature close the item.**
ADR-0012 fixed the unpassable-hook defect at SPEC-M14 §10 and did not look one
level up. Three verification columns in FROZEN requirements.md still commission
the REQ-007 universal unscoped — REQ-007's own ("every downstream stream that
emits a frame"), REQ-013's ("every downstream stage still forwards the frame with
the bit set") and REQ-707's ("`tuser`[0] propagation checked against an injected
bad-FCS frame"). §11.4 explicitly reasons that REQ-707 needs no diff because its
normative sentence says "propagated **per REQ-007**" and inherits whatever scope
REQ-007 gains — which is right about the normative sentence and silent about the
verification column, because a test commission inherits no scope from anything.
I graded the severity **below** C-37 and said so: these three are *satisfiable*
(REQ-708's own stimulus passes all of them), where §10's old hook named §8's
frames and was unsatisfiable. But the natural bench choice is the minimum frame
and the smallest datagram, REQ-707's is the *system* bench gated at neither
§11.4's nor §11.5's SO- packet, and a tb_writer working from requirements.md is
the person it hurts.

What decided me to raise it as a row rather than a note is the **price
asymmetry**, which nobody has separated: requirements.md §13's own class column
treats verification-column changes as **editorial**, and this very commit
contains one (C-39's REQ-710) with no ADR and no normative movement. So the
unpassable-hook half of the REQ-007 problem costs three editorial diffs today,
while the normative scoping clause stays carried and flip-invariant exactly as
§11.4 and §11.5 price it. The two halves have been treated as one deferred item
and they have different prices. **This is also mine to have missed** — it has
been true since the F-1 repair landed at `d8df28d` and I countersigned batch F
without raising it. Root cause: at WO-0022 I checked §11.4's *generalisation*
across modules, which is where I expected the error to be and where it was, and
did not then walk *up* to requirements.md's own verification columns to ask
whether the newly created exception had falsified any of them. The lesson
generalises and goes into my attack-plan discipline: **when a module gains a
behavioural exception to a programme invariant, re-read every verification column
of that invariant and of the requirements that cite it, not only the module hooks
the §11 row prices.**

**C-42 is smaller and is entirely mine.** SPEC-M14 §12's countersignature row
records that I proved "the abort-bit inequality M + 3 ≥ K … for every residue".
What I proved at WO-0018 (`J-dv_lead-0009`, Evidence item 7) is
⌈(N − 20)/8⌉ + 3 ≥ ⌈N/8⌉, which is true in every residue and is §6.1's *second*
inequality. `M + 3 ≥ K` is the composite §13 now names as the error, reached from
the true statement by the substitution M ← ⌈(N − 20)/8⌉ that holds only at
N′ = N — the exact substitution that hid C-37. My own journal's Actions line at
`J-dv_lead-0009` made the same slip while its Evidence stated the true
proposition; the architect transcribed my label faithfully. The freeze record
therefore claims a proof of a proposition the same document's §13 calls false.
Journals are append-only (PROTOCOL §4), so my half of the correction is here
rather than edited into `J-dv_lead-0009`, and the specification's half is a §13
row whenever SPEC-M14 next moves. It blocks nothing.

**C-40 reaffirmed one site short, and why I raised a single word.** SPEC-M17 §10's
REQ-007/REQ-013 hook still reads "copied where that word is emitted *on or after*
the input `tlast` (§6.1's D = 0)" — the same wrong phrase C-40 corrected at §3,
in the **hook that commissions the bench**, saved only by its parenthetical.
SPEC-M14 §10, written fresh in the same commit, reads "after … (§6.1's D ≤ 0)"
and is right in both halves. I would not have raised one word alone; I raise it
because SPEC-M17 §13 asserts the sweep is complete and it is complete but for
this, and because the hook is the artefact a bench is written from. C-40 stays
open with one named residual site rather than closing.

**C-38's decline I endorse, and endorsing it is the consistency test.** The
architect declined on my own rule — the price is flip-invariant, SPEC-M18 is
already FROZEN, the gate is a different gate (`SO-udp_ip_tx_64.md`), and the
repair is a second post-freeze *behavioural* change at a different module inside
the commit carrying the programme's first. That is exactly the test §11.4 uses,
that I applied to C-37 itself, and applying it inconsistently when the item is
mine would be worse than the delay. My mandatory-row status on the M18 attack
plan is intact and the declare-96/supply-104 datagram will be a bench before it
is a reader.

**What I did not reopen.** Everything outside the moved text: M14's L = 12,
h = 20, ΔC = 4, the 3-cycle parse latency, all seven strobe cycles, §9's
extensional truncation branch, and every batch-A…F item signed at WO-0018,
WO-0020 and WO-0022. The batch-F status flip I checked only for consistency with
what I signed — all four §12 rows cite run 30744579228 at d8df28d with
`J-dv_lead-0011`, and the per-spec bases are the right ones — and it needs no
further signature from me.

### Actions
- Read the charter, PROTOCOL, WO-0025, the WO-0023 Return log and ADR-0012 in
  full, then SPEC-M14's and SPEC-M17's moved text and the whole `8641455` diff.
- Wrote `tools/check_abort_availability.sh` — an exhaustive re-derivation of both
  modules' abort-availability algebra from spec text, pure bash + awk, with every
  formula cited inline to its section; ran it (exit 0, 8 720 452 checks).
- Re-derived by hand, independently of the tool, before running it: the
  separation identity, D ≥ −1 from 20 ≥ 16, the threshold equivalence, the
  D-versus-word-deficit residue split, and the `Tail` superset properness.
- Checked the §8 pair against four wrong keys (unconditional, padding, `Tail`,
  M17's word deficit) and two off-by-one D-keyed designs.
- Computed the composite over the 64-octet frame and isolated the
  application-visible band, total lengths 29 … 36.
- Grepped every `tuser`, `abort` and `inherit` site in SPEC-M14 to verify the
  relay sweep is complete (six sites, none unqualified) and found the count
  "five" is a Return-log prose slip and not in any specification.
- Checked requirements.md REQ-007/REQ-013/REQ-707/REQ-605 verification columns
  and traceability.md's REQ-007/REQ-013/REQ-707 rows against the new exception;
  raised C-41 from the first three and confirmed the architect's REQ-605 and
  traceability findings.
- Compared SPEC-M14 §12's countersignature row against `J-dv_lead-0009`'s
  Evidence item 7; raised C-42.
- Ran `tools/dv_checks.sh`; verified CI run 30746705765 via the GitHub API.
- Wrote the Return log into the WO-0025 packet with the re-countersignature
  sentence at `8641455`, the per-item verdicts, the residual judgment and
  C-41/C-42.
- Touched no spec, ADR, gate or audit file; read no RTL and did not enter
  `libs/`; ran no git command beyond `status`, `log`, `show` and `diff`.

### Evidence
- `bash tools/check_abort_availability.sh` → **exit 0**,
  `8720452 check(s) run, 0 failure(s)`, 2.5 s wall. Committed in this commit and
  re-executable by the auditor at this SHA. Selected output lines:
  - `M14  D over the whole admissible space: -1 .. 184   (§6.1: never below -1; worst 184)`
  - `M14  in-Tail-but-still-copies witnesses: 5820, first (N=46, total length 37)`
  - `M14  N=46 (64-octet frame): threshold total length >= 37, unavailable band 21 .. 36`
  - `M14  surviving under-fill by residue: 4 .. 11 octets`
  - `M14  worst case N=1500, total length 21: payload tlast Ci+4, input tlast Ci+187, readable Ci+188`
  - `       -> 183 cycles before the input tlast is PRESENTED   (§6.1, the M17 convention)`
  - `       -> 184 cycles before the bit is READABLE by a registered output (dv_lead, WO-0022)`
  - `M14  §8 pair, total length 36: D=1  W=1  Tail=yes  payload=16 octets in 2 words, tlast Ci+5, padding=10`
  - `M14  §8 pair, total length 37: D=0  W=1  Tail=yes  payload=17 octets in 3 words, tlast Ci+6, padding=9`
  - `M17  D over the whole admissible space: 0 .. 183   (§6.1: D >= 0)`
  - `M17  worst case N=1480, UDP length 9: D=183, 182 cycles before the input tlast`
  - `Composite over the 64-octet minimum frame, inherited bit = 1: 39 marked, 36 lost at M14, 96 lost at M17`
- `bash tools/dv_checks.sh` → **exit 0**, `dv_checks: all checks passed`; within
  it `check_records_vs_appendix.sh` **23 check(s) run, 0 failure(s)** (all twenty
  §4.1 lifts byte-identical to their records) and `check_emitted_verilog.sh`
  **4 checks, 0 failures, 4 pending**.
- CI `build` run **30746705765**:
  `head_sha` = `8641455ffdfa00697c590c23568c7712cb197beb`,
  `status` = `completed`, `conclusion` = **`success`**, `run_number` 60,
  `event` = `push`, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`.
  The head SHA **is** the commit carrying the moved text, so no witnessing
  argument is owed for this re-countersignature.
- Hand arithmetic, reproducible from the cited sections with no tooling:
  payload word j leaves Ci + 4 + j (SPEC-M14 §6.1 cycle table) so the `tlast`
  word leaves Ci + M + 3; separation = M − K + 4 = 1 − D; ⌈(N−20)/8⌉ ≤ ⌈N/8⌉ − 2
  because 20 ≥ 16, hence D ≥ −1; ⌈(N′−20)/8⌉ ≥ ⌈N/8⌉ − 3 ⟺ N′ ≥ 8⌈N/8⌉ − 11;
  D − W = −1 at N′ mod 8 ∈ {0,5,6,7} and 0 at {1,2,3,4}; 8·6 − 11 = 37;
  1500 mod 8 = 4 so total length 1500 is D = 0.
- Verdict artifact: `agents/handoffs/WO-0025_m14-recountersign.md`, Return log
  dated 2026-08-02T18:25Z, carrying the re-countersignature sentence at
  `8641455`, the ten-row per-item verdict table, the residual judgment and
  C-41/C-42.
- `git status --porcelain` before this entry: only
  `tools/check_abort_availability.sh` untracked; no spec, ADR, gate, audit,
  `libs/` or `test/` path modified.

### Outcome
**DoD met.** Every item on WO-0025's list is re-derived and confirmed, the
residual disposition is judged and endorsed with the application-visible band
quantified, C-39 is closed, C-40 is reaffirmed with one named residual site,
C-38's deferral is endorsed, and two new ledger items are raised. The
re-countersignature is given:

> "I re-countersign the SPEC-M14 text moved by ADR-0012 — §2, §3, §4.2, §6.1,
> §6.2, §8, §10, the new §11.5 and the §13 row — for `P1-spec-freeze`
> testability at `8641455`. SPEC-M14 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0009` for the specification as frozen
> at `3f6accc`, and on `J-dv_lead-0012` for this revision."

SPEC-M17's §11.4/§13 corrections landed in the same commit are accepted and
`J-dv_lead-0011` stands over them. The ratified batch-F status flip is
consistent with what I signed at WO-0022 and needs no further signature.

Handoff: `agents/handoffs/WO-0025_m14-recountersign.md` Return log, to the
orchestrator — for transcription of the re-countersignature and for relay of
C-41 and C-42 (and C-40's residual site) to architect_docs_lead.

### Open-questions
- **C-41 is the one I want acted on before the first receive-chain bench**, not
  because it is large but because it is cheap and it is aimed at a worker. A
  tb_writer working from requirements.md REQ-007, REQ-013 or REQ-707 today can
  be commissioned to an assertion a conformant design fails, and the fix is three
  editorial verification-column diffs on the C-39 precedent — no ADR, no
  normative movement, no interaction with the carried scoping clause. It is not
  an escalation class; it is normal packet flow to architect_docs_lead.
- **C-42** is one cell in SPEC-M14 §12 and rides along with whatever moves that
  document next.
- **C-40 stays open** on SPEC-M17 §10's "on or after", gated at
  `SO-udp_ip_rx_64.md` with the rest of it.
- **C-41 is a second escape of mine** (charter §6 criterion 2), smaller than
  C-37 and of the same family: I checked the exception where I expected it and
  not one document up. The auditor owns the DV-escape ledger (PROTOCOL §10); the
  root cause is in Reasoning above and I will cooperate with its recording. I did
  not and will not write `docs/reports/audit/**`.
- **`tools/check_abort_availability.sh` is not wired into `tools/dv_checks.sh`**
  and its CI step, like `dv_checks.sh`'s own, is the orchestrator's to make
  (`.github/**` is outside my scope). My recommendation is to leave it on demand
  until `dv_checks.sh` itself is wired, then add it in the same step — it is
  2.5 s and dependency-free.
- C-2, C-3, C-5, C-7, C-9's REQ-903 half, C-32, C-33, C-36, C-38, C-40, C-41 and
  C-42 remain open. C-31, C-34, C-35, C-37 and C-39 are **closed**.
- **Next for me is unchanged and now overdue**: `test/attack_plans/`, starting
  with `AP-ip_eth_rx_64.md` and `AP-udp_ip_rx_64.md`. Their first rows are
  written for me — the abort-availability row computed over the full deficit
  range (now mechanised), §8's 36/37 pair with both input bits, and the
  D ≥ 1 exclusion named so no SO- claims REQ-007 whole at M14 by silence.

### Files-in-this-commit
- agents/handoffs/WO-0025_m14-recountersign.md
- tools/check_abort_availability.sh

## [J-dv_lead-0013] 2026-08-02T21:40:00Z | task:WO-0027 | The programme's first two attack plans — AP-M03 (73 rows) and AP-M14 (63 rows, C-37's availability pair first); the row format defined as the template; rtl_lead's three M03 questions become two RULING rows and one NO-STIMULUS; a new undecided class found at M14 by writing the plan (declared total length below 20)

### Trigger
Orchestrator work order `agents/handoffs/WO-0027_attack-plans.md`, spawn
short-id `WO-0027/2026-08-02T20:50Z`. This is the unit I named as my own next at
`J-dv_lead-0012`'s Open-questions ("Next for me is unchanged and now overdue:
`test/attack_plans/`"), re-ordered by the work order to M03 first and M14
second, which is the right order: M03's RTL now exists at `f840475` and M14's
does not, so the plan that will be executed soonest is the one whose format is
reviewed first.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md`; `agents/handoffs/README.md`
  (packet forms — there is no `AP-` form, which is why §"Reasoning" below spends
  its first paragraphs on inventing one).
- `agents/handoffs/WO-0027_attack-plans.md`; `agents/handoffs/WO-0024_batch-b-rtl.md`
  (Return log §6, rtl_lead's four returned questions; §2's microarchitecture
  narrative was read as part of the packet and is treated below as a **declared
  reading**, never as a source of expected behaviour); `agents/handoffs/WO-0012_dv-wave2.md`.
- **SPEC-M03** `docs/specs/modules/xgmii_rx_64.md` in full — FROZEN `f78766e`
  plus all six §13 rows through C-18.
- **SPEC-M14** `docs/specs/modules/ip_eth_rx_64.md` in full — FROZEN `3f6accc`
  plus all four §13 rows including the ADR-0012 behavioural row at `8641455`.
- `docs/specs/requirements.md` §0.3, §0.4, §0.5, §0.6 (including C-23's counting
  convention), §0.7, §1 (REQ-001 … REQ-021), §1.1, §2 (REQ-101 … REQ-113),
  §5 (REQ-401 … REQ-410), §7 (REQ-601 … REQ-612), §8 (REQ-703, REQ-707, REQ-708),
  §9 (REQ-802, REQ-803, REQ-810), §12.
- `docs/adr/ADR-0012-the-abort-bit-m14-cannot-copy.md` (context, decisions 1–6,
  alternatives (a) … (f)); ADR-0006/0007 (the CRC finished-value convention and
  the 1-to-8 `octet_count` domain); ADR-0008 (the two `valid` disciplines);
  ADR-0009 (ultimate consumers).
- `docs/gates/P1-spec-freeze-checklist.md` — the carry-forward ledger and its
  status marks.
- My own machinery, read to size the gaps: `test/monitors/*.mli`,
  `test/xgmii/*.mli`, `test/golden/*.mli`, `test/axi64_probe/axi64_probe.ml`,
  every `test/*/dune`, `test/hardcaml_ethernet/test_word_counter.ml`.
- `tools/check_abort_availability.sh`, executed.
- **Not read: `libs/**`.** No file under it was opened by me at this commit or
  at any earlier one. M03's RTL exists at `f840475` and was deliberately left
  unopened; the WO-0024 Return log's prose was in my inputs and is the one place
  a design's shape reached me, which is why every family-N row derives its
  expected observable from SPEC-M03's text and says so in the plan.

### Reasoning

**What an attack plan is for, and therefore what shape it takes.** The programme
has no `AP-` form — the handoffs README defines WO/SO/BUG/RV and stops — so the
first decision was what a row *is*. Charter §3 asks for "an enumerated
adversarial table" and §"Sign-offs" asks the `SO-` to map tests back to rows;
those two sentences fix the id and the enumeration but not the columns. I chose
six cells, and the one that decided the design is **Kills**: the wrong design
each row detects, stated concretely enough that a reader can see the row fail
against it. A plan without that column is a test list with adjectives, and the
failure mode it invites is exactly the one this programme has already paid for
twice — a hook that commissions an assertion nobody has checked is passable
(C-41, and SPEC-M14 §10's pre-ADR-0012 REQ-007 row, which commissioned an
assertion **no conformant design passes** over a directed set every member of
which was inside the defective band).

Rejected column sets: (i) *REQ · test name · expected result*, which is a
traceability matrix and the architect already owns one; (ii) adding a
*severity*, which prices a defect before it exists and would let a plan
soft-pedal a row; (iii) adding an *owner*, since every row is tb_writer's or
mine and the WO decides that later; (iv) splitting stimulus and expected into
separate documents, which is how a stimulus catalogue drifts from the assertions
it was built for — the `arrival.mli` deferral of the injection catalogue "until
the attack plan exists" was the right instinct and this format keeps them in one
row.

**The status vocabulary is six values, and four of them exist because of things
this programme has already got wrong.** ASSERT is the default. **NO-ASSERT**
exists because C-14.3, C-14.4, C-14.5 and C-27 are all cases where a bench built
from a true-looking sentence fails a *conformant* design; a plan that only lists
what to assert cannot record that, and the assertion re-appears in the next
bench. **NO-STIMULUS** exists because §6.3 item 3 and REQ-018's contract make
some inputs meaningless to drive, and a row that says so is cheaper than the
argument being had again. **RULING** exists because C-12 was held as NO-ASSERT
in `arrival.mli` until requirements.md settled it, and that worked: the case was
visible, blocked nothing, and closed with a one-line ruling. **GAP** exists so a
sign-off cannot claim coverage by silence. STRUCTURAL keeps compile-checked
facts out of the behavioural count.

**Why C-37's row is the first row of the first family at M14, and how it is
constructed.** ADR-0012's class is entered by *ordinary Ethernet padding*, so it
is the commonest small frame on the wire rather than a corner, and three
plausible keys — "carries padding", "is in `Tail`", and SPEC-M17's **word**
deficit — agree with the correct rule on almost every datagram. The pair that
separates them is two datagrams differing by **one declared octet**: IPv4 total
lengths 36 and 37 in a 64-octet frame, where padding, `Tail` and the word
deficit are identical and only the cycle deficit D differs. Driving each twice
with opposite input bits makes the row kill six designs on four runs:
unconditional copy, padding-keyed, `Tail`-keyed, word-deficit-keyed, and **both
off-by-one D-keyed designs** (copy iff D ≤ 1 fails 36; copy iff D ≤ −1 fails 37).
I added **M14-A2** — total length 40, residue 0, D = 0 with a word deficit of 1 —
because one witness proves an instance while the specification's claim is about
*four residues in eight*; two witnesses at residues 5 and 0 test the claim. And
I added **M14-A3/A4/A5** as the anti-vacuity spine: without a row asserting the
bit is **copied** somewhere (D = −1 at total length 46, D = 0 at 1500), the
"0 on both runs" assertions pass against a design that never copies anything.
**M14-A6** is the row that keeps the previous hook from coming back: the whole
directed 21 … 28 set asserts *nothing* about the bit, and saying so is the only
way a later reader does not re-derive the unpassable assertion from §8's list.

**The arithmetic was verified before it was written down, twice.** Every D,
word deficit, `tlast` cycle, `tkeep` and padding figure in family A was
recomputed independently of the plan text and cross-checked against
`tools/check_abort_availability.sh`, which reproduces the §8 pair exactly
(`total length 36: D=1 W=1 Tail=yes … tlast Ci+5, padding=10`;
`37: D=0 W=1 Tail=yes … tlast Ci+6, padding=9`). This is deliberate discipline
rather than caution: C-37 exists because an inequality ran backwards in a frozen
document, and a plan that repeats the error would commission benches that
enforce it.

**What writing AP-M14 found that no bench would have found for months.**
SPEC-M14 §6.1's field table justifies "total length ≥ 20" as holding "by
construction of REQ-601's IHL check". It does not: IHL fixes the *header*
length; the total-length field is sixteen independent bits an adversary
controls. A datagram with version 4, IHL 5, a correct checksum, protocol 17, an
accepted destination, MF = 0 and offset 0, declaring total length 0, passes all
six header conditions and arrives at §6.2's `Header` branch, which selects on
*declared payload empty (total length 20)* versus *non-empty* — and this
datagram is neither. §6.1's own M = ⌈(N′ − 20)/8⌉ is negative for it, so the D
arithmetic is undefined on the class too. That is C-26's family exactly: a
reachable band the branch conditions do not cover. It is row **M14-K7**, status
RULING, with three readings enumerated and a recommendation (fold it into
REQ-601's class — same detection cycle, no new strobe, no new REQ, no port). I
note without pleading that this is the first defect the *attack-plan step
itself* has caught, which is the argument for the step.

**The second M14 finding is a coverage hole I cannot close from inside DV.**
REQ-603 constrains more-fragments (octet 6 bit 5) and the fragment offset, and
§6.3 item 4 forbids DV from asserting anything about a datagram that sets DF
(bit 6) or the reserved bit (bit 7). The consequence is that a design reading
the **wrong bit** of octet 6 for more-fragments is **unkillable at M14**: the
only stimulus that distinguishes it is one on which no assertion may be made.
I could have written the row anyway and been quietly out of conformance with
§6.3; instead it is M14-B5 (NO-ASSERT) plus an open question naming the
one-sentence repair. The fragment-offset half *is* killable and is attacked
properly — M14-B4 drives offset 0x0100, whose low octet is zero, which kills a
design reading octet 7 alone and accepting every offset that is a multiple of
256.

**rtl_lead's three returned questions, answered from the specification and not
from the answer it gave.** This mattered enough to shape the family: rtl_lead
declared readings in its Return log, and the temptation is to write rows that
confirm them, which would make my benches a transcription of a design I am not
allowed to read.
- *Two closure characters in one word* splits into two cases. Where the second
  arrives after the frame is closed and no frame is open, §9's third row and
  C-12 decide it outright — that is **M03-N1**, ASSERT. Where the second falls
  inside the **new** frame's preamble (`/S/` lane 0, `/T/` lane 3), §6.1 says in
  terms that a control character in a preamble position "is routed by §9: `/T/`
  to REQ-107", which gives a second zero-delivered frame and one `error_runt`;
  rtl_lead's declared one-closure-per-word reading pulses only the abort. The
  readings differ in exactly one observable, and under the declared one **a
  frame is opened and never reported**, which is a hole in §0.6's conservation
  equation. That is **M03-N2**, RULING — because asserting my reading before the
  architect rules would be DV writing specification, and asserting the other
  would enshrine RTL.
- *An idle word inside a frame's own preamble* is decided by §6.1's "exactly 8
  octet times", so it is **M03-N3**, NO-STIMULUS — and the row is more than an
  answer: it is the **contract for the idle-injection wrapper** (X-4), which
  must not inject between the start word and the first frame octet. A wrapper
  that injects uniformly would produce red benches that are the bench's fault.
- *`cfg_rx_enable` going 0 mid-frame with a REQ-110 start character arriving*
  is **M03-N4**, RULING, because §4.3's own two sentences point opposite ways
  ("treats every start character as absent … pulses no strobe" against "a frame
  already in flight completes under the old one") and the two readings differ in
  a delivered octet count, a strobe and an abort bit.

**Rows I am most confident are worth their cost.** M03-H2 (a `/S/` in lane 4
leaves four octets of the aborted frame behind, and a design that switches its
alignment offset on the acceptance cycle loses them **silently** — a REQ-008
hole with no strobe that every row not counting the aborted frame's octets
misses); M03-G2 (1518 against 1519, which deliver an **identical** 1514 octets
and differ only in the strobe, the abort bit and whether an FCS check happened);
M03-I6 (7-cycle idle injection into a 1518-octet frame, which trips any oversize
detector counting cycles instead of octets); M03-D3 (a bad-FCS frame followed at
the *minimum* gap by a good one, which catches a design reading the CRC register
at the `tlast` cycle after the next frame has re-seeded it — derivable from
§6.1's seeding rule and §6.1's own two-cycle drain bound, with no RTL);
M03-H4 (two zero-delivered aborts whose pinned strobe cycles are **consecutive**,
making C-23's high-cycle counting convention load-bearing on the receive chain
for the first time — the convention was homed in §0.6 on M13's evidence and
stated there as generalising, and this is the proof); M14-E4 (a frame truncated
inside the header **whose version nibble is 6**, turning §9's only precedence
rule from a silence into a positive assertion); M14-B3 (a header whose
one's-complement sum needs **two** folds, which kills the once-folded 32-bit
accumulator — a defect that agrees with the correct arithmetic on nearly every
header and rejects a valid datagram).

**Attacks considered and rejected** — the list the auditor mines, recorded in
both plans' §5 and summarised here with the ones whose rejection I most want
challenged. Random fuzz at both modules (rejected as a *substitute*: the oracle
it needs is the same one the directed rows need, so it becomes cheap only after
X-1/X-8 exist, and then it is worth a row of its own). Asserting the lane-0 /
lane-4 absolute-cycle equality at M03 (§6.1 and §10 forbid it — it is a property
of pinned constants, not an obligation). Asserting which FCS realisation is used
(§6.3 item 1). A start character in lanes 1, 2, 3, 5, 6 or 7 (§6.3 item 3 plus
REQ-018 — and note this is why rtl_lead's own example of `/S/` in lane 2 could
not become a row as posed and had to be re-expressed at a legal lane). A gap
below §0.3's DIC floor (SPEC-M03 §2: reacting to a short gap is *nobody's* job).
Asserting `tuser`[0] on M03's input (it has none — M03 originates the bit).
Reaching into the CRC register or the `octet_count` M02 sees — instead
ADR-0007's 1-to-8 domain is attacked **through** its observable consequence, by
M03-C2 (a held CRC fails seven of eight terminate lanes) and M03-A2 (a held CRC
fails every lane-4 frame); that substitution is the single most important
methodological choice in AP-M03. At M14: a datagram with N′ > N *and* D ≥ 1
(unconstructible — N′ > N is REQ-605's truncation, which never reaches the
availability question); a `hdr_valid` lead other than one cycle (outside the
producer's contract — it would test M08); datagram adjacency closer than the
XGMII layer can deliver, which is the only way to attack §9's
consecutive-cycle claim and would be attacking a producer the programme does not
have; and a loopback of M15's transmit checksum as an oracle for M14's check,
rejected on REQ-202's own principle — a systematically wrong but self-consistent
checksum passes a loopback.

**Machinery: eleven gaps, named and not built.** The work order said note, do
not build, and the discipline is right — a plan whose author is also building
its machinery writes rows the machinery can already do. The two that will hurt
first are **X-1** (the link partner's error-injection catalogue: without it,
families B, D, E, F, G and H of AP-M03 have no stimulus, and it needs a
per-frame **expected §9 outcome** so benches compare against the model rather
than hand-copied constants) and **X-5/X-9**, which are the same repair with two
customers: `Latency.create` takes `~tail_octets` as a **run** constant and
`frame_out` requires the output length to be exactly (input − strip − tail).
Every aborted or truncated M03 frame breaks that, and at M14 the removed tail is
the Ethernet padding N − N′, which varies **per datagram**. That is a second
defect in the same tagger WO-0012 already repaired once, found the same way
(by asking what the module's own frames look like rather than what the parameter
is called), and I would rather it be a named row here than a wrong number in a
sign-off packet. **X-3** (the strobe monitor) is the third: nothing today counts
strobes — `Conservation_monitor.strobe_pulse` is a call a bench makes by hand —
and both plans pin exact strobe cycles that no monitor can check.

**What I deliberately did not do.** No bench, no `test/**` code, no
`docs/gates/**`, no spec edit; the three architect items and the clerical ledger
note leave this packet as questions, which is the only route my scope allows.
I did not fold `tools/check_abort_availability.sh` into the M14 plan as the
bench's oracle: it stays the **independent cross-check**, and X-10 asks for a
separate OCaml D oracle, because two implementations of one formula in two
languages is the cheapest protection this programme has against the arithmetic
error that created C-37.

### Actions
- Read the charter, PROTOCOL, WO-0027, WO-0024's Return log, WO-0012, both
  specifications in full with every §13 row, the requirements sections listed in
  Inputs, ADR-0012 and the gate ledger.
- Read my own machinery's interfaces (`test/monitors`, `test/xgmii`,
  `test/golden`, `test/axi64_probe`, every `test/*/dune`) to size the gaps in §7
  of each plan against what exists rather than against what I remember building.
- Created `test/attack_plans/` and wrote **`AP-xgmii_rx_64.md`** — 73 rows in 15
  families — and **`AP-ip_eth_rx_64.md`** — 63 rows in 11 families, C-37's pair
  first.
- Recomputed every D, word deficit, payload-word count, `tlast` cycle, `tkeep`
  and padding figure in AP-M14 family A independently, then cross-checked
  against `tools/check_abort_availability.sh`.
- Recomputed AP-M03's directed-length arithmetic by hand: delivered = length − 4
  for 64 … 71 giving all eight `tkeep` patterns and all eight terminate lanes
  (lane = length mod 8); 1518 → 1514 in 190 words with a final `tkeep` = 0x03;
  the drain bound of two cycles; the consecutive strobe cycles of M03-H4.
- Tightened M03-H4's stimulus after checking it: the original three-consecutive-
  cycle `/S/` schedule put the second start character at the aborted frame's
  **first frame octet** rather than strictly inside its preamble, which is a
  different §9 row. Replaced with `/S/` in lanes 0 and 4 of one word then `/S/`
  in lane 0 of the next, where both aborts are strictly inside their own
  preambles and the pinned strobe cycles are still consecutive.
- Wrote the WO-0027 Return log with the row tables, the format summary, the
  machinery list, the ledger-row mapping and the four architect items.
- Ran no `git` command beyond `status`; opened no file under `libs/`.

### Evidence
- `test/attack_plans/AP-xgmii_rx_64.md` — **73 rows**, reproducible:
  `grep -c '^| \*\*M03-' test/attack_plans/AP-xgmii_rx_64.md` → `73`;
  `grep -o '^| \*\*M03-[A-O]' … | sort | uniq -c` → A 5, B 4, C 4, D 4, E 4,
  F 5, G 6, H 4, I 6, J 4, K 3, L 6, M 9, N 4, O 5;
  status histogram via
  `grep -o '| ASSERT |\|| NO-ASSERT |\|| NO-STIMULUS |\|| RULING |\|| GAP |\|| STRUCTURAL |' … | sort | uniq -c`
  → 55 / 7 / 4 / 2 / 1 / 4.
- `test/attack_plans/AP-ip_eth_rx_64.md` — **63 rows**: same commands with
  `M14` → A 8, B 10, C 4, D 5, E 7, F 4, G 4, H 3, I 5, J 6, K 7; status
  histogram 49 ASSERT / 5 NO-ASSERT / 2 NO-STIMULUS / 1 RULING / 0 GAP /
  6 STRUCTURAL.
- `bash tools/check_abort_availability.sh` → **exit 0**,
  `8720452 check(s) run, 0 failure(s)`. The two lines that witness AP-M14
  family A's boundary pair, quoted verbatim from its output:
  `M14  §8 pair, total length 36: D=1  W=1  Tail=yes  payload=16 octets in 2 words, tlast Ci+5, padding=10`
  and
  `M14  §8 pair, total length 37: D=0  W=1  Tail=yes  payload=17 octets in 3 words, tlast Ci+6, padding=9`,
  with `M14  §8 pair: padding, Tail and word deficit agree; only D differs` —
  which is the row's kill argument, mechanised.
- Independent recomputation of the six lengths AP-M14 family A asserts, by an
  awk script written for this entry in the session scratchpad (**ephemeral, not
  committed** — ADR-0003/F5): with K = ⌈N/8⌉, M = ⌈(N′−20)/8⌉, D = K − M − 3 and
  word deficit W = ⌈N/8⌉ − ⌈N′/8⌉ —
  (N=46, N′=28) → K 6, M 1, **D 2**, W 2, `tlast` Ci+4, `tkeep` 0xFF;
  (46, 36) → M 2, **D 1**, W 1, Ci+5, 0xFF;
  (46, 37) → M 3, **D 0**, W 1, Ci+6, 0x01;
  (46, 40) → M 3, **D 0**, W 1, Ci+6, 0x0F;
  (46, 46) → M 4, **D −1**, W 0, Ci+7, 0x03;
  (1500, 1500) → K 188, M 185, **D 0**, W 0, Ci+188, 0xFF; input `tlast` at
  Ci + K − 1 = Ci+5 for every 64-octet frame and Ci+187 at 1500. Every figure
  matches the plan's cells and the first two match the committed tool. The
  computation reproduces from the formulas in SPEC-M14 §6.1 with no tooling.
- AP-M03's directed arithmetic, reproducible from §0.3 and §6.1 by hand:
  lengths 64 … 71 deliver 60 … 67 octets, giving final `tkeep` patterns
  0x0F, 0x1F, 0x3F, 0x7F, **0xFF**, 0x01, 0x03, 0x07 in that order and terminate
  lanes 0 … 7 (lane = length mod 8); 1518 delivers 1514 = 189 × 8 + 2, i.e. 190
  words with a final `tkeep` = 0x03, which is REQ-015's pinned maximum;
  1519 delivers **the same 1514** and differs only in the strobe, the abort bit
  and the absence of an FCS check (M03-G2); a 5-octet frame delivers exactly one
  octet in one word (C-11's legal one-word frame).
- `git status --porcelain` before this entry: `?? test/attack_plans/` only —
  no `libs/`, `docs/`, `test/**` code or `tools/` path touched.
- Verdict artifact: `agents/handoffs/WO-0027_attack-plans.md` Return log, dated
  2026-08-02T21:40Z.

### Outcome
**DoD met.** All four deliverables: AP-M03 and AP-M14 committed before either
module's first bench (charter §3, ADR-0001); the row format defined in AP-M03
§0–§1 and reused unchanged in AP-M14, so it is a template rather than a
one-off; C-37's abort-availability pair is AP-M14's first row with the six wrong
designs it kills named individually; the five ledger rows the work order gated
on these plans have landed as rows (C-12 → M03-E4/G4/G5/M7, C-18 → M03-A2/C2,
C-26 → M14-E1/E2/E3, C-27 → M14-F2, C-30 → M14-H2), with C-2, C-11, C-14.3/4/5,
C-17(e) and C-23 landing alongside them; rtl_lead's three returned questions are
explicit rows (M03-N1/N2 for the closure-character question, M03-N3 for
idle-in-preamble, M03-N4 for `cfg_rx_enable` mid-frame); eleven machinery gaps
are named for later work orders and none is built here.

Handoff: `agents/handoffs/WO-0027_attack-plans.md` Return log, to the
orchestrator — for the tb_writer work orders these plans now make writable, and
for relay of the four architect items.

### Open-questions
- **M14-K7 is the one I want ruled before any M14 bench**, and it is new:
  SPEC-M14 §6.1's "total length ≥ 20 by construction of REQ-601's IHL check" is
  false, and a datagram declaring total length 0 … 19 passes all six header
  conditions and lands on a `Header` branch covering neither of its cases, with
  M = ⌈(N′ − 20)/8⌉ negative. Reachable and adversary-controlled. Recommended
  reading: fold into REQ-601's class. It blocks only its own row.
- **M03-N2 and M03-N4** are RULING rows carrying rtl_lead's declared readings
  against the text-strict ones; both are cheap to settle (one §6.3 row or one §9
  row each) and both are worth settling before a tb_writer packet quotes the
  sections. M03-N2 additionally leaves a frame opened-and-never-reported under
  the declared reading, which is a §0.6 hole.
- **M14-B5** — §6.3 item 4's silence makes the more-fragments bit-position
  defect unkillable at M14. One sentence converts it into a row; carried as a
  declared gap meanwhile.
- **M03-O2** — SPEC-M03 §10's REQ-014 hook commissions a differential run with
  no instance at this module (no input `tstrb`); C-41's family, one cell, the
  repair form already exists in SPEC-M14 §10.
- **Clerical**: the `P1-spec-freeze` ledger's unnumbered dv-machinery row
  (`Latency.create`'s conflated quantities) was discharged at WO-0012 and shows
  neither an id nor a closure mark. AP-M03's M03-L3 is the row that keeps that
  fix honest.
- **Machinery, in the order they block work**: X-1 (link-partner error
  injection with expected §9 outcomes) and X-5/X-9 (per-frame output extent on
  the latency tagger — one repair, two modules, and the tagger's **second**
  defect of this family) gate the first real benches; X-3 (strobe monitor with
  C-23 high-cycle counting and §9's pinned cycles) gates every strobe assertion
  in both plans; X-6/X-7/X-8 gate M14 entirely, and X-8's checksum oracle owes
  an external anchor (RFC 1071's worked example) **before** it judges anything,
  on the same rule `Crc32_ref` already follows.
- C-2, C-3, C-5, C-7, C-9's REQ-903 half, C-32, C-33, C-36, C-38, C-40, C-41 and
  C-42 remain open; C-31, C-34, C-35, C-37 and C-39 are closed.
- **Next for me**: the machinery work order these plans specify — X-1, X-3 and
  X-5/X-9 first, because AP-M03's families B through H cannot be driven without
  X-1 and cannot be measured without X-5. The M03 tb_writer packet should not be
  drafted before X-1 exists, since its `Context provided` section would
  otherwise have to restate the injection catalogue in prose, which is the
  failure mode rtl_lead correctly refused at WO-0024.

### Files-in-this-commit
- agents/handoffs/WO-0027_attack-plans.md
- test/attack_plans/AP-ip_eth_rx_64.md
- test/attack_plans/AP-xgmii_rx_64.md
