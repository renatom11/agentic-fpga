# WO-0041 — five seeded family-D mutations of M03, authored blind

- **Author**: auditor (independent; I authored neither M03's RTL nor any part of
  its bench, and I have no stake in either verdict)
- **Date**: 2026-08-03
- **Packet**: `agents/handoffs/WO-0041_family-d-mutation-campaign.md` (committed
  at `06007a3`) — dv_lead's brief, §§1–6 of which are my whole instruction
- **Subject under test**: **not M03.** Family D of `test/xgmii_rx_64/**`, and
  whether it has teeth (packet's own framing)
- **Base**: every diff is against `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
  **exactly as it stands at `447d11c`** — blob
  `81cd9ed7fc64e6265c53117f251ef948f24e3b00`, sha256
  `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`. Each
  diff's own `index 81cd9ed..` line names that preimage blob, so `git apply
  --3way` verifies the base as well as the context. *Falsifiable side note*:
  `git diff --stat 6bd7e5a 447d11c -- libs/` is **empty**, so this file is
  byte-identical to WO-0039's base — the BUG-0001 `fcs_tail` fix is in both, and
  `447d11c` moved only `test/`, a packet and dv_lead's journal.
- **Artifacts**: `D-M1.diff` … `D-M5.diff` in this directory. Each is a
  single-file unified diff applying with `git apply` from the repository root.
  They are reproduced in full in §3; **the `.diff` files are authoritative** and
  the inlined text is generated from them, never retyped.
- **Journal**: `J-auditor-0005`

> **These patches are mutations. They are never to be committed to any branch
> that merges.** Packet §4: one throwaway branch per mutation, parent
> `447d11c`, exactly one diff, never merged. Every hunk carries a
> `D-MN MUTATION (WO-0041)` marker comment so that a leaked mutant is greppable
> with one `grep -rn 'MUTATION (WO-0041)'`.

---

## 1. Scope statement — the ten bars, and the prior-exposure disclosure

Packet §1 sets eight read bars and two process bars on me for the campaign's
duration, and §0 makes my own `Inputs` disclosure the whole of the enforcement.
**All ten were honoured.** Stated individually, in the packet's own order.

### 1.1 The eight read bars

1. **`test/xgmii_rx_64/**` — not read.** I opened no file under `test/` at all,
   of any name, at any SHA, in this session. I did not read `test_m03_d.ml`, nor
   the family-D dune stanza, nor any sibling family.
2. **`test/attack_plans/AP-xgmii_rx_64.md` — not read.** Nor any other file
   under `test/attack_plans/`.
3. **`agents/handoffs/WO-0040_tb-m03-family-d-fcs.md` — not read.** I therefore
   have not seen the published D-M1…D-M4 → row table that §0 warns me about, and
   I did not go looking for it. §2's intents were sufficient without it.
4. **`agents/handoffs/WO-0039_m03-mutation-campaign.md` — not read in this
   session.** See §1.3 for the prior spawn.
5. **`agents/handoffs/WO-0039_m03-mutation-campaign-SEALED-predictions.md` — not
   opened.**
6. **`agents/handoffs/WO-0041_family-d-mutation-campaign-SEALED-predictions.md`
   — not opened.** I know of it only that it exists and its path: the path
   appears in `git log --name-only -1 06007a3`, which prints file names and no
   content.
7. **`agents/journals/claude_dv_lead_agent.md` — not read**, whole file, and I
   asked for no extraction because nothing in this task needed one.
8. **`agents/journals/workers/claude_tb_writer_agent.md` — not read.**

### 1.2 The two process bars

9. **All five diffs were authored before any of them was run**, and none has
   been run: no simulation, no elaboration, no `dune build`, no `dune runtest`.
   The five were written as one act against §2's five intents, and the last was
   finished before the first left my hands. The only executions in this work
   order are the mechanical checks of §4 — `git apply --check`, a parse-only
   `ocamlc` invocation, and text arithmetic — none of which builds or runs the
   design, and none of which involves the bench.
10. **No diff has been revised after any run result**, there being no run result
    in existence to revise it against. **No compile-only repair was needed or
    made** (bar 10's sole exception is unused).

### 1.3 Prior exposure — items 3–8, before this brief

The precise answer to "what do you recall reading" is **nothing**: PROTOCOL §2
makes agents stateless between spawns, and my context for this task begins with
this brief. I therefore do not *recall* the WO-0039 seeding at all. What exists
instead is that spawn's own committed disclosure — §1 of
`docs/reports/audit/WO-0039-mutations/README.md`, a file with **exactly one
commit** (`git log --oneline -- docs/reports/audit/WO-0039-mutations/README.md`
prints one line, `0556f23`) and therefore never amended with anything learned
later. I read that section in this session, deliberately, so that this
disclosure is *checkable* rather than remembered. Against WO-0041 §1's bar list
it says:

| Bar item | The WO-0039 seeding spawn (record: `0556f23`) | This spawn |
|---|---|---|
| 1. `test/**` | not read (its §1 item 1: "I opened no file under `test/` at all") | not read |
| 2. `AP-xgmii_rx_64.md` | not read (its §1 item 2) | not read |
| 3. WO-0040 packet | **could not have read it** — every commit in `git log --oneline -12` whose subject names WO-0040 or family D (`0b90227`, `7651ddd`, `7fac574`, `cf77631`, `447d11c`) is **newer** than `0556f23`, so the packet did not exist when that report was written | not read |
| 4. WO-0039 packet | **read in full, at `0d231ee`.** `RV-0039-VERDICT` was appended to that file at `c3a3ffa` and its addendum at `fe1a7f6`, **both after `0556f23`** — so the text that spawn read was the brief, and the verdict was not yet in the file to read | not read |
| 5. WO-0039 SEALED companion | not opened (its §1 item 3) | not read |
| 6. WO-0041 SEALED companion | did not exist (first commit `06007a3`) | not opened |
| 7. dv_lead's journal | explicitly not read, and recorded as a deliberate abstention under "Deliberately not read, though nothing barred them" | not read |
| 8. tb_writer's worker journal | absent from that report's *complete* read list, which is the enforcement record — so not read | not read |

Two further facts make item 4's exposure narrower than even the brief allows
for. The family-D bench does not exist at `0556f23` — the commits whose subjects
announce it (`0b90227` "WO-0040 family D authored", `7651ddd` "WO-0040: family D
written", `cf77631` "Family D green on the board") are all **newer** than the
WO-0039 report, in the same `git log --oneline -12` — so **no prior spawn of
mine could have seen the bench under test, in principle**. I did not run a
path-scoped log on any bench file to establish this and did not need to. And the
WO-0039 packet governed families A–C's machinery, not family D's.

**The brief's ruling** — that this exposure is already known and acceptable —
is recorded here as received, not as something I am judging for myself.

### 1.4 Ambient exposure I am disclosing because a bar list is a floor

Three things reached me in this session that are not the barred *files* but sit
near them. I report them rather than decide for the reader:

- **Commit subject lines.** I ran `git log --oneline -12`, `git log --name-only
  -1 06007a3`, and three path-scoped `git log --oneline` calls to establish base
  SHAs and file histories. **One of those three was on a barred path** —
  `agents/handoffs/WO-0039_m03-mutation-campaign.md` (bar item 4) — run to date
  `RV-0039-VERDICT`'s arrival for §1.3's table; the other two were the WO-0041
  packet and my own WO-0039 report. A path-scoped log prints commit subjects and
  SHAs, **not one byte of the file**, and I did not follow it with `git show`.
  Their output includes subjects that summarise
  outcomes — `c3a3ffa` ("RV-0039-VERDICT: 5/5 kills, 21/21 required through
  predicted channels …"), `7fac574` ("RV-0040-VERDICT: ACCEPT — … runtest
  predicted green-silent …"), `cf77631` ("Family D green on the board …"),
  `06007a3` ("… 5×12 matrix measured not labelled, eight blinding bars swept,
  D-M5 the fully-blinded discriminator"). I read those subject lines. They name
  **no bench unit, no expected value, and no D-M → row mapping**, and I ran
  `git show` on no commit touching `test/`. I did not seek them; they are what
  `git log` prints.
- **The shared scratchpad's directory listing.** `/tmp/…/scratchpad` is shared
  across this environment's agents and its `ls -la` shows other agents' working
  files, including `HEAD_test_m03_a.ml`, `HEAD_test_m03_b.ml`,
  `HEAD_test_m03_c.ml`, `HEAD_test_m03_structural.ml`, `rv40.md`,
  `wo40_final.md`, `wo40_inter.md`. **I opened none of them**, and my own work
  went into freshly named files (`mutate_d.py`, `mutwork/`, `checkdir/`,
  `parsecheck/`). Copies of barred artifacts are one `cat` away in that
  directory and the only thing standing between them and this campaign is this
  paragraph, which is precisely the honest-enforcement model my charter §9
  describes.
- **My own WO-0039 artifacts.** I read `docs/reports/audit/WO-0039-mutations/README.md`
  lines 1–91 and `M3.diff` in full. These are my own committed output, barred by
  nothing, read for the diff format and for §1.3's record. They contain RTL and
  disclosures only — that report was itself authored blind.

### 1.5 Complete list of everything read for this work order

This is the enforcement record. If it shows a bench file, an attack plan or a
sealed file, the mutations authored around it are void.

| Path | Extent |
|---|---|
| `agents/charters/auditor.md` | full |
| `agents/PROTOCOL.md` | full |
| `agents/handoffs/WO-0041_family-d-mutation-campaign.md` | full (at `06007a3`) |
| `docs/specs/modules/xgmii_rx_64.md` | full, all 949 lines (SPEC-M03), in three reads |
| `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` | full, at `447d11c` (extracted with `git show` into the scratchpad; the working tree's copy was never touched) |
| `libs/hardcaml_ethernet/src/xgmii_rx_64.mli` | full |
| `libs/hardcaml_ethernet/src/dune`, `dune-project`, `.ocamlformat` | full (build surface: `ppx_hardcaml`, `ppx_jane`; janestreet profile, ocamlformat 0.26.2) |
| `.github/workflows/build.yml` | **grep hits only** — lines 28 and 41, from one grep for `fmt|dune build|runtest`, to establish whether a format check gates CI (it does not) |
| `docs/adr/ADR-0005-build-environment.md` | lines 1–60 (why I cannot compile) |
| `docs/reports/audit/WO-0039-mutations/README.md` | lines 1–91 (my own prior report: §1.3's record and the diff format) |
| `docs/reports/audit/WO-0039-mutations/M3.diff` | full (my own prior artifact) |
| `agents/journals/claude_auditor_agent.md` | `tail -5` plus a grep of its entry-header lines, for the next entry id and the grammar. **Read only, never modified above EOF** |
| git metadata | `git log --oneline -12`; three path-scoped `git log --oneline` calls (the WO-0041 packet, the WO-0039 packet — a barred path, subjects only, §1.4 — and my own WO-0039 report); `git log --oneline --name-only -1 06007a3`; `git show 447d11c --stat`; `git diff --stat 447d11c HEAD -- libs/`; `git diff --stat 6bd7e5a 447d11c -- libs/`; `git rev-parse` / `sha256sum` on the base blob. **No `git show` of any commit's content**, and no `git diff` output other than the `--stat` name/count lines above |
| directory listings | `ls libs/hardcaml_ethernet/src/`, `ls docs/reports/audit/`, `ls docs/reports/audit/WO-0039-mutations/`, `ls .github/workflows/`, `ls -a` at the repo root, `ls -la` of the shared scratchpad |

**Deliberately not read, though nothing barred them** — recorded because the
campaign's validity rests on what I did not see:

- `libs/hardcaml_ethernet/src/crc32_eth.ml` and its `.mli`. WO-0039 needed M02's
  finished-value convention; this campaign does not — no family-D intent touches
  how the CRC is computed, only what is done with its result — so I stayed out.
- `agents/handoffs/BUG-0001_*`, `SO-*`, `RV-*` packets of any number, and
  `tasks/BOARD.md`.
- `agents/journals/` other than my own tail: rtl_lead's, the orchestrator's, the
  worker journals. My charter's read scope includes every one of them and I
  stayed out on purpose for the campaign's duration.

---

## 2. What is delivered

Five diffs, one per §2 intent, each **minimal** (the smallest change producing
the described behaviour) and **faithful** (behaving *as described*, not merely
broken nearby). Nothing was unachievable: no intent was substituted, and §5
carries the three precisions where a stated intent needed a reading rather than
a transcription.

| id | one-line mechanism | site (base line) | hunks | code lines changed |
|---|---|---|---|---|
| D-M1 | the REQ-104 residue comparison is forced to *match* by an inserted `gnd &:` conjunct | `bad_fcs`, 471 | 1 | 1 |
| D-M2 | the same comparison forced to *mismatch* by an inserted `vdd \|:` disjunct, with `has_fcs` left outside it | `bad_fcs`, 471 | 1 | 1 |
| D-M3 | the closure record carries only "this frame had an FCS"; the residue comparison moves to the consumption site and reads `crc_reg` there | `bad_fcs` 471 + `sel_bad_fcs` 533 | 2 | 2 |
| D-M4 | `error_bad_fcs` is taken from the age-0 record instead of the consumed one | `error_bad_fcs` field, 761 | 2 | 1 |
| D-M5 | `error_bad_fcs` is driven low; the verdict and `tuser`[0] are untouched | `error_bad_fcs` field, 761 | 2 | 1 |

All five touch exactly one file, `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`,
and no other file in the repository.

**The tuser[0]-is-a-disjunction precision (packet §2), held.** `tuser`[0] is
`emit_tlast &: abort`, and `abort = sel_bad_fcs |: sel_error |: sel_start |:
sel_oversize |: sel_runt` (base line 736). In every one of the five, the four
non-FCS disjuncts are **textually untouched** and reach `abort` by their own
terms; D-M1/D-M2/D-M3 change only what the `sel_bad_fcs` disjunct evaluates to,
and D-M4/D-M5 do not change even that. **No diff forces `tuser`[0] itself to a
constant**, and none touches the second report path (`q2`, epochs B and C),
which carries no FCS bit at all. REQ-107's runt, REQ-105's error character and
REQ-108's oversize therefore keep both their marking and their strobes in all
five.

---

## 3. The five mutations

### 3.1 D-M1 — hardwire the FCS verdict to *good*

**Intent as understood.** The REQ-104 check concludes "the received FCS matches"
for every frame, whatever the frame carries. Four consequences: the FCS path
contributes 0 to `tuser`[0] always; `error_bad_fcs` never pulses for any frame;
a good-FCS frame is indistinguishable from today; runt, oversize and
error-character marking and strobes are untouched.

**Mechanism.** `bad_fcs` (base line 471) *is* the REQ-104 verdict — the single
expression every downstream consequence is reached through: the closure record's
bit 5, `sel_bad_fcs`, `abort`'s FCS disjunct and the `error_bad_fcs` field. The
diff inserts one conjunct, `gnd &:`, in front of it. The result is a constant 0
verdict, so bit 5 of every closure record is 0, `sel_bad_fcs` is 0 on every
cycle, and `strobe sel_bad_fcs` is 0 on every cycle.

**Fidelity.** Everything upstream of the verdict is left standing: coverage,
counts, `has_fcs`, the CRC chain and its M02 instance, alignment, `tkeep`,
`tlast`, `tvalid` and every other strobe. A good-FCS frame is therefore
bit-identical to the original, which is what "indistinguishable from today"
requires. A bad-FCS **runt** still gets `tuser`[0] = 1 — from `sel_runt`, not
from the FCS path — which is exactly what "touch only the REQ-104 contribution"
means and is the case that separates this from forcing `tuser`[0] low. §9's
ninth ruling is unaffected because `has_fcs` still stands (it is now
irrelevant, not wrong). The CRC subgraph remains driven — `crc_final` still
feeds `crc_reg` — so M02 is still instantiated and REQ-018's structure is
unchanged, which matters for any structural check that counts emitted modules.

**On its quietness.** The packet instructs me to expect this one to look too
quiet and not to improve it, and I have not. The only frames whose observable
behaviour changes at all are those ending in a terminate character, with ≥ 5
received octets, whose FCS is wrong. A version that reddened more would be a
different defect.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..59ba4f4 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -468,7 +468,14 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      something else, so a design that compares here reports "this frame's FCS
      is wrong" as a function of octets §9 says nothing is removed from. *)
   let has_fcs = count_next >=:. fcs_min_octets in
-  let bad_fcs = has_fcs &: (crc_final <>: of_int ~width:32 fcs_residue) in
+  (* D-M1 MUTATION (WO-0041): REQ-104's residue comparison is forced to
+     "the received FCS matches" — for every frame, whatever the frame
+     carries. The [gnd] conjunct is the whole of the mutation; [has_fcs] and
+     the comparison are left standing so that no binding above is orphaned.
+     Only the REQ-104 contribution to [tuser][0] and the whole of
+     [error_bad_fcs] go with it: REQ-107's runt, REQ-105's error character
+     and REQ-108's oversize reach [abort] by their own terms below. *)
+  let bad_fcs = gnd &: has_fcs &: (crc_final <>: of_int ~width:32 fcs_residue) in
   (* One reload condition for both state registers, and it is [begins]: the
      word that hands a new frame forward is the word before that frame's first
      octet at both start lanes, whether the frame was admitted from [Idle] /
```

### 3.2 D-M2 — hardwire the FCS verdict to *bad*

**Intent as understood.** The REQ-104 check always concludes mismatch. Every
frame that has an FCS to check is forwarded with `tuser`[0] set from the FCS
path and pulses `error_bad_fcs` on §9's pinned cycle. §9 ruling 9's floor is
respected: a frame with fewer than 5 received octets has no FCS to check and
still pulses nothing from this path.

**Mechanism.** One disjunct, `vdd |:`, inserted **inside** the comparison's
parentheses. `has_fcs` is deliberately left **outside** it, so the verdict
becomes exactly `has_fcs` — "this frame has an FCS, and the check on it says
mismatch".

**Fidelity.** Three properties of the base do the rest of the work and none is
disturbed. (a) The record's field is `a_close_terminate &: bad_fcs`, so only a
frame closed by its terminate character can carry the bit — which preserves §9's
three "never" rulings exactly (`error_bad_frame`, `error_start_without_terminate`
and `error_oversize` still never co-occur with `error_bad_fcs`, because those
frames never reach this field). (b) `has_fcs = count_next >=:. fcs_min_octets`
is untouched and outside the forced disjunct, so §9's ninth ruling holds and a
0-to-4-octet frame still reports `error_runt` alone. (c) The strobe still leaves
through `strobe sel_bad_fcs`, so its cycle is still §9's pin — this mutation
moves no cycle. §9's *first* ruling (`error_runt` with `error_bad_fcs` on a 5-to-63
octet frame) now fires for every runt in that range: that is a consequence of the
stated intent, not an extra defect.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..2a7f3ef 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -468,7 +468,13 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      something else, so a design that compares here reports "this frame's FCS
      is wrong" as a function of octets §9 says nothing is removed from. *)
   let has_fcs = count_next >=:. fcs_min_octets in
-  let bad_fcs = has_fcs &: (crc_final <>: of_int ~width:32 fcs_residue) in
+  (* D-M2 MUTATION (WO-0041): REQ-104's residue comparison is forced to
+     "the received FCS does not match" — for every frame that has one. The
+     [vdd |:] disjunct is the whole of the mutation, and [has_fcs] is
+     deliberately left outside it: §9's ninth ruling still holds, so a frame
+     of fewer than five received octets has no FCS to check and still
+     reports nothing from this path. *)
+  let bad_fcs = has_fcs &: (vdd |: (crc_final <>: of_int ~width:32 fcs_residue)) in
   (* One reload condition for both state registers, and it is [begins]: the
      word that hands a new frame forward is the word before that frame's first
      octet at both start lanes, whether the frame was admitted from [Idle] /
```

### 3.3 D-M3 — read the CRC register at the `tlast` cycle instead of carrying the verdict

**Intent as understood.** The verdict is no longer computed over a frame's own
octets and carried with that frame to its `tlast` word. It is formed at the
moment the `tlast` word is emitted, by comparing the CRC register's value *then*
against REQ-304's residue. On a lone frame this is indistinguishable from
correct; on two frames close together it is not, because §6.1 re-seeds the
register in `Preamble`.

**Mechanism.** Two hunks, which are the two halves of one change. (1) At line
471 the record stops carrying the verdict: `bad_fcs` becomes `has_fcs`, so bit 5
of the closure record carries only "this frame had an FCS to check". (2) At line
533 the verdict is *formed*: `sel_bad_fcs` becomes `bit sel 5 &: (crc_reg <>:
residue)`, evaluated on the cycle the record is consumed — which §9 pins to the
frame's `tlast` cycle, or to age 2 for a frame that emits no word.

**Fidelity — why a lone frame is unaffected, in full**, since this is the
mutation whose fidelity is least self-evident:

- `crc_reg(t) = crc_final(t−1)` unless `begins(t−1)`, in which case it is the
  seed 0 (base line 478).
- On a frame's terminate word `W`, `crc_final(W)` is the complete value §6.1
  item 3 describes — coverage runs through the octet immediately preceding the
  terminate character, which lies in `W`.
- On every later cycle with no coverage, `cov_count` = 0, so `crc_update` = 0,
  so `crc_final = crc_reg` and the register holds. The value therefore survives
  unchanged across the drain.
- §6.1's drain derivation puts the `tlast` word at `W + 1` or `W + 2` at a
  lane-0 start and at `W` or `W + 1` at a lane-4 start. For every candidate
  after `W`, the previous bullet says `crc_reg` still holds the frame's own
  final value. The single candidate *at* `W` is a lane-4-started frame whose
  terminate character is in lane 0 — a word covering no frame octet — where
  `crc_final(W) = crc_reg(W)` and the comparison reads the same value anyway.

So on a lone frame the mutant and the original agree exactly, at both start
lanes and at every length. They diverge exactly when another frame's start
character makes `begins` true, or another frame's octets are being covered,
between the terminate word and the `tlast` cycle: the register then holds the
seed 0 or the next frame's running value, neither of which is the residue, and a
**good** frame is reported bad. The observable is a *false positive on a good
frame*, which is the direction that survives: a bad frame's verdict is wrong
too, but wrong-in-the-same-direction and so invisible. Frames not closed by a
terminate character are unaffected — bit 5 is still gated by `a_close_terminate`
— so §9's "never" rulings still hold.

**Disclosure.** I kept §9 ruling 9's floor rather than dropping it; see §5.2.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..e59da1a 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -468,7 +468,12 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      something else, so a design that compares here reports "this frame's FCS
      is wrong" as a function of octets §9 says nothing is removed from. *)
   let has_fcs = count_next >=:. fcs_min_octets in
-  let bad_fcs = has_fcs &: (crc_final <>: of_int ~width:32 fcs_residue) in
+  (* D-M3 MUTATION (WO-0041): the closure record no longer carries this
+     frame's own verdict. What travels with the frame is only whether it had
+     an FCS to check at all (§9's ninth ruling); the residue comparison
+     itself moves to the consumption site below. The alias keeps [bad_fcs]'s
+     single use — the record's [~fcs] field — textually unchanged. *)
+  let bad_fcs = has_fcs in
   (* One reload condition for both state registers, and it is [begins]: the
      word that hands a new frame forward is the word before that frame's first
      octet at both start lanes, whether the frame was admitted from [Idle] /
@@ -530,7 +535,13 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let sel_error = bit sel 2 in
   let sel_start = bit sel 3 in
   let sel_oversize = bit sel 4 in
-  let sel_bad_fcs = bit sel 5 in
+  (* D-M3 MUTATION (WO-0041): the verdict is formed here rather than
+     carried. Bit 5 is now only "this frame had an FCS to check", and the
+     residue equality is evaluated against [crc_reg] as it stands on *this*
+     cycle — the cycle this frame's `tlast` word is emitted — instead of
+     against the value that frame's own octets left in the register at its
+     terminate character. §6.1 re-seeds the register in [Preamble]. *)
+  let sel_bad_fcs = bit sel 5 &: (crc_reg <>: of_int ~width:32 fcs_residue) in
   let sel_runt = bit sel 6 in
   (* ---- the second report path: an epoch opened *and* closed in one word ----
      Such a frame delivers no octet — its eight preamble octets fill the rest of
```

### 3.4 D-M4 — pulse `error_bad_fcs` one cycle early, on the terminate cycle

**Intent as understood.** The verdict is correct and `tuser`[0] is marked on the
correct word. Only the strobe's cycle moves: `error_bad_fcs` pulses on the cycle
carrying the frame's terminate character rather than on the cycle M03 emits that
frame's `tlast` word (§9's pin). No other strobe moves.

**Mechanism.** The `error_bad_fcs` output field stops reading the *consumed*
record and reads the *age-0* one instead: `a_close_terminate &: bad_fcs`, which
is the exact expression the record's `~fcs` field is built from (base line 513),
gated by `~:(i.clear)` — the same REQ-009 gate the `strobe` helper applies. The
verdict is unchanged, still enters the record, still ages, and is still consumed
by `abort`.

**Fidelity.** `abort` still reads `sel_bad_fcs`, so `tuser`[0] is still set on
the right word of the right frame — the mutation is a pure cycle move, as
specified. The pulse is still exactly one cycle wide and at most one per frame,
because `a_close_terminate` is high only on the closure word's own cycle.
Nothing else moves: `error_bad_frame`, `error_runt`, `error_oversize` and
`error_start_without_terminate` still read `strobe`/`q_strobe` and are textually
untouched, and the `q2` in-word path is untouched. §9 ruling 9's floor survives,
because `bad_fcs` still contains `has_fcs`. REQ-009 survives, because the
`~:(i.clear)` gate is kept — without it the mutation would have smuggled in a
second defect.

**Disclosure.** "One cycle early" is the typical case, not an invariant of the
implemented defect; see §5.3.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..b93bc55 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -750,6 +750,14 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      one-term union and is written as one. *)
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
+  (* D-M4 MUTATION (WO-0041): the REQ-104 verdict and its [tuser][0] marking
+     are untouched — [abort] still reads [sel_bad_fcs] out of the aged
+     closure record, so the correct word of the correct frame is still
+     marked. Only the strobe's cycle moves: [error_bad_fcs] is taken from
+     the age-0 record instead of the consumed one, so it pulses on the cycle
+     carrying the frame's terminate character rather than on the cycle §9
+     pins it to — the cycle this frame's `tlast` word is emitted. No other
+     strobe moves: the other four still read [strobe] and [q_strobe]. *)
   { O.rx =
       { Axi64.Source.tvalid
       ; tdata = al_data_d
@@ -758,7 +766,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
       ; tlast = emit_tlast &: ~:(i.clear)
       ; tuser = emit_tlast &: abort
       }
-  ; error_bad_fcs = strobe sel_bad_fcs
+  ; error_bad_fcs = a_close_terminate &: bad_fcs &: ~:(i.clear) (* D-M4 MUTATION (WO-0041) *)
   ; error_bad_frame = strobe sel_error |: q_strobe 0
   ; error_runt = strobe sel_runt |: q_strobe 1
   ; error_oversize = strobe sel_oversize
```

### 3.5 D-M5 — mark the frame but never report it

**Intent as understood.** The REQ-104 verdict is computed correctly and
`tuser`[0] is set correctly on the `tlast` word of a bad-FCS frame — but
`error_bad_fcs` never pulses, for any frame. The frame is marked and forwarded;
nothing is reported. Every other strobe is untouched.

**Mechanism.** The `error_bad_fcs` output field is driven to `gnd`. Nothing
else changes anywhere in the module.

**Fidelity.** The verdict is computed, recorded, aged and consumed exactly as
today, and `abort` still reads `sel_bad_fcs`, so a bad-FCS frame still leaves
with `tuser`[0] = 1 on its `tlast` word. Only the reporting path is severed —
which is the conformance defect the intent names: REQ-008 forbids silent
discard and §9 row 1 requires *both* the bit and the strobe, and this design now
supplies one of the two. The `strobe` helper is still the other four strobes'
and is textually unchanged; `consume` is still computed and still drives the
record ageing, so no other report's cycle moves. A constant output field is not
novel in this record — `tstrb = zero 8` sits four lines above it — so nothing
structural is disturbed.

**Its relation to D-M1, stated because the pair is the discriminator.** D-M1
removes the mark *and* the report by killing the verdict; D-M5 keeps the mark
and removes only the report. A bench unit that asserts "`tuser`[0] = 1 on this
frame's `tlast` word" and a unit that asserts "`error_bad_fcs` pulsed once" fail
in different combinations under the two, and a unit that checks only one of the
two cannot tell them apart.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..088140e 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -750,6 +750,12 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      one-term union and is written as one. *)
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
+  (* D-M5 MUTATION (WO-0041): the REQ-104 verdict is computed and carried
+     exactly as it is today — [abort] still reads [sel_bad_fcs], so a
+     bad-FCS frame is still marked [tuser][0] = 1 on its `tlast` word — but
+     it is never reported: [error_bad_fcs] is driven low for every frame.
+     The other four strobes keep their own paths and [strobe] stays their
+     helper, so no strobe but this one changes. *)
   { O.rx =
       { Axi64.Source.tvalid
       ; tdata = al_data_d
@@ -758,7 +764,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
       ; tlast = emit_tlast &: ~:(i.clear)
       ; tuser = emit_tlast &: abort
       }
-  ; error_bad_fcs = strobe sel_bad_fcs
+  ; error_bad_fcs = gnd (* D-M5 MUTATION (WO-0041) *)
   ; error_bad_frame = strobe sel_error |: q_strobe 0
   ; error_runt = strobe sel_runt |: q_strobe 1
   ; error_oversize = strobe sel_oversize
```

---

## 4. Self-check — what I ran, and its results

Packet §3 and my charter require the diffs to apply cleanly to `447d11c` and my
Evidence to be as falsifiable as what I audit. Every check below runs in the
scratchpad against a copy of the file extracted with `git show`; **the working
tree's `libs/` was never modified** (`git status --porcelain` in the repository
reports only the new, untracked `docs/reports/audit/WO-0041-mutations/`).

**(a) `git apply --check`, from a pristine base.** A scratch directory holding
only `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` = `git show
447d11c:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (sha256 re-verified as
`3d87515a…`):

```
D-M1   files=1  Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml... -> exit=0
D-M2   files=1  Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml... -> exit=0
D-M3   files=1  Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml... -> exit=0
D-M4   files=1  Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml... -> exit=0
D-M5   files=1  Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml... -> exit=0
```

Re-run against the **delivered copies** in this directory, not the working ones:
5 / 5, exit 0. `files=1` is `grep -c '^diff --git'` — each diff touches exactly
one file, and it is the RTL file the packet names.

**(b) Apply / reverse-apply round trip.** For each diff: `git apply` →
snapshot the mutated file → `git apply -R`. After all five, the scratch base
file's sha256 is unchanged at `3d87515a…`. Every diff is therefore exactly
invertible against this base, which is what makes the orchestrator's
"apply transiently, revert fully" procedure safe (PROTOCOL §10).

**(c) Parse-only syntax check — and its limits.** The container has no Hardcaml
and no OCaml 5.x (ADR-0005); it does have the system compiler 4.14.1. I ran
`ocamlc -stop-after parsing -c <file>.ml` on the base and on all five mutated
snapshots. This lexes and parses only: it neither typechecks, nor resolves a
module, nor runs a ppx, nor elaborates a circuit.

```
base.ml        rc=0
mut_D_M1.ml    rc=0
mut_D_M2.ml    rc=0
mut_D_M3.ml    rc=0
mut_D_M4.ml    rc=0
mut_D_M5.ml    rc=0
broken.ml      rc=2   File "broken.ml", line 471, characters 16-17:
```

`broken.ml` is a negative control — the base with `let bad_fcs = = has_fcs …`
substituted — included because a check that cannot fail is not a check. What
this establishes: no mutant introduces a syntax error, an unterminated comment,
or an unbalanced string literal inside a comment (OCaml lexes string literals
inside comments; three of my comments contain quoted phrases). What it does
**not** establish: that any mutant compiles. **ADR-0005 stands — CI is the
authoritative build environment and I cannot compile here.** §4(d) is the rest
of my compile-confidence argument, and it is reasoning, not evidence.

**(d) No orphaned binding — the one real compile risk, checked by counting.**
This library has no `env` stanza anywhere (`grep -rn '(env'` over `dune` and
`dune-project` returns nothing), so dune's dev-profile default flags apply,
which promote warnings 26 (unused `let` binding) and 32 (unused value
declaration) to errors. `xgmii_rx_64.mli` exports only `I`, `O`, `create` and
`hierarchical`, so **every** top-level binding in the `.ml` — `fcs_residue`
among them — is caught by warning 32 the moment its last use disappears. A
mutation written as the obvious bare constant would have orphaned
`fcs_residue`, and a mutation that deleted `bad_fcs` would have orphaned it
under 26. I therefore wrote all five to preserve every binding's use (§5.1), and
verified it by stripping comments and counting identifier occurrences in code:

| file | `fcs_residue` | `has_fcs` | `crc_final` | `bad_fcs` | `sel_bad_fcs` | `crc_reg` | `a_close_terminate` | `strobe` |
|---|---|---|---|---|---|---|---|---|
| base | 2 | 2 | 3 | 2 | 3 | 4 | 5 | 6 |
| D-M1 | 2 | 2 | 3 | 2 | 3 | 4 | 5 | 6 |
| D-M2 | 2 | 2 | 3 | 2 | 3 | 4 | 5 | 6 |
| D-M3 | 2 | 2 | 2 | 2 | 3 | 5 | 5 | 6 |
| D-M4 | 2 | 2 | 3 | 3 | 2 | 4 | 6 | 5 |
| D-M5 | 2 | 2 | 3 | 2 | 2 | 4 | 5 | 5 |

Each count is definition + uses. **No entry anywhere is 1**, so no binding is
orphaned in any mutant; `fcs_residue` in particular stays at definition + exactly
one use in all five, and `sel_bad_fcs` keeps its `abort` use in D-M4 and D-M5
where the output field stops reading it.

**(e) Widths and scope, by inspection.** Every introduced expression is one bit
and every identifier is in scope at its use site: `gnd`/`vdd` come from the
`let open Signal in` at the head of `create` and already appear in the base;
`crc_reg` is bound at line 439 and assigned at 478, both above D-M3's new read
at 533; `a_close_terminate` (line 366) and `bad_fcs` (471) are both above
D-M4's new read at 761. `has_fcs` is `count_next >=:. fcs_min_octets`, one bit;
`bit sel 5` is one bit; `crc_reg <>: of_int ~width:32 fcs_residue` compares two
32-bit signals and yields one bit.

**(f) Minimality, counted.**

| id | hunks | lines added | of which comment | **code lines changed** | lines removed |
|---|---|---|---|---|---|
| D-M1 | 1 | 8 | 7 | **1** | 1 |
| D-M2 | 1 | 7 | 6 | **1** | 1 |
| D-M3 | 2 | 13 | 11 | **2** | 2 |
| D-M4 | 2 | 9 | 8 | **1** | 1 |
| D-M5 | 2 | 7 | 6 | **1** | 1 |

Every hunk carries a `D-MN MUTATION (WO-0041)` marker, as packet §4 requires for
greppability; the marker comments are the bulk of every diff and the defect
itself is one or two lines in each. The widest line any diff adds is 93 bytes
(D-M4's output field, marker comment included), inside the base file's own
existing maximum of 97.

**(g) What I did not check, and cannot.** That the mutants elaborate; that they
produce a circuit; that any of them changes any test's outcome. Those are CI's
and the orchestrator's, and by bar 10 I must not see the last of them until the
campaign closes.

---

## 5. Disclosures

### 5.1 The two forced constants are written as an inserted conjunct/disjunct, not as a bare constant

D-M1 is `gnd &: has_fcs &: (crc_final <>: …)` rather than `gnd`, and D-M2 is
`has_fcs &: (vdd |: (crc_final <>: …))` rather than `has_fcs`; D-M3 keeps
`let bad_fcs = has_fcs in` as an alias rather than deleting the binding and
renaming its use. **The circuits are identical** to the bare forms — `gnd &: x`
is 0 and `vdd |: x` is 1 for every `x` — and the reason for the longer form is
entirely §4(d)'s: the bare forms orphan `fcs_residue` (warning 32) or `bad_fcs`
(warning 26), and this repository builds with warnings as errors. A mutation
that fails to compile would cost bar 10's disclosed compile-only repair for no
behavioural gain, and I would rather author it right than repair it. I flag the
choice because a reader comparing my diff against the defect they imagine will
see three extra tokens and should know they are load-bearing for the build and
inert for the circuit.

### 5.2 D-M3 preserves §9 ruling 9's floor deliberately, and the alternative reading exists

D-M3's intent says the verdict is formed "by comparing the CRC register's value
at the moment it emits the `tlast` word against REQ-304's residue". Read with no
qualification at all, that also removes the `has_fcs` gate, and a **lone**
0-to-4-octet frame would then report `error_bad_fcs` — breaking §9's ninth
ruling and reddening whatever asserts the exact strobe set on that class. I did
not do that, for a reason internal to the intent: its own next sentence is "on a
lone frame this is indistinguishable from correct", and that sentence is **false**
under the floorless reading. So I moved the *comparison's timing* and nothing
else, and left the floor where the design put it.

If dv_lead meant the floorless variant, D-M3 as delivered is narrower than
intended by exactly the sub-5-octet class, and the right response is a **sixth
mutation authored on request**, not a revision of this one — bar 10 lets me
revise nothing after a run, and I would rather be told than guess. This is
recorded before any run, which is the only time such a note is worth anything.

### 5.3 D-M4 moves the strobe *to the terminate cycle*, which is not always one cycle

The intent's title says "one cycle early" and its body says "pulses on the cycle
carrying the frame's terminate character rather than on the cycle M03 emits that
frame's `tlast` word". I implemented the **body**. §6.1's drain derivation makes
the gap 1 or 2 cycles at a lane-0 start and 0 or 1 at a lane-4 start, so the
move is 1 cycle in the common case, 2 in the long-drain case, and **0** in one
class: a lane-4-started frame whose terminate character falls in lane 0, where
the terminate cycle and the `tlast` cycle are the same cycle and the mutation is
**unobservable on that frame**. That class is inherent to the defect as
described — any implementation of "pulse on the terminate cycle" has it — and it
is not a weakness of the diff, but a bench that happened to test only that shape
would find D-M4 invisible, which is exactly the kind of fact the campaign exists
to surface. I state it before any run so that it cannot be read as an excuse
afterwards.

### 5.4 Nothing was unachievable

Packet §2 asks me to say plainly if a faithful minimal diff is not achievable
rather than substituting a different defect. No such case arose: all five intents
are implementable at a single site each, with one or two code lines, and no
intent was substituted, weakened or widened beyond §§5.2–5.3's two readings.

---

## 6. Open questions

1. **§5.2 — D-M3's floor.** Do you want the floorless variant instead of, or in
   addition to, what is delivered? Say so before the first run and it costs a
   new diff; after any run it costs the campaign's blinding.
2. **§5.3 — D-M4's unobservable class.** Confirmed as inherent, not as a defect
   in the seed; no action requested, but recorded.
3. **§1.4 — the ambient exposure.** Three things: commit *subject lines*
   summarising WO-0039's and WO-0040's outcomes reached me through `git log`;
   one of my path-scoped logs was on a barred path (subjects only, no content);
   and copies of barred artifacts sit unopened in a shared scratchpad directory
   whose listing I saw. If dv_lead judges any of the three to compromise the
   blind, the affected mutations are its call to void, not mine — and the call
   is cheapest now, before any run.
4. **Sequencing.** PROTOCOL §10 requires that no RTL-line or worker agent be
   spawned while a manifest is applied, and that mutated RTL never enter
   history. The `447d11c` + one diff branches of packet §4 satisfy the second by
   construction; the first is the orchestrator's to hold.

---

## 7. ADDED NOTE — 2026-08-11 — the `D-M3` equivalence exclusion, recorded; and what re-deriving its proof returned

> **This section is an ADDITION and nothing above it is edited.** §§1–6 are the
> frozen pre-run blind manifest of 2026-08-03; §3.3 in particular is pre-run text
> and stays exactly as written, including the sentences §7.3 below examines.
> Repairing frozen manifest prose to match what a campaign later learned is the
> retro-edit `ADR-0020` §12.6 and clause (b.2)'s last sentence forbid, and this
> note is the form that obligation leaves open. **Added by**: auditor,
> `J-auditor-0024`. **Read surfaces**: `65ba148`.

### 7.1 Why this note exists

`ADR-0020` clause (b.3) — the equivalent-mutant standard, drafted at
`J-architect_docs_lead-0045`/`-0046` and countersigned by this seat at
`J-auditor-0021` — has three limbs. **Limb 3** requires that a mutation leave the
denominator *"only once the **seeder records the exclusion in the seeder's own
committed artefact**"*. `ADR-0020` §6.3 makes (b.3) **prospective** and
grandfathers exactly one instance **by name**: `D-M3`, the mutation seeded in
§3.3 of this file. ADR §10 item 4 named the resulting debt and its owner —
this seat, because `docs/reports/audit/**` is its exclusive scope (PROTOCOL §6)
and nobody else can pay it. I accepted the debt at `J-auditor-0021` §9, filed it
against myself as `F-0021-4`, and carried it unpaid through `J-auditor-0022`.

I committed there to two facts and one disclosure: record the exclusion; record
that §3.3's divergence claim at `:325–326` and `:354–360` is contradicted by the
proof and stands unedited; and **state my verification posture explicitly —
either I re-derive the margin over the stated stimulus space myself, or I record
the proof as cited and not re-derived, and say which.**

**I re-derived it. The re-derivation does not reproduce the proof's conclusion.**
That is not the note I expected to write, and §7.3 is written so it can be
checked line by line rather than believed.

### 7.2 Fact 1 — the exclusion, recorded in the seeder's own artefact (limb 3's form)

Recorded plainly, because limb 3's whole function is that a denominator exclusion
is discoverable from the seeder's side of the record and not only from the graded
party's:

| field | value |
|---|---|
| mutation excluded | **`D-M3`** — §3.3 of this file; artefact `D-M3.diff`; base `447d11c`, blob `81cd9ed`, sha256 `3d87515a…` |
| seeded by | auditor (this file, `J-auditor-0005`, committed `fb49b80`) |
| ruled | **EQUIVALENT MUTANT — excluded from the denominator, not counted as a survivor** |
| ruled by | **dv_lead**, `RV-0041-VERDICT` §3, `agents/handoffs/WO-0041_family-d-mutation-campaign.md`:369–395, journal `J-dv_lead-0044` |
| the proof relied on | the margin `next_frame_start_cycle − tlast_cycle` computed *"over every legal combination of terminate lane (0–7), start lane (0 and 4), frame length and inter-frame gap down to §0.3's DIC floor of 9 octets"*, concluding *"The margin is never negative. Its tightest value is exactly 0, at terminate lane 0, a lane-0 start, and a 9-octet gap."* |
| what the exclusion changed | the campaign's score from five seeded mutations to *"**PASS** on the killable set — 4 of 4"* (`WO-0041` §4) |
| what the exclusion supports downstream | `agents/handoffs/SO-xgmii_rx_64.md` `SC-5` at **:280**, **:511** and the campaign row at **:803** — *"pre-class era … **15 of 15**, with `D-M3` ruled an equivalent mutant and excluded from the denominator"* — and `docs/gates/P1-module-ready-checklist.md`:**211**, which carries the same figure into the gate record |
| proof authored by | **not this seat.** Limb 3 requires the seeder to **record**, not to **prove** — the reading I confirmed as the constrained party at `J-auditor-0021` — so a third party's proof counts, and this row is what makes clear whose it is |

**The record is now complete in the form limb 3 asks for, and §7.3 is why that is
not the end of it.**

### 7.3 Fact 2 — §3.3's divergence claim, and my re-derivation

#### (a) The two sentences under examination, quoted from the frozen text

`:325–326`:

> On a lone frame this is indistinguishable from correct; on two frames close
> together it is not, because §6.1 re-seeds the register in `Preamble`.

`:354–360`:

> They diverge exactly when another frame's start character makes `begins` true,
> or another frame's octets are being covered, between the terminate word and the
> `tlast` cycle: the register then holds the seed 0 or the next frame's running
> value, neither of which is the residue, and a **good** frame is reported bad.

`J-auditor-0021` §9 recorded, on the strength of dv_lead's proof, that **that
claim is what the equivalence proof refutes**, and `F-0021-4` filed it against my
own seat as a falsified mechanism claim standing in my own artefact.

#### (b) What the equivalence question actually reduces to

The original computes `bad_fcs = has_fcs &: (crc_final <>: residue)` at the
**closure** cycle and latches it into the closure record
(`447d11c:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`:471). `D-M3` moves the
comparison to the **consumption** cycle and reads the register there
(`sel_bad_fcs = bit sel 5 &: (crc_reg <>: residue)`). Equivalence therefore holds
exactly when

    crc_reg(consumption cycle) = crc_final(closure cycle)

and the register's own recurrence (`:478`,
`crc_reg <== reg spec (mux2 begins (zero 32) crc_final)`) makes the seed **visible
one cycle after** `begins` — dv_lead's own load-bearing observation, which I
confirm. Write **W** for the input word carrying the terminate character, **t**
for its lane, **S** for the input word carrying the next frame's start character
and **s ∈ {0,4}** for that start lane. Divergence requires a seed visible at or
before the consumption cycle, i.e. `S + 1 ≤ tlast`, i.e.

    margin := S − tlast ≤ −1.

#### (c) The gap arithmetic — this limb is certain and needs no execution

`requirements.md` §0.3:81 fixes one convention: the gap is measured **from the
terminate character inclusive to the next start character exclusive**; :101 fixes
the DIC floor at **9 octets**. In octet positions, `p_T = 8W + t` and
`p_S = 8S + s`, so

    G = p_S − p_T = 8(S − W) + s − t,     hence     G ≡ s − t  (mod 8).

**A 9-octet gap therefore occurs only at `t = 7` with a lane-0 successor, or at
`t = 3` with a lane-4 successor.** At **terminate lane 0** a 9-octet gap would put
the start character at lane 1, which REQ-101 does not admit; the shortest legal
gap there is **12** (lane 4 of `W+1`). So the proof's stated tightest case —
*"terminate lane 0, a lane-0 start, and a 9-octet gap"* — **is not a member of the
space it quantifies over.** That is arithmetic on the frozen convention, it is
independent of everything below, and it is checkable in one line.

#### (d) The margin, computed over the same space

`tlast` from SPEC-M03 §6.1:330 (*"an output word leaves **two** cycles after the
input word carrying its last octet when its frame began at lane 0 (L = 16), and
two or **one** cycle after it when its frame began at lane 4 (L = 12), according
as that octet lies in lanes 4 … 7 or in lanes 0 … 3"*), with the frame's last
octet at lane `t−1` of `W` when `t ≥ 1` and at lane 7 of `W−1` when `t = 0`:

| frame 1 started | `t` | `tlast` | earliest legal `S` | **margin** |
|---|---|---|---|---|
| lane 0 | 0 | `W+1` | `W+1` (lane‑4 successor, G = 12) | 0 |
| **lane 0** | **1** | **`W+2`** | **`W+1`** (lane‑4 successor, **G = 11**) | **−1** |
| **lane 0** | **2** | **`W+2`** | **`W+1`** (lane‑4 successor, **G = 10**) | **−1** |
| **lane 0** | **3** | **`W+2`** | **`W+1`** (lane‑4 successor, **G = 9**) | **−1** |
| lane 0 | 4…7 | `W+2` | `W+2` (G = 12, 11, 10, 9) | 0 |
| lane 4 | 0…4 | `W+1` | `W+1` or `W+2` | 0 or +1 |
| lane 4 | 5…7 | `W+2` | `W+2` | 0 |

**The margin is not never-negative. It is −1 on three cells**, and one of them is
the DIC floor the proof named. At a lane-0 start the terminate lane is
`L mod 8` for a frame of `L` octets (DA…FCS), so the divergent cells are exactly
**frames of length ≡ 1, 2, 3 (mod 8) at a lane-0 start, followed by a
lane-4-started frame at a DIC-shortened gap of 11, 10 or 9 octets** — the
alternating lane-0/lane-4 DIC-capable link partner `REQ-004` names as the worst
case the receive path must survive.

#### (e) A concrete witness, laid out by the bench's own link-partner model

`test/xgmii/arrival.ml`:30–61 implements §0.3's rounding and DIC credit exactly.
Three 65-octet frames from a lane-0 first start —
`frames_at ~lane:0 ~fcs_valid:true [f65; f65; f65]`, i.e.
`Arrival.create ~ifg:12 ~first_start:8` — lay out as:

| frame | start octet (lane) | terminate octet (word, lane) | banked credit | gap to next |
|---|---|---|---|---|
| 0 | 8 (lane 0) | 81 (word 10, lane 1) | 0 → 3 | 15 |
| **1** | **96 (lane 0)** | **169 (word 21, lane 1)** | 3 → 2 (spent 3) | **11** |
| 2 | 180 (**lane 4**) | — | — | — |

Frame 1's start word is 12; nine output words (`m = 0…8`) put its `tlast` at
`12 + 8 + 3 = 23` by §6.1:398's `m + 3`, which is `W + 2`. Frame 2's start
character is in word **22**, so `begins(22)` holds and `crc_reg(23) = 0`, while
`fcs_residue = 0x2144_df1c ≠ 0`. **The mutant asserts `error_bad_fcs` on frame 1,
a good frame, at cycle 23; the original does not.** Frame 0 is safe (margin 0) and
frame 2 has no successor, so the prediction is *exactly one* spurious pulse, on
frame index 1, at cycle 23. The DIC-floor variant is five 67-octet frames, where
frame 3's gap is **9** and its `tlast` is `W + 2`.

**I have not executed this.** I cannot: PROTOCOL §10 gives transient application
of a manifest to the **orchestrator**, and ADR-0019 keeps the seeder out of the
repository entirely. The witness is stated so that one transient run of the
**unmodified** `D-M3.diff` against a three-frame 65-octet schedule settles it in
either direction, and **if that run comes back green I withdraw §7.3 and §7.4's
`F-0024-A` in full and say so here.** Nothing is withheld: every number above is
derived in the open from the two frozen documents and the base RTL, so this is a
prediction, not a seal (`R-SEAL-1`).

#### (f) Why the suite passed anyway — the hypothesis the verdict rejected

`RV-0041-VERDICT` §3 opens: *"Two hypotheses were put to me: a bench coverage
gap, or an equivalent mutant. **It is the second**."* On the derivation above it
is the **first**, and the gap is sharp and checkable at `447d11c`:

- `bench.ml`:289–296 — `run_directed_lengths` drives every length of
  `directed_lengths` through `one_frame`, i.e. **as a lone frame**. Every length
  is covered and no length has a successor.
- Every multi-frame schedule in the M03 units is built from **64-octet** frames:
  family D's pairs (`test_m03_d.ml`:239, *"two 64-octet frames at `frames_at`'s
  default (§0.3 minimum, 12-octet) gap"*) and the line-rate stress
  (`Frame.stress_frame` = 6+6+2+4+42 octets + 4 FCS = **64**; `SO-xgmii_rx_64.md`
  `SC-4`, *"10 000 consecutive 64-octet frames, start lanes alternating 0/4"*).
- `64 mod 8 = 0`, so every multi-frame stimulus in the bench sits in the `t = 0`
  or `t = 4` row of §7.3(d) — **margin 0 or +1, never −1**.

**No unit in the suite has both properties at once**: the tests that vary length
never have a successor, and the tests that have a successor never vary length off
a multiple of eight. `D-M3` survived on that intersection, which is a coverage
gap of precisely the shape the campaign existed to surface.

#### (g) One error in §3.3 that is real, and is recorded rather than repaired

§3.3's fidelity bullets say the drain derivation puts the `tlast` word *"at `W`
or `W + 1` at a lane-4 start"* and reason about *"the single candidate **at**
`W`"*. That is off by one: at a lane-4 start `tlast` is `W + 1` for `t ∈ {0,1,2,3,4}`
and `W + 2` for `t ∈ {5,6,7}`, and **no** frame's `tlast` falls on `W`. The error
is conservative for the argument it served (the lone-frame fidelity claim survives
without it, because the register holds across the drain), and it is the reason the
lane-4 rows of §7.3(d) had to be recomputed rather than read off §3.3. Recorded
here, unedited there.

### 7.4 Findings

| id | severity | subject | finding | route |
|---|---|---|---|---|
| **`F-0024-A`** | **CRITICAL** | **dv_lead** (`RV-0041-VERDICT` §3, `J-dv_lead-0044`), and the artefacts carrying its consequence | The `D-M3` equivalence proof does not hold. Its stated tightest case (*terminate lane 0, lane-0 start, 9-octet gap*) **cannot exist** — `G ≡ s − t (mod 8)` puts a 9-octet gap only at `t = 7`/lane-0-successor or `t = 3`/lane-4-successor (§7.3(c), arithmetic, certain) — and the margin reaches **−1** at terminate lanes 1–3 from a lane-0 start with a lane-4-started successor at gaps 11/10/9 (§7.3(d)), so the mutant diverges on a stimulus `REQ-004` names as the worst case the receive path must survive. Charter §3 reserves CRITICAL for Evidence claims that do not reproduce; this is one, it sits in a **verbatim**-class packet, and its consequence is a live denominator exclusion | **E4, verbatim.** Falsifier named in §7.3(e) and cheap: one transient run of the unmodified `D-M3.diff` against `frames_at ~lane:0 [f65; f65; f65]`. **The finding is withdrawn in full if that run is green** |
| **`F-0024-B`** | **MAJOR** | **`SO-xgmii_rx_64.md`** `SC-5` (:280, :511), campaign row :803, and **`docs/gates/P1-module-ready-checklist.md`:211** | With `F-0024-A` standing, the pre-class era figure is not *"15 of 15"*: `D-M3` returns to the denominator as a **survivor**, making `WO-0041` **4 of 5**. Under `ADR-0020` (b.2) a survivor must be named individually with its disposition, and the disposition form for one whose seal predicted a kill requires the unmodified diff replayed at the gate SHA **with the killing unit named** — **there is no killing unit** | dv_lead (the score) and the orchestrator (the gate reading). **This blocks no gate by itself and passes none**; it changes a figure two artefacts carry |
| **`F-0024-C`** | **MAJOR** | **dv_lead / tb_writer** (`test/xgmii_rx_64/**` at `447d11c`, and forward) | The bench has no unit that combines a frame length ≢ 0 (mod 8) with a following frame. Directed lengths are lone frames (`bench.ml`:289–296); every multi-frame schedule is 64-octet. The intersection is empty, so the DIC-shortened-gap rows of §7.3(d) are undriven — including the 9-octet floor `REQ-004` and §8's stress obligation both point at | dv_lead. **Not a DV-escape ledger entry**: the ledger's subject is a post-sign-off divergence of the *design*, and there is none — M03 carries the verdict with the frame and is correct. The defect is in the **score and the stimulus**, and filing it as an escape would misname it |
| **`F-0024-D`** | **MINOR** | **my own seat** (this file, §3.3) | The lane-4 drain window in §3.3's fidelity bullets is off by one (`W`/`W+1` where the truth is `W+1`/`W+2`; no `tlast` falls on `W`). Conservative for the claim it served. Recorded at §7.3(g), **not repaired** — §3.3 is frozen pre-run text | none. It is disclosed so a reader re-deriving from §3.3 is not misled twice |
| **`F-0024-E`** | **MINOR** | **`ADR-0020` §6.3** / architect_docs_lead, orchestrator | §6.3 closes the (b.3) grandfathered set at exactly one member, `D-M3`. If `F-0024-A` stands, that member's substantive ground is gone and **the record contains no surviving equivalence exclusion at all** — the standard's first application has an empty subject. Grandfathering excuses the missing *record* (limb 3); it does not immunise a refuted *proof* | recorded for the gate record's form (`F-0021-3`'s owed row), which is where the exclusions were to be published beside the tally |

### 7.5 What this note does not do, stated so it cannot be over-read

- **It does not edit §3.3, or any line above §7.** The two sentences at `:325–326`
  and `:354–360` stand exactly as written, and after §7.3 they stand as
  *substantially correct in their essential claim and wrong in one supporting
  parenthetical* — which is not the disposition `J-auditor-0021` §9 predicted for
  them, and the difference is stated rather than smoothed.
- **It does not retroactively apply (b.3) to `D-M3`.** `ADR-0020` §6.3 makes the
  clause prospective and this note pays limb 3's **form**, not its jurisdiction.
  `F-0021-4`'s bound stands: nobody may cite this note as limb 3 satisfied
  retroactively, and the grandfathered set is not reopened by its being paid.
- **It does not re-score the campaign, void a kill, or touch a packet.** The
  auditor stages `docs/reports/audit/**` and nothing else (PROTOCOL §3's auditor
  exception, ADR-0003). `WO-0041`'s scorecard, `SO-xgmii_rx_64.md` and the gate
  checklist are other seats' artefacts; `F-0024-B` is a finding against them, not
  an edit of them.
- **It does not claim the design is defective.** `D-M3` is a mutation. M03 as
  shipped carries the verdict with the frame and is unaffected by every line of
  §7.
- **It asserts nothing it has executed.** §7.3(c) is arithmetic; §7.3(d) is
  derivation from two frozen documents; §7.3(e) is an unexecuted prediction with
  its own falsifier; §7.3(f) is a read of committed test source at `447d11c`.
  Each is labelled with which it is, because a note filed against a proof owes at
  least the standard it is holding that proof to.

---

## 8. ADDED NOTE — 2026-08-12 — the falsifier ran green: `F-0024-A` is WITHDRAWN IN FULL by its own sealed term, and the step where my hand-execution left the machine is located

### 8.1 What this note is

§7 filed a CRITICAL against another seat's committed proof and sealed its own
falsifier with it: *"withdrawn in full if that run is green"* (§7.4, `F-0024-A`).
The run was commissioned, executed by the orchestrator as operator under
`ADR-0019` and `PROTOCOL` §10, and **it is green on the witness**. This note
discharges the term — **in full, not in part** — locates the exact step at which
my hand-execution diverged from the machine, supplies the corrected derivation
over the whole legal space, and re-grades the one finding of the round that was
never conditional on `F-0024-A`.

**Nothing here is a re-argument of `F-0024-A` under a new number.** A seat that
seals *withdrawn in full* and then re-files a fragment of the same claim has not
withdrawn in full. What survives below survives as observation and as findings
**against this seat's own instrument**, which is a different subject.

### 8.2 The run, verified at its source rather than adopted from the relay

The operator's report reached me as a dispatch statement. I did not take it as
one. Every fact below was re-taken at its own source; the two that only the
GitHub API can settle are cited as `ADR-0003`/F5 and `PROTOCOL` §4.1 permit —
a run id and its conclusion.

| fact | value | how I took it |
|---|---|---|
| branch | `mut/wo-0041-dm3-falsifier`, **not an ancestor of HEAD** | `git for-each-ref refs/remotes/origin/mut/*`; `git merge-base --is-ancestor` |
| mutation commit | `528b045`, base `d4be71b`, subject *"…NEVER MERGE"* | `git show --stat 528b045` — two files, `xgmii_rx_64.ml` +15/−2 and `test_m03_d.ml` +26 |
| workflow run | **31541276523**, workflow `build`, run #625, `head_sha` `528b045`, started 2026-08-11T22:10:45Z | GitHub API `actions/runs/31541276523` |
| job `build` (93943973189) | **Build `success`** (step 5), **Run tests (expect tests, waveform snapshots) `success`** (step 6), **Generate RTL `success`** (step 7), **Verify nothing was left unpromoted or non-deterministic `failure`** (step 8, the only red), steps 9–10 `skipped` as its consequence | API `actions/runs/31541276523/jobs` |
| job `cosim` (93943973133) | **`success`** end to end, including *Run the co-simulation lane (WO-0046 Phase 1)* | same |
| overall conclusion | `failure` — **and it is the snapshot check, which is red for any mutated tree by construction**: the mutation changes RTL, so the emitted Verilog cannot equal the committed snapshot | step-level read above, not the run-level rollup |

**Four non-vacuity checks, because a green run refutes nothing unless it could
have gone red.**

1. **The applied mutation is the committed manifest, unmodified** — the seal's own
   word. Re-applied and diffed rather than eyeballed:
   `git show d4be71b:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` + `patch -p1 <
   D-M3.diff` is **byte-identical** to `git show
   528b045:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`.
2. **The oracle is real and is not this witness's own invention.**
   `error_pulses` (`test/xgmii_rx_64/bench.mli`:446, `bench.ml`:464) returns every
   `(cycle, strobe name)` pair high anywhere in a run, across all five strobes,
   read from the `Before` view at the cycle the strobe belongs to. It is the same
   oracle a dozen other M03 units use, including units that assert strobes **do**
   fire (`test_m03_b.ml`:427, :686, :886, :1068, :1310) — so a broken oracle would
   redden the suite elsewhere, not silently green this unit.
3. **The observation window covers the predicted cycle.** The schedule is 35
   cycles (`Arrival.cycles` for three 65-octet frames at `ifg` 12), driven with
   `~drain:8` on top; the strobe §7.3(e) predicted was at **cycle 23**, inside the
   window by twelve cycles before the drain is counted.
4. **The result transfers to HEAD.** `git diff --stat d4be71b HEAD --
   libs/hardcaml_ethernet/src/xgmii_rx_64.ml test/xgmii_rx_64/
   test/xgmii/arrival.ml` is **empty**: neither the design, nor the M03 bench, nor
   the link-partner model has moved since the falsifier's base.

**Verdict: `F-0024-A` is WITHDRAWN IN FULL, by the term §7.4 sealed before the
run existed.** The `WO-0041` campaign is **5 of 5** with `D-M3` excluded under
(b.3), and the era figure the gate reads — **15 of 15** — stands unchanged.

### 8.3 The divergence step, located: one substitution, worth exactly one cycle

The hand-execution at §7.3(d)–(e) and the machine agree at every step but one.
Taking them in order against the witness (`frames_at ~lane:0 [f65; f65; f65]`):

| # | step | hand-executed | machine | agrees? |
|---|---|---|---|---|
| i | DIC layout (`arrival.ml`:41–59) | frame 1 starts at octet 96, terminates at 169, banks 3 and spends 3, gap **11**, frame 2 starts at 180 in lane 4 | same | **yes** |
| ii | terminate word / lane | `W` = **21**, `t` = **1** | same | **yes** |
| iii | `begins` for the successor | input word **22** (`survivor_c`, :422/:429/:430 — lanes 5–7 of word 22 are preamble, so nothing closes epoch C) | same | **yes** |
| iv | the re-seed's arrival | `crc_reg(23) = 0` by :478's recurrence | same | **yes** |
| v | **the consumption cycle** | **23** | **22** | **NO** |

**The step is (v), and the substitution inside it is this.** §7's own quoted rule
is *"output word m leaves on cycle m + 3"*, and `m` indexes the module's **output**
words — the delivered payload, from which `REQ-103`'s four FCS octets have already
been removed. The module's header says so in terms
(`libs/hardcaml_ethernet/src/xgmii_rx_64.ml`:22–27): *"the four FCS octets of a
frame may lie in the input word after the one carrying the octets of output word
m … **the FCS is removed by `tkeep` and never by holding octets back**"*.

**I computed `m` from the frame's received octet count instead of its delivered
one.** At `L` = 65: I took ⌈65 / 8⌉ = **9** output words, last index `m` = 8, and
wrote `tlast = 12 + 8 + 3 = 23`. The design emits ⌈(65 − 4) / 8⌉ = ⌈61 / 8⌉ =
**8** words, last index `m` = **7**, and `tlast = 12 + 7 + 3 = **22**`.

In the octet-time form §7.3(d) actually used, the same error reads: **I placed the
`tlast` word at the input word carrying the frame's last *received* octet (168,
word 21) where the design places it at the input word carrying the last
*delivered* octet (164, word 20).** The FCS strip pulls the `tlast` word back by
four octets, which at this cell is exactly one input word. The RTL states the
general form of what I missed at :949–950: *"the `tlast` word is released by
`closure_aligned` on the cycle after the terminate word, its record then at age
1"* — `emit_last_b`, the straddling case, with `keep_count = pc − strip + nc` =
8 − 4 + 1 = 5 delivered octets and the word behind it dropped as pure FCS tail.

**One substitution — received-for-delivered — in one step of a five-step chain,
worth exactly one cycle. And the whole finding rested on exactly one cycle:**
`crc_reg(22)` is still `crc_final(21)`, the frame's own final CRC, and only
`crc_reg(23)` is the re-seeded zero. **The mutant reads the register one cycle
before the seed lands.**

**The corroboration that makes this a located defect rather than a plausible
story: the bench writes the correct arithmetic out, in a unit I did not read.**
`test/xgmii_rx_64/test_m03_f.ml`:695–697 —

```ocaml
let delivered0 = 63 - 4 in
let words0 = (delivered0 + 7) / 8 in
let expected_tlast_cycle0 = start_cycle0 + 3 + (words0 - 1) in
```

— **delivered**, not received. That unit's own header (:668–671) calls the
distinction its whole point: the row *"kills both a `< 64` → `<= 64` threshold AND
a threshold applied to the **DELIVERED** count (60, after FCS removal, on both
sides of the boundary) rather than the **RECEIVED** count"*. §7 sampled
`bench.ml`:289–296 and `test_m03_d.ml`:239 and did not open `test_m03_f.ml`. The
correction to my arithmetic was three files away, in the suite I was auditing.

### 8.4 The corrected derivation, over the whole legal space — and the margin is exactly one cycle

With (v) repaired, the question closes in the general case, and it closes the
other way.

Let `C` be the input word carrying the frame's terminate character, `t` its lane,
`T` the cycle the frame's record is consumed, `S₁` the successor's start octet
time, `B = ⌊S₁ / 8⌋` the word on which `begins` fires for it, and `G` the §0.3 gap
(terminate character inclusive).

1. **`T ≤ C + 2`.** The closure record is a three-age structure consumed on the
   frame's `tlast` cycle or at age 2 at the latest (:481–501, `consume <== sel_valid
   &: (emit_tlast |: sel_is_r2)` at :977).
2. **`T = C + 2` requires `t ≥ 5`.** `T = C + 2` only when the frame's last
   *delivered* octet lies in the terminate character's own word; four FCS octets
   and the terminate character sit above it, so that word can hold it only from
   lane 5 upward.
3. **`B ≥ C + 1` always, and `B = C + 1` requires `s ≥ t + 1`.** §0.3 puts the
   successor's start character at `S₁ = 8C + t + G` with `G ≥ 9`, so `B = C + 1`
   needs `t + G ≤ 15`, whence the successor's start lane `s = t + G − 8 ≥ t + 1`.
4. **Divergence requires `B + 1 ≤ T`** — the seed must be visible at or before the
   consumption cycle. With (1)–(3) that forces `B = C + 1` **and** `T = C + 2`
   simultaneously, hence `s ≥ t + 1 ≥ 6`.
5. **`REQ-101` admits `s ∈ {0, 4}` only.** No legal stimulus reaches the
   conjunction.

**`D-M3` is an equivalent mutant over the specification's legal stimulus space,
and the load-bearing fact is the FCS strip — which no version of this proof, dv_lead's
or mine, had named.** The minimum margin is **exactly one cycle**, and it is
attained, by two different routes:

- the witness's own cell — `t = 1` from a lane-0 start, lane-4 successor at a
  DIC-shortened `G = 11`: `T = C + 1 = 22`, `B = C + 1 = 22`, margin `B + 1 − T =
  **1**`;
- `M03-F4`'s cell — a 63-octet frame at lane 0, `t = 7`, successor at `G = 13`:
  `T = C + 2 = 11`, `B = C + 2 = 11`, margin **1**.

**So the witness was aimed at the right cell and missed the right cycle.** The run
is a refutation at the boundary of the space, not somewhere in its interior, which
is the strongest form a green run can take.

**One observation, recorded and deliberately NOT re-filed as a finding.**
§7.3(c)'s arithmetic limb is untouched by all of this and remains true: `G ≡ s − t
(mod 8)` puts a 9-octet gap only at `t = 7` with a lane-0 successor or `t = 3`
with a lane-4 successor, so `RV-0041-VERDICT` §3's stated tightest case —
*terminate lane 0, a lane-0 start, and a 9-octet gap* — is **not a member of the
space the proof quantifies over**. The proof's **conclusion is correct** and now
has two independent supports it did not have (this derivation, and a machine run
at the extremal cell); its **exhibited extremal case is not**. That is recorded
here so a later reader re-deriving from §3 is not sent to a case that cannot
exist, and it is recorded as an observation because `F-0024-A` was sealed
*withdrawn in full* and I will not convert a withdrawal into a smaller finding.

### 8.5 What falls with `F-0024-A`, and what does not

| id | prior state | disposition now | ground |
|---|---|---|---|
| **`F-0024-A`** | CRITICAL, open, E4 | **WITHDRAWN IN FULL** | its own sealed term, discharged by run 31541276523 (§8.2) |
| **`F-0024-B`** | MAJOR | **WITHDRAWN** | its text begins *"With `F-0024-A` standing"*. `D-M3` does not return to the denominator; **`WO-0041` is 5 of 5 and the era figure stays 15 of 15**; `SO-xgmii_rx_64.md` `SC-5` and `P1-module-ready-checklist.md`:211 are unaffected and **nothing is owed by dv_lead or the orchestrator on its account** |
| **`F-0024-E`** | MINOR | **WITHDRAWN** | its text begins *"If `F-0024-A` stands"*. `ADR-0020` §6.3's grandfathered set keeps its single member, and that member's exclusion is now **better** supported than when it was grandfathered: an independent re-derivation over the legal space, plus a run |
| **`F-0024-C`** | MAJOR | **SPLIT: limb 1 withdrawn as false, limb 2 re-graded MINOR** | never conditional on A — §8.6 |
| **`F-0024-D`** | MINOR, against this seat | **STANDS**, and is now the **first of two** instances of one defect class in this instrument | §8.7, §8.8 |
| **`F-0021-4`** | filed against this seat; declared **INVERTED** at `J-auditor-0024` | **REINSTATED**, and the withdrawal of `J-auditor-0021` §9's sentence is itself **withdrawn** | `-0024` inverted it on the strength of the refutation that has now been refuted. §3.3's divergence claim (*"they diverge exactly when another frame's start character makes `begins` true … between the terminate word and the `tlast` cycle"*) selects **no legal stimulus**, and the exclusion **does** stand on its own merits, exactly as `-0021` §9 originally said |

### 8.6 `F-0024-C` re-graded — one limb was false when I filed it; the other is re-measured and downgraded

`F-0024-C` was two claims in one row, and the round that filed it did not separate
them. They part company completely.

**Limb 1 — *"no unit combines a frame length ≢ 0 (mod 8) with a following frame"*
— is FALSE, and was false when I filed it.** The counter-example is `M03-F4`,
`test/xgmii_rx_64/test_m03_f.ml`:684–686 (`run_f4 ~lane`, driven at **both**
lanes): `frames_at ~lane ~fcs_valid:true [ octets63; octets64 ]` — a **63**-octet
frame **followed by** a 64-octet frame, `63 mod 8 = 7`. It asserts, at :753–767,
**exactly one strobe pulse in the entire run** (`error_runt`, on the runt, at its
own `tlast` cycle) and **zero** on the second frame. It is not a weak unit: had
`D-M3` diverged at margin 0, `M03-F4` would have killed it.

**The measurement was true at the SHA it was pinned to and stale by eight days at
the moment I filed it.** `test_m03_f.ml` **did not exist** at the campaign base
(`git cat-file -t 447d11c:test/xgmii_rx_64/test_m03_f.ml` → *does not exist*); it
landed at **`8e040f0`, 2026-08-03 15:13:06Z**, ten hours after `447d11c`
(2026-08-03 05:22:29Z), 826 lines of pure addition. §7.3(f) measured `447d11c`
honestly and §7's Evidence says so — and then the **row** stated an unbounded
present-tense universal over the suite. That is the defect, and it is mine
(`F-0026-B`).

**And `M03-F4` is not merely a counter-example, it is the tight one.** §8.4 shows
its lane-0 cell sits at margin **1** — the minimum over the whole legal space, the
same margin as the witness. The suite had a unit in the tightest row for eight
days before I said it had none.

**Limb 2 — the DIC-shortened-gap rows — survives, re-measured at HEAD, and is
DOWNGRADED to MINOR.** Re-stated so it is checkable: **no committed unit ever
spends deficit-idle credit.** `Arrival.create` banks credit only when a frame's
length is ≢ 0 (mod 4) (`arrival.ml`:56–59, `round_up_4`) and spends it only on a
*later* gap, so a shortened gap needs three or more frames with a non-final one
off the 4-octet grid. Every committed multi-frame schedule of three or more frames
is built from 64-octet frames — `Arrival.stress` (10 000, `test_m03_l.ml`:78),
`test_m03_j.ml`:83 (101), `test_m03_n.ml`:1037–1047 — and every schedule carrying
a length off the grid has at most two frames (`test_m03_f.ml`:686 · 63+64,
`test_m03_e.ml`:527 · 64+68, `test_m03_i.ml`:1109 · 64+68). **Therefore `shorten`
is 0 in every committed unit, every committed gap is ≥ 12 octets, and the 9-octet
floor has never been driven** — while §0.3 and `REQ-004` assume a DIC-capable
partner and the link-partner model implements the behaviour it is never asked to
emit (`arrival.ml`:19 `dic_floor = 9`, :36, :56–59).

**Why MINOR and not the MAJOR it was filed as** — stated as grounds so the grade
can be argued with:

1. **Not because the mutant turned out equivalent.** A coverage gap is not graded
   by the fate of one mutation; that reasoning would let any gap be excused by the
   accident of what was seeded through it. The grade moves for the three reasons
   below and not for that one.
2. **The tight row is driven, permanently and at both lanes.** What §7 thought was
   undriven timing is driven by `M03-F4`; what is actually undriven is the
   *shortened-gap stimulus*, not the *tight-margin cycle relation*.
3. **No packet overstates.** `grep -i dic` returns **nothing** in
   `agents/handoffs/SO-xgmii_rx_64.md` or `test/attack_plans/AP-xgmii_rx_64.md`:
   the sign-off makes no DIC coverage claim, so this is an **unclaimed gap** and
   not a false claim — the distinction `docs/PROCESS.md` §2.1 makes load-bearing.
4. **`REQ-004`'s named worst case is otherwise driven.** The alternating
   lane-0/lane-4 partner at the 84-octet budget — start-to-start alternating 10 and
   11 cycles — is exactly what the 10 000-frame stress emits; it is the DIC
   *shortening*, not the alternation, that is missing.

**Cure route, and it is exhibited rather than described.** One unit in dv_lead's
scope: `frames_at ~lane:0 ~fcs_valid:true [ f65; f65; f65 ]` drives gaps 15 then
**11** (credit 3 banked, 3 spent) with starts at lanes 0, 0, 4 — assert the
schedule (`Arrival.gaps`, `Arrival.start_lanes`) so the unit fails loudly if the
layout ever stops producing a shortened gap, then assert the strobe set. The exact
text exists at `528b045:test/xgmii_rx_64/test_m03_d.ml`. **It has never run against
the unmutated design** — the only tree it ever ran on carries `D-M3` — which is
the one thing this round leaves genuinely unobserved, and the one sentence of the
cure that matters.

### 8.7 Findings of this note

| id | severity | subject | finding | route |
|---|---|---|---|---|
| **`F-0026-A`** | **MAJOR** | **my own seat** (§7.3(d)–(e), `J-auditor-0024`) | A hand-derivation of this seat's produced a **false CRITICAL** against another seat's committed proof. The defect is single and located (§8.3): the drain rule was instantiated with the frame's **received** octet count where the design uses its **delivered** count, placing the consumption cycle at 23 instead of 22 — one cycle, in a claim whose entire content was a one-cycle margin. Not CRITICAL, and the ground is stated rather than assumed: charter §3 reserves CRITICAL for Evidence that does not reproduce, and §7's Evidence **labelled the witness NOT EXECUTED and named the run that would withdraw it**, so the claim was falsifiable by construction and died by the route it named. The seal worked; the arithmetic did not | this seat. Bounded by §8.8 |
| **`F-0026-B`** | **MAJOR** | **my own seat** (`F-0024-C` limb 1) | An **unbounded present-tense universal over a test suite** (*"no unit combines…"*) was asserted from a **partial enumeration at a superseded SHA**, while a counter-example had been in the tree for eight days (`M03-F4`, `8e040f0`). A distinct defect from `F-0026-A`: that one is arithmetic, this one is quantifier discipline — the Evidence section's pin (*"measured at `447d11c`"*) did not survive into the row that a reader acts on | this seat. Bounded by §8.8 |
| **`F-0026-C`** | **MINOR** | dv_lead (`test/xgmii_rx_64/**`) | **No committed unit spends DIC credit**: every committed gap is ≥ 12 octets, the 9-octet floor is undriven, and the link-partner model implements a behaviour no schedule asks it to emit — while §0.3 and `REQ-004` assume a DIC-capable partner. Downgraded from `F-0024-C`'s MAJOR on the four grounds at §8.6, none of them *"the mutant was equivalent"* | dv_lead. **Not a DV-escape ledger entry** — the ledger's subject is a post-sign-off divergence of the *design*, and there is none. Cure exhibited at §8.6 |

**`F-0024-A` is not re-filed in any form.** `F-0026-A` and `F-0026-B` are findings
about **this seat's instrument**, not about `RV-0041-VERDICT`, `D-M3`, the
campaign score or the gate.

### 8.8 The boundary this method now carries

Two defects, in one round, from one instrument: `F-0024-D` (a lane-4 drain window
off by one), `F-0026-A` (a drain instantiated from the wrong octet count). **Both
are the same class — placing the `tlast` cycle by hand** — and one of them reached
CRITICAL. A method with a measured defect needs a boundary, not an apology, so
here is the one this seat now operates under and can be convicted against:

> **A hand-executed cycle-level derivation may not carry a severity above MINOR
> while its conclusion turns on a margin no larger than the pipeline's own
> quantum.** Below that margin the derivation is a **hypothesis with a named
> falsifier**, and the falsifier runs **before** the severity is assigned, not
> after. Where the run is not available to the deriving seat, the finding is filed
> at the severity the derivation supports *without* the tight cell — which for a
> one-cycle margin is *no severity at all*.

And its portable half, for the harvest this seat will owe at the next `SO-` or
gate (`LH2-g`: no proper noun, cites `d4be71b`/`528b045`/run 31541276523 as the
incident, and without it a reviewer's arithmetic slip is indistinguishable from a
defect in the reviewed artefact):

> **A margin narrower than the mechanism's own granularity is a measurement, not a
> derivation.** When a claim's whole content is "one unit earlier or one unit
> later", hand-execution is evidence of *where to look*, never evidence of *what
> is there*.

The second guard the round vindicates is already in the record and is worth naming
because it is what made this reconciliation cheap: **`J-auditor-0021` §9 bound this
seat to disclose which of two methods it had used, and §7 disclosed
`NOT EXECUTED` and sealed a falsifier.** A promise to say which method you used is
worth more than a promise to reach a particular conclusion — the finding was wrong
for eleven hours and cost one branch, one CI run and one round, because the seal
named its own executioner.

### 8.9 What this note does not do

- **It edits nothing above §8**, including §3.3, §7.3 and §7.4. `F-0024-A` stands
  in §7.4's table as written, with its disposition recorded here — the record
  keeps what it measured (`docs/PROCESS.md` §5.4).
- **It re-scores nothing and touches no packet.** `WO-0041`'s scorecard,
  `SO-xgmii_rx_64.md` and `P1-module-ready-checklist.md` are other seats'
  artefacts; the withdrawal of `F-0024-B` releases them and edits none of them.
- **It does not clear the DIC row.** `F-0026-C` stays open at MINOR, and the one
  observation nobody has is named in terms: **the witness schedule has never run
  against the unmutated design.**
- **It labels its own kinds.** §8.2 is external verification (API + git); §8.3 is
  a located error, checkable line by line against the RTL and one test unit; §8.4
  is derivation over the legal space, machine-confirmed at its own extremal cell
  and nowhere else; §8.6's limb-2 measurement is a read of committed test source at
  HEAD. No claim below §8.1 rests on a run this seat did not verify at its source.
