# WO-0058 — seven seeded M03-G7 + family-H mutations, authored blind

- **Author**: auditor (`J-auditor-0010`)
- **Packet**: `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md`
  (dv_lead → auditor, via orchestrator), read from the working tree at
  `d609b36`
- **Base SHA**: **`a2d090d`** — the SHA the packet names in its header and the
  SHA its §6 mechanics build each throwaway branch from
- **File mutated**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03). **It is
  the only file any of the seven diffs touches.** No diff reaches root build
  configuration, and no class demanded that it should.
- **Base blob**: `git rev-parse a2d090d:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
  → `81cd9ed7fc64e6265c53117f251ef948f24e3b00`; `sha256sum` of the
  `git archive a2d090d libs/` extraction →
  `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`,
  **772 lines**. Byte-identical to the blob the WO-0045, WO-0050 and WO-0055
  campaigns mutated at `bc565a6`, `616686f` and `2e8994f`: the design has not
  moved across seven campaigns, and `git diff a2d090d HEAD -- libs/` is empty,
  so the base design and the working tree's design are the same bytes.
- **Never merge.** Every diff carries a `MUTATION GH-cN … NEVER MERGE` comment
  at its own site. `gh-c2` is a two-site diff and carries the marker at **both**
  sites; the other six carry it once.
- **All seven classes are SEEDED.** Nothing is NOT-SEEDED, nothing was
  substituted, nothing was narrowed to make it build.

> ## This report contains no prediction
>
> **Nothing below is a claim about which bench unit reddens, which stays green,
> or what any failure message says.** I have not read the bench, I do not know
> what any of the five scored units asserts or prints, and the sealed companion
> was not opened. Every behavioural sentence here is a statement about **M03
> under the mutation**, argued from `docs/specs/modules/xgmii_rx_64.md`,
> `docs/specs/requirements.md` and the diff, and is falsifiable against those
> three things alone. Consequences are stated as **mechanism** — what signal
> changes, and what follows from it inside the module — and stop there.

---

## 0. One deviation, disclosed first because it is a deviation from my orders

My spawn prompt names the deliverable as
**`agents/handoffs/WO-0058_manifests.md`**. **I did not write that file, and
this report is at `docs/reports/audit/WO-0058-mutations/README.md` instead.**

The reason is that the named path is outside my write scope, on four
independent statements of it, and one of them is mechanical:

1. **PROTOCOL §6** — the auditor may stage `docs/reports/audit/**` **only**.
2. **PROTOCOL §3, the ADR-0003 auditor exception** — *the auditor stages
   `docs/reports/audit/**` and nothing else, ever — deliberately, so it can
   never modify an artifact it audits, including other agents' packets.*
   `agents/handoffs/` is the directory those packets live in.
3. **My charter §5** — *All inside `docs/reports/audit/**`; you stage nothing
   else, ever.*
4. **WO-0058 §5 itself** — *A report under `docs/reports/audit/**`.*

Mechanically, **R7 would refuse** a commit staging `agents/handoffs/` under the
trailer `Agent: auditor`, so the named deliverable could not have been committed
as mine in any case. And `agents/handoffs/` is precisely the directory holding
this campaign's sealed companion — the one directory whose integrity the
blinding rests on my not touching.

I honoured the rest of the instruction exactly: **one file**, containing all
seven manifest entries with their diffs inline. §7 gives a one-command
extraction to the seven `.diff` files if the orchestrator prefers the WO-0055
form. The write-scope conflict is reported to the orchestrator in my return
message as well as here; it is not mine to resolve by writing outside my scope.

---

## 1. Scope statement — WO-0058 §2's allowlist, and what I actually opened

### 1.1 The six readable path sets

| | readable | what I opened |
|---|---|---|
| 1 | **this packet** | `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md`, in full, from the working tree at `d609b36`. **I did not verify it against `1c3a89d`** — that would have put an `agents/**` path on a git command line, and §2's bar on git subcommands is the stricter reading of the two. I take the packet as given. |
| 2 | **`docs/specs/**`** | `docs/specs/modules/xgmii_rx_64.md` **in full** (1014 lines, both pages); `docs/specs/requirements.md` §0.6, §0.7, the §2 table in full (REQ-101 … REQ-113), the §1 rows REQ-001 … REQ-012, and the section index. Read at `d609b36`, not at `a2d090d` — see §1.4. |
| 3 | **`docs/adr/**`** | **nothing opened**; the directory listing only (`ls docs/adr`), to confirm ADR-0014 and ADR-0016 exist where the packet and PROTOCOL cite them. Every rule I relied on is stated in the two specification documents, which are the normative source; the ADRs restate rationale. |
| 4 | **`libs/**`** | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **in full** (772 lines). Materialised with `git archive a2d090d libs/`, which names the allowlisted set by construction (packet bar 10); **I opened no other file in the extraction**, only `libs/hardcaml_ethernet/src/dune` (three lines, to learn the library's dependencies for the build attempt in §5). |
| 5 | **`docs/reports/audit/**`** | `ls -R docs/reports/audit`; the first 60 lines of `WO-0055-mutations/README.md` (to keep this report's structure comparable); `WO-0055-mutations/g-c4.diff` in full — the packet's §1 names `g-c4` as GH-c1's `/E/` sibling and rules it out of scope, so reading the diff it rules out is what lets me argue GH-c1 is not it; and the tail of my own journal. |
| 6 | **root-level build configuration** | `dune-project` (`(lang dune 3.0)`, `(name agentic_fpga)`) and `.ocamlformat` (`profile = janestreet`, `version = 0.26.2`), both via `git show a2d090d:<path>`. |

### 1.2 Out of bounds — the confirmation, stated affirmatively

**I opened no file under `test/**` at any revision.** Not `test_m03_g.ml`, not
`test_m03_h.ml`, not the rest of the bench, not the attack plan, not the DV
machinery, not the co-simulation lane, not a `dune` file inside it. **I do not
know what M03-G7, M03-H1, M03-H2, M03-H3 or M03-H4 assert, in what order, with
what helpers, or what any of them prints on failure.** Everything I know about
those five units is the one-line description the packet publishes in its own §1
table.

**I opened no file under `agents/**` other than this packet.** In particular I
did not open, list, `ls`, hash, diff, `git show`, `git grep`, tab-complete or
otherwise touch
`agents/handoffs/WO-0058_m03-g7-h-mutation-campaign-SEALED-predictions.md`
**at any revision**, and I did not read `WO-0056`, `WO-0057`, `RV-0055-VERDICT`,
`RV-0057-VERDICT`, any other `WO-`, `RV-`, `SO-` or `BUG-` packet, any other
agent's journal, `agents/PROTOCOL.md`'s neighbours in `agents/`, or
`tasks/BOARD.md`. The only `agents/**` files I read this spawn are the packet,
my own charter, `agents/PROTOCOL.md` and my own journal — the first three
because my spawn prompt's mandatory first actions name them, the last to write
this cycle's entry into.

**No unscoped `git log` was run, and no `git` subcommand of mine named a path
outside the allowlist.** The complete list of git invocations is:
`git diff --stat a2d090d HEAD -- libs/ docs/specs/ docs/adr/ dune-project .ocamlformat`;
`git diff a2d090d HEAD -- libs/`; `git archive a2d090d libs/`;
`git show a2d090d:dune-project`; `git show a2d090d:.ocamlformat`;
`git rev-parse` on SHAs and on the base blob; `git apply --check` and
`git apply` inside my scratch directory and `git apply --check` against the
working tree; and, in a scratch repository of my own containing only the
extraction, `git init / add / commit / diff / checkout`.

**One unscoped invocation, disclosed rather than smoothed**: I ran
`git status --porcelain` once, in the repository root, to prove that my
`git apply --check` calls had left the working tree untouched. It is unscoped by
nature. **Its output was empty**, so it disclosed nothing about any path, in or
out of bounds; had the tree been dirty it could have named out-of-bounds paths,
which is why it is listed here rather than treated as harmless.

### 1.3 Nothing outside the allowlist was written, either

The working tree's `libs/**` is **unmodified**: every mutation exists only as
diff text in this file and as a file in my private scratch directory
(packet bar 9). `git status --porcelain` was empty after all seven
`git apply --check` runs. No branch was created; no `git commit`, `git push`,
`git add` or `git checkout` was run in the repository (only inside the scratch
repositories I created).

### 1.4 One allowlist ambiguity, resolved conservatively

**The specifications moved after the base SHA.**
`git diff --stat a2d090d HEAD -- docs/specs/` reports 22 added lines in
`docs/specs/modules/xgmii_rx_64.md` and 50 in `docs/specs/requirements.md`;
`libs/` is empty in the same diff. I read the **`d609b36`** versions, because
the packet's §3 spec basis cites §9's *2026-08-04 zero-referent paragraphs* and
requirements.md §0.6's *C-23 counting-convention paragraph*, which are only
guaranteed present in the later text. This is the conservative reading in the
direction that matters: the design I mutated is `a2d090d`'s (byte-identical to
`d609b36`'s), and reading a **later, strictly additive** statement of the rules
cannot make a diff unfaithful to an **earlier** one where the two agree, while
reading the earlier one could have made me miss a rule the packet cites by
name. Every rule quoted below is quoted from the text I read.

---

## 2. What was produced, and how the base identity was fixed

Seven diffs, one per class, each a unified diff against `a2d090d` touching
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else. **All seven were
authored before any of them was applied anywhere** (packet bar 7); none has been
run, and no result of any kind has been seen.

**Clean application, verified three ways** (all read-only against the
repository):

1. In a scratch git repository containing **only** `git archive a2d090d libs/`
   — blob `81cd9ed`, `sha256` `3d87515a…5be92` — `git apply --check --index`
   returns clean for all seven.
2. In that same repository, each diff was **applied** and the resulting blob's
   `sha256` compared against the mutant I authored: **all seven match exactly**,
   so the diff text is a faithful serialisation of the file I reasoned about and
   not merely something that applies.
3. Against the live working tree at `d609b36`, `git apply --check` returns clean
   for all seven, and `git status --porcelain` is empty afterwards.

---

## 3. The seven manifest entries


### GH-c1 — the resynchronising start character read as a second abort

- **Site**: `create`, the epoch-A closure block — `a_close_start`
  (base line 375).
- **Code changed**: one line replaced by two; the rest of the diff is comment.

<!-- BEGIN gh-c1 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..a9dd6df 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -372,7 +372,22 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let a_close_error =
     a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
   in
-  let a_close_start = a_closes_with lanes.is_start in
+  (* MUTATION GH-c1 -- WO-0058, NEVER MERGE. Seeded defect: a start character
+     arriving in the [Discard] state -- after REQ-108's truncation point, while
+     the remainder of the oversize frame is being discarded -- raises epoch A's
+     REQ-110 closure as though a frame were still open, so a frame already
+     closed and already reported by [error_oversize] draws a second report: one
+     [error_start_without_terminate] on §9's two-cycles-after pin. §9's sixth
+     co-occurrence ruling makes such a character REQ-108's resynchronisation
+     rather than a second abort, pulsing nothing; C-12 is the carry-forward.
+     SEEDED FOR [/S/] IN [Discard] ONLY: [a_closing_v], [cov_first] and the
+     REQ-108 cap are untouched, so the truncation, its 1514-octet extent, its
+     `tuser` bit 0 and its own [error_oversize] are unchanged; [to_preamble] is
+     unchanged, so the receiver still resynchronises onto this very start
+     character and receives what follows normally; and [Discard]'s own switch
+     arm does not read [a_close_char], so the state sequence does not move. *)
+  let discard_start = sm.is State.Discard &: any lanes.is_start in
+  let a_close_start = a_closes_with lanes.is_start |: discard_start in
   let a_close_char = a_close_terminate |: a_close_error |: a_close_start in
   let a_close_now = (a_close_char |: a_close_oversize) &: ~:(i.clear) in
   (* Covered octets: lanes [cov_first, cov_end). Empty when cov_end <= cov_first,
```

<!-- END gh-c1 -->

### What the mutation does, mechanically

`a_close_start` is the module's REQ-110 closure predicate for **epoch A**, the
frame open on entry to the word. At base it is `a_closes_with lanes.is_start`,
and `a_closes_with` is gated by `a_char_acts = a_open &: ~:a_close_oversize`
with `a_open = in_preamble |: in_frame` — so in `Discard` the predicate is
structurally false, which is how §9's sixth co-occurrence ruling is realised.
The mutant ORs in `sm.is State.Discard &: any lanes.is_start`. A start character
decoded while the machine is in `Discard` therefore raises `a_close_start`,
hence `a_close_char`, hence `a_close_now`, and a closure record is written into
the three-age channel at `r0` with its `start` field set and every other field —
`terminate`, `error`, `oversize`, `fcs`, `runt` — clear. That record is served
oldest-first like any other; because `Discard` sets `cov_first` to 8 and covers
no octet, `pc` is 0, `have_word` is low and `emit_tlast` never fires for it, so
it is retired by the age-2 arm of `consume` and `strobe sel_start` drives
`error_start_without_terminate` high for exactly one cycle, two cycles after the
input word carrying that start character — §9's own pin for a frame that
produces no output word. Nothing upstream moves. `a_closing_v`, `cov_first`,
`cap_room`, `cap_end` and `a_close_oversize` are untouched, so REQ-108's
truncation point, its 1514-octet delivered extent, the truncated frame's
`tuser`[0] and its own single `error_oversize` are exactly the base design's;
`to_preamble = begins` is untouched, so the receiver still resynchronises onto
that very start character and receives what follows normally; the `Discard` arm
of the state machine reads `to_preamble` and `have_terminate` and **not**
`a_close_char`, so the state sequence does not move; and the spurious record
carries neither `terminate` nor `oversize`, so `strip` stays 0 and no output
word is created, shortened or suppressed. The added term searches all eight
lanes, mirroring the base predicate's own `a_close_oh` search rather than
narrowing to lanes 0 and 4 — §6.3 item 3 leaves a start character elsewhere
unconstrained either way.

### Why this is the class, and why it is not `g-c4`

The packet's §1 puts `g-c4` out of scope and §3 distinguishes the two: `g-c4`
seeded an **error** character in the discard window, against §9's *seventh*
ruling and REQ-105's open-frame clause. This seeds a **start** character there,
against §9's **sixth** ruling — *a start character arriving during the `Discard`
state is the resynchronisation REQ-108 requires, not a second abort, and it
pulses nothing* — and REQ-108's own *between the truncation point and that start
character the receiver SHALL emit no output word and SHALL pulse no strobe*.
C-12 is the carry-forward. The two diffs touch adjacent lines and different
predicates: `g-c4` extended `a_close_error`; this extends `a_close_start`, and
`a_close_error` is byte-unchanged here.


### GH-c2 — a frame an error character closed is re-aborted by the next start character

- **Site**: `create`, two sites — `a_close_start` (base line 375) and the
  statement block after `frame_start4` (base line 432).
- **Code changed**: one line replaced by three, plus one statement added; the
  rest is comment.
- **This is the only diff of the seven that adds state** — one bit. See the
  fidelity note below.

<!-- BEGIN gh-c2 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..6c68437 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -372,7 +372,24 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let a_close_error =
     a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
   in
-  let a_close_start = a_closes_with lanes.is_start in
+  (* MUTATION GH-c2 -- WO-0058, NEVER MERGE, first half of two. Seeded defect:
+     an [/E/] that closes an open frame does not close it for REQ-110's
+     purposes. [stale_frame] latches on every REQ-105 closure of an OPEN frame
+     and holds until a new frame is accepted, and while it is set the next
+     start character raises epoch A's REQ-110 closure -- so the frame the
+     error character already ended and already reported with [error_bad_frame]
+     draws a second report, one [error_start_without_terminate]. §9's fifth
+     co-occurrence ruling forbids the pairing in terms: an error character ends
+     the frame, so a start character after it begins a new frame and aborts
+     nothing. SCOPE: the latch is driven by [a_close_error], which is itself
+     gated by [a_char_acts] = [a_open] and not truncating, so it is never set
+     by an error character arriving with NO frame open -- not in the
+     inter-frame gap, not in [Discard]. Coverage, the truncation point, the
+     delivered octets, `tuser` bit 0 and the single [error_bad_frame] are all
+     untouched: the frame still stops delivering at the error character. *)
+  let stale_frame = wire 1 in
+  let stale_start = stale_frame &: any lanes.is_start in
+  let a_close_start = a_closes_with lanes.is_start |: stale_start in
   let a_close_char = a_close_terminate |: a_close_error |: a_close_start in
   let a_close_now = (a_close_char |: a_close_oversize) &: ~:(i.clear) in
   (* Covered octets: lanes [cov_first, cov_end). Empty when cov_end <= cov_first,
@@ -430,6 +447,11 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let begins = survivor_b |: survivor_c in
   let new_start4 = survivor_c in
   frame_start4 <== reg spec ~enable:begins new_start4;
+  (* MUTATION GH-c2, second half. Set by REQ-105's closure of an open frame,
+     cleared when a new frame is accepted. [a_close_error] and [begins] both
+     precede this point and neither depends on [a_close_start], so no
+     combinational loop is created. *)
+  stale_frame <== reg_fb spec ~width:1 ~f:(fun d -> (d |: a_close_error) &: ~:begins);
   (* ---- the running CRC (§6.1's FCS check, ADR-0006, ADR-0007) ----
      Seeded to 0x00000000 on the cycle a start character is accepted, which is
      the cycle before the frame's first octet is covered. Updated on every
```

<!-- END gh-c2 -->

### What the mutation does, mechanically

The diff adds a one-bit latch, `stale_frame`, set by `a_close_error` and cleared
by `begins`, and ORs `stale_frame &: any lanes.is_start` into `a_close_start`.
`a_close_error` is the module's REQ-105 closure of epoch A — an `/E/`, or any
other control character standing in one of epoch A's preamble positions — and it
is itself gated by `a_char_acts`, so it is only ever high on a word that closed
a genuinely **open** frame. While the latch is set, the next start character
raises `a_close_start`, so a closure record is written at `r0` with its `start`
field set and everything else clear, ages through the same channel, and retires
one `error_start_without_terminate` — for a frame the error character already
ended and already reported with `error_bad_frame`. §9's fifth co-occurrence
ruling forbids exactly this pairing: *an error character **ends** the frame
(§6.2 leaves to `Idle`), so a start character after it begins a new frame and
aborts nothing. A bench that injects `/E/` and then `/S/` SHALL see exactly one
`error_bad_frame` and no `error_start_without_terminate`.* Everything the scope
clause protects is untouched: `a_closing_v` still routes the error character
into `a_char_end`, so coverage still stops at the octet immediately preceding
it and the frame still stops delivering there; the delivered octets, `tkeep`,
`tuser`[0] and the single `error_bad_frame` of the `/E/`-closed frame are the
base design's; and the frame the start character opens is received normally,
because `begins`, `to_preamble` and the alignment path are untouched (the latch
is *cleared* by `begins`, and clearing it is its only interaction with the new
frame). Because the latch is a register, a start character in the **same word
as** the error character and above it is not affected: there the base design's
own rules apply — the error character is `a_close_oh`, the start character opens
epoch B or epoch C and aborts nothing. Because the spurious record enters the
same three-age channel, it is served in age order behind any record still live,
which is the ordinary behaviour of that channel and not a second defect.

### MANDATORY DISCLOSURE (packet §3, §5) — what this diff reaches

> **Does the diff also fire where an error character arrived with no frame
> open — the inter-frame gap, or the REQ-108 discard window?**
>
> **NO.** The latch's only set term is `a_close_error`, and `a_close_error` =
> `a_closes_with (…)` = `a_char_acts &: …` = `a_open &: ~:a_close_oversize &: …`
> with `a_open = in_preamble |: in_frame`. In `Idle` — the inter-frame gap,
> and after a terminate character — `a_open` is low, so an error character there
> sets nothing. In `Discard` — REQ-108's window — `a_open` is low, so an error
> character there sets nothing; C-12's *nothing pulses and nothing is emitted*
> is preserved. On the word where REQ-108's truncation itself binds,
> `a_close_oversize` is high, `a_char_acts` is low, and again nothing is set.
> **The latch is set only by a REQ-105 closure of a frame that was genuinely
> open.**

Three further reaches, disclosed because they are reaches even though the packet
does not name them:

1. **The set term is REQ-105's closure, not the character `/E/` alone.** §6.2's
   `Preamble` row and REQ-102's third sentence route *any other* control
   character in a preamble position — `/I/` and `/Q/` included — to REQ-105,
   and `a_close_error` carries `other_ctl &: a_pre_mask` for exactly that
   reason. The latch follows the **rule**, not the character. This is the same
   rule §9's fifth ruling is about, so it is inside the intent rather than
   beside it; a reader who expected `lanes.is_error` alone should know it is
   wider by that much.
2. **The latch survives an arbitrary gap.** It is cleared by `begins` and by
   `clear` (through the shared `Reg_spec`) and by nothing else, so if a frame
   closed by REQ-105 is followed after any number of idle cycles by an ordinary
   next frame, that ordinary frame's start character is the one that draws the
   spurious report. That **is** the class — §9's fifth ruling's own bench is
   *inject `/E/`, then `/S/`* with no bound on the separation — but it means the
   diff is not confined to a tight `/E/`-then-`/S/` window.
3. **`cfg_rx_enable` = 0 does not clear it.** `begins` carries the enable gate,
   so while the enable is 0 the latch is not cleared and each start character
   arriving under it raises the spurious closure again. REQ-802/REQ-810
   stimulus is therefore inside this diff's reach. It does not reach REQ-108's
   truncation, REQ-110's own aborts, or REQ-104's marking.

### Fidelity note — why one bit of state, and why nothing narrower exists

The intent is *an `/E/` that closes an open frame does not close it for
REQ-110's purposes*, and the scope clause forbids the obvious state-free
rendering in terms: *the frame must still stop delivering at the `/E/` — a diff
that leaves the frame genuinely receiving is a **different and much wider**
defect.* In this design the frame stops delivering **because the state machine
leaves to `Idle`**, and `a_open` is what makes epoch A's REQ-110 closure
reachable. So a rendering that keeps the frame abortable without keeping it
receiving cannot be a re-wiring of an existing signal — the fact that has to
survive from the `/E/` cycle to the `/S/` cycle is not carried anywhere in the
base design, and one bit is the smallest thing that carries it. The alternative
of adding a fifth FSM state, or of making the `Frame` → `Idle` exit conditional,
is strictly wider and lands on the forbidden reading. **This is a structural
addition, not a build-only repair**, and it is disclosed here rather than in §5.


### GH-c3 — FCS removal attempted on a frame cut short by a start character

- **Site**: `create`, the output decision — `strip` (base line 696).
- **Code changed**: one line replaced by two; the rest is comment.

<!-- BEGIN gh-c3 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..ff750a3 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -693,7 +693,19 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      begins a new frame tells the word before it nothing except that it was the
      last of its own. *)
   let nc = mux2 al_new (zero 4) (popcount al_keep) in
-  let strip = mux2 (sel_valid &: (sel_terminate |: sel_oversize)) (of_int ~width:4 4) (zero 4) in
+  (* MUTATION GH-c3 -- WO-0058, NEVER MERGE. Seeded defect: FCS removal is
+     attempted on a frame cut short by a start character. [strip] is the count
+     of trailing octets the output decision withholds from the emitted word;
+     REQ-103's last sentence says a frame cut short under REQ-110 delivers
+     every octet decoded up to its abort point, WITH NO FCS REMOVAL ATTEMPTED,
+     so [sel_start] must not appear here. With it, a REQ-110-aborted frame's
+     delivered extent is four octets shorter, and [tkeep] and the output-word
+     count follow that shorter extent. SEEDED ON THE REQ-110 PATH ONLY:
+     [sel_error] -- REQ-105's abort -- is NOT added, and [sel_oversize] was
+     already present as REQ-108's own 1518-to-1514 arithmetic and is untouched.
+     The abort bit is unchanged, since [abort] is a separate term. *)
+  let strip_cond = sel_valid &: (sel_terminate |: sel_oversize |: sel_start) in
+  let strip = mux2 strip_cond (of_int ~width:4 4) (zero 4) in
   (* ---- the all-FCS tail word (REQ-103, REQ-015; BUG-0001) ----
      [emit_last_a] is the case where the FCS lies wholly inside the emitted
      word, and its [pc >: strip] guard is what stops a word made *only* of FCS
```

<!-- END gh-c3 -->

### What the mutation does, mechanically

`strip` is the number of trailing octets the output decision withholds from a
frame's final word — the whole of REQ-103's FCS removal, performed by `tkeep`
rather than by holding octets back. At base it is 4 when the consumed closure
record says the frame ended with a terminate character or was truncated by
REQ-108, and 0 otherwise; REQ-110's abort (`sel_start`) and REQ-105's
(`sel_error`) are deliberately absent, which is REQ-103's last sentence
implemented — *a frame aborted under REQ-105, truncated under REQ-108 or cut
short under REQ-110 delivers every octet decoded up to its abort point, with no
FCS removal attempted*. The mutant adds `sel_start` to that condition. A frame
cut short under REQ-110 therefore takes `strip` = 4, and the three consumers of
`strip` follow: `keep_count` becomes `pc − 4` on the ordinary last word, so the
frame's delivered extent is four octets shorter and `tkeep` marks the shorter
extent; `emit_last_a`'s guard `pc >: strip` withholds a final word that carries
four or fewer octets altogether, so the output-word count follows the shorter
extent as well; and `emit_last_b` (`nc <=: strip` with `nc` ≥ 1) becomes
reachable on this path, taking `tlast` one word earlier with
`keep_count = pc − 4 + nc` and arming `fcs_tail_pending` to drop the word behind
it. `abort` is a separate expression and does not read `strip`, so `tuser`[0] is
unchanged; `consume` reads `emit_tlast`, so where the shortened extent removes
the frame's last word the record is retired by the age-2 arm instead of on a
`tlast` cycle — the same structure the base design already uses for a frame with
nothing left to deliver. Nothing else in the module reads `strip`.

### MANDATORY DISCLOSURE (packet §3, §5) — what this diff reaches

> **Does the same diff also shorten an `/E/`-aborted frame (REQ-105) or a
> truncated frame (REQ-108)?**
>
> **NO to both, and the second needs one sentence of care.**
>
> **REQ-105**: `sel_error` is **not** added. An `/E/`-aborted frame takes
> `strip` = 0 exactly as at base and delivers every octet it decoded.
>
> **REQ-108**: `sel_oversize` **was already in the base condition** and the diff
> does not touch it. That is not FCS removal — the module's own comment records
> it as REQ-108's 1518-to-1514 arithmetic, obtained by capping coverage at 1518
> and letting the four-octet tail removal run — and a truncated frame's
> delivered extent, `tuser`[0] and `error_oversize` are byte-for-byte the base
> design's under this diff. **The diff's entire behavioural reach is the
> `sel_start` term**, i.e. frames closed by epoch A's REQ-110 abort.
>
> It does not reach REQ-104's marking, REQ-108's resynchronisation, REQ-107's
> runt path (`sel_runt` is not in the condition at base and is not added), or
> the frame the aborting start character opens.

One consequence worth naming so it is not mistaken for a second defect: because
`sel_start` is the **record's** start bit and the record channel carries epoch A
only, frames aborted in-word (epochs B and C, reported through `q2`) deliver no
octet and never reach `strip` at all. The diff cannot touch them.


### GH-c4 — the new frame's alignment applied to the aborted frame's own octets

- **Site**: `create`, the alignment window — immediately after `off4`
  (base lines 664–667).
- **Code changed**: one line added, none removed; the rest is comment.

<!-- BEGIN gh-c4 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..f8d60cd 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -665,6 +665,20 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
     reg_fb spec ~width:1 ~f:(fun d ->
       mux2 (begins &: ~:new_start4) gnd (mux2 start4_pending vdd d))
   in
+  (* MUTATION GH-c4 -- WO-0058, NEVER MERGE. Seeded defect: the alignment
+     window switches to the new frame's offset ON THE SAME CYCLE the new start
+     character is accepted, instead of one register level later. The comment
+     above states exactly what the lag is for: a REQ-110 restart can put the
+     aborted frame's last octets in the same word as the new frame's start
+     character, and the aborted frame's octets must still be rotated by the OLD
+     offset. With the bypass, the word decoded on the accepting cycle is
+     rotated by the NEW offset, so the octets of that word that belong to the
+     aborted frame are assembled from the wrong two half-words. REQ-021 and
+     REQ-101 govern the alignment; REQ-008 is what makes silent corruption of
+     already-decoded octets a defect rather than a nuance. The register itself
+     is untouched, so from the following cycle onward the offset is exactly the
+     base design's and the new frame's own words are unaffected. *)
+  let off4 = off4 |: (begins &: new_start4) in
   let data_d = reg spec i.xgmii_rx.d in
   let cov_d = reg spec cov in
   let first_d = reg spec first_v in
```

<!-- END gh-c4 -->

### What the mutation does, mechanically

The base design's `off4` is a register whose new value of 4 **deliberately lags
the frame's start lane by one cycle**, and the comment above it states exactly
why: *a REQ-110 restart can put the aborted frame's last octets in the same word
as the new frame's start character; the aborted frame's octets must still be
rotated by the old offset, and this is the delay that gives them that.* The
mutant leaves the register alone and bypasses it combinationally —
`off4 |: (begins &: new_start4)` — so on the cycle **W** on which a lane-4 start
character is accepted the alignment window already uses the new frame's offset.
Write cov(W) for that word's coverage vector. At offset 4 the window produces
`al_data` = *the previous word's upper four octets followed by this word's lower
four*, and `al_keep` = `{cov(W)[3:0], cov(W−1)[7:4]}`.

At REQ-110's own geometry — a frame aligned at offset 0, aborted by a start
character in lane 4 of W, so cov(W) = 0x0F (REQ-110's *a start character in lane
4 leaves lanes 0 to 3 of that word belonging to the aborted frame*) and
cov(W−1) = 0xFF — the mutant's `al_keep` at W is `{0xF, 0xF}` = **0xFF**, the
same eight-octet extent the base produces from `cov_d`. `first_v` is low in
`Frame`, so `al_new` and therefore `nc` are unchanged as well. Only `al_data`
moves: writing the aborted frame's octets 8m … 8m+7 for word W−1 and
8m+8 … 8m+11 for lanes 0–3 of W, the base emits 8m … 8m+7 in that aligned word
and the mutant emits 8m+4 … 8m+11. On W+1 the bypass is low again and the
register still holds the old offset, so the frame's final four-octet word is
produced exactly as at base, carrying 8m+8 … 8m+11 with `tkeep` = 0x0F. The
frame therefore delivers the **same number of octets in the same number of words
with the same `tkeep`, the same `tlast` placement, the same `tuser`[0], the same
closure record and the same strobe cycle** — while octets 8m … 8m+3 never appear
on the stream and octets 8m+8 … 8m+11 appear twice. REQ-021 and REQ-101 govern
the alignment that is broken; REQ-008 is what makes a silent corruption of
already-decoded octets a defect rather than a nuance. From W+1 onward the offset
is the base design's own, so the **new** frame's aligned words — assembled at
W+2 from `{cov(W+2)[3:0], cov(W+1)[7:4]}` — are byte-identical to base.

### MANDATORY DISCLOSURE (packet §3, §5) — which of the two readings this is

> **This diff produces the COUNT-PRESERVING, CONTENT-DESTROYING reading** — the
> signature class the intent names: *delivered, counted and `tkeep`-marked as
> before, but carrying the wrong values*. It is **not** the count-moving
> reading. The delivered octet count, the output-word count, `tkeep`, `tlast`,
> `tuser`[0] and the strobe cycle of the aborted frame are all unchanged at
> REQ-110's lane-4 abort geometry; only `tdata` content moves.

And what it reaches beyond that geometry, disclosed because the gating term is
`begins &: new_start4` — *every* cycle on which a lane-4 start character is
accepted — and not a REQ-110 predicate:

1. **A lane-4 start with no frame's octets in the two-word window is
   unaffected.** From `Idle` after a conformant inter-frame gap, requirements.md
   §0.3's twelve-octet minimum forces the preceding terminate character into
   lane 0 of W−1, where it covers nothing, so cov(W−1) = cov(W) = 0 and both
   `al_keep` expressions are 0. The rotation has nothing to corrupt and the
   output is byte-identical to base. **This is why the diff is not a
   general-purpose lane-4 corruption.**
2. **One geometry in which the same diff moves the count instead.** Where the
   accepting word carries a start character in **lane 0 as well as lane 4** —
   §10's REQ-110 hook's second commissioned case — `a_close_oh` is the lane-0
   character, cov(W) = 0, and the mutant's `al_keep` at W is
   `{0x0, cov(W−1)[7:4]}` = 0xF0 against the base's 0xFF. There the aborted
   frame's last aligned word loses four octets rather than being rotated, so in
   **that** geometry the diff exhibits the other reading. The seal branches on
   the reading; this is stated so both branches can be scored rather than one
   assumed.
3. It does not reach REQ-105's aborts, REQ-108's truncation or its
   resynchronisation, REQ-104's marking, or any strobe.


### GH-c5 — the aborting start character does not begin a new frame

- **Site**: `create`, the in-word epoch block — `begins` (base line 430).
- **Code changed**: one line replaced by one; the rest is comment.

<!-- BEGIN gh-c5 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..c33ef9b 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -427,7 +427,22 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      and both close epoch A. *)
   let survivor_b = b_exists &: ~:(any b_closing) in
   let survivor_c = c_exists &: ~:(any c_closing) in
-  let begins = survivor_b |: survivor_c in
+  (* MUTATION GH-c5 -- WO-0058, NEVER MERGE. Seeded defect: REQ-110's second
+     clause -- and SHALL begin a new frame at that start character -- is not
+     honoured. [a_close_start] is the module's own predicate for a start
+     character that aborts the open frame under REQ-110, so gating [begins]
+     with its complement suppresses exactly the frame such a character should
+     open. The abort itself is untouched and correctly reported: the frame is
+     still cut at the octet before the start character, still marked, and still
+     pulses its single [error_start_without_terminate], because none of
+     [a_close_start], the closure record or the coverage logic reads [begins].
+     With [to_preamble] low the state machine falls through to
+     [a_close_char] and the receiver goes to [Idle] -- it waits for the NEXT
+     start character, and every frame the aborting character should have opened
+     is lost with no report of its own, the silent discard REQ-008 forbids.
+     REQ-108's resynchronisation is NOT reached: [a_close_start] is gated by
+     [a_char_acts], which is low in [Discard] and low on a truncating word. *)
+  let begins = (survivor_b |: survivor_c) &: ~:a_close_start in
   let new_start4 = survivor_c in
   frame_start4 <== reg spec ~enable:begins new_start4;
   (* ---- the running CRC (§6.1's FCS check, ADR-0006, ADR-0007) ----
```

<!-- END gh-c5 -->

### What the mutation does, mechanically

`begins` is the module's single *a new frame is handed forward* signal: it
drives `to_preamble` (and so every `Preamble` entry in the state machine), the
reload of the octet counter and of the CRC seed, the `frame_start4` capture, and
`start4_pending`/`off4`. The mutant gates it with the complement of
`a_close_start` — the module's own predicate for *epoch A was closed by a start
character*, which is REQ-110's abort. On a word in which a start character
aborts the frame open on entry, `begins` is low: the state machine's
`to_preamble` arm is not taken, `to_discard` is low, and the machine falls
through to `a_close_char` and goes to `Idle`; `count`, `crc_reg`,
`frame_start4`, `start4_pending` and `off4` all hold; no frame is opened at that
character, and the receiver behaves as though idle and waits for the **next**
start character. REQ-110's second clause — *and SHALL begin a new frame at that
start character* — is simply not honoured, and every frame the aborting
character should have opened is lost with no report of its own, which is the
silent discard REQ-008 forbids and §0.6's conservation equation counts.

The abort itself is correct and correctly reported, and that is structural
rather than lucky: `a_close_start`, `a_close_now`, `r0`, `a_char_end`, `cov_end`,
`strip`, `abort` and `consume` do not read `begins`. The aborted frame is still
cut at the octet immediately preceding the start character (REQ-106's rule, via
`a_char_end`), still carries `tuser`[0] = 1 on its `tlast` word where it
delivers anything, and still retires exactly one
`error_start_without_terminate`. Its `tlast` cycle does not move either: the
only coverage the suppression removes is the **new** frame's, which enters the
alignment window one cycle after the aborted frame's last covered word, and the
aborted frame's own `nc` at that point is 0 under both the base (through
`al_new`, which the new frame's `first_v` raises) and the mutant (through an
empty `al_keep`, because `Idle` covers nothing). The two produce the same
`emit_last_a` on the same cycle.

### MANDATORY DISCLOSURE (packet §3, §5) — does it reach REQ-108's resynchronisation?

> **NO, in either of that resynchronisation's two forms.** `a_close_start` is
> gated by `a_char_acts = a_open &: ~:a_close_oversize`.
>
> - **In `Discard`** — the ordinary resynchronisation, `Discard` → a new frame
>   on `/S/` — `a_open` is low, so `a_close_start` is low, so `begins` is
>   ungated and the new frame opens normally.
> - **On the truncating word itself** — a start character above the lane at
>   which REQ-108's cap binds — `a_close_oversize` is high, `a_char_acts` is
>   low, `a_close_start` is low, and again the new frame opens normally.
>
> **The diff's entire behavioural reach is `a_close_start`**: epoch A, in
> `Preamble` or `Frame`, closed by a start character. It does not reach
> REQ-105's aborts, REQ-104's marking, REQ-108's truncation or marking, or
> `cfg_rx_enable`'s own gating (which `b_exists`/`c_exists` already carry — the
> diff only ever removes frames, never admits one).

**One place where it is narrower than REQ-110's full extension, disclosed
because the packet asks what the diff reaches and this is a place it does
not.** A start character in **lane 4** that aborts a frame opened by a start
character in **lane 0 of the same word, with nothing open on entry** — §10's
REQ-110 hook's second commissioned case — aborts **epoch B**, not epoch A, so
`a_close_start` is low there and the lane-4 frame still begins. That aborted
frame's own report is untouched: it travels the `inword_strobes` → `q2` path,
which does not read `begins` either. Where a frame **was** open on entry to such
a word, `a_close_oh` is the lane-0 start character, `a_close_start` is high, and
both start characters' frames are suppressed. Extending the gate to epoch B's
abort would have required a second term reproducing `inword_strobes`' own start
computation; I judged the single-predicate gate the faithful minimal rendering
and am disclosing the edge it leaves rather than widening the diff to cover it.


### GH-c6 — `error_start_without_terminate` never pulses

- **Site**: `create`, the output record — the
  `error_start_without_terminate` field (base line 765).
- **Code changed**: one line replaced by one; the rest is comment.

<!-- BEGIN gh-c6 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..f7c9295 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -750,6 +750,17 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      one-term union and is written as one. *)
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
+  (* MUTATION GH-c6 -- WO-0058, NEVER MERGE. Seeded defect:
+     [error_start_without_terminate] never pulses, for any frame and from
+     either report path. The condition is still detected and still acted on in
+     every other respect -- [a_close_start] still closes the frame at the right
+     octet, [abort] still carries [sel_start] so `tuser` bit 0 is still set on
+     the `tlast` word of a frame that delivers anything, [consume] is unchanged
+     so the closure record is still retired on its pinned cycle, and the new
+     frame still begins normally. Only the port is held low. REQ-008 forbids
+     silent discard and §9's rows 8 and 9 require the report; for a
+     zero-delivered abort §9 and §0.7 make this strobe the frame's only report.
+     Every other strobe is untouched. *)
   { O.rx =
       { Axi64.Source.tvalid
       ; tdata = al_data_d
@@ -762,7 +773,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   ; error_bad_frame = strobe sel_error |: q_strobe 0
   ; error_runt = strobe sel_runt |: q_strobe 1
   ; error_oversize = strobe sel_oversize
-  ; error_start_without_terminate = strobe sel_start |: q_strobe 2
+  ; error_start_without_terminate = gnd
   }
 ;;
 
```

<!-- END gh-c6 -->

### What the mutation does, mechanically

One field of the output record is driven to `gnd`. That cuts **both** report
paths for this name at once — epoch A's `strobe sel_start`, consumed from the
aged closure record on its pinned cycle, and the in-word epochs'
`q_strobe 2`, fixed two cycles after their word — so the strobe never pulses,
for any frame, at either start lane, from either path. Everything that computes
the condition, and everything else that acts on it, is untouched:
`a_close_start` still closes the frame at the octet immediately preceding the
start character; `r0`'s start bit still travels the ageing channel and
`consume` still retires the record on exactly its pinned cycle, so no other
frame's report is delayed or advanced; `abort` still carries `sel_start`, so
`tuser`[0] = 1 still appears on the `tlast` word of a REQ-110 abort that
delivers anything; `inword_strobes` still computes its start bit into `q2`;
`begins` and `to_preamble` still open the new frame normally; and the other four
strobe ports — `error_bad_fcs`, `error_bad_frame`, `error_runt`,
`error_oversize` — are byte-identical to base, including the `q_strobe 0` and
`q_strobe 1` terms that share `q2` with the suppressed bit. REQ-008 forbids
silent discard and §9's rows 8 and 9 require this report; for a zero-delivered
abort, §9's *no output word at all* clause and §0.7 make this strobe the frame's
**only** report, so its suppression removes such a frame from §0.6's
conservation equation entirely.

The class is deliberately quiet — it agrees with every content assertion a
correct design satisfies — and the packet's own note asks that it not be
strengthened. It has not been: the diff drives one port low and changes nothing
else.


### GH-c7 — two consecutive reports of one strobe collapsed into one high cycle

- **Site**: `create`, the output record — a helper added after `q_strobe`
  (base line 752) and the five strobe fields (base lines 761–765).
- **Code changed**: one line added and five replaced; the rest is comment.

<!-- BEGIN gh-c7 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..353a96f 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -750,6 +750,19 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      one-term union and is written as one. *)
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
+  (* MUTATION GH-c7 -- WO-0058, NEVER MERGE. Seeded defect: a one-cycle
+     per-name lockout on every strobe, i.e. a rising-edge-shaped report. Where
+     two frames' reports of the SAME strobe fall on CONSECUTIVE cycles the port
+     is high for one cycle instead of two, and the second frame's report is
+     lost. requirements.md §0.6's counting convention is the rule this breaks:
+     one high cycle per reported event, monitors count high cycles and never
+     rising edges, and a strobe does not return to 0 between consecutive
+     events. Nothing about a lone report changes -- a report preceded by an
+     idle cycle on its own name still occupies exactly one cycle on its pinned
+     cycle -- and nothing upstream of the ports moves: the second frame is
+     still aborted, closed and counted, it is simply not reported, so §0.6's
+     conservation equation is short by one frame. *)
+  let collapse s = s &: ~:(reg spec s) in
   { O.rx =
       { Axi64.Source.tvalid
       ; tdata = al_data_d
@@ -758,11 +771,11 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
       ; tlast = emit_tlast &: ~:(i.clear)
       ; tuser = emit_tlast &: abort
       }
-  ; error_bad_fcs = strobe sel_bad_fcs
-  ; error_bad_frame = strobe sel_error |: q_strobe 0
-  ; error_runt = strobe sel_runt |: q_strobe 1
-  ; error_oversize = strobe sel_oversize
-  ; error_start_without_terminate = strobe sel_start |: q_strobe 2
+  ; error_bad_fcs = collapse (strobe sel_bad_fcs)
+  ; error_bad_frame = collapse (strobe sel_error |: q_strobe 0)
+  ; error_runt = collapse (strobe sel_runt |: q_strobe 1)
+  ; error_oversize = collapse (strobe sel_oversize)
+  ; error_start_without_terminate = collapse (strobe sel_start |: q_strobe 2)
   }
 ;;
 
```

<!-- END gh-c7 -->

### What the mutation does, mechanically

A one-cycle per-name lockout is applied to every strobe port:
`collapse s = s &: ~:(reg spec s)`, so each port carries the **rising edge** of
the value the base design drives on that name. A report whose name was low on
the preceding cycle is unchanged in width and in cycle — a lone abort still
pulses for exactly one cycle on its pinned cycle. A report whose name was high
on the preceding cycle is suppressed entirely, so where two frames' reports of
the **same** strobe fall on **consecutive** cycles the port is high for **one**
cycle instead of two. requirements.md §0.6's counting convention is the rule
this breaks in terms: *one high cycle per reported event … a monitor therefore
counts high cycles, never rising edges*, and *the strobe does **not** return to 0
between them*; C-23 is the carry-forward. Nothing upstream of the ports moves:
the closure records, `consume`, `q2`, `abort`, `tvalid`, `tkeep`, `tlast` and
`tuser` are all untouched, so the second frame is still aborted, still closed,
still counted and still marked — it is simply not reported, and §0.6's
conservation equation is short by one frame. The lockout register is cleared by
the shared `Reg_spec`'s synchronous `clear`, so the first report after `clear`
is never swallowed, and REQ-009's all-strobes-0 requirement is unaffected (the
base's own `~:(i.clear)` terms are inside `strobe`/`q_strobe` and are retained).

### Scope, disclosed although §5 does not demand it for this class

The lockout is applied to **all five** strobe names, uniformly — which is the
intent's *one-cycle-per-name lockout* read literally, and matches the rule it
breaks: §0.6's counting convention is programme-wide and is stated for every
strobe, not for one. A narrower diff touching only
`error_start_without_terminate` was considered and rejected as a narrowing of
the stated intent, not a minimisation of it. §6.3 item 8's excluded stimulus is
not involved: item 8 bars two frames reporting under one name on the **same**
cycle, and this diff changes nothing about that case (a single high cycle
remains a single high cycle); consecutive cycles are specified behaviour, which
is what the packet's §3 note records having checked.


---

## 4. The four mandatory disclosures, collected

The packet's §5 makes the sealed row set for GH-c2 … GH-c5 a **function** of
these answers, so they are repeated here in one place, in the packet's own
terms. Each is argued in full in the class entry above.

| class | the question the packet asks | the answer |
|---|---|---|
| **GH-c2** | does the diff also fire where an error character arrived with **no frame open** — the inter-frame gap, or the REQ-108 discard window? | **NO.** The latch's only set term is `a_close_error`, gated by `a_char_acts = a_open &: ~:a_close_oversize`; `a_open` is low in `Idle` and in `Discard`, and `a_close_oversize` blanks it on the truncating word. It is set only by a REQ-105 closure of a genuinely open frame — including the `/I/`- and `/Q/`-in-a-preamble-position instances REQ-102's third sentence routes to REQ-105. It survives an arbitrary gap and is not cleared while `cfg_rx_enable` = 0. |
| **GH-c3** | does the same diff also shorten an `/E/`-aborted frame (REQ-105) or a truncated frame (REQ-108)? | **NO to both.** `sel_error` is not added, so REQ-105 aborts take `strip` = 0 as at base. `sel_oversize` was **already** in the base condition as REQ-108's own 1518-to-1514 arithmetic and is untouched, so a truncated frame is byte-for-byte the base design's. The diff's whole behavioural reach is the added `sel_start` term — epoch A's REQ-110 aborts. |
| **GH-c4** | which of the two readings did you produce — count-preserving/content-destroying, or count-moving? | **COUNT-PRESERVING AND CONTENT-DESTROYING** at REQ-110's lane-4 abort geometry: same delivered count, same word count, same `tkeep`, same `tlast`, same `tuser`[0], same strobe cycle, wrong octets. Two reaches disclosed: a lane-4 start with no frame octets in the two-word window is unaffected entirely; and in the one geometry where the accepting word carries a start character in lane 0 as well as lane 4, the same diff moves the count instead. |
| **GH-c5** | does the diff also reach REQ-108's resynchronisation (`Discard` → a new frame on `/S/`)? | **NO**, in either form. `a_close_start` is low in `Discard` (`a_open` low) and low on the truncating word (`a_close_oversize` high), so both resynchronisations open their frame normally. Disclosed narrowing: a lane-4 start aborting a frame opened by a lane-0 start **in the same word with nothing open on entry** aborts epoch B, not epoch A, and its new frame still begins. |

---

## 5. Build state, and what I could not verify

**Build-only repairs applied: none.** No diff has been revised for any reason,
because none has been run (packet bar 8's exception has not been invoked).

**What was verified mechanically:**

- **Syntax and comment lexing**: every mutant parses. `ocamlc -stop-after
  parsing -c` (system OCaml **4.14.1**) accepts all seven, and accepts the
  unmutated base as a control. This is a real check for this file — the added
  comments contain `[/S/]`, `§`, `--` and apostrophes, and an unbalanced `"`
  inside an OCaml comment is a lexer error. `grep -c '"'` returns **33** on the
  base and **33** on each of the seven mutants, so no added comment introduces
  a quote at all.
- **Clean application and faithful serialisation**: §2's three checks.
- **Margin**: **every added line is ≤ 88 columns**, and every added expression
  is a single-line `let … in` rather than a multi-line one, so the diff is a
  fixpoint of any reasonable formatter setting rather than of one guess about
  the margin. This is why GH-c1, GH-c2 and GH-c3 name an intermediate binding
  (`discard_start`, `stale_start`, `strip_cond`) instead of extending the
  original line: extending it would have produced a 97-to-110-column line whose
  reformatting is margin-dependent.

**What could not be verified, and is therefore argued rather than demonstrated:**

- **Types and widths.** Hardcaml, `hardcaml_axi`, `ppx_hardcaml` and
  `ocamlformat` are **absent from this container** — the only opam switch
  (`fpga`) contains `dune` 3.24.1 and nothing else, and `dune build` fails at
  *Library "hardcaml_axi" not found*. ADR-0005 makes a local build inadmissible
  evidence in any case. The argument is by construction: every added expression
  is built from operators and combinators the file already uses **at the same
  site or within a few lines of it** — `sm.is State.Discard` (the base uses
  `sm.is State.Preamble` and `sm.is State.Frame` at lines 260–261), `any`,
  `&:`, `|:`, `~:`, `wire 1` with `<==` (used for `count`, `crc_reg`,
  `frame_start4`, `consume`, `r1`, `r2`, `fcs_tail_pending`),
  `reg_fb spec ~width:1 ~f:` (used for `off4`), `reg spec` (used throughout) and
  `gnd` (used at line 666). Every added signal is one bit wide and every
  combination is between one-bit signals. No binding is left unused by any
  diff: `sel_start` survives in `abort` under GH-c6, `q_strobe` survives at
  indices 0 and 1, and `start4_pending` survives inside the untouched `off4`
  register under GH-c4.
- **Formatting.** `dune build @fmt` cannot be run here, and the base itself
  carries **two 97-column code lines** (622 and 696) against `.ocamlformat`'s
  janestreet profile, so **whether `@fmt` is clean at `a2d090d` at all is
  unestablished** — unchanged from WO-0050 and WO-0055 and still open. If a
  `@fmt` failure appears under any of these seven, the first question is whether
  it is pre-existing; bar 8's compile-only repair clause should not be spent on
  a base-level failure.

---

## 6. Fidelity ledger — what was seeded whole, and the two judgement calls

**NOT-SEEDED: none.** All seven intents admit a rendering inside their own
stated intent, and all seven are seeded. Nothing was substituted for something
easier, and no class was narrowed in order to make it build.

Two renderings involved a judgement the adjudication should be able to reverse
in one line if dv_lead reads the intent differently:

1. **GH-c2 adds one bit of state.** The scope clause forbids the state-free
   rendering by name, and the fact that must survive from the `/E/` cycle to the
   `/S/` cycle is carried nowhere in the base design. §3's entry argues this in
   full. If dv_lead intended the wider *frame keeps receiving* rendering, that
   is the defect the clause calls *different and much wider* and is a different
   class, not a revision of this one.
2. **GH-c5 gates on `a_close_start` rather than on every REQ-110 abort.**
   `a_close_start` is the module's own name for the class; extending to epoch
   B's in-word abort would have required a second term reproducing
   `inword_strobes`' start computation. The edge it leaves is named in §3's
   entry rather than papered over. One term reverses it.

**Bounds this manifest does not close** (beyond the five the packet names in its
own §8): the record channel's three ages are sized in the base design on the
argument that at most one closure record is live at a time; GH-c1 and GH-c2 each
introduce a record the base design would not have produced, so in geometries
where an older record is still live the two are served oldest-first and the
newer one reports later than it otherwise would. That is the channel's ordinary
behaviour under an extra record, and it is a property of the seeded defect, not
a second seeded defect — stated here so that an adjudicator who sees it does not
read it as one.

---

## 7. Extraction, for the orchestrator

Each diff below appears between a `<!-- BEGIN gh-cN -->` / `<!-- END gh-cN -->`
sentinel pair, in a fenced block whose content is byte-exact. To recover the
seven files in the WO-0055 form, from the repository root:

```sh
python3 - <<'EOF'
import re
src = open("docs/reports/audit/WO-0058-mutations/README.md", encoding="utf-8").read()
pat = "<!-- BEGIN (gh-c[1-7]) -->" + chr(10) * 2 + "[`]{3}diff" + chr(10) + "(.*?)" + chr(10) + "[`]{3}" + chr(10)
for m in re.finditer(pat, src, re.S):
    open(m.group(1) + ".diff", "w", encoding="utf-8").write(m.group(2) + chr(10))
EOF
```

Each recovered file applies to `a2d090d` with `git apply`, on its own, to a
throwaway branch named `mut/wo-0058-<id>` per packet §6. **No two diffs may be
applied to the same tree**: `gh-c1`, `gh-c2` and `gh-c5` all touch the
`a_close_start` region, `gh-c6` and `gh-c7` both touch the output record, and
several pairs overlap textually as well as behaviourally.
