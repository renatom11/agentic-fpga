# Journal: claude_data_wrangler_agent

- **Agent**: data_wrangler (Haiku/Sonnet worker template)
- **Charter**: agents/charters/data_wrangler.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.

---

## [J-data_wrangler-0001] 2026-08-03T13:49:46Z | task:WO-0046 | tools/cosim/run_cosim.sh — the co-sim Phase 1 entry point

### Trigger

Spawned by the orchestrator to execute the `tools/cosim/` half of WO-0046
(co-simulation Phase 1) in parallel with a tb_writer spawn building
`test/cosim/**`. No explicit "work-order id + spawn UTC timestamp" short-id
token was present in the spawn prompt this session received (PROTOCOL §4.1's
described form, e.g. `WO-0012/2026-08-01T16:00Z`); recording that honestly
here rather than inventing one. The task-identifying content given was: build
`tools/cosim/run_cosim.sh`, the single entry point that sequences the
reference build, the our-side driver, the comparison, the self-test, and the
two-run determinism diff, per WO-0046 and ADR-0015; code against the packet's
pinned interfaces where tb_writer's artifacts do not yet exist, not against
guesses about their content.

### Inputs

- `agents/charters/data_wrangler.md` (full read).
- `agents/PROTOCOL.md` §2–6 (full read of the whole file).
- `agents/handoffs/WO-0046_cosim-phase-1.md` at `cc8043930d6ca5c2b8e48608d814c96926653ae2`
  (confirmed unchanged at HEAD before I edited it) — full read.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` at the same SHA — full read.
- `docs/adr/ADR-0015-the-cosim-lane-dependency-reference-and-determinism.md`
  — full read (Status: ACCEPTED 2026-08-03).
- `test/third_party/verilog-ethernet/PROVENANCE.md` — full read, to confirm
  the vendored reference's pinned SHA (`77320a9471d19c7dd383914bc049e02d9f4f1ffb`)
  the sidecar records.
- `tools/precompile_check.sh` and `tools/check_rfc1071_anchor.sh` — full
  reads, for this repository's established house style for a hygiene-critical
  bash harness (`mktemp -d` + `trap … EXIT`, `--self-test` conventions,
  `say`/`hdr` helpers, `[ok]`/`[FAIL]` reporting).
- `scripts/policy.sh` — confirmed `data_wrangler`'s write scope is exactly
  `tools/*` and `agents/handoffs/*`.
- `.github/workflows/build.yml` — confirmed no `cosim` job exists yet (the
  orchestrator's part of §5's table, not touched here).
- `test/cosim/`, `tools/cosim/` — confirmed both did not exist before this
  spawn; `test/third_party/verilog-ethernet/{COPYING,axis_xgmii_rx_64.v,lfsr.v,PROVENANCE.md}`
  confirmed present and vendored per ADR-0015 D2.

### Reasoning

The packet splits Phase 1 into two artifacts along a real seam: `test/cosim/**`
(the canonical form, the comparator, the our-side driver, the Verilog
testbench — verification content, tb_writer's) and
`tools/cosim/run_cosim.sh` (sequencing, working directory, cleanup —
plumbing, mine). WO-0046 §5 states this explicitly and adds "data_wrangler is
not blocked by tb_writer" — so I built the orchestration script against the
packet's own pinned facts (the file layout in §2.1, the file-based bridge
diagram in §2, the three checks in §4 in their stated order, the hygiene
rules in §7 as hard constraints) rather than waiting for `test/cosim/`'s
binaries to exist, exactly as invited.

The one real design decision this task required of me, precisely because it
was NOT pinned, is the calling convention for the four entry points
(`stimulus_gen.exe`, `ours_run.exe`, `compare.exe`, `tb_xgmii_rx_64.v`) — the
packet fixes their names and what each reads/writes in prose ("writes
stimulus.txt", "reads stimulus.txt … writes ours.canon") but not an
argv/CLI shape. Two options: (a) pass explicit paths as CLI arguments, or (b)
zero arguments, fixed relative filenames, harness controls cwd. I chose (b)
because it is the smaller, more restrictive contract (nothing to get subtly
wrong about argument order or quoting across an OCaml/Verilog boundary), it
matches this repository's own precedent (`bin/generate.exe` takes no
arguments and writes fixed paths), and it composes cleanly with the hygiene
requirement — the harness already has to control the run directory for
`vvp`'s relative-path `$readmemh`/`$fdisplay` idiom (ADR-0015 D1 names this
idiom explicitly), so extending the same "cwd is the interface" discipline to
the OCaml side keeps one convention instead of two. This is a guess where the
packet is genuinely silent, so it is written down as a flagged assumption in
the script's own header and in the WO-'s Return log, not left implicit —
per the charter's "return ambiguity as written questions" duty, and because
"code against the pinned interface, not guesses" cuts against inventing an
argv shape and presenting it as settled.

The second decision was the exit-code map. The packet pins only "exit 0 = all
three checks passed; nonzero = failure, with the failing check named on
stdout" and ADR-0015 D1 separately pins "a skipped, absent or failed-to-install
simulator is never a PASS" and "a run summary must distinguish *ran and
agreed* from *did not run*". I read "distinguish ran from did not run" as
requiring more than a uniform nonzero on every failure — a CI consumer or a
future re-run script should be able to tell, from the exit code alone, which
of "the lane never started" (PREREQ), "the lane could not reach a verdict"
(BUILD), and "the lane reached a verdict and it was negative" (DIFFERENTIAL /
SELFTEST / DETERMINISM) occurred. Six distinct codes (0, 2, 3, 4, 5, 6, plus
9 for a harness-internal problem) cost nothing and make that distinction
mechanical rather than something only the log text carries.

The third decision, flagged rather than silently taken: `dune build`'s
ordinary `_build/` cache is allowed to land inside the checkout (it already
does, repo-wide, gitignored). WO-0046 §7.1 says "nothing is written inside
the repository checkout at any point", but its own enumeration is
`iverilog`/`vvp` output, VCDs, logs, the stimulus, and the canonical files
plus sidecars — the OCaml toolchain's build cache is not in that list, is
already `.gitignore`d, and is identical in kind to what every other `dune
build` invocation in this programme already leaves behind. Relocating it into
the `mktemp -d` as well would be free of downside but also free of any
benefit the existing `.gitignore` does not already provide, so I left it
where dune already puts it and recorded the reasoning rather than deciding it
silently.

### Actions

Wrote `tools/cosim/run_cosim.sh` (new file, `chmod +x`): checks
`iverilog`/`vvp`/`dune` on `PATH` (§ PREREQUISITES); reads the vendored
reference's pinned SHA from `test/third_party/verilog-ethernet/PROVENANCE.md`
and the simulator's version via `iverilog -V` and `dpkg-query`; builds
`stimulus_gen.exe`/`ours_run.exe`/`compare.exe` via `dune build` and the
`iverilog`-compiled reference+testbench sim binary into a `mktemp -d`
(§ BUILD); generates the Phase 1 stimulus once and reuses it for both runs
(§ STIMULUS); runs the pipeline (copy stimulus in, run `ours_run`, run `vvp`,
write both `.canon.meta` sidecars) into `run1/`, then invokes `compare` there
for check 4.1 (§ CHECK 1/3); invokes `compare --self-test` for check 4.2
(§ CHECK 2/3); repeats the pipeline into `run2/` and diffs `run1` against
`run2` byte-for-byte for both canonical files for check 4.3 (§ CHECK 3/3).
`trap 'rm -rf "$WORK"' EXIT` is installed immediately after the one
`mktemp -d` call, before any check runs, so it fires on every exit path
including every `die` call. On a differential or determinism failure, both
canonical files and both sidecars for every run directory implicated are
`cat` to stdout via a `dump_run` helper before the script exits (and before
the trap deletes them). Appended a Return log section to
`agents/handoffs/WO-0046_cosim-phase-1.md` (no existing Return log section
was present, so this is the first one) with the check sequence, the
exit-code map, the flagged interface assumption, the local test results, and
three open questions for tb_writer/dv_lead.

### Evidence

```
$ bash -n tools/cosim/run_cosim.sh && echo SYNTAX OK
SYNTAX OK

$ command -v iverilog vvp dune shellcheck   # before installing shellcheck
(no output — none present)

$ apt-get install -y shellcheck   # local dev-container action only, per
                                   # "try; report"; not a CI claim
...
Setting up shellcheck (0.9.0-1) ...

$ shellcheck tools/cosim/run_cosim.sh; echo "exit: $?"
exit: 0        # zero findings

$ ./tools/cosim/run_cosim.sh; echo "EXIT CODE: $?"
=== PREREQUISITES ===
  [FAIL] iverilog not found on PATH
  [FAIL] vvp not found on PATH
  [FAIL] dune not found on PATH

  ADR-0015 D1's standing rule: "A skipped, absent or failed-to-install
  simulator is never a PASS. No SO- packet may cite a run in which the
  co-simulation lane did not execute, and a run summary must distinguish
  *ran and agreed* from *did not run*." This is *did not run*: missing
  tool(s): iverilog vvp dune

run_cosim: FAILED CHECK: PREREQUISITES (missing: iverilog vvp dune)
EXIT CODE: 2

$ ls -d /tmp/run_cosim.* 2>&1 || echo "none left (cleanup via trap worked)"
none left (cleanup via trap worked)

$ grep -m1 'Pinned commit SHA' test/third_party/verilog-ethernet/PROVENANCE.md \
    | grep -oE '[0-9a-fA-F]{40}'
77320a9471d19c7dd383914bc049e02d9f4f1ffb   # matches the script's extraction logic
```

All four commands above were run in this container at this SHA and are
reproducible by anyone with the same checkout. The "everything present" path
(iverilog/vvp/dune all on PATH, `test/cosim/`'s executables and
`tb_xgmii_rx_64.v` built) was NOT run — no simulator is installable-and-usable
in a way I could exercise here beyond the `--self-test`-style installability
check ADR-0015 itself already performed for `iverilog`, and `test/cosim/`'s
sources do not exist in this checkout. That path's correctness is traceable
by review of the script only, as the task instructions anticipated.

### Outcome

DoD vs the task: `tools/cosim/run_cosim.sh` written, matches §2.1's contract
(single no-argument entry point, exit 0 iff all three checks pass, failing
check named on stdout); the three checks sequenced in §4's order; prerequisite
check present with a distinct exit code per ADR-0015 D1's skipped-is-never-a-
PASS rule; cleanup via `trap … EXIT` on every path, evidence dumped to stdout
on a comparison-class failure per §7.3; degraded path (no iverilog/vvp)
exercised for real, output captured verbatim above; full-toolchain path
traced by review only, as instructed, since `vvp` cannot run here. `shellcheck`
ran clean. Handed back via the WO- packet's Return log, appended after the
existing content (no tb_writer Return log section was present yet, so mine is
first).

### Open-questions

Three, all also recorded in the WO- packet's Return log for tb_writer/dv_lead:
(1) confirm or correct the zero-argument, fixed-relative-filename calling
convention this script assumes for `stimulus_gen.exe`/`ours_run.exe`/
`compare.exe`/`tb_xgmii_rx_64.v`; (2) confirm the bare `iverilog -o <bin>
<tb> <ref1> <ref2>` invocation (no `-g2012` or other flag) is sufficient once
`tb_xgmii_rx_64.v` exists; (3) confirm `dune build`'s ordinary `_build/`
cache landing inside the checkout (gitignored, not one of §7.1's named
artifact classes) is an acceptable reading of the hygiene rule, versus
relocating the whole OCaml build tree into the `mktemp -d` as well.

### Files-in-this-commit

- tools/cosim/run_cosim.sh
- agents/handoffs/WO-0046_cosim-phase-1.md

## [J-data_wrangler-0002] 2026-08-03T14:55:05Z | task:WO-0046 | run_cosim.sh round 2 — the sidecar ruling implemented, the real entry-point contract confirmed

### Trigger

Not a new spawn: the same session continued, with a mid-task message relayed
by the coordinator (no new "work-order id + spawn UTC timestamp" short-id was
minted for this continuation, so none is copied here — this is a course
correction inside `J-data_wrangler-0001`'s spawn, not a fresh one). The message
reported dv_lead's `RV-0046-VERDICT` (`aa51971`, ACCEPTED) ruling on the
`.canon.meta` sidecar's ownership (§5: producers write none; `run_cosim.sh` is
the sole writer; placeholders are barred; an undeterminable required field
fails the run) and directed four things: (1) implement the ruling — create both
sidecars in `run_cosim.sh` itself, gathering the pinned reference SHA,
`iverilog -V`/`vvp -V`, stimulus sha256, and runner image at run time; (2)
fail-closed on any undeterminable field, deciding and documenting the
runner-image field's behaviour outside CI; (3) decide the interaction with
`tb_xgmii_rx_64.v`'s own still-placeholder-writing sidecar code without editing
`test/**`; (4) re-run the degraded-path test and shellcheck, keep the exit-code
map current; append this entry and a round-2 Return log note.

### Inputs

- The coordinator's message, in full (quoted above by content, not verbatim
  reproduced here per the entry-body header-line rule, §4.1).
- `agents/handoffs/WO-0046_cosim-phase-1.md` at `aa51971` (full re-read via the
  `Read` tool this round, not merely `git show` — confirmed byte-identical to
  what I had inspected via `git show aa51971:…` earlier in this session) —
  specifically dv_lead's `RV-0046-VERDICT` §5 (the sidecar ruling, quoted
  verbatim in `run_cosim.sh`'s own header and in the Return log note) and §§2/4
  (the four question-deliverables' answers, for context on the landed
  `test/cosim/` sources' design).
- `test/cosim/dune`, `test/cosim/stimulus_gen.ml`, `test/cosim/ours_run.ml`,
  `test/cosim/compare.ml`, `test/cosim/tb_xgmii_rx_64.v` — all read in full this
  round (did not exist at `J-data_wrangler-0001`'s time; landed at `28e230d` by
  tb_writer, reviewed at `aa51971` by dv_lead). This is a `test/**` READ, not a
  write — my write scope is unchanged (`tools/*`, `agents/handoffs/*`); no file
  under `test/**` was staged or modified.
- My own `tools/cosim/run_cosim.sh` at `2c6a3ec` (round 1's committed version) —
  re-read via the `Read` tool before this round's edits, per the tool's own
  read-before-write requirement.
- `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` — NOT read, this round or
  the last, per the task's standing instruction and my charter's forever-scope
  exclusion.

### Reasoning

**The sidecar ruling was a design to implement, not a question to re-litigate**:
`RV-0046-VERDICT` §5 settles the ownership question definitively (ACCEPTED, not
PROPOSED), so this round's work was translating "producers write none; one
writer; placeholders barred; undeterminable fails the run" into code and its
own exit code, not deciding it afresh. The interesting design work this round
was in the DETAILS the ruling did not spell out, matching the standing "return
ambiguity as written questions, do not guess silently" duty:

1. **Which fields are REQUIRED vs advisory.** The coordinator's round-2
   instructions named `iverilog -V`/`vvp -V` as "the simulator version" to
   capture, without mentioning `dpkg-query`'s package version (which round 1
   carried, per ADR-0015 R-CI-3). I read the reproducibility guarantee's
   antecedent — "the recorded simulator version" — as being about the
   binaries that actually ran (the compiler and the runtime), not about the
   distribution's packaging of them, and kept `dpkg-query` advisory and
   ungated. This is a judgement call, flagged as an open question rather than
   asserted as settled, because the alternative reading (gate it too) costs
   one more `require_field` call if dv_lead disagrees.
2. **The runner-image field outside CI.** The coordinator's instructions
   explicitly posed this as a choice ("either the field accepts a well-defined
   local value… or local runs fail the sidecar check; pick the one that keeps
   the degraded local path meaningful"). I chose the well-defined-local-value
   branch, for the reason ADR-0015 D1 already gave me for free: it measured
   that "the local lane is genuinely usable," unlike the blocked OCaml lane,
   and a rule that makes a genuinely runnable local lane permanently unable to
   pass would spend that finding for nothing. `hostname`/`uname -srm`/
   `/etc/os-release`'s `PRETTY_NAME` are all facts, not guesses, about the
   actual machine — as legitimate a "runner image" identifier for a local run
   as `$ImageOS` is for a hosted one.
3. **A bug I found in my own first draft of that same runner-image
   composition, before returning it.** The first version used bash parameter
   expansion defaults (`"${host:-unknown-host}"`) to paper over EITHER of
   `hostname`/`uname` failing alone. Re-reading it against the very rule I was
   implementing, I recognised that a partial failure would silently embed a
   literal `unknown-host`-shaped token into a field this script then treats
   as a real, recorded value — precisely the failure mode dv_lead's ruling
   exists to bar, reintroduced by me one level down, inside my own fix for
   it. I verified this failure mode concretely (Evidence: tests B and C
   below) before fixing it, rather than trusting the reasoning alone. The fix
   composes the field ONLY from whichever sources actually succeeded, with no
   filler for the others, and only fails (matching `require_field`'s
   contract) when literally nothing is available. **Recorded as a finding
   against my own first draft, not smoothed over**, because the charter's
   "data-cleaning honesty" duty applies to a harness's own provenance logic
   exactly as much as to a dataset.
4. **The interaction with `tb_xgmii_rx_64.v`'s existing placeholder code.**
   Reading the landed file (§ Inputs) confirmed it still writes
   `theirs.canon.meta` itself, exactly as its own "Best-effort sidecar"
   comment (lines 263–276) describes — predating dv_lead's ruling, which
   supersedes it. Editing it would be the direct fix, but `test/**` is outside
   my write scope, so the only two honest options were "defeat it
   mechanically" or "leave the run silently exposed to whichever sidecar
   happened to be read last." `write_sidecar` already ran after both
   producers in round 1's ordering, for an unrelated reason (it needed both
   canonical files to exist first); the SAME ordering, unchanged, now also
   guarantees the overwrite wins over the Verilog placeholder — no reordering
   was needed, only recognising that the existing order already had this
   property and stating it explicitly instead of leaving it implicit.
5. **Reading `test/cosim/` before writing more of `run_cosim.sh` closed two of
   round 1's own open questions independently of the sidecar work**: the
   calling-convention assumption (question 1) and the `iverilog` flags
   question (question 2). This was not asked for in this round's task list,
   but the source now exists and reading it before touching the script again
   is exactly what "code against the pinned interface, not guesses" has meant
   since round 1 — and it surfaced a real, previously undetected bug (round
   1's `compare` invocation, zero arguments, which would have hit `compare`'s
   own usage branch and exited 2 on every real run without comparing anything)
   that would otherwise have shipped un-caught into the first CI run of this
   lane. Fixing a latent bug discovered while doing assigned work is not scope
   creep; leaving a known bug in place because it was not the day's explicit
   assignment would be.

### Actions

Modified `tools/cosim/run_cosim.sh` in place (round 1's version at `2c6a3ec`):
added `EXIT_PROVENANCE=7`; added `require_field()` and `runner_image()`
helpers; added a `PROVENANCE` section (after `PREREQUISITES`, before `BUILD`)
that determines and gates all four required fields plus the advisory
`dpkg-query` field; rewrote `write_sidecar()` to include
`simulator_vvp_version`, to conditionally omit the advisory field when empty,
and to document the single-writer/overwrite contract; changed the
`stimulus_gen`/`ours_run`/`compare` invocations from round 1's cwd-relative,
zero/omitted-argument calls to explicit absolute-path arguments, matching the
now-confirmed real contract (`compare` specifically: was zero args, now
`<ours.canon> <theirs.canon>`, fixing the bug in Reasoning item 5); kept the
`vvp` invocation's `cd`-into-run-directory unchanged (the one entry point with
no argv support); rewrote roughly two-thirds of the header comment to replace
round 1's "WHAT THIS SCRIPT ASSUMES" (speculative) with confirmed citations
against the landed sources, added the sidecar-ruling section quoting
`RV-0046-VERDICT` §5, and updated the exit-code table for code 7. Appended a
"Return log — round 2" section to `agents/handoffs/WO-0046_cosim-phase-1.md`
(pure EOF append, after dv_lead's `RV-0046-VERDICT`) covering all of the above
plus three round-2 open questions.

### Evidence

```
$ bash -n tools/cosim/run_cosim.sh && echo SYNTAX OK
SYNTAX OK

$ shellcheck tools/cosim/run_cosim.sh; echo "exit: $?"
exit: 0        # zero findings, same shellcheck 0.9.0 as round 1

$ ./tools/cosim/run_cosim.sh; echo "EXIT CODE: $?"
=== PREREQUISITES ===
  [FAIL] iverilog not found on PATH
  [FAIL] vvp not found on PATH
  [FAIL] dune not found on PATH
  ...
run_cosim: FAILED CHECK: PREREQUISITES (missing: iverilog vvp dune)
EXIT CODE: 2

$ ls -d /tmp/run_cosim.* 2>&1 || echo "none (clean)"
none (clean)
```

The `PROVENANCE`-section logic (unreachable in this container behind the
`PREREQ` gate) was extracted into an isolated harness — `require_field`,
`runner_image`, `write_sidecar`, copied verbatim by `sed` range out of the
committed script, sourced into a throwaway `bash -c`, never written into the
repository — and exercised directly:

```
--- test 1: local runner_image (no ImageOS set) ---
value: [local:vm Linux 6.18.5 x86_64 (Ubuntu 24.04.4 LTS)]  rc=0
--- test 2: CI runner_image (ImageOS + RUNNER_NAME set) ---
ci:ubuntu24 (gh-runner-1)
--- test 3: CI runner_image (ImageOS only) ---
ci:ubuntu24
--- test 4: require_field with a real value (should not die) ---
  (reached here => require_field did not die, correct)
--- test 5: require_field with empty value (should die with exit 7) ---
run_cosim: PROVENANCE — required sidecar field could not be determined: simulator_iverilog_version
  dv_lead, RV-0046-VERDICT §5: "An 'unknown (fill in:)' marker in an
  evidence artifact is worse than an absent file — ..."
run_cosim: FAILED CHECK: PROVENANCE (undeterminable field: simulator_iverilog_version)
subshell exit: 7

--- test B (bug hunt): hostname fails, uname succeeds -- must NOT contain "unknown-host" ---
[BEFORE FIX] would have printed: local:unknown-host Linux 6.18.5 x86_64 (Ubuntu 24.04.4 LTS)
[AFTER FIX]  value: [local:Linux 6.18.5 x86_64 (Ubuntu 24.04.4 LTS)]  rc=0
OK: no placeholder text in the field
--- test C: uname fails, hostname succeeds -- must NOT contain "unknown-kernel" ---
value: [local:vm (Ubuntu 24.04.4 LTS)]  rc=0
OK: no placeholder text in the field
--- test D: both hostname and uname fail, no os-release -- must return 1, empty ---
OK: returned 1, stdout empty: []

--- test 7: write_sidecar omits the advisory field when empty, includes it when present ---
== sidecar WITHOUT dpkg version (no simulator_package_version_advisory line) ==
(...9 lines, no such key...)
== sidecar WITH dpkg version (line present) ==
(...10 lines, simulator_package_version_advisory=12.0-2build2 present...)
```

(Test B's "[BEFORE FIX]" line is a reconstruction from the pre-fix function
body I had just replaced, run manually to confirm the bug was real before
claiming to have fixed it — not a run of code left in the repository at any
point; the shipped script never contained the buggy version at a commit
boundary, only within this uncommitted editing session.) All nine scenarios
plus the three script-level checks above were run in this container at this
tree and are reproducible by anyone with the same checkout and the same `sed`
extraction. The `iverilog`/`vvp`/`dune`-dependent path (BUILD, both real
`run_pipeline` calls, the corrected `compare` invocations against real
`.canon` files) remains traceable by review only — no simulator exists here,
unchanged from round 1.

### Outcome

DoD vs the round-2 task: sidecar ruling implemented (single writer, full
overwrite, `RV-0046-VERDICT` §5 quoted in the script's own header); all four
required fields gated via `require_field`, `EXIT_PROVENANCE=7` added and
documented; runner-image field decided for outside-CI (well-defined local
value, not a forced failure) and its own composition bug found and fixed
before return; the `tb_xgmii_rx_64.v` placeholder-sidecar interaction decided
(mechanical overwrite, `test/**` not touched, flagged for tb_writer) and
stated as such rather than silently assumed; degraded-path test and
`shellcheck` re-run, both clean; exit-code map kept current in the header.
Additionally, and not part of this round's explicit ask: the real
`test/cosim/` calling convention was confirmed against the landed sources,
closing round 1's open questions 1–2, and a real bug in round 1's `compare`
invocation (zero arguments against a binary that requires exactly two) was
found and fixed before it could reach CI. Handed back via a "Return log —
round 2" section on the WO- packet, pure EOF append after dv_lead's verdict.

### Open-questions

Three, all also recorded in the WO- packet's round-2 Return log: (1) whether
`dpkg-query`'s package version belongs inside the gated antecedent (currently
treated as advisory-only, per the coordinator's round-2 instructions naming
only `iverilog -V`/`vvp -V`); (2) `test/cosim/tb_xgmii_rx_64.v`'s now-dead
placeholder-sidecar code, flagged for tb_writer's next round, not fixed here;
(3) round 1's open question 3 (`dune build`'s `_build/` cache inside the
checkout, gitignored) — untouched by `RV-0046-VERDICT`, still open, repeated
rather than assumed resolved by silence.

### Files-in-this-commit

- tools/cosim/run_cosim.sh
- agents/handoffs/WO-0046_cosim-phase-1.md
