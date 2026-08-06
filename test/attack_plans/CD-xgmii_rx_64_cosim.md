# CD-xgmii_rx_64: the comparison domain for the differential co-simulation lane

**WO-0044 Phase 0.** dv_lead, `J-dv_lead-0049`. Written **before any bridge
code, any vendored source and any run** — deliberately, because it is the
deliverable most likely to be skipped under schedule pressure and the one that
decides whether the lane's first result is interpretable at all.

- **Status**: FROZEN for Phase 1.
- **Pairing**: M03 `Xgmii_rx_64` (ours) against `axis_xgmii_rx_64`
  (`alexforencich/verilog-ethernet`, MIT, vendored verbatim at
  `test/third_party/verilog-ethernet/`, pinned by commit).
- **Governing ADR**: ADR-0015 **as committed at `9d357e6`** — status PROPOSED,
  two sponsor E3 items outstanding. The citation is pinned to the committed
  state deliberately: at the time of writing the working tree also carried an
  **uncommitted** revision of that file, by architect_docs_lead, moving it to
  ACCEPTED and naming Icarus. **I have not built on it** — a frozen document
  must not rest on another agent's in-flight edit. When that revision lands,
  this line and §4's simulator-agnostic phrasing get a recorded update, and the
  freeze discipline of §0 applies to that update like any other.

## 0-bis. CORRECTION, before Phase 1 is built on this (J-dv_lead-0052)

**I wrote §5 and §6 without consulting REQ-901, and REQ-901 already governs
both.** It was found while authoring Phase 1. Two corrections, in force:

1. **§5.1's list is superseded by REQ-901's own**, which requires "the same
   ordered sequence of output frames — payload octets, the `tkeep` extent of
   **each** word, and `tuser`[0] on each `tlast` — and **the same
   accept-or-discard decision per input frame**". Mine said *final*-word
   `tkeep` and omitted the accept/discard decision entirely. **REQ-901
   governs**; §5.1 is annotated in place rather than rewritten, per the
   recorded-miss rule.
2. **§6 is reclassified in full.** REQ-901 declares **four** divergence classes
   — (a) IPv4 header checksum, (b) ARP cache LRU, (c) discard-on-miss, (d) zero
   UDP transmit checksum — **none of which applies to the M03 pairing** — and
   then states: *"Any divergence outside these four classes is a defect. A
   divergence class discovered later SHALL be added here by spec diff before
   any sign-off packet may cite it."*

> **So this document may not permit a divergence, and §6 never could.** ADR-0015's
> governing clause offers three resolutions — a defect against our RTL, **a
> documented-divergence entry**, or a spec diff with an ADR — and I read
> "documented-divergence entry" as meaning an entry *here*. It means an entry in
> **REQ-901**, added by spec diff. My §6 created a parallel, self-authored
> permission list, which is the same error the clause forbids, one level up.
>
> **§6's V1–V7 are therefore NOT permitted divergences. They are predicted
> DEFECTS-or-spec-diff-candidates**, and if one materialises the resolution is a
> defect raised against our RTL, or a spec diff adding a class to REQ-901 —
> never a quiet entry in this file. **For the M03 pairing the permitted-divergence
> set is EMPTY.**

## 0-ter. DATED ANNOTATION beside §0-bis — the "EMPTY" sentence is STALE AT THE SCOPE IT IS WRITTEN AT (2026-08-09, `J-dv_lead-0132`)

**This is an annotation beside §0-bis, never an edit inside it.** §0-bis is
frozen and a run has probed its area; the four things CD §9's change discipline
requires of every change are stated below in its own order.

- **The section**: §0-bis, closing sentence — *"For the M03 pairing the
  permitted-divergence set is EMPTY."*
- **What moved**: **nothing in this document, and everything in the requirement
  it reports.** REQ-901 gained divergence classes **(e)** — `tuser`[0] alone on
  5-to-63-octet frames, with payload octets and `tkeep` extent still compared —
  and **(f)** — an over-1518-octet frame excluded entirely — **at the M03
  boundary, by spec diff, at `ebb3f49`, countersigned.** **This document's own
  §2-bis already carries the resolution block naming them**, so the two halves of
  this file have disagreed with each other since that diff landed.
- **The justifying clause**: §0-bis's own rule that **REQ-901 governs** and that a
  divergence class is added *there* by spec diff and nowhere else. The sentence
  is not being widened by this note; it is being **narrowed to the scope at which
  it was always true**, which §0 permits and §9 requires be recorded.
- **Whether a run has probed the area**: **YES — Phase 1's own**, `build` run
  `30988038809` at `2dbd39b`, `cosim` job `92247281222`. **That is precisely why
  the entry may not move outward and does not.** Phase 1 drove one 64-octet
  good-FCS lane-0 frame, which is **inside** the 64-to-1518-octet range, so it
  compared under an empty permitted set — **correctly** — and the operative fact
  for Phase 1 is unaffected.

**The three scopes, tabulated rather than picked between**, because picking one
is how the defect happened:

| statement | truth at this commit |
|---|---|
| "for the M03 **pairing** the permitted-divergence set is empty" | **FALSE.** It contains (e) and (f). |
| "for the **64-to-1518-octet range** at this boundary the permitted-divergence set is empty" | **TRUE**, and it is REQ-901's own sentence: *"Classes (e) and (f) exclude nothing in the 64-to-1518-octet range."* |
| "for **Phase 1's own domain instance** the permitted-divergence set is empty" | **TRUE**, because §8's frame is 64 octets and therefore inside that range. |

**The defect is one of SCOPE, not of arithmetic**, and it is the
left-standing-summary class this programme has now paid for at
`RV-0039-VERDICT` F-2, at `AP-xgmii_rx_64.md` §7's staleness banner, and at
`bench.mli`'s own header. **AND IT HAD PROPAGATED**: `tools/cosim/run_cosim.sh`'s
check-4.1 comment carried the same sentence into a script, where a future phase
driving a runt or an oversize frame would have read it and **mis-adjudicated its
own result**. That comment is annotated in the same commit as this note, which is
the whole reason the two are one edit set rather than two.

**What this annotation does NOT do.** It permits no divergence — this document
still cannot, and §0-bis's ruling on that is untouched. It does not reclassify
V1–V7. And it does not weaken §5.1: classes (e) and (f) are **narrow**, they
exclude `tuser`[0] alone on 5-to-63-octet frames and the whole of an
over-1518-octet frame, and **family F's core observable — REQ-103's FCS removal
on a runt, its delivered counts and their `tkeep` — REMAINS co-sim-anchorable**.

## 0. What this document is, and the discipline it runs under

Two conformant implementations of "10G Ethernet receive" differ **legally and
often**. SPEC-M03 carries rulings the reference has never heard of. A harness
that compares everything against everything produces a wall of differences on
its first run, and the lane gets written off when what actually failed is that
nobody defined the question.

So this document defines the question. It states **what must agree**, and
enumerates **where the two are permitted to differ and why**.

**Freeze discipline, identical to a sealed mutation prediction:**

> The domain is frozen before each run. A difference **inside** the domain is a
> **finding**. A difference **outside** it is **data** — recorded, not
> adjudicated. **Nothing may be moved from inside the domain to outside it
> after a run has shown a difference there.** Widening the permitted-divergence
> list to absorb a result is the co-sim equivalent of editing a frozen
> prediction, and it is barred for the same reason: it would make the lane
> unable to fail.

Moving an entry outward is legitimate **only** before a run has probed it, and
only with the clause that justifies it recorded here.

## 1. THE GOVERNING CLAUSE

Attached by architect_docs_lead with ADR-0015 and reproduced **verbatim**. It
governs every other section of this document:

> "No attack-plan row's expected value and no golden-model outcome may be
> changed to match the reference. A divergence resolves as a defect against our
> RTL, a documented-divergence entry, or a spec diff with an ADR — never by
> amending an expectation to agree."

**Read the direction of authority carefully.** The reference is an *anchor*, not
an *oracle*. Where SPEC-M03 is deliberately stricter or simply different, **our
rows govern**. A divergence has exactly three legitimate resolutions — a defect
raised against our RTL, an entry added to §5 below, or a specification change
with its own ADR — and amending `AP-xgmii_rx_64.md` or `Injection`'s outcome
model to agree with the reference is **not** one of them.

## 2. What the lane can anchor — and the part it cannot

**This is the finding of Phase 0 and it changes what the lane is worth.**

X-1's outcome model (`test/xgmii/injection.ml`) computes two different kinds of
thing for each injected frame:

1. **the data-path outcome** — `received`, `delivered`, and the resulting
   stream: which octets come out, how the final word is marked, whether the
   frame is marked invalid;
2. **the report** — *which* §9 strobe fires and on *which pinned cycle*.

The reference is an AXI-Stream receiver. Its error signalling is expected to be
an AXI-Stream `tuser` bit on `tlast`, in the ordinary style. **It is not
expected to have counterparts for `error_bad_fcs`, `error_runt`,
`error_bad_frame`, `error_oversize` or `error_start_without_terminate`, still
less for §9's per-strobe pinned cycles**, which are SPEC-M03's own construction.

**Consequence, stated now rather than discovered at Phase 3: this lane can
anchor half of X-1's model and not the other half.** The data-path outcome is
anchorable. The strobe taxonomy and its pinned cycles are **not**, because there
is nothing on the other side to compare them to.

**So `WO-0033`'s standing limit is only partly dischargeable here**, and any
future `SO-xgmii_rx_64` must say so in its own words: the delivered/marking half
of the model rests on an independent implementation; **the strobe half rests on
the specification and hand derivation alone.** If the programme wants the strobe
half anchored, it needs a *different* anchor and this lane is not it.

This prediction is **frozen** and Phase 1 confirms or falsifies it (§6).

## 2-bis. CORRECTION to §2, and a NEW FINDING that is larger (J-dv_lead-0056)

**§2's conclusion stands; its ground was wrong, and the reference turns out to
be both more and less like ours than I predicted.** Verified by me directly
against `test/third_party/verilog-ethernet/axis_xgmii_rx_64.v` at the pin,
prompted by the WO-0046 worker's Q1 finding.

**§2 said the reference "is not expected to have counterparts" for our five
strobes. Two of them it has, by the same names**: `error_bad_frame` and
`error_bad_fcs` are output ports of the reference. So the ground was wrong.

**The conclusion survives on a better ground, and it is REQ-901's.** REQ-901's
comparison content is "payload octets, the `tkeep` extent of each word, and
`tuser`[0] on each `tlast` — and the same accept-or-discard decision per input
frame". **Strobes are not in it at all.** So the lane cannot anchor the strobe
half of X-1's model because **REQ-901 does not compare strobes**, not because no
counterpart exists. Third time REQ-901 has superseded my own reasoning here.

### THE NEW FINDING — the reference has NO LENGTH LOGIC WHATSOEVER

`grep -niE "length|runt|oversize|too_short|too_long|min_|max_|frame_len"` over
all 449 lines of `axis_xgmii_rx_64.v` returns **nothing**. Not a runt check, not
an oversize check, not a length register. REQ-901's "minimum frame length 64"
setting has no counterpart because **the concept is absent**.

**Consequence, and it is not small.** For a runt, ours forwards with
`tuser`[0] = 1 (REQ-107); the reference forwards with `tuser`[0] = 0, because it
has no notion that anything is wrong. For an oversize frame, ours truncates to
1514 and marks (REQ-108); the reference forwards it whole and unmarked. **In both
cases the divergence is in `tuser`[0] on the `tlast` — squarely INSIDE REQ-901's
comparison domain**, where "any divergence outside these four classes is a
defect".

**It is not a defect. It is a deliberate specification difference**, and by
REQ-901's own rule the only legitimate resolution is **a fifth divergence class,
added to REQ-901 by spec diff** — which this document cannot grant (§0-bis).

> **RESOLVED at `ebb3f49`, and the class is NARROWER than I asked for
> (`J-dv_lead-0057`).** REQ-901 classes **(e)** and **(f)** are appended and
> countersigned. (e) excludes **`tuser`[0] alone** on 5-to-63-octet frames —
> **payload octets and `tkeep` extent are still compared** — because the
> reference's FCS check is a lane-indexed residue array with **no length gate**,
> so it strips four octets and delivers `length − 4` exactly as we do. **So
> family F's core observable (REQ-103's FCS removal on a runt: delivered
> counts 1, 12, 56, 59 and their `tkeep`) REMAINS co-sim-anchorable**; only the
> REQ-107 marking is not. A sub-5-octet frame is excluded entirely, its
> accept-or-discard included, and the reference's disposition of one is
> **recorded as data on first drive, never adjudicated**. (f) excludes an
> over-1518-octet frame entirely. **Both exclude nothing in 64–1518.**
>
> The paragraph below was written before that diff and predicted a whole-frame
> exclusion for runts. It is left standing as a recorded miss; **the narrower
> class governs.**

> **RAISED, and it gates part of the lane's value**: REQ-901 says a later class
> "SHALL be added here by spec diff **before any sign-off packet may cite it**".
> **So the co-simulation cannot anchor families F (runts) or G (oversize) at all
> until that spec diff lands.** Routed to architect_docs_lead. This sharpens §2
> considerably: the lane anchors clean frames and the FCS and `/E/` paths, where
> counterparts exist — **and cannot anchor the length-derived error paths in
> either half, data or strobe.**

## 3. The canonical transaction form — what is actually compared

**Transaction-level, never cycle-stamped.** ΔC = 3 is SPEC-M03's constant
(REQ-019); the reference has its own latency and pipeline depth, and comparing
cycle indices would report a legal design difference as a divergence on every
single frame.

For each frame, both sides are reduced to an ordered list of output words:

```
(octets : int list, tkeep : int, tlast : bool, invalid : bool)
```

`octets` are the delivered octets carried by that word in ascending `tdata`
position order; `invalid` is the abort/found-invalid marking bit as each side
expresses it. **Frame boundaries come from `tlast`**, not from cycle counts.

**No version string, tool name, path, timestamp or host identifier may appear
inside a canonical file.** Provenance — pinned reference SHA, simulator name and
version, runner image, stimulus identifier — lives in a **sidecar** beside it.
A version embedded in the compared artifact turns every toolchain upgrade into a
divergence, and the reproducibility check of §4 into noise.

## 4. The reproducibility guarantee — named, and weaker than REQ-902

**REQ-902 is NOT extended to this lane** (ADR-0015 D3). What the lane carries
instead is a conditional guarantee, stated with its antecedent so nobody quotes
it without one:

> **Pinned-input reproducibility.** Given the pinned reference SHA, the recorded
> simulator version, the recorded stimulus, and the same runner image, two runs
> produce **byte-identical canonical transaction files**.

Everything in that antecedent is load-bearing. Change the simulator version and
the guarantee does not apply; it is not a claim that the reference is
deterministic across toolchains, and it must never be summarised as one.

**Exercised, not asserted**: Phase 1 runs the simulation **twice** and diffs the
two canonical files. A guarantee nobody has tried to break is worth what the
empty `[%expect]` blocks were worth before the mutation campaigns.

## 5. The comparison domain

### 5.1 INSIDE — differences here are findings

> **SUPERSEDED IN PART by REQ-901 (see §0-bis).** REQ-901 requires the `tkeep`
> extent of **each** word (not only the final one) and adds **the accept-or-discard
> decision per input frame**, which this table omits. The table stands as a
> recorded miss; **REQ-901's list is the operative one.**

For a frame in a stimulus class both implementations are expected to forward:

| | observable |
|---|---|
| **D1** | the ordered sequence of **delivered octets**, whole frame |
| **D2** | the **`tkeep`** of the final word |
| **D3** | **`tlast` placement** — the word index it falls on |
| **D4** | the **invalid/abort marking** on the final word |
| **D5** | the **number of output words** for the frame |

### 5.2 OUTSIDE — differences here are data

| | excluded | why |
|---|---|---|
| **X1** | all **cycle timing**, latency and word-to-word spacing | REQ-019's ΔC is ours; §3's canonical form is transaction-level by construction |
| **X2** | **strobe identity and pinned cycles** | §2 — no counterpart is expected to exist on the reference side |
| **X3** | anything on a `tvalid` = 0 cycle, and `tdata` where `tkeep` is 0 | standing obligation 6; unconstrained on both sides |
| **X4** | **preamble and SFD octet values** | REQ-102 forbids M03 from validating them; the reference may. Family B's stimulus is expected to diverge |
| **X5** | internal state, port names, parameterisation, reset conventions | absorbed by the bridge, explicitly (WO-0044 §3) |

## 6. Predicted DEFECTS or spec-diff candidates — a FROZEN PREDICTION

> **RECLASSIFIED (§0-bis).** These were written as "permitted divergences".
> They are not, and this document cannot make them so: REQ-901 reserves that
> declaration to itself by spec diff, and for M03 its permitted set is **empty**.
> Each entry below is a **predicted defect** whose resolution, if it
> materialises, is a defect packet against our RTL **or** a spec diff adding a
> class to REQ-901.

**These entries are predictions.** I have not read the reference — it is not
vendored yet — so each names what would confirm it. **Phase 1 and Phase 2 test
this section as much as they test the bridge**, and an unpredicted divergence is
a finding against *this document*, exactly as an unnamed reddening unit is a
finding against a sealed mutation matrix.

| | class | SPEC-M03's behaviour | prediction | confirmed by |
|---|---|---|---|---|
> **V1–V3's MECHANISM IS CORRECTED (§2-bis).** I predicted the reference would
> **drop** short and long frames. It does no such thing: it has **no length
> logic at all** and forwards them unmarked. The predictions were right that a
> divergence appears and wrong about why, and the resolution is not a CD entry
> but **a fifth REQ-901 class by spec diff**. Corrected on a source reading, not
> a run result — Phase 1 drives one 64-octet good frame and probes none of
> V1–V3, so §0's bar on moving an entry after a run has probed it does not bite.

| **V1** | **runt, 5–63 octets** | forwarded, 1–59 octets delivered, marked invalid (REQ-107) | reference **drops** it — no output at all | driving a 5-octet frame; Phase 3 |
| **V2** | **below 5 octets** | **no output word**, `error_runt` alone, `error_bad_fcs` barred (§9 ruling 9) | reference drops; agreement on "no output" is likely but for a different reason | Phase 3 |
| **V3** | **oversize > 1518** | truncated to **exactly 1514** delivered octets and marked (REQ-108) | reference drops or truncates at a different bound | Phase 3 |
| **V4** | **`/E/` mid-frame** | frame truncated at the octet before the `/E/`, marked, **no FCS removal** (REQ-103) | reference may drop, or may remove the FCS anyway | Phase 3; family E's rows are the hand-derived reference |
| **V5** | **`/S/` before `/T/`** | REQ-110's abort with its own disposition | reference behaviour unknown | Phase 3 |
| **V6** | **nonstandard preamble** | forwarded; REQ-102 forbids validation | reference may reject the frame | Phase 2; family B's stimulus |
| **V7** | **bad FCS** | **forwarded in full**, marked invalid (§9 row 1) | reference may **drop** — this is the commonest store-and-forward instinct and REQ-005 forbids it for us | Phase 2 |

**V7 is the one to watch.** If the reference drops bad-FCS frames, then family
D's entire subject matter is outside the comparison domain, and REQ-104's
verification continues to rest on family D's mutation-qualified bench alone —
which is a perfectly good place for it to rest, but the `SO-` must say so rather
than imply the co-sim covered it.

## 7. Artifact hygiene — a hard constraint on the bridge, from ADR-0015

The determinism step **stages untracked files deliberately**, so **any simulator
artifact left in the checkout fails the main suite** (R-CI-1 / R-CI-5). This is
not a tidiness preference; it is a mechanism that will redden a green tree.

**Binding on every bridge and harness design under this lane:**

1. All simulator working files — build directories, object files, waveform
   dumps, logs — are written **outside the repository checkout**, or are
   gitignored if they cannot be.
2. Canonical transaction files and their sidecars are likewise **not left in the
   checkout** unless deliberately committed as evidence, in which case they are
   committed, not left untracked.
3. **The bridge is responsible for its own cleanup on failure as well as on
   success.** A harness that tidies up only on the happy path will strand
   artifacts on exactly the runs that matter.

## 8. Phase 1's domain instance

One 64-octet good-FCS frame, lane-0 start, driven into both implementations.

**Inside the domain**: D1–D5. Expected identical — 60 delivered octets, final
`tkeep` = 0x0F, `tlast` on word 7, not marked invalid, 8 words.

**Also required of Phase 1, and it is not the comparison**: a **deliberate
mismatch check** — perturb one octet in the expected comparison and confirm the
harness reports a difference. **A comparator that has only ever agreed is worth
nothing**, which is the lesson of B2 and B3 and of this whole programme's last
fortnight. A green Phase 1 that compared nothing is the failure mode this clause
exists to prevent.

**And the two-run diff of §4.** Phase 1 is not complete without it.

## 9. Change discipline

Every change to this document carries: the section, what moved, the clause that
justifies it, and **whether any run has already probed the area being changed**.
An entry moved outward after a run probed it is barred by §0 and must be raised
as a finding instead.

**This document is frozen for Phase 1 as written.**

## 9-bis. THE PHASE-1 FREEZE IS DISCHARGED AND THIS DOCUMENT OPENS FOR ADDITION ONLY — §9's four items, in §9's own order (`J-dv_lead-0151`)

**This is an annotation beside §9, never an edit inside it** — §0-ter's form, at
its second use. §9's four items follow, each answered rather than gestured at.

**1. The section.** §9's closing sentence, *"This document is frozen for Phase 1
as written."* — **and nothing else.** §0-bis, §0-ter and §§0–8 are untouched by
the commit carrying this note, byte for byte.

**2. What moved.** **No entry, in either direction.** What changes is the
freeze's *tense*, not its content:

- **Co-sim Phase 1 has run** — `build` run `30988038809` at `2dbd39b`, `cosim`
  job `92247281222`, as §0-ter records. §8's instance is therefore a **probed**
  instance, and it is frozen **permanently** rather than "for Phase 1". This note
  makes that explicit and takes nothing back.
- **The document opens for ADDITION ONLY**: §10 below, carrying co-sim Phase 2's
  domain instances. No existing section is edited. **No permitted-divergence
  entry is created** — §0-bis bars this document from making one and that bar is
  untouched. **No observable moves from §5.1's inside table to §5.2's outside
  table.** §6's V1–V7 keep the reclassified status §0-bis gave them and are
  **cited** below, never amended.
- **The freeze that replaces it is per instance, not per document.** Each
  instance in §10 is frozen from this commit, and §0's bar binds each one
  individually rather than the file as a whole.

**3. The clause that justifies it.** Four, all quoted rather than paraphrased:

1. **§0's own words**: *"The domain is frozen **before each run**."* The freeze is
   a **per-run** obligation. §9's sentence discharged it for Phase 1's run; it
   never purported to bar a later phase's instance, and read as barring one it
   would make this lane unable to **advance** rather than unable to **fail** —
   the opposite of the property §0 exists to protect.
2. **§0's move rule**: *"Moving an entry outward is legitimate only before a run
   has probed it, and only with the clause that justifies it recorded here."*
   **Nothing is moved outward by this commit**, so the rule's condition is never
   reached. That is recorded here rather than left to a reader's inference.
3. **§9 itself**, whose four-item discipline this section is an instance of.
4. **`WO-0078` §6.2's stop rule and its §13 item 1** — *"the domain instance for a
   case must be committed before the case first runs"*, routed to dv_lead *"in a
   dv_lead round of its own"* and restated as the immediate next gate by
   `RV-STAGE1` §9.

**4. Whether a run has already probed the area being changed. Two answers, and
they are different — which is why they are given separately.**

- **The freeze sentence's own area: YES.** Co-sim Phase 1 ran against this
  document as frozen. **That is precisely why §8 is not opened and why this lift
  is scoped to addition**: Phase 1's result is a statement about §8's instance,
  and §8's instance does not move.
- **§10's area: NO — and this is the load-bearing half.** **No case in §10 has
  ever been driven.** This lane has driven exactly one stimulus since it opened —
  case 0, one 64-octet good-FCS lane-0 gapless frame — and Stage 1 added a case
  *container* and put nothing in it (`RV-STAGE1` §8 items 1–2). C1, C2, C3 and C4
  are unrun at this commit, and **all four instances are frozen here before any
  of them is dispatched**, which is stronger than the stop rule requires: the stop
  rule is per case, and freezing C3's and C4's predictions now means neither was
  written with C1+C2's result in hand.

**Dating.** **§9-bis and §10 assert no calendar date of their own. They are dated
by the commit that carries them and by `J-dv_lead-0151`** — `WO-0078`'s own
dating rule, *"this packet asserts no date of its own. It is dated by the commit
that carries it"*. This is a deliberate departure from §0-ter's form and its
reason is `FINDING CD-P2-2` (§10.6).

**What this lift does NOT do.**

1. **It permits no divergence.** §0-bis's ruling stands unqualified: this document
   cannot declare one, and REQ-901's lettered classes (a)–(f) are the only
   permitted set at this boundary.
2. **It reopens nothing.** §8, §5.1, §5.2, §6, §0-bis and §0-ter are all closed to
   this commit and to every commit that does not carry its own §9 record.
3. **It adds no co-sim Phase 3 instance.** `WO-0078` §6.3's re-authorisation gate
   (b) requires one; **it remains owed and unwritten**, declared here rather than
   omitted, and a Phase-3 addition carries its own §9 record when it comes.
4. **It does not touch §3's transaction form, §4's conditional reproducibility
   guarantee or §7's artifact-hygiene constraints**, all of which bind §10's cases
   exactly as they bound §8's.

## 10. Co-sim Phase 2's domain instances — C1, C2, C3, C4

### 10.0 What binds every instance below

**"Co-sim Phase 2" is `WO-0044` §4's phasing of this lane — the clean-frame
spine — and is NOT the programme's Phase 2** (MoldUDP64/ITCH 5.0 and the order
book), which this section does not touch and which no line of this lane
advances (`WO-0078` §0.1).

**The case set** is `WO-0078` §6.2's: **C1, C2, C3, C4**, landing **C1+C2**
together, then **C3** alone, then **C4** alone.

**Case 0 is not one of them.** Case 0 is the frozen baseline (`WO-0078` §3.1), its
domain instance is **§8**, and this section neither re-freezes it nor restates
its hash. **The freeze's independent anchor is `build` run `31080871169`, job
`92549154623`, at commit `55e16ae`** — the last green run that predates the
widening. **That run is what any later packet cites when it claims the freeze,
never the `CASE0_PINNED_SHA256` literal inside the file the freeze constrains**
(`RV-STAGE1` §1's standing note; the value itself is quoted there with its
provenance and is deliberately not copied here, because a second literal is a
second thing that can drift). This section repeats the rule because §10's reader
is exactly the reader the literal will tempt.

**§0's bar is the operative rule for every instance below, individually**, and it
is restated here in its own words rather than referenced:

> **Nothing may be moved from inside the domain to outside it after a run has
> shown a difference there.**

Concretely, per case: each instance below is **frozen from this commit**. If a
case's run shows a difference inside its domain, that difference is a **finding**,
and its resolution is one of branch **γ**'s two routes — **a `BUG-` against our
RTL, or a REQ-901 spec diff routed to architect_docs_lead** — **never an entry
here, never a widening of §5.2, and never an amendment to an expected value.**
§1's governing clause and REQ-901's own closing sentence both say it: *"an
exclusion is never a licence to take an expected value from the reference."*
**And a case that runs before its instance is committed is void** — re-run, not
adjudicated (`WO-0078` §6.2, §12 criterion 8). All four are committed here,
before any is dispatched.

**What is INSIDE, for every instance below.** REQ-901's operative list, per
§0-bis correction 1: the ordered sequence of output frames — **payload octets**,
**the `tkeep` extent of *each* word**, **`tuser`[0] on each `tlast`** — and **the
accept-or-discard decision per input frame**. §5.1's D1–D5 table stands as the
recorded miss §0-bis annotated it as; where the two differ **REQ-901 governs**.

**What is OUTSIDE, for every instance below.** §5.2's X1–X5, **unchanged,
unwidened and unedited**. Two are load-bearing in this stage and are named again
at the instances that lean on them: **X1** (all cycle timing, latency and
word-to-word spacing) and **X4** (preamble and SFD octet values).

**The permitted-divergence set for this stage is EMPTY, and the scope of that
sentence is stated with it** — §0-ter's lesson, applied rather than cited.
**Every frame in C1–C4 is 64 octets.** REQ-901's own sentence: *"Classes (e) and
(f) exclude **nothing** in the 64-to-1518-octet range."* Classes (a)–(d) have no
instance at the M03 boundary (§0-bis). **So: for these four instances the
permitted-divergence set is empty.** Not "for the M03 pairing" — that scope is
false and §0-ter tabulates why.

**One consequence falls out of that and it is not decorative: branch β is
UNREACHABLE in this stage.** `WO-0078` §7's three branches are:

- **(α) AGREEMENT** — *"the observable agrees inside the domain. The case's class
  becomes co-sim-anchored **for that class and no wider**."*
- **(β) DECLARED-CLASS DIVERGENCE** — the divergence falls inside a REQ-901
  declared class (a)–(f); excluded, not reported as a failure.
- **(γ) UNDECLARED DIVERGENCE** — *"Any divergence outside the declared classes is
  a defect"*; resolves as a `BUG-` against our RTL or as a REQ-901 spec diff, and
  **never** by amending an expectation to agree.

With the permitted set empty at 64 octets, **no case in this stage can select β**.
**Every case's outcome space here is exactly two-valued: agreement, or a
divergence that is undeclared.** That is the fact `FINDING CD-P2-1` (§10.5) turns
on.

**Stage 2's dispatch has three preconditions and this commit discharges one**
(`RV-STAGE1` §9): §13 item 1's co-sim Phase 2 instance, here. The other two —
`FINDING RV-0078-S1-2`'s printer repair, both limbs, and the retirement of the
wildcard byte-identity requirement — are not this document's and are not
discharged by it.

### 10.1 C1 — lane-4 start on cycle 0

**Stimulus** (`WO-0078` §6.2): case 0's frame with `~first_start:4` — one
64-octet good-FCS frame, gapless, whose **start character sits in lane 4 of the
input word of cycle 0**, i.e. on the reset-release cycle. `Arrival.create`'s
`?first_start` must be a multiple of 4, so `4` is a lane-4 start **on cycle 0**
where the obvious `12` would have been a lane-4 start on cycle 3 — **the sighted
placement is preserved deliberately** (`WO-0078` §4.2 item 2).

**Why this case exists**: it closes `WO-0046`-adjudication §5 item 2 — *"lane 4
has never been driven at this boundary … where every quantity SPEC-M03 §7 pins
takes its other value."*

**INSIDE the domain — expected, and identical to §8's instance in every REQ-901
observable**: the frame is **accepted**; **60 delivered octets**, the injected
frame minus its four FCS octets (REQ-103); **8 output words**; `tkeep` = `0xFF`
on words 0–6 and **`0x0F`** on word 7; **`tlast` on word 7**; **`tuser`[0] = 0**
on that word. Grounded in REQ-101 — *"SHALL produce identical output streams for
the same frame received at either alignment"* — and REQ-103's own directed
lengths.

**OUTSIDE — X1**, unchanged. Cycle timing is not compared cross-side at this case
and this instance does not make it so; `AP-M03` §7 bar 3 keeps every cross-side
timing quantity barred.

**Our-side-only timing note, carried because `WO-0078` §7's C1 cell states it.**
SPEC-M03 §7's table pins **ΔC = 3 at both start lanes** ((L + h) = 24 in both
rows), and §6.1's gapless formula is `admit_cycle + m + 3` with `admit_cycle` = 0
here, so **T1's expected set is `{3 … 10}`, unchanged from case 0's**. **This is
an assertion of ours against SPEC-M03, not comparison content.** And the thing a
later reader must not conflate: **REQ-101's verification column permits the first
output word's absolute cycle to differ by one cycle between our own two start
lanes; SPEC-M03 §7 pins it tighter, at 3 for both.** A T1 red at C1 is therefore
adjudicated against **SPEC-M03 §7's own table**, on the ours-vs-spec axis
(`EXIT_TIMING(10)`), and is **never** a co-simulation divergence.

**FROZEN PREDICTION — `WO-0078` §7's C1 row, carried verbatim:**

> **our side, by spec**: *"SPEC-M03 §6.1 gives the **same absolute output cycles**
> at a lane-0 and a lane-4 start; delivered octets identical to case 0"*
> **prediction**: *"agreement; **T1's expected set is unchanged from case 0's
> `{3 … 10}`**"*
> **branch if the prediction holds**: **α**
> **branch if it fails**: *"**γ** — and it would be a large one, because it would
> mean the two designs disagree on a clean frame at the other start lane"*

**What α buys, bounded before it is bought**: `AP-M03` §7 bar 1 lifts for **this
class only** — a 64-octet good-FCS frame at a lane-4 start — and for no other. No
`SO-` sentence of the form *"the co-simulation anchors this module"* becomes
writable (`WO-0078` §8).

**A note on the check, not on the freeze**: `WO-0078` §12 criterion 2 checks this
instance's sighted-placement claim by requiring the harness to print frame 0's
`admit_cycle` as **0**, and that printing mechanism **does not exist**
(`FINDING RV-0078-S1-2`(a)); it is commissioned in the Stage-2 dispatch. **This
instance does not depend on that repair for its freeze** — the repair is what
makes the check readable, not what makes the prediction binding.

### 10.2 C2 — two clean frames, minimum inter-frame gap

**Stimulus** (`WO-0078` §6.2): **two** 64-octet good-FCS frames, **frame 0 at
`~first_start:0`** — lane 0, cycle 0, the sighted placement preserved for frame 0
— separated by the **minimum inter-frame gap** of requirements.md §0.3: 12 octets,
counted **from the terminate character inclusive**.

**Why this case exists**: it closes the one-frame bound that has been this lane's
binding constraint since it opened, and it needs **no accumulator change** —
`WO-0078` §2.2 measured both refusal guards and both fire only on a start
character arriving *while a frame is open*.

**INSIDE the domain — expected**: **two accepted frames, in order, indices 0 and
1**; each **60 delivered octets**, **8 output words**, `tkeep` `0xFF` on words
0–6 and **`0x0F`** on word 7, **`tlast` on each frame's word 7**, **`tuser`[0] =
0** on both `tlast` words. **Frame boundaries come from `tlast`, not from cycle
counts** (§3).

**A consequence of the stimulus, recorded because it changes what a red would
mean — and it is not a bar on how the case is built.** §0.3's gap arithmetic puts
frame 1's start character **84 octet times** after frame 0's (8 preamble + 64
frame + 12 gap), and 84 is not a multiple of 8, so **frame 1's start character
lands in lane 4**. C2 therefore drives a lane-4 start as a by-product. **This does
not make C1 redundant and the difference is the whole reason C1 exists
separately**: C1 isolates the lane-4 start at the reset-release cycle, as frame 0;
C2's lane-4 frame is the *second* frame at a non-zero admit cycle, so a red at C2
alone could not be attributed between the start lane and the re-arm path. The two
land together and per-case reporting attributes a red **to** a case — it does not
attribute *within* one.

**OUTSIDE — X1**, unchanged.

**FROZEN PREDICTION — `WO-0078` §7's C2 row, carried verbatim:**

> **our side, by spec**: *"two accepted frames, indices 0 and 1, eight words each"*
> **prediction**: *"agreement on both"*
> **branch if the prediction holds**: **α**
> **branch if it fails**: *"**γ** — the re-arm path, which no seeded class has
> ever reached at this lane"*

**What α buys, bounded**: bar 1 lifts for the **two-clean-frames-at-minimum-IFG**
class and for no other. It does **not** lift for REQ-004's 10 000-frame line-rate
cadence: two frames is two frames, and the stress obligation rests where it
rested.

**A note on the check**: `FINDING RV-0078-S1-2`(b) first bites here — with two
frames, a case carrying one clean frame and one divergent frame prints no numbers
for the clean one. Commissioned in the same dispatch; it bounds the *readability*
of C2's timing evidence, not this instance's freeze.

### 10.3 C3 — one 64-octet frame, bad FCS (this document's §6 **V7**)

**Stimulus** (`WO-0078` §6.2): one **64-octet** frame, `~fcs_valid:false` plus a
corrupted octet; lane-0 start on cycle 0, sighted placement preserved.

**Why this case exists**: it is §6's **V7**, and §6 calls it *"the one to
watch"*.

**Our side, by spec — pinned, not chosen.** §9 row 1: *"frame forwarded in full,
`tuser`[0] = 1 on `tlast`"*, REQ-104. REQ-104's own verification column: *"the
same octet count is delivered"*. REQ-005 forbids store-and-forward. The frame
**ends with a terminate character**, and REQ-103's no-FCS-removal exceptions are
REQ-105 aborts, REQ-108 truncations and REQ-110 cut-shorts — **a bad FCS is not
among them** — so the FCS is stripped exactly as on a good frame. **Expected:
accepted; 60 delivered octets; 8 output words; `tkeep` `0xFF` ×7 then `0x0F`;
`tlast` on word 7; `tuser`[0] = 1 on that word.**

**INSIDE the domain**: all four REQ-901 observables, **`tuser`[0] on the `tlast`
word and the accept-or-discard decision included**. **Class (e) does not reach
this case** — (e) is 5-to-63 octets and this frame is 64.

**OUTSIDE — X1**, unchanged.

**FROZEN PREDICTION — `WO-0078` §7's C3 row, carried verbatim, blank cell
included:**

> **our side, by spec**: *"**forwarded in full, marked `tuser`[0] = 1** (§9 row 1,
> REQ-005 forbids store-and-forward)"*
> **prediction**: *"**the reference may DROP it** — CD §6: 'the commonest
> store-and-forward instinct'"*
> **branch if the prediction holds**: *"—"*
> **branch if it fails**: *"**γ**, and the **expected** resolution is **a REQ-901
> spec diff adding a class**, not a `BUG-`: our behaviour is pinned by REQ-005 and
> the reference's is its own. **If it drops, family D's entire subject matter is
> outside the comparison domain and REQ-104 rests on family D's bench alone —
> which the `SO-` must SAY, not imply away**"*

**That blank cell is `FINDING CD-P2-1` (§10.5).** It is carried verbatim here
rather than quietly filled, and what this instance does with it is stated in
§10.5 and nowhere else.

**And the thing this case must not be allowed to do.** Whatever it returns,
`AP-M03` §7 **bar 4 stays standing**. C3 is the first stimulus in this lane's
history that makes `error_bad_fcs` pulse on our side, so bar 4's precondition (1)
is met **for that one strobe**; preconditions (2) and (3) — a committed mapping,
then a grammar field — are **not**, and this document does not meet them.
**REQ-901 compares no strobe, and neither does this instance.**

### 10.4 C4 — nonstandard preamble (this document's §6 **V6**)

**Stimulus** (`WO-0078` §6.2): one **64-octet** good-FCS frame whose six preamble
filler octets and SFD octet carry **arbitrary, nonstandard data values**;
otherwise clean; lane-0 start on cycle 0, sighted placement preserved. This is
REQ-102's own commissioned stimulus — *"a frame whose six preamble filler octets
and SFD octet are arbitrary data values"*.

**Why this case exists**: it is §6's **V6**. REQ-102 **forbids** M03 from
validating those octet values; the reference may validate them.

**Our side, by spec**: identical to §8's instance. **The preamble is stripped and
never delivered** (REQ-102, REQ-103), so the delivered stream is unchanged by the
octet values: **accepted; 60 delivered octets; 8 output words; `tkeep` `0xFF` ×7
then `0x0F`; `tlast` on word 7; `tuser`[0] = 0.**

**INSIDE the domain**: the four REQ-901 observables — and **the accept-or-discard
decision is the observable this case is about.**

**OUTSIDE — X4, with its scope recorded so it cannot be over-read.** §5.2's X4
excludes *"preamble and SFD octet values"*. Those octets are **stripped by
REQ-102 and appear in no delivered stream on either side**, so **X4 removes
nothing from C4's delivered-octet comparison**; what it removes is the *stimulus*
octets as a source of expected values, and family B's stimulus is where §5.2
expected the divergence. **X4 does NOT exclude the decision those octets cause.**
If the reference validates the preamble and rejects the frame, that is a
divergence in REQ-901's **accept-or-discard decision**, inside the domain, outside
every declared class — **γ**. `WO-0078` §7's C4 cell says exactly this.

**No entry moves here.** X4 is neither widened nor narrowed nor edited; its scope
is **recorded beside an instance that leans on it**, which is what §9 asks of a
change that rests on an existing entry. **And no run has probed X4** — family B's
stimulus has never been driven at this lane — so even had this been a narrowing
it would have been lawful under §0. It is not one.

**FROZEN PREDICTION — `WO-0078` §7's C4 row, carried verbatim, blank cell
included:**

> **our side, by spec**: *"forwarded; **REQ-102 forbids M03 from validating
> preamble octets**"*
> **prediction**: *"the reference may reject the frame"*
> **branch if the prediction holds**: *"—"*
> **branch if it fails**: *"**γ** on the *decision*; the preamble octet values
> themselves are **CD §5.2 X4**, already outside the domain, so a divergence in
> the octets alone is **data**"*

**That blank cell is `FINDING CD-P2-1` (§10.5)**, on the same terms as C3's.

### 10.5 `FINDING CD-P2-1` (MINOR at this commit) — `WO-0078` §7's branch table leaves the AGREEMENT outcome of C3 and C4 unbranched, and its holds/fails polarity reads backwards against its own prediction column. **A defect against my own packet, not against any assignee's work.**

**The text it is measured against, both from `WO-0078` §7 itself.** Its prose:
*"The three branches, and **every case's result resolves to exactly one**."* Its
table columns: *"branch if the prediction holds"* / *"branch if it fails"*.

**Where it holds.** C1 and C2's prediction column asserts **agreement**, so
*holds* → α and *fails* → γ. Both rows are coherent and this document uses them
as written.

**Where it does not.** C3's and C4's prediction column asserts a **divergence** —
*"the reference may DROP it"*, *"the reference may reject the frame"*. Read
against its own column headings the table then says that the **divergence**
outcome is the prediction **failing** (γ sits in the *fails* column), and that the
prediction **holding** selects **"—"**, no branch at all. **Two defects in one
cell pair:**

1. **An unbranched outcome.** Agreement at C3 or C4 selects **nothing**, which
   contradicts §7's own opening sentence.
2. **A polarity that reads backwards.** γ sits under *fails* for a prediction of
   divergence.

**Why it is material rather than cosmetic, and the reason is §10.0's.** **β is
unreachable in this stage** — every frame is 64 octets, (e) and (f) exclude
nothing in 64–1518, and (a)–(d) have no instance at this boundary. So C3's and
C4's outcome space is **exactly two-valued**: agreement, or an undeclared
divergence. **A table naming a branch for one of two possible outcomes leaves the
adjudicator to choose the other after the run** — which is the precise mechanism
`WO-0078` §12 criterion 8 voids a case for (*"a case adjudicated by a disposition
written after its run is void whatever its colour"*) and the precise mechanism §0
was written to prevent.

**Resolution — recorded, not made silently.** §7's branch **definitions**, not its
table, already decide the blank: **α is defined as *"the observable agrees inside
the domain. The case's class becomes co-sim-anchored for that class and no
wider."*** The agreement outcome of C3 and C4 **is α by that definition**, and
these instances read it so. **Nothing is amended**: no expected value moves, no
prediction is rewritten, §7's γ text is carried verbatim at both cases, and the
blank is filled **from §7's own definitions** rather than from a judgement made
with a result in hand. **The finding stands regardless of that reading being the
obvious one** — a table whose completion has to be reconstructed from prose
elsewhere has failed at the job it was written for, and this programme has paid
for left-standing summaries four times already (§0-ter's own list).

**A bound on that reading, so it cannot be over-used.** α at C3 would mean the
reference forwards a bad-FCS frame **and marks it**. That is a **result, not an
expectation**: this document does **not** predict it and must not, because §7's
frozen prediction says the reference may drop it and **a prediction may not be
sharpened after it is frozen** (§0). The α branch is named so that the outcome has
a home, **not** because the outcome is expected.

**Scope.** The same blank appears in §7's **C8** and **C9** rows. Those are
co-sim Phase 3, **SCOPED, NOT AUTHORISED** (`WO-0078` §6.3), and this document
carries no Phase-3 instance, so **no repair is owed there yet**; the finding is
recorded as reaching them so that the Phase-3 instance round does not rediscover
it.

**Owner**: dv_lead — the defect is in my own packet's §7. **Carrier**: the Stage-2
C1+C2 dispatch, which restates the branch structure, and the `RV-` that
adjudicates the first C3 or C4 result. **Class: MINOR at this commit** — no case
has run, nothing has been adjudicated under the defective cell, and it is repaired
at the instance that would have been the first to use it.

### 10.6 `FINDING CD-P2-2` (MINOR, records defect) — §0-ter's calendar literal does not match its own commit's date

§0-ter is headed *"(2026-08-09, `J-dv_lead-0132`)"*. The commits carrying this
document's history on the working branch are dated **2026-08-06** by git; the
journal volume carrying `J-dv_lead-0149` and `J-dv_lead-0150` likewise heads its
entries **2026-08-11** against commits (`beb9c2a` … `965f6ee`) all dated
2026-08-06. **A calendar literal that disagrees with the commit carrying it is not
a date — it is a second, weaker record of one, and the weaker record is the one a
reader meets first.**

**Class: MINOR, and it is a records defect, not a verification defect.** Nothing
adjudicated anywhere rests on it, and no instance in §10 does.

**What this section does about it**: §9-bis and §10 **assert no calendar date of
their own** and take `WO-0078`'s dating rule instead — dated by the commit that
carries them and by `J-dv_lead-0151`.

**Not repaired here**: §0-ter is frozen and this is an annotation beside it, never
an edit inside it. **Owner**: dv_lead. **Carrier**: recorded to the auditor via
`J-dv_lead-0151`; a document-wide date reconciliation would be an edit inside
frozen sections and is not this round's work.

### 10.7 What §10 does NOT do

1. **It permits no divergence** (§0-bis). REQ-901's (a)–(f) remain the only
   permitted set, and none of them reaches a 64-octet frame.
2. **It compares no strobe and no cross-side cycle** (§5.2's X1 and X2;
   `AP-M03` §7 bars 3 and 4, both standing).
3. **It lifts `AP-M03` §7 bar 1 for NOTHING by itself.** A bar lifts when a case
   **runs and agrees**, per class. No case in §10 has run. This document freezes
   the questions; it answers none of them.
4. **It adds no co-sim Phase 3 instance.** `WO-0078` §6.3's gate (b) stays unmet
   and is declared open, not omitted.
5. **It does not re-freeze case 0** and does not restate its pinned literal; the
   anchor is run `31080871169` / job `92549154623` at `55e16ae`.
6. **It touches no file under `test/cosim/` or `tools/cosim/`, and names no
   deliverable in either.** The stimulus construction for C1–C4 is `WO-0078`
   §6.2's assignee work and is not specified here beyond the stimulus class each
   case drives.
