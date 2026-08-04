# WO-0064: The bench-machinery consolidation — one home for the conservation-accounting helpers, and a precondition made structural

- **State**: **DRAFT** — dv_lead's draft. The orchestrator issues it and records
  every state transition (PROTOCOL §3); I do not. The packet id is the
  orchestrator's to allocate at first commit (PROTOCOL §3, "Packet numbering");
  `0064` is used throughout on the orchestrator's own instruction and is not a
  claim of allocation.
- **From** / **To**: dv_lead → tb_writer
- **Commissioned by**: `RV-0062-VERDICT` §5 (`J-dv_lead-0099`), the disposition
  that accepted family B's helper duplication *for that round* and made the
  consolidation an owed, standalone debt.
- **Class**: **pure refactor.** This packet adds no row, changes no expected
  value, and asserts nothing about the design. It is the only packet in this
  programme so far whose success criterion is that **the suite's behaviour is
  bit-for-bit what it was before it**.
- **Rows**: **none.** `AP-xgmii_rx_64.md` is not read for rows and is not
  edited by this packet (it is dv_lead's, and its edits ride a different
  commit).
- **Deliverables**, and nothing else:
  1. `test/xgmii_rx_64/bench.ml` + `test/xgmii_rx_64/bench.mli` — four helper
     definitions moved in, with their documentation, per §3 and §4.
  2. `test/xgmii_rx_64/test_m03_b.ml`, `test_m03_d.ml`, `test_m03_e.ml`,
     `test_m03_f.ml`, `test_m03_g.ml`, `test_m03_h.ml`, `test_m03_i.ml` —
     fourteen local definitions deleted, eleven call sites renamed, and the
     stale duplication comments repaired (§5).
  3. This packet's Return log, carrying the evidence §7 names.
  4. Your journal entry.

---

## 1. The three binding conditions — restated verbatim from `RV-0062-VERDICT` §5

These are not guidance. They were fixed at the verdict that commissioned this
round and they are quoted here in the words they were fixed in, because a
condition restated loosely is a condition renegotiated:

> **(i) pure refactor — no assertion, no message string and no argument value
> changes, so every campaign seal keeps its exact text; (ii) it lands alone, on
> its own CI run, with no row in the same commit; (iii) it does not consolidate
> `split_at_first_tlast` into `bench.ml` without also recording FINDING B-1's
> precondition at the definition, because a shared copy of an idiom with an
> unstated precondition is worse than six local copies of it.**

Each condition is operationalised below and each has a pre-committed BOUNCE:

- **(i)** is §6's review bar 1 and BOUNCE **B1**/**B2**/**B5**/**B7**. The bar is
  mechanical: the multiset of string literals in **every** file of
  `test/xgmii_rx_64/` must be **byte-identical** before and after your diff,
  `bench.ml`/`bench.mli` included. §6 gives the command.
- **(ii)** is a landing condition on the orchestrator *and* a staging
  obligation on you: `git status --porcelain` at the tree you hand back must
  contain the nine files of §2.1 and nothing else. BOUNCE **B4**/**B6**.
- **(iii)** is §4.4 and BOUNCE **B3**. It is also the round's justification, and
  §4.5 discharges the same obligation for a *second* helper whose precondition
  has already cost one repair.

**Why this round exists at all, stated once so the Return log does not have to
argue it.** Duplication is not the defect. The defect is a duplicated helper
that carries an **unstated contract**, because each copy is transplanted by a
reader who sees the body and not the precondition. This programme has paid for
that twice: `RV-0057-VERDICT` Finding 1 (an input trace sized by what a frame
*delivered* where the contract wanted what it *received*), and `RV-0062`
FINDING B-1 (a two-group partition idiom transplanted to a run where the first
group is empty by construction, which turned a conforming design red with a
message accusing it of the violation the test was written to detect). Both
helpers are in this packet's scope, and both leave it with their contract
written at their single definition. **That, not the line count, is the payoff.**

---

## 2. Scope — the exact surface

### 2.1 What you may stage, and nothing else

| Path | What may change |
|---|---|
| `test/xgmii_rx_64/bench.ml` | Four new definitions, bodies moved verbatim (§3, §4) |
| `test/xgmii_rx_64/bench.mli` | Four new `val`s with their docstrings (§4) |
| `test/xgmii_rx_64/test_m03_b.ml` | 3 definitions deleted; 1 call site renamed; duplication comments repaired |
| `test/xgmii_rx_64/test_m03_d.ml` | 1 definition deleted; comment repaired |
| `test/xgmii_rx_64/test_m03_e.ml` | 2 definitions deleted; comments repaired |
| `test/xgmii_rx_64/test_m03_f.ml` | 2 definitions deleted; comments repaired |
| `test/xgmii_rx_64/test_m03_g.ml` | 2 definitions deleted; 1 call site renamed; comments repaired |
| `test/xgmii_rx_64/test_m03_h.ml` | 3 definitions deleted; 9 call sites renamed; comments repaired |
| `test/xgmii_rx_64/test_m03_i.ml` | 1 definition deleted; comments repaired |
| `agents/handoffs/WO-0064_…md` | This packet's Return log |
| `agents/journals/workers/…` | Your journal entry |

### 2.2 What you may **not** touch, and why each is named

1. **`test/xgmii_rx_64/dune`.** Its row list is *rows by packet*. This packet
   adds no row, so it gets no line; adding a "no rows" line to a rows-by-packet
   list makes the list harder to read, not easier. The `libraries` stanza does
   not move either — the consolidation lands in an existing module of an
   existing library.
2. **`test/xgmii_rx_64/test_m03_a.ml`, `test_m03_c.ml`,
   `test_m03_structural.ml`.** They hold none of the fourteen definitions and
   none of the eleven call sites. A diff hunk in any of them is BOUNCE **B4**.
3. **`test/xgmii/**`, `test/monitors/**`** (`Dv_xgmii`, `Dv_monitors`). Frozen.
   Nothing in this refactor needs them; if you believe it does, stop and report
   it (§7), do not take it.
4. **`fail` and `fail_cross`** — see §4.6. They are **out of scope by
   derivation, not by oversight**, and consolidating either is BOUNCE **B8**.
5. **`assert_following_frame_intact`** (`test_m03_b.ml:223`) and
   **`assert_clean_frame_structure`** (`test_m03_i.ml:672`). Same *purpose*,
   different bodies (40 lines against 58), both message-producing. Merging them
   is a **redesign** — someone must decide which checks the merged form makes —
   not a refactor, and it would have to be commissioned with that derivation.
   Recorded here so their absence from this packet is legible as a decision.
   BOUNCE **B8**.
6. `libs/**`, `rtl_snapshots/**`, `docs/**`, `test/attack_plans/**`,
   `test/golden/**`, `tools/**`, `tasks/**`, `.github/**`, `scripts/**`.
   PROTOCOL §6 and §10. Your journal `Inputs` lists this packet and existing
   `test/xgmii_rx_64/**` files, and nothing else — **no spec path is needed for
   this round and none should appear**, which is itself the independence
   evidence: a pure refactor that cited REQ ids would be a refactor that
   re-derived something.

---

## 3. The inventory — measured from the tree, and one correction against myself

`RV-0062-VERDICT` §5's table said `split_at_first_tlast` has **6** copies. **It
has 7.** The verdict's table was built from the sites the review had opened;
the tree says `test_m03_b.ml:178`, `test_m03_d.ml:208`, `test_m03_e.ml:149`,
`test_m03_f.ml:693`, `test_m03_g.ml:385`, `test_m03_h.ml:164`,
`test_m03_i.ml:221`. The correction is recorded here rather than in the verdict
because a verdict is a record of a judgement and this packet is the instruction
— **the instruction is the thing that has to be right**. Take the table below,
not the verdict's, and if your own count disagrees with this one, **your count
and the Return log win** and you stop before editing.

| # | Identity | Definitions (file:line) | Bodies | Call sites |
|---|---|---|---|---|
| 1 | `account_dropped_frame` | `test_m03_b.ml:190`, `test_m03_e.ml:139`, `test_m03_f.ml:145` | **character-identical, all 3** | 6 (b ×3, e ×2, f ×1) |
| 2 | forwarded, no `Arrival` record | `test_m03_b.ml:204` (`account_forwarded_frame`), `test_m03_h.ml:210` (`account_spliced_forwarded`) | **character-identical apart from the name** | 8 (b ×1, h ×7) |
| 3 | dropped, no `Arrival` record | `test_m03_g.ml:408` (`account_resync_runt_frame`), `test_m03_h.ml:227` (`account_spliced_dropped`) | **character-identical apart from the name** | 3 (g ×1, h ×2) |
| 4 | `split_at_first_tlast` | b:178, d:208, e:149, f:693, g:385, h:164, i:221 | identical apart from the **parameter name** (`samples` in b/g/h/i, `words` in d/e/f) and the line-wrapping of one `if` | **30** (b 2, d 1, e 2, f 2, g 12, h 7, i 4) |

**14 definitions become 4.** Verify every cell of this table yourself before you
delete anything — a body you assume is identical and is not is exactly the
failure this round is designed to be unable to hide.

**The fact that makes this refactor cheap, and you must not spend it.** Every
family file already carries `open Bench` (`test_m03_a.ml:5` … `test_m03_i.ml:213`).
So for identities **1** and **4**, deleting the local `let` is *sufficient*: the
name re-resolves through the `open` to `Bench`'s, and **not one call site
changes**. Those two identities' diffs in the family files are **pure deletion**
plus comment repair. Only identities 2 and 3 have call-site edits, because they
are being merged under one name (§4.2, §4.3). Do not "helpfully" qualify the
unchanged call sites with `Bench.` — that would put 36 gratuitous edited lines
into a diff whose reviewability is the point.

---

## 4. Where each helper goes, what it is called, and what its definition must say

### 4.1 The home is `bench.ml` / `bench.mli`, not a new file — and here is the reason

**Decision: `bench.ml` / `bench.mli`.**

The deciding fact is that the family's **fourth member is already there**:
`bench.mli` exports `account_clean_frame`, the clean-delivery case of exactly
the same conservation-plus-latency accounting, and `bench.mli`'s own module
docstring is where the accounting contract is already written down. A new
`accounting.ml` would do one of two things and both are worse:

- leave `account_clean_frame` in `bench.ml` and put its three siblings in
  another module — which is *the very configuration that produced the drift*, a
  concept whose cases live in two places, and it would make the split
  permanent rather than accidental; or
- drag `account_clean_frame` out too — which rewrites every clean-frame call
  site in every family file, a diff several times this one's size, in a round
  whose second binding condition is that it lands alone and is readable.

There is a third reason and it is the plainest: **every one of the fourteen
local copies carries a comment that names `Bench` as the target.**
`test_m03_g.ml:382–383` — *"{!Bench} is the only shared surface, so every family
file carries its own copy"*; `test_m03_h.ml:162` and `test_m03_i.ml:218–219` say
the same. The refactor's job is to **make that sentence true**, not to introduce a
second shared surface that makes it false in a new way.

`split_at_first_tlast` goes to the same home on an independent ground: it is a
function over `Bench.sample`, and `bench.ml` already owns the sample-list
utilities that read `out` under standing obligation 6 (`delivered_samples`,
`delivered_octets`, `tlast_sample`, `error_pulses`). It has nowhere else to live
that does not begin by re-exporting `sample`.

### 4.2 The naming axis: `_frame` has an `Arrival` record, `_piece` does not

The five accounting helpers that will sit adjacent in `bench.mli` split on
exactly one axis, and **that axis is the trap that has already cost one
repair**:

| Name | Input trace comes from | Frame's fate |
|---|---|---|
| `account_clean_frame` (existing, **not moved, not touched**) | `Arrival.in_times frame` | delivered cleanly |
| `account_dropped_frame` (identity 1, **name unchanged**) | `Arrival.in_times frame` | delivered nothing; reported by a strobe |
| `account_forwarded_piece` (identity 2, **new name**) | the **caller**, from `~start_ot` and `~received` | delivered content; no `Arrival` record exists |
| `account_dropped_piece` (identity 3, **new name**) | the **caller**, from `~start_ot` and `~received` | delivered nothing; no `Arrival` record exists |

`account_spliced_forwarded` / `account_spliced_dropped` / `account_resync_runt_frame`
name *the family that first needed them* — a splice, a resynchronised runt.
`_piece` names **the property that decides the call's contract**: there is no
`Arrival.frame`, so the caller sizes the input trace by hand, and sizing it by
`~delivered` instead of `~received` is `RV-0057-VERDICT` Finding 1 — a defect
that was harmless only by cancellation and had to be repaired anyway. Names
that encode the family are how one concept ends up with five names; the name
must carry the thing the next writer has to get right.

**The eleven call-site renames**, and they are the *only* identifier edits in
this packet:

- `account_forwarded_frame` → `account_forwarded_piece`: `test_m03_b.ml:475`.
- `account_spliced_forwarded` → `account_forwarded_piece`: `test_m03_h.ml:413`,
  `:420`, `:643`, `:650`, `:842`, `:849`, `:1087`.
- `account_resync_runt_frame` → `account_dropped_piece`: `test_m03_g.ml:1503`.
- `account_spliced_dropped` → `account_dropped_piece`: `test_m03_h.ml:1083`,
  `:1084`.

An identifier is not a message. **No `let%expect_test` name, no runner name
(`run_b4`, `run_h2`, `run_g7`, …), no `~strobe:` value, no `row` string and no
`failwith` text may change anywhere** — those *are* what campaign seals cite.

### 4.3 Bodies move verbatim. Nothing is re-expressed in terms of anything else

`account_dropped_frame` and `account_dropped_piece` compute the same array by
two different routes (`Arrival.in_times frame` against
`Array.init (8 + received) ~f:(fun i -> start_ot + i)`). **Do not unify them.**
Do not add an optional argument, do not reorder a parameter, do not introduce a
variant, do not thread one through the other, do not "clean up" a `let` binding
while you are in there. Four bodies in, four bodies out, character-identical to
the copies they replace modulo the leading `let <name>` and `ocamlformat`'s own
janestreet profile (`.ocamlformat`, version 0.26.2) doing whatever it does with
the surrounding indentation. BOUNCE **B2**, **B7**.

For `split_at_first_tlast`, the seven copies differ in the parameter name and
in one `if`'s line-wrapping. Take the four-copy majority spelling (`samples`,
one-line `if`) and say in the Return log that you did. A parameter name is not
observable.

### 4.4 Condition (iii): `split_at_first_tlast`'s precondition, recorded at the definition

This is the round's justification and the bar is **not** "add a cautionary
comment". The `bench.mli` docstring must state, in this order:

1. **What the function returns**, extensionally: *(the prefix through and
   including the first sample whose `tlast` is 1, and the remainder)*. Not
   "splits at the frame boundary" — that phrasing is the error.
2. **The precondition of the two-group reading**, in terms: *the first group is
   the first frame's words **only if the first frame delivers at least one
   word**.* Where a frame may deliver none (requirements.md §0.7 — an abort at
   or before its first octet), this partition hands the **next** frame's words
   to the first group and the empty list to the second, so a guard written to
   prove the first frame's silence convicts the frame that is present.
3. **The incident**, so the reader meets the cost and not only the rule:
   FINDING **B-1**, `RV-0062-VERDICT` §2 — two rows built on the two-group
   idiom went red against a **conforming** design at `88da20e` (CI `build` run
   **30937558341**), each with a message accusing the design of violating §0.7.
4. **What a caller must therefore do**: either establish that both groups are
   non-empty before reading them as two frames — which is what every landed
   two-group call site does with its own `List.is_empty` guard — or not use the
   two-group form at all, which is what `run_b3`/`run_b2` do after repair R-1.

Point 4's second half matters and is easy to miss: **do not touch a single one
of the thirty call sites' guards.** Their `List.is_empty` checks and their
messages stay exactly where and as they are. The docstring documents them; it
does not absorb them. Folding a guard into the shared function would move a
message string and is BOUNCE **B1**.

### 4.5 The same obligation, applied unasked, to the `_piece` pair

Condition (iii) was written for `split_at_first_tlast`. The `_piece` pair has
the identical disease and a **larger** paid cost, so its definition carries the
same treatment: the `bench.mli` docstring for `account_forwarded_piece` and
`account_dropped_piece` must state that `~received` is **what the frame received
while it was open** (requirements.md §0.6's own window), **not** what it
delivered — for a cleanly-closed piece the two differ by the four FCS octets
REQ-103 strips — and must cite `RV-0057-VERDICT` Finding 1 / `WO-0059` §7.3 as
the incident. The text for this already exists, in full, at
`test_m03_h.ml:185–209`; **carry it, do not re-author it**.

More generally: the four moved definitions must arrive carrying the **union** of
the documentation their copies held, not the shortest copy's version. Named
content that must survive, with its current home:

- the *"a frame that delivered ZERO octets is accounted for through its STROBE,
  never through an emitted `frame_out`"* rule and the `Latency.frame_dropped`
  "no `tlast` word to mark" note — `test_m03_e.ml:134–138`,
  `test_m03_f.ml:137–144`;
- the hand-built-`in_times` contract and its verification against
  `test/monitors/octet_time.ml` — `test_m03_g.ml:394–407`;
- the `~received`-versus-`~delivered` paragraph — `test_m03_h.ml:185–209`;
- obligation 6's licence to read `.tlast` on an already-`tvalid`-filtered list —
  `test_m03_d.ml:203–207` (the only copy that states it, and the shared
  definition must not lose it).

The Return log names, per moved definition, which sentence came from which copy.

### 4.6 `fail` and `fail_cross`: measured, and excluded anyway

I measured them rather than guessing, and the measurement does **not** support
the usual objection: `let fail row msg = failwith (String.concat [ row; ": "; msg ])`
is **character-identical in all nine files**, and `fail_cross` is
**character-identical in all five**. Consolidating them would change no emitted
text. They are excluded regardless, on two grounds:

1. **The debt is contract-bearing helpers, not duplication as such.** Nobody has
   ever been misled by a copy of a one-line `failwith` wrapper: it has no
   precondition, no sizing rule, no partition semantics, nothing a reader could
   transplant wrongly. Fourteen copies of it cost nothing that this round is
   commissioned to recover.
2. **Excluding them is what makes condition (i) checkable in one command.**
   Because no message-producing function moves, **the diff of this round
   contains no added or removed string literal anywhere in the directory** — the
   §6 bar. If `fail` moved, that bar could not be stated and the review would
   become a fourteen-way textual comparison whose failure mode is a silently
   altered seal. **The scope boundary is chosen so that seal-safety is decidable
   by a script rather than by care.**

If a later round wants them, it comes with the byte-identity proof as its own
deliverable and it does not ride this one.

---

## 5. The comments that become false, and why repairing them is a deliverable

Fourteen definitions carry comments asserting the convention this packet ends —
*"duplicated below from…"*, *"duplicated here per this packet's own file-local
convention"*, *"`{!Bench}` is the only shared surface, so every family file
carries its own copy"*. After the consolidation those sentences are **wrong**,
and a wrong comment asserting a convention is precisely the left-standing-summary
defect this directory has already been bitten by twice (`RV-0039-VERDICT` F-2;
`RV-0040-R5`, which is why `test/xgmii_rx_64/dune`'s own header carries a
warning about itself). Repairing them is **not** optional tidying.

Sites, from the tree — every one must be either repaired or deleted, and the
Return log states which and why:

| File | Comment blocks above a deleted definition | Passing mentions |
|---|---|---|
| `test_m03_b.ml` | `176–177`, `187–189`, `197–203` | `151`, `153`, `154` |
| `test_m03_d.ml` | `203–207` | — |
| `test_m03_e.ml` | `134–138`, `146–148` | `519` |
| `test_m03_f.ml` | `137–144`, `675–691` | `104` |
| `test_m03_g.ml` | `381–384`, `394–407` | `254`, `255`, `307`, `309`, `1244` |
| `test_m03_h.ml` | `161–163`, `185–209`, `222–226` | `83`, `138`, `191` |
| `test_m03_i.ml` | `217–220` | `188`, `193` |

**The rule for repairing one**: a comment that documents a *fact* (what the
helper does, why `~received` is the honest size) either moves to the shared
definition (§4.5) or stays and keeps pointing at it. A comment that documents
the *convention* (why this file has its own copy) is deleted, because the
convention is gone. A comment that cross-references a sibling file's line number
(`test_m03_e.ml:139`, `test_m03_f.ml:145`) or a retired helper name is repaired
to name `Bench` and the surviving name, because those references are about to
be wrong.

**Two comments that stay exactly as they are**, and I name them because they
look like candidates and are not: `test_m03_b.ml:612` and `:814`, the reviewed
repair R-1's own comments (*"Deliberately NOT the two-group
[`split_at_first_tlast`] idiom…"*, *"the [`split_at_first_tlast`] idiom presumes
both frames deliver…"*). They document a **call-site decision**, they remain
true after the consolidation, and they are the local record of FINDING B-1 at
the two sites it convicted. Editing either is BOUNCE **B10** in the other
direction.

**Do not extend this to comments that merely mention a helper in passing**
beyond changing a name that no longer exists. Every comment edit is a line in a
diff that must be read; make each one earn its place.

---

## 6. The review bar I will apply — stated in advance, in commands

Every item below is something I will run or read at review. They are listed so
that nothing in my verdict is a surprise, and so that you can pass the review
before you hand the tree back.

1. **No message moved — the primary bar.** For **every** file in
   `test/xgmii_rx_64/`, the multiset of string literals must be byte-identical
   at HEAD and at your tree:

   ```sh
   for f in test/xgmii_rx_64/*.ml test/xgmii_rx_64/*.mli; do
     b=$(mktemp); a=$(mktemp)
     git show "HEAD:$f" | grep -o '"\([^"\\]\|\\.\)*"' | sort > "$b"
     grep -o '"\([^"\\]\|\\.\)*"' "$f" | sort > "$a"
     if ! diff -q "$b" "$a" >/dev/null; then echo "STRING LITERALS MOVED: $f"; diff "$b" "$a"; fi
   done
   ```

   This must print **nothing**. It holds because the four moved bodies contain
   no string literal, no call site's arguments change, and `fail`/`fail_cross`
   do not move (§4.6). Quote the command and its empty output in the Return log.
2. **Bodies verbatim.** For each of the four moved definitions, the Return log
   carries the deleted body and the added body **side by side**, so I can read
   the identity rather than take it.
3. **Definitions live in exactly one place.**

   ```sh
   git grep -n 'let \(rec \)\?\(split_at_first_tlast\|account_dropped_frame\|account_dropped_piece\|account_forwarded_piece\)' -- test/xgmii_rx_64/
   ```

   must return **only** `bench.ml` lines. And

   ```sh
   git grep -n 'account_spliced_forwarded\|account_spliced_dropped\|account_resync_runt_frame\|account_forwarded_frame' -- test/xgmii_rx_64/
   ```

   must return **nothing at all** — the retired names survive in no comment
   either, because a comment naming a function that no longer exists is §5's
   defect in miniature.
4. **Arithmetic of the diff.** 14 definitions deleted, 4 added; 11 call sites
   renamed; 30 `split_at_first_tlast` call sites and 6 `account_dropped_frame`
   call sites **textually unchanged**. Any number that differs is either your
   correction of §3's table (welcome, in the Return log, before you edit) or a
   defect.
5. **No behavioural line moved.** `git diff` shows no added or removed line
   containing an assertion, a guard, a comparison, a constant, a
   `List.is_empty`, an `[%expect`, a `let%expect_test`, or a `failwith` —
   outside the four moved bodies, which contain none of them. Comment lines may
   contain any of these words; code lines may not.
6. **Parse.** `ocamlc -stop-after parsing` exit 0 on all nine edited files. Full
   `dune build`/`dune runtest` are **not available in this container**
   (ADR-0005) and you must not claim them.
7. **Inventory unchanged.** `bash tools/dv_checks.sh` reports
   `test/xgmii_rx_64/` at **39** units — the count at the WO-0062 landing. A
   refactor that changes the unit count has changed the suite.
8. **`bash tools/check_records_vs_appendix.sh`** unchanged (23/23 PASS).
9. **Independence.** Your journal `Inputs` names this packet and
   `test/xgmii_rx_64/**` files. **No `libs/**`, no `rtl_snapshots/**`, no
   `docs/**` — and, this round, no spec path either** (§2.2 item 6).
10. **The landing.** CI `build` green at the commit carrying this work, with
    **every `%expect` block in the directory unchanged** and
    `git diff --exit-code` clean. That is the actual proof of condition (i): a
    behaviour-preserving refactor is one the promotion block cannot tell
    happened. Baseline for comparison is the green `build` at the commit
    carrying `RV-0062` repair R-1.

---

## 7. Pre-committed BOUNCE conditions

Committed in advance so the verdict is not negotiated after the fact. Any one
of these bounces the packet as a whole; none of them is repairable by me under
`RV-0062`'s repair bar, because each is either a judgement that is yours to
re-take or a claim I would be grading myself on.

| | Condition |
|---|---|
| **B1** | The §6 bar 1 command prints anything. A string literal added, removed or altered anywhere in the directory. |
| **B2** | A moved body is not character-identical to the copy it replaces — including a "while I was in there" simplification, rename of a local binding, or reformatting beyond what `ocamlformat` does unbidden. |
| **B3** | `split_at_first_tlast` shared without §4.4's four-part precondition at its definition, or with it reduced to a general caution ("be careful with empty lists") rather than the stated precondition, the stated consequence and the named incident. |
| **B4** | `git status --porcelain` shows a file outside §2.1 — `dune`, `test_m03_a.ml`, `test_m03_c.ml`, `test_m03_structural.ml`, anything under `test/xgmii/`, `test/monitors/`, or outside `test/`. |
| **B5** | An assertion, guard, comparison, constant, argument value, call-site argument, or assertion **order** changed anywhere. |
| **B6** | A row, a stimulus, an expect block, or any other packet's work staged in the same tree (condition (ii)). |
| **B7** | A signature merged, a parameter reordered, an optional argument added, or one helper re-expressed in terms of another (§4.3). |
| **B8** | `fail`, `fail_cross`, `assert_following_frame_intact` or `assert_clean_frame_structure` consolidated, moved or edited (§2.2 items 4, 5). |
| **B9** | A Return log without the four side-by-side body comparisons (§6 bar 2), the §6 bar 1 and bar 3 command outputs, and the §4.5 provenance list. |
| **B10** | A stale duplication comment left standing (§5), or a comment naming a retired helper name. |

**Not a bounce, and say so if it happens**: your inventory disagreeing with §3's
table. Report it and stop; that is bar 11 of `WO-0062` §2 applied to a refactor
— **report, never repair, a scope you cannot satisfy as written.** The same
holds if a body you were told is identical is not.

---

## 8. Pass criteria

1. Fourteen local definitions gone; four in `bench.ml`, declared in `bench.mli`
   with docstrings carrying the union of what the copies documented.
2. The §6 bar 1 command prints nothing.
3. `split_at_first_tlast`'s precondition, its consequence and FINDING B-1 are
   at the definition (§4.4); `~received`-versus-`~delivered` is at the `_piece`
   pair's definitions (§4.5).
4. Eleven call sites renamed; the other thirty-six textually unchanged.
5. Every stale duplication comment repaired or deleted, each choice stated.
6. `ocamlc -stop-after parsing` exit 0 on all nine files; unit count 39.
7. Nothing outside §2.1 staged.
8. The Return log carries §6 bars 1–3's evidence verbatim.

## 9. What this packet does not close

- **No row is added, no row is qualified, no coverage moves.** 41 of the plan's
  62 ASSERT rows are discharged before this packet and 41 after it.
- **`SO-xgmii_rx_64.md` does not issue and is not offered.** Families J, K, M, N
  and L1–L5 stay unwritten; the verilog-ethernet anchor stays undischarged.
- **Nothing here qualifies the bench against mutation.** A refactor cannot kill
  a defect; `WO-0058` §8's weighting governs, unchanged.
- **`WO-0058` bound 7** — the in-word REQ-110 abort with a frame already open on
  entry — is untouched and still has no candidate row.
- **The `assert_following_frame_intact` / `assert_clean_frame_structure` merge**
  (§2.2 item 5) is left open, deliberately, with its reason recorded.

## Return log (tb_writer, WO-0064/2026-08-04)

**§3 table verification.** Re-measured from the tree before editing: all
fourteen definition sites and all thirty `split_at_first_tlast` call sites
match this packet's own §3 table exactly (the corrected 7-copy count for
`split_at_first_tlast` held). No further correction found; nothing stopped
on this ground.

**§6 bar 1 (no string literal moved) — the exact command, run after every
edit:**

```
for f in test/xgmii_rx_64/*.ml test/xgmii_rx_64/*.mli; do
  b=$(mktemp); a=$(mktemp)
  git show "HEAD:$f" | grep -o '"\([^"\\]\|\\.\)*"' | sort > "$b"
  grep -o '"\([^"\\]\|\\.\)*"' "$f" | sort > "$a"
  if ! diff -q "$b" "$a" >/dev/null; then echo "STRING LITERALS MOVED: $f"; diff "$b" "$a"; fi
done
```

Output: **empty** (pass) — checked over all nine edited files (`bench.ml`,
`bench.mli`, and the seven family files). Note for the reviewer: this check
is a blind regex over raw file text, so it also catches quoted phrases
sitting inside *comments*, not only genuine OCaml string literals in code —
several of the repaired comments (`"emitted"` in `test_m03_b/e/f.ml`,
`"no tlast word to mark"` in `test_m03_g.ml`, `"frame the stimulus opens"`
in `test_m03_b.ml`) were therefore kept verbatim in place rather than
deleted with their definitions, specifically so this bar stays clean file
by file. New docstring prose added to `bench.mli` avoids introducing any
new double-quoted span at all, for the same reason.

**§6 bar 2 (bodies verbatim) — the four moved definitions, side by side.**
Deleted text is the family-file original; added text is `bench.ml`'s new
copy. Diffed programmatically against every source copy (not just eyeballed)
— all four came back `IDENTICAL`.

1. `account_dropped_frame` (source: `test_m03_b.ml:190-195`, `test_m03_e.ml`,
   `test_m03_f.ml` — all three character-identical per §3):
   ```
   - let account_dropped_frame bench (frame : Dv_xgmii.Arrival.frame) ~strobe =
   + let account_dropped_frame bench (frame : Dv_xgmii.Arrival.frame) ~strobe =
       Dv_monitors.Conservation_monitor.frame_in (conservation bench);
       Dv_monitors.Conservation_monitor.discarded (conservation bench) ~strobes:[ strobe ];
       Dv_monitors.Octet_time.Latency.frame_in (latency bench) (Dv_xgmii.Arrival.in_times frame);
       Dv_monitors.Octet_time.Latency.frame_dropped (latency bench)
   ```
   (Only the retained `let account_dropped_frame` line differs by nothing —
   name unchanged, this identity keeps its name per §4.2.)

2. `account_forwarded_piece` (source: `test_m03_b.ml:204-214`'s
   `account_forwarded_frame`, `test_m03_h.ml`'s `account_spliced_forwarded` —
   both character-identical apart from the name per §3):
   ```
   - let account_forwarded_frame bench ~start_ot ~received ~delivered ~aborted samples =
   + let account_forwarded_piece bench ~start_ot ~received ~delivered ~aborted samples =
       Dv_monitors.Conservation_monitor.frame_in (conservation bench);
       Dv_monitors.Conservation_monitor.frame_out (conservation bench) ~aborted;
       let in_times = Array.init (8 + received) ~f:(fun i -> start_ot + i) in
       Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
       let delivered_pairs = List.map samples ~f:(fun s -> s.cycle, s.out) in
       Dv_monitors.Octet_time.Latency.frame_out
         (latency bench)
         ~expected_octets:delivered
         (Dv_monitors.Octet_time.of_words delivered_pairs)
   ```

3. `account_dropped_piece` (source: `test_m03_g.ml:408-414`'s
   `account_resync_runt_frame`, `test_m03_h.ml`'s `account_spliced_dropped` —
   both character-identical apart from the name per §3):
   ```
   - let account_resync_runt_frame bench ~start_ot ~received ~strobe =
   + let account_dropped_piece bench ~start_ot ~received ~strobe =
       Dv_monitors.Conservation_monitor.frame_in (conservation bench);
       Dv_monitors.Conservation_monitor.discarded (conservation bench) ~strobes:[ strobe ];
       let in_times = Array.init (8 + received) ~f:(fun i -> start_ot + i) in
       Dv_monitors.Octet_time.Latency.frame_in (latency bench) in_times;
       Dv_monitors.Octet_time.Latency.frame_dropped (latency bench)
   ```

4. `split_at_first_tlast` (majority spelling per §4.3: `samples` param,
   one-line `if` — confirmed present verbatim in `test_m03_b.ml`,
   `test_m03_g.ml`, `test_m03_h.ml`, `test_m03_i.ml`; the minority
   (`words` param, wrapped `if`) survives only as `test_m03_d/e/f.ml`'s own
   call-site variable names, which are untouched):
   ```
   - let split_at_first_tlast samples =
   + let split_at_first_tlast samples =
       let rec go acc = function
         | [] -> List.rev acc, []
         | (s : sample) :: rest ->
           if s.out.Dv_monitors.Stream_word.tlast then List.rev (s :: acc), rest else go (s :: acc) rest
       in
       go [] samples
   ```

**§6 bar 3 (single home) — both commands, run after every edit:**

```
$ git grep -n 'let \(rec \)\?\(split_at_first_tlast\|account_dropped_frame\|account_dropped_piece\|account_forwarded_piece\)' -- test/xgmii_rx_64/
test/xgmii_rx_64/bench.ml:259:let account_dropped_frame bench (frame : Dv_xgmii.Arrival.frame) ~strobe =
test/xgmii_rx_64/bench.ml:266:let account_forwarded_piece bench ~start_ot ~received ~delivered ~aborted samples =
test/xgmii_rx_64/bench.ml:278:let account_dropped_piece bench ~start_ot ~received ~strobe =
test/xgmii_rx_64/bench.ml:286:let split_at_first_tlast samples =
```
(only `bench.ml`, as required.)

```
$ git grep -n 'account_spliced_forwarded\|account_spliced_dropped\|account_resync_runt_frame\|account_forwarded_frame' -- test/xgmii_rx_64/
```
(empty — the four retired names survive in no comment either.)

**§4.5 provenance — which sentence came from which copy:**

- `account_dropped_frame`'s docstring: the "accounted through its STROBE,
  never through an emitted `frame_out`" rule and the "pops the pending input
  frame without a comparison" / no-`tlast`-to-mark phrasing are
  `test_m03_e.ml:134-138` / `test_m03_f.ml:137-144`'s own wording
  (`test_m03_b.ml:151-154`'s cross-reference to those two files is the
  passing mention that confirmed the source).
- `account_forwarded_piece` / `account_dropped_piece`'s shared
  `~received`-vs-`~delivered` precondition paragraph: carried from
  `test_m03_h.ml:185-209` per §4.5's instruction, generalised only where the
  original said "this file's rows" / "this packet" / named the now-retired
  `account_resync_runt_frame` — every other clause (the REQ-103 FCS-octet
  arithmetic, the `frame_out`/`Array.init` cancellation argument, the
  `RV-0057-VERDICT` Finding 1 / WO-0059 §7.3 citation) is that same
  paragraph's own wording. The literal quotation of `octet_time.mli` ("output
  octet j is still input octet j + strip_octets") is stated without quote
  marks in the moved copy — see the bar-1 note above for why.
- `account_forwarded_piece`'s mid-array/no-`Arrival.frame` framing and
  `account_dropped_piece`'s STROBE-not-`frame_out` framing: `test_m03_g.ml
  :394-407`'s own wording (the only copy that states the M03-G7 mid-array
  case) and `test_m03_h.ml:222-226`'s own wording respectively.
- `split_at_first_tlast`'s four-part precondition (§4.4): points 1-2 and 4
  are this packet's own text (§4.4 itself, quoted near-verbatim); point 3
  (the incident) cites FINDING B-1 / `RV-0062-VERDICT` §2, `88da20e`, CI
  `build` run 30937558341, exactly as §4.4 states it. `test_m03_d.ml:203-207`
  — "the only copy that states" obligation 6's `.tlast`-read licence — is
  folded into the docstring's opening sentence ("should already be
  `tvalid`-filtered … obligation 6").

**Comment-site disposition (§5), file by file — every site named in the
packet's own table, repaired or deleted, with the ground for each:**

- `test_m03_b.ml` 176-177 (pure convention, no quotes): deleted with the
  definition below it. 187-189 (`"emitted"` quote present): repaired in
  place to a one-line pointer at `{!Bench.account_dropped_frame}`, quote
  kept verbatim. 197-203 (no quotes; its M03-B4-specific fact is folded into
  the repaired 150-161 paragraph instead): deleted. 150-161 (the "Local
  helpers, duplicated…" paragraph, holding the `"frame the stimulus opens"`
  quote at old line 159): repaired — "duplicated"/"not moved" framing
  removed, retired name `account_forwarded_frame` replaced by
  `{!Bench.account_forwarded_piece}`, the quote kept verbatim in place.
  612/814 (the R-1 "Deliberately NOT the two-group…" comments, WO-0064's own
  explicit "stay exactly as they are"): confirmed byte-identical
  before/after by diff, not merely left alone by omission.
- `test_m03_d.ml` 203-207 (no quotes, pure fact, no false claim to repair):
  deleted with the definition, replaced with a one-line pointer.
- `test_m03_e.ml` 134-138 (`"emitted"` and a cross-line "no tlast word to
  mark" fragment; **no** "duplicated" framing present at all — already
  100% accurate as a rule statement): left completely unchanged rather than
  edited, since editing it would only add risk for no correctness gain.
  146-148 (pure convention, no quotes): deleted with the definition. 519
  (passing mention, no quotes, name not retired): repaired to
  `{!Bench.account_dropped_frame}` for consistency with the adjacent
  `{!Bench.account_clean_frame}` reference on the next line.
- `test_m03_f.ml` 104-106 (module-docstring passing mention, "no `{!Bench}`
  addition" now false): repaired. 137-144 (`"emitted"` quote present, mixed
  convention+fact): repaired in place, convention framing removed, quote
  kept. 675-691 (the M03-F4 *row* description, not a duplication comment —
  no "duplicated" sentence exists at this site in this file; holds two
  quoted spans, `"< 64"` / `"<= 64"`): left completely unchanged; only the
  blank-line-separated `split_at_first_tlast` definition below it was
  deleted, which if anything improves the comment's own positioning (it now
  sits directly above `run_f4`, the row it describes).
- `test_m03_g.ml` 254-255, 307 (retired-name passing mentions): repaired to
  `{!Bench.account_dropped_piece}` / `{!Bench.account_dropped_frame}`. 309
  (mentions `account_dropped_frame`, not retired): left unchanged. 381-384
  (pure convention, no quotes): deleted with the definition. 394-407
  (`"no tlast word to mark"` quote present): repaired in place — convention
  framing and the retired name removed, quote kept, reworked to describe
  `{!Bench.account_dropped_piece}`. 1244 (retired-name passing mention):
  repaired.
- `test_m03_h.ml` 83 (retired name in the module docstring's X-5 section):
  repaired. 138 (Independence-section historical record of what WO-0057
  read; names no retired identifier, remains accurate as a historical
  statement): left unchanged. 161-163 (pure convention, no quotes): deleted
  with the definition. 185-209 (no quotes at the per-line level — the one
  embedded quotation from `octet_time.mli` is itself split across two
  physical lines in the source and so never forms a grep-matched span;
  content carried to `bench.mli` per §4.5): deleted, replaced with a
  two-sentence pointer. 222-226 (no quotes, "duplicated … file-local
  convention" framing, retired name): deleted with the definition, folded
  into the same pointer.
- `test_m03_i.ml` 188 (retired-name passing mention): repaired. 193 (names
  `fail`/`split_at_first_tlast`, neither retired; an Independence-section
  historical record of what WO-0059 read from `test_m03_h.ml`, still
  accurate): left unchanged. 217-220 (pure convention, no quotes): deleted
  with the definition.

**Arithmetic (§6 bar 4).** 14 definitions deleted (3 `account_dropped_frame`
+ 2 `account_forwarded_frame`/`account_spliced_forwarded` + 2
`account_resync_runt_frame`/`account_spliced_dropped` + 7
`split_at_first_tlast`), 4 added to `bench.ml`. Eleven call sites renamed —
`test_m03_b.ml:1` (`account_forwarded_frame`→`account_forwarded_piece`),
`test_m03_g.ml:1` (`account_resync_runt_frame`→`account_dropped_piece`),
`test_m03_h.ml:9` (7× `account_spliced_forwarded`→`account_forwarded_piece`,
2× `account_spliced_dropped`→`account_dropped_piece`) — matching §4.2's list
exactly. The other 36 call sites (30 `split_at_first_tlast` + 6
`account_dropped_frame`) are textually unchanged; confirmed by diffing the
full `git diff` of every family file and finding no changed line outside a
comment, a deleted definition, or one of the eleven renamed call-site
identifiers.

**§6 bar 6 (`git status --porcelain`) — condition (ii):**
```
 M test/xgmii_rx_64/bench.ml
 M test/xgmii_rx_64/bench.mli
 M test/xgmii_rx_64/test_m03_b.ml
 M test/xgmii_rx_64/test_m03_d.ml
 M test/xgmii_rx_64/test_m03_e.ml
 M test/xgmii_rx_64/test_m03_f.ml
 M test/xgmii_rx_64/test_m03_g.ml
 M test/xgmii_rx_64/test_m03_h.ml
 M test/xgmii_rx_64/test_m03_i.ml
```
Exactly the nine files §2.1 names (plus this Return log and the journal
entry, staged separately by the orchestrator). `dune`, `test_m03_a.ml`,
`test_m03_c.ml`, `test_m03_structural.ml`, `test/xgmii/**`, `test/monitors/
**` are all absent, as required.

**§6 bar 6 (parse).** `ocamlc -stop-after parsing` on all nine files: exit 0,
no output, for every one — `bench.mli`, `bench.ml`, `test_m03_b.ml`,
`test_m03_d.ml`, `test_m03_e.ml`, `test_m03_f.ml`, `test_m03_g.ml`,
`test_m03_h.ml`, `test_m03_i.ml`.

**§6 bar 7 (`bash tools/dv_checks.sh`).** Bench inventory line: `39
test/xgmii_rx_64/ (the M03 bench)` — unchanged from the WO-0062 landing.
The one OBLIGATION OPEN line (`check_rfc1071_anchor.sh`, blocked network
egress) is pre-existing per the script's own history (`J-dv_lead-0017/18`,
the WO-0033 acceptance block) and unrelated to this packet's scope; every
check this refactor could affect passed.

**§6 bar 8 (`bash tools/check_records_vs_appendix.sh`).** `23 check(s) run,
0 failure(s)` — unchanged.

**Independence.** This spawn's Inputs (journal entry below) list only this
packet and the nine `test/xgmii_rx_64/**` files edited or read for
verification — no `libs/**`, no `rtl_snapshots/**`, no `docs/**`, and no
spec path, per §2.2 item 6.

**BOUNCE conditions:** none hit. No string literal moved (B1/B2/B5/B7); no
file outside §2.1 touched (B4/B6); `split_at_first_tlast` carries its
four-part precondition at the definition (B3); `fail`/`fail_cross`/
`assert_following_frame_intact`/`assert_clean_frame_structure` untouched
(B8); this Return log carries the four side-by-side comparisons, the bar 1
and bar 3 outputs, and the §4.5 provenance list (B9); the two R-1 comments
at (old) `test_m03_b.ml:612`/`:814` are confirmed byte-identical, not edited
(B10); every other stale comment named in §5's table is repaired or deleted
above.

**For dv_lead's review, first:** the `bench.mli` docstring for
`split_at_first_tlast` (condition iii, the round's actual justification) and
for the `account_forwarded_piece`/`account_dropped_piece` pair (§4.5's
second, larger-cost obligation) — those two docstrings are the payoff this
round exists to bank, everything else is mechanical deletion.

---

## RV-0064-VERDICT (dv_lead, 2026-08-04) — **ACCEPT**

**State**: `RETURNED → ACCEPTED`. Landed alone at `c501425` per condition (ii).
Build run **30943522690** = SUCCESS and journal-check run **30943522449** =
SUCCESS, both confirmed by me against `head_sha
c50142500e7a8233902cf061a7f8bb6737492a9d` through the Actions API, not taken
from the Return log.

I re-ran every one of §6's ten bars myself. Where the packet's command compares
`HEAD` against a working tree, that form is vacuous now that the work has
landed, so I ran each against **`42a81e3` (the parent) versus `c501425`** —
the same comparison the bar was written to make.

### The ten bars

| # | Bar | Verdict | What I measured, not what I was told |
|---|---|---|---|
| 1 | String-literal multiset identical | **PASS** | Empty output over **all twelve** `.ml`/`.mli` files in the directory (the Return log checked the nine edited; the bar says *every* file). |
| 2 | Bodies verbatim | **PASS** | Extracted each definition from parent and from `bench.ml` and compared byte-for-byte modulo the leading `let <name>`: `account_dropped_frame` IDENTICAL against all 3 copies; `account_forwarded_piece` against both; `account_dropped_piece` against both; `split_at_first_tlast` against all 4 majority copies. The 3 minority copies (`d`/`e`/`f`) differ **only** in the parameter name (`words`) and one `if`'s line-wrapping — the two dimensions §4.3 pre-authorised by name. Not B2. |
| 3 | Single home | **PASS** | `git grep` returns only the four `bench.ml` lines; the four retired names return **nothing** under `test/xgmii_rx_64/` (their survival in historical packets and journals is history, correctly outside the bar's `--` scope). |
| 4 | Arithmetic | **PASS** | 14 definitions in parent at **exactly** §3's fourteen line numbers; 4 at `c501425`. Call sites recounted on **comment-stripped** source so prose mentions could not inflate them: `split_at_first_tlast` 30 (b2 d1 e2 f2 g12 h7 i4), `account_dropped_frame` 6 (b3 e2 f1), forwarded 8 (b1 h7), dropped-piece 3 (g1 h2) — every cell matches §3. Renames = **11**, matching §4.2's list exactly. |
| 5 | No behavioural line moved | **PASS** | Strongest check I ran. I stripped comments (nested, string-aware) from all seven family files at both revisions and diffed the code alone: **11 added code lines across the whole family, all eleven of them the renamed call sites**, each character-identical to its predecessor including its `~strobe:` string arguments. Zero added or removed line anywhere contains an assertion, guard, comparison, `List.is_empty`, `[%expect`, `let%expect_test` or `failwith`. |
| 6 | Parse | **PASS** | `ocamlc -stop-after parsing` exit 0 on all nine (`ocamlc` *is* present; full `dune build`/`runtest` remain unavailable per ADR-0005, and the Return log correctly claims neither). |
| 7 | Inventory 39 | **PASS** | `bash tools/dv_checks.sh` → `39 test/xgmii_rx_64/`. The one OBLIGATION OPEN line is the pre-existing blocked-egress RFC-1071 anchor, untouched by and unrelated to this round. |
| 8 | Records vs appendix | **PASS** | `bash tools/check_records_vs_appendix.sh` → `23 check(s) run, 0 failure(s)`. |
| 9 | Independence | **PASS** | `J-tb_writer-0022` Inputs: this packet, the tb_writer charter, PROTOCOL, and the nine `test/xgmii_rx_64/**` files. No `libs/**`, no `rtl_snapshots/**`, no `docs/**`, **and no spec path** — §2.2 item 6 satisfied in the affirmative sense the packet wanted. |
| 10 | The landing | **PASS** | Both CI runs SUCCESS at `c501425` (verified via API). And the part of bar 10 that carries the actual meaning: I extracted and compared **all 40 `[%expect …]` blocks** in the directory across the two revisions — **every one byte-identical**. The promotion block could not tell the refactor happened. That is condition (i) discharged. |

**Pre-committed BOUNCE conditions B1–B10: none hit.** B4/B6 confirmed from the
commit's own file list — exactly the nine files plus this packet and the worker
journal, nothing else. B8 confirmed by count and by absence from the diff:
`fail` 9→9, `fail_cross` 5→5, `assert_following_frame_intact` 1→1,
`assert_clean_frame_structure` 1→1, none appearing in any hunk.

### B3 — the condition (iii) docstring, read clause by clause

This is the round's justification and it is the one thing I would have bounced
on. §4.4 demanded four parts in order; `bench.mli` carries all four, at full
strength, none reduced to a general caution:

1. **Extensional return** — present, and *stronger* than asked: "returns the
   prefix … through and including the first sample whose `tlast` is 1, paired
   with the remainder — **extensionally, and only extensionally**". It also
   folds in obligation 6's `tvalid`-filtered licence, which §4.5 flagged as
   surviving in `test_m03_d.ml` alone.
2. **The precondition** — present with all three of its clauses: correct only
   if the first frame delivers at least one word; where none is delivered the
   first group returned is the *next* frame's and the second is empty; and
   therefore "a guard written to prove the silent first frame's absence …
   convicts the frame that is actually present."
3. **The incident** — present with all four citation elements: FINDING B-1,
   `RV-0062-VERDICT` §2, `88da20e`, CI run 30937558341, plus the load-bearing
   sentence "the design was innocent".
4. **What a caller must do** — both halves present, including the half that is
   easy to drop: the `List.is_empty` guard route *and* the do-not-use-the-
   two-group-form route the R-1 repair took.

§4.5's parallel obligation on the `_piece` pair is likewise discharged. I
diffed the moved paragraph against its source at `test_m03_h.ml:185-209`: every
clause survives — §0.6's window, the aborted-frame coincidence, REQ-103's
no-removal clause, the four-FCS-octet arithmetic, the `frame_out`/`Array.init`
cancellation argument, and both citations. The generalisations are exactly the
ones §4.5 licensed (file-local claims like "every second/third piece in this
file" removed; past-tense repair narration turned into a standing contract).

**One forced adaptation, and the worker was right to make it.** §4.5 said
*carry the text*; condition (i)'s bar 1 forbids adding any new double-quoted
span. The source paragraphs quote phrases — `"emitted"`, the `octet_time.mli`
sentence — and carrying those quote marks into `bench.mli` would have **fired
B1**. The worker carried the content without the quote marks and kept the
quoted phrases verbatim in the comments that already held them. That is the
correct resolution of a genuine conflict between two of my own requirements,
and it is why bar 1 stayed clean file by file.

### Comment-site dispositions taken on the worker's own judgement — adjudicated

All **upheld**. §5's own rule ("do not extend this to comments that merely
mention a helper in passing beyond changing a name that no longer exists") is
what governs, and it was applied correctly in each case:

- `test_m03_e.ml:134-138`, `test_m03_f.ml:675-691` — left unchanged. **Upheld.**
  Neither carries a duplication claim; `f`'s block is a *row* description whose
  "two-frame SPLIT (structural: both non-empty)" is a call-site decision that
  stays true, and it now sits directly above `run_f4`, which improves it.
- `test_m03_g.ml:309`, `test_m03_h.ml:138`, `test_m03_i.ml:193` — left
  unchanged. **Upheld.** All three are Independence-section historical records
  of what a past round *read*; none names a retired identifier; each remains
  accurate as a statement about its own moment.
- `test_m03_g.ml:307`, `test_m03_h.ml:83`, `test_m03_i.ml:188` — repaired
  although also inside historical prose. **Upheld**, and necessary: each named
  a **retired** identifier, which B10 reaches regardless of the sentence's
  tense.
- `test_m03_h.ml:191` is absent from the disposition table; it is subsumed by
  the deletion of the `185-209` block that contains it. No defect.
- Repairing quote-bearing comments **in place** rather than deleting them —
  **upheld**, and it is the single judgement that kept bar 1 clean per file.
- `test_m03_b.ml:612`/`:814` — confirmed **byte-identical** by my own extract
  and diff. B10 satisfied in the direction it was written.

I verified the whole class mechanically as well: no `duplicat*`, "only shared
surface", "own local helper" or "carries its own copy" claim about any of the
fourteen helpers survives anywhere in the directory.

### Three reviewed repairs, made by me under this round's repair bar

The first is a defect **in my own packet**, not in the execution.

1. **`test/xgmii_rx_64/test_m03_b.ml`** — §5 named the two R-1 comments as
   comments that "remain true after the consolidation" and made editing either
   BOUNCE **B10**. One clause of the first is **not** true after it: it calls
   the idiom the one "this file **carries above**", and this file no longer
   carries it — the packet itself ordered that copy deleted. The worker obeyed
   the instruction and proved byte-identity, which is exactly right; bouncing an
   executor for obeying a named instruction backed by a bounce condition is how
   a pre-committed review bar gets renegotiated after the fact. The error is
   mine. Repaired to `…idiom this file / and test_m03_e/f/g/h call from
   {!Bench}: …`, preserving the line structure and the rest of the comment.
2. **`test/xgmii_rx_64/test_m03_e.ml`** — the `134-138` block was correctly
   judged to carry no false claim, but with its definition deleted it was left
   describing a function it never names, floating above another comment. §5's
   rule for a fact comment is that it "stays and **keeps pointing at it**"; this
   one pointed at nothing. Repaired by naming `{!Bench.account_dropped_frame}`
   in its opening clause. The two quoted spans are untouched, and the
   `"no tlast word to / mark"` span is deliberately left straddling its newline
   — joining it onto one line would make it *newly visible* to bar 1's
   line-based regex and add an element to the file's multiset.
3. **`test/xgmii_rx_64/bench.mli`** — §4.5 named "the hand-built-`in_times`
   contract **and its verification against `test/monitors/octet_time.ml`**" as
   content that must reach the shared definition. The sizing contract arrived;
   the verification clause — that `Latency.frame_dropped` only pops the pending
   queue and never inspects the array — stayed behind in `test_m03_g.ml`'s
   call-site comment. It matters precisely at `account_dropped_piece`, where it
   means the `~received` precondition is **unenforced by construction**: a
   wrongly-sized array is not caught here, and the mistake surfaces only once
   the habit reaches `account_forwarded_piece`, where the array is read.
   Restored to `account_dropped_piece`'s docstring.

Each repair is **comment/docstring only** — I re-ran the comment-stripped code
diff on all three files against `c501425` and got **zero** code-line
differences — and I re-ran bar 1 (clean over all twelve files against the
parent), the parse check (exit 0), the inventory (39) and the records check
(23/23) against the repaired tree.

### What this unlocks

`WO-0064` closes the `RV-0062-VERDICT` §5 debt in full. One home, four
definitions, and — the part that was the actual point — **two contracts that
were previously carried only in the heads of the people who transplanted them
are now written where the next caller cannot miss them.** Fourteen-to-four is
the bookkeeping; the preconditions are the payoff.

**`WO-0063` phase A opens next.** My scheduling, stated so it is not
rediscovered later:

- The member (iii) plan edit **rides phase A's opening commit**.
- The `BUG-0003` §V.2 probe **rides phase A**.
- My five owed notes' citation sites **ride the next family-I bench round**,
  not phase A.

Unchanged and still open, so their absence stays legible: `WO-0058` bound 7
(the in-word REQ-110 abort with a frame already open on entry) still has no
candidate row; the `assert_following_frame_intact` /
`assert_clean_frame_structure` merge remains deliberately uncommissioned, a
redesign rather than a refactor; `SO-xgmii_rx_64.md` does not issue; 41 of 62
ASSERT rows discharged before this packet and 41 after it — a refactor moves no
coverage, which is the whole claim.

**Verdict: ACCEPT.** Recorded at `J-dv_lead-0101`.
