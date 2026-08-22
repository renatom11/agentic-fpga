# WO-0085: M04 cfg_ifg gap axis — commission the configuration-coverage benches (M04-F3, M04-F7) that close WO-0084-S2

- **State**: ISSUED — number **ALLOCATED as `WO-0085`** (orchestrator,
  `J-orchestrator-0308`, 2026-08-22, PROTOCOL §3). Re-measured at allocation:
  the highest committed packet id is this file's own, and
  `ls agents/handoffs | grep -c 'WO-0085'` → 1 (the draft itself, no other
  claimant), so the placeholder id stands and **no internal self-reference
  moves** — the §7 T-8 citation in `AP-xgmii_tx_64.md` and the
  `J-dv_lead-0197` change-log row already read `WO-0085` and are correct as
  written. Drafted DRAFT by dv_lead at `J-dv_lead-0197`; the draft's
  placeholder note is superseded by this allocation, its text preserved in
  that journal entry.
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: SPEC-M04 §6.1 (the gap paragraph and the identity
  `g = ⌈(cfg_ifg + t)/8⌉` words, gap `8g − t` octets), §9 (the abort word and
  *"the gap is then served from that terminate character"*), §4.2/§4.3
  (`cfg_ifg`), requirements.md §9.1 (`cfg_ifg ≥ 12` — values below 12 SHALL NOT
  be driven); **REQ-204, REQ-206, REQ-802**; `AP-xgmii_tx_64.md` rows **M04-F3**
  and **M04-F7** (row TEXT only), the §4 arithmetic identity, the §2 standing
  obligations, and §7 item **T-8**.
- **Deliverables** (all inside `test/**`, tb_writer's write scope):
  1. **The `cfg_ifg` knob (T-8).** A way for a unit to drive `cfg_ifg ≠ 12`
     through `test/xgmii_tx_64/bench.ml`'s driver, with the `Tx_decoder`
     constructed `~ifg:<the driven value>` so its standing REQ-204 gap-legality
     arm tracks the configured gap rather than the hard-wired 12. The **default
     path (`cfg_ifg = 12`) must stay byte-identical** so the 39 discharged rows
     and every pre-existing unit are unperturbed — `git diff` on their
     `[%expect]` blocks must be empty. `bench.ml`'s own run-length note warns
     that a round changing `cfg_ifg` must **re-derive** the `g_max` cycle bound;
     do that from the identity, per member.
  2. **A unit discharging `M04-F3`** — the normal-gap sweep.
  3. **A unit discharging `M04-F7`** — the abort-gap sweep.
  4. **The `M04-F6` correction (WO-0084-S1's second site).** In
     `test/xgmii_tx_64/test_m04_f.ml`, strike/rewrite the `M04-F6` comment and
     failure-message that quote *"16 is one octet from conformant"*: the abort
     defect the row's `= 15` assertion actually kills is a **whole-word** error
     (a recorded gap of 7 or 23), and **16 is not a gap this decoder can record
     after an abort** — every abort gap is `8k − 1`, i.e. `≡ 7 (mod 8)`. Cite
     `WO-0084-S1` and `AP-xgmii_tx_64.md`'s corrected `M04-F6`. This does not
     change the assertion (`= 15` stands); it corrects the explanatory text so
     the failure path cannot itself quote the unreachable figure.
- **Definition of done**: `M04-F3` and `M04-F7` asserted and green under
  `dune runtest`; `git diff --exit-code` clean (no unpromoted / non-deterministic
  output); the `cfg_ifg = 12` path unchanged for every pre-existing unit; the
  `M04-F6` message corrected; a worker journal entry appended (Trigger carrying
  the spawn short-id); no doc impact beyond `test/**`.
- **Context provided** — the two row texts, the identity, and the bench's public
  interface. **RTL source is DELIBERATELY OMITTED**:
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` is NOT attached and MUST NOT be
  opened (PROTOCOL §10; DV independence — tests derive from spec, never from
  RTL). Every expected value below is derived from SPEC-M04 §6.1's identity, not
  from the design; a leaked-RTL violation would be visible in the worker's
  journal Inputs. The interface files you MAY read: `test/xgmii_tx_64/bench.mli`,
  `test/xgmii/tx_decoder.mli`, `test/xgmii_tx_64/test_m04_f.ml` (the family-F
  units, for style and to site the M04-F6 correction), and `AP-xgmii_tx_64.md`.
  - **M04-F3** (already an ASSERT row in the plan — you are giving it its bench,
    not authoring it): Stimulus — `cfg_ifg ∈ {12, 13, 16, 20, 255}`, each with a
    normal frame terminating at `t = 0`, the value stable from well before the
    terminate character. Observable — `g = ⌈cfg_ifg/8⌉` words, gap `8g` octets:
    **16, 16, 16, 24, 256**. Kills — a design reading `cfg_ifg` as a *word* count
    (at 20 it serves 160 octets); a design ignoring `cfg_ifg` and hard-wiring 16,
    which the default hides (12, 13 and 16 all give 16, so the default cannot
    distinguish a configurable design from a fixed one, and **20 is the smallest
    member that can**); a design saturating an 8-bit accumulator at 255.
  - **M04-F7** (added this round): Stimulus — an underflowed frame (family G's
    stall stimulus; §9's terminate character is the `/T/` at **lane 1**, `t = 1`)
    followed by a normal frame, swept over `cfg_ifg ∈ {12, 16, 24}`, each value
    stable from well before the abort word. Observable — `Tx_decoder.gaps` has
    **exactly one** abort-gap entry (assert the list length first), of
    `g = ⌈(cfg_ifg + 1)/8⌉` words and `8g − 1` octets: **15, 23, 31**; next start
    character in lane 0. Kills — the IC-10 / ABORT-GAP-FROM-`/E/` design that
    measures from the `/E/` in lane 0 (`t = 0`): it records `8·⌈cfg_ifg/8⌉ − 1` =
    **15, 15, 23**, identical to conformant at `cfg_ifg = 12` and a **whole word
    short** at 16 and 24 (15 vs 23, 23 vs 31); and a design hard-wiring the abort
    gap. Assert the gap **exactly** (`= 15/23/31`), never `≥ cfg_ifg` — a
    `≥`-only check is green against the defect.
- **Out of scope**: RTL of any kind; the abort **word shape** (family G's rows
  own `/E/`/`/T/`/`/I/` placement — do not re-assert it here); the controllable-
  handover machinery (`T-7`, family H's — NOT needed, abort-then-normal is
  `run_stream` / `run_scheduled`'s existing shape); the DIC / average-gap
  question (`M04-F4`/`M04-F5` own it); `WO-0083`'s stage-2 revision items.

## Task

Build the `cfg_ifg` axis for M04. Two coverage gaps a mutation campaign
(`WO-0084`) demonstrated are closed by one instrument: the suite never drove any
`cfg_ifg` but 12, so a *gap-ignores-ifg* mutant (`class-11`) survived the whole
campaign on the normal path, and its abort sibling (the sealed `IC-10`) could not
be scored at all. `M04-F3` and `M04-F7` are the plan's two rows for it; both need
the harness able to present a configured gap other than the default (§7 `T-8`),
which no committed producer can do today.

1. Add the `cfg_ifg` knob (Deliverable 1), keeping the default path byte-exact.
2. Write the `M04-F3` unit (normal gap, five members).
3. Write the `M04-F7` unit (abort gap, three members) — the abort stimulus is
   family G's stall producing a `/T/` at lane 1, followed by a normal frame; the
   discriminating members are `cfg_ifg ∈ {16, 24}` (the `/E/`-vs-`/T/` reading
   separates by a whole word there), with `cfg_ifg = 12` carried as the control
   that shows the class is invisible at the default.
4. Correct the `M04-F6` comment/message (Deliverable 4) — the `= 15` assertion
   stays; only the text that quotes *"16 is one octet from conformant"* is fixed.

Assert each list's **length first** (a two-gap run must not pass a one-gap
check), and assert the gap value **exactly**. Derive every cycle bound and gap
value from SPEC-M04 §6.1's identity per member — do not carry the `cfg_ifg = 12`
figures forward.

## Return / verdict log

(appended on RETURNED / ACCEPTED / BOUNCED, with journal-entry refs)

### RETURNED — tb_writer, spawn `WO-0085/2026-08-22T04:45Z`, `J-tb_writer-0047`

**0. Precheck.** `git status --short` → empty. `git rev-parse HEAD` →
`8ab9d70b8c6b19938d13d8b19800f162e9027d81` — matches the dispatch's expected
prefix `8ab9d70`. Proceeded.

**1. Deliverables, each traced.**

1. **The `cfg_ifg` knob (T-8).** `Bench.t` gains an `ifg : int` field;
   `create` gains `?(ifg = 12)`, drives `i.cfg_ifg` with it (reset cycle and
   every `sample_cycle` choke point, reading `t.ifg` rather than a
   hardcoded `12`), and constructs the standing decoder
   `Tx_decoder.create ~name:"M04 tx" ~ifg ()`. `run_stream` and
   `run_scheduled` each gain the same `?(ifg = 12)`, threaded to `create`
   and to a new `g_max ~ifg` helper (`⌈(ifg+7)/8⌉`, the per-frame cycle
   allowance's own worst-case-lane bound) that `cycles_for_run` and
   `cycles_for_scheduled_run` are now expressed over, replacing the
   hardcoded `3`/`4` constants those two functions carried. At the default
   `ifg = 12`, `g_max ~ifg = 3` and every arithmetic term is
   byte-identical to what those two functions computed before this round —
   `bench.mli` documents the same default on every changed signature.
   `wire_frames`' own **content-reader** decoder is left at its existing
   hardcoded `~ifg:12` deliberately (out of scope per the packet's own
   text — "its standing REQ-204 gap-legality arm", i.e. `t.decoder`, is
   what T-8 names; the content reader is a structural-fact reader, never
   checked for cleanliness, and the driven gap is always >= 12 in every
   member this round drives, so it raises no spurious violation).
2. **`M04-F3`** — `test_m04_f.ml` unit U28, five members (`cfg_ifg` ∈
   {12, 13, 16, 20, 255}), `run_stream ~ifg` over two `P = 60` frames.
   Asserts instruments clean at `frames:2`; both frames' `t = 0`
   (corroboration); `Tx_decoder.gaps` length 1 (asserted first) then the
   exact value per member (16, 16, 16, 24, 256); frame 2's `start_cycle`
   at `C + 10 + g` (a second, independent reading of the same fact).
3. **`M04-F7`** — `test_m04_f.ml` unit U29, three members (`cfg_ifg` ∈
   {12, 16, 24}), `run_scheduled ~ifg` with `M04-F6`'s own stall shape
   (`frame=0, word=4, hold=1, Abandon`) — unchanged deliberately, per
   `AP-xgmii_tx_64.md`'s rejection (c). Asserts the standing instruments
   (one strobe at its own pin, frame 0 underflowed, two frames complete);
   `Tx_decoder.gaps` length 1 (asserted first) then the exact value per
   member (15, 23, 31, never `>= cfg_ifg`); the abort word's own `/T/` at
   lane 1 of cycle `A` (independent of `cfg_ifg`); the next start
   character in lane 0 at cycle `A + g`.
4. **The `M04-F6` correction.** Three sites in `test_m04_f.ml` corrected
   (the file's own top-of-file `M04-F6` addendum docstring, the code
   comment above Assertion 3, and Assertion 3's own failure-message
   string) — all quoted or paraphrased the now-false *"16 is one octet
   from conformant"* claim. Replaced with: the defect the `= 15` assertion
   kills is a **whole-word** error (7 or 23), every abort gap this decoder
   can record is `8k - 1` (`≡ 7 mod 8`), so 16 is unreachable, and the
   `/E/`-vs-`/T/` design is **invisible** (not "one octet away") at
   `cfg_ifg = 12`, visible only from `M04-F7`. The `= 15` assertion
   itself: byte-unchanged. Cites `WO-0084-S1` and `AP-xgmii_tx_64.md`'s
   corrected `M04-F6` row, per the packet's own instruction.

**2. `dune runtest` — NOT RUN, local execution is structurally blocked in
this environment; disclosed in full, not summarized.** Two install
attempts, both exhausted honestly:

- Attempt 1, existing `fpga` switch (OCaml 4.14.1 system): `opam install .
  --deps-only --with-test --yes` → `[ERROR] No agreement on the version of
  ocaml`: `hardcaml_axi >= v0.17` requires `ocaml >= 5.1.0`, the switch's
  own invariant pins `ocaml-system 4.14.1`. Matches CI's own pin
  (`.github/workflows/build.yml`: `ocaml-compiler: "5.1"`) and that
  workflow's own comment: *"The development container's network policy
  blocks opam package downloads (see ADR-0005), so CI — not a developer
  machine — is where OCaml correctness is established."*
- Attempt 2, a freshly created `fpga51` switch (OCaml 5.1.1, matching CI):
  `opam install . --deps-only --with-test --yes` → `curl error code 403`
  on every package fetch (hardcaml, core, ppx_hardcaml, ppx_expect, …).
  Per `/root/.ccr/README.md`'s own instruction for this exact failure
  class ("403 / 407 from the proxy: … Do not retry or route around it —
  report the blocked host"), I stopped there rather than attempting a
  third route, and removed the unusable `fpga51` switch afterward
  (environment-only cleanup, no repo files touched).
- This matches `test/xgmii_tx_64/dune`'s own pre-existing header note
  (unedited by this round, quoted for the record): *"this directory is
  EXCLUDED from [the STUBBABLE precompile] harness by construction and
  CI's `dune build @default` is the only compiler that reaches it
  (ADR-0005)"* — i.e. this is this directory's documented, standing
  verification posture, not a defect this round introduced.

**Substitute local verification actually performed** (evidence, not a
claim of `dune runtest` green):

- `ocamlc -stop-after parsing -dsource` (the base 4.14.1 compiler, no
  Base/Core/Hardcaml needed — parsing skips type-checking and module
  resolution) on all three touched `.ml`/`.mli` files: `bench.ml`,
  `bench.mli`, `test_m04_f.ml` — **exit 0, parsed end to end**, on every
  edit including the final one. Rules out mismatched parens/brackets,
  malformed matches, and malformed `let%expect_test`/`[%expect]` syntax.
- Every expected value re-derived from SPEC-M04 §6.1's identity by hand,
  twice, and cross-checked a third way: my generalised formulas
  (`s2_off = 10 + g` for F3's `t = 0`; `s2 = A + g` for F7's `t = 1`)
  independently **reproduce** `M04-F1`'s and `M04-F6`'s own
  already-landed results (gap 16 / `C+12`; gap 15 / `C+8`) exactly at the
  `cfg_ifg = 12` control member — the generalised code collapses onto the
  pre-existing, presumably-CI-green code's own values at the point where
  they must agree.
- The re-derived `g_max` cycle bound checked by hand for every one of the
  eight sweep members (below) — every one has comfortable slack (tens of
  cycles), never a tight or insufficient bound.
- A real defect self-caught before landing: my first-draft unit labels
  (`U27`/`U28` in the file's own `(* ---- U<n>: ... *)` convention)
  collided with `U27` already claimed by `M04-A4` (`test_m04_a.ml`,
  WO-0083). Found by grepping every `test_m04_*.ml` file's own unit
  markers across the whole directory (not just this file); renumbered to
  `U28`/`U29`, the next free slots after the highest existing (`27`).
- Record-field disambiguation: `f3_member`/`f7_member` share field names
  (`ifg`, `gap`) with the pre-existing `f2_member` and with each other;
  every access site already carried a type-annotated parameter
  (`(m : f3_member)` / `(m : f7_member)`, matching `f2_member`'s own
  precedent), and I added explicit `: f3_member list` / `: f7_member
  list` annotations on the two members lists defensively, removing any
  reliance on OCaml's default disambiguation heuristic.

**`git diff --exit-code`**: not meaningful without a `dune runtest` run to
diff against (nothing to promote). `git status --short` at this entry's
own commit point is limited to the four files below, confirmed.

**3. Re-derived `g_max` bounds used, per member** (§T-8's own run-length
warning; `g_max ~ifg = (ifg + 14) / 8` in integer division, i.e.
`⌈(ifg+7)/8⌉`, the worst-case-lane bound `cycles_for_run` /
`cycles_for_scheduled_run` budget against):

| Row | `cfg_ifg` | `g_max` | `cycles_for_run` / `_scheduled_run` total | Byte-identical to pre-WO-0085? |
|---|---|---|---|---|
| F3 | 12 | 3 | 51 | yes (F1/F2's own established 51) |
| F3 | 13 | 3 | 51 | new |
| F3 | 16 | 3 | 51 | new |
| F3 | 20 | 4 | 53 | new |
| F3 | 255 | 33 | 111 | new |
| F7 | 12 | 3 | 47 | yes (F6's own established 47) |
| F7 | 16 | 3 | 47 | new |
| F7 | 24 | 4 | 49 | new |

**4. Files touched** (set-equal to `git status --short`, this entry's own
journal excluded): `test/xgmii_tx_64/bench.ml`, `test/xgmii_tx_64/bench.mli`,
`test/xgmii_tx_64/dune`, `test/xgmii_tx_64/test_m04_f.ml`.

**5. Deviations / self-disclosed instrument use.** Two opam install
attempts and one new opam switch created and removed (§2) — environment
operations, no repo file touched by either, disclosed above and in the
journal entry's Actions section. No RTL read (`libs/**`, `top/**`,
`rtl_snapshots/**`, `bin/**` — none opened; confirmed in the journal's
Inputs section). No ambiguity found in the spec requiring a written
question — every value in this packet's own Context section re-derived
cleanly from SPEC-M04 §6.1's identity with no residual disagreement.

**6. Verdict**: none claimed — PASS/FAIL is dv_lead's `SO-`; this entry
asserts only that `M04-F3` and `M04-F7` are named, spec-derived, and
present, and that `dune runtest`'s own verdict is CI's to render, per
ADR-0003/ADR-0005.
