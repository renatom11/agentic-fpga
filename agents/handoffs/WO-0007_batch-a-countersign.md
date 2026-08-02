# WO-0007: Batch A testability countersignature (SPEC-M01, SPEC-M02)
- **State**: RETURNED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: docs/specs/modules/axi64.md and crc32_eth.md at 22145b5
  (DRAFT, template-complete); their ifc_check lifts (compile evidence: build
  run 30727252770, green — the first ppx elaboration of these records);
  docs/specs/SPEC-TEMPLATE.md; requirements.md at b4b4cf4; the WO-0006
  Return log (architect's open questions and their dispositions in the
  ACCEPTED entry); the carry-forward ledger (C-1/C-4 are batch-B scoped)
- **Deliverables**:
  - A verdict entry in this packet's Return log: per spec, SIGNED or
    CONTESTED (contested = the specific sections a test writer cannot work
    from, phrased as spec-diff requests). Judge each spec as the reader who
    will hand excerpts to a tb_writer who never sees RTL. Explicitly judge:
    (a) SPEC-M02's finished-CRC port convention (constants read directly at
    crc_out, seed 0x00000000) — the convention your own REQ-303/304
    findings made load-bearing; (b) SPEC-M01's Status record vs the §12
    strobe appendix (names, order, completeness); (c) the "not applicable"
    answers — each is honest or it isn't.
  - If both SIGNED: the sentence "I countersign batch A (SPEC-M01,
    SPEC-M02) for P1-spec-freeze at 22145b5" in your journal entry, for
    orchestrator transcription to the gate table.
  - Journal entry J-dv_lead-0003; Files-in-this-commit: exactly this
    packet.
- **Definition of done**: both specs judged; the countersignature decision
  explicit either way; no edits outside this packet + your journal.
- **Out of scope**: re-reviewing requirements.md (signed at b4b4cf4);
  bench construction; the REQ-010/M02 narrowing (already agreed for batch
  B — judge M02 against the agreed future wording, noting that you do so).
## Task
The freeze-or-contest decision for the two foundation specs. Sign only
what you can defend to the auditor.
## Return / verdict log
(dv_lead appends on RETURNED)

### RETURNED — dv_lead, 2026-08-02T05:55Z

- **State**: ISSUED → **RETURNED** (awaiting orchestrator commit, then
  transcription of the signature sentence into the gate table)
- **Journal**: `J-dv_lead-0003`
- **Spawn short-id**: WO-0007/2026-08-02T05:20Z
- **Review targets**: `docs/specs/modules/axi64.md` and
  `docs/specs/modules/crc32_eth.md` at 22145b5, with their `ifc_check` lifts;
  judged against `docs/specs/requirements.md` and `docs/specs/SPEC-TEMPLATE.md`
  at b4b4cf4. No RTL was read; `libs/**` and `rtl_snapshots/**` were not opened.

#### Verdicts

| Spec | Verdict |
|---|---|
| SPEC-M01 `Axi64` | **SIGNED** |
| SPEC-M02 `Crc32_eth` | **SIGNED**, judged against the REQ-010 narrowing already agreed for batch B (see the dependency note below) |

Both are specs I would hand to a tb_writer as excerpts today. SPEC-M01 §6.1 is
sufficient to build the shared protocol monitor (octet positions, `tkeep`
contiguity, `tlast`, `tuser` `tlast`-only significance, `tstrb` = 0) and the
header-field comparators, and §6.3 item 5 tells the monitor what it must *not*
assert — `tdata` at positions where `tkeep` is 0, and every field on a
`tvalid` = 0 cycle — which is the false-failure guard I most wanted to find and
did. SPEC-M02 §4.2, §6.1 and §6.3 are sufficient to build the M02 directed and
randomised benches without a protocol reference open: port widths, the
octet-position mapping, the 1-to-8 domain with an explicit instruction to assert
nothing outside it, two worked examples with real numbers, and the oracle
relationship including its anchoring obligation.

#### (a) SPEC-M02's finished-CRC port convention — VERIFIED BY COMPUTATION

Every number in §6.1 was recomputed, not checked. I wrote a bit-serial CRC-32
from REQ-301's parameterisation as stated in requirements.md §4 (polynomial
0x04C11DB7, init 0xFFFFFFFF, reflected in and out, final XOR 0xFFFFFFFF), with
no table and without `zlib` in the definition, then cross-checked against `zlib`
afterwards. The exact command is Evidence item 1 of `J-dv_lead-0003`.

| Claim in SPEC-M02 §6.1 / §4.2 | Computed |
|---|---|
| seed `crc_in` = 0x00000000 is `CRC32(empty)` (note 1) | 0x00000000 — confirmed |
| worked example 1, update 1 intermediate 0x9AE0DAAF | 0x9AE0DAAF |
| worked example 1, update 2 = REQ-303's **0xCBF43926** at `crc_out`, no adjustment | 0xCBF43926 |
| octet packing 0x3837363534333231 for `123456789`'s first eight octets | 0x3837363534333231 |
| worked example 2 residue = REQ-304's **0x2144DF1C** at `crc_out` | 0x2144DF1C at frame lengths 60, 46, 26, 9 and 1500 — one value, not five |
| M04's decomposition: 60 octets in eight updates (7×8 + 1×4) | equals the single-shot value |
| M03's decomposition: 64 received octets in eight updates of eight | 0x2144DF1C |
| REQ-302 serial equivalence for every `octet_count` 1…8 | 0 failures in 3000 random cases |
| note 3 conversions 0x340BC6D9 and 0xDEBB20E3 | both reproduce; a further bit reversal gives requirements.md §4's 0xC704DD7B |

The convention is right, and not merely internally consistent. What I was
hunting was the **seed**, not the constants: REQ-301 says the initial value is
0xFFFFFFFF and SPEC-M02 says a caller drives 0x00000000, and a test writer who
takes REQ-301's number as the port seed builds a bench that fails a conformant
M02 on its first vector. Both numbers are individually correct — only their
pairing would be wrong — which is the same defect class as the two wrong
constants in the WO-0002 text, one level down and less visible. The spec guards
it in three places (§4.2's `crc_in` row, §6.1 note 1, and the explicit "this is
not a contradiction of REQ-301" sentence) and gives the reason rather than the
rule, which is what makes the guard survive being excerpted.

It is also the convention DV should want: it makes the REQ-305 comparison the
identity `crc_out = reference(crc_in, octets)` with no conversion at either end,
and every conversion is a place an endianness or complement error hides — this
programme has already lost a cycle to exactly that (0xC704DD7B). I confirm the
spec's reading that a `zlib`-shaped table-driven implementation is a cross-check
*of* the reference and never a substitute *for* it: my anchor run under PROTOCOL
§10 and charter §3 will be the bit-serial reference reproducing REQ-303's
0xCBF43926, with `zlib` as a second opinion only.

#### (b) SPEC-M01's `Status` record against requirements.md §12 — EXACT

Checked mechanically as ordered sequences, character for character, not by eye —
twenty-one names is the length at which reading is unreliable and
`error_start_without_terminate` is the name a reader's memory smooths over.
Result: **21 for 21, in §12's order, no missing strobe, no extra field, no
duplicate, no reordering** (`diff` of the two extractions is empty; Evidence
item 2 of `J-dv_lead-0003`).

I extended the same treatment to everything else with two copies:

- `Config` versus requirements.md §9.1 — twelve fields against twelve rows, in
  order, every width equal (48/32/32/32/32/1/16/1/8/8/1/1), and `ifg` plus the
  `cfg_` prefix makes REQ-802's `cfg_ifg` name true.
- `Eth_header`, `Ip_header`, `Udp_header` versus SPEC-M01 §4.2's field tables —
  identical field lists and widths; every field of every record appears exactly
  once, as §4.2 claims.
- Both §4.1 blocks versus their `ifc_check` lifts — byte identical.

SPEC-M01 §4.2's decision *not* to restate the twenty-one names in the table ("a
second copy of twenty-one normative names is a second place for them to drift")
is the right call, and its consequence is that the record is the only copy, so
the record is what has to be checked by script at every SHA. I am claiming that
script under `tools/` — see C-9.

#### (c) The "not applicable" answers — eleven, ten honest, one unsupported

The failure mode I was looking for is an obligation that lands somewhere real
being answered with a sentence about why this module is special.

**Honest (10).** SPEC-M01 §4.2 (not a port table, but supplies the field tables
that replace it and covers every field exactly once), §4.3, §6.2, §7 — which
answers all five template clauses individually and names where each contract
does live, the form I would like the other eighteen specs to copy — §8 and §9,
which keeps the empty table with an explicit "(none)" row and confronts REQ-008
rather than sidestepping it. SPEC-M02 §4.1's `Source`-without-`Dest` bullet,
§4.3, §5, §6.2 (which is what SPEC-TEMPLATE §6.2 explicitly asks a combinational
module to say), §7's reset and configuration-sampling clauses, §8 and §9.

Two of those I expected to be dodges and they are not, which is worth saying:
**SPEC-M02 §9** could easily have invented a strobe for an out-of-domain
`octet_count` and instead argues why doing so would put a field in the
requirements.md §12 record for a condition §12 does not name; **SPEC-M02 §5**
meets REQ-506's timeouts-must-be-parameters rule head-on and shows it has no
instance here rather than ignoring it. **SPEC-M02 §8** likewise does not use "not
on the stress list" as an excuse to claim no obligation — it names the randomised
REQ-302/REQ-305 equivalence as what actually constrains M02 and notes that M02 is
driven at full arrival rate inside M03's and M04's benches.

**Unsupported (1) — SPEC-M01 §4.1's `create`/`hierarchical` bullet.** The
engineering answer is right: a types-only module has no entry point to declare.
The citation is not. The bullet says REQ-903 and REQ-808 are not applicable and
leans on "REQ-808's own text excludes it" — but REQ-808's exclusion is written
for the emitted-Verilog module list only. REQ-903 reads "Every module in the
inventory SHALL have an `.mli` and a `hierarchical` entry point taking a
`Scope.t`", carries no types-only exclusion, and quantifies over architecture.md
§4's inventory, where M01 is a row. SPEC-M01 §10 has no REQ-903 row, so nothing
else in the spec covers it. And the obligation splits: the `hierarchical` half is
genuinely impossible, but the `.mli` half is not — a types-only OCaml module can
carry one — and the spec does not address that half. Recorded as **C-8**, not a
signature block: the affected check is a repository-surface script at
`P1-module-ready`, no bench derives from REQ-903, and the fix is one clause in
requirements.md, which this work order puts out of scope.

#### Signature decision

Both SIGNED, so the sentence for the orchestrator to transcribe into
`docs/gates/P1-spec-freeze-checklist.md` per PROTOCOL §7, quoted verbatim from
`J-dv_lead-0003`:

> I countersign batch A (SPEC-M01, SPEC-M02) for P1-spec-freeze at 22145b5

#### Dependency this signature carries (SPEC-M02, REQ-010)

Per this packet's instruction I judged SPEC-M02 against the **agreed future
wording** of REQ-010 — the narrowing to frame-carrying *stream* ports naming M02
as the non-stream case, agreed in principle in WO-0006's ACCEPTED entry
(disposition 1) and assigned to batch B — and I am saying so explicitly. Under
that wording SPEC-M02's §3 REQ-010 row, its §4.1 `Source`-without-`Dest` bullet
and its §10 REQ-010 row are correct and my signature covers them. **Under the
literal b4b4cf4 wording they are not, and I would not sign them.** If the
narrowing does not land in batch B, three claims in a frozen SPEC-M02 become
false and their repair is a spec diff plus an ADR under SPEC-TEMPLATE rule 7.
The narrowing changes what the interface compile check quantifies over, which is
why the architect asked for my countersignature on it; this is that
countersignature, given forward.

#### New carry-forwards (C-8 … C-10) — none a condition of the signature

| id | Item | Owner | Must land before |
|---|---|---|---|
| C-8 | REQ-903 quantifies over every inventory module with no types-only exclusion, while SPEC-M01 §4.1 declares `create`/`hierarchical` not applicable citing REQ-808, whose exclusion covers only the emitted-Verilog list. The REQ-903 repository check has no determinable answer for M01. Needs one clause in requirements.md **and** a decision on the `.mli` half — exempt M01 from both halves, or only from `hierarchical`. | architect_docs_lead, rtl_lead | `P1-module-ready` |
| C-9 | SPEC-M01 §10's verification hooks for REQ-802 and REQ-804 name "the interface compile check" as the mechanism for comparing the records against requirements.md §9.1 and §12; an OCaml compile cannot read a markdown table. Editorial: name the script. I own the script — it is the one in `J-dv_lead-0003` Evidence items 2 and 3 — and it lands under `tools/`. | dv_lead (script), architect_docs_lead (hook wording) | first `SO-` citing those hooks |
| C-10 | SPEC-M01 §6.1's `tuser` paragraph drops REQ-013's "solely" ("No Phase-1 module drops or alters a frame because this bit is set on its input"). A monitor writer holding only the M01 excerpt could turn that into a false failure against a requirements.md §0.6 local discard that legitimately suppresses an aborted frame. One word, or one clause pointing at §0.6. | architect_docs_lead | the shared protocol monitor |

Two editorial nits with no ledger id, raised so they are not rediscovered:
SPEC-M02 §6.1 worked example 2 labels frame octets 0–7 "(destination address)"
where the destination address is six octets, so 0–7 is DA plus the first two
source-address octets — the numeric ranges are unambiguous and no test is
affected; and SPEC-M02 §6.3 item 3 sits under "Deliberately unconstrained" while
stating a prohibition (no internal register, ever), whose content belongs in §6.1
or §7 — §10's REQ-306 row already commissions the check, so no coverage is lost.

C-1 and C-4 remain batch-B scoped and were not attempted. I confirm they have no
instance in batch A: neither spec pins a latency constant, so C-1's
ceiling-comparison unit has nothing to bite on, and SPEC-M02 §7 correctly places
the constants at M03 and M04 with M02 contributing zero.

#### Two things I checked rather than assumed

1. **The green run does not discharge SPEC-M01 §11.4.** Run 30727252770
   elaborates the functor application and every hand-written record in both lifts
   — the 21 `Status` fields, the 12 `Config` fields, the three header records,
   and M02's `I`/`O`/`S` — but **no lift names an `Axi64.Source` or `Dest` field
   anywhere outside a comment**, so `hardcaml_axi` v0.17.0's field names remain
   unverified by any compile, exactly as §11.4 predicts. Batch B's M03 lift is
   the first that will name one, and I would like it settled there rather than at
   first bench, because those names are now quoted normatively in text I have
   countersigned.
2. **SPEC-TEMPLATE §11 versus the FROZEN status flip.** A FROZEN spec may not
   carry open questions. Both batch-A specs carry four each, and none of the
   eight closes before batch B or before the gate itself. This checklist's FROZEN
   condition names only (a) a green `ifc_check` run and (b) my countersignature,
   so satisfying both does not by itself make the DRAFT → FROZEN flip legal under
   the form the auditor checks against. Architect and orchestrator to reconcile —
   the specs stay DRAFT with the countersignature banked, or the questions close,
   or the gate text says which rule governs. Not a reason to withhold, and not
   mine to resolve; flagged because my signature is one of the two named
   conditions and I will not have it read as endorsing a flip the template
   forbids.

#### DoD check against this packet

- Both specs judged, verdict per spec: yes — SIGNED and SIGNED.
- The three named items judged explicitly: yes — (a), (b), (c) above.
- Countersignature decision explicit either way: yes, affirmative, with the
  sentence quoted verbatim from `J-dv_lead-0003` for transcription.
- No edits outside this packet and my journal: yes. Nothing under
  `docs/specs/**`, `docs/gates/**`, `test/**`, `tools/**` or `libs/**` was
  written; the C-9 script exists only as the commands in `J-dv_lead-0003`
  Evidence and will land under `tools/` with my bench-setup work order.
- `git commit` / `git push`: never run.

### ACCEPTED — orchestrator, 2026-08-02T05:45Z, journal `J-orchestrator-0038`

Both signatures transcribed to the gate table. Dispositions:
1. §11/FROZEN conflict: AGREED — the flip would be illegal under the form
   the auditor checks. Resolution assigned as WO-0008's first
   deliverable: SPEC-TEMPLATE §11 amended so a FROZEN spec may carry no
   OPEN questions but may cite tracked ledger/WO items; both batch-A
   specs' §11 converted accordingly (C-10 folded in). Batch A flips
   FROZEN at WO-0008 acceptance.
2. §11.4 field-name gap: noted and scheduled — WO-0008's M03 lift names
   Source fields; the run on that commit settles it.
3. C-8/C-9/C-10 added to the ledger with deadline gates as proposed.
4. Bench-setup WO: AGREED and issued as WO-0009, running in parallel
   with WO-0008 (disjoint write scopes: test/** + tools/** vs
   docs/specs/**).
