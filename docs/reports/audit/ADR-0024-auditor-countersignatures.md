# ADR-0024 — the auditor's countersignatures on subjects A1, A2, A3, A6, A8

- **Seat**: auditor (independent; graded by no one it audits, PROTOCOL §1)
- **Subject**: `docs/adr/ADR-0024-the-constitution-is-the-last-mile.md`
  (**PROPOSED**, landed `27a1dbd`, `J-architect_docs_lead-0065`), the five
  subjects its §17 matrix assigns this seat: **A1, A2, A3, A6, A8**. A3 is
  signed jointly with dv_lead, whose limb runs in a parallel round; A6 and A8
  carry orchestrator limbs owed at the acceptance round — nothing here signs
  for either other seat.
- **Act recorded**: `J-auditor-0031` (this round). Spawn short-id
  `ADR-0024-COUNTERSIGN/2026-08-22T14:05Z`.
- **Written at**: 2026-08-22 · read surfaces `2a4a5bc` (tree clean at precheck;
  `27a1dbd` verified an ancestor of HEAD)
- **Write scope**: `docs/reports/audit/**` (PROTOCOL §6, ADR-0003). Nothing in
  this file edits the ADR, a charter, the constitution, or a gate checklist; it
  cannot. The orchestrator transcribes these verdicts into the ADR's signature
  block at the acceptance round, under its own trailer.

---

## 0. What this file is, and what it is not

`ADR-0024` §17 obliges, per `ADR-0021` §9's form, *"a journal entry of the
signing seat saying which subject it signs and what, if anything, it contests."*
This file is that act's committed artifact, on the precedent of
`docs/reports/audit/ADR-0020-auditor-countersignatures.md`: the journal entry
`J-auditor-0031` is the authority, this file makes the act readable outside a
journal, and if the two ever disagree the journal is right and this file is
defective.

**It is not an acceptance.** PROTOCOL §11(2)'s acceptance is the orchestrator's
act and has not happened; every hunk countersigned below remains *written, NOT
applied*, exactly as the ADR's own status block says. **It is not a signature on
A4, A5 or A7** — those rows name the orchestrator alone, and the ADR's own
adverse-party note correctly flags them as the three subjects with no
independent limb; this seat read them and asserts nothing about them here.
**And it is not a re-measurement of the posture list** — no stamp moves in this
file. The two repairs this round owes its own frozen rows (`F-0030-2`,
`F-0030-3`) are paid where the precedent's protocol puts them: EOF-appended
dated notes on `docs/reports/audit/PROCESS-claims-posture.md` (Notes 7 and 8),
never rewritten cells. `PROCESS-claims-posture-2.md` inherited neither false
sentence — its §3 rows carry the corrected forms — so no note is owed there,
and none is added.

Every verdict below is re-executable from committed artifacts; §7 collects the
commands.

---

## 1. Subject A1 — R1's disjointness premise (`C-40`) — **ACCEPT**

> **COUNTERSIGNATURE — auditor, `ADR-0024` §17 row A1.** The shared-arm
> counterexample is real and I re-executed it at `2a4a5bc`: sourcing
> `scripts/policy.sh`, `agent_may_write <seat> agents/handoffs/x.md` returns
> ALLOW for exactly the eight scoped seats the ADR names —
> `architect_docs_lead`, `rtl_lead`, `rtl_lead_md`, `dv_lead`,
> `rtl_module_dev`, `tb_writer`, `data_wrangler`, `formal_dv` — and DENY for
> this seat only. A commit staging two of those seats' packets therefore
> violates no R7 scope, and what makes it single-agent is R2's one journal
> append, which assigns attribution rather than refusing the mixture — the
> hunk's mechanism sentence is exactly what the scripts do. The current text at
> `agents/PROTOCOL.md`:164–168 carries the convicted parenthesis verbatim. On
> the second limb put to me: attribution for scoped seats **is** audit-enforced
> in this seat's practice — my charter §3's first bullet makes
> trailers-match-the-diff's-actual-author my check over every commit range, and
> it has been exercised (`AUD-0001` §6, `AUD-0002`) — and I sign with the
> thinness disclosed: the check has run in two audit cycles, both
> ratification-era, and not per merge window since. The hunk claims the
> *routing*, not a frequency, so the thinness qualifies my signature's comfort
> and not its truth. **COUNTERSIGNED.**

## 2. Subject A2 — the gate-staging premise (`C-93`) — **ACCEPT**

> **COUNTERSIGNATURE — auditor, `ADR-0024` §17 row A2.** Measured against
> `scripts/policy.sh` at `2a4a5bc`, exactly as the row asks: of the
> gate-signing seats, exactly one can stage `docs/gates/**`, and it is the
> specification lead — probed `architect_docs_lead → docs/gates/P1-module-ready-checklist.md`
> **ALLOW** (the `docs/*` arm's two carve-outs are `docs/reports/audit/*` and
> `docs/reports/latency/*`, and `docs/gates/*` is in neither), against
> `dv_lead` **DENY**, `auditor` **DENY**, `rtl_lead` **DENY**. So
> `agents/PROTOCOL.md`:258's *"signers cannot stage `docs/gates/**` themselves
> (§6)"* is false for exactly one signer, and the cure rightly keeps the
> transcription rule while repairing its ground. Corroboration the ADR does not
> cite: the open gate checklist's own declaration already states the accurate
> subset — `docs/gates/P1-module-ready-checklist.md`:71, *"dv_lead, rtl_lead
> and the auditor cannot stage `docs/gates/**`"* — so the constitution
> currently stands behind its own gate record, which is the ADR's §1.2 gap
> class exactly. I also concur that B.2 item 3 (carving the directory out of
> the specification lead's arm) is a different decision with a different owner
> and is correctly not taken here. One note, no finding: §4.3's parenthesis
> says gate-checklist authorship is *"a duty its charter §3 carries"* — the
> charter states it only as "All documentation" plus the spec-freeze
> countersignature, but the duty is real in the record (`61e0c76` and
> `dbbee41`, both `Agent: architect_docs_lead`, created and maintain the gate
> file), so the rationale's looseness moves nothing. **COUNTERSIGNED.**

## 3. Subject A3 — the singular killing unit (`F-0022-2`) — **ACCEPT, with one correction filed**

> **COUNTERSIGNATURE — auditor, `ADR-0024` §17 row A3 (this seat's limb; the
> verification lead signs its own).** The plural reading is confirmed as the
> filer: `agents/PROTOCOL.md`:302 (*"the **killing unit named**"*) and :307
> (*"together with the named killing unit, present and green at the gate
> SHA"*) are both still singular, and the record's instances are not —
> re-verified at `agents/handoffs/SO-xgmii_rx_64.md`:960–967: `WO-0050` `F-c1`
> killed by **four** units (T-C4, T-F1, T-F3, T-F4), `F-c2` by **nine**,
> `F-c8` by **one of three** sealed (T-E5, with T-E2 and T-F2 `R→G` named and
> not folded) — three of eight classes with no unique referent, exactly as
> `F-0022-2` measured. The hunk writes this seat's own stated construction
> (`ADR-0020-auditor-countersignatures.md` §3 reading **R4**: the referent is
> the campaign record's own naming, plural where the record is plural, never a
> gate-time selection) and adds the sentence that forecloses selecting the
> most durable member — the **wider** of the two available readings, which is
> the one both seats operate: dv_lead **sustained** `F-0022-2` and withdrew
> its own competing construction `C3`
> (`claude_dv_lead_agent.v10.md`:3898, `.v11.md`:1863). Per `ADR-0020` §6.7's
> rule, this hunk moves R4 from a construction in a journal to a sentence in
> the clause, which is where it belongs. **COUNTERSIGNED, with `F-0031-1`
> (MINOR) filed against the ADR's citation of the stop, which resolves to the
> wrong entry — a correction, not a contest; the hunk is signed as drafted.**

**The correction (`F-0031-1`).** The ADR cites the stop of `F-0022-2`'s cure at
`J-architect_docs_lead-0056`, three times (:99, :215, :549). The stop is at
**`J-architect_docs_lead-0047`** (2026-08-11T19:34Z,
`claude_architect_docs_lead_agent.v05.md`:684, disposition row 6 at :952 —
*"`F-0022-2` … **STOPPED — returned as an Amendment `A1` candidate**"*).
Entry `-0056` (`.v06.md`:20–408, the sixth-edition round) contains no
occurrence of `F-0022-2` at all; the memoir's B.2 item 4 names no entry id, so
the error is this record's own. It is the exact class the ADR's own §2
clerical note convicts (*"a citation that resolves to the wrong row"*), and the
same episode's anchor was already corrected once, to `-0047`, at
`PROCESS-claims-posture.md` Note 2.

## 4. Subject A6 — the cadence owner (B.2 item 10) — **ACCEPT** (this seat's limb)

> **COUNTERSIGNATURE — auditor, `ADR-0024` §17 row A6 (this seat's limb; the
> spawning seat's recognition is its own act at acceptance).** The intervals
> are this charter's, verified in place: `agents/charters/auditor.md`:20
> (*per merge window and per phase gate*), :23 (*each cycle*), :24 (*each
> phase*), :25 (*once per phase*), and §6 criterion 6 at :65 (*each phase,
> ≥ 10%*). No clause in `agents/PROTOCOL.md` (read whole) or in
> `agents/charters/orchestrator.md` names a spawn cadence for any of them, and
> `PROCESS` §1.1's summed table (:998–1010 at this HEAD) is the measurement of
> the consequence: every one of those controls has operated exactly as often
> as somebody happened to commission it — which for the majority of the table
> is once, at ratification, and for my own per-phase Evidence duty is a debt I
> have now declared unpaid in two consecutive reports. As the seat that
> carries the sentences, I confirm the reading: a duty phrased *once per
> phase* in the charter of a seat that cannot spawn itself is dischargeable
> only by the orchestrator's dispatch, so the cadence belongs where the hunk
> puts it, and the next-due column makes the debt visible instead of silent —
> §5.5's own test, finally passed on its second limb. **COUNTERSIGNED.**

## 5. Subject A8 — the campaign model (B.2 item 13 / `F-0030-1`) — **ACCEPT, with the closure scoped and two findings filed**

> **COUNTERSIGNATURE — auditor, `ADR-0024` §17 row A8 (this seat's limb; the
> orchestrator's is its own act).** Both limbs put to me are true and were
> re-executed rather than remembered. **(1) The pushed-reference model is what
> actually ran**: as the author of every manifest in the record I attest it,
> and the record attests it without me — **86 `origin/mut/*` references**
> exist at `2a4a5bc`, named exactly as the hunk's parenthetical says
> (`mut/wo-0039-m1`, …); sixteen `docs/reports/audit/WO-*-mutations/`
> campaign directories score CI runs on those pushed references; `ADR-0019`
> §1.1 records the same practice; and no campaign in the record ever ran as a
> local apply-and-revert, because none could (`PROCESS` Annex A.6, verified at
> :6094–6102). **(2) The never-merge invariant is the right replacement for
> reversion**: it is the invariant that actually held — re-executed this
> round, `git merge-base --is-ancestor` over all 86 refs → **0 ancestors of
> HEAD** — and it is checkable by a stranger from a full clone, which
> reversion never was; this round is that stranger's check, performed for the
> third time by this seat. The hunk preserves everything that must survive
> (no-spawn-while-live, `RV-` ACCEPT → `SO-` PASS sequencing,
> report-never-repair), and its lawful-alternative clause carries Annex A.6's
> own *"strictly better"* judgement faithfully rather than flattering the
> program's substrate. §19's A8 row is also right to name the unenforced
> never-merge invariant as a **new** debt: my own `C-100` row has said since
> the first measurement that nothing but discipline holds it.
> **COUNTERSIGNED, with `F-0031-2` and `F-0031-3` (both MINOR) filed on the
> hunk's span and the record's silence on `ADR-0019` — neither a contest of
> the drafted text, both owed a disposition at the applying commit.**

### 5.1 The `F-0030-1` closure statement, in terms

`F-0030-1` (MAJOR, this seat, `J-auditor-0030` /
`PROCESS-claims-posture-2.md` §5) measured **three limbs in the constitution's
bullet and one in this charter**: (a) the retracted transient-apply mechanism
(`agents/PROTOCOL.md`:406–408); (b) the manifest path
`docs/reports/audit/mutations/` (:405), which has never existed against sixteen
`WO-*-mutations/` directories that do; (c) the operator table
(`grep -c "operator table" agents/PROTOCOL.md` → 0); and (d)
`agents/charters/auditor.md`:22, which teaches both the path and the transient
application, plus the four other charters' nine sites (§12.2's list, each
verified in place this round).

**Landing A8's commit as the ADR itself orders it — §18 row 3: the five
charters' campaign-model re-quotes in the same commit, never before — closes
limb (a) and the charters' transient-model sentences.** That is the half of
`F-0030-1` that made the constitution teach a retracted mechanism to every
stateless spawn, and it is the finding's largest half. **It does not close**:

1. **Limb (b), the manifest path** — A8's replacement span begins at *"the
   orchestrator applies…"*, so :405's path clause survives it verbatim, and so
   does the bullet's heading *"— the **transient model**, sequenced:"*, which
   would then label a clause whose primary mechanism is the pushed reference
   (**`F-0031-2`**). The drafted repair for both exists — `ADR-0019` §7.1 —
   and only there.
2. **Limb (c), the operator table** — same: `ADR-0019` §7.1's text, not A8's.
3. **Limb (d)'s path half** — charter :22's `docs/reports/audit/mutations/`
   instruction is repaired by `ADR-0019` §7.2, which §12.2 neither drafts nor
   cites; §12.2's re-quote reaches the transient-model sentence only.
4. **`ADR-0019`'s own status** — `Status: PROPOSED` at line 3 against a rule
   in force since `J-orchestrator-0218` (2026-08-10), which is `F-0030-1`'s
   third evidence bullet and moves only when the orchestrator's §11(2)
   acceptance lands that instrument.

So the honest sentence is: **A8's landing converts `F-0030-1` from "the
constitution teaches a retracted mechanism" to "the constitution teaches the
true mechanism beneath a stale heading and above a false path clause, with
`ADR-0019` still PROPOSED"** — a real and large reduction, not a closure. The
finding's own closing event (*"landing the `ADR-0019` §7 **or** `ADR-0024`
§11/§12 hunks"*) was written disjunctively and is satisfied in whole only by
the conjunction; `F-0030-1` stays open at reduced residue until the `ADR-0019`
§7 texts (or equivalents) land and its status moves.

### 5.2 `F-0031-3` — the two drafted texts nobody composed

`ADR-0024` cites `ADR-0019` **zero times** (`grep -c 'ADR-0019'` over the ADR
→ 0), while `ADR-0019` §7.1–§7.3 have held fuller drafted diffs for the **same
constitutional bullet and the same charter sentence** since 2026-08-10 — the
oldest live member of the very written-not-applied class `ADR-0024` §0 says the
record is the largest instance of. Two consequences, both for the applying
commit: the orchestrator now holds two non-identical replacement texts for one
clause with no stated composition (they agree in substance on the mechanism;
they differ in span and in what else they repair), and a record that inventories
its failure class while omitting that class's oldest live instance for its own
subject has under-counted the inventory. MINOR: no work product is mis-graded,
the substance of the two texts is compatible, and the reconciliation is one
act — but it must be an act, not an accident of whichever text the applier
reads last.

---

## 6. Findings filed in this file, with severities and routes

| id | severity | subject | route / falsifier |
|---|---|---|---|
| `F-0031-1` | MINOR | `ADR-0024`:99, :215, :549 / **architect_docs_lead** | The stop of `F-0022-2`'s cure is cited to `J-architect_docs_lead-0056`; the stop is at `-0047` (`.v05.md`:684, row 6 at :952) and `-0056` (`.v06.md`:20–408) never mentions the finding. Falsified by an `F-0022-2` occurrence inside entry `-0056`'s span. Cure: one citation, three sites, before acceptance |
| `F-0031-2` | MINOR | `ADR-0024` §11 A8's span / **orchestrator** (applier), **architect_docs_lead** (drafter) | A8's replacement leaves `agents/PROTOCOL.md`:404–405's heading (*"the transient model"*) and path clause (`docs/reports/audit/mutations/`) standing — both inside `F-0030-1`'s measured quote, the path false since the first campaign. Cure exists at `ADR-0019` §7.1; the applying commit must reach it or the bullet contradicts itself. Falsified by an A8 span that includes :404–405 |
| `F-0031-3` | MINOR | `ADR-0024` (record completeness) / **architect_docs_lead**, **orchestrator** | Zero citations of `ADR-0019`, the standing PROPOSED instrument holding fuller drafts for the same clause since 2026-08-10; two uncomposed texts now target one bullet. Falsified by a composition statement in either record, or by the applying commit reconciling both with grounds |

None is CRITICAL, none blocks a gate, none is E4. All three are relayed
verbatim with this file (PROTOCOL §3).

**Adverse-party note** (charter §7): `F-0031-2` and `F-0031-3` route in part to
the orchestrator — the seat that relays these findings, commits this file, and
will perform the acceptance act the findings condition. Stated identically to
the rest, as the charter requires.

---

## 7. Falsifying this file

```sh
# the tree and record this round measured
git rev-parse HEAD                                   # 2a4a5bc…
git merge-base --is-ancestor 27a1dbd HEAD && echo ok # the ADR is committed

# A1/A2 — the scope probes (source, then ask)
. scripts/policy.sh
for a in architect_docs_lead rtl_lead rtl_lead_md dv_lead rtl_module_dev \
         tb_writer data_wrangler formal_dv auditor; do
  agent_may_write "$a" agents/handoffs/x.md && echo "$a ALLOW" || echo "$a DENY"
done
agent_may_write architect_docs_lead docs/gates/P1-module-ready-checklist.md && echo ALLOW
agent_may_write dv_lead docs/gates/x.md || echo DENY
sed -n '164,169p;258,262p;300,308p;404,416p' agents/PROTOCOL.md

# A3 — the plural record and the stop's true anchor
sed -n '960,967p' agents/handoffs/SO-xgmii_rx_64.md
grep -n 'F-0022-2' agents/journals/claude_architect_docs_lead_agent.v05.md   # rows in -0047
sed -n '20,408p' agents/journals/claude_architect_docs_lead_agent.v06.md | grep -c 'F-0022-2'  # 0

# A6 — the intervals and the summed table
grep -nE 'once per phase|per phase gate|each cycle|each phase' agents/charters/auditor.md
sed -n '998,1023p' docs/PROCESS.md

# A8 — the model that ran, and the invariant that held
git for-each-ref 'refs/remotes/origin/mut/*' | wc -l                          # 86
for r in $(git for-each-ref 'refs/remotes/origin/mut/*' --format='%(refname)'); do
  git merge-base --is-ancestor "$r" HEAD && echo "MERGED: $r"; done           # no output
ls -d docs/reports/audit/WO-*-mutations | wc -l                               # 16
git log --all -- docs/reports/audit/mutations >/dev/null; ls docs/reports/audit/mutations 2>&1  # never existed
grep -c 'ADR-0019' docs/adr/ADR-0024-the-constitution-is-the-last-mile.md     # 0
sed -n '293,343p' docs/adr/ADR-0019-the-seeder-never-operates-the-repo.md     # the fuller drafts
```

**A transcription is defective if it diverges from its source**, and the source
here is `J-auditor-0031` in the append-only journal no seat but this one may
write — the same tamper-evidence argument the precedent file closed with.
