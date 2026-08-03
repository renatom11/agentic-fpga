# ADR-0016: a seal is a file in the commit that claims it, or it is not a seal

- **Status**: **PROPOSED** at `J-architect_docs_lead-0018`. **Not accepted.**
  Two things are owed before acceptance: **dv_lead countersigns the rule text**
  (it is dv_lead's rule, and §2 below changes its wording in four places), and
  the **orchestrator accepts**. Nothing in this ADR is in force until then, and
  the PROTOCOL diff in §8 is **written, not applied** — PROTOCOL §11 requires
  the ADR to land first.
- **Deciders**: **orchestrator**, on a process rule. This is deliberately *not*
  an escalation class: it adds no requirement, phase or role (not E2), touches
  no toolchain or licence (not E3), and settles no dispute between leads (not
  E5). Authority for the rule's *content* is dv_lead's, which is why the
  countersignature is a precondition rather than a courtesy — I am the drafter
  and the analyst here, not the author of the finding.
- **Proposed by**: dv_lead, `RV-0049-VERDICT` §1
  (`agents/handoffs/WO-0049_cosim-canon-format-fix.md`), `J-dv_lead-0062`.
- **Work order**: WO-0051 · **Journal**: `J-architect_docs_lead-0018`
- **Affects**: **no frozen spec text, no requirement, no interface record, no
  gate checklist.** It proposes one bullet in `agents/PROTOCOL.md` §10 (§8 below
  carries the exact diff) and, if the advisory check of §6 is adopted, work in
  `scripts/check_journals.sh`, `scripts/agent_commit.sh` and
  `scripts/test_protocol.sh` — all orchestrator-owned, all outside my write
  scope, all requiring their own work order.

---

## 1. Context — what happened, and why nothing could have caught it

`WO-0049` §4 commissioned a sweep of every format directive in
`test/cosim/tb_xgmii_rx_64.v` from tb_writer, and closed the item like this:

> **I have done this sweep myself and I am withholding my result until your
> Return log lands** — the same sealed-prediction discipline `WO-0039`/`WO-0041`
> used for the mutation campaigns. If our sweeps disagree, that disagreement is
> the finding and I would rather discover it than have handed you my answer to
> nod at.

`J-dv_lead-0059` repeated the claim twice more, in Actions (*"And I sealed my
own sweep"*) and in Open-questions.

The sweep came back. dv_lead went to open its own seal and **there was nothing
to open.** `J-dv_lead-0059`'s `Files-in-this-commit` lists exactly one path —
`agents/handoffs/WO-0049_cosim-canon-format-fix.md` — so the commit carrying the
claim carried the packet and the journal append and no sweep. dv_lead refused to
reconstruct it after reading the worker's answer, on its own `RV-0045-VERDICT`
§2 precedent, and recorded the standing consequence: **no packet, verdict or
sign-off may claim that two independent sweeps of `tb_xgmii_rx_64.v` agreed.**

**The property that makes this worth a rule is not that a seal was forgotten.
It is that the forgetting was undetectable from outside.** Every reader of
WO-0049 — the orchestrator relaying it, the worker executing it, the auditor
sampling it — was told by the packet that a seal existed, and none of them had
any artifact to check that against. A claim about a withheld thing is
self-certifying in a way that no other claim in this programme is: a claim about
a test can be run, a claim about a spec can be read, a claim about a commit can
be diffed, and a claim about a thing deliberately not shown can only be
believed. That asymmetry is the defect class, and it is why the repair has to be
structural rather than another restatement of care.

dv_lead's proposed repair, verbatim:

> **A packet may not assert a sealed prediction unless the seal is a file listed
> in that same commit's `Files-in-this-commit`.** A seal that is not a committed
> artefact is not a seal, it is a claim — and this programme already knows what
> a claim about an unexercised thing is worth, because that is what WO-0049 was
> written about.

WO-0051 asks whether that belongs in PROTOCOL, in what words, and whether a
script can check it. My finding is **adopt, with the wording sharpened in four
places, in §10 rather than §3, review-enforced with an advisory script and not a
blocking one.** The reasons are below and every one of them is measured against
this repository's own history rather than argued from principle.

### 1.1 The compliant corpus — five rounds, not four

`RV-0049-VERDICT` §1 names `WO-0039`, `WO-0041`, `WO-0045` and `WO-0050` as the
four real seals. Read straight out of the `Files-in-this-commit` sections of
dv_lead's journal — which is the only evidence the rule itself needs, since the
rule is stated in terms of that section — there are **five**:

| freeze | journal entry | packet in the commit | seal file in the *same* commit |
|---|---|---|---|
| WO-0039, M03 campaign | `J-dv_lead-0035` | `WO-0039_m03-mutation-campaign.md` | **yes** — `WO-0039_…-SEALED-predictions.md` |
| WO-0041, family D | `J-dv_lead-0041` | `WO-0041_family-d-mutation-campaign.md` | **yes** — `WO-0041_…-SEALED-predictions.md` |
| WO-0042, D-M6 mini-round | `J-dv_lead-0045` | `WO-0042_family-d-m6-mini-round.md` | **yes** — but it is **`WO-0041`'s** seal file, appended to |
| WO-0045, family E | `J-dv_lead-0051` | `WO-0045_family-e-mutation-campaign.md` | **yes** — `WO-0045_…-SEALED-predictions.md` |
| WO-0050, family F | `J-dv_lead-0061` | `WO-0050_family-f-mutation-campaign.md` | **yes** — `WO-0050_…-SEALED-predictions.md` |
| **WO-0049, the sweep** | **`J-dv_lead-0059`** | `WO-0049_cosim-canon-format-fix.md` | **NO — the counterexample** |

The fifth row is the one that matters for anything mechanical. `WO-0042` §0 item
6 says of the WO-0041 seal file, *"which now also carries **this** round's sealed
prediction"* — so a compliant seal is **not** necessarily a new file, and its
name **need not** correspond to the work order asserting it. Any check that
looks for "a newly added `WO-<this number>-SEALED-*.md`" reports the D-M6 round
as a violation. It is not one. This constraint is invisible from the four rounds
dv_lead enumerated and is the single most useful thing the corpus scan produced.

---

## 2. The rule as proposed, and the rule as I propose to adopt it

### 2.1 Defect 1 — the wording is a property of a file, re-evaluated at every commit that touches it

"A packet may not assert…" describes the *state of a document*. A packet asserts
a seal for as long as the sentence stays in it, and packets are appended to for
weeks after a freeze: Return logs, rulings, verdicts, closures. So every later
commit touching a seal-asserting packet re-asserts the seal, and almost none of
them re-stage the seal file — correctly, because the seal was frozen once and
must not be touched again.

Measured against this programme's own record, taking every commit whose
`Files-in-this-commit` includes a packet that contains seal language:

| entry | staged | seal file staged? | is it actually a violation? |
|---|---|---|---|
| `J-dv_lead-0035` | WO-0039 packet + seal | yes | — passes |
| `J-dv_lead-0036` | WO-0039 packet + seal (unsealing) | yes | — passes |
| `J-dv_lead-0037` | WO-0039 packet, AP, a test | **no** | **no — closure prose** |
| `J-dv_lead-0041` | WO-0041 packet + seal | yes | — passes |
| `J-dv_lead-0043` | WO-0041 packet | **no** | **no — pre-result rulings** |
| `J-dv_lead-0044` | WO-0041 packet + seal + AP | yes | — passes |
| `J-dv_lead-0045` | WO-0042 packet + WO-0041 seal | yes | — passes |
| `J-dv_lead-0046` | WO-0042 packet | **no** | **no — an arming ruling** |
| `J-dv_lead-0047` | WO-0042 packet + AP | **no** | **no — scoring after the kill** |
| `J-dv_lead-0048` | WO-0043 + WO-0044 packets | **no** | **no — a forward commitment** |
| `J-dv_lead-0051` | WO-0045 packet + seal | yes | — passes |
| `J-dv_lead-0053` | WO-0045 packet | **no** | **no — pre-result rulings** |
| `J-dv_lead-0054` | WO-0045 packet + AP | **no** | **no — scoring** |
| **`J-dv_lead-0059`** | **WO-0049 packet** | **no** | **YES — the incident** |
| `J-dv_lead-0061` | WO-0050 packet + seal | yes | — passes |
| `J-dv_lead-0062` | WO-0049 packet (the verdict) | **no** | **no — it *quotes* the claim** |

**Nine commits flagged. Eight of them are correct conduct.** The rule read
literally is wrong about 89% of what it catches, and — this is the part that
decides the enforcement question in §6 — **the last row is `RV-0049-VERDICT`
itself**, the artifact that discovered the problem, flagged because it quotes the
sentence it is convicting.

The repair is one word. The obligation attaches to the commit that **introduces**
the claim, not to every commit that carries the file the claim lives in. This is
almost certainly what dv_lead meant — §1 of the verdict is written about
*authoring* — so I record this as a clarification rather than a correction, but
it must be in the text, because a script and an auditor both read the text and
not the intent.

### 2.2 Defect 2 — "sealed prediction" does not cover the thing that went wrong

WO-0049 §4's withheld artifact was a **sweep of an existing file's format
directives**. It predicted nothing. It was a claim about work already done on a
static artifact, held back so that the worker's independent answer could be
compared against it. Under the phrase "sealed prediction" the rule reaches
WO-0049 only by analogy — and a rule that reaches its own founding counterexample
by analogy will not reach the next variant at all.

The class is not prediction. It is: **the author claims to already hold a result
that the reader is not being shown, and the claim's evidentiary value depends
entirely on that result having existed before the reader's answer did.** Call it
a **withheld-result claim**. It covers, in this programme's actual practice:
frozen mutation kill-matrices (WO-0039/0041/0042/0045/0050), withheld sweeps
(WO-0049 §4), undisclosed mutation→row mappings (WO-0043 §8, WO-0045 §0), sealed
expected-message strings, and any "I will tell you after you answer" device
anyone invents next.

**One exclusion is mandatory, because "seal" is overloaded in this repository.**
`WO-0010` uses it for finalising a decision — *"C-1 | **CLOSED and SEALED** at
this countersignature"*, *"I am sealing this on more than coherence"*. That is a
freeze-a-decision sense: nothing is withheld from anyone, the decision is in the
open in the same document. It must not be bound by this rule, and the rule text
must say so or the first thing the new rule does is flag a countersignature.

### 2.3 Defect 3 — a forward commitment is not a withheld-result claim

`WO-0043` §8 says the family-E row mapping *"is sealed before any diff exists"*
in a packet committed at `J-dv_lead-0048`, three entries before the seal existed
(`J-dv_lead-0051`). That is not a false claim and it is not the WO-0049 shape: it
is a **promise about how a future campaign will be run**, and the worker cannot
and does not rely on a seal existing at that moment. Binding it would make it
impossible to commission a campaign before freezing it, which is backwards —
the packet naming the defect classes has to reach the worker before the seal
against its bench can be frozen.

The distinction is tense and it is load-bearing: *"I have sealed / I hold / I am
withholding"* is bound; *"will be sealed before any diff exists"* is not. The
promise is redeemed by the later commit that freezes the seal, and **that**
commit is bound. WO-0043 §8's present-tense passive sits exactly on the line, so
the ADR carries a drafting note (§9) rather than pretending the boundary is
crisp in every sentence.

### 2.4 Defect 4 — "a packet" leaves the journal half of the failure uncovered

The WO-0049 claim was made **three times in one commit**: once in the packet and
twice in `J-dv_lead-0059`. Under "a packet may not assert", the two journal
assertions are unbound — yet they are the more durable record, they are what
`git log` surfaces, and they are append-only and therefore *harder* to walk back
than the packet. Widening the subject from "a packet" to "a committed artifact"
costs nothing (R2 forces the journal into the same commit anyway, so the same
commit-membership test settles both) and closes a hole that the founding
incident actually walked through.

### 2.5 The text I propose

Normative core, one sentence, with dv_lead's own consequence line kept verbatim
because it is the better sentence and because it is dv_lead's:

> **R-SEAL-1 — a seal is a file, not a sentence.** A commit may not **introduce**
> a claim that a result already exists and is being withheld from the reader — a
> sealed prediction, a sealed sweep, an undisclosed mapping, any "I hold this and
> am not showing you yet" — unless that same commit also stages the artifact
> holding the withheld result, so that the seal appears in the commit's own
> `Files-in-this-commit` list. **A withheld result that is not a committed
> artefact is not a seal, it is a claim.**
>
> Three things this rule does not reach. A **forward commitment** ("the mapping
> will be sealed before any diff exists") is a promise, redeemed by the later
> commit that freezes the seal, which is itself bound. A **retrospective
> reference** to a seal already in history ("the mutation died where the seal
> said it would"), including quoting the claim in order to convict it, is not a
> new claim. And **sealing in the finalise-a-decision sense** (a countersignature
> "CLOSED and SEALED") withholds nothing and is outside the rule entirely.

Side-by-side with dv_lead's original, the four changes are: `a packet may not
assert` → `a commit may not introduce` (§2.1, §2.4); `a sealed prediction` → `a
claim that a result already exists and is being withheld` (§2.2); `the seal is a
file listed in` → `that same commit also stages the artifact … so that the seal
appears in` (same test, stated as the act rather than the state, which is what a
script and an author both need); plus the three exclusions, which are new (§2.2,
§2.3).

**What the rule buys, stated exactly, because it is narrower than it looks.** It
makes a seal claim **non-backdatable relative to the claim itself**: the seal is
at least as old as the sentence asserting it, provably, from one commit. It does
**not** establish that the seal predates the *thing it seals against* — that is
an ordering question between the freeze commit and the mutation/answer commits,
it is already provable from SHAs, and it stays the auditor's check. It does
**not** establish that the seal was not edited afterwards (§7.2). And it does not
make a seal *good* (§7.1). It converts one unfalsifiable claim into a countable
one. That is the whole of it, and overclaiming here would be the same defect in a
different costume.

---

## 3. Decision

- **D1.** Adopt R-SEAL-1 in the §2.5 wording, subject to dv_lead's
  countersignature of the text.
- **D2.** It lives in **PROTOCOL §10 (Independence & evidence rules)**, not §3.
  Reasoning in §5.
- **D3.** It is **review-enforced**, with an **advisory** mechanical aid. It does
  **not** become R10 and `agent_commit.sh` does **not** refuse a commit for it.
  Reasoning in §5 and §6.
- **D4.** The rule carries **no content requirement** on the seal file. Vacuity
  is caught at adjudication and by audit sampling, under the standard that
  already exists in this programme; the seal-file header convention of §7.1 is
  recorded as convention, not as a rule.
- **D5.** The `R-SEAL-n` identifier namespace is minted here for
  evidence/independence rules that are **review-enforced**, in the same house
  style as ADR-0015's `R-CI-n`, and deliberately distinct from PROTOCOL §5's
  `R1`–`R9`, which are exactly the machine-enforced set.

---

## 4. Scope — what the rule catches, checked against the corpus

WO-0051 asks specifically whether "sealed prediction" covers only campaign seals
or any withheld-result claim, since WO-0049 §4 was the latter. Answer: as written
by dv_lead it covers campaign seals cleanly and WO-0049 only by analogy; the §2.5
wording covers both by construction. Applied to every withheld-result device this
programme has actually used:

| device | where | caught by dv's text? | caught by §2.5? |
|---|---|---|---|
| frozen mutation kill-matrix | WO-0039/0041/0045/0050 seals | yes | yes |
| a mini-round's prediction appended to an older seal file | WO-0042 → WO-0041's seal | yes | yes — the file is in the list, which is what the test asks |
| withheld sweep of an existing file | **WO-0049 §4** | by analogy only | **yes** |
| undisclosed mutation→row mapping | WO-0043 §8, WO-0045 §0 | ambiguous (a promise, not a held result) | **no, by the §2.3 exclusion — correctly** |
| sealed expected-message strings | WO-0041/0042 | yes | yes |
| "CLOSED and SEALED" decision freeze | WO-0010 C-1 | **yes — a false positive** | **no, by the §2.2 exclusion** |
| withholding a *signature* pending repair | `J-dv_lead-0033` region | ambiguous | no — nothing is hidden from the reader |

The two rows where the wordings differ in both directions are the argument for
the change: dv's text misses its own founding counterexample's category and
catches a countersignature that has nothing to do with it.

---

## 5. Where it lives, and why it is not R10

**Not §3.** PROTOCOL §3 is the packet chapter: types, who writes and consumes
each, relay class, lifecycle states, numbering. Every rule in it is about the
*transport*. R-SEAL-1 is about what makes a piece of evidence admissible, and
after §2.4 its subject is any committed artifact — packet, journal entry,
verdict, report — which no longer fits a chapter framed around packet types.

**§10, "Independence & evidence rules."** Read what is already there: DV derives
tests from specs and never from RTL; golden models must agree with an external
anchor before they may judge; the auditor owns the DV-escape ledger; mutation
manifests are applied transiently and the campaign is blinded. Every one of those
exists to stop a result being shaped by knowledge the author should not have had
yet. **A seal is that same device pointed at the author's own answer** — it
exists so a prediction cannot be authored after the outcome. §10 is not a
convenient home, it is the correct one, and R-SEAL-1 sits most naturally
immediately after the mutation-discipline bullet, whose blinding rules it
generalises.

**Not R10.** PROTOCOL §5's `R1`–`R9` are the set `agent_commit.sh` enforces
before a commit exists, and §5 is unusually careful about that: R1 carries an
explicit *Honesty note* conceding that one-agent-per-commit is emergent for
scoped agents and audit-enforced for the orchestrator, and §6 says of the
tb_writer read bar that it is "honestly documented as such". The R-namespace
means *the script refuses this*. Adding a rule the script does not refuse would
make R10 the first R-number that is a wish, and every later reader would have to
learn which R-numbers are real. `R-SEAL-1` in §10, with its enforcement class
stated in the same sentence, keeps that boundary intact. ADR-0015 already
established the precedent for a namespaced, ADR-minted rule id (`R-CI-1` …
`R-CI-8`).

---

## 6. Enforceability — what a script can and cannot do

**Finding: review-enforced, with an advisory warning in `scripts/check_journals.sh`
(and, optionally, the same warning in `scripts/agent_commit.sh`). Not a blocking
gate, in either script, at this time.**

### 6.1 The mechanical half is trivial; the detection half is not

Both scripts already hold everything the *test* needs. `agent_commit.sh` builds
`WORK_PATHS[]` from `git diff --cached --name-status` (:52-70) and can read any
staged blob with `git show ":$path"`. `check_journals.sh` builds
`$TMP/work_paths` per commit (:91-113) and has `$PARENT` (:80-86), so the added
lines of a commit are one `git diff-tree -p` away. Given a set of paths and a set
of added lines, "does any staged path look like a seal" is a one-line `grep`.

The hard half is the antecedent: **deciding whether an added line asserts a
withheld result.** That is a judgement about prose, and the corpus says how hard
it is. Over `agents/handoffs/` and `agents/journals/`, **more than 400 lines**
contain the vocabulary (`seal|sealed|sealing|seals|withheld|withholding`) — 201
in dv_lead's journal alone. Almost all of them are retrospective, quotational, or
the WO-0010 decision sense.

### 6.2 The two-stage filter, and what it measures

Stage 1 is the vocabulary. Stage 2 requires a **first-person present or perfect
holding claim on the same line**, which is what separates "I hold this" from
"the seal said it would":

```bash
SEAL_S1='(seal(ed|s|ing)?|withh(eld|olding))'
SEAL_S2="(\b(I|we)('ve|'m)?[[:space:]]+(have|am|had|already|seal|sealed|froze|frozen|hold|withheld|withholding|did|ran|done)\b|\bmy[[:space:]]+(own[[:space:]]+)?(seal|sweep|prediction|result|answer|mapping)\b)"
```

Run over the whole of `agents/` at this SHA — a deliberately harsher test than
the real check, which sees only one commit's added lines:

- **over 400 lines** match Stage 1;
- **22 lines** match both stages;
- **2 of those 22 are the incident** — `WO-0049_cosim-canon-format-fix.md:194`
  (*"I have done this sweep myself and I am withholding my result…"*) and
  `claude_dv_lead_agent.md:14993` (*"And I sealed my own sweep"*, inside
  `J-dv_lead-0059`) — and **both sit in the same commit**, which is the
  granularity the check reports at. **Commit-level recall on the one known
  incident: 1 of 1.**
- The `J-dv_lead-0059` Open-questions repetition is **missed**: it says a
  disagreement between the two sweeps would be the finding, without using the
  vocabulary. Line-level recall is therefore 2 of 3. This is stated because it is
  the honest measure of what a regex over prose is worth.
- The remaining 20 are false positives of exactly three shapes: quotations of the
  §4 sentence inside `RV-0049-VERDICT` and `J-dv_lead-0062`; WO-0010's
  decision-sense "I am sealing this on more than coherence"; and ordinary
  retrospect ("I did not touch the sealed file", "the delivered-octet message I
  sealed is unreachable").

Restricting to a commit's **added** lines does not reduce that set — every line
was added by exactly one commit — but it changes the arithmetic that matters: a
claim is examined **once, at the commit that introduces it**, instead of
re-examined on every later commit that touches the file. Over ~242 commits (one
journal entry per commit, 242 entry headers across all journals at this SHA)
the check fires on roughly a dozen, one of which is real.

### 6.3 Why advisory, and why that is not timidity

One measured fact settles it. **The check fires on the commit carrying
`RV-0049-VERDICT`** — the artifact that found the missing seal — because that
verdict quotes the claim in order to convict it. A blocking form of this rule
would have refused the commit that discovered the defect the rule exists to
prevent. There is no regex that distinguishes a quotation from an assertion, and
a gate that cannot tell a confession from a crime must not be a gate.

Three further reasons, in descending weight:

1. **The rule's own exclusions are semantic and the script's test is lexical.**
   §2.5 correctly exempts quotations, retrospect and forward commitments; the
   regex cannot see any of those three distinctions. The gap between rule and
   check is therefore permanent, not a matter of a better pattern, and the honest
   response is to let the human close it — which is precisely PROTOCOL §4.1's
   existing settlement, where structure is machine-checked and narrative is
   auditor-sampled. R-SEAL-1 is a narrative property.
2. **`agent_commit.sh` refusals are hard stops for the sole committer.** Every
   false positive costs a round trip through the one agent that can commit, and
   at roughly 1-in-12 precision the gate would train its only user to route
   around it.
3. **The actual failure mode was inattention, not evasion.** dv_lead believed it
   had sealed. A tripwire aimed at the inattentive is the right instrument; it
   does not need to be, and cannot be, proof against an author who decides to
   phrase around it. A blocking gate would imply a guarantee the mechanism does
   not have — the same overclaiming this ADR exists to punish.

### 6.4 The check, written against the real scripts

For `check_journals.sh`, inside the per-commit loop after `$TMP/work_paths` is
built (:113) and before or after R4 — order does not matter, it never fails:

```bash
  # R-SEAL-1 (ADR-0016) — ADVISORY. A commit that INTRODUCES a withheld-result
  # claim should stage the seal in the same commit. Warns; never fails unless
  # STRICT_SEALS=1. Precision is ~1-in-12 by design (quotations and retrospect
  # cannot be distinguished lexically) — see ADR-0016 §6.
  if [ -n "$PARENT" ]; then
    git diff-tree -p --no-renames "$PARENT" "$C" -- 'agents/handoffs/' 'agents/journals/' \
      | grep -E '^\+' | grep -v '^\+\+\+' > "$TMP/added" || true
  else
    : > "$TMP/added"
  fi
  if grep -iE "$SEAL_S1" "$TMP/added" 2>/dev/null | grep -qiE "$SEAL_S2"; then
    if ! grep -qE '[^/]*SEALED[^/]*\.md$' "$TMP/work_paths"; then
      echo "WARN-SEAL: $short introduces a withheld-result claim but stages no seal file (R-SEAL-1, ADR-0016)" >&2
      grep -iE "$SEAL_S1" "$TMP/added" | grep -iE "$SEAL_S2" | head -3 >&2
      if [ "${STRICT_SEALS:-0}" = "1" ]; then
        fail "$short: withheld-result claim without a seal in the same commit (R-SEAL-1)"
      fi
    fi
  fi
```

**This block was executed, not just written.** Run standalone under
`set -euo pipefail` against four fixtures: WO-0049 §4's sentence with a
non-seal staged set → warns; the same sentence with
`WO-0041_family-d-mutation-campaign-SEALED-predictions.md` in the staged set →
silent, which is the D-M6 case of §1.1 passing; *"the mutation died where the
seal said it would"* → silent; *"that mapping is sealed before any diff
exists"* → silent. The script reached its end in every case, which is the fourth
note below.

Four implementation notes, each derived from something in this analysis rather
than from taste:

- **The seal test is `*SEALED*.md` anywhere in the staged set — no work-order
  correspondence.** §1.1's fifth row is why: WO-0042's seal is an append to
  `WO-0041_…-SEALED-predictions.md`. A check keyed on the asserting packet's own
  number reports that compliant round as a violation.
- **`if [ … ]; then fail; fi`, never `[ … ] && fail`.** Both scripts run
  `set -euo pipefail`; a bare `[ … ] && …` whose test is false returns 1 and
  kills the script on the compliant path — the check would then fail *only* the
  commits it approves of.
- **The grep pair is `grep | grep -q`, not one pattern.** Stage 2 must apply to
  lines Stage 1 already matched; a single alternation would fire on any
  first-person sentence anywhere in the diff.
- **It warns to stderr and does not touch the exit code.** `check_journals.sh`'s
  contract is "exits nonzero on the first violating commit"; R-SEAL-1 is not a
  violation of the commit protocol and must not be reported as one. CI surfaces
  the line; `STRICT_SEALS=1` exists so the blocking form can be tried on a range
  later without another ADR.

The same block, minus `$PARENT`/`$C` (use `git diff --cached -U0` and
`WORK_PATHS[]`), belongs in `agent_commit.sh` as a warning **printed before the
commit is created and not gating it** — that is where the author is still in the
room and can fix it in ten seconds. This is the higher-value of the two
placements and the one I would implement first.

### 6.5 PROTOCOL §11(3)

§11 requires an updated `scripts/test_protocol.sh` case when a change "alters
enforcement semantics". An advisory warning arguably does not, and I decline the
loophole: if the orchestrator adopts §6.4, the test case is owed and is cheap —
**(a)** a commit introducing a seal claim with no seal file emits `WARN-SEAL` and
exits **0**; **(b)** the same under `STRICT_SEALS=1` exits nonzero; **(c)** a
commit staging `WO-0041_…-SEALED-predictions.md` alongside a *WO-0042* packet
emits **no** warning — case (c) is the D-M6 regression test and is the one that
will actually catch a future "simplification" of the path pattern.

---

## 7. Failure modes

### 7.1 An empty or vacuous seal file — and the incentive this rule creates

**The rule can be satisfied by `touch`.** A one-byte `WO-XXXX-SEALED.md` staged
alongside the claim passes every mechanical form of R-SEAL-1, and the rule
*creates* the incentive to write one, because before today there was no gate to
game. That has to be said in the ADR rather than discovered later.

**It does not need a content requirement, for two reasons.**

First, **adjudication already catches it, and there is a stated standard.** A
seal exists to be scored: WO-0039's was scored at `RV-0039-VERDICT`, WO-0041's at
`J-dv_lead-0044` where it was falsified and left standing, WO-0042's at
`J-dv_lead-0047`. A seal that does not *select* among outcomes cannot be scored,
and the scoring packet is where that becomes visible — to dv_lead first, and to
the auditor sampling it. The standard is already in this programme's own words,
from `J-dv_lead-0033`: a prediction worth having is *"a written-down prediction
that selects exactly two of twenty entries"*. Discriminating power, not length.
An empty seal fails that at the first attempt to score it, in front of the one
agent who cannot pretend otherwise, because the whole point of the round is the
comparison.

Second, **a content requirement would poison the one property the rule has.**
R-SEAL-1's value is that it is uncontestable: a path is in a list or it is not.
The moment it also requires the seal to be *good*, it acquires an argument, and —
worse — passing it starts to look like a quality verdict. The rule is a floor:
**it makes seals countable, not good.** Anyone reading a green check as evidence
that a seal was worth sealing has made the WO-0049 error one level up.

**Recorded as convention, not as rule**: all five real seals already share a
header — `State`, `Frozen against` (the SHA, with WO-0050 naming the CI run that
executed it), `Frozen by` (the journal entry, *"before any diff existed"*), and a
pointer to the second copy or companion. A file carrying those four fields cannot
be literally empty, and `Frozen against` is the field the auditor's ordering check
consumes. I recommend seal authors keep it. I do **not** propose to require it:
requiring a header is one grep away from believing the header is the seal.

### 7.2 A seal committed and then edited to fit the result

R-SEAL-1 secures **existence at the time of the claim**, not immutability.
Nothing in it stops a seal being rewritten a week later.

Two defences already exist and neither is mine to change. `git diff <freeze-SHA>
HEAD -- <seal>` is decisive, and WO-0039's seal says so in its own header —
*"This state line is the only line of this file that has been altered since the
freeze … `git diff` against the freeze commit is the check."* And the **second
copy in the journal**: WO-0039's seal §0 (*"Integrity note — why this is written
twice"*) argues that two independent append-only copies are not redundancy,
because *"if either is later edited to fit a result, the other exposes it"*, and
WO-0050's seal carries a `Second copy` field naming `J-dv_lead-0061`. The journal
copy is protected by R3 in a way the packet file is not.

**I considered folding the second copy into R-SEAL-1 and decided against it.** It
is a content requirement in disguise (nothing mechanical can check that a journal
entry contains the seal's *substance*), R2 already forces a journal append into
the same commit so the hook exists whenever anyone wants it, and the immutability
question is genuinely separate from the existence question this ADR was asked to
settle. Recorded here as the practice to keep, and named in §10 as a candidate
for its own rule if a seal ever *is* found edited.

### 7.3 A seal authored after the answer but committed in one commit

R-SEAL-1 cannot see authoring order inside a working tree. In the WO-0049 shape
this is closed for free — the worker's answer does not exist yet — but for a
campaign seal frozen after a control run it is open, and it stays where it
already lives: the auditor's ordering check against SHAs, and the blinding
allowlist of `WO-0045` §1. The rule is not weakened by this; it simply does not
claim it.

### 7.4 The vocabulary drifts, or an author writes around the warning

Recall degrades if authors stop using the words. The mitigations are that the
warning is advisory, so there is no incentive to evade it; that the rule binds
the *conduct*, so writing around the regex is a straightforward audit finding
rather than a clever pass; and that the auditor samples narrative anyway
(PROTOCOL §4.1). If the pattern is ever tuned, §6.4's case (c) is the regression
test that must survive the tuning.

---

## 8. The PROTOCOL diff — written, not applied

**Not applied.** PROTOCOL §11 requires the ADR first, `agents/PROTOCOL.md` is
orchestrator-owned (PROTOCOL §6) and outside my write scope, and this ADR is
PROPOSED. This section is the exact text to land **after** acceptance and
dv_lead's countersignature, under `Agent: orchestrator`.

### 8.1 §10 — the new bullet (required)

Inserted between the mutation-discipline bullet and the licensing bullet, at
`agents/PROTOCOL.md:311`:

```diff
   spawned while a manifest is applied; the "report, never repair a suspected
   seeded mutation" clauses in RTL-line charters are the safety net for a
   sequencing error, not the normal case.
+- **R-SEAL-1 — a seal is a file, not a sentence** (ADR-0016). A commit may not
+  **introduce** a claim that a result already exists and is being withheld from
+  the reader — a sealed prediction, a sealed sweep, an undisclosed mapping, any
+  "I hold this and am not showing you yet" — unless that same commit also stages
+  the artifact holding the withheld result, so that the seal appears in the
+  commit's own `Files-in-this-commit` list. **A withheld result that is not a
+  committed artefact is not a seal, it is a claim.** Three things it does not
+  reach: a **forward commitment** ("the mapping will be sealed before any diff
+  exists"), which is a promise redeemed by the later commit that freezes the
+  seal — and that commit is bound; a **retrospective reference** to a seal
+  already in history, including quoting a claim in order to convict it; and
+  sealing in the **finalise-a-decision** sense (a countersignature "CLOSED and
+  SEALED"), which withholds nothing. *Enforcement*: **review-enforced**, like
+  the rest of §10 — it is deliberately **not** an `R1`–`R9` commit rule, because
+  distinguishing a claim from a quotation is not a lexical test. The scripts may
+  emit an advisory `WARN-SEAL`; a warning is not a verdict and its absence is
+  not a clearance. The rule makes seals countable, not good: a vacuous seal
+  passes it and is caught at adjudication, where a prediction that selects
+  nothing cannot be scored.
 - Licensing: `verilog-ethernet` (MIT) may be read and co-simulated freely.
```

### 8.2 §3 — a cross-reference (optional, recommended)

§3 is where a packet author looks. One sentence, appended to the **Packet
numbering** paragraph at `agents/PROTOCOL.md:83`:

```diff
 **Packet numbering**: the orchestrator — as sole committer — allocates the
 next `NNNN` per prefix when a packet is first committed; drafts circulating
 before commit use a placeholder id. This makes monotonic-per-prefix numbering
 enforceable by a single authority.
+
+**Withheld results**: a packet that says it is holding a sealed prediction, a
+sealed sweep or an undisclosed mapping must ship that seal as a file in the same
+commit — §10's **R-SEAL-1**.
```

The orchestrator may drop §8.2 without weakening the rule; it is a signpost, and
the rule is normative in §10 either way. What must **not** happen is §8.2 landing
without §8.1 — a cross-reference to a rule that lives nowhere is the WO-0049
failure shape exactly.

---

## 9. Drafting notes for seal authors

Not normative. Written because §2.3's boundary is a sentence-level distinction
and the cheapest place to keep it visible is at the point of writing.

1. **Write forward commitments in the future tense.** "The mapping *will be*
   sealed before any diff exists" is unambiguous; WO-0043 §8's "*is* sealed
   before any diff exists" reads as a present holding claim on first pass and
   only resolves on the second. Same meaning, no ambiguity, no warning.
2. **When you claim to hold something, name the file in the same sentence.** "My
   sweep is sealed at `agents/handoffs/WO-XXXX_…-SEALED-predictions.md`" is
   self-checking: a reader who cannot open that path has found the defect
   immediately, which is the one thing no reader of WO-0049 could do.
3. **Keep the four header fields** — `State`, `Frozen against` (SHA, and the CI
   run if one executed it), `Frozen by` (journal entry, "before any diff
   existed"), `Second copy`. All five real seals carry them.
4. **Keep the journal second copy** (§7.2). R-SEAL-1 does not require it and it
   is the only thing standing between a seal and a quiet later edit.

---

## 10. Consequences

- **The claim in `RV-0049-VERDICT` §1 stands unchanged**: one sweep of
  `tb_xgmii_rx_64.v` exists, it is tb_writer's, dv_lead's is a post-hoc review,
  and no packet, verdict or sign-off may claim two independent sweeps agreed.
  Nothing in this ADR reopens that, and adopting the rule does not retroactively
  repair the round it came from.
- **No existing artifact is amended.** Nine commits would trip the literal
  reading (§2.1) and eight are correct conduct; the §2.5 wording clears all
  eight, so the record needs no corrections and none are proposed.
- **The auditor gains a cheap sampling handle**: for any commit range, the
  withheld-result claims and the seal files are both in the diff, and a claim
  without a file in its own commit is a finding to raise rather than an
  impression to form.
- **A new gaming surface exists** (§7.1) and is named here so that its first use
  is recognised as gaming rather than compliance.
- **Cost, honestly**: one bullet in PROTOCOL, roughly fifteen lines in each of
  two orchestrator-owned scripts, one `test_protocol.sh` case with three
  branches, and about one advisory warning per twenty commits, each dismissable
  by reading one quoted line. Against that, the single failure it prevents is a
  claim no reader could check — which is the failure class this programme has
  paid for four rounds running.

---

## 11. Alternatives considered

1. **Adopt dv_lead's text verbatim.** Rejected on §2.1's measurement: nine
   commits flagged, eight of them correct, and the ninth-row false positive is
   the verdict that found the bug. The intent is right and is preserved; the
   wording as it stands would have to be reinterpreted by every reader.
2. **Make it R10 and block in `agent_commit.sh`.** Rejected on §5 and §6.3. It
   would be the first R-number the script does not enforce, or — if it did
   enforce it — a blocking gate at roughly 1-in-12 precision that would have
   refused `RV-0049-VERDICT`.
3. **No rule; rely on review.** Rejected: review is exactly what failed. The
   claim was reviewed by its own author three times in one commit and by the
   orchestrator in relay, and no one had an artifact to check it against. The
   rule's whole contribution is producing that artifact.
4. **Require the seal's substance to be duplicated in the journal entry**
   (dv_lead's own two-copy practice, promoted to rule). Rejected as a rule,
   recommended as practice (§7.2): it is a content requirement nothing can check,
   it answers immutability rather than existence, and R2 already provides the
   hook if it is ever needed on its own.
5. **Require the seal file to be well-formed** (non-empty, `Frozen by:` naming an
   entry in the same commit). Rejected for this ADR (§7.1) and left available: it
   is the natural second step if a stub seal is ever committed, and it would be
   `R-SEAL-2` rather than an amendment of `R-SEAL-1`, so that the existence rule
   stays uncontestable.
6. **Put it in §3.** Rejected in §5: §3 is transport, the rule is admissibility,
   and §2.4 widens the subject past "packet" anyway. §8.2 keeps the signpost.

---

## 12. What this ADR does not decide

- **Whether the rule is adopted.** dv_lead countersigns the text; the
  orchestrator accepts. This ADR is PROPOSED and R-SEAL-1 is not in force.
- **Whether the advisory check is implemented, and when.** `scripts/**` is
  orchestrator-owned; §6.4 is a specification, not a change.
- **Anything about the WO-0049 round's technical content.** The §3 fix and the §5
  exit code were ACCEPTed on their merits and are untouched here.
- **Immutability of seals** (§7.2) and **authoring order inside a working tree**
  (§7.3). Both are open, both are the auditor's, neither is what WO-0051 asked.
- **`R-SEAL-2`** (§11 alternative 5). Available, not proposed.
