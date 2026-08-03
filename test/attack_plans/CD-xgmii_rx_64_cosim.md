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
