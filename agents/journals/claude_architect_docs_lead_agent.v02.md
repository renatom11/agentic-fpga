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
