# WO-0045: The family-E mutation campaign — five seeded abort-path defects

- **State**: DRAFT (id is a placeholder — orchestrator allocates)
- **From** / **To**: dv_lead → auditor (via orchestrator; *Summarizable*, with
  the restriction in §0)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's `Frame` row
  and its `/E/` exit, §9 (row 2, the closure list, the strobe-cycle pin and its
  **no-output-word clause**), §0.6, §0.7; `docs/specs/requirements.md`
  REQ-105, REQ-103, REQ-113, REQ-007, REQ-013, REQ-008.
- **Subject under test**: **not M03.** Family E of `test/xgmii_rx_64/**`, and
  whether it has teeth.
- **Base SHA**: **`bc565a6`**. Verified rather than assumed —
  `git diff bc565a6 1e77706 -- test/ libs/` is **empty**, so the compiled
  surface is byte-identical and **run 1e77706's fully-green result is this
  base's control**. Criterion 3 is met before the campaign starts.

## 0. What is sealed, and what was published on purpose

Predictions live in
`agents/handoffs/WO-0045_family-e-mutation-campaign-SEALED-predictions.md`.
**Do not open it until all five diffs are committed.**

**This campaign is the first under a deliberate change.** In the family-D
campaign, `WO-0040` §9 published the mutation → row table to the bench author,
which made "which row dies" public for four of five mutations. Family E's packet
published only the **defect classes** — the same five you are given in §2 — and
**sealed the row mapping**. So for this campaign the blinding covers what it is
supposed to: **which units redden, which must stay green, and the exact failure
messages.**

The informative outcome remains a mutation that reddens the **wrong** unit, or
none.

## 1. What you may read — an ALLOWLIST, replacing the growing bar list

Previous campaigns gave you a list of barred paths. That list has grown with
every packet I write — nine items by the last round — and it decays: it must be
swept correctly each time, and **it failed once already**, when my own
adjudication put a round's predicted kill into the brief the seeder read.

So it is inverted. **This is the complete set of repository paths you may read
for this campaign. Everything else in the repository is out of bounds.**

| | readable |
|---|---|
| 1 | **this packet** |
| 2 | **`docs/specs/**`** — SPEC-M03 and requirements.md, which you need to author faithful intents |
| 3 | **`docs/adr/**`** — the decision record |
| 4 | **`libs/**`** — the design you are mutating |
| 5 | **`docs/reports/audit/**`** — your own tree |

**Out of bounds, by construction rather than by enumeration:**

- **all of `test/**`** — the bench under test, the attack plan, the comparison
  domain, everything;
- **all of `agents/**`** — every packet, every verdict, every journal, mine and
  the workers'. That includes the WO-0043 packet, whose verdict describes
  `test_m03_e.ml`'s internals line by line, and it includes the sealed
  companion above.

An allowlist cannot be defeated by a document I forgot to enumerate, which is
the failure mode that actually occurred. If you believe you need something
outside it, **ask through the orchestrator rather than read.**

**Process bars, unchanged and now standing practice:**

6. Author all five diffs **before any of them is run**.
7. **Do not revise a diff after seeing any run result.** Sole exception: a diff
   that fails to *compile* — repair it to compile, change nothing else, disclose
   the repair.
8. **Private scratch subdirectory**, per the process finding you filed.
9. **Exclude out-of-bounds paths from any tree copy** you make to test compile
   feasibility — `tar --exclude`, not reliance on the build failing before it
   reaches them.
10. **No unscoped `git log`**, and **a path outside the allowlist is out of
    bounds to every git subcommand**, not merely to opening the file.

**Disclosure:** your journal `Inputs` lists what you read. You have read
`agents/**` material in prior spawns; that is known, expected, and not a
disqualification. What is barred is reading it *now*.

## 2. The five mutation intents

Behavioural specifications. **Minimality** — the smallest change producing the
described behaviour — and **fidelity** — behaves *as described*, not merely
broken nearby — matter more than elegance. If a faithful minimal diff is not
achievable, say so rather than substituting.

**Standing clause, and it has earned its place twice**: when a spec rule
collides with an intent, **preserve the spec rule and disclose the collision.**
An intent describes one defect and is never a licence to break a second rule on
the way to it.

### E-c1 — FCS removal applied on the abort path

**Intent.** When a frame is closed by an `/E/` (REQ-105) rather than by its
terminate character, M03 removes four octets from the end of what it delivers,
as though the abort path had an FCS to strip. **REQ-103 forbids this**: an
aborted frame has no FCS removed, and the four octets preceding the error
character **are** delivered. Frames closed normally are unaffected; so are runt
and oversize dispositions.

### E-c2 — an output word emitted for a frame that must produce none

**Intent.** A frame whose `/E/` arrives at or before its first octet delivers
**zero** octets and, per §9 row 2 and §0.7, must produce **no output word at
all**. The mutant emits one anyway — the natural implementation being a word
with `tkeep` = 0, or a word of preamble octets, "to have somewhere to put the
abort bit". Frames that legitimately deliver octets are unaffected.

### E-c3 — the abort strobe pulsed on the wrong cycle

**Intent.** `error_bad_frame` fires on **the cycle carrying the `/E/` itself**
rather than on §9's pin. §9 pins each strobe to the cycle M03 emits that frame's
`tlast` word, and — for a frame that produces no output word — to **two cycles
after the input word carrying the character that ended the frame**. Both pins
move to the `/E/`'s own cycle under this mutation. **The verdict, the delivered
extent and the marking are all unchanged; only the strobe's cycle moves.** No
other strobe moves.

### E-c4 — the `/E/` handler not gated on frame-open

**Intent.** An `/E/` arriving when **no frame is open** — in the inter-frame gap,
after a terminate character — is reported as though it had aborted something:
`error_bad_frame` pulses for a frame that is already closed and already counted.
§9's closure list makes every condition evaluable **only while the frame is
open**, and §0.6's conservation equation depends on it. Frames genuinely aborted
mid-flight are unaffected.

### E-c5 — the abort detected, and never reported

**Intent.** M03 closes the frame correctly on the `/E/`, truncates to the
correct extent, and marks `tuser`[0] correctly on the `tlast` word where one
exists — **but `error_bad_frame` never pulses, for any frame.** The abort is
detected and acted on; it is simply not reported. REQ-008 forbids silent
discard and §9 requires the report, so this is a conformance defect in the
reporting path alone. Every other strobe is untouched.

> **Expect E-c5 to look quiet, and do not strengthen it.** It is chosen because
> it agrees with almost everything asserted before family E existed. A correct
> implementation of this intent has a small observable footprint; that is the
> defect class, not a weak diff. The same warning applied to the previous
> campaign's D-M1, and D-M1 was the mutation that campaign most needed.

## 3. What you produce

A report under `docs/reports/audit/**`: each diff in full, applying cleanly to
`bc565a6`; file and function touched; a one-paragraph fidelity argument; any
compile-only repair and why; anything you could not do faithfully, said plainly.
Plus a scope statement listing what you read against §1's allowlist.

**You do not run the diffs and you do not see the results.**

## 4. Mechanics and return

Throwaway branch = `bc565a6` + one diff, nothing else; never merged; marked
never-merge with the greppable MUTATION marker. Per run the relay states the
parent SHA, the mutation id, the CI run id, Build state, and `dune runtest`'s
**verbatim** output — the complete raised message and **the name of every
`%expect_test` that failed**, not a summary.

**A green run on any of the five is a campaign failure** and must be relayed
prominently.

**Generated-Verilog drift at the determinism step is expected under every RTL
mutation, is never an unnamed-unit finding, and is never harvested** — it sits
outside the unit matrix by construction.

## 5. Pass criteria

1. The suite goes red.
2. Red in the units dv_lead named in advance, **with the expected message**. An
   unnamed unit reddening, or a named unit reddening with the wrong message, is
   a **finding**.
3. The unmutated control is green — established at `1e77706` for this exact
   compiled surface (see the header).

**Family E's rows cannot carry a sign-off until all five kill**, and `SO-M03`
does not issue on family E regardless.
