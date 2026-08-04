# WO-0063B — two seeded mutations on M03's report path, authored blind

- **Author**: auditor (`J-auditor-0013`)
- **Packet**: `agents/handoffs/WO-0063B_m03-i2-report-path-campaign.md`
  (dv_lead → auditor, via the orchestrator), read **in full** from the working
  tree at `c6c3287`. Nothing else under `agents/handoffs/` was opened.
- **Intents**: **IC-1** — the no-output-word report is consumed one cycle late.
  **IC-2** — the control: the same one-cycle deferral applied to the
  `tlast`-pinned report instead.
- **Binding**: `R-DISC-1` and `R-DISC-2` (`DISP-0001` §4, this tree, minted from
  dv_lead's accepted FINDING A-1 against my own prior disclosure). §3 and §4
  below are their discharge; §8 carries DISP-0001 §4's supporting change — a
  third list in the verification taxonomy, for behavioural claims made in
  disclosures.

---

## 0. The base SHA, its identity, and what was read

### 0.1 Base SHA — §5 item 6, and its check against §7

**Base SHA: `c0595f9e8026757cd4eed6e856d06555424437e0`** (`c0595f9`).

The packet (§7) cannot state its own base hash and instead states an
**identity**: *"the commit that this packet's own commit immediately follows —
i.e. the commit carrying `J-dv_lead-0105`'s citation sweep, which is the parent
of the commit staging this packet and its seal."* That identity is verified
here, not assumed:

```
$ git rev-parse c6c3287^
c0595f9e8026757cd4eed6e856d06555424437e0

$ git log -1 --format='%H %s' c0595f9
c0595f9e8026757cd4eed6e856d06555424437e0 The citation sweep by defect not
  string - four repaired, thirteen upheld, one stopped at a frozen seal

$ git log --oneline -2 c6c3287
c6c3287 Phase-B packet and seal in one commit - the forward commitment
        redeemed at its due date
c0595f9 The citation sweep by defect not string - ...
```

`c0595f9` is the exact parent of the packet commit `c6c3287`, and its subject is
the citation sweep §2.1 requires to ride with the base. **The identity holds and
there is no disagreement to report as a finding.**

### 0.2 The mutation target

`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03) — **the only file either diff
touches.** Neither reaches the `.mli`, any other file under `libs/**`, any build
configuration, or anything under `test/**`.

```
$ git rev-parse c0595f9:libs/hardcaml_ethernet/src/xgmii_rx_64.ml
30ca0385f3106160917ab671c871d774cbaea371          (1011 lines)
$ git show c0595f9:libs/hardcaml_ethernet/src/xgmii_rx_64.ml | sha256sum
8fc08242046ec0b8431df90d0fafb581cb22f30acf2b9651e29d3c4c7656fec1
```

**The blob is byte-identical to WO-0061's base blob at `42b9df3`** (same hash,
same `sha256`; recorded in `DISP-0001` §6). M03's RTL has not moved across
WO-0058, WO-0061 and this round, so every base line number cited in DISP-0001
still resolves, and every line number cited below is checkable against either
SHA.

```
$ git rev-parse HEAD:libs/hardcaml_ethernet/src/xgmii_rx_64.ml
30ca0385f3106160917ab671c871d774cbaea371          (unchanged at HEAD)
```

### 0.3 What was read, and what was not — §5's allowlist

**Read**, and nothing else in the repository:

- `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `c0595f9`, in full, and its
  `.mli` (the exported surface only — it carries no logic).
- `docs/specs/requirements.md` — §0.6 (the strobe window, the *bound-never-a-licence*
  paragraph, C-23's counting), §0.7, and §12's change-log row for the §0.6 ruling.
- `docs/specs/modules/xgmii_rx_64.md` — §9 in full (the closure list, the
  non-normative record-age note, **Strobe cycle, pinned**), §6.3 item 8, §10's
  REQ-109 row, §13's C-14.3 row.
- `agents/handoffs/WO-0063B_m03-i2-report-path-campaign.md` — this packet.
- `docs/reports/audit/**` — my own scope: `DISP-0001_A-1.md` in full (R-DISC-1
  and R-DISC-2's authoritative text), and the header of the WO-0061 manifest and
  one prior `.diff` for house form.

**Not read, deliberately and completely:**

- **`WO-0063B_m03-i2-report-path-campaign-SEALED-predictions.md`.** It exists in
  the same commit as the packet. It was not opened, listed for content, or
  inferred from. Every statement below about what the seal may branch on is
  taken from the packet's own §1.1, §2, §6 and §8 — the parts §11 declares
  *freely told* — and never from the seal.
- **Every file under `test/**`.** Not one was opened. §6's expected killing
  behaviour is therefore stated as **spec-derived observable behaviour** and
  names no assertion, monitor, runner or message string. Where a fact about the
  bench would have been convenient, it is derived as a *condition* and labelled
  inferred, or it is not claimed.
- **Every journal, every other packet, every `BUG-` packet, every prior verdict.**

### 0.4 Ambient exposure, disclosed unprompted

The call on whether any of this voids a mutation is dv_lead's, not mine. Four
items, none of which conveys a prediction, a cell, a message string or an
iteration order:

1. **`agents/PROTOCOL.md` §4 (journal grammar), §4.2, §7 (the lessons harvest,
   LH1–LH3) and §6 (write scopes).** My spawn instruction makes reading PROTOCOL
   a mandatory first action and my journal obligations are stated by reference to
   these sections; the packet's §5 bars `agents/**` generally. I read those
   sections and no others. PROTOCOL is the org's constitutional document and
   carries nothing about this campaign, this module or this bench.
2. **`agents/journals/claude_auditor_agent.md`, my own journal** — the entry-id
   chain (last entry `J-auditor-0012`) and the structure of that entry, needed to
   append `J-auditor-0013` and to compute the §7 harvest span. My own prior
   writing only; no other agent's journal was opened.
3. **`agents/charters/auditor.md`** — my charter, a mandatory first read.
4. **A directory listing of a shared scratch directory** used by earlier
   sessions, which showed *filenames* including `HEAD_test_m03_a.ml`,
   `HEAD_test_m03_b.ml`, `HEAD_test_m03_c.ml` and `head_m03_i.ml`. **No such
   file was opened and none of their contents entered this work.** The listing
   was incidental to creating a working directory; a dedicated clean
   subdirectory was used from that point on. I record it because a filename that
   names a bench file is exposure of a kind, however thin, and the packet asks
   for exposure disclosed rather than judged by me.

Nothing under `test/**` in the repository was read at any point, by any command,
including `grep`.

---

## 1. The two diffs

Both are one file, and both are stated here as the exact expression before and
after. `git apply --check` results are at §8.1.

### 1.1 The site both intents share

Base line 977 is the whole of the module's report-consumption decision:

```ocaml
977:  consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
```

and base line 990 is the whole of the epoch-A strobe emission:

```ocaml
990:  let strobe s = consume &: s &: ~:(i.clear) in
```

`consume` is a disjunction of **exactly SPEC-M03 §9's two pins**, and the module
says so in its own words at lines 480–501 and 966–970:

| pin | §9's words | the term in `consume` |
|---|---|---|
| with an output word | *"on the cycle M03 emits that frame's `tlast` word"* | `emit_tlast` |
| with no output word | *"two cycles after the input word carrying the character that ended the frame, at both start lanes"* | `sel_is_r2` — the record reaching age 2, base 486–488: *"a record is always consumed by age 2, which is §9's pinned cycle for a frame that emits no word"* |

Both diffs **partition `consume` without altering it**:

```ocaml
  let report_tlast = sel_valid &: emit_tlast in
  let report_no_word = sel_valid &: sel_is_r2 &: ~:emit_tlast in
```

`report_tlast |: report_no_word` = `sel_valid &: (emit_tlast |: sel_is_r2)` =
`consume`, term for term. The `~:emit_tlast` conjunct makes the two **mutually
exclusive**, so no report is ever emitted twice and no report is ever dropped;
each diff then delays exactly one side of the partition by one register.

### 1.2 IC-1 — `ic-1.diff` (two hunks, one intent)

**Hunk 2 of 2 (the load-bearing one), base line 990.**

Before:

```ocaml
  let strobe s = consume &: s &: ~:(i.clear) in
```

After (comment elided; it is in the diff verbatim):

```ocaml
  let report_tlast = sel_valid &: emit_tlast in
  let report_no_word = sel_valid &: sel_is_r2 &: ~:emit_tlast in
  let deferred s = reg spec (report_no_word &: s) in
  let strobe s = ((report_tlast &: s) |: deferred s) &: ~:(i.clear) in
```

**Hunk 1 of 2, base lines 583–590** — the module's *second* no-output-word
report structure, the in-word epoch's fixed two-stage path.

Before:

```ocaml
  let q2 =
    reg
      spec
      (reg
         spec
         (inword_strobes ~exists:b_exists ~closing:b_closing
          |: inword_strobes ~exists:c_exists ~closing:c_closing))
  in
```

After: a third `reg spec` wrapping the same expression. Nothing else changes.

**Why two hunks and not one.** This module realises "a frame that emits no
output word" in **two** structures, not one: the aged closure record consumed at
age 2 (epoch A, base 480–534), and the fixed two-stage `q2` path for a frame
opened *and* closed inside one input word (epoch B / epoch C, base 535–590).
Both are §9's no-output-word pin; both report at the closing word + 2. Deferring
only one of them would answer §1.1's disclosure with an unnamed third axis —
precisely the `WO-0058` GH-2 / `WO-0061` S-4 failure the packet names. §2.1
below answers the disclosure on both.

**Neither hunk touches `consume`.** Verified mechanically:

```
$ grep -n 'consume <==' <base> <ic-1 mutant> <ic-2 mutant>
base                 977:  consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
ic-1 mutant          988:  consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
ic-2 mutant          977:  consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
```

### 1.3 IC-2 — `ic-2.diff` (one hunk)

The same site, the same partition, the opposite disjunct. Before, base line 990,
as above. After:

```ocaml
  let report_tlast = sel_valid &: emit_tlast in
  let report_no_word = sel_valid &: sel_is_r2 &: ~:emit_tlast in
  let deferred s = reg spec (report_tlast &: s) in
  let strobe s = (deferred s |: (report_no_word &: s)) &: ~:(i.clear) in
```

IC-2 does **not** touch `q2`: the in-word path is a no-output-word path in its
entirety, so it belongs to IC-1's class and not to the control's.

### 1.4 Minimality and independence

- Each diff is `[c0595f9 + exactly one diff]`. Neither depends on the other, and
  they overlap in **no hunk**: IC-2's single hunk and IC-1's hunk 2 are the same
  *base* lines, so the two are alternatives and are never applied together —
  which is what the packet's "minimal and independent" asks for, and the reason
  they are two files and not one.
- Each **reverts to the base byte for byte** (§8.1).
- Neither adds, deletes or renames a file. Neither changes a constant, a
  threshold, a state encoding, a width, an interface record or a port.
- The only added state is the deferral register itself (five one-bit flops, one
  per strobe field, from `deferred`'s five call sites) and, for IC-1, three more
  in `q2`'s third stage. No flop is added anywhere in the payload path, so
  REQ-019's depth is untouched by construction as well as by argument.

---

## 2. The two mandatory disclosures (packet §1.1), answered as facts of the diffs

Both answers are **measured on the delivered diffs**, not predicted. §9's model
reproduces every figure quoted here.

### 2.1 Disclosure 1 — closure-character-scoped, or shared across the whole no-output-word path?

> **SHARED ACROSS THE WHOLE NO-OUTPUT-WORD REPORT PATH. Not scoped to the
> closure character, and not scoped to one of the module's two no-output-word
> structures either.**

`report_no_word = sel_valid &: sel_is_r2 &: ~:emit_tlast` reads the record's
**validity and age** and reads **none** of its closure-character fields —
`sel_terminate` (bit 1), `sel_error` (bit 2), `sel_start` (bit 3) and
`sel_oversize` (bit 4) do not appear in it. Every record consumed at age 2 is
deferred, whatever closed the frame. IC-1's hunk 1 does the same for the in-word
path, whose `inword_strobes` vector (base 570–582) likewise carries all three
characters.

Measured, at the base and under IC-1 (model §C):

| frame closed by | REQ | structure | BASE report cycle | IC-1 report cycle | strobe |
|---|---|---|---|---|---|
| `/T/`, zero octets | REQ-107, §9 row 6 | epoch-A aged record | closing word + 2 | **+ 3** | `error_runt` |
| `/E/` (or an other-control character in a preamble position) | REQ-105 | epoch-A aged record | + 2 | **+ 3** | `error_bad_frame` |
| `/S/` | REQ-110 | epoch-A aged record | + 2 | **+ 3** | `error_start_without_terminate` |
| `/T/`, opened and closed in one word | REQ-107 | in-word `q2` | + 2 | **+ 3** | `error_runt` |
| `/E/`, opened and closed in one word | REQ-105 | in-word `q2` | + 2 | **+ 3** | `error_bad_frame` |
| `/S/` in lane 4 of an `/S/` word (§10's REQ-110 hook) | REQ-110 | in-word `q2` | + 2 | **+ 3** | `error_start_without_terminate` |

`error_oversize` and `error_bad_fcs` ride the epoch-A path only and are deferred
by the same term wherever a record carrying them reaches age 2 — the same answer,
stated for completeness rather than because a no-output-word instance of either
is claimed to exist (REQ-108's count never advances on a zero-octet frame, and
§9's ninth ruling puts that class outside the FCS check; base 545–556).

**The dimension the disclosure's own wording does not name, named here.** The
question as posed has two values, and this module has a second axis underneath
them: *which of the two no-output-word structures*. Had IC-1 deferred only the
aged record, the answer "shared, all closure characters" would have been true and
still incomplete, because a frame opened and closed in one word would not have
moved at all. **IC-1 defers both. There is no third axis left in this diff.**

### 2.2 Disclosure 2 — hold, or re-derive from a later reference?

> **HOLD. One additional pipeline register on the report path, in both hunks.
> Nothing is re-derived from any later reference.**

`deferred s = reg spec (report_no_word &: s)` is a unit delay on the report
pulse and its record field, and `q2`'s third stage is a unit delay on the in-word
vector. Neither reads any signal the base design does not already have at that
point, and neither computes a cycle from anything.

The consequence the disclosure asks about, stated exactly: **the map from base
report cycles to mutant report cycles is `t ↦ t + 1`, applied independently to
every report on the deferred path.**

- A **second report in the same run moves with it**, by the same one cycle.
- The **interval between two deferred reports is preserved** — two reports one
  cycle apart at base are one cycle apart under the mutant.
- Nothing is merged or dropped **by the register**: a one-bit flop driven high on
  consecutive cycles is high on the two following cycles. Measured across 20 736
  stimuli, IC-1 never *increases* a strobe's high-cycle count (model §D:
  count-gaining stimuli = 0), so the mutation manufactures no event.
- There is one shape in which the **shift** — not the register — can cost a
  count, and it is disclosed in full at §7.1 rather than left to be discovered.

---

## 3. R-DISC-1 — reachability discharged term by term, at the firing cycle, per lane

R-DISC-1's standard, in its own words (`DISP-0001` §4): name the gate signal that
produces the event, quote its complete defining expression from the base file
with line numbers, evaluate **every** conjunct at the claimed firing cycle, call
out the conjuncts contributed by the stimulus rather than by the mutation, and
enumerate the recurrence set rather than assume it unique. Below, for IC-1 and
IC-2 separately, at both start lanes.

### 3.0 The stimulus, and the cycle arithmetic, derived before anything is claimed

Member (iii) is *"a frame closed by its own `/T/` with zero octets received,
which owes exactly one `error_runt` and no output word at all"* (packet §0), and
the packet §3 adds: *"the closing character is in **lane 0** at a lane-0 start
and in **lane 4** at a lane-4 start"*, with `boundary` = **5** at both lanes.

Three consequences, derived, not assumed:

1. **The closing character cannot be in the frame's own start word.** At a
   lane-0 start the `/S/` occupies lane 0, so a closing character *in lane 0* is
   in a different word; at a lane-4 start the same argument holds at lane 4.
   **Member (iii) is therefore on the epoch-A aged-record path and not on the
   in-word `q2` path** — the start word is `W`, the closing word is `W + 1`, and
   `cov_first` at `W + 1` is exactly the frame's start lane (base 297–302), which
   is why the closing character sits *at* `cov_first` and covers nothing.
2. **The closing word is cycle 2 and the start word is cycle 1.** §4's own
   quoted message fixes the boundary as *"the silence boundary 3 cycles after the
   closing word"* and the packet fixes the boundary at 5; requirements.md §0.6
   states the same arithmetic from the other end (*"this window's ceiling is the
   closing word + 3, while SPEC-M03 §9 pins the pulse at the closing word + 2"*).
   Closing word = 5 − 3 = **2**; start word = **1**.
3. **The conformant report is at cycle 4 and the deferred report is at cycle 5** —
   *at* the boundary, which is what §1's required consequence asks for and what
   §0.6 rules **non-conformant against §9's pin**, on §9's authority.

Everything in 1–3 is derived from the packet, requirements.md §0.6 and SPEC-M03
§9 — no bench file was consulted and none is needed.

### 3.1 IC-1 — the gate, quoted complete

The gate producing member (iii)'s report is the `error_runt` output. Under IC-1
its complete defining expression is (base line numbers for the unchanged parts):

```ocaml
1002:  ; error_runt = strobe sel_runt |: q_strobe 1
 990:  let strobe s = ((report_tlast &: s) |: deferred s) &: ~:(i.clear)   (* IC-1 *)
       let deferred s = reg spec (report_no_word &: s)                     (* IC-1 *)
       let report_tlast = sel_valid &: emit_tlast                          (* IC-1 *)
       let report_no_word = sel_valid &: sel_is_r2 &: ~:emit_tlast         (* IC-1 *)
 991:  let q_strobe k = bit q2 k &: ~:(i.clear) in
 522:  let sel_is_r2 = valid_of r2 in
 525:  let sel = mux2 sel_is_r2 r2 (mux2 sel_is_r1 r1 r0) in
 528:  let sel_valid = valid_of sel in
 534:  let sel_runt = bit sel 6 in
 963:  let emit_tlast = emit_last_a |: emit_last_b in
 959:  let emit_last_a = have_word &: decided &: closed &: (nc ==:. 0) &: (pc >: strip) in
 960:  let emit_last_b = have_word &: decided &: (nc <>:. 0) &: (nc <=: strip) in
 831:  let have_word = (pc <>:. 0) &: ~:fcs_tail_now in
 795:  let pc = popcount al_keep_d in
 502:  let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
 366:  let a_close_terminate = a_closes_with lanes.is_terminate in
```

The firing term at cycle 5 is `deferred sel_runt`, a register. It therefore has
**two** evaluation points, and both are discharged: the register's **input at
cycle 4**, and the surrounding disjunction at **cycle 5**.

### 3.2 IC-1, LANE-0 START — every conjunct at the firing cycle

**Register input, evaluated at cycle 4.** `report_no_word &: sel_runt` =
`sel_valid &: sel_is_r2 &: ~:emit_tlast &: sel_runt`.

| # | conjunct | value at cycle 4 | why | contributed by |
|---|---|---|---|---|
| 1 | `sel_valid` (`bit sel 0`, 528) | **1** | the record born at cycle 2 (`a_close_now` = 1, base 377) has aged to `r2`; `sel` = `r2` = `0x43` | **stimulus** — unchanged from base |
| 2 | `sel_is_r2` (`valid_of r2`, 522) | **1** | `r1` at cycle 3 = `0x43` and `consume` was 0 at cycle 3, so `r2 <== r1` (base 527) loads it | **stimulus**, and *structurally preserved by the mutation*: IC-1 leaves `consume` and lines 526–527 untouched, so `r2`'s occupancy at cycle 4 is bit-identical to base |
| 3 | `~:emit_tlast` (963) | **1** | `pc` = `popcount al_keep_d` = 0 on every cycle of the run, because the frame covers no octet at any cycle: `cov_end` = `a_char_end` = 0 = `cov_first`, so `cov_nonempty` = (0 > 0) = 0 (base 381). `have_word` = 0 (831), so `emit_last_a` and `emit_last_b` are both 0 | **stimulus** — this is member (iii)'s defining property |
| 4 | `sel_runt` (`bit sel 6`, 534) | **1** | `a_close_runt` at cycle 2 = `a_close_terminate` ∧ (`count_next` < 64) = 1 ∧ (0 < 64) (base 502) | **stimulus** |

`a_close_terminate` at cycle 2, itself a conjunction (base 364–366), evaluated
because it is what makes conjunct 4 available: `a_char_acts` = `a_open` ∧
¬`a_close_oversize` = 1 ∧ ¬0 = 1 — `a_open` = 1 because the state is `Preamble`
(base 296), `a_close_oversize` = 0 because its second conjunct `cap_end <: a_char_end`
is (8 < 0) = false (base 361–362, `cap_end` = 8 at `count` = 0); and
`any (lanes.is_terminate &: a_close_oh)` = `any (0x01 &: 0x01)` = 1.

All four conjuncts are 1, so the register loads 1 at cycle 4.

**The disjunction, evaluated at the firing cycle 5.**

| # | term | value at cycle 5 | why | contributed by |
|---|---|---|---|---|
| 5 | `deferred sel_runt` (the register's Q) | **1** | loaded at cycle 4 | **the mutation** — this register *is* IC-1 on this path |
| 6 | `~:(i.clear)` (990) | **1** | `clear` is low after reset | **stimulus** |
| 7 | `report_tlast &: sel_runt` | **0** | `sel_valid` = 0 at cycle 5 — `r2 <== r1` (527) with `r1` = 0 at cycle 4, so the record has drained; and `emit_tlast` = 0 | stimulus + the unchanged chain |
| 8 | `q_strobe 1` (991) | **0** | `q2` ≡ 0 for the whole run: `b_exists` = 1 at cycle 1 but `b_closing` = 0 (lanes 1–7 are preamble data), so `closed` in `inword_strobes` is 0 and the vector is 0 at every cycle (base 570–582) | **stimulus** |

`error_runt` = (0 ∨ 1) ∧ 1 ∨ 0 = **1 at cycle 5.** Terms 7 and 8 are evaluated
because they decide that the pulse at cycle 5 is *the deferred one and the only
one*, which §8's `= 1` count row and `= "error_runt"` name row both need.

**The recurrence set, enumerated rather than assumed unique.** Over the sampled
window the set of cycles at which `error_runt` is high is:

- **base: {4}**, **IC-1: {5}**. Both singletons.

The enumeration, not the assumption: the register's input is `report_no_word ∧ sel_runt`,
which needs `sel_is_r2`; `r2` is nonzero only at cycle 4 (it is loaded from `r1`
at cycle 4 and `r1` is zero from cycle 4 onward, base 526–527), so the register
is high only at cycle 5. `report_tlast` is 0 at every cycle because `emit_tlast`
is. `q2` is 0 at every cycle. And **the schedule's later characters raise
nothing**: from cycle 3 the state is `Idle`, so `a_open` = 0, `a_char_acts` = 0
and `a_close_now` = 0 (base 364, 377) — the auto-placed terminate at cycle 10
that the packet §3 names creates no record and no strobe. That last point was
checked by running the stimulus with and without the cycle-10 terminate and
comparing the strobe sets: identical (model, earlier revision; retained as §9's
`member_iii(auto_term_cycle=…)` parameter).

**Output words: 0 at every cycle**, both variants — `have_word` = 0 always, so
`tvalid` (976) and `tlast` (997) are 0 at every cycle. §8's `= 0` row holds.

### 3.3 IC-1, LANE-4 START — the separate evaluation

A conjunct satisfiable at one lane is not thereby satisfiable at the other, so
this is evaluated independently. The differences from §3.2 are in **four**
signals; every one of the eight terms above is re-checked underneath them.

| signal | lane-0 value at cycle 2 | lane-4 value at cycle 2 | source |
|---|---|---|---|
| `frame_start4` (432) | 0 | **1** | `new_start4` = `survivor_c` = 1, latched by `begins` at cycle 1 |
| `cov_first` (297–302) | 0 | **4** | `mux2 in_preamble (mux2 frame_start4 4 0) …` |
| `a_pre_mask` (308) | `0x00` | **`0x0f`** | `repeat (in_preamble &: frame_start4) 8 &: 0x0f` |
| `a_char_end` (316–317) | 0 | **4** | the `/T/` is in lane 4; `a_close_oh` = `0x10` |
| `off4` (664–666) | 0 | **1 from cycle 3** | the deliberate one-cycle lag (base 657–662): `start4_pending` is 0 at cycle 1, so `off4` is still 0 at cycle 2 |

Re-evaluating the eight terms:

- **Conjunct 3 (`~:emit_tlast`) — the one that could have differed, and does
  not.** `cov_end` = min(`a_char_end` = 4, `cap_end` = 8, `a_hold_end` = 5) = 4,
  and `cov_first` = 4, so `cov_nonempty` = (4 > 4) = **0** (base 381). Zero
  octets are covered here too, so `pc` ≡ 0, `have_word` ≡ 0 and `emit_tlast` ≡ 0.
  `a_hold_end` = 5 because the idle characters above the `/T/` set `a_hold_v` =
  `other_ctl &: ~:a_pre_mask` = `0xe0 &: 0xf0` = `0xe0` (base 328–331); it does
  not bind, since 5 > 4.
- **Conjunct 4 (`sel_runt`)**: `a_close_terminate` = `any (0x10 &: 0x10)` = 1 and
  `count_next` = 0 < 64, so `a_close_runt` = 1. The record is `0x43` — **the same
  seven bits as at lane 0**.
- **`a_close_error` is 0, checked because `a_pre_mask` is nonzero here and is not
  at lane 0.** `a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))`
  (base 372–373): `other_ctl &: a_pre_mask` = `0xe0 &: 0x0f` = `0x00` — the idle
  characters lie *above* the `/T/`, outside the frame's preamble positions
  (lanes 0…3), so REQ-102's third sentence does not route them to REQ-105 here.
  Had they lain below, epoch A would have closed with `error` rather than
  `terminate` and conjunct 4 would have failed. It does not.
- **Conjuncts 1, 2, 5, 6, 7, 8**: identical to §3.2, and the `off4` = 1 that
  arrives at cycle 3 changes only `closure_aligned` (957) → `decided` (958),
  which is gated by `have_word` = 0 in all three emission arms and therefore
  reaches nothing.

**Result at lane 4: `error_runt` high at cycle 5 under IC-1, at cycle 4 at base,
recurrence set a singleton at both, zero output words.** Identical to lane 0
cycle for cycle. **Both lanes are SEEDED. No lane is declared NOT SEEDED and
R-DISC-1's escape is not taken** — every conjunct above is discharged, none is
argued.

### 3.4 IC-2 — the control, discharged as a *non*-firing at member (iii)

IC-2's required consequence is a green, so the discharge is the opposite shape:
show the deferral term never arms, and show the base behaviour is reproduced
exactly.

Gate, under IC-2:

```ocaml
       let strobe s = (deferred s |: (report_no_word &: s)) &: ~:(i.clear)
       let deferred s = reg spec (report_tlast &: s)
       let report_tlast = sel_valid &: emit_tlast
```

| # | conjunct of the register's input, `report_tlast &: s` | value at **every** cycle, both lanes | why |
|---|---|---|---|
| 1 | `sel_valid` | 1 at cycles 2, 3, 4; 0 elsewhere | as §3.2 |
| 2 | `emit_tlast` (963) | **0 at every cycle** | `emit_last_a` and `emit_last_b` are both conjoined with `have_word` (959, 960), and `have_word` = `(pc <>:. 0) &: ~:fcs_tail_now` with `pc` = `popcount al_keep_d` ≡ 0, because member (iii) covers no octet at any cycle at either lane (§3.2 conjunct 3, §3.3) |

The conjunction is **never** satisfied, so IC-2's register never loads and its
output is 0 at every cycle. `strobe s` then reduces to `(report_no_word &: s) &: ~:clear`,
and since `report_no_word |: report_tlast` = `consume` with `report_tlast` ≡ 0
here, `strobe s` = `consume &: s &: ~:clear` — **the base expression exactly**.

**Measured consequence: under IC-2, member (iii) is bit-identical to the base on
all five strobes and on the whole datapath, at both start lanes, at every cycle
of the run** (model §B and §D). The report is at cycle 4, the base's own pin.

### 3.5 IC-2 is a live defect, not a vacuous control

A control that changed nothing anywhere would prove nothing. IC-2 differs from
the base on **1 868 of 20 736** swept stimuli (9.0 %, model §D). The cleanest
demonstration is the same strobe name in the other class — a **delivering**
runt, 32 received octets closed by `/T/`, at both start lanes (model §G):

| stimulus | class | BASE | IC-1 | IC-2 |
|---|---|---|---|---|
| 32 octets, `/T/`-closed (delivers 4 words) | `tlast`-pinned | `error_runt` at 7 | **7** (untouched) | **8** (deferred) |
| member (iii), `/T/`-closed, 0 octets | no-output-word | `error_runt` at 4 | **5** (deferred) | **4** (untouched) |

Same strobe, same closing character, opposite classes, opposite variants. That
is the discriminator the round is built on, exhibited on the diffs themselves.

---

## 4. R-DISC-2 — the gate inventory, with cross-class facts tabulated before delivery

The report path is named by **both** intents, so it gets its full term list and
each intent's claim about it, here, before delivery.

### 4.1 The inventory

| # | signal | base line | complete term list | IC-1's claim | IC-2's claim | cross-class? |
|---|---|---|---|---|---|---|
| G1 | `consume` | 977 | `sel_valid &: (emit_tlast \|: sel_is_r2)` | **unchanged, byte for byte** — read, never rewritten | **unchanged, byte for byte** | **YES — both read it, neither writes it.** This is the fact that makes both diffs datapath-free (§5) |
| G2 | `strobe` | 990 | `consume &: s &: ~:(i.clear)` | rewritten: `((report_tlast &: s) \|: deferred s) &: ~:(i.clear)` | rewritten: `(deferred s \|: (report_no_word &: s)) &: ~:(i.clear)` | **YES — the same line, rewritten by both.** The two rewrites are the same partition with the register on opposite disjuncts |
| G3 | `report_tlast` (new) | — | `sel_valid &: emit_tlast` | **left on §9's pin** | **deferred one cycle** | **YES — the disjunct the two intents disagree about** |
| G4 | `report_no_word` (new) | — | `sel_valid &: sel_is_r2 &: ~:emit_tlast` | **deferred one cycle** | **left on §9's pin** | **YES — the other disjunct** |
| G5 | `q2` | 583–590 | two `reg spec` stages over `inword_strobes b \|: inword_strobes c` | **third stage added** | untouched | no — IC-1 only |
| G6 | `q_strobe` | 991 | `bit q2 k &: ~:(i.clear)` | unchanged expression, deferred input | unchanged | no |
| G7 | `sel` and its seven field bits | 519–534 | `mux2 sel_is_r2 r2 (mux2 sel_is_r1 r1 r0)` | **unchanged** — read at the firing cycle by both `report_*` terms | **unchanged** | **YES — read by both, written by neither** |
| G8 | `r1`, `r2` | 526–527 | `reg spec (r0 &: ~:(repeat (consume &: sel_is_r0) 7))`, and the r1→r2 form | **unchanged** — the record chain's occupancy is bit-identical to base | **unchanged** | **YES** |
| G9 | `emit_tlast` | 963 | `emit_last_a \|: emit_last_b` | **unchanged** — read as a conjunct of both `report_*` terms | **unchanged** | **YES — read by both, written by neither** |
| G10 | `strip`, `closed`, `decided`, `hold`, `keep_count`, `abort`, `tvalid`, `tlast`, `tuser`, `tkeep`, `tdata` | 800, 956–958, 971–998 | all functions of `sel`, `pc`, `nc`, `al_*` | **unchanged, and unreachable from either diff** | **unchanged, and unreachable** | **YES — the §5 claim rests on this row** |
| G11 | `i.clear` | 990–991 | the output mask on every strobe | unchanged | unchanged | **YES** |

### 4.2 The cross-class gate facts, stated rather than left to be discovered

1. **The two intents rewrite the same line (G2) and read the same three
   unchanged signals (G1, G7, G9).** They are not two mutations at two sites;
   they are one partition with the register moved. That is why IC-2 is a control
   for IC-1 and not merely a second defect.
2. **`report_tlast` and `report_no_word` are mutually exclusive and their
   disjunction is `consume`** (G3, G4). Neither intent can double-report and
   neither can drop a report, at either lane, on any stimulus. Checked
   mechanically over 20 736 stimuli: no strobe's high-cycle count ever *rises*
   under either variant (model §D, count-gaining = 0).
3. **No fact any entry relies on is contradicted by any other entry.** The one
   place two entries could have collided is `emit_tlast` (G9): §3.2 conjunct 3
   relies on it being **0** on member (iii), and §3.5 relies on it being **1** on
   a delivering runt. These are different stimuli, not different readings — the
   distinguishing term is `pc = popcount al_keep_d` (795), zero at member (iii)
   and nonzero on any delivering frame, and it is named in both entries. This is
   the check `DISP-0001` §4's R-DISC-2 exists to force, and it is recorded as
   performed and clean rather than as unnecessary.
4. **The one term IC-1 touches that IC-2 does not is `q2` (G5)**, and it is
   named in the §2.1 disclosure for exactly that reason.

---

## 5. The packet §4 pre-ship check — the datapath-perturbation signature

### 5.1 The signature, and the check that answers it

The measured signature (`BUG-0003` §V.10.2, quoted at packet §4): **(a)** 7
mid-frame words with `tkeep` ≠ `0xFF` and `tlast` = 0; **(b)** 4 of 60 required
octets in their gapless byte positions, 28 delivered as idle filler `0x07`, 28
never delivered — a 32-octet stream against a required 60; **(c)** `tlast` on
word 7; **(d)** `tuser` = 0 on a corrupted frame.

**Result: NONE of (a), (b), (c) or (d) can be produced by either diff, because
under both diffs the emitted stream is bit-identical to the base's on every
stimulus.** The check is discharged two ways, and both are total rather than
sampled.

### 5.2 Structural — the mutation cone is closed inside the five strobes

The six fields of `O.rx` are, at base lines 992–999:

```ocaml
  { Axi64.Source.tvalid ; tdata = al_data_d ; tkeep = keep_of_count keep_count
  ; tstrb = zero 8 ; tlast = emit_tlast &: ~:(i.clear) ; tuser = emit_tlast &: abort }
```

Every one of `tvalid`, `al_data_d`, `keep_count`, `emit_tlast` and `abort`
depends on the record chain **only through `consume`**, and `consume`'s defining
expression is byte-identical in the base and in both mutants (§1.2). The signals
each diff introduces are then checked for reachability *forwards*, mechanically:

```
$ grep -n 'report_tlast\|report_no_word\|deferred' <ic-1 mutant>   (code lines only)
1017:  let report_tlast = sel_valid &: emit_tlast in
1018:  let report_no_word = sel_valid &: sel_is_r2 &: ~:emit_tlast in
1019:  let deferred s = reg spec (report_no_word &: s) in
1020:  let strobe s = ((report_tlast &: s) |: deferred s) &: ~:(i.clear) in

$ grep -n '\bstrobe\b\|q_strobe\|\bq2\b' <ic-1 mutant>             (code lines only)
 592:  let q2 =
1020:  let strobe s = ...
1021:  let q_strobe k = bit q2 k &: ~:(i.clear) in
1030:  ; error_bad_fcs = strobe sel_bad_fcs
1031:  ; error_bad_frame = strobe sel_error |: q_strobe 0
1032:  ; error_runt = strobe sel_runt |: q_strobe 1
1033:  ; error_oversize = strobe sel_oversize
1034:  ; error_start_without_terminate = strobe sel_start |: q_strobe 2
```

The new identifiers occur **only** in the definition of `strobe`; `strobe` and
`q_strobe` occur **only** in the five `error_*` fields; no field of `rx`
references either. The cone is closed. **The emitted stream cannot move.** The
same check on IC-2 gives the same closure (IC-2 has no `q2` hunk).

### 5.3 Executable — exhaustive over a 20 736-stimulus sweep

A cycle model built from the base source (§9) was run at BASE, IC-1 and IC-2 over
every 4-word sequence drawn from a 12-word alphabet of start/closure placements
at lanes 0 and 4 — 12⁴ = **20 736 stimuli** — comparing `tvalid`, `tkeep`,
`tlast` and `tuser` cycle by cycle:

```
   stimuli: 20736
   IC1: stimuli whose DATAPATH (tvalid/tkeep/tlast/tuser) moves vs BASE = 0
   IC2: stimuli whose DATAPATH (tvalid/tkeep/tlast/tuser) moves vs BASE = 0
```

and on **delivering** stimuli — the only ones on which the signature has a domain
at all — the 64-octet member at both start lanes and at injection depths
k = 0, 1, 7:

```
   lane4=0 k=0/1/7 and lane4=1 k=0/1/7:  datapath IC1==BASE, IC2==BASE
   BASE stream, gapless: 8 words at cycles 4…11, tkeep 0xFF ×7 then 0x0F,
                         tlast on word 7, tuser 0 — 60 octets delivered of 60
```

Against the signature: **(a)** mid-frame words with `tkeep` ≠ `0xFF` — **0**, at
base and under both mutants; **(b)** delivered octet count — **60 of 60**, and
`tdata` is `al_data_d`, whose cone is untouched (§5.2), so no octet is
substituted or dropped; **(c)** `tlast` on word 7 — where it belongs, unchanged;
**(d)** `tuser` — unchanged on every cycle of every stimulus.

### 5.4 The packet's adjudication half — the three datapath messages have no domain

Packet §4 observes that the signature has no domain at member (iii), where the
conformant stream is empty, and names the discriminator instead: three datapath
messages that step 5 and step 6's *first* assertion would raise before the strobe
scan. Measured (model §E):

```
   lane4=0 BASE/IC1/IC2: emitted words = []   lane4=1 BASE/IC1/IC2: emitted words = []
```

No `tvalid` and no `tlast` rises at **any** cycle, under **any** variant, at
**either** lane. A `tlast` word cannot be observed, a `tvalid` word cannot be
observed, and no output word exists to be emitted at or after cycle 5. **None of
the three datapath messages can be raised by either diff**, so the packet's
disposition 5 — *"IC-1 red at member (iii) with one of §4's three datapath
messages → out of specification, reported and not scored"* — **cannot be reached
by these diffs.** A red at member (iii) under IC-1 must carry the window's own
strobe message.

### 5.5 The check did real work — the rendering it rejected, measured

§4 asked for a test rather than prose, and it earns its place: **the literal
rendering of "consumed at age 3" is out of specification and was rejected on this
check.**

That rendering — a fourth record stage, `r1 → r2 → r3`, with `consume` firing at
`sel_is_r3` instead of `sel_is_r2` — is the reading the words *"consumes it at
age 3 instead of age 2"* most directly suggest. It was built and run alongside
the delivered diffs (§9's `CHAIN` variant). At member (iii) it is
**indistinguishable from IC-1**:

```
   lane4=0 CHAIN: emitted words=[] strobes={'error_runt': [5]}
   lane4=1 CHAIN: emitted words=[] strobes={'error_runt': [5]}
```

and over the same sweep it **moves the datapath on 191 of 20 736 stimuli**:

```
   CHAIN (rejected rendering): stimuli whose DATAPATH moves = 191
      (('idle','S0','S0','data'), cycle 6,
         [('tvalid',0,1), ('tkeep',None,255), ('tlast',0,1), ('tuser',0,1)])
      (('idle','S0','S0','T4'),   cycle 6,
         [('tvalid',0,1), ('tkeep',None,15),  ('tlast',0,1), ('tuser',0,1)])
```

— a `tlast` word, with `tuser` set, emitted where the base emits nothing at all.
The mechanism is the one §5.2 turns on its head: holding a record in the chain
one cycle longer leaves `sel_valid` high for an extra cycle, which changes
`closed` → `closure_aligned` → `decided` and `strip` → `keep_count` for the
*next* frame. **That is IC-1 plus a datapath defect, and the two cannot be scored
apart** — exactly packet §4's out-of-specification case, caught before delivery
rather than from a scorecard.

**The consequence for the delivered IC-1**: keeping `consume` untouched and
deferring only the report *output* is not a stylistic choice. It is the only
rendering of IC-1 this module admits without perturbing the datapath, because the
closure record feeds the emission decision. The observable is unchanged —
§9's pin at closing word + 2 becomes closing word + 3 — and SPEC-M03 §9 is
explicit that the observable is what is at stake: *"§6.3 item 2 leaves the
placement of the register levels and every internal encoding deliberately
unconstrained; this module's observable is the emitted stream, not the age of a
record inside it."* IC-1 renders the intent at the layer the specification
governs.

---

## 6. Expected killing behaviour, per diff — spec-derived, no test internals

Stated as **behaviour of the design**, in terms of requirements.md and SPEC-M03
only. No assertion, monitor, runner, file, line or message string is named,
because none was read.

### 6.1 IC-1

**What the design now does, that the specification forbids.** For every frame
that emits no output word, M03 pulses that frame's strobe **three** cycles after
the input word carrying the character that ended the frame, where SPEC-M03 §9's
**Strobe cycle, pinned** requires **two**, *"at both start lanes"*. The pulse
therefore lands on requirements.md §0.6's ceiling — the module's latency ΔC = 3
after the reference word — which §0.6 rules, in terms, is **inside the window and
non-conformant**, *"on §9's authority and not on this window's"*.

**Anything that decides a no-output-word frame's report against §9's exact pin
detects it.** That includes both structures (§2.1) and all of `error_runt`
(REQ-107's sub-5 class, §9 row 6), `error_bad_frame` (REQ-105's
at-or-before-the-first-octet case) and `error_start_without_terminate`
(REQ-110's at-or-before-the-first-octet case).

**Anything that decides the report only against §0.6's window does not detect
it**, because the deferred cycle is still inside that window — requirements.md
§0.6 says so and calls the consequence an instrument fact: *"a monitor built on
this window alone cannot convict a report-path delay on this class at any
unit."* This is the whole discriminator the round is measuring.

**What must not change, and does not.** Every frame that emits an output word
reports on its own `tlast` cycle exactly as at base; the delivered stream is
bit-identical to base on every stimulus (§5); the number of reports is unchanged
(no strobe's high-cycle count rises, and the only way one can fall is §7.1's
disclosed shape); the strobe *names* are unchanged; `tuser`[0] is unchanged.

**At member (iii), derived exactly**: `error_runt` high at cycle **5** instead of
cycle **4**, at both start lanes; exactly one high cycle; no other strobe; zero
output words; `tvalid` and `tlast` never high (§3.2, §3.3, §5.4). Cycle 5 is the
boundary the packet §3 names, so the pulse lands **at** it, satisfying §8's
sealed inequality `observed ≥ 5` in the direction §8 fixes — later, never
earlier.

### 6.2 IC-2

**What the design now does, that the specification forbids.** For every frame
that emits an output word, M03 pulses that frame's strobe **one cycle after** the
cycle it emits that frame's `tlast` word, where SPEC-M03 §9 requires the strobe
*"on the cycle M03 emits that frame's `tlast` word"*. REQ-104's `error_bad_fcs`,
REQ-107's with-delivery `error_runt`, REQ-105's with-delivery `error_bad_frame`,
REQ-108's `error_oversize` and REQ-110's with-delivery
`error_start_without_terminate` all move. Anything deciding a delivered frame's
report against its own `tlast` cycle detects it.

**What must not change, and does not.** No frame that emits no output word moves
at all — the no-output-word pin stays at the closing word + 2 in **both**
structures and for **all** closure characters (§2.1's table, IC-2 column). The
delivered stream is bit-identical to base (§5). At member (iii) the design is
bit-identical to base on all five strobes at both start lanes (§3.4), so **a red
there under IC-2 cannot come from this diff.**

---

## 7. Disclosed rendering properties, before any result exists

Neither of these is an escape taken; both are facts of the delivered diffs that a
scorecard would otherwise discover. Recorded here because a disclosure made
before running costs nothing and the same fact found afterwards is a finding.

### 7.1 The one shape in which IC-1's shift can cost a high cycle

C-23 counts **high cycles, never rising edges** (requirements.md §0.6). A
one-cycle shift can therefore land a moved report on the same cycle as an
unmoved one of the **same strobe name**, and two events then occupy one high
cycle.

**Measured, exhaustively over the 20 736-stimulus sweep** (model §D):

| variant | count-losing stimuli | on which strobe | count-gaining |
|---|---|---|---|
| IC-1 | **291** of 20 736 (1.4 %) | `error_start_without_terminate` 285, `error_bad_frame` 6, **`error_runt` 0** | 0 |
| IC-2 | **261** of 20 736 (1.3 %) | `error_start_without_terminate` 235, `error_bad_frame` 26, **`error_runt` 0** | 0 |

The smallest instance, in full (model §F) — three frames chained by REQ-110
aborts, `/S/` lane 0 at cycles 2 and 3 and `/S/` lane 4 at cycle 4:

```
   BASE: error_start_without_terminate at [5, 6]      (frame 1's no-output-word
                                                       report at 5; frame 2's
                                                       tlast-pinned report at 6)
   IC1 : error_start_without_terminate at [6]         (the two collide)
   IC2 : error_start_without_terminate at [5, 7]      (the two separate)
```

Four things worth having straight:

1. **It is a property of the intent, not of this rendering.** Any design that
   defers the no-output-word report by one cycle puts it on the cycle §9 pins the
   next report to, wherever the two were one cycle apart. The rejected chain
   rendering of §5.5 does the same thing.
2. **It is not the §6.3 item 8 class.** §6.3 item 8 declares unconstrained the
   stimulus in which two frames' reports fall on the same cycle *at base*; here
   the base separates them and the mutant collides them. The collision is
   mutation-induced.
3. **It cannot touch member (iii)**, whose run contains one frame and one report;
   the count there is **exactly 1** at both lanes under both variants, derived at
   §3.2–§3.3 and measured at model §B. §8's *"the count of pulses in member
   (iii)'s run = 1, not mutant-owned"* row is satisfied.
4. **It never touches `error_runt`** anywhere in the sweep — 0 count-losing
   stimuli on that name under either variant.

Where a unit in the blast radius does sit on this shape, the observable is a
**count** difference rather than a **cycle** difference. Both are differences
from the base; the note exists so that a red of that shape is not mistaken for
something else.

### 7.2 What is *not* claimed

- **No claim is made about which units redden.** The packet §2 enumerates nine
  no-output-word registrations from the tree; I have not read the tree and cannot
  confirm, refute or refine that enumeration. §2.1's table states which
  *structures* and which *closure characters* IC-1 moves; mapping those onto
  units is dv_lead's, from files I may not open.
- **No claim is made about assertion ordering at member (iii)** beyond §5.4's
  measured fact that the three datapath conditions are unreachable. Which
  assertion raises first, and whether §6's disposition 4 is engaged, is decided
  by files I have not read.
- **No claim is made that the diffs compile or elaborate.** See §8.3.

---

## 8. Verification taxonomy

`DISP-0001` §4's supporting change requires three lists, not two: the third is
for **behavioural claims made in disclosures**, each with the method that
discharged it. A disclosure the seal branches on may not sit in the manifest
with a weaker evidence standard than a comment's column width.

### 8.1 Verified mechanically

| check | result |
|---|---|
| base SHA is the parent of the packet commit (`git rev-parse c6c3287^`) | `c0595f9e8026757cd4eed6e856d06555424437e0` — matches |
| base commit subject is `J-dv_lead-0105`'s citation sweep (packet §7's identity) | matches |
| base blob (`git rev-parse c0595f9:…`) | `30ca0385f3106160917ab671c871d774cbaea371`, 1011 lines, `sha256` `8fc08242046ec0b8431df90d0fafb581cb22f30acf2b9651e29d3c4c7656fec1` |
| target file unchanged between `c0595f9` and `HEAD` | same blob hash |
| `git apply --check docs/reports/audit/WO-0063B-mutations/ic-1.diff` | **applies cleanly** |
| `git apply --check docs/reports/audit/WO-0063B-mutations/ic-2.diff` | **applies cleanly** |
| `git apply --check -R` each diff against the clean base | **fails**, as it must — the mutation is not present at base |
| apply IC-1 to a pristine `c0595f9` copy → compare with the intended mutant | byte-identical |
| revert IC-1 → compare with base | byte-identical |
| apply IC-2 → compare with the intended mutant; revert → compare with base | byte-identical both ways |
| each diff touches exactly one file | 1 (`libs/hardcaml_ethernet/src/xgmii_rx_64.ml`) |
| `consume <==` identical in base and both mutants | identical, verified by `grep` |
| the new identifiers occur only inside `strobe`'s definition | verified by `grep` (§5.2) |
| `strobe` / `q_strobe` occur only in the five `error_*` output fields | verified by `grep` (§5.2) |
| no added line exceeds the base file's own longest line (97 cols; margin 90 with two pre-existing exceptions at base 622 and 800) | longest added line 70 cols |
| `sha256` of `ic-1.diff` | `87e285e28a64ea1893bfdad42a5f37407f095ae5ffa37df2ba1a4399d7d41283` |
| `sha256` of `ic-2.diff` | `36263bd5ecbfbaa2bb30eafba908b43e11da0a4a7df02042c005e11d4390cac2` |

### 8.2 Verified by execution (the model, §9)

| claim | method | result |
|---|---|---|
| **model fidelity** — the model reproduces the design, not my expectations | run the base variant on the 64-octet member at both start lanes and k = 0, 1, 7 and compare with figures **already measured and recorded** in SPEC-M03 §9 (`tlast` at 19 and 67) and base RTL 938–942 / 951–953 (the full word-cycle sequences) | **all reproduce exactly**: lane-0 `5,7,…,19` at k=1 and `11,19,…,67` at k=7; lane-4 `6,8,…,18,19` at k=1 and `18,26,…,66,67` at k=7; `m+4` and 11 at k=0 at both lanes |
| member (iii) base report cycle | run BASE on the derived stimulus, both lanes | `error_runt` at **4** = closing word + 2 (§9's pin) |
| member (iii) IC-1 report cycle | run IC-1, both lanes | `error_runt` at **5** = closing word + 3 = the boundary |
| member (iii) IC-2 report cycle | run IC-2, both lanes | `error_runt` at **4**, base-identical on all five strobes |
| pulse count = 1, name = `error_runt`, output words = 0 at member (iii) | all three variants, both lanes | holds in all six runs |
| the later schedule raises nothing | run with and without the cycle-10 terminate | identical strobe sets |
| §2.1's scope table (6 rows) | run each closure character on each structure | as tabulated |
| datapath identity | 20 736-stimulus sweep + 6 delivering runs (2 lanes × k∈{0,1,7}) | **0** stimuli move `tvalid`/`tkeep`/`tlast`/`tuser`, either variant |
| IC-2 liveness | same sweep | differs from base on 1 868 stimuli (9.0 %) |
| no strobe count ever rises | same sweep | 0 count-gaining stimuli, either variant |
| the count-losing shape (§7.1) | same sweep | 291 (IC-1) / 261 (IC-2), never on `error_runt` |
| the rejected chain rendering perturbs the datapath | same sweep, `CHAIN` variant | **191** stimuli move the datapath |

### 8.3 Could not be verified, and is not claimed

- **Type-correctness, width inference and elaboration.** No OCaml toolchain was
  run and no `dune build` was attempted; doing so would have required a tree I
  may not create and a build I may not commit. The expressions use only
  vocabulary already present in the base file (`reg spec`, `&:`, `|:`, `~:`,
  `bit`) applied to signals already in scope at the mutation site
  (`sel_valid` 528, `sel_is_r2` 522, `emit_tlast` 963), and every `strobe` call
  site passes a one-bit signal as before. **If either diff fails to compile that
  is a defect in this manifest and I own it**, not a defect in the campaign.
- **`ocamlformat` idempotence.** The added lines are within margin, but I have
  not run the formatter. `dune runtest` does not invoke it; if the campaign's
  pipeline does, a reformat is cosmetic and does not change the seeded behaviour.
- **Combinational loops.** Neither diff introduces a feedback path — both added
  structures are forward registers — but no elaboration was run to confirm it.
- **Anything about the bench.** No file under `test/**` was opened. Every
  statement in §6 is about the design's observable behaviour against
  requirements.md and SPEC-M03, and no unit, cell, message or ordering is
  predicted.

### 8.4 Behavioural claims made in disclosures — the third list

| disclosure / claim | method used to discharge it | grade |
|---|---|---|
| §2.1 — the deferral is shared across all closure characters | the mutated expression reads no closure-character field, plus six measured runs (one per character per structure) | **derived and measured** |
| §2.1 — the deferral covers **both** no-output-word structures | two hunks, plus the same six runs | **derived and measured** |
| §2.2 — it is a hold, not a re-derivation; a second report moves with it | the added signal is a unit-delay register; plus the sweep's "no count ever rises" result | **derived and measured** |
| §3.2 / §3.3 — IC-1 fires at cycle 5 at both lanes | every conjunct evaluated at the firing cycle from the quoted base expressions; recurrence set enumerated; then measured | **derived, then measured** |
| §3.4 — IC-2 never arms at member (iii) | `emit_tlast` shown identically 0 from `pc ≡ 0`; then measured as base-identity | **derived, then measured** |
| §5 — neither diff perturbs the datapath | forward fan-out closure verified by `grep` (a *syntactic* closure, not a fan-out *argument*), plus 20 736-stimulus exhaustive comparison | **derived and measured** |
| §5.5 — the literal chain rendering is out of specification | built and run | **measured** |
| §6 — expected killing behaviour | derived from SPEC-M03 §9's pin and requirements.md §0.6, with the base and mutant cycles measured | **derived, then measured** |
| §7.1 — the count-losing shape | exhaustive sweep, minimal instance exhibited | **measured** |
| the mapping from §2.1's structures onto bench units | **not attempted** — out of allowlist | **not claimed** |

**The A-1 defect, checked for by name.** FINDING A-1's class was *"a fan-out
trace cannot discharge a reachability claim: fan-out proves the mutated value
reaches the gate, it never proves the gate fires."* Every reachability claim in
§3 is discharged by evaluating **all** conjuncts of the quoted gate at the firing
cycle, including the ones the mutation does not feed — `sel_valid`, `sel_is_r2`,
`~:emit_tlast`, `sel_runt`, `~:(i.clear)`, `q_strobe 1`, and at lane 4
additionally `a_hold_end`, `a_pre_mask` and `a_close_error`, each of which is a
sibling input contributed by the stimulus. The one place a fan-out argument
appears is §5.2, and there it is a **syntactic closure over the whole file**
(`grep` for every occurrence, forwards to the output record) rather than a walk
outward from the mutated signal — the direction that failed in WO-0061 — and it is
corroborated by an exhaustive execution rather than left standing alone.

---

## 9. Reproduction

`git apply --check` and the round-trip checks of §8.1 need only the repository:

```
git rev-parse c6c3287^
git rev-parse c0595f9:libs/hardcaml_ethernet/src/xgmii_rx_64.ml
git apply --check docs/reports/audit/WO-0063B-mutations/ic-1.diff
git apply --check docs/reports/audit/WO-0063B-mutations/ic-2.diff
git show c0595f9:libs/hardcaml_ethernet/src/xgmii_rx_64.ml \
  | sed -n '480,534p;570,590p;955,1005p'
```

Every figure in §2, §3, §5 and §7 comes from the model below, which is reproduced
in full so that this manifest is checkable without any scratch file. It needs
nothing but `python3` and depends on no file in this repository — its only input
is the base source, transcribed with base line numbers against every signal. Save
it and run `python3 model.py`.

```python
"""WO-0063B manifest evidence — cycle model of xgmii_rx_64 at base SHA c0595f9.

Modelled line by line from `git show c0595f9:libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
(base line numbers in comments). Four variants:

  BASE   the base design
  IC1    the delivered IC-1 diff (report-path deferral of the no-output-word pin)
  IC2    the delivered IC-2 diff (report-path deferral of the tlast pin)
  CHAIN  the REJECTED IC-1 rendering (a fourth record stage, consumption at
         age 3), retained to show why §4's pre-ship check selected IC1 over it

Run: python3 model.py     (no repo dependency; needs only python3)
"""

IDLE, START, TERM, ERR = 0x07, 0xFB, 0xFD, 0xFE
RUNT_THRESHOLD, FCS_MIN, OVERSIZE = 64, 5, 1518        # base 135, 142
MASK_GE = [0xFF, 0xFE, 0xFC, 0xF8, 0xF0, 0xE0, 0xC0, 0x80, 0x00]   # base 250
MASK_LT = [0x00, 0x01, 0x03, 0x07, 0x0F, 0x1F, 0x3F, 0x7F, 0xFF]   # base 254


def W(*lanes):
    """8 lanes, lane 0 first; ('C', v) control, ('D', v) data."""
    assert len(lanes) == 8
    c, d = 0, [0] * 8
    for k, (kind, v) in enumerate(lanes):
        if kind == "C":
            c |= 1 << k
        d[k] = v
    return c, d


I, S, T, E = ("C", IDLE), ("C", START), ("C", TERM), ("C", ERR)
PRE, SFD, DAT = ("D", 0x55), ("D", 0xD5), ("D", 0xAA)


def idle_word():
    return W(*[I] * 8)


def popcount(v):
    return bin(v).count("1")


def lowest_index(v):
    return (v & -v).bit_length() - 1 if v else 8


class Rx:
    """variant in {BASE, IC1, IC2, CHAIN}."""

    def __init__(self, variant):
        assert variant in ("BASE", "IC1", "IC2", "CHAIN")
        self.v = variant
        self.state = "Idle"
        self.frame_start4 = self.count = 0
        self.r1 = self.r2 = self.r3 = 0
        self.start4_pending = self.off4 = 0
        self.cov_d = self.first_d = self.al_keep_d = 0
        self.fcs_tail_now = 0
        self.q = [0, 0, 0]            # base 583-590 (3rd stage: IC-1 hunk 1)
        self.defer = [0] * 5          # IC-1 / IC-2 hunk 2's register

    @staticmethod
    def rec(valid, terminate, error, start, oversize, fcs, runt):   # base 503-504
        return (valid | (terminate << 1) | (error << 2) | (start << 3)
                | (oversize << 4) | (fcs << 5) | (runt << 6))

    def cycle(self, word, clear=0):
        c, d = word
        bitset = lambda ch: sum((1 << k) for k in range(8)
                                if (c >> k) & 1 and d[k] == ch)          # 184-193
        is_start, is_term, is_err = bitset(START), bitset(TERM), bitset(ERR)
        other_ctl = c & ~(is_start | is_term | is_err) & 0xFF            # 243-244

        in_preamble = self.state == "Preamble"
        in_frame = self.state == "Frame"
        a_open = int(in_preamble or in_frame)                            # 296
        cov_first = ((4 if self.frame_start4 else 0) if in_preamble
                     else (0 if in_frame else 8))                        # 297-302
        a_pre_mask = 0x0F if (in_preamble and self.frame_start4) else 0   # 308
        a_closing_v = is_term | is_err | is_start | (other_ctl & a_pre_mask)   # 312-313
        a_close_oh = (1 << lowest_index(a_closing_v)) if a_closing_v else 0    # 315
        a_char_end = lowest_index(a_closing_v) if a_closing_v else 8     # 316-317
        a_hold_v = other_ctl & ~a_pre_mask & 0xFF                        # 328
        a_hold_end = lowest_index(a_hold_v) if a_hold_v else 8           # 329-331
        cap_room = (OVERSIZE - self.count) & 0x7FF                       # 342
        room = 8 if cap_room >= 8 else cap_room                          # 348
        cap_end = 8 if cov_first + room >= 8 else cov_first + room       # 349-350
        cov_end = min(a_char_end, cap_end, a_hold_end)                   # 353
        cov_nonempty = int(cov_end > cov_first)                          # 381
        cov = MASK_LT[cov_end] & MASK_GE[cov_first] & (0xFF if cov_nonempty else 0)  # 382
        cov_count = (cov_end - cov_first) if cov_nonempty else 0         # 383
        count_next = (self.count + cov_count) & 0x7FF                    # 398

        a_close_oversize = int(a_open and cap_end < a_char_end
                               and cap_end < a_hold_end and cap_end < 8)  # 361-362
        a_char_acts = int(a_open and not a_close_oversize)               # 364
        cw = lambda v: int(bool(a_char_acts) and bool(v & a_close_oh))    # 365
        a_close_terminate = cw(is_term)                                  # 366
        a_close_error = cw(is_err | (other_ctl & a_pre_mask))            # 372-373
        a_close_start = cw(is_start)                                     # 375
        a_close_char = a_close_terminate | a_close_error | a_close_start  # 376
        a_close_now = int((a_close_char or a_close_oversize) and not clear)  # 377
        bad_fcs = 0   # CRC not modelled; upstream of the mutation, identical in all variants
        a_close_runt = int(a_close_terminate and count_next < RUNT_THRESHOLD)  # 502
        r0 = self.rec(a_close_now, a_close_terminate, a_close_error, a_close_start,
                      a_close_oversize, int(a_close_terminate and bad_fcs),
                      a_close_runt)                                      # 506-515

        chain = self.v == "CHAIN"
        sel_is_r3 = (self.r3 & 1) if chain else 0
        sel_is_r2 = int((self.r2 & 1) and not sel_is_r3)                 # 522
        sel_is_r1 = int((self.r1 & 1) and not sel_is_r2 and not sel_is_r3)   # 523
        sel_is_r0 = int(not sel_is_r3 and not sel_is_r2 and not sel_is_r1)   # 524
        sel = (self.r3 if sel_is_r3 else
               (self.r2 if sel_is_r2 else (self.r1 if sel_is_r1 else r0)))   # 525
        sel_valid, sel_terminate = sel & 1, (sel >> 1) & 1
        sel_error, sel_start = (sel >> 2) & 1, (sel >> 3) & 1
        sel_oversize, sel_bad_fcs, sel_runt = ((sel >> 4) & 1, (sel >> 5) & 1,
                                               (sel >> 6) & 1)           # 528-534

        cfg = 1
        b_exists = int(bool((is_start >> 0) & 1) and cfg and not clear)   # 421
        c_exists = int(bool((is_start >> 4) & 1) and cfg and not clear)   # 422
        iwc = lambda above: (is_term | is_err | is_start | other_ctl) & above  # 418-419
        b_closing, c_closing = iwc(0xFE), iwc(0xE0)                      # 423-424
        survivor_b = int(b_exists and not b_closing)                     # 428
        survivor_c = int(c_exists and not c_closing)                     # 429
        begins, new_start4 = survivor_b | survivor_c, survivor_c         # 430-431

        first_v = ((1 << cov_first) if cov_first < 8 else 0) & 0xFF      # 391
        first_v &= 0xFF if (in_preamble and cov_nonempty) else 0         # 392

        def inword_strobes(exists, closing):                            # 570-582
            oh = (1 << lowest_index(closing)) if closing else 0
            cl = int(bool(exists) and bool(closing))
            t_ = int(bool(cl) and bool(is_term & oh))
            e_ = int(bool(cl) and bool((is_err | other_ctl) & oh))
            s_ = int(bool(cl) and bool(is_start & oh))
            return e_ | (t_ << 1) | (s_ << 2)
        q_in = (inword_strobes(b_exists, b_closing)
                | inword_strobes(c_exists, c_closing))                   # 588-589

        bubble = int(self.off4 and a_open and not cov_nonempty and not a_close_now)  # 732
        rot = lambda hi, lo: ((hi & 0x0F) << 4) | ((lo >> 4) & 0x0F)     # 737-740
        al_keep = 0 if bubble else (rot(cov, self.cov_d) if self.off4 else self.cov_d)  # 741
        al_new = int(bool(rot(first_v, self.first_d) if self.off4 else self.first_d))   # 745

        pc = popcount(self.al_keep_d)                                    # 795
        nc = 0 if al_new else popcount(al_keep)                          # 799
        strip = 4 if (sel_valid and (sel_terminate or sel_oversize)) else 0   # 800
        have_word = int((pc != 0) and not self.fcs_tail_now)             # 831
        ev12 = int((not al_new) and bool((al_keep >> 4) & 1))            # 955
        closed = sel_valid                                               # 956
        closure_aligned = int(closed and (not sel_is_r0 or self.off4))   # 957
        decided = int(ev12 or closure_aligned)                           # 958
        emit_last_a = int(have_word and decided and closed
                          and nc == 0 and pc > strip)                    # 959
        emit_last_b = int(have_word and decided and nc != 0 and nc <= strip)  # 960
        emit_full = int(have_word and decided and ((not closed) or nc > strip))  # 962
        emit_tlast = emit_last_a | emit_last_b                           # 963
        hold = int(have_word and not decided and not clear)              # 971
        keep_count = ((pc - strip) if emit_last_a else
                      ((pc - strip + nc) if emit_last_b else pc))        # 972-973
        abort = (sel_bad_fcs | sel_error | sel_start | sel_oversize | sel_runt)  # 975
        tvalid = int((emit_full or emit_tlast) and not clear)            # 976
        consume = int(sel_valid and (emit_tlast
                                     or (sel_is_r3 if chain else sel_is_r2)))  # 977
        tkeep = MASK_LT[keep_count] if keep_count <= 8 else 0xFF         # 995
        tlast = int(emit_tlast and not clear)                            # 997
        tuser = int(emit_tlast and abort)                                # 998

        # ---------------- the mutation site (base 990) ----------------
        report_tlast = int(sel_valid and emit_tlast)
        report_no_word = int(sel_valid and sel_is_r2 and not emit_tlast)
        fields = [sel_bad_fcs, sel_error, sel_start, sel_oversize, sel_runt]
        if self.v in ("BASE", "CHAIN"):
            strobes = [int(consume and f and not clear) for f in fields]
            defer_in = [0] * 5
        elif self.v == "IC1":
            strobes = [int(((report_tlast and f) or self.defer[j]) and not clear)
                       for j, f in enumerate(fields)]
            defer_in = [int(report_no_word and f) for f in fields]
        else:                                                   # IC2
            strobes = [int((self.defer[j] or (report_no_word and f)) and not clear)
                       for j, f in enumerate(fields)]
            defer_in = [int(report_tlast and f) for f in fields]
        q_out = self.q[2] if self.v == "IC1" else self.q[1]      # IC-1 hunk 1
        qs = [int(((q_out >> k) & 1) and not clear) for k in range(3)]   # 991

        out = dict(error_bad_fcs=strobes[0], error_bad_frame=strobes[1] | qs[0],
                   error_runt=strobes[4] | qs[1], error_oversize=strobes[3],
                   error_start_without_terminate=strobes[2] | qs[2],
                   tvalid=tvalid, tkeep=(tkeep if tvalid else None),
                   tlast=tlast, tuser=tuser,
                   state=self.state, cov_first=cov_first, off4=self.off4,
                   a_char_end=a_char_end, cov_count=cov_count,
                   count_next=count_next, a_close_terminate=a_close_terminate,
                   a_close_runt=a_close_runt, r0=r0, r1=self.r1, r2=self.r2,
                   sel=sel, sel_valid=sel_valid, sel_runt=sel_runt,
                   sel_is_r0=sel_is_r0, sel_is_r2=sel_is_r2, pc=pc, nc=nc,
                   have_word=have_word, emit_tlast=emit_tlast, decided=decided,
                   consume=consume, q2=q_out, report_tlast=report_tlast,
                   report_no_word=report_no_word)

        # ---------------- registers ----------------
        st = self.state
        if st == "Idle":
            nxt = "Preamble" if begins else "Idle"
        elif st in ("Preamble", "Frame"):
            nxt = ("Preamble" if begins else
                   ("Discard" if a_close_oversize else
                    ("Idle" if a_close_char else "Frame")))
        else:
            nxt = "Preamble" if begins else ("Idle" if is_term else "Discard")
        M = 0x7F
        if chain:
            self.r3 = self.r2 & ~(M if (consume and sel_is_r2) else 0) & M
        self.r1, self.r2 = (r0 & ~(M if (consume and sel_is_r0) else 0) & M,   # 526
                            self.r1 & ~(M if (consume and sel_is_r1) else 0) & M)  # 527
        self.frame_start4 = new_start4 if begins else self.frame_start4   # 432
        self.count = 0 if begins else count_next                          # 479
        nsp = int(begins and new_start4)                                  # 663
        self.off4 = (0 if (begins and not new_start4)                     # 664-666
                     else (1 if self.start4_pending else self.off4))
        self.start4_pending = nsp
        if not bubble:                                                    # 733-736
            self.cov_d, self.first_d = cov, first_v
        if not hold:                                                      # 781-782
            self.al_keep_d = al_keep
        self.fcs_tail_now = emit_last_b                                   # 830, 961
        self.q = [q_in, self.q[0], self.q[1]]                             # 583-590
        self.defer = defer_in
        if clear:
            self.__init__(self.v)
        else:
            self.state = nxt
        return out


VARIANTS = ("BASE", "IC1", "IC2")
STROBES = ["error_bad_fcs", "error_bad_frame", "error_runt", "error_oversize",
           "error_start_without_terminate"]
DP = ["tvalid", "tkeep", "tlast", "tuser"]


def run(words, variant):
    dut = Rx(variant)
    return [dut.cycle(w) for w in words]


def strobe_cycles(tr):
    return {n: [t for t, s in enumerate(tr) if s[n]] for n in STROBES
            if any(s[n] for s in tr)}


def dp_trace(tr):
    return [(t, s["tkeep"], s["tlast"], s["tuser"])
            for t, s in enumerate(tr) if s["tvalid"] or s["tlast"]]


# ------------------------- stimuli -------------------------
def member_iii(lane4, n=21, auto_term_cycle=10):
    """Member (iii): frame closed by its own /T/, zero octets received.
    Start word cycle 1; closing character cycle 2 — lane 0 at a lane-0 start,
    lane 4 at a lane-4 start (packet §3). Scan boundary 5 = closing word + 3."""
    ws = []
    for t in range(n):
        if t == 1:
            ws.append(W(I, I, I, I, S, PRE, PRE, SFD) if lane4
                      else W(S, PRE, PRE, PRE, PRE, PRE, PRE, SFD))
        elif t == 2:
            ws.append(W(PRE, PRE, PRE, SFD, T, I, I, I) if lane4
                      else W(T, I, I, I, I, I, I, I))
        elif t == auto_term_cycle:
            ws.append(W(T, I, I, I, I, I, I, I))
        else:
            ws.append(idle_word())
    return ws


def delivering64(lane4, k, n=90):
    """64 received octets closed by /T/, k idle words at every in-frame boundary."""
    ws = [idle_word(), (W(I, I, I, I, S, PRE, PRE, SFD) if lane4
                        else W(S, PRE, PRE, PRE, PRE, PRE, PRE, SFD))]
    if lane4:
        body = ([W(PRE, PRE, PRE, SFD, *[("D", 0x21)] * 4)]
                + [W(*[("D", 0x22)] * 8)] * 7
                + [W(*([("D", 0x23)] * 4 + [T, I, I, I]))])
    else:
        body = [W(*[("D", 0x22)] * 8)] * 8 + [W(T, I, I, I, I, I, I, I)]
    for j, w in enumerate(body):
        ws.append(w)
        if j < len(body) - 1:
            ws.extend([idle_word()] * k)
    ws.extend([idle_word()] * (n - len(ws)))
    return ws


def two_word(closer):
    """Epoch-A no-output-word frame: /S/ lane 0 at cycle 1, closer lane 0 at 2."""
    return ([idle_word(), W(S, PRE, PRE, PRE, PRE, PRE, PRE, SFD),
             W(closer, I, I, I, I, I, I, I)] + [idle_word()] * 15)


def in_word(closer):
    """In-word epoch (q2 path): /S/ lane 0 and the closer at lane 4, one word."""
    return [idle_word(), W(S, PRE, PRE, PRE, closer, PRE, PRE, SFD)] + [idle_word()] * 16


ALPHABET = {
    "idle": idle_word(), "data": W(*[DAT] * 8),
    "S0": W(S, PRE, PRE, PRE, PRE, PRE, PRE, SFD),
    "S4": W(I, I, I, I, S, PRE, PRE, SFD),
    "S0S4": W(S, PRE, PRE, PRE, S, PRE, PRE, SFD),
    "S0T4": W(S, PRE, PRE, PRE, T, I, I, I),
    "S0E4": W(S, PRE, PRE, PRE, E, I, I, I),
    "T0": W(T, I, I, I, I, I, I, I), "T4": W(DAT, DAT, DAT, DAT, T, I, I, I),
    "E0": W(E, I, I, I, I, I, I, I), "E4": W(DAT, DAT, DAT, DAT, E, I, I, I),
    "D4S": W(DAT, DAT, DAT, DAT, S, PRE, PRE, SFD),
}


def sweep():
    import itertools
    for combo in itertools.product(ALPHABET, repeat=4):
        yield combo, ([idle_word()] + [ALPHABET[n] for n in combo]
                      + [idle_word()] * 10)


# ------------------------- checks -------------------------
if __name__ == "__main__":
    print("=" * 76)
    print("A. FIDELITY CONTROL — the model must reproduce figures it was not")
    print("   given: SPEC-M03 §9's measured tlast at 19 (k=1) / 67 (k=7) on the")
    print("   64-octet lane-0 member, and base RTL 938-942 / 951-953's sequences.")
    print("=" * 76)
    for lane4 in (False, True):
        for k in (0, 1, 7):
            tr = run(delivering64(lane4, k), "BASE")
            print(f"   lane4={int(lane4)} k={k}: words at "
                  f"{[t for t, s in enumerate(tr) if s['tvalid']]}  "
                  f"tlast at {[t for t, s in enumerate(tr) if s['tlast']]}")

    print()
    print("=" * 76)
    print("B. R-DISC-1 — member (iii), the firing cycle, both start lanes")
    print("=" * 76)
    for lane4 in (False, True):
        ws = member_iii(lane4)
        for v in VARIANTS:
            tr = run(ws, v)
            print(f"   {'lane-4' if lane4 else 'lane-0'} {v:4s}: "
                  f"strobes={strobe_cycles(tr)}  output-words={len(dp_trace(tr))}")

    COLS = ["state", "cov_first", "off4", "a_char_end", "cov_count", "count_next",
            "a_close_terminate", "a_close_runt", "r0", "r1", "r2", "sel_valid",
            "sel_runt", "sel_is_r2", "pc", "emit_tlast", "consume",
            "report_no_word", "report_tlast", "q2", "error_runt"]
    for lane4 in (False, True):
        tr, tb = run(member_iii(lane4), "IC1"), run(member_iii(lane4), "BASE")
        print(f"\n   {'LANE-4' if lane4 else 'LANE-0'} START, variant IC1"
              f" (BASE error_runt in the last column)")
        print("   t  " + " ".join(f"{c[:8]:>8s}" for c in COLS) + "  BASEerr")
        for t in range(7):
            r = tr[t]
            cells = []
            for cc in COLS:
                v = r[cc]
                cells.append(f"{('0x%02x' % v) if cc in ('r0','r1','r2') else v:>8}")
            print(f"   {t:<2d} " + " ".join(cells) + f"  {tb[t]['error_runt']:>7d}")

    print()
    print("=" * 76)
    print("C. DISCLOSURE 1 — IC-1's scope: every closure character, both")
    print("   no-output-word structures.  BASE pins are all closing word + 2.")
    print("=" * 76)
    for label, ws in [
            ("epoch-A aged record, /T/  (REQ-107, §9 row 6)", two_word(T)),
            ("epoch-A aged record, /E/  (REQ-105)", two_word(E)),
            ("epoch-A aged record, /S/  (REQ-110)", two_word(S)),
            ("in-word q2 path,    /T/  (REQ-107)", in_word(T)),
            ("in-word q2 path,    /E/  (REQ-105)", in_word(E)),
            ("in-word q2 path,    /S/  (REQ-110, §10's hook)", in_word(S))]:
        r = {v: strobe_cycles(run(ws, v)) for v in VARIANTS}
        print(f"   {label}\n      BASE={r['BASE']}\n      IC1 ={r['IC1']}\n"
              f"      IC2 ={r['IC2']}")

    print()
    print("=" * 76)
    print("D. §4 PRE-SHIP CHECK — exhaustive datapath identity, 12^4 stimuli")
    print("=" * 76)
    import collections
    tot = 0
    dp_moved = {"IC1": 0, "IC2": 0, "CHAIN": 0}
    differs = {"IC1": 0, "IC2": 0}
    merges = {"IC1": collections.Counter(), "IC2": collections.Counter()}
    splits = {"IC1": 0, "IC2": 0}
    chain_examples = []
    for combo, ws in sweep():
        tot += 1
        tb = run(ws, "BASE")
        for v in ("IC1", "IC2", "CHAIN"):
            tv = run(ws, v)
            if any(tv[t][kk] != tb[t][kk] for t in range(len(ws)) for kk in DP):
                dp_moved[v] += 1
                if v == "CHAIN" and len(chain_examples) < 3:
                    t0 = next(t for t in range(len(ws))
                              if any(tv[t][kk] != tb[t][kk] for kk in DP))
                    chain_examples.append(
                        (combo, t0, [(kk, tb[t0][kk], tv[t0][kk]) for kk in DP
                                     if tv[t0][kk] != tb[t0][kk]]))
            if v == "CHAIN":
                continue
            if any(tv[t][n] != tb[t][n] for t in range(len(ws)) for n in STROBES):
                differs[v] += 1
            for n in STROBES:
                cb, cv = sum(s[n] for s in tb), sum(s[n] for s in tv)
                if cv < cb:
                    merges[v][n] += 1
                if cv > cb:
                    splits[v] += 1
    print(f"   stimuli: {tot}")
    for v in ("IC1", "IC2"):
        print(f"   {v}: stimuli whose DATAPATH (tvalid/tkeep/tlast/tuser) moves "
              f"vs BASE = {dp_moved[v]}")
    print(f"   CHAIN (rejected rendering): stimuli whose DATAPATH moves "
          f"= {dp_moved['CHAIN']}")
    for ex in chain_examples:
        print(f"      CHAIN example {ex}")
    for v in ("IC1", "IC2"):
        print(f"   {v}: stimuli with any strobe difference vs BASE = {differs[v]} "
              f"({100 * differs[v] / tot:.1f}%)")
        print(f"   {v}: high-cycle-count-losing (merge) stimuli = {dict(merges[v])};"
              f" count-gaining (split) = {splits[v]}")

    print()
    print("=" * 76)
    print("E. §4 — member (iii): no output word in any variant, so none of the")
    print("   three datapath messages has a domain there")
    print("=" * 76)
    for lane4 in (False, True):
        for v in ("BASE", "IC1", "IC2", "CHAIN"):
            tr = run(member_iii(lane4), v)
            print(f"   lane4={int(lane4)} {v:5s}: emitted words={dp_trace(tr)} "
                  f"strobes={strobe_cycles(tr)}")

    print()
    print("=" * 76)
    print("F. The merge case, in full — IC-1's one disclosed count-losing shape")
    print("=" * 76)
    combo = ("idle", "S0", "S0", "D4S")
    ws = [idle_word()] + [ALPHABET[n] for n in combo] + [idle_word()] * 10
    for v in VARIANTS:
        tr = run(ws, v)
        print(f"   {v:4s}: strobes={strobe_cycles(tr)}  words={dp_trace(tr)}")

    print()
    print("=" * 76)
    print("G. THE CONTROL, SHOWN AGAINST ITSELF — same strobe name, both classes")
    print("   32 received octets closed by /T/: a DELIVERING runt, tlast-pinned.")
    print("=" * 76)

    def runt32(lane4):
        ws = [idle_word(), (W(I, I, I, I, S, PRE, PRE, SFD) if lane4
                            else W(S, PRE, PRE, PRE, PRE, PRE, PRE, SFD))]
        if lane4:
            ws.append(W(PRE, PRE, PRE, SFD, *[("D", 0x31)] * 4))
            ws += [W(*[("D", 0x32)] * 8)] * 3
            ws.append(W(*([("D", 0x33)] * 4 + [T, I, I, I])))
        else:
            ws += [W(*[("D", 0x32)] * 8)] * 4
            ws.append(W(T, I, I, I, I, I, I, I))
        return ws + [idle_word()] * 12

    for lane4 in (False, True):
        for v in VARIANTS:
            tr = run(runt32(lane4), v)
            print(f"   32-octet runt lane4={int(lane4)} {v:4s}: "
                  f"strobes={strobe_cycles(tr)} words={dp_trace(tr)}")
```

---

**Filed by**: auditor, `J-auditor-0013`.
**Handoff**: to the orchestrator for commit and transient application; to
dv_lead for adjudication against the sealed companion, which I have not read and
will not read.
