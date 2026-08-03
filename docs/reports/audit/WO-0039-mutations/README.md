# WO-0039 — five seeded mutations of M03, authored blind

- **Author**: auditor (independent; I authored neither M03's RTL nor its bench)
- **Date**: 2026-08-03
- **Packet**: `agents/handoffs/WO-0039_m03-mutation-campaign.md` (committed at
  `0d231ee`) — dv_lead's brief, §§1–5 of which are my whole instruction
- **Base**: every diff is against
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **exactly as it stands at
  `6bd7e5a`** (sha256 of that blob's file:
  `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`; the
  working tree at `0d231ee` is byte-identical to it — `git diff 6bd7e5a HEAD --
  libs/` is empty)
- **Artifacts**: `M1.diff` … `M5.diff` in this directory. Each is a single-file
  unified diff applying with `git apply` from the repository root. The diffs are
  reproduced in full in §3 below; the `.diff` files are the authoritative copies
  and the inlined text is generated from them, not retyped.
- **Journal**: `J-auditor-0004`

> **These patches are mutations. They are never to be committed to any branch
> that merges.** Packet §4: one throwaway branch per mutation, parent
> `6bd7e5a`, exactly one diff, deleted after its run. Every hunk carries an
> `MN MUTATION (WO-0039)` marker comment so that a leaked mutant is greppable.

---

## 1. Scope statement — everything I read, and the five bars

Packet §1 sets five bars on me for the campaign's duration and §0 says the
enforcement is my own `Inputs` disclosure. **All five were honoured.** Stated
individually, in the packet's own order:

1. **`test/xgmii_rx_64/**` — not read.** I opened no file under `test/` at all,
   of any name, at any SHA.
2. **`test/attack_plans/AP-xgmii_rx_64.md` — not read.** Nor any other file
   under `test/attack_plans/`.
3. **The sealed companion `WO-0039_m03-mutation-campaign-SEALED-predictions.md`
   — not opened.** I know of it only that it exists (it appears in
   `git diff --stat 6bd7e5a HEAD`, which I ran to establish that `libs/` had not
   moved; the stat line shows a path and a line count, no content).
4. **All five diffs were authored before any of them was run**, and none has
   been run: no test, no simulation, no elaboration. See §4 for the two
   mechanical checks I did perform, neither of which executes the design.
5. **No diff has been revised after seeing a test result**, there being no test
   result in existence to see.

**Complete list of files read for this work order** (this is the enforcement
record; if it shows a bench or attack-plan read, the affected mutations are void):

| Path | Extent |
|---|---|
| `agents/charters/auditor.md` | full |
| `agents/PROTOCOL.md` | full |
| `agents/handoffs/WO-0039_m03-mutation-campaign.md` | full (at `0d231ee`) |
| `docs/specs/modules/xgmii_rx_64.md` | full, all 949 lines (SPEC-M03) |
| `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` | full (at `6bd7e5a`) |
| `libs/hardcaml_ethernet/src/xgmii_rx_64.mli` | full |
| `libs/hardcaml_ethernet/src/crc32_eth.ml` | full (M02's value convention, for M2's argument) |
| `libs/hardcaml_ethernet/src/dune`, `dune-project` | full (build surface: `ppx_hardcaml`, `ppx_jane`) |
| `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`, `axi64.ml` | **grep hits only** — lines 119–120, 211, 236, 240 and 7–9 respectively, from one `grep -n "\.map \|Of_signal\|popcount\|\.mli"` over `libs/hardcaml_ethernet/src/*.ml`, run to check which Hardcaml idioms this library already uses |
| `docs/adr/ADR-0005-build-environment.md` | full (why I cannot compile) |
| `agents/journals/claude_auditor_agent.md` | header (lines 1–40) and the head of `J-auditor-0003`, for the next entry id and the grammar; **read only, never modified above EOF** |
| git objects | `git log --oneline -16`; `git show 0b64b68` in full (the BUG-0001 fix commit, including its RTL diff — M5's reverted hunk); `git show 0b64b68^:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (the pre-fix source); `git diff --stat 6bd7e5a HEAD`; `git diff --stat 6bd7e5a HEAD -- libs/` |
| directory listings | `ls -R libs/`, `ls docs/adr/`, `ls -R docs/reports/audit/`, `ls /root/.opam/fpga/{bin,lib}` (toolchain check — no Hardcaml is installed; no source in the switch was read) |

**Deliberately not read, though nothing barred them** — recorded because the
campaign's validity rests on what I did *not* see, and a bar list is a floor:

- `agents/handoffs/BUG-0001_m03-final-word-over-delivery.md`. The packet points
  at it for M5's invariant, so opening it was sanctioned; I did not, because a
  dv_lead bug packet is likely to name the bench rows that caught the defect and
  I did not need it. M5's implementation is dictated by the packet ("revert the
  fix hunk"), and I re-derived the `max(0, k − 4)` invariant from the RTL myself
  (§3.5) before comparing it with the packet's statement of it.
- `agents/journals/claude_dv_lead_agent.md` and `claude_rtl_lead_agent.md`.
  dv_lead's journal grew 240 lines in the commit that sealed the predictions;
  reading it during the blind window is the same hazard as reading the sealed
  file. My charter's read scope includes both and I stayed out on purpose.
- Anything under `test/`, `site/`, `tasks/BOARD.md`, and the other agents' open
  packets: not needed to implement five behavioural specifications.

---

## 2. What is delivered — minimality and fidelity before elegance

Five diffs, one per intent, each **minimal** (the smallest change producing the
described behaviour) and **faithful** (behaving as described, not merely broken
nearby). Where a faithful minimal diff was not achievable I say so rather than
substituting a different defect — packet §2. Three such disclosures exist, all
in §3: **M1**'s reading of "the same error strobes" (§3.1), **M3**'s unavoidable
change to the delivered octet sequence *and* its silence at most lane-4 starts
(§3.3), and **M4**'s two-octet move of a constant to obtain a one-word move of
the bound the intent names (§3.4).

Every diff touches `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else.
Applying one:

```
git worktree add /tmp/m03-M1 6bd7e5a        # or any checkout of 6bd7e5a
git -C /tmp/m03-M1 apply <path>/M1.diff     # the .diff files live at a later
                                            # SHA than 6bd7e5a, so pass a path
                                            # from outside the worktree
```

`git apply --check` results for all five are in §4.

---

## 3. The five mutations

### 3.1 M1 — output latency shifted by one cycle (later)

**Intent as I understood it.** Every output word of every frame appears one
cycle later than the unmutated design emits it, at both start lanes by the same
amount, with the output *content* — the delivered octets and their order, each
word's `tkeep`, the `tlast` word, `tuser`, and the strobe set — unchanged.
Only the cycle index moves. I chose the **later** direction (packet §1 leaves it
to me); earlier is not reachable by a small edit, since the module's two payload
register levels are REQ-019's permitted depth and the third cycle is the lane-4
assembly register — removing any of them changes content, not just timing.

**File and function touched.** `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`,
`create`, the returned `O` record only (the last statement of the function).

**Mechanism, and why it is the intent.** Every leaf output signal is passed
through one additional `reg spec` stage — `tvalid`, `tdata`, `tkeep`, `tlast`,
`tuser` and all five strobes. Because *every* leaf goes through the *same*
single register level, each output word's `(tvalid, tdata, tkeep, tlast, tuser)`
tuple is preserved bit for bit and arrives one cycle later than before; the
sequence of output words is identical and only its absolute cycle index moves.
The shift is **lane-uniform by construction**: the added register sits after all
lane decode, alignment and coverage logic and is a function of nothing —
it cannot distinguish a lane-0-start frame from a lane-4-start one, so it cannot
shift them by different amounts. In SPEC-M03 §7's terms the mutant's ΔC is 4 at
both start lanes instead of 3, and the per-octet constant L is 24 at a lane-0
start and 20 at a lane-4 start instead of 16 and 12 — both moved by exactly one
cycle, the 4-octet-time difference between the lanes preserved.

`tstrb` is deliberately *not* registered: it is the constant `zero 8` in both
designs (REQ-014), and a constant delayed by one cycle is the same constant, so
registering it would add a register without adding behaviour. Under `clear` the
added registers clear to 0 like every other register in the module, so REQ-009's
"`tvalid` = 0 and all five strobes 0 while `clear` is asserted" still holds and
the mutation introduces no second, clear-window defect.

**Disclosure — the strobes.** The intent's content list ends "the same `tuser`,
the same error strobes", which admits a second reading: move the `rx` stream and
leave the five strobes where they are. I rejected it deliberately. SPEC-M03 §9
pins each strobe to *the cycle that frame's `tlast` word is emitted*; moving the
stream while leaving the strobes would break that pin and so introduce a
*second* defect — a strobe-placement defect — on top of the latency shift, which
contradicts the intent's own closing sentence ("only the cycle index at which
each output word appears moves") and would make the result ambiguous, the exact
failure mode packet §2's minimality bar exists to prevent. Under the diff as
written, the mutant is the unmutated design observed one cycle later on every
output port, and every §9 relationship survives intact. If dv_lead intended the
other reading, this mutation is the wrong one and the fix is one line (drop the
`d1` from the five strobe fields) — but it is a different defect and should be
seeded and adjudicated as one.

**Compile confidence: high.** The diff introduces no library surface the file
does not already use: `let d1 s = reg spec s in` is the same `reg spec x` form
used at eleven other sites in `create` (e.g. `let data_d = reg spec i.xgmii_rx.d
in`), so the optional `?enable` erases against the following positional argument
exactly as it does there. `d1` shadows nothing (no such identifier exists in the
file) and is used, so no unused-binding warning is exposed. The record keeps all
six `Axi64.Source` fields and all five strobe fields; the only syntactic change
to the record is that `tvalid`'s field punning becomes an explicit
`tvalid = d1 tvalid`, ordinary record syntax, with the local `tvalid` binding
still live and still consumed. Residual risk: none identified.

**`M1.diff`:**

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -750,19 +750,21 @@
      one-term union and is written as one. *)
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
+  (* M1 MUTATION (WO-0039): one extra register level on every output port. *)
+  let d1 s = reg spec s in
   { O.rx =
-      { Axi64.Source.tvalid
-      ; tdata = al_data_d
-      ; tkeep = keep_of_count keep_count
+      { Axi64.Source.tvalid = d1 tvalid
+      ; tdata = d1 al_data_d
+      ; tkeep = d1 (keep_of_count keep_count)
       ; tstrb = zero 8 (* REQ-014 *)
-      ; tlast = emit_tlast &: ~:(i.clear)
-      ; tuser = emit_tlast &: abort
+      ; tlast = d1 (emit_tlast &: ~:(i.clear))
+      ; tuser = d1 (emit_tlast &: abort)
       }
-  ; error_bad_fcs = strobe sel_bad_fcs
-  ; error_bad_frame = strobe sel_error |: q_strobe 0
-  ; error_runt = strobe sel_runt |: q_strobe 1
-  ; error_oversize = strobe sel_oversize
-  ; error_start_without_terminate = strobe sel_start |: q_strobe 2
+  ; error_bad_fcs = d1 (strobe sel_bad_fcs)
+  ; error_bad_frame = d1 (strobe sel_error |: q_strobe 0)
+  ; error_runt = d1 (strobe sel_runt |: q_strobe 1)
+  ; error_oversize = d1 (strobe sel_oversize)
+  ; error_start_without_terminate = d1 (strobe sel_start |: q_strobe 2)
   }
 ;;
 
```

### 3.2 M2 — the CRC accumulator holds across a lane-4 start's first four frame octets

**Intent as I understood it.** For a frame whose first octet arrives in lane 4,
the FCS accumulator does not consume frame octets 0–3 — the four that share the
second preamble word — but holds its previous value across them and resumes at
octet 4. Lane-0-start frames are untouched. Delivered octet counts, `tkeep`,
`tlast` placement and word timing all unchanged; only the FCS verdict for
lane-4-start frames moves, from good to bad on frames that are in fact
well-formed. This is C-18's first non-instance made into a defect.

**File and function touched.** `create`, the single binding `crc_update`.

**Mechanism, and why it is the intent.** The accumulator is `crc_reg`, updated
through `crc_final = mux2 crc_update crc_out crc_reg` and re-registered as
`crc_reg <== reg spec (mux2 begins (zero 32) crc_final)`. `crc_update` is
therefore precisely the accumulator's enable: with it low and `begins` low, the
register holds. The mutation ANDs it with `~:(cov_first ==:. 4)`.

`cov_first` — the first lane of the current input word carrying an epoch-A frame
octet — takes the value 4 **only** in state `Preamble` with `frame_start4` = 1,
which is exactly the second preamble word of a lane-4 start, the word whose
lanes 4–7 carry frame octets 0–3 (SPEC-M03 §6.1's first C-18 non-instance,
§6.2's `Preamble` row). It is 0 in `Preamble` at a lane-0 start and throughout
`Frame`, and 8 in `Idle` and `Discard`. So exactly one word per lane-4-start
frame is gated, no word of a lane-0-start frame is gated, and every later word
of the lane-4 frame updates normally from the held value — "holds across octets
0–3 and resumes from octet 4", stated in the design's own signals. The very same
expression `cov_first ==:. 4` already appears one line above, where it selects
the shifted octets for M02, which is what makes the site exact rather than
approximate.

**Why the verdict actually flips, and not merely for some frames.** M02 carries
*finished* CRC values, with 0x00000000 as the identity (ADR-0006;
`crc32_eth.ml` lines 13–20 and 93–97: `register_in = crc_in ^: 0xffffffff`), so
seeding the accumulator with zero starts REQ-301's internal register at
0xFFFFFFFF, not at zero. Dropping the first four covered octets therefore
changes the final value for *any* four octets — all-zero ones included, which a
zero-initialised CRC would have absorbed silently — so the frame's residue is no
longer REQ-304's 0x2144DF1C and `bad_fcs = has_fcs &: (crc_final <>: residue)`
goes true. `tuser`[0] is set on the `tlast` word and `error_bad_fcs` pulses once,
on the cycle §9 already pinned. (A frame whose skipped-octet residue lands back
on 0x2144DF1C would be a coincidence of the frame's own content, not a class.)

**What provably does not move.** `crc_update` has exactly one consumer,
`crc_final`. Coverage (`cov`, `cov_count`, `cov_end`), the received-octet count,
`has_fcs`, the closure record's other six bits, the alignment window, `keep_count`
and every emit decision are computed without it, so delivered octets, `tkeep`,
`tlast` placement, word timing and the four other strobes are untouched. Frames
that close *inside* the gated word deliver at most three octets, so `count_next`
is under `fcs_min_octets` and `has_fcs` is 0: §9's ninth ruling still holds and
no new `error_bad_fcs` appears in that class.

**Compile confidence: very high.** The added subexpression is copied verbatim
from line 440 of the same function. `&:` and `~:` appear at ~30 sites in the
file. Both operands are parenthesised, so no precedence question arises (`&:`,
`==:.` and `<>:.` are all at OCaml's `=…/<…/>…/|…/&…/$…` infix level and
left-associative — the parse is forced either way). `cov_first` is bound at line
298, well above line 447. No binding is added or removed.

**`M2.diff`:**

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -444,7 +444,10 @@
       { Crc32_eth.I.crc_in = crc_reg; data = crc_data; octet_count = cov_count }
   in
   let crc_out = crc.Crc32_eth.O.crc_out in
-  let crc_update = cov_count <>:. 0 in
+  (* M2 MUTATION (WO-0039): hold the CRC accumulator across a lane-4 start's
+     first four frame octets. [cov_first] = 4 is exactly that word — the second
+     preamble word of a lane-4 start, SPEC-M03 §6.1's first C-18 non-instance. *)
+  let crc_update = (cov_count <>:. 0) &: ~:(cov_first ==:. 4) in
   (* The value the residue is compared against is the one *after* this word's
      update, because §6.1 item 3 runs the coverage through the octet
      immediately preceding the terminate character — which is in this word. *)
```

### 3.3 M3 — `tkeep` derived from the terminating input word instead of the frame

**Intent as I understood it.** The final output word's `tkeep` is computed from
*which lanes of the terminating XGMII input word carry frame octets* rather than
from *how many frame octets remain to be delivered*. In this implementation the
first quantity is `cov_count` on the cycle the frame closes: in `Frame`,
`cov_first` is 0 and coverage stops at the closing character's lane, so
`cov_count` is the count of that input word's frame-octet lanes — and those
lanes are 0 … j−1 for a terminate character in lane j, contiguous from bit 0, so
the count and the lane *mask* are the same object here and REQ-011's contiguity
survives.

**File and function touched.** `create`: the closure record's field list, its
two ageing wires and masks, one new selector, and the `keep_count` expression.

**Mechanism, and why it is the intent.** The quantity must reach the emit cycle,
which is one or two cycles after the closing word. The design already carries
per-closure facts across exactly that gap in its ageing closure record
(`r0` → `r1` → `r2`, selected oldest-first as `sel`), and the unmutated `strip`
— the four-octet FCS removal — is read from it. So the mutation widens that
record from 7 bits to 11, appending `cov_count` at bits 10:7, and reads it back
through **the same `sel`**. That is the whole of the mechanism, and it is chosen
so that the mutant inherits the unmutated design's own record-to-word
association: it introduces no new alignment assumption that could turn a `tkeep`
defect into a timing defect.

`keep_count` then becomes `mux2 (emit_tlast &: sel_valid) sel_cov pc`. Non-final
words are unaffected (they take `pc`, as before). The `sel_valid` conjunct is not
a second behaviour: every genuine final word already requires `sel_valid` (it is
what `strip` and `consume` require), so the guard is true whenever the
substitution applies, and it exists only so that a word emitted with no live
record — a state conformant stimuli do not reach — keeps its unmutated `tkeep`
instead of reading a stale count. That keeps the mutation to exactly one defect.

**What does not move.** `keep_count` has exactly one consumer,
`tkeep = keep_of_count keep_count`. `tvalid`, `tlast`, `tuser`, the FCS verdict,
the five strobes, the emit decisions, `fcs_tail_pending` and word timing are all
computed without it and are bit-identical to the unmutated design.

**Disclosure 1 — the delivered octet sequence does change.** Packet §2 asks for
it to be preserved "if that is achievable minimally"; it is not achievable at
all, because on this stream `tkeep` *is* what "delivered" means. Worked examples
at a lane-0 start, with `/T/` in lane j and D delivered octets:

| frame | j | unmutated final `tkeep` | mutant final `tkeep` | effect |
|---|---|---|---|---|
| 64 octets (D = 60) | 0 | `0x0F` (4 octets) | `0x00` (0 octets) | 4 octets lost; an empty `tlast` word |
| 68 octets (D = 64) | 4 | `0xFF` (8) | `0x0F` (4) | 4 octets lost |
| 71 octets (D = 67) | 7 | `0x07` (3) | `0x7F` (7) | 4 **FCS** octets delivered |

The pattern is exact and is the intent's own arithmetic: at a lane-0 start
D ≡ j − 4 (mod 8), so the mutant's count is the true one plus four, modulo the
word — "the input word's occupied lanes include the four FCS octets".

**Disclosure 2 — the mutant is silent on most lane-4-start frames.** At a
lane-4 start frame octet p sits in lane (p + 4) mod 8, so the terminate lane
satisfies D ≡ j (mod 8): the frame's four-octet realignment offset cancels the
four FCS octets exactly, and *the two derivations agree*. The mutant therefore
changes nothing for a lane-4-start frame terminating in lanes 1 … 7, and changes
`0xFF` to `0x00` for one terminating in lane 0. This is a property of the defect
the intent describes, not of my encoding of it — deriving `tkeep` from the
terminating input word genuinely is the correct answer at a lane-4 start except
in lane 0 — and I state it because it changes how a result reads: a mutation
that only speaks at one start lane and at one terminate lane of the other is a
narrower probe than its one-sentence description suggests.

**Compile confidence: high** — the largest surface of the five, so the widths,
one by one. `record_fields` gains a labelled `~cov` and `concat_lsb` accepts
mixed widths, giving 7 + 4 = 11 bits with `cov` at 10:7 (`concat_lsb` puts its
first element at the LSB, so the seven existing bits keep their indices and
`valid_of`, `bit sel 1 … 6` are untouched). `r1`/`r2` become `wire 11` to match
what is driven onto them; the two ageing masks become `repeat … 11` so both
operands of `&:` are 11 bits. `select sel 10 7` yields 4 bits and uses the same
positional argument order as the existing `select window 11 4` (line 671) and
`select xgmii.d ((8*k)+7) (8*k)` (line 186). `pc` is 4 bits — proved by the
unmutated `pc -: strip` with `strip = of_int ~width:4 4` — so `mux2 … sel_cov pc`
has equal-width arms, and `emit_tlast` and `sel_valid` are both one bit.
`emit_tlast` and `sel_valid` are both bound above the new `keep_count` (lines
732 and 528 of the original). No binding falls out of use: `strip`, `nc`,
`emit_last_a` and `emit_last_b` are all still read by the emit guards and by
`fcs_tail_pending`, so no unused-binding warning is exposed. Residual risk: the
4-bit `cov` field is written unconditionally, so an *invalid* record can carry a
non-zero count; that is why the read is guarded by `sel_valid`.

**`M3.diff`:**

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -500,8 +500,11 @@
      latest. Consumptions therefore never contend, and each record is at age 2
      exactly when its turn comes. *)
   let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
-  let record_fields ~valid ~terminate ~error ~start ~oversize ~fcs ~runt =
-    concat_lsb [ valid; terminate; error; start; oversize; fcs; runt ]
+  (* M3 MUTATION (WO-0039): the closure record additionally carries [cov_count]
+     of the closing word — how many lanes of the terminating input word carry
+     frame octets — in bits 10:7. *)
+  let record_fields ~valid ~terminate ~error ~start ~oversize ~fcs ~runt ~cov =
+    concat_lsb [ valid; terminate; error; start; oversize; fcs; runt; cov ]
   in
   let r0 =
     record_fields
@@ -512,19 +515,20 @@
       ~oversize:a_close_oversize
       ~fcs:(a_close_terminate &: bad_fcs)
       ~runt:a_close_runt
+      ~cov:cov_count
   in
   (* [consume] is defined by the output decision below; the two are mutually
      recursive through one cycle of register, so the wire is declared here. *)
   let consume = wire 1 in
-  let r1 = wire 7 in
-  let r2 = wire 7 in
+  let r1 = wire 11 in
+  let r2 = wire 11 in
   let valid_of r = bit r 0 in
   let sel_is_r2 = valid_of r2 in
   let sel_is_r1 = valid_of r1 &: ~:sel_is_r2 in
   let sel_is_r0 = ~:sel_is_r2 &: ~:sel_is_r1 in
   let sel = mux2 sel_is_r2 r2 (mux2 sel_is_r1 r1 r0) in
-  r1 <== reg spec (r0 &: ~:(repeat (consume &: sel_is_r0) 7));
-  r2 <== reg spec (r1 &: ~:(repeat (consume &: sel_is_r1) 7));
+  r1 <== reg spec (r0 &: ~:(repeat (consume &: sel_is_r0) 11));
+  r2 <== reg spec (r1 &: ~:(repeat (consume &: sel_is_r1) 11));
   let sel_valid = valid_of sel in
   let sel_terminate = bit sel 1 in
   let sel_error = bit sel 2 in
@@ -532,6 +536,7 @@
   let sel_oversize = bit sel 4 in
   let sel_bad_fcs = bit sel 5 in
   let sel_runt = bit sel 6 in
+  let sel_cov = select sel 10 7 in
   (* ---- the second report path: an epoch opened *and* closed in one word ----
      Such a frame delivers no octet — its eight preamble octets fill the rest of
      the word — so §9 pins its report to exactly two cycles after this one, with
@@ -730,9 +735,10 @@
   fcs_tail_pending <== emit_last_b;
   let emit_full = have_word &: (nc >: strip) in
   let emit_tlast = emit_last_a |: emit_last_b in
-  let keep_count =
-    mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
-  in
+  (* M3 MUTATION (WO-0039): the frame's final word takes its [tkeep] from the
+     terminating input word's own covered-lane count, carried in the closure
+     record, instead of from how many frame octets remain to be delivered. *)
+  let keep_count = mux2 (emit_tlast &: sel_valid) sel_cov pc in
   let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
   let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
   consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
```

### 3.4 M4 — the maximum-words-per-frame limit reduced by one

**Intent as I understood it.** Reduce M03's per-frame output-word bound by
exactly one, from 190 words to 189, so that a frame requiring 190 words is
truncated or aborted at the boundary while a frame requiring 189 or fewer still
completes normally.

**File and function touched.** The module-level constant `oversize_threshold`
(no function).

**Mechanism, and why it is the intent — including where the boundary lands.**
M03 has no output-word counter and no word constant: the 190-word bound of
REQ-015/REQ-108 is a *consequence* of the received-octet cap. `cap_room =
oversize_threshold -: count` caps this word's coverage; a frame whose received
count would pass the threshold is closed at the cap (`a_close_oversize`, one
`error_oversize`, `tuser`[0] on `tlast`) and delivers threshold − 4 octets, while
a frame reaching the threshold *exactly* still terminates normally, because the
cap binds only when `cap_end <: a_char_end`. The bound in words is therefore
⌈(threshold − 4) / 8⌉.

1514 delivered octets = 189 × 8 + 2 → **190** words; 1512 = 189 × 8 → **189**
words. Both 1513 and 1514 delivered octets need a 190th word, so the *word*
bound falls by exactly one iff the *octet* cap falls by two. Hence 1518 → 1516,
and the boundary lands here:

- received ≤ 1516 → terminates normally, ≤ 1512 delivered, ≤ 189 words, no
  `error_oversize` (the 1516-octet frame is the new maximum and is silent);
- received ≥ 1517 → truncated at 1516 received → **1512 delivered, 189 words**,
  `tuser`[0] = 1 on `tlast`, one `error_oversize`.

So the maximum legal Ethernet frame — 1518 octets, 1514 delivered, 190 words,
which the unmutated module forwards whole and silent — is truncated by four
octets and marked bad. **Disclosure**: the "reduce by one" of the intent is a
one-word move, obtained by a two-octet move of the constant. I considered and
rejected 1518 → 1517 as the literal "minus one" edit: it leaves 1513 delivered
octets, which still requires a 190th word, so the bound the intent names would
not have moved at all.

**What does not move.** `oversize_threshold` has exactly one consumer,
`cap_room`. `count_bits` = 11 (2047) still holds 1516 + 8 without aliasing, so
the counter cannot wrap an oversize frame into a runt. `runt_threshold`,
`fcs_min_octets`, the residue check and every strobe path are untouched. Note
that the mutant never *exceeds* the unmutated bound — it only stops short of it
— so it is not a REQ-015 protocol violation; it is a false `error_oversize` and
a four-octet under-delivery at the top of the length range.

**`M4.diff`:**

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -139,7 +139,9 @@
    delivered, which this design obtains by capping coverage at 1518 and
    letting the four-octet tail removal run — see the truncation comment in
    {!create}. *)
-let oversize_threshold = 1518
+(* M4 MUTATION (WO-0039): 1518 -> 1516, which moves the per-frame output-word
+   bound from 190 words (1514 delivered octets) to 189 (1512). *)
+let oversize_threshold = 1516
 
 (* The received-octet counter must hold [oversize_threshold] + 8 without
    wrapping — the count is advanced by up to eight octets per cycle and is
```

### 3.5 M5 — re-introduce BUG-0001's over-delivery at k > 4

**Intent as I understood it.** Restore the convicted defect: for a frame
delivering D octets, with k = ((D − 1) mod 8) + 1 the octet count of its final
output word, the mutant emits max(0, k − 4) octets beyond D — nothing extra when
the final word holds four or fewer delivered octets, one to four extra when it
holds five to eight. Nothing else moves.

**Implementation: a revert, as the packet prefers.** I reverted rtl_lead's fix
hunk rather than re-deriving the defect. The reverted hunk is the RTL half of
commit `0b64b68` ("BUG-0001 root cause and fix: consume disarms the strip guard
— one fcs_tail register suppresses the residual all-FCS word",
`J-rtl_lead-0007`), quoted here from `git show 0b64b68` as the packet requires:

```
-  let have_word = pc <>:. 0 in
+  let fcs_tail_pending = wire 1 in
+  let fcs_tail_now = reg spec fcs_tail_pending in
+  let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
   let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
   let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
+  fcs_tail_pending <== emit_last_b;
```

M5 undoes exactly those four added lines and restores exactly that removed one.
(The same commit also added a large explanatory comment above the hunk and a
paragraph to the module docstring; I left both in place. They are comment text,
cannot affect elaboration, and reverting them would have enlarged the diff
without changing behaviour. The comment now describes a register the mutant does
not contain — which is a second, harmless marker that a tree is mutated.)

**Mechanism, and why the excess is exactly max(0, k − 4).** The fix's own
comment states the failure and I re-derived it from the signals rather than
taking it on trust. `emit_last_b` is the straddling case: the emitted word
carries `pc` octets and the word behind it carries `nc` ∈ 1 … 4 octets that are
all FCS, all four of which are accounted for in the emitted word's own
`keep_count = pc − strip + nc`, which is why that word carries `tlast`. On the
*next* cycle that residual word arrives at the same decision as `pc` = nc with
`nc` = 0 behind it; the closure record was consumed on the `tlast` cycle, so
`strip` is now 0, `emit_last_a`'s guard `pc >: strip` reads pc > 0 instead of
pc > 4, and the residual word goes out as a second `tlast` word with `tuser` = 0
and no strobe. Its fill is `nc`. Tracing the four reachable shapes:

- lane-0 start, N ≡ r (mod 8) received octets: r = 0 → `emit_last_a`, k = 4, no
  residual (excess 0); r = 1 … 4 → `emit_last_b` with nc = r, k = 4 + r, excess
  r = k − 4; r = 5 … 7 → `emit_last_a`, k = r − 4 ≤ 3, no residual (excess 0).
- lane-4 start, terminate lane j: j = 0 → `emit_last_b` with nc = 4, k = 8,
  excess 4 = k − 4; j = 1 … 4 → `emit_last_a`, k = j ≤ 4, excess 0; j = 5 … 7 →
  `emit_last_b` with nc = j − 4, k = j, excess j − 4 = k − 4.

In every case the excess is max(0, k − 4), at both start lanes, which is
BUG-0001's invariant as the packet states it — arrived at from the RTL, and then
found to agree.

**What does not move.** `fcs_tail_now` had exactly one consumer (`have_word`)
and `fcs_tail_pending` exactly one driver, so removing them leaves `emit_last_a`,
`emit_last_b`, `emit_full`, `emit_tlast`, `keep_count`, `consume`, `strip`,
`abort` and every strobe path textually identical. Word timing is unchanged; the
`tlast` of the extra word is the only new `tlast`, which is what the extra octets
themselves imply; no strobe pulses for it, because `consume` fired on the
previous cycle.

**Compile confidence: as near certain as this campaign can get.** With comments
stripped, the M5 mutant's source is **identical, line for line, to the module at
`0b64b68^` = `47fcfda`** — the tree BUG-0001 was raised against, which CI built
and ran (the defect was found by test results, which presupposes a successful
build). Reproduce:

```
git show 0b64b68^:libs/hardcaml_ethernet/src/xgmii_rx_64.ml > /tmp/prefix.ml
# strip comments and blank lines from both, then diff -> empty
```

**`M5.diff`:**

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -722,12 +722,11 @@
      still reports on its pinned cycle whether or not a word goes out. Frames
      ended by REQ-105, REQ-110 or `clear` never set it, because [strip] is 0
      for them and [emit_last_b] needs [nc] <= [strip] with [nc] >= 1. *)
-  let fcs_tail_pending = wire 1 in
-  let fcs_tail_now = reg spec fcs_tail_pending in
-  let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
+  (* M5 MUTATION (WO-0039): BUG-0001 restored — the fix hunk of 0b64b68 is
+     reverted, so nothing suppresses the residual all-FCS word. *)
+  let have_word = pc <>:. 0 in
   let emit_last_a = have_word &: (nc ==:. 0) &: (pc >: strip) in
   let emit_last_b = have_word &: (nc <>:. 0) &: (nc <=: strip) in
-  fcs_tail_pending <== emit_last_b;
   let emit_full = have_word &: (nc >: strip) in
   let emit_tlast = emit_last_a |: emit_last_b in
   let keep_count =
```

---

## 4. Self-check results

Every check below was run on a scratch copy. **The repository working tree was
not modified**: nothing under `libs/`, `test/` or any path outside
`docs/reports/audit/` was touched, and no `git commit` was run (PROTOCOL §2, §6).

**(a) Base identity.** `git show 6bd7e5a:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
is byte-identical to the working tree's copy at `0d231ee`
(sha256 `3d87515a843d98d7d5bd6692a9d19cdbe2b0dee4e430c88f871a2d4887f5be92`,
772 lines), and `git diff --stat 6bd7e5a HEAD -- libs/` is empty. Every diff was
generated against that blob.

**(b) `git apply --check`.** Each diff was checked against a fresh copy of the
`6bd7e5a` blob, then applied, and the result compared with the mutant source it
was generated from:

| Mutation | `git apply --check` | applies to a byte-identical result | files in patch | changed lines (±) | of which code |
|---|---|---|---|---|---|
| M1 | CLEAN | yes | 1 | 22 | +11 / −10 |
| M2 | CLEAN | yes | 1 | 5 | +1 / −1 |
| M3 | CLEAN | yes | 1 | 24 | +9 / −9 |
| M4 | CLEAN | yes | 1 | 4 | +1 / −1 |
| M5 | CLEAN | yes | 1 | 7 | +1 / −4 |

The last column excludes the `MN MUTATION (WO-0039)` marker comments, which are
the balance of every count and cannot affect elaboration.

**(c) Single-file, minimum-necessary.** Every patch names exactly one `+++`
path, `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`. Each mutant was produced by
exact-string substitution with a script that aborts unless each pattern matches
**exactly once** in the pristine source, so no edit landed twice and none landed
silently nowhere.

**(d) Syntax check — and its limits.** ADR-0005 stands: no Hardcaml line is
installable on this container (the `fpga` opam switch contains `dune` and
nothing else; OCaml is 4.14.1), so **I cannot compile and did not**. What I
could do is parse. Each mutant source, and the pristine control, was run through
`ocamlc -stop-after parsing -c` — which checks *syntax only*, does no type
checking, and needs no `ppx_hardcaml`, since `[@@deriving hardcaml]` is a
well-formed attribute at parse time. All six exit 0. To prove the instrument is
not vacuous — the very complaint this campaign exists to answer — I ran two
negative controls: an unbalanced parenthesis in M5's `have_word` and a dropped
`in` after M3's `sel_cov`. Both were rejected with an exit code of 2 and a
located error.

**This is not gate evidence and is not offered as any.** ADR-0005 makes CI the
authoritative build environment; a local parse says nothing about types, widths
or elaboration. The width and scope arguments in §3 are the actual basis of my
compile-confidence claims, and they are reasoning, not measurement. Per packet
§1 bar 5, if a diff fails to build I may repair it to compile and change nothing
else, disclosing the repair — that clause is the safety net for exactly this
gap.

**(e) What I did not check.** Behaviour. I have run no simulation, no test and
no elaboration of any of the five mutants, and I have seen no result of any kind
for any of them. Packet §3's closing sentence is structural here and not a
courtesy.

---

## 5. Open questions for dv_lead and the orchestrator

1. **M1's strobes** (§3.1). I delayed the strobes with the stream, on the
   reading that §9 pins strobes to the `tlast` cycle and that leaving them
   behind would be a second defect. If the intent was stream-only, M1 as
   delivered is the wrong mutation and should be re-seeded, not reinterpreted
   after its result.
2. **M3's reach** (§3.3, disclosure 2). The defect the intent describes is, at a
   lane-4 start, *correct* for every terminate lane but lane 0. Adjudicating M3
   as one mutation may therefore under-report: it is effectively a lane-0-start
   probe with one lane-4 instance. If a lane-symmetric `tkeep` defect is wanted,
   that is a different intent and I would need it stated.
3. **M4's constant** (§3.4). I moved the octet cap by two to move the word bound
   by one. If the intent was the octet constant minus one (1517), the word bound
   does not move and the mutation is a different one; say so and I will re-seed.
4. **A note on my own independence.** I authored these mutations from SPEC-M03
   and the RTL alone. I have never read this module's bench, and after this
   campaign I still have not. The symmetry packet §1 names is intact in both
   directions as far as my own conduct can establish it — and the only evidence
   for that is this section and my journal's `Inputs`, which is the honest
   enforcement my charter §9 says it is.
