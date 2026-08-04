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

## [J-dv_lead-0079] 2026-08-06T20:40Z | task:WO-0058 | The combined G7+H campaign drafted and its seal frozen in the same commit — seven classes, fourteen REQUIRED cells, and the two places where two classes could be one measurement are named before the diffs exist

### Trigger
Orchestrator, following my own `RV-0057-VERDICT` §8 ruling: draft the campaign I
declared dispatchable, as `WO-0058`, with the sealed class → predicted-red
mapping frozen in the **same commit** — the R-SEAL-1 forward commitment I made at
that verdict, redeemed before any manifest diff exists. My own ruling is the
specification for this round.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` §3 (packet forms and the
  withheld-results clause), §4.1/§4.2, §6, §10 (**R-SEAL-1**, ADR-0016).
- `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md` — the
  packet §5/§6/§7 and **`RV-0057-VERDICT` §2 (FINDING 1), §3 (FINDING 2), §4
  (FINDING 3), §8 (the campaign ruling), §9 (the D1/D2 device ruling)**, read
  back in full rather than recalled.
- `agents/handoffs/WO-0055_family-g-mutation-campaign.md` and its
  `-SEALED-predictions.md` companion — the form this packet follows, and
  `RV-0055-VERDICT` §3's **FINDING G-1** (a sealed cell asserted from a category)
  and §4's **FINDING G-2**, which are the two errors this seal is built not to
  repeat. `WO-0056`'s **LIFT RULING** §1–§2 (g-c4 adjudicated and closed; M03-G7
  stayed green under it "the diff being gated on an error character").
- **Committed test sources**, read as the object under test — `test_m03_h.ml` in
  full; `test_m03_g.ml`'s `run_g1`, `run_g2_legal`/`run_g2_oversize`, `run_g3`,
  `run_g4`, `run_g6`, `run_g7`, `run_g8`; `test_m03_e.ml`'s `run_e1` and
  `run_e4`; `test/xgmii_rx_64/bench.ml`'s `run`, `error_pulses`,
  `delivered_samples`, `assert_monitors_clean`; `test/monitors/strobe_monitor.ml`
  (to establish that monitor errors accumulate and are raised last, so the first
  `fail` in each row's own order is what a campaign sees); the four `dune`
  stanzas that fix the blast radius.
- `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2 (`Preamble`/`Frame`/`Discard`
  rows), §6.3 items 6 and 8, §7, §9 (closure list; table rows 2, 3, 7, 8, 9; the
  fifth and sixth co-occurrence rulings; the pinned-strobe-cycle section);
  `docs/specs/requirements.md` REQ-110, REQ-108, REQ-105, REQ-103, REQ-101,
  REQ-021, REQ-008, REQ-007, §0.3, §0.6, §0.7.
- CI, read through the Actions API rather than assumed: run **30865856907**
  (`build`, run 271) at `a2d090d`, **both jobs green**.
- **No `libs/**`, no `top/**`, no `bin/**`, no `rtl_snapshots/**`, no
  `docs/reports/audit/**`** — at any point in this spawn. No prior campaign's
  SEALED file was opened.

### Reasoning

**Why seven classes and not five.** The scored set is five units and every one of
them must be reachable by at least one class, or the campaign qualifies nothing
at the row it skips. M03-G7 needs the `/S`-in-`Discard` class (GH-c1) — the
variant the WO-0055 seeder rejected on minimality grounds and `RV-0055` §7 bound
3 named as a candidate of its own. M03-H3 needs the `/E/`-closure class (GH-c2),
because every other class here is gated on a REQ-110 abort and M03-H3's whole
point is that its `/S/` is **not** one. M03-H4 needs the C-23 collapse class
(GH-c7), which no other unit in the bench can even see. M03-H1 and M03-H2 are
reached by four (GH-c3 through GH-c6). Fewer classes would have left a scored row
unqualified; more would have been padding.

**The hard problem this round was scope collision, not class invention.** M03's
error paths share machinery: one "this frame ended without a terminate character"
gate serves REQ-105's abort, REQ-108's truncation and REQ-110's abort, so a
minimal diff aimed at one can land on all three. My first instinct was to
over-specify the intents until only one rendering was possible — which is exactly
the F-c8 mistake `RV-0050` cost me, where pinning a mechanism made half a class
unseedable. **So I did the opposite and made the seal a function of a required
disclosure**, the G-c4 method: the packet states each class's scope, requires the
seeder to say what its diff actually reaches, and the seal carries an exact
branch per answer. GH-c2 has two branches, GH-c3 three, GH-c5 two, GH-c4 two
readings. Every branch is worked; the one rendering I could not work — an `/E/`
that stops closing the frame at all — is marked **UNWORKED** in the seal with its
adjudication rule fixed in advance: that disclosure scores the class as *not
seeded*, and no claim about the bench is made from it in either direction.

**Where FINDING G-1 could have recurred, and what I did instead.** Every cell in
this seal that rests on "the receiver is in state X when this character arrives"
carries the row's own arithmetic. The G-family cells are the exact shape of the
cell I got wrong at WO-0055: T-G7 REQUIRED because `run_g7` **guards**
`inject_ot > start_ot1 + 8 + 1518 && inject_ot < terminate1`; T-G6 REQUIRED
because it replaces frame 1's terminate with an idle character and asserts the
substitution landed; **T-G3 GREEN because its second frame's `/S/` is scheduled
at content 1620 and frame 1's terminate is at 1600** — twenty octet times
earlier, so `Discard` was left before the character arrived. That last cell is
the one FINDING G-1 was, re-derived from source rather than from the category
"a character past the truncation point".

**Two classes could be one measurement, and I named both places before the
diffs.** GH-c3(i) and GH-c4(b) produce a **character-identical** message at
M03-H2 and differ at M03-H1 **only in the lane label** — because M03-H1's `/S/`
lands in the same lane as its frame's own start, so a lane-independent
extent defect speaks at lane 0 while an alignment defect that needs octets below
the `/S/` speaks at lane 4. And GH-c5 and GH-c7 both print `observed 1` at
M03-H4, separated only by whether M03-H1 and M03-H2 also move. Both collisions
are written into the seal with the rule that a coincidence there is **one defect
measured twice**, not two kills. That is `RV-0055`'s inflation lesson applied
where it can actually recur, rather than restated as a principle.

**On the D2 correlation the verdict ordered carried, the useful half turned out
to be a negative.** D2 — the accounting for a frame the stimulus itself opened —
spans all five scored units, so a class detected *through it* would be one
measurement replicated five times. But in every one of those rows the accounting
calls and `assert_monitors_clean` come **after** every assertion, so a row that
reddens never reaches them: **no cell in this seal is scored on D2's output**, and
I said so with the line numbers so it can be checked rather than trusted. What
survives as a live warning is the weaker correlation I found while writing the
messages — four of the seven classes are detected by the same
exact-`error_pulses` idiom, replicated per row, which makes those units
independent measurements of the *stimulus geometry* and not of the *property*.
Both statements are in `WO-0058` §4.1, and the kill unit is fixed as the **class**:
seven classes, at most seven kills, fourteen REQUIRED cells that are evidence of
blast radius and nothing more.

**Base SHA `a2d090d`, chosen not inherited.** The bench landed at `f806272` and
two packet-only commits followed; `git diff f806272 a2d090d -- test/ libs/ tools/
dune-project` is empty, so the compiled surface is identical and I take **the SHA
CI actually ran green on** — run 30865856907, both jobs, verified through the API
— which is the WO-0050/WO-0055 precedent and removes any byte-identity inference
from pass criterion 3. Denominators re-measured at that SHA with
`tools/dv_checks.sh`'s inventory block rather than carried: **31 M03 units, 111
repository-wide, 80 non-M03**.

**What I did not do.** I did not touch `AP-xgmii_rx_64.md`, any test file or any
spec — everything owed there stays owed and is re-listed below. I did not open
RTL. I did not gate this draft on the architect's answer to the §0.6
zero-delivered referent question: the campaign seals against the **bench at the
base SHA**, and FINDING 2 already establishes that M03-H4's window check cannot
fail either way, so nothing in the mapping moves on that ruling.

**The mapping, second copy** (row sets only; the messages, the MUST-STAY-GREEN
columns and the reasoning live in the sealed file):

| class | narrow-branch REQUIRED | disclosure branches |
|---|---|---|
| GH-c1 `/S/` in `Discard` read as a second abort | T-G7, T-G6 | none |
| GH-c2 `/E/`-closed frame re-aborted by the next `/S/` | T-H3 | wide: + T-E4, T-G4, T-G8; third rendering UNWORKED |
| GH-c3 FCS removal on a `/S/`-aborted frame | T-H1, T-H2 | +REQ-105: + T-H3, T-E1; +REQ-108: + T-G1, T-G2, T-G3, T-G4, T-G6, T-G7, T-G8 |
| GH-c4 new frame's alignment on the aborted frame's octets | T-H1, T-H2 | two readings, same row set |
| GH-c5 the aborting `/S/` opens no new frame | T-H1, T-H2, T-H4 | wide: + T-G7, T-G6 |
| GH-c6 `error_start_without_terminate` never pulses | T-H1, T-H2, T-H4 | none |
| GH-c7 consecutive same-name reports collapsed | T-H4 | none |

### Actions
- Authored `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md`: base SHA and
  its control run, the scored set and re-measured denominators, the standing
  allowlist and five process bars, **seven** mutation intents each with a scope
  clause, the kill-counting rule with the D2 correlation, and the two
  constraints that bound what a result may be read to mean (FINDING 3's blind
  spot, FINDING 2's vacuity) — the three constraints `RV-0057-VERDICT` §8
  requires, all present as §4.1–§4.3.
- Authored
  `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign-SEALED-predictions.md`:
  the 31-unit table, the 7 × 31 matrix, every expected message quoted as the row
  composes it, nine grounded reasoning notes, the disclosure functions branch by
  branch, seven named bounds, the weighting and the not-to-be-told list.
- **Derived, not assumed, for every REQUIRED cell**: which assertion speaks
  first, given each row's committed order and its lane iteration. Two of them are
  arithmetic that could easily have gone the other way — M03-H1's word count is
  **unchanged** under a four-octet shortening (`(64+7)/8 = (60+7)/8 = 8`) and so
  is its `tlast` cycle (both last octets sit in the same input word), so `tkeep`
  speaks; M03-H2's count **does** move (2 → 1), so the count speaks.
- Verified the blast radius from the `dune` stanzas rather than from memory, and
  the control run from the Actions API rather than from a relay.
- Touched no test, no attack plan, no spec, no RTL. No `git`.

### Evidence
1. **Control run at the base SHA**: CI run **30865856907**, workflow `build`, run
   number 271, `head_sha` `a2d090d49d5c2271e81a942091a4faa7fd66bfac`, jobs
   `build` (91857431361) and `cosim` (91857431300) both `conclusion: success`.
   Read from the GitHub Actions API.
2. **Compiled surface unchanged since the bench landed**:
   `git diff f806272 a2d090d -- test/ libs/ tools/ dune-project` prints nothing.
3. **Denominators**, from `tools/dv_checks.sh`'s inventory block run at
   `a2d090d`: `31  test/xgmii_rx_64/ (the M03 bench)` and
   `111  test/ (repository-wide)`; 111 − 31 = **80** non-M03.
4. **REQ-110 events are confined to two files**:
   `grep -rn start_char test/xgmii_rx_64/*.ml` returns hits in `test_m03_g.ml`
   and `test_m03_h.ml` only — the fact that bounds GH-c3 through GH-c6 to at most
   three units each.
5. **`Discard` is reachable only in family G**: no unit outside it drives a frame
   above 1518 octets (T-C3 is exactly 1518, legal; T-C5 is 1513 and 1516) — the
   fact that bounds GH-c1.
6. **The G-family state cells, from source**: `run_g7`'s guard
   `inject_ot > start_ot1 + 8 + 1518 && inject_ot < terminate1` with `k = 1588`;
   `run_g6`'s `?word_at` substitution of an idle character at
   `Arrival.terminate_octet_time frame1`; `run_g3`'s
   `terminate1 = first_start + 8 + 1600` against
   `target_start2 = first_start + 8 + 1620`; `run_g4`'s guard
   `inject_ot > terminate1 && inject_ot < start_ot2`; `run_g8`'s `k = 1560` with
   frame 1's own terminate left in place.
7. **Monitor errors do not pre-empt row assertions**: `strobe_monitor.ml`'s
   `error` accumulates into `rev_errors`, and `bench.ml:298`'s
   `assert_monitors_clean` is the only reader — so the first `fail` in each row's
   own order is what a campaign observes, which is what every message in the seal
   assumes.
8. **The accounting-after-assertions fact** (why D2 cannot produce any sealed
   message): `test_m03_h.ml:392-395`, `594-597`, `778-781`, `1007-1012` and
   `test_m03_g.ml:1502-1507` are all after their rows' last assertion.
9. **Cell counts**: 14 REQUIRED cells over 7 × 31 = 217 M03 cells, so 203
   must-stay-green M03 cells plus 7 × 80 = 560 non-M03 ones, on the narrow
   branches.

### Outcome
**DoD met.** Both deliverables exist and land in one commit, which is what makes
the seal a seal: `WO-0058` asserts a withheld mapping and
`WO-0058_..._-SEALED-predictions.md` is staged beside it, so the claim and the
artefact appear in the same `Files-in-this-commit` list (PROTOCOL §10, R-SEAL-1).
**The forward commitment of `RV-0057-VERDICT` §8 is redeemed, before any manifest
diff exists.**

The campaign carries all three constraints my own verdict ordered: the D2
correlation with the classes it does and does not touch (§4.1), FINDING 3's
blind spot with the rule that a survival at M03-H1/H2/H3 is not evidence of
weakness on the written-for class (§4.2), and FINDING 2's vacuity with the rule
that a class scored against M03-H4 is scored against the exact two-element
`error_pulses` list and nothing else (§4.3). `g-c4` is out of scope by name.

Handoff: to the orchestrator, for commit and for dispatch to the auditor as the
manifest round — base SHA `a2d090d`, allowlist `WO-0058` §2, branches
`mut/wo-0058-gh-c1` … `gh-c7`. **`SO-M03` does not issue and is not offered**;
32 of the plan's 62 ASSERT rows are discharged.

### Open-questions
- **The seal is unopened and must stay so until all seven diffs are committed.**
  Its unsealing is on the orchestrator's word that the branches have run, exactly
  as at WO-0039/0041/0045/0050/0055.
- **If GH-c2 is disclosed under the seal's UNWORKED third rendering, M03-H3 ends
  this campaign unqualified** and no packet may say otherwise.
- **§0.6's reference word for a zero-delivered frame** — still with
  architect_docs_lead. It does not gate this campaign: the seal is written
  against the bench at the base SHA, and FINDING 2 makes M03-H4's window check
  vacuous either way.
- **Owed to `AP-xgmii_rx_64.md` at its next touch**: the M03-H2 parenthetical
  footnote (§4.H).
- **Owed to `test/**` at its next touch**: `account_spliced_forwarded`'s
  `~received`-vs-`~delivered` input trace (FINDING 1), M03-H3's §6.2 `Idle`
  citation (FINDING 4), and the total-output-word line at the ordinary two-frame
  rows (FINDING 3) — the last of which this campaign explicitly does **not**
  seed against.
- **Still owed**: AP-M14's sweep companion if more plans are written
  (`J-dv_lead-0076`); the `precompile_check.sh` side-effect-in-combinator lane;
  M03-F5's discharge-by-citation qualification; the RFC 1071 anchor on the next
  fetching run; X-7, X-10, X-11 deferred; families I, J, K, M, N and L1–L5
  unwritten.

### Files-in-this-commit
- agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md
- agents/handoffs/WO-0058_m03-g7-h-mutation-campaign-SEALED-predictions.md

## [J-dv_lead-0080] 2026-08-06T23:30Z | task:WO-0058 | Seven of seven classes killed and all five scored units qualified — and both deviations are my seal's, not the bench's: a cell that could not have reddened under any faithful rendering, and a cell whose message turned on a scope dimension my disclosure function had no column for

### Trigger
Orchestrator: all seven `mut/wo-0058-gh-c*` branches have run. Adjudicate the
campaign against the seal frozen at `1c3a89d`, score each class in the packet's
own denominators, apply the two pre-named collision rules, rule the five
qualification questions, dispose of the M03-G6 red, and append the verdict to the
packet. The SEALED companion stays untouched.

### Inputs
- **The harvest, relayed verbatim**: seven branches (`39bcccb`, `4e84d64`,
  `2ddb3db`, `6795ae6`, `63af79d`, `e996f8e`, `3cf90ac`, each `a2d090d` + one
  diff), seven CI runs (30868752152, 30868753423, 30868754060, 30868754798,
  30868756316, 30868757246, 30868758781), the `build` job's `runtest` failing-file
  list and complete message set per run, and the `cosim`-green note.
- `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md` at `1c3a89d` — §1's
  scored set and denominators, §4.1–§4.3's three binding constraints, §7's four
  pass criteria, §8's five bounds.
- `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign-SEALED-predictions.md` at
  `1c3a89d` — the 31-unit table, the 7 × 31 matrix, §3's messages, §4's nine
  reasoning notes, §5's disclosure functions. **Opened at adjudication, on the
  orchestrator's word that the seven diffs are committed, exactly as at the five
  prior campaigns.**
- `docs/reports/audit/WO-0058-mutations/README.md` at `480c38a` (`J-auditor-0010`)
  **in full** — the scope statement, the seven diffs, the four mandatory
  disclosures, the two flagged judgement calls, the fidelity ledger.
- **My own bench sources, post-verdict, for the two findings**:
  `test/xgmii_rx_64/test_m03_h.ml` `run_h1` (lines 236-290), `run_h2` (626-670),
  `run_h4` (855-880, 960-1010).
- **Departure from my own practice at `J-dv_lead-0075`, disclosed loudly**: that
  entry recorded "**No `libs/**`, no `docs/reports/audit/**`**" and adjudicated
  the `g-c4` replay from the harvest alone. **This round I read the audit manifest
  in full, including seven RTL diffs with their base-design context lines**, on
  the orchestrator's explicit instruction and because this campaign's seal makes
  four classes' row sets a **function** of the disclosures, so the manifest is
  constitutive of the score rather than commentary on it. **It is not a charter
  violation** — the five units and the seal were frozen at `f806272` and `1c3a89d`
  respectively, both before any diff existed, so nothing already committed can
  have been contaminated. **It is a hazard for what is not yet written**, and it
  is in Open-questions with a proposed control rather than left implicit.
- `PROTOCOL.md` §10 (R-SEAL-1's retrospective-reference clause, which is what lets
  a verdict quote a seal in order to convict it), charter §3, §8.

### Reasoning

**The result, stated in the shape that matters: the bench killed everything, and
the seal mispredicted twice.** Seven classes seeded, seven classes dead, no green
run. All five scored units reddened with a sealed message under at least one
class, so all five are qualified. **763 of 763 must-stay-green cells held** — 203
sealed-green M03 cells and 560 non-M03 — which is the half of pass criterion 2
that most often fails and it is perfect. Zero unnamed-unit reds. So the two
deviations are not escapes and not weak rows: they are **wrong predictions**, and
the G-1 precedent says the falsified cells stand unedited and the finding names
them. Both are mine.

**FINDING GH-1 — the T-H1 × GH-c4 cell could not have reddened, and the seal had
the arithmetic on the page.** GH-c4 corrupts by applying the new frame's
alignment offset a cycle early. That can only corrupt if the two offsets
**differ**. `run_h1` splices its `/S/` at `close_ot = start_ot1 + 8 + 64`, and
**72 ≡ 0 (mod 8)**, so the aborting character lands in the frame's own start lane
at both members — lane 0 → lane 0, lane 4 → lane 4. The new frame's offset **is**
the aborted frame's offset, so applying it early is the identity, and the mutant
is behaviourally equal to base at that stimulus. The auditor's rendering (an OR
bypass gated on `begins &: new_start4`) makes this concrete — at the lane-4
member it ORs a 4 into a register already holding 4 — but the conclusion is
**rendering-independent**, which is what makes it a prediction error rather than
a disclosure surprise.

And the seal states the very fact it then fails to use. SEALED §4(c) writes *"72
is a multiple of 8, so it lands in the same lane as the frame's own start"*, and
concludes from a **category** — that GH-c4 "needs aborted-frame octets in the
`/S/`'s own word", which is necessary and not sufficient — that the lane-4 member
speaks. **This is `RV-0055` FINDING G-1's exact species**, recurring in the file
whose §4(a) exists to repair it, one subsection away from the repair. I record it
without discount. The mitigating fact is not mine: `AP-xgmii_rx_64.md` §4.H never
claimed M03-H1 against the alignment class — it names that defect in **M03-H2's**
Kills cell, where it died — so the plan was right and the seal over-extended.

**The bound this uncovers is worth more than the finding costs.** An alignment
defect on the REQ-110 path is observable only where the aborting `/S/`'s lane
differs from the aborted frame's start lane, and **that geometry exists at
exactly one member of one unit in the entire 31-unit bench**: `run_h2`'s lane-0
member (`k = 12`). The lane-4 member (`k = 16`) is offset-preserving, M03-H1 is
offset-preserving at both, M03-H4 delivers nothing. One stimulus point carries the
whole class. It works — but a single point is not a sweep, and I could not have
found this by inspection; the campaign found it by falsifying me.

**FINDING GH-2 — the T-H4 × GH-c5 cell is red with the wrong message, and the
root cause is one missing column.** Sealed: `observed 1`. Observed: `expected one
delivered frame (frame C's own tlast word), got none`. The auditor **disclosed**
the deciding fact before any result existed: its GH-c5 diff gates `begins` on
`a_close_start`, which is **epoch A only**, so a lane-4 `/S/` aborting a frame
opened by a lane-0 `/S/` in the same word aborts **epoch B** and its new frame
still begins. **That is M03-H4's word `c` verbatim.** So frame B opens after all,
frame B is epoch A at word `c + 1`, the third `/S/` aborts it and **suppresses
frame C** — both strobes fire correctly on `c + 2` and `c + 3`, the `error_pulses`
pattern passes, and the row speaks at its earlier frame-C emptiness check. I
traced the row's assertion order to confirm the message can only come from there
(`test_m03_h.ml:970`, before the `error_pulses` match at `990`).

SEALED §5.3 branches GH-c5 on **one** dimension — does it reach REQ-108's
resynchronisation — and has **no column for the epoch dimension**. M03-H4 is the
only unit in the bench whose stimulus contains both an in-word and a cross-word
abort, so it is the only unit where that dimension is observable, and it is
precisely the unit I got wrong. The observed **row set** still matches branch (i)
exactly, so §5's incomplete-enumeration rule does not fire: the enumeration was
right about reach and silent about scope. **The auditor discharged its duty
completely** — it volunteered the narrowing under a heading saying so.

**And GH-2 improves the row it falsifies, which is why I would not trade it
away.** §4.3 bound me to score M03-H4 against "the exact two-element
`error_pulses` list … and nothing else", on FINDING 2's ground that the §0.6
window is vacuous there. That phrasing over-narrowed the row against §4.2, which
records that the total-output-word check exists at four rows including M03-H4.
The campaign settles it: GH-c5 was caught at M03-H4 by **frame C's own `tlast`
word**, an instrument independent of every strobe. So M03-H4 is qualified on two
instruments, not one. I honour §4.3's operative content in full — no window is
cited as a bound, no kill is attributed to the strobe monitor — and rule its
"nothing else" clause scoped to the strobe-monitor instruments it names. **A
constraint I wrote is corrected by the experiment it constrained**, in the
verdict, not by editing the frozen packet.

**Why neither collision rule bites, checked rather than assumed.** §4(c) fires
only if GH-c4 landed the count-moving reading; it landed reading (a), and the
messages prove it independently of the disclosure — `delivered octets differ`
against `unexpected output word count` at the shared unit. §4(e) fires only if
GH-c5 and GH-c7 both produce a lone `observed 1` at M03-H4; GH-c5 moved three
units and its H4 message is not `observed 1` at all, and GH-c7 reddened M03-H4
**alone out of 111 units** under a diff that rewires all five strobe ports. That
last is the strongest positive result in the round: §4(e)'s uniqueness argument —
§0.3's 12-octet gap plus REQ-102's 8-octet preamble put any ordinary schedule's
second closure ≥ 2.5 cycles away — is confirmed at 110 units rather than argued.
**Seven kills are seven detections.**

**D2 is absent and that is checkable, not claimed.** Every one of the thirteen
observed messages is a row-local assertion; not one is a monitor message. In all
five scored units the accounting helpers sit after the last assertion, so a
reddening row never reaches them. §4(g)'s off-pattern condition — a class caught
only by `assert_monitors_clean` — did not occur. The **weaker** correlation is
real and the scorecard says so: four of the seven kills rest wholly on the
exact-`error_pulses` idiom, three on structural or content instruments, so the
campaign is seven detections at six geometries probing two property families.

**The M03-G6 red is a kill cell, not collateral and not a finding, and I ruled it
on the two documents that named it in advance.** §1 published that a class's
REQUIRED set may contain a unit outside the scored five and that the cell would be
sealed REQUIRED rather than left to surface as a violation; SEALED §2 carries
`T-G6` as **R** under GH-c1 with its exact message and its stimulus ground. A
finding needs an **unnamed** unit or a wrong message; neither holds. A second kill
would be the `RV-0055` inflation the packet exists to prevent. **Its real value is
that it is the demonstrated repair of FINDING G-1**: SEALED §4(a) re-derived all
seven G cells from their own committed arithmetic — two REQUIRED, five GREEN,
including T-G3, the cell whose category-reasoning cost a campaign — and **all
seven landed as derived**. The method worked where it had failed; it failed once
more this round in a different family, which is where §3 of the verdict puts it.

**The two flagged judgement calls, and I would reverse neither.** GH-c2's one
added latch bit is the **only** rendering the scope clause leaves standing —
the clause forbids the state-free version by name, and in this design the fact
that must survive from the `/E/` cycle to the `/S/` cycle is carried nowhere. So
SEALED §5.1's UNWORKED third rendering is **not** invoked, §6 bound 1 does not
bite, and **M03-H3 is qualified** — thinly, by one class, which is all the bench
can offer it. The three volunteered extra reaches make the mutant strictly larger
than an `/E/`-then-`/S/` pair; they could only have produced more reds and none
appeared, correctly, because the latch needs a genuinely open frame and T-E1/E2/E5
build one `frame_case` each with no `/S/` following. GH-c4's count-preserving
reading is the signature class named in §3's own words, and its disclosed second
geometry moves no cell — it needs a frame open on entry with covered octets in
`W−1`, and M03-H4, the bench's only two-`/S/`-in-one-word stimulus, has nothing
open on entry.

**What I did not do.** I did not touch the SEALED file and never will. I did not
edit any test. I did not issue `SO-M03` and did not offer it: 32 of 62 ASSERT rows
are discharged and families I, J, K, M, N and L1–L5 are unwritten. **I opened no
RTL source file** — my exposure this round is the seven diffs inside the audit
manifest, disclosed in Inputs and in Open-questions.

### Actions
- Scored all seven classes cell by cell against SEALED §2's matrix and §3's
  message strings, comparing observed text **character-for-character** including
  lane labels.
- Selected the disclosure branch for each of GH-c2, GH-c3, GH-c4, GH-c5 from the
  **observed row set** and cross-checked it against the manifest's §4 disclosure
  table: all four landed narrow / reading (a), 4 of 4 agreeing.
- Re-derived M03-H1's and M03-H2's splice arithmetic from the rows' own committed
  source to establish FINDING GH-1, and M03-H4's three-frame epoch structure and
  assertion order to establish FINDING GH-2.
- Applied §4(c) and §4(e) explicitly and recorded that neither fires; applied
  §4(g)'s D2 test and §4(f)'s idiom test.
- Appended `WO-0058-VERDICT` (ten sections) to the campaign packet.
- Touched no test, no spec, no RTL, no audit tree. No `git`.

### Evidence
1. **Seven runs, all RED on the `build` job's `runtest` step**: 30868752152,
   30868753423, 30868754060, 30868754798, 30868756316, 30868757246, 30868758781,
   on branches `39bcccb`, `4e84d64`, `2ddb3db`, `6795ae6`, `63af79d`, `e996f8e`,
   `3cf90ac`. No green run on any branch.
2. **Failing-file sets**: `test/xgmii_rx_64/test_m03_g.ml` for gh-c1 and
   `test/xgmii_rx_64/test_m03_h.ml` for gh-c2 … gh-c7; **no other file failed on
   any branch**, which is the 560-cell non-M03 must-stay-green result and the
   203-cell M03 one.
3. **Cell tally**: 14 sealed REQUIRED cells; **13 red**; **12 red with the exact
   sealed message**; 1 sealed-R-observed-G (T-H1 × GH-c4); 1 red-with-wrong-message
   (T-H4 × GH-c5); **0 unnamed-unit reds**.
4. **GH-1's arithmetic, from the row's own source**: `test_m03_h.ml:262`
   `let close_ot = start_ot1 + 8 + close_idx` with `close_idx = frame1_len = 64`;
   `72 mod 8 = 0`; guard at `264` accepts lane 0 or lane 4 only. Both members are
   offset-preserving.
5. **The single lane-changing abort in the bench**: `test_m03_h.ml:634`
   `let k = if lane = 0 then 12 else 16`, with the guard at `657` forcing
   `close_ot ≡ 4 (mod 8)`. At lane 0 the frame starts at lane 0 and the `/S/` is
   at lane 4 — offsets differ; at lane 4 both are lane 4 — offsets equal.
6. **GH-2's assertion order, from source**: `test_m03_h.ml:970`
   `fail row "expected one delivered frame (frame C's own tlast word), got none"`
   precedes the `error_pulses` two-element match at `990`, so the observed message
   is reachable only with both strobes correct and frame C absent.
7. **M03-H4's epoch geometry**: `test_m03_h.ml:856-861` — `ot_2 = start_ot_a + 4`
   in word `c` lane 4, `ot_3 = start_ot_a + 8` in word `c + 1` lane 0 — so frame A
   is opened **and** aborted inside word `c` (an in-word abort) while frame B is
   aborted across a word boundary (a cross-word abort). The only unit with both.
8. **Control, unchanged**: `a2d090d`, CI **30865856907**, both jobs green — pass
   criterion 3, established before the campaign at `J-dv_lead-0079` Evidence 1.
9. **Manifest conduct**: `docs/reports/audit/WO-0058-mutations/README.md` §1.2
   affirms no `test/**` file opened at any revision and the sealed companion
   untouched; §2 fixes the base blob at `81cd9ed…` with the extraction's
   `sha256` `3d87515a…5be92`; §6 declares **NOT-SEEDED: none**.

### Outcome
**DoD met.** The campaign is adjudicated and the verdict is a committed packet
section, not a chat message. **Kills 7 of 7 classes; all five scored units
qualified; 763 of 763 must-stay-green cells held; two findings, both against my
own seal.** Pass criteria 1, 3 and 4 met; criterion 2 met in full on its
must-stay-green half and at 12 of 14 cells on its message half, with the two
deviations adjudicated as FINDING GH-1 and FINDING GH-2 rather than scored away.
**M03-G7's qualification discharges the oldest open DV debt on this module.**

Handoff: to the orchestrator for commit. **`SO-M03` does not issue and is not
offered.** The §0.6 countersignature and the attack-plan consequences ride in the
next entry and the next commit.

### Open-questions
- **RTL exposure at adjudication — disclosed, not a violation, and it wants a
  control.** `J-dv_lead-0075` recorded "no `libs/**`, no `docs/reports/audit/**`"
  and scored from the harvest alone; this round I read seven RTL diffs in the
  manifest, because the seal makes four classes' row sets a function of the
  disclosures and because **neither finding was diagnosable without the diff's
  mechanism**. Nothing already committed is contaminated. But families I, J, K,
  M, N and L1–L5 are unwritten, and I now hold this module's internal signal
  names. **Proposal to the orchestrator, for the next campaign packet**: the
  adjudicator reads the manifest's disclosure table and fidelity ledger by
  default, and opens a diff only when a cell is off-pattern — journaling which
  diff and why, as here. Raising it rather than deciding it: the mutation
  discipline is PROTOCOL §10's, and an amendment there is an ADR.
- **Bound 6, owed**: the alignment-transition instrument is a single stimulus
  point (`run_h2` lane 0). The second point belongs at REQ-110's commissioned
  **M03-B4** geometry, which is unwritten.
- **Bound 7, owed**: the in-word (epoch B/C) REQ-110 abort exists at one unit in
  one form; no row drives it with a frame already open on entry.
- **§4.3's "nothing else" clause** is corrected by ruling in the verdict, not by
  editing the frozen packet. If a future packet restates that constraint it must
  carry §4.2's four-row total-output-word fact with it.
- **Owed to `test/**` at its next touch**, unchanged from `J-dv_lead-0079`:
  `account_spliced_forwarded`'s `~received`-vs-`~delivered` trace (Finding 1),
  M03-H3's §6.2 `Idle` citation (Finding 4), the total-output-word line at the
  ordinary two-frame rows (Finding 3).
- **Still owed**: AP-M14's sweep companion; the `precompile_check.sh`
  side-effect-in-combinator lane; M03-F5's discharge-by-citation qualification;
  the RFC 1071 anchor on the next fetching run; X-7, X-10, X-11 deferred.

### Files-in-this-commit
- agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md

## [J-dv_lead-0081] 2026-08-07T00:10Z | task:WO-0058 | The §0.6 reference-word ruling COUNTERSIGNED on a check of my own instrument rather than on its assertion — and the attack plan now carries the one bound a green window check does not give you

### Trigger
Two obligations falling due in the same round as the WO-0058 adjudication, per my
own ledger: the C-43-discipline re-countersignature of the architect's §0.6
reference-word ruling at `0caf023`, and my call on whether
`AP-xgmii_rx_64.md` restates `RV-0057-VERDICT` Finding 2's vacuity note at X-3
check (c). Both are mine to execute, neither was dispatched as a work order.

### Inputs
- `0caf023` in full — the `docs/specs/requirements.md` §0.6 diff (three normative
  clauses plus one non-normative note) and the `docs/specs/modules/xgmii_rx_64.md`
  §9 paragraph, plus both change-log rows and their concurrence classifications.
- `e284a2e` — the orchestrator's C-5 re-scoping transcription that followed it.
- `test/xgmii/injection.ml:255-310` — `window`, `no_output_cycle`, `tkeep_of` and
  the `outcomes` walker's `Data`/`Control`/truncation arms. **My own instrument,
  as the thing whose ratification is being claimed.**
- `test/attack_plans/AP-xgmii_rx_64.md` §4.H's four rows and §7's X-3 row — my
  own text, as the thing being corrected.
- `agents/handoffs/WO-0046_cosim-phase-1.md`'s COUNTERSIGNATURE block
  (`J-dv_lead-0057`) — the form of record for a dv countersignature.
- `J-dv_lead-0077` and `J-dv_lead-0078` (the question as I routed it, and Finding
  2 as I wrote it); the WO-0058 verdict of the preceding entry.

### Reasoning

**I sign, and the reason I can sign quickly is that the ruling answers the
question I asked rather than a nearby one.** §0.6 now names the reference word for
every module: the last octet the frame **received while open**; a closing control
character is not one of its octets and an octet closing it **by count** is;
what follows never extends it; and a frame that received nothing takes its
**closing word**, with a one-to-four-octet frame expressly outside that class.

**The claim I would not sign on assertion is that the ruling ratifies my bench
rather than moving it, so I checked it.** `test/xgmii/injection.ml`'s `window`
computes `last_octet_ot = if received > 0 then start_ot + 8 + (received - 1) else
closing_ot` and returns `(closing_ot / 8, (last_octet_ot / 8) + 3)`. That is
clause 1 (the upper bound reads `received`, never `delivered`) and clause 3 (the
zero-received branch takes the closing word) in one expression. Clause 1's
control-character half is structural: `rev_octets` is pushed only in the
`Xgmii_word.Data octet` arm, so no control character can enter the count. Clause
1's closing-by-count half is the REQ-108 arm, which fires at `received () > 1518`
— with the 1519th octet **already pushed** — and emits with that octet's own time
as `closing_ot`, so the truncating octet is counted and is the reference. Clause 2
is `current := None` at closure. And the one-to-four-octet exclusion is
**implemented, not merely stated**: the runt path reaches `close_zero` with
`~received:r`, `r ≥ 1`, so it measures from its octets. **All three clauses and
the exclusion are in the committed bench.** The ratification claim is true.

**And I re-derived the arithmetic the module-side paragraph rests on rather than
reading it, because it is the part that decides whether the ruling is worth a
signature.** The truncation binds on the 1519th received octet at
`start_ot + 8 + 1518`. At a **lane-4** start that is word **s + 191** while the
1514th delivered octet is word **s + 190**; at a **lane-0** start both are word
**s + 190**. So the received-versus-delivered reading is **invisible at lane 0 and
load-bearing at lane 4** — the delivered reading would have shifted every family-G
lane-4 member's window by a cycle. That is a real decision with a real
consequence, correctly made, and it is why the older paragraph's orthogonality
claim held for its conclusion and not for its arithmetic.

**Finding 2 is adopted with the scoping sentence I would have insisted on.** The
note says the window carries no independent information where the reference word
and the module's pin come from the same word — and then bounds itself: *"The
window keeps its teeth wherever the frame received an octet, because there its two
ends and the pin are three different quantities."* The vacuity is confined to the
class that has it and is not allowed to discredit the check generally. I could not
have written it better and I did not have to.

**On the AP question I ruled EDIT, and against my own default.** My standing
disposition — `J-dv_lead-0078`, and `RV-0056` §1 before it — is *footnote owed at
the plan's next touch, the file is the authority meanwhile*, precisely because a
restatement can drift from its source. Three things overturn it here. **First, the
failure mode has an instance**: M03-H4's `Strobe_monitor` registration is already
vacuous as a window check, and it got that way because the plan's X-3 row promises
check (c) flatly. The plan is the document read **before** a row is written, so a
flat promise there is how the defect reproduces. **Second, the drift hazard is
gone**: until `0caf023` the vacuity was my private finding, and restating a
private finding in a second document is exactly what drifts; now it is normative
text with a non-normative note, so the plan's cell **cites its authority** and
cannot drift from it without contradicting a spec it names. **Third, the campaign
supplied confirmation I did not have when I deferred**: three seeded classes
reddened M03-H4 and **none** spoke through the window — two through the exact
`error_pulses` list and one through frame C's own `tlast` word. A bound with a
normative source and an empirical confirmation is not a footnote owed later.

**So I touched the plan, and a touch discharges everything owed to it.** Three
edits, no new rows, and **no status count moves** — 57 ASSERT, 7 NO-ASSERT, 4
NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL are all unchanged, which is what keeps
this an editorial touch rather than a re-scoping:

1. **X-3 check (c)** now carries its bound, its normative citation, its
   consequence (on the zero-received class the assurance is (b) plus (d), never
   (c)), the teeth-bearing complement, and the explicit note that a 1-to-4-octet
   frame is in the teeth-bearing class. The "which rows need it" cell records that
   M03-H4 is the row where (c) is vacuous, and the note cell records the
   empirical confirmation.
2. **M03-H2's parenthetical** — the cell that says the four octets are proved by
   "`tkeep` and the delivered count" — is footnoted with its lane bound: true at a
   lane-0 start only, because REQ-101's absolute-lane rule forces `k ≡ 0 (mod 8)`
   at a lane-4 start, and the row is actually proved at both alignments by
   `WO-0057` §2.3's delivered-**content** assertion. This is the footnote
   `J-dv_lead-0078` recorded as owed at the plan's next touch. **Discharged.**
3. **Two geometry bounds appended under §4.H**, both discovered by the campaign
   rather than by design: the alignment-transition instrument is a single
   stimulus point (`run_h2` lane 0), with the second point owed at M03-B4; and
   the in-word abort exists at M03-H4 only, in the nothing-open-on-entry form.
   Recorded as **bounds on the family**, not as new rows — a new row is a work
   order's business and would move the counts.

**What I did not do.** I did not touch `docs/specs/**` — outside my scope, and the
countersignature is the signature of record for the orchestrator to transcribe. I
did not edit the SEALED companion. I opened no RTL.

### Actions
- Appended the COUNTERSIGNATURE block for requirements.md §0.6's reference word
  at `0caf023` to `agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md`
  — the packet that routed the question — in the form
  `WO-0046`'s block established.
- Verified all three clauses and the 1-to-4-octet exclusion against
  `test/xgmii/injection.ml`'s `window` and `outcomes` walker, line by line.
- Re-derived the lane-0 / lane-4 truncation arithmetic independently.
- Edited `test/attack_plans/AP-xgmii_rx_64.md`: X-3 check (c)'s bound, M03-H2's
  owed parenthetical footnote, and §4.H's two new geometry bounds.
- No `git`.

### Evidence
1. **The ruling**: `0caf023`, `J-architect_docs_lead-0023`, +22 lines in
   `docs/specs/modules/xgmii_rx_64.md` and +50 in `docs/specs/requirements.md`,
   `libs/` empty in the same diff. Both change-log rows class it **editorial**
   while carrying the **C-43 countersignature discipline** — not in force until
   transcribed.
2. **Clause implementation, from source**: `test/xgmii/injection.ml:277-282`
   (`window`), `:370` (only `Data` octets enter `rev_octets`), `:371-378` (the
   REQ-108 arm fires with the 1519th octet pushed and passes that octet's time as
   `closing_ot`), `:388-393` with `:321` (the runt path passes `~received:r`,
   `r ≥ 1`, so a 1-to-4-octet frame measures from its octets).
3. **The lane arithmetic**: 1519th received octet at `start_ot + 8 + 1518`. Lane-4
   start `8s + 4` → `8s + 1530` → word `s + 191`; 1514th delivered at `8s + 1525`
   → word `s + 190`. Lane-0 start `8s` → `8s + 1526` and `8s + 1521` → **both**
   word `s + 190`.
4. **The empirical confirmation of check (c)'s irrelevance at M03-H4**: WO-0058's
   gh-c5, gh-c6 and gh-c7 all reddened M03-H4, with messages
   `expected one delivered frame (frame C's own tlast word), got none`,
   `… observed 0` and `… observed 1` respectively — **no window message on any
   branch**, and no monitor message anywhere in the campaign.
5. **AP status counts unchanged** by this touch: 57 ASSERT, 7 NO-ASSERT, 4
   NO-STIMULUS, 0 RULING, 1 GAP, 4 STRUCTURAL.

### Outcome
**DoD met.** The §0.6 ruling is **COUNTERSIGNED** — signature of record in
`WO-0057`'s COUNTERSIGNATURE block, authority this entry, transcription owed to
the orchestrator before the diff is in force. The X-3 check (c) question is
**ruled EDIT** and executed, against my own standing default, with the three
reasons on the record. Two owed footnotes are discharged in the same touch and no
status count moves.

Handoff: to the orchestrator — the countersignature for transcription into
requirements.md's change log, and both files for commit.

### Open-questions
- **Transcription owed**: the §0.6 diff is not in force until the orchestrator
  transcribes this signature, per its own change-log row's C-43 clause.
- **Programme-wide consequence of the ruling, flagged not resolved**: X-3 check
  (c)'s vacuity on the zero-received class is now normative for **every** module's
  strobe rows, not M03's alone. `AP-M13` and `AP-M14` carry X-3-shaped
  instruments and I have not re-read their rows against this bound. Owed at their
  next touch; not urgent, because the module pin carries every commissioned
  assertion either way.
- **Owed and still owed**, unchanged: bound 6 (the M03-B4 alignment point) and
  bound 7 (the in-word abort) are now **written into the plan** but **unbenched**;
  the three `test/**` repairs of `J-dv_lead-0079`; AP-M14's sweep companion;
  M03-F5's discharge-by-citation qualification; the RFC 1071 anchor; X-7, X-10,
  X-11 deferred; families I, J, K, M, N and L1–L5 unwritten.

### Files-in-this-commit
- agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0082] 2026-08-07T03:15Z | task:WO-0059 | Family I authored — and authoring it found that M03-I2's own stimulus cannot produce the design its Kills cell names, which is the third unachievable kill this plan has carried and the first caught by arithmetic before a bench existed

### Trigger
Orchestrator: author the next family packet in the sponsor-approved queue —
**WO-0059, family I**, for tb_writer, against `AP-xgmii_rx_64.md` §4.I as it
stands at `abf5d0b`, in the `WO-0057` form. With two interactions named
explicitly: whether family I touches the two unbenched geometry bounds my
`WO-0058` verdict recorded, and whether family I's rows will be scored by the
next campaign — whose adjudicator-blind-by-default control belongs in that
campaign's packet and not in this one.

### Inputs
- `test/attack_plans/AP-xgmii_rx_64.md` at `abf5d0b` in full: **§4.I's six
  rows** (the object), §0–§3 (the format, the standing obligations, stimulus
  legality), §4.A/B/C/F/G/H/M/N (the rows family I reuses stimulus from or is
  bounded against), §5 (the rejected list, item 10 in particular), §6's coverage
  map, §7's staleness banner and its **X-1 / X-3 / X-4 / X-5** rows, §8 item 5,
  §9's change log.
- `docs/specs/requirements.md`: **REQ-016, REQ-109, REQ-113**, REQ-101–REQ-108,
  REQ-110, REQ-111, §0.3, **§0.5** (octet time, h, ΔC, "Start lanes"), **§0.6**
  as ruled at `0caf023` and in force at `abf5d0b`, §2, §12.
- `docs/specs/modules/xgmii_rx_64.md`: **§6.1** (the preamble-position
  paragraph, the C-14.4 gapless qualifier, the two C-18 non-instances, the
  64-octet cycle table, and **the "Between frames" paragraph with its
  two-cycle drain derivation**), **§6.2**'s `Idle` and `Frame` rows, §6.3 items
  2/4/5/6, **§7**, §9's closure list and strobe table, **§10**'s REQ-109,
  REQ-113 and REQ-016 hooks.
- `test/xgmii/idle_injection.mli` **and `.ml`** (`uniform`'s site range,
  `word_at`, `cycle_of`, `in_times`, `check_sites`, `is_c45_boundary`),
  `test/xgmii/arrival.mli`, `test/xgmii/xgmii_word.mli`,
  `test/monitors/octet_time.mli`, `test/monitors/strobe_monitor.mli`,
  `test/xgmii_rx_64/bench.mli` and `bench.ml`'s `run`,
  `test/xgmii_rx_64/test_m03_structural.ml`, and the `%expect_test` inventory
  of all nine `test/xgmii_rx_64/*.ml`.
- `test/attack_plans/CD-xgmii_rx_64_cosim.md` §0-bis, §5.1, §5.2, §8.
- `agents/handoffs/WO-0057_…` in full — the form, its `RV-0057-VERDICT`
  (Findings 1–4 and the §8/§9 rulings), and its COUNTERSIGNATURE block.
- My own `J-dv_lead-0079`, `J-dv_lead-0080` (the WO-0058 verdict and its
  Open-questions: the RTL-exposure escalation, bounds 6 and 7, the three owed
  `test/**` repairs), `J-dv_lead-0081` (the §0.6 countersignature and the AP
  touch); `tasks/BOARD.md`'s WO-0058 row.
- **No `libs/**`, no `top/**`, no `rtl_snapshots/**`, no `docs/reports/audit/**`,
  no `test/third_party/**`.**

### Reasoning

**Family I is authorable and is genuinely next — I checked the three things that
could have stopped it and none did.** Its machinery exists and is unit-tested
(X-4 at WO-0033, X-3 likewise), so no row is blocked on a build. Its
specification basis is settled: REQ-109's drain bound was fixed by C-14.3,
REQ-016's wrapper constraint by the M03-N3 ruling at `541ea43`/`06c1eba` with
C-45 recorded against it, and REQ-113 needs nothing further. And the one place I
expected to need a ruling — whether a `/Q/` ordered set is legal stimulus at all
under REQ-018's contract — is already answered by this plan's own §5 item 10,
which names M03-I3's ordered set as the closest legal attack to a deliberately
illegal `xgmii_rxc` pattern. So no escalation, and the packet is authored.

**What authoring it found is that M03-I2 cannot kill what M03-I2 says it
kills.** The row drove a 64-octet frame and asserted silence from three cycles
after the terminate word. I worked §6.1's own drain derivation at both ends
rather than quoting it: N = 8q + r, and a lane-0-started frame's `tlast` word
leaves at cycle q + 2 for r ≤ 4 and q + 3 for r ≥ 5 — one or two cycles after
the terminate word — while a lane-4-started frame's leaves zero or one. A
64-octet frame is r = 0. So a conformant design's last output falls at **+1**,
the assertion starts at **+3**, and the one-cycle-long drain defect the `Kills`
cell names emits at **+2** — inside two cycles the row never asserts about.
**The stimulus cannot produce the design the cell claims to kill.** That is the
M03-D3 / M03-F2 shape, and this plan has now carried it three times.

**I repaired it rather than deferring it, and the choice is against my own
standing default.** My default — `RV-0056` §1, `J-dv_lead-0078` — is *footnote
owed at the plan's next touch, the file is the authority meanwhile*, because a
restatement can drift from its source. That default is right for a **claim about
how a benched row is proved**. It is wrong here for three reasons. First, the
defect is not in a description, it is in the **commissioning cell** of a row
that has not been written yet, and the plan is the document a bench writer reads
before writing one. Second, **the direct precedent is `J-dv_lead-0038`** —
family D corrected before it was benched, WO-0040 issued against the corrected
row — and it is precedent for exactly this shape, an unachievable kill found by
working octet-time arithmetic while authoring the work order. Third, family I's
qualification campaign will seal against this plan; a campaign seals against the
plan and **the plan must already be right**, which is the ordering
`J-dv_lead-0060` deliberately established in history rather than claimed in a
packet.

**The repair is a second member and not a new row, which is what keeps every
count still.** A **69**-octet frame at a **lane-0** start — already in M03-C1's
committed directed set, so no new frame class and no new builder — is r = 5, so
a conformant `tlast` lands **exactly on** the last legal drain cycle. The
defect emits at +3 and dies; and, the half I care about almost as much, **a
bench that mis-derives the bound one cycle tight goes red against a conformant
design instead of passing in silence**, which the 64-octet member also could not
do. On `Bench`'s own lane-0 schedules both members put their terminate character
in cycle 10 and share the boundary at cycle 13 — a convenience, not the reason —
while the same 69 octets at a **lane-4** start put it in cycle 11 with the
boundary at 14. The two lanes do not share a boundary, so the `Observable` cell
now says so: a bench giving them one is wrong. **The maximum drain of 2 is
reachable only at a lane-0 start with N mod 8 ≥ 5**, derived, and that is why
the member names its lane. 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4
STRUCTURAL, 1 GAP — all unchanged.

**The packet's organising idea is that this family's characteristic failure is
vacuity rather than wrongness.** Every one of §4.I's rows asserts an *absence* —
no output word, no strobe, no change — and an absence is satisfied by a design
that does nothing and by a bench that drove nothing. Six such rows is the
easiest green in this programme and the least evidence. So the packet's first
trap is a rule with teeth: **each row carries a positive companion assertion in
its own unit**, named, with what would go red if it were deleted, and a
companion living in another unit or another family is not one — cross-file
liveness is an argument about the suite, and a campaign scores rows one at a
time. I tabulated the five companions rather than gesturing at the idea, and I
recorded the cost of M03-I1's: once a frame is in the run,
`assert_monitors_clean`'s latency half stops being carved out and starts being
demanded.

**Three more traps, and two of them are the same trap this bench has now met
twice.** `Bench.account_clean_frame` feeds the latency tagger
`Arrival.in_times`, which is false about an **injected** input line by exactly 8
octet times per idle inserted before each octet — the `Frame.delivered`-on-an-
abort-path trap of `WO-0057` §3.1 in a new dress, and worse in one respect: a
tagger handed a false input trace does not fail, it reports a *varying* L, so
this trap's failure mode is a **false BUG- packet** rather than a missed one.
And `Bench.run` discharges standing obligation 5 against the **source** schedule
only, so neither an overlaid word nor an injected line is checked by it — while
`Idle_injection` deliberately *applies* an illegal site rather than dropping it.
The rows therefore check their own stimulus before driving it. I also stated
M03-I5's prohibition in the traps section rather than in the row list, because it
is a prohibition on the row a writer builds immediately before breaking it: §6.1's
`m + 3` is scoped to a gapless stimulus and §10 commissions injection against
this very module, so a bench asserting the formula under injection fails a
conformant design.

**One trap is this family's own and I expect it to be the one that bites.** Every
`Kills` cell in §4.I is written in the language of the design's internals — a
spurious word out of an *empty pipeline*, a design that *holds the CRC register*,
a design that *counts cycles rather than octets*. That is what a `Kills` cell is
for and it is not an observable; §6.3 items 2, 4 and 5 forbid asserting register
placement, FSM encoding or counter direction, and `RV-0055`'s rule requires a
state claim to cite the stimulus fact that establishes it or not be made. The
packet says it plainly: if a row's reasoning needs the word "pipeline" it needs a
different sentence.

**Four findings about the family's reach that I derived rather than assumed, and
all four would otherwise have been a campaign's to discover.** (1) **X-3's checks
(a), (b) and (c) have no instance here at all** — no row registers an expected
event, so there is no high cycle to count, no pin to compare and no window to
check, and the family's entire strobe assurance is check (d) plus each row's
positive companion. That is the exact mirror of the M03-H4 bound I wrote into
§7's X-3 row at `J-dv_lead-0081`, where (c) alone was vacuous. (2) **M03-I4 and
M03-I6 attack the two halves of one rule** — §6.2's hold: I4 the CRC register,
I6 the received-octet count — so a class that moves the hold path moves both, and
they are **not** independent kills (`RV-0057-VERDICT` §9(c)'s lesson, applied
before the diffs exist rather than after). (3) **M03-I6's 64-octet member is
stimulus M03-I4 already drives** at the same 7-idle figure; its value is as a
positive companion, not as coverage, and no `SO-` may count it twice. (4) **At 7
idles the runt half of the count defect escapes by one cycle** — a 64-octet
frame's injected span from start word to terminate word is 9 + 8×7 = 65, one
outside REQ-107's 5-to-63 band — **while at M03-I4's 1-idle figure the same span
is 17, squarely inside it**. §10's three figures are not a ladder of increasing
severity, and that is the instance which proves it. I also derived that the
naive cycle-counting oversize defect is **lane-asymmetric** on the 1518-octet
member (roughly 1513 cycles at lane 0, 1521 at lane 4), so it fires at one lane
only, by three.

**On the two interactions I was asked to settle, the answer to both is a clean
negative and the negatives are worth stating.** **Bound 6** — the
alignment-transition instrument is a single stimulus point, with the second owed
at M03-B4's geometry — and **bound 7** — the in-word abort exists at M03-H4
only. **Family I drives no start character while a frame is open, and no abort of
any kind**; not one row. So it discharges neither and moves neither, and the next
campaign should not come here looking. What *is* real is forward-facing: `AP` §4.N
records that M03-N2 may be run inside the M03-I4 wrapper, and **family I is the
wrapper's first customer against a DUT** — everything before this was the
wrapper's own unit tests — so every later row that runs inside it inherits a
wrapper measured rather than assumed. That is why the packet asks for
`cycle_of`, `in_times` and the front-offset observation to be reported: the
tagger reads h = 8 and 12 under injection **only because** no idle is ever
inserted between the start character and the frame's first octet, so the
observation is the M03-N3 constraint made measurable.

**On the next campaign, I put its structure in the packet and its escalation
out of it.** The combined G7+H campaign is closed, so **the next campaign is
family I's own qualification and its scored set is this packet's five ASSERT
rows** — which is why assertion and iteration order are contract items here, why
the two correlations above are named now, and why §6 item 1's bound is flagged
as belonging in the class rationale. My RTL-exposure escalation from
`J-dv_lead-0080` — adjudicator reads the disclosure table and fidelity ledger by
default, opens a diff only for an off-pattern cell, journals which and why — is
raised and undecided and **belongs in that campaign packet, not in a bench work
order**. It governs how a campaign is adjudicated and nothing about how a bench
is written; putting it here would pre-empt the orchestrator's own routing of an
item I deliberately raised rather than decided.

**I ruled on all three owed `test/**` repairs rather than letting the round pass
them again.** This packet is the "next `test/**` touch" they were owed to.
Finding 1 (`account_spliced_forwarded`'s `~received`-versus-`~delivered` input
trace, right today only by cancellation and sitting exactly on `frame_out`'s
bound) and Finding 4 (M03-H3's missing §6.2 `Idle` citation) **ride**: one site
each, both mechanical, both already specified in the verdict, and Finding 4's
clause is the same one M03-I1 and M03-I3 rest on, which is a reason to land them
together. Finding 3's sweep — the total-output-word line at the ordinary
two-frame rows of families D–H — **does not ride**, and the reason that decides
it is not review load: **the line is not uniform**. Each row's "nothing else was
emitted" bound is a function of that row's own legitimate output *and its
drain*, and the drain is the quantity **M03-I2 derives from §6.1 for the first
time in this bench**. The sweep should be written on top of that derivation
rather than beside it, so it is deferred to the first `test/**` touch after
family I lands, with a named ground instead of a recurring reminder.

**And I corrected a scope sentence of my own.** `WO-0057` §11 wrote "Families I,
J, K, M, N and L1–L5 remain unwritten". `test_m03_b.ml` carries **one** unit;
**M03-B2, M03-B3 and M03-B4 have no unit of their own**. That is three ASSERT
rows omitted from a scope statement — and it matters beyond bookkeeping, because
**bound 6 is owed at M03-B4's geometry and M03-B4 does not exist**, so that bound
is blocked on a family-B packet rather than on a campaign. A scope sentence that
omits three rows is how an owed row becomes an escape.

**What I did not do.** No `docs/specs/**` — outside my scope and nothing here
needs a ruling. No `test/**` code: this packet commissions the bench, it does not
write it. No RTL, no audit reports, no vendored reference — and the packet bars
tb_writer from `test/third_party/verilog-ethernet/**` for this round, not on
licensing (it is MIT and freely readable) but because the ordered set's shape is
to be derived from requirements.md §2 and §6.2 alone and the reference is the
nearest place to take one from instead.

**One deviation from my instructions, stated rather than absorbed.** I was told
`Files-in-this-commit` should be exactly the packet, and it is two files: the AP
edit of §1.1 is the named exception in the same instruction ("AP edits only if a
defect requires one, said loudly"), and R4's set-equality is mechanical, so the
list follows the diff.

### Actions
- Authored `agents/handoffs/WO-0059_tb-m03-family-i-silence-and-ordered-sets.md`
  — six rows (five ASSERT, one NO-ASSERT), traps before the rows, rows ranked by
  risk with the build order stated and its one deviation explained, one
  authorised `Bench` addition (`?ifg` on `frames_at`), and ten Return-log
  deliverables.
- Edited `test/attack_plans/AP-xgmii_rx_64.md`: **M03-I2's Stimulus and
  Observable and Kills cells** (the two-member repair, the per-lane boundary
  derivation, and the unachievable-kill finding stated in the cell), plus a §9
  change-log row. No row added, no status converted, no count moved.
- Re-derived, from specification text only: §6.1's drain arithmetic at both
  lanes and both residue classes; M03-I3's 100-cycle window and its `ifg`;
  M03-I4's drain arithmetic and front-offset invariance; M03-I6's injected spans
  at both lanes for both members.
- Ruled on the three owed `test/**` repairs; corrected `WO-0057` §11's scope
  sentence; flagged the inherited 32-of-62 discharge figure as unverified.
- No `git`.

### Evidence
1. **The defect, reproducible by arithmetic from committed text alone.**
   SPEC-M03 §6.1's "Between frames" paragraph: N = 8q + r; lane-0 terminate word
   q + 1, `tlast` at q + 2 (r ≤ 4) or q + 3 (r ≥ 5); lane-4 gives 0 or 1. At
   N = 64 (r = 0) a conformant `tlast` is **+1** after the terminate word and the
   row asserted only from **+3**; the one-cycle defect emits at **+2**.
2. **The repair's own numbers, on `Bench`'s schedules.** Lane 0
   (`first_start` = 8): 64 octets → terminate at octet time 80, cycle **10**;
   delivered 60 → 8 words; `tlast` cycle **11**. 69 octets → terminate at octet
   time 85, cycle **10**; delivered 65 → 9 words; `tlast` cycle **12** = the last
   legal drain cycle. Both boundaries cycle **13**. Lane 4 (`first_start` = 12),
   69 octets → terminate at octet time 89, cycle **11**; `tlast` cycle **12**;
   boundary **14**.
3. **`uniform` proposes no C-45 site**, from source:
   `test/xgmii/idle_injection.ml`'s `uniform` starts at
   `first = first_octet_cycle f + 1` while the prohibited boundary is
   `first_octet_cycle f`, so `c45_sites` is empty on every uniform schedule and
   there is no residue to report — the packet bars manufacturing one.
4. **M03-I6's spans.** 64 octets, lane 0: source span 9 cycles, sites at
   `before_cycle` 3 … 10 (8 sites) × 7 = 56 → **65**, one outside REQ-107's
   5-to-63 band; at 1 idle the same span is **17**, inside it. 1518 octets: lane
   0, sites 3 … 191 (189) × 7 = 1323, span **1513**; lane 4, sites 3 … 192 (190)
   × 7 = 1330, span **1521** — the naive cycle-counting oversize defect fires at
   lane 4 only, by three.
5. **The co-simulation reach**, from `CD-xgmii_rx_64_cosim.md` §5.2: X1 excludes
   all cycle timing, latency and word-to-word spacing; X2 excludes strobe
   identity and pinned cycles. So M03-I1, I2, I5 and I6 are anchorable in
   nothing, and only the delivered-frame half of I3 and I4 could be. **Not a
   REQ-901 effect** — REQ-016/109/113 are outside classes (e) and (f).
6. **Family B's unbenched rows**, measured:
   `grep -c 'let%expect_test' test/xgmii_rx_64/test_m03_b.ml` = **1** (M03-B1),
   against §4.B's four ASSERT rows.
7. **AP status counts unchanged by this touch**: 78 rows, 62 ASSERT, 7
   NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP. Table well-formedness checked:
   the edited M03-I2 row carries six cells, the appended change-log row three.
8. **Nothing was executed.** No `dune`, no test run, no simulator: this round
   produced a work order and a plan edit, and every number above is derived from
   committed specification text or read from committed `test/**` source. The
   container's absent-toolchain state (ADR-0005) is unchanged and untested by me
   this round.

### Outcome
**DoD met.** `WO-0059` is authored and ready for the orchestrator to issue to
tb_writer: six rows, traps before the rows, risk ranking with a stated build
order, the two asked-for interactions declared (both negative, with the real
forward interaction named instead), the next campaign's scored set stated and
its escalation deliberately excluded, the three owed `test/**` repairs ruled on,
and five bars on what this family may not claim. **One AP defect was found and
repaired in the same round, loudly** — M03-I2's stimulus could not reach its own
kill — with no row, status or count moved. `SO-M03` neither issues nor is
offered.

Handoff: to the orchestrator — both files for commit, and the packet for issue
to tb_writer under a fresh spawn short-id.

### Open-questions
- **The 37-of-62 discharge figure is inherited, not re-derived.** It is
  `WO-0057` §11's "32 of 62" plus family I's five; my own count of benched ASSERT
  rows at `abf5d0b` gives **33**, so the running figure is uncertain by one. I
  will re-derive it at this packet's verdict rather than quote it again — the
  `J-dv_lead-0061` failure mode, where a denominator I had quoted rather than
  counted survived one packet too long.
- **A §4.I family note on co-simulation reach is offered, not written.** Families
  F and G carry notes because REQ-901's exclusions bind what a sign-off packet
  may offer; family I's limitation is the comparison domain's, which binds
  nothing normatively. It lives in `WO-0059` §6 item 4 for now; if `SO-M03` needs
  it in the plan, it is one note at the plan's next touch.
- **Owed and still owed**, updated: **bound 6** is blocked on **M03-B4**, which
  is unbenched along with M03-B2 and M03-B3 — family B is not in the queue's
  stated remainder and should be; **bound 7** unbenched; Finding 3's
  total-output-word sweep deferred with a named ground and a named home (§7.3);
  AP-M14's sweep companion; the `precompile_check.sh` side-effect-in-combinator
  lane; M03-F5's discharge-by-citation qualification; the RFC 1071 anchor on the
  next fetching run; X-7, X-10, X-11 deferred.
- **Raised, not decided, unchanged**: the adjudicator RTL-exposure control, which
  belongs in the next campaign packet.

### Files-in-this-commit
- agents/handoffs/WO-0059_tb-m03-family-i-silence-and-ordered-sets.md
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0083] 2026-08-07T06:20Z | task:WO-0059 | Family I BOUNCED on two reds that are the bench's and not the design's — and the arithmetic that acquits the design convicts my own §2.4, the wrapper's own docstring and, worst of the three, an attack-plan Observable cell that no conformant design can satisfy

### Trigger
Orchestrator: review WO-0059's return at `6001630` (`J-tb_writer-0016`), where
CI run `30874173054`'s `build` job went red on two of family I's five units —
`M03-I4 (length 64, lane 0, idles 1): word 0 arrived on cycle 4, expected 6` and
`M03-I6 (length 64, lane 0): word 0 arrived on the wrong cycle`. Adjudicate the
reds (worker defect, design defect, or wrapper defect — rule out rather than
assume), re-derive the discharge count I flagged as inherited at
`J-dv_lead-0082`, and issue the verdict.

### Inputs
- `agents/handoffs/WO-0059_…` in full, my own packet, including the RETURNED
  Return log (a)–(m).
- **`test/xgmii_rx_64/test_m03_i.ml`** (whole, 1285 lines), `test_m03_h.ml`'s
  diff at `6001630`, `bench.ml`/`bench.mli`'s diff, `dune`'s diff,
  `test_m03_f.ml:833` (M03-F5's citation discharge).
- **`test/xgmii/idle_injection.ml` and `.mli` in full** — the adjudication turns
  on whether the wrapper mis-models the front boundary, which cannot be ruled
  out by reading the bench.
- **`test/monitors/octet_time.mli` in full** — the adjudication turns on what
  `Latency.is_constant` actually demands.
- `docs/specs/requirements.md` **§0.5 in full** (Latency, front offset h, word
  delay ΔC, **Gapped stimulus**, Start lanes), REQ-004, REQ-005, REQ-011,
  REQ-016, REQ-019, REQ-101, REQ-103, REQ-104, REQ-111.
- `docs/specs/modules/xgmii_rx_64.md` **§6.1 in full** — the preamble-position
  paragraph, the more-than-one-event paragraph and its consequence 1 (the
  output-word-leaves-N-cycles rule and its **gapped-stimulus scope note**), the
  *Emitting the frame* paragraph, C-18, C-14.4.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.I (all six rows), §4.N (M03-N2's
  injection-proof note, M03-N3), §7 (X-4), §9.
- `agents/charters/dv_lead.md`, `agents/PROTOCOL.md`, `J-dv_lead-0080`,
  `J-dv_lead-0082`; `WO-0057`'s RV-0057-VERDICT (form).
- CI: run `30874173054` and both its jobs, read at the GitHub API rather than
  taken from the relay; the harvested `build` log's expect diff and promotion
  block.
- **No `libs/**`, no `top/**`, no `bin/**`, no `rtl_snapshots/**`, no
  `docs/reports/audit/**`, no `scripts/**`.** **The RV-0058 escalation-1
  exposure note did not bite**: I opened no design source, because the
  adjudication is arithmetic on the specification and on `test/**`. The single
  design fact used is the one number CI printed.

### Reasoning

**I set out to decide between three possibilities and the answer was a fourth
that contains all three.**

**First, the red itself.** `test_m03_i.ml:926–927` computes the expected
injected-line cycle of output word m as `Idle_injection.cycle_of (start_cycle +
3 + m)`. `cycle_of`'s domain is the **source input** cycle line — its own first
sentence says so and `idle_injection.ml` builds its map by walking
`Arrival.cycles schedule`. `start_cycle + 3 + m` is an **output** cycle. The
composition is a category error, and it is acausal in form: it delays an output
word by idles inserted **after** that word's octets had already arrived.

Worked for the exact failing member (64 octets, lane 0, `first_start:8`,
`idles:1`): the start character is at octet time 8, cycle 1; §6.1 puts the first
frame octet 8 octet times later, at octet time 16, cycle 2; content octets 0…63
fill source cycles 2…9; the terminate character is at octet time 80, cycle 10.
`uniform ~idles:1` proposes boundaries before cycles 3…10 — **none before cycle
2**, because the only earlier one is M03-N3's prohibited boundary. So content
octets 0…7 are **not delayed at all**, and output word 0, which carries exactly
those octets, leaves on its baseline cycle **4** — by §6.1's consequence-1 rule
(two cycles after the input word carrying the word's last octet at a lane-0
start, *scoped by §6.1 itself to hold on a gapped stimulus*) and independently by
§0.5's identity (input octet time 16 + L 16 = output octet time 32 = cycle 4,
byte 0). **The design's 4 is right and the bench's 6 is wrong**, and the error is
closed-form: 2k at a lane-0 start, k at a lane-4 start, for every m. At k = 7 it
predicts M03-I6's own red exactly (4 against 18). Two reds, one arithmetic, and
the correlation is the shared translator §7.2 item 2 named before the diff
existed.

**Second, the wrapper — ruled out rather than assumed, which is why I read it in
full.** `first_octet_cycle = start_cycle + 1` is the word carrying the frame's
first octet at **both** lanes (§6.1's own paragraph gives the lane-0 and lane-4
geometries separately and they agree on that index), `uniform`'s
`first = first_octet_cycle + 1` is the first boundary §6.1 admits, `cycle_of` is
a correct monotone injection, `in_times` is REQ-016's arithmetic applied. **No
behaviour defect.** But its `cycle_of` docstring's *second* sentence — *"This is
what a bench applies to every cycle §6.1 and §9 pin on the un-injected schedule:
`m + 3`…"* — is false, names an output cycle as the argument, and is where my own
§2.4 came from. X-4's unit tests could never have caught it: they exercise the
map, and the map is right. **Only a first customer against a DUT finds a defect
in the instructions for using a correct function**, which is precisely the
measurement §7.1 commissioned family I to make. It came back with a result.

**Third, and this is the finding that outgrew the round.** Having derived the
right rule I checked it against the row it serves — and `AP` §4.I's M03-I4
`Observable` cell says *"the per-octet constant of §7 is unchanged (16 at lane 0,
12 at lane 4)"*, with M03-I5 restating it as *the* gap-invariant quantity. **It
is not, at either start lane, and no conformant design can make it so.** Two
independent structural reasons, both derived at both ends:

*(a) The `tlast` word, both lanes.* `uniform`'s last site is the boundary before
the **terminate** word. The `tlast` word's `tkeep`, `tlast` and `tuser`[0] are
undecidable until that character arrives (REQ-011, REQ-103, REQ-104 — the design
cannot know which octets are FCS before it), so the word moves with the
terminate word while its own octets moved with an earlier one. At 64 octets,
lane 0, k = 1: delivered octets 56…59 arrive at injected cycle 16, the terminate
at 18, `tlast` therefore at 19, and **L = 24 for those four octets** while every
earlier octet holds 16.

*(b) Every output word's first half, lane 4.* §6.1 puts frame octets 0…3 in
lanes 4…7 of the word after the start word and 4…7 in the next, so **every**
output word straddles two input words and `uniform`'s first legal site falls
between them. REQ-011 forbids splitting the word and REQ-016 requires the word
sequence unchanged, so it must leave whole — giving **L = 20 and L = 12 inside
one word** at k = 1.

So `Latency.is_constant`, which demands a single L per front-offset class, is
**unsatisfiable on any injected run**, and `test_m03_i.ml:997–1010` plus
`assert_monitors_clean`'s latency half would fail a conformant design after the
cycle repair. **That is my own §2.2's false-`BUG-` failure mode arriving through
a door §2.2 did not name** — the worker handed the tagger the right array; the
claim the tagger is asked to judge is the wrong claim.

**Why I did not simply fix the row.** The claim lives in **frozen** text —
requirements.md §0.5's "Gapped stimulus" paragraph, REQ-016's verification
column, and §6.1's *"because §7's per-octet constant does"* justification. The
rule those sentences justify is right and survives; the justification does not.
Deciding that a normative sentence over-claims is the architect's, not mine
(charter §4: spec-ambiguity findings go up as packetized change requests), so I
raised **SCR-M03-I4** inside the verdict with the derivation and the ask, and
**left the AP cells unedited**. Editing them now would be me writing the ruling I
am asking for; commissioning a bench against them as they stand would be
building on a claim — **§1.1's own rule, applied to myself**. Hence the third
bounce item: round 2 **holds** the per-octet-constant clause as a *reported*
measurement rather than asserting it, and that measurement is what the ruling
will be scored against.

**Options I considered and rejected.** *Hold M03-I4 and M03-I6 entirely until
the ruling* — rejected because the cycle rule is unambiguous and already
normative, so most of both rows can land now and leaving CI red to wait on an
architect round costs more than it protects. *Let round 2 assert the per-octet
constant and see* — rejected outright: I have derived that it fails a conformant
design, and shipping an assertion I expect to redden correctly is manufacturing a
false `BUG-`. *Fix the docstring myself in this commit* — rejected as
gratuitous scope: it is one comment, it belongs with the round that consumes it,
and authorising it in the verdict keeps the repair and its reason in one diff.

**On conduct, and I want this on the record in the right order.** The worker did
what my packet told it to do, cited my section at the site, and its failure
message quotes my own prohibition back at me. It also caught its own circularity
in the delay identity before returning and rebuilt against sixteen separately
driven baselines — **which is the only reason the file contained an independent
expectation at all**, and therefore the only reason this red is distinguishable
from a design defect without a rerun. Three of my six sections that touch
injection were wrong (§2.4, §3.4 item 2, §3.4 item 4) and the fourth (§2.2) was
right about the trap and wrong about its only door. **The bounce is against the
file; the findings are against me.**

**The count.** §11 carried "37 of 62" flagged as inherited. Counted rather than
added: 78 rows, 62 ASSERT; 37 ASSERT rows named in a committed `%expect_test`
title; plus M03-F5, discharged by citation, which is exactly the missing one
that made `WO-0057`'s 32 and my own 33 disagree — **so the uncertainty of one is
closed, with its cause**. Minus M03-I4 and M03-I6, red at this SHA and therefore
discharging nothing. **36 of 62 at `6001630`**; 38 forward once family I lands
clean, not 37.

### Actions
- **Adjudicated both reds as bench defects.** Derived the conformant arrival
  cycle for the failing member from §6.1, §0.5 and REQ-016 by two independent
  routes; both give cycle 4, which is what the design produced. **No `BUG-`
  packet opened and none owed.**
- **Ruled out the wrapper as a behaviour defect** by reading `idle_injection.ml`
  and `.mli` in full against §6.1's two lane geometries, and **found its
  `cycle_of` docstring's second sentence false** — a test-infrastructure
  documentation defect with its own repair lane, authorised into round 2.
- **Derived the correct rule** (verdict §8) — `cycle_of` applied to the source
  cycle of the latest input word each output word depends on, plus that word's
  baseline offset, with the `tlast` word keyed to the **terminate** word — and
  **corrected `WO-0059` §2.4 and §3.4 items 2 and 4** in the packet itself.
- **Raised SCR-M03-I4** to architect_docs_lead inside the verdict, with the two
  structural derivations, the statement of what does survive, and an explicit
  refusal to draft text for a frozen document.
- **Re-derived the discharge count** and ruled **36 of 62** at `6001630`, naming
  both errors in the inherited figure.
- **Appended `RV-0059-VERDICT`** to `WO-0059`: state BOUNCED, twelve sections,
  six numbered findings, per-row dispositions, a five-item bounce scope, the
  round-2 Return-log deliverables and the tb_writer volume-02 rotation note.
- **Left `test/attack_plans/AP-xgmii_rx_64.md` untouched** — the owed edit is
  blocked on SCR-M03-I4 and saying so is the ruling.
- Ran no `git` command that writes.

### Evidence
1. CI, at the API: run `30874173054` head `6001630` conclusion **failure**; job
   `build` `91882127561` **failure** at step 6, steps 7–10 (**Generate RTL**,
   **Verify nothing was left unpromoted**, **DV mechanical checks**, **C-37
   quantifier**) **skipped**; job `cosim` `91882127487` **success**. The cosim
   result anchors nothing here — `CD-xgmii_rx_64_cosim.md` §5.2's X1 puts all
   cycle timing outside the comparison domain, so no family-I row is anchorable
   in it, and I do not cite it as support for the design.
2. Row/status tally, counted from the file at `6001630`:
   `grep -o '^| \*\*M03-[A-Z0-9]*\*\*.*| [A-Z-]* |$'` over
   `test/attack_plans/AP-xgmii_rx_64.md` → **78** rows; statuses **62 ASSERT**,
   7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP (sum 78).
3. ASSERT rows named in a committed `%expect_test` title in
   `test/xgmii_rx_64/`: A1 A2 A3 A5 / B1 / C1 C2 C3 C4 C5 / D1 D2 D3 / E1 E2 E4
   E5 / F1 F2 F3 F4 / G1 G2 G3 G4 G6 G7 G8 / H1 H2 H3 H4 / I1 I2 I3 I4 I6 =
   **37**, all ASSERT. Plus M03-F5 by citation (`test_m03_f.ml:833`) = **38**
   carrying a discharge; minus I4 and I6, red at this SHA = **36 of 62
   discharged**. At `abf5d0b` the same method gives 38 − 5 = **33**, reproducing
   `J-dv_lead-0082`'s own figure and identifying F5 as the missing one in
   `WO-0057` §11's 32.
4. Failing-member derivation, reproducible by hand from the specification:
   start character octet time 8 → cycle 1; first frame octet at 16 → cycle 2
   (§6.1); content 0…63 at octet times 16…79 → cycles 2…9; terminate at 80 →
   cycle 10; `uniform ~idles:1` sites before cycles 3…10 (`first_octet_cycle +
   1` through `terminate_octet_time / 8`), `injected = 8`; `cycle_of 2 = 2`,
   `cycle_of 3 = 4`, `cycle_of 4 = 6`, `cycle_of 10 = 18`. Output word 0 carries
   content 0…7, whose input octet times are unchanged at 16…23 ⇒ output octet
   times 32…39 ⇒ **cycle 4**. Bench asserted `cycle_of 4 = 6`. CI observed 4.
5. FINDING 5 (a), same member at k = 1: delivered octets 56…59 at source cycle 9
   → injected 16 → input octet times 128…131; terminate at source cycle 10 →
   injected 18; baseline `tlast` one cycle after the terminate word (11 after
   10) ⇒ injected `tlast` at 19 ⇒ output octet times 152…155 ⇒ **L = 24** where
   every earlier octet has 16.
6. FINDING 5 (b), 64 octets lane 4 (`first_start:12`) at k = 1: content 0…3 at
   octet times 20…23 (cycle 2, lanes 4…7) and 4…7 at 24…27 (cycle 3, lanes 0…3);
   `cycle_of 2 = 2`, `cycle_of 3 = 4`, so injected input times are 20…23 and
   32…35; the word must leave whole (REQ-011, REQ-016) one cycle after its last
   octet's word ⇒ cycle 5 ⇒ output octet times 40…47 ⇒ **L = 20 and L = 12
   inside one output word**.
7. `Latency.is_constant`'s contract, quoted from `test/monitors/octet_time.mli`:
   *"True iff at least one octet was compared and every front-offset class has a
   single L."* Evidence 5 and 6 are each a counter-example under injection.
8. Bench and `dune` deliverables verified against §8.1/§8.2 by
   `git show 6001630 -- test/xgmii_rx_64/bench.ml bench.mli dune`: one optional
   parameter threaded to `Arrival.create`, one comment line, nothing else.
9. `test_m03_h.ml` repairs verified against §7.3 by `git show 6001630 --
   test/xgmii_rx_64/test_m03_h.ml`: `~received`/`~delivered` split at four call
   sites, `~received = delivered` on aborted pieces and 64 on clean ones; one
   comment-only citation at `run_h3`. Green in CI at `6001630`.

### Outcome
**WO-0059 BOUNCED**, DoD partially met. **M03-I1, M03-I2, M03-I3 discharged**
(green, well-guarded, anti-vacuity satisfied); **M03-I5's declaration, the
`?ifg` addition, the `dune` line and both `test_m03_h.ml` repairs accepted**;
**M03-I4 and M03-I6 bounced** on a five-item scope.

**No `BUG-` packet**: the design's behaviour at the disputed observable is the
conformant one, derived twice from frozen text without opening `libs/**`.

**Three findings against my own work** (§2.4 and §3.4 item 4's replacement rule;
§3.4 item 2's per-octet delay identity; `AP` §4.I's M03-I4 Observable and
M03-I5's clause), **one against the machinery I own** (X-4's `cycle_of`
docstring), and **one against frozen specification text** raised as
**SCR-M03-I4** to architect_docs_lead rather than decided here.

**Discharge count ruled: 36 of 62 at `6001630`**, 38 forward once family I lands
clean. `SO-M03` does not issue. Family I's qualification campaign does not open.

Handoff: to the orchestrator — the packet for commit and the bounce for reissue
to tb_writer under a fresh spawn short-id, and **SCR-M03-I4 for relay to
architect_docs_lead**.

### Open-questions
- **SCR-M03-I4 needs a route.** It is written inside `RV-0059-VERDICT` §6 because
  packet numbers are the orchestrator's to allocate and I will not invent one. If
  the orchestrator prefers a standalone packet addressed to architect_docs_lead I
  will author it against an allocated id; otherwise the verdict section is the
  artifact and should be relayed as it stands.
- **The `AP` §4.I edit is owed and is deliberately not in this commit** —
  M03-I4's `Observable` and M03-I5's cells, blocked on that ruling. Counts stay
  78 / 62 ASSERT until it lands. This is the same shape as `J-dv_lead-0072`'s
  owed edit, with the block named instead of the timing.
- **§8's rule is checked against exactly one observed cycle.** Forty-seven of
  M03-I4's runs and all four of M03-I6's are predictions. If round 2 finds the
  design disagreeing anywhere, that is a finding to receive, not an expectation
  to adjust — and it would be the first evidence for a `BUG-` in this family.
- **CI at `6001630` did not run `dv_checks.sh` or the unpromoted-drift check**
  (steps 7–10 skipped), so §(l)'s inventory figures are the worker's local
  measurement only. They will be corroborated at round 2's green SHA.
- **Owed and still owed**, updated: the `AP` §4.I edit (above, blocked);
  `RV-0057-VERDICT` Finding 3's total-output-word sweep, whose shared ground —
  M03-I2's derived drain bound — **now exists and is green**, so its precondition
  is satisfied for the first `test/**` touch after family I lands; bound 6
  blocked on M03-B4, with M03-B2/B3/B4 all unbenched and family B still not in
  the queue's stated remainder; bound 7 unbenched; AP-M14's sweep companion;
  the `precompile_check.sh` side-effect-in-combinator lane; **M03-F5's
  discharge-by-citation qualification, now load-bearing** because it is the row
  that closes the denominator's uncertainty-of-one; the RFC 1071 anchor on the
  next fetching run; X-7, X-10, X-11 deferred.
- **Raised, not decided, unchanged**: the adjudicator RTL-exposure control,
  which belongs in the next campaign packet. It did not bind this round — I
  opened no design source — and that is a datum for it, not a resolution of it.

### Files-in-this-commit
- agents/handoffs/WO-0059_tb-m03-family-i-silence-and-ordered-sets.md

## [J-dv_lead-0084] 2026-08-07T09:30Z | task:WO-0059 | The design is convicted this time — a mid-frame idle makes M03 mark `tlast` on word 0 of an eight-word frame, and the guard that caught it is the one round 1's own defect was standing in front of

### Trigger
Orchestrator: the WO-0059 FINALIZE round at `4901161`. CI run **30881653846**
compiles clean, M03-I1/I2/I3 green again, and the two rebuilt units fail a guard
round 1's red never reached — `M03-I4 (length 64, lane 0, idles 1): word 0
unexpectedly carries tlast` and `M03-I6 (length 64, lane 0): word 0 unexpectedly
carries tlast`. Adjudicate between four named candidates (bench guard/sampling;
wrapper site model; design non-conformance; a mis-stated ruling), re-countersign
the §0.5 + REQ-016 ruling under C-43, make the attack-plan edit the ruling
unblocks, rule the worker's two flagged judgment calls, re-derive the discharge
count, and append the round-2 verdict. **This entry carries everything that is
packet traffic** — the adjudication, `BUG-0002`, the round-2 verdict and the
§0.5 + REQ-016 countersignature, all of it inside `agents/handoffs/`. **The
attack-plan repair the signature licenses rides in the next commit**
(`J-dv_lead-0085`), which is the packet-then-plan split `J-dv_lead-0071` and
`J-dv_lead-0072` used for exactly this pair and which keeps the plan's diff
separately readable. The two commits have **disjoint** file sets by
construction.

### Inputs
- **CI**: run `30881653846` at `4901161`, job `91904129422` — the full log and
  the decoded promoted file, harvested to an **ephemeral** scratch path
  (`/tmp/.../wo59_harvest/`, ADR-0003/F5: not a repo artefact and not citable as
  one). Read: the `dune build @default` step, the `dune runtest` step's exit
  code, the promotion block's file list and both expect-diff hunks, and the
  trailing-output line carrying the k = 0 report.
- `test/xgmii_rx_64/test_m03_i.ml` **in full at `4901161`** (1512 lines);
  `test/xgmii/idle_injection.ml` and `.mli` **in full**, again;
  `test/xgmii/xgmii_word.ml` and `.mli`; `test/xgmii_rx_64/bench.ml:84–229`
  (the `sample` record, `sample_cycle`'s `Before`/`After` split, `run`'s drive
  loop, `delivered_samples`); `test/attack_plans/AP-xgmii_rx_64.md` §4.I, §4.N,
  §5's two routes, §6, §7's X-4, §9.
- `docs/specs/requirements.md` at `a77017c`: **§0.5 in full** (the Latency
  sentence's new gapless qualifier, **Gapped stimulus (normative)**, **the
  deciding input word**, **what survives idle injection**, **what a latency
  monitor may demand**, the §0.6 relation, provenance), **REQ-016's repaired
  verification column**, REQ-005, REQ-011, REQ-013, REQ-015, REQ-101–REQ-113,
  REQ-901's ADR-0015 D2 clause, **§1.1's h column**, §13's new row.
- `docs/specs/modules/xgmii_rx_64.md` at `a77017c`: **§6.1 in full** (consequence
  1 and its repaired scope note, the Emitting-the-frame paragraph, C-18, the
  C-14.4 qualifier with its withdrawn sentence, **D(m)**, the two structural
  derivations, **the residue table**, item 3's survival case, the two C-18
  non-instances, the FCS-by-residue list, the cycle table, the Between-frames
  drain derivation), **§6.2's four state rows in full**, §6.3 items 1–6, §7's
  handshake bullet, §10's REQ-016 hook, §13's new row.
- `agents/handoffs/WO-0059_…` in full including `RV-0059-VERDICT` (§2, §3, §6,
  §8, §9, §12); `agents/handoffs/BUG-0001_…` (form and severity precedent);
  `agents/handoffs/README.md` (the `BUG-` template); `tasks/BOARD.md` (the
  `BUG-` prefix's allocation state).
- `agents/journals/workers/claude_tb_writer_agent.v02.md`
  **`J-tb_writer-0018` and `J-tb_writer-0019` in full** — the round-2 return of
  record, including both flagged judgment calls.
- For the countersignature's checks additionally: `test/monitors/octet_time.mli`
  (`Latency.is_constant`'s contract) and `octet_time.ml`'s `derived_errors`;
  `git show a77017c --stat` and the full diffs of both spec files (the
  confinement check, **run** rather than taken from the diff's own claim);
  `J-dv_lead-0081` and `72192ba` as the countersignature form.
- `agents/charters/dv_lead.md`, `agents/PROTOCOL.md`, `J-dv_lead-0083`.
- **No path under `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**` was
  opened, targeted or swept at any point this spawn. No path under
  `docs/reports/audit/**`.** The single design fact used is what CI printed.
- Attempted and failed: `opam exec -- dune build @default` locally — the
  Hardcaml package tree is absent from this environment (ADR-0005). **CI is the
  only execution evidence in this entry** and no number below is a local re-run.

### Reasoning

**I set out to rule between four candidates and the evidence separates them
cleanly, which it did not last round.**

**(i) The guard is out, and the reason is that it is injection-independent and
green at k = 0.** The predicate is `if m = words - 1 then require tlast else
require (not tlast)`. It contains no term from `Idle_injection`, no cycle and no
`k`; `words` = 8 is computed from the frame length **and** confronted with a
separately driven un-injected simulation whose own word count and `tlast` cycle
are guarded; and `delivered_samples` filters on `tvalid` alone, so there is no
stream walk to get wrong. The `M03-I4 (length 64, lane 0, idles 0)` member ran
the identical predicate over the identical frame **immediately before** and
printed GREEN. A guard that is wrong under injection and right without it would
have to depend on injection. This one cannot.

**Round 1's "word 0 arrived on cycle 4" does not need re-reading, and that is
worth stating rather than assuming.** It is the same measurement round 2 made.
Round 1's bench predicted 6 and I derived 4 from frozen text by two routes;
round 2 predicts 4 and the design produced 4, at **both** figures. The
observation has moved from failing a wrong guard to passing a right one. What
round 1 could not see is that the *next* guard was already going to fire — the
design's `tlast` was presumably as wrong at `6001630` as it is at `4901161`, and
nothing about M03 changed between them. **My round-1 acquittal of the design was
correct on the observable in dispute and silent on this one, which is the
difference between an acquittal and a clean bill.**

**(ii) The wrapper's site model is out, and the answer to the scope question is
the opposite of the reading it invites.** The question was whether REQ-016's
promise reaches idles injected *inside* an open frame or only between frames.
Four frozen places say inside, three of them older than the ruling: REQ-016's
own normative sentence says *"arbitrary idle gaps **within a frame** without
corrupting it"*; SPEC-M03 §6.2's **`Frame`** row names *"an idle cycle injected
under REQ-016"* as a word that **holds** the frame; §6.1's C-14.4 paragraph says
such a word *"is **not** a condition"*; and §10's REQ-016 hook commissions the
wrapper at this module at 0, 1 and 7 cycles at both start lanes. **The
deliberateness is legible in the state table itself**: §6.2's `Preamble` row
enumerates *"`/I/` and `/Q/` included"* among its exits and the `Frame` row does
not — the specification distinguishes an idle character in a preamble position
from one in a data position and gives them opposite dispositions. M03-N3 is the
whole of the exclusion, it bars exactly one boundary, `uniform` begins one
boundary later at both lanes, and the bench **asserted** `errors` and
`c45_sites` empty before the design was driven.

And the counterfactual settles it independently: **a wrapper restricted to
inter-frame gaps would measure REQ-109, not REQ-016**. That gap is `Idle` state
and is already carried by M03-I1, I2 and I3. So a "fix" that moved the sites out
of the frame would convert M03-I4 into a vacuous restatement of rows this family
already has — the exact failure mode §2.1 of my own packet exists to prevent. So
**the stimuli do not change, at any length or lane, and the AP rows do not move
on this account.** My packet authored these sites; had they been wrong the
finding would have landed on me as three did last round. It does not, and saying
so plainly is the same duty as saying the reverse was.

**(iv) The ruling is out, and I checked the half that would have been convenient
to skip.** The clause under test is §0.5's *"the ordered sequence of (`tdata`,
`tkeep`, `tlast`, `tuser`) tuples is unchanged"*. The design changed it. The
ruling states the promise the design fails; it does not overstate it. Its own
factual claim about this member — *"the design's own answer — word 0 on cycle 4
at the failing member — is the one this text now describes"* — is **vindicated**,
not falsified. And its "no conformant design changes" classification is a claim
about the diff, whose truth does not depend on whether any particular design is
conformant; a non-conformant design is not a counter-example to it. I return one
**note**, not a disagreement, and it rides with the signature rather than
against it (N-1, below).

**(iii) is the answer, and the strongest evidence for it is a guard that did
NOT fire.** If the design had routed the mid-frame idle word the way §6.2's
`Preamble` row routes an idle in a preamble position — to REQ-105 — it would
have aborted the frame and emitted **one** output word, and the count guard at
`:1023` would have raised first with *"expected 8 output words, got 1"*. It did
not. The design emitted **8** words (the conformant count) with word 0 on cycle
**4** (the conformant cycle) and `tkeep` **0xFF** (conformant) and `tlast`
**1** (not). **The state machine did not abort; the framing marks are wrong.**
That is a narrower and more useful statement than "the design fragments the
frame", and it is the one the evidence supports.

**What I refused to do with it.** I have a mechanism in mind — a `tlast` derived
from "no further octets are buffered", which would mark every word whose
following input word covers no frame octet — and it fits every number. It is a
**prediction**, it is written into `BUG-0002` §4 **in the open** (nothing is
withheld, so R-SEAL-1 does not reach it), and it is labelled as something I have
not observed and cannot observe without a diagnostic run or RTL I have not
opened. The packet asks the fix's Root-cause section for the one table that
would settle it — the eight `(cycle, tkeep, tlast, tuser)` rows at the failing
member. Writing a mechanism into an Observed section would be the shape of error
this programme keeps finding in its own text: an inference stated where a
measurement belongs.

**Severity, and the counter-consideration I did not suppress.** CRITICAL. It
corrupts a frame at the head of the receive chain, under an unconditional IFC
requirement whose own words are *"without corrupting it"*, and BUG-0001 — the
precedent — was CRITICAL for over-delivering octets on the final word, which is
the same harm reached from the other side. The honest counter is that an idle
character does not appear inside a frame on a real 802.3 link. Three answers,
all in the packet: REQ-018 makes this boundary simulation-only and hands the
link partner's contract to DV; §6.2 and §6.1 specify the behaviour
**unconditionally** and §10 commissions the measurement by name; and REQ-016
binds every receive-path stream, where the same gap is an ordinary `tvalid`
deassertion. **Narrowing REQ-016's reach at an XGMII port would be a spec diff
with a countersignature, not a ground for closing a packet** — and I say so in
the packet so that the option is visible and correctly priced rather than
available as a quiet dismissal.

**The two flagged judgment calls, and the first of them is a correction of me.**
The worker reported that §8's literal delay-identity instruction has no anchor
octet for 2 of 16 `(length, lane)` pairs and substituted a closed form from
`uniform`'s documented contract. I checked the closed form (exact: the shift at
the terminate word is `idles × (terminate_cycle − first_octet_cycle)`, and
`cycle_of(10) − 10 = 8` at the worked member agrees), checked the two named
pairs (right: the terminate word is octet-free iff the terminate character is in
lane 0, which is `r` = 0 at lane 0 and `r` = 4 at lane 4) — **and found the
worker under-claimed.** The literal instruction is wrong not at 2 pairs but at
**10**: wherever the terminate word is later than the word carrying the last
delivered octet, which is `r ∈ {0,1,2,3,4}` at lane 0 and `r ∈ {0,4,5,6,7}` at
lane 4, five of eight lengths at each lane. At length 64 / lane 0 / k = 1 the
literal form predicts a shift of 7 against a conformant 8 and **would have gone
red against a conformant design** — my §8 repeating, at word granularity, the
error FINDING 5(a) convicted the specification of. The substitution stands at all
sixteen. The second call — extending the HOLD to `run_i4`'s cross-run
`is_constant` — is correct and the omission is mine: §12 item 3 cited line
numbers where it should have cited the claim, and the cross-run tagger asserts
the identical unsatisfiable thing. Both were flagged rather than absorbed, which
is why they can be ruled on their merits instead of discovered.

**Why ACCEPT-with-HOLD and not a third bounce.** There is nothing for a bench
writer to do. The file does what the verdict asked, guards what it was told to
guard, diverges twice with the reasoning written down, and one divergence
repairs the packet. Bouncing it would be blaming the file for the design —
precisely the inverse of the error this packet already convicted itself of once,
and a worse one, because it would ask a worker to make a defect disappear. So:
the **round** is ACCEPTED, the **rows** are HELD red, `WO-0059` does not close,
and no round 3 issues. I also considered and rejected converting the assertion
to a reported form so CI would go green — that is amending an expectation to
agree, barred by REQ-901's ADR-0015 D2 clause and by my own §12 item 5, which
told the worker this exact thing in this exact round. **The red stands. The cost
is a red `runtest` on the branch until the fix lands, and it is the correct
cost.**

**The count did not move and that is the point.** 78 rows, 62 ASSERT, counted;
37 ASSERT rows named in a committed `%expect_test` title plus M03-F5 by citation
= 38 carrying a discharge; minus M03-I4 and M03-I6, red = **36 of 62 at
`4901161`**, identical to `6001630`. What changed is the **block**: forward is 38
and it is now gated on `BUG-0002`'s fix, with **no further bench work required
to reach it**.

**On the packet number.** `BUG-0001` is the only packet of this prefix, so 0002
is the sole monotonic candidate; I have named the file `BUG-0002` rather than
leave a bug in prose, because a `BUG-` is verbatim-relay class and must be a
file (PROTOCOL §3). Allocation remains the orchestrator's and the packet's own
header says so and says what to do if it allocates otherwise. Last round I
refused to invent an id for **SCR-M03-I4** and put it inside a verdict section
instead; the difference is that an SCR has no template, no prefix and no
existing series, and a `BUG-` has all three.

**And the countersignature, which lands in this same commit because it is packet
traffic and because the round owes it under C-43. I sign the §0.5 + REQ-016 diff
at `a77017c` as testable and correct.** Seven checks, written out in the
`COUNTERSIGNATURE` block; the three that did the real work:

**The residue table is the thing a signature can actually verify, so I verified
it rather than endorsed it.** Writing the start character at octet time `T`,
frame octet *j* at `T + 8 + j`, `N = 8q + r` octets between the start and
terminate characters, the last delivered octet at index `N − 5`: at a lane-0
start the terminate's cycle is `s + 1 + q` and the last delivered octet's is
`s + q` for `r ≤ 4`, `s + 1 + q` for `r ≥ 5` — **later iff `r ∈ {0,1,2,3,4}`**;
at a lane-4 start the terminate's is `s + q + 1` for `r ≤ 3` and `s + q + 2` for
`r ≥ 4` while the octet's is `s + q` for `r = 0` and `s + q + 1` otherwise —
**later iff `r ∈ {0,4,5,6,7}`**. Both sets are exactly the ruling's. **And I
checked the survival case one level deeper than the ruling states it**, because
"the terminate shares the word carrying the last delivered octet" is not by
itself enough: at a lane-0 start with `r ∈ {5,6,7}` the `tlast` word carries
**one, two and three** octets respectively and all of them lie in that same word,
so nothing straddles, nothing is late-decided, and `L = 16` genuinely holds octet
for octet. Item 3 is sound, and its own refusal to let a bench generalise from it
is the right instruction rather than a hedge.

**The check I care most about is against the instrument, not the text.** §0.5's
new clause says a monitor SHALL NOT demand a single per-octet L on an injected
run at a module failing either test. That is not a claim about prose; it is a
claim about what `Dv_monitors.Octet_time.Latency.is_constant` may be asked for —
and its contract is *"every front-offset class has a single L"*, the forbidden
predicate verbatim. At `4901161` the committed bench holds exactly that predicate
at both sites that carried it, keeps `Latency.errors` asserted (sound:
`derived_errors` matches only a singleton `latencies` list), and keeps the
front-offset check a real assertion (correct: `h` is §0.5's **correspondence**
term, not the constant). The monitor clause is implemented, not merely agreed
with.

**And one check was available to this signature that is usually available to
none.** The ruling's central factual claim about the failing member — word 0 on
cycle 4 — has now been **measured**, and §6.1's D(m) is the first clause of this
ruling ever confronted with hardware. It survived. Which is why `BUG-0002` is
**not** a finding against the ruling: the design fails the very clause the ruling
states, and that is the ruling being useful rather than wrong.

**N-1 is a note and not a withholding, and I want the distinction on the record
because I have withheld before and this is not that.** REQ-016's repaired column
gates the extra per-octet assertion on a **module**-level property — *"where
§0.5's two tests both pass at a module"* — while §0.5's own late-decision test
makes survival a property of the **(start lane, residue)** pair: at M03 lane 0
the constant survives at `r ∈ {5,6,7}` and fails at `r ∈ {0,1,2,3,4}`, same
module, same port, one octet of frame length apart. At M03 it licenses nothing,
because §7 makes no such claim, so it **cannot fail a conformant design and
blocks nothing** — which is precisely why it is a note rather than a contest.
The exposure is a later bench reading the per-module gate as licensing an
assertion at every length its module accepts. Offered as a clause, not demanded,
riding with whichever WO next opens REQ-016 alongside the three restatements the
§13 row already names.

### Actions
- **Adjudicated the round-2 red as (iii), a design non-conformance**, ruling out
  (i) on the guard's injection-independence and its green k = 0 run through the
  same code path, (ii) on four frozen citations plus the vacuity counterfactual,
  and (iv) on the clause under test plus two checks of the ruling's own claims.
- **Opened `BUG-0002`, CRITICAL** — reproduction, the stimulus rebuilt from the
  specification, the conformant output table at both figures, the four measured
  facts, an explicit list of what the raise left **unmeasured**, the three
  alternatives ruled out, an **open** prediction with the diagnostic table that
  would settle it, and the severity argument including its counter-consideration.
- **Appended the round-2 `RV-0059-VERDICT` block** to `WO-0059`: state
  **ACCEPTED**, rows **HELD**, ten sections, per-row dispositions, both flagged
  judgment calls ruled, the count re-derived, and the note that goes back with
  the countersignature.
- **Recorded the round-2 RETURNED entry** in the packet, since the worker staged
  no Return-log text this round and its return of record is two journal entries.
- **COUNTERSIGNED requirements.md §0.5 and REQ-016 at `a77017c`, GRANTED**, in a
  `COUNTERSIGNATURE` block appended to the same packet — scope named explicitly,
  seven checks written out with their arithmetic, confinement checked across the
  tree, and note **N-1** returned with the signature rather than against it.
- **Ruled that no round 3 issues** and that no expectation is adjusted.
- Ran no `git` command that writes. Opened no design source.

### Evidence
1. **CI**, run `30881653846` at `4901161`, job `91904129422`: `dune build
   @default` clean; `dune runtest` exit code 1; promotion block lists **one**
   file, `test/xgmii_rx_64/test_m03_i.ml`, in **two** hunks — the `%expect_test`
   blocks of M03-I4 (`@@ -1298,7 +1298,30 @@`) and M03-I6 (`@@ -1508,5 +1531,20
   @@`). Backtraces name `run_i4_case` at `test_m03_i.ml:1037` and `run_i6_case`
   at `:1450`. Trailing output carries exactly one report:
   `[M03-I4 (length 64, lane 0, idles 0)] frames=1 octets=60 latency=CONSTANT
   per front offset (1 class) / h=8 L=16 word_delay=3 frames=1 octets=60`.
2. **The conformant output for the failing member, reproducible by hand from the
   specification.** Start character at octet time 8 → source cycle 1; frame
   octets 0 … 63 at octet times 16 … 79 → source cycles 2 … 9; terminate at
   octet time 80 → source cycle 10 (REQ-106). `uniform ~idles:k` → sites before
   source cycles 3 … 10. Injected map: `c ↦ c` for `c ≤ 2`, `2c − 2` for
   `2 ≤ c ≤ 10` at k = 1 and `8c − 14` at k = 7. D(m) = source cycle of frame
   octet `8m + 7` = `2 + m` for m ≤ 6, the terminate word (cycle 10) for m = 7.
   Words 0 … 6: `tkeep` 0xFF, `tlast` 0, cycles **4, 6, 8, 10, 12, 14, 16**
   (k = 1) and **4, 12, 20, 28, 36, 44, 52** (k = 7). Word 7: `tkeep` 0x0F,
   `tlast` 1, `tuser`[0] 0, cycle **19** (k = 1) and **67** (k = 7). Sixty
   delivered octets, no strobe.
3. **What the design produced**, at both figures: `tvalid` word count **8** (the
   guard at `:1023`/`:1440` passed), word 0 on cycle **4** (guard at `:1041`
   passed), word 0 `tkeep` **0xFF** (guard at `:1056` passed), word 0 `tlast`
   **1** (guard at `:1058–1061` / `:1467–1470` raised).
4. **The abort reading is excluded by a guard that did not fire**: an abort
   under REQ-105 emits one output word, and `:1023` would have raised
   *"expected 8 output words, got 1"* before the `tlast` guard was reached.
5. **The injected word is an XGMII idle**: `Idle_injection.word_at` returns
   `Xgmii_word.idle` on an injected cycle (`idle_injection.ml:163–169`), and
   `Xgmii_word.idle` is eight `Control 0x07` lanes (`xgmii_word.ml:37`) —
   requirements.md §2's `/I/`.
6. **Stimulus legality asserted, not assumed**: `Idle_injection.errors` and
   `c45_sites` are checked empty at `:993–1007` and `:1418–1428` before the
   design is driven, and the run reached the word loop, so both were empty.
   `uniform`'s first site is `first_octet_cycle + 1` (`idle_injection.ml:150`),
   one boundary past M03-N3's prohibition, at both start lanes.
7. **Call 1 verified.** `uniform` places `idles` idles at every boundary in
   `[first_octet_cycle + 1, terminate_cycle]`, so the shift at the terminate
   word is `idles × (terminate_cycle − first_octet_cycle)`; at length 64 /
   lane 0 / k = 1 that is `1 × (10 − 2) = 8`, and `cycle_of(10) − 10 = 18 − 10 =
   8`. The terminate word carries no frame octet iff the terminate character is
   in lane 0, i.e. `r` = 0 at a lane-0 start (length 64) and `r` = 4 at a lane-4
   start (length 68) — the worker's two pairs, and the only two. **The literal
   §8 form is wrong at ten pairs**, not two: the terminate word is later than
   the last-delivered-octet word for `r ∈ {0,1,2,3,4}` at lane 0 and
   `r ∈ {0,4,5,6,7}` at lane 4, five of eight lengths at each lane; at length
   64 / lane 0 / k = 1 it predicts shift 7 against a conformant 8.
8. **Call 2 verified.** `run_i4`'s cross-run tagger accumulates all 48 injected
   runs (`:1192–1193`, `:1239–1249`) and its retired `is_constant` / per-class
   `latencies` equality is the same claim as `run_i4_case`'s. `front_offset` and
   `frames` remain asserted (`:1268–1278`) and `Latency.errors` remains asserted
   on both taggers (`:1161–1166`, `:1251–1253`) — sound, because
   `octet_time.ml`'s `derived_errors` matches only a singleton `latencies` list.
9. **Count, from the files at `4901161`, not carried forward.** `grep -c '^| \*\*M03-'`
   over `test/attack_plans/AP-xgmii_rx_64.md` → **78**; status tally → **62
   ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP (sum 78). Rows
   named in a committed `%expect_test` title under `test/xgmii_rx_64/` → **38**
   (36 `%expect_test` blocks), of which **37 ASSERT** and one NO-ASSERT
   (M03-A4). Plus M03-F5 by citation (`test_m03_f.ml:833`) = **38**; minus
   M03-I4 and M03-I6, red = **36 of 62**.
10. **Local execution unavailable**: `opam exec -- dune build @default` fails
    with `Library "hardcaml" not found` (ADR-0005); the opam switch `fpga` holds
    only base packages. No claim in this entry is a local re-run.

**The countersignature's seven checks** (C-1 … C-7 in the `COUNTERSIGNATURE`
block; the arithmetic, so it can be re-executed by hand):

11. **C-1, the residue table.** Lane 0: terminate cycle `s + 1 + q`,
    last-delivered-octet cycle `s + 1 + ⌊(N − 5)/8⌋` = `s + q` for `r ≤ 4` and
    `s + 1 + q` for `r ≥ 5` ⇒ later iff **`r ∈ {0,1,2,3,4}`**. Lane 4
    (`T = 8s + 4`): terminate at `8(s + q + 1) + (4 + r)` ⇒ cycle `s + q + 1`
    (`r ≤ 3`) or `s + q + 2` (`r ≥ 4`); last delivered octet at
    `8(s + q) + (7 + r)` ⇒ cycle `s + q` (`r = 0`) or `s + q + 1` (`r ≥ 1`) ⇒
    later iff **`r ∈ {0,4,5,6,7}`**. Both match §6.1's derivation 1 exactly.
12. **C-2, the survival case checked one level deeper.** Lane 0, `r ∈ {5,6,7}`:
    delivered = `8q + r − 4`, so the `tlast` word carries indices `8q … N − 5` —
    **1, 2, 3** octets — all at octet times `T + 8 + 8q …`, inside the
    terminate's own word. Nothing straddles, nothing is late-decided,
    `h = 8 ≡ 0 (mod 8)`.
13. **C-3, straddle verdicts against §1.1's own h column**: `h` = 12 (M03 lane
    4), 14 (M06), 20 (M14) are not multiples of 8; `h` = 8 (M03 lane 0), 0
    (M08), 8 (M17) are. §1.1's normative table gives exactly those six values, so
    the three owed restatements are the right three.
14. **C-4, the ruling's worked example reproduced**: 64-octet lane-0 frame,
    `k = 1` — octets 56–59 at injected cycle 16, input octet times 128–131;
    terminate word at injected cycle 18; `tlast` word at injected cycle **19**,
    output octet times 152–155; **`L = 24`** against `L = 16` earlier.
15. **C-5 / C-6, the instrument and the column.**
    `test/monitors/octet_time.mli`: `Latency.is_constant` is *"true iff at least
    one octet was compared and every front-offset class has a single L"* — the
    predicate §0.5 now forbids demanding on an injected run; held at
    `test_m03_i.ml:1146–1187` and `:1254–1283`, with `Latency.errors` still
    asserted at `:1161–1166` and `:1251–1253`. REQ-016's clause (a) is asserted
    at `:1037–1061` and `:1450–1470`; clause (b) at `:1093–1115` with
    `dependency_source_cycle` / `injected_word_cycle` at `:922–930`.
16. **C-7, confinement, run rather than taken**: `git show a77017c --stat` →
    **3 files** (`docs/specs/requirements.md` +120/−21,
    `docs/specs/modules/xgmii_rx_64.md` +104, the architect's journal volume).
    REQ-013, REQ-014, REQ-015, REQ-017 and REQ-018 appear in the requirements
    diff as **context only**. Nothing under `test/**`, `libs/**`, `scripts/**`,
    `docs/gates/**` or `docs/reports/**`.

### Outcome
**`WO-0059` round 2 ACCEPTED; M03-I4 and M03-I6 HELD RED against `BUG-0002`.**
DoD met for the worker in full — five items asked, five met, two divergences
ruled correct and one of them a repair of my own §8. DoD **not** met for the
rows: family I is complete as a bench and incomplete as evidence.

**`BUG-0002` opens, CRITICAL**, the programme's second hardware bug and the
first found by a family written to close a requirement rather than by a bench
characterising a frame. **No round 3 for tb_writer**; no expectation adjusted;
the two units stay red until the design changes.

**Discharge count: 36 of 62 at `4901161`**, unchanged from `6001630`; forward 38,
blocked on the fix and on no bench work.

**§0.5 and REQ-016 COUNTERSIGNED, GRANTED**, on seven checks and with one
non-blocking note (N-1). **The diff is in force from the orchestrator's
transcription** into requirements.md §13, not from this commit; the signature of
record is the `COUNTERSIGNATURE` block in
`agents/handoffs/WO-0059_tb-m03-family-i-silence-and-ordered-sets.md` plus this
entry. **I sign gate-class item: requirements.md §0.5's gapped-stimulus
replacement, the deciding-input-word definition, the surviving-quantity clause,
the monitor clause, and REQ-016's repaired verification column, all at
`a77017c`.**

**`SO-xgmii_rx_64.md` does not issue and is not owed.** Family I's qualification
campaign does not open.

Handoff: to the orchestrator — `BUG-0002` for **verbatim** relay to rtl_lead;
this signature for **transcription** into requirements.md §13 under the
orchestrator's own trailer (PROTOCOL §7's clerical rule, the form used at
`J-dv_lead-0081`); note **N-1** for routing to architect_docs_lead with whichever
work order next opens REQ-016; and the packet for commit. **The attack-plan
repair the signature licenses follows in the next commit
(`J-dv_lead-0085`), with a disjoint file set.**

### Open-questions
- **`BUG-0002`'s id is the orchestrator's to confirm.** `0002` is the only
  monotonic candidate at this SHA; the packet header says what to do if the
  allocation differs, and this entry's `Files-in-this-commit` list is the
  binding statement of the committed path.
- **N-1 is offered, not demanded, and is owed no ruling before anything
  proceeds.** It licenses nothing at M03 today. If the architect declines it, the
  standing protection is SPEC-M03 §6.1 item 3's own *"a bench SHALL NOT
  generalise from it"*, which is already normative.
- **The three restatements the §13 row names — SPEC-M06 (§7, §10), SPEC-M10 (§3,
  §6.1, §7, §10), SPEC-M14 (§3, §6.1, §7, §10, §11.2) — are not mine and are not
  discharged by this signature.** None has a committed bench, so nothing is
  blocked. **But AP-M14 exists**, and whether it carries the same retired claim
  its spec does is a question I have not asked; it rides with AP-M14's owed §6
  sweep companion, named now so it is not discovered later.
- **The mechanism in `BUG-0002` §4 is a prediction and may be wrong.** It is
  stated in the open — nothing withheld, so R-SEAL-1 does not reach it — and the
  fix's Root-cause section is asked for the one table that settles it.
- **47 of M03-I4's 48 runs and all four of M03-I6's are still unexecuted past
  their first output word.** Everything this family asserts about lane 4, about
  lengths other than 64, and about the 1518-octet member remains a prediction.
  A fix that turns word 0 green may reveal a second disagreement further in, and
  that too would be a finding to receive.
- **If rtl_lead disputes `BUG-0002` as spec ambiguity it goes to
  architect_docs_lead immediately** (charter §7), and I carry it there rather
  than argue it in a return.
- **Still owed**, unchanged in substance from `J-dv_lead-0083` and restated in
  the verdict's §10: `RV-0057-VERDICT` Finding 3's total-output-word sweep
  (precondition now satisfied); AP-M14's §6 sweep companion; the
  `precompile_check.sh` side-effect-in-combinator lane; M03-F5's
  discharge-by-citation qualification, still the row that closes the
  denominator's uncertainty-of-one; the RFC 1071 anchor on the next fetching
  run; bound 6 (blocked on M03-B4, family B still unqueued); bound 7; X-7, X-10,
  X-11 deferred.
- **The adjudicator RTL-exposure control** remains raised and undecided
  (`J-dv_lead-0080`). It did not bind this round either — no design source was
  opened — which is now two adjudications of design behaviour decided without
  it. That is a datum for the decision, not a resolution of it.

### Files-in-this-commit
- agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md
- agents/handoffs/WO-0059_tb-m03-family-i-silence-and-ordered-sets.md


## [J-dv_lead-0085] 2026-08-07T10:15Z | task:WO-0059 | The attack-plan repair the countersignature licenses — and it is four cells, not the two I declared owed, because the two I missed cite the retired claim as a *ground* in a family I was not looking at

### Trigger
My own call, taken inside the WO-0059 FINALIZE round and immediately after the
commit carrying the signature (`J-dv_lead-0084`). `J-dv_lead-0083` declared the
`AP` §4.I edit **owed and blocked** on the SCR ruling; the ruling landed at
`a77017c` and I countersigned it one commit ago, so the block lifts and the
repair lands now, before any bench is re-commissioned (ADR-0001's
row-before-bench rule). Packet traffic in the previous commit, the plan in this
one — the split `J-dv_lead-0071` and `J-dv_lead-0072` used for exactly this pair.
**The two commits have disjoint file sets and this one touches
`test/attack_plans/AP-xgmii_rx_64.md` alone.**

### Inputs
- `test/attack_plans/AP-xgmii_rx_64.md` — **§4.I's six rows in full**, **§4.N's
  M03-N2 row and the two-routes prose that follows §4.N's table**, §6's REQ-005
  and REQ-016 rows, §7's X-4 row, §9's tail and its three-column format.
- `docs/specs/requirements.md` at `a77017c`: §0.5's **Gapped stimulus**, **the
  deciding input word**, **what survives idle injection**, **what a latency
  monitor may demand**; **REQ-016's repaired verification column**; **REQ-005's
  own verification column** (the gapless-stimulus fact the coverage-map removal
  turns on); REQ-011, REQ-015, REQ-103, REQ-104.
- `docs/specs/modules/xgmii_rx_64.md` at `a77017c`: §6.1's **repaired
  consequence-1 scope note** (the named-input-word ground that replaces the
  withdrawn one), the repaired **C-14.4** qualifier, **D(m)**, **the residue
  table**, **item 3's survival case and its no-generalisation instruction**;
  §6.2's `Frame` row; §7's handshake bullet; §10's REQ-016 hook.
- `agents/handoffs/WO-0059_…` — the `COUNTERSIGNATURE` block committed one
  commit ago (its C-1 … C-7 and N-1), and the round-2 `RV-0059-VERDICT` block's
  §3 (the ruling that the stimuli do not move) and §5 (`BUG-0002`).
- `agents/handoffs/BUG-0002_…` — its §2.2 conformant table and §2.3 measured
  facts, for the class M03-I4's `Kills` cell now names.
- `J-dv_lead-0083` (the owed-and-blocked declaration), `J-dv_lead-0084`,
  `J-dv_lead-0072` (the precedent for a plan repair as its own commit).
- **No path under `libs/**`, `top/**`, `bin/**` or `rtl_snapshots/**` was
  opened, targeted or swept. No path under `docs/reports/audit/**`.**

### Reasoning

**The edit I declared owed was two cells. It is four, plus a coverage
reduction, and finding the extra two was the actual work of this commit.**

The ruling withdrew two justifications from SPEC-M03 §6.1 — *"because §7's
per-octet constant does"* and *"the per-octet constant of §7 holds on every
stimulus, gapped or not"*. `J-dv_lead-0083` named the two §4.I cells that assert
the retired claim as an **observable**. What it did not do was ask where else in
my own plan the claim appears as a **ground**, and the answer is a different
family:

- **M03-I4's `Observable`** asserted the constant outright. Replaced by
  REQ-016's two achievable clauses — (a) the ordered
  (`tdata`, `tkeep`, `tlast`, `tuser`) tuple sequence with every octet in its own
  byte position, and (b) the per-output-word delay from **D(m)**, at both start
  lanes — with the constant demoted to *measured and reported*. I named §6.1
  item 3's surviving case (lane 0, `r ∈ {5,6,7}`) in the cell **and explicitly
  barred asserting it**, because a cell that mentions a three-in-eight exception
  without barring generalisation is an invitation rather than a warning.
- **M03-I5's `Observable`** stated the same false claim as a **rule** — *"the
  gap-invariant quantity is the per-octet constant"* — which is worse than
  asserting it, because a NO-ASSERT row is exactly where a later bench writer
  goes to learn what may and may not be asserted. Repaired, and the row's
  NO-ASSERT scope **widens by one**: on an injected run neither `m + 3` nor a
  single per-octet L. The second half is the one that would have failed a
  conformant design; the first half never could.
- **M03-N2's `Observable` and §4.N's Route 2** cite the constant as the
  **ground** for the two-events-in-one-word table surviving injection — *"and it
  is gap-invariant, so the table holds under idle injection as well"*. **This is
  the pair I would have missed had I read only §4.I**, and it is text I wrote at
  `J-dv_lead-0016` on the strength of a spec sentence that has since been
  withdrawn as false. The ground is replaced with §6.1's repaired one: each cycle
  is pinned to a **named input word** and is read at that word's own injected
  position. **The six sub-cases and the three coincidences do not move**,
  because they never rested on the constant — which is exactly what §6.1's own
  repaired note says about itself, and is why this is a ground repair and not a
  row change. Route 2 also stays the route to keep: it is what makes the aborted
  frame's own start lane a discriminator, and `m + 3` does not.
- **§6's REQ-005 row loses M03-I4.** REQ-005's per-octet constancy is defined and
  measured on a **gapless** stimulus — which is precisely why the ruling leaves
  REQ-005 untouched — and M03-I4 no longer asserts a constant at all; it reports
  one. **A reporting row discharges nothing.** Leaving it in the coverage map
  would have claimed coverage this plan does not have, which is the one kind of
  error a coverage map can make that no test run will ever surface. It is a
  coverage **reduction** found by working the consequences of a signature I was
  granting, and that is what a countersignature is supposed to produce.

**M03-I4's `Kills` cell gains the class the row actually caught**, and with it
the fact that matters for anyone reading the row later: **clause (b)'s cycle rule
passed at the failing word.** The arrival guard is not what caught `BUG-0002`;
the tuple guard is. A row asserting cycles alone would have been green on a
design that closes a 60-octet frame on its first word. That is the reason the
repaired `Observable` keeps (a) as a separate assertion instead of folding it
into (b), and I wrote the reason into the cell rather than leaving it to be
re-derived.

**What I deliberately did not do.** No row added, no row converted, no status
moved — **78 rows and 62 ASSERT before and after, counted from the file rather
than reasoned about**. M03-I4 stays **ASSERT**, and it asserts *more* after the
repair than before, not less: clause (a) was always there and clause (b) replaces
a claim that asserted nothing any design could satisfy. I did not touch a single
`Stimulus` cell, because §3 of the round-2 verdict ruled that the sites are the
ones §10 commissions and §6.2's `Frame` row governs; a stimulus edit here would
have been me quietly agreeing with a reading the verdict rejects. And I did not
weaken M03-I4 or M03-I6 to make CI green — that decision belongs to
`J-dv_lead-0084` and is barred twice over.

**On §7's X-4 note**, which I added rather than left alone: the wrapper's first
contact with a DUT produced two results — a falsified docstring and a hardware
bug — and **no behaviour defect in the wrapper itself across two adjudications
that each read it in full**. The last clause is the one worth committing. X-4 is
the only piece of machinery in this plan that has now been audited twice by
someone actively looking for a reason to blame it, and the record should say that
it survived both, so that the third round does not start by re-litigating it.

### Actions
- **Repaired `test/attack_plans/AP-xgmii_rx_64.md`**, seven sites:
  **M03-I4's `Observable`** (replaced with REQ-016's clauses (a) and (b), the
  per-octet constant demoted to reported, §6.1 item 3's survival case named and
  barred from generalisation) and its **`Kills`** (the `BUG-0002` class, with the
  note that clause (b) passed at the failing word); **M03-I5's `Observable`**
  (the gap-invariant quantity restated as the per-output-event delay from D; the
  NO-ASSERT scope widened by one); **M03-N2's `Observable`** and **§4.N's
  Route 2** (the withdrawn ground replaced by the named-input-word one, the
  table's rows and coincidences explicitly unaffected); **§6's REQ-005 row**
  (M03-I4 removed, with the reason); **§7's X-4 note** (the wrapper's first
  contact with a DUT, both results, and the no-behaviour-defect record).
- **Appended one §9 change-log row** carrying the countersignature's seven
  checks in summary, N-1, the four repairs, the coverage reduction, `BUG-0002`,
  and the counts.
- **Converted nothing, added nothing, moved no status.** Counts re-counted from
  the file after the edit.
- Ran no `git` command that writes. Opened no design source.

### Evidence
1. **Counts after the repair, counted from the file, not carried forward**:
   `grep -c '^| \*\*M03-[A-Z0-9]*\*\*'` → **78**; status tally → **62 ASSERT**,
   7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP (sum 78) — byte-for-byte the
   same distribution as at `4901161` before the edit.
2. **Table well-formedness after the edit**: every six-cell row touched carries
   exactly **seven** pipes (M03-I1 … M03-I6 and M03-N2 all checked, not only the
   edited ones); §6's REQ-005 row carries **three**; the appended §9 row carries
   **four**.
3. **The removal from §6's REQ-005 row is sound**: REQ-005's verification column
   is *"per-octet latency tagger inside the REQ-004 stress bench... directed
   lengths 64 through 71 inclusive plus 1518, at both start lanes"* — a gapless
   stimulus, which is why requirements.md §13's own ruling row lists REQ-005
   among the requirements it leaves **untouched**. M03-L2 and M03-L5 remain and
   carry the REQ.
4. **The `Kills` cell's claim that clause (b) passed** is CI's, not mine: at run
   `30881653846` the arrival guard (`test_m03_i.ml:1041`, `:1454`) passed at
   word 0 at both `k = 1` and `k = 7`, and the tuple guard (`:1058–1061`,
   `:1467–1470`) raised.
5. **The M03-N2 ground repair changes no cycle**: §6.1's repaired consequence-1
   note states the same rule on the named-input-word ground and says so in
   terms — *"The rule is unaffected, because it never rested on the constant"* —
   and the row's six sub-cases, three coincidences and W-relative offsets are
   textually unchanged in the cell.
6. **The countersignature this repair rests on** is the `COUNTERSIGNATURE` block
   in `agents/handoffs/WO-0059_…` plus `J-dv_lead-0084`, committed one commit
   earlier; its seven checks and note N-1 are recorded there and are not restated
   here.
7. **Discharge count unchanged**: **36 of 62** at `4901161`, re-derived in
   `J-dv_lead-0084` (37 ASSERT rows named in a committed `%expect_test` title,
   plus M03-F5 by citation, minus M03-I4 and M03-I6 red). **This commit does not
   move it**, because a plan repair discharges nothing.

### Outcome
**The attack-plan edit `J-dv_lead-0083` declared owed-and-blocked is
DISCHARGED** — and it was **four cells plus a coverage reduction**, not the two I
declared: M03-I4's `Observable` and `Kills`, M03-I5's `Observable`, **M03-N2's
`Observable` and §4.N's Route 2** (the retired claim as a *ground*, in a family
the declaration never looked at), and **§6's REQ-005 row**, which loses M03-I4
because a reporting row discharges nothing.

**Counts unchanged: 78 rows, 62 ASSERT**, 7 NO-ASSERT, 4 NO-STIMULUS, 4
STRUCTURAL, 1 GAP. No row added, converted, or moved. **M03-I4 asserts more than
it did**, not less.

`SO-xgmii_rx_64.md` does not issue. Family I's qualification campaign does not
open. The discharge count stays **36 of 62** at `4901161`, forward 38 and blocked
on `BUG-0002`'s fix rather than on any bench work.

Handoff: to the orchestrator — this file for commit, second of the round's two
and with a file set disjoint from the first.

### Open-questions
- **AP-M14 has not been checked for the same defect.** SPEC-M14 is one of the
  three restatements the ruling's §13 row names as owing the same repair (`h` =
  20 straddles), and if its spec carries the retired claim then its attack plan
  may carry it as a ground the way `AP-M03`'s §4.N did. **I have not asked.** It
  rides with AP-M14's already-owed §6 sweep companion, and is named here rather
  than left to be discovered by whoever opens that file next.
- **Whether `AP-M03` carries the claim anywhere I still have not looked** is not
  something this commit can close. I searched §4.I and §4.N and the coverage map;
  a fourth site in a family I did not think to check would be the same miss one
  level down, and the honest statement is that the search was targeted rather
  than exhaustive.
- **M03-I4's repaired `Observable` has been executed as far as word 0 of one
  member.** Clause (a) is what is red; clause (b) is confirmed at exactly two
  words of two runs. Everything else in the cell — lane 4, every length but 64,
  the 1518-octet member, the reported L classes — is still a prediction, and a
  fix that turns word 0 green may reveal a second disagreement further in.
- **Still owed**, unchanged: `RV-0057-VERDICT` Finding 3's total-output-word
  sweep (precondition satisfied); AP-M14's §6 sweep companion, now carrying the
  question above; the `precompile_check.sh` side-effect-in-combinator lane;
  M03-F5's discharge-by-citation qualification; the RFC 1071 anchor on the next
  fetching run; bound 6 (blocked on M03-B4, family B still unqueued); bound 7;
  X-7, X-10, X-11 deferred.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_rx_64.md

## [J-dv_lead-0086] 2026-08-07T13:40Z | task:none | The D(m) re-ruling countersigned on four independent derivations — three granted, and the one refused is refused because the ruling contradicts its OWN residue table one paragraph up, at the other start lane

### Trigger
Orchestrator, scoped re-countersignature round at `1f3c04c`. rtl_lead's
BUG-0002 fix landed at `ce00c06` and CI validated it exactly as its return
predicted (run **30895770553**: only M03-I4 and M03-I6 red, only at word 7,
18 against 19; all 34 other units green). rtl_lead's E5 escalation proved my own
`RV-0059` §8 D(m) rule's non-`tlast` case unsatisfiable by causality, and the
architect re-ruled D(m) at `1f3c04c` (`J-architect_docs_lead-0025`): a new
output-word bullet and a causality test in requirements.md §0.5, a new D(m) block
in SPEC-M03 §6.1. My `d39ffb6` signature is neither withdrawn nor inherited —
five of its seven checks stand, C-2's residue-survival conclusion is superseded —
and a **new, narrow** signature is owed on exactly four points: the two
refutations, `k = 0` invariance, the carve-out withdrawal and inverted class
table, and the new I4/I6 pinned cycles. Sign or refuse each separately; any
numeric disagreement returns as a finding with its numbers.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3 packets, §4 grammar,
  §6 scope, §10 R-SEAL-1 and the independence rules).
- `docs/specs/requirements.md` at `1f3c04c` — §0.5 whole, and specifically **The
  deciding input word (normative)** with its new output-word bullet, **The test a
  specification's D must pass (normative)**, **What survives idle injection**,
  the *why L does not survive* pair of tests, and the new
  `J-architect_docs_lead-0025` paragraph; REQ-016; REQ-005, REQ-011, REQ-015,
  REQ-103, REQ-107; §0.6's window paragraphs; §1.1's `h` column; §13's
  countersignature rows for `ebb3f49`, `0caf023` and `a77017c`.
- `docs/specs/modules/xgmii_rx_64.md` at `1f3c04c` — §6.1 whole (the new D(m)
  block, the refutation paragraph, the two consequences, derivations 1–3 with
  the withdrawn carve-out, the preamble/octet-time geometry, the 64-octet table,
  the drain derivation), §8's directed set and stress obligation, §9, §10's
  REQ-016 / REQ-005 / REQ-107 hooks.
- `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`
  whole, including rtl_lead's Root-cause, fix and *What the fix does not repair*
  escalation.
- `agents/handoffs/WO-0059_tb-m03-family-i-silence-and-ordered-sets.md` — the
  `d39ffb6` COUNTERSIGNATURE block (C-1 … C-7 and N-1), re-read to fix exactly
  what my earlier signature did and did not certify.
- `test/attack_plans/AP-xgmii_rx_64.md` — M03-I4, M03-I5, M03-I6, M03-N2 and
  §4.N's Route 2, plus the `J-dv_lead-0085` change-log row.
- `test/xgmii_rx_64/test_m03_i.ml` — `dependency_source_cycle` (`:922`),
  `injected_word_cycle` (`:926`), the four call sites (`:1015`, `:1039`,
  `:1432`, `:1452`), the delay-identity block (`:1084–1115`), the per-octet
  reporting block (`:1119–1196`), the module docstring (`:1–140`). **This is a
  test file I own, not RTL.**
- **No RTL read this round or any round of this packet.** Every statement below
  about what the design does is taken from rtl_lead's own returned tables in this
  packet or from CI run 30895770553's published result, and is labelled as such.

### Reasoning
The instruction was to re-derive rather than verify prose, so I rebuilt M03's
octet-time geometry from §6.1's own preamble paragraph and §0.5's octet-time
definition — received octet `j` at octet time `8s + ℓ + 8 + j`, closing character
at `8s + ℓ + 8 + N`, uniform injection `g(c) = c + k·max(0, min(c,T) − f)` with
sites at the boundaries before cycles `f+1 … T` — instantiated the new D(m) on
it, and read the four points off the result. I validated the geometry **before**
trusting it, against constants the ruling does not touch: at `k = 0` it returns a
single per-octet `L` of 16 at lane 0 and 12 at lane 4 over `N = 5 … 199`, which is
§7's pinned pair, and it reproduces `m + 3` identically.

**Two things fell out of the geometry that made three of the four points cheap,
and they are the reason this entry is not four separate arguments.** First, `N ≥
8m+13 ⟺ m < W−1` exactly, so the new rule's (a)/(b) split *is* the
non-`tlast`/`tlast` split — not a stipulation but an identity, which means the
`tlast` bullet is untouched and point 2's second half needs no sweep at all. It
also means the bench's existing `m = words - 1` branch is already the right
branch and only the octet index inside it moves. Second, `c(N−5) = T` — the last
delivered octet sharing the closing character's own word — holds iff `r ∈ {5,6,7}`
at lane 0 and `r ∈ {1,2,3}` at lane 4, and those are exactly the complements of
§6.1 derivation 1's own "terminate later" sets, the table I re-derived
independently at C-1 of `d39ffb6` and which this ruling leaves standing. That
second fact is what produced the refusal.

**Point 1 (refutations) — granted, and I refused to settle for checking two
examples.** Both worked by hand and both hold: 64/69 at lane 0, `k = 7` collide at
cycle 60 with the lines agreeing through 65, and 64/12 collide at cycle 4 with the
lines agreeing through 9. But two witnesses do not tell you whether the *new* rule
is causal, only that the old one is not — so I swept the causality test itself:
every pair of lengths `N ∈ [5,80]`, `k ∈ {0,1,7}`, both lanes, comparing the two
rules' pinned tuples at every cycle through the last one on which the two injected
lines agree. The new D(m) violates **nothing** in 17 100 pair-runs; the replaced
rule violates 1 620 times at lane 0 (all at `k = 7`) and 648 at lane 4 (`k = 1`
and `k = 7`, 324 each). That converts the signature from "the architect's two
examples check out" into "the rule passes the test the architect made normative,
over the space I could sweep" — which is what a countersignature should be worth,
and it cost one script.

Two precisions I insisted on rather than let ride. The 64/69 pair carries **no
FCS side-condition**: making the lines identical forces the 69-octet frame's
octets 60–63 to equal the other frame's FCS, but those are payload for it and its
own FCS at 65–68 is free, so **both frames can carry correct FCSs simultaneously**
and no `tuser` confound enters. And 1b's 12-octet frame is **not** in a
commissioned set — REQ-107's row commissions 5, 16, 60 and 63 — where 1a's 64 and
69 both are, in §8's directed 64…71. The refutation is sound either way (§0.5's
test ranges over legal stimuli, and a 12-octet runt is one), but the packet must
not be read as claiming an in-set collision it does not have. Any `N ∈ [8,12]`
serves; 12 is the best because it makes the two frames' word 0 tuple-identical, so
the collision is purely in the cycle.

**And I withdrew my own §2.3.** BUG-0002 recorded word 0's measured cycle 4 as the
first hardware confirmation of §6.1's D(m). Under the ruled D(m) the conformant
value is 5 at `k = 1` and 11 at `k = 7`; 4 is conformant at neither, and the design
reached it through `emit_last_a`'s emptiness test — the very defect the packet
convicted. The general lesson, which I would rather write against myself than have
the auditor write: **a guard passing is not evidence for the rule it encodes when
the design under it is already known to compute that guard's quantity by the wrong
mechanism.** An emptiness test and an evidence test agree on a gapless line and
only there, and the whole point of family I is that it is not a gapless line.

**Point 2 (`k = 0` invariance) — granted, and the honest form of it is that it is
an identity, not a coincidence.** At `k = 0`, `g` is the identity, so
`emit(m) = s+m+3` for every `m` by construction. The real content is that D(m)
exists and never lies *after* the word it decides, i.e. that every offset is
non-negative — and the offset table is `{1}` for (a) and `{1,2}` for (b) at lane 0,
`{0}` and `{0,1}` at lane 4, all of them `≥ 0`, all of them exactly §6.1's own four
numbers, recovered rather than read. The lane-4 zeros are legal precisely because
§0.5's test permits the same cycle. Mechanically: 0 deviations over `N = 5…199`
at both lanes at `k = 0`, and 0 of 6 630 frames move their `tlast` word over
`k = 0…16`. The consequence worth stating is the ruling's blast radius: every
gapless cycle this programme ever pinned, and every `tlast` word on every injected
run already driven, is untouched. What moves is exactly the non-`tlast` words of
an injected run.

**Point 3 (class table) — granted in part, refused in part, and this is the
round's real output.** The lane-0 half reproduces exactly, inversion and all:
`r ∈ {0…4} → {16+8k}` where the withdrawn item predicted two classes, and
`r ∈ {5,6,7} → {16, 16+8k}` where it promised one. The carve-out withdrawal is
right and C-2's arithmetic survives intact inside it — those one, two and three
octets *do* still measure 16; what died is the inference that the frame therefore
has one class, because the other words no longer measure 16 either.

The lane-4 cell is wrong, and it is wrong in a way the ruling could have caught
against its own text. §6.1 item 2 is headed *"**Every** output word, at a lane-4
start"* and gives `L+16k` / `L+8k`. That is exact for the non-`tlast` words and
for the `tlast` word at `r = 4` **only**. At `r ∈ {1,2,3}` the `tlast` word's bytes
4 … r+3 sit in the closing character's own input word, so no injected idle
separates them from their evidence and they measure **12** flat — a **third**
class, `{12, 12+8k, 12+16k}`, which is `{12,20,28}` at `k = 1` and `{12,68,124}` at
`k = 7`. At `r = 0` and `r ∈ {5,6,7}` the `tlast` word has no bytes above 3 and its
bytes 0–3 measure `12+8k` rather than `12+16k`, so the set is unchanged but the
per-word description is still wrong. **The ruling preserved exactly this reasoning
at lane 0 and dropped it at lane 4, where its own derivation-1 residue table names
the mirror set** — `{1,2,3}` is the complement of `{0,4,5,6,7}` just as `{5,6,7}`
is the complement of `{0,1,2,3,4}`. So the two halves of the ruling are
inconsistent with each other, not merely incomplete, and that is the sharpest form
I could put the finding in.

I weighed returning it as a non-blocking note in the style of `d39ffb6`'s N-1 and
rejected that: N-1 was a gate that licensed nothing at M03, where this is a false
statement in a normative section that **the next CI run will contradict in printed
output**. §8's directed lengths are 64…71, so lane-4 `r ∈ {1,2,3}` is lengths 65,
66 and 67 — three of the sixteen (length, lane) members M03-I4 already drives, at
both `k = 1` and `k = 7`, and the bench *reports* these classes. A reader, or a
later bench built from item 2, would read a conformant design as divergent.
Nothing fails today (§0.5 forbids asserting a per-octet constant here and M03-I4
does not assert one, so it cannot fail a conformant design and blocks nothing) —
but "cannot fail a design" is not a reason to leave a normative sentence false. I
offered a repair that costs one paragraph and moves no rule, no cycle and no
design, and stated that I hold no position beyond offering it.

**Point 4 (I4/I6 cycles) — granted, on three internal checks rather than on
arithmetic agreement alone.** `emit(m) = m+4+k(m+1)` for `m ≤ 6` and `11+8k` for
`m = 7` gives 5,7,9,11,13,15,17,19 at `k = 1` and 11,19,27,35,43,51,59,67 at
`k = 7`, `FF×7` then `0F`, `tlast` on word 7 only, `tuser` 0 throughout — the
architect's rows to the cycle. The checks: the `k = 7` row's 67 is the same 67
refutation 1a computes from the other side and nothing sits at 60, so points 1 and
4 are consistent; the spacing is uniform at `k+1` including the step to word 7,
which is *why* `r = 0` is the one-class residue in point 3, so points 3 and 4 are
consistent; and **REQ-019's two-word bound holds at these cycles** — at `k = 7`
word `m`'s octets complete at `8m+2`, it leaves at `8m+11`, and word `m+1`'s
octets complete at `8m+10`, so exactly two words are resident and never three.
§6.1 asserts that bound at every `k` and this is the stimulus most likely to break
it; it does not break.

**On editing the attack plan, which I did not do.** Two of my own AP cells are now
false — M03-I4's `Observable` names the superseded D(m) as the thing the bench
asserts and cites the withdrawn carve-out as live; M03-N2's `Observable` names the
wrong pinned word and carries the "moves earlier, never onto it" clause the ruling
withdraws in terms; §4.N's Route 2 needs its injected reading re-based to `W`. The
round's own predecessor settles the sequencing: at `d39ffb6` the signature commit
touched no plan and the repair landed at `b2a3b95` *after* transcription — "the AP
repair the countersignature licenses". A ruling not yet in force does not license a
repair, so I declared all three loudly in the packet with their replacement text
fixed, making the repair clerical, and left the file untouched. No row is added,
converted or re-statused by any of the three and the plan's counts do not move.

**Why the packet carries a prediction about the next CI run.** The bench repair
**widens** the red set before it narrows it: word 0's pin moves by exactly `k`
cycles at both lanes and every directed length, and the design emits a word as
soon as its octets are complete, so 36 units go red — M03-I4's 32 injected members
at `k ∈ {1,7}` and all 4 of M03-I6's — all at **word 0**, with
`expected − observed = k`, while all 16 `k = 0` members stay green. That is the
correct direction (ADR-0015 D2: never amend an expectation to agree), but a
red count going 2 → 36 is exactly the kind of surprise that gets a bench blamed
for a design's gap, so it is written down before the run, falsifiably: a green
`k ≥ 1` unit, a first failure at a word other than 0, or a delta other than `k`
means the bench repair is wrong and not the design.

### Actions
- Read the four artefacts above; rebuilt M03's octet-time geometry from the
  specification and instantiated the new D(m) on it; derived all four points
  independently.
- Ran three ephemeral scratchpad derivations (not committed, ADR-0003/F5): the
  offset/invariance sweep over `N = 5…199` × both lanes × `k = 0…16`; the
  per-octet class tables by residue at both lanes at `k ∈ {1,7}`; and the
  causality-test sweep over all length pairs `N ∈ [5,80]` × `k ∈ {0,1,7}` ×
  both lanes, for both the new and the replaced rule.
- Appended the COUNTERSIGNATURE block to
  `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md`:
  points 1, 2 and 4 GRANTED, point 3 GRANTED IN PART with **FINDING F-1**; the
  standing of `d39ffb6` restated (five checks stand, C-1 load-bearing, C-2
  superseded); BUG-0002 §2.3's "first confirmation" claim withdrawn by its own
  author; the three false AP sites declared with replacement text; the 36-unit
  red-set prediction stated in the open.
- Wrote **no** file under `test/**`, `libs/**` or `docs/**`; ran **no** git
  command; opened **no** RTL.

### Evidence
Everything below is arithmetic on the specification and reproduces by hand from
the closed forms in the packet's §C-0. The scratchpad scripts are **ephemeral and
uncommitted** (ADR-0003/F5) and are not offered as evidence; the numbers are.

- **Geometry validated against frozen constants before use**: at `k = 0` the model
  returns a single per-octet `L` of **16** at lane 0 and **12** at lane 4 over
  `N = 5…199` — §7's pinned pair — and reproduces `m + 3` identically.
- **Point 2**: 0 deviations from `s+m+3` at `k = 0` over `N = 5…199` at both
  lanes; observed offset sets `{1}` (a) / `{1,2}` (b) at lane 0 and `{0}` /
  `{0,1}` at lane 4, matching §6.1's four numbers; **0 of 6 630** frames move
  their `tlast` word over `N = 5…199` × both lanes × `k = 0…16`.
- **Point 1**: causality violations over all pairs `N ∈ [5,80]` × `k ∈ {0,1,7}` ×
  both lanes — **new D(m): 0 and 0**; replaced rule: **1 620** (lane 0, all
  `k = 7`) and **648** (lane 4, `k = 1` and `k = 7`, 324 each). The two named
  witnesses appear at exactly the stated numbers: `(64,69)` lane 0 `k = 7`
  violating at cycle **60**, lines agreeing through **65**; `(12,64)` lane 0
  `k = 7` violating at cycle **4**, lines agreeing through **9**.
- **Point 3**: lane 0 by residue at `k = 1` → `{24}` for `r ∈ {0…4}` and
  `{16,24}` for `r ∈ {5,6,7}`; at `k = 7` → `{72}` and `{16,72}`. Lane 4 at
  `k = 1` → `{20,28}` for `r ∈ {0,4,5,6,7}` and **`{12,20,28}`** for
  `r ∈ {1,2,3}`; at `k = 7` → `{68,124}` and **`{12,68,124}`**. Over
  `N = 13…199`, no exceptions in either lane.
- **Point 4**: `(64, lane 0, k = 1)` → 5, 7, 9, 11, 13, 15, 17, 19;
  `(64, lane 0, k = 7)` → 11, 19, 27, 35, 43, 51, 59, 67; `tkeep` `FF`×7 then
  `0F`; `tlast` word 7 only; D kinds `a`×7 then `b`; offsets all 1.
- **Cited, not re-run**: CI run **30895770553** at `ce00c06` (only M03-I4 and
  M03-I6 red, at word 7, 18 against 19; 34 other units green) — the externally
  verifiable reference this round's premise rests on, per PROTOCOL §4.1(b).

### Outcome
DoD met for the round as scoped. Four points adjudicated separately: **1, 2 and 4
GRANTED; 3 GRANTED IN PART**, with the lane-4 class cell REFUSED as numerically
incomplete and returned as **FINDING F-1** with its numbers and an offered repair.
Signature of record: the COUNTERSIGNATURE block in
`agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md` plus
this entry. **The diff is not in force until the orchestrator transcribes the
signature into requirements.md §13.** The **Fix verdict** section of BUG-0002
stays open and `ce00c06` is not accepted: the bench that would re-test it asserts
a superseded D(m), so the verdict is owed after the bench round and the RTL round
after it. `SO-xgmii_rx_64.md` remains unopened; family I's discharge count stands
at **36 of 62**, unchanged.

### Open-questions
- **F-1 is with architect_docs_lead**: SPEC-M03 §6.1 item 2's "every output word"
  is false for the `tlast` word at seven of eight lane-4 residues and produces a
  third latency class at `r ∈ {1,2,3}` — observable in printed output at directed
  lengths 65, 66 and 67 on the next run. Non-blocking, cannot fail a conformant
  design, offered repair costs one paragraph.
- **The AP repair is owed in the next commit of this round** (M03-I4's and
  M03-N2's `Observable`, §4.N's Route 2), licensed by transcription and not by
  this signature — the `J-dv_lead-0084` → `J-dv_lead-0085` sequencing, repeated.
  The tb_writer work order SHALL NOT issue before it lands.
- **Sequencing question for the orchestrator, not a decision of mine**: the bench
  repair takes the red count from 2 to 36 until rtl_lead's elastic-emission round
  lands. I recommend bench-first (the bench states the requirement; the design
  meets it) and have stated the predicted red set falsifiably, but the ordering is
  the orchestrator's call.
- `d39ffb6`'s **N-1** still rides unanswered — REQ-016's verification column gates
  the per-octet assertion per **module** while survival is per (start lane,
  residue). This round strengthens it: point 3 now shows the class count varying
  by residue at **both** lanes, not one.

### Files-in-this-commit
- agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md

## [J-dv_lead-0087] 2026-08-07T15:05Z | task:none | The AP repair the transcription licenses — three sites, all clerical because the replacement text was fixed before this commit existed, and the plan absorbs a live spec dispute without a status change because the values it carries are reported and not asserted

### Trigger
Orchestrator: my `J-dv_lead-0086` signature is transcribed at `155c9b2` and the
re-ruled D(m) is **IN FORCE**; **FINDING F-1** is recorded outstanding against
SPEC-M03 §6.1 item 2's lane-4 cell, with the architect on it in a parallel
SPEC-M03-only round. Land escalation 2 of that return — the clerical repair of
the three attack-plan sites the countersignature declared FALSE — because the
tb_writer work order is waiting on my own stated precondition that it SHALL NOT
issue before this lands.

### Inputs
- `agents/handoffs/BUG-0002_m03-idle-injection-tlast-on-a-non-final-word.md` at
  `a8ca14d` — my own COUNTERSIGNATURE block, specifically the section *"Two of my
  own attack-plan cells are now FALSE"*, which fixes the replacement text for all
  three sites.
- `docs/specs/requirements.md` §13 at `155c9b2` — the transcription row
  (`J-orchestrator-0167`), read to confirm the ruling is in force and to confirm
  F-1 is recorded as outstanding rather than resolved.
- `docs/specs/modules/xgmii_rx_64.md` §6.1 at `1f3c04c` — the D(m) block, the
  aborted-frame scope note (*"that named word is W in every row of the table"*)
  and the withdrawn "moves earlier" clause, quoted into the repair.
- `test/attack_plans/AP-xgmii_rx_64.md` at `155c9b2` — M03-I4, M03-N2, §4.N's
  Route 2, and §9's change log; the status counts re-counted from the file.
- My own `J-dv_lead-0084` → `J-dv_lead-0085` sequencing, re-read as the
  precedent this round deliberately repeats.
- **No RTL, this round or any round of this packet.**

### Reasoning
There was one judgement to make and I had already made it last round: **a ruling
not yet in force does not license a repair.** That is why the signature commit
(`a8ca14d`) touched no plan and why this one does — the same shape as `d39ffb6`
→ `b2a3b95`, where the change-log row's own words were *"the AP repair the
countersignature licenses"*. Doing it in this order costs one commit and buys the
property that no cell of this plan ever cites a rule that was not in force when
the cell was written, which is a property an auditor can check by commit ordering
and cannot check any other way.

The repair itself is **clerical by construction and I built it that way on
purpose**: every replacement sentence was fixed in the COUNTERSIGNATURE block
*before* this commit existed, so this commit installs text rather than deciding
it. That is the difference between a repair and a second ruling, and it matters
here because the thing being repaired is a contract the next work order is
written against — a worker reading M03-I4's `Observable` would otherwise have
been handed the superseded D(m) as the thing the bench asserts.

**Site 1, M03-I4's `Observable`, is the one that actually mattered.** It named D
as *the input word carrying output word m's last octet* for every non-`tlast`
word — this plan's own restatement of the rule rtl_lead refuted. I replaced it
with the ruled D(m) and, rather than assert the branch, **derived** it:
`N ≥ 8m + 13 ⟺ m < W − 1` exactly, so evidence-first and `tlast`-first name the
same partition and the (b) bullet is untouched. I wrote the consequence a reader
of this plan most needs — **no `tlast` word's cycle moves at any `k`, no gapless
cycle moves at all** — because without it the repair reads as if family I's whole
expectation set had been rebuilt, and it has not: the `k = 0` members and every
other family are exactly where they were. I also recorded, in the cell, that
the ruling's new sentence *"a word whose D(m) has not arrived is not emitted"*
owes **no new guard**, and why: the word-count guard and the per-word cycle guard
cover it **as a pair** and neither alone does. That is there to stop a worker
inventing a third guard for a property two existing guards already close, which
is the failure mode this plan has hit before in the other direction.

**The carve-out sentence was the subtler half of site 1.** The cell said §6.1
item 3's lane-0 `r ∈ {5,6,7}` case survives with one class and that this row does
not generalise from it. Under the ruled D(m) that case has **two** classes — the
`tlast` octets still measure 16, but every earlier word now measures `16 + 8k` —
so the sentence was false in its premise even though its instruction (*do not
generalise*) was right. I replaced it with the full reported class tables at both
lanes, **including F-1's three-class lane-4 cell**, and stated in the cell itself
that all of it is REPORTED and none ASSERTED.

**That last point is why this plan can carry a live spec dispute without a status
change, and it is worth naming as a property rather than a coincidence.** F-1 is
outstanding against §6.1 item 2 and the architect may resolve it either way. If
the plan *asserted* those classes, F-1's resolution would move a row and the
plan's counts would depend on an open dispute. Because the `J-dv_lead-0085`
repair demoted the per-octet constant to reported data, **F-1 moves nothing here
in either direction** — and lengths 65, 66 and 67 at a lane-4 start will print
the third class into a promoted expect block whichever way the architect rules.
A plan that reports where the specification is unsettled and asserts only where
it is settled absorbs a dispute; one that asserts everywhere has to be reopened
every time a ruling moves. I recorded that in the change-log row because it is
the reusable part.

**Sites 2 and 3 are the same error at two removes and both were mine.** M03-N2's
`Observable` named the wrong pinned word ("W itself, or the word carrying the
aborted frame's last octet") and carried the clause that idle injection moves the
two lane-0-`/S/` reports *earlier, further from the new frame's and never onto
it* — both withdrawn in terms at `1f3c04c`. The replacement reads every row at
**W**, so both reports now move **together** and the coincidence column is
unchanged at every `k` on the offsets alone (`W + 1` against `W + 2`). §4.N's
Route 2 is the derivation underneath that cell and needed the same re-basing.

**On Route 2 I checked rather than assumed, because the tempting repair is
wrong.** Route 2's `U + ⌊(k + L)/8⌋` looks like it needs replacing, since `U` is
the octet's own input word and that is the superseded D. It does not: the formula
is a **gapless** derivation of the *offset*, and gapless the two readings
coincide — a lane-0 `/S/` leaves the aborted frame's last octet at lane 7 of
`W − 1`, so `U + 2 = W + 1`, which is W's own `+ 1`. So the formula, the six rows
and the three coincidences all stand, and what is re-based is **only which word
the offset is read from on an injected line**. Had I replaced the formula I would
have destroyed the one thing Route 2 exists for — it is what makes the aborted
frame's own start lane a discriminator, which `m + 3` does not — and I would have
had to re-derive six rows that never moved.

**Counts re-counted from the file rather than carried forward**, per this plan's
own discipline: 78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL,
1 GAP, summing to 78. No row added, converted or re-statused — the repair is
three `Observable`/derivation cells and one appended change-log row.

**One residual phrase is deliberate.** The withdrawn parenthesis and the
withdrawn "moves earlier" clause are **quoted inside their own replacements**, so
a reader meeting the old wording elsewhere in the programme's history can find
where it died. Quoting a claim in order to convict it is not restating it —
PROTOCOL §10's own note on the point — and a repair that silently deletes the
text it replaces makes the diff the only record of what was wrong.

### Actions
- Edited `test/attack_plans/AP-xgmii_rx_64.md` at exactly three sites plus one
  appended change-log row:
  1. **M03-I4** — `Attacks` cell re-cited (`a77017c`, re-ruled at `1f3c04c`);
     `Observable` clause (b) rewritten to the ruled D(m) with the branch
     equivalence derived, the refutation and sweep numbers recorded, the
     no-early-emission half attributed to the count/cycle guard **pair**; the
     carve-out sentence replaced by the withdrawal plus the reported class
     tables at both lanes, F-1 named and marked outstanding.
  2. **M03-N2** — `Observable`'s named word re-based to **W in every row**, with
     the superseded alternative quoted as withdrawn; the "moves earlier" clause
     replaced by "moves BOTH reports TOGETHER", the coincidence column now
     resting on the offsets alone.
  3. **§4.N Route 2** — re-based to **W**, with the formula, the six rows and the
     three coincidences explicitly stated as unmoved and the gapless coincidence
     `U + 2 = W + 1` worked in place.
  4. **§9 change log** — one appended row, `J-dv_lead-0087`.
- Re-counted every status class from the file after the edit.
- Ran **no** git command. Touched **no** file under `libs/**`, `docs/**`,
  `agents/handoffs/**` or the rest of `test/**`.

### Evidence
- `git status --porcelain` at this working tree shows **three** modified paths:
  `test/attack_plans/AP-xgmii_rx_64.md` and this journal, which are mine, **and
  `docs/specs/modules/xgmii_rx_64.md`, which is NOT** — it is the architect's
  concurrent F-1 round landing in the same working tree. It is outside dv_lead's
  write scope (PROTOCOL §6), it is absent from this entry's
  `Files-in-this-commit`, and R7 would refuse it from a dv_lead commit in any
  case; **the orchestrator SHALL stage my two paths explicitly and never
  `git add -A` this tree.** Flagged rather than silently ignored, because a
  files-list that set-equals the commit only proves what was staged, not what was
  in the tree when it was staged.
- **The architect's parallel repair, read from that uncommitted diff, accepts F-1
  in full and agrees with my derivation cell for cell** — `r = 0` → `L + 8k`;
  `r ∈ {1,2,3}` → `L + 8k` on bytes 0–3 and **`L`** on bytes 4 … r+3;
  `r = 4` → the 28/20 split; `r ∈ {5,6,7}` → `L + 8k`; class sets `{12, 20, 28}`
  at `k = 1` and `{12, 68, 124}` at `k = 7`, at lane-4 lengths 65, 66 and 67. It
  reaches the mirror-of-lane-0 argument independently (*"which is why both items
  state it or neither is right"*). I record the agreement as an observation on an
  **uncommitted** working-tree diff, not as evidence of a committed state, and I
  countersign nothing of it here — that round is the architect's and its
  signature, if one is owed, is a later unit of work.
- Status counts re-counted from the repaired file (`grep -c '| <STATUS> |$'`):
  **ASSERT 62, NO-ASSERT 7, NO-STIMULUS 4, STRUCTURAL 4, GAP 1**; row count
  (`grep -cE '^\| \*\*M03-'`) = **78**; 62 + 7 + 4 + 4 + 1 = 78. Identical to the
  counts at `155c9b2`.
- Residual-text check: a grep for the four superseded phrasings returns **one**
  hit, at line 362, and it is the deliberate quotation inside M03-N2's own
  withdrawal (*"The parenthesis this replaces read … the second alternative is
  the superseded D and is withdrawn"*). No live cell states a superseded rule.
- The replacement text is byte-comparable against its source: every sentence
  installed here appears in the COUNTERSIGNATURE block at `a8ca14d`, which is
  earlier in history than this commit — the ordering an auditor can check.
- **Cited, not re-run**: the four derivations this repair installs are
  `J-dv_lead-0086`'s (causality sweep 2 268 vs 0; `k = 0` invariance 0 deviations
  over N = 5…199 and 0 of 6 630 `tlast` words moving over `k = 0…16`; the class
  tables; the I4/I6 cycles 5,7,…,19 and 11,19,…,67). Nothing new was derived this
  round — that is what makes it clerical.

### Outcome
DoD met. Escalation 2 of `J-dv_lead-0086` is discharged: the three FALSE sites
are repaired, no row added, converted or re-statused, counts unmoved at
78/62/7/4/4/1. **My own precondition is satisfied and the tb_writer work order is
UNBLOCKED** — the `Context provided` section may now quote M03-I4's and M03-N2's
`Observable` cells and §4.N's Route 2 as they stand at this commit. The bench
instruction returned with `J-dv_lead-0086` is unchanged by this repair, including
change 5(b), which already insulates the worker from §6.1 item 2's disputed
lane-4 cell by forbidding an expected class set to be written from it. BUG-0002's
`Fix verdict` stays open and `ce00c06` is still not accepted; family-I discharge
stands at **36 of 62**, unchanged.

### Open-questions
- **F-1 remains with architect_docs_lead** (parallel SPEC-M03-only round).
  It moves no row of this plan in either direction, because every value it
  touches is reported and none is asserted. When it is ruled, this plan's §9
  gains a one-line row recording the outcome and nothing else moves.
- **The tb_writer WO is mine to draft next** — one file
  (`test/xgmii_rx_64/test_m03_i.ml`), seven changes, the two `+ 12` derivations
  kept independent so a defect in the translator cannot validate itself, and the
  36-unit red-set prediction stated in the WO before the run.
- **Sequencing remains the orchestrator's**: the bench repair takes the red count
  from 2 to 36 until rtl_lead's elastic-emission round lands. My recommendation is
  unchanged — bench first, prediction stated in advance so a surprise cannot be
  mistaken for a bench defect.
- `d39ffb6`'s **N-1** still rides unanswered, and this round leaves it where it
  was: REQ-016's column gates per module while survival is per (start lane,
  residue), which point 3 of `J-dv_lead-0086` showed varies at **both** lanes.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_rx_64.md
