# BUG-0004: M04 pulses `error_underflow` on a frame whose **every** source word was presented and accepted — at the one frame shape where REQ-206's window is provably **empty**, a source frame of one word (`P ≤ 8`, `W = 1`)

- **State**: `OPEN` → **`CLOSED`** at `af06c62` (dv_lead, `J-dv_lead-0176`; the
  Fix verdict is at the end of this file and the token is **`CLOSED`**). dv_lead's
  packet. The orchestrator allocates the packet number and relays it **verbatim**
  (PROTOCOL §3); the `NNNN` in this filename is dv_lead's prediction of the next
  free id (`BUG-0001` … `BUG-0003` exist; `0004` is next) and is the
  orchestrator's to confirm. **Two obligations survive the closure and are named
  in the verdict rather than left with it**: the derived-but-unmeasured routes 2
  and 3 of §9.3, and the `W = 2` residue of §6/§8 — both carried, both with
  carriers named at §10.4.
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

## 9. Root cause and fix — rtl_lead's response

*(appended by rtl_lead at `J-rtl_lead-0018`. Derived from
`libs/hardcaml_ethernet/src/xgmii_tx_64.ml` as it stands at `fcf6f08` and from
`docs/specs/modules/xgmii_tx_64.md` §6.1, §6.2, §7, §9. **No file under
`test/**` was opened** — the three units, `bench.ml`, `strobe_monitor.ml` and
`AP-xgmii_tx_64` are known to me only through this packet's own text, which is
why §9.3 and §9.4 are stated as derivations a bench can be pointed at rather
than as predictions about a bench I have read. The header's **State** and
**severity** fields are dv_lead's live state and I do not touch them; §9.4 hands
§6 its measurement question answered by derivation and takes no position on the
grade.)*

### 9.1 Root cause — the mechanism, and it is not the one a cycle offset would suggest

**One register, and a priority inversion inside its next-value mux.** The
underflow condition at line 350 is §9's, term for term:

```ocaml
let underflow = tready &: ~:(i.tx.tvalid) &: frame_active &: ~:last_accepted in
```

`frame_active` is REQ-206's lower bound (set on the cycle the preamble is
composed, so it is high from the cycle the start character reaches the wire) and
`last_accepted` is its upper bound — *has this frame's `tlast` word been
accepted?* The bound is the right one. **Its encoding was not**:

```ocaml
(* at fcf6f08, the defect *)
last_accepted <== reg spec (mux2 start_now gnd (last_accepted |: (accept &: i.tx.tlast)));
```

Read as a predicate this says "the `tlast` word has been accepted **since the
frame started**", because the frame-boundary clear sits *above* the set term in
the mux and therefore wins whenever the two fire on the same cycle. That is
equivalent to the intended predicate only while the two events are **distinct
cycles**. At `W = 1` they are the same cycle: the frame's first word is its
`tlast` word, and this module starts a frame on the cycle it accepts a first
word (`start_now`, and §6.2's `Preamble` is that same cycle here — the module
doc's phase mapping says so). So `start_now = 1` and `accept & tlast = 1`
together, the clear discards the very acceptance that closes the window, and the
window is left open on a frame that has nothing left to owe.

**The cycle-by-cycle account of the reported failure**, from the design alone,
against §1's stimulus. `C` = 1 because the reset clause holds `tx_tready` = 0
through cycle 0 (`reset_window`), which is §7's reset bullet and is why the word
offered from cycle 0 is accepted on cycle 1:

| cycle | phase | `fill` | `tready` | `tvalid` | `frame_active` | `last_accepted` | `error_underflow` |
|---|---|---|---|---|---|---|---|
| 0 | Idle | 0 | **0** (reset window) | 1 | 0 | 0 | 0 |
| 1 = `C` | Idle | 0 | 1 | 1 → **accept**, `start_now` | 0 | 0 | 0 (`tvalid` = 1) |
| 2 | Body | 1 | 1 (`need_payload`) | 0 | **1** | **0 ← the acceptance at `C` was discarded** | **1** |

At cycle 2 the composer holds the whole frame and needs nothing, but `tready` is
1 because `need_payload` is still true (the end is recorded by *this* cycle's
consumption, not before it), `tvalid` is 0 because the source has nothing left to
present, and the two bounds both read "inside the window". The strobe is
`observed: error_underflow@2` exactly.

**Why `W = 3` and `W = 8` are clean, which is the same fact from the other
side.** At `W ≥ 2` the first word carries `tlast` = 0, so `accept & tlast` fires
on a later cycle than `start_now` and the clear has nothing to destroy: at
`W = 3` the `tlast` word is accepted at `C+2` and `last_accepted` is high from
`C+3`, which is the cycle §7's C-16 bullet describes; at `W = 8`, `C+7` and
`C+8`. §4's selectivity is therefore explained without residue — **the design
is not reading REQ-206 to its first full stop** (that would have strobed at
`P = 60` too), it is failing on exactly the shape where the window's two bounds
are set by one event.

**Why review and smoke sims did not catch it, stated because the charter asks
for it and not as mitigation.** The predicate was written down correctly in prose
at authoring time — `J-rtl_lead-0002` says, of C-16, "*C+8 carries no obligation
(the underflow window closed when the `tlast` word was accepted)*" — and then
encoded as a clear-then-accumulate register, a shape whose narrowing is invisible
unless the two events are instantiated on one cycle. Every worked instance I
reasoned against was a frame where they are not: §6.1's cycle table is `P = 60`,
§7's C-16 bullet illustrates at `C+8`, and §9's strobe pin is stated against a
frame with a word still owed. I read the C-16 clause through the number it is
illustrated with rather than through the predicate it is stated over — which is
the same reading error §3 of this packet identifies and answers, arrived at
independently from the design side. There were no smoke sims: ADR-0005's
container has zero hardcaml packages, so this module had never been compiled,
elaborated or simulated by anything until CI run 31476319884, and the first
execution of a bench against it is exactly when this had to surface.

### 9.2 The fix — one expression, no new register, `error_underflow` the only cone touched

```ocaml
let start_word_is_last = ~:empty &: held_last in
last_accepted
<== reg
      spec
      (mux2 start_now start_word_is_last last_accepted |: (accept &: i.tx.tlast));
```

Two changes to one next-value expression, and they are the same change said
twice: **the set term moves outside the frame-boundary clear** (clear the
history, then record this cycle's acceptance — rather than clear the whole
expression), and **the clear is replaced by a seed taken from what the module is
already holding**. The register keeps asking exactly the question REQ-206's upper
bound asks, and now three ways of having accepted a `tlast` word all register
rather than one:

1. **on the start cycle itself** — `empty`, the word taken now (`accept & tlast`
   after the seed). This is the reported `W = 1` frame from idle;
2. **before the start cycle** — `~empty` with `held_last`, the frame's first word
   already in the holding structure. This is §7 case 2's early-acceptance cycle
   (C-16) followed by §6.2's `Idle` row starting the frame from the held word.
   §9.3 shows this is a second reachable route to the same defect;
3. **after the start cycle** — the accumulate term, unchanged, which is every
   `W ≥ 2` frame including all three of §4's clean brackets.

**The change is provably a suppression only where the window is provably
empty**, which is §5 item 4's demand. `start_now` = 0 ⇒ both forms are
`last_accepted | (accept & tlast)`, bit for bit. `start_now` = 1 ⇒ old = 0, new =
`(~empty & held_last) | (accept & tlast)`. So the *only* cycles on which the two
designs differ are start cycles at which the starting frame's `tlast` word is
**already in this module's hands** — the exact condition REQ-206's upper bound
names. It cannot silence a frame with a word still to come: such a frame's first
word has `tlast` = 0 and nothing is held behind it, so the seed is 0 and the
register behaves as it did. `M04-G5` — `P = 60`, a word withheld at `C+1` — is
untouched by inspection: at its `C` the seed is `~empty` = 0 and `accept & tlast`
= 0, so `last_accepted` = 0 at `C+1` and the strobe pulses there as the row
requires, with the `/E/` word two cycles later. That is the one-cycle-offset
neighbour §5 names, and the fix keys on the `tlast` acceptance, never on an
offset from `C`.

**`~:empty` is load-bearing, not defensive.** The `hold` registers keep their
last value on a pop, so `held_last` is stale whenever `fill` = 0.

**That the held word at a start cycle is always the starting frame's own first
word** is what makes route 2 sound, and it holds for the module's reasons rather
than by assumption: `tx_tready` is asserted only when `(can_start &
cfg_tx_enable)` or `(in_body & need_payload)`; in `Body` every accepted word is
consumed before the frame ends except one accepted on the last `need_payload`
cycle, which is §7 case 2's cycle and which case 2 itself names *the next frame's
first word*; on a `can_start` cycle an acceptance always coincides with
`start_now`, because `word_available` includes `accept`; and on the abort path
`starved` requires the structure empty and `tx_tready` is 0 while starved, so
nothing is carried into an aborted frame's gap. `clear` empties `fill` outright.

### 9.3 A second and a third route to the same defect, which the reported stimulus cannot reach — stated because §8 item 3 asks whether the mechanism's domain is wider than `W = 1`

**It is wider than the reported stimulus and it is not wider than the defect.**
The mechanism is "the frame's `tlast` word was accepted at or before the cycle
the frame started", and §1's stimulus reaches only its first route because it
runs one frame out of reset. Two more routes exist in the specified domain, both
requiring a **preceding frame** so that §7 case 2's early acceptance at `C+8` has
somewhere to come from. Derived, not measured — I have run nothing:

- **Route 2 — `W = 1`, pre-accepted.** Frame A (`P` = 60) is accepted at
  `C … C+7`; at `C+8` the source presents a one-word frame B, which M04 accepts
  into the slot A's word vacates (§7 case 2). `term_here` at `C+9`, gap served,
  and at `C+11` the gap's last cycle starts B from the held word with no
  acceptance of its own (`word_available` = `~empty`). At `fcf6f08` the clear
  fires and `last_accepted` = 0; at `C+12`, B's first `Body` cycle, `tready` = 1,
  `tvalid` = 0 and **`error_underflow` pulses** — the same defect, one frame
  later, reached without ever satisfying `start_now & accept & tlast`. The fix's
  seed is `~empty & held_last` = 1 there and it is silent.
- **Route 3 — `W = 2`, fully pre-loaded, and this one is a `W = 2` strobe.**
  Same frame A; B's word 0 accepted at `C+8`, B's word 1 (`tlast`) accepted at
  `C+11`, which is precisely the pairing §7 case 4 describes and licenses
  ("*if a word was accepted at C+8, the word accepted at C+11 is that frame's
  second word*"). At `fcf6f08` the clear discards the `C+11` acceptance;
  `tx_tready` is 0 at `C+12` because both slots are full (§7 case 4's own
  consequence), and the spurious strobe lands one cycle later, at `C+13`, when
  the second slot drains and `need_payload` is still high. Post-fix the seed
  path takes `accept & tlast` at `C+11` and it is silent.

**What this does and does not do to §6.** It does **not** overturn §6's
reachability finding, and it changes the reason: §6 argued the composed chain is
safe because M07 prepends 14 octets so `W = 1` cannot be produced upstream, and
that argument stands for route 1. Route 3 is a `W = 2` strobe, so the
`W ≥ 2`-therefore-safe half of that argument does not by itself close the
question — what closes it is SPEC-M04 §7's own note that **in the composed chain
M07 presents nothing at `C+8`** (its output word 0 leaves at `C+9` and is
accepted at `C+11`), so the early acceptance routes 2 and 3 both depend on is not
produced by M07 at all and is "*reached only by a bench driving M04 directly from
a continuous source*". Both routes therefore need a direct-drive back-to-back
bench, which is REQ-209's sustained run (§8 of the spec) — and REQ-209's frames
are minimum-length, `W = 8`, so that bench does not reach them either. **I am
reporting this to §6, not grading it**: whether a derived `W = 2` strobe on a
shape no committed bench drives is a severity conversion is dv_lead's to decide,
and §V.2 of BUG-0003 is the standing precedent that a derivation is not a class
DV records a severity on.

### 9.4 `W = 2` — §4's nearest untested neighbour and §6's conversion question, answered by derivation

**On the stimulus shape §1 describes — one elaboration out of reset, each word
re-offered until accepted, nothing after — `W = 2` (`P` = 9 … 16) is CLEAN at
`fcf6f08` and is BIT-IDENTICAL after the fix.** The derivation, with `C` = 1 as
in §9.1:

| cycle | `fill` | `tready` | `tvalid` | `last_accepted` at `fcf6f08` | `last_accepted` post-fix | `error_underflow` |
|---|---|---|---|---|---|---|
| 1 = `C` | 0 | 1 | 1 → accept word 0 (`tlast` = 0), `start_now` | 0 | 0 (seed `~empty` = 0, `accept & tlast` = 0) | 0 |
| 2 | 1 | 1 | 1 → accept word 1 (`tlast` = 1) | 0 | 0 | 0 (`tvalid` = 1) |
| 3 | 1 | 1 | **0** | **1** (set at cycle 2) | **1** | **0** |
| ≥ 4 | 0 | 0 (`need_payload` = 0, end recorded) | 0 | 1 | 1 | 0 |

Cycle 3 is §7's C-16 cycle for this frame — `tx_tready` = 1 with `tx_tvalid` = 0
meaning nothing at all — and both designs suppress it through the same set term,
because at `W ≥ 2` the acceptance and the start are different cycles. **So the
measurement §6 names as the CRITICAL converter will not be obtained on that
stimulus shape**, and the fix does not move it either way, which is the property
§8 item 3 needs before it releases the re-test: *on the reset-and-present shape
the fix's behaviour at `W = 2` is the identity.* If dv_lead wants the `W = 2`
point to bite, §9.3 route 3 is the shape that does it, and it needs a preceding
frame handing over at `C+8` — a direct-drive back-to-back stimulus, not a
lengthened single frame.

Two further brackets, same derivation, offered so the re-test can be read
without re-deriving them: `W ∈ {4,5,6,7}` behave as `W = 3` and `W = 8` do (first
word `tlast` = 0, acceptance and start on different cycles) and are unaffected by
the change in both designs; and `P ∈ {59, 61, 64, 67, 1514}`, the members §4
records as driven but never adjudicated, are all `W ≥ 8` and sit in the same
class.

### 9.5 What does not move, and the one thing that does

**The wire path is untouched, structurally rather than by argument.**
`last_accepted` feeds exactly one expression in the module — `underflow` — and
nothing else reads it (`grep -n 'last_accepted'` is four sites: its declaration,
its use in `underflow`, its own next-value, and the new seed binding). It reaches
neither `tx_dest.tready` nor `xgmii_txd`/`xgmii_txc`, so §5 item 2 holds by
construction: `F = max(P,60) + 4` wire octets, the pad, the terminate character's
cycle and lane, and the absence of `/E/` are all bit-identical to the run this
packet was written from, and §5 item 3's post-`tlast` silence at `W ≥ 2` is
untouched for the reason §9.2 gives.

**`rtl_snapshots/**` goes stale at this commit and is deliberately not
regenerated here.** The emitted netlist *does* change — `bin/generate.ml` builds
`rtl_snapshots/xgmii_tx_64.v` from `Xgmii_tx_64.create`, and
`rtl_snapshots/eth_mac_10g.v` contains the same `xgmii_tx_64` module body at line
2852 — so **both files are stale until the emitter arc promotes them**, which is
the arc `J-rtl_lead-0016`/`J-rtl_lead-0017` established: CI's *Verify nothing was
left unpromoted or non-deterministic* step reddens and its `PROMOTION BLOCK`
carries the two new `.v` files as sha256 + base64. **This does not contaminate
the re-test**: `Run tests` executes *before* `Generate RTL` in `build.yml`, so
§8's items 1 and 2 are read from the same run at their own step, and the job's
red at the later step is scheduled rather than a second defect. The prediction,
stated before the run so it can convict itself: **no register is added and no
`always` block appears or disappears** — the delta in the error_underflow cone is
one added AND term and the OR moving outside the mux — and the same delta
appears twice, once per file.

### 9.6 What I do not claim

1. **Nothing CI has not run.** This module has still never been compiled,
   type-checked, elaborated, simulated or emitted in this container: the `fpga`
   switch carries zero hardcaml packages (ADR-0005). The edit is parse-checked
   only — `ocamlc -stop-after parsing`, with negative controls, recorded in
   `J-rtl_lead-0018` — which sees syntax and nothing else: not a width mismatch,
   not a wrong field name, not a `Signal` operator that does not exist. **The
   first real verdict on this fix is dv_lead's re-test at §8.**
2. **No test file was read or written.** §8's closing rule is respected: nothing
   under `test/**` is in this commit, and the three failing units are known to me
   only through this packet.
3. **The tables in §9.1, §9.3 and §9.4 are derivations from the design source and
   the specification, not observations.** Every one of them is falsifiable by
   dv_lead's re-run, which is the point of writing them down before it.
4. **No row of `AP-xgmii_tx_64` moves, no `SO-` is offered, and the packet's
   State and severity stay where dv_lead put them.** PROTOCOL §10's mutation
   campaign remains sequenced after `WO-0080`'s eventual `RV-` ACCEPT.

---

## Fix verdict

**`CLOSED`.**

*(dv_lead, 2026-08-11, at `af06c623e4ea1ace45b2763d8c511649dedd338e`. Journal
`J-dv_lead-0176`. One token, per this packet's own grammar — §8's re-test
protocol executed item by item below, against the runs rather than against the
fix return's account of them.)*

---

### 10.1 §8's four items, each executed

| §8 item | Verdict | Evidence, read at the source |
|---|---|---|
| **1 — the three units of §1 raise nothing, and their `[%expect {\|\|}]` blocks stay empty** | **MET** | CI `build` run **31482795659** at `af06c62`, job `build` id **93751338432**, `run_attempt` **1**, conclusion `success`. Steps read **by name and status**: **"Build" = `success`**, **"Run tests (expect tests, waveform snapshots)" = `success`**, **"Verify nothing was left unpromoted or non-deterministic" = `success`**, plus "Generate RTL", "DV mechanical checks" and the abort-bit quantifier all `success`. Job `cosim` id **93751338523**: all steps `success`. A green `Run tests` is what §1's raise made impossible at `cbbeb76`; a green *determinism* step is the stronger half — it is the step that would print a `PROMOTION BLOCK` for any `.corrected` file, so its silence is the direct measurement of "no `test_m04_b.ml` and no `test_m04_c.ml` entry". Re-checked in the tree at `af06c62`: **ten** empty `[%expect]` blocks under `test/xgmii_tx_64/`, **zero** occurrences of `expect.uncaught_exn` or `expect.unreachable` in any of the seven files |
| **2 — the never-adjudicated members are adjudicated** | **MET** | `dune runtest` exits 0 only if every `%expect_test` unit runs to completion with empty output, so each `List.iter` reached its last member. The members §4 recorded as *driven but never adjudicated* — `P ∈ {20, 59, 60, 61, 64, 67, 1514}` in U5, `{59, 60, 61}` in U7, `{20, 59}` in U10 — are now **driven and read**. This is the single largest evidentiary movement of the fix round and it is not a claim about the fix: it is what a green suite means |
| **3 — the `W = 2` neighbour** | **DISPOSED at §10.2**, and the re-test is **not** held on it | §9.3/§9.4 do state a mechanism wider than `W = 1`. §8 item 3's condition — *"if the fix return states a mechanism whose domain is wider than `W = 1`, the re-test is held until that point is driven"* — is answered rather than waived: the wider domain's `W = 2` member (route 3) is **unreachable by every committed bench**, so holding the re-test would hold it on a measurement no scheduled round can produce. §10.2 states the disposition and §10.4 names the carrier |
| **4 — a Root-cause section exists in rtl_lead's fix journal entry** | **MET** | `J-rtl_lead-0018` carries `#### Root cause` inside its Reasoning, before the fix description, and §9.1 of this packet is its packet-side statement. Verified as present, per §7 item 1 and dv_lead charter §8 — dv_lead verifies a Root-cause section **exists**; adjudicating its correctness against the design is not this seat's act |

**The one fact that makes this a measurement of the fix and not of a coincidence.**
`git diff cbbeb76 af06c62 -- test/` is **empty**. The seven files under
`test/xgmii_tx_64/` are **byte-identical** between the SHA at which three units
raised and the SHA at which none does. Nothing in the bench moved; the design did.
The red and the green are the same instrument reading two designs.

**Scope of the fix, measured rather than accepted.** `git diff --name-only
fcf6f08 02f762a` returns exactly three paths — this packet, `rtl_lead`'s journal,
and `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`. **`git diff --name-only fcf6f08
02f762a -- test/` is empty**, so §8's closing rule (*"a fix that makes the suite
green by changing anything under `test/**` is not a fix"*) is satisfied by
measurement and not by assurance. `git diff --stat 02f762a af06c62 -- libs/ bin/`
is empty: the promotion commit changed no source.

**§5's four observables.** Item 1 (`error_underflow` = 0 on every cycle of a
one-source-word frame, any `P` in 1 … 8): met at `P = 1` in three independent unit
bodies, by the standing strobe monitor that convicted the design. Item 2 (the
frame is unchanged): met, and now **by measurement rather than by the structural
argument §9.5 offers** — every wire assertion in all thirteen rows passes at the
full directed length set, which is a stronger statement than "`last_accepted`
feeds only `underflow`". Item 3 (no regression at `W ≥ 2`): met at every `W` the
round drives — 1, 2 (`P` = 9…16 is not in the set, see §10.2), 3, 8 and every
`W ≥ 8` member of `M04-B4`'s directed set. Item 4 (nothing licenses suppressing a
real underflow): **not measured, and it cannot be** — family G is unwritten, so
`M04-G5`, the one-cycle-offset neighbour with the opposite verdict, is still
carried by §9.2's derivation alone. §10.3 routes it.

**Independence note, stated because it is a departure.** This packet was written
without opening any file under `libs/**` (§0's independence clause, honoured).
The verdict above is **post-verdict**: `git diff fcf6f08..02f762a -- libs/` was
read at this seat, for the single purpose of establishing the fix's **scope** —
that one expression moved, that no `test/**` file did, and that the promotion
commit changed no source. No expectation in this packet was derived from it, and
none was revised after it. Journalled explicitly at `J-dv_lead-0176` per dv_lead
charter §8's independence discipline.

---

### 10.2 (a) The `W = 2` disposition — §6/§8's condition is **DISCHARGED**, on a ground it was not written on, and it leaves a **named residue**

**What §6 asked.** *"The measurement that would convert this to CRITICAL is a
demonstration that `W = 2` also strobes."* The question was asked because M07
prepends 14 header octets (REQ-405), so `W = 1` is unreachable through the
Phase-1 composed chain and `W = 2` is the shortest shape that is reachable.

**What §9.3/§9.4 answer, taken apart into its two halves.**

1. **On the round's stimulus shape — one elaboration out of reset, each word
   re-offered until accepted, nothing after — `W = 2` is clean at `fcf6f08` and
   bit-identical after the fix.** So **no measurement on that shape can convert
   the grade**, in either direction, and §8 item 3's held point would have been
   held on a stimulus that cannot answer the question. §9.4's table gives the
   reason and it is the same one §4's selectivity gives: at `W ≥ 2` the frame's
   first word carries `tlast` = 0, so the frame-opening acceptance and the
   `tlast` acceptance are **different cycles** and the priority inversion has
   nothing to destroy.
2. **A `W = 2` strobe nevertheless exists in the unfixed design** — §9.3's route
   3, the fully pre-loaded back-to-back handover, spurious strobe at `C+13`. So
   the literal answer to *"does `W = 2` strobe?"* is **yes, on one shape**, and
   read literally that points at CRITICAL.

**Why it does not convert, and the ground is not the one §6 wrote.** §6's
argument was *`W ≥ 2` is what the chain can produce, therefore the chain is
safe*. Route 3 breaks that argument's minor premise: `W = 2` is not by itself
safe. What survives is **SPEC-M04 §7's own note** that in the composed chain M07
presents nothing at `C+8` — its output word 0 leaves at `C+9` and is accepted at
`C+11` — so the early acceptance that routes 2 and 3 both require **is not
produced by M07 at all**, and both are *"reached only by a bench driving M04
directly from a continuous source"*. **The conclusion stands; its ground has been
replaced, and this packet says so rather than letting a later reader re-derive
the protection from the wrong premise.** A conclusion that outlives the reason it
was given for is exactly the shape that rots silently.

**Severity therefore stays MAJOR and is not converted.** The grade is now
historical — the defect is fixed — but the ground is not, because it is the same
ground the *residue* below rests on.

**The residue, and it is real.** Route 3 is a **derivation**, not a measurement,
and so is the fix's silence on it. My own standing precedent — `BUG-0003` §V.2,
which §9.3 correctly cites back at me — is that *a derivation is not a class DV
records a severity on*. **The symmetric half binds this seat and I apply it
against myself: a derivation is not a class DV records a clearance on either.**
So the closure above is closure **on route 1**, which is measured end to end (red
at `cbbeb76`, green at `af06c62`, bench byte-identical). It is **not** closure on
routes 2 and 3, and this packet's `CLOSED` does not claim them. §10.4 carries
them.

**One correction to §6's own text, recorded rather than edited in place.** §6
reads *"`W = 1` cannot be produced by any upstream module in Phase 1"* and
concludes the defect is not reachable through the composed chain. That remains
true. The sentence immediately after it — *"the measurement that would convert
this to CRITICAL is a demonstration that `W = 2` also strobes"* — is **too wide**
as a conversion rule, because it makes the grade turn on a word count when the
mechanism turns on a handover. The rule it should have stated: *the conversion
question is whether the composed chain can present a frame whose `tlast` word is
in this module's hands at or before the cycle the frame starts.* The answer is no,
for §7's reason. Filed as **`FINDING BUG-0004-1` (MINOR, mine)** against this
packet's own §6.

---

### 10.3 (b) The two further routes — **CARRIED OBLIGATION plus AP row debt**, not discharged and not a future family's to inherit by silence

§9.3 derives two routes to the same defect that §1's stimulus cannot reach, both
**fixed by the same edit BY DERIVATION** and **neither ever measured**:

- **Route 2** — `W = 1`, pre-accepted at §7 case 2's `C+8`, started from the held
  word at `C+11`, spurious strobe at `C+12` in the unfixed design;
- **Route 3** — `W = 2`, fully pre-loaded, `tlast` accepted at `C+11`, spurious
  strobe at `C+13` in the unfixed design.

**Routed three ways, and the split is deliberate.**

1. **NOT AP rows today.** No committed row of `AP-xgmii_tx_64` names either
   shape, and this round is not commissioned to author rows. They become **plan
   row debt**: two new family-G rows — the `W = 1` collapse row already owed at
   `J-dv_lead-0175` Open-question 2, now joined by a **pre-loaded-handover** row
   covering routes 2 and 3, with `M04-G5` named as the opposite-verdict
   neighbour on both. **The `AP-M04` repair debt moves from EIGHT to NINE**, all
   riding the round commissioned to repair the plan (see §10.5's carrier note —
   the carrier needed re-pinning and this round re-pins it).
2. **NOT a future family's inheritance.** Family G is the underflow family and
   would be the natural home, but family G's own rows assert what **must** pulse;
   routes 2 and 3 assert what must **not**, on a stimulus shape (back-to-back
   direct drive with a handover at `C+8`) that neither family G nor REQ-209's
   sustained run produces — REQ-209's frames are minimum-length, `W = 8`. Writing
   them into family G without the capability would be a row that cannot be
   mounted, which is what the `GAP` status exists to say and is not what these
   are. **They need a capability that does not exist**: a direct-drive
   continuous-source bench with a controllable handover cycle.
3. **A hard precondition on the eventual `SO-`.** Stated here so it cannot be
   lost when this packet closes: **`SO-xgmii_tx_64.md` may not report REQ-206
   coverage without either (i) routes 2 and 3 measured on a direct-drive
   back-to-back bench, or (ii) both recorded in the `SO-` as an explicit declared
   gap with this packet's id.** A defect that was fixed by derivation and never
   measured is precisely the class that a sign-off absorbs by silence. dv_lead
   charter §5's DoD already forbids coverage claimed by silence; this is that
   rule instantiated at the one place it is about to be tested.

---

### 10.4 The carriers, named, because a closed packet cannot carry anything itself

| Obligation | Carrier | Trip condition |
|---|---|---|
| Routes 2 and 3 measured, or declared as a gap | **dv_lead** — the round that first opens a direct-drive back-to-back bench at M04 (**not** family D, which drives no handover; the capability is family H/L-shaped) | `SO-xgmii_tx_64.md` may not be issued with REQ-206 coverage claimed and this box unticked (§10.3 item 3) |
| The `W = 2` residue — §6's conversion rule restated over the handover rather than over a word count (`FINDING BUG-0004-1`) | **dv_lead**, with the plan-repair round | the restatement rides the same round as the two new rows |
| Two new family-G rows (`W = 1` collapse; pre-loaded handover) | **dv_lead** — the round commissioned to repair `AP-xgmii_tx_64` | debt count **NINE**; a plan round that pays eight and not nine has missed this packet |
| `M04-G5`, the opposite-verdict neighbour §5 item 4 names — still carried by derivation alone | **dv_lead**, family G's bench round | no `SO-` may report §5 item 4 as met before it |

---

### 10.5 (c) rtl_lead's non-claims — noted, and one of them is measured here

§9.6 and `J-rtl_lead-0019`'s Open-questions state four things rtl_lead does not
claim. Each is dispositioned rather than left to be read as settled:

1. **`J-rtl_lead-0019` Open-question 2 — *"REQ-902's two-run byte identity has
   still never been observed on the M04 path"*. SUPERSEDED, by one datapoint,
   measured here.** §5 of that entry pre-committed the reading before the run
   existed: *"if the determinism step now goes green at the commit carrying this
   entry, that is M04's first determinism datapoint."* **It went green.** Run
   **31482795659**, step 8, `success`, at `af06c62`. The two generations compared
   are run **31479688462**'s — whose `PROMOTION BLOCK` produced the committed
   bytes — and run **31482795659**'s, which regenerated and found no diff; two
   runs, two runners, and `git diff --stat 02f762a af06c62 -- libs/ bin/` empty,
   so the source-change proviso that entry made load-bearing is satisfied. The
   committed digests are `27cb8ebe…ee85` (`rtl_snapshots/xgmii_tx_64.v`) and
   `6735d092…02ac` (`rtl_snapshots/eth_mac_10g.v`), matching the shas that entry
   named in advance. **Stated as one datapoint and NOT as REQ-902 discharged**:
   `.github/workflows/build.yml`'s determinism step generates **once** and
   compares against the committed tree, so what is proven is cross-run identity
   between two commits, not a double-generation check within one run. **Routed to
   rtl_lead** — REQ-902 is its requirement and its ledger; this is DV handing it a
   measurement, not DV taking the row.
2. **`J-rtl_lead-0019` Open-question 3 — the `Run tests` verdict relayed, not
   verified there.** Correct, and §10.1 is that verification. Discharged.
3. **§9.6 item 1 — *"nothing CI has not run … the edit is parse-checked only"*.**
   Discharged: the module is now compiled, elaborated and simulated at `02f762a`
   and again at `af06c62`.
4. **`J-rtl_lead-0019` Open-question 4 — M04 has had no independent design
   review.** **Noted and NOT discharged, and it is not DV's to discharge.** A
   green DV suite is not a design review and this packet does not offer itself as
   one: thirteen of eighty rows have run, family G is unwritten, and `BAR T1`
   records the differential anchor at this boundary as **SHUT**. Carried as
   rtl_lead's.

**Carrier hygiene, recorded because this round found the failure mode.** The
`AP-M04` repair debt's carrier has read *"the round that next opens
`test/attack_plans/**`"* since `J-dv_lead-0174`. This round opens that file — for
a change-log append and nothing else — which would let a carrier phrased over a
**path** read as satisfied by a round that never looked at the debt. **The carrier
is re-pinned to the round commissioned to repair the plan**, and the debt is
restated at nine so that a later reader counts it rather than infers it.

---

### 10.6 What this verdict does **not** claim

1. **No `SO-`.** None is opened, offered or implied. Thirteen green rows are
   thirteen green rows.
2. **No claim about `tx_tready`'s value** anywhere, on any cycle — `WO-0080` §5.6
   asserts none and no unit under `test/xgmii_tx_64/` contains the substring
   `tready` at all. `M04-G4` is **not** discharged and is not described as
   discharged.
3. **No claim that a real underflow still pulses.** §5 item 4 is carried by
   derivation only (§10.4).
4. **No adjudication of the emitted netlist.** `rtl_snapshots/**` is rtl_lead's;
   the promotion's faithfulness is established by the determinism step, not by
   this seat reading Verilog. `J-rtl_lead-0019`'s own correction of `J-rtl_lead-0018`
   §9.5's *"one added AND term"* to two nets is rtl_lead's record and is noted, not
   graded.
5. **No claim of coverage for REQ-206.** The strobe that convicted the design was
   read by a **standing** instrument on stimuli commissioned for the pad boundary;
   that is evidence about instrument placement, not about REQ-206 coverage.
