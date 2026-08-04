# Journal: claude_dv_lead_agent — volume 02

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 02
- **Continues-from**: J-dv_lead-0072
- **Previous-volume**: agents/journals/claude_dv_lead_agent.md
- **Previous-volume-sha256**: 47d2ffbeebe99de490db4dc6165cfbfd8433811543e76f2eb8d7c1174add0771
- **Previous-volume-bytes**: 1123442

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 01 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0073] 2026-08-05T18:45Z | task:WO-0053 | Volume 02 opened — the rotation ADR-0017 §5.2 predicted, executed as its own worked example, with the chain fields computed rather than accepted

### Trigger
Orchestrator: ADR-0017 step 2 is live at `a0454b4` — `R10` enforced, `H` = 512
KiB in force, `R11` minted and `verify_journal_chain.sh` shipped. My active
volume stood at 1,123,442 bytes, **2.14 × H**, so my next append to it would be
refused. Rotate before anything else, ahead of tb_writer's WO-0056 return.

### Inputs
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.3 (the header block),
  §4.4 (the four-step rotation), §5.2 (the disposition table that named this
  rotation in advance), §7.1 (the two steps).
- `agents/PROTOCOL.md` §4 as amended, §4.1's entry grammar, §4.2's
  `Files-in-this-commit` rule, §5's `R2`/`R3`/`R5`/`R10`.
- **`agents/journals/claude_dv_lead_agent.md` at HEAD** — its entry-header tail
  and its committed bytes, both read through `git show HEAD:` rather than from
  the working tree.
- My own `J-dv_lead-0066` (the ADR-0017 countersignature, whose §6.5 contest was
  applied verbatim at `acc8145`).
- **No `libs/**`, no `docs/reports/audit/**`, no `scripts/**`, no
  `/workspace/**`.**

### Reasoning

**Every field in this volume's header was computed, and the one I was told to
verify I verified against the tree rather than the dispatch.** The orchestrator
gave `J-dv_lead-0072` as the last entry id and explicitly said not to trust the
figure; `git show HEAD:… | grep '^## \[J-dv_lead-'` ends on **J-dv_lead-0072**,
so `Continues-from` is right. That mattered more than it looks: my previous
commit (`4dba968`, the G7/G8 attack-plan edit) had to have landed for that to
hold, and had it not, `Continues-from` would have named an entry that volume 01
did not contain — the join point the chain check exists to catch, forged by
accident on the very first rotation.

**I also checked that volume 01 is byte-clean against HEAD before hashing it.**
`git diff --stat` on that path is empty, so the bytes I hashed are the bytes that
are committed, and `Previous-volume-sha256` describes a state that exists in
history rather than one that happens to be on my disk. ADR-0017 §4.3 says the
two coincide *because the predecessor is not modified by the rotation commit* —
true here, and worth confirming rather than assuming, because the entire
integrity claim of the chain rests on that hash being of the committed object.

**The one thing I was careful not to do is touch volume 01.** It froze the moment
step 2 landed. This commit stages **only** the new volume — no append, no
truncation, no rename, which §2.1 of the ADR shows are refused anyway. The
mechanism's virtue, and the reason I countersigned it, is that there is **no
rotation mode in the scripts**: R2 sees one own-journal path staged, R3 sees a
new file and passes its byte-prefix test trivially, R5 reads `Continues-from`,
and nothing is conditionally disabled. Executing it, that is exactly how it
feels — an ordinary commit with an unusual header.

**Being the ADR's worked example is worth a sentence, because it is a check on
the ADR rather than on me.** §5.2 predicted *"exactly one forced rotation"* and
named dv_lead as the one. At the countersignature I re-measured all nine journals
and confirmed the prediction still held. It holds now: I am over `H`, and nobody
else is. A design document that predicted its own first firing correctly, months
of entries in advance, has earned some trust for the parts not yet exercised.

**And the bound I contested is the one I want restated here, at the top of a
volume that will accumulate entries nobody re-reads.** ADR-0017 §6.5 originally
claimed a green `verify_journal_chain.sh` meant *"no entry has been dropped or
rewritten"*. My countersignature replaced that, verbatim, with a sentence
bounding it to **frozen** volumes: the active volume has no successor linking
back to it, so its append-only property still rests on R3 and history exactly as
before. **A green chain is not a clearance for the volume being written** — this
one — and everything I append here is protected by the same machinery as always
until volume 03 exists and hashes it.

**One consequence for citation, since this is the first entry anyone will reach
by a path that is not the historic one.** Entry ids continue across volumes and
are never restarted (ADR-0017 §4.2): this is **0073**, not 0001. Every
`J-dv_lead-NNNN` reference in every packet, verdict, gate signature and ADR in
this repository stays resolvable, and volume 01 keeps its path forever. The
citation namespace did not move; only the file did.

### Actions
- **Verified the last entry id at HEAD** — `J-dv_lead-0072` — from volume 01's
  committed bytes, not from the dispatch and not from the working tree.
- **Verified volume 01 is byte-identical to HEAD** before hashing it.
- **Computed** `Previous-volume-sha256` =
  `47d2ffbeebe99de490db4dc6165cfbfd8433811543e76f2eb8d7c1174add0771` and
  `Previous-volume-bytes` = **1,123,442** from
  `git show HEAD:agents/journals/claude_dv_lead_agent.md`.
- **Created `agents/journals/claude_dv_lead_agent.v02.md`** with §4.3's header
  block — the three standard bullets plus `Volume`, `Continues-from`,
  `Previous-volume`, `Previous-volume-sha256`, `Previous-volume-bytes` — and the
  frozen-predecessor notice above the `---`.
- Wrote this entry as the volume's first, `J-dv_lead-0073`.
- **Did not touch volume 01**, and did not stage the one dirty path in the tree
  (`test/xgmii_rx_64/test_m03_g.ml`, tb_writer's WO-0056 work in flight).
- No `git commit`, no `git push`.

### Evidence
1. `git show HEAD:agents/journals/claude_dv_lead_agent.md | grep -o '^## \[J-dv_lead-[0-9]*\]' | tail -2`
   → `## [J-dv_lead-0071]`, `## [J-dv_lead-0072]`. **Continues-from = 0072.**
2. `git show HEAD:agents/journals/claude_dv_lead_agent.md | sha256sum` →
   `47d2ffbeebe99de490db4dc6165cfbfd8433811543e76f2eb8d7c1174add0771`.
3. `git show HEAD:agents/journals/claude_dv_lead_agent.md | wc -c` →
   **1123442** bytes = **2.14 × H** (524,288), and 1.12 × the retired blob
   ceiling.
4. `git diff --stat -- agents/journals/claude_dv_lead_agent.md` → empty, so the
   hashed bytes are the committed bytes.
5. `git log --oneline -1` → `a0454b4 WO-0053: journal volume chain enforced -
   R10 live, R11 minted, verifier shipped`; my `J-dv_lead-0072` landed one commit
   earlier at `4dba968`.

### Outcome
**Volume 02 is open at `agents/journals/claude_dv_lead_agent.v02.md`**, carrying
ADR-0017 §4.3's header with all five chain fields computed from volume 01's
committed bytes, and this entry — `J-dv_lead-0073`, continuing the id sequence
rather than restarting it — as its first.

**Volume 01 is frozen at 1,123,442 bytes and 72 entries**, at its historic path,
never to be appended to again. Every existing citation of it resolves unchanged.

The rotation ADR-0017 §5.2 predicted is executed, and the prediction was exact:
one forced rotation, mine.

### Open-questions
- **The chain's own verifier has not been run by me.** `verify_journal_chain.sh`
  shipped at `a0454b4` and this is the first chain in the repository for it to
  walk; a green run over this tree — and a red one after flipping a byte of
  volume 01 — is ADR-0017 §9's case (h), which is the orchestrator's to execute
  and the one that proves the mechanism rather than its mechanics.
- **`Previous-volume-bytes` is informational**, per §4.3; the sha256 is the
  load-bearing field and the byte count is a convenience for a reader diffing by
  eye. If they ever disagree, the hash governs.
- **Nothing about the WO-0056 round changes.** The standing consequence from
  `RV-0055-VERDICT` is unlifted, M03-G8 is the row that lifts it, and I am clear
  to review tb_writer's return.
- **Still owed**: the epoch-A no-output-word class (`J-dv_lead-0065`, rides with
  family H); AP-M14's §6 invariant; the `precompile_check.sh`
  side-effect-in-combinator lane; M03-F5's discharge-by-citation qualification;
  the RFC 1071 anchor on the next fetching run; X-7, X-10, X-11 deferred; L1–L5
  as a separate packet.

### Files-in-this-commit
- (none)

## [J-dv_lead-0074] 2026-08-05T21:20Z | task:WO-0056 | WO-0056 accepted — and the round's finding is that my own first-epoch interval starts one octet too early, because placing a character at the boundary removes the octet that makes the frame oversize

### Trigger
Orchestrator: tb_writer's WO-0056 return is in the tree — `run_g7` and `run_g8`
appended to `test_m03_g.ml`, with a new accounting helper and a flagged-not-fixed
`dune` staleness. Line-review it, verify the new helper against the accounting
rules rather than the worker's account of it, check G8's own constant, restate
the replay instrument's published prediction, and rule on the `dune` header.
First review entry in volume 02.

### Inputs
- `test/xgmii_rx_64/test_m03_g.ml` — `account_resync_runt_frame` in full,
  `run_g7`'s five guards and its resynchronised-frame derivation, `run_g8`'s
  guards and exact strobe set, and the module docstring's construction-split
  argument.
- **`test/xgmii/arrival.ml`'s `in_times` implementation and `arrival.mli`'s
  docstring for it** — the check that settled the new helper.
- `test/xgmii/injection.ml`'s `At_octet` validation (the bounds test and the
  start-character lane test).
- `test/xgmii_rx_64/test_m03_e.ml`'s `account_dropped_frame`, as the shape being
  generalised.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.G rows M03-G7 and M03-G8 — **my own
  text from `J-dv_lead-0072`, re-read as the thing under check**.
- `agents/handoffs/WO-0056_…` §2, §2.1, §5, §6, §7; the Return log in full.
- `tools/dv_checks.sh`'s inventory block, run at this tree.
- **No `libs/**`, no `docs/reports/audit/**`, no `scripts/**`, no
  `/workspace/**`.**

### Reasoning

**The finding came from a discrepancy the worker did not flag, and I noticed it
only because both guards are in the file.** Each row carries my row's stated
interval (`k < 1518 || k > 1599`) *and* an octet-time guard
(`inject_ot > start_ot1 + 8 + 1518`). Those disagree at exactly `k = 1518`. I
went to decide which was right expecting to confirm my own row, and did not.

**A character placed at content index `k` replaces that octet**, so the data
octets that arrived before it are indices `0 … k−1` — **`k` octets**. REQ-108
truncates a frame **exceeding** 1518, which needs `k > 1518`. At `k = 1518`
exactly 1518 octets arrived, **the frame is not oversize at all**, and a `/S/`
there is REQ-110's abort of a legal-length frame while an `/E/` there is
REQ-105's. **The row's premise fails at its own stated lower bound.**

**The shape of my error is worth stating precisely, because it is not a typo.**
`J-dv_lead-0072`'s cell says *"content 1518 is the 1519th received octet, the
first that makes the frame exceed 1518"* — **true about the octet and wrong as a
placement bound**, because placing a character there removes the very octet whose
arrival would have made the frame oversize. The figure is correct for *where
truncation triggers* and wrong for *where a character may be placed after it*,
and the two differ by one for exactly that reason.

**And it is the same class as the "100 octets" figure this packet exists to
repair — committed by me one entry after diagnosing that one.** An interval
endpoint asserted without working its boundary case. I wrote the row, derived
both ends in its own cell, and did not ask what happens *at* either end.

**No bench defect and no bounce.** Both rows use `k` far inside either reading,
the octet-time guard is correct, and the file **fails safe**: a `k = 1518` passes
guard one and is caught by guard two. The AP row needs a one-character fix and
that is owed as a follow-up, this commit being scoped to the packet. I recorded
in the verdict that **until it lands the file's octet-time guard is the authority
on the interval, not the row text** — so nobody reads the stale bound as
governing.

**One note to the worker rather than a defect**: the correct guard was built and
the disagreement with the commissioning row was not remarked. Nothing is at risk
since both guards ship, but *"my derivation and the row's figure disagree"* is
exactly what a Return log is for, and it would have put the finding in the
worker's hands instead of mine.

**The new helper I checked against the primitives rather than its docstring**,
which is what the dispatch asked and what I would have wanted anyway on a first
piece of shared machinery. Against `Arrival.in_times`' own implementation the
helper is **the same construction, not an approximation** — `Array.init (8 +
received) (fun i -> start_ot + i)` against `Array.init (preamble_octets +
Array.length f.octets) (fun k -> f.start_octet_time + k)` — and `arrival.mli`'s
docstring confirms that is the shape `Latency.frame_in` wants. The accounting is
`account_dropped_frame`'s exactly, including **`frame_dropped`** rather than
`frame_out ~aborted:true`, which is M03-E3's rule and is also what stops the
tagger applying its four-octet tail identity to a four-octet frame that has no
FCS to strip. **Right primitive, right order, right reason.**

**Its generalisation is justified by a fact about the machinery, not by
convenience**: there is no `Arrival.frame` record for a frame the *stimulus*
opens mid-array, because `Arrival.frames` knows only what `Arrival.create`
scheduled. Taking `~start_ot ~received` is the minimal reach, and it widens no
exported surface.

**G7's contingency never fired and that is the packet's own prediction landing.**
`1592 − 1588 = 4` octets → REQ-107's sub-five class → no output word, one
`error_runt` at §9's no-output-word pin, **asserted rather than omitted** — which
is what makes the row a test of resynchronisation rather than of the oversize
frame alone. Five committed guards on one recommended constant: interval,
octet-time, REQ-101 lane, the `1592 − k` shortcut against the interval it
abbreviates, and the sub-five class assumption. **My recommendation was checked,
not taken**, which is the whole reason the interval's real boundary surfaced.

**G8's own constant stands on two grounds I verified.** An error character carries
no REQ-101 lane restriction — REQ-101 constrains *start* characters — so no mod-8
guard is owed and the worker said so rather than adding one that would look like
diligence and mean nothing. And `k = 1560` is deliberately central so that the
guard on it cannot be accidentally vacuous, which is the habit this family's
history argues for.

**The construction-split derivation is correct and is the round's most reusable
output.** `At_octet` refuses an index at or past the array's end; G3/G4's target
is content 1618 on a 1600-octet array, G7/G8's are 1588 and 1560. So **the second
epoch lies outside the frame's own array and the first lies inside it** — the
family splits on construction for a fact about the tooling, not a preference, and
the next G row is cheaper for its being written down.

**On the `dune` header I ruled proportionately rather than by principle.** It
should carry a WO-0056 line — the header's own comment says a missing line makes
it wrong with no way to tell — but it is one comment line, blocks nothing, and is
not worth a spawn. So: rides with this landing if the worker's files are
uncommitted, otherwise with the next `test/**` touch. The worker was right to
flag rather than fix, my §7 having narrowed the deliverables.

### Actions
- **Established that the first-epoch interval starts at 1519**, filed the finding
  against my own `J-dv_lead-0072` row, and ruled the file's octet-time guard
  authoritative until the AP is fixed.
- **Verified `account_resync_runt_frame`** line by line against
  `Arrival.in_times`' implementation, `arrival.mli`'s stated contract, and
  `account_dropped_frame`'s primitive order.
- Verified G7's five guards, its lane arithmetic at both starts, and that its
  resynchronised-frame disposition derives (so §2.1's contingency stayed shut).
- Verified G8's constant on both its stated grounds.
- Verified the `At_octet` construction-split claim at the source.
- **Measured** the inventory: **27** M03 units, **107** repository-wide.
- **Restated the replay prediction verbatim** in the verdict so the harvest
  scores against my own words, and re-stated why it is published rather than
  sealed.
- Ruled the `dune` header repair in scope but not worth a re-spawn.
- Appended **`RV-0056-VERDICT`** (ACCEPT). Touched nothing in `test/**`. No
  `git`.

### Evidence
1. Both rows carry `if k < 1518 || k > 1599` **and**
   `if not (inject_ot > start_ot1 + 8 + 1518 && inject_ot < terminate1)`; the
   second admits content ≥ **1519** and is the correct bound.
2. Boundary derivation: a character at content `k` leaves `k` data octets before
   it; REQ-108 needs **more than** 1518; so `k ≥ 1519`. At `k = 1518` the frame is
   not oversize and the row's premise fails.
3. `arrival.ml:24` — `in_times f = Array.init (preamble_octets + Array.length
   f.octets) (fun k -> f.start_octet_time + k)`; the helper is
   `Array.init (8 + received) (fun i -> start_ot + i)`. Same construction.
4. `arrival.mli:111-117` — the array is "the eight preamble octets from the start
   character inclusive, then the frame's octets DA through FCS … exactly the array
   `Latency.frame_in` expects".
5. Helper order: `frame_in` → `discarded ~strobes` → `Latency.frame_in` →
   **`frame_dropped`**, matching `account_dropped_frame` at
   `test_m03_e.ml:139-144`.
6. `1588 mod 8 = 4` → lane 4 at a lane-0 start, lane 0 at a lane-4 start; both
   REQ-101-legal. `1592 − 1588 = 4` → sub-five.
7. `At_octet` refuses `k >= List.length case.octets`; 1618 ≥ 1600 (G3/G4's target,
   rejected), 1588 and 1560 < 1600 (accepted).
8. Inventory at this tree: 3+1+4+3+4+4+**7**+1 = **27**; **107** repository-wide.

### Outcome
**WO-0056 ACCEPTED.** M03-G7 and M03-G8 are built and correct against their plan
rows, the first epoch is driven for the first time in this programme, the new
accounting helper reproduces the primitives rather than approximating them, and
the §2.1 RULING contingency never fired.

**The round's defect is mine**: `AP-xgmii_rx_64.md`'s first-epoch interval reads
`1518 … 1599` and should read **`1519 … 1599`**, because a character at 1518
removes the octet that makes the frame oversize. One entry old, same class as the
"100 octets" figure this packet repairs. **A one-character AP fix is owed** and is
not in this commit.

**The standing consequence is NOT lifted by this acceptance.** It lifts only on
the `g-c4` replay with **M03-G8 reddening**, restated verbatim in the verdict so
the harvest adjudicates against my own words.

### Open-questions
- **The AP interval fix is owed** — `1518 … 1599` → `1519 … 1599` in M03-G7's and
  M03-G8's Stimulus cells, with the derivation corrected to say why the boundary
  octet cannot be replaced. Until it lands, **the file's octet-time guard is the
  authority**.
- **`test/xgmii_rx_64/dune` still lacks its WO-0056 line** — ruled in scope, not
  worth a spawn; rides with the landing or the next `test/**` touch.
- **The replay is the next thing owed on family G**, and its prediction is
  published: M03-G8 SHALL redden; M03-G7 green expected, red adjudicated and not
  scored; failure means the repair failed and the bar stands.
- **My error pattern now has a fourth instance and a sharper name**: not merely
  "asserted from a category" but **"an interval endpoint stated without working
  its boundary case"** — the 100-octet offset and the 1518 lower bound are the
  same mistake twice. The procedural answer is the one I adopted at
  `J-dv_lead-0070` extended: **a cell that states an interval must show what
  happens at each end, not merely how each end was computed.**
- **Still owed**: the epoch-A no-output-word class (`J-dv_lead-0065`, rides with
  family H); AP-M14's §6 invariant; the `precompile_check.sh`
  side-effect-in-combinator lane; M03-F5's discharge-by-citation qualification;
  the RFC 1071 anchor on the next fetching run; X-7, X-10, X-11 deferred; L1–L5
  as a separate packet.

### Files-in-this-commit
- agents/handoffs/WO-0056_m03-g-discard-window-repair.md

## [J-dv_lead-0075] 2026-08-06T09:40Z | task:WO-0056 | The bar is LIFTED — G8 alone of twenty-seven units died under the unmodified diff that survived all twenty-five — and the one clause I got wrong is the cosim job, which went green for a reason better than my prediction

### Trigger
Orchestrator: the `g-c4` replay ran — branch `mut/wo-0056-gc4-replay`
(`c95c9f4` = `e7657e3` + the unmodified `g-c4.diff`), CI run **30852220315**,
Build success, `runtest` RED. Adjudicate against my `RV-0056-VERDICT` §7
published prediction, rule on the lift, execute the owed one-character AP
boundary fix, and state the resulting coverage count.

### Inputs
- The verbatim harvest
  `…/scratchpad/gc4replay_runtest_verbatim.txt` — read in full: the failing-file
  list, the hunk count, and the single message.
- `agents/handoffs/WO-0056_…` §6's four published clauses and §7's restatement in
  `RV-0056-VERDICT`; `RV-0055-VERDICT` §4 and §8; `RV-0054-VERDICT`.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.G rows M03-G7 and M03-G8 and §9's
  change-log row — **my own text, as the thing being corrected**.
- `tools/dv_checks.sh`'s inventory block at this tree (27 units), and the bench
  files' own row-to-unit mapping for the coverage recount.
- **No `libs/**`, no `docs/reports/audit/**`, no `scripts/**`, no
  `/workspace/**`.**

### Reasoning

**All four of §6's clauses landed, and the first landed in the sharpest form
available.** I predicted "M03-G8 SHALL redden" as the whole lift condition. What
came back is **one failing file, one hunk, one message** — G8 alone out of
**twenty-seven** units, on the exact assertion the row was written to make, with
`observed 2`: the spurious `error_bad_frame` beside the frame's own
`error_oversize`, the second report §9's seventh ruling and C-12 forbid. G7 green
as predicted, the five pre-existing G rows green as at WO-0055.

**So the bar lifts, and it lifts on the measurement rather than on the landing.**
That distinction is the whole reason I wrote the instrument into the packet
before the rows existed: M03-G3 and M03-G4 were green from the day they landed
and were green **for the wrong reason**, so a green M03-G8 would have proved
exactly as much as they did. **What proves the repair is that the mutation which
survived all twenty-five units at WO-0055 now dies — on an unmodified diff,
against a bench that has never seen it.**

**The clause I got wrong is the cosim job, and what replaced my prediction is
worth more than the prediction was.** I said red-by-design, reasoning from
WO-0055 that a mutated M03 must diverge from the reference. It went **green** —
because **g-c4's defect fires only after REQ-108's truncation, and the anchor's
single clean frame never gets there.** The lane compared what it covers, agreed,
and passed, while the defect sat in a region REQ-901 class (f) excludes entirely.

**That is a confirmation of the exclusion's scope, not a hole in it**, and it
converts an argument into a demonstration: **a green co-simulation is not evidence
about REQ-108**, which I have asserted since `J-dv_lead-0060` and can now point at
a run for. A prediction of mine died and the programme is better informed for it —
the same shape as E-c1, and I would rather record it that way than quietly note
the clause was "not scored".

**The bound I am most careful about is the one the lift does not carry.**
**M03-G7 is benched but NOT mutation-qualified.** It did not exist at WO-0055 and
the replay's diff is error-character-gated, so **no mutation has ever reddened
it** — a start character in the first epoch is driven and asserted, and nothing
has proved the row would notice a defect there. I put that in the ruling as a
numbered bound rather than in a closing aside, because "family G verifies the
first epoch" is exactly the over-reading this whole repair exists to prevent, and
the `/S/`-gated class the WO-0055 seeder rejected is now seedable against a row
that can see it.

**The boundary fix I executed at all three sites, and I rewrote the derivation
rather than the number.** Changing 1518 to 1519 and leaving the reasoning alone
would have left the cell asserting an endpoint without its boundary case — the
exact habit that produced both this error and the "100 octets" one. So each cell
now works it: a character at content `k` **replaces** that octet, so `k` octets
precede it, REQ-108 needs **more than** 1518, hence `k ≥ 1519`; at 1518 the frame
is not oversize at all and the character is REQ-110's or REQ-105's. **The figure
was right for where truncation triggers and wrong for where a character may be
placed after it**, and the correction says so in the cell.

**The consequential figure went with it**: the interval is **81 octets wide**, not
82. `RV-0055-VERDICT` §4 and `WO-0056` §1 both carry the 82 and both are closed
adjudications — **not edited**. The attack plan governs, which `WO-0056` §7
already directs, and I said so in the ruling rather than leaving two figures in
circulation with no stated authority between them.

**I folded the fix into this commit deliberately.** It is a boundary correction,
not a row change: no status moves, no count moves, and the delivered rows use
1588 and 1560, both far inside either reading — so nothing needs re-running and
the replay above stands unaffected. Separating it would have put the ruling's own
cited correction in a different commit from the ruling.

**And counting rather than recalling turned up a third arithmetic inconsistency
of mine.** `RV-0055-VERDICT` §8 said "30 rows benched" and its enumeration
omitted **M03-G5** while counting **M03-D4** and **M03-E3** — all three declared
NO-ASSERT rows carrying a codeless disposition. So I stated the rule that stops
it drifting: **a row is benched when the bench carries a committed disposition
for it — code for an ASSERT row, a declared statement for a NO-ASSERT one.**
Under it the figure was 31 then and is **33** now. **The ASSERT tally is
unaffected** (G5 is NO-ASSERT), so no coverage claim in any prior packet moves,
which is why this is a correction and not a finding.

### Actions
- **Adjudicated all four of §6's clauses** against the harvest, verbatim, and
  **RULED the standing consequence LIFTED**.
- Recorded the cosim clause as **predicted wrongly**, with the better fact that
  replaced it: class (f)'s exclusion demonstrated rather than argued.
- **Executed the AP boundary fix at all three sites** (M03-G7's Stimulus,
  M03-G8's Stimulus, §9's restatement), rewriting the derivation to work both
  boundary cases and correcting 82 → **81 octets**.
- **Verified counts unmoved**: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4
  STRUCTURAL, 1 GAP.
- **Recounted coverage by rule rather than by memory** and corrected
  `RV-0055`'s benched figure on the record.
- Named four bounds the lift does **not** carry, **M03-G7's lack of
  qualification** first among them.
- Appended the **LIFT RULING** to the WO-0056 packet. No `git`.

### Evidence
1. Harvest: `grep '^File "'` → **one** file, `test/xgmii_rx_64/test_m03_g.ml`;
   `grep -c '^@@'` → **1**. One failing unit in a twenty-seven-unit suite.
2. The message: `M03-G8 (lane 0): expected exactly one strobe (error_oversize
   alone -- NO error_bad_frame, §9's seventh ruling, C-12, in the epoch M03-G4's
   character never reaches), observed 2`, raised from `run_g8`.
3. Boundary derivation: a character at content `k` leaves `k` octets before it;
   REQ-108 needs `> 1518`; so `k ≥ 1519`. At `k = 1518` the frame is not oversize
   and the row's premise fails. Interval **1519 … 1599 = 81 octets**.
4. Post-fix: `grep -c '1518 … 1599'` → **0**; row and status tallies unchanged at
   78 / 62 / 7 / 4 / 4 / 1.
5. Coverage recount by the stated rule: A1–A5 (5), B1 (1), C1–C5 (5), L6 (1),
   D1–D4 (4), E1–E5 (5), F1–F4 (4), G1–G8 (8) = **33** benched; minus A4, D4, E3,
   G5 (NO-ASSERT) and L6 (STRUCTURAL) = **28 ASSERT-class**; 62 − 28 = **34
   outstanding**.

### Outcome
**The `RV-0055-VERDICT` standing consequence is LIFTED.** Family G verifies
REQ-108's window in both epochs — the second by M03-G1/G3/G4, the first by
**M03-G8** for an error character and by M03-G6 for the no-terminate case. A
packet may now cite family G for first-epoch behaviour **under an error
character**, and for nothing wider.

**The instrument worked exactly as specified**: the same unmodified diff that
survived twenty-five units killed one of twenty-seven, and it killed the row
written for it and nothing else.

**The owed boundary fix is executed** — 1519 … 1599, 81 octets, with both
boundary cases worked in the cells rather than merely computed. Counts unmoved.

**Coverage: 33 rows benched, 28 of 62 ASSERT discharged, 34 outstanding**, plus
F5 by citation. `SO-M03` does not issue.

### Open-questions
- **M03-G7 is unqualified** and that is the first thing family G's next campaign
  owes: the `/S/`-gated first-epoch class the WO-0055 seeder rejected is now
  seedable against a row that can see it.
- **The `/T/`-in-the-first-epoch case remains uncommissioned** — M03-G1's and
  M03-G2's own terminates already sit there, and the auditor's stated reason for
  rejecting a `/T/`-gated mutation (it re-plants G-c3's defect through the closure
  record) still applies.
- **`test/xgmii_rx_64/dune`'s WO-0056 line** is still owed under my `RV-0056` §8
  ruling — comment-only, rides with the next `test/**` touch.
- **My arithmetic-in-prose habit has a third instance** (the benched-row count),
  after "nineteen" at `RV-0047` and the interval endpoint at `J-dv_lead-0072`.
  Each was caught by counting rather than by recalling, and the rule is now stated
  in the ruling so the next count has a definition to follow.
- **Still owed**: the epoch-A no-output-word class (`J-dv_lead-0065`, rides with
  family H); AP-M14's §6 invariant; the `precompile_check.sh`
  side-effect-in-combinator lane; M03-F5's discharge-by-citation qualification;
  the RFC 1071 anchor on the next fetching run; X-7, X-10, X-11 deferred; L1–L5
  as a separate packet.

### Files-in-this-commit
- agents/handoffs/WO-0056_m03-g-discard-window-repair.md
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0076] 2026-08-06T13:10Z | task:WO-0056 | AP-M14's §6 invariant HOLDS, and establishing WHY is the useful half: it was never disturbed, where AP-M03's broke because a row was added to its spec after the plan was written

### Trigger
Orchestrator, item 2 of two: the AP-M14 §6-invariant check I flagged at
`J-dv_lead-0060` and have carried as owed since. SPEC-M14 is REQ-901 class (a)'s
home and `AP-ip_eth_rx_64.md` carries the same invariant AP-M03 had — check it,
repair if stale, or record that it holds.

### Inputs
- `test/attack_plans/AP-ip_eth_rx_64.md` §6 — its invariant sentence and its full
  coverage-map REQ column.
- `docs/specs/modules/ip_eth_rx_64.md` §10 — its full REQ column.
- The same two at **`df3e474`**, the commit that authored AP-M14.
- `J-dv_lead-0060` (where I raised it) and the AP-M03 §6 repair it came from.
- **No `libs/**`, no `docs/reports/audit/**`, no `/workspace/**`.**

### Reasoning

**It holds, and I checked both halves of it rather than the obvious one.** The
invariant is *"every REQ SPEC-M14 §10 lists appears exactly once"*, which is two
claims: **every** (set inclusion) and **exactly once** (no duplicates). A sorted
set comparison proves the first and **hides** the second, so I ran them
separately: `diff` on the two sorted lists is empty in both directions — 31
entries each, REQ-901 among them — and `uniq -d` is empty on each side. **No
repair is owed.**

**The useful half is why it held, because "it holds" alone tells nobody whether
to look again.** AP-M03's invariant broke because SPEC-M03 §10 **gained** a
REQ-901 row at `62c39a7` — the cascade — while AP-M03 had been written long
before. I checked the analogous history at M14: **SPEC-M14 §10's REQ list is
byte-identical to what it was at `df3e474`**, the commit that authored AP-M14,
and **REQ-901 was already in it then**. So M14's plan was written against the
list it still faces.

> **The invariant is not more robust at M14; it was simply never disturbed.** That
> distinction is the whole content of the answer, and it yields a standing
> re-check condition rather than a one-off result: **the M14 invariant becomes
> at-risk the moment SPEC-M14 §10 gains a row**, and the check is owed again then
> — by whoever adds it, not by whoever remembers.

**And that generalises to a rule the programme can use.** The failure mode is not
"attack plans drift"; it is **a class-home specification gaining a §10 row after
its attack plan was authored**. Every plan carrying this invariant is exposed to
exactly that event and to nothing else. Worth stating once here rather than
re-deriving at each plan.

### Actions
- Extracted both REQ columns mechanically and compared as **sets** (`diff`,
  empty both directions) and for **duplicates** (`uniq -d`, empty both sides).
- Extracted SPEC-M14 §10's REQ column **at `df3e474`** and compared against today:
  unchanged.
- **Recorded that the invariant HOLDS. No repair made, none owed.**
- Derived the standing re-check condition and the general failure mode.
- Touched **no file**. No `git`.

### Evidence
1. `diff` of AP-M14 §6's REQ column against SPEC-M14 §10's → **empty both
   directions**, 31 entries each, REQ-901 present in both.
2. `uniq -d` on each column → **empty**; the "exactly once" half holds on both
   sides.
3. SPEC-M14 §10's REQ column at `df3e474` vs today → **identical**; REQ-901
   present at authoring time (`grep -c` → 1).
4. `git log --diff-filter=A -- test/attack_plans/AP-ip_eth_rx_64.md` → `df3e474`
   ("WO-0027: first attack plans — AP-M03 … + AP-M14 …").

### Outcome
**AP-M14's §6 invariant HOLDS** — set-identical and duplicate-free on both sides
— and **no repair is owed**. The debt raised at `J-dv_lead-0060` is discharged.

**Why it held**: SPEC-M14 §10 has not moved since AP-M14 was authored, and
REQ-901 was already there. AP-M03 broke because its spec gained a row afterwards.
**The standing re-check condition is therefore an event, not a date: any addition
to a class-home spec's §10 re-opens its plan's §6 invariant.**

### Open-questions
- **The re-check is owed on the event, not on a schedule.** If SPEC-M14 §10 ever
  gains a row, AP-M14's §6 must be re-checked in the same round — the mistake at
  M03 was that nobody looked, not that anyone looked late.
- **Two other plans may carry the same invariant** if more attack plans exist or
  are written; I checked only M14 because it is the one I flagged. Worth a sweep
  when the next plan is authored rather than a separate packet now.
- Unchanged from `J-dv_lead-0075` and not repeated here.

### Files-in-this-commit
- (none)

## [J-dv_lead-0077] 2026-08-06T15:45Z | task:WO-0057 | Family H authored — and the design's two real findings are that M03-H4 drives both no-output-word shapes in one stimulus, and that §0.6's window has no referent for a frame that delivered nothing

### Trigger
Orchestrator, item 1 of two: family H is next on the sponsor-approved queue.
Author the WO-0057 packet for tb_writer against `AP-xgmii_rx_64.md` §4.H under
the plan as it stands at `6dd229c` (78 rows, 62 ASSERT, corrected first-epoch
boundary), with everything accreted binding, and say in the packet where family
H's design interacts with family G's next campaign rather than leaving it to be
discovered.

### Inputs
- `test/attack_plans/AP-xgmii_rx_64.md` §4.H's four rows **in full**, §4.B's
  M03-B4 (REQ-110's only currently-driven row), §4.M's M03-M5, §7's X-1 and X-5
  entries, §8 item 5 (the uncitable claim).
- `docs/specs/requirements.md` REQ-110 (its zero-delivered clause), REQ-101,
  REQ-103, REQ-105, REQ-021, REQ-008, **§0.6 and its C-23 counting convention**,
  §0.7.
- `docs/specs/modules/xgmii_rx_64.md` §6.1's two-events-in-one-word paragraph and
  its six-row table, §6.3 items 3 and 8, §9's fifth ruling, rows 8 and 9, and the
  strobe pin's no-output-word clause.
- `test/xgmii_rx_64/test_m03_f.ml`'s `run_f2` **`k = 0` window branch** — the
  precedent that settles §3.2.
- `RV-0055-VERDICT` §4 (M03-G7 unqualified, the `/S/` class seedable);
  `RV-0056-VERDICT` §1 and §8; `J-dv_lead-0065`, `J-dv_lead-0070`,
  `J-dv_lead-0075`.
- **No `libs/**`, no `docs/reports/audit/**`, no `/workspace/**`.**

### Reasoning

**The first thing I checked is what REQ-110 is actually verified by today, and
the answer is narrower than the family's size suggests.** Exactly one committed
row drives it — **M03-B4**, a `/S/` in lane 4 of a word whose lane 0 carried a
`/S/`, **with no frame open before it**. So **nothing anywhere aborts a frame that
has already delivered octets**, and REQ-110's central sentence — the aborted
frame's last delivered octet is the one immediately preceding the new start
character — is unverified in both directions. That is the packet's §1, and it is
the same check I ran at `WO-0047` §1.1 for REQ-107, where it turned the packet's
premise inside out. Here it confirmed it.

**Two silently-always-pass classes live here and they are not the same shape**,
which is why the packet ranks the rows rather than listing them. A design that
**strips the FCS on the abort path** delivers four octets too few and pulses
everything correctly — M03-H1 closes it. A design that **switches its alignment
offset on the same cycle it accepts the new start character** loses four octets
**with no strobe at all** — M03-H2 closes it, and only if the row asserts the
aborted frame's octet-by-octet **content**. I said that explicitly, because a
version of H2 that asserts the strobe and the second frame and stops **does not
kill the defect the row exists for**, and that version is the natural one to
write.

**M03-H4 is the risky row and I told the worker to build it last.** It is the
C-23 row: two aborts, both zero-delivered, both closed strictly inside their own
preambles, with `error_start_without_terminate` high on **consecutive** cycles
`c + 2` and `c + 3`. §0.6 as revised counts **high cycles, never rising edges**,
so a rising-edge counter sees one event where a conformant M03 reported two — and
**passes**. The instruction is to register two expected events with
`Strobe_monitor`, whose `sample` is total over the run, and **not to hand-roll a
count**, because a hand-rolled count is exactly the thing C-23 exists to forbid.

**And working H4's geometry produced the design's first real finding.** Frame A's
start and its closure lie in the **same input word** (`8c` and `8c + 4`); frame
B's lie in **different** words (`8c + 4` in word `c`, closed at `8c + 8` in word
`c + 1`). **So M03-H4 drives both no-output-word shapes in one stimulus, which no
other row in this programme does** — and the epoch-A zero-delivered class owed
since `J-dv_lead-0065` is supplied here, which is why I routed it to family H
three entries ago and can now say *why* rather than *that*.

**That derivation is pure §6.1 word geometry and I was careful to keep it there.**
The temptation was to reach for the auditor's WO-0055 disclosure, which describes
the design's two implementations of the no-output-word report. That would be
reasoning from RTL into a test design. The distinction I held to: **a frame whose
start and closure lie in different input words** is a statement about the
stimulus, derivable from §6.1 alone, and it is the only form of the fact the
packet carries.

**The second finding is a genuine specification gap, and it is the G6 question
again in a different family.** §0.6's window upper bound is ΔC = 3 after the input
word carrying the frame's **last received octet** — and **M03-H4's frames received
none**. No referent. I ruled it the same way I ruled G6 and on stronger ground
than I had then, because two supports now exist: the **principle** the architect's
truncation-closure ruling derives from (a frame's report is a function of the
frame, and the closure event is the last thing belonging to it), and an
**existing precedent in this bench** — `run_f2`'s `k = 0` branch already uses the
closing word for a frame that received nothing. So the instruction is grounded in
practice rather than invented, the exact pin carries the assertion either way
(`RV-0047` ruling 2), and the generalisation question goes to the architect
**blocking no row**.

**I also stated what has no instance here**, because absence read as oversight is
how the last two rounds' findings started: family H has **no oversize frame**, so
the truncation-closure ruling itself does not apply; and **§6.3 item 8's carve-out
is not violated** by H4 — its two reports share a strobe *name* but land on
**consecutive** cycles, not the same one. I checked that rather than assume it,
and recorded it so a campaign does not have to rediscover it.

**On the interaction the dispatch asked me to name, there are three and the first
is mutual.** M03-G7 is benched but **unqualified**, and the `/S/`-gated class is
now seedable against it — while family H is full of start characters. **So the
next G campaign's MUST-STAY-GREEN column must account for every unit in
`test_m03_h.ml`, and family H's own campaign must account for M03-G7. Neither can
be sealed without the other's unit list.** That is the kind of thing that, unsaid,
becomes an unnamed-unit finding at adjudication — which is precisely what happened
to me at WO-0050 with T-E4.

**And I barred the one claim that would make this family's reasoning easy and
wrong.** `WO-0047` §1.2's shared-no-output-path claim is still uncitable; H4 is
exactly where someone would reach for it. The packet says so at the point of
temptation rather than in a preamble.

### Actions
- Checked REQ-110's existing coverage (**M03-B4 alone**) before writing the
  packet's premise.
- Authored **`agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md`**:
  four rows **ranked by risk** with H4 last; §3.1's `Frame.delivered` trap on the
  abort path with a per-member governance deliverable; §3.2's zero-delivered
  window ruling with both its supports; §4's constant/guard/boundary discipline
  carrying the `k = 1518` lesson explicitly; §5's assertion-order contract; §6's
  three named interactions with family G's next campaign; §7's two upward items;
  §8's `dune` line including WO-0056's still-missing one; §9's bars; §10's eight
  deliverables.
- **Derived and recorded** that M03-H4 drives both no-output-word shapes, keeping
  the derivation inside §6.1's geometry.
- **Verified** §6.3 item 8 has no instance at H4 (consecutive, not coincident).
- Touched no attack-plan row and no test file. No `git`.

### Evidence
1. REQ-110's committed coverage today: **M03-B4 only** — a `/S/` in lane 4 of an
   `/S/` word with no frame open before it. No row aborts a frame that has
   delivered octets.
2. H4 geometry from §6.1: frame A opens `8c`, closes `8c + 4` → **same word `c`**;
   frame B opens `8c + 4`, closes `8c + 8` → **words `c` and `c + 1`**. Both
   shapes, one stimulus.
3. §9's no-output-word pin (two cycles after the closing input word) gives
   **`c + 2`** and **`c + 3`** — consecutive, so §6.3 item 8 (two frames reported
   on **one** cycle under **one** name) has no instance.
4. §0.6 as revised: "one high cycle per reported event … a monitor counts high
   cycles, never rising edges" — the basis for H4's two-event registration.
5. `test_m03_f.ml`'s `run_f2`: `expected_not_after = if k = 0 then closing_cycle +
   3 else ((closing_ot - 1) / 8) + 3` — the zero-received precedent §3.2 rests on.
6. `AP` §7's X-5 entry names **H1 and H2** among its intended customers, which is
   why §6 item 3 asks for its second confirmation.

### Outcome
**WO-0057 authored and ready to issue.** Four rows commissioned, **ranked by
risk** with M03-H4 named as the one to build last; two derivation traps stated
before the rows; the zero-delivered window ruled with its precedent cited and its
generalisation routed up; three interactions with family G's next campaign named
in the packet; and the uncitable claim barred at the point where it would be
reached for.

**Two findings came out of the design rather than out of a run**: M03-H4 supplies
**both** no-output-word shapes in one stimulus — discharging *why* the epoch-A
class rides with family H — and **§0.6 has no reference word for a frame that
delivered nothing**, which is the M03-G6 question recurring in a family with no
oversize frame in it.

`SO-M03` does not issue; after family H, **32 of 62 ASSERT rows** would be
discharged.

### Open-questions
- **§0.6's reference word for a zero-delivered frame** — routed to
  architect_docs_lead. Blocks no row; the bench already has a precedent and the
  exact pin carries every assertion.
- **The next G campaign and family H's campaign are coupled.** Neither's seal can
  be written without the other's unit list, and I would rather that were decided
  before either freeze than discovered at an adjudication.
- **M03-G7 remains unqualified** until a `/S/`-gated class is seeded against it.
- **`test/xgmii_rx_64/dune` carries neither a WO-0056 nor a WO-0057 line** — both
  are in this packet's §8, comment-only.
- **Still owed**: AP-M14's sweep companion if more plans are written
  (`J-dv_lead-0076`); the `precompile_check.sh` side-effect-in-combinator lane;
  M03-F5's discharge-by-citation qualification; the RFC 1071 anchor on the next
  fetching run; X-7, X-10, X-11 deferred; L1–L5 as a separate packet.

### Files-in-this-commit
- agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md

## [J-dv_lead-0078] 2026-08-06T18:30Z | task:WO-0057 | Family H ACCEPTED — four clean rows, and every finding of the round is against my own plan or my own machinery; the G/H campaigns are RULED into one, scored on five units against a 26-unit floor

### Trigger
Orchestrator: tb_writer returned `WO-0057` at `f806272` — `test/xgmii_rx_64/
test_m03_h.ml` (four rows, built in my own risk order H1, H3, H2, H4), the
`dune` header line, and a RETURNED log. Review round in the `RV-0056` shape,
plus two rulings the dispatch asked for by name: the G/H campaign coupling I
carried out of `J-dv_lead-0077` as an open question, and the worker's
non-blocking shared-device flag.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3 packet classes and
  lifecycle, §4 entry grammar, §5's R2/R3/R4/R5/R7, §6 write scopes, §10's
  independence rules and **R-SEAL-1**).
- `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md` in full,
  my own §1–§11 re-read against the return rather than from memory.
- **`test/xgmii_rx_64/test_m03_h.ml` in full (1024 lines)** and the one-line
  `test/xgmii_rx_64/dune` diff, both at `f806272` via `git show`.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.H rows M03-H1 … M03-H4 verbatim, §4.G
  rows M03-G3/G4/G6/G7/G8, §6's REQ-007/008/021/103/105/108/110 rows, §7's X-3
  and X-5 entries.
- `docs/specs/requirements.md` §0.3, §0.5 (front offset, ΔC identity, the
  per-start-lane exception), **§0.6 in full** (window, C-23 counting, frame
  conservation), §0.7, REQ-101, REQ-102, **REQ-103** (its no-removal sentence),
  REQ-105, REQ-107, REQ-108, **REQ-110**, REQ-007, REQ-008, REQ-019, REQ-021.
- `docs/specs/modules/xgmii_rx_64.md` §6.1 (preamble geometry, the
  two-events-in-one-word paragraph **and its six-row table**, the emission rule
  and C-18's two non-instances), §6.2 (all four state rows, `Idle` in
  particular), §6.3 items 3, 5, 6 and **8**, §7 (L = 16 / 12, h = 8 / 12,
  ΔC = 3), **§9 in full** (the nine-row table, the closure list, "Strobe cycle,
  pinned", the zero-referent paragraphs, the fifth co-occurrence ruling).
- DV machinery, read to review the file against its contracts, not to write
  RTL-derived tests: `test/xgmii_rx_64/bench.mli`, `test/monitors/
  strobe_monitor.mli`, `test/monitors/octet_time.mli` (`Latency.frame_in` /
  `frame_out`'s `?expected_octets`), `test/monitors/conservation_monitor.mli`,
  `test/monitors/stream_word.mli`, `test/xgmii/injection.mli`, **`test/xgmii/
  injection.ml` lines 130–300** (the `Place` octet-time arithmetic, the `/S/`
  lane validation, `Arrival.create ~fcs_valid:false`, `tlast_cycle_of`,
  `no_output_cycle`, `window`), `test/xgmii/arrival.mli`,
  `test/xgmii_rx_64/test_m03_g.ml` (M03-G7's construction and
  `account_resync_runt_frame`; the total-output-word idiom at G6/G7/G8).
- `agents/journals/workers/claude_tb_writer_agent.md` entry `J-tb_writer-0015`
  (Trigger, Inputs, Reasoning — read for independence discipline).
- `agents/journals/claude_architect_docs_lead_agent.md` `J-architect_docs_lead-0021`
  and `docs/specs/modules/xgmii_rx_64.md`'s 2026-08-04 change-log row, to verify
  the ruling the file cites for the zero-delivered window is the one it names.
- `.github/workflows/build.yml`'s header (ADR-0005's authority statement); the
  GitHub Actions API records for runs **30862176345** and **30862176314**.
- My own `J-dv_lead-0074`, `-0075`, `-0077`; `RV-0056-VERDICT` and the LIFT
  RULING in `WO-0056`.
- **No `libs/**`, no `top/**`, no `bin/**`, no `rtl_snapshots/**`, no
  `docs/reports/audit/**`** — at any point in this spawn.

### Reasoning

**The review method was re-derivation, because a green run is the one thing this
round could not have been short of.** The four units executed for the first time
anywhere and passed, so nothing was going to be found by reading a failure.
I re-derived every octet time, lane, output-word count, `tkeep`, `tlast` cycle
and §0.6 window in all four rows from the frozen text — §6.1's geometry, §7's
`L = 16 / 12`, §9's two pinning rules — and compared against the file. They
agree everywhere, and the places where agreement was not automatic are what the
verdict spends its length on.

**Three cross-checks I would not have got from the assertions.** First, the
splice's geometry closes exactly at every row: the following frame's content
ends one octet time before `Arrival`'s auto-placed terminate character, so the
second frame is a genuine REQ-103 frame and "no `error_bad_fcs`" is a live
assertion. Second — and this one could have made the whole file vacuous —
`Injection.create` passes `~fcs_valid:false` to `Arrival.create`, and
`fcs_valid` gates only `Arrival.check`'s residue verification; it never edits
octets. Had `Arrival` recomputed a residue over the spliced array, every row
would have been asserting "exactly one strobe" against a frame whose FCS the
stimulus had just broken, and all four would still have been green if the model
made the same assumption. Third, §6.3 item 8's prohibition: I had claimed at
`J-dv_lead-0077` that M03-H4 does not violate it; I have now verified it on the
**built stimulus** — word `c` carries two start characters but ends exactly one
frame, word `c + 1` ends exactly one, and item 8 bars a word carrying two
frame-**ending** characters.

**The M03-H2 finding is against my own attack plan.** §4.H's outcome cell says
the four octets are proved by "`tkeep` and the delivered count". At a lane-4
start REQ-101's absolute-lane rule forces `k ≡ 0 (mod 8)`, the aborted frame
delivers a whole number of words, `tkeep` is `0xFF`, and it distinguishes
nothing. The parenthetical is true at one of the two alignments the row is
driven at. The bench is unaffected because `WO-0057` §2.3 required the **content**
assertion and `run_h2` makes it at both lanes — so the row is proved by the
instrument that works everywhere and my cell over-promised about a weaker one.
Same disposition shape as `RV-0056` §1's `k = 1518`: no bounce, footnote owed to
the plan at its next touch, file is the authority meanwhile. (I confirmed the
`1518 → 1519` repair itself landed at `J-dv_lead-0075` and is not outstanding.)

**Three findings are about what a green does not prove, and I am recording them
now because the campaign is the next dispatch.**

1. `account_spliced_forwarded` builds its input trace as `8 + delivered`, but
   `Latency.frame_in`'s contract wants the frame's octets **DA through FCS**. On
   an aborted frame `received = delivered` and it is right; on a **clean**
   spliced frame the two differ by four and the array is four octet times short.
   It is harmless **by cancellation** — the identity extent is `delivered − 4`,
   `~expected_octets:delivered` overrides it back, and the delivered octets are
   a prefix so the comparison never reads past index `8 + delivered − 1`. Two
   errors that cancel exactly, sitting **on** `frame_out`'s stated bound. No
   assertion is wrong; a monitor is being handed a fact that is not true.
2. The strobe monitor's §0.6 window check **cannot fail on a zero-delivered
   frame**. §9 pins such a frame at `closing_word + 2` and §0.6's window is
   `[closing_word, closing_word + 3]` — both functions of one quantity — so the
   pin is inside by arithmetic, whatever either rule said. That is my
   specification's two rules meeting, not the worker's code, and it holds
   identically at `run_f2`'s `k = 0` member and M03-G7's resynchronised runt. It
   matters because X-3's check (c) exists to catch a **specification** defect of
   exactly the M03-R2 class, and at M03-H4 it is a tautology. The row's real
   assurance is the exact two-element `error_pulses` list and the
   consecutive-cycle check — which is where I put it.
3. No ordinary two-frame row in the M03 bench excludes a spurious **third**
   output frame. `test_m03_h.ml` follows `test_m03_g.ml`'s idiom exactly (the
   total-output-word check appears where a *third piece* must emit nothing —
   G6, G7, G8, and M03-H4 — and not otherwise), so this is **not** a deviation
   and not a WO-0057 defect. It is a coverage fact spanning roughly a dozen
   units across D, E, F, G and H, and it belongs on the record before a campaign
   seals classes against them rather than after one survives.

**On the campaign coupling I ruled ONE campaign, and the reason is that the two
obligations are one experiment.** M03-G7 and family H owe the same defect
*site*: the receiver's response to a start character arriving while a frame is
open — G7 inside REQ-108's first epoch, H1/H2/H4 on the ordinary path, H3 the
ruling that it stops being that event once an `/E/` has closed the frame. A
`/S/`-gated class moves units in both families at once, which is exactly why
neither seal could be written without the other's unit list. Two sequenced
campaigns would seed the same predicate twice and score the second against a
bench the first had already measured — **two readings of one experiment reported
as two kills**, which is the inflation `RV-0055` already cost me once. I
rejected waiting for families I–N on the opposite ground: G7 is the oldest open
DV debt on this module, and making it wait on unwritten benches is the trap that
produced the coupling.

**On the shared-device flag, the count was right and the object was not, and
that changed the answer.** I checked the five sites. There are **two** devices:
the hand-built spliced array (four sites, all in `test_m03_h.ml` — M03-G7 does
**not** use it; `run_g7` is an ordinary two-`frame_case` `create`), and the
accounting for a frame the *stimulus* opened, which has no `Arrival.frame`
record (five sites across two files, already duplicated as
`account_resync_runt_frame` and `account_spliced_dropped`). So: no promotion for
the first (one file, no second customer), deferred for the second to the third
file that needs it, with Finding 1 repaired in that same edit — a device that is
right by cancellation must not be promoted while it is wrong. And the literal
question answers itself once the object is named: **a MUST-STAY-GREEN list names
units, never devices** — naming one there makes the column unfalsifiable. What
the flag was really pointing at is a **correlation**: five units share one
accounting path, so a class that moves it moves all five and they are not five
independent kills. That goes in the campaign's class rationale, and it is the
part worth having asked.

**What I did not do.** I did not touch `AP-xgmii_rx_64.md` — no finding required
it, and the M03-H2 footnote rides with the plan's next touch. I did not open
RTL. I offered no `SO-`.

### Actions
- Reviewed `test/xgmii_rx_64/test_m03_h.ml` and the `dune` line at `f806272`
  line by line against `WO-0057` §-by-§ and `AP` §4.H's four row contracts.
- Re-derived independently: H1's `At_octet 64` lane identity at both starts and
  its `[m + 9, m + 11]` window against an `m + 10` pin; H3's `e_idx = 24 / 20`
  lane-0 landing and the exact `s_cycle = e_cycle + 2`; H2's per-lane `k` from
  REQ-101's absolute-lane rule and the four-octets-in-the-`/S/`-word geometry at
  **both** lanes; H4's full three-frame octet-time layout, its `c + 2` / `c + 3`
  pins from §9's no-output rule, and its windows from §0.6.
- Verified the splice's terminate placement, `Arrival.create ~fcs_valid:false`,
  and §6.3 item 8's non-instance on the built stimulus.
- **Counted the units myself**: 31 in `test/xgmii_rx_64/` (A 3, B 1, C 4, D 3,
  E 4, F 4, G 7, H 4, structural 1) — the worker's figure reproduces.
- Verified both CI runs through the Actions API rather than accepting the relay.
- Appended **`RV-0057-VERDICT`** to
  `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md`: ACCEPT,
  four row dispositions, four numbered findings, two Return-log corrections, the
  CI section, the campaign ruling with its unit lists, and the shared-device
  ruling.
- Touched no attack plan, no test file, no spec. No `git`.

### Evidence
1. **CI at `f806272`, verified not relayed**: run **30862176345** (`build`,
   run 268) `conclusion: success`, `head_sha`
   `f8062722da52d5aa304557a26d42cdd61207684f`; run **30862176314**
   (`journal-check`, run 286) `conclusion: success`, same `head_sha`. Read from
   the GitHub Actions API.
2. **The four units genuinely ran**: `test/xgmii_rx_64/dune` declares no
   `(modules …)` field, so every `.ml` in the directory is in the library;
   `grep -c 'let%expect_test' test/xgmii_rx_64/test_m03_h.ml` = **4**;
   repository M03 total **31**. All four `[%expect]` blocks are `{||}` and the
   determinism step passed, so nothing was promoted (ADR-0005 rule 2).
3. **`fail_cross` passed in all four rows** — `Injection`'s own §6.2/§9 walker,
   evaluating a splice no committed caller had built before, independently
   reproduced the delivered counts, strobe names, pinned cycles and §0.6 windows
   the file derived by hand.
4. **H1's window is the tighter of the two forms in the bench**:
   `((close_ot − 1) / 8) + 3` (last **delivered** octet's word + ΔC), one cycle
   tighter than family G's `closing_cycle + 3`, and it matches
   `injection.ml`'s `window` exactly.
5. **The M03-H2 lane-4 arithmetic**: `k = 16`, `start_ot ≡ 4 (mod 8)`,
   `delivered = 16`, `16 mod 8 = 0`, so `tkeep = 0xFF` — the AP parenthetical's
   proof mechanism is unavailable at that alignment, and `got1 = filler k` is
   what carries the row there.
6. **Finding 1's cancellation, exactly**: `in_times` length `8 + delivered`;
   identity extent `delivered − 4`; override `delivered`; comparison indices
   `8 … 8 + delivered − 1`; bound `expected_octets ≤ len − strip_octets` met at
   equality (`60 ≤ 60`).
7. **Finding 3's idiom check**: `grep -n 'List.length (delivered_samples'`
   returns `test_m03_g.ml` lines 1185, 1472, 1685 (G6, G7, G8) and
   `test_m03_h.ml` line 971 (M03-H4) — and nothing else in the bench.
8. **The citation the file rests its window on is the right one**:
   `J-architect_docs_lead-0021`, 2026-08-04, SPEC-M03 §9's zero-referent
   paragraphs, committed at `1004384`.
9. **Independence**: `J-tb_writer-0015`'s Inputs list specs, the packet, the
   attack plan and DV machinery only, and state explicitly that no path under
   `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**` or `docs/reports/audit/**`
   was opened. The file's own docstring repeats it.

### Outcome
**`WO-0057`: RETURNED → ACCEPTED.** Four ASSERT rows built and clean; the bench
pins what §4.H's contracts name, in `WO-0057` §5's order, with no
mechanism-testing and no unsupported state claim. **Nothing returns to the
worker and the round does not reopen.** After family H, **32 of the plan's 62
ASSERT rows** are discharged. `SO-M03` does not issue and is not offered.

**Two rulings delivered, both dispatchable.** (1) The next M03 mutation campaign
is **one** campaign covering M03-G7's qualification and family H's: scored set
**five units** (G7, H1–H4), MUST-STAY-GREEN the complement within the M03
bench's 31 — **26** when a class targets one of the five — plus the whole non-M03
suite, all re-measured at the campaign's base SHA; `g-c4` explicitly out of
scope as already adjudicated; three constraints carried from this round's
findings. (2) The shared device is **not** named in a MUST-STAY-GREEN list (that
column names units), is **not** promoted to `Bench` now, and **is** named in the
campaign's class rationale as a correlation across the five scored units.

Handoff: `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md`,
`RV-0057-VERDICT` block, to the orchestrator for transcription of the state flip
and for the campaign dispatch.

### Open-questions
- **The campaign packet is owed and is mine to draft** — with its
  `-SEALED-predictions.md` companion frozen in the same commit, before any
  manifest diff exists (R-SEAL-1 forward commitment; I hold no mapping today).
- **Owed to `AP-xgmii_rx_64.md` at its next touch**: the M03-H2 parenthetical
  footnote (§4.H) — `tkeep` proves the four octets at a lane-0 start only.
- **Owed to `test/**` at its next touch**: `account_spliced_forwarded`'s
  `~received`-vs-`~delivered` input trace (Finding 1), M03-H3's §6.2 `Idle`
  citation (Finding 4), and the total-output-word line at the ordinary two-frame
  rows (Finding 3).
- **§0.6's reference word for a zero-delivered frame** — still with
  architect_docs_lead as a scope question; blocks no row, and Finding 2 now adds
  that the window check is vacuous on that class either way.
- **Still owed**: AP-M14's sweep companion if more plans are written
  (`J-dv_lead-0076`); the `precompile_check.sh` side-effect-in-combinator lane;
  M03-F5's discharge-by-citation qualification; the RFC 1071 anchor on the next
  fetching run; X-7, X-10, X-11 deferred; families I, J, K, M, N and L1–L5
  unwritten.

### Files-in-this-commit
- agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md
