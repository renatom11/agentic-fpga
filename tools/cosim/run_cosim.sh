#!/usr/bin/env bash
# run_cosim.sh — THE ENTRY POINT for the differential co-simulation lane
# (WO-0046, Phase 1). Sequences the three artifacts WO-0046 §2.1 splits across
# two workers into the three checks §4 requires, and owns every byte of
# working-directory hygiene ADR-0015/§7 make hard constraints.
#
# CONTRACT (WO-0046 §2.1, verbatim): "The CI job invokes exactly one command:
# tools/cosim/run_cosim.sh. exit 0 = all three checks passed; nonzero =
# failure, with the failing check named on stdout. No arguments, no
# environment beyond PATH reaching iverilog/vvp and a built dune tree."
#
# ROUND 2 (dv_lead's `RV-0046-VERDICT`, `aa51971`, ACCEPTED): tb_writer's
# `test/cosim/**` landed and was reviewed. Two changes here as a result: (1)
# the sidecar's ownership is now RULED, not assumed — §5 below quotes it in
# full; (2) round 1's calling-convention ASSUMPTION for the four pinned entry
# points is now CONFIRMED (and one bug fixed) by reading the landed sources
# directly — see "THE PINNED ENTRY POINTS" below, which replaces round 1's
# speculative section of the same name.
#
# ROUND 3 (`WO-0049` §8, dv_lead's request, routed by the orchestrator as its
# own packet — see `WO-0049`'s own §8 header: "tb_writer: do not act on this,
# and do not open tools/**"; and `RV-0049-VERDICT` §4's measured addendum on
# that same packet): `test/cosim/compare.ml` gained a new exit code this
# round, `3` = "could not read a canonical file" (a `tb_writer`-scoped fix,
# `WO-0049` §5, ACCEPTED). Two changes here as a result:
#   (1) Check 4.1's mapping of `compare`'s exit code now separates a REAL
#       divergence (compare's own `1` -> `EXIT_DIFFERENTIAL(4)`) from NO
#       VERDICT REACHED AT ALL (compare's own `3` -> the new
#       `EXIT_NO_VERDICT(8)`). Before this round both collapsed onto `4` —
#       exactly the mis-classification `WO-0049` was written about: run
#       `30825741565`'s malformed `theirs.canon` was reported as if it were a
#       differential finding, when nothing had actually been compared.
#   (2) `compare`'s own exit `2` is measured, not assumed, to be AMBIGUOUS —
#       it is `compare.ml`'s usage-error code AND the code OCaml's runtime
#       assigns an uncaught exception (dv_lead, `RV-0049-VERDICT` §4,
#       measured: a bare `failwith` alone exits 2 under the system OCaml
#       toolchain). This script always invokes `compare` with exactly the
#       two required arguments at check 4.1's call site, so its usage branch
#       can never legitimately fire there — an observed `2` is therefore
#       never read as "usage" here. It maps to `EXIT_INTERNAL(9)`, the same
#       code any other code `compare`'s documented contract does not name
#       also gets.
# ROUND 4 (`WO-0075` §6, dv_lead's request, drafted this round; companion to
# tb_writer's `test/cosim/**` half of the same packet, which is what makes
# `compare`'s two new exit codes real): `compare` gains a timing comparison
# on top of its unchanged content comparison — `WO-0075` §3's T0 (admit-cycle
# base alignment, cross-side but asserts nothing about either design), T1
# (our own M03's output cycles against SPEC-M03 §6.1, asserting), and T2
# (the reference's own cycles, recorded and never adjudicated, REQ-901's
# exclusion). `compare`'s own precedence (`WO-0075` §6, pinned there so it is
# not invented here): content wins (its own exit 1 outranks everything);
# otherwise T0 (exit 5); otherwise T1 (exit 4); otherwise clean (exit 0). Two
# changes here as a result:
#   (1) Check 4.1's classification of `compare`'s exit code gains two more
#       cases, `4` -> the new `EXIT_TIMING(10)` and `5` -> the new
#       `EXIT_TIMING_NO_VERDICT(11)`, inserted before the unchanged `*)`
#       fail-closed branch (`WO-0075` §11 depends on that branch being
#       unchanged, so it is).
#   (2) The SUMMARY block gains one line stating what a green run is, and is
#       not, timing evidence for.
# Both new codes carry the same distinction WO-0049 §8 built the rest of this
# table around, applied to a third axis: a TIMING code is a defect against
# OUR OWN spec (SPEC-M03 §6.1, REQ-005/REQ-111) or against this harness's own
# timekeeping — never a disagreement with the MIT reference, whose cycles
# `compare` records and never adjudicates (T2). See "EXIT CODES" below for
# the full, current table.
# See "EXIT CODES" below for the full, current table, and "THE PINNED ENTRY
# POINTS" for the compare.exe entry's updated note.
#
# ROUND 5 (`WO-0078` §6.1 Stage 1, data_wrangler's own round; companion to
# tb_writer's landed `test/cosim/**` half at `3ec0efe`, which is what makes
# case iteration and `compare`'s new exit `6` real): this file goes from
# driving ONE stimulus to iterating a CASE SET. Stage 1 authorises exactly
# one member, case 0, byte-identical to what this script has always driven
# (`WO-0078` §3.1/§6.1) -- nothing here adds a stimulus class. What changes
# is the machinery around it, so that a case set of more than one member
# (Stage 2, a separate, not-yet-authorised round) has somewhere to land
# without a redesign:
#   (1) `stimulus_gen.exe` is now invoked with its SECOND, optional,
#       argument -- the case id (`test/cosim/stimulus_gen.ml`'s own header:
#       "the case id is therefore the SECOND, optional, argument, never the
#       first," landed against exactly this round's own use of it). Every
#       case gets its own stimulus, generated fresh, in its own working
#       directory.
#   (2) Checks 4.1 and 4.3 now run PER CASE (each case gets its own
#       differential-plus-timing comparison and its own two-run determinism
#       check, in its own directory); check 4.2 (the self-test) does not
#       depend on any case's stimulus at all -- it exercises `compare`'s own
#       fixed, hand-built fixtures -- so it still runs exactly ONCE, in the
#       same relative position WO-0046 §4 always put it: after the first
#       case's own check 4.1 and before that case's own check 4.3. At Stage
#       1's one-case cardinality this reproduces the pre-existing execution
#       order (4.1, 4.2, 4.3) byte-for-byte; at a future N > 1 the self-test
#       simply does not repeat, which is a documented choice of THIS round
#       (`WO-0078` §6.1 names case iteration as data_wrangler's own item; it
#       does not pin the self-test's position relative to a case loop that
#       does not exist yet), not an inference.
#   (3) NEITHER check dies on the first red any more. A producer refusal
#       inside one case's own pipeline (any of the six census entries
#       `WO-0078` §2.2 enumerates, plus a determinism mismatch) is recorded
#       against THAT case and the loop moves on to the next one -- `WO-0078`
#       §12 criterion 3, quoted here because it is the reason the control
#       flow changed shape: "A case that is skipped, or whose result is
#       folded into an aggregate without its own line, fails -- including
#       when the aggregate is 0." The ONE exception is case 0's own
#       stimulus_sha256 check (next item): that one aborts the whole run
#       before any case's pipeline has executed, by `WO-0078` §3.3 item 1's
#       own explicit instruction, and is not part of this "never die
#       mid-loop" rule.
#   (4) Case 0's `stimulus_sha256`, generated fresh by THIS run, is compared
#       against the value the last GREEN pre-widening `cosim` job printed --
#       CI run `31084252734`, job `cosim` (job id `92559876482`), commit
#       `3ec0efe` (fetched via GitHub's REST API, jobs-then-logs, read-only;
#       see the Return log for the one blocked leg of that fetch and how it
#       was worked around without retrying a policy denial). A mismatch
#       exits the new `EXIT_CASE0_MOVED` (`13`) immediately, reported before
#       any case's own pipeline runs; a match is reported too (`WO-0078` §12
#       criterion 1's read side never goes unstated, whichever way it comes
#       out).
#   (5) Two new exit codes, both allocated by this round: `EXIT_
#       TIMING_UNASSERTABLE` (`12`, required by `WO-0075`/`WO-0078` §5.3 the
#       moment any case can carry an injected idle -- `compare`'s own exit
#       `6`, landed by tb_writer at `3ec0efe`, is what this maps) and
#       `EXIT_CASE0_MOVED` (`13`, `WO-0078` §3.3 item 1, allocated "above
#       12" per the packet's own instruction). See "EXIT CODES" below for
#       both, in this round's own words, and where each sits on the
#       did-the-lane-reach-a-verdict axis `WO-0049` §8 built this table
#       around.
#   (6) The per-case aggregate precedence (`WO-0078` §3.3, implemented here
#       in the exact order the packet pins it): case-0-moved, then any
#       producer refusal in any case, then content divergence in any case,
#       then T0-unaligned in any case, then T1-unassertable in any case,
#       then T1-negative in any case, then `EXIT_OK`. `compare`'s own exit
#       code and precedence, per invocation, are UNCHANGED (`WO-0078` §3.3's
#       own framing: "`compare` runs per case and keeps its own exit
#       contract unchanged. The harness aggregates.") -- this script only
#       adds the layer that folds N per-case results into ONE process exit.
#   (7) A cost probe (`WO-0078` §9): two wall-time numbers, printed as plain
#       lines rather than left to CI's own step-timing UI -- the per-case
#       pipeline wall time (the `run_pipeline` call that will scale with the
#       case count Stage 2/3 add) and this whole script's own wall time
#       ("the `cosim` job's own duration" `WO-0078` §9 names as unmeasured;
#       scoped explicitly to this script's invocation, not the surrounding
#       CI job's opam/checkout time, which this script has no visibility
#       into and does not claim to measure).
#
# ROUND 6 (`WO-0078` §6.2 Stage 2, the C1+C2 landing, data_wrangler's own
# round; companion to tb_writer's landed `test/cosim/stimulus_gen.ml` half at
# `a822f46`, which is what makes C1 and C2 real stimulus rather than unknown
# case ids -- and to `RV-STAGE1` §5's own amendment to §6.1/§11, landed at
# `965f6ee`/`8427b12`, which is what makes items (2) and (3) below lawful
# rather than a defect against the Stage-1 DoD). The case set grows from
# Stage 1's one member to three, and the machinery that only had to work for
# one case is repaired everywhere it assumed that:
#   (1) `CASES` gains `"C1"` and `"C2"`, in `WO-0078` §6.2's own landing order
#       (C1+C2 together, this round; C3 and C4 each alone, not this round).
#       **The ids are the generator's own, confirmed by reading
#       `test/cosim/stimulus_gen.ml`'s `known_cases`/`find_case_meta`
#       directly rather than assumed from this round's own dispatch text**,
#       which named them lowercase ("c1"/"c2") -- `find_case_meta` matches
#       by `String.equal` against `known_cases`' own ids `"0"`, `"C1"`,
#       `"C2"`, case-sensitively, and has no entry for a lowercase form; a
#       run with the lowercase ids would have `failwith`n on both new cases
#       ("unknown case id ... known: 0, C1, C2"), correctly recorded by this
#       script as a PRODUCE-REFUSAL for each, but wrongly -- the generator
#       was never broken, the dispatch's own shorthand just was not this
#       file's contract. Corrected here against the source rather than
#       against the dispatch; see the Return log for the full account.
#   (2) Per-case working directories become GENUINELY per-case:
#       `$WORK/case_<id>/{stim,run1,run2}`, replacing the three shared paths
#       (`$WORK/stim`, `$WORK/run1`, `$WORK/run2`) every case used to
#       overwrite in turn. This is what `RV-STAGE1` §5 OQ1 named as the
#       rename Stage 1's own byte-identity-pinned wildcard could not survive,
#       and what its amendment (below) exists to permit.
#   (3) The `*)` wildcard arm changes from Stage 1's byte-identical,
#       immediate-`die` form to `RV-STAGE1` §5 OQ1/OQ2's own behavioural
#       successor, quoted in full at the arm itself in the CASE LOOP below.
#       In one sentence: it no longer dies mid-loop (a die there costs every
#       LATER case in the set its own line, `RV-STAGE1`'s own added bound on
#       top of the original OQ2 acceptance); it records-and-continues like
#       every classified arm above it, printing the RAW unclassifiable code
#       rather than a fabricated tier; and `EXIT_INTERNAL` becomes an
#       AGGREGATE code, decided after the loop and ranking ABOVE every other
#       aggregate code -- see the AGGREGATE section below for where that
#       precedence is implemented, and EXIT CODES 9's own entry for the
#       restated rule.
#   (4) `FINDING RV-0078-S1-3`'s repair: the cost probe now times BOTH
#       `run_pipeline` calls per case (run1 AND run2, not run1 alone, which
#       Stage 1's own probe under-reported the true per-case marginal by
#       roughly half by only ever timing) -- three lines per case now
#       (`run1`, `run2`, and their sum), so that Band A's linearity clause
#       (`WO-0078` §9: "each added case costs no more than 2x the
#       single-case measurement") is actually READABLE from this run's own
#       printed output at N=3, not merely satisfiable by construction as
#       Stage 1's green could only claim.
#   (5) The case-0 pin's printed CITATION is corrected, value unchanged
#       (`RV-STAGE1` §1's own standing note, dv_lead's Stage-1 review,
#       `8c6429e`): the printed provenance line and `CASE0_PINNED_SHA256`'s
#       own comment now name the re-anchored, genuinely pre-widening run --
#       `build` run `31080871169`, job `92549154623`, commit `55e16ae` --
#       never the run this literal was originally fetched from at Stage 1
#       (`31084252734`/`92559876482`/`3ec0efe`), which dv_lead's own review
#       found CIRCULAR by construction (that run post-dates tb_writer's own
#       Stage-1 landing, so a moved case 0 could have been pinned right back
#       to itself with nothing in the log to say so). See
#       `CASE0_PINNED_SHA256`'s own comment, below, for the full account,
#       kept rather than erased so the citation rule is checkable against
#       its own history.
#
# ROUND 7 (`WO-0078` §6.2 Stage 2, the C3 landing, data_wrangler's own round;
# companion to tb_writer's landed `test/cosim/stimulus_gen.ml` half at
# `b10546c`, which is what makes C3 real stimulus rather than an unknown case
# id -- and to `RV-C2ALPHA` §9, dv_lead's own sequencing verdict on the C2
# re-run, which is what makes item (1) below a lawful amendment rather than
# an invented reorder). Two changes:
#   (1) `CASES` becomes `("0" "C1" "C3" "C2")` -- C3 THIRD, C2 LAST, not the
#       order the ids were introduced in. `RV-C2ALPHA` §9 item 2, quoted
#       rather than paraphrased: "the reason is §12 criterion 3's plural
#       content: a red case does not cost a LATER case its line. It is
#       unexercised after three landings -- twice deferred because the only
#       not-clean case was last in the array, and a third time because
#       nothing was not-clean at all ... Placing C3 third makes a not-clean
#       C3 be followed by C2 in the same run, which exercises the property
#       at zero cost the first time C3 diverges -- and costs nothing if it
#       does not." **Lawful, checked, restated here rather than re-derived**:
#       case 0 stays FIRST -- its frozen-baseline gate is precedence 1 and
#       reports before any case runs, untouched by this round (`WO-0078`
#       §3.3 item 1, see the array's own comment below, unmoved). **Binds
#       are per case, never per position** (`RV-C2ALPHA` §9 item 2): no
#       stimulus moves, so C1's and C2's own shas (printed by
#       `stimulus_gen.exe` itself via each case's own SUMMARY, not
#       recomputed or re-pinned by this script) are untouched by the
#       reorder -- this script only changed the ORDER the loop below visits
#       ids in, not what any id names.
#       `RV-C2ALPHA` §9 item 3's own consequence, restated here because it
#       changes what a reader should expect of EVERY FUTURE run of this
#       file, not just this one: **"C2 is now a standing regression case.
#       Every subsequent landing re-runs it, so the two-frame class, the sha
#       bind and the re-arm path are re-checked at C3, at C4, and at every
#       landing after them. The first landing that fails to reproduce
#       [C2's stimulus sha] with two matching frames is adjudicated as a
#       regression before any new case's result is read."** This script
#       does nothing special to enforce that -- C2's own CASE line and
#       SUMMARY carry it exactly as every other case's do; the adjudication
#       is dv_lead's, at the RV-, never this script's own.
#   (2) `FINDING RV-0078-S2-7`'s repair, riding this round's runner half per
#       `RV-C2ALPHA` §9 item 1 ("FINDING RV-0078-S2-7's runner repair rides
#       C3's runner half, unchanged"): the per-case SUMMARY block used to be
#       printed UNCONDITIONALLY at the tail of the loop body, so a case that
#       reached the tail without hitting a `continue` first (NO-VERDICT,
#       TIMING-NO-VERDICT, TIMING-UNASSERTABLE, INTERNAL) printed
#       T1-assertion language and the WO-0078 §12 criterion 9 coverage
#       sentence for a comparison that was never computed -- observed in
#       production for C2 at `RV-C2RERUN` (compare exit 3, tier NO-VERDICT,
#       no T0/T1/T2 anything printed above it). Quoted from the finding
#       rather than paraphrased: **"The repair is a bound, not a
#       suppression: a case that reached no verdict may still print its
#       provenance, and the timing sentence is what must become
#       conditional."** `print_case_summary` (defined below, immediately
#       before the CASE LOOP) is now the single call site every per-case
#       exit path reaches -- the three PRODUCE-REFUSAL sites (stimulus_gen,
#       run1's own pipeline, run2's own pipeline) that used to `continue`
#       straight past any SUMMARY at all, and the tail-of-loop-body site
#       that used to be the old unconditional block. It prints the same
#       provenance lines (reference pin, simulator versions, runner image,
#       stimulus sha256 where one was ever computed) for EVERY case, and
#       prints the timing sentence only when the case's own tier is one of
#       WO-0049 §8's reached-a-verdict family (CLEAN, DIFFERENTIAL, or
#       TIMING -- exactly the family the EXIT CODES section below already
#       documents that axis by). Every other tier -- PRODUCE-REFUSAL at any
#       of the three pipeline stages, NO-VERDICT, TIMING-NO-VERDICT,
#       TIMING-UNASSERTABLE, or INTERNAL (the did-not-reach-a-verdict
#       family, the identical enumeration) -- gets a SUMMARY that says so,
#       names the reason, and claims nothing else. **A case WITH a result
#       keeps today's SUMMARY byte-for-byte**: this round changes no line
#       printed for CLEAN, DIFFERENTIAL or TIMING (confirmed by `diff`
#       against the pre-round text, Return log).
#       ONE WORDING NOTE, recorded rather than silently corrected: the
#       dispatch that carried this repair to this seat cited it against
#       "the amended criterion 7." Read directly against `WO-0078` §12
#       rather than copied from the dispatch, criterion 7 governs
#       refusal-code distinctness (a different, unrelated property) and it
#       is criterion 9, "No claim outside the driven set," that the
#       finding's own text actually invokes ("this verdict says in terms
#       what C2 proves (nothing). But it is a sentence of the form
#       criterion 9 exists to police"). This comment and the Return log
#       cite 9, not 7, for that reason -- the same "read the source, not
#       the shorthand" discipline ROUND 6's item (1) above already
#       established for this file.
#
# C3 lands ALONE this round (`RV-C2ALPHA` §9 item 1: "the C3 dispatch,
# alone, per §6.2 -- CONFIRMED"), not C4 (a separate, future round). C3's
# own predicted disposition (`WO-0078` §7 row 3, CD §10.3): our side
# ACCEPTS and MARKS the bad-FCS frame in full (60 delivered octets,
# `tuser`[0] = 1 -- REQ-005 forbids store-and-forward); the reference MAY
# DROP it entirely -- "the commonest store-and-forward instinct." If it
# does, `compare` legitimately reports a divergence and this run's
# aggregate reds with C3's own CASE line naming it. This script does NOT
# special-case C3 anywhere: the same per-case machinery every prior case
# already used -- the DIFF_RC case statement, the aggregate precedence, the
# SUMMARY repair above -- is what lets that divergence surface cleanly, and
# the disposition it resolves to (a REQ-901 spec diff versus a `BUG-`) is
# dv_lead's adjudication at the RV-, never this file's.
#
# THE THREE CHECKS (WO-0046 §4, order followed exactly; `WO-0078` §6.1/§6.2
# widen 4.1 and 4.3 from ONE stimulus to a CASE SET -- see ROUND 5/6 above)
#
#   4.1  DIFFERENTIAL COMPARISON  — run PER CASE in the case set (`WO-0078`
#        §6.1; Stage 1's set has exactly one member, case 0, byte-identical
#        to the single 64-octet good-FCS frame, lane-0 start, this script
#        has always driven). Each case's stimulus is driven into both
#        `Xgmii_rx_64` (ours, via ours_run) and `axis_xgmii_rx_64` (theirs,
#        via the vendored reference under `iverilog`/`vvp`), reduced to
#        canonical transaction files and compared under REQ-901. For the
#        FRAME THIS SCRIPT DRIVES the permitted-divergence set is EMPTY, so
#        any divergence is a defect and `compare` exits nonzero.
#
#        CORRECTED 2026-08-09 (dv_lead, J-dv_lead-0132; CD-xgmii_rx_64_cosim.md
#        §0-ter, the dated annotation beside §0-bis). This comment used to say
#        "For M03 the permitted-divergence set is EMPTY", quoting §0-bis's
#        closing sentence. THAT SENTENCE IS STALE AT THE SCOPE IT IS WRITTEN
#        AT, and this file is where the staleness could do damage rather than
#        merely mislead. REQ-901 gained divergence classes (e) and (f) at the
#        M03 boundary by spec diff at ebb3f49, countersigned:
#
#          (e) `tuser`[0] ALONE is excluded on 5-to-63-octet frames — payload
#              octets and the `tkeep` extent are STILL COMPARED, because the
#              reference's FCS check is a lane-indexed residue array with no
#              length gate, so it strips four octets and delivers length-4
#              exactly as we do. A sub-5-octet frame is excluded entirely,
#              its accept-or-discard included.
#          (f) an over-1518-octet frame is excluded ENTIRELY.
#
#        Both exclude NOTHING in the 64-to-1518-octet range, which is why the
#        statement above is scoped to the frame this script drives (64 octets,
#        inside that range) rather than to "M03". A LATER PHASE THAT DRIVES A
#        RUNT OR AN OVERSIZE FRAME THROUGH THIS SAME SCRIPT MUST NOT READ THE
#        OLD SENTENCE AND ADJUDICATE ITS OWN RESULT AGAINST AN EMPTY SET — for
#        those classes the set is not empty, and a `tuser`[0] difference there
#        is a declared divergence, not a defect. Nothing about the check's
#        MECHANICS changes: `compare` still exits nonzero on any difference it
#        finds, and narrowing that verdict is the reader's job, not this
#        script's.
#   4.2  DELIBERATE-MISMATCH SELF-TEST — `compare --self-test`, in the SAME
#        binary as 4.1, so the self-test exercises the production comparison
#        path rather than a parallel harness that proves nothing about it.
#   4.3  TWO-RUN DETERMINISM — run PER CASE, immediately after that case's own
#        4.1 (`WO-0078` §6.1): the whole pipeline (ours_run + vvp against the
#        SAME recorded per-case stimulus and the SAME built simulator) runs a
#        second time, and both canonical files (ours.canon, theirs.canon) are
#        diffed byte-for-byte between the two runs. This exercises the
#        "pinned-input reproducibility" guarantee named in ADR-0015 D3 and
#        CD-xgmii_rx_64_cosim.md §4 — explicitly NOT REQ-902, which does not
#        extend to this lane.
#
# ARTIFACT HYGIENE — HARD CONSTRAINTS (WO-0046 §7, ADR-0015 R-CI-1/R-CI-5)
#
#   1. Nothing this script produces — iverilog output, vvp output, the
#      compiled sim binary, the stimulus, the canonical files, their sidecars
#      — is ever written inside the repository checkout. Everything lives
#      under one `mktemp -d`. The one exception, and it is deliberate: `dune
#      build` writes its ordinary `_build/` cache inside the checkout, exactly
#      as every other dune invocation in this programme does. `_build/` is
#      already `.gitignore`d repo-wide and is not one of the artifact classes
#      named in §7.1 (iverilog/vvp output, VCDs, logs, the stimulus, the
#      canonical files, the sidecars) — it is the OCaml toolchain's own
#      standard cache, identical in kind to what `dune build @default`
#      already leaves behind in the main `build` job. Isolating it further
#      would buy nothing the existing `.gitignore` does not already give.
#   2. Cleanup runs via `trap … EXIT`, so it fires on every exit path — the
#      happy path, a `die` call from any of the three checks, and a prereq or
#      build failure alike. A harness that tidies only on success strands
#      artifacts on exactly the runs that matter (§7.2); this one does not.
#   3. On failure, the evidence reaches the log BEFORE cleanup: both
#      canonical files and both sidecars for every run implicated are `cat`
#      to stdout (§7.3), because a divergence nobody can see is a divergence
#      nobody can adjudicate.
#
# THE CANONICAL FORM — this script does not interpret it. It treats
# `ours.canon`/`theirs.canon` as opaque byte streams for the determinism diff,
# and defers ALL comparison semantics to `compare` (tb_writer's deliverable,
# reviewed and ACCEPTED under REQ-901 at RV-0046-VERDICT).
#
# THE SIDECAR — SINGLE WRITER, PLACEHOLDERS BARRED
# (dv_lead's ruling, `RV-0046-VERDICT` §5, ACCEPTED — quoted, not paraphrased,
# where it matters)
#
# `run_cosim.sh` is the sidecar's ONLY writer. Neither OCaml producer
# (`stimulus_gen`, `ours_run`) writes one at all. `tb_xgmii_rx_64.v` (read in
# full before this round) DOES still write its own best-effort
# `theirs.canon.meta` as part of the `vvp` run, with the two fields it
# cannot determine from inside Verilog — simulator version, runner image —
# left as literal `unknown (fill in: …)` text; that is what tb_writer's
# landed code does today, predating dv_lead's ruling. This script does not
# edit that file (`test/**` is outside this agent's write scope) — it
# defeats the placeholder mechanically instead: `write_sidecar` always runs
# AFTER `vvp` and always fully OVERWRITES `<name>.canon.meta` (truncate +
# write, never append or merge), so whatever `tb_xgmii_rx_64.v` wrote there
# is replaced before anything downstream — a comparison, a determinism diff,
# an on-failure dump — ever reads it. The still-placeholder-writing Verilog
# code is flagged in this round's Return log for tb_writer's next round, not
# fixed here.
#
# Placeholders are barred, full stop. dv_lead, verbatim: "An 'unknown (fill
# in:)' marker in an evidence artifact is worse than an absent file — it
# reads as a recorded value, and the reproducibility guarantee's entire
# antecedent is those fields being real." So every REQUIRED field below is
# validated non-empty by `require_field` before ANY sidecar is written, for
# BOTH canonical files, on BOTH runs — a field this script cannot determine
# fails the WHOLE RUN (`EXIT_PROVENANCE`), not a sidecar with a hole in it.
#
# The four REQUIRED fields (the reproducibility guarantee's antecedent,
# ADR-0015 D3 / CD §4), and how each is determined here:
#   reference pin SHA   parsed from test/third_party/verilog-ethernet/
#                        PROVENANCE.md at run time (a repository fact).
#   simulator version    `iverilog -V` AND `vvp -V`, each captured at run
#                        time — only the invoker knows which binaries it
#                        actually invoked.
#   runner image         `$ImageOS`/`$RUNNER_NAME` in CI; a well-defined
#                        LOCAL descriptor otherwise — see next section.
#   stimulus identifier  sha256 of the one `stimulus.txt` both runs of a
#                        GIVEN CASE share (`WO-0078` §6.1: a case set means a
#                        distinct stimulus per case; the sidecar's own
#                        `stimulus_sha256` field is per-case, recomputed and
#                        re-validated before each case's own two runs).
# Additionally recorded, best-effort and explicitly NOT gated — advisory
# only, R-CI-3's extra forensic detail, not part of the antecedent above —
# the distro package version via `dpkg-query`. Applying the same "no marker
# that reads as a recorded value" principle to this one non-required field
# too: when `dpkg-query` cannot answer, the key is OMITTED from the sidecar
# entirely, never written with placeholder text.
#
# THE RUNNER-IMAGE FIELD OUTSIDE CI — A DECISION, NOT A GAP
#
# In GitHub Actions, `$ImageOS` (and `$RUNNER_NAME` where present) already
# name the runner image losslessly. Outside CI — a developer running the
# full pipeline locally with a real `iverilog`/`vvp`/`dune` on PATH — there
# is no `$ImageOS`, and the fail-if-undeterminable rule, taken naively, would
# make a local full run permanently unable to pass. That is the wrong
# failure mode: ADR-0015 D1 itself measured that "the local lane is
# genuinely usable" (unlike the OCaml lane, which ADR-0005 blocks), and a
# rule that turns a genuinely runnable local lane into one that can never
# succeed would throw away a finding the programme already paid to
# establish, in the name of a rule aimed at fabricated values, not real
# local ones.
#
# So a local run gets a DIFFERENT, but equally REAL, value:
# `local:<hostname> <uname -srm> [<os-release PRETTY_NAME>]`. This is not a
# placeholder and not a guess — every token is a fact this shell can read
# about the machine it is actually running on, exactly as much a genuine
# runner-image identifier as `$ImageOS` is for a GitHub-hosted one. It is
# composed ONLY from the parts that actually succeed: if `hostname` fails but
# `uname` does not (or vice versa), the field is built from whichever
# succeeded, never padded with an "unknown-host"-shaped filler for the one
# that did not — that would smuggle back exactly the kind of marker this
# whole rule exists to bar, just at one remove. It is `require_field`-checked
# exactly like the CI value: only if EVERY part — `hostname`, `uname` AND
# `/etc/os-release` — comes back empty (a machine broken enough that none of
# them works) is that the genuine "cannot determine" case, and the run fails
# rather than record nothing.
#
# THE PINNED ENTRY POINTS' CALLING CONVENTION — CONFIRMED AGAINST THE LANDED
# `test/cosim/` SOURCES (round 2; round 1 built this section from an
# assumption, flagged as such, before these files existed)
#
#   stimulus_gen.exe   TWO optional positional args, filled left to right:
#                      output path (default "stimulus.txt", cwd-relative, if
#                      omitted), case id (default "0") —
#                      `test/cosim/stimulus_gen.ml`'s own `Sys.argv` match.
#                      ROUND 5 (`WO-0078` §6.1, this round): this script now
#                      passes BOTH explicitly, an absolute output path and
#                      the case id being iterated, for every case in the set
#                      — the landing-order affordance
#                      `test/cosim/stimulus_gen.ml`'s own header names
#                      ("the case id is therefore the SECOND, optional,
#                      argument, never the first") is exercised here for the
#                      first time. `stimulus_gen.exe` also writes a
#                      `<output_path>.idle` sidecar unconditionally
#                      alongside `stimulus.txt` (`WO-0078` §5.2,
#                      tb_writer's own mechanism) — this script does not
#                      read, copy, or otherwise touch that file directly; it
#                      rides along through `ours_run.exe`'s own relay to
#                      `<ours.canon>.idle`, which `compare.exe` reads on its
#                      own.
#   ours_run.exe       TWO optional positional args, filled left to right:
#                      stimulus path (default "stimulus.txt"), output path
#                      (default "ours.canon") — `ours_run.ml`'s own
#                      `Sys.argv` match; more than two args is a usage error,
#                      exit 2. This script always passes both explicitly.
#   compare.exe        REQUIRES exactly two positional args, `<ours.canon>
#                      <theirs.canon>` — NO default, unlike the other two;
#                      any other argument count (including zero) prints
#                      usage and exits 2 without comparing anything —
#                      `compare.ml`'s own `Sys.argv` match. Round 1 called
#                      this binary with ZERO arguments under the since-
#                      corrected assumption that it would default to
#                      cwd-relative filenames like `ours_run` does; that
#                      would have made check 4.1 exit 2 on every run,
#                      never actually comparing anything. Fixed this round
#                      by reading the real source before landing it.
#                      ROUND 3: `compare.ml` also now documents exit `3`
#                      ("could not read a canonical file", `WO-0049` §5) --
#                      still 0 clean / 1 divergence / 2 usage / 3 no-verdict.
#                      This script's check-4.1 call site always passes
#                      exactly the required two arguments, so `compare`'s own
#                      usage branch (exit 2) can never legitimately fire from
#                      THIS call — see EXIT CODES 9 below for what an
#                      observed 2 here actually means (`WO-0049` §8,
#                      `RV-0049-VERDICT` §4).
#   compare.exe --self-test
#                      exactly one argument, the literal `--self-test`.
#                      Unchanged from round 1's assumption; confirmed.
#   tb_xgmii_rx_64.v   NO argv support at all (Verilog, no `$test$plusargs`
#                      parsing) — it hardcodes `$fopen("stimulus.txt","r")`,
#                      `$fopen("theirs.canon","w")` and
#                      `$fopen("theirs.canon.meta","w")`, all relative to
#                      `vvp`'s cwd at invocation time (the file's own
#                      "WORKING DIRECTORY CONTRACT" comment says exactly
#                      this and names this script as the one responsible
#                      for arranging it). This is the one entry point where
#                      cwd, not an argument, IS the interface, so this
#                      script still `cd`s into the run directory — with a
#                      `stimulus.txt` copied there first — only for the
#                      `vvp` invocation.
#
# THE iverilog INVOCATION (ADR-0015 D1, quoted: "iverilog -o sim … && vvp
# sim") — this script adds no flags beyond `-o` and the source list, on
# purpose: the ADR's own quoted shape is the contract, and inventing a
# generation flag (e.g. `-g2012`) neither pinned by the ADR nor requested by
# tb_writer would be exactly the kind of guess this WO- says not to make. If
# `tb_xgmii_rx_64.v` needs one, that is a one-line change here, flagged back
# through the RV- loop, not a silent addition now.
#
# EXIT CODES — the failing check named on stdout AND encoded in the exit
# code, so CI, a human, and a re-run script can all tell which outcome
# occurred without re-reading the log.
#
# WO-0049 §8 (dv_lead's request; routed here by the orchestrator, ACCEPTED at
# `RV-0049-VERDICT`): the codes below are partitioned along one axis — DID
# THE LANE REACH A VERDICT? `2` (PREREQ), `3` (BUILD) and `8` (NO-VERDICT,
# added this round) mean it did NOT; `4` (DIFFERENTIAL), `5` (SELFTEST) and
# `6` (DETERMINISM) mean it ran to completion and the verdict it reached was
# negative. Conflating the two is the concrete hazard §8 names: "a reader, or
# a future automated gate, sees EXIT_DIFFERENTIAL and reads 'our RTL diverged
# from the MIT reference' — a far more consequential claim than 'our own
# testbench wrote a malformed file'." A broken harness must never be
# reportable as an anchor finding.
#
# `WO-0075` §6 (dv_lead's request, drafted this round): two more codes join
# the same axis, both keyed off `compare`'s own timing tiers (`WO-0075` §3).
# `10` (TIMING) joins the reached-a-verdict/negative side beside `4`, `5` and
# `6`; `11` (TIMING-NO-VERDICT) joins the did-not-reach side beside `2`, `3`
# and `8`. Both are about OUR OWN M03 against OUR OWN spec (SPEC-M03 §6.1,
# REQ-005/REQ-111) or about this harness's own time base — never about the
# MIT reference, whose cycles `compare` records and never adjudicates (T2,
# REQ-901's exclusion, `WO-0075` §3.3).
#
# ROUND 5 (`WO-0078` §5.3/§3.3, data_wrangler's own round): one more code
# joins the did-not-reach side, and one more joins it beside it for a
# different reason.
#
# `12` (TIMING-UNASSERTABLE) is the mapping of `compare`'s own exit `6`
# (`Unassertable`, landed by tb_writer at `3ec0efe`) — T1 DECLINING to
# certify a frame rather than certifying it and finding it wrong. That is
# "did not reach a verdict" in exactly the sense `2`/`3`/`8`/`11` already are
# — a defect in neither our RTL nor the reference, but in what the stimulus
# permits T1 to assert — so `12` joins that same enumerated set: `2`, `3`,
# `8`, `11`, `12`. It ranks ABOVE `10` (a reached-and-negative T1 verdict) in
# this script's own per-case classification and in `WO-0078` §3.3's
# aggregate precedence, for the identical reason `8` outranks `4` and `11`
# outranks `10` — a refusal is not a verdict, so it cannot be a NEGATIVE
# verdict either.
#
# `13` (CASE0-MOVED) is not a `compare` exit mapping at all — it fires
# before `compare` is ever invoked for any case, indeed before any case's
# own `ours_run`/`vvp` pipeline runs at all (`WO-0078` §3.3 item 1). It
# belongs on the did-not-reach-a-verdict side for the strongest form of the
# same reason `2` (PREREQ) and `7` (PROVENANCE) do: this is not a report
# that some case's comparison went badly, it is a report that the frozen
# baseline this whole lane's history is anchored to (`WO-0078` §3.1) no
# longer exists in the form every prior result assumed, so there is nothing
# for ANY case in the set to be compared against yet. Grouped here, in this
# round's own words, with `2`, `3`, `7`, `8`, `11`, `12` — the whole
# did-not-reach-a-verdict family — rather than invented as some fourth axis:
# a run that never got as far as a baseline never got as far as reaching or
# missing a verdict either.
#
# A further note this round adds, since checks 4.1 and 4.3 now iterate a
# case set (`WO-0078` §6.1) rather than driving one stimulus: `4`
# (DIFFERENTIAL), `9` (INTERNAL, Stage 2 amendment — see `9`'s own entry
# above), `10` (TIMING), `11` (TIMING-NO-VERDICT) and `12`
# (TIMING-UNASSERTABLE) below are now AGGREGATE codes — "at least one case in
# the set produced this outcome," per `WO-0078` §3.3's own precedence AS
# AMENDED by `RV-STAGE1` §5 OQ1/OQ2 (`WO-0078` §6.2, this round): this script
# implements case-0-moved first (it fires inside the loop, before any case's
# pipeline runs, so it is not really competing with the rest), THEN `9`
# (INTERNAL — a comparator outside its own documented contract invalidates
# every case's verdict, not merely its own, so it is checked before anything
# decided from a verdict compare DID reach), then any producer refusal, then
# content, then T0, then T1-unassertable, then T1-negative, then OK. WHICH
# case, and every OTHER case's own outcome, is always in the per-case
# `CASE <id>: …` lines printed during the run — the aggregate code alone
# never says which case, on purpose (`WO-0078` §3.3's own rule: "the per-case
# lines say which case, and they are printed for every case whatever the
# aggregate is") — and that rule now covers the wildcard's own outcome too,
# which Stage 1's version of this script could not print at all.
#
#   0  PASS         — all three checks (4.1, 4.2, 4.3) passed.
#   2  PREREQ       — iverilog, vvp or dune is not on PATH. The lane DID NOT
#                     RUN. Per ADR-0015 D1's standing rule: "A skipped,
#                     absent or failed-to-install simulator is never a
#                     PASS." This code exists so nothing can read exit-
#                     nonzero-therefore-ran-and-found-a-defect from a run
#                     that never started.
#   3  BUILD /      — TWO STAGE NAMES, ONE CODE (`WO-0073-D5`, repaired
#      PRODUCE        2026-08-10; the code's contract is UNCHANGED and is the
#                     one `WO-0049` §8 accepted). Both mean the lane DID NOT
#                     RUN a comparison, and both are distinguished from PREREQ
#                     because the tools were present. They differ in where they
#                     send the reader, which is the whole of what a label is
#                     for:
#                       BUILD   — `dune build` of the three pinned executables,
#                                 the `iverilog` compile of the testbench +
#                                 vendored reference, or a required source file
#                                 that does not exist. Nothing has run yet.
#                       PRODUCE — one of the pinned executables (stimulus_gen,
#                                 ours_run, or vvp against the compiled
#                                 reference) BUILT, RAN, and then exited
#                                 nonzero or exited 0 without writing the file
#                                 it owed. The build succeeded; a driver did
#                                 not. The line names which producer, which
#                                 side, which run, and which of the two failure
#                                 modes it was.
#                     In both cases the failing command's own output is printed
#                     immediately above the "FAILED CHECK:" line.
#                     WHY THE CODE IS NOT SPLIT TOO: §8's axis is "did the lane
#                     reach a verdict?", both answer no, and the exit-code table
#                     is a contract that went through the RV- loop. A label is
#                     free to become more precise; a code is not.
#   4  DIFFERENTIAL — check 4.1: `compare` REACHED a verdict (its own exit 1)
#                     and it was negative — a real disagreement between the
#                     reference and our implementation. As of WO-0049 §8
#                     (ACCEPTED): a run that did NOT reach a verdict is never
#                     reported under this code, however it failed — see
#                     NO-VERDICT(8) below. (Before this round this code's own
#                     description read "reported a divergence, OR could not
#                     be run to a verdict" — precisely the conflation §8
#                     identifies; that wording is gone.)
#   5  SELFTEST     — check 4.2: `compare --self-test` did not confirm the
#                     production comparator has teeth. `compare`'s own
#                     contract (WO-0049 §5.5, ACCEPTED) guarantees
#                     `--self-test`'s aggregate exit is 0 or 1 only — it must
#                     not return 3 (or 2) as its own result, so this code
#                     carries none of check 4.1's ambiguity.
#   6  DETERMINISM  — check 4.3: the two-run byte-for-byte diff of the
#                     canonical files found a difference.
#   7  PROVENANCE   — a sidecar field the reproducibility guarantee's
#                     antecedent depends on (the reference pin, either
#                     simulator's version, the runner image, or the
#                     stimulus's sha256) could not be determined. dv_lead's
#                     ruling (`RV-0046-VERDICT` §5, ACCEPTED): placeholders
#                     are barred, so an undeterminable REQUIRED field fails
#                     the whole run rather than ship an "unknown (fill
#                     in:)" marker in an evidence artifact. Distinct from
#                     INTERNAL because the three checks' own machinery may
#                     be perfectly fine — only the provenance record is not
#                     attestable, and that is reason enough on its own.
#   8  NO-VERDICT   — check 4.1's `compare` invocation could not reach a
#                     verdict AT ALL: it exited 3, its own documented "could
#                     not read a canonical file" code (WO-0049 §5, ACCEPTED)
#                     — a grammar violation (`Canonical.read`'s `Failure`) or
#                     an I/O failure (`Sys_error`) on either producer's
#                     canonical file. NOT a claim that the reference and our
#                     implementation agree OR disagree — neither was
#                     established. This is precisely the class of failure
#                     WO-0049 itself was written about (run `30825741565`: a
#                     malformed `theirs.canon` was reported as
#                     EXIT_DIFFERENTIAL; this code exists so that never
#                     happens again). Distinct from BUILD(3): BUILD is a
#                     failure BEFORE `compare` is even invoked (dune,
#                     iverilog, or a producer's own nonzero exit or missing
#                     output file); NO-VERDICT is specifically `compare`
#                     having run and declared, in its own words, that it
#                     could not read what it was given.
#   9  INTERNAL     — a machinery problem unrelated to the above (bad
#                     invocation, mktemp failure, a build reported success
#                     but the expected binary is missing) — OR check 4.1's
#                     `compare` exiting an AMBIGUOUS or unrecognized code,
#                     most notably its own `2`. `compare.ml` assigns `2` to a
#                     usage error, but this script always invokes it with
#                     exactly the two required positional arguments at that
#                     call site, so that branch can never legitimately fire
#                     here; an observed `2` is therefore the OCaml runtime's
#                     OWN uncaught-exception exit code, which happens to
#                     collide with the usage code `compare.ml` chose
#                     (dv_lead, `RV-0049-VERDICT` §4, measured: a bare
#                     `failwith` alone exits 2 under the system OCaml
#                     toolchain). A bare `2` cannot distinguish "usage" from
#                     "compare crashed internally", so this script never
#                     guesses which — it reports INTERNAL, never
#                     DIFFERENTIAL and never "usage" (WO-0049 §8).
#                     STAGE 2 AMENDMENT (`RV-STAGE1` §5 OQ1/OQ2, `WO-0078`
#                     §6.2, this round): per-invocation this code's meaning
#                     above is UNCHANGED. What is new is that `9` now also
#                     exists as an AGGREGATE outcome, decided once after the
#                     per-case loop, exactly like `4`/`10`/`11`/`12` below —
#                     "at least one case in the set hit the wildcard." dv_lead's
#                     own words, quoted rather than paraphrased: "EXIT_INTERNAL
#                     SHALL become an aggregate code decided after the loop,
#                     ranking ABOVE every other code in §3.3's precedence — a
#                     comparator outside its contract invalidates every case's
#                     verdict, not merely its own." So among everything decided
#                     AFTER the loop, `9` is checked FIRST — ahead of a producer
#                     refusal, content, T0, T1-unassertable and T1-negative —
#                     because a case whose own `compare` invocation left its
#                     documented `{0,1,3,4,5,6}` contract has told this script
#                     nothing trustworthy about ANY case's verdict, including
#                     the cases that ran cleanly. (`13`, CASE0-MOVED, still
#                     fires earlier still when it fires at all — it aborts
#                     before any case's pipeline runs, which is a stronger
#                     precondition than "after the loop" — so the two never
#                     compete for the same run.) See the AGGREGATE section in
#                     the script body for where this precedence is implemented,
#                     and the CASE LOOP's own `*)` arm for what triggers it.
#  10  TIMING       — check 4.1's `compare` REACHED a timing verdict (T1,
#                     `WO-0075` §3.2) and it was negative: our M03 emitted an
#                     output word at a cycle other than the one SPEC-M03
#                     §6.1 pins for it, on a stimulus whose CONTENT both
#                     implementations already agree on (`compare`'s own exit
#                     4, `WO-0075` §6 — content is checked first, so a
#                     content divergence is never masked as a timing one).
#                     This is a defect against OUR OWN specification
#                     (REQ-005/REQ-111), a `BUG-` candidate — decided by
#                     re-reading SPEC-M03 §6.1, never by editing the expected
#                     constant to match what was observed (`WO-0075` §3.2).
#                     It is NEVER a disagreement with the MIT reference: the
#                     reference's own cycles are recorded and never
#                     adjudicated (T2, REQ-901's exclusion) and contribute to
#                     no exit code at all.
#  11  TIMING-NO-    — check 4.1's `compare` could NOT reach a timing verdict
#      VERDICT         at all: T0 (admit-cycle equality — the harness's own
#                     two producers indexing the same stimulus the same way)
#                     failed to align, so T1 and T2 were withheld rather than
#                     computed on an unaligned base (`compare`'s own exit 5,
#                     `WO-0075` §3.1/§6 — "a timing verdict computed on
#                     unaligned bases is worse than no verdict"). This is a
#                     defect in the co-simulation harness's own timekeeping —
#                     the two producers not deriving the shared 0-based
#                     stimulus-line time base the same way — and it is
#                     NEITHER a claim about our design NOR about the MIT
#                     reference; nothing about either side's cycles was ever
#                     compared.
#  12  TIMING-        — check 4.1's `compare` REFUSED to certify T1 for at
#      UNASSERTABLE     least one frame in at least one case (`compare`'s own
#                     exit 6, `WO-0078` §5.3/§5.4, landed by tb_writer at
#                     `3ec0efe`): either the stimulus itself CARRIED a
#                     nonzero injected-idle count for that frame (FINDING
#                     RV-0075-2 — the antecedent SPEC-M03 §6.1's gapless
#                     formula does not survive), or the frame's own recorded
#                     cycles carry exactly one broken inter-word delta,
#                     structurally indistinguishable from a legitimate
#                     single idle injection. NOT a defect against our own
#                     spec (that is `10`, TIMING) and NOT a differential
#                     finding — it is T1 declining to compute a number it
#                     was not built to assert past, which is a DIFFERENT
#                     thing from computing one and getting it wrong. Ranks
#                     ABOVE `10` in this script's own aggregate precedence
#                     (`WO-0078` §3.3): a tier that declined to certify has
#                     not certified, so it cannot be read as a negative
#                     certification either. Before this code existed
#                     (`RV-0075-VERDICT` §4.1(b)/(c)), `Unassertable` mapped
#                     to `10` — putting a stimulus/harness condition on the
#                     design-defect axis, which is exactly the
#                     misclassification hazard `WO-0049` §8 built this whole
#                     table to prevent, applied here to a third axis. `12`
#                     is required, not optional, from the first case this
#                     lane ever drives that CAN carry an injected idle or a
#                     boundary-shifted timing shape (`RV-0075-VERDICT`
#                     §4.1(c)) — Stage 1 ships the machinery; the case that
#                     actually exercises this code end-to-end in this
#                     script's own execution is `compare --self-test`'s own
#                     fixtures (e)/(e′), not case 0, which carries zero idles
#                     by construction (`WO-0078` §4.2 item 2) and is
#                     therefore never expected to produce `12` on a green run.
#  13  CASE0-MOVED    — case 0's `stimulus_sha256`, generated fresh by THIS
#                     run, does not equal the value the last GREEN
#                     pre-widening `cosim` job printed (`WO-0078` §3.3 item
#                     1; the pinned value and its own source are recorded
#                     where `CASE0_PINNED_SHA256` is set, below). Checked,
#                     and reported either way, BEFORE any case's own
#                     `ours_run`/`vvp` pipeline runs — a run whose frozen
#                     reference case has moved has no baseline, so NOTHING
#                     else in that run is reported: not a per-case line for
#                     case 0, not a per-case line for any other case in the
#                     set, nothing. PREREQ/PROVENANCE/BUILD still run first
#                     (this check needs a built `stimulus_gen.exe` to even
#                     produce case 0's stimulus to hash), but among
#                     everything CASE-related this is the very first thing
#                     checked — before case 0's own `ours_run`/`vvp`
#                     pipeline, before any other case in the set gets a
#                     turn. `13` sorts last among the codes by number but
#                     first among the case-related checks by construction,
#                     because every later check in this script assumes case
#                     0 is what `WO-0078` froze it as, and that assumption
#                     is exactly what this code exists to verify before it
#                     is spent.
#
# USAGE
#   tools/cosim/run_cosim.sh        run all three checks, no arguments
#   tools/cosim/run_cosim.sh --help print this header and exit 0

set -uo pipefail

# WO-0078 §9 -- the cost probe's second number (the whole `cosim` job's own
# wall time). Captured as the very first thing this script does, so the
# number printed at the end covers everything this script itself spends,
# not merely the case loop. Nanosecond epoch, GNU `date` (`%N`); integer
# bash arithmetic only, no `bc`/`awk` dependency.
JOB_START_NS="$(date +%s%N)"

# FINDING RV-0078-S1-3's repair (WO-0078 §6.2 Stage 2, this round): the
# per-case cost probe must time BOTH `run_pipeline` calls (run1 AND run2),
# not run1 alone -- Stage 1's own probe under-reported the true per-case
# marginal by roughly half. Callers that need to ADD two durations (a run1
# time and a run2 time, to print their sum) need the raw nanosecond count,
# not only a formatted string, so `elapsed_since` below is now a thin
# formatting wrapper around two smaller pieces rather than one function that
# did both at once.
elapsed_ns_since() {
  # $1 = a %s%N start value from this same `date`; prints the raw elapsed
  # nanosecond count as an integer.
  local start="$1"
  printf '%d' "$(($(date +%s%N) - start))"
}

format_ns() {
  # $1 = a nanosecond count (from elapsed_ns_since, or a sum of several);
  # prints "N.NNNs" -- the exact format elapsed_since has always printed.
  local ns="$1" ms
  ms=$((ns / 1000000))
  printf '%d.%03ds' "$((ms / 1000))" "$((ms % 1000))"
}

elapsed_since() {
  # $1 = a %s%N start value from this same `date`; prints "N.NNNs". Every
  # call site written before this round keeps working unchanged.
  format_ns "$(elapsed_ns_since "$1")"
}

HERE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$HERE/../.." && pwd)"

DUNE_DIR="test/cosim"
TP_DIR="test/third_party/verilog-ethernet"
PROVENANCE="$REPO/$TP_DIR/PROVENANCE.md"
TB_FILE="$REPO/$DUNE_DIR/tb_xgmii_rx_64.v"
REF_FILE_1="$REPO/$TP_DIR/axis_xgmii_rx_64.v"
REF_FILE_2="$REPO/$TP_DIR/lfsr.v"

STIMULUS_GEN_BIN="$REPO/_build/default/$DUNE_DIR/stimulus_gen.exe"
OURS_RUN_BIN="$REPO/_build/default/$DUNE_DIR/ours_run.exe"
COMPARE_BIN="$REPO/_build/default/$DUNE_DIR/compare.exe"

EXIT_OK=0
EXIT_PREREQ=2
EXIT_BUILD=3
EXIT_DIFFERENTIAL=4
EXIT_SELFTEST=5
EXIT_DETERMINISM=6
EXIT_PROVENANCE=7
EXIT_NO_VERDICT=8
EXIT_INTERNAL=9
EXIT_TIMING=10
EXIT_TIMING_NO_VERDICT=11
EXIT_TIMING_UNASSERTABLE=12
EXIT_CASE0_MOVED=13

# WO-0078 §6.2 Stage 2 (the C1+C2 landing) -- the case SET grows from Stage
# 1's one authorised member to three: case 0 (frozen baseline, §3.1,
# unedited), C1 (lane-4 start on cycle 0, CD §10.1) and C2 (two clean frames
# at minimum IFG, CD §10.2). C3 and C4 are NOT here -- WO-0078 §6.2's own
# landing order lands each of those alone, in its own round, and this round
# is only the C1+C2 landing.
#
# The ids below are `test/cosim/stimulus_gen.ml`'s OWN case-sensitive
# vocabulary (`known_cases`), confirmed by reading that file directly rather
# than copied from this round's own dispatch text, which named them
# lowercase -- see ROUND 6's header note above for the full account of why
# that matters (a lowercase id is not in `known_cases` and would PRODUCE-
# REFUSE both new cases rather than run either). Case 0 is always processed
# first -- everything this script does with it (the frozen-baseline check,
# below) depends on that ordering, not on searching the array for "0".
#
# ROUND 7 amendment (`WO-0078` §6.2 Stage 2, the C3 landing, `RV-C2ALPHA` §9
# item 2, this round): the array becomes `("0" "C1" "C3" "C2")` -- C3 THIRD,
# C2 LAST, not the order the ids were introduced in. See ROUND 7's own
# header note above for the full reasoning (the §12 criterion 3
# plural-property argument) and for why the reorder is lawful (case 0 stays
# first; binds are per case, never per position; no stimulus moves, only
# the order this loop visits ids in). From this round on C2 is a STANDING
# REGRESSION CASE -- re-run and re-checked at every landing after this one,
# not merely the case this landing happens to add (`RV-C2ALPHA` §9 item 3).
CASES=("0" "C1" "C3" "C2")

# WO-0078 §3.3 item 1 -- the last GREEN pre-widening `cosim` job's own
# printed value, pinned here rather than re-derived. The VALUE below is
# UNCHANGED since Stage 1; only its CITATION moves, this round, and the
# reason is recorded in full because a citation rule that hides why it
# exists cannot be checked.
#
# CITATION, per `RV-STAGE1` §1's own standing note (dv_lead's Stage-1
# review, `8c6429e`, read in full rather than paraphrased from memory) --
# **CITE BUILD RUN `31080871169`, JOB `92549154623`, COMMIT `55e16ae`
# whenever this freeze is claimed, never the literal alone and never the run
# below.** dv_lead's own words: "From `8c6429e` forward, criterion 1 is
# checked against a literal inside the file it constrains. That literal is
# now the single point of failure for the entire freeze, and an edit to it
# would defeat the freeze silently and greenly. The freeze's independent
# anchor is run `31080871169` / job `92549154623` at `55e16ae`. Cite that
# run, never the literal, whenever the freeze is claimed -- including in
# `SO-xgmii_rx_64.md`."
#
# HISTORY, kept rather than erased: this value was ORIGINALLY fetched
# (Stage 1, this file's own prior round) from CI run `31084252734` ("build"
# workflow), job `cosim` (job id `92559876482`), commit `3ec0efe` -- the last
# GREEN `cosim` job at the time, read via `mcp__github__get_job_logs` after
# the dispatch's own named `curl` route hit an organisation egress policy
# denial (GitHub's own logs endpoint 302s to Azure blob storage, not on this
# session's allow-list; worked around by a different transport onto the same
# public log, not a retry of the denial). dv_lead's `RV-STAGE1` review found
# THAT citation circular by construction -- `3ec0efe` is the very commit
# tb_writer's own Stage-1 half had already landed at, so "had the case table
# moved case 0, the pin would have recorded the moved value and criterion 1
# would have passed vacuously, green, with nothing in the log to say so" --
# and closed the circularity independently against the genuinely
# pre-widening run named above, finding the two values IDENTICAL. This
# round's printed pin-provenance line therefore cites the re-anchored run;
# the value itself needed no change.
CASE0_PINNED_SHA256="c675517176922d42bca42ec3def182cb3536861f1acaa8384116f33a5c4cc051"

say() { printf '%s\n' "$*"; }
hdr() { printf '\n=== %s ===\n' "$*"; }

case "${1:-}" in
  -h | --help)
    sed -n '2,/^set -uo/p' "$0" | sed 's/^# \{0,1\}//;$d'
    exit "$EXIT_OK"
    ;;
esac
if [ "$#" -gt 0 ]; then
  say "run_cosim: unexpected argument(s): $*"
  say "  WO-0046 §2.1: this entry point takes no arguments. Nothing here reads"
  say "  the job's environment beyond PATH; configuration lives in files in the"
  say "  repository, not in argv."
  exit "$EXIT_INTERNAL"
fi

# ------------------------------------------------------------------ #
# working directory — everything this run produces lives here         #
# ------------------------------------------------------------------ #

WORK="$(mktemp -d "${TMPDIR:-/tmp}/run_cosim.XXXXXX")" || {
  say "run_cosim: INTERNAL — mktemp -d failed. Cannot proceed without a"
  say "  working directory outside the checkout (WO-0046 §7.1)."
  exit "$EXIT_INTERNAL"
}
trap 'rm -rf "$WORK"' EXIT

dump_run() {
  # $1 = run directory, $2 = label, for the evidence-on-failure rule (§7.3).
  hdr "EVIDENCE — $2: both canonical files and both sidecars"
  local f
  for f in ours.canon theirs.canon ours.canon.meta theirs.canon.meta; do
    if [ -e "$1/$f" ]; then
      printf -- '--- %s/%s ---\n' "$2" "$f"
      cat "$1/$f"
      printf -- '--- end %s/%s ---\n' "$2" "$f"
    else
      say "  ($2/$f does not exist)"
    fi
  done
}

die() {
  # $1 = exit code, $2 = check name — printed exactly once, so "the failing
  # check named on stdout" (WO-0046 §2.1) is never ambiguous.
  #
  # WO-0078 §9's cost probe (this round): the whole job's own wall time is
  # printed on EVERY exit path, not only the happy one -- a run that fails
  # is exactly the run whose cost a reader most wants to see (was this
  # slow, or did it fail fast?), so it is printed here rather than only in
  # the final success-path summary.
  say "  [cost] run_cosim.sh wall time (this invocation): $(elapsed_since "$JOB_START_NS")"
  printf '\nrun_cosim: FAILED CHECK: %s\n' "$2"
  exit "$1"
}

produce_reason() {
  # $1 = the producer's exit code, $2 = the output file it owed. Names WHICH of
  # the two PRODUCE failure modes occurred, because they send a reader to
  # different places and the old wording named neither.
  #
  # `WO-0073-D5` (MINOR, against `tools/`, mine; measured `J-dv_lead-0134`,
  # `WO-0073-VERDICT` §10, carrier declared as this round): under IC-L5 the lane
  # printed
  #
  #   Fatal error: exception Failure("ours_run: M03 produced an output word
  #     with no admitted frame open")
  #     ... test/cosim/ours_run.ml, line 119
  #   run_cosim: FAILED CHECK: BUILD (ours_run failed in run1, rc=2)
  #
  # on a run whose build had already printed `dune build: ok` eight lines
  # earlier. The exit CODE was right — 3's contract has always covered "one of
  # the pinned executables ran but did not exit 0", and that contract went
  # through the RV- loop at `WO-0049` §8, so it is not changed here. The LABEL
  # was wrong, and a label is what a reader acts on: "BUILD" sends them to dune
  # and iverilog, and the story was a guard raising inside a driver.
  #
  # Repair: code 3 keeps its meaning and gains a second STAGE NAME. `BUILD` now
  # means compilation and its inputs (dune, iverilog, a missing source file);
  # `PRODUCE` means a pinned executable that BUILT, RAN, and then failed or did
  # not write the file it owed. Same code, same axis (§8: the lane did not reach
  # a verdict), different pointer.
  #
  # The general form: WHERE ONE EXIT CODE COVERS SEVERAL STAGES, THE STAGE MUST
  # BE NAMED IN THE TEXT, BECAUSE THE CODE IS READ BY A MACHINE AND THE TEXT IS
  # READ BY THE PERSON WHO HAS TO FIX IT. Widening a code's contract is free;
  # widening its label silently is how the two drift apart.
  if [ "$1" -ne 0 ]; then
    printf 'ran and exited %d -- the build had already succeeded' "$1"
  else
    printf 'ran and exited 0 but did not write %s' "$2"
  fi
}

require_field() {
  # $1 = human field name, $2 = value. dv_lead's ruling (`RV-0046-VERDICT`
  # §5, ACCEPTED): placeholders are barred. A REQUIRED field this script
  # cannot determine fails the run outright rather than ship an "unknown
  # (fill in:)" marker in an evidence artifact.
  local name="$1" value="$2"
  if [ -z "$value" ]; then
    say "run_cosim: PROVENANCE — required sidecar field could not be determined: $name"
    say "  dv_lead, RV-0046-VERDICT §5: \"An 'unknown (fill in:)' marker in an"
    say "  evidence artifact is worse than an absent file — it reads as a"
    say "  recorded value, and the reproducibility guarantee's entire"
    say "  antecedent is those fields being real.\" This run fails rather than"
    say "  record one."
    die "$EXIT_PROVENANCE" "PROVENANCE (undeterminable field: $name)"
  fi
}

runner_image() {
  # Prints a runner-image identifier and returns 0; prints nothing and
  # returns 1 only if truly nothing is determinable (header note: "THE
  # RUNNER-IMAGE FIELD OUTSIDE CI"). CI is detected by `$ImageOS` (GitHub
  # Actions' own runner-image variable); outside CI, a well-defined LOCAL
  # descriptor is built instead — a real fact about this machine, not a
  # placeholder.
  if [ -n "${ImageOS:-}" ]; then
    if [ -n "${RUNNER_NAME:-}" ]; then
      printf 'ci:%s (%s)' "$ImageOS" "$RUNNER_NAME"
    else
      printf 'ci:%s' "$ImageOS"
    fi
    return 0
  fi
  # Composed ONLY from parts that actually succeeded -- never a placeholder
  # standing in for one that did not. A partial failure (e.g. `hostname`
  # unavailable but `uname` fine) must not embed an "unknown-host"-shaped
  # token into a field this same function's caller then treats as real; that
  # would be exactly the marker-that-reads-as-a-recorded-value dv_lead's
  # ruling bars, self-inflicted. Only if EVERY part is unavailable is the
  # field genuinely undeterminable (returns 1, caller fails via
  # require_field) -- there is no in-between "half-known" value.
  local host unamestr osline parts=""
  host="$(hostname 2>/dev/null)"
  unamestr="$(uname -srm 2>/dev/null)"
  osline=""
  if [ -r /etc/os-release ]; then
    osline="$(sed -n 's/^PRETTY_NAME="\{0,1\}\([^"]*\)"\{0,1\}$/\1/p' /etc/os-release | head -1)"
  fi
  [ -n "$host" ] && parts="$host"
  if [ -n "$unamestr" ]; then
    [ -n "$parts" ] && parts="$parts $unamestr" || parts="$unamestr"
  fi
  if [ -n "$osline" ]; then
    [ -n "$parts" ] && parts="$parts ($osline)" || parts="($osline)"
  fi
  if [ -z "$parts" ]; then
    return 1
  fi
  printf 'local:%s' "$parts"
  return 0
}

# ------------------------------------------------------------------ #
# PREREQUISITES — iverilog, vvp, dune. Absence is never a PASS.        #
# ------------------------------------------------------------------ #

hdr "PREREQUISITES"
PREREQ_MISSING=""
for tool in iverilog vvp dune; do
  if command -v "$tool" >/dev/null 2>&1; then
    say "  [ok]   $tool -> $(command -v "$tool")"
  else
    say "  [FAIL] $tool not found on PATH"
    PREREQ_MISSING="$PREREQ_MISSING $tool"
  fi
done
if [ -n "$PREREQ_MISSING" ]; then
  say ""
  say "  ADR-0015 D1's standing rule: \"A skipped, absent or failed-to-install"
  say "  simulator is never a PASS. No SO- packet may cite a run in which the"
  say "  co-simulation lane did not execute, and a run summary must distinguish"
  say "  *ran and agreed* from *did not run*.\" This is *did not run*: missing"
  say "  tool(s):$PREREQ_MISSING"
  die "$EXIT_PREREQ" "PREREQUISITES (missing:$PREREQ_MISSING)"
fi

# ------------------------------------------------------------------ #
# PROVENANCE — the four REQUIRED sidecar fields, determined once,      #
# validated non-empty once, reused by every sidecar write below.       #
# Placeholders are barred (dv_lead, RV-0046-VERDICT §5): any of these   #
# missing fails the run here, before a single check runs.              #
# ------------------------------------------------------------------ #

hdr "PROVENANCE"

if [ ! -e "$PROVENANCE" ]; then
  say "run_cosim: PROVENANCE — $PROVENANCE does not exist."
  say "  Cannot determine the vendored reference's pinned SHA without it, and"
  say "  a run that cannot determine it must not claim the reproducibility"
  say "  guarantee (dv_lead, RV-0046-VERDICT §5)."
  die "$EXIT_PROVENANCE" "PROVENANCE (missing PROVENANCE.md)"
fi
REF_SHA="$(grep -m1 'Pinned commit SHA' "$PROVENANCE" 2>/dev/null | grep -oE '[0-9a-fA-F]{40}' | head -1)"
require_field "reference_pin_sha" "$REF_SHA"
say "  [ok]   reference pin (from PROVENANCE.md): $REF_SHA"

IVERILOG_VERSION_BANNER="$(iverilog -V 2>&1 | head -1)"
require_field "simulator_iverilog_version" "$IVERILOG_VERSION_BANNER"
say "  [ok]   iverilog: $IVERILOG_VERSION_BANNER"

VVP_VERSION_BANNER="$(vvp -V 2>&1 | head -1)"
require_field "simulator_vvp_version" "$VVP_VERSION_BANNER"
say "  [ok]   vvp: $VVP_VERSION_BANNER"

# Advisory only — NOT gated, NOT part of the reproducibility guarantee's
# antecedent (R-CI-3's extra forensic detail). Left empty, never given
# placeholder text, if dpkg-query cannot answer (e.g. iverilog was not
# apt-installed, or this is not a Debian-derived system); write_sidecar
# omits the key entirely in that case rather than write one.
IVERILOG_PKG_VERSION="$(dpkg-query -W -f='${Version}' iverilog 2>/dev/null)"
say "  [--]   iverilog package version (advisory, not gated): ${IVERILOG_PKG_VERSION:-not available}"

RUNNER_IMAGE="$(runner_image)" || RUNNER_IMAGE=""
require_field "runner_image" "$RUNNER_IMAGE"
say "  [ok]   runner image: $RUNNER_IMAGE"

write_sidecar() {
  # $1 = path to write, $2 = canon_role (ours|theirs), $3 = run_label.
  # SINGLE WRITER (RV-0046-VERDICT §5, ACCEPTED): always called AFTER both
  # producers for a run have finished, and always FULLY OVERWRITES $1
  # (truncate + write via `>`, never append) — see the header note on
  # tb_xgmii_rx_64.v's own still-present placeholder-writing code, which
  # this defeats mechanically rather than by editing test/**. Every
  # REQUIRED field below was validated non-empty by require_field before
  # this function was ever reachable; none is a placeholder.
  {
    printf '# provenance sidecar — NEVER compared (WO-0046 §2.3). Sole writer:\n'
    printf '# tools/cosim/run_cosim.sh (dv_lead ruling, RV-0046-VERDICT §5, ACCEPTED).\n'
    printf 'canon_role=%s\n' "$2"
    printf 'run_label=%s\n' "$3"
    printf 'reference_repo=https://github.com/alexforencich/verilog-ethernet\n'
    printf 'reference_pin_sha=%s\n' "$REF_SHA"
    printf 'reference_files=axis_xgmii_rx_64.v,lfsr.v (test/third_party/verilog-ethernet/, verbatim, ADR-0015 D2)\n'
    printf 'simulator_iverilog_version=%s\n' "$IVERILOG_VERSION_BANNER"
    printf 'simulator_vvp_version=%s\n' "$VVP_VERSION_BANNER"
    if [ -n "$IVERILOG_PKG_VERSION" ]; then
      printf 'simulator_package_version_advisory=%s\n' "$IVERILOG_PKG_VERSION"
    fi
    printf 'runner_image=%s\n' "$RUNNER_IMAGE"
    printf 'stimulus_sha256=%s\n' "$STIMULUS_SHA"
  } >"$1"
}

# ------------------------------------------------------------------ #
# BUILD — the three OCaml executables, and the reference simulator    #
# ------------------------------------------------------------------ #

hdr "BUILD"
say "  dune build (writes to $REPO/_build/, gitignored — see header note)"
BUILD_OUT="$(cd "$REPO" && dune build \
  "$DUNE_DIR/stimulus_gen.exe" "$DUNE_DIR/ours_run.exe" "$DUNE_DIR/compare.exe" 2>&1)"
BUILD_RC=$?
if [ "$BUILD_RC" -ne 0 ]; then
  say "$BUILD_OUT"
  die "$EXIT_BUILD" "BUILD (dune build failed, rc=$BUILD_RC)"
fi
for bin in "$STIMULUS_GEN_BIN" "$OURS_RUN_BIN" "$COMPARE_BIN"; do
  if [ ! -x "$bin" ]; then
    say "run_cosim: INTERNAL — dune build reported success but $bin is not executable."
    die "$EXIT_INTERNAL" "INTERNAL (expected executable missing: $bin)"
  fi
done
say "  dune build: ok — stimulus_gen.exe, ours_run.exe, compare.exe"

for f in "$TB_FILE" "$REF_FILE_1" "$REF_FILE_2"; do
  if [ ! -e "$f" ]; then
    say "run_cosim: BUILD — required source file does not exist: $f"
    die "$EXIT_BUILD" "BUILD (missing source: $f)"
  fi
done
SIMBIN="$WORK/sim"
IVERILOG_OUT="$(iverilog -o "$SIMBIN" "$TB_FILE" "$REF_FILE_1" "$REF_FILE_2" 2>&1)"
IVERILOG_RC=$?
if [ "$IVERILOG_RC" -ne 0 ]; then
  say "$IVERILOG_OUT"
  die "$EXIT_BUILD" "BUILD (iverilog compile failed, rc=$IVERILOG_RC)"
fi
[ -n "$IVERILOG_OUT" ] && say "$IVERILOG_OUT"
say "  iverilog compile: ok -> $SIMBIN"

# ------------------------------------------------------------------ #
# run_pipeline — drives one case's stimulus through both sides ONCE.   #
# WO-0078 §6.1 (this round): no longer calls `die` on its own account —  #
# see the CASE LOOP below for why (pass criterion 3: a producer refusal  #
# in one case's pipeline must not silently cost every OTHER case in the  #
# set its own reported line). Callers read the return status and        #
# `$PIPE_FAIL_REASON`.                                                   #
# ------------------------------------------------------------------ #

run_pipeline() {
  # $1 = run directory (created by the caller), $2 = label, $3 = this
  # case's own stimulus.txt path. Drives our side with explicit absolute
  # paths (ours_run.ml takes two optional positional args, confirmed
  # against the landed source), then drives the reference side via vvp,
  # which has NO argv support at all and hardcodes
  # "stimulus.txt"/"theirs.canon"/"theirs.canon.meta" relative to its own
  # cwd (tb_xgmii_rx_64.v's own "WORKING DIRECTORY CONTRACT" comment) — so
  # only that invocation needs a cwd change and a copied-in stimulus file.
  # Writes both sidecars last, overwriting whatever tb_xgmii_rx_64.v wrote.
  #
  # Returns 0 on success. On failure, prints the failing producer's own
  # output (unchanged from before this round) and returns 1 with
  # `$PIPE_FAIL_REASON` set to the same human-readable string this script
  # used to hand straight to `die` — the caller decides what to do with a
  # failure now, this function no longer decides FOR it.
  local dir="$1" label="$2" stim="$3" out rc
  PIPE_FAIL_REASON=""

  out="$("$OURS_RUN_BIN" "$stim" "$dir/ours.canon" 2>&1)"
  rc=$?
  if [ "$rc" -ne 0 ] || [ ! -e "$dir/ours.canon" ]; then
    say "$out"
    PIPE_FAIL_REASON="PRODUCE (ours_run, our side, $label: $(produce_reason "$rc" "$dir/ours.canon"))"
    return 1
  fi
  [ -n "$out" ] && say "  [$label] ours_run: $out"

  cp "$stim" "$dir/stimulus.txt"
  out="$(cd "$dir" && vvp "$SIMBIN" 2>&1)"
  rc=$?
  if [ "$rc" -ne 0 ] || [ ! -e "$dir/theirs.canon" ]; then
    say "$out"
    PIPE_FAIL_REASON="PRODUCE (vvp, the reference side, $label: $(produce_reason "$rc" "$dir/theirs.canon"))"
    return 1
  fi
  [ -n "$out" ] && say "  [$label] vvp: $out"

  write_sidecar "$dir/ours.canon.meta" ours "$label"
  write_sidecar "$dir/theirs.canon.meta" theirs "$label"
  return 0
}

# record_case_refusal — WO-0078 §3.3 item 2 ("any producer refusal, any
# case, → its own code, on the did-not-reach-a-verdict side"). First
# refusal recorded across the whole case set wins the AGGREGATE exit code
# (a process returns exactly one exit status; every case's own line is
# printed regardless, so no information is lost by this choice — only
# which single code the aggregate reports when more than one case has a
# refusal, a situation Stage 1's one-case set cannot itself produce).
AGG_REFUSAL_CODE=""
AGG_REFUSAL_LABEL=""
record_case_refusal() {
  # $1 = harness exit code, $2 = human-readable label (already case-scoped
  # by the caller).
  if [ -z "$AGG_REFUSAL_LABEL" ]; then
    AGG_REFUSAL_CODE="$1"
    AGG_REFUSAL_LABEL="$2"
  fi
}

# ------------------------------------------------------------------ #
# CASE LOOP — WO-0078 §6.1/§6.2: checks 4.1 and 4.3, iterated per case, #
# in a GENUINELY per-case working directory (`RV-STAGE1` §5 OQ1's own    #
# amendment, this round -- see below). Check 4.2 (self-test) does not    #
# depend on any case's stimulus and runs exactly once, in-line,          #
# immediately after the FIRST case's own check 4.1 — reproducing         #
# WO-0046 §4's original 4.1/4.2/4.3 order exactly at Stage 1's one-case  #
# cardinality, and still first-case-only now that there is more than     #
# one. Nothing in this loop calls `die` for a per-case producer          #
# refusal, content divergence, timing outcome, or (as of this round)     #
# unclassifiable compare exit (WO-0078 §12 criterion 3, `RV-STAGE1` §5   #
# OQ2): every case gets its own printed line and its own attempt, and    #
# the AGGREGATE section after the loop is the only place that exits      #
# non-zero for any of those reasons. The one exception is case 0's own   #
# frozen-baseline check, immediately below, which is instructed by       #
# WO-0078 §3.3 item 1 to abort the ENTIRE run before any case's          #
# pipeline executes.                                                     #
# ------------------------------------------------------------------ #

hdr "CASE SET (WO-0078 §6.2 Stage 2: ${#CASES[@]} case(s) — ${CASES[*]})"

# `RV-STAGE1` §5 OQ1's own amendment (dv_lead, `965f6ee`), quoted rather
# than paraphrased: Stage 1's "per-case working directory" instruction and
# its "`*)` fail-closed wildcard untouched" instruction collided head-on the
# moment the case set grew past one member, because the wildcard's own body
# named `$WORK/run1` LITERALLY. dv_lead's own ruling retired the
# byte-identity form of the wildcard's pin and replaced it with a
# BEHAVIOURAL one that survives a path rename: "The `*)` arm SHALL remain
# the last arm; it SHALL dump the case's own run directory; it SHALL report
# EXIT_INTERNAL and never a differential or timing code; and it SHALL never
# fall through." That successor is implemented at the wildcard arm itself,
# below. What it PERMITS, exercised here for the first time: working
# directories that are genuinely per-case, `$WORK/case_<id>/{stim,run1,run2}`,
# rather than the three shared paths every case used to overwrite in turn.
# `mkdir -p` is called per case, inside the loop, rather than once here.

AGG_CONTENT=0
AGG_T0=0
AGG_T1_UNASSERTABLE=0
AGG_T1_NEG=0
SELFTEST_DONE=0

# WO-0078 §6.2/`RV-STAGE1` §5's own amendment (this round) -- see the `*)`
# arm below for what sets this and the AGGREGATE section for how it is
# read. "First one across the set wins the aggregate's own label" for the
# identical reason `record_case_refusal` already works this way: a process
# exits exactly one status; every case's own line is printed regardless, so
# no information is lost, only which single label backs the aggregate
# EXIT_INTERNAL when more than one case trips the wildcard.
AGG_INTERNAL_HIT=0
AGG_INTERNAL_LABEL=""
record_case_internal() {
  # $1 = the case id, $2 = the raw, unclassifiable compare exit code.
  if [ "$AGG_INTERNAL_HIT" -eq 0 ]; then
    AGG_INTERNAL_HIT=1
    AGG_INTERNAL_LABEL="INTERNAL (compare exited ambiguous/unrecognized code $2 for case $1 -- outside its documented contract {0,1,3,4,5,6})"
  fi
}

# print_case_summary -- FINDING RV-0078-S2-7's repair (`WO-0078` §6.2 Stage
# 2, the C3 landing, `RV-C2ALPHA` §9 item 1; ROUND 7's own header note above
# has the full account). The single call site every per-case exit path now
# reaches, replacing the old unconditional SUMMARY block that used to sit
# only at the tail of the loop body -- the defect that let a case which
# reached the tail without a `continue` first (NO-VERDICT,
# TIMING-NO-VERDICT, TIMING-UNASSERTABLE, INTERNAL) print T1-assertion
# language and the §12 criterion 9 coverage sentence for a comparison that
# was never computed (observed in production for C2 at `RV-C2RERUN`:
# compare exit 3, tier NO-VERDICT, no T0/T1/T2 anything printed above it).
# Quoted from the finding: "The repair is a bound, not a suppression: a
# case that reached no verdict may still print its provenance, and the
# timing sentence is what must become conditional."
#
# $1 = case id.
# $2 = "1" if this case reached a comparison verdict -- compare exit 0/1/4,
#      i.e. CLEAN, DIFFERENTIAL, or TIMING-negative, WO-0049 §8's own
#      reached-a-verdict family, exactly as the EXIT CODES section above
#      already documents that axis -- "0" otherwise: PRODUCE-REFUSAL at any
#      of the three pipeline stages (stimulus_gen, run1, run2), NO-VERDICT,
#      TIMING-NO-VERDICT, TIMING-UNASSERTABLE, or INTERNAL, the identical
#      did-not-reach-a-verdict enumeration.
# $3 = this case's own stimulus_sha256, or the literal "N/A" if generation
#      itself never produced one to hash.
# $4 = a short human-readable reason; printed only when $2 is "0".
#
# A case WITH a result ($2 = 1) keeps today's SUMMARY byte-for-byte -- this
# function changes no line printed for CLEAN, DIFFERENTIAL or TIMING.
print_case_summary() {
  local cid="$1" has_result="$2" stim_sha="$3" reason="$4"
  hdr "SUMMARY (case $cid)"
  say "  reference pin: $REF_SHA"
  say "  simulator: $IVERILOG_VERSION_BANNER / $VVP_VERSION_BANNER"
  say "  runner image: $RUNNER_IMAGE"
  say "  stimulus sha256: $stim_sha"
  if [ "$has_result" -eq 1 ]; then
    say "  timing: OUR side asserted against SPEC-M03 §6.1 (T1); the reference's own"
    say "          cycles are RECORDED AND NOT ADJUDICATED (T2, REQ-901's exclusion)."
    say "          This case's own result is timing evidence for the ONE stimulus"
    say "          class it drives and for no other (WO-0078 §12 criterion 9)."
  else
    say "  timing: NO RESULT for this case -- it did not reach a comparison verdict"
    say "          ($reason). FINDING RV-0078-S2-7: a case with no result claims"
    say "          nothing about timing, content, or coverage; see this case's own"
    say "          CASE line above for the exit code and tier that produced this."
  fi
}

for CASE_ID in "${CASES[@]}"; do
  hdr "CASE $CASE_ID"
  CASE_DIR="$WORK/case_$CASE_ID"
  mkdir -p "$CASE_DIR/stim" "$CASE_DIR/run1" "$CASE_DIR/run2"

  # ---- stimulus, this case's own (case 0's construction expression is
  #      tb_writer's and is unedited by this round — this script only
  #      NAMES the case id it wants, per stimulus_gen.ml's own dispatch) ----
  CASE_STIM="$CASE_DIR/stim/stimulus.txt"
  GEN_OUT="$("$STIMULUS_GEN_BIN" "$CASE_STIM" "$CASE_ID" 2>&1)"
  GEN_RC=$?
  if [ "$GEN_RC" -ne 0 ] || [ ! -e "$CASE_STIM" ]; then
    say "$GEN_OUT"
    GEN_REASON="$(produce_reason "$GEN_RC" "$CASE_STIM")"
    record_case_refusal "$EXIT_BUILD" "PRODUCE (stimulus_gen, case $CASE_ID: $GEN_REASON)"
    say "CASE $CASE_ID: stimulus_sha256=N/A compare_exit=N/A tier=PRODUCE-REFUSAL ($GEN_REASON)"
    print_case_summary "$CASE_ID" 0 "N/A" "PRODUCE-REFUSAL (stimulus_gen, case $CASE_ID: $GEN_REASON)"
    continue
  fi
  [ -n "$GEN_OUT" ] && say "$GEN_OUT"
  STIMULUS_SHA="$(sha256sum "$CASE_STIM" | cut -d' ' -f1)"
  require_field "stimulus_sha256 (case $CASE_ID)" "$STIMULUS_SHA"
  say "  [ok]   case $CASE_ID stimulus.txt sha256: $STIMULUS_SHA"

  # ---- WO-0078 §3.3 item 1 — case 0's frozen-baseline gate. Checked BEFORE
  #      case 0's own pipeline runs, and case 0 is always first in $CASES,
  #      so this fires before any case in the set has a pipeline run at
  #      all. A mismatch aborts the WHOLE script here: "nothing else is
  #      reported... only a defect in itself" — no per-case line, for case
  #      0 or for anything after it. Citation per `RV-STAGE1` §1's own
  #      standing note (this round's own repair; value unchanged since
  #      Stage 1 -- see CASE0_PINNED_SHA256's own comment for the full
  #      account): cite the re-anchored, genuinely pre-widening run, never
  #      the run this literal happened to be read off originally. ----
  if [ "$CASE_ID" = "0" ]; then
    say "  case 0 stimulus_sha256 (this run):                                 $STIMULUS_SHA"
    say "  case 0 stimulus_sha256 (pinned -- freeze's own independent anchor,"
    say "    RV-STAGE1 §1, build run 31080871169, job 92549154623,"
    say "    commit 55e16ae):                                                 $CASE0_PINNED_SHA256"
    if [ "$STIMULUS_SHA" != "$CASE0_PINNED_SHA256" ]; then
      say "  MISMATCH — case 0 has moved (WO-0078 §3.1 / §10 item 7 says it never"
      say "  should). WO-0078 §3.3 item 1: this is reported and nothing else is —"
      say "  a moved reference case has no baseline, so no case's pipeline runs."
      die "$EXIT_CASE0_MOVED" "CASE0-MOVED (case 0's stimulus_sha256 no longer matches the last green pre-widening run)"
    fi
    say "  [ok]   case 0's stimulus is byte-identical to the last green pre-widening run"
  fi

  # ---- check 4.1: differential + timing comparison, this case's run1 ----
  # FINDING RV-0078-S1-3's repair (this round): Stage 1's own probe timed
  # ONLY this call, under-reporting the true per-case marginal by roughly
  # half (run_pipeline runs twice per case, once here and once at check
  # 4.3, below). `RUN1_START_NS`/`RUN2_START_NS` below bracket each call
  # individually now, and their sum is also printed, so Band A's linearity
  # clause is actually readable from this run's own output at N=3.
  RUN1_START_NS="$(date +%s%N)"
  if ! run_pipeline "$CASE_DIR/run1" "case $CASE_ID run1" "$CASE_STIM"; then
    RUN1_NS="$(elapsed_ns_since "$RUN1_START_NS")"
    record_case_refusal "$EXIT_BUILD" "PRODUCE ($PIPE_FAIL_REASON)"
    say "  [cost] case $CASE_ID pipeline wall time (run1): $(format_ns "$RUN1_NS")"
    say "CASE $CASE_ID: stimulus_sha256=$STIMULUS_SHA compare_exit=N/A tier=PRODUCE-REFUSAL ($PIPE_FAIL_REASON)"
    print_case_summary "$CASE_ID" 0 "$STIMULUS_SHA" "PRODUCE-REFUSAL ($PIPE_FAIL_REASON)"
    continue
  fi
  RUN1_NS="$(elapsed_ns_since "$RUN1_START_NS")"
  say "  [cost] case $CASE_ID pipeline wall time (run1): $(format_ns "$RUN1_NS")"

# compare.ml REQUIRES exactly two positional args -- no cwd-default, unlike
# ours_run (confirmed against the landed source; see header). Round 1 called
# this with zero arguments under the assumption it defaulted like ours_run
# does; it does not, and that call would always have hit compare's own
# usage branch (exit 2) without comparing anything. Fixed in round 2.
  DIFF_OUT="$("$COMPARE_BIN" "$CASE_DIR/run1/ours.canon" "$CASE_DIR/run1/theirs.canon" 2>&1)"
  DIFF_RC=$?
  say "$DIFF_OUT"

# ROUND 3 (WO-0049 §8, ACCEPTED at RV-0049-VERDICT): classify compare's exit
# code along the "did the lane reach a verdict?" axis instead of collapsing
# every nonzero onto EXIT_DIFFERENTIAL(4). compare's own contract
# (test/cosim/compare.ml, WO-0049 §5): 0 clean, 1 divergence, 2 usage error,
# 3 could not read a canonical file (no verdict reached at all). This call
# site always passes exactly the two required positional arguments above, so
# compare's own usage branch can NEVER legitimately fire here -- an observed
# 2 is therefore never "usage"; it is the OCaml runtime's OWN
# uncaught-exception exit code, which happens to collide with the usage code
# compare.ml chose (dv_lead, RV-0049-VERDICT §4, measured: a bare `failwith`
# alone exits 2 under the system OCaml toolchain). A bare 2 cannot
# distinguish "usage" from "compare crashed internally", so this script
# never guesses which.
#
# ROUND 4 (WO-0075 §6, drafted this round): compare's contract grows by two
# more codes, both keyed off its new timing tiers (WO-0075 §3) and both
# ranked BELOW its own content comparison (WO-0075 §6's pinned precedence:
# content first, then T0, then T1, then clean) -- 4 = T1 reached a verdict
# and it was negative, 5 = T0 did not align so T1/T2 were withheld. Both are
# now REAL, DOCUMENTED codes with their own case arms below, not part of the
# unrecognized set any more. The wildcard's own contract is UNCHANGED by this
# round (WO-0075 §11 depends on that): an unrecognized/ambiguous code (2, or
# anything else outside {0,1,3,4,5}) is still fail-closed as INTERNAL(9),
# never as DIFFERENTIAL(4), never as a TIMING code, and never read as
# "usage".
#
# ROUND 5 (WO-0078 §5.3/§3.3): a `6` arm joins the set below --
# `Unassertable`, landed by tb_writer at `3ec0efe`, previously unreachable
# and therefore previously (correctly, for its time) falling to the
# wildcard. Every arm stops calling `die` directly: a case's own outcome is
# RECORDED (`record_case_refusal`/the AGG_* flags) and its own required
# line is printed regardless (WO-0078 §12 criterion 3), and the AGGREGATE
# section after this loop is what actually exits non-zero.
#
# ROUND 6 (`WO-0078` §6.2 Stage 2, `RV-STAGE1` §5 OQ1/OQ2's amendment, this
# round): AT STAGE 1 the wildcard arm was the ONE exception to the rule
# above -- byte-identity-pinned, dying immediately, printing no per-case
# line for the case that tripped it -- because it was, by this file's own
# then-current commentary, unreachable under any call this script itself
# made. dv_lead's own Stage-1 review (`RV-STAGE1` §5 OQ2) accepted that
# narrow exception but added a bound this round now closes: "At N > 1 the
# wildcard's immediate `die` also loses EVERY SUBSEQUENT case's line --
# cases with no connection to the comparator's misbehaviour." With three
# cases landing in this round, N > 1 is no longer hypothetical. The
# wildcard's successor, quoted from `RV-STAGE1` §5 OQ1/OQ2 verbatim: "it
# SHALL record-and-continue like every other arm, printing a line that
# names the raw code without classifying it ... and EXIT_INTERNAL SHALL
# become an aggregate code decided after the loop, ranking ABOVE every
# other code in §3.3's precedence -- a comparator outside its contract
# invalidates every case's verdict, not merely its own." Implemented below:
# the arm sets `CASE_TIER` to the RAW code (never a fabricated
# classification -- "a fabricated tier is worse than an absent line",
# `RV-STAGE1` §5), calls `record_case_internal` (first case across the set
# to trip it wins the aggregate's own label, same pattern as
# `record_case_refusal`), and FALLS THROUGH to the same per-case print,
# self-test and determinism check every classified arm above it reaches --
# it is not a special case any more, it is the last case, which is what
# "record-and-continue like every other arm" means literally.
  # ROUND 7 (`WO-0078` §6.2 Stage 2, the C3 landing, `FINDING RV-0078-S2-7`'s
  # repair, this round): every arm below now also sets `CASE_HAS_RESULT` --
  # "1" for the WO-0049 §8 reached-a-verdict family (CLEAN, DIFFERENTIAL,
  # TIMING), "0" for the did-not-reach-a-verdict family (NO-VERDICT,
  # TIMING-NO-VERDICT, TIMING-UNASSERTABLE, INTERNAL) -- the same
  # enumeration the EXIT CODES section above already partitions this exact
  # axis by. `print_case_summary` (defined above the CASE LOOP) reads this
  # flag at the loop body's tail to decide whether the timing sentence
  # prints; nothing else in this arm's own behaviour changes.
  case "$DIFF_RC" in
    0)
      CASE_TIER="CLEAN"
      CASE_HAS_RESULT=1
      ;;
    1)
      CASE_TIER="DIFFERENTIAL (REQ-901 content divergence)"
      CASE_HAS_RESULT=1
      AGG_CONTENT=1
      dump_run "$CASE_DIR/run1" "case $CASE_ID run1"
      ;;
    3)
      CASE_TIER="NO-VERDICT (compare could not read a canonical file/idle sidecar, exit 3)"
      CASE_HAS_RESULT=0
      record_case_refusal "$EXIT_NO_VERDICT" "NO-VERDICT (case $CASE_ID: compare could not read a canonical file, exit 3)"
      dump_run "$CASE_DIR/run1" "case $CASE_ID run1"
      ;;
    4)
      CASE_TIER="TIMING (T1 negative against SPEC-M03 §6.1, exit 4)"
      CASE_HAS_RESULT=1
      AGG_T1_NEG=1
      dump_run "$CASE_DIR/run1" "case $CASE_ID run1"
      ;;
    5)
      CASE_TIER="TIMING-NO-VERDICT (T0 unaligned, exit 5)"
      CASE_HAS_RESULT=0
      AGG_T0=1
      dump_run "$CASE_DIR/run1" "case $CASE_ID run1"
      ;;
    6)
      # WO-0078 §5.3's own new arm: T1 REFUSED to certify (Canonical.
      # Unassertable, landed by tb_writer at 3ec0efe) -- a carried nonzero
      # idle count or a single-broken-delta shape indistinguishable from
      # one. A refusal outranks a reached-and-negative T1 verdict (4) in
      # WO-0078 §3.3's own aggregate precedence, on the same "did the lane
      # reach a verdict?" axis WO-0049 §8 built this whole table around --
      # see EXIT_TIMING_UNASSERTABLE's header note for the full argument.
      CASE_TIER="TIMING-UNASSERTABLE (T1 declined to certify, exit 6)"
      CASE_HAS_RESULT=0
      AGG_T1_UNASSERTABLE=1
      dump_run "$CASE_DIR/run1" "case $CASE_ID run1"
      ;;
    *)
      # `RV-STAGE1` §5 OQ1/OQ2's successor rule (this round) -- see the
      # ROUND 6 note above for the finding text in full. Ambiguous or
      # unrecognized -- most notably compare's own 2, which this call
      # site's fixed, always-correct two-argument invocation can never
      # legitimately produce via compare's usage branch (see the comment
      # above `case "$DIFF_RC"`). The RAW code is named, never classified:
      # no `AGG_CONTENT`/`AGG_T0`/`AGG_T1_*` flag is set, because none of
      # those tiers is what happened here -- a comparator outside its own
      # documented contract has not reached ANY of REQ-901's, T0's, or
      # T1's verdicts, reached-and-negative or otherwise, and asserting one
      # of those labels over it would be exactly the fabricated
      # classification the finding bars.
      CASE_TIER="INTERNAL (compare exit $DIFF_RC outside its documented contract {0,1,3,4,5,6})"
      CASE_HAS_RESULT=0
      record_case_internal "$CASE_ID" "$DIFF_RC"
      dump_run "$CASE_DIR/run1" "case $CASE_ID run1"
      ;;
  esac

  # WO-0078 §3.2/§12 criterion 3's own required line: case id,
  # stimulus_sha256, compare's own exit code, the tier that produced it.
  # Printed unconditionally, whatever the tier -- this is the line that
  # keeps a case that is not clean from ever being silently absorbed into
  # the aggregate (§12 criterion 3: "A case that is skipped, or whose
  # result is folded into an aggregate without its own line, fails --
  # including when the aggregate is 0."). As of this round the wildcard's
  # own outcome reaches this line too (`RV-STAGE1` §5 OQ2) -- no arm is
  # exempt any more.
  say "CASE $CASE_ID: stimulus_sha256=$STIMULUS_SHA compare_exit=$DIFF_RC tier=$CASE_TIER"

  # ---- check 4.2: DELIBERATE-MISMATCH SELF-TEST — does not depend on any
  #      case's stimulus; runs exactly ONCE, in the same relative position
  #      WO-0046 §4 always put it (after the first case's own 4.1, before
  #      that case's own 4.3). Unaffected by the case set: still an
  #      immediate, whole-run die on failure, because a comparator that
  #      cannot be trusted on its own hand-built fixtures cannot be trusted
  #      on any case's real output either. ----
  if [ "$SELFTEST_DONE" -eq 0 ]; then
    hdr "CHECK — DELIBERATE-MISMATCH SELF-TEST (WO-0046 §4.2, run once)"
    SELFTEST_OUT="$("$COMPARE_BIN" --self-test 2>&1)"
    SELFTEST_RC=$?
    say "$SELFTEST_OUT"
    if [ "$SELFTEST_RC" -ne 0 ]; then
      die "$EXIT_SELFTEST" "SELF-TEST (compare --self-test exited $SELFTEST_RC)"
    fi
    say "  SELF-TEST: PASSED — the production comparison path was confirmed to"
    say "  report a difference when one is seeded, via the same binary as check 4.1."
    SELFTEST_DONE=1
  fi

  # ---- check 4.3: two-run determinism, THIS case's own run2 ----
  # FINDING RV-0078-S1-3's repair (this round, continued from run1 above):
  # this is the SECOND run_pipeline call Stage 1's own probe never timed.
  # Timed the same way run1 is, plus the two summed, so a reader can see
  # BOTH halves of what "this case's own pipeline" actually costs.
  RUN2_START_NS="$(date +%s%N)"
  if ! run_pipeline "$CASE_DIR/run2" "case $CASE_ID run2" "$CASE_STIM"; then
    RUN2_NS="$(elapsed_ns_since "$RUN2_START_NS")"
    record_case_refusal "$EXIT_BUILD" "PRODUCE ($PIPE_FAIL_REASON)"
    say "  [cost] case $CASE_ID pipeline wall time (run2): $(format_ns "$RUN2_NS")"
    say "  case $CASE_ID determinism: NOT CHECKED -- run2 did not produce a comparable pair ($PIPE_FAIL_REASON)"
    # ROUND 7: run1's own tier ($CASE_TIER, printed on the CASE line above)
    # is not asserted as a claim here -- ADR-0015 D3's reproducibility
    # guarantee is precisely what run2's own failure leaves unconfirmed, so
    # this case's SUMMARY reports NO RESULT (has_result=0) regardless of
    # what run1's compare returned, same as the other two PRODUCE-REFUSAL
    # sites above.
    print_case_summary "$CASE_ID" 0 "$STIMULUS_SHA" "PRODUCE-REFUSAL (determinism check's own second run, case $CASE_ID: $PIPE_FAIL_REASON; run1's own tier was $CASE_TIER, unconfirmed reproducible)"
    continue
  fi
  RUN2_NS="$(elapsed_ns_since "$RUN2_START_NS")"
  say "  [cost] case $CASE_ID pipeline wall time (run2): $(format_ns "$RUN2_NS")"
  say "  [cost] case $CASE_ID pipeline wall time (run1+run2, sum -- excludes this"
  say "    case's own compare/self-test time in between): $(format_ns "$((RUN1_NS + RUN2_NS))")"
  DET_STATUS=0
  OURS_DIFF="$(diff -u "$CASE_DIR/run1/ours.canon" "$CASE_DIR/run2/ours.canon" 2>&1)" || DET_STATUS=1
  THEIRS_DIFF="$(diff -u "$CASE_DIR/run1/theirs.canon" "$CASE_DIR/run2/theirs.canon" 2>&1)" || DET_STATUS=1
  if [ "$DET_STATUS" -ne 0 ]; then
    say "  case $CASE_ID: ours.canon differs between run1 and run2:"
    say "$OURS_DIFF"
    say "  case $CASE_ID: theirs.canon differs between run1 and run2:"
    say "$THEIRS_DIFF"
    dump_run "$CASE_DIR/run1" "case $CASE_ID run1"
    dump_run "$CASE_DIR/run2" "case $CASE_ID run2"
    record_case_refusal "$EXIT_DETERMINISM" "DETERMINISM (case $CASE_ID: canonical files differ between run1 and run2)"
  else
    say "  case $CASE_ID: ours.canon/theirs.canon byte-identical between run1 and run2"
  fi

  # WO-0078 §3.2's own instruction: "the existing per-run SUMMARY block is
  # retained per case." FINDING RV-0078-S2-7's repair (ROUND 7, this round):
  # this call site used to BE the SUMMARY block, printed here
  # unconditionally -- exactly the defect this round fixes; see
  # `print_case_summary`'s own definition, above the CASE LOOP, for the
  # reasoning in full. Every OTHER per-case exit path (stimulus_gen
  # refusal, run1 refusal, run2 refusal) now calls the same function before
  # its own `continue`, so this call site is reached only by a case that
  # ran its whole loop body to the end without one -- but it is
  # `print_case_summary` itself, not this call site, that decides whether
  # the timing sentence prints, keyed off `$CASE_HAS_RESULT` set in the
  # `case "$DIFF_RC"` statement above.
  print_case_summary "$CASE_ID" "$CASE_HAS_RESULT" "$STIMULUS_SHA" "$CASE_TIER"
done

# ------------------------------------------------------------------ #
# AGGREGATE — WO-0078 §3.3's precedence, AS AMENDED by `RV-STAGE1` §5     #
# OQ1/OQ2 (this round). Case 0 moved is handled inside the loop above,   #
# because it aborts before any case runs. Of what remains, EXIT_INTERNAL #
# is now checked FIRST -- dv_lead's own words: "EXIT_INTERNAL SHALL      #
# become an aggregate code decided after the loop, ranking ABOVE every   #
# other code in §3.3's precedence -- a comparator outside its contract   #
# invalidates every case's verdict, not merely its own." Everything else #
# is decided in WO-0078 §3.3's own original order, unchanged.            #
# ------------------------------------------------------------------ #

hdr "AGGREGATE (WO-0078 §3.3, RV-STAGE1 §5 OQ1/OQ2 amendment)"
if [ "$AGG_INTERNAL_HIT" -eq 1 ]; then
  # RV-STAGE1 §5 OQ2's amendment: ranks above everything else decided here.
  die "$EXIT_INTERNAL" "$AGG_INTERNAL_LABEL"
elif [ -n "$AGG_REFUSAL_LABEL" ]; then
  # item 2: any producer refusal, any case -> its own code.
  die "$AGG_REFUSAL_CODE" "$AGG_REFUSAL_LABEL"
elif [ "$AGG_CONTENT" -eq 1 ]; then
  # item 3: content divergence, any case.
  die "$EXIT_DIFFERENTIAL" "DIFFERENTIAL COMPARISON (a content divergence was reported by at least one case -- see its own CASE line above)"
elif [ "$AGG_T0" -eq 1 ]; then
  # item 4: T0 unaligned, any case.
  die "$EXIT_TIMING_NO_VERDICT" "TIMING-NO-VERDICT (T0 did not align for at least one case -- see its own CASE line above)"
elif [ "$AGG_T1_UNASSERTABLE" -eq 1 ]; then
  # item 5: T1 unassertable, any case.
  die "$EXIT_TIMING_UNASSERTABLE" "TIMING-UNASSERTABLE (T1 declined to certify for at least one case -- see its own CASE line above)"
elif [ "$AGG_T1_NEG" -eq 1 ]; then
  # item 6: T1 negative, any case.
  die "$EXIT_TIMING" "TIMING (T1 reached a negative verdict for at least one case -- see its own CASE line above)"
fi

# item 7: otherwise, EXIT_OK.
say "  every case in the set reached a verdict and every verdict was clean."
say "  [cost] run_cosim.sh wall time (this invocation): $(elapsed_since "$JOB_START_NS")"
say "  WO-0078 §12 criterion 9: this run's green is co-simulation coverage for"
say "  the classes the landed case set drives, and for no other -- see the"
say "  per-case CASE lines above for exactly which cases those were."
exit "$EXIT_OK"
