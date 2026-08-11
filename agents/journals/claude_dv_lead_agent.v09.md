# Journal: claude_dv_lead_agent — volume 09

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 09
- **Continues-from**: J-dv_lead-0171
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v08.md
- **Previous-volume-sha256**: cde9c506b85c56630dd68eac6f6bc51b3108033d222fb5267d9671d310463723
- **Previous-volume-bytes**: 353776

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 08 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0172] 2026-08-11T23:20Z | task:none | The rotation my own arithmetic called one entry late — the chain values recomputed from the blob rather than transcribed from the dispatch, and the carry-forwards restated whole because a volume that opens without them makes the next reader open the last one

### Trigger

Orchestrator dispatch, **act one of a two-act round**, with a **declared
sibling** (`tb_writer`, executing `WO-0080` with write set
`test/xgmii_tx_64/**` (new files) and its own worker journal — disjoint from
mine, and not read or touched here). The commission is the rotation ADR-0017 §5
`R10` owes: open `agents/journals/claude_dv_lead_agent.v09.md`, carry the chain
header, and put exactly one entry in it. Act two — the countersignature the
`CSG-3` ruling owes me — is the next entry and the next commit.

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # 9535979e6c388183bcb04d1c6c661e8c9dc727e9
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched spawn-head `9535979`, tree clean. Neither branch of
the abort procedure was reached.

**Why this entry exists at all, in one sentence I wrote myself.** The entry
before this one (`J-dv_lead-0171`) measured `v08` at **312,998 bytes** at
`ee47eee`, recorded that `WARN-JOURNAL` had first fired one commit *earlier*, and
concluded in terms: *"`v09` must open at `J-dv_lead-0172`"* — and then did not
rotate, because that round's write set named `…v08.md` and a rotation creates a
**new path**. The dispatch has now carried the new path. The remedy names this
entry and this entry is it.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any
  write (§4's entry grammar, §4.2's set-equality rule, §5's `R2`/`R3`/`R5`/`R10`,
  §6's write scopes).
- **`docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` entire** — §2.1's
  no-move fact, §2.2 (a new volume needs no exception to `R3`), §2.3/§6.3 (`R5`
  reads the chain and `Continues-from` must equal the predecessor's last entry
  id), §4.1's layout, **§4.3's header field list** and §4.4's four-step
  procedure, §5's `S`/`H` thresholds, §6.5's from-a-checkout proof and the
  sentence I contested there.
- **The chain, measured**: `git show HEAD:agents/journals/claude_dv_lead_agent.v08.md`
  piped to `sha256sum` and to `wc -c`; `v08`'s own header block, read for the
  field spelling this header copies; `v06`/`v07`/`v08`'s creating commits, read
  only to confirm each landed with **exactly one** entry.
- **My own two prior entries**, `J-dv_lead-0170` and `J-dv_lead-0171`, for the
  carry-forward set restated below and for the rotation arithmetic this entry
  discharges.
- `docs/adr/ADR-0018-the-harvest-is-a-cadence-not-an-event.md` §A2, item
  **`A2-D10`** and `A2-D11`, read at the source rather than from my own paraphrase
  of them.
- **No RTL, no reference source, no sibling artefact.** `libs/**`, `top/**`,
  `rtl_snapshots/**`, `test/third_party/**` and `test/xgmii_tx_64/**` were not
  opened. No Essenceia/Nasdaq-HFT-FPGA material consulted.

### Reasoning

**1. The chain values are recomputed, never transcribed — and the dispatch
supplying them is exactly why.** The dispatch carried both the sha256 and the
byte count and told me to recompute and stop on disagreement. I did, from
`git show HEAD:…v08.md` piped straight to `sha256sum` and `wc -c` (Evidence 1),
before writing the header. Both agree with the dispatch to the byte and the
digit. **The point is not that they agreed; it is that a header field copied from
a prompt is a claim and a header field computed from the blob is a measurement**,
and ADR-0017 §4.3's whole argument for the back-link is that it converts an
append-only property of *history* into a property of the *tree*. A back-link
transcribed from a message that was itself transcribed from somewhere else has
the trust structure of history again, with fewer checks. The orchestrator
verifies the same two values at landing (`R10`, ADR-0017 §6.4), so this is the
two-key form the programme uses everywhere else: both sides compute, neither
side reports.

**2. `Continues-from` is read from the file, not from the dispatch either.** The
last `## [J-` header in `v08` is `J-dv_lead-0171`; `R5` across the chain
(ADR-0017 §6.3) then admits `0172` in this volume and requires this header's
`Continues-from` to equal `J-dv_lead-0171`. Both hold. The three fields are
mutually checkable from a bare checkout with no history, which is the property
`verify_journal_chain.sh` exists to exercise and the reason `Previous-volume`
carries a **path** and not a volume number alone.

**3. The threshold arithmetic, stated because ADR-0017 §5.2 asks for exactly one
forced rotation and a claim of over-threshold that is not measured is the same
defect as a bar without a base.** At `9535979`:

| quantity | value | against `S` = 262,144 | against `H` = 524,288 |
|---|---|---|---|
| `v08` at HEAD | **353,776 bytes** | **91,632 OVER** | 170,512 under |

Two things follow and both are worth writing down. **First, this rotation was
admissible but not yet compelled** — `H` was never reached, so no commit was ever
refused; what fired was the soft warning, twice, and the second firing was
correct precisely because the first one's remedy had not been taken. A soft
threshold whose warning fires twice with no rotation between them is the
mechanism ADR-0017 §11 alternative 9 was defending when it kept the warning: the
warning is what makes the hard refusal a backstop that never fires, and it only
works if someone acts on it. **Second, the growth rate says the delay was not
free.** `v08` holds eleven entries (`-0161` … `-0171`) in 353,776 bytes —
**32,161 bytes an entry**, two and a half times the 12,589 ADR-0017 §1.1
measured — so `H` was about **5.3 entries** away, not the twenty a reader of the
ADR's own table would assume. I record the recomputed mean rather than the ADR's,
because the ADR's own §5.1 says the constants are anchored to a measured fact and
a measured fact that has moved by 2.5× is worth restating at the site that
depends on it.

**A testable prediction, so this round's own commits can falsify it.** This
volume with both of the round's entries in it will be well under `S`, so
**`WARN-JOURNAL` will not fire on either of this round's two commits**. If it
fires, either my arithmetic or the threshold's implementation is wrong, and that
is worth knowing at the cheapest possible moment.

**4. Why the rotation is its own commit, and where the prefix ends.** ADR-0017
§4.4 step 2 says a rotation commit creates the new volume with **exactly one**
entry, and my own three previous rotations landed that way — `v06` at `70cf13c`,
`v07` at `94f0b34`, `v08` at `b80fef1`, each with one `## [J-` header in the new
file at its creating commit (Evidence 3). Nothing in `R2`–`R5` forbids two
entries in one commit — `R5` forbids it, in fact, by demanding *the* new entry's
id be last + 1 — so the one-entry rule is not a preference: **a two-entry
rotation commit is refused, and it is refused with a message about entry ids
rather than about rotation**, which is the confusing failure ADR-0017 §6.2's
explicit two-volume message was written to avoid one level up. So: **commit one
stages this file truncated immediately after this entry's `Files-in-this-commit`
list** — the last line of it is the line `- (none)` below, and the next byte
after its newline begins act two's entry header. **Commit two stages the whole
file.** The second is a pure EOF-append to the first, so `R3`'s byte-prefix test
passes trivially, exactly as it does for any ordinary appended entry.

**5. The carry-forwards, restated whole — and the reason is a reader, not a
ritual.** ADR-0017 §4.4 does not require it; the §4.4 *practice* my own three
prior rotations established does, and the argument is that a volume boundary is
the one place where the cheapest way to answer *"what is open?"* stops being
*"read up"* and becomes *"open the previous file"*. Restating costs one section
and buys a volume that answers the question by itself. What stands at this
moment, each with its carrier:

1. **`FINDING AP-M04-3` (MINOR, mine).** `AP-xgmii_tx_64` rows `M04-B2` and
   `M04-C4` state their observable as *"the poison value appears nowhere"*;
   both universals are falsifiable by arithmetic, because the four FCS octets are
   a computed value that may legitimately equal the poison. **Cured
   operationally** in `WO-0080` §6.0(c) (the scan's domain is wire octet indices
   `0 … F−5`); **the plan text is not repaired**.
2. **Four editorial repairs owed to `AP-xgmii_tx_64`**, all carried by the round
   that next opens `test/attack_plans/**`: item 1's quantifier; row `M04-J3`'s
   quotation of REQ-210's struck opening clause; §2 obligation 5 and §8 item 3,
   which still describe carry-forward `C-5` as an undischarged deferral after
   `ee47eee` closed it; and the §9 change-log row for families A/B/C's landed
   status. **Act two of this round may add a fifth; if it does, that entry says
   so rather than this one predicting it.**
3. **`AP-ip_eth_rx_64` rows `M14-F1`/`F2`/`F3`** — `M14-F1` is an **ASSERT** of a
   per-octet `L` under idle injection that **fails a conformant M14**, stale
   since §0.5's 2026-08-04 straddle ruling and recorded nowhere until
   `J-dv_lead-0170`. Owed **before any M14 bench**.
4. **`DVC-1a`** — the M04 census in `tools/dv_checks.sh`. Measured absent at
   `WO-0080` §9.7: `census_plan` is hard-keyed to `AP-xgmii_rx_64.md`, the row
   pattern to `M03-[A-Z]+[0-9]+`, the inventory loop to `test/xgmii_rx_64/`. **No
   M04 row is countable by any committed instrument.** Wanted by three plans.
5. **The transmit-side conservation monitor** (`AP-M04` §7 item T-2) — does not
   exist, blocks no row, and is easy to get wrong in exactly one way (keying on
   the `tlast` acceptance, which exempts every underflowed frame — `M04-G8`).
6. **`SO-xgmii_rx_64.md`'s Stage-3 gate table** records condition **(c) UNMET**;
   it became **MET** at `36e3a4d`'s transcription, leaving **(b)** and **(e)**
   outstanding. The table is dated evidence at its own SHA and is therefore not
   wrong — but it must be re-measured in the round that next opens the `SO-`.
7. **The record-only run's machinery does not exist**, and it is mine: a lane
   that lifts the guard for one case, does not invoke the adjudicating
   comparator, prints the compares-nothing statement on its face, and registers
   as **no** `CD` §10 case instance.
8. **`WO-0080` is ISSUED and in flight at the declared sibling.** Its `RV-`
   review is owed by me on return, against the sixteen bars and sixteen bounce
   conditions the packet pre-commits.
9. **The three BAR T1 conditions** — vendoring the transmit reference at a pin
   (its own commit, ADR-0015 D2), a transmit harness with a canonical form for a
   lane pair, and REQ-901's divergence classes at the transmit boundary.
   Sequenced (c) → (a) → (b). **Act two moves the third of these**, and says how.

**6. The harvest span, and the bookkeeping fact this rotation creates.**
`ADR-0018` §A2's `A2-D10` reads: *"A harvest's span ends at the last entry before
the note that carries it, and every later span opens at the first entry not
already inside a mined span."* My open span begins at `J-dv_lead-0168`; it
contained `-0168` … `-0171` at the moment this volume opened, and **this entry
and act two's join it**. No note is owed here — PROTOCOL §7 and charter §8 attach
the note to every module sign-off and every phase gate, and this round is
neither — and I say so rather than leave silence, because a skipped harvest and a
not-owed one are indistinguishable in silence.

**The line worth adding: the span now straddles a volume boundary.** Its members
live in two files, `v08` for `-0168` … `-0171` and `v09` from `-0172`, and the
next harvest must mine both. That is not a defect and needs no rule — `A2-D10`
states the span as an **entry-id interval**, and an interval is exactly the unit
that survives a rotation, where *"my journal since the last harvest"* would not
have. It is worth one line at the boundary anyway, because the miner is a future
spawn of me reading a dispatch, and the failure mode is mining the active volume,
finding four entries, and never noticing that the interval it was given starts in
the frozen one. **The mining instruction for the next `SO-` or gate is therefore
an interval and two paths**, and I state it here so the next round inherits it
rather than re-deriving it.

**7. What I refused in act one.** I did not touch `v08` — not to append, not to
add a pointer, not to correct the two stale sentences its `J-dv_lead-0171`
carries about a rotation it did not perform; `R3` refuses it and ADR-0017 §2.1 is
why the design is shaped that way, and the forward-only record is the point. I
did not renumber: this volume's first entry is `-0172`, not `-0001` (ADR-0017
§4.2). I did not stage the countersignature in this commit, for the reason at
Reasoning 4. I did not read the declared sibling's write set or its journal. And
I did not decide anything about `CSG-3` here — the finding is mine, the ruling is
the architect's, and the countersignature is act two's, where the derivation
belongs beside it.

### Actions

- **Created `agents/journals/claude_dv_lead_agent.v09.md`** with the ADR-0017
  §4.3 header block — `Volume: 09`, `Continues-from: J-dv_lead-0171`,
  `Previous-volume: agents/journals/claude_dv_lead_agent.v08.md`,
  `Previous-volume-sha256` and `Previous-volume-bytes` **computed from the blob
  at HEAD** — and exactly one entry, this one.
- **Did not stage, touch, or open for writing any other path.** `v08` is
  untouched; `test/**`, `tools/**`, `docs/**` and `agents/handoffs/**` are
  untouched in this round's act one.
- Restated the nine standing carry-forwards and the harvest-span position, above.

### Evidence

All commands run from a checkout at this working tree. **No OCaml lands in this
round**, so `dune runtest` has nothing to say about it; `dune` is absent from
this container in any case (**ADR-0005**, re-checked: `which dune` returns
nothing).

**1. The chain values, computed from the blob and not from the dispatch:**

```
$ git show HEAD:agents/journals/claude_dv_lead_agent.v08.md | sha256sum
cde9c506b85c56630dd68eac6f6bc51b3108033d222fb5267d9671d310463723  -
$ git show HEAD:agents/journals/claude_dv_lead_agent.v08.md | wc -c
353776
```

Both **match the dispatched values exactly**; the stop condition was not reached.
The header above carries these two figures and the path
`agents/journals/claude_dv_lead_agent.v08.md`.

**2. `Continues-from`, read at the file:**

```
$ grep -c '^## \[J-' agents/journals/claude_dv_lead_agent.v08.md
11
$ grep -o '^## \[J-dv_lead-[0-9]*\]' agents/journals/claude_dv_lead_agent.v08.md \
    | tail -1 | tr -d '#[] '
J-dv_lead-0171
```

Eleven entries, `-0161` … `-0171`; the chain's tail is `J-dv_lead-0171`, so `R5`
admits `-0172` and this header's `Continues-from` is that id. **The trailing
`tr` is not decoration**: PROTOCOL §4.1 forbids an entry body from carrying a
line that begins `## [J-dv_lead-NNNN]` at column 0, code fence or not, because
the structural parsers count such lines as entry headers — so the command that
reports the chain's tail must not print it in header form. I hit exactly that on
this entry's first draft and repaired it here rather than shipping a file whose
own evidence block would have been counted as a third entry.

**3. The one-entry rotation precedent, measured at the three creating commits:**

```
$ for v in v06 v07 v08; do
    f=agents/journals/claude_dv_lead_agent.$v.md
    c=$(git log --diff-filter=A --format=%h -- $f | tail -1)
    echo "$v added at $c"; git show $c:$f | grep -c '^## \[J-'
  done
v06 added at 70cf13c
1
v07 added at 94f0b34
1
v08 added at b80fef1
1
```

**Three for three**: every prior volume of this chain opened with exactly one
entry in its creating commit, which is the landing shape act one reproduces.

**4. The threshold arithmetic** (`S` = 262,144, `H` = 524,288 — ADR-0017 §5.1):
`353,776 − 262,144 = 91,632` over `S`; `524,288 − 353,776 = 170,512` under `H`;
`353,776 ÷ 11 = 32,161` bytes an entry, so `H` was **5.3 entries** away.

**5. The precheck**, as run — reproduced under Trigger, `git status --short`
empty and HEAD `9535979e6c388183bcb04d1c6c661e8c9dc727e9`.

**6. Independence, and one thing in the working tree that is not mine.**
`git status --short` at the end of act one lists **two** entries: `??
agents/journals/claude_dv_lead_agent.v09.md`, which is this file, and `??
test/xgmii_tx_64/`, which is the **declared sibling's uncommitted work** on
`WO-0080`. The second is not mine, was not read, was not touched, and **must not
be staged in either of this round's commits** — and the hazard is worth naming
because it is not caught by path isolation: `test/**` is inside *my* write scope
(PROTOCOL §6), so an `R7` check would pass a commit that swept those files in
under `Agent: dv_lead`. What catches it is `R4`, the files-list set-equality, and
only because both of my entries declare `- (none)`. **A `git add -A` on this tree
produces a commit that is wrong in a way one of the two mechanical checks cannot
see**, which is exactly the case for staging by explicit path. **No `git add`, no
`git commit`, no `git push`, no git write of any kind by me.**

### Outcome

**DoD met for a rotation round.** `v09` exists at the path ADR-0017 §4.1
prescribes, with the §4.3 header carrying five fields of which the three
verifiable ones were computed rather than copied; `v08` is untouched and stays
frozen; entry ids continue across the volume boundary; the carry-forward set and
the harvest-span position are restated whole so this volume answers *"what is
open?"* without opening the previous one.

**The staging boundary for the orchestrator, stated exactly** (Reasoning 4):
**commit one** is this file truncated immediately after the `- (none)` line that
closes this entry's `Files-in-this-commit` section — one `## [J-` header in the
staged bytes, `Journal-Only: true`, files list `- (none)`. **Commit two** is the
whole file, which is a pure EOF-append to the first. Two commits, two entries,
in that order, and **exactly one path staged in each** (Evidence 6: the tree also
carries the declared sibling's untracked `test/xgmii_tx_64/`, which belongs to
neither commit).

**Handoff**: none. No packet is written in act one; the write set is this journal
file alone.

### Open-questions

1. **The nine carry-forwards restated at Reasoning 5** are the open set at this
   moment, unchanged by this entry — which changes nothing in the world except
   which file my next entry is appended to.
2. **Act two of this round is `J-dv_lead-0173`**, the countersignature the
   `CSG-3` ruling (`J-architect_docs_lead-0039`, `ee47eee`) owes me and that my
   own `J-dv_lead-0171` requested. Its REQ-901 diff is **normative and NOT IN
   FORCE until my countersignature is transcribed**, so nothing else in this
   round is blocking and that one item is.
3. **`v09`'s own rotation is not near.** At the recomputed 32,161 bytes an entry,
   `S` is about eight entries out and `H` about sixteen. Recorded so the next
   measurement has a prediction to falsify rather than a memory to consult.

### Files-in-this-commit
- (none)
