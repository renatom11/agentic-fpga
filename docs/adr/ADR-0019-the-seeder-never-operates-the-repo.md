# ADR-0019: the seeder never operates the repo, and the operator never authors the evidence

- **Status**: **PROPOSED**, and the rule it records **has been in force since
  `J-orchestrator-0218`** (2026-08-10), where `FINDING WO-0074-A1` (MAJOR,
  auditor) was ruled **ACCEPTED** by the orchestrator against its own dispatches.
  This ADR is the authorising instrument PROTOCOL §11 requires for that ruling
  and has been owed since it — the orchestrator routed it to me in the same
  entry (*"the ADR recording the three prior deviations and fixing the operator
  rule is routed to the architect - carrier: the next architect round"*).
  Acceptance is the orchestrator's, and §11(2)'s orchestrator journal entry for
  the round that lands this file is that acceptance; the §7 diffs to
  `agents/PROTOCOL.md` and `agents/charters/auditor.md` are orchestrator-scope
  and are **written here, applied by it**.
- **Deciders**: **orchestrator** (the operator rule itself, ruled at
  `J-orchestrator-0218`, and the §7 diffs it applies); **architect_docs_lead**
  (this instrument: the rule's exact statement, its bounds, the reading of
  PROTOCOL §10 at §2.2, and the §3 correction to the finding's recital).
  **Not an escalation class.** It adds no requirement, drops none, changes no
  phase, no role, no toolchain and no licensing boundary; it records who may run
  two git commands during a campaign, which is decided inside the org.
- **Proposed by**: the auditor's refusal (`FINDING WO-0074-A1`), accepted by the
  orchestrator and routed to me.
- **Work order**: none (the standing carry from `J-orchestrator-0218`) ·
  **Journal**: `J-architect_docs_lead-0032`
- **Affects**: `agents/PROTOCOL.md` §10's mutation-discipline bullet and
  `agents/charters/auditor.md` §3 and §4 (**diffs written at §7, applied by the
  orchestrator**). **No frozen spec text, no requirement's normative sentence,
  no interface record, no enforcement script, no closed gate checklist.**

---

## 1. Context — a practice fifteen campaigns deep with no instrument behind it

### 1.1 What is actually done, measured rather than remembered

A mutation campaign works like this, and has since the first one:

1. **The auditor seeds.** It authors one single-class diff per mutation class
   against a named base SHA, publishes them inside a manifest under
   `docs/reports/audit/<WO-id>-mutations/`, and delivers an **operator table**:
   branch name, base SHA, the one diff each branch carries, and the delivery
   order. It stages nothing outside `docs/reports/audit/**` (PROTOCOL §6,
   ADR-0003) and — the part this ADR is about — it runs no `git` write.
2. **The orchestrator operates.** It cuts one transient branch per class, fresh
   from the campaign base, each branch being *base + exactly one manifest diff*;
   commits each with a plain `git commit` (never `scripts/agent_commit.sh`)
   whose message is `MUTATION RUN <id> -- never merge`; pushes it so CI executes
   the DV suite against it; and never merges it.
3. **dv_lead adjudicates** the harvested CI results against its sealed
   predictions. It never receives a patch body before adjudication.

The measurement, at this commit, from a checkout:

```
git ls-remote --heads origin | grep -c 'refs/heads/mut/'      # -> 85
```

**85 transient refs across 17 prefixes** — fifteen campaign families
(`wo-0039` 7, `wo-0041` 5, `wo-0042` 1, `wo-0045` 5, `wo-0050` 8, `wo-0055` 5,
`wo-0056` 1, `wo-0058` 7, `wo-0061` 10, `wo-0063b` 2, `wo-0066` 6, `wo-0073` 5,
`wo-0074` 7, `wo-0076` 5, `wo-0077` 9 = 83) and two non-campaign probes
(`bug3-sev`, `wo70-cost-probe`). **None has ever been merged**, and none has
been deleted: the refs are the campaigns' re-checkable record, and
`tasks/BOARD.md` carries their inventory.

### 1.2 The one deviation, and the refusal that ended it

At **WO-0073** the orchestrator's seeding dispatch told the auditor to cut,
commit and push the transient branches itself, and the auditor did:
`J-auditor-0015`, Actions — *"Cut, committed (plain `git commit`, never
`agent_commit`) and pushed five transient branches in the packet's fixed
delivery order"*. The same entry records what makes the deviation expensive
rather than merely irregular: a correction to one class needed
`git push --force-with-lease`, **the repository rules refused it** (R9's
no-force-push guarantee holding on transient refs too), and the correction had
to land as a second fast-forward commit. **An operator error by an agent that
cannot force-push is not withdrawable by that agent.**

At **WO-0074** the dispatch said the same. The auditor refused, and filed
`FINDING WO-0074-A1` (MAJOR) **before any branch existed**, supplying the
operator table instead of the branches. Its three grounds are exact:

- **PROTOCOL §2** — *"the orchestrator is the sole spawner … and the sole
  operator of git. No other agent ever runs `git commit` or `git push`."*
- **PROTOCOL §6 / R7** — the auditor may stage `docs/reports/audit/**` only, so
  a commit under its identity whose diff is `libs/**` is a path-isolation
  violation by construction, and additionally fails R2, R4 and R6.
- **PROTOCOL §10 and its own charter** — *"the **orchestrator** applies each
  manifest transiently in an uncommitted working tree."*

The finding's falsifiable form is the reason this file exists: *"if such an ADR
exists, cite its number and this finding closes in one line; if it does not,
[the] campaigns have run on an unamended exception and one is owed."* It does
not exist. This is it.

`J-orchestrator-0218` ruled it **ACCEPTED against its own dispatches**, cut the
seven branches itself from the manifest's operator table, verified the working
branch unmoved after each, and made future seeding dispatches manifest-only.

### 1.3 A correction to the finding's recital, which does not disturb the finding

The finding says the practice was *"three campaigns deep"* and cites
`J-auditor-0014` (WO-0066) as a second instance of auditor operation. **The
journals do not bear that out.** `J-auditor-0014`'s own Actions record the
opposite — *"with read-only git commands (no `git commit`, no `git push`, no
`git add`)"* — and `J-auditor-0013` (WO-0063B) records *"Ran no `git` write of
any kind -- every `git` invocation was a read"*. Sweeping both auditor journal
volumes, **exactly one** entry records a write (`J-auditor-0015`, WO-0073); every
other seeding entry records the absence explicitly. The verified count is
therefore **one auditor-operated campaign**, with WO-0074's dispatch the second
instruction and the one refused.

**The finding's substance is untouched by this.** What it found was not a
frequency but a missing instrument: a practice contradicting three committed
rules with no ADR authorising it. That is as true of one instance as of three,
and the remedy — this file — is identical. The correction is recorded because an
ADR that repeats an overcount would make the record worse where it is supposed
to make it durable.

## 2. What PROTOCOL says, and the two distances between it and the practice

### 2.1 The operator — a real prohibition, plainly breached at WO-0073

PROTOCOL §2 is unambiguous and admits no exception: no agent other than the
orchestrator runs `git commit` or `git push`. WO-0073's five branches were
outside it. There is nothing to reconcile here and this ADR reconciles nothing:
it restates the prohibition and names the seam it was being crossed at.

### 2.2 The vehicle — "an uncommitted working tree" was never executable here

The harder distance is one nobody filed, and it predates the deviation by
fourteen campaigns. PROTOCOL §10 says the orchestrator *"applies each manifest
transiently in an **uncommitted working tree**, runs the DV suite against it,
reverts fully, and never lets mutated RTL enter history."* **No campaign has
ever been run that way**, because in this environment it cannot be:
**ADR-0005** establishes that the OCaml toolchain cannot be installed locally
(opam's repository paths are unreachable through the proxy) and that **CI is the
authoritative build and test environment**. CI runs on pushed refs. A mutation
that is never pushed is never executed, and a campaign that executes nothing
kills nothing.

So the choice was never *branch versus working tree*; it was *branch versus no
mutation testing at all* — and mutation testing is a mandatory imported
enforcement measure (ADR-0001, auditor charter §3) and a `P<n>-module-ready`
precondition (PROTOCOL §7). The transient branch is the minimum vehicle that
makes §10's own campaign executable.

**And it keeps §10's real object.** "Never lets mutated RTL enter history" is
protecting the **lineage** — the working branch that R9 serialises and the
`main` it merges into — because that is the object every traceability guarantee
in §5 is stated over (`git diff A..B` on the working branch; trivial merges to
`main`). A `mut/*` ref is a leaf hanging off a campaign base: it is never
merged, so it never enters the lineage, and `git log` on the working branch is
unchanged by its existence. What §10's wording protects, the practice preserves;
what §10's wording *says*, the practice cannot do. §11 exists for exactly this,
and it is fifteen campaigns late.

## 3. Decision

**The two roles are separated at the git seam, and the separation is the rule:**

> **The auditor seeds manifests only. The orchestrator operates the repository
> only. Neither does the other's half.**

Concretely, for every mutation campaign:

1. **The auditor authors the manifest and the operator table, and runs no `git`
   write of any kind** — no `commit`, no `push`, no `add`, no branch, no tag, no
   checkout, no working-tree application of its own diffs. Its apply/revert
   round trips are verified with `git apply --check` and performed outside the
   repository working tree. It stages `docs/reports/audit/**` and its journal,
   and nothing else, ever (PROTOCOL §6, ADR-0003 — unchanged by this ADR).
2. **The orchestrator cuts, commits and pushes every transient branch itself**,
   from the manifest's operator table, and never merges one.
3. **The manifest's operator table is the sole authority for what gets cut.**
   Branch names, base SHA, the one diff per branch and the delivery order all
   come from it. The orchestrator adds nothing to it and drops nothing from it;
   a disagreement with the table is a finding routed back to the auditor, never
   an edit to the table and never a silently different branch.

## 4. Bounds — what this authorises, and what it still forbids

**B1 — transients only.** This authorises `mut/*` refs carrying seeded RTL, one
per manifest class, each exactly *campaign base + one manifest diff*. It
authorises no other commit of mutated RTL anywhere.

**B2 — never merged, never rewritten.** A transient is never merged to the
working branch or to `main`, never rebased, never force-pushed (R9's protection
applies to it and has been observed to fire — §1.2). It is **retained, not
deleted**, so the campaign's CI runs stay re-checkable, and `tasks/BOARD.md`
carries the ref inventory, updated when a transient is pushed.

**B3 — a plain commit, and no journal entry.** A transient commit is made with
`git commit`, **not** `scripts/agent_commit.sh`, and its message is
`MUTATION RUN <id> -- never merge`. **No journal entry is written for it**, by
anyone. This is deliberate and it is not a bypass of R2: R2 couples a journal
entry to a commit *that carries work*, and a throwaway ref that is deleted from
the program's meaning the moment its run concludes carries none. The campaign's
reasoning is journaled where it belongs — in the auditor's seeding entry, the
orchestrator's operating entry and dv_lead's adjudication entry, each with its
own files list. Inventing a journal entry per transient would put fifteen
campaigns' worth of throwaway entries into three permanent chains to describe
nothing.

**B4 — `journal-check` red on a `mut/*` ref is declared noise.** A plain commit
on a transient has no journal append, so the workflow reddens by construction
(`J-orchestrator-0159` recorded this on the first branch campaign). That red is
**noise, not a verdict**: it is never cited as a finding, and — the half that
matters more — **it is never cited as a clearance either**, and it never
substitutes for `journal-check` on the working branch or on `main`, where the
check is the actual gate. Only the `build` job's `runtest` result is harvested
from a transient run; a co-simulation red on a transient is by design.

**B5 — the seeding blind stays sealed.** Nothing here relaxes the campaign
allowlists, the sealed-prediction discipline (ADR-0016, R-SEAL-1), or dv_lead's
routing bar (no patch body reaches DV before adjudication). The operator learns
the diffs by executing the table; it already knew them, being the party that
holds the manifest.

**B6 — no RTL-line or worker agent is spawned while a manifest is applied to a
working tree** (PROTOCOL §10, unchanged). Under the branch vehicle the working
tree is clean throughout, which makes the hazard smaller, not absent — an
operator that applies a diff locally to check it is inside the window.

**B7 — non-campaign transients.** A probe transient cut by the orchestrator on
its own account (`mut/bug3-sev`, `mut/wo70-cost-probe`) is bound by B1–B4 and
has **no manifest and no operator table**, because there is no seeder. It is
therefore **not authorised to carry seeded RTL for adjudication**: a branch whose
content is adjudicated as a mutation kill must come from a manifest, or the
adjudicator is scoring the operator's own edit.

## 5. Why this shape — the property being bought

**The auditor authors evidence and never operates the repository; the
orchestrator operates the repository and never authors evidence.** PROTOCOL §1's
second non-negotiable is independence, and it is normally read one way — the
auditor is never graded by anyone it audits. This is the same property read in
the other direction, and it is worth two things the alternatives do not buy:

- **The seeder cannot make a mutation land differently from what its manifest
  says.** It does not push. Every branch's content is derivable from a committed
  manifest by a published command, so a discrepancy between the ref and the
  manifest is an operator defect, visible, and attributable — rather than an
  unfalsifiable question about what the seeder actually did.
- **The operator cannot choose which mutations exist.** It executes a table it
  did not compose. Its own errors — a wrong base, a skipped class, a wrong order
  — are checkable against the table by anyone, which is exactly the check
  `J-orchestrator-0218` and `J-orchestrator-0224` both record performing
  (*"operator-cut fresh from aced7b4 per the manifest's table … pushed in
  manifest order"*, *"working branch verified unmoved after each"*).

The failure mode this forecloses is the one WO-0073 walked into: an agent whose
entire value is that it did not touch the artefact, touching the artefact — with
an irreversible command, under an identity whose write scope forbids the paths
involved, and with no journal entry to attribute it.

## 6. Alternatives considered

**(a) The status quo ante — the auditor operates on the orchestrator's
dispatch.** *Rejected.* It breaches PROTOCOL §2 and R7 by construction, makes
the author of the evidence the operator of the artefact, and its errors are
irreversible under branch protection by the very agent least able to withdraw
them. It also costs the orchestrator nothing to take back: §1.2's remedy was
seven `git` commands supplied verbatim in the manifest.

**(b) Literal PROTOCOL §10 — an uncommitted working tree, no branch.**
*Rejected as unexecutable*, not as undesirable. ADR-0005 leaves CI as the only
environment that can run the DV suite, and CI runs on pushed refs. This
alternative does not produce a slower campaign; it produces no campaign, and
therefore no `P<n>-module-ready`.

**(c) A dedicated operator agent.** *Rejected.* It adds a spawn, a charter and a
journal chain to execute a table, and it does not answer the question: PROTOCOL
§2 makes the orchestrator the sole operator of git regardless, so the new agent
either breaches §2 exactly as the auditor did, or hands the branches back to the
orchestrator, which is this ADR with an extra hop.

**(d) Land the mutation on the working branch behind a revert.** *Rejected.* It
puts mutated RTL in the lineage — the one thing §10 forbids in substance — and a
mutate/revert pair would appear in every later `git diff A..B` traceability
read, which is the guarantee §5 exists to protect.

**(e) Delete each transient after its run.** *Rejected.* The refs are the only
durable evidence that a given mutant was the thing CI actually ran; deleting
them turns every kill claim into a claim about a vanished object, which is the
shape R-SEAL-1 (ADR-0016) was minted against. Retention costs 85 refs.

## 7. The diffs — written here, applied by the orchestrator

Both files are orchestrator-scope (PROTOCOL §6), so this ADR supplies the text
and applies nothing.

### 7.1 `agents/PROTOCOL.md` §10 — the mutation-discipline bullet

Replace the bullet's first sentence (through *"…never lets mutated RTL enter
history."*) with:

> - Mutation discipline — the **transient model**, sequenced: the auditor
>   authors mutation manifests (patches) under
>   `docs/reports/audit/<WO-id>-mutations/` together with the **operator table**
>   the orchestrator executes from, and **runs no `git` write of any kind — it
>   seeds manifests only** (ADR-0019). The **orchestrator alone operates the
>   manifest**: it cuts one transient `mut/*` branch per class, fresh from the
>   campaign base, each branch being that base plus exactly one manifest diff,
>   commits each with a plain `git commit` messaged
>   `MUTATION RUN <id> -- never merge`, and pushes it so that CI — the only
>   authoritative build environment (ADR-0005) — can run the DV suite against
>   it. A transient is **never merged, never rebased and never force-pushed**,
>   so mutated RTL never enters the lineage the working branch and `main`
>   carry. The **manifest's operator table is the sole authority** for what is
>   cut; a disagreement with it is a finding routed back, never an edit. A red
>   `journal-check` on a `mut/*` ref is declared noise (ADR-0019 §4 B4): never a
>   verdict, never a clearance, and never a substitute for the check on a
>   protected branch.

The bullet's remaining sentences — the sequencing clause, the N ≥ 3 rule, the
no-spawn-while-applied clause and the "report, never repair" safety net — are
**unchanged**.

### 7.2 `agents/charters/auditor.md` §3, the mutation-testing bullet

Replace *"Author each mutation as a manifest under
`docs/reports/audit/mutations/` (module, exact patch, expected killing
behavior); the orchestrator applies mutations transiently in an uncommitted
working tree — mutated RTL never enters history —"* with:

> Author each mutation as a manifest under
> `docs/reports/audit/<WO-id>-mutations/` (module, exact patch, expected killing
> behaviour), carrying the **operator table** the orchestrator executes from;
> **you seed manifests only and run no `git` write of any kind — no `commit`, no
> `push`, no `add`, no branch, no working-tree application** (ADR-0019). The
> orchestrator cuts, commits and pushes every transient branch itself and never
> merges one, so mutated RTL never enters the lineage —

Two corrections ride this: the manifest path (`docs/reports/audit/mutations/`
has never been the path used; every campaign wrote
`docs/reports/audit/<WO-id>-mutations/`), and the vehicle.

### 7.3 `agents/charters/auditor.md` §4, the orchestrator interface row

Replace *"mutation manifests for transient application"* with *"mutation
manifests **and their operator tables** for transient application, which the
orchestrator alone operates (ADR-0019)"*.

## 8. PROTOCOL §11(3) — the test cases owed

**None, and the reason is the same one ADR-0018 §7.4 gives.** No `R`-rule is
minted, no `R`-rule is amended, and `scripts/agent_commit.sh`,
`scripts/policy.sh` and `scripts/check_journals.sh` are untouched: this ADR
constrains **who runs two commands outside the commit script** and **on which
refs**, neither of which those scripts can see. §11(3) is conditioned on a
change to enforcement semantics; there is none, so no case is owed and inventing
one would assert coverage the scripts do not have.

**How it is enforced instead** — stated honestly, per PROTOCOL §10's own
convention:

- **By the seeder's refusal.** WO-0074 is the demonstration: the constrained
  party is the one that filed the finding. This is a real control precisely
  because the auditor's incentive runs toward refusing.
- **By attribution.** Any commit on a `mut/*` ref is a plain commit with no
  trailer; who ran it is recoverable from the round's journals, and the
  orchestrator's operating entry is the one that must claim it.
- **By the table.** Every transient's content is derivable from a committed
  manifest, so an unauthorised or divergent cut is checkable by anyone at any
  later commit.

## 9. Consequences

- The practice gains the instrument PROTOCOL §11 requires, fifteen campaigns
  after it began and three campaigns after the finding that named the gap
  (WO-0074's seven transients, WO-0076's five, WO-0077's nine — 21 transients,
  no incident).
- `FINDING WO-0074-A1`'s falsifiable form is **discharged in its first branch**:
  the ADR now exists and is numbered, and any future seeding dispatch that
  instructs an auditor to push cites nothing — it contradicts §7.1.
- The auditor's refusal cost is now zero: refusing an operator instruction is
  the charter's own text rather than a judgement call it has to defend, which is
  what the next seeder — a stateless spawn reading only the charter — will see.
- **A residue is created and named**: `mut/*` refs accumulate (85 today) and are
  deliberately never garbage-collected. If that ever becomes a repository-health
  problem, the disposition is a further ADR, not a quiet deletion, because §6(e)
  is the reason they are kept.

## 10. What this ADR does not decide

- **It does not decide mutation-campaign content**: how many classes, which
  defect classes, what counts as a kill, or how survivors are dispositioned.
  Those are the auditor charter's §3 and §9 and PROTOCOL §10's sequencing, all
  untouched.
- **It does not decide the seal discipline.** ADR-0016 governs sealed
  predictions and is neither widened nor narrowed here.
- **It does not authorise any other mutated-RTL commit**, in any other place, by
  any agent, for any reason. B1 is exhaustive.
- **It does not settle whether `journal-check` should be taught to skip `mut/*`
  refs.** B4 declares the red noise; making the workflow silent there is a
  scripts change, orchestrator-scope, and would be an enforcement-semantics
  change owing §11(3) a case. This ADR deliberately leaves the red visible and
  declares its meaning instead.
