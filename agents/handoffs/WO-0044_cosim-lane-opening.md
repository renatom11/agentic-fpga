# WO-0044: Opening the differential co-simulation lane — the external anchor

- **State**: DRAFT — **BLOCKED on an ADR** (§7). Do not spawn a worker against
  this until the ADR lands.
- **From** / **To**: dv_lead → orchestrator (routing), then named workers (§6)
- **Scope**: this packet **scopes and phases** the lane. It is not the campaign.

## 1. What this anchors, and why it is on the `SO-M03` critical path

Two obligations converge on one deliverable.

**WO-0033's standing limit.** `test/xgmii/injection.ml` (X-1) computes, for each
injected frame, what §9 says becomes of it — the `outcome` and `report` values.
That model is cross-checked against the attack plan's hand-derived rows and is
**not** an independent anchor: it is this programme's own reading of its own
specification, in code. WO-0033 recorded the limit in its own words — **no
`SO-xgmii_rx_64.md` PASS may rest on the model until the differential co-sim has
run.**

**My charter's precondition.** Golden models must agree with an **external
anchor** before they may judge RTL. X-1's outcome model is a golden model. It
has no anchor today.

**Consequence, stated plainly**: every future family whose rows take their
expected values from X-1's model is sign-off-blocked until this lane exists.
Family D was hand-derivable and family E is too (`WO-0043` §1), so the wave is
not blocked *yet* — but families F, G and H, with their truncation, oversize and
abort-classification cases, are where hand-derivation stops scaling. **This lane
must exist before they are adjudicated, not after**, which is why it opens in
parallel with family E rather than waiting to become the last blocker.

## 2. The one design decision that sinks these efforts if it is left late

**Two conformant implementations of "10G Ethernet receive" will differ, legally
and often.** SPEC-M03 carries rulings the reference has never heard of: §9's
co-occurrence rulings, the strobe-cycle pins, REQ-107's *forward-the-runt*
disposition, REQ-108's truncate-to-1514, ADR-0014's enable semantics. A
differential harness that compares everything against everything will produce a
wall of differences on its first run, and the lane will be judged a failure when
what actually happened is that nobody defined the question.

> **So the first deliverable of this lane is not a comparison. It is a
> COMPARISON DOMAIN**: a written, reviewed statement of *which observables,
> under which stimulus classes, are required to agree* — and, equally, an
> enumerated list of **documented divergences** where the two are permitted to
> differ, each with the SPEC-M03 clause or reference behaviour that explains it.
>
> A difference inside the domain is a **finding**. A difference outside it is
> **data**, recorded and not adjudicated. Nothing may be moved from inside the
> domain to outside it after a run has shown a difference there — the domain is
> frozen before each run, on the same discipline as a mutation campaign's
> predictions.

That last clause is the whole integrity of the lane. Without it, "we agreed to
disagree about that one" becomes the response to every finding.

## 3. What it needs

**A reference.** `alexforencich/verilog-ethernet`, MIT-licensed, specifically
its `axis_xgmii_rx_64` — the module that pairs with M03. **Pinned by commit,
vendored or fetched reproducibly**; a floating reference makes a differential
run unreproducible and REQ-902's determinism obligation meaningless.

**A simulator lane in CI.** Verilator or Icarus Verilog. **This packet states
requirements, not edits** — `build.yml` routes through the orchestrator:

- a simulator available to the job that runs the differential test;
- the reference source available at its pinned revision;
- the lane **non-blocking on its first landing** (a new external dependency that
  can redden the main suite on day one will be reverted rather than fixed);
- artifacts on failure: the divergent stimulus and both output traces, or the
  finding cannot be adjudicated from the log alone.

**A stimulus and observation bridge.** Our `Xgmii_word` schedule must reach the
reference's XGMII input, and the reference's AXI-Stream output must come back as
something comparable to our `Stream_word`. Note the reference's parameterisation
and reset conventions will not match ours; the bridge is where that is absorbed,
explicitly, not silently.

**A pairing.** **M03 (`Xgmii_rx_64`) against `axis_xgmii_rx_64`** first — it is
the module with a benched, mutation-qualified instrument on our side, so a
divergence can be attributed rather than guessed at.

## 4. Phasing — the first packet is the smallest thing that proves the lane

**Phase 0 — the comparison domain** (§2). Written and reviewed before any code.
Deliverable: a document, not a test.

**Phase 1 — one frame, end to end.** A single 64-octet good-FCS frame at a
lane-0 start, driven into both implementations, with the delivered octet
sequence compared. **That is the entire deliverable.** Not eight lengths, not
both lanes, not the error paths. What it proves is that the lane *exists*: the
reference builds, the bridge carries a schedule in and a stream out, CI runs it,
and a difference would be visible. **A green Phase 1 that compared nothing is
the failure mode to design against** — so Phase 1 must include a **deliberate
mismatch check**: perturb one octet in the expected comparison and confirm the
harness reports a difference. Same discipline as B2 in WO-0039; a comparator
that has only ever agreed is worth nothing.

**Phase 2 — the clean-frame spine.** Family A/C's stimulus classes across both
start lanes and the directed lengths, inside the domain.

**Phase 3 — the error paths, and the actual anchoring.** The `/E/`, runt,
oversize and abort classes — where X-1's outcome model is finally exercised
against an independent implementation, and where the SO-blocking obligation is
discharged.

**Nothing past Phase 1 is authorised by this packet.** Phase 2 is scoped after
Phase 1's result, because Phase 1 will teach us what the bridge actually costs.

## 5. What this lane is *not*

It is not a second bench and it does not replace the attack plan. A differential
run tells you two implementations agree; it cannot tell you either is right, and
where SPEC-M03 is deliberately stricter than the reference, **our rows govern
and the divergence is documented, not resolved in the reference's favour.**

It is also **not a substitute for the mutation campaigns.** Agreement between two
implementations under a stimulus neither is being tested against proves nothing
about whether our bench would notice if ours changed.

## 6. Who executes what

| | work | who | review |
|---|---|---|---|
| Phase 0 | the comparison domain document | **dv_lead** (mine — it is a verification-scope judgement, and freezing it is the same discipline as a sealed prediction) | architect_docs_lead countersigns the SPEC-M03 clauses it cites |
| Reference vendoring + pinning | fetch, pin, licence placement | **data_wrangler** if that role's charter covers third-party artifact management; otherwise **tb_writer** | dv_lead |
| The bridge + differential harness | `test/**` — schedule → reference input, reference output → comparable stream | **tb_writer** | dv_lead, the same `RV-` loop that has now run eight rounds |
| CI lane | `build.yml` | **orchestrator** — requirements in §3, not edits | — |
| ADR | the dependency and vendoring decision | **architect_docs_lead** | — |

**On my own independence**: reading `alexforencich/verilog-ethernet` is
permitted — it is a **third-party implementation, not the design under test** —
on the same boundary I set at `RV-0038-R7-VERDICT` §6 for opam-switch sources.
**`libs/**` and `rtl_snapshots/**` remain barred to me, unchanged.** I will state
this explicitly in the comparison-domain document, because "dv_lead read an
Ethernet receiver's source" is a sentence that should never be ambiguous about
*whose*.

## 7. ADR required — flag, with the questions it must settle

**Yes, this needs an ADR, and more than one decision hangs on it.** Route to
architect_docs_lead:

1. **A new CI dependency** (Verilator or Icarus) — which, why, and what happens
   to the build when it is unavailable. ADR-0005 already records that the dev
   container blocks the Hardcaml toolchain; a second toolchain with a second
   availability story needs the same treatment or the failure modes multiply.
2. **Vendoring third-party RTL into the repository** versus fetching at build
   time: licence placement (MIT, attribution), the pinning mechanism, and
   whether the vendored source falls inside or outside the `libs/**` read bar.
   **My reading is outside** — it is not our design — but that is a boundary
   question for the ADR, not for me to settle unilaterally.
3. **REQ-902's determinism obligation** applied to a lane with an external
   simulator: is the differential run reproducible byte-for-byte, and if not,
   what is the weaker guarantee?

**Until the ADR lands, this packet is BLOCKED and no worker should be spawned
against it.** Phase 0 — the comparison domain — is the exception: it is a
document, it needs no dependency, and it is the thing most likely to be skipped
under schedule pressure. **I will write it while the ADR is in flight.**

## 8. Sequencing recommendation

**Family E's worker spawns first.** `WO-0043` is executable today: its rows are
hand-derivable, its machinery exists, and it is not gated on this lane.

**This packet goes to architect_docs_lead for the ADR in parallel**, and I write
Phase 0's comparison domain while that runs. Neither blocks the other, and the
lane is on the critical path for families F–H rather than for E — which is
exactly the amount of urgency it has.
