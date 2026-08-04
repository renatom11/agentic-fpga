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
