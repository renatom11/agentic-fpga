# CHARLIE — Cold-Reader Audit of docs/PROCESS.md

## Frame and sampling disclosure

I read the entire document (2,973 lines), once, in order, with no access to any other file in the repository and no prior knowledge of the project. Per my mandate I could not run Sal's reality-checking criteria (C2 accuracy-vs-repo, C7 posture-vs-scripts, C1's repo-built inventory); where those criteria have a text-alone shadow — can the reader locate, parse, and implement what is claimed — I applied that shadow and tagged it. Criteria applied as a cold reader: C3 (human readability), C4 (AI readability), C5 (blank-AI replicability from the text), C9 (internal consistency), C10 (edition control), and fragments of C1/C6 visible from the text alone. Findings marked **[own]** are from my reading and not from any framework probe.

Calibration, so the convictions are sharp: the document does not lose me at the top level. §1.0's one-paragraph version answers "who commits, who spawns, why the auditor cannot fix, what a journal is for, what the sponsor does" (C3.1 passes); §2.1's five-step commit procedure, the §2.6 table with its "enforced where" column, the §3.2 state machine, and Annex A are genuinely implementable prose. The failures below are therefore not diffuse; they cluster in specific, fixable places.

---

## FINDING 1 — CRITICAL — The other half of the export unit cannot be found from the document, and the grammars the preamble promises are not in it. (C5.1, C5.3, C4.3, C4.5, C9.4)

The preamble states: *"The other half is an executable shell, named in §6.0"* ("Read this first"). §6.0 never names it. It says only: *"The other half is an executable **shell**: the machinery, extracted project-free into its own repository, which an adopter clones and starts from"* — no repository name, no location, no identifier of any kind. §6.0 then instructs the adopter to *"treat the shell as named, not as inspected"* — but it is not even named. A cold reader cannot clone, obtain, or verify half of the export unit, and §6.0 itself concedes the doc-shell drift check *"does not exist yet."*

This matters doubly because the document leans on the shell to discharge exactly the material it promises to contain but does not. The preamble claims: *"Included: mechanism. The commit-script contract, the scope-table format, the entry grammar, the packet forms. These carry no domain and an adopter cannot build the layer without them."* Test that claim against the text:

- **The entry grammar is not given.** §3.1 lists the header's *components* ("entry id, timestamp, the work-order id or `none`, and a one-line title") and eight section names, but no literal format, template, or example. Consequently §3.1's own rule — *"An entry body may never contain a line that looks like its own journal's entry header at the start of a line… because the parsers are deliberately simple"* `[MC · C-74]` — is unimplementable: I am never shown what an entry header looks like, so I cannot write the parser, the refusal, or a compliant entry.
- **The trailer block is not given.** §2.1: the mark for a work-free commit *"is a named trailer"* — the name is never stated; *"the entry's file list must be the empty marker"* — the empty marker is never defined. §2.6: *"protected keys cannot be shadowed or duplicated"* — the protected keys are never enumerated.
- **No identifier templates exist in the body.** Packet, decision-record, finding, and journal-entry ID schemes appear nowhere in §1–§6 — and then surface, unexplained, as `J-auditor-0025`, `J-dv_lead-0190`, `F-0025-A`, `F-0022-2`, `ADR-0021` in Annex B. The annex declares itself program-local, but this is the only place the reader ever glimpses the ID grammar an adopter must reproduce, and it is never explained. §3.2's *"drafts in flight use a placeholder"* — the placeholder is unspecified.
- **"Marked references" have no marking convention.** §3.9's entire campaign model rests on *"ordinary commits pushed to marked references that are never merged"*; how a reference is marked (naming? prefix? the text hints at "fifteen campaign prefixes" without stating a rule) is never specified, and the never-merged property's standing measurement duty is assigned to no named cadence.

Consequence to an adopter: replication from the text alone fails precisely at the layer the document says "an adopter cannot build … without." The document's honesty about the shell being the carrier (§6.0, §6.3) does not cure this — it aggravates it, because the carrier is unobtainable from the document.

---

## FINDING 2 — CRITICAL — The document's entire evidential apparatus cites an artifact the reader cannot locate, and the edition itself has no anchor. (C10.1, C9.4, C5.1) [partly own]

Every claim's authority is a stamp of the form `[MC · C-nn]`, defined as *"the row number in the posture list that decides the claim"* ("Read this first"). The posture list is never given a path, a filename, an owner-artifact identity, or a place in the §6.0 kit table. Annex B implies it is an auditor artifact (the census row cites `J-auditor-0025`), but a cold reader cannot resolve a single stamp to a checkable row. The document's own evidence rule — *"a claim whose support cannot be re-executed may not be stated as fact"* (§1.4(d), citing §3.1) — is thus violated, for the document-only reader, by all ~135 stamps.

Compounding it: the edition has no identity. The text says "at this writing" (§1.1, §2.2), "at this revision's own commit" (§3.9 — the commit is never named), "this edition" throughout — with no version string, no date line, no commit anchor anywhere. The only commit hash in the document is `287b5ee`, anchoring ADR-0021 in B.3, not the edition. A reader cannot tell what repo state the document describes, whether it pre- or post-dates any amendment, or when "at this writing" was. Nor is there any standing rule binding this document into the amendment procedure of §2.7 (C10.2): nothing says a constitutional amendment obliges a PROCESS re-edition; the update contract is inferable only from Annex B's debts.

Consequence: the stamping discipline — the document's central innovation and its main defense against the failure it warns of — is, to its primary audience (strangers), testimony. The fix is one line per gap: name the posture list's path and ship it in §6.0's table; put an edition/date/commit line at the top.

---

## FINDING 3 — MAJOR — The document is architected as an erratum to an absent first edition, and norms must be reverse-engineered from correction narratives. (C3, C3.5, C4.7) [own]

A large fraction of the text states the current rule only by contrast with what "the first edition" wrongly said — and the reader does not have the first edition. Convictions:

- §1.4 opens with a parenthetical that is pure revision archaeology: *"(The first edition's header said "three lines" over a list of four. It was a count of the organization's three working lines… sitting over a list of four separations…)"* — this is the first paragraph of the section defining the separations of duties, and it is unintelligible before the list it prefaces has been read.
- §3.9's second exhibit ("The survivor whose rehabilitation expires") consists almost entirely of a description of what the passage *used to say and no longer does*: *"(Corrected, and the correction is the exhibit's whole point. This passage previously opened on a defect 'later said to be handled…' — an event this record does not contain…)"*. The actual incident must be inferred from the negative space of a retracted account.
- Two stamps reference a section number that only exists in the absent edition: §1.4(b) *"survives its own §6.1 test unqualified"* and §1.5 *"survived its own §6.1 test"* — but in *this* edition the test lives at the top ("Read this first" says so explicitly: *"This warning sat in §6.1 of the first edition"*), and the current §6.1 holds only a pointer. The cross-reference is anachronistic, keyed to a document the reader cannot open.
- The stamp legend directs the reader to "the margin" (*"What the first edition said, and what refuted it, is stated in the margin"*) — but this is a flat file with no margins; the reader must learn by exposure that italic paragraphs labeled "*Margin note*" are meant (C3.5, minor but disorienting on first contact).

Consequence: the reader's working memory is spent tracking a two-edition diff instead of the mechanism. Much of this material is genuinely valuable (the corrections are often the lesson), but the *rule* should be stated plainly first and the correction layered behind it — Sal's guidance #3 (progressive disclosure) names the remedy exactly. As written, several rules (§1.4's separation count, §3.9's survivor discipline, §5.5's posture-declaration practice) exist only inside their own correction stories.

---

## FINDING 4 — MAJOR — The domain of the enforcement surfaces is never delimited, which makes the [MC] stamps ambiguous in exactly the cases the record contains. (C5.3, C7-shadow, C9.2) [own]

§2.5 claims CI re-verifies *"the entire pushed history."* §3.9 says every campaign ran as *"ordinary commits pushed to marked references that are never merged"* — eighty-six of them. Are pushed-but-never-merged references inside "the entire pushed history" or not? The document never says which refs/branches either surface (commit script, CI re-check) actually covers.

The ambiguity is not academic, because the record as narrated appears to contradict the stamps and the reconciliation is left to the reader. §1.5 stamps the auditor's write restriction *"enforced mechanically"* `[MC · C-25]` — *"the one that survived its own §6.1 test with no qualification at all"* — and `[MC · C-26]` (*"it cannot stage the artifact it would repair"*). Yet §1.1 records that the auditor *"cut, committed and pushed five transient references on the orchestrator's own dispatch, plus three earlier deviations of the same shape."* How did a mechanically-refused act happen eight times? The available reconciliation (the script is a voluntarily-invoked wrapper — §2.5 concedes *"every commit tool has a bypass flag"* — and the CI re-check does not adjudicate never-merged refs) is never assembled anywhere in the text. A cold reader either concludes the [MC] stamps are false or constructs the boundary themselves; both are failures of the document. Relatedly, §2.5's "entire pushed history" quantifier — in the very section that convicts the first edition for an *"unqualified quantifier"* — is itself unqualified over the ref population.

Consequence: an adopter cannot state, for any [MC] claim, the surface on which the guarantee holds — which is the precise over-trust failure the stamp system exists to prevent.

---

## FINDING 5 — MAJOR — The "closed" packet taxonomy is contradicted by artifact classes the document itself uses, and the kit omits templates for artifacts the text makes load-bearing. (C9.2, C1, C5.1, C4.4)

§3 declares: *"The taxonomy is closed, and this is it"* — six types (work order, review verdict, sign-off, defect packet, sealed prediction, finding). Then:

- §3.9 introduces **defect manifests**, a **"campaign brief"**, and a **"campaign packet"** (*"the allowlist is carried in the campaign packet"*). None of the three maps to the six types. The manifest is half-mapped ("a defect manifest **is** one of its own reports", §1.5) — to "reports", which is itself not a taxonomy entry (closest is "finding"). The campaign packet is mapped to nothing.
- Decision records (§3.6) and gate checklists (§3.7) are versioned files that carry work/verdicts between seats and sit outside the taxonomy — presumably deliberately, but nothing says whether "packet" rules (state, author, addressee, relay class) bind them.
- §3.1 makes *"the entry template"* a named compensating control (*"The seven narrative sections are carried by the entry template, by review, and by the sampling that is owed"*) — and the entry template appears nowhere in §6.0's kit table. Nor do gate-checklist or decision-record skeletons: the kit's "packet forms" row covers only *"the taxonomy of §3"*, which excludes both.
- Direct inconsistency: §4.3 enumerates the protected relay classes as *"sign-off packets, defect packets, and every auditor finding"* — omitting **sealed predictions**, which the §3 table explicitly marks **Verbatim**. An agent implementing relay policy from §4.3 alone would summarize a seal.

Consequence: an adopter cannot enumerate the artifact classes they must be able to produce, which is C1's silent-omission failure operating inside the document's own artifact chapter.

---

## FINDING 6 — MAJOR — Terms of art used before definition, never defined, or drifting across synonyms — in violation of the document's own introduction rule. (C3.2, C4.4, C9.4, C9.5)

"How to read this" promises: *"Terms this system uses in a particular way are introduced in **bold** at first use."* The dialect section exists because *"a cold reader proved they could not be inferred."* Both are under-delivered:

- **"council"** — never defined, never bolded, not in the §1.2 roster, yet it performs load-bearing review acts three times: *"The council that reviewed it was the first review it ever had"* (§1.4(a)); *"the council that produced this edition"* (§3.1); *"The council that reviewed this document quoted that tally"* (§3.4). Is it a standing body, a convened review round, external reviewers? A cold reader cannot say — and cannot replicate it. (Same for §5's *"the hostile ones"* among "every reviewer of the first edition.")
- **"census"** — used as a named instrument five times (*"the census that re-read every marker"* §1.6; *"the date census re-anchored all of them"* §2.4; *"a program-wide census"* §2.4(b); §5.1; B.1's verdict "CENSUSED") and never defined: who runs one, what triggers one, what its output artifact is.
- **"phase" vs "milestone"** — §3.7's gate set is *"per phase"*; E1 is "Phase-gate approval"; §1.6's drill is *"a scheduled obligation of the first phase"*; §2.6's trunk merges *"at milestone boundaries."* Neither term is defined and their relation is never stated. An adopter cannot build the gate cadence around an undefined unit of program time.
- **"surfaces"** — the two-surface model (local commit path vs pushed-history re-check) is the spine of §2, but "both surfaces" is first used in §1.4(b) (*"Probed in both directions on both surfaces"*), two sections before §2.4–§2.5 explain what a surface is.
- **Synonym drift**: *"task packet"* (§1.0, §1.1) vs *"work order"* (§3.2) — never equated. The sponsor *"reads a single status file"* (§1.2) vs the *"program-state file"* (§1.6) vs the sponsor guide (§4.7/§6.0) — three candidate referents, unresolved. *"transient references"* (§1.1, §2.5) vs *"marked references"* (§3.9) vs *"a working reference"* (§6.2 step 3) — apparently one population under three names. **"dv_lead"** in Annex B is never mapped to "the verification lead" of §1.2 — the reader must decode a domain abbreviation the body's own exclusion rule ("no seat names from the program") forbade itself from explaining.

---

## FINDING 7 — MAJOR — Rules whose enacting artifact or edge case is unstated, so they cannot be implemented as described. (C5.7, C4.2) [own]

- **Countersignature form.** §3.5 gives three properties (narrow, asked of the constrained party, refusable) but never states what a countersignature physically *is* or where it is recorded — a journal entry citing the clause? a line in the decision record? a packet? Contrast §3.7, which does say what a gate signature is (a journal-entry reference in the checklist). An adopter cannot produce or verify a §3.5 signature.
- **Delta-signature ledger.** §3.5: owed traffic *"is recorded as owed until it is paid"*, and *"the ledger has to be somewhere a later reader is obliged to look (§5.5)"* — §5.5 names the property (visible debt), not the location or form; the only worked example, Annex B, is declared program-local and *"an adopter forking this document deletes it."* The mechanism's home is deleted with the example.
- **The canary collides with the machinery as described.** §1.5: the sponsor *"may deliberately plant a process violation — hand-edit a record"* — but §2.2's append-only rules mechanically refuse edited records at commit, and the sponsor is not a committing seat. How a hand-edit canary physically enters the record without being auto-refused (which would test the script, not the auditor) is never explained.
- **Self-acceptance edge in §3.6.** *"A record proposes; a different seat accepts… for anything touching the constitution, the charters or the enforcement scripts it is the orchestrator."* When the orchestrator itself proposes such a record, acceptor = proposer, re-creating §5.7's "permission slip" inside the rule that exists to prevent it. The edge is unaddressed.
- **Worker spawn token.** §1.2: each spawn is *"identified by a token minted into its prompt"* — the token's format and where it must appear in the journal are unspecified, so the shared-journal attribution rule cannot be implemented.
- **E6's threshold.** §4.6: *"Budget or schedule anomalies past a stated threshold"* — stated where, by whom? Escalations are *"batched, not dribbled"* — on what trigger or cadence? Unstated.

---

## FINDING 8 — MODERATE — Direct internal contradictions a cold reader trips on. (C9.2)

- **"The one" vs "one of the claims."** §1.5(1): `[MC · C-25]` is *"of every 'enforced mechanically' claim in the first edition… **the one** that survived its own §6.1 test with no qualification at all."* §1.4(b): `[MC · C-21]` is *"**one of the claims** that survives its own §6.1 test unqualified."* Both cannot be right as written; a reader cannot tell which sentence to trust, which is C4's worst case for retrieval-fed agents.
- **§4.3's protected-class list vs the §3 relay-class table** (sealed predictions omitted — see Finding 5).
- **Ownership vs write scope, unreconciled.** §1.2: the specification lead *"owns… all documentation."* §1.3: *"the charter directory is outside every seat's write scope but the orchestrator's."* Charters are documentation; the document never explains that "owns" and "may stage" are different relations, though the difference silently governs several passages (including who may repair the sponsor guide in B.7 item F-0025-F).
- **§3.9's whiplash on the transient model.** The margin note rules the apply-and-revert description *"wrong against this program's record"*; the very next rule block re-admits it (*"or, where a local run is possible, in a working state that is reverted"*); Annex A.6 then *recommends* it. The three passages are reconcilable (record vs generalized rule vs substrate advice) but only on a second read; the first read registers a contradiction.

---

## FINDING 9 — MODERATE — Front-loaded self-reference and local density pathologies. (C3.1, C3.5)

- "Read this first" opens with three forward references and an edition-history reference in its first ten lines — *"the failure of §2.5's declared external dependency, one level up"*, *"§6.1 of the first edition"*, *"§5.8 says prohibitions belong at the top"* — before the reader knows what a section, a seat, or a posture is. The imperative itself is right (and rightly placed); its justification apparatus belongs behind it, not around it.
- §3.9's frozen-kill bullet is a genuine three-read passage: the three limits, which was disclosed vs found, the five-of-thirty-seven aside, and the retired-namespace consequence are packed into one bullet-length run (*"…the first is disclosed in the clause itself, and the other two were found afterwards, by applying the clause…"*). The calculus is irreducibly intricate (per Sal guidance #3 I do not charge the precision), but it is not layered: no summary sentence precedes it, no example sits beside it.
- §5.1's census figures sentence (*"a majority of the record when measured as drift past a stated tolerance — about two thirds… and in a plurality, about two fifths, when measured as an outright wrong date"*) is deliberately double-banded and still had me re-reading; a two-row table would discharge it.
- Annex B.7's disposition table cites finding IDs (`F-0025-A`…) that resolve to nothing a reader can follow — consistent with B's program-local declaration, but the table is then unverifiable ornament to the cold reader.

---

## FINDING 10 — MODERATE — Coverage gaps visible even without the repository. (C1-shadow, C5.2) [own]

- **Nothing on staffing the seats.** The document distinguishes seat lifetimes (long-running orchestrator, per-packet workers) but says nothing about what kind of agent occupies a seat — capability class, context budget, or how an adopter should decide which seats need stronger reasoners. For a replication document whose seats are AI agents, the silence is conspicuous.
- **The audit-cadence hole is named and then left open.** §1.1's residue note is the document's own diagnosis (*"if you route a residue to your auditor, put the routing on a cadence something else enforces, or you have routed it to nobody"*) and underlies *six of the eight owed postures* — yet no section states what such a cadence mechanism would be (a gate item? a trigger? a standing routine?), and §6.2's adoption checklist asks only that "a cadence for each" exist without one example of an enforceable cadence instrument. The adopter inherits the failure and a warning, not a mechanism.
- **Rehydration triggers.** §1.6 gives the recovery read-order but only for a *fresh* orchestrator; whether/when a live long-running orchestrator re-reads state (context exhaustion? every round?) is unstated.

---

## MINOR ITEMS (collected)

- §3.3: the seal file's state vocabulary (what the *"single line that is flipped at unsealing"* flips between) is never given.
- §3.2: how a bounced packet's *"new revision"* is identified is unstated.
- §6.0's "Where its original lives" column ("this repository, enforcement directory") names no actual paths — while Annex B.2 freely names `scripts/policy.sh` and `docs/gates/**`; the anonymization gradient is inconsistent between the two (C6.5-shadow), and the kit table's vagueness is the unhelpful half.
- The document's authorship (the specification lead) is discoverable only from Annex B.1's incidental phrase *"in the specification lead's words"* — the body never says whose document this is (C10.2).
- "Read this first" scrub verdict, for the record: the body's domain-noun exclusion held under my reading — I found no project noun in §§1–5 outside declared program-local zones; the leak surface is Annex B's ID dialect (Finding 1, 6), which the annex at least declares.

---

## Framework coverage statement

Applied as cold-reader shadows: C3 (Findings 3, 6, 9), C4 (1, 5, 6, 8), C5 (1, 2, 4, 7, 10), C9 (2, 5, 8), C10 (2), C6 (minor items). Not runnable from my seat: C2, C7 (require the repo; note that Finding 4 is the text-side symptom a C7 reviewer should chase), C1's repo-built inventory (Finding 10 is its text-visible remainder), C8 (rationale preservation — for completeness: the failure-class-per-rule structure discharged C8 well in my reading; I found no rule I could not state the failure of, which is the document's strongest property). Findings 3, 4, 7, and 10, and the shell-unnamed limb of Finding 1, are my own beyond Sal's probes and are marked [own].

## Summary for the council

The document teaches its mechanism well and fails at being its own evidence and its own kit. The two CRITICAL findings share one shape: the document points outside itself — to a shell it never names and a posture list it never locates — for exactly the material a stranger needs, while its preamble claims that material is included. The MAJOR findings share another: the second edition's honesty apparatus (corrections, stamps, margins) has been allowed to occupy the structural positions where the plain rule should stand. Both shapes are repairable without weakening a single claim, which under Sal's guidance #3 is the only acceptable repair direction.
