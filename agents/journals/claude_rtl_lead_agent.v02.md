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

## [J-rtl_lead-0015] 2026-08-11T05:10:00Z | task:none | M06 `Eth_axis_rx` written from the frozen batch-C spec and implemented rather than decomposed: one holding register and one output register at ΔC = 3 of 3, the realignment applied to `tkeep` by the same two positions as to `tdata` so the module contains no octet counter at all, and the straddle finding SPEC-M06 §7 still carries named rather than designed around

### Trigger

Orchestrator dispatch, same spawn-head `61e0c76`, act 2 of the same window as
`J-rtl_lead-0014`: M03 is signed (`SO-xgmii_rx_64.md` **PASS**, fourteen of
fourteen, at `41fead6`), the sponsor has asked for more RTL, and the next unbuilt
module is to be opened — implemented in-round or decomposed into a `WO-` packet,
my call, said out loud.

**Concurrency**: the declared dv_lead round owns
`test/attack_plans/AP-xgmii_tx_64.md` (new),
`test/attack_plans/AP-xgmii_rx_64.md`,
`agents/handoffs/WO-0079_m03-traceability-test-rows.md` and
`agents/journals/claude_dv_lead_agent.v08.md`. This commit writes three files —
two under `libs/hardcaml_ethernet/src/` and my own journal — and the sets are
disjoint. **The confinement claim is over the paths I own and not over the tree
being otherwise quiet**, which is my own banked candidate 26: `git status
--short` at the end of this round lists exactly my three files, and says nothing
about anyone else's.

### Inputs

- `docs/specs/architecture.md` §4's module inventory table and §4's three
  datapath diagrams — read to establish which module is next **from the record**
  rather than from the dispatch's sentence (§1 below).
- **`docs/specs/modules/eth_axis_rx.md` in full** — SPEC-M06, FROZEN at
  `508eea2`, all thirteen sections including §11's deferred items and §13's two
  change-log rows.
- `docs/specs/requirements.md` — **§0.5 in full** (octet time, the front offset
  h, the word delay ΔC, the deciding input word D, the two arithmetic tests, what
  a latency monitor may demand on a gapped stimulus), §0.6, §0.7, §1.1's ceiling
  and currency tables, REQ-003/005/011/013/014/016/019/021 and REQ-401 … REQ-410,
  and **§13's 2026-08-04 revision row**, which is where SPEC-M06's owed repair is
  recorded.
- `docs/specs/ifc_check/eth_axis_rx_ifc.ml` — the compile-checked lift of
  SPEC-M06 §4.1, read as the surface my `.mli` must present.
- `docs/specs/traceability.md`'s M06 rows (REQ-401, 402, 403, 407, 408, 409,
  410) — the REQ set architecture.md §4 maps to this module.
- `test/attack_plans/AP-xgmii_rx_64.md` **§2's standing obligations and §7's four
  bars**, read as the qualification era's standing rules and **read only**; the
  file is the declared sibling's and I did not write it. Bar 3 is the one that
  binds new RTL: the co-simulation lane is content-comparing and not
  timing-comparing, so a module's pinned per-octet constant is the programme's
  only detector of a uniform word-delay regression.
- `docs/adr/ADR-0005` (CI is the authoritative build surface), `ADR-0010` (the
  house consumer convention for record opens), `ADR-0017` (this window's
  rotation), `ADR-0018` §A2.7.
- The house style, read as the thing I am conforming to: my own
  `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, `xgmii_tx_64.ml`,
  `eth_mac_10g.ml`, `crc32_eth.ml`, `axi64.ml` and their `.mli`s, and
  `libs/hardcaml_ethernet/src/dune`.
- **`test/third_party/` was NOT opened this round.** The verilog-ethernet pin
  (`77320a9`) is MIT and my charter permits reading it freely, and I did not:
  SPEC-M06 §6.1 states the payload assembly rule in terms, so there was nothing
  the reference could have told me that the frozen spec does not, and the
  vendored source is the differential anchor's own subject. `eth_axis_rx.v` is
  named in SPEC-M06's header as consulted **by the architect** for decomposition
  and port naming; that consultation is upstream of the freeze and is not
  repeated here.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted**, for this or anything in
  it (charter §8, Inputs honesty).

### Reasoning

#### 1. Which module, established from the record

architecture.md §4's inventory is ordered by datapath position, and its receive
diagram is explicit: `W → M03 → M06 → M08 → {M10, M14} → M17 → APP`. M01 through
M05 exist in `libs/hardcaml_ethernet/src/` — `axi64`, `crc32_eth`,
`xgmii_rx_64`, `xgmii_tx_64`, `eth_mac_10g`, plus the `word_counter` bootstrap —
so **M06 `Eth_axis_rx` is the next unbuilt module and the next in datapath order
after the MAC pair.** That is two independent readings agreeing (the inventory's
order and the directory's contents), which is why I checked both rather than
taking the dispatch's sentence: an instruction is a summary of the source, and a
summary that has gone stale is not an authority.

#### 2. Implement or decompose — the call, and the paragraph it owes

**I implemented it, and the reason is that M06 is the first of REQ-021's three
realignment sites and it has zero latency reserve.** SPEC-M06 §1 says in terms
that the realignment "has to live somewhere, and this is the first of the three
places it does (M06 strips 14, M14 strips 20, M17 strips 8)", so the structure
chosen here is the one M14 and M17 will either copy or contradict; §1.1's
currency table pins M06 at ΔC = 3 against a ceiling of 3 with **reserve 0**,
which makes any structural misjudgement a slack release — a spec diff to §7, to
§1.1 and to architecture.md §4 together (SPEC-M06 §11.2) — rather than a local
tweak. On top of that, SPEC-M06 §7 and §10 still carry the per-octet-under-
injection reading that requirements.md §0.5 retired (§5 below), so a worker
reading the frozen spec end to end would build to a sentence that describes
something no straddling module can do, or would stop and ask; a packet faithful
enough to prevent that would have to restate §6.1's assembly rule, §7's pinned
constants, §0.5's straddle test and the D of every output event — which **is**
writing the contract out longhand, exactly the ground on which
`J-rtl_lead-0002` decided the whole MAC layer myself. **And I restate the price
in the same breath, because that entry did too and my own harvest banked it as
candidate 3: this module has no independent design review, self-review is not
review, and war story R14 — the rule that says delegation is bounded by the cost
of restating counter-intuitive constraints — still has no incident under it,
because I still have not delegated.** dv_lead's independently written suite is
the compensating control and it is not the same control.

#### 3. The microarchitecture: what was considered and why the winner won

The module is 14 octets removed from the front of a word-aligned stream. Four
decisions, each with the alternative I rejected.

**(a) Fixed wiring, not a shifter.** A general realignment stage carries a shift
amount and a barrel shifter. Rejected: SPEC-M06 §5 has **no parameters** and
makes 14 a constant of the specification, so the shift amount is not a variable
and a structure that admits one is logic parameterised on something that cannot
vary — and it invites the next author to make it vary. The realignment is
therefore two `select`s and a `concat_msb`:

```text
    tdata = { current[47:0], previous[63:48] }
```

**(b) The same shift applied to `tkeep`, which is the decision I most want on the
record.** The obvious datapath carries an octet count: `popcount tkeep` on the
`tlast` word, `min(count, 6) + 2` for the last full payload word, `count - 6`
for the drain word, and a count-to-`tkeep` decode table at the end. I wrote that
first. It is arithmetic on three cases, and every one of the three is a place to
be off by one. The formulation that replaced it is:

```text
    tkeep = { current[5:0], previous[7:6] }
```

— **the identical two-position shift, applied to the presence bits instead of
the octets.** An octet's presence then travels with the octet by construction,
the three cases collapse into one expression, and the drain word's `tkeep` falls
out of the same wiring with the current word's share masked to zero. The module
contains **no octet counter, no `popcount`, and no length arithmetic of any
kind**. It is smaller, but that is not why it won: it won because the property a
reviewer has to check is now *the same wiring twice* rather than *three
arithmetic cases agreeing with one wiring*, and I am the author of a module
nobody else reviews (§2).

The same collapse reaches the two control decisions. Every question this module
asks about a word's length is one bit of `tkeep`: bit 5 set means the word
reached frame octet 13, which is "the header is complete" **and** "the frame has
at least fourteen octets" — one test, two requirements (REQ-401 and REQ-402);
bit 6 set means the word carries an octet belonging to a payload word whose other
source word will never arrive, which is the drain condition and nothing else.

**(c) Constant latency beats data availability.** For an input frame of N octets
with N ≡ 0 or 7 (mod 8) the final payload word's octets are all present on the
input `tlast` word, and a design keyed to availability would emit it one cycle
early. Rejected on REQ-005 and on SPEC-M06 §6.1's own paragraph, which works the
15-octet case explicitly: payload octet 0's input octet time fixes its output
octet time, "an implementation that emitted it at Ci + 2 because it happened to
have all the octets would have length-dependent latency". So the drain word is
assembled on the cycle **after** the input `tlast`, from the holding register
alone, and leaves one cycle after that. This is the only asymmetry in the module
and it costs one registered pulse, one captured bit of `tuser`, and no counter.

**(d) Two register levels, placed to hit ΔC = 3 exactly.** Payload word m is
assembled from input words m + 1 and m + 2 (SPEC-M06 §6.1), so the earliest a
registered output can present it is one cycle after input word m + 2 — which is
Ci + m + 3, the cycle §6.1 pins. One holding register (the previous input word:
data, `tkeep`, `tuser`) plus one output register **is** REQ-019's permitted depth
of two, and the holding register is the same register the header capture reads,
so there is one and not two. An elastic buffer was never a candidate: REQ-003
gives this module no `tready` in either direction, so there is nothing to
backpressure and nothing that may stall.

**The header capture rides the same register.** On the cycle input word 1
arrives, the holding register holds word 0, so `dst_mac` is its octets 0–5 and
the top of `src_mac` its octets 6–7, with the rest of `src_mac` and the ethertype
taken live from word 1. REQ-012's network-byte-order decode is the concatenation
order (`concat_msb` over octets, most significant first) and not a reversal
network.

#### 4. The arithmetic, worked, because zero reserve means it has to be

Input frame of N octets, K = ⌈N/8⌉ input words, M = ⌈(N−14)/8⌉ payload words.
Payload octet j is frame octet 14 + j, which lies in input word ⌊(14+j)/8⌋ at
position (14+j) mod 8; payload word m therefore takes positions 6 and 7 of input
word m + 1 and positions 0 to 5 of input word m + 2.

- **N mod 8 ∈ {1,…,6}**: M = K − 2. The last payload word is index K − 3 and its
  second source word is the input `tlast` word, so it is loaded on that cycle
  with `{ tlast_keep[5:0], 11 }` — that is (N mod 8) + 2 octets — and carries
  `payload_tlast`. **No drain word**; `tkeep` bit 6 of the `tlast` word is 0,
  which is exactly the condition the design tests.
- **N mod 8 ∈ {7,0}**: M = K − 1. The word loaded on the `tlast` cycle is full
  (`{ tlast_keep[5:0], 11 }` = `0xFF` at both residues) and is **not** last; the
  final payload word's only octets are that word's positions 6 and 7, so it is
  the drain word, `tkeep` = `{000000, tlast_keep[7:6]}` = `0x01` or `0x03`.

Two worked members against the specification's own figures. The **60-octet**
stress frame (§8): K = 8, residue 4, M = 6; the last payload word loads on input
word 7 with `tkeep` = `{001111, 11}` = `0x3F`, six octets, `tlast` = 1, leaving
at Ci + 8 — §6.1's table row for cycle Ci+8 character for character, and 5×8 + 6
= **46** payload octets, REQ-408's worked figure. The **1514-octet** maximum
(§8's directed set): K = 190, residue 2, M = 188 = §7's bound, last `tkeep` =
`{000011, 11}` = `0x0F`, four octets, 187×8 + 4 = **1500**. The **22-octet**
directed length that C-17(e) added to cover the `0xFF` pattern: K = 3, residue 6,
M = 1, one payload word with `tkeep` = `{111111, 11}` = `0xFF` — the one length
in 14…22 that produces it, as §8 says.

**The three degenerate lengths.** N = 14: the `tlast` word is word 1 with six
octets, bit 5 set (header complete, `hdr_valid` pulses) and bit 6 clear (no
drain), and word 1 is not in `Payload`, so **no payload word is emitted at all**
— requirements.md §0.7's zero-octet payload with no encoding, and no strobe.
N = 15 and 16: the `tlast` word is word 1 with bit 6 set, so the drain fires and
one payload word of 1 or 2 octets leaves at Ci + 3 — §6.1's worked 15-octet case.
N ∈ 1…13: `error_short_frame`, one cycle, on the cycle after the input `tlast`
(§9's pinned offset), with no header pulse and no payload word.

**REQ-410, back-to-back.** The machine leaves for `Idle` on the input `tlast`
cycle and the pipeline drains behind it, so a new frame's word 0 on the next
cycle is accepted while the previous frame's drain word is being assembled. The
two loads cannot collide, and that is structural rather than lucky: a drain load
lands on a cycle whose state is `Idle` by construction, so the payload load's
`in_payload` term is 0 there. Worked at N = 16 with zero idle cycles between
frames: the drain word loads on the cycle carrying B's word 0 and leaves the
next; B's own first payload word leaves three cycles after that.

#### 5. The straddle, named rather than designed around

M06's front offset h = 14 is not a multiple of 8, so by requirements.md §0.5's
**straddle** test every payload word is assembled from two input words and
**M06's per-octet constant does not survive REQ-016's idle injection**. This is
not my finding and it is not new: §13's 2026-08-04 revision row names
**SPEC-M06 (§7, §10)** — beside SPEC-M10 and SPEC-M14 — as still carrying the
retired reading and owing the same repair, to ride with the next work order that
opens those specs. The two sentences at issue are §7's *"idle gaps on the input
delay everything by exactly 8 octet times per cycle and change nothing else"* and
§10's REQ-016 hook, which commissions *"asserting the per-octet constant rather
than the cycle formula"* — the assertion §0.5's closing normative paragraph
forbids a monitor from making at a module failing either test.

**What I did with that.** Not patch around it, not implement to it, and not fix
it — `docs/specs/**` is outside my write scope and the repair is
architect_docs_lead's. I implemented to **§0.5 as amended, which governs**, and I
wrote the consequence into the module's own doc comment so that no later reader
concludes I built against a live spec sentence in silence (charter §7: a spec
defect found mid-implementation is a spec-change request, never a silent
work-around). Concretely, §0.5's gap-invariant quantity is the delay from an
output event's **deciding input word** D, and this design's are constant because
each is a registered decision taken on D itself:

| output event | D | delay |
|---|---|---|
| payload word m, where the frame's `tlast` word carries no octet at position 6 | input word m + 2 — the word carrying the `tkeep`/`tlast`/`tuser` evidence that fixes it | **1** cycle |
| the drain word | the input `tlast` word | **2** cycles |
| `hdr_valid` | input word 1 — the last header octet and the not-short evidence arrive together | **1** cycle |
| `error_short_frame` | the input `tlast` word | **1** cycle |

On a gapless stimulus these are §6.1's cycle table exactly and §7's pinned
L = 10 octet times; **no cycle any section of SPEC-M06 pins moves**, which is what
§13's row says of the whole diff and is why this is a documentation repair and
not a design one. What changes is what a bench may assert under injection, and
that is dv_lead's instrument and not mine to write.

**The escalation-shaped part, routed and not decided here.** The repair's stated
carrier is "the next work order that opens those specs". M06 now exists, so the
next thing to open SPEC-M06 is its bench — and a REQ-016 wrapper built from the
un-repaired §10 hook would fail a conformant M06, which is precisely the failure
this programme has already paid for once (`SCR-M03-I4`, where a monitor built
from §0.5's unqualified sentence went red against a conformant M03). I raise it
to the orchestrator as a spec-change request for architect_docs_lead, class **E2
adjacent but not E2** — no requirement is added or dropped and no constant moves;
it is the third of the three repairs §13 already commissioned, now due.

#### 6. Line-rate invariant, and what bar 3 makes of it

Charter §5's rx-path clause: one 64-bit word per cycle, zero rx backpressure,
back-to-back minimum frames. Here it is structural before it is behavioural —
neither record contains an `Axi64.Dest` and neither contains a `tready`, so a
design that needed backpressure could not be written without a spec diff to
SPEC-M06 §4 (REQ-003). Throughput is guaranteed by the shape rather than by
argument: M06 removes fourteen octets, so it emits **one or two fewer** words
than it consumes for every frame and the output is never asked to carry two words
on one cycle.

`AP-xgmii_rx_64` §7's **bar 3** is what makes the latency constant load-bearing
rather than decorative: the differential co-simulation lane compares *what* is
delivered and not *when*, so a uniform word-delay regression is invisible to it,
and the pinned per-octet constant is the programme's only detector. At M06 that
constant has **no reserve at all** — ΔC = 3 of 3 — so there is no cycle here to
spend by accident, and I spent none: §4's arithmetic reaches 3 with a registered
output, which is the argument SPEC-M06 §7 makes and §11.2 defers to
implementation. **I therefore request no slack release**, and I record that the
measurement is dv_lead's at the stress bench and not mine.

#### 7. What this round deliberately does not contain

- **No test, no bench, no golden model.** PROTOCOL §10 and charter §3: I never
  author the tests that gate my own modules. I wrote no smoke sim either — there
  is no local toolchain to run one on (§Evidence), and a smoke sim carries no DoD
  weight in any case.
- **No `bin/generate.ml` change and no `rtl_snapshots/eth_axis_rx.v`.** `bin/**`
  is inside my charter scope and outside **this round's** dispatched write set,
  which named `libs/hardcaml_ethernet/src/**` and dune files only. Carried as
  **C-RL-6** in `J-rtl_lead-0014` §4 rather than mentioned once and dropped
  (candidate 50). The WO-0024 → WO-0026 pair is this programme's precedent for
  landing modules and registering their emission in separate rounds, and the
  snapshot itself is never hand-authored: it is promoted from a CI run
  (ADR-0005 rule 2), which is why the two must be separate acts anyway.
- **No `docs/specs/**` edit.** §5's finding is routed as a request.
- **No dune change, and that is a checked fact rather than an omission.**
  `libs/hardcaml_ethernet/src/dune` declares no `(modules …)` field, so the
  library takes every module in its directory and a new `.ml`/`.mli` pair joins
  it with no edit. No new directory was created, so no dune disposition is owed.
- **No packet.** This round issues no `WO-` and no `RV-`; there is no worker
  round to review.

### Actions

1. Read the charter, PROTOCOL, SPEC-M06 in full, requirements.md §0.5–§0.7 and
   §1.1, architecture.md §4, traceability.md's M06 rows, the frozen `ifc_check`
   lift, `AP-xgmii_rx_64` §2 and §7, and the four existing library modules for
   house style.
2. Established M06 as the next module from architecture.md §4 and the directory
   contents independently (§1).
3. Wrote `libs/hardcaml_ethernet/src/eth_axis_rx.mli` **first** — the module
   surface, matching SPEC-M06 §4.1's record shape — then
   `libs/hardcaml_ethernet/src/eth_axis_rx.ml`. One module fully on disk; no
   other module was opened for edit.
4. Wrote the count-carrying datapath, then replaced it with the shifted-`tkeep`
   formulation of §3(b) and removed `popcount` and the count-to-`tkeep` decode
   entirely.
5. Worked the length arithmetic of §4 against SPEC-M06 §6.1's and §8's own
   figures — the 60-octet stress frame, 1514, 22, 14, 15, 16 and the 1–13 class
   — before treating the design as settled.
6. Ran the parse check of §Evidence, with a negative control, and the line-width
   check against `.ocamlformat`'s `janestreet` profile.
7. Attempted a real build, recorded its exact failure, and **claim nothing from
   it** (§Evidence).
8. Removed the `_build/` cache that attempt created (134 files, all of them
   younger than one hour, so all of them mine), leaving the working tree at
   exactly my three files.
9. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git
   write of any kind.**

### Evidence

Reproducible from a checkout at this commit:

```sh
git status --short
#   the three files of this window and nothing else

# the library takes new modules with no dune edit: no (modules) field
cat libs/hardcaml_ethernet/src/dune

# the surface against the frozen lift, read side by side
sed -n '/^module I = struct/,/^end/p'  docs/specs/ifc_check/eth_axis_rx_ifc.ml
sed -n '/^module I : sig/,/^end/p'     libs/hardcaml_ethernet/src/eth_axis_rx.mli
sed -n '/^module O = struct/,/^end/p'  docs/specs/ifc_check/eth_axis_rx_ifc.ml
sed -n '/^module O : sig/,/^end/p'     libs/hardcaml_ethernet/src/eth_axis_rx.mli

# no line exceeds .ocamlformat's janestreet margin of 90
awk 'length>90 {print FILENAME": "FNR}' libs/hardcaml_ethernet/src/eth_axis_rx.ml \
                                        libs/hardcaml_ethernet/src/eth_axis_rx.mli
#   (no output)
```

**The parse check, and its negative control, because a check that reports clean
without discriminating is not a check** (my own candidates 8 and 14):

```sh
ocamlc -stop-after parsing -c libs/hardcaml_ethernet/src/eth_axis_rx.ml   # exit 0
ocamlc -stop-after parsing -c libs/hardcaml_ethernet/src/eth_axis_rx.mli  # exit 0
printf 'let x = (1 +\n' > /tmp/bad.ml
ocamlc -stop-after parsing -c /tmp/bad.ml                                 # exit 2, "Syntax error"
```

**WHAT DOES NOT BUILD HERE, MEASURED RATHER THAN ASSERTED, AND WHAT IT MEANS.**
The container's `fpga` switch is `ocaml-system.4.14.1` with **zero** hardcaml
packages installed (`opam list --installed | grep -ic hardcaml` → `0`), which is
ADR-0005's documented condition — the network policy blocks opam, so CI is the
authoritative build surface. `dune build libs/hardcaml_ethernet/src` fails at
**library and ppx resolution on `axi64.pp.ml`**, before any file of mine is
reached:

```text
File "libs/hardcaml_ethernet/src/dune", line 4, characters 18-30:
Error: Library "ppx_hardcaml" not found.
-> required by _build/default/libs/hardcaml_ethernet/src/axi64.pp.ml
File "libs/hardcaml_ethernet/src/dune", line 3, characters 21-33:
Error: Library "hardcaml_axi" not found.
```

**So: this module has NOT been compiled, NOT been type-checked, NOT elaborated,
NOT simulated and NOT emitted, and I claim none of those.** The parse check
establishes that the two files are syntactically well-formed OCaml and nothing
whatever beyond it — in particular it does not see a width mismatch, a wrong
field name, an unused binding under the dev profile's warning set, or a
`Signal` operator that does not exist. **The first real verdict on this module is
the `build` workflow's, and its run id belongs in whatever entry reads it.** That
is the same posture every RTL round of mine has taken since `J-rtl_lead-0001`,
and it is why the DoD below is stated as partially met rather than met.

**Not claimed, stated so the absence does not read as coverage**: that M06
compiles; that ΔC = 3 is measured (it is derived — §4 — and dv_lead measures it
at the stress bench, REQ-019's second check); that the line-rate invariant is
demonstrated (it is designed to and is structural at the record level; the proof
is dv's back-to-back stress); that any REQ of §10 is verified; that the
`ifc_check` lift and my `.mli` are byte-identical (they are not and should not
be — the lift opens `Axi64_ifc` and mine opens the library's `Axi64`, which is
ADR-0010's consumer convention); that `eth_axis_rx` appears in `rtl_snapshots/`
(it does not — C-RL-6). **Nothing in this entry is a verification result and no
DV sign-off is claimed** — `SO-` is dv_lead's to give.

### Outcome

M06 `Eth_axis_rx` is on disk, written from SPEC-M06 as frozen at `508eea2`, with
its `.mli` first and its `.ml` second, in the house style: `[@@deriving hardcaml]`
records with `[@rtlprefix]` on the nested ones, an `Always` state machine over a
three-state `enumerate`d type, `Hierarchy.In_scope` for `hierarchical`, one
`open! Axi64` and no second record module (ADR-0010).

Charter §5's per-module DoD, honestly scored:

- Implements its frozen spec, every REQ satisfied or escalated — **met on
  authorship, unproven by execution.** No silent deviation: the one thing I
  found that the spec says and no conformant design can do is §5's straddle
  reading, and it is raised rather than absorbed.
- Compiles and elaborates hierarchically; `bin/generate.exe` emits it
  deterministically — **NOT met, and deliberately so this round.** No local
  toolchain (measured above); emission registration and the snapshot are
  **C-RL-6**, owed to a later round with `bin/**` in its write set.
- House style holds; `.ocamlformat` clean — **style held by construction and
  against the four existing modules; `.ocamlformat` is NOT verified**, because
  `ocamlformat` is not installed in this container. Line width is checked.
- Rx-path module designed to the line-rate invariant — **met by design and
  structurally at the record level**; the proof is dv's.
- Worker modules reviewed line by line — **no instance**: no worker, no `RV-`.
- Journal entry appended, no DV sign-off claimed — **met.**

Charter §8's harvest-note obligation does not fire this round: PROTOCOL §7 ties
it to a sign-off and to a phase gate, and this is neither. The span bookkeeping
is at `J-rtl_lead-0014` §5 — this seat's next harvest opens at `J-rtl_lead-0013`
under ADR-0018 `A2-D10`.

**Handoff**: to the orchestrator — for commit, and thence (a) to dv_lead as the
seat that will bench M06 whenever the programme schedules it, with no test
content from me, and (b) to architect_docs_lead as a spec-change request for
SPEC-M06 §7 and §10's retired reading (§5), which requirements.md §13 already
commissioned and which M06's existence now makes due.

### Open-questions

1. **C-RL-6 — M06's emission is unregistered.** `bin/generate.ml` gains an
   `emit_eth_axis_rx` and `rtl_snapshots/eth_axis_rx.v` is promoted from a CI
   run, in a round whose write set includes `bin/**`. Note for whoever schedules
   it: the generator change and the snapshot **cannot** land in one commit here,
   because the determinism step's diff is what produces the snapshot's bytes —
   the generator lands, CI prints the promotion block, the snapshot lands next.
   Registering the emitter without a snapshot in the same window therefore
   reddens the `build` workflow by design, which is a decision to take
   deliberately rather than to discover.
2. **C-RL-7 — SPEC-M06 §7 and §10's retired per-octet-under-injection reading**
   (§5). Third of the three repairs requirements.md §13's 2026-08-04 row
   commissioned; architect_docs_lead's, now due because the module exists and its
   bench is the next thing to open the spec.
3. **This module has no independent design review** (§2, candidate 3). It is the
   sixth module in a row in this position. The compensating controls are
   dv_lead's independently written suite, the auditor's mutation campaigns, and
   the fact that the whole design is stated in the two `.ml` comments a reviewer
   can check against SPEC-M06 §6.1 by reading. If the programme ever wants the
   delegation path exercised, M07 `Eth_axis_tx` is the natural first packet: it
   is the transmit mirror of a module now written, its constants are ADR-0008's
   rather than novel, and R14's rule would finally acquire provenance in one
   direction or the other.
4. **Carried, unchanged and untouched by this round**: C-RL-2 (the latent
   `first_v` gating in M03), C-RL-3 (sub-word idle granularity, no row owed).
   Neither is reachable from anything this round wrote; M03 was not opened.

### Files-in-this-commit

- libs/hardcaml_ethernet/src/eth_axis_rx.ml
- libs/hardcaml_ethernet/src/eth_axis_rx.mli
