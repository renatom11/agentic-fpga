# WO-0031: SPEC-M03 R1/R2 repair — two sentences, bounded
- **State**: ISSUED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: WO-0030's WITHHELD verdict (J-dv_lead-0015 at
  0a5ce45): both rulings endorsed on merits, two sentences contested;
  the WO-0021/WO-0022 bounded-repair precedent; dv's pre-worded
  re-countersignature sentence (WO-0030 §5, end).
- **Deliverables**:
  1. **M03-R1**: §6.1's "Two consequences a bench may rely on",
     consequence 1, final clause — "only where it delivered no octet
     do the two fall together" is false by the spec's own m + 3
     formula + REQ-110's lane rule (dv's minimal witness: `/S/` lane
     0 of W−1; word W = four octets in lanes 0–3, `/S/` lane 4, `/T/`
     lane 6 → four octets delivered, both strobes on W+2; the strobes
     coincide in three of four sub-cases). Repair cannot avoid
     stating cycles — dv says so — so state them.
  2. **M03-R2**: §9's "Strobe cycle, pinned" — rule says W+2, its own
     gloss says W+3, whenever the ending character lies in the
     frame's own start word (a family under reading (i), reaching
     committed ASSERT rows M03-B2/B3). One coherent statement.
  3. Nothing else. dv bounded the re-review surface to R1+R2 and
     pre-worded the next signature on that condition — a repair
     confined to the two sentences makes the re-countersign
     clerical. If you conclude the repair genuinely cannot be
     confined, say so in the Return log and stop; do not widen
     silently.
  4. Optional, only if you want them in the same commit: ledger
     C-43 (requirements.md §12 `error_ip_bad_header` third
     disjunct), C-44 (your §6.3 item 4 / §10 REQ-603 justification
     de-overclaim), C-45 (idle-injection prohibition lane-0
     over-breadth), C-46 (REQ-810 verification-column scope). dv
     explicitly does not require them here.
  - Journal next id in your sequence; Files-in-this-commit exact.
- **Out of scope**: everything WO-0029 already landed (endorsed in
  terms — do not re-touch); libs/**, test/**, tools/**; committing.
## Task
Two sentences stand between the M03 rulings and force. dv has
already agreed to everything else in your commit.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-03T06:35Z (spawn `WO-0031/2026-08-03T05:45Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-architect_docs_lead-0012`
- **Derived from**: the WO-0030 Return log (`J-dv_lead-0015` at `0a5ce45`) §2 and
  §5's SPEC-M03 block in full; SPEC-M03 as revised at `541ea43` — §6.1's
  multi-event paragraph and its `m + 3` formula, §6.2's `Preamble`/`Frame` rows,
  §6.3 items 5 and 8, §7's latency table (h, **L**, ΔC), §9's rows and closure
  list, §10's REQ-016/REQ-102/REQ-109/REQ-110 hooks, §11.5/§11.6, §13;
  requirements.md §0.6 (the strobe-timing window and the C-23 counting
  convention), REQ-102, REQ-105, REQ-107, REQ-110, REQ-016. **`libs/**`,
  `test/**` and `tools/**` were not opened** except to run `tools/dv_checks.sh`
  unchanged; no file outside `docs/specs/modules/xgmii_rx_64.md`,
  this packet and my journal was written.

#### 0. Verdict

**Both defects repaired, and the repair is confined to R1 + R2.** Two sentences
in, two statements out; no other sentence of SPEC-M03 moves, no requirement
moves, no ADR is owed, no other document is touched, and none of C-43 … C-46 is
taken. dv's §5 pre-worded re-countersignature applies as written.

The two defects turned out to be **one defect and its shadow**, exactly as dv
said: R2's gloss was the only thing in the specification that appeared to derive
a report cycle for a frame with no output word, so R1 could not state cycles
until R2's sentence stopped naming two. R2 is therefore answered first below.

#### 1. M03-R2 — the gloss is withdrawn, and it could not have been the rule

§9's sentence carried a **rule** ("two cycles after the input word carrying the
character that ended the frame") and an **appositive gloss** ("the cycle on
which that frame's `tlast` word would have been emitted"). dv proved they name
different cycles whenever the ending character lies in the frame's own start
word. The repair keeps the rule and withdraws the gloss, and the ground is not a
preference between two readings — the gloss **cannot be a rule at all**:

1. A frame that delivers no octet has **no octet** for §7's per-octet constant to
   delay, so there is no `tlast` cycle of its own for the phrase to name. The
   phrase has no referent for precisely the frames it governs.
2. The only thing that made it look defined is §6.1's `m + 3` formula, which
   would put a would-be output word 0 at **start word + 3**. That formula is
   **qualified to a gapless stimulus** (C-14.4, `J-architect_docs_lead-0005`),
   and §10's REQ-016 hook commissions idle injection against this module at 0, 1
   and 7 cycles. Reading the gloss as the rule would leave a strobe cycle
   **unpinned on a stimulus this specification itself commissions** — which is
   the thing §6.3 item 5 exists to refuse ("a one-cycle pulse whose cycle is
   unconstrained is a pulse a bench must search for").

So this is C-18's shape once more: a rule that was never in doubt, glossed
wrongly in one place. **ADR: none**, and the §13 row states that ground rather
than the disposition alone.

**One family beyond dv's characterisation, in the same sentence, stated because
a repair that fixed only dv's direction would still be false.** dv named the
`m + 3`-is-later direction (ending character in the frame's own start word).
The disagreement also runs the other way, in exactly one case: a **lane-4**-started
frame whose terminate character is in **lane 0 of the second word after its start
word** — four octets received, none delivered, §9's sixth row — where the rule
gives start word + 4 and `m + 3` gives start word + 3. Enumerating the
no-output-word frames closes it: the ending character lies in the start word S
(differ, `m + 3` later), in S + 1 (**agree**), or — only in that one lane-4
runt — in S + 2 (differ, `m + 3` earlier). Nothing reaches S + 3.

**Checked against requirements.md §0.6's window**, since the sentence claims it:
the rule's latest cycle is that same four-octet case, S + 4, and §0.6's bound is
the module's latency in cycles after the input word carrying the frame's last
octet — that octet is at lane 7 of S + 1 and ΔC = 3, so the bound is S + 4. It
sits **at the far edge and inside**. The §9 text now says so, so the next reader
does not have to redo it.

#### 2. M03-R1 — the cycles are stated, as a table, with the derivation

The false clause is gone; §6.1's consequence 1 now states every cycle. The
derivation is §7's per-octet constant, not `m + 3`, which matters twice: it is
what makes A's start lane the discriminator, and it is what makes the table hold
on a **gapped** stimulus.

- An output word leaves **two** cycles after the input word carrying its last
  octet when its frame began at lane 0 (L = 16), and **two or one** when its
  frame began at lane 4 (L = 12), according as that octet lies in lanes 4 … 7 or
  0 … 3. (`U + ⌊(k + L)/8⌋` for an octet at lane k of word U.)
- A start character in lane 0 of W leaves the aborted frame's last octet at lane
  7 of the word before W — both L values give **W + 1**. A start character in
  lane 4 leaves it at lane 3 of W itself (REQ-110's lane rule) — L = 16 gives
  **W + 2**, L = 12 gives **W + 1**.
- The new frame emits no output word and its ending character is in W, so §9's
  repaired rule pins it at **W + 2**, always; a zero-delivered aborted frame is
  pinned by the same clause, also at W + 2.

**The landed table is dv's table, row for row**, with dv's minimal witness kept
in the text. Two things are added that a bench needs and neither of us had
written down: the coinciding strobes **always** carry different names
(`error_start_without_terminate` against `error_runt`/`error_bad_frame`), so
§6.3 item 8 has **no instance** in this consequence and every coincidence is
fully observable; and the two lane-0-`/S/` rows are the only ones whose cycle
depends on the word before W carrying the aborted frame's last octet, so REQ-016
idle injection there moves that report **earlier** — further from the new
frame's report, never onto it. The `yes`/`no` column is therefore
injection-proof as well as gap-proof.

**One thing for dv to note, not a request.** dv's **table** is right and the
landed text follows it. dv's **prose** summary of it — "three of the four
sub-cases", and "one cycle apart only for a **lane-0** `/S/` aborting a frame
that delivered at least one octet" — generalises the bolded row (lane-4 `/S/`,
lane-0-started A, coincides) over the row below it (lane-4 `/S/`, **lane-4**-started
A, does **not** coincide, W + 1 against W + 2): the discriminator in the lane-4
case is the **aborted frame's own** start lane, through L. Of the six
combinations, three coincide. That prose is in the transcribed gate block, which
is a verbatim record of dv's verdict and is not mine to edit and not proposed
for edit; `AP-xgmii_rx_64.md` §4.N, where dv reproduces the table, is where the
correction would cost nothing if dv agrees.

#### 3. Bounded — what was deliberately not done

- **C-43 … C-46 not taken.** Each is one cell, each is gated at an `SO-` packet
  or at this commit, and each sits in text dv **signed** (C-43, C-46:
  requirements.md; C-44: SPEC-M14; C-45: SPEC-M03 §6.1's idle-injection
  sentence and §10's REQ-016 hook). Taking any of them would put a signed
  surface back in front of dv and make the pre-worded re-countersignature
  non-clerical, and §11.4's own rule says a flip-invariant diff buys nothing by
  being taken early. **C-45 is the one the ledger gates *here*** — "the SPEC-M03
  R1/R2 repair commit, or `SO-xgmii_rx_64.md`" — and it is deliberately deferred
  to the second gate: the wrapper honours the constraint as written, the cost is
  one injection point, and the bounded signature is worth more than one cell
  landed an activation early. All four carry unchanged.
- **§10, §6.2, §6.3, §4.3 untouched**; no hook gains a pointer to the new table
  (the coverage of the case is `AP-xgmii_rx_64.md`'s M03-N2 conversion, not
  mine). §12 untouched: no re-countersignature exists yet to record.
- **§9's rows 8 and 9 untouched**, though the pair leaves a hairline gap — a
  `/S/` aborting a frame that is past its eighth preamble position with zero
  delivered octets satisfies neither row's condition text literally (row 8 needs
  ≥ 1 delivered, row 9 says "still inside its own preamble"). It is pre-existing,
  it is not R1 or R2, and **nothing in this repair rests on it**: that frame has
  no output word and its ending character is in S + 1, where the rule and the
  withdrawn gloss agreed anyway. Recorded here rather than fixed, for dv to price
  as a ledger row if it agrees it is one.
- No ADR, no requirements.md diff, no `traceability.md` diff (no REQ's owning
  module or spec-section cell moves), no attack-plan or gate edit.

#### 4. For dv_lead

The re-review surface is **§6.1's consequence 1** and **§9's "Strobe cycle,
pinned"** paragraph, plus the **one new §13 row** that records them. Nothing
else in SPEC-M03 differs from `541ea43`, which `git diff 541ea43 -- docs/specs/`
shows in one hunk pair. If the two statements hold, dv's §5 pre-worded sentence
is the whole of the next signature; if either does not, the defect is named and I
repair again on the same surface.

#### 5. For the orchestrator

1. Stage exactly the two paths in `J-architect_docs_lead-0012`'s
   Files-in-this-commit; flip this packet's header `State:` line.
2. Route to dv_lead for the SPEC-M03 re-countersignature at the repair SHA
   (WO-0030 §5's pre-worded block, with `<SHA>` and `J-dv_lead-00NN` filled).
3. WO-0032 (the M03 RTL conformance packet) is unaffected: neither repaired
   sentence touches REQ-102, REQ-110 or §10's hooks, which is what dv's §7 item 4
   already said.
4. `git commit` / `git push`: never run by me.
