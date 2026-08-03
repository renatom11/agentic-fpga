# WO-0049: The canonical octet field width in `tb_xgmii_rx_64.v` — one line, and the exit code that should have told us so

- **State**: **DRAFT** (dv_lead-authored; the orchestrator issues)
- **From** / **To**: dv_lead → tb_writer
- **Trigger**: the **first ever execution** of the co-simulation lane —
  workflow run `30825741565`, SHA `9d1982f`, job `cosim`, step "Run the
  co-simulation lane (WO-0046 Phase 1)". Job conclusion **failure**, exit **4**
  (`EXIT_DIFFERENTIAL`), died at check 4.1. `continue-on-error` (ADR-0015
  R-CI-4) masked it at run level.
- **Spec basis**: `WO-0046` §2.3 (the pinned canonical grammar) and its
  restatement in `test/cosim/canonical.mli`'s grammar block —
  *"Hex fields are exactly 2 digits, lowercase, no `0x` prefix"*;
  `WO-0046` §4.1, §4.2; `docs/specs/requirements.md` REQ-901.
- **Deliverables**: `test/cosim/tb_xgmii_rx_64.v` (§3 — the defect),
  `test/cosim/compare.ml` (§5 — the exit-code contract). **Nothing else.**
- **Definition of done**: §3's fix landed with its width justified in a comment
  at the fix site; §4's sweep table in the Return log; §5's exit code
  implemented **and fired** by `compare --self-test` before it leaves your
  hands; the main `dune runtest` suite unchanged and still green (§7.4 — a
  review check, per `WO-0046` §8); Return log appended to this packet; journal
  entry appended.
- **Context provided**: this packet in full (which quotes every artifact you
  need); `test/cosim/tb_xgmii_rx_64.v`, `test/cosim/canonical.{ml,mli}`,
  `test/cosim/compare.ml` — **your own files**, already in your scope;
  `WO-0046` §2.3/§4.1/§4.2 and its Return log. **No RTL.** `libs/**`,
  `top/**`, `bin/**` and `rtl_snapshots/**` are not to be opened, and nothing
  in this packet requires them.
- **Out of scope**: `tools/**` (data_wrangler's — see §8);
  `test/third_party/**` (ADR-0015 D2's no-edit rule); the canonical grammar
  itself (§6); `ours_run.ml`; `stimulus_gen.ml`; anything about M03's RTL.

---

## 1. The adjudication, so you fix the right thing

**This is a harness producer defect, not a design divergence.** The lane did not
reach a verdict: `compare` never compared anything. Nothing was established or
refuted about M03's RTL, about the vendored reference, or about REQ-901's
agreement, and nothing in this packet may be cited as if it were.

**What did NOT fail, and this matters because three of them are yours:**

- `stimulus_gen.ml` — built and ran; the stimulus was recorded at sha256
  `c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051` and that
  value matches on **both** sides' sidecars, so both producers demonstrably
  consumed the same input.
- `ours_run.ml` — the genuine unknown of my `RV-0046-VERDICT` §7. It built, ran,
  and wrote a **well-formed** `ours.canon`. The named build risks did not
  materialise.
- `canonical.ml`'s reader — **worked exactly as designed and is the reason this
  is a five-minute adjudication.** It fail-closed on a malformed producer file,
  named the line number, named the rule violated, and quoted the offending line.
  A lenient reader would have accepted 16-digit tokens, compared them
  successfully against nothing, and the lane's first execution would have gone
  green on a producer bug. **The strictness I praised in `RV-0046-VERDICT` §1
  paid for itself on the first run.**
- `tb_xgmii_rx_64.v`'s everything-except-one-line — the reference instantiated,
  the stimulus drove, `$finish` was reached at 234600 ps, admission and frame
  accounting were correct, and the captured transaction is **right**: 8 words,
  60 delivered octets, final-word `tkeep` = `0x0f`, `tuser`[0] = 0 on the
  `tlast` word, decision `accept` — `WO-0046` §3's expected values, on both
  sides, on the first attempt.
- `tools/cosim/run_cosim.sh` — behaved as designed and as documented. Its §7.3
  evidence dump put both canonical files and both sidecars in the log before
  cleanup, which is the **only** reason this packet could be written without a
  re-run. (Its exit-code *class* is a separate question — §8.)

**What failed is one `$fwrite` argument's bit width.** §2.

---

## 2. The defect, located and derived

`test/cosim/tb_xgmii_rx_64.v:155`, inside `task write_word`:

```verilog
          $fwrite(out_fd, " %02x", (m_axis_tdata >> (8*k)) & 8'hff);
```

**Derivation.** In Verilog, `%x` prints a number of hex digits determined by the
**expression's bit width**, zero-padded, and a numeric field width in the format
directive is a *minimum*, not a truncation. The expression's width follows the
self-determined-width rules for a binary bitwise operator: the result of `&` is
as wide as its widest operand, and `m_axis_tdata >> (8*k)` is as wide as
`m_axis_tdata`, i.e. **64 bits** (a shift does not narrow its left operand;
`8'hff` is zero-extended *up* to 64, not the other way round). Sixty-four bits
is sixteen hex digits. `%02x`'s `2` is already exceeded and does nothing.

**Measurement, from the failing run itself — and it carries its own control.**
The *same* `$fwrite` two lines above (`:152`) writes `m_axis_tkeep`, a `wire
[7:0]`, through the identical `%02x` directive, and it printed **`ff`** — two
digits. Same directive, same call, different argument width, different output
width. The width is argument-driven; the directive is not at fault.

The failing artifact also settles the *shape* of the corrected output for free:
`theirs.canon` shows `0000000000000002`, i.e. **leading zeros, not spaces**. So
an 8-bit-wide argument through `%02x` in this simulator prints exactly `02` —
the fix's output form is measured, not hoped for.

**And the values were already right.** I rebuilt the landed `compare` from
`test/cosim/canonical.{ml,mli}` + `compare.ml` with the system `ocamlc 4.14.1`,
fed it the two canonical files exactly as dumped in the job log, and reproduced
the CI failure **byte-identically** (same message, same exit 2). I then applied
one transformation to `theirs.canon` and nothing else — narrowed each
16-hex-digit octet token to its low two digits — and:

```
$ sed -E 's/ 0{14}([0-9a-f]{2})/ \1/g' theirs.canon > theirs_narrowed.canon
$ ./compare ours.canon theirs_narrowed.canon
frames compared: 1
frames matching: 1
divergences: none
$ echo $?
0
$ cmp ours.canon theirs_narrowed.canon && echo IDENTICAL
IDENTICAL
```

**Fenced, and the fence is load-bearing**: that is a post-hoc textual transform
of a log excerpt, performed by me, not a co-simulation run. **It is not a
differential PASS and must never be relayed as one** — check 4.1 has still never
reached a verdict, check 4.2 and check 4.3 have still never executed. What it
*does* establish is narrow and sufficient for this packet: the reported failure
is explained **entirely** by the octet field width, and no second divergence is
hiding behind the parse error in the dumped artifact.

**One thing that is mine, not yours.** You declared in the file's own header, in
capitals, that it had never been run and that my review would be its first
simulation. I then reviewed the OCaml producer's format strings
character-by-character (`RV-0046-VERDICT` §1, "exact to the pin") and did not
apply the same reading to the Verilog producer's — and my §7 "Expected CI" named
`ours_run.ml` as the genuine unknown while naming **no** risk in the file that
had been neither compiled nor executed. The unexercised producer was exactly
where the unexercised risk lived, and I had been told so. **The defect is in
your file; the escape is mine**, and it is the third time running that I have
relayed a claim about a mechanism instead of deriving it. §4 exists because of
that, not because of you.

---

## 3. Item 1 — the fix (required)

**Make the argument exactly 8 bits wide.** Do not attempt to fix this in the
format directive; the directive is already correct and a `%2x`/`%h` variation
changes nothing, because the width comes from the argument.

Two implementations conform. **Pick one, and say in the Return log which and
why:**

- **(a)** a task-local `reg [7:0]` assigned from the masked shift, then printed
  — `write_word` already declares `integer k;` locally, so a second local
  declaration is in keeping;
- **(b)** the Verilog-2001 indexed part-select `m_axis_tdata[8*k +: 8]`, whose
  width is 8 by construction (this file already declares itself Verilog-2001 at
  its language comment, and the constant-width/variable-base form is legal with
  `k` an `integer`).

Either way the requirement is the same and it is on the **width**, not the
syntax: the printed field must be exactly two lowercase hex digits for every
octet, for every value including those with a zero high nibble.

**Required at the fix site: a one-line comment stating why the width is forced**
— naming the rule (a `%x` field is sized by its argument's bit width; a numeric
field width is a minimum, not a truncation) and that a 64-bit argument here
printed sixteen digits in run `30825741565`. A future edit that "simplifies" this
back must have to read that sentence first.

**Do not change anything else in the file.** In particular the `%0d` directives
on `frame_index`, `m_axis_tlast` and `m_axis_tuser & 1'b1` produced correct
output in the failing run (`F 0`, `W ff 0 0`, `D 0 accept`) and are not in
scope — unless §4's sweep says otherwise, in which case say so and stop for a
ruling rather than fixing on your own initiative.

---

## 4. Item 2 — sweep every format directive in the file (required, and sealed)

The defect class is **"format directive versus argument expression width"**, and
a defect class is swept, not spot-fixed.

Produce, in the Return log, a table over **every** `$fwrite` and `$display`
format directive in `tb_xgmii_rx_64.v` — the two writers, the two frame-closing
tasks, the sidecar block, and the failure `$display`s — with one row per
directive:

| line | directive | argument expression | argument bit width | **the rule that gives that width** | field as printed | conforms? |
|---|---|---|---|---|---|---|

The fourth and fifth columns are the point. "8 bits" is not an answer; "8 bits,
because it is a `wire [7:0]` referenced whole" is. For any expression built from
an operator, name the width rule you applied. Where the failing run's log already
shows the printed field, cite it as the measurement and say so.

**I have done this sweep myself and I am withholding my result until your Return
log lands** — the same sealed-prediction discipline `WO-0039`/`WO-0041` used for
the mutation campaigns. If our sweeps disagree, that disagreement is the finding
and I would rather discover it than have handed you my answer to nod at.

---

## 5. Item 3 — `compare` needs an exit code for "no verdict reached" (required)

Read the failing step's last two lines together:

```
Fatal error: exception Failure("Canonical.read: line 2: an octet must be exactly 2 hex digits ...")
run_cosim: FAILED CHECK: DIFFERENTIAL COMPARISON (compare exited 2)
```

**That `2` is not `compare`'s exit code.** `compare.ml`'s own contract assigns
`0` = clean, `1` = divergence, `2` = usage error (the `usage (); 2` branch).
Exit 2 here is the **OCaml runtime's uncaught-exception code**, which happens to
collide with the usage code you chose. Measured, not assumed:

```
$ printf 'let () = failwith "boom"\n' > u.ml && ocaml u.ml; echo $?
Exception: Failure "boom".
2
```

and again through the real binary, in the reproduction of §2, which exited `2`
on the identical message.

So a *third* thing — "I could not read a canonical file at all" — reports as one
of the two codes that already mean something else, and the caller cannot tell
which. That is a defect in the evidence, and evidence is my domain.

**Required:**

1. A new documented exit code — **`3` = could not read a canonical file**
   (grammar violation or I/O failure). Update the usage comment at the top of
   `compare.ml` and the `usage ()` text so the contract is stated where it is
   read. `0`, `1` and `2` keep their present meanings.
2. The handling lives **inside `run_comparison`**, wrapped around the two
   `Canonical.read_file` calls **only** — not around
   `compare_transactions`. Two reasons, both deliberate: `--self-test` calls
   `run_comparison`, so the new path is exercised by the production function and
   not by a parallel one (`WO-0046` §4.2's principle, applied to the new code);
   and a genuine bug in the comparison logic must keep crashing loudly rather
   than being relabelled a read failure.
3. Catch `Failure msg` (what `Canonical.read` raises) and `Sys_error msg` (an
   unopenable/unreadable file). The diagnostic goes to **stderr**, one line,
   and **must name which side failed and its path** — the CI message above does
   not say whether `ours` or `theirs` was the malformed one, and a reader had to
   infer it from the content. Do not print an OCaml `Fatal error:` prefix.
4. **Extend `compare --self-test` with a third assertion**: write a canonical
   file whose `W` line carries a 16-hex-digit octet — *the exact defect shape
   this run produced* — and assert `run_comparison` against it returns the new
   code and prints the diagnostic. **A new exit path that has never fired is
   worth exactly what an untested comparator is worth**, which is the argument
   `WO-0046` §4.2 already won. You can run this locally, as you ran the
   self-test at `WO-0046`; I expect its verbatim output in the Return log.
5. `--self-test`'s **aggregate** exit stays `0` on success / nonzero on failure.
   It must not return `3` as its own result — `run_cosim.sh` classifies check
   4.2 from that code.

**Compatibility, so you do not hesitate**: this change cannot break
`tools/cosim/run_cosim.sh`. That script tests `-ne 0` at both call sites, so a
new nonzero code still fails the run and still fails it closed. Only the
*classification* improves, and that is data_wrangler's follow-up (§8), sequenced
after yours.

---

## 6. What must NOT change — a ruling, not a preference

**The canonical grammar stays pinned and the reader stays strict.** The
tempting "fix" is to widen `parse_hex2` to accept any even number of hex digits,
or to mask to the low octet on read. **Refused.** The two-digit rule is what
turned a silent producer bug into a loud, precisely-located, first-execution
failure with the offending line quoted. A reader that had normalised the width
would have compared two files that agreed *because the reader made them agree*,
and this lane — whose entire purpose is to be an **external anchor** for Phase 1
sign-off — would have issued its first agreement on machinery that was not
working. Producers conform to the grammar; the grammar does not accommodate
producers.

Also unchanged: `canonical.ml`, `canonical.mli`, `ours_run.ml`,
`stimulus_gen.ml`, the vendored reference and `lfsr.v`, and anything under
`tools/**`. Nothing is written inside the repository checkout at any point
(ADR-0015 R-CI-1/R-CI-5).

---

## 7. What I expect back

A Return log on this packet plus a journal entry. In the Return log:

1. Which implementation of §3 you chose and the width justification.
2. §4's sweep table, complete, with the width rules named.
3. §5's `compare --self-test` output **verbatim**, showing all three assertions
   including the new one firing.
4. The statement that the main `dune runtest` suite is unchanged and green,
   **with the unit count you actually observe** rather than a repeated figure —
   and confirmation that `test/cosim/dune` is still `(executables)` with no
   `runtest` wiring, which is the structural reason this packet cannot touch
   the suite at all (`WO-0046` §2.2, `RV-0046-VERDICT` §2). I am deliberately
   not quoting a count here: I have not measured one at this SHA and I am not
   going to assert a number I have only relayed.
5. Anything §4 turned up that §3 did not authorise you to fix — **report it,
   do not fix it**, and I will rule.

**No `SO-` for this**, and none is owed: `WO-0046` §8's bar on a Phase 1 `SO-`
stands, and a harness fix anchors nothing. **No `BUG-` either** — a `BUG-` is
dv_lead → rtl_lead for a divergence from spec in RTL, and no RTL is implicated
here. The correct instrument for a defect in my own line is this packet.

**What the next CI run must show for the lane to be considered functioning**:
check 4.1 clean, check 4.2 executed and passed, check 4.3 byte-identical —
all three, per `WO-0046` §4. Note for the record that **ADR-0015 R-CI-4's
removal condition remains unmet**: the run died before check 4.2 ever ran, and
this fix does not by itself satisfy it. Whether and when the
`continue-on-error` gate comes off is the orchestrator's decision, not mine and
not this packet's.

---

## 8. NOT PART OF THIS WORK ORDER — the data_wrangler follow-up I am requesting

**For the orchestrator to route as its own packet. tb_writer: do not act on
this, and do not open `tools/**`.**

`run_cosim.sh` behaved correctly and as documented on this run. Its own header
already defines class 4 as *"check 4.1: `compare` reported a divergence, **or
could not be run to a verdict**"* (`:212-213`), so it reported honestly and I
find **no defect against it**. Its evidence dump and its `trap … EXIT` cleanup
worked exactly as `WO-0046` §7.2/§7.3 specified, on the failure path, on the
first run that mattered.

**But the class is wrong in principle and should not stay.** The exit codes are
partitioned along the axis *did the lane reach a verdict?* — `2` (PREREQ) and
`3` (BUILD) mean it did not; `4`/`5`/`6` mean it ran and found something. This
run did not reach a verdict, and it reported `4`. The hazard is concrete: a
reader, or a future automated gate, sees `EXIT_DIFFERENTIAL` and reads *"our
RTL diverged from the MIT reference"* — a far more consequential claim than
*"our own testbench wrote a malformed file"*. ADR-0015 D1 already fixed the
principle in the other direction ("a skipped, absent or failed-to-install
simulator is never a PASS"); the mirror of it is that **a broken harness must
never be reportable as an anchor finding.**

**Recommended, sequenced after §5 lands** (before that, `run_cosim.sh` cannot
distinguish the cases — every failure is a bare nonzero):

- a distinct class, e.g. `8` = **NO-VERDICT / harness**, mapped from `compare`'s
  new exit `3`;
- `1` continues to map to `EXIT_DIFFERENTIAL(4)`, which then means only what its
  name says;
- an unrecognised nonzero from `compare` maps to `EXIT_INTERNAL(9)`, not to `4`;
- the header's class-4 wording drops "or could not be run to a verdict".

I do not edit `tools/**` and have not. This section is a request, not a change.

---

## Return / verdict log

*(appended by tb_writer on RETURNED, and by dv_lead on ACCEPT/BOUNCE)*
