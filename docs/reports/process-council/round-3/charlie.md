CHARLIE — COLD-READER AUDIT OF /home/user/agentic-fpga/docs/PROCESS.md (third edition, 2026-08-12)

Scope and sampling frame: I read the entire file, lines 1–4142, once, start to finish. I opened no other file in the repository — no journals, no scripts, no constitution — so every finding below is about what the text alone does to a reader with no context. Framework criteria applied where a cold reader can execute them: C3 (human readability), C4 (agent readability), C5 (replicability from the text alone), C9 (internal coherence), with spot observations under C6 and C10. C2/C8 (accuracy against the repo) were outside my brief; several findings below are internal contradictions the C2 reviewer should chase into the record.

A procedural note the council should have first: Annex B.1's final row commissions exactly this reading — "The whole text, read cold... edition 3: owed" — and names four checks (terms inferable, sections reachable, followable without prior editions, cited artifacts locatable by a stranger). This report is that row's instrument; my answers to its four checks close the report. This observation is my own, not the framework's.

Ranking logic: findings that would silently mislead a replicator rank above findings that merely lose a reader; within each class, earliest-encountered first.

————————————————————————
F1 — CRITICAL. The campaign seal — the central artifact of the document's flagship mechanism — has no determinable author, no single freeze point, and no determinable scorer. (C5.8 silent divergence; C9 contradiction hunt. This specific hole is my own finding; the framework's C3.4 density probe points at the mutation record generally but not at this.)

Four passages collide:
- §3 packet table: "Sealed prediction | A frozen expectation... | Whichever seat will be scored | Verbatim". §3.9 says "The subject under test is the test suite" — so the scored party is the verification line.
- §3.9: the auditor "authors defect manifests... the results are scored against predictions sealed before any defect existed", and "the seal that discriminates is the expected message text, taken from whichever assertion speaks first."
- Predicting the exact failure message per seeded class requires knowing both the defect classes and the suite's assertions. If the verification lead seals (per the §3 table), it has read the manifest and the blinding that makes the campaign "a test rather than a confirmation" (§3.3 facsimile's own banner) is destroyed. If the auditor seals, the §3 table's "whichever seat will be scored" is false for the document's most important seal. The text never says which.
- The freeze point is stated twice, differently: §3.9 says "sealed before any defect existed"; §3.3's facsimile says "Frozen by: <seat>, <entry-id>, before any evidence existed". Before-the-manifest and before-the-run are materially different disciplines and the two statements license different ones.
- The scorer: §3.3 says the seal is "scored by the reviewing seat named in the commissioning packet — never by the party whose work the evidence grades." For a campaign that party is the verification line — yet §3.8 has the verification lead's own sign-off carrying "the seeded-defect dispositions", and §3.9's exhibit has "a verification lead reported a campaign in five columns". Who scores a campaign — the auditor, or the seat whose suite is the subject under test — is not answerable from the text.

A reconciling design probably exists in the repository (the packet-path facsimile's comment "a seal ships beside its own commission" hints at seeder-authored twins). But two replicators reading this text will build it differently, at the exact point where independence is the whole payload. Per the framework's own scoring note, C5 is capped by its worst independence-touching leg; this is that leg.

————————————————————————
F2 — MAJOR. Four parameters the text calls stated, literal, or fixed — and never states. (C5.8; this is the document's own convicted class, A.7: "A parameter a document calls stated and does not state is worse than an unstated one: the reader stops looking.")

1. The draft placeholder token. §3: "drafts in flight carry a placeholder rather than a guess (§3.2) — the placeholder is a literal token, not a blank, so that an unallocated id is greppable." The literal token is never given. An adopter must invent one; two adopters invent two; greppability across the ecosystem — the stated purpose — is lost.
2. The packet <TYPE> tokens. The path facsimile is "packets/<TYPE>-NNNN_<slug>.md"; the §3 table names six types in English ("Work order", "Sign-off"...) and never binds them to file tokens. The only bindings leak through examples elsewhere ("WO-0012" in §3.1, "mut/wo-0039-b2" in §3.9). Five of six types have no token anywhere in the document.
3. The bounce revision scheme. §3.2: "A bounced packet carries the numbered defect list and re-issues as a new revision." New identifier, suffix, or in-place rev? Never stated — and §3's own "letter-suffixed splits" are listed as unrouted states, so the reader cannot even infer from that.
4. The E6 threshold. §4.6: "Budget or schedule anomalies past a stated threshold." No threshold is stated anywhere. The document knows — B.8 Refusals item 7 admits "an escalation threshold nobody states" — but that admission is 1,200 lines away and the running line in §4.6 still reads as if the threshold exists. A reader of §4.6 alone inherits a phantom.

————————————————————————
F3 — MAJOR. The cold open fails its own probe: the first 278 lines are the document's epistemology, not the organization. (C3.1.)

From "Read this first" I could not state what the organization is, who commits, or what a gate is — that content first appears at §1.0 (line 279), which is an excellent one-paragraph version buried behind an apparatus preface. The opening lines are dense with unresolvable forward references: line 23–28 invokes "§2.5's declared external dependency", "§6.1 of the first edition", and "§5.8 says prohibitions belong at the top" — three sections the reader has not met, one of them belonging to an edition the reader has never held. "The posture list" is load-bearing at line 37 ("the row number in the posture list that decides the claim") and is located only at line 172–175. The preface's stated justification (§5.8: prohibitions at the top) covers one warning sentence, not 240 lines of stamp semantics, boundary claims, and edition archaeology. A significant fraction of cold readers will not survive to §1.0; the ones who do have been taught to distrust the document before being told what it describes.

————————————————————————
F4 — MAJOR. Navigation: six contents entries over 4,142 lines, and "How to read this" gives no reading paths. (C3.6, C4.5.)

The Contents lists six sections and two annexes; there is no subsection index, so the sponsor's obligations (§4.7), the gate rules (§3.7), the commit-rule table (§2.6) and the adoption checklist (§6.2) are unreachable from the top. "How to read this" (lines 242–261) explains only the rule/failure-class convention and the bold-at-first-use convention; the framework's probe asks for role-based paths (sponsor path, adopter path, reference path) and there are none. The document convicts itself — B.8 Refusal 4: "the sponsor's obligations, the gate rules and the adoption checklist all unreachable from the top" — and defers the repair with a reasoned ground. The conviction is correct; the deferral leaves the defect live for exactly the reader this edition claims to serve.

————————————————————————
F5 — MAJOR. Correction-archaeology is interleaved with normative text at high volume, with inconsistent fencing — and the stamp apparatus, by its own boundary admission, cannot price individual sentences. (C3.5, C4.5.)

A large fraction of the running text narrates prior editions' errors. The fencing is inconsistent: some history is in italic "Margin note" passages (the declared convention, per The dialect), but much is inline — "(Corrected in this edition...)" parentheticals, bold asides ("The two limbs were true separately and false together"), "the previous edition said X" sentences inside normative paragraphs, and whole exhibits about corrections of exhibits (§3.9's second exhibit carries a margin note about what the exhibit used to say). A cold reader cannot mechanically strip history from norm, and an agent extracting the normative core (C4.5's context-budget probe) cannot skip safely. Compounding this, the boundary block in "Read this first" states: "The stamps do not cover this document. They cover the document it used to be... There is no visible seam." Taken together: the reader pays the full parsing cost of ~135 stamps, margins and C-nn citations, and receives — by the document's own admission — assurance only about a superseded 1,445-line state, with no way to tell stamped-then-grown text from new text except where marked. The honesty is real; the cost-benefit for a cold reader is upside down, and §2.7's own observation that "per-claim editing of a document this size does not converge" reads as the document's verdict on its own apparatus.

————————————————————————
F6 — MAJOR. Formless artifact classes: several artifacts a replicator must produce have no shown form, including both rehydration entry points. (C5 legs 4, 6, 7.)

The placement rule ("at most one marked, anonymized facsimile per artifact class", Read this first) permits zero, and zero is what these got:
- Gate checklist: §3.7 describes rules about gates but never shows a checklist row, a signature line, or the "harvest block" ("unchecked boxes that hold the gate closed", §3.10). Leg 7 (pass a gate with the human) is not executable without invention.
- Decision record: fields are listed (§3.6) but no form, no path, and a scope puzzle: "The proposing seat writes the instrument" (§3.6), yet the scope facsimile (§2.3) grants the documentation tree only to the specification lead and orchestrator. How a verification lead's proposed ADR reaches the tree is unstated. (Where decision records live is itself never stated; only the id scheme is.)
- Countersignature: no physical form — where the signature lives, what it looks like. B.8 Refusal 7 admits "the countersignature's physical form" is owed a round; the admission does not help the reader of §3.5.
- Roster file and program-state file: contents sketched in §1.6, formats explicitly ROUTED to the kit and not written (B.8 Refusal 5). These are the first two artifacts a fresh orchestrator reads in the recovery procedure — leg 6 (survive a death) runs through two files the document declines to shape.
- Review verdict: §3.2 says the practiced form is "a verdict section appended to the work order's own return log" — that section's format is never shown.

————————————————————————
F7 — MAJOR. The four most load-bearing words — seat, agent, role, spawn — are never defined, while nine rarer terms get The dialect. (C3.3 jargon ledger.)

"Seat" appears from line 31 and thousands of times after; it is never defined, and its relation to "agent" and "role" is genuinely ambiguous where it matters mechanically: §1.2 says workers "share a journal template per role, with each spawn identified by a token", and "the journal's identity is the role, not the spawn" — so is a worker role one seat with many agents? Is the scope-table row "<worker role>" one seat? §2.2's "Each agent has one reasoning log" is reconcilable with the shared worker journal only through §1.2's aside, and the reader must do that reconciliation with undefined terms. "Posture" — the document's most-used term of art after "seat" — is likewise never defined, only exhibited via the stamp table. Also in this class: "in persona" (§6.2 Step 5, "perform the audit in persona if you must") — a load-bearing instruction in the solo-adopter path whose meaning (in one's own persona? role-playing the auditor?) I could not fix from the text.

————————————————————————
F8 — MEDIUM. Live instances, in the current text, of defect classes the document itself convicts. (C9; feeds C2.)

(a) Compound-stamp defect, convicted twice (§1.1: "A stamp on a compound sentence is a stamp on its strongest limb, and it will be read as a stamp on its weakest"; B.8 items 27 and 37 are limb-splits of exactly this) — and committed live at §2.2: "Which of those fields is structure and which is testimony [MC · C-44]... The byte count is checked by nothing." An [MC] stamp sits on the sentence whose point is that one of its subjects is machine-checked by nothing.
(b) Ten-line self-contradiction in §3: the packet table's Finding row gives relay class "Verbatim when the auditor's" — author-dependent — and the very next paragraph asserts "Relay class is a property of the packet type, not of the round." Both cannot be read literally; the reader must invent a sub-typing (auditor-finding as its own class, as §4.3's list implies) to repair it.
(c) Staleness in "How to read this": "Five that the first edition used without ever introducing are defined in The dialect, above" — over a dialect that now holds nine terms. Strictly parseable as provenance of five of them; reads as an uncorrected count, in the section that tells the reader how to read.

————————————————————————
F9 — MEDIUM, verdict-relevant. The headline claim is disclaimed by the text itself: this document is, by design, not replicable-from-alone. (C5, C10; bears directly on the council's three-grade verdict.)

The claim under audit is "a complete, project-agnostic description... sufficient to hand to a stranger or a blank AI." The document's own placement rule says otherwise: "The shell is the normative source of every grammar. This document carries at most one marked, anonymized facsimile per artifact class — an instance, not a norm" (Read this first), and §6.0 reports the executed measurement: a cold adopter working from the text alone reconstructed the executable layer as "roughly one hundred percent invention." From the text alone, replication fails by construction, and the document says so. The consequence for the verdict: PROCESS.md alone can be at most description-grade with an unusually strong adoption scaffold; any replication-grade or adoption-grade verdict is conditional on the shell — an external repository the document itself instructs readers to treat as "named, not inspected", and whose binding instrument (the doc–shell drift check) "does not exist yet" (§6.0). The council should grade the unit or grade the half, and say which.

————————————————————————
F10 — MEDIUM. The transport layer of the work loop is unstated. (C5.4.)

§2.1's commit handoff (steps 1–5) repairs the first edition's famous gap, but the surrounding conveyance is still missing: step 2 says the acting seat "returns, naming the exact set of paths it touched" — returns through what channel? How a spawned worker receives its packet (embedded in the dispatch text, or by reading the packet file at a stated path?), and in what form "the lead's verdict travels back out through the orchestrator" (§1.1), are never stated. B.8 Refusal 7 admits "the spawn-side mechanics of the loop" are owed. Until then, leg 4 (run one full work cycle) is executable only with invented plumbing.

————————————————————————
F11 — MINOR bundle. (C3.3, C4.3, C6.)

- Annex B uses program identifiers with no mapping from the function names used everywhere else: "dv_lead" (B.1, B.7) is never equated with "the verification lead"; J-auditor-0025, J-dv_lead-0190, F-0022-2, and commit 287b5ee are citable by a stranger only if the journal path scheme — shown solely inside a facsimile marked "instance, not norm" — is trusted as norm anyway. The annex is declared program-local, which mitigates but does not resolve.
- The council's "Tier 1/2/3/4" taxonomy is cited ~30 times as a source ("Source: council verdict Tier 3 coverage") and never decoded.
- "nought of thirty-four stamps" (§6.2 Step 0's HALT-01 note) against "~135 stamps" elsewhere: presumably the [MC] subset, but unreconciled in the text.
- "octopus" (B.8 item 27) is the one unexplained tool-culture word in a document that otherwise scrupulously avoids naming its version-control tool; likewise A.5's "rulesets rather than classic branch protection" and "the picker" assume one unnamed hosting platform's UI.
- The shell's name, "generic-agentic-fpga-org" (§6.0), contains a domain noun in a document whose first content rule is "Excluded: domain nouns." The name is flagged as a deliberate program noun; the domain residue inside it is not flagged.
- A.8's "(opus-class)... (sonnet-class)" are one vendor's tier names, marked as substrate but thinly.
- Forward-reference habit beyond the preface: "its own §6.1 test" is used at §1.4(b) and §1.5 as if it named a known instrument, 2,600 lines before §6.1.

————————————————————————
ANSWERS TO ANNEX B.1's COLD-READER ROW (the four checks the document itself commissions):

1. "The terms it uses are inferable from the text": mostly, with the exceptions in F7 (seat/agent/role/spawn, posture, in persona) — these are inferable in outline and ambiguous exactly where the mechanics turn on them.
2. "Its sections are reachable from its contents": top level only; F4 stands as the document's own Refusal 4 predicted.
3. "A first reader can follow it without the edition it corrects": yes, with substantial effort; the correction-archaeology (F5) must be parsed to be discarded, and the fencing is not uniform enough to skip mechanically.
4. "A stranger can locate every artifact it cites": partial. The posture list (path given), the halt log (path given), and the shell (URL given) — yes. Journal entries, finding ids, ADR files, and gate files — no in-document location rule beyond facsimiles the document itself instructs me not to treat as norms.

————————————————————————
RECOMMENDED VERDICT POSTURE (per framework §4): on the evidence of the text alone, description-grade — a strikingly honest and rationale-rich account — with the replication claim assignable only to the export unit, not to this document, and blocked meanwhile by F1 (independence-touching silent divergence in the campaign-seal mechanism) and F2 (four never-stated stated-parameters). F1 and F2 have crisp acceptance tests: F1 closes when one passage names the seal's author, freeze point, and scorer for a campaign and the §3 table row agrees; F2 closes when the four literals exist in the text or are explicitly re-labeled as adopter-chosen parameters in Annex A's idiom. Per the framework's standing rule I name the defects and the tests, not the wording of the fixes.

File audited: /home/user/agentic-fpga/docs/PROCESS.md (all 4,142 lines; no other file read).
