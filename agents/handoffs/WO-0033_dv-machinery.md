# WO-0033: The verification machinery — X-1 … X-11
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: your own machinery-gap register (J-dv_lead-0013,
  WO-0027 deliverable 4 — the X-1…X-11 list is yours verbatim); the
  two attack plans those gaps block (136 rows, now 0 RULING after
  e22e3f0); your charter's external-anchor precondition for golden
  models; C-23 (strobe high-cycle counting), C-45 (idle-injection
  lane-0 scope — your own wording), the WO-0031 injection scope note
  (REQ-016 injection moves the two lane-0-/S/ rows earlier, never
  onto the other report); the WO-0012 latency-tagger precedent.
- **Deliverables**:
  1. The eleven, under test/** (oracles in test/golden/), each
     derived from spec text alone — libs/** stays unread:
     X-1 link-partner error-injection catalogue (per-frame expected
     §9 outcomes); X-2 XGMII probe; X-3 strobe monitor (C-23
     counting, §9 pinned-cycle check, §0.6 window); X-4
     idle-injection wrapper carrying the M03-N3 constraint AS
     REPAIRED at 06c1eba and C-45's lane-0 scope; X-5/X-9 the
     per-frame output-extent repair on the latency tagger (one
     repair, two customers: M03 aborts, M14 padding); X-6 Axi64
     stream driver (from SPEC-M01's compile-checked records); X-7
     M08-output stimulus model composed from X-1's model; X-8 IPv4
     header builder + one's-complement checksum oracle, EXTERNALLY
     ANCHORED per your charter (name the authority and its vectors
     in the file); X-10 the OCaml D oracle beside
     tools/check_abort_availability.sh; X-11 M14's seven strobe
     cycles.
  2. dune-integrated: `dune runtest` exercises what can be exercised
     without RTL (oracle self-checks, model-vs-catalogue expect
     tests); state the expected CI outcome in your Return log
     (Build green is load-bearing — this is your largest OCaml
     sitting; ADR-0005 blind-writing discipline applies).
  3. Staging is yours: if one sitting risks the output cap, build
     the M03-critical core first (X-1…X-6, X-9) and RETURN with the
     remainder explicitly deferred and reasoned — a stated partition
     is a good return; a silent one is not. Incremental writes
     (≤~300 lines per tool call, one file complete before the
     next).
  - Journal **J-dv_lead-0017**; Files-in-this-commit exact.
- **Out of scope**: benches themselves (tb_writer WOs follow, on
  this machinery); libs/** (reading included); docs/** (spec gaps
  return as questions); tools/** except reading X-10's neighbour;
  committing. rtl_lead's two WO-0032 questions (§9 row 6 sub-5-octet
  `error_bad_fcs`; the /S/-lane-2 example) are architect-bound and
  deliberately NOT in this WO.
## Task
Everything the 136 rows need and do not have. You named these gaps;
now close them.
## Return / verdict log

### RETURNED — dv_lead, `J-dv_lead-0017` (WO-0033/2026-08-03T07:40Z)

**State: RETURNED, partial by the WO's own deliverable 3 — a stated
partition.**

#### 1. Built (8 of 11), and where

| Item | Home | Note |
|---|---|---|
| **X-1** | `test/xgmii/injection.{ml,mli}` + `test_injection.ml` | The catalogue **and** the §9 outcome model. Outcomes are **computed** by running §6.2's state machine and §9's closure list over the emitted octet-time line, not tabulated — so §6.1's two-events-in-one-word cases are ordinary, a frame the *stimulus* opens gets an outcome, and the cycles come from §7's per-octet constant and §9's no-output-word clause (both gap-invariant) rather than from `m + 3` |
| **X-2** | `test/xgmii_probe/` (new library `dv_xgmii_probe`) | Both directions: `to_refs`/`to_port` drive M03's input, `of_refs`/`of_port` sample M04's output |
| **X-3** | `test/monitors/strobe_monitor.{ml,mli}` + test | C-23 high-cycle counting; §9 pinned-cycle comparison; §0.6's window checked **against the pin itself**; "no strobe the stimulus created" |
| **X-4** | `test/xgmii/idle_injection.{ml,mli}` + test | §10's 0/1/7 cycles; **M03-N3 as repaired at `06c1eba`**; **C-45**'s lane-0 instances in `c45_sites`, released only by `~allow_c45:true` (default **false**); the WO-0031 scope note recorded as a one-directional property |
| **X-5 / X-9** | `test/monitors/octet_time.{ml,mli}` + test | One repair, two customers: `frame_out ?expected_octets` |
| **X-6** | `test/axi64_probe/axi64_driver.ml` + test | Stream driver + the `Eth_header` one-cycle pulse. `test/axi64_probe/dune` gains `(inline_tests)`, justified in the dune comment |
| **X-8** | `test/golden/ipv4_ref.ml` + `test_ipv4_ref.ml` | Builder + oracle. **Anchor: RFC 1071 §3's numerical example**, embedded with its citation — see §3 below |

#### 2. Deferred (3 of 11), with reasons

**X-7** (M08-output stimulus model), **X-10** (the OCaml D oracle) and **X-11**
(M14's seven strobe names and pinned cycles over X-3). All three are M14-side
*bench composition* over machinery that now exists, and each has a reason of
its own beyond output budget:

- **X-7** composes an M08 datagram stream from `Dv_xgmii.Frame` **and** from
  X-8's header builder. Building it before X-8's anchor is confirmed (§3) would
  bake an unconfirmed constant into the stimulus generator as well as the
  oracle, doubling the surface a bad citation touches.
- **X-10** is thirty lines of arithmetic already quantified **exhaustively**
  over all 8.7 M admissible (N, N′) pairs by `tools/check_abort_availability.sh`
  at every CI run. It is the *least* blocked item on the list: family A cannot
  run without RTL, and nothing is at risk from its absence today.
- **X-11** is a data table (seven names, three pinning rules) over X-3, which
  now exists and is tested. It needs SPEC-M14 §9's `error_ip_truncated`
  next-`hdr_valid` rule transcribed carefully, and transcribing a pinned cycle
  at the tail of the largest OCaml sitting this programme has had is how a
  wrong constant reaches a bench.

They are one short sitting, and they are M14's, not M03's. **No row of
`AP-xgmii_rx_64.md` remains blocked on machinery**; `AP-ip_eth_rx_64.md`'s
families A, B, E and J remain blocked on X-10/X-11 and its stress row on X-7.

#### 3. X-8's external anchor — named, embedded, and NOT yet discharged

**Authority: RFC 1071, "Computing the Internet Checksum", §3 "Numerical
Examples"** — the normative definition of the arithmetic SPEC-M14 §6.1
restates. Its octet string and both results are embedded in `ipv4_ref.ml` as
`rfc1071_example_octets` / `_sum` / `_checksum`, with two further RFC 1071
claims driven as checks (the residue form, and §2's byte-swap invariance,
which kills a halfword-endianness error that every palindromic vector
survives).

**What has not happened**: a re-fetch of RFC 1071's text to confirm the
quotation. This environment's proxy refuses `rfc-editor.org` and
`datatracker.ietf.org` with **HTTP 403** (both tried; see `J-dv_lead-0017`
Evidence item 7). The anchor is therefore **embedded and unconfirmed**, it is
recorded as such in the file and in `AP-ip_eth_rx_64.md`'s change log, and it
is an **open obligation on `SO-ip_eth_rx_64.md`**. Calling it discharged would
be the fabricated evidence ADR-0005 rule 2 exists to prevent. Cheapest closure:
one CI step, or one orchestrator fetch, comparing three constants.

#### 4. Finding against dv_lead's own attack plan — ledger **C-48**

Building X-8 proved that `AP-ip_eth_rx_64.md` row **M14-B3(a)** commissions a
stimulus that **does not exist**. Sub-case (a) asked for a header whose
ten-halfword sum needs *two* folds, to kill a 32-bit accumulator folded once.
Writing g(T) = (T mod 2^16) + ⌊T/2^16⌋ and f = g to a fixpoint: both preserve
T mod 65535; ten halfwords give ⌊T/2^16⌋ ≤ 9 so g(T) ≤ 0xFFFF + 9; a header
verifies iff f(T) = 0xFFFF, i.e. T ≡ 0 (mod 65535) with T > 0, whence
g(T) ∈ {0, 0xFFFF} and g(T) = 0 forces T = 0, which does not verify. So the two
arithmetics make the **same accept/reject decision on every 20-octet header**
and fold-once is unkillable at M14 *because it is not a defect there*.
Sub-case (a) is **withdrawn in place** (live guidance, this programme's own
rule), (b) carries the row and is now built by search, and
`Ipv4_ref.fold_once_divergence` runs the search every CI run and expects
`None`. **Third instance** of dv_lead's named failure mode.

#### 5. Expected CI outcome — read this before judging the run

- **`dune build @default`: expected GREEN.** This is the load-bearing claim and
  the one ADR-0005 makes CI authoritative for. Five new libraries' worth of
  files, blind-written; the two names that are new to this repository's proven
  API surface are `Bits.concat_lsb` and `Bits.width` (`test/xgmii_probe/`,
  `test/axi64_probe/axi64_driver.ml`). No integer constructor and no width
  argument is used to build a 64-bit value anywhere, deliberately: everything
  goes through `vdd`/`gnd` and `concat_lsb`, so a 63-bit `int` can never wrap a
  lane-7 octet. If the build is red, the likeliest single cause is one of those
  two names and the repair is confined to those two files.
- **`dune runtest`: expected RED on the first run, and that is the ADR-0005
  cadence, not a failure.** Every new `[%expect]` block is **EMPTY on purpose**
  (ADR-0005 rule 2: snapshots are promoted from CI's own diff output, never
  authored by hand). The first run prints the PROMOTION BLOCK; after promotion
  the second run is expected green. Every verdict in every new test is asserted
  **in OCaml** — `check`/`expect_int` raise or `failwith` — so a promotion that
  captured wrong output still leaves a red test. There are no waveform
  snapshots and no timing figures in any new block.
- **`tools/dv_checks.sh` and `tools/check_abort_availability.sh`: unchanged and
  expected green.** `tools/**` was not written (out of scope);
  `check_abort_availability.sh` was read only, as X-10's neighbour.
- **`bin/generate.exe`: untouched.** No `libs/**`, no `top/**`, no `docs/**`.

#### 6. Scope statement

Staged paths are `test/**` and this packet only (PROTOCOL §6). `libs/**` was
not opened at any point in this sitting, including for the Axi64 driver —
SPEC-M01 §4.1's lift under `docs/specs/ifc_check/` is its whole source, as the
file records. No benches were written (out of scope); this is the machinery
benches will be written against, and the tb_writer work orders that consume it
are the next packet.
