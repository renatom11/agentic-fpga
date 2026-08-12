# The Sponsor's Guide

You (Renato) are the program's final authority. Everything else runs itself;
this page is the complete list of what is genuinely yours, written for an
evening check-in, not a process manual.

**Your five standing powers, in one line each** — the rest of this page is the
detail behind them. Every one of them is also listed in `docs/PROCESS.md` §4.7,
and the two lists are meant to say the same thing; if they ever disagree, this
page is the one you actually operate from and the disagreement is a defect worth
reporting.

1. **The six escalation classes** — the only things that may reach you (below).
2. **One-time infrastructure setup** — branch protection (below). Done once.
3. **Canaries** — plant a deliberate violation and see if the auditor catches it
   (below). Standing, optional, never announced.
4. **Ratification of the organization itself** — the founding act no seat inside
   can perform (below). Performed once, at G0.
5. **Candidate-by-candidate refusal at the lessons harvest** — your veto on what
   leaves this program (below). Standing, and the one nobody expects.

## Your to-do list lives in one place

Open [`tasks/BOARD.md`](../tasks/BOARD.md) → **"Pending escalations to
sponsor"**. If that section is empty, nothing needs you. The orchestrator
batches; it does not dribble.

## The six things that can reach you

Every contact from the orchestrator belongs to exactly one class
(anything else is a process violation worth calling out):

| Class | In plain language | Your move |
|---|---|---|
| **E1** | "A phase gate is ready — approve it?" | Read the evidence bundle, approve or ask |
| **E2** | "Scope change proposed" (add/drop a requirement, phase, or role) | Decide |
| **E3** | "Toolchain or licensing decision needed" | Decide |
| **E4** | "The auditor found something CRITICAL" — relayed to you word-for-word, never softened | Read it directly; the orchestrator may not summarize it |
| **E5** | "Two leads deadlocked after one written round" | Break the tie |
| **E6** | "A phase is running >2× its estimate" | Re-scope, accept, or stop |

Every escalation arrives decision-ready: options, a recommendation, and cost.
If one doesn't, bounce it back.

## Your one-time setup duty

**G0 item 9 — branch protection** (exact click-path in
[`docs/gates/G0-checklist.md`](gates/G0-checklist.md)). Until you do this, the
append-only journal guarantee is enforced only by convention: an admin
force-push could rewrite history. Five minutes, once.

## Your standing (optional) power: canaries

You may occasionally plant a deliberate process violation — e.g. hand-edit a
journal line in a commit, or ask the orchestrator to relay an altered packet —
to test whether the auditor catches it. Tell no one in advance, including the
auditor (its charter tells it canaries exist but never when). A missed canary
is a CRITICAL finding against the auditor. This page documents the mechanism:
**no instance is ever announced in advance, and none is discoverable before it
is caught.** Once it *is* caught it becomes a finding like any other and is
documented as one — that route is the whole point of planting it.

*(This line previously ended "never document the instances", which contradicted
the finding route it depends on. Corrected 2026-08-11 on an audit finding, in
the same act as the matching sentence in `docs/PROCESS.md` §1.5.)*

## Your founding act: ratification

The organization cannot vote itself legitimate. **G0 — the founding gate — does
not pass until you sign it**, and no real work order issues before it does. That
signature is the external act that makes every internal one binding, and it is
the reason this seat exists at all: not as a stakeholder, but as the one party
whose approval the program cannot manufacture.

**Status: done.** G0 PASSED 2026-08-01, all eleven checklist items signed,
including the auditor's re-verification that lifted a CRITICAL block. You do not
have to do this again — it is listed here because a complete list of your powers
that omits the one that started the program is not complete, and because if this
org is ever forked or re-founded, this row comes back.

## Your standing power at the export boundary: refusing a lesson

This is the one most people do not expect, and it is the only place in the whole
process where **you can stop something that is correct by every internal check
and simply not wanted outside this program.**

At every module sign-off and every phase gate the org runs a **lessons harvest**
(PROTOCOL §7): each agent mines its own journal for rules worth keeping, the
candidates are screened for portability, and the survivors are collated for
export into the reusable shell repository that other programs pull from.

**Before any of that leaves, you see the collated list, and you may refuse
candidates — one at a time, by name.** You are not asked to accept or reject the
batch. That granularity is the whole point: nobody refuses eleven good rules to
stop one bad one, so a batch-level veto would be a notification wearing a
power's clothes.

**What this looks like in practice.** The harvest is delivered to the shell as a
*proposal* — a pull request against its inbox, not a push into its corpus — so
declining an item costs nothing and reverses nothing. You need no reason and owe
no explanation; "not that one" is a complete answer. Your grounds can be
anything a human has and a process does not: it discloses more than you want
disclosed, it is embarrassing, it is true but not ours to publish, it reads as
advice we should not be giving.

**Where it reaches you.** The same place as everything else — the escalation
section of `tasks/BOARD.md`, at a gate. If a harvest ever lands in the shell
without having passed under your eye, that is a process violation and worth
calling out.

## How to spot-check the org yourself (any time)

- `git log --oneline` — every commit title, one agent each.
- `git log --grep 'Agent: rtl_lead'` — one agent's entire thread.
- `git show <commit>` — any change plus the reasoning that produced it,
  in the same diff. That's the core guarantee; if you ever see a work change
  without its journal entry, the machinery failed — say so.
- [`ORG_CHART.md`](../ORG_CHART.md) → any charter → that agent's journal tail.
- CI tab: `journal-check` must be green on every push.

## What is deliberately NOT yours

Module design choices, test adequacy, work-order routing, bounce/accept
verdicts, and schedule micro-management all stay inside the org — they reach
you only if they escalate into one of the six classes above. If you want to
change how the org itself works, ask the orchestrator for an ADR (protocol
and charters change only that way, PROTOCOL §11).
