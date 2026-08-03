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
