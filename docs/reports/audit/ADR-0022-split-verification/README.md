# ADR-0022 row 2 — the split-loses-nothing verification, in the auditor's own committed artefact

- **Seat**: auditor (independent; graded by no one it audits, PROTOCOL §1).
- **Subject**: `docs/adr/ADR-0022-the-warranty-and-the-split.md` §7 **row 2** —
  the countersignature owed on **Decision 2, the core/memoir split**.
- **Verdict**: **ACCEPT**, both sub-answers, qualified as stated in §8. Recorded
  as an authored act at `J-auditor-0029`, which is the authority; if this file
  and that entry ever disagree, the entry is right and this file is defective.
- **Read/verified surfaces**:
  - fifth edition (the split's "before"): **`d96a5b1:docs/PROCESS.md`** — 5,446 lines / 384,659 bytes.
  - the split commit (the "after", 6th edition): **`592926e`** — core reduced + `docs/PROCESS-MEMOIR.md` created in one commit.
  - the restoration (7th edition): **`2ed029d`**.
  - current committed state: **HEAD `21e7332`**; both PROCESS files are byte-identical from `2ed029d` through HEAD (`git diff 2ed029d HEAD -- docs/PROCESS.md docs/PROCESS-MEMOIR.md` is empty). Core = 5,538 / 366,906; companion = 2,028 / 198,269.
- **Write scope**: `docs/reports/audit/**` (PROTOCOL §6). This file edits no ADR,
  packet, or gate checklist, and cannot. The §7 table edit and the status flip are
  the orchestrator's acceptance act (ADR §8), citing `J-auditor-0029`.

---

## 1. The question, exactly as asked

ADR-0022 §7 row 2 owes the auditor confirmation of two things about Decision 2:

> (a) **the split as executed loses nothing — verified against the fifth
> edition's committed text**; and (b) **the core's remaining stamp apparatus is
> not weakened by the move of its archaeology** to the companion.

Per ADR §3.5 this is a countersignature of a normative change, not a
confirmation of description, and **refusal is a first-class outcome**. The check
was re-executed against committed text, not read through — ADR §3.3 states in
terms that "verifying the split against the fifth edition's committed text is a
reviewer's act this record cannot perform for itself." This file is that act.

## 2. Method, and its limits

The standard applied to "loses nothing": **every substantive passage of the
committed fifth edition (`d96a5b1`) must either (i) survive as current law in the
current core, (ii) be preserved in the companion as a superseded claim under the
core section it was anchored to, or (iii) be edition-scaffolding legitimately
regenerated per edition** (the edition anchor, the table of contents, per-edition
census counts, and "this edition" self-referential narrative). A fifth-edition
passage that is a substantive rule/claim/facsimile and is in **neither** volume
is a loss.

Instruments used, each against a state a reviewer can check out:

1. **The four committed falsifiers** the companion prints at `PROCESS-MEMOIR.md`
   §0.4, re-run independently (§5 below).
2. **A whole-line diff accounting**: `git diff d96a5b1 HEAD -- docs/PROCESS.md`,
   every removed content line classified against both current volumes by
   whitespace-normalised substring, then by 6-gram coverage to separate genuine
   content-absence from line-wrap reflow (§4).
3. **A first-edition-preservation reconciliation**: the fifth edition's
   sentinel-bearing preserved claims enumerated and matched into the current
   companion, one at a time (§6) — the decisive check, because the preserved
   superseded claims are a bounded, load-bearing set and the discipline the
   split most risks.
4. **The stamp-apparatus trace**: every `[CORRECTED · C-nn]` stamp in the core
   resolved; the posture legend, boundary block, §5.5, and the advisory-warning
   instrument located in the current core (§7).

**Limits, stated so the sample can be reconstructed.** Substring and n-gram
matching is permissive toward "found": a lost passage that shared a long word-run
with surviving text could be masked. Two things bound that risk — the
sentinel-census reconciliation (§6) is an *exact* accounting of the preserved-claim
set, not a fuzzy one; and line counts are explicitly **not** treated as a closure
proof (a moved block and a deleted-plus-added block of equal size are
indistinguishable by count — this is the very defect the sixth edition made and
the seventh edition names). The claim of this file is bounded by falsifier 4 run
against `d96a5b1`, not by arithmetic.

## 3. What the split moved, and what it kept — the map I verified

| Fifth-edition asset | Where it is now | Verified |
|---|---|---|
| §1–§4, §6, §5 failure museum, Annex A substrate, every facsimile, the rule-plus-failure-class dual statement | **stayed in core** as current law | core headers §1–§6 present; §5 kept (§5.1–§5.9, incl. §5.5 at core:4296 — the ADR §4 judgement); Annex A A.1–A.8 present (core:5328+); seal facsimile present (core:2720–2783); large-file threshold present as current law (core:2178–2180, 5453) |
| the revision archaeology — every preserved superseded claim | **companion Part I** | §6 below |
| Annex B (edition ledgers, owed-acts, conditions) | **companion Part II / Annex B** (S2, 752 lines) | companion:641+ |
| Annex C (the name map) | **companion Annex C** | companion:1523+ |
| the edition genealogy | **companion Part IV** | companion:1607+ |

The core carries the split's governing rule and derivation where its readers meet
them; the companion carries the manifest (Part 0). Property 1 of ADR §3.1 ("the
core governs where the two disagree") is stated in both (core front matter;
companion:38–46). Property 3 ("the derivation is stated in both so a reviewer can
verify") holds: Part 0 is the reviewer's artefact and it is what made this audit
executable.

## 4. The diff accounting (falsifier 4, re-executed)

`git diff d96a5b1 HEAD -- docs/PROCESS.md`: **1,588 lines added, 1,496 removed.**
Classifying the 1,494 removed content lines against both current volumes:

| Disposition | Lines |
|---|---|
| trivial (blank, fences, table rules) | 118 |
| found verbatim in the **companion** | 1,025 |
| found in the current **core** (moved-within / reflow) | 79 |
| not matched by exact normalised line | 272 |

The 272 exact-miss lines were then 6-gram-scored; 199 fell below 0.6 coverage.
Inspecting those 199, **every one resolves to a benign class**: the fifth
edition's own edition anchor and provenance sentences; its table of contents and
index counts; its per-edition sentinel census ("returns **50**", now 52); its
"this edition / previous edition" revision narrative; and reworded current-law
prose whose substance is present in the current core (e.g. the §6 adoption
chapter and seal facsimile, rewritten between the 5th and 7th editions with the
superseded originals preserved in the companion). **No substantive rule, claim,
or facsimile from the fifth edition was found absent from both volumes.**

## 5. The four falsifiers, re-run

1. `grep -c 'SUPERSEDED — historical record, not current law:' docs/PROCESS.md`
   → **0** (also 0 for the broader token `SUPERSEDED — historical record`). The
   committed enforcement `scripts/check_process_doc.sh` → **`OK`**.
2. Every companion Part I anchor names a core section that exists — spot-confirmed
   across §1.5, §2.6, §3.4, §4.7, §6.0.
3. The three committed line counts of companion §0.3 reproduce (5,446 / 5,538 /
   2,028), and the subtraction is the growth claimed.
4. `git diff d96a5b1 HEAD -- docs/PROCESS.md` with the **fifth edition itself** as
   the yardstick — §4 above. This is the one falsifier that catches a silent
   deletion, and it is the one the sixth edition got structurally wrong (it
   diffed against its own manifest — self-check against a list the same edition
   wrote). Run correctly here, it comes back clean for the **current** state.

## 6. First-edition preservation — the decisive reconciliation

The sentinel `SUPERSEDED — historical record, not current law:` marks every
preserved superseded claim. Its census across committed states:

| State | Token total | Mentions | **Preserved-claim uses** |
|---|---|---|---|
| fifth edition `d96a5b1` (core) | 50 | 3 | **47** |
| sixth-edition companion `592926e` | 38 | 5 | **33** — 14 short |
| current companion (HEAD) | 52 | 5 | **47** — 33 + 14 restored |
| current core (HEAD) | 0 | — | 0 |

The preserved-claim count returns to the fifth edition's exactly: **47 = 47.**
Count-match is necessary, not sufficient, so I matched the fifth edition's
preserved claims into the companion **individually**. Of 50 token sites, 44 matched
on the first pass; the 6 exceptions all resolve:

- **#3** — a benign census *mention* ("…which returns **50**"), edition-specific and superseded by "returns 52".
- **#13 / #18 / #21 / #44** — preserved, with relocation-appropriate wording only ("this stamp"→"that stamp" companion:534; "the text said"→"an earlier edition said" companion:567; "canary" added companion:469; a `>` blockquote marker companion:883). Substance intact and marked superseded.
- **#22** — **not a loss**: the fifth-edition §2.6 margin conflated a correction-history ("an earlier table called this threshold *stated* and stated it nowhere") with the actual 1,000,000-byte rule statement. The history is preserved in the companion (§2.6, companion:572–574); the **rule statement is current law in the core** (core:2178–2180, and Annex A.7 core:5453). This is the split operating exactly as designed — archaeology to the memoir, current rule stays as law.

### 6.1 The fourteen restorations, verified verbatim

The companion (§0.1 S4, §0.2a, §0.4, §0.5, B.12) discloses that the split **as
first executed in the sixth edition lost fourteen preserved margins** and that its
falsifier could not see the loss; an independent audit diffing against `d96a5b1`
caught it, and the seventh edition restored all fourteen. I re-verified three,
chosen because they re-anchor the orphaned `[CORRECTED]` stamps:

- **C-33** — fifth `d96a5b1:1276` ("the first edition stated it as an exercised fact") → companion:503, verbatim; core stamp resolves at §1.6 (core:1518) and §1.1's summed table (core:910).
- **C-82** — fifth `d96a5b1:2629` (founding-audit tally quoted from a superseded line) → companion:705; core stamp at §3.4 (core:2942).
- **C-114** — fifth `d96a5b1:3651` ("four commands" where there are three) → companion:812; core stamp at §4.7 (core:4136).

## 7. Sub-answer (b) — the stamp apparatus is not weakened

The posture apparatus that ADR §3.3 (last bullet) and §5.5 keep in the core is
**present in the core as current law**, and was *adapted* to the split rather than
diminished by it:

- **Posture grades still carried in the core** (present-tense counts): `[MC]`×46, `[RE]`×60, `[P1]`×33, `[SF]`×8, `[PLANNED]`×21, `[UNANCHORED]`×5, `[CORRECTED]`×20.
- **The `[CORRECTED · C-nn]` legend was updated for the split** (core:292): "What the superseded claim said, and what refuted it, is preserved in **the companion volume**, under the section this text sits in." That is the apparatus pointing readers across the seam by section anchor — the mechanism by which C-32 (companion:478) and C-93 (companion:729) resolve even though their C-id label is not repeated in the companion.
- **The boundary block stayed** (core:129, 310, 344, 640) — the control ADR §3.3 names for "a reader who over-reads a stamp".
- **§5.5** ("a guard that forecloses conduct is enforced differently from one that routes traffic") stayed (core:4296).
- **Every one of the 12 `[CORRECTED · C-nn]` stamps in the core resolves.** C-33/82/114/32/93 resolve to preserved companion margins. C-77/80/97/123 were **margin-less in the fifth edition itself** (0 sentinel markers follow each of those stamps at `d96a5b1`) — they stamp inline current-law corrections, a pre-existing form, so the split lost no margin for them.
- **WARN-STAMP**: the literal token was only ever an **Annex B.3 ledger row** — in the fifth edition too (`d96a5b1:4961`) — recording it as a PROPOSED-not-in-force instrument (ADR-0021). That ledger row correctly moved to the companion with Annex B (companion:1319). The instrument's **posture declaration stayed in the core**: §2.4(b) "Mechanical refusal over advisory warning" (core:1970), the §5.1 warning corollary (core:4208), and the `[PLANNED · C-53, C-54, C-119]` stamps in the *Read this first* control table (core:913). Nothing about the declaration moved.
- **The posture list itself** — `docs/reports/audit/PROCESS-claims-posture.md`, which every `C-nn` stamp cites — is an audit-owned artefact (88,881 bytes), untouched by the split.

No orphaned stamp remains in the current core. The apparatus was **transiently
weakened by the sixth edition** (14 stamps, including C-33/82/114, "pointed at
preservation that did not exist… meant nothing" — companion:497–502) and the
seventh edition cured it.

## 8. Verdict, and the one qualification

**ACCEPT (a):** as of the current committed state (HEAD `21e7332`; the split's
output stable since `2ed029d`), the split loses nothing — verified against
`d96a5b1` by falsifier 4 and by the exact 47 = 47 preserved-claim reconciliation.

**ACCEPT (b):** the core's remaining stamp apparatus is not weakened; it was
adapted (legend updated to cross the seam) and every core stamp resolves.

**The qualification, stated because the ADR §3.6 "proposed-but-operating" frame
demands the lateness be measurable, not smoothed.** The split *as first executed
in the sixth edition (`592926e`)* did **not** satisfy either sub-answer: it
dropped fourteen preserved margins (census 47→33) and orphaned fourteen stamps,
and its own falsifier was structurally incapable of catching it. Read strictly
against `592926e` alone, row 2 would **REFUSE**. I ACCEPT because the instrument
being countersigned is the artefact as it now stands — the split **plus** its
disclosed repair — and that artefact currently loses nothing and orphans no
stamp. The sixth-edition loss is not hidden: it is recorded with unusual rigor in
the companion (§0.1, §0.2a, §0.4, §0.5, B.11–B.12), and its discovery-and-cure is
the ADR §3.3 compensating control (reviewer verification against the committed
fifth edition) operating exactly as written. That the control fired, caught a
real loss, and the loss was restored verbatim is the strongest available evidence
that the split's derivation is now verifiable rather than merely asserted. A
smaller residue the companion itself flags (one fifth-edition margin, `d96a5b1:4825`,
preserved in B.1 rather than under its Part I anchor — companion:195) is in the
volume, so nothing is lost; only its filing is imperfect, and it is named.

## 9. What this file is not

It is not the acceptance act and not a §7 table edit — those are the
orchestrator's (ADR §8), citing `J-auditor-0029`. It is not a gate signature. It
does not re-open Decision 1 (row 1, dv_lead, ACCEPT at `21e7332`) or the
orchestrator's row 3. It certifies the two sub-answers of row 2 and nothing
wider.
