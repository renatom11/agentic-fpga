# WO-0061 — ten seeded family-I mutations, authored blind

- **Author**: auditor (`J-auditor-0011`)
- **Packet**: `agents/handoffs/WO-0061_family-i-mutation-campaign.md`
  (dv_lead → auditor, via orchestrator), read in full from the working tree at
  `d08552e`
- **Base SHA**: **`42b9df3`** — the SHA the packet's header names, the SHA its §6
  mechanics build each throwaway branch from, and the SHA of the green control
  run (CI **30920890962**) the packet records
- **File mutated**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (M03). **It is
  the only file any of the ten diffs touches.** No diff reaches root build
  configuration, no diff reaches any other file under `libs/**`, and no class
  demanded that either should.
- **Base blob**:
  `git rev-parse 42b9df3:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` →
  `30ca0385f3106160917ab671c871d774cbaea371`, **1011 lines**, `sha256`
  `8fc08242046ec0b8431df90d0fafb581cb22f30acf2b9651e29d3c4c7656fec1`. The
  `sha256` of the whole `git archive 42b9df3 libs/` extraction (12 files, hashed
  in sorted path order) is
  `1849eac6165c9a7a01d0f0088d930e0190fe38641e046ed238c6004ff818d20d`. This blob
  is **not** the one the WO-0045 … WO-0058 campaigns mutated: the design moved
  from 772 lines to 1011 across `BUG-0002`'s and `BUG-0003`'s repairs, and every
  line number cited below is this base's.
- **Never merge.** Every diff carries a `MUTATION I-cN -- WO-0061, NEVER MERGE`
  comment at its own site, so the marker travels with the patch text and not
  only with the commit subject §6 fixes (which is the orchestrator's to write).
- **All ten classes are SEEDED.** Nothing is NOT-SEEDED. None of the three
  escapes §3 pre-authorises (I-c1's one-octet-per-cycle rendering, I-c8's
  out-of-range threshold, I-c9's no-observable rendering) was taken, and each is
  argued below at its own class rather than merely declined.

> ## This report contains no prediction
>
> **Nothing below is a claim about which bench unit reddens, which stays green,
> or what any failure message says.** I have not read the bench, I do not know
> what M03-I1, M03-I2, M03-I3, M03-I4 or M03-I6 assert, in what order, with what
> helpers, or what any of them prints on failure, and the sealed companion was
> not opened by any route. Every behavioural sentence here is a statement about
> **M03 under the mutation**, argued from `docs/specs/modules/xgmii_rx_64.md`,
> `docs/specs/requirements.md` and the diff, and is falsifiable against those
> three things alone. Consequences are stated as **mechanism** — what signal
> changes, and what follows from it inside the module — and stop there.

---

## 1. Scope statement — WO-0061 §2's allowlist, and what I actually opened

### 1.1 The six readable path sets

| | readable | what I opened |
|---|---|---|
| 1 | **this packet** | `agents/handoffs/WO-0061_family-i-mutation-campaign.md`, in full, from the working tree at `d08552e`. **I did not verify it against `61eb242`** — that would have put an `agents/**` path on a git command line, and §2's bar 11 (*a path outside the allowlist is out of bounds to every git subcommand*) is the stricter reading of the two. I take the packet as given, exactly as at WO-0058. |
| 2 | **`docs/specs/**`** | `docs/specs/modules/xgmii_rx_64.md` — §6 in full (§6.1, §6.2's four-row table, §6.3), §7, §8, §9 in full, §10's REQ table, §11, §13's change log; and the section index. `docs/specs/requirements.md` — §0.5's opening (octet time, latency, front offset), §0.6 in full, §0.7 in full, the §1 rows REQ-001 … REQ-021 and the §2 rows REQ-101 … REQ-113. Read from the working tree; **§1.4 shows this is the base text byte for byte.** |
| 3 | **`docs/adr/**`** | **nothing opened, and not listed.** Every rule I relied on is stated in the two specification documents, which are the normative source; the ADRs the packet cites (ADR-0006, ADR-0007, ADR-0014, ADR-0016) are restated at the sites that matter in SPEC-M03 §6.1 and PROTOCOL §10. |
| 4 | **`libs/**`** | `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **in full** (1011 lines) and `libs/hardcaml_ethernet/src/dune` (four lines, for the library's dependency list in §5). Materialised with `git archive 42b9df3 libs/`, which names the allowlisted set by construction (bar 10); **I opened no other file in the extraction**, though the extraction contains all twelve. |
| 5 | **`docs/reports/audit/**`** | `ls -la docs/reports/audit` and the two campaign directories; `WO-0058-mutations/README.md` — its heading index, lines 1–240 and §4–§7 (869–988) — to keep this report's structure, its extraction form and its evidence standard comparable, which is what my orders name as the template. |
| 6 | **root-level build configuration** | `dune-project` (`(lang dune 3.0)`, `(name agentic_fpga)`) and `.ocamlformat` (`profile = janestreet`, `version = 0.26.2`), both via `git show 42b9df3:<path>`. |

### 1.2 Out of bounds — the blinding conduct, stated affirmatively

**I opened no file under `test/**` at any revision, by any route.** Not
`test_m03_i.ml`, not the rest of the M03 bench, not `test/attack_plans/`, not
`test/monitors/`, not `test/xgmii/`, not `test/golden/`, not `test/cosim/`, not
a `dune` file inside any of them. **I do not know what M03-I1, M03-I2, M03-I3,
M03-I4 or M03-I6 assert, in what order, with what helpers, or what any of them
prints on failure.** Everything I know about those five units is the one-line
description the packet publishes in its own §1 table, plus the line references
the packet itself quotes in its §4.4 and §4.5. I ran no `grep`, no `ls`, no
`wc`, no `git` subcommand and no editor against any path under `test/`.

**I opened no file under `agents/**` other than this packet, my own charter and
`agents/PROTOCOL.md`** — the last two because my spawn prompt's mandatory first
actions name them, and they are the only two `agents/**` files this spawn's
orders require. In particular I did **not** open, list, `ls`, `grep`, hash,
`git show`, `git log`, tab-complete or otherwise touch
`agents/handoffs/WO-0061_family-i-mutation-campaign-SEALED-predictions.md`
**at any revision, by any route**, and I did not open `WO-0059`, `WO-0060`,
`RV-0059-VERDICT`, `RV-0060-VERDICT`, `BUG-0002`, `BUG-0003`,
`SO-xgmii_rx_64.md`, any other `WO-`, `RV-`, `SO-` or `BUG-` packet, any other
agent's journal, `agents/ORG_CHART.md`, `agents/journals/INDEX.md` or
`tasks/BOARD.md`. **I did not read my own journal either** (§1.4, item 3).

**No unscoped `git log` was run**, and **no `git` subcommand of mine named a
path outside the allowlist.** The complete list of git invocations against the
repository is: `git archive 42b9df3 libs/` (twice — once for the authoring
extraction, once for an independent verification extraction);
`git diff --stat 42b9df3 HEAD -- libs/ docs/specs/ docs/adr/ dune-project .ocamlformat`;
`git rev-parse` on the base blob; `git show 42b9df3:dune-project`;
`git show 42b9df3:.ocamlformat`; `git status --porcelain libs/` (**scoped to
`libs/`**, so it can name no out-of-bounds path even when the tree is dirty —
this is the one place this round improves on WO-0058, which ran it unscoped);
and `git apply --check` for each of the ten diffs against the working tree.
Everything else — `git init`, `add`, `commit`, `diff`, `checkout`, `apply` —
ran **inside two throwaway repositories of my own** under the scratch
directory, each containing nothing but a `git archive 42b9df3 libs/`
extraction.

**One repository-root listing, disclosed rather than smoothed**: I ran
`ls -a /home/user/agentic-fpga` once, to fix the set of root-level build
configuration files §2 item 6 admits. It names the repository's top-level
entries, `agents` and `test` among them. It surfaced **no file content** and no
name the packet does not itself already use, and it is listed here rather than
treated as harmless because it is the only command of mine whose output
mentions an out-of-bounds directory at all.

### 1.3 Nothing outside the allowlist was written, either

The working tree's `libs/**` is **unmodified**: every mutation exists only as
diff text in this file and as a file in my private scratch directory (bar 9).
`git status --porcelain libs/` is **empty** after all twenty
`git apply --check` runs. **No branch was created**; no `git commit`,
`git push`, `git add` or `git checkout` was run in the repository. **I ran none
of the ten diffs**, applied none of them to the repository, and have seen no
result of any kind (§5 of the packet: *you do not run the diffs and you do not
see the results*). The only file this spawn writes inside the repository is
this one, plus my journal.

*Scratch note, for completeness.* My scratch directory also carries five
`.diff` files named `M1` … `M5` left by an earlier spawn sharing this session
id. They are outside the repository, they are not repository paths, I did not
open them, and nothing in this round derives from them.

### 1.4 Allowlist ambiguities, resolved conservatively

1. **Which revision of the specifications governs — and this round it is not a
   judgement call.**
   `git diff --stat 42b9df3 HEAD -- libs/ docs/specs/ docs/adr/ dune-project .ocamlformat`
   is **empty**. The working tree's specifications, design, ADRs and root build
   configuration are byte-identical to the base SHA's, so reading them from the
   working tree reads the base. WO-0058 had to argue this point (its §1.4);
   here it is measured and there is nothing left to resolve.
2. **The packet is an `agents/**` path that §2 item 1 nonetheless admits.** I
   read it, and nothing else in `agents/handoffs/`. Bar 11 stopped me
   verifying it against its frozen SHA, and I say so rather than quietly
   verifying: an unverified packet read from the working tree is the
   conservative choice, because the alternative puts an `agents/**` path on a
   git command line in the very directory holding the seal.
3. **My charter, PROTOCOL and my journal are `agents/**` paths.** §2 bars all
   of `agents/**`; my spawn prompt mandates reading the first two and appending
   to the third. I resolved it by reading **exactly** those two files and
   **not** reading the journal at all: my orders supply the next entry id
   (`J-auditor-0011`), so the append needs no read, and the entry is a pure
   end-of-file append whose leading newline makes it correct whether or not the
   file already ended in one. The narrowest reading of "your journal excepted
   for writing" is that it is excepted *for writing*, and that is the reading I
   took.
4. **`docs/adr/**` is allowlisted and I opened none of it.** Reading less than
   the allowlist permits is never a violation, and the two specification
   documents are the normative statement of every rule I used. Where a class
   below cites an ADR (ADR-0006, ADR-0007 at I-c2) it cites it as SPEC-M03 §6.1
   quotes it, not as the ADR states it.
5. **The base extraction was materialised by `git archive`, not by filtering.**
   Bar 10 makes that the required construction, and it is stronger than
   filtering: no out-of-bounds path is ever produced to be excluded. Both
   scratch repositories were built the same way, independently.

---

## 2. What was produced, and how the base identity was fixed

Ten diffs, one per class I-c1 … I-c10, each a unified diff against `42b9df3`
touching `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` and nothing else. **All ten
were authored before any of them was applied anywhere** (bar 7); none has been
run; no result of any kind has been seen.

**Two mechanism comments were corrected during authoring** — I-c5's, which said
its `error_bad_frame` pulses on the held cycle when §9 pins it to the aborted
frame's `tlast` cycle, and I-c6's, which described the corrupted lanes
imprecisely. Both corrections were made **before any diff was applied anywhere
and with no result of any kind in existence**, so neither is bar 8's forbidden
revision-after-a-result; both changed comment text only, and the recorded
`sha256` values below are the corrected ones.

**Clean application, verified three ways** (all read-only against the
repository):

1. In a throwaway git repository containing **only** an independent
   `git archive 42b9df3 libs/` extraction — blob `30ca038`, verified equal to
   the base blob — `git apply --check --index` returns **CLEAN for all ten**.
2. In that same repository each diff was **applied** and the resulting file's
   `sha256` compared against the mutant I authored by direct string
   substitution: **all ten MATCH exactly**, so the diff text is a faithful
   serialisation of the file I reasoned about and not merely something that
   applies. The ten mutant `sha256` prefixes are `e6f9033c1adc` (I-c1),
   `49e519a224cb` (I-c2), `17350b4c82e6` (I-c3), `9f575099666e` (I-c4),
   `451c548196e8` (I-c5), `5d07112bea6a` (I-c6), `1ca5b149cba2` (I-c7),
   `c2725feb793d` (I-c8), `1504357cf5fb` (I-c9), `ba665e1578f3` (I-c10).
3. Against the live working tree at `d08552e`, `git apply --check` returns
   **CLEAN for all ten**, and `git status --porcelain libs/` is empty
   afterwards.

**No two diffs may be applied to the same tree.** Each is written against the
unmutated base and several are behaviourally entangled: I-c1, I-c2, I-c3 and
I-c5 all read the same coverage signals, I-c3 and I-c5 both change what a
carry-forward word does, and I-c6, I-c7 and I-c8 all sit in the emission path.
One branch, one diff, per §6.

---

## 3. The ten manifest entries

### I-c1 — the octet count does not hold across a held cycle

- **Site**: `create`, the epoch-A octet total — `count_next` (base line 398).
- **Code changed**: one line replaced by three; the rest of the diff is comment.

<!-- BEGIN i-c1 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..09b8f60 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -395,7 +395,21 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      and no base selection: the register is reloaded with 0 below on every word
      that hands a *new* frame forward, which is the cycle before that frame's
      first octet at both start lanes. *)
-  let count_next = count +: uresize cov_count count_bits in
+  (* MUTATION I-c1 -- WO-0061, NEVER MERGE. Seeded defect: SPEC-M03 6.2's
+     [Frame] row says the octet count HOLDS on an input word covering no frame
+     octet inside an open frame. This counter advances it by eight instead, on
+     every such word -- REQ-016's injected idle cycle and 6.2's other named
+     held cycle, a terminate character in lane 0, alike. The inflated total is
+     the one REQ-108's 1518 cap, REQ-107's 64-octet runt threshold and the
+     [fcs_min_octets] floor are all read against, so a legal frame under
+     injection changes class. Reach: [count] also feeds [cap_room], hence the
+     truncation point, hence REQ-103's delivered extent -- but only once the
+     inflated total approaches 1518; below that [cap_end] saturates at 8 and
+     coverage is bit-identical. The gate is low in [Discard], where [a_open] is
+     low, and covers no word that covers an octet. *)
+  let held_cycle = a_open &: ~:cov_nonempty in
+  let held_octets = mux2 held_cycle (of_int ~width:4 8) cov_count in
+  let count_next = count +: uresize held_octets count_bits in
   (* ---- epochs B and C: the frames this word begins (REQ-101, REQ-110) ----
      A [/S/] in lane 0 opens epoch B and a [/S/] in lane 4 opens epoch C, each
      closing whatever was open at its own octet time — epoch A, or epoch B in
```

<!-- END i-c1 -->

### What the mutation does, mechanically

`count_next` is the frame's received-octet total through this word's own octet
times, and at base it advances by `cov_count` — the number of frame octets this
word actually covers, zero on a word covering none. The mutant substitutes a
constant **8** for `cov_count` on every word satisfying
`a_open &: ~:cov_nonempty`: the frame is open (state `Preamble` or `Frame`) and
this word's coverage interval `[cov_first, cov_end)` is empty. That predicate is
§6.2's `Frame`-row **held cycle** read at this design's own signals, and it
covers both of the held cycles §6.2 names — REQ-016's injected idle word, and a
terminate character in lane 0.

The inflated total propagates to exactly three readers, all of them the ones
§3's intent names. `count <== reg spec (mux2 begins (zero count_bits)
count_next)` carries it forward, so the inflation accumulates across the frame.
`has_fcs = count_next >=:. fcs_min_octets` is REQ-107's 5-octet floor.
`a_close_runt = a_close_terminate &: (count_next <:. runt_threshold)` is
REQ-107's 64-octet threshold. And the registered `count` feeds
`cap_room = 1518 - count`, hence `cap_end`, hence `cov_end` — REQ-108's
truncation point.

Nothing about the octets themselves moves on the mutated cycle: `cov`,
`cov_count`, `cov_nonempty`, `first_v`, the CRC's `octet_count` and the whole
alignment window read `cov_count` and `cov_end`, none of which the diff touches,
so a held cycle still covers no octet, still produces no aligned word, and
`bubble` still empties it. What changes is the arithmetic the frame is
classified by.

The threshold crossing is worth stating as arithmetic rather than as a claim.
Under a uniform wrapper at k idle cycles per in-frame boundary, a frame of N
octets presents ⌈N/8⌉ covering words and about (⌈N/8⌉ − 1)·k held cycles, so the
mutated total grows by roughly 8k per source word instead of 8 — a factor of
(k + 1). At **N = 1518 and k = 7** each source word contributes 8 + 7·8 = 64 to
the mutated total, so the total passes 1518 after about 24 source words: about
190 received octets in, `cap_room` falls below 8, `cap_end` binds below
`a_char_end`, `a_close_oversize` rises, the frame is truncated there, the state
machine enters `Discard`, `error_oversize` is raised and the remainder of a
perfectly legal maximum-length frame is discarded until the next start
character. At **N = 64 and k = 7** the same arithmetic reaches about 520, which
crosses neither 1518 nor 64 nor 5, so that member's coverage, delivered extent,
`tkeep`, cycles, CRC and strobes are bit-identical to the base design's — a
property of the class, stated here so no adjudication reads its absence there as
anything else.

### MANDATORY DISCLOSURE (packet §3, §5)

**The third standing clause's three answers — does the gate fire (a) on idle
words arriving in the `Discard` state, (b) on idle words arriving in the
`Preamble` state, (c) on a lane-0 terminate character?**

- **(a) `Discard` — NO.** The gate's first term is `a_open = in_preamble |:
  in_frame`, which is structurally low in `Discard` (and in `Idle`). REQ-108's
  post-truncation window is untouched.
- **(b) `Preamble` — YES**, at a lane-0 start, where `cov_first` is 0 and an
  all-idle word gives `cov_end` = 0. At a **lane-4** start the same word's idle
  characters occupy epoch A's preamble positions, so `a_pre_mask` routes them to
  `a_close_error` and the frame closes under REQ-105 — the gate still *fires*
  there (`a_open` is high and coverage is empty), but the frame is closing on
  that same cycle, so `count_next` reaches only `has_fcs` and `a_close_runt`,
  and `a_close_terminate` is low, so nothing observable follows. Both placements
  are stimuli **M03-N3 forbids the injection wrapper to produce** (§6.1: the
  wrapper SHALL NOT inject between a start character and the frame's first
  octet).
- **(c) A lane-0 terminate character — YES.** `/T/` in lane 0 gives
  `a_char_end` = 0 and `cov_end` = 0 with `cov_first` = 0, so the gate fires and
  the closing word adds 8 to `count_next`. The consequence is REQ-107's
  threshold read against a total 8 too high **on the closure cycle itself**: a
  frame of 56 to 63 received octets ending with `/T/` in lane 0 reads as 64 to
  71 and its `error_runt` is suppressed. This is a genuine widening of the class
  beyond the injected half, it is disclosed rather than narrowed, and it is
  reachable **gapless** — the one class here of which that is true.

**Whether the counter you moved also feeds REQ-103's delivered extent /
`tkeep`.** **YES, conditionally, and the condition is exactly REQ-108's.**
`count` feeds `cap_room`, `cap_end` and hence `cov_end`, so once the inflated
total comes within 8 of 1518 the truncation point moves and with it the number
of output words and the `tlast` word's `tkeep`. Below that, `cap_room >=: 8`
holds and `cap_end` saturates at 8, so the cap never binds and coverage is
bit-identical to the base. **This is therefore §4.1's "wide branch" of I-c1**,
and §8 bound 1's `tkeep` instrument at M03-I4/I6 is exercised on it — but only
at a member whose mutated total reaches the cap.

**Whether the 1518 + 7-idle crossing actually occurs.** **YES.** The arithmetic
is above: at N = 1518 with 7 idles at every in-frame boundary the mutated total
passes 1518 after roughly 24 of the frame's 190 source words, so the crossing
happens with an enormous margin rather than marginally. The class is **SEEDED**;
the one-octet-per-cycle rendering §3 pre-authorises as an escape was **not**
taken and was not needed.

---

### I-c2 — the CRC register does not hold across a held cycle

- **Site**: `create`, the running-CRC block — the `Crc32_eth.hierarchical`
  instantiation and `crc_update` (base lines 441–447).
- **Code changed**: two lines edited, two bindings added; the rest is comment.

<!-- BEGIN i-c2 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..9a8d73e 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -438,13 +438,28 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      and M02's result is ignored, so no update-by-zero is ever driven. *)
   let crc_reg = wire 32 in
   let crc_data = mux2 (cov_first ==:. 4) (srl i.xgmii_rx.d 32) i.xgmii_rx.d in
+  (* MUTATION I-c2 -- WO-0061, NEVER MERGE. Seeded defect: SPEC-M03 6.2's
+     [Frame] row says the CRC register HOLDS BY ITS ENABLE across a
+     carry-forward word. Here the enable is asserted on that word with
+     [octet_count] = 8, so all eight lanes of REQ-016's injected idle word are
+     folded into the running residue and every frame the wrapper touches takes
+     a wrong REQ-104 verdict. Driving the enable with [cov_count] = 0 instead
+     would be a no-op through M02's 1-to-8 domain and could not fail, so the
+     count is what moves. SEEDED FOR THE VERDICT ONLY: [cov_count] is
+     untouched, so coverage, [count_next], the delivered octets, every [tkeep]
+     and every cycle are the base design's. [a_close_now] excludes 6.2's other
+     named held cycle, a terminate character in lane 0: folding a closure
+     word's lanes would move gapless frames' verdicts too, a different defect.
+     [a_open] keeps the gate out of [Discard]. *)
+  let crc_carry_fwd = a_open &: ~:cov_nonempty &: ~:a_close_now in
+  let crc_octets = mux2 crc_carry_fwd (of_int ~width:4 8) cov_count in
   let crc =
     Crc32_eth.hierarchical
       scope
-      { Crc32_eth.I.crc_in = crc_reg; data = crc_data; octet_count = cov_count }
+      { Crc32_eth.I.crc_in = crc_reg; data = crc_data; octet_count = crc_octets }
   in
   let crc_out = crc.Crc32_eth.O.crc_out in
-  let crc_update = cov_count <>:. 0 in
+  let crc_update = crc_octets <>:. 0 in
   (* The value the residue is compared against is the one *after* this word's
      update, because §6.1 item 3 runs the coverage through the octet
      immediately preceding the terminate character — which is in this word. *)
```

<!-- END i-c2 -->

### What the mutation does, mechanically

SPEC-M03 §6.1's four-item FCS recipe updates the register "on every cycle
covering at least one frame octet … with `octet_count` set to how many — **1 to
8, never 0**", and §6.2's `Frame` row says the register **holds by its enable**
on a word covering none. This design realises the enable as a mux rather than as
a register enable — `crc_final = mux2 crc_update crc_out crc_reg` with
`crc_update = cov_count <>:. 0` — so the hold and the update are one signal,
`cov_count`, read twice.

The mutant introduces `crc_octets`, equal to `cov_count` everywhere except on a
carry-forward word, where it is 8, and feeds it to **both** readers: M02's
`octet_count` port and `crc_update`. On the held cycle the enable is therefore
asserted and M02 folds **eight octets** — `crc_data`, which at `cov_first` = 0
is the raw XGMII word, i.e. the injected idle word's own eight lanes — into the
running residue. Every subsequent octet of that frame is then CRC'd on a
corrupted seed, so `crc_final` at the terminate character misses REQ-304's
residue `0x2144DF1C`, `bad_fcs` rises, the closure record's `fcs` field is set,
`sel_bad_fcs` drives `error_bad_fcs` on the frame's `tlast` cycle and `abort`
sets `tuser`[0] = 1 on that word. A frame with k ≥ 1 idle cycles injected takes
that verdict; a gapless frame has no carry-forward word and is untouched.

**Why the count and not just the enable.** Asserting `crc_update` alone with
`cov_count` = 0 would have driven M02 outside the 1-to-8 domain SPEC-M02 §11.2
and ADR-0007 pin, and — the decisive point — a 0-octet update is the identity on
the residue, so the mutant would fold nothing and **could not fail**. Moving the
count is what makes this class a defect rather than a no-op, and it is the
minimal way to do it.

The gate is `a_open &: ~:cov_nonempty &: ~:a_close_now` — an open frame, empty
coverage, and no closure decided on this word.

### MANDATORY DISCLOSURE (packet §3, §5)

**The third standing clause's three answers.**

- **(a) `Discard` — NO.** `a_open` is low there.
- **(b) `Preamble` — YES at a lane-0 start** (`cov_first` = 0, an all-idle word
  gives empty coverage, no closure); **NO at a lane-4 start**, where the idle
  characters stand in epoch A's preamble positions, `a_close_error` rises and
  `a_close_now` masks the gate. Both are stimuli M03-N3 forbids the wrapper to
  produce.
- **(c) A lane-0 terminate character — NO**, and deliberately. `a_close_now` is
  high on that word, so the gate is masked. Folding a closure word's lanes would
  give **every gapless frame whose `/T/` lands in lane 0** a wrong FCS verdict,
  which is a different and far wider defect than "the idle word's lanes are
  folded into the residue"; §3's own scope sentence — *the frame's FCS verdict
  is then wrong for every frame the wrapper touches* — is what fixes the
  narrower reading, and I took it.

**Whether the delivered octets move as well as the verdict.** **NO.** The diff
touches `octet_count` and `crc_update` and nothing else. `cov`, `cov_count`,
`cov_end`, `count_next`, `first_v`, the alignment window, `bubble`, `al_keep`,
`pc`, `nc`, `strip`, `keep_count`, `emit_*` and `hold` are all bit-identical, so
the frame's delivered octets, its word count, every `tkeep`, every word's cycle
and the frame's closure are the base design's. **This class corrupts the verdict
and only the verdict**, which is the separation §4(b)'s collision rule exists to
be able to make against I-c6. The two observables that do move alongside the
strobe are `tuser`[0] on the `tlast` word and the `error_bad_fcs` pulse itself —
they are REQ-104's own two consequences of one condition, not a second seeded
defect.

---

### I-c3 — a held cycle produces an output word

- **Site**: `create`, the REQ-016 hold vector — `a_hold_v` (base line 328).
- **Code changed**: one line; the rest of the diff is comment.

<!-- BEGIN i-c3 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..9844115 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -325,7 +325,21 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      frame) is not one §10 commissions: REQ-016's wrapper injects whole idle
      cycles, so the hold lane is lane 0 and no octet is at stake. Where it is
      driven anyway, coverage still stops at the hold lane. *)
-  let a_hold_v = other_ctl &: ~:a_pre_mask in
+  (* MUTATION I-c3 -- WO-0061, NEVER MERGE. Seeded defect: SPEC-M03 6.2's
+     [Frame] row says NO OUTPUT WORD IS PRODUCED on an input word covering no
+     frame octet. With the hold vector empty, an other-control lane inside an
+     open frame no longer ends this word's coverage, so REQ-016's injected idle
+     word is decoded as eight DATA octets, covered like any other word and
+     forwarded: the frame grows by eight octets per injected idle cycle and the
+     receiver delivers more words than the frame contains. The frame's octet
+     count and its CRC move with the forwarded octets, because [cov_count]
+     feeds both. Reach: the same edit removes the hold at sub-word granularity,
+     which no commissioned stimulus produces (6.1's C-14.4 paragraph), and it
+     removes [a_hold_end]'s suppression of REQ-108's truncation on a word whose
+     hold lane lies below the cap. In [Discard] and at a lane-4 start's
+     preamble positions nothing moves: [cov_first] is 8 in the first and
+     REQ-102 routes the character to REQ-105 in the second. *)
+  let a_hold_v = zero 8 in
   let a_hold_end =
     mux2 (any a_hold_v) (index_of_onehot (lowest_set a_hold_v)) (of_int ~width:4 8)
   in
```

<!-- END i-c3 -->

### What the mutation does, mechanically

`a_hold_v` is the design's realisation of §6.1's C-14.4 hold: an other-control
lane outside epoch A's preamble positions ends this word's coverage and carries
the frame forward without closing it. `a_hold_end` is the index of the lowest
such lane, and `cov_end = min2 (min2 a_char_end cap_end) a_hold_end` is what
stops coverage there. With `a_hold_v` empty, `a_hold_end` is the constant 8 and
the minimum is decided by the closure character and the REQ-108 cap alone.

For REQ-016's injected idle word inside an open `Frame`, `a_pre_mask` is 0 (the
machine is not in `Preamble`), so `a_closing_v` is 0 and `a_char_end` is 8; the
cap does not bind at any ordinary length; so `cov_end` = 8 against `cov_first` =
0. The word therefore covers **all eight lanes as data octets**: `cov` = 0xFF,
`cov_count` = 8. From there everything follows through the untouched pipeline —
`count_next` advances by 8, the CRC folds those eight lanes with `octet_count` =
8, `cov` enters the alignment window, `bubble` (which requires `~:cov_nonempty`)
is now low so the window advances normally, and a full aligned word is assembled
and emitted like any other. The frame grows by eight octets per injected idle
cycle, and the receiver delivers more words than the frame contains, with the
frame's own last octets pushed past the FCS-removal arithmetic that was computed
for the true length.

### MANDATORY DISCLOSURE (packet §3, §5)

**The third standing clause's three answers.**

- **(a) `Discard` — NO.** `cov_first` is 8 in `Discard` (and in `Idle`), so
  `cov_end > cov_first` is unsatisfiable there and coverage stays empty whatever
  `a_hold_end` reads.
- **(b) `Preamble` — YES at a lane-0 start**, where `cov_first` = 0 and an idle
  word now covers eight octets that are not the frame's; **NO at a lane-4
  start**, where those lanes are preamble positions, `a_pre_mask` = 0x0F puts
  them in `a_closing_v`, `a_char_end` = 0 decides the minimum, and coverage
  stays empty exactly as at base. Both are M03-N3-forbidden stimuli.
- **(c) A lane-0 terminate character — NO.** `/T/` is in `a_closing_v`, not in
  `other_ctl`, so `a_char_end` = 0 decides `cov_end` and the terminate word
  still covers nothing (§6.1's second non-instance, C-18). The diff does not
  reach it.

**Whether the frame's count and CRC move with the forwarded octets.** **YES,
both, and by construction rather than as a side effect.** The single signal
`cov_count` feeds the octet total (`count_next`), M02's `octet_count` and the
coverage vector that becomes `tkeep`, so making the idle word cover eight octets
necessarily advances the count by 8 and folds those eight lanes into the
residue. §3 says *they naturally will; say so* — they do, and this is the
saying.

**Scope reaches beyond the class's own statement, disclosed under the second
standing clause.** Two, both consequences of nulling the vector rather than
gating it: (i) the hold is removed at **sub-word** granularity as well as
whole-word, so a single other-control lane inside an open frame now decodes as
data instead of ending coverage — a configuration §6.1's own C-14.4 paragraph
records as commissioned by nothing and which §10's wrapper cannot produce; and
(ii) `a_hold_end` no longer participates in `a_close_oversize`, so a word whose
hold lane lies below the REQ-108 cap no longer suppresses the truncation. Both
were preferred to a gated rendering because a gate would have had to name the
whole-word case explicitly, which is the wrapper's shape and not the design's,
and §3 asks for the defect and not for the stimulus.

---

### I-c4 — a held cycle raises a condition

- **Site**: `create`, the in-word two-stage report path — `q2` (base lines
  583–590).
- **Code changed**: one line added to the OR tree, one binding added.

<!-- BEGIN i-c4 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..8b3066f 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -580,13 +580,26 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
        `error_bad_fcs` out of this vector entirely (above). *)
     concat_lsb [ error; terminate; start ]
   in
+  (* MUTATION I-c4 -- WO-0061, NEVER MERGE. Seeded defect: SPEC-M03 6.2's
+     [Frame] row says NO CONDITION IS RAISED on an input word covering no frame
+     octet inside an open frame. Here such a word is treated as an anomaly and
+     reported as REQ-105's [error_bad_frame] through the in-word two-stage
+     report path, so the pulse lands exactly TWO cycles after the held cycle.
+     REQ-008's conservation is what makes a report of an event that did not
+     happen a defect. NOTHING ELSE MOVES: [q2] is read only by [q_strobe] and
+     only its bit 0 is touched, so the frame continues and its octets, count,
+     CRC, coverage, cycles, [tkeep], [tuser] and closure are the base design's.
+     [a_open] keeps the gate out of [Discard]; [a_close_now] keeps it off
+     6.2's other named held cycle, a terminate character in lane 0. *)
+  let strobe_carry_fwd = a_open &: ~:cov_nonempty &: ~:a_close_now in
   let q2 =
     reg
       spec
       (reg
          spec
          (inword_strobes ~exists:b_exists ~closing:b_closing
-          |: inword_strobes ~exists:c_exists ~closing:c_closing))
+          |: inword_strobes ~exists:c_exists ~closing:c_closing
+          |: uresize strobe_carry_fwd 3))
   in
   (* ---- the state machine (§6.2) ----
      One [Always] switch, and every transition is a function of the closure
```

<!-- END i-c4 -->

### What the mutation does, mechanically

`q2` is the design's second report path: a two-deep register chain carrying the
three-bit strobe vector of an epoch opened *and* closed inside one input word,
whose §9 cycle is pinned two cycles after that word and is a function of nothing
downstream. Bit 0 of the vector is `error_bad_frame`, bit 1 `error_runt`, bit 2
`error_start_without_terminate`, read out by `q_strobe` and ORed with epoch A's
consumed strobes at the output ports.

The mutant ORs `uresize strobe_carry_fwd 3` into the chain's input — a one-bit
signal zero-extended to three, so **bit 0 only**. On a carry-forward word the
vector's `error_bad_frame` bit is set, and two register stages later
`q_strobe 0` drives `error_bad_frame` high for exactly one cycle. REQ-016 says
that word is normal and §6.2's `Frame` row says **no condition is raised** on
it; REQ-008's conservation is what makes reporting an event that did not happen
a defect rather than a nuance, and §0.6's frame-conservation equation is then
long by one discard-strobe pulse per injected idle cycle.

**Everything else is correct, and that is checkable rather than asserted.** `q2`
is read at exactly one place — `q_strobe k = bit q2 k &: ~:(i.clear)` — and only
bit 0 is touched, so `error_runt` and `error_start_without_terminate` are
unchanged. Nothing else in the module reads `q2`. The frame continues; its
coverage, octet total, CRC, closure record, alignment window, emission decision,
`tvalid`, `tdata`, `tkeep`, `tlast`, `tuser` and state sequence are all
bit-identical to the base design's. This class agrees with every content, count
and timing assertion a correct design satisfies, and I have not strengthened it.

### MANDATORY DISCLOSURE (packet §3, §5)

**The third standing clause's three answers.**

- **(a) `Discard` — NO.** `a_open` is low there, so REQ-108's post-truncation
  silence is untouched.
- **(b) `Preamble` — YES at a lane-0 start; NO at a lane-4 start**, where
  `a_close_now` is high on the idle word (REQ-102 → REQ-105) and masks the gate.
  Both are M03-N3-forbidden stimuli.
- **(c) A lane-0 terminate character — NO.** `a_close_now` is high on that word.
  The alternative would have put an `error_bad_frame` on **every** frame closed
  by a lane-0 `/T/`, gapless runs included, which is not "an idle word arriving
  inside an open frame is treated as an anomaly".

**Which strobe you pulse, and on which cycle relative to the held cycle.**
**Strobe: `error_bad_frame` (REQ-105's name, `q2` bit 0).** **Cycle: exactly
`held cycle + 2`** — the in-word path is two fixed register stages with no
ageing and no consumption decision, so the offset is a constant and not a
function of the frame, its length, its start lane or anything downstream. Under
a uniform wrapper at k idles per boundary the pulses are consecutive high
cycles, k of them per boundary, which §0.6's counting convention reads as k
events.

---

### I-c5 — a held cycle closes the frame

- **Site**: `create`, epoch A's REQ-105 closure predicate — `a_close_error`
  (base lines 372–374).
- **Code changed**: one line edited, one binding added.

<!-- BEGIN i-c5 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..eee09c4 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -369,8 +369,24 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      epoch A's preamble positions — `/I/` and `/Q/` included (§6.2's [Preamble]
      row as revised at 541ea43). Outside a preamble position the same character
      is the hold above and closes nothing. *)
+  (* MUTATION I-c5 -- WO-0061, NEVER MERGE. Seeded defect: SPEC-M03 6.2's
+     [Frame] row lists the frame's exits exhaustively -- /T/, /E/, /S/ and
+     REQ-108's count -- and a held cycle is not among them. Here the first
+     input word covering no frame octet inside an open frame closes the frame
+     through the REQ-105 path: the record carries [error], so the frame ends
+     there, whatever it has received is delivered with no FCS removal
+     ([strip] = 0) and [tuser] bit 0 set on its [tlast] word, one
+     [error_bad_frame] pulses on the cycle 9 pins for it -- that frame's
+     [tlast] cycle, or age 2 where it emits no word -- the machine falls to
+     [Idle], and everything after the idle word is orphaned until the next
+     start character. The gate is written from [a_char_acts] and [a_closing_v]
+     rather than from [a_close_now], because [a_close_now] is a function of
+     [a_close_error] and the pair would be a combinational loop; the
+     consequence is that it excludes REQ-108's truncating word and every word
+     carrying a closure character, 6.2's lane-0 terminate among them. *)
+  let held_close = a_char_acts &: ~:(cov_end >: cov_first) &: ~:(any a_closing_v) in
   let a_close_error =
-    a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask))
+    a_closes_with (lanes.is_error |: (other_ctl &: a_pre_mask)) |: held_close
   in
   let a_close_start = a_closes_with lanes.is_start in
   let a_close_char = a_close_terminate |: a_close_error |: a_close_start in
```

<!-- END i-c5 -->

### What the mutation does, mechanically

§6.2's `Frame` row lists the frame's exits exhaustively — `/T/` (REQ-106), `/E/`
(REQ-105), `/S/` (REQ-110) and the count passing 1518 (REQ-108) — and a held
cycle is not among them. The mutant adds it, through the `/E/` path: `held_close`
is ORed into `a_close_error`, so a carry-forward word raises epoch A's REQ-105
closure. From there the base design does the rest. `a_close_char` rises, hence
`a_close_now`; a closure record is written at `r0` with its `error` field set and
`terminate`, `oversize`, `fcs` and `runt` clear; `strip` stays 0 because
`sel_terminate` and `sel_oversize` are low, so **no FCS removal is attempted**
(REQ-103's third case); `abort` picks up `sel_error`, so `tuser`[0] = 1 on the
frame's `tlast` word; `error_bad_frame` pulses on the cycle §9 pins — that
frame's `tlast` cycle, or age 2 where it emits no word. The state machine's
`Frame` and `Preamble` rows both take `Idle` on `a_close_char`, so everything
after the idle word is orphaned until the next start character.

**Why the gate is written the way it is.** The obvious spelling — reuse
`a_close_now`'s complement, as I-c2 and I-c4 do — is unavailable here, because
`a_close_now` is a function of `a_close_error` and the pair would be a
combinational loop. `held_close` is therefore built from signals that are
already settled at that point in the file: `a_char_acts` (which carries
`a_open` and REQ-108's truncation exclusion), `~:(cov_end >: cov_first)` (empty
coverage, spelled with the same operator line 381 uses), and
`~:(any a_closing_v)` (no closure character anywhere in the word). The last
conjunct is what keeps this class off `/T/`, `/E/` and `/S/` words, and it is a
slightly *different* exclusion from `~:a_close_now` — it excludes a closure
character in a lane the closure search would not have selected, and it excludes
epoch A's preamble-position other-control closure. Both differences narrow the
class rather than widen it.

**This class is the campaign's anti-vacuity probe and I have not narrowed it.**
Its gate fires on the first carry-forward word inside an open frame at either
alignment offset, at every frame length, at both start lanes, and at every
non-zero k. It is drastic by design.

### MANDATORY DISCLOSURE (packet §3, §5)

**The third standing clause's three answers.**

- **(a) `Discard` — NO.** `a_char_acts = a_open &: ~:a_close_oversize`, and
  `a_open` is low in `Discard`. REQ-108's discard window keeps its silence.
- **(b) `Preamble` — YES at a lane-0 start** (empty coverage, no closure
  character, frame open): the frame closes there with zero or few delivered
  octets. **NO at a lane-4 start**, where the idle characters are in preamble
  positions, `a_closing_v` is 0x0F and `~:(any a_closing_v)` masks the gate —
  the base REQ-105 abort happens instead, unchanged. Both are M03-N3-forbidden
  stimuli.
- **(c) A lane-0 terminate character — NO.** `/T/` in lane 0 puts bit 0 in
  `a_closing_v`, so `~:(any a_closing_v)` masks the gate and the frame closes
  under REQ-106 exactly as at base, with its runt check and FCS check sequenced
  normally.

**Which closure path you route it through, and what the frame delivers.**
**The `/E/` path — REQ-105's abort with `tuser`[0] marking — and not the `/T/`
path.** Concretely: `strip` = 0, so **no FCS removal is attempted and no FCS
check is sequenced**; the frame delivers every octet it had covered up to the
idle word, in the ordinary words plus a final short word carrying `tlast`;
`tuser`[0] = 1 on that word; one `error_bad_frame`; **no** `error_runt` (the
runt check rides `a_close_terminate`, which is low here) and **no**
`error_bad_fcs` (the record's `fcs` field rides `a_close_terminate` too). Where
the frame had delivered no octet at all — reachable at a lane-4 start whose
first injected idle precedes any covered word — §0.7 and §9's third row apply
instead: no output word, no `tlast` to mark, and the `error_bad_frame` pulse at
age 2 is the frame's only report.

---

### I-c6 — silent content corruption at the held-cycle boundary

- **Site**: `create`, the alignment window's payload register — `data_d` (base
  line 734).
- **Code changed**: one line; the rest of the diff is comment.

<!-- BEGIN i-c6 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..cd040cf 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -731,7 +731,22 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      the open question below and is untouched here. *)
   let bubble = off4 &: a_open &: ~:cov_nonempty &: ~:a_close_now in
   let window_advance = ~:bubble in
-  let data_d = reg spec ~enable:window_advance i.xgmii_rx.d in
+  (* MUTATION I-c6 -- WO-0061, NEVER MERGE. Seeded defect: REQ-016 clause (a)
+     requires the output word sequence unchanged, every octet in its own byte
+     position. The alignment window's DATA register no longer holds across a
+     carry-forward word, so at offset 4 -- where an aligned word straddles two
+     input words -- the word assembled on the cycle after an injected idle
+     takes that idle word's lanes 4 to 7 in its own byte positions 0 to 3,
+     where the frame's octets belong, while [cov_d] and [first_d] still hold
+     and supply that word's shape from the last CONTRIBUTING input word.
+     COUNT-, CYCLE-, [tkeep]- AND
+     VERDICT-PRESERVING AND CONTENT-DESTROYING: [al_keep] is unchanged so every
+     word's shape and [tkeep] are the base design's, [bubble] still empties the
+     held cycle's own aligned word so no word is added or removed, and the CRC
+     is computed from the raw input word and [cov_count] rather than from this
+     register, so the REQ-104 verdict stays clean. At offset 0 [bubble] is
+     identically 0, so a lane-0 start is bit-identical to the base. *)
+  let data_d = reg spec i.xgmii_rx.d in
   let cov_d = reg spec ~enable:window_advance cov in
   let first_d = reg spec ~enable:window_advance first_v in
   let rotate_hi window = select window 11 4 in
```

<!-- END i-c6 -->

### What the mutation does, mechanically

The alignment window is three registers sharing one enable — `data_d` (the
payload), `cov_d` (its coverage) and `first_d` (the new-frame marker) — and
`window_advance = ~:bubble` is BUG-0003's repair: the window **holds** across a
carry-forward word, so the rotation's lower half is the last *contributing*
input word rather than the last input word. The mutant removes that enable from
`data_d` **alone**, leaving `cov_d` and `first_d` holding.

At **offset 4** the aligned word straddles two input words:
`al_data = select (concat_msb [ i.xgmii_rx.d; data_d ]) 95 32`, which is
`data_d`'s lanes 4–7 in aligned byte positions 0–3 and this cycle's lanes 0–3 in
positions 4–7. On the cycle a covering word arrives immediately after an
injected idle, `data_d` now holds **the idle word**, so aligned byte positions
0–3 take the idle word's lanes 4–7 instead of the frame's own octets. Positions
4–7 are the current word's and are correct. Exactly one aligned word per
injected gap is affected, in its low half.

Everything that decides that word's *shape* is untouched, and that is the
class's signature. `al_keep = mux2 bubble (zero 8) (mux2 off4 (rotate_hi
window_keep) cov_d)` reads `cov` and the still-held `cov_d`, so `tkeep`, `pc`,
`nc`, `keep_count` and the word count are the base design's; `bubble` still
forces the held cycle's own aligned word empty, so no word is added or removed;
`al_new` reads the still-held `first_d`, so `ev12` and the emission cycles are
unchanged; and the CRC is computed from `i.xgmii_rx.d` and `cov_count` directly,
never from this register, so REQ-304's residue is still taken over the frame's
**true** octets and the REQ-104 verdict is clean. The frame arrives at the right
time, in the right shape, with the right verdict, and the wrong contents —
REQ-016 clause (a) broken in the octets and nowhere else, with REQ-008 the
reason a silent corruption is a defect.

### MANDATORY DISCLOSURE (packet §3, §5)

**The third standing clause's three answers.** This class adds no gate of its
own: it removes a term from an existing enable, so its reach is exactly
`bubble = off4 &: a_open &: ~:cov_nonempty &: ~:a_close_now`.

- **(a) `Discard` — NO.** `a_open` is low there.
- **(b) `Preamble` — NO**, at either start lane, and for two independent
  reasons. At a lane-0 start `off4` is 0. At a lane-4 start `off4` is still 0
  during the `Preamble` cycle — `start4_pending` is only registered on that
  cycle, so `off4` rises on the first `Frame` cycle — and in any case the idle
  word there raises `a_close_now`. `bubble` is low in `Preamble` at both lanes.
- **(c) A lane-0 terminate character — NO.** `a_close_now` is high on that word,
  so `bubble` is low and the window advances as at base.

**Whether the FCS verdict stays clean (the signature reading) or moves.**
**IT STAYS CLEAN — this is the signature reading.** The CRC path reads the raw
XGMII word and `cov_count`, not `data_d`, so no corrupted octet ever reaches
M02: the residue is computed over the frame's true octets and `error_bad_fcs`
does not pulse. The class is **count-, cycle-, `tkeep`- and verdict-preserving
and content-destroying**, exactly as §3 specifies it. §4(b)'s collision rule is
therefore not invoked, and I-c2 remains the only class in this campaign that
moves the verdict.

**One further scope note, because a reader will find it.** The class has
instances at **lane-4 starts only**, and that is structural rather than a
narrowing: at offset 0 the aligned word *is* the previous input word, no output
word's assembly spans a held cycle, and `bubble` is identically 0 — so a lane-0
start is bit-identical to the base under this diff, at every k. §3's own
wording, *an output word whose assembly spans a held cycle*, has no lane-0
instance to have.

---

### I-c7 — the output word is emitted on the superseded evidence

- **Site**: `create`, the deciding-input-word decision — `decided` (base line
  958).
- **Code changed**: one line; the rest of the diff is comment.

<!-- BEGIN i-c7 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..a780b4f 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -955,7 +955,20 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let ev12 = ~:al_new &: bit al_keep 4 in
   let closed = sel_valid in
   let closure_aligned = closed &: (~:sel_is_r0 |: off4) in
-  let decided = ev12 |: closure_aligned in
+  (* MUTATION I-c7 -- WO-0061, NEVER MERGE. Seeded defect: SPEC-M03 6.1's
+     ruled D(m) makes an output word's deciding input word the one carrying
+     whichever arrives first of received frame octet 8m + 12 or the character
+     that closes the frame. Here a word with NO live closure record is decided
+     the moment it reaches the emission register -- the SUPERSEDED rule, the
+     input word carrying that word's own last octet -- so under injection every
+     non-[tlast] word leaves early, by the idle cycles injected between its own
+     last octet and its deciding octet. THE [tlast] WORD DOES NOT MOVE: its
+     release still needs [closed], and where [closed] holds the added term is
+     low, so [closure_aligned] alone releases it exactly as at base. Gapless
+     the two rules coincide -- [ev12] is already 1 on every cycle [have_word]
+     is with no live record -- so k = 0 is bit-identical. [hold] is the exact
+     complement of [decided] and follows it, so no word is emitted twice. *)
+  let decided = ev12 |: closure_aligned |: ~:closed in
   let emit_last_a = have_word &: decided &: closed &: (nc ==:. 0) &: (pc >: strip) in
   let emit_last_b = have_word &: decided &: (nc <>:. 0) &: (nc <=: strip) in
   fcs_tail_pending <== emit_last_b;
```

<!-- END i-c7 -->

### What the mutation does, mechanically

`decided = ev12 |: closure_aligned` is this design's realisation of SPEC-M03
§6.1's ruled **D(m)**: `ev12` is evidence (a), received frame octet 8m + 12
arriving in the aligned lookahead word at its position 4, and `closure_aligned`
is evidence (b), the character that closes the frame read through the octets'
own alignment. Every arm of the emission decision is qualified by `decided`, and
`hold` is its exact complement, so a completed word waits with `tvalid` = 0
until its evidence arrives.

The mutant ORs in `~:closed`, i.e. `~:sel_valid`: **no closure record is live**.
Where that holds, `decided` is 1 unconditionally, so `emit_full` fires the
moment `have_word` does — the cycle after the aligned word reached the emission
register, which is the cycle after the input word carrying **that word's own
last octet**. That is precisely the rule §6.1 replaced, and the mutant is the
design §6.1's refutation convicts: the word is emitted before the evidence that
would decide whether the frame runs past it. Under a wrapper injecting k idles
between word m's own last octet and its deciding octet, word m leaves **k cycles
early**.

**Nothing gapless moves**, and the design's own comment is the proof rather than
my assertion: it derives that with `have_word` and no live record, on a gapless
stimulus, `ev12` is 1. The added disjunct is therefore true exactly where `ev12`
already was, so k = 0 is bit-identical — §3's *on a gapless stimulus the two
rules coincide exactly, so nothing changes at k = 0*, obtained rather than
assumed.

**No word is emitted twice.** `hold` reads the same `decided`, so a word that is
not held is a word that goes out; the emission register then advances and loads
the aligned word behind it, which on a carry-forward cycle is empty (`al_keep` =
0 through `bubble`), so `have_word` falls and nothing is re-emitted. The octet
*contents* are untouched — the alignment window, `bubble` and the three window
registers are not in this diff — so only cycles move.

### MANDATORY DISCLOSURE (packet §3, §5)

**The third standing clause's three answers.** This class's added term is
**not a state gate and not a held-cycle gate**, and saying otherwise would
misdescribe the diff. It is `~:sel_valid`, a function of the closure-record
channel alone, and it is therefore true in `Idle`, `Preamble`, `Frame` and
`Discard` alike whenever no record is live. Answering the clause's question in
its own terms, at the point where the term can change an observable — a
completed word waiting in the emission register:

- **(a) `Discard` — NO observable.** A frame reaching `Discard` did so through
  REQ-108's truncation, whose record is live (`sel_oversize`), so the term is
  low while that word is released; once the record is consumed there is no word
  left in the register for the term to release early.
- **(b) `Preamble` — NO observable.** The words draining from a previous frame
  during a new frame's `Preamble` cycle are released either by their own live
  record or by `ev12`, and the term adds nothing the base did not already have.
- **(c) A lane-0 terminate character — NO.** The closure record is born at age 0
  on that word's own cycle, so `closed` is high and the added term is low there;
  the `tlast` word's release is `closure_aligned`'s exactly as at base.

**Whether the `tlast` word's cycle moves too.** **NO — and this is the scope
clause met rather than approximated.** Both `tlast` arms require `closed`
(`emit_last_a` names it; `emit_last_b` needs `nc <=: strip` with `nc >=: 1`,
hence `strip` = 4, hence `sel_valid`), and wherever `closed` is high the added
disjunct `~:closed` is low. So `decided` reverts to `ev12 |: closure_aligned`
for every cycle on which a `tlast` word could leave, and the alignment-corrected
release §9's non-normative note describes — age ≥ 1 at offset 0, age 0 admitted
at offset 4 — is untouched. `tkeep`, `tuser`, the octet contents, the counts and
every strobe are likewise untouched: the strobes are pinned to `consume`, which
reads `emit_tlast` and `sel_is_r2` and neither moves.

---

### I-c8 — a spurious output word out of an empty pipeline after prolonged idle

- **Site**: `create`, the output stage — `keep_count` and `tvalid` (base lines
  972–976).
- **Code changed**: two expressions edited, three bindings added.

<!-- BEGIN i-c8 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..03b8b6d 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -969,11 +969,33 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      becomes age 1, and [off4] releases at age 0), so no record can reach the
      age-2 consumption §9 pins while the word it belongs to is still waiting. *)
   hold <== (have_word &: ~:decided &: ~:(i.clear));
+  (* MUTATION I-c8 -- WO-0061, NEVER MERGE. Seeded defect: REQ-109 requires
+     [tvalid] = 0 while idle characters are present and no frame remains in
+     flight. An eight-bit counter ages while the receiver is empty -- no frame
+     open, no closure record live, no word in the emission register -- and is
+     cleared on every cycle it is not. On the cycle it reads 255, i.e. after
+     255 consecutive empty cycles, one spurious output word is put on the
+     stream; because the counter wraps rather than saturating, another follows
+     every 256 cycles for as long as the receiver stays empty. THRESHOLD
+     T = 255 IDLE CYCLES, REPEATING EVERY 256. The word is well formed rather
+     than a REQ-011 violation: [keep_count] is forced to 8 on that cycle, the
+     pipeline holding no octet of its own to mark. It carries [tlast] = 0 and
+     no strobe. Nothing else moves: [consume], the record channel, the five
+     strobes and the state machine do not read this counter. *)
+  let rx_empty = ~:(a_open |: sel_valid |: have_word) in
+  let idle_age =
+    reg_fb spec ~width:8 ~f:(fun d ->
+      mux2 rx_empty (d +: of_int ~width:8 1) (zero 8))
+  in
+  let stale_word = rx_empty &: (idle_age ==:. 255) in
   let keep_count =
-    mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc)
+    mux2
+      stale_word
+      (of_int ~width:4 8)
+      (mux2 emit_last_a (pc -: strip) (mux2 emit_last_b (pc -: strip +: nc) pc))
   in
   let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
-  let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
+  let tvalid = (emit_full |: emit_tlast |: stale_word) &: ~:(i.clear) in
   consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
   (* Three of the five strobes are the union of the two report paths: epoch A's,
      consumed from the aged record on its `tlast` cycle or at age 2, and the
```

<!-- END i-c8 -->

### What the mutation does, mechanically

REQ-109 requires `tvalid` = 0 and no strobe while idle characters are present
**and no frame remains in flight**. The mutant adds an eight-bit counter,
`idle_age`, which increments while `rx_empty` holds — no frame open (`a_open`
low), no closure record live (`sel_valid` low), and no word in the emission
register (`have_word` low) — and is reloaded with 0 on every cycle that
predicate fails. On the cycle the counter reads 255, `stale_word` rises: the
counter has aged through 255 consecutive empty cycles. Because the counter
**wraps** rather than saturating, the next 256 empty cycles produce another, and
so on for as long as the receiver stays empty.

`stale_word` is ORed into `tvalid`, so one output word appears on the stream out
of an empty pipeline. Its `tdata` is whatever `al_data_d` last held — §6.3 item
4 leaves that unconstrained where `tkeep` is 0, but here `tkeep` is not 0: the
mutant also forces `keep_count` to 8 on that cycle, so the word is **well
formed** under REQ-011 (`tkeep` = 0xFF, contiguous from bit 0) rather than the
`tkeep` = 0 word an untouched `keep_count` would have produced with `pc` = 0.
That choice is §3's first standing clause applied: REQ-011 is a spec rule the
intent does not license breaking on the way to a REQ-109 defect, so the rule is
preserved and the collision is disclosed here.

The word carries `tlast` = 0 (`emit_tlast` is low) and `tuser` = 0, and it
pulses no strobe: `consume` reads `sel_valid` and `emit_tlast`, neither of which
this diff touches. So it is a REQ-109 violation and, through REQ-015's
one-frame-between-`tlast`-words rule, a corruption of whatever frame arrives
next; it is **not** a frame-conservation violation, because no frame was
discarded. Nothing else in the module reads `idle_age`, `rx_empty` or
`stale_word`: the record channel, the state machine, the alignment window, the
CRC, the counters and the five strobes are all bit-identical.

### MANDATORY DISCLOSURE (packet §3, §5)

**The threshold T in idle cycles, and once-or-repeating.**

- **T = 255 consecutive idle cycles with the receiver empty.** The counter is
  reloaded with 0 whenever `rx_empty` fails, so it is 0 on the first empty cycle
  of a run and reads 255 on the 256th; the first spurious word therefore appears
  **255 empty cycles after the receiver goes empty**.
- **REPEATING**, every **256** cycles thereafter, for as long as the run of
  empty cycles continues — 255, 511, 767, … The counter wraps; it does not
  saturate and it does not disarm.
- **T is inside the range the bench can see.** §3 names idle runs of 8, 64, 100,
  1001 and 1331 cycles in the suite. T = 255 is strictly greater than 100 and
  strictly less than 1001, so this diff is invisible at the 8-, 64- and
  100-cycle runs and visible only where the run is long. That is deliberate and
  it is §3's own argument for the class — *a pipeline that misbehaves after
  sixty-odd idle cycles is invisible at ten and visible at a thousand*. **T is
  not greater than 1331**, so the escape §3 pre-authorises for this class was
  **not** taken; the class is SEEDED.
- **One measurement note, stated because it decides how a run should be read.**
  `rx_empty` is a *receiver-empty* predicate, not an *idle-character* predicate:
  it counts cycles on which nothing is in flight, whatever the XGMII lanes
  carry. On a run of `/Q/` ordered sets between frames (REQ-113's stimulus) the
  receiver is equally empty, so the counter ages there too.

---

### I-c9 — the ordered set outside a frame is not ignored

- **Site**: `create`, epoch B's existence predicate — `b_exists` (base line 421).
- **Code changed**: one line edited, one binding added.

<!-- BEGIN i-c9 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..ea0fccd 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -418,7 +418,23 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
   let inword_closing above =
     (lanes.is_terminate |: lanes.is_error |: lanes.is_start |: other_ctl) &: above
   in
-  let b_exists = bit lanes.is_start 0 &: i.cfg_rx_enable &: ~:(i.clear) in
+  (* MUTATION I-c9 -- WO-0061, NEVER MERGE. Seeded defect: REQ-113 requires a
+     sequence ordered set outside a frame to be IGNORED -- no output word, no
+     header effect and no strobe. Here a /Q/ (0x9c) in lane 0 arriving while
+     the machine is in [Idle] is acted on as though it were a start character:
+     it OPENS epoch B. Lanes 1 to 7 of a /Q/ word are themselves other-control,
+     so [b_closing] is non-zero and REQ-102's third sentence closes that frame
+     inside its own word under REQ-105. [survivor_b] therefore stays low, so
+     [begins], [frame_start4], the CRC seed, the counter reload and the state
+     machine do not move and NO OUTPUT WORD is produced -- while
+     [inword_strobes] reports the closure, PULSING ONE [error_bad_frame] TWO
+     CYCLES LATER for every /Q/ word. So: it OPENS a frame and PULSES a strobe,
+     and EMITS nothing. The gate is [Idle] rather than [a_open] low, so
+     REQ-108's discard window keeps the silence REQ-108 requires of it. *)
+  let q_opens =
+    bit i.xgmii_rx.c 0 &: (select i.xgmii_rx.d 7 0 ==:. 0x9c) &: sm.is State.Idle
+  in
+  let b_exists = (bit lanes.is_start 0 |: q_opens) &: i.cfg_rx_enable &: ~:(i.clear) in
   let c_exists = bit lanes.is_start 4 &: i.cfg_rx_enable &: ~:(i.clear) in
   let b_closing = inword_closing (of_int ~width:8 0xfe) in
   let c_closing = inword_closing (of_int ~width:8 0xe0) in
```

<!-- END i-c9 -->

### What the mutation does, mechanically

REQ-113 requires a sequence ordered set outside a frame to be **ignored** — no
output word, no header effect and no strobe — and the base design realises that
by testing only for the three control characters that matter and letting
everything else fall through (`other_ctl`). The mutant makes a `/Q/` (0x9C)
decoded in lane 0 while the machine is in `Idle` **act like a start character**:
it is ORed into `b_exists`, so epoch B — the frame a lane-0 `/S/` would open —
comes into existence on that word.

What follows is the base design's own epoch machinery, and it splits on the
stimulus:

1. **With `/Q/` on every lane** — the stimulus §3 names for this class — lanes 1
   through 7 are themselves other-control, so `b_closing = inword_closing 0xFE`
   is non-zero: REQ-102's third sentence routes every control character in a
   preamble position to REQ-105, and the frame epoch B just opened is closed
   inside its own word. `survivor_b = b_exists &: ~:(any b_closing)` is
   therefore low, so `begins` stays low and **nothing else moves** — the state
   machine stays in `Idle`, `frame_start4`, the CRC seed, the octet-counter
   reload and the alignment offset are all untouched, and no output word is
   produced. But `inword_strobes ~exists:b_exists ~closing:b_closing` sees a
   closed epoch whose lowest closing lane carries an other-control character, so
   its `error` bit is set and `q2` drives **one `error_bad_frame`, exactly two
   cycles after that `/Q/` word**. Over a run of ordered-set words the pulses are
   consecutive high cycles, one per word, which §0.6's counting convention reads
   as one event each.
2. **With `/Q/` in lane 0 and data in lanes 1 through 7**, `b_closing` is 0,
   `survivor_b` is high, `begins` rises and the receiver genuinely **opens a
   frame**: it enters `Preamble`, seeds the CRC, reloads the counter and
   receives a frame from whatever follows, emitting output words for it. I state
   this branch because I cannot see the stimulus and the class's disclosure is
   the seal's input; on the packet's own declared stimulus it is branch 1 that
   applies.

The gate is `sm.is State.Idle` rather than `~:a_open`. `~:a_open` would have
included `Discard`, where REQ-108 requires that the receiver *emit no output
word and pulse no strobe, whatever characters arrive* — a second spec rule the
class has no licence to break. Restricting to `Idle` preserves it, and is the
first standing clause applied.

### MANDATORY DISCLOSURE (packet §3, §5)

**What your mutant does with the ordered set: opens a frame, emits an output
word, pulses a strobe, or some combination.**

**On the packet's declared stimulus (`0x9C` on every lane, between frames):
it OPENS a frame and PULSES a strobe. It EMITS no output word.** Precisely:

- **OPENS** — yes, in the design's own sense: epoch B exists, is evaluated, and
  is closed inside the same word. The frame is opened and aborted in one word,
  so no state change survives it.
- **PULSES** — yes: exactly one `error_bad_frame` (REQ-105's name), two cycles
  after the `/Q/` word, one per `/Q/` word in the run.
- **EMITS** — no: an epoch opened and closed in one word delivers no octet (its
  eight preamble positions fill the rest of the word), so there is no `tlast`
  word and no output word of any kind.

**On a `/Q/`-in-lane-0-with-data stimulus, if one exists anywhere: OPENS and
EMITS** — a frame genuinely begins and its words are delivered — **and pulses
nothing for the `/Q/` word itself.**

The class is **SEEDED**: the no-observable rendering §3 pre-authorises as an
escape — *the ordered set decoded as data but no frame opens and nothing is
emitted* — was **not** where minimality landed, because acting on the character
at the epoch predicate produces a report through machinery the design already
has.

---

### I-c10 — a spurious strobe at every clean frame's closure

- **Site**: `create`, the closure record's runt field — `a_close_runt` (base
  line 502).
- **Code changed**: one line edited, one binding added.

<!-- BEGIN i-c10 -->

```diff
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 30ca038..0e0375d 100644
--- a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
+++ b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
@@ -499,7 +499,21 @@ let create (scope : Scope.t) (i : Signal.t I.t) : Signal.t O.t =
      word at W + 3, while the record born at W is consumed at W + 2 at the
      latest. Consumptions therefore never contend, and each record is at age 2
      exactly when its turn comes. *)
-  let a_close_runt = a_close_terminate &: (count_next <:. runt_threshold) in
+  (* MUTATION I-c10 -- WO-0061, NEVER MERGE. Seeded defect: REQ-008's
+     conservation makes a report of an event that did not happen a defect.
+     REQ-107's runt threshold is evaluated here against a counter that has
+     ALREADY BEEN CLEARED and therefore reads zero, so every frame closed by a
+     terminate character satisfies it and every clean frame in the suite
+     carries one [error_runt] it did not earn. STROBE: [error_runt]. OFFSET:
+     the record is born on the terminate character's own input word and is
+     consumed on that frame's [tlast] cycle, which 6.1's drain derivation pins
+     at ONE OR TWO cycles after the terminate word at a lane-0 start and ZERO
+     OR ONE at a lane-4 start, and at TWO for a frame that emits no output
+     word. Reach: REQ-107's own consequences travel with the condition, so the
+     same frames take [tuser] bit 0 = 1 on their [tlast] word through [abort].
+     Frames closed by /E/, /S/ or REQ-108's count are untouched. *)
+  let count_cleared = zero count_bits in
+  let a_close_runt = a_close_terminate &: (count_cleared <:. runt_threshold) in
   let record_fields ~valid ~terminate ~error ~start ~oversize ~fcs ~runt =
     concat_lsb [ valid; terminate; error; start; oversize; fcs; runt ]
   in
```

<!-- END i-c10 -->

### What the mutation does, mechanically

`a_close_runt = a_close_terminate &: (count_next <:. runt_threshold)` is
REQ-107's threshold evaluated at the site §6.2's `Frame` row puts it — on the
`/T/` exit, against the frame's received-octet total through the closing
character's own octet time. The mutant evaluates it against `count_cleared`, a
counter that has **already been cleared** and therefore reads zero. Zero is
below 64 unconditionally, so `a_close_runt` degenerates to `a_close_terminate`:
**every** frame closed by a terminate character satisfies REQ-107's runt
condition.

The record's `runt` field is then set for every such frame, and REQ-107's own
two consequences travel with the condition through the untouched report path:
`sel_runt` drives `error_runt` on the frame's `tlast` cycle, and `sel_runt` is
one of `abort`'s five terms, so `tuser`[0] = 1 on that word. Every clean frame
in the suite therefore carries one strobe it did not earn, and REQ-008's
conservation — the rule that makes a report of an event that did not happen a
defect — is what makes that a defect rather than a nuance. §0.6's frame
conservation equation is long by one discard-strobe pulse per terminated frame.

Nothing else moves. `a_close_runt` is read at exactly one place, the
`record_fields` call at `r0`, and the diff removes no term from anywhere else:
`count_next` still feeds `has_fcs`, `count` and REQ-108's cap unchanged, so the
FCS check, the truncation point, the delivered octets, every `tkeep`, every
word's cycle and the state sequence are the base design's. Frames closed by
`/E/` (REQ-105), by `/S/` (REQ-110) or by REQ-108's count have
`a_close_terminate` low and are untouched entirely.

**This class is deliberately wide** — its reach is every unit whose stimulus
opens and terminates a frame — and §4.1 fixes in advance that this is **one**
detection probed at many stimuli, not many measurements.

### MANDATORY DISCLOSURE (packet §3, §5)

**Which strobe, and the offset in cycles from the terminate word.**

- **STROBE: `error_runt`** (REQ-107's name), through epoch A's aged record and
  `strobe sel_runt`, never through the in-word `q2` path.
- **OFFSET: the frame's own `tlast` cycle, which §6.1's drain derivation pins at
  ONE OR TWO cycles after the terminate word at a lane-0 start and ZERO OR ONE
  at a lane-4 start** — `q + 2` or `q + 3` against the terminate word's `q + 1`,
  according as the residue r = N mod 8 is ≤ 4 or ≥ 5. **For a frame that emits
  no output word** (fewer than 5 octets, §9's sixth row) the record is consumed
  at age 2, so the offset is **+2**, which is §9's own pin for such a frame.
- **The offset is therefore inside `+0 … +2` at every length and both start
  lanes, and never `+3` or later.** I state that plainly because §4.3 item 2
  makes it decide what a kill proves: this rendering's pulse lies inside the
  window every row in the bench already holds, and does **not** land in the
  region only C-14.3's tightened window can see. A `+3`-or-later rendering was
  available only by delaying the strobe — a defect in the report path rather
  than in the threshold comparison — which is a different class from the one §3
  states, so I seeded the faithful one and disclose the consequence rather than
  engineering the offset to reach a particular instrument.

**One co-occurrence reach, disclosed under the second standing clause.** On a
frame whose FCS is genuinely wrong and whose length is 64 or more, the mutant
pulses `error_runt` **and** `error_bad_fcs` together. §9's first co-occurrence
ruling admits that pairing for 5-to-63-octet frames; at 64 and above the pairing
is new, and it is a consequence of the seeded condition rather than a second
seeded defect. Frames of fewer than 5 octets are unchanged: `has_fcs` still
gates the residue comparison, so §9's ninth ruling still holds and
`error_runt` still pulses alone there.

---

## 4. The ten mandatory disclosures, collected

The packet's §5 makes the sealed row set a **function** of these answers, so
they are repeated here in one place, in the packet's own words. Each is argued
in full in its class entry above.

### 4.1 The third standing clause, for I-c1 … I-c7

*"For each of I-c1 … I-c7, state whether your gate also fires (a) on idle words
arriving in the `Discard` state (REQ-108's post-truncation window), (b) on idle
words arriving in the `Preamble` state, and (c) on a lane-0 terminate character
— §6.2's other named held cycle."*

| class | the gate, as written | (a) `Discard` | (b) `Preamble` | (c) lane-0 `/T/` |
|---|---|---|---|---|
| **I-c1** | `a_open &: ~:cov_nonempty` | **NO** | **YES** (lane-0 start; fires but is unobservable at a lane-4 start) | **YES** |
| **I-c2** | `a_open &: ~:cov_nonempty &: ~:a_close_now` | **NO** | **YES** at a lane-0 start, **NO** at a lane-4 start | **NO** |
| **I-c3** | the hold vector emptied; reach is `a_hold_end` no longer binding | **NO** | **YES** at a lane-0 start, **NO** at a lane-4 start | **NO** |
| **I-c4** | `a_open &: ~:cov_nonempty &: ~:a_close_now` | **NO** | **YES** at a lane-0 start, **NO** at a lane-4 start | **NO** |
| **I-c5** | `a_char_acts &: ~:(cov_end >: cov_first) &: ~:(any a_closing_v)` | **NO** | **YES** at a lane-0 start, **NO** at a lane-4 start | **NO** |
| **I-c6** | no gate added; reach is `bubble` = `off4 &: a_open &: ~:cov_nonempty &: ~:a_close_now` | **NO** | **NO** at either start lane | **NO** |
| **I-c7** | **no state gate at all**: the added term is `~:closed` = `~:sel_valid` | true in `Discard`, **no observable** | true in `Preamble`, **no observable** | **NO** (`closed` is high there) |

Every `Preamble` answer above concerns a stimulus **M03-N3 forbids the injection
wrapper to produce** (§6.1: the wrapper SHALL NOT inject between a start
character and the frame's first octet), and none of the seven fires in
`Discard`, so REQ-108's post-truncation silence is preserved by all seven.

### 4.2 The per-class questions

| class | the question the packet asks | the answer |
|---|---|---|
| **I-c1** | whether the counter you moved also feeds REQ-103's delivered extent / `tkeep`; and whether the 1518 + 7-idle crossing actually occurs | **YES, conditionally** — `count` feeds `cap_room` → `cap_end` → `cov_end`, so the delivered extent and the `tlast` word's `tkeep` move **once the inflated total comes within 8 of 1518**, and are bit-identical below that. This is §4.1's **wide branch**. **And YES, the crossing occurs**: at N = 1518 with k = 7 each source word contributes 64 to the mutated total, so 1518 is passed after about 24 of the frame's 190 source words, with an enormous margin. **SEEDED** — the one-octet-per-cycle escape was not taken. |
| **I-c2** | whether the delivered octets move as well as the verdict | **NO.** The diff touches M02's `octet_count` and `crc_update` only; coverage, `count_next`, the delivered octets, every `tkeep`, every cycle and the closure are bit-identical. The verdict moves and nothing else does, so §4(b)'s collision rule is not invoked. |
| **I-c3** | whether the frame's count and CRC move with the forwarded octets | **YES, both.** One signal, `cov_count`, feeds the octet total, M02's `octet_count` and the coverage vector, so the forwarded eight octets are counted and folded exactly as real octets are. |
| **I-c4** | which strobe, and on which cycle relative to the held cycle | **`error_bad_frame`**, on **held cycle + 2 exactly** — the in-word `q2` path is two fixed register stages, so the offset is a constant, independent of length, start lane and everything downstream. |
| **I-c5** | which closure path (`/T/`-like or `/E/`-like), and what the frame delivers | **The `/E/` path.** `strip` = 0, so no FCS removal and no FCS check; the frame delivers every octet covered up to the idle word, ending in a short `tlast` word with `tuser`[0] = 1; one `error_bad_frame`; no `error_runt` and no `error_bad_fcs`. Where it had delivered no octet, §0.7 applies: no output word and the strobe at age 2 is its only report. |
| **I-c6** | whether the FCS verdict stays clean (the signature reading) or moves | **IT STAYS CLEAN.** The CRC reads the raw XGMII word and `cov_count`, never `data_d`, so the residue is taken over the frame's true octets. Count-, cycle-, `tkeep`- and verdict-preserving and content-destroying. Further scope: **lane-4 starts only** — at offset 0 no output word's assembly spans a held cycle and `bubble` is identically 0. |
| **I-c7** | whether the `tlast` word's cycle moves too | **NO.** Both `tlast` arms require `closed`, and the added disjunct is `~:closed`, so wherever a `tlast` word can leave the decision reverts to `ev12 |: closure_aligned` exactly as at base. `tkeep`, `tuser`, contents, counts and strobes are untouched; only non-`tlast` words move, and only under injection. |
| **I-c8** | the threshold **T** in idle cycles, and once-or-repeating | **T = 255 consecutive idle cycles with the receiver empty**, and **REPEATING every 256 cycles** thereafter (255, 511, 767, …) — the counter wraps rather than saturating. T lies strictly between the bench's 100-cycle and 1001-cycle runs, and **T ≤ 1331**, so the out-of-range escape was not taken. |
| **I-c9** | what the ordered set does: opens / emits / pulses / combination | **OPENS + PULSES**, and **EMITS nothing**, on the packet's declared stimulus (`0x9C` on every lane): epoch B is opened and closed inside its own word, `begins` stays low so no state moves, and one `error_bad_frame` pulses two cycles after each `/Q/` word. On a hypothetical `/Q/`-in-lane-0-with-data word instead: **OPENS + EMITS**. **SEEDED** — the no-observable escape was not taken. |
| **I-c10** | which strobe, and the **offset in cycles from the terminate word** | **`error_runt`**, at **+1 or +2 at a lane-0 start and +0 or +1 at a lane-4 start** (the drain derivation's own two cases, by residue), and **+2** for a frame that emits no output word. **Never +3 or later.** §4.3 item 2's consequence is stated at the class entry rather than left to be inferred. |

---

## 5. Build state, and what I could not verify

**Build-only repairs applied: none.** Bar 8's exception has not been invoked,
because no diff has been built or run. The two comment corrections recorded in
§2 are authoring, not repair: they were made before any application anywhere and
with no result in existence.

**What was verified mechanically:**

- **Syntax and comment lexing**: every mutant parses. `ocamlc -stop-after
  parsing -c` (system OCaml **4.14.1**) accepts all ten, and accepts the
  unmutated base as a control. This is a real check for this file — the added
  comments contain `[/S/]`-style bracket text, `--`, apostrophes and `/T/`, and
  an unbalanced `"` inside an OCaml comment is a lexer error. **No added comment
  contains a double quote at all** (0 in every one of the ten).
- **Clean application and faithful serialisation**: §2's three checks, all ten
  CLEAN and all ten `sha256`-MATCH.
- **Margin**: **every added line is ≤ 87 columns** (the widest is I-c9's
  `b_exists` line at 87), and every added expression is either a single-line
  `let … in` or is laid out in the file's own existing multi-line style
  (I-c8's `reg_fb` follows line 664–667's shape; I-c8's nested `mux2` follows
  the `mux2`-per-line shape the file uses at 298–301). The base itself carries
  **two 97-column lines** (622 and 800) against `.ocamlformat`'s janestreet
  profile, so **whether `dune build @fmt` is clean at `42b9df3` at all is
  unestablished** — unchanged from WO-0050, WO-0055 and WO-0058 and still open.
  If an `@fmt` failure appears under any of these ten, the first question is
  whether it is pre-existing; bar 8's build-only repair clause should not be
  spent on a base-level failure.
- **Vocabulary**: every operator and combinator used in the ten diffs already
  appears in the base file, most of them within a few lines of the mutation
  site. `&:`, `|:`, `~:`, `+:`, `-:`, `>:`, `<:.`, `==:.`, `<>:.`, `mux2`,
  `uresize`, `zero`, `of_int ~width:`, `any`, `bit`, `select`, `repeat`, `reg
  spec`, `reg_fb spec ~width: ~f:` and `sm.is State.<C>` are all base
  constructs. Two deliberate avoidances, for different reasons. **`+:.` does not
  appear in the base at all** (nor does `-:.`), so I-c8's increment is written
  `d +: of_int ~width:8 1`: a local build cannot check the shorthand here and a
  guess would be the wrong thing to spend the build-repair exception on.
  **`<=:` does appear** — once, at base line 960 — so I-c5 could have used it;
  I wrote `~:(cov_end >: cov_first)` instead because line 381 states the same
  predicate with `>:` and the mutation reads against that line, which is a style
  choice and not a necessity.

**What could not be verified, and is therefore argued rather than demonstrated:**

- **Types, widths and elaboration.** Hardcaml, `hardcaml_axi`, `ppx_hardcaml`
  and `ppx_jane` are absent from this container
  (`libs/hardcaml_ethernet/src/dune` names them), and ADR-0005 makes a local
  build inadmissible evidence in any case. The argument is by construction:
  every added signal is one bit wide except `crc_octets` and `held_octets` (4
  bits, matching `cov_count`), `idle_age` (8 bits, its own literal), and
  `count_cleared` (`count_bits`, matching the comparison's other operand); every
  combination is between operands of equal width; `uresize strobe_carry_fwd 3`
  matches the three-bit `inword_strobes` vector it is ORed with; and
  `of_int ~width:4 8` matches `keep_of_count`'s and `count_next`'s 4-bit inputs.
  **No binding is left unused by any diff**, and no diff removes a use of an
  existing binding except I-c3's, which drops `other_ctl` and `a_pre_mask` from
  `a_hold_v` while both remain used at `a_closing_v`, `a_close_error`,
  `inword_closing` and `inword_strobes`.
- **Combinational loops.** Argued per class rather than checked: the only diff
  that could have introduced one is I-c5, and its entry states why `held_close`
  is built from `a_char_acts`, `cov_end`, `cov_first` and `a_closing_v` rather
  than from `a_close_now`. I-c7's added term reads `closed`, which is
  `sel_valid`, a function of registered record state and of `r0`, not of
  `decided`. I-c8's counter is a register and reads only settled signals.

---

## 6. Fidelity ledger — what was seeded whole, and the judgement calls

**NOT-SEEDED: none.** All ten intents admit a rendering inside their own stated
intent, and all ten are seeded. **None of the three escapes §3 pre-authorises
was taken**, and each was tested rather than waved past: I-c1's crossing is
arithmetic (§3's entry), I-c8's T = 255 is inside the bench's own range of idle
runs, and I-c9's rendering produces a strobe rather than nothing. Nothing was
substituted for something easier and no class was narrowed to make it build.

Four renderings involved a judgement an adjudication should be able to reverse
in one line if dv_lead reads the intent differently:

1. **I-c1's gate omits `~:a_close_now` and I-c2's, I-c4's carry it.** §6.2's
   `Frame` row names **two** held cycles — the injected idle and the lane-0
   terminate — and the three classes quote three different sentences of that
   row. I read I-c1's *"the octet count holds"* as governing both named held
   cycles, and I-c2's *"the idle word's lanes are folded into the residue"* and
   I-c4's *"an idle word arriving inside an open frame"* as naming the idle word
   specifically. The difference is deliberate, it is disclosed at every class,
   and one term reverses either choice. If dv_lead intended I-c1 narrow, its
   lane-0-terminate reach (a suppressed `error_runt` at 56–63 octets, reachable
   gapless) is the part to strike.
2. **I-c3 nulls the hold vector rather than gating it to whole-word idles.** A
   gated rendering would have had to name the wrapper's stimulus shape inside
   the design, which is measuring the wrapper rather than the design. The two
   reaches this costs are disclosed at the class.
3. **I-c8 forces `keep_count` to 8.** Left alone, the spurious word would carry
   `tkeep` = 0 with `tvalid` = 1, which REQ-011 forbids outright — a second spec
   rule broken on the way to a REQ-109 defect. The first standing clause says
   preserve the rule and disclose, so I did. If dv_lead intended the raw
   rendering, deleting the `keep_count` mux is the one-line reversal.
4. **I-c10's offset is the design's, not chosen.** The class as stated moves the
   threshold comparison, and the report cycle then follows §9's pin. I did not
   reach for a `+3`-or-later rendering that would have exercised M03-I2's tight
   window, because that would have required seeding a defect in the report path
   instead — a different class. §4.3's adjudication is fixed in advance for
   exactly this, and the disclosure above is what it needs.

**Bounds this manifest does not close**, beyond the seven the packet names in
its own §8:

- **I-c6 has no lane-0 instance and I-c1 has no instance at the 64-octet
  member.** Both are structural properties of the design and of the class, both
  are derived above, and neither is a narrowing I chose.
- **Three classes (I-c1, I-c3, I-c5) move the delivered word count in different
  directions and by different magnitudes**, which is §4.1's stated separation
  device: I-c3 makes the frame longer by 8 octets per injected idle, I-c5 makes
  it shorter by truncating at the first idle, and I-c1 moves it only where
  REQ-108's cap binds. The magnitudes are stated at each class so the separation
  is available.
- **Two classes put a strobe on the in-word `q2` path** (I-c4 and I-c9) and both
  use bit 0, `error_bad_frame`. They are separated by their stimulus — an idle
  word inside an open frame against a `/Q/` word between frames — and never by
  the instrument.

---

## 7. Extraction, for the orchestrator

Each diff above appears between a `<!-- BEGIN i-cN -->` / `<!-- END i-cN -->`
sentinel pair, in a fenced block whose content is byte-exact. To recover the ten
files, from the repository root:

```sh
python3 - <<'EOF'
import re
src = open("docs/reports/audit/WO-0061-mutations/README.md", encoding="utf-8").read()
pat = "<!-- BEGIN (i-c[0-9]+) -->" + chr(10) * 2 + "[`]{3}diff" + chr(10) + "(.*?)" + chr(10) + "[`]{3}" + chr(10)
n = 0
for m in re.finditer(pat, src, re.S):
    open(m.group(1) + ".diff", "w", encoding="utf-8").write(m.group(2) + chr(10))
    n += 1
print(n, "diffs extracted")
EOF
```

It prints `10 diffs extracted`; any other number means the file was edited
between publication and extraction.

Each recovered file applies to `42b9df3` with `git apply`, **on its own**, to a
throwaway branch named `mut/wo-0061-i-c1` … `mut/wo-0061-i-c10` per §6.
**No two diffs may be applied to the same tree** (§2 above). Every branch is
`42b9df3` + one diff and nothing else, so §0.1's mechanical independence check —
`git diff 42b9df3 <mutation-branch> -- test/` must be **empty** — holds by
construction for all ten: no diff here touches any path outside
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml`.
