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
