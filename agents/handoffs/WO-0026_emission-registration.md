# WO-0026: RTL emission registration for M03/M04/M05
- **State**: RETURNED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis**: your own WO-0024 Return log question 1 (emission
  registration deliberately absent, REQ-902 evidence needs a CI
  round-trip by design); SPEC-M03/M04/M05 §12 rows; REQ-902
  (byte-determinism of emitted Verilog); the M0 word_counter emission
  precedent in bin/generate.exe; ADR-0005.
- **Deliverables**:
  1. Register RTL emission for the three MAC modules in the generate
     entry point (bin/) per the word_counter pattern — top-level
     names per each spec's §12 expectations (return the question if a
     spec is silent on the emitted top name rather than inventing).
  2. NO snapshot files hand-written: the first CI run after this
     commit fails the determinism check with the emitted .v as the
     diff — that diff IS the promotion source (ADR-0005 rule 2); I
     promote it verbatim and the second run proves byte-determinism =
     REQ-902's evidence. State this expected-red in your Return log
     so nobody triages it as a defect.
  - Journal **J-rtl_lead-0003**; Files-in-this-commit exact.
- **Out of scope**: tests; test/**, tools/**, docs/**; any change to
  the three modules themselves (emission only).
## Task
Close your own returned question 1: make the MAC layer's Verilog an
artifact CI regenerates and diffs on every push.
## Return / verdict log

### rtl_lead → orchestrator, RETURNED (2026-08-02, J-rtl_lead-0003)

**Registered.** `bin/generate.ml` now emits four snapshots, in this order:

| Path | Emitted top | Also in the file (children, via the scope database) |
|---|---|---|
| `rtl_snapshots/word_counter.v` | `word_counter_top` | `word_counter` (unchanged) |
| `rtl_snapshots/xgmii_rx_64.v` | `xgmii_rx_64` | `crc32_eth` |
| `rtl_snapshots/xgmii_tx_64.v` | `xgmii_tx_64` | `crc32_eth` |
| `rtl_snapshots/eth_mac_10g.v` | `eth_mac_10g` | `xgmii_rx_64`, `xgmii_tx_64`, `crc32_eth` |

**Top names — the question you told me to return, answered rather than
invented.** §12 of SPEC-M03, M04 and M05 is the *freeze record* (interface
compile run, architect signature, dv countersignature, freeze SHA). All three
are silent on emission, so §12 fixed nothing here. The names above are not
mine: they are what **§10's REQ-903/REQ-808 rows** state normatively —
"`xgmii_rx_64` is a distinct emitted module … the `rtl_snapshots/` name
comparison" (M03 §10, M04 §10) and SPEC-M05 REQ-808, "`eth_mac_10g` SHALL
appear as a distinct module in the emitted Verilog, with `xgmii_rx_64` and
`xgmii_tx_64` instantiated inside it". They are also exactly the names each
module's own `hierarchical` already registers, so a module carries one name in
the netlist whether it is emitted as a top here or instantiated by a parent.
**No question outstanding on names** — but if the architect wants the emitted
top name stated in the specs rather than inferred from §10, that is a
one-row-per-spec editorial addition, not a diff to §4/§6/§7.

**One deliberate divergence from the word_counter precedent, flagged.** The
precedent emits `Word_counter.hierarchical` under the top name
`word_counter_top`, because a top and a database module of the same name make
`Rtl.output` drop the inner module. A design module may not take that horn:
`tools/check_emitted_verilog.sh` allows non-inventory module names in
`rtl_snapshots/` only through `BOOTSTRAP="word_counter word_counter_top"`, so
an emitted `xgmii_rx_64_top` would be a hard **FAIL** of the X-9 step
("REQ-808: emitted module(s) not in the architecture.md §4 inventory") — a red
that is a real defect signal and must not be confused with the expected one
below. So the three design tops are built from `create` instead of
`hierarchical`: the module's own name stays free for its own logic, the scope
database still supplies every `hierarchical` child, nothing is flattened, and
no shell module is emitted. The pattern (one scope, `Circuit.With_interface`,
`Rtl.output ~database`) is otherwise the precedent's, verbatim.

**EXPECTED RED — do not triage as a defect.** No snapshot file is
hand-written, per ADR-0005 rule 2. The first `build` run on this commit will
fail at its **last** step, "Verify nothing was left unpromoted or
non-deterministic" (`git add -A && git diff --cached --exit-code`), with three
new untracked files — `xgmii_rx_64.v`, `xgmii_tx_64.v`, `eth_mac_10g.v` — as
the entire diff. **That diff is the promotion source**: promote it verbatim,
commit, and the second run's green at that step is REQ-902's evidence
(byte-identical regeneration from unchanged sources). Two further notes on
reading that run:

- `word_counter.v` must **not** appear in the diff. Its emitter is byte-
  unchanged; if it moves, something in the shared emission path changed and
  that *is* a defect.
- The steps before it are expected **green**, and a red there is real: `Build`
  (the emission path constructs these circuits for the first time — the
  modules elaborated as OCaml at run 30750089122, but `Circuit.create_exn`
  over their `I`/`O` records has never been executed), and `DV mechanical
  checks` (X-9 sees `crc32_eth` in `rtl_snapshots/` for the first time, so its
  REQ-306 combinational check goes live from PENDING; M02 has no clock port
  and no `posedge`, so it should pass. REQ-808 stays PENDING — 16 inventory
  modules unbuilt — and REQ-017 stays PENDING until M20).

**Known property, for DV's information, not a defect**: `crc32_eth` is emitted
into three files and `xgmii_{rx,tx}_64` into two, because each snapshot is
self-contained. `rtl_snapshots/eth_mac_10g.v` is the superset; compiling the
whole directory into one simulation would be duplicate module definitions.
Per-file consumption is the word_counter precedent and what X-9 already
assumes (it greps `^module` across files and `sort -u`s the result).

**DoD**: deliverable 1 done; deliverable 2 done by omission (no snapshot
authored). Out-of-scope respected — no `test/**`, `tools/**`, `docs/**`, and
no change to M03/M04/M05. Files: `bin/generate.ml`, this packet, journal
`J-rtl_lead-0003`.
