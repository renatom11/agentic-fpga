# Journal: claude_rtl_lead_agent — volume 02

- **Agent**: rtl_lead (Opus 5 lead)
- **Charter**: agents/charters/rtl_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 02
- **Continues-from**: J-rtl_lead-0013
- **Previous-volume**: agents/journals/claude_rtl_lead_agent.md
- **Previous-volume-sha256**: 51e646322b0a6954895bcb670c00251817b4f6e6422430cf663fd1f16d873426
- **Previous-volume-bytes**: 270152

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 01 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-rtl_lead-0014] 2026-08-11T04:30:00Z | task:none | Volume 02 opened on the rotation this seat scheduled for itself one entry ago: the two chain fields recomputed rather than accepted, the carried ledger restated whole with an owner and a closing event on every item, and three of its seven closed by acts that were not mine

### Trigger

Orchestrator dispatch, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`,
spawn-head `61e0c76`. Abort-first head check ran before anything else:
`git status --short` printed nothing and `git rev-parse HEAD` returned
`61e0c76bf3f9f9e555837dfc75253940389012a8`, an exact match with the dispatch, so
no rollback or descendant check was reached.

The rotation is not news to this chain. `J-rtl_lead-0013`'s Evidence section
predicted the `WARN-JOURNAL` its own append would trigger and recorded, in terms,
that **"this seat's volume 01 is due to rotate at `J-rtl_lead-0014`"** — so this
entry is a scheduled act redeeming a written prediction, not a threshold
discovered at a refusal. Volume 01 measures **270,152 bytes** at HEAD, past
ADR-0017's soft threshold `S` = 262,144 and well inside its hard refusal
`H` = 524,288; nothing was blocked, and rotating now is what keeps it that way.

The dispatch also fixed the boundary discipline: under ADR-0017 §4.4's fifth
step as practised by the architect at `J-architect_docs_lead-0035`, the rotating
entry **restates the carried ledger whole** rather than citing it across a volume
boundary. §4 below is that restatement.

**Concurrency**: a dv_lead round is declared in flight with write set
`test/attack_plans/AP-xgmii_tx_64.md` (new), `test/attack_plans/AP-xgmii_rx_64.md`,
`agents/handoffs/WO-0079_m03-traceability-test-rows.md` and
`agents/journals/claude_dv_lead_agent.v08.md`. This commit writes **one file**,
this journal, which is disjoint from all four. I opened two of the sibling's
files read-only (`AP-xgmii_rx_64.md` §2 and §7, `WO-0079` not at all) and wrote
neither.

### Inputs

- `agents/charters/rtl_lead.md` in full (§3 red lines, §5 DoD, §7 escalation
  classes, §8's journalling rules including the Harvest-notes clause).
- `agents/PROTOCOL.md` in full — §4 as amended (a journal is a chain), §4.1's
  entry grammar, §4.2's `Files-in-this-commit` set-equality, §5's `R1`–`R11`,
  §6's write scopes, §7's gates and lessons-harvest cadence, §10's independence
  and licensing rules.
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` **in full** — §2.1
  (journal files can never move), §2.2 (R3 already supports a new path), §2.3
  (R5 is the one thing that breaks), §4.1's layout, **§4.3's header block**,
  **§4.4's four-step rotation**, §5's thresholds, §6.3's `Continues-from`
  equality check, §6.5's from-a-checkout proof.
- `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md` — **§A2.7's
  census and `A2-D10`/`A2-D11`/`A2-D12`**, read for the span bookkeeping in §5
  below and for nothing else.
- The worked precedents, read as mechanics rather than as text to copy:
  `agents/journals/claude_dv_lead_agent.v02.md` (the first rotation in this
  programme) and `agents/journals/claude_architect_docs_lead_agent.v03.md`
  (the carried-ledger restatement at a boundary).
- **My own volume 01 at HEAD**, through `git show HEAD:` rather than from the
  working tree: its entry-header tail, its committed bytes, and the
  Open-questions sections of `J-rtl_lead-0012` and `J-rtl_lead-0013`, which
  between them are the whole of the carried ledger §4 restates.
- `agents/handoffs/SO-xgmii_rx_64.md` §1's criterion table and §2.9's run
  ledger — read to establish the **closing events** for two carried items, and
  read as another seat's verdict which I record rather than re-derive.
- `agents/journals/claude_orchestrator_agent.v02.md` `J-orchestrator-0173` — the
  closing event for the oldest item on the ledger.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted**, for this or anything in
  it (charter §8, Inputs honesty).

### Reasoning

#### 1. What the rotation is, mechanically, and why it needs no exception

ADR-0017 §4.4 is four steps and this commit is exactly them: compute the
predecessor's hash, create the successor at a new path with §4.3's header and
**one** entry, touch volume 01 not at all, hand the set to the orchestrator.
Nothing is conditionally disabled. `R2` sees one own-journal path staged; `R3`
sees a file absent from HEAD, so the byte-prefix test passes trivially and the
whole file is the appended region (§2.2); `R5` reads the chain and finds
`0013 + 1`; `R10` checks the header's three chain fields against volume 01's
actual bytes. **There is no rotation mode to get wrong**, which is §4.4's own
point and the reason a first rotation is cheap.

The one thing an author can get wrong is the header, so I computed both fields
myself rather than transcribing the dispatch's:

```sh
git show HEAD:agents/journals/claude_rtl_lead_agent.md | sha256sum
#   51e646322b0a6954895bcb670c00251817b4f6e6422430cf663fd1f16d873426
git show HEAD:agents/journals/claude_rtl_lead_agent.md | wc -c
#   270152
```

Both agree with the dispatch to the character. That agreement is the point of
recomputing: the orchestrator verifies the same two values at landing, so the
check is two-sided and a transcription error cannot pass by being consistent
with itself. **`Previous-volume` carries the repo-relative path**, not the bare
filename — §6.5's verifier compares paths.

#### 2. Why volume 01 is not touched, and what that buys

`git blame` and `git log` on `agents/journals/claude_rtl_lead_agent.md` stay
unbroken, and every citation of that path in every packet, verdict, ADR and
attack-plan row in this repository stays resolvable. Volume 01 keeps its historic
path forever (§4.1 property 1) and this commit stages it not at all. Entry ids
continue: my first entry in volume 02 is `J-rtl_lead-0014`, **not** `-0001`
(§4.2) — the ids are this programme's citation namespace and `SO-xgmii_rx_64`
§4, `AP-xgmii_rx_64` §4.N and `BUG-0002`'s escalation trail all cite mine by
number.

#### 3. The one judgement in this entry, stated before it is exercised

A rotation entry can be a receipt or it can be a hand-over. ADR-0017 §4.4 as
written permits the receipt; the practice this programme has settled on —
`J-architect_docs_lead-0035`, on the architect's own harvest candidate 59 —
makes it a hand-over, because **a carried obligation cited across a volume
boundary is one lookup further from the reader who has to act on it**, and the
volume boundary is exactly where a fresh session's rehydration stops reading
(PROTOCOL §9 as amended: the active volume is what is read, earlier volumes are
the archive). That is also my own banked candidate 50 — *an obligation a round
cannot discharge is restated in that round's own record, with the reason it
could not be discharged, at every round until it closes* — arriving at the one
place where the alternative is not merely inconvenient but changes what a
rehydrating reader sees at all.

So §4 restates the ledger **whole**: every item, with an owner and a closing
event, including the ones that closed. **Three of the seven closed, and all three
by acts that were not mine**; I record those closures rather than assert them — the
distinction matters, because a designer marking a verification obligation closed
on its own authority is the shape my charter §5 forbids in its last clause.

#### 4. THE CARRIED LEDGER, RESTATED WHOLE

Sources: `J-rtl_lead-0012` Open-questions 1 and 3 (four items) and
`J-rtl_lead-0013` Open-question 5 (three, two of which restate `-0012`'s). Ids
are minted here for the first time so that a later round can cite an item rather
than a sentence; they are local to this chain and claim no namespace.

| id | item | first carried | owner | status at this SHA | closing event |
|---|---|---|---|---|---|
| **C-RL-1** | REQ-902's double-generation byte-identity: the same source SHA must emit byte-identical Verilog on two generations, and one CI run is one sample | `J-rtl_lead-0003`, carried through `-0012` | rtl_lead | **CLOSED** | `build` run **`30920890962`** at `42b9df3`: the determinism step's empty diff against the snapshots landed there **is** the second sample. Recorded by the orchestrator at `J-orchestrator-0173`, which names it as completing exactly where `J-rtl_lead-0012` said it would. Not my act and not my reading — I cite the run and the entry |
| **C-RL-2** | the latent `first_v` gating in M03, reachable only by a stimulus SPEC-M03 §10 forbids (`M03-N3`: an idle word between a frame's start character and its first octet) | `J-rtl_lead-0005`, carried through `-0012` | rtl_lead | **OPEN — latent, by construction** | Re-check when and only when the prohibition is scoped in. `AP-xgmii_rx_64` §4.N holds `M03-N3` at **NO-STIMULUS, CITED**, with no coverage claimed for it anywhere, and carries **C-45**'s caveat that the prohibition is over-broad at a lane-0 start. Nothing in this round moves it and this round did not open M03 |
| **C-RL-3** | sub-word idle granularity — escalation 2 of `J-rtl_lead-0010`, on which `RV-0060-VERDICT` §6 ruled that no plan row is owed | `J-rtl_lead-0010`, carried through `-0012` | rtl_lead, with dv_lead's ruling standing | **OPEN — no row owed** | A stimulus at sub-word granularity, which no bench in this programme drives and none is commissioned to. Carried because a ruling that nothing is owed is not the same as the hazard being absent |
| **C-RL-4** | the `WO-0038` §8 mutation spot-check | `J-rtl_lead-0012` | auditor and dv_lead | **CLOSED by another seat's act** | Superseded by the class-based mutation era `SO-xgmii_rx_64` §1 `SC-5` scores — ten campaigns `WO-0050` … `WO-0077`, 63 sealed / 61 killed / 1 survived / 0 green-by-blindness / 1 void, plus fifteen of fifteen in the pre-class era. **I record the closure; the reading is dv_lead's and the manifests are the auditor's, and I re-verified neither** |
| **C-RL-5** | the line-rate rows `M03-L1` … `L5`, owed before `SO-xgmii_rx_64.md` could issue | `J-rtl_lead-0012` | dv_lead | **CLOSED by another seat's act** | `SO-xgmii_rx_64.md` **PASS**, fourteen of fourteen, at `41fead6`; `SC-4` **MET** on `build` run **`31453108454`**. Same discipline as C-RL-4: recorded, not claimed |
| **C-RL-6** | M06's emission is not registered in `bin/generate.exe` and `rtl_snapshots/eth_axis_rx.v` does not exist | **new, this window** — see `J-rtl_lead-0015` | rtl_lead | **OPEN — deliberately** | The round that registers the emitter and promotes the snapshot from a CI run. `bin/**` is inside my charter scope and outside **this round's** dispatched write set, and the WO-0024 → WO-0026 pair is the programme's precedent for landing a module and registering its emission in separate rounds |
| **C-RL-7** | SPEC-M06 §7's sentence *"idle gaps on the input delay everything by exactly 8 octet times per cycle"* and §10's REQ-016 hook (*"asserting the per-octet constant"*) are the reading requirements.md §0.5 retired | **new, this window** — surfaced while implementing, not raised by me | architect_docs_lead | **OPEN, and already tracked outside my chain** | requirements.md §13's 2026-08-04 row names SPEC-M06 (§7, §10) alongside SPEC-M10 and SPEC-M14 as owing this repair, to *"ride with the next work order that opens those specs"*. **Not a new escalation and not mine to fix** — `docs/specs/**` is outside my write scope. Recorded here so that no reader of my RTL concludes I designed around a live spec sentence in silence |

**Four open, three closed, and every one of the three closed by an act that was
not mine** — C-RL-1 by a CI run the orchestrator read, C-RL-4 and C-RL-5 by
dv_lead's sign-off. No item is dropped and none is folded into another. The
counts are the table's own: 4 + 3 = 7 rows.

#### 5. Harvest span bookkeeping, so the next note does not have to derive it

I owe **no** lessons-harvest note this round. PROTOCOL §7 and ADR-0018 §D1 tie
the obligation to a module sign-off and to a phase gate; this window is a journal
rotation and a construction round, and is neither.

What the window does owe is the span, stated so the intervals tile: under
**ADR-0018 `A2-D10`** a harvest's span ends at the last entry before the note
carrying it, and every later span opens at **the first entry not already inside a
mined span**. My first harvest mined `J-rtl_lead-0001 … -0012` (note at `-0013`),
so **this seat's next harvest span opens at `J-rtl_lead-0013`** — which is what
`J-rtl_lead-0013` itself declared, so `A2-D11` has nothing to correct here and no
prediction of mine is consumed. `A2-D12` obliges a note to state the convention
it used; the convention is `A2-D10`'s and this paragraph is where a future miner
finds it without re-reading the amendment.

#### 6. What this entry does not do

- It **edits volume 01**, and stages it, **not at all** — the one thing the
  mechanism forbids absolutely (§2.1, `R3`).
- It **claims no verification result of any kind.** C-RL-4 and C-RL-5 are
  recorded as closed by other seats' committed acts, with the run ids and packet
  sections those seats published; I re-executed nothing and no `SO-` is mine to
  read.
- It **checks no gate box and instantiates no checklist block.**
- It **touches no other agent's journal, packet or file**, and in particular
  none of the four files the declared sibling round owns.
- It **allocates no `L-` id and transcribes nothing to the shell.**

### Actions

1. Ran the abort-first head check: `git status --short` (empty) and
   `git rev-parse HEAD` → `61e0c76bf3f9f9e555837dfc75253940389012a8`, matching
   the dispatch exactly.
2. Read the charter, PROTOCOL, ADR-0017 in full and ADR-0018 §A2.7 for the span
   rule; read dv_lead's and architect_docs_lead's rotations as worked mechanics.
3. **Recomputed both chain fields from `git show HEAD:`** and compared them
   against the dispatch's values before writing a byte of the header.
4. Created `agents/journals/claude_rtl_lead_agent.v02.md` with ADR-0017 §4.3's
   header block and this single entry.
5. Walked `J-rtl_lead-0012` and `-0013`'s Open-questions to assemble the carried
   ledger, then established each item's status and closing event from the
   committed artefacts named in §4 — `J-orchestrator-0173` for C-RL-1,
   `SO-xgmii_rx_64.md` §1 for C-RL-4 and C-RL-5.
6. Wrote no other file in this commit. **No `git add`, no `git commit`, no
   `git push`, no git write of any kind.**

### Evidence

Reproducible from a checkout at this commit:

```sh
git rev-parse HEAD                                   # 61e0c76bf3f9f9e555837dfc75253940389012a8
git show HEAD:agents/journals/claude_rtl_lead_agent.md | sha256sum
#   51e646322b0a6954895bcb670c00251817b4f6e6422430cf663fd1f16d873426
git show HEAD:agents/journals/claude_rtl_lead_agent.md | wc -c
#   270152
grep -c '^## \[J-rtl_lead-' agents/journals/claude_rtl_lead_agent.md      # 13, last is -0013
grep -c '^## \[J-rtl_lead-' agents/journals/claude_rtl_lead_agent.v02.md  # 1, this entry
```

The three header fields against the two commands above: `Previous-volume` is the
repo-relative **path** the second and third commands read;
`Previous-volume-sha256` is the second command's output; `Previous-volume-bytes`
is the third's. `Continues-from` is `J-rtl_lead-0013`, which the fourth command's
file has as its last entry header — ADR-0017 §6.3's equality check, satisfied by
construction rather than by assertion.

**The chain check itself is not run here and I do not claim it.**
`scripts/verify_journal_chain.sh` is the from-a-checkout proof (§6.5) and it is
the orchestrator's and the auditor's to run; §6.5 is also explicit that a green
chain **does not certify the active volume**, which is the one this commit
creates. What I can state is what I did: both fields recomputed from `git show`,
neither transcribed.

**Externally verifiable references cited in §4, none of them mine**: `build` run
**`30920890962`** at `42b9df3` (C-RL-1's closing sample, recorded
`J-orchestrator-0173`) and `build` run **`31453108454`** at `41fead6`
(`SO-xgmii_rx_64` `SC-3`/`SC-4`'s evidence). I re-executed neither and the
citations are to the seats that published them.

**Not claimed**: that any carried item closed because of anything in this entry;
that the chain verifies (see above); that a harvest is owed or performed this
round; that volume 01 is complete or correct beyond its bytes hashing to the
value above. **Nothing in this entry is a verification result and no DV sign-off
is claimed.**

### Outcome

Volume 02 is open, at the entry this chain scheduled for the purpose one entry
ago. ADR-0017 §4.4's four steps: hash computed ✔, successor created with §4.3's
header and exactly one entry ✔, volume 01 untouched and unstaged ✔, set handed
to the orchestrator ✔. §4.4's practised fifth step — the carried ledger restated
whole at the boundary, with an owner and a closing event on every item ✔, four
open and three closed by other seats' acts, recorded rather than asserted.

Charter §5's per-module DoD does not apply to this entry: no RTL, no generator
change, no snapshot, no review verdict, no module. `Files-in-this-commit` is
**`- (none)`** and the commit needs the **`Journal-Only: true`** trailer
(PROTOCOL `R2`).

**Handoff**: to the orchestrator, which verifies the same two chain fields at
landing and lands this entry as its own commit, ahead of `J-rtl_lead-0015`'s.

### Open-questions

1. **Carried, and restated in full at §4 rather than referenced**: C-RL-2 (the
   latent `first_v` gating, latent by construction), C-RL-3 (sub-word idle
   granularity, no row owed), C-RL-6 (M06's emission unregistered — opened by
   this window and paid by a later round), C-RL-7 (SPEC-M06 §7 and §10's retired
   reading, architect_docs_lead's and already tracked in requirements.md §13).
   C-RL-1, C-RL-4 and C-RL-5 are closed and stay on the table with their closing
   events, per SPEC-TEMPLATE's own rule that a closed item keeps its row.
2. **A convention question for whoever collates the next harvest**, raised once
   and not repeated: this entry mints ledger ids `C-RL-n` local to my chain,
   because §4's restatement needs something a later round can cite that is not a
   sentence. The programme's other carried-item namespace is the spec-freeze
   ledger's `C-n`, which is architect_docs_lead's and which I have deliberately
   not extended. If a single namespace is wanted, mine is the one to retire.

### Files-in-this-commit

- (none)
