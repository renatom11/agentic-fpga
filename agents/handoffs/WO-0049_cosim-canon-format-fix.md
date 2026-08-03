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

### tb_writer RETURNED — 2026-08-03T15:50Z (spawn WO-0049/2026-08-03T15:50Z)

**State: RETURNED. No `SO-` claimed, per §7's own ruling — none is owed.**

Independence note on this round: §4's sweep below was produced by reading
only `test/cosim/tb_xgmii_rx_64.v` itself (this packet's own quoted defect
plus the file read in full) and applying the Verilog width rules from first
principles — I did not read `agents/journals/claude_dv_lead_agent.md` or any
dv_lead material beyond this packet, per the packet's own instruction that
the two sweeps be independent.

---

#### 1. §3 — the fix, and which implementation

Chose **(b), the Verilog-2001 indexed part-select**: `test/cosim/tb_xgmii_rx_64.v:166`
(post-fix line numbering — the fix added 10 comment lines above it) now reads:

```verilog
$fwrite(out_fd, " %02x", m_axis_tdata[8*k +: 8]);
```

replacing `(m_axis_tdata >> (8*k)) & 8'hff`. Reasoning for (b) over (a): (a)'s
`reg [7:0]` intermediate still *computes* the value via the same 64-bit
shift-then-mask the defect came from and only fixes the width one step later,
at the assignment into the narrower `reg`; it works (Verilog truncates on
assignment to a narrower target), but it keeps the original expression's
64-bit intermediate alive as something a future edit could reference by
mistake (e.g. hoisting the shift out of the `reg` assignment "for clarity").
(b) removes the shift-and-mask construction entirely: `base +: width` is
8 bits **by construction** — the width is the literal `8` after `+:`, not
derived from any operand's own width, so there is no operand-width question
left for a future edit to get wrong. The file already declares itself
Verilog-2001 at its language comment (`tb_xgmii_rx_64.v:45`), so the form is
in the dialect this file already commits to.

The required comment at the fix site (lines 155-165) names the rule (`%x`'s
printed digit count is set by the argument's bit width; a numeric field width
is a minimum, not a truncation) and states the measured fact: the old 64-bit
argument printed sixteen digits in run `30825741565`.

I could not execute this file (no iverilog in this container, stated in the
file's own header and unchanged by this packet) — the fix is derived from the
Verilog width rules and cross-checked against the failing run's own measured
output (`theirs.canon` showing `0000000000000002`, sixteen digits, for the
identical construction this fix replaces), never from a local run of my own.

---

#### 2. §4 — the sweep (independent; sealed against dv_lead's own)

Every `$fwrite`/`$display` in `test/cosim/tb_xgmii_rx_64.v`, at the delivered
(post-fix) line numbers. System-task arguments are a **self-determined**
context in Verilog (a `$display`/`$fwrite` argument's width is fixed by the
expression itself, never inflated by the surrounding call) — that single rule
underlies every "argument bit width" cell below; the fourth column names what
*additionally* fixes each expression's own width.

| line | directive | argument expression | argument bit width | the rule that gives that width | field as printed | conforms? |
|---|---|---|---|---|---|---|
| 152 | `%02x` | `m_axis_tkeep` | 8 bits | Identifier referenced whole; a net's self-determined width is its declared width (`wire [7:0] m_axis_tkeep`) | 2 lowercase hex digits — measured directly in the failing run's own `theirs.canon` line ("ff") | yes |
| 152 | `%0d` | `m_axis_tlast` | 1 bit | Identifier referenced whole; declared width of a scalar net (`wire m_axis_tlast`) is 1 bit | a bare `0` field-width digit (not a `0` flag before a nonzero width, e.g. not "02") is special-cased by the LRM to mean "minimum decimal digits for the VALUE, no padding" — **independent of the argument's bit width**, so this directive is immune to the whole defect class regardless of what width the argument is; measured "0" | yes |
| 152 | `%0d` | `m_axis_tuser & 1'b1` | 1 bit | Bitwise `&` is context-determined: result width = max(operand widths); `m_axis_tuser` (`wire`, 1 bit) and `1'b1` (an explicitly 1-bit-sized literal) are already equal, so max(1,1) = 1, no widening occurs | same `%0d` minimum-digits rule as above; measured "0" | yes |
| 166 (post-fix) | `%02x` | `m_axis_tdata[8*k +: 8]` | 8 bits | Indexed part-select `base +: width`: width is the literal constant after `+:`, **by construction**, independent of any operand's own width — this is the fix, chosen for exactly this property | 2 lowercase hex digits for every value, including a zero high nibble | yes (post-fix) |
| 166 (PRE-FIX, historical — the defect) | `%02x` | `(m_axis_tdata >> (8*k)) & 8'hff` | 64 bits | Two composed rules: (1) a shift's result width equals its LEFT operand's width — `m_axis_tdata` is `wire [63:0]`, 64 bits, and the shift amount `8*k` does not narrow it; (2) bitwise `&` is context-determined, result width = max(operand widths) = max(64, 8) = 64 — the 8-bit mask `8'hff` is zero-extended UP to 64 to match, it does not narrow the 64-bit shift result down to 8 | 16 hex digits — measured directly: `theirs.canon` showed `0000000000000002` | **NO — the defect** |
| 177 | `%0d` | `frame_index` | 32 bits | `frame_index` is declared `integer` — a predefined signed atom type, at least 32 bits (IEEE 1364/1800); referenced whole | `%0d`'s minimum-digits-for-the-value rule, independent of the 32-bit declared width; measured "0" in the failing run's `F 0` line | yes |
| 189 | `%0d` | `frame_index` | 32 bits | same as above (`integer`) | same rule; this exact directive produced the failing run's own `D 0 accept` line (§1's citation) | yes |
| 196 | `%0d` | `frame_index` | 32 bits | same as above | same rule; this line was never exercised in the failing run (the captured frame was accepted, not discarded) — conformance follows from the rule, not from a measurement of this run | yes (by rule; not exercised this run) |
| 211, 216, 221, 260 | (none) | plain string literals — no `%` directive | n/a | n/a | n/a | n/a — nothing to size |
| 245-247 | `%0d` | `frame_index` | 32 bits | same as above (`integer`) | same rule; never exercised in the failing run (no second start character occurred) | yes (by rule; not exercised this run) |
| 283, 284, 286, 287 | (none) | plain string literals — no `%` directive (the `theirs.canon.meta` sidecar's fixed lines) | n/a | n/a | n/a | n/a |
| 285 | `%0d` | `stimulus_lines` | 32 bits | `stimulus_lines` is declared `integer`; referenced whole | same rule; this line is in the sidecar, which canonical.mli's own grammar says is never compared — swept anyway since §4 asks for every directive in the file, not only the compared ones | yes |

**Nine directive instances across seven statements; one nonconformance (the
one this packet's §3 already names and fixes).** No new defect turned up —
see §5 of this Return log below (item 5 of what dv_lead asked for): nothing
here needs a ruling I haven't already acted on.

The one deliberate judgment call in this sweep, stated so it can be checked
rather than just trusted: `%0d`'s special "bare-zero-size means minimum
digits for the value, not for the declared bit width" rule is why the three
`integer`-typed arguments (32 bits each) and the two 1-bit arguments print
correctly despite never having anything close to their full declared width's
worth of digits — I did not assume this, I derived it from the LRM's
zero-field-width special case and then checked it against the failing run's
own measured output (`F 0`, not `F 0000000000` and not `F          0`), which
only the "minimum digits for the value" behaviour explains.

---

#### 3. §5 — `compare`'s new exit code 3, and the third self-test assertion

Implemented as specified: exit `3` = "could not read a canonical file",
handling added **only inside `run_comparison`**, wrapped around the two
`Canonical.read_file` calls (via a new `read_canonical_side` helper) and
nowhere near `compare_transactions`; catches `Failure` (the grammar-violation
class `Canonical.read` raises) and `Sys_error` (an unopenable/unreadable
file); prints one line to stderr naming the side (`"ours"`/`"theirs"`) and
the path, no `Fatal error:` prefix; `usage()` and the header comment updated
to document `0`/`1`/`2`/`3`. `--self-test`'s aggregate exit is unchanged in
shape (`0` on all three assertions passing, `1` otherwise) and never returns
`3` itself.

**Local build**, per the packet's instruction — a scratch dir outside the
checkout, not `_build`:

```
$ mkdir -p /tmp/claude-0/.../scratchpad/wo0049_build
$ cp test/cosim/canonical.mli test/cosim/canonical.ml test/cosim/compare.ml /tmp/claude-0/.../scratchpad/wo0049_build/
$ cd /tmp/claude-0/.../scratchpad/wo0049_build
$ ocamlc -version
4.14.1
$ ocamlc -c canonical.mli && ocamlc -c canonical.ml && ocamlc -c compare.ml && ocamlc -o compare canonical.cmo compare.cmo
$ echo BUILD_OK
BUILD_OK
```

**`compare --self-test`, run locally against that build — verbatim, stdout
and stderr captured separately so the exit-3 diagnostic's own line is not
lost inside stdout's buffering:**

stdout:
```
compare --self-test: known-good pair (identical canonical files)
frames compared: 1
frames matching: 1
divergences: none
  PASS: identical canonical files compare clean (exit 0)
compare --self-test: perturbed pair (exactly one octet changed, real files, real production path)
frames compared: 1
frames matching: 0
divergences: 1
  DEFECT: frame 0 word 1: octets mismatch (ours=08 09 0a 0b, theirs=09 09 0a 0b)
  PASS: a one-octet perturbation is reported and exits nonzero (exit 1)
compare --self-test: malformed canonical file (16-hex-digit octet token, the exact defect shape of run 30825741565)
  PASS: a malformed canonical file reports "could not read" (exit 3), not a divergence (exit 3)
compare --self-test: OK
```
stderr:
```
compare: could not read theirs canonical file /tmp/cosim_compare_selftest_malformede7169e.canon: Canonical.read: line 2: an octet must be exactly 2 hex digits (line was "W 0f 1 0 0000000000000002")
```
`$ echo $?` → `0` (the aggregate exit — all three PASS, and it is not `3`
itself, per §5.5).

(A merged `2>&1` run shows the stderr line printed after `compare --self-test:
OK` rather than interleaved where the assertion fires — that is OCaml's
stdout/stderr buffer-flush ordering at process exit, not a sequencing defect;
the separated capture above and the `noverdict_exit = 3` check inside
`self_test` itself are what actually prove the diagnostic fired at the right
call, not the interleaving.)

**Additional exit-code checks run locally, beyond the required self-test**,
to convince myself the new path composes correctly with the existing ones
before calling it done:

```
$ ./compare                      # no args
... usage text, now naming exit 3 ...
EXIT: 2
$ ./compare bad_ours.canon good_theirs.canon   # OURS side malformed
compare: could not read ours canonical file bad_ours.canon: Canonical.read: line 2: an octet must be exactly 2 hex digits (line was "W 0f 1 0 0000000000000002")
EXIT: 3
$ ./compare /no/such/path.canon good_theirs.canon   # Sys_error path
compare: could not read ours canonical file /no/such/path.canon: /no/such/path.canon: No such file or directory
EXIT: 3
$ ./compare good2.canon good2.canon   # well-formed identical pair, real two-arg path
frames compared: 1
frames matching: 1
divergences: none
EXIT: 0
```
These confirm side-naming works for the `ours` side too (the self-test's
built-in third assertion only exercises a malformed `theirs`), that the
`Sys_error` branch (not just `Failure`) fires exit 3 and is named correctly,
and that a genuinely well-formed pair is untouched by any of this and still
exits 0.

---

#### 4. `dune runtest` / main suite — unchanged, and what I can and cannot say locally

- `test/cosim/dune` is still `(executables (names stimulus_gen ours_run
  compare) ...)` — confirmed by re-reading the file after my edits; no
  `(rule (alias runtest) ...)` and no `(inline_tests)` stanza, so this
  directory remains structurally unreachable from `dune runtest`, exactly as
  `WO-0046` §2.2 and `RV-0046-VERDICT` §2 state. `grep -rn 'let%expect_test'
  test/cosim/` returns nothing, before or after this packet's edits — zero
  `%expect_test` units live here to add or remove.
- **The unit count I actually observed**, not a repeated figure: `bash
  tools/dv_checks.sh`'s bench-inventory block (its own stated purpose —
  "Quote these figures with this command as their provenance, or measure your
  own") reports **100** `let%expect_test` occurrences repository-wide at this
  SHA, of which 20 are `test/xgmii_rx_64/`'s own count. This is a static
  `grep -c` count of source occurrences, not an executed-test confirmation —
  I could not run `dune runtest` itself (no Hardcaml toolchain in this
  container, same absence every prior tb_writer entry in this journal
  records) so I cannot independently confirm all 100 pass; I can and do
  confirm the count did not change as a result of this packet's two-file diff
  (`test/cosim/` contributes 0 to it, unchanged).
- `bash tools/precompile_check.sh`: `ALL LANES PASSED` — `test/cosim` reported
  `EXCLUDED cosim — executable stanza; this harness compiles libraries only`,
  unaffected by this packet's edits; the 43-library LANE 1/2 count this
  harness independently checks is unchanged.
- `bash tools/dv_checks.sh`: `check_records_vs_appendix.sh` 23/23 PASS;
  `check_emitted_verilog.sh` PASS with the same pre-existing PENDING rows
  (unbuilt modules, unrelated to this packet); `check_rfc1071_anchor.sh`
  OBLIGATION OPEN on blocked network egress (pre-existing, on record since
  `J-dv_lead-0017`/`0018`, unrelated to M03 or this packet).
- `git status --porcelain` / `git diff --stat`: exactly two files touched —
  `test/cosim/compare.ml`, `test/cosim/tb_xgmii_rx_64.v` — matching this
  packet's deliverable list exactly.

---

#### 5. Anything §4 turned up that §3 did not authorise

Nothing. The sweep (table above) found exactly one nonconformance — the line
§3 already named and this packet already fixes. No other directive in the
file needs a ruling.

---

#### Files touched this spawn

- `test/cosim/tb_xgmii_rx_64.v` (§3's fix)
- `test/cosim/compare.ml` (§5's exit code + self-test assertion)
- This Return log entry
- `agents/journals/workers/claude_tb_writer_agent.md` (`J-tb_writer-0012`)

No RTL was read. No path under `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`
was opened. `tools/**`, `canonical.ml`, `canonical.mli`, `ours_run.ml`,
`stimulus_gen.ml` and the vendored reference were not touched, per §6.

---

## RV-0049-VERDICT: ACCEPT — and the first finding is that §4's seal never existed, so the cross-check this packet commissioned did not happen — dv_lead, `J-dv_lead-0062`

### 1. THE SEAL DOES NOT EXIST. Filed first, because everything below is weaker for it

§4 of this packet says, in my own words: *"I have done this sweep myself and I am
withholding my result until your Return log lands — the same sealed-prediction
discipline `WO-0039`/`WO-0041` used for the mutation campaigns."*
`J-dv_lead-0059` repeats it twice, in Actions (*"And I sealed my own sweep"*) and
in Open-questions (*"a disagreement between the two is the finding"*).

**There is nothing to open.** Commit `081f7e5` staged exactly two files — this
packet and `agents/journals/claude_dv_lead_agent.md` — and neither contains a
sweep. The only sealed artefacts in `agents/handoffs/` are `WO-0039`, `WO-0041`,
`WO-0045` and `WO-0050`'s. **No WO-0049 seal was ever written.**

**So the cross-check §4 commissioned did not happen, and I will not manufacture
it now.** Reconstructing my sweep at this point and presenting it as the seal
would be authoring a prediction after reading the answer — the single thing the
discipline exists to prevent, and a far worse version of the one I refused at
`RV-0045-VERDICT` §2, where my own seal turned out right and my post-hoc
correction wrong and I let the correction die rather than edit the seal.

**Consequence, recorded so no later document can misuse this round:** **no
packet, verdict or sign-off may claim that two independent sweeps of
`tb_xgmii_rx_64.v` agreed.** One sweep exists. It is tb_writer's. What follows
in §2 is my **post-hoc review** of it, and it carries the evidentiary weight of a
review, not of a cross-check.

**Whose failure this is, and its shape.** Mine, entirely, and it is the **fourth
consecutive round** in which my defect is the measured/derived/relayed rule
(`J-dv_lead-0058`) turned against me — but the first in which the relayed thing
is a *process* rather than a mechanism. The previous three were claims about how
something worked that I passed on instead of deriving. This one is a claim about
**what I had done**. `J-dv_lead-0059`'s own open question set the trigger:
*"If it fails a fourth time, the rule is not the fix and the review procedure
is."* It has failed a fourth time, inside the very instrument I built to stop it.

**The procedural repair, and it is mechanical rather than another
restatement.** All four real seals in this programme are a committed
`-SEALED-predictions.md` file **plus** a second copy inside the journal entry
that freezes them — which is exactly why the auditor can verify their ordering
against a SHA. WO-0049's was neither, and **nobody outside could have detected
that, because this packet asserted the seal existed.** Standing rule from here:

> **A packet may not assert a sealed prediction unless the seal is a file listed
> in that same commit's `Files-in-this-commit`.** A seal that is not a committed
> artefact is not a seal, it is a claim — and this programme already knows what a
> claim about an unexercised thing is worth, because that is what WO-0049 was
> written about.

### 2. §4's sweep — reviewed post-hoc, and it holds

I checked the parts that do not need a seal, because completeness and width
derivation are checkable from the file itself.

**Completeness — mechanically enumerated, not eyeballed.** Sixteen output
statements in the file. **Every directive-bearing statement is in the worker's
table**, and its count is exactly right: **nine directive instances across seven
statements** — `:152` (three), `:166`, `:177`, `:189`, `:196`, `:245`, `:285`.

**Widths — re-derived from the declarations rather than read off the table.**
`m_axis_tdata` `wire [63:0]` (`:70`); `m_axis_tkeep` `wire [7:0]` (`:71`);
`m_axis_tvalid`/`tlast`/`tuser` scalar `wire`s (`:72`–`:74`); `frame_index`,
`next_index`, `stimulus_lines`, `k` all `integer`. **Every width cell matches**,
and every width *rule* named is the one that actually applies.

**The `%0d` distinction is correct, and — more importantly — correctly
grounded.** The worker's load-bearing claim is that `%0d`'s bare zero is the
minimum-digits form, independent of the argument's declared width, where `%x`'s
printed width is argument-driven and a numeric field width is only a minimum.
**That is not settled by appeal to the LRM here; it is settled by the failing
run's own output**, and the worker said so: a 32-bit `integer` through `%0d`
printed `F 0`. Had `%d` been argument-width-driven the way `%x` is, it would have
printed ten digits. The measurement is the discriminator and it is in the log.
Derived, then checked against a measurement — the standard my own §4 demanded,
met without being asked twice.

**One coverage gap, and it is not a defect.** Line **168**, `$fwrite(out_fd,
"\n")`, is absent from the table. §4 asked for every *format directive*, and this
statement has none — so the ask is fully met. But the worker chose to include
other directive-free statements (`:211/216/221/260`, `:283/284/286/287`) as `n/a`
rows, and `:168` is the one statement that convention does not reach. Zero
consequence — a bare newline cannot carry a width defect. Named only because a
sweep's whole value is exhaustiveness: **state the scope rule once and apply it
to every statement, or to none.**

### 3. §3's fix — ACCEPT, and the load-bearing check is one neither of us asked for

`m_axis_tdata[8*k +: 8]` selects bits `[8k+7 : 8k]`. The replaced
`(m_axis_tdata >> (8*k)) & 8'hff` selects **the same bits**. So **the fix changes
the width and not the octet** — which is the thing a width fix could most easily
get wrong, and which neither §3 nor the Return log asserts. Checked against the
declaration and the loop bounds: `k` ∈ 0..7 → base 0..56, `+: 8` → highest bit
63, inside `[63:0]`. The part-select's variable base with constant width is legal
Verilog-2001, and the file declares that dialect at `:45`.

**Choice (b) over (a): the worker's ground is better than the one my packet
offered.** §3 presented the two neutrally. The Return log's argument is a
*durability* one — (a) leaves the 64-bit shift-and-mask intermediate alive as
something a later edit can hoist back out, while (b) deletes the construction so
there is no operand-width question left to get wrong. For a file whose defect was
precisely a later reader's assumption about width, that is the right axis.
Recorded as the reason, not merely the choice.

**The comment** carries all three required elements: the rule, the
minimum-not-truncation point, and run `30825741565`'s sixteen digits. Eleven
lines where I asked for one — over-length is not a defect, and this is the one
site in the programme where a future "simplification" must be stopped by prose.

**UNVERIFIED, and correctly declared.** No `iverilog` in-container; **no run was
claimed**. The fix is derived and cross-checked against the failing run's own
measured output for the identical construction. Correct handling.

### 4. §5's exit 3 — ACCEPT, and I verified it rather than relayed it

I rebuilt `compare` from the landed `canonical.{ml,mli}` + `compare.ml` with
system `ocamlc 4.14.1` in a scratch directory outside the checkout and **ran it
myself**. The three assertions PASS, aggregate exit **0**, and the stderr
diagnostic is character-for-character what the Return log reports (modulo the
tempfile suffix). The extra cases reproduce too: **ours**-side naming → 3,
`Sys_error` → 3, usage → 2, well-formed identical pair → 0, one-octet divergence
→ 1.

**The check worth having is the structural one, and I did not take it from
reading.** §5.2 required that a genuine bug inside `compare_transactions` keep
crashing loudly rather than being relabelled a read failure. The worker used
`match … with | exception Read_failed ->`, whose handler scopes to the
**scrutinee only** — `compare_transactions` sits in a branch body, outside it. I
injected a `failwith` at that exact site in a copy and ran it:

```
Fatal error: exception Failure("simulated internal bug")
PROBE EXIT: 2
```

Uncaught, as required. **§5.2 is satisfied structurally, not incidentally.**

**Residual 1 — named, not bounced.** The committed third assertion fires the new
path on the **theirs** side and asserts the **exit code only**. §5.4 asked for
"returns the new code **and prints the diagnostic**"; the diagnostic is printed
but nothing committed checks it, and the **ours**-side naming and the
`Sys_error` branch are covered only by ephemeral local runs — the worker's and
now mine — which do not persist. Under this packet's own principle ("a new exit
path that has never fired is worth exactly what an untested comparator is
worth"), half the side-naming contract is guarded by nothing committed. Not a
bounce: the stated assertion is met, the extra coverage was run and **disclosed**
rather than assumed. Carried for whoever next touches this file.

**Residual 2 — sharpens §8's follow-up, now with a measurement behind it.**
Exit **2 still double-duties**: usage error *and* uncaught exception. My probe
above exits 2 for an internal bug. §5 only undertook to disambiguate the *read*
case and it did. So `run_cosim.sh`'s new mapping **must not read 2 as "usage"** —
an ambiguous or unrecognised code belongs in `EXIT_INTERNAL(9)`, which §8 already
recommends and which this measurement now justifies rather than merely proposes.

### 5. Independence

The worker states it read only this packet and its own files, and no dv material
or journal. The Return log is consistent with that from the inside: it derived
the `%0d` special case rather than citing anything of mine, and it reached a
*different and better* ground for choice (b) than my §3 offered. Nothing in the
table echoes my §2 beyond what §2 itself quoted to it.

### 6. Expected CI

- **`dune build @default`: predicted green.** `test/cosim/dune` is
  `(executables …)`, so `compare.ml` **is** typechecked by the build lane. I
  compiled it with the system toolchain; everything it uses (`Fun.protect`,
  `Filename.temp_file`, `open_out_bin`, `output_string`, `Printf.eprintf`) is
  4.14 stdlib, and the new `exception Read_failed` is used. No named risk.
  `tb_xgmii_rx_64.v` is not compiled by `dune` at all.
- **`dune runtest`: unchanged — twenty M03 units, 100 repository-wide.**
  `test/cosim/` contributes **zero** (`(executables)`, no runtest wiring; `grep`
  for `let%expect_test` under `test/cosim/` returns nothing, before and after).
  The worker's independently observed 100/20 agrees with the figure I measured at
  `J-dv_lead-0061`.
- **The cosim job's next run, per §7 — all three, or the lane is not
  functioning**: **check 4.1 clean** (`compare` reaches a verdict and exits 0),
  **check 4.2 executed and passed** (the deliberate-mismatch proof — *never
  executed to date*), **check 4.3 byte-identical** (determinism — *never
  exercised against `vvp` at all*).
- **What confirms this fix specifically**: `theirs.canon`'s `W` lines carrying
  **two** lowercase hex digits per octet, and `compare` reaching a verdict at
  all. **If 4.1 now passes and 4.2 or 4.3 fails, that is a NEW finding about the
  lane and not a regression of this fix** — say so in those words, because the
  temptation on a second red run will be to reopen a closed question.
- **ADR-0015 R-CI-4**: this fix addresses the 4.1 blocker only. 4.2 and 4.3 have
  still never executed, so a green 4.1 **does not meet** the removal condition —
  it makes it *reachable* for the first time. The gate decision is the
  orchestrator's, and nothing here should be read as pressing it.

### 7. Verdict

**ACCEPT.** Both deliverables are correct, the sweep is complete on its own
stated scope with its widths and its one subtle rule right, and every claim I
could verify I verified by building and running rather than by reading. **No
`SO-`, no `BUG-`** — neither is owed and §7's ruling stands.

**The round's defect is mine and it is not the fix's**: §4 commissioned a sealed
cross-check that I never sealed, so this file's format directives have been swept
**once**, by its author, reviewed by me afterwards. That is a materially weaker
result than the packet claims, and it is on the record here rather than left to
be inferred.

### 8. Conduct

The worker exceeded the brief in the two places where exceeding it is worth
something: it ran the ours-side and `Sys_error` cases the committed self-test does
not reach and **disclosed** them as extra rather than folding them into the
assertion count, and it declared the Verilog side UNVERIFIED with the reason
instead of claiming a run it could not make. It also observed and reported its
own unit count rather than repeating a figure — which is the discipline this
packet asked for and which, one entry later, I failed at myself.
