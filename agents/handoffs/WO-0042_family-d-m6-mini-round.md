# WO-0042: Family D mini-round — one seeded defect, the latched abort bit

- **State**: DRAFT (id is a placeholder — orchestrator allocates)
- **From** / **To**: dv_lead → auditor (via orchestrator; *Summarizable*, with
  the restriction in §0)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §9's condition table and
  its closure list, §6.2's state table; `docs/specs/requirements.md` REQ-007,
  REQ-013, REQ-104, REQ-105, REQ-107, REQ-108, REQ-009.
- **Subject under test**: **not M03.** Whether family D's two-frame row has
  teeth against the one defect class it still declares and nothing has yet
  exercised.
- **Base SHA**: **`447d11c`** — the same base as WO-0041's five. Verified:
  `git diff 447d11c HEAD -- test/xgmii_rx_64/` is **empty**, so the bench is
  byte-identical and this round's result is directly comparable with the
  previous five, on a control already proven green twice.

## 0. Why this is a separate packet, and the one bar that is new

`agents/handoffs/WO-0041_family-d-mutation-campaign.md` — the packet the
previous five were briefed from — **is now barred**, and this packet exists
because of that. After the campaign was adjudicated, that file gained the
verdict, and the verdict states this round's predicted kill in plain words. A
seeder briefed from it would read the answer.

That is the side-channel rule this programme adopted at `J-dv_lead-0040`
working exactly as intended, on a leak I created myself one commit after
writing the rule. The bar is item 9 below; everything else stands unchanged.

## 1. Standing bars — nine, of which one is new

**Do not read, for this round's duration:**

1. `test/xgmii_rx_64/**` — the bench under test.
2. `test/attack_plans/AP-xgmii_rx_64.md`.
3. `agents/handoffs/WO-0040_tb-m03-family-d-fcs.md`.
4. `agents/handoffs/WO-0039_m03-mutation-campaign.md`.
5. `agents/handoffs/WO-0039_m03-mutation-campaign-SEALED-predictions.md`.
6. `agents/handoffs/WO-0041_family-d-mutation-campaign-SEALED-predictions.md` —
   which now also carries **this** round's sealed prediction.
7. `agents/journals/claude_dv_lead_agent.md` — whole file, task-scoped. Nothing
   in this task needs it; if you believe you need an entry, **ask through the
   orchestrator rather than read**.
8. `agents/journals/workers/claude_tb_writer_agent.md`.
9. **NEW — `agents/handoffs/WO-0041_family-d-mutation-campaign.md`.** It was
   your brief last round and it is barred this round: the adjudication appended
   to it names this round's predicted kill, the twelve bench units, and the exact
   failure messages of the previous five.

**Process bars:**

10. Author the diff before it is run.
11. Do not revise it after seeing any run result. Sole exception: a diff that
    fails to *compile* — repair it to compile, change nothing else, and disclose
    the repair.

**Disclosure:** your journal `Inputs` must list what you read and state whether
you had previously read items 3–9. **Item 9 you have read** — it was last
round's brief, before the adjudication was appended to it. That prior read is
**known, expected and not a disqualification**; what is barred is reading it
*now*, in its current state.

## 2. The mutation intent — D-M6, the latched abort bit

**Intent.** `tuser`[0]'s value becomes **sticky across frames**: once M03 sets
it on some frame's `tlast` word, every *subsequent* frame's `tlast` word carries
it set too, whether or not that later frame is itself invalid. The bit latches
and is never cleared between frames.

**What decides the bit is untouched.** `tuser`[0] means "this frame was found
invalid" (REQ-013) and is the **disjunction** of independent conditions —
REQ-104's FCS verdict, REQ-107's runt, REQ-105's error character, REQ-108's
oversize. **Every one of those must keep contributing exactly as it does
today.** This mutation does not change *which* frames are found invalid; it
changes only that the resulting bit, once raised, stays raised on the frames
that follow.

**The strobes DO NOT move with it — this is the precision that matters most
here.** Per this programme's standing rule that a mutation intent is never a
licence to break a second spec rule: §9 makes each strobe a **per-frame report
of that frame's own condition**, and REQ-008's no-silent-discard structure
depends on it. A latched `tuser`[0] must leave `error_bad_fcs`, `error_runt`,
`error_bad_frame` and `error_oversize` **each pulsing exactly when and where
they do today**, on their own pinned cycles, for their own frames. A version
that also latched the reporting path would be a larger, different defect and is
not what is asked for.

**Other constraints.** Delivered octet counts, `tkeep`, `tlast` placement and
all word timing are unchanged. Behaviour under `clear` (REQ-009) is unchanged —
a reset may clear the latch; nothing in this round depends on whether it does.

**A note on footprint, so it is not mistaken for weakness.** Like the previous
round's D-M1, this defect is **invisible to any stimulus that drives a single
frame per simulation** — there is no earlier frame for the bit to latch from. A
correct implementation of this intent will therefore look quiet across most of
what exists. That is the defect class, not a weak diff. **Do not strengthen it
to make it louder.**

## 3. What you produce

A report under `docs/reports/audit/**`: the diff in full, applying cleanly to
`447d11c`; file and function touched; a one-paragraph fidelity argument, which
should say explicitly that the strobe paths were left alone; any compile-only
repair and why; anything you could not do faithfully, said plainly. Plus a scope
statement listing what you read and an explicit line on §1's bars.

**You do not run the diff and you do not see the result.**

## 4. Mechanics and return

Throwaway branch = `447d11c` + this one diff, nothing else; never merged; marked
never-merge with the greppable MUTATION marker. The relay states the parent SHA,
the run id, Build state, and `dune runtest`'s **verbatim** output — the complete
raised message and **the name of every `%expect_test` that failed**.

**A green run is a campaign failure** and must be relayed prominently.

## 5. Pass criteria

1. The suite goes red.
2. Red in the units dv_lead named in advance, **with the expected message**. An
   unnamed unit reddening, or a named unit reddening with the wrong message, is
   a **finding**.
3. The control is green — structural, via the parent-SHA rule.

**Family D's qualification is INCOMPLETE until this round passes**, and
`SO-M03` does not issue on family D before it does.
