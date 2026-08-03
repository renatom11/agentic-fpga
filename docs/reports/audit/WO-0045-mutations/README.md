# WO-0045 — five seeded family-E mutations of M03, authored blind

- **Author**: auditor (independent; I authored neither M03's RTL nor any part of
  its bench, and I have no stake in either verdict — the same no-stake standing
  as WO-0039, WO-0041 and WO-0042)
- **Date**: 2026-08-03
- **Packet**: `agents/handoffs/WO-0045_family-e-mutation-campaign.md`, read at
  commit `520ab9b` — dv_lead's brief, §§0–5 of which are my whole instruction
- **Subject under test**: **not M03.** Family E of `test/xgmii_rx_64/**`, and
  whether it has teeth (the packet's own framing, §0 and the header)
- **Base**: every diff is against `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
  **exactly as it stands at `bc565a6`** — blob
  `81cd9ed7fc64e6265c53117f251ef948f24e3b00`, sha256
  `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, 772
  lines. Each diff's own `index 81cd9ed..` line names that preimage blob, so
  `git apply --3way` verifies the base as well as the context.
  *Falsifiable side notes*: (a) `git diff --stat bc565a6 1e77706 -- libs/` is
  **empty**, which is the packet header's own criterion-3 claim re-derived
  rather than taken on trust — the green run at `1e77706` is this base's
  control for every compiled surface I touch; (b) that blob is the **same**
  blob as WO-0039's, WO-0041's and WO-0042's base
  (`git rev-parse 447d11c:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` returns
  `81cd9ed7…` as well), so this file has not moved across four campaigns and
  the D-family diffs' context lines remain valid against it.
- **Artifacts**: `E-c1.diff` … `E-c5.diff` in this directory. Each is a
  single-file unified diff applying with `git apply` from the repository root.
  They are reproduced in full in §3; **the `.diff` files are authoritative** and
  the inlined text is generated from them, never retyped.
- **Journal**: `J-auditor-0007`

> **These patches are mutations. They are never to be committed to any branch
> that merges.** Packet §4: one throwaway branch per mutation, parent
> `bc565a6`, exactly one diff, never merged. Every hunk carries an
> `E-cN MUTATION (WO-0045)` marker comment, so a leaked mutant is greppable
> with one `grep -rn 'MUTATION (WO-0045)'`.

---

## 1. Scope statement — the allowlist, and the prior-exposure disclosure

Packet §1 replaces the previous campaigns' growing deny-list with an
**allowlist**: five readable path sets, everything else out of bounds, plus
five process bars. §0 makes my own `Inputs` disclosure the whole of the
enforcement. **All ten were honoured.** Stated individually, in the packet's
own order.

### 1.1 The five readable path sets, and what I actually read in each

1. **This packet** — `agents/handoffs/WO-0045_family-e-mutation-campaign.md`,
   read in full at `520ab9b` via `git show`, which is the only file under
   `agents/**` I opened for its content this session other than my own charter
   and my own journal's tail (see §1.3).
2. **`docs/specs/**`** — `docs/specs/modules/xgmii_rx_64.md` in full (all 949
   lines, extracted with `git show bc565a6:…` into a private scratch
   subdirectory), and `docs/specs/requirements.md` in part: §0.6 and §0.7
   (lines 240–324) and the whole of §2, REQ-101 … REQ-113 (lines 410–435), plus
   one grep for the REQ ids the packet's spec basis names.
3. **`docs/adr/**`** — **not opened.** The four ADRs the intents lean on
   (ADR-0006, ADR-0007, ADR-0013, ADR-0014) are quoted at the points that
   matter inside SPEC-M03 itself, and nothing in the five intents turned on a
   decision record I had not already got from the spec. This is an abstention
   inside the allowlist, not a bar; it is disclosed because §1.5 is meant to be
   a complete list and not a permitted-set restatement.
4. **`libs/**`** — `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `bc565a6` in
   full (the mutation target), and directory listings of
   `libs/hardcaml_ethernet/src/`. No other file under `libs/` was opened;
   in particular I did **not** re-read `crc32_eth.ml` or `axi64.ml` this round,
   because no family-E intent turns on M02's convention or on the width of
   `tuser` (WO-0042 needed the latter; this campaign does not).
5. **`docs/reports/audit/**`** — my own tree: `WO-0041-mutations/README.md`
   (my own prior artifact, for the section structure and the index-line and
   hunk-marker conventions) and a `git ls-tree` listing of the directory.

### 1.2 Out of bounds — the confirmation

- **All of `test/**` — not read.** I opened no file under `test/` at all, of any
  name, at any SHA, in this session: not `test_m03_e.ml`, not any sibling
  family, not `test/attack_plans/AP-xgmii_rx_64.md`, not a dune stanza. `test/`
  was **excluded from the tree copy by `tar --exclude`** (packet bar 9) and is
  physically absent from the scratch tree, so no build could have reached it
  even by accident — §4 check 0 records the guard and its output.
- **All of `agents/**` — not read**, with the two exceptions the campaign itself
  names: this packet (§1 item 1) and my own charter, which my spawn instruction
  requires me to read first. The **sealed companion**
  (`…-SEALED-predictions.md`) was **not opened**; I know of it only that it
  exists and its path, both of which are stated in the packet I am permitted to
  read. The **WO-0043 packet was not opened**, so I have not seen the
  line-by-line description of `test_m03_e.ml`'s internals that §1 warns me it
  contains. No journal of any other agent was opened. `agents/` was likewise
  excluded from the tree copy by `tar --exclude`.
- **Everything else in the repository — not read.** The allowlist is a
  whitelist, so this clause is the substantive one, and one file is worth
  naming because I used it last round and could not this round:
  **`.ocamlformat` is outside the allowlist and was not read.** Neither was
  `dune-project`, nor `libs/hardcaml_ethernet/src/dune` (read at WO-0042, not
  here — the build's own error output named the two missing libraries without
  my opening it), nor `ORG_CHART.md`, `README.md`, `agentic_fpga.opam`, nor
  anything under `.github/`, `.claude/`, `bin/`, `scripts/`, `site/`, `tasks/`,
  `tools/`, `top/`, `rtl_snapshots/` or `docs/` outside items 2, 3 and 5.
  **One incidental exposure is disclosed rather than glossed**: my first tree
  copy excluded only the paths I had reasoned about in advance, and a
  `find -maxdepth 1 -type d` over that copy printed the names
  `.claude .github bin libs scripts site tasks`. I read no content from any of
  them; I rebuilt the copy immediately, restricted to `libs/` plus root-level
  files, and the second listing additionally showed the root file names quoted
  above. Directory and file **names** are all that reached me.
- **No unscoped `git log`** was run, and no `git` subcommand of any kind was
  aimed at a path outside the allowlist (bar 10). Every `git show`, `git
  rev-parse`, `git diff` and `git ls-tree` invocation in this work order carries
  an explicit path argument inside the allowlist, or names only commits and
  blobs. The only commit subjects that reached me are none: I ran no
  `git log --format=%s` at all this round.

### 1.3 The one exception the orchestrator granted, and its extent

My journal lives under `agents/**`. To append I must know my next entry number,
so the orchestrator granted the minimal necessary exception: read the **tail**
of `agents/journals/claude_auditor_agent.md` from the last entry header, and
nothing above it. Extent, exactly: one `grep -n 'J-auditor-[0-9]' | tail -1`,
whose output as it reached me was the single line number `1082`, and one
`sed -n '1080,$p'` — the last entry (`J-auditor-0006`, WO-0042) and the two
lines above its header. Nothing between line 1 and line 1079 was displayed.
The next id is therefore `J-auditor-0007`.

### 1.4 Prior exposure, disclosed because §1's last paragraph asks for it

I have read `agents/**` material in prior spawns — the WO-0039, WO-0041 and
WO-0042 packets, `agents/PROTOCOL.md`, and my own journal in full — and the
packet says plainly that this is known, expected and not a disqualification;
what is barred is reading it *now*. For this campaign the material question is
narrower and I answer it directly: **I have never read `test_m03_e.ml` or any
part of family E, at any SHA, in any spawn**, nor the WO-0043 packet, nor
`AP-xgmii_rx_64.md`. What I carry from prior spawns about M03's bench is the
family-D round's published mutation → row table (WO-0040 §9, which the packet
itself names as the leak it is correcting) and the D-family verdicts — all of
it about family D and the FCS path, none of it about family E or the abort
path. My charter and `agents/PROTOCOL.md` were read in earlier spawns; this
round I re-read only the charter, because the spawn brief supplies the process
in PROTOCOL's place (the brief's own exception note).

### 1.5 Complete list of everything read for this work order

Read in full: `agents/charters/auditor.md`;
`agents/handoffs/WO-0045_family-e-mutation-campaign.md` at `520ab9b`;
`docs/specs/modules/xgmii_rx_64.md` at `bc565a6` (949 lines);
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `bc565a6` (772 lines, blob
`81cd9ed7…`, extracted with `git show`/`git archive` into a private scratch
subdirectory — the working tree's copy was never opened and never modified);
`docs/reports/audit/WO-0041-mutations/README.md` (my own prior artifact).

Partial: `docs/specs/requirements.md` at `bc565a6` — §0.6/§0.7 (lines 240–324),
§2 REQ-101…REQ-113 (lines 410–435), and one id grep; my own journal, the tail
described in §1.3 only.

Git metadata only, no file content: `git rev-parse` on the base blob at
`bc565a6` and at `447d11c`; `git diff --stat bc565a6 1e77706 -- libs/` (empty);
`git ls-tree -r --name-only bc565a6 -- libs` and `-- docs/reports/audit`.

Directory listings only: `libs/hardcaml_ethernet/src/`,
`docs/reports/audit/`, the scratch tree's own top level (see §1.2's incidental
exposure), and the opam switch's `bin`/`lib`.

Tools, not repository content: `ocamlc -stop-after parsing` (OCaml 4.14.1),
`dune build libs/` inside the scratch tree, `git apply --check`,
`git hash-object`, `diff -u`, and text arithmetic in `python3`.

### 1.6 The five process bars

6. **All five diffs were authored before any of them was run**, and none has
   been run: no simulation, no `dune runtest`, no bench of any kind. The five
   were written as one act against §2's five intents and generated in a single
   `python3` pass (§4 check 1's transcript is that pass), so the last was
   finished before the first left my hands.
7. **No diff has been revised after any run result**, there being no run result:
   I do not run the diffs and I do not see the results. **No compile-only repair
   was made**, because no diff has been compiled — see §5.1, which states the
   compile-confidence honestly rather than claiming a check I could not run.
8. **Private scratch subdirectory**: everything mechanical happened under
   `…/scratchpad/wo0045-private/` (mode 0700), created for this work order.
   Nothing was written anywhere in the repository except this directory
   (`docs/reports/audit/WO-0045-mutations/`) and my journal append.
9. **Out-of-bounds paths were excluded from the tree copy by `tar --exclude`**,
   not by relying on a build failing first — see §1.2 and §4 check 0.
10. **No unscoped `git log`**; no git subcommand aimed outside the allowlist —
    §1.2's last bullet.

---

## 2. What is delivered

Five diffs, one per intent, each a single-file unified diff against
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `bc565a6`:

| id | intent, in one line | file / function | hunks | non-comment code lines changed |
|---|---|---|---|---|
| E-c1 | FCS removal applied on the REQ-105 abort path | `xgmii_rx_64.ml`, `create` — the `strip` binding | 1 | 1 removed, 3 added (one rewrapped `let`) |
| E-c2 | an output word emitted for a frame that must produce none | `xgmii_rx_64.ml`, `create` — the `emit_last_a` binding | 1 | 1 removed, 3 added (one rewrapped `let`) |
| E-c3 | the abort strobe pulsed on the `/E/`'s own cycle | `xgmii_rx_64.ml`, `create` — the `q2` binding and the `error_bad_frame` output field | 2 | 8 removed, 6 added |
| E-c4 | the `/E/` handler not gated on frame-open | `xgmii_rx_64.ml`, `create` — the `a_close_error` binding | 1 | 1 removed, 1 added |
| E-c5 | the abort detected, and never reported | `xgmii_rx_64.ml`, `create` — the `error_bad_frame` output field | 1 | 1 removed, 1 added |

No `.mli`, no dune file, no test file and no other module is touched by any of
them; §4 check 2 is the mechanical statement of that.

---

## 3. The five mutations

Each subsection states the intent **as I understood it**, the mechanism, a
fidelity argument, what the diff deliberately leaves alone, and the diff in
full as generated from the artifact.

### 3.1 E-c1 — FCS removal applied on the abort path

**Intent as understood.** A frame closed by an `/E/` under REQ-105 must deliver
every octet decoded up to its abort point — REQ-103's third sentence says no FCS
removal is attempted on such a frame, and SPEC-M03 §9 row 2 says "no FCS
removed", so the four octets immediately preceding the error character **are**
delivered. The mutant strips four octets from the end of what an
`/E/`-closed frame delivers, as though the abort path had an FCS. Frames closed
by their terminate character, runts and oversize truncations keep their present
behaviour.

**Mechanism.** `strip` is the module's single FCS-removal control: it is 4 on
the cycles a frame's `tlast` word is decided when that frame was closed by a
terminate character or by REQ-108's truncation, and 0 otherwise, and everything
downstream — `keep_count`, `emit_last_a`'s `pc >: strip` guard, `emit_last_b`'s
straddle test and `fcs_tail_pending` — reads it. The mutation adds `sel_error`
to the disjunction that raises it, so a REQ-105 closure now raises it too. That
is one added token in one expression, and it recruits the *whole* existing
FCS-removal mechanism onto the abort path rather than subtracting four octets
by hand somewhere: the straddling case moves the `tlast` back a word and drops
the residual all-FCS word exactly as it does for a terminate-closed frame,
which is what "as though the abort path had an FCS to strip" means.

**Fidelity.** `sel_error` is the record bit set by `a_close_error`, i.e. exactly
REQ-105's closure class — an `/E/` in an open frame, or (per REQ-102's third
sentence and §6.2's `Preamble` row) any other control character standing in one
of that frame's preamble positions. The three closure bits are mutually
exclusive, because `a_close_oh` is one-hot and one lane carries one character,
so adding `sel_error` cannot perturb a terminate or oversize disposition: for
those, `sel_terminate` or `sel_oversize` already made the mux select 4. Runts
close with a terminate character (`a_close_runt = a_close_terminate &: …`), so
they are in the unaffected set by construction. REQ-110 aborts keep `strip` = 0,
which is right — the intent names the `/E/` path only.

**Deliberately left alone.** The strobes, `tuser`, the FSM, the CRC sequencing
and the REQ-108 truncation arithmetic. The base file's comment at the
`fcs_tail_pending` block ("Frames ended by REQ-105, REQ-110 or `clear` never set
it, because `strip` is 0 for them") is now false of the mutant; I left the
comment standing rather than edit it, because editing it would be a second,
non-minimal change and because the contradiction is the defect in prose. See
§5.2 for the one consequential behaviour this recruits.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..afefecb886a460c128d00eef8c1a7cad6c29d602 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -693,7 +693,12 @@
      begins a new frame tells the word before it nothing except that it was the
      last of its own. *)
   let nc = mux2 al_new (zero 4) (popcount al_keep) in
-  let strip = mux2 (sel_valid &: (sel_terminate |: sel_oversize)) (of_int ~width:4 4) (zero 4) in
+  (* E-c1 MUTATION (WO-0045) — FCS removal applied on the REQ-105 abort path:
+     a frame closed by an `/E/` has four octets removed from the end of what it
+     delivers, as though the abort path had an FCS to strip. *)
+  let strip =
+    mux2 (sel_valid &: (sel_terminate |: sel_oversize |: sel_error)) (of_int ~width:4 4) (zero 4)
+  in
   (* ---- the all-FCS tail word (REQ-103, REQ-015; BUG-0001) ----
      [emit_last_a] is the case where the FCS lies wholly inside the emitted
      word, and its [pc >: strip] guard is what stops a word made *only* of FCS
```

### 3.2 E-c2 — an output word emitted for a frame that must produce none

**Intent as understood.** An `/E/` arriving at or before a frame's first octet
leaves that frame with zero delivered octets; §9 row 3, REQ-105's own
zero-delivered clause and requirements.md §0.7 all say the frame produces **no
output word at all**, there being no `tlast` to mark and no legal encoding for a
zero-octet word (REQ-011 forbids `tkeep` = 0 with `tvalid` = 1). The mutant
emits one anyway, on the cycle the frame's strobe is due, "to have somewhere to
put the abort bit". Frames that legitimately deliver octets are unaffected.

**Mechanism.** The gate that produces the correct behaviour is twofold —
`have_word` requires `pc <> 0`, and `emit_last_a` additionally requires
`pc >: strip` — so no single existing conjunct can be weakened without also
moving the §9-row-6 runt case, which belongs to a different intent. The
mutation therefore adds one disjunct to `emit_last_a`:
`sel_valid &: sel_error &: sel_is_r2`. `sel_is_r2` is the module's own name for
"this closure record has reached age 2", which §9 pins as the report cycle of a
frame that emits no word, so the disjunct fires **exactly on that frame's
already-pinned strobe cycle** and nowhere else. With `pc` = 0 and `strip` = 0
the forced word carries `tkeep` = `keep_of_count 0` = `0x00`, `tlast` = 1,
`tuser`[0] = 1 (`abort` contains `sel_error`) and whatever `al_data_d` is
holding — the "word with `tkeep` = 0, or a word of preamble octets" the intent
names, in one expression.

**Fidelity.** The disjunct cannot fire for a frame that delivers octets. A
record reaches `r2` only if no `tlast` was emitted for it at ages 0 and 1; if
its `tlast` falls at age 2 — which §6.1's derivation makes reachable — then
`pc <> 0` on that cycle and `emit_last_a`'s original conjunction is already
true, so the added disjunct changes nothing. It cannot fire for a frame closed
any other way, because `sel_error` is the REQ-105 bit alone. And it cannot move
the strobe: `consume = sel_valid &: (emit_tlast |: sel_is_r2)` already had
`sel_is_r2` high on that cycle, so consumption, and therefore the strobe's
cycle, is bit-for-bit unchanged. The mutant adds a word and changes nothing
else, which is what the intent asks.

**The one thing I could not do faithfully, said plainly.** The intent's class
has two structurally different halves, and this diff reaches one of them. A
frame **opened and closed inside one input word** — an `/E/` in a lane above the
`/S/`, which at a lane-0 start is where every preamble position lies — is
reported through the `q2` path, which is three bits through two registers and
has **no payload datapath at all**: nothing about it decides to emit a word,
because it never had octets, coverage, alignment or a `tkeep`. Making that half
emit a word means constructing an output-word path that does not exist, which is
neither minimal nor "the natural implementation". This diff therefore covers
the **epoch-A** instances of the class: an `/E/` in a preamble position of the
word *after* a lane-4 start (lanes 0–3), and an `/E/` standing at the frame's
own first-octet position at **both** start lanes. Those are real, commissioned
members of §9 row 3 (§10's REQ-105 hook drives "`/E/` in a preamble lane" and
REQ-102's column commissions it at both start lanes), so the defect class is
genuinely seeded; the in-word half is not. §6 carries this as an open question.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..d01674a40b9d624b208ea0100c7c20019c802113 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -725,7 +725,13 @@
   let fcs_tail_pending = wire 1 in
   let fcs_tail_now = reg spec fcs_tail_pending in
   let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
-  let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
+  (* E-c2 MUTATION (WO-0045) — an output word emitted for a frame that must
+     produce none: an `/E/`-closed frame whose record reaches its no-output-word
+     report cycle forces a `tlast` word out, "to have somewhere to put the abort
+     bit".  With [pc] = 0 and [strip] = 0 that word carries [tkeep] = 0. *)
+  let emit_last_a =
+    (have_word &: (nc ==:. 0) &: (pc >: strip)) |: (sel_valid &: sel_error &: sel_is_r2)
+  in
   let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
   fcs_tail_pending <== emit_last_b;
   let emit_full = have_word &: (nc >: strip) in
```

### 3.3 E-c3 — the abort strobe pulsed on the wrong cycle

**Intent as understood.** §9 pins each strobe to the cycle M03 emits that
frame's `tlast` word, and — for a frame that produces no output word — to two
cycles after the input word carrying the character that ended the frame. Both
pins move to the `/E/`'s own cycle. The verdict, the delivered extent and the
marking are unchanged; only the strobe's cycle moves, and no other strobe moves.

**Mechanism.** `error_bad_frame` has two contributing paths and the mutation
moves both, because the intent is a statement about the strobe and not about one
of its sources. Epoch A's path, `strobe sel_error` (= `consume &: sel_error`),
is replaced by `a_close_error`, which is the same closure decision read
combinationally on the cycle the character arrives — one cycle before the
record's earliest possible consumption and one or two before its pinned report.
The in-word path, `q_strobe 0` (= `bit q2 0`), is replaced by `bit inword_now 0`,
`inword_now` being a new name for the expression `q2` already registered twice;
`q2`'s own definition is unchanged, so the naming is a refactor and the
un-delaying is the defect. The `~:(i.clear)` gate is preserved on the whole
expression, so REQ-009's "all five strobes 0 while `clear`" still holds.

**Fidelity.** Each REQ-105 closure raises `a_close_error` for exactly one cycle
and produces exactly one record consumption, so the pulse **count** is
unchanged and only the cycle moves; the same holds for the in-word path, where
`inword_now` bit 0 is high for exactly the cycle `q2` bit 0 would have been high
two cycles later. The move is never zero cycles: the epoch-A pin is the closure
word + 1 or + 2 and the in-word pin is the closure word + 2, while the mutant
fires on the closure word itself. Nothing in the datapath is touched — `strip`,
`keep_count`, `emit_*`, `abort`, `tuser`, `consume` and the FSM are byte-for-byte
as they were — so the delivered extent and the marking stand, and `error_runt`,
`error_start_without_terminate`, `error_bad_fcs` and `error_oversize` keep both
of their own paths untouched.

**Two hunks, and why that is still minimal.** The second hunk is the defect. The
first exists only because the un-delayed value had no name: OCaml cannot
reference a subexpression of a `let` it is not part of. The first hunk adds a
binding and rewrites `q2` in terms of it, and `git apply` of hunk 1 alone would
leave the module behaviourally identical to the base.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..df865207e2a490622e84f2988d537ac87e466e9e 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -580,14 +580,14 @@
        `error_bad_fcs` out of this vector entirely (above). *)
     concat_lsb [ error; terminate; start ]
   in
-  let q2 =
-    reg
-      spec
-      (reg
-         spec
-         (inword_strobes ~exists:b_exists ~closing:b_closing
-          |: inword_strobes ~exists:c_exists ~closing:c_closing))
+  (* E-c3 MUTATION (WO-0045) — the abort strobe pulsed on the wrong cycle: the
+     in-word report vector is named here so the un-delayed value is available to
+     `error_bad_frame` below.  [q2] itself is unchanged. *)
+  let inword_now =
+    inword_strobes ~exists:b_exists ~closing:b_closing
+    |: inword_strobes ~exists:c_exists ~closing:c_closing
   in
+  let q2 = reg spec (reg spec inword_now) in
   (* ---- the state machine (§6.2) ----
      One [Always] switch, and every transition is a function of the closure
      signals decided above, so the table below reads against §6.2 row for row.
@@ -759,7 +759,9 @@
       ; tuser = emit_tlast &: abort
       }
   ; error_bad_fcs = strobe sel_bad_fcs
-  ; error_bad_frame = strobe sel_error |: q_strobe 0
+    (* E-c3 MUTATION (WO-0045) — `error_bad_frame` fires on the cycle carrying
+       the `/E/` itself rather than on §9's pin, on both report paths. *)
+  ; error_bad_frame = (a_close_error |: bit inword_now 0) &: ~:(i.clear)
   ; error_runt = strobe sel_runt |: q_strobe 1
   ; error_oversize = strobe sel_oversize
   ; error_start_without_terminate = strobe sel_start |: q_strobe 2
```

### 3.4 E-c4 — the `/E/` handler not gated on frame-open

**Intent as understood.** §9's closure list makes every condition in §9's table
evaluable **only while the frame is open**, and §9 row 4 spells out the
consequence: an `/E/` arriving when no frame is open — in the inter-frame gap,
after a terminate character, or after REQ-108's truncation — emits nothing and
pulses nothing. §0.6's conservation equation depends on it, because a strobe
after closure is attributable to a frame already counted. The mutant reports
such a character as though it had aborted something. Frames genuinely aborted
mid-flight are unaffected.

**Mechanism.** The frame-open test lives in one conjunct. `a_closes_with v =
a_char_acts &: any (v &: a_close_oh)` and `a_char_acts = a_open &:
~:a_close_oversize`, with `a_open = in_preamble |: in_frame`. The mutation
inlines `a_closes_with` for this one closure and **drops `a_open`**, keeping
everything else including the REQ-108 truncation-wins conjunct. The resulting
expression is character-for-character the original minus the frame-open test.

**Fidelity, and what follows from it.** In `Preamble` and `Frame` the mutant is
*identical* to the base, because `a_open` is 1 there — so a genuine mid-flight
abort keeps its extent, its marking and its strobe cycle exactly. In `Idle` and
`Discard` an `/E/` that is the lowest of the word's `/S/`, `/T/`, `/E/`
characters now raises `a_close_error`, hence `a_close_char`, hence
`a_close_now`, hence a closure record whose **only** set condition bit is
`error`: `terminate`, `start`, `oversize`, `fcs` and `runt` all still require
`a_char_acts` and stay 0. That record ages and is consumed, so
`error_bad_frame` pulses once, two cycles after the character — §9's own pin for
a frame that emits no word, which is exactly the "reported as though it had
aborted something" the intent describes, rather than a bare pulse bolted onto an
output. The FSM does not move: neither the `Idle` nor the `Discard` arm of the
`Always` switch reads `a_close_char`, so REQ-108's resynchronisation and
REQ-113's ignore-outside-a-frame transitions are untouched.

**Deliberately left alone.** (a) `~:a_close_oversize` is **kept**. Dropping it
would let a truncation cycle raise the abort too, which is a second defect
against REQ-108 and C-12; the packet's standing clause says preserve the spec
rule and disclose, so it is preserved. (b) REQ-113's idle and ordered-set
characters still pulse nothing outside a frame, because `a_closing_v` contains
`other_ctl` only under `a_pre_mask`, which requires `in_preamble` — an `/I/` or
`/Q/` in the gap is not in the vector at all, so `a_close_oh` never marks it.
That is deliberate: the intent names an `/E/`, not any control character. (c) No
legitimate report can be lost to the spurious record: a valid `r2` always
satisfies `consume`, so no record is ever overwritten unconsumed, and records
are selected oldest-first, so a draining frame's own record is still selected
before any record born after it.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..a1236bd56c684564ed6fd790c7092b7582717192 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -369,8 +369,11 @@
      epoch A's preamble positions — `/I/` and `/Q/` included (§6.2's [Preamble]
      row as revised at 541ea43). Outside a preamble position the same character
      is the hold above and closes nothing. *)
+  (* E-c4 MUTATION (WO-0045) — the `/E/` handler not gated on frame-open: the
+     [a_open] conjunct of [a_char_acts] is dropped from this closure only, so an
+     `/E/` arriving with no frame open raises a closure record and is reported. *)
   let a_close_error =
-    a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
+    ~:a_close_oversize &: any ((lanes.is_error |: (other_ctl &: a_pre_mask)) &: a_close_oh)
   in
   let a_close_start = a_closes_with lanes.is_start in
   let a_close_char = a_close_terminate |: a_close_error |: a_close_start in
```

### 3.5 E-c5 — the abort detected, and never reported

**Intent as understood.** M03 closes the frame on the `/E/`, truncates to the
correct extent, and marks `tuser`[0] correctly on the `tlast` word where one
exists — but `error_bad_frame` never pulses, for any frame. REQ-008 forbids
silent discard and §9 requires the report, so this is a conformance defect in
the reporting path alone. Every other strobe is untouched.

**Mechanism.** The output field is driven to `gnd`. Both contributing paths —
epoch A's `strobe sel_error` and the in-word `q_strobe 0` — disappear with it,
which is what "for any frame" requires.

**Fidelity.** `sel_error` remains live in `abort`, so `tuser`[0] is still set on
the `tlast` word of every `/E/`-aborted frame that has one; `a_close_error`
remains live in `a_close_char`, so the frame is still closed at the right octet
and the FSM still returns to `Idle`; `strip` is still 0 for the abort path, so
the delivered extent is right; and `consume` does not read the strobe, so no
other record's timing moves. `strobe` and `q_strobe` are both still used by the
other four outputs, and `q2` is still used by `q_strobe`, so nothing becomes an
unused binding (§4 check 5).

**On its quietness.** The packet warns not to strengthen this one, and I have
not: it is deliberately the smallest possible edit, one identifier, and it
agrees with everything the bench could assert about extent, marking, ordering
and the other four strobes. If it survives, what survived is a reporting-path
assertion that nothing makes.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..a8d301f13d3634f8ad2d08333d8a86f244db8fe6 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -759,7 +759,10 @@
       ; tuser = emit_tlast &: abort
       }
   ; error_bad_fcs = strobe sel_bad_fcs
-  ; error_bad_frame = strobe sel_error |: q_strobe 0
+    (* E-c5 MUTATION (WO-0045) — the abort detected, and never reported:
+       the frame is closed, truncated and marked correctly, but
+       `error_bad_frame` never pulses. *)
+  ; error_bad_frame = gnd
   ; error_runt = strobe sel_runt |: q_strobe 1
   ; error_oversize = strobe sel_oversize
   ; error_start_without_terminate = strobe sel_start |: q_strobe 2
```

---

## 4. Self-check — what I ran, and its results

Everything below ran inside the private scratch subdirectory (bar 8) against a
`git archive bc565a6` extraction that excludes every out-of-bounds tree (bar 9).
No check builds or runs the design's bench, and none involves `test/`.

**Check 0 — the tree copy really excludes the out-of-bounds paths.** The copy
was taken with `git archive bc565a6 | tar -x --exclude=… `, and a probe loop
over `test agents docs tools rtl_snapshots` printed `absent:` for all five; the
copy was then rebuilt a second time, restricted further to `libs/` plus
root-level files, after the first listing showed `.claude .github bin scripts
site tasks` present (§1.2's incidental exposure). Final retained content:
`libs/`, `.gitignore`, `.ocamlformat`, `ORG_CHART.md`, `README.md`,
`agentic_fpga.opam`, `dune-project` — of which only `libs/**` was ever opened.

**Check 1 — generation is anchor-asserted.** Each mutation is a list of exact
literal replacements applied to the `bc565a6` text; the generator exits non-zero
unless every anchor occurs **exactly once**. All five generated on the first
pass: `E-c1` … `E-c5`, base blob `81cd9ed7fc64` for all five, 1 edit each except
`E-c3` (2).

**Check 2 — `git apply --check` from a pristine `bc565a6` copy, and single
file.** All five report `Checking patch
libs/hardcaml_ethernet/src/xgmii_rx_64.ml...` and nothing else. For each, the
patch was then actually applied to a fresh pristine copy and the result compared
byte-for-byte against the generated file: identical in all five cases. Each diff
contains exactly **one** `diff --git` header, naming that one path, and one
`index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..<post> 100644` line pinning the
base blob. The base blob was re-derived independently with
`git rev-parse bc565a6:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` →
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`.

**Check 3 — minimality.** Hunks and line counts, comment lines separated from
code lines: E-c1 1 hunk, −1/+6 (3 of the added lines are the marker comment);
E-c2 1 hunk, −1/+7 (4 comment); E-c3 2 hunks, −8/+10 (4 comment); E-c4 1 hunk,
−1/+4 (3 comment); E-c5 1 hunk, −1/+4 (3 comment). Every non-comment addition
is reproduced in §3's diffs, and in E-c4 and E-c5 the entire code delta is a
single line replaced by a single line.

**Check 4 — parse check with negative controls.** `ocamlc -stop-after parsing
-c` (OCaml 4.14.1) accepts the pristine file and all five mutants. To show the
check has teeth, four deliberately broken variants were fed to the same command:
a dropped closing paren in E-c2's added disjunct, a dropped `in` in E-c1's
rewrapped `let`, a stray `;;` in E-c5's output field, and a dropped paren in
E-c3's rewritten `q2`. All four were **rejected** (`Syntax error: ')' expected`
×2, `Syntax error` ×2). A parse check that accepts everything is not a check;
this one does not.

**Check 5 — orphaned bindings.** Over the comment-stripped text, all 135
`let`-bindings of the base file were counted in each mutant. E-c1, E-c2, E-c4
and E-c5: no binding added, none removed, **none became unused**, and no binding
is unused at all. E-c3: one binding added (`inword_now`), none removed, none
became unused. In particular `strobe`, `q_strobe`, `q2` and `sel_error` all
remain referenced in E-c3 and E-c5, which is where an unused-variable warning
would have been the likely failure.

**Check 6 — identifier census and scope order.** Every identifier token in every
added code line was extracted and classified. All of them either are `let`-bound
in the base file, or are library/record names already used by the base file
(`mux2`, `of_int`, `zero`, `bit`, `reg`, `any`, `gnd`, `~width`, `i.clear`,
`error_bad_frame`, `is_error`, `~exists`, `~closing` — occurrence counts in the
base file 2 … 39), or are `inword_now`, introduced by E-c3's own first hunk.
Scope order was then checked binding-line against use-line for every referenced
identifier: `sel_valid` 528, `sel_terminate` 529, `sel_error` 530,
`sel_oversize` 532 all before E-c1's site at 696; `sel_is_r2` 522, `pc` 691,
`strip` 696, `nc` 695, `have_word` 727 all before E-c2's site at 728;
`inword_strobes` 570, `b_exists` 421, `b_closing` 423, `c_exists` 422,
`c_closing` 424, `spec` 232 before E-c3's first site at 583, and
`a_close_error` 372 and `inword_now` (~583) before its second at 762;
`a_close_oh` 315, `a_pre_mask` 308, `a_close_oversize` 361, `other_ctl` 243,
`lanes` 234 all before E-c4's site at 372. No forward reference and no shadowing.

**Check 7 — width discipline and whitespace.** Maximum line length: base 97,
every mutant 97 (unchanged — the widest added line is E-c1's 97-character `mux2`
line, which is exactly the width of the base line it replaces plus the added
disjunct, rewrapped). Added lines carry no trailing whitespace, no tab and no
CR; the mutants have zero trailing-whitespace lines, as does the base.

**Check 8 — the greppable marker.** Every hunk of every diff carries its own
`E-cN MUTATION (WO-0045)` marker: E-c3 has two hunks and two markers, the other
four have one each.

**Check 9 — what could NOT be checked, stated as a result rather than omitted.**
See §5.1.

---

## 5. Disclosures

### 5.1 Compile-confidence: HIGH on syntax and scope, ASSERTED on types

**No mutant has been type-checked, and I could not type-check one.** The
environment's opam switch (`fpga`, `ocaml-system.4.14.1`) has **no Hardcaml
packages installed**: `dune build libs/` in the scratch tree fails at
`Library "ppx_hardcaml" not found` and `Library "hardcaml_axi" not found`, before
reaching a single line of `xgmii_rx_64.ml`. That failure is a property of this
environment, not of the diffs, and it is the same class of fact ADR-0005 is
about — a local build is not evidence here, and in this case not even
obtainable. What the confidence rests on instead:

- **Syntax: verified.** Check 4, with negative controls.
- **Scope: verified.** Check 6 — every identifier bound before use, no
  shadowing, one new binding whose name occurs nowhere else in the file.
- **Unused-binding warnings: verified absent.** Check 5.
- **Types and widths: argued, not machine-checked.** Every mutation composes
  1-bit signals with 1-bit operators and feeds a site that already took a 1-bit
  signal. E-c1 adds `sel_error` (`bit sel 2`, 1 bit) to a `|:` chain of 1-bit
  record bits feeding `mux2`'s selector; both `mux2` branches are the base's own
  4-bit constants. E-c2 `|:`-joins two 1-bit conjunctions and rebinds a signal
  that was already 1 bit. E-c3 drives a 1-bit output field from
  `(a_close_error |: bit inword_now 0) &: ~:(i.clear)`, where `a_close_error` is
  1 bit and `bit _ 0` is 1 bit by construction, and `inword_now` is the
  3-bit `concat_lsb [error; terminate; start]` the base already indexed with
  `bit q2 0`. E-c4 replaces a 1-bit `&:` chain by a 1-bit `&:` chain over the
  same operands. E-c5 drives that output field from `gnd`, which the base file
  already uses in two places. **The residual risk is a Hardcaml width or
  labelled-argument error I cannot see without the library**, and I rate it low
  for E-c1/E-c2/E-c4/E-c5 (no new call to any library function) and low but
  nonzero for E-c3 (a `let` restructured around an existing `reg spec (reg spec
  …)` composition).
- **Formatting: unverified.** `ocamlformat` is not installed, and `.ocamlformat`
  is **outside this campaign's allowlist**, so unlike WO-0042 I did not read the
  margin and cannot state it. I matched the base file's observed style and kept
  every added line at or under the base's own maximum width of 97. If the
  campaign's Build state includes a `dune build @fmt` check, a formatting-only
  failure is possible; it would fall squarely in packet §7's compile-only repair
  class, and I ask that it be returned to me as such rather than treated as a
  defect in the intent. §6 carries this as an open question.

### 5.2 E-c1 recruits the whole FCS-removal mechanism, including its word-drop

Because `strip` is read by `emit_last_a`'s `pc >: strip` guard and by
`emit_last_b`/`fcs_tail_pending`, an `/E/`-closed frame under E-c1 behaves like
a terminate-closed one in two further respects, and both are consequences of the
single injected defect rather than additions to it. (a) Where the abort leaves a
final aligned word of four or fewer octets with nothing behind it, that word is
suppressed entirely — the frame's `tlast` disappears with it — exactly as §9's
sixth row suppresses a sub-5-octet frame's word. The frame's `error_bad_frame`
still reports, because the record then ages to `r2` and `consume` fires there.
(b) Where the four notional FCS octets straddle two aligned words, `emit_last_b`
moves the `tlast` back a word and `fcs_tail_pending` drops the residual. I
consider both faithful to "as though the abort path had an FCS to strip"; a
reader who disagrees should read them as the diff's cost and say so, and I will
not revise the diff to avoid them (bar 7).

### 5.3 E-c4's spurious record is a record, not a bare pulse

I chose to inject the defect at the closure decision rather than at the output
field. A bare `|: (any lanes.is_error &: ~:a_open)` on `error_bad_frame` would
also pulse, but it would pulse on the character's own cycle, importing E-c3's
defect into E-c4 and making two mutations partly indistinguishable. Injecting at
`a_close_error` keeps the report on §9's own no-output-word pin, which is what
"reported as though it had aborted something" means. The consequence worth
naming: the spurious record occupies the shared closure channel for two cycles.
Check 5's reasoning shows it can neither displace nor delete a legitimate
record; the one interaction I cannot rule out by inspection alone is a spurious
record being consumed on a cycle when some other frame's `tlast` is emitted,
which would put `tuser`[0] on that word. I could not construct such a cycle —
records are consumed oldest-first, and the base file's `fcs_tail_now` suppresses
the only residual word a closed frame can still produce — but I state it as a
gap in my own argument rather than as a proof.

### 5.4 One intent is only partly achievable, and it is E-c2

Stated in full in §3.2 and repeated here so that a reader of this section alone
sees it: E-c2 seeds the defect for the **epoch-A** members of §9 row 3's class
and not for the members opened and closed inside a single input word, which have
no payload datapath to mutate. Everything else in §2 was achievable minimally
and faithfully.

---

## 6. Open questions

1. **E-c2's uncovered half.** Does dv_lead want a sixth diff attacking the
   in-word (`q2`) half of §9 row 3 — necessarily a larger diff, since it must
   construct an output-word path that does not exist — or is the epoch-A half
   the intended target? I did not substitute a different defect to cover it
   (§2's instruction), and I did not widen E-c2 to reach it.
2. **Is `dune build @fmt` inside the campaign's "Build state"?** If it is, and a
   mutant fails it, I ask that the failure be returned to me as packet §7's
   compile-only repair rather than adjudicated as a defect. I could not
   pre-empt it: `ocamlformat` is absent from this environment and `.ocamlformat`
   is outside the allowlist.
3. **The allowlist and the toolchain.** The campaign's read rule is about
   repository content, and I have read it that way — but a build needs
   `dune-project` and `libs/**/dune` as *inputs to a tool*, and last campaign I
   read the latter two as files. This round I did not, and the only cost was
   that I learned the missing-library names from the build's own error text
   instead. If a future campaign wants build-configuration files inside the
   allowlist, saying so explicitly would remove the ambiguity; I have resolved
   it conservatively here.
4. **Nothing about family E is asked here.** I have not seen the bench, the
   sealed predictions or the attack plan, and I make no claim about which unit
   should redden for any of the five. That is the campaign's design and I have
   kept to it.
