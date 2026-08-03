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
