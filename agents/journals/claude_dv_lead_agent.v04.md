# Journal: claude_dv_lead_agent — volume 04

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 04
- **Continues-from**: J-dv_lead-0109
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v03.md
- **Previous-volume-sha256**: 76bb76822a90285b04f4a206857ec4309523391ca83c612e6905e620b01bf37c
- **Previous-volume-bytes**: 279073

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 03 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0110] 2026-08-05T18:30Z | task:none | Volume 04 opened — and the dispatch's one instruction I could not execute is the one the checker forbids: a header-only rotation commit does not exist, because R2 and R5 both require the entry that ADR-0017 §4.4 puts in it

### Trigger
Orchestrator dispatch, step 1 of a two-commit round: rotate to volume 04 before
anything else, with the chain fields computed rather than accepted, and commit
the new volume alone under `--journal-only` semantics. The commit gate emitted
`WARN-JOURNAL` at `79074cb` — v03 stands at 279,073 bytes, above `S`.

### Inputs
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` **§4.3** (the header
  block and why the back-link is the load-bearing part), **§4.4** (the rotation
  commit, *concretely* — its four numbered steps), §5.1 (the thresholds and what
  anchors them), §6.2 and §6.3 (the tightened R8 and R5-across-the-chain).
- `agents/PROTOCOL.md` §4, §4.1, §4.2, §5 (`R2`, `R3`, `R4`, `R5`, `R10`).
- `scripts/agent_commit.sh` lines 60–200 — **the R10/R2/R3/R5 checks I am about
  to be graded by, read so this file is written against the checker and not
  against my memory of the ADR**, which is the discipline `J-dv_lead-0091`
  adopted and the reason this entry exists at all.
- `scripts/policy.sh` — `JOURNAL_SOFT_MAX` 262144, `JOURNAL_HARD_MAX` 524288;
  `extract_files_list`'s `(none)` handling (lines 250–260).
- **`agents/journals/claude_dv_lead_agent.v03.md` at HEAD** — its sha256, its
  committed byte count and its last entry id, all three through `git show HEAD:`
  and none from the worktree.
- Commit `77e8540` (`dv journal rotated to volume 03`) — **the precedent the
  dispatch itself cited**, read as a commit rather than as a description: one
  file, +117 lines, `Journal-Only: true`, `Journal-Entry: J-dv_lead-0091`.
- My own `J-dv_lead-0091` (the volume-03 rotation) as the form.
- **No `libs/**`, no `docs/reports/audit/**`, no `scripts/` writes, no spec
  path.** A rotation has no evidence content and needs no derivation.

### Reasoning

**1. Every chain field is computed at HEAD, and the one I was handed is verified
against the tree rather than against the dispatch.** `Continues-from` was given
as `J-dv_lead-0109`; `git show HEAD:…v03.md | grep '^## \[J-dv_lead-'` ends on
**J-dv_lead-0109**, so the join point is right. `Previous-volume-sha256` is the
sha256 of the **committed blob** — `76bb7682…bf37c`, taken through `git show
HEAD:`, which is the whole point of the field: it must describe a state that
exists in history, not a state that exists on my disk. Bytes: **279,073**, from
the same pipe. `git status --porcelain` shows v03 untracked-clean and unmodified,
so the hashed bytes and the disk bytes agree — stated because if they had
disagreed, the committed blob still wins and the ADR says so.

**2. The instruction I could not execute, and why refusing it is the only way to
obey the dispatch's own cited authority.** The dispatch says, in terms: *"NO
entry in v04 in this commit — the header block only."* **That commit cannot be
created**, and not by a matter of taste:

- `agent_commit.sh` R2 requires a staged append to the active volume; for a new
  volume the whole file is the appended region.
- **R5 then runs `grep -cE "^## \[J-dv_lead-[0-9]{4}\]"` over that region and
  fails unless the count is exactly 1** — a header-only file gives **0** and the
  script fails with *"appended region must contain exactly one new entry header,
  found 0"*. There is no flag that skips it: ADR-0017 §4.4 says in terms
  **"there is no 'rotation mode' in the scripts"**, and calls that absence the
  property that makes the mechanism hard to abuse.
- R4 additionally requires a `### Files-in-this-commit` section in the appended
  region, which a header block does not have.
- **ADR-0017 §4.4 step 2 spells the requirement out**: create the new volume
  *"with the §4.3 header and **exactly one** entry … in the normal §4.1
  grammar."*
- And **the precedent the dispatch names as authority says the same thing when
  read as a commit rather than as a memory**: `77e8540` carries
  `Journal-Entry: J-dv_lead-0091`, and `git show 77e8540:…v03.md | grep -c '^##
  \[J-dv_lead'` = **1**. The practiced rotation has always contained its entry.

So the header-only reading is a misdescription of the precedent, and following it
would produce a commit the orchestrator cannot make. **This entry is that one
entry, and it takes number 0110** — `chain_last_entry_num` at HEAD is 0109 and
R5 wants last + 1, so no other number is available. **The consequence the
orchestrator must carry into commit 2: the WO-0065 packet's entry is
`J-dv_lead-0111`, not 0110.** I state the renumbering here rather than only in my
return, because the return is chat and this is the artefact.

**3. This rotation is ELECTIVE, and saying so is a debt `J-dv_lead-0091` created
for every rotation after it.** v03 is **279,073 bytes — above `S` (262,144) and
well under `H` (524,288)**. `agent_commit.sh` refuses only above `H` and emits
`WARN-JOURNAL` above `S`; the gate at `79074cb` **warned**. So R10 would have
taken another append, exactly as it would have at v02, and the choice to rotate
is mine to defend rather than a mechanical necessity. The v02 rotation *was*
forced (v01 stood at 1,123,442 bytes, 2.14 × `H`); the v03 one was not and said
so; this one is not and says so. **A journal whose rotations all imply necessity
is a journal that has quietly stopped distinguishing the two**, and an auditor
diffing the three entries would find the difference and be right to ask.

**4. Why rotate anyway.** Three reasons, in the order I weight them. (i) The
boundary is a real one: v03 opens on the BUG-0003 confirm round and closes on the
plan round that absorbed the M03-I2 campaign; v04 opens on a **family round**,
so a reader who opens this volume gets the family-B completion from its first
byte instead of joining a closed campaign's bookkeeping. (ii) The warn band is
where a rotation is *cheap* — above `H` it is compulsory and lands wherever the
refusal happens to fall, which is never a boundary anyone chose. (iii) The
dispatch asked, and a clerical act that costs nothing and forecloses nothing is
not the place to spend refusal capital — which is exactly why the one thing I do
refuse here is the thing the checker refuses too, and nothing else.

**5. What I did not do.** I did not touch v03 — not one byte, which R10 verifies
by comparing the staged and HEAD blob ids and which is also what makes
`Previous-volume-sha256` mean anything. I did not seed or read any other agent's
journal into this commit. I did not fold the WO-0065 packet into the rotation:
`Files-in-this-commit` is `- (none)` and the commit carries `Journal-Only: true`,
so the rotation is separable in the log from the packet that follows it, exactly
as the dispatch ordered them.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at `J-dv_lead-0109`: **J-dv_lead-0110** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0110**, first harvest still firing at
`SO-M03`. **Nil yield**: nine banked candidates and both war stories carry
unchanged, none promoted, none retired. A rotation produces no incident, and
recording a candidate from a clerical act would dilute the ones that were earned.

### Actions
- Created `agents/journals/claude_dv_lead_agent.v04.md` with the ADR-0017 §4.3
  header block — Volume 04, Continues-from `J-dv_lead-0109`, Previous-volume
  `agents/journals/claude_dv_lead_agent.v03.md`, sha256 and bytes as computed —
  in v03's exact field order and wording, and this entry as its first.
- Computed, not copied: the predecessor's sha256, byte count and last entry id,
  all at HEAD.
- Read `agent_commit.sh`'s R2/R3/R4/R5/R10 block before writing a byte, and
  recorded above the one place where the dispatch and the checker disagree.

### Evidence
```sh
git show HEAD:agents/journals/claude_dv_lead_agent.v03.md | sha256sum
# 76bb76822a90285b04f4a206857ec4309523391ca83c612e6905e620b01bf37c  -
git show HEAD:agents/journals/claude_dv_lead_agent.v03.md | wc -c
# 279073
git show HEAD:agents/journals/claude_dv_lead_agent.v03.md \
  | grep '^## \[J-dv_lead-' | tail -1 | cut -c1-24
# ## [J-dv_lead-0109]
git status --porcelain -- agents/journals/claude_dv_lead_agent.v03.md
# (empty -- the hashed bytes are the committed bytes)

# The precedent, read as a commit rather than as a description
git show --stat 77e8540 | tail -3
#  agents/journals/claude_dv_lead_agent.v03.md | 117 +++++++++++++
git show 77e8540:agents/journals/claude_dv_lead_agent.v03.md \
  | grep -c '^## \[J-dv_lead'
# 1        <- the rotation commit has always carried exactly one entry
```
Thresholds read from `scripts/policy.sh`: `JOURNAL_SOFT_MAX=262144`,
`JOURNAL_HARD_MAX=524288`; **279,073 is between them, i.e. warn, not refuse.**
The R5 check quoted in Reasoning §2 is `agent_commit.sh`'s own
`new_headers=$(grep -cE "^## \[J-${AGENT}-[0-9]{4}\]" …)` followed by
`[ "$new_headers" -eq 1 ]`. **Not run**: `dune build`, `dune runtest` — no
Hardcaml toolchain in this container (ADR-0005); this commit stages one markdown
file and no test could speak to it.

### Outcome
DoD met for step 1, with **one declared divergence from the dispatch**: the
rotation commit carries this entry, because a header-only rotation commit is
refused by R2/R5 and is forbidden by ADR-0017 §4.4's own step 2 — and the
precedent the dispatch cited is itself an entry-carrying commit. Volume 03 is
frozen; volume 04 is active and chains to it. **Handoff**: the orchestrator
commits this volume **alone**, `Journal-Only: true`, `--entry J-dv_lead-0110`,
ahead of the WO-0065 packet commit.

### Open-questions
1. **The WO-0065 packet's entry is `J-dv_lead-0111`, not 0110**, and the two
   commits must be staged in order. R5 leaves no choice on the number: 0110 is
   consumed here. It also fixes the **staging order**, because R5 counts entry
   headers in the appended region and would see two if both entries were present
   at commit 1. So this volume is handed over containing **the header and this
   entry only**; `J-dv_lead-0111` is written and waiting at
   `<scratchpad>/J-dv_lead-0111.md`, to be appended verbatim
   (`cat … >> agents/journals/claude_dv_lead_agent.v04.md`) **after** commit 1
   has been created and **before** commit 2 is staged. The second
   `agent_commit.sh` invocation then passes `--entry J-dv_lead-0111`.
2. **This rotation is elective, not forced** (Reasoning §3). If the programme
   would rather rotations be taken only at `H`, that is a policy change and an
   ADR amendment, not a judgement call to be made silently one volume at a time.
3. Carried unchanged from `J-dv_lead-0109`: `run_i2_member`'s deliberate citation
   exception, still without a carrier; `WO-0058` bound 7 — **and it is paid in
   the next entry's packet, by M03-N2 rather than by M03-B4**; the
   `assert_following_frame_intact` / `assert_clean_frame_structure` merge;
   `WO-0061` §8 bound 1's `tkeep` half; **N-1**; the auditor's DV-escape ledger
   disposition on `BUG-0003`; family J behind a bench-capability round;
   `SO-xgmii_rx_64.md` unopened and **not offered**.

### Files-in-this-commit
- (none)
