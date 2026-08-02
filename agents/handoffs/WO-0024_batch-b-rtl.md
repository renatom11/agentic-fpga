# WO-0024: Batch-B RTL — M03 `Xgmii_rx_64`, M04 `Xgmii_tx_64`, M05 `Eth_mac_10g`
- **State**: ISSUED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis** (PROTOCOL §10): SPEC-M03/M04/M05, FROZEN at f78766e,
  §13 rows since (M03: C-18 + twin; M04: C-14 set, C-16's C+8 rule,
  C-31's ordered-and-unpinned §9 — read every §13 row, the frozen
  text + its recorded diffs IS the spec); ADR-0006/0007 (CRC ports,
  octet_count); ADR-0008 (M04-adjacent handshake context); ADR-0010
  (consumer conventions — `open! Axi64` NORMATIVE, no named module
  type S); your delivered M01/M02 at 189d5b2 (the vocabulary + the
  CRC engine these modules instantiate).
- **Environment**: hardcaml v0.17.1 sources readable at
  /root/.opam/fpga/.opam-switch/sources/hardcaml (your own WO-0016
  finding — bind constructs to real signatures there);
  hardcaml_axi/base sources absent; ADR-0005 blind-write + CI
  round-trip discipline, same as WO-0016 (green first try is the bar
  you set).
- **Deliverables**:
  1. libs/hardcaml_ethernet/src/xgmii_rx_64.ml/.mli — SPEC-M03: XGMII
     decode, start-lane handling (lanes 0/4), FCS check via your
     Crc32_eth, the 21-strobe discipline, one 64-bit word/cycle zero
     backpressure (the line-rate invariant, charter red line).
  2. xgmii_tx_64.ml/.mli — SPEC-M04: encode, IFG, CRC insertion,
     tx_tready per §6.1's cycle table INCLUDING the C-16 C+8 rule and
     C-31's ordered-and-unpinned §9 strobes.
  3. eth_mac_10g.ml/.mli — SPEC-M05: the structural wrapper, total
     wiring per its §6.1.
  4. dune untouched unless needed; RTL emission registration per
     SPEC-M05 §12's expectations if its frozen text names one,
     otherwise return the question.
  - M03 is on your personally-implemented list (charter §2: hard
    receive modules). Decompose M04/M05 to rtl_module_dev workers ONLY
    if you judge the packets writable without ambiguity — otherwise
    implement personally; you cannot spawn (orchestrator is sole
    spawner), so "decompose" means: return the worker packets in your
    Return log and I spawn them under your review. Simpler: implement
    all three personally this wave if that is faster than packet-
    writing; your call, state it.
  - Journal **J-rtl_lead-0002**; Files-in-this-commit exact;
    line-by-line self-review in the Return log (charter §3).
- **Out of scope**: tests (dv-owned, red line); test/**, tools/**,
  docs/** (spec questions return as questions — note C-37's repair is
  in flight at SPEC-M14, does not touch your three specs).
## Task
The MAC layer. Second RTL activation: three modules against the
longest-frozen full-behaviour specs in the programme.
## Return / verdict log

### RETURNED — rtl_lead, 2026-08-02 (spawn `WO-0024/2026-08-02T16:50Z`)

**State**: RETURNED. Six files under `libs/hardcaml_ethernet/src/`:
`xgmii_rx_64.ml/.mli`, `xgmii_tx_64.ml/.mli`, `eth_mac_10g.ml/.mli`.
`dune` untouched (it has no `(modules)` field, so the three modules
build as they stand — deliverable 4 is the empty diff, stated rather
than assumed). `bin/`, `rtl_snapshots/`, `test/`, `tools/`, `docs/`
untouched.

#### 1. Implement-vs-decompose call: **all three personally.**

Decomposition was rejected on a single argument. M04's spec is
*harder* than M03's, not easier: the C-16 §7 bullet, the C-14.1
`tx_tready` rule and the C-31 §9 co-occurrence text are four
carry-forwards that a worker packet would have to restate *exactly*,
and a packet that restates them imperfectly produces RTL that
compiles, passes a naive reading and fails REQ-209's composed cadence
by one cycle — the precise failure C-16 exists to prevent. Writing a
packet faithful enough to avoid that is writing the module's timing
contract out longhand, which costs more than implementing it. M05 is
80 lines of wiring and is not worth a spawn round-trip. M03 was mine
by charter §2 regardless.

The cost is that all three are unreviewed by a second party. I have
recorded the line-by-line self-review in §4 below, and I flag it
explicitly: **self-review is not independent review**, and the
compensating controls here are dv_lead's independently written suites
and the auditor's mutation campaign, not this section.

#### 2. Deliverable 1 — M03 `Xgmii_rx_64` (SPEC-M03)

Microarchitecture, and the alternatives rejected:

- **One rotation window shared by the octets and their coverage
  vector.** Aligned word *m* is the frame's output word *m* − 2 at
  **both** start lanes, which is where §7's ΔC = 3 comes from without
  a per-lane special case: at a lane-0 start the aligned word is
  simply the previous input word, at a lane-4 start it is the previous
  word's upper four octets followed by this word's lower four. Payload
  storage is the input-word register plus the output register —
  **two datapath words**, REQ-019's permitted depth exactly.
- **FCS removal by `tkeep` with one word of lookahead, and no
  counters.** The emitted word's `tkeep`/`tlast` are a function of two
  numbers: the octet count of the word being emitted and of the word
  behind it. A word with fewer than eight octets is necessarily the
  frame's last (a frame's octets are contiguous from aligned position
  0), so "fewer than eight behind me" *is* the end-of-frame signal and
  the four FCS octets are unmarked wherever they straddle. Rejected: a
  delivered-octet counter compared against a per-frame total, which
  needs the total before the first word leaves and cannot be
  cut-through.
- **REQ-108 by capping coverage at 1518 and letting the four-octet
  tail removal run**, which delivers exactly 1514. Rejected: capping
  coverage at 1514, which would stop the CRC short of the FCS octets
  and break the *legal* 1518-octet frame.
- **The §9 report travels as a three-age record beside the payload**
  (age 0 combinational, ages 1 and 2 registered), consumed oldest
  first. This is what pins §9's strobe cycle: the `tlast` cycle when a
  word is emitted, and age 2 — "two cycles after the input word
  carrying the character that ended the frame" — when none is. Two
  closures can never be less than two cycles apart (a closure sends
  the machine to `Idle`/`Discard` for at least one cycle), so three
  ages hold every live record without a queue. Rejected: a single
  latched record, which loses a frame's strobe when the next frame
  closes on the drain's last cycle — reachable with a normal frame
  followed by a sub-5-octet runt.

Per-REQ notes where the implementation is not a transcription:

- **REQ-101 / REQ-021 / REQ-111**: the alignment offset register
  deliberately **lags** the frame's start lane by one cycle when the
  new offset is 4. A REQ-110 restart can put the aborted frame's last
  octets in the same input word as the new frame's start character;
  those octets must still be rotated by the *old* offset. A new offset
  of 0 needs no lag, because in that case the aborted frame has no
  octets left in the window. Without this the REQ-110 lane-4 restart
  loses four delivered octets silently.
- **REQ-016 / REQ-113**: a control lane that is not `/S/`, `/T/` or
  `/E/` ends that word's coverage without closing the frame. That one
  rule is both REQ-016's "an input word covering no frame octet holds
  the frame" (C-14.4) and REQ-113's "ordered sets ignored", and it
  means an idle word inside an open frame is never decoded as eight
  data octets.
- **REQ-105 / REQ-110 / §9's closure list**: the *lowest* lane wins
  within a word, because the frame is already closed when a later
  character in the same word arrives.
- **REQ-104**: the residue form, one equality against 0x2144DF1C, with
  no octet-order reassembly of the received FCS — §6.1's stated
  choice. The comparison is made on the value *after* the closing
  word's update and is carried in the closure record, **not** read
  from the CRC register at the `tlast` cycle: a frame starting one
  cycle after a terminate re-seeds that register before the previous
  frame's `tlast` word leaves.
- **REQ-810 / REQ-803**: `cfg_rx_enable` gates only the *beginning* of
  a frame. A REQ-110 `/S/` arriving while it is 0 still aborts and
  still pulses `error_start_without_terminate` — the abort belongs to
  a frame that was accepted under the old value — and the new frame
  does not begin. Flagged as a reading, not asserted as obvious.

#### 3. Deliverables 2 and 3 — M04 `Xgmii_tx_64`, M05 `Eth_mac_10g`

**M04** is one position sequence and one composed word. Every octet of
a transmitted frame has a position counted from the first DA octet;
the four boundaries (payload end, pad end, FCS end, terminate) are
taken relative to the word's position as **signed** offsets, so a
boundary already passed is negative. Consequence: a word carrying
payload, pad, FCS and the terminate character at once needs no special
case, and an FCS split across two words needs no second counter. The
rejected alternative was §6.2's seven states as seven behaviours,
which makes `Frame`/`Pad`/`Fcs` three copies of the same lane
arithmetic and puts the straddles in the transitions between them.

- **§7's C-16 cycle (C+8) falls out rather than being special-cased.**
  `tx_tready` is asserted exactly when the composer consumes a payload
  word this cycle; at C+8 it consumes the `tlast` word's four octets,
  so `tx_tready` = 1 there with no rule of its own, and at C+9 it
  consumes nothing, so `tx_tready` = 0. A word presented at C+8 is
  accepted into the two-entry holding structure, which §7 case 4
  bounds at two accepted-untransmitted words — that bound is the whole
  of the `tx_tready` full condition.
- **§7's C-14.1 gap rule**: `tx_tready` is 1 on the gap's last cycle
  because that cycle is the one on which a frame may begin, and the
  preamble it composes lands on REQ-204's rounded lane-0 boundary.
  Earlier gap cycles are 0, which §6.3 item 3 permits and REQ-207 and
  REQ-204 bound.
- **REQ-206 / §9's two-cycle wire consequence** is structural: the
  strobe pulses on the acceptance cycle where the word was required
  and absent; the composer finds the holding structure empty on the
  next cycle and composes the abort word; that word reaches the wire
  on the cycle after. `tx_tready` is suppressed while starved, which
  is what keeps the strobe exactly one cycle wide.
- **C-31** needed no code: M04 reports only its own condition and has
  exactly one strobe. The ordered-and-unpinned relationship with
  `error_tx_length_mismatch` is M18's and M04's separately, and there
  is nothing here to synchronise.
- **§7's reset clause wins over §6.2's `Idle` row (C-14.2)**:
  `tx_tready` is 0 while `clear` = 1 and on the first cycle after,
  whatever `cfg_tx_enable` says, and the lanes carry idle across that
  window — the output registers clear to zero, which is not an idle
  character, so the window is muxed at the port rather than assumed.

**M05** is the wiring and nothing else: two `hierarchical` calls and a
record of pass-throughs. No register, no mux, no logic — §6.1's table
is total and §8's "joins the stress list by spec diff if it gains
datapath logic" stays inapplicable by construction. §6.3 item 2 leaves
the `.mli` re-exports to me: it re-exports nothing, because a consumer
already has M01's records through `Axi64` and a re-export would be a
second place to state the same names.

#### 4. Line-by-line self-review (charter §3), and what it found

Read after writing, against §4.1/§6/§7/§9 of each spec. Four defects
found and fixed **before** this return; recorded because a review that
reports nothing is a review that was not done.

1. **M04, combinational loop.** `need_payload` derived from the
   payload-end boundary closed the cycle
   `consume → end_now → payload_end_eff → d_payload → consume`. Fixed
   by deriving `need_payload` from *registered* state only
   (`have_end`, `payload_end` against `pos`); the two formulations
   agree cycle for cycle and the reason is in the source. This would
   have been a Hardcaml elaboration failure, not a wrong waveform.
2. **M03, `cap_end` unsaturated.** `cov_first + room` was clamped for
   `room ≥ 8` but not for the sum, so in `Idle`/`Discard`
   (`cov_first` = 8) a small room produced a value above 8 and
   spurious coverage. Fixed by saturating the sum.
3. **M03, idle words decoded as data.** An input word of idle
   characters inside an open frame was covered as eight data octets,
   which corrupts the CRC of every frame REQ-016's injection wrapper
   touches — and §10 commissions that wrapper against this module at
   0, 1 and 7 cycles. Fixed by the not-`S`/`T`/`E` control rule above.
4. **M03, frame-boundary lookahead.** The FCS-removal lookahead read
   the *next frame's* first aligned word as a continuation of the
   current one on a REQ-110 restart, emitting the aborted frame's last
   word without `tlast`. Fixed by rotating a one-hot marker on each
   frame's first covered octet through the same window, which makes
   "this aligned word begins a new frame" available where the
   lookahead needs it.

Also checked and unchanged: `tstrb` driven 0 at the only producer
(REQ-014); no `tready` on M03's ports and none reachable from M04 into
M03 (REQ-003, REQ-208 — M05 wires nothing between the halves);
`octet_count` never 0 at either CRC call site (ADR-0007); `open!
Axi64` and only `Axi64` in all three files, no named `module type S`
anywhere (ADR-0010); `create` and `hierarchical` exported from every
`.mli`, no `[@bits]` in any signature (REQ-903).

#### 5. Compile-risk register (ADR-0005 — I cannot build; CI adjudicates)

Named so the round-trip is cheap, highest first:

1. **`Always.State_machine.create (module State) spec`** — the state
   modules derive `compare, enumerate, sexp_of` via `ppx_jane`, which
   the library's `(pps ppx_hardcaml ppx_jane)` provides. If the
   deriver set is wrong the error is at the `module State`/`module
   Phase` declaration. This is the one construct in the delivery with
   no precedent in this repository.
2. **Constructor disambiguation** — `sm.is State.Idle` is qualified,
   but `sm.set_next State.Body` and the `switch` case labels rely on
   `Phase.t`/`State.t` being inferred. Dune's dev profile disables
   warnings 40–42, so this should be quiet; if not, the fix is
   mechanical qualification.
3. **`Signal.popcount` / `onehot_to_binary` / `binary_to_onehot`
   widths** — I read v0.17.1's `comb.ml`: `popcount` on 8 bits returns
   `ceil_log2 9` = 4 bits, `onehot_to_binary` on 8 returns 3. If
   either differs, the error is a width mismatch at a `mux` or a
   comparison and the fix is a `uresize`.
4. **Signed comparison operators** (`<+`, `>=+`, `<=+.`, `>=+.`) on
   13-bit position offsets in M04 — bound to `comb_intf.ml`, but this
   is the only place the programme uses them.
5. **Top-level `Signal.t` constants** (`idle_word`, `preamble_word`,
   `abort_word` in M04) shared across every instantiation. Legal —
   they are immutable graph nodes — but if hierarchical emission
   objects, the fix is to build them inside `create`.
6. **`open! Axi64` in an `.mli`** — three new signatures use it where
   `crc32_eth.mli` did not. `open!` is legal in a signature; if the
   inner-module shadowing behaves differently there, the fallback is
   `Axi64.Axi64.Source.t` in the `.mli` only, which would be an
   ADR-0010 deviation and would come back as a question, not a quiet
   edit.

#### 6. Questions returned

1. **RTL emission registration (deliverable 4).** SPEC-M05 §12 is the
   four-row freeze record and names **no** emission entry point;
   §10's REQ-808 hook says the check is "the `rtl_snapshots/` module-
   name comparison", and `tools/check_emitted_verilog.sh` treats an
   un-emitted inventory module as PENDING rather than FAIL. So I have
   **not** touched `bin/generate.ml` or `rtl_snapshots/`, per the
   work order's "otherwise return the question". Registering M05 (and
   with it M03, M04, M02) is a one-function change I can make in a
   follow-up; it should land in a packet that also carries the
   double-generation byte-identity evidence REQ-902 and my charter §8
   require, which I cannot produce blind. **Request: a follow-up WO
   for emission + determinism evidence, after this one is CI-green.**
2. **Two closure characters in one input word, beyond §10's
   `/S/`-then-`/S/` case.** M03 recognises exactly one closure per
   word — the lowest — and reports one condition per cycle. A word
   carrying, say, `/S/` in lane 2 and `/T/` in lane 5 would abort the
   open frame, start a new one and not see the terminate. No
   requirement names the case and REQ-018's link-partner contract
   injects one condition at a time, so I have implemented the
   single-closure reading and am **declaring it rather than leaving it
   to be discovered**. If the architect wants it constrained, it is a
   §6.3 addition (unconstrained) or a §9 addition (specified), and the
   second costs a second report path.
3. **An idle word inside a frame's own preamble.** §6.1 fixes the
   frame's first octet at exactly 8 octet times after the start
   character, so an idle word between the start word and the first
   data word contradicts it. M03 treats that stimulus as outside the
   specified space (the offset would be wrong). Confirming that
   reading in §6.3 would close the last place REQ-016 and §6.1 could
   be read against each other.
4. **`error_runt` on a frame closed by `/T/` while `cfg_rx_enable`
   went to 0 mid-frame** — covered by my REQ-803 reading in §2 above;
   raised so it is visible rather than assumed.
