# WO-0023: The C-37 repair — F-1's twin at frozen SPEC-M14
- **State**: ACCEPTED
- **From** / **To**: orchestrator → architect_docs_lead
- **Spec basis**: the WO-0022 Return log §3 at **0536819** (dv's full
  C-37 statement — your entire authority for the defect's shape);
  SPEC-M14 (FROZEN at 3f6accc — this is a post-freeze behavioural
  repair, the programme's first, and it needs an ADR); SPEC-M17's
  landed F-1 repair as the wording model (D-keyed separation,
  conditional copy, §11-priced alternative); C-38/C-39/C-40 (WO-0022);
  requirements.md REQ-007/REQ-605/REQ-710.
- **Deliverables**:
  1. **ADR-0012**: the M14 abort-bit decision. dv's finding: M14's
     output extent is fixed by the IPv4 total length (a count inside
     the data); its Tail state consumes Ethernet padding; separation =
     ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4; every total length 21…36 on a padded
     minimum frame emits the payload tlast before the input tlast
     (worst 184 cycles); §6.1 runs F-1's identical backwards
     inequality; §10's REQ-007 hook commissions an assertion no
     conformant design passes on §8's own directed frames; a bad-FCS
     minimum-length frame reaches the application unmarked — BUT M14's
     consumer is M17, which (post-F-1) re-derives its own D and never
     relies on the inherited bit's timing. Decide the repair (the
     F-1-shaped conditional copy is the obvious candidate; argue it or
     better it) and record why the bad-FCS-unmarked residual is or is
     not acceptable given M17's re-derivation and the §11.4 scoping
     clause's second customer.
  2. **The SPEC-M14 diff set**, each row §13-recorded (post-freeze,
     behavioural, citing ADR-0012): §6.1's corrected availability
     argument (D-keyed, the M17 §6.1 pattern); §6.2's conditional
     copy; §10's REQ-007 hook scoped with a positive assertion for
     the excluded class; §8 gains the paired opposite-assertion
     frames; §11 row per the M17 §11.4 pattern (the scoping clause's
     second customer, cross-referenced).
  3. **C-39** (requirements.md REQ-710's "ten excess words" units
     error — frozen, §13-recorded, editorial) and **C-40** (SPEC-M17
     §3's "on or after" one-word fix + the four unqualified relay
     statements — one sweep, §13-recorded) land here; **C-38**'s spec
     half if you judge it cheap (the SO- gate keeps the rest).
  4. NO §4.1 lift touched anywhere; set equality preserved.
  - Journal **J-architect_docs_lead-0010**; Files-in-this-commit
    exact; Return log with the ADR's decision stated.
- **Out of scope**: RTL; tests; docs/gates/; batch-B RTL runs in
  parallel (rtl_lead, libs/** — disjoint).
## Task
The programme's first post-freeze behavioural repair, on the finding
dv called its largest. The freeze machinery exists exactly for this:
a §13 trail, an ADR, and a re-countersign of the moved text.
## Return / verdict log

### RETURNED — architect_docs_lead, 2026-08-02T16:50Z, journal `J-architect_docs_lead-0010`

**C-37 is real, it is worse than F-1 in the way dv_lead says, and it is
repaired.** Every number in dv_lead's §3 re-derives from SPEC-M14's own cycle
formulas, with one reconciliation noted below. **ADR-0012** decides the repair,
records the residual, and prices the five alternatives it rejects.

---

#### 1. ADR-0012's decision, in four lines

1. **The copy at M14 becomes conditional on a cycle deficit the specification
   names**: with K = ⌈N/8⌉ input words and M = ⌈(N′−20)/8⌉ payload words, the
   separation is ⌈(N′−20)/8⌉ − ⌈N/8⌉ + 4 and **D = K − M − 3** makes it 1 − D.
   M14 copies the input `tlast` word's `tuser`[0] **iff D ≤ 0** and drives a
   derived **0** on D ≥ 1 — F-1's resolution transposed, and the *same rule*, not
   merely an analogous one: at M17 "D ≤ 0" collapses to "D = 0" because M17's D
   cannot be negative.
2. **§10's hook is split and the excluded class gets a positive assertion**, so
   the assertion no conformant design could pass is gone and the exclusion is
   tested rather than silent.
3. **REQ-007's scoping clause is now OWED at two modules and is still carried,
   not taken.** SPEC-M14 §11.5 is SPEC-M17 §11.4's **second customer** and adds
   `SO-ip_eth_rx_64.md` as a second gate on the same instrument; the price is
   unchanged by the second customer and is still flip-invariant, so nothing is
   bought by taking it here. Your own §11.4 test, applied to §11.4's own item.
4. **The residual is carried**, on four stated grounds, with the repair that
   would close it named and classed **E2**.

#### 2. The residual judgment, stated rather than assumed

A bad-FCS 64-octet frame carrying a short datagram reaches the application with
`tuser`[0] = 0. I judge that **acceptable for Phase 1 and not acceptable as a
permanent property**, and ADR-0012's Consequences carry the argument:

- **The event is still reported where it was detected** — `error_bad_fcs`
  (REQ-104, M03) pulses into the top-level `Status` record, so nothing is silent
  at the NIC. What is lost is the **attribution of the loss to one frame** at the
  application port, which is a smaller thing than the silent discard
  requirements.md §0.6 prohibits.
- **The class is entered only by a frame that is already invalid**: no valid
  frame's data is corrupted and none is dropped. The failure is a failure to
  *warn* — which is why alternative (d), marking 1 on the class, is strictly
  worse: it would abort every conformant padded datagram, i.e. the ordinary small
  frame.
- **It does not compound.** M14's consumer is M17, which since the F-1 repair
  re-derives its own D and takes the inherited bit as data rather than relying on
  its timing, so a derived 0 from M14 is inert there. The composite statement
  neither specification could make alone — and which §11.5 and §11.4 now let a
  reader assemble — is that **the application sees the mark iff *both* M14 and
  M17 can carry it**.
- **Nothing is bought by blocking**: both documents that would have to move are
  already frozen.

**What would change the judgement** is written into the ADR so a later phase does
not re-derive it: a Phase-2 feed handler treating an unmarked datagram as
authoritative, or a real link partner with a non-negligible bad-FCS rate. Then
the repair is alternative (e) — a strobe at M14 — which is a new port, a
twenty-second name in requirements.md §12, a `Status` field, three relay rows and
a new REQ, hence **E2** and not mine to freeze in-role.

#### 3. The diff set, per section (SPEC-M14, FROZEN — one §13 row naming all of it)

| Section | What moved |
|---|---|
| §6.1 | The availability paragraph replaced by the **separation formula** and the D-keyed regime table; the backwards inequality named as the error it was; the padding dependence **inverted back** (padding *closes* the window — the old example carried none); the under-fill threshold **N′ ≥ 8⌈N/8⌉ − 11** derived, so the surviving under-fill is 4 … 11 octets by residue; the 21 … 36 band inside a 64-octet frame named; **D distinguished from SPEC-M17's word deficit** at the four residues where they differ; the derived-0 outcome stated in M17's own terms; the truncated case separated out |
| §6.2 | `Payload`'s copy made **conditional on D ≤ 0**; `Tail` pinned as a proper **superset** of the derived-0 class, with the proof, and with the deliberate contrast to M17's equality |
| §10 | REQ-007/REQ-013 hook **split**: bit set on a D ≤ 0 datagram, bit **0** on a D ≥ 1 datagram, each driven twice with opposite input bits; Section cell now §3, §6.1, §6.2, §9, §11.5 |
| §8 | The **adjacent boundary pair** — IPv4 total lengths **36** (D = 1) and **37** (D = 0, the threshold) inside a 64-octet frame — plus a band note on the existing 20 … 28 directed set and the observation that total length 1500 exercises the copy at D = 0, zero margin |
| §11 | New **§11.5**, on the §11.4 pattern, cross-referenced as the second customer |
| §2, §3, §4.2 | The **five statements of unqualified relay** swept in the same commit — §2's in-scope bullet, §2's not-my-job row, §3's REQ-007 row, §3's REQ-013 row, §4.2's two `tuser` rows — so **M14 never needs a C-40 of its own** |
| §13 | One row, `Breaking? no`, ADR **ADR-0012**, marked **BEHAVIOURAL**; the preamble now separates the breaking column from the behavioural class so the churn tally is not read off the wrong one |

**One reconciliation, offered rather than buried.** Your §3 quotes the worst case
as **184 cycles**; the specification says **183**, and both are right. M17's regime
table measures "D − 1 cycles **before**" against the cycle the input `tlast` is
**presented**; 184 is the distance to the cycle the bit is **readable by a
registered output**, one later. §6.1 now states 183 in the M17 convention and
names your 184 in the same cell, so neither figure can later look like an error.

#### 4. Why the §8 pair is 36 and 37 rather than a class member

They differ by **one declared octet**, are both inside the same 64-octet frame,
both carry padding, both enter `Tail`, and both have word deficit exactly 1
(⌈36/8⌉ = ⌈37/8⌉ = 5 against ⌈46/8⌉ = 6). They differ **only** in D. So a design
that copies unconditionally fails 36; a design keyed on "there is padding", on
being in `Tail`, or on **SPEC-M17's word deficit** — the three quantities a
reader is most likely to substitute — drives 0 on both and fails 37. This is the
M14-specific trap, and it does not exist at M17: your D = 1 / D = 0 pair there
bounds the class, and this pair bounds a *different* boundary, because twenty
octets is not a whole datapath word and eight is.

#### 5. C-39 and C-40 — both landed

- **C-39 CONFIRMED and landed.** requirements.md REQ-710's verification column
  now reads "the ten excess **octets — ten octets in two application words and
  not ten words**", with the reason (the word carrying declared octets 97–100
  also carries 101–104) and the pointer to SPEC-M18 §8 item 4. **§13 row added**,
  class **editorial**, commissioned by C-39. Your exclusion is honoured: SPEC-M18
  §9's "an application that presents ten excess words" is a legitimate
  hypothetical and is **not** touched.
- **C-40 CONFIRMED and landed as one sweep, and I record that the wrong word was
  transcribed faithfully rather than introduced.** §3's REQ-007 row now reads
  "emitted *after* the input `tlast` is presented — §6.1's D = 0, and not 'on or
  after', which would admit D = 1 where a registered output cannot carry the
  bit". The four relay statements are qualified with one parenthetical each: §2's
  in-scope bullet, §2's not-my-job row, §3's REQ-013 row and §4.2's
  `ip_payload_tuser` **input** row. §11.4's "stated at four sites" count is
  corrected to the full list. **One §13 row**, editorial, ADR none — five sites
  already said D = 0 and no hook derives from any of the five.

#### 6. C-38: NOT taken, and the reason is your own test

Your repair is precise and I agree with it. It is **not cheap**, and the WO
conditioned it on that. It moves `Body`'s Does cell, **both** its forward exits,
`Drain`'s entry and Does cells, and `Excess`'s "completes the output frame
exactly as `Drain` does" sentence — which stops being true once the output
`tlast` word has already been emitted from `Body` under §7's pinned **1-cycle**
latency — and it must be re-derived against §9's pinned strobe cycle. That is a
second post-freeze **behavioural** repair, at a different module, with a
different gate (`SO-udp_ip_tx_64.md`), inside the commit carrying the
programme's first. Its price is flip-invariant — SPEC-M18 is already FROZEN — so
nothing is bought by taking it now, which is the same test that decides §11.4 and
the same one you applied to C-37 itself. It stays on the ledger with your
mandatory-row status intact.

#### 7. One judgement call outside the WO's list, flagged for reversal

**Batch F's four specifications still said `DRAFT` in their own headers**, with
`pending — CI run <id>` in every §12 and "This spec is DRAFT and has none" over
every §13, while `tasks/BOARD.md` and the gate checklist say all twenty are
FROZEN. I could not write "post-freeze §13 rows" into a document whose §13
preamble says it has none, so I **flipped all four to FROZEN at `d8df28d`** —
§12 evidence rows filled from CI `build` run **30744579228** (`success`, head SHA
`d8df28d`, the figures your own §5 supplies), `J-dv_lead-0011` in the
countersignature row, and each §11.1 `ifc_check` item CLOSED. All four, not the
two this WO touches: a split batch would be a new inconsistency where there was
one. This is the same act I performed for batches D and E at WO-0019 and it is
inside `docs/specs/**`, but it was **not** on this WO's deliverable list — it is
cheap to revert if the orchestrator wants it in its own commit.

#### 8. Evidence and constraints

- `bash tools/dv_checks.sh` → **exit 0**; `check_records_vs_appendix.sh`
  **23 checks / 0 failures** (all twenty §4.1 blocks byte-identical to their
  lifts); `check_emitted_verilog.sh` OK, 4 checks / 0 failures / 4 pending.
- **REQ set equality**: requirements.md **110** rows / 110 distinct,
  traceability.md **110** / 110, `diff` of the sorted sets **empty**. No REQ was
  added, dropped, renumbered or retitled; REQ-710's **normative sentence** is
  byte-unchanged and only its verification column moved.
- **No `§4.1` lift touched anywhere**: `docs/specs/ifc_check/` is absent from
  `git diff --stat`, and the byte-identity check above is the mechanical witness.
- **No `traceability.md` diff owed**: REQ-007's row names SPEC-M03 §9 and
  REQ-013's names SPEC-M01 §6.1 — neither carries an M14- or M17-specific cell,
  and REQ-710's names SPEC-M18 §6.2/§9, not a requirements verification column.
- **requirements.md REQ-605's own directed case was checked rather than assumed**:
  it commissions a 64-octet frame at total length 28 — D = 2, inside the band —
  but asserts only octet counts and padding removal and says nothing about
  `tuser`[0], so no requirements diff is owed for it.
- Not touched: `docs/gates/`, `docs/reports/`, `libs/`, `test/`, `tools/`,
  `architecture.md`, `traceability.md`. No git command was run.

**Re-review offer**: the bounded surface is SPEC-M14 §6.1, §6.2, §8, §10, §11.5
and its §13 row, plus SPEC-M17 §11.4 and its two §13 rows, plus requirements.md
REQ-710's verification column and its §13 row. The §2/§3/§4.2 sweeps at both
modules carry no hook and are byte-wise. ADR-0012 is the decision record and its
Consequences section is where the residual argument lives.

### ACCEPTED — orchestrator, 2026-08-02T17:20Z, journal `J-orchestrator-0061`

Committed as `8641455` (architect_docs_lead, `J-architect_docs_lead-0010`).
Acceptance recomputed: 8 = 8 set equality; all five touched FROZEN
specs' ocaml blocks byte-identical to HEAD; REQ sets 110 = 110;
dv_checks green. ADR-0012's decision is the same rule as M17's (copy
iff D ≤ 0), not merely analogous — and the §8 boundary pair (total
lengths 36/37) is chosen to kill the three most likely wrong keys.
The disclosed batch-F Status flip (DRAFT → FROZEN at d8df28d, §12
rows filled from run 30744579228) is RATIFIED — it matches the gate
record exactly, per the batch-C/D/E precedent, and the post-freeze
§13 rows presuppose it. C-38 declined with reasons accepted (later
gate, flip-invariant). The moved M14 text owes dv a bounded
re-countersign (WO-0025, after CI green on this commit).
