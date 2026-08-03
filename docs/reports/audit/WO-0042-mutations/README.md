# WO-0042 — family-D mini-round: one seeded mutation (D-M6, the latched abort bit)

**Author**: auditor (no-stake third party — I authored neither M03's RTL nor any
part of its bench).
**Task**: `agents/handoffs/WO-0042_family-d-m6-mini-round.md` (committed at
`fbd4ce3`).
**Base**: `447d11c`, file `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, blob
`81cd9ed7fc64e6265c53117f251ef948f24e3b00`.
**Subject under test**: **not M03.** Whether family D's two-frame row has teeth
against the one defect class it still declares and nothing has yet exercised.
**I did not run this diff and I have not seen any result.**

Deliverables in this directory:

| File | Contents |
|---|---|
| `D-M6.diff` | The mutation, unified format, index line pinning the base blob |
| `README.md` | This file |

---

## 1. Scope statement — what I read, what I did not, and prior exposure

Packet §0 says the blinding has no script behind it and that my disclosure is
the whole of it. This section is therefore the enforcement mechanism, not a
formality.

### 1.1 Read in full

- `agents/charters/auditor.md`
- `agents/PROTOCOL.md`
- `agents/handoffs/WO-0042_family-d-m6-mini-round.md` (this round's brief, at
  `fbd4ce3`)
- `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` **at `447d11c`**, all 772 lines —
  extracted with `git show 447d11c:<path>` into my private scratch subdirectory;
  the working tree's copy was never opened and never touched
- `docs/reports/audit/WO-0041-mutations/D-M1.diff` — my own prior artifact, read
  for the diff format (index-line convention, hunk marker style)
- `agents/journals/claude_auditor_agent.md` — my own journal: the entry-header
  grep for the next id, the file tail, and `J-auditor-0005` in full (lines
  822–955), which is the documentary basis of §1.4 below

### 1.2 Read in part

- `docs/specs/modules/xgmii_rx_64.md` (SPEC-M03): one grep for `tuser` (60-line
  cap, 25 hits shown) and two `sed` ranges — lines 705–740 (§9's condition table
  and the closure list) and 780–815 (§9's co-occurrence rulings). REQ text quoted
  in §4 below comes from those extents and nowhere else.
- `libs/hardcaml_ethernet/src/axi64.ml` lines 1–80 — to establish
  `user_bits = 1`, i.e. that `tuser`[0] is the whole field.
- `libs/hardcaml_ethernet/src/dune`, `dune-project`, `.ocamlformat` — build and
  format configuration, for §6.
- Hardcaml's own sources at
  `/root/.opam/fpga/.opam-switch/sources/hardcaml/src/` — `signal_intf.ml:80`
  (the `reg_fb` signature) and `fifo.ml:313–318` (the library's own 1-bit
  set/hold idiom). Read for compile-confidence; these are library sources, not
  repository artifacts.

### 1.3 Metadata only — no file content

- `git rev-parse HEAD`; `git log -1 --format='%H %s' 447d11c`;
  `git rev-parse 447d11c:<the RTL path>`
- `git diff 447d11c HEAD --stat -- libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
  (empty — the base file is HEAD's file)
- `git log --oneline --format='%h %an %s' -- docs/reports/audit/WO-0041-mutations/`
  — **one** commit, `fb49b80`, my own; this is how §1.4 knows my prior report was
  never amended after the fact
- `git status --porcelain -- docs/reports/audit/` (empty)
- Directory listings only: `libs/hardcaml_ethernet/src/`, `docs/reports/audit/`,
  `docs/reports/audit/WO-0041-mutations/`, `rtl_snapshots/`, the repository root,
  `_build/default`, and the opam switch's `bin`/`lib`/`sources`.

**Deliberate abstention, and it is a tightening on last round.** WO-0042 sharpens
the bar to *every* git subcommand on a barred path, `log` and `show` included. I
ran **no** unscoped `git log` this round — not even `--oneline -12`, which the
WO-0041 spawn did run — because the WO-0041 adjudication's own commit *subject*
could carry a kill result. The only commit subject that reached me is `447d11c`'s
(the base) and `fb49b80`'s (my own seeding commit). No path-scoped log was run on
any barred path.

### 1.4 The nine bars, item by item

**Not read, at any SHA, by any means:**

1. `test/xgmii_rx_64/**` — nothing under it. In fact **no file under `test/` at
   all**, of any name (see the disclosure in §1.5 about a directory copy).
2. `test/attack_plans/AP-xgmii_rx_64.md` — nor anything else under
   `test/attack_plans/`.
3. `agents/handoffs/WO-0040_tb-m03-family-d-fcs.md`.
4. `agents/handoffs/WO-0039_m03-mutation-campaign.md`.
5. `agents/handoffs/WO-0039_m03-mutation-campaign-SEALED-predictions.md`.
6. `agents/handoffs/WO-0041_family-d-mutation-campaign-SEALED-predictions.md`.
7. `agents/journals/claude_dv_lead_agent.md` — whole file. I asked for no
   extraction through the orchestrator because nothing in this task needed one.
8. `agents/journals/workers/claude_tb_writer_agent.md`.
9. `agents/handoffs/WO-0041_family-d-mutation-campaign.md` — **not opened, and
   not touched by any git subcommand this round.**

Beyond the bars I also stayed out of every `BUG-`/`SO-`/`RV-` packet,
`tasks/BOARD.md`, `docs/gates/**`, every other agent's journal, and
`crc32_eth.ml` (this round's intent touches what is done with a verdict, never
how any verdict is computed).

**Prior exposure, items 3–9, on commit-ordering evidence rather than memory.**
PROTOCOL §2 makes agents stateless between spawns; my context for this task
begins with this brief, so "what I recall reading" is exactly nothing, and a
memory-based answer would be worthless. What exists instead is committed:

- `J-auditor-0005` (WO-0041 seeding) records its own complete read list. It
  records item 9 **read in full at `06007a3`**, and records items 1–8 not read.
  Its long form is §1.5 of `docs/reports/audit/WO-0041-mutations/README.md`, a
  file with **exactly one commit** (`fb49b80`, path-scoped log above) and
  therefore never amended with anything learned later.
- `J-auditor-0004` (WO-0039 seeding) is the corresponding record one round back;
  its long form is §1 of `docs/reports/audit/WO-0039-mutations/README.md`.
- Item 9's exposure is therefore **exactly** what WO-0042 §1 already states and
  rules acceptable: the WO-0041-era spawn read that packet **before** the
  adjudication was appended to it. The ordering is established by the brief's own
  §0 ("After the campaign was adjudicated, that file gained the verdict") taken
  with `J-auditor-0005`'s `06007a3`; I did not verify it with a path-scoped log
  because doing so is now itself barred.

I make no claim about item 9's *current* content and have no basis for one.

### 1.5 Ambient exposure I disclose because a bar list is a floor

1. **A directory copy that included barred paths.** To test whether a real
   compile was possible I copied the repository tree (excluding `_build` and
   `.git`) into my scratch subdirectory with `tar`, ran
   `dune build libs/hardcaml_ethernet` against it, and deleted the copy. The
   copy contained `test/**`. **No byte of it entered my context**: `tar` piped
   to `tar`, and dune's output (reproduced in §6) names only
   `libs/hardcaml_ethernet/src/dune` and two missing libraries. I judged the
   copy worth making and, having made it, worth disclosing rather than
   rationalising. If dv_lead judges the copy itself to breach bar 1, the finding
   is dv_lead's to make and I will not argue it down.
2. **Private scratch, and the shared root not listed.** I worked only in a
   freshly created subdirectory and did **not** list the shared scratchpad root
   — the practice my own WO-0041 process finding proposed and the orchestrator
   accepted. Nothing another agent left there could reach me even by accident.
3. **`_build/default`'s directory listing** shows a `test` entry among its
   subdirectory names. A name, no content.

---

## 2. The intent as I understood it

Verbatim from the packet, `tuser`[0] becomes **sticky across frames**: once M03
sets it on some frame's `tlast` word, every subsequent frame's `tlast` word
carries it set too, whether or not that later frame is itself invalid. The bit
latches and is never cleared between frames.

Four constraints ride with it, and I treated each as binding:

1. **What decides the bit is untouched.** REQ-104's FCS verdict, REQ-107's runt,
   REQ-105's error character and REQ-108's oversize must each keep contributing
   exactly as today. This mutation must not change *which* frames are found
   invalid.
2. **The strobes do not move with it.** §9 makes each strobe a per-frame report
   of that frame's own condition. `error_bad_fcs`, `error_runt`,
   `error_bad_frame` and `error_oversize` must each pulse exactly when and where
   they do today.
3. **Nothing in the payload path moves.** Delivered octet counts, `tkeep`,
   `tlast` placement and all word timing unchanged.
4. **`clear` (REQ-009) is free.** A reset may clear the latch; nothing depends
   on whether it does.

And the footprint note: this defect is invisible to any stimulus that drives a
single frame per simulation, and must **not** be strengthened to make it louder.
I took that as a prohibition on widening the arming condition, and §5.1 records
the one place where it decided a reading.

---

## 3. Mechanism

### 3.1 Site

M03 has exactly one place where `tuser`[0] is produced and exactly one place
where the abort disjunction is formed, and they are 23 lines apart in the same
scope:

- base **line 736**: `let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in`
  — the disjunction, already fed by the aged closure record (`sel`), i.e. by the
  four REQ conditions the packet names;
- base **line 759**: `; tuser = emit_tlast &: abort` — the only assignment of the
  `tuser` field of the output record.

Nothing else in the module reads or writes `tuser`. That is what lets this
mutation be one added binding and one edited expression.

### 3.2 The two code changes

Added immediately after `abort` (the register's inputs, `emit_tlast` at base line
732 and `abort` at 736, are both already in scope):

```ocaml
let abort_sticky = reg_fb spec ~width:1 ~f:(fun d -> d |: (emit_tlast &: abort)) in
```

and the field assignment becomes:

```ocaml
; tuser = emit_tlast &: (abort |: abort_sticky) (* D-M6 MUTATION (WO-0042) *)
```

The added block carries an in-source comment opening `D-M6 MUTATION (WO-0042)`,
so the marker is greppable at both sites.

### 3.3 What the circuit now does

`abort_sticky` is a one-bit register whose next value is
`abort_sticky | (emit_tlast & abort)` — a set-and-hold flop armed by *the value
M03 drives on `tuser` today*, reset only by `spec`'s clear.

- Before any invalid frame: `abort_sticky` = 0 and
  `emit_tlast & (abort | 0)` = `emit_tlast & abort`, the base expression exactly.
  Every frame up to and including the first invalid one behaves as the
  unmutated module does, *bit for bit*, on every output.
- On the first invalid frame's `tlast` word: `tuser` is 1 because `abort` is 1,
  as today. The flop arms on that same edge.
- On every later frame's `tlast` word: `tuser` is 1 regardless of `abort`.

So the **first observable divergence** is on the `tlast` word of the frame *after*
the first frame that already set the bit — which is precisely the packet's "every
subsequent frame's `tlast` word carries it set too", and precisely why a
one-frame-per-simulation stimulus cannot see it.

Latching the *emitted* value rather than `abort` is not a choice with two
outcomes: `d | (emit_tlast & (abort | d))` reduces to `d | (emit_tlast & abort)`,
so the two formulations are the same circuit. What is a choice is §5.1.

---

## 4. Fidelity argument

**The strobe paths were left alone — textually, not merely in effect.** The
comment-stripped code delta (§7.5) is two lines and neither is a strobe. The five
output strobes remain:

```ocaml
; error_bad_fcs = strobe sel_bad_fcs
; error_bad_frame = strobe sel_error |: q_strobe 0
; error_runt = strobe sel_runt |: q_strobe 1
; error_oversize = strobe sel_oversize
; error_start_without_terminate = strobe sel_start |: q_strobe 2
```

with `strobe s = consume &: s &: ~:(i.clear)`, `q_strobe k = bit q2 k &: ~:(i.clear)`
and `consume <== (sel_valid &: (emit_tlast |: sel_is_r2))` all byte-identical to
the base. `abort_sticky` is referenced in exactly one place in the whole module,
and that place is the `tuser` field (§7.4 counts it mechanically: two occurrences
in comment-stripped code, one definition and one use). No strobe, no closure
record bit, no ageing register, no consumption decision can see it. §9's "each
strobe is a per-frame report of that frame's own condition" therefore holds
after the mutation exactly as before, on the same pinned cycles, and REQ-008's
no-silent-discard structure is untouched. A version that latched the reporting
path would be a larger, different defect; this is not one.

**What decides the bit is untouched.** `abort`'s five disjuncts — `sel_bad_fcs`
(REQ-104), `sel_error` (REQ-105), `sel_start` (REQ-110), `sel_oversize`
(REQ-108), `sel_runt` (REQ-107) — appear in the mutated file in the same single
expression, unedited. Nothing upstream of `abort` is touched: not `bad_fcs`, not
`has_fcs`, not the residue comparison, not `a_close_runt`, not
`a_close_oversize`, not the closure record `r0`/`r1`/`r2` or its selection.
Which frames are found invalid is bit-for-bit what it was.

**The payload path is untouched.** `tvalid`, `tdata`, `tkeep`, `tstrb` and
`tlast` are unedited; `keep_count`, `strip`, `pc`, `nc`, `emit_full`,
`emit_last_a`, `emit_last_b`, `fcs_tail_pending`/`fcs_tail_now` and the whole
alignment window are unedited. The added register is a leaf: it drives one
consumer and is driven by two existing signals, so it adds no level to any
existing path and cannot retime anything. Delivered octet counts, `tkeep`
patterns, `tlast` placement and ΔC = 3 are all as specified.

**`clear`.** `spec` is `Reg_spec.create ~clock ~clear`, so `abort_sticky` resets
to 0 when `clear` is asserted — the latch does not survive a reset. The packet
says nothing depends on this either way; I record the behaviour rather than
engineering around it, because engineering around it would be an unrequested
second change.

**No second `tlast` word picks the bit up inside one frame.** BUG-0001's residual
all-FCS word is suppressed by `fcs_tail_now` (`have_word = (pc <>:. 0) &: ~:fcs_tail_now`),
so a frame emits at most one `tlast` word and the sticky bit cannot appear twice
within a frame's own output.

**Ports are unchanged.** The `I` and `O` records are untouched, so no port name,
width or ordering changes and nothing that binds M03 by port name is structurally
affected.

---

## 5. Disclosures

### 5.1 The one reading I had to choose: what arms the latch

The intent's sentence is "once M03 **sets it on some frame's `tlast` word**". I
armed the latch from exactly that event — `emit_tlast &: abort`, the value driven
on `tuser`. The consequence is that the §0.7 classes that produce **no output
word at all** do not arm it:

- a frame of fewer than 5 octets between start and terminate (§9 row 6),
- `/E/` at or before the frame's first octet (§9 row 3),
- `/S/` at or before the frame's first octet (§9 row 9),
- an epoch opened and closed inside one word (the `q2` path).

Every one of these is an *invalid* frame with no `tlast` word to carry
`tuser`[0]. A wider reading — "the abort **condition** latches", arming on any
consumed closure record with an abort bit whether or not a word is emitted —
would also arm on those.

I chose the narrower reading on two grounds. First, textual: the intent names
`tuser`[0]'s *value* on a `tlast` word as both the thing that becomes sticky and
the setting event, and a frame with no `tlast` word has no such value. Second,
the packet's own instruction not to strengthen the defect to make it louder: the
wider reading is a strict superset of the narrower one's observable behaviour, so
choosing it would add footprint the intent did not ask for.

**This is the disclosure that matters for pass criterion 2.** If dv_lead's sealed
prediction expects a kill from a stimulus whose *first* invalid frame emits no
output word — a sub-5-octet runt, or an `/E/`/`/S/` before the first octet, as
the arming frame — then D-M6 as written is silent where a wider reading would
speak, and the round would go green for a reason that is mine and not the bench's.
I flag it in advance rather than after a result, and I have no way to check it:
the bench and every prediction file are barred. Should dv_lead want the wider
reading, the change is one line and I will author it as a separate diff, before
any result is disclosed to me.

### 5.2 Collateral that any RTL change carries

The added flop changes M03's generated Verilog. `rtl_snapshots/xgmii_rx_64.v`
exists in this repository. If any unit compares generated RTL against that
snapshot, it will redden for structural reasons under **every** mutation in every
round, this one included, and such a reddening is not evidence about family D.
I cannot check whether such a unit exists — `test/**` is barred — so I state the
possibility so it is not read as an unnamed unit reddening under pass criterion 2.

### 5.3 What I could not do

- **I could not compile-check the mutation.** See §6; the dependencies are not
  installed in this container and the *unmutated* base fails identically.
- **I could not exercise the defect.** I ran no simulation and saw no result, by
  design (packet §3).
- **I could not verify item 9's ordering with git.** See §1.4; the sharpened bar
  forbids it, so the ordering rests on the brief's own statement plus my
  committed prior journal.

### 5.4 No compile-only repair was needed

Bar 11's exception was not used. The diff in this directory is the diff as first
authored; it has been revised for nothing, and no run result of any kind has
reached me.

---

## 6. Compile-confidence

**A real type-check is not available in this container, and that is a property of
the environment, not of the diff.** `dune` exists in the `fpga` opam switch but
`~/.opam/fpga/lib/` holds only `dune`, `stublibs` and `toplevel`. Building the
**unmutated** base in a scratch copy fails:

```
$ dune build libs/hardcaml_ethernet
File "libs/hardcaml_ethernet/src/dune", line 4, characters 18-30:
4 |  (preprocess (pps ppx_hardcaml ppx_jane)))
                      ^^^^^^^^^^^^
Error: Library "ppx_hardcaml" not found.
File "libs/hardcaml_ethernet/src/dune", line 3, characters 21-33:
3 |  (libraries hardcaml hardcaml_axi)
                         ^^^^^^^^^^^^
Error: Library "hardcaml_axi" not found.
```

So compile-confidence below is **argued and parse-checked, not demonstrated by a
build**. The argument, in the order the compiler would meet it:

1. **Syntax.** `ocamlc -stop-after parsing` accepts the mutated file (§7.3), and
   two negative controls prove the check is live and specifically sensitive to
   the added line.
2. **`reg_fb`'s signature.** From the pinned Hardcaml source,
   `src/signal_intf.ml:80`:
   `val reg_fb : ?enable:t -> Reg_spec.t -> width:int -> f:(t -> t) -> t`.
   My call `reg_fb spec ~width:1 ~f:(fun d -> …)` matches it, matches the base
   file's own existing call at line 665 (`off4`), and matches Hardcaml's own
   1-bit set/hold idiom at `src/fifo.ml:315`
   (`reg_fb spec ~width:1 ~f:(fun q -> … (fifo_rd_en |: q))`).
3. **Scope and order.** `spec` (line 232), `emit_tlast` (732) and `abort` (736)
   are all bound before the insertion point, in the same `create` body.
   `abort_sticky` is bound at line 756 of the mutated file, before its single use
   at the `tuser` field on line 779.
4. **No orphaned binding — the WO-0041 hazard does not arise here.** This
   repository has no `env` stanza, so dune's dev profile applies and warnings 26
   and 32 are errors. `abort` keeps a use (two, in fact: the latch and `tuser`),
   `abort_sticky` has exactly one use, and no other binding loses its last use.
   The mechanical scan (§7.4) reports **zero** orphans in both base and mutated
   files, with the mutated file holding exactly one more binding.
5. **Name collision.** `abort_sticky` occurs zero times in the base file.
6. **Widths.** Hardcaml checks widths at elaboration rather than at compile time,
   so this is a runtime-exception argument rather than a typing one, and it
   holds: `emit_tlast` is 1 bit (an `|:` of two 1-bit signals), `abort` is 1 bit
   (an `|:` fold over five `bit` selections), `abort_sticky` is 1 bit by
   `~width:1`, and `Axi64`'s `user_bits = 1` (`libs/hardcaml_ethernet/src/axi64.ml`),
   so the `tuser` field wants exactly 1 bit.
7. **No new unassigned wire and no combinational loop.** `reg_fb` introduces no
   `wire`/`<==` obligation of its own, and the register's inputs do not depend on
   its output, so nothing new is cyclic.
8. **Formatting.** `.ocamlformat` pins `profile = janestreet, version = 0.26.2`
   (margin 90). The longest added line is 85 characters; the base file already
   contains 97-character lines, so the file is not margin-clean before the
   mutation either, and no CI job gates on `ocamlformat`.

**Stated confidence: high that this compiles unchanged; not certain, because it
was not compiled.** If it does not, bar 11's compile-only repair applies: I will
change nothing else and I will disclose the repair.

---

## 7. Self-checks (raw)

All work was done in a private scratch subdirectory; the repository working tree
was never modified outside `docs/reports/audit/WO-0042-mutations/`.

### 7.1 Base blob pinned, and reproduced independently

`git show 447d11c:libs/hardcaml_ethernet/src/xgmii_rx_64.ml` extracted to
scratch; re-hashed after committing it into a throwaway repository:

```
$ git rev-parse HEAD:libs/hardcaml_ethernet/src/xgmii_rx_64.ml
81cd9ed7fc64e6265c53117f251ef948f24e3b00
```

which is the blob the diff's index line names. `git diff 447d11c HEAD --
libs/hardcaml_ethernet/src/xgmii_rx_64.ml` is empty, so HEAD's file is the base
file.

### 7.2 `git apply --check` against a pristine `447d11c`, plus round-trip

Pristine tree via `git archive 447d11c | tar -x`:

```
$ git hash-object libs/hardcaml_ethernet/src/xgmii_rx_64.ml
81cd9ed7fc64e6265c53117f251ef948f24e3b00
$ git apply --check -v ../D-M6.diff
Checking patch libs/hardcaml_ethernet/src/xgmii_rx_64.ml...
check_exit=0
$ git apply --stat ../D-M6.diff
 libs/hardcaml_ethernet/src/xgmii_rx_64.ml |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)
$ git apply ../D-M6.diff && git hash-object libs/…/xgmii_rx_64.ml
2f9c3a199f63c5d65ca606d85905272d0fc66deb        # == the diff's post-image index
$ sha1sum libs/…/xgmii_rx_64.ml ../mkdiff/libs/…/xgmii_rx_64.ml
214f1eb2780e970950f9ab35aff891646dbd7320  (applied)
214f1eb2780e970950f9ab35aff891646dbd7320  (authored)
$ git apply -R ../D-M6.diff && git hash-object libs/…/xgmii_rx_64.ml
81cd9ed7fc64e6265c53117f251ef948f24e3b00        # base restored exactly
```

The applied file is byte-identical to the file I authored, and the patch reverses
to the base blob exactly.

### 7.3 Single file, and the parse check with negative controls

```
$ grep -c '^diff --git' D-M6.diff
1
diff --git a/libs/hardcaml_ethernet/src/xgmii_rx_64.ml b/libs/hardcaml_ethernet/src/xgmii_rx_64.ml
index 81cd9ed..2f9c3a1 100644
```

One file, one hunk pair, 21 insertions / 1 deletion.

```
$ ocamlc -stop-after parsing -c base.ml      → exit 0
$ ocamlc -stop-after parsing -c mutated.ml   → exit 0
```

Negative controls, both derived from the *mutated* file so that a vacuous check
would be caught:

```
$ # control 1: append an unterminated comment
Error: Comment not terminated                                  → exit 2
$ # control 2: drop one ')' from the added abort_sticky line
File "negctl_paren.ml", line 756, characters 82-84:
Error: Syntax error: ')' expected                              → exit 2
```

Control 2 is the important one: it proves the parser actually reads the line the
mutation adds.

### 7.4 Orphaned-bindings scan

A comment-stripping scan over every `let`/`and` binding, counting occurrences of
each identifier in comment-free code (so that a name surviving only inside
documentation is still reported as an orphan):

```
xgmii_rx_64.base.ml: 135 distinct let/and bindings; orphans (uses <= definitions): 0
mutated:             136 distinct let/and bindings; orphans (uses <= definitions): 0
```

Exactly one new binding, and it is used. Targeted census in comment-stripped
mutated code: `abort_sticky` 2 (one definition, one use), `abort` 3,
`emit_tlast` 6, `consume` 5, `strobe` 6, `q_strobe` 4, `sel_bad_fcs` 3,
`sel_runt` 3, `sel_error` 3, `sel_start` 3, `sel_oversize` 4.

### 7.5 Minimality — the comment-stripped code delta

With all comments and blank lines removed from both files:

```diff
   let abort = sel_bad_fcs |: sel_error |: sel_start |: sel_oversize |: sel_runt in
+  let abort_sticky = reg_fb spec ~width:1 ~f:(fun d -> d |: (emit_tlast &: abort)) in
   let tvalid = (emit_full |: emit_tlast) &: ~:(i.clear) in
   consume <== (sel_valid &: (emit_tlast |: sel_is_r2));
   let strobe s = consume &: s &: ~:(i.clear) in
…
       ; tlast = emit_tlast &: ~:(i.clear)
-      ; tuser = emit_tlast &: abort
+      ; tuser = emit_tlast &: (abort |: abort_sticky)
       }
   ; error_bad_fcs = strobe sel_bad_fcs
   ; error_bad_frame = strobe sel_error |: q_strobe 0
```

Two lines of code, everything else in the 21 added lines is the argument.

---

## 8. Mechanics for the runner

Throwaway branch = `447d11c` + `D-M6.diff` and nothing else; never merged. The
greppable marker is `D-M6 MUTATION (WO-0042)`, present at both change sites.
Per packet §4 the relay should state the parent SHA, the run id, Build state and
`dune runtest`'s **verbatim** output — the complete raised message and the name
of every `%expect_test` that failed. **A green run is a campaign failure** and is
to be relayed prominently; §5.1 above is the one reading that could produce a
green run for a reason attributable to me rather than to the bench.
