# ADR-0017: a journal is a chain, not a file

- **Status**: **ACCEPTED**. Proposed at `J-architect_docs_lead-0019`;
  **countersigned by dv_lead at `J-dv_lead-0066`**; **accepted by the
  orchestrator at `J-orchestrator-0140`**, the entry accompanying the step-1
  implementation commit; amended and flipped at `J-architect_docs_lead-0020`.

  dv_lead countersigned **D1–D6**, §4's design, §5's thresholds, §6's script
  specification (including the `<lister>` warning of §6.1 and §6.3's
  `Continues-from` equality check), §7's sequencing and end condition, and §9's
  eight test cases — having **verified the five forcing facts of §2 and §1.2's
  asymmetry against the scripts rather than accepting them**, and re-measured
  every journal against `S` and `H`. It **contested one sentence** of §6.5,
  bounding what a green chain certifies; the replacement is applied verbatim
  there and is the only change to the text as drafted.

  Still true after acceptance: the PROTOCOL diffs of §8 are **written, not
  applied** — the constitution is orchestrator-scope and, per ADR-0016 §8, the
  ADR authors the diff and the orchestrator transcribes it. The script behaviour
  of §6 remains a **specification**: step 1 lands under `J-orchestrator-0140`,
  step 2 is allocated as **WO-0053**.
- **Deciders**: **orchestrator**, on a process rule that amends the commit
  protocol. Not an escalation class: no requirement, phase or role changes
  (not E2), no toolchain or licence (not E3), no lead dispute (not E5).
- **Proposed by**: orchestrator dispatch, WO-0052, on the incident recorded at
  `J-orchestrator-0137` (committed `1799e10`).
- **Work order**: WO-0052 · **Journal**: `J-architect_docs_lead-0019`
- **Affects**: `agents/PROTOCOL.md` §4, §5 (`R3`, `R5`, new `R10`), §9;
  `scripts/policy.sh`, `scripts/agent_commit.sh`, `scripts/check_journals.sh`,
  `scripts/test_protocol.sh`, a new `scripts/verify_journal_chain.sh`;
  `agents/journals/INDEX.md`; every charter's `Journal:` line. **No frozen spec
  text, no requirement, no interface record, no gate checklist.** All of the
  above except this ADR is outside my write scope.

---

## 1. Context — a gate built for data fired on prose

Committing `J-dv_lead-0063` (the ADR-0016 countersignature, journal-only),
`agent_commit.sh` refused:

> staged file exceeds blob threshold: `agents/journals/claude_dv_lead_agent.md`
> (1013298 > 1000000 bytes; large data ships as fetch script + checksum
> manifest — blob gate, ADR-0002)

The refusal is correct against the code and wrong against the intent. The blob
gate is ADR-0002's accepted debt — item 6 of its key decisions re-labelled
**data_wrangler's** blob limit as `.gitignore`+audit-guarded "until a mechanical
size gate arrives with M1 CI", and its Consequences list the gate as debt. Its
remedy is stated in the refusal message itself: *large data ships as fetch script
+ checksum manifest*.

**That remedy cannot apply to a journal, and the reason is structural rather
than a matter of taste.** `R2` requires a journal append in the commit that
carries the work; `R3` requires the staged file's bytes to continue its own
previous bytes. A journal that shipped as a fetch script would satisfy neither —
there would be nothing to append to and nothing to byte-prefix. The one artifact
class the protocol *requires* in every commit is the one class the gate's remedy
cannot serve.

The orchestrator's response was to use the script's own parameterisation as a
bounded interim — `AGENT_COMMIT_BLOB_MAX=1100000`, dv commits only, each use
recorded in its journal — and to route the real fix here. That is the right
shape for an incident measure, and this ADR's job is to end it rather than to
bless it.

### 1.1 The interim is bounded by arithmetic, not only by policy

| journal | bytes | entries | bytes/entry |
|---|---|---|---|
| `claude_dv_lead_agent.md` | **1,013,298** | 63 | 16,084 (last 12: mean **12,589**) |
| `claude_architect_docs_lead_agent.md` | 357,620 | 18 | 19,867 |
| `claude_orchestrator_agent.md` | 261,392 | 137 | 1,907 |
| `workers/claude_tb_writer_agent.md` | 198,953 | 12 | 16,579 |
| `claude_rtl_lead_agent.md` | 132,667 | 8 | 16,583 |
| `claude_auditor_agent.md` | 122,226 | 8 | 15,278 |
| `workers/claude_data_wrangler_agent.md` | 42,587 | 3 | 14,195 |
| all journals | **2,131,151** | 249 | — |

**The table lists seven journals; there are nine** (dv_lead, at countersignature,
counted rather than assumed). The two omitted are
`workers/claude_rtl_module_dev_agent.md` (364 bytes) and
`workers/claude_formal_dv_agent.md` (359 bytes) — seeded headers with zero
entries, quiet by three orders of magnitude, and no conclusion below moves. The
correction is recorded because the argument is an argument about *counting*
journals, and a table that silently omits two of them invites the reader to check
nothing else. §5.2's disposition table is complete as drafted for the agents that
have entries; both seeds are quiet under `S` and remain so.

Measured at the **parent** commit — i.e. before this ADR's own journal append.
This commit adds `J-architect_docs_lead-0019`, taking
`claude_architect_docs_lead_agent.md` to **386,090** bytes and the total to
**2,159,621**; `claude_dv_lead_agent.md` is untouched by this commit and stays at
1,013,298. The dv figures, which are the ones every conclusion below rests on,
are therefore unaffected. Stated rather than left to be noticed, because a table
that silently excludes the commit carrying it is the kind of small dishonesty
that makes a reader distrust the large numbers too.

The override ceiling is 1,100,000. dv's headroom is **86,702 bytes ÷ 12,589 per
recent entry ≈ 6.9 entries.** The interim does not merely *deserve* an end
condition — **it has one whether or not anyone chooses it**, roughly six dv
commits out, which is inside a single campaign's verdicts. Raising the number
again at that point, without a governing rule, is how an incident measure becomes
the policy. This is the urgency, and it is measured rather than asserted.

### 1.2 The gate is enforced in exactly one place

`check_journals.sh` has **no blob check**. CI re-verifies R1–R8 (and R9's merge
triviality) and says nothing about size. So a commit made outside the script
lands a blob of any size and CI passes. The blob gate is therefore not an
invariant of this repository at all; it is a property of one code path. That
matters twice below: it weakens any claim that removing journals from the gate
*loosens* something (§3.2), and it is the same defect shape dv_lead flagged in
its ADR-0016 rider — a rule and its check disagreeing about what compliance is
(§6.6).

---

## 2. What the scripts key on — the five facts that force the design

Everything below is read out of the enforcement scripts at this SHA. Each fact
eliminates a candidate design, so this section is the argument, not background.

### 2.1 Journal files can never move. This is decisive.

`agent_commit.sh:56-57` refuses a staged journal **deletion** and refuses a
journal **rename/copy**; `check_journals.sh:95-96` refuses the same per commit.
Both scripts pass `--no-renames`, so a rename is reported as `D` + `A` and the
`D` fails first.

⇒ **Any design that moves, truncates or archives-away an existing journal file is
unimplementable without weakening R3.** That eliminates "copy the content to
`archive01.md` and truncate the active file", and it eliminates "reorganise
journals into `agents/journals/<agent>/vNNN.md`". The existing file stays where
it is, forever. The *active* file is the thing that must move.

This is also the reason the orchestrator's one requirement is satisfiable
cheaply: the rule that would have to be bent for truncation is exactly the rule
that guarantees no entry is silently rewritten, and this design never touches it.

### 2.2 R3 already supports a brand-new journal file

`agent_commit.sh:97-101`: if `HEAD:$JOURNAL` does not exist, `head` is empty, the
byte-prefix test passes trivially, and the whole file becomes the "appended
region" that R5 and R4 then read. `check_journals.sh:127-131` does the same
against `$PARENT`.

⇒ A rotation commit that creates a **new path** needs **no exception to R3 and no
special case in the append-only check**. Nothing is conditionally disabled;
nothing is skipped for "rotation commits". There is no rotation mode to abuse.

### 2.3 R5 is the one thing that genuinely breaks

`policy.sh:93-98` (`last_entry_num`) reads HEAD's copy of the single journal path
and returns `0000` when absent, so `agent_commit.sh:114-118` would demand `0001`
from a fresh volume. dv's next entry is `0064`.

⇒ R5 must read the **chain**, not the file. This is the only genuine amendment
the mechanism needs, and §6.3 states it exactly.

### 2.4 Three predicates are coupled to the filename

| helper | where | what it does | what a volume breaks |
|---|---|---|---|
| `is_journal_path` | `policy.sh:31-37` | globs `agents/journals/claude_*_agent.md` and the `workers/` twin; decides journal vs **work product** | `…_agent.v02.md` does not match ⇒ classified a work product ⇒ listed under R4 and refused by R7 (only the orchestrator may stage `agents/journals/**`) |
| seed-agent extraction | `agent_commit.sh:85`, `check_journals.sh:102` | `sed -E 's/^claude_(.*)_agent\.md$/\1/'` then `is_known_agent` | `claude_dv_lead_v2_agent.md` *does* match the glob but yields agent `dv_lead_v2` ⇒ unknown agent ⇒ R8 refusal |
| `journal_path_for` | `policy.sh:21-27` | one path per agent; feeds R2, R3, R5 | must resolve to the **active** volume |

⇒ The naming scheme is not cosmetic: it is jointly constrained by a glob, a
regex, and a lookup, and getting it wrong produces an R7 or R8 refusal rather
than a clean error. §6.1 fixes all three together.

### 2.5 The blob gate iterates every staged path, journals included

`agent_commit.sh:134-142` walks `STATUS_LIST`, which is built before journals are
partitioned out. The gate applies to journals **by accident of universality**,
not by decision: no line of ADR-0002, and no line of PROTOCOL, ever considered
the journal case.

---

## 3. Decision

- **D1 — Journals leave the blob gate.** `agent_commit.sh`'s blob check skips
  `is_journal_path` paths. Rationale: §1's structural argument (the gate's stated
  remedy is inapplicable to journals by R2+R3 construction) plus §2.5 (they were
  never deliberately in scope).
- **D2 — Journals get their own governance: a volume chain.** Freeze in place,
  fork forward (§4). Volume 01 is the file that exists today, at its historic
  path; volume N+1 is a new sibling; entry IDs continue across volumes.
- **D3 — Integrity is a property of the tree, not only of history.** Each volume
  header carries a sha256 back-link to its predecessor and the ID it continues
  from; the chain is verifiable from a bare checkout with no history at all
  (§4.3, §6.5).
- **D4 — Thresholds on the *active* volume: `S` = 256 KiB warn, `H` = 512 KiB
  refuse** (§5). Both are parameters, both defaulted in `policy.sh`.
- **D5 — These are `R`-numbers, not a namespace.** `R3` and `R5` are amended and
  **`R10`** is added, because ADR-0016 established that `R1`–`R9` means *the
  script refuses this* and namespaced ids (`R-CI-n`, `R-SEAL-n`) are for
  review-enforced rules. These rules are script-refused. §5.3 explains why this
  ADR blocks where ADR-0016 declined to, without inconsistency.
- **D6 — The blob gate stays unnumbered ADR-0002 debt**, unless the orchestrator
  also adopts the CI half (§6.6), in which case `R11` is minted in the same
  commit. Stated as a conditional deliberately: minting a number for something
  merely recommended is the defect ADR-0016 refused.

### 3.1 The framing that makes this more than a compromise

> **The exemption is not a loosening. It is a change of jurisdiction.** Journals
> leave a gate whose remedy is inapplicable to them by construction, and enter a
> rule whose remedy — rotate — is available, cheap, and in the author's own
> hands.

### 3.2 And the destination is tighter than the origin

The rotation ceiling `H` is **512 KiB**, half the blob gate that just fired. Every
journal but one is already inside it; the one that is not is the reason this ADR
exists. Combined with §1.2 — the gate was enforced on one code path and never in
CI — the honest summary is that D1 removes a check that was **not** an invariant
and D2 installs one that **is**.

---

## 4. The design: freeze in place, fork forward

### 4.1 Layout

```
agents/journals/claude_dv_lead_agent.md        volume 01 — FROZEN at rotation, never touched again
agents/journals/claude_dv_lead_agent.v02.md    volume 02 — ACTIVE
agents/journals/claude_dv_lead_agent.v03.md    volume 03 — ACTIVE, after the next rotation
```

and identically under `agents/journals/workers/` for the shared worker templates.

Three properties, each of which is a consequence of §2.1 rather than a
preference:

1. **Volume 01 keeps its historic path.** Every `agents/journals/claude_<agent>_agent.md`
   citation in every packet, ADR, verdict and journal entry in this repository
   stays resolvable, and `git blame`/`git log` on that path are unbroken. A
   design that moved the old content would have invalidated hundreds of
   references at a stroke — and could not have been implemented anyway (§2.1).
2. **Volume numbers live in the header, not only in the path.** The path suffix
   is how the scripts *find* the chain; the header is what they *verify*. Volume
   01 has no suffix and declares `Volume: 01`.
3. **Ordering is numeric.** `v02` … `v09` … `v10` sort correctly by number;
   zero-padding to two digits is convention, not the sort key, so a third digit
   never breaks the ordering.

### 4.2 Entry IDs continue across volumes

dv_lead's first entry in volume 02 is `J-dv_lead-0064`, not `J-dv_lead-0001`.

**Rejected alternative — per-volume renumbering.** Entry IDs are this
programme's citation namespace: gate signatures are journal-entry references
(PROTOCOL §7), countersignatures are cited by ID, and this very ADR cites
`J-dv_lead-0063`. Restarting numbering makes `J-dv_lead-0001` ambiguous between
two volumes and silently invalidates the meaning of every historic citation. It
would also destroy the cheapest drop-detector there is (§4.3, contiguity).

### 4.3 The volume header, and what makes the chain verifiable

A new volume's frozen header block — above the `---`, in the existing header's
style — adds five fields:

```markdown
# Journal: claude_dv_lead_agent — volume 02

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 02
- **Continues-from**: J-dv_lead-0063
- **Previous-volume**: agents/journals/claude_dv_lead_agent.md
- **Previous-volume-sha256**: <64 hex digits>
- **Previous-volume-bytes**: 1013298

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 01 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.
---
```

`Previous-volume-sha256` is the sha256 of the predecessor's **blob at the parent
commit** — which, because the predecessor is not modified by the rotation commit,
is also its content on disk at the moment of writing:
`sha256sum agents/journals/claude_dv_lead_agent.md`. `sha256` rather than git's
blob id because the chain should not depend on which hash git happens to use, and
because it is verifiable with a tool every checkout has.

**Why the back-link is the load-bearing part.** Today's append-only guarantee is
a property of **history**, and PROTOCOL §5 already concedes that it ultimately
rests on branch protection — an out-of-repo control the sponsor configures, named
in §5 as "one out-of-repo dependency". A history that is rewritten and force-
pushed can be made to re-satisfy every per-commit check. The back-link chain
makes the guarantee a property of the **tree**: altering one byte of an archived
volume requires rewriting every successor volume's `Previous-volume-sha256`, and
those are visible in a single checkout, in the working tree, with no history at
all. Entry-ID contiguity adds the second half: a *dropped* entry leaves a gap
even in a chain whose hashes have all been re-forged consistently.

⇒ The orchestrator's requirement — *the append-only audit trail must remain
mechanically verifiable across the full history; no design where rotation can
silently drop or rewrite an entry* — is not merely preserved by this design. It
is **strengthened relative to the single-file status quo**, and §6.5 gives the
command that proves it.

### 4.4 The rotation commit, concretely

dv_lead's next entry, if it is the rotating one:

1. Compute `sha256sum agents/journals/claude_dv_lead_agent.md`.
2. Create `agents/journals/claude_dv_lead_agent.v02.md` with the §4.3 header and
   **exactly one** entry, `J-dv_lead-0064`, in the normal §4.1 grammar.
3. Do **not** touch volume 01. Do not stage it.
4. Hand the file set to the orchestrator as usual.

Mechanically this is an ordinary commit: R2 sees one own-journal path staged; R3
sees a new file (§2.2); R5 reads `Continues-from` (§6.3); R4 and R7 are unchanged
because §6.1 keeps the path classified as a journal. **There is no "rotation
mode" in the scripts** — which is the property that makes the mechanism hard to
abuse, since there is no flag to set and no branch to take.

---

## 5. Thresholds

### 5.1 The numbers, and what anchors them

- **`S` = 256 KiB (262,144) — warn.** Anchored to a measured fact: in this
  session the Read tool refused `claude_architect_docs_lead_agent.md` with
  *"File content (349.2KB) exceeds maximum allowed size (256KB)"*. An agent
  cannot read its own journal in one call, and PROTOCOL §9's rehydration
  procedure — *"a fresh orchestrator session reads … the journal tails of agents
  with open work"* — is degraded **today**, not prospectively. One volume should
  be one readable unit.
- **`H` = 512 KiB (524,288) — refuse.** Two reads; ~40 dv entries or ~26 of mine
  per volume, i.e. roughly a phase of one lead's reasoning.

The tool limit is an environment property and could change, so it is the
*reason* for the number, not the number itself: both are parameters
(`JOURNAL_SOFT_MAX`, `JOURNAL_HARD_MAX` in `policy.sh`), changeable without an
ADR provided the ratio and the rationale are recorded.

### 5.2 What happens on the day this lands — a testable prediction

From §1.1's table, against `S` = 262,144 and `H` = 524,288:

| agent | bytes | disposition |
|---|---|---|
| dv_lead | 1,013,298 | **over `H` — must rotate at its next entry** |
| architect_docs_lead | 357,620 | over `S` — warned |
| orchestrator | 261,392 | **752 bytes under `S`** — crosses on its next entry |
| tb_writer | 198,953 | quiet |
| rtl_lead | 132,667 | quiet |
| auditor | 122,226 | quiet |
| data_wrangler | 42,587 | quiet |

**Exactly one forced rotation.** If implementing this produces more than one, or
none, the implementation does not match this ADR and that is the first thing to
check.

The dispositions are stable against the growth between now and implementation:
architect_docs_lead is already 386,090 bytes after this commit (§1.1) and stays
in the warn band until 524,288; the orchestrator crosses `S` on its next entry
either way; dv_lead is 1.9× `H` and nothing short of the rotation it is being
asked to perform changes that. Only a delay long enough for a second agent to
add ~140 KB would alter the count, and the note in §7.3 exists to prevent one.

### 5.3 Why this ADR blocks where ADR-0016 refused to

ADR-0016 argued at length that R-SEAL-1 must be advisory, because its antecedent
— *does this sentence assert a withheld result?* — is a judgement about prose that
no regex can make, and a blocking gate at ~1-in-12 precision would have refused
the very commit that discovered the defect. None of that applies here:

| | R-SEAL-1 | R10 / `H` |
|---|---|---|
| antecedent | "does this prose assert a withheld result" | `wc -c` |
| false positives | measured ~1 in 12 | **zero, by construction** |
| remedy on refusal | none mechanical — the author must re-author | rotate: create one file, move one entry |
| refusing the wrong commit | would have refused `RV-0049-VERDICT` | cannot happen |

A gate that cannot tell a confession from a crime must not be a gate. A gate that
counts bytes is exactly what a gate is for. The two ADRs land on opposite
enforcement classes **because the antecedents differ in kind**, and recording that
side by side is what keeps the R-namespace meaningful rather than arbitrary.

---

## 6. Exact required script behaviour

Specification, not a change: `scripts/**` is orchestrator-owned. Written against
the real variables so the implementation is transcription rather than design.

### 6.1 `policy.sh` — three coupled fixes (§2.4) plus chain resolution

```bash
is_journal_path() {
  case "$1" in
    agents/journals/claude_*_agent.md|agents/journals/workers/claude_*_agent.md) return 0 ;;
    agents/journals/claude_*_agent.v[0-9][0-9].md) return 0 ;;
    agents/journals/workers/claude_*_agent.v[0-9][0-9].md) return 0 ;;
    *) return 1 ;;
  esac
}

# agent identity from any volume of a chain
journal_agent_of() {
  basename "$1" | sed -E 's/^claude_(.*)_agent(\.v[0-9]{2})?\.md$/\1/'
}

# volume number from a path: 01 for the unsuffixed root
journal_volume_of() {
  case "$1" in
    *.v[0-9][0-9].md) basename "$1" | sed -E 's/.*\.v([0-9]{2})\.md$/\1/' ;;
    *) echo "01" ;;
  esac
}
```

`journal_path_for` is **retained unchanged** — it is the chain **root** (volume
01) and remains the stable identity of an agent's journal. Two new resolvers:

- `journal_chain_for <agent> <lister>` — the chain, ordered by
  `journal_volume_of` **numerically** (`sort -k1,1n` on the extracted number, not
  a lexicographic path sort).
- `active_journal_for <agent> <lister>` — the highest-numbered member.

`<lister>` is the critical parameter and the one place an implementation can go
quietly wrong: **the chain must be enumerated from the state being checked, never
from the filesystem.** In `agent_commit.sh` that is the index
(`git ls-files --cached -- 'agents/journals/'`); in `check_journals.sh` it is the
tree at the commit under examination
(`git ls-tree -r --name-only "$C" agents/journals/`). A filesystem glob in
`check_journals.sh` would validate old commits against today's worktree — passing
history that never contained the volume it is being credited with.

### 6.2 `agent_commit.sh` — R2, R8, the gate, the warning

- `JOURNAL="$(active_journal_for "$AGENT" index)"`, falling back to
  `journal_path_for "$AGENT"` when the agent has no chain yet.
- **Exactly one own-chain path may be staged.** If two volumes of the committing
  agent's chain are staged, refuse explicitly:
  `fail "two volumes of $AGENT's journal staged: … (R10 — one journal append per commit)"`.
  Without this, the second is misclassified as a *foreign* journal and refused by
  R8 with a misleading message.
- **R8 tightened.** A foreign journal seed may only be **volume 01 of an agent
  with no existing chain**. Today's rule ("a newly created file with a header and
  zero entries") would otherwise let any agent create
  `claude_dv_lead_agent.v02.md` — pre-empting dv_lead's next volume, or splicing
  an empty volume into a chain that the contiguity check would then have to
  reject after the fact. Refuse at the commit instead:
  `fail "foreign volume seed: $path (R8 — only volume 01 of a chainless agent may be seeded)"`.
- **Blob gate (D1)**: `is_journal_path "$path" && continue` inside the loop at
  `:136-142`, before the size test. Message unchanged for everything else.
- **Soft warning (D4)**: after the R3/R5 block, when the staged active volume
  exceeds `JOURNAL_SOFT_MAX`, warn to stderr and do not touch the exit code:
  `WARN-JOURNAL: agents/journals/… is NNN bytes (> 256 KiB); rotate to volume NN at your next entry (R10, ADR-0017)`.
- **Hard refusal (D4)**: when it exceeds `JOURNAL_HARD_MAX`,
  `fail "$JOURNAL is NNN bytes (> 512 KiB): rotate to volume NN (R10, ADR-0017 §4.4)"`.
  The message must name the rotation procedure, because a refusal whose remedy is
  not in the message costs a round trip through the sole committer.

### 6.3 R5 across the chain

```bash
# last entry id at the parent state:
#   active volume unchanged -> its own last id (today's behaviour, unchanged)
#   active volume NEW in this commit -> the PREDECESSOR volume's last id
```

and, when the active volume is new, the header's `Continues-from` **must equal**
that predecessor's last entry id, or refuse. This is the check that makes the
chain's join point non-forgeable from either side: the predecessor's content and
the successor's declaration have to agree.

### 6.4 `check_journals.sh` — per-commit, plus the tree check

- Resolve the chain from `git ls-tree` at `$C` (§6.1).
- Active volume: append-only vs parent — unchanged (`:132-133`).
- **Every non-active volume must be byte-identical to its parent version.**
  Today's R3 forbids non-append edits but would still permit *appending* to a
  frozen volume; a frozen volume must be frozen.
- Deletion/rename refusal applies to **every** volume (already does, via
  `is_journal_path` once §6.1 lands).
- R5 across the chain (§6.3); R4 and R7 unchanged.
- **The R10 tree check**, once per commit: volumes `01..N` present with no gap;
  each volume k>1's `Previous-volume` names k−1 and its `Previous-volume-sha256`
  equals `sha256(git show "$C:<k−1>")`; `Continues-from` equals k−1's last entry
  id; the concatenated chain's entry ids are contiguous `0001..M`, no gaps, no
  repeats.

**A performance note that is a real benefit, not a rationalisation.** Today
`check_journals.sh --all` materialises the whole journal for every commit
(`git show "$C:$JOURNAL"` at `:126`, plus `is_byte_prefix` reading both copies),
so its I/O is O(N × filesize) and filesize itself grows with N — quadratic in
programme length. Rotation caps the per-commit term at one volume, restoring
O(N × `H`). The tree check adds one pass over the chain per commit, which is
bounded by the same constant.

### 6.5 `verify_journal_chain.sh` (new) — the from-a-checkout proof

The artifact that discharges the orchestrator's requirement in one command, with
**no history required**:

```
scripts/verify_journal_chain.sh            # every agent, working tree
scripts/verify_journal_chain.sh --at <rev> # every agent, as of a revision
```

For each agent: walk `01..N`; assert each volume's declared `Volume` matches its
path; recompute `sha256` of volume k and compare against volume k+1's
`Previous-volume-sha256`; assert `Continues-from` equals volume k's last entry
id; concatenate and assert entry-id contiguity from `0001`. Exit nonzero naming
the first break and *which* property broke. This is the command an auditor runs.
Its green result is the claim **"no entry in a frozen volume has been rewritten,
and no entry id is missing from the chain"** — a claim that today can only be
made by trusting branch protection. **It does not certify the active volume**,
which has no successor to link back to it and whose append-only property still
rests on R3 and on history exactly as it does today. A green chain is not a
clearance for the volume currently being written.

### 6.6 The CI asymmetry (recommended, D6)

`check_journals.sh` has no blob check (§1.2), so the two scripts disagree about
what a legal commit is. That is **dv_lead's own ADR-0016 §6.4 rider one level
up** — *"the rule and its check will disagree about what compliance is"* — and
the same reasoning applies: a constraint enforced on one path only is a property
of that path, not of the repository. Recommended, in the same commit as D1: add
the blob gate to `check_journals.sh` **with the journal carve-out**, and mint
`R11` for it so PROTOCOL §5's enumeration stays honest about what CI re-checks.
If the orchestrator declines, the gate stays ADR-0002 debt and §5's text stays
accurate as it is — but the two scripts stay inconsistent, and that should be a
decision rather than an oversight.

---

## 7. Sequencing, and the end condition for the interim override

### 7.1 Two steps

- **Step 1 — the carve-out (D1) + the soft warning (§6.2), ~5 lines.**
  Unblocks dv_lead permanently. Nothing is blocked by anything; the gap before
  step 2 contains a *warning* rather than silence.
- **Step 2 — the chain (D2, D3) + `H` + `verify_journal_chain.sh` + the
  `test_protocol.sh` cases (§9).** dv_lead rotates at `J-dv_lead-0064`.

Both may land in one work order and should if the implementation is smooth; the
split exists so that step 1 is never held hostage to step 2.

### 7.2 The end condition, stated exactly

> **`AGENT_COMMIT_BLOB_MAX=1100000` is retired by the commit that lands step 1's
> journal carve-out in `agent_commit.sh`.** Not step 2. After that commit, the
> variable is never set again for a journal, and any future use is a new incident
> requiring its own record.

Supporting facts, so the condition cannot drift:

- Uses to date: **one** (`ad1e124`, recorded at `J-orchestrator-0137`).
- This ADR's own commit needs **no** override: the architect journal is 357,620
  bytes plus this entry, well under 1,000,000.
- dv_lead's next commit (the F-campaign adjudication) needs a **second** use if
  step 1 has not landed.
- The override **expires by arithmetic after about six more dv entries** (§1.1).
  If step 1 has not landed by then, the correct response is to land step 1, not
  to raise the number again.

**Facts at acceptance — the arithmetic above playing out, and no decision moves.**
The four bullets were written at drafting and are left standing as the record of
what was predicted; this note is what actually happened between draft and
acceptance:

- **Uses to date: four**, not one — `ad1e124`, `c3e877a`, `a2a3342`, `b9a08ff`,
  each recorded under `J-orchestrator-0137`'s regime. The draft predicted the
  second explicitly ("dv_lead's next commit … needs a second use"); the third and
  fourth are the same round continuing.
- **dv_lead's headroom is now ≈ 3.9 entries**, not ~6.9: 1,100,000 − 1,050,915 =
  **49,085 bytes** at the 12,589-byte recent mean. dv_lead measured ≈ 5.8 at
  countersignature (`J-dv_lead-0066`) and predicted ≈ 3.8 after that round's two
  entries; the measured 3.9 confirms it.
- **This is the ADR's own §1.1 argument arriving on schedule, not a surprise**,
  and it is the reason the end condition is pinned to step 1 rather than to the
  chain: at four uses and under four entries of headroom, the alternative to
  landing five lines is raising the ceiling a second time with the same argument
  and less credibility.
- **The `J-dv_lead-0064` worked example at §4.4, §5.2 and §7.1 is stale**: that
  entry is committed (`c3e877a`), so the rotation falls on dv_lead's first entry
  after step 2 lands, which is not knowable until it does. The *procedure* is
  unaffected — only the illustrative id is. Noted rather than rewritten, because
  the example's job is to show the shape and a live id would go stale again.

### 7.3 The guard against step 1 landing and step 2 never arriving

Step 1 removes the only thing currently bounding journal size, so it must not
land unaccompanied:

1. The commit landing step 1 **names the allocated follow-up work order** in its
   journal entry.
2. `H` must be **in force before the next `P<n>-phase-accept`** — the gate at
   which the full written record is read and the latency/audit reports are
   accepted. A gate, not a date, because that is this programme's idiom.
3. The soft warning ships **with** step 1, so the gap is observable in every
   commit's output rather than discovered at the next ceiling.

---

## 8. The PROTOCOL diffs — written, NOT applied

PROTOCOL §11 requires the ADR to land first, and this ADR is PROPOSED.

### 8.1 §4 — a journal is a chain

> One append-only journal per agent identity:

becomes

> One append-only journal per agent identity. A journal is a **chain of
> volumes**: volume 01 at the path below, and — once it reaches the rotation
> threshold (§5, `R10`) — volumes 02, 03 … as siblings named
> `…_agent.v02.md`. **No volume is ever moved, deleted, truncated or rewritten.**
> A frozen volume is never appended to again; the active volume is the
> highest-numbered one, and it alone grows, only by whole entries at EOF. Entry
> ids **continue across volumes** and are never restarted: an id identifies an
> entry in an agent's whole record, not in one file.
>
> Every volume after the first carries, in its frozen header block: `Volume`,
> `Continues-from` (the last entry id of the previous volume), `Previous-volume`
> (its path) and `Previous-volume-sha256` (that file's content hash at the
> rotation commit). Those fields are what make the record verifiable from a
> checkout alone rather than from history: rewriting an archived entry requires
> rewriting every later volume's header, and dropping one leaves a gap in the
> id sequence.

### 8.2 §5 — R3 amended, R5 amended, R10 added

`R3` gains: *"'The journal' means the **active volume** of the committing agent's
chain. Every other volume must be byte-identical to its previous version — a
frozen volume is frozen against appends as well as edits. Deletions and renames
are refused for every volume."*

`R5` gains: *"…across the chain. When the commit creates a new volume, the
predecessor is the previous volume's last entry, which must also equal the new
volume's `Continues-from` header field."*

`R10` (new): *"**R10 — Journal volume chain.** An agent's journal volumes form a
gapless chain `01..N`. A commit may create at most one new volume, for the
committing agent only, carrying a well-formed header whose `Previous-volume`
names volume N−1, whose `Previous-volume-sha256` equals that file's content hash
at the parent commit, and whose `Continues-from` equals volume N−1's last entry
id. The concatenated chain's entry ids are contiguous and strictly increasing. A
foreign journal seed (R8) may only be volume 01 of an agent with no chain.
Verified per commit by `check_journals.sh` and from any checkout by
`verify_journal_chain.sh`."*

The CI paragraph's enumeration is updated to whatever set is true after
implementation.

### 8.3 §9 — rehydration

*"…reads the journal tails of agents with open work"* → *"…reads the **active
volume** of the journals of agents with open work; earlier volumes are the
archive and are read on demand."*

### 8.4 PROTOCOL §11's touched-file list

`agents/PROTOCOL.md` (§4, §5, §9); `scripts/policy.sh`;
`scripts/agent_commit.sh`; `scripts/check_journals.sh`;
`scripts/test_protocol.sh`; `scripts/verify_journal_chain.sh` (new);
`.github/workflows/journal-check.yml` (if the new script runs in CI);
`agents/journals/INDEX.md` (a volume column — orchestrator's file, since
`is_journal_path` classifies `INDEX.md` as an ordinary work product); and every
charter's `Journal:` line, which should read "chain root" rather than name the
only file. **All of these are outside my write scope** and are a work-order
request, not a change I can make.

---

## 9. PROTOCOL §11(3) — the test cases owed

This change unambiguously alters enforcement semantics, so the cases are owed,
not optional. In `test_protocol.sh`'s existing style:

- **(a)** a rotation commit is **accepted**: new volume with a well-formed
  header, one entry = predecessor's last + 1, predecessor untouched.
- **(b)** a new volume whose entry restarts at `0001` is **refused (R5)**.
- **(c)** a new volume whose `Previous-volume-sha256` is wrong is **refused
  (R10)**.
- **(d)** an **append to a frozen volume** is **refused (R3)** — the regression
  test that catches a future "simplification" of volume resolution, and the one
  that would otherwise pass silently because today's R3 permits it.
- **(e)** two own-chain volumes staged in one commit are **refused**, with the
  R10 message and not R8's.
- **(f)** a foreign `…v02.md` seed is **refused (R8 tightened)**.
- **(g)** a 1.5 MB **journal** is **accepted** while `S27`'s 1.5 MB
  `libs/big.bin` is still **refused** — the carve-out and its boundary in one
  pair. `S27` must keep passing unchanged.
- **(h)** `check_journals.sh --all` over a history containing a rotation is
  **green**, and `verify_journal_chain.sh` on that tree is **green**; flipping one
  byte of the frozen volume makes both **red**.

Case (h) is the one that proves the ADR's central claim rather than its
mechanics, and it is the one I would write first.

---

## 10. Consequences

- **The blob gate no longer applies to journals, and applies unchanged to
  everything else.** The failure it exists to prevent — a multi-megabyte pcap or
  build artifact entering history — is untouched.
- **One forced rotation** on the day step 2 lands, dv_lead's (§5.2), plus one
  warning apiece for architect_docs_lead and (within an entry) the orchestrator.
- **Every existing journal citation stays valid** and volume 01 of every chain
  keeps its path forever (§4.1).
- **The append-only guarantee gets stronger**: from a property of history backed
  by an out-of-repo control, to a property of the tree checkable in one command
  (§4.3, §6.5).
- **CI gets cheaper as the programme gets longer**, from O(N²) to O(N × `H`)
  (§6.4).
- **Cost, honestly**: ~60–80 lines across four scripts plus one new ~50-line
  script; eight test cases; three PROTOCOL sections; one INDEX column; one line
  per charter. Ongoing: one rotation per ~40 entries for the verbose leads, ~135
  for the orchestrator, and a header an agent writes once per volume.
- **What this does *not* buy: clone size.** Git deltas an append-only text file
  nearly perfectly, so the packed cost of journals is ≈ O(total prose written)
  either way, and rotation barely moves it. The real costs are readability,
  sampling depth, rendering, and the quadratic checker — and saying so is worth
  more than a padded case, because it tells a future reader which of these
  arguments to re-check if the constants change.

---

## 11. Alternatives considered

1. **Raise the ceiling and stop.** Rejected: §1.1 — it buys ~7 dv entries, and
   the next raise has the same argument behind it and less credibility.
2. **Truncate the active file and archive its content** at a fixed path.
   Rejected twice over: unimplementable (§2.1 — deletion and rename are refused,
   and truncation is not an EOF-append) and, more importantly, it would require
   conditionally disabling R3 for a "rotation commit" — a mode whose existence is
   itself the rewrite vector the orchestrator's requirement forbids.
3. **Per-agent volume directories** (`agents/journals/dv_lead/v001.md`).
   Rejected on §2.1: the existing file cannot move, so the scheme cannot be
   applied to the volumes that already exist — it would describe only future
   ones, leaving two layouts in one repository.
4. **Per-volume entry renumbering.** Rejected: §4.2 — entry ids are the citation
   namespace, and renumbering silently invalidates every historic reference while
   destroying the contiguity drop-detector.
5. **Compact, squash or summarise old entries.** Rejected outright: PROTOCOL §1's
   first non-negotiable is that `git diff A..B` contains the reasoning. A summary
   is not the reasoning, and the deleted text is exactly what the auditor
   samples.
6. **Ship journals as fetch script + checksum manifest**, the gate's own remedy.
   Rejected on §1: R2 requires the content in the commit and R3 requires the
   file's bytes to continue its own bytes. The remedy is not merely awkward here,
   it is incompatible with two rules.
7. **Exemption alone, no rotation.** Rejected as an end state on the four real
   costs (§10), and adopted as **step 1 only**, with an end condition (§7.2) and
   a named guard against becoming permanent (§7.3).
8. **Rotation alone, no carve-out.** Rejected on sequencing: dv_lead is blocked
   *now*, and this would make the first-ever use of a brand-new mechanism happen
   under time pressure in the middle of a live campaign — the circumstance most
   likely to produce a malformed first chain, in the one artifact class that
   cannot be repaired afterwards.
9. **A blocking `WARN-JOURNAL` with no soft threshold.** Rejected: the warning is
   what makes the hard refusal a backstop that should never fire, and it costs
   one `if`.

---

## 12. What this ADR does not decide

- ~~**Whether it is adopted.**~~ **SETTLED.** dv_lead countersigned at
  `J-dv_lead-0066` (one sentence contested, applied at §6.5); the orchestrator
  accepted at `J-orchestrator-0140`. Struck rather than deleted, per this
  programme's no-silent-rewrite practice.
- **Whether and when the scripts change.** `scripts/**` is orchestrator-owned;
  §6 is a specification. Step 1 lands under `J-orchestrator-0140`; **step 2 is
  allocated as WO-0053** and remains unwritten until it does.
- **Whether the blob gate becomes `R11` and enters CI** (§6.6, D6) — recommended,
  conditional, and explicitly the orchestrator's call.
- **Whether `INDEX.md` and the charters are updated in the same commit** as the
  scripts or a follow-up — both are orchestrator-owned (§8.4).
- **The exact constants.** `S` and `H` are anchored (§5.1) but are parameters;
  changing them is a `policy.sh` edit, not an ADR, provided the anchor is
  restated.
- **Anything about ADR-0016 or R-SEAL-1.** They share a commit and nothing else;
  §5.3 compares their enforcement classes but does not reopen either.
