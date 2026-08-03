# WO-0050 — eight seeded family-F mutations of M03, authored blind

- **Work order**: `agents/handoffs/WO-0050_family-f-mutation-campaign.md`, read at
  `6f385d9` (blob `aea384a32a32abf96e5cfe0b54576c146cc21064`, confirmed identical
  to the working-tree copy I opened).
- **Base SHA**: **`616686f`**. Every diff applies cleanly to it and to nothing
  else claimed.
- **Target file**, all eight: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, blob
  `81cd9ed7fc64e6265c53117f251ef948f24e3b00`, 772 lines, sha256
  `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`. Function
  touched, all eight: `create`.
- **Author**: auditor, under WO-0050 §1's allowlist and §2's intents. I authored
  neither M03's RTL nor any part of its bench, and the subject under test is not
  M03 but whether family F of `test/xgmii_rx_64/**` and row M03-E5 have teeth.
- **Status**: seeding only. **No diff has been run and I have seen no result.**
  This report contains no prediction about which unit reddens, which stays
  green, or what any message says; that is dv_lead's sealed side and I have not
  opened it.

| id | class | site at `616686f` | one-line intent |
|---|---|---|---|
| F-c1 | FCS removal suppressed on a runt closed by `/T/` | line 509 (record `r0`, 506–515) | a 5-to-63-octet frame is delivered with its four FCS octets still attached |
| F-c2 | the runt threshold off by one at its upper boundary | line 502 | "fewer than 64 received" becomes "64 or fewer", so a 64-octet frame is a runt |
| F-c3 | an output word emitted for a sub-five frame that must produce none | lines 728, 733–735 | a 1-to-4-octet frame emits a `tlast` word with `tkeep` = 0 |
| F-c4 | first-match reporting where two conditions hold | line 513 | on a runt that also fails the residue check, `error_bad_fcs` is suppressed |
| F-c5 | a sub-five-octet frame silently dropped, with no strobe at all | line 502 | the sub-five frame vanishes: no output word, and `error_runt` never pulses |
| F-c6 | the FCS-strip underflow, faithful | line 728 | the four-octet removal runs unconditionally and the octet count wraps |
| F-c7 | the in-word open-and-close abort detected, and never reported | line 588 (`q2`, 583–590) | epoch B's `error_bad_frame` bit is masked off; the closure still happens |
| F-c8 | the no-output-word strobe pin displaced by one cycle | lines 586–589 (`q2`, 583–590) | the in-word report path's two fixed register stages become one |

---

## 1. Scope statement — the allowlist, and what I actually read

WO-0050 §1 is an allowlist: six permitted path sets, everything else out of
bounds by construction. §1 also asks that my journal `Inputs` record what I
read. This section is the long form of that; the journal entry points here.

### 1.1 The six readable path sets

| | path set | what I read in it |
|---|---|---|
| 1 | **this packet** | `agents/handoffs/WO-0050_family-f-mutation-campaign.md` **in full**, at the blob committed at `6f385d9` |
| 2 | **`docs/specs/**`** | `docs/specs/modules/xgmii_rx_64.md` at `616686f`: §6.1 and §6.2 and the head of §6.3 (lines 256–535), §9 **in full** (711–864), and §10's REQ rows for REQ-102/103/105/107/108/016 (a grep over 865–905). `docs/specs/requirements.md` at `616686f`: §0.3 (63–92), §0.6 (244–287), §0.7 (288–313), and the REQ-008, REQ-011, REQ-103, REQ-104, REQ-105, REQ-107, REQ-108 and REQ-901 rows (a grep, first 520 characters of each). Nothing else in either file. |
| 3 | **`docs/adr/**`** | **nothing — a deliberate abstention, recorded because `Inputs` is meant to be what I read rather than what I was allowed to read.** ADR-0006, ADR-0007, ADR-0010, ADR-0013 and ADR-0014 are quoted at the points that matter inside SPEC-M03 §6 and §9 and inside `xgmii_rx_64.ml`'s own comments, and no family-F intent turned on a decision record I had not already got there. |
| 4 | **`libs/**`** | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `616686f` **in full** (772 lines); `xgmii_rx_64.mli` (45 lines); `libs/hardcaml_ethernet/src/dune` (4 lines). The other ten files of `libs/hardcaml_ethernet/src/` were extracted into scratch by the tree copy and **never opened**; the only thing I learned about them is the operator census in §4, which printed occurrence **counts** and no content. |
| 5 | **`docs/reports/audit/**`** | my own prior artifacts, for the diff-format conventions: the heading outline of `WO-0045-mutations/README.md`, the first 30 lines of `WO-0045-mutations/E-c1.diff`, and `WO-0045-mutations/E-c3.diff` in full; plus a listing of `docs/reports/audit/`. |
| 6 | **root-level build configuration** | `dune-project` (2 lines) and `.ocamlformat` (2 lines) at `616686f`, plus the top-level name listing from `git ls-tree 616686f --name-only`. |

**`.ocamlformat` read under item 6, and the reasoning stated rather than
assumed.** §1 item 6 promotes "`dune-project` and any sibling build config at
the repository root", on the ground that build configuration carries no bench,
prediction or verdict content. Process bar 8 makes `dune build @fmt` part of
"Build state" for the compile-only repair exception, so the file that configures
`@fmt` is build configuration in this campaign's own sense. It contains two
lines — `profile = janestreet`, `version = 0.26.2` — and neither is a fact about
the bench. This was open question 2 of `J-auditor-0007`; I have read item 6 as
answering it, and flag the reading here so it can be overruled rather than
discovered.

### 1.2 Out of bounds — the confirmation

- **The sealed predictions file was never opened, listed, hashed, diffed,
  grepped, or shown at any revision.** I know its path only because §0 of the
  packet prints it. No git subcommand of mine has ever named it.
- **No file under `test/**` was opened, at any revision, by any means** — not
  the family-F bench, not `test_m03_e.ml`, not `AP-xgmii_rx_64.md`, not the
  co-simulation lane.
- **No file under `agents/**` was opened except this packet**, save the two
  reads the spawn message directed, disclosed in §1.3.
- `site/`, `tools/`, `tasks/`, `bin/`, `scripts/`, `rtl_snapshots/`, `.github/`
  and `.claude/` were not opened at any revision.
- **Two leakage events, disclosed rather than smoothed.** (i) `git status
  --porcelain`, run once to establish the working tree's state, printed four
  modified **path names**, two of them under `agents/` and two under
  `test/cosim/`. I opened none of them and read no content; the names concern
  WO-0049's co-simulation canon format, which is not this campaign. (ii) `git
  ls-tree 616686f --name-only` at the top level printed the repository's
  top-level entry names, which is how I identified the root build-config
  siblings item 6 permits. Both are directory-level metadata, not content, and
  both are recorded because an allowlist is only worth what its holder
  discloses.
- **No unscoped `git log`, ever.** Every git subcommand either named an
  allowlisted path (`show`, `rev-parse <sha>:<path>`, `archive 616686f libs/`,
  `hash-object`) or was repo-level metadata (`rev-parse HEAD`, `status`, the
  top-level `ls-tree`). No `git show` of a barred path at any revision; no `git
  grep`; no `git diff` naming a barred path.

### 1.3 The two reads the spawn message directed, outside §1's allowlist

My spawn brief and my standing charter both order two reads "before anything
else": `agents/charters/auditor.md`, and the tail of my own journal
`agents/journals/claude_auditor_agent.md`. Both are `agents/**` and therefore
outside WO-0050 §1. I did them, in that order, **before opening the packet**,
and I record them here rather than letting the allowlist statement quietly
overstate itself:

- `agents/charters/auditor.md` — in full. My own operating document.
- `agents/journals/claude_auditor_agent.md` — the final 120 lines, an entry-header
  grep, and lines 1354–1400, i.e. **parts of `J-auditor-0007` only**, for the
  entry grammar and the last campaign's disclosures. No earlier entry was
  opened, and no other agent's journal was opened at all.

Neither contains family-F material: the charter predates the campaign and the
journal tail is my own account of family E, which this packet itself cites.
**`agents/PROTOCOL.md` was not read this round** — the same abstention as
WO-0045, with the packet and the charter supplying the process in its place.

### 1.4 Prior exposure

§1's last paragraph asks for this. I have read `agents/**` material in earlier
spawns — packets, verdicts and journals across WO-0001, WO-0039, WO-0041,
WO-0042 and WO-0045 — and that is known and expected. What is barred is reading
it *now*, and I have not. I have never read `test_m03_f.ml`, `test_m03_e.ml`,
`AP-xgmii_rx_64.md` or `WO-0047` at any point in any spawn.

### 1.5 The five process bars

7. **All eight diffs authored before any of them is run.** None has been run.
   None has been built (§5.1: there is no toolchain here to build it with).
8. **No diff revised after any result**, there being none. **No build-only
   repair was made**, because no diff has been compiled. If one fails to build,
   bar 8's procedure applies and I will change nothing else and disclose it.
9. **Private scratch subdirectory**:
   `…/scratchpad/wo0050/`, created for this work order.
10. **Tree copies exclude out-of-bounds paths by construction, not by
    filtering.** I did not copy the tree and filter it: `git archive 616686f
    libs/` names the one allowlisted path set, so no barred path was ever
    materialised to be excluded. That is stronger than `tar --exclude` and is
    why no `--exclude` list appears in §4.
11. **No unscoped `git log`; barred paths barred to every git subcommand.** See
    §1.2.

---

## 2. What is delivered

Eight diffs, one per class, each applying cleanly to `616686f`, each touching
one file and one function, each carrying a greppable `MUTATION` marker naming
its class and this work order.

```
docs/reports/audit/WO-0050-mutations/
  f-c1.diff  f-c2.diff  f-c3.diff  f-c4.diff
  f-c5.diff  f-c6.diff  f-c7.diff  f-c8.diff
  README.md   (this file)
```

Each diff is a throwaway-branch input: `616686f` + one diff, never merged. The
diffs embedded in §3 below were spliced from the `.diff` files by script and
verified byte-identical to them (§4).

---

## 3. The eight mutations

Each subsection quotes the packet's class line, names the site, states the
defect the mutation fakes, gives the diff in full, and argues fidelity —
including, where it applies, what the diff does **not** reach.

### 3.1 F-c1 — "FCS removal suppressed on a runt closed by `/T/`"

**Site.** Line 509 at `616686f`, the `~terminate` field of the epoch-A closure
record `r0` (lines 506–515), inside `create`.

**The defect it fakes.** A design that reads REQ-107's runt disposition as an
*alternative* to REQ-103's FCS removal rather than as an addition to it — "it is
a runt, so there is nothing to strip" — and consequently forwards a 5-to-63-octet
frame with its four FCS octets still in the stream: four octets too many.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..a03ca16cb3bdc39b604efa513d31c9d8306dda40 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -506,7 +506,12 @@
   let r0 =
     record_fields
       ~valid:a_close_now
-      ~terminate:a_close_terminate
+      (* F-c1 MUTATION (WO-0050) — FCS removal suppressed on a runt closed by
+         `/T/`.  The record's terminate flag, whose only consumer is [strip]
+         below, is cleared for a frame of 5 to 63 received octets, so REQ-103's
+         removal is not attempted and four octets too many are delivered.  The
+         closure itself, the runt report and the FCS verdict are untouched. *)
+      ~terminate:(a_close_terminate &: ~:(a_close_runt &: has_fcs))
       ~error:a_close_error
       ~start:a_close_start
       ~oversize:a_close_oversize
```

**Fidelity.** The record's terminate flag has exactly one consumer in the whole
module, `strip` at line 696 — `sel_terminate` occurs at its definition (529) and
at 696 and nowhere else, which §4's census checks mechanically. Clearing it for
`a_close_runt &: has_fcs` — terminate-closed, and 5 ≤ received count < 64 — sets
`strip` to 0 for exactly the class §9's fifth row governs, so the four octets are
not removed. With `strip` = 0, `emit_last_b` (which needs `nc <=: strip` with
`nc <>:. 0`) cannot fire for such a frame, `fcs_tail_pending` stays low, and the
word the base suppressed as all-FCS is emitted instead: the frame goes out in
full, `tlast` on its own last word. Everything the intent protects is untouched.
Frames of 64 octets and above: `a_close_runt` is low, flag unchanged. Frames
below five octets: `has_fcs` is low, flag unchanged, so §9's sixth row keeps its
`pc` = 4 = `strip` guard and still emits no word — this diff does not trespass on
F-c3's or F-c5's class. The REQ-105 and REQ-110 abort paths never set the
terminate flag at all, and `error_oversize`'s strip term is a separate disjunct
of the same `mux2`. The runt report, the FCS verdict, `tuser`[0], the state
machine and the CRC all read `a_close_terminate` itself, which is unchanged.

**One consequence, named so it is not mistaken for a second defect.** For a frame
whose received length is 1, 2, 3 or 4 modulo 8 the FCS straddles two aligned
words, so the frame now occupies one output word more than it did and its `tlast`
moves one cycle later — and with it §9's strobe pin, which for a frame that
produces an output word *is* its `tlast` cycle. The frame got longer; the pin did
not move. The record is not orphaned by the shift: in exactly that straddle case
the base emitted `tlast` at record age 1 and the mutant emits it at age 2, which
is the cycle `consume` fires anyway through `sel_is_r2`, so the strobe and
`tuser`[0] land together on the new `tlast` word. For lengths 5, 6, 7 and 0
modulo 8 the `tlast` cycle does not move at all; only `keep_count` changes.

### 3.2 F-c2 — "the runt threshold off by one at its upper boundary"

**Site.** Line 502 at `616686f`, `a_close_runt`, inside `create`.

**The defect it fakes.** A threshold written as "64 or fewer" where REQ-107 says
"fewer than 64" — the classic boundary slip, on the **received** octet count, so
that the legal minimum frame is reported as a runt.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..2300f74b57a03713eeb2cf71e2c69a37fc47d3d1 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -499,7 +499,12 @@
      word at W + 3, while the record born at W is consumed at W + 2 at the
      latest. Consumptions therefore never contend, and each record is at age 2
      exactly when its turn comes. *)
-  let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
+  (* F-c2 MUTATION (WO-0050) — REQ-107's runt threshold off by one at its
+     upper boundary: "fewer than 64 octets between the start and terminate
+     characters" is implemented as "64 or fewer", on the received count, so a
+     64-octet frame — the legal minimum, §0.3 — is marked and reported exactly
+     as a 63-octet frame is. *)
+  let a_close_runt = a_close_terminate &: (count_next <:. (runt_threshold + 1)) in
   let record_fields ~valid ~terminate ~error ~start ~oversize ~fcs ~runt =
     concat_lsb [ valid; terminate; error; start; oversize; fcs; runt ]
   in
```

**Fidelity.** `count_next` is the frame's received total through the closing
character's own octet time — the module's own comment at lines 455–458 says so —
which is precisely §9's "octets between start and terminate", so the mutation is
pinned to the received count as the packet directs and not to the delivered one.
`a_close_runt`'s only consumer is the record's `~runt` field (census: definition
502, use 514), so nothing else in the design can move: `sel_runt` feeds `abort`,
which sets `tuser`[0] once on the `tlast` word, and `error_runt`. A 64-octet
frame therefore acquires exactly the marking and the single report a 63-octet
frame has. Its octets, its `tkeep` extent and its `tlast` cycle are functions of
`strip`, which reads `sel_terminate` and not the runt bit; its FCS verdict is
`bad_fcs`, computed from `has_fcs` and the residue, untouched. A 65-octet frame
is outside the new bound. Frames below five octets are already inside the old
one and are unaffected either way.

**Operator choice, disclosed.** The mutation is written `<:. (runt_threshold + 1)`
rather than `<=:. runt_threshold`. The two are the same predicate on an 11-bit
unsigned count where 65 < 2^11. I chose the first because `<=:.` occurs **zero**
times anywhere under `libs/**` while `<:.` is used in this very line, and with no
Hardcaml in this container (§5.1) I cannot typecheck an operator the tree has
never exercised. The defect shape is the comparison's bound, and it is off by
exactly one either way.

### 3.3 F-c3 — "an output word emitted for a sub-five frame that must produce none"

**Site.** Lines 728 and 733–735 at `616686f`, `emit_last_a` and `keep_count`,
inside `create`.

**The defect it fakes.** A design that wants somewhere to put the abort bit and
so emits a `tlast` word for a frame that delivered nothing — the word carrying
`tkeep` = 0, which is the form the packet's intent names first.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..7e6ab6d09793e9586e0bc41fbc01599ded775b44 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -725,13 +725,18 @@
   let fcs_tail_pending = wire 1 in
   let fcs_tail_now = reg spec fcs_tail_pending in
   let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
-  let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
+  (* F-c3 MUTATION (WO-0050) — an output word emitted for a sub-five frame
+     that must produce none.  The [pc >: strip] guard §9's sixth row rests on is
+     dropped, so a frame of 1 to 4 received octets emits a `tlast` word; the
+     count is clamped at zero in [keep_count] below, so that word carries
+     `tkeep` = 0 rather than an underflowed extent. *)
+  let emit_last_a = have_word &: (nc ==:. 0) in
   let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
   fcs_tail_pending <== emit_last_b;
   let emit_full = have_word &: (nc >: strip) in
   let emit_tlast = emit_last_a |: emit_last_b in
   let keep_count =
-    mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
+    mux2 emit_last_a (pc -: min2 pc strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
   in
   let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
   let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
```

**Fidelity.** The `pc >: strip` guard is, in the module's own words at lines
699–702, "what stops a word made *only* of FCS octets from going out", and §9's
sixth row "is that guard's own instance". Dropping it admits exactly what the
guard excluded, and no more: `have_word` still requires `pc <>:. 0` and
`~:fcs_tail_now`, and `nc ==:. 0` still requires an empty lookahead word, so the
only frames newly admitted are terminate-closed frames of **1 to 4 received
octets**. Every longer frame whose final aligned word holds 1 to 4 octets is the
all-FCS tail that the previous cycle's `emit_last_b` already suppressed through
`fcs_tail_now`; an oversize frame's final word holds six; and on the REQ-105 and
REQ-110 paths `strip` is 0, where the removed guard `pc >: 0` was already implied
by `have_word` — so those frames are bit-identical. The clamp is what keeps this
class distinct from F-c6: `pc -: min2 pc strip` uses the module's own `min2`
(line 352) and equals `pc -: strip` on every case the base admitted, since there
`pc > strip` — it is inert outside the new class and yields `tkeep` = 0 inside
it. **The strobe does not move**, as the intent requires: for a frame of 1 to 4
octets the newly emitted word falls on the cycle the closure record reaches age
2, which is the cycle §9 already pinned the report to, and `consume` fires there
in the base and in the mutant alike.

**What it does not reach, said plainly.** A frame of **zero** octets between
`/S/` and `/T/` still emits nothing. Its aligned word has `pc` = 0, so
`have_word` is low for a reason that has nothing to do with the guard, and the
only edit that would emit a word for it emits words on idle cycles across the
whole design — not a mutation but a different module. The class is therefore
seeded at 1 to 4 octets, not 0 to 4.

**Collision noted, per the standing clause.** The emitted word carries `tkeep` =
0 with `tvalid` = 1, which REQ-011 forbids outright and §0.7 restates. That is
the form the packet's own intent names ("a word with `tkeep` = 0"), so here it is
the defect rather than collateral damage to a second rule; it is recorded because
the standing clause asks for collisions to be named rather than absorbed.

### 3.4 F-c4 — "first-match reporting where two conditions hold"

**Site.** Line 513 at `616686f`, the `~fcs` field of the closure record `r0`,
inside `create`.

**The packet asks which of the two strobes the diff suppresses. It suppresses
`error_bad_fcs`. `error_runt` survives.**

**The defect it fakes.** A report chain that stops at the first matching
condition — the frame's disposition is decided once, and the second applicable
condition never gets to pulse.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..0538144861729fff295ae09397b9c461a7ba6c44 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -510,7 +510,13 @@
       ~error:a_close_error
       ~start:a_close_start
       ~oversize:a_close_oversize
-      ~fcs:(a_close_terminate &: bad_fcs)
+      (* F-c4 MUTATION (WO-0050) — first-match reporting where two conditions
+         hold.  §9's first co-occurrence ruling admits `error_runt` together
+         with `error_bad_fcs` on a frame of 5 to 63 octets; here the FCS report
+         is suppressed on exactly that frame and the runt report survives.
+         `tuser`[0] is still set once, on the same word: [abort] reads
+         [sel_runt] as well. *)
+      ~fcs:(a_close_terminate &: bad_fcs &: ~:a_close_runt)
       ~runt:a_close_runt
   in
   (* [consume] is defined by the output decision below; the two are mutually
```

**Fidelity.** §9's first co-occurrence ruling requires both strobes, each once,
on the `tlast` cycle of a terminate-closed frame of 5 to 63 octets that also
fails the residue check. The added `~:a_close_runt` removes the FCS report on
exactly that frame and on no other. Everything else the ruling pins survives:
`tuser`[0] is still set once on the same word, because `abort` (line 736) reads
`sel_runt` as well as `sel_bad_fcs`; the delivered extent is unchanged, because
`strip` reads `sel_terminate`; a frame of 64 octets or more with a bad FCS keeps
its `error_bad_fcs`, since `a_close_runt` is low there; and the sub-five class is
untouched, since `bad_fcs` is already low there through `has_fcs` — so this diff
disturbs neither §9's ninth ruling nor the class F-c5 attacks.

**Why this one and not the other.** The packet leaves the pick to whichever is
minimal in the design. Suppressing the FCS report extends a conjunction the field
already has (`~fcs:(a_close_terminate &: bad_fcs)`), where suppressing the runt
report would have to introduce parentheses around a bare identifier
(`~runt:a_close_runt`); and the surviving report is then the frame-level
disposition of REQ-107 rather than the subordinate verdict, which is the order
`record_fields` itself lists the two fields in (line 503, `~fcs` before `~runt`).
The alternative — `~runt:(a_close_runt &: ~:bad_fcs)` — is equally available, is
equally one term, and was **not** seeded.

### 3.5 F-c5 — "a sub-five-octet frame silently dropped, with no strobe at all"

**Site.** Line 502 at `616686f`, `a_close_runt`, inside `create` — the same line
F-c2 attacks from the other end.

**The defect it fakes.** A threshold that quietly lifts the sub-five class out of
the reporting path: the frame is correctly not emitted, and then not reported
either. REQ-008's prohibition on silent discard, denied.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..9f317f2d0570617f59cb9e19592ebdbbc6fbfbd7 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -499,7 +499,12 @@
      word at W + 3, while the record born at W is consumed at W + 2 at the
      latest. Consumptions therefore never contend, and each record is at age 2
      exactly when its turn comes. *)
-  let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
+  (* F-c5 MUTATION (WO-0050) — a sub-five-octet frame silently dropped.  The
+     runt report is qualified by [has_fcs], i.e. by the frame having five or
+     more received octets, so §9's sixth row loses its strobe: the frame
+     produces no output word, as it should, and pulses nothing at all.  Frames
+     of 5 to 63 octets keep their report. *)
+  let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) &: has_fcs in
   let record_fields ~valid ~terminate ~error ~start ~oversize ~fcs ~runt =
     concat_lsb [ valid; terminate; error; start; oversize; fcs; runt ]
   in
```

**Fidelity.** `has_fcs` is the design's own name for "five or more received
octets" (line 470), evaluated on the same cycle and from the same `count_next` as
the runt test beside it, so the qualifier is exact rather than approximate.
`a_close_runt`'s only consumer is the record's `~runt` field, so the record stays
**valid** — `~valid:a_close_now` is untouched — and therefore still ages and is
still consumed at age 2 by `sel_is_r2`, with every strobe bit low. Nothing
pulses, nothing lingers, and no output word was ever due. Frames of 5 to 63
octets keep `error_runt` exactly as before; `strip`, the FCS verdict, the state
machine and the other four strobes read signals this diff does not touch. It will
look quiet, and that is the class: outside the sub-five frame the design is
bit-identical to the base.

### 3.6 F-c6 — "the FCS-strip underflow, faithful"

**Site.** Line 728 at `616686f`, `emit_last_a`, inside `create`.

**The packet asks whether a faithful underflow is expressible in this design at
all. It is, and this diff is it** — see the two readings below.

**The defect it fakes.** FCS removal attempted unconditionally at the terminate
character, on a frame with fewer than four octets to remove it from, with the
resulting octet count allowed to wrap rather than being clamped at zero.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..3da9c0b3dce91c71f79a0d10e4ff3882ef2d230f 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -725,7 +725,13 @@
   let fcs_tail_pending = wire 1 in
   let fcs_tail_now = reg spec fcs_tail_pending in
   let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
-  let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
+  (* F-c6 MUTATION (WO-0050) — the FCS-strip underflow, faithful.  The
+     [pc >: strip] guard is this design's only clamp on the four-octet removal,
+     so removing it attempts the removal unconditionally at the terminate
+     character and lets [pc -: strip] underflow, in four-bit arithmetic, on a
+     frame with fewer than four octets to remove it from.  The consequence is
+     left to [keep_count] and [keep_of_count] as they stand. *)
+  let emit_last_a = have_word &: (nc ==:. 0) in
   let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
   fcs_tail_pending <== emit_last_b;
   let emit_full = have_word &: (nc >: strip) in
```

**Fidelity, and the answer.** This design's **only** clamp on the removal is the
`pc >: strip` guard. `strip` is set to 4 at line 696 for every terminate closure
without regard to how many octets the frame has, and `keep_count` computes
`pc -: strip` in four-bit arithmetic — the subtraction is already unconditional;
what the guard does is refuse to *select* it when `pc <=: strip`. Removing the
guard therefore performs the removal on a frame with nothing to remove it from
and lets the count underflow: `pc` = 1, 2, 3 give `keep_count` = 15, 14, 13, and
`keep_of_count` (line 259) maps every index above 8 to `ones 8`, so the word
leaves with `tkeep` = 0xFF; `pc` = 4 gives 0. **Nothing is engineered around that
consequence** — no clamp, no saturation, no reshaping of `keep_of_count` — which
is exactly what separates this diff from F-c3, whose single extra edit is the
clamp. The blast radius is identical to F-c3's and is bounded the same way
(terminate-closed frames of 1 to 4 received octets only, for the reasons set out
in §3.3), and the zero-octet frame is out of reach for the same structural
reason.

**The declared kill says "underflows its counter", and the design has two
counters. Both readings are answered rather than one.** (i) The **delivered-octet
count** of the FCS removal, `pc -: strip`: it *can* underflow, it is what this
diff seeds, and the underflow is observable at `tkeep`. (ii) The **received-octet
counter**, `count` (line 341, 11 bits): it is **structurally unable to go
negative** in this design. It is only ever advanced by `count_next = count +:
uresize cov_count count_bits` and reloaded to zero on `begins`; no path subtracts
from it, and the FCS removal never touches it — REQ-103's removal here is
performed by `tkeep` and never by arithmetic on the received count, which is what
the module's "removed by `tkeep` and never by holding octets back" design note
(lines 25–27) amounts to. Manufacturing an underflow there would mean adding a
subtraction that does not exist, i.e. substituting a diff for the class rather
than seeding it, and §2's standing clause says to say so instead. I say so.

### 3.7 F-c7 — "the in-word open-and-close abort detected, and never reported"

**Site.** Line 588 at `616686f`, within the `q2` binding (583–590), inside
`create`.

**The defect it fakes.** A reporting path written for one route through the
design and never wired for the other: the frame is opened, closed and discarded
entirely correctly, and only the report is missing.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..0f0d643764d65aa6debe6b8368bc16250b75fdfd 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -580,12 +580,20 @@
        `error_bad_fcs` out of this vector entirely (above). *)
     concat_lsb [ error; terminate; start ]
   in
+  (* F-c7 MUTATION (WO-0050) — the in-word open-and-close abort detected, and
+     never reported.  Epoch B — the frame a `/S/` in lane 0 opens, all eight of
+     whose preamble positions lie inside that one word (§6.1) — has bit 0 of
+     its report vector masked off, so `error_bad_frame` never pulses for a
+     frame opened and closed there by an `/E/` or by any other control
+     character.  The closure itself, epoch B's other two bits, epoch C and
+     every epoch-A abort path are untouched. *)
   let q2 =
     reg
       spec
       (reg
          spec
-         (inword_strobes ~exists:b_exists ~closing:b_closing
+         ((inword_strobes ~exists:b_exists ~closing:b_closing
+           &: concat_lsb [ gnd; vdd; vdd ])
           |: inword_strobes ~exists:c_exists ~closing:c_closing))
   in
   (* ---- the state machine (§6.2) ----
```

**Fidelity.** Epoch B is the frame a `/S/` in lane 0 opens, and §6.1 puts all
eight of its preamble positions inside that same input word, so every control
character that closes it in-word lies in lanes 1–7 and its report is the `error`
bit — bit 0 of `inword_strobes`, which `q_strobe 0` routes to `error_bad_frame`.
Masking that bit with `concat_lsb [ gnd; vdd; vdd ]` removes the report for
exactly that route: bits 1 and 2 — the same epoch's `/T/` runt report and its
`/S/` start-without-terminate report — still pulse, so a `/T/` or `/S/` in the
same lanes is reported normally; epoch C's vector is ORed in **unmasked**, so a
lane-4-started frame closed inside its own word keeps its `error_bad_frame`; and
epoch A's `/E/` handling is a different path entirely (`a_close_error`, line 372,
reported through `strobe sel_error`), so an error character at the frame's first
octet position or in a mid-frame word keeps its report, as the intent requires.
The closure is untouched: `b_closing` and `survivor_b` still end the frame and no
output word is produced. What is lost is only the report, which is REQ-008 and
§9's third row denied on one structurally distinct route.

**Precedence, handled explicitly.** `&:` and `|:` share one precedence level in
OCaml, so the mask is parenthesized rather than left to associativity — matching
this file's own habit at lines 313, 419 and 574.

### 3.8 F-c8 — "the no-output-word strobe pin displaced by one cycle"

**Site.** Lines 586–589 at `616686f`, the inner register stage of the `q2`
binding (583–590), inside `create`.

**The defect it fakes.** An off-by-one in a fixed pipeline delay. The report is
right in name, right in content, and one cycle early.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..0e2f44d0503dc4f218ea5c83ba6b85a5a719a792 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -580,13 +580,18 @@
        `error_bad_fcs` out of this vector entirely (above). *)
     concat_lsb [ error; terminate; start ]
   in
+  (* F-c8 MUTATION (WO-0050) — §9's no-output-word strobe pin displaced by one
+     cycle, earlier.  The two fixed register stages below are the whole of that
+     pin for a frame opened and closed inside one input word; one of them is
+     removed, so every such report pulses one cycle after that word instead of
+     two, whatever the strobe's name and whatever character closed the frame.
+     Frames that do produce an output word report on their own `tlast` cycle
+     and do not move. *)
   let q2 =
     reg
       spec
-      (reg
-         spec
-         (inword_strobes ~exists:b_exists ~closing:b_closing
-          |: inword_strobes ~exists:c_exists ~closing:c_closing))
+      (inword_strobes ~exists:b_exists ~closing:b_closing
+       |: inword_strobes ~exists:c_exists ~closing:c_closing)
   in
   (* ---- the state machine (§6.2) ----
      One [Always] switch, and every transition is a function of the closure
```

**Fidelity.** §9 pins a strobe reporting a frame that produces no output word to
**two cycles after the input word carrying the character that ended the frame**,
and adds that "that clause is the whole of the rule for such a frame … a pin in
its own right, not a corollary of §6.1's `m + 3` formula". The design implements
that pin, for a frame opened and closed inside one word, as exactly two fixed
register stages — its own comment at lines 538–541: "Two fixed register stages
are therefore the whole of its reporting path: no ageing, no consumption
decision, because the cycle is not a function of anything downstream." Removing
one stage moves the pin to one cycle after that word, **earlier by one, not by
two, and not later**. It moves for every frame on the path, whatever character
closed it and whatever the strobe's name: bit 0 `error_bad_frame`, bit 1
`error_runt` and bit 2 `error_start_without_terminate` all shift together, and
both epoch B and epoch C feed the same two stages. Frames that do produce an
output word are unaffected, exactly as the intent requires: their report is
`strobe`, gated by `consume`, a function of `emit_tlast` and the record's age
that this diff does not touch. The verdict, the delivered extent, `tuser`[0] and
the strobe names are all unchanged; only the cycle moves.

**The half this diff does not reach, said plainly rather than substituted for.**
The no-output-word class has a second implementation here: an epoch-A record
consumed at age 2 because no `tlast` ever came — a sub-five frame, or a frame
aborted with zero delivered octets that opened in an **earlier** word. I did not
displace that half, and the reason is the standing clause. That report is
*conditional*: `consume <== sel_valid &: (emit_tlast |: sel_is_r2)` is one
expression serving both pins, so moving the no-output-word half one cycle earlier
by consuming at age 1 would also fire `consume` before the `tlast` of every frame
whose received length is 5, 6 or 7 modulo 8 — those frames' `tlast` falls exactly
at age 2 — clearing the record before its own `tlast` word and taking `tuser`[0]
and `strip` with it. That breaks §9's `tlast` pin and REQ-103's removal on a
class this very intent protects ("Frames that do produce an output word are
unaffected"), which is precisely the collision §2's standing clause governs. The
in-word half is seeded whole; the epoch-A half is named, argued, and left undone.

---

## 4. Self-check — what I ran, and what it returned

Everything in this section was run in the private scratch directory against
extractions of `616686f`. No result of any *bench* run is involved; none exists.

1. **Base identity, re-derived rather than assumed.**
   `git rev-parse 616686f:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` →
   `81cd9ed7fc64e6265c53117f251ef948f24e3b00`. The same command at `bc565a6`
   (the family-E base) returns the **same** blob, so the file is byte-identical
   across the two campaigns. `sha256sum` of the extraction →
   `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, 772 lines.
   The packet's own blob at `6f385d9` matches the copy I read
   (`aea384a32a32abf96e5cfe0b54576c146cc21064`).
2. **Generation.** One base string, eight mutants, exact-string replacement only;
   the generator **asserts each anchor occurs exactly once** and aborts
   otherwise, so a silent no-op or a doubled edit is impossible. Post-image
   blobs: f-c1 `a03ca16cb3bd`, f-c2 `2300f74b57a0`, f-c3 `7e6ab6d09793`, f-c4
   `053814486172`, f-c5 `9f317f2d0570`, f-c6 `3da9c0b3dce9`, f-c7
   `0f0d643764d6`, f-c8 `0e2f44d0503d`.
3. **`git apply --check --verbose` from a pristine `616686f` extraction**: all
   eight print `Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml...` and
   nothing else.
4. **Real application and byte comparison.** Each patch was applied to a **fresh**
   pristine extraction and the result `cmp`-ed against the generated mutant:
   **byte-identical in all eight cases**.
5. **Single-file and index-line pinning.** Each diff carries exactly one
   `diff --git` header and exactly one
   `index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..<post> 100644` line.
6. **Minimality.** Hunks and ±lines: f-c1 1/−1+6, f-c2 1/−1+6, f-c3 1/−2+7, f-c4
   1/−1+7, f-c5 1/−1+6, f-c6 1/−1+7, f-c7 1/−1+9, f-c8 1/−4+9 — of which 5, 5, 5,
   6, 5, 6, 7 and 7 added lines respectively are the marker comment. **With
   comments stripped, six of the eight are one line replaced by one line**; f-c3
   is two such lines; f-c7 adds one line and one parenthesis; f-c8 deletes the
   inner `reg`/`spec` pair and re-indents the two lines beneath it. The
   comment-stripped code delta of every mutant was computed and inspected, and
   in every case it is exactly the intended edit and nothing else.
7. **Parse check, with five negative controls.** `ocamlc -stop-after
   parsing -c` (OCaml 4.14.1) accepts the pristine file and all eight mutants.
   Five deliberately broken variants — a dropped paren in f-c1's `~:` argument, a
   dropped `in` in f-c5's binding, a dropped paren in f-c7's mask, a stray `;;`
   after f-c8's `in`, and a dropped paren in f-c3's `min2` application — were all
   **rejected** (`This '(' might be unmatched` ×3, `Syntax error` ×2), so the
   check has teeth.
8. **Binding census, over comment-stripped text.** The base has 135 `let`
   bindings and no unused one. Every mutant **adds no binding, removes no
   binding, and leaves none unreferenced** — the check that matters for f-c3 and
   f-c6, which delete a use of `strip` and of `pc`: both remain referenced
   (`strip` at 729, 731, 734; `pc` at 734), so no unused-variable warning is
   introduced.
9. **Width, whitespace and marker.** Every mutant's longest line is 97
   characters, which is the **base's own maximum** and comes from two
   pre-existing lines (622 and 696) that no diff touches; the longest line any
   diff *adds* is 87. Zero trailing-whitespace lines, zero tabs, zero CR, in the
   base and all eight mutants. Exactly one `MUTATION` marker per mutant.
10. **Splice check.** The eight diffs embedded in §3 were inserted into this
    README by script from the `.diff` files and verified byte-identical to them.

---

## 5. Disclosures

### 5.1 Compile-confidence: HIGH on syntax and scope, ASSERTED on types and widths

**Stated as a result rather than omitted: no mutant has been type-checked, and
none could be.** This container's opam switch (`fpga`, `ocaml-system.4.14.1`) has
**no Hardcaml packages installed**, and there is no `dune` and no `ocamlformat`
binary at all — `libs/hardcaml_ethernet/src/dune` requires `hardcaml`,
`hardcaml_axi`, `ppx_hardcaml` and `ppx_jane`, none of which are present. This is
the third campaign running in that state.

Machine-checked, therefore, and reported above: syntax (§4.7, with negative
controls), scope and binding hygiene (§4.8), whitespace and width (§4.9),
application and byte-identity (§4.3–4.5). Argued rather than demonstrated: types
and widths. The argument, per diff, is that every operand is a signal the base
file already computes at that width:

- **f-c1** `a_close_terminate &: ~:(a_close_runt &: has_fcs)` — three 1-bit
  signals (`a_close_runt` 502, `has_fcs` 470, both bound above line 509).
- **f-c2** `count_next <:. (runt_threshold + 1)` — `<:.` takes an `int` on the
  right, as it already does on this very line; 65 < 2^11 = the counter's range,
  so the literal cannot alias.
- **f-c3** `pc -: min2 pc strip` — `min2` (352) returns one of its two arguments,
  both 4-bit (`pc` = `popcount` of an 8-bit vector, `strip` = `of_int ~width:4`),
  so the subtraction is 4-bit, matching the other two `mux2` branches and
  `keep_of_count`'s 16-entry mux.
- **f-c4** `a_close_terminate &: bad_fcs &: ~:a_close_runt` — three 1-bit signals.
- **f-c5** `… &: has_fcs` — 1-bit conjunct on a 1-bit expression.
- **f-c6** removes a conjunct; the remaining expression is the base's own.
- **f-c7** `… &: concat_lsb [ gnd; vdd; vdd ]` — `inword_strobes` returns
  `concat_lsb [ error; terminate; start ]`, 3 bits; the mask is 3 bits by
  construction.
- **f-c8** removes one `reg spec` from a 3-bit expression; `q2` stays 3 bits and
  `q_strobe 0/1/2` still index it.

All identifiers introduced are bound **above** their use: `has_fcs` 470 < 502,
509; `a_close_runt` 502 < 509, 513; `min2` 352 < 734; `gnd` and `vdd` are
`Signal` constants the file already uses at 214 and 666. No shadowing, no forward
reference, no new binding at all.

### 5.2 Formatting is unverified, and the base's own margin is not clean

`ocamlformat` is absent, so I cannot run `dune build @fmt` or predict it. `.ocamlformat`
at `616686f` selects `profile = janestreet`, `version = 0.26.2`, whose margin is
90 — and **the base file already contains two 97-column code lines** (622 and
696), which no mutation of mine touches. I therefore could not establish that
`@fmt` is clean at the base, and I do not claim my mutants leave it in a state it
was not already in. What I did instead: every line any diff adds is **≤ 87
columns**, and the one construct that had to be re-wrapped (f-c8's `q2`, where
removing a register stage removes an indentation level) is wrapped in the shape
this file itself uses for a non-fitting application at lines 441–445 — arguments
broken one per line. If `@fmt` nevertheless rejects a mutant, that is bar 8's
compile-only repair class, the repair must be ocamlformat's own output, and I
will disclose it.

### 5.3 Two intents are seeded for one of two halves, and both say so

- **F-c3** is seeded for received lengths **1 to 4**, not 0 to 4; the zero-octet
  frame is unreachable from this site (§3.3).
- **F-c8** is seeded for the **in-word** report path, which is the whole of §9's
  no-output-word pin for a frame closed inside its own start word; the **epoch-A**
  half of the same class is named, argued and left undone, because displacing it
  breaks a second spec rule on the way (§3.8).

Neither was substituted for, widened, or quietly counted as complete. This is the
same disclosure shape as `E-c2` in the family-E campaign.

### 5.4 F-c4's pick and F-c6's answer, both required by §3 of the packet

- **F-c4 suppresses `error_bad_fcs`; `error_runt` survives.** The reasoning, and
  the equally-available alternative that was not seeded, are in §3.4.
- **F-c6: a faithful minimal underflow is expressible, and f-c6.diff is it** —
  on the FCS removal's delivered-octet count. On the *received* counter it is
  **not** expressible, because that counter has no subtraction anywhere in the
  design; §3.6 gives both readings rather than picking the convenient one.

### 5.5 Two allowlist judgements I made rather than escalated

Recorded so they can be overruled rather than discovered: reading `.ocamlformat`
as "root-level build configuration" under §1 item 6 (§1.1), and performing the
two `agents/**` pre-reads my spawn message and charter directed (§1.3). Both
are disclosed at the point they occur. Everything else on the allowlist I either
read and listed, or deliberately did not read and said so.

---

## 6. Open questions, routed through the orchestrator

1. **F-c8's epoch-A half.** Does dv_lead want a ninth diff attacking the
   record-ageing half of the no-output-word pin? It cannot be done without
   disturbing frames that *do* produce an output word — §3.8 gives the argument —
   so it would need either a wider diff than a mutation should be, or a redrawn
   intent. I neither substituted nor widened.
2. **F-c3 and F-c6 share a site.** They are distinguished by one edit — F-c3's
   clamp — and the packet's own contrast ("allowed to underflow *rather than
   being clamped at zero*") is what told me they should be. If the intended F-c3
   was instead the one-character `>:` → `>=:` change, that reaches only the
   4-octet member of the class and I judged it less faithful; the choice is
   stated here so it can be reversed cheaply.
3. **`@fmt` and the base's two 97-column lines.** Is `dune build @fmt` actually
   clean at `616686f`? If it is not, a `@fmt` failure under any mutation is
   pre-existing rather than mine, and bar 8's repair clause should not be spent
   on it. I could not check (§5.2).
4. **Compile-confidence is argued, not demonstrated**, for the third campaign
   running, because the toolchain is absent from this container. If any diff
   fails to build, bar 8 applies: I will change nothing else and will disclose
   the repair.
