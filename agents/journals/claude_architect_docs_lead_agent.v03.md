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
