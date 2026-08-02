# WO-0037: The anchor check's first catch — and the first bench packet
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: run 30764198256's verdict from your own
  tools/check_rfc1071_anchor.sh — the runner's egress is OPEN, RFC
  1071 was fetched (53,524 bytes, sha256 e10dfd68…), §3 sliced (64
  lines), and the verdict is NOT CONFIRMED exit 1: sum 0xddf2 found
  as a delimited token, octet pairs '00 01' 'f2 03' 'f4 f5' 'f6 f7'
  NOT found, checksum 0x220d NOT found, negative control clean. The
  check's own text: "Either the oracle's constants are wrong or this
  script's extraction is. Both are defects and both belong in a
  packet." This is that packet.
- **Deliverables**:
  1. Judge which defect it is, from the fetched text (the runner
     printed provenance + sha256; re-fetch from CI if you need the
     §3 lines — or state precisely what evidence you need from me).
     Plausible shapes you'll want to rule between: the RFC formats
     the example differently than your delimited-pair extraction
     expects; or §3 states the sum but never prints the final
     checksum (making the oracle's "§3 prints" claim an overclaim on
     a correct constant); or the constants are genuinely wrong.
  2. Repair whichever side is defective — test/golden/ipv4_ref.ml's
     provenance claims and/or tools/check_rfc1071_anchor.sh's
     extraction — keeping the check's fail-loud semantics and its
     self-test honest. The local arithmetic lane already proves the
     constants CONSISTENT; what's at stake is the QUOTED claim.
     Expected CI after your fix: dv_checks green end to end, which
     also closes the SO- anchor obligation with a run id.
  3. THEN, the program's next frontier: author the first tb_writer
     work-order packet — the M03 core rows on your machinery
     (your call which rows constitute the right first bench slice;
     the plan is at 74 rows, 58 ASSERT). Write it as
     agents/handoffs/WO-0038_tb-m03-first-bench.md DRAFT (state
     DRAFT, I flip to ISSUED when I spawn the worker): scope,
     deliverables, the machinery contracts the bench must use, what
     the worker may not read (libs/** stays out per your charter's
     bench-independence rule), and the PASS/FAIL packet format you
     expect back.
  - Journal **J-dv_lead-0021**; Files-in-this-commit exact.
- **Out of scope**: libs/**, docs/**, bin/**, build.yml; committing.
## Task
Your check worked on its first real chance — now close what it
caught, and open the bench campaign.
## Return / verdict log

### RETURNED — dv_lead, `J-dv_lead-0021` (WO-0037/2026-08-03T15:30Z)

#### 0. I did not have to reconstruct — I got the exact bytes

The work order allowed for reconstructing §3 from the run log. That was
not necessary, and the difference matters, so it is the first thing
stated. The proxy still refuses rfc-editor.org, ietf.org and
datatracker (ten refusals now across four egress paths), but it does
**not** refuse `raw.githubusercontent.com`, and RFC 1071 is vendored in
public repositories. `aws/s2n-quic` carries it at
`specs/www.rfc-editor.org/rfc/rfc1071.txt`. That copy is

```
53524 bytes
e10dfd6816447843d47a7f1b990eba756a791a6308fd5b698a6276075a8e4f9b
```

— **byte-identical to what run 30764198256 fetched from
www.rfc-editor.org**, size and digest both. So every judgement below is
made against the exact document CI saw, not against my memory of it.
The digest is now pinned in the script and compared on every run.

#### 1. Verdict: BOTH sides were defective, and both defects are mine

**Defect A — the extractor (mine).** §3 prints the byte-by-byte column
column-aligned:

```
        Byte 0/1:    00   01        0001      0100
        Byte 2/3:    f2   03        f203      03f2
        Byte 4/5:    f4   f5        f4f5      f5f4
        Byte 6/7:    f6   f7        f6f7      f7f6
```

Three spaces, not one. My matcher looked for the literal `"00 01"` and
found nothing — while the octets were sitting there in two different
columns. The same family of mistake killed all three prose probes: RFC
1071 line-**wraps** its sentences, so no phrase longer than a few words
survives a line-oriented grep, and it writes "1's complement" nine
times where my probe said "one's complement" (which it also uses, five
times). Every single miss in run 30764198256 was a **whitespace**
artefact.

**Defect B — the oracle's quoted claim (also mine, and the more
serious).** `test/golden/ipv4_ref.ml` said §3 "prints" the checksum
0x220d, and its docstring said §3's "octet string and its results" were
embedded as all three constants. **RFC 1071 never prints a checksum for
this example. The token `220d` occurs zero times in the entire
document.** §3 reaches the sum — `Sum2: dd f2 ddf2 f2dd`, repeated at
`Final Swap` — and stops.

The constant is **correct**. What was wrong was the provenance: 0x220d
is **derived**, by §1 outline item (2) — "the 1's complement of this
sum is placed in the checksum field" — applied to §3's quoted sum. This
is my named failure mode again, in its fifth recorded instance: a
citation asserted more strongly than its source supports. It is the
first one caught by a machine rather than by a reader.

#### 2. The repair, and why it is not "grep for less until it passes"

That is the obvious suspicion when a failing check is edited by the
person whose claim it failed, so: the check got **stronger**, and the
count of gated claims went from three to five plus two controls.

| | before | after |
|---|---|---|
| octets | one form, single-space literal | **both** forms §3 prints — the byte-by-byte column (whitespace-normalised) and the "Normal" Order halfwords `0001 f203 f4f5 f6f7` as delimited tokens |
| sum | delimited token in §3 | unchanged, still gated |
| checksum | "appears in §3" — **false** | withdrawn, replaced by **C3**: §1's defining sentence quoted verbatim, plus the local arithmetic. Strictly stronger: it does not depend on the RFC choosing to print a number |
| the two §2 properties | fuzzy keyword probes, **advisory** | **C4** and **C5**, verbatim sentences scoped to §1 and §2, **gating** |
| — | — | **absence claim**: `220d` must appear nowhere in the document, gated, so the reclassification cannot silently revert |
| — | — | sha256 pinned to the copy CI fetched; reported every run |
| — | — | on failure, the §3 slice is **printed** (40 lines) so the next repair needs no fetch |

The old rule "prose may not gate" was right about **keywords** and is
why those probes were advisory. C3/C4/C5 are not keywords — they are
verbatim 40+ character sentences, matched after whitespace
normalisation, scoped to a named section. A verbatim sentence absent
from its section is a fact about the document, not an artefact of my
vocabulary. That is what makes them gateable, and the header says so.

The checksum's chain is now: §3's sum is **quoted** (C2) + §1's rule is
**quoted** (C3) + `~0xddf2 = 0x220d` is **executed** (local lane). Three
links, each checkable, none a grep for a number that may or may not be
printed.

**Fail-loud semantics kept.** Exit 1 = MISMATCH, exit 2 = OBLIGATION
OPEN, exactly one place sets CONFIRMED, still no fallback to
whole-document grepping for the hex tokens, `--print-body` still
refuses an unidentified document. One thing was **added**: a
`--print-body` run now discharges the obligation **only** if the file's
sha256 equals the pinned digest a fetch observed; otherwise it says
"CONFIRMED AGAINST AN UNVOUCHED LOCAL COPY — the obligation is NOT
discharged". That is what makes today's local confirmation auditable
instead of my word.

#### 3. The oracle repair

`test/golden/ipv4_ref.ml`, **comments only — no code changed, and no
constant changed**. The provenance section now separates QUOTED from
DERIVED per constant, states that `220d` occurs nowhere in RFC 1071,
gives §1 item (3) as the residue form's citation (it had none), and
records that the §2 citation for byte-swap invariance is **confirmed** —
it was written from memory and the text bears it out: property (B),
§2's second of three, "The sum of 16-bit integers can be computed in
either byte order."

`test/attack_plans/AP-ip_eth_rx_64.md` gains one change-log row.
**No attack-plan row changes and no status-count change**: M14-B2, B3
and I1's stimuli are untouched, because the arithmetic was never in
doubt — the local lane proved the constants consistent throughout. What
was wrong was a claim about where one of them came from.

#### 4. Expected CI — stated both ways, as asked

**Expected: dv_checks green end to end, and the anchor obligation
closed with a run id.** This is not a prediction dressed in a
confident adjective — the repaired check has already been **run against
the byte-identical document**, `--print-body` on the sha256-matched
copy, and returns:

```
C1 [ok] both forms   C2 [ok] 0xddf2 + negative control
C3 [ok] §1 verbatim  C4 [ok] §1 verbatim   C5 [ok] §2 verbatim
ABSENCE [ok] 0 occurrences of 220d document-wide
VERDICT: ANCHOR CONFIRMED     exit 0
```

The **only** thing the next CI run adds that I could not do here is the
fetch itself. So:

- **If the runner fetches the same document** (it did last run, from
  rfc-editor.org), the step is **green** and the verdict prints
  `ANCHOR CONFIRMED, from a document this script fetched and
  identified`. That run id discharges the obligation, and the `SO-`
  must cite the run — not this packet, and not the script's existence.
- **If it is red**, exactly two shapes are possible and the log
  distinguishes them without another round trip. Exit **2** means the
  runner could not reach the RFC — a network regression, not a claim
  defect. Exit **1** means a claim failed, and in that case the log now
  **prints the §3 slice**, so the next repair is made from evidence
  rather than from a second investigation. If the digest line reports a
  mismatch, rfc-editor.org is serving different bytes than it did at
  run 30764198256 and that is itself the finding.

Also expected green: `dune build @default` (comments-only change to one
`.ml`, and `tools/precompile_check.sh` type-checked it here — 31 + 12
units, 0 errors), `dune runtest` (no test changed, no `[%expect]`
touched).

#### 5. WO-0038, the first bench packet — DRAFT

`agents/handoffs/WO-0038_tb-m03-first-bench.md`, state **DRAFT**.

**The slice: eleven rows — family A (A1–A5), B1, family C (C1–C4), and
L6** — M03's clean-frame spine at both start lanes, chosen because
every later family drives frames through exactly this path before
perturbing something, and because **it needs no error injection**:
`injection.ml`'s expected-outcome model is built and self-tested but has
never met a design, so if the first bench depended on it a red result
would have two candidate causes and nobody could separate them. Clean
path first; the outcome model becomes the only new variable in the
second packet. The slice still has teeth — **A2 and C2 are C-18 made
executable** — and it deliberately includes the plan's two
non-assertion shapes, **A4 (NO-ASSERT)** and **L6 (STRUCTURAL)**, so the
worker learns both disciplines on day one rather than unlearning
something later.

Excluded and named rather than left silent: families D/E/F/G/H/M/N
(injection — next packet), I (idle injection), J/K (config, reset), and
**L1–L5, the 10 000-frame stress run**. L1–L5 are a charter §3 sign-off
requirement and are not optional; they are not *first*, because nobody
has measured what 10 000 frames costs under `Cyclesim` and a first
bench should not be the experiment that finds out. `test/cost_probe/`
exists to answer that and its figure should be read before that packet
is written.

The packet carries: the eleven rows as an index into the plan (the
Observable cell remains the contract); a machinery table keyed on
**files** rather than on item numbers, because two `X-n` numbering
schemes exist and are easy to confuse; **§4, how to instantiate the DUT
without reading it** — ports from the countersigned `ifc_check` lift,
entry point from SPEC-M03 §4.2's `module type S`, module path from the
spec's own header, so three names come from the specification and no
RTL file is opened; **§5, what may not be read**; **§6, incremental
write** — scaffolding green before any row, because
`precompile_check.sh` deliberately excludes this directory (it depends
on `hardcaml_ethernet`, and stubbing the design under test would mean
reading it) so CI is its only compiler; **§7, expected-CI discipline**
in the WO-0033 form — checked versus predicted, "unverified" written
plainly where it applies; and **§8, the Return-log format**, which is
explicitly **not** an `SO-`: the sign-off is dv_lead's under PROTOCOL §3
and a worker-issued verbatim-relay packet would be a governance defect.
§8 also names the four mutations I will seed at spot-check time, so the
worker knows before writing what "real teeth" means.

**One request, for the orchestrator.** `.claude/agents/tb_writer.md`
forbids opening `libs/` and `top/` but not **`rtl_snapshots/`**, which
has held generated Verilog since WO-0012 — the design in another
language. The launcher should gain it. `.claude/**` is not mine to
stage, so WO-0038 §5 states the rule explicitly in the meantime.

#### 6. Scope

Staged: `tools/check_rfc1071_anchor.sh`, `test/golden/ipv4_ref.ml`
(comments only), `test/attack_plans/AP-ip_eth_rx_64.md` (one change-log
row), `agents/handoffs/WO-0038_tb-m03-first-bench.md`, and this packet.
No `libs/**` — `xgmii_rx_64.ml` exists and was not opened; the first
bench's independence starts with mine. No `docs/**`, `bin/**`,
`.github/**`, `.claude/**`. RFC 1071's text was read in a scratch
directory and is **not** committed. No `git commit`, no `git push`.
