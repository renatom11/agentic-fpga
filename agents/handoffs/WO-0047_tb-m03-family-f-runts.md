# WO-0047: Family F — runt frames (REQ-107), and the in-word abort row E5

- **State**: DRAFT (id assumes WO-0047 is next free; orchestrator allocates)
- **From** / **To**: dv_lead → tb_writer
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's `Frame` row,
  §9 (the sixth row, the strobe pin **and its no-output-word clause**, the
  co-occurrence rulings — **ruling 1** on the admitted pairing and **ruling 9**
  on the sub-5 bar), §0.6, §0.7; `docs/specs/requirements.md` REQ-107, REQ-103,
  REQ-104, REQ-105, REQ-008, REQ-013, §0.3.
- **Rows**: **six.** `AP-xgmii_rx_64.md` §4.F — **M03-F1, F2, F3, F4** (ASSERT)
  and **M03-F5 (discharged by citation, §3.3)** — plus **M03-E5** (§4.E,
  REQ-105), folded in for the reason in §1.2.
- **Deliverables**: `test/xgmii_rx_64/test_m03_f.ml`, plus any bench addition
  §4 authorises and nothing else. **M03-E5 lives in `test_m03_e.ml`**, beside
  its family — see §1.2.

## 1. Why this family, what it closes, and one decision I am taking for you

### 1.1 What is actually unverified — checked, not assumed

The obvious claim would be "REQ-107 is unverified in its positive direction, as
REQ-104 and REQ-105 were". **That is false, and I checked before writing it.**

**M03-C4 already drives a 5-octet runt at both start lanes** and asserts: one
output word, `tkeep` = 0x01, `tlast`, **`tuser`[0] = 1** ("REQ-107 forwards it
marked invalid"), the delivered octet, and **exactly one `error_runt` on the
pinned cycle**. So a design that detected a runt and never reported it **already
dies at C4**. REQ-107's report path is verified at five octets today.

**What is unverified is narrower and sharper: the sub-five-octet class.** No unit
in the bench drives a frame of **fewer than five octets between start and
terminate**. C4's frame is *exactly* five. M03-E2's frame delivers zero octets
but is closed by `/E/`, so it takes REQ-105's disposition and §9's second row,
not REQ-107's sixth.

> **So the silently-always-pass class for this family is: a sub-five-octet frame
> silently dropped, with no strobe at all.** REQ-008 forbids silent discard and
> §9's sixth row requires `error_runt`; **nothing in the suite today would
> notice.** That is F-c5 in §8, and it is what this packet exists to close.

### 1.2 M03-E5 is folded in — my call, and the reason is a verification one

M03-E5 (a preamble-position `/E/` at a lane-0 start: a frame opened and closed
inside one input word) is REQ-105's, not REQ-107's. I am folding it here anyway.

The convenience argument — shared machinery, and a one-row round with a full
mutation campaign attached is disproportionate — is true but not sufficient. **The
verification argument is:** E5 and F2 are the programme's **two no-output-word
classes**, and a defect in the shared no-output path would have to be scored
against **both** to be understood. In separate packets they get separate freezes
and separate denominators, and a mutation seeded against one **cannot be scored
against the other**. Folding them puts both in one matrix where a shared-path
defect is visible killing both at once.

**Accounting stays separate**: this packet discharges **M03-E5 (REQ-105)** and
**M03-F1–F5 (REQ-107)**, and the sign-off arithmetic tracks them under their own
requirements.

### 1.3 Not co-sim-gated

Every row below is **hand-derivable from §9 and §6.1**. As at WO-0043 §1: derive
every expected value by hand and use `Injection`'s computed `outcome`/`report`
**only as a cross-check that you report**. A row whose expected values come from
the model is co-sim-gated and cannot carry a sign-off; a row that hand-derives
them is not.

**The embedded cross-check idiom is now standing practice** (`RV-0043-VERDICT`
§5): a model-vs-hand tripwire may live in a committed expect test provided it
**raises rather than prints**, **names its finding class**, and **routes to
dv_lead with an explicit bar on resolving it by adopting either side**. Reuse
`test_m03_e.ml`'s `fail_cross` wording.

## 2. The rows

### M03-F1 — 5, 16, 60 and 63 octets, both start lanes (ASSERT)

Delivered 1, 12, 56, 59; `tuser`[0] = 1 on each `tlast` word; **exactly one
`error_runt` per frame on the `tlast` cycle** and no other strobe; **the FCS is
removed and checked** — these frames end with `/T/`, so REQ-103 applies.

**Sampling**: all four produce output, so the `tlast` cycle is §9's ordinary pin.
State per length whether the final delivered word is full — 1, 12, 56 and 59
give fills 1, 4, 8 and 3, so **56 is the full-word case** and belongs to R-1's
disagreement class. **X-1**: placement only. Hand-derivable.

### M03-F2 — 0, 1 and 4 octets between start and terminate (ASSERT)

**No output word at all**; **exactly one `error_runt` and no other strobe of any
kind**, at §9's **no-output-word pin** — two cycles after the input word carrying
the character that ended the frame, which is a pin in its own right and **not** a
corollary of `m + 3`.

**The 4-octet frame's filler SHALL NOT be `00 00 00 00`** — or both fillers are
driven — for the reason M03-M10 gives: an all-zero four-octet frame passes a
wrong design by accident, because `zlib.crc32(bytes(4))` is REQ-304's residue and
is the unique four-octet member of that class.

> **The no-output-word discipline, generalised from M03-E2 and binding here:**
> §4.1 makes `rx_tuser`[0] *"meaningful only on the `tlast` word"*, and these
> frames have none. **M03-F2 must assert NOTHING about `tuser`[0]** — not 0, not
> 1. An assertion there reads a field on a `tvalid` = 0 cycle, which standing
> obligation 6 forbids outright. Assert the **structural** fact instead
> (`tlast_sample` is `None`, `delivered_samples` is empty), as `run_e2` does.
>
> And account the frame **through its strobe** — `Conservation_monitor.discarded`
> via an `account_dropped_frame`-shaped helper — **never** through
> `frame_out ~aborted:true`. That is M03-E3's rule and it applies unchanged to
> every no-output-word frame.

**X-1**: placement, **and the stimulus trap of §4.1**. Hand-derivable.

### M03-F3 — a 63-octet frame with a wrong FCS (ASSERT)

**Both** `error_runt` and `error_bad_fcs` pulse **once**; `tuser`[0] is set
**once** — one bit on one word, not one bit per condition.

§9's **first** co-occurrence ruling admits this pairing at five octets and above,
which the WO-0039 campaign confirmed empirically: mutation M2 made M03-C4's
five-octet frame report `observed 2` strobes. So the pairing is real at 63.

**X-1**: placement plus an FCS corruption. Hand-derivable.

### M03-F4 — the adjacent pair 63 and 64, both lanes (ASSERT)

63 → `error_runt`, `tuser`[0] = 1, 59 delivered. 64 → **no strobe**, `tuser`[0] =
0, 60 delivered.

**This is the strongest row in the family** and the re-read (§3) says so: two
frames differing by one octet and by everything else, which kills both the
`< 64` → `≤ 64` threshold and a threshold applied to the *delivered* count rather
than the *received* count (60 < 64 would strobe on a legal frame).

**X-1**: placement only. Hand-derivable.

### M03-F5 — DISCHARGED BY CITATION (§3.3). Do not build it.

### M03-E5 — a preamble-position `/E/` at a lane-0 start (ASSERT, `test_m03_e.ml`)

A frame opened **and closed inside one input word**: zero delivered octets, **no
output word at all**, exactly one `error_bad_frame` at §9's no-output-word pin,
and — per the discipline above — **nothing asserted about `tuser`[0]**.

Drive `Injection.placement`'s **preamble-position** constructor at positions 1..7
of a lane-0 start. This row exists because the WO-0045 seeder found, by reading
the design, that this stimulus takes a structurally distinct in-word path that no
family-E row exercises.

**Put it in `test_m03_e.ml`** beside its family, not in `test_m03_f.ml`. The
packet is shared; the file layout follows the requirement.

## 3. The two defect-shape re-reads — DONE, with three findings

`RV-0041-VERDICT` ordered every unwritten family re-read for the D3-vacuity
shape and the unachievable-kill shape before being benched. I did this myself
rather than delegate it, per the family-E precedent, and it produced three
findings you need before you start.

### 3.1 What passed both re-reads

**F1**: suppressing FCS removal delivers four octets too many at all four
lengths; suppressing output removes words. Both directly observable. **Clean.**

**F3's precedence kill**: a first-match design reports only the runt, which the
exact-strobe-set check catches. **Clean.**

**F4**: both kills are sharply observable, and the two-frame construction makes
them unmissable. **Clean, and the best row here.**

**E5**: an in-word path that reports through a different channel, or not at all,
shows as a wrong strobe or a missing one. **Clean.**

### 3.2 FINDING — two declared kills are at risk, and I could not settle either

**F2's second kill** — "a design that attempts FCS removal on a frame with
nothing to remove it from **and underflows its counter**" — is **at risk of the
unachievable-kill shape.** An underflow that *clamps* to zero produces the same
observable as the correct design: no output word. Whether this M03 clamps is a
question about `libs/**`, which I may not read, so **I cannot settle it either
way** — unlike M03-D3, where a margin computation proved unachievability outright.

> **Do not rest F2's justification on it.** The row's teeth are kill 1 (a
> `tkeep` = 0 word emitted) and kill 3 (the exhaustive strobe set catching a
> residue comparison at every terminate — M03-M10). **The campaign settles it**:
> if a faithful underflow mutation kills nothing, the kill is withdrawn by spec
> diff, exactly as M03-D3's headline kill was.

**F3's second kill** — "a design that sets the abort bit **twice**" — is **not
clearly an observable at all.** `tuser`[0] is one bit on one word; "twice" has no
distinct manifestation unless it means two `tlast` words, which is a different
defect. **The row's teeth are the precedence kill and the pulse-width kill** (a
widened strobe, which C-23's high-cycle counting catches). Assert the exact
strobe set and the single `tuser` bit; do not attempt to assert "not twice".

### 3.3 FINDING — M03-F5 is redundant with M03-C4. Discharge by citation.

F5 drives "the 5-octet frame of M03-F1" and asserts exactly one delivered octet,
`tkeep` = 0x01, `tlast`. **M03-C4 already drives that frame at both start lanes
and asserts strictly more**: the same three facts plus `tuser`[0] = 1, the
delivered octet's value, the arrival cycle, and exactly one `error_runt` on the
pinned cycle.

F5's declared kill — "fewer than 5" implemented as "≤ 5", emitting nothing for
the boundary frame — **would die at C4**, which asserts a word exists.

> **So F5 is discharged by citation to M03-C4, and you do not build it.** State
> the citation exactly in your Return log, as WO-0040 §2 required for M03-D2.
> **M03-F1's own 5-octet member re-drives the frame anyway**, so the boundary is
> exercised twice over without a dedicated row.

A row discharged by citation is honest only if the citation is exact. Name C4's
assertions, not "C4 covers it".

## 4. Machinery

### 4.1 The sub-five-octet stimulus trap — stated, not posed

`Arrival.check` **complains about a frame of fewer than five octets**, in terms
that such a frame "is an injection case, not a schedule case". `Injection`
**filters exactly that one complaint and no other** (`test/xgmii/injection.ml`,
the comment at the `Arrival.create` call), naming rows **F2 and F5**.

> **Consequence, binding: M03-F2 must be built through `Injection`, not through
> `Bench.frames_at`/`Arrival.create` directly.** A sub-five frame scheduled the
> ordinary way fails the STIMULUS's own self-check before a cycle is driven, and
> that failure reads exactly like a DUT finding while being nothing of the kind.
> This is the `fcs_valid` trap of WO-0040 §3.2 in a new dress, and it is the
> third such trap in three families.

**Report the filter's exact predicate.** The comment names F2 *and F5*, but F5's
frame is five octets and should not trip a *sub*-five complaint. Establish what
the predicate actually is and say so — it is either a looser bound than the
comment implies or the comment is loose, and either way the next family wants to
know.

### 4.2 Assertion order is part of a row's contract

A new instruction, earned at `J-dv_lead-0053`/`0054`, and it is not stylistic.

**The first failing assertion is what a mutation campaign is scored against.** I
seal expected *messages* before a campaign runs, and those messages are
determined by the order your assertions appear in — and, where a row loops, by
**which iteration runs first**, since these rows fail fast.

> **So: order assertions deliberately — most structural first, most specific
> after — and treat the order as part of the row's contract. If you reorder
> assertions or change an iteration order, say so prominently in the Return
> log.** I got a sealed message wrong once by not reading an iteration order; I
> would rather not repeat it because a reorder went unremarked.

### 4.3 Bench additions

`Bench`'s exported surface is bounded as before, and `RV-0043-VERDICT` §7 is now
precedent: **the budget bounds `Bench`'s exported surface, not a row's own
helpers.** Family E needed no addition because the accounting it wanted was
already public on the accessors. Expect the same here — the no-output-word
accounting helper is a file-local function, as `account_dropped_frame` is.
**If you believe an exported addition is required, return the question rather
than adding it.**

## 5. What you may NOT read

- **Never open `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**`** — any path,
  manifests included. Scope every `grep` to `test/` and `docs/specs/`.
- Derive every expected value from **SPEC-M03 and requirements.md**, never from
  the design, and never from `Injection`'s computed model (§1.3).
- **Third-party sources at the opam switch (`/root/.opam/**`) are readable** and
  every such read is listed by path in your journal `Inputs`.
- `test/third_party/**` holds the co-simulation reference. **You have no reason
  to read it for this packet** and it is not a source for any expected value
  here.

## 6. Expected-CI discipline — the regime facts already paid for

1. **ADR-0005: no toolchain reaches this directory.** CI is authoritative; mark
   anything uncompiled **UNVERIFIED**. `tools/precompile_check.sh` **structurally
   excludes** this directory and its green is not a type-check.
2. Warning **9** (missing record fields) and **33** (unused open) are **fatal**;
   69 is not enabled; **alerts are errors**, so use **`Int.rem`**, never `mod`.
3. A record pattern gets no type-directed label resolution from an unannotated
   scrutinee. Annotate or qualify.
4. `Base.List.init` evaluates `~f` from the highest index **down**;
   `List.iter` over a built list runs in order. **Know which you are using** —
   §4.2 depends on it.
5. **Promotion discipline.** Every `[%expect]` block stays empty. **Never harvest
   a promotion**; a `runtest` diff is a finding to report.
6. **Nothing timing-derived may be snapshotted.** Assert in code.
7. **Run a guard against the defect it names before shipping it**, and **verify a
   stimulus at BOTH its failure sites** — its own construction, *and* whether the
   bench actually drove it. `run_e4` checks its `/E/` twice for this reason and
   the second check is the one that catches an unwired hook.
8. **Trace a change against the code it will run beside.**
9. **Provenance**: any quantity you state carries its provenance — **measured**
   (with the command), **derived** (with the derivation), or **relayed** (with
   the source named). **A relay is not a measurement**, and when you cite a
   tracked item, name the **field and the SHA**, not the item.
10. **A new directory holding OCaml sources needs a `dune` disposition.**
    `precompile_check.sh` lane 3a reddens on an undisposed directory, by design —
    an undisposed directory is one whose sources would be silently uncompiled.

## 7. What I expect back

A Return log appended to this packet plus your journal entry. **Do not write an
`SO-`.** Structure it as WO-0043's: row disposition with no silence; what you
changed with file and line; **every derivation with its spec section cited**;
anything UNVERIFIED with the reason; expected CI as a labelled prediction; open
questions; and a scope statement with `git status --porcelain`, `git diff
--exit-code` on files you claim untouched, an explicit no-forbidden-path line,
and every `/root/.opam/**` read.

**Deliverables, not background**: §4.1's filter-predicate answer, §3.3's exact
citation, and an explicit statement of each row's assertion order per §4.2.

## 8. Family F's qualification — five defect classes, ROW MAPPING SEALED

Qualified by a blinded campaign under the WO-0045 protocol. **The classes are
published so you write against them; which of your rows is predicted to catch
which is sealed before any diff exists.**

| | defect class |
|---|---|
| **F-c1** | FCS removal suppressed on a runt closed by `/T/` — four octets too many delivered |
| **F-c2** | the runt threshold off by one, or applied to the delivered count rather than the received count |
| **F-c3** | an output word emitted for a frame that must produce none |
| **F-c4** | first-match reporting — where two conditions hold, only the first-considered strobe fires |
| **F-c5** | a **sub-five-octet frame silently dropped, with no strobe at all** |

**F-c5 is the class this packet exists for.** Per §1.1 it is the *only*
silently-always-pass class family F can still close, because C4 already verifies
REQ-107's report path at five octets. It violates REQ-008 and §9's sixth row, and
**nothing in the bench today would notice.** A row set that does not die on F-c5
has closed nothing.

**Expect F-c5 and F-c3 to look quiet.** They are invisible to everything outside
the sub-five class. That is the defect class, not a weak diff.

## 9. What this packet does not do

`SO-M03` does not issue on family F. After it, **21 of the plan's 60 ASSERT rows**
would be discharged — F1–F4 and E5 newly, F5 by citation. Families **G and H**
remain unwritten, as do I, J, K, M, N and L1–L5, and `WO-0046`'s differential
co-sim is still owed as the external anchor for any row resting on X-1's computed
model — which, per §1.3, none of these do.
