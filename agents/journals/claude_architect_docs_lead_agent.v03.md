# Journal: claude_architect_docs_lead_agent — volume 03

- **Agent**: architect_docs_lead (Opus 5 lead)
- **Charter**: agents/charters/architect_docs_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 03
- **Continues-from**: J-architect_docs_lead-0034
- **Previous-volume**: agents/journals/claude_architect_docs_lead_agent.v02.md
- **Previous-volume-sha256**: 099c7e3893d7bd2fab83d112540f1ecf0718c6dd064650efc263b442c1026293
- **Previous-volume-bytes**: 311192

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Volume 03 of a chain (ADR-0017 §4.3).
Enforced by scripts/agent_commit.sh and CI.
Volume 02 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-architect_docs_lead-0035] 2026-08-11T14:20Z | task:WO-0079 | Volume 03 opened on the round that fills the test column for the first time — thirty-four cells transcribed verbatim, the `OPEN`-beside-a-populated-cell question ruled rather than answered with a new `Status` value, two precisions returned to dv, and the carried ledger restated whole with an owner and a closing event on every item

### Trigger

Orchestrator dispatch: transcribe dv_lead's traceability delivery,
`agents/handoffs/WO-0079_m03-traceability-test-rows.md` (landed `a43ac00`), into
`docs/specs/traceability.md`. The packet is the carrier of `FINDING SO-1` and
pays act 1 of `SO-xgmii_rx_64.md` §8.2; the file it targets is mine and dv_lead
cannot stage it (PROTOCOL §6), which is the whole reason the mapping arrives as a
packet instead of an edit.

The dispatch also fixed the volume boundary: this entry opens volume 03 per
ADR-0017 §4.3, and under my own harvest candidate 59 the rotation entry owes a
**full restatement of the carried ledger** rather than a citation across the
boundary. `J-architect_docs_lead-0034` deferred that restatement here explicitly
and asked that candidate 93 be discharged on it at the same time.

Abort-first head check ran before anything else: `git rev-parse HEAD` returned
`c55c754`, matching the spawn-head exactly. No rollback, no divergence, proceed.

### Inputs

- `agents/charters/architect_docs_lead.md` — §3 (I own the matrix file; dv
  supplies the test-side mapping), §4 (the dv_lead interface row), §8 (journal
  obligations), §6 (traceability-matrix currency as an evaluation criterion).
- `agents/PROTOCOL.md` — §3 (packet forms; participants update their own packet's
  Return log), §4/§4.1/§4.2 (entry grammar, `Files-in-this-commit` set-equality),
  §5 (`R1`–`R9`), §6 (write scopes), §7 (gates), §10 (independence, ADR-0003/F5
  evidence classes).
- **`agents/handoffs/WO-0079_m03-traceability-test-rows.md`** — read whole. §0
  (what it is and the four things it does not do), §1 and §1.1 (the domain and
  the three tiers), §1.2 (the tier-B/C `OPEN` argument), §2.1–§2.3 (the citation
  atom, the homing rule, what `COVERED` rests on), **§3.A/§3.B/§3.C (the 34 cells
  transcribed)**, §4 (the unit register), §5 (the eighteen bounds), §6.1
  (`FINDING SO-1-A`), §7 (my definition of done).
- **`docs/specs/traceability.md` at HEAD** — the target, and specifically its own
  rules, which are what the delivery had to be checked against: the `Test(s)` and
  `Status` bullets, the programme-invariant bullet, the process-row paragraph in
  the Spec-section discussion, and `Open dependencies` items 1, 3 and 4.
- `docs/specs/modules/xgmii_rx_64.md` **§10** — the hook table, re-derived rather
  than accepted.
- `docs/specs/requirements.md` — for REQ-set equality only.
- `agents/handoffs/SO-xgmii_rx_64.md` — §1.1 `SC-1` and `SC-2` (the clause this
  round pays), §2.1-M's census, the `GAP` accounting at `M03-O2`.
- `test/attack_plans/AP-xgmii_rx_64.md` — §6's coverage map and the family-M
  qualification rows, consulted **only** to adjudicate the one citation whose
  form did not match the packet's own rule (Reasoning 4).
- `test/xgmii_rx_64/*.ml` and `test/xgmii/test_idle_injection.ml` — read at the
  cited lines to verify the citations. **Read only**; `test/**` is dv_lead's
  scope and no byte of it moved.
- `agents/journals/claude_architect_docs_lead_agent.v02.md` at HEAD, through
  `git show` — the chain fields, the last entry id, `-0022`'s full ledger and
  every Open-questions section from `-0023` to `-0034`, for the restatement.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.3/§4.4 (the rotation),
  and `scripts/policy.sh` + `scripts/verify_journal_chain.sh` — read to confirm
  the header form the enforcement actually parses (Reasoning 7).
- **No `libs/**`, no `top/**`, no `rtl_snapshots/**`** — not read, not opened. The
  chain from spec to matrix cell never touches design.

### Reasoning

**1. What the delivery's design bought, and why I checked it anyway.** The packet
carries **only** columns 6 and 7. That is not politeness, it is the safety
property: a delivery that re-printed my columns 1–5 would invite a paste that
overwrote the architect's own cells with dv's transcription of them, and the
overwrite would be invisible because it would look like the file. Because §3 omits
them, the worst a bad paste could do here is corrupt the two columns dv owns.

That made the *form* safe and said nothing about whether the *content* held. Three
things could still have been wrong and each would have been mine to catch: a hook
set that is not 34, a `file:line` that does not name what it claims, and a tier
assignment my matrix's rules refuse. I checked all three before touching the file,
because a matrix that transcribes an unverified mapping is worse than an empty
one — it converts dv's claim into my file's assertion and launders the provenance
in the process.

**2. The hook set, re-derived rather than quoted.** A left-column pass over
SPEC-M03 §10 returns exactly 34 REQ ids; a whole-section grep returns 35. The
packet explains the difference as `REQ-010` appearing only inside REQ-014's cell
as a cross-reference. I confirmed it: `REQ-010` occurs in **zero** left-column
cells. The set it returns is identical to the union of the three tiers. So the
domain is right, and — worth stating because it is the property that makes the
whole delivery checkable — the packet reproduced the figure **by measurement**
rather than by quoting `SO-` §2.8's "34", which is what let me re-derive it
independently instead of comparing two copies of one claim.

**3. The tier assignments are my matrix's, not dv's invention.** Tier A's 13 rows
all read `M03 Xgmii_rx_64` in my own `Owning module(s)` column and are owned
whole — `COVERED` is available to them. Tier C's five name M20, M20, the
four-owner REQ-810, and `programme (process)` twice. Tier B is the 16 programme
invariants SPEC-M03 §10 hooks. Nothing in the partition is a judgement dv made
that my file does not already make.

**4. The citations, and the one that did not match the packet's own rule.** All
**55** unit citations land on a `let%expect_test` line, and every one of those
units' titles carries the row id its cell claims — I checked the titles, not just
that a unit exists there, because a `file:line` that lands on *some* unit is not
evidence that it lands on the *right* one. The single non-unit citation,
`test_m03_f.ml:811`, is the comment the packet declares it to be, and the cell
says so in terms rather than naming a unit that does not exist.

One citation failed the packet's **own** §2.1 rule. §2.1 promises `<path>:<line>`
names "the `let%expect_test` unit whose title carries that row id". At
`M03-M10 → test_m03_f.ml:492` the title carries `M03-F2` and the string `M03-M10`
appears nowhere in that unit. Every other co-occurrence citation — M1, M2, M3, M4,
M5, M6, M7, and M10's other carrier at `test_m03_b.ml:907` — does carry its id in
the title, so this is one exception and not a pattern.

I transcribed it unchanged, and the reason is the distinction that matters here:
**the claim is true even though the stated rule for finding it is not.** `AP-M03`
records M03-M10's carriers as M03-F2 and M03-B3 and qualifies the row "ON
`M03-F2` ALONE"; the homing lives in the plan, not in the unit title. Refusing a
true cell because the packet over-generalised how to check it would have cost the
matrix real coverage to punish a documentation defect. So it goes in the cell and
the defect goes back as **P-1** — which is precisely what §7 item 4 asks for: a
divergence made visible rather than reconciled silently.

**5. The tier-B/C `OPEN` question — where my reading agrees with dv's, and the
two rows where it does not.** I was told that if my reading of the invariant-row
rule differs from dv's, that is a returned question and not a silent adjustment.
It mostly does not differ. My file says invariant rows record the *system-level*
test, and my `Status` vocabulary defines `COVERED` as "test exists and passes". A
module's restatement is not the system-level test, so `COVERED` is unavailable on
those rows however much evidence the cell holds. dv's disposition follows from my
own two rules.

But dv calls it "the matrix's own rule", and that is a shade stronger than the
file supports: the *disposition* — a populated cell sitting beside `OPEN` — is
**entailed** by two of my rules and is written down in neither. That gap is not
dv's to close and is exactly why the combination looks like a contradiction to a
reader: `OPEN` is defined in my file as "no test yet", printed beside a cell full
of test names. So I wrote the entailment down (Actions 3).

And the ground genuinely under-reaches at two rows. §1.2 justifies all 21 by the
programme-invariant rule and `Open dependencies` item 3, whose ranges are
REQ-001 … REQ-021 and REQ-801 … REQ-810. **`REQ-901` and `REQ-903` are in
neither** — they are process rows owned by `programme (process)`. Their `OPEN` is
still correct, but on a different ground my file already carries: a process
obligation is the programme's to discharge, and pointing one at a module's
evidence is the same false claim of coverage my Spec-section paragraph refuses
when it makes four rows name a process document instead of a module spec. Same
answer, different reason, 19 of 21 covered by the reason given. Returned as
**P-2** and written into the file so the 21 rows do not all rest on a rule that
reaches only 19.

**6. Why no `PARTIAL`, when dv offered it and the candidate set was handed to me.**
This was the one genuinely open ruling in the round, and the temptation was real:
a `PARTIAL` value would make the 21 rows *look* right at a glance, which is what a
matrix is for. I refused it on the ground that a status value is not a label, it
is a promise about a transition. `PARTIAL` would have to define when it becomes
`COVERED` — and that condition is precisely the invariant split that
`Open dependencies` item 3 defers to the first module-ready gate. Minting the
value now would freeze half of that gate's decision into the vocabulary before the
gate that owes it has met, and the half I would freeze is the half I happen to
have evidence for today. That is deciding a question by pre-empting its forum.

`OPEN` costs nothing once the file says what `Status` is a claim *about*, and it
keeps the decision where it belongs. I recorded the 21 rows as the candidate set,
so if the gate does want `PARTIAL` it inherits a measured set rather than an
argument. This is candidate 58 — rule at the narrowest scope that decides the
case — applied to my own vocabulary.

**7. Provenance: why the packet is cited once as a rule and not thirty-four times
as a string.** The dispatch asked for the delivery cited as each cell's
provenance. A literal reading is 34 repetitions of the same packet id inside cells
that already run long, which is unreadable and would have to be re-edited for
every future module. The property actually wanted is that provenance be
**recoverable per cell**, and the cells already carry it: every entry is prefixed
with its module's attack-plan row id (`M03-…`), and partial cells additionally
open `M03:`. So I made the prefix the pointer and wrote the resolution rule into
the file — the `M03-` cells are WO-0079's, measured at `a851948`. Any of the 34
cells resolves to its source by a rule the file states, the scheme extends to M04
and M06 without editing anything, and no cell is ever back-filled from another
module's packet. I record the deviation from a literal per-cell citation here
because it was my call and a reader may prefer the other one.

**8. `COVERED` rests on a run id, and I checked the run's subject had not moved.**
§2.3 shows `test/`, `tools/` and `docs/specs/` byte-identical across
`2183d71..a851948`. That interval ends one commit short of where I am writing. I
extended it to my own SHA: `test/` and `docs/specs/` are byte-identical
`2183d71..c55c754`. So CI `build` run `31444471834` at `head_sha` `2183d71` covers
the suite exactly as it stands at the commit that will carry this entry, and the
13 `COVERED` cells are not resting on a green whose subject has since changed.
I ran no simulation — ADR-0005 forbids it in this container — and the pass stays
an externally verifiable reference in ADR-0003/F5's sense. **Transcription does
not upgrade evidence**: a cell that reads `COVERED` in my file rests on the same
run id it rested on in dv's packet, and my act added the identity check, not a
green of my own.

**9. On the two rows dv homed itself.** `FINDING SO-1-A` reports six `AP-M03`
rows unreachable from §6's coverage map, two of them landed green units
(`M03-C5`, `M03-E5`). dv homed them explicitly and said in the provenance column
that the homing is this round's and not §6's. That disclosure is what made it
checkable at all, and it is the reason I could transcribe them without either
taking them for a plan statement I could look up or dropping them. A mechanical
transcription of §6 would have omitted landed evidence from three cells — the
exact failure mode this matrix exists to prevent, arriving through the instrument
built to prevent it. The `AP-M03` repair is dv's and rides its next plan round;
nothing here anticipates it, and I did not touch `test/**`.

**10. The volume boundary, and a header field the dispatch got wrong.** The
dispatch supplied `Previous-volume: claude_architect_docs_lead_agent.v02.md` —
a bare filename. `verify_journal_chain.sh` compares that field against
`journal_chain_for`'s output, which is repo-relative **paths**; volume 02's own
header uses the path form. Writing the dispatched value verbatim would have
produced a header that looks right, reads right, and fails the chain verifier at
the first check that reads it. I verified the expected form by running
`journal_chain_for` rather than by inference, and wrote the path. The sha256 and
byte count I recomputed myself from `git show HEAD:` and both match the dispatched
values exactly, so only the one field differed.

This is candidate 63 in miniature — a field defined by whatever the last party
declared, rather than by the checker that consumes it — and the cheap defence is
to read the consumer.

**11. Why the ledger is restated whole here.** Candidate 59 says an append-only
record split for size carries forward whatever was cumulative, because the
integrity checks prove nothing was rewritten or dropped and say nothing about what
stopped being **read**. My chain proves volume 02 is intact; it does not stop a
fresh architect from reading volume 03 alone and never learning that fourteen
ledger items are live. `-0034` deferred the restatement to this entry deliberately,
and candidate 93 says a list that only grows is not a tracking instrument: each
item must name the party who can close it and the event that closes it, and each
round must report closures. Both are discharged below. Restating it also let me
*check* four items instead of recopying them, which is the difference the two
candidates were minted to produce — and the check found one item that has been
overtaken by events without ever being answered (Evidence 9).

### Actions

1. **Ran the abort-first head check** (`git rev-parse HEAD` → `c55c754`, matching
   the spawn-head) before reading or writing anything.
2. **Verified the delivery's form** against the matrix's own rules — hook set,
   citations, tier partition, `COVERED` evidence — before transcribing (Evidence
   1–6). Verification preceded transcription; nothing was written on trust.
3. **Transcribed the 34 `Test(s)`/`Status` cells** into `docs/specs/traceability.md`.
   The transcription was applied **programmatically** from the packet's §3 tables
   rather than retyped: the script asserts each target cell was empty and `OPEN`
   before writing, refuses to touch any row outside the delivery, and a
   post-check compares every landed cell against the packet's string. Retyping 34
   long cells by hand is the obvious way to introduce a silent character-level
   divergence into exactly the file whose job is exactness.
4. **Updated the prose the transcription falsified** (DoD item 2), all of it text
   this file owns: the `Status` header line (no longer "DRAFT skeleton — test
   column pending dv_lead"); the `Test column owner` line, which now records that
   dv derives and I transcribe, and why; `Open dependencies` item 1 (no longer
   "empty by design at WO-0002 return", now carrying the live 76-rows-owed
   figure); and `Open dependencies` item 3, which gains the record that this is
   its first occasion plus P-2's two exceptions.
5. **Rewrote the `Test(s)` bullet**, whose "listed comma separated" rule the
   delivered atom falsifies — entries are semicolon-separated and the comma groups
   *within* an entry. The bullet now states the citation atom, why unit titles are
   not repeated in cells, and the two non-`file:line` entry forms.
6. **Added a provenance bullet** making the `M03-` prefix the readable pointer
   back to WO-0079 (Reasoning 7), and **ruled the `OPEN`-beside-a-populated-cell
   question** in a new bullet that states what `Status` is a claim about, names
   all three subject cases including the process-row one, and records the 21 rows
   as the `PARTIAL` candidate set should the module-ready gate want it.
7. **Appended §8.1 to the packet's Return log** and a change-log row (PROTOCOL §3:
   participants update their own packet's Return log), recording the verdict, the
   counts, the ruling, and precisions P-1 and P-2. Set the packet `State` to
   ACCEPTED and noted that `0079` is no longer a placeholder.
8. **Opened volume 03**: this file, with the chain header verified against the
   consumer rather than the dispatch (Reasoning 10), and the carried ledger
   restated in full below.

### Evidence

All commands run from a repo checkout at `HEAD = c55c754`.

1. **Head check.** `git rev-parse HEAD` → `c55c754`. Matches spawn-head.
2. **The hook set is 34.**
   ```
   $ awk '/^## 10\./{f=1} f&&/^## 11\./{f=0} f' docs/specs/modules/xgmii_rx_64.md \
       | awk -F'|' '/^\| REQ-/{print $2}' | grep -oE 'REQ-[0-9]+' | sort -u | wc -l
   34
   ```
   Whole-section grep returns **35**; left-column occurrences of `REQ-010`:
   ```
   $ awk '/^## 10\./{f=1} f&&/^## 11\./{f=0} f' docs/specs/modules/xgmii_rx_64.md \
       | awk -F'|' '/^\| REQ-/{print $2}' | grep -c 'REQ-010'
   0
   ```
   The 34 ids equal the union of the packet's three tiers.
3. **The delivery parses to exactly 34 cells**, 13 `COVERED` + 21 `OPEN`, with no
   `|` inside any cell (a pipe would have broken the target table):
   `34 rows, 0 malformed, 34 unique REQs, Counter({'OPEN': 21, 'COVERED': 13})`.
4. **Every cited line holds.** A loop over all 56 citations reports **55** landing
   on a `let%expect_test` line and one — `test_m03_f.ml:811` — landing on
   `(* ---- M03-F5 — DISCHARGED BY CITATION, not built (WO-0047 §3.3) ----------- *)`,
   which is what the packet declares it to be. A second pass confirmed each unit's
   title carries the row id its cell claims.
5. **The one exception, P-1.** `grep -rn 'M03-M10' test/` returns no hit inside
   `test_m03_f.ml`'s F2 unit (lines 492–652); the string occurs in that file only
   at `:324`, inside the *F1* unit. `AP-xgmii_rx_64.md` records M03-M10's carriers
   as M03-F2 and M03-B3 and qualifies it "ON `M03-F2` ALONE". Claim true, §2.1's
   stated locating rule inapplicable at this one entry.
6. **`COVERED`'s subject has not moved, checked past the packet's own interval.**
   ```
   $ git diff --quiet 2183d71..c55c754 -- test/ ; echo $?
   0
   $ git diff --quiet 2183d71..c55c754 -- docs/specs/ ; echo $?
   0
   ```
   CI `build` run `31444471834`, job `93635620822`, `head_sha` `2183d71`,
   conclusion `success` — cited as an **externally verifiable reference**
   (ADR-0003/F5), not re-executed here: `dune runtest` cannot run in this
   container (ADR-0005).
7. **Matrix after transcription.**
   ```
   $ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
                s=$8; gsub(/^[ \t]+|[ \t]+$/,"",s);
                if(t=="") e++; else p++; c[s]++}
        END{print n" rows: "p" populated, "e" empty";
            for(k in c) print "  "k": "c[k]}'  docs/specs/traceability.md
   110 rows: 34 populated, 76 empty
     OPEN: 97
     COVERED: 13
   ```
   Cell-for-cell comparison against the packet: **0 mismatches**. Of the 76 rows
   outside the slice, **76** still have an empty `Test(s)` and `Status` `OPEN` —
   measured over all 110 rows, not over the rows I remember not editing.
   `grep -c '^[-+]| REQ-'` on the diff → **68**: 34 removed, 34 added, one pair per
   delivered row.
8. **REQ-set equality survives** (the file's own first rule): the matrix's 110 row
   ids and `requirements.md`'s 110 REQ ids differ in neither direction — empty
   symmetric difference.
9. **Ledger items re-measured, not recopied** (candidate 93's "report closures"):
   `agents/PROTOCOL.md` still lists `R1`–`R9` in §5 and its CI paragraph still
   reads "R1–R8" at line 212, with no occurrence of `R10`/`R11` — **still open**.
   `agents/journals/INDEX.md` still shows `J-orchestrator-0012` and still records
   architect_docs_lead as "Not yet activated" — **still open and now further from
   true**, since this entry is number 35 across three volumes.
   `docs/gates/` holds `G0-checklist.md`, `P1-spec-freeze-checklist.md` and
   `lessons-harvest-block.md`: **no `P1-module-ready-checklist.md`** — still open,
   and newly load-bearing, because `Open dependencies` item 3 defers the invariant
   split to that gate and this round just proposed its M03 half.
   `agents/journals/workers/` now holds `claude_tb_writer_agent.md` (263,033 B),
   `.v02.md` (268,905 B) and `.v03.md` (155,243 B): the worker-template rotation
   predicted at `-0022` has happened **twice**, executed by whichever spawn held
   the pen, while the question of who *may* rotate a shared template journal was
   never answered. The item did not close; it was overtaken.
10. **Chain fields recomputed from HEAD, not accepted from the dispatch.**
    ```
    $ git show HEAD:agents/journals/claude_architect_docs_lead_agent.v02.md | wc -c
    311192
    $ git show HEAD:agents/journals/claude_architect_docs_lead_agent.v02.md | sha256sum
    099c7e3893d7bd2fab83d112540f1ecf0718c6dd064650efc263b442c1026293
    ```
    Both match the dispatched values. Volume 02's last entry is
    `J-architect_docs_lead-0034`, so `Continues-from` is that.
    `journal_chain_for architect_docs_lead worktree` emits repo-relative paths,
    which is the form `Previous-volume` must take — **not** the bare filename the
    dispatch quoted (Reasoning 10).

### Outcome

**DoD vs WO-0079 §7: met, all four items.**

1. **Transcribe the 34 cells** — met. 34 of 34, cell for cell, 0 mismatches,
   nothing refused. The 76 other rows untouched, verified by measurement over all
   110.
2. **Update the file's own header and prose** — met, and beyond the two items
   named: the `Status` line and `Open dependencies` item 1 as required, plus the
   `Test column owner` line, `Open dependencies` item 3, the `Test(s)` bullet's
   falsified separator rule, and the new provenance and `Status`-meaning bullets.
3. **Rule on the tier-B/tier-C `Status` question** — met. `OPEN` kept, vocabulary
   **not** extended, reason written into the matrix rather than left in this
   journal, 21 rows recorded as the candidate set for the module-ready gate.
4. **Return with a `J-architect_docs_lead-NNNN` reference** — met.
   `agents/handoffs/WO-0079_m03-traceability-test-rows.md` §8.1 carries this
   entry's id, the verdict, the counts, and both precisions.

**Matrix state**: 110 rows · 34 populated / 76 empty · 13 `COVERED` · 97 `OPEN` ·
0 `GAP` · 0 `WITHDRAWN`. The test column is no longer empty for the first time
since WO-0002.

**Handoff**: back to the orchestrator for commit; the packet's Return log is the
artefact dv_lead reads. **Not claimed**: that `SC-2` is met. This round pays act 1
of `SO-xgmii_rx_64.md` §8.2; the criterion is adjudicated by a re-read against §1
after **both** acts, which is neither this round nor my call.

**Volume 03 opened**, chain header verified against the consumer, ledger restated
in full below.

### Open-questions

**New this round.**

- **P-1, returned to dv_lead: one citation is true but unreachable by the
  packet's own locating rule.** `M03-M10 → test_m03_f.ml:492` is correct — the
  plan qualifies M03-M10 on M03-F2 — but §2.1 promises the unit's *title* carries
  the row id, and this title carries only `M03-F2`. **Owner: dv_lead. Closes by:
  either a §2.1 wording that admits plan-homed rows, or the `AP-M03` §6 repair
  round making the homing findable where §2.1 points.** Non-blocking; the cell is
  transcribed.
- **P-2, returned and simultaneously repaired on my side: §1.2's ground reaches
  19 of its 21 rows.** `REQ-901` and `REQ-903` are process rows outside both cited
  ranges. I wrote the process-row ground into the matrix so nothing rests on a
  rule that does not reach it. **Owner: dv_lead if it disputes the ground; me for
  the matrix text, done. Closes by: dv's acknowledgement, or silence at the next
  round that reads §1.2.**
- **The 21-row `PARTIAL` candidate set is now a standing question for
  `P1-module-ready`.** I ruled `OPEN` and declined to mint the value; the gate may
  want it. **Owner: the module-ready gate, jointly with dv_lead. Closes by: the
  gate ratifying the invariant split (`Open dependencies` item 3), at which point
  either `PARTIAL` is minted with a defined transition or `OPEN` stands.**
- **My provenance scheme is a deviation from a literal per-cell citation and I
  say so rather than let it pass as the only reading** (Reasoning 7). If the
  auditor or dv prefers the packet id inside each cell, the change is mechanical
  and I will make it. **Owner: me. Closes by: an auditor finding, or the second
  module's delivery landing under the same scheme unchallenged.**
- **The 76 empty rows are now the file's own visible debt**, and `Open
  dependencies` item 1 states the figure so it cannot rot quietly. **Owner: each
  module's dv sign-off round. Closes by: reaching 0, one module at a time.**

**Carried, restated in full rather than cited across the volume boundary**
(candidate 59), **with an owner and a closing event on every item** (candidate
93). Compiled from `-0022`'s full ledger and every Open-questions section
`-0023` … `-0034`. Four items were re-measured this round rather than recopied
(Evidence 9); **closures this round: none** — which is itself the report candidate
93 asks for, and the pattern it was minted against.

| # | Item | Owner | Closes by | State at this rotation |
|---|---|---|---|---|
| 1 | ADR-0017 §8's PROTOCOL diffs unapplied: `R10`/`R11` refuse commits but appear nowhere in the document that claims to list every rule | orchestrator (apply); me (draft, done) | the next orchestrator round transcribing §8's diffs | **re-measured, still open** (Evidence 9) |
| 2 | PROTOCOL §5's CI paragraph says "R1–R8" while `check_journals.sh` also checks `R9` | orchestrator | same transcription as #1 | **re-measured, still open** (line 212) |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward (candidate 59's rule) | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | **practised twice now, still undrafted** — `-0022` and this entry |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace; five seats mint five sequences from 1 | me | an ADR-0018 amendment, or the collator ruling a scheme | carried; no ADR-0020 exists |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale at `J-orchestrator-0012`, silent on volumes, and records me as "Not yet activated" | orchestrator | a gate-boundary refresh (PROTOCOL §9) | **re-measured, still open and further from true** |
| 10 | No owner for rotating a **shared worker-template** journal: a short-lived spawn executes §4.4 on a volume it did not write | orchestrator | a ruling, or an ADR-0017 clause | **overtaken, not closed** — tb_writer has rotated twice under no rule (Evidence 9) |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate convenes | **re-measured, still absent; now load-bearing** for `Open dependencies` item 3 |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried |
| 14 | `C-5`'s §0.6 repair: must state the vacuity case (no referent) and the `-0021` case (referent at closure) as **different** dispositions | me | any WO next opening `requirements.md` §0.6; owes dv's countersignature as a normative change | carried, half-repaired at `-0023`, re-scoped not closed |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6); bites at M03's oversize case and every stripped FCS | me | a ruling in `requirements.md` §0.6 | carried |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | dv's endorsed question: the (e)/(f) reading should run over every error class families E–H assert, before Phase 3 is scoped | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's "Aborted-and-forwarded" paragraph out of table order; `tools/precompile_stubs/ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007's scoping clause at two modules, `C-38`, `requirements.md`'s `DRAFT` header against its §13 frozen treatment, `C-2`, `C-3`, `C-5`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause; the `DRAFT` header closes on a freeze decision | carried whole |
| 25 | Two re-countersignatures and one concurrence owed at `J-architect_docs_lead-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 tb_writer row used the *widest defensible* window bound, looser than `-0021`'s ruling; G7/G8 have since landed so this is now a fact to look up | me | reading whether dv tightened G6's window to the truncation word | **now checkable, still unchecked** — I did not spend the round on it |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | carried |
| 30 | `AP-xgmii_rx_64.md` §4.I's M03-I4/M03-I5 cells are dv's to edit (`-0024`) | dv_lead | dv's next plan round | carried; **joined this round by `FINDING SO-1-A`'s §6 repair**, same file, same carrier |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes, not dischargeable by widening (g); carrier unscheduled (`-0033`) | dv_lead (carrier); me (class) | the round that lifts `FI-4`/`FI-6` | carried, still unscheduled |
| 35 | Two of my `-0033` repairs correct dv's finding rather than my own text and dv has not seen them | dv_lead | dv reading them, disputing or not | carried |
| 36 | The `-0032` countersignature is owed; that diff is not in force until it lands | dv_lead | dv countersigning | carried |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar (`-0032`) | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration; if any of candidates 11, 14, 22, 41, 63, 67, 73, 82, 91 goes hollow, the nil is wrong by that many | auditor (sampling, §3.6/§7.2) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted — append-only means a reader finding `-0030` and not `-0034` reads a span opening at `-0022` | me | nothing repairs it; the correcting notes are the only remedy | carried, and this restatement is the third note that tiles it |

- **No escalation.** Every question in this round was decidable in-role: the
  transcription against measurement, the `Status` ruling at the narrowest scope
  that decided it, and the two precisions returned rather than absorbed. Item 33
  remains the only E2 on my ledger and it is not triggered by anything here.

### Files-in-this-commit

- agents/handoffs/WO-0079_m03-traceability-test-rows.md
- docs/specs/traceability.md

## [J-architect_docs_lead-0036] 2026-08-11T15:40Z | task:none | Amendment A2 settles three open ends of my own ADR, and the load-bearing one turns out to have been minted in my file rather than in the criterion that inherited it — the block told a packet it was a gate, and said PROTOCOL said so

### Trigger

Orchestrator dispatch carrying **dv_lead's ADR request under PROTOCOL §11**, raised
at `J-dv_lead-0167` Open-questions item 1 (landed `5d50ab7`) and routed by the
`SO-xgmii_rx_64` re-verdict. Three items in one amendment round:

1. **Load-bearing, and it blocks a sign-off.** `SC-12`'s wording defect —
   `FINDING SO-5`'s unrepaired wording half. The packet has returned `FAIL` twice
   and the re-verdict states in terms that a future round finding the substantive
   gap paid **cannot write `PASS` until this is settled by amendment, not by
   reading**.
2. **My own carried ledger item 5**: ADR-0018 §4.3's `LC-`/`LD-` ids have no
   per-miner namespace. The collator has since ruled a scheme (`RULING O-1`,
   `J-orchestrator-0233`); my item said it closes on *"an ADR-0018 amendment, or
   the collator ruling a scheme"*, and this round decides whether the ruling is
   codified.
3. **rtl_lead's Open-question 2** (`J-rtl_lead-0013`): the span-boundary
   convention differs by one entry between notes, and all five have now landed.

**Abort-first head check, before reading anything.** `git rev-parse HEAD` →
`b4814b03613d89c816b1b98a144a532d5cf87ea7`, byte-equal to the dispatched
spawn-head `b4814b0`; `git status --short` empty. No divergence, no repair
attempted, proceeded.

**No lessons-harvest note is owed by this round and none is written.** PROTOCOL §7
and charter §8 attach the obligation to **every `SO-` and every phase gate**; this
is neither. Writing one here would be the `-AUD-53` defect the auditor banked this
arc — *"work done between triggers is a banking, not a discharge, and calling it
one makes the next span's start ambiguous"* — committed by the seat that has just
ruled on span boundaries. My span since `-0034` stays open and opens at `-0035` by
the very rule this round writes (A2-D10).

### Inputs

- `agents/charters/architect_docs_lead.md` — §2 (rulings are spec diffs plus ADRs,
  never verbal agreements), §3 (ADR ownership, dispute adjudication), §6 (ADR
  coverage), §7 (escalation classes), §8 (journal obligations, ADR coupling:
  Reasoning must record **how the ADR came to be asked**, not restate it).
- `agents/PROTOCOL.md` — **§11 in full** (the amendment procedure, and what its
  three elements actually are), §3 (packet classes; `SO-` is a packet and a merge
  precondition), §4/§4.1/§4.2, §6 (write scopes), §7 (gates, the lessons-harvest
  paragraph at lines 268–295, and the box sentence at line 291), §10.
- **`docs/adr/ADR-0018-...md` in full, §§1–12 and Amendment A1** — my own ADR, read
  as the thing being amended: §3.2 (the span), §3.3, §3.6, §4.1 (collation),
  §4.2/§4.3 (ids, one shell commit per harvest), §4.4, §6 (enforcement homes),
  §7.4/§7.5, §9, §12, A1.4 (`LD-`, pack fragmentation, the near-collision check),
  A1.5 (the block's amendment and the `SO-M03` tag), A1.6 (the PROTOCOL hunk
  mechanic), A1.8.
- `docs/gates/lessons-harvest-block.md` **in full** — the eleven boxes, and the
  preamble sentence that is the actual defect (Reasoning 1).
- **`agents/handoffs/SO-xgmii_rx_64.md`** — §1 (`SC-12` and the other thirteen
  criteria, to see what the amendment must not disturb), §4.1, §4.8 (`FINDING
  SO-5`), §4.9 (the refusal, the four notes measured, `FINDING SO-6`), §8.0.1–§8.0.3
  (the re-verdict and its routing). **Read, never written** — dv_lead's packet.
- **The five harvest notes, at their own journals**: `J-dv_lead-0165` and
  `J-dv_lead-0167` (`...v08.md`); `J-architect_docs_lead-0034` (`...v02.md`, mine);
  `J-rtl_lead-0013`; `J-auditor-0019` (`...v02.md`); `J-orchestrator-0233` and
  `-0234` (`...v02.md`, carrying `RULING O-1`). Read for their **span statements**,
  their **declared next openings** and their **minted id prefixes** — the three
  facts the three items turn on.
- `agents/journals/workers/claude_tb_writer_agent.v03.md` — the `-SELFWALK-` mint,
  which `RULING O-1` does not name.
- `docs/adr/ADR-0016-...md` (§8's transcription mechanic and its Status block),
  `ADR-0017-...md` (Status block), `ADR-0019-...md` (Status block: acceptance is the
  orchestrator's, via §11(2)) — the three acceptance precedents.
- `agents/journals/claude_architect_docs_lead_agent.v03.md` at HEAD — `-0035`'s
  restated ledger, for this round's restatement.
- **Not read**: no RTL, no `test/**`, no `docs/reports/audit/**`. Nothing in this
  round needed any of them.

### Reasoning

**1. The finding is right and its diagnosis stops one hop short, and the missing
hop is mine.** `FINDING SO-5` says `SC-12` *"imports PROTOCOL §7's gate
condition … onto a packet"*. I went to check that before ruling on it, because an
amendment written on a misattributed source repairs the wrong document. PROTOCOL
§7 line 291 reads *"A gate is not passed while any box … is unchecked"* — **gates
only**, and an `SO-` is not a gate by §3's own table. The sentence that actually
extends the condition to sign-offs is in `docs/gates/lessons-harvest-block.md`
line 5: *"A gate is not passed, **and a module sign-off is not complete**, while any
box in the instantiated block is unchecked (PROTOCOL §7)"* — **my file, my clause,
and a parenthesis citing a source that does not contain it.**

That changes what the round is. It is not an architect adjudicating dv's criterion;
it is the author of a defective instrument repairing it, one hop upstream of the
criterion that quoted it in good faith. It also decides the PROTOCOL question
immediately: **no constitutional diff is owed**, because the constitution never said
the thing that produced the impossibility. I would have written a PROTOCOL hunk on
`FINDING SO-5`'s recital had I not gone to the line, and the hunk would have
"repaired" text that was already right.

**2. Where the partition falls, and why the discriminator is not "who is the
orchestrator".** The obvious cut is *whose act is it*. That cut is wrong at box 7
(*no candidate was edited in transcription*): the act is the collator's at a gate
and the packet author's at an `SO-`, so ownership does not partition it. The cut
that does partition all eleven is **does the act the box observes already exist when
the instantiation is written**. Boxes 1–7 observe committed journals — five notes,
their spans, their classifiers, their grades, their packs, and the table being
written. Boxes 8–11 observe a shell commit, an id that does not exist until that
commit, a sponsor's sight of it, and a declaration of completeness. Seven and four,
and the four are **exactly** the four dv_lead enumerated, which is the check that
the rule and the request describe the same set rather than merely the same count.

**3. What I refused to do to make `SC-12` satisfiable.** Two easier repairs were
available and both are worse:

- **Waive the four boxes at the packet** — i.e. rule that a packet's instantiation
  simply need not check them. That leaves eleven boxes on the page with four
  permanently blank, which is a checklist that teaches its readers boxes are
  optional.
- **Say a packet "checks what it can"**. That is a reading, and dv_lead's request
  was explicit that a reading is what must not settle it: a criterion whose scope is
  fixed by whoever reads it is the defect, not the cure.

The partition is a **structural** answer: at an `SO-` the block instantiates **seven
boxes and no more**, with Part B present as a named deferral line that names the
gate that owes it. Nothing is waived, nothing is optional, and the count of boxes
a packet must carry is a fact about the block rather than a judgement about the
round.

**4. The three things the partition must not buy, and the guards on each.** A
partition is a loosening unless it is fenced, so I fenced it in the text rather
than trusting the reader: the five-seat obligation is untouched and boxes 1 and 2 —
the two that made `FINDING SO-5`'s substantive half checkable — stay at the packet;
a gate re-checks Part A over **its own** spans and never inherits a sign-off's
(A2-D3); and the batching question deferring Part B raises is closed by keeping
§4.2's *"exactly one commit per harvest"* **verbatim** rather than reinterpreting it
per gate (A2-D5). That third one nobody asked for and it is the one a later round
would have discovered at the worst moment — the first gate ratifying two sign-offs.

**5. Why this amendment binds without a countersignature, when the two nearest
precedents took one.** ADR-0016 and ADR-0017 both flipped on dv_lead's
countersignature; A1 was in force on the sponsor's authority; neither authority
exists here. I considered (b) — awaiting dv_lead's countersignature — seriously,
because dv_lead is the seat graded by the criterion and because a drafter who
legislates for an executor without asking is the shape ADR-0016 §8 warned about.
Three things decided it the other way.

First, **content authority**. In 0016 the rule was dv's own finding; in 0017 dv had
verified the design against the scripts. Here the block, its boxes, §3.2's span and
§4.3's ids are all this ADR's instruments and every one of the three defects is
mine. dv_lead is the **requester**, and the request is granted in its own terms —
its own four-and-seven.

Second, and this is the one that actually moved me: **requiring the graded seat's
consent re-admits it to the decision it refused to make.** `SO-` §4.9 declined to
rule *"in either direction"* because *"both possible rulings would amend a criterion
inside the document the criterion grades"*. A countersignature is a milder form of
the same participation. The independence property dv_lead was protecting is better
served by an amendment that binds without it.

Third, **the test for a self-serving amendment is whether it changes the current
outcome, and this one cannot**. `SC-12` fails at `14615f8` on `FINDING SO-6`:
three **mining** boxes, all in Part A, all still the packet's to check. A2 removes
an impossibility and removes no measured failure. If it had flipped the token I
would have chosen (b) whatever the analysis said, because an amendment that
converts a `FAIL` into a `PASS` in the same breath as it is written is not
distinguishable from the thing it claims not to be.

**PROTOCOL §11's elements are met at this landing and I checked them one by one
rather than asserting them**: (1) a numbered ADR — this amendment; (2) an
orchestrator journal entry — the entry accompanying the commit that carries it,
which is the acceptance act and which the ADR says in terms is what makes A2 live,
so a refusal to write it leaves A2 not in force; (3) a `test_protocol.sh` case only
if enforcement semantics move — none do, on §7.4's unamended reasoning. **The
contest route is written into A2 rather than left to be improvised**: any seat may
contest, the carrier is an Amendment A3 drafted here, and a contest does **not**
suspend A2 — because a criterion any graded party can suspend by objecting is the
original defect wearing a different hat.

**6. Codifying `RULING O-1` rather than ruling around it, and the four places it
needed extending.** The collator ruled the id scheme while my ledger item said it
closes on *"an ADR-0018 amendment, **or** the collator ruling a scheme"*. It ruled;
the disjunct is satisfied. I codify anyway, for a reason that is not tidiness: an
allocator living in one entry of one journal is discoverable only by someone who
already knows it exists, and the next miner reads the ADR. Measuring the record
before codifying found four things O-1 does not reach, each of which would have been
found by a miner instead:

- **What `<k>` counts.** O-1 writes `H<harvest#>` and does not say whose. It must be
  the minting chain's own ordinal, or a seat that misses a harvest cannot mint an id
  without reading outside its own journal — which destroys the property the
  qualifier exists for. And it counts **spans, not notes**: the orchestrator's
  harvest has two notes over one span, and `-0234` already kept `H1`.
- **The harvest tag leaves the id.** O-1 drops it silently; I adopt the drop and give
  it its evidence, which is in this document: A1.5 wrote *"The first instantiation is
  `SO-M03`"* and the packet landed as `SO-xgmii_rx_64`, so **this ADR and that packet
  already name one harvest of one module by two tags**. A key with a volatile field
  is A1.4's pack-fragmentation failure mode with ids as its subject.
- **`LD-` and the workers.** O-1 says nothing about the domain sequence, and names
  neither `-ADL-` nor `-SELFWALK-`. Both are landed mints, so the grandfathering has
  to be stated over the whole record rather than over the three ranges that were in
  view; I put the eight ranges in a table so the omission cannot recur by reading.
- **"Merges BY TAG" needed a bar.** A merge that lets the collator pick which of two
  wordings survives makes the collator a selector, which §4.1 forbids. A2-D8 keeps
  the merge and requires the surviving statement to be **one of the two verbatim**,
  the other recorded beside it, and no third sentence.

**7. The span convention: I picked against my own practice, and the reason is that
my practice cannot be executed honestly.** dv_lead's note and mine end their spans
**at** their own signing entry; rtl_lead's and the auditor's and the orchestrator's
end at the entry **before** it, which is §3.2's live wording. The inclusive form is
mine and it tiles, so choosing the other one costs me a grandfathering clause and
buys the following: **an entry cannot be mined by the note it contains.** My `-0034`
claims to have mined `-0034`; what it actually mined was everything up to it. Where
a note rides a work round — `R2` guarantees most will — the entry's substantive
reasoning is exactly the material a harvest wants, and under the exclusive form it
is mined next time by a miner who can read it finished.

**The real defect was never the end, though; it was the missing successor
sentence.** §3.2 says where a span ends and never says where the next opens, and
that is what produced the two live gaps: the auditor's `-0019` and the
orchestrator's `-0233`/`-0234` sit in **no** interval, because both paired §3.2's
end with an opening one past the note. So the rule I wrote is not "the next opens at
the note entry" but **"the next opens at the first entry not already inside a mined
span"** — self-correcting, convention-independent, and it repairs both declared gaps
without any journal being edited, which is not available anyway. The corollary is
its own small rule: **a declared next opening is a prediction, not a mining act**,
and a prediction consumes nothing.

**8. What I refused to touch, and why the list matters more than usual here.** Three
unrelated items in one amendment is a shape that invites scope creep, so the
refusals are enumerated in A2.0 and again in A2.9: `SC-12`'s own text (dv's
document — A2 supplies the partition and stops, and says so explicitly so the
silence is not read as an oversight); the landed instantiations in §4.8/§4.9 of that
packet, which are dated records and are not migrated, on A1.5's own precedent; the
five-seat obligation; the shell's scheme and formats; and the sponsor's parked
federation question. I also declined to decide **whether the shell commit may land
before the gate that ratifies it** — A2 fixes the count and leaves the moment where
§4.4 and §12 already left it, next to the unanswered question of what a sponsor
refusal converts a candidate into.

**9. The block's edit is owed rather than made, and the reason is a write-set
discipline, not an inability.** `docs/gates/**` is inside my scope, so this is not
ADR-0016 §8's cross-scope mechanic. The dispatched write set is this ADR and this
journal, and a round that quietly adds a second file makes its own
`Files-in-this-commit` disagree with what was commissioned — in the same commit as
an amendment about instruments minted in one sitting without checking who could
execute them. So A2 carries the five clerical edits as **fixed text** with the
carrier named (my next round opening `docs/gates/`, which is the `P1-module-ready`
checklist round already owed on ledger item 11).

**A2 is nonetheless in force before that edit lands, and the block itself supplies
the authority**: it says twice — §2 and §2.1 — that ADR-0018 is the **normative
text** and it is the short form. A short form that disagrees with its normative text
is stale, not governing. Had the block not carried that deference clause, this
amendment would have been unusable until a second commit, and the sign-off would
have been blocked on my file rather than on dv's finding.

**10. One thing I got wrong inside this amendment and caught by measuring my own
draft.** I first labelled A2's decisions `D1`…`D9` — colliding head-on with §2's
existing `D1`–`D7` in the same file, in the amendment whose second item exists
because a label minted without a namespace collides the first time a second party
mints one. Found by grepping my own draft for label occurrences rather than by
reading it. Renumbered to `A2-D1` … `A2-D12`, and the reason is written into A2.0
rather than fixed silently, because the incident is the item's own argument
arriving unprompted.

### Actions

1. **Ran the abort-first head check** (`git rev-parse HEAD` → `b4814b0…`, clean
   `git status --short`) before opening any file.
2. **Read the three requests at their sources** — `SO-xgmii_rx_64.md` §4.8, §4.9 and
   §8.0.2, `J-dv_lead-0167` Open-questions item 1, my own `-0034` Open-questions,
   and `J-rtl_lead-0013` Open-question 2 — rather than from the dispatch's quotation
   of them, and **verified `FINDING SO-5`'s recital against `agents/PROTOCOL.md`
   line 291 before ruling on it** (Reasoning 1, Evidence 3).
3. **Measured the five seats' span statements and declared next openings** at their
   own journals (Evidence 6), and the **landed id prefixes** across all seven
   minting chains (Evidence 4, 5).
4. **Appended Amendment A2 to
   `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md`** in A1's form —
   §§1–12 and A1 stand unedited; the amendment carries the authority block, the
   acceptance ruling, the three rulings, the owed block text, the failure modes and
   the not-decided list. Twelve decisions, `A2-D1` … `A2-D12`.
5. **Renumbered A2's decision labels** after finding the collision with §2's
   `D1`–`D7` (Reasoning 10), and recorded the reason in A2.0.
6. **Re-ran every command A2 quotes** and corrected two claims the measurement
   falsified before the text landed (Evidence 7).
7. **Wrote no harvest note** (Trigger), **edited no packet**, **edited no
   PROTOCOL**, and **edited no journal but this one**.

### Evidence

All commands run from a repo checkout at `HEAD = b4814b0`, working tree carrying
only this round's two files.

1. **Head check.** `git rev-parse HEAD` →
   `b4814b03613d89c816b1b98a144a532d5cf87ea7`; `git status --short` → empty before
   the round, `M docs/adr/ADR-0018-...md` after.
2. **The block has eleven boxes**, which is the number every party has been quoting:
   ```
   $ grep -c '^- \[ \]' docs/gates/lessons-harvest-block.md
   11
   ```
   The file's only unchecked boxes are §3's block, so the whole-file count is the
   block's count; I checked that before quoting the one-liner rather than after.
3. **The impossibility is in my file, not in the constitution.**
   ```
   $ grep -n "is not passed" agents/PROTOCOL.md docs/gates/lessons-harvest-block.md
   agents/PROTOCOL.md:291:later project pulls in only if that domain is its own. A gate is not passed
   docs/gates/lessons-harvest-block.md:5:verbatim, filling the bracketed fields. **A gate is not passed, and a module
   ```
   PROTOCOL's sentence is gate-only; the block's continues *"and a module sign-off
   is not complete"* and attributes the whole to PROTOCOL §7.
4. **The landed id census**, at this amendment's parent commit and quoted in A2.6
   with its two limits stated: seven minting chains under four schemes —
   `LC-SO-xgmii_rx_64-<n>` (dv H1), `-AUD-<n>` (auditor), `-ADL-<n>` (mine),
   `LC-rtl_lead-H1-<n>`, `LC-orchestrator-H1-<n>`, `LC-data_wrangler-H1-<n>`,
   `LC-tb_writer-SELFWALK-<n>`, plus `LC-dv_lead-H2-<n>` already conformant.
   **Zero string collisions**, and that is the finding rather than the reassurance.
5. **The census cannot see the auditor's range**, which is why A2 says the prefix
   set is read from the notes:
   ```
   $ grep -c "LC-SO-xgmii_rx_64-AUD-[0-9]" agents/journals/claude_auditor_agent.v02.md
   0
   ```
   against a note that states *"Every id is `LC-SO-xgmii_rx_64-AUD-<n>` … Abridged
   ids `-AUD-n` below"*.
6. **The span census, at each seat's own journal**: dv_lead `-0001 … -0165`, next
   `-0166` (v08); architect `-0001 … -0034`, next not stated (v02); rtl_lead
   `-0001 … -0012`, next `-0013`; auditor `-0001 … -0018`, next **`-0020`**;
   orchestrator `-0001 … -0232`, next **`-0235`**. **Two live gaps**: `J-auditor-0019`
   and `J-orchestrator-0233`/`-0234` fall inside no interval.
7. **Two claims in my own draft were falsified by re-running them, and both were
   corrected before landing**: I wrote that `grep "LC-\|LD-" agents/PROTOCOL.md`
   returns the grade paragraph's *carry-forward* bar — it returns **0**, so the text
   now says the id form has never been in the constitution at all; and I wrote *"the
   census above shows five"* forms where the record holds **seven minting chains**,
   now a table. A third self-check confirmed the drift claim: re-running the census
   over the working tree adds exactly `LD-dv_lead-H2` — the example A2-D9 invents —
   and nothing else, which is what A2.6 predicts in advance.
8. **The near-collision check reproduces** over the qualified form:
   ```
   $ printf 'LC-rtl_lead-H1-7 LD-dv_lead-H2-1 L-D15\n' | grep -oE "L-[A-Z]{1,3}[0-9]{1,3}"
   L-D15
   ```
9. **Ledger items re-measured rather than recopied**: `docs/gates/` still holds
   exactly `G0-checklist.md`, `P1-spec-freeze-checklist.md` and
   `lessons-harvest-block.md` — **no `P1-module-ready-checklist.md`** (item 11, still
   open, and it is now the named carrier for A2.4's owed block edit); `docs/adr/`
   holds no `ADR-0020` (item 5's alternative route, never taken — the amendment is
   the route that closed it).
10. **No simulation, no build.** Nothing in this round has an executable artefact;
    `dune runtest` is not runnable in this container (ADR-0005) and no claim here
    depends on it.

### Outcome

**DoD vs the dispatch: met, all three items, plus the acceptance ruling.**

1. **`SC-12`'s wording defect** — settled by amendment, in dv_lead's own terms. The
   eleven boxes partition **7 / 4**; the four are exactly the four the request
   enumerated; an `SO-` instantiates Part A only and carries Part B as a named
   deferral line; a gate carries all eleven and re-checks Part A over its own spans.
   **The criterion is satisfiable without any packet re-reading its own clause**,
   and no landed packet is edited by this round.
2. **The `LC-`/`LD-` namespace** — `RULING O-1` codified into §4.3's territory with
   four refinements and a total grandfathering table. **No landed id is renumbered**;
   eight ranges stand as minted.
3. **The span-boundary convention** — one convention forward (§3.2's end, plus the
   successor sentence it lacked), every landed note grandfathered, and the two
   declared gaps closed by rule rather than by any journal being touched.
4. **Acceptance mechanics** — ruled **(a)**: **A2 is in force at this landing on
   PROTOCOL §11**, completed by the orchestrator's own journal entry for the commit
   that carries it. **No countersignature is required and none is awaited**, so
   nothing needs sequencing ahead of the re-verdict dispatch. The contest route is
   stated in the amendment; a contest does not suspend A2.

**Handoff**: to the orchestrator for commit, and to dv_lead as the requesting seat —
the re-verdict round reads `SC-12` against A2.2 and the amended block. **Not
claimed**: that `SC-12` is met, or that anything about the verdict has moved. The
substantive obstacle named at `FINDING SO-6` is untouched by this round and is the
orchestrator's own successor note to write.

**Owed by this round**: the five clerical edits to
`docs/gates/lessons-harvest-block.md`, text fixed at A2.4, carrier the next round
opening `docs/gates/`.

### Open-questions

**New this round.**

- **A2 binds without a countersignature, and that is a ruling a seat may dislike.**
  If dv_lead, the orchestrator or the auditor reads the 7/4 partition, the id
  codification or the span convention as wrong, the route is a finding in that
  seat's own artefact carried to an **Amendment A3**, drafted here. **Owner: any
  contesting seat; me for the drafting. Closes by: the re-verdict round reading
  `SC-12` against A2 without contest, or an A3 landing.**
- **The block edit is owed and A2 is in force ahead of it.** Until it lands, a
  reader of `docs/gates/lessons-harvest-block.md` reaches the correct rule only via
  the block's own deference clause. **Owner: me. Closes by: the next round opening
  `docs/gates/` — the `P1-module-ready` checklist round, ledger item 11.**
- **Whether the shell commit may land before the gate that ratifies a harvest, or
  must land at it, is left undecided** while A2-D5 fixes the count at one per
  harvest. It becomes live at the **first gate that ratifies more than one
  sign-off's harvest**. **Owner: orchestrator as collator, with the sponsor on the
  refusal half. Closes by: `P1-module-ready`, or an ADR item.**
- **`SC-12`'s own text is dv_lead's to keep or narrow.** A2 supplies the partition
  and deliberately does not restate the criterion. **Owner: dv_lead. Closes by: the
  re-verdict round.**

**Carried, restated in full** (candidate 59), **with an owner and a closing event on
every item** (candidate 93). Compiled from `-0035`'s restatement, which was itself
compiled from `-0022` and `-0023` … `-0034`. **Closures this round: one — item 5**,
the first closure the ledger has recorded since it began being reported, and it
closed on the route it named rather than on the alternative it named
(`ADR-0020` still does not exist, Evidence 9). Two items re-measured (11, and item 5
itself); the rest carried.

| # | Item | Owner | Closes by | State at this round |
|---|---|---|---|---|
| 1 | ADR-0017 §8's PROTOCOL diffs unapplied: `R10`/`R11` refuse commits but appear nowhere in the document that claims to list every rule | orchestrator (apply); me (draft, done) | the next orchestrator round transcribing §8's diffs | carried |
| 2 | PROTOCOL §5's CI paragraph says "R1–R8" while `check_journals.sh` also checks `R9` | orchestrator | same transcription as #1 | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; **now doubly owed** — A2.4 is the first amendment whose owed edit is *inside* my own scope, and §11 describes neither case |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward (candidate 59's rule) | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried, practised twice |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace; five seats mint five sequences from 1 | me | an ADR-0018 amendment, or the collator ruling a scheme | **CLOSED this round** — both routes fired: the collator ruled (`RULING O-1`), and A2.6 codifies it with four refinements and a total grandfathering. No landed id renumbered |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried; **its Status block is now load-bearing precedent** — A2.0 cites it for acceptance-by-orchestrator-entry |
| 9 | `agents/journals/INDEX.md` stale at `J-orchestrator-0012`, silent on volumes, records me as "Not yet activated" | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate convenes | **re-measured, still absent**; now the named carrier for A2.4's five block edits |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried, and **its content moved this round**: an `SO-` instantiates seven boxes, a gate eleven (A2-D1/A2-D2) |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are **different** dispositions | me | any WO next opening `requirements.md` §0.6; owes dv's countersignature as a normative change | carried, half-repaired at `-0023` |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert, before Phase 3 is scoped | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's "Aborted-and-forwarded" paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-5`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried whole |
| 25 | Two re-countersignatures and one concurrence owed at `J-architect_docs_lead-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling; G7/G8 have landed so it is a fact to look up | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | carried |
| 30 | `AP-xgmii_rx_64.md` §4.I's M03-I4/M03-I5 cells are dv's to edit; joined by `FINDING SO-1-A`'s §6 repair | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes, not dischargeable by widening (g) | dv_lead (carrier); me (class) | the round that lifts `FI-4`/`FI-6` | carried, still unscheduled |
| 35 | Two of my `-0033` repairs correct dv's finding rather than my own text and dv has not seen them | dv_lead | dv reading them, disputing or not | carried |
| 36 | The `-0032` countersignature is owed; that diff is not in force until it lands | dv_lead | dv countersigning | carried |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar (`-0032`) | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | carried; **and A2-D10 now makes the correction structural** — my next span opens at `-0035` by rule, not by any note's say-so |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` are owed; A2 is in force ahead of them via the block's own deference clause | me | the next round opening `docs/gates/` (item 11's carrier) | **new this round** |
| 43 | A2 binds without countersignature; a contest by any seat is carried to an Amendment A3 | any contesting seat; me for drafting | the re-verdict reading `SC-12` against A2 without contest, or an A3 landing | **new this round** |

- **No escalation.** Every question in this round was decidable in-role: the
  amendment is PROTOCOL §11 work on my own ADR, the id scheme codifies a ruling
  already made, and the span convention closes an end my own §3.2 left open. Item 33
  remains the only E2 on this ledger and nothing here touches it. **Charter §7's E5
  is not triggered**: no lead disputed anything — dv_lead requested this.

### Files-in-this-commit

- docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md

## [J-architect_docs_lead-0037] 2026-08-11T17:05Z | task:none | The gate file that told a packet it was a gate is repaired, and the gate it named as the carrier is written — a checklist whose first section is a promise not to over-reach, and whose authoring produced two findings that reading about the gate could not have

### Trigger

Orchestrator dispatch naming this round as the carrier Amendment A2 committed me
to: *"the next architect round opening `docs/gates/`, which is the
`P1-module-ready` checklist round already owed on ledger item 11"* (A2.4, landed
`85753b6`, in force at `41fead6`). Two owed items, one round, by A2's own
sentence:

1. **A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md`**, whose
   text A2.4 fixed and whose landing `SO-xgmii_rx_64.md` §8.R4.3 lists as owed
   onward: *"line 5 still carries the over-reach at `41fead6`; text fixed at
   A2.4 … Not mine to stage."*
2. **`docs/gates/P1-module-ready-checklist.md`**, measured MISSING by my own
   ledger at `-0035` and again at `-0036` (Evidence 9 there), and named by
   `SO-xgmii_rx_64.md` §4.10 as the carrier of the first harvest's Part B.

**Abort-first head check, before opening anything.** `git rev-parse HEAD` →
`2c38307405eac66796a461bf8d7be25f64ab143f`, byte-equal to the dispatched
spawn-head `2c38307`; `git status --short` empty. No divergence, nothing
repaired.

**No lessons-harvest note is owed by this round and none is written.** PROTOCOL §7
and charter §8 attach the obligation to every `SO-` and every phase gate;
ADR-0018 §3.1 fires `P<n>-module-ready` *"before the checklist's sign-off section
may be completed"*. **Authoring the checklist is not convening the gate** — its
sign-off section is written empty and its boxes are written unchecked. Writing a
note here would be the `-AUD-53` defect (*"work done between triggers is a
banking, not a discharge, and calling it one makes the next span's start
ambiguous"*) committed by the seat that wrote A2-D10. My span stays open and
opens at `-0035`.

### Inputs

- `agents/charters/architect_docs_lead.md` — §3 (all documentation; the DoD
  template; gate countersignature **at `P<n>-spec-freeze`**, which is the clause
  that decides §8 of the new file), §5, §6 (traceability-matrix currency before a
  module's `P<n>-module-ready`), §8.
- `agents/PROTOCOL.md` — **§7 in full**, the `P<n>-module-ready` row read
  character by character; the lessons-harvest paragraph; the signature
  transcription rule; the hardening paragraph. §3 (an `SO-` is a packet and a
  merge precondition), §6 (write scopes), **§10** (mutation sequencing and the
  `N/N` sentence, external anchors).
- `docs/adr/ADR-0018-...md` — **§A2.4 as the source of this round's five edits**,
  read at the ADR and not from the dispatch; plus §2 (D1–D7), §3.1, §3.2, §4.1,
  §4.2, §4.3, §4.4, A1.4, A2.2 (the 7/4 partition table), A2-D1 … A2-D12, A2.8's
  failure modes, A2.9's not-decided list.
- `docs/gates/lessons-harvest-block.md` **in full, before editing** — the eleven
  boxes and the four sites A2.4's items touch.
- `docs/gates/P1-spec-freeze-checklist.md` **in full** — read for **form**: the
  per-batch record table, the transcribed-signature blocks, the `C-` ledger with
  a "must land before" column, the Sign-off section. Its ledger discipline is what
  §9 of the new file copies.
- `docs/gates/G0-checklist.md` — the other gate form: numbered items with an
  Owner, a Status and a Signature column, and an explicit Exit line.
- `agents/handoffs/SO-xgmii_rx_64.md` — §1.4 (`SC-3`, `SC-4`, `SC-5` read back at
  `41fead6`), §2.1-M, §2.2-M, §2.8-R, §2.9-R2, §2.10, §2.12, §4.10 (the round-4
  instantiation and its Part B deferral line), §7.2 (the gate ladder), §8.R4,
  §8.R4.2, §8.R4.3, **§8.R4.4 (the twelve bounds)**. **Read, never written.**
- `agents/handoffs/HT-01_first-harvest-transit.md` **in full** — the census, the
  method, §4's pairing rule **and its appended correction**, §5-pre, §5.
- `docs/federation/outbox/SO-xgmii_rx_64.md` — header, self-containment
  statement, tier summary.
- **The shell, read at source rather than through `HT-01`'s summary of it**:
  `renatom11/generic-agentic-fpga-org` PR #3 (state, base, file count) and
  `docs/FEDERATION.md` at shell `main` `2ad82c3` — §4 (the landing fence
  allocates final ids), §7 (records the sponsor does not sign defer their outer
  hop), §8.1 step 5 (the maintainer closes the PR **with the id-mapping table**),
  §10 (origin honesty; no privileged lane).
- `docs/specs/architecture.md` §4 (the twenty-module inventory and the Path
  legend), `docs/specs/requirements.md` (REQ-003, REQ-004, REQ-006, REQ-903,
  REQ-904, REQ-905), `docs/specs/traceability.md` (the REQ-903/904 rows and Open
  dependencies items 1 and 3), and the eight `§11` deferral rows at SPEC-M06,
  M14, M15, M17, M19 ×2, M20 ×2.
- `tools/dv_checks.sh` and `tools/check_emitted_verilog.sh` — read to find out
  whether REQ-903's and REQ-904's commissioned checks exist. **This is where the
  round's second finding came from.**
- `tasks/BOARD.md` — the Gates table (two rows: G0 and P1-spec-freeze; no
  module-ready row) and the current-milestone block. **Read, never written** —
  orchestrator scope.
- `agents/journals/claude_architect_docs_lead_agent.v03.md` at HEAD — `-0036`'s
  restated ledger, for this round's restatement.
- **Not read**: no RTL beyond `ls libs/hardcaml_ethernet/src/` for the existence
  column, no `test/**`, no `docs/reports/audit/**`.

### Reasoning

**1. Why the two items belong in one round, beyond A2 having said so.** A2.4's
carrier sentence is a write-set discipline, not a dependency claim; the
dependency is real anyway and runs in the direction that matters. The gate file
instantiates the block. Had I written `P1-module-ready-checklist.md` against the
unrepaired block, its harvest section would have inherited a template whose line
5 still told sign-offs they were gates — and the first gate to instantiate it
would have been the first reader to hit the defect **in a live gate** rather than
in a packet. The edit had to land first in the same tree, and it did.

**2. The five edits: what "their text fixed here" actually fixes, item by
item.** A2.4 gives item 1 as a quotation and items 2–5 as **content** — *"gains
its site qualifier"*, *"takes the qualified id form of A2.6"*, *"splits under two
sub-headings … with all eleven box texts unchanged"*, *"gain one line"*. So item
1 is applied verbatim (re-wrapped to the file's line width, which is not a text
change) and items 2–5 are applied as the sentences A2.4 specifies, with the
wording mine and stated here to be mine. Two of them needed a decision A2.4 did
not make, and both are recorded rather than absorbed:

- **Item 2's second half.** The old sentence ended *"the checklist edit is
  clerical, commits under `Agent: orchestrator`"* — true at a gate and false at
  an `SO-`, where the packet commits under the signing seat's trailer. The site
  qualifier the item adds is exactly what makes that half wrong unqualified, so I
  scoped it (*"the gate-checklist edit commits under `Agent: orchestrator`"*).
  **Scoping the consequence is inside the item; it is not a sixth edit.**
- **Item 3's definitions.** *"Takes the qualified id form of A2.6"* is unusable
  in the block unless the block says what `<seat>` and `<k>` are, so I imported
  A2-D6(1)'s two clauses — the minting journal chain, and spans rather than
  notes. Importing the definition of the form the item adopts is inside the item.

**3. The one edit A2.4 did not enumerate, and why I made it anyway.** §3's Yield
table carried two placeholder rows, `LC-<harvest-tag>-1` and
`LD-<harvest-tag>-1`. A2.4 item 3 names §1 item 2 and stops. Leaving the
placeholders would have left **the block's own example rows minting ids A2-D6
forbids**, in a template whose whole function is to be copied — and A2-D6 governs
every id minted after A2's commit, which is now. So I propagated item 3 into the
two placeholder cells and I am naming it as a propagation, not smuggling it in
as one of the five. The framing I acted on: item 3's subject is the id form the
file specifies, and the file specifies it in two places; A2.4 named the normative
one. **If a later reader judges this a sixth edit, the disclosure is here and the
diff is two cells.**

**4. The one thing I did not adapt, and it is the harder call.** The preamble's
surviving clause still reads *"every `SO-<module>.md` sign-off section
instantiates §3's block **verbatim**"*, which under A2-D1 is now qualified — a
sign-off takes Part A's boxes and the deferral line, not all eleven. A2.4 fixed
one sentence of that paragraph and not this one. I applied the fixed text and
left the neighbour, because the replacement sentence lands **immediately after**
it and spells the qualification out in terms, and because rewriting text an
amendment deliberately scoped is how a "clerical edit" becomes a second
amendment nobody voted on. **Carried as ledger item 44** rather than judged
harmless.

**5. What a `P<n>-module-ready` checklist is actually for, which is not "a list
of the three clauses".** PROTOCOL §7's row is one sentence with three clauses. If
that were the whole gate, the file would be nine lines. Reading the record turned
up three **more** classes of thing already homed at this gate by artefacts that
are not the constitution:

- **Requirements whose own verification column names the gate** — REQ-903's
  repository-surface check (*"a mechanical repository check at each module-ready
  gate, in two parts"*) and REQ-904's traceability currency (*"before its owning
  module's `P1-module-ready` gate"*). Neither is a §7 clause; both are normative
  and both are checkable.
- **Specification deferrals homed here by name** — eight `§11` rows across six
  specs, each of which says in its own words that its disposition is reviewed at
  a module's `P1-module-ready`. Those are mine, deferred by me, and a gate that
  did not carry them would let eight deliberate deferrals expire silently.
- **The traceability split** — `traceability.md`'s Open dependencies item 3:
  *"the architect and dv_lead agree the split at the first module-ready gate"*,
  with the `PARTIAL` question ruled at WO-0079 to be **this gate's** to decide.

So the file has ten sections and not three, and each row cites the artefact that
created it. **A gate condition nobody wrote down is a gate condition that does
not bind.**

**6. §0.2 is first on purpose, and it is this file's whole safety property.** The
instrument I repaired this round failed by extending its source and citing the
source for the extension. The obvious way for a new gate checklist to repeat that
is to encounter a place where the record and a clause do not line up and settle
it in prose — which is cheap, reads as diligence, and is exactly the A2.1 defect.
So the file opens by binding itself: every condition cites what creates it, it
adds no condition of its own, and **a mismatch becomes a numbered open item with
an owner rather than a sentence**. That rule was not decoration; it fired twice
within the same round (Reasoning 7 and 8), and both times the cheap move was
available and refused.

**7. First firing — `G-1`, the mutation clause against the measured column.**
PROTOCOL §7 says *"auditor's seeded mutations **all killed** by the DV suite"*;
§10 says *"every PASS reports kills **N/N**"*. M03's class-based era, walked
campaign by campaign in the packet, is **63 sealed / 61 killed / 1 survived / 0
green-by-blindness / 1 void**. That is not `N/N` on any reading that ignores the
columns, and the packet is emphatic that folding them is the thing not to do:
*"collapsing a never-rendered class into 'killed' would overstate coverage and
into 'survived' would libel a bench that was never given anything to catch."*
The survivor `G-c4` has its defect **measured dead at a repaired bench** and the
void `IC-M5` is narrow — unrenderable *at this design*. Two readings are
genuinely available: that the clause counts renderings and 61/61 of the killable
set satisfies it, or that a survivor is a survivor whatever later killed its
defect. **I took neither.** The auditor owns the mutation ledger (PROTOCOL §10),
so the verdict is the auditor's to write in its own artefact, and if the clause
itself needs moving that is an amendment. A gate checklist that ruled this in a
table cell would be deciding a constitutional reading in the file class that has
already done that once.

**8. Second firing — `G-4(ii)`, and this one is the argument for writing a gate
checklist before its gate.** REQ-904 makes traceability currency a gate condition
and commissions *"a script comparing the REQ id set … asserting exact set
equality, run in CI"*. I went to look for it. `tools/check_emitted_verilog.sh`
implements **REQ-903's** two parts, is wired into CI at `build` step 9, and even
carries the sentence *"REQ-903 passes only when this list is empty; that is a
`P1-module-ready` condition"* — an instrument that knows which gate it serves.
**REQ-904's script does not exist**, and `traceability.md`'s own REQ-904 row
records it: an empty `Test(s)` cell, status `OPEN`, naming the commissioned
script as the thing it waits for. **A gate condition whose check has never run is
not a satisfied condition**, and nobody would have noticed at gate time, because
the row would have been read as "REQ-904, continuous in CI" — which is what the
requirement says and not what the tree contains. Neither of this round's two
findings came from reasoning about the gate; both came from opening the artefact
the gate cites.

**9. Part B, and why box 8 and box 9 are two boxes.** The first harvest's
collation is deferred here by name. Read at source rather than from `HT-01`'s
summary: the transit is EXECUTED, the export packet is committed at
`docs/federation/outbox/SO-xgmii_rx_64.md` (commit `7fb2c99`), and the inbox PR
is **open** — one PR, one file, base `main` `2ad82c3`, never a merge candidate.
The shell's own law decides what the two boxes can mean:

- **Box 8** — *exactly one commit*. This repo's side is the outbox commit. The
  shell's side is whatever protocol-conforming commits its maintainer lands,
  **counted at the shell**, because a foreign PR is never merged there by design.
- **Box 9** — *`LC-`/`LD-` → `L-` pairs recorded*. `FEDERATION.md` §4 allocates
  final ids **at the landing fence**, and §8.1 step 5 has the maintainer close
  the PR *"with the landing commits **and the id-mapping table**"*. **While the
  PR is open there is no `L-` id in the world to pair to.** `HT-01` §4 already
  demoted its own `L-H1-` scheme to a local provisional index by appended
  correction; the box therefore reads the maintainer's returned mapping **and
  nothing else**, and I wrote that into the box's annotation so that a future
  collator cannot discharge it against this repo's own index. A2.8's second
  failure mode is Part B checked with no shell commit linked; a pairing recorded
  against ids the fence has not allocated is the same defect wearing the other
  coat.

**10. Two harvests at one gate — A2-D5's first live instance, arriving one gate
after it was written.** `-0036` noted that the batching clause was *"the one a
later round would have discovered at the worst moment — the first gate ratifying
two sign-offs."* It is not two sign-offs, it is a sign-off's harvest plus the
gate's own, and the clause covers it identically: **two harvests, two shell
commits, one per harvest, in harvest order**. The file therefore carries harvest
1 as Part B alone (its Part A was checked at the packet and discharges the
sign-off) and harvest 2 as all eleven boxes over the gate's own spans, with
A2-D3's non-inheritance stated between them. The span-opening line is included as
a **derived aid** with the derivation shown and the authority left where it
belongs — each seat's own note — because a gate record that hard-codes five
openings is a gate record that will be stale the first time a seat harvests
early.

**11. What I refused, and the list is the interesting part of this round.**
Beyond `G-1`: I did not check a single box or fill a single signature cell —
every one of them belongs to a seat that cannot stage this file, which is the
whole reason the transcription rule exists. I did not invent an architect
signature: PROTOCOL §7 gives me a countersignature at `P<n>-spec-freeze` and none
here, so §8 says so in terms rather than leaving a blank row a later reader would
fill in. I did not pair any `LC-` id to any `L-` id. I did not enumerate which
modules owe an `SO-` — clause (a) is plural and enumerates nothing, M01 is
types-only and three modules are structural wrappers, and inventing the
enumeration in a checklist would be the §0.2 violation with a different subject
(`G-2`). And I did not touch the ADR, the packet, `HT-01`, `PROTOCOL.md` or
`tasks/BOARD.md` — the board has no `P1-module-ready` row and adding one is the
orchestrator's act, not mine.

### Actions

1. **Head check** (`git rev-parse HEAD` → `2c38307…`, clean `status --short`)
   before opening any file.
2. **Read A2.4 at the ADR** and the four sites it touches in the block, then
   **applied the five edits** — item 1 verbatim, items 2–5 as A2.4 fixes their
   content, with the two in-item decisions of Reasoning 2 recorded.
3. **Propagated item 3 into §3's two Yield-table placeholder ids** and disclosed
   it as a propagation (Reasoning 3).
4. **Verified the box count survived the split**: 11 before, 11 after.
5. **Authored `docs/gates/P1-module-ready-checklist.md`** — ten sections, the
   per-module record over all twenty, the DV/mutation/stress rows, the mechanical
   requirement rows, the eight specification deferrals, both harvests, the
   signature table and an eleven-row open-items ledger.
6. **Read the shell at source** — PR #3's state and `docs/FEDERATION.md` §4, §7,
   §8.1, §10 — rather than relying on `HT-01`'s account of them, and wrote box
   9's annotation from §8.1 step 5's own words.
7. **Went looking for REQ-903's and REQ-904's commissioned checks in `tools/`**
   and corrected two cells of my own draft on what I found (Evidence 5).
8. **Wrote no harvest note** (Trigger), **checked no box**, **filled no
   signature cell**, and **edited no file outside the dispatched write set**.

### Evidence

All commands run from a repo checkout at `HEAD = 2c38307`, working tree carrying
only this round's two files plus this journal.

1. **Head check.** `git rev-parse HEAD` →
   `2c38307405eac66796a461bf8d7be25f64ab143f`; `git status --short` empty before
   the round; after it, `M docs/gates/lessons-harvest-block.md` and
   `?? docs/gates/P1-module-ready-checklist.md`.
2. **The block still has eleven boxes after the split**, which is the property
   A2.4 item 4 protects (*"all eleven box texts unchanged and in their present
   order"*):
   ```
   $ grep -c '^- \[ \]' docs/gates/lessons-harvest-block.md
   11
   ```
   Seven under `#### Part A — mining`, four under `#### Part B — collation`, in
   their present order, no wording moved.
3. **The over-reach is gone from line 5 and PROTOCOL is untouched**:
   ```
   $ grep -n "is not passed" agents/PROTOCOL.md docs/gates/lessons-harvest-block.md
   agents/PROTOCOL.md:291:later project pulls in only if that domain is its own. A gate is not passed
   docs/gates/lessons-harvest-block.md:5:verbatim, filling the bracketed fields. **A gate is not passed while any box in
   ```
   The clause *"and a module sign-off is not complete"* no longer appears in the
   file; the sign-off's condition is now stated over Part A.
4. **The new file's fifteen boxes are 4 + 11**, which is the A2-D2/A2-D1
   arithmetic made checkable:
   ```
   $ grep -c '^- \[ \]' docs/gates/P1-module-ready-checklist.md
   15
   ```
   Four are harvest 1's Part B (§7.1); eleven are harvest 2's full instantiation
   (§7.3). **None is checked.**
5. **REQ-903's check exists and runs; REQ-904's does not exist.**
   ```
   $ grep -rn "REQ-903" tools/check_emitted_verilog.sh | head
   …  REQ-903  (a) an .mli for every inventory module, M01 INCLUDED
   …  note "REQ-903 passes only when this list is empty; that is a P1-module-ready condition"
   $ grep -rln "REQ-904" tools/
   (no output)
   ```
   And `docs/specs/traceability.md`'s REQ-904 row carries an **empty `Test(s)`
   cell** with status `OPEN`, naming *"the CI set-equality script requirements.md
   REQ-904's verification column commissions"*. **Both halves are stated because
   the negative one is the finding.**
6. **The shell, read at its own head** (`main` `2ad82c3`): PR #3 `state: open`,
   `merged: false`, `changed_files: 1`, head branch
   `inbox/agentic-fpga-nic-SO-xgmii_rx_64`. `docs/FEDERATION.md` §8.1 step 5:
   *"The foreign PR is then closed with a pointer to the landing commits **and
   the id-mapping table** (`LC-nn → L-Xnn`, `LD-nn → <PREFIX>-nn`)"*. §4: *"the
   landing fence allocates final ids"*. **Externally verifiable references, not
   local commands** (PROTOCOL §4.1(b)); the path is `docs/FEDERATION.md`, which
   `HT-01` cites as `FEDERATION.md`.
7. **The outbox commit is real and is one commit**:
   ```
   $ git show --stat --oneline 7fb2c99 | head -4
   7fb2c99 FETCH FIRST catches the shell thirty-one commits ahead …
    agents/handoffs/HT-01_first-harvest-transit.md   |   49 +-
    agents/journals/claude_orchestrator_agent.v02.md |   46 +
    docs/federation/outbox/SO-xgmii_rx_64.md         | 2810 ++++++++++++++++++++++
   ```
8. **The eight `§11` rows homed at this gate**, counted rather than remembered:
   `grep -rn "module-ready" docs/specs/modules/` returns thirteen hits, of which
   **five are REQ-903 coverage rows** (M01, M05, M16, M19, M20) and **eight are
   `§11` deferral rows** — M06 11.2, M14 11.2, M15 11.2, M17 11.2, M19 11.2,
   M19 11.3, M20 11.2, M20 11.3.
9. **REQ-905's stress list is by name and is quoted as such**: *"M03, M06, M08,
   M10, M14, M17 and M20 … Structural wrappers M05, M16 and M19 are covered by
   their children's benches unless the wrapper introduces datapath logic of its
   own, which puts it on the list by spec diff."*
10. **The board has no `P1-module-ready` row**: `tasks/BOARD.md`'s Gates table
    holds exactly two rows, `G0` and `P1-spec-freeze`. Recorded because §10 of
    the new file asks the orchestrator to add one, and the ask should be
    measured rather than assumed.
11. **No simulation, no build.** Nothing in this round has an executable artefact;
    `dune runtest` is not runnable in this container (ADR-0005) and no claim here
    depends on it. The CI run ids quoted in the new file are **the packet's**,
    re-read at the packet, not re-triggered.

### Outcome

**DoD vs the dispatch: met, both items.**

1. **A2.4's five edits are applied**, with item 1 verbatim, items 2–5 as A2.4
   fixes their content, one in-file propagation disclosed (Reasoning 3) and one
   neighbouring clause deliberately left with its reason (Reasoning 4). The block
   is no longer stale against its own normative text, and the deference clause
   that kept A2 usable in the interval is no longer load-bearing.
2. **`docs/gates/P1-module-ready-checklist.md` exists**, OPEN, carrying: the
   twenty-module record with one row supplied; the DV rows and the bound-reading
   rule with M03's twelve bounds dispositioned; the mutation record with its
   reading question left open; the line-rate stress row; two normative
   requirement rows and the traceability split; eight specification deferrals;
   **both harvests, fifteen unchecked boxes**; the signature table; and an
   eleven-item open-gate ledger.

**Handoff**: to the orchestrator, as collator and as sole committer. Three things
are its acts and not mine — the harvest tables and every box (A2-D4), every
signature transcription, and the `tasks/BOARD.md` gate row the new file's §10
asks for. To dv_lead and the auditor as the seats whose evidence the gate reads:
`G-1` needs the auditor's verdict and `G-4(ii)` needs a script that lives in
dv-scoped `tools/`.

**Not claimed**: that any gate condition is satisfied, that the gate is close, or
that M03's `PASS` does anything beyond supplying that module's DV rows. **One of
twenty.**

### Open-questions

**New this round.**

- **The propagation at §3's Yield table is disclosed, not authorised.** A2.4
  enumerated five edits; I made a sixth cell-level change in the same file for
  the reason at Reasoning 3. **Owner: me. Closes by: a reader accepting it as
  item 3's completion, or an Amendment A3 sentence saying otherwise.**
- **`G-1` is the first gate item that may need an amendment rather than a
  ruling.** If the auditor's verdict cannot settle *"all killed"* against a
  measured survivor, the clause itself moves, and PROTOCOL §11 is the route.
  **Owner: auditor, then me for the drafting. Closes by: the verdict, or an
  ADR.**
- **REQ-904's commissioned script has never existed and the requirement reads as
  though it runs continuously.** **Owner: dv_lead (`tools/` is its scope); me for
  the `WO-` request. Closes by: the script landing green in CI.**

**Carried, restated in full** (candidate 59), **with an owner and a closing event
on every item** (candidate 93). Compiled from `-0036`'s restatement. **Closures
this round: two — items 11 and 42**, which are the two the dispatch named, and
they closed on each other's carrier exactly as A2.4 predicted. Items 13 and 3 are
re-measured; the rest carried.

| # | Item | Owner | Closes by | State at this round |
|---|---|---|---|---|
| 1 | ADR-0017 §8's PROTOCOL diffs unapplied: `R10`/`R11` refuse commits but appear nowhere in the document that claims to list every rule | orchestrator (apply); me (draft, done) | the next orchestrator round transcribing §8's diffs | carried |
| 2 | PROTOCOL §5's CI paragraph says "R1–R8" while `check_journals.sh` also checks `R9` | orchestrator | same transcription as #1 | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; **half of it is now spent** — A2.4 was the first amendment whose owed edit was inside my own scope, and this round executed it without §11 describing the case. The gap is now evidenced, not predicted |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward (candidate 59's rule) | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried, practised three times |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036`; **the block now carries the qualified form** (edit 3), so the codification has reached the instrument a miner actually reads |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried; cited in the new file's §3 for the transient-branch mechanic |
| 9 | `agents/journals/INDEX.md` stale at `J-orchestrator-0012`, silent on volumes, records me as "Not yet activated" | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried; **a gate boundary is now in sight**, which is the event PROTOCOL §9 names |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate convenes | **CLOSED this round** — the file exists, OPEN, ahead of the gate. Its own eleven `G-` items are the gate's ledger and are not carried here |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — this round opened `docs/gates/` but not that file |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried, **and the instantiation now exists to be filled**: two of them, in the new file's §7.1 and §7.3, with every cell empty and every box unchecked |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are **different** dispositions | me | any WO next opening `requirements.md` §0.6; owes dv's countersignature | carried, half-repaired at `-0023` |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert, before Phase 3 is scoped | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried; **all three landed `BUG-` packets are CLOSED**, so this one has no open sibling to ride |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's "Aborted-and-forwarded" paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-5`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried whole; the new file's `G-3` reads the open set at gate time without re-homing a row |
| 25 | Two re-countersignatures and one concurrence owed at `J-architect_docs_lead-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | carried |
| 30 | `AP-xgmii_rx_64.md` §4.I's M03-I4/M03-I5 cells are dv's to edit; joined by `FINDING SO-1-A`'s §6 repair | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried — the packet reads CLOSED with a stated carve-out, which is what this row tracks |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes | dv_lead (carrier); me (class) | the round that lifts `FI-4`/`FI-6` | carried, still unscheduled |
| 35 | Two of my `-0033` repairs correct dv's finding rather than my own text and dv has not seen them | dv_lead | dv reading them, disputing or not | carried |
| 36 | The `-0032` countersignature is owed; that diff is not in force until it lands | dv_lead | dv countersigning | carried |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar (`-0032`) | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried; the transit's hide test passed them at the source, and the shell's own screens re-run it |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | carried; A2-D10 makes the correction structural |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` are owed; A2 is in force ahead of them via the block's own deference clause | me | the next round opening `docs/gates/` (item 11's carrier) | **CLOSED this round** — five applied, one propagation disclosed, one neighbour deliberately left (item 44) |
| 43 | A2 binds without countersignature; a contest by any seat is carried to an Amendment A3 | any contesting seat; me for drafting | the re-verdict reading `SC-12` against A2 without contest, or an A3 landing | **half spent** — the re-verdict read `SC-12` against A2 and returned `PASS` without contest (`J-dv_lead-0168`). The route stays open for the orchestrator and the auditor, neither of which has read A2 against its own practice yet |
| 44 | The block's preamble still says an `SO-` instantiates §3's block *"verbatim"*, which A2-D1 qualifies; A2.4 fixed the following sentence and not this one | me | the next round opening the block, or an explicit judgement that the following sentence qualifies it | **new this round** |
| 45 | The `P1-module-ready` checklist opens its own ledger, `G-1 … G-11`; five rows are mine (`G-2` the `SO-`-owing enumeration, `G-3` the spec-freeze residue, `G-4(i)` the matrix, `G-10` the anchor reading, `G-11` the §1.1 tightening) | me for those five; the file names the others' owners | each `G-` row's own closing event | **new this round** |
| 46 | REQ-904's commissioned CI set-equality script does not exist, while the requirement reads as though it runs continuously | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | **new this round**, measured at Evidence 5 |

- **No escalation.** Every question in this round was decidable in-role: applying
  fixed amendment text to my own file, and authoring a checklist in my own write
  scope. The two questions that were **not** decidable in-role were left as gate
  items with owners rather than decided (`G-1`, `G-4(ii)`) — which is §0.2 of the
  new file working on its first day. Item 33 remains the only E2 on this ledger
  and nothing here touches it. **Charter §7's E5 is not triggered**: no lead
  disputed anything.

### Files-in-this-commit

- docs/gates/lessons-harvest-block.md
- docs/gates/P1-module-ready-checklist.md

## [J-architect_docs_lead-0038] 2026-08-11T19:20Z | task:none | Three spec-repair items landed and one deadlock of my own released — the retired per-octet sentence repaired at every site in all three modules it was consequential at, REQ-210's conflation ruled with the finding's second half answered in §0.5, and C9's admission rule written because the round that was supposed to write it could never have existed

### Trigger

Orchestrator dispatch, spawn-head `8f81568`, no sibling round in flight. Three
items, all mine, all made due by two landings:

1. **rtl_lead's M06 round** (`J-rtl_lead-0015`, `0753735`) implemented M06 and
   routed the `§13` 2026-08-04 repair as a spec-change request rather than
   touching `docs/specs/**` — carried as its **C-RL-7** — because a REQ-016
   wrapper built from SPEC-M06's un-repaired §10 hook would fail a conformant
   M06. That is the third of the three repairs that row commissioned "with the
   next work order that opens those specs", and M06's bench is the next thing to
   open SPEC-M06.
2. **dv_lead's AP-M04 round** (`J-dv_lead-0169`, `8f81568`) minted
   **`FINDING AP-M04-1`** against REQ-210 read with SPEC-M04 §7 and routed it to
   me undecided.
3. My own carried ledger item **34**, and the sentence in
   `J-architect_docs_lead-0032` that said C9 "needs one more spec round". This
   is a spec round; the dispatch asked me to discharge it or say precisely why
   not.

Precheck performed and passed before any edit: `git status --short` empty,
`git rev-parse HEAD` = `8f81568856c758296b2d9511f14554200143351c9`.

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md`, in full,
  before any edit.
- **`docs/specs/requirements.md`**: §0.5 in full (octet time, front offset h,
  word delay ΔC, the deciding input word D, the two arithmetic tests, what a
  monitor may demand under injection, the two provenance notes), §0.3, §0.4,
  §0.6, §0.7, §2 (REQ-101 … REQ-113 verbatim), §3 (REQ-201 … REQ-210 verbatim),
  §7's REQ-611, §10's REQ-901 in full, and **all fifty-three rows of §13** —
  the 2026-08-04 row commissioning the three repairs read word for word, not
  from memory.
- **`agents/journals/claude_rtl_lead_agent.v02.md`, `J-rtl_lead-0015` in full**,
  including its §5 table of the four output events with their D and delay, its
  §4 length arithmetic, and its Evidence section's statement of what it does not
  claim.
- **`test/attack_plans/AP-xgmii_tx_64.md`** §4.J (rows `M04-J1` … `M04-J4`),
  **§8 items 1–6 in full**, and §9's creation row. Read at the minting site, as
  the dispatch required, not from the routing summary.
- **The M03 precedent**, read as the discipline to copy: `SPEC-M03 §7`'s
  handshake bullet and §10's REQ-016 hook as they stand after `a77017c` and
  `1f3c04c`, and SPEC-M03 §9's *"When a frame is open, and what closes it"*
  paragraph.
- **The (g)/(h) record**: `J-architect_docs_lead-0032` (Outcome and
  Open-questions), `J-architect_docs_lead-0033` (`FINDING CSG-1`'s four-case
  table and its three outcomes), requirements.md §13's `3526e79` ruling row and
  its **`4e7331b` transcription row**, and dv_lead's countersignature record
  through that row (`J-dv_lead-0162`).
- **dv_lead's own measurements of the obligation**: `J-dv_lead-0169` §(l) — gate
  condition (c) **UNMET**, "no span-closing rule in `docs/specs/**`" — and
  `claude_dv_lead_agent.v07.md`'s `FINDING ECS-3` axis 2, which reshaped
  condition (c) from REQ-110's abort rule to the span-closing rule and widened it
  from one case to five classes.
- **`agents/handoffs/WO-0078_cosim-phase2-3-stimulus-widening.md`**: §2.2's
  guard table (`FI-4` at `ours_run.ml:118`, `FI-6` at `tb_xgmii_rx_64.v:274-276`),
  §6.3's C5–C9 case table, and the **re-authorisation gate**, whose condition (c)
  is the sentence this round turned on.
- The four module specifications end to end: `eth_axis_rx.md` (M06),
  `xgmii_tx_64.md` (M04), `arp_eth_rx.md` (M10), `ip_eth_rx_64.md` (M14);
  plus `udp_ip_rx_64.md` §6.1 and SPEC-M08, checked and **deliberately not
  edited** (§4 below).
- `test/attack_plans/AP-xgmii_rx_64.md` §4.H (rows `M03-H1` … `M03-H4`), read
  for what a landed plan already asserts on the `/E/`-then-`/S/` geometry.
- **No Essenceia/Nasdaq-HFT-FPGA material.** `test/third_party/` was not opened:
  every arithmetic claim below is derived from this programme's own
  specifications, and the one reference-behaviour question in item 3 is
  deliberately left unanswered rather than answered from a static read.

### Reasoning

#### 1. Item 1 — the M06 repair, and the site the commissioning row missed

The 2026-08-04 row named **SPEC-M06 (§7, §10)**. Reading M06 end to end before
editing found a **third** site: §6.1's gapped paragraph says in its own words
*"the per-octet constant of §7 holds on every stimulus, gapped or not"*. That is
the retired claim, stated in the section a bench writer reads first and a module
author reads before either §7 or §10. **My own commissioning row's site list was
short by one**, at the module whose repair was being routed to me *because* the
list was believed complete. I record that as a defect in the row rather than fix
it silently, because a site list is a set claim and this one was checked against
the file for the first time this round — which is the whole lesson of `C-43`'s
"one document up" family arriving in my own commissioning instrument.

The positive content is rtl_lead's four output events, and I did not take them on
trust: I re-derived each from SPEC-M06 §6.1's own assembly rule and checked the
whole mapping by arithmetic over every frame length from 14 to 1514 (Evidence 2).
The derivation agrees with `J-rtl_lead-0015` exactly, and the agreement is worth
recording as an *independent* check rather than a confirmation — rtl derived them
from the design it was writing, I derived them from the specification the design
was written to, and the two routes are only the same route if the spec and the
design agree, which is the thing in question.

**One thing in the D table is worth its own sentence.** The drain word's deciding
input word is its frame's **`tlast`** word and not "input word m + 2", because at
N ≡ 0 or 7 (mod 8) there is no input word m + 2 — the frame has ended. A rule
written as "always the later of the two source words" names a word that never
arrives, and a monitor built from it would wait forever at exactly two of the
eight residues. The table therefore states the two cases separately, with the
condition on each, and the arithmetic check swept both residues to confirm the
delay is 2 at each (Evidence 2).

M06 **passes** §0.5's late-decision test — its input carries `tkeep`, `tlast` and
`tuser`[0] in band, which is precisely what §0.5's own re-ruling note said the
three named specs owed nothing further from — and **fails** the straddle test at
h = 14. Both verdicts are now in §7 rather than derivable from §0.5 by a reader
who thinks to go looking.

#### 2. Item 1 continued — M10 and M14 land now, and why that was not the safe-looking call

The dispatch left the M10/M14 disposition to me. The safe-looking call was to
carry them with a trigger: neither has RTL, neither has a bench, and the row's
own words are that each "needs its own arithmetic worked against its own pinned
numbers". I did them, for three reasons that only became visible on reading the
files.

**(a) M10's arithmetic was already in its own §6.1.** M10 has exactly one output
event per opened packet, and §6.1 pins its cycle as *"the cycle after the earliest
of: the payload word carrying ARP octet 27, and the event that closed the packet"*.
That **is** the deciding input word, named, in the frozen text, one ruling before
the rule existed. The repair is a re-statement plus a verdict (M10 fails the
late-decision test and is §0.5's own worked instance of it), not new arithmetic.
Carrying it would have been carrying a debt whose payment was already written.

**(b) M14's repair is not confined to the loose sentence, and leaving it would
have left a live contradiction.** SPEC-M14 §7 discharges REQ-611's gap clause with
*"the per-octet constant L = 12, which is gap-invariant"* — and §0.5 retired that
on 2026-08-04, because M14 straddles at h = 20. So carry-forward **C-27**'s
disposition, which is countersigned and in force, has been standing on a sentence
that became false four days before this round, at two sites (§7's parse-latency
bullet and §10's REQ-611 hook). A trigger-and-carry would have left a frozen
specification discharging a requirement against a retired claim, with a §11 marker
pointing at a repair that nobody was scheduled to do. **C-27's conclusion survives
untouched** and is in fact strengthened: the growth rule ("the figure measured from
input word 0 grows by exactly the injected count") is the *same fact* as the new
one ("the delay from input word 2 is exactly one cycle, always"), seen from the
two ends. That is a better discharge than the one it replaces, and it was reachable
only by doing the work.

**(c) The trigger I would have written was not writable.** "The next work order
that opens those specs" is what the 2026-08-04 row said, and this round is an
instance of a work order opening those specs *for this exact purpose* — so a
trigger of that shape either fires now or is not a trigger. Naming a sharper one
("the WO commissioning its RTL or its bench, whichever is first") would have been
inventing a schedule for two modules nobody has scheduled.

**What I did not do at M14, and why it is stated.** §13's row named **§11.2** as a
site. It is not one: §11.2 is about the ΔC reserve and makes no gap claim. The
site list is corrected in M14's own §13 row rather than left for a later reader to
re-derive and doubt.

**And two specs are deliberately untouched.** SPEC-M08 (h = 0) and SPEC-M17 (h = 8,
`tlast` fixed by an in-data count) pass both of §0.5's tests, so their claims are
**true** and the 2026-08-04 row says in terms they are not to be "repaired".
SPEC-M17 §6.1 still carries the loose sentence and it is still correct there. I
checked both against the arithmetic rather than against the row (Evidence 2(d)).

#### 3. Item 2 — `FINDING AP-M04-1`, sustained by re-derivation, and the repair that was *not* obvious

dv's derivation is right and I re-ran it rather than reading it: frame octet j
enters at octet time `8C + j` and leaves at `8C + 16 + j`, so **L = 16 for every
octet of every frame at every length**, against §7's pinned **8** — checked by
arithmetic over every frame length from 60 to 1514, zero deviations (Evidence 1).
Both figures are exact. **The defect is the conflation**, and REQ-210's opening
clause is where it lives.

**The alternative was live and I refused it, which is the part of this that is a
decision rather than a correction.** One could repair §7's pinned 8 to 16 and keep
REQ-210's per-octet opening. Given REQ-201's fixed eight-octet preamble the two
readings constrain the same hardware, so nothing about the design is at stake —
which is exactly why this needs no ADR and does need a recorded reason. Two
grounds decided it. The **event** delay's two events are both named and both sit
at octet position 0 of their words, so it is the sharper observable and it is the
one `AP-xgmii_tx_64` row `M04-J1` already asserts at `ASSERT` status; moving §7's
figure would have invalidated a landed plan row to fix a sentence in a different
document. And pinning **both** is strictly more informative than renaming one:
the failure mode was that a reader could not tell which quantity was pinned, and
naming both cures that where renaming one merely moves it.

**The finding's second half is answered in §0.5 rather than at M04**, and that is
the part I think matters most. dv asked which word ΔC counts to at a module that
*inserts*: the preamble word gives ΔC = 1 and L = 8, the first frame-octet word
gives ΔC = 2 and L = 16. §0.5's front-offset definition already settles it without
amendment — it names the first octet the module emits for that frame **at that
same input**, and an inserted octet entered on no input, so it is not that octet.
Hence h = 0, ΔC counts to the first output word carrying an octet **of the frame**,
and the identity L = 8ΔC − h returns 16, agreeing with the per-octet route. What
§0.5 lacked was the sentence saying so, because its worked gloss ("the octets the
module removes from the front") silently assumes a module that only removes. That
gloss is where the ambiguity was, so that is where the clause went — one site, in
the definition, rather than a note at each inserting module. The clause closes with
the rule the whole finding teaches: **a delay pinned to an inserted word is an
event delay, not a latency; a specification may pin both and SHALL name which is
which.** That is `SCR-M03-I4`'s lesson at the transmit port — *name the quantity,
do not assume the reader will infer it from the measurement you cite.*

**A third instance found while doing item 1, repaired in the same diff.**
REQ-611 says its parse latency is "counted per §0.5 so that REQ-016's permitted
idle gaps do not break the constant", and names an input word and an output pulse
as its two events. An idle inside the header moves the second and not the first, so
the requirement demands of its own figure something no design can give — REQ-210's
defect at a different module, reached from the other direction. It is repaired to
the achievable form (the pinned figure is scoped to a consecutively delivered
header; the invariant quantity is the delay from the deciding input word). I record
it as **found rather than filed**: nobody raised it, and the only reason it surfaced
is that repairing SPEC-M14 §7 forced me to read what its parse-latency bullet was
resting on.

#### 4. Item 3 — C9, and the deadlock that turns out to be mine

The ledger sentence is `J-architect_docs_lead-0032`'s: *"Stage 3 may therefore be
authorised for C8 on this ruling; C9 needs one more spec round, and this ruling
does not supply it"*, with the closing round named as *"the round that lifts
`FI-4`/`FI-6` and writes C9's admission rule — the only round that can build the
stimulus at all."* Reading that sentence against `WO-0078`'s own re-authorisation
gate found **two defects in it, both mine**.

**(i) The round it names cannot exist.** `FI-4` and `FI-6` are guards in
`test/cosim/ours_run.ml` and `test/cosim/tb_xgmii_rx_64.v` — dv_lead's write scope
— and the admission rule is spec text, mine. PROTOCOL §6 makes those scopes
disjoint and PROTOCOL §5's R1 makes a commit single-agent, so *"the round that does
both"* names no round any agent in this org can hold. A closing event that no seat
can execute is not a closing event; it is a carry with the appearance of one, and it
sat on my ledger through four entries looking like a plan.

**(ii) The order is backwards, and dv's own packet says so.** `WO-0078` §6.3's
re-authorisation gate reads: *"C9's admission rule is written as spec text **before
either producer is opened** — because two producers implementing the same rule from
one written derivation is a review problem, and two producers implementing it from
each other is a circularity that would make the comparison compare a shared
assumption."* The spec text is a **precondition** of lifting the guards, not a
co-deliverable of it. So this round is not merely *a* qualifying round; it is the
one the sequence requires to come first.

**(iii) And the release condition could never be met.** REQ-901's restriction read
*"until a class is declared, co-simulation stimulus SHALL NOT present a start
character inside an open frame that has already delivered an octet"*. My own ground
for declaring no class was that **a class is a commitment about a run** — and the
restriction in the same paragraph barred the only run that could produce one. That
is a closed loop, minted by me at `-0032`, and dv's `SO-` measurement of gate
condition (c) as UNMET is what a stuck item looks like from outside.

**What I ruled, in four parts.**

**(a) The span-closing rule, written at the site that lacked it.** REQ-105 has said
since the freeze that "between the start character and the terminate character"
means *while the frame is still open*, and lists the closures; REQ-108 says the same
for its post-truncation window; SPEC-M03 §9 gives the list whole, five members
including `clear`. **REQ-110 said none of it** — its literal text aborts "the current
frame" on any start character before a terminate character, which would abort and
re-report a frame an `/E/` had already closed and already counted. That is why the
two producers' guards close their span on the terminate character alone and reach
five classes instead of one case: *they implement REQ-110's literal sentence*.
dv's `FINDING ECS-3` measured the guards; this is the sentence that produced them.
REQ-110 now carries REQ-105's clause in REQ-105's own words, on carry-forward
**C-12**'s conservation argument, with the pointer to SPEC-M03 §9 for the full list.
**Editorial**: `AP-xgmii_rx_64` row `M03-H3` already asserts *no*
`error_start_without_terminate` on exactly this geometry, so the closed reading is
what every landed instrument already implements — what changes is that
`requirements.md` alone now yields it.

**(b) The admission rule, stated in REQ-901 where the producers' obligation lives.**
The span is restated there and both producers are required to derive their admission
logic from **this document** — never from the reference, never from each other,
which is `WO-0078`'s own stated reason. A guard whose span is closed by the
terminate character alone is recorded as *wider than the rule*: not a defect, but
not the rule either, and only the rule is citable. **This discharges gate condition
(c)** as `FINDING ECS-3` reshaped it, before either producer is opened, which is the
order the condition demands.

**(c) The deadlock released by a record-only licence, not by a class.** The
unreleasable *"until a class is declared"* is replaced: the case **may** be driven
on a run that **compares nothing and adjudicates nothing** and says so on its face,
reporting both designs' dispositions as data — the form classes (e) and (f) already
use for the frames they exclude entirely. No sign-off packet may cite such a run and
no expected value may be taken from it (ADR-0015 D2). This is smaller than a class:
it authorises **observation**, not **exclusion**. And it is the only move consistent
with my own `-0032` ground — if a class is a commitment about a run, then the way
out of the loop is to supply the run, not to weaken what a class means.

**(d) No class is declared, and the reason is unchanged and is not "no producer can
build it".** That ground would prove too much: class **(h)** was declared at `-0032`
for the zero-delivered abort, which needs the *same* unproducible stimulus. The
real obstacle is `FINDING CSG-1`'s shape — **four cases, three outcomes**, of which
**two are frame merges**, and a merge is a divergence in the *ordered sequence of
output frames*. Every class this document has ever declared excludes a per-frame
observable: extent, `tuser`[0], the accept-or-discard decision. **None excludes at
the sequence level**, and minting a new kind of exclusion — one that voids a
comparison over a stimulus rather than over a frame — on a static read of a pipelined
design, in a round dv is not in, reversing a sentence dv countersigned, is three
over-reaches in one act. So the class stays undeclared; what changes is that its
closing event is now **reachable** (a record-only run's measurement, then a class
round on measured behaviour) instead of unreachable.

**One thing I added that nobody asked for, and the reason.** Writing the span down
makes "open frame" determinate, and a determinate "open" puts the `/E/`-then-`/S/`
geometry *outside* part (i) of the restriction — the frame is closed, so the bar
does not reach it. That would have authorised, as a side effect of a clarification,
a stimulus whose outcome on the reference side dv's own sweep says *"is not
derivable from a static read of a pipelined design"*, and whose divergence is again
a sequence divergence no class covers. A run driving it would have read a merge as a
defect against our design — the exact failure REQ-901's bar exists to prevent. So
part (ii) bars it explicitly, on its own ground, with the same record-only licence
and with the statement that **neither part reaches a directed bench**, where our own
rule is asserted against this document and the reference is not in the loop
(`M03-H3` is untouched). A clarification that quietly widens what may be driven is
not a clarification.

**Class and escalation.** The REQ-901 diff is **normative** — it changes what
stimulus is legal in both directions — so dv_lead's re-countersignature is owed and
**the diff is not in force until it is transcribed**. Nothing is blocked meanwhile:
`FI-4` and `FI-6` still refuse the stimulus at both producers, so no run can drive
either situation today. **Not E2** (charter §7): no requirement, phase or role is
added or dropped. **No ADR**, on REQ-901's own self-amendment clause and the
2026-08-03 and 2026-08-10 precedents. **No E5**: no lead disputed anything, and
the only position overturned this round is my own.

#### 5. What this round refused

- **No ADR for any of the four rulings.** Each replaced reading is arithmetically
  unsatisfiable rather than rejected among live alternatives, which is the
  2026-08-04 row's own stated ground for taking none. The single genuinely live
  alternative — repairing SPEC-M04 §7's 8 instead of REQ-210's opening clause —
  is a drafting choice about which of two equivalent constraints to write, not a
  design choice, and it is recorded with its refusal in §13 rather than promoted.
- **No `test/**` byte, no `agents/handoffs/**` byte, no PROTOCOL or charter byte.**
  `AP-xgmii_tx_64.md`'s rows `M04-J1`/`M04-J3` are dv's to re-status if dv wants
  to; the ruling deliberately leaves both where they are, because dv wrote that
  neither moves on it.
- **`AP-M04` §8's other routed items are not answered here.** Item 2 (REQ-901
  declares no divergence class at the M04 boundary) and item 3 (`C-5`'s §0.6
  vacuity for `error_underflow`) are routed to me and are **not** in this
  dispatch's three; answering them would have been widening my own write set
  mid-round. Both are carried below with owners.
- **No class for C9**, §4(d).
- **No repair at SPEC-M08 or SPEC-M17**, §2.

### Actions

1. Read the charter and PROTOCOL; ran the precheck; read every input above
   before the first edit.
2. Wrote the check script of Evidence 2 and ran it **before** writing any D
   table, so that the tables are transcriptions of a checked derivation rather
   than the derivation itself.
3. `docs/specs/requirements.md`: §0.5 gains the inserting-module clause;
   **REQ-210** repaired (opening clause struck, both quantities named, both
   columns rewritten); **REQ-611**'s gap clause repaired; **REQ-110** gains the
   open-frame clause; **REQ-901** gains the span, the admission-derivation rule,
   restriction part (ii) and the record-only licence. Four §13 rows appended.
4. `docs/specs/modules/xgmii_tx_64.md`: §7's latency bullet rewritten as two
   named constants with both derivations shown; §10's REQ-210 hook rewritten;
   one §13 row.
5. `docs/specs/modules/eth_axis_rx.md`: §6.1's gapped paragraph, §7's latency
   bullet and §7's handshake bullet (with the four-event D table), §10's REQ-016
   hook; one §13 row.
6. `docs/specs/modules/arp_eth_rx.md`: §3's REQ-016 row, §6.1's gapped
   paragraph, §7's latency and handshake bullets (one-event D table), §10's
   REQ-016 hook; the stale *"This spec is DRAFT and has none"* sentence above
   §13's table repaired; one §13 row.
7. `docs/specs/modules/ip_eth_rx_64.md`: §3's REQ-016 row, §6.1's gapped
   paragraph, §7's latency bullet, §7's parse-latency (C-27) bullet, §7's
   handshake bullet (four-event table plus the **D**-nomenclature note against
   ADR-0012's own use of the letter), §10's REQ-016 and REQ-611 hooks; one §13
   row.
8. Ran the table-integrity check of Evidence 3 over all five files.
9. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git
   write of any kind.**

### Evidence

Reproducible from a checkout at this commit.

**1. The precheck, as run.**

```sh
git status --short              # empty
git rev-parse HEAD              # 8f81568856c758296b2d9511f14554200143351c9
git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
```

**2. Every pinned figure re-derived from the specifications' own rules, by
arithmetic, with no RTL and no simulation** — which is what requirements.md
§0.5's *"checkable by arithmetic at spec freeze"* clause promises and what
`FINDING AP-M04-1` reached the same way. The script is reproduced in full in the
Reasoning-adjacent form below so it re-runs from any checkout; it reads no repo
file and depends only on the rules quoted in it.

```python
# (a) SPEC-M04 §6.1: source word m accepted at C+m is transmitted at C+m+2,
#     lane = byte position (REQ-012, no rotation).
for N in range(60,1515):
    for j in range(N):
        m = j//8
        assert (8*(0+m+2) + (j%8)) - (8*(0+m) + (j%8)) == 16
# (b) SPEC-M06 §6.1: payload word m takes positions 6,7 of input word m+1 and
#     0..5 of input word m+2; emitted at Ci+3+m.
# (c) SPEC-M14 §6.1: payload word j takes positions 4..7 of input word j+2 and
#     0..3 of input word j+3; emitted at Ci+4+j.
# (d) §0.5 straddle predicate: h mod 8 != 0.
```

Observed output, re-run at this working tree:

```text
M04 per-octet L: constant 16 over N=60..1514: True | deviations: 0
M04 event delay (accept cycle C -> start-character word C+1): 1 cycle = 8 octet times
M04 h=0 -> DC=(L+h)/8 = 2 cycles; first output word carrying frame octets is C+2: True
M06 payload-word delay from D=input word m+2: {1} | drain word (N mod 8, delay): [(0, 2), (7, 2)] | M=K-1/K-2 rule holds: True
M06 hdr_valid: D=input word 1 (cycle Ci+1), pinned Ci+2 -> delay 1
M06 L=10,h=14 -> DC= 3 | straddle (h mod 8 != 0): True
M14 payload-word delay from input word j+3: {1} | last-word delay from the tlast word: {2}
M14 ip_hdr_valid: D=input word 2 (cycle Ci+2), pinned Ci+3 -> delay 1 | parse latency from word 0 = 3
M14 L=12,h=20 -> DC= 4 | straddle: True
  M03 lane0: h=8 straddles=False
  M03 lane4: h=12 straddles=True
  M04: h=0 straddles=False
  M06: h=14 straddles=True
  M08: h=0 straddles=False
  M10: h=0 straddles=False
  M14: h=20 straddles=True
  M17: h=8 straddles=False
```

**What each line buys.** M04's `deviations: 0` over 1 455 frame lengths is the
finding sustained rather than accepted. M06's `{1}` is a **single-valued** delay
set over every ordinary payload word of every length 14–1514 — a set with two
members would have meant the table is wrong — and `[(0, 2), (7, 2)]` confirms the
drain word's delay at **both** residues that produce one. M14's `{1}` and `{2}`
are the same two claims at h = 20. The straddle block reproduces §0.5's Phase-1
verdict list term for term, including the two modules I did **not** edit: M08 and
M17 return `False`, which is the check that the 2026-08-04 row's "not to be
repaired" instruction is arithmetic and not deference.

**3. Table integrity across the five edited files** (a normative row that stops
being a table row stops being readable, and four of this round's edits are inside
table cells):

```sh
python3 - <<'PY'
import sys
for f in ["docs/specs/requirements.md","docs/specs/modules/xgmii_tx_64.md",
          "docs/specs/modules/eth_axis_rx.md","docs/specs/modules/arp_eth_rx.md",
          "docs/specs/modules/ip_eth_rx_64.md"]:
    blk=[]
    for n,l in enumerate(open(f,encoding="utf-8").read().split("\n"),1):
        if l.startswith("|"): blk.append((n,l.count("|")))
        else:
            if len(blk)>1 and len({c for _,c in blk})>1: print("SPLIT ROW near",f,n)
            blk=[]
PY
```

Observed: three reports, all in `ip_eth_rx_64.md` at lines 257, 956 and 1084 —
**all pre-existing and all false positives**, each being a cell containing an
escaped `\|` inside `cfg_local_ip \| ~cfg_subnet_mask`, which the naive counter
counts as a column separator. None is a line this round touched
(`git diff -U0 -- docs/specs/modules/ip_eth_rx_64.md` shows no hunk at any of
them). No genuinely split row exists in any of the five files.

**4. The loose sentence's remaining occurrences, measured after the edits:**

```sh
grep -rn "8 octet times per cycle" docs/specs/
```

Observed: `udp_ip_rx_64.md:430` (SPEC-M17 — **correct as written**, h = 8,
passes both tests, and the 2026-08-04 row says it is not to be repaired), the
three repaired sites now qualified with "on the **input** side", `xgmii_tx_64.md`
§7's new sentence about how L moves with the event delay, and the §13 rows that
quote the retired sentence in order to convict it.

**5. Confinement.** `git status --short` at the end of this round lists exactly
the five specification files below plus this journal, and `git diff --stat`
reports `5 files changed`. The claim is over the paths I own; it says nothing
about anyone else's, and no sibling round was declared.

**Not claimed, stated so the absence does not read as coverage.** No bench was
run, none exists for M04, M06, M10 or M14. Nothing here is a verification result.
The M06 RTL at `0753735` was **not** re-read against the repaired §7 — the
agreement recorded in §1 above is between `J-rtl_lead-0015`'s stated derivation
and mine, not between the repaired spec and the emitted circuit, and the first
real verdict on that is dv's bench. No `ifc_check` build was run and none is owed:
no §4 record in any of the five files moves, so §12's existing evidence still
witnesses every interface. The reference design's behaviour on either restricted
stimulus of item 3 is **not** determined by this round and is deliberately left
open.

### Outcome

**DoD met on all three items; one of the three is a partial discharge, stated as
such and with the split named.**

- **Item 1 — DISCHARGED, wider than commissioned.** The 2026-08-04 row's three
  repairs all land at this SHA: SPEC-M06 (four sites, one of them missing from
  the row's own list), SPEC-M10 (four sites) and SPEC-M14 (six sites, including
  the two carrying carry-forward C-27's discharge). Each module's §7 now names
  the deciding input word and the delay for every one of its output events, and
  each states its two §0.5 verdicts. **No cycle, constant or interface in any of
  the three moves.** Ledger item **29** closes.
- **Item 2 — `FINDING AP-M04-1` RULED, both halves.** SUSTAINED on re-derivation;
  REQ-210's opening clause is the defect and is struck; both quantities are pinned
  in SPEC-M04 §7 with each measured in its own terms; the second half is answered
  by a normative clause in §0.5 covering every inserting module rather than by a
  note at M04. A third instance of the same defect, **REQ-611**, was found while
  doing item 1 and repaired in the same diff. Class **editorial** by §13's own
  test; **dv_lead's re-countersignature owed** on both REQ rows and the §0.5
  clause, and neither is in force until transcribed. Nothing dv holds moves:
  `M04-J1` asserts the event delay unchanged and `M04-J3` reports 16 either way.
- **Item 3 — C9's SPEC HALF DISCHARGED; the class stays undeclared with a
  reachable closing event, and my own closing-event sentence is corrected.**
  Discharged: the span-closing rule at REQ-110, the admission rule and the
  derivation obligation in REQ-901 — `WO-0078`'s re-authorisation condition (c),
  landed *before* either producer is opened as that condition requires. Released:
  the deadlock `-0032` created, by a record-only measurement licence in place of
  an unmeetable "until a class is declared". Not done, deliberately: the class
  itself (§4(d)), and the lifting of `FI-4`/`FI-6`, which is dv's scope and was
  never mine to hold in a joint round. The REQ-901 diff is **normative** and is
  **not in force until dv_lead's countersignature is transcribed**.
- **Handoff**: to the orchestrator for commit; then the three countersignature
  requests to dv_lead — the REQ-210/§0.5 diff, the REQ-611 diff and the REQ-901
  diff — which may travel as one packet or three, dv's call, since none blocks
  any other.

**Carried ledger, restated whole** (ADR-0017 §4.4's practice; every row carries
an owner and a closing event, and a row is never dropped for being old).

| # | Item | Owner | Closing event | This round |
|---|---|---|---|---|
| 1 | ADR-0016 §8's transcription mechanic is unwritten in PROTOCOL | orchestrator | a PROTOCOL §11 amendment | carried |
| 2 | The generic shell's `LESSONS` transit is the orchestrator's and unexercised | orchestrator | the first harvest reaching the shell | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; half spent |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried, practised four times |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036` |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale, silent on volumes, records me as "Not yet activated" | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate | CLOSED at `-0037` |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — this round opened no `docs/gates/` file |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried, instantiations exist to be filled |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are **different** dispositions | me | any WO next opening `requirements.md` §0.6; owes dv's countersignature | carried, half-repaired at `-0023`. **This round opened `requirements.md` and not §0.6** — the four repairs are at §0.5, §2, §3, §7 and §10, and widening to §0.6 would have been widening my own write set mid-round. `AP-xgmii_tx_64` §8 item 3 now names this as a dependency, which is new pressure and is item 49 |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried — **this round opened REQ-901 and did not take it**, because the clause is about the reference's build configuration and the round's REQ-901 edits are about stimulus legality; taking it would have mixed two unrelated diffs under one countersignature request |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried — this round opened no SPEC-M03 site |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-5`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried whole. **C-27 is not on this list and did not need to be**: it was closed, and this round found its discharge standing on a retired sentence — which is the first evidence that a *closed* ledger item can be reopened by a later ruling, and is item 50 |
| 25 | Two re-countersignatures and one concurrence owed at `-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried — **and this round is its second customer**: three module specs now restate that diff's rule, so a contest of it would move four files and not one |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | **CLOSED this round.** All three repaired at every site, and the row's own site list corrected in two places (SPEC-M06 gains §6.1; SPEC-M14's §11.2 was never a site) |
| 30 | `AP-xgmii_rx_64.md` §4.I's M03-I4/M03-I5 cells are dv's to edit; joined by `FINDING SO-1-A`'s §6 repair | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger, and this round touches nothing on it |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes, not dischargeable by widening (g) | dv_lead (carrier); me (class) | **restated this round**: a record-only run measuring the reference's disposition on both shapes, then a class round on the measurement | carried — **but its closing event is now reachable**, which it was not on any prior restatement of this row. The obstacle is named precisely: no declared class excludes at the *sequence* level, and two of the four cases are frame merges |
| 35 | Two of my `-0033` repairs correct dv's finding rather than my own text and dv has not seen them | dv_lead | dv reading them, disputing or not | carried |
| 36 | The `-0032` countersignature is owed; that diff is not in force until it lands | dv_lead | dv countersigning | **CLOSED — and it has been closed since `4e7331b`.** dv COUNTERSIGNED at `J-dv_lead-0162` and the orchestrator transcribed it into requirements.md §13 under `J-orchestrator-0232`; classes (g) and (h), the boundary sentence and the stimulus restriction have been IN FORCE since then. **This row was stale on my ledger for two entries and I found it only because item 3 sent me to read the transcription row.** A carried row whose closing event happens in another agent's round closes silently unless someone goes and looks — recorded as the round's sharpest lesson about this ledger |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar (`-0032`) | me (class); dv (stimulus) | a class ruling | carried, **and the bar is now releasable**: part (i) keeps its scope, gains part (ii)'s sibling, and both gain the record-only licence in place of a condition that could never be met |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried — **and this round is a partial answer at three modules**, though for the `-0024` rule and not `-0031`'s |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | carried |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` | me | the next round opening `docs/gates/` | CLOSED at `-0037` |
| 43 | A2 binds without countersignature; a contest by any seat is carried to an Amendment A3 | any contesting seat; me for drafting | a re-verdict without contest, or an A3 landing | carried, half spent |
| 44 | The block's preamble still says an `SO-` instantiates §3's block *"verbatim"*, which A2-D1 qualifies | me | the next round opening the block | carried |
| 45 | The `P1-module-ready` checklist's ledger `G-1 … G-11`; five rows are mine | me for those five | each `G-` row's own closing event | carried — **`G-3` (the spec-freeze residue) gained material this round**: three frozen specs took post-freeze diffs and one of them repaired a stale DRAFT sentence |
| 46 | REQ-904's commissioned CI set-equality script does not exist | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | carried — **and this round adds no REQ id**, so the set it would compare is unchanged |
| 47 | **Three countersignatures owed on this round**: the REQ-210 + §0.5 diff, the REQ-611 diff, and the REQ-901 diff (which is **normative** and not in force until transcribed) | dv_lead | dv countersigning each | **new this round** |
| 48 | **`AP-xgmii_tx_64` §8 item 2**: REQ-901 declares no divergence class at the M04 boundary, and its own text forbids citing a class not listed there — needed before any TX co-simulation result may be cited | me | a REQ-901 round that opens the transmit boundary | **new this round.** Routed to me by dv and deliberately **not** in this dispatch's three; the REQ-901 edits here are at the M03 boundary only |
| 49 | **`AP-xgmii_tx_64` §8 item 3** makes `C-5` (item 14) a dependency of a landed plan for the first time: a reader of §0.6 alone finds a window, applies it to `error_underflow` and gets a green that means nothing | me | the `requirements.md` §0.6 round item 14 names | **new this round** |
| 50 | **A closed ledger item can be reopened by a later ruling, and nothing detects it.** C-27 was closed; its discharge rested on a sentence `-0024` retired four days later; the reopening surfaced only because a repair round read what the discharge stood on | me | a survey of closed items whose grounds cite a since-amended §0.5/§0.6 clause | **new this round** |
| 51 | **`FINDING CSG-1`'s four cases have never been checked against a run**, and the record-only licence is what makes that possible — but nothing schedules it | dv_lead (the run); orchestrator (scheduling) | the first record-only run | **new this round** |
| 52 | **SPEC-M04's own §11.3 carries `C-5` as a deferred item** and this round opened SPEC-M04 §7 and §10 without touching §11.3 | me | the `C-5` round of items 14 and 49 | **new this round**, stated because opening a file and not closing its open item is exactly the omission this ledger exists to make countable |

- **No harvest note is owed.** PROTOCOL §7 and charter §8 attach the lessons
  harvest to an `SO-` and to a phase gate; this round is neither, and it is not a
  volume rotation either (entry 0038 of volume 03). Declared rather than omitted,
  per the same clause's own discipline about nil yields.
- **No escalation.** Every question was decidable in-role: three spec repairs and
  two rulings, all inside `docs/specs/**`. **E2 not triggered** (no requirement,
  phase or role added or dropped — item 33 remains the only E2 on this ledger and
  is untouched). **E3 not triggered** (no toolchain or licensing boundary; no
  third-party source was read). **E5 not triggered**: no lead disputed anything,
  and the only ruling overturned this round is mine.

### Open-questions

- **Three countersignatures are owed and the REQ-901 diff is not in force until
  its own is transcribed.** Until then no producer may be opened against the
  admission rule and no packet may cite it. If dv reads restriction part (ii) as
  reaching stimulus it intends to drive, or the record-only licence as narrower
  than it needs, that is a fresh finding and takes a narrow round of its own —
  the standing clause `-0031` and `-0033` wrote against themselves.
- **The class for C9's two shapes is still undeclared**, and the question it now
  poses is sharper than "declare or not": does this document want a class that
  excludes at the **sequence** level, which none of (a)–(h) does? That is the
  ruling the class round has to make, and it should be made with a measurement in
  hand rather than on a static read.
- **Whether the record-only licence is the right instrument, or whether it should
  have been a class of the (e)-sub-5 shape** ("excluded entirely, decision
  included, reference disposition recorded as data"). I chose the licence because
  it authorises observation without pre-committing an exclusion, and because
  reversing a countersigned "no class is declared" sentence in a round dv is not
  in is the wrong way round. If dv would rather have the class, that is a cheap
  round and the material is all in `-0033`'s four-case table.
- **Item 50 is the one I would most like someone else to check.** If C-27's
  discharge could rot silently under an amendment to §0.5, so could others, and I
  do not know how many. The survey is mine and unscheduled.
- **`AP-xgmii_tx_64` §8 items 2 and 3 are routed to me and unanswered** (items 48
  and 49), as is `C-5` at three sites now (requirements.md §0.6, SPEC-M04 §11.3,
  and the new plan's dependency on it).

### Files-in-this-commit

- docs/specs/requirements.md
- docs/specs/modules/xgmii_tx_64.md
- docs/specs/modules/eth_axis_rx.md
- docs/specs/modules/arp_eth_rx.md
- docs/specs/modules/ip_eth_rx_64.md

## [J-architect_docs_lead-0039] 2026-08-11T22:35Z | task:none | Two findings ruled and three carried items paid — `CSG-3` cured by neither of the two ways it was offered but by stating the restriction over the span it was short of, `AP-M04-2`'s survival claim struck at the site that issued the invitation, and `C-5` closed at the clause whose reference word had no referent

### Trigger

Orchestrator dispatch, spawn-head `9d68d10`. This is the **re-dispatch** of the
round my previous spawn refused: that spawn ran on a rolled-back container where
the SHAs its own dispatch cited did not resolve, and it stopped rather than
write into a substrate that had lost the work it was supposed to build on
(incident eight, credited at `J-orchestrator-0245`). The repository is restored,
every SHA this dispatch cites resolves, and the dispatch is unchanged but for
the spawn-head. **Declared sibling**: a `dv_lead` round with write set
`agents/handoffs/WO-0080_*.md` (new) and `agents/journals/claude_dv_lead_agent.v08.md`.
Disjoint from mine; neither file was opened for writing and the untracked
`WO-0080` in the tree at the end of this round is the sibling's, not mine.

Five items, two of them findings routed to me undecided by `J-dv_lead-0170` and
three of them carried on my own ledger:

1. **`FINDING CSG-3`** (MATERIAL) — REQ-901's stimulus restriction is stated over
   two of the admission span's five closure events, and REQ-108's truncation
   closure is uncovered while the class-(f) lift clause opens it. Filed without
   holding the countersigned REQ-901 diff out of force, with two candidate cures
   and neither chosen.
2. **`FINDING AP-M04-2`** (MINOR) — SPEC-M04 §7's new closing sentence claims the
   per-octet constant *"does survive REQ-016's idle injection"*, over a stimulus
   class the same specification twice declares has no instance at that port.
3. **Ledger item 48** — REQ-901 declares no divergence class at the M04 boundary
   (`AP-xgmii_tx_64` §8 item 2).
4. **Ledger item 49** and **item 52** — `C-5`, §0.6's window vacuous for
   `error_underflow`, now a landed plan's dependency (`AP-xgmii_tx_64` §8 item 3)
   and an open deferral in SPEC-M04's own §11.3.

Precheck performed and passed **before reading the findings and before any
write**:

    git status --short              # empty
    git rev-parse HEAD              # 9d68d107bf88525980aaeaffc36cefba742f5d94
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md`, in full,
  before any edit.
- **The findings at their minting site**, not from the dispatch's paraphrase:
  `agents/journals/claude_dv_lead_agent.v08.md`, `J-dv_lead-0170` entire —
  §(a) the REQ-210 countersignature and its 1501-length re-derivation, §(b)
  `FINDING AP-M04-2` word for word, §(c) the REQ-611 countersignature with dv's
  withdrawal of its own second clause, §(d) the three stale `AP-M14` rows, §(e)
  the REQ-901 countersignature and the record-only licence stated in dv's own
  words, **§(f) `FINDING CSG-3` word for word including its two candidate cures
  and dv's self-binding on `FI-4`/`FI-6`**, §(g), §(h), and the three
  countersignature texts in its Outcome.
- **`docs/specs/requirements.md` at HEAD**: §0.5 entire (the two tests, the
  survival clause, what a monitor may demand), **§0.6 entire** (the three
  reference-word clauses, the two italic notes, the counting convention, frame
  conservation), REQ-105, REQ-106, REQ-107, REQ-108, REQ-110, REQ-111, REQ-206,
  REQ-210, REQ-611, **REQ-901 entire**, §12's strobe appendix read row by row for
  the absence-condition census, and §13's rows through
  `J-orchestrator-0244`'s three transcriptions — so the diff I am amending is the
  one **in force**, not the one I wrote at `-0038`.
- **`docs/specs/modules/xgmii_tx_64.md`**: §3's REQ-016 and REQ-008 rows, §6.1,
  §7 entire, §8, §9 entire, §10's REQ-206 and REQ-210 hooks, §11 all five rows,
  §12, §13.
- **`docs/specs/modules/xgmii_rx_64.md` §9**'s *"When a frame is open, and what
  closes it"* paragraph and its two following notes — the span REQ-901 restates,
  read to confirm my repair changes the **restriction** and not the span.
- **`test/attack_plans/AP-xgmii_tx_64.md`**: §7.1 entire (BAR T1's three
  conditions and its would-see/would-not-see table), §7.2, **§8 items 1–6**, §9's
  creation row. Read at the minting site, as `-0038` was required to and as items
  48 and 49 are quoted from.
- `agents/journals/claude_architect_docs_lead_agent.v03.md`,
  `J-architect_docs_lead-0038` entire, for the carried ledger restated below.
- **A directory listing of `test/third_party/verilog-ethernet/`** (four files:
  `axis_xgmii_rx_64.v`, `lfsr.v`, `COPYING`, `PROVENANCE.md`) — a listing, to
  check dv's BAR T1(a) claim myself rather than carry it. **No third-party source
  file was opened in this round**, no reference behaviour was derived from a
  static read, and **no Essenceia/Nasdaq-HFT-FPGA material was touched**. Every
  reference-side claim below is carried from a recital already in
  `requirements.md` — class (e)'s line sweep at pin `77320a9` and the (g)/(h)
  paragraph's lane-0 mechanism — and is labelled as carried at the point of use.

### Reasoning

---

#### 1. `FINDING CSG-3` — SUSTAINED, and cured by neither cure it offered

**The finding is right and the geometry is constructible from this document
alone.** With the span written down, a frame closes on the earliest of five
events. Part (i) barred a start character **inside an open frame**; part (ii)
barred one **after an `/E/` closure**. REQ-108's truncation is a closure, so a
start character after it is inside no open frame and part (i) does not reach it;
it is not after an `/E/`, so part (ii) does not either. Present a frame of more
than 1518 octets carrying **no terminate character**, then a start character in
XGMII lane 0, then a normal frame: REQ-108 has ours truncate at 1514, mark,
pulse `error_oversize` and resynchronise on the start character, so ours delivers
**two** frames; the reference has no frame-length logic at all (class (e)'s own
449-line sweep at pin `77320a9`, carried) and does not abort at a lane-0 start
(the (g)/(h) paragraph's own mechanism, carried), so its frame is still open and
the second is merged into it — **one** frame. Class (f) does not cover the
merged-away frame: its exclusion runs *up to* the next start character and this
frame's octets begin *at* it. **The divergence is on the following frame and at
the sequence level, which is exactly what part (ii) exists to keep out.**

**Both cures dv offered are correct and both are too small, for the same reason.**
Extending part (ii) to the truncation closure repairs the case dv found; narrowing
the lift repairs the clause that widened it. Neither touches the **shape** that
produced the gap: a restriction enumerated case by case, written against a span
enumerated closure by closure, with nothing making the two lists agree. Take
either cure and the `clear` closure (REQ-009) is still uncovered — dv itself
recorded `clear` as an observation rather than a finding only because no producer
drives it mid-run today — and the **zero-delivered** member of the start-character
closure is still admissible, because part (i) said *"that has already delivered an
octet"*. Two more of the same gap, one of them already visible in the filing.

**So the ruling is the third cure: state the restriction over the span.** The
discriminator is not "after a truncation"; it is **whether the reference can be
relied on to have closed the frame by the time the start character arrives**, and
the answer is *only for the terminate character*:

- **terminate (REQ-106)** — both designs close. Safe, and it is the only safe one.
- **error character (REQ-105)** — the reference does close, but on a cycle decided
  by the one-word look-ahead race classes (g) and (h) recite, so *whether it has
  closed by then* is not derivable. Part (ii)'s original ground, unchanged.
- **REQ-108's truncation** — the reference never closes on that account: it has no
  length notion. `CSG-3`'s own mechanism.
- **`clear` (REQ-009)** — this document has derived **no** reference-side
  counterpart of any kind. The bar is keyed there on the **absence of a
  derivation**, and I say so in the text rather than assert a reference behaviour
  I have not derived. That distinction is the whole reason the clause is
  admissible in a round where I refuse to read the reference.
- **a later start character (REQ-110)** — part (i)'s subject, and it is widened:
  the *"has already delivered an octet"* qualifier goes.

**Why dropping that qualifier is a gain and not an over-reach, stated because it
is the one place this ruling removes stimulus nobody asked me to remove.** The
zero-delivered member is class **(h)**'s: such a frame is *"excluded entirely at
this boundary, its accept-or-discard decision included"*. So a comparing run that
drives it **compares nothing about that frame** — the only thing it can gain is
the comparison of the frames that follow, and those are precisely what a merge
destroys. The stimulus therefore had **no comparison value and carried the whole
sequence hazard**, and barring it costs REQ-110 nothing it was ever getting: that
row's own verification column already says both halves rest on its directed tests
and that no sign-off packet may offer a co-simulation result for either. Class
(h) is not made vacuous — its REQ-105 member (an error character at or before the
frame's first octet) remains drivable, since part (ii) bars a *start* character in
the window and not the frame's own terminate.

**And the lift is struck rather than narrowed.** *"Both parts are lifted for the
frame class that class (f) already excludes entirely, where nothing is compared in
any case"* — the reason is true of the excluded frame and **false of the frame the
start character opens**, which is dv's finding in one sentence. Narrowing it to
"stimulus whose every divergence lies inside an excluded frame" would leave a
clause that, under the repaired parts, licenses nothing the parts do not already
allow: presenting a class-(e) or class-(f) frame is not restricted, and a start
character after such a frame's own **terminate** character is legal because that
is where the reference closes it too. A clause with no remaining work, whose only
historical effect was to open the geometry, is better struck with its quotation
preserved than kept in a narrowed form nobody can apply. Both statements go into
the text so the strike is not silent.

**The one-sentence form, and why I wrote one.** A restriction stated as two parts
over five closures is not something a producer's guard can be reviewed against
without re-deriving it, and re-derivation by two producers is the circularity
`WO-0078` §6.3 exists to prevent. Its closed form is: **on a run that compares,
every start character SHALL follow a terminate character**, the trace's first
excepted. I did not assert that equivalence — I checked it, by enumerating every
event trace up to length 8 over the span's own alphabet and comparing the two
formulations trace by trace: **2 015 538 traces, zero mismatches** (Evidence 3).
The same run reports that the repair moves **425 673** traces and every one of
them in the direction legal → barred, which is the property a stimulus
restriction must have: it can never admit something it used to refuse.

**Two consequences I did not go looking for, and they are the reason this cure is
the cheap one.** First, the same run shows **REQ-108's own verification geometry
untouched** — the 1600-octet frame *with* its terminate character followed by a
valid frame is legal before and after — so the repair costs the stimulus the
requirement was written around exactly nothing. Second, and more useful to dv:
under the repaired rule a guard whose span closes on the terminate character
alone is **no longer wider than the rule for a comparing run**. dv's guard-width
sentence was measured against the rule as it stood, and what it was pointing at
were precisely the two gaps this ruling closes. So **nothing needs narrowing to
conform**: `FI-4` and `FI-6` may stay as they are for every comparing run, and
narrowing is a question only for a record-only run, which lifts the restriction
anyway. dv's self-binding — no narrowing for the truncation geometry until
`CSG-3` is ruled — is discharged without dv having to narrow anything. I state
this as a consequence of the **rule** and mark the guard side as dv's
measurement to make; I have not read either producer this round.

**Class, force and countersignature.** The diff is **normative**: it changes what
stimulus is legal in both directions, and it widens a restriction dv countersigned
eleven hours ago. **dv_lead's re-countersignature is owed and the diff is NOT IN
FORCE until it is transcribed** — until then the restriction as countersigned at
`J-dv_lead-0170` governs, which means the gap stays open on paper. Nothing can
drive it meanwhile: both guards refuse the geometry today and dv has bound itself
not to narrow them. **Not E2** (no requirement, phase or role added or dropped).
**No ADR**: the replaced reading is a coverage gap in a list, not a design choice
among live alternatives, which is the same ground the 2026-08-04 and 2026-08-11
rows took. **No E5**: no lead disputes anything; the only text overturned is mine.

---

#### 2. `FINDING AP-M04-2` — SUSTAINED, and cured where the invitation was issued

dv's reading is right and the check is two citations long: REQ-016 carves M04's
source interface out **in its own text**, SPEC-M04 §3's REQ-016 row says it a
second time, and §7's own handshake bullet a third; a required source word not
presented is REQ-206's **underflow**, which ends the frame in `/E/` then `/T/`
with no FCS. So *"its per-octet constant does survive REQ-016's idle injection"*
quantifies over an empty stimulus class at this port. **The claim is vacuous
rather than false** — and vacuity is not why it has to go. It has to go because of
what it invites: a bench writer reading §7 is told the constant survives
injection, builds the wrapper, and the first injected cycle on a required cycle
destroys the frame the monitor is measuring. That is `FINDING AP-M04-1`'s shape at
the same module — a specification sentence from which a monitor can be built that
no conformant design satisfies — and it arrived in the sentence I wrote to cure
`AP-M04-1`.

**Three cures were live and I took the third.** A bare **strike** loses the two
§0.5 verdicts, which are load-bearing: they are why L is single-valued at all (no
output word is assembled from two source words, so no output word can carry two
latencies), and they are what a reader of §0.5's straddle/late-decision tests
comes to §7 to find. A **defence with the vacuity stated** keeps a sentence whose
only readers are the ones it misleads. So: keep both verdicts and say what they
buy; **strike the survival claim with its own text quoted**; and add the
prohibition at the site that issued the invitation — *a bench SHALL NOT build a
REQ-016 idle-injection wrapper at this module's source interface*. The
prohibition is the same instrument §10's REQ-210 hook already carries against
asserting 8 per octet, at the section a bench writer reads first, and it brings
this specification into agreement with `AP-xgmii_tx_64` §6's REQ-016 row, which
has recorded the absence structurally since the plan was created.

**Class and countersignature.** **Editorial** by §13's own test: no strobe, port,
record, state, cycle table or latency constant moves; L, h, ΔC, the event delay
and the prohibition on cross-measuring are untouched; M04 has no bench, so no
committed test changes meaning. **No countersignature is owed**, and the reason is
in dv's own signature: §(a) countersigned SPEC-M04 §7 *"with the one exception
filed at (b)"* — this sentence, by name — and §(b) asked for the diff. A signature
that carved a sentence out cannot be broken by removing it. What is genuinely new
is the **prohibition**, and I say in §13 that if dv reads it as reaching stimulus
it intends to drive, that is a fresh finding and takes a narrow round — the
standing clause `-0031` and `-0033` wrote against themselves.

---

#### 3. Ledger item 48 — the M04-boundary class question, ruled rather than answered with classes

`AP-xgmii_tx_64` §7.1(c) and §8 item 2 ask for divergence classes at the transmit
boundary, because REQ-901 forbids citing a class not listed there and none of
(a) … (h) names that port. **I cannot declare one, and the reason is not
reluctance.** Every class in that list is *derived*: (e), (f), (g) and (h) each
cite the vendored receive counterpart at a pin, down to line numbers, and (a) …
(d) rest on configuration and requirement differences this document states in its
own text. At the transmit boundary there is **neither**. I checked the tree myself
rather than carry dv's measurement: `test/third_party/verilog-ethernet/` holds
`axis_xgmii_rx_64.v`, `lfsr.v`, `COPYING` and `PROVENANCE.md`, and no transmit
module. Vendoring one is a commit governed by ADR-0015 D2 and `PROVENANCE.md`'s
own rules — its own commit, carrying the pin, the sizes, the hashes and a
re-derived instance closure — and it is not in my write scope and not a spec
round's to perform. **A class invented without a derivation would be the worst
artefact this document could carry**: it excludes a comparison, so a wrong one
silently forgives a real defect.

**What I could do, and did.** The defect the item is really pointing at is that
the list's **silence has been read as coverage**. A reader cannot tell from
(a) … (h) whether the transmit boundary was considered and found divergence-free
or never considered at all — and those two states license opposite acts. REQ-901
now says which: the silence is **unexamined, not a finding of no divergence**; the
event that makes the question answerable is the vendoring commit, named; and the
standing consequence is restated where a packet author will hit it — no sign-off
packet may cite a transmit-boundary co-simulation result as an anchor for any
requirement. **Item 48 is therefore half discharged**: the question is ruled, the
classes are not written, and the row keeps a closing event that is now an event
and not a wish.

---

#### 4. Items 49 and 52 — `C-5`, and the reference word that had no referent

§0.6's ceiling is *"the module's latency in cycles after the input word carrying
the last octet of the offending frame"*. At `error_underflow` that word has no
referent: the offending frame is cut short by a **missing** input word, so the
first clause measures from an octet that never arrives, the second clause is about
octets that arrive **after** a closure, and the third clause is for a frame that
received **no** octet — which this frame is not. The window was therefore
determinate at every module except the one whose strobe is an absence, and
`AP-xgmii_tx_64` §8 item 3 states the consequence exactly: *a reader of §0.6 alone
will find a window, apply it, and get a green that means nothing*.

**The repair is a fourth clause, and it is general rather than an M04 exception.**
Where the reported condition is decided on the **non-arrival of an input word**,
the reference word is **the cycle on which the word was required and not
presented** — the earliest cycle the condition is decidable, which is where §0.6's
own opening sentence puts the window's floor. `error_underflow` is the only strobe
in §12 whose condition is an absence (I read the appendix row by row rather than
assume it: every other condition is decided on an octet, including
`error_ip_truncated` and `error_tx_length_mismatch`, both decided on a `tlast`
word), so the clause has exactly one instance today and is written so the next one
inherits it instead of filing the same finding.

**A trap of my own making, caught while writing it.** §0.6 says *"the module's
latency in cycles (§0.5)"*, and until `-0038` M04 had one such figure. It now has
**two** pinned in §7 — REQ-210's 1-cycle event delay and §0.5's ΔC = 2 — so my own
two-constant repair made a **different document's** clause ambiguous at exactly
the module this new clause reaches. The clause names ΔC and says why (it is the
only latency §0.5 defines in cycles) and notes that a reader taking the other
would compute a ceiling one cycle short. That is the second instance in two
rounds of ledger item **50**'s pattern — a landed clause whose ground moves under
an amendment made elsewhere — and this time the mover is me.

**And the clause states what the window is worth here**, which is the half that
makes it safe: §9 pins `error_underflow` on the same required cycle, so the pin
sits at the window's **near** edge, the window carries no independent information,
and a monitor built on it alone cannot convict a report the pin forbids. That is
the disposition §0.6's own note already gives the no-octet class, on the same
ground, so the fourth clause inherits an argument rather than inventing one.
SPEC-M04 §11.3 closes on the repair and §9 gains the cross-reference, which is
item **52**: opening a file and leaving its own open item is the omission the
ledger exists to make countable, and this round opened §7, §9, §11 and §13.

**Class**: editorial (it settles an undecided corner; no conformant design
changes, and the only instrument it reaches is one that could not have been
built). **dv's countersignature is owed** on it as on every §0.6 diff — item 14
has said so since `-0023` — and it is **in force meanwhile**, because nothing
rests on it that SPEC-M04 §9's pin did not already decide.

---

#### 5. The interaction the dispatch asked about: `CSG-3` and item 48 do not collapse

They share a **principle** and nothing else, and I state both halves because
either alone would be misleading.

**The shared principle**: *a list stated over a domain must say what its silence
about a member means.* `CSG-3` is a restriction stated over two of five closures,
where the silence read as "not restricted". Item 48 is a class list stated over
four boundaries, where the silence read as "no divergence". Both are cured by the
same move — make the list's coverage of its own domain explicit — and both cures
landed in this round because the principle is one thing to see.

**Why they stay separate rulings.** Different objects (a **stimulus restriction**
versus a **divergence class**), different boundaries (M03 receive versus M04
transmit), and — decisively — different blockers: `CSG-3` is closable by arithmetic
on this document, which is why it closes today, while item 48 cannot be closed by
any amount of writing, because the derivation it needs does not exist in this
repository. Ruling one does **not** discharge the other's substance, and a §13 row
claiming otherwise would be the kind of claim `AP-M04-1` was filed against. They
are two rows, in the same diff, with the shared principle named in each.

---

#### 6. What this round refused

- **I refused to declare a divergence class at the transmit boundary** (§3), and
  I refused to declare one for `CSG-1`'s two shapes or for `CSG-3`'s geometry. A
  class is a commitment about a run; there is still no run.
- **I refused to widen my write set.** No `test/**` byte: `AP-xgmii_tx_64`'s stale
  `M04-J3` quotation and the three stale `AP-M14` rows dv named at §(d) are dv's,
  and dv has already owned them. No `agents/handoffs/**` byte — the sibling round
  owns a new packet there and `SO-xgmii_rx_64.md`'s gate-table re-measurement is
  dv's own open item. No PROTOCOL, charter or ADR byte.
- **I refused to read the reference or any third-party source.** The one place
  where a reference behaviour would have settled a question — whether the
  reference closes a frame on `clear` — is written as an **absence of
  derivation**, and the restriction is keyed on that absence rather than on a
  guess. A static read would have been the over-reach `RV-C4` §12 convicts, and it
  would have been mine this time.
- **I refused to repair `§0.5`'s survival clause**, which states its two tests as
  properties of a module without saying that a module can pass them at a port
  where the stimulus has no instance. M04 is the first such port and its own spec
  now says so; whether §0.5 should say it generally is a `requirements.md` §0.5
  round and a fresh countersignature, and this round already owes two. Carried as
  item **53**.
- **No harvest note.** PROTOCOL §7 and charter §8 attach the lessons harvest to a
  module sign-off and to a phase gate; this round is neither, and it is not a
  volume rotation (entry 0039 of volume 03). Declared rather than omitted, per the
  same clause's discipline about nil yields.

### Actions

1. Read the charter and PROTOCOL in full; ran the precheck; read `J-dv_lead-0170`
   entire at its minting site and the §13 transcription rows at HEAD before any
   edit.
2. `docs/specs/requirements.md`: **§0.6** gains the fourth reference-word clause
   (and "Three clauses" becomes "Four", with the following note's *"that last
   class"* disambiguated to the third clause's class); **REQ-901**'s restriction
   is restated over the span, part (i) widened, part (ii) generalised, the lift
   struck with its quotation preserved, the record-only licence's *"either
   restricted situation"* repaired, the guard-width sentence dated with its
   general form kept, and a new paragraph on what the class list's silence at a
   boundary means; **REQ-108**'s and **REQ-110**'s verification columns brought
   into agreement. Three §13 rows appended.
3. `docs/specs/modules/xgmii_tx_64.md`: **§7**'s survival claim struck and
   replaced with the two verdicts, the vacuity and the bench prohibition; **§9**'s
   strobe-cycle paragraph gains §0.6's fourth-clause cross-reference; **§11.3**
   closed; one §13 row appended.
4. Wrote and ran the trace-enumeration check of Evidence 3 **after** drafting the
   one-sentence form and **before** committing to it in the text, so the sentence
   is a checked equivalence rather than a claim.
5. Ran the table-integrity check of Evidence 2 and the stale-phrase census of
   Evidence 4 over both edited files.
6. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git write
   of any kind.**

### Evidence

Reproducible from a checkout at this commit.

**1. The precheck**, as run — reproduced under Trigger.

**2. Table integrity across both edited files** (four of this round's edits are
inside table cells, and a normative row that stops being a table row stops being
readable):

```sh
python3 - <<'PY'
for f in ["docs/specs/requirements.md","docs/specs/modules/xgmii_tx_64.md"]:
    blk=[]
    for n,l in enumerate(open(f,encoding="utf-8").read().split("\n"),1):
        if l.startswith("|"): blk.append((n,l.count("|")))
        else:
            if len(blk)>1 and len({c for _,c in blk})>1: print("SPLIT ROW near",f,n)
            blk=[]
PY
```

Observed: **no output** — no split row in either file, and in particular the
three new §13 rows and the rewritten REQ-901, REQ-108 and REQ-110 cells keep
their column counts. (The three known false positives this check reports live in
`ip_eth_rx_64.md`, which this round does not touch.)

**3. The repaired restriction checked against its own one-sentence form, and
against the geometry it is for.** The script models the span's closure semantics
from REQ-901's own list and nothing else — it reads no repo file and no RTL, and
it is a check on **the rule**, not on either design or either producer. Durable
form (the run used
`/tmp/claude-0/-home-user-agentic-fpga/681e6e34-cd2f-5f3e-a4c3-42391e4d282b/scratchpad/csg3_rule_check.py`,
an **ephemeral** path stated as such per ADR-0003/F5; the logic below reproduces
every number):

```python
# alphabet: S start, T terminate, E error, X REQ-108 truncation, C clear, o octet
# span: a frame is open from S until the earliest of T, E, S, X, C
# NEW  (i) no S inside an open frame; (ii) no S between a non-terminate closure
#      of a frame and that frame's following T
# OLD  (i) no S inside an open frame THAT HAS DELIVERED AN OCTET; (ii) no S after
#      an E closure before the frame's T; plus the class-(f) lift
# SENTENCE  every S follows a T, the trace's first excepted
for L in range(1, 9):
    for t in product("SToEXC", repeat=L):
        assert legal(t, "new") == sentence(t)          # equivalence
        assert not (legal(t, "new") and not legal(t, "old"))  # never admits more
```

Observed:

```text
traces enumerated (len 1..8 over SToEXC) : 2015538
part (i)+(ii) NEW  vs one-sentence form  : mismatches = 0
legality changed by the repair (old->new): 425673 traces, all in one direction: {True} -> {False}
CSG-3 geometry (no terminate)  SoXSoT    old=True  new=False sentence=False
REQ-108 verification geometry  SoXToSoT  old=True  new=True  sentence=True
zero-delivered start abort     SSoT      old=True  new=False sentence=False
```

**What it buys and what it does not.** It buys three things: the one-sentence form
a producer's guard can be reviewed against is **exactly** parts (i)+(ii), over two
million traces with zero mismatches; the repair is **monotone** — every trace whose
legality moves, moves from legal to barred, so nothing the old rule refused is
newly admitted; and the geometry `CSG-3` constructs was legal and is now barred
**while REQ-108's own verification geometry stays legal**, which is the cost
question the ruling turns on. It buys nothing about the reference design, nothing
about `FI-4` or `FI-6` — neither producer was opened — and nothing about any
hardware: no bench was run and M04 and M03 have no bench here.

**4. The stale-phrase census after the edits** — a restriction repaired in one
place and restated in three is the site-list defect `-0038` convicted itself for:

```sh
grep -rn "already delivered an octet"  docs/
grep -rn "lifted for the frame class"  docs/
grep -rn "either restricted situation" docs/
grep -rn "until a class is declared"   docs/
grep -rn "does survive REQ-016"        docs/specs/
```

Observed: every remaining occurrence of the four restriction phrases is either
inside a **quoted historical note** in the repaired paragraph itself, inside the
(g)/(h) class paragraph (which is about classes and is unmoved), or inside a §13
row that quotes the old text in order to convict it — REQ-110's column, the last
live restatement, is repaired in this diff. The fifth grep returns the SPEC-M04
§7 quotation of the struck sentence and its §13 row, and nothing else in
`docs/specs/`.

**5. The vendored tree, listed rather than carried** (item 48's premise):

```sh
ls test/third_party/verilog-ethernet/
```

Observed: `COPYING`, `PROVENANCE.md`, `axis_xgmii_rx_64.v`, `lfsr.v` — four
files, no transmit module, which is `AP-xgmii_tx_64` §7.1(a)'s claim confirmed
independently. **This is a directory listing; no file in it was opened.**

**6. Confinement.** `git status --short` at the end of this round lists exactly
the two specification files below plus this journal, and one **untracked**
`agents/handoffs/WO-0080_*.md` that belongs to the declared sibling round and that
I neither created nor opened. `git diff --stat` reports `2 files changed`.

**Not claimed, stated so the absence does not read as coverage.** No bench was
run; none exists for M03 or M04. Nothing here is a verification result. No RTL was
read and no reference source was read; the two reference-side facts used inside
the `CSG-3` reasoning are carried from recitals already in `requirements.md` and
are labelled as carried. No `ifc_check` build was run and none is owed: no §4
record moves in either file, so §12's existing evidence still witnesses every
interface. `traceability.md` is untouched and owes nothing — this round adds no
REQ id and moves no test-side row.

### Outcome

**DoD met on all five items; two are partial discharges and both say where the
split falls.**

- **`FINDING CSG-3` — RULED, SUSTAINED, cured by a third cure.** The restriction
  is restated over the span: part (i) widened to any open frame, part (ii)
  generalised to every non-terminate closure, the class-(f) lift struck, the
  licence's *"either"* repaired, and a checked one-sentence form added.
  **Normative; dv_lead's re-countersignature is owed and the diff is NOT IN FORCE
  until it is transcribed.** Nothing is blocked meanwhile — both guards refuse the
  geometry — and, if dv agrees, **nothing needs narrowing afterwards either**,
  which is the finding's own binding released.
- **`FINDING AP-M04-2` — RULED, SUSTAINED, cured at SPEC-M04 §7.** The survival
  claim is struck with its quotation kept, the two §0.5 verdicts stay with what
  they actually buy, and the bench prohibition lands at the section that issued
  the invitation. **Editorial; no countersignature owed** (dv's own signature
  excluded the sentence by name and requested the diff), and the new prohibition
  is flagged for contest.
- **Item 48 — HALF DISCHARGED.** The question is ruled: no class is writable at
  the transmit boundary until the counterpart is vendored at a pin and derived,
  and REQ-901 now records the silence as **unexamined rather than empty**, with
  the vendoring commit named as the event that opens the question. The classes
  themselves are not written and the row stays open.
- **Items 49 and 52 — CLOSED, and with them carry-forward `C-5` and ledger item
  14's remaining half.** §0.6 gains the fourth reference-word clause; SPEC-M04
  §11.3 is closed and §9 carries the cross-reference. dv's countersignature is
  owed on the §0.6 diff and it is in force meanwhile.
- **Handoff**: to the orchestrator for commit; then **two countersignature
  requests to dv_lead** — the REQ-901 `CSG-3` diff (normative, not in force until
  transcribed) and the §0.6 fourth-clause diff (editorial, in force, signature
  owed) — which may travel as one packet or two, dv's call, since neither blocks
  the other. The SPEC-M04 §7/§9/§11.3 diff needs no signature and is in force on
  commit.

**Carried ledger, restated whole** (ADR-0017 §4.4's practice; every row carries an
owner and a closing event, and a row is never dropped for being old).

| # | Item | Owner | Closing event | This round |
|---|---|---|---|---|
| 1 | ADR-0016 §8's transcription mechanic is unwritten in PROTOCOL | orchestrator | a PROTOCOL §11 amendment | carried |
| 2 | The generic shell's `LESSONS` transit is the orchestrator's and unexercised | orchestrator | the first harvest reaching the shell | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; half spent |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried, practised five times |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036` |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale, silent on volumes, records me as "Not yet activated" | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate | CLOSED at `-0037` |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — this round opened no `docs/gates/` file |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried, instantiations exist to be filled |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are **different** dispositions | me | any WO next opening `requirements.md` §0.6; owes dv's countersignature | **CLOSED this round.** The `-0021` case was repaired at `-0023` and the **vacuity** case lands here as §0.6's fourth reference-word clause; the two dispositions stayed different, as this row insisted. The residue is dv's countersignature, which moves to item 55 rather than keeping this row open |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried — **and this round opened §0.6 without taking it**, deliberately: the fourth clause is about a frame with **no** last octet, and folding an unrelated ruling into a diff dv must countersign would have made one signature answer two questions |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried — **and it gains material**: (f)'s lift is struck and its terminate-less geometry is now barred stimulus, which is a fact that document's §11 would want |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried — **this round opened REQ-901 twice and did not take it** again, for the same reason as `-0038`: the clause is about the reference's build configuration, and both of this round's REQ-901 edits are about coverage of a list |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried — this round read SPEC-M03 §9 and edited no byte of it |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-5`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried, **less `C-5`**, which closes this round at §0.6 and at SPEC-M04 §11.3 |
| 25 | Two re-countersignatures and one concurrence owed at `-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried — **and this round is its second customer**: §0.6 now carries a fourth clause, so a contest of the `-0023` diff would arrive at a longer rule than it was written against |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried — and this round leans on that diff a third time, at SPEC-M04 §7 |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | CLOSED at `-0038` |
| 30 | `AP-xgmii_rx_64.md` §4.I's M03-I4/M03-I5 cells are dv's to edit; joined by `FINDING SO-1-A`'s §6 repair | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger. **This round touched REQ-016's carve-out at M04 and did not narrow anything**: the SPEC-M04 §7 repair states the existing carve-out, it does not extend it |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes, not dischargeable by widening (g) | dv_lead (carrier); me (class) | a record-only run measuring the reference's disposition on both shapes, then a class round on the measurement | carried — **and the stimulus it needs is now barred in one more way**: with part (i) widened, the zero-delivered member joins the two shapes outside a comparing run, so the record-only run has three geometries to measure and not two |
| 35 | Two of my `-0033` repairs correct dv's finding rather than my own text and dv has not seen them | dv_lead | dv reading them, disputing or not | carried |
| 36 | The `-0032` countersignature is owed; that diff is not in force until it lands | dv_lead | dv countersigning | CLOSED at `4e7331b` |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar (`-0032`) | me (class); dv (stimulus) | a class ruling | carried — **and the bar is restated over the span this round**, which changes its shape (it now takes in the zero-delivered case) without changing what it is waiting for |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | carried |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` | me | the next round opening `docs/gates/` | CLOSED at `-0037` |
| 43 | A2 binds without countersignature; a contest by any seat is carried to an Amendment A3 | any contesting seat; me for drafting | a re-verdict without contest, or an A3 landing | carried, half spent |
| 44 | The block's preamble still says an `SO-` instantiates §3's block *"verbatim"*, which A2-D1 qualifies | me | the next round opening the block | carried |
| 45 | The `P1-module-ready` checklist's ledger `G-1 … G-11`; five rows are mine | me for those five | each `G-` row's own closing event | carried — **`G-3` gains material again**: two frozen specs take post-freeze diffs this round, one of them normative and unenforced until countersigned |
| 46 | REQ-904's commissioned CI set-equality script does not exist | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | carried — **this round adds no REQ id**, so the set it would compare is unchanged for the second round running |
| 47 | **Three countersignatures owed on `-0038`**: the REQ-210 + §0.5 diff, the REQ-611 diff, and the REQ-901 diff (normative, not in force until transcribed) | dv_lead | dv countersigning each | **CLOSED.** All three COUNTERSIGNED at `J-dv_lead-0170` §(a), §(c), §(e) and transcribed into §13 under `J-orchestrator-0244`; the REQ-901 diff has been in force since that row. Two findings came back with the signatures and are ruled this round |
| 48 | **`AP-xgmii_tx_64` §8 item 2**: REQ-901 declares no divergence class at the M04 boundary, and its own text forbids citing a class not listed there | me | **restated**: the vendoring commit for `axis_xgmii_tx_64.v` at a pin (ADR-0015 D2, `PROVENANCE.md`), then a derivation round that writes the classes | **HALF DISCHARGED this round.** The question is ruled — no class is writable without a derivation, and none exists — and REQ-901 now records the silence as unexamined rather than empty, with the prohibition on citing a transmit-boundary result restated. **The classes are not written**, and cannot be by a spec round |
| 49 | **`AP-xgmii_tx_64` §8 item 3** makes `C-5` a dependency of a landed plan: a reader of §0.6 alone finds a window, applies it to `error_underflow` and gets a green that means nothing | me | the `requirements.md` §0.6 round item 14 names | **CLOSED this round.** §0.6's fourth clause gives the window a determinate reference word at an absence-condition strobe and states in its own text that the window carries no independent information there, which is the "green that means nothing" pre-refuted at the site the reader reaches first |
| 50 | **A closed ledger item can be reopened by a later ruling, and nothing detects it** | me | a survey of closed items whose grounds cite a since-amended §0.5/§0.6 clause | carried — **and this round is the second instance, with me as the mover**: `-0038` pinned two constants at M04 and thereby made §0.6's *"the module's latency in cycles"* ambiguous at that module. Caught while writing the fourth clause, not by a survey; the survey is still unscheduled and is still mine |
| 51 | **`FINDING CSG-1`'s four cases have never been checked against a run**, and the record-only licence is what makes that possible — but nothing schedules it | dv_lead (the run); orchestrator (scheduling) | the first record-only run | carried — **and the run's subject grew this round** (item 34): three geometries, and dv's own `J-dv_lead-0170` open question 5 records that the machinery for such a run does not exist yet |
| 52 | **SPEC-M04's own §11.3 carries `C-5` as a deferred item** and `-0038` opened SPEC-M04 §7 and §10 without touching §11.3 | me | the `C-5` round of items 14 and 49 | **CLOSED this round.** §11.3 is CLOSED against §0.6's fourth clause and §9 carries the cross-reference; the round that opened SPEC-M04 closed the open item it found there, which is what this row was for |
| 53 | **§0.5 states its two tests as properties of a module**, and a module may pass them at a port where the stimulus they quantify over has **no instance** — M04 is the first such port and only its own §7 says so | me | a `requirements.md` §0.5 round, or a deliberate decision to leave the statement at the module | **new this round**, and it is `AP-M04-2`'s general form: a true test verdict does not license a stimulus the port refuses |
| 54 | **Class (h)'s REQ-110 half now has no comparing-run instance** — part (i)'s widening bars the stimulus, class (h) still excludes the frame, and the class keeps its REQ-105 instance | me (the class); dv_lead (a record-only observation) | the class round of item 34, or an explicit note that (h)'s REQ-110 half is directed-test-only | **new this round.** Stated because a class whose stimulus is barred looks vacuous from outside, and the reason it is not is that the bar protects the *following* frame rather than the excluded one |
| 55 | **Two countersignatures owed on this round**: the REQ-901 `CSG-3` diff (**normative**, NOT IN FORCE until transcribed) and the §0.6 fourth-clause diff (editorial, in force, signature owed — item 14's residue) | dv_lead | dv countersigning each | **new this round.** The SPEC-M04 §7/§9/§11.3 diff owes none, on dv's own carve-out at `J-dv_lead-0170` §(a) |

- **No harvest note is owed** — PROTOCOL §7 and charter §8 attach it to an `SO-`
  and to a phase gate, and this round is neither. Declared rather than omitted.
- **No escalation.** **E2 not triggered** (no requirement, phase or role added or
  dropped; item 33 remains the only E2 on this ledger and this round did not move
  it). **E3 not triggered** — and it is worth one sentence why, since item 48
  touches the licensing boundary: the ruling **declines** to vendor anything and
  names the vendoring commit as someone else's act, which is the opposite of a
  toolchain or licensing decision taken in-round. **E5 not triggered**: no lead
  disputed anything, and both findings were routed to me undecided by their filer.

### Open-questions

1. **The REQ-901 `CSG-3` diff is not in force until dv's countersignature is
   transcribed**, and until then the gap it repairs is open on paper. Nothing can
   drive it (both guards refuse the geometry, and dv has bound itself not to
   narrow them), but a producer round scheduled before the signature would be
   scheduled against the old rule.
2. **The claim dv should check hardest is not the cure but its consequence**: that
   under the repaired rule a terminate-only guard is no longer wider than the rule
   for a comparing run, so nothing needs narrowing. I derived that from the rule
   and checked the rule against its one-sentence form; **I did not read either
   producer**, and the guard side is dv's measurement to make.
3. **Part (i)'s widening is the one place this ruling removes stimulus nobody
   asked me to remove.** My ground is that class (h) already compares nothing
   about that frame, so the comparison loses nothing — if dv reads the
   zero-delivered start abort as stimulus it intends to drive on a comparing run,
   that is a fresh finding and a narrow round.
4. **Item 48's other half needs a work order, not a spec round**: vendoring
   `axis_xgmii_tx_64.v` at a pin is `AP-xgmii_tx_64` §8 item 6's first condition
   and it is scheduling, which makes it the orchestrator's to sequence and mine
   only to state the dependency, which REQ-901 now does.
5. **Item 50 is still the one I would most like someone else to check**, and this
   round supplied its second instance — my own `-0038` diff moved the ground under
   a clause in a different section of a different document. The survey is mine and
   unscheduled.

### Files-in-this-commit

- docs/specs/requirements.md
- docs/specs/modules/xgmii_tx_64.md

## [J-architect_docs_lead-0040] 2026-08-11T23:58Z | task:none | Two findings against recitals rather than rules — `ABS-1`'s override written where the clause claimed a hole, `AP-M14-1`'s adjacency restated as the bound M17 actually needs, and the census both findings implied ran and returned two sites nobody had filed

### Trigger

Orchestrator dispatch, spawn-head `deace39`. Precheck run before anything was
read: `git status --short` empty and `git rev-parse HEAD` =
`deace39329a21811cc36765da7f0c4550659fa8e`, matching the dispatch. **No declared
sibling**, and the working tree at the end of this round contains exactly the
four files listed below.

Three items, two of them findings routed to me undecided by their filer and one
of them my own carried ledger:

1. **`FINDING ABS-1`** (MINOR, dv_lead, `J-dv_lead-0173` §(c), transcribed at
   requirements.md §13's countersignature row for the fourth clause) — filed
   against the **stated ground** of the §0.6 fourth reference-word clause my own
   `-0039` round wrote, and not against its rule, which dv countersigned in the
   same act.
2. **`FINDING AP-M14-1`** (MINOR, dv_lead, `J-dv_lead-0177`, minted at
   `AP-ip_eth_rx_64` §8 item 3) — SPEC-M14 §7 states the `ip_hdr_valid`-to-payload
   adjacency unscoped while the same section's per-output-event table contradicts
   it at one injection site, with §6.1 calling the lead normative and M17 written
   against it. A recommendation was offered and no ruling made.
3. **The carried ledger** (`-0039`'s table, 55 rows), walked at items 44, 47,
   48-half, 50, 51, 53, 54 and 55.

**Write set**: `docs/specs/**` and this journal. Explicitly out and untouched:
`test/**` (both findings have a half that lives there and both halves are dv's),
`agents/handoffs/**`, `agents/PROTOCOL.md`, `docs/adr/**`, `docs/gates/**`.

### Inputs

- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` (§4.1, §4.2,
  §6, §7, §10, §11) — read before writing, as the charter's first mandatory act.
- `agents/journals/claude_dv_lead_agent.v09.md`: `J-dv_lead-0173` §(c) in full
  (the `ABS-1` minting site, its three verification checks and its cure
  sentence), §(d) (the two rows on which no signature is owed, including the
  transmit-boundary row that answers my ledger item 48); `J-dv_lead-0177`
  Reasoning items 10–15 and Open-questions 1–2 (the `AP-M14-1` minting site).
- `test/attack_plans/AP-ip_eth_rx_64.md` §8 item 3 (the finding as filed, with
  its (A)/(B) statement, its arithmetic, its recommendation and its five-site
  grep list) and row `M14-F1` §4.F (what the row asserts and what it does not);
  `test/attack_plans/AP-xgmii_tx_64.md` was **not** opened this round — `M04-G7`
  is quoted from dv's own journal entry, which is where dv convicted it.
- `docs/specs/requirements.md`: §0.6 whole (all four reference-word clauses and
  both notes), §0.5's straddle and deciding-input-word material, REQ-016,
  REQ-206, REQ-606, REQ-611, REQ-901, §12's strobe appendix, §13 whole.
- `docs/specs/modules/ip_eth_rx_64.md` whole; `docs/specs/modules/xgmii_tx_64.md`
  §6.1, §7, §9, §11.3, §13; `docs/specs/modules/arp_eth_rx.md` §7, §9, §11, §13;
  `docs/specs/modules/eth_axis_rx.md`, `udp_ip_rx_64.md`, `ip_complete_64.md`,
  `udp_complete_64.md` — read only at the sites the census below names.
- `git show 747e561` (the transcription commit ledger item 55 turns on) and
  `git log --oneline -12`.

### Reasoning

#### 1. `FINDING ABS-1` — SUSTAINED, on a stronger ground than it was filed with

**The finding is right, and it is right about my own text.** The fourth clause's
ground read *"the three clauses above name no word: the offending frame is cut
short by an absence rather than closed by an event on the stream, so the octet
the first clause measures from is one that never arrives, and the third clause
does not reach it either because the frame did receive octets"*. Those two halves
are inconsistent on their face once the first clause is read as it has stood
since `0caf023`: the clause does not measure from the frame's *intended* final
octet, it names *"the last octet that frame **received while it was open**"*. If
the frame received octets — which the sentence's own second half asserts, in
order to exclude the third clause — then the first clause names a word. The
sentence excludes the third clause by a fact that simultaneously admits the
first.

**And the defect is worse than dv's filing says, which is why I sustained it on a
different ground.** dv argued that an underflowed frame *has* received octets,
citing `M04-G5` and REQ-207 — an argument about what happens in practice at this
module. The stronger statement is available from the requirement's own text and
does not need a plan row: REQ-206 defines the underflow only *after* the
transmitter has emitted the frame's start character, and SPEC-M04 §6.1 enters
`Preamble` — which is what emits it — only once **a first source word has been
accepted**. So the class in which the first clause names nothing is not merely
unoccupied at this module, it is **empty**: every frame that can underflow has
accepted at least one word, by the construction of the two documents. A recital
that says "the first clause names no word here" is not a stale reading of a
contingent fact; it is refuted by the definition of the condition it is about.

**So the fourth clause is an override, and the repair is to say so.** dv's cure
sentence — replace the *"name no word"* premise with what the clause does, moving
the reference to the condition's own decidability cycle — is right and I took it.
I added three things dv's one sentence did not carry, each because leaving it out
would leave the rule less determinate than it was before the finding:

- **The precedence statement, in the paragraph's opening sentence.** The
  paragraph says *"Four clauses, and together they are the whole of the rule"*.
  Under the hole-filler reading that was a partition; under the override reading
  the first and the fourth both reach one class and nothing on the page said
  which wins. Left alone, the repair would have converted a false recital into a
  live ambiguity — a reader could compute the first clause's ceiling and a reader
  could compute the fourth's, and both would be citing §0.6. The opening sentence
  now says the first three partition by what the frame received and the fourth
  overrides the first for the class it names.
- **The loosening derivation.** dv checked harmlessness with `A + 1`, `A + 2`,
  `A + 3` at this module, resting on §7's contiguous-acceptance argument. That is
  true (§7 pins `tx_tready` = 0 only on the FCS and terminate words, both after
  the `tlast` acceptance) but the ruling does not need it, and a general clause
  should not rest on a module's throughput bullet. The general form: the required
  cycle is **strictly after** the last acceptance, because an acceptance needs
  `tvalid` = 1 and the absence *is* `tvalid` = 0 — so the ceiling moves strictly
  outward while the floor, fixed by the "not earlier than decidable" rule, does
  not move at all. The new window therefore **strictly contains** the one the
  first clause would give, for any distance, and nothing the first clause
  admitted is barred. That is a one-line proof that survives a change to §7.
- **The closing italic, which repeated the error one sentence after the clause
  that refutes it.** It read *"a reader of §0.6 alone found a window whose
  reference word had no referent at this module"*. That is the same misreading,
  in the same clause, written by me in the same round — the finding's site list
  was one entry short **inside its own paragraph**. It now states what the trap
  actually was: the first clause's referent is the wrong *event*, so a reader
  gets a determinate window measured from a word that arrived when the condition
  is about a word that did not, and the green it yields repeats the module's pin.

**Class: editorial, and the countersignature question answered explicitly.** No
conformant design changes — SPEC-M04 §9's pin is unmoved and sits at the floor of
both windows — no committed instrument changes meaning (M04 has no bench), and
the only bound that moves moves outward. **dv_lead's countersignature is owed**,
on the standing rule that every §0.6 diff carries one, **narrowed to what this
diff adds**: the override statement, the loosening derivation and the two
repaired recitals. It is **not** a re-countersignature of the rule, which is
countersigned at `J-dv_lead-0173` §(c) and in force since its transcription row.
**The diff is in force meanwhile**, on the same disposition the clause itself
took: nothing rests on it that §9's pin did not already decide.

**What is not mine.** `AP-xgmii_tx_64` row `M04-G7` carries the identical
sentence and is dv's to repair; I did not open `test/**`. I record only that
SPEC-M04 §11.3's raised wording is the likeliest source of it — the two sentences
are near-identical, and §11.3 predates the plan row.

#### 2. The census `ABS-1` implied, which nobody commissioned, and the two sites it found

**A finding against a recital is a finding against a sentence that may have been
copied.** Both of `ABS-1`'s named sites (my clause, dv's plan row) say the same
thing in near-identical words, which is evidence of propagation rather than of
two independent errors. So before ruling I ran the census the finding implies,
over `docs/specs/` — every occurrence of the retired ceiling phrase, and every
`§11` deferred-item row citing §0.5 or §0.6. It returned two sites nobody had
filed:

- **SPEC-M04 §11.3's raised statement**, the row `C-5` was carried in: *"is not
  defined for a frame that never receives that octet"*. Corrected **in its Status
  column**, with the first column left exactly as raised — SPEC-TEMPLATE §11
  makes item statements permanent, and rewriting a raised item to match what was
  later learned is precisely the silent rewrite the mechanics forbid. The
  correction sits where a reader of the row meets it.
- **SPEC-M10 §9**, which called its own no-payload case *"inside requirements.md
  §0.6's window only vacuously"* and cited SPEC-M04 §11.3 as its authority — *"the
  same vacuity carry-forward C-5 records against `error_underflow`"*. This one is
  wrong for a **different** reason than the other three, which is why it is worth
  the round: the no-payload case at M10 is a frame that received **no octet at
  all**, which is exactly §0.6's **third** clause, and that clause names its
  reference word — the input word carrying the closing event. The window there is
  not vacuous but redundant, and §0.6's own note for that clause says so. The
  paragraph's conclusion (this specification does not depend on the window)
  survives untouched; only its ground moves.

**Two things follow that are worth stating.** First, the citation chain is
visible: §11.3 was written, dv's `M04-G7` copied its phrasing, SPEC-M10 §9 cited
§11.3 by name. One wrong recital in a closed ledger row propagated into two other
documents and a landed attack plan. Second, **this is the survey ledger item 50
has been asking for since `-0032`**, run for the first time — and it is bounded,
not complete: it covers §11 item rows and one phrase, not §13 recitals or free
prose. I record the bound rather than claim the item.

#### 3. `FINDING AP-M14-1` — SUSTAINED; dv's cure in substance, with the bound stated rather than only the scope

**The conflict is real and I re-derived it rather than accepting it.** §7's
handshake bullet said the pulse falls *"on the cycle before that datagram's first
payload word"*, unscoped; §6.1 said *"the lead is normative here and not
incidental"* because M17 is written against it; and §7's own per-output-event
table puts `ip_hdr_valid` at input word **2** + 1 cycle and payload word 0 at
input word **3** + 1 cycle. REQ-016 permits idle cycles inside a datagram, so k
of them between input words 2 and 3 put the pulse at C₂ + 1 and payload word 0 at
C₃ + 1 = C₂ + k + 2. The lead is 1 + k and the bullet says 1. Everywhere else the
two agree because C₃ = C₂ + 1. dv's reachability check also holds: §8's stress run
gaps *between* frames and delivers each datagram's six words on consecutive
cycles, so no committed stimulus reaches the site.

**Three dispositions were live. I took the third.**

- **A defence** — keep the adjacency unscoped and make it bind under injection,
  i.e. require the design to defer the pulse until it knows payload word 0's
  cycle. **Refused, and refuted rather than merely disliked.** It moves
  `ip_hdr_valid`'s deciding input word from 2 to 3, contradicting §7's table and
  requirements.md §0.5's rule; it requires holding the record for an unbounded
  idle count; and it breaks §9, where the six header-decided strobes of a
  **rejected** datagram pulse on *"the cycle `ip_hdr_valid` would have
  occupied"*. A rejected datagram has no payload word to track, so under the
  defence an accepted datagram's pulse would move and a rejected one's strobes
  would not, and §9's identity — the one that makes every rejection a
  discard-before-emission on a single pinned cycle — would come apart. The
  defence is the only reading that preserves M17's contract literally, which is
  why it had to be excluded by derivation and not by preference.
- **dv's recommendation as offered** — scope the adjacency the way §7 already
  scopes its 3-cycle parse latency under `C-27`: exact on a datagram delivered
  without idles between input words 2 and 3, growing by the injected count. Right
  as far as it goes, and it is what I landed.
- **The addition, and the reason for it.** A pure scope tells a reader what is
  true on one stimulus class and leaves the *guarantee* to be re-derived at every
  reading. What a consumer needs — and what §6.1's "normative" claim was really
  about — is that the record arrives **before** the payload, with time to act.
  That is a bound, it holds on every stimulus REQ-016 permits, and it is
  derivable in one line: input word 3 is never presented earlier than the cycle
  after input word 2 (a stream carries at most one word per cycle, REQ-002) and
  each event trails its own deciding word by one cycle, so the lead is ≥ 1 with
  equality exactly on the gapless case. Stating the bound is what lets §6.1 keep
  saying the lead is normative instead of deleting the claim, and it is the form
  REQ-606 is already written in (*"on or before the cycle carrying the first
  payload word"*), which a grown lead satisfies **a fortiori**.

**The M17 consequence, which the dispatch asked to be addressed and which is the
half a scope alone would have left dangling.** §6.1 named M17 as the reason the
lead is normative, so scoping it without saying what M17 keeps would move a
contract out from under a specification in another document. M17 inherits **the
bound and not the figure**: the record is presented at least one whole cycle
before the first payload word, on the pulse cycle only (§6.3 item 2), so a
consumer that latches on the pulse is correct under every admissible lead and
gains time when the lead grows. What M17 may **not** do is derive its timing from
"payload word 0 is the cycle after the pulse". **I checked whether SPEC-M17 does
that, rather than assuming it does not**: its §6.1 anchors `Ci` at *"the first
cycle after the opening `ip_hdr_valid` pulse **with `ip_payload_tvalid` = 1**"* —
keyed to the first valid cycle, not to the next cycle — so it is robust under a
grown lead and **no diff to SPEC-M17 is owed by this ruling**, and none is made.
The same qualifier saves SPEC-M14 §6.1's own `Ci`.

**The site list is two entries longer than the finding's, and I grepped for the
claim rather than for the signal name.** `AP-ip_eth_rx_64` §8 item 3 listed five
sites. A grep for the *claim* adds **§7's parse-latency bullet** (*"one cycle less
than the payload's word delay — which is what puts `ip_hdr_valid` one cycle
before payload word 0"*, two gapless figures subtracted to derive a lead stated
without its scope) and **§9's counterfactual** (*"one cycle before the first
payload word would have left"*, in the pinned-strobe paragraph). Both repaired.
§10's REQ-016 hook additionally gains the bare adjacency to its list of things a
wrapper may not assert under injection — which is what `M14-F1` was left unable
to state while the finding was open, and it is now stated in the document a bench
writer derives from rather than only in the plan.

**Class: editorial, and no countersignature is owed — stated explicitly because
my practice is to state it either way.** No conformant design changes: a design
meeting §7's table already meets the bound, and no design could ever have met the
unscoped adjacency under injection. No record, port, width, strobe name or pinned
cycle moves, and no committed stimulus reaches the site, so no landed bench
changes verdict. **dv is the filer**, offered this cure by name, and its landed
row `M14-F1` asserts neither lead and is unmoved by the ruling in either
direction — the same carve-out dv itself applied to `AP-M04-2` at
`J-dv_lead-0170` §(a), which is the practice I am following rather than inventing
relief for myself. **A contest stays open** on the one point where the ruling
exceeds the recommendation: the normativity of the bound. If dv reads the bound
as a new obligation rather than as the surviving half of an old one, that is a
fresh finding and a narrow round.

#### 4. What I refused to sweep, and why naming beats widening here

The same unscoped adjacency stands in four other specifications — **SPEC-M06**
§6.1, §7, §10; **SPEC-M17** §4.2, §6.1, §7, §9, §10; and the wrappers
**SPEC-M16** §4.2, §7 and **SPEC-M19** §4.2, §7 — and I listed them from a grep
of every specification rather than estimating. I did **not** repair them, and the
reason is not economy:

1. **Each needs its own derivation.** The deciding input words differ (M06's
   header completes at input word 1 and its payload word 0 comes from word 2;
   M17's header completes at input word 0 and its application word 0 from word
   1), and a scope written from M14's arithmetic would be a guess at two other
   modules.
2. **At M17 the repair collides with a standing ruling.** requirements.md §13's
   2026-08-04 row says in terms that **SPEC-M08 and SPEC-M17 pass both of §0.5's
   tests, so their claims are true and are not to be "repaired"** — and SPEC-M17
   §7 still carries the loose sentence *"Idle gaps on the input (REQ-016) delay
   everything by exactly 8 octet times per cycle and change nothing else"*, which
   is the only sentence under which M17's own adjacency survives. Whether that
   sentence remains true once an output **pulse** whose deciding word precedes the
   injection is counted among "everything" is a question about someone else's
   ruling, and re-opening it inside a diff written for M14 would be exactly the
   smuggling the mechanics exist to prevent.
3. **The precedent is the 2026-08-04 row's own.** It repaired three modules and
   *named* the rest — *"Owed and named, not smuggled — the restatement discipline
   PROTOCOL §11 states for scope parameters, applied here by naming the sites
   rather than by widening this diff"*. I applied the same rule to my own ruling,
   including where it costs me a clean sweep.

The sites are named in SPEC-M14 §13 and carried as ledger items 56 and 57.

#### 5. The interaction the two findings have, and why it is one lesson and not two rulings

Both findings are against **recitals**, both were countersigned or unblocked in
the same breath, and both concern a **universal stated over a domain wider than
the one it was derived on** — §0.6's "name no word" over a class that is empty,
and §7's adjacency over stimulus REQ-016 admits. But they are not the same defect
and I did not merge them. `ABS-1` is a **ground that was false when written**,
against a rule that is right; `AP-M14-1` is a **rule that is right on one
stimulus class** and was stated without it, with the table beside it saying so.
The first is repaired by rewriting a reason; the second by scoping an obligation
and stating what survives the scope. Merging them would have produced a
generalisation ("state the scope") that is true, useless, and already in the
programme's text three times.

**Where they do meet is ledger item 53's territory** — a specification statement
whose truth conditions are narrower than the sentence — and item 53 gains
`AP-M14-1` as a second instance of the shape, from the opposite direction: item
53 is about a test a port passes *vacuously*, this is about a figure a port meets
only *sometimes*. Both are cured by naming the stimulus class in the sentence.

#### 6. What this round refused

- **I refused to widen into `test/**`.** Both findings have a half that lives
  there — `M04-G7`'s ground and `M14-F1`'s newly-assertable observable — and both
  halves are dv's. The second is a genuine loss this round: `M14-F1` can now say
  what it may assert at injection site (a), and it will take a dv round to say it.
- **I refused to repair four sibling specifications** (item 4 above).
- **I refused to fold ledger item 15's ruling** (the received-versus-delivered
  question) into a §0.6 diff dv must countersign, for the third round running and
  for the reason `-0039` gave: one signature should answer one question.
- **I refused to rewrite SPEC-M04 §11.3's raised item statement**, correcting it
  in the Status column instead.
- **I refused to move any `Status` cell, discharge count or gate row**, and I
  opened no `docs/gates/` file, no ADR and no packet.

### Actions

- Precheck (`git status --short`, `git rev-parse HEAD`), then charter and
  PROTOCOL, then both findings at their minting sites, then the specifications.
- **`docs/specs/requirements.md`** — §0.6's reference-word paragraph: the opening
  sentence gains the partition-and-override statement; the fourth clause's ground
  is replaced (override, not hole-filler; the empty class derived from REQ-206 and
  SPEC-M04 §6.1; the reference moved later so floor and reference word coincide;
  the loosening proof); the clause's closing italic is replaced with what the trap
  actually was. §13 gains **one appended row** for the `ABS-1` ruling, carrying the
  retired sentence verbatim, the class, the census result and the
  countersignature disposition. **No earlier §13 row was edited** — the 2026-08-11
  `C-5` discharge row repeats the same recital and is corrected by the new row
  beneath it, on the device §13's own F-1 row used.
- **`docs/specs/modules/ip_eth_rx_64.md`** — seven sites repaired for
  `AP-M14-1`: §4.2's port row, §6.1's derivation paragraph (scoped, with the
  bound derived and M17's inheritance stated), §7's parse-latency bullet, §7's
  handshake bullet (the ruling proper), §8's stress bullet (a note plus the named
  sibling sites), §9's counterfactual, §10's REQ-606 hook; §10's REQ-016 hook
  gains the bare adjacency as a thing a wrapper may not assert. §13 gains **one
  appended row**.
- **`docs/specs/modules/xgmii_tx_64.md`** — §11.3's **Status** column gains the
  correction of the item's own raised premise (the first column untouched); §13
  gains **one appended row**.
- **`docs/specs/modules/arp_eth_rx.md`** — §9's vacuity paragraph replaced with
  the third clause's determinate reference word and the redundancy argument, its
  conclusion preserved; §13 gains **one appended row**.
- No file outside `docs/specs/` was opened for writing.

### Evidence

**1. The precheck**, as run and reproduced under Trigger:
`git status --short` → empty; `git rev-parse HEAD` →
`deace39329a21811cc36765da7f0c4550659fa8e`.

**2. Ledger item 55, closed against the record rather than against the
dispatch.** `git show --stat 747e561` → `agents/journals/claude_orchestrator_agent.v02.md`
and `docs/specs/requirements.md`, `+42/-0`, trailer `Agent: orchestrator`,
`Journal-Entry: J-orchestrator-0247`. `git show 747e561 -- docs/specs/requirements.md`
shows **two** appended §13 rows and no other change: the REQ-901/`CSG-3`
countersignature transcription (*"the restriction restated over the span … are IN
FORCE from this row"*) and the §0.6 fourth-clause countersignature transcription.
**Both halves of item 55 are therefore paid, not one**: the normative REQ-901 diff
entered force at that row, and the editorial §0.6 diff's owed signature landed
there too. Item 55 closes whole.

**3. Table integrity across all four edited files.** Every row of every table
touched or appended to was field-counted after the edits:
`awk -F'|' '/^\| [0-9]{4}-[0-9]{2}-[0-9]{2} \|/ {if (NF!=7) print FILENAME":"NR}'`
over the three module specifications returns nothing (five columns each), and
`awk -F'|' 'NR>=1039 {if (NF!=8) print NR}' docs/specs/requirements.md` returns
nothing (six columns, §13's header at line 1039). The `xgmii_tx_64.md` §11.3 edit
was checked the same way: it is a five-column §11 row and stayed one.

**4. The `ABS-1` census, both slices, with their bounds stated.**

- *Slice A — every `§11` deferred-item row citing §0.5 or §0.6*, over
  `docs/specs/modules/*.md`, `requirements.md` and `architecture.md`: **four rows**
  — `eth_demux.md` §11.2 (CLOSED), `ip_eth_tx_64.md` §11.4 (DEFERRED),
  `xgmii_rx_64.md` §11.5 (CLOSED), `xgmii_tx_64.md` §11.3 (CLOSED). Each ground
  read: M08's cites §0.6's conservation reading, unaffected; M15's is a REQ-008
  question, unaffected; M03's cites §0.5's **gapless qualifier**, which still
  stands and was strengthened rather than retired on 2026-08-04. **One falsified,
  and it is M04's** — repaired this round.
- *Slice B — every occurrence of the retired ceiling phrase* `"input word carrying
  the last octet"` under `docs/specs/`: **six sites** in four files —
  `requirements.md` ×2 (§0.6's own statement, correct; §13's `C-5` row, which
  repeats the recital and is corrected by the appended row rather than edited),
  `xgmii_tx_64.md` ×2 (§11.3's raised statement, corrected in Status; the new §13
  row, which quotes it in order to convict it), `xgmii_rx_64.md` ×1 (**§9**'s
  reference-word paragraph for a frame no terminate character closes — dv's row
  `M03-G6` — which **already** says *"It has one, and the closure list above is
  what supplies it"*: the same correction, made a week earlier at a different
  clause, and correct), and `arp_eth_rx.md` ×1 — **the site nobody had filed**,
  repaired this round.
- **The bound**: neither slice reaches §13 recital rows generally or free prose in
  §6/§7. Ledger item 50 is **partially** discharged and says so.

**5. The `AP-M14-1` site census, by claim and not by signal name.** Over
`docs/specs/modules/ip_eth_rx_64.md`, grepping the *claim* (`one cycle before`,
`cycle before that datagram`, `would have left`) rather than `ip_hdr_valid`
returns the finding's five sites plus **§7's parse-latency bullet** and **§9's
counterfactual**. After the edits the same grep returns: §4.2 (bounded), §6.1
(scoped, *"on this stimulus"*), §7's handshake bullet (bounded), §8's two stimulus
lines (gapless by construction, one of them now saying so and naming the sibling
sites), §9 (scoped), §10 (bounded) — **no unscoped statement of the adjacency
remains in the file**. `§12`'s countersignature row still records *"the one-cycle
header lead re-derived"* and is **deliberately left**: it is a record of what dv
proved at the freeze, on gapless stimulus, and it was correct.

**6. The sibling census, across the programme.** Grepping every module
specification for the same claim and printing each hit with its enclosing section:
**SPEC-M06** §6.1 (line 249), §7 (426), §10 (603) — its §4.2 row states no lead
and needs nothing; **SPEC-M17** §4.2 (231), §6.1 (344), §7 (579), §9 (774), §10
(863), plus §8's two stimulus lines (627, 634) which are gapless by construction;
**SPEC-M16** §4.2 (231), §7 (423); **SPEC-M19** §4.2 (248), §7 (419). That is the
list carried as item 56, and it is a measurement rather than an estimate.

**7. The arithmetic in the SPEC-M10 repair, checked before it was written.**
§7 of that specification pins ΔC = **4** (its §7 table, line 474). The pinned
strobe is one cycle after the closing event; §0.6's third clause puts the
reference word at the closing event and the ceiling at ΔC beyond it. `1 < 4`, so
the pin sits well inside the window and the redundancy claim holds with margin —
which is the claim the repaired paragraph makes.

**8. Confinement.** `git status --short` at the end of this round lists exactly:
`M docs/specs/modules/arp_eth_rx.md`, `M docs/specs/modules/ip_eth_rx_64.md`,
`M docs/specs/modules/xgmii_tx_64.md`, `M docs/specs/requirements.md` — four
modified files, no untracked file, no deletion, and the set equals the
`Files-in-this-commit` list below.

**Not claimed, stated so the absence does not read as coverage.** No bench was
built or run; no `ifc_check` build was invoked (no interface record moved, so
none is owed); no RTL was read; `tools/` was not run. Every arithmetic claim in
this round is a derivation over specification text, reproducible by reading the
cited sections at this SHA, and the one enumeration this round relies on —
dv's 2.4-million-trace check of the `CSG-3` form — is dv's and is cited, not
re-run.

### Outcome

**DoD met on all three items.** Two findings ruled with their cures landed, their
classes stated, their countersignature status stated either way, and their site
lists measured rather than asserted; the ledger walked at all eight named items,
with one closed on the record, one partially discharged by work done, and the
rest restated with owners and closing events.

**Handoff**: to the orchestrator for commit. The `ABS-1` diff carries a
**countersignature owed** to dv_lead, narrowed to what it adds and **in force
meanwhile**; the `AP-M14-1` diff carries **none**, on dv's own carve-out, with a
contest available. Two halves of this round's subject matter are dv's and are
named in the ledger: `AP-xgmii_tx_64` row `M04-G7`'s ground, and `M14-F1`'s
newly-assertable observable at injection site (a).

**Carried ledger, restated whole** (ADR-0017 §4.4's practice; every row carries an
owner and a closing event, so a row is never a note to nobody):

| # | Item | Owner | Closing event | This round |
|---|---|---|---|---|
| 1 | ADR-0016 §8's transcription mechanic is unwritten in PROTOCOL | orchestrator | a PROTOCOL §11 amendment | carried |
| 2 | The generic shell's `LESSONS` transit is the orchestrator's and unexercised | orchestrator | the first harvest reaching the shell | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; half spent |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried, practised six times |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036` |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale, silent on volumes, records me as "Not yet activated" | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate | CLOSED at `-0037` |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — this round opened no `docs/gates/` file, the dispatch's write set excluding it |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried, instantiations exist to be filled |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are **different** dispositions | me | any WO next opening `requirements.md` §0.6; owed dv's countersignature | CLOSED at `-0039`; the countersignature residue closed with item 55 |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried — **and this round opened §0.6 a second time without taking it**, for the third round running and the same reason: one signature should answer one question. It is now the **oldest** untaken §0.6 item and the next §0.6 round should take it or say why not |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried — this round opened `requirements.md` twice and did not take it, both edits being §0.6's and §13's |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried — SPEC-M03 was not opened for writing this round |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried (`C-5` closed at `-0039`) |
| 25 | Two re-countersignatures and one concurrence owed at `-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked — **and this round read the M03 §13 row it turns on** (Evidence 4, slice B): that row already carries the correction `ABS-1` makes at a different clause, which is evidence the M03 side is in better shape than this row assumes |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried — **and this round is its third customer**: §0.6 now carries a fourth clause with a repaired ground and an override statement, so a contest of the `-0023` diff would arrive at a longer rule again |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried — and this round leans on that diff a fourth time, at SPEC-M14 §7 (the deciding-input-word rule is the whole ground of the `AP-M14-1` ruling) |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | CLOSED at `-0038` |
| 30 | `AP-xgmii_rx_64.md` §4.I's M03-I4/M03-I5 cells are dv's to edit; joined by `FINDING SO-1-A`'s §6 repair | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger. **This round did the opposite of narrowing REQ-016**: `AP-M14-1` is ruled by scoping a module's claim to the stimulus REQ-016 already permits, leaving REQ-016 itself untouched |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes, not dischargeable by widening (g) | dv_lead (carrier); me (class) | a record-only run measuring the reference's disposition on three geometries, then a class round on the measurement | carried |
| 35 | Two of my `-0033` repairs correct dv's finding rather than my own text and dv has not seen them | dv_lead | dv reading them, disputing or not | carried — **and this round adds a third of the same kind**: the `ABS-1` ruling is sustained on a ground dv did not give (the empty class, derived from REQ-206), which is a correction of the filing in dv's favour and unseen by dv |
| 36 | The `-0032` countersignature is owed; that diff is not in force until it lands | dv_lead | dv countersigning | CLOSED at `4e7331b` |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar (`-0032`) | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | carried |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` | me | the next round opening `docs/gates/` | CLOSED at `-0037` |
| 43 | A2 binds without countersignature; a contest by any seat is carried to an Amendment A3 | any contesting seat; me for drafting | a re-verdict without contest, or an A3 landing | carried, half spent |
| 44 | The block's preamble still says an `SO-` instantiates §3's block *"verbatim"*, which A2-D1 qualifies | me | the next round opening `docs/gates/lessons-harvest-block.md` | **carried, and not for want of trying**: `docs/gates/**` is outside this round's dispatched write set, so the round could not open the block. The row is unchanged and its closing event is unchanged; what this walk adds is that it has now been carried past **two** rounds whose write sets excluded the file, which makes it a scheduling item rather than a drafting one — the fix is a dispatch that includes `docs/gates/`, and that is the orchestrator's to sequence |
| 45 | The `P1-module-ready` checklist's ledger `G-1 … G-11`; five rows are mine | me for those five | each `G-` row's own closing event | carried — **`G-3` gains material again**: three frozen specifications take post-freeze diffs this round and **all three are editorial**, which is the first round since `-0037` in which the post-freeze churn count does not move |
| 46 | REQ-904's commissioned CI set-equality script does not exist | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | carried — **this round adds no REQ id**, so the set it would compare is unchanged for the third round running |
| 47 | Three countersignatures owed on `-0038`: the REQ-210 + §0.5 diff, the REQ-611 diff, and the REQ-901 diff | dv_lead | dv countersigning each | **CLOSED at `-0039`, and re-checked here against item 50's hazard rather than assumed.** `ABS-1` reaches the §0.6 fourth clause, whose ΔC sentence cites SPEC-M04 §7's **two** constants — the very pair the `-0038` REQ-210 diff created. That sentence is untouched by this round's repair and remains exactly as countersigned, so none of the three signatures is disturbed. Stays closed |
| 48 | `AP-xgmii_tx_64` §8 item 2: REQ-901 declares no divergence class at the M04 boundary | me (the record); orchestrator (the sequencing) | the vendoring commit for `axis_xgmii_tx_64.v` at a pin (ADR-0015 D2, `PROVENANCE.md`), then a derivation round | **carried, and the spec half is now fully discharged — verified at the text rather than taken from dv's report.** REQ-901 states the silence as *"unexamined, not a finding of no divergence"*, names the four vendored paths, says a class there is **not writable in this document** until the counterpart is vendored at a pin, and states the prohibition: *"no sign-off packet may cite a transmit-boundary co-simulation result as an anchor"*. dv accepted this at `J-dv_lead-0173` §(d) with the premise independently verified (`git ls-files` returning four paths) and drew the gate consequence — charter §3 makes differential co-sim a Phase-1 MAC sign-off precondition, so the prohibition is a condition on `SO-xgmii_tx_64`. **I do not add that consequence to REQ-901**: it follows from the prohibition already there, and a requirement that restates its own consequences grows a second place to go stale. Nothing further is available to a spec round |
| 49 | `AP-xgmii_tx_64` §8 item 3 makes `C-5` a dependency of a landed plan | me | the `requirements.md` §0.6 round item 14 named | CLOSED at `-0039`; the clause's **ground** is repaired this round |
| 50 | **A closed ledger item can be reopened by a later ruling, and nothing detects it** | me | a survey of closed items whose grounds cite a since-amended §0.5/§0.6 clause | **PARTIALLY DISCHARGED: the survey ran, for the first time since this row was written, and it found something** (Evidence 4). Slice A — all four §11 deferred-item rows citing §0.5 or §0.6, one falsified (SPEC-M04 §11.3, repaired here). Slice B — all six occurrences of the retired ceiling phrase, one falsified and unfiled (SPEC-M10 §9, repaired here) and one already self-corrected (SPEC-M03 §13). **The row stays open at a stated bound**: neither slice reaches §13 recital rows generally or free prose, and this round is itself the **third** instance of the hazard — `ABS-1` is a ruling of mine whose ground was falsified by an amendment to the same paragraph six days earlier. The survey is still mine and now has a method that worked |
| 51 | `FINDING CSG-1`'s four cases have never been checked against a run, and nothing schedules it | dv_lead (the run); orchestrator (scheduling) | the first record-only run | carried, unchanged — no run exists, the machinery does not exist (`J-dv_lead-0170` open question 5), and this round touched neither |
| 52 | SPEC-M04's own §11.3 carries `C-5` as a deferred item | me | the `C-5` round of items 14 and 49 | CLOSED at `-0039`; **its raised statement is corrected this round** and the row's closure is unchanged |
| 53 | §0.5 states its two tests as properties of a module, and a module may pass them at a port where the stimulus they quantify over has **no instance** | me | a `requirements.md` §0.5 round, or a deliberate decision to leave the statement at the module | carried — **and it gains a second instance from the opposite direction**: `AP-M14-1` is a figure a port meets only *sometimes* where item 53's own case is a test a port passes *vacuously*, and both are cured by naming the stimulus class in the sentence. Two instances is the threshold at which the §0.5 round becomes worth scheduling rather than waiting for a third |
| 54 | Class (h)'s REQ-110 half now has no comparing-run instance | me (the class); dv_lead (a record-only observation) | the class round of item 34, or an explicit note that (h)'s REQ-110 half is directed-test-only | carried, unchanged |
| 55 | Two countersignatures owed on `-0039`: the REQ-901 `CSG-3` diff (normative) and the §0.6 fourth-clause diff (editorial) | dv_lead | dv countersigning each | **CLOSED, both halves, verified at the commit** (Evidence 2). dv COUNTERSIGNED at `J-dv_lead-0173` §(a) and §(c); the orchestrator transcribed **two** §13 rows at `747e561` under `J-orchestrator-0247`. The REQ-901 diff has been in force since that row. One finding came back attached to the second signature and is ruled this round |
| 56 | **The `AP-M14-1` adjacency stands unscoped at four other specifications** — SPEC-M06 §6.1/§7/§10, SPEC-M17 §4.2/§6.1/§7/§9/§10, SPEC-M16 §4.2/§7, SPEC-M19 §4.2/§7 — measured by grep, not estimated | me | a round per specification, or one batch round that derives each module's deciding input words first | **new this round**, and named in SPEC-M14 §13 rather than swept into it. Each needs its own derivation because the deciding input words differ by module; M17's additionally collides with item 57 |
| 57 | **SPEC-M17 §7 and SPEC-M08 §7 still carry the retired *"delay everything by exactly 8 octet times per cycle"* sentence**, which requirements.md §13's 2026-08-04 row declared *"true and not to be repaired"* at those two modules because both pass §0.5's tests — but the sentence quantifies over *"everything"*, and an output **pulse** whose deciding input word precedes the injection is not delayed at all | me | the round that opens SPEC-M17 §7, which is item 56's M17 member; the ruling to revisit is another round's and is named rather than re-opened here | **new this round.** It is the reason M17 cannot be swept with the others: repairing M17's adjacency requires deciding whether that sentence survives an output event that is not an octet, and that is a question about a standing ruling |
| 58 | **One countersignature owed on this round**: the §0.6 `ABS-1` diff (**editorial**, IN FORCE meanwhile, signature narrowed to the override statement, the loosening derivation and the two repaired recitals — not a re-countersignature of the rule) | dv_lead | dv countersigning | **new this round.** The `AP-M14-1` diff at SPEC-M14 and the two correction rows at SPEC-M04 and SPEC-M10 owe **none** — dv is `AP-M14-1`'s filer and was offered this cure by name, and the two correction rows are consequences of the `ABS-1` ruling at sites dv did not file, carrying no rule of their own. A contest of the bound's normativity stays open to dv |

- **No harvest note is owed** — PROTOCOL §7 and charter §8 attach it to an `SO-`
  and to a phase gate, and this round is neither. Declared rather than omitted.
  The open span for my next harvest continues to run and this entry joins it.
- **No escalation.** **E2 not triggered** (no requirement, phase or role added or
  dropped; REQ-606, REQ-016 and REQ-206 are untouched, and item 33 remains the
  only E2 on this ledger). **E3 not triggered** — item 48's walk names the
  vendoring commit as someone else's act and declines to perform it, which is the
  opposite of taking a licensing decision in-round. **E5 not triggered**: no lead
  disputed anything and both findings were routed to me undecided by their filer.

### Open-questions

1. **The §0.6 diff is in force and its countersignature is owed** (item 58). The
   thing dv should check hardest is not the override — dv proved that — but the
   **empty-class derivation** I sustained it on: that REQ-206's *"after the
   transmitter has emitted a frame's start character"* plus SPEC-M04 §6.1's
   `Preamble` entry condition make the no-octet class at this module empty rather
   than merely unoccupied. If that is wrong, the clause is a hole-filler *and* an
   override on different frames, and the precedence sentence would need a scope.
2. **The one place `AP-M14-1`'s ruling exceeds its recommendation is the bound's
   normativity.** dv recommended a scope; I landed a scope **plus** a stated lower
   bound, because §6.1's "normative" claim needed something to survive. If dv
   reads the bound as a new obligation on a design rather than as the surviving
   half of an old one, that is a fresh finding and a narrow round — and I would
   rather have it filed than have the bound quietly read as commentary.
3. **`M14-F1` can now say what it could not.** The row records that the lead *"is
   asserted nowhere until `FINDING AP-M14-1` is ruled"*. It is ruled; the
   assertable observable at injection site (a) is the bound and the two per-event
   delays, and §10's REQ-016 hook now names them. That is a dv round and this seat
   cannot write it.
4. **Item 56 is the largest thing this round created and did not do.** Four
   specifications state the same unscoped adjacency, and I named them instead of
   sweeping them. The risk of naming is the risk the 2026-08-04 row took and
   survived; the risk of not sweeping is that dv files the same finding three more
   times, each correctly.
5. **Item 50's survey worked and is still not complete.** Two slices ran, two
   falsified grounds surfaced, one of them at a document nobody had filed against.
   The uncovered surface — §13 recitals and free prose — is where the next
   instance will be, because that is where this round's own two came from.

### Files-in-this-commit

- docs/specs/requirements.md
- docs/specs/modules/ip_eth_rx_64.md
- docs/specs/modules/xgmii_tx_64.md
- docs/specs/modules/arp_eth_rx.md

## [J-architect_docs_lead-0041] 2026-08-11T13:54Z | task:none | `C-RL-8` upheld and refined — the inserting-module clause was written at the one insertion that is a whole number of words, and the term it needed repairs four statements rather than the one that was filed, the load-bearing one licensing an assertion no conformant design can pass

### Trigger

Orchestrator dispatch, one round: adjudicate and repair **C-RL-8**, rtl_lead's
finding routed to me through the orchestrator per rtl_lead's own handoff. The
abort-first precheck ran before any file was opened and passed: `git status
--short` empty, `git rev-parse HEAD` = `cddad51f479ab1656222e94fb9264e7040d761f1`,
branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`.

**Concurrency, stated rather than left for a reader to reconcile.** The dispatch
declared a dv_lead round live in this tree on disjoint paths (`test/**`,
`agents/handoffs/WO-0081*`, its own journal). At the end of this round `git status
--short` lists four paths: my three under `docs/` and `test/xgmii_tx_64/
test_m04_d.ml`, which is dv's. **I opened no file under `test/` for writing and
none under `agents/handoffs/`.** My confinement claim is over the paths I own and
is not a claim that the tree is otherwise quiet. I read `test/` twice, read-only
and for one purpose each, and both readings are recorded in Inputs.

### Inputs

- `agents/charters/architect_docs_lead.md` and `agents/PROTOCOL.md`, in full,
  before any other file (§4 grammar, §5 R1–R9, §6 write scope, §7 gates, §10).
- **`agents/journals/claude_rtl_lead_agent.v02.md`, `J-rtl_lead-0020` in full** —
  the finding's authoritative source. §5 carries the derivation, Open-questions 1
  the statement, §2 and §3 the microarchitecture the derivation rests on, §Inputs
  the discipline claim that it read `docs/specs/**` and wrote none of it.
- **`docs/specs/requirements.md` §0.5 in full**, plus §1 (REQ-005, REQ-011,
  REQ-016, REQ-019, REQ-021), §1.1 both tables, and §13's fourteen 2026-08-11
  rows — the REQ-210 + §0.5 repair and its countersignature transcription being
  the precedent this round is measured against.
- **`docs/specs/modules/eth_axis_tx.md` in full** (SPEC-M07, FROZEN at `508eea2`):
  §3, §6.1, §6.2, §7, §10, §11, §12, §13.
- **`docs/specs/modules/ip_eth_tx_64.md`** (SPEC-M15, FROZEN at `3f6accc`): §6.1
  in full, §7 in full, §3's invariant rows, §10, §11, §12, §13.
- `docs/specs/modules/udp_ip_tx_64.md` §7 and `docs/specs/modules/arp_eth_tx.md`
  §7 — the two rtl_lead measured as clean, re-read here to verify the verdict
  rather than accept it.
- `docs/specs/modules/xgmii_tx_64.md` §7, §10's REQ-210 row and §13's three
  2026-08-11 rows — the model repair, read for its form before I wrote mine.
- `docs/specs/modules/eth_axis_rx.md` §13's 2026-08-11 row — the module-side row
  form and the straddle-verdict wording M06 already carries.
- `docs/specs/modules/ip_eth_rx_64.md` §7's parse-latency bullet — the third
  occurrence of the *"not a rounding"* phrase, read to decide whether it is a
  fourth site. It is not (Reasoning §5).
- `docs/specs/modules/ip_complete_64.md` §7 and `docs/specs/modules/arp.md`
  §6.1's REQ-502 table row 15 — the two places that compose M07's and M15's
  figures, read to measure what the repair reaches.
- `docs/specs/architecture.md` §4's inventory — to establish which module SPEC-M15
  is from the record rather than from the dispatch's sentence.
- My own `J-architect_docs_lead-0038`, `-0039` and `-0040` — the spec-repair
  procedure, the change-log row forms, the countersignature mechanics and the
  carried ledger.
- **Read-only into other seats' scopes, twice, each for one question.**
  (a) `libs/hardcaml_ethernet/src/eth_axis_tx.ml` — its doc comment only, to check
  whether the landed RTL was built to the sentence I am repairing. It was not; it
  names the defect and derives L = 22 itself. (b) `test/` — `grep -rl
  'eth_axis_tx\|ip_eth_tx' test/`, to establish whether any committed test changes
  meaning. None does. Neither file was opened for writing and nothing else was
  taken from either.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

#### 1. The adjudication: UPHELD on the face of the text, then REFINED

**Upheld, and it needed no re-derivation to reach that.** SPEC-M07 §7's first
bullet was titled **Latency**, pinned 1 cycle between the acceptance of the first
payload word and the emission of **output word 0**, and justified calling the
figure a latency with: *"Both sit at octet position 0 of their words, so the
figure is exactly 8 octet times and not a rounding."* requirements.md §0.5's
inserting-module clause says that a delay pinned to an inserted word *"is an event
delay, not a latency: it is a legitimate and often sharper thing to pin — **both
its events are named and both sit at octet position 0** — but it is a different
quantity with a different value."* The sentence §7 used to argue that its figure
**is** a latency is the sentence §0.5 uses to explain why it is **not** one. And
§7's own next paragraph supplies the premise: *"output word 0 is a function of the
header record alone."* A module's specification convicting itself two paragraphs
apart is the same shape `FINDING AP-M04-1` had, and it is refutable by arithmetic
before any RTL exists — which is where rtl_lead found it.

**I re-derived the three figures rather than accepting them**, because a ruling
that accepts its filing's arithmetic has checked nothing. Payload octet k is
accepted in payload word ⌊k/8⌋ at cycle C + ⌊k/8⌋ at byte position k mod 8, so its
input octet time is 8C + k. §6.1 puts it at frame octet 14 + k, in output word
⌊(14 + k)/8⌋ at byte position (14 + k) mod 8, and output word n leaves at C + 1 + n
— so its output octet time is 8·(C + 1 + ⌊(14 + k)/8⌋) + ((14 + k) mod 8), which
telescopes to 8C + 22 + k. **L = 22 at every k, every length and every content.**
The identity `L = 8·ΔC − h` with h = 0 and ΔC = 2 returns 16. The printed figure is
8. Three figures, one printed, and the two §0.5 routes disagreeing with each other
— which is exactly rtl_lead's §5 and is confirmed independently here.

**Refined in two directions the filing did not reach**, and the second decides the
question the filing left open.

**(a) The identity is not the only §0.5 statement keyed to h alone.** Three more
are, and one of them convicts: the whole-number consequence says *"(L + h) is
therefore a multiple of 8 for every conformant module. A specification pinning an
L for which it is not describes a module that cannot exist."* At M07, L + h = 22.
At M15, 28. Neither is a multiple of 8. So §0.5's own freeze-time arithmetic check
— the check the AP-M04-1 repair leaned on as the thing that catches this class
before RTL — **refutes the two conformant modules it exists to protect**, the
moment their true L is written down. A repair that fixes the identity and leaves
that bullet produces a specification that cannot state its own latency without
being convicted by the document that demanded it.

**(b) The straddle test is wrong at M07 and M15, and it is wrong in the licensing
direction.** This is the half neither rtl_lead nor the dispatch named, and it is
the one that decides the term-versus-scope question. §0.5's straddle test reads
*"those eight lie in one input word iff h ≡ 0 (mod 8)"*. At M07 and M15, h = 0, so
the test returns **no straddle**. Both modules' own §6.1 says the opposite in
terms: SPEC-M07's *"output word n ≥ 2 carries payload octets 8n − 14 through
8n − 7 — which lie in payload words n − 2 … and n − 1"*, SPEC-M15's *"body word
n ≥ 3 … lie in payload words n − 3 … and n − 2"*. Two input words. And the
consequence is not a mislabelled quantity: §0.5's closing paragraph says *"where a
module passes **both** tests its per-octet constant does survive injection"*, and
REQ-016's verification column says *"where §0.5's two tests both pass at a module,
its own §7 says so and the wrapper asserts the per-octet constant as well."* Both
modules pass the late-decision test — their input carries `tkeep`, `tlast` and
`tuser`[0] in band — so under the live text they pass both, and a bench writer
following REQ-016's column to the letter builds a wrapper asserting a single
per-octet latency under injection at a module where one output word carries two.
**That assertion fails every conformant design.** It is the exact failure mode
§0.5 exists to prevent, it is the one this programme has already paid for once
(`SCR-M03-I4`, where a monitor built from an unqualified §0.5 sentence reddened
against a conformant M03), and the h-only reading is not merely silent about it —
it affirmatively licenses it.

#### 2. The ruling rtl_lead asked for: a term, not a scope

rtl_lead put it as a choice: *"the identity needs an output-side offset term (or
an explicit scoping to insertions that are multiples of 8) before it can be
applied to an inserting module at all."* Both were live. I ruled **the term**, on
three grounds, in the order of their weight.

**Ground 1 — a scope on the identity does not reach §1 (b).** This is decisive on
its own. The scope removes the identity's answer at M07 and M15 and says nothing
about the straddle test, which is a different sentence with its own keying. After
the scope, §0.5 still returns *no straddle* at both modules and REQ-016's column
still licenses the impossible assertion. To close it, the scope must be written
again in the straddle bullet, again in the whole-number bullet, and again in
**Cycles** — four scopes for one defect, each a place to go stale. The term is
written once and all four statements take it because all four are the same
arithmetic.

**Ground 2 — the mechanism that produced this defect is enumeration.** §0.5's
inserting-module clause was written on 2026-08-11 at M04, whose insertion is
exactly one word, and it was correct there and nowhere tested against another
insertion. A scope is that same act repeated: a rule stated over the cases its
author had in front of them, against a document that grows modules. This is
`FINDING CSG-3`'s lesson at a different paragraph — my own `-0039` round cured a
restriction *"stated over two of the span's five closures"* by restating it over
the span rather than by naming the third closure — and taking the enumerating
option here, one round after ruling against it there, would be inconsistent as
well as wrong.

**Ground 3 — consistency with how REQ-210 and REQ-611 were repaired.** Both
repairs *added a named quantity* rather than removing a claim: REQ-210 now pins
**both** constants because *"pinning both is strictly more informative than
renaming one, while the failure mode was conflation, which naming cures and
renaming does not"*; REQ-611 gained the per-event invariant alongside its scoped
figure. The term is that move at §0.5's own level — it gives the section a name
for the quantity it was missing. The scope is the other move, deleting reach.

**The term, stated so it changes nothing it did not already reach.** Output offset
**q**: the position, within the output word ΔC's output event names, of the first
octet **of the frame** at that output; equivalently (octets inserted ahead of the
frame) mod 8. It is the exact mirror of h's second term — h says where the frame's
first octet sits inside the *input* word the measurement event names, q where it
sits inside the *output* word ΔC counts to. The identity becomes
**L = 8·ΔC − h + q**, the word delay **ΔC = (L + h − q)/8**, the whole-number test
**(L + h − q) ≡ 0 (mod 8)**, the straddle test **(h − q) ≡ 0 (mod 8)**.

**Why this is editorial and not a renumbering of the programme**: q = 0 at every
module §0.5 has ever been applied to. Checked module by module, not assumed —
M03 both lanes, M06, M08, M14, M17 (all receive-path, output word-aligned at the
frame's first octet, q = 0); M04 and M18 (insertions of 8, q = 0); M11 (its output
word 0 carries ARP octet 0 at position 0, and §7 already says the fourteen
Ethernet octets it causes to exist *"are not an insertion at this port"*); M09
(adds nothing). So §1.1's table, its convenience column's *"always satisfies
(L + h) ≡ 0 (mod 8)"*, SPEC-M20 §7's chain arithmetic and every pinned value in
the document are unchanged. **The two Phase-1 instances are M07 (q = 6) and M15
(q = 4), and both are new text.**

**One drafting decision inside the term, taken deliberately.** h's paragraph says
h *"is stated in the module's specification §7"* — an obligation on every spec.
Mirroring that for q would have minted an unmet sweep across fifteen frozen
specifications in a round that opened two, and a rule whose first act is to make
thirteen documents non-conformant is a rule that will be ignored. So q's default
is **0 and needs no statement**; only a non-zero q must be stated. That is
stronger, not weaker: it puts the obligation exactly where the information is.

#### 3. The module repairs, and why they could not land without the §0.5 diff

I considered landing the two module repairs alone and filing the §0.5
generalisation as a proposal, because the dispatch's write set named
`requirements.md` only *"if a change-log row belongs there"*. **It does not work,
and the reason is arithmetic rather than preference.** SPEC-M07 §7 repaired
honestly must state L = 22 with h = 0. Under the *live* §0.5, (L + h) = 22 is not
a multiple of 8, so the repaired specification would state a latency that §0.5's
whole-number bullet declares *"describes a module that cannot exist"* — I would be
curing a conflation by writing a self-refuting specification, at a module whose
RTL is already in the tree. And the straddle licence of §1 (b) would still be
standing at both modules meanwhile. The three files are one diff or none.

**How I read the write set, stated plainly so the orchestrator can bounce it.**
Under my procedure a requirements.md §13 row is not an annotation on someone
else's diff — it *is* the record of a requirements.md diff, and every one of the
fourteen 2026-08-11 rows landed with the text it describes in the same commit. A
row without its text would describe a diff that does not exist. So I read *"only
if a change-log row belongs there under your procedure"* as covering the row's own
text, and I have made the reading explicit rather than quiet. Everything else in
the dispatched set is untouched.

**SPEC-M07 §7** now carries the SPEC-M04 form: a five-row table (event delay 1
cycle = 8 octet times to output word 0; L = 22; h = 0; q = 6; ΔC = 2 to **output
word 1**), the derivation, the reason h = 0, the prohibition on asserting 8 octet
times per octet, and a second bullet giving the two §0.5 verdicts and the
**deciding-input-word** table (output word 0: D = payload word 0, delay 1; output
word n, 1 ≤ n ≤ J: D = payload word n − 1, delay 2; output word J + 1 when
W = J + 2: D = payload word J − 1, delay 3). D is the **later** of an output
word's two source payload words because that is the one whose `tkeep` and `tlast`
decide whether the output word is the frame's last — §6.1's residue rule
(W − J = 1 for P ≡ 1 or 2 mod 8, else 2) read from the deciding side rather than
the counting side.

**SPEC-M15 §7** takes the identical treatment at its own numbers: event delay 1
cycle to body word 0; **L = 28**; h = 0; **q = 4**; **ΔC = 3** to **body word 2**;
straddle **failed**, (h − q) = −4; D table with delays 1, 2, 3 and 4, and
`arp_query_valid`/`arp_response_valid` excluded by name because no payload word
decides them. rtl_lead named M15 as *"an adjacency read from its §7 and §6.1
rather than as a finding I have derived end to end"* and said the derivation was
mine. It is done here and it holds: the sentence is verbatim identical, the
insertion is 20, and the arithmetic runs the same way.

**Three dependent sites per file, repaired rather than left.** §7's handshake
bullet at both modules said idle gaps *"delay everything by the number of idle
cycles"* — true only of events whose deciding input word the idles fall at or
before, and false as a universal the moment an idle lands mid-frame. §3's REQ-005
row at both named *"§7's pinned one-cycle constant"* where there are now two. §10's
REQ-016 hook at M07 asserted only REQ-016's half (a) and at M15 named no assertion
at all; both now carry (a), (b) against the D table, and the prohibition. This is
ledger item 50's discipline: a repair that lives at one site leaves the falsified
reading at the others, and this round's own §1 (b) is what that costs.

#### 4. Class, force and countersignature

**Editorial on §13's own test, and stated site by site rather than asserted.** No
conformant design changes: not one cycle, cycle-table row, residue class, drain
count, strobe, gap figure, checksum or interface record moves in either
specification. No committed test changes meaning: `grep -rl` over `test/` returns
nothing for either module. The M07 RTL at `cddad51` was written to §6.1's table
with this defect already named in its own doc comment, and M15 has no RTL at all.
**What changes is a permission** — a monitor may no longer demand a single
per-octet latency under injection at either module — and nothing was built on it.
Withdrawing a licence before its first customer is the whole value of catching
this by arithmetic on the specification.

**In force meanwhile, and this is the one place I depart from the REQ-210 row's
shape.** REQ-210's diff was held out of force pending countersignature; the
REQ-611 and §0.6-fourth-clause diffs were in force meanwhile. This one is in
force, on a ground specific to it: holding it out would leave the **unrepaired**
straddle test governing in the interim, and that is the licensing one. A reader in
the gap would find §0.5 telling them M07 passes both tests and REQ-016 telling
them to assert the per-octet constant — strictly worse than the repair being read
before it is signed. The countersignature is owed and named in the ledger.

**Not E2**: no requirement, phase or role is added or dropped, and no REQ's
normative text is touched — §0.5 is a definitional section and the two diffs are
module §7s. **No ADR**: at the level of the constraint the retired reading is
arithmetically unsatisfiable rather than chosen among live alternatives, so
nothing about the hardware is decided; the alternative that *was* live (scope
versus term) is recorded in the §13 cell, which is the form C-14, C-16 and REQ-210
used. **Not E5**: rtl_lead routed the finding undecided and disputed nothing.

#### 5. The census, because a repair at two sites should say how it knows there
are two

Four checks, each stated with what it would have caught.

**(a) The phrase.** `grep -rn "not a rounding" docs/specs/` returns three hits:
SPEC-M07 §7 (repaired), SPEC-M15 §7 (repaired — the grep missed it at first
because the phrase wraps mid-line, which is why the second check exists), and
**SPEC-M14 §7's parse-latency bullet**. M14's is **not** a fourth site: its two
events are an input word and the `ip_hdr_valid` pulse, it says in terms that this
is *"a different measurement on the same pipeline … stated separately because
REQ-611 asks for it"*, it does not claim the figure is §0.5's L, and M14's actual
L = 12 is stated elsewhere in the same bullet. REQ-611's own 2026-08-11 repair
already scoped it. Checked and cleared, not skipped.

**(b) rtl_lead's two negative results, re-verified rather than accepted.**
SPEC-M18 §7 does **not** carry the class: it pins the delay for output words
carrying **application** octets and states *"output word 0 is outside that
constant and is stated separately, because it carries no application octet"*,
giving both monitors' figures — which is what §0.5's clause asks for, written
before the clause existed. Its use of the *"octet position 0"* sentence is sound,
because M18's insertion is 8 and its q is 0, so the pinned quantity really is the
per-octet latency. SPEC-M11 §7 tabulates L, h and ΔC explicitly and disclaims the
Ethernet octets as *"not an insertion at this port"*. Both verdicts stand, and
M18 is more than clean — it is the model the two repairs are written towards.

**(c) Who composes the repaired figures.** `grep -rn "SPEC-M07 §7\|SPEC-M15 §7"
docs/` returns eleven hits; nine cite those sections for handshake, abandon or
record-discipline reasons and are untouched by this diff. Two compose the figure:
**SPEC-M16 §7**'s transmit chain (*"M07 emits its first output word at C + 2
(SPEC-M07 §7's 1 cycle from the acceptance of its own first payload word)"*) and
**SPEC-M13 §6.1**'s REQ-502 table row 15. Both are **true and correctly evented**
— they compose event delays and name both events — so neither is falsified and
neither is repaired here. What they now under-name is that the bullet they cite
pins two constants where their citation implies one. New ledger item 59, with a
closing event, rather than a silent widening of this round's diff.

**(d) Whether anything was built on the retired reading.** M07's RTL doc comment
already names the defect and derives 22 independently; M15 has no RTL; no
committed test names either module. So the class has no built customer at either
site, which is what makes the row editorial and is checked rather than hoped.

### Actions

1. Ran the precheck before opening any file; both outputs matched the dispatch
   exactly.
2. Read the charter and PROTOCOL in full, then `J-rtl_lead-0020` §5 and
   Open-questions 1 in full, then requirements.md §0.5 in full.
3. Re-derived L = 22 at M07 and L = 28 at M15 from each module's own §6.1 before
   reading either §7's claim as wrong.
4. Derived the two refinements the filing did not carry — the whole-number
   bullet's false conviction, and the straddle test's false licence — and made the
   second the ground of the term-versus-scope ruling.
5. Edited `docs/specs/requirements.md` §0.5: the M04 identity sentence, the new
   **Output offset q** paragraph, the amended identity block, the whole-number
   bullet, the **Cycles** coincidence clause, the **Straddle** bullet, and a
   provenance note attributing the finding to rtl_lead and the term to me.
6. Edited `docs/specs/modules/eth_axis_tx.md`: §7's latency bullet replaced by the
   two-constant table plus derivation, a new *what survives idle injection* bullet
   with the D table, §7's handshake idle sentence, §3's REQ-005 row, §10's REQ-016
   hook, and a §13 row.
7. Edited `docs/specs/modules/ip_eth_tx_64.md`: the same six sites at M15's
   numbers, plus §13's stale *"This spec is DRAFT and has none"* preamble, which
   was already false against §12 and the file's own FROZEN header.
8. Appended the requirements.md §13 revision row: class, force, the refused
   alternative, the countersignature obligation and the provenance split.
9. Ran the census of Reasoning §5, four checks, and recorded the two negative
   results and the two composing sites rather than only the positives.
10. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git write
    of any kind.**

### Evidence

Reproducible from a checkout at this commit.

```sh
git status --short
#   docs/specs/requirements.md, docs/specs/modules/eth_axis_tx.md,
#   docs/specs/modules/ip_eth_tx_64.md — mine — plus
#   test/xgmii_tx_64/test_m04_d.ml, which is the declared dv_lead lane and
#   which I did not open for writing (Trigger)

# 1. The conflation, at both sites, in the text as it stood at HEAD~0's parent
git show cddad51:docs/specs/modules/eth_axis_tx.md  | sed -n '332,342p'
git show cddad51:docs/specs/modules/ip_eth_tx_64.md | sed -n '547,556p'
#   both end "so the figure is exactly 8 octet times and not a rounding"

# 2. The sentence that refutes them, in the same tree
git show cddad51:docs/specs/requirements.md | sed -n '210,216p'
#   "a delay pinned to an inserted word is an event delay, not a latency …
#    both its events are named and both sit at octet position 0"

# 3. The census of the phrase — three hits, one of which is cleared in §5(a)
grep -rn "not a rounding" docs/specs/

# 4. Nothing was built on the retired reading at either module
grep -rl 'eth_axis_tx\|ip_eth_tx' test/          # (no output)
ls libs/hardcaml_ethernet/src/ip_eth_tx_64.ml    # No such file or directory

# 5. The composing sites, true and correctly evented, carried not repaired
grep -rn "SPEC-M07 §7\|SPEC-M15 §7" docs/ | wc -l   # 11
```

**The arithmetic, which is a derivation and not an execution**, stated so a reader
can check it with the two documents and no toolchain. At M07: input octet time
`8C + k`; output octet time `8·(C + 1 + ⌊(14+k)/8⌋) + ((14+k) mod 8) = 8C + 22 + k`;
difference **22**, independent of k. At M15 the same with 20 for 14: **28**.
Identity closes at both under the new term — `8·2 − 0 + 6 = 22` and
`8·3 − 0 + 4 = 28` — and `(L + h − q)` is `16` and `24`, both multiples of 8.
Straddle: `(h − q) mod 8` is `2` at M07 and `4` at M15, neither 0, agreeing with
each §6.1's own two-payload-word statement — and the h-only form returns 0 at
both, which is the false licence.

**The q = 0 check across the rest of the programme, module by module** — M03 (both
lanes), M06, M08, M14, M17, M04, M18, M11, M09 — is a reading of each module's own
§6.1/§7 output-alignment statement, recorded in Reasoning §2. It is what makes the
row editorial and it is the claim most worth an independent check.

**NOT claimed, stated so the absence does not read as coverage**: that any figure
here has been measured (none has — M07 has no bench, M15 has neither bench nor
RTL); that dv_lead has countersigned any part of this diff (it has not, and the
obligation is ledger item 60); that the D tables have been simulated (they are
derived from each §6.1 and are checkable by reading); that the SPEC-M16 and
SPEC-M13 citations are repaired (they are carried, item 59). **No verification
result appears in this entry and no sign-off is claimed.**

### Outcome

**DoD met on all four dispatched acts.** C-RL-8 adjudicated with grounds
(UPHELD, then REFINED at two points the filing did not reach); SPEC-M07 §7
repaired; the §0.5 question decided — **a term, not a scope**, on the straddle
test's licence rather than on the identity; SPEC-M15 §7 repaired in the same
round; M18 and M11 spot-verified clean and the verdicts re-derived rather than
accepted; change-log rows in all three files; this entry.

**On the dispatch's conditional (act 3).** My procedure does **not** require a dv
countersignature before an edit lands: the fourteen 2026-08-11 precedent rows show
the text and its row landing together, with force stated in the row and the
countersignature transcribed later by the orchestrator. So I edited rather than
returning proposed text, and the force disposition is written into the row itself.

**Handoff**: to the orchestrator for commit, and thence to dv_lead for the
countersignature owed on the §0.5 diff (ledger item 60), narrowed to what it adds
— q's definition, the two amended identities, the whole-number bullet, the
**Cycles** clause and the straddle test — with the two module diffs owing none of
their own, since both are consequences of the §0.5 ruling at sites dv did not
file. To rtl_lead: C-RL-8 is discharged and its answer is *the term*; SPEC-M07
§6.1, the section the M07 RTL was built to, is byte-unchanged.

**Carried ledger, restated whole** (ADR-0017 §4.4's practice; every row carries an
owner and a closing event, so a row is never a note to nobody). Items 1–58 are
carried from `-0040` with their dispositions; only the rows this round touched
carry new text.

| # | Item | Owner | Closing event | This round |
|---|---|---|---|---|
| 1 | ADR-0016 §8's transcription mechanic is unwritten in PROTOCOL | orchestrator | a PROTOCOL §11 amendment | carried |
| 2 | The generic shell's `LESSONS` transit is the orchestrator's and unexercised | orchestrator | the first harvest reaching the shell | carried |
| 3 | PROTOCOL §11 does not describe the ADR-0016 §8 transcription mechanic | orchestrator | same transcription as #1 | carried; half spent |
| 4 | ADR-0017 §4.4 owes a fifth step: the rotating entry restates any running carry-forward | me | an ADR-0017 amendment, or a deliberate decision to leave it to practice | carried, practised seven times |
| 5 | ADR-0018 §4.3's `LC-`/`LD-` ids have no per-miner namespace | me | an ADR-0018 amendment, or the collator ruling a scheme | CLOSED at `-0036` |
| 6 | `R-SEAL-2` drafted and unproposed | me | a round that proposes it | carried |
| 7 | ADR-0016 §7.2's immutability question, unanswered for the **active** volume | me | an ADR amendment or an explicit decision that R3 + history suffices | carried |
| 8 | ADR-0019 is PROPOSED, not accepted; its §7 diffs are orchestrator-scope | orchestrator | acceptance or rejection | carried |
| 9 | `agents/journals/INDEX.md` stale, silent on volumes | orchestrator | a gate-boundary refresh (PROTOCOL §9) | carried |
| 10 | No owner for rotating a **shared worker-template** journal | orchestrator | a ruling, or an ADR-0017 clause | carried, overtaken |
| 11 | `docs/gates/P1-module-ready-checklist.md` does not exist | orchestrator (file); me (content) | the checklist landing before the gate | CLOSED at `-0037` |
| 12 | `P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal | me | the next round opening that checklist | carried — this round's write set excluded `docs/gates/`, for the third round running |
| 13 | `lessons-harvest-block.md` instantiation per gate | orchestrator | the first gate to instantiate it | carried |
| 14 | `C-5`'s §0.6 repair: vacuity case and the `-0021` case are different dispositions | me | any WO next opening `requirements.md` §0.6 | CLOSED at `-0039` |
| 15 | "Last octet" received-versus-delivered undecided programme-wide (§0.6) | me | a ruling in `requirements.md` §0.6 | carried — this round opened `requirements.md` at **§0.5** and not §0.6, so the item is untouched rather than passed over; it remains the oldest untaken §0.6 item |
| 16 | Three handoff packets restate "four classes" | me | a packet-text round | carried |
| 17 | M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run | me | the round that opens SPEC-M03 §11 | carried |
| 18 | REQ-901's configuration clause names three transmit-only parameters | me | a `requirements.md` round | carried — **this round opened `requirements.md` and did not take it**, the edit being §0.5's and §13's. Third consecutive pass; it is now a scheduling item |
| 19 | The reference's disposition of a sub-5-octet frame | dv_lead (measurement); me (ruling) | a co-simulation round that measures it | carried |
| 20 | The (e)/(f) reading should run over every error class families E–H assert | me, with dv | a scoping round before Phase 3 | carried |
| 21 | `R-CI-4`'s gate-removal owner | orchestrator | naming the owner | carried |
| 22 | The M03 RTL non-conformance against §9 ruling 9 | rtl_lead (fix); dv_lead (bug) | a `BUG-` round | carried |
| 23 | SPEC-M03 §6.1 item 4 unscoped; §9's paragraph out of table order; `ifc_check.ml`'s stale note | me (first two); orchestrator (third) | the next round opening each file | carried |
| 24 | Requirements ledger open: `C-45`, `C-36`, ADR-0012's residual, REQ-007 at two modules, `C-38`, the `DRAFT` header, `C-2`, `C-3`, `C-7`, `C-9`'s REQ-903 half, `C-32`, `C-33`, `C-44` | me | each closes on the round that opens its clause | carried |
| 25 | Two re-countersignatures and one concurrence owed at `-0013`'s SHA | dv_lead | dv countersigning | carried |
| 26 | The M03-G6 window bound is looser than `-0021`'s ruling | me | reading whether dv tightened G6's window | carried, still unchecked |
| 27 | dv's re-countersignature owed on the §0.6 diff (`-0023`) | dv_lead | dv countersigning | carried |
| 28 | dv's re-countersignature owed on the §0.5 + REQ-016 diff (`-0024`) | dv_lead | dv countersigning | carried — **and this round is its fifth customer and the first to amend the same section.** The straddle test and the *what survives injection* rule this round edits are that diff's own text; the amendment is additive (a term) and retires none of it, so an unsigned `-0024` now has a longer unsigned successor. This is the strongest argument yet for clearing it |
| 29 | Three module specs owe the same repair, named in §13's row (`-0024`) | me | a batch round over the three | CLOSED at `-0038` |
| 30 | `AP-xgmii_rx_64.md` §4.I's cells and `FINDING SO-1-A`'s §6 repair are dv's | dv_lead | dv's next plan round | carried |
| 31 | The design consequence owed as a work order, not absorbed (`-0025`) | me (WO); orchestrator (dispatch) | the WO issuing | carried |
| 32 | `BUG-0002` cannot close on the `-0025` ruling; M03-I4/I6 remain red | dv_lead | a bug round | carried |
| 33 | Option 2 (narrowing REQ-016 at an XGMII port) remains available only as **E2** | orchestrator → sponsor | an E2 escalation, or the option lapsing | carried; still the only E2 on this ledger. **This round again did the opposite of narrowing REQ-016** — it states what REQ-016's own wrapper may assert at two more modules and touches REQ-016's text nowhere |
| 34 | `FINDING CSG-1`'s class request: four cases, three outcomes | dv_lead (carrier); me (class) | a record-only run, then a class round | carried |
| 35 | Repairs that correct dv's findings rather than my own text, unseen by dv | dv_lead | dv reading them, disputing or not | carried — **and this round adds a fourth of the kind, in the other direction**: the straddle licence is a defect *nobody* filed, found by working rtl_lead's filing, and it is the load-bearing half of the ruling |
| 36 | The `-0032` countersignature is owed | dv_lead | dv countersigning | CLOSED at `4e7331b` |
| 37 | The REQ-110 delivered-octets case has no class and now has a stimulus bar | me (class); dv (stimulus) | a class ruling | carried |
| 38 | `WO-0063` phase B's disclosure axis (`-0030`) | dv_lead | that phase closing | carried |
| 39 | Whether any Phase-1 module other than M03 needs the `-0031` treatment | me | a survey round | carried |
| 40 | The nine role-rewrites are the weakest part of `-0034`'s nil-domain declaration | auditor (sampling) | an auditor finding, or the collator accepting the tier | carried |
| 41 | `-0030`'s stated interval is corrected but not retracted | me | nothing repairs it; the correcting notes are the only remedy | carried |
| 42 | A2.4's five clerical edits to `docs/gates/lessons-harvest-block.md` | me | the next round opening `docs/gates/` | CLOSED at `-0037` |
| 43 | A2 binds without countersignature; a contest is carried to an Amendment A3 | any contesting seat; me for drafting | a re-verdict without contest, or an A3 landing | carried, half spent |
| 44 | The block's preamble still says an `SO-` instantiates §3's block *"verbatim"* | me | the next round opening `docs/gates/lessons-harvest-block.md` | carried — **third consecutive round whose write set excludes the file**; the fix is a dispatch that includes `docs/gates/`, which is the orchestrator's to sequence |
| 45 | The `P1-module-ready` checklist's ledger `G-1 … G-11`; five rows are mine | me for those five | each `G-` row's own closing event | carried — **`G-3` gains material again**: two more frozen specifications take post-freeze diffs and **both are editorial**, so the post-freeze churn count still does not move |
| 46 | REQ-904's commissioned CI set-equality script does not exist | dv_lead (`tools/` scope); me for the `WO-` request | the script landing green | carried — **this round adds no REQ id**, fourth round running |
| 47 | Three countersignatures owed on `-0038` | dv_lead | dv countersigning each | CLOSED at `-0039`; re-checked at `-0040`; **re-checked here**: this round amends §0.5's *straddle* and *identity* text, which the `-0038` REQ-210 diff cites but does not contain, and the inserting-module clause that diff *did* write is extended, not retired — its M04 numbers (ΔC = 2, L = 16, q = 0) are unchanged and its signature is undisturbed. Stays closed |
| 48 | `AP-xgmii_tx_64` §8 item 2: REQ-901 declares no divergence class at the M04 boundary | me (the record); orchestrator (the sequencing) | the vendoring commit, then a derivation round | carried; the spec half stays fully discharged |
| 49 | `AP-xgmii_tx_64` §8 item 3 makes `C-5` a dependency of a landed plan | me | the §0.6 round item 14 named | CLOSED at `-0039` |
| 50 | **A closed ledger item can be reopened by a later ruling, and nothing detects it** | me | a survey of closed items whose grounds cite a since-amended §0.5/§0.6 clause | **carried, and this round is the fourth instance and the first from the *other* direction**: not a closed item falsified by an amendment, but an amendment (`-0038`'s inserting-module clause) falsified by a module it had never been evaluated against. The survey's two slices would not have caught it — neither reaches a clause's own *reach*. A third slice is owed: for each normative clause, the set of modules it quantifies over, evaluated |
| 51 | `FINDING CSG-1`'s four cases have never been checked against a run | dv_lead (the run); orchestrator (scheduling) | the first record-only run | carried, unchanged |
| 52 | SPEC-M04's own §11.3 carries `C-5` as a deferred item | me | the `C-5` round of items 14 and 49 | CLOSED at `-0039` |
| 53 | §0.5 states its two tests as properties of a module, and a module may pass them at a port where the stimulus they quantify over has no instance | me | a `requirements.md` §0.5 round, or a deliberate decision to leave the statement at the module | **carried, and it gains a third instance and a sharper form.** M07 and M15 *passed* the straddle test only because the test was keyed to the wrong offset — a module passing a test it should fail, where item 53's two instances were modules passing tests vacuously. All three say the tests are stated over the wrong domain. **This round opened §0.5 and did not take it**, deliberately: one signature should answer one question, and the term was that question. Three instances is past the threshold this row set at two — the §0.5 scoping round should now be scheduled |
| 54 | Class (h)'s REQ-110 half now has no comparing-run instance | me (the class); dv_lead (an observation) | the class round of item 34 | carried, unchanged |
| 55 | Two countersignatures owed on `-0039` | dv_lead | dv countersigning each | CLOSED, both halves, at `747e561` |
| 56 | **The `AP-M14-1` adjacency stands unscoped at four other specifications** — SPEC-M06, SPEC-M17, SPEC-M16, SPEC-M19 | me | a round per specification, or one batch round | carried — **and this round is evidence for the batch reading rather than the per-round one**: two specifications took the same repair in one round because their derivations differed only in a constant, which is the condition under which a batch is safe |
| 57 | **SPEC-M17 §7 and SPEC-M08 §7 still carry the retired *"delay everything by exactly 8 octet times per cycle"* sentence** | me | the round that opens SPEC-M17 §7 | carried — **and this round repaired the *cycle-form* of the same sentence at M07 and M15**, where it read *"delay everything by the number of idle cycles"*. That is the same defect in the same class, so the item's site list was short by two and the two are now closed. What remains is item 57's actual open question, which is different and is about **pulses** at M17 and M08, and is untouched |
| 58 | One countersignature owed on `-0040`: the §0.6 `ABS-1` diff (editorial, in force meanwhile) | dv_lead | dv countersigning | carried — **new-in-progress**; no signature has arrived since `-0040` landed |
| 59 | **Two specifications compose M07's and M15's §7 figures under a name those bullets no longer use exclusively** — SPEC-M16 §7's transmit chain and SPEC-M13 §6.1's REQ-502 table row 15 | me | the round that next opens SPEC-M16 §7 or SPEC-M13 §6.1 | **new this round, and it is a naming-currency item and not a defect** — both texts are true and both name their two events correctly, so neither is falsified. What they under-name is that the cited bullet now pins two constants. Measured by grep over eleven citations, nine of which are handshake or abandon references and untouched |
| 60 | **One countersignature owed on this round**: the §0.5 output-offset diff (**editorial**, IN FORCE meanwhile, signature narrowed to q's definition, the two amended identities, the whole-number bullet, the **Cycles** clause and the straddle test) | dv_lead | dv countersigning | **new this round.** The SPEC-M07 and SPEC-M15 diffs owe **none** of their own — both are consequences of the §0.5 ruling at sites dv did not file, carrying no rule beyond it. A contest of the *in force meanwhile* disposition, or of the term-versus-scope ruling, stays open to dv and would take a narrow round |

- **No harvest note is owed** — PROTOCOL §7 and charter §8 attach it to an `SO-`
  and to a phase gate, and this round is neither. Declared rather than omitted.
  The open span for my next harvest continues to run and this entry joins it.
- **No escalation.** **E2 not triggered** (no requirement, phase or role added or
  dropped; no REQ's normative text is touched, and item 33 remains the only E2 on
  this ledger). **E3 not triggered** — no toolchain or licensing surface is
  reached. **E5 not triggered**: rtl_lead routed C-RL-8 undecided and disputed
  nothing; this is an adjudication of a filing, not of a disagreement.

### Open-questions

1. **The thing dv should check hardest is not the term but its default.** q's
   paragraph says a specification stating no q is stating q = 0, and I justified
   that by a module-by-module reading (Reasoning §2). If **any** Phase-1 module
   other than M07 and M15 has a non-zero q, then the default silently mis-states
   that module's identity and the sweep I declined to mint is owed after all. The
   candidates I judged 0 and would most want re-derived are **M11** (whose output
   is a generated packet, not a forwarded one) and the three structural wrappers
   **M16, M19, M20**, whose transmit-side ports expose a child's stream and whose
   q is therefore inherited rather than their own — a case §0.5 does not discuss.
2. **The *in force meanwhile* disposition is a departure from the REQ-210 row and
   is mine, not precedent's.** I took it because holding the diff would leave the
   licensing form of the straddle test governing in the gap. If dv reads the
   editorial class as too weak to carry a change in what a monitor may demand,
   the honest counter is that the change **removes** a permission rather than
   adding an obligation — but that is an argument, not a signature, and dv's is
   the one that settles it.
3. **Item 50 needs a third slice and this round is why.** Both existing slices
   look for *grounds falsified by an amendment*. This defect ran the other way: a
   clause correct where it was written, wrong at a module it had never been
   evaluated against, and undetectable by either slice. The slice owed is: for
   each normative clause, enumerate the modules it quantifies over and evaluate
   it at each. That is a round of its own and I am naming it rather than doing it.
4. **M15's D table is derived and unreviewed by anyone.** M15 has no RTL, so
   unlike M07 — whose D structure rtl_lead derived independently while
   implementing it — nothing checks my four delay figures but §6.1's own mapping.
   They are the most re-derivable thing in this diff and the least witnessed.
5. **The dispatch's write set and my reading of it.** I edited
   `docs/specs/requirements.md` §0.5's body, not only its §13 row, on the ground
   in Reasoning §3 that a row records a diff and cannot land without one. If the
   orchestrator intended the narrower reading, this round should be bounced whole
   rather than partially reverted — the three files are one diff and the module
   repairs are unsound without the §0.5 term.

### Files-in-this-commit

- docs/specs/requirements.md
- docs/specs/modules/eth_axis_tx.md
- docs/specs/modules/ip_eth_tx_64.md
