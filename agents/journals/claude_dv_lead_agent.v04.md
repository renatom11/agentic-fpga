# Journal: claude_dv_lead_agent — volume 04

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 04
- **Continues-from**: J-dv_lead-0109
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v03.md
- **Previous-volume-sha256**: 76bb76822a90285b04f4a206857ec4309523391ca83c612e6905e620b01bf37c
- **Previous-volume-bytes**: 279073

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 03 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0110] 2026-08-05T18:30Z | task:none | Volume 04 opened — and the dispatch's one instruction I could not execute is the one the checker forbids: a header-only rotation commit does not exist, because R2 and R5 both require the entry that ADR-0017 §4.4 puts in it

### Trigger
Orchestrator dispatch, step 1 of a two-commit round: rotate to volume 04 before
anything else, with the chain fields computed rather than accepted, and commit
the new volume alone under `--journal-only` semantics. The commit gate emitted
`WARN-JOURNAL` at `79074cb` — v03 stands at 279,073 bytes, above `S`.

### Inputs
- `docs/adr/ADR-0017-a-journal-is-a-chain-not-a-file.md` **§4.3** (the header
  block and why the back-link is the load-bearing part), **§4.4** (the rotation
  commit, *concretely* — its four numbered steps), §5.1 (the thresholds and what
  anchors them), §6.2 and §6.3 (the tightened R8 and R5-across-the-chain).
- `agents/PROTOCOL.md` §4, §4.1, §4.2, §5 (`R2`, `R3`, `R4`, `R5`, `R10`).
- `scripts/agent_commit.sh` lines 60–200 — **the R10/R2/R3/R5 checks I am about
  to be graded by, read so this file is written against the checker and not
  against my memory of the ADR**, which is the discipline `J-dv_lead-0091`
  adopted and the reason this entry exists at all.
- `scripts/policy.sh` — `JOURNAL_SOFT_MAX` 262144, `JOURNAL_HARD_MAX` 524288;
  `extract_files_list`'s `(none)` handling (lines 250–260).
- **`agents/journals/claude_dv_lead_agent.v03.md` at HEAD** — its sha256, its
  committed byte count and its last entry id, all three through `git show HEAD:`
  and none from the worktree.
- Commit `77e8540` (`dv journal rotated to volume 03`) — **the precedent the
  dispatch itself cited**, read as a commit rather than as a description: one
  file, +117 lines, `Journal-Only: true`, `Journal-Entry: J-dv_lead-0091`.
- My own `J-dv_lead-0091` (the volume-03 rotation) as the form.
- **No `libs/**`, no `docs/reports/audit/**`, no `scripts/` writes, no spec
  path.** A rotation has no evidence content and needs no derivation.

### Reasoning

**1. Every chain field is computed at HEAD, and the one I was handed is verified
against the tree rather than against the dispatch.** `Continues-from` was given
as `J-dv_lead-0109`; `git show HEAD:…v03.md | grep '^## \[J-dv_lead-'` ends on
**J-dv_lead-0109**, so the join point is right. `Previous-volume-sha256` is the
sha256 of the **committed blob** — `76bb7682…bf37c`, taken through `git show
HEAD:`, which is the whole point of the field: it must describe a state that
exists in history, not a state that exists on my disk. Bytes: **279,073**, from
the same pipe. `git status --porcelain` shows v03 untracked-clean and unmodified,
so the hashed bytes and the disk bytes agree — stated because if they had
disagreed, the committed blob still wins and the ADR says so.

**2. The instruction I could not execute, and why refusing it is the only way to
obey the dispatch's own cited authority.** The dispatch says, in terms: *"NO
entry in v04 in this commit — the header block only."* **That commit cannot be
created**, and not by a matter of taste:

- `agent_commit.sh` R2 requires a staged append to the active volume; for a new
  volume the whole file is the appended region.
- **R5 then runs `grep -cE "^## \[J-dv_lead-[0-9]{4}\]"` over that region and
  fails unless the count is exactly 1** — a header-only file gives **0** and the
  script fails with *"appended region must contain exactly one new entry header,
  found 0"*. There is no flag that skips it: ADR-0017 §4.4 says in terms
  **"there is no 'rotation mode' in the scripts"**, and calls that absence the
  property that makes the mechanism hard to abuse.
- R4 additionally requires a `### Files-in-this-commit` section in the appended
  region, which a header block does not have.
- **ADR-0017 §4.4 step 2 spells the requirement out**: create the new volume
  *"with the §4.3 header and **exactly one** entry … in the normal §4.1
  grammar."*
- And **the precedent the dispatch names as authority says the same thing when
  read as a commit rather than as a memory**: `77e8540` carries
  `Journal-Entry: J-dv_lead-0091`, and `git show 77e8540:…v03.md | grep -c '^##
  \[J-dv_lead'` = **1**. The practiced rotation has always contained its entry.

So the header-only reading is a misdescription of the precedent, and following it
would produce a commit the orchestrator cannot make. **This entry is that one
entry, and it takes number 0110** — `chain_last_entry_num` at HEAD is 0109 and
R5 wants last + 1, so no other number is available. **The consequence the
orchestrator must carry into commit 2: the WO-0065 packet's entry is
`J-dv_lead-0111`, not 0110.** I state the renumbering here rather than only in my
return, because the return is chat and this is the artefact.

**3. This rotation is ELECTIVE, and saying so is a debt `J-dv_lead-0091` created
for every rotation after it.** v03 is **279,073 bytes — above `S` (262,144) and
well under `H` (524,288)**. `agent_commit.sh` refuses only above `H` and emits
`WARN-JOURNAL` above `S`; the gate at `79074cb` **warned**. So R10 would have
taken another append, exactly as it would have at v02, and the choice to rotate
is mine to defend rather than a mechanical necessity. The v02 rotation *was*
forced (v01 stood at 1,123,442 bytes, 2.14 × `H`); the v03 one was not and said
so; this one is not and says so. **A journal whose rotations all imply necessity
is a journal that has quietly stopped distinguishing the two**, and an auditor
diffing the three entries would find the difference and be right to ask.

**4. Why rotate anyway.** Three reasons, in the order I weight them. (i) The
boundary is a real one: v03 opens on the BUG-0003 confirm round and closes on the
plan round that absorbed the M03-I2 campaign; v04 opens on a **family round**,
so a reader who opens this volume gets the family-B completion from its first
byte instead of joining a closed campaign's bookkeeping. (ii) The warn band is
where a rotation is *cheap* — above `H` it is compulsory and lands wherever the
refusal happens to fall, which is never a boundary anyone chose. (iii) The
dispatch asked, and a clerical act that costs nothing and forecloses nothing is
not the place to spend refusal capital — which is exactly why the one thing I do
refuse here is the thing the checker refuses too, and nothing else.

**5. What I did not do.** I did not touch v03 — not one byte, which R10 verifies
by comparing the staged and HEAD blob ids and which is also what makes
`Previous-volume-sha256` mean anything. I did not seed or read any other agent's
journal into this commit. I did not fold the WO-0065 packet into the rotation:
`Files-in-this-commit` is `- (none)` and the commit carries `Journal-Only: true`,
so the rotation is separable in the log from the packet that follows it, exactly
as the dispatch ordered them.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at `J-dv_lead-0109`: **J-dv_lead-0110** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0110**, first harvest still firing at
`SO-M03`. **Nil yield**: nine banked candidates and both war stories carry
unchanged, none promoted, none retired. A rotation produces no incident, and
recording a candidate from a clerical act would dilute the ones that were earned.

### Actions
- Created `agents/journals/claude_dv_lead_agent.v04.md` with the ADR-0017 §4.3
  header block — Volume 04, Continues-from `J-dv_lead-0109`, Previous-volume
  `agents/journals/claude_dv_lead_agent.v03.md`, sha256 and bytes as computed —
  in v03's exact field order and wording, and this entry as its first.
- Computed, not copied: the predecessor's sha256, byte count and last entry id,
  all at HEAD.
- Read `agent_commit.sh`'s R2/R3/R4/R5/R10 block before writing a byte, and
  recorded above the one place where the dispatch and the checker disagree.

### Evidence
```sh
git show HEAD:agents/journals/claude_dv_lead_agent.v03.md | sha256sum
# 76bb76822a90285b04f4a206857ec4309523391ca83c612e6905e620b01bf37c  -
git show HEAD:agents/journals/claude_dv_lead_agent.v03.md | wc -c
# 279073
git show HEAD:agents/journals/claude_dv_lead_agent.v03.md \
  | grep '^## \[J-dv_lead-' | tail -1 | cut -c1-24
# ## [J-dv_lead-0109]
git status --porcelain -- agents/journals/claude_dv_lead_agent.v03.md
# (empty -- the hashed bytes are the committed bytes)

# The precedent, read as a commit rather than as a description
git show --stat 77e8540 | tail -3
#  agents/journals/claude_dv_lead_agent.v03.md | 117 +++++++++++++
git show 77e8540:agents/journals/claude_dv_lead_agent.v03.md \
  | grep -c '^## \[J-dv_lead'
# 1        <- the rotation commit has always carried exactly one entry
```
Thresholds read from `scripts/policy.sh`: `JOURNAL_SOFT_MAX=262144`,
`JOURNAL_HARD_MAX=524288`; **279,073 is between them, i.e. warn, not refuse.**
The R5 check quoted in Reasoning §2 is `agent_commit.sh`'s own
`new_headers=$(grep -cE "^## \[J-${AGENT}-[0-9]{4}\]" …)` followed by
`[ "$new_headers" -eq 1 ]`. **Not run**: `dune build`, `dune runtest` — no
Hardcaml toolchain in this container (ADR-0005); this commit stages one markdown
file and no test could speak to it.

### Outcome
DoD met for step 1, with **one declared divergence from the dispatch**: the
rotation commit carries this entry, because a header-only rotation commit is
refused by R2/R5 and is forbidden by ADR-0017 §4.4's own step 2 — and the
precedent the dispatch cited is itself an entry-carrying commit. Volume 03 is
frozen; volume 04 is active and chains to it. **Handoff**: the orchestrator
commits this volume **alone**, `Journal-Only: true`, `--entry J-dv_lead-0110`,
ahead of the WO-0065 packet commit.

### Open-questions
1. **The WO-0065 packet's entry is `J-dv_lead-0111`, not 0110**, and the two
   commits must be staged in order. R5 leaves no choice on the number: 0110 is
   consumed here. It also fixes the **staging order**, because R5 counts entry
   headers in the appended region and would see two if both entries were present
   at commit 1. So this volume is handed over containing **the header and this
   entry only**; `J-dv_lead-0111` is written and waiting at
   `<scratchpad>/J-dv_lead-0111.md`, to be appended verbatim
   (`cat … >> agents/journals/claude_dv_lead_agent.v04.md`) **after** commit 1
   has been created and **before** commit 2 is staged. The second
   `agent_commit.sh` invocation then passes `--entry J-dv_lead-0111`.
2. **This rotation is elective, not forced** (Reasoning §3). If the programme
   would rather rotations be taken only at `H`, that is a policy change and an
   ADR amendment, not a judgement call to be made silently one volume at a time.
3. Carried unchanged from `J-dv_lead-0109`: `run_i2_member`'s deliberate citation
   exception, still without a carrier; `WO-0058` bound 7 — **and it is paid in
   the next entry's packet, by M03-N2 rather than by M03-B4**; the
   `assert_following_frame_intact` / `assert_clean_frame_structure` merge;
   `WO-0061` §8 bound 1's `tkeep` half; **N-1**; the auditor's DV-escape ledger
   disposition on `BUG-0003`; family J behind a bench-capability round;
   `SO-xgmii_rx_64.md` unopened and **not offered**.

### Files-in-this-commit
- (none)

## [J-dv_lead-0111] 2026-08-05T19:15Z | task:WO-0065 | The family-B completion round drafted — and the bound the dispatch attributed to M03-B4 is paid by M03-N2 instead, which I could only find because the packet made me state what bound 7 wanted rather than which row it belonged to

### Trigger
Orchestrator dispatch, step 2 of a two-commit round: author `WO-0065`, the
family-B completion round, from my own queue read — M03-B4's member (b),
M03-B2's `/I/` members under note B-ii, M03-N2 as its own bounded unit, the
riding bench debts, and B-2/B-3 as acceptance bars rather than carried debts.
Executor tb_writer. No bench edits by me; the debts are the worker's edits under
the packet.

### Inputs
- `test/attack_plans/AP-xgmii_rx_64.md` at HEAD — §1's row grammar and its closed
  six-value status set, §3's stimulus legality, §4.B's four rows and **notes
  B-i, B-ii and B-iii** in full, §4.N's M03-N2 row, its two-route derivation, its
  **landed six-row cycle table**, defects M03-R1/M03-R2 and the closing
  no-unit note, §6's REQ-102 and REQ-110 entries.
- `docs/specs/requirements.md` — **REQ-102** (the third sentence, extensional),
  **REQ-105** (the zero-delivered clause and the already-closed clause),
  **REQ-107**, **REQ-110** (*"a start character in lane 4 leaves lanes 0 to 3 of
  that word belonging to the aborted frame"*), **REQ-113**, **REQ-018** (the
  link-partner contract, read limb by limb), REQ-016, §0.3, §0.5, §0.6, §0.7,
  **§2** (the five control-character codes).
- `docs/specs/modules/xgmii_rx_64.md` — **§6.2's `Preamble` row** (which names
  `/I/` **and `/Q/`**), **§6.1's landed table and consequence 1**, §9's nine-row
  table and its co-occurrence rulings, the **REQ-102 traceability row at
  `:1197`**, the port table at `:180`.
- `agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md` **§9 bounds 6 and 7
  verbatim**, and the FINDING GH-2 passage at `:636–675` where the **epoch
  vocabulary** is defined by the auditor's own disclosure.
- `agents/handoffs/WO-0062_tb-m03-family-b-preamble-and-sfd.md` in full — §1's
  queue read, §2's thirteen bars, §3's row form, §5's ten traps, §6.1's five
  bench notes, §6.2's three footnoted items, §7–§9 — as the house form.
- `test/xgmii/injection.mli` and `idle_injection.mli` in full;
  `test/xgmii_rx_64/bench.mli`, `bench.ml` (`delivered_samples` and its
  neighbourhood), `test_m03_b.ml` (the three landed runners and their titles),
  `test_m03_i.ml` (the five landed count notes and the guard-ordering note),
  `test_m03_h.ml` `:244–300` and `:476` (the standing cross-check depth),
  `test/xgmii_rx_64/dune`.
- `agents/journals/workers/claude_tb_writer_agent.v02.md` — entry titles only,
  for `J-tb_writer-0023`'s citation repairs and the volume's committed size.
- My own `J-dv_lead-0094` (the count-guard ruling and its two owed notes),
  `J-dv_lead-0100` (notes B-i/B-ii/B-iii as authored), `J-dv_lead-0105` (the
  frozen-seal collision rule), `J-dv_lead-0108`/`0109` (the many-to-many rule and
  the discharge-count correction).
- **No `libs/**`, no `rtl_snapshots/**`, no `docs/reports/audit/**`.** No RTL was
  opened at any point in this round.

### Reasoning

**1. The dispatch's own framing of member (b) is wrong on both halves, and the
instruction that exposed it is the instruction to state bound 7 *exactly*.** The
dispatch calls M03-B4 member (b) *"the in-word abort, the only candidate paying
`WO-0058` bound 7"*. Bound 7's words are: *"the in-word (epoch B/C) REQ-110 abort
… M03-H4's word `c` is the bench's only in-word abort, and only in the
nothing-open-on-entry form; **no unit drives an in-word abort with a frame
already open**."* Two conjuncts. Member (b)'s aborting `/S/` lands in **lane 0 of
the following word** — a word boundary, not in-word — so it has the *already
open* half and not the *in-word* half; member (a) has the *in-word* half and not
the other, because nothing was open when its word arrived. **Neither member of
M03-B4 pays bound 7**, which is what note B-i already says in the plan and what I
wrote there precisely so this could not be quietly re-attributed. Had I taken the
dispatch's framing and written "member (b) closes bound 7" into the packet, the
bound would have been marked closed by a stimulus that does not contain it, and
the instrument `WO-0058` §9 exists to preserve — bounds that stay countable —
would have lost a count without anyone editing a number.

**2. And the bound *is* paid this round, by the row nobody was looking at.**
Deriving M03-N2's six sub-cases against REQ-110's own sentence — *"a start
character in lane 4 leaves lanes 0 to 3 of that word belonging to the aborted
frame"* — makes the geometry fall out: in sub-cases 4 and 5 the aborting `/S/` is
in **lane 4** (mid-word, so in-word) and frame A delivers octets **in lanes 0 … 3
of W itself**, which A can only do if it entered W in `Frame` state (**already
open on entry**). Both conjuncts, by construction, twice over — and sub-case 6's
lane-4-start instance is a third, in the zero-delivered form, which I have made
the worker derive rather than asserting it myself because the two instances of
sub-case 6 split on a fact (`/S/` at A's preamble position 4 versus at A's octet
0) that depends on which start lane A took. **This is the most valuable thing the
round produced and it was not on anyone's list.** M03-N2 has been carried as an
unbenched row for its coverage value; the reason to write it turns out to be
partly a *bound* it closes, and that only became visible because the packet had to
state what bound 7 wanted instead of which row was supposed to pay it.

**3. `/Q/` is ruled DRIVEN, and the ruling is a correction against my own note.**
Note B-ii held `/Q/` as carried-and-not-driven pending one derivation: whether
REQ-018's link-partner contract admits it at an arbitrary preamble position. Four
grounds now say it does. (i) **SPEC-M03 §6.2's `Preamble` row names `/Q/` by
name** as an exit — *"any other control character in a preamble position — `/I/`
and `/Q/` included, which REQ-102's third sentence routes to REQ-105"* — and so
does the REQ-102 traceability row at `:1197`. A specification that fixes the
design's obligation on an input **has constrained that input**, so M03-O5's
prohibition (a bench asserting a fact about a space the specification does not
constrain) does not bite, and it was the only thing holding the sub-member.
(ii) REQ-018's limb (ii) — *"each condition named in … REQ-105"* — reaches it
through REQ-102's own composition, which §6.2 and the traceability row both
perform in terms. (iii) Read as a **closed** admission set, REQ-018 would refuse
M03-B3's `/T/` at position 5 and M03-B2's `/E/` at position 3, since no
requirement names either position, and both are committed green rows; the plan's
§3 draws exactly **one** prohibition from REQ-018 and it is about `/S/`'s lane.
(iv) **The fact I deferred on is not in any frozen spec of this programme.** Note
B-ii's ground was that a sequence ordered set is a four-character set — an 802.3
fact. `requirements.md` §2 defines `/Q/` as one of five per-lane control-character
codes and nothing more. **Deferring a stimulus the module spec names by name, on
the strength of a structural fact no frozen spec states, is deriving from outside
the specification** — which is the opposite failure from the one I was guarding
against, and it is mine.

I bounded the ruling in two directions rather than banking it. `/Q/`'s **marginal
kill over `/I/`** is stated and it is real: a design whose preamble routing is a
**closed code table** and which falls through on a code outside it — `/I/` cannot
see that, because a closed table would contain `/I/`. And what the member may
**not** claim is stated too: it drives a single control character at a named
preamble position, **not** an ordered set, so REQ-113's outside-a-frame ordered-set
case is untouched and belongs to M03-I3. The asymmetry is on the record as well —
`/I/` is admitted at **two** independent sites and `/Q/` at **one** — with the
disposition if architect_docs_lead reads REQ-018 as a closed list: `/Q/` becomes a
**declared gap naming that clause**, never silence, which is note B-ii's own word.

**4. The three riding debts were measured, and two of them had already
evaporated.** The dispatch's phrase was *"landing in this round or evaporating"*,
and the only honest way to settle that is a measurement, not a recollection.
(a) The three stale `RV-0059-VERDICT §8` citation sites were **repaired at
`WO-0063A`** (`J-tb_writer-0023`, `c00771f`): `grep -c` on `test_m03_i.ml` gives
**2**, and both survivors are the *keep-the-history, re-cite-the-rule* form the
repair was meant to produce. Nothing owed. (b) The guard-ordering note **landed**
at `test_m03_i.ml:447` over the four-guard cascade; nothing owed on that site.
(c) The count-blindness note landed at **five** call sites — but the half
`J-dv_lead-0094` named as *"definition at `bench.ml:222`"* **never landed**, and
`grep -c "by identity"` on `bench.ml` and `bench.mli` returns **0** at both. So
the debt is not paid and not evaporated: it is **half paid at the call sites and
unpaid at the definition**, which is the one place the next reader will meet the
instrument. Commissioned as a comment-only deliverable, and the reason is my own
banked rule firing a third time: **a rule belongs where the next pass will be run,
not where the last one was journalled** — the same move `tools/dv_checks.sh` got
one entry ago. Debt (b) also gets a forward obligation rather than a repair: the
note is **per-cascade, not per-file**, and this round adds cascades in two files
that carry none.

**5. A fourth debt, found while deriving §3.3, and it is the most dangerous one
in the tree for this packet.** `test/xgmii/injection.mli:33` and `:60–63` and
`test/xgmii/idle_injection.mli:64–77` still carry **the withdrawn gap-invariance
ground** (§7's per-octet constant, withdrawn as false at `SCR-M03-I4`,
`J-dv_lead-0085`) and **the withdrawn clause** that injection moves the two
lane-0-`/S/` rows *earlier*, widening their separation — re-based to **W** at
`1f3c04c`, countersigned `J-dv_lead-0086`, after which both reports move
**together**. The `idle_injection.mli` site is addressed, under its own heading,
*"because a bench driving **M03-N2** inside this wrapper needs it"* — i.e. it is
addressed by name to the reader this packet creates. I commissioned the repair as
comment-only, in the keep-the-history form, and **ran the frozen-seal collision
check first**, which is `J-dv_lead-0105`'s banked rule applied by its author for
the first time: the strings appear in **zero** `*SEALED*` files and in exactly one
packet (`WO-0033`, my own original machinery instruction), which is not edited.
Without that check the repair would have been instructed blind, and the last time
a sweep was instructed blind it nearly voided a scored campaign's seal.

**6. B-2 and B-3 are bars, not debts, and the difference is where the cost
falls.** On the **new** members they cost nothing, because the members are not
written yet — so the five-field-plus-`received` cross-check depth and the
non-byte-identical-frames rule are pass criteria with BOUNCE conditions behind
them. On the **landed** members they remain debts, because B-2's remedy is a
suite-wide deepening that needs a round which can run the suite and B-3's is a
**stimulus** change to green units whose messages are sealed into a closed
campaign. I did not promote either to a §2 standing obligation, for the reason
note B-iii already gives: §2 binds every M03 bench, and generalising a two-row
observation into a claim about seventy-eight rows I have not re-read for it is
the C-44 failure this plan records against me twice.

**7. Two measurements corrected inside the packet, both against my own
artefacts.** First: `AP` §4.N says M03-N2 *"is named 17 times in this plan"*; the
tree gives **25 lines / 26 occurrences**, because the 17 was measured **before**
the same round's own edits added §4.N's closing note and §6's two entries. A count
taken at one state and published about another — the third incident of that
pattern in three entries, and the third time it is mine. The packet cites the
measurement and forbids the 17. Second: note B-2 cites `test_m03_h.ml:307`/`:539`
for the standing cross-check depth; those are **pre-`WO-0064` line numbers**, and
the sites are now `:244–256` and `:476`. The described fact is unchanged, so the
packet carries the fact with measured line numbers and flags the stale ones rather
than quoting them. **Both plan corrections are dv_lead's to land and they ride the
`RV-0065` round**, because this commit may stage only the packet.

**8. The unit's home is a new file, and the ground is a mistake this programme has
already paid for.** M03-N2 goes in a new `test/xgmii_rx_64/test_m03_n.ml`, not
into `test_m03_b.ml`: family N has no file and N1/N4 are also outstanding; the
`dune` stanza is a `library` with `(inline_tests)` and **no `modules` field**, so
a new module needs no machinery change; and filing a row under another family's
file is how `M03-M10` came to share `M03-B3`'s `%expect_test` title, which is
exactly why `WO-0063B-VERDICT` §9 item 1.1 attributed the discharge count's move
to the wrong cause. **A row filed under another family's title is a row a
mechanical census miscounts**, and I have the census to prove it.

**9. What I refused to widen.** The `/E/` variant of M03-N2's second closure
character is **earned and not commissioned**, footnoted on the `WO-0058`/`WO-0061`
§12 precedent: it buys no REQ-105 coverage the suite lacks and it creates no
SPEC-M03 §6.3 item 8 instance either, because B's strobe merely changes name.
That last point is stated as a prohibition in the packet as well — **no sub-case
in this round produces a same-name, same-cycle coincidence**, so the §6.3 item 8
carve-out stays untested and no comment or message may claim otherwise. The
forward discharge figure (42 → 43) is published as **derived, not measured**, with
the verdict instructed to re-measure it from the tree — my own correction from one
entry ago, applied forward instead of re-stated.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since the note at `J-dv_lead-0110`: **J-dv_lead-0111** (this entry);
cumulative untiled span **J-dv_lead-0001 … 0111**, first harvest still firing at
`SO-M03`.

- **All nine banked candidates carry, and two were USED rather than re-cited.**
  `J-dv_lead-0108`'s LH2-g (*a rule belongs where the next pass will be run*) is
  what §6.1 debt 2 makes mechanical at the definition site; `J-dv_lead-0105`'s
  extended observable (*before instructing an edit to a string, establish whether
  that string is quoted by any frozen artefact*) was run **by its author, for the
  first time, before instructing three string repairs** — and it cleared, which is
  worth recording beside the incidents where its absence cost something. Both gain
  this commit as an LH1 incident; neither observable changes.
- **`J-dv_lead-0106`'s LH2-g gains a FOURTH incident and it is mine again**: the
  `17` in §4.N. Three quantities in this programme have now moved on measurement
  after being published from derivation or from a pre-edit state — a convicting
  set, a discharge count, and now a name-count in a document about itself. The
  candidate's observable is behaving exactly as stated and it does not need a
  sibling.
- **One new candidate banked.** *"A bound stated as a conjunction is discharged
  only by a stimulus containing every conjunct; a candidate matching one conjunct
  is evidence that the bound is still open, not that it is nearly closed."*
  **LH1**: this commit — the dispatch's attribution of a two-conjunct bound to a
  stimulus holding one of them, and the discovery of the true payer three
  sections later. **LH2-g** — no proper noun in the rule. **LH3**: without it, a
  register of open limitations closes entries by resemblance, and the limitation
  survives in the artefact while disappearing from the register — which is worse
  than never having registered it, because the register is what a reviewer reads.
- **Both war stories carry unchanged.** None retired, none promoted.

### Actions
- Drafted `agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md`: the
  queue read; the standing bars carried from `WO-0062` §2 with five restated;
  three row sections (M03-B4 member (b) with note B-i's arithmetic re-derived as a
  two-column comparison; M03-B2's `/I/` and `/Q/` members with the discrimination
  argument stated per character; M03-N2's six sub-cases with the landed cycle
  table, a bound-7 column added to it, a worked placement for sub-case 4 and a
  new-file ruling); a risk ranking that is the review order; **twelve sealed
  derivation traps T1–T12**; §6.1's four measured debts with two declared
  evaporated; §6.2's three earned-not-commissioned items; the deliverables and
  return form including the worker's journal-volume facts; **eleven pass criteria
  with B-2 and B-3 as bars 3 and 4**; **twelve pre-committed BOUNCE conditions**;
  and §10's five things the packet does not close.
- Ruled note B-ii obligation 1 (`/Q/` position legality) **in the packet**, with
  the four grounds, the two bounds on the claim and the reversal disposition.
- Measured all four bench debts at HEAD before writing a word about any of them,
  and ran the frozen-seal collision check on the strings the packet instructs an
  edit to.
- Corrected two of my own committed figures inside the packet (§4.N's `17`; note
  B-2's stale line numbers), naming the round that owes each plan edit.
- **No bench file, no plan file and no spec file was edited.** This round produces
  one packet.

### Evidence
```sh
# Debt 1 -- EVAPORATED (repaired at WO-0063A / c00771f)
grep -c "RV-0059-VERDICT §8" test/xgmii_rx_64/test_m03_i.ml          # 2
grep -n  "RV-0059-VERDICT §8" test/xgmii_rx_64/test_m03_i.ml         # :49, :1328
#   both cite SPEC-M03 §6.1's D(m) (`1f3c04c`) as the RULE and name the
#   verdict as HISTORY -- the form the repair was meant to produce

# Debt 2 -- call sites PAID, definition site UNPAID
grep -n "Owed bench note (i)"  test/xgmii_rx_64/test_m03_i.ml
#   314, 489, 1055, 1493, 2030   (five call sites carry the caveat)
grep -c "by identity" test/xgmii_rx_64/bench.ml test/xgmii_rx_64/bench.mli
#   bench.ml:0   bench.mli:0     <- the definition says nothing

# Debt 3 -- PAID at its landed cascade
grep -n "Owed bench note (ii)" test/xgmii_rx_64/test_m03_i.ml        # 447

# Debt 4 -- the three stale doc sites, and the seal check on them
grep -n "gap-invariant" test/xgmii/injection.mli                     # 33, 60
grep -n "moves the two lane-0\|move {b earlier}" test/xgmii/injection.mli \
        test/xgmii/idle_injection.mli                                # i:61, ii:69
grep -rln "injection moves the two lane-0" agents/handoffs/*SEALED*  # (no output)
grep -rn  "injection moves the two lane-0" agents/handoffs/ | grep -v WO-0065
#   agents/handoffs/WO-0033_dv-machinery.md:10   <- one packet, no seal

# M03-N2 has no unit, from two independent directions (re-verified at HEAD)
grep -rn "M03-N2" test/ --include=*.ml --include=*.mli | wc -l       # 3, all test/xgmii/
grep -c  "M03-N2" test/attack_plans/AP-xgmii_rx_64.md                # 25 lines (26 hits)
#   ^ the plan's own §4.N sentence says 17; that figure predates the same
#     round's edits and is owed a correction at RV-0065

# The standing cross-check depth B-2 measures against, at HEAD
grep -n "Injection.outcomes" test/xgmii_rx_64/test_m03_h.ml          # 244, 476
#   both compare `delivered` + `reports` only -- two fields, not six

# WO-0058 bound 7, quoted into the packet from the packet, not from memory
grep -n "in-word (epoch B/C)" agents/handoffs/WO-0058_m03-g7-h-mutation-campaign.md # 807

# tb_writer's journal facts stated in the packet's dispatch note
git show HEAD:agents/journals/workers/claude_tb_writer_agent.v02.md | wc -c  # 109462
git show HEAD:agents/journals/workers/claude_tb_writer_agent.md    | wc -c   # 263033 (v01, FROZEN)

git status --porcelain
#  ?? agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md
#  (the journal volume is the only other path; no test/, tools/ or docs/ edit)
```
**Not run**: `dune build`, `dune runtest` — no Hardcaml toolchain in this
container (ADR-0005); CI is authoritative. This commit stages **one markdown
packet** and no code, so no test could speak to it; every figure in the packet is
labelled a derivation for the worker to check, and the four measurements above
are the only claims made as facts.

### Outcome
DoD met. `WO-0065` drafted for tb_writer, carrying: three commissioned items
(M03-B4 member (b), M03-B2's `/I/` **and `/Q/`** members, M03-N2's six
sub-cases in a new file), twelve sealed traps, twelve pre-committed BOUNCE
conditions, and B-2/B-3 as pass **bars** on the new members. **Two rulings made
rather than deferred**: `/Q/` is driven, discharging note B-ii obligation 1 with
its reversal disposition stated; and `WO-0058` **bound 7 is paid by M03-N2's
lane-4-`/S/` sub-cases, not by M03-B4 member (b)** — a correction against the
dispatch's own framing, derived from the bound's two conjuncts and REQ-110's
lane-4 sentence. **Four debts measured, two declared evaporated, one commissioned
at its definition site, one newly found and commissioned** with its frozen-seal
check run first. **No row added, converted or re-statused; no bench, plan or spec
file touched.** No `SO-xgmii_rx_64.md` issues and none is offered — 20 ASSERT rows
outstanding and the verilog-ethernet anchor undischarged. Handoff:
`agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md`, for the
orchestrator to issue to tb_writer.

### Open-questions
1. **`AP-xgmii_rx_64.md` owes four edits when this work lands, all mine and all
   at the `RV-0065` round**: §4.B's B4 and B2 cells (member (b) and the `/I/`
   `/Q/` members marked driven), note B-ii obligation 1 discharged with §3.2.1's
   ruling, §4.N's closing note and §6's **two no-coverage marks struck**, plus the
   `17` corrected to the measurement and a §9 change-log row. **Not in this
   commit** — the round's write scope is the packet.
2. **M03-N2's two prohibitions stay in force until the unit LANDS**: no `SO-` may
   cite it as coverage of REQ-102 or REQ-110, and no campaign may place it in a
   denominator. Issuing the packet lifts nothing.
3. **The `/Q/` ruling is mine and is reversible by architect_docs_lead.** If
   REQ-018 limb (ii) is a closed list keyed on each requirement's literally-named
   conditions, `/Q/` converts to a declared gap naming that clause; `/I/` survives
   that reading on its second site. I have not escalated it, because the module
   spec names `/Q/` in the `Preamble` row and that is a derivation, not a dispute.
4. **SPEC-M03 §6.3 item 8's carve-out remains untested after this round** and the
   packet says so in terms. A same-name, same-cycle coincidence is not
   constructible from M03-N2's stimulus at any sub-case; whether any stimulus
   constructs one is a question I have not answered and it belongs with the round
   that opens family M.
5. Carried unchanged from `J-dv_lead-0110`: `run_i2_member`'s deliberate citation
   exception, still without a carrier; the `assert_following_frame_intact` /
   `assert_clean_frame_structure` merge; `WO-0061` §8 bound 1's `tkeep` half;
   **N-1**; the auditor's DV-escape ledger disposition on `BUG-0003`; family J
   behind a bench-capability round; **B-4**'s stale forward reference in
   `test_m03_h.ml`'s docstring, which this round explicitly does not carry.
   **`WO-0058` bound 7 leaves this list** the moment `WO-0065` lands green — it is
   commissioned, not carried, for the first time since it was opened.

### Files-in-this-commit
- agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md

## [J-dv_lead-0112] 2026-08-05T21:40Z | task:WO-0065 | RV-0065 BOUNCED on three of eleven members — and the flagship sub-case fails because a guard asserts the absence of the coincidence the row exists to record, which my own twelve pre-committed conditions would not have caught if it had failed silently

### Trigger
Orchestrator spawn: review tb_writer's `WO-0065` execution at `88413b9`
(11 members, 4 comment-only debt repairs), issue `RV-0065-VERDICT`, and land the
four plan edits my own `J-dv_lead-0111` §(f)1 deferred to this round with write
scope open.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` §4, §4.2, §5, §6, §10.
- `agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md` — the whole
  packet: §2 bars, §3.1/§3.2/§3.2.1/§3.3, §4 ranking, **§5's twelve traps**,
  §6.1's four debts, §7, **§8's eleven pass criteria**, **§9's twelve BOUNCE
  conditions**, §10, and tb_writer's Return log (a)–(g).
- `git show 88413b9` in full: `test/xgmii_rx_64/test_m03_n.ml` (new, 534 lines),
  `test_m03_b.ml`, `bench.ml`, `bench.mli`, `dune`, `test/xgmii/injection.mli`,
  `test/xgmii/idle_injection.mli`.
- Spec, read **before** the return's constants: `docs/specs/requirements.md`
  §0.6 in full (the strobe window, its reference word, all three clauses, the
  bound-never-a-licence note, C-23), §0.3, §0.5, §0.7; REQ-102, REQ-105, REQ-107,
  REQ-110, REQ-113, REQ-018, REQ-101, REQ-008, REQ-011, REQ-103, REQ-104.
  `docs/specs/modules/xgmii_rx_64.md` **§9 in full** (the nine-row table, the
  closure list, clauses (a)/(b), the non-normative closure-record note, the
  pinned-strobe-cycle paragraph and its withdrawn gloss, the no-terminate
  reference word), §6.1's D(m) at `1f3c04c`, §6.2's `Preamble` row, §6.3 items 3
  and 8, §7, §10, the REQ-102 traceability row at `:1197`, §13's change rows for
  `a77017c` / `1f3c04c` / F-1.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.B rows + notes B-i/B-ii/B-iii, §4.N's
  closing note, §6's REQ-102/REQ-110 rows, §9's last two rows.
- `test/xgmii/arrival.ml:150–174` (standing obligation 5's checks),
  `test/xgmii/injection.ml:228, 309` (`outcome.abort`'s definition),
  `test/xgmii_rx_64/bench.ml:237–240` (`error_pulses`), `bench.mli`'s accounting
  contracts, existing accounting call sites across `test_m03_a` … `test_m03_i`.
- `J-dv_lead-0109`, `J-dv_lead-0111` (my own prior rulings and the count method).
- **CI, read directly and not inferred**: `build` run **`30961544649`** and
  `journal-check` run **`30961544680`**, both at `88413b9`, and the failing
  job's full log.
- **No `libs/**`, no `top/**`, no `rtl_snapshots/**`, no
  `docs/reports/audit/**`** was opened (PROTOCOL §10, charter §3).

### Reasoning

**1. The verdict is BOUNCE, and CI said it before I finished saying it.** I
derived the sub-case-4 defect by reading `run_subcase` against the packet's own
table — the delivered branch opens with `if c1 = c2 then fail "…unexpectedly
coincide…"`, and sub-case 4 is a delivered sub-case whose two reports **do**
coincide at cycle 4 — and only then pulled the CI log, which carries that exact
`failwith` string. Two independent routes to the same defect. The log also
carried a **second** defect I had not derived: sub-cases 3 and 6 declare a
**3-octet** array (`array_len = sc.t_idx + 1`, `t_idx = 2`) and
`Arrival.check`'s five-octet rule refuses the schedule before a cycle is driven.
**Three of eleven members raise; the other eight are green and family B is
complete.**

**2. Both defects sit on top of arithmetic that is entirely correct, and that is
the finding worth carrying.** I re-derived every figure from §0.5/§0.6 and §9
before reading the return's constants: all six sub-case tuples, both B4 members'
eight figures, B2's four members' figures. **Every one agrees.** The
`(last_in + L)/8` pin for the delivered sub-cases reproduces §4.N's W+1/W+2
column at all four; the zero-delivered pin is §9's own no-output-word clause;
the window function is §0.6's three clauses written out. **The worker derived
right and encoded wrong**, in the one member that could least afford it — sub-case
4 is the plan's minimal witness for M03-R1 and the first payer of bound 7. That
is a much cheaper failure to fix than the reverse, and the BOUNCE should say so
rather than reading as a judgement on the round.

**3. Why I did not repair it myself.** `test/**` is my scope and the fix is small
— delete three lines, widen one array. But **this seat cannot run the suite**
(ADR-0005: no Hardcaml toolchain), so a repair by me would be an unverified fix
to a flagship member handed back as if reviewed, which is precisely what I bounce
workers for. The defects return with `file:line`; CI is what will say they
worked. I did make one **stated** consistency repair, in the plan and not the
bench: B2's Observable cell said "Members (a) and (b)" while the row now has
three.

**4. The promotion question, answered in the log rather than from the shape of
the failure.** The run prints a `PROMOTION BLOCK` and it must **not** be acted
on. The three corrected hunks are `[%expect.unreachable]` +
`[@@expect.uncaught_exn {| (Failure "…") |}]` with backtraces — raised
exceptions, not printed tables. Promoting them would bake three failure messages
into the expect blocks and turn a red suite green with the defects intact. I
stated the house rule this instantiates, because it will be needed again: **a
`.corrected` carrying `expect.uncaught_exn` is never a promotion candidate; a
promotion candidate is printed data, an uncaught exception is a verdict.**

**5. A gap in my own pre-commitment, and I am recording it against myself rather
than letting condition 12 look like foresight.** None of my twelve BOUNCE
conditions names *"a member that fails a conforming design"*. Condition 12
("unpromoted expect drift") catches this only because a raised `failwith`
happens to produce a `.corrected` file — a **mechanism**, not the defect. Had
these three members failed *silently* — a vacuous guard rather than a raising
one — twelve pre-committed conditions would have returned zero and I would have
ACCEPTed. The twelve were written to stop me writing the verdict to fit what
arrived; they did that, but they were not a coverage claim and I should not have
let them read as one.

**6. The sub-case-6 split, verified independently in both limbs, because bound
7's closure rides on it.** At a lane-0 start, preamble positions 1…7 are lanes
1…7 of A's **own** start word, so `At_preamble 4` reaches lane 4 **inside the
word A opened** — nothing open on entry, no bound-7 payment — and it is the only
placement reaching lane 4 at zero delivered. At a lane-4 start, positions 1…7 are
lanes 5,6,7 of word 1 and lanes 0…3 of word 2 — **no preamble position reaches
lane 4 at all** — so `At_octet 0` (octet time 20, lane 4 of word 2) is the only
route, with A open since word 1: **in-word, already open, bound 7 paid.** The
worker's derivation is correct in both limbs. **One distinction it does not
draw and the seal must**: at sub-cases 4 and 5 A is in `Frame` state on entry, at
sub-case 6 in `Preamble` state. §9's closure list makes both *open*, so all three
satisfy bound 7 — but "three instances" without that split is a count, not a
coverage, and I have already been caught once this programme generalising over a
table that did not support it.

**7. BAR B-2's `abort`, ruled by entailment rather than by counting
expressions.** `injection.ml:309` defines `abort = delivered > 0 && strobes <>
[]`, so asserting `reports = []` on a clean following frame **entails**
`abort = false` by construction. The bar is a requirement about **what the
member pins**, not about how many comparisons it writes. No defect against
`run_b4` is opened — the worker was right to ask rather than to deepen a landed
member, and right that it could not have deepened it without touching what §7
item 1 froze.

**8. The `_piece`/`_frame` naming axis is incomplete, and the correction is
mine.** Frame A in `test_m03_n.ml` **has** a genuine `Arrival.frame` record, so
`account_forwarded_piece` reads as an axis violation. It is not:
`account_clean_frame` would feed `Latency.frame_in` the **whole declared array's**
input times while A received only 4 or 8 octets, with no `?expected_octets`
override — and `~received`-honesty is the precondition that actually carries
weight. The axis has **no cell** for *a genuine record whose received extent is
shorter than its declared array*, which is what every REQ-110-aborted declared
frame is. A `bench.mli` documentation debt, mine, not this round's; no code
moves.

**9. Three of my four plan edits landed as commissioned; the third landed as its
own escape clause.** `J-dv_lead-0111` §(f)1 pre-authorised striking §4.N's
closing note and §6's two no-coverage marks **"subject to your review verdict"**,
and the verdict is what stopped it. `WO-0065` §10 holds the prohibitions *"until
the unit LANDS"*, and **a red unit has not landed**. But leaving the marks
untouched would have left them **false on their face** — a unit now exists — so
they are **re-grounded**, from *"has no unit"* to *"benched and not green"*, with
both §6 rows naming exactly what strikes them. That is the same
keep-the-history-replace-the-ground pattern the debt-4 repairs used, applied to
my own text.

**10. The count is right, its cause is right, and the method has a defect I
found by running it twice.** `WO-0065` §10 published 42 → 43 as *derived, not
measured* and told this verdict to re-measure. Measured at both ends: **42** at
`88413b9^`, **43** at `88413b9`, and the parent reproduces `J-dv_lead-0109`'s
outstanding list of twenty **row for row** — which is what licenses the new
figure rather than merely agreeing with it. The whole +1 is M03-N2. **First time
in four attempts that a forward figure's number and its cause both held.** Two
things ride with it. (a) **43 is not earned**: the census counts **titles, not
passes**, and M03-N2's are red, so the *effective* figure is **42**; both are
carried in §4.N so no later reader has to choose. (b) **My first pass returned
44**, because a naive substring match discharges **`M03-M1` on `M03-M10`'s
title** — the `M03-M10`/`M03-B3` shared-title problem biting from a **third**
direction, and this time it was mine. Boundary-matched row ids are commissioned
into `tools/dv_checks.sh` with the campaign packet; a review commit is not where
tooling changes belong.

**11. What I commissioned.** `WO-0065B` as a **revision**, scoped to
`test_m03_n.ml` alone — everything else in `88413b9` is accepted and frozen — with
the two defects, three fold-ins (B-2's shortfall on `oa`'s
`words`/`last_tkeep`/`tlast_cycle`; §4.N row numbers in the titles; optionally A's
delivered content), and an explicit instruction that the `row` strings passed to
`fail` do **not** move, because campaign seals are written against them. On green:
the family-B/N campaign packet + seal in one commit, bound 7 **scored** with its
three instances' shapes distinguished; and **family J gets a date** — the round
immediately after that seal, on my own two-deferral rule, with an E2 required
before it slips a third time.

### Actions
- Line-reviewed all eleven new members and all four comment-only debt repairs.
- Re-derived every figure from spec text before reading the return's constants;
  compared; recorded agreement.
- Verified BOUNCE 9 **mechanically**: nesting-aware comment-stripped comparison
  of `88413b9^` vs `88413b9` for `bench.ml`, `bench.mli`, `injection.mli`,
  `idle_injection.mli`, `dune` — all five code-identical.
- Read CI runs `30961544649` (build, **failure**) and `30961544680`
  (journal-check, success) and the failing job's full log.
- Appended **`RV-0065-VERDICT`** (BOUNCE) to
  `agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md`.
- Landed the four owed edits in `test/attack_plans/AP-xgmii_rx_64.md` (§4.B two
  cells, note B-ii obligation 1, §4.N + §6's two marks re-grounded, the 17 → 25/26
  correction) and one §9 change-log row.

### Evidence
- **CI at `88413b9`**: `build` run **`30961544649`** → `completed` / **`failure`**;
  `journal-check` run **`30961544680`** → `completed` / `success`. Failing job
  `92166342111`.
- **The three failures, from the log**: `M03-N2 (S lane 4, A lane 0, delivered):
  frame A and frame B's reports unexpectedly coincide in this sub-case`
  (`test_m03_n.ml:440`, from `:513`); and, twice, `Bench.run: Arrival.check found
  an unconformant schedule (standing obligation 5): frame 0 carries 3 octets; a
  frame below five octets delivers nothing (REQ-107) and is an injection case,
  not a schedule case` (`bench.ml:180` via `test_m03_n.ml:370`, from `:503` and
  `:532`). Only `test_m03_n.ml` produced a `.corrected`.
- **PROMOTION BLOCK, recorded and NOT to be promoted**:
  `test/xgmii_rx_64/test_m03_n.ml`, sha256
  `0df912b17bba38a53083a2d6971dfa8d8169ee471522ae26e5ecfee54fcd7252`.
- **Comment-stripped protected-file check** (runnable from a checkout): strip
  OCaml comments with nesting and string-literal handling from
  `git show 88413b9^:<f>` and `git show 88413b9:<f>`, normalise whitespace,
  compare — **identical** for `test/xgmii_rx_64/bench.ml`, `bench.mli`,
  `test/xgmii/injection.mli`, `test/xgmii/idle_injection.mli`, and (with `;`
  lines dropped) `test/xgmii_rx_64/dune`. `test_m03_b.ml`'s only deleted line in
  the whole diff is `   case). *)`.
- **Name-count, measured twice at `88413b9`**:
  `grep -c "M03-N2" test/attack_plans/AP-xgmii_rx_64.md` = **25**;
  `grep -o "M03-N2" test/attack_plans/AP-xgmii_rx_64.md | wc -l` = **26**.
  (`grep -rn "M03-N2" test/ --include=*.ml --include=*.mli` = **18**, was 3.)
  **And at the tree this commit hands back — because the commit correcting the
  count adds names, which is the trap itself, one turn later**: **29** lines /
  **33** occurrences, re-measured after the last edit and stable. §4.N carries
  both figures with both states; neither is written without its SHA.
- **Bench inventory, reproduced independently of the return**: `%expect_test`
  titles under `test/xgmii_rx_64/` **39 → 48** (+9); repository-wide
  **119 → 128** (+9).
- **Discharge count, `J-dv_lead-0094` titles method, both ends** — 48 titles
  under `test/xgmii_rx_64/`, 43 distinct plan rows named, − `M03-A4`
  (NO-ASSERT in a title), + `M03-F5` by citation (`test_m03_f.ml:809`) =
  **43 of 62** at `88413b9`; the same procedure at `88413b9^` returns **42 of
  62** with outstanding = `M03-J1…J3, K1, K2, L1…L5, M1…M7, N1, N2, N4`,
  reproducing `J-dv_lead-0109` exactly. Outstanding at HEAD is that list minus
  `M03-N2` (**19**). **Row ids must be matched with a trailing-digit boundary**:
  a substring match discharges `M03-M1` on `M03-M10`'s title and returns 44.
- **`Injection.outcome.abort`** is `delivered > 0 && strobes <> []`
  (`test/xgmii/injection.ml:309`); **`error_pulses`** is a `concat_map` over
  samples (`test/xgmii_rx_64/bench.ml:237–240`), so two strobes on one cycle
  yield two entries with equal cycles; **`Arrival.check`** refuses frames under
  five octets (`test/xgmii/arrival.ml:161–167`).

### Outcome
**BOUNCE**, on pre-committed condition **12**, with two defects at `file:line`
and eight of eleven members accepted. `WO-0065`'s DoD is **partially met**:
§8 criteria 2, 5, 6, 7, 8, 9, 10, 11 met; **criterion 1 (all members green, no
unpromoted drift) failed**; criteria 3 (B-2) and 4 (B-3) met on the members they
name, with one recorded shortfall on `test_m03_n.ml`'s frame A. All four
comment-only debts (§6.1 debts 2 and 4) **accepted as landed**. My four owed
plan edits are **landed**, the third as a **re-grounding rather than a striking**
— the verdict is what stopped it. Handoff: `RV-0065-VERDICT` in
`agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md`; the respawn is
`WO-0065B`, scoped to `test_m03_n.ml` alone, for the orchestrator to issue.

### Open-questions
1. **`WO-0065B` is drafted inside the verdict (§12) and not as its own packet
   file** — the orchestrator allocates its id and issues it. If it wants a
   standalone packet I draft one on request; the scope, the two defects and the
   three fold-ins are already stated in terms.
2. **`bench.mli`'s `_frame`/`_piece` naming axis has no cell for a genuine
   `Arrival.frame` whose received extent is shorter than its declared array** —
   every REQ-110-aborted declared frame. A documentation debt, **mine**, riding
   the next round that opens `bench.mli`. No code moves.
3. **`tools/dv_checks.sh`'s census must match row ids with a trailing-digit
   boundary** (`M03-M1` vs `M03-M10`). Commissioned into the campaign packet,
   deliberately not landed in a review commit.
4. **Family J is now DATED** — the round immediately after the family-B/N
   campaign seal, on my own two-deferral rule. A third deferral is an **E2** to
   the orchestrator with the cost named, not a footnote.
5. Carried unchanged from `J-dv_lead-0111`: `run_i2_member`'s deliberate
   citation exception; the `assert_following_frame_intact` /
   `assert_clean_frame_structure` merge; `WO-0061` §8 bound 1's `tkeep` half;
   **N-1**; the auditor's DV-escape ledger disposition on `BUG-0003`; **B-4**'s
   stale forward reference in `test_m03_h.ml`'s docstring. **`WO-0058` bound 7
   does NOT leave the list this round** — `J-dv_lead-0111` said it would "the
   moment `WO-0065` lands green", and it did not land green. It stays,
   commissioned, until the respawn is scored.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since `J-dv_lead-0111`'s note: **J-dv_lead-0112** (this entry); cumulative
untiled span **J-dv_lead-0001 … 0112**, first harvest still firing at `SO-M03`.

- **`J-dv_lead-0111`'s new candidate gains its first confirming instance from the
  other side.** *"A bound stated as a conjunction is discharged only by a
  stimulus containing every conjunct"* — sub-case 6 satisfies both conjuncts on
  a **third** shape (`Preamble`-state on entry, not `Frame`-state), and the seal
  now has to say which shape each instance is. The candidate's observable is
  unchanged; it gains this commit as an LH1 incident.
- **`J-dv_lead-0106`'s LH2-g gains a FIFTH incident, and for the first time the
  candidate fires in the direction of a false POSITIVE.** Every previous incident
  was a published figure that measurement moved **down** or **corrected**. Here
  measurement moved a figure **up** — my first census pass returned 44 because
  `M03-M1` matched inside `M03-M10` — and the wrong number would have **retired an
  outstanding row**. The observable holds unchanged; recording the direction
  because a candidate only ever seen failing one way gets read as a rule about
  that way.
- **One new candidate banked.** *"A list of pre-committed reject conditions is a
  guarantee about the reviewer's independence, never a claim of coverage; before
  citing one as met, name the defect class it would have MISSED."* **LH1**: this
  commit — twelve conditions caught three raising members only via the
  `.corrected` file a `failwith` happens to produce, and would have returned zero
  had the same three members failed silently. **LH2-g** — no proper noun in the
  rule; it binds any pre-commitment list, mine or a campaign seal's. **LH3**:
  without it, a pre-commitment list is read as an audit of the work rather than
  an audit of the reviewer, and its silence is taken as evidence of absence —
  which is the exact inference `WO-0058` §8's weighting paragraph forbids about
  mutation denominators, unnoticed one level up.
- **Both war stories carry unchanged.** None retired, none promoted.

### Files-in-this-commit
- agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md
- test/attack_plans/AP-xgmii_rx_64.md
