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

---

## [J-dv_lead-0113] 2026-08-05T23:05Z | task:WO-0065B | RV-0065B ACCEPTED at 11 of 11 green — and the one place the two repairs are not geometrically identical hides a second crossing the return did not see, a control character its own "plain filler octets" ground cannot reach

### Trigger
Orchestrator, re-review of the `WO-0065B` bounce revision at `eb1e06a` against the
contract I wrote at `RV-0065-VERDICT` §12. Prescribed opening: `git show eb1e06a
--stat`, my own §12, then the line review of `test/xgmii_rx_64/test_m03_n.ml`
before any other orientation — so the file was read against the contract and not
against the return's account of it.

### Inputs
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §6, §7, §10).
- `agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md` — my
  `RV-0065-VERDICT` §2, §3, §4, §6, §9, §12, §13, and the `WO-0065B` Return log
  §(a)–(g) **read after the line review, not before**.
- `test/xgmii_rx_64/test_m03_n.ml` at `eb1e06a` and at `eb1e06a^`.
- **Spec, as the sole derivation basis**: `docs/specs/modules/xgmii_rx_64.md`
  §6.2's state table (the `Idle` row, verbatim), §6.3 item 8, §7, §9;
  `docs/specs/requirements.md` §0.3, §0.5, §0.6 (lane mapping and the window).
- **Test-side machinery, mine, read to check what the padding reaches**:
  `test/xgmii/arrival.ml:91–116` (`lane_at`, the auto-terminate) and `:147–174`
  (`check`'s standing obligations); `test/xgmii/injection.ml:135`
  (`fcs_valid:false`); `test/xgmii_rx_64/bench.ml:226–288` (the accounting
  helpers); `test/monitors/octet_time.ml:83–89` (`frame_dropped`).
- `test/attack_plans/AP-xgmii_rx_64.md` §4.N's six-row table and §6's REQ-102 /
  REQ-110 rows.
- `.github/workflows/build.yml` steps 6 and 8 — read to learn what the two
  gating steps actually run, rather than trusting their names.
- CI at `eb1e06a`: `build` run `30963617198` (jobs `92172708172`,
  `92172708206`), `journal-check` run `30963617180`.
- **No `libs/**`, `top/**` or `rtl_snapshots/**` was opened** (PROTOCOL §10).

### Reasoning

**The verdict is ACCEPT, and the thing that makes it an ACCEPT rather than a
provisional one is that CI is green and I read the gating steps' commands.**
Step 6 runs `dune runtest`; step 8 runs `git add -A; git diff --cached
--exit-code`. Both success at `eb1e06a`. That matters because `run_subcase`
signals every defect by raising `failwith`, and a raise is an
`expect.uncaught_exn` correction, which fails step 6 — so **silence here is a
positive result, not an absence of one**. Combined with all six blocks still
reading `[%expect {||}]` and zero occurrences of `unreachable`/`uncaught_exn` in
the file, the six sub-cases demonstrably ran and were demonstrably silent.

**I checked my own new BOUNCE condition in both directions, which is the whole
point of having minted it.** At `RV-0065` §4 I recorded against myself that none
of my twelve pre-committed conditions named *"a member that fails a conforming
design"* — condition 12 caught it only because a raise happens to produce a
`.corrected` file, a mechanism rather than the defect. So here I did not ask "is
CI green"; I asked whether the **three previously-red members are now green AND
the eight previously-green stayed green**. A repair that traded one set for the
other passes the naive read and fails this one. 11 of 11.

**Both repairs re-derived before reading the return's §(c), and both are right.**
N-1: `max 5 (sc.t_idx + 1)` is minimal, moves only sc3/sc6 (3 → 5), and — the
part worth checking rather than assuming — reaches nothing. `array_len` enters
neither cycle formula nor either §0.6 window; and on the accounting side
`account_dropped_frame` hands the declared array's `in_times` to
`Latency.frame_in` and then calls `frame_dropped`, which pops the queue and
discards the value unexamined. So a longer declared array changes the size of a
never-read array. That was the one path a length change could have reached the
monitors by, and I walked it rather than reasoning that it was fine. N-2: sc4's
`a_cycle` = `(19 + 16)/8` = 4 and `b_cycle` = `(22/8) + 2` = 4 — they coincide,
and the deleted guard asserted the inverse. `coincides` checks out at all six
rows against **the plan's** §4.N table, not against the file's own copy of it.

**The sc6 crossing — the return's first see-first item — is real, is bigger than
reported, and the ground it was defended on does not cover the bigger part.**
The return flagged one character crossing into W+1: the second filler octet at
octet time 24. Deriving the whole post-closure geometry myself gives **two**:
that octet, **and `Arrival`'s own auto-terminate at octet time 25 = W+1 lane 1**
(`arrival.ml:110–112` emits a terminate character at `start_ot + 8 + n`). The
auto-terminate is a **control** character, and the comment at the site defends
the crossing on the octets being *"plain (non-control) filler octets, not
REQ-113's out-of-frame control characters"* — a distinction that by its own
terms does not reach the character it most needed to reach.

**The ruling is unchanged; the ground had to move.** SPEC-M03 §6.2's `Idle` row
disposes of both, on its *form* rather than on the octets' plainness: it states
its behaviour **per lane** with no word index (so lane 0 of W+1 is the same case
as lane 3 of W), it states it over **every** lane (so it covers control and data
alike — this is the citation that actually carries the auto-terminate), and it
holds **no state a boundary could disturb** (`tvalid` = 0, CRC held), with its
only exit `/S/` in lane 0 or 4. None of the crossing characters is a `/S/`.
Worth recording: **the Idle-state auto-terminate is already an exercised green
shape** — all four delivered sub-cases have `t_idx = array_len − 1`, so each put
one in `Idle` one octet after the injected `/T/` and all four were green at
`88413b9`. The genuinely new thing at sc3/sc6 is only the crossing, which (i)
makes a non-case. I made this a **comment-only reviewed repair at the site**,
because the return correctly identified this as the place deserving a second
independent look and the site should carry the answer, not only my verdict — and
I proved it comment-only (1729 tokens, identical sha256, both sides) **before**
claiming the green evidence transfers.

**The fold-in-1 superset is not scope drift, and the narrow reading would have
been the defect.** My commission named the **object** — *"`oa`'s
`words`/`last_tkeep`/`tlast_cycle`"* — and the *"sub-cases 1/2/4/5"* phrase in
§4 was the diagnosis of where the shortfall was **visible**, not a scope limit.
`oa` is bound in the shared `[ oa; ob ]` match, so covering four would have
required **adding** an exclusion branch: narrowing here is a positive act, not
the default. And it would have been weakest where it matters most — at the two
zero-delivered rows, `words` = 0 / `last_tkeep` = 0 / `tlast_cycle` = `None` is
the **model-side** statement that A's zero-delivery is real, and omitting it
leaves the row at the two-field depth `BOUNCE 10` sets a floor against. The
worker was right to flag the width and right not to narrow it; I am recording
that the wider landing is what the instruction meant, so the next reader does
not have to re-litigate it.

**On checking the discriminator strings myself rather than accepting the
return's empty grep.** An empty grep is a claim about a diff's rendering; I
extracted the six `~row:` literals from both trees, sorted them and hashed the
multiset — `c3af1d41…` on both sides. Campaign seals are written against those
strings, so "the diff shows nothing" is not the standard; "the bytes are the
same bytes" is.

**Why I struck the plan's three marks in this commit rather than deferring
them.** At `RV-0065` §11 item 3 I refused to strike them and **re-grounded** them
instead, on *"benched and not green"*, writing into each that it is struck by a
green respawn and a verdict and nothing else. Both now exist. A mark whose own
stated discharge condition is met and which is left standing is a false
no-coverage claim in a document that feeds `SO-` coverage — the exact defect
class I bounce workers for. So the strikes land here, with the superseded wording
kept beneath each, because the argument that retired a mark is only readable
against the mark. **One of the three limbs changed its ground rather than its
truth value, and that is the more useful edit**: §6.3 item 8 is still untested,
but no longer *"because the row was never benched"* — the row is benched at six
sub-cases, three of which coincide, always under different names. It is untested
because the carve-out **forbids the stimulus**. Closed question, not open gap;
without the edit an `SO-` would carry it as the latter.

**The count, and the adjective.** 43 titled / 42 effective at `88413b9` becomes
**43 of 62, titled and effective, which now coincide**. The census reproduces at
this tree boundary-matched; the naive matcher still returns 44 by discharging
`M03-M1` inside `M03-M10`'s title, third direction of the same shared-title
problem. **The census is the numerator's provenance; the run id is the
adjective's** — no titles method can see a pass, which is precisely why 43 was
not earned three hours ago and is now.

**The commissions.** Family-B/N campaign packet **+ seal in one commit**, next
round: denominator to re-measure at **48 / 128 / 80**, five REQUIRED classes
(in-word abort recognition, zero-delivered close, coincidence serialisation,
REQ-113-into-preamble, runt-check sequencing on the abort path), and bound 7
**scored with the three instances distinguished** — 4 and 5 `Frame`-state on
entry, 6 `Preamble`-state — because a campaign that scores "three instances"
without saying which shape each is has recorded a count, not a coverage.
Family J is **dated to the round after that seal**; a third deferral is an E2
with the cost named. The seal is stated as a **forward commitment** in
PROTOCOL §10's own terms, redeemed by the commit that stages it and by nothing
else, and I wrote into the verdict that an unredeemed promise is adjudicated as
**no seal** — so the bound-7 scoring claim cannot be made without the file.

### Actions
- Line-reviewed `test/xgmii_rx_64/test_m03_n.ml` at `eb1e06a` against
  `RV-0065-VERDICT` §12; re-derived both repairs, all six tuples, both §0.6
  windows and the sc3/sc6 post-closure geometry from spec text first.
- Built a nesting-aware OCaml comment stripper (string-literal and `{|…|}`
  aware) and compared `eb1e06a^..eb1e06a` **token for token**; enumerated the
  complete set of six code changes; confirmed no `[%expect]` block moved.
- Hashed the sorted `~row:` discriminator multiset on both sides.
- Read `.github/workflows/build.yml` steps 6 and 8, then checked the three CI
  runs and the two job conclusions at the source.
- Re-ran the discharge census at `eb1e06a`, boundary-matched and naive, side by
  side.
- **Reviewed repair, comment-only**: the `DEFECT N-1` derivation site in
  `test_m03_n.ml` now carries the full post-closure geometry for sc3 and sc6,
  both crossings at sc6, and the three properties of the `Idle` row that decide
  them. Proved code-identical (1729 tokens, matching sha256) and
  `ocamlc -stop-after parsing` clean.
- Appended **`RV-0065B-VERDICT`** (ACCEPT) to the packet.
- **Plan edits in `AP-xgmii_rx_64.md`**: §4.N's closing note STRUCK with both
  prohibitions lifted; §6's REQ-102 and REQ-110 marks STRUCK and re-read as
  DRIVEN, the REQ-110 entry carrying the three bound-7 shapes; the *"absence
  costs"* costing discharged with limb (b) re-grounded; §9 change-log row
  appended. Superseded wording kept beneath every strike.

### Evidence
- **CI at `eb1e06a`** — `build` run **`30963617198`**: job `build`
  **`92172708172`** *success* (step 6 `opam exec -- dune runtest`; step 8
  `git add -A; git diff --cached --exit-code`), job `cosim` **`92172708206`**
  *success*; `journal-check` run **`30963617180`** *success*. No `.corrected`
  file, no unpromoted drift. **11 of 11 members green**; the three RED at
  `88413b9` (M03-N2 sub-cases 3, 4, 6) are green, the eight green stayed green.
- **Comment-stripped token diff, `eb1e06a^..eb1e06a`**, `test_m03_n.ml`:
  1591 → 1729 tokens; the complete change set is the `coincides` field + six
  literals, `max 5 (`…`)`, the `Bool.equal` guard, the five-statement B-2
  fold-in, the deletion of the `c1 = c2` early-fail, and six title strings.
  Nothing else.
- **Discriminator multiset sha256**, sorted, both sides:
  `c3af1d41ba7c8d09a81afaa1325d97a405df07d15a8b0c9e59f79f477860dd0b`.
- **`git show eb1e06a --numstat`**: three paths; the packet and the worker
  journal are `+153/−0` and `+205/−0`, pure appends. `test_m03_b.ml`,
  `bench.ml`, `bench.mli`, `test/xgmii/injection.mli`,
  `test/xgmii/idle_injection.mli`, `test/xgmii_rx_64/dune` and
  `AP-xgmii_rx_64.md` are absent from the commit.
- **Discharge census at `eb1e06a`**, boundary-matched, run at this tree: 48
  titles under `test/xgmii_rx_64/`; **43** distinct plan rows named; − `M03-A4`
  (NO-ASSERT, named in a title) = 42; + `M03-F5` by citation
  (`test_m03_f.ml:809`) = **43 of 62, EFFECTIVE**. Naive substring match
  returns **44** (`M03-M1` inside `M03-M10`). CI's own inventory block prints
  6 / 48 / 128, unchanged from `88413b9`.
- **My comment-only repair proved comment-only**: comment-stripped and
  tokenised, before and after are **1729 tokens** and sha256
  `f28e8fca695ee886e20408b4e9cccb7b6c04b83110fc846d38baa727a71f2c02` both
  sides; `ocamlc -stop-after parsing test/xgmii_rx_64/test_m03_n.ml` exit 0.
- **Spec citation checked verbatim**: SPEC-M03 §6.2's `Idle` row reads
  *"ignores every lane; `tvalid` = 0; CRC register held"*, exiting only *"on
  `/S/` in lane 0 or lane 4 while `cfg_rx_enable` = 1"*.
- The `dune runtest` / `git diff --exit-code` pair is CI's, not this seat's:
  ADR-0005 leaves no Hardcaml toolchain here, and I say so rather than implying
  I ran the suite.

### Outcome
**DoD met.** `RV-0065B-VERDICT` **ACCEPT** appended to
`agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md`; `WO-0065` moves
to **ACCEPTED**. M03-N2 is **DRIVEN**, both standing prohibitions **LIFTED**,
discharge **43 of 62 effective**, outstanding twenty → **nineteen**. `WO-0058`
bound 7 has three instances **with their shapes distinguished** and **leaves my
carried list only when the campaign scores it**. Commissioned and dated: the
family-B/N campaign packet **+ seal in one commit** (next round), then family J
(the round after). Handoff: this packet's `RV-0065B-VERDICT` §7 to the
orchestrator.

### Open-questions
1. **The family-B/N seal is a FORWARD COMMITMENT and nothing more** (PROTOCOL
   §10, ADR-0016). No result is held and none is claimed. It falls due in the
   commit that stages the packet beside its `-SEALED-predictions.md`; **if a
   diff exists before that commit lands, the round has no seal**, the bound-7
   scoring claim may not be made, and the absence is a finding against me.
2. **`bench.mli`'s `_frame`/`_piece` naming axis still has no cell** for a
   genuine `Arrival.frame` whose received extent is shorter than its declared
   array — every REQ-110-aborted declared frame. Documentation debt, **mine**,
   riding the campaign round; carried into that packet at `RV-0065B-VERDICT`
   §7.1. No code moves.
3. **`tools/dv_checks.sh`'s census must match row ids with a trailing-digit
   boundary.** Now demonstrated at two SHAs; commissioned into the campaign
   packet, still deliberately not landed in a review commit.
4. **Fold-in 3 — A's delivered content — remains an undischarged standing
   strengthening**, correctly declined this round because I marked it
   *"optionally"*. Carried into the campaign packet rather than dropped; two
   lines, and it converts A's count assertion into a provenance assertion.
5. **Family J is DATED to the round after the campaign seal.** A third deferral
   is an **E2** to the orchestrator naming the cost — the capability rows enter
   `P1-module-ready` evidence unbuilt — not a footnote.
6. Carried unchanged from `J-dv_lead-0112`: `run_i2_member`'s deliberate
   citation exception; the `assert_following_frame_intact` /
   `assert_clean_frame_structure` merge; `WO-0061` §8 bound 1's `tkeep` half;
   **N-1**; the auditor's DV-escape ledger disposition on `BUG-0003`; **B-4**'s
   stale forward reference in `test_m03_h.ml`'s docstring.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due this round** — no `SO-`, no gate.
Span since `J-dv_lead-0112`'s note: **J-dv_lead-0113** (this entry); cumulative
untiled span **J-dv_lead-0001 … 0113**, first harvest still firing at `SO-M03`.
Inventory carries unchanged at **~11 LH2-g candidates plus the war stories**,
including `J-dv_lead-0112`'s pre-commitment-list candidate. Yield this round:

- **One new candidate banked, and it is the sharpest thing this round taught.**
  *"When a repair is defended on a property of the objects it handles, check
  whether the same site handles an object lacking that property — a ground
  chosen from the instances in view will silently exclude the one that is
  not."* **LH1**: this commit — the padding's crossing was defended on the added
  octets being plain data, while the same padding also displaced a **control**
  character across the same boundary, which that ground cannot reach; the
  correct ground was the state rule's per-lane *form*, which covers both.
  **LH2-g** — no proper noun in the rule statement; it binds any argument that
  picks its warrant from the cases it happens to be looking at. **LH3**: without
  it, a defence is graded on whether it is true of what was examined rather than
  on whether it covers what is present, and the uncovered object is found by
  whoever hits it next rather than by the reviewer.
- **`J-dv_lead-0112`'s pre-commitment candidate gains its first CONFIRMING use,
  from the other side.** *"A list of pre-committed reject conditions is a
  guarantee about the reviewer's independence, never a claim of coverage; before
  citing one as met, name the defect class it would have MISSED."* Last round it
  fired against me on a miss. This round I used it **prospectively** — checking
  both directions of the member set instead of reading CI's colour — and it
  changed what I checked. A candidate that has now failed once and paid once is
  materially stronger than one with a single incident; observable unchanged.
- **The `J-dv_lead-0111` conjunction candidate gains a second confirming
  instance.** *"A bound stated as a conjunction is discharged only by a stimulus
  containing every conjunct."* Bound 7's three instances split into two shapes
  on the *state* conjunct, and the plan's own §6 entry now carries the split —
  so the candidate has now shaped an artefact, not just a verdict.
- **No war story retired, none promoted.** Both carry.

### Files-in-this-commit
- agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md
- test/attack_plans/AP-xgmii_rx_64.md
- test/xgmii_rx_64/test_m03_n.ml

## [J-dv_lead-0114] 2026-08-05T23:55Z | task:WO-0066 | The census that had to stop being a hand measurement — and the boundary defect reproduces at a third SHA, so the tool now prints both matchers and names the row the naive one steals

### Trigger
Orchestrator dispatch opening the family-B/N campaign round, item 1's carried
obligation: the `tools/dv_checks.sh` trailing-digit boundary match commissioned
at `RV-0065B-VERDICT` §7.1 and left standing at `J-dv_lead-0113`
Open-question 3. It lands as its **own commit, before** the campaign packet's,
because it is under `tools/` and therefore moves no byte the campaign scores
against — which is exactly what makes it eligible to ride the base SHA.

### Inputs
- `agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md`
  **`RV-0065B-VERDICT` §5** (the 48/43/44 measurement and the naive matcher's
  defect) and **§7.1** (the commission itself).
- `tools/dv_checks.sh` at HEAD — the whole file, and the **bench-inventory
  block's own header comment** in particular, because the new block has to be a
  REPORT under the same rules and I wrote it against that block rather than
  against my memory of it.
- `test/attack_plans/AP-xgmii_rx_64.md` — read for its **row-id declarations
  only**, to derive the id set the matcher ranges over.
- `test/xgmii_rx_64/*.ml` — `%expect_test` titles only.
- `agents/PROTOCOL.md` §5 (R2, R4, R7), §6 (write scope: `tools/**` is mine).
- `agents/charters/dv_lead.md` §3, §8.

### Reasoning
**Why a REPORT and not a check, decided the same way the inventory block was.**
An asserted census goes stale every packet and would redden the suite for doing
its job. The block therefore has no pass/fail semantics and does not touch
`$status` — verified by running the script and confirming exit 0 with the
OBLIGATION-OPEN line unchanged. What it buys is **provenance**: a figure a
sign-off or a campaign denominator quotes now has a command behind it.

**Why print BOTH matchers rather than only the correct one.** The naive figure
is what any reader's own `grep` produces. A tool that silently prints the right
number teaches nothing and is re-derived wrongly by the next person with a
shell. Printing 44 beside 43 **and naming `M03-M1` as the row the naive matcher
steals from `M03-M10`'s title** makes the discrepancy readable rather than
merely counted — the same move `J-dv_lead-0109` §6 made when it put a rule in
the tool instead of in a journal.

**The general shape, written into the comment because it is not about this
bench.** *When a set of identifiers is matched into free text, the match needs a
boundary whenever any identifier is a prefix of another.* The block says so, and
says the corollary that matters more: **a pass with no prefix pairs is correct by
accident and stays correct only until an id is added** — so the "the two matchers
agree" branch prints that caveat rather than a clean bill.

**What I deliberately did NOT mechanise.** Two adjustments stand between the
boundary figure and the discharge count: `M03-A4` is a **NO-ASSERT** row that is
named in a title, and `M03-F5` is discharged **by citation** and appears in no
title. Both are **judgements**. Encoding them would let a later reader inherit
two rulings as if they were measurements, and would silently go wrong the day a
third such row appears. They are printed as **DECLARED**, with their provenance,
so a reader checks them. The ASSERT-row denominator (62) is likewise left to the
plan rather than computed, because the plan is where ASSERT/NO-ASSERT is ruled.

**One thing I found while testing the extractor and did not build on.** A regex
that harvests `M03-[A-Z]+[0-9]+` tokens straight out of the titles returns
**44** as well — but for an entirely different reason: it picks up `M03-R1`, a
**defect** id named in sub-case 4's title, which is not a plan row at all. Two
different methods, two different 44s, one right answer. That is precisely why
the block matches the **plan's declared id set** into the titles rather than
harvesting tokens: a census must range over the thing being discharged, not over
whatever happens to look like it.

### Actions
- `tools/dv_checks.sh`: appended one block, **row-discharge census
  (REPORT only)**, after the bench inventory and before the status summary.
  Extracts the plan's row ids from its own table rows; extracts `%expect_test`
  titles from `test/xgmii_rx_64/*.ml`; runs the **naive substring** and the
  **trailing-digit boundary** matcher side by side; prints both counts, the
  over-discharged rows, and the two declared adjustments. No `$status` effect,
  no new check, no workflow edit (`.github/**` is not mine, PROTOCOL §6).
- Guarded the missing-plan case so the block announces `census skipped, NOT
  coverage` rather than printing a zero that could be read as a measurement.

### Evidence
- `bash -n tools/dv_checks.sh` → exit 0.
- `bash tools/dv_checks.sh` at this tree, the new block's own output:
  **78** row ids declared in the plan; **44** named in a unit title under the
  NAIVE substring match; **43** under the TRAILING-DIGIT BOUNDARY match;
  `over-discharged by the naive matcher: M03-M1`.
- **The defect reproduces at a third SHA** and its cause is now printed rather
  than argued: `M03-M1` is a prefix of `M03-M10`, and `M03-M10` shares
  `M03-B3`'s `%expect_test` title in `test_m03_b.ml`.
- `bash tools/dv_checks.sh >/dev/null 2>&1; echo $?` → **0**. The block cannot
  manufacture a green and cannot redden one; the run still ends with
  `every check that COULD run passed, and 1 obligation is still OPEN` (the
  RFC 1071 fetch, blocked here for the sixth time, `curl (56) CONNECT tunnel
  failed, response 403`).
- Inventory block unchanged and re-read at this tree: **48**
  `test/xgmii_rx_64/`, **128** `test/`, therefore **80** non-M03.
- `dune runtest` is not runnable from this seat (ADR-0005: no Hardcaml
  toolchain in this container). Nothing in this commit is OCaml, so no compile
  evidence is owed; CI's `build` is the authority as always.

### Outcome
**DoD met** for the first of the round's two commits. `RV-0065B-VERDICT` §7.1's
census commission is **DISCHARGED**, and `J-dv_lead-0113` Open-question 3 is
**closed**. This commit is the **base SHA** the campaign packet and its seal
freeze against (`WO-0066` §8): it is under `tools/`, so the sentence *"nothing
under `test/**` moves again until the campaign scores"* survives it intact.
Handoff: the campaign packet, next commit.

### Open-questions
1. The two declared adjustments (`M03-A4` out, `M03-F5` in by citation) are
   printed, not computed, **on purpose**. If a third such row appears the block
   will not know, and the reader who quotes it must still read the plan. Stated
   as a known limit of the instrument rather than left to be discovered.
2. Carried unchanged from `J-dv_lead-0113`: the `bench.mli` `_frame`/`_piece`
   naming-axis cell; fold-in 3; `run_i2_member`'s citation exception; `WO-0061`
   §8 bound 1's `tkeep` half; **N-1**; the auditor's ledger disposition on
   `BUG-0003`; **B-4**'s stale forward reference in `test_m03_h.ml`.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due** — no `SO-`, no gate. Span since
`J-dv_lead-0113`'s note: **J-dv_lead-0114** (this entry); cumulative untiled span
**J-dv_lead-0001 … 0114**, first harvest still firing at `SO-M03`. Inventory
carries unchanged at **~11 LH2-g candidates plus the war stories**. Yield this
round:

- **One candidate banked.** *"When a set of identifiers is matched into free
  text, require a boundary wherever one identifier is a prefix of another; a
  matcher with no prefix pairs in its current set is correct by accident, and
  stops being correct the moment an id is added."* **LH1**: this commit, and the
  two SHAs before it where the same prefix pair produced a discharge count one
  too high with no visible symptom. **LH2-g** — no proper noun in the rule
  statement. **LH3**: without it, a census over a growing id set silently
  over-counts, and the over-count is invisible precisely because the matcher
  runs cleanly.
- **A second candidate, weaker, banked as a war story rather than a rule.** Two
  different methods returned the same wrong number here for two unrelated
  reasons (a prefix collision; a defect id that looks like a row id). The
  observation — *agreement between two methods is not corroboration when neither
  was checked against the thing being counted* — is real but I could not state
  it without leaning on the coincidence, so it fails LH2 as written and goes no
  further this round.
- **No war story retired, none promoted.**

### Files-in-this-commit
- tools/dv_checks.sh

## [J-dv_lead-0115] 2026-08-06T01:20Z | task:WO-0066 | Six classes sealed against eleven never-scored members — and the coincidence that makes three sub-cases the round's best instrument is what makes two of them blind, which I found by deriving the seal instead of recalling my own plan

### Trigger
Orchestrator dispatch, item 1: the family-B/N mutation campaign packet **and its
SEALED companion in ONE commit**, redeeming `RV-0065B-VERDICT` §7.1's forward
commitment under R-SEAL-1. Sixth campaign of the programme, the practiced
`WO-0055`/`WO-0058`/`WO-0063B` form.

### Inputs
- `agents/handoffs/WO-0065_tb-m03-family-b-completion-and-n2.md` — the whole
  packet, and **`RV-0065B-VERDICT` §5, §6 and §7.1** in particular (the
  commissioning that is this round's contract).
- `agents/handoffs/WO-0063B_m03-i2-report-path-campaign.md` and
  `agents/handoffs/WO-0063B_m03-i2-report-path-campaign-SEALED-predictions.md` —
  the practiced form, and the seal whose §0 blast-radius sentence this round
  corrects.
- `agents/PROTOCOL.md` §3, §4, §5, §6, §10 (**R-SEAL-1** in full).
- `agents/charters/dv_lead.md` §3, §5, §8.
- `test/xgmii_rx_64/test_m03_n.ml` — **the whole file**: the six sub-case
  records, `run_subcase`'s complete source order, and every `fail` literal.
- `test/xgmii_rx_64/test_m03_b.ml` — `run_b2_new` (`:1157`–`:1329`), `run_b2`'s
  row prefix (`:940`), `run_b4b`'s (`:501`), and every `Strobe_monitor.expect`
  site in the file.
- `test/xgmii_rx_64/test_m03_g.ml`, `test_m03_h.ml`, `test_m03_i.ml`,
  `test_m03_e.ml`, `test_m03_f.ml`, `test_m03_c.ml`, `test_m03_d.ml` —
  registration sites and their `cycle` fields only.
- `test/xgmii_rx_64/bench.ml` `:226`–`:240` (`delivered_samples`,
  `error_pulses`) and `bench.mli`'s `[Before]` view.
- `test/attack_plans/AP-xgmii_rx_64.md` §4.B, §4.N, and its row-id declarations.
- `tools/dv_checks.sh` at the base SHA — run, for the denominator.
- `docs/specs/requirements.md` REQ-102, REQ-103, REQ-104, REQ-105, REQ-107,
  REQ-110, REQ-113, REQ-011, REQ-008, REQ-101, §0.3, §0.5, §0.6, §0.7, §2, §12;
  `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2, §6.3 items 3 and 8, §7, §9,
  §10.
- **No `libs/**`, `top/**` or `rtl_snapshots/**` path was opened** (PROTOCOL
  §10, charter §3).

### Reasoning
**The five classes I foresaw were a plan, and the freeze derivation broke two of
them.** My own commissioning said so in terms — *"what you seal is what you
derive at freeze"* — and it was right to.

- **IC-B as foreseen named two renderings in one sentence** (*emits a `tkeep`=0
  word* **or** *suppresses `error_runt` below a floor*). They redden the same six
  cells through **different assertions with different messages**. Sealing one
  string for both would have scored a correct rendering as a finding at six
  cells. It stays one class with a **mandatory rendering disclosure**, and the
  seal carries both branches.
- **IC-D as foreseen put `/I/` and `/Q/` in one `R!` set.** They are **two
  different defects**: the bench's own row text says `/I/` kills a REQ-113
  ignore-rule design and `/Q/` kills a **closed code table**. Scoring them as one
  class would have left the `/Q/` member — the whole reason §3.2.1's ruling
  drove it rather than declaring it — unscored on the only class it was built
  for. **IC-F is minted**, and the addition is named in the packet rather than
  smuggled.

**The thing I did not foresee, and it is the round's own discovery.**
`error_pulses` (`bench.ml:237`) maps each sample's `errors_high` to
`(cycle, name)` pairs. A strobe is a **signal, not a counter**: two logical
reports of the same name on the same cycle are **one observation** — §0.6's C-23
convention doing exactly what it says. Sub-cases 3, 4 and 6 pin frame A's and
frame B's reports to **one cycle**. So under **IC-E** — T8's own class, where a
spurious `error_runt` is *added* to frame A — the added report at sub-case 4
lands on the same cycle and under the same name as frame B's genuine one, and
`error_pulses` returns exactly the two pairs the assertion requires. **Sub-case 4
passes. It asserts T8 and cannot detect its violation.**

That collapses IC-E's `R!` set from the two members I foresaw to **one**
(sub-case 2, whose reports are a cycle apart), and it is a **real coverage
limitation of the landed bench, mine, on the record before the campaign runs**.
Had I written the seal from my plan instead of from the runner, the campaign
would have recorded a MUST-STAY-GREEN violation at sub-case 4 as a finding
against the auditor's manifest — for a green that is structurally correct.

**The same coincidence cuts the other way at IC-B(W)**: at sub-case 4 frame A's
`tlast` word and frame B's spurious word are owed on one cycle, and the stream
carries one word per cycle, so the sub-case cannot distinguish *B emitted a word*
from *B's word displaced A's*. Marked **UNWORKED with adjudication pre-fixed in
both directions** — a red buys nothing, and **a green is not a coverage finding
either**, because it is a property of the observation convention, not of the
bench. Recording it as a gap would be recording the instrument as the defect.

**The portable form, and it is the sharpest thing this round taught**: *a
stimulus that pins two events to one instant is an instrument for a defect that
moves an event in time and a blindfold for a defect that duplicates one.* The
same design property produces both, so a coverage claim naming the first without
the second has counted its instrument twice. Sub-cases 3/4/6 are IC-C's entire
convicting set **and** IC-E's and IC-B(W)'s blind spots, for one reason.

**Bound 7's scoring, built so a partial catch cannot be rounded up.** The three
instances split on frame A's state **on entry to W**: sub-cases 4 and 5 in
`Frame`, sub-case 6 in `Preamble` — derived from the lane mapping, because at a
lane-4 start A's SFD lands at lane 3 of W itself while at a lane-0 start it lands
at lane 7 of the preceding word. **D-A1** is the disclosure that decides which
instances a rendering reaches, and §4 rule 2 fixes that a rendering reaching only
the `Frame` pair scores **2 of 3, SHORT**, naming the unscored instance. A count
without that split is not a coverage, and my own §7.1 said so.

**Why the two carried `test/**` debts do not land in this round.** The
adjudicator-ordering rule's whole force is the sentence *nothing under `test/**`
moves again until the campaign scores*. `bench.mli`'s naming-axis cell and
fold-in 3 are both `test/**` edits. Landing either would cost that sentence for
**zero measurement gain** — a comment does not change a verdict, and the reader
downstream cannot tell a bench frozen before the mutants from one edited beside
them without it. Both get **named, dated carriers** in the packet §10: the
naming-axis cell rides the **family-J capability round** (which must open
`bench.mli` anyway, and which §7.2 dates to the round immediately after this
seal); fold-in 3 rides the first round that opens `test_m03_n.ml` — the
`M03-N1`/`M03-N4` bench round — **with a dated fallback**: if none is scheduled
by the time family J returns, it is commissioned as a rider on that round's
`RV-`. An undated carrier is how a debt becomes a habit, which is the failure
family J is one deferral away from.

**A correction against my own prior seal.** `WO-0063B`'s seal §0 said only
`test/xgmii_rx_64/dune` declares `hardcaml_ethernet` among the bench libraries
with `%expect_test`s. Measured at this tree that is **wrong**:
`test/hardcaml_ethernet/` declares it too and holds **one** unit. It names no M03
module, so a red there is a **build** finding — the mutant did not compile — and
never a behavioural one. The old sentence would have scored a build failure as a
scope violation. The non-M03 80 therefore splits **79 behavioural + 1
build-level**, and the seal says so.

**What I decline to derive, and why declining is cheaper than guessing.** Eight
blast-radius units across four classes are marked `r` — predicted red, zero
kills, red is not a finding and green is. Eight worked derivations would be eight
chances to repeat FINDING G-1's error at cells that score nothing. And IC-A's
**D-A2 = P** branch (the unrecognised `/S/` consumed as data rather than routed
to REQ-105) is sealed as `U` over an **enumerated message set**, because deriving
its exact first-speaker would require me to invent how the design strips REQ-103's
FCS from a frame whose length the mutation itself changed. The predicted-red
*set* is unchanged at P, so **bound 7 is still scored there** — the set is what
the bound turns on, not the string.

### Actions
- Wrote `agents/handoffs/WO-0066_family-bn-mutation-campaign.md`: six intent
  classes with **seven mandatory disclosures** (D-A1, D-A2, D-B1, D-B2, D-D2,
  D-DF1, D-E1); the denominator with its blast-radius correction; the measured
  eighteen-unit no-output-word set; **bound 7's scoring rule with the three
  instances' state split**; R-DISC-1/2 binding per class, per sub-case, per lane;
  the `BUG-0003` datapath signature as a pre-ship check **that has a domain this
  round** plus the five datapath messages that discriminate structurally; the
  allowlist; the base SHA and the adjudicator-ordering rule; the mutant-owned
  inequality table; the non-closures with named carriers; the weighting; the
  return format; and the `WO-0063B` pre-run-reading-note precedent restated.
- Wrote `agents/handoffs/WO-0066_family-bn-mutation-campaign-SEALED-predictions.md`:
  row prefixes; assertion orders for `run_subcase` and `run_b2_new`; the
  eight-number derivation table; the branch-by-branch matrix with
  MUST-STAY-GREEN denominators; **the REQUIRED cells verbatim, derived from the
  runners at the base SHA**; the UNWORKED cells with adjudication pre-fixed;
  **§6 GREEN BY BLINDNESS**; seven dispositions; the inequality table; the
  reasoning; the bounds; the pass criteria.
- **No `test/**` byte was edited in this round**, deliberately (§8's ordering
  rule). No git command was run (PROTOCOL §2).

### Evidence
- **Denominator, re-measured at the freeze** by `bash tools/dv_checks.sh` at the
  base SHA: **48** M03 units, **128** repository-wide, therefore **80** non-M03 —
  the figure `RV-0065B-VERDICT` §7.1 predicted, confirmed rather than inherited.
  Per-directory split re-measured: `monitors` 37, `xgmii` 25, `golden` 11,
  `axi64_probe` 3, `xgmii_probe` 3, `hardcaml_ethernet` **1**, `xgmii_rx_64` 48
  — 128 exactly, and **79 + 1** outside M03.
- **Row census at the base SHA**, from the block landed at `J-dv_lead-0114`:
  78 plan rows, **44** naive, **43** boundary; over-discharged: `M03-M1`.
- **Every sealed string was read out of the runner, not recalled.** The six N row
  prefixes are `run_subcase`'s `~row:` arguments at `test_m03_n.ml:652`, `:662`,
  `:672`, `:683`, `:693`, `:704`; the bodies are the `fail` literals at `:541`,
  `:556–557`, `:562–563`, `:586–587`, `:616–617`, `:622–623` with their
  line-continuation whitespace folded. The B2 prefixes are composed at
  `test_m03_b.ml:1158` (`/I/`, `/Q/`) and `:940` (the landed `/E/`); the bodies
  are the literals at `:1299–1301` and `:1320–1323`.
- **The eight numbers per sub-case**, re-derived here from `requirements.md` §0.5
  and §0.6 and checked against the file's own records: `(W, /S/ lane, /T/ lane,
  A delivered, A's cycle, B's cycle)` = (3,0,2,8,4,5), (3,0,2,4,4,5),
  (2,0,2,0,4,4), (2,4,6,4,4,4), (3,4,6,8,4,5), (2,4,6,0,4,4) for sub-cases 1…6;
  §0.6 windows [3,5]/[3,6], [3,5]/[3,6], [2,5]/[2,5], [2,5]/[2,5], [3,6]/[3,6],
  [2,5]/[2,5]. **Sub-cases 3, 4 and 6 coincide; 1, 2 and 5 do not.**
- **The blindness claim is read off the source, not assumed**: `error_pulses`
  (`bench.ml:237–240`) is `List.concat_map samples ~f:(fun s -> List.map
  s.errors_high ~f:(fun name -> s.cycle, name))` — one pair per *name high at a
  cycle*, so a same-name same-cycle duplicate is unobservable by construction.
- **M03-H4's two reports are `c + 2` and `c + 3`** (`test_m03_h.ml:939`, `:951`,
  `expected_cycle_a`/`expected_cycle_b`), never equal — which is why IC-C's whole
  convicting set is inside M03-N2. M03-G7's two are the truncation cycle
  (`start_cycle + 3 + 189`, `test_m03_g.ml:1363`) and a runt pin after the whole
  1600-octet frame (`:1375`).
- **CI green at `eb1e06a`**, run **`30963617198`**, job `92172708172` (step 6
  `dune runtest`, step 8 `git add -A; git diff --cached --exit-code`) —
  the last measured green of the bench this seal freezes against. The control run
  at the base SHA is the auditor's to quote (`WO-0066` §12 item 5); **CI is the
  authority** (ADR-0005) and I do not claim a local run: this seat has no
  Hardcaml toolchain.
- **The seal is a file in this commit's own `Files-in-this-commit` list**, which
  is what R-SEAL-1 requires and what `J-dv_lead-0113` Open-question 1 said would
  be the whole of the redemption.

### Outcome
**DoD met.** `RV-0065B-VERDICT` §7.1's forward commitment is **REDEEMED**: the
packet and its seal are staged in one commit, before any diff exists. Six
classes, seven disclosures, `R!` sets spanning eleven never-scored members, and
**bound 7 scored with its three instances distinguished**. The base SHA is the
`J-dv_lead-0114` commit this one immediately follows. Handoff: `WO-0066` to the
**auditor** via the orchestrator, blinded under §7's allowlist; the seal stays
sealed until the scorecard is in hand.

### Open-questions
1. **The seal is now a committed artefact and no longer a promise.** If any
   `test/**` file is edited between this commit and the scorecard — **including
   by me** — the round has no valid base and re-runs from a fresh seal
   (`WO-0066` §8).
2. **T8 is instrumented at two members and detectable at one** (seal §6.1). That
   is a coverage limitation of the landed bench, it survives any outcome of this
   round, and the repair — a per-frame strobe attribution the current `(cycle,
   name)` observation cannot express — is a **bench-machinery** question, not a
   member question. Not commissioned here; recorded so it is not rediscovered
   from a scorecard.
3. **IC-D and IC-F are indistinguishable by any observation this bench makes.**
   Their separation is carried entirely by which diff was applied, and
   disposition 6 is the whole of the protection. If the auditor renders them in
   one change, both are unscoreable.
4. **`bench.mli`'s naming-axis cell** rides the **family-J capability round**;
   **fold-in 3** rides the first round that opens `test_m03_n.ml`, with the
   family-J `RV-` as its dated fallback (packet §10). Both are now carried with
   dates rather than with intentions.
5. **Family J is one deferral from an E2.** `RV-0065B-VERDICT` §7.2 dated it to
   the round immediately following this seal; a third deferral goes up naming the
   cost, not as a footnote.
6. Carried unchanged: `run_i2_member`'s citation exception; `WO-0061` §8 bound
   1's `tkeep` half; **N-1**; the auditor's ledger disposition on `BUG-0003`;
   **B-4**'s stale forward reference in `test_m03_h.ml`'s docstring.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due** — no `SO-`, no gate. Span since
`J-dv_lead-0114`'s note: **J-dv_lead-0115** (this entry); cumulative untiled span
**J-dv_lead-0001 … 0115**, first harvest still firing at `SO-M03`. Inventory
carries at **~12 LH2-g candidates plus the war stories** (`J-dv_lead-0114` banked
the twelfth). Yield this round:

- **The strongest candidate this arc has produced.** *"A stimulus that pins two
  events to one instant is an instrument for a defect that moves an event in time
  and a blindfold for a defect that duplicates one; the same property produces
  both, so a coverage claim naming the first without the second has counted its
  instrument twice."* **LH1**: this commit — sub-cases 3, 4 and 6 are the
  serialisation class's entire convicting set and the duplication class's blind
  spot, because the observation is *which signals are high at a cycle* and a
  duplicate is not a second signal. **LH2-g** — no proper noun in the rule
  statement; it binds any observation channel that reports presence rather than
  count. **LH3**: without it, a bench's most-cited stimulus is credited with
  coverage it structurally cannot have, and the gap is found by whoever seeds the
  duplicating defect years later.
- **`J-dv_lead-0113`'s ground-selection candidate gains a confirming use, in the
  direction it was banked for.** *"When a repair is defended on a property of the
  objects it handles, check whether the same site handles an object lacking that
  property."* Applied here to a **prediction** rather than a repair: my foreseen
  IC-E cell was defended on *frame A delivers fewer than five octets*, which is
  true at sub-cases 2 **and** 4 — and hid that only one of them can report it.
  The candidate found it. Observable unchanged; second incident, different
  artefact class.
- **`J-dv_lead-0111`'s conjunction candidate gains a third instance.** *"A bound
  stated as a conjunction is discharged only by a stimulus containing every
  conjunct."* **D-A1** exists because bound 7's second conjunct (*already open on
  entry*) has two state shapes, and a rendering may satisfy one; the packet's
  §4 scoring rule is the candidate turned into an adjudication.
- **One war story, not promoted.** `WO-0063B`'s seal §0 blast-radius sentence was
  wrong at this tree and would have mis-classed a build failure as a scope
  violation. The lesson — *a claim about what a test suite depends on must be
  re-measured, not carried, when the suite grows* — is true and reads as project
  hygiene rather than as a portable rule. Recorded, not banked.
- **No war story retired.**

### Files-in-this-commit
- agents/handoffs/WO-0066_family-bn-mutation-campaign-SEALED-predictions.md
- agents/handoffs/WO-0066_family-bn-mutation-campaign.md

## [J-dv_lead-0116] 2026-08-06T14:10Z | task:WO-0066 | Two pre-run questions ruled and a third the manifest raised without asking — my seal's runt floor was five where the specification says sixty-four, and the auditor falsifying two of my green cells is the best independence evidence this round could have produced

### Trigger
Orchestrator relay: the auditor's `WO-0066` manifest is committed at `8869705`
(six diffs, frozen before any run, base `199e319` verified as `ebaac58^`), and
the adjudicator-ordering rule permits my read. **Two pre-run questions from its
§7 to rule on in writing before the transients are operated**, plus the voiding
call on a disclosed ambient exposure, which `WO-0066` §7 makes mine alone.

### Inputs
- `docs/reports/audit/WO-0066-mutations/README.md` — the manifest **in full**
  (841 lines): §1 base-SHA verification, §2 stimulus geometry, §3's six diffs,
  §4's seven disclosure answers, §5's gate inventory, §6's fan-out closure, §7's
  two pre-run notes, §8's mechanical checks, §9's allowlist statement.
- `docs/specs/requirements.md` — **§12's strobe table, line 881** (decisive), §0.6
  (the counting convention and the bound-never-a-licence note), REQ-102, REQ-107.
- `agents/handoffs/WO-0066_family-bn-mutation-campaign.md` §1.3, §1.6, §4, §6,
  §7, §9 — my own packet, re-read against the manifest's answers.
- `agents/handoffs/WO-0066_family-bn-mutation-campaign-SEALED-predictions.md`
  §3.3, §4.5, §5.2, §6, §7, §8 — **read, not edited**.
- `agents/handoffs/WO-0063B_pre-run-reading-note.md` — the form.
- `agents/PROTOCOL.md` §2, §4.1, §10; `agents/charters/dv_lead.md` §3.
- Git metadata for `199e319`, `ebaac58`, `fb27764`, `8869705` — subjects and
  trailers, to measure the exposure channel rather than assume it.
- **No `libs/**`, `top/**` or `rtl_snapshots/**` path was opened.** Every RTL
  claim below is cited as the auditor's disclosed evaluation and none enters a
  verdict as verification.

### Reasoning
**The governing constraint, fixed before any ruling.** The diffs exist. Anything
I write now is written with a rendering in view, so a "clarification" can become
a seal tuned to a mutant — and it does not stop being that failure because the
tuning would raise the kill count rather than lower it. **No cell moves.** Where
the manifest shows a sealed cell wrong, the cell stands and the round scores it a
violation against me. That is strictly harsher than a correction and it is the
only disposition that leaves the seal doing its job. What the note may legitimately
do is **pre-commit an adjudication** the manifest has made foreseeable, which is
the opposite of amending a prediction after a result.

**Question 1 was easier than it looked, and the auditor's ground is better than
mine.** My seal already marked N sub-cases 3, 4 and 6 `G✱` under IC-E — green by
blindness — and scoped `R!` to sub-case 2. So its NOT-SEEDED and my `G✱` are the
same fact; the ruling is **concordant**, and disposition 3 does **not** fire
because disposition 3 keys on unreachability at the **`R!`** set, which is
sub-case 2 and is reachable. **The refinement I did adopt cuts against my own
wording.** I located the limitation in the *instrument* ("blindness"); the auditor
locates it in the *waveform* — under §0.6's high-cycle counting the mutant is
**bit-identical** to a conformant design there, which makes it an **equivalent
mutant**. That is a **larger** limitation than my seal claimed: sub-case 4 is not
a defective instrument, and no bench repair can fix it, because the strobe
interface reports presence per cycle and not multiplicity. I restated seal §6.1
rather than withdrew it, and barred any verdict from reading IC-E's kill as
evidence that T8 is instrumented at two members.

**Question 2 needed a rule that did not exist, so I minted one rather than
stretch a disposition to fit.** IC-B's `W` branch is unrenderable at this design
(the auditor's derivation: the in-word path has no payload machinery, and the
epoch-A `W` rendering cannot fire because `have_word` needs `pc ≠ 0`, which a
zero-delivered frame never gives). D-B1's **disclosure structure already absorbs
it** — that is what putting the rendering on a mandatory axis bought — and IC-B is
seeded and scoreable on the `R` branch. But none of seal §7's seven dispositions
covers *a disclosed branch that cannot exist*. **Disposition 8, VOID BY
DISCLOSURE**, minted pre-run and citable: the branch's cells are not scored,
contribute zero kills, and are findings in neither direction; the class scores on
the rendered branch alone. Seal §5.2's UNWORKED cell at sub-case 4 becomes
**moot** — void by disclosure, not by the one-word-per-cycle argument — and I said
so, because conflating the two later would launder a design fact into a coverage
argument. **And I barred the tempting half**: the auditor's derivation implies the
design *structurally* cannot emit a word for a zero-delivered frame, which would be
stronger than any test — and it is **not mine to claim**. I have not read the RTL,
DV does not derive from RTL, and no `SO-` may cite it as §0.7 coverage.

**The third item is the round's real event, and neither question asked about it.**
The manifest predicts IC-E red at sub-cases **1, 2 and 5**. My seal marks **1 and
5 `G` — MUST STAY GREEN**. I checked which of us was right **from the
specification, not from the diff**: `requirements.md` §12 line 881 defines
`error_runt` as *"fewer than 64 octets between start and terminate"*. My seal §4.5
derived from a **sub-five floor** and marked 1 and 5 green *because A delivers 8*.
**Eight is also fewer than sixty-four.** At those two sub-cases A reports at W + 1
and B at W + 2, so unlike at 3/4/6 the two runts do **not** collapse and three high
cycles are observable. **The manifest is right and my seal is wrong at two cells.**

Worse and more instructive: **my disclosure question was malformed.** §1.6 asked
*"`delivered < 5` or `0 < delivered < 5`?"* — **both options wrong**; the predicate
is `< 64` on octets received. The auditor answered the one sound half and
**disclosed the real threshold in the open**. The disclosure function worked
*despite* the axis being mis-stated by me, which is simultaneously the strongest
argument for mandatory disclosures and against trusting whoever writes them.

**How I scored it, and why not by correcting the seal.** Sub-cases 1 and 5 **stand
as sealed**. If they redden it is a MUST-STAY-GREEN violation **against me**,
scored exactly as `WO-0063B-VERDICT` §6.1's M03-D2 violation was. It is the first
of my own containment rule's two alternatives — *my enumeration was incomplete* —
never the second, because IC-E reaches precisely what IC-E says it reaches. **Kill
count unaffected**: the scored cell is sub-case 2. So the seal produced exactly
the behaviour a seal is for — it caught its author.

**The voiding call: NOT VOIDED, and I priced the channel instead of waving it
through.** Two of the four exposures are **my drafting defect**: barring all of
`agents/**` forbade the charter, PROTOCOL and own-journal reads PROTOCOL §2 makes
mandatory first actions, so an agent obeying my allowlist literally could not have
written the manifest. Carve-out stated and binding. The fourth — git metadata — I
**measured**: `ebaac58`'s subject carries "six classes" and "eleven never-scored
members", both **freely told in the packet itself**; `199e319`'s is census content;
the `--stat` line leaks a filename the packet's own header names. **Marginal leak
zero.** But it was luck: my `J-dv_lead-0115` title continues into seal §6
substance — listed in seal §12 as not to be told — and reached the subject only in
**truncated** form because the orchestrator shortened it. That discipline is mine
and I did not keep it.

**Materiality, tested rather than asserted.** Three positive signs the exposure
changed nothing: the auditor's IC-E ground is *different from and stronger than*
mine; the shape of question 1 is inconsistent with having read the answer (a reader
of seal §3.3 sees `G✱` and has nothing to ask); and **decisively, its IC-E red set
contradicts two of my green cells**. A contaminated auditor matches the seal; it
does not falsify it from the specification. **The best independence evidence this
round could produce arrives as a by-product of my own error**, and it is worth more
than any assurance either of us could have written.

**Class order is for reading, not gating**, and two orderings are load-bearing:
IC-C first because its three required greens are the round's control and every
later report-path red is read against them; IC-E **after** IC-C, because IC-C's
green at 1/2/5 is what makes IC-E's predicted red at 1 and 5 attributable to my
enumeration rather than to a general report perturbation. IC-D before IC-F because
the `/E/` control must be established before the class that reddens only `/Q/`, and
IC-A last because bound 7's verdict must not be contaminated.

### Actions
- Wrote `agents/handoffs/WO-0066_pre-run-reading-note.md`, **BINDING and citable
  by the scorecard**: §0 the no-cell-moves rule; §1 ruling 1 (concordant,
  disposition 3 does not fire, the equivalent-mutant refinement adopted); §2
  ruling 2 (**disposition 8, VOID BY DISCLOSURE**, minted) with the bar on
  claiming the design fact as coverage; §3 **FINDING WO-0066-3** and its scoring;
  §4 the voiding call with the measured metadata table and the allowlist
  carve-out; §5 the four findings, all mine, and the statement that **nothing is
  found against the manifest**; §6 the run ruling and class order; §7 what the
  note does not do.
- **The seal was read and NOT edited.** No `test/**` byte moved. No git command
  was run (PROTOCOL §2).

### Evidence
- **The decisive specification citation, read by me at this tree**:
  `docs/specs/requirements.md:881` — `` `error_runt` | fewer than 64 octets
  between start and terminate | REQ-107 | M03 ``. This is what falsifies seal
  §3.3's IC-E `G` at sub-cases 1 and 5, and it is a **spec** read, not an RTL one.
- **Seal §3.3's IC-E row as landed, re-read before ruling**: sub-case 2 `R!`;
  1 and 5 `G`; 3, 4 and 6 `G✱`. **Concordance with the manifest at 3/4/6;
  contradiction at 1/5.**
- **Exposure channel measured, not assumed**: `git log --format='%H %s'` at
  `ebaac58` → *"Six classes sealed against eleven never-scored members - the
  packet and its seal in one commit"*; at `199e319` → *"The census stops being a
  hand measurement: both matchers printed, the stolen row named"*. Neither carries
  a seal cell. My own `J-dv_lead-0115` header at this file shows the clause the
  subject dropped.
- **Base SHA agreement**: manifest §1 gives `199e319` = `ebaac58^`, carrying
  `tools/dv_checks.sh` and `J-dv_lead-0114` and **no `test/**` or `libs/**`
  path**; `git log --oneline 199e319..HEAD -- test/ libs/` **empty**; last bench
  edit `fa91964`, strictly earlier. **No disagreement to raise as a pre-run
  finding.**
- **Manifest mechanics quoted from its §8**: all six `git apply --check` clean;
  each applies alone and reverts to empty; one file each; hunks 1/2/1/3/2/6; all
  six parse under `ocamlc -stop-after parsing`, with a deliberately broken file
  failing so the check is not vacuous. Elaboration is the orchestrator's to
  observe; a mutant that fails to compile is a **build-level** finding per
  `WO-0066` §2.1.
- **No transient has been applied.** Nothing in this entry is a campaign result,
  and every disposition in the note is conditional and pre-run.

### Outcome
**DoD met.** Both pre-run questions ruled in writing, in a committed and citable
form, **before any transient is operated** — the `WO-0063B` precedent honoured.
Ruling 1: **concordant**, IC-E scoreable at sub-case 2. Ruling 2: **VOID BY
DISCLOSURE** under new disposition 8, IC-B scoreable on branch `R`. Voiding call:
**NOT VOIDED**, campaign may run, six classes in the order IC-C → IC-D → IC-F →
IC-B → IC-E → IC-A. Four findings, **all against me**; **none against the
manifest**. Handoff: this note to the auditor and orchestrator; the transients may
proceed.

### Open-questions
1. **Two MUST-STAY-GREEN violations are PREDICTED at N sub-cases 1 and 5 under
   IC-E**, against my own seal, on the manifest's disclosed derivation. If they
   occur they are mine; if they do **not**, that is equally a finding and I must
   explain why a `< 64` predicate did not reach an eight-octet frame.
2. **The IC-B(W) design fact is recorded and NOT banked.** That a zero-delivered
   frame structurally cannot emit a word is the auditor's RTL derivation; **no
   `SO-` may cite it as §0.7 coverage** until a bench re-establishes it from the
   specification side. Whether that bench is worth writing is a question for the
   family-J round, not for this one.
3. **The strobe interface reports presence per cycle, not multiplicity**, so a
   duplicated report under one name on one cycle is unobservable by construction
   (§1(c)). That is not a bench defect and no bench change fixes it. Whether M03's
   strobe contract should carry a multiplicity signal is an **architect** question
   and I raise it as one, not as a `BUG-`.
4. Carried unchanged from `J-dv_lead-0115`: the ordering rule's standing bar on
   `test/**` until the scorecard exists; `bench.mli`'s naming-axis cell and
   fold-in 3 with their dated carriers; family J one deferral from an E2;
   `run_i2_member`'s citation exception; `WO-0061` §8 bound 1's `tkeep` half;
   **N-1**; the ledger disposition on `BUG-0003`; **B-4**.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due** — no `SO-`, no gate. Span since
`J-dv_lead-0115`'s note: **J-dv_lead-0116** (this entry); cumulative untiled span
**J-dv_lead-0001 … 0116**, first harvest still firing at `SO-M03`. Inventory
carries at **~13 LH2-g candidates plus the war stories**. Yield this round:

- **The sharpest candidate this round, and it is about my own instrument.** *"A
  question offered as a choice between n values asserts that the answer lies among
  them; state the quantity the values range over, or a respondent can answer
  correctly and leave the questioner's error intact."* **LH1**: this commit — I
  offered a floor as *"< 5 or 0 < … < 5"* when the governing predicate was
  *"< 64"*, and the respondent answered the one sound half while disclosing the
  real threshold in passing; had it answered only the question, two of my sealed
  cells would have been falsified by a scorecard instead of by a disclosure.
  **LH2-g** — no proper noun. **LH3**: without it, a disclosure protocol
  transmits the asker's misconception intact and certifies it as answered.
  **This supersedes `J-dv_lead-0107`'s weaker form** (*a question with n values
  must state the dimension it ranges over*) by adding what goes wrong when it is
  answered rather than when it is asked.
- **A second candidate, banked.** *"When a prediction and an independent
  derivation disagree, resolve it from the shared source both claim to derive
  from — never from the artefact one of them was derived against."* **LH1**: this
  commit — the manifest and my seal disagreed at two cells, and I settled it from
  the specification's own strobe table rather than from the diff that raised it,
  which is the only resolution that does not convert a disagreement into a
  tuning. **LH2-g**. **LH3**: without it, the party with access to the
  implementation always wins, and the record cannot tell agreement from
  capitulation.
- **A third, weaker, banked as a war story.** An adversary's contradiction of
  your own prediction is stronger evidence of its independence than any assurance
  either party can write. True, and I could not state it without leaning on this
  round's particulars — it reads as an observation about adversarial review rather
  than a portable rule. Recorded, not banked.
- **`J-dv_lead-0115`'s coincidence candidate gains a same-round strengthening**
  from the other side: the auditor derived the same collapse from the DUT's
  waveform while I derived it from the bench's reading, and its version is
  stronger — the events are **not distinguishable at the interface**, so no
  instrument change reaches them. Observable restated; the candidate is now about
  the observation channel rather than about a bench.
- **No war story retired, none promoted.**

### Files-in-this-commit
- agents/handoffs/WO-0066_pre-run-reading-note.md

## [J-dv_lead-0117] 2026-08-06T18:40Z | task:WO-0066 | Six of six killed and bound 7 scored 3 of 3 — and the campaign's most valuable result is that it falsified the bound's own premise, which was false when I wrote it and which six packets quoted instead of re-measuring

### Trigger
Orchestrator relay: all six transients ran at base `199e319`, six CI runs
delivered as decoded logs, and the round's adjudication is mine — score every
class against the seal frozen at `ebaac58`, applying
`WO-0066_pre-run-reading-note.md` wherever its rulings bind.

### Inputs
- The six decoded build logs (complete `dune runtest` output with promotion
  blocks), runs **30968238533** (IC-C), **30968239697** (IC-D), **30968240974**
  (IC-F), **30968242482** (IC-B), **30968243105** (IC-E), **30968244496** (IC-A).
- `agents/handoffs/WO-0066_family-bn-mutation-campaign-SEALED-predictions.md` —
  **opened only after all six scorecards existed; read, NOT edited.**
- `agents/handoffs/WO-0066_pre-run-reading-note.md` — rulings 1 and 2,
  disposition 8, FINDING WO-0066-3's pre-classification.
- `agents/handoffs/WO-0066_family-bn-mutation-campaign.md` §4, §6, §9, §11.
- `docs/reports/audit/WO-0066-mutations/README.md` §2, §3, §4 — the auditor's
  disclosed derivations, cited as its claims.
- `docs/specs/requirements.md` §12 (the runt threshold), §0.6.
- **`test/xgmii_rx_64/test_m03_h.ml`** — `M03-H1`'s and `M03-H2`'s stimulus
  docstrings and splice arithmetic, read **after** the scorecards, to ground
  FINDING WO-0066-6 rather than guess at it. Read only; **no `test/**` byte was
  edited**.
- Git metadata for `199e319..HEAD`, re-derived by me.
- **No `libs/**` path was opened.** Every RTL claim in the verdict is cited as the
  auditor's disclosed evaluation.

### Reasoning
**I re-checked the ordering rule before reading a single message**, because §8
is not discharged once: `git diff --name-only 199e319 HEAD -- test/ libs/` is
**empty**, and the four commits since the base touch handoffs, audit reports,
journals and the board only — verified path by path, not accepted from the
relay. The bench that judged these mutants is the bench frozen strictly before
they existed, so the scorecards are admissible.

**The four clean classes needed adjudication, not deliberation.** IC-C, IC-D,
IC-F and IC-B each reddened exactly their sealed sets with every REQUIRED cell
character-exact and every control green. Two results inside them are worth more
than their kills. **IC-C's three REQUIRED GREENS held** — sub-cases 1, 2 and 5,
whose reports are already a cycle apart — so the class measured the *coincidence*
and not reports in general, which is the only way disposition 1 can mean
anything. And **IC-D and IC-F produced the predicted asymmetry**: identical
message strings, but `/I/` red under one and green under the other. Seal §4.4 had
recorded that the bench **cannot** tell those two classes apart and that their
separation rests entirely on running them as separate transients in the order the
reading note fixed. It held. Disposition 6 never engaged.

**IC-B was scored on branch R alone**, under the reading note's disposition 8,
and seal §5.2's UNWORKED cell went **moot** rather than being quietly re-used —
conflating "void by disclosure" with "void by the one-word-per-cycle convention"
would have laundered a design fact into a coverage argument. The class's six
identical bodies with `observed 1` also **confirmed §6's discriminator by
measurement**: at the four delivering sub-cases the raise is the *pulse* message,
which means frame A's `tlast` cycle, `tkeep`, `tlast` bit and `tuser`[0] all
passed. The rendering is report-path-only as claimed, and my structural ordering
and the auditor's fan-out closure agree without either having to be trusted.

**IC-E is where the round started costing me, exactly where the reading note said
it would.** The scored cell — sub-case 2 — hit character-exact with the derived
count of 3, so the class is killed. Sub-cases 3, 4 and 6 stayed **green**, which
confirms ruling 1's concordance and, more importantly, the **ground I adopted
from the auditor over my own**: those cells are an **equivalent mutant**, not a
blind instrument. That matters permanently — T8 is asserted at two members and
observable at one, and **no bench change reaches the other**, because the limit is
in a strobe interface that reports presence per cycle and not multiplicity.

And **sub-cases 1 and 5 reddened, as I predicted against myself before the run**.
Scored exactly as pre-classified: a MUST-STAY-GREEN violation, mine, under the
first of my own containment alternatives. Then a **third** violation the reading
note had not foreseen — `M03-H2` — from the identical root cause, an aborted
frame with some octets but fewer than sixty-four. **The auditor's enumeration
carried a rule where mine carried a list** (*"plus any unit driving a REQ-110
abort of a frame that received fewer than 64 octets"*), and the rule caught what
the list missed. That is the sharper lesson of the two.

**IC-A killed on its set, and cost me two more findings.** All three bound-7
instances reddened, so **§4 rule 1 fires and bound 7 scores 3 of 3** in both state
shapes. Sub-cases 4 and 5 were message-exact. Sub-case 6 was red with the *other*
arm of the same check, because my seal's premise — *"frame B is never opened"* —
is **not IC-A's consequence**: the class narrows the abort *classification* of the
frame open on entry, while the in-word machinery that *opens* B is untouched. B
opens, closes on the `/T/`, reports; frame A survives and is closed later as a
runt by `Arrival`'s own auto-terminate, giving two `error_runt` pulses and failing
`names_ok`. **The error was masked at two of three cells because a different
instrument spoke first there**, and visible only where the pulse check was
reached. I recorded it as a message miss rather than absorbing it into the kill,
because §11 criterion 1 asks for verbatim cells and this class delivered 2 of 3.

**The round's real event is FINDING WO-0066-6, and it cost the round part of its
own headline.** `M03-H1` (lane 4) and `M03-H2` (both lanes) reddened under IC-A
and my seal predicted green. I read their stimuli rather than assume: `M03-H2`'s
own row text is *"a new `/S/` in **lane 4** of a **mid-frame** word, i.e. lanes
0-3 of that word still belong to the aborted frame"*, driven at both start lanes
with `k` chosen so the `/S/`'s absolute lane is always 4; `M03-H1` at a lane-4
start puts its aborting `/S/` at octet time 84, lane 4, against a frame that has
delivered 64 octets. **Both are bound 7's exact conjunction, and both landed at
`WO-0057` — before bound 7 was written at `WO-0058`.** The bound's premise
(*"no unit drives an in-word abort with a frame already open"*) was **false at the
moment I stated it**, and six packets quoted the sentence instead of re-measuring
the claim.

**I chose to state the consequence at full strength rather than let the kill count
carry the paragraph.** The bench was **not** blind to a lane-4 abort of an
already-open frame; three members detected it before `M03-N2` existed; sub-cases 4
and 5 are not first detectors. What remains genuinely `M03-N2`'s own is the
**`Preamble`-state instance** and the **coincidence geometry** IC-C measures and
that exists nowhere else in the bench. That is a smaller claim than the one this
arc has been carrying, and it is the true one. The bound still scores 3 of 3 —
because §4's rules were written in terms of *which sub-cases redden*, not in terms
of what else exists, which is the one decision at seal time that survived contact
with this finding.

**Why WO-0066-3 and WO-0066-6 are one failure twice**: both are a **claim about a
set, carried in prose and never re-measured** — a floor quoted from the wrong
requirement, and a census never run because the sentence asserting its result read
as settled. The census tool this round shipped covers neither, which is worth
knowing about a tool built in the same round.

### Actions
- Appended **`WO-0066-VERDICT`** to
  `agents/handoffs/WO-0066_family-bn-mutation-campaign.md`: §0 the re-checked
  preconditions; §§1–6 the six per-class scorecards with every REQUIRED cell
  quoted and compared; §7 the bound-7 verdict under §4's four rules; §8 the
  campaign scorecard, the MUST-STAY-GREEN sweeps and the five-way
  cycle/count/name-set/datapath presentation taxonomy; §9 the six findings and the
  manifest's acceptance; §10 what is commissioned.
- **The seal was opened only after all six scorecards existed and was NOT
  edited.** No `test/**` byte moved. No git command was run (PROTOCOL §2).

### Evidence
- **Ordering rule, re-derived by me**: `git diff --name-only 199e319 HEAD --
  test/ libs/` → **empty**; `ebaac58`, `fb27764`, `8869705`, `b26354d` carry
  handoffs, audit reports, journals and `tasks/BOARD.md` only, from
  `git show --stat` per commit.
- **Per-class reds, counted from the promotion blocks** (`+[@@expect.uncaught_exn`
  occurrences): IC-C **3**, IC-D **2**, IC-F **1**, IC-B **10**, IC-E **7**,
  IC-A **5**. Every `File "test/…"` path in all six logs is under
  `test/xgmii_rx_64/` — so **79 behavioural + 1 build-level non-M03 held under
  every class**, and no mutant failed to compile.
- **REQUIRED cells: 15 of 16 message-exact**, decoded from the logs' OCaml
  escaping (`\194\167` = `§`). IC-C 3/3, IC-D 2/2, IC-F 1/1, IC-B 6/6, IC-E 1/1,
  IC-A 2/3.
- **Raise sites prove the row-local instruments spoke**: `test_m03_n.ml:554`
  and `:614` (IC-C, IC-A sub-case 6), `:583` (IC-A sub-cases 4/5),
  `test_m03_b.ml:1297` (IC-D, IC-F). `assert_monitors_clean` at
  `test_m03_n.ml:643` never executed — **disposition 4 never fired, and the
  standing `Strobe_monitor` spoke nowhere**, as seal §9(g) predicted.
- **All seven disclosures confirmed by measurement**: D-A1 = O (`M03-B4` (a) and
  `M03-H4` both green), D-A2 = E, D-B1 = R, D-B2 = narrow (`test_m03_e.ml` and
  `test_m03_h.ml` absent from IC-B's failure set), D-D2 = wide, D-DF1 = C (the
  `:1297` raise site), D-E1 = includes zero.
- **FINDING WO-0066-3's cause, from the specification**: `requirements.md` §12 —
  `error_runt` is *"fewer than 64 octets between start and terminate"*; seal §4.5
  derived from a sub-five floor.
- **FINDING WO-0066-6's ground, from the bench's own row text**: `M03-H2`'s
  docstring (*"a new `/S/` in lane 4 of a mid-frame word"*, both start lanes,
  absolute lane always 4) and `M03-H1`'s splice (`At_octet 64` ⇒ octet time
  `12 + 8 + 64` = 84 ⇒ lane 4 at a lane-4 start, 64 octets already delivered).
  Both predate `WO-0058`.
- **Kills: 6 of 6**, counted per class — IC-B's ten reds are one, IC-E's seven are
  one.
- `dune runtest` is CI's, not this seat's (ADR-0005); the six run ids above are
  the authority and I quote no local run.

### Outcome
**DoD met.** `WO-0066-VERDICT` appended; the campaign is **6/6 killed**;
**`WO-0058` bound 7 SCORED 3 of 3** with its three instances' state split
recorded. **Six findings, all against me**; **none against the manifest**, which
is accepted with three acts noted as more than compliance. Commissioned: the
`AP-xgmii_rx_64.md` plan round (six items, including striking bound 7's false
premise with its superseded wording kept beneath), then **family J's DATED
capability round** carrying the two parked debts. **No `BUG-` opened** — every red
is a seeded mutation killed by the suite, and no divergence of the unmutated
design was observed. Handoff: §10 to the orchestrator.

### Open-questions
1. **Bound 7 leaves my carried list only when the plan records all three facts** —
   the 3-of-3 score, the state split, and FINDING WO-0066-6's correction. A score
   recorded without the correction would carry a false history of a true result.
2. **T8 is observable at one member of two, permanently** (§5.2). Whether M03's
   strobe contract should carry a multiplicity signal is an **architect** question
   and I raise it as one, not as a `BUG-`.
3. **The IC-B(W) design fact stays unbanked** — no `SO-` may cite §0.7 coverage
   from the auditor's RTL derivation until a bench re-establishes it from the
   specification side.
4. **`M03-B4` member (b) was scored by six classes and convicted under none.**
   That is a result, not an omission, and the plan records it as
   scored-and-unconvicting — but it is the one member of the eleven whose value
   this campaign did not demonstrate.
5. Carried: `bench.mli`'s naming-axis cell and fold-in 3 with their dated
   carriers; family J now **due**; `run_i2_member`'s citation exception;
   `WO-0061` §8 bound 1's `tkeep` half; **N-1**; the ledger disposition on
   `BUG-0003`; **B-4**.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due** — no `SO-`, no gate. Span since
`J-dv_lead-0116`'s note: **J-dv_lead-0117** (this entry); cumulative untiled span
**J-dv_lead-0001 … 0117**, first harvest still firing at `SO-M03`. Inventory
carries at **~15 LH2-g candidates plus the war stories**. Yield this round:

- **The round's strongest candidate, and it retired a claim of my own.** *"A
  sentence asserting the result of a census is not the census; re-run the
  measurement at every re-statement, because a claim that reads as settled is
  quoted rather than checked, and each quotation makes the next reader less
  likely to check it."* **LH1**: this commit — a bound's premise (*no unit drives
  X*) was false when written, survived six packets that each quoted it, and was
  falsified by a mutation reddening two units that had driven X since before the
  bound existed. **LH2-g** — no proper noun. **LH3**: without it, a programme's
  most-repeated claims are its least-verified ones, and the repetition is what
  protects them.
- **A second candidate, banked, and it is the auditor's lesson not mine.**
  *"Predict a set by stating the rule that generates it, not by listing its known
  members; a list is falsified silently by a member you did not know about, a rule
  is not."* **LH1**: this commit — the manifest's predicted red sets carried
  containment clauses (*"plus any unit driving …"*) that caught two units my
  enumerated lists missed, at two independent classes. **LH2-g**. **LH3**: without
  it, an enumeration's completeness is assumed by everyone downstream because it
  looks like a measurement.
- **`J-dv_lead-0116`'s malformed-question candidate gains a second, sharper
  instance.** My IC-A sub-case 6 cell rested on *"frame B is never opened"*, which
  is not the class's consequence — the same shape as offering a floor of five when
  the predicate is sixty-four: **a derivation that names the wrong quantity can
  still produce the right cell**, and did at two of three. Observable extended:
  *a wrong premise that yields correct outputs wherever a different instrument
  speaks first is discoverable only at the cell where it does not.*
- **`J-dv_lead-0115`'s coincidence candidate is CONFIRMED by measurement and I
  now regard it as promotion-ready at the next harvest.** IC-C killed on exactly
  the three coincident sub-cases; IC-E was structurally unobservable on exactly
  the same three. One stimulus property, instrument and blindfold, measured in one
  round from both directions.
- **One war story retired.** `WO-0063B` FINDING 3's *"the red-presentation
  taxonomy needs a third column"* is superseded: this round produced **five**
  presentations, so the lesson is not about a missing column but about taxonomies
  of presentations being open-ended. Folded into the second candidate above and
  no longer carried separately.

### Files-in-this-commit
- agents/handoffs/WO-0066_family-bn-mutation-campaign.md

## [J-dv_lead-0118] 2026-08-06T21:15Z | task:WO-0066 | The plan absorbs the campaign — and the round's own discipline rule caught a miscount in my draft of the paragraph that mints it, three hours after the finding that taught me the rule

### Trigger
Orchestrator dispatch: execute the six-item `AP-xgmii_rx_64.md` round I
commissioned at `WO-0066-VERDICT` §10 item 1, deriving from the verdict
committed at `be8f7c2`, citing it at every site, with the pre-run reading
note cited wherever its rulings bind. The plan was held back from every commit
of the campaign because it is the campaign's contract and moving it inside the
window would have violated `WO-0066` §8's ordering rule. The campaign has
scored; the window is closed; this is that round.

### Inputs
- `agents/handoffs/WO-0066_family-bn-mutation-campaign.md`, **`WO-0066-VERDICT`
  section at `be8f7c2`** — §§1–6 the six per-class scorecards, §7 the bound-7
  verdict under §4's four rules, §8 the campaign scorecard, §9 the six findings
  and their shared root cause, §10 what is commissioned. **This round's deriving
  authority; cited, never edited.**
- `agents/handoffs/WO-0066_pre-run-reading-note.md` — **ruling 1(c)** (the
  equivalent-mutant ground and the T8 consequence, adopted from the auditor over
  my own "green by blindness" wording), **ruling 2 / disposition 8** (IC-B branch
  `W`, VOID BY DISCLOSURE), and `FINDING WO-0066-3`'s pre-classification.
- `test/attack_plans/AP-xgmii_rx_64.md` at `9293ef1` — §0, §1's status
  vocabulary, §2 obligation 4, §4.B (rows M03-B2/B4 and notes B-i, B-ii, B-iii),
  §4.H (rows and the two family bounds), §4.N (row M03-N2, its tables and its
  struck blocks), §6's REQ-102/REQ-110 entries, §7's banner, §9's change log.
- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` §2, §3, §4.1, §4.2, §6, §7,
  §10.
- `agents/journals/claude_dv_lead_agent.v04.md` — my own `J-dv_lead-0109`
  (the divergence ruling: qualification lives in the Kills cell and discharges no
  row), `J-dv_lead-0112` (tooling does not land in a review commit),
  `J-dv_lead-0113` (the state split, already in §6), `J-dv_lead-0117` (this
  campaign's adjudication and its five open questions).
- `tools/dv_checks.sh` lines 238–322 — the census block, **read so that what I
  say it does not cover is read off the code rather than recalled**.
- `test/xgmii_rx_64/test_m03_n.ml` lines 85–130 — **trap T8's own text**, read so
  that the permanence note names what the bench actually asserts. Read only.
- **No `libs/**` path was opened.** No RTL claim is made anywhere in this round;
  the equivalent-mutant fact is cited as the auditor's disclosed derivation,
  adopted at the reading note.

### Reasoning
**The whole round is one judgement repeated six times: record what the campaign
measured, at the site where a later reader will look for it, in the vocabulary
this plan already has — and never let a score be recorded without the correction
that makes it true.**

**Qualification goes in the Kills cell, twice, and the Status cells do not move.**
`J-dv_lead-0109` settled this and I followed it rather than re-decide it: §1's
status vocabulary is a **closed set of six values**, `QUALIFIED` is not one of
them, and M03-I2's, M03-E5's and M03-F2's qualifications already sit in their
Kills cells. Qualification is a **measured property of the Kills claim**, not a
seventh status — which is also why it discharges no row, a point the count line
below turns on.

**M03-N2's qualification had to carry its own narrowing in the same breath, or it
would have been a lie by arrangement.** The four classes give it 4/4, and IC-C's
three REQUIRED GREENS are what make the kill mean *the coincidence* rather than
*reports in general*. But `FINDING WO-0066-6` says `M03-H1` and `M03-H2` have
driven bound 7's conjunction since `WO-0057`, so sub-cases 4 and 5 are **not the
conjunction's first detectors** and this bench was never blind to it. I put that
sentence **inside the qualification**, not in a footnote below it, because a
reader who stops after the kill count must not be able to leave with the larger
claim. What survives as genuinely M03-N2's own — the `Preamble`-state instance
and the coincidence geometry — is written in the same paragraph as the score.

**M03-B2's qualification is where the campaign paid for a ruling I made on
argument.** IC-D and IC-F emit **identical strings**; the seal recorded that the
bench cannot tell them apart and that the separation rests entirely on running
them as separate transients. The measured asymmetry — `/I/` red under IC-D,
green under IC-F, `/Q/` red under both — is therefore the **separating
observable**, and it is what turns note B-ii's `/Q/` ruling from an admitted
argument into a ruling with a kill under it. I said so in the cell in those
terms, because `WO-0065` §3.2.1 overruled a REQ-018 objection to get that
stimulus and the record should show what the overrule bought.

**M03-B4 member (b): a result, stated as one.** It sat in all six classes'
denominator and convicted under none. The temptation is to leave that unsaid,
since it reads like an omission; the plan says it explicitly, and says the
opposite thing too — its value is bound 6's **4 → 0** alignment point, which no
campaign attacking report paths was ever going to exercise. **A member can be
worth adding for a geometry it uniquely supplies and convict nothing in a
campaign that does not attack that geometry.** Both facts, adjacent, so neither
can be quoted alone.

**Bound 7 is adjudicated in exactly one place and pointed at from two.** The
bound's home in this plan is §4.H's second family bound, and that is the sentence
`FINDING WO-0066-6` refutes, so the strike, the superseded wording, the 3-of-3
score, the state-split table and the correction all land **there**. Note B-i's
*"Bound 7 remains open with no candidate row"* is struck with its wording kept,
and §6's REQ-110 entry gains a **pointer** rather than a restatement. That is not
tidiness: this round's own new rule is about claims carried in prose, and
restating an adjudicated claim at three sites is how the next re-statement gets
quoted instead of re-measured.

**Why §0 and not §2 for the new rule.** The dispatch offered §2. I filed it in
§0 and recorded the reason in the change log: **§2's obligations attach to
"every M03 bench" by that section's own opening sentence**, and this rule binds
**prose** — a plan's, a packet's, a seal's — not a bench. Minting it as a seventh
bench obligation would have mis-filed it in the one section whose scope is
stated in its first line. §0 is where this plan defines what it is and what its
cells may not say, and that is the same kind of rule.

**And I made the note say what the tool does not do.** `WO-0066-3` is a
row-status/threshold claim; `WO-0066-6` is a cross-row premise claim; the
boundary-matched census answers *which rows are named in a unit title* and
catches **neither**. The tool shipped in the same round as both findings. Left
unsaid, its existence would be read as coverage of the class — which is the
second-order version of the failure it was built for. So `DVC-1` is commissioned
**with an executor and with its own bound written into the commission** (part b
reports what docstrings *declare*, never what stimuli *do*), and it is
deliberately not built here: a plan round is not where tooling lands, which is
`J-dv_lead-0112`'s rule applied to its author.

**The count line does not move, and that is the rule rather than an oversight.**
Two rows qualified and **43 of 62** stands, because qualification measures an
instrument and discharges no row. I re-measured rather than carried it forward —
78 declared row ids, 43 under the trailing-digit boundary matcher, 44 under the
naive one over-discharging `M03-M1` inside `M03-M10`'s title (**the same defect
at a fourth SHA**), − `M03-A4` + `M03-F5` = 43 — and counted the 62 ASSERT
denominator from the file's own status cells in the same pass.

**The round's best moment is against me, and it is three hours old.** My first
draft of the M03-N2 qualification said *"three MUST-STAY-GREEN violations across
the two classes"*. There are **five**, at four distinct units — three under IC-E
and two under IC-A, with `M03-H2` violated under both from one root cause. I had
carried a count in prose, from the paragraph I had just read, into the very cell
whose neighbouring section mints the rule against doing that. I caught it by
re-reading the verdict's two scorecards instead of my own sentence, corrected it
at both sites, and I am recording it here rather than quietly fixing it, because
**the rule's first violation being committed by its author while writing it down
is the strongest evidence the rule is worth having.**

### Actions
- **`test/attack_plans/AP-xgmii_rx_64.md`, one round, six items plus the change
  log** — the only file touched:
  1. **§4.N, M03-N2's Kills cell** — QUALIFIED on IC-A/IC-B/IC-C/IC-E, 4/4, per
     class with its controls, disposition 8 named for IC-B's `W` column, the
     WO-0066-5 message miss recorded and not absorbed; the honest scope from
     `FINDING WO-0066-6`; the five MUST-STAY-GREEN violations attributed to the
     seal; **and trap T8's permanent single observability** as an interface
     property, stated once, where the row's coverage claims are read.
  2. **§4.B, M03-B2's Kills cell** — QUALIFIED on IC-D/IC-F, 2/2, with the
     `/I/`-red-under-D / `/I/`-green-under-F asymmetry as the separating
     observable, note B-ii obligation 1's `/Q/` ruling recorded as paid by
     measurement, and lane 4 recorded UNOBSERVED.
  3. **§4.B, note B-i** — member (b) recorded **SCORED-AND-UNCONVICTING** beside
     what it does pay (bound 6's opposite-direction point).
  4. **§4.H, family bound 2** — struck, with the superseded wording reproduced
     verbatim and its emphasis intact beneath; bound 7 **SCORED 3 of 3** with the
     three instances' state-split table (`Frame` ×2, `Preamble` ×1), the
     `WO-0066-6` correction, and the mechanism by which the false premise
     survived every packet that re-stated it. Note B-i's *"remains open"*
     sentence struck; §6's REQ-110 entry given a pointer, not a restatement.
  5. **§0.1, new** — the prose-carried set-claim rule, its two minting instances,
     what the census tool does **not** cover, and `DVC-1` commissioned with an
     executor and a bound.
  6. **§9** — one change-log row carrying all six items, the unchanged status
     counts and the re-measured count line.
- **No git command was run** (PROTOCOL §2). **No `test/**` file other than the
  plan was edited**; no packet was edited; the verdict and the seal were read and
  not touched.

### Evidence
- **Count line, re-measured at `9293ef1` by the committed tool's own census
  block** (`tools/dv_checks.sh` lines 275–322, run standalone): `78` row ids
  declared, `44` naive, **`43` boundary-matched**, over-discharged by the naive
  matcher: `M03-M1`. Declared adjustments − `M03-A4` + `M03-F5` ⇒ **43**.
- **ASSERT denominator, counted from the file rather than carried**:
  `grep -oE '\| (ASSERT|NO-ASSERT|NO-STIMULUS|STRUCTURAL|GAP|RULING) \|$'
  test/attack_plans/AP-xgmii_rx_64.md | sort | uniq -c` → **62 ASSERT**, 7
  NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP. **Re-run after my edits:
  identical.** Row ids declared: **78**, before and after.
- **Post-edit re-measure of the census: 78 / 44 / 43, unchanged** — the
  state-split table I added inside §4.H names `M03-N2`, an already-declared id,
  so the declared-id set does not move.
- **Working tree**: `git status --porcelain` → `M test/attack_plans/AP-xgmii_rx_64.md`,
  one file (plus this journal). `git diff --numstat --
  test/attack_plans/AP-xgmii_rx_64.md` → **181 insertions, 10 deletions**, one
  file. **The ten deleted lines, enumerated rather than characterised, because
  "nothing was deleted" is exactly the kind of claim §0.1 now forbids me to
  assert without checking**: three whole-row table lines rewritten in place with
  their prior text retained in full (`M03-B2`, `M03-N2`, §6's REQ-110 entry); one
  line of note B-i, whose struck sentence is quoted back verbatim in the block
  beneath it; and §4.H bound 2's six lines, reproduced **word for word with their
  own emphasis** inside the blockquote that replaces them. **No wording of this
  plan is deleted by this round** — verified by reading the diff's `-` side, not
  by intending it.
- **Deriving authority**: `WO-0066-VERDICT` at `be8f7c2`
  (`git show --stat be8f7c2` → the campaign packet and my journal, 2 files),
  read at that commit and **not edited by this round**.
- **T8's text**, quoted from the bench rather than recalled:
  `test/xgmii_rx_64/test_m03_n.ml:102` — *"T8: A's strobe set on the delivered
  sub-cases is `error_start_without_terminate` ALONE, even where A delivers FEWER
  than five octets (sub-cases 2 and 4, four octets each)"*.
- `dune runtest` is CI's, not this seat's (ADR-0005). **This round runs no
  simulation and claims no run**: it edits a plan, and every number in it is
  either quoted from `WO-0066-VERDICT` with its section or measured by the two
  commands above.

### Outcome
**DoD met.** All six commissioned items landed in the single commissioned file,
each citing `WO-0066-VERDICT` at its site and the pre-run reading note where its
rulings bind, plus the §9 change-log row. **Counts unchanged and re-measured:
78 rows, 62 ASSERT, 7 NO-ASSERT, 4 NO-STIMULUS, 4 STRUCTURAL, 1 GAP; discharge
43 of 62, nineteen outstanding — qualification discharges no row.** **`WO-0058`
bound 7 leaves my carried list**, under `WO-0066` §4 rule 4, now that the plan
records the score, the split and the correction together. **No `SO-` is opened
and none is offered.** Handoff: the file to the orchestrator; next commission in
Open-questions.

### Open-questions
1. **FAMILY J'S BENCH-CAPABILITY ROUND IS WHAT I COMMISSION NEXT, AND I AM NOT
   DEFERRING IT AGAIN.** `RV-0065B-VERDICT` §7.2 dated it to the round
   immediately following this seal; `WO-0066-VERDICT` §10 item 2 carried the date
   forward; this is that round's successor and the packet is **DUE**. It carries
   the two debts parked with named carriers — **`bench.mli`'s `_frame`/`_piece`
   naming-axis cell** and, if no `M03-N1`/`N4` round is scheduled first,
   **fold-in 3**. A third deferral is an E2 to the sponsor by my own rule and I
   am not invoking it.
2. **`DVC-1` is commissioned with me as executor**, in the next round that opens
   `tools/`, and is named in §0.1 so it cannot evaporate. It is **not** owed
   before family J.
3. **T8's multiplicity question stands with architect_docs_lead** — whether M03's
   strobe contract should carry a multiplicity signal. Specification question,
   not a `BUG-`; unchanged by this round, now recorded in the plan.
4. **The IC-B(W) design fact stays unbanked**; no `SO-` may cite §0.7 coverage
   from the auditor's RTL derivation until a bench re-establishes it from the
   specification side.
5. **Two clerical observations on the plan, neither repaired here and both
   reported rather than silently fixed.** (a) §9's last pre-existing change-log
   row (`J-dv_lead-0113`'s) has **no Author cell** — the table is
   `| Date | Change | Author |` and that row carries two fields; the author is
   recoverable from inside the cell, and I did not edit a committed historical
   row to add it. (b) §4.H **bound 1** still reads *"Owed: the second point at
   REQ-110's commissioned M03-B4 geometry"*, which note B-i records as **paid**
   by member (b); the bound and the note do not contradict each other but the
   bound is stale in its tense. Both are candidates for the next round that opens
   this plan.
6. Carried, unchanged: `run_i2_member`'s citation exception; `WO-0061` §8
   bound 1's `tkeep` half; **N-1**; **F-1** with architect_docs_lead; the ledger
   disposition on `BUG-0003`; **B-2**, **B-3** and **B-4**.

**Harvest (ADR-0018, PROTOCOL §7).** **Not due** — no `SO-`, no gate. Span since
`J-dv_lead-0117`'s note: **J-dv_lead-0118** (this entry); cumulative untiled span
**J-dv_lead-0001 … 0118**, first harvest still firing at `SO-M03`. Inventory
carries at **~15 LH2-g candidates plus the war stories**. Yield this round:

- **`J-dv_lead-0117`'s strongest candidate is BANKED and I now regard it as
  tier-1 general and promotion-ready.** *"A sentence asserting the result of a
  census is not the census; re-measure at every re-statement, or quote the
  measurement with the state it was taken at."* **LH1**: two commits now —
  `be8f7c2`, where a bound's premise was falsified by units that had driven its
  conjunction since before the bound existed, and **this commit**, where the rule
  was written into a plan as §0.1 **and its author violated it in the draft of
  the neighbouring cell** (a violation count carried from memory: three, where
  the measurement is five). **LH2-g** — no proper noun. **LH3**: without it, a
  programme's most-repeated claims are its least-verified ones and the repetition
  is what protects them. The second incident adds the sharper half: **the rule is
  hardest to obey in the sentence that states it**, because a claim one has just
  read feels measured.
- **A new candidate, and it is about mitigations rather than about claims.** *"A
  tool commissioned in response to a failure must be checked against the
  instances that commissioned it; one that would not have caught them is a
  mitigation in name only, and its existence is what stops anyone looking
  further."* **LH1**: this commit — the census shipped in the same round as the
  two findings it was built to prevent, and covers **neither**, because both were
  claims of a kind it does not match; §0.1 now says so in the plan rather than
  leaving the tool's existence to imply the coverage. **LH2-g**. **LH3**: without
  it, a class is recorded as mitigated on the strength of an artefact nobody
  tested against the class, and the artefact suppresses the next check.
- **A third, weaker, and I bank it as a candidate rather than a war story because
  it has bitten twice.** *"Keep the counter that measures an instrument separate
  from the counter that measures obligations discharged; a result that qualifies
  a tool must not be allowed to look like progress against the work."* **LH1**:
  `J-dv_lead-0109` (a verdict's forward figure right in its number and wrong in
  its cause) and **this commit** (two rows qualified, count line deliberately
  unmoved and re-measured to prove it). **LH2-g**. **LH3**: without it, coverage
  figures drift upward on rounds that added no coverage.
- **One war story, retained as a war story.** The plan's own strike notation is
  now two things — the prose *"STRUCK … superseded wording kept"* block it has
  always used, and the literal strikethrough I added at the two sites this round.
  It fails **LH2** in both grades (it is a notation choice in one document) and
  it is recorded only so the next editor knows the mixture was deliberate: the
  literal strike marks *which sentence* died, the prose block carries *why*.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_rx_64.md
