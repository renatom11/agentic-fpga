# Journal: claude_auditor_agent — volume 02

- **Agent**: auditor (Opus 5, independent)
- **Charter**: agents/charters/auditor.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 02
- **Continues-from**: J-auditor-0017
- **Previous-volume**: agents/journals/claude_auditor_agent.md
- **Previous-volume-sha256**: c268ec132dac3e7506a8e2dda21b8abfe39b62e0710e547da6b49122340acedb
- **Previous-volume-bytes**: 267487

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 01 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-auditor-0018] 2026-08-10T16:30Z | task:WO-0077 | Nine family-K + N-completion classes seeded blind at aced7b4: all nine SEEDED including the one the packet pre-committed a row's UNQUALIFIABLE status against, and the carry that separates a class from a re-timing is one disjunct
### Trigger
Spawned by the orchestrator on `WO-0077` (`agents/handoffs/WO-0077_family-k-mutation-campaign.md`,
DRAFT, dv_lead's, committed with its seal at `aced7b4`). Spawn short-id
`WO-0077-SEED/2026-08-10T16:30Z`. MANIFEST-ONLY blinded seeding for the tenth and last
campaign of the class-based era: six family-K classes against `clear` (`IC-K1` … `IC-K6`)
and three N-completion classes against `cfg_rx_enable` (`IC-N1`, `IC-N4a`, `IC-N4b`),
delivered as one minimal independent diff each plus the mechanical operator table, with
the operator — not me — cutting the nine transients (`FINDING WO-0074-A1`, mine, ruled
ACCEPTED, carried into the packet's own §9.1). **This entry is the first of volume 02**:
volume 01 crossed 256 KiB at 267 487 bytes and ADR-0017 §4.3's rotation applies.
### Inputs
`agents/charters/auditor.md`; `agents/PROTOCOL.md`;
`agents/handoffs/WO-0077_family-k-mutation-campaign.md` (all 1641 lines, four reads);
`libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (all 1011 lines at `aced7b4`) and its `.mli`
(all 45 lines); `docs/specs/requirements.md` (REQ-005, REQ-008, REQ-009, REQ-011,
REQ-015, REQ-016, REQ-101 … REQ-113, REQ-802, REQ-803, REQ-810, plus the section index);
`docs/specs/modules/xgmii_rx_64.md` (§4.3, §6.1's disabled-state paragraph, §6.2, §6.3,
§7, §9, and the `cfg_rx_enable` grep hits in §4.2/§10/§13);
`docs/reports/audit/WO-0061-mutations/DISP-0001_A-1.md` §4 (R-DISC-1, R-DISC-2 — my own
rules, which bind this manifest); `docs/reports/audit/WO-0076-mutations/README.md` (form);
`agents/journals/claude_auditor_agent.md` (my own journal only — header, entry-id chain,
harvest span, tail); `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` §4.1–§4.4
(the volume-header specification — an exposure outside the packet's allowlist, disclosed
in the manifest's §0 (E5) and below).
**Not read, absolutely**: the sealed companion
`WO-0077_family-k-mutation-campaign-SEALED-predictions.md` — not opened, not grepped, not
`git show`n, no excerpt, no line count, no diff stat. **All of `test/**`**, the attack
plan `AP-xgmii_rx_64.md` **by name** (seven of the nine classes are quoted from its
cells), `bench.ml`/`bench.mli`, all three named `test_m03_*.ml` files, `test/cosim/`,
`test/monitors/`, `test/golden/`. **All of `agents/**`** bar the packet and my two
charter documents — **every other journal**, every other handoff packet, and **`WO-0072`
specifically**, whose §9 disposition table is `FINDING K-1`'s subject. Also not read:
`ADR-0014` (admitted by the packet, omitted by my spawn's allowlist; the narrower
allowlist was honoured and nothing in the manifest rests on it), `docs/gates/`, `tasks/`,
`tools/`, `scripts/`, `.github/`, and every `libs/**` file but the target and its `.mli`.
### Reasoning
**Sampling frame.** The window is not a commit range this round: it is one file at one
SHA. In scope was `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` at `aced7b4` in full,
against nine class statements the packet derives from REQ-009, REQ-810, REQ-803 and
SPEC-M03 §4.3/§6.1/§6.2/§7/§9. I sampled the whole file rather than the gates the packet
names, because a minimal diff is only minimal relative to every alternative site, and
three of the nine renderings below were chosen by *rejecting* the site the class's own
sentence suggests. What I deliberately skipped, and why: every `test/**` byte and the
seal (barred, and the whole point of a blinded seeding); `ADR-0014` (allowlist conflict,
resolved toward the narrower list; the specification states the ruling in its own words
at §4.3, §6.1, §6.2 and §9's clause (b)); and the packet's §11 sealed-quantity table read
as anything other than a direction — I used its *directions* to cross-check my
mechanisms, never to choose one.

**How the six K classes were chosen, and the fact that decided all six.** `clear` enters
this design in exactly two ways, and I measured that before writing a class: as `spec`'s
synchronous register clear (232) and as eight combinational gates (377, 421, 422, 971,
976, 990, 991, 997). That split is what makes REQ-009's two conjuncts true separately —
the gates give silence *inside* the window, the register clear gives silence on the
release cycle *for free* — and it is also what makes four of the six classes expressible
as a single disjunct. The consequence I leaned on six times, and which is the one piece
of Hardcaml semantics this whole manifest rests on: **a `reg spec` register samples its
clear at the same edge as its data**, so a value driven on the cycle before a window is
still presented on the window's first cycle and is zeroed only at the end of it. That is
why `IC-K4`'s carry needs no clear-free flop, and why `IC-K3`'s `reg spec vdd` is an
exact *"the previous cycle was cleared"* signal.

**`IC-K4` is the round's real result and it went the other way from the packet's
expectation.** The packet named it the likeliest `NOT SEEDED` of the nine, said so three
times (§1.6, §14(c), Q2), and pre-committed `M03-K1` **UNQUALIFIABLE BY MUTATION** as
the disposition if it came back declared. Its argument was that a strobe carried across a
`clear` must either be a plain re-timing — which moves every pinned strobe cycle in the
suite and is a scope violation — or a mechanism nobody had shown to exist. **The
mechanism exists and it is one operator.** `strobe` is a *function* whose clear gate is a
**conjunct**, so a carry can be **disjoined beside** the conformant term instead of
inserted in front of it: `(consume &: s &: ~:(i.clear)) |: (reg spec (consume &: s) &:
i.clear)`. The conformant disjunct is byte-identical, so nothing moves anywhere; the
added disjunct ends in `&: i.clear`, so it is identically zero on every schedule that
never drives `clear` — both of `D-K1b`'s conjuncts discharged **structurally**, which no
other class in the round manages for both. I sat on this for a while because a class the
commissioning packet expects to be unrenderable is exactly the shape of a rendering that
is quietly wrong; what convinced me was that the *reachable surface* of the diff is
`{ units driving clear } × { cycles inside a window }`, and at `M03-K2` that surface is
empty because nothing is consumed on the cycle before its window. A class that can only
fire where the packet's own §4.3 says the only pending thing is a strobe is a class, not
a re-timing.

**Two renderings I rejected after working them, and both rejections are the argument for
what shipped.** (1) `IC-K1` at `a_close_now` (377) — the site the class's own sentence
points at, *"clear closes the frame"*. It renders **nothing**: the record it creates is
destroyed by `spec`'s clear at the first window edge and `tvalid`/`tlast` stay gated, so
the design is observationally identical to the base. The class has to be rendered at the
output record or not at all, and that is a fact about where this design puts its clear,
not about the class. (2) `IC-K6` as the *deletion* of `&: ~:(i.clear)` from 976 — the
smaller edit, and the one a reader would expect. It renders nothing at a **lane-4**
started frame, because `bubble` forces `al_keep` to zero under an idle word at offset 4,
so `decided` is low on the window's first cycle and no arm of the emission decision
fires. Since frame A's start lane at `M03-K2` is a bench fact I am blinded from, the
smaller edit would have been a coin toss. The disjunctive form is one token longer and
offset-independent. **`FINDING WO-0074-S4`'s method applied to my own diffs rather than
to a seal**: check the rendering against the cells it does *not* mark, not only the one
it does.

**`IC-N1` is where I had to choose between the packet's stated required consequence and
its own disclosure, and I chose the disclosure and said so.** §2's required consequence
says the frame's `tuser`[0] = 0 is untouched — that is branch **α**, report-only. In this
design `abort` (975) reads `sel_error`, so **any** record-borne report sets `tuser`, and
α is not reachable without a private two-stage report path beside the record: a bigger
diff that renders a *reporting* defect where the class is named for a *routing* one. So
the rendering is the one-conjunct deletion at `a_closes_with` (365) — which is `a_close_oh`,
which is §9's clause (a) *"each event is evaluated at its own octet time"* compiled to a
lane search — and it moves exactly two things: `tuser`[0] on one word and one added
`error_bad_frame`. I declare it **β**, state exactly what moves, and ask dv_lead to
confirm the label before the run rather than argue it after a scorecard (RN-3). I also
chose `D-N1b`'s reading **(b)** over (a) deliberately: (b)'s red set is contained in
(a)'s, so §11's `⊆` requirement holds whichever branch the seal was written for, and (b)
is the narrower blast radius — which §16 item 7 says is the only thing standing between
one class and a breadth claim.

**Why these nine and not others — the defect classes rejected as low-value.** I did not
choose the classes; the packet did, and seven of nine are quoted from `AP` cells I am
barred from reading. What I chose was the *rendering* of each, and the classes I rejected
were renderings: a lane-asymmetric admission gate for `IC-K3` (a different defect, and
`NOT SEEDED` at lane 4 for any two-lane carrier); a level rather than a pulse for
`IC-K2` and `IC-K4` (the same class, but it makes the sealed count a function of the
window's length rather than of the defect); nine separate hunks for `IC-K5` instead of
one re-source at `i.clear` (any drift between them is a *partial* shift, which no
sentence of REQ-009 describes); gating `consume` for `IC-N4b` (it is read by the record
ageing, so it would change **which cycle** later reports pulse on — a report defect with
a datapath signature); and gating `a_char_end` for `IC-N4a` (the frame would run on
**and** still be reported, which is a design no reading of REQ-810 produces).

**The one derivation I had to make because the packet does not state it.** Four of six K
discharges name cycle numbers, and I am blinded from the bench. The packet's own front
matter quotes `WO-0072` §9's three tells — D1 *"inside cycles 6 … 11"*, D3 *"on a cycle in
6 … 11"*, D2 *"cycles other than 14 … 21"* — and §16 item 5 states the window is five
cycles closing on a start character's cycle. Five cycles inside 6 … 11 with the release
carrying frame B's start gives window 6 … 10, release 11; and §7's ΔC = 3 puts a frame
admitted at 11 at words 14 … 21, which is D2's own interval at both ends. Three
independently quoted figures agree, so I used it — and raised it as **RN-1** rather than
rely on it silently, because a derivation that four discharges name should be confirmed
by the party who can see the file.

**A second, independent way `WO-0072` §9's table under-discriminates, found by rendering
rather than by reading.** `FINDING K-1` convicts the table because all three dispositions
raise one assertion whose message carries no observed data. Working the classes surfaces
a different hole: **D3's own tell is a disjunction — *"`tvalid` = 1 **or any strobe
high** … with no `tlast`"* — and `IC-K6` satisfies it by the first disjunct while
`IC-K2` satisfies it by the second.** Two different defects, two different root causes,
one disposition row. I raise it as an observation and not as a finding (RN-4): the six
bench-side classes the table also carries are barred to me, and one of them may already
own the added-report case. If it does not, it belongs in `FINDING K-1`'s record when the
post-campaign `AP-` round pays it.

**The ADR-0017 exposure, decided rather than drifted into.** My spawn makes the rotation
mandatory and specifies the header *"per ADR-0017 §4.3"*; volume 01 carries no rotation
header to copy; the packet's allowlist does not admit the ADR. Guessing a header format
that `agent_commit.sh` and CI key on would risk a malformed chain — a protocol defect —
to protect a blinding whose subject is a mutation campaign, and an ADR about journal file
mechanics can hold no campaign answer. I read §4.1–§4.4 and nothing else in that file,
and recorded it as a **leak** in the manifest's blinding statement rather than arguing it
into the allowlist. A blinding statement that omits its own exposures is worthless, and
that includes the ones I would defend.
### Actions
- Ran `git rev-parse HEAD` as the first action (§9.2's abort-first check): `aced7b4…`,
  matching the base the spawn supplied, so no `git merge-base` direction test was needed.
- Verified R-SEAL-1 from the commit rather than from the claim: `git show --stat
  --name-only aced7b4` (names only) shows the seal staged in the packet's own commit.
- Verified §10's freeze against history rather than accepting the packet's sentence:
  `git log --oneline -3 -- test/` confirms `22ffe13` is the most recent `test/**` edit
  reachable from the base, and `aced7b4` itself stages no `test/**` byte.
- Authored nine diffs against `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` — one per class,
  each a single contiguous hunk whose old text occurs **exactly once** in the file.
- Verified all nine mechanically (Evidence below), reverting each and confirming the
  working tree byte-identical to the base after every trial.
- Wrote the manifest to `docs/reports/audit/WO-0077-mutations/README.md`: blinding with
  five disclosed exposures; the base-SHA/direction/freeze/R-SEAL-1 section; the nine
  classes with their rejected alternatives; R-DISC-2's five-path gate inventory with
  cross-class facts tabulated before delivery, including the two shared sites (990 for
  IC-K4/IC-N4b, the emission clear gate for IC-K1/IC-K5/IC-K6); R-DISC-1 discharged per
  class, per lane, term by term at the firing cycle with §6's four K and two N cycle
  facts explicit; all nineteen disclosures; §7's pre-ship check in its positive form for
  all nine; blast-radius rules with complete conjunct lists; a six-question pre-run
  reading note; and §10's mechanical operator table.
- **Cut no branch, staged nothing outside `docs/reports/audit/**`, ran no `git commit` and
  no `git push`.**
### Evidence
All at base SHA `aced7b41ef83c497b81cba411e51045627260f20`, working tree clean before and
after every trial.

```
$ git rev-parse HEAD
aced7b41ef83c497b81cba411e51045627260f20
$ git show --stat --name-only --format='%H%n%s' aced7b4     (names only — the seal was NOT opened)
agents/handoffs/WO-0077_family-k-mutation-campaign-SEALED-predictions.md
agents/handoffs/WO-0077_family-k-mutation-campaign.md
agents/journals/claude_dv_lead_agent.v06.md
$ git log --oneline -3 -- test/      (subjects and SHAs only)
22ffe13 | 1e5d58a | c109c08          -> 22ffe13 is the last test/** edit before the base
$ ocamlc -version
4.14.1
```

Per class — anchor uniqueness (`old.count(text) == 1` over the base file), `git apply
--check`, application, parse, round-trip revert, and a byte-identical tree afterwards:

```
IC-K1   anchors=1 lines=992-999  apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-K2   anchors=1 line=1003      apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-K3   anchors=1 lines=421-422  apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-K4   anchors=1 line=990       apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-K5   anchors=1 line=232       apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-K6   anchors=1 line=976       apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-N1   anchors=1 line=365       apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-N4a  anchors=1 lines=312-314  apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
IC-N4b  anchors=1 lines=990-991  apply-check=OK applied=[M …/xgmii_rx_64.ml] parse=OK revert=OK clean-after=yes identical=True
$ git status --porcelain | wc -l
0
$ git rev-parse HEAD
aced7b41ef83c497b81cba411e51045627260f20      (unmoved)
```

The parse check is `ocamlc -stop-after parsing -c <mutant>.ml`, exercised for a negative
first (a deliberately truncated file returns exit 2 with `Error: Syntax error`), so a
`parse=OK` above is a check that can fail rather than a label. **No `dune` was run** (the
spawn forbids it) and no branch was cut, so **types, widths, elaboration and
combinational loops are unverified and are stated as unverified** in the manifest's §9
item 4 — the honest limit of this environment, and the reason `IC-K5`'s record-update
field is written `{ i with I.clear = … }` with its module path explicit.

The volume-02 header fields are computed, not recalled:

```
$ git show HEAD:agents/journals/claude_auditor_agent.md | sha256sum
c268ec132dac3e7506a8e2dda21b8abfe39b62e0710e547da6b49122340acedb  -
$ git show HEAD:agents/journals/claude_auditor_agent.md | wc -c
267487
```

and they match the on-disk file byte for byte, which is ADR-0017 §4.3's own note that the
predecessor is not modified by the rotation commit. Volume 01 is **not staged and not
touched**; the last entry in it is `J-auditor-0017`, so `Continues-from` is that ID and
this entry is `J-auditor-0018` (ADR-0017 §4.2: IDs continue across volumes).
### Outcome
**DoD met.** Nine manifests delivered as one document, **nine seeded, zero `NOT
SEEDED`** — including `IC-K4`, which the packet expected to come back declared and
against which §13 pre-committed `M03-K1`'s UNQUALIFIABLE-BY-MUTATION status; that
disposition does **not** fire, and §5's `D-K4c` states the mechanism in my own words
rather than asserting the conclusion. All nineteen disclosures answered separately under
their own labels; §7's pre-ship check positive for all nine in its positive form with the
`clear` = 0 column and the **reset-pulse** column discharged for every K class (four
structurally, two by the packet's own §4.2 measurement, and the difference is stated) and
the `Enable.high` column for every N class (both structurally); R-DISC-2's five-path
inventory tabulated with cross-class facts **before** delivery; R-DISC-1 discharged per
class per lane at the firing cycle. **No branch cut** — `FINDING WO-0074-A1` is carried in
the packet's own terms and the operator cuts `mut/wo-0077-k1 … k6, n1, n4a, n4b` from §10's
table in §12's fixed order. **No lessons harvest is due** — my charter fixes harvests at
every `SO-` and every phase gate and this round is neither; the open span is
**`J-auditor-0015` … (open)**, declared so a skipped harvest stays a visible gap.
Handoff: the manifest to the orchestrator for commit, and to dv_lead as this campaign's
manifest **and** its pre-run reading note (§8, six questions, all before the run).
### Open-questions
1. **RN-1 — the `M03-K2` window and release cycles are derived, not given.** Window
   6 … 10 and release 11, derived from three figures the packet quotes and cross-checked
   against ΔC = 3. Four of six K discharges name them. Confirm or correct.
2. **RN-2 — frame A's start lane at `M03-K2`.** `IC-K5`'s leading-edge word escape is
   offset-dependent; its trailing-edge half (frame B refused) is not, so the class's red
   does not turn on the answer — but the seal's cell might.
3. **RN-3 — `D-N1c`'s branch label.** My `IC-N1` adds one `error_bad_frame` and sets
   `tuser`[0] on the already-closing frame while leaving that frame's word count, cycles,
   `tkeep` and octets bit-identical. Neither α nor β at its widest. I declare **β** and
   ask whether the per-word `tuser` assertion is inside the row's own observable for §13's
   qualification rule.
4. **RN-4 — `WO-0072` §9's D3 tell is satisfied by two of this round's classes**, `IC-K6`
   by its first disjunct and `IC-K2` by its second, with different root causes. A second
   and independent under-discrimination beside `FINDING K-1`'s. Raised as an observation:
   the six bench-side classes the table also carries are barred to me and one may already
   own it.
5. **RN-5 — `IC-K4` seeded against a pre-committed void.** §14's era arithmetic names it
   *"this round's likeliest addition to the void column"*; §11 seals its strobe count as
   *"an inequality above one"*, which presupposes a seeding. Confirm the seal carries an
   `IC-K4`-seeded branch; if it does not, the cell is `U` by the seal's own construction
   and I would rather know now than at adjudication.
6. **RN-6 — the allowlist's `ADR-0014` path is broken for the second round running.**
   Reported at `WO-0076` §9 RN-4 and unrepaired at this base. It cost nothing this round
   because my spawn's allowlist omits the ADR entirely, but an allowlist naming a path
   that does not exist is one a future round will silently widen or narrow.
7. **The date discrepancy is now at its fourth consecutive round, and I record it because
   I audit rather than tidy**: my spawn short-id is minted `2026-08-10T16:30Z` while this
   session's environment reports 2026-08-06 (it reported 2026-08-05 at `J-auditor-0016`
   and 2026-08-06 at `J-auditor-0017`, and the base commit's own author date is
   2026-08-06). I take the spawn mint as authoritative for this entry's timestamp, as at
   the three previous entries. Entry-ID monotonicity is unaffected across the volume
   boundary; the correction is the orchestrator's to own.
8. **One exposure outside the packet's allowlist, and it is mine**: `ADR-0017` §4.1–§4.4,
   read to compute this volume's header rather than guess a format the commit scripts key
   on. Disclosed in the manifest's §0 (E5) and reasoned about above. If the operator holds
   that the allowlist admitted no such exception, the finding is against me and the
   remedy is a spawn that names the rotation ADR in the allowlist when it mandates a
   rotation.
### Files-in-this-commit
- docs/reports/audit/WO-0077-mutations/README.md
