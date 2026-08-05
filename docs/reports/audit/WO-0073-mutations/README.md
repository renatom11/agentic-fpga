# WO-0073 — the family-L mutation campaign: five classes, five diffs, seeded blind

**Packet**: `agents/handoffs/WO-0073_family-l-mutation-campaign.md`, frozen with its
sealed companion at `bbd4122`.
**Author**: auditor. **Spawn short-id**: `WO-0073-SEED-2/2026-08-09T21:15Z`
(respawn; the prior seeding spawn died mid-round in a tool outage and left no
branch and no file — verified at §10.4 below before anything was cut).
**Binding**: `R-DISC-1` and `R-DISC-2` (`DISP-0001` §4, `docs/reports/audit/WO-0061-mutations/DISP-0001_A-1.md`
lines 280–314). **Delivery order**: IC-L1, IC-L2, IC-L3, IC-L4, IC-L5 (§10.2 of
the packet), each on its own branch, each a single independent diff.

This file is the whole manifest. The five diffs are quoted inline rather than
shipped as sibling blobs, because the round's `Files-in-this-commit` is fixed at
the manifest alone; the authoritative copy of each diff is its transient branch,
recoverable as `git diff bbd4122 mut/wo-0073-l<N>`.

---

## 0. Blinding conduct, declared affirmatively

The packet's §7 allowlist is absolute. **What I read, and nothing else:**

| | path | what for |
|---|---|---|
| 1 | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (1011 lines) and `libs/hardcaml_ethernet/src/xgmii_rx_64.mli` (45 lines), at the base tree | the mutation target; every line number in this manifest is that file's |
| 2 | `docs/specs/requirements.md` — the rows REQ-005, REQ-011, REQ-014, REQ-015, REQ-019, REQ-020, REQ-021, REQ-103, REQ-107, REQ-111, REQ-112, and REQ-004 via the packet's own quotation | the ground of each class |
| 3 | `docs/specs/modules/xgmii_rx_64.md` §7 (the timing contract, lines 803–879) and §8 (the line-rate stress obligation, lines 881–928) | ΔC, L, h, and the stimulus geometry |
| 4 | `agents/handoffs/WO-0073_family-l-mutation-campaign.md` — this packet | |
| 5 | `docs/reports/audit/**` — my own tree: `WO-0061-mutations/DISP-0001_A-1.md` §4 for the two binding rules, and the section headings (not the bodies) of `WO-0066-mutations/README.md` for the manifest's shape | |
| 6 | `agents/charters/auditor.md`, `agents/PROTOCOL.md` | my own mandatory first actions, which precede the campaign and are not campaign inputs |

**What I did not read, and did not open at any point:**

- **The sealed companion `WO-0073_family-l-mutation-campaign-SEALED-predictions.md`.**
  It exists in the tree at `bbd4122` — it is one of the three paths that commit
  added — and I did not open it, grep it, `git show` it, or read any excerpt of
  it. Its name appears in this manifest only because the packet names it.
- **All of `test/**`** — `test/xgmii_rx_64/test_m03_l.ml`, `bench.ml`/`bench.mli`,
  `test/monitors/`, `test/xgmii/`, `test/golden/`, `test/cosim/`, the dune files,
  and **`test/attack_plans/AP-xgmii_rx_64.md`**, which is barred by name because
  the five classes are quoted from its Kills cells. I have not read a single byte
  under `test/` in this spawn. Every prediction below is derived from the RTL and
  the specification; where I name a unit's behaviour I am quoting the packet's own
  §3/§4, which is freely told.
- **All of `agents/**` except the packet and my two mandatory charter documents.**
  No journal — not dv_lead's, not rtl_lead's, not the orchestrator's, not the
  worker journals. My own journal is appended to, not read for campaign content.
- No `RV-`, `SO-`, `BUG-` or `WO-` packet other than `WO-0073`. Where this
  manifest cites `WO-0066`, `WO-0070`, `WO-0072`, `BUG-0003` or `RV-0070/0071/0072`,
  it is quoting **the WO-0073 packet's own citation of them**, never those files.

**Ambient exposure, disclosed unprompted.** Three items reached me without my
opening a barred file, and I record them so the adjudicator can discount them.
(i) The packet quotes two Kills cells verbatim (`M03-L1`'s and `M03-L5`'s), so I
know those two sentences of the attack plan; that is the packet's own doing and
its §16 lists them as freely told. (ii) `git status`/`git show --stat` at `bbd4122`
told me the commit staged three paths, one of which is the seal — a file name, no
content. (iii) The mutation target's own comments cite `BUG-0001`, `BUG-0002`,
`BUG-0003` and rulings by SHA; those are RTL comments inside the allowlist.

Nothing in this manifest was chosen against a written expectation. Each class's
diff was chosen against the sentence of the specification the packet names for it.

---

## 1. The base SHA — verified rather than accepted, and it does not agree

**§7 item 6 requires me to quote the base SHA I applied to and confirm it matches
§8's. It does not, and §8 says that disagreement is "a finding *before* the
campaign runs, not after". Here it is, before the campaign runs.**

### FINDING WO-0073-M1 — MINOR — the packet's §8 base SHA and the operating base SHA are different commits (materially void)

- **What §8 says**: *"The base SHA is the commit that this packet's own commit
  immediately follows — the parent of the commit staging this packet and its
  seal."*
- **The commit staging the packet and its seal** is `bbd4122cb37f7481f6dd8bf34676c31a0a19899e`
  (`dv_lead`, `J-dv_lead-0133`, three paths: the packet, the seal, dv_lead's
  journal).
- **Its parent** — and therefore §8's literal base SHA — is
  `8acd28df5e83e99953816c79d160b41eb1e3a447` (*"Site: the bench era's close is on
  the page…"*).
- **The base SHA I applied to**, as dispatched by the campaign operator, is
  **`bbd4122cb37f7481f6dd8bf34676c31a0a19899e`**. All five branches are cut from
  it; every line number in this manifest is `bbd4122`'s.

**Why I recorded it and proceeded rather than stopping.** The two commits carry
**the same tree for every path this campaign scores**:

```
$ git diff --stat 8acd28d bbd4122 -- libs/ test/ tools/ docs/specs/
(empty)
$ git diff --name-status 8acd28d bbd4122
A  agents/handoffs/WO-0073_family-l-mutation-campaign-SEALED-predictions.md
A  agents/handoffs/WO-0073_family-l-mutation-campaign.md
M  agents/journals/claude_dv_lead_agent.v05.md
```

`libs/**`, `test/**`, `tools/**` and `docs/specs/**` are byte-identical at the two
SHAs. §8's adjudicator-ordering rule — *"every `test/**` byte this campaign scores
against is at or before the base SHA"* and *"nothing under `test/**` moves again
until the campaign scores"* — holds identically under either reading, and the
control run's result is the same tree's result either way. **The disagreement is
therefore a naming disagreement with zero bytes behind it**, and stopping the
round for it would cost five CI runs to change nothing measurable.

**What the adjudicator must do with it**: read every §8 reference to "the base
SHA" as `bbd4122`, and take the control run from `bbd4122`'s own CI run. If dv_lead
holds that the seal is keyed to `8acd28d` in a way that a tree identity does not
discharge, this finding is the notice, and it was filed before the first transient
was cut. **Q1 in §11.**

---

## 2. The stimulus geometry, derived from the specification and the RTL only

Every cycle number below is derived from SPEC-M03 §8 (the stress stimulus and its
*"start-to-start spacing alternating 10 and 11 cycles"*), REQ-004 (the 12-octet
gap counted from the terminate character inclusive), SPEC-M03 §7 (ΔC = 3 at both
lanes), and a cycle-by-cycle trace of `create` at `bbd4122`. It is **not** taken
from the packet's §1, which states the same geometry; agreeing with it
independently is the point.

Let frame index `j = 0 … 9999`, `k = 0 … 4999`.

| | even frame `j = 2k` | odd frame `j = 2k+1` |
|---|---|---|
| start character | cycle **1 + 21k**, lane **0** | cycle **11 + 21k**, lane **4** |
| front offset h | **8** octet times | **12** octet times |
| preamble | lanes 0…7 of 1+21k | lanes 4…7 of 11+21k, lanes 0…3 of 12+21k |
| frame octets 0…63 | cycles 2+21k … 9+21k, eight full words | 12+21k lanes 4…7, then 13+21k … 19+21k, then 20+21k lanes 0…3 |
| terminate character | cycle **10 + 21k**, lane **0** | cycle **20 + 21k**, lane **4** |
| gap to the next start | lanes 1…7 of 10+21k (7) + lanes 0…3 of 11+21k (4) + the terminate itself = **12** ✓ | lanes 5…7 of 20+21k (3) + all of 21+21k (8) + the terminate itself = **12** ✓ |
| words between terminate and next start | **none — the two words are adjacent** | **exactly one**, the all-idle word 21+21k |
| output words 0…7 (ΔC = 3) | cycles **4+21k … 11+21k** | cycles **14+21k … 21+21k** |
| the `tlast` word | word 7 at **11 + 21k**, `tkeep` = 0x0F, 4 delivered octets | word 7 at **21 + 21k**, `tkeep` = 0x0F |
| delivered octets | 60 (64 received − REQ-103's four FCS octets) | 60 |

**Two coincidences this schedule manufactures, and they are the campaign's two
geometric classes:**

1. **Cycle 11 + 21k is an odd frame's start word and its predecessor 10 + 21k is
   an even frame's terminate word.** ⇒ IC-L1's condition, 5 000 instances, on the
   **odd** frames.
2. **Cycle 11 + 21k is also the cycle the *even* frame's word 7 is emitted**
   (1 + 21k + 7 + 3 = 11 + 21k). ⇒ IC-L4's condition, 5 000 instances, on the
   **even** frames.

The two fire on the **same cycle set** and on **different frames, through
different gates**. That is the whole of the answer to dv_lead's pre-run question
(§9.1).

Start-to-start check: (11+21k) − (1+21k) = **10**; (22+21k) − (11+21k) = **11**.
Alternating 10 and 11 ✓ (SPEC-M03 §8, REQ-004).

**The eighteen directed runs (SPEC-M03 §8's last paragraph, REQ-005, REQ-103)** —
lengths 64…71 and 1518, at both start lanes, each a single frame with nothing
before or after it. Delivered = received − 4:

| received | 64 | 65 | 66 | 67 | 68 | 69 | 70 | 71 | 1518 |
|---|---|---|---|---|---|---|---|---|---|
| delivered | 60 | 61 | 62 | 63 | 64 | 65 | **66** | 67 | **1514** |
| delivered residue mod 8 | 4 | 5 | 6 | 7 | 0 | 1 | **2** | 3 | **2** |
| received residue mod 8 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 6 |
| `tlast` word arm | `emit_last_a` | `_b` | `_b` | `_b` | `_b` | `_a` | `_a` | `_a` | `_a` |
| `tlast` word extent | 4 | 5 | 6 | 7 | 8 | 1 | **2** | 3 | **2** |

The arm follows from lines 959–960: `emit_last_a` needs `nc = 0` and `pc > strip`,
which is received residue ∈ {5,6,7,0} ⟺ delivered residue ∈ {1,2,3,4};
`emit_last_b` needs `1 ≤ nc ≤ strip = 4`, which is received residue ∈ {1,2,3,4} ⟺
delivered residue ∈ {5,6,7,0}. **`keep_count` (972–974) equals the delivered octet
count modulo 8 for every frame**, because a word of fewer than eight octets is
always the frame's last (REQ-011; the design says so itself at lines 790–794).

---

## 3. The five diffs

Each applies alone to `bbd4122`, elaborates, and reverts cleanly (§10.2). **No
diff combines two classes.** IC-L2 and IC-L5 edit the same *site* — the output
port record, lines 989–1005 — and are nevertheless two entirely separate diffs on
two separate branches; a reader comparing them will see the same hunk header and
must not read that as a combination (**Q4**).

| class | branch | commit | site (base line) | one-line rendering |
|---|---|---|---|---|
| IC-L1 | `mut/wo-0073-l1` | `8fe0251404f569bef9a6f5cbda190a5a864be496` | `begins`, **430** | a start character is refused if the previous input word carried a terminate character |
| IC-L2 | `mut/wo-0073-l2` | `e24e5230faba5118e97dbb392c0ae91661d722d5` | the output record, **989–1005** | one unconditional register level on the whole `O` record: ΔC = 4 |
| IC-L3 | `mut/wo-0073-l3` | `60ed49cc885bc759590c57ccf29889a19824e1ce` | `l3_block` → `decided` **958**, `r1`/`r2` **526–527**, `consume` **977** | the `tlast` word waits one cycle when its delivered extent is 2 |
| IC-L4 | `mut/wo-0073-l4` | `22b538f7e6702e705296dbc869ed40b9a679f8cd` | `have_word`, **831** | no output word leaves on a cycle that accepts a start character |
| IC-L5 | `mut/wo-0073-l5` | `806d3d5652772aab36731e680d3f756775085a3f` | the output record, **989–1005** | the final word is re-presented, with `tlast`, on the next cycle |

**One branch carries two commits and the adjudicator must read the tip.**
`mut/wo-0073-l3` is `c66565dae3a5689f1596ff40771da8a83364fda8` followed by
`60ed49cc885bc759590c57ccf29889a19824e1ce`. The first commit's rendering was
**defective and is superseded**: it held only `r2`, which is enough for the
lane-**0** members of R (their closure record is at age 2 when the `tlast` word is
due) and **not** for the lane-**4** members (age 1), where the deferred word would
have been stranded — word loss, not a one-cycle delay, and therefore not the
class. I found it while discharging §4's per-lane obligation, before any scorecard
existed. I could not amend the branch: `git push --force-with-lease` was **refused
by repository rules** (`! [remote rejected] … (push declined due to repository rule
violations)`), which is PROTOCOL R9's no-force-push guarantee holding on transient
refs as well as on `main` and the working branch — reported here as a fact of the
round, and a good one. **The correction therefore landed as a fast-forward second
commit.** The net diff `bbd4122..60ed49c` is the single minimal rendering quoted
below; `c66565d`'s CI run, if one exists, scores nothing and must be discarded.
**Q2 in §11.**

### IC-L1 — `mut/wo-0073-l1` — the receiver needs a cycle to re-arm between frames

Branch **A** (adjacency) and branch **D** (drops the frame). Ground: REQ-004's
*"dropping no frame and losing no word"*.

```diff
@@ -427,7 +427,12 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      and both close epoch A. *)
   let survivor_b = b_exists &: ~:(any b_closing) in
   let survivor_c = c_exists &: ~:(any c_closing) in
-  let begins = survivor_b |: survivor_c in
+  (* MUTATION IC-L1 (branch A / branch D) -- never merge.
+     The receiver needs a cycle to re-arm: a start character standing in an
+     input word whose immediate predecessor carried a terminate character is
+     not accepted, and the frame it opens is dropped entirely. *)
+  let rearming = reg spec have_terminate in
+  let begins = (survivor_b |: survivor_c) &: ~:rearming in
   let new_start4 = survivor_c in
   frame_start4 <== reg spec ~enable:begins new_start4;
```

**Why `begins` (430) and not `b_exists`/`c_exists` (421–422).** `b_exists` and
`c_exists` are read by `inword_strobes` (570–582), which is the **report path**.
Gating them would have put this class's edit on a path R-DISC-2 says no class in
this campaign names. `begins` is downstream of both and feeds only the acceptance
consequences — `to_preamble` (609), `frame_start4` (432), the count and CRC
reloads (478–479), `start4_pending` (663) and `off4` (664–666). The report path is
untouched, which §5's inventory records.

### IC-L2 — `mut/wo-0073-l2` — the reserve is spent: the word delay is 4

Branch **U** (uniform). Ground: SPEC-M03 §7's pinned L = 16 / 12 and ΔC = 3
against REQ-019's §1.1 ceiling of 4.

```diff
@@ -989,19 +989,25 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      one-term union and is written as one. *)
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
+  (* MUTATION IC-L2 (branch U) -- never merge.
+     The reserve is spent: one further register level on the whole output
+     surface puts output word m on cycle m + 4 and ΔC at 4, uniformly, with
+     every octet, every [tkeep], every [tlast] placement and every strobe's
+     coincidence with its [tlast] word unchanged relative to the frame. *)
+  let d1 x = reg spec x in
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

`tstrb` is left unregistered because it is the constant `zero 8` (REQ-014) and a
registered constant is the same constant; registering it would add a flop to
change nothing. **Nothing internal reads the registered copies**, so the module's
entire internal trajectory — states, records, counts, CRC, `hold`, `keep_count` —
is bit-identical to the base at every cycle. Only the observation moves.

### IC-L3 — `mut/wo-0073-l3` — the delay varies with the final word's residue

**R = {2}**, on the **delivered** octet count. Ground: REQ-005's *"independent of
frame length and frame content"*.

```diff
@@ -516,6 +516,12 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   (* [consume] is defined by the output decision below; the two are mutually
      recursive through one cycle of register, so the wire is declared here. *)
   let consume = wire 1 in
+  (* MUTATION IC-L3 -- never merge. Declared here, driven at the output
+     decision below, because the deferral it renders must hold the frame's
+     closure record at whatever age it has reached for the one extra cycle the
+     deferred word waits: at a lane-0 start that age is 2, at a lane-4 start it
+     is 1, so both stages are held and neither is enough alone. *)
+  let l3_block = wire 1 in
   let r1 = wire 7 in
   let r2 = wire 7 in
   let valid_of r = bit r 0 in
@@ -523,8 +529,8 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let sel_is_r1 = valid_of r1 &: ~:sel_is_r2 in
   let sel_is_r0 = ~:sel_is_r2 &: ~:sel_is_r1 in
   let sel = mux2 sel_is_r2 r2 (mux2 sel_is_r1 r1 r0) in
-  r1 <== reg spec (r0 &: ~:(repeat (consume &: sel_is_r0) 7));
-  r2 <== reg spec (r1 &: ~:(repeat (consume &: sel_is_r1) 7));
+  r1 <== reg spec ~enable:(~:l3_block) (r0 &: ~:(repeat (consume &: sel_is_r0) 7));
+  r2 <== reg spec ~enable:(~:l3_block) (r1 &: ~:(repeat (consume &: sel_is_r1) 7));
   let sel_valid = valid_of sel in
@@ -955,7 +961,24 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let ev12 = ~:al_new &: bit al_keep 4 in
   let closed = sel_valid in
   let closure_aligned = closed &: (~:sel_is_r0 |: off4) in
-  let decided = ev12 |: closure_aligned in
+  (* MUTATION IC-L3 -- never merge.
+     The delay varies with the final word's residue: when the word about to be
+     emitted is the frame's [tlast] word and its DELIVERED extent -- the [tkeep]
+     extent [pc] - [strip], which is the delivered octet count modulo 8 -- is 2,
+     the deciding evidence is withheld for exactly one cycle. The word waits in
+     the emission register, its closure record is held at its own age, and it
+     leaves complete on the next cycle with its strobes still on its own [tlast]
+     cycle. R = {2}; 4 is not in R, so a 60-octet delivery is untouched. *)
+  let l3_block_d = reg spec l3_block in
+  l3_block
+  <== (have_word
+       &: (ev12 |: closure_aligned)
+       &: closed
+       &: (nc ==:. 0)
+       &: (pc >: strip)
+       &: ((pc -: strip) ==:. 2)
+       &: ~:l3_block_d);
+  let decided = (ev12 |: closure_aligned) &: ~:l3_block in
   let emit_last_a = have_word &: decided &: closed &: (nc ==:. 0) &: (pc >: strip) in
@@ -974,7 +997,7 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
-  consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
+  consume <== (sel_valid &: (emit_tlast |: sel_is_r2) &: ~:l3_block);
```

`~:l3_block_d` is the one-shot: the block is asserted for exactly one cycle per
qualifying word, after which the word leaves. The three sites are one rendering
and not three defects — the deferral is only a *delay* if the record survives it
(`r1`/`r2` enables) and is only *the class* if the strobes stay on the `tlast`
word's own cycle (`consume`). Blocking `decided` alone strands the word; that was
`c66565d`'s error at the lane-4 members, corrected before delivery.

### IC-L4 — `mut/wo-0073-l4` — the tail word is lost to the next frame's start character

Branch **S** (suppressed). Ground: REQ-112's verification column, *"word loss is
the only observable failure mode"*.

```diff
@@ -828,7 +828,13 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      for them and [emit_last_b] needs [nc] <= [strip] with [nc] >= 1. *)
   let fcs_tail_pending = wire 1 in
   let fcs_tail_now = reg spec fcs_tail_pending in
-  let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
+  (* MUTATION IC-L4 (branch S) -- never merge.
+     The tail word is lost to the next frame's start character: on a cycle
+     whose XGMII word hands a new frame forward, the completed word standing in
+     the emission register is not emitted. [hold] is low on that cycle for the
+     same reason, so the word is not deferred — it is overwritten and lost,
+     and with it the frame's [tlast]. *)
+  let have_word = (pc <>:. 0) &: ~:fcs_tail_now &: ~:begins in
```

The one conjunct does both halves of "cannot do both": it kills the emission
(`emit_last_a`/`_b`/`_full` at 959–962 are all conjoined with `have_word`) **and**
it kills the hold (`hold = have_word &: ~:decided &: ~:clear`, 971), so the
emission register advances on the same cycle and the word is overwritten. That is
suppression, not deferral, and it is the difference between branch S and branch F
in one term.

### IC-L5 — `mut/wo-0073-l5` — the last output word is delivered twice

Repeated **once**. Ground: REQ-020's *"no duplication and no reordering"* and
REQ-015's one-frame-between-`tlast`s rule.

```diff
@@ -989,13 +989,26 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      one-term union and is written as one. *)
   let strobe s = consume &: s &: ~:(i.clear) in
   let q_strobe k = bit q2 k &: ~:(i.clear) in
+  (* MUTATION IC-L5 (branch: repeated ONCE) -- never merge.
+     The last output word is delivered twice: the frame's final word is held in
+     a shadow copy and re-presented on the very next cycle, carrying [tlast],
+     the same octets and the same [tkeep] extent a second time. [l5_again] is a
+     one-cycle register of the [tlast] event and does not feed [emit_tlast], so
+     the repeat cannot re-trigger itself: exactly one extra cycle, never more. *)
+  let l5_tkeep = keep_of_count keep_count in
+  let l5_tuser = emit_tlast &: abort in
+  let l5_tlast = emit_tlast &: ~:(i.clear) in
+  let l5_again = reg spec l5_tlast in
+  let l5_data_q = reg spec al_data_d in
+  let l5_keep_q = reg spec l5_tkeep in
+  let l5_user_q = reg spec l5_tuser in
   { O.rx =
-      { Axi64.Source.tvalid
-      ; tdata = al_data_d
-      ; tkeep = keep_of_count keep_count
+      { Axi64.Source.tvalid = tvalid |: l5_again
+      ; tdata = mux2 l5_again l5_data_q al_data_d
+      ; tkeep = mux2 l5_again l5_keep_q l5_tkeep
       ; tstrb = zero 8 (* REQ-014 *)
-      ; tlast = emit_tlast &: ~:(i.clear)
-      ; tuser = emit_tlast &: abort
+      ; tlast = l5_tlast |: l5_again
+      ; tuser = mux2 l5_again l5_user_q l5_tuser
       }
   ; error_bad_fcs = strobe sel_bad_fcs
```

Rendered at the port with a shadow copy rather than by holding the pipeline,
because holding the pipeline would spend the closure record on the first `tlast`
cycle and leave the repeat carrying `strip` = 0 — an eight-octet duplicate
including the FCS instead of the frame's own four. **The sealed inequality's
derived value assumes the *same* word twice; this rendering delivers exactly
that.** The five strobes are untouched and therefore fire on the **first** of the
two `tlast` cycles.

---

## 4. R-DISC-1 — reachability discharged term by term, per lane, per length, per parity

For each class: the gate signal that produces the event, its complete defining
expression from the base file with line numbers, and **every** conjunct evaluated
at the claimed firing cycle, with **stimulus-contributed** conjuncts marked `[S]`
and mutation-contributed marked `[M]`.

### 4.1 IC-L1 — gate `begins`, base line 430

```
430   let begins = survivor_b |: survivor_c in                      (base)
      let rearming = reg spec have_terminate in                     (mutated)
      let begins = (survivor_b |: survivor_c) &: ~:rearming in      (mutated)
```

**Firing cycle t = 11 + 21k. Parity discharge at frame 1 (k = 0, t = 11).**

| conjunct | line | value at t = 11 | source |
|---|---|---|---|
| `bit lanes.is_start 4` | 190, 422 | 1 — the odd frame's `/S/` in lane 4 | `[S]` |
| `i.cfg_rx_enable` | 422 | 1 — REQ-810/§4.3; SPEC-M03 §8 accepts and forwards every one of the 10 000 frames, so it is 1 for the whole run | `[S]` |
| `~:(i.clear)` | 422 | 1 — no reset mid-run | `[S]` |
| ⇒ `c_exists` | 422 | **1** | `[S]` |
| `c_closing = (is_terminate \|: is_error \|: is_start \|: other_ctl) &: 0xe0` | 418–420, 424 | **0** — lanes 5, 6, 7 of the start word are preamble data octets, not control lanes | `[S]` |
| ⇒ `survivor_c = c_exists &: ~:(any c_closing)` | 429 | **1** | `[S]` |
| `bit lanes.is_start 0` ⇒ `b_exists` ⇒ `survivor_b` | 421, 428 | **0** — no `/S/` in lane 0 at t | `[S]` |
| `have_terminate = any lanes.is_terminate` at t − 1 = **10** | 235 | **1** — the even frame's `/T/` in lane 0 of cycle 10 | `[S]` |
| ⇒ `rearming = reg spec have_terminate` | mutated | **1**, so `~:rearming` = **0** | `[M]` on a `[S]` fact |

⇒ `begins` = (0 ∨ 1) ∧ 0 = **0**, where the base has **1**. **Every conjunct but
the mutation's own register is contributed by the stimulus.**

**Downstream, term by term, to the observable:** `to_preamble = begins` (609) = 0
⇒ the FSM stays in `Idle` (614) for the whole of cycles 12+21k … 21+21k ⇒
`a_open = in_preamble |: in_frame` (296) = 0 ⇒ `cov_first` = 8 (298–302) ⇒
`cov_nonempty = cov_end >: cov_first` (381) = 0 ⇒ `cov` = 0 and `cov_count` = 0
(382–383) ⇒ `cov_d` (735) = 0 ⇒ `al_keep` (741) = 0 ⇒ `pc = popcount al_keep_d`
(795) = 0 ⇒ `have_word` (831) = 0 ⇒ `emit_full`/`emit_last_a`/`emit_last_b`
(959–962) = 0 ⇒ `tvalid` (976) = 0 and `tlast` (997) = 0. **No output word, no
`tlast`.** And `a_char_acts = a_open &: ~:a_close_oversize` (364) = 0 ⇒
`a_close_terminate`/`_error`/`_start` (366, 372, 375) = 0 ⇒ `a_close_now` (377) =
0 ⇒ `r0` (506) invalid ⇒ **no strobe on epoch A's path**; and at the refused start
word `c_closing` = 0 ⇒ `inword_strobes`' `closed` (572) = 0 ⇒ `q2` (583) = 0 ⇒
**no strobe on the in-word path either**. The frame is dropped silently — branch
**D** exactly.

**Recurrence, enumerated rather than assumed unique.** `rearming` at cycle `t` is
`have_terminate` at `t − 1`. On this schedule `have_terminate` = 1 at exactly the
cycles **10 + 21k** and **20 + 21k**, `k = 0…4999`; start characters occur at
exactly **1 + 21k** (lane 0) and **11 + 21k** (lane 4).

- `11 + 21k`: predecessor `10 + 21k` is a terminate cycle ⇒ **blocked**, for every
  `k = 0…4999`. **5 000 members, the odd-index frames, all of them.**
- `1 + 21k`: predecessor is cycle `21k`. Is `21k` a terminate cycle? `21k = 10+21j`
  ⇒ `21(k−j) = 10`, no integer solution; `21k = 20+21j` ⇒ `21(k−j) = 20`, no
  integer solution. **Never** — cycle `21k` is the all-idle word `21 + 21(k−1)`.
  ⇒ **not blocked, for every k. 5 000 members, the even-index frames, all of them.**
- Frame 0 (`k = 0`, cycle 1): predecessor cycle 0 is pre-stimulus idle,
  `have_terminate` = 0 ⇒ accepted.

**This is §1's required consequence met exactly**: the 5 000 odd-index
(lane-4-start) frames are affected, the 5 000 even-index ones are not, and §8.1's
IC-L1 scoring rule 1 (*"the even-index frames must stay correct"*) is satisfied by
derivation and not by hope.

**Per-lane / per-length discharge on unit 2 (the eighteen directed runs).** Each
run drives one frame with nothing before it, so the input word preceding the start
word carries no terminate character and `have_terminate` there is 0 ⇒ `rearming` =
0 ⇒ `begins` takes its base value. The conjunct that differs is the same single
term at all eighteen, and it is 0 at all eighteen for one stimulus reason, so the
discharge is uniform and complete over **lane 0 and lane 4** × **lengths 64, 65,
66, 67, 68, 69, 70, 71, 1518**. **Unit 2 is predicted GREEN under IC-L1** — §8.1's
IC-L1 rule 2, derived rather than assumed.

**Derived quantities.** Frames out **5 000**; `tlast` words **5 000** (an
inequality **below** 10 000, §9's row); delivered octets **300 000**; delivered
sequence numbers **0, 2, 4, … , 9998**; strobe set over the run **∅** (shown
above); front offset h **∈ {8, 12}**, untouched — this diff does not alter the
input trace and h is computed from it.

### 4.2 IC-L2 — gate `tvalid` (976) and the word's cycle, at the port (992–1005)

The class gates nothing; it inserts one register level. The complete defining
expression of the emission event is unchanged —

```
976   let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
959   let emit_last_a = have_word &: decided &: closed &: (nc ==:. 0) &: (pc >: strip) in
960   let emit_last_b = have_word &: decided &: (nc <>:. 0) &: (nc <=: strip) in
962   let emit_full   = have_word &: decided &: (~:closed |: (nc >: strip)) in
```

— and every conjunct evaluates exactly as in the base, on every cycle, at every
frame, at both lanes: **the diff reads these signals and registers the result; it
computes nothing.** The mutation contributes one term, `d1 x = reg spec x` `[M]`,
with `spec = Reg_spec.create ~clock:i.clock ~clear:i.clear ()` (232), so the delay
is not observable across `clear` (SPEC-M03 §7's reset bullet is preserved: the
port is 0 while `clear` is 1 and on the first cycle after).

**Per-lane, per-word discharge — §5 names word 0 and the `tlast` word, at both lanes:**

| member | base cycle | mutated cycle | the term that moves it |
|---|---|---|---|
| lane 0 (h = 8), even frame 2k, **word 0** | 4 + 21k | **5 + 21k** | `tvalid` = 1 at 4+21k `[S]` ⇒ `d1 tvalid` = 1 at 5+21k `[M]` |
| lane 0, even frame 2k, **`tlast` word 7** | 11 + 21k | **12 + 21k** | `emit_last_a` = 1 at 11+21k `[S]` ⇒ `d1 (emit_tlast &: ~:clear)` = 1 at 12+21k `[M]` |
| lane 4 (h = 12), odd frame 2k+1, **word 0** | 14 + 21k | **15 + 21k** | as above |
| lane 4, odd frame 2k+1, **`tlast` word 7** | 21 + 21k | **22 + 21k** | as above |

**Word delay.** ΔC = (first output word's cycle) − (start word's cycle):
lane 0, (4+21k) − (1+21k) = 3 → **4**; lane 4, (14+21k) − (11+21k) = 3 → **4**.
**Per-octet constants**, from SPEC-M03 §7's ΔC = (L + h)/8 with one cycle = 8
octet times: lane 0, L = 8·4 − 8 = **24**; lane 4, L = 8·4 − 12 = **20**. Exactly
§1 IC-L2's required consequence. REQ-019's ceiling comparison (§1.1's 4) does not
fire — 4 > 4 is false. §0.5's closure holds — (L + h) = **32** at both lanes, a
multiple of 8. §0.5's start-lane pair rule holds — both classes at ΔC = 4, the two
constants 4 octet times apart, inside the ≤ 8 bound of REQ-111. **`Latency.errors`
is therefore silent under this class, and that silence is a REQUIRED green**, as
the packet's §1 says in terms.

**Per-length discharge on unit 2.** The register is unconditional, so all eight
words … all 190 words of every one of the eighteen runs move by exactly one cycle,
at both lanes and at all nine lengths. There is no length-dependent or
lane-dependent term to discharge — the absence is the discharge.

**Derived quantities.** Frames out **10 000**; `tlast` words **10 000**; delivered
octets **600 000**; sequence **0 … 9999**; `tkeep` per word unchanged; strobe set
**∅**, one cycle later; h **∈ {8, 12}**. Every latency observation moves **later,
never earlier** (§9's direction row).

### 4.3 IC-L3 — gate `decided`, base line 958, via `l3_block`

```
958   let decided = ev12 |: closure_aligned in                              (base)
      l3_block <== (have_word &: (ev12 |: closure_aligned) &: closed
                    &: (nc ==:. 0) &: (pc >: strip)
                    &: ((pc -: strip) ==:. 2) &: ~:l3_block_d);            (mutated)
      let decided = (ev12 |: closure_aligned) &: ~:l3_block in             (mutated)
```

**R = {2}, delivered.** Members among the eighteen: **length 70 at lane 0**,
**length 70 at lane 4**, **length 1518 at lane 0**, **length 1518 at lane 4**
(§2's table). **4 ∉ R**, so the stress unit's 60-octet deliveries never fire it.

#### Member 1 — length 70, lane 0. Firing cycle t = s + 11, where s is the start word's cycle.

Layout from the RTL: preamble in lanes 0…7 of `s`; octets 0…7 at `s+1` … octets
56…63 at `s+8`; octets 64…69 at `s+9` lanes 0…5; **terminate at `s+9` lane 6**.
At `s+9`: `a_char_end` (316–318) = 6, `cov_first` (298–302) = 0, `cap_end`
(343–351) = 8, `a_hold_end` (329–331) = 8, `cov_end = min2 (min2 a_char_end
cap_end) a_hold_end` (353) = 6, `cov_count` (383) = **6**; `a_close_terminate`
(366) = 1; `count_next` (398) = 70 ≥ `runt_threshold` so `a_close_runt` (502) = 0;
`has_fcs` (470) = 1 and the residue matches so `bad_fcs` (471) = 0. `off4` = 0
(664–666, lane-0 start), so `al_keep` (741) = `cov_d` = cov(t−1) and `al_keep_d`
(782) = cov(t−2). Record ageing: age 0 at `s+9`, age 1 at `s+10`, **age 2 at `s+11`**.

| conjunct | line | value at t = s + 11 | source |
|---|---|---|---|
| `have_word = (pc <>:. 0) &: ~:fcs_tail_now` | 831 | `pc` = popcount(cov(s+9)) = **6** ≠ 0; `fcs_tail_now` (830) = 0 ⇒ **1** | `[S]` |
| `ev12 = ~:al_new &: bit al_keep 4` | 955 | `al_keep` = cov(s+10) = 0 ⇒ bit 4 = 0 ⇒ **0** | `[S]` |
| `closure_aligned = closed &: (~:sel_is_r0 \|: off4)` | 957 | `closed` = 1 (record at age 2), `sel_is_r0` = 0 ⇒ **1** | `[S]` |
| `(ev12 \|: closure_aligned)` | 958 | **1** | `[S]` |
| `closed = sel_valid` | 528, 956 | **1** | `[S]` |
| `nc = mux2 al_new (zero 4) (popcount al_keep)` | 799 | `al_new` (745) = 0 (state `Idle`, `first_v` = 0), `popcount al_keep` = 0 ⇒ `nc` = **0** ⇒ `(nc ==:. 0)` = **1** | `[S]` |
| `strip` | 800 | `sel_valid ∧ sel_terminate` ⇒ **4** | `[S]` |
| `(pc >: strip)` | — | 6 > 4 ⇒ **1** | `[S]` |
| `((pc -: strip) ==:. 2)` | mutated | 6 − 4 = **2** ⇒ **1** | `[M]` |
| `~:l3_block_d` | mutated | `l3_block`(s+10) = 0 ⇒ **1** | `[M]`, the one-shot |

⇒ `l3_block` = **1** at `s+11` ⇒ `decided` = 0 ⇒ `emit_last_a` (959) = 0,
`emit_full` (962) = 0, `tvalid` = 0; `hold` (971) = `have_word ∧ ¬decided ∧ ¬clear`
= **1** so `al_data_d`/`al_keep_d` (781–782) keep the word; `consume` (977,
mutated) = 0 so the record is not spent; `r1` and `r2` (526–527, mutated) are
enable-held so the record stays at age 2. **The aligned word dropped by the hold
is `al_keep` = cov(s+10) = 0 — empty**, and provably so: `al_new` = 0 here, so the
conjunct `nc = 0` *is* the emptiness statement rather than the new-frame
statement.

At `s+12`: `l3_block_d` = 1 ⇒ `l3_block` = 0 ⇒ `decided` = `closure_aligned` = 1
(record held at age 2) ⇒ `emit_last_a` = 1 with `pc` = 6 (held), `nc` =
popcount(cov(s+11)) = 0, `strip` = 4 ⇒ `keep_count` (972–974) = **2**, `tdata` =
the held `al_data_d` (the same octets), `tlast` = 1, and `consume` = 1 so the
strobe set is still evaluated on this frame's own `tlast` cycle. **The `tlast`
word is one cycle late and otherwise identical.**

#### Member 2 — length 70, lane 4. Firing cycle t = s + 11.

Octet `j` sits at word `s + 1 + ⌊(j+4)/8⌋`, lane `(j+4) mod 8` (the lane-4 start
puts four preamble octets in lanes 4…7 of `s` and four in lanes 0…3 of `s+1`).
Octets 60…67 → indices 64…71 → **`s+9` lanes 0…7**; octets 68, 69 → indices 72, 73
→ `s+10` lanes 0, 1; **terminate at `s+10` lane 2**. `off4` = 1, so `al_keep` (741)
= `rotate_hi (concat_msb [cov; cov_d])` = {cov(t−1)[7:4], cov(t)[3:0]}.
`al_keep(s+10)` = {1111, 0011} = **6 octets**; `al_keep_d(s+11)` = that, so
`pc` = **6**. **Record ageing differs by lane**: the closure is at `s+10`, so at
`s+11` the record is at **age 1**, not age 2.

| conjunct | line | value at t = s + 11 | source |
|---|---|---|---|
| `have_word` | 831 | `pc` = 6 ≠ 0 ⇒ **1** | `[S]` |
| `ev12` | 955 | `al_keep(s+11)` = {cov(s+10)[7:4], cov(s+11)[3:0]} = 0 ⇒ bit 4 = 0 ⇒ **0** | `[S]` |
| `closure_aligned = closed &: (~:sel_is_r0 \|: off4)` | 957 | `closed` = 1, `sel_is_r0` = 0 (record in `r1`), and `off4` = 1 — **either disjunct alone suffices here** ⇒ **1** | `[S]` |
| `closed` | 956 | **1** (age 1) | `[S]` |
| `nc` | 799 | `al_new` = 0, `popcount al_keep` = 0 ⇒ **0** | `[S]` |
| `strip` | 800 | **4** | `[S]` |
| `(pc >: strip)` | — | 6 > 4 ⇒ **1** | `[S]` |
| `((pc -: strip) ==:. 2)` | mutated | **1** | `[M]` |
| `~:l3_block_d` | mutated | **1** | `[M]` |

⇒ fires at `s+11`; released at `s+12` with the record found at **age 1**
(`sel_is_r1`), `keep_count` = 2, `consume` = 1. **This member is the one that
forced the `r1` enable**: with only `r2` held, `r1` would have reloaded from
`r0`(s+11) = 0 at `s+12`, the record would have vanished, `closed` would have gone
to 0, `decided` would have stayed 0 and the word would have been stranded — word
loss, not a delay, and not this class. Discharging this member per lane is what
found it, which is precisely what R-DISC-1 exists to make happen before a seal
branches on the claim.

#### Members 3 and 4 — length 1518, lane 0 and lane 4.

1518 = 189·8 + 6 ⇒ the last aligned word carries **6** received octets ⇒ `pc` = 6,
`strip` = 4, `keep_count` = **2**, delivered **1514** ✓ (REQ-108's *"exactly 1514
delivered"* and REQ-103's extent agree). REQ-108 does **not** fire: at the closing
word `cap_room = 1518 − count` equals `a_char_end`, so
`a_close_oversize = a_open &: (cap_end <: a_char_end) &: …` (361–362) is
`(6 < 6)` = **0** at lane 0 and `(2 < 2)` = **0** at lane 4 — a frame of exactly
1518 octets is the maximum legal frame, not an oversize one, and `strip` is
therefore 4 by `sel_terminate` and not by `sel_oversize`. Lane 0: terminate at
lane 6 of the last word, record at **age 2** at the firing cycle — identical in
every term to member 1. Lane 4: octet 1517 → index 1521 = 8·190 + 1 ⇒ terminate at
lane 2 of word `s+191`, `al_keep(s+191)` = {1111, 0011} = 6, record at **age 1** at
the firing cycle `s+192` — identical in every term to member 2. **Both discharged;
neither is assumed from the shorter members.**

#### The lengths and lanes NOT in R — discharged as non-firing rather than skipped

At received lengths 64, 65, 66, 67, 68, 69, 71 (both lanes) the conjunct
`((pc -: strip) ==:. 2)` evaluates to **0** — the `tlast` word's delivered extent
is 4, 5, 6, 7, 8, 1, 3 respectively (§2's table) — so `l3_block` is 0 and
`decided`, `hold`, `consume`, `r1` and `r2` are the base's on every cycle. **Ten of
the eighteen runs are provably inert.** By §3.2's shadowing the first reddening
row of the eighteen in `run_l5`'s order (lane 0: 64, 65, 66, 67, 68, 69, **70**,
71; lane 4: the same eight; lane 0 1518; lane 4 1518) is **lane 0, length 70 — the
7th run**; the other three firing members are discharged term by term above and
are recorded **unobserved**, never as a miss and never as a pass.

**Unit 1 (the 10 000-frame stress run): every frame delivers 60 octets, 60 mod 8 =
4, `pc` = 8, `strip` = 4, `(pc -: strip)` = 4 ≠ 2 ⇒ `l3_block` is identically 0
across all 10 000 frames and 210 000 cycles. Predicted GREEN.** §8.1's IC-L3
scoring rule **1** is the rule in play, declared before the run: red at the L5 rows
whose delivered residue ∈ R with unit 1 green.

**Two bounds on the rendering, stated rather than left to be discovered.** (i) If a
firing cycle's lookahead word *began a new frame*, `nc` would be 0 through `al_new`
rather than through emptiness, and the hold would drop a non-empty word — the
class plus a datapath defect. **No instance of this campaign's stimulus does so**:
unit 2's runs are single-frame and unit 1 never fires. (ii) A closure record born
at `r0` on a deferral cycle is lost rather than delayed, since `r1`'s enable is
low. That needs a second frame closing on the exact cycle a first frame's
residue-2 `tlast` word is due; again no instance here. Both are in §6's rule.

### 4.4 IC-L4 — gate `have_word`, base line 831

```
831   let have_word = (pc <>:. 0) &: ~:fcs_tail_now in                (base)
      let have_word = (pc <>:. 0) &: ~:fcs_tail_now &: ~:begins in    (mutated)
```

**Firing cycle t = 11 + 21k. Parity discharge at frame 0 (k = 0, t = 11).**

| conjunct | line | value at t = 11 | source |
|---|---|---|---|
| `pc = popcount al_keep_d` | 795 | `al_keep_d(11)` = cov(9) = 0xFF ⇒ **8** ≠ 0 ⇒ 1 | `[S]` |
| `~:fcs_tail_now`, `fcs_tail_now = reg spec fcs_tail_pending`, `fcs_tail_pending <== emit_last_b` | 829–830, 961 | `emit_last_b`(10) = 0 (at cycle 10, `nc` = 8 > `strip` = 4) ⇒ **1** | `[S]` |
| `begins = survivor_b \|: survivor_c` | 430 | **1** — the odd frame's lane-4 `/S/` is accepted at this very cycle (`c_exists` = 1, `c_closing` = 0) ⇒ `~:begins` = **0** | `[M]` reading a `[S]` fact |

⇒ `have_word` = **0**, where the base has 1. And the word it suppresses is the one
§1's geometry names: at t = 11, `nc` = popcount(cov(10)) = **0** and `strip` = 4
and `pc` = 8 > 4, so the base's `emit_last_a` (959) = 1 — **this is frame 0's word
7, its `tlast` word, `keep_count` = 8 − 4 = 4 delivered octets.**

**Downstream:** `emit_last_a`, `emit_last_b` (959–960) and `emit_full` (962) are
all conjoined with `have_word` ⇒ 0 ⇒ `emit_tlast` (963) = 0, `tvalid` (976) = 0,
`tlast` (997) = 0. **And `hold` (971) = `have_word &: ~:decided &: ~:clear` = 0**,
so `advance` (780) = 1 and `al_data_d`/`al_keep_d` load the next aligned word: the
completed word is **overwritten, not deferred**. Branch **S** exactly — *"it is
never emitted, and with it the frame's `tlast`"*.

**The report path is not re-authored, only re-timed by §9's own fallback**:
`consume` (977) = `sel_valid &: (emit_tlast |: sel_is_r2)`; at t = 11 the record is
at age 1 (`sel_is_r1`) and `emit_tlast` = 0 ⇒ `consume` = 0; at t = 12 the record
is at age 2 ⇒ `sel_is_r2` = 1 ⇒ `consume` = 1 — *"a record is always consumed by
age 2, which is §9's pinned cycle for a frame that emits no word"* (the design's
own comment, 486–487). All strobe bits are 0 for a conformant frame, so the run's
strobe set is still **∅**.

**Recurrence, enumerated.** `begins` = 1 at exactly the cycles **1 + 21k** and
**11 + 21k**. An output word is emitted at those cycles only when:

- `11 + 21k` — the even frame `2k`'s **word 7**, at `1+21k+7+3` = `11+21k`. ⇒
  **suppressed, for every k = 0…4999. 5 000 members, every even-index frame,
  every one of them its `tlast` word.**
- `1 + 21k` — the previous odd frame `2k−1`'s last output word is at
  `11+21(k−1)+10` = `21k`, one cycle **earlier**, and its successor's word 0 is at
  `4+21k`, three cycles later. `pc` at `1+21k` is popcount of an all-idle aligned
  word = 0, so `have_word` was already 0. ⇒ **no word is suppressed there, for
  every k.**

**This is §1 IC-L4's required consequence met exactly**: every even-index frame
loses its word 7; the odd frames — whose word 7 falls at `21 + 21k`, an all-idle
input word with `begins` = 0 — are untouched.

**Per-lane / per-length discharge on unit 2.** Each run drives one frame; `begins`
is 1 only at that frame's own start word, and the first output word of the frame
is three cycles later (ΔC = 3), so `pc` = 0 at the `begins` cycle and the added
conjunct changes nothing. Uniform over **lane 0 and lane 4** × **lengths 64…71,
1518** for one stimulus reason. **Unit 2 predicted GREEN under IC-L4.**

**Derived quantities.** Frames presented **10 000**, `tlast` words **5 000** (an
inequality **below** 10 000, §9's row); delivered octets 5 000·56 + 5 000·60 =
**580 000**; every even frame delivers **56** of its 60 octets and carries no
`tlast`; strobe set **∅**; h **∈ {8, 12}**.

### 4.5 IC-L5 — gate: the `tlast` gate alone, at the port (992–999)

```
997   ; tlast = emit_tlast &: ~:(i.clear)                    (base)
      ; tlast = l5_tlast |: l5_again                          (mutated)
      where l5_again = reg spec l5_tlast, l5_tlast = emit_tlast &: ~:(i.clear)
```

**Firing cycle: the cycle after every `tlast` cycle.**

| conjunct | line | value | source |
|---|---|---|---|
| `emit_tlast = emit_last_a \|: emit_last_b` | 963 | 1 at each frame's `tlast` cycle — unmodified | `[S]` |
| `~:(i.clear)` | 997 | 1 | `[S]` |
| `l5_again = reg spec l5_tlast` | mutated | 1 on the **next** cycle only | `[M]` |
| `l5_again` feeding `emit_tlast`? | — | **no** — the repeat is produced at the port and `emit_tlast` never reads it, so `l5_tlast` is 0 on the repeat cycle and `l5_again` is 0 on the cycle after ⇒ **exactly one extra cycle** | `[M]` |

**Per-parity discharge, unit 1.** Even frame `2k`: `tlast` at `11 + 21k`, duplicate
at `12 + 21k`. The next genuine output word is the odd frame's word 0 at
`14 + 21k`, two cycles later ⇒ **the duplicate replaces an idle cycle**. Odd frame
`2k+1`: `tlast` at `21 + 21k`, duplicate at `22 + 21k`; the next genuine word is
the even frame `2k+2`'s word 0 at `4 + 21(k+1)` = `25 + 21k`, three cycles later ⇒
**again an idle cycle**. No output word is displaced anywhere in the 10 000-frame
run, at either parity.

**Per-lane, per-length discharge, unit 2.** Each run's frame is the last thing in
its run, so the cycle after its `tlast` carries nothing ⇒ the duplicate displaces
nothing, at both lanes and all nine lengths. The duplicate's content is the
frame's own final word: `l5_data_q` = `reg spec al_data_d` and `l5_keep_q` =
`reg spec (keep_of_count keep_count)`, both sampled unconditionally every cycle, so
on the repeat cycle they hold the `tlast` cycle's values.

**Derived quantities.** `tlast` words **20 000** (an inequality **above** 10 000,
§9's row — this is the direction that separates IC-L5 from IC-L1(D) and IC-L4(S)
at the same cell); delivered octets in unit 1 = 10 000 · (60 + 4) = **640 000**
(above 600 000); delivered octets per unit-2 run = delivered + the `tlast` word's
extent, i.e. **64, 66, 68, 70, 72, 66, 68, 70** at lengths 64…71 and **1516** at
1518 — every one **above REQ-103's extent**, §9's row. Strobe set **∅**, on the
**first** of the two `tlast` cycles. h **∈ {8, 12}**.

### 4.6 Nothing is self-declared NOT SEEDED

All five classes are seeded as specified and every lane, length and parity their
own required consequence names is discharged above. **No class, lane, length or
parity is declared NOT SEEDED in this manifest.** The one term I could not
discharge on the first attempt — IC-L3's lane-4 members — was repaired before
delivery rather than escaped (§3, `c66565d` → `60ed49c`).

---

## 5. R-DISC-2 — the gate inventory, before delivery

Three paths, as the packet's §5 names them. Every term the classes touch or read,
with each class's claim about it.

### 5.1 The output-word emission gate

Terms: `pc` 795, `nc` 799, `strip` 800, `fcs_tail_pending` 829, `fcs_tail_now` 830,
`have_word` 831, `ev12` 955, `closed` 956, `closure_aligned` 957, `decided` 958,
`emit_last_a` 959, `emit_last_b` 960, `emit_full` 962, `emit_tlast` 963,
`hold` 971 / `advance` 780, `al_data_d` 781, `al_keep_d` 782, `keep_count` 972–974,
`tvalid` 976, the `rx` port fields 992–999.

| class | claim about this path |
|---|---|
| IC-L1 | **Does not touch it.** The class acts upstream at acceptance; every term here is unmodified and evaluates to its base value on every cycle of every frame the design still accepts. The path goes silent for a refused frame only because `pc` is 0 there. |
| IC-L2 | Touches only the path's **observation**: one register level on the port. No gate term is modified; `emit_*`, `hold`, `keep_count`, `tvalid` are bit-identical to the base at every cycle. |
| IC-L3 | Modifies **`decided` (958)** by one conjunct. Through it `emit_last_a/_b`, `emit_full`, `emit_tlast`, `tvalid` and `hold` take base values on every cycle except one deferral cycle per qualifying frame. |
| IC-L4 | Modifies **`have_word` (831)** by one conjunct. Through it the three emission arms and `hold` are forced low on `begins` cycles. |
| IC-L5 | **Does not modify any term.** It adds a port-level shadow copy and re-presentation. |

### 5.2 The frame-acceptance / `tlast` gate

Acceptance terms: `inword_closing` 418–420, `b_exists` 421, `c_exists` 422,
`b_closing` 423, `c_closing` 424, `survivor_b` 428, `survivor_c` 429, `begins` 430,
`new_start4` 431, `frame_start4` 432, `to_preamble` 609, the FSM 611–647,
`start4_pending` 663, `off4` 664–666.
`tlast` terms: the closure record `r0` 506–515 / `r1` 526 / `r2` 527 / `sel` 525 /
`sel_*` 528–534, `emit_last_a` 959, `emit_last_b` 960, `emit_tlast` 963,
`consume` 977, `tlast` 997.

| class | claim about this path |
|---|---|
| IC-L1 | Modifies **`begins` (430)** — the acceptance half — by one conjunct. Deliberately **not** `b_exists`/`c_exists`, which feed the report path. Nothing on the `tlast` half is modified. |
| IC-L2 | No term modified. |
| IC-L3 | Holds **`r1` (526)** and **`r2` (527)** for one cycle via their register *enables*, and adds one conjunct to **`consume` (977)**. No condition, comparison or count inside a record changes; only the cycle a record is spent, which remains by construction the cycle its own `tlast` word leaves. |
| IC-L4 | No acceptance term modified; **reads** `begins` as the coincidence trigger. `emit_tlast` is forced low through `have_word`, so `consume` falls to its own `sel_is_r2` arm one cycle later — §9's existing age-2 fallback, not a new term. |
| IC-L5 | Adds a second `tlast` cycle **at the port**. `emit_tlast` and `consume` are unmodified, so every record is still spent exactly once, on the **first** of the two `tlast` cycles. |

### 5.3 The report path — declared as a NEGATIVE

Terms: `has_fcs` 470, `bad_fcs` 471, `a_close_runt` 502, `record_fields` 503–505,
`r0`'s strobe fields 506–515, `sel_error` 530 / `sel_start` 531 / `sel_oversize` 532
/ `sel_bad_fcs` 533 / `sel_runt` 534, `inword_strobes` 570–582, `q2` 583–590,
`abort` 975, `strobe` 990, `q_strobe` 991, the five `error_*` port fields 1000–1004.

**No class in this campaign names the report path, and no diff modifies any term of
it.** Said explicitly, as §5 requires. Two consequential contacts are disclosed
rather than left to be found:

1. **IC-L2 puts its one register level on the five `error_*` fields as well as on
   `rx`.** This is deliberate and is the class rather than an addition to it: §9
   pins every strobe to its frame's `tlast` cycle, so a rendering that delayed
   `rx` alone would have produced a strobe/`tlast` **skew** — a second defect no
   class here names, and exactly the kind of term-outside-every-class R-DISC-2
   warns about. No strobe condition, count or comparison is altered; the strobe set
   over any run is the base set, one cycle later. **I judged this rather than
   followed it — Q3 in §11.**
2. **IC-L3 and IC-L4 move the *cycle* on which `consume` fires for one frame.**
   IC-L3: one cycle later, still that frame's own `tlast` cycle. IC-L4: one cycle
   later, onto §9's age-2 fallback, because the `tlast` word no longer exists.
   Neither changes what `consume` gates.
3. **IC-L1 and IC-L5 have no report-path contact at all.**

**Consequence worth pinning before the run**: under all five classes the strobe set
over the 10 000-frame stress run is **∅**, because SPEC-M03 §8's error-injection
rate is zero and no class creates a closure condition. Under IC-L1 in particular a
refused frame is silent on **both** report paths — epoch A's, because `a_open` is 0
so `a_char_acts` (364) is 0; and the in-word epochs', because `c_closing` is 0 at
the refused start word so `inword_strobes`' `closed` (572) is 0. **§9's "strobe set
= ∅, not mutant-owned" row is therefore preserved by every one of the five, and a
strobe name appearing in this campaign belongs to no class here** — §9 says that is
a finding, and I have made it a checkable one.

### 5.4 Cross-class gate facts, tabulated rather than discovered

Every term two or more classes touch or read:

| term | line | IC-L1 | IC-L2 | IC-L3 | IC-L4 | IC-L5 | the reading all five agree on |
|---|---|---|---|---|---|---|---|
| `begins` | 430 | **modified** | reads | reads | **reads** as its trigger | reads | high exactly on an input word that hands a new frame forward: cycles 1+21k and 11+21k in unit 1; the start word only, in every unit-2 run |
| `have_word` | 831 | — | — | reads (a conjunct of `l3_block`) | **modified** | — | a completed word stands in the emission register and is not BUG-0001's residual |
| `decided` | 958 | — | — | **modified** | reads | — | the word's deciding evidence has arrived (`ev12` or the aligned closure record) |
| `hold` | 971 | — | — | driven **high** on the firing cycle | driven **low** on the firing cycle | — | *the exact complement of the emission it withholds.* **IC-L3 and IC-L4 rely on opposite values of this one signal, and that is precisely the difference between a deferral and a loss.** They are consistent, not contradictory: IC-L3 kills `decided` and leaves `have_word` = 1 ⇒ hold = 1; IC-L4 kills `have_word` ⇒ hold = 0 |
| `emit_tlast` | 963 | — | reads | one cycle later for R-members | forced low for even frames | reads (the second `tlast` is at the port) | the frame's last word is leaving |
| `consume` | 977 | — | reads | **modified** | falls to its age-2 arm | reads | a closure record is spent |
| `r1`, `r2` | 526–527 | — | — | **enable-gated** | — | — | the three-age closure channel |
| `strip` | 800 | — | — | reads | reads | reads | 4 on a terminate/oversize closure, else 0 |
| `sel_valid` | 528 | — | — | reads | reads | — | a closure is decided and unreported |
| the port record | 989–1005 | — | **registered whole** | — | — | **muxed with a shadow copy** | IC-L2 and IC-L5 edit the same site in **two separate diffs**, never combined |

**A fact one entry relies on that another contradicts: none.** The `hold` row is
the one that looked like a contradiction and is not; it is tabulated here, before
delivery, because that is the mechanical form of the cross-check `DISP-0001` §4
says failed in WO-0061.

---

## 6. The blast-radius rules (§3.3 form), stated as rules with instances beneath

Per the packet's §3.3, **the rule governs where the rule and the instances
disagree.** A red selected by the rule is predicted blast radius and contributes
**zero** additional kills; a red outside the rule is a finding.

**IC-L1** — *a unit reddens iff its stimulus presents a start character in an input
word whose immediate predecessor input word contains a terminate character in any
lane.* Instances worked: unit 1's 5 000 odd-index frames; unit 2's eighteen runs,
none. Corollary in gap terms, offered because it bounds the rule at other units: at
a legal REQ-004 gap (≥ 12 octet times from the terminate inclusive) adjacency is
reachable only when the terminate is in **lane 0** and the next start in **lane 4**
of the following word; a sub-minimum or adversarial gap can produce adjacency at
other lane pairs and the rule still governs there.

**IC-L2** — *a unit reddens iff it pins an absolute cycle of any M03 output — a
`tvalid`, `tkeep`, `tlast`, `tuser` or strobe cycle, a word delay, a per-octet
latency constant, or a simulation horizon inside which the last expected word must
arrive.* A unit that reads only the ordered sequence of output words and their
contents, with no cycle pinning and at least one cycle of horizon slack, stays
green. The packet's own count of **227** cycle-pinning assertion sites across the
twelve row files is the scale; the class is a cheap kill by construction and its
reds are coverage of nothing.

**IC-L3** — *a unit reddens iff it drives a frame whose `tlast` word's delivered
extent is exactly 2 octets **and** pins that word's cycle or a latency derived from
it.* Instances worked: unit 2 at received length **70** (both lanes) and **1518**
(both lanes) — four of eighteen, of which **lane 0 length 70** is the observable one
and the other three are **unobserved**. Unit 1 green. Two bounds (§4.3): a firing
cycle whose lookahead word begins a new frame, and a closure record born at `r0`
on a deferral cycle — neither has an instance in this campaign's stimulus, and a
red traceable to either is the rendering leaving the class, not a kill.

**IC-L4** — *a unit reddens iff an output word is emitted on the same cycle an
accepted start character arrives* — equivalently, iff a frame's last output word
and the next frame's start word fall on one cycle. Instances worked: unit 1's 5 000
even-index frames; unit 2, none.

**IC-L5** — *a unit reddens iff it counts output words, counts `tlast` words,
compares a delivered octet stream against an expected extent, or asserts what the
cycle after a `tlast` carries.* A unit that drives no frame to a `tlast` stays
green. Bound: the duplicate replaces whatever the port would otherwise carry on the
following cycle; on this campaign's stimulus that cycle is idle at every instance
(unit 1: two or three idle output cycles after every `tlast`; unit 2: nothing
follows the frame).

**A prediction I owe the adjudicator, derived and not read.** IC-L1(D) and
IC-L4(S) both yield **5 000** `tlast` words in unit 1 and both leave unit 2 green.
If the first-speaking assertion of unit 1 is a frame count, the two classes will
speak with one string and the discriminator will be **which branch was applied** —
§10's own situation, and the reason the packet fixes the delivery order and
requires a branch name per run. They differ in every quantity beyond the count
(delivered octets 300 000 vs 580 000; sequence 0,2,4,… vs 0,1,2,…; 5 000 frames
absent vs 10 000 frames present with 5 000 truncated), so a scorecard that reports
the message *and its branch* separates them completely. I state this as my own
derivation from the RTL, having read no seal.

---

## 7. The §6 pre-ship datapath check

The check applies to renderings that **claim the datapath does not move in
content**. The packet names four class-branches: IC-L2, IC-L3, IC-L1(**T**) and
IC-L4(**F**).

**I rendered IC-L1 at branch D and IC-L4 at branch S. Both move the datapath by
design, so the check does not apply to them and I make no §6 claim for either** —
saying so is the difference between a check and a ritual, which is the packet's own
sentence. It applies to **IC-L2** and **IC-L3**, and both pass.

The measured signature (`BUG-0003` §V.10.2, as the packet states it): **(a)** 7
mid-frame words with `tkeep` ≠ 0xFF and `tlast` = 0; **(b)** 4 of 60 required
octets in their gapless byte positions, 28 delivered as the idle filler `0x07` and
28 never delivered (a 32-octet stream against a required 60); `tlast` on word 7;
`tuser` = 0 on a corrupted frame.

| component | IC-L2 | IC-L3 |
|---|---|---|
| mid-frame `tkeep` ≠ 0xFF with `tlast` = 0 | **absent.** `keep_count` (972–974) is bit-identical to the base at every cycle; the diff registers its result and computes nothing | **absent.** `keep_count` is untouched; the deferral changes *when* the `tlast` word leaves, not any word's extent, and no mid-frame word is affected at all |
| octets out of their gapless positions | **absent.** `al_data_d` (781) unmodified | **absent.** `al_data_d` is *held* for one cycle and emitted unchanged |
| `0x07` idle filler delivered as payload | **absent.** No path from the raw XGMII word to `tdata` is added | **absent.** Same |
| octets never delivered | **absent.** Every word that left in the base leaves, one cycle later | **absent at every firing instance.** The word the hold drops is `al_keep`, and `al_new` = 0 at all four instances (nothing follows the frame in a single-frame run), so the conjunct `nc = 0` *is* the statement that it is empty |
| `tlast` on the wrong word | **absent.** Same word of the same frame | **absent.** Same word of the same frame |
| `tuser` = 0 on a corrupted frame | **absent.** `tuser = emit_tlast &: abort` unmodified | **absent.** Same |

**Both PASS.** Neither rendering produces any component of the signature on a
delivering stimulus, so neither is the class plus a datapath defect, and the
packet's §6 consequence — *a red carrying a datapath message scores as the class
out of specification* — has, on my analysis, no instance to reach.

---

## 8. What the campaign does NOT ask of these diffs, restated so no verdict drifts

The packet's §4 declares six things this campaign structurally cannot score
(`M03-L4`'s and `M03-L3`'s own instruments, item 9's REQ-014 residue, REQ-020's
reordering half, family C's observables at scale, and item 5's empty-strobe-set
check). **I have seeded against none of them and claim nothing about any of them.**
Specifically: no class here targets `tstrb` (REQ-014) — IC-L2 leaves `tstrb` as the
constant `zero 8` precisely so that it does not; no class targets REQ-020's
*reordering* half, which the packet derives as unrenderable at this stimulus and
which I independently agree is unrenderable at this design (a cut-through pipeline
with two datapath words of storage cannot emit octets it has not received); and no
class targets the empty-strobe-set check, whose non-target status the packet
grounds in enumerability and which my §5.3 result — strobe set ∅ under all five —
confirms from the other direction.

---

## 9. Pre-run reading note for dv_lead (`WO-0073` §7 item 7, the `WO-0063B` precedent)

Delivered **before** any run, as a committed note, per the packet's own precedent
clause. Item 9.1 is dv_lead's own question relayed to me; 9.2–9.5 are mine.

### 9.1 dv_lead's question, answered before either branch ran

> *"if IC-L1 and IC-L4 turn out to be the same edit under this design, that promotes
> collision 1 from a message fact to a manifest fact and disposition 6 makes both
> unscoreable — I would re-cut one class rather than score a pair I cannot
> separate."*

**Answer: they are not the same edit, and they are not close to the same edit. No
re-cut is needed and I did not stop.** The derivation, from the RTL alone:

| | IC-L1 | IC-L4 |
|---|---|---|
| gate modified | **`begins`, line 430** — the frame-acceptance gate | **`have_word`, line 831** — the output-word emission gate |
| conjunct added | `~:rearming`, a **register of the previous word's** `have_terminate` (235) | `~:begins`, a **combinational** read of **this** word's acceptance |
| what it keys on | the input word **before** the start word | the input word **on** the emission cycle |
| frames affected | the **5 000 odd-index (lane-4-start)** frames | the **5 000 even-index (lane-0-start)** frames |
| what is lost | the whole frame — 60 octets, 8 output words, its `tlast`, its place in the sequence | one word — 4 delivered octets and the frame's `tlast`; the frame's other 56 octets are delivered |
| the two are related how | both fire on the **same cycle set, 11 + 21k** — because that cycle is simultaneously an odd frame's start word and an even frame's word-7 emission. That coincidence is the schedule's, not the edits' |

The one coincidence is real and worth naming: **cycle 11 + 21k is where both
classes live**, which is a fact about REQ-004's alternating-lane geometry rather
than about either diff. But the gates are 400 lines and one pipeline stage apart,
the conjuncts have different types (registered vs combinational), and the affected
frame sets are **disjoint and complementary**. Applying one has no effect on the
other's condition: IC-L1's diff leaves `have_word` and `begins` untouched at every
even frame; IC-L4's diff leaves `begins` untouched everywhere.

**What I do owe you, and it is a weaker thing than you feared** (§6's last
paragraph, repeated here so it reaches you before the run): IC-L1(D) and IC-L4(S)
produce the **same `tlast` count in unit 1 — 5 000** — and both leave unit 2 green.
If unit 1's first-speaking assertion is a frame count, the two may raise the same
string. That is a *message* collision, which is §10's own priced situation and
which the branch name on each run resolves; it is **not** an edit collision, and
disposition 6 has no purchase on it. Every quantity beyond the count separates
them (the table above).

### 9.2 The base SHA disagreement — §1's FINDING WO-0073-M1

Filed before the first branch was cut, per §8's *"a finding before the campaign
runs, not after"*. §8's literal base is `8acd28d`; the operating base is
`bbd4122`; the trees are byte-identical at `libs/`, `test/`, `tools/` and
`docs/specs/`. I applied to `bbd4122` and quote it as §7 item 6 requires. **If you
hold the seal to `8acd28d`, say so before adjudication.**

### 9.3 R-DISC-2's report-path negative versus IC-L2's uniform register

§5.3 item 1. I judged that "every output word on cycle m + 4" means the strobes
move with the `tlast` word they are pinned to, and that registering `rx` alone
would be the class **plus** a strobe/`tlast` skew. If your seal branched on the
narrower reading — `rx` delayed, strobes not — say so; the cells differ only at
units that assert a strobe cycle, and this campaign's stimulus injects no errors.

### 9.4 IC-L3's residue set is mine to choose and I chose narrowly

**R = {2}**, four of the eighteen runs, `4 ∉ R`. I chose 2 rather than {1, 2, 3}
because it is the only residue that selects **both** the short set and the 1518
member, at both lanes, and because §5's per-length per-lane discharge burden is
then four members I can work completely rather than eight I would work thinly.
`{4}` was barred by §8.1's rule 2/3 structure. If the seal's cells assume a
different R, the disclosure is here, before the run.

### 9.5 No extra rendered branch is requested — the +344 s is not incurred

§12(b) prices an extra rendered branch of a disclosure at +344 s. **I render
exactly one branch of each disclosure**: IC-L1 at A/D, IC-L2 at U, IC-L3 at
R = {2}, IC-L4 at S, IC-L5 at once. Five diffs, five branches, five CI runs, at the
packet's own price of ≈ 28.7 minutes of CI wall. **No extra branch, no extra
cost.**

---

## 10. Mechanical verification

### 10.1 Base identity

```
$ git rev-parse HEAD                     # working branch at spawn and at return
bbd4122cb37f7481f6dd8bf34676c31a0a19899e
$ git rev-parse bbd4122^
8acd28df5e83e99953816c79d160b41eb1e3a447
$ git diff --stat 8acd28d bbd4122 -- libs/ test/ tools/ docs/specs/
(empty)
```

### 10.2 Each diff applies alone at the base and reverts cleanly

For each `N` in 1…5, at `bbd4122` with a clean tree:

```
$ git diff bbd4122 mut/wo-0073-l<N> -- libs/hardcaml_ethernet/src/xgmii_rx_64.ml > ic-l<N>.diff
$ git apply --check ic-l<N>.diff && git apply ic-l<N>.diff \
    && git apply -R ic-l<N>.diff && git diff --quiet -- libs/
ic-l1: applies alone at bbd4122, reverts clean
ic-l2: applies alone at bbd4122, reverts clean
ic-l3: applies alone at bbd4122, reverts clean
ic-l4: applies alone at bbd4122, reverts clean
ic-l5: applies alone at bbd4122, reverts clean
```

Each diff touches **one** file, `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, and
nothing else. Sizes: 18, 40, 63, 19, 36 diff lines.

### 10.3 Syntax, checked without building

No `dune` was run, on the working branch or anywhere. The five mutated sources and
the base were parsed with the OCaml front-end only:

```
$ ocamlc -stop-after parsing -dsource <file> > /dev/null
ic-l1: PARSES   ic-l2: PARSES   ic-l3: PARSES   ic-l4: PARSES   ic-l5: PARSES
base:  PARSES
```

**This is a syntax result and nothing more.** Type errors and Hardcaml width or
loop errors are not excluded by it, and per the packet's §2.1 a mutant that does
not compile is a **build finding**, never a behavioural one, with the build step's
own conclusion — not a green `test/cosim/` — as its evidence. The widths I reasoned
about by hand: `pc` and `strip` are both 4 bits (`popcount` of 8 bits, `of_int
~width:4`), so `pc -: strip` is 4 bits and `((pc -: strip) ==:. 2)` is well formed;
`keep_of_count` takes the same 4-bit count; `rearming`, `l3_block`, `l5_again` are
all 1 bit. IC-L3's `r2` register takes its own enable through `l3_block`, which
reads `sel` and therefore `r2` — a register output feeding its own enable, which is
`reg_fb`'s own shape and not a combinational loop.

### 10.4 The respawn precondition, checked before anything was cut

The dispatch required me to stop if any `mut/wo-0073-*` branch or any WO-0073
manifest already existed. Checked first:

```
$ git ls-remote --heads origin 'refs/heads/mut/wo-0073*'
(empty)
$ git ls-files | grep -i wo-0073
agents/handoffs/WO-0073_family-l-mutation-campaign-SEALED-predictions.md
agents/handoffs/WO-0073_family-l-mutation-campaign.md
```

No transient branch, and no manifest under `docs/reports/audit/`. The two files
found are the packet and its seal, which `bbd4122` staged and which the dispatch
expects. **Clean start confirmed.**

### 10.5 Refs touched

Created and pushed: `mut/wo-0073-l1`, `-l2`, `-l3`, `-l4`, `-l5`. **No other ref
was created, moved or deleted.** The working branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf` is at `bbd4122` at return, the
same commit it held at spawn, and this manifest is left unstaged for the
orchestrator to commit. No `git commit` and no `git push` touched the working
branch. One `git push --force-with-lease` was **attempted** against
`mut/wo-0073-l3` and **refused by repository rules**; the correction landed as a
fast-forward instead (§3).

---

## 11. Anything judged rather than followed, and the questions for ruling

1. **Q1 — the base SHA.** FINDING WO-0073-M1 (§1). §8's literal base is `8acd28d`,
   the parent of the packet's own commit; the dispatch and this campaign operate at
   `bbd4122`, the packet's commit itself. The trees are byte-identical at every path
   the campaign scores. I recorded it and proceeded rather than burning the round.
   **Ruling wanted**: confirm that every §8 reference to "the base SHA" reads
   `bbd4122`, and that the control run is `bbd4122`'s.
2. **Q2 — `mut/wo-0073-l3` carries two commits.** The tip `60ed49c` is the
   deliverable; `c66565d` is a superseded rendering that stranded the lane-4 members
   of R. Force-push was refused by repository rules (a good result — R9 holds on
   transient refs), so the correction is a fast-forward. **Ruling wanted**: score
   IC-L3 from the tip's CI run and discard `c66565d`'s if one exists.
3. **Q3 — IC-L2 registers the five strobes with the datapath.** §5.3 item 1. I read
   "the reserve is spent" as a uniform ΔC = 4 that preserves §9's strobe-on-`tlast`
   coincidence, and read the narrower alternative (delay `rx` only) as the class
   plus a skew defect. **Ruling wanted**: confirm the reading, or tell me the seal
   branched the other way.
4. **Q4 — IC-L2 and IC-L5 edit the same site.** Both touch the output record at
   989–1005 and their diffs carry the same hunk header. They are two separate
   diffs on two separate branches and **no diff combines two classes**; flagged so
   that the coincidence of site is not read as a combination under §7 item 1.
5. **Q5 — IC-L3's R is mine and is narrow.** §9.4. `R = {2}`, four members, `4 ∉ R`.
6. **What I did not do.** I applied no mutation to the working tree beyond the
   transient branches; I ran no `dune`; I read no `test/**` byte, no journal, and
   not one line of the sealed companion; I made no edit to any packet, plan or
   bench file; and I offer no scorecard — §15's items 4, 5 and 6 are the operator's
   and are not this manifest's to supply.

---

## 12. Summary line

Five classes, five single-class diffs, five transient branches, **none NOT
SEEDED**. IC-L1 at branch **A**/**D**; IC-L2 at branch **U**; IC-L3 at
**R = {2}**, delivered; IC-L4 at branch **S**; IC-L5 repeated **once**. Reachability
discharged term by term at the firing cycle for every lane, length and parity each
class's own required consequence names. The report path is declared as a negative
and no diff modifies a term of it. The §6 pre-ship check applies to IC-L2 and
IC-L3 and both pass. One finding filed before the run (WO-0073-M1, MINOR, base
identity). One rendering defect found by the per-lane discharge and corrected
before delivery (IC-L3's lane-4 members). Adjudication is dv_lead's, against a seal
this manifest's author has not read.
