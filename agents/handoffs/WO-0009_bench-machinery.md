# WO-0009: DV bench machinery (DUT-independent layer)
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your WO-0003 §13.3 bench architecture (accepted); the
  WO-0003/WO-0007 ACCEPTED rulings (X-9 boundary: tools may parse
  rtl_snapshots/**, never libs/** sources; cost probe approved); SPEC-M01
  at 22145b5 (the signed §6.1 protocol contract your monitors encode);
  requirements.md at b4b4cf4 (REQ-301/303/304/305 for the reference CRC;
  §12 strobe appendix; §9.1 config table); ADR-0005 (CI-authoritative —
  every "it works" claim cites a run ID)
- **Deliverables** (all under test/** and tools/**):
  1. **Cyclesim cost probe**: a throwaway-marked bench measuring
     cycles/second on the CI runner (word_counter or a trivial DUT is
     fine); result read from the CI log and recorded in your journal with
     the run ID. This sizes the 10 000-frame stress commitment.
  2. **REQ-305 software reference**: the bit-serial CRC-32 you already
     validated, as a reusable OCaml module under test/ with an expect
     test anchoring REQ-303 (0xCBF43926) and REQ-304 (0x2144DF1C across
     several lengths). This is the oracle every FCS bench will import.
  3. **Protocol monitor**: the SPEC-M01 §6.1 stream-legality checker
     (tkeep contiguity, tlast rules, the §6.3-item-5 must-not-assert
     guards) as a Cyclesim-attachable module with its own unit expect
     test on hand-built legal/illegal traces.
  4. **Conservation monitor + octet-time latency tagger**: per your
     §13.3 design (8×cycle + lane/byte position), DUT-independent,
     unit-tested the same way.
  5. **C-9 + X-9 tools scripts**: record-vs-appendix checks (Status vs
     §12, Config vs §9.1) and the emitted-Verilog structural checks
     (REQ-001/017/018/306/808 now; REQ-903's script lands after C-8
     settles its wording) — plain scripts under tools/, each runnable
     standalone and wired into CI only if trivially cheap (your call;
     document either way).
  - Journal entry J-dv_lead-0004; Files-in-this-commit = exactly what you
    created (test/**, tools/**, this packet).
  - Return log entry (state → RETURNED).
- **Definition of done**: everything compiles and its tests pass in CI
  (expect snapshots follow ADR-0005 promotion if any waveform/output
  snapshot is involved — never hand-author); no RTL read (libs/** stays
  unopened, PROTOCOL §10); monitors encode the SPEC-M01 contract by
  citation, not by reading Hardcaml sources beyond the Axi64 type module
  you must import to attach to streams (that import is the one sanctioned
  exception — it is the signed public interface, not implementation).
- **Out of scope**: per-module benches for M03+ (their specs are not
  frozen); the XGMII link-partner model's implementation if it requires
  M03 spec details still in flight — the interface skeleton and the
  arrival scheduler are fine; golden models beyond CRC.
## Task
The machinery layer every Phase-1 bench stands on. Parallel with the
architect's WO-0008 — do not touch docs/specs/**.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-02, journal `J-dv_lead-0004`

All five deliverables landed, under `test/**` and `tools/**` only. Twenty-five
files created; nothing outside my write scope was touched; `libs/**` was never
opened.

**Layering, because it is the decision the rest of the packet follows from.**
Every monitor is plain OCaml over a `Stream_word.t` record and depends on no
Hardcaml, no simulator and no DUT. Attachment to a simulation is a per-cycle
closure (`Protocol_monitor.sink`), which a `Cyclesim` loop and a
`hardcaml_step_testbench` cycle hook drive identically. The consequences are
the point: the monitors' own tests fail when a monitor is wrong rather than
when a design is; they were type-checked and *executed* locally against the
system OCaml 4.14 compiler despite ADR-0005; and exactly one file in DV names a
`hardcaml_axi` field.

**1. Cyclesim cost probe** — `test/cost_probe/`, marked THROWAWAY in the
directory's dune, the source header and every line of output. A synthetic
Hardcaml design (1, 8 and 32 sixty-four-bit registers) runs 100 000 cycles per
size; the probe prints `COST-PROBE …` lines with CPU seconds, cycles/second and
the implied wall time of a 110 000-cycle stress bench. It is an executable on
the `runtest` alias with `(deps (universe))`, not an expect test: a wall-clock
figure can never be promoted into a snapshot, because the workflow's
`git diff --cached --exit-code` step would then fail on every run forever, and
`(universe)` stops dune serving a stale figure from cache. Three sizes rather
than one because the plan needs the slope: `narrow` brackets a per-module bench
from below, `wide` brackets `nic_top` from above. **The figure is read from the
CI log** (`grep COST-PROBE`) and recorded in a later journal entry with its run
id. Synthetic rather than `word_counter` so the probe reads nothing under
`libs/**`.

**2. REQ-305 bit-serial CRC-32 reference** — `test/golden/crc32_ref.{ml,mli}`,
the charter §3 golden-model home, deliberately outside data_wrangler's
`tools/**`. Written from requirements.md §4 and SPEC-M02 §6.1; bit-serial, no
table, no eight-way unrolling, so it shares no structure with the engine it
will judge (which is why REQ-305 names a bit-serial reference). Ports carry
SPEC-M02's **finished** values, so the RTL comparison is
`crc_out = update ~crc_in octets` with no conversion at either end.
`test_crc32_ref.ml` anchors REQ-303's 0xCBF43926 and REQ-304's 0x2144DF1C at
eight frame lengths (1, 9, 26, 46, 60, 64, 100, 1500), plus: `CRC32("")` = 0
(the seed premise the whole convention rests on), SPEC-M02 §6.1 worked example
1 including its derived 0x9AE0DAAF and the 0x3837363534333231 packing, worked
example 2's M04 7×8+1×4 and M03 8×8 decompositions, REQ-302 serial equivalence
and a second independent bit-serial formulation over 3 000 cases each, note 3's
two raw-register conversions, §4's provenance value 0xC704DD7B, and a negative
case proving the residue is *not* constant when the FCS is appended
most-significant-octet-first (which is what pins REQ-202's wire order).

**3. SPEC-M01 §6.1 protocol monitor** — `test/monitors/protocol_monitor.{ml,mli}`
with ten unit tests on hand-built legal and illegal traces. Rules: `tkeep`
contiguous from bit 0, `tkeep` ≠ 0, `0xFF` on every non-`tlast` word (REQ-011);
`tstrb` = 0 (REQ-014); the REQ-015 word-count residue when a bench supplies the
producing spec's pinned maximum, and *not* invented when it does not. The
§6.3-item-5 guards are structural, not conventional: every rule sits inside one
`tvalid` test at the top of `observe`, `Stream_word.octets` is the only read of
`tdata` and returns only kept positions, and `to_string` prints `idle` and
nothing else for an invalid cycle so an unconstrained value can never reach a
snapshot and freeze into an accidental requirement. Two tests falsify the
guards directly (a trace of deliberately toxic idle cycles; a legal word with
nonsense above `tkeep`). `on_clear` discharges REQ-009/D-8: the frame in
progress is dropped, counted and never flagged.

**4. Conservation monitor + octet-time latency tagger** —
`test/monitors/conservation_monitor.{ml,mli}`, `strobes.{ml,mli}`,
`octet_time.{ml,mli}`, fourteen unit tests. The conservation monitor implements
§0.6 with three deviations, each of which is a carry-forward made executable:
it balances on **discarded frames**, not strobe pulses (C-2 — the co-occurring
test shows pulses giving residual −1 where frames give 0, i.e. a false failure
on a conformant design); a discard reported with no strobe is refused as the
silent discard REQ-008 prohibits; and frames never accepted under REQ-009
`clear` or REQ-810 receive-disable are recorded exempt and left outside the
equation. Strobe names are validated against requirements.md §12. The tagger
implements §0.5 octet time on both port kinds and per-octet latency with a
`strip_octets` offset; `Octet_time.word_cycles` is C-1's ΔC = (L + h)/8
alongside §0.5's `floor (L / 8)`, and both are printed, so a packet written
against either wording is checkable. The D-4 lane walk from `J-dv_lead-0002` is
now an executable regression: it asserts the cycle metric takes **two** values
inside one lane-4 frame while octet time takes one, and that the two start-lane
constants differ by 4 ≤ 8 octet times.

**5. C-9 and X-9 scripts** — `tools/check_records_vs_appendix.sh`,
`tools/check_emitted_verilog.sh`, `tools/dv_checks.sh`. These are the only
WO-0009 deliverables that run in the development container (ADR-0005's blocker
is the OCaml toolchain, not the shell), so they carry real local evidence, and
each was **negative-tested against eleven seeded mutations, eleven kills**. C-9
checks: SPEC-M01's `Status` record against §12 as ordered
character-for-character sequences, the `Config` record against §9.1 (twelve
fields, widths in order — names are not compared, because §9.1 writes them in
prose and the record in OCaml, so the correspondence is SPEC-M01 §4.2's human
judgement and saying otherwise would be a false check), the DV library's own
copy of §12, and — one per module spec **discovered** under
`docs/specs/modules/`, not a hardcoded batch-A list — each spec's §4.1 block
against its `ifc_check` lift byte for byte, failing rather than skipping when a
lift is missing. It already covers batch B: run against this working tree it
reports eight checks and zero failures, the three in-flight `xgmii_rx_64`,
`xgmii_tx_64` and `eth_mac_10g` lifts included. X-9
checks REQ-001 (every edge expression resolves through Hardcaml's `assign`
aliasing to `clock`; `negedge`, multiple edge terms and derived clocks all
fail), REQ-306, REQ-808, REQ-018 (instantiation whitelist, constraint-file
sweep, link-partner location) and REQ-017. **REQ-903's script is deliberately
absent** and prints why: C-8 leaves it with no determinable answer for M01.

**CI wiring — the call, documented as asked.** *Recommended, not applied.* The
scripts are sub-second and dependency-free and I would wire
`tools/dv_checks.sh` as one step in `.github/workflows/build.yml`; the exact
step is quoted in the script's header. I did not apply it because `.github/**`
is the orchestrator's write scope (PROTOCOL §6). I also considered and rejected
the route that *is* inside my scope — a dune rule on the `runtest` alias — for
a reason worth recording: a dune action runs inside `_build`, where only files
some rule depends on are present, so the script would need file-level
dependencies on `docs/specs/**` and `rtl_snapshots/**`, and a mistake there
fails the whole build in a way ADR-0005 leaves me unable to test locally. A
one-line workflow step has none of that risk. **Request to the orchestrator:
add the step.** Until it lands these checks are on-demand and cited by SHA.

**`hardcaml_step_testbench` — added to the opam file, deliberately not used
here.** CI's `opam install --deps-only` already proves it resolves and
installs, which was WO-0003 §13.4's request. Writing a coroutine now against an
API no local build can check would put compile risk on this work order for no
coverage, and the closure-based attachment means nothing has to change when the
first packet-level bench lands. Recorded in `test/axi64_probe/dune`.

**Every expect snapshot is deliberately EMPTY — thirty of them.** ADR-0005 rule
2: snapshots are promoted from CI's own diff output and are never
hand-authored. Counts: `test/golden/test_crc32_ref.ml` 6,
`test/monitors/test_protocol_monitor.ml` 10,
`test/monitors/test_conservation_monitor.ml` 8,
`test/monitors/test_octet_time.ml` 6. Verify with
`grep -c '\[%expect {| |}\]' test/golden/test_crc32_ref.ml test/monitors/test_*.ml`.
**The first CI run after this commit is expected to fail** at `dune runtest`
with thirty diffs; that diff *is* the promotion source. Because a hand-written
snapshot is the one thing this discipline exists to prevent, none of the
pass/fail judgement lives in the snapshots: every case states its expected
constants and verdict in OCaml, prints `ok` / `VERDICT ok` or a `MISMATCH` /
`VERDICT WRONG` line, **and raises**. Promoting a red snapshot cannot make a
broken check look green.

**The one sanctioned `Axi64` import, and what compiling it settles.**
`test/axi64_probe/axi64_probe.ml` is the only DV file that names a
`hardcaml_axi` field. It imports `Ifc_check.Axi64_ifc.Axi64` — the lift of
SPEC-M01 §4.1 under `docs/specs/ifc_check/`, byte-identical to the
specification and countersigned at 22145b5. That is the signed public interface
and not an implementation, which is the exception the packet grants;
`libs/hardcaml_ethernet/src/axi64.ml` is specified but does not exist at this
SHA, and `libs/**` stayed unopened. It is a **separate dune library** on
purpose: SPEC-M01 §11.4 records that `Axi64.Source`'s field names are
transcribed from `stream_intf.ml` and unverified by any compile — run
30727252770 elaborated the functor but no lift names a field outside a comment
— and this is the first code in the repository to name `tvalid`, `tdata`,
`tkeep`, `tstrb`, `tlast`, `tuser` on a real `Source`. **A green build
discharges §11.4. A red one is §11.4's answer**, the repair is editorial and
confined to one file, and dropping `test/axi64_probe/` from the commit leaves
every other deliverable building and running. The library also exposes
`of_refs`, which names no stream type at all and therefore survives `Axi64`
moving to `libs/` — that move is a one-line retarget of `of_source` and is on
the open-questions list rather than left to be discovered.

**New carry-forward, C-11 (REQ-015 self-contradiction at the one-word frame).**
REQ-015's two sentences cannot both be enforced. The 190-word figure it quotes
for the `Xgmii_rx_64` output stream only comes out if words are counted
*inclusive* of the `tlast` word (1514 octets = 189 full words + a 2-octet
remainder), and under that same convention the second sentence — "SHALL NOT
assert `tlast` without at least one preceding word since the previous `tlast`"
— forbids the single-word frame that REQ-011 and SPEC-M01 §6.1 make mandatory
for any 1-to-8-octet payload. The wording is mine, proposed in WO-0003, so this
is my defect to raise. In any case the second sentence has no observable: the
only shape it could forbid is `tlast` on a cycle carrying no word, and §6.3
item 5 forbids a monitor from looking at `tlast` when `tvalid` = 0. The monitor
enforces the inclusive count and nothing from the second sentence; the reading
is recorded at the top of `protocol_monitor.ml` and a unit test asserts the
single-word frame is legal. Requested fix: delete the sentence, or restate it
as "a frame comprises at least one word, the `tlast` word included". Owner
architect_docs_lead; must land before the first `SO-` cites the monitor.

**Shared-working-tree notice.** While running the `tools/` scripts I observed
uncommitted modifications to `docs/specs/**` in this working tree — the
architect's parallel WO-0008. Stated so the record is unambiguous: everything
here derives from the **committed** text (requirements.md at b4b4cf4, SPEC-M01
and SPEC-M02 at 22145b5), and I touched nothing under `docs/`. One observation
worth passing on: those in-flight edits appear to adopt C-1 (word delay
ΔC = (L + h)/8 becoming the normative conversion in §0.5, §1.1, REQ-006 and
REQ-019). If that lands, `Octet_time.word_cycles` is already the normative
figure and no code changes. The orchestrator should stage only the paths listed
in `J-dv_lead-0004`; R1 would refuse a mixed-agent commit in any case.

**Definition of done.** Met, with the one gap ADR-0005 makes unavoidable:
"everything compiles and its tests pass in CI" cannot be claimed by me and is
not claimed. What I can evidence locally is in `J-dv_lead-0004`: the six
stdlib-only modules type-check clean under `ocamlc -w +a-4-9-40-41-42-44-45-48-67-70`
with no warnings; all thirty expect-test bodies, mechanically de-ppx'd, compile
and **run green**; the two Hardcaml-dependent files parse; and both `tools/`
scripts pass and kill every seeded mutation. The authoritative verdict is the
orchestrator's push and its CI run id.
