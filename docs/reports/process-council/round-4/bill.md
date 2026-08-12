# BILL — Adoption Audit of docs/PROCESS.md (fifth edition, 2026-08-12)

Read as: the person standing up a NEW organization from this document — different domain, different team, nothing in common with FPGA. Criteria cited from Sal's framework (C1–C10); findings marked **[own]** where my reading went past the framework. I verified against the live repo and — unlike both cold adoption runs, whose worlds could not reach it — against the actual shell repository, which is public and fetchable.

---

## Findings, ranked by adoption risk

### BILL-01 · MAJOR · C6 + C2 (cross-filed C5.4/C5.5) — The half the adopter is told to "clone and start from" is domain-bound, and the document calls it "extracted project-free" **[own — verified against the live shell]**

§6.0: *"The other half is an executable shell: the machinery, **extracted project-free** into its own repository, which an adopter clones and starts from."*

I fetched the shell (`github.com/renatom11/generic-agentic-fpga-org`, public, HTTP 200). Its README's first line: *"A reusable AI-agent organization **for FPGA programs**."* Its `scripts/policy.sh` hardcodes `KNOWN_AGENTS="orchestrator architect_docs_lead rtl_lead dv_lead auditor rtl_module_dev tb_writer data_wrangler formal_dv"`. Its `agents/charters/rtl_lead.md` opens *"You own every line of shipped HDL under rtl/"*. Its packet templates carry "Line-rate stress", "Mutation kills: N/N", "tb_writer WOs deliberately omit RTL source". The shell is generic across FPGA projects — not across domains.

PROCESS.md §1–§6 is scrupulously de-domained ("Seats are named by function"), so the *document* keeps its agnosticism claim — but the export unit does not, and the document never says so. §6.2 contains **no de-domaining step for the kit**: an alien-domain adopter reaching act 1b–1c discovers that the charters, launcher prompts, `KNOWN_AGENTS`, scope rows, packet templates, README, sponsor guide — most of the machinery's non-script surface — must be rewritten, with no inventory of what is domain-load versus mechanism. The only hint is Annex C's fork instruction ("delete whole and write your own"), which covers the document's name map, not the shell's files. The shell's very name embeds the domain; §6.0 flags it as "a program noun, deliberately" without flagging that it names a *domain*.

**Repair**: either re-label the shell honestly (FPGA-generic) and add a §6.2 act "de-domain the kit," with a file-by-file inventory of domain-bound kit surfaces; or produce the actually domain-free shell the sentence claims.

### BILL-02 · MAJOR · C5.1 + C9 — Two adoption orders exist; the document never mentions the second; the only tested path is the one an adopter with the shell would not take **[own]**

§6.2 is a build-up-from-empty-repo order (Steps 0–6, acts 1a–1d). The shell ships its own, different order: `BOOTSTRAP.md` — *"from cloned shell to running program"* — a **fork-based** flow (Stage 0: enable Actions, rulesets on `main` and `fed/**`, G0 intake rows, "Repo role" board lines, org-generic/federation concepts that appear nowhere in PROCESS.md). PROCESS.md never names `BOOTSTRAP.md`; §6.0's thirteen-row kit table has no row for it; no precedence rule connects the two procedures. The document's "the shell wins" rule (*Read this first*) governs **grammars**, not procedures.

Worse for the replication claim: both executed adoption runs ran in worlds that could not reach the shell — §6.2 admits *"the unit's own bet … is therefore half-vindicated and half-untested: the reasons half now transfers, and nothing about the machine half was verifiable from that world."* So the **normal** adopter's path — clone/fork the shell, follow which order? — has never been executed against this document at all. An adopter holding both halves on day one faces two checklists that disagree on branch topology, gate rows, and founding sequence, with no tiebreaker.

**Repair**: add `BOOTSTRAP.md` to the kit table; state which order governs when the shell is reachable (§6.2 as the shell-less fallback would be a defensible split); schedule a with-shell adoption run as the next dated condition.

### BILL-03 · MAJOR · C5.1/C5.6 + C9.4 — §6.2 ships its own convicted order defects with a time budget instead of one-line repairs

§6.2 names them itself: *"five of the seventeen are order defects rather than substrate facts — the founding range, the committing seat's roster row that no act activates, the program-state file no step schedules, the roster-column mismatch between act 1a and §1.6's facsimile, and the undefined bootstrap range at Step 5"* — then budgets *"About an hour each for the five order defects above, which should be zero and are not."* Only the founding-range mechanism was actually repaired (B.10 item 13). Verified against the current text:

- **Act 1a vs §1.6 facsimile (HALT-04)**: 1a demands columns "function … the scope it will hold"; the facsimile it cites has `Seat | Tier | Reports to | Charter | Journal | Status` — no scope, no function, plus a Reports-to column 1a never mentions. Still mismatched.
- **Committing seat's roster row (HALT-07)**: act 1c flips *planned → active* for "every remaining seat"; act 1b names no flip, so by the letter the sole committer is never activated. Still unrepaired.
- **Program-state file (HALT-16)**: §1.6 makes it the **first file of the recovery sequence**; no step of §6.2 creates it. Still unscheduled. (The journal INDEX, also one of §1.6's six memory artifacts, is likewise never scheduled — my addition.)
- **"Bootstrap range" (HALT-14)**: Step 5 and the DoD still say "the whole bootstrap range" — undefined, and not obviously equal to the now-defined "founding range" (acts 1a+1b); Step 5's "a seat that did not exist during it" is unsatisfiable even in staffed adoptions, since the auditor is created inside the range it audits.
- **Step 1 preamble (HALT-05)**: *"before the first commit you intend to keep"* still stands — the run filed it as unsatisfiable as written (all four acts are kept commits).

These are one-line fixes the fifth edition chose to confess rather than make, and the confession sits in a dense preamble paragraph an executor in checklist mode will skip. Every fresh adopter re-pays roughly a day of known potholes.

**Repair**: fix the four; where a fix is genuinely out of scope, move the warning into the step it convicts.

### BILL-04 · MAJOR · C5.4 + C10 — The document's entire evidence apparatus lives in a repository the document never locates **[own]**

Every `C-nn` stamp cites `docs/reports/audit/PROCESS-claims-posture.md` "in this program's repository"; §6.2 cites the two halt logs; B.0 cites the cold-reader reports — all paths **in the origin repo**, whose name and address appear nowhere in PROCESS.md (grep confirms: the only URL in the document is the shell's). The fourth edition fixed "stamps cite an artifact with no path"; the fifth ships the same defect one level up — **path with no host**. The stated audience (a stranger handed the document) cannot resolve a single citation; the only recovery route is an undocumented one-hop back-link from the shell's README to `github.com/renatom11/agentic-fpga`. The pin's own escape hatch — *"checkable from a clone of it"* — presumes a clone the reader cannot locate. And nothing states the dependency that the origin repo *remain public*: if it goes private, the posture list, both halt logs, and every "committed verbatim at…" anchor become testimony again, silently.

**Repair**: one line in the edition anchor naming the origin repository's address and its visibility as a standing dependency of the evidence apparatus — or an explicit statement that the record is not reachable to adopters and the stamps are to be read as unverifiable from outside.

### BILL-05 · MAJOR · C1.5 + C5.3 — The charter question: the document exports one charter's substance and eight charters' *field names*, while leaning on the other eight elsewhere

The owner asked whether the document "doesn't talk too much about the specific charters." The split it chose is principled — §1.5 exports the auditor's five load-bearing mechanisms in prose and routes the artifact to the kit ("export the artifact once, in the half that runs; export the reasons in the half that explains") — and §1.3's nine-section list is now complete. But the document leans on charter-carried duties of **other** seats that neither §1.3's list nor any facsimile regenerates:

- §1.4(e): the anchor-ordering check *"is a named precondition in the verification lead's charter"* — an adopter authoring that charter from §1.3's nine sections will not put it there.
- §3.9: *"the 'report, never repair a suspected seeded defect' clauses in the builder charters"* — named once, in a subordinate clause, in the campaign section.
- §1.2's leads' line-by-line worker-review duty, and the orchestrator's three transcription duties, are scattered as prose.

The kit table's "charter template" row asserts *"Every artifact above exists, in its original form, in the repository that paid for it — that is checkable from a clone"* — checked: the charter directory contains **nine real FPGA charters and no template**; B.8 refusal 5 itself records the slotted template as *"Named as owed; not applied in either direction this round."* So the answer to the owner's question is: the document talks the right amount about the auditor's charter and too little about the rest — not more charter *prose*, but a per-seat index of the charter clauses this document references elsewhere, so an adopter authoring charters at act 1c can check completeness.

### BILL-06 · MAJOR · C3 (the "does it make sense to a human?" finding) — The memoir is fused to the law, the separation is twice-refused, and every adopter pays the strip individually

The document's own external graders answered the human-readability question: *"accurate, navigable, and not yet hospitable"*; *"readable with sustained effort, roughly a B-minus"*; report card: readability B−, conciseness C+, chunked-retrieval C. Those graded the **fourth** edition; the fifth's repairs (pointerization, sentinels, seam column) have been audited by no cold reader (B.0.3 is OPEN, and the fifth edition was written single-seat — §5.7's root class, disclosed at B.0.3).

The adoption cost is concrete: 5,446 lines of which ~670 (Annex B) are "delete whole" on fork, 50 SUPERSEDED sentinels, ~135 stamps each owing a per-mark fork act, 70 annex pointers whose referents are program-local. The council's own prescribed repair — *"executing the fork contract once, exporter-side, to produce a stripped rule-first adopter's edition"* — was named "the fifth edition's act" (B.9 refusal 1) and refused again (B.10 refusal 1: *"the endorsement is now overdue"*). Result: the exporter has outsourced the memoir-stripping to every adopter individually. And HALT-03 remains unrepaired: **the document never says whether an adopter executing §6.2 is a "fork" owing the §6.1 contract at all** — run 2 had to invent the split. The prose itself is a further tax: sentences routinely carry two or three normative clauses plus a self-commentary clause (C3.6), a register that an AI parses and a human survives.

**Repair**: already named in the record — execute the fork contract exporter-side once; and add one sentence connecting §6.1 to §6.2 (adopt-without-republishing ⇒ trace table + own name map; republish ⇒ full contract).

### BILL-07 · MAJOR (disclosed, but the export lacks the cure) · C7/C8 + C5 — The exported control class "review-enforced, on a cadence" has no working keep-alive mechanism, and the document knows it **[own]**

§1.1's summed table is the document's best honesty: the review-enforced tier — *"the majority tier — has been substantially dormant since ratification"*; *"a cadence written into a charter is owned by whoever spawns that seat"*; the fix is *"routed as an amendment candidate"* (B.2 item 10) — i.e., **not enacted anywhere**. Meanwhile §6.2's DoD requires the adopter to build a residue file whose *"cadence column is the one that matters"*. So the adopter is handed a residue register whose cadence cells, per the origin's own measured record, do nothing by themselves, and the mechanism that would make them fire (spawner-owned scheduling, a "next due" column, a gate that blocks on overdue cadences) is not part of the export in any form. This is the failure the document itself calls "the failure that eats the rest" — exported as a confession, not as a control.

**Repair**: promote B.2 item 10's closing event into the export: one paragraph in §6.2/§1.1 telling the adopter to bind each residue cadence to a gate row or to the spawner's charter on day one, since the charter-only form is the measured failure.

### BILL-08 · MINOR · C2 — The kit table's existence claim is stretched for its two "template" rows

*"The constitution template — §2's rules as a document a program can amend … this document's companion constitution."* The original is `agents/PROTOCOL.md` — the real FPGA constitution, not a template ("companion constitution" is also unresolvable wording for a stranger). Same for the charter template (see BILL-05). The table's blanket assertion — "Every artifact above exists, in its original form … checkable from a clone" — is true only under the reading "an *instance* exists from which you could make a template," which is not what "template" says. Act 1d partially compensates (*"Write it by reading what your scripts actually refuse, not by transcribing this document"*), which is the right instruction and quietly concedes the template isn't one.

### BILL-09 · MINOR · C5.5 — Annex A.3's "measure yours" is not executable on line-based readers, filed by run 2 and untouched

A.3 anchors journal thresholds to "the maximum bytes the agents' file-reading tool returns in one call." HALT-08: in a line-based substrate (2,000-line reads, per-line truncation) *"the anchor's quantity does not exist in this substrate's terms."* The run's improvisation (adopt the figures, declared unmeasured, residue-rowed) is good and is exactly what A.3 should now say as its fallback. Not in B.10; unrepaired.

### BILL-10 · MINOR · C4.4 — Chunk-independence: the stamp and pointer dialect decodes only via the preamble legend

A windowed reader landing in §2.6 meets `[MC · C-64]`, `[CORRECTED · C-67]`, `[B.8·15]` with no nearby key; the legend lives ~1,700 lines earlier. The SUPERSEDED sentinel is the counter-example done right — self-describing at the point of use ("historical record, not current law" is the decode). A one-line legend stub at the head of §2 and §3, or making the stamp self-describing (`[MC=machine-checked · C-64]` at first use per major section), would close it. Similarly, the "one canonical statement plus pointers" dedupe rule (fifth edition) trades chunk-safety for conciseness: a fragment now often contains the pointer, not the fact.

### BILL-11 · NOTE · C7 — Enforcement honesty is this document's strength; the one residue an adopter should still not inherit as a wall

The posture apparatus, the two-surface vocabulary, the R9-branch-limb "no script anywhere," the §2.5 size-check exception, §3.7's staged-by-signer probe — all survive checking against `scripts/` and PROTOCOL. The remaining trap is inherited confidence in the **facsimiles**: nothing has ever checked doc-vs-shell (the drift check is *"named in three consecutive editions and built in none; it is the oldest unpaid item in this annex"*, B.2 item 9, now due "before any sixth edition"). The document discloses this loudly; the adoption consequence it does not spell out is that Step 0's facsimile-vs-shell diff is currently the **adopter's only** protection, performed with Annex C as the map — and Annex C maps the *origin's* paths, which happen to match the shell's today by construction, not by contract.

### BILL-12 · NOTE · C9 — Small internal wobble in §6.1's "Transfers directly" list

The list includes "the write-scope table" while §2.3's facsimile says *"The contents are yours to write; the shape is the mechanism."* A hurried adopter reads §6.1 as "import the table." One word ("the write-scope **mechanism**") fixes it. Same shape: "the seat topology" transfers, but §1.2 deliberately does not fix worker roles (HALT-09: number, line assignment, contingent-seat mandatoriness all undetermined — routed to a kit template that does not exist yet).

---

## What transfers as-is vs. what must be re-derived (as the document leaves it)

**Transfers as-is, and genuinely**: the two monopolies and their postures; R1–R11 semantics with surfaces (§2.6 facsimile — run 2 consumed every grammar facsimile without invention); journal entry/trailer/volume-header/scope-table/gate/packet grammars; §1.7's four founding acts; §3.3's seal mechanism (now single-sourced, cast-listed, and cold-reader-validated); §3.9's scoring rulings ("import the rules; re-derive the numbers"); the failure museum; Annex A's substrate framing.

**Must be re-derived, and the document says so**: roster and worker decomposition; scope-table contents; MC/RE/should-not-exist judgment (§6.1 "has to be re-earned"); thresholds (A.7, A.9); E6 threshold; every stamp (fork contract); every facsimile against the shell (Step 0).

**Must be re-derived, and the document does NOT say so**: the de-domaining of the shell's kit (BILL-01); the choice between §6.2 and BOOTSTRAP.md (BILL-02); a working cadence mechanism for the review-enforced tier (BILL-07); the charter clauses of the non-auditor seats that the document references elsewhere (BILL-05).

**Says import, should say re-verify**: nothing found — the document's central imperative ("do not import any statement that a control is mechanically enforced; check it in your own machinery") is stated at the top, in the imperative, and the fork contract operationalizes it. **Says re-verify, could safely say import**: also essentially nothing — the calibration is right. This axis is the document's best.

## Day one, concretely

An adopter with network access can reach the shell (I did; both tested runs could not — the tested world is not the real one, BILL-02). They then hit, in order: the fork-or-adopt ambiguity (HALT-03, unrepaired); the roster-column mismatch at act 1a (HALT-04, unrepaired); the domain surgery on the kit at 1b–1c (BILL-01, undocumented); the never-activated committer row (HALT-07, unrepaired); a first live-fire failure of their own machinery (now budgeted — the fifth edition's best single adoption repair, B.10·14); the missing program-state file at recovery time (HALT-16, unrepaired); and an evidence apparatus whose every citation points into a repository the document never locates (BILL-04). None of these is fatal — run 2 finished with zero stops, and the solo-adopter honesty blocks (open gate rows, declared fictions) are exemplary — but four of the seven are defects the document has already convicted itself of and left standing.

## Verdict on the adoption story

For a same-substrate adopter building another FPGA-adjacent program with the shell in hand: **FIT WITH REPAIRS** — the repairs being BILL-02, -03, -04, none structural. For the audience the document actually claims — a stranger in a different domain: the document half of the unit is honest, mechanism-complete to an unusual degree, and its self-scoping (*"a falling stop count over a flat halt count is a document that has stopped being unexecutable and has not yet become determinate"*) is accurate; but the unit's machine half carries an undisclosed domain load (BILL-01), the with-shell path is untested (BILL-02), and the human-readability repair the council prescribed has been refused twice (BILL-06). The replication claim, as the document itself scopes it — belonging to the unit, not the text — does not yet survive for the different-domain adopter, and the document's one materially false sentence about that is "extracted project-free."
