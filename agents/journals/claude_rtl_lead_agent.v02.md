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

## [J-rtl_lead-0016] 2026-08-11T06:40:00Z | task:none | M06's emitter registered and the `build` workflow reddened on purpose: the missing-snapshot case proved to be a promotion source and not a dead end before the commit that depends on it was written, with the failing step named in advance so the next red on this branch reads as scheduled

### Trigger

Orchestrator dispatch, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`,
spawn-head `36e3a4d`. Abort-first head check ran before any read of substance:
`git status --short` printed nothing and `git rev-parse HEAD` returned
`36e3a4d973a202ada61fd10bd5217382a19a3b41`, an exact match with the dispatch, so
no rollback path was reached. The dispatch declares no sibling rounds in flight.

This round is the first half of my own carry **C-RL-6**, raised one entry ago in
`J-rtl_lead-0015` Open-questions item 1 and now ruled by the orchestrator: the
emitter lands here, CI prints the snapshot's bytes, the snapshot lands in a
separate round. The dispatch adds one condition I did not write into the carry
and which is the real content of this entry — **verify, before writing anything,
that the red this commit creates is a source and not a dead end.**

### Inputs

- `agents/charters/rtl_lead.md` and `agents/PROTOCOL.md` in full (mandatory
  first actions; §5's DoD and §6's determinism criterion are what this round is
  measured against, PROTOCOL §6's write-scope row is what bounds it).
- `bin/generate.ml` at `36e3a4d` in full — the file I edited, read whole first
  because its two block comments are the record of the `word_counter_top`
  lesson and a registration that contradicted them would be a silent deviation.
- `bin/dune`, `libs/hardcaml_ethernet/src/dune` — read to establish that neither
  needs an edit (§3 below).
- `libs/hardcaml_ethernet/src/eth_axis_rx.mli` and the `create`/`hierarchical`
  definitions and I/O records of `eth_axis_rx.ml` — **read only**; M06's source
  is landed and this round does not open `libs/**` for writing.
- `.github/workflows/build.yml` in full, and **the body of its
  `Verify nothing was left unpromoted or non-deterministic` step verbatim** —
  the object of the mandated verification.
- `.gitignore`, plus a `git check-ignore` probe on the path that does not yet
  exist (§4).
- `tools/check_emitted_verilog.sh` — the header block and the REQ-808 branch at
  lines 836–856; `tools/dv_checks.sh`'s header. Read to establish what the
  *next* round's promoted bytes will meet, and that this round never reaches
  either script.
- `tools/cosim/run_cosim.sh` — grepped for `generate.exe` and `rtl_snapshots`:
  no hit, so the `cosim` job is not a second red.
- `docs/specs/architecture.md` §4's module inventory (M06's row fixes the
  emitted name and therefore the file name) and
  `docs/specs/modules/eth_axis_rx.md` §10's REQ-903/REQ-808 row.
- `docs/adr/ADR-0005` — CI as the only authoritative build surface, which is the
  premise the whole two-commit sequence rests on.
- My own `J-rtl_lead-0015` (C-RL-6 as written) and `J-rtl_lead-0014` §5's ledger.
- **No `test/third_party/` material opened this round; no
  Essenceia/Nasdaq-HFT-FPGA material consulted, for this or anything in it**
  (charter §8, Inputs honesty). Nothing about registering an emitter has a prior-
  art question in it.

### Reasoning

#### 1. The decision restated, because taking it deliberately is the whole point

The emitter and the snapshot cannot land in one commit. `rtl_snapshots/**` is a
build product of a toolchain this container does not have (ADR-0005: opam
downloads are blocked, CI is where OCaml correctness is established), so the
only bytes that may enter `rtl_snapshots/eth_axis_rx.v` are bytes CI produced.
CI produces them by failing: the determinism step diffs the working tree after
generation and prints what it found. So the sequence is forced —

1. this commit registers the emitter and ships **no** snapshot;
2. `build` goes red at one named step and prints the file;
3. a later round commits those bytes verbatim.

The alternative — hand-authoring `rtl_snapshots/eth_axis_rx.v`, or a placeholder
— was refused, and not on taste. A hand-authored snapshot is a machine-produced
expectation authored by the party it grades, which is the same failure the
promotion discipline exists to prevent; and a *placeholder* is worse than the
absence, because the determinism step's failure would then read as "drift"
rather than "never committed", and the promotion block would still be the true
bytes while the diff invited a reader to believe the placeholder had ever meant
anything. **The absence is legible; a placeholder is a lie with a diff.**

#### 2. Which horn of the naming problem M06 takes

`bin/generate.ml`'s existing comment already records the lesson: `Word_counter`
is emitted through `hierarchical` under a *renamed* top (`word_counter_top`),
because a top and the hierarchical module it instantiates may not share a name —
`Rtl.output` then drops the inner module's logic and emits a self-instantiating
shell. M03/M04/M05 take the other horn: build the top with `create`, name it the
inventory name, and let the scope database supply the children.

M06 takes the M03–M05 horn, and I wrote into the comment *why it still matters
for a module with no children*. SPEC-M06 §1 says `Eth_axis_rx` instantiates
nothing, so its circuit database is empty either way and the "supplies the
children" half of the argument is vacuous here. The other half is not: emitting
through `Eth_axis_rx.hierarchical` under `~name:"eth_axis_rx"` reproduces the
`word_counter_top` collision exactly, and the emitted file would be a shell
instantiating a module that is not in it — a file that looks plausible, passes a
name check, and contains no logic. The renaming escape (`..._top`) is closed for
a design module by REQ-808: `tools/check_emitted_verilog.sh` tolerates
`word_counter_top` only through an explicit bootstrap allowance, and any other
non-inventory emitted name is a FAIL there. So `create` is not a preference, it
is the only conformant option, and the comment now says so.

`~name:"eth_axis_rx"` is the same string `eth_axis_rx.ml`'s own `hierarchical`
registers, so M06 has one name in the netlist whether it is emitted standalone
here or instantiated by a future parent. The path is `rtl_snapshots/eth_axis_rx.v`
— file named after its top, as the other four are, and as architecture.md §4's
M06 row and SPEC-M06 §10's REQ-808 row require.

#### 3. What did **not** need to change, established rather than assumed

`libs/hardcaml_ethernet/src/dune` has no `(modules)` field, so the library
already exports `Eth_axis_rx` and `open Hardcaml_ethernet` at the top of
`generate.ml` already brings it into scope; `bin/dune` already lists
`hardcaml_ethernet`. **No dune file is touched this round**, which is worth
stating because dune/opam project files are the orchestrator's scope (charter
§7, E3) and a registration that had needed one would have been an escalation
rather than an edit.

#### 4. THE MANDATED CHECK: is the missing-snapshot red a source or a dead end?

The dispatch's STOP condition is precise — a determinism check that only handles
a *differing* snapshot would leave a missing one as a red with nothing in it, and
the next round would have no bytes to promote. **It is a source.** Three findings,
each measured rather than reasoned:

**(a) The step stages untracked files first.** Its body opens with `git add -A`,
and its own comment names this exact case as one of the three it is built to
catch — "a generated file that was never committed (plain `git diff` ignores
untracked files, so stage everything first)". `git diff --cached --exit-code`
then sees a *new file* diff, not a modification, and exits nonzero the same way.
The missing case is not a special case in this check; `git add -A` collapses it
into the differing case before the comparison happens.

**(b) Nothing hides the path from `git add -A`.** `.gitignore` covers `_build/`,
`_opam/`, `*.install`, `.merlin`, market data, `tools/data/` and editor noise —
no `*.v`, no `rtl_snapshots`. `git check-ignore -v rtl_snapshots/eth_axis_rx.v`
exits 1 (not ignored) at this commit, for a path that does not exist yet. Had it
exited 0 this whole round would have been a STOP: the step would have gone
**green** with the snapshot silently absent, which is a far worse outcome than a
red, because the absence would then never surface at all.

**(c) The promotion loop takes its file branch, not its deleted branch.** The
loop tests `[ -f "$f" ]`; a newly generated file exists on disk, so it prints
`--- FILE <path>`, `sha256sum`, `base64 -w 400`, `--- END <path>`. I ran the
step's body verbatim against a throwaway repo staging one never-committed file
under `rtl_snapshots/` (§Evidence) and got exactly that block. The `--- DELETED`
branch, which would have been the dead end, is unreachable here.

So the red prints the snapshot's bytes, checksummed. **No STOP is owed and none
is raised**; the check needs no missing-file branch, and no repair — mine,
dv_lead's or CI's — is proposed.

#### 5. Which step goes red, and why no earlier step pre-empts it

Named exactly, because "the build will be red" is not a prediction anyone can
falsify. The failing step is **`Verify nothing was left unpromoted or
non-deterministic`**, in job **`build`**, `.github/workflows/build.yml:57`. The
three steps ahead of it cannot fire first:

- **`Build`** (`dune build @default`) — reached, and passes or fails on my OCaml
  alone. If it fails, that is a defect in this commit, not the scheduled red, and
  it prints a compiler error rather than a promotion block. See §6 for what I do
  and do not claim about it.
- **`Run tests (expect tests, waveform snapshots)`** — cannot see the new file:
  it runs *before* `Generate RTL`, so the snapshot does not exist yet, and its
  own promotion block lists `git diff --name-only` (tracked modifications) which
  would not list an untracked path even if it did. No dune rule anywhere depends
  on `rtl_snapshots/**` — the only two `dune` files mentioning it (`test/cosim`,
  `test/xgmii_rx_64`) mention it in `;` comments asserting they never opened it —
  so `dune runtest` is blind to this change by construction.
- **`Generate RTL`** (`dune exec bin/generate.exe`) — reached, and the one place
  a different red could appear: `Circuit.create_exn` raises on a duplicate port
  name. M06's records carry `[@rtlprefix]` `rx_`, `hdr_` and `payload_` over
  three nested interfaces plus bare `clock`, `clear`, `error_short_frame`, so no
  two flattened names collide as far as reading can establish. If it raises
  anyway, that is a **defect report to make, not a promotion to harvest**, and
  the two are told apart by which step's name appears in the log.

Consequences to expect and not misread: the two steps *after* the determinism
step — `DV mechanical checks (C-9 record-vs-appendix, X-9 emitted Verilog)` and
`Abort-bit availability quantifier` — **do not run at all** this round, since a
failed step skips the rest of the job. Their silence this round is not a result.
The `cosim` job is a separate job, does not reference `generate.exe` or
`rtl_snapshots/**`, and should be unaffected — if `cosim` goes red on this
commit, that is not this commit's doing and should be investigated as such.

#### 6. What the next round's bytes will meet, checked now so the promotion is not a gamble

`tools/check_emitted_verilog.sh`'s REQ-808 branch distinguishes two lists: an
emitted module absent from architecture.md §4 is `fail`; an inventory module not
yet emitted is `pend` with the note that REQ-808 "passes only when this list is
empty; that is a P1-module-ready condition". `Eth_axis_rx` is inventory row M06,
so the promoted snapshot arrives as an inventory name and **cannot** land as an
`extra`. REQ-808 does not turn green on it either — M07…M20 remain unemitted, so
it stays `pend` with one fewer name. Stating both halves matters: a promotion
round that expected REQ-808 to go green would read a correct `pend` as a
regression.

REQ-903's two parts are already satisfied by the source landed last round (an
`.mli` exists; `hierarchical` is exported) and neither is affected by this
registration.

#### 7. What this entry deliberately does not claim

**M06 has still never been compiled by anything.** The parse check below sees
syntax and nothing else — not a type, not a width, not the existence of
`Eth_axis_rx.create`'s arity as I used it, not a warning-as-error under the dev
profile. `bin/generate.ml` is now a file that *should* build; whether it does is
the `Build` step's verdict, in a run whose id belongs in whatever entry reads it.
**No run id is cited here because no run has executed this commit.** Equally not
claimed: that `rtl_snapshots/eth_axis_rx.v` will contain a correct netlist (its
correctness is dv_lead's and the co-sim lane's to establish, and its *existence*
is the next round's); that determinism holds for M06 (REQ-902's two-run byte
identity is a CI observation about bytes that do not exist yet); that the
line-rate invariant is demonstrated.

### Actions

1. Ran the abort-first head check, then read the charter, PROTOCOL, and the
   round's inputs listed above.
2. Ran the mandated missing-snapshot verification **before editing anything** —
   `.gitignore` probe plus the workflow step's body executed verbatim in a
   throwaway repo (§4) — and confirmed the red is a promotion source.
3. Edited `bin/generate.ml` and nothing else: added `emit_eth_axis_rx` in the
   M03/M04/M05 pattern (`create`, `~name:"eth_axis_rx"`, own scope, one
   `Rtl.output`), appended `"rtl_snapshots/eth_axis_rx.v", emit_eth_axis_rx` to
   the emission list after M05, and updated the two block comments that had
   enumerated exactly three design modules so they remain true at four, adding
   the paragraph recording why a childless module still may not take the
   `hierarchical` horn (§2).
4. **Created no file under `rtl_snapshots/`** — no snapshot, no placeholder, no
   empty file.
5. Parse-checked the edit with two negative controls, one of them shaped like
   the edit itself (§Evidence), and ran the line-width check.
6. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no
   `scripts/agent_commit.sh`, no git write of any kind.**

### Evidence

Reproducible from a checkout at this commit:

```sh
git status --short
#    M bin/generate.ml            (plus this journal; nothing else)

git diff bin/generate.ml
#   one new emitter, one list row, two comment updates

# the library needs no dune edit: no (modules) field
cat libs/hardcaml_ethernet/src/dune
```

**Parse check with negative controls, because a check that cannot report failure
is not a check:**

```sh
ocamlc -stop-after parsing -c bin/generate.ml          # exit 0
printf 'let x = (1 +\n' > /tmp/bad.ml
ocamlc -stop-after parsing -c /tmp/bad.ml              # exit 2, "Syntax error"
printf 'let f o =\n  let module C = Circuit.With_interface (A.I) (A.O in\n  C.create_exn ~name:"x" o\n;;\n' > /tmp/bad2.ml
ocamlc -stop-after parsing -c /tmp/bad2.ml             # exit 2, "')' expected"

awk 'length>90 {print FILENAME": "FNR}' bin/generate.ml   # (no output; janestreet margin)
```

The second control is the one that counts: it is a malformed
`Circuit.With_interface` application, the exact construct this round added, and
the parser rejects it — so the positive result above is discriminating over the
edit's own shape and not merely over "the file is still OCaml".

**The missing-snapshot check (§4), the workflow step's body run verbatim:**

```sh
sed -n '57,84p' .github/workflows/build.yml     # the step, its name and its body
git check-ignore -v rtl_snapshots/eth_axis_rx.v ; echo "exit=$?"   # exit=1, not ignored

D=$(mktemp -d) && cd "$D" && git init -q . && mkdir rtl_snapshots &&
printf 'module a;\nendmodule\n' > rtl_snapshots/a.v && git add -A &&
git -c user.email=a@b -c user.name=c commit -qm base &&
printf 'module eth_axis_rx;\nendmodule\n' > rtl_snapshots/eth_axis_rx.v
git add -A
git diff --cached --exit-code >/dev/null || {
  git diff --cached --name-only | while read -r f; do
    if [ -f "$f" ]; then echo "--- FILE $f"; sha256sum "$f"; base64 -w 400 "$f";
      echo "--- END $f"; else echo "--- DELETED $f"; fi
  done
  echo "step-would-exit 1"
}
rm -rf "$D"
```

observed:

```text
--- FILE rtl_snapshots/eth_axis_rx.v
5240252f7f39bed76bd2dd46bff4192ef865f01e781f499e6ec708b3f1408bcb  rtl_snapshots/eth_axis_rx.v
bW9kdWxlIGV0aF9heGlzX3J4OwplbmRtb2R1bGUK
--- END rtl_snapshots/eth_axis_rx.v
step-would-exit 1
```

— a never-committed file under `rtl_snapshots/` produces a `--- FILE` entry with
its sha256 and its base64, which is a promotion source. The stand-in's contents
are two lines of my own invention and prove nothing about M06's netlist; what
they establish is the **shape of the step's behaviour on an untracked path**,
which is the only thing in question.

**Precedent that the block's payload survives a real snapshot's size**: the
largest file in `rtl_snapshots/` is `eth_mac_10g.v` at 112,000 bytes, and
`git log --oneline -- rtl_snapshots/eth_mac_10g.v` shows it entering at `42b9df3`
("snapshots promoted verbatim from run 30918948889"). So this mechanism has
already carried a 112 KB file through a log tail. M06 instantiates nothing and
will be smaller; I do not predict a figure.

**REQ-808's two branches, read at the source:**

```sh
sed -n '836,856p' tools/check_emitted_verilog.sh
#   extra   -> fail "emitted module(s) not in the architecture.md §4 inventory"
#   missing -> pend "inventory module(s) not yet emitted"
sed -n '/^| M06 /p' docs/specs/architecture.md    # Eth_axis_rx is an inventory row
```

**THE PREDICTION THIS ENTRY EXISTS TO MAKE, stated so the next red is scheduled
rather than discovered.** At the commit carrying this entry, the `build`
workflow **WILL FAIL**, at the step named
**`Verify nothing was left unpromoted or non-deterministic`** (job `build`,
`.github/workflows/build.yml:57`), printing a `=== PROMOTION BLOCK ===` whose
single `--- FILE` entry is `rtl_snapshots/eth_axis_rx.v` with its sha256 and its
base64. Those bytes are the snapshot, and committing them verbatim is the next
round. A red at any *other* step of this workflow is **not** this prediction
coming true and must be read as a defect in this commit.

**Not claimed** (§7): that `bin/generate.ml` compiles; that `generate.exe` runs;
that the emitted netlist is correct or deterministic; any DV result. `SO-` is
dv_lead's to give and none is implied.

### Outcome

M06 is registered in the RTL emission path in the established pattern, and the
determinism step has been shown — by executing it, not by reading it — to turn
this commit's missing snapshot into that snapshot's bytes.

Charter §5's DoD, scored against what this round was actually for:

- Implements its frozen spec, deviations escalated — **no instance this round**;
  no `libs/**` file was opened for writing and M06's conformance to SPEC-M06 is
  `J-rtl_lead-0015`'s claim, unchanged and not re-asserted here.
- `bin/generate.exe` emits it into `rtl_snapshots/**` deterministically, two
  consecutive runs byte-identical — **NOT met, deliberately and visibly.** The
  emitter is registered; the snapshot does not exist; determinism is a property
  of bytes not yet produced. This is the half of C-RL-6 that a second commit
  closes, and the red between them is the mechanism, not a lapse.
- House style / `.ocamlformat` clean — the edit follows the three sibling
  emitters character for character in structure; **`ocamlformat` itself is NOT
  run** (not installed here), line width is checked.
- Rx-path line-rate invariant — no instance; no RTL changed.
- Worker review — no instance; no worker, no `RV-`.
- Journal entry appended, no DV sign-off claimed — **met.**

Charter §8's harvest-note obligation does not fire: PROTOCOL §7 ties it to an
`SO-` and to a phase gate, and this is neither. Span bookkeeping is unchanged —
this seat's next harvest still opens at `J-rtl_lead-0013` (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator, for commit and for the board note the dispatch
promised — the red window between this commit and the promotion commit is open
from the moment this lands, and its expected shape is in Evidence above so that
the board entry and the CI log can be compared line for line.

### Open-questions

1. **C-RL-6 is half discharged and I am splitting it rather than closing it.**
   **C-RL-6a — `rtl_snapshots/eth_axis_rx.v` is owed**, promoted verbatim from
   the `PROMOTION BLOCK` this commit's CI run prints, in a round whose write set
   includes `rtl_snapshots/**` and whose entry cites the run id it harvested. The
   generator half is done here. Until 6a lands, `build` is red on this branch by
   design and every agent reading CI should know why.
2. **The red window is a real cost and I will not describe it as free.** While it
   is open, `build` cannot certify anything else on this branch: a genuine
   regression landing in the same window would be masked by a failure everyone
   has been told to expect. That is an argument for keeping the window to one
   round — the promotion commit should be the *next* commit on this branch, not
   the next convenient one.
3. **C-RL-7 — SPEC-M06 §7 and §10's retired per-octet-under-injection reading**,
   carried unchanged from `J-rtl_lead-0015` item 2; architect_docs_lead's, and
   untouched by this round.
4. **Carried, unchanged and untouched**: C-RL-2 (the latent `first_v` gating in
   M03), C-RL-3 (sub-word idle granularity, no row owed), and item 3 of
   `J-rtl_lead-0015` (M06 has had no independent design review — registering its
   emitter does not review its logic and nothing here should be read as having
   done so).

### Files-in-this-commit

- bin/generate.ml

## [J-rtl_lead-0017] 2026-08-11T07:10:00Z | task:none | C-RL-6a discharged and the red window closed: `rtl_snapshots/eth_axis_rx.v` promoted from run 31465181652's own failure, re-derived from the log through two mutually independent channels before a byte was placed, and the emitted netlist read as reviewer without being touched

### Trigger

Orchestrator dispatch, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`,
spawn-head `e9f371b`. Abort-first head check ran before any read of substance:
`git status --short` printed nothing and `git rev-parse HEAD` returned
`e9f371b34df806cbdcce3d1578465f748152e9e6`, an exact match with the dispatch, so
no rollback path was reached. The dispatch declares no sibling rounds in flight.

This round is **C-RL-6a**, the carry I split out of C-RL-6 one entry ago (the
`J-rtl_lead-0016` Open-questions item that reads "`rtl_snapshots/eth_axis_rx.v`
is owed, promoted verbatim from the `PROMOTION BLOCK` this commit's CI run
prints"). The generator half landed at `e9f371b`; CI ran it and went red exactly
where that entry said it would; this round carries the bytes it printed. The
same item argued the promotion commit should be the *next* commit on this branch
rather than the next convenient one, because a red `build` masks any genuine
regression landing beside it — that argument is discharged here rather than
merely repeated.

### Inputs

- `agents/charters/rtl_lead.md` and `agents/PROTOCOL.md` in full (mandatory first
  actions; PROTOCOL §6's write-scope row bounds this round to one new file).
- **The CI log of run 31465181652**, job `build`, step `Verify nothing was left
  unpromoted or non-deterministic`. The orchestrator placed a copy at a
  scratchpad path and a decode of the payload beside it; **both are ephemeral
  container artifacts and neither is evidence** (ADR-0003/F5). The durable
  references are the run id `31465181652` and the payload sha256
  `0ab634e1628e40502dcb521c0be64b9975d59e28e252e007125902bfd5257564`, and the
  bytes now in the tree carry that sha.
- My own `J-rtl_lead-0016` in full — §6 (what the promoted bytes would meet) and
  the Evidence prediction, both of which this round scores rather than restates.
- `docs/specs/modules/eth_axis_rx.md` §4.1 (interface records) and §4.2 (the
  nineteen-row port table), for the reviewer read.
- `libs/hardcaml_ethernet/src/eth_axis_rx.mli` and the `[@rtlprefix]`-bearing
  record declarations in `eth_axis_rx.ml`; `libs/hardcaml_ethernet/src/axi64.ml`
  §`Axi64_config`/`Eth_header` for the field names and widths the prefixes act
  on. **Read only** — `libs/**` was not opened for writing this round.
- `tools/check_emitted_verilog.sh` — read at the REQ-808 branch, and **executed**
  (§Evidence 4). It is dv_lead's script; running it read-only against a build
  product is not authoring it, and no line of it was edited.
- `.gitattributes` — probed and absent, so no eol/filter attribute can rewrite
  the promoted bytes on staging (§Reasoning 2c).
- **No `test/third_party/` material opened this round; no
  Essenceia/Nasdaq-HFT-FPGA material consulted, for this or anything in it**
  (charter §8, Inputs honesty). Transcribing a machine's output has no prior-art
  question in it.

### Reasoning

#### 1. Why I re-derived bytes that had already been decoded for me

The dispatch handed me a decoded file and its sha and asked me to derive the
payload myself anyway. That instruction is the whole content of the round and I
want to record why it is right rather than merely comply.

The promotion discipline exists because `rtl_snapshots/**` is a build product of
a toolchain this container does not have (ADR-0005), so the *only* defensible
provenance for these bytes is "CI emitted them, and I moved them". A decode I did
not perform breaks that sentence in the middle: the bytes would then be CI's as
far as the orchestrator could tell, and the orchestrator's as far as I could tell.
The failure this guards against is not dishonesty; it is an ordinary transcription
accident — a truncated log fetch, a line-wrapped paste, a stripped prefix that ate
one payload character — which produces a file that is *plausible Verilog* and
wrong. **A hand-checked sha is what makes "verbatim" a claim rather than a
courtesy**, and a sha I did not compute from bytes I did not assemble checks
nothing.

So: three quantities had to agree — the sha the block prints, the sha of the
orchestrator's decode, and the sha of my own decode — plus a byte-level `cmp`
between the two decodes, since two files can share nothing but a hash function's
output only under an assumption I do not need to make when `cmp` is free. All
four agreed (§Evidence 1).

#### 2. What "derive from the log" had to survive, enumerated before doing it

Three ways a log-to-bytes pipeline silently corrupts, each checked rather than
assumed:

**(a) The timestamp strip.** Every log line carries a `2026-08-11T06:33:08.xxxxxxxZ `
prefix. A fixed-width `cut` is wrong the moment one line's fractional seconds
differ in length; a greedy regex is wrong if it can match into base64 (it cannot —
the alphabet has no `Z` followed by a space, but "cannot" is the kind of claim
worth measuring). I measured the prefix width across all thirty lines of the block
under an anchored regex: uniformly 29, no line unmatched. I also checked the block
region for `CR` bytes and ANSI escapes — GitHub's log stream carries both
elsewhere in this same file, on the step's *echoed body* at lines 1130–1191 — and
found none inside the payload.

**(b) The line set.** I extracted the block **by its own `--- FILE` / `--- END`
markers**, not by the line numbers the dispatch gave me, so a mis-cited line range
could not silently truncate the payload. The arithmetic then has to close, and it
does: 27 base64 lines, 26 of them exactly 400 characters wide (`base64 -w 400`) and
one of 288, is 10,688 characters, which is 2,672 quartets, which is 8,016 bytes
less one `=` of padding — 8,015 bytes, the size the block's own file is. Nothing
outside the base64 alphabet appears in those 27 lines.

**(c) The write.** `cp` from my derived file, not a text editor and not a here-doc:
an editor that appends a trailing newline, normalises line endings, or strips
trailing whitespace would corrupt a build product in a way no reviewer would ever
see. The absence of `.gitattributes` matters for the same reason — no `text=auto`
or filter attribute can rewrite these bytes between the working tree and the index.
The placed file was re-hashed *after* writing (§Evidence 1), which is the only
check that covers the write itself.

#### 3. The second channel, which is what turns agreement into corroboration

Re-deriving the base64 twice would only prove my `sed` is deterministic. The log
contains an **independent encoding of the same file**: the `git diff --cached`
body printed above the promotion block, `@@ -0,0 +1,362 @@` followed by 362
`+`-prefixed lines. That channel and the base64 channel fail in disjoint ways — a
mis-stripped timestamp corrupts the diff reconstruction while leaving the base64
decodable, and a dropped payload line corrupts the base64 while leaving the diff
whole. Reconstructing the file from the `+` lines and `cmp`-ing it against the
base64 decode is therefore a real check, and it passes byte-for-byte (§Evidence 2).
With no `\ No newline at end of file` marker anywhere in the log and the derived
file ending in `\n`, the 362-line diff and the 8,015-byte payload describe the same
object with nothing left over.

#### 4. Nothing was added to the file, and the reason is not tidiness

No header comment, no provenance line, no `// generated by` banner. The temptation
is real — a snapshot whose own first line named the run that produced it would be
convenient — and it is a trap: `bin/generate.exe` does not emit such a line, so the
next run's regeneration would diff against it, the determinism step would print a
promotion block forever, and `build` would be permanently red for a comment. **The
provenance of a build product belongs in the commit that carries it, never in its
bytes.** This entry and the commit trailer are where run 31465181652 is recorded.

#### 5. The reviewer read: what it establishes, and the larger thing it does not

Charter §3's line-by-line duty attaches to shipped source and this snapshot ships,
so I read all 362 lines. Findings are in §Evidence 3 and the observations below;
**no defect was found and nothing was changed.** Three things are now established
mechanically rather than by eye: the module is named `eth_axis_rx` and is the only
module in the file; its nineteen ports set-equal SPEC-M06 §4.2's table on name,
direction *and* width, with no port outside the table and no row of the table
missing; and the file contains **no instantiation statement of any kind**, so the
`word_counter_top` failure mode that `J-rtl_lead-0016` §2 chose the `create` horn
to avoid — a shell instantiating a module absent from the file — did not occur.
That last one is the check the round was really for, since it is the failure that
passes a name check.

Four further observations, recorded as observations and not as verdicts:

- **`payload_tstrb` is tied to the constant 8'b0**, which is REQ-014's "reserved;
  driven to 0" read literally.
- **No `ready` or `tready` signal exists anywhere in the file**, in any direction.
  REQ-003's structural argument — that M06 cannot stall M03 because the record has
  nowhere to put a backpressure signal — survives emission, which is where a
  structural argument would fail if it were going to.
- **All sixteen sequential blocks are `always @(posedge _20)` with `_20 = clock`
  and a synchronous `if (_18)`, `_18 = clear`.** No second edge expression, no
  asynchronous reset, no latch-inferring block, no `initial`, no delay, no
  simulation-only construct, and every one of the 103 declared internal nets has a
  driver.
- **A one-cycle output suppression out of clear.** A register `_46` loads 0 while
  clear is asserted and `1'b1` otherwise, so `_48 = clear | ~_46` is high during
  clear *and* for the first cycle after it releases; that term gates `hdr_valid`,
  `payload_tvalid` and `error_short_frame` to 0. The behaviour is coherent for a
  synchronously-cleared design and I flag it not as a defect but as a fact a
  testbench author would otherwise discover as a surprise. Relatedly, the 2-bit
  state register decodes three encodings and *holds* on the fourth; `2'b11` is
  unreachable from the `2'b00` reset, and clear recovers it if it were ever
  reached.

**What this read is not**: it is not the independent design review of M06 that
`J-rtl_lead-0015` item 3 says is owed, and it cannot become one. Every internal
name in this file is an emitter-generated `_NN`; the file shows me structure with
the intent deleted. Whether `_32`'s three states are SPEC-M06 §6's states, whether
the ΔC = 3 pipeline holds, whether the `tkeep` realignment is the two positions
the spec fixes — none of that is legible here, and reading a netlist is the wrong
instrument for it. That carry stays open and this entry does not touch it.

#### 6. The forward check, measured this time instead of predicted

`J-rtl_lead-0016` §6 predicted that REQ-808 would remain `pend` with one fewer
name and warned that "a promotion round that expected REQ-808 to go green would
read a correct `pend` as a regression". I ran the check both ways rather than
asserting it (§Evidence 4): with the file absent the pend list is fifteen names
beginning `eth_axis_rx`; with it present the list is fourteen and `eth_axis_rx`
has moved to the emitted set. It did not land as an `extra` and REQ-808 did not
turn green. **That is the predicted correct `pend`, and it is a result, not a
regression.** REQ-001 also now counts 87 edge expressions where M06 contributes
16, all resolving to the clock port.

#### 7. What I expect of CI, stated so a second red is not read as a repeat

The determinism step should now pass, **conditional on something this branch has
never tested**: it passes iff `generate.exe`, run at the commit carrying this
entry, emits bytes equal to those it emitted at `e9f371b`. `bin/generate.ml` is
untouched this round and the run built exactly `e9f371b`, so the generator input
is identical and the only variable left is generation determinism itself — which
is precisely REQ-902's claim and has never been observed for M06, because until
now there was nothing to compare against. So: if the step goes green, that is
M06's first determinism datapoint. **If it goes red again printing a `--- FILE
rtl_snapshots/eth_axis_rx.v` block with a *different* sha, that is a determinism
defect and a real finding — it is emphatically not a promotion to repeat**, and
re-promoting the new bytes would launder a nondeterministic emitter into the tree.
Charter §6 makes determinism my criterion, so that case is mine to root-cause.

The two steps that were skipped last round — `DV mechanical checks` and
`Abort-bit availability quantifier` — should now execute for the first time since
`e9f371b`. Their verdicts are theirs and I predict neither; what I do claim is
that their silence last round was a skip and their output this round is not a
change of state in whatever they measure. `cosim` remains a separate job and this
round adds nothing it reads.

### Actions

1. Ran the abort-first head check, then read the charter, PROTOCOL, the round's
   dispatch and the inputs listed above.
2. Re-derived the payload from the log independently: extracted the block by its
   own markers, measured the timestamp prefix and payload charset, concatenated
   the 27 base64 lines, decoded, and hashed — then compared against the block's
   own sha and against the orchestrator's decode, with a one-byte perturbation as
   a negative control on the comparison itself.
3. Reconstructed the same file a second time from the log's `git diff` `+` lines
   and `cmp`-ed the two reconstructions against each other.
4. Placed **my own derived bytes** (not the orchestrator's file) at
   `rtl_snapshots/eth_axis_rx.v` with `cp`, then re-hashed the placed file.
5. Read all 362 emitted lines as reviewer and ran the structural checks in
   §Evidence 3. **Changed nothing**; no defect found.
6. Ran `tools/check_emitted_verilog.sh` with the snapshot present and absent, and
   restored the file and re-verified its sha after the absent-case run.
7. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no
   `scripts/agent_commit.sh`, no git write of any kind.** No file outside
   `rtl_snapshots/eth_axis_rx.v` and this journal was created or modified.

### Evidence

Provenance, externally verifiable: **build run `31465181652`**, job `build`, step
`Verify nothing was left unpromoted or non-deterministic`, conclusion failure.
The run's log records the fetch of
`e9f371b34df806cbdcce3d1578465f748152e9e6` — this branch's HEAD at this round —
and its only `##[error]` is that step, with `dune build @default`, `dune runtest`
and `dune exec bin/generate.exe` all having run ahead of it without error. That
disposes of `J-rtl_lead-0016` §5's three alternatives by observation: the red is
the scheduled one, at the named step, and not a compile failure or a
`Circuit.create_exn` duplicate-port raise.

**1. The three-way sha agreement and the write.** From the log's block, after
stripping the uniform 29-character timestamp prefix:

```text
block's own sha line : 0ab634e1628e40502dcb521c0be64b9975d59e28e252e007125902bfd5257564
my decode            : 0ab634e1628e40502dcb521c0be64b9975d59e28e252e007125902bfd5257564   (8015 bytes)
orchestrator's decode: 0ab634e1628e40502dcb521c0be64b9975d59e28e252e007125902bfd5257564
cmp mine vs theirs   : exit 0, no output
```

and after `cp` into the tree, `sha256sum rtl_snapshots/eth_axis_rx.v` reproduces
`0ab634e1…7564` at 8,015 bytes, which is the check that covers the write itself.
Reproducible at this commit:

```sh
sha256sum rtl_snapshots/eth_axis_rx.v   # 0ab634e1628e40502dcb521c0be64b9975d59e28e252e007125902bfd5257564
wc -c    < rtl_snapshots/eth_axis_rx.v   # 8015
```

*Negative control, because a comparison that cannot report a difference is not a
comparison*: perturbing one byte at offset 100 of my derived file moves the sha to
`9b94f715e648…` and `cmp` reports the difference. The pipeline discriminates.

**2. The second channel.** Reconstructing the file from the log's own
`@@ -0,0 +1,362 @@` hunk by stripping the `+` prefixes yields 362 lines, and

```text
cmp  <diff-reconstruction>  <base64-derivation>   ->  exit 0
```

The log contains no `\ No newline at end of file` marker and the derived file's
last byte is `\n`, so the two encodings agree on the terminator too.

**3. The reviewer read, mechanised where it can be.** All commands runnable from a
checkout at this commit:

```sh
grep -c '^module\|^endmodule' rtl_snapshots/eth_axis_rx.v      # 2 — one module, line 1 and line 362
grep -nE '^\s+[A-Za-z_][A-Za-z0-9_]*\s+[A-Za-z_][A-Za-z0-9_]*\s*\(' rtl_snapshots/eth_axis_rx.v
#   no match — no instantiation statement of any kind, so no self-instantiating shell
grep -n 'tready\|ready'   rtl_snapshots/eth_axis_rx.v          # no match — REQ-003 survives emission
grep -n 'always @' rtl_snapshots/eth_axis_rx.v | grep -v 'always @(posedge _20) begin'
#   no match — all 16 sequential blocks are posedge clock, sync clear
grep -n 'initial\|#[0-9]\|\$display\|\$finish' rtl_snapshots/eth_axis_rx.v   # no match
```

Port table conformance, by set comparison rather than by eye — the emitted
`input`/`output` declarations rendered as `name|dir|width` and diffed against
SPEC-M06 §4.2's nineteen rows rendered the same way:

```text
diff <emitted 19> <spec 19>  ->  empty
```

8 inputs, 11 outputs, each appearing exactly once, each driven by exactly one
`assign`, and every one of the 103 declared internal nets has a driver (the
difference `declared nets − driven names` is empty).

**4. REQ-808's A/B, run both ways.** `tools/check_emitted_verilog.sh` at this
commit:

```text
with    rtl_snapshots/eth_axis_rx.v present:
  emitted modules: crc32_eth eth_axis_rx eth_mac_10g word_counter word_counter_top xgmii_rx_64 xgmii_tx_64
  PASS     REQ-001 single clock domain: all 87 edge expression(s) ... resolve to the clock port
  PENDING  REQ-808: inventory module(s) not yet emitted: eth_axis_tx eth_demux ... nic_top   (14 names)
  5 check(s) run, 0 failure(s), 3 pending

with it absent (the HEAD state):
  PENDING  REQ-808: inventory module(s) not yet emitted: eth_axis_rx eth_axis_tx ... nic_top  (15 names)
```

— `eth_axis_rx` leaves the unemitted list and enters the emitted set; REQ-808 does
not `fail` (it is an inventory name, never an `extra`) and does not turn green
(M07…M20 remain). One fewer name, still `pend`, exactly as `J-rtl_lead-0016` §6
said it would be. The file was restored and re-hashed after the absent-case run.

**Ephemeral, and named as such** (ADR-0003/F5): the log copy and the
orchestrator's decode live at container scratchpad paths that do not survive this
session and are not citable evidence. Everything above either runs from a checkout
at this commit or is the run id `31465181652`, whose conclusion GitHub holds.

**Not claimed**: that the emitted netlist is *correct* — 362 lines of `_NN` nets
cannot establish that and §5 says why; that determinism holds (§7: the next run is
the first observation, not a foregone one); that the line-rate invariant is
demonstrated; any DV result. `SO-` is dv_lead's to give and none is implied.

### Outcome

C-RL-6 is now fully discharged: the emitter landed at `e9f371b`, CI produced the
bytes by failing, and those bytes are in the tree with their provenance recorded.
The red window `J-rtl_lead-0016` opened by design was one commit wide, which is
what that entry argued it had to be.

Charter §5's DoD, scored against what this round was actually for:

- Implements its frozen spec, deviations escalated — **no instance for authorship**
  (no `libs/**` file was opened for writing); for the artifact, the emitted
  interface set-equals SPEC-M06 §4.2 on all nineteen ports and no deviation was
  found to escalate.
- `bin/generate.exe` emits it into `rtl_snapshots/**` deterministically, two
  consecutive runs byte-identical — **partially met, and the gap is named.** The
  snapshot now exists and is CI's own output at a known run; the *two-run byte
  identity* half is unobservable from this container (ADR-0005) and becomes
  observable for the first time on the next CI run, per §7. I do not score a
  criterion I cannot execute.
- House style / `.ocamlformat` clean — **no instance**; no OCaml was written.
- Rx-path line-rate invariant — **no instance this round**; no RTL logic changed.
  The structural half of REQ-003 was *observed to survive emission* (§Evidence 3),
  which is a check, not a demonstration of the invariant.
- Worker review — no instance; no worker, no `RV-`.
- Journal entry appended, no DV sign-off claimed — **met.**

Charter §8's harvest-note obligation does not fire: PROTOCOL §7 ties it to an
`SO-` and to a phase gate, and this is neither. Span bookkeeping unchanged — this
seat's next harvest still opens at `J-rtl_lead-0013` (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator, for commit. The one thing worth watching on the
run this commit triggers is stated in §7 and is falsifiable: green at the
determinism step is M06's first determinism datapoint; a second red printing a
*different* sha for the same path is a determinism defect that comes back to me
and must not be re-promoted.

### Open-questions

1. **M06's emission determinism is asserted by no one yet.** REQ-902's two-run
   byte identity has never been observed for this module and cannot be observed
   here. The next CI run is its first test; §7 states both branches and which of
   them is mine to root-cause. This is a watch item, not a carry — it resolves on
   its own within one run.
2. **C-RL-7 — SPEC-M06 §7 and §10's retired per-octet-under-injection reading**,
   carried unchanged from `J-rtl_lead-0015` item 2 and `J-rtl_lead-0016` item 3;
   architect_docs_lead's, and untouched by this round.
3. **M06 has still had no independent design review.** Carried from
   `J-rtl_lead-0015` item 3 and restated here because this round could be
   misread as having done it: reading the emitted netlist reviewed the *artifact*,
   and §5 explains why a file of `_NN` nets cannot review the design. What M06's
   logic does against SPEC-M06 §6 remains unreviewed by anyone but its author.
4. **Carried, unchanged and untouched**: C-RL-2 (the latent `first_v` gating in
   M03) and C-RL-3 (sub-word idle granularity, no row owed).

### Files-in-this-commit

- rtl_snapshots/eth_axis_rx.v

## [J-rtl_lead-0018] 2026-08-11T10:05:00Z | task:BUG-0004 | M04's underflow window was encoded as "the `tlast` word was accepted *since the frame started*" and the frame-boundary clear outranked the set term, so at `W` = 1 — where the two events are one event — the design threw away the acceptance that closes the window; the repair moves the set outside the clear and seeds the clear from what is already held

### Trigger

Orchestrator spawn against `BUG-0004` (dv_lead's packet, **VERBATIM** relay class),
branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`, spawn-head `fcf6f08`,
precheck clean and confirmed (`git status --short` empty, `git rev-parse HEAD` =
`fcf6f084747b2704c9100acd76dffedbb8ae8f73`). The packet is dv_lead's adjudication
at `J-dv_lead-0175` of the **first execution** of the M04 bench against the M04
design — `WO-0080` §15 class **D1**, a design defect and not a bounce — and the
spawn relayed §3's derivation verbatim rather than summarizing it. Bounded round:
the bug only. The M06 design review does not fold in.

### Inputs

- `agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md` — read
  in full at `fcf6f08`, twice: §1's reproduction and the stimulus stated so it can
  be rebuilt without the bench, §2's observed/expected and the three named clause
  breaches, §3's derivation that REQ-206's window is **empty** at `W` = 1, §4's
  exclusion of the presenter and of the monitor's model plus the selectivity
  brackets, §5's four fix obligations, §6's severity and reachability argument,
  §7's four non-claims, §8's re-test protocol.
- `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` at `fcf6f08` — my own module, read
  end to end and then traced: the reset window and `clear_d` (155–168), the
  two-entry `hold` structure and `fill` (169–200), the position sequence and
  `end_now`/`have_end`/`payload_end` (201–227), `need_payload`/`starved`/`consume`
  and `start_now`/`can_start`/`word_available` (306–322), and the underflow block
  itself (332–355).
- `docs/specs/modules/xgmii_tx_64.md` (SPEC-M04) at `fcf6f08` — §6.1's `P` = 60
  cycle table and its two-words-in-flight paragraph, §6.2's state table **including
  the `Idle` row's second "Leaves to" clause** and the C-16 early-acceptance
  paragraph, §6.3's unconstrained list, §7's C-14.1 `tx_tready` bullet, the C-16
  bullet's four consequences **and its "why this value is load-bearing" note about
  M07**, the handshake bullet, the reset bullet, §8, §9's table and its pinned
  strobe cycle.
- `docs/specs/requirements.md` REQ-206 as reproduced verbatim in the packet §3.
- `agents/PROTOCOL.md` §3–§6, §10; `agents/charters/rtl_lead.md` (§3 bug lane, §5
  DoD, §7 escalation classes, §8 root-cause-before-fix).
- My own `J-rtl_lead-0002` (M04's authoring entry, WO-0024, design at `f840475` —
  the C-16 paragraph quoted in Root cause below), and `J-rtl_lead-0016` /
  `J-rtl_lead-0017` for the emitter-arc precedent §Evidence 4 leans on.
- `.github/workflows/build.yml` (step order, which is what makes §Evidence 4's
  claim about the re-test's readability true rather than hopeful),
  `bin/generate.ml` (which emitters consume `Xgmii_tx_64.create`), and the two
  affected files under `rtl_snapshots/` read only for their `^module` lines.
- **Not opened**: anything under `test/**` — the three failing units, `bench.ml`,
  `strobe_monitor.ml` and `AP-xgmii_tx_64` are known to me only through this
  packet's own text, which is the whole reason §8's closing rule can be satisfied
  by construction rather than by promise. Nothing under `docs/reports/audit/**`.
- No Essenceia material consulted (charter §8, Inputs honesty).

### Reasoning

#### Root cause

**One register, and a priority inversion inside its next-value mux.** The strobe
expression is §9's condition term for term and is not where the defect is:

```ocaml
let underflow = tready &: ~:(i.tx.tvalid) &: frame_active &: ~:last_accepted in
```

`frame_active` is REQ-206's lower bound (the start character on the wire) and
`last_accepted` is its upper bound — *has this frame's `tlast` word been
accepted?* The bound is the right question. Its encoding was not:

```ocaml
(* at fcf6f08 *)
last_accepted <== reg spec (mux2 start_now gnd (last_accepted |: (accept &: i.tx.tlast)));
```

The frame-boundary clear sits **above** the set term, so read as a predicate this
register says "the `tlast` word has been accepted **since the frame started**".
That is the intended predicate only while the two events fall on **different
cycles**. At `W` = 1 they are the same cycle — the frame's first word *is* its
`tlast` word, and this module enters the frame on the cycle it accepts a first
word (`start_now`; §6.2's `Preamble` is that same cycle here, which is the
mapping the module doc already states and REQ-210's one-cycle event delay is why)
— so `start_now` and `accept & tlast` fire together, the clear discards the very
acceptance that closes the window, and the window is left open on a frame that
owes nothing further.

Traced against the packet's §1 stimulus, with `C` = 1 because §7's reset clause
holds `tx_tready` = 0 through cycle 0:

| cycle | phase | `fill` | `tready` | `tvalid` | `frame_active` | `last_accepted` | `error_underflow` |
|---|---|---|---|---|---|---|---|
| 0 | Idle | 0 | **0** (`reset_window`) | 1 | 0 | 0 | 0 |
| 1 = `C` | Idle | 0 | 1 | 1 → accept, `start_now` | 0 | 0 | 0 (`tvalid` = 1) |
| 2 | Body | 1 | 1 (`need_payload`) | 0 | **1** | **0 ← the acceptance at `C` discarded** | **1** |

`observed: error_underflow@2`, exactly, and the mechanism explains §4's
selectivity without residue: at `W` ≥ 2 the first word carries `tlast` = 0, the
set fires later than the clear, and `W` = 3 (`tlast` at `C+2`) and `W` = 8
(`tlast` at `C+7`) are clean for the same reason. So the design is **not** a naive
reading of REQ-206 to its first full stop — that would have strobed at `P` = 60
too, and is `M04-G4`'s defect, not this one. It fails on exactly the shape where
one event sets both of the window's bounds.

**Why review and smoke sims missed it, which the charter asks for and I will not
soften.** The predicate was written down *correctly, in prose*, at authoring time:
`J-rtl_lead-0002`, on C-16, says "*C+8 carries no obligation (the underflow window
closed when the `tlast` word was accepted)*". Then it was encoded as a
clear-then-accumulate register, a shape whose narrowing is invisible unless the
two events are instantiated on one cycle — and every worked instance I reasoned
against is a frame where they are not: §6.1's table is `P` = 60, §7's C-16 bullet
illustrates at `C+8`, §9's strobe pin is stated against a frame with a word still
owed. **I read the C-16 clause through the number it is illustrated with rather
than through the predicate it is stated over.** That is precisely the reading
error the packet's §3 identifies from the specification side ("*the clause is
stated over the `tlast` acceptance, not over the number 8*"), reached
independently from the design side, and the agreement of the two derivations is
the strongest evidence I have that the diagnosis is the real one. There were also
no smoke sims to miss it: ADR-0005's container carries zero hardcaml packages, so
this module had never been compiled, elaborated or simulated by anything until CI
run 31476319884 — the first bench execution against it was always going to be the
first opportunity, and the instrument that caught it is the standing strobe
monitor, working exactly as `strobe_monitor.mli` §(d) says it exists to.

#### The fix, and why this shape and not the two alternatives

```ocaml
let start_word_is_last = ~:empty &: held_last in
last_accepted
<== reg
      spec
      (mux2 start_now start_word_is_last last_accepted |: (accept &: i.tx.tlast));
```

Two edits to one expression, which are one idea twice: **the set term moves
outside the clear** (clear the history, *then* record this cycle's acceptance),
and **the clear becomes a seed taken from what the module is already holding**.

*Why not the smaller edit.* Moving the OR out and leaving `gnd` as the seed —
`mux2 start_now gnd last_accepted |: (accept &: tlast)` — repairs the reported
failure and nothing else, and I rejected it after deriving two further routes to
the same defect (below): a frame can be wholly in this module's hands *before* it
starts, via §7 case 2's early acceptance at `C+8`, and then there is no
`accept & tlast` at the start cycle for the moved term to catch. A fix that leaves
a reachable instance of the same defect standing is a fix that comes back.

*Why not the alternative bound.* The other candidate was to move the **lower**
bound — hold `frame_active` low for a cycle, or gate the strobe on `have_end`.
Rejected on `M04-G5`'s account: that row is the one-cycle-offset neighbour with
the opposite verdict, and any lower-bound edit keyed on a cycle offset from `C`
either kills `M04-G5`'s legitimate strobe at `C+1` or leaves this one. §5 item 4
says the condition must key on **whether the `tlast` word has been accepted**, and
the upper bound is where that question lives. My diagnosis agrees with dv's
prediction here, and it agrees because the mechanism forces it, not because the
packet said so.

**The change is a suppression only where the window is provably empty**, which is
the property that makes it safe and which is checkable without simulation: when
`start_now` = 0 the two forms are `last_accepted | (accept & tlast)` bit for bit;
when `start_now` = 1 the old is 0 and the new is `(~empty & held_last) | (accept &
tlast)`. So the designs differ on exactly one class of cycles — frame starts at
which the starting frame's `tlast` word is **already accepted** — which is
verbatim REQ-206's upper bound. A frame with a word still to come has `tlast` = 0
on its first word and nothing held behind it, so the seed is 0 and it behaves as
before; `M04-G5` (`P` = 60, word withheld at `C+1`) still pulses at `C+1` with the
`/E/` two cycles later, by inspection.

`~:empty` is load-bearing rather than defensive: the `hold` registers keep their
value on a pop, so `held_last` is stale whenever `fill` = 0. And **the held word
at a start cycle is always the starting frame's own first word** — `tx_tready` is
asserted only under `(can_start & cfg_tx_enable)` or `(in_body & need_payload)`;
in `Body` every accepted word is consumed before the frame ends except one
accepted on the last `need_payload` cycle, which is §7 case 2's cycle and which
case 2 itself names *the next frame's first word*; on a `can_start` cycle an
acceptance always coincides with `start_now` because `word_available` includes
`accept`; on the abort path `starved` requires the structure empty and
`tx_tready` is 0 while starved; and `clear` empties `fill` outright.

#### Two further routes, derived — the answer to §8 item 3's question about domain

The mechanism is "the frame's `tlast` word was accepted **at or before** the cycle
the frame started", and the reported stimulus reaches only its first route because
it runs one frame out of reset. Both further routes need a **preceding frame**, so
that §7 case 2's early acceptance at `C+8` has something to come from:

- **Route 2 — `W` = 1 pre-accepted.** Frame A (`P` = 60) accepted at `C … C+7`; a
  one-word frame B accepted at `C+8` into the slot A vacates; terminate at `C+9`,
  gap served, and at `C+11` B starts from the held word with **no acceptance of
  its own**. The clear fires, and at `C+12` — B's first `Body` cycle — `tready` = 1,
  `tvalid` = 0 and the spurious strobe lands. Same defect, reached without ever
  satisfying `start_now & accept & tlast`.
- **Route 3 — `W` = 2 fully pre-loaded, and this one strobes at `W` = 2.** B's
  word 0 at `C+8`, B's word 1 (`tlast`) at `C+11` — precisely the pairing §7 case 4
  describes and licenses. The clear discards the `C+11` acceptance; `tx_tready` is
  0 at `C+12` because both slots are full (case 4's own consequence), so the
  spurious strobe lands at `C+13` when the second slot drains.

Both are silent post-fix (route 2 through the seed, route 3 through the moved set
term). I record route 3 rather than sitting on it because it touches §6's severity
argument: §6 reasons the composed chain is safe because M07 prepends 14 octets so
`W` = 1 cannot be produced upstream, and route 3 is a `W` = 2 strobe, so the
`W` ≥ 2-therefore-safe half of that argument does not by itself close. What does
close it is SPEC-M04 §7's own note that **in the composed chain M07 presents
nothing at `C+8`** — its output word 0 leaves at `C+9` and is accepted at `C+11` —
so the early acceptance routes 2 and 3 both depend on is not produced by M07 at
all, and §7 says the case is "*reached only by a bench driving M04 directly from a
continuous source*". §6's conclusion therefore survives on a different premise
than the one it used. **I report this to dv_lead and grade nothing**: a derived
`W` = 2 strobe on a shape no committed bench drives is not a class DV records a
severity on (BUG-0003 §V.2 is the standing precedent), and the severity field is
dv_lead's.

#### `W` = 2 on the shape §8 will actually run — the identity, derived

On §1's stimulus shape (one elaboration out of reset, each word re-offered until
accepted, nothing after), `W` = 2 is **clean at `fcf6f08` and bit-identical after
the fix**: word 0 (`tlast` = 0) is accepted at `C` with the start, word 1 (`tlast`)
at `C+1`, `last_accepted` is high from `C+2`, and `C+2` — which is §7's C-16 cycle
for this frame, `tready` = 1 with `tvalid` = 0 meaning nothing at all — is
suppressed by the **set** term in both designs. So the measurement §6 names as its
CRITICAL converter will not be obtained on that shape, and the fix does not move
it in either direction. That is the property §8 item 3 needs before it releases
the re-test, stated in advance so the re-run can convict it. `W ∈ {4,5,6,7}` and
the never-adjudicated `P ∈ {59, 61, 64, 67, 1514}` (all `W` ≥ 8) sit in the same
class and are unaffected in both designs.

#### What must not move, and the one thing that does

`last_accepted` feeds exactly one expression in the module — `underflow` — and
nothing else reads it. It reaches neither `tx_dest.tready` nor the XGMII lanes, so
§5 item 2 holds **structurally**: the wire path this packet proved correct in the
same runs cannot move. The emitted **netlist** does move, and two snapshots go
stale with it (below); regenerating them is out of this round's write set by the
spawn's own scope and is the emitter arc's, exactly as `J-rtl_lead-0016` and
`J-rtl_lead-0017` established for M06.

### Actions

1. Ran the precheck and stopped nothing: tree clean, HEAD = `fcf6f08`.
2. Read the charter, PROTOCOL, and `BUG-0004` in full before opening any source.
3. Read `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` end to end, then hand-traced
   the reported stimulus, `W` = 2, `W` = 3, `M04-G5`, and the two back-to-back
   routes against SPEC-M04 §6.1/§6.2/§7/§9.
4. **One edit to one file**: `libs/hardcaml_ethernet/src/xgmii_tx_64.ml`,
   `last_accepted`'s next-value expression plus the comment block that states the
   predicate it now encodes. `xgmii_tx_64.mli` is **not** touched — no port, no
   signature and no interface record moves, and the fix is entirely internal.
5. Appended `## 9. Root cause and fix — rtl_lead's response` to the packet
   (§9.1–§9.6), per the `BUG-` grammar BUG-0003 established. The packet's
   **State** and **severity** header fields are dv_lead's live state and are
   untouched.
6. Parse-checked the edit with two negative controls, and re-ran the line-width
   check.
7. Wrote this entry.

### Evidence

**1 — precheck, reproducible at this commit's parent.**

```sh
git rev-parse HEAD          # fcf6f084747b2704c9100acd76dffedbb8ae8f73
git status --short          # (empty)
```

**2 — the parse check, with negative controls, because a check that cannot report
failure is not a check.**

```sh
ocamlc -stop-after parsing -c libs/hardcaml_ethernet/src/xgmii_tx_64.ml   # exit 0
ocamlc -stop-after parsing -c libs/hardcaml_ethernet/src/xgmii_tx_64.mli  # exit 0
printf 'let x = (1 +\n' > bad.ml
ocamlc -stop-after parsing -c bad.ml     # exit 2, "Syntax error"
printf 'let f a b = mux2 a b\n<== reg spec (mux2 x y z |: (p &: q);\n' > bad2.ml
ocamlc -stop-after parsing -c bad2.ml    # exit 2, "')' expected", "This '(' might be unmatched"
```

The second control is shaped like the edit — an unbalanced parenthesis in exactly
the `mux2 … |: (…)` construction the fix writes — so it discriminates the failure
mode this change could plausibly have. **The parse check sees syntax and nothing
else**: not a width mismatch, not a wrong field name, not an operator that does
not exist, not an unused binding under the dev profile's warning set.

**3 — line width, against `.ocamlformat`'s janestreet margin of 90.**

```sh
awk 'length>90 {print FILENAME": "FNR": "length}' \
  libs/hardcaml_ethernet/src/xgmii_tx_64.ml libs/hardcaml_ethernet/src/xgmii_tx_64.mli
#   xgmii_tx_64.ml: 191: 91
#   xgmii_tx_64.ml: 287: 96
git show HEAD:libs/hardcaml_ethernet/src/xgmii_tx_64.ml | awk 'length>90 {print FNR": "length}'
#   191: 91
#   287: 96
```

Both over-margin lines are **pre-existing at HEAD and unchanged by me** (same line
numbers, same lengths); no line this commit adds exceeds 90. `ocamlformat` itself
is not installed in this container, so this is a margin check and not a format
check, and I do not claim the file is `ocamlformat`-clean.

**4 — the emitted netlist changes, and two snapshots go stale. Stated as a
prediction, before the run that grades it.** `bin/generate.ml` builds
`rtl_snapshots/xgmii_tx_64.v` from `Xgmii_tx_64.create`, and
`rtl_snapshots/eth_mac_10g.v` contains the same `xgmii_tx_64` module body
(`grep -n '^module ' rtl_snapshots/eth_mac_10g.v` → `crc32_eth` 1, `xgmii_rx_64`
1031, `xgmii_tx_64` 2852, `eth_mac_10g` 4598). So **both files are stale at this
commit**, CI's *Verify nothing was left unpromoted or non-deterministic* step will
red, and its `PROMOTION BLOCK` is the promotion source — the arc `J-rtl_lead-0016`
opened and `J-rtl_lead-0017` closed for `eth_axis_rx.v`. Regeneration is
**deliberately not in this commit**: the spawn's write set excludes
`rtl_snapshots/**`, and this container cannot run the emitter (ADR-0005). The
falsifiable half of the prediction: **no register is added and no `always` block
appears or disappears** — the delta is one AND term and the OR moving outside the
mux, in the `error_underflow` cone only — and the same delta appears once per
file. A raw diffstat far larger than that is Hardcaml net renumbering, which
`J-rtl_lead-0012` already measured once on this same emitter.

**5 — the red at that step does not contaminate the re-test, from `build.yml`'s own
step order.** `Run tests` (`dune runtest`) runs **before** `Generate RTL` and
before the determinism step, so §8's items 1 and 2 — the three units raising
nothing and the never-adjudicated members finally being adjudicated — are readable
from the `Run tests` step of the very same run whose job conclusion is `failure`.
A reader who takes the job's red as the M04 verdict will be reading the wrong
step.

**WHAT IS NOT CLAIMED, MEASURED RATHER THAN ASSERTED.** The `fpga` switch has
`dune` and no hardcaml package, so `dune build` cannot resolve `ppx_hardcaml` /
`hardcaml_axi` and fails before any file of mine is reached. **This fix has NOT
been compiled, NOT type-checked, NOT elaborated, NOT simulated and NOT emitted,
and I claim none of those.** Every cycle table in this entry and in the packet's
§9 is a **derivation from the source and the specification**, not an observation.
The first real verdict is dv_lead's re-test at §8, at CI, at the landing SHA
(ADR-0005: a local build is not acceptable evidence). In particular I do **not**
claim the three units are green, do not claim the `W` = 2 bracket is measured, and
do not claim `M04-G5` still fires — the last is an inspection of a row I have
never read the body of.

### Outcome

Charter §5's DoD, scored against a bug-fix round:

- **Implements its frozen spec, deviations escalated — met.** The change moves the
  design *toward* REQ-206 as SPEC-M04 §9 and §7's C-16 bullet state it; no
  deviation was created and none was found to escalate. The spec text needed no
  change: §3 of the packet and my Root cause agree that the specification already
  says the right thing and the implementation did not.
- **Emits deterministically into `rtl_snapshots/**` — NOT met at this commit, by
  design and named.** Two snapshots are stale (§Evidence 4); the double-generation
  byte-identity check is owed at the promotion commit and cannot be run here.
- **House style / margin — met** as far as this container can check (§Evidence 3);
  `ocamlformat` cleanliness is asserted by nobody and I do not assert it.
- **Rx-path line-rate invariant — no instance.** M04 is not an rx-path module
  (SPEC-M04 §8: not in requirements.md §0.4's list); its equivalent obligation is
  REQ-209's sustained transmit bench, which this change does not touch and which
  §9.3 route 3 notes is `W` = 8 throughout.
- **Worker review — no instance.** No worker, no `RV-`.
- **Journal entry appended, Root-cause section before the fix description, no DV
  sign-off claimed — met.**

Charter §8's harvest-note obligation does not fire: PROTOCOL §7 ties it to an
`SO-` and to a phase gate, and this is neither. Span bookkeeping unchanged — this
seat's next harvest still opens at `J-rtl_lead-0013` (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator, for commit; then to dv_lead via
`agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md` §9,
whose §8 re-test protocol is unchanged and whose Fix verdict field stays dv's.
Two things worth watching on the run this commit triggers, both stated so they can
convict me: the determinism step's red must carry **exactly** `xgmii_tx_64.v` and
`eth_mac_10g.v` and no third path, and the `Run tests` step must be **green** —
a red there is the fix failing, not the snapshot.

### Open-questions

1. **Escalation to dv_lead, not a blocker: routes 2 and 3 are unexercised by any
   committed stimulus I know of.** The fix closes them by derivation, and by
   derivation they were reachable before it. Whether they deserve a bench round is
   dv's call; I raise them rather than let a fix quietly cover ground nobody
   asked about (§9.3 of the packet is the same statement in dv's own document,
   per §8 item 3's requirement that a wider mechanism be declared).
2. **`rtl_snapshots/xgmii_tx_64.v` and `rtl_snapshots/eth_mac_10g.v` are stale
   from this commit until the promotion commit.** Owed by me, next round, from
   the `PROMOTION BLOCK` of the run this commit triggers. REQ-902's two-run byte
   identity for the M04 path has still never been observed.
3. **M04 has had no independent design review**, exactly as recorded for M06 in
   `J-rtl_lead-0015` item 3 and `J-rtl_lead-0017` item 3. This round is the first
   time any second party has looked at M04's behaviour at all, and it did so
   through the output pins without reading the source (the packet's §7 item 1).
   That is DV's job and not review; the defect this entry fixes was in my design
   for nine days and no review found it because no review happened.
4. **Carried, unchanged and untouched by this round**: C-RL-2 (the latent
   `first_v` gating in M03), C-RL-3 (sub-word idle granularity, no row owed), and
   C-RL-7 (SPEC-M06 §7/§10's retired per-octet-under-injection reading,
   architect_docs_lead's).

### Files-in-this-commit

- libs/hardcaml_ethernet/src/xgmii_tx_64.ml
- agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md

## [J-rtl_lead-0019] 2026-08-11T10:35:00Z | task:none | The two snapshots BUG-0004's fix made stale are promoted from run 31479688462's own red, and the prediction J-rtl_lead-0018 wrote before the run is graded against them: no register added, no `always` block moved, and the delta is the same six normalized lines inside the one module in each file

### Trigger

Orchestrator re-dispatch of the promotion round owed by `J-rtl_lead-0018`
Open-question 2, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`,
spawn-head `6e66eb2`. Precheck ran first and passed: `git status --short` empty,
`git rev-parse HEAD` = `6e66eb27142b90471515721658be22e7ecd58134`. The prior spawn
of this round correctly refused on a rolled-back container; the repository is
restored and every referent named in the dispatch resolves at this head. This is
the emitter arc that `J-rtl_lead-0016` opened and `J-rtl_lead-0017` closed for
M06, run a second time — its first repeat, which is what makes the determinism
watch in §5 below possible at all.

### Inputs

- `agents/charters/rtl_lead.md` and `agents/PROTOCOL.md`, read in full before any
  file was opened (§4 entry grammar, §5 R1–R9, §6 write scope, §10).
- `agents/journals/claude_rtl_lead_agent.v02.md` at `6e66eb2` — the whole of
  `J-rtl_lead-0018` (its §Evidence 4 is the prediction this entry grades, its
  §Outcome carries the "no third path" half), and `J-rtl_lead-0017`'s Actions and
  Evidence for the promotion discipline this round repeats.
- The run log excerpt, **ephemeral, outside the repository** (ADR-0003/F5):
  `promotion_run31479688462.log`, 292,539 bytes, 1,200 lines, in this session's
  scratchpad. **What it is and is not**: it is the tail of the failing
  determinism step only. Its first line is already inside a diff hunk body, and
  it carries no CI step markers other than the terminating `##[error]` and a
  Node-version warning. It therefore does **not** contain the `Run tests` step.
- The orchestrator's two decoded payload files, `promoted_xgmii_tx_64.v` and
  `promoted_eth_mac_10g.v`, also ephemeral and outside the repository, used as
  the third leg of the sha comparison and for nothing else.
- `rtl_snapshots/xgmii_tx_64.v` and `rtl_snapshots/eth_mac_10g.v` at `6e66eb2`,
  read whole as the baseline the prediction is graded against
  (`6f4cc64a…44f3`, 66,186 B; `a309376c…bcb6`, 112,000 B).
- `tools/check_emitted_verilog.sh` — its header comment, to confirm before
  running it that it reads build products and `.mli` surfaces only.
- **Not opened**: anything under `test/**` or `docs/reports/audit/**`. No
  Essenceia material consulted (charter §8, Inputs honesty).

### Reasoning

#### 1. Why the payloads were derived again from the log rather than accepted

The dispatch states both payloads were already sha-verified three ways, including
by my own prior spawn. I re-derived them anyway, from the log, with a script
written this spawn. The reason is not ceremony: **the scratchpad rolled back once
inside this window**, so a file sitting in it that agrees with a sha I am told to
expect is evidence about the file, not about the run. The only artefact that
carries the run's authority is the log's own block, and the only derivation I can
vouch for is one I performed. `J-rtl_lead-0017` set this as L-D01 discipline for
exactly this failure mode, and a promotion is the one act in this seat's repertoire
where trusting the wrong bytes writes them into history unrecoverably.

The derivation is deliberately paranoid at each joint rather than at the end. The
timestamp prefix is **measured** (all 1,200 lines carry a 29-character prefix
matching `\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{7}Z `; zero exceptions) instead
of assumed. The block is located by its own two markers. Each file's payload is
bounded by its own `--- FILE <path>` / `--- END <path>` pair, and the sha line's
trailing path is checked to equal the `--- FILE` path, so a block whose sha line
and payload had drifted apart could not pass. Every payload line is checked to be
pure base64, and the `-w 400` discipline is checked on every interior line, so a
truncated or wrapped line is caught before decode rather than surfacing as a sha
mismatch with no diagnosis. Only then is the concatenation decoded and hashed.

#### 2. Grading J-rtl_lead-0018's prediction — the part of this round that could have failed

The prediction was written before the run existed and has four claims plus a fifth
in that entry's Outcome. Graded one at a time, against the true HEAD:

- **"No register is added" — HELD.** `reg` declarations are 29 → 29 in
  `xgmii_tx_64.v` and 48 → 48 in `eth_mac_10g.v`.
- **"No `always` block appears or disappears" — HELD, and measured on both kinds
  rather than on the total, because a total can hold while a sequential block
  becomes a combinational one.** `always @(posedge …)` is 19 → 19 and `always @*`
  is 10 → 10 in the tx file; 35 → 35 and 13 → 13 in the mac file. Zero `negedge`,
  zero `#` delay, zero `initial` in either file, before and after.
- **"The delta is confined to the `error_underflow` cone" — HELD, and this is the
  one claim the normalized diff cannot establish**, because normalization erases
  precisely the signal identities the claim is about. It is established instead by
  tracing fan-out in the emitted bytes: the register's output net feeds **exactly
  two** expressions — its own next-value mux (the feedback term) and a single
  inversion, which feeds only the AND-chain terminating in
  `assign error_underflow = …`. Nothing else reads it. That is the structural form
  of `J-rtl_lead-0018`'s "what must not move" argument, and it now holds as an
  observation of the netlist rather than as a claim about the source.
- **"The same delta appears once per file" — HELD, in the strong form.** The two
  normalized diffs are not merely the same size; their changed lines are
  **byte-identical to each other**, and per-module decomposition puts the delta
  inside the `xgmii_tx_64` module body in both files and nowhere else.
- **"Exactly `xgmii_tx_64.v` and `eth_mac_10g.v` and no third path"
  (`J-rtl_lead-0018` §Outcome) — HELD.** The block contains exactly two
  `--- FILE` entries.

**One refinement I record rather than smooth over.** The prediction described the
combinational delta as "one AND term and the OR moving outside the mux". The
emission costs **two** nets, not one: the source term is `~:empty &: held_last`,
and Hardcaml materialises the negation as its own node, so the file gains a NOT
and an AND. Net effect per file: `wire` declarations +2, `assign` statements +2,
lines +4 — and nothing else. That is the predicted term emitted faithfully, not a
second change; but "one AND term" undercounted the nets by one, and a prediction
is worth less if I let its wording drift to fit the result.

**A result stronger than the prediction asked for.** The raw diffstat is ~1,400
lines changed per file, which the prediction anticipated as net renumbering. It is
now measured rather than presumed, and it is tighter than that: the module bodies
of `crc32_eth`, `xgmii_rx_64` and the `eth_mac_10g` wrapper are **raw
byte-identical** between HEAD and the promoted files — not merely identical modulo
renumbering. The renumbering is therefore contained entirely within the one module
that changed. An emitter that renumbered globally would have been consistent with
the prediction and is not what happened.

#### 3. The reviewer read, scoped to the deltas as dispatched

Read as reviewer, the change in the emitted netlist is the source fix and nothing
else. Before: the register's D input is `start_now ? 0 : (last_accepted | (accept
& tlast))`. After: `(start_now ? (~empty & held_last) : last_accepted) | (accept &
tlast)`. The synchronous clear to a `1'b0` constant is unchanged in both files,
and the `gnd` literal that disappears from the mux is the seed that
`J-rtl_lead-0018` replaced — `gnd` still appears elsewhere in both files, so
nothing was left dangling.

The equivalence argument that made the fix safe is checkable **in the netlist**,
which is a stronger place to check it than the source: when the start term is 0
the new D reduces to `last_accepted | (accept & tlast)`, which is the old D term
for term. So the two designs differ on start cycles only — the class
`J-rtl_lead-0018` argued is exactly REQ-206's upper bound — and that is now an
inspection of shipped bytes rather than of my own OCaml.

**A trap this round had to avoid, worth recording because it nearly reads the
wrong way.** Net numbers are *reused with different meanings* across the two
versions: in the HEAD file `_42` is the OR term, and in the promoted file `_42` is
the emptiness signal feeding the new inversion. A reviewer comparing by net number
would conclude a signal changed meaning. Nothing changed meaning; the emitter
renumbered, and **any comparison of two emissions must be by structure and
fan-out, never by net name.**

Four structural facts, checked because a promotion writes bytes I cannot
compile here: the port list of each file is set-equal to HEAD on name, direction
and width; every declared net in all six module bodies has a driver (458, 690,
728, 30 declarations, zero undriven); `eth_mac_10g.v` is genuinely hierarchical —
its top instantiates `xgmii_tx_64` and `xgmii_rx_64`, and the changed cone reaches
the top output through `.error_underflow(_43[73:73])` and `assign error_underflow
= _44` — so the delta is not stranded inside an uninstantiated definition; and
there is no `initial`, no delay, no `negedge` and no latch-inferring block.

**What this read is not.** It is not the independent design review of M04 that
`J-rtl_lead-0018` Open-question 3 says is owed, and reading a netlist cannot
become one — every internal name here is an emitter-generated `_NN`, so the file
shows structure with intent deleted. That carry stays open, untouched.

#### 4. Nothing was added to the promoted bytes

No provenance banner, no header comment, for the reason `J-rtl_lead-0017` §4
established and which this round is the first opportunity to violate a second
time: `bin/generate.exe` does not emit such a line, so the next run would diff
against it and the determinism step would print a promotion block forever. The
provenance of a build product belongs in the commit that carries it. This entry
and the commit trailer are where run 31479688462 is recorded.

#### 5. The second-promotion determinism watch — the reason this round is not a repeat of the first

`J-rtl_lead-0017` §7 could only state the determinism watch as a rule for a future
round, because M06 had no prior emission to compare against. This round is the
first time this seat promotes a file **that has been promoted before**, so the
watch is now live and I state it in the form that convicts me:

> A future `build` red printing a `PROMOTION BLOCK` for `rtl_snapshots/xgmii_tx_64.v`
> or `rtl_snapshots/eth_mac_10g.v` with a sha **different** from
> `27cb8ebe…ee85` / `6735d092…02ac`, **absent any change to
> `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` or `bin/generate.ml` between the two
> runs**, is the nondeterminism signature. It is a REQ-902 defect and charter §6
> makes it mine to root-cause. **It is emphatically not a promotion to repeat** —
> re-promoting the new bytes would launder a nondeterministic emitter into history
> and would destroy the only evidence that it happened.

The source-change proviso is load-bearing in both directions: a different sha
*with* a source change is the expected outcome and not a finding, and a promotion
round that treats every second block as routine is exactly how a real determinism
break gets absorbed. Symmetrically, if the determinism step now goes **green** at
the commit carrying this entry, that is M04's first determinism datapoint and the
first byte-identity observation REQ-902 has ever had on this path —
`J-rtl_lead-0018` recorded that it had never been observed.

### Actions

1. Ran the precheck; it passed, so nothing was refused. Read the charter,
   PROTOCOL, the dispatch, and the inputs above before touching a byte.
2. Wrote a fresh derivation script this spawn and re-derived **both** payloads
   from the log: measured the timestamp prefix, located the block by its own
   markers, validated each file's sha-line path against its `--- FILE` path,
   validated the base64 charset and the `-w 400` line discipline, decoded, hashed.
3. Compared three ways per file — the block's own sha line, my decode, and the
   orchestrator's decoded file — with a one-byte perturbation as a negative
   control on the comparison itself.
4. Placed **my own derived bytes** (not the orchestrator's files) over
   `rtl_snapshots/xgmii_tx_64.v` and `rtl_snapshots/eth_mac_10g.v` with `cp`, then
   re-hashed both in the tree.
5. Graded `J-rtl_lead-0018`'s prediction: structural counts, per-kind `always`
   counts, normalized diffs, per-module decomposition, and a fan-out trace of the
   changed cone in both files.
6. Read the deltas as reviewer and ran the structural battery in §Evidence 5.
   **Changed nothing; no defect found.**
7. Ran `tools/check_emitted_verilog.sh` with the promoted files and again with the
   HEAD files, then restored the promoted bytes and re-verified both shas.
8. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no
   `scripts/agent_commit.sh`, no git write of any kind.** No file outside the two
   snapshots and this journal was created or modified inside the repository.

### Evidence

Provenance, externally verifiable: **build run `31479688462`**, job
`93741536143`, step *Verify nothing was left unpromoted or non-deterministic*,
conclusion failure, its `PROMOTION BLOCK` the promotion source.

**1 — the three-way sha agreement, per file, 3/3 on both.**

```text
rtl_snapshots/xgmii_tx_64.v      221 base64 lines, 66,267 B
  block's own sha line : 27cb8ebef55a8d644644a2ce875b09e6a3cb533ca42a3021b9edb666bc89ee85
  my independent decode: 27cb8ebef55a8d644644a2ce875b09e6a3cb533ca42a3021b9edb666bc89ee85
  orchestrator's decode: 27cb8ebef55a8d644644a2ce875b09e6a3cb533ca42a3021b9edb666bc89ee85
  cmp mine vs theirs   : exit 0

rtl_snapshots/eth_mac_10g.v      374 base64 lines, 112,081 B
  block's own sha line : 6735d0921a69e0aba87020a70af47d37c28ef0a0efcfd35a1fa99599026702ac
  my independent decode: 6735d0921a69e0aba87020a70af47d37c28ef0a0efcfd35a1fa99599026702ac
  orchestrator's decode: 6735d0921a69e0aba87020a70af47d37c28ef0a0efcfd35a1fa99599026702ac
  cmp mine vs theirs   : exit 0
```

Both decodes end in `\n` and the block carries no "No newline at end of file"
marker. After placement, reproducible from a checkout at this commit:

```sh
sha256sum rtl_snapshots/xgmii_tx_64.v   # 27cb8ebef55a8d644644a2ce875b09e6a3cb533ca42a3021b9edb666bc89ee85
sha256sum rtl_snapshots/eth_mac_10g.v   # 6735d0921a69e0aba87020a70af47d37c28ef0a0efcfd35a1fa99599026702ac
wc -c   < rtl_snapshots/xgmii_tx_64.v   # 66267
wc -c   < rtl_snapshots/eth_mac_10g.v   # 112081
```

*Negative control, because a comparison that cannot report a difference is not a
comparison*: flipping one bit at offset 1000 of each derived file moves the sha
(`cb927ad7…`, `85c1dafa…`) and `cmp` reports `differ: char 1001, line 61` in both
cases. The pipeline discriminates.

**2 — the structural counts, HEAD vs promoted.** All runnable at this commit with
`git show HEAD:<path>` against the working file:

```text
                          xgmii_tx_64.v        eth_mac_10g.v
                          HEAD  ->  NEW        HEAD  ->  NEW
reg declarations           29   ->   29         48   ->   48     <- no register added
always @(posedge ...)      19   ->   19         35   ->   35     <- none appears/disappears
always @*                  10   ->   10         13   ->   13
negedge / #delay / initial  0   ->    0          0   ->    0
^module / ^endmodule        2/2 ->    2/2        4/4 ->    4/4
input / output decls       13/5 ->   13/5       31/31->   31/31   <- port list set-equal
wire declarations        1117   -> 1119       1856   -> 1858     <- +2
assign statements        1121   -> 1123       1883   -> 1885     <- +2
total lines              2776   -> 2780       4766   -> 4770     <- +4
raw git diff --numstat   1406 insertions / 1402 deletions   1407 / 1403
```

**3 — the normalized delta, and the counting convention stated so the number
reproduces.** Normalizing `_[0-9]+` → `_N` in both versions and diffing, counting
changed lines as those matching `^[+-][^+-]` (i.e. **excluding** the `---`/`+++`
file headers):

```text
xgmii_tx_64.v : 6 changed lines, 2 hunks
eth_mac_10g.v : 6 changed lines, 2 hunks     (measured fresh against HEAD a309376c…)
```

and the changed lines are **byte-identical between the two files** (`cmp` exit 0):

```diff
+    wire _N;
+    wire _N;
+    assign _N = ~ _N;
+    assign _N = _N & _N;
+    assign _N = _N ? _N : _N;
-    assign _N = _N ? gnd : _N;
```

Counting all lines beginning `+` or `-` including the two file headers would give
8; the dispatch relayed an ungraded prior figure of "~9 lines", which I neither
reproduce nor contest — I state my own convention instead so the count is
checkable. Both figures are well inside the prediction either way.

**4 — per-module decomposition, which is what "once per file" and "confined"
actually mean.** Splitting each file at its `^module` headers and comparing bodies:

```text
xgmii_tx_64.v   crc32_eth    RAW BYTE-IDENTICAL
                xgmii_tx_64  6 changed lines, 2 hunks (normalized)
eth_mac_10g.v   crc32_eth    RAW BYTE-IDENTICAL
                xgmii_rx_64  RAW BYTE-IDENTICAL
                xgmii_tx_64  6 changed lines, 2 hunks (normalized)
                eth_mac_10g  RAW BYTE-IDENTICAL
```

So the ~1,400-line raw diff is renumbering **inside the single changed module**,
not across the file.

**5 — the cone trace and the structural battery.** In the promoted
`xgmii_tx_64.v`, the register `_51` (cleared to `_49` = `1'b0` under `_39`) drives
`_1`, and `_1` appears in exactly three places besides its declaration: its own
next-value mux `_45 = _29 ? _44 : _1`, its driver `_1 = _51`, and `_163 = ~ _1`.
The inversion feeds only

```text
_160 = ~ _33 ;  _161 = _159 & _160 ;  _162 = _161 & _2 ;
_164 = _162 & _163 ;  _166 = _164 & _165 ;  assign error_underflow = _166 ;
```

The same trace holds inside `eth_mac_10g.v`'s `xgmii_tx_64` body (lines
2852–4601), whose `error_underflow` reaches the top output via
`.error_underflow(_43[73:73])` and `assign _44 = _43[73:73]`. Every declared net
in all six module bodies has a driver — 458 / 690 in the tx file, 458 / 728 / 690
/ 30 in the mac file, **zero undriven in each**.

**6 — the forward check, run both ways rather than asserted.**

```sh
bash tools/check_emitted_verilog.sh
#   5 check(s) run, 0 failure(s), 3 pending
#   PASS REQ-001: all 87 edge expressions and 3 instantiated .clock() connections
#        resolve to the clock port
#   PASS REQ-306, PASS REQ-018 (x3)
#   PENDING REQ-808 / REQ-017 / REQ-903 — unchanged P1-module-ready conditions
```

Run against the HEAD snapshots instead, the output is **identical**, including the
87 edge expressions — which is the correct result, since the delta is
combinational, and it corroborates the `always`-count claim from an instrument
that does not share its method. `J-rtl_lead-0017` §6 recorded 87 after M06's
promotion; the figure is unmoved. The HEAD files were restored afterwards and both
shas re-verified.

**WHAT IS NOT CLAIMED, MEASURED RATHER THAN ASSERTED.** The log excerpt in hand is
the failing determinism step's tail only: it begins inside a diff hunk body and
contains no `Run tests` step. **I therefore did not verify, and do not claim, that
`Run tests` passed or that the M04 bench is green against the fixed design.** The
dispatch states both; I record that as relayed and unverified by me, and the
adjudication is dv_lead's in any case (charter §5: `SO-` PASS is not mine to give).
Because the excerpt starts mid-hunk, the second reconstruction channel
`J-rtl_lead-0017` used — rebuilding the file from the log's own `+` lines — was
**not available** this round; the base64 block was re-derived independently, but I
had one log-side channel and not two, and I say so rather than imply parity with
the earlier round. This container still cannot run the emitter (ADR-0005), so
**REQ-902's two-run byte-identity check was not performed by me** and the promoted
bytes have not been compiled, elaborated or simulated here. The promotion is a
transcription of the run's output, verified as a transcription.

### Outcome

Charter §5's DoD, scored against a promotion round:

- **`bin/generate.exe` emits into `rtl_snapshots/**` deterministically — partially
  met, and named.** The staleness `J-rtl_lead-0018` declared is discharged: both
  files now carry run 31479688462's bytes. The **double-generation byte-identity
  check remains unperformed by me** (no emitter in this container); the first real
  determinism datapoint for the M04 path is the determinism step at the commit
  carrying this entry, and §5 above states in advance how to read either verdict.
- **Implements its frozen spec, deviations escalated — met, no instance created.**
  No source changed this round; the promoted bytes are the emission of the fix
  already reviewed at `J-rtl_lead-0018`.
- **Line-by-line review — met for the scope dispatched** (the deltas), with the
  limits of a netlist read stated in §3 rather than glossed.
- **Rx-path line-rate invariant — no instance.** M04 is not an rx-path module.
- **Worker review — no instance.** No worker, no `RV-`.
- **Journal entry appended, no DV sign-off claimed — met.**

Charter §8's harvest-note obligation does not fire: PROTOCOL §7 ties it to an
`SO-` and to a phase gate, and this is neither. Span bookkeeping unchanged — this
seat's next harvest still opens at `J-rtl_lead-0013` (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator, for commit. `J-rtl_lead-0018` Open-question 2 is
**closed** by this entry.

### Open-questions

1. **The second-promotion determinism watch is now live** (§5). A future block
   printing either of these two paths with a different sha, absent a change to
   `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` or `bin/generate.ml`, is a REQ-902
   nondeterminism finding and is mine to root-cause — not a promotion to repeat.
2. **REQ-902's two-run byte identity has still never been observed on the M04
   path**, only asserted; carried from `J-rtl_lead-0018` Open-question 2 and not
   discharged by promoting, since promotion transcribes one run and compares
   nothing across runs.
3. **The `Run tests` verdict for the M04 bench is relayed, not verified here**
   (§Evidence, non-claims). Whether the fix actually closes `BUG-0004` is
   dv_lead's re-test at §8 of that packet, and its Fix verdict field stays dv's.
4. **M04 has had no independent design review** — carried unchanged from
   `J-rtl_lead-0018` Open-question 3; a netlist read cannot become one.
5. **Carried, unchanged and untouched by this round**: C-RL-2 (the latent
   `first_v` gating in M03), C-RL-3 (sub-word idle granularity, no row owed), and
   C-RL-7 (SPEC-M06 §7/§10's retired per-octet-under-injection reading,
   architect_docs_lead's).

### Files-in-this-commit

- rtl_snapshots/xgmii_tx_64.v
- rtl_snapshots/eth_mac_10g.v

## [J-rtl_lead-0020] 2026-08-11T13:05:00Z | task:none | M07 `Eth_axis_tx` written from the frozen batch-C spec and implemented rather than decomposed: M06's two-position shift run backwards and applied to `tkeep` as well as `tdata`, the header seeded into the datapath's own two slots so it is held in no register of its own, the drain's length falling out of one bit — and SPEC-M07 §7's pinned constant found to be an event delay printed as a latency, at a fourth site of a defect class this programme repaired twice on 2026-08-11

### Trigger

Orchestrator dispatch, branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`,
spawn-head `714178d`: the datapath's next unbuilt module is to be opened —
implemented in-round or decomposed into a `WO-` packet, my call, said out loud
with grounds. Precheck ran before anything was read and passed: `git status
--short` empty, `git rev-parse HEAD` =
`714178dddc79a9061779e6816b088b239cb10c36`.

**Concurrency**: the declared tb_writer round owns `test/xgmii_tx_64/**` (three
new files plus edits per WO-0081 §11.2), `agents/handoffs/WO-0081_tb-m04-
families-d-e-g9.md`'s Return log and `agents/journals/workers/claude_tb_writer_
agent.v03.md`. This commit writes three files — two under
`libs/hardcaml_ethernet/src/` and my own journal — and the sets are disjoint. **The
confinement claim is over the paths I own and not over the tree being otherwise
quiet**. Mid-round the orchestrator committed that sibling as **`aabae58`**, so
`HEAD` advanced under me from the spawn-head and `git status --short` at the end
of this round lists exactly my three files rather than the eight it listed while
I was writing. That is what a declared concurrent round looks like and is not a
finding against either of us, but it is stated rather than left for a reader to
reconcile: my work sits on `aabae58`, whose eight paths (`test/xgmii_tx_64/**`,
the WO-0081 packet and the tb_writer journal) are disjoint from my two, and it
touched no journal of mine — checked, not assumed, by comparing `git show
HEAD:agents/journals/claude_rtl_lead_agent.v02.md` byte for byte against the
first 140507 bytes of the staged file, so R3's append-only property holds against
the head this commit will actually land on.

### Inputs

- `agents/charters/rtl_lead.md` and `agents/PROTOCOL.md`, read in full before any
  other file was opened (§4 entry grammar, §5 R1–R9, §6 write scope, §10).
- `docs/specs/architecture.md` §4's module inventory table — read to establish
  which module is next **from the record** rather than from the dispatch's
  sentence (§1 below).
- **`docs/specs/modules/eth_axis_tx.md` in full** — SPEC-M07, FROZEN at
  `508eea2`, all thirteen sections including §11's four deferred items (all
  closed) and §13's single change-log row.
- `docs/specs/requirements.md` — **§0.4 and §0.5 in full** (the receive-path
  definition and its stress list; octet time, the front offset h, **the
  inserting-module clause**, the word delay ΔC, the deciding input word D, the
  straddle and late-decision tests, what a monitor may demand under injection),
  §1.1's ceiling and currency tables, REQ-001 … REQ-021, REQ-405, REQ-409, and
  §13's **2026-08-11** rows — the `FINDING AP-M04-1` row (REQ-210, §0.5) and its
  countersignature row at `816e187` are the ones this round turns on.
- `docs/specs/ifc_check/eth_axis_tx_ifc.ml` — the compile-checked lift of
  SPEC-M07 §4.1, read as the surface my `.mli` must present.
- `docs/specs/traceability.md`'s M07 rows (REQ-405, REQ-409).
- `docs/specs/modules/eth_axis_rx.md` §13 — read only to see whether **C-RL-7**
  is still open. It is not: a 2026-08-11 row repairs the retired reading at all
  four of its sites in that file. Recorded in Open-questions and dropped.
- `docs/specs/modules/ip_eth_tx_64.md` §7's latency bullet and §6.1's body-word
  layout, `docs/specs/modules/udp_ip_tx_64.md` §7's latency bullet, and
  `docs/specs/modules/arp_eth_tx.md` §7's — read **only** to measure how far §5's
  finding reaches, not to design anything. What I read is quoted in §5 and
  nothing else was taken from them.
- `agents/journals/claude_architect_docs_lead_agent.v03.md` — the ledger rows
  **56** and **57** (which specifications the unscoped-adjacency and
  retired-sentence sweeps still owe) and the reasoning that produced §0.5's
  inserting-module clause. Both were read to answer one question: is §5's finding
  already named by someone else? It is not.
- `agents/journals/claude_dv_lead_agent.v09.md` — the `BUG-0004` closeout
  paragraph that supersedes my REQ-902 non-claim with one measured datapoint and
  routes the requirement back to this seat (Open-questions 4).
- My own `J-rtl_lead-0015` (the precedent form for this round's §2 and §3) and
  `J-rtl_lead-0019` (the carried ledger).
- The house style, read as the thing I am conforming to: my own
  `libs/hardcaml_ethernet/src/eth_axis_rx.ml` — the module this one mirrors —
  `xgmii_tx_64.ml` (the transmit-side `tready` and reset-window patterns),
  `axi64.mli`, and `libs/hardcaml_ethernet/src/dune`.
- **Hardcaml's own API declarations**, at
  `/root/.opam/fpga/.opam-switch/sources/hardcaml/src/comb_intf.ml`, for the
  exact signatures of `concat_lsb`, `split_msb`, `select`, `ones` and `zero`
  before I used them. This is the library's own interface documentation, which
  charter §9 tells me to mine; it is not a design source and nothing was taken
  from it but four type signatures. Recorded because with no compiler for the
  library available (§Evidence) it is the only thing standing between me and a
  name that does not exist.
- **`test/` was NOT opened this round** beyond nothing at all: I read no bench,
  no attack plan and no golden model, and I did not open `test/third_party/`.
  ADR-0015's pin rules would permit me the MIT verilog-ethernet reference, and I
  did not need it — SPEC-M07 §6.1 states the assembly rule and the cycle table in
  terms, so there was nothing the reference could have told me that the frozen
  spec does not.
- **No Essenceia/Nasdaq-HFT-FPGA material consulted**, for this or anything in it
  (charter §8, Inputs honesty).

### Reasoning

#### 1. Which module, established from the record

architecture.md §4's inventory is ordered by datapath position. M01 through M06 —
`Axi64`, `Crc32_eth`, `Xgmii_rx_64`, `Xgmii_tx_64`, `Eth_mac_10g`,
`Eth_axis_rx` — exist in `libs/hardcaml_ethernet/src/` (plus the `word_counter`
bootstrap), and the next row is **M07 `Eth_axis_tx`**, transmit path, spec
`docs/specs/modules/eth_axis_tx.md`, primary REQs **405** and **409**, prior-art
counterpart `eth_axis_tx.v`. That is two independent readings agreeing — the
inventory's order and the directory's contents — which is why I checked both
rather than taking the dispatch's sentence: an instruction is a summary of the
source, and a summary that has gone stale is not an authority. The dispatch's
"M07 by number" and the record agree here, and the record is what I built from.

**The dispatch's defect warning, discharged.** The architect's ledger item 56
names SPEC-M06, M16, M17 and M19; item 57 names SPEC-M17 and M08. SPEC-M07 is in
neither, its §13 carries exactly one row (2026-08-02, C-17(b)), and
`grep SPEC-M07` over the architect's current journal volume returns nothing. So
my target spec carries **no** defect a 2026-08-11 §13 row has already named — and
§5 below is therefore a **new** one, handled under the rule the dispatch gave for
that case.

#### 2. Implement or decompose — the call, and the paragraph it owes

**I implemented it.** Three grounds, and then the price.

**(a) The counter-intuitive constraint that bounds delegation is present here, and
it is §5's finding.** A worker handed SPEC-M07 and told to build it would read
§7's *"Latency. Pinned at 1 cycle … so the figure is exactly 8 octet times"* and
would either write that sentence into the module's doc comment — a false
statement about a per-octet quantity, entering the tree under my signature — or
stop and ask. The packet that prevented both would have to restate §0.5's
inserting-module clause, the three figures §5 derives, and which of them the RTL
is built to. That **is** writing the contract out longhand, which is the ground
`J-rtl_lead-0002` decided the MAC layer on and `J-rtl_lead-0015` decided M06 on.
War story **R14** — delegation is bounded by the cost of restating
counter-intuitive constraints — acquires no incident from this round either,
because I again did not delegate; what it acquires is a third consecutive module
where the restatement cost was measured rather than assumed.

**(b) The realignment structure is a decision about five modules, not one.** M07
is M06 run backwards, and the thing that has to be mirrored is not the direction
but the *formulation*: M06 contains no octet counter because the two-position
shift is applied to `tkeep` as well as to `tdata`. The obvious M07 datapath
carries an octet count (`popcount` the payload `tlast` word, add 6, decide
whether one more word is owed, decode a count back to `tkeep`). If M07 were built
that way, the programme would hold the same constant in two incompatible
encodings at the two ends of the same 14 octets, and M14, M15, M17 and M18 would
each inherit whichever they read first. Choosing the encoding for the *set* of
realignment sites is not a single-module work order.

**(c) M07's zero-latency-reserve analogue.** M07 has no §1.1 ceiling (§3, §7), so
it has no reserve to spend — but §8 makes its two-or-three-cycle drain compose
against M04's 11-cycle frame period, and §6.1 pins the drain length as W − J + 1
after carry-forward **C-17(b)** corrected it in three places at once. A design
that produced two cycles where three are owed passes every local reading and
fails the composed REQ-209 run. That is a spec-anchored corner I would have had
to write into the packet verbatim, which returns to (a).

**And the mechanical fact, stated separately because it is not a design ground.**
This round's dispatched write set is two files under `libs/hardcaml_ethernet/src/`
plus my journal; `agents/handoffs/**` is in my charter scope but not in *this*
round's set, so a `WO-` packet could not have been written here. Had the merits
gone the other way, the honest act would have been to return the round with the
packet unwritten and ask for a write set that includes `agents/handoffs/**` — not
to implement by default. The merits went this way, so the question did not arise;
I record it because a decision that agrees with its constraint should say whether
the constraint was doing the work. It was not.

**The price, restated because `J-rtl_lead-0015` restated it and my own harvest
banked it as candidate 3.** This is the **seventh** module in a row with no
independent design review. Self-review is not review. The compensating controls
are dv_lead's independently written suite, the auditor's mutation campaigns, and
the fact that the whole design is stated in the module doc comment against
SPEC-M07 §6.1's own table, so a reviewer can check it by reading rather than by
re-deriving. **What would make the next one delegable**: a module that neither
realigns nor carries a §7 whose quantity is misnamed — M08 `Eth_demux` and M09
`Eth_arb_mux` are the candidates by position, and choosing between them needs
their §7s read first, which this round did not do and should not pretend to have
done.

#### 3. The microarchitecture: what was considered and why the winner won

M07 inserts fourteen octets ahead of a word-aligned payload stream. Four
decisions, each with the alternative I rejected.

**(a) Fixed wiring, not a shifter — the mirror of M06(a).** SPEC-M07 §5 has **no
parameters** and makes 14 a constant of the specification, so the insertion
amount is not a variable and a structure admitting one is logic parameterised on
something that cannot vary. The realignment is two `select`s and a `concat_msb`:

```text
    tdata = { new[15:0], old[63:16] }
```

— where `old` is the older of two held payload words and `new` the newer, which
is SPEC-M07 §6.1's "output word n carries payload octets 8n − 14 … 8n − 7, which
lie in payload words n − 2 and n − 1" written once.

**(b) The same shift applied to `tkeep`, which is again the decision I most want
on the record.** The count-carrying datapath is the obvious one and I wrote it
first: `popcount` on the payload `tlast` word, W and J formed, W − J + 1 counted
down, a count-to-`tkeep` decode at the end. It is arithmetic on three cases and
each is a place to be off by one — and C-17(b) is the programme's evidence that
this particular count is easy to get wrong, because the *specification* got it
wrong in three places before any RTL existed. The formulation that replaced it is

```text
    tkeep = { new[1:0], old[7:2] }
```

— the identical two-position shift applied to the presence bits instead of the
octets. An octet's presence travels with the octet by construction, the three
cases collapse into one expression, and **the module contains no octet counter,
no `popcount`, no W, no J and no length arithmetic of any kind.** It won for the
same reason M06's did: the property a reviewer has to check is now *the same
wiring twice* rather than *three arithmetic cases agreeing with one wiring*, and
I am the author of a module nobody else reviews (§2).

The collapse reaches the end of the frame too. The frame's last output word is
the first one whose newer slot holds the payload's last word **and** has no octet
at or above position 2:

```text
    tlast = new_last & (new_keep[7:2] = 0)
```

One bit. The two-or-three stalled cycles §6.1 and §7 pin as W − J + 1 are then a
*consequence* of that wiring rather than a number this module computes — which is
the strongest form of agreeing with C-17(b), because a design that never forms
W − J cannot form it off by one.

**(c) The header rides in the datapath's own registers, and is held in none of its
own.** SPEC-M07 §6.3 item 1 leaves "whether the header is held in one register or
three" unconstrained. The candidates were: capture the four fields into a header
register and mux them into the first two output words; or push the header into
the pipeline the payload already uses. I took the second. Output word 0 is a mux
at the output register's input, taken live from the record on the acceptance
cycle (ADR-0008 holds the fields stable until then), and header octets 8–13 are
written into the **older slot** as a pseudo payload word whose positions 2 to 7
are those octets and whose `tkeep` share is all ones. Output word 1 then falls
out of (a)'s expression with **no case of its own**: the header's tail is simply
what the older slot happens to hold on that one cycle.

So the header occupies **zero** registers of its own. It is captured directly
into the two places it will be emitted from, which is why it cannot drift from
the frame it belongs to — the failure mode a separate header register invites is
the header of frame n being emitted with the payload of frame n + 1, and here
there is no register in which that could be staged.

**(d) One enable for the whole module.** §6.1 says `payload_tready` is 1 only when
`tx_tready` is 1, and §6.2 says a cycle with `tx_tready` = 0 holds every state and
every register. So `tx_tready` (with the reset window removed) is a single enable
rather than two independently derived conditions, and **REQ-207 becomes
structural**: a payload word is only ever accepted on a cycle whose output word is
leaving, so "an accepted word is always transmitted" is a property of the enable
and not an argument about a buffer. The rejected alternative was a skid buffer
that accepts while the consumer stalls — REQ-207 permits it and §6.3 item 2 leaves
`payload_tready` free when no frame is offered, but it buys throughput that
nothing asks for (M04 raises `tx_tready` when it can take a word, so an idle
consumer is not a steady state) and it costs a third word of storage and a second
control path. Three words of storage — two payload slots plus the output register
— is what a 14-octet insertion needs and is where I stopped.

#### 4. The arithmetic, worked against the specification's own table

Payload of P octets, J = ⌈P/8⌉ payload words, W = ⌈(14 + P)/8⌉ output words. C is
the cycle the first payload word is accepted; payload word j is accepted at C + j
and output word n leaves at C + 1 + n (§6.1).

**§6.1's 46-octet frame, row for row.** J = 6, W = 8. C: accept word 0, load
output word 0 (header octets 0–7). C+1: present output word 0, accept word 1,
load output word 1 = { word 0's octets 0–1, header octets 8–13 }, `tkeep` =
{ 11, 111111 } = 0xFF. C+2 … C+5: present output words 1–4, accept words 2–5;
word 5 is the payload `tlast` with `tkeep` = 0x3F. C+6: `payload_tready` = **0**
(the newer slot holds the last word), present output word 5, load output word 6 =
{ word 5's octets 0–1, word 4's octets 2–7 }, `tkeep` = 0xFF, not last because
word 5's `tkeep`[7:2] = 001111 ≠ 0. C+7: `payload_tready` = 0, present output word
6, load output word 7 = { nothing, word 5's octets 2–7 }, `tkeep` = { 00, 001111 }
= **0x0F**, `tlast` = 1, `tuser`[0] inherited. C+8: `payload_tready` = 0, present
output word 7 — frame octets 56–59. C+9: `Idle`, `tx_tvalid` = 0,
`payload_tready` = 1 if a frame is offered.

That is §6.1's table character for character, including **three** zero cycles at
C+6, C+7 and C+8 — W − J + 1 = 3, never 2, which is exactly what C-17(b) exists to
protect and what §8 tells the composed REQ-209 run to assert.

**The residues, because the drain length is where an off-by-one would live.** The
frame is 8J + 6 + p octets where p = `popcount` of the payload `tlast` word's
`tkeep`, 1 ≤ p ≤ 8. Under (b)'s wiring the word loaded on the cycle after the
payload `tlast` is accepted carries `tkeep` = { L[1:0], 111111 } and is last iff
L[7:2] = 0:

- **p = 1** (P ≡ 1 mod 8): `tkeep` = 0x7F, seven octets, **last**. W − J = 1,
  stalled cycles 2.
- **p = 2** (P ≡ 2 mod 8): `tkeep` = 0xFF, **last**. W − J = 1, stalled cycles 2.
- **p ≥ 3**: that word is full and not last; one more word follows with
  `tkeep` = { 00, L[7:2] } = p − 2 octets, **last**. W − J = 2, stalled cycles 3.

Which is §6.1's "W − J equal to 1 for P ≡ 1 or 2 (mod 8) and 2 at every other
payload length", reached from the `tkeep` bits and not from a count.

**Three worked lengths.** P = 46 (the ARP-sized frame of §8): above, 60 octets on
the wire, last word 4 octets. P = 1500 (REQ-612's maximum): J = 188, W = 190 —
REQ-015's bound exactly, the `tlast` word included — p = 4, last output word 2
octets. P = 28 (§6.3 item 3's floor, the smallest Phase-1 transmit payload):
J = 4, W = 6, p = 4, last output word 2 octets, three stalled cycles.

**The two degenerate lengths §6.3 item 3 declares unreachable.** P ≤ 8 puts the
payload `tlast` word in the *acceptance* cycle, so the machine drains from its
first active cycle. The design degrades correctly rather than hanging: at P = 8 it
emits three output words with the last carrying 6 octets, at P = 1 it emits two
with the last carrying 7. I state this because "unreachable" is a statement about
the Phase-1 stimulus and not about the RTL, and a module that hung there would be
a latent defect waiting for a Phase-2 stimulus. A 14-octet frame — a header with
**no** payload word — remains genuinely outside the design: ADR-0008 makes the
simultaneous offer an obligation on the source, so the case is unreachable rather
than undefined, and §6.3 item 3 says DV SHALL assert nothing about it.

**`clear`, §7's reset clause.** Every register clears synchronously, so a
mid-frame `clear` abandons the frame with no `tlast` (REQ-009's only permitted
silent frame loss) and the machine is in `Idle` on the next cycle. `tx_tvalid` and
`payload_tready` are both muxed to 0 while `clear` = 1 and on the first cycle
after, so a frame offered on that first cycle is accepted on the following one and
transmits intact — §7's own case.

#### 5. The finding: SPEC-M07 §7 pins an event delay and prints it as a latency

**What the specification says.** §7's first bullet is titled **Latency** and
reads: *"Pinned at 1 cycle: the frame's first output word is emitted on the cycle
after M07 accepts the frame's first payload word … Both sit at octet position 0 of
their words, so the figure is exactly 8 octet times and not a rounding."*

**What requirements.md §0.5 says, as amended on 2026-08-11 and in force from its
countersignature row at `816e187`.** A module that *inserts* octets ahead of the
frame has h = 0, and **ΔC counts to the first output word carrying an octet of the
frame, never a word the module inserted ahead of it**; and *"a delay pinned to an
inserted word is an **event delay**, not a latency: it is a legitimate and often
sharper thing to pin — **both its events are named and both sit at octet position
0** — but it is a different quantity with a different value, and a specification
pinning both SHALL name which is which. Pinning one and citing the other's
measurement is the defect `FINDING AP-M04-1` found."*

The sentence §7 uses to justify calling its figure a latency is, word for word,
the sentence §0.5 uses to explain why that does **not** make it one.

**The arithmetic, which refutes it before any RTL exists.** M07's output word 0 is
fourteen inserted octets' first eight; it carries no octet that entered at any
input port, and §7's own next paragraph says so (*"output word 0 is a function of
the header record alone"*). By §0.5's definition the octets with a latency at M07
are the payload octets. Payload octet k enters at octet time 8C + k (word ⌊k/8⌋
accepted at C + ⌊k/8⌋, byte position k mod 8). It leaves as frame octet 14 + k, in
output word ⌊(14 + k)/8⌋ at byte position (14 + k) mod 8, and output word n leaves
at C + 1 + n — so its output octet time is 8C + 8 + (14 + k) = 8C + k + **22**.
Constant, at every k, every length and every content:

| route | figure | what it is |
|---|---|---|
| §0.5's per-octet definition | **22** octet times | M07's latency |
| §0.5's identity L = 8·ΔC − h, with h = 0 and ΔC = 2 | **16** octet times | what the identity returns |
| SPEC-M07 §7 | **8** octet times | the event delay to output word 0 |

Three figures, one of them printed. **And the two §0.5 routes disagree with each
other**, which is the part that makes this more than a relabel: at M04 the
architect's own ground for making the inserting clause a *naming* rule was that
"the identity L = 8ΔC − h returns 16, agreeing with the per-octet route". It
agrees there because M04 inserts **8** octets and the frame stays word-aligned. It
disagrees here because M07 inserts **14**: the frame's first input-derived octet
lands at byte position 6 of the output word ΔC counts to, and the identity's
derivation assumes position 0. The identity needs an output-side offset term (or
an explicit scoping to insertions that are multiples of 8) before it can be
applied to an inserting module at all.

**Why this is new.** SPEC-M07 §13 carries one row, 2026-08-02. Ledger item 56
names SPEC-M06, M16, M17, M19; item 57 names SPEC-M17 and M08. The architect's
current journal volume does not mention SPEC-M07. The 2026-08-11 sweep that
repaired REQ-210 and REQ-611 reached the two sites it was looking at, and this is
a third of the same class at a module nobody was reading.

**How far it reaches, measured rather than estimated.** I read the §7 latency
bullet of the three other transmit modules. **SPEC-M15 §7 carries the identical
sentence** — *"the frame's first body word is emitted on the cycle after M15
accepts the frame's first payload word … Both sit at octet position 0 of their
words, so the figure is exactly 8 octet times and not a rounding"* — and SPEC-M15
§6.1 says *"body word 0 and body word 1 are header only"*, so its pinned word is
inserted too and its insertion is **20**, again not a multiple of 8. **SPEC-M18
§7 does not carry it**: it states in terms that *"output word 0 is outside that
constant and is stated separately, because it carries no application octet"* and
gives both monitors' figures — which is what §0.5's clause asks for, written
before the clause existed. **SPEC-M11 §7 does not carry it**: it tabulates L and h
explicitly and its input is a record rather than a stream. So the class is two
sites, M07 and M15, and I name M15 as an **adjacency read from its §7 and §6.1**
rather than as a finding I have derived end to end — that derivation is the
architect's and M15's own cycle structure is not something I opened this round.

**What I did with it.** Not patch around it, not implement to it, and not fix it:
`docs/specs/**` is outside my write scope and the repair is
architect_docs_lead's (charter §7 — a spec defect found mid-implementation is a
spec-change request, never a silent work-around). I implemented to **§6.1's cycle
table, which no repair moves**, and wrote the consequence into the module's own
doc comment so that no later reader concludes I built against a live spec sentence
in silence.

**On the instruction to STOP the affected part.** The affected part is the
*characterisation* of §7's constant, and no line of RTL implements a
characterisation. All three figures above describe the **same cycles** — output
word 0 at C + 1, output word n at C + 1 + n — because the disagreement is about
which quantity is named, not about when a word leaves; §7's own reason for the
figure (*"a registered output cannot do better"*) is a statement about the
pipeline that survives every candidate repair. So there is no part of this module
reachable from the disputed sentence, and stopping it would stop nothing. This is
the **C-RL-7** precedent applied exactly: implement to the text that governs, name
the defect in the artefact, route the repair as a question. It is **E2-adjacent
but not E2** — no requirement is added or dropped, no constant moves, no
conformant design changes — and it is routed to architect_docs_lead through the
orchestrator as **C-RL-8**.

#### 6. The invariants that do and do not bind M07

**REQ-004 and the line-rate invariant do not bind here, and saying so is part of
the record.** M07 is not on requirements.md §0.4's receive chain and is not in its
by-name stress list (M03, M06, M08, M10, M14, M17, M20). SPEC-M07 §8 says so and
names M07's equivalent obligation instead: M04's REQ-209 run of 10 000
minimum-length frames driven **through** M09 and M07, asserting the 11-cycle frame
period. What that run tests about M07 is that §3(b)'s drain fits inside M04's
inter-frame gap. My design's frame period from acceptance to acceptance is W + 1
cycles for a back-to-back offer — 9 cycles for the 46-octet stimulus — against the
11 M04 spends, so the drain fits with two cycles to spare **by derivation**;
dv_lead's composed run is the measurement and it is not mine to write.

**REQ-005 and REQ-019 likewise do not bind**: no §1.1 ceiling, no budget entry, no
payload-storage depth limit. I used three words of storage anyway (§3(d)) and
record that as a design choice rather than a compliance claim.

**REQ-208 holds structurally**: M07 has no receive-side port, so there is no path
from its `tready` into the receive datapath to argue about. That is what lets a
transmit module carry backpressure at all without touching REQ-003.

**REQ-021 holds at the output by construction**: frame octet 0 — `hdr_dst_mac`'s
most significant octet — is at `tx_tdata`[7:0] of output word 0, because the
fourteen header octets are placed with `concat_lsb` over the octets split most
significant first, which is REQ-012's numeric encode done by concatenation order
and not by a reversal network.

**One sentence of §6.2 I could not read literally, and did not.** Its closing line
says a cycle on which *"the source presents no payload word"* holds every state
and every register. Read without scope that would hang the drain: §6.1's own cycle
table shows output words 5, 6 and 7 leaving at C+6, C+7 and C+8 with the payload
input column **empty**, and a design that waited for a payload word there would
leave a frame it had begun without a `tlast`, which §9's frame-conservation
identity ("one frame in, one frame out") and §6.2's own `Drain` row forbid. The
table and §9 settle it, so this is a scope that the section supplies itself rather
than a second defect, and I built to the table. I record it here because the next
reader will hit the same sentence, and because if the architect judges that it
wants scoping in the text, this paragraph is where the request starts.

#### 7. What this round deliberately does not contain

- **No test, no bench, no golden model.** PROTOCOL §10 and charter §3: I never
  author the tests that gate my own modules. I wrote no smoke sim either — there
  is no local toolchain to run one on (§Evidence), and a smoke sim carries no DoD
  weight in any case.
- **No `bin/generate.ml` change and no `rtl_snapshots/eth_axis_tx.v`.** `bin/**`
  is inside my charter scope and outside **this round's** dispatched write set.
  Carried as **C-RL-6b** rather than mentioned once and dropped, with the M06 arc
  as its closing pattern: `J-rtl_lead-0016` registered the emitter and reddened
  the `build` workflow on purpose, `J-rtl_lead-0017` promoted the snapshot from
  that run's own failure. The two cannot land in one commit, because the
  determinism step's diff is what produces the snapshot's bytes.
- **No `docs/specs/**` edit.** §5's finding is routed as a request, not applied.
- **No dune change, and that is a checked fact rather than an omission.**
  `libs/hardcaml_ethernet/src/dune` declares no `(modules …)` field, so the
  library takes every module in its directory and a new `.ml`/`.mli` pair joins it
  with no edit. No new directory was created, so no dune disposition is owed.
- **No packet.** This round issues no `WO-` and no `RV-`; there is no worker round
  to review.
- **Nothing in the sibling's paths.** I read no file under `test/` at all.

### Actions

1. Ran the precheck (`git status --short`, `git rev-parse HEAD`) before opening
   any file; both matched the dispatch.
2. Read the charter, PROTOCOL, architecture.md §4, SPEC-M07 in full,
   requirements.md §0.4/§0.5 in full and §1.1/§1's REQ table, traceability's M07
   rows, the frozen `ifc_check` lift, and the three existing library modules
   nearest in role for house style.
3. Established M07 as the next module from architecture.md §4 and the directory
   contents independently (§1), and established that no §13 row names a defect in
   it (§1, §5).
4. Wrote `libs/hardcaml_ethernet/src/eth_axis_tx.mli` **first** — the module
   surface, matching SPEC-M07 §4.1's record shape — then
   `libs/hardcaml_ethernet/src/eth_axis_tx.ml`. One module fully on disk; no other
   module was opened for edit.
5. Wrote the count-carrying datapath, then replaced it with the shifted-`tkeep`
   formulation of §3(b) and removed `popcount`, W, J and the count-to-`tkeep`
   decode entirely.
6. Worked §4's arithmetic against SPEC-M07 §6.1's own cycle table and §8's
   figures — the 46-octet frame row for row, then 1500, 28, 8 and 1 — before
   treating the design as settled.
7. Derived §5's finding while checking §7 against requirements.md §0.5, then
   checked it against the architect's ledger and journal volume to establish it
   was new, then measured its reach across the three other transmit specs' §7
   bullets.
8. Ran the parse check of §Evidence with **two** negative controls, and the
   line-width check against `.ocamlformat`'s `janestreet` margin.
9. Established what does not build here by measurement rather than assertion
   (§Evidence) and claimed nothing from it.
10. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no git write
    of any kind.**

### Evidence

Reproducible from a checkout at this commit:

```sh
git status --short
#   exactly my two files and my journal; the declared sibling landed as
#   aabae58 mid-round, which is why nothing of its five remains here (§Trigger)

# the library takes new modules with no dune edit: no (modules) field
cat libs/hardcaml_ethernet/src/dune

# the surface against the frozen lift, read side by side
sed -n '/^module I = struct/,/^end/p'  docs/specs/ifc_check/eth_axis_tx_ifc.ml
sed -n '/^module I : sig/,/^end/p'     libs/hardcaml_ethernet/src/eth_axis_tx.mli
sed -n '/^module O = struct/,/^end/p'  docs/specs/ifc_check/eth_axis_tx_ifc.ml
sed -n '/^module O : sig/,/^end/p'     libs/hardcaml_ethernet/src/eth_axis_tx.mli

# no line exceeds .ocamlformat's janestreet margin of 90
awk 'length>90 {print FILENAME": "FNR}' libs/hardcaml_ethernet/src/eth_axis_tx.ml \
                                        libs/hardcaml_ethernet/src/eth_axis_tx.mli
#   (no output)
```

**The parse check, and its two negative controls, because a check that reports
clean without discriminating is not a check** (my own candidates 8 and 14):

```sh
ocamlc -version                                                          # 4.14.1
ocamlc -stop-after parsing -c libs/hardcaml_ethernet/src/eth_axis_tx.mli # exit 0
ocamlc -stop-after parsing -c libs/hardcaml_ethernet/src/eth_axis_tx.ml  # exit 0
printf 'let x = (1 +\n' > /tmp/bad.ml
ocamlc -stop-after parsing -c /tmp/bad.ml                                # exit 2
printf 'module I : sig type t end = struct end\n' > /tmp/bad.mli
ocamlc -stop-after parsing -c /tmp/bad.mli                               # exit 2
```

Both controls report `Syntax error`, one in each file class, so the check
discriminates in the direction it is being cited for.

**WHAT DOES NOT BUILD HERE, MEASURED RATHER THAN ASSERTED, AND WHAT IT MEANS.**
`opam list --installed | grep -ic hardcaml` returns **0** — ADR-0005's documented
condition, unchanged since `J-rtl_lead-0015` — and this container has gone one
step further: `dune` is no longer on `PATH` at all (`timeout 180 dune build
libs/hardcaml_ethernet/src` → `timeout: failed to run command 'dune': No such
file or directory`), so unlike `-0015` I could not even reach the
library-resolution error. `ocamlformat` is likewise absent, so `.ocamlformat`
conformance is **not** verified; line width is, and the style is held by
construction against the four existing modules.

**So: this module has NOT been compiled, NOT been type-checked, NOT elaborated,
NOT simulated and NOT emitted, and I claim none of those.** The parse check
establishes that the two files are syntactically well-formed OCaml and nothing
whatever beyond it — in particular it does not see a width mismatch, a wrong field
name, an unused binding under the dev profile's warning set, or a `Signal`
operator that does not exist. Against that last one the only control I had was
reading Hardcaml's own `comb_intf.ml` for the four signatures I was least sure of
(`concat_lsb`, `split_msb`, `select`, `ones`), which is recorded in Inputs. **The
first real verdict on this module is the `build` workflow's, and its run id
belongs in whatever entry reads it.**

**§4's cycle-by-cycle agreement with SPEC-M07 §6.1 is a derivation, not an
execution.** I worked it by hand against the specification's table and state it as
such; it is checkable by a reader with the two documents and no toolchain, which
is the only reason it is in Evidence at all.

**Not claimed, stated so the absence does not read as coverage**: that M07
compiles; that its event delay of 1 cycle is measured (it is derived — §4 — and
dv_lead measures it); that REQ-207's stall count of W − J + 1 is demonstrated (it
is structural — §3(b) — and §8's composed run is the proof); that any REQ of §10
is verified; that the `ifc_check` lift and my `.mli` are byte-identical (they are
not and should not be — the lift opens `Axi64_ifc` and mine opens the library's
`Axi64`, ADR-0010's consumer convention); that `eth_axis_tx` appears in
`rtl_snapshots/` (it does not — C-RL-6b). **Nothing in this entry is a
verification result and no DV sign-off is claimed** — `SO-` is dv_lead's to give.

### Outcome

M07 `Eth_axis_tx` is on disk, written from SPEC-M07 as frozen at `508eea2` plus
its C-17(b) row, with its `.mli` first and its `.ml` second, in the house style:
`[@@deriving hardcaml]` records with `[@rtlprefix]` on the nested ones, an
`Always` state machine over an `enumerate`d type, `Hierarchy.In_scope` for
`hierarchical`, one `open! Axi64` and no second record module (ADR-0010).

Charter §5's per-module DoD, honestly scored:

- Implements its frozen spec, every REQ satisfied or escalated — **met on
  authorship, unproven by execution.** No silent deviation: the one thing the
  specification says that no conformant design can be described by is §7's
  characterisation of its constant, and it is raised (§5) rather than absorbed;
  the one sentence I read against its own section is §6.2's closing line (§6).
- Compiles and elaborates hierarchically; `bin/generate.exe` emits it
  deterministically — **NOT met, and deliberately so this round.** No local
  toolchain at all (measured above); emission registration and the snapshot are
  **C-RL-6b**, owed to a later round with `bin/**` in its write set.
- House style holds; `.ocamlformat` clean — **style held by construction and
  against the existing modules; `.ocamlformat` is NOT verified**, because
  `ocamlformat` is not installed. Line width is checked.
- Rx-path module designed to the line-rate invariant — **no instance.** M07 is a
  transmit-path module (§6); its analogue is §8's composed REQ-209 run, which is
  dv_lead's.
- Worker modules reviewed line by line — **no instance**: no worker, no `RV-`.
- Journal entry appended, no DV sign-off claimed — **met.**

Charter §8's harvest-note obligation does not fire this round: PROTOCOL §7 ties it
to an `SO-` and to a phase gate, and this is neither. Span bookkeeping unchanged —
this seat's next harvest still opens at `J-rtl_lead-0013` (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator — for commit, and thence (a) to
architect_docs_lead as a spec-change request for SPEC-M07 §7's event-delay /
latency conflation and §0.5's inserting-module identity, with the SPEC-M15
adjacency named (§5, C-RL-8); and (b) to dv_lead as the seat that will bench M07
whenever the programme schedules it, with no test content from me.

### Open-questions

1. **C-RL-8 — SPEC-M07 §7 pins an event delay and prints it as a latency**, at a
   fourth site of the class `FINDING AP-M04-1` convicted REQ-210 for and the
   2026-08-11 sweep repaired at REQ-210 and REQ-611. The three figures are 8
   (printed), 16 (what §0.5's identity returns) and 22 (what §0.5's per-octet
   definition returns), derived in §5; the identity and the definition disagree
   here because M07's insertion is 14 and not a multiple of 8, which is the half
   that is not a relabel. Adjacency **measured, not estimated**: SPEC-M15 §7
   carries the identical sentence at a 20-octet insertion; SPEC-M18 §7 and
   SPEC-M11 §7 do not carry it. architect_docs_lead's, through the orchestrator.
   No cycle of SPEC-M07 moves under any candidate repair, which is why M07 was
   built rather than stopped.
2. **C-RL-6b — M07's emission is unregistered.** `bin/generate.ml` gains an
   `emit_eth_axis_tx` and `rtl_snapshots/eth_axis_tx.v` is promoted from a CI run,
   in a round whose write set includes `bin/**`. The M06 arc is the closing
   pattern and the emitter path is now proven twice (`J-rtl_lead-0016` →
   `J-rtl_lead-0017`, then the BUG-0004 promotion at `J-rtl_lead-0019`): the
   generator change and the snapshot **cannot** land in one commit, because the
   determinism step's diff is what produces the snapshot's bytes. Registering the
   emitter without a snapshot in the same window therefore reddens the `build`
   workflow by design — a decision to take deliberately rather than to discover.
3. **This module has no independent design review**, and it is the seventh in a
   row (§2). Carried alongside **the M06 independent design review, which is
   still owed and was not done this round** — M06 was not opened. R14 acquires no
   incident in either direction. §2 names M08 and M09 as the first delegable
   candidates and says what has to be read before either is chosen.
4. **REQ-902's two-run byte identity is now this seat's requirement, and this
   round did not touch it.** dv_lead's `-0176` closeout supersedes my standing
   non-claim with **one measured datapoint** and routes the requirement back to
   me. It needs a round with `bin/**` and `rtl_snapshots/**` in its write set —
   the same round as C-RL-6b, or a later one — and it is not discharged by
   promoting a snapshot, which transcribes one run and compares nothing across
   runs.
5. **Carried, unchanged and untouched by this round**: **C-RL-2** (the latent
   `first_v` gating in M03) and **C-RL-3** (sub-word idle granularity, no row
   owed). Neither is reachable from anything this round wrote; M03 was not opened.
6. **C-RL-7 is discharged and leaves this ledger.** SPEC-M06 §13's 2026-08-11 row
   repairs the retired per-octet-under-injection reading at all four of its sites
   in that file and states that §7 now names D. Recorded here rather than dropped
   silently, so that the item's closure has an entry to point at.

### Files-in-this-commit

- libs/hardcaml_ethernet/src/eth_axis_tx.ml
- libs/hardcaml_ethernet/src/eth_axis_tx.mli

## [J-rtl_lead-0021] 2026-08-11T14:30:54Z | task:none | M07's emitter registered and `build` reddened on purpose against a wholly green parent: the promotion block predicted at exactly one FILE entry on a precedent that has already run once, the duplicate-port red ruled out by an emitted netlist rather than by reading, and the REQ-902 rider declined because the only check `bin/**` can hold is unsound for the property it would claim

### Trigger

Orchestrator dispatch **C-RL-6b**, branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`, spawn-head `3951b05`. The
abort-first precheck ran before any read of substance: `git status --short`
printed nothing and `git rev-parse HEAD` returned
`3951b052ea74c12d003045aa857b92f322883164`, an exact match with the dispatch, so
neither the rollback path nor the descendant clause was reached.

The dispatch declares dv_lead live in this same tree on a concurrent round over
`agents/handoffs/WO-0081_tb-m04-families-d-e-g9.md`,
`test/attack_plans/AP-xgmii_tx_64.md`, `docs/specs/requirements.md`
(countersignature mechanics) and its own journal, and warns that its return may
land mid-round and move HEAD under me. **Neither happened at my sitting**: the
tree was clean at entry, so no sibling edit was in flight, and HEAD re-read at the
end of the round is still `3951b052…` (§Evidence). Nothing of the sibling's five
paths was opened for writing, and `docs/specs/requirements.md` was opened
**read-only**, for REQ-902's row and §0.5's output-offset term.

This round is the first half of my own carry **C-RL-6b**, raised one entry ago at
`J-rtl_lead-0020` Open-questions item 2, and it runs the pattern this seat
established at `J-rtl_lead-0016` → `J-rtl_lead-0017` and exercised a second time
at `J-rtl_lead-0019`. The dispatch also offers a rider — the REQ-902
one-datapoint follow-up — explicitly to my judgement. **I decline it, and §7 is
the reason, which is not schedule.**

### Inputs

- `agents/charters/rtl_lead.md` and `agents/PROTOCOL.md` in full (mandatory first
  actions; §5's DoD, §6's determinism criterion and PROTOCOL §6's write-scope row
  are what this round is measured against and bounded by).
- `bin/generate.ml` at `3951b05` **in full** — the one file edited, read whole
  first because its two block comments are the record of the `word_counter_top`
  lesson and a registration contradicting them would be a silent deviation.
- `bin/dune` and `libs/hardcaml_ethernet/src/dune` — read to establish that
  neither needs an edit (§3).
- `libs/hardcaml_ethernet/src/eth_axis_tx.mli` **in full**, and the `I`/`O` record
  definitions and header doc comment of `eth_axis_tx.ml` — **read only**. M07's
  source is landed at `cddad51`; this round does not open `libs/**` for writing.
- `libs/hardcaml_ethernet/src/axi64.mli`'s `Axi64` block — the sentence making
  `Source` and `Dest` distinct records with no `tready` in the former
  (REQ-003, REQ-010), which is §4's construction-side answer.
- `.github/workflows/build.yml` **in full**, and the body of its
  `Verify nothing was left unpromoted or non-deterministic` step compared byte
  for byte against the same step at `e9f371b` (§Evidence).
- **`J-architect_docs_lead-0041` and the `docs/specs/modules/eth_axis_tx.md` diff
  at `0b7be1f` in full** — read *before* writing anything in this entry that
  cites SPEC-M07 §7, per the dispatch. C-RL-8 UPHELD AND REFINED; §7 now carries
  the two-constant table (event delay 1 cycle · L = 22 · h = 0 · q = 6 · ΔC = 2
  counted to output word 1), the per-octet prohibition, and the idle-injection
  survival table with its deciding-input-word D column; §0.5 gained the output
  offset q. §8 below is what that ruling costs my own shipped source.
- `docs/specs/architecture.md` §4's M07 row (which fixes both the emitted name and
  the file name), SPEC-M07 §10's REQ-903/REQ-808 row, and
  `docs/specs/requirements.md`'s REQ-902 row with its verification column.
- `tools/check_emitted_verilog.sh` — the REQ-808 `extra`/`missing` branches and
  the REQ-903 inventory parser, to establish what the *next* round's promoted
  bytes will meet; `tools/dv_checks.sh` grepped for `generate` (three comment
  hits, no invocation).
- `rtl_snapshots/eth_mac_10g.v` and `rtl_snapshots/eth_axis_rx.v` — their
  top-level port lists, as the emitted evidence in §4; and the unnamed-wire index
  ranges of all five committed snapshots, as the measurement in §6.
- `.gitignore`, plus a `git check-ignore` probe on a path that does not exist yet.
- My own `J-rtl_lead-0016` (the pattern, and its §4–§6 which this round does not
  re-derive), `-0017`, `-0019` and `-0020`.
- `J-dv_lead-0176` §9 — the determinism datapoint and the sentence routing REQ-902
  back to this seat.
- GitHub Actions: runs **31500640010** (`3951b05`, the parent), **31495302673**
  (`cddad51`, where M07's source landed) and the historical pair **31465181652** /
  **31467035116** from the M06 arc. Job- and step-level conclusions read via the
  API, quoted in Evidence.
- **No `test/third_party/` material opened this round; no Essenceia/Nasdaq-HFT-FPGA
  material consulted, for this or for anything in it** (charter §8, Inputs
  honesty). Registering an emitter has no prior-art question in it.

### Reasoning

#### 1. The decision is not re-argued, only re-applied

`J-rtl_lead-0016` §1 settled why the emitter and the snapshot cannot land in one
commit: `rtl_snapshots/**` is a build product of a toolchain this container does
not have (ADR-0005), so the only bytes that may enter a snapshot are bytes CI
produced, and CI produces them by failing. The sequence is forced — register,
redden at one named step, promote the printed bytes. That reasoning is landed and
the mechanism has now run twice end to end (M06 at `e9f371b` → `f34d0e2`, and the
BUG-0004 re-promotion at `J-rtl_lead-0019`). **I re-apply it and do not re-litigate
it**; what is new this round is §4, §6 and §7, and nothing else here is novel.

The refused alternatives are refused on the same ground and by the same sentence:
a hand-authored snapshot is a machine-produced expectation authored by the party
it grades, and a placeholder is worse than the absence, because the determinism
step's failure would then read as *drift* rather than *never committed*. **The
absence is legible; a placeholder is a lie with a diff.**

#### 2. The registration, and the three sentences of comment it made false

`emit_eth_axis_tx` is the M03/M04/M05/M06 shape, character for character in
structure: own `Scope.create ~flatten_design:false ()`, `Circuit.With_interface
(Eth_axis_tx.I) (Eth_axis_tx.O)`, top built with **`create`** under
`~name:"eth_axis_tx"`, one `Rtl.output` to the channel. The list row
`"rtl_snapshots/eth_axis_tx.v", emit_eth_axis_tx` is **appended after M06**, which
is architecture.md §4's inventory order.

`eth_axis_tx` and `eth_axis_tx.v` are not my choices: architecture.md §4's M07 row
names the module and, in its own column, the file; SPEC-M07 §10's REQ-903/REQ-808
row requires a distinct emitted module of that name; and it is the same string
`eth_axis_tx.ml`'s own `hierarchical` registers, so M07 has one name in the
netlist whether it is emitted standalone here or instantiated by a future parent.

The `create`-not-`hierarchical` horn is M06's argument unchanged and it applies
verbatim: SPEC-M07 §1 says M07 instantiates nothing, so the "supplies the
children" half is vacuous, and the other half is not — emitting through
`Eth_axis_tx.hierarchical` under a top of the same name reproduces the
`word_counter_top` collision exactly and yields a shell instantiating a module
that is not in the file, while the renaming escape is closed for a design module
by REQ-808's `extra` branch.

The comment repairs are **three, and all three are corrections of counts rather
than new argument**: the spec list `M03/M04/M05/M06` → `M03/M04/M05/M06/M07`; the
emitted-name list gains `` `eth_axis_tx` ``; "§12 of all four specs" → "all five".
The childless-module paragraph, added last round for M06 alone, now names M06 and
M07 together, because SPEC-M07 §1 says exactly what SPEC-M06 §1 says. **I did not
add a paragraph.** M07 raises no new naming question, and a comment that grows a
section per module stops being read, which defeats the reason it exists.

#### 3. What did not need to change, established rather than assumed

`libs/hardcaml_ethernet/src/dune` has no `(modules)` field, so the library already
exports `Eth_axis_tx`, and `open Hardcaml_ethernet` at the top of `generate.ml`
already brings it into scope; `bin/dune` already lists `hardcaml_ethernet`. **No
dune file is touched**, which is worth stating because dune/opam project files are
the orchestrator's scope (charter §7, E3) and a registration that had needed one
would have been an escalation rather than an edit.

**The dispatch's conditional `libs/hardcaml_ethernet/**` allowance was not
exercised and no hook was required.** `eth_axis_tx.mli` already exports
`val create : Scope.t -> Signal.t I.t -> Signal.t O.t` and modules `I` and `O`
with `[@@deriving hardcaml]` — the same surface the four sibling emitters consume,
at the same arity, in the same order. Not one byte under `libs/**` was opened for
writing.

**And nothing was created under `rtl_snapshots/`** — no snapshot, no placeholder,
no empty file. The dispatch asked me to say so if the arc's first half turned out
to touch it. It does not, and it must not: the snapshot arrives from CI's bytes in
the second half, and a file placed here by me would be the hand-authored
expectation §1 refuses.

#### 4. The one failure mode M06's registration did not have to clear

M06's every prefix serves one direction: `rx_` is a `Source` in, `payload_` a
`Source` out, `hdr_` an output record. **M07 is the first module registered in
this generator whose prefixes each span both stream directions** — `payload_` is
an `Axi64.Source` **input** and an `Axi64.Dest` **output**; `tx_` is an
`Axi64.Dest` **input** and an `Axi64.Source` **output**. `Circuit.create_exn`
raises on a duplicate port name, so this is a real question about step 7 and not a
formality. It is answered twice, and the second answer is the one that does not
depend on my reading:

**(a) By construction.** `axi64.mli` states that `Axi64.Source` and `Axi64.Dest`
are distinct records and that this "is how a receive-path port is declared with no
`tready` in it (REQ-003)". The two flattenings under one prefix are therefore
disjoint by the record definition, not by luck.

**(b) By an emitted netlist that already exists in this repository.**
`rtl_snapshots/eth_mac_10g.v`'s top-level port list carries `tx_tvalid`,
`tx_tdata`, `tx_tkeep`, `tx_tstrb`, `tx_tlast`, `tx_tuser` **and** `tx_tready` —
one prefix, both records, one circuit, already emitted by this same generator
through this same `create` horn. M07 reverses which side is input, and the
duplicate-name question is blind to direction. The full 20-name port set for M07
is enumerated in Evidence; no two of the twenty are equal.

#### 5. Which step goes red, and the parent that makes the answer sharp

Named exactly, because "the build will be red" is not a prediction anyone can
falsify. The failing step is **`Verify nothing was left unpromoted or
non-deterministic`**, job **`build`**, `.github/workflows/build.yml:57`, step 8 of
10. Its body is **byte-identical** to the body I executed and verified at
`J-rtl_lead-0016` §4 — `diff` against `e9f371b` reports no difference (§Evidence)
— so that round's finding transfers rather than being re-asserted, and I re-ran it
once against this round's new filename anyway because the filename is the only
part of it that changed.

**The discriminator this arc has and the M06 arc did not: the parent is wholly
green.** Run **31500640010** at `3951b05` finished with all ten `build` steps
`success` — including step 7 `Generate RTL` and step 8 itself — and with the
`cosim` job green. So every step ahead of mine is known-passing on precisely the
tree I am editing, and **a red at step 5, 6, 7, 9 or 10 is this commit's defect
and not the schedule.**

- **Step 5 `Build`** (`dune build @default`) — reached; my four new lines are the
  only new code. A failure here prints a compiler error, not a promotion block.
  What raises the odds it passes, stated precisely so it is not overclaimed: at
  `cddad51`, `Build` concluded `success` (run 31495302673, job `build`, step 5),
  and `@default` builds `libs/hardcaml_ethernet` — so `Eth_axis_tx`, its `I`, its
  `O` and `create`'s arity **already type-check**. What has never been compiled is
  the four lines in `generate.ml` that name them.
- **Step 6 `Run tests`** — cannot see this change. Nothing under `test/` and no
  `dune` file references `bin/` or `generate.exe` (measured), and the step runs
  *before* `Generate RTL` regardless. Worth flagging because this is the step that
  failed at `cddad51` — an expect-test promotion, dv's — and it is green again at
  the parent, so a red here would be a new event and not a leftover.
- **Step 7 `Generate RTL`** — reached, and **the one place a different red could
  appear**: `Circuit.create_exn` on a duplicate port name. §4 rules it out two
  ways. If it raises anyway, that is a **defect report to make, not a promotion to
  harvest**, and the two are told apart by which step's name appears in the log.
- **Steps 9 and 10 do not run at all** — a failed step skips the rest of the job.
  Their silence this round is **not** a result, in either direction.
- **`cosim`** is a separate job referencing neither `generate.exe` nor
  `rtl_snapshots/**`, and should stay green. If it reddens on this commit, that is
  not this commit's doing and must be investigated as such.

#### 6. The shape of the block: exactly ONE `--- FILE` entry, on three independent grounds

The dispatch asks for the expected shape, and the sharpest part of the shape is a
negative — that the other four snapshots do **not** appear.

**(a) Historical, and it is the very same mechanism.** `e9f371b` appended M06's
emitter as the fifth entry in this list; `f34d0e2` promoted **exactly one file**,
`rtl_snapshots/eth_axis_rx.v`, and run **31467035116** then went green. Had
appending an emitter perturbed the four earlier files' bytes, that one-file
promotion would have been insufficient and the next run would have reddened again
listing them. It did not. The M07 append is the same act one position later.

**(b) Measured, and it says *why*.** The unnamed-wire indices in the emitted
Verilog are **file-local, not process-global**. Across the five committed
snapshots in emission order the lowest index is 2, 2, 1, 1 and 3 — whereas a
process-global monotonic counter would leave `eth_axis_rx.v`, emitted fifth,
starting above the ~7,300 wire names `eth_mac_10g.v` alone consumes. So an
emitter's *position* in the list does not reach any file's bytes. This is exactly
what `generate.ml`'s own comment asserts ("this list's order cannot leak into any
of them"); until now that was an assertion, and it is now a measurement.

**(c) Trivially, from the diff.** The four earlier emitter functions are
character-identical before and after this change, the four modules' sources are
untouched, and step 8 was green at the parent — so those four regenerate
byte-identically on the tree I am editing.

Consequently the block's predicted shape is: one `--- FILE
rtl_snapshots/eth_axis_tx.v`, its `sha256sum` line, its `base64 -w 400` payload,
one matching `--- END`, no `--- DELETED` line anywhere, and **no test failure
anywhere in the log** — the promotion block *is* the snapshot's bytes, and the red
carries no other content. **I predict no byte count and no line count for the
file**; M06's came out at 8,015 bytes and M07 has more datapath than M06, but a
figure I cannot compute is a guess dressed as a prediction.

What the promoted bytes will meet next round, checked now so the promotion is not
a gamble: `Eth_axis_tx` is architecture.md §4 inventory row M07, so the snapshot
arrives as an inventory name and **cannot** land in REQ-808's `extra` (`fail`)
branch. **REQ-808 does not turn green either** — M08…M20 remain unemitted, so it
stays `pend` with one fewer name, and a promotion round expecting green would read
a correct `pend` as a regression. REQ-903's two parts were already satisfied when
M07's source landed and are untouched by this registration. REQ-018's whitelist
gains nothing to check, because M07 instantiates nothing.

#### 7. The REQ-902 rider: declined, and the reason is not schedule

`J-dv_lead-0176` §9 superseded my standing non-claim with one measured datapoint
and routed the requirement back to me, recording that the workflow "generates
**once** and compares against the committed tree, so this is cross-run identity
between two commits and **not** a double-generation check". That reading is
correct and I adopt it. Two corrections to the surrounding picture, then the
refusal:

**The datapoint is no longer one.** Run 31500640010's step 8 at the parent is a
second instance of the same observable, and every green `build` on this branch is
another. What none of them is, is a *double generation*.

**The rider's premise — that the requirement needs exactly the `bin/**` +
`rtl_snapshots/**` surface — is one file short.** Regeneration is a **process
invocation**, and the only file in this repository that invokes `generate.exe` is
`.github/workflows/build.yml`, whose scope is the orchestrator's exclusively
(PROTOCOL §6). **Nothing I can stage under `bin/**` causes the executable to be
run a second time.**

**The only check that fits inside `bin/**` is a second emission within the same
process, compared in memory — and it is unsound for this requirement.** The
nondeterminism classes REQ-902 exists to catch are process-scoped: hash-seed
randomisation, address- or allocation-order dependence, environment and locale.
All are fixed once per process, so an in-process second call **cannot expose any
of them** and would report clean in exactly the cases where the property fails. It
is not free of the opposite error either: whether a second in-process emission of
the same circuit even *should* produce identical text depends on whether
Hardcaml's signal naming is process-global, and §6(b) measures that only *across
files within one run*, which does not settle it. I have no toolchain here to
settle it — `dune` is not on `PATH`, `opam list --installed | grep -ic hardcaml`
returns 0, `ocamlformat` is absent (all three measured in Evidence). **A check
that can pass while the property fails, and might fail while it holds, is worse
than the absence it replaces**, and shipping it would let a later reader believe
REQ-902 was instrumented when it was not.

**And it cannot share this commit even if it were sound.** Any behaviour change to
`generate.exe` adds a second candidate red site at steps 5 and 7, which destroys
the single thing this two-commit pattern runs on: that a reader tells a scheduled
red from a defect **by the failing step's name alone**. The rider and the arc want
the same commit and cannot have it.

**So it stays queued, and I name what would discharge it** so it is routed rather
than carried indefinitely. One step in `.github/workflows/build.yml`, placed after
`Generate RTL` and before the determinism step, that runs the already-built
executable **a second time as a separate process from a different working
directory** and diffs the two output trees — `_build/default/bin/generate.exe`
executed with cwd in a scratch directory, then `diff -r` of its `rtl_snapshots`
against the checkout's. That is a workflow edit and an orchestrator act. If the
orchestrator would rather this seat hold the instrument, I can write the
comparison script — but not in `bin/`, which by this repository's convention holds
the OCaml executable and nothing else, and not in an arc commit; and the
invocation would still not be mine. My part of the item is the derivation above
and it is discharged here.

#### 8. A finding I raise and deliberately do not repair: M07's doc comment now describes a closed defect

`libs/hardcaml_ethernet/src/eth_axis_tx.ml`'s header comment ends with a section
titled *"The constant, and the finding this module was written against"*, which
states that what §7 calls the figure "is a **live spec defect** and is raised, not
absorbed", and that "§0.5's identity L = 8·ΔC − h returns 16 for it". Both
sentences were true when written at `cddad51`. **Neither is true at `0b7be1f`.**
The architect UPHELD C-RL-8: §7 now carries the two-constant table — event delay
**1 cycle** to output word 0, **L = 22** octet times per payload octet, **h = 0**,
**q = 6**, **ΔC = 2** counted to output word 1 — §0.5 gained the output offset q so
the identity reads 8·2 − 0 + 6 = 22 and agrees with the derivation instead of
contradicting it, and SPEC-M07 §13's 2026-08-11 row records the repair. The defect
is closed, so shipped source calling it live is now wrong.

**I have not repaired it, and both reasons bind:**

- **Scope.** The dispatch opens `libs/hardcaml_ethernet/**` only if the emitter
  registration mechanically requires a hook. It does not (§3). A doc-comment
  repair is not a hook, and taking it would be a silent widening of a declared
  write set — the exact species of act my charter §6 scores as a finding.
- **Preservation, which matters more here than it looks.** SPEC-M07 §13's row
  rests its *editorial* classification on that very comment: it records that the
  M07 RTL "was written to §6.1's table with this defect already named in its own
  doc comment (`J-rtl_lead-0020` §5, which derived L = 22 independently — that
  independence is what this row rests on rather than my arithmetic alone)". The
  comment is a **cited evidentiary artefact**. It should be *updated* — to record
  that the finding was raised, upheld and refined, with the ruling's commit named
  — and never quietly rewritten to read as though it had always said the new
  thing.

One consequence worth stating because it makes the repair cheap and schedulable:
**the repair is snapshot-neutral.** A doc comment reaches no signal, so
regenerating over a repaired `eth_axis_tx.ml` emits identical Verilog and the
determinism step stays green. It can therefore land in any later round **without**
re-promoting `rtl_snapshots/eth_axis_tx.v` — and it specifically must **not** be
folded into the promotion commit, whose write set is the snapshot alone. New carry
**C-RL-9**.

#### 9. What this entry deliberately does not claim

**`bin/generate.ml` has not been compiled.** The parse check below sees syntax and
nothing else — not a type, not `Eth_axis_tx.create`'s arity as I applied it, not a
warning-as-error under the dev profile. **No run id is cited for this commit,
because no run has executed it**; every run id in Evidence belongs to a commit at
or before the parent.

Equally not claimed: that `rtl_snapshots/eth_axis_tx.v` will contain a correct
netlist (its correctness is dv_lead's and the co-sim lane's; its *existence* is the
next round's); that REQ-902 holds for M07 (a property of bytes that do not exist);
that REQ-808 turns green (§6 — it stays `pend`); that M07 has had an independent
design review (it has not — registering an emitter reviews no logic and nothing
here should be read as having done so); that the line-rate invariant is
demonstrated (M07 is a transmit-path module and has no instance of it). **Nothing
in this entry is a verification result and no DV sign-off is claimed** — `SO-` is
dv_lead's to give.

### Actions

1. Ran the abort-first precheck (`git status --short`, `git rev-parse HEAD`) before
   opening any file; tree clean, HEAD an exact match, no sibling edit in flight.
2. Read the charter and PROTOCOL in full, then `J-architect_docs_lead-0041` and
   the SPEC-M07 diff at `0b7be1f` **before writing any sentence citing §7**, then
   the round's remaining inputs.
3. Re-verified the promotion mechanism rather than assuming it transferred: diffed
   the determinism step's body against `e9f371b` (identical), probed
   `git check-ignore` on the not-yet-existing path (exit 1, not ignored), and ran
   the step's body verbatim in a throwaway repo against an untracked
   `rtl_snapshots/eth_axis_tx.v`.
4. Established §4's duplicate-port answer from `axi64.mli` and, independently,
   from `rtl_snapshots/eth_mac_10g.v`'s emitted port list; enumerated M07's twenty
   port names and checked them pairwise distinct.
5. Read the parent's CI run and `cddad51`'s at job and step granularity, and
   established the green baseline and the fact that M07's own source already
   type-checks.
6. Measured §6(b)'s wire-index ranges across all five committed snapshots, and
   read `f34d0e2`'s file list to confirm §6(a)'s precedent.
7. Edited `bin/generate.ml` and nothing else: one new `emit_eth_axis_tx` in the
   M03–M06 pattern, one list row appended after M06, three count corrections and
   one paragraph generalisation in the block comments.
8. **Created no file under `rtl_snapshots/`, and opened no file under `libs/**`
   for writing.**
9. Parse-checked the edit with two negative controls, one shaped like the edit
   itself, and ran the line-width check against `.ocamlformat`'s margin.
10. Re-ran the precheck at the end of the round to confirm HEAD had not moved
    under me.
11. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no
    `scripts/agent_commit.sh`, no git write of any kind.**

### Evidence

Reproducible from a checkout at this commit:

```sh
git status --short
#    M bin/generate.ml            (plus this journal; nothing else)

git diff bin/generate.ml
#   one new emitter, one list row, two comment blocks updated

# the library takes the new emitter with no dune edit: no (modules) field
cat libs/hardcaml_ethernet/src/dune
```

**Parse check with two negative controls, because a check that cannot report
failure is not a check:**

```sh
ocamlc -version                                        # 4.14.1
ocamlc -stop-after parsing -c bin/generate.ml          # exit 0
printf 'let x = (1 +\n' > bad.ml
ocamlc -stop-after parsing -c bad.ml                   # exit 2, "Syntax error"
printf 'let f o =\n  let module C = Circuit.With_interface (A.I) (A.O in\n  C.create_exn ~name:"x" o\n;;\n' > bad2.ml
ocamlc -stop-after parsing -c bad2.ml                  # exit 2, "This '(' might be unmatched"

awk 'length>90 {print FILENAME": "FNR}' bin/generate.ml   # (no output; janestreet margin)
```

The second control is the one that counts: a malformed `Circuit.With_interface`
application, the exact construct this round added, and the parser rejects it — so
the positive result discriminates over the edit's own shape.

**The determinism step's body is unchanged since the M06 registration, so
`J-rtl_lead-0016` §4's execution transfers:**

```sh
diff <(git show e9f371b:.github/workflows/build.yml | sed -n '57,84p') \
     <(sed -n '57,84p' .github/workflows/build.yml)     # no output
git check-ignore -v rtl_snapshots/eth_axis_tx.v ; echo "exit=$?"   # exit=1, not ignored
```

**Re-run once against this round's filename** (the step's body verbatim, in a
throwaway repo staging one never-committed file under `rtl_snapshots/`):

```text
=== PROMOTION BLOCK: sha256 + base64 -w 400 of every staged path ===
--- FILE rtl_snapshots/eth_axis_tx.v
cc551c1603f5f0cb78cd9dd996df25f215e43db02fddf6cf596dbac0de43c368  rtl_snapshots/eth_axis_tx.v
bW9kdWxlIGV0aF9heGlzX3R4OwplbmRtb2R1bGUK
--- END rtl_snapshots/eth_axis_tx.v
=== END PROMOTION BLOCK ===
step-would-exit 1
```

The stand-in's contents are two lines of my own invention and prove nothing about
M07's netlist; what they establish is the **shape of the step's behaviour on an
untracked path under this filename**, which is the only thing in question.

**§4's duplicate-port answer, from an emitted netlist rather than from reading:**

```sh
awk '/^module eth_mac_10g \(/,/^\);/' rtl_snapshots/eth_mac_10g.v
#   ... tx_tuser, tx_tlast, tx_tstrb, tx_tkeep, tx_tdata, tx_tvalid ...
#   ... tx_tready ...          <- one prefix, Source and Dest, one circuit
```

M07's twenty flattened port names, enumerated so the pairwise-distinct claim is
checkable rather than asserted — 13 in, 7 out:

| direction | names |
|---|---|
| in | `clock`, `clear`, `hdr_valid`, `hdr_dst_mac`, `hdr_src_mac`, `hdr_ethertype`, `payload_tvalid`, `payload_tdata`, `payload_tkeep`, `payload_tstrb`, `payload_tlast`, `payload_tuser`, `tx_tready` |
| out | `payload_tready`, `tx_tvalid`, `tx_tdata`, `tx_tkeep`, `tx_tstrb`, `tx_tlast`, `tx_tuser` |

**§6(b)'s measurement — wire numbering is file-local, so the list's order cannot
reach any file's bytes:**

```sh
for f in word_counter xgmii_rx_64 xgmii_tx_64 eth_mac_10g eth_axis_rx; do
  grep -oE '\b_[0-9]+\b' rtl_snapshots/$f.v | tr -d '_' | sort -n \
    | awk -v F=$f 'NR==1{min=$1}{max=$1}END{printf "%-14s min=%-6s max=%-6s count=%s\n",F,min,max,NR}'
done
```

observed, in emission order:

| file | min | max | wire references |
|---|---|---|---|
| `word_counter.v` | 2 | 13 | 41 |
| `xgmii_rx_64.v` | 2 | 873 | 4557 |
| `xgmii_tx_64.v` | 1 | 834 | 4351 |
| `eth_mac_10g.v` | 1 | 873 | 7305 |
| `eth_axis_rx.v` | 3 | 149 | 430 |

The fifth-emitted file starts at 3, not above 7,300 — the counter is per emission,
not per process.

**§6(a)'s precedent, read from history rather than recalled:**

```sh
git show --stat --oneline f34d0e2 | head -5
#   rtl_snapshots/eth_axis_rx.v   +362      <- exactly one snapshot promoted
#   (and my journal)                        <- and the next run, 31467035116, was green
```

**The CI baseline, at job and step granularity** (externally verifiable references
per PROTOCOL §4.1(b); read via the Actions API, not from a local execution):

| run | commit | job | outcome |
|---|---|---|---|
| **31500640010** | `3951b05` (the parent) | `build` | **all 10 steps `success`**, incl. step 7 `Generate RTL` and step 8 `Verify nothing was left unpromoted or non-deterministic` |
| 31500640010 | `3951b05` | `cosim` | `success` |
| **31495302673** | `cddad51` (M07 source) | `build` | step 5 `Build` **`success`** → M07 already type-checks; step 6 `Run tests` `failure`; steps 7–10 `skipped` |
| 31465181652 / 31467035116 | M06 arc | `build` | the red and the green of the pattern this round repeats |

**What does not build here, measured rather than asserted:** `dune` is not on
`PATH` (`dune build …` → `No such file or directory`), `opam list --installed |
grep -ic hardcaml` returns **0** (ADR-0005's documented condition), and
`ocamlformat` is absent — so `.ocamlformat` conformance is **not** verified and
line width is what is checked. This is also §7's evidence that the in-process
question cannot be settled at this SHA.

**THE PREDICTION THIS ENTRY EXISTS TO MAKE, stated so the next red is scheduled
rather than discovered.** At the commit carrying this entry, the `build` workflow
**WILL FAIL**, at the step named **`Verify nothing was left unpromoted or
non-deterministic`** (job `build`, step 8, `.github/workflows/build.yml:57`),
printing a `=== PROMOTION BLOCK ===` containing **exactly one `--- FILE` entry** —
`rtl_snapshots/eth_axis_tx.v`, with its `sha256sum` line and its `base64 -w 400`
payload — followed by one matching `--- END` and `=== END PROMOTION BLOCK ===`.
**No `--- DELETED` line. No second `--- FILE` entry. No test failure anywhere in
the log.** Those bytes are the snapshot, and committing them verbatim is the
second commit of this arc. **A red at any other step of this workflow, or a block
listing more than one file, is NOT this prediction coming true and must be read as
a defect in this commit.**

**Not claimed** (§9): that `bin/generate.ml` compiles; that `generate.exe` runs;
that the emitted netlist is correct, deterministic, or reviewed; any DV result.

### Outcome

M07 is registered in the RTL emission path in the pattern this seat established at
M06 and has now applied three times, and the scheduled red is named at one step,
one job and one file in advance, against a parent whose every step is green.

Charter §5's DoD, scored against what this round was actually for:

- Implements its frozen spec, deviations escalated — **no instance this round**;
  no `libs/**` file was opened for writing, and M07's conformance to SPEC-M07 is
  `J-rtl_lead-0020`'s claim, unchanged and not re-asserted here. One *new* spec-
  adjacent finding is raised rather than absorbed and it runs the other way (§8:
  my own source now lags a ruling in my favour).
- `bin/generate.exe` emits it into `rtl_snapshots/**` deterministically, two
  consecutive runs byte-identical — **NOT met, deliberately and visibly.** The
  emitter is registered; the snapshot does not exist; determinism is a property of
  bytes not yet produced. This is the half of C-RL-6b that a second commit closes,
  and the red between them is the mechanism, not a lapse. The *two-run* clause
  specifically is §7's declined rider and remains owed.
- House style / `.ocamlformat` clean — the edit follows the four sibling emitters
  character for character in structure; **`ocamlformat` itself is NOT run** (not
  installed here, measured), line width is checked.
- Rx-path line-rate invariant — no instance; no RTL changed, and M07 is a
  transmit-path module.
- Worker review — no instance; no worker, no `RV-`.
- Journal entry appended, no DV sign-off claimed — **met.**

Charter §8's determinism-evidence rule fires (this entry touches
`bin/generate.exe`) and is discharged **negatively and explicitly**: the
double-generation byte-identity check **cannot be run at this SHA**, the reason is
measured rather than asserted, and §7 says who can run it and how.

Charter §8's harvest-note obligation does not fire: PROTOCOL §7 ties it to an
`SO-` and to a phase gate, and this is neither. Span bookkeeping unchanged — this
seat's next harvest still opens at `J-rtl_lead-0013` (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator, for commit and for the board note — the red
window on this branch opens the moment this lands, its expected shape is in
Evidence line for line so the board entry and the CI log can be compared, and the
promotion round should be the **next** commit on this branch (Open-questions 2).

### Open-questions

1. **C-RL-6b is half discharged.** The remainder — promoting
   `rtl_snapshots/eth_axis_tx.v` verbatim from the `PROMOTION BLOCK` this commit's
   run prints, in a round whose write set includes `rtl_snapshots/**` and whose
   entry cites the run id it harvested — I label **C-RL-6b/2** rather than minting
   a fresh top-level id: the M06 arc's `C-RL-6`/`C-RL-6a` pair showed that a new
   id at the halfway point reads as a new obligation rather than a continuation.
   Until it lands, `build` is red on this branch **by design** and every agent
   reading CI should know why.
2. **The red window is a real cost and I will not describe it as free.** While it
   is open, `build` certifies nothing else on this branch: a genuine regression
   landing in the same window is masked by a failure everyone has been told to
   expect. The sibling round declared in my Trigger makes this concrete — if
   dv_lead's return lands between this commit and the promotion, its CI signal is
   inside my window. That is an argument for keeping the window to one round: the
   promotion should be the **next** commit, not the next convenient one.
3. **C-RL-9 — M07's doc comment describes a defect that has been closed** (§8).
   `libs/hardcaml_ethernet/src/eth_axis_tx.ml`'s header calls the §7 conflation a
   *live* spec defect and quotes §0.5's identity in its pre-`q` form; `0b7be1f`
   upheld the finding and repaired both. Mine, needing a round with
   `libs/hardcaml_ethernet/**` in its write set. **Snapshot-neutral** — a comment
   reaches no signal, so it re-emits identically and must **not** ride the
   promotion commit, whose write set is the snapshot alone. The repair updates the
   comment to record that the finding was raised and upheld; it does not delete
   it, because SPEC-M07 §13's row cites that comment as the independent derivation
   its *editorial* classification rests on.
4. **REQ-902's two-run byte identity is carried, not discharged, and this round
   declined the offered rider on grounds, not on schedule** (§7). What is owed is
   a **second process invocation** compared byte for byte; the only file that
   invokes `generate.exe` is `.github/workflows/build.yml`, which is the
   orchestrator's exclusive scope. The check that would fit in `bin/**` is
   in-process and therefore blind to every nondeterminism class the requirement
   exists to catch. **Route: the orchestrator**, as a one-step workflow addition;
   my derivation of what that step must do is §7 and is complete. If the
   orchestrator wants this seat to author the comparison script instead, that is a
   round of its own and not an arc commit — and the invocation is still not mine.
5. **C-RL-8 is discharged and leaves this ledger.** `0b7be1f`
   (`J-architect_docs_lead-0041`) UPHELD the finding and refined it past what I
   filed: I filed the event-delay/latency conflation and the §0.5 identity's
   disagreement, and the architect added the ground I had **not** filed — that the
   straddle test keyed on h alone licenses a wrapper assertion **every conformant
   design fails** — and ruled §0.5's repair a **term (q), not a scope**. Recorded
   here rather than dropped silently, so the closure has an entry to point at, and
   noted as the second consecutive round in which a routed finding came back
   larger than it went out.
6. **M07 still has no independent design review**, and it is the seventh module in
   a row. Carried alongside **the M06 independent design review, which remains
   owed and was not done this round** — neither module was opened. Registering an
   emitter reviews no logic.
7. **Carried, unchanged and untouched by this round**: **C-RL-2** (the latent
   `first_v` gating in M03) and **C-RL-3** (sub-word idle granularity, no row
   owed). Neither is reachable from anything this round wrote; M03 was not opened.

### Files-in-this-commit

- bin/generate.ml

## [J-rtl_lead-0022] 2026-08-11T14:54:33Z | task:none | C-RL-6b closed in the two commits it was designed to take: `rtl_snapshots/eth_axis_tx.v` promoted from run 31502554670's own failure through three mutually independent channels, the eight-clause prediction scored against the API's step records rather than against a relay, and the netlist read as reviewer turning one asserted claim into an artifact — zero arithmetic operators in 387 lines

### Trigger

Orchestrator dispatch, second half of **C-RL-6b**, branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`, spawn-head `500dbed`. The
precheck ran first: `git status --short` printed nothing and `git rev-parse HEAD`
returned `500dbeda373669732318a9c607cecf2a959d6736`, matching the dispatch.

**HEAD moved under me mid-round, exactly as declared**, to `0092325` — the
orchestrator's clerical §13 transcription commit
(`docs/specs/requirements.md` + its own journal, 2 files, 48 insertions). Per the
dispatch's standing clause I re-verified only that my read surfaces were
unchanged, and they are: `bin/generate.ml`, `.github/workflows/build.yml`,
`docs/specs/architecture.md`, `tools/check_emitted_verilog.sh`,
`tools/dv_checks.sh` and `libs/hardcaml_ethernet/src/eth_axis_tx.ml` are all
byte-identical across `500dbed..0092325`. I ran one further check the dispatch did
not ask for, because a promotion is only valid against the tree that produced it —
§5 below.

The dispatch also instructs me to score my own prediction rather than take the
relay's reading of it. I do, from the Actions API's own step records: §1.

### Inputs

- The **job log of run 31502554670, job `build` (93815981078)** — its step-8
  `PROMOTION BLOCK` in full (the `--- FILE` header, the sha256 line, all 29
  base64 lines, the `--- END`), and the `git diff --cached` `+` lines printed
  immediately above it, which are §2's second channel.
- The **Actions API step records** for both jobs of run 31502554670, at step
  granularity — the evidence for §1's scorecard, read directly rather than
  accepted from the dispatch.
- My own **`J-rtl_lead-0021`** — the prediction being scored, and its Evidence
  table of twenty port names, which is §2's third channel; **`J-rtl_lead-0017`**,
  the M06 promotion precedent this round follows; **`J-rtl_lead-0019` §5**, whose
  determinism-watch wording §5 reuses deliberately rather than reinventing.
- `libs/hardcaml_ethernet/src/eth_axis_tx.ml`'s header doc comment — **read
  only**, as the description the emitted netlist is reviewed against (§3).
- `docs/specs/modules/eth_axis_tx.md` §6.1 (the realignment and the header split)
  and §10's REQ-014/REQ-012/REQ-021 rows.
- `tools/check_emitted_verilog.sh`, **executed** against the tree with the
  snapshot in place (§4).
- charter §5 (DoD), §6 (determinism criterion), §8 (determinism evidence);
  PROTOCOL §4.2 and R3.
- **No `test/third_party/` material opened; no Essenceia/Nasdaq-HFT-FPGA material
  consulted, for this or for anything in it** (charter §8, Inputs honesty).
  Transcribing a checksummed artifact has no prior-art question in it.

### Reasoning

#### 1. Scoring my own prediction, clause by clause, from the step records

`J-rtl_lead-0021`'s prediction was not "the build will be red" — it named one
step, excluded four others, predicted two skips, predicted the block's
**cardinality**, and predicted a **negative**. All eight clauses are scored below
against the API's own `conclusion` fields.

| # | Predicted at `J-rtl_lead-0021` | Observed, run 31502554670 | |
|---|---|---|---|
| 1 | fails at step 8, **`Verify nothing was left unpromoted or non-deterministic`**, job `build` | step 8 `failure` — and the **only** failing step in the job | ✔ |
| 2 | step 5 `Build` reached; a red here is my defect, not the schedule | `success` | ✔ |
| 3 | step 6 `Run tests` cannot see this change | `success` (and it had **failed** at `cddad51`, so this is a real re-pass, not inertia) | ✔ |
| 4 | step 7 `Generate RTL` — the one place a *different* red could appear, via `Circuit.create_exn` on a duplicate port name | `success` — §4 of that entry's two answers held | ✔ |
| 5 | steps 9 and 10 "do not run at all; their silence is not a result" | both `skipped` | ✔ |
| 6 | `cosim` unaffected, should stay green | `success` | ✔ |
| 7 | block carries **exactly one** `--- FILE`, no `--- DELETED`, no second `--- FILE` | one `--- FILE rtl_snapshots/eth_axis_tx.v`, one `--- END`, no `--- DELETED` | ✔ |
| 8 | **no test failure anywhere in the log** | none | ✔ |

Clause 4 is the one that was genuinely open. M07 is the first module registered in
this generator whose prefixes each span both stream directions, and
`Circuit.create_exn` raises on a duplicate port name; the entry answered it from
`axi64.mli`'s record distinctness and from `eth_mac_10g.v`'s already-emitted port
list. Step 7's `success` is that answer confirmed by execution.

**One figure I deliberately declined to predict** and therefore do not get to
claim: the file's size. `J-rtl_lead-0021` said "I predict no byte count and no line
count — a figure I cannot compute is a guess dressed as a prediction." It is
**8,661 bytes, 387 lines**, which is now known and was not forecast.

#### 2. Three channels, and what each one actually buys

`J-rtl_lead-0017` established that the bytes are re-derived before they are placed.
Three channels, and the reason for each is that the previous one cannot catch the
next one's error class:

**Channel 1 — checksum.** `sha256sum` of the base64-decoded bytes equals the sha
CI printed: `48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04`.
This catches **any transcription error in the payload**. It does not catch
transcribing a *consistent pair* — payload and sha both taken from the wrong
place.

**Channel 2 — a second serialisation, by a different tool, in the same step.** The
step prints the file twice in different forms: `git diff --cached` emits it as
`+`-prefixed plaintext, and `base64 -w 400` emits it as base64. I transcribed the
plaintext channel independently (68 lines, the file's tail) and diffed it against
the decoded file's last 68 lines: **identical**. Two tools, two encodings, one
agreement — this is what catches the consistent-but-wrong-source error channel 1
is blind to.

**Channel 3 — a prior written prediction, independent of the log entirely.**
`J-rtl_lead-0021`'s Evidence table enumerated M07's twenty flattened port names
**before these bytes existed**. The emitted module's port list is **set-equal** to
that table: twenty names, none missing, none extra. This catches the error neither
log channel can — that the log is right, the transcription is right, and it is the
wrong module.

**A fourth reading, of the placement itself.** The sha was re-taken *after* `cp`,
at `rtl_snapshots/eth_axis_tx.v`, and holds. The verified object is the file in the
tree, not a scratch file that was once equal to it.

**The transcription's own shape corroborates it independently of content:** 28
lines of exactly 400 characters and one of 348, which is what `base64 -w 400`
produces and what a dropped or doubled line would not.

#### 3. The netlist read as reviewer, and the one claim it converts from assertion to artifact

Read, not touched. Every observation below is a property of CI's bytes.

- **One module, `eth_axis_tx`, lines 1–387.** No child instance anywhere and no
  self-instantiating shell — the `word_counter_top` failure mode did not occur,
  and SPEC-M07 §1's "instantiates nothing" is now visible in *emitted* form rather
  than only in the source. 13 `reg` declarations, 13 `always @(posedge)` blocks.
- **The two-position realignment, applied to `tkeep` as well as `tdata`** — the
  design's central decision (`J-rtl_lead-0020` §3(b)), legible in the netlist as
  two concatenations of the same shape: `_95 = { _73[1:0], _93[7:2] }` for
  `tkeep`, `_133 = { _103[15:0], _131[63:16] }` for `tdata`. Positions 0–5 from
  the older word's 2–7, positions 6–7 from the newer word's 0–1, in both planes.
- **The end of frame is one comparator and one AND**: `_76 = (_73[7:2] ==
  6'b000000)`, `_77 = _23 & _76` — `new_last & (new_keep[7:2] = 0)`, the doc
  comment's formula emitted verbatim in structure.
- **The header, 112 bits, split 8 + 6.** `_106` is `[111:0]` — fourteen octets.
  Output word 0 (`_142`) takes octets 0–7 with `_141 = _106[111:104]` — the first
  wire octet — **last in the concatenation and therefore in the low byte**, which
  is REQ-012/REQ-021's "frame octet 0 at `tx_tdata[7:0]`". The pseudo payload word
  is `_127 = { _125, 16'b0 }`: header octets 8–13 at byte positions 2–7, zeros at
  0–1 — exactly the doc comment's "pseudo payload word whose positions 2 to 7 are
  header octets 8 to 13".
- **REQ-014**: `tx_tstrb` is driven from `_87 = 8'b00000000`.

**THE CLAIM THAT BECOMES AN ARTIFACT.** `J-rtl_lead-0020` claimed this module
"contains no octet counter, no `popcount` and no length arithmetic: it never forms
W, J or W − J at all". Until this commit that was a claim about OCaml I had
written, checkable only by reading me. The emitted netlist contains **zero `+` and
zero `-` operators in 387 lines**. The claim is now checkable by a reader who never
opens my source, against an artifact I did not author.

**What this review is not.** It confirms that the emission carries the design the
source describes. It is **not** the independent design review M07 still lacks, and
it cannot be: I am checking a netlist against a doc comment I wrote, so both sides
of the comparison are mine. And no defect it found would have been fixed here — a
promoted snapshot is never edited; a defect would have been a `libs/**` bug in a
different round.

#### 4. The next run's step 9, forecast by executing it rather than reading it

`tools/check_emitted_verilog.sh` is a shell script and needs no OCaml, so the
forecast is an execution. With the snapshot in place: **5 checks run, 0 failures, 3
pending.**

- **REQ-808** accepts `eth_axis_tx` as an inventory name — it leaves the `missing`
  list, which drops from fourteen names to thirteen — and stays **PENDING**. This
  is precisely what `J-rtl_lead-0021` §6 predicted and warned about: *"a promotion
  round expecting green would read a correct `pend` as a regression."* It does not
  go green until M08…M20 are emitted, which is a P1-module-ready condition.
- **REQ-018 whitelist** stays PASS — M07 adds no instantiation to check.
- **REQ-001** single-clock now quantifies over M07's thirteen `posedge`
  expressions as well and passes.
- **REQ-903** stays PENDING at 7 of 20, **unchanged** — M07's `.mli` was already
  counted when its source landed, and a snapshot does not move that check.

So step 9 should pass at the next run, and step 8 should go green — which is §5.

#### 5. The determinism watch for M07, live, in the form that convicts me

`J-rtl_lead-0019` §5 fixed the wording for this and I reuse it rather than
reinvent it:

> A future `build` red printing a `PROMOTION BLOCK` for
> `rtl_snapshots/eth_axis_tx.v` with a sha **different** from
> `48c4b03b…beb04`, **absent any change to
> `libs/hardcaml_ethernet/src/eth_axis_tx.ml` or `bin/generate.ml` between the two
> runs**, is the nondeterminism signature. It is a REQ-902 defect, charter §6
> makes it mine to root-cause, and **it is emphatically not a promotion to
> repeat** — re-promoting the new bytes would launder a nondeterministic emitter
> into history and destroy the only evidence that it happened.

The source-change proviso is load-bearing in both directions: a different sha
*with* a source change is the expected outcome and not a finding, and a promotion
round that treats every second block as routine is exactly how a real determinism
break gets absorbed.

Symmetrically: **if step 8 goes green at the commit carrying this entry, that is
M07's first emission-determinism datapoint** and the first byte-identity
observation REQ-902 has ever had on this path.

**And this round can sharpen that reading in a way the M06 round could not.** A
promotion is only sound against the tree that produced the bytes, so I measured
it: `git diff 89ef55e..0092325 -- bin/ libs/ rtl_snapshots/` is **empty** — the
emitter and M07's source are byte-identical between the commit CI generated from
and the commit this entry lands on, across two intervening commits. So a green at
step 8 will be a clean cross-run byte identity and not a comparison spanning a
source change. Had `bin/` or `libs/` moved under me, these bytes would be **stale**
and the promotion would have had to be re-taken from a new run; that is why the
check was run rather than assumed.

#### 6. What did not ride this commit, by my own rule

**C-RL-9** — M07's doc comment still describing a defect the architect closed at
`0b7be1f` — is a `libs/**` edit and stays out. `J-rtl_lead-0021` wrote that it
"must **not** be folded into the promotion commit, whose write set is the snapshot
alone", and a rule whose author breaks it at the first opportunity is not a rule.
**REQ-902's two-run instrument** is a `.github/**` step and is not mine to stage.
No handoff packet, no test, no spec, no `libs/`, no `bin/`. The write set is one
file.

#### 7. What this entry deliberately does not claim

- **The netlist is not verified.** It has been emitted, transcribed, checksummed
  four times and read. It has **not** been simulated, co-simulated, synthesised,
  linted, or run against a testbench, and no `SO-` is implied — that is dv_lead's
  to give.
- **REQ-902 is not discharged by this commit.** My own words at `J-rtl_lead-0020`
  item 4: promotion "transcribes one run and compares nothing across runs". The
  datapoint this round *enables* arrives at the **next** run, not here, and the
  two-run instrument remains owed and routed (Open-questions 4).
- §3 is **not** an independent design review, and not a correctness check against
  SPEC-M07 §6.1's cycle table — it checks emitted structure against the design's
  own description, which is a weaker thing, and both sides are mine.
- **REQ-808 does not turn green** (§4), and the line-rate invariant has no
  instance here (M07 is a transmit-path module).

### Actions

1. Ran the precheck (`git status --short`, `git rev-parse HEAD`) before opening
   anything; clean tree, HEAD matching the dispatch.
2. Read the run's **step records** from the Actions API and scored
   `J-rtl_lead-0021`'s eight clauses myself (§1) before reading the log body, so
   the scorecard could not be shaped by the payload.
3. Fetched the job log for job 93815981078, extracted the step-8 promotion block,
   and transcribed the 29 base64 lines and, separately, the 68 plaintext `+` diff
   lines above it.
4. Decoded, then verified through the three channels and the shape check (§2),
   **before** placing a byte.
5. Placed the decoded bytes at `rtl_snapshots/eth_axis_tx.v` **verbatim** and
   re-took the sha at the destination path (fourth reading).
6. Read the emitted netlist as reviewer (§3) and **changed nothing in it**.
7. Executed `tools/check_emitted_verilog.sh` against the tree with the snapshot in
   place, to forecast the next run's step 9 by execution (§4).
8. Detected the declared HEAD move to `0092325`, re-verified my six read surfaces
   unchanged, and measured `bin/`/`libs/`/`rtl_snapshots/` byte-identical between
   `89ef55e` and `0092325` (§5).
9. Opened **no** file under `libs/`, `top/`, `bin/`, `test/`, `tools/`, `docs/` or
   `agents/handoffs/` for writing. C-RL-9 deliberately left undone (§6).
10. Wrote this entry. **No `git add`, no `git commit`, no `git push`, no
    `scripts/agent_commit.sh`, no git write of any kind.**

### Evidence

Reproducible from a checkout at this commit:

```sh
git status --short
#   ?? rtl_snapshots/eth_axis_tx.v      (plus this journal; nothing else)

sha256sum rtl_snapshots/eth_axis_tx.v
#   48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04
wc -c rtl_snapshots/eth_axis_tx.v      # 8661
wc -l rtl_snapshots/eth_axis_tx.v      # 387
```

**CI's own figure, for comparison** — printed by run 31502554670, job `build`
(93815981078), step 8, in the line immediately after
`--- FILE rtl_snapshots/eth_axis_tx.v`:

```text
48c4b03b88ba2fc211fc145b0a9c1747e7f610513cbef80767ee7e22897beb04  rtl_snapshots/eth_axis_tx.v
```

The two are equal, which is **channel 1**.

**Channel 2 — the log's other serialisation of the same bytes:**

```sh
# 68 plaintext '+' lines transcribed from the same step's git-diff output
diff <(tail -n 68 rtl_snapshots/eth_axis_tx.v) diff_channel.txt   # no output
```

**Channel 3 — the artifact against a prediction written before it existed:**

```sh
awk '/^module eth_axis_tx \(/,/^\);/' rtl_snapshots/eth_axis_tx.v \
  | grep -oE '[a-z_0-9]+,|[a-z_0-9]+$' | tr -d ',' | sort > got_ports.txt
# compared against J-rtl_lead-0021's twenty-name Evidence table
#   emitted 20, predicted 20, diff empty — set-equal
```

**Transcription shape** (independent of content): 28 base64 lines of exactly 400
characters, one of 348 — the signature of `base64 -w 400`.

**The prediction scorecard's source**, so the auditor re-executes the same query
rather than trusting my table: the Actions API job listing for run
**31502554670**, job **93815981078** — step 5 `success`, step 6 `success`, step 7
`success`, **step 8 `failure`**, steps 9 and 10 `skipped`; job **93815981081**
(`cosim`) `success`.

**§3's reviewer reads, each a command over CI's bytes:**

```sh
grep -n '^module \|^endmodule' rtl_snapshots/eth_axis_tx.v   # 1: module eth_axis_tx (   387: endmodule
grep -c '^    reg ' rtl_snapshots/eth_axis_tx.v              # 13
grep -c 'always @(posedge' rtl_snapshots/eth_axis_tx.v       # 13
grep -nE '_94 =|_88 =|_95 =|_132 =|_104 =|_133 =' rtl_snapshots/eth_axis_tx.v
#   _94 = _93[7:2];  _88 = _73[1:0];  _95 = { _88, _94 }      <- tkeep, two positions
#   _132 = _131[63:16];  _104 = _103[15:0];  _133 = { _104, _132 }   <- tdata, same two
grep -nE '_74 =|_75 =|_76 =|_77 =' rtl_snapshots/eth_axis_tx.v
#   _75 = 6'b000000;  _74 = _73[7:2];  _76 = _74 == _75;  _77 = _23 & _76

# THE CLAIM THAT BECAME AN ARTIFACT: no adder, no subtracter, anywhere
grep -cE "[^_a-z0-9] [+-] " rtl_snapshots/eth_axis_tx.v      # 0
```

**§4's forecast, executed:**

```sh
tools/check_emitted_verilog.sh
#   emitted modules: crc32_eth eth_axis_rx eth_axis_tx eth_mac_10g word_counter
#                    word_counter_top xgmii_rx_64 xgmii_tx_64
#   PENDING  REQ-808: inventory module(s) not yet emitted: eth_demux … nic_top   (13, was 14)
#   PASS     REQ-018 whitelist / REQ-001 single clock / REQ-306
#   PENDING  REQ-903: 7 of 20 … (unchanged)
#   5 check(s) run, 0 failure(s), 3 pending
```

**§5's tree-identity check, which is what makes the promoted bytes the right
bytes:**

```sh
git diff --stat 89ef55e..0092325 -- bin/ libs/ rtl_snapshots/    # (empty)
git diff --stat 500dbed..0092325
#   agents/journals/claude_orchestrator_agent.v02.md | 47 +
#   docs/specs/requirements.md                       |  1 +
```

**Not claimed** (§7): that the netlist is verified, simulated or co-simulated;
that REQ-902 is discharged; that §3 is an independent design review; any DV result.

### Outcome

**C-RL-6b is closed entire, in the two commits the decision was designed to take,
and the red window on this branch closed at one round** — `89ef55e` (emitter,
scheduled red) → this commit (promotion), with no third commit and no unrelated
work landing inside the window.

Charter §5's DoD, scored against what this round was for:

- Implements its frozen spec, deviations escalated — **no instance**; no `libs/**`
  file opened. M07's conformance remains `J-rtl_lead-0020`'s claim.
- `bin/generate.exe` emits it into `rtl_snapshots/**`; two consecutive runs
  byte-identical — **emission met, byte-identity NOT yet observed.** The module is
  now emitted and the snapshot is in the tree; the two-run property is §5's watch,
  and it resolves at the next run, not here.
- House style / `.ocamlformat` — **no instance**; the file is machine-generated
  Verilog and was not authored or formatted by me.
- Rx-path line-rate invariant — no instance; M07 is transmit-path.
- Worker review — no instance; no worker, no `RV-`.
- Journal entry appended, no DV sign-off claimed — **met.**

Charter §8's determinism-evidence rule fires (this entry touches
`rtl_snapshots/**`) and is discharged **negatively and explicitly, for the second
consecutive round**: the double-generation byte-identity check cannot be run here
(no `dune`, no `hardcaml`, measured at `J-rtl_lead-0021`), and this round is the
*transcription* half, which by construction compares nothing across runs. §5's
falsifiable watch is what stands in its place, and Open-questions 4 names who can
replace it with a real instrument.

Charter §8's harvest-note obligation does not fire: PROTOCOL §7 ties it to an
`SO-` and a phase gate, and this is neither. Span bookkeeping unchanged — this
seat's next harvest still opens at `J-rtl_lead-0013` (ADR-0018 `A2-D10`).

**Handoff**: to the orchestrator, for commit. The one thing worth watching on the
run this commit triggers is §5's watch and it is falsifiable in both directions:
green at step 8 is M07's first emission-determinism datapoint; a second red
printing a *different* sha for this path, with `bin/` and `libs/` unmoved, is a
REQ-902 defect that comes back to me and **must not be re-promoted**.

### Open-questions

1. **C-RL-6b is discharged and leaves this ledger**, both halves: the emitter at
   `89ef55e` (`J-rtl_lead-0021`) and the snapshot here. The two-commit pattern has
   now run three times on this branch (M06, the BUG-0004 re-promotion, M07) and
   its cost is measured rather than estimated — one red window, one round wide.
2. **M07's emission determinism is asserted by no one yet.** REQ-902's byte
   identity has never been observed for this module; the next CI run is its first
   test. §5 states both branches and which of them is mine to root-cause. **This
   is a watch item, not a carry** — it resolves on its own within one run, and the
   watch value is `48c4b03b…beb04`.
3. **C-RL-9 carried, deliberately untouched** (§6): M07's doc comment still calls
   a closed defect live and still quotes §0.5's identity in its pre-`q` form.
   Mine, needing a round with `libs/hardcaml_ethernet/**` in its write set;
   snapshot-neutral, so it re-emits identically and cannot invalidate the bytes
   promoted here.
4. **REQ-902's two-run instrument carried, route unchanged**: a second *process*
   invocation compared byte for byte, which only `.github/workflows/build.yml` can
   cause, so the route is the orchestrator's. `J-rtl_lead-0021` §7 is the complete
   derivation of what that step must do; nothing in this round changes it, and
   this round's promotion is not a partial discharge of it.
5. **M07 has no independent design review, and neither does M06.** §3 is not one
   and says so. Carried unchanged; nothing in this round moves either.
6. **Carried, unchanged and untouched**: **C-RL-2** (the latent `first_v` gating
   in M03) and **C-RL-3** (sub-word idle granularity, no row owed). M03 was not
   opened.

### Files-in-this-commit

- rtl_snapshots/eth_axis_tx.v
