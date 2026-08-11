# BUG-0004: M04 pulses `error_underflow` on a frame whose **every** source word was presented and accepted — at the one frame shape where REQ-206's window is provably **empty**, a source frame of one word (`P ≤ 8`, `W = 1`)

- **State**: **`OPEN`**. dv_lead's packet. The orchestrator allocates the packet
  number and relays it **verbatim** (PROTOCOL §3); the `NNNN` in this filename is
  dv_lead's prediction of the next free id (`BUG-0001` … `BUG-0003` exist; `0004`
  is next) and is the orchestrator's to confirm.
- **From** / **To**: dv_lead → rtl_lead (via orchestrator, **VERBATIM** relay class)
- **Module / severity**: `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`
  (M04 `Xgmii_tx_64`) | **MAJOR**
  — a false error report on a class of frames the specification admits, with
  **no wire corruption** and **no Phase-1 composed-chain reachability** today.
  §6 states the reachability analysis in full rather than leaving the severity to
  be inferred, and names the one measurement that would convert it.
- **Origin**: the **first execution** of the M04 bench against the M04 design.
  CI `build` run **31476319884** at `cbbeb76`, conclusion `failure`. Not a
  targeted underflow stimulus: **family G does not ride `WO-0080`** (§1.2 of that
  packet excludes it). The strobe was caught by obligation 4's **standing**
  instrument — the strobe monitor attached to every elaboration of the round —
  on a stimulus built to present every word. That is the instrument doing
  precisely the job `test/monitors/strobe_monitor.mli` §(d) exists for:
  *"a design that pulses `error_runt` on every good frame passes every positive
  assertion in an attack plan."*
- **Disposition of record**: `WO-0080` §15 class **D1** — a design defect, **not**
  a bounce. Adjudicated at `J-dv_lead-0175`, against the §15 table as it was
  written **before** any run existed.
- **Independence**: no file under `libs/**`, `top/**` or `rtl_snapshots/**` was
  opened to write this packet. Every expectation below is derived from
  `docs/specs/requirements.md` REQ-206 / REQ-008 and `docs/specs/modules/xgmii_tx_64.md`
  §6.1, §6.2, §7 and §9 at `ee47eee`. §7 states what this packet deliberately
  does **not** claim, including any statement about the implementation's
  mechanism.

---

## 1. Reproduction

```sh
opam exec -- dune build @default
opam exec -- dune runtest
```

at **`cbbeb76650f3b471d0ecc1bf85db4001cb907ec1`**. Three units raise, each at its
**`P = 1`** member and at no other:

| Unit | Row id | Raise site | Length set (the failing member is the **first**) |
|---|---|---|---|
| U5 | `M04-B4` / `M04-B5` | `test/xgmii_tx_64/test_m04_b.ml:298` via `bench.ml:368` | `[1; 20; 59; 60; 61; 64; 67; 1514]` |
| U7 | `M04-C2` | `test/xgmii_tx_64/test_m04_c.ml:112` via `bench.ml:368` | `[1; 59; 60; 61]` |
| U10 | `M04-C5` | `test/xgmii_tx_64/test_m04_c.ml:288` via `bench.ml:368` | `[1; 20; 59]` |

**CI evidence.** `build` run **31476319884**, job `build` id **93730745511**,
`head_sha` `cbbeb76650f3b471d0ecc1bf85db4001cb907ec1`, `run_attempt` **1**,
conclusion **`failure`**. The `Build` step is **green** — the compile cleared at
this SHA, which is what made this the first run in the M04 era to execute
`Run tests` against the design at all.

**The failure text, verbatim from the job log** (un-escaped from the expect
machinery; identical at all three sites but for the row id):

```
(Failure
   "M04-B4/B5 (P=1): strobe monitor unclean:
  [M04 tx strobes] cycles=35 expected=0 high-cycles=1
    high cycles per strobe (C-23, never edges): error_underflow=1
    observed: error_underflow@2
    ERROR: cycle 2: M04 tx pulsed \"error_underflow\" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)")
```

**The stimulus, stated so it can be rebuilt without this bench.** One elaboration
of `Xgmii_tx_64` with `flatten_design:true`; `clear` = 1 for exactly one cycle
then released; `cfg_tx_enable` = 1 and `cfg_ifg` = 12 driven through that cycle
and every cycle after. Cycle numbering starts at the **first cycle with
`clear` = 0**. One source word is offered from cycle 0 and re-offered on every
cycle until it is accepted: `tvalid` = 1, `tkeep` = `0x01`, `tlast` = 1,
`tdata`[7:0] = `0x01`, `tdata`[63:8] = `0xA5` in each unkept octet position
(`tkeep`-0 positions are unconstrained by SPEC-M01 §6.3 item 5 and are
deliberately filled with a non-zero poison so a pad octet cannot be mistaken for
one), `tstrb` = 0, `tuser` = 0. After that word is accepted the source presents
nothing (`tvalid` = 0) for the remainder of the run. The run is 35 cycles. Every
output is read from the `~clock_edge:Side.Before` view of the same cycle.

**Two preconditions of this stimulus were checked by the bench and did not fire**,
which is what removes the presenter from the candidate list (§4):

- the **liveness bound** — a word was accepted by cycle 16;
- **`P-ACCEPT`** — the accepted cycles are exactly `[C]`, contiguous, one word.
  Had the presenter withheld the word or had the design accepted it twice, this
  `failwith` (`bench.ml:284–303`) would have fired **before** the strobe check.

---

## 2. Observed vs expected

| | |
|---|---|
| **Observed** | `error_underflow` **high for exactly one cycle, at cycle 2**, on a run in which every source word the stimulus built was presented and accepted, and in which the XGMII lane pair carried a **complete, correctly padded, normally terminated** frame. |
| **Expected** | `error_underflow` **0 on every cycle of the run.** REQ-206's condition is unsatisfiable on a one-word source frame — §3 derives it — so there is no cycle at which the strobe may be asserted. |

**The wire, in the same run, from assertions that PASSED before the strobe check
raised** — and independently in all three units:

- exactly **one** completed frame decoded, decoder clean (`Tx_decoder.is_clean`
  is checked at `bench.ml:364`, **before** the strobe check at `:368`, and passed);
- **64** wire octets, destination address through FCS — `F = max(P,60) + 4 = 64`;
- wire octets 0 … 59 equal `pad_to_60(content)`: the one content octet followed by
  **59 zero pad octets** (REQ-203 satisfied, checked as a prefix comparison in U5
  and as an explicit all-`0x00` pad-region scan in U7 and U10);
- the terminate character at cycle **`C + 2 + ⌊F/8⌋` = `C + 10`**, in **lane 0**
  (`F mod 8` = 0), with the control bit for that lane set on that word;
- the poison value `0xA5` **nowhere** among the frame octets.

**So the design's two outputs contradict each other.** REQ-206 is a single
`SHALL` binding a strobe to a wire remedy: *"the transmitter SHALL emit an error
character followed by a terminate character and SHALL pulse `error_underflow`
once"*, and SPEC-M04 §9's row states the remedy in full — `/E/` in lane 0, `/T/`
in lane 1, `/I/` in lanes 2–7, **no FCS appended**, the gap served from that
terminate character. The lane pair shows none of it: the frame ran to its normal
terminate character at its normal cycle and lane, with its pad intact. Whichever
of the two outputs one privileges, the pair is not conformant — and §3 says which
one is wrong.

**Clauses violated**, named:

1. **REQ-206** (`requirements.md` line 765) — the strobe is asserted outside the
   window the requirement's own text defines. §3.
2. **REQ-008** — *"no strobe pulses other than those of the conditions the
   stimulus creates"* (the requirement's verification column, half (a)). The
   stimulus created no discard and no truncation; a strobe pulsed.
3. **REQ-206 again, from the other side** — having pulsed, the design did not
   emit the error character the same `SHALL` requires. Recorded as a **second**
   breach and not as a mitigation: a spurious strobe that also produced the abort
   would have destroyed the frame, and this one did not, but "the wire survived"
   is not conformance.

---

## 3. The derivation — why REQ-206's window is **empty** at `W = 1`

Derived from spec text alone. `P` is the source frame's octet count; `W = ⌈P/8⌉`
is its source word count. The failing member has `P = 1`, hence **`W = 1`**.

**REQ-206, verbatim** (`requirements.md`):

> If, on any cycle **after the transmitter has emitted a frame's start character**
> and **before it has accepted that frame's `tlast` word**, the transmitter asserts
> `tready`, requires a word, and no word is presented (`tvalid` = 0), the
> transmitter SHALL emit an error character followed by a terminate character and
> SHALL pulse `error_underflow` once.

SPEC-M04 §9's row states the same two bounds: *"after the start character has
been emitted and before the frame's `tlast` word has been accepted"*.

The window therefore has a lower bound (an event on the **output**) and an upper
bound (an event on the **input**). Locate both for `W = 1`, with `C` the cycle the
frame's first source word is accepted:

1. **Upper bound.** At `W = 1` the frame's first source word **is** its `tlast`
   word. It is accepted at `C`. So the window's upper bound — *before* the `tlast`
   word has been accepted — closes at the end of cycle `C`.
2. **Lower bound.** SPEC-M04 §6.2: `Preamble` is *entered when a first source word
   is accepted* and *emits the REQ-201 word*; §6.1's cycle table shows the
   preamble at `C+1` against an acceptance at `C`. The start character therefore
   exists no earlier than cycle **`C+1`**.
3. **Intersection.** `C+1 > C`. **The window is empty.** No cycle in a one-word
   frame's life satisfies REQ-206's condition — and this holds **whatever the
   value of `C`**, and **whatever the value of `tready`** on any cycle, because
   neither bound mentions `tready`. The `tready`/`tvalid` clause is a further
   conjunct inside a window that never opens.

**SPEC-M04 §7 says the same thing from the other side, in its own words.** The
`C-16` bullet's consequence 1, on the cycle after the frame's `tlast` word is
accepted:

> **Nothing of the current frame may be presented on that cycle, so
> `tx_tvalid` = 0 there is not an underflow.** REQ-206's condition, stated in §9
> and in the handshake bullet below, ends at the acceptance of the frame's
> `tlast` word … **this is the one cycle in a frame's life where `tx_tready` = 1
> with `tx_tvalid` = 0 means nothing at all.**

§7 illustrates that cycle as `C+8` because it is reading §6.1's `P = 60` table,
where the `tlast` word is accepted at `C+7`. **The clause is stated over the
`tlast` acceptance, not over the number 8.** At `W = 1` the `tlast` acceptance is
at `C`, so *that* cycle is **`C+1`** — which is simultaneously the start-character
cycle. **`W = 1` is the frame shape at which §7's silent cycle and §6.2's
`Preamble` cycle collapse onto one another**, and it is the only shape at which
they do.

`requirements.md` §0.6's fourth clause (carry-forward **C-5**, closed 2026-08-11)
is consistent and adds nothing here: it fixes the *reference word* for a report
whose condition is an absence, and states in its own text that at this module the
window *"carries no independent information"* because SPEC-M04 §9's pin sits at
its near edge. There is no absence to reference at `W = 1`; the clause is not
reached.

**What the round pre-committed, before any run.** `WO-0080` §9.4 item 2, quoting
§7's C-16 consequence 1 verbatim, and then: *"Every run in this round passes
through it. Obligation 4's empty strobe set is what asserts the silence."* The
expectation that failed is the one the packet wrote down in advance and derived
from the specification, not one fitted to a result.

---

## 4. The two mechanisms that are **not** this, and why each is excluded

`WO-0080` §15's classes were written before the run. Three mechanisms could
produce this signature; two are excluded on evidence, by derivation from the
bench and specification text, and neither exclusion required reading the design.

**(b) The bench's reactive presenter failed to present a word the design
required — EXCLUDED.** `Bench.present` (`test/xgmii_tx_64/bench.ml:246–256`)
offers word `next` on **every** cycle and advances `next` **only** on acceptance;
after the last word it offers `Stream_word.idle ()`. At `W = 1` there is no
second word in existence to withhold. Two guards would have fired first and did
not: the **liveness bound** (no acceptance within 16 cycles) and **`P-ACCEPT`**
(`bench.ml:284–303`), which requires the accepted cycles to be exactly
`C, C+1, …, C+W−1` — at `W = 1`, exactly `[C]`. The word was offered until taken,
taken once, and nothing further existed to offer. A withheld word would also have
had to be withheld *inside* a window §3 shows is empty.

**(c) The strobe monitor's expectation model wrongly forbids a legal strobe —
EXCLUDED, and the model is mine, so this is the exclusion I had the strongest
reason to test.** The monitor is `test/monitors/strobe_monitor.ml`, dv_lead's
committed instrument; the empty expected-event set is declared by
`Strobe_monitor.create ~name:"M04 tx" ~strobes:["error_underflow"]` at
`bench.ml:73` and is `WO-0080`'s own pre-commitment (§1.2's scope rule: every run
begins and cleanly completes exactly one frame; family G excluded, so no underflow
stimulus is driven anywhere in the round). §3 shows independently that **zero** is
the correct expectation at `W = 1` — not merely the round's convention. And the
monitor's report is a count of **high cycles** on the design's own output pin
(convention `C-23`: high cycles, never edges), sampled every cycle including idle
ones: `cycles=35 … high-cycles=1 … observed: error_underflow@2`. That is an
observation, not a model. The only modelled quantity is `expected=0`, and §3 is
its derivation.

**(a) The design pulses `error_underflow` on a fully presented one-word frame —
SUSTAINED.** By elimination and, independently, by §3's derivation plus §2's wire
evidence.

**What the selectivity brackets, stated exactly, because it is the most useful
thing this packet can hand a fix.** In this run:

- `W = 1` (`P = 1`) — **strobes**, at three independent unit bodies.
- `W = 3` (`P = 20`) — **clean**, adjudicated at four units (`M04-B2`, `M04-C1`/`C6`,
  `M04-C3`, `M04-C4`).
- `W = 8` (`P = 60`) — **clean**, adjudicated at two units (`M04-A1`/`A2`/`A5`,
  `M04-B1`).
- `W = 2`, and `W ∈ {4,5,6,7}` — **not adjudicated, status unknown.** `W = 2`
  (`P` = 9 … 16) is the *nearest untested neighbour* of the failing case and is
  the one extra point a fix should be re-tested at. See §8.
- `P ∈ {59, 61, 64, 67, 1514}` — **driven but never adjudicated.** `P = 1` is the
  first member of all three failing length lists and the raise aborts the
  `List.iter` before the later members are read. Any statement that "every larger
  member passed" is true **only** of `P = 20` and `P = 60`, in other units, and
  this packet asserts nothing about the rest.

So the design suppresses the strobe correctly on the cycle after the `tlast`
acceptance when that acceptance is at `C+2` or at `C+7` — it is **not** a naive
implementation of REQ-206 read to its first full stop, which is the defect
`AP-xgmii_tx_64` row `M04-G4` was written to kill and which would have shown at
`P = 60` too. It fails when the `tlast` acceptance and the frame-opening
acceptance are the **same** acceptance. **This is a distinct defect class from
`M04-G4`'s and no committed row in `AP-xgmii_tx_64` names it**; the plan repair
is dv_lead's, recorded at `J-dv_lead-0175`.

---

## 5. What a fix must satisfy

Stated as observables, not as a mechanism. The mechanism is rtl_lead's, and this
packet takes no position on it (§7).

1. **`error_underflow` = 0 on every cycle of a run whose source presents every
   word of a one-source-word frame**, for any `P` in 1 … 8 — at every cycle,
   including the start-character cycle. This is the assertion that fails today.
2. **The frame is unchanged**: `F = max(P,60) + 4` wire octets, the content octets
   at wire indices 0 … `P−1`, `60 − P` zero pad octets, a terminate character at
   cycle `C + 2 + ⌊F/8⌋` in lane `F mod 8`, no `/E/` anywhere. This already holds
   today and the fix must not cost it.
3. **No regression at `W ≥ 2`**: the post-`tlast` silence that holds today at
   `W = 3` and `W = 8` still holds.
4. **Nothing here licenses suppressing a real underflow.** A fix that silences
   `error_underflow` more broadly than "the window is empty at `W = 1`" would be
   caught by family G, which has not been written yet — so it would be caught
   **late**. `AP-xgmii_tx_64` rows `M04-G1`, `M04-G3`, `M04-G4` and `M04-G5` are
   the standing statement of what must still pulse, and `M04-G5` is the sharp
   neighbour: at `P = 60`, a word withheld at `C+1` — the same *cycle offset* as
   this bug's spurious strobe, on a frame with a second word to require — **is**
   an underflow and **must** pulse, with the `/E/` word two cycles later. The two
   cases are one cycle offset apart and opposite in verdict; that is the whole
   difficulty of this fix and it is why the condition must be keyed on **whether
   the `tlast` word has been accepted**, never on a cycle offset from `C`.

---

## 6. Severity, and the reachability analysis behind it

**MAJOR**, and the honest reasons on both sides:

**Why not CRITICAL.** No octet on the wire is wrong: the frame is complete,
correctly padded and normally terminated (§2). And the defect is **not reachable
through the Phase-1 composed chain today**: M04's source is M07 `Eth_axis_tx`,
which prepends the 14 Ethernet header octets (REQ-405), so the shortest frame
that can reach M04's source interface from the stack above is 14 octets — `W = 2`
— and `W = 1` cannot be produced by any upstream module in Phase 1. The
measurement that would convert this to CRITICAL is a demonstration that `W = 2`
also strobes; `W = 2` is untested (§4) and §8 asks for it.

**Why not MINOR.** SPEC-M04 places **no lower bound** on the source frame length —
§2's not-my-job table records that *nobody* knows a frame's length in advance at
this module, and REQ-203's pad rule is written to reach any `P` below 60, which is
why `AP-xgmii_tx_64` rows `M04-B4`, `M04-C2` and `M04-C5` all name `P = 1` as a
commissioned stimulus. A one-word frame is inside the module's specified domain,
and REQ-008's *"no strobe the stimulus did not create"* is unconditional. The
strobe is not decorative: REQ-804 aggregates it into the host-visible status
record, and REQ-709's co-occurrence bench asserts **one pulse of each** per
under-delivered frame — an assertion a spurious pulse breaks. A module that
reports a transmit error on a legal frame is reporting a fault that did not
happen, which is the failure mode `test/monitors/strobe_monitor.ml` was built to
make impossible to miss.

---

## 7. What this packet does **not** claim

1. **No root cause.** No file under `libs/**`, `top/**` or `rtl_snapshots/**` was
   opened. The Root-cause section is rtl_lead's obligation on the fix return
   (dv_lead charter §8), and dv_lead verifies one exists before writing ACCEPT
   into the Fix verdict field.
2. **No claim about `tx_tready`.** `WO-0080` §5.6 asserts **no value** of
   `tx_tready` anywhere in the round, and no unit in `test/xgmii_tx_64/` contains
   the substring `tready` at all. This packet asserts nothing about its value on
   any cycle, and in particular does **not** discharge `AP-xgmii_tx_64` row
   `M04-G4`, which additionally asserts `tx_tready` = 1 at that cycle
   (`WO-0080` §9.4 item 3 forbids describing the empty strobe set as covering it).
3. **No claim about the FCS at `P = 1`.** The four FCS octets at wire indices
   60 … 63 were **not** compared against the REQ-305 oracle in this run — that
   comparison is `M04-C3`'s and rides at `P = 20` only. §2's "correct frame" claim
   is scoped to wire octets 0 … `F−5`, exactly as far as the passing assertions
   reach.
4. **No coverage claim.** Nine of the thirteen commissioned rows executed green in
   this run; four (`M04-B4`, `M04-B5`, `M04-C2`, `M04-C5`) did not. No row status
   moves in `AP-xgmii_tx_64` on this packet, no `SO-xgmii_tx_64.md` is opened or
   offered, and the PROTOCOL §10 mutation campaign remains sequenced after
   `WO-0080`'s eventual `RV-` ACCEPT and before any `SO-` PASS.
5. **The corrected expect-files this run printed must NOT be promoted.** The
   `PROMOTION BLOCK` at the end of job 93730745511 carries `.corrected` files
   whose new content is `[%expect.unreachable]` plus an
   `[@@expect.uncaught_exn {| … |}]` payload containing this failure's message
   **and its OCaml backtrace**. Promoting them would bake the crash text into the
   expectations and turn the suite green with the defect intact. The standing
   house rule: **a `.corrected` carrying `expect.uncaught_exn` is never a
   promotion candidate; a promotion candidate is printed data, an uncaught
   exception is a verdict.** Verified at `cbbeb76`: zero occurrences of
   `expect.uncaught_exn` or `expect.unreachable` in any of the seven files under
   `test/xgmii_tx_64/`, and the committed sha256 of both touched files differs
   from the runner-local promoted one
   (`test_m04_b.ml` committed `465a8b91…` vs promoted `1178cec5…`;
   `test_m04_c.ml` committed `f127ff13…` vs promoted `10e7d0b6…`).

---

## 8. Re-test protocol — what dv_lead will run on the fix return

At the fix's landing SHA, on CI (`ADR-0005`: a local build is not acceptable
evidence):

```sh
opam exec -- dune build @default
opam exec -- dune runtest
```

and read, from the run's own job log:

1. **The three units of §1 raise nothing**, and their `[%expect {||}]` blocks stay
   empty — i.e. the `PROMOTION BLOCK` contains no `test_m04_b.ml` and no
   `test_m04_c.ml` entry.
2. **The members that were never adjudicated are adjudicated**: with the `P = 1`
   raise gone, the `List.iter` in each unit reaches `P ∈ {20, 59, 60, 61, 64, 67,
   1514}` in U5, `{59, 60, 61}` in U7 and `{20, 59}` in U10, all with clean
   instruments.
3. **The `W = 2` neighbour** (§4): dv_lead adds it as a bench round, not as a
   demand on this fix — but if the fix return states a mechanism whose domain is
   wider than `W = 1`, the re-test is held until that point is driven.
4. **A Root-cause section exists** in rtl_lead's fix journal entry (§7 item 1).

A fix that makes the suite green **by changing anything under `test/**`** is not a
fix and will be returned: DV-line files are outside rtl_lead's write scope
(PROTOCOL §6) and this packet's assertions are derived from the specification, not
from the bench.

---

## Fix verdict

*(empty — appended by dv_lead after re-test, per the `BUG-` template. The fix
return must carry a Root-cause section before the fix description; dv_lead
verifies its presence before writing ACCEPT.)*
