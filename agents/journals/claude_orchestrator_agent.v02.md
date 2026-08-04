# Journal: claude_orchestrator_agent — volume 02

- **Agent**: orchestrator (Fable 5 session, sole spawner and sole committer)
- **Charter**: agents/charters/orchestrator.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 02
- **Continues-from**: J-orchestrator-0146
- **Previous-volume**: agents/journals/claude_orchestrator_agent.md
- **Previous-volume-sha256**: 9b9ee0b3761560984dd82b85567cc9fdeeddb370d0515cf200706058e645d277
- **Previous-volume-bytes**: 279351

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Volume 02 of a chain (ADR-0017 §4.3).
Enforced by scripts/agent_commit.sh and CI.

---

## [J-orchestrator-0147] 2026-08-03T22:30:00Z | task:WO-0053 | Volume 02 opens - the rotation, and the chain's first real proof

### Trigger
Volume 01 crossed the advisory threshold (279 KiB > 256 KiB);
with the chain live and quiet, rotating voluntarily rather than
riding the warning to the ceiling.

### Inputs
Volume 01 at HEAD (sha256 and byte count in this volume's header,
computed from the committed object per the dv_lead rotation's
practice); ADR-0017 §4.3 mechanics.

### Reasoning
- dv_lead's forced rotation landed at 4168962 - the ADR's §5.2
  prediction (exactly one forced rotation) held through landing.
- Case (h) executed on the repository's first real chain, per
  dv's passed-back item: verify_journal_chain.sh GREEN over the
  true tree (dv_lead - 2 volumes, 73 entries); then, in a
  disposable worktree copy, ONE byte flipped mid-file in the
  frozen 1.1 MB volume turned the verifier RED naming the exact
  property (Previous-volume-sha256 mismatch: expected 47d2ffbe...,
  found f127b387...). The mechanism - not merely its mechanics -
  is proven: a frozen volume cannot be altered without the chain
  saying so, from a bare checkout, no history required.
- dv's §6.5 caveat stands restated: this new volume is now the
  uncertified active one; its protection is R3 and history.

### Actions
This volume created with computed header fields; the rotation
commit stages this file only; volume 01 untouched and frozen at
146 entries.

### Evidence
The case-(h) transcript in the session record; the header fields
above, recomputed after writing.

### Outcome / DoD
The orchestrator chain is two volumes; two of three warned
journals are rotated. architect_docs_lead (423 KiB, under H)
rotates at its next natural round.

### Open-questions
None.

### Files-in-this-commit
- (none)

## [J-orchestrator-0148] 2026-08-03T23:05:00Z | task:none | The backlog ledger told the truth again - a single-word assumption retired

### Trigger
Sponsor deployed the site and reported WO-0038 as the newest work
order on the live backlog.

### Inputs
build.py's wo_rows regex: the State capture was (\w+) — a single
word — matching only the early rows' bare ACCEPTED. Every row
since WO-0039 carries a compound state ("CLOSED · 8/8") and was
silently dropped. The build line's "38 WOs" announced the bug on
every run and was read as a fact instead of re-derived — the
provenance lesson in the flesh, again, on my own tooling.

### Reasoning
- State capture widened to free text; the id accepts link and
  bare forms (some rows deliberately have no packet file); the
  status chip's CSS class keys on the state's first word.
- The page's "what happens next" list had also fossilized
  (naming work finished days ago) — refreshed to the current
  truth: the WO-0056 repair + replay, family H onward, SO-M03,
  the M06-M09 wave, the last pending journal rotation.
- Rebuilt in a HEAD worktree (dv's WO-0056 review is mid-flight
  in the tree); ledger verified: 51 rows, newest WO-0055, oldest
  WO-0001.

### Actions
build.py fixes; clean rebuild; this commit; push.

### Evidence
The rebuilt page's row extraction printed in the session record.

### Outcome / DoD
The live backlog will show the full ledger on the sponsor's next
deploy.

### Open-questions
None.

### Files-in-this-commit
- site/build.py
- site/public/backlog.html
- site/public/block-diagram.html
- site/public/index.html
- site/public/org-chart.html
- site/public/spec-atlas.html

## [J-orchestrator-0149] 2026-08-03T23:30:00Z | task:none | Every work order now has a board row - the ledger is the full record

### Trigger
Sponsor: the heading said 51 while the true count is higher.

### Inputs
Board sweep vs the allocated id space WO-0001..WO-0056: six ids
had no row — WO-0042 (folded into a shared WO-0041/42 row),
WO-0044 (a real packet round never rowed), and WO-0048/0052/0053
(dispatch-only rounds whose records lived in journals alone),
plus the in-flight WO-0056.

### Reasoning
- Every allocated id now has its own row, each written from its
  round's actual record: WO-0042 split out of the shared row
  (retitled WO-0041); WO-0044 (the co-sim lane's opening
  questions); WO-0048 (the REQ-901 cascade, dispatch-only, noted
  as such); WO-0052 (the ADR-0017 acceptance + override
  retirement); WO-0053 (the chain landing + rotations + case h);
  WO-0056 (ACCEPTED · LANDING, with the replay condition).
- The heading now counts DISTINCT ids (56), not raw rows (57 —
  the WO-0046 run-1 record row is a deliberate duplicate id and
  stays).
- Standing practice adopted: a work-order id gets its board row
  at ALLOCATION (dispatch-only rounds included), not only at a
  packet landing — the gap existed because dispatch-only rounds
  had no landing moment to trigger a row.

### Actions
Six rows inserted in id order; heading fix; clean-worktree
rebuild; this commit; push.

### Evidence
Rebuilt page: heading 56, rows 57, distinct 56, newest WO-0056;
board sweep shows zero missing ids.

### Outcome / DoD
"Every work order ever issued" is now literally true on the page.

### Open questions
None.

### Files-in-this-commit
- site/build.py
- site/public/backlog.html
- site/public/block-diagram.html
- site/public/index.html
- site/public/org-chart.html
- site/public/spec-atlas.html
- tasks/BOARD.md

## [J-orchestrator-0150] 2026-08-03T23:55:00Z | task:none | Cadence caption simplified to the sponsor's wording

### Trigger
Sponsor: not a fan of the current cadence caption; supplied the
replacement wording with "here" as the link.

### Inputs
CAD_CAPTION in site/build.py (motion + reduced-motion variants).

### Reasoning
Applied his sentence near-verbatim: "One Ethernet packet comes in
every 67.2 nanoseconds, slowed down exactly 20,000,000× here.
Check it out in more detail [here → block diagram]." The
reduced-motion variant carries the same fact frozen. Clean
worktree rebuild (WO-0056's landing is the tree's HEAD; nothing
uncommitted but the habit stands).

### Actions
Caption swap; rebuild; this commit; push.

### Evidence
Regenerated index.html carries the new caption.

### Outcome / DoD
Sponsor redeploys at will.

### Open questions
None.

### Files-in-this-commit
- site/build.py
- site/public/backlog.html
- site/public/block-diagram.html
- site/public/index.html
- site/public/org-chart.html
- site/public/spec-atlas.html

## [J-orchestrator-0151] 2026-08-04T00:10:00Z | task:none | Caption wrap fixed - the second sentence breaks as a unit

### Trigger
Sponsor: the caption breaks after "Check".

### Inputs
CAD_CAPTION; the second sentence now wrapped in a nowrap span so
the break falls before it, never inside it.

### Actions
Edit; clean rebuild; this commit; push.

### Evidence
Regenerated index.html.

### Outcome / DoD
Sponsor redeploys.

### Open questions
None.

### Files-in-this-commit
- site/build.py
- site/public/backlog.html
- site/public/block-diagram.html
- site/public/index.html
- site/public/org-chart.html
- site/public/spec-atlas.html

## [J-orchestrator-0152] 2026-08-04T00:35:00Z | task:WO-0056 | The lift landed - the arc from survival to proof is closed

### Trigger
dv's lift ruling committed at 6dd229c: the consequence LIFTED on
the replay's evidence — the surviving g-c4 diff, unmodified,
died against the repaired bench; G8 alone out of twenty-seven
units, on the exact assertion the row was written to make.

### Inputs
Run 30852220315's harvest; the ruling's four bounds (G7 benched
but not mutation-qualified — the next G campaign's first owed
item); the folded boundary fix (k >= 1519, interval 81 octets);
the benched-row rule stated to stop count drift.

### Reasoning
Board row flipped to CLOSED · LIFTED with the full arc; the
cosim-stayed-green observation carried as dv ruled it (the
class-(f) exclusion converted from argument to measured fact).
Coverage per dv's measurement: 33 rows benched, 28 of 62 ASSERT,
34 outstanding. Site rebuilt clean.

### Actions
Board flip; rebuild; this commit; push. Next dispatches: family
H design (dv), the architect's voluntary rotation + AP-M14 check
queued behind it.

### Evidence
6dd229c; run 30852220315; the rebuilt row.

### Outcome / DoD
WO-0056 closed. The G-2 arc — survival, diagnosis, correction of
the diagnosis, repair, replay, lift — is complete on the record.

### Open questions
None new.

### Files-in-this-commit
- tasks/BOARD.md
- site/public/backlog.html
- site/public/block-diagram.html
- site/public/index.html
- site/public/org-chart.html
- site/public/spec-atlas.html

## [J-orchestrator-0153] 2026-08-03T21:55Z | task:WO-0057 | Two returns processed and family H goes to the worker

### Trigger
dv_lead and architect_docs_lead both returned from the dispatches
issued after the WO-0056 lift landed at 1ff8562.

### Reasoning
dv's return declared a two-entry split and it was honored exactly:
J-dv_lead-0076 (AP-M14 §6 invariant re-checked — HOLDS, no file
changed, journal-only) at 55010e3, then J-dv_lead-0077 (the
WO-0057 family-H packet, four rows ranked by risk, M03-H4 last)
at 0e96728. The architect's rotation was committed per ADR-0017
§4.3 mechanics — the new volume staged alone, journal-only — at
a378612; its header fields re-verified against HEAD bytes before
the commit (sha256 253e92c8…, 423543 bytes, Continues-from
J-architect_docs_lead-0021). verify_journal_chain.sh: 9 chains
green, all three rotations now on the record. All three commits
pushed.

### Actions
The three commits above; push; tb_writer dispatched on WO-0057
with the packet issued as authored (DRAFT-state convention
unchanged from WO-0054), the risk ordering made binding, RTL
source barred, and the return addressed to dv's line review.

### Evidence
55010e3, 0e96728, a378612; verify_journal_chain.sh output
(9 chains, frozen volumes certified); the WO-0057 packet at
0e96728.

### Outcome / DoD
Both in-flight returns are on the record under their own
identities. Family H is with the worker. dv's two carried
open questions stand: §0.6's referent for a zero-delivered frame
(routed to architect) and the G/H campaign coupling (to be
decided before either seal is written).

### Open questions
None new.

### Files-in-this-commit
- (none)

## [J-orchestrator-0154] 2026-08-04T00:05Z | task:WO-0057 | Worker return landed green on first execution; board row added at allocation practice

### Trigger
tb_writer's WO-0057 return sat complete and quiet in the tree
(its completion notification was lost); processed it per the
same rule as this window's earlier returns.

### Reasoning
The return's material fact: the dev container's opam switch lost
its packages in a container recycle (lib dir down to 3 entries;
`hardcaml` not found in every dependent directory — re-verified
myself before committing, not taken on the worker's word), and
ADR-0005's network policy blocks reinstalling. The worker proved
the failure predates its diff and returned unverified-locally
with CI declared authoritative — which is the workflow file's
own stated posture. The four units use the house assert-style
(empty expect blocks, silent on success), same as family G.
Committed under tb_writer at f806272 (J-tb_writer-0015; files =
its journal's declared set exactly). CI: build 30862176345 and
journal-check 30862176314 both SUCCESS — the four units' first
execution anywhere, green first try. dv_lead dispatched on the
RV-0057 review with the CI fact relayed and two rulings owed:
the G/H campaign coupling, and the worker's Injection-device
MUST-STAY-GREEN flag. Architect's §0.6 round stays HELD until
the verdict lands — no spec movement under an active review.

### Actions
f806272 commit + push; dv review dispatch; WO-0057 board row
added above WO-0056 (row-at-allocation practice, 57 ids on the
ledger); this commit.

### Evidence
f806272; runs 30862176345, 30862176314; the dune error naming
`hardcaml` unfound at test/xgmii_rx_64/dune:61; J-tb_writer-0015's
Files list vs the staged set.

### Outcome / DoD
Family H is built, landed, and green; the round is with dv.
The toolchain loss is on the record as environment fact, not
worker fault.

### Open questions
Whether the lost opam switch is worth rebuilding if the network
policy ever admits it — local runs would shorten worker loops,
but CI-authoritative has held twice now under this posture.

### Files-in-this-commit
- tasks/BOARD.md

## [J-orchestrator-0155] 2026-08-04T00:45Z | task:WO-0057 | ACCEPT transcribed - family H closes at 32 of 62, one combined campaign next

### Trigger
dv_lead's RV-0057 return sat complete in the tree (notification
lost again); verdict read in full, committed under dv at 32257d7.

### Reasoning
ACCEPT with no bounce: four rows clean, every observable
re-derived rather than checked off. The verdict directs the
orchestrator to transcribe the state flip (RETURNED → ACCEPTED)
- done on the packet's State line, and the board row flipped
with the verdict's substance: the three green-run-cannot-say
findings (H4's vacuous window check, the unexcluded third
frame, the right-by-cancellation helper), the D1/D2 two-device
correction, and the coupling ruling - ONE campaign, scored set
G7 + H1-H4, three constraints carried, g-c4 out of scope.
Count: 32 of 62 ASSERT discharged. Next dispatches: dv drafts
the campaign packet with its SEALED companion frozen in the
same commit (R-SEAL-1 forward commitment, held); architect
round on the twice-routed §0.6 zero-delivered referent now
unblocked - review landed, no active round cites the clause.

### Actions
32257d7 push; packet State line transcription; board row flip;
this commit; then the two dispatches.

### Evidence
32257d7; RV-0057-VERDICT §10's boxed ruling; §8's scope and
constraints; §9's three-part ruling.

### Outcome / DoD
WO-0057 ACCEPTED on the record with the verdict's reasoning
preserved verbatim in the packet. Families A-H all landed.

### Open questions
None new; dv's owed-at-next-touch items ride in its journal.

### Files-in-this-commit
- agents/handoffs/WO-0057_tb-m03-family-h-start-without-terminate.md
- tasks/BOARD.md

## [J-orchestrator-0156] 2026-08-04T01:00Z | task:WO-0057 | The section-0.6 ruling landed and C-5 re-scoped by transcription

### Trigger
architect_docs_lead returned from the twice-routed §0.6 round;
dv_lead still drafting WO-0058 in a disjoint lane.

### Reasoning
The ruling landed at 0caf023 under the architect's identity:
the window's reference word is the last octet the frame
RECEIVED while open; the closing word stands in only for the
zero-received class; what follows a frame never extends it
(M03-G6's principle generalised upward, not distinguished).
The architect's material correction: the routed question said
"delivered nothing" but the right trigger is "received
nothing" - the delivered reading would have falsified
SPEC-M03 §9's committed far-edge sentence and changed what
run_f2 asserts at (lane 4, k=4). The escalation condition was
avoided by correcting the class, not weakening the rule. No
ADR, per the C-12/C-23 precedent. The -0021 received-versus-
delivered deferral is closed. Its one transcription request:
C-5's re-scope in docs/gates (not its staging lane) - done
here citing J-architect_docs_lead-0023.

### Actions
0caf023 commit + push; C-5 row amendment; this commit.
Queued for dv's next natural round: the §0.6 re-countersign
(C-43 discipline - not in force until transcribed) and its
call on restating Finding 2's note in the attack plan.

### Evidence
0caf023; the return's mechanical check (injection.ml:277's
window function computes the ruled rule clause for clause -
the diff ratifies the bench).

### Outcome / DoD
The §0.6 referent question that recurred across G6, family F's
k=0 branch, and family H is settled programme-wide. Nothing
benched moves.

### Open questions
None new; C-5's module-side half rides the ledger.

### Files-in-this-commit
- docs/gates/P1-spec-freeze-checklist.md

## [J-orchestrator-0157] 2026-08-04T01:20Z | task:WO-0058 | Campaign frozen in one commit; the auditor's blind round dispatched

### Trigger
dv_lead returned with WO-0058 drafted and its seal complete.

### Reasoning
Freeze-first honored: packet + SEALED companion in one commit
(1c3a89d) under J-dv_lead-0079, before any manifest diff
exists - the property that makes the seal a seal. Seven
classes GH-c1..c7 over the five scored units; 14 REQUIRED
cells; 203/217 M03 + 560 non-M03 must-stay-green measured at
base SHA a2d090d (run 30865856907, both jobs); two collisions
named in advance (the RV-0055 inflation lesson); one UNWORKED
rendering with its adjudication rule fixed before the fact.
dv confirmed the architect's §0.6 ruling does not gate the
campaign (seal written against the bench at the base SHA;
Finding 2 holds under either outcome). Board row added at
allocation. Next: auditor authors seven blind diffs under the
§2 allowlist; the transient application (branches = base + one
diff) is mine when the manifests return.

### Actions
1c3a89d push; board row; this commit; auditor dispatch with
base SHA, allowlist, branch naming, and the four mandatory
scope disclosures carried verbatim.

### Evidence
1c3a89d; dv's return (seal completeness statement, collision
list, base-SHA verification including the empty
f806272..a2d090d diff over test/ libs/ tools/).

### Outcome / DoD
The campaign is frozen and dispatchable. SO-M03 neither issues
nor is offered; 32 of 62 stands until the harvest.

### Open questions
None new. dv's §0.6 re-countersign rides its adjudication
round.

### Files-in-this-commit
- tasks/BOARD.md

## [J-orchestrator-0158] 2026-08-04T01:40Z | task:none | journal-check 141 was a SIGPIPE race in my own helper, not a violation - drained, proven, S39 added

### Trigger
journal-check red at 1c3a89d and d609b36 while build stayed
green - the first red on that job since R10 landed.

### Reasoning
A broken harness is never an anchor finding, and this was the
harness: the self-test passed 50/50, then check_journals.sh
--all died exit 141 = SIGPIPE. volume_header_field (mine,
WO-0053) awk-exited at the header's end; its `git show`
producer strands once a volume outgrows the 64 KiB pipe
capacity, and pipefail turns the race into red. It fired now
because dv's active volume crossed 79 KB at 1c3a89d. Verified
empirically rather than argued: locally the same tree is green
because mawk buffers the whole stream before honoring exit
(old helper leaves 0 leftover bytes); CI's awk is gawk, which
exits promptly and strands the producer. No journal property
was violated - both reds certify nothing about the record.
Fix: the helper drains stdin to EOF (found/past flags, no awk
exit), so the pipeline status is a verdict, never a schedule.
Audited the other pipe consumers: last_entry_num reads to EOF;
policy.sh:270's head-c/cmp stays verdict-correct under either
status. S39 added: over-buffer fixture, status and value
asserted; honest limitation recorded - the fixture reddens the
old code only under a prompt-exit awk (gawk, the CI flavor
where it raced; mawk cannot exhibit the bug at all). Suite
51/51, check_journals green, chain green.

### Actions
policy.sh helper rewrite; test_protocol.sh S39; suite + both
checkers run; this commit; push; confirm journal-check green
at the new tip (it re-verifies the full history, which is the
verdict that stands - the two red runs stay in the log as what
they are, a race caught and named).

### Evidence
Run 30867156714's log (50 passed then exit 141 on
check_journals); the two flavor measurements above; suite
output 51 passed, 0 failed.

### Outcome / DoD
Enforcement lane clean again; nothing in the journal record
was ever in question. The auditor's blind round continues
undisturbed.

### Open questions
None new.

### Files-in-this-commit
- scripts/policy.sh
- scripts/test_protocol.sh

## [J-orchestrator-0159] 2026-08-04T01:30Z | task:WO-0058 | Manifests landed and the seven transients applied

### Trigger
Auditor returned: seven classes SEEDED, blinding conduct
affirmed, four mandatory disclosures on the record.

### Reasoning
The auditor refused the manifest path my dispatch named -
agents/handoffs/ is outside its lane on four independent
statements and R7 would have refused the commit; the manifest
lives at docs/reports/audit/WO-0058-mutations/README.md and
that is the correct resolution, mine to have gotten right in
the dispatch. Committed under auditor at 480c38a. Transient
application per packet §6 and the manifest's own §7: diffs
extracted by the published command, byte-checked clean against
the tree, then seven branches each = a2d090d + one diff:
gh-c1 39bcccb, gh-c2 4e84d64, gh-c3 2ddb3db, gh-c4 6795ae6,
gh-c5 63af79d, gh-c6 e996f8e, gh-c7 3cf90ac - plain
"MUTATION RUN <id> -- never merge" commits, never merged.
journal-check red on those branches is plain-commit noise;
cosim red is by design; the harvest scores the BUILD job's
runtest alone.

### Actions
480c38a push; extraction; seven branches pushed; this commit.
Next: wait the runs out, harvest, relay to dv with the four
disclosures verbatim for adjudication against the seal at
1c3a89d.

### Evidence
480c38a; the seven branch SHAs above; git apply --check clean
seven of seven before any branch existed.

### Outcome / DoD
The campaign's field work is running. Nothing about outcomes
is claimed here; the seal speaks at adjudication.

### Open questions
None new.

### Files-in-this-commit
- (none)

## [J-orchestrator-0160] 2026-08-04T01:50Z | task:WO-0058 | Harvest: seven of seven reddened the scored bench; adjudication dispatched

### Trigger
All seven mutation runs completed within nine minutes of the
push; harvested per the packet (BUILD job runtest only).

### Reasoning
Measured facts, no interpretation: every class's runtest went
red and every failure landed in the module's own bench files -
gh-c1 in test_m03_g.ml (M03-G6 observed 2 strobes, M03-G7
observed 3), gh-c2 through c7 in test_m03_h.ml alone. gh-c7's
red is M03-H4 by itself on the exact consecutive-high-cycles
assertion - the collapse class died on the one unit dv said
could see it. gh-c1's M03-G6 red is a unit outside the scored
five; named for dv, not judged here. The cosim job was GREEN
on all seven branches - relayed as fact, unscored per the
packet. No other test file failed anywhere. Full logs saved
to the session scratchpad (wo58_harvest/). Adjudication
dispatched to dv with the messages verbatim, the branch and
run ids, the manifest's disclosures named as scoring inputs,
and the round's other dues: the §0.6 re-countersign and the
X-3(c) restatement call.

### Actions
Seven harvests parsed; dv dispatched; this commit; push.

### Evidence
Runs 30868752152/3423/4060/4798/6316/7246/8781; the message
strings quoted in the dispatch, lifted character for character
from the logs.

### Outcome / DoD
The campaign's field phase is complete and the record of it is
with the adjudicator. The seal speaks next, not me.

### Open questions
None new.

### Files-in-this-commit
- (none)

## [J-orchestrator-0161] 2026-08-04T02:05Z | task:WO-0058 | Verdict landed, countersignature transcribed into force, board and site at the campaign's close

### Trigger
dv_lead returned from adjudication with a two-commit split;
both honored exactly (ac79ccb: verdict + entry 0080; 72192ba:
countersignature block + AP edits + entry 0081).

### Reasoning
Seven of seven killed, all five scored units qualified, 763 of
763 must-stay-green - and the campaign's two findings are both
against dv's own seal, standing unedited per the G-1 precedent.
M03-G7's qualification discharges the module's oldest open DV
debt; M03-H4's lone kill of the collapse class measured C-23's
counting convention load-bearing. The §0.6 countersignature is
signed on dv's own re-derivation (the lane-4 s+191/s+190
discriminant), and this round transcribes it per the C-43
clause: a §13 row in requirements.md records the signature of
record (WO-0057 packet block, J-dv_lead-0081) and the ruling
is IN FORCE from that row - the REQ-901/J-orchestrator-0126
form followed exactly. dv's AP edit was announced loudly and
its rationale recorded; its RTL-exposure escalation is raised
in the verdict for the next campaign packet, not decided. The
board row carries the arc whole; site rebuilt from this tree.

### Actions
The two dv commits + push; the transcription row; board flip;
site rebuild; this commit; push. Relay to sponsor with the
verdict verbatim and the redeploy suggestion.

### Evidence
ac79ccb, 72192ba; WO-0058-VERDICT §§ in the packet; the §13
row appended above J-architect_docs_lead-0023's; the build
line (300 commits, 257 entries).

### Outcome / DoD
WO-0058 CLOSED. Families A-H landed, five more units
mutation-qualified, the strobe-window rule normative and in
force. 32 of 62 ASSERT discharged; SO-M03 neither issues nor
is offered. Next: dv drafts the next family packet (I is next
in the queue).

### Open questions
dv's escalation 1 (adjudicator blind-by-default) is queued for
the next campaign packet's drafting round.

### Files-in-this-commit
- docs/specs/requirements.md
- tasks/BOARD.md
- site/public/backlog.html
- site/public/block-diagram.html
- site/public/index.html
- site/public/org-chart.html
- site/public/spec-atlas.html
