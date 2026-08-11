# Export packet — SO-xgmii_rx_64 (the origin program's first lessons harvest)

- **Source org**: the [agentic-fpga program](https://github.com/renatom11/agentic-fpga)
  (the origin program — FEDERATION §10: no privileged lane; this packet takes
  the same pipeline as any contributor's), project slug `nic`, branch
  `claude/fpga-hardcaml-agent-orchestration-37ceyf`.
- **Parent record**: `SO-xgmii_rx_64` — the module sign-off, **PASS, fourteen
  of fourteen criteria, one token**, at sign-off SHA
  [`41fead6`](https://github.com/renatom11/agentic-fpga/commit/41fead67b9fa7ec22f54e807f830c0b64faefb9c)
  (`J-dv_lead-0168`, landed `69f1475`), after two honest FAILs preserved quoted
  beneath it. An `SO-` is a record the sponsor does not sign; its outer-hop
  decision would defer to the next sponsor-signed gate by FEDERATION §7 —
  **transmission authority here is the sponsor's own standing direction**,
  given in-session to the source org's orchestrator for this specific first
  harvest ("on a PASS: the harvest transit — as inbox PR"), not a default
  acted on.
- **Date**: 2026-08-11.
- **Citation base** (ADR-0017 A1): every bare SHA, CI run id, or
  `J-<agent>-NNNN` journal-entry id in this packet resolves in
  <https://github.com/renatom11/agentic-fpga>; each section header carries a
  permalink to its note at the note's landed SHA. The source repository is
  public, so permalinks resolve; they supplement the packet text (§9).
- **Provisional ids**: `LC-`/`LD-` ids below are the source org's, seat-
  qualified and unrenumbered per its ADR-0018 §4.3 (Amendment A2). Final ids
  are the landing fence's to allocate (§4, §8.1 step 4).
- **Collation record**: the census, extraction verification (byte-fidelity
  checks and an independent 14-of-14 sample), merge sweeps, and hide-test
  record are committed at the source as
  [`HT-01_first-harvest-transit.md`](https://github.com/renatom11/agentic-fpga/blob/claude/fpga-hardcaml-agent-orchestration-37ceyf/agents/handoffs/HT-01_first-harvest-transit.md).

## Self-containment statement (§9), read before screening

Each candidate row carries its **statement verbatim** from the minting seat's
harvest note. Where the note discharges LH1/LH3 **per row** (architect 94,
rtl_lead 50, auditor 54, orchestrator 18), the row carries that text — the
LH3 "breaks without it" clause is the incident-consequence material §9 asks
for. Where the note discharges LH1/LH3 **at the cited entry** rather than in
row text (dv_lead 95, tb_writer 28, data_wrangler 14), the section header
says so and every citation is a qualified permalink into the public source;
the fence's LH-bars screen may judge those rows at the permalink or bounce
them individually — the packet states this rather than papering over it.

## Tier summary

- **Tier 1 (`LC-`, general)**: 352 rows, in seven seat sections below.
- **Tier 2 (`LD-`, domain)**: 1 row — `LD-SO-xgmii_rx_64-1` (dv_lead), target
  pack `version-control` (a pack this shell has not yet created; §8.1 step 4
  decides pack creation).
- **Pre-screened redundancy** (the fence re-runs this): four rows merge to the
  seeded corpus with the seeded statement surviving —
  `LC-SO-xgmii_rx_64-ADL-45` → `L-B15`, `LC-rtl_lead-H1-8` → `L-D03`,
  `LC-SO-xgmii_rx_64-AUD-14` → `L-C15`, `LC-SO-xgmii_rx_64-AUD-10` → `L-E06`;
  marked on their rows.
- **Hide test at the source**: 353/353 clean on project nouns. Two rows
  (`LC-orchestrator-H1-2`, `-8`) carry version-control tool nouns under a
  stated LH2-g — flagged at the source as `OBSERVATION SO-O1`, transited as
  general with the reasoning recorded in HT-01 §3.4; the fence's leak screen
  rules on them independently.
- **War stories**: appendix, 47 refused candidates with the criterion each
  failed.

---

## dv_lead — 95 candidates

**Note**: the packet-carried note: `SO-xgmii_rx_64.md` §4.2–§4.7 (signing entry `J-dv_lead-0161`; bank at §4.5) · **span**: J-dv_lead-0001 … -0165 · [source at `69f1475`](https://github.com/renatom11/agentic-fpga/blob/69f1475/agents/handoffs/SO-xgmii_rx_64.md)

> Ids are the notes own `LC-SO-xgmii_rx_64-<n>` (grandfathered by A2). LH1 and LH3 are declared discharged per candidate **at the cited entry** by the notes §4.5 preamble ("Not one candidate was admitted on a note that lacked either"); grades: 94 `LC-` tier-1 and 1 `LD-` tier-2 (pack `version-control`), per the notes count table.

### `LC-SO-xgmii_rx_64-1`

an idiom that partitions a stream by its own terminator presumes every partition is non-empty

**Provenance.** `0099`

### `LC-SO-xgmii_rx_64-2`

a helper lifted out of its first caller inherits that caller's name, so the name describes the situation rather than the obligation

**Provenance.** `0100`

### `LC-SO-xgmii_rx_64-3`

an instruction that exempts an artefact from review by asserting it correct; **extended**: a change proposal states which existing claims its own instructions make false

**Provenance.** `0101`, `0104`, `0105`

### `LC-SO-xgmii_rx_64-4`

a negative claim about an instrument must be derived from its **matching rule**, never from its documentation

**Provenance.** `0102`

### `LC-SO-xgmii_rx_64-5`

a precaution vindicated because the number was right must record **both** the confirmation and the price the precaution charged

**Provenance.** `0103`

### `LC-SO-xgmii_rx_64-6`

search an open enumeration by the **defect** it enumerates, never by the string its known instances share

**Provenance.** `0104`, `0105`, `0108`, `0109`

### `LC-SO-xgmii_rx_64-7`

a correction to an enumeration must be produced by the method that would have produced the enumeration correctly, never derived from the erroneous version

**Provenance.** `0106`, `0107`, `0109`

### `LC-SO-xgmii_rx_64-8`

a question offered as a choice between n values asserts the answer lies among them; state the dimension the values range over

**Provenance.** `0107`, `0108`, `0109`, `0116`, `0117`

### `LC-SO-xgmii_rx_64-9`

a set built by a mechanical pass must state the relation its pass assumes, and a one-to-one assumption is checked against the many-to-many case

**Provenance.** `0108`, `0109`

### `LC-SO-xgmii_rx_64-10`

a bound stated as a conjunction is discharged only by a stimulus containing every conjunct

**Provenance.** `0111`, `0113`, `0115`

### `LC-SO-xgmii_rx_64-11`

a list of pre-committed reject conditions guarantees the reviewer's independence, never coverage

**Provenance.** `0112`, `0113`

### `LC-SO-xgmii_rx_64-12`

when a repair is defended on a property of the objects it handles, check whether the same site handles an object lacking it

**Provenance.** `0113`, `0115`

### `LC-SO-xgmii_rx_64-13`

when identifiers are matched into free text, require a boundary wherever one is a prefix of another

**Provenance.** `0114`

### `LC-SO-xgmii_rx_64-14`

a stimulus pinning two events to one instant is an instrument for one defect class and a blindfold for another

**Provenance.** `0115`, `0117`

### `LC-SO-xgmii_rx_64-15`

when a prediction and an independent derivation disagree, resolve it from the shared source both claim to derive from

**Provenance.** `0116`

### `LC-SO-xgmii_rx_64-16`

a sentence asserting the result of a census is not the census; re-measure at every re-statement, **or state what state the measurement was taken in**

**Provenance.** `0117`, `0118`, `0119`, `0120`, `0124`

### `LC-SO-xgmii_rx_64-17`

predict a set by stating the rule that generates it, not by listing its known members

**Provenance.** `0117`

### `LC-SO-xgmii_rx_64-18`

a tool commissioned in response to a failure must be checked against the instances that commissioned it

**Provenance.** `0118`

### `LC-SO-xgmii_rx_64-19`

keep the counter that measures an instrument separate from the counter that measures obligations discharged

**Provenance.** `0118`

### `LC-SO-xgmii_rx_64-20`

where a stimulus is generated by two mechanisms, a coincidence constraint is checked against the stimulus **as delivered**

**Provenance.** `0119`

### `LC-SO-xgmii_rx_64-21`

a stated kill is a claim about a stimulus and is re-derived from that stimulus each time the row is commissioned

**Provenance.** `0119`

### `LC-SO-xgmii_rx_64-22`

count a construct by the element its grammar makes mandatory, never by the identifiers its authors chose

**Provenance.** `0120`

### `LC-SO-xgmii_rx_64-23`

when a specification states an outcome as covering two alternatives, check each against the same document's own exclusions

**Provenance.** `0121`

### `LC-SO-xgmii_rx_64-24`

every instruction in a review bar must be executable, as written, by the party the bar assigns it to

**Provenance.** `0122`

### `LC-SO-xgmii_rx_64-25`

when a specification orders a set of values checked, it must derive **every** value in that set

**Provenance.** `0122`, `J-tb_writer-0028`

### `LC-SO-xgmii_rx_64-26`

an authorised deviation from a pre-committed check must name the check and state the exception in that check's instrument's terms

**Provenance.** `0123`

### `LC-SO-xgmii_rx_64-27`

a rule minted inside a document must be run over the rest of that same document before the document ships

**Provenance.** `0123`

### `LC-SO-xgmii_rx_64-28`

when a reviewer's instruction characterises a source document, open the source before writing the characterisation down

**Provenance.** `0124`

### `LC-SO-xgmii_rx_64-29`

a round with an enumerated scope repairs what it was given and **reports what it finds**, with its class named

**Provenance.** `0124`

### `LC-SO-xgmii_rx_64-30`

score a prediction by the provenance of its dominant term, not by its subject

**Provenance.** `0126`

### `LC-SO-xgmii_rx_64-31`

a rule stated as bands must be shown exhaustive **and** disjoint before it is committed

**Provenance.** `0126`

### `LC-SO-xgmii_rx_64-32`

a tool that captures a subprocess's output and replays it stamps the replay, not the execution

**Provenance.** `0126`

### `LC-SO-xgmii_rx_64-33`

where a seat is obliged to state a fact it has no instrument to measure, name the substitute

**Provenance.** `0127`

### `LC-SO-xgmii_rx_64-34`

a disclosure that lives only in a channel the record does not keep is a disclosure the next reviewer will not have

**Provenance.** `0127`

### `LC-SO-xgmii_rx_64-35`

prefer a discharge the instrument can see over a discharge the reader must be told about

**Provenance.** `0128`

### `LC-SO-xgmii_rx_64-36`

when a claim is repaired by adding a second witness, re-point every index that names the first

**Provenance.** `0128`

### `LC-SO-xgmii_rx_64-37`

a review instrument's stated expected value is a claim and must be derived from the same source the work is

**Provenance.** `0129`

### `LC-SO-xgmii_rx_64-38`

a guard's entry condition must project the guard's own subject, re-derived for each thing guarded

**Provenance.** `0130`

### `LC-SO-xgmii_rx_64-39`

a review bar quantifying over a whole tree must be executed against the unchanged baseline before it is issued, or restated as a delta

**Provenance.** `0131`

### `LC-SO-xgmii_rx_64-40`

a table of derived quantities and a list of required assertions are different objects; mark each quantity required or carried **at the quantity**

**Provenance.** `0131`

### `LC-SO-xgmii_rx_64-41`

a self-deleting artefact needs a named executor as well as a named condition

**Provenance.** `0132`

### `LC-SO-xgmii_rx_64-42`

a function whose branches are selected by a caller-supplied value owes a witness of **which branch ran**

**Provenance.** `0132`

### `LC-SO-xgmii_rx_64-43`

an assertion whose subject a sibling already compares, positionally and earlier, is unreachable, and its green is evidence about the sibling

**Provenance.** `0133`

### `LC-SO-xgmii_rx_64-44`

a packet defining its own frozen baseline must name the commit that stages it, never that commit's parent

**Provenance.** `0134`

### `LC-SO-xgmii_rx_64-45`

a claim that two events cannot be told apart must state the scope at which it holds

**Provenance.** `0134`

### `LC-SO-xgmii_rx_64-46`

a prediction of which tests detect a defect must be keyed on the condition the defect fires on, never on the category the tests belong to

**Provenance.** `0135`

### `LC-SO-xgmii_rx_64-47`

a rule naming the condition a class keys on must also name every gate the rendering may **not** remove

**Provenance.** `0137`

### `LC-SO-xgmii_rx_64-48`

a collision inventory is derived from the cross product of predictions with observations

**Provenance.** `0137`

### `LC-SO-xgmii_rx_64-49`

where a condition has more than one reporter, a coverage claim names which reporter each bound assertion observes

**Provenance.** `0137`

### `LC-SO-xgmii_rx_64-50`

an inventory of a language construct must be scoped by file type, never by directory

**Provenance.** `0139`

### `LC-SO-xgmii_rx_64-51`

where one exit code covers several stages, the stage must be named in the text

**Provenance.** `0139`

### `LC-SO-xgmii_rx_64-52`

an observable expressed as an absence cannot distinguish never-produced from produced-and-suppressed

**Provenance.** `0140`

### `LC-SO-xgmii_rx_64-53`

a harness's own refusal guard is evaluated before the component under test is read, so no mutation of it can score the guard

**Provenance.** `0140`

### `LC-SO-xgmii_rx_64-54`

a path cited in a normative instrument is verified to resolve at the tree the instrument governs, before the instrument is issued

**Provenance.** `0141`, **`RN-6`**

### `LC-SO-xgmii_rx_64-55`

an artefact quoting a component's diagnostic message derives it from that component's source at the frozen revision

**Provenance.** `0142`

### `LC-SO-xgmii_rx_64-56`

when a document asserts a count of its own marked cells, the count is re-derived from the table

**Provenance.** `0142`

### `LC-SO-xgmii_rx_64-57`

a document absorbing another's result re-derives every quantity it carries forward, and marks any it could not

**Provenance.** `0143`

### `LC-SO-xgmii_rx_64-58`

a test case that is the only exerciser of a branch may not be specified as optional

**Provenance.** `0144`

### `LC-SO-xgmii_rx_64-59`

a guard specified against a condition of the input cannot be implemented by a detector reading the output unless the mapping is injective

**Provenance.** `0144`

### `LC-SO-xgmii_rx_64-60`

an assertion that names its expected value without reporting the observed one collapses every distinct cause into one indistinguishable effect

**Provenance.** `0145`

### `LC-SO-xgmii_rx_64-61`

a universal asserted over one stimulus producer is measured over **every** producer that drives the unit under test

**Provenance.** `0147`

### `LC-SO-xgmii_rx_64-62`

a set enumerated from how its members are **named** is a different set from the one a rule selects

**Provenance.** `0148`

### `LC-SO-xgmii_rx_64-63`

a silence assertion over an interval where a conformant component is already silent measures only defects that **add**

**Provenance.** `0148`

### `LC-SO-xgmii_rx_64-64`

when an instrument is measured capable on exactly one configuration, freeze it and add new ones beside it

**Provenance.** `0149`

### `LC-SO-xgmii_rx_64-65`

a census of refusal guards records, per guard, the state variable it tests and the interval over which it is true — never the condition its message names

**Provenance.** `0152`

### `LC-SO-xgmii_rx_64-66`

in a differential harness the bookkeeping layers on the two sides are common-mode

**Provenance.** `0152`

### `LC-SO-xgmii_rx_64-67`

when a review recommends a settlement on a stated ground, the round that executes it re-measures that ground at the source

**Provenance.** `0153`

### `LC-SO-xgmii_rx_64-68`

a repair that changes which inputs a component **accepts** also changes which outputs it **produces**

**Provenance.** `0154`

### `LC-SO-xgmii_rx_64-69`

a record format in which the owner is implied by position is unambiguous only while one owner can be open at a time

**Provenance.** `0154`

### `LC-SO-xgmii_rx_64-70`

a bound introduced to make a buffer finite is sized against the workload in front of its author; state the range it must cover in the same change

**Provenance.** `0155`

### `LC-SO-xgmii_rx_64-71`

when a format loses a fact, move the fix upstream to where the fact is still observable

**Provenance.** `0155`

### `LC-SO-xgmii_rx_64-72`

a frozen prediction is spent by a comparison that could have falsified it — count comparisons, not runs

**Provenance.** `0155`

### `LC-SO-xgmii_rx_64-73`

where the interesting fact is a value rather than a relation, print the agreed value on the passing path

**Provenance.** `0156`

### `LC-SO-xgmii_rx_64-74`

a quantity whose comparison is barred does not become assertable by reproducing; reproduction earns confidence, never jurisdiction

**Provenance.** `0156`

### `LC-SO-xgmii_rx_64-75`

when the reason a standing refusal rested on expires, replace the reason before restating the conclusion, and attach a condition

**Provenance.** `0156`

### `LC-SO-xgmii_rx_64-76`

a readiness census over the layers that **consume** an input is not a readiness census; "no mechanism exists" is a measurement over a stated set or a guess

**Provenance.** `0157`

### `LC-SO-xgmii_rx_64-77`

an answered question re-asked without citing its answer is a new question to everyone downstream

**Provenance.** `0158`

### `LC-SO-xgmii_rx_64-78`

a per-unit cost claim is read on a per-unit measurement, never on a total containing a unit-invariant part

**Provenance.** `0158`

### `LC-SO-xgmii_rx_64-79`

a divergence-class question is answered per equivalence class of the exclusion's own axes, never per family and never per case

**Provenance.** `0160`

### `LC-SO-xgmii_rx_64-80`

a bar over a corpus whose entries may not be edited needs a declared exception list, and an exception that no longer fires must fail

**Provenance.** `0163`

### `LC-SO-xgmii_rx_64-81`

a carried-obligation list is a claim about the present and goes stale like any other measurement

**Provenance.** `0163`

### `LC-SO-xgmii_rx_64-82`

a record of what two implementations agreed on may contain only the quantities that were compared

**Provenance.** `0163`

### `LC-SO-xgmii_rx_64-83`

where a change is cheap but the instrument that would give it meaning is expensive, the refusal is priced by the instrument

**Provenance.** `0163`

### `LC-SO-xgmii_rx_64-84`

a check that judges committed artefacts must resolve every reference against the version-controlled tree, never the working filesystem

**Provenance.** `0164`

### `LD-SO-xgmii_rx_64-1` — **domain tier, pack `version-control`; not part of the general body**

a store that records only leaf objects cannot represent an empty container, so a namespace that must be citable needs a committed leaf inside it. **Pack: `version-control`**

**Provenance.** `0164`

### `LC-SO-xgmii_rx_64-85`

an exception-list entry whose expiry is already fixed by a scheduled obligation is a deferred failure with a known date, not a disposition

**Provenance.** `0164`

### `LC-SO-xgmii_rx_64-86`

an instrument that grades documents by a rule may not itself violate that rule

**Provenance.** `0164`

### `LC-SO-xgmii_rx_64-87`

a blind text-pattern equivalence check cannot distinguish payload from prose; enumerate what the check **cannot** match, not only what it does

**Provenance.** `J-tb_writer-0022`

### `LC-SO-xgmii_rx_64-88`

where an upstream instruction would skip a standing onboarding step, the standing rule wins by default

**Provenance.** `J-tb_writer-0023`

### `LC-SO-xgmii_rx_64-89`

route a call to the sibling helper whose **stated precondition** it satisfies, not to the one whose type signature it fits

**Provenance.** `J-tb_writer-0024`

### `LC-SO-xgmii_rx_64-90`

a guard asserting a negative property is at highest risk of encoding the inverse of its own table; prefer a positive, table-keyed assertion

**Provenance.** `J-tb_writer-0025`

### `LC-SO-xgmii_rx_64-91`

a checker that stops before name resolution cannot see an unbound name; compare the token against a corpus known to run

**Provenance.** `J-tb_writer-0026`

### `LC-SO-xgmii_rx_64-92`

an absolute prohibition is crossed in a task's opening moves, by habit, before its text has been read in full

**Provenance.** `J-tb_writer-0027`

### `LC-SO-xgmii_rx_64-93`

weight precedents by their **unanimity**, not by their existence

**Provenance.** `J-tb_writer-0029`

### `LC-SO-xgmii_rx_64-94`

intake and application are two separate acts; satisfying the first is not evidence the second happened

**Provenance.** `J-tb_writer-0030`


## architect_docs_lead — 94 candidates

**Note**: `J-architect_docs_lead-0034` · **span**: J-architect_docs_lead-0001 … -0033 (exclusive end per A2-D10) · [source at `54b2553`](https://github.com/renatom11/agentic-fpga/blob/54b2553/agents/journals/claude_architect_docs_lead_agent.v02.md)

> All 94 are graded **tier 1 / LH2-g** by the notes blanket declaration; the tier-2/`LD-` result is NIL, declared with cause. LH1 and LH3 are per-candidate table columns, reproduced below. The note twice says "sixty-two candidates" against its own 94 measured rows — a source self-contradiction preserved, not repaired (the row count and every other mention read ninety-four).

### `LC-SO-xgmii_rx_64-ADL-1`

Record each deliberate exclusion as a numbered item carrying the same status as an inclusion.

**Provenance.** `08899d3` · `-0001`

**Breaks without it.** An absence is indistinguishable from an oversight; it is re-litigated or silently re-added, and nothing can be tested in the negative.

### `LC-SO-xgmii_rx_64-ADL-2`

A correspondence between two documents that must stay exact is produced by generation and checked by set comparison, never maintained by proofreading.

**Provenance.** `08899d3` · `-0001`; re-run every round to `ce5674d`

**Breaks without it.** The two drift while each stays internally consistent, so no reader of either can see it.

### `LC-SO-xgmii_rx_64-ADL-3`

When a reviewer's requested change is right in intent and unsatisfiable as written, apply the intent in a corrected form and record the departure as a contest — never silently improve it.

**Provenance.** `b4b4cf4` · `-0002`

**Breaks without it.** The re-review compares against a list whose items have quietly changed meaning, and can detect neither the improvement nor an error in it.

### `LC-SO-xgmii_rx_64-ADL-4`

When two of your own statements disagree, settle it on a ground outside the disputed system.

**Provenance.** `b4b4cf4` · `-0002`

**Breaks without it.** You pick the reading that matches the most recent draft, and the error survives with a justification attached to it.

### `LC-SO-xgmii_rx_64-ADL-5`

Where two readings of a standard's convention are both defensible, prefer the one under which the standard's own published figure holds at every configuration it defines.

**Provenance.** `b4b4cf4` · `-0002`

**Breaks without it.** The other reading makes one configuration exceptional, and the exception is later read as a defect by whatever meets it first.

### `LC-SO-xgmii_rx_64-ADL-6`

Where two representations differ by a fixed transformation and cost the same, expose the one that needs no conversion at any consumer.

**Provenance.** `22145b5` · `-0003`

**Breaks without it.** Every consumer, test and oracle applies the same conversion independently; one that forgets produces a plausible wrong answer.

### `LC-SO-xgmii_rx_64-ADL-7`

Leave an out-of-domain input unconstrained rather than defining it as the identity.

**Provenance.** `22145b5` · `-0003`; confirmed `f78766e` · `-0004`

**Breaks without it.** With the identity defined, a caller that reaches the out-of-domain value produces a correct-looking result and the mistake is invisible.

### `LC-SO-xgmii_rx_64-ADL-8`

A frozen document may carry unfinished items, but each must state what a reader may assume meanwhile; an item that cannot state that is open, not deferred.

**Provenance.** `f78766e` · `-0004`

**Breaks without it.** "Frozen" degrades into either an unattainable bar or a stopped pen, and downstream readers guess.

### `LC-SO-xgmii_rx_64-ADL-9`

Identifiers cited from outside a document are permanent: close in place, append at the end, never insert or renumber.

**Provenance.** `f78766e` · `-0004`; `1fe71ca` · `-0013`; `ebb3f49` · `-0016`; `3526e79` · `-0032`

**Breaks without it.** Every external citation silently re-points, and a reference that used to be true becomes false with no document changing.

### `LC-SO-xgmii_rx_64-ADL-10`

A budget decomposed across components is checkable only in an additive quantity; when every component passes and the composition fails, suspect the unit before the allocation.

**Provenance.** `f78766e` · `-0004`

**Breaks without it.** The reconciliation is spent lowering per-component limits, which preserves the defect and destroys the headroom.

### `LC-SO-xgmii_rx_64-ADL-11`

Place a correction where its reader arrives, not where its subject is filed — the right document, and the right row inside it.

**Provenance.** `508eea2` · `-0005`; `62c39a7` · `-0017`; `ce5674d` · `-0033`

**Breaks without it.** The reader derives the corrected-away behaviour from the text they actually hold, and the correction is invisible at the point of use.

### `LC-SO-xgmii_rx_64-ADL-12`

Adjudicate the class the corner case is an instance of and state the closure rule; answering the corner answers one question.

**Provenance.** `508eea2` · `-0005`; `aaa55b2` · `-0008`

**Breaks without it.** Every sibling corner returns as a new question, each costing a round, and the separate answers drift apart.

### `LC-SO-xgmii_rx_64-ADL-13`

A table complete on some dimensions and summarised on others says which, inside the table.

**Provenance.** `508eea2` · `-0005`

**Breaks without it.** A reader counts rows and concludes a coverage that was never claimed.

### `LC-SO-xgmii_rx_64-ADL-14`

A report names where a defect was noticed; the repairing round derives where it lives and covers that — both the other sites restating it and the other components exhibiting it.

**Provenance.** `a9993ff` · `-0006`; `8641455` · `-0010`; `ebb3f49` · `-0016`; `a77017c` · `-0024`; `ce5674d` · `-0033`

**Breaks without it.** The repair leaves the same defect standing where nobody looked, and the document now contradicts itself at the unrepaired sites.

### `LC-SO-xgmii_rx_64-ADL-15`

Re-derive the price of an option before rejecting it under deadline.

**Provenance.** `3f6accc` · `-0007`

**Breaks without it.** A stale price decides a question that was never argued, and the record shows a choice made on merit when it was made on an arithmetic error.

### `LC-SO-xgmii_rx_64-ADL-16`

Record the rejected alternative in the artefact the decision is cited from, not only in the decider's own log.

**Provenance.** `3f6accc` · `-0007`

**Breaks without it.** A reader who can reach the ruling but not the alternative cannot audit it, and the choice reads as forced.

### `LC-SO-xgmii_rx_64-ADL-17`

Take evidence at the artefact's own state; evidence taken at a neighbouring state plus an argument that nothing moved is a claim that decays unchecked.

**Provenance.** `aaa55b2` · `-0008`

**Breaks without it.** The connecting argument goes stale silently, and the record then asserts evidence it does not have.

### `LC-SO-xgmii_rx_64-ADL-18`

A deferred item names its closing event, and the round in which that event occurs closes it.

**Provenance.** `aaa55b2` · `-0008`

**Breaks without it.** The tracking column becomes decoration, and a genuinely blocking deferral is indistinguishable from a note.

### `LC-SO-xgmii_rx_64-ADL-19`

A defect left unfixed only because fixing it now is expensive is recorded as a defect with its trigger, never as a decision.

**Provenance.** `aaa55b2` · `-0008`

**Breaks without it.** The next party to open that region has no reason to fix it, and either re-derives the same trade-off or never sees it.

### `LC-SO-xgmii_rx_64-ADL-20`

When owed changes compete for one round, take those whose cost rises at the next state change and carry those whose cost does not.

**Provenance.** `d8df28d` · `-0009`; applied `8641455`, `541ea43`; refused `06c1eba`; taken `1fe71ca`

**Breaks without it.** The round either takes everything and blows its review surface, or takes the loudest item while a cheap-now/dear-later one rolls into a much larger change.

### `LC-SO-xgmii_rx_64-ADL-21`

When two correct measurements of one phenomenon disagree, publish both with the event each is measured to.

**Provenance.** `8641455` · `-0010`

**Breaks without it.** The discarded figure resurfaces elsewhere as an apparent contradiction, and every reader who meets it re-derives.

### `LC-SO-xgmii_rx_64-ADL-22`

A rule carried to another component by analogy is re-derived there, and the case distinguishing the analogy from the derivation is constructed.

**Provenance.** `8641455` · `-0010`

**Breaks without it.** The transposed rule is confirmed by every ordinary case and fails on a class nobody tests.

### `LC-SO-xgmii_rx_64-ADL-23`

When a checkable claim is falsified, replace it with another checkable claim, never with a hedge.

**Provenance.** `8641455` · `-0010`

**Breaks without it.** Hedged text cannot be falsified, so the next error of the same class is undiscoverable — and checkability is what made this one findable.

### `LC-SO-xgmii_rx_64-ADL-24`

An implementation's declared behaviour is evidence of what was built, never of what was required.

**Provenance.** `541ea43` · `-0011`

**Breaks without it.** The specification silently becomes a description of the code, and the independent check it exists to provide is gone.

### `LC-SO-xgmii_rx_64-ADL-25`

Before narrowing a specified space, enumerate what has already been commissioned inside it and show each survives.

**Provenance.** `541ea43` · `-0011`

**Breaks without it.** The narrowing retires a commissioned check, and the retirement surfaces later as an unexplained coverage drop nobody can date.

### `LC-SO-xgmii_rx_64-ADL-26`

Never normalise an untrusted input into a legal value to make a branch total.

**Provenance.** `541ea43` · `-0011`

**Breaks without it.** A hostile or malformed input becomes indistinguishable from valid traffic, where an unhandled case fails loudly at the first test.

### `LC-SO-xgmii_rx_64-ADL-27`

A record of another party's statement is corrected by that party, never by its holder; a later correction is a new record beside it.

**Provenance.** `06c1eba` · `-0012`; `62c39a7` · `-0017`; `a12ac8f` · `-0030`

**Breaks without it.** The record of an exchange stops being evidence of the exchange, and the correction cannot be dated or attributed.

### `LC-SO-xgmii_rx_64-ADL-28`

When a sentence carries a rule and an explanatory restatement that disagree, check whether the restatement could be a rule at all before treating the repair as a choice.

**Provenance.** `06c1eba` · `-0012`

**Breaks without it.** A forced disposition is treated as a choice, which drags in an authority the repair never needed and makes an arbitrary pick look adjudicated.

### `LC-SO-xgmii_rx_64-ADL-29`

Classify a change on two independent axes — what it changes, and whose approval it needs — and state the discriminator.

**Provenance.** `1fe71ca` · `-0013`; `ebb3f49` · `-0016`; `62c39a7` · `-0017`; `0caf023` · `-0023`; `a77017c` · `-0024`; `d54c931` · `-0026`; `8725c81` · `-0027`; `a12ac8f` · `-0030`; `b6ef1cb` · `-0031`; `ce5674d` · `-0033`

**Breaks without it.** One answer silently follows the other: a change that alters nobody's behaviour but moves the text a reviewer's verdict rests on ships without that reviewer.

### `LC-SO-xgmii_rx_64-ADL-30`

Give every change class a deletion test — what would differ if the text were removed — and state it in the record.

**Provenance.** `8725c81` · `-0027`; `a12ac8f` · `-0030`; `b6ef1cb` · `-0031`; `ce5674d` · `-0033`

**Breaks without it.** A class named without a test drifts to whatever the author wants it to mean this round, and the lightest class absorbs everything.

### `LC-SO-xgmii_rx_64-ADL-31`

State the fact a deferral rests on, so that when the fact changes the deferral can be revisited without re-arguing it.

**Provenance.** `1fe71ca` · `-0013`

**Breaks without it.** A deferral justified by a general preference can never be revisited; it is re-argued from scratch or never.

### `LC-SO-xgmii_rx_64-ADL-32`

A partial pass over a class is evidence about the passing members only if the mechanism is uniform over the class; and a universal checked at one instance — especially the instance an existing worked example made cheap — is not checked.

**Provenance.** `1fe71ca` · `-0013`; `d54c931` · `-0026`

**Breaks without it.** Two-red-of-three is read as the third being right, and a prediction is "confirmed" at exactly the member where the error is invisible.

### `LC-SO-xgmii_rx_64-ADL-33`

When an access restriction is relaxed, state the converse obligation it was protecting.

**Provenance.** `9d357e6` · `-0014`

**Breaks without it.** The permission erodes one convenient use at a time, and nobody can point to the step that crossed the line.

### `LC-SO-xgmii_rx_64-ADL-34`

If review and enforcement read changes as content diffs, never adopt a dependency whose update appears as an identifier rather than as content.

**Provenance.** `9d357e6` · `-0014`

**Breaks without it.** The change is invisible to every control you have, and no rule catches it because no rule is about it.

### `LC-SO-xgmii_rx_64-ADL-35`

Verify an instruction's premise against the artefact before executing it.

**Provenance.** `9d357e6` · `-0014`; `a378612` · `-0022`; `a12ac8f` · `-0030`; `3526e79` · `-0032`

**Breaks without it.** An instruction right about the action and wrong about the state produces a false claim signed by the executor, or a refused commit.

### `LC-SO-xgmii_rx_64-ADL-36`

A guarantee that is never exercised is a claim; make the round that introduces it exercise it once.

**Provenance.** `9d357e6` · `-0014`

**Breaks without it.** The guarantee is cited for the life of the project and has never been true.

### `LC-SO-xgmii_rx_64-ADL-37`

When an authority approves one question, record in the same document what the approval does not reach.

**Provenance.** `d3a5a1d` · `-0015`

**Breaks without it.** Decisions made in-role acquire borrowed authority and become unchallengeable by the parties entitled to challenge them.

### `LC-SO-xgmii_rx_64-ADL-38`

A record of a statement received through an intermediary says so, and names the check that would surface an alteration.

**Provenance.** `d3a5a1d` · `-0015`

**Breaks without it.** A second-hand record is indistinguishable from a first-hand one, so a relay error is undiscoverable.

### `LC-SO-xgmii_rx_64-ADL-39`

When a status changes, sweep the body for every sentence the change falsifies.

**Provenance.** `d3a5a1d` · `-0015`; `9d357e6` · `-0014`; `62c39a7` · `-0017`; `a378612` · `-0022`

**Breaks without it.** A corrected header over a stale body is worse than neither, because the header licenses trust in the body.

### `LC-SO-xgmii_rx_64-ADL-40`

A universal negative relayed through more than one party is re-measured by whoever writes it into binding text, with the measuring command beside the claim.

**Provenance.** `ebb3f49` · `-0016`; `ce5674d` · `-0033`

**Breaks without it.** Relayed negatives accumulate confidence without accumulating evidence, and the binding text asserts something nobody has checked.

### `LC-SO-xgmii_rx_64-ADL-41`

Two exceptions sharing a cause but differing in extent are declared separately, each with the narrowest exclusion it needs.

**Provenance.** `ebb3f49` · `-0016`; `3526e79` · `-0032`

**Breaks without it.** Merging forces the wider exclusion on both and silently retires the checks the narrower one preserved — the document gets more permissive while looking tidier.

### `LC-SO-xgmii_rx_64-ADL-42`

State an enumeration, never its count.

**Provenance.** `ebb3f49` · `-0016`; `62c39a7` · `-0017`

**Breaks without it.** The count goes stale at the first addition, reads as prose rather than as a claim, and is the copy every sweep misses.

### `LC-SO-xgmii_rx_64-ADL-43`

When the cascade exceeds the round, enumerate the unrepaired sites by name with the verdict for each — including the sites that need no repair — and state the cost of leaving them.

**Provenance.** `ebb3f49` · `-0016`; `a77017c` · `-0024`

**Breaks without it.** An unnamed cascade is rediscovered by whoever trips on it, and a list of only the failures invites a later reader to "fix" a passing site.

### `LC-SO-xgmii_rx_64-ADL-44`

When a decision's stated reason has gone stale but the decision has not, repair the reason and leave the decision.

**Provenance.** `62c39a7` · `-0017`

**Breaks without it.** Deleting the reason loses it; rewriting the decision changes something nobody decided to change; leaving it lets a reader derive a false premise from a true sentence.

### `LC-SO-xgmii_rx_64-ADL-45` — **merges to seeded L-B15; the seeded statement survives (A2-D8); this candidate's provenance joins it**

Before adopting a proposed rule, run it backwards over the history it claims to govern and count what it would have refused.

**Provenance.** `f3f5210` · `-0018`

**Breaks without it.** A rule validated only against the incident that prompted it is measured on a sample of one; it then blocks correct work or is quietly ignored.

### `LC-SO-xgmii_rx_64-ADL-46`

Choose a rule's enforcement class from the decidability of its antecedent, not from its importance.

**Provenance.** `f3f5210` · `-0018`; `8d83371` · `-0019`

**Breaks without it.** A rule whose antecedent needs judgement about prose, made blocking, refuses the very report that discovers the thing it forbids.

### `LC-SO-xgmii_rx_64-ADL-47`

A namespace that carries an implicit guarantee admits only members that satisfy it.

**Provenance.** `f3f5210` · `-0018`

**Breaks without it.** The first member that does not forces every reader to learn which members are real, and the guarantee stops being usable without a lookup.

### `LC-SO-xgmii_rx_64-ADL-48`

A mechanical check earns its value from being uncontestable; do not add a quality condition to it.

**Provenance.** `f3f5210` · `-0018`

**Breaks without it.** Passing starts to look like a quality verdict, and the check is cited as evidence of the thing it never measured.

### `LC-SO-xgmii_rx_64-ADL-49`

Declare both edges of a signal you declare to be noise: never a verdict, and never a clearance.

**Provenance.** `f3f5210` · `-0018`; `3526e79` · `-0032`

**Breaks without it.** A one-edged declaration becomes a clearance the first time somebody needs one.

### `LC-SO-xgmii_rx_64-ADL-50`

Name, in the document that creates a gate, the way the gate can be satisfied without doing the thing.

**Provenance.** `f3f5210` · `-0018`

**Breaks without it.** The first use of the loophole is indistinguishable from compliance, because nobody wrote down what compliance is not.

### `LC-SO-xgmii_rx_64-ADL-51`

The document defining who may change what is never changed by the party citing its own authorisation: the proposer writes the exact text, a different party applies it.

**Provenance.** `8d83371` · `-0019`; reused `ec5d906` · `-0028`, `8734c10` · `-0029`, `3526e79` · `-0032`

**Breaks without it.** Any party able to author an authorisation can grant itself the change, and the separation the document exists to create is gone.

### `LC-SO-xgmii_rx_64-ADL-52`

Read the enforcement mechanism before proposing a design it must pass.

**Provenance.** `8d83371` · `-0019`

**Breaks without it.** A proposal the mechanism cannot implement consumes a review round and returns; the design that survives was never checked against the thing that judges it.

### `LC-SO-xgmii_rx_64-ADL-53`

Prefer a mechanism needing no exemption mode over one guarded by a mode.

**Provenance.** `8d83371` · `-0019`

**Breaks without it.** A mode that suspends a check is a mode that can be entered, and the guarantee is only as strong as the discipline around the flag.

### `LC-SO-xgmii_rx_64-ADL-54`

State which of your supporting arguments does not hold, and delete it from the case.

**Provenance.** `8d83371` · `-0019`

**Breaks without it.** A case padded with a plausible-but-false argument is re-checked as a whole and discredited as a whole.

### `LC-SO-xgmii_rx_64-ADL-55`

Record an outcome beside the prediction it tests, leaving the prediction unedited; retire a falsified prediction in the open.

**Provenance.** `acc8145` · `-0020`; `1f3c04c` · `-0025`; `d54c931` · `-0026`

**Breaks without it.** A document that edits its predictions into accuracy destroys the only evidence that it predicted anything.

### `LC-SO-xgmii_rx_64-ADL-56`

A summary of a bounded claim is where the bound gets dropped; the section a reader quotes must carry the bound, not only the section that derived it.

**Provenance.** `8d83371` · `-0019` (the overclaim), `acc8145` · `-0020` (the repair)

**Breaks without it.** The careful statement stays true and unread while the convenient one is cited, and a tool's green result is read as certifying what it does not.

### `LC-SO-xgmii_rx_64-ADL-57`

File a new case against an existing item only after reading that item's own instances.

**Provenance.** `1004384` · `-0021`

**Breaks without it.** Shared vocabulary merges defects with different causes, and the merged item is later closed on evidence from one of them.

### `LC-SO-xgmii_rx_64-ADL-58`

Rule at the narrowest scope that decides the case.

**Provenance.** `1004384` · `-0021`; `d54c931` · `-0026`; `b6ef1cb` · `-0031`

**Breaks without it.** A wider ruling is the same words on a much larger surface to be wrong on, and it drags in approvals the narrow ruling did not need.

### `LC-SO-xgmii_rx_64-ADL-59`

When an append-only record is split for size, the split carries forward whatever was cumulative; integrity checks on bytes and identifiers prove nothing was rewritten or dropped and say nothing about what stopped being read. Any interval over that record is stated in the record's own identifiers, never in storage units.

**Provenance.** `a378612` · `-0022` (found by executing my own ADR); `a12ac8f` · `-0030` (where I then committed the error)

**Breaks without it.** The cumulative part is silently truncated at the boundary — nothing rewritten, nothing dropped, and nobody reads it again; and an interval opened at a storage boundary looks well-formed while skipping everything before it.

### `LC-SO-xgmii_rx_64-ADL-60`

Quote the arithmetic of a threshold you authored accurately, even when the inflated figure would support the same action.

**Provenance.** `a378612` · `-0022`

**Breaks without it.** A gate's credibility is the accuracy with which the parties it governs quote it, and its author is the cheapest place to corrode it.

### `LC-SO-xgmii_rx_64-ADL-61`

An identifier minted per round by several parties independently carries the minting party inside the id.

**Provenance.** this entry; ADR-0018 §4.3 at `ec5d906`; dv's parallel allocation in `SO-xgmii_rx_64` §4.1

**Breaks without it.** The sequences collide at collation; the collator must renumber, which either breaks every citation already written or silently re-points them.

### `LC-SO-xgmii_rx_64-ADL-62`

Restate a routed question in the terms the governing text uses before answering it.

**Provenance.** `0caf023` · `-0023`

**Breaks without it.** A question posed in the wrong terms is answered correctly and is still wrong, and the wrongness is invisible because the answer matches the question.

### `LC-SO-xgmii_rx_64-ADL-63`

A general rule must not be defined as whatever its instances declare.

**Provenance.** `0caf023` · `-0023`; `a12ac8f` · `-0030`

**Breaks without it.** A check derived from the thing it checks passes by construction, and the class of defect it existed to catch becomes undetectable.

### `LC-SO-xgmii_rx_64-ADL-64`

A question deferred because the answer does not matter is re-tested on every recurrence.

**Provenance.** `0caf023` · `-0023`

**Breaks without it.** By the second recurrence some later ruling has usually assumed one of the answers, and the deferral is protecting a dependency nobody declared.

### `LC-SO-xgmii_rx_64-ADL-65`

When a rule is retired as unachievable, state its successor in the same change.

**Provenance.** `a77017c` · `-0024`

**Breaks without it.** Retiring without replacing moves the derivation to every reader, and it was the derivation that was wrong.

### `LC-SO-xgmii_rx_64-ADL-66`

State a ruling's falsifiable consequence in the open when you issue it.

**Provenance.** `a77017c` · `-0024`; `1f3c04c` · `-0025`

**Breaks without it.** A ruling with no scoreable consequence cannot be reviewed, and its errors surface as somebody else's defect.

### `LC-SO-xgmii_rx_64-ADL-67`

A rule about when a component may act is stated over information the component holds at that moment.

**Provenance.** `1f3c04c` · `-0025`

**Breaks without it.** A rule keyed to a fact learned later is not implementable; it is discovered by an implementer rather than a reviewer, after it has been countersigned.

### `LC-SO-xgmii_rx_64-ADL-68`

Distinguish options you may choose from options you may only escalate, and say which each is.

**Provenance.** `1f3c04c` · `-0025`

**Breaks without it.** Presenting an escalation-class option as a design alternative lets a decision needing an authority get made in-role.

### `LC-SO-xgmii_rx_64-ADL-69`

A measurement agreeing with a prediction is evidence only if the mechanism producing it is the mechanism the prediction is about.

**Provenance.** `1f3c04c` · `-0025`; `a12ac8f` · `-0030`

**Breaks without it.** A defective implementation and a defective rule agree, and the agreement is recorded as the first confirmation of both.

### `LC-SO-xgmii_rx_64-ADL-70`

A specification states the observable and not the mechanism, even when the round was opened by an implementation problem.

**Provenance.** `1f3c04c` · `-0025`

**Breaks without it.** Naming the mechanism converts a repair into a design constraint nobody argued for, and the constraint outlives the problem.

### `LC-SO-xgmii_rx_64-ADL-71`

A finding's numbers and its offered repair are separate objects: adopt the numbers, re-derive the wording.

**Provenance.** `d54c931` · `-0026`; `a12ac8f` · `-0030`; `ce5674d` · `-0033`

**Breaks without it.** A repair offered alongside a correct finding is frequently the same error one case over, and adopting it re-imports the defect at the cases the finding did not check.

### `LC-SO-xgmii_rx_64-ADL-72`

A repair landing exactly the values a reviewer derived and published needs no further approval from that reviewer — and the properties that make it so are stated, not assumed.

**Provenance.** `d54c931` · `-0026`

**Breaks without it.** Without the stated properties the standing is a bare claim, and every unsigned repair is permanently contestable.

### `LC-SO-xgmii_rx_64-ADL-73`

Before writing a measured figure into binding text, ask whether it is a property of the specified thing or of the implementation that produced it.

**Provenance.** `8725c81` · `-0027`

**Breaks without it.** A figure from one implementation, written normatively, silently specifies that implementation and retracts a freedom the document granted.

### `LC-SO-xgmii_rx_64-ADL-74`

Make a recurring obligation's skipping visible by requiring each instance to state its coverage as an interval over a monotonic identifier.

**Provenance.** `ec5d906` · `-0028` — **and the finding that produced this dispatch is its first confirmation**

**Breaks without it.** Without tiling, a skipped instance is an absence nobody can see, and the practice is believed to be running when it is not.

### `LC-SO-xgmii_rx_64-ADL-75`

Give a judgement criterion one mechanical test runnable without interpretation, and one test aimed at the attack that mechanical test invites.

**Provenance.** `ec5d906` · `-0028`

**Breaks without it.** With only the first, the criterion is gamed by substitution; with only the second, it cannot be adjudicated at a table.

### `LC-SO-xgmii_rx_64-ADL-76`

Add a new obligation as a new artefact, never as a box in a completed record.

**Provenance.** `ec5d906` · `-0028`

**Breaks without it.** Added to a closed record it either falsifies the completion or records compliance that never happened.

### `LC-SO-xgmii_rx_64-ADL-77`

Make the cheaper category reachable only through an attempt at the stricter one.

**Provenance.** `8734c10` · `-0029`

**Breaks without it.** A discount available on request is the one every tired party takes first, and the stricter category empties without anyone deciding to empty it.

### `LC-SO-xgmii_rx_64-ADL-78`

An amendment that relaxes a bar states the measurement that says what the relaxation bought.

**Provenance.** `8734c10` · `-0029`

**Breaks without it.** Unmeasured, a relaxation cannot be distinguished from a softening, and the next amendment argues from the same absence.

### `LC-SO-xgmii_rx_64-ADL-79`

Record a deferred decision's shape together with an explicit statement that none of it is in force.

**Provenance.** `8734c10` · `-0029`

**Breaks without it.** A shapeless deferral is re-derived badly by the next reader; an unmarked shape becomes policy by being read twice.

### `LC-SO-xgmii_rx_64-ADL-80`

Where two encodings of one distinction are equally expressive, choose the one owing no edits to documents you do not control.

**Provenance.** `8734c10` · `-0029`; `8d83371` · `-0019`

**Breaks without it.** The other mints obligations on parties who did not ask for them, and the change lands half-applied.

### `LC-SO-xgmii_rx_64-ADL-81`

A permissive bound states, in its own text, that satisfying it is not conformance.

**Provenance.** `a12ac8f` · `-0030`

**Breaks without it.** Stated in one direction only, it is read as a licence by exactly the reader who satisfies it.

### `LC-SO-xgmii_rx_64-ADL-82`

Before narrowing a general rule to defer to a specific one, check the members that have no specific rule.

**Provenance.** `a12ac8f` · `-0030`

**Breaks without it.** The carve-out removes the only constraint wherever no instance states one, manufacturing a clause with no referent.

### `LC-SO-xgmii_rx_64-ADL-83`

When two rules appear to conflict, check they are about the same object before reconciling them.

**Provenance.** `a12ac8f` · `-0030`; `b6ef1cb` · `-0031`

**Breaks without it.** A manufactured reconciliation makes the document say something neither rule said, and both originals lose their force.

### `LC-SO-xgmii_rx_64-ADL-84`

Remove each of a finding's supporting grounds in turn and check whether it still holds.

**Provenance.** `b6ef1cb` · `-0031`

**Breaks without it.** A finding resting on a clause under dispute reads as a bootstrap and is refused on that ground alone, however sound its substance.

### `LC-SO-xgmii_rx_64-ADL-85`

Never pay for a documentation or verification convenience with a constraint on the thing being built.

**Provenance.** `b6ef1cb` · `-0031`

**Breaks without it.** The cost lands on a party that did not ask for it and outlives the convenience that bought it.

### `LC-SO-xgmii_rx_64-ADL-86`

When you claim a change needs no approval, state in the record what happens if the other party disagrees, and make that a fresh objection rather than a retroactive condition.

**Provenance.** `b6ef1cb` · `-0031`; `3526e79` · `-0032`; `ce5674d` · `-0033`

**Breaks without it.** Otherwise every unsigned change is permanently contestable and its in-force status is unknowable.

### `LC-SO-xgmii_rx_64-ADL-87`

Validate a reading of an external artefact against a path in the same artefact whose correctness is independently known.

**Provenance.** `3526e79` · `-0032`

**Breaks without it.** A reading that merely explains the observed behaviour is not distinguished from its alternatives, and a rule is then written on the wrong one.

### `LC-SO-xgmii_rx_64-ADL-88`

Where a record's structure is carried by an in-band delimiter, re-run the structural check after every edit.

**Provenance.** `3526e79` · `-0032`; `b6ef1cb` · `-0031`; `ce5674d` · `-0033`

**Breaks without it.** A value containing the delimiter silently reshapes the record while the text still reads correctly.

### `LC-SO-xgmii_rx_64-ADL-89`

When a written procedure has never been followed, ask whether it is executable in the environment before treating the deviation as a lapse.

**Provenance.** `3526e79` · `-0032`

**Breaks without it.** A procedure that cannot be executed has already been substituted; it is the substitution that needs authorising, not the deviation that needs punishing.

### `LC-SO-xgmii_rx_64-ADL-90`

Correct a finding's factual recital when carrying it into a durable record, and say in the same breath that the substance is untouched.

**Provenance.** `3526e79` · `-0032`

**Breaks without it.** An uncorrected recital propagates; a correction without that sentence reads as a rebuttal and the finding is re-litigated.

### `LC-SO-xgmii_rx_64-ADL-91`

State a prohibition over the situation it excludes, not over the mechanism you believe produces it.

**Provenance.** `ce5674d` · `-0033`

**Breaks without it.** A rule written on a mechanism falls with the mechanism, so a falsified reason falsifies a ruling that was substantively right.

### `LC-SO-xgmii_rx_64-ADL-92`

Order an append-only record by a monotonic identifier the writer controls, never by a wall-clock stamp the environment supplies.

**Provenance.** `ce5674d` · `-0033`

**Breaks without it.** A clock that drifts backwards makes the record appear reordered and its ordering unusable as evidence.

### `LC-SO-xgmii_rx_64-ADL-93`

A carried-forward list that only grows is not a tracking instrument: each item names the party who can close it and the event that closes it, and each round reports closures.

**Provenance.** `1fe71ca` · `-0013` through `ce5674d` · `-0033` — the ledger grew from eight items to twenty and closed three

**Breaks without it.** The list becomes a ritual restatement readers skip, and a blocking item becomes indistinguishable from a note.

### `LC-SO-xgmii_rx_64-ADL-94`

Where a directory is inside several parties' write scope, enumerate a commit's file set explicitly and never take it from a wildcard: scope permits, it does not attribute.

**Provenance.** `a378612` · `-0022`; `a12ac8f` · `-0030`; `b6ef1cb` · `-0031`; `3526e79` · `-0032`; `ce5674d` · `-0033`

**Breaks without it.** A concurrent party's unfinished work is committed under the wrong identity, destroying its attribution and failing the files-list check.


## rtl_lead — 50 candidates

**Note**: `J-rtl_lead-0013` · **span**: J-rtl_lead-0001 … -0012 · [source at `c55c754`](https://github.com/renatom11/agentic-fpga/blob/c55c754/agents/journals/claude_rtl_lead_agent.md)

> "All fifty are grade **LH2-g**, domain pack —." (the notes single declaration). LH1 carries the notes own (F)/(C) visibility grade, defined and defended in its §2; measured split 40 F / 10 C, matching the notes stated split.

### `LC-rtl_lead-H1-1`

Where a task instruction and the frozen source it derives from disagree about a deliverable, the source governs and the disagreement is returned as a question — an instruction is a summary of the source, and a summary that has gone stale is not an authority.

**Provenance.** (F) `189d5b2` / `-0001`

**Breaks without it.** The executor resolves toward whichever is convenient, the divergence is visible nowhere, and a check written against the source fails later at a point where its cause is no longer local.

### `LC-rtl_lead-H1-2`

Where an author is barred from testing their own work, prefer the formulation a reviewer can check against the requirement **by reading** over the one that is smaller or faster but whose correctness lives in a derivation only the author performed.

**Provenance.** (F) `189d5b2` decision, failure at `1434f27` / `-0001`, `-0006`

**Breaks without it.** The private derivation's error is invisible to review and to the author's own inspection, and surfaces only at the independent oracle — after every later decision has been built on it.

### `LC-rtl_lead-H1-3`

When the role that normally reviews a class of work performs that work itself, the record names the review that consequently did not happen and the controls standing in its place.

**Provenance.** (C) `f840475` / `-0002`

**Breaks without it.** A later gate counts the self-review as an independent one, and the coverage claim is inflated by exactly the reviews that never occurred.

### `LC-rtl_lead-H1-4`

A review's finding count is evidence that the review **ran**, never evidence of what it **covered**; state what was checked and what was not, because a review that reports defects reads as thorough whether or not it was.

**Provenance.** (F) `f840475` (four found and reported) against `0b64b68`, `ce00c06`, `b848d56` (three later criticals in the same artefact) / `-0002`, `-0007`, `-0009`, `-0011`

**Breaks without it.** Findings are read as coverage; the untouched region is invisible precisely because the touched region reported well.

### `LC-rtl_lead-H1-5`

Where a stage cannot refuse its input, prefer a structure whose delay is a constant of the design over one whose delay is a function of occupancy — an occupancy-dependent delay turns every pinned timing figure into a function of input history.

**Provenance.** (F) `f840475` (rejected), arrived at `fafb83d`, cost at `b848d56` / `-0002`, `-0010`, `-0011`

**Breaks without it.** Elasticity enters later under a ruling, and the pinned figures it was keeping constant become stimulus-dependent — which is discovered as a defect in the elastic stage rather than as the price of elasticity.

### `LC-rtl_lead-H1-6`

A capacity or depth bound records the premise about the input that it was derived from, at the bound.

**Provenance.** (F) `f840475` premise, falsified at `d57e028` / `-0002`, `-0005`

**Breaks without it.** The bound survives the change that invalidates its premise, because nothing tells the changing party that the bound depended on them.

### `LC-rtl_lead-H1-7`

Before returning "the source is silent" on a question, search the whole source for the fact rather than the section the asker named — the section pointer is the asker's model of the document, not the document.

**Provenance.** (F) `7322c9c` / `-0003`

**Breaks without it.** A fact already fixed elsewhere in the source is invented a second time, and two names now exist for one thing with no rule saying which wins.

### `LC-rtl_lead-H1-8` — **merges to seeded L-D03; the seeded statement survives (A2-D8); this candidate's provenance joins it**

An artefact a build produces is never hand-authored, and never post-processed, to satisfy a check — however small the edit and however correct the artefact already is.

**Provenance.** (C) `7322c9c`, `ad3a042` / `-0003`, `-0004`

**Breaks without it.** The check becomes a test of the post-processing; the false green is permanent, because nothing downstream can distinguish a generated artefact from an edited one.

### `LC-rtl_lead-H1-9`

A prediction about a run states what must **not** move as well as what must; the negative half is the control, and without it every observed change is absorbed by the prediction.

**Provenance.** (F) `7322c9c` predicted, red landed elsewhere at `ad3a042`, negative half clean at `750be49` / `-0003`, `-0004`, `-0008`

**Breaks without it.** Any failure is triaged as "the expected one", and a second genuine defect arriving in the same run is consumed by the prediction that was meant to expose it.

### `LC-rtl_lead-H1-10`

A defect report's stated cause and its proposed repair are the reporter's model of an artefact the reporter usually cannot see; re-derive the mechanism from the artefact before acting on either — and where the model turns on a distinction between two cases, an artefact already committed usually decides it.

**Provenance.** (F) `ad3a042`, `d57e028` / `-0004`, `-0005`

**Breaks without it.** The repair is chosen against a distinction that does not exist; it does not fix the failure, and it spends the expensive round that would have found the real mechanism.

### `LC-rtl_lead-H1-11`

When a hypothesis is refuted, look for a second refutation that does not share the first's assumptions, and record both.

**Provenance.** (C) `ad3a042` / `-0004`

**Breaks without it.** The single supporting artefact is later found unrepresentative and the whole verdict falls with it, with no independent line of argument left standing.

### `LC-rtl_lead-H1-12`

A party may not edit the check that grades its own output, **even when it is right that the check is wrong**; it states the defect and the repair as a position and routes them to the check's owner.

**Provenance.** (F) `ad3a042` / `-0004`

**Breaks without it.** The record cannot distinguish a correct widening from a self-serving one, so every later reader must re-derive the merits from scratch — and the separation the check existed to enforce is gone whether or not the edit was right.

### `LC-rtl_lead-H1-13`

Where a pipeline judges an artefact before the step that publishes it, a failure suppresses its own evidence; publish first and judge second, or the first real failure is undiagnosable.

**Provenance.** (F) `ad3a042` / `-0004`

**Breaks without it.** The artefact cannot be published because the check fails on it, and the check cannot be diagnosed because the artefact was never published — a deadlock that becomes permanent the moment anyone works around it once.

### `LC-rtl_lead-H1-14`

A check written against the only artefact that existed encodes that artefact's incidental shape as a rule; when the first real subject arrives, the first failure is more likely the check's calibration than the subject's defect — and the check's own comment usually names the qualifiers that were calibrated.

**Provenance.** (F) `ad3a042` / `-0004`

**Breaks without it.** The first genuine subject is convicted by a rule that was only ever a description of the bootstrap, and the repair is applied to the subject.

### `LC-rtl_lead-H1-15`

An ambiguity resolved in the implementer's favour and declared is not thereby licensed: when it is later ruled the other way, the artefact was non-conformant from the moment it shipped — the round that prices the ruling is a defect discovery, not a change request.

**Provenance.** (F) `d57e028` / `-0005`

**Breaks without it.** The work is scheduled and costed as an optional change when it is an owed repair, and every check that passed over the interval is quietly reclassified from "green" to "blind".

### `LC-rtl_lead-H1-16`

When a defect is traced to a clause of the source, run the **whole** clause over the artefact; a clause with several cases is repaired in all of them, or the repair is a new and narrower deviation from the same sentence.

**Provenance.** (F) `d57e028` / `-0005`

**Breaks without it.** One case is fixed, its siblings under the same sentence stay broken, and the closed report now says the sentence is satisfied.

### `LC-rtl_lead-H1-17`

Leaving behaviour unchanged while escalating the question about it is a decision that ships, and it needs the same argument a change would need. Escalating and shipping the old behaviour meanwhile are two acts; only the first is usually recorded.

**Provenance.** (F) `d57e028` shipped, convicted at `1434f27` / `-0005`, `-0006`

**Breaks without it.** The escalation is on the record and reads as diligence, while the unargued half is what the artefact actually does until the ruling lands — and it can be wrong for the whole interval.

### `LC-rtl_lead-H1-18`

A justification written at a site is an assertion with a lifetime. When the premise it rests on moves, the justification becomes a defect: a change that repairs the behaviour and leaves its now-false reasoning standing has shipped a second one, and it is the one the next reader will trust.

**Provenance.** (F) `f840475`→`d57e028`; `1434f27`; `fafb83d`→`b848d56` / `-0005`, `-0006`, `-0011`

**Breaks without it.** The stale reason survives every later review because it reads as the design's own argument, and the next author extends the design along it.

### `LC-rtl_lead-H1-19`

When a computed value is ruled out of scope, remove the computation rather than gate its report; a correctly-scoped report over a still-computed value leaves the value available one hop away with its scope now detached from it.

**Provenance.** (C) `1434f27` / `-0006`

**Breaks without it.** The next consumer picks the value up without the scope that made it meaningful, and the scope is nowhere near the value to warn them.

### `LC-rtl_lead-H1-20`

Where two encodings of "this cannot happen" are equivalent after optimisation, choose the absent one over the constantly-false one: the absent form states the impossibility to the next reader, the constant form states only today's value.

**Provenance.** (C) `1434f27` / `-0006`

**Breaks without it.** A later change makes the constant non-constant, and no reader was ever told the case was supposed to be unreachable.

### `LC-rtl_lead-H1-21`

A justification that argues from a value the implementation happens to produce, rather than from the operands the requirement names, is a defect wearing a comment — a valid inference from a false premise reads exactly like a correct one.

**Provenance.** (F) `1434f27` / `-0006`

**Breaks without it.** The false premise is preserved in the artefact **as an argument**, which protects it from every later reader including its author.

### `LC-rtl_lead-H1-22`

Where a specification declares a class of inputs value-independent, an implementation whose observable varies with the values in that class is defective at **every** member — including the members where the value happens to give the right answer. Such a class is discharged by argument over the class, never by sampling it.

**Provenance.** (F) `1434f27` / `-0006`

**Breaks without it.** The sampled member passes by arithmetic accident and the accident is recorded as coverage; the class is then believed checked.

### `LC-rtl_lead-H1-23`

The members a hand-check is run on — whether inherited from the source's worked example or chosen by the author — are systematically the ones the mechanism already explains. Choose members at the boundary of the rule, and name the branches the chosen members do not reach.

**Provenance.** (F) `1434f27`, `0b64b68` / `-0006`, `-0007`

**Breaks without it.** The check is anchored on the cases that cannot discriminate and reports clean, and the clean report is what the next stage relies on.

### `LC-rtl_lead-H1-24`

Before repairing a reported observable, enumerate every site that produces it. A repair applied at one of several producers is worse than no repair, because the remaining producers now fail in a condition the closed report says was fixed.

**Provenance.** (F) `1434f27` / `-0006`

**Breaks without it.** The bug is closed, the siblings stay open, and their next appearance is triaged against a report that says this cannot be it.

### `LC-rtl_lead-H1-25`

Evidence produced by running something that is not in the committed tree is labelled with that fact at the point it is cited. A command that cannot be re-executed at the commit is a report, not evidence, and only the label distinguishes them.

**Provenance.** (F) `1434f27` / `-0006`

**Breaks without it.** A citation that cannot reproduce is inherited as one that can, and the first party to try it concludes the artefact changed rather than that the evidence was never portable.

### `LC-rtl_lead-H1-26`

Where several writers share one working tree, a claim of confinement is made over the paths the claimant owns — never over the tree being otherwise quiet. A whole-tree cleanliness claim is false the moment a concurrent writer exists, and it is the claim most likely to be copied forward unchecked.

**Provenance.** (F) `1434f27` / `-0006`

**Breaks without it.** A blanket stage sweeps another party's work into this one's unit, and the attribution the whole record rests on is wrong in a way no later reader can unpick.

### `LC-rtl_lead-H1-27`

A guard that is correct in isolation can be defeated by the **lifetime** of the state it reads; when a guard fails, establish when its input is valid relative to when the guard is evaluated, before changing the guard's condition.

**Provenance.** (F) `0b64b68` / `-0007`

**Breaks without it.** The condition is rewritten to cover a case it already covered, the real cause — an earlier consumer clearing the state — survives, and the widened guard now misfires elsewhere.

### `LC-rtl_lead-H1-28`

A specification's own worked example is not a test of an implementation: it is the case its author found easiest to write out, and it is systematically the case in which the implementation's branches do **not** separate.

**Provenance.** (F) `0b64b68` / `-0007`

**Breaks without it.** Self-review anchors on the one directed case the source supplies, finds it correct, and reports clean over every branch the example never enters.

### `LC-rtl_lead-H1-29`

A repair also states, at the site, the fact the design's own narrative had no vocabulary for — because that vocabulary is what determines which review questions get asked, and a defect the narrative cannot express is invisible to review by construction.

**Provenance.** (F) `0b64b68`, `fafb83d` / `-0007`, `-0010`

**Breaks without it.** The code is fixed and the reasoning that produced the defect is left intact, so the next consumer of the same relation reproduces it with no reason to look.

### `LC-rtl_lead-H1-30`

When a measurement disagrees with the artefact on one entry out of many and agrees on the rest, suspect the instrument's observation point before the artefact; the discriminator is whether the disagreeing entries share a **timing** relation rather than a value relation.

**Provenance.** (F) `0b64b68` / `-0007`

**Breaks without it.** A correct artefact is changed to satisfy an instrument's sampling artefact, which corrupts the design and hides the instrument defect behind the repair.

### `LC-rtl_lead-H1-31`

A prediction published before a run earns its keep by naming the observation that would refute it **and what that observation would convict**; a prediction that says only what should happen cannot fail informatively.

**Provenance.** (F) `0b64b68` / `-0007`

**Breaks without it.** The run comes back ambiguous and the party who wrote the prediction gets to choose, after the fact, which of their claims it tested.

### `LC-rtl_lead-H1-32`

Reviewing a generated artefact by line diff measures the generator's naming scheme, not the change. Compare a representation invariant under the generator's incidental choices, and state the normalisation — a reviewer without it will either wave through a large real change or challenge a small one.

**Provenance.** (F) `750be49`, `42b9df3` / `-0008`, `-0012`

**Breaks without it.** Thousands of changed lines for a handful of real ones is read as either "all mine" or "something is wrong", and both readings are guesses dressed as review.

### `LC-rtl_lead-H1-33`

A landing that publishes an artefact a later process must reproduce states that reproduction as its **own** success criterion, and names itself as the thing to revert if it fails.

**Provenance.** (C) `750be49` / `-0008`

**Breaks without it.** A non-reproducing artefact is triaged as a defect of whatever produced the mismatch, rather than of the landing that put an unreproducible object in the record.

### `LC-rtl_lead-H1-34`

Where an event is available, do not infer it from the absence of data. An absence coincides with the event only while the input is dense, and that coincidence is exactly what carries the substitution through every review.

**Provenance.** (F) `ce00c06` / `-0009`

**Breaks without it.** A gap in the input makes the absence momentarily true, and the consumer acts on an event that did not occur — while the state machine that owns the real event never moves, so nothing else reports it.

### `LC-rtl_lead-H1-35`

Where two conditions coincide on every input a system has been exercised with, name which of them each decision is keyed on and the input property that separates them; the separating input is the whole of the untested space.

**Provenance.** (F) `ce00c06`, `fafb83d`, `b848d56` / `-0009`, `-0010`, `-0011`

**Breaks without it.** Three different decisions key on three different halves of the same coincidence, and each is discovered separately, as its own critical defect, by the first input that separates them.

### `LC-rtl_lead-H1-36`

Designing one side of a rule deliberately does not carry to the other side. Where a rule constrains both an input decision and an output decision, each is written against the rule separately — the second is the one that inherits its correctness by assumption.

**Provenance.** (F) `ce00c06` / `-0009`

**Breaks without it.** The deliberate half is cited as evidence the feature was designed, and the assumed half is where the defect is.

### `LC-rtl_lead-H1-37`

A repair that reasons carefully about a quantity in one branch lends that quantity unearned authority in every other branch that reads it; after a repair, re-examine the quantity's other consumers.

**Provenance.** (F) `ce00c06` / `-0009`

**Breaks without it.** A later reviewer sees a quantity that a recent careful argument relied on and treats its other uses as load-bearing rather than accidental — so the repair hardens the defect next door.

### `LC-rtl_lead-H1-38`

A timing rule stated per output event is checked for consistency across stimuli that share a prefix. Where two stimuli identical through a point pin contradictory behaviour at or before it, the rule is unsatisfiable by any causal implementation, and the finding belongs to the rule and not to the implementation.

**Provenance.** (F) `ce00c06` / `-0009`

**Breaks without it.** The implementation is repaired again and again against a requirement no implementation can meet, and each round is scored as another failure of the implementer.

### `LC-rtl_lead-H1-39`

When fixing a defect exposes a defect in the instrument or the rule that convicted you, fix the first without contesting it and report the second separately, with its proof; bundling the two makes the report read as a defence of the artefact and it will be discounted as one.

**Provenance.** (C) `ce00c06` / `-0009`

**Breaks without it.** The genuine finding is filed with the excuse and dies with it, and the unsatisfiable rule stays in force.

### `LC-rtl_lead-H1-40`

An instruction that characterises part of an artefact as already correct is a prediction, not a fact — its author has not run the change. Verify it at the level the change will exercise.

**Provenance.** (F) `fafb83d` / `-0010`

**Breaks without it.** The unverified region is the one the change moves, and the resulting defect is attributed to the change rather than to the assumption that region was fine.

### `LC-rtl_lead-H1-41`

Where two conditions agree on every case the current tests reach, implement the one the source **names**, not the one that is simpler: the cases in which they differ are exactly the cases the clause was written to pin, and their agreement is evidence about the test set, not about the conditions.

**Provenance.** (F) `fafb83d` / `-0010`

**Breaks without it.** The simpler condition ships as a silent deviation and is correct on everything anyone runs, until the configuration the clause existed for is exercised.

### `LC-rtl_lead-H1-42`

A round instructed to stop and report if a named cost is incurred says explicitly that it was not incurred; silence on a watched condition reads as "not reached" to an optimistic reader and "not checked" to a pessimistic one, and both are guesses.

**Provenance.** (C) `fafb83d` / `-0010`

**Breaks without it.** The watched condition's status is unknown at exactly the point a later decision assumes it.

### `LC-rtl_lead-H1-43`

A guard on the **number** of items produced cannot see a defect that substitutes one item for another. Where a defect class conserves the quantity a guard counts, that guard's green is evidence about the conservation; state, per guard, which quantity it cannot see.

**Provenance.** (F) `b848d56` / `-0011`

**Breaks without it.** The count is right, the terminal marker sits in the right place, and every octet in between is wrong — with a green guard standing over it.

### `LC-rtl_lead-H1-44`

A disjunction offered as exhaustive by a party who cannot see the artefact is a hypothesis about its structure; check for a third case in which the observable is conserved by two errors that cancel. The refusal may be right and its ground wrong, and only the ground transfers to the next round.

**Provenance.** (F) `b848d56` / `-0011`

**Breaks without it.** The correct conclusion is banked together with the incorrect reasoning that reached it, and the next round reuses the reasoning.

### `LC-rtl_lead-H1-45`

Grade a published prediction clause by clause. A prediction right about the mechanism and wrong about the consequence is a different lesson from one wrong about the mechanism, and a whole-prediction verdict loses which.

**Provenance.** (F) `b848d56` / `-0011`

**Breaks without it.** "The prediction was wrong" retires a mechanism that was correct and had been derived before any measurement existed.

### `LC-rtl_lead-H1-46`

Where a corruption is introduced by one stage and repaired by a later one, prefer the change that stops it being produced: the downstream repair must hold the corrupted object while it repairs it, and that storage is the cost the upstream fix does not pay.

**Provenance.** (C) `b848d56` / `-0011`

**Breaks without it.** The repair breaks a resource bound that the corruption itself never threatened, and the bound's breach is discovered as a separate escalation.

### `LC-rtl_lead-H1-47`

Prefer a change whose non-effect on the untouched configuration is a **textual identity** over one whose non-effect requires a case analysis; the first is checkable by a reader who does not follow the analysis, and it is the claim a regression will be graded against.

**Provenance.** (C) `b848d56` / `-0011`

**Breaks without it.** The no-regression claim rests on an argument that must itself be right, and when a regression appears there is no cheap way to tell whether the change or the argument was wrong.

### `LC-rtl_lead-H1-48`

When a change may legitimately move a result the changing party is not permitted to inspect, publish **before the run** the discriminator that separates "the change was wrong" from "the old expectation encoded the defect"; afterwards the two are indistinguishable, and the party who can see the result has no basis to choose.

**Provenance.** (F) `b848d56` / `-0011`

**Breaks without it.** A moved expectation is settled by whoever speaks first, and a separation of duties that was meant to strengthen the verdict makes it arbitrary instead.

### `LC-rtl_lead-H1-49`

Where a correctness argument rests on the order in which a generator composed two changes, check the generated artefact and not the source: the source states the intent, the artefact states the composition, and only the second can be wrong in a way the author cannot see.

**Provenance.** (F) `42b9df3` / `-0012`

**Breaks without it.** Two changes that fight produce something that reads correct at the source and is wrong at the artefact, with no reader ever comparing the two.

### `LC-rtl_lead-H1-50`

An obligation a round cannot discharge is restated in that round's own record, with the reason it could not be discharged, at every round until it closes — an obligation mentioned once and then dropped is indistinguishable from one that was met.

**Provenance.** (F) `7322c9c` … `42b9df3`, ten consecutive rounds / `-0003` … `-0012`

**Breaks without it.** The obligation ages out of everyone's context while the record still says it was raised, and it is rediscovered by whoever is harmed by its absence.


## auditor — 54 candidates

**Note**: `J-auditor-0019` · **span**: J-auditor-0001 … -0018 · [source at `185ae66`](https://github.com/renatom11/agentic-fpga/blob/185ae66/agents/journals/claude_auditor_agent.v02.md)

> "Every grade below is `LH2-g`" (the notes blanket declaration); ids minted `LC-SO-xgmii_rx_64-AUD-<n>`, abridged `-AUD-<n>` in the bank; entry attribution lives in the notes group headers. Classifier: "Step 0 was attempted for all 64; all 54 survivors passed step 1 with no proper noun, so none reached step 2 and no pack is named." 64 bankings reconciled to 54 distinct via the notes own merges table.

### `LC-SO-xgmii_rx_64-AUD-1`

*A test that asserts only that an operation was refused does not establish that it was refused for the reason the test names. Assert the reason, or the count of passing cases is not a coverage measurement.*

**Provenance.** `bd7fbcf` — the instrumented suite showed three scenarios satisfied by the wrong rule while the suite reported them green; second incident `8d48084`, where the repaired suite reconstructed to 23+3 failing exactly those three.

**Breaks without it.** without it a rule is wholly unenforced while its scenario passes, and the passing count is reported as coverage it does not have.

### `LC-SO-xgmii_rx_64-AUD-2`

*An instrument never exercised against a case it must reject reports only that it ran. Exercise every check against a deliberate failure before counting its passes.*

**Provenance.** `bd7fbcf` — the negative assertion asserted only a non-zero exit status; the practice minted from it recurs at `0556f23`, `2622f90` (four broken variants), `4ef6628` (five) and `f9232c2`, where the parse check is *"a check that can fail rather than a label"*.

**Breaks without it.** without it a green result is indistinguishable from an unwired check, and the first gating run proves nothing.

### `LC-SO-xgmii_rx_64-AUD-3`

*A task assignment cannot enlarge the permissions its issuer's constitution grants. Where an instruction requires an act outside them, the instruction is unexecutable and the conflict is the finding, not a licence.*

**Provenance.** `bd7fbcf` — an instruction executable in neither branch, filed as the round's CRITICAL; and `480c38a`, where a named deliverable path outside scope was honoured in substance at a permitted location with the deviation reported.

**Breaks without it.** without it a role's central guarantee is false at the first occasion it is tested, and the enforcement refuses the work anyway.

### `LC-SO-xgmii_rx_64-AUD-4`

*Verify a claim recorded at a past state by extracting that state into a disposable copy; never by moving the live state. Verification that perturbs the thing being worked on races the work.*

**Provenance.** `bd7fbcf` — archive-into-scratch chosen over three tree-moving alternatives, with the other party committing concurrently.

**Breaks without it.** without it the check destroys or captures work in progress and its own result is contaminated by what it disturbed.

### `LC-SO-xgmii_rx_64-AUD-5`

*Where one party authors and another publishes, publication is triggered by the author's completion signal, not by the publisher's schedule. Otherwise a partial artefact is published as a complete one and the publication is unamendable.*

**Provenance.** `de85393` — an intermediate draft published with 28 lines of corrections uncommitted, already distributed, so only a successor record could repair it.

**Breaks without it.** without it a half-written verdict is published as a verdict.

### `LC-SO-xgmii_rx_64-AUD-6`

*A finding that predicts an event cannot keep its lowest severity once that event occurs inside the same investigation. Severity follows the consequence class, not the identity of whoever was inconvenienced.*

**Provenance.** `de85393` — the hazard raised from the lowest severity to MAJOR after it fired and captured the report describing it.

**Breaks without it.** without it a control gap is graded before its own demonstration, and the demonstration is discarded as coincidence.

### `LC-SO-xgmii_rx_64-AUD-7`

*A party that files a defect class against another and then finds the same class in its own work records the correction in the same terms and under the same class. A silent self-correction forfeits the standing to file it.*

**Provenance.** `de85393` — the report's own severity tally was an instance of the defect it had just filed against the other party, and was annotated as one.

**Breaks without it.** without it the register loses its most informative instances and the filer's standing is unverifiable.

### `LC-SO-xgmii_rx_64-AUD-8`

*Claims of delivered work are verified against the artefact's own history, never read. Where a remediation record says "fixed", re-execute; where it says "applied", check what the artefact shows.*

**Provenance.** `8d48084` — three claims of delivered work falsified by path-scoped history, none of which careful reading would have surfaced.

**Breaks without it.** without it a remediation record accumulates claims nobody checked and the gate consuming it is signed on them.

### `LC-SO-xgmii_rx_64-AUD-9`

*Before accepting a rejected alternative's stated reason, check that the alternative was expressible in the mechanism that would have had to enforce it. An option the enforcement cannot express was never an option, and the record's reason for rejecting it is not the real one.*

**Provenance.** `8d48084` — the enforcement matches path prefixes and cannot express the narrow grant, so the decision record's stated rationale was weaker than the facts supported.

**Breaks without it.** without it a decision preserves a weaker reason than the evidence gives, and the next revisit reopens on the weak one.

### `LC-SO-xgmii_rx_64-AUD-10` — **merges to seeded L-E06; the seeded statement survives (A2-D8); this candidate's provenance joins it**

*A rule suspended by the party the rule constrains is a violation even when disclosed, reversed and harmless. Authorisation is prior or absent; disclosure after the fact is neither.*

**Provenance.** `8d48084` — the sole enforcer suspended the no-rewrite rule on its own authority and recorded it only in its own record.

**Breaks without it.** without it the one rule that makes every other rule durable becomes suspendable at the discretion of its only enforcer.

### `LC-SO-xgmii_rx_64-AUD-11`

*State the good reason behind a criticised act at full strength inside the finding. A finding that hides the actor's justification teaches "disclose less", which costs more than the act did.*

**Provenance.** `8d48084` — the countervailing fact (the protection under test guarded nothing) written into the finding at full strength.

**Breaks without it.** without it findings select against disclosure and the next incident is handled silently.

### `LC-SO-xgmii_rx_64-AUD-12`

*Where a stated intent and its only faithful realisation diverge, say so before the experiment runs. A divergence disclosed afterwards cannot be distinguished from a rationalisation of the result.*

**Provenance.** `0556f23` — three such statements, all pre-run; the practice recurs at `fb49b80`, `2622f90` and `8bbc388`.

**Breaks without it.** without it a result is reinterpreted around the divergence after the fact and the experiment measures nothing it can name.

### `LC-SO-xgmii_rx_64-AUD-13`

*A restriction no tool enforces is discharged only by a complete statement of what was **refused** — never by a statement of what was read, and never by a statement of what was permitted.*

**Provenance.** `0556f23`, whose refusal list is the round's enforcement mechanism; and `2622f90`, which records material **inside** its permitted set that was deliberately not opened.

**Breaks without it.** without it the restriction is satisfied literally while the protected material arrives by an unlisted route, and no reader can tell which conclusions rest on it.

### `LC-SO-xgmii_rx_64-AUD-14` — **merges to seeded L-C15; the seeded statement survives (A2-D8); this candidate's provenance joins it**

*A restriction list is a floor. The restricted party extends it to anything that would supply the answer by another route, and records the extension as its own act.*

**Provenance.** `0556f23` — two artefacts nothing barred, refused because each would have described the thing the experiment was blind to.

**Breaks without it.** without it a party satisfies every named bar and still reaches the answer, and the independence is a formality.

### `LC-SO-xgmii_rx_64-AUD-15`

*Generate a change mechanically from an anchored transformation that aborts on a missing or duplicated anchor; never transcribe one. A hand-written context line is an unchecked claim about where the change lands.*

**Provenance.** `0556f23`; `4ef6628`, where the generator *"asserts each anchor occurs exactly once and aborts otherwise, so a silent no-op edit is impossible"*; `f9232c2`, anchor uniqueness measured per class.

**Breaks without it.** without it a change silently applies at zero sites or two and the artefact's own statement of where it applies is unverified.

### `LC-SO-xgmii_rx_64-AUD-16`

*Where a document embeds a copy of an artefact, generate the copy from the artefact, verify it byte-equal, and exercise the extraction. A copy edited by hand is a second artefact with the same name.*

**Provenance.** `0556f23` — embedded copies injected and verified byte-equal; `480c38a` — the published extraction round-tripped, all seven recovered files byte-identical.

**Breaks without it.** without it two versions of one thing circulate and the one that gets used is whichever the reader reached first.

### `LC-SO-xgmii_rx_64-AUD-17`

*Statelessness makes recollection worthless as disclosure. A statement about prior exposure rests on a record committed **before** the thing it discloses about existed — never on memory.*

**Provenance.** `fb49b80` — the prior-exposure section rests on a file with exactly one commit, `0556f23`, therefore never amended with anything learned later.

**Breaks without it.** without it an exposure disclosure is an interested party's self-report, unfalsifiable in either direction, and the restriction it certifies is worth nothing.

### `LC-SO-xgmii_rx_64-AUD-18`

*Where a change must remain buildable, the token that keeps it buildable is written in and disclosed — never omitted to keep the change tidy. A subject that fails for a reason unrelated to what is being tested has its failure charged to the test.*

**Provenance.** `fb49b80` — two forced constants written in a non-obvious form because unused bindings are errors here, with the deviation disclosed as the one place buildability rather than fidelity chose the text; `adac5ca` — the cheapest-looking edit rejected because it would orphan a binding and die at build, where a death scores nothing.

**Breaks without it.** without it the subject dies of an unrelated cause and the round is spent on a repair budget instead of a result.

### `LC-SO-xgmii_rx_64-AUD-19`

*An instruction read to the letter that falsifies its own next sentence has been misread. Implement the reading under which the instruction's stated consequence is true, and record the rejected reading.*

**Provenance.** `fb49b80` — the literal reading makes the intent's own next sentence false, so the timing moved and the floor stayed, with the alternative offered as a separate artefact rather than a revision.

**Breaks without it.** without it a deliberate change contradicts its own specification of what it should be observable as, and no result can be attributed to it.

### `LC-SO-xgmii_rx_64-AUD-20`

*A workspace shared between parties separated by a restriction is a hole in the restriction. Separate the workspaces; do not rely on the restricted party's restraint.*

**Provenance.** `fb49b80` — the shared area's listing exposed other parties' copies of barred material; remedied at `784e5b6` with a private mode-0700 subdirectory and the shared root never listed.

**Breaks without it.** without it the protected material is one command away from the party protected from it, and nothing but that party's restraint stands between them.

### `LC-SO-xgmii_rx_64-AUD-21`

*When a change adds state, its **arming condition** and its **power-on/reset value** are the two choices that decide the change's real scope. State both before the run, and let the value the addition holds at reset be the one that makes it inert — or the change acquires a second defect at a moment it was never aimed at.*

**Provenance.** `784e5b6` — the arming reading chosen narrow, disclosed in advance, with the wider reading named as a one-line alternative; `2fbcf0d` — the natural rendering refuted because the added register reads the *blocking* value on the cycle after reset, the repair being to delay the complement so the non-blocking value is held at time zero.

**Breaks without it.** without it a change meant to be silent under one condition speaks at reset and is convicted at cases it was never about.

### `LC-SO-xgmii_rx_64-AUD-22`

*An allowlist is a stronger restriction instrument than a deny-list: a deny-list must anticipate every route, an allowlist need only enumerate the permitted ones.*

**Provenance.** `2622f90` — the growing deny-list of `0556f23`/`fb49b80`/`784e5b6`, which gained an item per discovered leak, replaced by five permitted path sets with everything else out of bounds by construction.

**Breaks without it.** without it every round's restriction grows by one item per leak already found, and the leak nobody has found yet is permitted.

### `LC-SO-xgmii_rx_64-AUD-23`

*A class with two structurally different halves is delivered for the renderable half, with the other named, argued and **left undone** — never substituted for.*

**Provenance.** `2622f90`, where the in-word half is named and left undone because seeding it means constructing a path that does not exist; `4ef6628`, the same disposition on a different half with the reason it cannot be done without breaking a second rule on the way.

**Breaks without it.** without it partial coverage is scored as full and the untested half is believed covered by the same evidence.

### `LC-SO-xgmii_rx_64-AUD-24`

*Two deliberate changes meant to test different things must not both instantiate the same defect. A site that plants a second class's defect on the way to its own confounds both, and no later measurement separates them.*

**Provenance.** `4ef6628` — the obvious site for one class would have planted another's defect, so the qualifier was moved to the one site where it is expressible in a single term; `762ae49` — a candidate character rejected for exactly that reason, and the generic reading rejected because it contains that case whole.

**Breaks without it.** without it two experiments report one result and neither is attributable.

### `LC-SO-xgmii_rx_64-AUD-25`

*Before charging a failure to a change, establish that the unchanged baseline passes the same check. Where that cannot be established, say so, and do not spend the change's repair budget on it.*

**Provenance.** `4ef6628` — the baseline itself violates the margin its own check enforces, so the check's cleanliness at the base was never established; carried unresolved and restated at `762ae49`, `480c38a`, `c4ffe7a`.

**Breaks without it.** without it a pre-existing failure is attributed to the change, and the change is repaired to conceal a baseline defect.

### `LC-SO-xgmii_rx_64-AUD-26`

*A derivation of where a change bites is checked against an independent evaluation at the **boundary** values before it is relied on. The boundary is where the derivation's assumptions are weakest.*

**Provenance.** `762ae49` — the algebraic reduction checked by hand at three adjacent boundary values at both geometries rather than trusted.

**Breaks without it.** without it a reduction valid in general and wrong at the edge is published as the change's whole reach.

### `LC-SO-xgmii_rx_64-AUD-27`

*A change specified in terms of an artefact the system does not contain must be re-specified as an **observable** before it can be made — and the artefact's absence is itself a fact worth reporting.*

**Provenance.** `762ae49` — the class named a constant that appears nowhere in the design, so the defect was re-expressed as an observable and seeded where that observable is one edit, with both readings recorded.

**Breaks without it.** without it the change is either not made or made at an unrelated site, and the specification's own error stays invisible.

### `LC-SO-xgmii_rx_64-AUD-28`

*Where a canonicaliser will run later and cannot be run now, produce output that is a fixpoint under every setting the canonicaliser might carry.*

**Provenance.** `480c38a` — every added line kept under a width stable at either candidate margin, and intermediate names introduced rather than existing lines extended, precisely because the canonicaliser was absent.

**Breaks without it.** without it the later canonicalisation rewrites the change and the rewrite is indistinguishable from the change itself.

### `LC-SO-xgmii_rx_64-AUD-29`

*A claim that a change produces an effect is discharged by evaluating **every** term of the condition that decides the effect, at the moment the effect is claimed, including terms the change does not feed. Tracing a changed value forward to a decision point shows only that it arrives there.*

**Provenance.** `c4ffe7a` (the claim), the finding raised against it, and `fab31de` (accepted in full, with the arithmetic that refutes it executed rather than argued).

**Breaks without it.** without it a claim that is arithmetically true and behaviourally false survives into a downstream decision and is found from a result rather than from a disclosure.

### `LC-SO-xgmii_rx_64-AUD-30`

*Where re-deriving a finding made against you corrects the finder, record the correction even though it does not help you. Falsifiability has no exception for findings you are the subject of.*

**Provenance.** `fab31de` — the finder's second reason was wrong (the bound binds six times, not never) and what carries the result is its first reason extended over all six; recorded although the verdict was unaffected.

**Breaks without it.** without it an accepted finding's rationale carries an error into the next round, and the acceptance is a settlement rather than a verification.

### `LC-SO-xgmii_rx_64-AUD-31`

*A disposition **locates** the defect's mechanism at named sites and mints the instrument that would have caught it; it does not confess. A confession teaches nothing and the same defect recurs with a different surface.*

**Provenance.** `fab31de` — four sites named, two rules minted, both binding the very next artefact and both discharged at `8bbc388`.

**Breaks without it.** without it the register records that something went wrong and nobody can tell what would have prevented it.

### `LC-SO-xgmii_rx_64-AUD-32`

*A verification taxonomy with rows only for properties of the artefact, and none for the claims made **about** it, will pass an artefact whose claims are false. Check the set that downstream decisions branch on, not the set that is easy to check.*

**Provenance.** `fab31de` — the taxonomy had a row for every mechanical property of the change and no row at all for a disclosure, although the sealed prediction was a function of the disclosures.

**Breaks without it.** without it the checked set and the relied-on set diverge silently, and the unchecked half is exactly what the decision rests on.

### `LC-SO-xgmii_rx_64-AUD-33`

*Minimality of a deliberate change is measured by its **effect cone**, not by its edit size. Enumerate every reader of every value the edit would alter, and evaluate the change at the cases it must **leave alone** — not only at the case it must change.*

**Provenance.** `8bbc388` — the literal rendering perturbed 191 of 20 736 stimuli and was rejected on that measurement; `784e5b6` — the added stage applied at the leaf so the source's other consumers stay textually untouched; `f9232c2` — a rendering checked against the cases it does *not* mark, which is what rejected the smaller edit.

**Breaks without it.** without it an experiment meant to isolate one effect seeds two, both detectors fire, attribution is impossible, and the result reads as a success while measuring nothing.

### `LC-SO-xgmii_rx_64-AUD-34`

*A model built to check a system must first reproduce quantities of that system it was **not** given. A model validated only against the modeller's expectations reproduces the expectations.*

**Provenance.** `8bbc388` — a modelling bug manufactured an event and was caught only because the model was validated against measured figures it had not been handed; the practice was established one round earlier at `fab31de`.

**Breaks without it.** without it the model's agreement with the claim it exists to check is circular, and every "measured" figure in the report is unfounded.

### `LC-SO-xgmii_rx_64-AUD-35`

*Mine your own record. A rule whose incidents belong to another party's record is **routed** to that party, not claimed — otherwise one incident yields two rules under two owners with one provenance each, and neither is the stronger for it.*

**Provenance.** `8bbc388` — an out-of-span rule routed rather than harvested, with its incidents named and its owner identified.

**Breaks without it.** without it spans stop tiling, the same rule is banked twice, and the register cannot tell a recurrence from a duplicate.

### `LC-SO-xgmii_rx_64-AUD-36`

*Removing one alternative from a first-match selection does not empty the selection — it **promotes the next**. Re-evaluate the selection's output on a concrete input before claiming the removal only deletes a behaviour.*

**Provenance.** `8869705` — the literal rendering refuted by evaluating the selection, which promoted a different alternative and planted a second defect that would have been scored under the first one's name; the converse error at `fab31de`.

**Breaks without it.** without it a change intended to delete one outcome substitutes a different one and every observation afterwards is attributed to the intended change.

### `LC-SO-xgmii_rx_64-AUD-37`

*Where an observer counts **occupancy of a shared slot** rather than distinct events, an event added onto a slot already occupied by an event of the same name is invisible. Declare the unobservable cases before the run, not after the result.*

**Provenance.** `8869705` — three sub-cases declared unscoreable in advance with the derivation attached.

**Breaks without it.** without it a change that fired exactly as designed is recorded as a survival and charged to the observer, and work is done on an instrument that was never wrong.

### `LC-SO-xgmii_rx_64-AUD-38`

*Where a mapping must be derived and cannot be looked up, prefer a derivation confirmed by **two documents that do not cite each other**. Agreement between independent statements is a stronger warrant than either alone.*

**Provenance.** `8869705` — two documents that never cite each other agreeing row for row, which is what fixed the geometry the whole round rested on.

**Breaks without it.** without it a derivation rests on one document's wording and that document's transcription error propagates into every conclusion drawn from it.

### `LC-SO-xgmii_rx_64-AUD-39`

*A check that speaks only on failure cannot be distinguished from a check that was not run. Record the precondition you verified **when it holds**, in the same terms you would have used to report its violation.*

**Provenance.** `8869705` — the commissioning commit's staging of its own sealed companion recorded affirmatively, because its absence would have been a finding and so its presence was equally owed.

**Breaks without it.** without it silence is ambiguous between "verified and fine" and "never looked", and the register of what was checked is unreconstructible.

### `LC-SO-xgmii_rx_64-AUD-40`

*A per-case discharge obligation is run at **every** case the artefact claims, including the ones the author believes symmetric. The asymmetric case is where the first reading fails.*

**Provenance.** `e5c0b11` — the per-case discharge refuted the author's own first rendering at the case that differed, before delivery, and the superseded version is on record.

**Breaks without it.** without it an artefact verified at the representative case ships a defect at the case that differs, and the verification's own scope claim is false.

### `LC-SO-xgmii_rx_64-AUD-41`

*Where the operating base and the instrument's stated base differ, file the disagreement **before** acting, with proof of whether it is material. Proceeding silently converts a documentation defect into an evidence defect.*

**Provenance.** `e5c0b11` — filed before the first branch existed, with the two trees shown byte-identical at every path the round scores, and the round proceeded on the proof rather than on the assumption.

**Breaks without it.** without it results are scored against a base nobody can identify afterwards, and the disagreement surfaces only when a result is disputed.

### `LC-SO-xgmii_rx_64-AUD-42`

*Where history cannot be rewritten, a correction is a **successor**, and the deliverable must say which version is the one to be scored.*

**Provenance.** `e5c0b11` — the rewrite refused by the protection, the correction landing as a successor, the tip named as the deliverable and its predecessor named as superseded.

**Breaks without it.** without it two versions of a correction are both live and the one that gets measured is whichever the runner reached.

### `LC-SO-xgmii_rx_64-AUD-43`

*When every candidate change must leave one observable untouched, select by the **absence of consumers** on the path to that observable, and check faithfulness second. Choosing the most faithful form first and checking it afterwards makes the constraint a side condition rather than the criterion.*

**Provenance.** `adac5ca` — six of seven classes passing the silence requirement by reachability rather than by argument, which is identity *everywhere* rather than identity at the cases one can see.

**Breaks without it.** without it the constraint is verified at the stimuli you have and violated at the ones you do not, and the violation surfaces later as an unexplained result.

### `LC-SO-xgmii_rx_64-AUD-44`

*An instruction to perform an act the constitution reserves to another party is refused and filed **before any irreversible step** — even when the practice is established, recorded and several rounds deep. Repetition is not authorisation.*

**Provenance.** `adac5ca` — the finding filed with the practice's own prior instances at `8869705` and `e5c0b11` named as evidence against itself; ruled ACCEPTED, and carried in the next two commissioning instruments' own terms (`2fbcf0d`, `f9232c2`).

**Breaks without it.** without it an unauthorised act launders itself into a rule by repetition, and the constraint the constitution encodes is lost without anyone deciding to drop it.

### `LC-SO-xgmii_rx_64-AUD-45`

*Where a disputed act is irreversible and refusing it is cheap, refuse and escalate. Asymmetry of cost decides a question that authority alone cannot.*

**Provenance.** `adac5ca` — a wrong irreversible step weighed against a withheld one costing the operator a handful of commands, and the asymmetry stated as the reason rather than the seniority.

**Breaks without it.** without it a party resolves a live constitutional question in the direction that cannot be undone, and the ruling arrives after the damage.

### `LC-SO-xgmii_rx_64-AUD-46`

*State an impossibility claim in the **narrow** form the evidence reaches — about this system's existing terms — never in the wide form about systems generally, even when the wider wording is offered to you.*

**Provenance.** `adac5ca` — the declaration made in the narrow form and the commissioning instrument's wider wording declined on evidence grounds.

**Breaks without it.** without it a local measurement is recorded as a general impossibility and the next project inherits a constraint that was never established.

### `LC-SO-xgmii_rx_64-AUD-47`

*A location reference into a changing artefact, carried outside that artefact without the version it was true at, is falsified silently by the next change. A reference is path, position and version, or it is not a reference.*

**Provenance.** `2fbcf0d` — filed against the counterpart's instrument and against my own prior artefacts equally, with the manifest that filed it written to the rule.

**Breaks without it.** without it citations decay into confident wrongness and no mechanical check anywhere detects it.

### `LC-SO-xgmii_rx_64-AUD-48`

*When a finding's remedy is carried in the commissioning instrument's own terms at the next round, record it as **absorption** and not as a repeat. A register that cannot tell the two apart cannot measure whether anything improved.*

**Provenance.** `2fbcf0d` — the prior round's remedy in force in the packet's own text, recorded as absorption rather than as a recurrence, against a standing evaluation criterion that grades a rising repeat trend.

**Breaks without it.** without it the same citation appears round after round and the trend the register exists to expose is invisible.

### `LC-SO-xgmii_rx_64-AUD-49`

*Where a guarded term must gain a behaviour without moving any existing one, add a **disjunct beside** the conformant term rather than editing the term. The conformant path stays byte-identical, and the addition is identically inert wherever its own guard is false.*

**Provenance.** `f9232c2` — the class the commissioning instrument named three times as the likeliest unrenderable, rendered by one operator, with both silence conditions discharged structurally rather than by argument; adjudicated killed at `d6fdf92`.

**Breaks without it.** without it a change meant to add one case re-times every existing case and is indistinguishable from a global change.

### `LC-SO-xgmii_rx_64-AUD-50`

*An outcome your commissioner predicted impossible is the outcome most likely to be an error of yours. Raise your own evidentiary bar for it before reporting it.*

**Provenance.** `f9232c2` — the rendering held back until its reachable surface was shown empty at the case that mattered, precisely because a disposition had been pre-committed against it.

**Breaks without it.** without it the result that overturns an expectation is the one most likely to be wrong and the least likely to be checked.

### `LC-SO-xgmii_rx_64-AUD-51`

*A statement of what a restriction covered is worthless if it omits its own exposures — **including the ones its author would defend**. Where a required act needs material the restriction omits, perform the act correctly and record the read as an exposure.*

**Provenance.** `f9232c2` — the format specification read to compute a header the enforcement keys on, recorded as a leak rather than argued into the permitted list, on the ground that guessing a format the enforcement checks would trade a protocol defect for a restriction the document could not compromise.

**Breaks without it.** without it either the enforcement is broken to preserve a restriction, or the restriction's certificate omits the one item a reader would want, and the certificate certifies nothing.

### `LC-SO-xgmii_rx_64-AUD-52`

*Record an unresolved inconsistency you cannot fix at **every** round it recurs, with its count. Tidying an anomaly out of your own record destroys the only evidence that it is systematic.*

**Provenance.** four consecutive entries recording the same clock discrepancy with its running count, the fourth stating *"a third recurrence is no longer an anomaly"*.

**Breaks without it.** without it a recurring defect is reported once, read as a one-off, and the trend that makes it worth fixing never becomes visible.

### `LC-SO-xgmii_rx_64-AUD-53`

*A periodic obligation tied to named triggers is discharged **at** those triggers. Work done between triggers is a banking, not a discharge — and calling it one makes the next span's start ambiguous and hides the skipped obligation behind something with the same name.*

**Provenance.** `8bbc388`, headed as the discharge with a span from the first entry, and `8869705`, tiling from it — **neither taken at a trigger**; the measurement that no such discharge had ever fired is `FINDING SO-5` at `a851948`.

**Breaks without it.** without it two different intervals both claim to be "the span since the last discharge", only one of them tiles, and the skipped obligation is invisible because something with the same name happened.

### `LC-SO-xgmii_rx_64-AUD-54`

*Allocate candidate identifiers from **one** sequence over the whole record. Per-round sequences that restart collide across rounds, and a later citation of one identifier then resolves to two different things.*

**Provenance.** `8bbc388` (`LH-A1`, `LH-A2`, `LH-A3`) and `8869705` (`LH-A`, `LH-B`) — two sequences, near-colliding on the first label, with no note in the chain recording the restart.

**Breaks without it.** without it a citation of a banked rule is ambiguous and reconciliation requires re-walking the whole record.


## orchestrator — 18 candidates

**Note**: `J-orchestrator-0233` (the walk) + `J-orchestrator-0234` (the admissibility record — same eighteen ids unrenumbered) · **span**: J-orchestrator-0001 … -0232 · [source at `b4814b0`](https://github.com/renatom11/agentic-fpga/blob/b4814b0/agents/journals/claude_orchestrator_agent.v02.md)

> Statements from 0233; LH2-g grade and LH3 discharge per candidate from 0234; classifier run from step 0 on all 18 (0234). Two candidates (2 and 8) carry version-control tool nouns — the transits hide-test disposition for them is recorded in the header of this file.

### `LC-orchestrator-H1-1`

In-flight agent work is never committed before its author returns and its files-list verifies against the write record; external pressure to commit it is refused every time. Negative instance that proved it: 0125 (my R1 violation carrying dv's in-flight countersignature).

**Provenance.** LH1: 0125 + the standing refusals throughout v02.

**Breaks without it.** LH3: committing mid-round attributes unsigned work to its author - 0125's negative instance carried dv's countersignature in my commit, and the signature's authority had to be rebuilt on its text because the carriage was mine.

### `LC-orchestrator-H1-2`

Every dispatch opens with an abort-first HEAD check, and the check reads DIRECTION by merge-base, not equality - ancestor means rollback, descendant means verify disjointness.

**Provenance.** LH1: 0219, 0222 (incidents three and four); the upgraded form held at every spawn since.

**Breaks without it.** LH3: an equality-only HEAD check cannot tell a rollback from a sibling's landing - incident three's 120-commit regression reads identically to legitimate descent until the merge-base direction separates them.

### `LC-orchestrator-H1-3`

Agent liveness is read from deliverable and scratchpad mtimes, never from the transcript file; a buffered transcript is a known false-positive.

**Provenance.** LH1: the corrected stall heuristic at 0227's arc (the RV-STAGE1 round's false signature).

**Breaks without it.** LH3: the transcript heuristic produced a false stall that was one command from killing a healthy round mid-verdict (the RV-STAGE1 near-TaskStop); the deliverable-mtime read showed 894 fresh lines the transcript hid.

### `LC-orchestrator-H1-4`

Preserve before restore: every recovery diffs the doomed state to scratchpad before any reset.

**Provenance.** LH1: six incidents, zero loss, 0219/0222/0229 and the silent-death partials.

**Breaks without it.** LH3: a reset without the preserved diff destroys the only evidence distinguishing rollback from corruption; every incident's forensic record IS its scratchpad diff.

### `LC-orchestrator-H1-5`

Push-before-pause: a landing is not done until pushed, so an ephemeral container never holds the only copy.

**Provenance.** LH1: 0229 (incident six - a five-hour pause, a reclaimed container, a three-command recovery).

**Breaks without it.** LH3: incident six - unpushed work in a reclaimed container is unrecoverable; pushed work made it three commands. The same event with one unpushed round is permanent loss.

### `LC-orchestrator-H1-6`

A freeze reference in a dispatch predates every commit that could move the frozen thing, and names a RUN, never a literal stored inside the file it protects.

**Provenance.** LH1: 0226 (the circular pin).

**Breaks without it.** LH3: the circular pin - a moved case 0 would have recorded the moved value and passed the freeze check vacuously; the check would have measured nothing while printing green.

### `LC-orchestrator-H1-7`

A dispatch carrying a finding block-quotes the finding's own text, so the assignee reads the source and the dispatch cannot disagree with it.

**Provenance.** LH1: the fourth dispatch error's hardened form (RV-C3ALPHA conduct ruling), applied at every dispatch since.

**Breaks without it.** LH3: my 'amended criterion 7' citation - an assignee following the dispatch would have keyed a repair to a criterion that does not say what the dispatch claimed; the worker's source-read is the only reason it did not ship.

### `LC-orchestrator-H1-8`

A dispatch that names journal-chain state derives it from git show HEAD:<journal> at dispatch time, exactly as rotation hashes are derived.

**Provenance.** LH1: 0231 (the fifth error - a stale entry id quoted one volume behind).

**Breaks without it.** LH3: the 0022 collision - an entry id from stale memory collides with an existing header and fails R5; undetected, it forks the chain's numbering silently.

### `LC-orchestrator-H1-9`

The dispatch author's obligation when a dispatch and a committed artifact disagree: the artifact governs, and the author's repair is to quote from the file, never from memory of it. Seven dispatch errors in this record, all mine, all caught by assignees - the control working in the wrong direction until the form changes made it structural.

**Provenance.** LH1: the error ledger across 0226/0228/0231/0232 and the SO-5 five-agent misread.

**Breaks without it.** LH3: the lowercase case-id error - uncaught, both new cases PRODUCE-REFUSE on 'unknown case id' and the landing reds for a defect in neither producer; eight instances of the species, every one caught by an assignee reading the source.

### `LC-orchestrator-H1-10`

Two rounds run concurrently iff their write sets are named disjoint in BOTH dispatches and verified disjoint at BOTH landings; the packet is never shared.

**Provenance.** LH1: the declared-sibling arcs at 965f6ee..ce5674d and the five-way harvest fan-out.

**Breaks without it.** LH3: two rounds sharing an undeclared file interleave writes; the landing attributes one author's lines to another, and R4 set-equality breaks in a way no later reader can untangle - the reason the packet's section 14 was never given to two concurrent rounds.

### `LC-orchestrator-H1-11`

No orchestrator commit lands during an open round unless disjointness is verified first and the open round is named in the entry.

**Provenance.** LH1: 0211's rule, held at every board flip since.

**Breaks without it.** LH3: an orchestrator commit inside an open round moves HEAD under the agent's feet; its spawn-head reasoning and its landing diff both silently change meaning - the disjointness verification is what makes the mid-round board flip lawful rather than lucky.

### `LC-orchestrator-H1-12`

A journal rotation's chain header is computed independently by dispatcher and author and verified both sides at the landing.

**Provenance.** LH1: dv v06-v07-v08, workers v02-v03, auditor v01-v02.

**Breaks without it.** LH3: a chain header computed by one party can freeze the wrong state - the bare-filename field would have failed the verifier AFTER landing; a wrong sha breaks every future verification at the worst possible time, silently until read.

### `LC-orchestrator-H1-13`

Verdicts and findings travel in the author's words - quote or pointer, never summary - to the sponsor and across seats.

**Provenance.** LH1: the standing verbatim-relay practice; the WO-0077 9.1/9.2 relay landed at the auditor's harvest.

**Breaks without it.** LH3: a paraphrased verdict drops the author's own riders - the 62/62 quoted without its does-not-mean clauses claims the PASS the verdict explicitly denies; verbatim carriage is what makes relay safe.

### `LC-orchestrator-H1-14`

The incident journal is written at the recovery, in the same session, not reconstructed later.

**Provenance.** LH1: 0219/0222/0229 and the incident-five record at 0227.

**Breaks without it.** LH3: a reconstructed incident record is memory wearing measurement's clothes - the reflog states and rollback counts cannot be re-derived once the container is gone; only the at-recovery record is evidence.

### `LC-orchestrator-H1-15`

The board updates in the same commit as the state change it describes, and a stale inventory is repaired by MEASUREMENT, never arithmetic.

**Provenance.** LH1: 0224 (59-with-six-families corrected to 85-by-ls-remote, staleness disclosed).

**Breaks without it.** LH3: the inventory drifted four campaigns on ride-along updates; the arithmetic repair (59+9) would have shipped a second wrong figure - the measurement said 85. A stale count repaired by arithmetic compounds the drift it hides.

### `LC-orchestrator-H1-16`

A silent worker death leaves no task record; the respawn reissues the identical dispatch with an anti-collision precheck and a resource-compactness hint, after partials are preserved and discarded.

**Provenance.** LH1: incident five at 0227.

**Breaks without it.** LH3: a respawn onto an unverified tree merges two half-rounds' writes into one attribution; without the compactness hint the successor dies the predecessor's death - incident five's respawn survived on both provisions.

### `LC-orchestrator-H1-17`

A refused instrument attempt goes in the journal, not in the void - durability applies to refusals.

**Provenance.** LH1: the durability clause's uses across the campaign and cosim arcs (proxy 403s, egress denials).

**Breaks without it.** LH3: an unrecorded refused attempt is indistinguishable from an attempt never made - the proxy-403 workarounds are diligence only because journaled; unjournaled they are omissions no audit can acquit.

### `LC-orchestrator-H1-18`

The stop condition is pre-registered with the answer not in hand, and it is retired on an answer, never on a timeout.

**Provenance.** LH1: adopted from dv's practice at the C2 arc and applied to my own stall thresholds; the generalization is this seat's.

**Breaks without it.** LH3: a stop condition written after seeing the run is a choice wearing a rule's clothes - the C2 third-run disposition is falsifiable only because the rule predates the answer; post-hoc it would justify any outcome equally.


## tb_writer (worker chain) — 28 candidates

**Note**: `J-tb_writer-0041` · **span**: J-tb_writer-0001 … -0040 · [source at `59942de`](https://github.com/renatom11/agentic-fpga/blob/59942de/agents/journals/workers/claude_tb_writer_agent.v03.md)

> The bank is a three-column table (id, entry(s), abridged statement) under a single blanket LH1 declaration covering every row; statements are the notes own abridgements ("abridged to their first clause"). The notes prose calls `SELFWALK-28` a cross-seat flag rather than a fresh banking while its table holds it as row 28 — the ambiguity is the sources, preserved.

### `LC-tb_writer-SELFWALK-1`

a search pattern broad enough to match content outside an intended boundary will eventually match some of it near that boundary; scope a reconnaissance search to the exact subtree being examined, not to whatever pattern is merely convenient

### `LC-tb_writer-SELFWALK-2`

driving a stateful system by iterating a collection through a combinator whose element-application order is unspecified can silently reorder the delivered sequence; the delivery order is part of the stimulus and must be asserted in code at the point the side effect happens

### `LC-tb_writer-SELFWALK-3`

a guard against out-of-order delivery must read the actual sequence of side effects at the single point they all pass through, never the order of a returned artefact built afterward or a schedule-derived proxy an override can bypass

### `LC-tb_writer-SELFWALK-4`

a timing relationship observed for one output of a multi-output component does not necessarily hold for every other output; some may be registered and others combinational within the same step, and each must be verified on its own

### `LC-tb_writer-SELFWALK-5`

a library that both generates stimulus and computes a from-scratch reference model of expected behaviour is not uniformly safe to call; read its source to find the seam, and use only the construction half

### `LC-tb_writer-SELFWALK-6`

a stimulus generator's own internal self-check passing certifies only that its model is internally consistent, never that it can be driven through a different consumer's own gate that has never previously been combined with it

### `LC-tb_writer-SELFWALK-7`

a convention or proxy that happens to satisfy a rule in every instance tried so far is not evidence it equals the quantity the rule actually constrains; the coincidence usually rests on an unnoticed symmetry that breaks at a differently-shaped instance

### `LC-tb_writer-SELFWALK-8`

a value copied from a similar-looking sibling case is checked, if at all, against that sibling's own shape rather than the rule that determines it; only re-deriving each case's own value from the rule catches a value copied from the wrong analogy

### `LC-tb_writer-SELFWALK-9`

a multi-part text edit that splices content between two syntactic units can detach a comment's own closing delimiter from its body, leaving text that is structurally valid but not the structure intended; a checker confirming only that something parses cannot see this

### `LC-tb_writer-SELFWALK-10`

before building a stimulus from an interface's most obvious composition, trace by hand what the resulting sequence actually contains; an obvious composition can silently insert an interval that redirects the stimulus down an unintended path

### `LC-tb_writer-SELFWALK-11`

a check that derives its own expected value by calling the same function whose coverage it exists to establish is circular and cannot catch a bug in that function; build the expectation from an independently obtained ground truth instead

### `LC-tb_writer-SELFWALK-12`

an import that shadows a standard name with a deprecated, alert-fatal alias fails at a compile stage a parse-only check never reaches; a fully-qualified reference to the shadowed name bypasses the shadow without adding a dependency

### `LC-tb_writer-SELFWALK-13`

a helper that partitions a stream at its first terminating event silently misattributes everything before that event to whichever record it assumes is closing there; an earlier record that ends by a different mechanism breaks that assumption

### `LC-tb_writer-SELFWALK-14`

a check built on the differences between consecutive elements cannot detect a shift applied uniformly across the whole sequence, because a uniform shift cancels out of every difference; an absolute-value check catches it but needs its own guard

### `LC-tb_writer-SELFWALK-15`

when two different causes can produce an identical observation and no available channel distinguishes them, state that tension explicitly rather than silently picking an interpretation or building the test case to avoid the ambiguous input

### `LC-tb_writer-SELFWALK-16`

when a precondition fails, prevent the checks depending on it from running at all rather than computing them anyway and filtering their output before display; a display-side filter can be defeated by a bug in the filter itself

### `LC-tb_writer-SELFWALK-17`

extending a format shared by two independently-written producers with a field only one can ever truthfully populate teaches the format to claim knowledge one writer structurally lacks; carry that information out of band instead

### `LC-tb_writer-SELFWALK-18`

a discriminator built by counting how many local checks fail can coincidentally match the same count for two different causes; a discriminator built on the shape or direction of the departure is harder to fool by an unrelated matching count

### `LC-tb_writer-SELFWALK-19`

when two outputs are meant to derive from the same underlying classification but each is computed by a separate call to the classifying function, a rule change applied at one call site can silently leave the other stale; compute it once, derive both from that one result

### `LC-tb_writer-SELFWALK-20`

a build unit's declared dependency list describes what the whole unit needs in aggregate, not what any single file inside it requires; trace a specific file's own imports before accepting the aggregate as that file's own bound

### `LC-tb_writer-SELFWALK-21`

state modelled as a single slot for "the one thing currently open" silently assumes at most one instance is ever in flight; the moment a stimulus can produce two overlapping instances, the model needs an ordered queue, not a second slot

### `LC-tb_writer-SELFWALK-22`

a check observed only ever to pass is indistinguishable from a check that cannot fail; construct a deliberate instance of each way it is meant to fail and confirm it produces that check's own specific, named failure before trusting it as a gate

### `LC-tb_writer-SELFWALK-23`

a fixture meant to certify a component's intended behaviour must be built from the specification's own derivation, never from a hand-read datum off an actual, possibly still-disputed run, which conflates what should happen with what one run produced

### `LC-tb_writer-SELFWALK-24`

when a hand-authored text stands in for an untested producer, generate the other side of the comparison through the already-trusted path, not by hand a second time; two hand-authored sides would only prove they agree with each other

### `LC-tb_writer-SELFWALK-25`

citing an existing, already-reviewed override affordance as precedent for a new construction licenses reusing that exact mechanism only; building a similarly-shaped mechanism fresh and calling it the same hook launders an unreviewed capability under an old approval

### `LC-tb_writer-SELFWALK-26`

a workaround confined to one's own write scope can still reproduce another component's private, undocumented internal geometry a second time outside that component's own abstraction, risking silent drift and disagreeing with what that component's own tools would report

### `LC-tb_writer-SELFWALK-27`

verifying that a formula sits correctly in the source is not the same fact as the produced artefact carrying the intended values at the intended positions; read the artefact itself, decoded field by field, before treating a construction as valid

### `LC-tb_writer-SELFWALK-28`

a helper's own docstring can misstate its domain; before applying it to a new value, reproduce the function's actual behaviour against a worked example rather than trust the prose describing what it accepts


## data_wrangler (worker chain) — 14 candidates

**Note**: `J-data_wrangler-0009` · **span**: the seats chain to its note · [source at `2d47871`](https://github.com/renatom11/agentic-fpga/blob/2d47871/agents/journals/workers/claude_data_wrangler_agent.md)

> "All fourteen graded `LC-`, `LH2-g`, and none reached step 2" (the notes uniform declaration); LH1 is the notes "entry(s) / commit(s)" cell per candidate.

### `LC-data_wrangler-H1-1`

a caller invoking an interface that does not exist yet writes any unpinned calling-convention detail down as a flagged assumption in its own text

**Provenance.** `-0001` (`2c6a3ec`), wrong-guess confirmed at `-0002` (`6181781`)

**Breaks without it.** the guess ships silently and every real invocation fails without ever doing the thing it was meant to do

### `LC-data_wrangler-H1-2`

a value composed from several independently-defaulting sources can look valid to a downstream presence check while partly fabricated; compose only from the sources that actually succeeded

**Provenance.** `-0002` (`6181781`)

**Breaks without it.** a guard built to reject fabricated content lets a fabricated value through one layer beneath itself

### `LC-data_wrangler-H1-3`

a code whose own documentation calls its meaning ambiguous is routed to the same branch as an unrecognized code, never given a dedicated branch

**Provenance.** `-0003` (`aa672c6`)

**Breaks without it.** a later change reads a certainty into the code that its own issuer disclaims, invisibly, until the ambiguous case occurs

### `LC-data_wrangler-H1-4`

a dump-before-exit step is kept textually beside each of several failure exits rather than factored into one shared call ahead of a branch

**Provenance.** `-0003` (`aa672c6`)

**Breaks without it.** a later exit added to the branch can silently skip the dump, invisible until it fires for real with no evidence printed

### `LC-data_wrangler-H1-5`

when an instruction summarising a task assigns work its own authoritative document places in another party's scope, the document's split governs and the discrepancy is recorded, not silently resolved either way

**Provenance.** `-0004` (`5705e3a`)

**Breaks without it.** no one downstream can tell whether an executor over-reached or under-delivered, or why

### `LC-data_wrangler-H1-6`

widening a check built for one instance into a loop over many converts every immediate-abort-on-failure branch to record-then-continue, or every case queued behind the first failure loses its own report

**Provenance.** `-0005` (`8c6429e`)

**Breaks without it.** adding a set where a single check ran turns the first failure into a report-truncation for every later case, including a clean one

### `LC-data_wrangler-H1-7`

a design satisfying two stated constraints only because the current instance count makes them coincide is stated as scoped to that count, not presented as the general design

**Provenance.** `-0005` (`8c6429e`), successor predicted then landed at `-0006` (`53fa1de`)

**Breaks without it.** the next instance beyond that count forces the two constraints apart and nothing on record explains the break was ever conditional

### `LC-data_wrangler-H1-8`

an implementer's own judgment that a branch of their own code is unreachable is not, alone, grounds to exempt it from an invariant every other branch upholds

**Provenance.** `-0005` (`8c6429e`), self-judgment corrected by the reviewer's ruling, implemented at `-0006` (`53fa1de`)

**Breaks without it.** if the branch becomes reachable the exemption is exactly what fails, and its own author is the worst-positioned person to have caught it

### `LC-data_wrangler-H1-9`

a read denied by a standing access-control policy is attempted again through a different transport reaching the same artifact, never by retrying the denied path with altered parameters

**Provenance.** `-0005` (`8c6429e`)

**Breaks without it.** a denial meant to enforce a boundary is treated as an obstacle to route around, and the boundary stops meaning anything once it is inconvenient

### `LC-data_wrangler-H1-10`

when a dispatched instruction's literal content contradicts the artifact it names to call, the artifact governs, proven load-bearing by reproducing the dispatch's own failure on a reverted, disposable copy before discarding it

**Provenance.** `-0006` (`53fa1de`)

**Breaks without it.** a reader cannot tell whether a claimed "correction" fixed a real defect or was cosmetic, and a wrong fix can pass on confidence alone

### `LC-data_wrangler-H1-11`

correcting your own prior reasoning that a reviewer explicitly rejected is done by quoting the reviewer's own words, not by restating the correction in your own

**Provenance.** `-0006` (`53fa1de`)

**Breaks without it.** restating a rejection of your own mistake risks reintroducing the same mistake in different phrasing

### `LC-data_wrangler-H1-12`

a harness driving dependencies unavailable in its own environment is validated by substituting disclosed stand-ins at its exact call sites, exercising its real committed logic — never a re-implementation of it — with what this does and does not substitute for stated beside the result

**Provenance.** `-0001` (`2c6a3ec`), refined at `-0005` (`8c6429e`), disclosed at `-0008` (`3d9b44d`)

**Breaks without it.** a local check either silently overclaims it exercised the real dependency, or is skipped, forfeiting confidence a disclosed stand-in could honestly buy

### `LC-data_wrangler-H1-13`

validation effort for a change is sized to the surface the change's own diff touches, not to the harness's total surface

**Provenance.** `-0008` (`3d9b44d`), read against `-0005`/`-0006`/`-0007`'s own scenario counts

**Breaks without it.** re-exercising paths a change did not alter buys nothing the earlier validation of those paths did not already buy, at real cost

### `LC-data_wrangler-H1-14`

a remedy an instruction directs wider than the finding it cites diagnosed is implemented at the instructed width if so directed, with the widening attributed to the instruction, never folded silently into the finding's own authority

**Provenance.** `-0007` (`9685c52`)

**Breaks without it.** a later reader citing the finding inherits a scope the finding never earned and cannot separate the diagnosis from the instruction riding on it
---

## Appendix — war stories (failed candidates, each with the criterion it failed)

Optional per FEDERATION §6. The seats' refused candidates, verbatim from the notes; not admissible, offered as evidence of where the bar sits.


### dv_lead

Copied verbatim from lines 2457–2484 (the "criterion failed" column of the table is the criterion each story failed):

### 4.6 THE WAR STORIES — nine, each with the criterion it failed

| # | war story | entry | criterion failed | why |
|---|---|---|---|---|
| **W1** | *a count taken from the artefacts an investigation happened to open is a sample, not a census* | `0100`, closed `0101` | superseded | the miscount was corrected from the tree; **its portable content survives inside `LC-…-16`** |
| **W2** | parenthesise mixed bitwise and arithmetic operators | `0103` | **LH2** (both grades) | the portable content is a coding convention, not a process rule |
| **W3** | *agreement between two methods is not corroboration when neither was checked against the thing being counted* | `0114` | **LH2** as written | could not be stated without leaning on the round's coincidence |
| **W4** | *a claim about what a test suite depends on must be re-measured, not carried, when the suite grows* | `0115` | **LH2-g and LH2-d** | reads as project hygiene rather than as a portable rule |
| **W5** | *an adversary's contradiction of your own prediction is stronger evidence of independence than any assurance* | `0116` | **LH2** | could not be stated without the round's particulars |
| **W6** | *the red-presentation taxonomy needs a third column* | `0117`, **retired** | superseded | five presentations appeared in one round; **folded into `LC-…-17`** |
| **W7** | the plan's two strike notations | `0118` | **LH2** (both grades) | a notation choice inside one document |
| **W8** | *determinate-wrong-answer versus no-determinate-answer* (the injection/refusal split) | `0119` | **LH2-g** | every attempt to state it named a stimulus generator or a specification's own vocabulary |
| **W9** | the anti-vacuity plan that dispositioned its findings before wiring its own gate, so the first gating run was green and proved nothing | `0163` | **subsumed** | generalises only into `LC-…-80`, which already carries it |

**W1 and W6 are RETIRED** (superseded, their content folded into named candidates);
**W2, W3, W4, W5, W7, W8 and W9 are kept and re-offerable at a later harvest with new
provenance.** **The war-stories table is not empty, and the number is the bar's own
evidence**: **nine refusals against ninety-eight bankings**, roughly one item in eleven
offered, refused **by its author before any collator saw it**.

**And the mirror line the block's §4 asks for, applied honestly against myself.** A yield
of **94 `LC-` to one `LD-`** is the inverse of the *"all `LD-` says something about the
miner"* warning, and it deserves the same suspicion. **My reading**: this chain's
discipline pushed every candidate through step 0 at banking time, so the general
statement was written first, every time, and the domain grade almost never got a chance
to be a shortcut. **The bar's discriminating power in this chain lives in the war
stories, not in the `LC-`/`LD-` split** — the nine refusals are where the bar bit.


### architect_docs_lead

Entry lines 315-331 (file lines 4221-4237):

```
#### 7. THE WAR STORIES — nine, each with the criterion it failed

| # | war story | entry | criterion failed | why |
|---|---|---|---|---|
| **W1** | Use the warning-suppressing form of an import for a module nothing references, or the build fails under a strict profile. | `-0003` | **LH2 (both grades)** | The portable content is one language's build-profile convention, not a process rule. |
| **W2** | Encode a zero-length payload as "no frame emitted" rather than as a last word with an empty byte-enable. | `-0002` | **LH2 (both grades)** | Every attempt to state it leaned on the stream type's own field vocabulary and this project's monitor invariants; the portable residue is candidate 41 and is already banked there. |
| **W3** | Choose a record field name so the generated identifier equals the externally required one. | `-0004` | **LH3** | The stated failure reduces to "the external contract is written in two places", which is candidate 42's, and on its own the rule is a code-generation tip. |
| **W4** | Do not pin a component exactly at its allocated ceiling with no reserve. | `-0005` | **LH3** | The failure I could state was "a later request arrives as a surprise" — a virtue, not an outcome a reviewer would recognise in another repository. |
| **W5** | One document, one row-numbering convention. | `-0013` | **LH2** as written | Could not be stated without leaning on the specific paragraph's indexing; the portable half is candidate 9. |
| **W6** | Do not renumber prose in the same change that pins row indices. | `-0013` | **LH3** | An ordering-of-operations preference with no concrete bad outcome beyond confusion. |
| **W7** | Record what you did **not** check as data rather than as adjudication. | `-0016` | **subsumed** | Generalises only into candidates 40 and 56, which already carry it with sharper provenance. |
| **W8** | Do not spend a shared reserve immediately before a gate to match current consumption. | `-0008` | **LH2-g and LH2-d** | Reads as budget hygiene specific to a fixed-allocation scheme; every general form I attempted collapsed into candidate 19. |
| **W9** | An ordinal inside a tracking row ("the fifth such class") goes stale. | `-0017` | **subsumed** | Candidate 42 already covers it and covers it more generally; kept only because its provenance is the *cost* of 42 being incurred a second time. |

**W7, W8 and W9 are retired as subsumed**; **W1–W6 are kept and re-offerable** at a
later harvest with new provenance, per §3.5. Recording the re-offer path is not an
obligation on anyone to revisit the pile.
```


### rtl_lead

(section #### 7, lines 3583-3617, verbatim — sixteen per the note's count; 16 rows measured)

#### 7. THE WAR STORIES — sixteen, each with the criterion it failed

| # | war story | entry | failed | why |
|---|---|---|---|---|
| **R1** | the non-re-abstracting signature idiom for a functor application | `-0001` | **LH2-g and LH2-d** | the portable content is a language idiom, not a rule about how work is done; as a domain candidate the pack would be a language ecosystem and the statement a coding convention |
| **R2** | confirm in writing a naming convention that many later artefacts will depend on, before the first dependent is written | `-0001` | **LH1** | asked and answered; the convention was ratified and nothing was built wrong. Re-offerable the first time an unratified convention has to be unpicked |
| **R3** | the build profile's fatal-warning set decides which documentation-only bindings may exist | `-0002` | **LH2-g and LH2-d** | toolchain configuration; as a domain candidate it is a project fact in disguise — this programme's lane, not a domain's |
| **R4** | where an instruction's illustrative example is inconsistent with its normative clause, implement the clause and flag the example | `-0005` | **LH1** | flagged, never ruled, nothing built wrong. Re-offerable if the example is ever ruled against the clause |
| **R5** | a defect found on a stimulus the current scope forbids is recorded with the reason it is unreachable, and re-checked when the scope widens | `-0005` … `-0012`, carried six rounds unchanged | **LH1** | never reached; there is no incident to point a reader at. Its portable content survives inside candidate 20 |
| **R6** | foreign files appearing in a shared working tree mid-round | `-0006` | **subsumed** | its portable content is candidate 26, which already carries it |
| **R7** | a check that is the only one available is cited with the failures it cannot detect, **every** time it is cited, not once | `-0005`, `-0006`, `-0009`, `-0010`, `-0011` | **LH1** | the discipline held at all five citations; there is no round where the weak check accumulated authority. Re-offerable at the first citation that drops the caveat |
| **R8** | where the record's grammar expects an attribution token and the dispatch omits one, substitute a stated checkable identifier and say what it stands for | `-0010`, `-0011`, `-0012` | **LH1** | three of my spawns carried no short-id, but the protocol owes a lead none, so the omission is not a defect. **Tier-3 disposition: local-accretion candidate** — if lead rounds should carry an attribution token, that is a protocol clause and orchestrator-scope; not adopted by this note |
| **R9** | a name that suggests a width or cardinality it does not have | `-0012` | **LH3** | the stated outcome is that a reader may be misled, which is a virtue-shaped failure rather than a concrete one |
| **R10** | prefer the structure in which a pinned figure falls out of the shape over the one in which it is arranged | `-0002` | **LH1** | vindicated by five consecutive changes in which the figure did not drift — the absence of a failure is not an incident. This is the war story I most expect to return with provenance |
| **R11** | two formulations of a transform used interchangeably carry the argument that they are the same function | `-0001` | **LH1** | the argument was written and nothing shipped reversed |
| **R12** | a deliverable discharged by making no change is reported as discharged, with its reason | `-0001`, `-0002` | **LH1** | stated twice, and no round in this span shows an unreported no-op being mistaken for an unperformed task |
| **R13** | an unconstrained input case is written out rather than left to a library default | `-0001` | **LH1** | no incident in my span; the reasoning that taught it belongs to an ADR written by another seat |
| **R14** | delegating work whose correctness rests on counter-intuitive constraints requires restating every one of them; where that restatement costs more than the work, the work is not delegable | `-0002` | **LH1** | I never delegated, so no packet ever dropped a constraint. **This is the decision that emptied my worker span** (§8) and it is recorded here rather than banked, because its evidence is an absence |
| **R15** | a precedent established under an explicit temporary allowance may not be copied into work the allowance does not cover | `-0003` | **LH1** | counterfactual — the copy was refused, so no allowance was widened. Its incident-bearing form lives in the neighbouring seat's exception-list cluster |
| **R16** | where the feedback loop that catches a mistake is expensive, prefer repetition of a construct already proven in this environment over an abstraction that introduces an unproven one | `-0003` | **LH1** | the abstraction risk never materialised; the four copies worked and the one construct I flagged as unsettleable did not redden |

**R6 is subsumed** (its content is banked as candidate 26). **The other fifteen
are kept and re-offerable** at a later harvest with new provenance, and a re-offer
cites this harvest as the one that refused it.

**The bar's own evidence, and it bit harder here than next door.** Sixteen
refusals against sixty-six items offered — roughly **one in four**, against
dv's one in eleven. I do not read that as a better chain. It is the direct
consequence of §2's strict LH1: I refused every rule whose only provenance was a
hazard I successfully avoided, and my span — twelve entries of design and repair,
with the design decisions dense at the front — is full of those. **Twelve of the
sixteen failed LH1 and nothing else** (two failed LH2 at both grades, one failed
LH3, one is subsumed), which is the honest shape of a first
harvest over a span whose author mostly got it right the first time and whose
mistakes, when they came, came as three criticals in one module.


### auditor

(Verbatim, lines 926-940 — header, table, and disposition paragraph.)

**THE WAR STORIES — five, each with the criterion it failed.**

| # | war story | entry | criterion failed | why |
|---|---|---|---|---|
| **WA-1** | a general-purpose language's `and` returns an operand rather than a boolean, so coercing a mask through it silently widened a one-bit field and manufactured an event | `8bbc388` | **LH2, both grades** | unstatable without naming a language's evaluation semantics, and one language's semantics is not a domain in the pack sense; its transferable half is `-AUD-34` |
| **WA-2** | a class claiming to touch only the reporting path must still discharge the datapath, because the two share terms | `8869705` | **LH3** | nothing breaks without it that is not already broken without the gate-inventory rule that obliges exactly this discharge — **subsumed**, recorded so no duplicate is minted |
| **WA-3** | apply an added stage to the derived value rather than to its source, so the source's other consumers stay textually untouched | `784e5b6` | **subsumed** | its portable content is `-AUD-33`, where it is carried as a provenance; retired, not separately banked |
| **WA-4** | the unchanged baseline carries two lines wider than the margin its own check enforces | `4ef6628` … `c4ffe7a` | **LH2-g and LH2-d** | a fact about one tree, not a rule; its portable content is `-AUD-25`; retired |
| **WA-5** | introduce an intermediate name rather than extend an existing line | `480c38a` | **LH2, both grades** | a coding convention, the same class dv_lead's `W2` refused; its portable half is `-AUD-28` |

**WA-1, WA-2 and WA-5 are kept and re-offerable** at a later harvest with new provenance;
**WA-3 and WA-4 are retired**, their content folded into named candidates. The
war-stories table is not empty, and five refusals against sixty-four extracted statements
— roughly one in thirteen, refused by their author before any collator saw them — is the
bar's own evidence that it bit.


### orchestrator

### 0233 — `### War stories (kept, not offered)` (lines 3435-3441, verbatim)

- The sponsor's secret-name typo (CLOUDFARE) found by asking for a screenshot rather than re-deriving the pipeline. Fails LH3: ordinary debugging judgement, no sharp rule.
- The 12-hour heartbeat chain surviving six wakeups with state intact. Fails LH2-g: the rule it suggests is candidate 5 said smaller.

Criteria failed (0233): CLOUDFARE typo — fails **LH3**; heartbeat chain — fails **LH2-g**.

### 0234 — `### War stories (criterion named, unchanged from 0233)` (lines 3540-3544, verbatim; 0234 restates 0233's stories)

- The CLOUDFARE typo: fails LH3 - ordinary debugging judgement, no rule with a sharp failure to state.
- The heartbeat chain surviving six wakeups: fails LH2-g - its general form is candidate 5 said smaller.

Criteria failed (0234, same two stories, same criteria as 0233): CLOUDFARE typo — fails **LH3**; heartbeat chain — fails **LH2-g**. The 0234 heading itself declares the restatement: "criterion named, unchanged from 0233".


### tb_writer

Header line, file line 2247; table, file lines 2249–2253; refusal-count
paragraph, file lines 2255–2258:

```
**WAR STORIES — three, each with the criterion it failed.**

| # | war story | entry | criterion failed | why |
|---|---|---|---|---|
| **W1** | a format directive's bare zero-width field means minimum digits for the value, distinct from a zero-flag before a nonzero width | `0012` | **LH2-g** | could not be stated without leaning on a specific format-string specification's own special-case wording; possibly re-offerable at `LD-` grade for a hardware-description-language or C-family-printf pack at a later harvest, not attempted here since I do not hold a second incident to test the domain grade's own hide-the-provenance step against |
| **W2** | when a construction choice is genuinely open and an already-reviewed technique exists for the identical shape, reuse it rather than invent a new one | `0038` | **LH3** | reads as ordinary engineering preference (prefer the smaller, already-reviewed bet) rather than a rule with a sharp, surprising, stated bad outcome; the failure it prevents ("multiplies unverified surface for no benefit") is real but mild, and every attempt to sharpen it collapsed back into "review reused work costs less than review new work," which teaches nothing a reader did not already know |
| **W3** | match an artefact's own identifiers to the vocabulary a governing document already uses, rather than inventing a translation between the two | `0035` | **LH3** | the stated failure ("a reader must cross-reference two id schemes") is a real but minor friction, not a defect class; reads as ordinary naming hygiene rather than a discovered failure mode |

Three refusals against twenty-eight fresh candidates offered — roughly one
in ten, the same rough proportion `dv_lead`'s own round found (nine against
ninety-eight, one in eleven) — kept, not deleted, each re-offerable at a
later harvest with new provenance per ADR-0018 §3.5.
```


### data_wrangler

Verbatim, lines 2326–2332 (bold run-in plus table):

````
**THE WAR STORIES — three, each with the criterion it failed:**

| # | candidate, abridged | entry | criterion failed | why |
|---|---|---|---|---|
| **W1** | a build tool's own cache directory landing inside a checkout, judged acceptable because it is already ignored and matches existing precedent | `-0001` | **LH2** (both grades) | stripped of the tool and the ignore-file it names, the statement collapses to "leave an existing convention alone" — too thin to teach |
| **W2** | a self-test's execution position inside a widened loop, preserved to match the pre-existing single-instance ordering | `-0005` | **LH3** | no concrete bad outcome is shown for the alternative ordering; continuity for its own sake, not a guard against a stated failure |
| **W3** | an exit code's numeric value, taken from a reviewing party's own suggestion rather than picked independently | `-0003` | **LH3** | agreeing with an offered number nothing argued against prevents no stated failure; a convention followed, not a rule earned |
````
