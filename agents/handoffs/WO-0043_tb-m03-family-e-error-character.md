# WO-0043: Family E — the error character inside a frame (REQ-105)

- **State**: DRAFT (id assumes WO-0043 is next free; orchestrator allocates)
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's `Frame` row
  and its `/E/` exit, §6.3, §9 (row 2, the closure list, the strobe-cycle pin
  including its **no-output-word clause**), §0.6, §0.7;
  `docs/specs/requirements.md` REQ-105, REQ-103, REQ-113, REQ-007, REQ-013,
  REQ-008.
  Attack-plan rows: `AP-xgmii_rx_64.md` **§4.E** — **four rows**, M03-E1, E2,
  E4 (ASSERT) and E3 (NO-ASSERT). **Family letter confirmed against §4: E is
  the error character; D was the FCS check.**
- **Deliverables**: `test/xgmii_rx_64/test_m03_e.ml`, plus any bench addition
  §4 authorises and nothing else.
- **Base**: current HEAD's bench, which is family-D-qualified. The existing
  twelve `%expect_test` units must all stay green and none may be modified.

## 1. Why this family now, and a correction that unblocks it

Family E is the first **error path** in M03 to be benched. Everything to date —
families A, B, C, D — drives frames that complete normally. Nothing in the
twelve units has ever seen a frame **aborted mid-flight**, and REQ-105 is
therefore unverified in both directions exactly as REQ-104 was before WO-0040.

**And a correction, because it decides whether you can start.** At
`J-dv_lead-0037` I wrote that families E–H "lean on X-1's computed outcomes and
are therefore gated on the co-sim for sign-off purposes". **That is too broad,
and family E is not gated.** The distinction I missed is between X-1's two
halves:

- **`Injection`'s placement and corruption machinery** — putting an `/E/` at a
  chosen octet time — is *stimulus generation*. Using it is fine.
- **`Injection`'s computed `outcome` and `report` values** — what §9 says
  becomes of the frame, and on which cycle — is the **model** WO-0033's standing
  limit refers to, and **no `SO-` PASS may rest on it until the differential
  co-sim has run** (`WO-0044`).

**All four of family E's rows are hand-derivable from §9 and §6.1.** So:

> **Binding instruction.** Derive every expected value **by hand from the
> specification**, and use `Injection`'s computed `outcome`/`report` **only as a
> cross-check that you report**. Where the two disagree, that is a finding for
> me — possibly against the model — never something to resolve by adopting the
> model's answer. A row whose expected values come from the model is
> co-sim-gated and cannot carry a sign-off; a row that hand-derives them is not.

## 2. The four rows, each with its sampling and dependency declaration

### M03-E1 — `/E/` in each of the eight lanes of a mid-frame word (ASSERT)

Eight `/E/` positions across one mid-frame word of a 64-octet frame, at a
lane-0 start, repeated at a lane-4 start: **sixteen cases**.

Expected, per §9 row 2 and REQ-103's no-removal clause: the last delivered octet
is **the one immediately preceding the `/E/`** — the REQ-106 rule with `/E/` in
place of `/T/`, so an `/E/` in **lane 0** means the *previous* word carried the
last octet; `tkeep` marks exactly those octets; `tuser`[0] = 1 on the `tlast`
word; **exactly one `error_bad_frame`, on the `tlast` cycle**, and no other
strobe; and — the row's own point — **no FCS removal**: the four octets before
the error character **are** delivered.

**Sampling declaration.** The `/E/`-in-**lane-0** sub-case has its closing word
carrying **no frame octets**, so §6.2's `Frame` row **holds** the frame and that
word produces no output — structurally the same shape as a terminate in lane 0.
The other seven sub-cases close in a word that carries frame octets. **State,
per sub-case, whether the final delivered word is full**, because a lane-0
closure with a full final word is R-1's disagreement class and the bench samples
`~clock_edge:Side.Before` precisely so it remains visible. No E1 sub-case
depends on an age-0 record for *visibility*; the declaration is still owed.

**X-1**: placement only. **Hand-derivable. Not co-sim-gated.**

### M03-E2 — `/E/` at the frame's first octet position (ASSERT)

Zero delivered octets. Expected: **no output word at all**; exactly one
`error_bad_frame`, on the cycle **two after the input word carrying the `/E/`**
— §9's **no-output-word clause**, which is a pin in its own right and **not** a
corollary of `m + 3`.

**This row is where the arming-reading boundary I ruled at `J-dv_lead-0046`
becomes live, and it is the most likely place in this packet to write something
wrong.** SPEC-M03 §4.1 makes `rx_tuser`[0] *"meaningful only on the `tlast`
word"*, and this frame has no `tlast` word. Therefore:

> **M03-E2 must assert NOTHING about `tuser`[0].** Not that it is 0, not that it
> is 1, not that it is anything. There is no word for the bit to live on, and the
> frame's entire report is its **strobe**. An assertion on `tuser` here would be
> reading a field on a `tvalid` = 0 cycle, which standing obligation 6 forbids
> outright.

**X-1**: placement only. **Hand-derivable. Not co-sim-gated.**

### M03-E3 — the bench-side rule for E2's frame (NO-ASSERT)

Not a design property. A monitor asserting "every abort is marked on a `tlast`
word" **must not be driven for E2's frame** — REQ-105's own verification column
says so, and §0.6 accounts for the frame by its **strobe** instead.

**Declare it and honour it.** In practice this means E2's frame is accounted to
the conservation monitor through its strobe path, never through the
clean-frame/abort-marked path. If the existing monitor surface makes that
awkward, **return the question rather than driving the monitor anyway** — a
monitor driven where the plan forbids it is a false green, not a strictness.

### M03-E4 — `/E/` after a terminate character, in the gap (ASSERT)

Expected: nothing emitted, **no strobe of any kind**, and the following frame
received intact.

**This is a negative assertion and negative assertions are the vacuity-prone
kind, so its stimulus must be verified rather than assumed.** The check has real
content only if an `/E/` is genuinely placed in the gap; if the injection
silently failed to land, the row passes against everything. **Assert that the
`/E/` is present in the emitted word at the intended cycle**, from the schedule's
own words, before asserting that nothing was reported.

**X-1**: placement only, two frames. **Hand-derivable. Not co-sim-gated.**

## 3. The two defect-shape re-reads, done — findings and what they leave you

`RV-0041-VERDICT` ordered every unwritten family re-read for two shapes before
being benched. Family E is clear on both, and here is the work so you can check
it rather than trust it.

**Shape 1 — vacuous stimulus** (M03-D3's original defect: a stimulus that cannot
discriminate the design it names). E1's kill — a design applying FCS removal on
the abort path — shows up as **four octets too few** at every one of the sixteen
cases, so the octet-count assertion discriminates it everywhere. E2's kill — a
design emitting a `tkeep` = 0 word or a preamble-octet word "to have somewhere to
put the abort bit" — shows up as **a word existing where none should**. E4's kill
— an `/E/` handler not gated on frame-open — shows up as **a strobe pulsing where
none should**. All three discriminate. **No vacuity.**

**Shape 2 — unachievable kill** (M03-D3's second defect: a declared kill that is
behaviourally indistinguishable from the correct design, "worse, because it
survives review by looking specific"). Each of the three kills above is a
*directly observable* difference — an octet count, a word's existence, a strobe's
existence — not a claim about internal realisation. **None is a D-M3 shape.**

**What that leaves you**: family E's declared kills are sound, so unlike family
D you are not building against a row whose stated purpose is about to be
withdrawn. If you find otherwise while writing, **say so** — I have been wrong
about a row twice and would rather be told a third time than have CI tell me.

## 4. Machinery, and the stimulus trap you must settle first

`test/xgmii/injection.mli` (X-1) is the error-injection catalogue: `placement`
(preamble position, frame octet offset, the terminate position), `corruption`
(bit flip, **`Place_control`** for putting `/E/`, `/S/` or `/T/` at a chosen
position), `clean`/`corrupt`/`frame_of_length`, `create ?ifg ?first_start
?first_lane cases`, and `schedule : t -> Arrival.t`.

**The trap of the `fcs_valid` class, which you must establish and report before
building anything on it.** `Injection.schedule` yields an `Arrival.t`, and
`Bench.run` discharges obligation 5 by calling `Arrival.check`. Family E's
corruptions are **`Place_control`, not FCS corruptions — the frames' FCS octets
are untouched.** Three questions, answered from `injection.mli` and
`arrival.mli` and reported in your Return log:

1. Does `Injection` clear `fcs_valid` on the schedule for a **control-character**
   placement? It should not need to; if it does, the residue check is switched
   off for frames that still carry a correct FCS, and you must assert
   `Frame.residue_ok` by hand as WO-0040 §3.2 required.
2. **Does `Arrival.check` accept a schedule whose frame is closed early by an
   `/E/`?** Its gap arithmetic is measured from the terminate character. A frame
   aborted mid-flight never emits one. **This is the likeliest trap in the
   packet** and it decides how E1's sixteen cases can be scheduled at all.
3. For M03-E4, is an `/E/` placed *after* a frame's terminate expressible as a
   `corruption` on that frame, or does it need a placement relative to the
   schedule rather than to a frame?

**If any answer requires a bench or `Injection` addition, return the question
before adding anything.** WO-0040 authorised exactly one addition and it cost no
review round; an unbudgeted one costs at least one.

## 5. What you may NOT read

- **Never open `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**`** — any path,
  manifests included. Scope every `grep` to `test/` and `docs/specs/`.
- Derive every expected value from **SPEC-M03 and requirements.md**, never from
  the design, and never from `Injection`'s computed model (§1).
- **Third-party sources at the opam switch (`/root/.opam/**`) are readable** for
  signatures and semantics, and every such read must be listed by path in your
  journal `Inputs`.

## 6. Expected-CI discipline — the regime facts already paid for

1. **ADR-0005: no toolchain reaches this directory.** CI is authoritative. Mark
   anything uncompiled **UNVERIFIED** and never call a prediction a fact.
   `tools/precompile_check.sh` **structurally excludes** this directory; its
   green is not a type-check and must not be reported as one.
2. Warning string `-w @1..3@5..28@30..39@43@46..47@49..57@61..62-40
   -strict-sequence`: warning **9** (missing record fields) and **33** (unused
   open) are **fatal**; 69 is not enabled; **alerts are errors**, so `Base`'s
   `mod` is unusable — use **`Int.rem`**.
3. A record pattern gets no type-directed label resolution from an unannotated
   scrutinee. Annotate or qualify.
4. `Base.List.init` evaluates `~f` from the highest index **down**.
5. **Promotion discipline.** Every `[%expect]` block stays empty; a passing test
   prints nothing. **Never harvest a promotion.** A `runtest` diff is a finding
   to report, not a snapshot to accept.
6. **Nothing timing-derived may be snapshotted.** Assert in code.
7. **Run a guard against the defect it names before shipping it.**
8. **Trace a change against the code it will run beside.**
9. **Provenance rule**: any quantity you state — a unit count, a row count, a
   cycle — carries its provenance: **measured** (with the command), **derived**
   (with the derivation), or **relayed** (with the source named). A relay is not
   a measurement. `tools/dv_checks.sh` prints the bench inventory if you need it.

## 7. What I expect back

A Return log appended to this packet plus your journal entry. **Do not write an
`SO-`.** Structure it as WO-0040's: row disposition with no silence; what you
changed with file and line; **every derivation with its spec section cited**;
anything UNVERIFIED with the reason; expected CI labelled as prediction; open
questions; and a scope statement with `git status --porcelain`, `git diff
--exit-code` on files you claim untouched, an explicit no-forbidden-path line,
and every `/root/.opam/**` read.

**Include the §4 trap answers explicitly** — they are a deliverable, not
background.

## 8. Family E's mutation qualification — defect classes named, row mapping SEALED

Family E will be qualified by a blinded mutation campaign under the WO-0041
protocol. **This packet names the defect classes so you write against them; it
does NOT tell you which rows are predicted to catch which** — that mapping is
sealed before any diff exists.

This is a deliberate change from WO-0040 §9, which published the
mutation → row table. That was right for the bench and it cost the campaign: it
made "which row dies" public for four of five mutations. The compromise, which I
left myself at `J-dv_lead-0040` and am now taking: **you need to know which
defect classes must be caught; you do not need to know which of your rows will
catch them.**

The classes:

| | defect class |
|---|---|
| **E-c1** | FCS removal applied on the abort path (REQ-103 forbids it) |
| **E-c2** | an output word emitted for a frame that must produce none |
| **E-c3** | the abort strobe pulsed on the wrong cycle — the `/E/` word's, rather than §9's pin |
| **E-c4** | the `/E/` handler not gated on frame-open, so it reports a frame already closed |
| **E-c5** | a *silently-always-pass* class: the abort condition detected but never reported at all |

**E-c5 is named last and matters most**, for the reason D-M1 did: a mutation
that agrees with everything the existing suite asserts is the one no prior
campaign can find, and REQ-105's positive direction is unverified today exactly
as REQ-104's was. **A row set that does not die on E-c5 has closed nothing.**

## 9. What this packet does not do

`SO-M03` does not issue on family E. After it, 17 of the plan's 59 ASSERT rows
would be discharged. Families F, G and H remain unwritten, as do I, J, K, M, N
and L1–L5, and `WO-0044`'s differential co-sim is still owed as the external
anchor for any row that rests on X-1's computed model — which, per §1, none of
family E's do.
