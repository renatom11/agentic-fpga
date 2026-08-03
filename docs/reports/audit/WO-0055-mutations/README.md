# WO-0055 — five seeded family-G mutations of M03, authored blind

- **Author**: auditor (`J-auditor-0009`)
- **Packet**: `agents/handoffs/WO-0055_family-g-mutation-campaign.md` (dv_lead →
  auditor, via orchestrator), committed at `b94aa1e`
- **Base SHA**: **`2e8994f`** — the SHA the packet names and the SHA the green
  control run executed
- **File mutated**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03), the only
  file any of the five diffs touches
- **Base blob**: `git rev-parse 2e8994f:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
  → `81cd9ed7fc64e6265c53117f251ef948f24e3b00`; `sha256sum` of the extraction →
  `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, **772
  lines**. This is byte-identical to the blob the family-E and family-F
  campaigns mutated at `bc565a6` and `616686f`; the design has not moved across
  six campaigns.
- **Never merge.** Every diff carries the greppable marker `MUTATION` in a
  comment at its own site, exactly once per diff (packet §4).

> **This report contains no prediction about which bench unit reddens, which
> stays green, or what any failure message says.** I have not read the bench,
> I do not know its row set beyond the five class names the packet publishes,
> and nothing below is a claim about it. Every behavioural sentence here is a
> statement about **M03 under the mutation**, argued from
> `docs/specs/modules/xgmii_rx_64.md` and `docs/specs/requirements.md`, and is
> falsifiable against those two documents and the diff alone.

---

## 1. Scope statement — the allowlist, and what I actually read

### 1.1 The six readable path sets (packet §1)

| | readable | what I opened |
|---|---|---|
| 1 | this packet | `agents/handoffs/WO-0055_family-g-mutation-campaign.md`, in full |
| 2 | `docs/specs/**` | `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2 (all four rows), §6.3, §7, §8, §9 (whole section), §10 (whole table); `docs/specs/requirements.md` §0.3, §0.6, §0.7, and the rows REQ-008, REQ-011, REQ-015, REQ-103, REQ-104, REQ-105, REQ-108, REQ-110 |
| 3 | `docs/adr/**` | **nothing** — deliberately, see §1.5 |
| 4 | `libs/**` | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` in full (772 lines). Extracted with `git archive 2e8994f libs/`, so the whole library tree was materialised; I opened no other file in it |
| 5 | `docs/reports/audit/**` | the heading list of `docs/reports/audit/WO-0050-mutations/README.md`, to keep this report's structure comparable, and `ls docs/reports/audit/` |
| 6 | root-level build configuration | `.ocamlformat` (`profile = janestreet`, `version = 0.26.2`) and `dune-project` (`(lang dune 3.0)`, `(name agentic_fpga)`), both via `git show 2e8994f:<path>`. Item 6 settles the WO-0050 reading, and I exercised it on the same two files |

### 1.2 Out of bounds — the confirmation

**I opened no file under `test/**` at any revision.** Not the bench, not the
attack plan, not the co-simulation lane, not a dune file inside it. I do not
know how many units family G has, what they are called, what they assert, or
what any of them prints on failure.

**I opened no file under `agents/**` other than the packet**, with the two
directed exceptions in §1.3. In particular I did not open, list, hash, diff,
`git show`, `git grep` or otherwise touch
`agents/handoffs/WO-0055_family-g-mutation-campaign-SEALED-predictions.md` **at
any revision**, and I did not open `WO-0054`, any `RV-`, any `SO-`, any other
agent's journal, `tasks/`, `tools/`, `site/`, or `/workspace/`.

**No unscoped `git log` was run**, and no `git` subcommand of mine named a path
outside the allowlist.

### 1.3 The two reads outside §1's allowlist, both directed and both disclosed

My spawn message and my standing launcher instructions directed three reads
inside `agents/**`, which §1 of the packet otherwise bars. I did them, and I
name them rather than smoothing them:

1. `agents/charters/auditor.md` — my charter, the launcher's mandatory first
   action and named in the spawn message. Its §9 lists this programme's
   mutation defect classes in general terms; it names no bench unit.
2. `agents/PROTOCOL.md` — the org protocol, the launcher's second mandatory
   action. §4.1 is the journal grammar this work order's entry must satisfy and
   §6 is the write scope this report must stay inside. It names no bench unit.
3. `agents/journals/claude_auditor_agent.md`, **tail only** (from line 1700 to
   EOF, plus a `grep` for my own entry headers) — named in the spawn message,
   and structurally required: `J-auditor-0009` must be `last + 1` (R5) and a
   pure EOF append (R3), neither of which is checkable without the tail. What I
   read is my own prior campaign's reasoning. It contains no bench information,
   because I had none when I wrote it.

None of the three carries family-G bench content, and none was consulted for
anything but process compliance. **The void call is dv_lead's**, per the
packet's disclosure clause; I state the exposure rather than judge it.

### 1.4 Ambient exposure beyond the enumerated bars (bar-list-is-a-floor)

Two things leaked path names without leaking content, and both are reported as
results rather than smoothed:

- `git ls-tree --name-only 2e8994f` printed the repository's **top-level entry
  names**. I ran it to identify item 6's siblings — "any sibling build config at
  the repository root" cannot be enumerated without listing the root. It printed
  17 names including `test`, `tools`, `site`, `tasks` and `agents`. No content.
- `ls docs/reports/audit/` printed my own tree's entries (item 5, allowlisted),
  which confirmed `WO-0055-mutations/` did not already exist.

Nothing else in this session listed, globbed or searched a barred path. In
particular I ran no repository-wide `grep` and no `find` outside my scratch and
the extracted `libs/` and `docs/specs/` trees.

### 1.5 Prior-spawn exposure

Expected and acknowledged by the packet: I have run five previous M03 mutation
campaigns (WO-0039, WO-0041, WO-0042, WO-0045, WO-0050) and audit cycles before
them, so I have historical exposure to `agents/**` and to `test/**` from those
spawns. I am stateless between spawns; what I carried into this one is what
§1.1 and §1.3 list, and nothing I wrote below was taken from memory of a bench.
I read no ADR this round for the same reason I gave last round: the design file
quotes the ADRs it depends on (ADR-0006, ADR-0007, ADR-0010, ADR-0013, ADR-0014,
ADR-0015) at the sites that depend on them, and none of the five intents turns
on an ADR's text.

### 1.6 The five process bars (packet §1, items 7–11)

| bar | status |
|---|---|
| 7 — author all five before any is run | **Honoured.** All five diffs were authored, generated and verified before anything was built or run. Nothing here has been run at all: I have no build of any mutant and no result from any of them. |
| 8 — no revision after a result; build-only repair disclosed | **No revision was made**, there being no result to revise against. **No build-only repair was made**, because no mutant has been compiled — the toolchain is absent from this container (§5.1). |
| 9 — private scratch subdirectory | **Honoured.** All working files live under my session scratchpad in a `wo0055/` subdirectory of my own making; nothing was written to the repository except the six files §2 lists. |
| 10 — exclude out-of-bounds paths from any tree copy **by construction** | **Honoured.** `git archive 2e8994f libs/` and `git archive 2e8994f docs/specs/` name the allowlisted sets; no barred path was ever materialised, so there was nothing to filter. The scratch tree holds `libs/**`, `docs/specs/**`, a one-file scratch git repository containing only `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, and my own generated artefacts. |
| 11 — no unscoped `git log`; barred paths out of bounds to every git subcommand | **Honoured.** The only git commands I ran were `rev-parse`, `archive`, `show` on two root build-config files, `ls-tree` on the root, and `apply --check` / `apply` / `diff` / `init` / `add` / `commit` / `checkout` **inside my private scratch repository**. No `git log` at all, scoped or unscoped. No `git commit` and no `git push` in `/home/user/agentic-fpga`. |

---

## 2. What is delivered

Six files, all inside `docs/reports/audit/WO-0055-mutations/`:

| file | what it is |
|---|---|
| `g-c1.diff` | G-c1 — truncation at the wrong count |
| `g-c2.diff` | G-c2 — the oversize threshold off by one |
| `g-c3.diff` | G-c3 — `error_bad_fcs` pulsed for a truncated frame |
| `g-c4.diff` | G-c4 — the `Discard` state not gated |
| `g-c5.diff` | G-c5 — an oversize frame truncated correctly and never reported |
| `README.md` | this report |

Each `.diff` is a single-file, single-hunk unified diff against
`2e8994f`, pinned by a full-length `index` line whose pre-image is
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`. Each applies to `2e8994f` on its
own; **the five are not composable and were never intended to be** — one
throwaway branch per diff, per packet §4.

All five intents were seeded **whole**. Nothing was substituted, nothing was
narrowed, and there is no family-G analogue of last round's F-c8. The choices
the packet left to me are in §3.4 (G-c4's character class, which the packet
requires me to state) and §6.

---

## 3. The five mutations

Every subsection quotes the packet's own class line, gives the site at
`2e8994f`, states the design intent, argues fidelity and minimality against the
specification, and states the diff's exact reach. The diffs below are spliced
from the `.diff` files by script and are byte-identical to them.

### 3.1 G-c1 — truncation at the wrong count

> **Packet §2, G-c1, verbatim.** "REQ-108 requires truncation at exactly
> **1514** delivered octets. The mutant truncates at **1518** instead — the
> received-count constant used as the delivered-count constant. The frame is
> still marked, still reported, and still resynchronises; only the delivered
> extent is wrong. Frames of 1518 octets and below are unaffected."

**Site at `2e8994f`**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **line 696**,
the `strip` binding.

**Design intent.** Suppress the four-octet tail removal on the **oversize
closure only**, so that all 1518 received octets are delivered instead of 1514.

**The disclosed choice, and why it is the faithful one.** *This design has no
delivered-count constant to corrupt.* 1514 appears nowhere in the module. The
file's own comment at lines 138–142 says so — "more than 1518 octets received is
oversize; exactly 1514 are then delivered, which this design obtains by capping
coverage at 1518 and letting the four-octet tail removal run" — so 1514 is
**emergent**, `oversize_threshold − 4`. The packet's phrase "the received-count
constant used as the delivered-count constant" therefore names an **observable**
(delivered extent = 1518, the received cap) rather than an edit, and the one
site at which that observable is a single-term edit is `strip`. The rejected
alternative was to raise `oversize_threshold` from 1518 to 1522, so that
1522 − 4 = 1518 delivered: that changes **which** frames are oversize — frames
of 1519 to 1522 octets would stop being detected at all — and the packet's own
sentence "the frame is still marked, still reported, and still resynchronises"
forbids it. It would also collide head-on with G-c2, which is the class that
owns the detection threshold.

**Fidelity and minimality.** One term is deleted from one line: `sel_oversize`
leaves the `strip` selector, so `strip` is 4 on a terminate closure and 0 on an
oversize closure. Detection (`a_close_oversize`), the received cap (`cap_end`),
the closure record, `tuser`[0] (through `abort`, which reads `sel_oversize`
independently), the `error_oversize` strobe, the transition to `Discard` and
REQ-108's resynchronisation are all untouched. The arithmetic is exact and
checkable by hand: 1518 received is 189 aligned words of eight octets and a
final word of six, so the emitted last word takes `keep_count = pc − strip` =
6 − 4 = 2 in the base (1512 + 2 = **1514** delivered, REQ-108) and 6 − 0 = 6
under the mutation (1512 + 6 = **1518** delivered). The word count is 190 in
both cases, so REQ-015's "at most 190 words" is not a second rule broken on the
way, and `tkeep` stays contiguous from bit 0, so REQ-011 is not either. This is
also a *plausible* defect rather than a contrived one: REQ-103's own sentence
says a frame truncated under REQ-108 "delivers every octet decoded up to its
abort point, with no FCS removal attempted", and an implementer who reads that
literally, without REQ-108's "exactly 1514", writes exactly this line.

**Reach.** Frames closed by a terminate character are untouched (`strip` still
4 for them); frames closed by `/E/` or `/S/` had `strip` = 0 already. Only a
frame REQ-108 truncates changes, and it changes in the delivered extent alone.
Frames of 1518 octets and below are unaffected, as the class requires.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..9ba8c88ea4407b4c3488e8650a886f8bbd53e06c 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -693,7 +693,14 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      begins a new frame tells the word before it nothing except that it was the
      last of its own. *)
   let nc = mux2 al_new (zero 4) (popcount al_keep) in
-  let strip = mux2 (sel_valid &: (sel_terminate |: sel_oversize)) (of_int ~width:4 4) (zero 4) in
+  (* MUTATION g-c1 (WO-0055 family G) — NEVER MERGE. Seeded defect: a frame
+     REQ-108 truncates delivers 1518 octets instead of 1514. This design has no
+     delivered-count constant — 1514 is [oversize_threshold] minus the four-octet
+     tail removal — so the received-count cap is made the delivered count by
+     suppressing that removal on the oversize closure alone. The terminate
+     closure still strips four octets; detection, [tuser][0], [error_oversize]
+     and the resynchronisation are untouched. *)
+  let strip = mux2 (sel_valid &: sel_terminate) (of_int ~width:4 4) (zero 4) in
   (* ---- the all-FCS tail word (REQ-103, REQ-015; BUG-0001) ----
      [emit_last_a] is the case where the FCS lies wholly inside the emitted
      word, and its [pc >: strip] guard is what stops a word made *only* of FCS
```

### 3.2 G-c2 — the oversize threshold off by one

> **Packet §2, G-c2, verbatim.** "REQ-108's 'a frame exceeding 1518 octets' is
> implemented as **'1518 or more'**, so a **legal maximum-length frame** is
> truncated, marked `tuser`[0] = 1, and reported with a single `error_oversize`.
> Nothing else about it changes. Frames of 1517 octets and below, and frames of
> 1519 and above, are unaffected."

**Site at `2e8994f`**: **line 362**, inside the `a_close_oversize` binding at
lines 361–363.

**Design intent.** Weaken the comparison that decides whether the truncation or
the closure character owns the cap lane, from strict to non-strict, so that a
closure character standing **exactly at** the cap lane no longer acts and the
truncation takes the frame instead.

**Fidelity and minimality.** One character is inserted: `<:` becomes `<=:` in
the first of three conjuncts. The change in behaviour is exactly computable.
Write `new ∧ ¬old` for the frames the mutation newly truncates:

> `(cap_end ≤ a_char_end) ∧ ¬(cap_end < a_char_end) ∧ (cap_end < a_hold_end) ∧ (cap_end < 8)`
> ⟺ `(cap_end = a_char_end) ∧ (cap_end < a_hold_end) ∧ (cap_end < 8)`

`cap_end` is `cov_first + (1518 − count)` saturated at 8, so `cap_end < 8`
means the cap binds inside this word, and `cap_end = a_char_end` means the
closure character sits at the octet time at which the received count reaches
exactly 1518. That is precisely a frame of **1518 octets DA through FCS** —
requirements.md §0.3's length convention — and no other. The design's own
comment at lines 358–360 states the rule the mutation inverts: "A character *at*
the cap lane still acts, because the count has not passed 1518 at that octet
time." The hold conjunct and the saturation conjunct are unchanged, so a
mid-frame word with `cap_end = a_char_end = 8` (no closure character, cap not
binding) cannot fire: the third conjunct is false there. I verified the boundary
by hand at both start lanes — at a lane-0 start the 1518-octet frame's last word
carries six octets in lanes 0–5 and `/T/` in lane 6 with `count` = 1512, giving
`cap_end` = `a_char_end` = 6; at a lane-4 start the same frame's last word
carries two octets and `/T/` in lane 2 with `count` = 1516, giving
`cap_end` = `a_char_end` = 2. A 1517-octet frame gives 6 vs 5 and 2 vs 1
respectively and does not fire; a 1519-octet frame gives 6 vs 7 and 2 vs 3 and
fires in the base too.

**What the mutated frame looks like, and why "nothing else about it changes" is
literally true.** With `a_close_oversize` set, `a_char_acts` goes low, so
`a_close_terminate` is 0 and the closure record carries `oversize` = 1 with
`terminate` = 0. `strip` is still 4 (it reads `sel_oversize`), and the received
count is still capped at 1518, so the frame **still delivers 1514 octets** — the
same 1514 a legal 1518-octet frame delivers in the base after ordinary FCS
removal. The only differences are that `tuser`[0] becomes 1 (through `abort`),
`error_oversize` pulses once, no FCS check is sequenced, and the state goes to
`Discard` instead of `Idle` — from which the next start character resynchronises
normally (§6.2's `Discard` row). The delivered octet string and its `tkeep`
extent are byte-for-byte what the base emits.

**Reach, disclosed.** The comparison is character-agnostic, so the mutation
reaches **any** closure character at the cap lane, not only `/T/`: a frame that
had received exactly 1518 octets when an `/E/` or an `/S/` arrives is truncated
and reported as oversize instead of aborted. This is one comparison and one
defect, not two, but the class line names only the maximum-length frame and the
wider reach is stated rather than left to be discovered.

**No confound with G-c3.** Because `a_close_terminate` is 0 on the mutated
closure, the record's `fcs` field — `a_close_terminate &: bad_fcs` — is 0, so
`error_bad_fcs` cannot pulse. §9's second co-occurrence ruling is not violated
by this diff.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..9ebaca5ac347ae5836e1613ea49f6099532d2642 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -359,7 +359,15 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      (REQ-108, C-12). A character *at* the cap lane still acts, because the
      count has not passed 1518 at that octet time. *)
   let a_close_oversize =
-    a_open &: (cap_end <: a_char_end) &: (cap_end <: a_hold_end) &: (cap_end <:. 8)
+    (* MUTATION g-c2 (WO-0055 family G) — NEVER MERGE. Seeded defect: REQ-108's
+       "a frame exceeding 1518 octets" is implemented as "1518 or more". The
+       character comparison is weakened from [<:] to [<=:], so a closure
+       character standing exactly at the cap lane no longer acts and the
+       truncation takes the frame instead: a legal maximum-length frame is
+       truncated, marked [tuser][0] = 1 and reported by one [error_oversize].
+       The hold term and the saturation term are unchanged, so no frame whose
+       count stays clear of the cap can reach this. *)
+    a_open &: (cap_end <=: a_char_end) &: (cap_end <: a_hold_end) &: (cap_end <:. 8)
   in
   let a_char_acts = a_open &: ~:a_close_oversize in
   let a_closes_with v = a_char_acts &: any (v &: a_close_oh) in
```

### 3.3 G-c3 — `error_bad_fcs` pulsed for a truncated frame

> **Packet §2, G-c3, verbatim.** "The residue comparison runs at the truncation
> point, where **no FCS is present**, and reports a mismatch: `error_bad_fcs`
> pulses **alongside** `error_oversize` for an oversize frame. §9's **second**
> ruling forbids the pairing — no FCS is removed from a truncated frame
> (REQ-103), so no comparison is made and there is no mismatch to report. The
> truncation, the extent, the marking and `error_oversize` itself are all
> unchanged."

**Site at `2e8994f`**: **line 513**, the `~fcs` field of the closure record `r0`
(lines 506–515).

**Design intent.** Admit the residue comparison at the oversize closure as well
as the terminate closure, so the comparison is *sequenced* for a frame that has
no FCS and its result is reported.

**Fidelity and minimality.** One line replaced by one line: the gate becomes
`(a_close_terminate |: a_close_oversize) &: bad_fcs`. This is the exact
structural inverse of what the design deliberately does. The module's comment at
lines 461–469 explains that the gate "sits **on the residue comparison** rather
than on the strobe that reports it, so that for this class no value derived from
the comparison exists anywhere downstream"; the mutation removes that scoping for
the oversize case and lets the comparison's own verdict through. It reports
`bad_fcs` **as computed** rather than forcing the strobe high, which is the
faithful reading of "the residue comparison runs at the truncation point … and
reports a mismatch": the defect is that a check with no operands is sequenced,
not that a strobe is hard-wired. `bad_fcs` is `has_fcs &: (crc_final <>: residue)`
and `has_fcs` is `count_next >=:. 5`, which at an oversize closure is
1518 ≥ 5 — true — so the comparison is live and its operand is a CRC over the
1518 received octets, which is not the residue for any frame a bench would
construct.

**Reach.** Nothing but the `fcs` bit of an oversize closure record changes.
`tuser`[0] was already 1 for such a frame (`abort` reads `sel_oversize`), so the
marking is unchanged; `strip` does not read the `fcs` bit, so the extent is
unchanged; `error_oversize` is unchanged; the FSM is unchanged. Terminate
closures are untouched, so §9's *ninth* ruling — `error_bad_fcs` SHALL NOT pulse
on a frame of fewer than five octets — still holds under this diff, and the
sub-five class is not disturbed.

**One honest caveat.** The mutation reports what the comparison finds, so a
truncated frame whose first 1518 octets happen to CRC to REQ-304's residue
`0x2144DF1C` would not raise the strobe. That is a 2⁻³² coincidence on an
arbitrary frame and I cannot exclude it without making the diff less faithful
(forcing the bit high rather than admitting the comparison). Stated as a
property of the diff, not as a prediction.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..b97e558388af52e096736a3d664777df4621e00a 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -510,7 +510,15 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
       ~error:a_close_error
       ~start:a_close_start
       ~oversize:a_close_oversize
-      ~fcs:(a_close_terminate &: bad_fcs)
+      (* MUTATION g-c3 (WO-0055 family G) — NEVER MERGE. Seeded defect: the
+         residue comparison is admitted at REQ-108's truncation point, where no
+         FCS is present, so [error_bad_fcs] pulses alongside [error_oversize] —
+         the pairing §9's second co-occurrence ruling forbids. The comparison is
+         reported as it stands rather than forced, which is the defect §9 names:
+         a check is sequenced for a frame that has no operands to give it. The
+         truncation, its extent, its marking and [error_oversize] itself are
+         unchanged. *)
+      ~fcs:((a_close_terminate |: a_close_oversize) &: bad_fcs)
       ~runt:a_close_runt
   in
   (* [consume] is defined by the output decision below; the two are mutually
```

### 3.4 G-c4 — the `Discard` state not gated

> **Packet §2, G-c4, verbatim.** "A **control character arriving after REQ-108's
> truncation point**, while the receiver is discarding the remainder of an
> oversize frame, is acted on as though a frame were still open: it produces a
> report for a frame that is already closed and already counted. §9's closure
> list makes REQ-108's truncation a closure event, and §9's sixth and seventh
> rulings plus **C-12** hold that characters after it belong to **no open
> frame**. The truncation itself, its extent, its marking and its own
> `error_oversize` are unchanged."

**Site at `2e8994f`**: **lines 372–374**, the `a_close_error` binding; the diff
adds one line after line 373.

### THE CHOICE THE PACKET REQUIRES ME TO STATE

**I seeded `/E/`, and only `/E/`.**

The packet's §2 blockquote leaves the character class to me, requires me to
state it plainly because its seal is written as a function of it, and tells me
to choose on **minimality and fidelity grounds**. I did, and the argument is
this:

- **`/T/` was rejected because it confounds this class with G-c3.** A terminate
  character acting in `Discard` sets `a_close_terminate`, and the record's `fcs`
  field is `a_close_terminate &: bad_fcs`, with `bad_fcs` true at a received
  count of 1518. Seeding `/T/` would therefore raise `error_bad_fcs` **as well
  as** `error_bad_frame`-class behaviour, planting G-c3's defect a second time
  in a different diff. My own last round records the same trap and the same
  refusal (`J-auditor-0008`, reasoning item 2). Worse, `/T/` in `Discard` is the
  *ordinary* exit §6.2 specifies, so the mutation would fire on every oversize
  stimulus that ends its frame at all, rather than on the character the class
  describes.
- **The generic "any control character" was rejected for the same reason**: it
  contains the `/T/` case, so it inherits the confound whole.
- **`/S/` is clean but reaches further.** A start character in `Discard` is
  REQ-108's resynchronisation, and making it report would violate §9's
  "`error_oversize` with `error_start_without_terminate`: never on the same
  frame". But `/S/` is also the character that **opens the next frame**, so the
  edit sits one wire away from the admission path (`b_exists`, `c_exists`,
  `begins`, the count and CRC reloads) and its spurious record ages alongside
  the new frame's own reporting path. It is a bigger blast radius for the same
  defect.
- **`/E/` was chosen** because it is the character with **no other job in
  `Discard`**. It opens nothing, it closes nothing, it covers no octet, and the
  specification pins its behaviour in five places at once: §6.2's `Discard` row
  ("An `/E/` arriving here is **absorbed** … no output word appears and no
  strobe pulses"), §9's third table row (`/E/` while no frame is open —
  strobe *(none)*), §9's `error_oversize`-with-`error_bad_frame` ruling ("A
  bench that injects a 1600-octet frame with an error character after the
  truncation point SHALL see exactly one `error_oversize`, no
  `error_bad_frame`"), REQ-105's own row, and REQ-108's own row ("Between the
  truncation point and that start character the receiver SHALL emit no output
  word and SHALL pulse no strobe, whatever characters arrive"). It is the
  narrowest edit that violates exactly one rule.

**Design intent.** Let an error character arriving in `Discard` close a frame
that REQ-108 has already closed, producing one spurious `error_bad_frame`.

**Fidelity and minimality.** One line is added and none removed:
`|: (sm.is State.Discard &: any lanes.is_error)` is disjoined onto
`a_close_error`. `a_open` is **not** touched, which is what keeps the blast
radius to a single strobe:

- `cov_first` is still 8 in `Discard`, so `cov_nonempty` is false, **no octet is
  covered**, the CRC still holds and **no output word is produced**. The
  spurious record carries `valid` = 1 and `error` = 1 and every other field 0,
  so `error_bad_fcs`, `error_runt`, `error_oversize` and
  `error_start_without_terminate` are all unaffected by it.
- `a_close_oversize` cannot fire in `Discard`: `count` holds at 1518, so
  `cap_room` = 0, and with `cov_first` = 8 the saturated `cap_end` is 8, which
  fails the `cap_end <:. 8` conjunct. No second `error_oversize`.
- The **state machine is untouched**. §6.2's `Discard` row is the only row that
  does not read `a_close_char`, so the added disjunct changes no transition; the
  module stays in `Discard`, which is one of the two encodings §6.3 item 6
  declares unobservable and equal. The mutation adds a strobe and nothing else.
- The report lands on §9's own pin for a frame with no `tlast` word — two cycles
  after the input word carrying the character — because `consume` fires on the
  `sel_is_r2` branch with `emit_tlast` low. The defect is a strobe that should
  not exist, not a strobe on the wrong cycle.
- Outside `Discard` the added term is identically 0, so `Idle`, `Preamble` and
  `Frame` behave exactly as the base does. REQ-113's ignored characters (`/I/`,
  `/Q/`) are still ignored: the term tests `lanes.is_error` only.

**Reach, disclosed.** The term fires on **any input word in `Discard` carrying
at least one `/E/`, in any lane**, and produces one report per such word — it is
not restricted to the first. Two consequences worth naming: `/E/` in a word that
*also* carries `/T/` or `/S/` still reports, because the term does not consult
`a_close_oh`; and `/E/` characters in consecutive `Discard` words would generate
records faster than the three-age channel consumes them, so some could be lost.
Neither is a second defect — both are the same one term seen at wider stimulus —
but both are stated rather than left to be found. `/T/` and `/S/` arriving in
`Discard` still pulse nothing under this diff.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..f5ea9d6b10f33be122adcc065c7f11730c573fdb 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -369,8 +369,18 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      epoch A's preamble positions — `/I/` and `/Q/` included (§6.2's [Preamble]
      row as revised at 541ea43). Outside a preamble position the same character
      is the hold above and closes nothing. *)
+  (* MUTATION g-c4 (WO-0055 family G) — NEVER MERGE. Seeded defect: the
+     [Discard] state is not gated. An error character arriving after REQ-108's
+     truncation point is acted on as though a frame were still open, so a frame
+     already closed and already reported by [error_oversize] draws a second
+     report — one [error_bad_frame], on §9's two-cycles-after pin. §6.2's
+     [Discard] row absorbs such a character, §9's third row pulses nothing for
+     it and C-12 is the ruling. SEEDED FOR [/E/] ONLY: [/T/] and [/S/] arriving
+     in [Discard] still pulse nothing, [/I/] and [/Q/] are still ignored
+     (REQ-113), no octet is covered and no output word is produced. *)
   let a_close_error =
     a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
+    |: (sm.is State.Discard &: any lanes.is_error)
   in
   let a_close_start = a_closes_with lanes.is_start in
   let a_close_char = a_close_terminate |: a_close_error |: a_close_start in
```

### 3.5 G-c5 — an oversize frame truncated correctly and never reported

> **Packet §2, G-c5, verbatim.** "The frame is truncated at exactly 1514
> delivered octets, marked `tuser`[0] = 1 on its `tlast` word, and the receiver
> resynchronises correctly — **but `error_oversize` never pulses, for any
> frame.** The condition is detected and acted on; it is simply not reported.
> REQ-008 forbids silent discard and §9 requires the report. Every other strobe
> is untouched."

**Site at `2e8994f`**: **line 764**, the `error_oversize` field of the output
record (lines 753–766).

**Design intent.** Drive the strobe low unconditionally, leaving detection and
every consequence of detection intact.

**Fidelity and minimality.** One line replaced by one line: `strobe
sel_oversize` becomes `gnd`. This is available as a one-term edit precisely
because the module's comment at lines 745–750 records that `error_oversize` has
**epoch A's path only** — "their union is therefore a one-term union and is
written as one" — so there is no second contribution to suppress and no
in-word-epoch path to leave dangling. Everything upstream survives:
`a_close_oversize` still fires, `to_discard` still moves the machine to
`Discard`, the received cap still holds at 1518, `strip` still reads
`sel_oversize` so the frame still delivers exactly 1514, `abort` still reads
`sel_oversize` so `tuser`[0] is still 1 on the `tlast` word, `consume` still
retires the record on its pinned cycle so no later frame's report is displaced,
and the next start character still resynchronises. `sel_oversize` remains bound
and used twice, so no binding is orphaned.

**Reach.** `error_bad_fcs`, `error_bad_frame`, `error_runt` and
`error_start_without_terminate` are untouched — including their in-word-epoch
`q_strobe` halves — and no non-oversize frame's behaviour changes in any
respect. The mutation removes exactly one observable: the strobe REQ-008
requires so that the truncation is not a silent discard, and which §0.6's
frame-conservation equation counts on the right-hand side.

**On the packet's warning, which I have honoured.** The packet says to expect
G-c5 to look quiet and **not** to strengthen it, because it agrees with every
content assertion a correct design satisfies and violates only REQ-008 and §9.
I did not strengthen it. I did not, for instance, also suppress `tuser`[0], and
I did not narrow the suppression to make it easier to trip. `gnd` is the whole
diff.

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..e0a8b1eb2e0a93532139ab319d5e9853551b21fc 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -761,7 +761,13 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   ; error_bad_fcs = strobe sel_bad_fcs
   ; error_bad_frame = strobe sel_error |: q_strobe 0
   ; error_runt = strobe sel_runt |: q_strobe 1
-  ; error_oversize = strobe sel_oversize
+  (* MUTATION g-c5 (WO-0055 family G) — NEVER MERGE. Seeded defect: the
+     oversize condition is detected and acted on in full — truncation at 1514
+     delivered octets, [tuser][0] = 1 on the [tlast] word, the [Discard] state
+     and its resynchronisation — but it is never reported. [error_oversize] is
+     driven low for every frame. REQ-008 forbids the silent discard and §9
+     requires the strobe; every other strobe is untouched. *)
+  ; error_oversize = gnd
   ; error_start_without_terminate = strobe sel_start |: q_strobe 2
   }
 ;;
```

---

## 4. Self-check — what I ran, and what it returned

Everything in this section is reproducible from `2e8994f` and the five `.diff`
files alone.

**Base identity.** `git rev-parse 2e8994f:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
→ `81cd9ed7fc64e6265c53117f251ef948f24e3b00`. `sha256sum` of the
`git archive`-extracted file →
`3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`, 772 lines.

**Anchor uniqueness, with the check given teeth.** The generator asserts that
each mutation's anchor text occurs **exactly once** in the base and aborts
otherwise, and separately asserts that the replacement differs from the anchor.
A silent no-op edit is therefore impossible rather than merely unlikely. All
five reported `anchor unique`.

**Apply check, then real application, then byte comparison.** For each diff, a
**fresh** pristine extraction of `2e8994f` was made and
`git apply --check --verbose` run against it: all five printed
`Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml...` and nothing else.
Each diff was then applied for real to that pristine tree and the result `cmp`-ed
against the generated mutant: **byte-identical in all five cases.**

**Single-file, single-hunk, pinned.** Each diff contains exactly one
`diff --git` header, exactly one `@@` hunk, and one full-length
`index 81cd9ed7fc64e6265c53117f251ef948f24e3b00..<post> 100644` line. Post-image
blobs: `g-c1` `9ba8c88e…`, `g-c2` `9ebaca5a…`, `g-c3` `b97e5583…`,
`g-c4` `f5ea9d6b…`, `g-c5` `e0a8b1eb…`.

**Minimality, measured on comment-stripped text.** Comments were removed with a
nesting-aware stripper and the code lines diffed against the base's 299:

| | code lines removed | code lines added |
|---|---|---|
| g-c1 | 1 | 1 |
| g-c2 | 1 | 1 |
| g-c3 | 1 | 1 |
| g-c4 | **0** | 1 |
| g-c5 | 1 | 1 |

Four of the five are **one line replaced by one line**; g-c4 adds one line and
removes none. The comment-stripped delta of every mutant was printed and
inspected and is exactly the intended edit, with no incidental change anywhere
else in the file.

**Parse check, with negative controls.** `ocamlc -stop-after parsing -c`
(OCaml 4.14.1) accepts the pristine file and all five mutants. Five deliberately
broken variants — a dropped paren in g-c1's `mux2` argument, a dropped paren in
g-c2's comparison, a dropped paren in g-c3's `~fcs` argument, a dropped `in`
after g-c4's binding, and an unterminated comment in g-c5 — were **all
rejected** (`This '(' might be unmatched` ×3, `Syntax error`, `Comment not
terminated`), so the check has teeth rather than merely passing.

**Binding census.** Over comment-stripped text: 135 `let` bindings in the base;
every mutant has the same 135, adds none and removes none. The base's two
apparent orphans (`hierarchical`, exported through the `.mli`, and `tvalid`,
consumed through a qualified record pun) are artefacts of the census regex,
are pre-existing, and are identical in all five mutants. Nothing the diffs
delete leaves a binding unreferenced — the check that matters for g-c1 and
g-c5, which each remove one use of `sel_oversize`, leaving it used twice and
once respectively.

**Width and whitespace.** Every mutant's longest line is 97 columns, which is
the **base's own maximum** (lines 622 and 696, neither of which any diff
lengthens — g-c1 in fact shortens line 696 below it). The longest line any diff
*adds* is 84 columns. Zero trailing-whitespace lines, zero tabs, zero CR, final
newline present, in the base and in all five mutants.

**Marker.** Exactly one `MUTATION` occurrence per mutant, at the mutation's own
site, naming the id, the work order, the family and `NEVER MERGE`.

**Splice check.** The five diffs embedded in §3 were spliced into this file by
script from the `.diff` files and are byte-identical to them.

---

## 5. Disclosures

### 5.1 Compile-confidence: HIGH on syntax and scope, ASSERTED on types and widths

**No mutant has been type-checked and none could be.** This container's opam
switch (`fpga`, `ocaml-system.4.14.1`) has **no Hardcaml packages**, there is no
`dune` binary and no `ocamlformat` binary. This is the fourth campaign running
under that constraint and it is reported as a result, not omitted.

What is machine-checked: syntax (parse, with five negative controls), scope and
binding integrity (census), single-site minimality, whitespace and width. What
is **argued rather than demonstrated**, per mutation:

- **g-c1** — `sel_valid &: sel_terminate` is `1 &: 1 → 1`, the `mux2` selector's
  required width; both branches are the base's own 4-bit constants.
- **g-c2** — `<=:` is used by the base itself at line 729 (`nc <=: strip`) and
  takes two equal-width operands; `cap_end` and `a_char_end` are both 4 bits
  (`mux2` of 4-bit values, and `index_of_onehot`'s `uresize … 4`). Result 1 bit,
  as `<:` gave.
- **g-c3** — `a_close_oversize` is bound at line 361, well before the record at
  line 506, and is 1 bit; `|:` and `&:` on 1-bit operands give 1 bit, which is
  what `record_fields`' `~fcs` label consumed before.
- **g-c4** — `sm.is State.Discard` follows the base's own idiom at lines 260–261
  (`sm.is State.Preamble`, `sm.is State.Frame`) and `State.Discard` is a
  constructor of the `State` module at line 165; `any` is the module-level
  function at line 219 returning `<>:. 0`, one bit. `a_closes_with (…)` is one
  bit, so the `|:` is width-legal, and function application binds tighter than
  `|:`, so no parenthesis is missing.
- **g-c5** — `gnd` is `Signal.gnd`, one bit, in scope through the `let open
  Signal in` at line 232 and used by the base at line 666. The `O.t` field is
  one bit.

If any diff fails to build, **bar 8 applies**: I will change nothing else, will
make the repair `ocamlformat`'s own output where the failure is `@fmt`, and will
disclose the repair.

### 5.2 Formatting is unverified, and the base's own margin is not clean

`.ocamlformat` selects `profile = janestreet` at `version = 0.26.2` with the
janestreet 90-column margin, and **the base file already carries two 97-column
code lines** (622 and 696). I therefore could not establish that
`dune build @fmt` is clean at `2e8994f` in the first place, and I could not run
`ocamlformat` to check my own additions. Every line I add is ≤ 84 columns and
every comment follows the file's existing indentation, but that is care, not
proof. This is the same disclosure as WO-0050 §5.2 and it has not improved.

### 5.3 The choice the packet required, restated in one place

**G-c4 is seeded for `/E/` only** — not `/T/`, not `/S/`, not the generic "any
control character after the truncation point". §3.4 carries the argument: `/T/`
and the generic reading both drag G-c3's defect into this diff through the
record's `fcs` field, and `/S/` is clean but sits on the next frame's admission
path. Restated here because the packet says its seal is written as a function of
this choice.

### 5.4 Two design facts I decided rather than escalated, both reversible

- **G-c1's site.** The module has no 1514 constant, so I made the *observable*
  the 1518-octet delivered extent by suppressing the tail removal on the
  oversize closure. §3.1 gives the argument and names the rejected alternative
  (`oversize_threshold` → 1522), which collides with G-c2. If dv_lead intended
  the other reading, it is a one-line change to make.
- **G-c3's form.** I admitted the comparison rather than forcing the strobe, so
  the diff reports what the residue check *finds* at the truncation point.
  §3.3's caveat is the price: a 2⁻³² frame would not raise it.

### 5.5 Two allowlist judgements I made rather than escalated

- **The root `ls-tree`** (§1.4). Item 6's "any sibling build config at the
  repository root" cannot be enumerated without listing the root, so I listed
  it and disclosed the leak of 17 top-level names. Same judgement as WO-0050,
  where it was disclosed and not flagged.
- **The three directed `agents/**` reads** (§1.3). My spawn message and launcher
  named them, the packet bars the directory, and I resolved the conflict by
  doing the minimum each obligation requires — charter, protocol, and my own
  journal's tail — and disclosing all three. **The void call is dv_lead's.**

---

## 6. Open questions, routed through the orchestrator

1. **Was G-c1's observable the intended one?** The class line names "the
   received-count constant used as the delivered-count constant", and this
   design has no delivered-count constant. I read it as *delivered extent =
   1518* and seeded it at `strip`. If it was meant as a constant substitution
   in `oversize_threshold`, that reading changes which frames are detected and
   contradicts the class line's own "still marked, still reported, and still
   resynchronises" — but it is dv_lead's call, and reversing it is one line.
2. **G-c2's wider reach.** The mutation is character-agnostic at the cap lane,
   so an `/E/` or `/S/` arriving at exactly octet time 1518 is also converted
   into a truncation. One comparison, one defect, wider stimulus surface than
   the class line names. Recorded per packet §3's "an intent that turns out
   wider than its description is a disclosure, not a failure".
3. **G-c4's rejected characters.** `/T/` and the generic reading were rejected
   on confound grounds (§3.4). If dv_lead wants the `/T/` or `/S/` variant as
   well, it is a separate diff and a separate class, not a revision of this one
   — and the `/T/` variant cannot be seeded without also planting G-c3.
4. **Is `dune build @fmt` clean at `2e8994f` at all?** The base carries two
   97-column lines against a 90-column margin. If it is not clean, a `@fmt`
   failure under any mutation is pre-existing rather than mine, and bar 8's
   compile-only repair clause should not be spent on it. Unchanged from
   WO-0050's open question 3, and still open.
5. **Compile-confidence is argued, not demonstrated**, for the fourth campaign
   running, because Hardcaml, `dune` and `ocamlformat` are all absent from this
   container. If any diff fails to build, bar 8 applies and I will disclose the
   repair.
