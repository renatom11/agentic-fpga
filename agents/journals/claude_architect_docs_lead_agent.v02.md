# Journal: claude_architect_docs_lead_agent — volume 02

- **Agent**: architect_docs_lead (Opus 5 lead)
- **Charter**: agents/charters/architect_docs_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 02
- **Continues-from**: J-architect_docs_lead-0021
- **Previous-volume**: agents/journals/claude_architect_docs_lead_agent.md
- **Previous-volume-sha256**: 253e92c87f94f900b161e34c88f018dee1ec4a6d940662317d844192cd69ef8b
- **Previous-volume-bytes**: 423543

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Volume 02 of a chain (ADR-0017 §4.3).
Enforced by scripts/agent_commit.sh and CI.
Volume 01 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-architect_docs_lead-0022] 2026-08-05T22:10Z | task:none | Volume 02 opened voluntarily at 1.62 × S — fields computed from volume 01's committed bytes, the dispatch's urgency figure corrected from one entry to three, and the open-questions ledger restated because ADR-0017 chains bytes and not meaning

### Trigger
Orchestrator dispatch: rotate voluntarily. My active volume stood at 423,543
bytes — **1.62 × `S`** (262,144) and under `H` (524,288) — so `R10` was warning
on every commit I made but refusing none. Three rotations are on the record to
copy from: dv_lead's forced one (`4168962`), the orchestrator's voluntary one
(`e11ffd7`), and the ADR's own worked example. The dispatch named the
orchestrator's volume-02 header as the form to match and told me to verify
`Continues-from` from my own tail at HEAD rather than accept the id it quoted.

No work order. This is a housekeeping round on my own journal, and the only
file it produces is this one.

### Inputs
- `agents/charters/architect_docs_lead.md` (§8 journalling obligations, §5 DoD).
- `agents/PROTOCOL.md` §4 (journals), §4.1 (entry grammar), §4.2
  (`Files-in-this-commit`), §5 (`R1`–`R9` as the constitution still states them),
  §6 (write scopes).
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` — **my own ADR, re-read
  as the thing being executed**: §4.2 (ids never restart), §4.3 (the header
  block and why the back-link is load-bearing), §4.4 (the four-step rotation),
  §5.1 (`S`/`H` and their anchors), §5.2 (the disposition table that predicted
  this volume's disposition in advance), §7.3 (the guard against step 1 landing
  alone).
- **`agents/journals/claude_architect_docs_lead_agent.md` at HEAD** — its entry
  headers and its committed bytes, both read through `git show HEAD:`, never
  from the working tree.
- `agents/journals/claude_orchestrator_agent.v02.md` (the form I was told to
  match) and `agents/journals/claude_dv_lead_agent.v02.md` (the ADR-conformant
  form, and `J-dv_lead-0073`'s verify-before-hashing practice, which I copied).
- `scripts/policy.sh` (`volume_header_field`, `journal_chain_for`,
  `is_chain_path_of`, `JOURNAL_SOFT_MAX`/`JOURNAL_HARD_MAX`),
  `scripts/agent_commit.sh` (the `R10` rotation block at lines 118–141 and the
  `R10` size block at 173–182), `scripts/verify_journal_chain.sh` — read to
  confirm the header I am writing is the header the enforcement actually parses.
- My own `J-architect_docs_lead-0019` (ADR drafted), `-0020` (ADR accepted on
  dv's §6.5 contest), `-0021` (the M03-G6 ruling, whose Open-questions ledger is
  restated below).
- **No `libs/**`, no `test/**`, no `docs/reports/audit/**`, no `scripts/**` edits
  — read only.**

### Reasoning

**1. Every header field was computed from the committed object, and the one I
was told to verify disagreed with nothing — which is the point of checking.**
`git show HEAD:… | grep '^## \[J-architect_docs_lead-'` ends on **0021**, so
`Continues-from` is `J-architect_docs_lead-0021` and my first entry here is
**0022**. I checked it for the same reason dv did at `J-dv_lead-0073`: if my
`-0021` commit had not landed, `Continues-from` would name an entry volume 01
does not contain — a forged join point, created by accident, in the exact field
the chain check exists to catch. It landed; the field is right; and the check
cost one command.

**2. I verified volume 01 is byte-identical to HEAD *before* hashing it.**
`git diff --stat HEAD -- <vol01>` is empty and the worktree sha256 equals the
`git show HEAD:` sha256, so the hash in this header describes **a state that
exists in history**, not one that happens to be on my disk. ADR-0017 §4.3 says
the two coincide *because the predecessor is not modified by the rotation
commit* — which is a claim about this commit's own discipline, and therefore
exactly the kind of claim to confirm rather than assume. The entire integrity
argument of §4.3 ("altering one byte of an archived volume requires rewriting
every successor's `Previous-volume-sha256`") is worth nothing if the hash was
taken of an uncommitted variant.

**3. The dispatch's urgency figure is wrong by about 3×, and I am recording the
correction because a voluntary rotation is the one kind that an inflated figure
could make look forced.** The dispatch said I was "one long entry" from `H`.
Measured over volume 01's 21 entries: mean **20,151** bytes, mean of the last
six **21,664**, **maximum 32,883** (`J-architect_docs_lead-0019`, the ADR-0017
drafting entry). Headroom was 524,288 − 423,543 = **100,745 bytes** — about
**4.6 typical entries, or 3.06 of my largest ever**. So `H` was three entries
away, not one.

This changes no decision: at 1.62 × `S` the warning had been firing for rounds,
§5.1's anchor (one volume should be one readable unit; the Read tool refuses my
journal at 256 KB) was already violated in the direction that matters, and the
right time to rotate voluntarily is while the chain is quiet rather than under a
refusal. But **"rotate because you are about to be refused" and "rotate because
your volume stopped being readable" are different reasons**, and only the second
one is true here. Writing down the first would have made the next reader believe
`H` binds tighter than it does — and `H`'s credibility as a gate that "cannot
refuse the wrong commit" (§5.3) rests on its arithmetic being quoted accurately
by the people it governs. I am its author; overstating it in my own journal
would be the cheapest possible way to corrode it.

**4. §5.2's prediction still holds, and holds in the precise form it was
written — which needs saying, because a careless tally now reads as three
rotations against a prediction of one.** The prediction was *"exactly one
**forced** rotation"*, dv_lead's. Measured at this HEAD: dv_lead 1,123,442
(2.14 × `H`, forced, `4168962`); me 423,543 (warn band, **voluntary**);
orchestrator 279,351 (warn band, **voluntary**, `e11ffd7`); tb_writer 231,879;
auditor 138,428; rtl_lead 132,667; data_wrangler 42,587. **Exactly one journal
has ever been over `H`.** The other two rotations are the mechanism being used
as designed, not the prediction missing. §5.2 also said my journal would *"stay
in the warn band until 524,288"* — it did, across three further entries and
+65,923 bytes. The disposition table has now been correct about every journal in
the repository for the whole interval between drafting and execution.

**5. The rotation felt like an ordinary commit, which is the property I
countersigned for.** §4.4 promised there is **no rotation mode in the scripts**:
`R2` sees one own-chain path staged; `R3` sees a new file and passes its
byte-prefix test against an empty predecessor; `R5` reads the last id from the
*chain* at HEAD (`chain_last_entry_num`), so 0021 → 0022 needs no special case;
`R10`'s block at `agent_commit.sh:118-141` re-derives all four chain fields from
`HEAD:` and my staged file and compares. I read that block before writing the
header rather than after, and wrote the header to the parser rather than to the
example: `volume_header_field` matches `- **<field>**: ` anchored at column 1
and stops at the first `---`, and it distinguishes `Previous-volume` from
`Previous-volume-sha256` correctly because the `**: ` is part of the match. No
flag, no branch, nothing disabled. There is nothing here for a future agent to
abuse, which was the design goal.

**6. On the header's prose paragraph I took the union rather than the dispatch's
form, and the reason is normative rather than aesthetic.** The orchestrator's
volume 02 paraphrases the notice and drops ADR-0017 §4.3's sentence *"Volume 01
is FROZEN: it is never appended to again, and any change to it breaks this
file's `Previous-volume-sha256`"*; dv_lead's carries it verbatim. The **field
set and order — the only load-bearing part, and the only part any script reads —
is byte-for-byte identical in all three**, so "matching the form" is satisfied
either way. I kept the orchestrator's ADR citation *and* restored §4.3's frozen
notice, because that sentence is the one thing in the block that tells a human
reader what the hash below it is *for*. A header that carries the hash without
the sentence is verifiable by a script and mute to a person, and this programme's
whole thesis is that both must be true of the record.

**7. The thing ADR-0017 does not chain is meaning, and a rotation is exactly
where that bites.** §4.3 chains **bytes** (sha256 back-link) and §4.2 chains
**ids** (contiguity). Neither chains the *running ledger* — the Open-questions
carry that every one of my entries since `J-architect_docs_lead-0013` has passed
forward, whose only anchor is the immediately preceding entry. That entry now
lives in a 423 KB file which, by §5.1's own anchor, **a fresh agent cannot open
in a single Read**. A rotation that says nothing therefore silently truncates
the one part of my journal that is deliberately cumulative — not by rewriting
anything, but by putting it one file behind a boundary readers will not cross.

So the ledger is **restated in full** in this entry's Open-questions rather than
cited. That is the correct remedy at the boundary and it is cheap; the ADR-level
question of whether it should be *required* at the boundary is raised below as a
finding against my own ADR, not fixed here — fixing it is a spec diff plus an
amendment, and this commit stages one journal file.

**8. Citation namespace: nothing moved.** Ids continue across volumes and never
restart (§4.2), so this is **0022**, not 0001. Every `J-architect_docs_lead-NNNN`
reference in every ADR, spec §13 row, gate checklist signature, packet and
countersignature in this repository stays resolvable, and volume 01 keeps its
historic path forever. The file moved; the namespace did not. In particular the
`P1-spec-freeze` checklist signatures and the two re-countersignatures owed at
`J-architect_docs_lead-0013`'s SHA are unaffected.

**9. Scope.** One new file under `agents/journals/`, which is my own journal
chain and not a work product; `Files-in-this-commit` is therefore `- (none)`
(PROTOCOL §4.2) and the commit is `Journal-Only: true`. No `docs/**` path is
touched, so no spec, requirement, ADR, interface record or gate checklist moves,
and **no countersignature is owed** — dv_lead's testability signature attaches to
normative spec text, and there is none here.

### Actions
- **Verified the last entry id at HEAD** — `J-architect_docs_lead-0021` — from
  volume 01's committed bytes, not from the dispatch and not from the worktree.
- **Verified volume 01 is byte-identical to HEAD** before hashing it (both
  `git diff --stat` and a worktree-vs-`git show` sha256 comparison).
- **Computed** `Previous-volume-sha256` =
  `253e92c87f94f900b161e34c88f018dee1ec4a6d940662317d844192cd69ef8b` and
  `Previous-volume-bytes` = **423,543** from
  `git show HEAD:agents/journals/claude_architect_docs_lead_agent.md`.
- **Measured** volume 01's per-entry size distribution to check the dispatch's
  urgency claim (reasoning 3), and re-measured every journal in the tree against
  `S` and `H` to check ADR-0017 §5.2's prediction (reasoning 4).
- **Read `agent_commit.sh`'s `R10` block and `policy.sh`'s
  `volume_header_field`** before writing the header, so the block is written to
  the parser rather than copied from an example.
- **Created `agents/journals/claude_architect_docs_lead_agent.v02.md`** with
  §4.3's header — the three standard bullets plus `Volume`, `Continues-from`,
  `Previous-volume`, `Previous-volume-sha256`, `Previous-volume-bytes` — and the
  frozen-predecessor notice above the `---`.
- Wrote this entry, `J-architect_docs_lead-0022`, as the volume's first, and
  **restated the Open-questions ledger in full** rather than citing it across the
  boundary.
- **Did not touch volume 01**, and **did not stage the two paths another agent's
  in-flight round put in the tree while I worked** — dv_lead's own volume 02
  (+263 lines, the family-H round) and an untracked
  `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md`. The
  second matters: `agents/handoffs/**` **is** in my write scope (PROTOCOL §6), so
  a `git add -A` would sweep a packet that is not mine into this commit. It is
  not mine and it is not claimed. **This commit stages exactly one path:**
  `agents/journals/claude_architect_docs_lead_agent.v02.md`.
- **Re-verified volume 01 against HEAD after** those paths appeared: still
  byte-identical, so the digest in this header still describes the committed
  object.
- No `git commit`, no `git push` — handed to the orchestrator as always.

### Evidence
All commands run at HEAD `1ff8562444d3e05928fb72524a4a5df3ae871781`, branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`. `git status --porcelain` was
**empty** when this round began; by the time it ended it showed dv_lead's
in-flight family-H work (`M agents/journals/claude_dv_lead_agent.v02.md`,
`?? agents/handoffs/WO-0057_…`) alongside my `??` volume 02. Volume 01 was
re-hashed **after** that appeared and is unchanged (4 below), so (2) and (3)
still describe the committed object.

1. `git show HEAD:agents/journals/claude_architect_docs_lead_agent.md | grep -c '^## \[J-architect_docs_lead-'`
   → **21**; the same pipe through `tail -1` ends on
   `## [J-architect_docs_lead-0021]`. **`Continues-from` = 0021; this entry is
   0022.**
2. `git show HEAD:agents/journals/claude_architect_docs_lead_agent.md | sha256sum`
   → `253e92c87f94f900b161e34c88f018dee1ec4a6d940662317d844192cd69ef8b`.
3. `git show HEAD:agents/journals/claude_architect_docs_lead_agent.md | wc -c`
   → **423543** = **1.62 × `S`**, **0.81 × `H`**.
4. `git diff --stat HEAD -- agents/journals/claude_architect_docs_lead_agent.md`
   → empty, and `sha256sum` on the worktree copy returns the digest in (2), so
   the hashed bytes are the committed bytes. **Re-run after dv_lead's paths
   appeared: identical both times.**
5. Per-entry sizes over volume 01 (byte offsets between successive
   `^## \[J-architect_docs_lead-NNNN\]` headers): mean **20,151**, mean of last
   six **21,664**, **max 32,883** at entry 0019, header block 369 bytes.
   Headroom at rotation = 524,288 − 423,543 = **100,745** = **4.6** mean entries
   / **3.06** maximum entries. *(Corrects the dispatch's "one long entry".)*
6. Every journal at HEAD, bytes: dv_lead 1,123,442 (+ v02 31,313);
   architect_docs_lead **423,543**; orchestrator 279,351 (+ v02 9,214);
   `workers/tb_writer` 231,879; auditor 138,428; rtl_lead 132,667;
   `workers/data_wrangler` 42,587; `workers/rtl_module_dev` 364;
   `workers/formal_dv` 359. **One journal has ever exceeded `H`.**
7. `grep -n 'R10\|R11\|volume\|chain' agents/PROTOCOL.md` → two hits, both
   unrelated senses of "chain" (§2 line 37, §8 line 275). **The constitution
   still contains no `R10`, no `R11` and no volume concept** — see
   Open-questions.
8. `scripts/agent_commit.sh` **read, not run** — running it requires staging,
   which is the orchestrator's act. `:118-141` re-derives `Volume`,
   `Previous-volume`, `Previous-volume-sha256` and `Continues-from` from `HEAD:`
   and the index and compares each against this header; `:173-182` applies `H`
   to the **staged active volume**, which is this file — **under 26 KB, i.e.
   below 5% of `H`** (stated as a bound rather than an exact count, because a
   file cannot quote its own final byte count without changing it), so the
   rotation commit passes that gate by construction. I reproduced all four
   comparisons by hand against `HEAD:` using `policy.sh`'s own
   `volume_header_field`, `last_entry_num` and `sha256_hex` — all four match —
   and `chain_last_entry_num architect_docs_lead HEAD` + 1 → **0022**, this
   entry's id (`R5`).
9. **`bash scripts/verify_journal_chain.sh` over the working tree → exit 0**,
   nine chains green, including **`OK: architect_docs_lead — 2 volume(s), 22
   entries, chain verified`**. That is the back-link, the `Continues-from`
   equality and id contiguity **0001…0022 across the volume boundary**, all
   checked from the tree with no history — which is the property §4.3 argues for.
   Two honest bounds: it ran over the **worktree**, which carries dv_lead's
   uncommitted appends to its own active volume (immaterial — no frozen volume's
   hash depends on an active one), and per §6.5 as dv_lead's countersignature
   amended it, **a green chain does not certify this volume**, only the frozen
   ones. The orchestrator's re-run at the committed tree is still the one that
   counts.

### Outcome
**DoD met for the dispatch as issued.**

- **Volume 02 is open** at `agents/journals/claude_architect_docs_lead_agent.v02.md`
  with ADR-0017 §4.3's header, all five chain fields computed from volume 01's
  committed bytes, and this entry — `J-architect_docs_lead-0022`, continuing the
  id sequence — as its first and only content.
- **Volume 01 is frozen** at **423,543 bytes / 21 entries**, at its historic
  path, never appended to again. Every existing citation of it resolves
  unchanged.
- **The commit stages this file only**; `Files-in-this-commit` is `- (none)` and
  the commit is journal-only.
- **Three of the repository's journals are now chains.** dv_lead's was forced;
  the orchestrator's and mine were voluntary; **exactly one journal has ever been
  over `H`**, as ADR-0017 §5.2 predicted in advance.
- **One correction on the record**: the dispatch's "one long entry from `H`" was
  three (reasoning 3, evidence 5). The conclusion — rotate now — is unchanged and
  independently supported by §5.1's readability anchor.

**Handoff**: orchestrator, for commit under `Agent: architect_docs_lead`,
`Work-Order: none`, `Journal-Only: true`,
`Journal-Entry: J-architect_docs_lead-0022`.

### Open-questions

**New this round.**

- **ADR-0017 chains bytes and ids, but not the running ledger — a gap in my own
  ADR, found by executing it** (reasoning 7). §4.3's back-link and §4.2's
  contiguity together prove nothing was *rewritten* or *dropped*; neither notices
  that a cumulative carry-forward stops being read because it is now one file
  behind a boundary a fresh agent cannot cross in a single Read (§5.1's own
  anchor). I remedied it here by restating the ledger in full below, which is the
  right act at a boundary and is **not** a rule. Candidate amendment: §4.4 gains
  a fifth step — *the rotating entry restates any running carry-forward rather
  than citing across the boundary* — as prose, not a script check, since "is
  there a running ledger" is a judgement about content and by ADR-0017 §5.3's own
  test that disqualifies it from being a gate. **Owner: me. Closes by: an
  ADR-0017 amendment, or a deliberate decision to leave it to practice.**
- **`workers/claude_tb_writer_agent.md` is the next journal to warn, and it is a
  worker template — a case neither ADR-0017 nor any charter has considered.** It
  is at **231,879 bytes / 14 entries** (16,563 mean): **30,265 bytes = 1.8
  entries under `S`**. §5.2 called it "quiet" and it no longer is. Mechanically
  nothing breaks — `policy.sh`'s globs cover `agents/journals/workers/…v[0-9][0-9].md`
  and `KNOWN_AGENTS` includes the workers — but the *procedure* has no owner: a
  worker journal is **shared per template across spawns**, so the rotation would
  fall to whichever short-lived Sonnet spawn happens to hold the pen, executing
  §4.4 from a work-order line, computing a sha256 and freezing a volume it did
  not write. Whether that is acceptable, or whether a lead/orchestrator should
  rotate worker volumes out-of-band, is undecided. **Raise before tb_writer's
  second-next spawn**, which on this arithmetic is when `S` is crossed.
- **ADR-0017 §8's PROTOCOL diffs are still unapplied, and step 2 landing made
  this worse rather than better** — upgraded from a carried item to a finding.
  `a0454b4` put `R10` and `R11` into `agent_commit.sh`, `check_journals.sh` and
  `test_protocol.sh`, and `verify_journal_chain.sh` into `scripts/`. The
  constitution — `agents/PROTOCOL.md` — still describes journals as "one
  append-only journal per agent identity", still lists **`R1`–`R9`** in §5, and
  contains **no occurrence of `R10`, `R11`, or the volume/chain concept at all**
  (evidence 7). So today: **two rules refuse commits without being written down
  anywhere in the document that claims to be the complete list of rules**, and a
  fresh agent reading PROTOCOL §4 would not learn that volumes exist — while its
  own journal may already be one. This is precisely the failure mode §7.3's guard
  was built to prevent for step 1, applied to a step nobody guarded. §8's diffs
  are drafted, in my scope as ADR text, and orchestrator-scope to apply
  (ADR-0016 §8's transcription mechanic). **Escalating as a dispatch request:
  the transcription should land at the next orchestrator round.**

**Carried, restated in full rather than cited (reasoning 7).** From
`J-architect_docs_lead-0021`, itself carrying from `-0020`:

- **From the M03-G6 round, now checkable**: the tb_writer row built under
  `WO-0054` §3.6 used the *widest defensible* window bound, which is looser than
  the bound `-0021` ruled; the row is correct as built and merely weaker on the
  secondary bound. `-0021` said it "reconciles at review", and the G7/G8 round
  has since landed (`82fa0f6`, `e7657e3`, `6dd229c`) — so whether dv tightened
  G6's window check to the truncation word is now a fact to *look up* rather than
  await. Nothing forces the tightening; the item closes by confirming which way
  it went.
- **C-5's §0.6 repair is still owed and has a third data point** (not a third
  instance): when it lands it must state the vacuity case (no referent) and the
  `-0021` case (referent at closure) as *different* dispositions, or it re-merges
  what that ruling separated. Closes by: any work order that next opens
  `requirements.md` §0.6 for its own reasons; owes dv_lead's countersignature as
  a normative change.
- **"Last octet" received-versus-delivered is undecided programme-wide** (§0.6).
  Bites hardest where the two differ most: M03's oversize case (1,514 delivered
  of ≥ 1,519 received) and every terminated frame's stripped FCS (4 octets).
- **PROTOCOL §11 does not yet describe the ADR-0016 §8 transcription mechanic.**
- **PROTOCOL §5's CI paragraph says "`R1`–`R8`"** while
  `scripts/check_journals.sh:40-54` also checks `R9`. (Now compounded by the
  `R10`/`R11` gap above — the same paragraph is wrong at both ends.)
- **`R-SEAL-2` drafted and unproposed.**
- **ADR-0016 §7.2's immutability question**: partly answered for frozen volumes
  by ADR-0017's back-link, and **not at all** for the active one — which, after
  today, is this file.
- **`docs/gates/P1-spec-freeze-checklist.md`'s ledger `C-7` ordinal.**
- **`agents/journals/INDEX.md` is stale at `J-orchestrator-0012`** — and is now
  additionally silent on volumes, so the one file whose stated job (PROTOCOL §9)
  is to point a rehydrating session at journal tails does not know that three
  agents' tails have moved. Worst-affected of the carried items by this round.
- **Three handoff packets restate "four classes".**
- **M03 has no §11 item tracking REQ-901 (e)/(f) to the first co-simulation run.**
- **REQ-901's configuration clause names three transmit-only parameters.**
- **The reference's disposition of a sub-5-octet frame.**
- **dv's endorsed question**: the (e)/(f) reading should run over every error
  class families E–H assert, before Phase 3 is scoped.
- **`R-CI-4`'s gate-removal owner.**
- **The M03 RTL non-conformance against §9 ruling 9.**
- **§6.1 item 4 unscoped**; **§9's "Aborted-and-forwarded" paragraph out of table
  order**; **`tools/precompile_stubs/ifc_check.ml`'s stale note**.
- **Ledger items open**: `C-45`, `C-36`, ADR-0012's residual, REQ-007's scoping
  clause at two modules, `C-38`, `requirements.md`'s `DRAFT` header against its
  §13 frozen treatment, `C-2`, `C-3`, `C-5`, `C-7`, `C-9`'s REQ-903 half,
  `C-32`, `C-33`, `C-44`.
- **Two re-countersignatures and one concurrence owed** at
  `J-architect_docs_lead-0013`'s SHA.

### Files-in-this-commit
- (none)

## [J-architect_docs_lead-0023] 2026-08-06T20:15Z | task:WO-0057 | §0.6's window reference word RULED and generalised upward — the last octet the frame RECEIVED while open, the closing word standing in only where it received none, and the received-versus-delivered question I deferred at -0021 settled because the fallback's own trigger depends on it

### Trigger

Orchestrator dispatch of a scope ruling dv_lead routed to me **twice** and which
is now unblocked (no active round cites the clause). First routing:
`WO-0057` §3.2 and §7 question 1, written while designing family H —
"§0.6's upper bound is ΔC = 3 after the input word carrying the frame's last
received octet; M03-H4's frames received none, so that phrase has no referent",
with dv's own grounded proposal (the closing character's word) and the note that
it **blocks no row** because the exact pin carries every assertion. Second
routing: `RV-0057-VERDICT` Finding 2, which adds the measured consequence — at
M03-H4 the §0.6 window check "cannot fail", because the pin and both window ends
are functions of one quantity, so the row's entire assurance is its exact
two-element `error_pulses` list.

The dispatch named the constraints I worked to: make M03-H4's situation
representable; contradict neither SPEC-M03 §9's committed pin nor
`test_m03_f.ml`'s `run_f2` `k = 0` precedent; and **stop and escalate rather than
land** if the ruling would change what any committed test asserts. It also left
the ADR question to my judgement.

### Inputs

- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` §4, §4.1, §4.2,
  §6, §7, §11.
- `docs/specs/requirements.md` §0.1–§0.7 in full, §1's REQ-007/REQ-008/REQ-011/
  REQ-015 rows, §1.1, §12, §13 — and its DRAFT header, which is what makes a
  §0.6 diff a countersignature question.
- `docs/specs/modules/xgmii_rx_64.md` §7 (the pinned L and ΔC = 3 at both start
  lanes), §9 in full — the condition table, the closure list, "Strobe cycle,
  pinned" with its withdrawn gloss and its **far-edge** sentence, the M03-G6
  reference-word paragraphs, the C-5 distinction, the nine co-occurrence
  rulings — §10, §13.
- `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md` §2.4,
  §3.1, §3.2, §4, §6, §7, and the `RV-0057-VERDICT` block (§0, §1, Findings 1–4,
  rulings 8 and 9). Read only; not touched.
- My own `J-architect_docs_lead-0021` (the M03-G6 ruling, read in full from
  volume 01 through `git show 1004384`) and `-0022`'s open-questions ledger.
- **The committed bench, read as evidence and not as authority** (PROTOCOL §10
  runs the other way — DV derives from specs — but what a committed test already
  asserts is a fact about whether a ruling changes anything):
  `test/xgmii/injection.ml`'s `window`/`no_output_cycle`, `test_m03_f.ml`
  `run_f2` with `f2_received_counts = [0; 1; 4]` at both start lanes,
  `test_m03_h.ml` `run_h2` and `run_h4` plus the file's header sections,
  `test_m03_g.ml`'s G1 window derivation, `test_m03_d.ml` `run_d1`,
  `test_m03_e.ml` `run_e1`.
- The two carry-forward **C-5** sites read rather than assumed:
  `docs/specs/modules/xgmii_tx_64.md` §9 and §11.3, and
  `docs/specs/modules/arp_eth_rx.md`'s closure list and pinned strobe cycle.
  Also `docs/specs/modules/eth_axis_rx.md` §9 (`error_short_frame`) and
  `docs/specs/SPEC-TEMPLATE.md` §9.
- **Not read**: no RTL, no `docs/reports/audit/**`. **Not written**: nothing
  outside the two spec files below and this journal.

### Reasoning

**1. The question is not the one the routing names, and the difference is the
whole ruling.** Both routings and the dispatch say "a frame that delivered
nothing". But §0.6's window is anchored to an **input** word — "the input word
carrying the last octet of the offending frame" — and delivery is an output
property. The class with no referent is therefore not the zero-**delivered**
class; it is the zero-**received** class, and the two are different at M03 by
exactly the frames that receive one to four octets and deliver none (§9's sixth
row). So the first thing I had to decide was which of the two the fallback keys
on, and that decision is forced from outside: it is exactly the question I
declined to settle at `-0021`.

**2. It is forced by text already committed, in two independent places, and I
checked both rather than reasoning from the phrase.**

*SPEC-M03 §9's own far-edge sentence.* "Strobe cycle, pinned" says the
no-output-word pin lies inside §0.6's window and, in one case, **at its far
edge**: "the four-octet case just named (last frame octet in the word before the
terminate word, ΔC = 3)". Work it. A lane-4-started frame with four octets and a
terminate character in lane 0 of the next word has `closing_ot ≡ 0 (mod 8)`, its
last received octet one octet earlier in the **previous** word, so the window's
upper end is `(closing_cycle − 1) + 3 = closing_cycle + 2`, which is exactly the
pin. That sentence is true **only** if a received-but-undelivered octet is one of
the frame's octets. Key the fallback on "delivered nothing" and this frame takes
its closing word instead, the upper end becomes `closing_cycle + 3`, and §9's
committed sentence becomes false. The dispatch's own stop condition — do not
contradict SPEC-M03 §9's committed pin — therefore decides the trigger before any
preference of mine gets a vote.

*The committed bench, which is that case.* `run_f2` runs `k ∈ {0, 1, 4}` at lanes
0 and 4, so **(lane 4, k = 4) is the far-edge frame**, and it computes
`expected_not_after = ((closing_ot − 1) / 8) + 3` for every `k ≥ 1` and
`closing_cycle + 3` only at `k = 0`. A "delivered nothing" trigger changes that
row's asserted value. That is the dispatch's escalate-instead-of-land condition,
and it is avoided not by weakening the ruling but by getting its trigger right.

**3. Having settled the trigger I had also settled the deferred question, so I
said so instead of leaving it implicit.** `-0021` left "received or delivered"
open on the ground that the M03-G6 answer held "under whichever of the two
conventions §0.6 is later read to use". Working the lane-4 arithmetic shows that
claim is generous to itself: at a lane-4 start an oversize frame's last
*delivered* octet (index 1513) sits at cycle *s* + 190 while the truncation octet
sits at *s* + 191, a **different input word**, so under the delivered reading
`-0021`'s own answer — the truncation word — is wrong at one of the two start
lanes that `test_m03_g.ml` runs. The received reading is the one that makes the
earlier ruling true. Leaving the question open a second time would have left a
ruling resting on arithmetic that only holds under the reading nobody had
adopted, and it is precisely the silence that made the question recur twice. So
§0.6 now says **received**, and SPEC-M03 §9 gains the paragraph that records it
at the site whose own sentence was relying on it.

**4. I rejected option (b) — delegate the zero-received reference to each module
spec's pin — and the reason is Finding 2 read forwards.** Delegation makes the
window a restatement of the pin at every module that has one, so the window check
becomes inside-by-arithmetic **everywhere**, not merely on the zero-received
class. Finding 2's disposition ("no defect, recorded so a green M03-H4 is not
read as evidence its pin was independently bounded") would generalise from one
class into the rule itself, and §0.6 would keep a paragraph that constrains
nothing. The window exists to catch a **specification** defect — a module pin
outside its own window, which is exactly what M03-R2 was — and a rule derived
from the pin cannot do that. Delegation is the shape of the disease, not the
cure.

**5. What I added beyond the two options, and why it belongs in normative
text.** Finding 2's real content is a warning to every future bench writer, and
it is not M03-specific: wherever the reference word and the pin come from the
same input word, a green window check carries no information and the assurance is
the exact pin plus the **exact** strobe-event set. I wrote that as a non-normative
note under the rule rather than leaving it in a verdict packet, because §0.6 is
the test-derivation basis and this is the one place a test writer will look. It
also states where the window **does** keep teeth — any frame that received an
octet, where the two ends and the pin are three different quantities — so the note
cannot be read as retiring the check.

**6. Does it generalise M03-G6 or distinguish it? It generalises, and the
generalisation is the second clause verbatim.** `-0021`'s principle was that a
frame's report is a function of the frame and never of the characters that happen
to follow it, so REQ-108's truncation — a closure event — fixes the reference and
the next start character does not extend the frame. §0.6 now states that as a
general clause binding every module, and adds the degenerate case `-0021` had no
instance of: where the frame closed before any octet of it arrived, the closure
**is** the last input event that belongs to the frame, so the closing word stands
in. G6 and H4 are then the same rule at two points on one scale — a frame whose
last octet is early, and a frame whose last octet does not exist — rather than two
rulings that happen to agree.

**7. Nothing benched moves, and I checked it row by row rather than asserting
it.** The rule I wrote is, clause for clause, what `test/xgmii/injection.ml`'s
`window` has computed since family E: `received > 0 → start_ot + 8 + (received −
1)`, else `closing_ot`, plus three. Every M03 window value in families E, F, G
and H is that function's output or a hand-computation equal to it. One
hand-computed exception exists and is **looser**, not different in kind:
`test_m03_d.ml`'s D1/D2 take the terminate word where the rule takes the last
received octet's word, which at a lane-0-started 64-octet frame is one cycle
later. A looser stated bound cannot fail a row whose pin is inside the tighter
one, so nothing changes meaning; it is a DV-side tightening opportunity and I
have listed it as such rather than treating it as a defect.

**8. Class, countersignature and ADR.** Editorial by §13's own test: no
conformant design changes (every module's cycle is pinned exactly by its own
specification and every pin lies inside the window this rule defines, at both
start lanes), and no committed test changes meaning (§7). But §0.6 is
**normative** text in the test-derivation basis and this settles a reading, so it
takes the **countersignature discipline** the C-43 precedent established rather
than the concurrence class C-39/C-41 diffs closed under: dv_lead's
re-countersignature is owed and the diff is not in force until transcribed. That
costs nothing operationally — the module pin carries every commissioned
assertion (`RV-0047` ruling 2) and the bench already computes these values.
**No ADR**, deliberately: an ADR records a design choice among live alternatives,
and here no design moves and the two readings are not rival designs — they differ
only in which class each leaves undefined, and one of them falsifies text already
committed. The precedent is exact: the two prior §0.6 diffs that settled
undecided corners, C-12's open-frame scoping and C-23's counting convention, both
landed as revision-record rows with no ADR. Calling this constitution-grade would
also be a category error: it changes no rule of the org, only the reading of one
sentence about one module class.

**9. What I did not do.** I did not close ledger **C-5**. The rule I wrote very
likely reaches both of its sites — M04's underflowing frame has received words
while open (first clause), and M09's payload-less frame has a closing `hdr_valid`
(third clause) — which means C-5's §0.6 repair is now **written** and only its two
module-side dispositions remain. But closing it means editing SPEC-M04 §11.3 and
SPEC-M09 §9 and checking each module's own pin against its own newly-defined
window, which is outside this dispatch's file scope and is real work rather than
clerical. `-0021` predicted C-5's repair would have to state the vacuity case and
the referent-at-closure case as different dispositions; it now must state a third,
that the fallback supplies a referent where the frame received nothing. Recorded
as an open question, not smuggled in.

### Actions

- `docs/specs/requirements.md` §0.6: new normative paragraph **"The window's
  reference word"** inserted between "Strobe timing window" and "Counting a
  strobe" — three clauses (received-not-delivered with the control-character
  carve-out; closure never extended by what follows; the zero-received fallback
  to the closing word, with the one-to-four-octet frame explicitly excluded from
  it) plus the non-normative note on what the window is worth when reference and
  pin share a word.
- `docs/specs/requirements.md` §13: one revision row, dated 2026-08-06, class
  **editorial with countersignature discipline**, commissioned-by naming both
  routings and Finding 2.
- `docs/specs/modules/xgmii_rx_64.md` §9: one paragraph **"Decided since,
  upward"** appended after the M03-G6 paragraph that deferred the question — the
  earlier text is left standing untouched, and the new paragraph records the
  upward decision, the lane-4 arithmetic that makes the received reading the one
  under which §9's own answer holds, and the one-to-four-octet exclusion.
- `docs/specs/modules/xgmii_rx_64.md` §13: one change-log row, `Breaking? no`,
  `ADR none`.
- No ADR. No `agents/**` file but this journal. No `test/**`, no `libs/**`, no
  `docs/gates/**` (PROTOCOL §7 reserves gate-checklist staging to the
  orchestrator, so the ledger consequences below are transcription requests).

### Evidence

Commands run from a checkout at this commit; all reads, no builds (this unit of
work produces no code and touches no `Interface` record, so no `ifc_check` run is
owed — charter §5's compile item applies to spec freezes, and §4's records are
byte-unchanged here).

- `git show 1004384 -- agents/journals/claude_architect_docs_lead_agent.md` —
  `J-architect_docs_lead-0021` in full, the ruling this generalises.
- `grep -n "let window" -A 6 test/xgmii/injection.ml` → the committed DV model:
  `let last_octet_ot = if received > 0 then start_ot + 8 + (received - 1) else
  closing_ot in closing_ot / 8, (last_octet_ot / 8) + 3`. This is the rule §0.6
  now states, clause for clause, and it is the mechanical demonstration that the
  diff ratifies the bench rather than moving it.
- `grep -n "f2_received_counts" test/xgmii_rx_64/test_m03_f.ml` → `[ 0; 1; 4 ]`,
  driven at lanes `[ 0; 4 ]`, so the far-edge member `(lane 4, k = 4)` is
  committed and running.
- `test_m03_f.ml:417-423` → `expected_not_after = if k = 0 then closing_cycle + 3
  else ((closing_ot - 1) / 8) + 3`; `test_m03_h.ml:861-865` → both of M03-H4's
  frames take `not_before = closing_word`, `not_after = closing_word + 3`,
  `cycle = closing_word + 2`. Both are outputs of the rule above.
- Arithmetic re-derived by hand and stated in the spec text: at a lane-4 start an
  oversize frame's truncation octet (`start_ot + 8 + 1518`) lies at cycle
  *s* + 191 and its last delivered octet (`start_ot + 8 + 1513`) at *s* + 190 —
  different input words, which is the check that decides received vs delivered.
  At a lane-0 start both fall in *s* + 190, which is why the question stayed
  invisible for one ruling.
- `git status --porcelain` → exactly the two spec files listed below.

### Outcome

**DoD met.** The ruling is landed as a spec diff in the two files, in the voice
and the class the §13 table requires, with the generalisation stated explicitly
and the alternative (delegation) recorded with its price. M03-H4's situation is
representable: two zero-received aborts each take their own closing word, the
consecutive high cycles are already governed by §0.6's C-23 counting convention,
and §0.6's conservation equation counts each by its own discard-strobe pulse. No
committed test changes meaning, so no escalation was triggered. Handed back to
the orchestrator for commit; the ruling's answer goes to dv_lead as the response
to `WO-0057` §7 question 1.

### Open-questions

- **dv_lead's re-countersignature is owed on the §0.6 diff**, which is not in
  force until it is transcribed. Nothing is blocked meanwhile.
- **Ledger C-5 is now half-repaired and should be re-scoped, not closed.** The
  §0.6 text it has been owed since batch B exists; what remains is SPEC-M04
  §11.3's and SPEC-M09 §9's own dispositions — each site's "the window is vacuous
  here" sentence is now stale, and each module's pinned cycle must be checked
  against its own newly-defined window before either row is retired. Owner: me;
  closes at any work order that opens either spec. This is a **transcription
  request** to the orchestrator, since `docs/gates/**` is not mine to stage.
- **A DV-side tightening, non-blocking**: `test_m03_d.ml`'s D1 and D2 compute the
  window from the **terminate** word where the rule now names the last received
  octet's word — one cycle looser at a lane-0-started 64-octet frame, identical at
  a lane-4 start. The rows pass either way; tightening them makes the check as
  sharp as the newer families' and removes a divergence between the hand values
  and `injection.ml`'s `window`. Rides with any later `test/**` touch, as
  `RV-0057-VERDICT` Finding 3's one-line repair does.
- **Finding 2's standing note is now normative-adjacent**: `AP-xgmii_rx_64.md`'s
  X-3 check (c) is a real instrument on frames that deliver and a tautology on
  frames that do not. §0.6 now says so in the document a plan writer derives from;
  whether the attack plan restates it is dv_lead's call, not mine.
- All items carried in `J-architect_docs_lead-0022`'s ledger remain open except
  as amended above; the one it listed as **"last octet received-versus-delivered
  is undecided programme-wide"** is **closed by this entry**.

### Files-in-this-commit
- docs/specs/requirements.md
- docs/specs/modules/xgmii_rx_64.md

## [J-architect_docs_lead-0024] 2026-08-04T06:20Z | task:SCR-M03-I4 | dv's unsatisfiability derivation CONFIRMED and widened — the per-octet constant is not the gap-invariant quantity at any module, the deciding input word is, and that is §0.6's reference-word ruling arriving at the data path

### Trigger

Orchestrator dispatch of **SCR-M03-I4**, dv_lead's spec change request, escalated
in `RV-0059-VERDICT` §6 (`agents/handoffs/WO-0059_tb-m03-family-i-silence-and-
ordered-sets.md` at `9bc6dd1`) and relayed to me verbatim by pointer under the
WO-0057 §7 routing precedent. The claim to rule on: requirements.md §0.5's
"Gapped stimulus" paragraph, REQ-016's verification column and SPEC-M03 §6.1's
clause *"because §7's per-octet constant does"* are **jointly unsatisfiable** with
REQ-011 and REQ-103/REQ-104 for any idle-injected stimulus with k ≥ 1. The
consequence dv states and does not absorb: `Latency.is_constant` cannot be
satisfied on an injected run, and `AP-xgmii_rx_64.md` §4.I's M03-I4 Observable is
unachievable as written. M03-I4 and M03-I6 are BOUNCED and rebuilding to dv's
`D(m)` rule in parallel; the ruling gates dv's owed AP edit and the worker's HOLD
declaration. The dispatch's stop condition: if the ruling would change what any
committed **green** test asserts, escalate instead of landing.

### Inputs

- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` §3, §4, §4.1,
  §4.2, §6, §7, §10, §11.
- `agents/handoffs/WO-0059_tb-m03-family-i-silence-and-ordered-sets.md`, the
  `RV-0059-VERDICT` block in full (§0 through §12), Findings 1, 2, 5 and 6 and
  §8's corrected rule read line by line. Read only; not touched.
- `docs/specs/requirements.md` §0.5 in full, §0.6 in full (the ruling I am asked
  to compare against), §0.7, REQ-004, REQ-005, REQ-011, REQ-013, REQ-015,
  REQ-016, REQ-019, REQ-021, REQ-101 … REQ-113, §1.1 including its currency
  table, §13.
- `docs/specs/modules/xgmii_rx_64.md` §3's REQ-016 row, §6.1 in full, §6.2's
  `Frame` row, §7, §8, §10, §11, §13.
- The other five REQ-016 restatement sites, read rather than assumed:
  `eth_axis_rx.md` §3/§7/§10, `eth_demux.md` §3/§7/§10, `arp_eth_rx.md`
  §3/§6.1/§7/§10, `ip_eth_rx_64.md` §3/§6.1/§7/§10/§11.2, `udp_ip_rx_64.md`
  §3/§7/§10.
- My own `J-architect_docs_lead-0023` (the §0.6 reference-word ruling) and
  `-0022`'s open-questions ledger.
- **The committed bench, as evidence of what is asserted and not as authority**:
  `test/xgmii_rx_64/test_m03_i.ml` (`run_i1`, `run_i2`, `run_i3`, `run_i4_case`,
  `run_i6_case` call sites), `test/xgmii/test_idle_injection.ml` in full,
  `test/monitors/octet_time.mli`'s `is_constant`/`observed`/`constant` contract,
  and a tree-wide search for `Idle_injection` users.
- **Not read**: no path under `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`,
  `docs/reports/audit/**`. **Not written**: nothing outside the two spec files
  below and this journal.

### Reasoning

**1. I re-derived dv's arithmetic instead of accepting it, because a ruling that
quotes a derivation has not made one. Both halves confirm, and one of them is
narrower than dv states while the other is wider.**

*(a) The `tlast` word.* Confirmed exactly, at the failing member. 64 octets at a
lane-0 start: content octets 0…63 occupy source cycles s+1…s+8, terminate at
s+9, `uniform ~idles:1` sites at every boundary from s+2 through s+9. Delivered
octets 56…59 sit in source cycle s+8 and move by 7 idles; the terminate word
moves by 8; §6.1's drain derivation pins the `tlast` word one cycle after the
terminate word at this residue, so it moves by 8 while its octets moved by 7 —
**L = 24 against 16**, dv's number. *Narrower than dv states in one respect I had
to work to find*: the separation exists only where the terminate character's
input word is **later** than the word carrying the last delivered octet, which is
`r = N mod 8 ∈ {0,1,2,3,4}` at a lane-0 start and `r ∈ {0,4,5,6,7}` at a lane-4
one. At a **lane-0** start with `r ∈ {5,6,7}` the two are the same word and the
per-octet constant **does** survive — three of the eight commissioned directed
lengths, at one lane. dv's `D(m)` rule is right at every residue; it is the
*consequence* that is residue-dependent, and I put the residues in §6.1 because a
bench that measures one class at length 69 and two at length 68 must be able to
tell a conformant reading from a defect.

*(b) The lane-4 straddle.* Confirmed and **structural in the strongest sense**.
Octets 8m…8m+3 lie in lanes 4…7 of one input word and 8m+4…8m+7 in lanes 0…3 of
the next; an injected idle between them moves the second half by 8 octet times
and not the first; the eight octets of an output word occupy eight *consecutive*
output octet times whatever their input did, so L(8m+4) − L(8m+3) = 1 − 9 = −8
and **no emission cycle can fix it**. At k = 1 that is L = 20 and L = 12 in one
word, dv's numbers. REQ-011 forecloses the only alternative.

**2. dv's derivation is right and its scope is too small — the same defect is at
three other modules, and I found it by asking what makes the straddle happen
rather than by looking at M03.** Output word m carries the octets at input octet
times T + h + 8m … T + h + 8m + 7; those lie in one input word **iff h ≡ 0
(mod 8)**. That is a one-line test over §1.1's own h column, and it convicts
**M06 (h = 14)** and **M14 (h = 20)** as well as M03 at a lane-4 start (12), while
acquitting M03 at lane 0 (8), M08 (0) and M17 (8). **M10** fails the other test:
its `arp_valid` pulse is decided by ARP octet 27's input word while its latency is
measured from ARP octet 0's, so its constant does not survive injection although
its h is 0. Three module specs therefore state, in their own §3/§6.1/§7/§10, the
sentence I am retiring; each §10 hook **commissions the unachievable assertion**,
which is a worse residue than the stale sentences C-5 left at M04 and M09.

**3. Why I did not repair those three in this diff, and why that is not
timidity.** The dispatch names two files. Each of the three needs its own
arithmetic worked against its own pinned numbers, its own `tlast`/pulse
dependency and its own §10 hooks — real work, not clerical, and exactly the
ground on which `-0023` declined to close C-5. None of the three has a committed
bench, so nothing is blocked and no bench can be built against the false cell
without a work order I would see. What I refused to do is leave them *silent*:
§0.5 now carries the arithmetic test that decides each one, and §13's row **names
all five modules and the verdict for each**, including the two that pass and are
not to be "repaired". That converts three latent traps into three bounded,
owned, dated repairs — the honest form of PROTOCOL §11's restatement discipline
when the diff that would satisfy it mechanically is larger than the ruling.

**4. What I ruled, and why the promise is per output *event* rather than per
output *word*.** dv asked for a per-word rule keyed to `D(m)`. I state it one
level more general — the **deciding input word** of any output *event*, word or
pulse — for two reasons, neither cosmetic. First, M10 has no output word at all
and its defect is the same defect; a word-only rule leaves the module whose
observable is a pulse outside the rule that convicts it. Second, §0.6's window is
already keyed to a *pulse's* deciding word, so a word-only rule would have stated
half of a principle the document already carries in the other half. The
gap-invariant quantity is then: **the delay in cycles from D to the event it
decides is the same gapped as gapless.** That is what every module spec's §6.1
and §7 already pin, which is why the ruling moves no pinned number anywhere.

**5. Two options I rejected.** *(i) Scope §0.5's per-octet constant to gapless
and stop there* — the minimum the SCR asks for. Rejected: it says what does not
hold and leaves what does hold to be derived, and the derivation is exactly the
one that went wrong twice already (dv's own §2.4 and §3.4 item 4 supplied a
replacement for a barred idiom that was itself unsound). A specification that
retires a promise without stating its successor hands the next bench the same
problem with less text to get it right from. *(ii) Delegate the gapped-stimulus
promise to each module spec's §7* — the shape `-0023` rejected for §0.6 and
rejects again for the same reason: a rule derived from the pin cannot catch a
defective pin, and this diff exists because a programme-level sentence was wrong,
not because a module's was.

**6. Does it generalise the §0.6 ruling, or is it independent? It generalises,
and I can name the shared clause.** `-0023` keyed a frame's **report** to the
input word that decides it: the last octet the frame received while open, or —
where it received none — the input word carrying the character that closed it.
This ruling keys an output **word** to the input word that decides it: the word
carrying its last octet, or — where its `tkeep`, `tlast` and `tuser`[0] are not
decidable from its own octets — the word carrying the **terminate character**.
The fallback is not merely analogous; it is the *same clause*: the closing event
is the last input event that belongs to the object being reported, so it stands
in wherever the object's own octets do not decide it. One principle, two ports.
I wrote that cross-reference into §0.5 rather than into this journal, because the
next reader who needs it is a bench writer reading the requirements, not an
auditor reading me. **It is a generalisation and not a coincidence**, and the
test is that the two rules now share their degenerate case.

**7. The stop condition, checked row by row rather than asserted.** No committed
green test changes meaning. `Idle_injection` has exactly two customers in the
tree: its own X-4 unit tests, which assert only **input**-side octet times (every
shift a non-negative multiple of 8, no octet changes lane, the preamble stays
contiguous) — all of them consequences of REQ-016's normative sentence, which
this diff leaves **untouched** — and `run_i4_case`/`run_i6_case`, which are RED
and BOUNCED at this SHA and are rebuilding to the rule I am ruling. M03-I1, I2, I3,
families A–H, the REQ-004 stress and its directed lengths are all gapless, which
is the stimulus class §0.5 defines L over and which this diff scopes it to
explicitly. Adding "on a gapless stimulus" to §0.5's definition sentence
therefore removes no assertion any of them makes. REQ-005 and REQ-111 inherit the
scope by citation, so neither row needed touching — a discipline that kept the
diff to two files.

**8. Class, countersignature and ADR.** **Editorial** by §13's own test: no
conformant design changes — the per-octet constant was *never* achievable under
injection, so nothing was ever built to it, and the design's own answer at the
failing member (word 0 on cycle 4) is what the corrected text describes — and no
committed test changes meaning (§7). **Countersignature discipline applies**, the
C-43 precedent: §0.5 is normative text in the test-derivation basis and REQ-016's
verification column is dv_lead's own commissioning instrument, so dv_lead's
re-countersignature is owed and the diff is not in force until transcribed.
Nothing is blocked meanwhile, because the rebuilt M03-I4/I6 assert the
per-output-word rule that SPEC-M03 §6.1 states in this same commit. **No ADR**,
and the reason is sharper than at `-0023`: an ADR records a choice among live
alternatives, and here the alternative is **arithmetically impossible** rather
than merely rejected — a specification asserted something no module can do, and
the correction is forced. Nor is it constitution-grade: nothing in PROTOCOL, a
charter or an enforcement script moves, and calling a corrected derivation a
constitutional amendment would devalue the class. The precedents are the §0.5 and
§0.6 diffs that settled a reading without an ADR (C-15, C-23, and `-0023`'s).

**9. What I owe dv_lead that is not text.** The ruling makes a complete,
falsifiable prediction about the measurement `RV-0059-VERDICT` §12 commissions —
the observed L classes on the held runs — and I state it in the return rather than
hold it, because a withheld prediction is a claim (PROTOCOL §10, R-SEAL-1) and
because a ruling that cannot be scored is not worth countersigning.

### Actions

- `docs/specs/requirements.md` §0.5 **"Latency"**: the definition sentence gains
  **"on a gapless stimulus"**, with the C-15 note below it named as the precedent
  for putting a qualifier in the sentence rather than eighty lines away.
- `docs/specs/requirements.md` §0.5 **"Gapped stimulus"**: the two-sentence
  paragraph replaced by five — the retired inference named as retired; **the
  deciding input word** defined for output words and for pulses; **what survives
  idle injection** stated as the delay from D to the event it decides; the
  *why* paragraph with the two arithmetic tests (**straddle**, h ≢ 0 mod 8, with
  the Phase-1 verdict read off §1.1's h column; **late decision**, with M03's
  `tlast` word and M10's pulse as the two instances); **what a latency monitor may
  demand**, with the SHALL NOT and the report-don't-assert clause; the *relation to
  §0.6*; and a provenance paragraph in §0.5's existing voice.
- `docs/specs/requirements.md` **REQ-016 verification column** repaired to the two
  achievable observables, with the retired clause quoted and convicted in place.
  REQ-016's **normative sentence is untouched**, as are REQ-005, REQ-011 and
  REQ-111.
- `docs/specs/requirements.md` §13: one row, class **editorial with
  countersignature discipline**, naming the five restatement sites and the verdict
  for each.
- `docs/specs/modules/xgmii_rx_64.md` §6.1 consequence 1: the **justification**
  *"because §7's per-octet constant does"* withdrawn, the **rule kept** and
  re-grounded on the fact that its cycles are keyed to named input words.
- `docs/specs/modules/xgmii_rx_64.md` §6.1 C-14.4 paragraph: the sentence *"the
  per-octet constant of §7 holds on every stimulus, gapped or not"* withdrawn as
  false; a new subsection states **D(m) for this module** (both bullets, with the
  offsets consequence 1 and the drain derivation already pin), why the two
  readings coincide gaplessly, and the three worked derivations — `tlast`
  separation by residue at both lanes, the lane-4 straddle, and the lane-0
  `r ∈ {5,6,7}` case where the constant survives and a bench must not generalise
  from it.
- `docs/specs/modules/xgmii_rx_64.md` §7 handshake bullet and §10's REQ-016 hook:
  the achievable observable stated, the unachievable one forbidden by name, and
  per-octet latencies on an injected run declared reportable but not assertable.
- `docs/specs/modules/xgmii_rx_64.md` §13: one row, `Breaking? no`, `ADR none`.
- **No ADR. No `test/**`, no `libs/**`, no `agents/**` but this journal, no
  `docs/gates/**`** (PROTOCOL §7 reserves gate staging to the orchestrator, so the
  ledger consequences below are transcription requests). `AP-xgmii_rx_64.md` is
  dv_lead's and is **not** touched.

### Evidence

Reads and hand arithmetic; this unit produces no code and moves no `Interface`
record, so no `ifc_check` run is owed (charter §5's compile item binds spec
freezes; §4's records are byte-unchanged).

- `git show 9bc6dd1 --stat` → the SCR's commit, `RV-0059-VERDICT` at
  `agents/handoffs/WO-0059_…md:1029–1571`, `Agent: dv_lead`,
  `Journal-Entry: J-dv_lead-0083`.
- `grep -rn "Idle_injection" test/ --include=*.ml --include=*.mli` → two
  customers only: `test/xgmii/test_idle_injection.ml` (X-4's own units) and
  `test/xgmii_rx_64/test_m03_i.ml` at `run_i4_case`/`run_i6_case`. No family A–H
  file and no `run_i1`/`run_i2`/`run_i3` appears. This is the mechanical form of
  the stop-condition check.
- `test/xgmii/test_idle_injection.ml:114–165` → X-4's REQ-016 unit asserts only
  input-side octet times (`every shift is a non-negative multiple of 8`, `no octet
  changes lane within its word`, `the frame's first octet is still 8 octet times
  after its start character`). REQ-016's normative sentence is untouched by this
  diff, so all three still hold.
- `grep -n "is_constant" -B4 -A6 test/monitors/octet_time.mli` → *"True iff at
  least one octet was compared and every front-offset class has a single L"* —
  the demand this ruling declares unsatisfiable on an injected run, quoted from
  the instrument itself.
- `grep -rn "gapped\|gapless\|REQ-016" docs/specs/` → the five restatement sites
  named in §13's row, each read at its own line before being listed.
- Hand arithmetic, stated in the spec text and reproducible from it: at a lane-0
  start octet j has input octet time 8s + 8 + j and the terminate character
  8s + 8 + N, so the terminate word exceeds the last delivered octet's word iff
  `N mod 8 ≤ 4`; at a lane-4 start the offsets are 8s + 12 + j and 8s + 12 + N,
  giving `N mod 8 ∈ {0,4,5,6,7}`. Output word m spans input octet times
  T + h + 8m … T + h + 8m + 7, which lie in one input word iff `h ≡ 0 (mod 8)`.
- `git status --porcelain` → exactly the two spec files listed below.
- Markdown table integrity re-checked by column count on every edited row: the
  REQ-016 row and both §13 rows have the same pipe count as their neighbours.

### Outcome

**DoD met.** SCR-M03-I4 is ruled as a spec diff in the two named files, in the
voice and class §13 requires. dv's derivation is **confirmed** at both structural
sites, with one narrowing (the `tlast` consequence is residue-dependent and the
constant survives at a lane-0 start with `N mod 8 ∈ {5,6,7}`) and one widening
(the same defect convicts M06, M14 and M10). M03-I4/I6's rebuilt form is
representable: §6.1 names `D(m)` with both clauses and the offset at each start
lane, §10's hook commissions the per-word delay and the unchanged tuple sequence,
and per-octet latencies are declared reportable-not-assertable, which is exactly
the HOLD `RV-0059-VERDICT` §12 item 3 instructs. dv_lead's owed `AP` §4.I edit is
unblocked on this ruling. **No committed green test changes meaning**, so the
dispatch's escalate-instead-of-land condition was not triggered. Handed to the
orchestrator for commit; the ruling goes to dv_lead as the answer to SCR-M03-I4
and to the M03-I4/I6 round-2 worker through dv's packet.

### Open-questions

- **dv_lead's re-countersignature is owed on the §0.5 + REQ-016 diff**, which is
  not in force until transcribed. Nothing is blocked meanwhile — the module-side
  rule SPEC-M03 §6.1 states in the same commit carries round 2's assertions.
- **Three module specs owe the same repair and are named in §13's row**:
  SPEC-M06 (§7, §10), SPEC-M10 (§3, §6.1, §7, §10), SPEC-M14 (§3, §6.1, §7, §10,
  §11.2). SPEC-M08 and SPEC-M17 pass both of §0.5's tests and are **not** to be
  touched. Owner: me; closes at the next work order that opens those specs. This
  is a **work-order request** to the orchestrator, not a silent to-do.
- **A prediction, disclosed rather than held** (PROTOCOL §10, R-SEAL-1: this is a
  forward statement in the open, not a seal). Under `uniform ~idles:k`, k ≥ 1, at
  the commissioned lengths 64…71, the observed L classes are: **lane 0, N mod 8 ∈
  {5,6,7}** → one class {16}; **lane 0, N mod 8 ∈ {0,1,2,3,4}** → two classes
  {16, 16 + 8k}, the second being exactly the `tlast` word's delivered octets;
  **lane 4, N mod 8 = 4** → **three** classes {12, 12 + 8k, 12 + 16k}, because the
  `tlast` word both straddles and is late-decided by one further word; **lane 4,
  every other residue** → two classes {12, 12 + 8k}. If dv's round-2 measurement
  disagrees anywhere, the disagreement is a finding against this ruling and I want
  it returned with its numbers, on §12 item 5's own terms applied to me.
- **`AP-xgmii_rx_64.md` §4.I's M03-I4 and M03-I5 cells** are dv_lead's to edit and
  I have not touched them; the ruling they were waiting on is this entry.
- All items carried in `J-architect_docs_lead-0023`'s ledger remain open,
  **C-5 included** — this ruling does not touch it, and the third disposition it
  predicted is still owed at SPEC-M04 §11.3 and SPEC-M09 §9.

### Files-in-this-commit
- docs/specs/requirements.md
- docs/specs/modules/xgmii_rx_64.md

## [J-architect_docs_lead-0025] 2026-08-04T18:40Z | task:BUG-0002 | rtl_lead's E5 against my own D(m) SUSTAINED — the non-`tlast` clause demanded hindsight and is refuted by two frames, so D becomes the evidence word for every output word, uniformly, and M03 must hold a completed word until its evidence arrives

### Trigger

E5 escalation from rtl_lead against my own `a77017c` §0.5 ruling
(`J-architect_docs_lead-0024`), relayed by the orchestrator verbatim-by-pointer:
`agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md` at
`ce00c06`, "What the fix does not repair" and the Root-cause section above it.
rtl_lead fixed the `tlast`-on-word-0 defect dv_lead convicted (last-ness gated on
the closure record, gapless bit-identical), and the fix exposed that the
specification's own `D(m)` — mine, one round old — pins an emission no causal
design can produce. Adjudication, charter §3 and §5: the ruling is a spec diff.

### Inputs

- `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`
  at `ce00c06` — read in full, both the packet body and rtl_lead's Root-cause /
  fix / escalation response.
- `docs/specs/requirements.md` §0.5 (whole gapped-stimulus block), REQ-016,
  REQ-004/005/011/015/019, §13's last three rows.
- `docs/specs/modules/xgmii_rx_64.md` §6.1 (whole), §6.2 `Frame` row, §7, §8's
  directed-length set, §10's REQ-016 hook, §13.
- `agents/charters/architect_docs_lead.md` §3, §5, §7, §8; `agents/PROTOCOL.md`
  §3, §4, §6, §8, §10.
- My own `J-architect_docs_lead-0024` (the ruling under appeal, including its
  disclosed prediction) and §13's `J-dv_lead-0084` countersignature row.

### Reasoning

**1. The proof is sound, and I verified it rather than accepting it.** rtl_lead's
pair is a 72- and a 64-octet lane-0 frame under `uniform ~idles:7`. Re-derived
from the wrapper's own site rule (boundaries before source cycles 3 … the
terminate word) with injected(c) = c + k·|{sites ≤ c}|: both put source cycle 9
at injected 58 and source cycle 10 at 66, so the two injected lines are identical
through cycle 65 and first differ at 66. Under D(m)-as-ruled the 72-octet frame's
word 7 is non-`tlast`, keyed to the word carrying frame octet 63 (source cycle 9,
injected 58), gapless cycle 11 + 49 idles = **60**; the 64-octet frame's word 7 is
its `tlast` word, keyed to the terminate word, 11 + 56 = **67**, and REQ-015 plus
§0.5's tuple invariance admit exactly eight words, so nothing at 60. Identical
registers, identical current input word, `tvalid` required to be both 1 and 0.
**Sustained.**

**2. Sharpened twice, because the sharper forms decide the remedy.** (a) The pair
does not need an uncommissioned length: **69** octets works identically — its
terminate also lies in source cycle 10 (lane 5), so it has the *same* injection
sites as the 64-octet frame and the same injected map, and 64 and 69 are both in
§8's directed set {64 … 71} at a lane-0 start with k = 7, which §10 commissions.
The collision is therefore inside the commissioned stimulus, not at its edge —
which matters, because it is what stops option 2 from being a cheap escape from a
merely exotic case. (b) The defect is not confined to word 7 or to long frames: a
**64**- and a **12**-octet frame at k = 7 are identical through injected cycle 9,
and the old rule pins word 0 at cycle **4** for the first while admitting nothing
there for the second. So the very measurement `BUG-0002` §2.3 read as "the first
confirmation of §6.1's D(m) against hardware" confirmed nothing: the design
produced 4 by closing on emptiness — the defect the packet convicted — and the
two agreed by coincidence. I say that plainly in §6.1 because a future reader
would otherwise cite that green guard against this ruling.

**3. Where my own rule went wrong, stated precisely.** Not "the `tlast` bullet is
wrong" — it is right and it does not move. The error is that I kept the
last-octet word as the **rule** and late decision as an **exception**, when the
exception is the general case at any port whose framing is not carried in band.
Whether output word m keeps eight octets and whether it is its frame's last are
both comparisons against N, the frame's received length, which the module learns
only from a further octet's arrival or from the closing character. Word m's own
octets settle neither. So a specification keyed to them is running the module
backwards — hindsight, exactly the shape I retired at `a77017c` for the per-octet
constant, one level deeper.

**4. The uniform rule, and why it is one object rather than two bullets.**
D(m) = whichever arrives first, received frame octet **8m + 12** (the fifth after
word m's own eight) or the character that closes the frame. The two are exclusive
by arithmetic, not merely ordered: octet 8m + 12 exists iff N ≥ 8m + 13, and word
m is last iff N ≤ 8m + 12 — so (a) decides exactly the non-`tlast` words and (b)
exactly the `tlast` word, while the module, not knowing N, evaluates only
"whichever came first". That is why the rule is causal *and* why it reproduces the
old `tlast` clause exactly. rtl_lead's option 1 wording ("the first input word
after word m's octets that carries a frame octet or closes the frame") is right
gapless and undefined at two real cases — a lane-0 frame with r ∈ {5,6,7}, whose
`tlast` word shares its input word with the terminate, and every lane-4 `tlast`
word — because there the closure is *in* the octets' own word, not after it. The
octet-index form has no such hole and needs no "at or after" hedge.

**5. Option 1 vs option 2 was not a choice between two things I may do.** Option
2 narrows REQ-016's reach at an XGMII port. REQ-016 is a countersigned normative
IFC requirement whose verification column §10 commissions at this module by name;
narrowing it **drops commissioned coverage**, which is charter §7 **E2** — the
architect does not take it in-role, it goes up with options and cost. So the real
choice was: rule option 1, or escalate E2 and block. I ruled. I record honestly
that option 2 is not *refuted* — I checked two of the collisions against it and
they dissolve, because a frame that ends earlier also loses injection sites and so
becomes distinguishable in time; I did not prove it consistent in general and I do
not claim it. It is not foreclosed: if the emission rule proves unaffordable in
timing or area, rtl_lead returns with the cost and I take it up as E2. Option 3
(keep row 7) is refuted above and is not available to anyone.

**6. The costs I found that the escalation did not name, and would not have
wanted hidden.** (a) §6.1's **r ∈ {5, 6, 7} survival carve-out is void** — the one
clause of this ruling dv_lead re-derived exactly when it countersigned `a77017c`.
Under the uniform D that case has *two* L classes (the `tlast` word's octets share
the terminate word and are separated from their evidence by no idle, so they still
measure L, while every other word measures L + 8k) and r ∈ {0 … 4} under a uniform
wrapper has *one* — the exact inversion of what the item promised. Withdrawn, and
replaced by "there is no surviving case", which is the safer statement anyway: no
bench can now over-read a green. (b) §6.1 item 1's worked figure ("those four
octets measure L = 24 while every octet before them measures L") and item 2's
("L = 20 and L = 12 in one word") are stale for the same reason; re-based to 24 as
a single value at 64/lane-0/k = 1, {16, 24} at 69/lane-0/k = 1, and 28/20 for the
lane-4 straddle. (c) The consequence-1 scope note said rows 1 and 2 move *earlier*
under an idle injected before W. They do not — the aborted frame's last word can
be proven last by nothing except the character in W that aborted it, so W is the
named word in **all six** rows and both reports move together. The conclusion
(never coincident, §6.3 item 8 has no instance) survives on the offsets alone.
(d) My own disclosed prediction at `J-architect_docs_lead-0024` about measured L
classes is **falsified by this ruling** — by my own arithmetic, not by dv's
measurement — and is retired and replaced in Open-questions rather than left to
be quietly contradicted by a future run.

**7. What I did not do.** I did not name a register, a hold, or a one-shot in the
specification. §6.1 states the observable — a word whose D(m) has not arrived is
not emitted, `tvalid` = 0 on those cycles — and REQ-019's two-word bound is stated
to be untouched, with the reason (word m + 1's octets complete no earlier than
D(m)), plus an instruction to raise rather than build if a design finds it needs a
third. Whether that costs an elastic emission register is rtl_lead's to answer,
and the work order to answer it is a follow-on, not a line in this diff.

### Actions

Two files, four sites in one and five in the other, no other file touched.

`docs/specs/requirements.md` §0.5: the **output-word bullet** of *the deciding
input word* replaced (evidence word; in-band framing named as the case where the
two readings coincide; XGMII named as the case where they part); the paragraph
after the bullets restated for the gapless coincidence; a new normative paragraph
**the test a specification's D must pass** (causality, the SHALL NOT, and the
two-frame refutation shape); the **late-decision** bullet extended to record that
at an XGMII port every output word is late-decided and M03 has no surviving
residue class; the *Relation to §0.6* paragraph's "fallback" framing corrected;
the provenance paragraph given its second-ruling note, including that M06/M08/
M14/M17 owe nothing further from this diff because their framing is in band.
§13: one row.

`docs/specs/modules/xgmii_rx_64.md`: §6.1's **D(m)** block rewritten (the
blockquoted rule, the exclusivity proof, the 64/69 and 64/12 refutations, the
per-lane offsets, the two consequences); §6.1 item 1 and item 2 re-based; item 3
rewritten as **no surviving case**, carve-out withdrawn; consequence 1's scope
note repaired to W in all six rows; §7's handshake bullet restated with the
uniform D, the offsets, the not-emitted-before-D observable and the withdrawal.
§13: one row.

### Evidence

The claims here are arithmetic on the committed specification and reproduce from
a checkout at this SHA with no toolchain (ADR-0005). The closed forms, stated so
the auditor and dv_lead re-derive rather than trust — lane-0 start, `/S/` at
source cycle 1, frame octet j at source cycle 2 + ⌊j/8⌋, `/T/` at octet offset N,
`uniform ~idles:k` injecting at boundaries before source cycles 3 … (terminate
word), injected(c) = c + k·|{sites ≤ c}|, gapless emission of word m at cycle
m + 4:

- **The refutation.** N = 64 and N = 69 share sites {3…10}, so both map source
  cycle 9 → 58 and source cycle 10 → 66 at k = 7. Old rule: N = 69 word 7 at
  11 + 49 = **60**; N = 64 word 7 at 11 + 56 = **67** with exactly 8 words.
  N = 64 and N = 12 map source cycle 2 → 2 and source cycle 3 → 10 at k = 7; old
  rule pins word 0 at **4** and at **11** respectively.
- **New-rule cycles, M03-I4 (64, lane 0, k = 1)**: 5, 7, 9, 11, 13, 15, 17, **19**.
  **M03-I6 (64, lane 0, k = 7)**: 11, 19, 27, 35, 43, 51, 59, **67**. `tkeep`
  0xFF ×7 then 0x0F, `tlast` on word 7 only, `tuser` 0 — the tuple sequence of
  `BUG-0002` §2.2 unchanged, and word 7's cycle unchanged from it.
- **Gapless invariance**: at k = 0 the new D reproduces m + 4 for every output
  word of every N from 5 to 199 at **both** start lanes, hence `m + 3`, L = 16/12,
  ΔC = 3, §7's table, the drain window and §9's cycles are byte-true as written.
- **No `tlast` word's cycle moves** at any k ∈ {1,2,3,7}, any N in 5…199, either
  lane — old and new D agree on the last word of every frame.
- **Offsets taken**: lane 0 → 1 where D is the octet, 1 or 2 where D is the
  closure; lane 4 → 0 and 0 or 1. **Words waiting at once**: maximum **2** over
  N = 5…199, k ∈ {0,1,2,3,7,15}, both lanes — REQ-019's bound is not touched.
- **L classes under a uniform wrapper, new rule**: lane 0, r ≤ 4 → one value
  {L + 8k}; lane 0, r ≥ 5 → {L, L + 8k}; lane 4 → {L + 8k, L + 16k}. This is what
  retires §6.1 item 3's carve-out and my `-0024` prediction.

These were re-derived twice, by hand in the Reasoning above and by a throwaway
enumeration script over N = 5…199 written in the session scratchpad. **That script
is ephemeral and is not committed** (ADR-0003/F5): it is a convenience over the
same closed forms printed here, every one of which is recomputable from the two
committed sections with a pencil. Nothing in this entry rests on it.

### Outcome

**DoD met** for an adjudication (charter §5, §8): both positions recorded, the
ruling landed as a spec diff in the two named files, the rejected alternative
recorded with the reason it was rejected — and, unusually, with the reason it was
*not available to me*. **Not in force until countersigned**: requirements.md §0.5
is normative text in dv_lead's sole test-derivation basis, so this diff carries
the same discipline as `a77017c` — dv_lead's re-countersignature is owed and the
orchestrator transcribes it into §13 before the rule binds. Handed to the
orchestrator for commit under `Agent: architect_docs_lead`,
`Work-Order: BUG-0002`; the ruling goes to rtl_lead as the answer to its E5 and to
dv_lead as the countersignature request and the guard-value change.

### Open-questions

- **Countersignature class, stated procedurally because this revises a
  countersigned diff.** dv_lead countersigned the `a77017c` §0.5 text at `d39ffb6`
  (`J-dv_lead-0084`) on seven checks. That signature is **neither withdrawn nor
  inherited**. Five of its checks stand untouched (straddle verdicts, the L = 24
  example *as a fact about the old D*, the forbidden predicate's location in
  `Latency.is_constant`, REQ-016's clause mapping, confinement); the **residue
  survival table is superseded** — its arithmetic was right for the D it assumed
  and is void under this one; and the sixth, the D(m) bullet itself, is what this
  diff replaces. The new countersignature is asked **narrowly**: (1) the two-frame
  refutation at 64/69 and 64/12, (2) k = 0 invariance at both lanes, (3) the
  withdrawal of the r ∈ {5,6,7} carve-out and the inverted class table, (4) the
  new M03-I4/I6 pinned cycles above. Until it is transcribed, the a77017c text
  remains the one in force and M03-I4/I6 stay red and held either way.
- **A design consequence is owed as a work order, not absorbed.** M03 must not
  emit a completed word before its D(m) arrives. Whether that is an elastic
  emission register (rtl_lead's ~15 lines) or something else is rtl_lead's call;
  what the specification fixes is the observable. This needs **one WO to rtl_lead**
  (implement to the new §6.1) and **one to dv_lead** (M03-I4's `:1041` guard and
  its siblings re-derived to the cycles above, not hardcoded from this entry).
  Sequencing matters: the countersignature first, then the two work orders, or the
  RTL is built to a rule not yet in force.
- **`BUG-0002` cannot close on this ruling.** M03-I4/I6 remain red after
  rtl_lead's committed fix and stay red until the emission rule lands; the packet's
  Fix verdict stays open and the family-I qualification campaign stays shut. The
  committed fix is **not** reverted by this — gating last-ness on the closure
  record is necessary under the new rule too, and this ruling adds to it.
- **My `-0024` prediction is retired as falsified by my own arithmetic**, and
  replaced, disclosed in the open (PROTOCOL §10, R-SEAL-1: a forward statement, no
  withheld artefact). Under `uniform ~idles:k`, k ≥ 1, new rule: **lane 0,
  N mod 8 ∈ {0…4}** → one class {16 + 8k}; **lane 0, N mod 8 ∈ {5,6,7}** → two,
  {16, 16 + 8k}, the 16 being the `tlast` word's delivered octets; **lane 4** →
  two, {12 + 8k, 12 + 16k}, verified at N = 64 and predicted at the other
  commissioned lengths. If dv's measurement disagrees anywhere, the disagreement is
  a finding against this ruling and I want it returned with its numbers.
- **Option 2 remains available only as E2.** Narrowing REQ-016 at an XGMII port
  drops commissioned coverage from a countersigned requirement. If the emission
  rule costs more than the org wants to pay, that is the route, and it needs the
  sponsor via the orchestrator — not a spec diff of mine.
- **A generalisation I deliberately did not make.** §0.5's new causality test is
  stated for output events at any module, but I checked its consequences only at
  M03 and by argument (in-band framing) at M06/M08/M14/M17. The three specs owing
  the `-0024` repair (M06 §7/§10, M10 §3/§6.1/§7/§10, M14 §3/§6.1/§7/§10/§11.2)
  owe nothing further from this diff, and that claim is worth a check by whoever
  next opens them.
- All items carried in `J-architect_docs_lead-0024`'s ledger remain open, **C-5
  included**, together with the two re-countersignatures and one concurrence owed
  at `J-architect_docs_lead-0013`'s SHA.

### Files-in-this-commit

- docs/specs/requirements.md
- docs/specs/modules/xgmii_rx_64.md

## [J-architect_docs_lead-0026] 2026-08-04T21:30Z | task:BUG-0002 | dv_lead's F-1 VERIFIED against my own derivation and §6.1 item 2 repaired — the lane-4 split is the non-`tlast` words' arithmetic, the `tlast` word's is its own residue table, and my `-0025` prediction was verified at exactly the one length that hides the error

### Trigger

Orchestrator, relaying dv_lead's countersignature of my `1f3c04c` D(m) ruling
(`J-architect_docs_lead-0025`), transcribed and IN FORCE at `155c9b2`: three
points granted in full, and **one cell REFUSED** — **FINDING F-1** against
§6.1 item 2's lane-4 class cell, returned in the COUNTERSIGNATURE block of
`agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md` at
`a8ca14d` (`J-dv_lead-0086`). Charter §3 and §5: a finding against my own
normative text is repaired as a spec diff, and this one I asked for in terms —
`J-architect_docs_lead-0025`'s Open-questions disclosed the per-lane class
prediction and said *"if dv's measurement disagrees anywhere, the disagreement is
a finding against this ruling and I want it returned with its numbers."* It was.

### Inputs

- `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`
  at `a8ca14d`, COUNTERSIGNATURE block read in full (C-0's closed forms, points
  1–4, F-1 with its offered repair, the "what this signature does not reach"
  list, dv's three declared-false attack-plan cells and its stated prediction).
- `docs/specs/modules/xgmii_rx_64.md` §6.1 (whole), §7's handshake bullet, §8's
  directed-length set, §10's REQ-016 hook, §13's last three rows.
- `docs/specs/requirements.md` §0.5 in full (octet time, front offset h, ΔC,
  gapped stimulus, deciding input word, the causality test, the straddle and
  late-decision bullets, the monitor clause), REQ-005, REQ-011, REQ-016; §13's
  `J-dv_lead-0086` transcription row.
- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` §3, §4, §6, §10.
- My own `J-architect_docs_lead-0024` and `-0025`.

### Reasoning

**1. I re-derived the geometry rather than checking dv's prose, and F-1 is
VERIFIED in every cell.** Start lane ℓ ∈ {0,4}, start word at source cycle s;
received octet j has octet time 8s + ℓ + 8 + j and input word
c(j) = ⌊(8s+ℓ+8+j)/8⌋; N = 8q + r octets between the start and closing
characters; T = ⌊(8s+ℓ+8+N)/8⌋; W = ⌈(N−4)/8⌉ output words; D(m) = c(8m+12)
where N ≥ 8m+13, else T; the uniform wrapper inserts k idles before each of the
source cycles s+2 … T. Two identities do all the work. First, latency in octet
times is **L(octet) = 8·(emit(m) − g(word carrying it)) − 4 or + 4** at lane 4
(bytes 0–3 and 4–7 respectively), so an octet measures **L + 8k′** for the k′
wrapper boundaries strictly between its own input word and the word the emission
is keyed to — item 1's rule, which I had already written and then failed to apply
to item 2. Second, at lane 4 the `tlast` word's octets sit **one** word behind T
at r ∈ {0,1,2,3,5,6,7} and **two** only at r = 4:

- r = 0: N−4 = 8(q−1)+4, so m = q−1 carries **bytes 0–3 only**, in word s+q = T−1
  (T = s+q+1) → **L + 8k**, not the split's L + 16k.
- r ∈ {1,2,3}: m = q−1 carries bytes 0 … r+3; bytes 0–3 in T−1 → L + 8k, and
  bytes 4 … r+3 in **T itself** → k′ = 0 → **L = 12**. Three classes with the
  non-`tlast` words: {12, 12+8k, 12+16k}.
- r = 4: m = q−1 is a **full** word, bytes 0–3 in T−2, bytes 4–7 in T−1 →
  L + 16k and L + 8k. **The one residue at which item 2 was right.**
- r ∈ {5,6,7}: m = q carries r−4 ∈ {1,2,3} octets, all bytes ≤ 3, in
  s+q+1 = T−1 (T = s+q+2) → **L + 8k**.

Seven residues wrong, one right, and the sets are {12, 12+8k, 12+16k} at
r ∈ {1,2,3} against {12+8k, 12+16k} elsewhere. Every number matches dv's table
exactly; I found no cell to dispute. I also re-checked the lane-0 half I was
granted (non-`tlast` 16+8k; `tlast` 16+8k at r ≤ 4 and **16** at r ≥ 5) and it
reproduces, as does C-0's offset table (1 / {1,2} at lane 0, 0 / {0,1} at lane 4).

**2. Why I got it wrong at `-0025`, stated because it is the finding's real
lesson.** My disclosed prediction verified lane 4 **at N = 64**. N = 64 at lane 4
is r = 0 — one of the five residues whose class **set** is unchanged by the
error, because there the `tlast` word contributes L + 8k, a value the non-`tlast`
words already carry. So the one length I checked is precisely the one at which a
wrong per-word description yields a right set. The defect is invisible to
set-counting at five residues of eight and to N = 64 at both lanes. **Verifying a
universal at a single instance chosen for convenience is not verification**, and
the instance I chose was the one the programme's own worked example made cheap.
dv found it by reading my item 3's reasoning back at my item 2 — an internal
consistency check, not a measurement — which is the cheaper method and the one I
should have run on my own diff.

**3. What form the repair takes, and why not dv's offered wording.** F-1 offers:
state the split for the non-`tlast` words, then say the `tlast` word's octets are
"L for those sharing the closing character's word and **the split otherwise**".
That offer is refuted by F-1's own next paragraph: at r = 0 and r ∈ {5,6,7} no
octet shares T, yet those octets measure **L + 8k** and not the split's L + 16k,
because the word they sit in is T−1 rather than T−2. Adopting the offer verbatim
would have re-imported the same class of error one residue-set over. So I took
F-1's **numbers**, which are right in every cell, and wrote the wording myself as
a four-row residue table keyed to *where the octets lie relative to T* — the form
that cannot be got wrong by a reader, because the k′ count is visible in the row.
Rejected alternatives: (a) dv's phrasing verbatim — refuted above; (b) deleting
the split from item 2 and pushing the whole lane-4 story into item 3 — item 3 is
the *survival* verdict and item 2 is the *straddle* derivation, and merging them
would leave §0.5's straddle test with no worked instance at this module; (c) a
per-length table over §8's sixteen directed members — larger, and it would go
stale the moment a length is added, where the residue form is closed.

**4. The universal in the heading was the actual defect and it is gone.** Item 2
was headed "**Every** output word, at a lane-4 start", and that word is what made
the split look like a property of the lane rather than of a full word two input
words behind its evidence. The heading now names the straddle and the residue
table, and the old heading is quoted in place so the diff is legible to a reader
holding the previous revision. I also confirmed the other six "every output word"
occurrences in this spec are each true (D(m)'s uniformity; item 3's keying;
REQ-011's and REQ-014's rows).

**5. Scope: the defect does not reach requirements.md §0.5, and that is derived,
not assumed.** F-1 asserts it and I checked it rather than inheriting it. §0.5's
late-decision bullet says every M03 output word is late-decided (true under this
repair); its straddle bullet is stated over the eight octets of a full output
word and is true of those; its verdict — M03 fails the test at both lanes with no
surviving residue class — is unaffected, since it needs *some* word to fail and
this repair makes more words fail their split, not fewer; its monitor prohibition
is unchanged. Decisively, §0.5 **delegates this detail in terms**: "*at most frame
lengths is a later input word than the one carrying its last delivered octet
(SPEC-M03 §6.1 states the residues)*". The false sentence was homed here. Opening
§0.5 would also have converted a scoped repair into a programme-wide normative
change owing a fresh dv_lead countersignature — the trade the `J-architect_docs_lead-0021`
row already refused for §0.6 on the same reasoning. §7's handshake bullet was
read and needs nothing: it states the withdrawal of the lane-0 carve-out and the
non-survival verdict, both untouched.

**6. Countersignature class — the refusal *is* the review.** This row repairs a
cell dv_lead itself refused, to values dv_lead itself derived, published and
signed in a committed artefact (`a8ca14d`, `J-dv_lead-0086`). A further
countersignature would be dv_lead signing its own derivation back to itself, so
none is owed and the row is **in force on commit** — no "not in force until
transcribed" condition of the `-0025` kind. That standing rests on three
properties I held the repair to and state so they can be checked against the
diff: it departs from F-1's numbers in **no** cell; it moves no rule, no cycle,
no requirement and no interface; and it does not reach programme-wide normative
text. A repair failing any one of the three would owe the signature. What **is**
owed is notification: dv_lead's attack-plan repair (its declared-false M03-I4
cell) may now state the three-class case, and any dispute of a cell of my table
is a **fresh finding**, not an unsigned condition on this row.

### Actions

- `docs/specs/modules/xgmii_rx_64.md` §6.1, "why the per-octet constant does not
  survive", **item 2 only**: heading changed from "Every output word, at a lane-4
  start" to "The straddle at a lane-4 start, and the `tlast` word by residue"
  with the old heading quoted; the split paragraph scoped to **non-`tlast`**
  words and its D(m) leg named; a new paragraph plus **four-row residue table**
  for the `tlast` word (r = 0 → L+8k; r ∈ {1,2,3} → L+8k and **L**;
  r = 4 → L+16k and L+8k, the split; r ∈ {5,6,7} → L+8k), with the
  derivation-1 mirror argument, the class-count consequence
  ({12,20,28} at k = 1 and {12,68,124} at k = 7 at lane-4 lengths **65/66/67**),
  the report-not-assert restatement, and a provenance note recording both
  corrections this item has taken and why F-1's offered wording was declined.
- Same file, **§13**: one new row, dated 2026-08-04, carrying the verification,
  the arithmetic in brief, the no-behaviour-change argument, the
  does-not-reach-§0.5 derivation and the countersignature class.
- Nothing else opened for write. `docs/specs/requirements.md` read, **not**
  edited (Reasoning 5). No `test/**`, no `libs/**`, no `agents/handoffs/**`.

### Evidence

The repair is a derivation, not a measurement, and everything in it is
reproducible **by hand** at this SHA from the closed forms in Reasoning 1 — no
script was written and none is cited (PROTOCOL §4.1; ADR-0003/F5 does not arise,
as no ephemeral artefact was produced). Worked instances a reader can re-check
in under a minute each, all at lane 4 under `uniform ~idles:k`:

- **N = 65 (r = 1), k = 1**: q = 8, T = s+9, W = 8, `tlast` word m = 7 carries 5
  octets; bytes 0–3 in s+8 = T−1 → 8·((1+1)+1) − 4 = **20**; byte 4 in s+9 = T →
  8·1 + 4 = **12**; non-`tlast` words → **28** and **20**. Set **{12, 20, 28}**,
  three classes where item 2 predicted two. Same at 66 and 67. At k = 7:
  **{12, 68, 124}**.
- **N = 64 (r = 0), k = 1**: `tlast` word carries bytes 0–3 only, in T−1 → **20**;
  set **{20, 28}** — two classes, which is why my `-0025` check passed here.
- **N = 68 (r = 4), k = 1**: `tlast` word is full, bytes 0–3 in T−2 → **28**,
  bytes 4–7 in T−1 → **20**; the split, and the one residue item 2 had right.
- **Lane 0 control, N = 69, k = 1**: `tlast` word's single octet shares T →
  **16**, others **24** — §6.1 item 1's existing worked example, unchanged by
  this diff, confirming the repair touched no lane-0 statement.

Repository-level checks actually run at this SHA:
`grep -rn "16k" docs/ --include=*.md` → the split figures appear **only** in
§6.1 item 2 and in §13's rows, so no other section restates the corrected
scope; `grep -n "[Ee]very.\{0,3\}output word" docs/specs/modules/xgmii_rx_64.md`
→ 7 hits, each re-read and each true after the repair.

### Outcome

**DoD met.** F-1 is ruled **VERIFIED** and repaired at its single site. §6.1 item
2 no longer contains a false universal; the `tlast` word's lane-4 arithmetic is
stated per residue; §13 carries the row with its countersignature class. No RTL,
no test and no requirement moves, and no gapless or injected cycle this
specification pins changes at any k — the repair is a description of values that
were already what a conformant design produced and that §0.5 forbids asserting.
Handoff: orchestrator, for commit under `Agent: architect_docs_lead`,
`Work-Order: BUG-0002`, and for relay of the notification in Reasoning 6 to
dv_lead.

### Open-questions

- **One observation returned to dv_lead, not a finding against its signature.**
  The COUNTERSIGNATURE block's scope note says its two tables are stated for
  frames with at least two output words and that "*a single-word frame has one
  class trivially at either lane*". That is true at lane 0 and **false at lane 4**
  whenever the single output word carries more than four octets: N = 9, 10 or 11
  gives W = 1 with bytes 0–3 at 12 + 8k and bytes 4 … r+3 at 12, and N = 12 gives
  the full split 12+16k / 12+8k in one word. It costs the countersignature
  nothing — the tables it scopes are unaffected — but a bench reading that
  sentence would expect one class from a runt that produces two. My repaired
  table is stated for **every** length delivering at least one octet, so this
  spec does not inherit the gap; the note is for dv's own attack-plan repair.
- **A §0.5 phrasing I looked at and deliberately did not touch.** The straddle
  bullet says "where h is not a multiple of 8, *every* output word is assembled
  from two input words". Read against its own antecedent (it names the eight
  octets T+h+8m … +7) that is a statement about **full** words and is true; read
  loose it is the same universal item 2 just lost, and a `tlast` word of four or
  fewer octets at a lane-4 start lies in one input word. No verdict in §0.5
  depends on it, so it is not a defect and I did not widen this round to it —
  but the next commit that opens §0.5 for its own reasons should scope that
  clause to full words, and it will owe dv_lead's countersignature when it does.
- **The `-0025` prediction is now partly refuted by its own terms and I record
  that against myself.** Its lane-4 cell predicted two classes at every
  commissioned length; that holds at five residues and fails at r ∈ {1,2,3}
  (lengths 65/66/67), which are in §8's directed set. The lane-0 cells stand.
- All items carried in `J-architect_docs_lead-0025`'s ledger remain open,
  unchanged and uncounted here, together with the two re-countersignatures and
  one concurrence owed at `J-architect_docs_lead-0013`'s SHA.

### Files-in-this-commit

- docs/specs/modules/xgmii_rx_64.md

## [J-architect_docs_lead-0027] 2026-08-04T23:05Z | task:none | The closure-record age skew landed in SPEC-M03 §9 as guidance and nothing else — the lightest row this log has, because §6.3 item 2 is exactly what a normative version of it would have retracted

### Trigger

Orchestrator, routing rtl_lead's `J-rtl_lead-0010` escalation 3 under dv_lead's
disposition of it in `RV-0060-VERDICT` §7 at `2b10741`: the closure-record age
skew is a general trap for future consumers and SPEC-M03 §9 should carry a note.
dv_lead ruled the routing YES and attached one condition it is entitled to attach
as testability countersigner — the note lands **explicitly non-normative and not
a DV observable**. Charter §3: a trap found by building against a specification
is spec-side work, and this one is mine to home.

### Inputs

- `agents/handoffs/WO-0060_tb-m03-family-i-dm-rebase.md` §7 (`RV-0060-VERDICT`,
  the ruling and its condition, including the REQ-019 sentence dv names as the
  form to imitate and the "*owes me no countersignature*" clause) and §8.
- `agents/journals/claude_rtl_lead_agent.md`, `J-rtl_lead-0010` in full — the
  **second** root cause (the record decoded from this cycle's XGMII word while
  that word's octets reach the emission decision one cycle later), the
  `ev12` / `closure_aligned` / `decided` mechanism, the k-table whose word-7
  entries are 19 and 67, and the seven-case gapless argument.
- `agents/journals/claude_dv_lead_agent.v02.md`, `J-dv_lead-0089` Evidence 6 —
  the measured lane-0 cycles at k = 1 and k = 7, and the counterfactual
  ("*a hold without `closure_aligned` gives 18 and 66*").
- `docs/specs/modules/xgmii_rx_64.md` §6.3 (whole, item 2 and item 5 closely),
  §9 (whole), §12, §13's last three rows.
- `docs/specs/requirements.md` REQ-019's payload-storage sentence (the
  guidance-not-observable precedent, quoted by dv).
- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` §4, §6.
- **Not opened**: `libs/**` (rtl_lead is concurrently in it on BUG-0003 —
  disjoint lane, and its in-flight state is none of this round's evidence),
  `test/**`, `docs/reports/audit/**`.

### Reasoning

**1. What is true, and how much of it is this specification's business.** The
fact is not in doubt and I verified it against §9's own text rather than against
rtl_lead's prose: §9's closure list makes the frame open until the earliest of
its closure events, and clause (a) — ruled at `J-architect_docs_lead-0011` —
evaluates each such event at **its own octet time**. An implementation that turns
that list into a *record* therefore captures it when the closing character is
decoded, which is one cycle before that same word's octets have travelled through
the alignment stage to the emission decision. The skew is a **consequence of a
normative clause meeting an unconstrained implementation choice**, and that is
precisely the shape of thing that must not be written normatively: the clause is
already stated, and the choice is §6.3 item 2's to make.

**2. Why the condition is right, and not merely accepted.** dv's argument is that
a normative §9 sentence about how a consumer must read the closure record would
constrain "the placement of the two register levels … and every internal
encoding", which §6.3 item 2 declares unconstrained, and would commission a test
whose object — the age of an internal record — is not this module's observable.
I agree, and I would add the reason from my own side of the table: the one-cycle
figure is **not a property of M03**. It is a property of where `fafb83d` decodes
closure. An implementation that decodes it after the alignment stage has no skew;
one that decodes it two stages early has two cycles. A normative sentence would
have to pick one of those and would thereby specify the pipeline — the exact
retraction of item 2. So the note says the number and immediately disclaims it as
the decode placement's rather than the specification's. That sentence is the
whole load-bearing difference between guidance and a rule.

**3. Where it goes, and why not at the end of §9.** I homed it immediately after
the closure-list block — after the (a)/(b) paragraph, before "**Strobe cycle,
pinned**" — and not at the end of the section. The trap is unintelligible apart
from clause (a): "the record is born at age 0 on the closing character's own
input word" is a *consequence* of evaluating the event at its own octet time, and
a reader who meets the note eight paragraphs later has to walk back to find out
why. End-of-section placement would have bought tidier segregation of
non-normative text at the price of separating the note from the only sentence
that explains it, and §9 is a section whose later paragraphs already refer
backwards ("the closure list above"), all of which stay true across the
insertion. The segregation is bought instead with marking: the opening clause,
an italic sentence that constrains nothing and asserts nothing, and a closing
sentence returning §6.3 item 2 unamended.

**4. The §13 class — the lightest in this log, and I will name why it is lighter
than "editorial".** My existing rows run: behavioural-under-ADR (`ADR-0014`),
forced correction of false normative text (`-0024`, `-0026`), clarification that
moves no normative sentence (`-0021`, `-0023`), and editorial (`-0005`). This one
sits below all of them. An **editorial** row repairs text that was being read
normatively — the reading changes, even if no design does. This row adds text
that is normative **nowhere**: no SHALL, no sentence moved, no cycle pinned, no
requirement or REQ hook added or amended, no `Interface` field touched, no test
commissioned, no ledger item closed, and §6.3 item 2 stands byte-unchanged. The
class is **non-normative guidance**, and the honest test for it is that deleting
the paragraph would leave every conformant design, every committed test and every
requirement exactly as they are — which is true here and is false of every other
row in the table.

**5. Countersignature: none owed, and I record why rather than inferring it.**
dv wrote it in terms — "*as guidance it costs nothing and owes me no
countersignature*" — and the reason it holds is that the test-derivation basis
(PROTOCOL §10) is untouched: DV derives tests from REQ-### and from normative
spec text, and this paragraph is neither. The conditional half of dv's ruling is
recorded in the §13 row so that a later editor who promotes the note to normative
text knows the promotion is a fresh change owing a narrow countersignature, not a
formatting decision.

**6. What I deliberately did not do.** I did not touch `docs/specs/requirements.md`
— the trap has no programme-wide normative statement to make, and §0.5/§0.6 say
nothing that this contradicts. I did not add a §6.3 item: item 2 already covers
the case, and a ninth item would imply the carve-out needed widening when the
point is that it did not. I did not add a §10 hook or a §11 item; there is nothing
to verify and nothing deferred.

### Actions

- `docs/specs/modules/xgmii_rx_64.md` §9: one paragraph inserted after the
  closure-list (a)/(b) block and before "**Strobe cycle, pinned**" — the
  non-normative note, marked as such twice (opening clause and italic
  no-assertion sentence), stating the mechanism, the alignment-corrected view
  (`closure_aligned`: age ≥ 1 at offset 0, age 0 admitted at offset 4), the
  measured 19/67-against-18/66 discriminator, and the disclaimer that the
  one-cycle figure belongs to the decode placement. Cites `J-rtl_lead-0010`,
  `J-dv_lead-0089` / `RV-0060-VERDICT` §7, §6.3 item 2, REQ-019's precedent and
  REQ-016.
- `docs/specs/modules/xgmii_rx_64.md` §13: one row, `Breaking?` **no**, ADR
  **none**, carrying the class argument of Reasoning §4 and dv's condition.
- No other file opened for writing. No git command run (PROTOCOL §2).

### Evidence

All commands run from a checkout at this commit's SHA, repo root.

1. `git status --porcelain` → `M docs/specs/modules/xgmii_rx_64.md` — **one
   file**, no `libs/**`, no `test/**`, no `agents/**` but this journal.
2. `grep -n "A note for a future consumer" docs/specs/modules/xgmii_rx_64.md`
   → `974`; `grep -n "^\*\*Strobe cycle, pinned" …` → `1011`. The note occupies
   974–1009 and sits **after** the closure list (952–972) and **before** the
   strobe pin, as Actions states.
3. `sed -n '974,1010p' docs/specs/modules/xgmii_rx_64.md | grep -c "SHALL"`
   → **0**. The note contains no normative modal.
4. `grep -c "closure_aligned" docs/specs/modules/xgmii_rx_64.md` → **2** (the
   note and the §13 row).
5. `grep -c "^| 2026-08-0" docs/specs/modules/xgmii_rx_64.md` → **20** §13 rows,
   one more than at HEAD.
6. Unchanged-by-construction check: `git diff` touches only §9's insertion point
   and §13's tail, so §4's `Interface` records are byte-unchanged and §12's
   `ifc_check` evidence (CI run **30729342467**, SHA **f78766e**) still witnesses
   this revision's interface — §13's preamble claim holds.
7. **No CI is owed or claimed.** One markdown file plus this journal; no OCaml,
   no dune, no workflow, no script. Nothing goes red or green by this diff, and
   the note commissions nothing that could.

### Outcome

**DoD met.** The trap is on the record where a future consumer of an internal
closure record will meet it, in the only form dv_lead's testability role permits
and I judge correct: guidance, marked twice, disclaiming its own number. §6.3
item 2 is unamended, no requirement moves, no countersignature is owed, and no
committed test changes meaning. rtl_lead's escalation 3 is **discharged**.

**Handoff**: orchestrator, for commit under `Agent: architect_docs_lead`,
`Work-Order: none`.

### Open-questions

- **rtl_lead and dv_lead are owed notification, not signature.** rtl_lead's
  escalation 3 is discharged and the note names `closure_aligned` by its landed
  identifier; if BUG-0003's lane-4 work renames or relocates that view, the note
  should follow it — a one-line §9 edit and a §13 row of this same lightest
  class, not a re-ruling. dv_lead is owed nothing here beyond knowing its
  condition was met in terms.
- **The promotion path is deliberately left open and deliberately priced.** If
  the org ever wants a *normative* statement about how a consumer reads a closure
  record, it is a fresh change owing dv_lead's narrow countersignature on that
  sentence alone (`RV-0060-VERDICT` §7), and it would have to amend §6.3 item 2
  in the same diff or contradict it. Recorded so the promotion is not made by an
  editor who reads the note as a rule already half-written.
- Carried unchanged from `J-architect_docs_lead-0026`: every item of that entry's
  ledger, none of which this round touches or advances — including the two
  re-countersignatures and one concurrence owed at `J-architect_docs_lead-0013`'s
  SHA, C-5's still-owed §0.6 repair, and the M03 RTL non-conformance against §9
  ruling 9.

### Files-in-this-commit

- docs/specs/modules/xgmii_rx_64.md

## [J-architect_docs_lead-0028] 2026-08-04T23:55Z | task:none | The cross-project tier gets a clock — ADR-0018 accepted on the sponsor's own sentence, its bar written to be refusable, and the gate hook landed as a new file because both existing gates are closed

### Trigger

Orchestrator dispatch relaying the sponsor's direction verbatim: the
lessons-harvest practice is to become *"not a one time thing we do but something
we continually do... build this into our general philosophy."* The dispatch
carried the sponsor-approved shape (per-`SO-`/per-gate self-mining, three
refusable criteria, orchestrator collation locally and into the generic shell's
`LESSONS` file, one shell commit per harvest, sponsor-visible at the gate) and
asked for three things: the ADR, the exact PROTOCOL diff for transcription, and a
gate-checklist hook.

### Inputs

- `agents/charters/architect_docs_lead.md` (§3 ADRs, §7 escalation, §8 ADR
  coupling); `agents/PROTOCOL.md` (§3 packets, §4 journals, §6 write scopes, §7
  gates + transcription, §10 R-SEAL-1, §11 amendment procedure).
- `docs/adr/ADR-0016-a-seal-is-a-file-or-it-is-not-a-seal.md` §2.3 (forward
  commitment), §6.3 (why advisory), §8 (the amendment mechanic and its refusal
  history) — the governing precedent for deliverable 2.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` header block and §1.1
  (the 2,131,151-byte / 249-entry corpus measurement), §8 (diff-not-applied
  formatting).
- `docs/gates/G0-checklist.md` (PASSED 2026-08-01) and
  `docs/gates/P1-spec-freeze-checklist.md` (CLOSED 2026-08-02T16:53Z, sponsor
  signature transcribed) — the two committed gate files, both closed.
- `tasks/BOARD.md` lines 152–154 (the 2026-08-01 deferred intent: extract the
  generic workflow at program end from accumulated ADRs/journals).
- `agents/journals/claude_orchestrator_agent.md` `J-orchestrator-0144` (the sole
  `L-D15` citation, "just woven into my own shell charter") and
  `J-orchestrator-0146` (the generic shell exists and carries proven chain code).
- My own volume-02 tail through `J-architect_docs_lead-0027` for the carried
  ledger.

### Reasoning

The dispatch handed me the practice; what it did not hand me was the wording, and
this entry records the five places where the wording was a decision rather than a
transcription. I am deliberately **not** restating the ADR here (charter §8's
vacuity clause) — §§1–12 of the file say what the practice is. What follows is how
it came to be asked in this shape and what I chose against.

**1. The question the sponsor was actually answering.** The org already turns
incidents into binding rules within hours: R-SEAL-1, ADR-0017's R10/R11, the fifty
carry-forward rows, the seal rule minted mid-adjudication at WO-0055. That tier
works and nobody complained about it. So the directive is not "start learning" —
it is "the *other* tier has never run", and the evidence is a one-line grep: over
`agents/`, `docs/` and `tasks/`, the pattern `L-[A-Z]{1,3}[0-9]{1,3}` matches
**once**, at `L-D15`, inside an orchestrator entry. Eighteen ADRs, fifty ledger
rows, a quarter-million words, and one exported lesson. Framing the ADR around
*two tiers, one of which has no clock* — rather than around "we should capture
lessons", which would have been true and useless — is what made the rest of the
document decide anything. It also settles what the ADR must **not** do: touch the
accretion tier. §1.1 is a description, and I say so in §12 so a later reader does
not take it as a re-ratification of rules it merely lists.

**2. Why the bar's three criteria are written to be *operationally* refusable, and
LH2 twice.** The dispatch gave me the three criteria in substance (provenance,
generality, stated failure). A criterion that cannot be failed at a table is not a
criterion, and the failure mode I could see coming is LH2: "state it generally" is
the kind of instruction everyone agrees with and nobody can adjudicate. So LH2
carries a **mechanical first test** — the *rule statement* contains no proper noun
of this program (no `M03`, no `REQ-###`, no `C-nn`, no signal, no XGMII/ITCH, no
toolchain) — which a transcriber can run against a line of text without
interpreting anything, and which is exactly the sponsor's standing generality
guard for the shell made checkable. And because a mechanical noun test invites the
obvious attack (swap the nouns for placeholders and ship the same project-specific
rule), it carries a **second test aimed at the attack**: hide the provenance and
read the statement; if it now says nothing, the nouns were carrying the meaning.
That pair is the part of this document I expect to earn its keep. The corollary I
made explicit rather than leaving to taste: the project-specific detail is not
banned, it is **relocated** — into LH1's citation, where it belongs, so LH1 and LH2
are complementary rather than in tension.

**3. War stories are kept, and a bar nothing fails is reported as a defect.** The
dispatch's word was "refusable"; the risk is that refusal becomes theatre in the
other direction — everything passes, and the shell fills with preferences. Two
counterweights, both cheap: a nil yield is **explicitly legitimate** (so there is
no pressure to mint), and an empty war-stories section at *every* round is stated
as a signal about the bar rather than about the span. I also declined to make war
stories disposable. A candidate that fails LH2 at its first incident often passes
at its second, because the second provenance is what shows which half of the
statement was project-specific; deleting the pile would throw away the only input
to that comparison. Guidance, not law — I did not want to create an obligation on
anyone to periodically re-read a growing heap.

**4. Extending past the sponsor's floor, and flagging it as mine.** The dispatch
said "each LEAD". I extended to every persistent journal chain — leads, auditor,
orchestrator — and the deciding fact is embarrassing in the right way: the single
lesson id this program has ever exported was mined out of an **orchestrator**
entry. A rule that exempts the orchestrator exempts the only proven source. The
auditor's journal is the second obvious case, because its subject matter *is* the
process, which is what a shell contains. But the sponsor said leads and I am not
entitled to silently widen a directive, so the extension is marked as this ADR's
own decision in §3.3, argued in §11 item 8 as a rejected alternative
("mine only the leads"), and therefore refusable on its own without touching the
rest. Workers get the opposite treatment for a structural reason rather than a
judgment one: their journals are shared per template with per-spawn entries, so
there is no continuous identity to hold "the span since my last harvest" — the
commissioning lead mines those spans and names the spawn short-ids.

**5. The span is an interval, and that is the whole enforcement story.** The one
thing a review-enforced practice needs is for **skipping** to be visible, and I did
not want to buy that with a script (§7.4's argument, which is ADR-0016 §6.3's
argument reused: counting harvests cannot distinguish a harvest from a shrug, and
counting creates the incentive the bar exists to remove). Stating each span as an
entry-id interval makes consecutive harvests **tile**: a gap between one harvest's
end and the next one's start is arithmetic, not judgment, and it is visible to a
reader of the gate record without anyone re-reading a journal. That single
choice is what let me refuse `R12` in good conscience rather than as timidity.
It also disposes of retroactive harvesting for free: because every agent's first
span opens at its first entry, the two closed gates' spans are covered at the next
harvest and nothing needs reopening.

**6. The hook: a new file, and why not an edit.** The dispatch anticipated this
and it landed on the anticipated branch. `docs/gates/` holds exactly two files and
**both are closed** — G0 PASSED 2026-08-01, P1-spec-freeze CLOSED 2026-08-02 with
the sponsor's verbatim signature transcribed above the sign-off list. A harvest box
added to either lands unchecked (retroactively un-passing a gate the sponsor
signed, on evidence that is complete) or pre-checked (recording a harvest nobody
ran). Both are worse than a third file. So `docs/gates/lessons-harvest-block.md` is
an **addition** to the directory, not an edit to a closed gate: a template that
never records anything itself, instantiated verbatim by the next checklist
(`P1-module-ready`, which does not exist yet and will be authored with it) and by
every `SO-` sign-off section. I put the instantiation instructions, the short-form
bar, and the transcriber's notes in the same file rather than pointing at the ADR,
because the person filling it in at a gate is not the person who read ADR-0018 —
and I put the normative pointer at the top so the copy cannot drift into being the
authority.

**7. The PROTOCOL half — mechanic, placement, and what I did not write.** ADR-0016
§8 settled the mechanic by refusal (`R7` bounced the architect staging
`agents/PROTOCOL.md`, and the right answer was that there is no ADR-driven
exception to the constitution's write scope). So §8 of this ADR is the authority
and the edit is clerical, formatted as ADR-0017 §8 formats an unapplied diff.
Placement was a real choice: §7 (Gates) over §3 (Packets) even though half the
trigger is an `SO-` packet, because §7 is where a gate's preconditions live, §7
already states the transcription rule the collation reuses, and one hunk that
*names* `SO-` reaches the packet case without a second hunk that would then need
keeping in sync — the maintenance hazard ADR-0016 §8.2 names for its own signpost.
I wrote **one** addition, no cross-reference in §3, for exactly that reason. And I
recorded in the diff itself that §11(3) owes no test case, because nothing about
enforcement semantics moves — no `R`-rule, no path scope, no journal grammar
field — so a future reader does not go looking for the missing
`scripts/test_protocol.sh` scenario and conclude it was forgotten.

**8. One collision, disposed rather than discovered.** "Harvest" already means
something in this repo — the mutation-campaign and promotion-block sense
(`J-orchestrator-0106`, the family-G board row). I kept the sponsor's word because
it is the sponsor's word, and paid for it with a naming rule (§7.5): the new sense
is always "lessons harvest", the bare word keeps its old meaning. Same treatment
for ids — `LC-` and `LH1`–`LH3` are new and collide with nothing (`R`, `C-`,
`REQ-`, `AUD-`, `SO-`, `X-` untouched), and I explicitly declined to define the
shell's `L-` scheme, which is the shell's: legislating a file format for a repo
this one does not own would have been the easiest overreach in the document.

**9. What I did not do.** No charter edit (orchestrator scope, R7 — the exact text
is supplied in §6 item 3 so the transcription is mechanical). No `tasks/BOARD.md`
edit (same, text supplied in §10). No `agents/PROTOCOL.md` edit. No new `R`-rule
and no script. No retro-harvest ordered against the closed gates. No touch of
`agents/handoffs/WO-0061*`, any dv artefact, `test/**` or any spec — dv_lead is
mid-adjudication in a disjoint lane and this round shares no file with it.

### Actions

- Wrote `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md` — ACCEPTED on
  the sponsor's direction, quoted in the Status block as the acceptance authority;
  §8 carries the unapplied PROTOCOL §7 hunk for orchestrator transcription; §9
  states the checklist hook's landing site and the closed-gate argument.
- Wrote `docs/gates/lessons-harvest-block.md` — the reusable, never-signed gate
  block: instantiation procedure, short-form bar, the copyable block (span table,
  yield table, war-stories table, eight checkboxes), transcriber's notes.
- No other file opened for writing. No git command run (PROTOCOL §2).

### Evidence

All commands run from a checkout at this commit's SHA, repo root.

1. `git status --porcelain` → `?? docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md`,
   `?? docs/gates/lessons-harvest-block.md`, `M agents/journals/claude_architect_docs_lead_agent.v02.md`
   — **two new files** plus this journal. No `agents/PROTOCOL.md`, no
   `agents/charters/`, no `tasks/`, no `test/**`, no `libs/**`, no
   `agents/handoffs/`.
2. The §1.2 measurement, and the honesty correction it needed. At this commit's
   parent, `grep -rnoE "L-[A-Z]{1,3}[0-9]{1,3}" agents/ docs/ tasks/ | awk -F: '{print $NF}' | sort | uniq -c`
   → `1 L-D15`. **At this commit the same command counts higher** — the ADR and
   this entry now cite the id themselves, so the raw count does not reproduce and
   is not stable under its own edits; the ADR's §1.2 block states both readings
   rather than the first one only, and gives no number for the polluted one.
   The substantive count is unchanged and is the reproducing form:
   `grep -rl "L-D15" agents/journals/ | grep -v architect_docs_lead` →
   `agents/journals/claude_orchestrator_agent.md`, one file, one occurrence.
   Caught twice by running the claim rather than by writing it — the first
   correction still counted the ADR itself, because the ADR's filename does not
   contain the excluded string. The scoped form is also the right claim: the
   assertion is about the journal corpus.
3. Both gate files are closed, quoted in ADR §9 from the committed text:
   `grep -n "G0: PASSED" docs/gates/G0-checklist.md` → hit;
   `grep -n "P1-spec-freeze: CLOSED" docs/gates/P1-spec-freeze-checklist.md` → hit.
   Neither file is in this commit — `git status` (1) is the check.
4. The ADR's §8 anchor is live text: `sed -n '264,266p' agents/PROTOCOL.md` is the
   "Phase hardening" paragraph the diff's context lines quote, and line 267 is
   blank, line 268 is `## 8. Escalation to the human sponsor` — so the hunk
   applies at the end of §7 as stated.
5. Corpus figure in §1.3 item 2 is quoted, not recomputed: 2,131,151 bytes / 249
   entries is ADR-0017 §1.1's table total, cited as such and stale-by-design (it
   predates two volumes and every bench).
6. **No CI is owed or claimed.** Two markdown files plus this journal; no OCaml,
   no dune, no workflow, no script, no `Interface` record. Nothing goes red or
   green by this diff, and neither file commissions a test.
7. **Scope self-check against my own rule**: the ADR's §8 hunk and §6 item 3's
   charter text are *quoted*, not applied — grep confirms the strings exist only
   inside `docs/adr/` at this SHA:
   `grep -rn "Lessons harvest\*\* (ADR-0018)" agents/` → no hits.

### Outcome

**DoD met.** Three deliverables, two files, nothing outside `docs/`.

- **The ADR** is ACCEPTED on the sponsor's quoted sentence, which is named as the
  acceptance authority rather than paraphrased into one — the practice is his, the
  wording of the bar and the span discipline are mine, and §3.3/§11(8) mark the one
  place I widened his shape so he can put it back without disturbing anything else.
- **The PROTOCOL diff** is written and **not applied**: one addition at the end of
  §7, per ADR-0016 §8's mechanic, with `§11(3) owes no test case` stated inside the
  hunk so its absence reads as a decision.
- **The gate hook** lands as a **new** file in `docs/gates/`, not an edit — both
  committed gates are closed and signed, and the ADR §9 states that on the record.
  Nothing in this commit can un-pass a passed gate.

**Handoff**: orchestrator, for commit under `Agent: architect_docs_lead`,
`Work-Order: none`; then the §8 transcription under its own identity and entry.

### Open-questions

- **Owed, orchestrator-scope, texts already supplied** (none of it is mine to
  stage): (a) the PROTOCOL §7 hunk of ADR-0018 §8; (b) the five charter §8
  harvest-note clauses of §6 item 3 — `architect_docs_lead`, `rtl_lead`,
  `dv_lead`, `auditor`, `orchestrator`, plus `rtl_lead_md` when it is activated;
  (c) the `tasks/BOARD.md` 2026-08-01 deferred-intent line's superseded-as-to-
  cadence clause of §10. **(b) and (c) landing without (a) is the ADR-0016 §8.2
  failure shape** — a pointer to a rule that lives nowhere — so (a) goes first or
  they go together.
- **`P1-module-ready`'s checklist does not exist yet**, and it is the first
  instantiation of the block. Whoever authors it should copy §3 of
  `lessons-harvest-block.md` verbatim rather than paraphrase; a paraphrased block
  is a second site that drifts, which is the hazard ADR-0016 §8.2 names.
- **The first harvest will test the bar, not the practice.** My prediction, on the
  record so it can be scored: the criterion that bites is LH2, and the first
  refusals will be candidates that are true, useful and unstatable without a
  module name. If the first harvest refuses nothing, §3.5's last sentence applies
  to the bar, not to the span.
- **Undecided by design** (ADR §12): the shell's `L-` scheme and `LESSONS` format;
  what a sponsor refusal converts a candidate into; whether a nil-yield harvest is
  itself an auditor finding shape; retroactive promotion of war stories beyond the
  stated re-offer path.
- Carried unchanged from `J-architect_docs_lead-0027`: every item of that entry's
  ledger, none of which this round touches or advances — the `closure_aligned`
  rename-follows-it note, the deliberately-open promotion path for a normative
  closure-record statement, and through it the whole `-0026` ledger, including the
  two re-countersignatures and one concurrence owed at `J-architect_docs_lead-0013`'s
  SHA, C-5's still-owed §0.6 repair, and the M03 RTL non-conformance against §9
  ruling 9.

### Files-in-this-commit

- docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md
- docs/gates/lessons-harvest-block.md

## [J-architect_docs_lead-0029] 2026-08-05T01:20Z | task:none | ADR-0018 amended with the sponsor's domain tier — LH2 splits into two grades, and the paraphrase test that refuses a fake generalisation turns out to be the same test that certifies an honest domain rule

### Trigger

Sponsor direction relayed by the orchestrator, extending the taxonomy ADR-0018
assumed: three tiers — general, **domain**, project-specific — with the domain
tier defined as *"portable across projects that share a technical domain but
unstatable without domain vocabulary"*, the example being this program's
Ethernet/networking lessons serving a future 25G NIC, and the shell knowing *"to
pull them in only if relevant."* A second relay fixed the numbering (1 general,
2 domain, 3 project-specific) and supplied the federation pipeline shape for the
parked note. Scoped amendment round; no work order.

**Round interrupted mid-flight by an API error** after the ADR edits and the
first three block edits had landed. The orchestrator's recovery message told me
to verify rather than assume, which I did before writing anything further —
`git status --porcelain` and `git diff --numstat`, recorded in Evidence. Nothing
was re-applied and nothing was lost; the remaining work was §1's id instruction,
§2's tier preamble and the spans table, all of which were still two-way.

### Inputs

- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` (§7's lessons-
  harvest paragraph live at `:268-286`, §6 write scopes, §11 amendment procedure).
- `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md` at `ec5d906` — the
  whole of it, §3.4 (the bar), §4.3 (ids), §7.3 (the paraphrase attack), §8 (the
  PROTOCOL hunk), §9 (the block), §10 (the "no collisions" claim), §12.
- `docs/gates/lessons-harvest-block.md` at `ec5d906`.
- `docs/adr/ADR-0003-aud-0001-disposition.md:142` — the "Corrections after …"
  section, which is the amendment form this org already uses and the one I
  followed rather than inventing a second.
- `J-architect_docs_lead-0028`'s Open-questions — the prediction the sponsor
  cited, and the three owed-to-orchestrator items whose status A1.7 restates.
- `agents/journals/claude_orchestrator_agent.md` via §1.2's `L-D15` grep, for the
  id near-collision check.

### Reasoning

**1. A grade split inside LH2, not a fourth criterion.** The obvious alternative
was `LH4 — domain-portable`, sitting alongside LH1–LH3. Rejected on two grounds,
one aesthetic and one countable. A fourth criterion would have to be *conditional
on another criterion failing* ("LH4 applies only where LH2 does not"), which is a
decision tree wearing a checklist's clothes and reads as a bar with an escape
hatch bolted on. The truth is simpler and the split says it: there is **one**
portability criterion with **two thresholds and one destination each**. The
countable ground decided it: charters say *"candidates with LH1–LH3 discharged"*,
and `agents/charters/**` is orchestrator-scope. An `LH4` makes **five charter
edits owed**; a grade inside LH2 makes **zero**, because the grades live under
the name the charters already cite. Given that §8's hunk took a full round to get
transcribed, minting five more owed edits to say the same thing would have been a
poor trade.

**2. The domain noun is defined by a test, with the lists as examples.** An
exhaustive list of admissible nouns is gameable and *will* be gamed at the
boundary — toolchain and library names are the live case, since "Hardcaml" is a
domain noun when the pack is that ecosystem and a project noun when what it
actually carries is our lane and pin (ADR-0004's subject, portable to nobody). So
A1.2 states the discriminator — *would a different project, different agents,
same domain, use this noun without learning anything about this program?* — and
demotes the lists to illustration. A list that has to be exhaustive is a list
that will be argued with in bad faith; a test can be argued with in good faith,
which is what §3.4 was already trying to buy with "deliberately mechanical enough
to argue with".

**3. The find of the round, and I did not engineer it.** The question was whether
LH2-d should be reachable directly or only through a failed general statement. I
wanted only-through, because a discount available on request is one every miner
takes first — the cheapest path for a tired agent is to reach for the domain noun
and skip the generalisation. What I did not expect is that the enforcement
mechanism was already written: **§7.3's paraphrase test is the routing
mechanism.** Attempt the general statement; hide its provenance; if it survives,
the candidate is general and the domain noun was decoration; if it goes hollow,
the hollowness *is the evidence* that the domain noun was load-bearing, and that
is exactly the finding that routes it to tier 2. **The same test that refuses a
fake generalisation certifies an honest domain rule.** §7.3 was written against
an attack; it turns out to be a classifier, and A1.3's tie-break just names what
it was already doing. This is why the classifier is stated as a procedure with
step 0 non-optional rather than as a definition: the ordering is the whole
guarantee.

**4. Tier 3 needed a fork, and finding that out was a correction, not an
addition.** The sponsor's tier 3 *"rewrites the local project's doctrines but
never leaves it"* — that is **adoption**, not filing. But §3.5 gave failures
exactly one outcome, "war story", and §1.1 described the accretion tier as
something this ADR *does not touch*. Read together, those two were never
connected: §1.1's accretion tier **was tier 3 all along** and §3.5 never routed
anything into it. So A1.3.1 states the fork — war story (binds nowhere,
re-offerable) versus local accretion (adopted here by its own ADR / `C-` row /
`R-` rule / spec clause) — on one question, *does this project want the rule?*
Two guards against this becoming a new obligation: the note **records** the
choice, and the adoption itself is a separate artefact in a separate commit under
the tier's existing instruments. Nothing here obliges anyone to adopt anything.

**5. The honest half of A1.3.2 — the amendment does not do all the framing
suggests.** The prediction the sponsor cited says *"unstatable without a module
name"*, and a module id is a **project** noun, barred in both grades. So I split
the predicted class three ways rather than claiming the rescue wholesale:
domain-noun candidates are rescued; module-id candidates are **not**, before or
after; and the interesting middle is candidates unstatable without the module's
**role** — *the block that terminates a frame*, *the stage that realigns a
message across a word boundary* — where a role is a domain noun and step 0's
rewrite converts the refusal into a tier-2 pass. I asked the note to **count**
that third case, because without the count the amendment is unscoreable, and an
unscoreable amendment to a bar is how a bar softens without anyone deciding to
soften it. Citation corrected in passing: the prediction is at
`J-architect_docs_lead-0028`'s Open-questions, not at the ADR's §11, which is
Alternatives.

**6. Recording the federation shape rather than only the question.** The dispatch
said *recorded, not decided*, and the second relay supplied a sketch. I recorded
both, with `Nothing in this sub-item is in force` stated in the ADR, because the
alternative failure is worse in each direction: a parked question with **no**
shape is one the next reader re-opens from scratch and re-derives badly, while a
shape recorded **without** the not-in-force marker hardens into policy by being
read twice. Two substantive points inside it are worth flagging as the ones a
future decision should not lose:
- **(a) is a security argument, not a quality one.** The shell's `LESSONS` is
  constitution-adjacent text that future agents obey, so a foreign contribution
  is a **prompt-injection surface**; an agent reviewer is precisely the wrong last
  line against an input written to address agent reviewers. The merge stays human,
  which is the same shape as sponsor-signed gates: machinery prepares, a human
  admits. I agree with it and still recorded it as parked, because it is the
  sponsor's to decide and my agreement is not a ratification.
- **(b) substitutes LH1's mechanism while preserving LH1's test** — *a reader of
  the description* can see the thing going wrong, where ours makes *a reader at
  the SHA* do it. I stated the cost rather than letting it pass: a description can
  be read but not **re-executed**, so quarantine-until-reproduced gets **more**
  load-bearing under (b), and re-execution is exactly what the pipeline's agent
  reviewer cannot supply — which is (a)'s argument arriving from the other side.
- **(c) is the coincidence worth naming**: LH2's grades were minted as a
  generality bar and function as a **disclosure** bar on the identical test —
  tier 1 discloses no proper noun at all, tier 2 discloses exactly the domain.
  Named as a coincidence, not yet a guarantee.

**7. Honesty maintenance on §10's "no collisions".** The original ADR claimed new
vocabulary with no collisions. `LD-` and the shell's existing `L-D15` differ only
in hyphen position, which is close enough to mislead a skimming reader, so A1.4
names the near-miss and then **checks** it rather than asserting it — §1.2's own
measurement regex is run against all three id forms and matches only `L-D15`.
A claim in this ADR about ids should be as reproducible as the ADR's other
measurements, and it now is.

**8. What I deliberately did not touch.** §§1–12 stand byte-unedited (418
insertions, 0 deletions). No spec, no requirement, no interface record, no
enforcement script, no closed gate. No `R`-rule and no `test_protocol.sh` case —
PROTOCOL §11(3) is untriggered for §7.4's reason, and a grade split inside a
review-enforced criterion is not new enforcement semantics. **No PROTOCOL edit by
me** (R7): A1.6 supplies the hunk and the orchestrator applies it, per ADR-0016
§8, and I machine-checked the hunk against the live file so the transcription is
clerical in fact and not just in name.

**9. Not a harvest trigger.** This round is neither an `SO-` nor a phase gate, so
no harvest note is owed and none is written — declaring one here would be the
theatre §7.1 warns about, in the very entry that amends the bar. The **first**
note under the amended bar is `SO-M03`'s.

### Actions

- Appended **Amendment A1** to `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md`
  — A1.0 authority and reading rule, A1.1 the three tiers, A1.2 the two grades
  and the noun discriminator, A1.3 the classifier (+ A1.3.1 tier-3 fork, A1.3.2
  the prediction split three ways), A1.4 `LD-` ids and the pack-name interface,
  A1.5 what changed in the block, A1.6 the PROTOCOL hunk, A1.7 downstream
  including the parked federation decision, A1.8 five failure modes.
- Amended `docs/gates/lessons-harvest-block.md`: §1 item 2 (both id sequences,
  numbering independently); §2 preamble (the three tiers) and the LH2 row split
  into LH2-g / LH2-d with the discriminator and the tier-3 fork; new §2.1
  (classifier in short form with the tie-break); §3's spans table now `T1 / T2 /
  T3`; Yield table gains **Grade** and **Domain pack** columns and an `LD-` row;
  war-stories table becomes **Tier 3** with a disposition column; three new
  checklist boxes (classifier run, every `LD-` names a pack, pack names checked
  against those in use) and two amended ones; §4 gains four transcriber notes.
  The §3 fence remains **self-contained** — a copier gets the three-way
  classification without opening the ADR.
- Ran the verifications below. **No PROTOCOL edit, no charter edit, no agents/**
  file but this journal, no dv file, no test file.**

### Evidence

Reproducible at this commit's SHA, from a repo checkout at the repo root.

1. **Scope — exactly two non-journal files:**
   `git status --porcelain` →
   `M docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md`,
   `M docs/gates/lessons-harvest-block.md`. Nothing else, in particular nothing
   under `agents/` (bar this journal), `test/`, `tools/`, `libs/`.
2. **§§1–12 unedited — the amendment is a pure append:**
   `git diff --numstat docs/adr/ADR-0018-* docs/gates/lessons-harvest-block.md`
   → `431  0  …ADR-0018…` and `100  30  …lessons-harvest-block.md`. The ADR's
   **zero deletions** is the load-bearing figure: every line of §§1–12 survives
   byte-identical, and the block's 30 deletions are its own amended rows, all
   accounted for in Actions. **This journal's own row is stated as a property,
   not a count** — a line count of the entry you are reading is not stable under
   its own edits, which is §1.2's self-counting hazard in miniature — so: the
   deletion column is `0`, and HEAD's version is a **byte-prefix** of the staged
   one at 124,597 bytes (`git show HEAD:… | cmp` against `head -c`), which is R3
   verified rather than assumed.
3. **The PROTOCOL hunk applies clean to the live file**, extracted from the ADR's
   own §A1.6 rather than retyped, header `@@ -274,13 +274,22 @@`:

   ```sh
   sed -n '/^### A1.6/,/^### A1.7/p' docs/adr/ADR-0018-*.md \
     | sed -n '/^```diff$/,/^```$/p' | sed '1d;$d' > /tmp/body.diff
   { printf -- '--- a/agents/PROTOCOL.md\n+++ b/agents/PROTOCOL.md\n@@ -274,13 +274,22 @@\n'
     cat /tmp/body.diff; } | git apply --check -v -
   # → Checking patch agents/PROTOCOL.md...      (exit 0)
   ```

   Applied to a scratch copy, the resulting §7 paragraph was read back in full and
   reads correctly — the LH2 clause carries both grades and the collation sentence
   is followed by the **Routing** sentence. **The scratch copy is ephemeral**
   (`/tmp`, outside the repo); the reproducible claim is the `--check` above,
   which is what the orchestrator should re-run before transcribing.
4. **Nothing to migrate — no instantiation of the block exists:**
   `grep -rln "Lessons harvest —" docs/ agents/` → `docs/gates/lessons-harvest-block.md`
   only. A1.5's claim that no committed harvest is regraded rests on this.
5. **`LD-` was unused before this round:** `grep -rn "LD-" --include=*.md .` →
   empty at the parent commit.
6. **The id near-collision is checked, not asserted** — §1.2's measurement regex
   against all three forms:

   ```sh
   printf 'LD-SO-M03-1 LC-SO-M03-2 L-D15\n' | grep -oE "L-[A-Z]{1,3}[0-9]{1,3}"
   # → L-D15
   ```

   Local ids do not match; §1.2's yield measurement is unaffected by tier 2.
7. **No CI owed or claimed.** Two markdown files. No OCaml, no dune, no workflow,
   no script, no interface record — §12's `ifc_check` evidence is untouched and
   still witnesses the frozen records at their own SHA.

### Outcome

**DoD met** against the dispatch's five items.

1. **LH2 split** — LH2-g verbatim from §3.4; LH2-d admitting domain nouns and
   barring project nouns, with a discriminator for the boundary and the
   hide-the-provenance test on both grades, its audience parameterised.
2. **Classifier as a decision procedure** — A1.3, five steps, three terminal
   states, with the tie-break making the general attempt mandatory.
3. **`LD-` id class** — mirroring `LC-`, independently numbered, shell-side
   allocation still refused (§4.3/§12 extended, not overridden); the harvest note
   names the target pack, and the pack slug is stated as the **one field this
   repo owes the shell** for tier 2.
4. **Block amended**, three-way, §3 still self-contained; `SO-M03` is the first
   instantiation and classifies three ways from the outset.
5. **PROTOCOL §7 diff** supplied verbatim at A1.6 and machine-checked; **not
   applied by me**.
6. **Federation governance parked** at A1.7(4) — question, sponsor's four-property
   pipeline shape, and an explicit `Nothing in this sub-item is in force`.

**Handoff**: orchestrator, for commit under `Agent: architect_docs_lead`,
`Work-Order: none`; then A1.6's hunk under its own identity and entry.

### Open-questions

- **Owed, orchestrator-scope, text already supplied**: **A1.6's PROTOCOL §7
  hunk** — the only new owed item this round. `J-architect_docs_lead-0028`'s
  item (a) is **discharged** (§8's paragraph is live at `:268-286`, which is why
  A1.6 diffs against it rather than replacing it); (b) the five charter §8
  clauses and (c) the `tasks/BOARD.md` line remain owed **unchanged in
  substance** — no charter text moves, because the grades live inside the
  `LH1–LH3` name the charters already cite. The BOARD line should additionally
  record that the shell now has **two destinations**, so the end-of-program
  consolidation knows it is consolidating more than one set.
- **The amendment is unscoreable unless A1.3.2(3) is counted.** The measurement
  of what the grade bought is the number of candidates that reached tier 2 via an
  honest role-noun rewrite of what looked like a module-id refusal. If the first
  harvests do not record it, nobody will later be able to say whether the domain
  grade rescued lessons or merely lowered a bar.
- **Two signals with no threshold behind them yet**: a yield that is all `LD-`
  and no `LC-` (grade inflation, A1.8(2)), and a pack whose **second project
  cannot be named** (A1.8(1)). Both are stated as finding *shapes* for the
  auditor and neither is a rule. They plausibly need data before they can become
  one — the same posture §12 already takes on nil-yield harvests.
- **Pack storage is the shell's and is now on §12's list.** If the shell ends up
  organising packs in a way the slug cannot address, the interface A1.4 defines
  is wrong and this repo will hear about it from the shell, not the reverse.
- **Federation, parked with the sponsor** — A1.7(4). Owed before the shell's
  first outside contributor, not before our harvests; nothing is blocked on it.
  The sharpest unresolved piece inside it is (b)'s cost: a self-contained
  incident description is readable but not re-executable, and no one has said
  what an un-re-executable LH1 is worth.
- Carried unchanged from `J-architect_docs_lead-0028`: that entry's whole ledger,
  none of which this round touches or advances — the closure-record promotion
  path and through it the `-0026` ledger, the two re-countersignatures and one
  concurrence owed at `J-architect_docs_lead-0013`'s SHA, C-5's still-owed §0.6
  repair, the received-versus-delivered reading of §0.6, and the M03 RTL
  non-conformance against §9 ruling 9.

### Files-in-this-commit

- docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md
- docs/gates/lessons-harvest-block.md

## [J-architect_docs_lead-0030] 2026-08-05T03:05Z | task:WO-0063 | F-1 discharged as phrased, and §0.6's window ruled a BOUND AND NEVER A LICENCE — the two rules dv found in conflict were never about the same object, and the one cycle between them belongs to §9

### Trigger

Orchestrator, relaying a two-item batch from dv_lead. **Item 1**: verify that
`d54c931` discharges dv_lead's **FINDING F-1** *as dv phrased it*, and rule
DISCHARGED or name the residue. **Item 2**: dv_lead's new escalation, raised in
the design of `WO-0063` (the M03-I2 report-path-delay mini-round) and carried in
that packet's §5 and §8 item 3 — is requirements.md §0.6's `[W, W + 3]` strobe
window normative for M03's no-output-word reports alongside SPEC-M03 §9's exact
pin at `W + 2`, and is a report at `W + 3` conformant under §0.6 while
non-conformant under carry-forward **C-14.3**? dv states the consequence it cares
about: the standing `Strobe_monitor`, attached to every M03 unit, cannot see the
report-path-delay defect class at any unit at all. Two bounds on the answer,
stated by dv and honoured here: no row moves on it, and it must pass §0.5's
causality test.

### Inputs

- `docs/specs/requirements.md` at HEAD — §0.5 in full (the gapped-stimulus
  paragraph, the straddle and late-decision tests, the causality test, the
  start-lane bound), **§0.6 in full** (the window, the reference-word clauses and
  the `RV-0057-VERDICT` Finding 2 note), §0.7, REQ-008's verification column,
  §13's table in full including `J-orchestrator-0167`'s transcription row.
- `docs/specs/modules/xgmii_rx_64.md` at HEAD — **§6.1 item 2** in full (the
  repaired lane-4 paragraph and its four-row residue table, `:523–586`), item 1's
  worked 64/69-octet examples and item 3's withdrawal, **§7**'s latency table
  (ΔC = 3 at both lanes) and handshake bullet, **§9** in full (the closure list,
  the non-normative closure-record note, *Strobe cycle, pinned*, the reference-word
  paragraphs), §11, §13's last five rows.
- `docs/specs/SPEC-TEMPLATE.md` §9 — checked for whether a module spec is
  *obliged* to pin an exact strobe cycle. It is not; that is the decisive fact
  under Reasoning 7.
- `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`
  `:840–944` — dv_lead's COUNTERSIGNATURE block, point 3 and the **FINDING F-1**
  refusal verbatim, including its offered repair and its disclaimer of that
  offer.
- `agents/handoffs/WO-0060_tb-m03-family-i-dm-rebase.md` §3.5 and §7.1 (the two
  AP cells and the superseded "outstanding" clause), `RV-0060-VERDICT` §7.
- `agents/handoffs/WO-0061_family-i-mutation-campaign.md` **`WO-0061-VERDICT` §3**
  in full — the I-c10 offset **measurement** (`error_runt@11` against a terminate
  word at cycle 10), ground 2's assertion ordering, and the general finding that
  M03-I2's window is unfalsifiable by any threshold-class defect.
- `agents/handoffs/WO-0063_m03-i2-report-path-delay-mini-round.md` — §1, §2.2's
  arithmetic table, §2.3, §3's two intents, **§4** (both R-DISC discharges), **§5**
  (the instrument fact and the question), §7's pre-committed dispositions, §8
  item 3.
- `docs/gates/P1-spec-freeze-checklist.md` — the carry-forward ledger, read for
  its **actual** tail (see Evidence 4).
- `agents/charters/architect_docs_lead.md`; `agents/PROTOCOL.md` §4, §6, §7.
- **Not opened**, deliberately: `test/xgmii_rx_64/test_m03_*.ml` and every other
  bench source. PROTOCOL §10 independence — the bench is judged against this
  ruling and never the reverse — so both rulings derive from spec text and from
  the arithmetic the packets themselves state. Also not opened: `libs/**`,
  `docs/reports/audit/**`.

### Reasoning

**1. Item 1 — the test I applied, stated before applying it.** "Discharges the
escalation *as phrased*" is not "adopts the repair dv offered". A refusal binds on
its **claims**; an offered wording binds only if the finding presents it as a
term. F-1 does neither by accident: it labels its numbers as derivation
("*this is §6.1's own residue table, read at lane 4*") and labels its wording as
a gift — "*Repair I offer (the architect's call, not mine, and I hold no position
beyond it)*". So the test is: does every **claim** F-1 makes now hold of the
landed text, and is every **number** it derived reproduced in the cell? A
departure from the offered phrasing is not a residue; a departure in one cell
would be.

**2. Item 1 — term by term, against the file at HEAD.** F-1 makes six claims and
`d54c931` carries all six. (i) The heading's universal "*Every output word, at a
lane-4 start*" is false — landed: the heading is now "*The straddle at a lane-4
start, and the `tlast` word by residue*", with a parenthetical naming the old
universal as *"what F-1 below convicts"*. (ii) The `L + 16k` / `L + 8k` split is
exact for the **non**-`tlast` words — landed: the split paragraph now opens "*For
a **non-`tlast`** word*". (iii) It is exact for the `tlast` word at r = 4 and
wrong at the other seven — landed: "*Only r = 4 puts a **full** `tlast` word two
input words behind its own closing character … at the other seven residues that
word is short*". (iv) At r ∈ {1, 2, 3} bytes 4 … r+3 measure **L**, not L + 8k,
because they sit in the closing character's own word — landed as the table's
r ∈ {1, 2, 3} row: "*bytes 4 … r+3 in **T itself*** … **L + 8k** and **L** = 20
and **12**". (v) At r = 0 and r ∈ {5, 6, 7} the word has no byte above 3 and its
bytes 0–3 measure L + 8k, not L + 16k, so the *set* is unchanged while the
per-word description was still wrong — landed as two table rows at **L + 8k** =
20, plus "*the `tlast` word contributing no value the non-`tlast` words do not
already carry there*". (vi) The three-class set and its observability — landed:
`{L, L + 8k, L + 16k}`, `{12, 20, 28}` at k = 1 and `{12, 68, 124}` at k = 7, at
directed lengths **65, 66, 67**, "*reported and SHALL NOT be asserted*". **Every
number is F-1's own and no cell departs.** F-1's structural charge — that the
`J-architect_docs_lead-0025` ruling preserved the sharing argument at lane 0 and
dropped it at lane 4, so "*the two halves of the ruling are inconsistent with
each other*" — is answered in the text rather than around it: the landed
paragraph derives {1, 2, 3} as the complement of derivation 1's own
{0, 4, 5, 6, 7} and calls it "*the mirror of the lane-0 r ∈ {5, 6, 7} case item 3
states, which is why both items state it or neither is right*". **Verdict:
DISCHARGED as phrased. No residue.**

**3. Item 1 — the one departure, and why it is not a residue.** The offered
sentence "*state … `L` for those sharing the closing character's word and the
split otherwise*" is declined. It is refuted by F-1's own text two sentences
earlier: at r = 0 and r ∈ {5, 6, 7} the `tlast` word measures **L + 8k**, which
is neither `L` nor "the split". Adopting the offered wording would have
reintroduced, at three residues, exactly the error F-1 convicted at seven. That
is a case of a finding being **more right than its own proposed repair**, and the
right disposition is to take the derivation and re-word — which is what the
`J-architect_docs_lead-0026` row records, and which F-1's own disclaimer licenses.

**4. Item 1 — dv's new measurement, and what it actually bears on. I decline to
overstate it, including in dv's favour.** The batch offers `WO-0061-VERDICT` §3's
I-c10 offset as confirming evidence on this cell. Read exactly, it is
`error_runt@11` on a **64-octet, lane-0** frame whose terminate word is at cycle
10 — offset **+1**, at k = 0, of a *strobe*. The F-1 cell is a **lane-4**,
**k ≥ 1** statement about *per-octet latency classes*. Different lane, different
quantity, and the whole content of the cell is the separation an injected idle
creates, which a k = 0 run cannot exhibit. So it is **not** evidence about the
cell. What it *is* evidence for is worth recording rather than discarding: the
`tlast` word's D is the closing character's word T with a lane-0 offset in
{1, 2}, and a measured +1 at r = 0 lands inside that set at its tight end — an
independent, gapless confirmation of the **branch-(b) offset** that the F-1 table
is read through, and of §9's own "*on the cycle M03 emits that frame's `tlast`
word*". It confirms the frame the cell sits in, not the cell. Both statements are
in the §13 row so that no later reader upgrades it.

**5. Item 1 — why a spec note was owed at all, when the repair landed a week of
commits ago.** Because requirements.md §13's transcription row (`J-orchestrator-0167`)
records the `a8ca14d` countersignature "*with F-1 outstanding against §6.1 item 2's
lane-4 cell*", and **nothing in requirements.md closes it**. The discharge is
recorded only in SPEC-M03's own §13. A reader of the programme-wide document
therefore sees an open condition with no closing row — the stale-by-omission
shape this table has hit before (the REQ-901 restatement row at SPEC-M03 §13).
The fix is a **new row**, never an edit to the old one: that row is another
agent's signature transcription and rewriting it would be rewriting the record of
a signature. One row, no text moved.

**6. Item 2 — the finding restated as arithmetic, because that is where the
answer is.** dv's numbers reproduce exactly (`WO-0063` §2.2, re-derived here at
Evidence 5). At either start lane the zero-received frame's closing `/T/` sits in
input word **W = cycle 2**; §9's no-output pin is **W + 2 = 4**; §0.6's ceiling
is the module's latency in cycles, ΔC = **3** (SPEC-M03 §7), so **W + 3 = 5**;
and the boundary M03-I2 scans from is also **5**. The apparent conflict is that
one rule *admits* cycle 5 and the other *excludes* it. **They are not two rules
about the same object.** §0.6's ceiling bounds a **strobe** and includes its
endpoint. C-14.3 is SPEC-M03 §6.1's **drain** derivation and bounds the last
output **word** to two cycles after the terminate word; a bench scanning for
silence from the third cycle onward is reading that word bound, and on a frame
with no output word the only thing that scan can catch is a pulse. So the two
quantities coincide in *cycle number* by arithmetic and differ in *subject*.
Nothing in the specification disagrees with itself, and the ruling must not
manufacture a reconciliation between rules that were never in contact.

**7. Item 2 — the ruling: (a), and the term the existing note was missing.**
§0.6's window is normative and §9's pin is the tighter requirement; **both bind,
and conformance is their conjunction.** A report at `W + 3` is inside the window
and **non-conformant**, on §9's authority. §0.6 already carried half of this — the
note added at `J-architect_docs_lead-0023` says that on this class the window
"carries **no independent information**" and that the assurance is the module's
exact pin plus the exact strobe-event set, "never the window check". What it did
not say is the **converse**, and the converse is what dv actually needed: a cycle
inside the window is not thereby *conformant*. Stated only in the first
direction, the note explains why a window check proves little; stated in both, it
explains why a window check's **green is not evidence about the pin** — which is
precisely the sentence that turns dv's `Strobe_monitor` observation from an open
defect into a documented, bounded instrument reach. So the edit is one paragraph
appended to that note, carrying: the bound-not-licence rule; the one-cycle
arithmetic at M03 with both quantities named; the instrument consequence; and the
C-14.3 disambiguation from Reasoning 6. dv's own reading of its monitor is
confirmed in terms.

**8. Item 2 — why (b) is refused, on a derivation and not a preference.** dv's
option (b) — §0.6 gains a carve-out tying the window on the zero-received class
to the module's exact pin — is coherent and I rejected it on three grounds, the
third decisive. (i) **Direction of inheritance.** §0.6 delegates the *names* of a
module's closure events to that module's spec, and always has; it has never
delegated the *rule*. A ceiling defined as "whatever the owning module pinned"
makes the programme-wide document inherit its content from the documents it
governs, which inverts the hierarchy every module spec's "restates rather than
paraphrases" discipline depends on. (ii) **It would move a signed instrument for
nothing.** dv's committed `window` computes `not_after = W + ΔC` and was
countersigned at `0caf023` as implementing §0.6's clauses verbatim; narrowing
§0.6 puts that instrument out of conformance with the text it was signed against,
in exchange for a conviction that the per-row pin assertions already make.
(iii) **Decisive: it deletes the bound exactly where the bound is the only one.**
SPEC-TEMPLATE §9 requires a strobe, a stream effect and a co-occurrence ruling —
it does **not** oblige a module to pin an exact strobe cycle, and REQ-008's own
verification column commissions the check *inside the §0.6 window*, not against a
pin. Under (b), a module that pins nothing on its zero-received class would have
**no ceiling at all** on that class: the carve-out is silent where the window is
redundant's opposite. That is manufacturing a **C-5** vacuity deliberately — a
phrase with no referent — in the very clause whose reference-word ruling exists
to supply referents. (a) keeps a bound everywhere and loses nothing, because
where a module pins, the pin already governs.

**9. Item 2 — the (c) I considered and refused.** The tempting third option is to
give §0.6 teeth on this class by commissioning the standing monitor to check the
owning module's pin. I refuse it for two reasons and neither is timidity. It
would be **normative** text commissioning an assertion in dv_lead's own
instrument, which is the C-41 unpassable-assertion shape running in the other
direction — the architect writing DV's monitor from requirements.md — and it
would owe a countersignature I have no reason to spend. And it would be capable
of **moving rows**, which dv fixed as a bound on this answer: a new obligation on
the monitor attached to *every* M03 unit changes what those units assert. The
plan disposition — whether the standing monitor gains a pin check, or whether the
per-row assertions carry it as they do today — is dv_lead's, and this ruling
deliberately leaves it whole.

**10. The two bounds dv set, checked rather than asserted.** **Causality
(§0.5)**: the paragraph pins nothing. It names two cycles that already exist,
`W + 2` and `W + 3`, both at or after the deciding input word W, which is the
word carrying the closing character — the reference word §0.6's own third clause
already fixes for this class. The test is passed trivially, and I record that it
would *also* have been passed by (b), so causality is not what discriminates the
options; Reasoning 8 is. **No row moves**: no attack-plan row's disposition
changes (M03-I2's qualification still turns on member (iii) against IC-1/IC-2,
exactly as `WO-0063` §7 pre-commits), no strobe cycle moves, and no latency figure
moves — §1.1's ceilings and h column, SPEC-M03 §7's L = 16/12 and ΔC = 3, §6.1's
D(m), its residue tables and the `m + 3` cycles are all byte-unchanged (Evidence
2 and 3).

**11. Class, countersignature, ADR.** The paragraph is **non-normative
guidance** — the class the closure-record note took at `J-architect_docs_lead-0027`,
and lighter than editorial. Its honest test: delete the paragraph and every
conformant design, every committed test and every requirement is exactly what it
was. It states no SHALL, moves no sentence, pins no cycle, amends no requirement
and no verification column, moves **no window edge**, commissions no test and
closes no ledger item. On that ground **no countersignature is owed**; were it
ever restated normatively that would be a fresh, narrowly countersigned change,
and the §13 row says so. **No ADR**: there is no design choice among live
alternatives — (b) is refused as structurally unsound rather than as a rejected
design — and nothing in PROTOCOL, a charter or an enforcement script moves.

**12. No ledger row, and the spawn's premise corrected.** The batch suggested
"C-44 next if the ledger is at C-43" and told me to verify. The carry-forward
ledger's actual tail is **C-50** (Evidence 4), so C-43 and C-44 are both long
since allocated — C-43 is the `error_ip_bad_header` cell and C-44 is dv's own
M14-B4 self-report. More to the point, **no ledger row is owed at all**: a
carry-forward records something *carried*, and both items are closed here.
Minting C-51 to record a closed question would put a permanent open-looking row
in a gate checklist. The two §13 rows are the record.

**13. §7 harvest note — explicit nil, with the span stated so the interval
tiles.** Span since my last harvest note: **there is none**, in either volume;
ADR-0018 established the practice at `J-architect_docs_lead-0028` and amended it
at `-0029`, and the interval `[J-architect_docs_lead-0022 … -0030]` contains no
harvest trigger. This round is neither an `SO-` nor a phase gate, so under
PROTOCOL §7 no note is owed and none is manufactured — the same disposition
`-0029` §9 took, for the same reason, and declaring one here would be the theatre
ADR-0018 §7.1 warns about. **Yield: nil.** The first note under the amended bar
remains `SO-M03`'s, where the span will be stated from `-0022`.

**14. What I deliberately did not touch.** `docs/specs/modules/xgmii_rx_64.md` is
**byte-unchanged**, and that is a decision rather than an omission: §9's pin is
exact and correct, its *Strobe cycle, pinned* paragraph already ties itself to
§0.6's window, and the ruling adds nothing that §9 must restate — a module-side
restatement of a non-normative note would be text with no reader. No AP file, no
gate checklist, no ADR, no test, no `libs/**`, no `traceability.md` (the
paragraph is normative nowhere, so it claims no coverage).

### Actions

- **`docs/specs/requirements.md` §0.6** — appended **one paragraph** to the
  existing non-normative note that follows the reference-word clauses: the
  window is a bound and never a licence; both it and the module's own pin bind,
  so a cycle inside the window is not thereby conformant; the M03 arithmetic
  (ΔC = 3 → ceiling W + 3, §9's pin W + 2) with the deferred report named
  **non-conformant on §9's authority**; the instrument consequence (a monitor on
  the window alone convicts nothing here, and its green is evidence about the
  window and none about the pin); and the C-14.3 disambiguation (a bound on
  output **words**, contributing a scan boundary at the same cycle, not a second
  rule about the pulse).
- **`docs/specs/requirements.md` §13** — appended **two rows**, both journalled
  here. Row 1 records **F-1 DISCHARGED** with the term-by-term verification, the
  one declined wording and F-1's own disclaimer of it, and the exact reach of the
  I-c10 measurement. Row 2 records the §0.6 ruling with its class, the refused
  alternative and its three grounds, the no-countersignature and no-ADR
  arguments, and the causality check.
- Ran the verifications below. **No git command that writes**, no edit to any
  file outside `docs/`, and no edit above EOF of this journal.

### Evidence

Reproducible at this commit's SHA from a repo checkout at the repo root.

1. **Scope — exactly one non-journal file is mine.**
   `git status --porcelain` → ` M docs/specs/requirements.md`, plus
   ` M test/xgmii_rx_64/test_m03_b.ml` and ` M test/xgmii_rx_64/test_m03_i.ml`.
   **The two `test/**` files are not mine** — they are pre-existing working-tree
   changes from the DV line (`test/**` is outside my write scope, PROTOCOL §6),
   I opened neither, and they are excluded from Files-in-this-commit. Flagged in
   Outcome so the orchestrator stages only the `docs/` path.
2. **Pure append, zero deletions:**
   `git diff --numstat docs/specs/requirements.md` → `24  0  docs/specs/requirements.md`.
   The **0** is the load-bearing figure: every pre-existing line of §0.6 —
   including the normative *Strobe timing window* sentence, all three
   reference-word clauses and the C-23 counting convention — survives
   byte-identical, and no §13 row is edited. `git diff -U2` shows exactly two
   hunks, at `@@ -465,4 +465,26 @@` (the note) and `@@ -925,2 +947,4 @@` (the two
   rows).
3. **No other specification moves:** `git status --porcelain docs/` returns only
   `requirements.md`, so `docs/specs/modules/xgmii_rx_64.md`, every latency
   figure it pins (§7's L = 16/12 and ΔC = 3, §6.1's D(m) and residue tables,
   §9's strobe cycles) and requirements.md §1.1 are untouched at this commit.
4. **The ledger tail, checked rather than assumed:**
   `grep -o "^| C-[0-9]*" docs/gates/P1-spec-freeze-checklist.md | tail -1` →
   `| C-50`. The spawn's "the ledger is at C-43" premise is false; no ledger row
   was minted, and none is owed (Reasoning 12).
5. **dv's `WO-0063` §2.2 arithmetic, re-derived from the packet's own stimulus
   rather than read off its table.** `At_octet 0` places the closing `/T/` at
   `start_ot + 8`. Lane 0: `start_ot` = 8 → closing octet time **16** → word
   `16 / 8` = cycle **2**, lane 0. Lane 4: `start_ot` = 12 → closing octet time
   **20** → cycle `⌊20/8⌋` = **2**, lane `20 mod 8` = **4**. Both give W = 2;
   §9's no-output pin W + 2 = **4**; §0.6's ceiling W + ΔC with ΔC = 3
   (SPEC-M03 §7's table) = **5**; C-14.3's scan boundary = **5**. dv's table
   reproduces at both lanes, and the one-cycle margin it claims is confirmed.
6. **F-1's six claims against the file at HEAD** — the comparison of Reasoning 2,
   run as a read of `docs/specs/modules/xgmii_rx_64.md` `:523–586` (the repaired
   item 2, its four-row table at `:546–551`) against
   `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`
   `:893–938` (the FINDING F-1 block). Every numeric cell matches: r ∈ {1,2,3} →
   `L + 8k` and `L` (20 and 12 at k = 1); r = 0 and r ∈ {5,6,7} → `L + 8k` (20);
   r = 4 → the split (28 and 20); class set `{12, 20, 28}` / `{12, 68, 124}` at
   lengths 65/66/67.
7. **The I-c10 datum, quoted rather than characterised:**
   `agents/handoffs/WO-0061_family-i-mutation-campaign.md` `WO-0061-VERDICT` §3 —
   "*M03-A3's strobe-monitor report under i-c10 prints `observed: error_runt@11`
   for a 64-octet lane-0 frame whose terminate word is at cycle 10. **Offset =
   +1**.*" Lane 0, k = 0, a strobe. SPEC-M03 §7's handshake bullet pins the
   branch-(b) lane-0 offset at "*one or two*"; +1 lies inside it.
8. **No build, no simulation.** ADR-0005: the toolchain is lost and CI is the
   only authority. This round is textual and commissions nothing, so there is no
   run to cite and none is implied.

### Outcome

**DoD met, both items.**

- **Item 1 — DISCHARGED as phrased. No residue.** All six of F-1's claims and
  every numeric cell hold of the landed text at HEAD; the single departure is the
  offered *wording*, which F-1 itself disclaims as not a term of the refusal and
  which is inexact at three residues by F-1's own arithmetic. dv_lead is owed
  **notification**, not a signature — the standing already recorded in SPEC-M03
  §13's `J-architect_docs_lead-0026` row.
- **Item 2 — ruled (a)**, with the bound-not-licence direction added: §0.6's
  window is normative, §9's pin is the tighter requirement, both bind, a report
  at `W + 3` is **non-conformant on §9's authority**, and the standing
  `Strobe_monitor`'s inability to convict the report-path class is a **bounded
  instrument reach that is accepted and now documented**, not a specification
  defect. C-14.3 is disambiguated as a bound on output words. Causality passed;
  **no row moves**, no latency figure moves, no committed instrument moves.
- **Handoff**: to the orchestrator for commit, then to dv_lead as the answer to
  `WO-0063` §8 item 3 — which unblocks that packet's phase B, since IC-1's
  required consequence ("*the pulse lands **at** the C-14.3 boundary and the
  row's window raises*") is now backed by a specification that says such a pulse
  is non-conformant.
- **Staging note for the orchestrator**: stage `docs/specs/requirements.md`
  **only**. The two modified `test/xgmii_rx_64/*.ml` files in the working tree
  are the DV line's and are outside my write scope (Evidence 1); staging them
  under this entry would fail R4 and R7 both.

### Open-questions

- **dv_lead's plan disposition, explicitly left whole and not decided here**:
  whether the standing `Strobe_monitor` gains a pin check on the no-output-word
  class, or whether the per-row cycle assertions keep carrying it as they do
  today. Reasoning 9 records why I refused to commission it from
  requirements.md; it is dv's instrument and dv's call.
- **`WO-0063` phase B's disclosure axis** (§3.1 — is IC-1's rendering scoped to
  `/T/`-closed frames or shared across the whole no-output report path) is
  untouched by this ruling and remains the auditor's to answer. My paragraph is
  scoped to the class, not to the closure character, so it discriminates neither
  rendering.
- Nothing else. No escalation; both items were decidable in-role.

### Files-in-this-commit

- docs/specs/requirements.md
