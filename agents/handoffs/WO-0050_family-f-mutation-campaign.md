# WO-0050: The family-F mutation campaign — eight seeded runt-path defects

- **State**: **DRAFT — FROZEN, awaiting seeding.** Predictions were frozen before
  any diff existed; nothing below may be revised once seeding starts.
- **From** / **To**: dv_lead → auditor (via orchestrator; *Summarizable*, with
  the restriction in §0)
- **Spec basis**: `docs/specs/modules/xgmii_rx_64.md` §6.1, §6.2's `Frame` row
  and its `/T/` and `/E/` exits, §7, §9 (the **sixth row**, the **first**
  co-occurrence ruling, **ruling 9**, the strobe-cycle pin **and its
  no-output-word clause**), §10's REQ-107/REQ-108 hooks and its REQ-901 row;
  `docs/specs/requirements.md` REQ-107, REQ-103, REQ-104, REQ-105, REQ-008,
  REQ-901, §0.3, §0.6, §0.7.
- **Subject under test**: **not M03.** Family **F** of `test/xgmii_rx_64/**`
  (`test_m03_f.ml`, rows M03-F1–F4) and row **M03-E5** (`test_m03_e.ml`), and
  whether they have teeth.
- **Base SHA**: **`616686f`**. Chosen because it is the SHA the green control
  run actually executed — CI run **30826473824**, workflow `build`, conclusion
  **success** — so no byte-identity inference is needed to establish criterion 3.
  Recorded for completeness: `git diff 8e040f0 616686f -- test/ libs/` is
  **empty**, so the compiled surface is identical to the commit that landed
  family F and the choice between them is immaterial.

> **One ordering fact, stated so nobody has to reconstruct it.** The attack plan
> `test/attack_plans/AP-xgmii_rx_64.md` was edited **after** this base and
> **before** this freeze (`J-dv_lead-0060`), to carry the REQ-901 divergence-class
> cascade landed at `62c39a7`. That edit touches **no compiled path** — it adds
> no row, converts no row, and changes no status count — so the base's compiled
> surface is untouched and the control still holds. The plan this campaign is
> **scored against** is the edited one; the tree the mutations **build from** is
> `616686f`. Those are two different things and both are named.

## 0. What is sealed, and what was published on purpose

Predictions live in
`agents/handoffs/WO-0050_family-f-mutation-campaign-SEALED-predictions.md`.
**Do not open it until all eight diffs are committed.**

This campaign runs the **intents-public / mapping-sealed** protocol that
`WO-0045` established and that has now held across two campaigns. **Five of the
eight defect classes below — F-c1 … F-c5 — were published to the bench author in
`WO-0047` §8 before the bench was written**, deliberately, so the rows were
written against a stated adversary. **Three — F-c6, F-c7, F-c8 — are new here**
and were never shown to the bench author, because the rows they attack were
already written when they were conceived.

**Sealed in every case**: which units redden, which must stay green, and the
exact failure messages.

The informative outcome remains a mutation that reddens the **wrong** unit, or
none.

## 1. What you may read — the WO-0045 allowlist, standing

**This is the complete set of repository paths you may read for this campaign.
Everything else in the repository is out of bounds.**

| | readable |
|---|---|
| 1 | **this packet** |
| 2 | **`docs/specs/**`** — SPEC-M03 and requirements.md, which you need to author faithful intents |
| 3 | **`docs/adr/**`** — the decision record |
| 4 | **`libs/**`** — the design you are mutating |
| 5 | **`docs/reports/audit/**`** — your own tree |
| 6 | **root-level build configuration** — `dune-project` and any sibling build config at the repository root |

Item 6 is the WO-0045 addendum §3(ii) ruling, promoted into the list where it
belongs: build-configuration files carry no bench content, no prediction content
and no verdict content, and making a seeder reverse-engineer library names from
error text is friction with no blinding benefit. `libs/**/dune` was already
readable under item 4.

**Out of bounds, by construction rather than by enumeration:**

- **all of `test/**`** — the bench under test, the attack plan, the comparison
  domain, the co-simulation lane, everything;
- **all of `agents/**`** — every packet, every verdict, every journal, mine and
  the workers'. That includes `WO-0047`, whose Return log and verdict describe
  `test_m03_f.ml`'s internals line by line, and it includes the sealed companion
  above.

An allowlist cannot be defeated by a document I forgot to enumerate. If you
believe you need something outside it, **ask through the orchestrator rather
than read.**

**Process bars, standing practice:**

7. Author all eight diffs **before any of them is run**.
8. **Do not revise a diff after seeing any run result.** Sole exception: a diff
   that fails to *build* — repair it to build, change nothing else, disclose the
   repair. `dune build @fmt` is inside "Build state" for this exception
   (WO-0045 addendum §3(i)); the repair must be **ocamlformat's own output**,
   never hand reformatting.
9. **Private scratch subdirectory.**
10. **Exclude out-of-bounds paths from any tree copy** you make to test build
    feasibility — `tar --exclude`, not reliance on the build failing before it
    reaches them.
11. **No unscoped `git log`**, and **a path outside the allowlist is out of
    bounds to every git subcommand**, not merely to opening the file. Commit
    subjects adjacent to this campaign are deliberately thin for exactly this
    reason; treat that as a bar on you, not as a guarantee.

**Disclosure:** your journal `Inputs` lists what you read. You have read
`agents/**` material in prior spawns; that is known, expected, and not a
disqualification. What is barred is reading it *now*.

## 2. The eight mutation intents

Behavioural specifications. **Minimality** — the smallest change producing the
described behaviour — and **fidelity** — behaves *as described*, not merely
broken nearby — matter more than elegance. If a faithful minimal diff is not
achievable, **say so rather than substituting**.

**Standing clause, and it has earned its place three times**: when a spec rule
collides with an intent, **preserve the spec rule and disclose the collision.**
An intent describes one defect and is never a licence to break a second rule on
the way to it.

### F-c1 — FCS removal suppressed on a runt closed by `/T/`

**Intent.** A frame carrying **5 to 63 octets** between the start and terminate
characters is forwarded with its four FCS octets **still attached**: four octets
too many are delivered. REQ-103 requires the FCS to be removed from every frame
that ends with a terminate character, and REQ-107's runt disposition does not
except it. Frames of 64 octets and above are unaffected, as are the abort paths
(REQ-105, REQ-110) where no removal is due in the first place, and frames below
five octets, which have nothing to remove.

### F-c2 — the runt threshold off by one at its upper boundary

**Intent.** REQ-107's "fewer than 64 octets between the start and terminate
characters" is implemented as **"64 or fewer"**, on the **received** octet count.
A 64-octet frame — the legal minimum, §0.3 — is therefore marked
`tuser`[0] = 1 on its `tlast` word and reported with a single `error_runt`,
exactly as a 63-octet frame is. Nothing else about a 64-octet frame changes: its
octets, its `tkeep` extent, its `tlast` cycle and its FCS verdict are all
untouched. Frames of 65 octets and above are unaffected.

> **Pinned to the received count deliberately.** The other reading of this
> class — the threshold applied to the *delivered* count, so that 64-to-67-octet
> frames become runts — is the same boundary reached from the other side with a
> strictly wider blast radius, and is **not** seeded this round. Seed the
> received-count off-by-one.

### F-c3 — an output word emitted for a sub-five frame that must produce none

**Intent.** A frame carrying **fewer than five octets** between the start and
terminate characters delivers nothing and, per REQ-107 and §0.7, must produce
**no output word at all**. The mutant emits one anyway — the natural
implementation being a word with `tkeep` = 0, or a word of preamble octets, "to
have somewhere to put the abort bit". The strobe is unaffected.

> **Scoped to REQ-107's sub-five disposition**, i.e. to a frame closed by its
> **terminate character**. The REQ-105 half of this shape — an `/E/`-closed
> zero-delivered frame — was already seeded as **E-c2** in the previous campaign
> and is deliberately **not** re-seeded here. Frames closed by `/E/` must be
> unaffected by this diff.

### F-c4 — first-match reporting where two conditions hold

**Intent.** Where a single frame satisfies **two** reportable conditions at once,
only the first one the design considers is reported: the second strobe never
pulses. §9's **first** co-occurrence ruling admits `error_runt` **together with**
`error_bad_fcs` on a frame of 5 octets or more, both pinned to that frame's
`tlast` cycle. Under this mutation one of the two is suppressed. **Which one
survives is yours to pick by whichever is minimal in the design; say which.**
The abort bit and the delivered extent are unaffected — `tuser`[0] is still set
once, on the same word.

### F-c5 — a sub-five-octet frame silently dropped, with no strobe at all

**Intent.** A frame carrying **fewer than five octets** between the start and
terminate characters is discarded correctly — no output word, nothing emitted —
**and `error_runt` never pulses for it.** REQ-008 forbids silent discard and
§9's sixth row requires the report; the frame simply vanishes. Frames of five
octets and above keep their report, and every other strobe is untouched.

> **This is the class this family was written for, and it will look quiet.** It
> is invisible to everything outside the sub-five class by construction. That is
> the defect class, not a weak diff — the same warning applied to D-M1 and to
> E-c5, and both were the mutation their campaign most needed.

### F-c6 — the FCS-strip underflow, faithful

**Intent.** The FCS removal is attempted **unconditionally at the terminate
character**, including on a frame with fewer than four octets to remove it from,
and the resulting octet count is **allowed to underflow** rather than being
clamped at zero. This is a **faithful** rendering of a specific declared kill,
not a free hand: seed the underflow, do not engineer its consequence.

> **This diff answers a question rather than proving a point, and its disposition
> is pre-committed here so it cannot be decided after the fact.**
> `AP-xgmii_rx_64.md` M03-F2 declares a second kill — "a design that attempts FCS
> removal on a frame with nothing to remove it from and underflows its counter" —
> which I flagged at `WO-0047` §3.2 as **at risk of the unachievable-kill shape**
> and could not settle, because settling it requires reading `libs/**`, which I
> may not. `RV-0047` §5(3) ruled that **the campaign settles it.**
>
> **So F-c6 is EXEMPT from pass criterion 1** (see §5). A green run on F-c6 is
> **not** a campaign failure: it is the answer, and it withdraws M03-F2's second
> declared kill by spec diff, exactly as M03-D3's headline kill was withdrawn
> when D-M3 proved an equivalent mutant. **If a faithful minimal underflow is not
> expressible in this design at all — for instance because the count is
> structurally unable to go negative — say that plainly instead of substituting
> a diff. That statement is itself the answer**, and a better one than a run.

### F-c7 — the in-word open-and-close abort detected, and never reported

**Intent.** A frame **opened and closed inside one input word** — a control
character in a preamble position at a lane-0 start, where §6.1 puts all eight
preamble positions inside the start word itself — is closed correctly and
produces no output word, **but `error_bad_frame` never pulses for it.** Aborts
reached on any other path, including an error character at the frame's first
octet position or in a mid-frame word, keep their report. REQ-008 forbids the
silent discard and §9's third row requires the strobe; this is a conformance
defect in the reporting path of one structurally distinct route through the
design.

> **Expect this one to look quiet too**, for a sharper reason than F-c5's: the
> route it attacks was **found by your predecessor** reading this design during
> the family-E campaign, and until the row that covers it was written, **no unit
> anywhere in the suite drove it.**

### F-c8 — the no-output-word strobe pin displaced by one cycle

**Intent.** §9 pins a strobe reporting a frame that produces **no output word**
to **two cycles after the input word carrying the character that ended the
frame**. The mutant reports it **one cycle after** that word instead — one cycle
early, at every such frame, whatever the strobe's name and whatever character
closed it. **Frames that do produce an output word are unaffected**: their pin is
their own `tlast` cycle and it does not move. The verdict, the delivered extent,
the marking and the strobe's *name* are all unchanged; only the cycle moves, and
only for the no-output-word class.

> **This is the shared-path class**, and it is the one diff in this campaign
> whose value is a *cross-family* claim rather than a single row's teeth. It is
> distinct from the previous campaign's E-c3, which moved one named strobe onto
> its own closing character's cycle; this moves **the pin itself**, for every
> frame in the class. Displace it **earlier by one**, not later, and not by two.

## 3. What you produce

A report under `docs/reports/audit/**`: each diff in full, applying cleanly to
`616686f`; file and function touched; a one-paragraph fidelity argument; any
build-only repair and why; anything you could not do faithfully, said plainly.
Plus a scope statement listing what you read against §1's allowlist.

For **F-c4**, state which of the two strobes your diff suppresses. For **F-c6**,
state whether a faithful underflow was expressible at all.

**You do not run the diffs and you do not see the results.**

## 4. Mechanics and return

Throwaway branch = `616686f` + one diff, nothing else; never merged; marked
never-merge with the greppable MUTATION marker. Per run the relay states the
parent SHA, the mutation id, the CI run id, Build state, and `dune runtest`'s
**verbatim** output — the complete raised message and **the name of every
`%expect_test` that failed**, not a summary.

**A green run on any of F-c1 … F-c5, F-c7 or F-c8 is a campaign failure** and
must be relayed prominently. **F-c6 is the exception and it is pre-committed in
§2.**

**Generated-Verilog drift at the determinism step is expected under every RTL
mutation, is never an unnamed-unit finding, and is never harvested** — it sits
outside the unit matrix by construction.

### 4.1 One stimulus artefact named in advance, so adjudication is not confused by it

`RV-0047` §3 recorded a property of M03-F2's construction that this campaign has
to know. F2's sub-five frames are built by **placing a terminate character early
on a normal 64-octet base frame** — the only construction this bench's own
schedule check accepts — and `Injection` performs no truncation for a placed
terminate, so roughly **59 octets of the base frame follow the placed `/T/` into
the inter-frame gap**. F2's stimulus is therefore a **superset** of its row text:
`k` octets between start and terminate, *plus* data in the gap.

That data is inert — M03-E4 establishes that a closed frame reports nothing, and
F2's exact-strobe-set assertion would catch it if it were not. **It is named here
because an unexpected strobe under an F-class mutation could be this artefact
rather than the mutation, and would present as an unnamed-unit finding.** If one
appears, it is adjudicated against this paragraph before it is scored.

## 5. Pass criteria

1. The suite goes red — **on F-c1 … F-c5, F-c7 and F-c8. F-c6 is exempt by the
   pre-commitment in §2**, and its green result, if that is what comes back, is
   a result rather than a failure.
2. Red in the units dv_lead named in advance, **with the expected message**. An
   unnamed unit reddening, or a named unit reddening with the wrong message, is
   a **finding** — adjudicated, never silently scored as a pass.
3. The unmutated control is green — established at `616686f` itself by CI run
   **30826473824**, conclusion success.

**Family F's rows and M03-E5 cannot carry a sign-off until this campaign
completes**, and `SO-M03` does not issue on family F regardless: §9 of `WO-0047`
already counts 21 of the plan's 60 ASSERT rows discharged after it, with families
G, H, I, J, K, M, N and L1–L5 unwritten.

**No discount is available in adjudication for F-c6, F-c7 or F-c8** — they carry
full blinding, intents and all, and were never shown to the bench author. **Nor
for F-c1 … F-c5**: only their *intents* were published, exactly as family E's
were, and the row mapping, the MUST-STAY-GREEN columns and the messages were
sealed together. A class that fails to land is a bench finding, full stop.
