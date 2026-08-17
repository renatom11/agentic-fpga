# ADR-0023: the retraction, mirrored — lessons are local, and they travel by hand

- **Status**: **ACCEPTED** on the sponsor's own direction, which is the
  acceptance authority for this ADR and is quoted in full at §1.1:

  > "I am really curious about doing a full sweep of generic-agentic-fpga-org and
  > making changes when necessary. It was designed to be an installer that you
  > fork and then forked versions would generate rules based on their journal
  > that could flow to the originally installed version but I dont love that
  > anymore. harvesting rules from journal is cool, but it should only be for a
  > local project. maybe it would be cool to have a file that has rules its
  > learned since starting that project that you could give another session so it
  > could learn but it shouldnt be like it currently is"
  > — Renato (sponsor), 2026-08-17, relayed by the orchestrator

  **The acceptance act is a separate orchestrator journal entry** — the
  orchestrator's acceptance entry, this round — under PROTOCOL §11(2), exactly as
  ADR-0019's Status block and Amendment A2 of ADR-0018 say of themselves: if the
  orchestrator does not write it, this ADR is not in force. Nothing here is
  self-ratifying. The direction is the authority for the *practice*; an accepted
  record is a precondition of the *amendment*; and the amendment itself is the
  orchestrator's act at §4.
- **Deciders**: **sponsor** (direction and acceptance authority — the retraction
  is his, reversing his own earlier design after two days); **orchestrator**
  (adoption, and application of §4's PROTOCOL diff under its own identity).
  Not an escalation class raised from below — it arrives from above, like
  ADR-0018 did.
- **Proposed by**: sponsor direction, relayed by the orchestrator; **drafted by**
  `architect_docs_lead`.
- **Work order**: none — dispatch-only round · **Journal**:
  `J-architect_docs_lead-0058`
- **Affects**:
  - `agents/PROTOCOL.md` §7's lessons-harvest paragraph — **diff written here at
    §4, applied by the orchestrator in its own commit citing this ADR**. §3.6's
    rule holds: the instrument does not edit the file it governs.
  - `docs/gates/lessons-harvest-block.md` — **amended in this commit** (§5); it
    is inside this seat's write scope.
  - `docs/LESSONS.md` — **NEW; established here, created and seeded by the
    orchestrator as collator in a following commit** (§2 D2, §6).
  - `agents/handoffs/HT-01_first-harvest-transit.md` — an **appended disposition
    note**, the orchestrator's, as that artifact's author (§6).
  - `tasks/BOARD.md` — the harvest rows' owed obligations re-pointed
    (orchestrator scope, §7).
  - **The shell's PR #3** — closed by the shell's maintainer, an act **outside
    this repository**, recorded here and performed nowhere here (§6.3).
  - **No enforcement script changes.** No `R`-rule is minted, no
    `scripts/test_protocol.sh` case is owed, and **PROTOCOL §11(3) is not
    triggered** — the harvest law is review-enforced throughout, was so before
    this ADR (ADR-0018 §7.4, D7) and is so after it. Stated explicitly because a
    record that is silent about §11(3) invites a reader to assume it forgot.
  - **No frozen spec text, no requirement, no interface record, no closed gate
    checklist.**

---

## 1. Context — the shell retracted the premise, and this program still holds the outbound half

### 1.1 The direction, and what it retracts

The sponsor's words are the Status block's quotation. They are a directive about
**topology**, not about discipline: *"harvesting rules from journal is cool"* is
the practice being kept; *"it should only be for a local project"* is the
destination being taken away; *"a file that has rules its learned since starting
that project that you could give another session"* is the replacement, and it is
a file plus a human, with nothing between them.

**One honesty note on the quotation.** The shell's own ADR-0018 quotes this same
direction with its sentence capitalisation normalised (*"Harvesting …"*,
*"Maybe …"*). The text above is the direction as relayed to this seat, unedited.
The two are the same direction and the difference is typographic; it is recorded
because a record that silently tidies its acceptance authority cannot be checked
against what was said.

### 1.2 What the shell has already done

The shell (`generic-agentic-fpga-org`) executed the direction first. Its
**ADR-0018, "The federation retraction — lessons are local, and they travel by
hand"** (ACCEPTED, sponsor-directed, 2026-08-17) plus a 24-file sweep landed at
shell `main = cb8a9f3`. Its decisions, as they bear on this program:

- The topology collapses to **two roles** — `canonical-shell` (the installer) and
  `project` (a founded copy running one program). This program is a `project`.
- **The harvest law survives unchanged in discipline**: per-sign-off and per-gate
  cadence, tiling spans, nil declared, the three-tier classifier and the
  LH1/LH2/LH3 bars **verbatim**, war stories kept, no counting metric.
- **All destinations are local** — each project's own `docs/LESSONS.md`, which
  **doubles as the hand-carried travel copy** (a board *Lessons baseline* line; a
  human hands the file or its post-baseline tail; seed provenance recorded at the
  receiving end).
- **The shell's corpus grows only by maintainer hand-carry commits.**
- `docs/FEDERATION.md`, `docs/federation/**` (the inbox), and `docs/domains/**`
  are **deleted**; export packets, the sent-ledger, the race law, the standing
  pre-answer, and **both hops** are retired.
- **The sponsor's per-gate lessons touchpoint shrinks to exactly one: the gate
  signature.** No consent question exists, because nothing transmits.

### 1.3 Why this program cannot simply inherit that

**Because this program's constitution still holds the outbound half, and a rule
that binds a working seat is the one nearest to hand.** Four artifacts here still
route learning out of this repository, and all four are live text, not history:

1. **`agents/PROTOCOL.md` §7** — *"The **orchestrator collates**: into the gate
   record locally, and into the generic shell's `LESSONS` file with permalinked
   provenance, the shell unfreezing for **exactly one commit per harvest**,
   sponsor-visible at the gate — the sponsor may refuse a candidate. **Routing**:
   a general candidate goes to the shell's universal set, a domain candidate to
   the pack its note named, which a later project pulls in only if that domain is
   its own."* Every clause of that sentence now names a mechanism that does not
   exist.
2. **This program's own ADR-0018** — §4.2 (the shell-transcription tier), A2-D5
   (*one shell commit per harvest*), and A2 Part B's shell boxes and their
   re-check at `P1-module-ready` (A2-D1/A2-D3).
3. **`docs/gates/lessons-harvest-block.md`** — the tier descriptions (*"to the
   shell's universal set"*, *"to a named domain pack in the shell"*, *"not
   transcribed to the shell"*) and Part B's collation boxes (shell commit, shell
   diff, sponsor-visible).
4. **`agents/handoffs/HT-01_first-harvest-transit.md`** — **EXECUTED**: the one
   delivery this program ever performed. The frozen export packet
   `docs/federation/outbox/SO-xgmii_rx_64.md` (353 candidates from seven minting
   chains) was delivered on 2026-08-11 as shell inbox **PR #3**, and **never
   landed** — the shell's retraction ADR records that no landing ever transited
   either hop. The PR is now open against a deleted directory and a deleted law.

**This ADR is the mirror.** It changes no bar, no span rule, no classifier, no
trigger and no enforcement posture. It moves one arrow.

### 1.4 The measurement that makes the retraction cheap here

The shell's retraction ADR records the standing audit finding on the shell's
board (2026-08-05): **the federation pipeline had zero mechanical test
coverage**, and its first landing was its own designated first test. This
program's side of that is exact and is worth stating rather than inferring: the
outbound pipeline **ran once, delivered once, and landed nothing**. There is no
production behaviour to preserve, and the only artifact with a claim on
continuity is HT-01 — which §6 disposes of by annotation rather than by deletion.

---

## 2. Decision

**D1 — All harvest destinations are local.** The orchestrator collates into the
gate record and into **this repository's own `docs/LESSONS.md`**. **LH2-g**
(general) candidates land in the file's per-harvest / thematic sections;
**LH2-d** (domain) candidates land in **domain-titled sections of the same
file**, their grade noted per entry. **Project-tier statements and war stories
stay exactly where they are today** — journals, packets, and the local accretion
instruments (ADRs, `C-` rows, `R-` rules, spec clauses).

**Nothing else about the harvest changes.** Stated as a list, because an
amendment that does not say what it leaves alone invites a re-reading of
everything: **LH1**, **LH2-g**, **LH2-d** and **LH3** verbatim; the three tiers
and their bars (A1.1–A1.2); **span tiling** as entry-id intervals and A2-D10's
closed end with its self-correcting successor (A2.7); the **nil declaration**
(D4); **war-story retention and re-offerability** (§3.5, A1.3.1); the
**gate-block precondition** (a gate is not passed while any box of the
instantiated block is unchecked); the **classifier and its order** (A1.3, step 0
first, the domain grade reachable only through a general statement that went
hollow); the **in-flight accretion tier** (§1.1); self-mining and who mines
(§3.3, §3.6); collation as **clerical** and the collator's bar on editing a
statement (§4.1); the **seat-qualified id scheme** and its total grandfathering
(A2-D6, A2-D7); the merge clause (A2-D8); the auditor's sampling duty; the
**review-enforced posture** and the refusal to mint an `R`-rule (§7.4).

**D2 — `docs/LESSONS.md` is the travel copy.** Its header states the hand-carry
contract in the file itself, so that a reader who opens only that file learns how
it moves:

> Learning leaves this repository **only when a human hands this file, or its
> post-baseline tail, to another session or project** — and the receiving end
> records where it came from, as **seed provenance**. There is no automatic
> transport, no packet, no inbox, and no consent question, because nothing
> transmits.

**This program inherited no corpus, and its baseline is empty.** The direction of
travel here has only ever been **outward**, and the claim is stated with its
evidence rather than asserted: this repository has never held a `LESSONS` file,
has no inbox, and its harvest law has pointed at another repository from the day
it was written — so **no lesson has ever arrived here**. The shell's 44-entry
starter corpus (`L-A01 … L-F08` at the shell's seeding pin) is recorded at HT-01
§2.1 as a **merge partner** for this program's candidates, never as a source for
them; that it was written from this program's own early experience is the
**orchestrator's relay**, consistent with the shell's own decision 5 (the shell
ships its file as the starter corpus every clone inherits) and **not
independently checkable from a checkout of this repository** — which is the same
honesty this record owes about every shell-side fact it carries (§1.2).

**The file says so**: its baseline line reads *empty — this project inherited no
corpus*, so that a later reader of the travel copy can tell what this program
learned from what it was given, which is the whole function a baseline serves.

**D3 — The outbound transit retires.** Three named instruments go with it:

1. **The shell-transcription tier** — this program's ADR-0018 §4.2, and A2 Part
   B's shell boxes.
2. **The export-packet / outbox / inbox-PR pipeline** — including the packet form
   `docs/federation/outbox/**` as a *destination for future packets*. The one
   packet already there is frozen and stays (§6.2).
3. **The transit packet form `HT-`** — retired as a class. `HT-01` remains as the
   record of the one delivery; no `HT-02` will exist.

**A2-D5 is restated, not deleted.** Its sentence was *"one shell commit per
harvest, never one per gate"*, and the property it bought was that the record
reads as a **list of harvests** rather than a stream of edits. That property is
kept and its site moves:

> **A2-D5, as restated by this ADR: one local landing commit per harvest, in this
> repository — never one per gate.** Several harvests ratified at one gate land
> as several commits, one per harvest, in harvest order.

**A2 Part B's collation boxes are re-scoped to the local landing**: transcription
into `docs/LESSONS.md`; **ids local**, under A2's grandfathered seat-qualified
scheme and unrenumbered; **each landed entry traceable to the note that minted
it**; and **dedup against the file recorded**. The A2.2 partition itself survives
in full — **7 / 4**, seven Part A mining boxes unchanged in wording and in site —
and within Part B exactly one box is swapped (§5.2).

**D4 — The sponsor's candidate-by-candidate refusal power retires with the
transit.** It existed to gate what **left** the program. Nothing leaves. A
refusal power over a movement that does not happen is not a reduced power, it is
a power over nothing, and keeping it as a ceremony would be worse than retiring
it: it would put a human signature on a decision with no object.

**The sponsor's per-gate lessons touchpoint is therefore exactly one: the gate
signature they were already giving.** The harvest table rides the gate record the
sponsor signs, and the landing rides the gate-closing commits. Two consequences,
both owed elsewhere and named here so they are not silently dropped:

- The sponsor's enumerated surface returns to **four standing items** (the six
  escalation classes; the one-time branch-protection setup; the standing canary;
  ratification of the organization). `docs/PROCESS.md` §4.7 item 5 is the
  restatement, and it is **re-editioned in a following commit under §2.7's own
  fourth requirement** — this ADR alters no enforcement semantics, so §2.7(4)'s
  *re-edition or logged waiver* is discharged by the re-edition already scheduled
  this round (§7 row 3).
- `docs/PROCESS.md` §3.10's paragraph on the fifth power, and its
  *"why the granularity is the whole point"* argument, become a **historical**
  argument about a power this program held: correct as written about the world it
  described, and no longer describing this one.

**D5 — HT-01 is dispositioned, not erased.** Five facts, recorded as one
disposition and executed in §6:

1. **EXECUTED stands as history.** The state line is true of what happened.
2. **The delivery mechanism was retracted before any landing.** Nothing this
   program sent was ever adopted anywhere; the shell's own ADR records that no
   landing transited either hop.
3. **PR #3 is closed by the shell's maintainer**, citing the shell's ADR-0018.
   That is an act in another repository, performed by another party, recorded
   here and ordered nowhere.
4. **The packet's 353 candidates land LOCALLY**, as the **first landing** in
   `docs/LESSONS.md`, **seeded verbatim from the frozen outbox packet** — A2-D8's
   bar applies unchanged: **no statement is edited**, and the collator never
   synthesises a sentence. The four **shell-corpus merge pre-judgments** and the
   one **`LD-` domain row** are carried as **recorded annotations** (§6.2).
5. **The outbox file stays frozen in place** as the record of the one delivery.

**And the board's owed item is discharged by this.** *"Part B → `P1-module-ready`
per A2-D1"* is discharged by the local landing, and **re-verified at
`P1-module-ready` exactly as A2-D3 already provides** — a gate re-checks Part A
over its own spans and inherits nothing from a sign-off. A2-D3 needs no amendment
to say this; it already says it about a different destination.

---

## 3. What this ADR does not touch, restated as sites

| Site | Status after this ADR |
|---|---|
| ADR-0018 §§1–12 body, A1 in full | **Stand unedited.** Where §4.2, D5 and D6 name the shell, they are **superseded by this record and not rewritten** — ADR-0003's amendment convention, which A1 and A2 both used |
| ADR-0018 A2's partition (A2-D1 … A2-D4) | **Stands.** Seven Part A boxes, unchanged; an `SO-` instantiates Part A only; a gate re-checks Part A over its own spans |
| ADR-0018 A2-D5 | **Restated** at D3 — count and ordering preserved, site moved |
| ADR-0018 A2-D6 … A2-D12 | **Stand**, verbatim. Ids, grandfathering, the merge clause, the span convention, the near-collision check |
| ADR-0018 A1.7(4) — the parked federation-governance decision | **Retired with its subject.** The question was the acceptance policy for *foreign* lessons arriving at a shared corpus. No shared corpus exists and none arrives. Its four sub-items — the human-merge fence, self-contained incident descriptions, the generality bar as disclosure filter, the exception path for shops that cannot share — are **historical**, and (a)'s principle survives without the pipeline: the travel copy is handed by a human, which is (a)'s "machinery prepares, a human admits" with the machinery removed |
| PROTOCOL §7 Mutation record; §§1–6, §8–§11 | Untouched |
| Seat topology, gates, campaigns, enforcement scripts, CI | Untouched |

---

## 4. The PROTOCOL §7 diff — the source text; applied by the orchestrator

**This section is the authority; the edit to `agents/PROTOCOL.md` is clerical.**
The hunk below is authored here and applied to the constitution by the
**orchestrator**, under `Agent: orchestrator`, with its own journal entry citing
this section as the source. It is **not** in this ADR's commit —
`agents/PROTOCOL.md` is outside this seat's write scope, and ADR-0016 §8 settled
that there is no ADR-driven exception to that: *an agent that can amend the
protocol by citing its own ADR can amend the protocol.* ADR-0018 §8 and A1.6 both
took this route; this is the third.

**One paragraph, one hunk**, inside §7's **Lessons harvest** paragraph. **The
surrounding clauses are kept intact and deliberately**: the sentence before the
replaced passage (war stories, nil declaration), the **gate-block precondition
sentence**, and the ***Enforcement*** note all stand exactly as they are, because
none of them is about the destination.

**The sentences being replaced, quoted from the live file before the diff**, so a
reader can check the hunk against what it claims to remove:

> The **orchestrator collates**: into the gate record locally, and into the
> generic shell's `LESSONS` file with permalinked provenance, the shell
> unfreezing for **exactly one commit per harvest**, sponsor-visible at the gate
> — the sponsor may refuse a candidate. **Routing**: a general candidate goes to
> the shell's universal set, a domain candidate to the pack its note named, which
> a later project pulls in only if that domain is its own.

```diff
 provenance hidden: a general candidate must teach a stranger to the domain, a
 domain candidate a stranger to this project. Anything passing neither grade is
 recorded as a war story and goes no further; a nil yield is declared, never
-omitted. The **orchestrator collates**: into the gate record locally, and into
-the generic shell's `LESSONS` file with permalinked provenance, the shell
-unfreezing for **exactly one commit per harvest**, sponsor-visible at the gate —
-the sponsor may refuse a candidate. **Routing**: a general candidate goes to the
-shell's universal set, a domain candidate to the pack its note named, which a
-later project pulls in only if that domain is its own. A gate is not passed
+omitted. The **orchestrator collates**: into the gate record locally, and into
+this repository's own `docs/LESSONS.md` — the travel copy (ADR-0023) — in
+**exactly one local landing commit per harvest**. **Routing**: a general
+candidate goes to that file's general sections, a domain candidate to a
+domain-titled section of the same file with its grade noted on the entry, which
+a later reader pulls in only if that domain is its own; project-tier statements
+and war stories stay where they already are. **Nothing transmits**: learning
+leaves this repository only when a human hands the file, or its post-baseline
+tail, to another session or project, recorded at the receiving end as seed
+provenance. The sponsor's harvest touchpoint is the gate signature already
+given; the candidate-by-candidate refusal power retires with the transit it
+gated (ADR-0023). A gate is not passed
 while any box of the instantiated `docs/gates/lessons-harvest-block.md` is
 unchecked. *Enforcement*:
 review-enforced, like §10 — no `R`-rule is minted and no script changes, so
 §11(3) owes no test case (ADR-0018 §7.4).
```

**The hunk is machine-checked against the live file**, so the transcriber is not
re-deriving context by eye. Its header is `@@ -347,13 +347,19 @@`, and this
reproduces at this commit — the patch body is extracted from *this section*, so
the check runs against the record's own text and not against a retyped copy:

```sh
sed -n '/^## 4\. The PROTOCOL §7 diff/,/^## 5\./p' \
    docs/adr/ADR-0023-the-retraction-mirrored-lessons-are-local.md \
  | sed -n '/^```diff$/,/^```$/p' | sed '1d;$d' > /tmp/adr23.diff
{ printf -- '--- a/agents/PROTOCOL.md\n+++ b/agents/PROTOCOL.md\n@@ -347,13 +347,19 @@\n'
  cat /tmp/adr23.diff; } | git apply --check -v -
# Checking patch agents/PROTOCOL.md...   (exit 0)
```

*(The nested three-backtick pattern inside the fence is safe and the fence is
deliberately three backticks, matching A1.6's: a closing fence must be a line of
backticks and nothing else, so a line whose backticks sit inside a `sed` argument
closes nothing. Stated because the opposite looks true at a glance, and this seat
briefly acted on the wrong reading before checking it.)*

**What the replacement says, itemised against what it replaces**, because a
reviewer should not have to diff prose in their head:

| The old clause | Its replacement |
|---|---|
| collates into the gate record locally | **unchanged** |
| …and into the generic shell's `LESSONS` file with permalinked provenance | …and into **this repository's own `docs/LESSONS.md` — the travel copy** |
| the shell unfreezing for exactly one commit per harvest | **exactly one local landing commit per harvest** (A2-D5, restated) |
| sponsor-visible at the gate — the sponsor may refuse a candidate | **the sponsor's harvest touchpoint is the gate signature already given**; the refusal power **retires** |
| general → the shell's universal set | general → **that file's general sections** |
| domain → the pack its note named | domain → **a domain-titled section of the same file, grade noted on the entry** |
| …which a later project pulls in only if that domain is its own | …which **a later reader** pulls in only if that domain is its own |
| *(unstated: the project tier)* | **project-tier statements and war stories stay where they already are** |
| *(unstated: how anything leaves)* | **nothing transmits** — hand-carry only, **seed provenance recorded at the receiving end** |

**Still no test case owed.** No `R`-rule is minted, no script changes, no
enforcement semantics move — PROTOCOL §11(3) is untriggered for §7.4's reason,
unamended, and a change of *destination* inside a review-enforced criterion is
not a new enforcement mechanism.

---

## 5. The gate block's edit — performed in this commit

`docs/gates/lessons-harvest-block.md` is **inside this seat's write scope**
(PROTOCOL §6), and this round's dispatched write set is this record, that file
and this seat's journal, so it is amended here rather than owed forward — the
opposite disposition from A2.4's, and for the opposite reason (A2.4's block edit
was owed because the round's write set was one file; this round's is two).

### 5.1 The tier descriptions

| Site | Was | Is |
|---|---|---|
| §2, tier line | *1 general — to the shell's universal set; 2 domain — to a named domain pack in the shell, pulled in by a later project only if that domain is its own* | *1 general — to the lessons file's general sections (`docs/LESSONS.md`); 2 domain — to a domain-titled section of the same file, pulled in by a later reader only if that domain is theirs* |
| §3, Yield caption | *`LC-` = tier 1, general, to the shell's universal set. `LD-` = tier 2, domain, to the named pack.* | the same two sentences, pointed at the file's general and domain-titled sections |
| §3, tier-3 heading | *Tier 3 — war stories and local accretions (**not transcribed to the shell**)* | *…(**not transcribed to the lessons file**)* |
| §3, Yield table, **Disposition** cells | *transcribed as `L-…` / **sponsor-refused*** | *landed as `L-…` in `docs/LESSONS.md` (or in the `<pack-slug>` section) / **deduped against `<L-…>`*** |

**Tier 3's substance does not move.** The heading changes which destination it
excludes them from; the fork it names (war story kept and re-offerable / local
accretion bound by its own artefact) is untouched.

**The Disposition row is a consequence, not a discretionary extra**, and it is
named here rather than left to be noticed: `sponsor-refused` is a disposition D4
retires, and box 9 — which this commit rewrites — points *at this column* for the
pairing record. A column that still offered a shell transcription and a retired
refusal, under a box that now records a local landing, would be a template
instructing its next instantiator to record two things that cannot happen. The
`deduped against` value is box 10's outcome, given a place to be written.

### 5.2 Part B — one box swapped, the count unchanged

- **Box 8** — *shell transcription, exactly one commit* → **local landing,
  exactly one commit** into `docs/LESSONS.md`, containing this harvest's
  admissible candidates — general and domain — and nothing else.
- **Box 9** — the pairing box, re-scoped: **ids are local**, seat-qualified and
  **unrenumbered** (A2-D6/A2-D7), and **each landed entry is traceable to the
  note that minted it**.
- **Box 10** — the *Sponsor-visible* box **retires and its seat is taken by
  dedup**: *dedup against the file recorded* — every candidate checked against
  what `docs/LESSONS.md` already holds, the outcome recorded on its row, a drop
  carrying its reason. **Dedup is clerical; composition is selection** (A2-D8,
  §4.1, unamended).
- **Box 11** — *harvest declared complete by the orchestrator* — **unchanged**.
- **The sponsor-visibility box becomes a standing line, not a box**: the landing
  **rides the gate-closing commits the sponsor already signs**, and there is no
  diff to surface for refusal and no refusal column to fill, because nothing
  leaves (D4).

**Arithmetic, stated because A2 stated it.** A2.2's partition stays **7 / 4** and
a gate still instantiates **eleven** boxes. **Not one Part A box moves, in
wording or in site** — the property A2.3 insisted on. Within Part B one box is
**swapped**, and the swap is deliberate rather than a count-preserving
coincidence: the act that retires (a human being shown a diff before it leaves)
and the act that arrives (a candidate checked against what the file already
holds) are the two acts that only exist on their own side of this retraction.
PROTOCOL §7's sentence keeps its exact meaning at a gate: *a gate is not passed
while any box of the instantiated block is unchecked.* The block's preamble and
the `SO-` deferral line keep the count of four and swap *sponsor visibility* for
*the dedup record* in the list of deferred acts.

### 5.3 The transcriber notes

Three of §4's notes name the retired mechanism and are corrected in place, each
minimally:

1. the **A2-D5 line** (*several shell commits, one per harvest*) takes the local
   landing's wording, citing A2-D5 as restated by D3;
2. the ***you are not the selector*** note's closing clause — *"shapes the shell
   without any note showing it"* — becomes *shapes the **corpus***. **The rule
   itself is verbatim**; only the noun for what a rogue collator distorts moves,
   because the thing distorted is now this file;
3. the **hide-test note**'s *"the last point before the rule leaves this repo"*
   becomes the last point before the rule enters the file a human may hand
   onward. **The test, and both of its strangers, are unchanged.**

**Every other note is untouched** — the "harvest" collision, the
empty-war-stories diagnostic, the all-`LD-` diagnostic, pack names as an
interface, and the closed-gates rule all survive verbatim.

### 5.4 What was deliberately not touched

**Every box about mining, spans, bars, nil yields and war stories is
byte-identical to its previous text**, and so are **§1 in full** (the
instantiation instructions, the seat-qualified id form, the one-row-per-chain
rule, the delete-no-rows rule), **§2's bar table and noun discriminator**, and
**§2.1's classifier**. A partition that also rewrote the boxes would make it
impossible to tell which of two effects a later disagreement is about — A2.4's
sentence, and it holds here for the same reason.

**The block's own historical note is kept as written**, including its sentence
about four boxes an `SO-` was once told to render: it is dated 2026-08-11 and is
true of that day. This ADR's change is recorded as a **second dated note beside
it**, in the same idiom, so the file's amendment history reads forward.

---

## 6. HT-01, the outbox packet, and PR #3

### 6.1 The disposition note — the orchestrator's, appended, never rewritten

`agents/handoffs/HT-01_first-harvest-transit.md` is the **orchestrator's**
artifact (its Author line says so), and its disposition note is therefore the
orchestrator's to append, in the same commit as the constitution's diff or the
one that seeds the file. It is an **appended** note, not an edit: the packet
already carries one appended correction (*"Superseded in part by the shell's own
landing law (2026-08-11, correction appended, not rewritten)"*) and this is the
second, in the same form. **Frozen records are annotated, never rewritten** —
which is also why alternative §8.2 is rejected.

What the note records: the retraction and its authority; that **EXECUTED stands
as history**; that the delivery mechanism was retracted **before any landing**;
that **PR #3 is closed by the shell's maintainer** citing the shell's ADR-0018;
and that the 353 candidates' destination is now this repository's own
`docs/LESSONS.md`, first landing, under D5.

### 6.2 The 353, landing locally

The packet's own tier summary is the seed manifest, and it is used **as frozen**:

- **352 tier-1 (`LC-`) rows** across seven minting chains — dv_lead 94, architect
  94, auditor 54, rtl_lead 50, tb_writer 28, orchestrator 18, data_wrangler 14 —
  into the file's general sections. (94 + 94 + 54 + 50 + 28 + 18 + 14 = 352; dv's
  95th row is the `LD-` below, which is how the packet's 353 resolves.)
- **1 tier-2 (`LD-`) row** — `LD-SO-xgmii_rx_64-1`, dv_lead, pack
  `version-control` — into a domain-titled section, **grade noted on the entry**.
- **47 war stories** stay in their notes. They were never admissible and are not
  admissible now; §3.5's retention and re-offer path is unchanged.
- **No statement is edited** (A2-D8). Ids transfer **seat-qualified and
  unrenumbered** (A2-D6, A2-D7).

**The four merge pre-judgments become annotations, and the reason is worth
stating.** HT-01 §3.3 judged four candidates as merging **to seeded shell
entries** — `ADL-45` → `L-B15`, `rtl H1-8` → `L-D03`, `AUD-14` → `L-C15`,
`AUD-10` → `L-E06`. **Those four partners do not exist in this repository**: the
seeded corpus is the shell's, this program inherited none (D2), and a merge whose
surviving statement lives in another repo cannot be performed here. So the four
land as **ordinary entries carrying their pre-judgment as a recorded
annotation** — the judgement is preserved for whoever reads the travel copy next,
and it is not executed against a partner that is absent. The same applies to
`HT-01` §4's provisional `L-H1-<TAG>-<n>` index, which was already demoted to a
local provisional index by the packet's own appended correction: it is a local
index, and local is now the only kind there is.

### 6.3 PR #3

**Closed by the shell's maintainer, citing the shell's ADR-0018.** This record
neither performs nor orders that act: it is another repository, another party,
and this program has no privileged lane there — which was true under the shell's
federation law (FEDERATION §10) and is true without it. It is recorded here so
that a reader of this program's record is not left with a dangling open PR and no
account of it.

**The outbox file stays.** `docs/federation/outbox/SO-xgmii_rx_64.md` remains
frozen in place as the record of the one delivery ever performed. This repository
does not delete `docs/federation/**` merely because the shell deleted its own: the
shell deleted an **inbox perimeter it operates**; this program holds a **frozen
record of a thing it did**, and the two are different objects.

---

## 7. The owed-restatement list (PROCESS §5.9's cure, part one)

**`docs/PROCESS.md` §5.9 names this program's most-exercised defect**: an
amendment is not landed when its record is accepted, but when **every artifact
that restates the amended rule has been re-quoted**, and its cure's first part is
that *"an amendment record's owed-restatement list names each target file, and
the record is not accepted until each is either re-quoted or carries a dated
refusal."* This is that list. **It is exhaustive over live text**; historical
records — ADR bodies, journals, council reports, the frozen outbox packet — are
**not** rewritten, and §3's table is how a reader knows what still binds.

| # | Artifact | What restates the old routing | Owner | Closing event |
|---|---|---|---|---|
| 1 | `agents/PROTOCOL.md` §7 | the collation and **Routing** sentences (§1.3 item 1) | **orchestrator** | this round's commits — the next commit, applying §4's hunk |
| 2 | `docs/gates/lessons-harvest-block.md` | tier descriptions, Yield caption, tier-3 heading, Part B boxes, two transcriber notes | **architect_docs_lead** | **this commit** — discharged (§5) |
| 3 | `docs/PROCESS.md` §3.10, §4.7, §6.0 | §3.10's destination sentence (*"this program routes admissible candidates into a separate reusable repository (§6.0)"*) and its fifth-standing-power passage; §4.7's item 5 and the five-item count above it; §6.0's ***"How the export actually moves"*** — the four-step outbox → inbox-PR → maintainer-screen → no-privileged-lane pipeline, every step of which is retired. **The export-unit framing itself survives**: the shell is still an installer a project clones, and §6.0's kit inventory is unaffected | **architect_docs_lead** | this round's commits — the **eighth-edition** commit already scheduled this round, under §2.7(4) |
| 4 | `tasks/BOARD.md` | the harvest rows' next-step text (*Part B → `P1-module-ready`*, shell transcription per A2-D5, `LC-`/`LD-` → `L-` at PR close, sponsor visibility) and the `P1-module-ready` gate row | **orchestrator** | this round's commits |
| 5 | `agents/handoffs/HT-01_first-harvest-transit.md` | the transit's live-mechanism framing | **orchestrator** (its author) | this round's commits — the appended disposition note (§6.1) |
| 6 | `docs/PROCESS-MEMOIR.md` | the export-unit rows that name the pipeline as live — the open condition `B.0.4b` (*"halt log returned through the federation inbox"*), the §6.0 disposition rows describing the four-step transit, and Annex C's federation identifier family | **architect_docs_lead** | this round's commits — the same eighth-edition carrier as row 3 |
| 7 | `docs/gates/P1-module-ready-checklist.md` | **an OPEN gate record** whose §7.1 carries harvest 1's Part B against the shell — the outbox link, the inbox PR, the maintainer's id-mapping, the shell-diff sponsor line, the Yield caption, the tier-3 heading, and finding `G-7` (*may a shell commit land before the gate that ratifies it?*) | **architect_docs_lead** | **the next architect round that opens `docs/gates/`** — the same carrier A2.4's five clerical edits already name |

**Rows 6 and 7 were not on this round's dispatched list and are named anyway**,
because a
list that omits a live target is the defect §5.9 exists to catch, minted in the
record that cites it. It is **not** discharged here: this round's dispatched write
set is two files, and A2.4's write-set discipline applies unchanged — an
open gate checklist edited outside its commission is a `Files-in-this-commit` that
disagrees with what was commissioned. **The dated statement of that**: owed
2026-08-17, to `architect_docs_lead`, on the next round that opens `docs/gates/`,
jointly with A2.4's five edits. Finding `G-7` is **answered by retirement** at
that round: the moment question A2 left open had a shell commit for its subject,
and there is no shell commit.

**Two things this list is not.** It is not the ledger — §5.9's second cure part
asks rows to carry a cadence, and these carry a closing event, which is the same
thing said once. And it is not mechanical — §5.9's third part (a grep-based
restatement check) is **not built here**, and its absence is stated rather than
implied.

---

## 8. Alternatives considered

**8.1 Keep the outbound hop dormant** — leave PROTOCOL §7 and the block as they
are, stop using them, and decide later. **Rejected**, on two grounds that point
the same way. First, **the sponsor retracted the premise**, not the schedule: a
dormant hop keeps a rule on the books that the person who owns the design has
said he does not want, and PROCESS §5.9's whole lesson is that the artifact
nearest to hand is the one a working seat obeys — a dormant clause is the stale
one by construction. Second, **a dormant pipeline is exactly the zero-coverage
residue the board's standing audit finding already names** (§1.4): an instrument
with no test, no user and no landing, retained on the chance it is wanted again.
The retention cost is not zero — it is a paragraph in the constitution that every
future seat reads and must be told to ignore.

**8.2 Delete HT-01 and the outbox packet** — the mechanism is gone, so remove its
artifacts. **Rejected.** Frozen records are **annotated, never rewritten**: it is
this program's rule for landed harvest notes (A1.5, A2-D12 — *"nothing is
migrated and no committed harvest is regraded"*), for closed gates (§9), for
`SO-` packets (A2.3), and for its own ADR amendments (ADR-0003's convention,
used by A1 and A2). HT-01 is the record of the one delivery this program ever
made; deleting it would leave the 353's provenance, the extraction fidelity
checks, the merge sweeps and the hide-test verdicts with no committed home, and
would make the local landing at D5 unauditable — the landing's *authority* is
that packet.

**8.3 Land the 353 in the shell anyway, as one hand-carry** — the shell's own
retraction permits maintainer hand-carry commits, so ask for one. **Rejected**,
and the reason is jurisdictional rather than technical. **The shell maintainer's
adoption is a separate, optional act under the shell's own law** (its ADR-0018
decision 5: the corpus grows *only* by maintainer hand-carry, at the maintainer's
choosing, under ordinary review). Treating it as this program's deliverable would
re-create the outbound obligation in the one form the retraction left standing,
and would make this ADR's completion depend on a party that owes it nothing.
**This program's obligation is the local landing**, and it is complete when
`docs/LESSONS.md` holds the 353. If the maintainer later wants them, the travel
copy is exactly the artifact D2 built for that, and a human hands it over.

**8.4 A new file class for the landing (`docs/lessons/`, a per-harvest file
each)** — rather than one `docs/LESSONS.md`. **Rejected**: it is ADR-0018 §11(4)'s
rejection in a new place (a new file class needs a write scope, a numbering
authority and a lifecycle), and it breaks D2 outright — **the travel copy must be
one file a human can hand over**, and a directory is not that.

**8.5 Keep the sponsor's refusal power, re-aimed at the local landing.**
**Rejected** at D4. A refusal over a local landing would be a human veto on what
this program records **about itself**, which is a different power from the one
granted, granted for a different reason, and nobody asked for it. The place a
sponsor stops something is the gate, and the gate signature is where it stays.

---

## 9. Consequences, and the failure modes worth naming

- **The recurring cost drops by one act per harvest and the discipline does
  not.** ADR-0018 §10 priced the practice honestly at one journal section per
  persistent-journal seat per trigger, plus one orchestrator collation and one
  shell commit. The shell commit becomes a local commit; every other line of that
  price stands.
- **The corpus becomes readable in one place, and that is new here.** Until now
  this program's admissible candidates lived in seven journal chains, one export
  packet and a PR in another repository. After the first landing they are in one
  file with their grades, provenance and dedup outcomes.
- **`docs/LESSONS.md` becomes the org's only artifact with an audience outside
  this program** — which is what ADR-0018 §10 said of the shell's file, now said
  of a local one. **LH2 is still what keeps it that way**, and it is still the
  criterion most likely to be argued about.
- **Failure mode: the file that nobody hands over.** Hand-carry has no machinery,
  which is the point and also the risk — a travel copy that never travels is a
  local log with an aspirational header. There is **no cure proposed here**, and
  the absence is deliberate: the direction retracted machinery, and re-adding a
  transport under a new name would be this ADR wearing the retraction as a
  costume. The visible signal, for the auditor: a `Lessons baseline` line that
  never moves and a file no session ever cites.
- **Failure mode: the landing becomes a dump.** With no fence, no screens and no
  refusal, the only bars left between a candidate and the file are LH1/LH2/LH3
  and the classifier — which is exactly where ADR-0018 put them (*"applied at
  minting rather than at transcription"*), and the hide test at transcription is
  retained in the block's transcriber notes. The auditor's sampling duty is
  unchanged and is now the only independent check on the file's contents.
- **Failure mode: `dedup against the file` silently becomes selection.** Box 10
  asks the collator to check a candidate against what the file holds — and
  §4.1's clerical bar is what keeps that from becoming a judgement about which
  rule is better. **Dedup is clerical; composition is selection** (A2-D8's
  distinction, unamended), and a drop is recorded with its reason, never
  performed silently.
- **New vocabulary, one item, no collisions**: *travel copy*. `L-`, `LC-`, `LD-`,
  `R`, `C-`, `REQ-`, `AUD-`, `SO-`, `HT-` and `X-` are untouched; `HT-` is
  retired as a form and its one instance keeps its id.

---

## 10. What this ADR does not decide

- **The shell's side.** Its law is its own — this program does not legislate for
  a repository it does not own, which was ADR-0018 §4.3's and §12's refusal and
  survives the thing that occasioned it.
- **Whether the shell's maintainer ever adopts entries from this travel copy.**
  Optional, theirs, and outside this record (§8.3).
- **`docs/LESSONS.md`'s internal format** — section naming, entry fields, how a
  domain-titled section is headed, and how the baseline line is written. The file
  is **created and seeded by the orchestrator as collator** (§2 D2), and its shape
  is that seat's to settle at the seeding commit, under D1's routing and D2's
  header contract. This record fixes the destination, the routing and the
  contract, and stops there.
- **Any change to seat topology, gates, campaigns, or enforcement.** None is
  proposed and none follows.
- **Whether a nil-yield harvest is a finding shape**, **retroactive promotion of
  war stories**, and **whether a seat may skip an `SO-` harvest** — all still
  parked exactly where ADR-0018 §12 and A2.9 left them.
- **The mechanical restatement check** of PROCESS §5.9's third cure part. Named
  at §7, not built, not proposed here.
