# WO-0066 — the family-B/N mutation campaign: six classes, six diffs, seeded blind

- **Author**: auditor · **Packet**: `agents/handoffs/WO-0066_family-bn-mutation-campaign.md` (committed at `ebaac58`)
- **Base SHA**: **`199e319`** (`199e3198ea2d525aaf37d8578cf1b1949d9d03e2`)
- **Target**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, read at the base blob only
- **Deliverables**: this manifest + `ic-a.diff` … `ic-f.diff` in this directory
- **Status**: delivered before any run. No diff has been executed, elaborated or
  simulated — no toolchain able to do so exists in this environment (§8).

Every line-number citation below is a line of the **base blob**
(`git show 199e319:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`), and every
specification citation is to `docs/specs/requirements.md` or
`docs/specs/modules/xgmii_rx_64.md` at the working tree. **No file under
`test/**` was read, opened, listed or searched at any point** (§9).

---

## 1. The base SHA, verified rather than accepted (§7 item 6, §8)

WO-0066 §8 cannot state its own base hash and fixes it by description: *the
commit that this packet's own commit immediately follows*, carrying the
`tools/dv_checks.sh` census (`J-dv_lead-0114`). I verified the identity rather
than taking the spawn prompt's word for it:

| check | command | observed |
|---|---|---|
| the packet's commit | `git log -1 --format='%H %s' ebaac58` | `ebaac58…` *"Six classes sealed against eleven never-scored members - the packet and its seal in one commit"* |
| its parent | `git rev-parse ebaac58^` | **`199e3198ea2d525aaf37d8578cf1b1949d9d03e2`** |
| what the parent carries | `git show --stat 199e319` | `agents/journals/claude_dv_lead_agent.v04.md`, `tools/dv_checks.sh` — trailers `Agent: dv_lead`, `Work-Order: WO-0066`, `Journal-Entry: J-dv_lead-0114` |
| no scored byte moves in it | same | **no `test/**` path and no `libs/**` path in the commit** |
| the adjudicator-ordering rule (§8) | `git log --oneline 199e319..HEAD -- test/ libs/` | **empty** — nothing under `test/**` or `libs/**` has moved between the base and `HEAD` (`fb27764`) |
| the last bench edit | `git log -1 --date=iso -- test/` | `fa91964…` 2026-08-05T00:52:01Z — strictly earlier than the base |
| working tree clean | `git status --porcelain` | empty |
| the target file is the base blob | `git diff --quiet 199e319 -- libs/hardcaml_ethernet/src/xgmii_rx_64.ml` | identical |

**Agreement with §8: yes.** The hash I applied to is `199e319`, it is the parent
of the packet's commit, it carries the census tool and no scored byte, and the
bench is frozen strictly earlier in history than any mutant RTL. There is no
disagreement to raise as a pre-run finding.

**R-SEAL-1, redeemed** (recorded because §0 makes its absence a finding against
dv_lead, so its presence is equally mine to record): `ebaac58` stages
`agents/handoffs/WO-0066_family-bn-mutation-campaign-SEALED-predictions.md`
alongside the packet, in the same commit, before any diff existed. The forward
commitment at `RV-0065B-VERDICT` §7.1 falls due here and **is** redeemed. I
verified this from `git show --stat ebaac58` — **the file name only**. I have
not opened it, and its 679 lines are unread.

---

## 2. The stimulus geometry, derived from the specification and the packet only

Everything below turns on *where* each class's gate fires, so the geometry is
derived first, from two sources I may read, and never from a bench file.

**SPEC-M03 §6.1's six-row table** (module spec lines 338–345) enumerates the six
combinations of *(the start character's lane in W, the aborted frame's own start
lane, whether the aborted frame delivered an octet)* and pins both reports. WO-0066
§4 independently describes its sub-cases 4, 5 and 6. The two agree row for row,
which is what fixes the mapping:

| sub-case | `/S/` in W at lane | frame A began at | A delivered | A's report | B's report | coincide? |
|---|---|---|---|---|---|---|
| 1 | 0 | lane 0 | ≥ 1 | W + 1 | W + 2 | no |
| 2 | 0 | lane 4 | ≥ 1 | W + 1 | W + 2 | no |
| 3 | 0 | either | 0 | W + 2 | W + 2 | **yes** |
| 4 | **4** | lane 0 | 4 | **W + 2** | W + 2 | **yes** |
| 5 | **4** | lane 4 | 8 | W + 1 | W + 2 | no |
| 6 | **4** | either | 0 | W + 2 | W + 2 | **yes** |

Sub-cases 4, 5 and 6 are WO-0066 §4's three bound-7 instances verbatim (A's SFD
at lane 7 of the preceding word ⇒ A began at lane 0; A's octets 0…3 in lanes 4…7
of the preceding word ⇒ A began at lane 4; A's SFD at lane 3 of W ⇒ A began at
lane 4 with zero delivered). The mapping is then forced by the coincidence
column: WO-0066 §1's IC-C requires exactly **3, 4 and 6** to redden and **1, 2
and 5** to stay green, and rows 3, 4 and 6 are exactly the coincident rows. Two
documents that never cite each other agree on which three; I take that as the
mapping's proof rather than as a coincidence of my own.

**Three consequences the classes below rest on**, all from §6.1's own text:

1. **Frame B is opened *and closed* inside word W.** §6.1: *"the **new** frame
   emits no output word and the character that ended it lies in W, so §9 pins its
   report at **W + 2**, always"*, and its minimal witness spells the word out —
   *"`/S/` in lane 0 of word W − 1; word W carries that frame's octets 0 … 3 in
   lanes 0 … 3, a `/S/` in lane 4 and a `/T/` in lane 6"*. In the base design an
   epoch opened and closed in one word is reported by the **in-word path**
   (`inword_strobes` → `q2`, base 570–590), **not** by the aged closure record.
   This is why IC-B(R) and IC-E each need a second site: a rendering that touched
   only `a_close_runt` would not redden a single N sub-case.
2. **Frame A's abort is reported by the epoch-A path** (`a_close_start` → `r0` →
   `sel_start` → `strobe`), because A is the frame open on entry to W.
3. **The two names are fixed**: A's is always `error_start_without_terminate`
   (REQ-110), B's is `error_runt` — WO-0066 §3 records the registrations at
   `test_m03_n.ml:497` and `:509` under exactly those two names, which is how I
   know B's closing character is a `/T/` and not an `/E/`.

**The B2 lane pair** (IC-D, IC-F). §6.1's preamble-position paragraph
(module spec 281–300): at a **lane-0** start all eight preamble positions are
lanes 0…7 of the start word itself; at a **lane-4** start they are lanes 4…7 of
the start word and lanes 0…3 of the next. Writing the positions as octet times
`s … s+7` with lane = (octet time mod 8) and word = ⌊octet time / 8⌋, the two
enumerations are

- lane-0 start, `s = 8w`: `{(w,0),(w,1),(w,2),(w,3),(w,4),(w,5),(w,6),(w,7)}` —
  one word, no recurrence;
- lane-4 start, `s = 8w+4`: `{(w,4),(w,5),(w,6),(w,7),(w+1,0),(w+1,1),(w+1,2),(w+1,3)}`
  — two words, the set enumerated rather than assumed.

WO-0066 §5 names the two landing lanes as **lane 3** and **lane 7**; those are
the last member of each enumeration — the SFD position — so **lane 7 belongs to
the lane-0 start and lies in the start word (the in-word path), and lane 3
belongs to the lane-4 start and lies in the word after it (epoch A's path)**.
The two lanes are therefore decoded by **two different gates**, and a diff
touching one reddens one member of each code. Both are touched by IC-D and IC-F,
and both are discharged separately in §3.

---

## 3. The six diffs

Each diff applies alone to `199e319`, touches one class, and reverts cleanly
(§8). No diff combines two classes.

### IC-A — `ic-a.diff` — the in-word REQ-110 abort is recognised only at a word boundary

**Mutated expression** (base line 375, one line):

```ocaml
(* before *) let a_close_start = a_closes_with lanes.is_start in
(* after  *) let a_close_start = a_closes_with (lanes.is_start &: of_int ~width:8 0x01) in
```

**The rendering, and the literal one I rejected.** My first rendering also moved
the unrecognised start character into `a_hold_v` (base 328) so that it would be
handled as REQ-016's hold — the literal reading of D-A2's branch **E**. I
evaluated it on the actual stimulus and **rejected it**: `a_closing_v` (base
312–314) contains `lanes.is_terminate` at *all eight lanes*, so with the lane-4
`/S/` removed from that vector the lowest set bit becomes **the `/T/` at lane 6
that closes frame B**, and epoch A is then closed *as a terminate* with
`count_next` = 4 / 8 / 0. That rendering pulses `error_runt` for frame A and, at
sub-case 5 (`count_next` = 8 ≥ `fcs_min_octets`), `error_bad_fcs` as well —
a third and a fourth strobe name, both of which WO-0066 §9 declares **findings
rather than rendering facts**, and it emits frame A's `tlast` word instead of
suppressing it, contradicting §9's own sealed direction (*"fewer under IC-A(E)
(the frame is suppressed)"*). The one-line rendering above leaves the character
in `a_closing_v`, so epoch A's lane range still ends at its own octet time —
which is REQ-110's lane rule (*"a start character in lane 4 leaves lanes 0 to 3
of that word belonging to the aborted frame"*) — while no closure condition is
raised for it. This is the disclosure J-auditor-0013's shape asks for: the
literal rendering of an intent, refuted by evaluating the gate rather than by
reasoning about fan-out.

**R-DISC-1 — reachability, per sub-case, at the firing cycle W.**
Gate: `a_close_start`, base 375, whose complete definition expands through

```
365  let a_closes_with v = a_char_acts &: any (v &: a_close_oh)
364  let a_char_acts    = a_open &: ~:a_close_oversize
315  let a_close_oh     = lowest_set a_closing_v
312  let a_closing_v    = lanes.is_terminate |: lanes.is_error |: lanes.is_start
                          |: (other_ctl &: a_pre_mask)
296  let a_open         = in_preamble |: in_frame
361  let a_close_oversize = a_open &: (cap_end <: a_char_end) &: (cap_end <: a_hold_end)
                            &: (cap_end <:. 8)
```

| conjunct | sub-case 4 | sub-case 5 | sub-case 6 | contributed by |
|---|---|---|---|---|
| `a_open` | 1 (`Frame`) | 1 (`Frame`) | 1 (`Preamble`) | **stimulus** — §6.2's rows; WO-0066 §4's state column |
| no closing bit below lane 4 in `a_closing_v` | 1 (lanes 0…3 are A's octets, not control) | 1 (same) | 1 (lanes 0…3 are A's preamble filler, data lanes, so `other_ctl &: a_pre_mask` = 0 there) | **stimulus** |
| `a_close_oh` = lane 4 | 1 | 1 | 1 | the `/S/` — **the mutation's own term** |
| `~:a_close_oversize` | 1 | 1 | 1 | **stimulus**: `count` ≤ 8 ⇒ `cap_room` ≥ 1510 ⇒ `cap_end` = 8, and `a_char_end` = 4 < 8 |
| `any (lanes.is_start &: a_close_oh)` — base | 1 | 1 | 1 | the `/S/` |
| `any ((lanes.is_start &: 0x01) &: a_close_oh)` — **mutant** | **0** | **0** | **0** | the mutation |

⇒ `a_close_char` = 0 ⇒ `a_close_now` = 0 (base 377) ⇒ **no closure record is born
for frame A at W**, at all three sub-cases. Coverage is unchanged: `cov_end` =
min(`a_char_end` = 4, `cap_end` = 8, `a_hold_end` = 8) = 4 in base and mutant
alike, so A's delivered count stays 4 / 8 / 0 and the CRC sees the same octets.
Sub-cases **1, 2 and 3** are evaluated too and are **green by construction**:
their `/S/` is in lane 0, `a_close_oh` = lane 0, and `lanes.is_start &: 0x01` is
1 there — the abort is decoded exactly as before.

**Expected killing behaviour (spec-derived).** At sub-cases 4, 5 and 6 the single
`error_start_without_terminate` that REQ-110 and SPEC-M03 §9's last two rows
require for frame A **never pulses** — not at §6.1's tabulated W + 2 (sub-cases 4
and 6), not at W + 1 (sub-case 5), not anywhere. Derived pulse count at each of
the three: **1** (frame B's `error_runt` at W + 2, unchanged) against the
conformant **2**. Derived output-word count for frame A: **0** against the
conformant **1** at sub-cases 4 and 5 — the frame is left open, its aligned word
is never `decided` (`closure_aligned` needs `closed`, and `ev12` is 0 once the
line returns to idle, base 955–958), so `hold` stays high and no `tvalid` word
leaves. Sub-case 6 delivered nothing in either design. No third strobe name
appears and `error_bad_fcs` stays absent (the record that would carry it is never
born). *Caveat stated in advance*: frame A is left **open**, so a start character
later in the same unit's stimulus would abort it then and displace the pulse
rather than delete it; at the pinned cycles the count is still 1, never 2.

**Predicted red set**: `M03-N2` sub-cases 4, 5 and 6, plus any unit whose
stimulus aborts a frame **open on entry to the word** with a start character
above lane 0. **Predicted green**: `M03-N2` sub-cases 1, 2, 3, and — named in
advance per WO-0066 §3.1 — `M03-B4` member (a) and `M03-H4`'s word c, whose
lane-4 aborts have nothing open on entry (`a_open` = 0 ⇒ `a_char_acts` = 0 in
base and mutant alike) and whose reports come from the in-word path this diff
does not touch.

### IC-B — `ic-b.diff` — the zero-delivered close is mis-scored (rendering **R**)

**Mutated expressions** (two sites, one defect: *`error_runt` requires at least
one delivered octet*).

```ocaml
(* base 502 — the epoch-A path *)
(* before *) let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
(* after  *) let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) &: has_fcs in

(* base 573 — the in-word path, inside inword_strobes *)
(* before *) let terminate = closed &: any (lanes.is_terminate &: oh) in
(* after  *) let terminate = gnd in
```

`has_fcs` (base 470) is `count_next >=:. fcs_min_octets`, i.e. `count_next ≥ 5`,
which is exactly *delivered ≥ 1* once REQ-103's four FCS octets come off — the
design's own signal, so the floor costs no new arithmetic. On the in-word path
every reported frame delivers **zero** octets by construction (base 546–552: its
eight preamble positions fill the rest of the word), so the same floor is never
met there and the bit is constantly low; `gnd` is that floor's evaluated value,
not a second decision.

**R-DISC-1 — per sub-case, at the firing cycle W.** Gate: the `terminate` bit of
`inword_strobes` (base 573) feeding `q2` bit 1 (base 581–590) and `q_strobe 1`
(base 991, 1002).

| conjunct | sub-cases 1–3 (`/S/` lane 0) | sub-cases 4–6 (`/S/` lane 4) | contributed by |
|---|---|---|---|
| `exists` = `b_exists` / `c_exists` (base 421–422) | `bit lanes.is_start 0` = 1 | `bit lanes.is_start 4` = 1 | **stimulus** |
| `cfg_rx_enable`, `~:clear` | 1, 1 | 1, 1 | **stimulus** |
| `closing` = `inword_closing 0xfe` / `0xe0` (base 418–424) | `/T/` at a lane ≥ 1 | `/T/` at a lane ≥ 5 | **stimulus** (§6.1's witness: lane 6) |
| `oh` = `lowest_set closing` = the `/T/`'s lane | 1 — the lanes between the `/S/` and the `/T/` are preamble filler data lanes | 1 — same | **stimulus** |
| `closed = exists &: any closing` | 1 | 1 | stimulus |
| `any (lanes.is_terminate &: oh)` — base | 1 | 1 | stimulus |
| the whole bit — **mutant** | **0** | **0** | the mutation |

⇒ frame B's `error_runt`, which SPEC-M03 §9 pins at **W + 2** (*"two cycles after
the input word carrying the character that ended the frame"*) at every one of
the six, **never pulses**. All six sub-cases are seeded and observable.

The second site (`a_close_runt`) is reached by a *different* geometry — a `/T/`
closing a frame in a **later** word than its start character, with `count_next` <
5 — for which WO-0066 names no sub-case, so no per-sub-case discharge is possible
and none is claimed. Its gate evaluation is generic and complete: `a_close_terminate`
= 1, `count_next` ∈ {0,1,2,3,4} ⇒ `count_next <:. 64` = 1 and `has_fcs` = 0 ⇒
the runt bit is 0 where the base had 1. Every strobe it suppresses is a
zero-delivered close's, and no other.

**Expected killing behaviour (spec-derived).** Every frame that REQ-107's second
sentence and §9's sixth row give *"no output words at all and one `error_runt`"*
now produces **no report of any kind**, at both report paths. §0.6's conservation
equation is then short by one frame at each such unit, and §9's *"a bench SHALL
assert `error_runt` alone on every frame of 0 to 4 octets — an exact strobe set"*
fails on the empty set. Derived pulse count at each N sub-case: **1**
(`error_start_without_terminate` only) against the conformant **2**. No output
word appears anywhere (this rendering emits nothing new), so frame B's word count
stays **0** as §9 requires of every class but IC-B(W).

**Predicted red set (D-B2 = narrow)**: the **ten** units of WO-0066 §3's table
whose no-output-word registration is an `error_runt` — `M03-B3`, `M03-F2`,
`M03-G7`, `M03-I2` member (iii), and `M03-N2` × 6 — plus any unit not in that
table that asserts an `error_runt` for a frame closed by `/T/` having received
fewer than five octets. **Predicted green**: every `error_bad_frame` and
`error_start_without_terminate` no-output-word unit (the other eight of the
eighteen), and every runt of 5…63 octets, which delivers ≥ 1 octet and clears the
floor.

### IC-C — `ic-c.diff` — the coincidence is serialised

**Mutated expression** (base 991, one site):

```ocaml
(* before *) let q_strobe k = bit q2 k &: ~:(i.clear) in
(* after  *) let coincident  = consume &: abort in
             let q2_deferred = reg spec (q2 &: repeat coincident 3) in
             let q_strobe k  = ((bit q2 k &: ~:coincident) |: bit q2_deferred k) &: ~:(i.clear) in
```

`consume` (base 518, 977) is *"epoch A's closure record is being consumed this
cycle"* and `abort` (base 975) is *"that record raises at least one strobe"*.
Their conjunction is high on exactly the cycles epoch A reports. Keying on
`consume` alone was rejected: a clean frame's record is consumed with no strobe
raised, and deferring against that would move reports generally rather than
coincident ones — which WO-0066 §1's IC-C paragraph says makes the measurement
worthless.

**R-DISC-1 — per sub-case, at the deferral cycle.** Gate: `coincident`, evaluated
at the cycle `q2` presents frame B's report, i.e. **W + 2** at every sub-case
(§6.1: *"always"*).

| sub-case | epoch A's record consumed at | `abort` on that record | `coincident` at W + 2 | effect |
|---|---|---|---|---|
| 1 | W + 1 (its `tlast`, `emit_tlast`) | `sel_start` = 1 | **0** — at W + 2 the record is gone: `r1`/`r2` were cleared by the consume mask (base 526–527), so `sel_valid` = 0 | **green** |
| 2 | W + 1 | 1 | **0** | **green** |
| 3 | W + 2 (age 2, `sel_is_r2`, no `tlast` word) | 1 | **1** | **red** |
| 4 | W + 2 (its `tlast`; §6.1 row 4) | 1 | **1** | **red** |
| 5 | W + 1 | 1 | **0** | **green** |
| 6 | W + 2 (age 2) | 1 | **1** | **red** |

The `consume` term is **stimulus-contributed** in the sense that matters: which
cycle epoch A's record is consumed on is fixed by A's own delivered count and
start lane (§6.1's table), not by the mutation. At sub-cases 3, 4 and 6 frame B's
three-bit `q2` word is masked out of `q_strobe` and re-presented one cycle later
by `q2_deferred`, so `error_runt` pulses at **W + 3**.

**Expected killing behaviour (spec-derived).** At sub-cases 3, 4 and 6 frame B's
`error_runt` moves from §9's pinned **W + 2** to **W + 3** — one cycle **later**,
never earlier, which is the direction WO-0066 §9 seals for this class. §0.6 is
explicit that a pulse elsewhere inside the window is *"inside this window and
**non-conformant**, on §9's authority"*, and at W + 3 it is exactly at the
window's ceiling (ΔC = 3). Nothing else moves: at sub-cases 1, 2 and 5 the two
reports are already a cycle apart by their own stimulus arithmetic, `coincident`
is 0 on B's report cycle, and `q_strobe` is bit-identical to the base.

**Predicted red set**: `M03-N2` sub-cases 3, 4 and 6 — and, per WO-0066 §11 item
2, nothing else in the bench, because no other unit pins two reports to one
cycle. **Predicted green**: sub-cases 1, 2, 5 and every other unit. This is the
class whose entire convicting set lies inside the new eleven, so it is the round's
own measurement, and it is also the class §6's datapath check exists for (§5).

### IC-D — `ic-d.diff` — REQ-113's ignore rule is carried into a preamble position

**Mutated expressions** (three sites, one defect: *an other-control character in
a preamble position is ignored rather than routed to REQ-105*).

```ocaml
(* base 312 — epoch A's preamble positions *)
(* before *) lanes.is_terminate |: lanes.is_error |: lanes.is_start |: (other_ctl &: a_pre_mask)
(* after  *) lanes.is_terminate |: lanes.is_error |: lanes.is_start

(* base 372 — the same character's REQ-105 classification *)
(* before *) a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
(* after  *) a_closes_with lanes.is_error

(* base 418 — the in-word epochs, every lane of which above their own /S/ is a preamble position *)
(* before *) (lanes.is_terminate |: lanes.is_error |: lanes.is_start |: other_ctl) &: above
(* after  *) (lanes.is_terminate |: lanes.is_error |: lanes.is_start) &: above
```

The REQ-016 hold (`a_hold_v`, base 328) is deliberately **untouched**: outside a
preamble position an other-control character still ends coverage and carries the
frame forward, which is REQ-113 read correctly. Only the preamble-position
routing changes, which is the class.

**R-DISC-1 — per lane, at the firing cycle.**

*Lane 3, at a **lane-4** start* (epoch A's path). Firing cycle W₁ = the word after
the start word. Gate: `a_close_error`, base 372.

| conjunct | value | contributed by |
|---|---|---|
| `in_preamble` (base 260) | 1 — W₁ is the cycle after the `/S/` was accepted (§6.2's `Preamble` row) | **stimulus** |
| `frame_start4` (base 432) | 1 — the frame's start lane was 4 | **stimulus** |
| `a_pre_mask` = `repeat (in_preamble &: frame_start4) 8 &: 0x0f` (base 308) | `0x0f` | the two above |
| `other_ctl` bit 3 (base 243) | 1 — lane 3 is control and is neither `/S/`, `/T/` nor `/E/` (`/I/` = 0x07 or `/Q/` = 0x9C, requirements.md §2) | **stimulus** |
| `a_close_oh` = lane 3 | 1 — lanes 0…2 are preamble filler **data** octets, so no lower bit is set | **stimulus** |
| `a_char_acts` | 1 — `a_open` = 1, and `cap_end` = 8 > `a_char_end` = 3 so `a_close_oversize` = 0 | stimulus |
| `any ((lanes.is_error |: (other_ctl &: a_pre_mask)) &: a_close_oh)` — base | **1** ⇒ `error_bad_frame`, no output word | stimulus |
| the same term — **mutant** | **0** — the `other_ctl` disjunct is gone | the mutation |

*Lane 7, at a **lane-0** start* (the in-word path). Firing cycle W = the start
word itself. Gate: the `error` bit of `inword_strobes` (base 574) feeding `q2`
bit 0.

| conjunct | value | contributed by |
|---|---|---|
| `b_exists` (base 421) | 1 — `/S/` in lane 0, `cfg_rx_enable` = 1, `clear` = 0 | **stimulus** |
| `b_closing` = `inword_closing 0xfe` (base 423) | bit 7 set — `other_ctl` bit 7 = 1 and 7 ∈ 0xfe | **stimulus** |
| `oh` = lane 7 | 1 — lanes 1…6 are preamble filler data octets | **stimulus** |
| `closed` | 1 | stimulus |
| `any ((lanes.is_error |: other_ctl) &: oh)` — base | **1** ⇒ `error_bad_frame` at W + 2 | stimulus |
| `b_closing` — **mutant** | **0** ⇒ `closed` = 0 ⇒ the whole vector is 0 | the mutation |

Both lanes are seeded; neither is NOT SEEDED. **D-DF1 = C** is discharged at both:
at lane 3 the un-exited preamble leaves `a_char_end` = 8 and `a_hold_end` = 8
(lane 3 is inside `a_pre_mask`, so `a_hold_v` excludes it), giving `cov_end` = 8
against `cov_first` = 4 — the frame's first four octets are covered and it enters
`Frame`; at lane 7 `survivor_b` = 1 ⇒ `begins` = 1 ⇒ the frame carries into
`Preamble` at W + 1 with `cov_first` = 0 and delivers normally.

**Expected killing behaviour (spec-derived).** REQ-102's third sentence and §6.2's
`Preamble` row require *one* `error_bad_frame` and *no output word* for a frame
carrying `/I/` or `/Q/` in a preamble position; the mutant pulses **no strobe at
all** and instead delivers the frame's octets as output words. Both halves are
observable: the missing pulse at the §9 no-output-word pin (W₁ + 2 and W + 2
respectively), and REQ-008/§0.6's conservation equation, which counts a frame
neither emitted nor strobed.

**Predicted red set (D-D2 = wide)**: `M03-B2`'s **four** `/I/` and `/Q/` members —
both codes at both start lanes — and any other unit driving a control character
other than `/S/`, `/T/`, `/E/` into a preamble position. **Predicted green**:
`M03-B2`'s `/E/` member at both lanes (the control WO-0066 §1 makes load-bearing:
`lanes.is_error` is untouched in all three sites), every `/T/`-in-a-preamble
member, and all six `M03-N2` sub-cases — the N stimulus routes its `/T/` through
`lanes.is_terminate`, which this diff does not touch.

### IC-E — `ic-e.diff` — the runt check is sequenced on the abort path

**Mutated expressions** (two sites, one defect: *the runt test is applied to the
abort path as well as to REQ-106's terminate exit*).

```ocaml
(* base 502 — the epoch-A path *)
(* before *) let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
(* after  *) let a_close_runt = (a_close_terminate |: a_close_start) &: (count_next <:. runt_threshold) in

(* base 581 — the in-word path *)
(* before *) concat_lsb [ error; terminate; start ]
(* after  *) concat_lsb [ error; terminate |: start; start ]
```

**R-DISC-1 — per sub-case, at the firing cycle W.** Gate: the record's runt field
(base 502 → `r0` bit 6 → `sel_runt` → `strobe sel_runt`, base 1002).

| conjunct | sub-cases 1–6 | contributed by |
|---|---|---|
| `a_close_start` | 1 at every sub-case — this is frame A's REQ-110 abort | **stimulus** |
| `count_next <:. 64` | 1 — `count_next` = 0, 4 or 8 (§6.1's table's *delivered* column) | **stimulus** |
| the record's runt bit — base | 0 | — |
| the record's runt bit — **mutant** | **1** | the mutation |

The mutation therefore **fires at all six sub-cases**. Its *observability* does
not follow, and the difference is where this class parts from the other five:

| sub-case | A reports at | B's `error_runt` at | `error_runt` high cycles, base | mutant | verdict |
|---|---|---|---|---|---|
| 1 | W + 1 | W + 2 | 1 (W + 2) | **2 (W + 1, W + 2)** | **red** |
| 2 | W + 1 | W + 2 | 1 | **2** | **red** |
| 5 | W + 1 | W + 2 | 1 | **2** | **red** |
| 3 | W + 2 | W + 2 | 1 (W + 2) | **1 (W + 2)** | **not observable** |
| 4 | W + 2 | W + 2 | 1 | **1** | **not observable** |
| 6 | W + 2 | W + 2 | 1 | **1** | **not observable** |

At sub-cases 3, 4 and 6 the added pulse lands on the **same cycle** as frame B's
own `error_runt`. requirements.md §0.6's counting convention — *"the observable is
one high cycle per reported event … a monitor counts high cycles, never rising
edges"* — makes two events under one name on one cycle a single high cycle, so
the mutant's output is **bit-identical to the conformant design's** at those
three. I therefore **declare sub-cases 3, 4 and 6 NOT SEEDED for scoring
purposes** under IC-E: the mutation is present and its gate fires, but no
observable distinguishes it there, and a green at those three is a fact about
§0.6's convention rather than about the bench. This is raised as a pre-run
reading note in §7.

The in-word site is discharged separately: at an epoch opened and closed inside
one word by a `/S/` (WO-0066 §3.1's `M03-B4` member (a) and `M03-H4` word c),
`start` = 1 ⇒ the runt bit of `q2` is 1 where the base had 0, and `error_runt`
gains a high cycle at that unit's `error_start_without_terminate` cycle, where
the conformant design has none. No coincidence collapses it, because those units
have no other `error_runt` to merge with.

**Expected killing behaviour (spec-derived).** SPEC-M03 §9's last two rows give a
REQ-110-aborted frame `error_start_without_terminate` **alone**; the runt rows key
on *"octets between start and terminate"* and an aborted frame has no terminate.
The mutant adds an `error_runt` high cycle to every abort of a frame that received
fewer than 64 octets while open. Derived pulse count at sub-cases 1, 2 and 5:
**3** (`error_start_without_terminate` and `error_runt` at W + 1, `error_runt` at
W + 2) against the conformant 2. `error_bad_fcs` stays absent — the record's FCS
field is `a_close_terminate &: bad_fcs` (base 513) and `a_close_terminate` is 0 on
an abort.

**Predicted red set (D-E1 = the floor includes zero)**: `M03-N2` sub-cases 1, 2
and 5; `M03-B4` members (a) and (b); `M03-H4` (both registrations, if word c's
abort is one of them) — WO-0066 §1.6's *"three units outside family N"*, which is
exactly the count of `error_start_without_terminate` units outside family N in §3's
table. Plus any unit driving a REQ-110 abort of a frame that received fewer than
64 octets. **Predicted green / not observable**: sub-cases 3, 4 and 6 as declared
above; every abort of a frame that received ≥ 64 octets.

### IC-F — `ic-f.diff` — the preamble-position routing is a closed code table

**Mutated expressions** (six hunks, one defect: the extensional *"any other
control character"* becomes the enumeration {`/S/`, `/T/`, `/E/`, `/I/`}).

```ocaml
(* new, beside the other three code constants at base 106–108 *)
let idle_char = 0x07

(* new field on the per-lane decode record (base 178–194) *)
; is_idle : Signal.t          (* in type lanes *)
; is_idle = vector ~f:(fun k -> matches k idle_char)   (* in decode_lanes *)

(* base 312 *) …|: (other_ctl &: a_pre_mask)   ⇒   …|: (lanes.is_idle &: a_pre_mask)
(* base 372 *) a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
               ⇒ a_closes_with (lanes.is_error |: (lanes.is_idle &: a_pre_mask))
(* base 418 *) (…|: lanes.is_start |: other_ctl) &: above
               ⇒ (…|: lanes.is_start |: lanes.is_idle) &: above
```

The base design compares against **three** codes and lets everything else fall
through — base 99–105 says so in terms: *"[idle] and [ordered_set] are named but
never compared against … the way to implement 'ignored' without a hole is to test
for the three that matter and let everything else fall through."* IC-F adds the
fourth comparison, which is what turns routing-by-the-control-bit into
routing-by-an-enumeration. `0x07` is requirements.md §2's normative idle code.

**R-DISC-1 — per lane, at the firing cycle.** The gates and their conjuncts are
IC-D's, evaluated identically (the same two tables above), with one term
substituted:

| lane / start lane | gate | base term | mutant term | `/I/` (0x07) | `/Q/` (0x9C) | `/E/` (0xFE) |
|---|---|---|---|---|---|---|
| lane 3 / lane-4 start | `a_close_error` (372) | `other_ctl &: a_pre_mask` | `lanes.is_idle &: a_pre_mask` | 1 ⇒ **green** | **0 ⇒ red** | 1 via `lanes.is_error` ⇒ **green** |
| lane 7 / lane-0 start | `inword_strobes.error` (574) via `b_closing` (423) | `other_ctl` | `lanes.is_idle` | 1 ⇒ **green** | **0 ⇒ red** | 1 ⇒ **green** |

Both lanes seeded; neither NOT SEEDED. `lanes.is_idle` bit k is
`control k &: (lane k ==:. 0x07)` — the design's own `matches` idiom (base
188) — so it is 1 exactly at an `/I/` lane and 0 at a `/Q/` lane, which is the
one distinction this class exists to make. **D-DF1 = C** is discharged exactly as
for IC-D: with the `/Q/` outside the enumeration, `a_char_end` = 8 at lane 3 and
`survivor_b` = 1 at lane 7, and the frame continues and delivers.

**Expected killing behaviour (spec-derived).** REQ-102's third sentence is
extensional — *"any other control character"* — and SPEC-M03 §6.2's `Preamble`
row names `/I/` **and `/Q/`** in the same shape. A frame carrying `/Q/` in a
preamble position owes one `error_bad_frame` and no output word; the mutant emits
its octets and pulses nothing, and §0.6's conservation equation is short by one
frame.

**Predicted red set**: `M03-B2`'s **two** `/Q/` members (one per start lane), and
any other unit driving a control character outside {`/S/`, `/T/`, `/E/`, `/I/`}
into a preamble position. **Predicted green**: `M03-B2`'s `/I/` members and its
`/E/` members at both lanes, every `/T/`-in-a-preamble member, and all six
`M03-N2` sub-cases.

---

## 4. The seven mandatory disclosures, answered as facts of these diffs

**D-A1 — the axis IC-A's non-recognition keys on: `O`.** The diff touches
`a_close_start`, which is **epoch A's** classification — epoch A being, by the
design's own construction (base 266–296), *the frame open on entry to this word*.
The in-word epochs' abort decode (`inword_strobes`' `start` bit, base 575) is not
touched, so a lane-4 `/S/` whose victim was opened **in that same word** still
aborts it correctly. That is exactly branch **O**: the failure needs the lane
**and** a frame open on entry. Within epoch A the keying is by lane alone (lane 0
aborts, any other lane does not), but since REQ-101 begins frames only in lanes 0
and 4 and §6.3 item 3 leaves any other start lane unconstrained, the only
reachable distinction is lane 0 against lane 4. Consequence I accept in advance:
bound 7 is scored **3 of 3** if sub-cases 4, 5 and 6 all redden, since all three
have A open on entry (§4's own state column), and `M03-B4` (a) / `M03-H4` word c
must stay **green** — a red at either is a finding against me, not against the
bench.

**D-A2 — where the unrecognised `/S/` lands: `E`, with its landing named.** It is
**not** consumed as a data octet (that is `P`, and I rejected it): the character
stays in `a_closing_v`, so epoch A's coverage still ends at its own octet time and
not one octet later — REQ-110's lane rule and the frame's octet count and CRC are
untouched. What it loses is the abort *condition*: no closure record is born, so
the frame carries forward unclosed and unreported, which is this design's existing
handling for a control character other than `/T/` inside a frame at a
non-preamble lane (C-14.4's hold, base 320–327). **Precision the packet's wording
does not carry, disclosed rather than assumed**: at all three sub-cases the
lane-4 `/S/` is *outside* epoch A's preamble positions — at sub-cases 4 and 5
because A is in `Frame`, at sub-case 6 because A's preamble positions are lanes
0…3 of W — so the fall-through lands on the hold, **not** on REQ-105, and frame A
therefore gets **no report at all** rather than an `error_bad_frame`. Both of
WO-0066 §9's own rows corroborate that this is the branch the seal derives
(*"a third name is a finding"*; *"fewer under IC-A(E) (the frame is suppressed)"*).

**D-B1 — which half I broke: `R`.** The report is suppressed below a
delivered-octet floor. I did **not** render `W`, and §7 records why the `W`
branch appears unreachable by any minimal diff in this design.

**D-B2 — the scope: `narrow`.** Only REQ-107's zero-delivered close is
mis-scored. REQ-105's and REQ-110's no-output-word closures report through
`sel_error` / `sel_start` and `q2` bits 0 and 2, none of which this diff touches,
so they still pulse. Predicted set is the **ten** `error_runt` no-output-word
units of §3's table, not the eighteen.

**D-D2 — does IC-D's carried-in ignore reach `/Q/`: `wide`.** The ignore is keyed
on **any control character REQ-113 would ignore outside a frame** — the design's
`other_ctl`, which is *"control and none of `/S/`, `/T/`, `/E/`"* — so both `/I/`
and `/Q/` are ignored and the campaign scores **2 of 2** on IC-D. Rendering it
narrow would have required *adding* an idle-code comparison the base design does
not contain, which is machinery rather than a subtraction, and is IC-F's own
defect rather than IC-D's.

**D-DF1 — what the un-exited preamble does: `C`, for both IC-D and IC-F.** The
preamble runs on, the SFD position is accepted without being looked at (REQ-102
forbids validating those values and the design never does), and the frame
delivers its octets normally. Discharged term by term at both lanes in §3: at a
lane-4 start `cov_end` = 8 against `cov_first` = 4, and at a lane-0 start
`survivor_b` = 1 ⇒ `begins` = 1. `S` (stop silently) is not produced by either
diff.

**D-E1 — does IC-E's floor include zero: `yes`.** The predicate is the design's
own `count_next <:. runt_threshold`, applied unchanged to the abort path, and 0 <
64, so the zero-delivered sub-cases are inside it. Two consequences I accept in
advance: the class reaches the three `error_start_without_terminate` units outside
family N (WO-0066 §1.6's own figure), and it reaches N sub-cases 1, 2 and 5 — the
other three being unobservable for the reason §3 derives and §7 raises.

---

## 5. R-DISC-2 — gate inventory, before delivery

### The report path

| term (base line) | what it is | IC-A | IC-B | IC-C | IC-D | IC-E | IC-F |
|---|---|---|---|---|---|---|---|
| `a_close_now` (377) | epoch A's record is born | **suppressed at a lane > 0 `/S/`** | — | — | suppressed at a preamble other-ctl | — | suppressed at a preamble `/Q/` |
| `a_close_terminate` (366) | REQ-106/107 exit | — | read | — | — | read | — |
| `a_close_error` (372) | REQ-105 exit | — | — | — | **narrowed to `/E/`** | — | **narrowed to `/E/` + `/I/`** |
| `a_close_start` (375) | REQ-110 exit | **narrowed to lane 0** | — | — | — | **read** (new term of the runt bit) | — |
| `a_close_runt` (502) | the record's runt field | — | **+ `has_fcs`** | — | — | **+ `a_close_start`** | — |
| `r0`/`r1`/`r2`, `sel_*` (503–534) | the three-age record | — | — | — | — | — | — |
| `consume` (518, 977) | the record is reported now | — | — | **read** | — | — | — |
| `strobe s` (990) | epoch A's five outputs | — | — | — | — | — | — |
| `inword_strobes.terminate` (573) | the in-word runt bit | — | **forced 0** | — | — | — | — |
| `inword_strobes.error` (574) | the in-word `error_bad_frame` bit | — | — | — | dead-but-present (see below) | — | — |
| `inword_strobes.start` (575) | the in-word abort bit | — | — | — | — | **read** (new term of the runt bit) | — |
| `q2` (583–590) | the two-stage in-word report | — | written via 573 | **read** | — | written via 581 | — |
| `q_strobe` (991) | the in-word outputs | — | — | **deferred on coincidence** | — | — | — |

### The output-word path

| term (base line) | IC-A | IC-B | IC-C | IC-D | IC-E | IC-F |
|---|---|---|---|---|---|---|
| `cov_first` / `cov_end` / `cov` / `cov_count` (296–383) | unchanged at the firing lane (`a_hold_end` and `a_char_end` both give 4) | — | — | **widened** where the ignored character was the lowest closer | — | **widened** at a `/Q/` |
| `count_next` (398), `crc_reg` (478) | unchanged | — | — | changed by the widened coverage | — | changed by the widened coverage |
| `al_data`/`al_keep`/`al_new` (740–745) | — | — | — | changed | — | changed |
| `pc`, `nc`, `strip` (795–800) | — | — | — | changed | — | changed |
| `closed` = `sel_valid`, `closure_aligned`, `decided` (956–958) | **never asserted for the unclosed frame** | — | — | changed | — | changed |
| `emit_last_a`/`_b`, `emit_full`, `emit_tlast`, `keep_count` (959–973) | frame A's word is never released | — | — | changed | — | changed |
| `abort` (975) → `tuser` | — | **read** (see §6) | — | — | **read** (see §6) | — |
| `tvalid`/`tkeep`/`tlast` (976, 992–999) | frame A emits none | — | — | changed | — | changed |

### The preamble-exit decode

| term (base line) | IC-A | IC-D | IC-F | others |
|---|---|---|---|---|
| `other_ctl` (243) | read (unchanged) | **removed from two consumers** | **replaced at two consumers** | read |
| `a_pre_mask` (308) | — | consumers removed; still read by `a_hold_v` | consumers re-keyed; still read by `a_hold_v` | — |
| `a_closing_v` (312) | read (unchanged — **load-bearing**, see IC-A above) | **term removed** | **term re-keyed** | — |
| `a_hold_v` / `a_hold_end` (328–331) | read (unchanged) | unchanged | unchanged | — |
| `inword_closing` (418) | — | **term removed** | **term re-keyed** | — |
| `b_closing`/`c_closing`, `survivor_b`/`_c`, `begins` (423–431) | unchanged | changed via `inword_closing` | changed via `inword_closing` | — |
| `lanes.is_idle` (new) | — | — | **introduced** | — |

### Cross-class gate facts, tabulated rather than discovered

1. **`a_close_runt` (base 502) is touched by two classes** — IC-B adds `&: has_fcs`,
   IC-E adds `|: a_close_start` to its antecedent. They are opposite in sign
   (IC-B removes reports, IC-E adds them) and the two diffs are independent, but a
   reader diffing them side by side sees the same line twice; that is expected and
   is not a combined class.
2. **`inword_strobes`' runt bit (base 581 / 573) is likewise touched by both** —
   IC-B forces it low, IC-E widens it with the in-word abort. Same note.
3. **`a_closing_v` (base 312) is read or written by three classes** — IC-D removes
   its `other_ctl` term, IC-F re-keys it, and **IC-A depends on it being left
   alone**: the correctness of IC-A's one-line rendering rests on the lane-4 `/S/`
   remaining in this vector (§3). A future round that combined IC-A with IC-D or
   IC-F would not be two classes at once — it would be a third, different defect.
4. **`a_close_start` (base 375) is written by IC-A and read by IC-E.** Applied
   together they would silently cancel at sub-cases 4/5/6 (no abort decoded ⇒ no
   runt added), which is one more reason no diff combines two classes.
5. **`other_ctl` (base 243) is read by four classes and modified by none.** Every
   class that changes preamble-position routing does so at the *consumer*, so the
   REQ-016 hold — the same signal's other consumer — is provably untouched.
6. **`abort` (base 975) is read by the datapath** (`tuser`, base 998) **and fed by
   `sel_runt`**, which IC-B and IC-E both change. That is the one place where two
   report-path classes touch the output-word path, and it is discharged in §6.
7. **IC-D leaves `other_ctl` in `inword_strobes`' `error` term (base 574) as dead
   code.** With `other_ctl` removed from `inword_closing`, `oh` can never select an
   other-control lane, so the term can no longer evaluate true. It is left in place
   deliberately: removing it would enlarge the diff without changing behaviour.

---

## 6. The §6 pre-ship datapath check — IC-C, IC-B(R), IC-E

The measured signature (WO-0066 §6, `BUG-0003` §V.10.2): **(a)** 7 mid-frame words
with `tkeep` ≠ 0xFF and `tlast` = 0; **(b)** 4 of 60 required octets in their
gapless byte positions, 28 delivered as the idle filler `0x07`, 28 never
delivered, `tlast` on word 7, `tuser` = 0 on a corrupted frame.

Every component of that signature is a function of `al_data`, `al_keep`,
`keep_count`, the four `emit_*` terms, `hold` and `abort`. The check is therefore a
**fan-out closure** on each mutated signal — where reachability needed a gate
evaluation, silence needs the complementary argument, and both are given.

| class | mutated signal | complete list of readers | reaches the datapath? |
|---|---|---|---|
| **IC-C** | `coincident` (new) | `q2_deferred`, `q_strobe` | no |
| | `q2_deferred` (new) | `q_strobe` | no |
| | `q_strobe` | `error_bad_frame`, `error_runt`, `error_start_without_terminate` (base 1001–1004) | no |
| | *reads* `consume`, `abort`, `q2` | — | it reads them; it assigns to neither |
| **IC-B(R)** | `a_close_runt` (502) | `r0`'s runt field ⇒ `sel_runt` ⇒ (i) `strobe sel_runt` ⇒ `error_runt`; (ii) `abort` (975) ⇒ `tuser` (998) | **(ii) is a datapath reader — discharged below** |
| | `inword_strobes.terminate` (573) | `q2` bit 1 ⇒ `q_strobe 1` ⇒ `error_runt` | no |
| **IC-E** | `a_close_runt` (502) | as above | **(ii) discharged below** |
| | `inword_strobes` bit 1 (581) | `q2` bit 1 ⇒ `error_runt` | no |

**Discharging the one datapath reader, `tuser = emit_tlast &: abort`.**

- **IC-B(R)** only ever clears `sel_runt`, and only for records with
  `count_next` < 5. Such a frame emits **no word at all**: `pc` ≤ 4 = `strip`
  (`strip` = 4 because `sel_terminate` = 1, base 800), so `emit_last_a`'s guard
  `pc >: strip` is false, `emit_last_b` needs `nc` ≥ 1 with `nc <=: strip` and the
  frame has nothing behind it, and `emit_full` needs `~:closed |: (nc >: strip)`
  with `closed` = 1 and `nc` = 0. `emit_tlast` = 0, so `tuser` has no cycle on
  which to differ. For every record with `count_next` ≥ 5 the floor is satisfied
  and `sel_runt` is bit-identical to the base.
- **IC-E** only ever *sets* `sel_runt`, and only on records where
  `a_close_start` = 1 — i.e. where `sel_start` is already 1. `abort` is a
  disjunction containing `sel_start`, so it was already 1 on exactly those cycles:
  `abort` is bit-identical, and so is `tuser`.
- Neither class touches `strip` (`sel_terminate`/`sel_oversize` only), `keep_count`,
  `consume`, `hold`, `decided`, `al_keep` or `al_data`.

**Result: all three classes pass.** None can produce component (a) — no `tkeep`
value changes, because `keep_count` is not in any of their cones. None can produce
component (b) — no octet changes byte position (`al_data`, `al_data_d` untouched),
none is dropped or replaced by filler (`hold`, `bubble`, `window_advance`
untouched), `tlast` placement is unchanged (`emit_tlast` untouched) and `tuser` is
bit-identical by the two arguments above. Consequently none of WO-0066 §6's five
datapath messages can be raised by these three diffs, and a red carrying one of
them would be evidence of something other than my diff.

**IC-A, IC-D and IC-F move the datapath by design** and the check does not apply
to them: IC-A suppresses frame A's only output word, IC-D and IC-F let a frame
that owed no output word deliver its octets. Saying so is the difference between
a check and a ritual.

---

## 7. Pre-run reading note for dv_lead (WO-0066 §7 item 7, the `WO-0063B` precedent)

Two items, both derived before any run and both material to adjudication. Neither
blocked delivery; both are raised now because raising them after a scorecard
exists would be a negotiation.

**Note 1 — IC-E cannot be scored at N sub-cases 3, 4 and 6, and the reason is
§0.6's own counting convention.** IC-E adds an `error_runt` pulse to frame A's
abort report. At sub-cases 3, 4 and 6 frame A's report and frame B's `error_runt`
are pinned to the **same cycle** (SPEC-M03 §6.1's table, W + 2 for both), so the
added pulse merges with an `error_runt` that is *already* high on that cycle. §0.6
counts high cycles and never rising edges, so the mutant's output at those three
sub-cases is bit-identical to a conformant M03's. I have declared them **NOT
SEEDED** (§3). If the seal predicts `R!` for IC-E at 3, 4 or 6, the prediction
cannot be met by any rendering of this class that fires at the abort — the
collapse is a property of the stimulus and the counting rule, not of my diff — and
the cells should be adjudicated as unscoreable rather than as survivals. The three
sub-cases IC-E *can* be scored at are 1, 2 and 5, which are exactly the three IC-C
leaves green; between them the two classes cover all six.

**Note 2 — IC-B branch `W` appears unreachable by any minimal diff in this
design, which bears on the seal's D-B1 = W column.** WO-0066 §1.3 says both
renderings *"redden all six N sub-cases"*. Frame B at every N sub-case is opened
and closed inside one word (§6.1, quoted in §2 above) and so is reported by the
in-word path, which has **no payload machinery at all** — three strobe bits and
two registers (base 535–590). A `tkeep` = 0 word cannot be emitted for it without
building an emission path that does not exist, and on the epoch-A path the natural
`W` rendering (relaxing `emit_last_a`'s `pc >: strip` guard to `pc >=: strip`,
base 959) cannot fire either, because `have_word` requires `pc <>:. 0` and a
zero-delivered frame has `pc` = 0. I chose `R` and my manifest is unaffected; I
raise this only so that, if the seal's `W` column was derived on the assumption
that either rendering reddens the six, the assumption is corrected **before** a
scorecard exists rather than after.

**Nothing else in the packet made me guess.** The base SHA was verified rather
than assumed (§1); the sub-case ↔ geometry mapping was derived from two documents
I am allowed to read and cross-checked against IC-C's own required consequence
(§2); D-A2's landing was derived rather than assumed and the derivation is
disclosed in full (§3, §4).

---

## 8. Mechanical verification of the diffs

All commands run from the repo root at `HEAD` = `fb27764`, whose
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` is byte-identical to the base blob
(`git diff --quiet 199e319 -- <path>` exits 0), so a working-tree check is a check
against `199e319`.

| check | result |
|---|---|
| `git apply --check <f>.diff` for all six | **clean, all six** |
| `git apply <f>.diff && git apply -R <f>.diff && git status --porcelain libs/` | **empty for all six** — each applies alone and reverts to the base exactly |
| each diff touches | one file, `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, and nothing else |
| hunks per diff | ic-a 1, ic-b 2, ic-c 1, ic-d 3, ic-e 2, ic-f 6 |
| OCaml parse check `ocamlc -stop-after parsing` on the six mutated sources | **all six parse**; the unmutated base parses; a deliberately broken file fails, so the check is not vacuous |

**Limit of that last row, stated rather than left to be assumed**: this
environment has `ocaml`/`ocamlc` 4.14.1 but **no `dune`, no `ocamlfind` and no
Hardcaml**, so nothing here type-checks or elaborates. The parse check catches
syntax errors only. Whether each mutant *elaborates* is the orchestrator's to
observe when it applies the manifest transiently, and a mutant that fails to
compile is — per WO-0066 §2.1 — a **build-level** finding and never a behavioural
one.

---

## 9. Allowlist compliance and ambient exposure, disclosed unprompted

**Read, all inside WO-0066 §7's allowlist**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
and its `.mli` **at the base blob** via `git show 199e319:<path>` (the sanctioned
form — the working-tree copies were never opened); `docs/specs/requirements.md`;
`docs/specs/modules/xgmii_rx_64.md`; `agents/handoffs/WO-0066_family-bn-mutation-campaign.md`;
`docs/reports/audit/**` (a directory listing only).

**Not read, and not listed, searched or grepped**: **all of `test/**`** — the M03
bench, `test/xgmii/`, `test/monitors/`, and `test/attack_plans/AP-xgmii_rx_64.md`,
whose bar is explicit this campaign; the **sealed companion**
`WO-0066_family-bn-mutation-campaign-SEALED-predictions.md`, of which I have seen
the file name in `git show --stat ebaac58` and nothing else; every journal other
than my own.

**Ambient exposure, disclosed because the voiding call is dv_lead's and never
mine** — three reads outside §7's allowlist, all forced by obligations that
predate this packet, none carrying bench content:

1. **`agents/charters/auditor.md`** — my own charter. Ordered explicitly by my
   spawn prompt's hard rule, and my standing first action under PROTOCOL §2.
2. **`agents/PROTOCOL.md`** — the org constitution. My launcher's first mandatory
   action, and the source of the §4.1 entry grammar this round's journal append
   must satisfy. Process rules only; no module, bench or stimulus content.
3. **`agents/journals/claude_auditor_agent.md`** — **my own** journal, and only
   its entry headers, obtained with a single `^## \[J-auditor-\d+\]` grep. I read
   no entry body. The purpose was the one my instructions name: establish that the
   chain's last entry is `J-auditor-0013` so this round's append is `0014`, and
   fix the harvest span's lower bound. No other journal was touched.
4. **Git metadata**: commit subjects, trailers and changed-path lists for
   `ebaac58`, `199e319`, `fa91964` and the range `199e319..HEAD`, used to verify
   §8's base-SHA identity and the adjudicator-ordering rule. Path names and commit
   subjects only — no `test/**` blob was ever read, and `git show` was never
   invoked on one.

My assessment is that none of the four could carry a cell of the seal or a line of
the bench, so none of them contaminates the blinding. **That assessment is not the
decision**: WO-0066 §7 makes the voiding call dv_lead's, and it is disclosed here
in advance of any result precisely so it can be made on the record.
