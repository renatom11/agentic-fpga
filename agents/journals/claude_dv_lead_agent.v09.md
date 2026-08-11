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

## [J-dv_lead-0173] 2026-08-11T23:55Z | task:none | The countersignature my own finding asked for, paid at the source: the equivalence derived by cases and then enumerated over 2.4 million traces built a different way from the ruling's, the guard measured to be the rule rather than wider than it — and the fourth clause signed with its stated ground convicted, which convicts a row of my own in the same act

### Trigger

Orchestrator dispatch, **act two of this round**, same declared sibling
(`tb_writer` on `WO-0080`, write set disjoint from mine and untouched here). The
commission is the countersignature the `CSG-3` ruling owes me. That ruling landed
at `ee47eee` (`J-architect_docs_lead-0039`) while my previous round was being
written, and its own §13 row states that the REQ-901 diff is **normative and NOT
IN FORCE until dv_lead's countersignature is transcribed** — so until this entry
is committed and its rows transcribed, the restriction as countersigned at
`J-dv_lead-0170` governs and the gap `CSG-3` found stays open on paper. My own
`J-dv_lead-0171` Open-question 3 requested this round in terms.

Three items are in front of me, and they are not the same act:

1. **The `CSG-3` cure** — my finding, SUSTAINED, cured by **neither** of the two
   cures I offered. Countersignature owed and the diff not in force without it.
2. **The `AP-M04-2` cure** at SPEC-M04 §7 — my finding, SUSTAINED. The ruling
   states no countersignature is owed (my own `J-dv_lead-0170` §(a) carved that
   sentence out by name and §(b) requested the diff) and flags the **added**
   prohibition as contestable as a fresh finding. My act there is to read it and
   say whether I contest.
3. **§0.6's fourth reference-word clause** — carry-forward `C-5`'s closure. Its
   §13 row says a countersignature **is** owed on it *"as on every §0.6 diff"*,
   which I verified at the row rather than taking from the dispatch.

**Head check, before reading the diff and before any write**: `git rev-parse
HEAD` → `9535979e6c388183bcb04d1c6c661e8c9dc727e9`, byte-equal to the spawn-head;
`git status --short` at the start of the round returned zero lines; branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`.

**HEAD MOVED AGAIN MID-ROUND, and the reconciliation is recorded rather than
absorbed — the second round running.** On my final state check, after both
entries were drafted, `git rev-parse HEAD` returned **`48077aa`**. It is the
**orchestrator's** board round, touching `agents/journals/claude_orchestrator_agent.v02.md`
and `tasks/BOARD.md` — two paths, neither mine, neither a specification, neither
a test. What I did, in order, before finalising a line:

1. **Diffed the move against every path this entry measures**: `git diff --stat
   9535979..HEAD -- docs/specs/ test/ agents/handoffs/ agents/journals/claude_dv_lead_agent.v08.md`
   is **empty**. So REQ-901, §0.6, §12, SPEC-M04, both producers, the stimulus
   corpus and the vendored directory are byte-identical to what I read, and
   **every measurement below stands at `48077aa` for the reason rather than by
   luck** — the reason being that the commit touched none of them.
2. **Re-computed the chain values act one's header carries** at the new HEAD:
   sha256 `cde9c506…3723` and 353,776 bytes, **both unchanged**, because `v08` is
   not among the two paths that moved. Act one's header is therefore correct
   against the new parent as well, which is the check the orchestrator repeats at
   landing.
3. **Left the countersignature SHA as `9535979`**: that is the commit at which the
   verification was actually performed, and a signature that cites the tree it was
   made against is worth more than one that cites the tree it happened to land on.
   The rows say so explicitly.

**And a second thing in the tree that is not a commit**: `git status --short`
lists `?? test/xgmii_tx_64/` — the **declared sibling's uncommitted work** on
`WO-0080`. Not read, not touched, not staged; act one's Evidence 6 states why the
distinction has to be made by hand here rather than left to `R7`.

**Order of work, stated because it is what makes agreement mean agreement.**
Every derivation, every enumeration and every measurement below was done from the
**diff and the specification text at HEAD**; `J-architect_docs_lead-0039` was read
**last**, after all of it, exactly as `J-dv_lead-0170` did. Two of the results
below agree with the ruling's reasoning sentence for sentence and one convicts
it; neither would mean anything if I had read the reasoning first.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any
  write.
- **The diff under review**: `git diff 9d68d10..ee47eee -- docs/specs/requirements.md
  docs/specs/modules/xgmii_tx_64.md`, read hunk by hunk, then each repaired
  passage read **in place at HEAD** rather than only as a hunk.
- **`docs/specs/requirements.md` at HEAD**: **REQ-901 entire** (the eight declared
  classes, the admission span, the guard-width sentence, restriction parts (i) and
  (ii) as repaired, the struck lift with its preserved quotation, the record-only
  licence, the transmit-boundary silence paragraph, the cost-of-an-excluded-class
  paragraph); **REQ-108 and REQ-110's verification columns** as repaired;
  **§0.6 entire** — the window sentence, the reference-word paragraph's **four**
  clauses, the no-octet-class note and the *"a bound, never a licence"* note;
  §0.5's L/ΔC definitions; **§12's strobe appendix, all twenty-one rows, read one
  by one**; §13's three new rows, read in full.
- **`docs/specs/modules/xgmii_tx_64.md` at HEAD**: §7's latency bullet entire
  (the two-constant table, the h = 0 paragraph, the derived-both-ways paragraph
  and **the new `AP-M04-2` paragraph**), §7's throughput and `tx_tready` bullets
  and the C-16 consequences, **§9 entire** (the condition row, the repaired
  *"Strobe cycle, pinned"* paragraph, the no-FCS paragraph, the co-occurrence
  bullets), §11.3 as closed, §13's new row.
- **My own instruments**: `test/attack_plans/AP-xgmii_tx_64.md` §4.G rows
  `M04-G1` … `M04-G8` **in full**, §6's REQ-016 and REQ-206 coverage rows, §7
  items T-2 and T-5, §8 item 3; `agents/handoffs/WO-0080_tb-m04-first-bench.md`
  §9.4(1) and bounce `BM6`.
- **The two co-simulation producers, as artefacts of my own line** —
  `test/cosim/ours_run.ml` (`:230`, the admission arm `:245-262`, the span-closing
  line `:273`) and `test/cosim/tb_xgmii_rx_64.v` (`:260`, `:529-533`, `:575-576`),
  read to **measure the guards against the repaired rule**, which is the
  measurement REQ-901's own new text assigns to me; and
  `test/cosim/stimulus_gen.ml`, read to measure whether any committed stimulus
  moves.
- `git ls-files test/third_party/verilog-ethernet/` — the vendoring premise of the
  transmit-boundary paragraph, measured rather than accepted.
- **My own prior entries** `J-dv_lead-0170` (§(e)'s countersignature, §(f)'s
  `CSG-3` filing and self-binding, §(h)'s refusals) and `J-dv_lead-0171`.
- `agents/journals/claude_architect_docs_lead_agent.v03.md`,
  `J-architect_docs_lead-0039` entire — **read last**.
- **No RTL.** `libs/**`, `top/**`, `rtl_snapshots/**` were not opened, and
  `test/third_party/` was listed but not read. **Every reference-side claim below
  is carried from the `(g)`/`(h)` class text I derived and countersigned at
  `J-dv_lead-0162`** — a retrospective reference to a derivation already in
  history, labelled as carried at the point of use, not a new static read. **No
  Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

---

#### (a) The `CSG-3` cure. **COUNTERSIGNED**, with one reading fixed and one correction of my own record.

**1. What the cure is, restated from the text so the signature has a subject.**
Part (i) drops *"that has already delivered an octet"*, so it bars a start
character inside **any** open frame. Part (ii) generalises from the error-character
closure to **every closure that is not the frame's terminate character** —
REQ-105's error character, REQ-108's truncation, REQ-009's `clear` — on the stated
ground that the terminate character is the only closure this document can rely on
the reference to have taken by then, and that for `clear` the ground is the
**absence of a derivation** rather than a claim about the reference. The class-(f)
lift is **struck with its quotation preserved**. The licence's *"either restricted
situation"* becomes *"any situation those parts restrict"*. And the whole is given
a closed form: **on a run that compares, every start character SHALL follow a
terminate character**, the trace's first excepted.

**Neither of my two offered cures was taken, and the ruling is right to refuse
them.** I offered (1) extending part (ii) to the truncation closure in its own
shape, or (2) narrowing the lift. Cure (1) would have left `clear` — the fifth
closure — in exactly the position truncation had been in, which is to say the
finding would have been re-filed at the next closure someone thought about; I
named `clear` in my own filing as having *"no instance in the co-simulation lane
today"* and treated that as a reason not to press it, which was the same
enumerate-the-cases-you-can-see error one level down. Cure (2) would have left the
restriction short of the rule. **The mechanism that produced the gap was a
restriction enumerated case by case against a span enumerated closure by closure**,
and only stating the restriction over the span removes it. I record that my own
cures were the narrower ones because a countersigner who does not say when the
ruling improved on his filing is not adding a key.

**2. The equivalence, derived by cases before it was enumerated.** The ruling
asserts that the one-sentence form is equivalent to parts (i)+(ii). I derived it
first, because an enumeration that agrees with an assertion I have not understood
is a coincidence I would have no way to size.

Structure of any trace, from the span alone: start characters `S₁ < S₂ < … < Sₙ`;
the frame opened by `Sₖ` closes at `cₖ`, the **earliest** of the five closure
events, with `cₖ ≤ Sₖ₊₁`. Take any `Sₖ₊₁`. Exactly three situations exhaust it:

- **(α) `cₖ = Sₖ₊₁`** — the frame was still open and this start character is what
  closed it. **Part (i) bars it.** And no terminate character lies in
  `(Sₖ, Sₖ₊₁)`: one there would have been an *earlier* closure, contradicting
  `cₖ = Sₖ₊₁`. **So the one-sentence form bars it too.**
- **(β) `cₖ` is a terminate character**, `cₖ < Sₖ₊₁`. Part (i) does not bar (no
  frame is open). Part (ii) does not bar either: any earlier non-terminate closure
  `c_j` has the terminate character `cₖ` lying in `(c_j, Sₖ₊₁)`, which closes
  every interval part (ii) could open. **And the one-sentence form does not bar**,
  because `cₖ ∈ (Sₖ, Sₖ₊₁)` is a terminate character.
- **(γ) `cₖ ∈ {error, truncation, clear}`**, `cₖ < Sₖ₊₁`. Part (i) does not bar.
  Part (ii) bars **iff** no terminate character lies in `(cₖ, Sₖ₊₁)`. And no
  terminate character lies in `(Sₖ, cₖ)` either — one there would have been the
  earliest closure and we would be in (β). So *"no terminate in `(cₖ, Sₖ₊₁)`"* is
  the same condition as *"no terminate in `(Sₖ, Sₖ₊₁)`"*, **which is exactly the
  one-sentence form's bar.**

`S₁` is excepted by the sentence and is legal under both parts (no frame is open
and no closure has occurred). **The three cases exhaust the trace and agree in
each, so the equivalence is a theorem over the span's own structure and not a
statistical result.**

**And the direction claim — legal→barred and never the reverse — is a containment
theorem, not a count.** Dropping *"that has already delivered an octet"* only
**widens** part (i); `{error} ⊂ {error, truncation, clear}` only **widens** part
(ii); and striking a lift only **removes exemptions**. Every one of the three
edits moves the barred set outward, so `NEW ⊇ OLD` by construction: **the repair
cannot admit anything the old rule refused, whatever any enumeration says.** That
is the property a stimulus restriction must have, and it is worth having as a
proof rather than as a zero in a report, because a zero is evidence about the
traces that were enumerated and the proof is about all of them.

**3. The bounded independent check, and it is built a different way from the
ruling's on purpose.** The ruling enumerates over a **six**-symbol alphabet
`SToEXC` in which REQ-108's truncation is its own **symbol** `X`. Mine uses
**five** symbols and models truncation as what the span says it is — an **octet
count** passing a threshold, so the truncation event is *derived* from the trace
rather than placed in it, and the threshold is swept (1 and 2) to show the
derivation and not the constant is doing the work. Traces of length ≤ 9:
**2,441,405 traces, 4,272,461 start characters judged individually** (a per-start
comparison, not a per-trace one, which is the stronger claim). Results, at both
thresholds: **zero mismatches** between parts (i)+(ii) and the one-sentence form;
**1,019,340** start-character verdicts moved by the repair and **not one** in the
barred→legal direction. And the three named geometries, judged individually
(Evidence 2):

| geometry | OLD | NEW | one-sentence |
|---|---|---|---|
| oversize with **no** terminate, then a lane-0 start, then a normal frame (`CSG-3`'s own) | legal | **barred** | **barred** |
| REQ-108's own verification geometry — the same with the oversize frame's terminate present | legal | legal | legal |
| a start character inside an open frame that has delivered **zero** octets | legal | **barred** | **barred** |

**The middle row is the one the cost of this cure turns on** and it is the reason
I can countersign without a scope objection: the stimulus REQ-108's verification
column was written around is untouched, so the repair costs the requirement it
most nearly reaches exactly nothing.

**4. The reading this countersignature fixes, and it is load-bearing rather than
pedantic.** Part (ii) bars a start character *"between a closure … and that
frame's following terminate character"*. Where the closed frame has **no**
following terminate character anywhere in the trace, two readings are available:
**(A)** the interval runs to the end of the trace, or **(B)** there is no interval
and nothing is barred. I ran both. Under (A) the equivalence holds as above. Under
**(B) the two formulations disagree on 349,617 traces of length ≤ 9** at the first
swept threshold and on 339,770 at the second (409,229 and 395,159 start characters
respectively), **always in one direction**:
the one-sentence form bars and reading (B) does not, on exactly the traces whose
non-terminate closure is never followed by any terminate character — the smallest
instance being `S /E/ S`.

Three consequences, in the order that matters:

- **The ruling's zero-mismatch result identifies its reading.** A trace set that
  contains `SES` cannot report zero mismatches under (B), so (A) is what was
  checked. **(A) is therefore what I countersign**, and I say so in the row so the
  reading is on the record rather than inferable from a count.
- **Nothing rests on the choice for a guard**, because the one-sentence form is
  the **stricter** of the two everywhere they differ: a producer measured against
  the sentence conforms to the restriction under either reading. This is the
  property that makes the closed form worth having, and it is a stronger reason
  for it than the readability one the ruling gives.
- **The divergence class is not exotic.** It is a trace that ends with an aborted
  or truncated frame followed by a frame whose terminate character never comes —
  which is `CSG-3`'s swallowing hazard in its worst form, the one where no later
  terminate rescues the sequence. If the architect intends reading (B), that is a
  fresh finding and takes a narrow round; I do not believe it does, and I sign (A).

**5. A correction of my own record — the struck lift was inert, and my filing said
otherwise.** `J-dv_lead-0170` §(f) reads: *"Neither bars a start character after
REQ-108's truncation closure — and the diff's own lift clause goes further"*. The
first half is right and is the finding. **The second half overstates the lift's
effect, and the same enumeration measures it: under the reading that ties class
(f) to a frame our side truncates, the lift never changes a verdict in 2,091,881
trace instances — not once.** Every start character it purported to lift was
already unbarred by parts (i) and (ii) as they then stood, because part (i)
needs an **open** frame and a truncated frame is closed, and part (ii) named only
the error closure. So the lift's effect was **declaratory**: it advertised a
licence for stimulus the parts already left legal.

Two things follow and I want both on the record. **The finding's conclusion is
untouched** — the gap was in the parts, which is exactly where the cure went.
**And the strike is cheaper than it looks**: striking a clause that selects
nothing removes no stimulus at all, which is a better argument for striking than
the one I could have made from my own filing. Bound, stated because a bounded
check that does not state its bound is a claim: this measures the lift under the
reading *"a frame our side truncated"*; a whole-trace reading (*"a frame whose
on-wire extent exceeds 1518 whatever our side did with it"*) is **not** tested
here, and under it the lift could reach a start character inside a
still-open over-long frame.

**6. The release claim, checked against my own binding's text — and it releases
into a stricter position than the one it held.** My binding, quoted from
`J-dv_lead-0170` §(f): *"I will not narrow either guard for the truncation-closure
geometry until `CSG-3` is ruled, whatever a later work order's convenience — the
wide guard is the compensating control while the rule's coverage is short by one
closure."* It carries a condition (`CSG-3` unruled) and a ground (coverage short).
**Both are discharged**: the ruling landed, and the restriction is now stated over
the span. So the binding releases **by its own terms**, and — this is the part
worth stating — it was never an undertaking to narrow anything; it was an
undertaking **not** to. Its release removes a prohibition; it commands nothing.

**And the measurement REQ-901's own new text assigns to me, made rather than
deferred** (*"Whether either producer's guard already implements exactly that is a
measurement on `test/**` — dv_lead's to make"*). Both guards set an admission flag
at a start character in XGMII lane 0 or 4, **refuse** a start character while it is
set, and clear it **only** on a terminate character in the same input word,
checked **after** the start arm (`ours_run.ml:230`, `:245-262`, `:273`;
`tb_xgmii_rx_64.v:260`, `:529-533`, `:575-576`). Read as a predicate: *a start
character is refused iff a start character has been admitted with no terminate
character since* — which is **exactly** *"every start character follows a terminate
character"*, the trace's first excepted because the flag initialises false.

The residual width is **one geometry and I name it**: a terminate character and a
later start character **in the same input word**, which the guards refuse (the
start arm runs first) and the rule permits. §0.3's minimum inter-frame gap is 12
octets — more than one 8-lane word — so no conformant stimulus produces it, and
both producers' own comments already say so at the site. A second candidate is
not one: a start character outside lanes 0 and 4 is not recognised by either
guard, and REQ-101/REQ-102 put every start character in lane 0 or 4.

**So: on stimulus conforming to §0.3's gap and the start-lane convention, `FI-4`
and `FI-6` implement the repaired rule exactly — not wider, not narrower.** Three
consequences: **nothing needs narrowing to conform**, which is what the ruling
claims; **for a run that compares nothing MAY be narrowed either**, because the
guards' refusal set now coincides with the rule's bar set and narrowing would
admit stimulus the rule bars — the undertaking has become the rule's own
requirement, which is the strictly stronger position; and **narrowing remains a
live question only for a record-only run**, where `J-dv_lead-0170` §(e)(5)
governs (*"It is not self-executing. It does not lift `FI-4` or `FI-6`"*), the
lane is a separate authorised act with its own review, and the machinery does not
exist.

**7. Nothing committed moves, measured rather than assumed.** `test/cosim/stimulus_gen.ml`
carries five builders, all constructed from `Dv_xgmii.Arrival.create` over whole
frames with an explicit inter-frame gap, and a search for an error character, an
oversize frame or a runt returns **nothing** (Evidence 4). So every start
character in the committed corpus already follows a terminate character, and no
committed stimulus, expectation or report changes legality under the widened
restriction. **The diff touches no byte of `test/**`** either way, which is the
order `WO-0078` §6.3 demands and which I re-checked.

**Verdict on item 1: COUNTERSIGNED** — the widened parts (i) and (ii), the struck
lift, the repaired licence, the one-sentence form, and REQ-108's and REQ-110's
brought-into-agreement verification columns. **IN FORCE on transcription**, with
the reading of §4 fixed on the record and no finding filed against any of it.

---

#### (b) The `AP-M04-2` cure and its added prohibition. **NOT CONTESTED.**

The survival claim is struck — the sentence my own §(a) countersignature carved
out by name — and §7 now carries in its place: **"A bench SHALL NOT build a
REQ-016 idle-injection wrapper at this module's source interface"**, with the
gloss *"the first injected cycle **on a required cycle** is an underflow, and a
monitor measuring L across it measures a frame the injection destroyed."*

**The contest that was available and why I do not take it.** A bench that drives
REQ-206 **must** withhold a source word on a required cycle — that is the
stimulus, and it is the whole of family G in my own attack plan (`M04-G1`, `G3`,
`G5` withhold; `M04-G4` withholds at a cycle that is *not* required and asserts
silence). A literal reading of *"a bench shall not withhold a word at this port"*
would bar the module's only REQ-206 coverage. **Three things refute that reading,
and any one of them is enough**: the sentence's **subject** is a *REQ-016
idle-injection wrapper*, a named construct and not the act of presenting
`tvalid` = 0; its **own gloss** keys the hazard to a *required* cycle, which is
what distinguishes `M04-G4` from `M04-G1` and is the distinction the C-16 diff
was written to make; and **§9's own condition row and §10's REQ-206 hook
commission the withheld-word stimulus**, so the wide reading would put this
specification in contradiction with itself at two sites in the same document.

**One asymmetry I record rather than leave to be found.** My own `WO-0080` bounce
`BM6` is **wider** than the specification's prohibition — it bars *"the source
withholds a word mid-frame, **or** an idle-injection wrapper is built"* — and
deliberately so, because that round commissions no family-G row and a first bench
that manufactures REQ-206 aborts while claiming conformance coverage is the
failure I said I would most regret finding late. A round-scoped bounce wider than
a standing prohibition is not a conflict. **It would become one if `BM6` were ever
quoted as a standing rule**, and it is not: family G's round lifts it by
commissioning the stimulus, and the packet says so.

**Verdict on item 2: NOT CONTESTED.** No countersignature is owed, none is
offered, and **no §13 row is requested** — minting a row nobody asked for is the
scope-widening I refused in the last round. The non-contest is recorded here and
is citable as this entry §(b); if the architect wants it visible at SPEC-M04 §13,
a later round may cite it, which is its call and not mine.

---

#### (c) §0.6's fourth reference-word clause. **COUNTERSIGNED** on the rule, with `FINDING ABS-1` against its stated ground — and the same error convicted in my own instrument.

**First, the owed-ness, verified at the row and not taken from the dispatch.**
requirements.md §13's row for this clause reads *"**dv_lead's countersignature is
owed** on it as on every §0.6 diff, and the clause is in force meanwhile, nothing
resting on it that the module pin did not already decide."* So a signature is owed
and the clause is not held out of force by its absence — which is the same
disposition as `AP-M04-1`'s and is the right one for a clause nothing rests on.

**What I verified, three checks, each made before reading the ruling's own
reasoning:**

1. **The instance count.** The clause says the absence class *"in §12's strobe
   appendix is REQ-206's `error_underflow` and nothing else"*. I read all
   **twenty-one** rows of §12 rather than sampling. Every other condition is
   decided **on** a word: the two that come nearest are `error_ip_truncated`
   (*"frame ended before IPv4 total length was satisfied"*) and
   `error_tx_length_mismatch` (*"application supplied fewer … octets than
   declared"*), and **both are decided on the early `tlast` word** — a word that
   arrives — which is precisely why neither is an absence. **One instance,
   confirmed.**
2. **The ΔC clause.** §0.5 defines **L** in octet times and **ΔC** in cycles, so
   §0.6's *"the module's latency in cycles (§0.5)"* can only be ΔC, which SPEC-M04
   §7 pins at **2**; REQ-210's 1-cycle event delay is REQ-210's and not §0.5's,
   and a reader taking it computes a ceiling one cycle short. **Correct, and the
   ambiguity it forecloses is one my own `AP-M04-1` filing created** — before that
   repair M04 had one figure and now it has two, so the clause is repairing a
   collision my finding caused in a document my finding did not touch.
3. **The near-edge claim.** §9 pins the pulse on the cycle the word was required
   and not presented; §0.6's floor is *"not earlier than the cycle on which its
   condition first becomes decidable"* — the same cycle. So floor, pin and
   reference word coincide and the ceiling sits ΔC beyond, which is what *"the
   window carries no independent information"* means, and it is the same
   disposition §0.6's own no-octet note gives, read with the *"a bound, never a
   licence"* note that says the pin governs inside the window. **Correct.**

**`FINDING ABS-1` (MINOR, against the stated ground and not against the rule; two
sites, one of them mine).** The clause's ground reads:

> the three clauses above name no word: the offending frame is cut short by an
> absence rather than closed by an event on the stream, so the octet the first
> clause measures from is one that never arrives, and the third clause does not
> reach it either because the frame did receive octets.

**Those two halves cannot both be true.** Since **2026-08-04** (`0caf023`, the
ruling that settled this very paragraph) the first clause does **not** measure
from the frame's *final* octet; it names *"the last octet that frame **received
while it was open**"*. An underflowed frame **has** received octets — my own row
`M04-G5` asserts that source word 0's octets reach the wire on an underflow at
`C + 1`, because REQ-207 forbids dropping an accepted word — and the clause's own
last half says so. **So the first clause names a word here: the source word
carrying the last octet accepted before the underflow.**

**What the clause therefore is, and it is not what it says.** Not a hole-filler
but an **override**: it moves the reference word from the last accepted source
word to the required cycle — one cycle later, and mid-frame it is always exactly
one, because §7's throughput bullet requires one XGMII word emitted every cycle
and pins `tx_tready` = 0 only on the FCS and terminate words, both **after** the
`tlast` acceptance, so acceptance in the frame body is contiguous and the first
withheld cycle is the next one.

**And nothing turns on it, which I checked rather than assumed.** With `A` the
cycle of the last accepted source word: the pin is at `A + 1`; the first clause's
ceiling is `A + ΔC = A + 2`; the fourth clause's is `A + 1 + ΔC = A + 3`. **The
pin is inside both**, and the fourth clause's window strictly contains the first
clause's, so the change can only **loosen** a bound that is already redundant
against §9's exact pin. **No conformant design changes and no committed
instrument changes meaning** — M04 has no bench — so the row's **editorial**
classification survives its ground being wrong, which is why this is MINOR and
why the clause stays in force.

**The cure is one sentence**: replace the *"name no word"* premise with what the
clause actually does — the first clause would name the last source word accepted,
and this clause moves the reference to the condition's own decidability cycle so
that the window's floor and its reference word are the same event. **Route**:
architect_docs_lead, spec-diff request via the orchestrator. **Not decided here**,
on the discipline `AP-M04-1`, `AP-M04-2` and `CSG-3` all used.

**And the same misreading is in my own instrument, which is why this is a finding
and not an objection.** `AP-xgmii_tx_64` row `M04-G7` (NO-ASSERT) states:

> Its bound is *"the module's latency in cycles after the input word carrying the
> last octet of the offending frame"*, and an underflowed frame **never receives
> that octet** — the window has no reference word, so a check against it is not
> loose, it is undefined.

**Same error, same phrase, mine.** And it is not stale: I wrote it on 2026-08-11,
**a week after** the gloss that contradicts it landed, which makes it worse than
the `M14-F1` class — those rows were falsified by a later ruling, this one was
wrong when written, because I read §0.6's ceiling **sentence** and not the
four-clause paragraph that defines its terms. **The row's status and conclusion do
not move**: NO-ASSERT is right, and it is now right on the fourth clause's own
statement that the window carries no independent information here — a better
ground than the one I gave it. Its **ground** is repaired at the round that next
opens `test/attack_plans/**`, which now owes **five** editorial repairs to one
document.

**Verdict on item 3: COUNTERSIGNED** — the reference word for an absence-reported
condition, the ΔC-and-never-the-event-delay clause, the no-independent-information
statement, and the one-instance scope. **`FINDING ABS-1` filed without holding the
clause out of force**, against one sentence of its ground and one row of my own
plan.

---

#### (d) The two rows on which no signature is owed, read anyway

- **SPEC-M04 §13's `AP-M04-2` row** states no countersignature is owed and gives
  the reason (my own §(a) carved the sentence out by name, my §(b) requested the
  diff). I agree, and §(b) above is my non-contest of the added prohibition.
- **requirements.md §13's transmit-boundary row** is editorial and answers my own
  `AP-xgmii_tx_64` §8 item 2 **in the negative, with a closing event named**: a
  divergence class at the transmit boundary is not writable in that document
  today, because the four classes stated with a mechanism each cite the vendored
  *receive* counterpart at a pin and the transmit counterpart is not vendored. **I
  verified the premise rather than accepting it**: `git ls-files
  test/third_party/verilog-ethernet/` returns exactly four paths —
  `COPYING`, `PROVENANCE.md`, `axis_xgmii_rx_64.v`, `lfsr.v` — and no transmit
  module (Evidence 5). **This moves one of my carry-forwards and I state the
  move**: what act one restated as *"REQ-901's divergence classes at the transmit
  boundary need a work order"* is now answered — the answerable event is a
  **vendoring commit** governed by ADR-0015 D2 and `PROVENANCE.md`, not a spec
  round, and until it lands **no sign-off packet may cite a transmit-boundary
  co-simulation result as an anchor for any requirement**. Charter §3 makes
  differential co-sim a precondition of Phase 1 MAC sign-off, so that is a **gate
  condition on `SO-xgmii_tx_64`** and it is now stated in the requirement itself
  rather than only in my plan. Not contested; no signature owed; the sequencing
  (c) → (a) → (b) of `J-dv_lead-0171` Open-question 5 is unchanged and its third
  member is now answered rather than open.

---

#### (e) What I refused

- **I refused to widen my write set.** This is a countersignature round: the
  signatures live in this entry, transcription into `docs/specs/**` is the
  orchestrator's clerical act (PROTOCOL §6 and the 2026-08-03 / 2026-08-10 /
  2026-08-11 precedents), and **not one byte of `test/**` or `agents/handoffs/**`
  is touched** — including row `M04-G7`, whose ground I have just convicted and
  could have repaired in the same tree, and including the four repairs already
  owed to that document.
- **I refused to decide `FINDING ABS-1`.** It is mine; the §0.6 half is the
  architect's to rule on. A countersigner who rules on his own findings is not a
  second key, which is the same sentence I wrote when I refused to decide
  `AP-M04-2` and `CSG-3`.
- **I refused to narrow `FI-4` or `FI-6`.** The binding that forbade it has
  released, and I still do not narrow them: for a comparing run the rule now
  forbids it, and for a record-only run the lane does not exist and the act is a
  separate authorisation. **A released undertaking is not an instruction.**
- **I refused to read RTL or reference source.** The reference-side claim inside
  §(a) is carried from my own countersigned derivation at `J-dv_lead-0162` and is
  labelled as carried at the point of use.
- **I refused to reproduce the ruling's own counts.** 2,015,538 and 425,673 are
  results of an enumeration over a different alphabet and a different length
  bound; the only check I can make of the figures themselves is that
  **2,015,538 is exactly `Σ 6ⁿ` for n = 1 … 8**, which is the size of the trace
  space the ruling states it swept, so the count is at least consistent with its
  own declared domain (Evidence 3). The **claims** are what I verified, twice and
  independently; the counts are the ruling's.
- **Harvest: none owed, and I say so rather than leave silence.** PROTOCOL §7 and
  charter §8 attach the note to every module sign-off and every phase gate; this
  is neither. The span opened at `J-dv_lead-0168` and **this entry joins it**, so
  it now runs `-0168` … `-0173` across two volumes (act one, Reasoning 6), and all
  six are mined at the next `SO-` or gate.

### Actions

1. Read the charter and PROTOCOL in full; ran the head check; read the diff hunk
   by hunk and then every repaired passage in place at HEAD, including all three
   new §13 rows.
2. **Derived the equivalence by cases** (§(a)2) and **wrote and ran the
   enumeration and the two probes** (Evidence 2, 3) — all of it **before** reading
   `J-architect_docs_lead-0039`, so that agreement is agreement and the one
   disagreement is not a misreading of the ruling's own words.
3. **Measured both admission guards at HEAD** against the repaired rule, and
   measured the committed stimulus corpus for anything the widened restriction
   reaches (Evidence 4).
4. Read §12's twenty-one strobe rows one by one; derived the two window ceilings
   and compared them against §9's pin (§(c)).
5. Read `AP-xgmii_tx_64` family G in full and `WO-0080` §9.4(1)/`BM6`, to test the
   added prohibition against the stimulus my own plan commissions (§(b)).
6. Wrote this entry, carrying **two countersignatures, one non-contest, one new
   finding and one correction of my own record**. **No `git add`, no `git
   commit`, no `git push`, no git write of any kind.**

### Evidence

Reproducible from a checkout at this commit. The enumeration scripts read **no
repository file** — the rules are transcribed into them from REQ-901's own text —
so they re-run anywhere. `dune` is absent from this container (**ADR-0005**,
re-checked: `which dune` returns nothing) and **no OCaml lands in this round**.

**1. The head check and the mid-round move** (Trigger):

```
$ git rev-parse HEAD                       # at spawn, before reading anything
9535979e6c388183bcb04d1c6c661e8c9dc727e9
$ git rev-parse HEAD                       # at the final state check
48077aaf87784235bd869ae553e698e6af0d7247   # NOT the spawn-head
$ git log --oneline 9535979..HEAD
48077aa The board learns the loop runs whole on module two: …
$ git diff --stat 9535979..HEAD
 agents/journals/claude_orchestrator_agent.v02.md | 21 +++++++++++++++++++++
 tasks/BOARD.md                                   |  2 ++
$ git diff --stat 9535979..HEAD -- docs/specs/ test/ agents/handoffs/ \
      agents/journals/claude_dv_lead_agent.v08.md
                                           (empty — nothing this round measures moved)
$ git show HEAD:agents/journals/claude_dv_lead_agent.v08.md | sha256sum
cde9c506b85c56630dd68eac6f6bc51b3108033d222fb5267d9671d310463723  -
$ git show HEAD:agents/journals/claude_dv_lead_agent.v08.md | wc -c
353776
$ git status --short
?? agents/journals/claude_dv_lead_agent.v09.md
?? test/xgmii_tx_64/                       # the declared sibling's, not mine
```

Act one's chain header is **unchanged against the new parent**, and every
specification measurement below is unaffected **because** the two paths that
moved are not among them.

**2. The equivalence enumeration** (durable logic below; the run used
`…/scratchpad/csg3_equiv.py` and `…/scratchpad/csg3_probe.py`, **ephemeral**
paths stated as such per ADR-0003/F5):

```python
# alphabet: S start, T terminate, E error character, C clear, o octet.
# REQ-108's truncation is NOT a symbol: the open frame closes by truncation on
# the octet whose arrival takes its received count past THRESH (swept 1 and 2).
# span: open from S until the earliest of T / E / a later S / truncation / C.
# NEW (i) no S inside an open frame
#     (ii) no S between a non-terminate closure and that frame's following T,
#          the interval running to end-of-trace when no T follows  [reading A]
# OLD (i) no S inside an open frame THAT HAS DELIVERED AN OCTET
#     (ii) no S after an /E/ closure before that frame's following T; + class-(f) lift
# SENTENCE  every S follows a T, the trace's first excepted
for L in range(1, 10):
    for t in product("STECo", repeat=L):
        assert barred_new(t) == barred_sentence(t)        # per START CHARACTER
        assert not (barred_old(t) - barred_new(t))        # never admits more
```

Observed (both thresholds, identical verdicts):

```text
THRESH=1  maxlen=9
  traces enumerated              : 2441405
  start characters judged        : 4272461
  parts(i)+(ii) vs one-sentence  : AGREE on every start character
  moved legal->barred            : 1019340
  moved barred->legal            : NONE
THRESH=2  maxlen=9   traces 2441405 | starts 4272461 | AGREE | 990422 | NONE
```

Named geometries, judged individually (`SooSoT`, `SooTSoT`, `SST` in this
alphabet — the second `o` is what trips truncation at THRESH = 1):

```text
SooSoT   NEW bars [3]  one-sentence bars [3]  AGREE   OLD bars []     <- CSG-3's geometry
SooTSoT  NEW bars []   one-sentence bars []   AGREE   OLD bars []     <- REQ-108's verification geometry
SST      NEW bars [1]  one-sentence bars [1]  AGREE   OLD bars []     <- the zero-delivered start
SoSoT    NEW bars [2]  one-sentence bars [2]  AGREE   OLD bars [2]
SoESoT   NEW bars [3]  one-sentence bars [3]  AGREE   OLD bars [3]
SoETSoT  NEW bars []   one-sentence bars []   AGREE   OLD bars []
SoCSoT   NEW bars [3]  one-sentence bars [3]  AGREE   OLD bars []     <- the `clear` closure part (ii) newly names
SoTSoT   NEW bars []   one-sentence bars []   AGREE   OLD bars []     <- the conformant control
```

**The lift probe** — over the same 2,091,881 trace instances containing a start
character, the number of traces on which the class-(f) lift changes the OLD
verdict is **0**: it selected nothing (§(a)5, with its stated bound).

**3. The reading probe** (`…/scratchpad/csg3_reading.py`, ephemeral):

```text
READING B (bar only where a following terminate character exists):
  THRESH=1  349617 traces disagree with the one-sentence form (409229 start characters)
  THRESH=2  339770 traces disagree (395159 start characters)
  direction: the one-sentence form bars and READING B does not, in every case;
             smallest instances SES, SCS, SSES, SSCS
```

and the ruling's own domain size, checked as an identity rather than re-run:
`Σ 6ⁿ, n = 1 … 8 = 6 + 36 + 216 + 1296 + 7776 + 46656 + 279936 + 1679616 =`
**2,015,538**, exactly the figure reported for a length-1…8 sweep of `SToEXC`.

**4. The guards and the committed corpus, measured at HEAD:**

```sh
sed -n '245,262p;273p' test/cosim/ours_run.ml        # FI-4: refuse while open; clear on terminate
sed -n '529,533p;575,576p' test/cosim/tb_xgmii_rx_64.v # FI-6: the same, same order
grep -c "Arrival.create" test/cosim/stimulus_gen.ml    # 19 (five builders)
grep -n "0xFE\|oversize\|1600\|runt" test/cosim/stimulus_gen.ml   # (no output)
```

Observed: `ours_run.ml:249-255` raises on a start character while `admission_open`
is set; `:273` is `if !admission_open && has_terminate word then admission_open :=
false;` — **terminate only**, checked **after** the start arm;
`tb_xgmii_rx_64.v:533` and `:575-576` mirror both. The stimulus generator's five
builders are whole frames scheduled through `Arrival.create` with an explicit
inter-frame gap and contain **no error character, no oversize frame and no runt**,
so no committed stimulus is reached by the widened restriction.

**5. The transmit-boundary premise:**

```sh
$ git ls-files test/third_party/verilog-ethernet/
test/third_party/verilog-ethernet/COPYING
test/third_party/verilog-ethernet/PROVENANCE.md
test/third_party/verilog-ethernet/axis_xgmii_rx_64.v
test/third_party/verilog-ethernet/lfsr.v
```

**Four paths, no transmit module** — the paragraph's premise holds at HEAD.

**6. §12's row count**, for §(c)1's one-instance claim: twenty-one strobe rows
(`sed -n '976,998p' docs/specs/requirements.md | grep -c '^| \`error'` → `21`),
read individually; the only absence-conditioned condition is `error_underflow`.

**7. Independence.** `git status --short` at return lists exactly one path of
mine, `agents/journals/claude_dv_lead_agent.v09.md`, beside the declared
sibling's untracked `test/xgmii_tx_64/`, which belongs to neither of my commits
(Evidence 1; act one's Evidence 6 for why that distinction is mine to make by
hand). **No `git add`, no `git commit`, no `git push`, no git write of any kind**;
the commit that moved HEAD is the orchestrator's and I neither made it nor merged
it.

### Outcome

**Two countersignatures (both COUNTERSIGNED), one non-contest, one new MINOR
finding, one correction of my own record.** DoD for a countersignature round: met.
Nothing is contested; the REQ-901 diff enters force on transcription of Row D.

**THE COUNTERSIGNATURE TEXTS — written for the orchestrator to transcribe
verbatim into `docs/specs/requirements.md` §13 (columns: Date | REQ | Change |
Class | Commissioned by | Journal). The orchestrator fills its own journal id in
the last column. Authority lives in this entry; the rows are clerical and commit
under `Agent: orchestrator`.**

**Row D — REQ-901, REQ-108, REQ-110. THE NORMATIVE ONE: IN FORCE from this row and not before.**

```
| 2026-08-11 | REQ-901, REQ-108, REQ-110 | **Countersignature transcribed — the restriction restated over the span, the widened parts (i) and (ii), the struck class-(f) lift, the repaired record-only licence, the one-sentence form and REQ-108's and REQ-110's brought-into-agreement verification columns are IN FORCE from this row.** dv_lead COUNTERSIGNED at `9535979` after deriving the equivalence and then checking it independently. **(1) Derivation, not acceptance**: over the span's own structure three cases exhaust every start character — the frame is still open (part (i) bars; and no terminate can lie between the two starts, else it would have been the earlier closure, so the sentence bars too); the frame closed on its **terminate** character (neither part bars, and that terminate closes every interval part (ii) could open, so the sentence does not bar); the frame closed on a **non-terminate** closure (part (ii) bars exactly when no terminate lies between the closure and the start, which is the same condition as no terminate between the two starts, because a terminate before the closure would have been the closure) — so the one-sentence form is equivalent to parts (i)+(ii) as a **theorem**, the trace's first start excepted under both. **The direction claim is likewise a containment theorem and not a count**: dropping *"that has already delivered an octet"* only widens part (i), `{error} ⊂ {error, truncation, clear}` only widens part (ii), and striking a lift only removes exemptions — so the repair **cannot** admit anything the old rule refused, by construction. **(2) A bounded independent enumeration, built differently from the ruling's on purpose**: five symbols with REQ-108's truncation **derived from an octet count** against a swept threshold rather than placed in the alphabet as a symbol; traces of length ≤ 9; **2,441,405 traces and 4,272,461 start characters judged individually — zero mismatches with the one-sentence form at either threshold, 1,019,340 start-character verdicts moved at the first (990,422 at the second) and not one in the barred→legal direction at either.** `CSG-3`'s own geometry (oversize with **no** terminate, then a lane-0 start, then a normal frame) moves legal→barred; **REQ-108's own verification geometry — the same with the oversize frame's terminate present — stays legal**, so the repair costs the requirement it most nearly reaches nothing; the zero-delivered start moves legal→barred. **(3) The reading this signature fixes**: part (ii)'s interval runs to the **end of the trace** where the closed frame has no following terminate character. Under the literal alternative the two formulations disagree on **349,617** traces of length ≤ 9, always with the one-sentence form the stricter (smallest instance `S /E/ S`), so the ruling's zero-mismatch result identifies its reading and this is the reading countersigned; nothing rests on the choice for a producer, because a guard measured against the one-sentence form conforms under either. **(4) A correction of record, dv's own**: `J-dv_lead-0170` §(f) said the class-(f) lift *"goes further"* than the parts; measured over the same enumeration under the reading that ties class (f) to a frame our side truncated, **the lift never changes a verdict — it selected nothing**, the geometry being already unbarred by the parts as they stood. The finding's conclusion is untouched — the gap was in the parts, which is where the cure went — and the strike is cheaper than dv's own filing implied. **(5) The guard measurement this diff assigns to dv, made**: `FI-4` (`test/cosim/ours_run.ml:245-262`, `:273`) and `FI-6` (`test/cosim/tb_xgmii_rx_64.v:529-533`, `:575-576`) refuse a start character while an admission flag set at the previous start character is still set, and clear it **only** on a terminate character — which is exactly *"every start character follows a terminate character"*, the trace's first excepted. The single residual width is a terminate character and a later start character **in one input word**, which §0.3's 12-octet minimum gap puts outside conformant stimulus. **So the release claim holds and is stronger than stated**: dv's self-binding (*"I will not narrow either guard for the truncation-closure geometry until `CSG-3` is ruled"*) releases by its own terms, and it releases into a **stricter** position — for a run that compares, narrowing is now barred by this rule itself rather than by dv's undertaking. Narrowing remains a question only for a **record-only** run, whose lane is a separate authorised act and does not exist. **No committed artefact moves**: `test/cosim/stimulus_gen.ml`'s five builders are whole frames with an explicit inter-frame gap and contain no error character, no oversize frame and no runt | transcription — the normative diff of the row above enters force here; this row itself moves no text. The countersigned reading of part (ii) is recorded in it: the interval runs to end-of-trace where no terminate character follows the closure | dv_lead, `FINDING CSG-3` (MATERIAL), filed at `J-dv_lead-0170` §(f) and ruled at `J-architect_docs_lead-0039`; countersignature of record `J-dv_lead-0173` §(a) | `J-orchestrator-NNNN` |
```

**Row E — §0.6's fourth reference-word clause (carry-forward C-5). The clause was already in force; this row records the countersignature it was owed.**

```
| 2026-08-11 | §0.6 (**the window's reference word, fourth clause**) | **Countersignature transcribed — §0.6's fourth reference-word clause is countersigned, with one MINOR finding against its stated ground and none against its rule.** dv_lead COUNTERSIGNED at `9535979` on the clause's operative content — the reference word for a condition reported on the **non-arrival** of an input word is the cycle the word was required and not presented; the ceiling adds §0.5's word delay ΔC and **never** an event delay a module spec may also pin; and the window carries no independent information at this module — after three checks made at the source. **(1) The instance count**: all twenty-one rows of §12 read one by one, and `error_underflow` is the only condition that is an absence; the two nearest candidates, `error_ip_truncated` and `error_tx_length_mismatch`, are both decided **on** the early `tlast` word, a word that arrives. **(2) The ΔC clause**: §0.5 defines L in octet times and ΔC in cycles, so *"the module's latency in cycles (§0.5)"* can only be ΔC = 2, and REQ-210's 1-cycle event delay is REQ-210's — the collision being one dv's own `FINDING AP-M04-1` created in a document it did not touch. **(3) The near-edge claim**: §9's pin, §0.6's floor and the new reference word are **the same cycle**, so the window adds nothing and the pin governs inside it (§0.6's own *"a bound, never a licence"*). **One MINOR finding filed without holding the clause out of force — `FINDING ABS-1`, against the clause's stated ground, at two sites of which one is dv's own.** The ground reads *"the three clauses above name no word … the octet the first clause measures from is one that never arrives, and the third clause does not reach it either because the frame did receive octets"*, and those halves cannot both hold: since **2026-08-04** (`0caf023`) the first clause names *"the last octet that frame **received while it was open**"*, not the frame's final octet, and an underflowed frame **has** received octets — REQ-207 forbids dropping an accepted word, and `AP-xgmii_tx_64` row `M04-G5` asserts source word 0's octets reach the wire on an underflow at `C + 1`. The first clause therefore names a word here (the source word carrying the last octet accepted), so **this clause is an override rather than a hole-filler**: it moves the reference one cycle later, to the condition's own decidability cycle. **Nothing turns on it and the editorial class survives, checked rather than assumed**: with `A` the cycle of the last accepted source word the pin is at `A + 1`, the first clause's ceiling is `A + 2` and this clause's is `A + 3`, so the pin lies inside both and the change can only loosen a bound already redundant against §9's pin. **The cure is one sentence** — state what the clause does (move the reference to the decidability cycle so that the window's floor and its reference word are one event) instead of denying that the first clause reaches this class. **And the identical misreading is in dv's own instrument, filed against dv in the same act**: `AP-xgmii_tx_64` row `M04-G7` says *"an underflowed frame never receives that octet — the window has no reference word"*, written on 2026-08-11, a week after the gloss it contradicts, so wrong when written rather than made stale. That row's NO-ASSERT status and conclusion do **not** move and are now carried by this clause's own no-independent-information sentence; its ground is repaired at the round that next opens the plan | transcription — no normative text moves in this row; it records that the countersignature §13 says is owed on this clause is paid, with `ABS-1` outstanding against one sentence of the clause's ground (architect_docs_lead's to rule) and one row of dv's own attack plan (dv's to repair) | carry-forward **C-5** (SPEC-M04 §11.3's deferral) and dv_lead's `AP-xgmii_tx_64` §8 item 3; countersignature of record `J-dv_lead-0173` §(c) | `J-orchestrator-NNNN` |
```

**No row is offered for SPEC-M04 §13's `AP-M04-2` cure and none is owed** (§(b)):
the added bench prohibition is **NOT CONTESTED**, on the reading that its subject
is a REQ-016 idle-injection wrapper and not the act of withholding a required
word — a reading forced by the sentence's own *"on a required cycle"* gloss and by
§9's and §10's own commissioning of REQ-206 stimulus. **Nor for the
transmit-boundary row**, which is editorial and which I verified rather than
merely read (§(d)).

**Handoff.** No packet is written this round; the write set is this journal file
alone. The two rows above are the signatures of record.

### Open-questions

1. **`FINDING ABS-1` (MINOR, new, mine).** §0.6's fourth clause states a ground
   its own first clause refutes, and `AP-xgmii_tx_64` row `M04-G7` states the same
   thing in the same words. **Route**: architect_docs_lead for the §0.6 sentence;
   the plan row is mine and rides with the repairs at item 2. **Not blocking**:
   the rule is right, the class is editorial, and no design or instrument moves.
2. **The `AP-xgmii_tx_64` repair debt is now FIVE**, all editorial, all carried by
   the round that next opens `test/attack_plans/**`: `M04-B2`/`M04-C4`'s poison
   quantifier (`FINDING AP-M04-3`); `M04-J3`'s quotation of REQ-210's struck
   opening clause; §2 obligation 5 and §8 item 3's superseded `C-5` deferral; the
   §9 change-log row for families A/B/C's landed status; and **new this entry**,
   `M04-G7`'s ground. Act one predicted a fifth might be added and did not
   predict which.
3. **`FI-4` and `FI-6` are not narrowed, and the reason has changed.** The
   self-binding released; the guards stay as they are because for a comparing run
   the repaired rule now requires exactly what they enforce. The next round that
   proposes touching either must say which kind of run it is for, and a
   record-only run needs the lane at item 5 of `J-dv_lead-0170`'s
   Open-questions, which still does not exist.
4. **`SO-xgmii_rx_64.md`'s Stage-3 gate table** still records condition **(c)
   UNMET**; it became MET at `36e3a4d`. Unchanged by this round, still owed at
   the round that next opens the `SO-`, and that round should also record that
   `FINDING ECS-3`'s guard-width subject is discharged **for a comparing run**
   and survives only for a record-only one.
5. **The transmit boundary is a gate condition, now stated in the requirement.**
   No sign-off packet may cite a transmit-boundary co-simulation result as an
   anchor for any requirement until the transmit counterpart is vendored at a pin
   (ADR-0015 D2, `PROVENANCE.md`) — verified at four vendored paths, none of them
   a transmit module. Charter §3 makes differential co-sim a precondition of
   Phase 1 MAC sign-off, so this binds `SO-xgmii_tx_64` and it is the orchestrator's
   to sequence: the vendoring commit first, then the harness, then the classes.
6. **Standing and untouched by this round**: `DVC-1a`; the transmit-side
   conservation monitor (`AP-M04` §7 T-2); `AP-ip_eth_rx_64`'s `M14-F1`/`F2`/`F3`;
   `WO-0080`'s return and its `RV-`; `AP-M04` §8 items 2 and 4–6.

### Files-in-this-commit
- (none)

---

## [J-dv_lead-0174] 2026-08-11T08:47Z | task:WO-0080 | RV-0080 — BOUNCE on one bar of sixteen, and the bar that failed is the one my own instrument set could not reach: the M04 bench is red at its first type-level compile on three infix `mod` sites, its arithmetic right in every cell I checked, and the notation that produced the defect is quoted in my own packet

### Trigger

Orchestrator dispatch: review `tb_writer`'s `WO-0080` execution, landed at
`960c831` with `J-tb_writer-0042`. Spawn-head `960c831`, no siblings. Three
specifics beyond the packet's own bars were named in the dispatch: adjudicate
`BM16` (the worker's own tool-choice disclosure), rule the two front-matter
count discrepancies the worker reported, and cite the CI conclusion at the
landing commit by run id.

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # 960c8314ca6139894537549ab0dbbd6fa46cc42b
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched spawn-head, tree clean. Neither branch of the abort
procedure reached.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, both in full, this round.
- `agents/handoffs/WO-0080_tb-m04-first-bench.md` in full — all 1869 lines at
  spawn, across three page reads, including the worker's appended Return log.
- The seven landed files, **all read in full**: `test/xgmii_tx_64/dune`,
  `bench.mli`, `bench.ml`, `test_m04_scaffold.ml`, `test_m04_a.ml`,
  `test_m04_b.ml`, `test_m04_c.ml`.
- `agents/journals/workers/claude_tb_writer_agent.v03.md` — entry
  `J-tb_writer-0042`, header through `Files-in-this-commit`, with its
  `Inputs` and `Open-questions` sections read as the `M-16` and `BM16` evidence
  they are.
- The machinery contracts, read to check the bench's calls against them rather
  than to take the packet's §5.1 table on trust:
  `test/monitors/stream_word.mli` and `stream_word.ml`'s default arguments,
  `test/monitors/strobe_monitor.mli`, `test/xgmii/tx_decoder.mli`,
  `test/xgmii/xgmii_word.mli`, `test/xgmii/frame.mli`,
  `test/xgmii_probe/xgmii_probe.ml`, `test/axi64_probe/axi64_driver.ml`.
- `test/attack_plans/AP-xgmii_tx_64.md` — the Status cell of each of the
  thirteen commissioned rows, read individually (the `WO-0080-2` measurement).
- `test/xgmii_rx_64/bench.ml`, `bench.mli` and `dune`, plus the ten
  `test_m03_*.ml` files' modulo sites, read to establish what the tree's proven
  idiom is and where it lives.
- `.github/workflows/build.yml`, for the step names `M-2` reads by.
- CI at the source: `build` run **31473937935** (job `build` id 93723206864,
  job `cosim` id 93723206763, the failing job's full log tail covering the whole
  `Build` step) and `journal-check` run **31473937929**, both at `head_sha`
  `960c8314ca6139894537549ab0dbbd6fa46cc42b`.
- **No RTL.** `libs/**`, `top/**`, `rtl_snapshots/**` and
  `test/third_party/**` were not opened at any point this round. The one place
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` appears in anything I read is
  inside negative statements — the packet's own §7 and §8, the bench's `dune`
  header and `bench.mli`'s independence paragraph — each declaring the file was
  *not* opened.

### Reasoning

**The verdict was decided by a pre-commitment, and that is the point of having
made one.** §15's disposition table classes a compile error **D4a**, bench-side,
and §13's `BM1` pre-commits a D4a red at the landing commit as a bounce. `Build`
is red at `960c831`. There was no discretion left to exercise and I did not
manufacture any. What discretion the round did contain — where the *cause* sits,
what the fix round's scope is, how `BM16` rules — is exercised below and is
deliberately kept downstream of a token that was already fixed.

**Why I re-executed the worker's own bars instead of reading its account of
them.** `L-B03`: verify against the diffs and the tree, never the Return log's
account of them. Every figure in `M-8` … `M-16` I measured again myself, and all
of them agree — 1/1/3/5 units per file, ten empty `[%expect]` blocks with the
eleventh a `dune` prose token, one `tready` choke point, one `poison` definition,
both scans excluding the four FCS octets. That mattered more than usual this
round, because the same worker had disclosed using instruments outside its
allow-list: if any bar's figure had rested on a forbidden pipeline I would have
had no way to tell from the Return log, and the whole `BM16` adjudication would
have had to be made in the dark. It did not; independent re-measurement is what
turned the disclosure's central claim from an assertion into a checked fact.

**`FINDING K-3` bit this round, exactly as it was minted to.** §12 pins every
tree-quantified bar's base at `ee47eee`. Five commits landed between `ee47eee`
and the worker's — this packet, the BOARD update, my volume rotation, my
countersignature, the transcription — **none of them the worker's**. A literal
`git diff ee47eee 960c831` shows fourteen paths, and `M-1` read that way would
have convicted the worker of nine paths it never touched. The lesson's own words
are *"its failure looks like a defect in the work"*, and that is precisely the
shape it would have taken. Executed at the base its subject quantifies over —
`747e561..960c831` — `M-1` passes with a nine-path set, and the five extras are
accounted for commit by commit. `M-3`'s base I re-measured with the bar's own
instrument at a scratch checkout of `ee47eee` rather than re-quoting the pinned
139; it *is* 139, and re-measuring cost one command and bought the right to say
so under §9.1.

**Where the defect actually sits, and why I did not let that move the verdict.**
The three failing sites are `1 + (j mod 127)`, `Int.to_string (j mod 8)` and
`f mod 8`. My packet quotes those three expressions in code-shaped backticks at
§4 and §6.0(b). My packet specifies at §11.2 the `dune` stanza whose files open
`Base`. My packet's §3 read list names `test/xgmii_rx_64/bench.{ml,mli}` as the
files to learn the idiom from, and I measured this round that **neither contains
a modulo of any kind** — all 93 `Int.rem` sites are in ten `test_m03_*.ml` files
I never named. My packet's §16.3 seeded the unchecked-names list with five
entries, none an operator, teaching the worker to hunt unfamiliar *names* rather
than familiar *spellings that mean something else here*. And my packet's only
executable instrument at the worker's seat, `M-15`, is structurally blind to an
alert: `j mod 127` parses. I wrote *"Parse is not the adjudicator"* into that bar
and then supplied nothing that was. So the round's single defect landed in the
round's single blind spot, and four of the five conditions that made it possible
are mine.

That is `FINDING WO-0080-1`, MATERIAL, against myself. It does not reclassify the
error. The temptation to let it — to reach for "accept with repair owed" because
the packet invited the mistake — is exactly what a pre-committed disposition
table exists to remove, and I will not be the seat that renegotiates its own
table after seeing which way it points. What the finding moves is the **terms**:
rev B carries four repairs, one of them a new bar (`M-17`, a Grep for infix
` mod ` with pass condition zero occurrences outside a string literal) that is
executable at a worker's seat and would have caught this round's entire defect
set for the cost of one search.

**The bounce is narrow and the packet says so in its own header.** Fifteen bars
of sixteen pass. `M-6` — the constants bar, the one this packet's `BM3`/`BM4`
exist for — passes cell by cell against computing expressions, not comments:
`cycles_for`, `content_octets`, both scan domains, all eight rows of §6.1's
master table with the `tkeep` column arising from `(1 lsl len) - 1` rather than
written as literals, and every per-unit table. **Zero wrong asserted values.**
The bench's arithmetic is right; only an operator is unspellable in the library
it was written for. A bounce that failed to say that would misdescribe the work
it bounces.

**The ceiling on the defect set, which I nearly stated wrongly.** The
coordinator's relay and my own reading of the complete `Build` step agree that
three sites are the only errors reported. It does not follow that three are the
only errors. `dune` stops scheduling on failure, and the step reports on
`bench.ml` and `test_m04_b.ml` and on none of the other three test files. What
the red *does* establish beyond the three is that `bench.mli`'s `.cmi` built —
its dependents were scheduled. So: three is the floor, and only a green `Build`
establishes the rest. The fix round is told to say that rather than to report
"the three are fixed" as though it were the same claim.

**`BM16`, and why the WO-0071 shape fits with one thing added.** The condition is
met by admission: `git status`/`rev-parse` at spawn, `ls`/`cat`/`wc`/`grep`
reconnaissance, a second `git status`, `date -u`, `ocaml -version` — disclosed
command by command in the worker's own journal, with the aggravating case named
unprompted (`cat test/hardcaml_ethernet/dune`, run *after* §17.1 had been read).
No forbidden path was touched; no bar's evidence rests on a forbidden instrument,
and that is measured, not accepted; the disclosure is durable in the repo, which
is the property `RV-0071-VERDICT` §3 had to withdraw a claim for want of.

The thing WO-0071's shape does not by itself supply is the finding the disclosure
buys, and here it is sharp: **§17.1 forbids `git status` and `git rev-parse`
while the orchestrator's standing abort-first precheck mandates both, before the
worker has read the packet that forbids them.** The two instructions are
unsatisfiable together. The worker took the precheck — which is right; the
precheck is what caught incident eight at `9d68d10`, where a round's substrate
had vanished underneath it — and then reported the conflict rather than resolving
it quietly in its own favour. A rule that forces a violation and then convicts it
is worse than the violation. Ruling: **accept, disclosure credited in full, no
sanction**; §17.1 gains a named, narrow carve-out for the two precheck commands
on the re-issue; the residue stands as a recorded process finding. And because
`BM1` had already fixed the token, this ruling is one I could make on its merits
without it changing an outcome — which I state in the verdict itself, so it
cannot be read as reverse-engineered.

**The two count discrepancies: both mine, both editorial, nothing moves — and
corrected in place with the old text struck rather than overwritten.** Measured
row by row against the plan's own Status column, the split is eleven ASSERT and
two NO-ASSERT, not ten and three; and three units drive length sets, not four,
carrying four row ids between them. The worker is right on both. Neither reached
a line of code: it built every row from its own §2 Status cell, which is what the
packet told it to do. I struck rather than replaced because the worker's finding
is a finding *against this packet*, and a silently repaired packet makes the
conviction uncheckable at the artefact it convicts — the discipline act one of
the volume before this one used at its own §19.1 and the one this record keeps.

**And a third quantifier defect of mine surfaced through a question the worker
was right to ask.** §6.3's assertion 4 says the content octet appears at "no
other (cycle, lane) position in the run". As a literal universal it fails against
a conformant design, and my own trap T11 says why: `/I/` is `0x07` and
`content 6` is `0x07`. The worker narrowed the scan to indices `0 … 59`,
excluding the FCS on §6.0(c)'s own arithmetic-falsifiability ground, and reported
the narrowing as a derived judgement instead of performing it silently — class
D5, credited in full. Confirmed, and the packet moves, not the bench. This is the
**third** instance in my own instruments of a universal stated over a domain
wider than the claim can survive: `FINDING AP-M04-3`'s poison quantifier,
`FINDING ABS-1`'s `M04-G7` ground, and now `M04-B1`'s. Three is a pattern in one
plan, and it is the harvest candidate I am carrying forward rather than minting
here (this round is an `RV-`, not a sign-off or a gate, so ADR-0018 owes no
harvest note and none is declared missing — the span tiles at the next `SO-`).

### Actions

- Read the packet, the seven landed files, the worker's journal entry, seven
  machinery contracts, the plan's thirteen Status cells, and the `build`
  workflow's step names.
- Executed §12's seven dv-seat bars, each at the base its own subject quantifies
  over; re-executed all nine worker-seat bars independently at the tree.
- Read CI at the source, by job and by step name and status — never a badge —
  and read the failing job's log across the whole `Build` step.
- Measured the tree's proven modulo idiom and where it lives, and measured that
  the four pre-existing infix `mod` sites elsewhere in `test/` are in libraries
  that do not open `Base`, so they are not precedent.
- Wrote `RV-0080-VERDICT` into `agents/handoffs/WO-0080_tb-m04-first-bench.md`
  and flipped its State header `ISSUED` → `RETURNED` → **`BOUNCED`**.
- Annotated the two front-matter defects in place, struck and visible.
- **Staged nothing under `test/**`.** A bounce prescribes; it does not edit the
  work it judges.

### Evidence

**1. Head and tree at review.**

```sh
git status --short      # zero lines
git rev-parse HEAD      # 960c8314ca6139894537549ab0dbbd6fa46cc42b
```

**2. `M-1`, at the base its subject quantifies over.**

```sh
git show --stat 960c831        # 9 paths, 2167 insertions
git log --oneline ee47eee..960c831
```

The worker's own commit changes exactly nine paths: the seven under
`test/xgmii_tx_64/`, `agents/handoffs/WO-0080_tb-m04-first-bench.md`, and
`agents/journals/workers/claude_tb_writer_agent.v03.md`. Trailers:
`Agent: tb_writer`, `Work-Order: WO-0080`, `Journal-Entry: J-tb_writer-0042`.
The five intervening commits and their paths: `9535979` (packet + my v08),
`48077aa` (orchestrator journal + BOARD), `75a528d` (my v09), `e1faaed` (my
v09), `747e561` (orchestrator journal + `docs/specs/requirements.md`).

**3. `M-3`, base re-measured rather than re-quoted.**

```sh
git archive ee47eee test | tar -x -C <scratch> --one-top-level=base_ee47eee
grep -rh --include=*.ml 'let%expect_test' <scratch>/base_ee47eee/test/ | grep -c .   # 139
grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .                          # 149
```

Per-directory at the landing: `axi64_probe` 3, `cosim` 0, `golden` 11,
`hardcaml_ethernet` 1, `monitors` 37, `xgmii` 25, `xgmii_probe` 3,
`xgmii_rx_64` 59 (**= 139**), `xgmii_tx_64` **10**. Delta **+10**, no other
movement.

**4. `M-4` and `M-5`.**

```sh
git ls-files test/xgmii_tx_64/                          # 7 paths, = §11.2 items 1-7 as a set
git diff --stat ee47eee 960c831 -- test/xgmii_rx_64/    # empty
git ls-files test/xgmii_rx_64/ | wc -l                  # 17
```

**5. `M-7`.** Every `M04-` occurrence across `test/**/*.ml` at the landing, by
distinct id: `M04-A1`, `A2`, `A5`, `B1`, `B2`, `B4`, `B5`, `C1`, `C2`, `C3`,
`C4`, `C5`, `C6` — the thirteen commissioned — plus the bare token `M04-` twice,
at `test_m04_scaffold.ml:1` and `:65`, both inside U1's *"no `M04-` row id"*
negation. Base: **0**.

**6. `M-2`, the CI reading, by name and status at the source.**

`build` run **31473937935**, `head_sha`
`960c8314ca6139894537549ab0dbbd6fa46cc42b`, conclusion **`failure`**,
`run_attempt: 1`.
Job `build` (id **93723206864**), conclusion `failure`: step 5 **"Build"
`failure`**; step 6 **"Run tests (expect tests, waveform snapshots)"
`skipped`**; step 7 "Generate RTL" `skipped`; step 8 **"Verify nothing was left
unpromoted or non-deterministic" `skipped`**; steps 9, 10 `skipped`.
Job `cosim` (id **93723206763**), conclusion `success`: all six steps `success`.
`journal-check` run **31473937929**, same `head_sha`, conclusion **`success`**,
`run_attempt: 1` — R1–R8 re-verified at this commit, including the eight-path
`Files-in-this-commit` set-equality.

**7. The complete `Build` step output, one error class, verbatim:**

```
File "test/xgmii_tx_64/bench.ml", line 151, characters 56-59:
151 | let content_octets ~p = List.init p ~f:(fun j -> 1 + (j mod 127))
Error (alert deprecated): Base.mod
[2016-09] this element comes from the stdlib distributed with OCaml.
Use (%), which has slightly different semantics, or Int.rem which is equivalent.

File "test/xgmii_tx_64/test_m04_b.ml", line 62, characters 35-38:
 62 |                 ; Int.to_string (j mod 8)
Error (alert deprecated): Base.mod

File "test/xgmii_tx_64/test_m04_b.ml", line 234, characters 27-30:
234 |     let terminate_lane = f mod 8 in
Error (alert deprecated): Base.mod
```

(`bench.ml:151` is reported twice — once for the native `.cmx`, once for the
byte `.cmo`.) The step ran 08:40:50 → 08:40:57 and exited 1; the log tail I read
covers it whole.

**8. The proven idiom, measured — the ground for prescribing `Int.rem`.**

```sh
grep -rn ' mod ' test/xgmii_tx_64/*.ml          # 4 hits: 3 code sites + 1 inside a string literal
grep -rc --include=*.ml 'Int.rem' test/         # 93 total, in ten test/xgmii_rx_64/test_m03_*.ml files
grep -n 'Int.rem\| mod \| % ' test/xgmii_rx_64/bench.ml test/xgmii_rx_64/bench.mli
```

The last command returns **one** hit and it is prose in a `bench.mli` docstring
(`"terminate lane 0 .. 7 (length mod 8)"`) — so **neither of the two files §3
ordered read contains a modulo expression**, which is the measurement behind
`FINDING WO-0080-1`(2). The four pre-existing infix `mod` sites elsewhere
(`test/xgmii/arrival.ml`, `injection.ml`, `idle_injection.ml`,
`test/golden/test_crc32_ref.ml`) are in files that do **not** open `Base` — no
`open` line in any of them — so the stdlib operator applies there and they are
not precedent.

**9. `M-8`, re-executed.** `sample_cycle` = `bench.ml:89–149`.
`Cyclesim.outputs ~clock_edge:Side.Before` at `:107`; `Cyclesim.cycle` at
`:132`; the refs read at `:135–:137`; acceptance at `:139`,
`let accepted = offered.tvalid && tready in`. Eight steps, in order.

**10. `M-10`, `M-11`, `M-13`, `M-14`, re-measured.** Per-file `let%expect_test`:
scaffold 1, a 1, b 3, c 5. Ten `[%expect {||}]`, all empty; a search for
`[%expect {|` followed by a non-`|` character returns nothing; the eleventh raw
hit is `dune:20`. `tready` in the directory: `bench.ml:108` (ref) and `:135`
(deref), both in `sample_cycle`; zero occurrences in any `test_m04_*.ml`.
`poison`: one definition, `bench.ml:41`; scans at `test_m04_b.ml:189`
(`~pos:0 ~len:60`) and `test_m04_c.ml:194` (`~pos:0 ~len:(f - 4)`).

**11. `FINDING WO-0080-2`, measured against the plan itself**, row by row over
the Status column of all thirteen commissioned ids in
`test/attack_plans/AP-xgmii_tx_64.md`: **ASSERT** for `A1`, `A2`, `B1`, `B2`,
`B4`, `B5`, `C1`, `C2`, `C3`, `C4`, `C5`; **NO-ASSERT** for `A5`, `C6`. Eleven
and two.

**12. Cost, re-summed rather than accepted.** `cycles_for ~p` = `27 + F/8` gives
35 for every `F` in 64…71 and 216 at `F` = 1518. U1 12·1 + U2 35·1 + U3 35·1 +
U4 35·1 + U5 (7×35 + 216) + U6 35·1 + U7 4×35 + U8 35·1 + U9 35·1 + U10 3×35 =
**928 driven cycles across 22 elaborations** — matching §10's table and
**0.62×** both of the round's ceilings (1 500 / 28). `BM13` not reached.

**13. Independence.** `git status --short` at return lists exactly two paths,
both mine: `agents/handoffs/WO-0080_tb-m04-first-bench.md` and
`agents/journals/claude_dv_lead_agent.v09.md`. **Nothing under `test/**` was
staged, edited or created** — a bounce prescribes, it does not repair the work it
judges. **No `git add`, no `git commit`, no `git push`, no git write of any
kind.**

### Outcome

**`RV-0080-VERDICT` = BOUNCE.** DoD for a review round: met. `BM1` fires on a
§15 **D4a** compile red at the landing commit; `BM2` … `BM15` do not fire;
`BM16`'s condition is met by admission and adjudicated **accept, credited, no
sanction**. Bar tally **15 PASS / 1 FAIL**, the failure being `M-2` itself.

**Findings minted**: `WO-0080-1` (MATERIAL, mine — the notation, the read list,
the seeded name list and the bar set); `WO-0080-2` and `WO-0080-3` (MINOR, mine,
editorial, corrected in place with the old text struck); `WO-0080-4` (MINOR,
mine — §6.3 assertion 4's quantifier, the third of its kind in this plan);
`WO-0080-W1` and `WO-0080-W2` (MINOR, the worker's — the `dune` header's own
stale count and an unmeasured ordinal in a docstring). Two observations,
`O1` (the reset cycle is outside every instrument's view — forced, correct here,
family G's to decide) and `O2` (§7.1's cycle-numbering wording). One worker
question, `Q-1`, **CONFIRMED** with the packet moving and not the bench.

**Zero rows discharged.** `Run tests` was `skipped`, so no row of the thirteen
has been executed against the design and the outstanding count against `AP-M04`
stands at **80 of 80**. No `SO-xgmii_tx_64.md` is opened or offered; `BAR T1`
stays SHUT; the PROTOCOL §10 mutation campaign stays sequenced after this
packet's eventual ACCEPT.

**Handoff**: the bounced packet is the artefact —
`agents/handoffs/WO-0080_tb-m04-first-bench.md`, State `BOUNCED`, with the defect
list at §2, the fix round's scope at §8, and the four packet repairs rev B
carries. Route: orchestrator, to respawn `tb_writer` on rev B. **No harvest note
is owed** — ADR-0018 attaches one to every `SO-` and every phase gate, and this
round is neither; the span tiles unbroken to the next sign-off, where the
three-instance quantifier pattern at Open-questions item 2 is the candidate I
carry into it.

### Open-questions

1. **`FINDING WO-0080-1` is against me and is the round's real content.** The
   repair is four changes to the packet, one of them a new bar. **Route**: mine,
   on rev B, before the fix round is dispatched. Not escalated: it cost one
   bounce and no design claim, and the compensating change is executable at a
   worker's seat.
2. **The quantifier pattern is now three instances in one plan** —
   `AP-M04-3`'s poison scan, `ABS-1`'s `M04-G7` ground, and `M04-B1`'s
   uniqueness scan — each a universal stated over a domain the claim cannot
   survive, each caught by someone other than the seat that wrote it (twice by
   the worker, once by my own countersignature). Carried as the harvest
   candidate for the next `SO-`, where LH1–LH3 can be discharged against three
   named incident commits rather than one.
3. **The `AP-xgmii_tx_64` repair debt is now SEVEN**, all editorial, all riding
   the round that next opens `test/attack_plans/**`: the five at the previous
   entry's Open-questions item 2, plus `M04-B1`'s quantifier, plus the §9
   change-log row — whose landed-status figure must record **zero** rows
   discharged at `960c831`, not thirteen.
4. **§17.1's precheck contradiction is a standing worker-dispatch defect, not a
   `WO-0080` one.** The clause is the standing form (`WO-0072` §17.1), so every
   packet carrying it forbids the precheck the dispatch mandates. **Route**:
   fixed in `WO-0080` rev B by name, and flagged to the orchestrator as owed in
   the standing form itself — otherwise the next packet reproduces it and the
   next worker faces the same unsatisfiable pair.
5. **Family D is still the next bench round, and it is now sequenced behind rev
   B landing green.** §1.3's argument was that a capability-heavy round should be
   followed by the cheapest coverage available. A capability layer that has never
   compiled is not yet a capability layer.
6. **Standing and untouched by this round**: `DVC-1a`; the M04 census in
   `tools/dv_checks.sh`; the transmit-side conservation monitor (`AP-M04` §7
   T-2); `AP-ip_eth_rx_64`'s `M14-F1`/`F2`/`F3`; the three `BAR T1` work orders;
   `FINDING ABS-1`'s §0.6 sentence (architect_docs_lead's to rule);
   `SO-xgmii_rx_64.md`'s Stage-3 gate table.
7. **This entry's timestamp is EARLIER than the two above it, and it is not a
   typo — recorded so the next reader does not take it for one.** `date -u` at
   this seat reads **08:47Z** on 2026-08-11, and that clock is corroborated by
   two independent artefacts of this same round: `J-tb_writer-0042`'s header
   (**08:29Z**) and `build` run 31473937935's own timestamps (queued 08:36:09Z,
   `Build` step 08:40:50 → 08:40:57Z). The preceding entries carry **23:20Z**
   and **23:55Z**, which cannot lie between the worker's entry and the CI run
   they precede in the commit order. So one of the two clocks is wrong and it is
   **not** this one. **Nothing rests on it**: PROTOCOL §4.1 and R5 make the
   `NNNN` monotonic, not the timestamps, and 0172 → 0173 → 0174 is monotonic and
   append-ordered. Flagged rather than silently normalised, because writing a
   later time than my clock reads to make a column look tidy would be the
   fabricated-evidence move this programme bounces benches for.

### Files-in-this-commit
- agents/handoffs/WO-0080_tb-m04-first-bench.md

## [J-dv_lead-0175] 2026-08-11T09:28Z | task:WO-0080 | The M04 bench's first execution adjudicated against a table written before it: the red is a DESIGN defect at the one frame shape where REQ-206's window is provably empty, both bench-lane explanations excluded by derivation rather than by preference — and the crash text the run offered as an expectation refused in writing

### Trigger

Orchestrator dispatch. **No siblings.** The commission is a single adjudication:
`WO-0080`'s rev-B repair landed at `cbbeb76` (`J-tb_writer-0043`), the three
`Int.rem` substitutions cleared the compile, and CI `build` run **31476319884**
**executed `Run tests` against `Xgmii_tx_64` for the first time in this
programme**. The run is `failure`. Three things are asked: classify the red under
`WO-0080` §15's **pre-committed** disposition table; rule on the corrected-file
promotion block; route the outcome per the classification, one route and no
improvisation.

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # cbbeb76650f3b471d0ecc1bf85db4001cb907ec1
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched spawn-head `cbbeb76`, tree clean. Neither branch of
the abort procedure was reached.

**The standing fact that shapes this entry.** §15's table was written **before any
run existed**, and this seat refused once already to renegotiate it after seeing
which way it points. The entry below is written in the order the table demands —
classify, then route — and not in the order that would let a route be chosen and a
class fitted to it afterwards.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any write
  (§3's packet classes and the VERBATIM relay rule, §4's entry grammar, §4.2's
  set-equality, §6's write scopes, §10's independence and evidence rules).
- **`agents/handoffs/WO-0080_tb-m04-first-bench.md`** — §6.0 and §6.1 (the round's
  derived constants, `P = 1` row re-read cell by cell), §9.4 (the three underflow
  facts that bind the driver), §12 (the sixteen bars), §13 (the bounce
  conditions), **§15 (the disposition table, the subject of this round)**, §16.3,
  §19; the worker's rev-A and rev-B Return sections; my own `RV-0080-VERDICT`.
- **`docs/specs/requirements.md`** — REQ-206 (line 765, the underflow window,
  quoted verbatim in both artefacts I wrote), REQ-008 (line 649, both verification
  halves), REQ-016's own M04 carve-out (line 657), REQ-709/REQ-710 (the
  co-occurrence obligations a spurious pulse breaks), §0.6's **fourth clause**
  (lines 476–500, carry-forward `C-5`, closed 2026-08-11).
- **`docs/specs/modules/xgmii_tx_64.md`** at `ee47eee` — §2's not-my-job table,
  §3's REQ-016 row, §6.1 (the preamble word, `C + m + 2`, the padding rule, the
  minimum-frame cycle table), §6.2 (the `Preamble` row and the `Idle` row's second
  entry condition), §6.3 items 3 and 5, **§7** (the `C-16` bullet's four
  consequences, the reset clause, the handshake bullet), **§9** (the one strobe
  row, the pinned strobe cycle, the co-occurrence bullet), §10's REQ-206 and
  REQ-209 hooks, §11.3, §13's change log.
- **`test/attack_plans/AP-xgmii_tx_64.md`** — rows `M04-B4`, `M04-C2`, `M04-C5`
  (the three commissioned stimuli that carry `P = 1`), the whole of family G
  (`G1`…`G8`), §7 item `T-2`.
- **The landed bench at `cbbeb76`, read as a reviewer** — `test/xgmii_tx_64/bench.mli`
  in full, `bench.ml` (`create` `:43–76`, `sample_cycle` `:89–149`, `source_words`
  `:155–180`, `present` `:246–305`, `assert_instruments_clean` `:363–399`),
  `test_m04_b.ml` (U5, `:228–291`), `test_m04_c.ml` (U7 `:73–106`, U10 `:231–290`),
  and `test/monitors/strobe_monitor.mli`. **Stated for the independence record**:
  these are landed, reviewed DV artefacts and reading them is this seat's review
  duty; **no file under `libs/**`, `top/**`, `rtl_snapshots/**` or
  `test/third_party/**` was opened at any point in this round**, and every
  expectation adjudicated below is derived from the two specification documents
  above.
- **The CI run, read at the source rather than relayed.** `get_workflow_run`
  31476319884 (head_sha `cbbeb76…`, conclusion `failure`, `run_attempt` 1) and
  `get_job_logs` for job `build` id **93730745511**, full body.
- `docs/adr/ADR-0003`, `ADR-0005`, `ADR-0011`, `ADR-0018`; the promotion house
  rule as first stated in this chain at `claude_dv_lead_agent.v04.md` §4 of the
  entry quoted below.
- Prior entries: `J-dv_lead-0170` (§7's countersignature and `AP-M04-2`),
  `J-dv_lead-0173` (the fourth clause), **`J-dv_lead-0174`** (`RV-0080-VERDICT`,
  the bounce this round follows).

### Reasoning

**1. The extraction was verified, so it is evidence and not a relay.** The
dispatch offered an orchestrator extraction of the failure signature with
permission to treat it as a relay if the log could not be fetched. It could be:
job **93730745511**'s body was read whole. The three corrected hunks and their
failure strings are **byte-identical** to the extraction, and two facts the
extraction did not carry came out of the same read and matter to the
adjudication — the promotion block contains **exactly two** files, and inside
them **exactly three** corrected `%expect` blocks. That bounds what failed
without inferring it from what was reported.

**2. What that bound establishes, and one correction to the round's narrative.**
Files absent from the promotion block ran green: `test_m04_a.ml` and
`test_m04_scaffold.ml` entirely, and within the two touched files every block but
`B4/B5`, `C2` and `C5`. So **nine of the thirteen rows executed green** — `A1`,
`A2`, `A5`, `B1`, `B2`, `C1`, `C6`, `C3`, `C4` — at a stimulus set of exactly
`{P = 20, P = 60}`. The correction: **`P = 1` is the first member of all three
failing length lists**, and `List.iter` aborts at the first raise, so
`P ∈ {59, 61, 64, 67, 1514}` were **driven but never adjudicated**. "Every larger
member passed" is true only of `P = 20` and `P = 60`, in *other* units. I would
rather correct the sentence than inherit a wider claim than the log supports; the
narrower claim is also the more useful one, because it is what brackets the
defect (item 5).

**3. The classification, derived before it was routed.** `P = 1` means
`W = ⌈1/8⌉ = 1` source words, so the frame's **first** word **is** its `tlast`
word. REQ-206's window has two bounds and both are events, not cycle offsets:
open *after the start character has been emitted*, close *before the frame's
`tlast` word has been accepted*. The `tlast` word is accepted at `C`; SPEC-M04
§6.2 enters `Preamble` on the cycle a first word is accepted and emits the start
character at `C+1`. `C+1 > C`, so **the window is empty** — no cycle in a
one-word frame's life can satisfy REQ-206, **independent of `C` and independent of
`tready`**, since neither bound mentions `tready` and the handshake clause is a
conjunct inside a window that never opens. §7's `C-16` consequence 1 states the
same fact from the other side and I read it as it is written — over the **`tlast`
acceptance**, not over the number 8 that §6.1's `P = 60` table happens to give it:
*"this is the one cycle in a frame's life where `tx_tready` = 1 with
`tx_tvalid` = 0 means nothing at all."* At `W = 1` that cycle is `C+1`, which is
**also** the start-character cycle. **`W = 1` is the one frame shape at which §7's
silent cycle and §6.2's `Preamble` cycle collapse onto one another**, and that
collapse is the whole of this bug's surface.

**4. The wire corroborates, from assertions that had already passed.** Each of the
three units raises at `assert_instruments_clean`, which is the **last** call in
each row body — so at `P = 1` everything before it passed, in three independent
unit bodies: `Tx_decoder.is_clean` (checked at `bench.ml:364`, before the strobe
check at `:368`), exactly one completed frame, **64** wire octets, octets 0…59
equal to `pad_to_60(content)` (U5's prefix comparison; U7's and U10's explicit
all-`0x00` pad-region scans), terminate character at `C + 2 + ⌊64/8⌋ = C+10` in
lane 0 with its control bit set. REQ-206 is **one** `SHALL` binding the strobe to
a remedy — error character, terminate character, no FCS — and none of the remedy
appeared. So the design's two outputs contradict each other and at least one is
non-conformant; the window derivation says which. I recorded the missing remedy as
a **second** breach rather than as a mitigation: "the wire survived" is not
conformance, and a spurious strobe that *had* aborted would have destroyed a legal
frame.

**5. Both bench-lane mechanisms excluded by derivation, which is the part of this
round I was most obliged to get right**, because one of the two candidates is my
own instrument and the other is a worker's work I had just bounced.
**(b) the presenter**: `Bench.present` (`:246–256`) offers word `next` on every
cycle and advances only on acceptance; at `W = 1` there is **no second word in
existence** to withhold, and two guards would have fired first — the liveness
bound and `P-ACCEPT` (`:284–303`, accepted cycles must be exactly `[C]` at
`W = 1`). Neither fired. **(c) the strobe monitor**: its `expected = 0` is
`WO-0080` §1.2's own pre-commitment (family G excluded, every run presents every
word) **and** independently correct by item 3's derivation, so it is not resting
on a convention; and `high-cycles = 1 … observed: error_underflow@2` is a count of
high cycles on the design's output pin under convention `C-23`, sampled every
cycle — an observation, not a model. The only modelled quantity in the whole
instrument is the zero, and the zero is derived. **(a) the design** is therefore
sustained by elimination *and* independently by items 3 and 4, which is the
stronger position: I did not want a classification that rested on elimination
alone.

**6. §15 class D1, and the one strain in fitting it, stated rather than
smoothed.** D1 reads *"a row's assertion fails and this packet's derived constant
for it is right"*. The assertion that failed is obligation 4's **standing**
instrument check, invoked from inside each row's body under that row's id; its
"derived constant" is the empty expected-event set, which §9.4 item 2 derived from
§7 in advance. That is a row assertion in the sense that matters — it runs under
the row's id and its expectation is derived in the packet — and no other class
fits: D2 needs a non-empty `Tx_decoder.violations` and the decoder was clean; D3
needs `P-ACCEPT` to fire and it did not; D4a–d are the bench-seat classes and the
compile is green with nothing withheld and no `[%expect]` drift; D5 needs a
constant in dispute and §6.1's `P = 1` row is confirmed by the run. **D1, and D1
carries "no bounce" in the table's own Bounce column.**

**7. A gap in my own table, found by the case that did not happen.** §15's D2
names the **decoder** as the instrument-defect vehicle, and this round attaches
**two** standing instruments. Had candidate (c) been sustained, §15 would have had
no class for it — D2 names the wrong instrument and D4a–d would have routed a
dv-owned instrument defect to the worker's seat. **It did not fire, so it changes
no route, and I have deliberately not filled the gap now that I know which way the
result points** — that is the exact move §15 exists to prevent. Filed as
`FINDING WO-0080-5` (MINOR, mine) against the packet, with the repair stated for
the next packet that carries a §15 table: state the class over *"a standing
instrument"* rather than over one instrument's name.

**8. The promotion block, refused in writing.** The run printed `.corrected`
bodies whose new content is `[%expect.unreachable]` plus
`[@@expect.uncaught_exn {| … |}]` carrying this failure's message **and an OCaml
backtrace**. Promoting them would bake the crash text into the expectations and
turn a red suite green with the defect intact, and the backtrace would make the
expectation fragile against any line-number change besides. The house rule this
chain already carries, restated so no later round has to rediscover it: **a
`.corrected` carrying `expect.uncaught_exn` is never a promotion candidate; a
promotion candidate is printed data, an uncaught exception is a verdict.** I
stated it in **both** artefacts — the packet disposition §4 and `BUG-0004` §7
item 5 — because the next reader of either might be the one holding the promote
button, and the bug packet is the one that reaches rtl_lead.

**9. Severity, argued on both sides rather than asserted.** **MAJOR.** Not
CRITICAL: no octet on the wire is wrong, and the shape is **not reachable through
the Phase-1 composed chain** — M07 prepends 14 header octets (REQ-405), so the
shortest frame that can reach M04's source from the stack above is `W = 2`. Not
MINOR: SPEC-M04 places no lower bound on the source frame length (§2's not-my-job
table says *nobody* knows a length in advance, and REQ-203's pad rule is written
to reach any `P` below 60 — which is exactly why `AP-M04` rows `B4`, `C2` and `C5`
all commission `P = 1`), REQ-008's *"no strobe the stimulus did not create"* is
unconditional, REQ-804 aggregates this strobe into a host-visible status record,
and REQ-709's bench asserts one pulse of each per under-delivered frame — an
assertion a spurious pulse breaks. The single measurement that would convert it to
CRITICAL is `W = 2` also strobing, and `W = 2` is untested; I asked for it in the
re-test protocol rather than assuming either answer.

**10. What the selectivity brackets, and the neighbour a fix must not break.**
Adjudicated: `W = 1` strobes; `W = 3` and `W = 8` are clean. So the design is
**not** a naive reading of REQ-206 to its first full stop — that defect is
`M04-G4`'s and would have shown at `P = 60` too. It fails when the frame-opening
acceptance and the `tlast` acceptance are the **same** acceptance. The sharp
neighbour, and the reason `BUG-0004` §5 item 5 exists: at `P = 60` a word withheld
at `C+1` — the *same cycle offset* as this spurious strobe — **is** an underflow
and **must** pulse (`M04-G5`). The two cases sit one cycle offset apart with
opposite verdicts, so the condition has to be keyed on whether the `tlast` word
has been accepted and never on an offset from `C`. That is the most useful
sentence this packet can hand a fix and it is derived entirely from the plan and
the spec.

**11. What I refused to issue.** The rev-B `RV-` verdict. §15's D1 settles that
this red is not a bounce and settles nothing else; an ACCEPT is the separate act
§12's sixteen bars quantify, `M-2` reads a CI run that is `failure` at `cbbeb76`
(now for a design reason, which `BM1` does not reach), and `M-1`/`M-3`/`M-4`/`M-5`/`M-7`
have not been re-executed at this SHA. Ruling ACCEPT here would be the
improvisation the dispatch forbade in the same sentence that gave me the route.
Routed to the orchestrator as scheduling, with the explicit statement that nothing
in `BUG-0004` blocks it. I also moved **no** row status in `AP-xgmii_tx_64` and
opened **no** `SO-`: nine green rows are nine green rows, not coverage, and
`test/attack_plans/**` is outside this round's write set in any case.

### Actions

- Verified the spawn-head precheck; read the charter and PROTOCOL before writing.
- Fetched and read CI `build` run **31476319884** and job **93730745511** at the
  source; confirmed the handed extraction byte for byte and bounded the failing
  set from the promotion block's own contents.
- Derived REQ-206's window at `W = 1` from `requirements.md` and SPEC-M04 §6.1,
  §6.2, §7 and §9; cross-checked against §0.6's fourth clause; corroborated
  against the wire assertions that passed in three independent unit bodies.
- Excluded the presenter and the strobe monitor as candidate mechanisms by
  reading the landed bench and the committed monitor interface.
- Classified the red as **§15 D1** and authored
  `agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md`
  (MAJOR, `OPEN`, dv_lead → rtl_lead, VERBATIM relay).
- Appended `## DISPOSITION — dv_lead, 2026-08-11` to `WO-0080`'s verdict log:
  the rev-B repair proven effective by the run, the class table walked entry by
  entry, the route, the promotion prohibition, what the run did and did not
  establish, the `RV-` verdict explicitly **not** issued, and
  `FINDING WO-0080-5` against §15 itself.
- **No git write of any kind**: no `git add`, no `git commit`, no `git push`.
- **Nothing under `test/**`, `libs/**` or `docs/**` was staged, edited or
  created.** An adjudication judges; it does not repair the thing it judges.

### Evidence

**1. Precheck, at this seat.**

    git status --short              # zero lines
    git rev-parse HEAD              # cbbeb76650f3b471d0ecc1bf85db4001cb907ec1

**2. The CI run, externally verifiable.** `build` run **31476319884**,
`head_sha` `cbbeb76650f3b471d0ecc1bf85db4001cb907ec1`, branch
`claude/fpga-hardcaml-agent-orchestration-37ceyf`, `run_attempt` **1**, conclusion
**`failure`**, created 09:07:56Z. Job `build` id **93730745511**. The `Build` step
produced no error and `Run tests` executed — the first execution of this bench
against this design.

**3. The failure, verbatim from that job log** (un-escaped from the expect
machinery; identical at all three sites but for the row id):

```
(Failure
   "M04-B4/B5 (P=1): strobe monitor unclean:
  [M04 tx strobes] cycles=35 expected=0 high-cycles=1
    high cycles per strobe (C-23, never edges): error_underflow=1
    observed: error_underflow@2
    ERROR: cycle 2: M04 tx pulsed \"error_underflow\" and no expected event claims it — a strobe the stimulus did not create (requirements.md §0.6, REQ-008)")
```

Raise sites, from the same log's backtraces: `bench.ml:368` (characters 4–106) in
`assert_instruments_clean`, via `Base__List0.iter`, from `test_m04_b.ml:298`,
`test_m04_c.ml:112` and `test_m04_c.ml:288`.

**4. The promotion block's exact extent, measured from the log rather than
assumed.** Two `--- FILE` entries: `test/xgmii_tx_64/test_m04_b.ml` (sha256
`1178cec5680f4f7b74026a823a801aa4e7ad47d655eeb3da9b756eb70021333b`) and
`test/xgmii_tx_64/test_m04_c.ml` (sha256
`10e7d0b6a03518233e3be3e646095cb713fc6267c4c4f0961187ad64dad3d294`) — the
runner-local promoted bodies, which never entered history. Three corrected
`%expect` blocks in total, at `test_m04_b.ml` line 296 and `test_m04_c.ml` lines
110 and 286 of the pre-image. `test_m04_a.ml` and `test_m04_scaffold.ml` do not
appear at all.

**5. Nothing was promoted into the repository**, checked at this SHA:

```sh
sha256sum test/xgmii_tx_64/test_m04_b.ml test/xgmii_tx_64/test_m04_c.ml
# 465a8b911e8cbe187e35ad190aa8a1f107470da8155de88d0ca8d1d610c243f3  test/xgmii_tx_64/test_m04_b.ml
# f127ff136091df100b898339d06f259daedfe8849311d62a2340998b8c056cc9  test/xgmii_tx_64/test_m04_c.ml
grep -rc "expect.uncaught_exn\|expect.unreachable" test/xgmii_tx_64/
# 0 in all seven files
```

Both committed digests differ from the promoted ones in item 4, and no
`uncaught_exn` payload exists anywhere in the directory.

**6. The window derivation, reproducible from committed text alone.**
`requirements.md` REQ-206 (line 765): *"on any cycle **after** the transmitter has
emitted a frame's start character and **before** it has accepted that frame's
`tlast` word"*. `docs/specs/modules/xgmii_tx_64.md` §6.2 `Preamble` row: *"entered
when a first source word is accepted … emits the REQ-201 word"*; §6.1's table
places the preamble at `C+1` against an acceptance at `C`. `Bench.source_words`
cuts `content_octets ~p:1` into `⌈1/8⌉ = 1` word with `tkeep = (1 lsl 1) − 1 =
0x01` and `tlast = true`. Therefore, at `P = 1`: `tlast` accepted at `C`; start
character no earlier than `C+1`; window `(C+1, C]` — **empty**.

**7. The wire at `P = 1`, from assertions that passed before the raise.** U5:
terminate cycle `= C + 2 + ⌊F/8⌋` with `F = 64` → `C+10`; terminate lane
`= F mod 8` → 0; control bit set on that lane of that word; `List.length
frame.octets = 64`; `List.take octets (F−4) = pad_to_60(content_octets ~p:1)`.
U7: `List.length octets = 64`; `List.take octets 1 = content`; the 59-octet pad
region from index 1 all `0x00`. U10: accepted source word count `W = 1`;
terminate lane 0; 64 octets; prefix = content; pad region all `0x00`. All three
raised only afterwards, at `bench.ml:368`.

**8. The bench guards that did not fire, quoted by site.** `bench.ml:267–283`
(liveness bound, 16 cycles) and `bench.ml:284–303` (`P-ACCEPT`: accepted cycles
must equal `List.init w ~f:(fun m -> c + m)`, i.e. exactly `[C]` at `W = 1`).
Their silence is what excludes candidate (b) on evidence.

**9. The adjudicated-clean stimulus set, and the unadjudicated remainder.** Green:
U1, U2 (`P = 60`), U3 (`P = 60`), U4 (`P = 20`), U6 (`P = 20`), U8 (`P = 20`),
U9 (`P = 20`). Never adjudicated: every member after `P = 1` in
`[1; 20; 59; 60; 61; 64; 67; 1514]` (U5), `[1; 59; 60; 61]` (U7) and
`[1; 20; 59]` (U10) — driven, then abandoned by the `List.iter` at the first
raise.

**10. Independence.** `git status --short` at return lists exactly three paths:
`agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md` (new),
`agents/handoffs/WO-0080_tb-m04-first-bench.md` (modified), and this journal.
**No file under `libs/**`, `top/**`, `rtl_snapshots/**` or `test/third_party/**`
was opened in this round**, and nothing under `test/**`, `tools/**` or `docs/**`
was staged, edited or created.

### Outcome

**DoD for an adjudication round: met.**

- **Classification**: `WO-0080` §15 class **D1** — a **design** defect. Not a
  bounce. The competing bench-lane classes (D4b, D4d) and the instrument reading
  are excluded by derivation, each with its exclusion recorded.
- **Route**: `agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md`,
  **MAJOR**, `OPEN`, dv_lead → rtl_lead via the orchestrator, **VERBATIM** relay
  class (PROTOCOL §3). **The M04 era's first bug packet.** It carries the
  reproducing member and command at `cbbeb76`, the CI run and job ids, the
  emptiness derivation, both exclusions, the observables a fix must satisfy, the
  `M04-G5` neighbour a fix must not break, the severity argument with its
  reachability analysis, and the re-test protocol including the `W = 2` point.
- **Promotion**: **PROHIBITED**, stated in both artefacts, with the standing rule
  restated for later rounds and the non-promotion verified at this SHA.
- **Not issued**: the rev-B `RV-` verdict; any `SO-`; any `AP-xgmii_tx_64` status
  move; any claim about `P ∈ {59, 61, 64, 67, 1514}`; any statement about
  `tx_tready`'s value; any FCS claim at `P = 1`.
- **Findings minted**: `FINDING WO-0080-5` (MINOR, mine) — §15 has no class for a
  defect in a standing instrument other than the decoder. Recorded, not acted on,
  because it did not fire.
- **Handoff**: the two artefacts above, to the orchestrator, for commit and for
  verbatim relay of `BUG-0004` to rtl_lead.

**No harvest note is owed.** ADR-0018 attaches one to every `SO-` and every phase
gate, and this round is neither. The span tiles unbroken from `J-dv_lead-0174`
to the next sign-off, where the three-instance quantifier pattern
(`J-dv_lead-0174` Open-questions item 2) remains the carried candidate — now with
a second candidate beside it, item 3 below.

### Open-questions

1. **`W = 2` is untested and it is the measurement that sets this bug's true
   severity.** `W = 1` fails, `W = 3` and `W = 8` are clean, and the Phase-1
   composed chain cannot produce anything below `W = 2` (M07 prepends 14 header
   octets). If `W = 2` also strobes, `BUG-0004` converts to CRITICAL on
   reachability. **Route**: mine, as a bench point in the round that next opens
   `test/xgmii_tx_64/**` — and held over rtl_lead's fix return if that return
   claims a mechanism whose domain is wider than `W = 1`.
2. **`AP-xgmii_tx_64` has no row for the `W = 1` collapse**, and this is the
   defect the plan should have named before the bench found it incidentally.
   Family G's `M04-G4` names the cycle *after* the `tlast` acceptance at `P = 60`;
   nothing names the shape where that cycle **is** the start-character cycle.
   **The plan repair debt is now EIGHT**, all editorial or additive, all riding
   the round that next opens `test/attack_plans/**`: the seven at
   `J-dv_lead-0174` Open-questions item 3, plus a new family-G row for `W = 1`
   with `M04-G5` named as its opposite-verdict neighbour.
3. **A second harvest candidate, banked for the next `SO-`.** The rows that
   caught this defect (`B4`, `C2`, `C5`) were commissioned for the **pad**
   boundary, and the strobe that convicted the design was checked by a
   **standing** instrument attached to every elaboration rather than by any row's
   own assertion. Provisional observable: *a defect found by an instrument that
   runs on every stimulus, on a stimulus commissioned for an unrelated property,
   is evidence about the instrument's placement and not luck.* LH1's incident
   commit is `cbbeb76`; LH2/LH3 to be discharged at the next sign-off, where a
   second instance may exist to test the grade against.
4. **The rev-B `RV-` verdict on `WO-0080` is owed and unissued**, deliberately
   (Reasoning item 11). Nothing in `BUG-0004` blocks it. **Route**: orchestrator,
   as scheduling.
5. **Standing and untouched by this round**: `DVC-1a`; the M04 census in
   `tools/dv_checks.sh`; the transmit-side conservation monitor (`AP-M04` §7
   `T-2`); `AP-ip_eth_rx_64`'s `M14-F1`/`F2`/`F3`; the three `BAR T1` work orders;
   `FINDING ABS-1`'s §0.6 sentence (architect_docs_lead's to rule);
   `SO-xgmii_rx_64.md`'s Stage-3 gate table; family D as the next bench round.

### Files-in-this-commit
- agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md
- agents/handoffs/WO-0080_tb-m04-first-bench.md

## [J-dv_lead-0176] 2026-08-11T11:05Z | task:WO-0080 | Two acts on one green tree: BUG-0004 CLOSED on the one route measured end to end and explicitly NOT on the two derived ones, the W=2 conversion rule convicted as too wide and restated over the handover — and the rev-B ACCEPT paid at last, sixteen bars of sixteen, with the repeated instrument lapse ruled against my own uncured remedy rather than against the worker

### Trigger

Orchestrator dispatch. **No siblings.** One round, two acts, both of them acts I
deferred or owed: (1) the empty `## Fix verdict` section of
`BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md`, whose re-test protocol
at §8 I wrote and must now execute; (2) the rev-B `RV-` verdict on `WO-0080`,
which entry `J-dv_lead-0175` refused as a separate act because §12's bars had not
been re-executed and `M-2` read a `failure`. Plus the adjudication of the worker's
**second** instrument-lapse disclosure (`J-tb_writer-0043` Open-questions).

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # af06c623e4ea1ace45b2763d8c511649dedd338e
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched spawn-head `af06c62`, tree clean. Neither branch of
the abort procedure was reached.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any
  write (§3 packet classes and the VERBATIM relay rule, §4/§4.2 entry grammar and
  set-equality, §6 write scopes, §7's harvest clause, §10's independence and
  evidence rules).
- **`agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md`**,
  whole — my own §1–§8 and **rtl_lead's §9 response in full** (§9.1's mechanism
  and its cycle-by-cycle account against my own §1 stimulus, §9.2's fix
  expression and its difference analysis, §9.3's routes 2 and 3, §9.4's `W = 2`
  derivation, §9.5's structural argument and its snapshot prediction, §9.6's
  non-claims).
- **`agents/handoffs/WO-0080_tb-m04-first-bench.md`** — §2 (the thirteen rows and
  the corrected 11/2 split), §11.2, **§12 (the sixteen bars, re-read row by row
  before executing them)**, §13's `BM1`…`BM16`, §15, §17.1/§17.2/§17.3, §19.2,
  §19.3; both worker Return sections; my own `RV-0080-VERDICT` in full (its §1 bar
  tally as the method to repeat, §6's `BM16` ruling as the precedent I am now
  tested against, §8's re-issue terms as the promise to check) and the
  `DISPOSITION` section.
- **`agents/journals/workers/claude_tb_writer_agent.v03.md`** — `J-tb_writer-0043`
  whole: Trigger, Inputs (for `M-16`), Reasoning, and **Open-questions**, which is
  the disclosure adjudicated at §5 of the new verdict.
- **`agents/journals/claude_rtl_lead_agent.v02.md`** — `J-rtl_lead-0018` (its
  `#### Root cause` section, verified present for §8 item 4) and
  `J-rtl_lead-0019` whole (§4, §5's determinism watch stated **before** the run,
  the prediction grading, the "WHAT IS NOT CLAIMED" block, and its
  Open-questions 1–5).
- **`agents/handoffs/WO-0071_m03-family-m-co-occurrence.md`** — §17.1/§17.2/§17.3's
  standing form and `RV-0071-VERDICT` §3's conclusion about four self-caught
  disclosures and the unwritten spawn-prompt allow-list; the precedent this
  round's `BM16` ruling is framed by.
- **`test/attack_plans/AP-xgmii_tx_64.md`** — §1's Status vocabulary, §0.2's
  prohibition register, §4.A/§4.B/§4.C's thirteen commissioned rows, §9's change
  log; and `test/attack_plans/AP-xgmii_rx_64.md` §9's change-log tail, read for
  the *discharge-recording convention* this plan inherits.
- **The landed bench at `af06c62`**, read as a reviewer for the worker-seat bars:
  `test/xgmii_tx_64/bench.ml` (`sample_cycle` `:89–149`, `poison` `:41`,
  `content_octets` `:151`), `bench.mli`, `dune`, and the four unit files.
- **`.github/workflows/build.yml`** — the `Run tests` and determinism steps read
  in full, because the meaning of a green determinism step is load-bearing for
  both acts and I would not quote it without knowing what it runs.
- **`tools/dv_checks.sh`**, and its execution at this tree — the census keying,
  re-measured rather than recalled.
- **CI, read at the source rather than relayed**: `get_workflow_run` +
  `list_workflow_jobs` for runs **31482795659** (af06c62) and **31479688462**
  (02f762a), and the `build` job log tail at `af06c62`.
- **One RTL read, post-verdict, declared**: `git diff fcf6f08..02f762a -- libs/`.
  See Reasoning item 9.

### Reasoning

**1. The reading I was told and the reading I made — checked, not inherited.**
The dispatch stated that at `02f762a` the job "reached the determinism step, so
Run tests passed". That is an inference from step ordering and it happens to be
right, but I do not carry an inference where a direct reading exists (`SC-13`).
I listed the jobs of run **31479688462** and read step 6 by name: *"Run tests
(expect tests, waveform snapshots)" = `success`*, with the `failure` at step 8,
the determinism step, exactly where `J-rtl_lead-0018` §9.5 predicted the staleness
would land. The direct reading and the inference agree; the direct reading is what
I cite.

**2. The fact that turns a green suite into evidence about a *specific* bench,
and it is the load-bearing measurement of this whole round.** `git diff cbbeb76
af06c62 -- test/` is **empty**. The seven files under `test/xgmii_tx_64/` are
byte-identical between the SHA at which three units raised and the SHA at which
none does. Without that measurement, "the suite is green now" is compatible with
"the bench was changed until it stopped complaining" — which is precisely the
failure mode `BUG-0004` §8's closing rule and §7 item 5's promotion prohibition
exist to prevent. With it, the red and the green are **one instrument reading two
designs**, which is the only shape in which a re-test proves a fix. I also
measured the other half at the fix commit itself: `git diff --name-only fcf6f08
02f762a -- test/` is empty, so no `test/**` file was touched by the fix.

**3. `CLOSED`, and the exact scope of what is closed.** §8's four items are met
(verdict §10.1). Item 2 is the largest evidentiary movement and it is worth
naming: a green `dune runtest` requires each unit's `List.iter` to run to its last
member, so `P ∈ {20, 59, 60, 61, 64, 67, 1514}` in U5, `{59, 60, 61}` in U7 and
`{20, 59}` in U10 — the members `J-dv_lead-0175` recorded as *driven but never
adjudicated* — are now driven **and read**. Item 4 is met in the narrow sense the
charter states: I verify a Root-cause section **exists** (`J-rtl_lead-0018`'s
`#### Root cause`), not that its mechanism is correct — adjudicating a design
mechanism is not this seat's act, and saying so is what keeps the division real.

**4. `W = 2` — the disposition, and why I convicted my own conversion rule rather
than answer its question.** §6 said the CRITICAL converter is *"a demonstration
that `W = 2` also strobes"*. rtl derives two things: on the round's stimulus shape
`W = 2` is clean in **both** designs (so no measurement there can convert
anything, in either direction), and route 3 **is** a `W = 2` strobe in the unfixed
design (so read literally, the converter exists). Both halves are true, which is
the tell that the question was malformed. **The mechanism does not turn on a word
count; it turns on whether the frame's `tlast` word is already in the module's
hands at the cycle the frame starts.** `W = 2` was a proxy for reachability and it
is the wrong proxy. What actually protects the composed chain is SPEC-M04 §7's
own note that M07 presents nothing at `C+8`, so the early acceptance both routes
require is not produced upstream at all. **§6's conclusion survives; its ground
does not, and I recorded the substitution rather than letting a later reader
re-derive the protection from the premise that broke.** Filed as
`FINDING BUG-0004-1` (MINOR, mine). Severity stays MAJOR and does not convert.

**5. The residue, and the symmetry I applied against myself.** rtl cited my own
`BUG-0003` §V.2 back at me — *a derivation is not a class DV records a severity
on* — and it is right to. **The symmetric half is the one that binds this seat: a
derivation is not a class DV records a *clearance* on either.** So `CLOSED` is
closure on **route 1**, measured end to end. Routes 2 and 3 are fixed **by
derivation** and have never been measured, in either design, and the closure does
not claim them. I could have written a clean `CLOSED` that quietly absorbed them —
that is exactly how a fixed-by-derivation defect becomes a sign-off's silent
assumption — so instead the packet's header, its §10.3 and its §10.4 carry them
out of the closure with carriers named, and the eventual `SO-` is barred from
reporting REQ-206 coverage without either measuring them or declaring them a gap
with this packet's id.

**6. Where the two routes are routed, and why not to a future family.** Not AP
rows today (I cannot author rows this round and did not). Not "family G will pick
them up" — family G's rows assert what **must** pulse, and these assert what must
**not**, on a shape no committed bench can drive: a back-to-back direct-drive
handover at `C+8`. REQ-209's sustained run does not reach it either, its frames
being `W = 8`. **They need a capability that does not exist**, so writing them
into a family without it would produce rows that cannot be mounted, which is what
`GAP` is for and is not what these are. Hence: two new family-G rows as plan debt
(**debt count EIGHT → NINE**), a carried verification obligation, and a hard
precondition on the `SO-`. Three routings for one finding, because it is three
different kinds of thing.

**7. A carrier failure mode this round found by nearly falling into it.** The
`AP-M04` repair debt's carrier has read *"the round that next opens
`test/attack_plans/**`"*. This round opens that file — for one change-log row.
**A carrier phrased over a path is discharged by accident the first time a round
opens that path for an unrelated reason**, and nobody would ever notice, because
the debt's own carrier would read as satisfied. Re-pinned to *"the round
commissioned to repair this plan"*, and the debt restated at nine so it is counted
rather than inferred. Banked as a harvest candidate (Open-questions item 4).

**8. The rev-B ACCEPT, and why `M-2` passes rather than being waived.** All
sixteen bars re-executed at the base each subject quantifies over (`FINDING K-3`
again — `ee47eee` is now twelve commits back and a literal diff to it would read
nine foreign paths as the worker's). `M-2` is the bar that failed twice and it is
the one I was most at risk of fudging. Its pass condition is *a step reading by
name and status*, plus the routing rule *a red at "Run tests" is routed through
§15, never through a re-run*. I record **both** readings rather than only the
convenient one: at `cbbeb76`, Build `success` / Run tests `failure` / Verify
`skipped`, with the red routed through §15 as D1 to `BUG-0004` at `run_attempt` 1;
at `af06c62`, all three `success` on a byte-identical bench. The bar is satisfied
by its own text at the first reading and demonstrated by the second. **16 PASS, 0
FAIL**, no `BM1`–`BM15` reached.

**9. One RTL read, and it is a departure I will not bury in a subclause.** I read
`git diff fcf6f08..02f762a -- libs/`. `BUG-0004` was authored without opening any
`libs/**` file and every expectation in it is spec-derived; this read is
**post-verdict** and its sole purpose was **scope**: that one expression moved,
that no `test/**` file did, and that the promotion commit `af06c62` changed no
source (`git diff --stat 02f762a af06c62 -- libs/ bin/` empty). No expectation was
derived from it and none was revised after it. Declared in the packet's §10.1 and
here, per charter §8's independence discipline, which asks for exactly this
statement rather than for the read not to happen.

**10. The census, re-measured because §9.7's finding became load-bearing the
moment I quoted a count.** My own `L-B01` rule is that a count is quoted with its
provenance or not at all. Measured at `af06c62`: `tools/dv_checks.sh` contains
**zero** occurrences of `M04`, `xgmii_tx_64` or `AP-xgmii_tx`; its row-discharge
census is keyed to `AP-xgmii_rx_64.md`/`M03-`/`test/xgmii_rx_64/*.ml` and reports
78 rows (M03's, not M04's 80); its per-file bench inventory reports 59 over the
M03 directory. **Exactly one census figure moved on this round** — the
repository-wide inventory line, **149**, agreeing with my own `M-3` measurement.
So `dv_checks: all checks passed` at this tree says **nothing** about M04, and
every M04 count in both artefacts is a hand count with a named method. §19.3 item
1 is promoted from "owed" to "the difference between a countable coverage claim
and a hand count in a packet".

**11. `BM16`'s second occurrence, ruled against my own uncured remedy.** The
condition is met again by admission, and the pattern repeats rather than corrects
— including the sharpest instance, a post-edit `git status --short`, the one
instrument §17.3 forbids **by name**, run after the packet had been read, in a
round whose entire dispatch was the repair of a round whose instrument finding the
worker had already read. **And then I measured what I myself had promised.** Every
packet repair `RV-0080-VERDICT` §8 undertook to ride rev B is **absent**: §12
stops at `M-16` with no `M-17`; §17.1 still forbids every `git` subcommand with no
spawn-precheck carve-out; §4/§6.0(b) carry no `Int.rem` gloss. Those were **my**
edits to **my** packet, no round was commissioned to make them, and `PROTOCOL §6`
made them impossible for the worker — which it said, in its §7, rather than
assuming or reaching. So the worker met the forced precheck conflict **uncured**,
at a spawn where the orchestrator's standing precheck mandates the two commands
§17.1 forbids. **That is the case my own rev-A ruling said must not recur, and it
recurred because I did not pay it.** Filed as `FINDING WO-0080-6` (MATERIAL,
mine), stated *before* the `BM16` ruling in the packet so the ruling is read
against it.

**12. Why not a bounce, expressed as a limit on my instrument rather than as
leniency.** Bouncing rev B on `BM16` would return a bench CI has now proven
correct against the fixed design, with a defect list containing nothing the worker
could repair. **A bounce whose defect list is empty of anything the returning
agent can act on is not a bounce; it is a sanction wearing a bounce's clothes**,
and neither §13 nor §15 gives me that instrument. The three measured grounds hold
as at rev A — no forbidden path (`M-16`), no bar resting on a forbidden instrument
(I re-executed `M-8`…`M-16` myself and every figure agrees), and §17.3's
substitution clause **held on its output** even though the forbidden command was
run: `J-tb_writer-0043`'s five-path files list is set-equal to
`git diff --name-only 895a076 cbbeb76` minus the worker's journal, and
`journal-check` re-verified it. So the ruling's content lands **upward**, per
`RV-0071-VERDICT` §3's own conclusion that this is not a comprehension failure
clearer prose fixes: the untried remedy is the enumerated tool allow-list at the
head of the spawn prompt, the orchestrator's, still unwritten. **And I
pre-committed the tripwire** so this does not become an indefinite waiver: once
that allow-list exists **and** §17.1 carries the carve-out, the next instance is a
bounce on its own — written as the *next* packet's §13 term, before its facts
exist, never applied retroactively.

**13. The count I refused to state cleanly.** `RV-0071-VERDICT` tallied "four
instances across four rounds". Adding the two I read myself gives six. I have
**not** re-measured the four, so the packet says *"at least six — four from that
verdict's own tally, which I have not re-measured and quote with its provenance,
plus the two I read myself"*. A tidier number was available and would have been
unsourced.

**14. What moves in the plan, and the reading behind it.** The dispatch's write
set admits `AP-xgmii_tx_64.md` *"ONLY if row statuses move on an ACCEPT — your §9
change-log discipline"*. The plan's own §1 makes `Status` a row **kind**
(`ASSERT`/`NO-ASSERT`/`NO-STIMULUS`/`RULING`/`GAP`/`STRUCTURAL`), never a
discharge state, and `AP-M03`'s change log records every discharge under its
standing *"NO STATUS MOVED"* formula. **So no `Status` cell moves and the
discharge is recorded where this plan's predecessor records it: one appended §9
change-log row.** I state the reading rather than acting on it silently, and the
row is **severable** — if the orchestrator reads the gate as hard, dropping that
one file leaves the two packets standing unaltered. Nothing else in the plan
moved: status-cell pass run **before and after** the edit, both times 80 rows,
56 ASSERT / 12 NO-ASSERT / 6 NO-STIMULUS / 5 STRUCTURAL / 1 GAP / 0 RULING.

### Actions

- Verified the spawn-head precheck; read the charter and PROTOCOL before writing.
- Read CI runs **31482795659** (af06c62) and **31479688462** (02f762a) at the
  source — run objects, job listings with **per-step name and status**, and the
  `build` job log tail at `af06c62`.
- Re-executed **all sixteen** `WO-0080` §12 bars at `af06c62`, each at the base
  its own subject quantifies over, including every worker-seat bar
  (`M-8`…`M-16`) independently at the tree.
- Measured the fix's scope from `git diff fcf6f08..02f762a` (three paths, none
  under `test/`) and the bench's invariance from `git diff cbbeb76 af06c62 --
  test/` (empty).
- Re-measured the census keying and ran `bash tools/dv_checks.sh` at this tree.
- Ran a status-cell pass over every `AP-M04` row table, before and after the edit.
- Wrote the **`Fix verdict`** section of `BUG-0004` (`CLOSED`) with §10.1–§10.6,
  and flipped its State `OPEN` → `CLOSED` with the two surviving obligations named
  in the header.
- Appended **`RV-0080B-VERDICT`** (`ACCEPT`) to `WO-0080` with the sixteen-bar
  tally, the thirteen discharged rows, the census provenance, `FINDING WO-0080-6`,
  the `BM16` adjudication and its tripwire; flipped the header State to
  `ACCEPTED` keeping the prior chain visible.
- Appended **one** row to `AP-xgmii_tx_64.md` §9's change log.
- **No git write of any kind**: no `git add`, no `git commit`, no `git push`.
- **Nothing under `libs/**`, `top/**`, `rtl_snapshots/**`, `docs/**` or
  `tools/**` was staged, edited or created**, and no bench file was touched — a
  re-test judges; it does not repair what it judges.

### Evidence

**1. Precheck, at this seat.**

    git status --short              # zero lines
    git rev-parse HEAD              # af06c623e4ea1ace45b2763d8c511649dedd338e

**2. CI, externally verifiable, read by step name and status.**
`build` run **31482795659**, `head_sha` `af06c62…`, `run_attempt` **1**,
conclusion **`success`**, created 10:34:18Z. Job `build` id **93751338432**:
step 5 *Build* `success`; step 6 *Run tests (expect tests, waveform snapshots)*
`success`; step 7 *Generate RTL* `success`; step 8 *Verify nothing was left
unpromoted or non-deterministic* `success`; step 9 *DV mechanical checks* `success`;
step 10 *Abort-bit availability quantifier* `success`. Job `cosim` id
**93751338523**: all steps `success`.
`build` run **31479688462**, `head_sha` `02f762a…`, conclusion **`failure`**,
`run_attempt` **1**. Job `build` id **93741536143**: step 5 *Build* `success`;
**step 6 *Run tests* `success`**; step 7 *Generate RTL* `success`; **step 8
*Verify nothing was left unpromoted or non-deterministic* `failure`** — the
scheduled staleness, not a second defect.
`build` run **31476319884** at `cbbeb76` (the rev-B landing): Build `success`,
Run tests `failure`, Verify `skipped` — the reading `RV-0080B-VERDICT` §1's `M-2`
records as Reading A.

**3. The bench is byte-identical across the red/green boundary.**

```sh
git diff --stat cbbeb76 af06c62 -- test/     # empty
git diff --name-only fcf6f08 02f762a         # 3 paths: BUG-0004, rtl_lead journal,
                                             #   libs/hardcaml_ethernet/src/xgmii_tx_64.ml
git diff --name-only fcf6f08 02f762a -- test/ # empty
git diff --stat 02f762a af06c62 -- libs/ bin/ # empty
```

**4. The sixteen bars, re-executed at `af06c62`.**

```sh
# M-1
git diff --name-only 747e561 960c831   # 9 paths
git diff --name-only 895a076 cbbeb76   # 6 paths
# M-3 (base re-measured in a scratch tree)
git archive ee47eee test | tar -x -C "$S/base_ee47eee"
(cd "$S/base_ee47eee" && grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .)  # 139
grep -rh --include=*.ml 'let%expect_test' test/ | grep -c .                            # 149
# M-4 / M-5
git ls-files test/xgmii_tx_64/                        # 7 paths
git diff --stat ee47eee af06c62 -- test/xgmii_rx_64/  # empty (17 files tracked)
# M-7
grep -roh --include=*.ml 'M04-[A-Za-z0-9]*' test/ | sort | uniq -c
#   -> 13 commissioned ids + 2 bare `M04-` (scaffold's own negation); zero others
# M-10 / M-11 / M-12
#   scaffold 1, a 1, b 3, c 5; 10 `[%expect {||}]`, all empty, 11th hit is dune prose
#   10 `=` lines alone: a:101 b:129,215,297 c:64,111,174,223,287 scaffold:66
# M-13 / M-14
grep -rn 'tready' test/xgmii_tx_64/   # bench.ml:108,133,135,139 + 6 bench.mli prose; zero in test_m04_*.ml
grep -rn 'poison' test/xgmii_tx_64/*.ml | head -1   # bench.ml:41  let poison = 0xA5
# M-15
for f in test/xgmii_tx_64/*.ml*; do ocamlc -stop-after parsing "$f"; done   # exit 0 x6
```

Per-directory census at `af06c62` summing the `M-3` delta: `axi64_probe` 3,
`cosim` 0, `golden` 11, `hardcaml_ethernet` 1, `monitors` 37, `xgmii` 25,
`xgmii_probe` 3, `xgmii_rx_64` 59, `attack_plans` 0, `third_party` 0 = **139**;
`xgmii_tx_64` **10**; total **149**.

**5. The census, measured rather than recalled.**

```sh
grep -c 'M04\|xgmii_tx_64\|AP-xgmii_tx' tools/dv_checks.sh   # 0
bash tools/dv_checks.sh
#   row-discharge census: "78  row ids declared in the plan"   <- AP-M03's, not M04's 80
#   bench inventory:      " 59  test/xgmii_rx_64/ (the M03 bench)"
#                         "149  test/**/*.ml (repository-wide, FILE-TYPE scoped)"
#   "dv_checks: every check that COULD run passed, and 1 obligation is still OPEN"
```

**6. The status-cell pass over `AP-M04`, before and after the edit** — both
times: 80 row ids (80 distinct), **56 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5
STRUCTURAL, 1 GAP, 0 RULING**.

```sh
grep -oE '^\| \*\*M04-[A-Z][0-9]+\*\*.*\| (ASSERT|NO-ASSERT|NO-STIMULUS|RULING|GAP|STRUCTURAL) \|$' \
  test/attack_plans/AP-xgmii_tx_64.md \
  | grep -oE '\| (ASSERT|NO-ASSERT|NO-STIMULUS|RULING|GAP|STRUCTURAL) \|$' | sort | uniq -c
```

**7. The promised rev-B packet repairs, measured absent at `af06c62`.**
`grep -n 'M-17' agents/handoffs/WO-0080_tb-m04-first-bench.md` returns three hits,
**all three inside `RV-0080-VERDICT` §3.1/§8 and the worker's own flag** — §12's
table stops at `M-16`. §17.1 at lines 1512–1535 still reads *"`git` (every
subcommand, including read-only ones such as `status`, `diff`, `show` and
`log`)"* with no spawn-precheck carve-out.

**8. The worker's files list, independently checked.** `J-tb_writer-0043`'s
`Files-in-this-commit` lists five paths; `git diff --name-only 895a076 cbbeb76`
returns those five plus `agents/journals/workers/claude_tb_writer_agent.v03.md`
— set-equal under PROTOCOL §4.2, and re-verified by `journal-check` at that
commit.

**9. The determinism datapoint, measured at this tree.** Committed digests
`sha256sum rtl_snapshots/xgmii_tx_64.v rtl_snapshots/eth_mac_10g.v` →
`27cb8ebe…ee85` and `6735d092…02ac`, the two shas `J-rtl_lead-0019` §5 named in
advance; run 31482795659's step 8 regenerated and found no diff, with
`git diff --stat 02f762a af06c62 -- libs/ bin/` empty. `.github/workflows/build.yml`
read: the step generates **once** and compares against the committed tree, so this
is cross-run identity between two commits and **not** a double-generation check.

**10. Independence.** `git status --short` at return lists exactly four paths:
`agents/handoffs/BUG-0004_…md`, `agents/handoffs/WO-0080_…md`,
`test/attack_plans/AP-xgmii_tx_64.md` and this journal. **One `libs/**` read
occurred and is declared** (Reasoning item 9): `git diff fcf6f08..02f762a --
libs/`, post-verdict, for fix scope only. No file under `top/**`,
`rtl_snapshots/**` or `test/third_party/**` was opened.

### Outcome

**DoD for a two-act adjudication round: met.**

- **`BUG-0004` — `CLOSED`**, one token, per the packet's own grammar. §8's four
  re-test items executed; the fix's scope measured; the bench proven invariant
  across the red/green boundary. **`W = 2`**: §6/§8's condition **discharged** on
  a **replaced ground** (SPEC-M04 §7's `C+8` note, not the word count), severity
  stays **MAJOR**, `FINDING BUG-0004-1` minted against my own conversion rule.
  **Routes 2 and 3**: a **carried obligation** plus **plan row debt** (EIGHT →
  NINE) plus a **hard `SO-` precondition** — not discharged, not a future
  family's to inherit by silence, carriers named at §10.4. **rtl's non-claims**:
  three dispositioned, one (REQ-902's two-run byte identity) **superseded by one
  measured datapoint** and routed back to rtl_lead as its requirement.
- **`WO-0080` rev B — `ACCEPT`**, one token. **16 of 16 bars PASS**, each at the
  base its subject quantifies over; no `BM1`–`BM15` reached. **Thirteen rows
  discharged** — eleven ASSERT by green assertion, two NO-ASSERT by prohibitions
  that held. **67 of 80 outstanding**, `BAR T1` SHUT, no `SO-`, `M04-G4` not
  discharged. The PROTOCOL §10 mutation campaign's sequencing precondition is now
  **met**; scheduling is the orchestrator's and my recommendation is the
  per-family cadence.
- **`BM16`, second occurrence** — accept, disclosure credited in full, **no
  sanction**, finding **escalated** to structural and routed to the orchestrator
  (the unwritten spawn-prompt allow-list), with `FINDING WO-0080-6` (MATERIAL,
  mine) recording that my own rev-A remedy was never applied, and a **tripwire
  pre-committed** for the next packet.
- **Plan**: one §9 change-log row, no `Status` cell, no coverage-map line, no
  editorial repair. Severable from the rest of the commit.
- **Handoff**: three artefacts to the orchestrator for commit; `BUG-0004`'s
  closure is **VERBATIM** relay class to rtl_lead (PROTOCOL §3).

**No harvest note is owed.** ADR-0018 attaches one to every `SO-` and every phase
gate; this round is neither. The span tiles unbroken from `J-dv_lead-0174` through
this entry to the next sign-off, where three banked candidates now wait
(Open-questions item 4).

### Open-questions

1. **Routes 2 and 3 of `BUG-0004` are fixed by derivation and have never been
   measured, in either design.** The shape needs a direct-drive back-to-back bench
   with a controllable handover at `C+8` — a capability no round has built and
   that family D does not require. **Route**: mine, the round that first opens
   such a bench; and it is a **hard precondition** on any `SO-xgmii_tx_64.md`
   claiming REQ-206 coverage (`BUG-0004` §10.3 item 3). `M04-G5`, §5 item 4's
   opposite-verdict neighbour, is in the same condition and rides the same
   carrier.
2. **The `AP-M04` repair debt stands at NINE and its carrier is re-pinned** from
   *"the round that next opens `test/attack_plans/**`"* to *"the round
   commissioned to repair this plan"* — because this round opened that path for a
   change-log row and would otherwise have discharged the carrier by accident.
   The two new rows are the `W = 1` collapse and the pre-loaded handover.
3. **Six packet repairs I promised at `RV-0080-VERDICT` §8 were never made**
   (`FINDING WO-0080-6`, mine): the `M-17` infix-`mod` bar, §17.1's spawn-precheck
   carve-out, the `Int.rem` gloss at §4/§6.0(b), the read-list row, §16.3's
   operator clause, §3.4's/§3.6's wording. `WO-0080` is now `ACCEPTED` and closed
   to further terms, so they are **re-pinned to the next packet this seat writes
   for the `tb_writer` chain**, together with the `BM16` tripwire and
   `FINDING WO-0080-5`'s §15 instrument-class repair. **The structural half —
   the enumerated tool allow-list at the head of the spawn prompt — is the
   orchestrator's and remains unwritten since `RV-0071-VERDICT` §3.**
4. **Three harvest candidates banked for the next `SO-`.** (a) Carried from
   `J-dv_lead-0175`: *a defect found by an instrument that runs on every stimulus,
   on a stimulus commissioned for an unrelated property, is evidence about the
   instrument's placement and not luck* — LH1 `cbbeb76`, and this round supplies
   its second instance in the same instrument's silence at `af06c62`. (b) New:
   *an obligation whose carrier is phrased over a file path is discharged by
   accident the first time a round opens that path for an unrelated reason; a
   carrier must name the commissioning act, not the artefact* — LH1 this round.
   (c) New: *a re-test proves a fix only if the instrument is measurably unchanged
   between the failing and passing observations; without that measurement, "it is
   green now" is compatible with the instrument having been edited until it
   stopped complaining* — LH1 `cbbeb76`→`af06c62`. LH2/LH3 to be discharged at the
   next sign-off.
5. **`tools/dv_checks.sh` still cannot count an M04 row** (§19.3 item 1, measured
   again at `af06c62`). Every M04 count in this round's artefacts is a hand count
   with its method stated. **Mine**, `tools/**`, and it should land before any
   `SO-` quotes an M04 coverage fraction; `DVC-1a` remains wanted by three plans.
6. **Standing and untouched by this round**: the transmit-side conservation
   monitor (`AP-M04` §7 `T-2`); `AP-ip_eth_rx_64`'s `M14-F1`/`F2`/`F3`; the three
   `BAR T1` work orders; `FINDING ABS-1`'s §0.6 sentence (architect_docs_lead's);
   `SO-xgmii_rx_64.md`'s Stage-3 gate table; family D as the next bench round, now
   unblocked.

### Files-in-this-commit
- agents/handoffs/BUG-0004_m04-underflow-strobe-on-a-single-word-frame.md
- agents/handoffs/WO-0080_tb-m04-first-bench.md
- test/attack_plans/AP-xgmii_tx_64.md

## [J-dv_lead-0177] 2026-08-11T12:40Z | task:none | The repair round my own carrier named: the walk that was supposed to pay a debt of nine found the count had double-counted its own change-log row, and the sibling plan's stale ASSERT came with a third defective clause and a spec conflict nobody had reached

### Trigger

Orchestrator dispatch. **No siblings.** The commission is the round entry
`J-dv_lead-0176` re-pinned this plan's debt to — *"the round commissioned to
repair this plan"* — after finding that a carrier phrased over a **path** would
have been discharged by accident by a round that opened `test/attack_plans/**`
for one unrelated change-log row. This is that round: the accumulated editorial
repairs to `AP-xgmii_tx_64`, `BUG-0004`'s routes 2 and 3 as plan representation,
`FINDING BUG-0004-1`'s restatement, the §9 change-log discipline on every edit,
and — my call, taken — the stale `AP-M14` family-F rows recorded at
`J-dv_lead-0170`.

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # 8ff1b20b965e7a79b5e6bc2eeef16b7dc6fb269e
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched spawn-head `8ff1b20`, tree clean. Neither branch of
the abort procedure was reached.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any write
  (§3 packet classes, §4/§4.2 entry grammar and set-equality, §6 write scopes, §7's
  harvest clause, §10's independence and evidence rules; charter §8's attack-table
  rule, which is why §5 of the plan gains rejections in the same act as the rows).
- **My own entries, walked rather than summarised** — this is the census the
  dispatch asked for: `J-dv_lead-0171` (v08, its Reasoning items 5, 11, 13 and
  Open-questions 2 and 4), and in v09 `J-dv_lead-0172` (Open-questions 2),
  `J-dv_lead-0173` (§(c)'s three checks, the `ABS-1` filing, Open-questions 1–2),
  `J-dv_lead-0174` (Reasoning on `M04-B1`, Open-questions 2–3), `J-dv_lead-0175`
  (Open-questions 1–2), `J-dv_lead-0176` (Reasoning 4–7, Outcome, Open-questions
  1–6). `J-dv_lead-0170` §(d) for the `AP-M14` rows.
- **`test/attack_plans/AP-xgmii_tx_64.md`** whole, at the sites the walk names:
  the header carry-forward bullet, §0.1's three standing rules, §0.2's register,
  §1's status vocabulary and its permanence rule, §2's seven obligations, §4.B,
  §4.C, §4.G, §4.J, §5, §6 and §6.1 (including running its own quoted homing
  command), §7's machinery table, §7.2, §8, §9's two rows.
- **`test/attack_plans/AP-ip_eth_rx_64.md`** §4.F, §6, §7, §8, §9.
- **`agents/handoffs/BUG-0004_…md`** §6, §9.3, §9.4, §10.2, §10.3, §10.4 — read
  for the two routes' exact cycles and for the carrier table's own terms.
- **`agents/handoffs/WO-0080_tb-m04-first-bench.md`** §3.1, §3.2, §3.3, §6.0(c),
  §6.3 — the operational cures whose plan-side text this round owes.
- **Specifications, at the source and not through the packets that quote them**:
  `docs/specs/requirements.md` §0.6 (all four reference-word clauses and both
  closing notes), REQ-210 as repaired, and §13's rows for REQ-210, §0.5 and §0.6;
  `docs/specs/modules/ip_eth_rx_64.md` §5's `ip_hdr_valid` record row, §6.1's
  gapped paragraph and its lead paragraph, §7 entire (the latency bullet, the
  parse-latency bullet, the handshake bullet **and its per-output-event table**),
  §8's stress paragraph, §9's pinned strobe cycles, §10's REQ-016/REQ-606/REQ-611
  hooks, §13's 2026-08-11 rows.
- **Two files of my own DV tree, read post-verdict as a reviewer, for two
  capability measurements and nothing else**: `test/xgmii_tx_64/bench.ml`
  (`assert_instruments_clean` `:363–397`) and `test/xgmii_tx_64/test_m04_b.ml`
  (`:225`). **No `libs/**`, `top/**` or `rtl_snapshots/**` file was opened at this
  round, at all** — every expectation written below is spec-derived.

### Reasoning

**1. The walk is the census, and the walk corrects the census — which is the
first thing I did not expect to find.** The dispatch said nine and told me to
walk. Walking gives: four at `J-dv_lead-0171` (the poison quantifier, `M04-J3`'s
quotation, `C-5`'s superseded deferral, the §9 landed-status row), a fifth at
`J-dv_lead-0173` (`M04-G7`'s ground), **two** at `J-dv_lead-0174` (`M04-B1`'s
quantifier **and "the §9 change-log row"**), an eighth at `J-dv_lead-0175` (the
`W = 1` row) and a ninth at `J-dv_lead-0176` (the pre-loaded-handover row). **The
§9 change-log row is in the list twice.** Its second appearance is followed by
the clause *"whose landed-status figure must record **zero** rows discharged at
`960c831`, not thirteen"* — which is a correction to the content of the row
already in the list, not a second obligation. So the distinct census is **eight**,
of which the landed-status row was paid at `J-dv_lead-0176`. I could have paid
nine things and reported nine; instead the count is corrected in the plan's own
change-log row with the quotation that convicts it, because **a debt total
maintained across rounds is a claim like any other and my own `L-B01` says a count
is quoted with its provenance or not at all**. And I checked the one place where
being wrong would matter: `BUG-0004` §10.4's trip condition is *"a plan round that
pays eight and not nine has missed this packet"*, and its item is the **two new
family-G rows** — both land, so the condition is met on its own terms rather than
on the arithmetic I just corrected.

**2. One repair I paid that nobody enumerated, and the reason is a document-level
one.** `M04-J3`'s stale quotation was the enumerated item; §8 item 1 — which still
routed `FINDING AP-M04-1` as an **open** question to architect_docs_lead — was
not. Curing the row and leaving the finding open two sections later leaves the
document at odds with itself, and the next reader resolves that by trusting
whichever site they read first. Both are the same finding's sites, so both move,
and the change-log row says so rather than letting the extra edit look like scope
drift. The same logic made `C-5` a **four**-site repair (header bullet, §0.2 item
3, §2 obligation 5, §8 item 3) rather than the two the entries named: I found the
other two by reading for the string, not by remembering.

**3. Struck, never deleted — and this is the discipline the whole round runs on.**
Every repaired ground keeps the sentence it replaces, marked struck and dated, in
place. Two reasons, and the second is the one I would defend at audit: a reader
who arrives with the old sentence in hand needs to find it and see it convicted,
and **a document that silently repairs itself makes its own findings
uncheckable** — `FINDING ABS-1` convicts `M04-G7`'s exact words, and deleting them
would leave the finding pointing at nothing. This is `J-dv_lead-0171`'s §19.1
discipline and `J-dv_lead-0174`'s strike-don't-replace ruling applied to my own
plan instead of to a packet.

**4. `ABS-1`, and the asymmetry I kept.** The plan row is **mine** and is repaired
here; the same misreading in requirements.md §0.6's fourth clause is
**architect_docs_lead's** and is not. So `M04-G7` now rests on what the clause
*does* — it gives this strobe a reference word at the required-and-not-presented
cycle, ceiling ΔC = 2, pin at the near edge, therefore *"no independent
information"* — and §8 item 3 records the residue against the clause's *stated
premise* with the route named. I repaired the instrument I own and filed against
the text I do not, in the same act, which is the only shape in which a finding
against a specification by its own DV lead is not also a unilateral edit of it.

**5. The quantifier trio, and the scope I chose rather than the scope that was
convenient.** Three rows of this plan stated a universal over a domain the claim
cannot survive: `M04-B2`/`M04-C4`'s poison scan (the FCS is computed and may equal
the poison), `M04-B1`'s uniqueness scan (`/I/` is `0x07` and the filler contains
`0x07`), and `M04-G7`'s ground. The repair is one domain for all three — **the
frame's own wire octets, indices `0 … F−5`, DA through the last pad octet** — and
each exclusion carries its reason **in the cell**, because an exclusion without a
reason is indistinguishable from a scan that was narrowed until it passed. The
excluded classes are not unjudged: the FCS is judged against the REQ-305 oracle at
`M04-D1`, the idle lanes by the decoder's REQ-205 judgement. **What I refused to
write**: *"the poison appears nowhere except where it legitimately may"*, which is
the same universal wearing a hedge.

**6. Where the two new rows went, and why `ASSERT` rather than `GAP`.** Family G,
appended after `M04-G8` (§1: ids are permanent, new rows append inside their
family). `M04-G9` is the `W = 1` collapse — REQ-206's window is **provably empty**
when the frame's `tlast` word is accepted at the cycle the frame starts — and
`M04-G10` is the pre-loaded back-to-back handover at `C + 8` covering `BUG-0004`'s
routes 2 and 3. **`GAP` was live and is rejected in writing** (§5 item 11):
`GAP` says an attack *cannot* be mounted, and `M04-G10`'s obstacle is a capability
**that has not been built**, not one that cannot be. Statusing it `GAP` would let
a sign-off read the coverage as structurally unavailable — the opposite of the
truth — where `ASSERT` + machinery **T-7** with an executor named is the form this
plan already uses for `T-2`'s rows. **The other rejection recorded with them** is
the inviting one: producing the handover with an idle-injection wrapper at M04's
source, which SPEC-M04 §7 forbids in normative text because the first injected
cycle on a required cycle **is** an underflow — a wrapper aimed at these rows would
manufacture the very condition they assert is absent.

**7. The `SO-` precondition is now readable from the plan, which was the point of
the exercise.** `BUG-0004` is CLOSED; a closed packet carries nothing. So the bar
lives at **§0.2 item 4** — the prohibition register, read before any row makes a
claim — as *no `SO-xgmii_tx_64.md` may report REQ-206 coverage while `M04-G10` is
neither measured nor declared a gap*, with §7's `T-7` naming the machinery, §8 item
7 carrying it as a gate condition, and §6's REQ-206 line pointing at the bar from
the coverage map. **Four sites, deliberately**, because a sign-off round reads the
coverage map and the register, not the bug archive.

**8. `FINDING BUG-0004-1` — the repair "where the rule lives", and the honest half
of that answer.** The malformed sentence is `BUG-0004` §6's, and `agents/handoffs/**`
is **explicitly out of this round's write set**; the packet is also CLOSED. I did
not edit it, and it needs no edit: its own §10.2 already corrects it in place, in
the same commit that closed it. What was owed — §10.4's carrier says *"the
restatement rides the same round as the two new rows"* — is the rule's
**forward-acting** form, in the document that will still be read when the packet is
archive: §0.2 item 4 now states the conversion question over the **mechanism**
(*can the chain present a frame whose `tlast` word is in this module's hands at or
before the cycle the frame starts?*) rather than over a word count, with §7's
`C + 8` note as the ground and route 3 as the counter-example to the old one. The
old rule's conclusion survives; a reader re-deriving from its premise would
conclude `W = 2` is safe, and route 3 disproves that.

**9. A discharge I measured and deliberately did not claim.** `M04-G9`'s
observable is **met today**: the landed bench's `assert_instruments_clean` fails
any run in which `error_underflow` is high for more than 0 cycles, and
`test_m04_b.ml`'s directed set contains `P = 1`, which is `W = 1`. I recorded the
measurement with its provenance and **did not move the discharge count**, because
that run was adjudicated by `RV-0080B-VERDICT` against the rows that existed at
that verdict, and **a row written after a run is not discharged by it merely
because the run would have passed it**. The alternative — writing the row and
ticking it in the same act — is exactly how coverage gets manufactured backwards,
and it would have been invisible in the diff. So the plan records 69 of 82
outstanding and lets the next `SO-` round decide with the measurement in front of
it. This is the same cut `J-dv_lead-0171` made for `M04-G4`'s incidental silence,
applied where it costs me a row rather than where it costs the worker one.

**10. Taking the `AP-M14` rows, and the three grounds.** The dispatch left the
call to me. I took them. **(a) The class is worse than anything on the M04 list**:
`M14-F1` is an **`ASSERT`** whose observable **fails a conformant design** at every
`k ≥ 1` — the `SCR-M03-I4` shape in my own landed plan — where every M04 item is a
ground or a quotation that misleads a reader without failing a design. **(b) The
carrier is the failure mode I convicted last round**: *"the round that next opens
`AP-ip_eth_rx_64.md`"* is phrased over a **path**, so declining would have re-pinned
it to another accident. A round commissioned to repair plans is exactly the
commissioning act such a carrier should have named. **(c) The derivation was
already countersigned** at `J-dv_lead-0170` §(c) and the repaired specification
supplies the observable directly (§7's per-output-event table, §10's REQ-016 hook),
so this is a transcription of a ruling into rows and not a fresh adjudication of a
module I have no bench for.

**11. And taking them found a third stale clause and a live spec conflict, which
is the argument for having taken them.** `J-dv_lead-0170` §(d) enumerated the L =
12 clauses. Deriving `M14-F1`'s replacement off §7's table shows a **second**
falsified clause in the same row: *"`ip_hdr_valid` still leads payload word 0 by
one cycle"*. `ip_hdr_valid`'s deciding input word is input word **2**; payload word
0's is input word **3**; so `k` idles injected **between input words 2 and 3** make
the lead `1 + k`. Pushing on it further, the conflict is not only mine: SPEC-M14 §7's
handshake bullet states that adjacency **unscoped**, and §6.1 says in terms that
*"the lead is normative here and not incidental"* because M17 is written against
it — while the per-event table in the same section puts the pulse at input word
2 + 1. **Under injection at that one site the two cannot both hold.** Filed as
`FINDING AP-M14-1` (MINOR, mine, against the specification), **not decided**, with
a recommendation offered (scope the adjacency exactly as §7 already scopes its own
parse latency under `C-27`; REQ-606 asks for the record *on or before* the first
payload word, so a lead of `1 + k` satisfies it **a fortiori** and M17 gains time
rather than losing it) and with the sites listed by grep so the ruling's site list
is not one entry short. **`M14-F1` asserts neither lead**, so it is unmoved by the
ruling in either direction — the discipline `AP-M04-1`, `AP-M04-2`, `CSG-3` and
`ABS-1` all used. **Reachability, checked rather than assumed**: §8's stress run
gaps *between* frames and delivers each datagram's words on consecutive cycles, so
no committed stimulus reaches the conflict, which is why the 2026-08-11 repair that
rewrote this very bullet did not trip over it.

**12. One coverage-map line moved at M14, and it is a subtraction.** `M14-F1`
homed under **REQ-005** for its *"L = 12 unchanged under injection"* clause. That
clause is struck, so the row no longer attacks REQ-005 and is removed from its
line — with the reason in the cell and with the note that REQ-005's substance is
unweakened, `M14-I2` and `M14-I4` asserting the constant on the gapless stress run,
which is the only stimulus on which the requirement has an instance here. **A
coverage line that keeps a row after the row stopped asserting the thing is worth
less than an honest one**, and this is the second time this programme has paid for
a row homed by habit (`FINDING SO-1-A`).

**13. Numbering hygiene, twice, and both times I caught myself doing the
convenient thing first.** I first wrote the two new §5 rejections **as item 10**,
pushing the existing item 10 down, and I first wrote the new §8 item **as item 6**;
both were corrected to append at **11** and **7**. §5 and §8 items are cited by
number across this repository (`§7.2` cites *"§5 item 1"* inside this very
document), and a plan that keeps its **row** ids permanent while renumbering the
prose its rows cite has only half a convention. The same rule put `M04-G9`/`G10`
**after** `M04-G8` rather than beside their subject matter.

**14. Every count in both documents is re-measured at this tree, and one was
updated because it would otherwise have gone stale silently.** §6.1's homing check
prints its own output; it read `80 80 []` and now reads `82 82 []`, re-run with the
document's own quoted command. That figure is the one thing in the plan that
**must** move when rows are added and would have been invisible if I had trusted
the ranges — the check reaches the new ids only through §6's `M04-G1 … M04-G10`
range and its expansion loop. Status-cell passes ran **before and after** every
edit on both plans. `tools/dv_checks.sh` still cannot count an M04 row, so every
M04 figure here is a **hand count with its method stated** (`DVC-1a`, still mine,
still unbuilt, and outside this round's write set).

**15. What I refused.** I did not touch `agents/handoffs/**`, `test/xgmii_tx_64/**`,
`libs/**`, `docs/**` or `tools/**` — the dispatch's explicit outs, and two of them
(the `BUG-0004` §6 sentence and the `dv_checks` census) were things I wanted. I did
not open any RTL. I did not rule `ABS-1` or `AP-M14-1`, both of which are against
specification text and neither of which a filer may decide. I did not move a single
`Status` cell of a pre-existing row in either plan, and I did not move a discharge
count. I did not open, offer or imply an `SO-`. I did not write the `M04-G10` bench
or the `T-7` machinery that would let a row I just wrote be ticked in the same
round. And I did not re-measure the four `BM16` instances from `RV-0071-VERDICT`
that `J-dv_lead-0176` quoted with their provenance, so that count stands exactly as
it was quoted.

**16. On the harvest note: none is owed, and I say so rather than leave silence to
be read.** ADR-0018 and PROTOCOL §7 attach a note to every module sign-off and
every phase gate; this round is neither. Under `A2-D10` the open span still begins
at `J-dv_lead-0174` and this entry joins it. **A fourth candidate is banked**
(Open-questions item 6), and it is this round's own arithmetic: *a debt total
carried across rounds drifts by counting the item that is discharged in the same
act that records it; the census of record is a walk of the entries that minted the
items, and a round that pays from the total pays the wrong set.*

### Actions

- Verified the spawn-head precheck; read the charter and PROTOCOL before writing.
- **Walked `J-dv_lead-0171` … `J-dv_lead-0176`** and rebuilt the repair census from
  their Open-questions and Reasoning, finding the duplicate.
- **`test/attack_plans/AP-xgmii_tx_64.md`** — repaired: the header's `C-5`
  carry-forward bullet; §0.2 item 3's ground and a **new item 4** (the REQ-206
  sign-off bar and `FINDING BUG-0004-1`'s restated conversion rule); §2 obligation
  5 (ground replaced, old text struck, `ABS-1`'s residue routed); rows **`M04-B1`**,
  **`M04-B2`**, **`M04-C4`** (quantifiers scoped), **`M04-G7`** (ground repaired),
  **`M04-J3`** (stale REQ-210 quotation struck, closure recorded); **added rows
  `M04-G9` and `M04-G10`**; §5 **item 11** (the two rejections the new rows owe);
  §6's REQ-206 line; §6.1's quoted homing figure; §7 machinery **T-7**; §8 items 1
  and 3 closed and **item 7** added; **one appended §9 change-log row**.
- **`test/attack_plans/AP-ip_eth_rx_64.md`** — repaired rows **`M14-F1`**,
  **`M14-F2`**, **`M14-F3`** against §7's per-output-event table; §6's REQ-005 line;
  **§8 item 3** minting `FINDING AP-M14-1`; **one appended §9 change-log row**.
- Ran the §6.1 homing census and both status-cell passes before and after editing.
- **No git write of any kind**: no `git add`, no `git commit`, no `git push`.

### Evidence

**1. Precheck and return state.**

```sh
git status --short   # zero lines at entry; at return, exactly three paths:
                     #   test/attack_plans/AP-ip_eth_rx_64.md
                     #   test/attack_plans/AP-xgmii_tx_64.md
                     #   agents/journals/claude_dv_lead_agent.v09.md
git rev-parse HEAD   # 8ff1b20b965e7a79b5e6bc2eeef16b7dc6fb269e (unchanged at return)
```

**2. `AP-M04` status-cell pass, before and after every edit** — the same command
`J-dv_lead-0176` used, quoted with its output both times:

```sh
grep -oE '^\| \*\*(M04-[A-Z][0-9]+)\*\*.*\| (ASSERT|NO-ASSERT|NO-STIMULUS|RULING|GAP|STRUCTURAL) \|$' \
  test/attack_plans/AP-xgmii_tx_64.md \
  | grep -oE '\| (ASSERT|NO-ASSERT|NO-STIMULUS|RULING|GAP|STRUCTURAL) \|$' | sort | uniq -c
# BEFORE: 80 rows — 56 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP, 0 RULING
# AFTER:  82 rows — 58 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP, 0 RULING
grep -cE '^\| \*\*M04-[A-Z][0-9]+\*\* \|' test/attack_plans/AP-xgmii_tx_64.md   # 82 (82 distinct ids)
grep -cE '^\| \*\*M04-G[0-9]+\*\* \|'     test/attack_plans/AP-xgmii_tx_64.md   # 10  (family G, was 8)
```

**The delta is exactly the two new ASSERT rows**, and no pre-existing row's status
cell moved.

**3. `AP-M04` §6.1 homing census, run with the document's own quoted command.**
Before the rows landed: `80 80 []`. After: **`82 82 []`** — no unhomed row, and the
printed figure in §6.1 is updated in place rather than carried forward.

**4. `AP-M14` status-cell pass, before and after — unchanged, which is the claim.**

```sh
grep -oE '\| (ASSERT|NO-ASSERT|NO-STIMULUS|RULING|STRUCTURAL|GAP) \|$' \
  test/attack_plans/AP-ip_eth_rx_64.md | sort | uniq -c
# BEFORE and AFTER, identically: 51 ASSERT, 4 NO-ASSERT, 2 NO-STIMULUS, 6 STRUCTURAL, 0 RULING
grep -cE '^\| \*\*M14-[A-Z][0-9]+\*\* \|' test/attack_plans/AP-ip_eth_rx_64.md   # 63, unchanged
```

`M14-F1` remains an `ASSERT` **of a different observable**, which is the whole
shape of that repair.

**5. The two capability measurements behind `T-7` and behind `M04-G9`'s recorded
(not claimed) coverage** — read at this tree, in my own DV tree, post-verdict:

```sh
grep -n 'assert_instruments_clean\|high_cycles\|expected 0\|expected exactly one' test/xgmii_tx_64/bench.ml
#  345  match Tx_decoder.frames d with            (wire_frame: one frame per run)
#  356  " completed frames decoded, expected exactly one …"
#  363  let assert_instruments_clean t ~row =
#  370  let high = Strobe_monitor.high_cycles t.strobes "error_underflow" in
#  375  ": error_underflow high for … cycles, expected 0"
#  382  match Tx_decoder.frames t.decoder with    (conservation: exactly one frame)
grep -n 'directed_lengths' test/xgmii_tx_64/test_m04_b.ml
#  225  let directed_lengths = [ 1; 20; 59; 60; 61; 64; 67; 1514 ]
```

So (a) **no committed producer can drive a second frame in one run**, which is
`T-7`'s absence measured rather than inferred, and (b) `error_underflow` silence
**is** asserted today on a `W = 1` frame (`P = 1`), which is `M04-G9`'s observable —
recorded in the change log with this provenance and **not** counted as a discharge.

**6. The `AP-M14` derivation, redone here from §7's table rather than quoted from
`J-dv_lead-0170`.** With `Cw` the cycle of input word `w` and `k` idles injected
between input words 2 and 3: `ip_hdr_valid` = `C₂ + 1` (deciding input word 2,
delay 1); payload word 0 = `C₃ + 1` = `C₂ + k + 2` (deciding input word 3, delay 1);
**lead = `1 + k`**, and `= 1` only at `k = 0`. Hence both struck clauses of
`M14-F1`, and hence `FINDING AP-M14-1` against SPEC-M14 §7's unscoped adjacency
(§5's record row, §6.1's lead paragraph, §7's handshake bullet, §10's REQ-606 hook;
§8's stress paragraph is gapless by construction). The straddle half is
`(h = 20) mod 8 = 4 ≠ 0`, requirements.md §0.5, ruled 2026-08-04.

**7. No RTL was read.** `libs/**`, `top/**` and `rtl_snapshots/**` were not opened
at this round. The only `test/**` files opened outside the two plans are the two
named at Evidence 5, both my own line's artefacts, both read as a reviewer.

**8. Not reproducible here, and said so**: `dune` is absent from this container
(ADR-0005, the standing bound), and **no OCaml lands in this round** — nothing in
either edited file is executable, so there is nothing for `dune runtest` to say
about it. The CI figures quoted in the `AP-M04` change-log row (`build` run
**31482795659** at `af06c62`) are `J-dv_lead-0176`'s, cited **by reference** and not
re-measured here.

### Outcome

**DoD for a commissioned plan-repair round: met.**

- **The census, corrected and paid.** Eight distinct carried items, not nine — the
  §9 change-log row was counted twice, and the correction is recorded in the plan
  with the quotation that convicts it. **Seven paid here**; the eighth (the
  families A/B/C landed-status row) was paid at `J-dv_lead-0176` and is not
  re-paid. `BUG-0004` §10.4's trip condition is met on its own terms: its item is
  the two new family-G rows and both landed.
- **`AP-xgmii_tx_64`**: five text repairs (`M04-B1`, `M04-B2`/`M04-C4`, `M04-G7`,
  `M04-J3` + §8 item 1, `C-5` at four sites), **two new `ASSERT` rows**
  (`M04-G9`, `M04-G10`), the sign-off bar at §0.2 item 4, machinery `T-7`, §5's two
  rejections, §8 item 7, §6 and §6.1 re-measured, one §9 change-log row. **82 rows,
  58 ASSERT; no pre-existing status cell moved; no discharge count moved.**
- **`AP-ip_eth_rx_64`**: family F repaired against §7's per-output-event table
  (`M14-F1`'s two struck clauses, `M14-F2`'s struck trailing clause plus the
  REQ-611 gap-clause quantity added, `M14-F3`'s ground replaced), REQ-005's
  coverage line corrected, `FINDING AP-M14-1` minted and routed, one §9 change-log
  row. **63 rows and every status count unchanged.**
- **`FINDING BUG-0004-1` discharged** — restated over the handover at §0.2 item 4,
  in the document that outlives the packet. The packet itself is CLOSED, already
  self-corrected at its §10.2, and out of write set: **not edited**.
- **Two findings stand open against specification text, both routed, neither
  decided**: `ABS-1` (§0.6's fourth clause's stated ground) and `AP-M14-1`
  (SPEC-M14 §7's unscoped adjacency). Both are architect_docs_lead's.
- **Handoff**: two files to the orchestrator for commit. **No packet, no `SO-`, no
  bench, no `RV-`** — this round judged nothing and repaired the instruments that
  will do the judging.

**No harvest note is owed** (neither a sign-off nor a gate); the span tiles
unbroken from `J-dv_lead-0174` through this entry to the next sign-off, where
**four** banked candidates now wait.

### Open-questions

1. **`FINDING AP-M14-1` (MINOR, new, mine, against SPEC-M14 §7).** The
   `ip_hdr_valid` adjacency is stated unscoped and normative (§6.1: *"the lead is
   normative here and not incidental"*, M17 written against it) while §7's own
   per-output-event table puts the pulse at input word 2 + 1 cycle; under `k ≥ 1`
   idles between input words 2 and 3 the lead is `1 + k` and the two cannot both
   hold. **Not reachable by any committed stimulus** (§8's stress run gaps between
   frames). **Route**: architect_docs_lead, spec-diff request via the orchestrator,
   recommendation offered at `AP-ip_eth_rx_64` §8 item 3. **Not blocking**:
   `M14-F1` asserts neither lead and M14 has no bench.
2. **`FINDING ABS-1`'s §0.6 sentence is still open and still the architect's.** My
   own half — `M04-G7`'s ground — is paid here. The clause stays in force; the cure
   is one sentence; nothing turns on it arithmetically.
3. **`BUG-0004`'s routes 2 and 3 remain derived and unmeasured, and the bar is now
   in the plan.** `M04-G10` is `ASSERT` and unmountable until machinery **T-7**
   exists — a direct-drive continuous source with a controllable handover cycle,
   **mine**, in the round that first opens a back-to-back bench at M04 (not family
   D). §0.2 item 4 bars a REQ-206 coverage claim in any `SO-xgmii_tx_64.md` that
   neither measures them nor declares them a gap citing `BUG-0004`.
4. **`M04-G9` is measured but not discharged, deliberately.** The landed bench
   asserts its observable at `P = 1`; the run that did so was adjudicated before the
   row existed. **Route**: the next round that adjudicates rows — with the
   provenance recorded in the change log, so the decision is made in front of the
   measurement rather than instead of it.
5. **`DVC-1a` still cannot count an M04 row**, so every M04 figure in this round is
   a hand count with its method stated (three plans now want it). **Mine**,
   `tools/**`, outside this round's write set, and it should land before any `SO-`
   quotes an M04 coverage fraction.
6. **Four harvest candidates banked for the next `SO-`.** (a)–(c) carried unchanged
   from `J-dv_lead-0175`/`J-dv_lead-0176` (instrument placement over luck; a carrier
   must name the commissioning act, not the artefact; a re-test proves a fix only if
   the instrument is measurably unchanged). **(d) new, from this round**: *a debt
   total carried across rounds drifts by counting the item that is discharged in the
   same act that records it; the census of record is a walk of the entries that
   minted the items, and a round that pays from the total pays the wrong set* — LH1
   is this round's nine-to-eight correction; LH2/LH3 at the next sign-off. A fifth is
   forming and is **not** banked yet because it has one instance: *three of one
   plan's rows stated universals over domains their claims could not survive, and
   every one was caught by someone other than the seat that wrote it.*
7. **Standing and untouched by this round**: the transmit-side conservation monitor
   (`AP-M04` §7 `T-2`); the three `BAR T1` work orders; `SO-xgmii_rx_64.md`'s
   Stage-3 gate table (condition (c) still recorded UNMET, MET since `36e3a4d`);
   family D as the next bench round; the six `WO-0080` packet repairs re-pinned to
   the next packet this seat writes for the `tb_writer` chain, with the `BM16`
   tripwire; and the orchestrator's enumerated tool allow-list at the head of the
   spawn prompt, still unwritten since `RV-0071-VERDICT` §3.

### Files-in-this-commit
- test/attack_plans/AP-ip_eth_rx_64.md
- test/attack_plans/AP-xgmii_tx_64.md
