# WO-0063A: M03-I2's third member — the zero-received-`/T/` frame, its own boundary, and the three stale citations that ride with it

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it and
  allocates its id (PROTOCOL §3); **`0063A` is a placeholder**, not a claim of
  allocation. It is the **phase-A execution packet** of the round whose planning
  packet is `WO-0063`.
- **From** / **To**: dv_lead → **tb_writer**, via the orchestrator.
- **Spec basis**: `docs/specs/requirements.md` **REQ-109**, **REQ-107**, **§0.6**
  (the strobe window and C-23's counting), **§0.7**, §12;
  `docs/specs/modules/xgmii_rx_64.md` **§6.1**'s drain derivation (**C-14.3**),
  **§9** (the closure list, the no-output-word pin, ruling 9).
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` §4.I, row **M03-I2**, as
  amended in the commit that issues this packet (`J-dv_lead-0102`). **Read the
  amended row in full before writing a line** — it is the contract, this packet
  is its execution instructions, and where the two differ **the plan wins and you
  report the difference**.
- **Independence (PROTOCOL §10)**: do **not** open
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, any other `libs/**` path, or
  `rtl_snapshots/**`. Your journal `Inputs` section is the standing evidence that
  you did not. Every number in this packet is derived from the specification and
  from `test/**`; if one is wrong, it is wrong for a reason you can find in those
  two places.

---

## 0. What this round is, in one paragraph

`AP-xgmii_rx_64.md` row **M03-I2** asserts that a conformant M03 emits nothing —
no word, no strobe — from three cycles after a frame's closing word onward
(§6.1's drain derivation, ledger **C-14.3**). The row has two committed members,
both **clean frames**, and a clean frame owes no strobe. So half of the row's own
observable has never had anything to speak about. **This round gives it the
missing stimulus**: a frame closed by its own `/T/` with **zero** octets received,
which owes exactly one `error_runt` and no output word at all. The stimulus
already exists in this bench — it is `test_m03_f.ml`'s `run_f2` at `k = 0` — so
**no new machinery is built, no new capability is added, and no new row or unit
is created**. What is new is one runner and one member inside the existing
`M03-I2` unit.

---

## 1. The artefact — exactly one, and its shape is fixed

**Add member (iii) to M03-I2**, in `test/xgmii_rx_64/test_m03_i.ml`:

1. a **new runner beside `run_i2_member`** (not a new argument threaded through
   it — §4 says why), driving the member at **both** start lanes;
2. two calls to it from **`run_i2`**, lane 0 and lane 4;
3. the existing **`%expect_test` for M03-I2 gains member (iii) in its title**
   and nothing else — **no new `%expect_test`**, so the unit inventory
   (`tools/dv_checks.sh` → `39 test/xgmii_rx_64/`) and the plan's row count are
   unchanged;
4. the `[%expect {||}]` block **stays empty** — this member asserts, it does not
   print.

**Naming.** The runner's name must describe **the obligation or the stimulus
class**, not its position in a list. `run_i2_zero_octet_member` is acceptable;
`run_i2_member2`, `run_i2_member_b` and `run_i2_member_iii` are not — a name that
encodes an ordinal tells the next reader nothing about when the helper applies.
(This is the second half of the naming defect recorded at `J-dv_lead-0100`, and
it is a review bar, not a preference.)

---

## 2. The stimulus, term by term

It is `run_f2`'s `k = 0` case. Build it the same way, from the same catalogue:

```
let base = directed_frame_octets ~length:64 in
let case =
  Dv_xgmii.Injection.corrupt
    base
    [ Dv_xgmii.Injection.Place
        { placement = Dv_xgmii.Injection.At_octet 0
        ; character  = Dv_xgmii.Xgmii_word.terminate_char
        } ]
in
let inj   = Dv_xgmii.Injection.create ~first_lane:lane [ case ] in
let sched = Dv_xgmii.Injection.schedule inj in
```

- `Injection.is_clean inj` is checked **before** anything is driven, and its
  `errors` are reported in the failure message. A construction error that is not
  read is a green test.
- The run is `run bench sched ~drain:8 ~word_at:(fun ~cycle ->
  Dv_xgmii.Injection.word_at inj ~cycle) ()`. **The `~word_at` argument is not
  optional here**: without it the driven stream is the un-injected schedule and
  the whole member is vacuous.
- Both start lanes: `~first_lane:0` and `~first_lane:4`.
- **No `dune` change is expected.** `dv_xgmii` is already a dependency of this
  directory and `test_m03_f.ml` already uses `Injection` from it. If you find you
  need a `dune` edit, **stop and report it** — it means the approach has drifted
  from "no new machinery". Likewise the `dune` header's per-packet row list gains
  **no line**, because this packet adds **no row**; say so in your Return log
  rather than leaving a reader to wonder whether it was forgotten.

---

## 3. The derivation — to be CHECKED, not taken

`run_i2_member`'s existing contract is *"a derivation to check, not an
instruction"* (`WO-0059` §4 item 3): the packet's hand-derived numbers arrive as
guard parameters and the runner **fails loudly** if its own computation from
`Arrival` / `Injection` disagrees. **Member (iii) keeps that contract.** Pass the
numbers below in as `~expected_…` parameters and guard each one.

`At_octet k` lands the injected character at `start_ot + 8 + k`
(`test/xgmii/injection.ml`'s own placement-to-octet-time map; `run_f2:396` states
it). With `k = 0`:

| | lane 0 | lane 4 |
|---|---|---|
| `start_ot` | 8 | 12 |
| closing `/T/` octet time | **16** | **20** |
| closing word **W** | cycle **2** (lane 0 of it) | cycle **2** (lane 4 of it) |
| §9 no-output-word pin (`W + 2`) | **4** | **4** |
| §0.6 window `[W, W + 3]` (§0.7: zero received octets, so the window is measured from the **closing** word) | **[2, 5]** | **[2, 5]** |
| **C-14.3 boundary (`W + 3`)** — the member's own | **5** | **5** |
| conformant margin (pin → boundary) | **one cycle** | **one cycle** |
| output words | **0** | **0** |

**These eight numbers are a claim of mine and they are yours to falsify.** If any
one of them disagrees with what `Injection` and `Arrival` compute at HEAD, the
guard fires and **you report the disagreement — you do not adjust the guard to
match the code, and you do not adjust the code to match the guard.** A guard
edited until it passes is the only way this round can fail invisibly.

Note what is unusual and worth stating in a comment: **this is the first member
of M03-I2 whose boundary is the same number at both start lanes.** Members (i)
and (ii) differ across lanes (13 / 13 / 13 / 14), which is why the row carries a
per-member, per-lane derivation at all. Here lane 4's four extra `start_ot` octet
times land the `/T/` in lane 4 of the *same* cycle rather than in the next one.
Derive it; do not copy it because this packet said so.

---

## 4. THE TRAP — the one thing that would make this member silently vacuous

`run_i2_member` computes its boundary as:

```
let terminate_ot = Dv_xgmii.Arrival.terminate_octet_time frame in
let terminate_cycle = terminate_ot / 8 in
let boundary = terminate_cycle + 3 in
```

`Arrival.terminate_octet_time` is the frame's **declared** terminate. For this
stimulus that is the **auto-placed** `/T/` at octet time **80 — cycle 10** — and
**not** the injected closing character at cycle 2. A member that inherits that
field asserts silence **from cycle 13 onward**, and the entire event under test
lives at cycles 2–5, **eight cycles earlier**. The member would be green against
anything.

**Three consequences, all binding:**

1. **Member (iii) derives its boundary from the closing character's own octet
   time** — `closing_ot = start_ot + 8 + 0`, `boundary = closing_ot / 8 + 3` —
   exactly as `run_f2:404-405` derives `closing_cycle`.
2. **It gets its own runner.** Threading a `~boundary_override` through
   `run_i2_member` would leave the committed members one keystroke away from the
   wrong field and would make the trap invisible at the call site. Two runners,
   each with one boundary rule.
3. **The trap is encoded as an executable guard, not only as a comment.** Before
   the run, assert that the boundary is **not** the declared-terminate one:

   ```
   let declared_boundary = (Dv_xgmii.Arrival.terminate_octet_time frame / 8) + 3 in
   if boundary = declared_boundary then fail row "test bug -- ...";
   ```

   with a message that names both numbers and says why the assertion below would
   be vacuous. It passes today (5 ≠ 13). It exists so that a later refactor that
   re-points this member at `Arrival.terminate_octet_time` **fails instead of
   passing quietly**.

---

## 5. What member (iii) asserts, in this order, and what it must not

**In order.** The order is part of the specification of this member, not a
stylistic choice: which instrument speaks first decides what a red unit reports.

1. **Construction.** `Injection.is_clean`, errors reported.
2. **Landing, at both sites** — the two sites `run_f2` established at
   `WO-0047` §6 item 7 and which this member reproduces:
   **site 1**, on the *schedule*, before a cycle is driven
   (`Injection.word_at inj ~cycle:closing_cycle` carries `terminate_char` in
   lane `closing_ot mod 8`); **site 2**, on the *driven* word at that cycle, read
   back from the samples. A member whose `/T/` never reached the DUT asserts an
   absence that was always going to hold.
3. **Derivation guards** — the `~expected_…` comparisons of §3, plus §4's
   anti-trap guard. All of these compare this file's arithmetic against this
   packet's; **none of them reads the design**, so none can be moved by a design
   defect.
4. **Vacuity guard**: the run's last sampled cycle is `≥ boundary`. (It will be:
   the schedule alone runs to the auto-placed terminate at cycle 10 and `~drain:8`
   follows. Assert it anyway — the guard is what makes step 6 non-vacuous, and
   `run_i2_member:445` already carries the same guard for the same reason.)
5. **No output word at all** (§0.7): no `tlast` sample, and
   `delivered_samples samples` is empty.
6. **The row's own observable — silence from the boundary onward.** Over
   `samples` filtered to `cycle >= boundary`: **no `tvalid`** and **no strobe**.
   Two separate assertions with two separate messages, each naming `boundary`,
   REQ-109 and C-14.3, in the same shape `run_i2_member:518-532` uses.
7. **Anti-vacuity on the strobe**: `error_pulses samples` is **exactly one** pair;
   its name is **`error_runt`**; its cycle is **strictly less than `boundary`**.
   Nothing tighter. See below.
8. **Conservation**: `account_dropped_frame bench frame ~strobe:"error_runt"` and
   `Conservation_monitor.strobe_pulse (conservation bench) ~name:"error_runt"` —
   `run_f2:485-486`'s pair, because it is the same dropped frame.
9. **`assert_monitors_clean bench ~row`**, last.

**What it must NOT assert: §9's pinned cycle 4.** No assertion of the member's
own may compare the observed pulse cycle to 4, and no message of its own may
contain the phrase *"expected cycle 4"* or its equivalent. That exact number is
**M03-F2's** claim and **M03-E5's**; a second, tighter instrument inside this unit
would convict before the C-14.3 window ever spoke, which is the exact failure mode
that has kept this window silent since it was written. Step 7's bound is
`cycle < boundary`, and that inequality is *part of the window* — one assertion
says nothing exists at or after the boundary, the other says the one thing that
exists is before it.

### 5.1 The strobe monitor — a RULING, because the obvious reading of §5 is wrong

Step 8's accounting is not enough on its own: `Strobe_monitor` matches expected
events to observed high cycles **exactly on `(strobe, cycle)`**, and any high
cycle no expected event claims makes `assert_monitors_clean` fail. So member (iii)
**must register a `Strobe_monitor.expect` event**, and that event carries §9's
pinned cycle — there is no unpinned form of `expect`.

**Ruling: register it, exactly as `run_f2:425-437` does** — same `strobe`,
`frame`, `cycle = closing_cycle + 2`, `not_before = closing_cycle`,
`not_after = closing_cycle + 3`, and a `why` quoting §9's no-output-word pin and
§0.7. **This does not violate the prohibition above**, and the distinction is the
point rather than a loophole:

- the registration is the **standing obligation-4 monitor**, attached to every
  M03 unit in this bench; a unit that drives a strobe and registers nothing is a
  coverage regression, not a purer instrument;
- it is evaluated **last**, inside `assert_monitors_clean`, **behind** the row's
  own window scan at step 6, so it cannot shadow the window; and
- it is **not an independent detector** — it re-checks a pin this bench itself
  computed and handed it, and it says nothing whatever about C-14.3's bound.

**Say all three of those things in a comment at the registration site**, and say
which instrument is expected to speak first if this unit ever reddens. A reader
who finds a pinned cycle inside a member whose plan cell says "does not assert
§9's pin" is entitled to that explanation at the site, not in a packet.

---

## 6. The three stale citation sites that ride with this round

`RV-0060-VERDICT` §10 item 3 recorded three `RV-0059-VERDICT §8` citations in
`test_m03_i.ml` beyond that packet's own enumeration, and deferred them to the
next round that opens this file. **This is that round.** The defect: those sites
cite `RV-0059-VERDICT §8` **as the authority for the output-word cycle rule**, and
**that verdict's §8 is the rule that was refuted**. The rule in force is
**SPEC-M03 §6.1's D(m) as re-ruled at `1f3c04c`** (with `requirements.md` §0.5's
deciding-input-word bullet where §0.5 is what the site cites).

At HEAD the three sites are:

| approx. line | what it is | what is wrong |
|---|---|---|
| `:41–42` | module docstring, the M03-I4 bullet | the delay identity is attributed to `RV-0059-VERDICT §8` |
| `:1394–1395` | M03-I4's `%expect_test` **title** | *"word sequence via RV-0059-VERDICT §8's corrected cycle rule"* |
| `:1501` | the M03-I5 NO-ASSERT comment | *"— RV-0059-VERDICT §8's corrected rule"* |

**The repair, per `WO-0060` §3.6's own rule**: re-cite the **rule** to SPEC-M03
§6.1's D(m) at `1f3c04c`; **keep the history** where a site records history rather
than authority (that round 1 sent `Idle_injection.cycle_of` an *output* cycle,
`RV-0059-VERDICT` FINDING 1 / FINDING 3, is a true and useful record and stays).
`:938` in the same file is **already** in the repaired form and is the model to
copy; **do not edit `:938`.**

**Two constraints on the title at `:1394`:** the `"M03-I4: "` prefix and the row
id must survive byte-identical (row-to-unit traceability is by that prefix), and
the `[%expect]` block below it must stay byte-identical.

**Three sites is where I expect to land, and it is NOT a closed list.** The last
packet to enumerate citation sites in this file claimed a closed list, was wrong
by three, and forbade edits beyond it — which is how these three survived. So:
**locate the sites by content, not by line number** (line numbers have drifted
since the finding was written), repair **every** occurrence you find, and if the
set is larger or smaller than three, **say so in the Return log with the exact
sites**. Finding a fourth is a good outcome for this round, not a deviation from
it.

---

## 7. What does not move — and why that is not a claim that it is correct

Out of scope for **editing** this round:

- `run_i2_member` itself, and members (i) and (ii) — their derivations, their
  guards, their parameters and their call sites in `run_i2`;
- `test_m03_f.ml`'s `run_f2`, and every other family's file;
- `bench.ml` / `bench.mli` — this member needs nothing that is not already
  exported (`create`, `run`, `delivered_samples`, `tlast_sample`, `error_pulses`,
  `account_dropped_frame`, `conservation`, `strobes`, `assert_monitors_clean`,
  `directed_frame_octets`, `fail`). If you believe it does, **report it**;
- the five landed `Owed bench note (i)…(v)` blocks and their remaining citation
  sites — those are deferred by `WO-0064`'s scheduling and are **deliberately**
  not in this round;
- `test/attack_plans/**` — the plan edit is dv_lead's and has already landed;
- every `[%expect]` block in the file except the two title strings §1 and §6
  name.

**And the clause that matters more than the list.** Nothing above is asserted to
be *correct*. It is asserted to be *out of scope for editing*, which is a
different thing. If you find any of it false — a stale comment, a wrong number, a
claim this packet makes about existing code that does not hold at HEAD, including
any of §3's eight numbers, §4's quoted lines or §6's three sites — **report it in
the Return log and leave it standing.** A work instruction that exempts an
artefact from review by asserting it is already correct moves the check from the
executor to the author, where it happens once, from memory, before the change
exists; that is exactly how `WO-0064` §5 shipped a comment its own instruction had
falsified (`J-dv_lead-0101`). **This packet's claims about existing code are
claims to verify, not facts to trust.**

---

## 8. The review bar — pre-committed, so it cannot be renegotiated after the fact

I will run these myself against your returned tree rather than read them off your
Return log.

- **B1 — the eight numbers, re-derived independently.** I re-derive `start_ot`,
  `closing_ot`, `W`, the pin, the §0.6 window and the C-14.3 boundary at both
  lanes from `injection.ml`'s placement map and §9/§0.6/C-14.3 **before** reading
  your constants, then compare. Any disagreement is adjudicated against the
  specification, not against either of us.
- **B2 — the boundary's provenance.** The member's `boundary` traces to the
  **closing character's** octet time by a path I can read, and
  `Arrival.terminate_octet_time` appears in this member **only** inside §4 item
  3's anti-trap guard.
- **B3 — the anti-trap guard exists, is executable, and names both numbers** in
  its message.
- **B4 — no pinned-cycle assertion.** No assertion of the member's own compares
  an observed strobe cycle to 4, at either lane; the only cycle bound on the pulse
  is `< boundary`. Checked by reading every comparison in the runner, not by
  grepping for `4`.
- **B5 — ordering.** The nine steps of §5 appear in that order, and the strobe
  monitor's contribution is evaluated last. I will state, from the returned
  source, which instrument speaks first for each of: a late output word, a
  deferred strobe, a missing strobe.
- **B6 — non-vacuity, demonstrated rather than asserted.** Your Return log must
  state, from the driven run, (a) the last sampled cycle, (b) the number of
  samples with `cycle >= boundary`, and (c) the observed pulse's cycle and name at
  **each** lane. A silence assertion whose scanned set nobody counted is not
  evidence.
- **B7 — no scope creep.** `git show --name-only` at your commit contains exactly
  `test/xgmii_rx_64/test_m03_i.ml`, this packet, and your journal. No `dune`, no
  `bench.ml`, no other family file.
- **B8 — inventory and expect blocks.** `bash tools/dv_checks.sh` still reports
  `39 test/xgmii_rx_64/`; every `[%expect]` block in `test_m03_i.ml` is
  byte-identical to HEAD; the only string changes are the two titles §1 and §6
  authorise.
- **B9 — the citation repair is complete and correctly scoped.** No occurrence of
  `RV-0059-VERDICT §8` survives **as an authority for the cycle rule** anywhere in
  `test/**` (search across lines — two of the three sites are line-wrapped, which
  is why a line-based grep missed them for two rounds); `:938` is untouched; every
  history-recording mention survives.
- **B10 — CI.** `dune build @default` and `dune runtest` green at your commit,
  with `git diff --exit-code` clean (no unpromoted expect drift), plus
  journal-check green. **CI is the authority** — the local toolchain is
  unavailable (ADR-0005) and a claim of "passes locally" is not admissible from
  either of us. Quote both run ids and their conclusions.

---

## 9. BOUNCE conditions

Any one of these returns the packet:

- **BO-1** — a guard parameter was changed to match the code (or vice versa)
  after a disagreement, instead of the disagreement being reported.
- **BO-2** — the member's boundary derives, directly or transitively, from
  `Arrival.terminate_octet_time`.
- **BO-3** — the anti-trap guard of §4 item 3 is absent, or is a comment only.
- **BO-4** — any assertion of the member compares an observed strobe cycle to
  §9's pin.
- **BO-5** — the member is threaded through `run_i2_member` rather than given its
  own runner, or the runner's name encodes an ordinal.
- **BO-6** — a new `%expect_test`, a changed inventory count, or any `[%expect]`
  block whose bytes moved.
- **BO-7** — `~word_at` omitted from the `run` call, or either landing site
  (§5 step 2) absent, at either lane.
- **BO-8** — any file outside `test/xgmii_rx_64/test_m03_i.ml` edited, this
  packet's Return log and your journal excepted.
- **BO-9** — `:938` edited, or a history-recording mention of `RV-0059-VERDICT`
  deleted rather than re-cited.
- **BO-10** — the Return log asserts a result CI did not produce, or omits the
  §8 B6 figures.

---

## 10. Your return

Append to this packet's Return log, and journal per PROTOCOL §4:

1. **The eight numbers as your own code computes them**, both lanes, beside this
   packet's — a table, with any disagreement flagged rather than reconciled.
2. **B6's figures**, both lanes.
3. **The instrument-order statement** of B5, in your words, from your own source.
4. **The citation-site set you actually found**, by content, with the count and
   the exact sites; explicitly state whether it is three, and if not, what the
   others were.
5. **Everything §7 asked you to report** — any claim of this packet about
   existing code that does not hold at HEAD. If there is nothing, say "nothing",
   and say what you checked to be able to say it.
6. **CI run ids and conclusions** for `build` and `journal-check`.
7. **Your files-touched list**, exactly.
8. Anything you judged rather than followed, and why — the same latitude
   `WO-0064` recorded and upheld: reading the rule rather than the table is the
   right order, and saying so is the obligation that goes with it.

---

## Return / verdict log

## Return log (tb_writer, WO-0063A/2026-08-04)

**1. The eight numbers, re-derived independently, before reading §3's table
as an instruction rather than a claim.** Derived by hand from
`requirements.md` §0.5/§0.6/§0.7, `docs/specs/modules/xgmii_rx_64.md` §6.1's
drain derivation (C-14.3) and "Strobe cycle, pinned", §9's no-output-word pin
and ruling 9, and `test/xgmii/injection.ml`'s own placement-to-octet-time map
(`At_octet k` -> `start_ot + 8 + k`, confirmed in the source, not only via
`run_f2`'s comment) and `arrival.ml`'s `terminate_octet_time` /
`create` arithmetic — never from `libs/**`. All eight AGREE with this
packet's table at both lanes; nothing was adjusted either direction.

| # | Quantity | Packet §3 | My re-derivation | Agree? |
|---|---|---|---|---|
| 1 | `start_ot` (lane 0 / lane 4) | 8 / 12 | 8 / 12 | Agree |
| 2 | closing `/T/` octet time | 16 / 20 | 16 / 20 | Agree |
| 3 | closing word W (cycle) | 2 / 2 | 2 / 2 | Agree |
| 4 | §9 no-output-word pin (W+2) | 4 / 4 | 4 / 4 | Agree |
| 5 | §0.6 window `[W, W+3]` | [2,5] / [2,5] | [2,5] / [2,5] | Agree |
| 6 | C-14.3 boundary (W+3) | 5 / 5 | 5 / 5 | Agree |
| 7 | conformant margin (pin→boundary) | 1 / 1 | 1 / 1 | Agree |
| 8 | output words | 0 / 0 | 0 / 0 | Agree |

Notable, and stated in a comment at both the runner and the `run_i2` call
site per WO-0063A §3: this is the first M03-I2 member whose numbers are
identical at both start lanes (members (i)/(ii) are 13/13/13/14).

**2. B6's figures, both lanes — hand-derived from `test/xgmii/arrival.ml`'s
own `cycles`/`create` arithmetic and `bench.ml`'s `run` (`total =
Arrival.cycles sched + drain`), never from an executed simulation (no local
toolchain, ADR-0005, and `bench.create` elaborates the RTL, which I do not
run or read).**
- Lane 0: `terminate_octet_time` (declared, auto-placed) = 80 ⇒
  `Arrival.cycles sched` = `((80 + 12 + 7) / 8) + 1` = 13. Lane 4: declared
  terminate = 84 ⇒ `((84 + 12 + 7) / 8) + 1` = 13. Both lanes: **13**.
- (a) last sampled cycle = `13 + drain(8) - 1` = **20**, both lanes.
- (b) samples with `cycle >= boundary(5)`: cycles 5..20 = **16**, both lanes.
- (c) the observed pulse's cycle and name: **not available from me** — this
  is the one figure only an actual run against the elaborated RTL can
  supply, and I neither run nor read that RTL. My own code asserts only
  `name = "error_runt"` and `cycle < boundary`; a spec-conformant design is
  expected (§9's own pin, the same one `run_f2`'s analogous k=0 case already
  pins) to land at cycle 4, both lanes — stated as an expectation, not a
  claim of having observed it.

**3. B5's instrument-order statement, in my own words, from my own source
(`run_i2_zero_octet_member` as returned):**
- **A late (or any) output word** — step 5's `tlast_sample` /
  `delivered_samples` check speaks first: it is unconditional over the
  whole run, ahead of the boundary-filtered scan at step 6.
- **A deferred report** (an `error_runt` at or after the boundary) — step
  6's window scan speaks first: it reads `errors_high` directly on
  `silent_tail`, ahead of step 7's `error_pulses`-based count and strictly
  ahead of the standing `Strobe_monitor` registration, which is only
  evaluated inside `assert_monitors_clean` at step 9.
- **A missing report** (no `error_runt` at all) — step 7's anti-vacuity
  count speaks first (the `error_pulses` match falls to its `| pulses ->`
  branch), again ahead of step 9.
- On every one of these three paths the §5.1 registration is never first —
  consistent with its own ruling that it is evaluated last, behind the
  window.

**4. The citation-site set actually found: three, matching this packet's §6
table exactly by content**, confirmed with a full-tree, line-joined regex
sweep for `RV-0059-VERDICT\s+§8` (Python, joining every line of
`test_m03_i.ml` with a single space, so a phrase split across a raw newline
still matches) rather than a same-line `grep`, plus a plain `grep -rn
RV-0059-VERDICT test/` to rule out a site outside this file. It is **not**
larger or smaller than three.

| Site | Before | After |
|---|---|---|
| module docstring, M03-I4 bullet (pre-edit :41-42; the phrase "RV-0059-VERDICT / §8" is split across a raw line break there, invisible to a same-line grep for the joined token) | "...(RV-0059-VERDICT §8, replacing WO-0059 §3.4 item 2's own per-octet form, FINDING 6) --" | "...(SPEC-M03 §6.1's D(m) (1f3c04c), this file's own re-basing of the form it took from RV-0059-VERDICT §8's own round-2 repair of WO-0059 §3.4 item 2's own per-octet form, FINDING 6) --" |
| M03-I4's `%expect_test` title (pre-edit :1394-1395; "RV-0059-VERDICT §8's" sits whole on one line but the phrase naming what it cites, "corrected cycle rule", wraps to the next — invisible to a grep for the packet's own quoted defect phrase) | "...word sequence via RV-0059-VERDICT §8's corrected cycle rule (baseline_cycle(m)..." | "...word sequence via SPEC-M03 §6.1's D(m) (1f3c04c) (baseline_cycle(m)..." |
| M03-I5 NO-ASSERT comment (pre-edit :1501; same shape as above) | "...baseline_cycle(m) + (cycle_of(D m) - D m) -- RV-0059-VERDICT §8's corrected rule, D(m) always a SOURCE cycle..." | "...baseline_cycle(m) + (cycle_of(D m) - D m) -- SPEC-M03 §6.1's D(m) (1f3c04c), D(m) always a SOURCE cycle..." |

`:938` (the model, "the cycle rule this file previously took from
RV-0059-VERDICT §8 (itself round 2's own repair of...") is untouched, and
every history-recording mention of `RV-0059-VERDICT` (the FINDING 1/3/4/5/6
citations, the §6/§12 section references) survives unedited. The only other
tree-wide mentions of `RV-0059-VERDICT §8` I found are `AP-xgmii_rx_64.md`
line ~1063, which already states the correction of record ("the authority
for the cycle rule is SPEC-M03 §6.1's D(m) at `1f3c04c`; §8 of that verdict
is the rule that was refuted") rather than citing §8 as authority — left
untouched, both because it is already correct and because
`test/attack_plans/**` is out of scope for this round (WO-0063A §7).

**5. Everything §7 asked me to report — claims about existing code that do
not hold at HEAD: nothing.** Checked: `run_i2_member`'s pre-edit line 445 is
exactly the vacuity-guard fail site the packet cites; `run_f2:396,
404-405, 425-437, 485-486` in `test_m03_f.ml` (untouched by me) match the
packet's citations exactly; every `bench.mli` export the packet names
(`create`, `run`, `delivered_samples`, `tlast_sample`, `error_pulses`,
`account_dropped_frame`, `conservation`, `strobes`, `assert_monitors_clean`,
`directed_frame_octets`) is present with a matching signature (`fail` is
this file's own local binding, as the packet implies); `test/xgmii_rx_64/
dune` already lists `dv_xgmii` and needed no edit (confirmed by reading the
file, not assumed); `test/xgmii/injection.ml`'s own `create` defaults
(`?ifg = 12`, `?first_start = 8`, `+4` at `first_lane:4`) match §0.3's lane
mapping the packet assumes. The three citation sites matched the packet's
table by content exactly (item 4). I found no fourth site and no falsified
claim.

**6. CI run ids and conclusions: none — I never run `git`, so no CI run
exists yet against this content (charter §8, ADR-0005: "CI is the
authority", and a claim of "passes locally" is not admissible from either of
us).** My own admissible local evidence: `ocamlc -stop-after parsing
test/xgmii_rx_64/test_m03_i.ml` — exit 0. `bash tools/dv_checks.sh` — bench
inventory unchanged (`5 test/xgmii_rx_64/test_m03_i.ml`, `39
test/xgmii_rx_64/` total); the run's sole `OBLIGATION OPEN` line is the
pre-existing, unrelated RFC-1071 network-fetch obligation
(`check_rfc1071_anchor.sh`), not caused by this change. `git diff --stat --
test/` shows exactly one file changed, `test/xgmii_rx_64/test_m03_i.ml`;
`git diff -- test/xgmii_rx_64/dune` is empty.

**7. Files-touched, exactly:**
- `test/xgmii_rx_64/test_m03_i.ml` (the member, the two `run_i2` call
  sites, the M03-I2 `%expect_test` title, the three citation repairs)
- `agents/handoffs/WO-0063A_m03-i2-member-iii-bench.md` (this Return log)
- `agents/journals/workers/claude_tb_writer_agent.v02.md` (my journal entry)

**8. Judged rather than followed, and why:**
- The runner's name, `run_i2_zero_octet_member`, is taken verbatim from
  this packet's own acceptable example (§1) rather than invented, since the
  packet's naming discipline (`J-dv_lead-0100`) is a review bar and the
  packet already supplied a name that satisfies it.
- I exposed all eight of §3's numbers as `~expected_…` parameters, including
  the two whose "independent computation" is closer to arithmetic identity
  than to a design-derived formula (the conformant margin, and the
  output-word count under §0.7) — §3's own instruction ("pass the numbers
  below in as `~expected_…` parameters and guard each one") reads as
  covering all eight, and B1's own bar re-derives and compares by exactly
  this table, so I judged completeness here worth the two thinner guards
  over trimming to a "meaningful subset."
- §5's nine steps are listed in an order where the derivation guards (step
  3) sit textually AFTER both landing-check sites (step 2), even though the
  guarded quantities are pure `Arrival`/`Injection` arithmetic computable
  before the schedule is ever driven. I kept the packet's literal order in
  the source rather than moving the guards earlier for their own logical
  independence, because B5 asks the returned source's own line order to
  match §5's numbered list, and a reader tracing "which instrument speaks
  first" needs that order to be the file's own, not a logically-equivalent
  rearrangement.
- I did not touch the module-level docstring's own M03-I2 summary text (the
  family-list bullet at the top of the file, and the "M03-I2 -- the
  repaired row" section), which still describes "two members" and is now
  stale in that one respect. WO-0063A §1 frames the artefact as "exactly
  one... and its shape is fixed" across four numbered items, none of which
  is the module docstring, and §7's out-of-scope list does not name it
  either way; I read the fixed-shape framing as excluding documentation
  outside those four items and left it standing, flagged here rather than
  silently touched or silently left unmentioned.

**9. Something transiently observed mid-spawn, now resolved independently —
recorded so the timeline is honest rather than because it needs action.**
Partway through this spawn, `git status` showed
`agents/handoffs/BUG-0003_m03-lane-4-injected-word-cycle.md` as modified. I
did not create that modification — I never opened, read the diff of, or
wrote to that file at any point (WO-0063A §7 forbids opening any `BUG-`
packet, which I honoured throughout). I flagged it as a stray mid-session
concern. It is no longer present: `git log` now shows commits `72ed100`
(`Agent: dv_lead`, `Journal-Entry: J-dv_lead-0103`) and `1f43afd`
(`Agent: orchestrator`) that closed that packet on its own timeline,
independent of and concurrent with this spawn, landed through the normal
commit path — neither touches `test_m03_i.ml` or this packet
(`git show --name-only` on both, checked). Recorded here only so a reader
of this Return log does not wonder why an earlier draft of it (visible in
this file's own edit history, if inspected) mentioned a file that is now
clean; there is nothing for dv/orchestrator to act on.
