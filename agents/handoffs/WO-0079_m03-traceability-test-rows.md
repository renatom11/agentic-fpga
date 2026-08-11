# WO-0079: The M03 test-side traceability rows — the delivery `SC-2`'s third clause names, for transcription into `docs/specs/traceability.md`

- **State**: **ACCEPTED — TRANSCRIBED IN FULL, 34 of 34 cells, nothing refused**
  (§8, `J-architect_docs_lead-0035`). The number is no longer a placeholder: the
  orchestrator allocated `0079` when this packet landed at `a43ac00`, so the
  paragraph below is preserved as the record of how it was drafted, not as a live
  caveat.
  **`0079` is a PLACEHOLDER**: it is the next free number per prefix measured over
  `agents/handoffs/` at `a851948` (highest landed: `WO-0078`), and the orchestrator's
  allocation at first commit governs (PROTOCOL §3). **No sentence of this packet's body
  depends on the number**, so a re-allocation renames the file and moves nothing.
- **From** / **To**: **dv_lead → architect_docs_lead**, via the orchestrator.
  PROTOCOL §3's table makes a lead an admissible consumer of a `WO-`; no new packet
  prefix is minted for this and none is needed.
- **Round class**: **delivery**. It hands over a mapping. It adjudicates nothing, it
  re-opens no verdict, and it is **not** a re-issue of `SO-xgmii_rx_64.md`.
- **Carrier of**: **`FINDING SO-1` (MAJOR, dv_lead, against its own design round)**,
  filed at `SO-xgmii_rx_64.md` §2.8 and named as act 1 of two at §8.2:

  > **CARRIER, named rather than left open**: a dv_lead round that drafts the test-side
  > rows for SPEC-M03 §10's hooks — REQ id, the `M03-` rows that attack it, the landed
  > unit each row is discharged by — as a packet in `agents/handoffs/`, delivered to
  > architect_docs_lead for transcription into `docs/specs/traceability.md`, which
  > dv_lead cannot stage (PROTOCOL §6).

- **Spec basis** (the derivation's whole spec side): `docs/specs/modules/xgmii_rx_64.md`
  **§10** (the hook table — the row set this packet is the slice of), with §4.1, §4.3,
  §6.1, §6.2, §6.3, §7, §8 and §9 read where a hook's text points at them;
  `docs/specs/requirements.md` REQ-003 … REQ-021, REQ-101 … REQ-113, REQ-802, REQ-808,
  REQ-810, REQ-901, REQ-903; `docs/specs/traceability.md` (the target file's own rules,
  its `Status` vocabulary and its `Open dependencies` §3 and §4).
- **Plan basis**: `test/attack_plans/AP-xgmii_rx_64.md` — **§6** (the coverage map), the
  **§4** row tables' `Attacks` and `Status` cells, **§1** (the six-value status
  vocabulary), **§2** (the standing obligations), **§0.1** (the set-claim rule this
  packet obeys at every figure).
- **Suite basis**: the `let%expect_test` units of `test/xgmii_rx_64/` and, at exactly one
  cited bound, `test/xgmii/test_idle_injection.ml`.
- **Independence** (PROTOCOL §10, charter §3): **no `libs/**`, `top/**` or
  `rtl_snapshots/**` path appears in this packet's derivation chain**, and none was
  opened to write it. The mapping is spec → plan → suite and never design → test.
- **Measurement SHA**: **`a851948`**. Every count below was measured at it, by the
  command printed beside it.
- **Drafted / signed**: **`J-dv_lead-0166`**, dv_lead.

---

## 0. What this packet is, and the four things it does not do

**It is the mapping.** Column 6 (`Test(s)`) and column 7 (`Status`) of
`docs/specs/traceability.md`, for the **34 rows SPEC-M03 §10 hooks**, in a form that can
be pasted cell for cell. `docs/specs/**` is architect_docs_lead's write scope and not
dv_lead's (PROTOCOL §6), which is why this is a packet and not an edit.

1. **It does not touch `docs/specs/traceability.md`, or any `docs/**` byte.** The
   transcription is architect_docs_lead's act, under its own trailer.
2. **It does not re-issue, amend or re-read `SO-xgmii_rx_64.md`.** That packet is
   `ISSUED — EXECUTED` with `FAIL` at `2183d71` and is not edited in place; §8.2 says the
   re-read happens **after both** of its two acts, and act 2 (the other four harvests) is
   the orchestrator's dispatch, not mine. **This packet pays act 1 and says so; it does
   not claim `SC-2` is met**, because a criterion is adjudicated by a re-read against §1
   at a later SHA and not by the artefact that supplies it.
3. **It lifts nothing and re-statuses no `AP-M03` row.** No bar moves, no class is
   anchored, no discharge count changes. Where a bound exists it is restated, never
   summarised (§5).
4. **It runs no simulation.** `dune runtest` cannot execute in this container (ADR-0005);
   the pass evidence is a CI run id, marked as an externally verifiable reference
   (ADR-0003/F5), and §2.3 states the bound in terms.

---

## 1. THE DOMAIN — which of the 110 matrix rows are M03's, and which are not

**Polarity discharged before anything else**: the claim below is that certain rows are
**outside** this delivery, so it is measured over **every** row of the matrix, not over
the rows I remember being M03's.

```
$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             if(t=="") e++} END{print n, e}'  docs/specs/traceability.md
110 110                     (110 REQ rows; 110 empty Test(s) cells, still, at a851948)

$ awk '/^## 10\./{f=1} f&&/^## 11\./{f=0} f' docs/specs/modules/xgmii_rx_64.md \
    | awk -F'|' '/^\| REQ-/{print $2}' | grep -oE 'REQ-[0-9]+' | sort -u | wc -l
34                          (the hook set: the LEFT column of §10's table)

$ awk -F'|' '/^\| REQ-/{if ($5 ~ /M03/) {r=$2; gsub(/ /,"",r); print r}}' \
    docs/specs/traceability.md | wc -l
14                          (rows naming M03 in the Owning module(s) column)
```

**The hook set is 34 and not 35, and the difference is stated rather than left to be
re-derived.** A whole-section `grep -oE 'REQ-[0-9]+'` over SPEC-M03 §10 returns **35**,
because `REQ-010` appears **only inside REQ-014's own cell** as a cross-reference
(*"M03's input is an XGMII lane pair, which has no `tstrb` to vary (REQ-010 class (b))"*)
and is not a hook of its own. **34 is `SO-xgmii_rx_64.md` §2.8's own figure** for this
delivery (*"a §2.8 table of 34 REQ→row mappings"*) and this packet reproduces it by
measurement rather than by quotation.

### 1.1 The three tiers, and why the matrix cannot be filled the same way in all three

| tier | rows | what this delivery supplies | recommended `Status` |
|---|---|---|---|
| **A — M03 owns the row whole** | **13**: REQ-101 … REQ-113 | the complete test-side content of the cell | **`COVERED`** (§2.3's pass evidence) |
| **B — programme invariant, M03 restates it** | **16**: REQ-003, 004, 005, 007, 008, 009, 011, 012, 014, 015, 016, 017, 018, 019, 020, 021 | **M03's contribution only**, prefixed `M03:` in the cell | **`OPEN`** — see below |
| **C — hooked here, owned elsewhere** | **5**: REQ-802 (M20), REQ-808 (M20), REQ-810 (M20 + M03 + M04 + M18), REQ-901 (programme), REQ-903 (programme) | **M03's half only**, prefixed `M03:` | **`OPEN`** |
| **outside this delivery** | **76** | nothing — they stay pending their own `SO-` rounds | unchanged |

**13 + 16 + 5 = 34; 110 − 34 = 76.** The 76 decompose as: **5** programme invariants
SPEC-M03 §10 does **not** hook (REQ-001, REQ-002, REQ-006, REQ-010, REQ-013) + **10**
XGMII transmit + **6** CRC-32/FCS + **10** Ethernet framing + **12** ARP + **12** IPv4 +
**10** UDP + **7** remaining top-level + **4** remaining verification/process = **76**.
**Every one of them stays `OPEN` with an empty `Test(s)` cell, and this packet asks for
no edit to any of them.** M04's, M02's, M06's … rows are their own modules' sign-off
rounds' to deliver, on this same form.

### 1.2 Why tier B and tier C stay `OPEN` even though their cells gain content

**This is the matrix's own rule and not a judgement of mine.** `traceability.md` says:

> Programme invariants (REQ-001 … REQ-021) are owned by every module; their row records
> the *system-level* test, and each module spec restates the invariant in its own
> REQ-coverage table.

and, at `Open dependencies` item 3:

> **System-level rows**: REQ-001 … REQ-021 and REQ-801 … REQ-810 are expected to be
> covered by `nic_top` system tests plus per-module restatements; the architect and
> dv_lead agree the split at the first module-ready gate.

**So a `COVERED` on an invariant row is a claim about the system, which one module's
bench cannot make.** The `M03:` prefix is what keeps a partial cell from reading as a
whole one. **I am not proposing a new `Status` value** — the vocabulary is
`OPEN`/`COVERED`/`GAP`/`WITHDRAWN` and it is architect_docs_lead's to extend, by its own
process, if it wants a `PARTIAL`. If it does, these 21 rows are its candidate set and
this packet is the evidence; if it does not, `OPEN` with a populated cell is honest and
costs nothing.

**And this packet is `Open dependencies` item 3's occasion.** The split it says the
architect and dv_lead agree at the first module-ready gate is proposed here concretely,
per row, so the gate can ratify a measured thing rather than negotiate one.

---

## 2. THE FORM — what to paste, and what the citations mean

### 2.1 The citation atom

Every entry in a `Test(s)` cell has the shape

> `M03-<row> → <path>:<line>`

where `<path>:<line>` names the **`let%expect_test` unit** whose title carries that row
id. **The unit's title is its test name**; titles in this suite run to several lines, so
they are not repeated inside the matrix cell — **§4 is the unit register** and prints all
of them in full, once. A reader checking a cell reads the row id in the plan, the
`file:line` in the suite, and §4's title to see they are the same unit.

**Two entry forms are not `file:line`, and both say so in the cell**:

- **`— STRUCTURAL: <what checks it>`** — discharged by a compile-time or script check,
  not by a waveform (`AP-M03` §1's status vocabulary). Named so no reader takes it for a
  behavioural test.
- **`GAP: <reason>`** — the form `traceability.md` itself prescribes.

### 2.2 The homing rule, stated because it decides what is NOT in a cell

**A landed row is cited in the cell of the REQ that `AP-M03` §6 homes it under, and its
incidental attacks on other requirements are not re-cited.** `M03-L5`'s `Attacks` cell
names REQ-103, for instance, because directed lengths necessarily extract frames — but §6
homes it at REQ-005 and REQ-111, and citing it three times would make one observation
look like three. **§6's homing is the tie-break, and §3's provenance column names it for
every row.** The two places where §6 homes a landed row **nowhere at all** are §6.1's
finding, and this delivery homes them explicitly rather than silently.

### 2.3 What `COVERED` rests on — the pass, its run id, and its bound

```
$ git diff --quiet 2183d71..a851948 -- test/ tools/ docs/specs/ ; echo $?
0                          (the suite, the tooling and the specs are byte-identical
                            between the sign-off SHA and this packet's SHA)
```

**So the sign-off SHA's CI evidence covers the suite as it stands here**: `build` run
**`31444471834`**, job **`93635620822`**, `head_sha` `2183d71`, conclusion **`success`**,
**all 13 steps `success`** — including step 6 *"Run tests"*, step 8 *"Verify nothing was
left unpromoted or non-deterministic"* and step 9 *"DV mechanical checks"*, which is where
`tools/dv_checks.sh` and therefore `tools/check_emitted_verilog.sh` run.

**The bound, declared rather than glossed**: `opam exec -- dune runtest` **cannot be
executed in this container** (ADR-0005 — the Hardcaml toolchain is absent). The pass is an
**externally verifiable reference** in ADR-0003/F5's sense, and it is marked as one here
and in `J-dv_lead-0166`'s Evidence. **A `COVERED` cell therefore rests on a run id, never
on a local green**, which is the same discipline `SC-3` fixed for the sign-off itself.

---

## 3. THE ROWS — transcribe columns **Test(s)** and **Status** cell for cell

**Columns 1–5 of `docs/specs/traceability.md` are untouched by this packet and are not
reproduced**, deliberately: a delivery that re-prints the architect's own cells invites a
paste that overwrites them. **Only the two columns dv_lead owns or advises on are
given.** The fourth column below is **provenance and is NOT transcribed** — it is what
lets the architect check the cell against the plan and the suite without asking me.

### 3.A Tier A — the thirteen rows M03 owns whole

| REQ | **`Test(s)`** — paste verbatim | **`Status`** | provenance (NOT transcribed) |
|---|---|---|---|
| REQ-101 | M03-A1, M03-A2 → test/xgmii_rx_64/test_m03_a.ml:80; M03-A3 → test/xgmii_rx_64/test_m03_a.ml:153 | COVERED | SPEC-M03 §10 REQ-101 hook → AP-M03 §6 (M03-A1, A2, A3, A4) → units. **M03-A4 is `NO-ASSERT`** and is declared inside `:153`'s own title: it names the property a bench must **not** assert (cross-lane absolute-cycle equality), so it contributes no test name |
| REQ-102 | M03-B1 → test/xgmii_rx_64/test_m03_b.ml:93; M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-B3 → test/xgmii_rx_64/test_m03_b.ml:907; M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-N2 → test/xgmii_rx_64/test_m03_n.ml:698, :708, :718, :728, :739, :749 | COVERED | AP-M03 §6 (M03-B1…B4, N2, N3). **M03-N3 is `NO-STIMULUS`** — §5 bound 6. B2's three members are `/E/`, `/I/`, `/Q/`; B4's two are the lane-0 and lane-4 placements; N2's six are §4.N rows 1–6 |
| REQ-103 | M03-C1 → test/xgmii_rx_64/test_m03_c.ml:338; M03-C3 → test/xgmii_rx_64/test_m03_c.ml:467; M03-C5 → test/xgmii_rx_64/test_m03_c.ml:408; M03-E1 → test/xgmii_rx_64/test_m03_e.ml:353; M03-F1 → test/xgmii_rx_64/test_m03_f.ml:304; M03-G1 → test/xgmii_rx_64/test_m03_g.ml:534; M03-H1 → test/xgmii_rx_64/test_m03_h.ml:378 | COVERED | AP-M03 §6 (C1, C3, E1, F1, G1, H1) **+ M03-C5, homed here by this delivery** — `FINDING SO-1-A`, §6.1. C5 is the `BUG-0001` / prediction `P-1` probe at 1513 and 1516 octets, landed and green, and §6 homes it nowhere |
| REQ-104 | M03-D1 → test/xgmii_rx_64/test_m03_d.ml:176; M03-D2 → test/xgmii_rx_64/test_m03_d.ml:414; M03-D3 → test/xgmii_rx_64/test_m03_d.ml:468; M03-M2 → test/xgmii_rx_64/test_m03_g.ml:534; M03-M3 → test/xgmii_rx_64/test_m03_e.ml:353; M03-M4 → test/xgmii_rx_64/test_m03_h.ml:378; M03-M10 → test/xgmii_rx_64/test_m03_f.ml:492, test/xgmii_rx_64/test_m03_b.ml:907 | COVERED | AP-M03 §6 (D1–D4, M2, M3, M4, M10). **M03-D4 is `NO-ASSERT`** (residue-versus-capture is unobservable, §6.3 item 1). The four `M` rows are §9's co-occurrence rulings and are carried **inside** the units named, which is why those `file:line` repeat. **Bounds 1, 2 and 4 of §5 apply to this row** |
| REQ-105 | M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-E1 → test/xgmii_rx_64/test_m03_e.ml:353; M03-E2 → test/xgmii_rx_64/test_m03_e.ml:490; M03-E4 → test/xgmii_rx_64/test_m03_e.ml:609; M03-E5 → test/xgmii_rx_64/test_m03_e.ml:799; M03-G4 → test/xgmii_rx_64/test_m03_g.ml:1003; M03-G8 → test/xgmii_rx_64/test_m03_g.ml:1696; M03-M5 → test/xgmii_rx_64/test_m03_h.ml:609; M03-M7 → test/xgmii_rx_64/test_m03_g.ml:1003, :1696; M03-N1 → test/xgmii_rx_64/test_m03_n.ml:959 | COVERED | AP-M03 §6 (B2, E1–E4, G4 second epoch, G8 first epoch, M5, M7, N1) **+ M03-E5, homed here by this delivery** — `FINDING SO-1-A`. **M03-E3 is `NO-ASSERT`** (§5 bound 5) |
| REQ-106 | M03-C1, M03-C2 → test/xgmii_rx_64/test_m03_c.ml:338 | COVERED | AP-M03 §6 (C1, C2). Both rows are discharged by the one unit, whose title names both |
| REQ-107 | M03-B3 → test/xgmii_rx_64/test_m03_b.ml:907; M03-F1 → test/xgmii_rx_64/test_m03_f.ml:304; M03-F2 → test/xgmii_rx_64/test_m03_f.ml:492; M03-F3 → test/xgmii_rx_64/test_m03_f.ml:653; M03-F4 → test/xgmii_rx_64/test_m03_f.ml:801; M03-F5 → discharged by citation to M03-C4 (test/xgmii_rx_64/test_m03_c.ml:556) and M03-F1's 5-octet member, recorded at test/xgmii_rx_64/test_m03_f.ml:811; M03-M1 → test/xgmii_rx_64/test_m03_f.ml:304, :653; M03-M10 → test/xgmii_rx_64/test_m03_f.ml:492, test/xgmii_rx_64/test_m03_b.ml:907 | COVERED | AP-M03 §6 (B3, F1 … F5, M1, M10 — the range is expanded here). **M03-F5 is the suite's one discharge-by-citation** and the cell says so rather than naming a unit that does not exist. **§5 bound 3 (REQ-901 class (e)) rides with this row permanently** |
| REQ-108 | M03-G1 → test/xgmii_rx_64/test_m03_g.ml:534; M03-G2 → test/xgmii_rx_64/test_m03_g.ml:684; M03-G3 → test/xgmii_rx_64/test_m03_g.ml:834; M03-G4 → test/xgmii_rx_64/test_m03_g.ml:1003; M03-G6 → test/xgmii_rx_64/test_m03_g.ml:1186; M03-G7 → test/xgmii_rx_64/test_m03_g.ml:1490; M03-G8 → test/xgmii_rx_64/test_m03_g.ml:1696; M03-M2 → test/xgmii_rx_64/test_m03_g.ml:534; M03-M6 → test/xgmii_rx_64/test_m03_g.ml:834, :1490; M03-M7 → test/xgmii_rx_64/test_m03_g.ml:1003, :1696 | COVERED | AP-M03 §6 (G1 … G8, M2, M6, M7 — range expanded). **M03-G5 is `NO-ASSERT`** (the internal state after absorbing an `/E/` in `Discard` is not asserted; §6.3 item 6). G1/G3/G4 drive REQ-108's window **after** the frame's own terminate, G7/G8 **before**, G6's frame has no terminate at all. **§5 bound 3 (class (f)) rides permanently** |
| REQ-109 | M03-I1 → test/xgmii_rx_64/test_m03_i.ml:397; M03-I2 → test/xgmii_rx_64/test_m03_i.ml:977 | COVERED | AP-M03 §6 (I1, I2). I2 carries three members, the third closed by its own `/T/` with zero octets received |
| REQ-110 | M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-G3 → test/xgmii_rx_64/test_m03_g.ml:834; M03-G7 → test/xgmii_rx_64/test_m03_g.ml:1490; M03-H1 → test/xgmii_rx_64/test_m03_h.ml:378; M03-H2 → test/xgmii_rx_64/test_m03_h.ml:808; M03-H3 → test/xgmii_rx_64/test_m03_h.ml:609; M03-H4 → test/xgmii_rx_64/test_m03_h.ml:1047; M03-M4 → test/xgmii_rx_64/test_m03_h.ml:378; M03-M5 → test/xgmii_rx_64/test_m03_h.ml:609; M03-M6 → test/xgmii_rx_64/test_m03_g.ml:834, :1490; M03-N2 → test/xgmii_rx_64/test_m03_n.ml:698, :708, :718, :728, :739, :749; M03-N4 → test/xgmii_rx_64/test_m03_n.ml:1450 | COVERED | AP-M03 §6 (B4, H1 … H4, M4, M5, M6, G3 second epoch, G7 first epoch, N2, N4 — range expanded). **§5 bounds 7 and 8 apply**: N2's six sub-cases are never §9-ruling-9 coverage, and the zero-delivered REQ-110 abort under a disabled receive path has **no instance at M03** |
| REQ-111 | M03-L2 → test/xgmii_rx_64/test_m03_l.ml:258; M03-L5 → test/xgmii_rx_64/test_m03_l.ml:361 | COVERED | AP-M03 §6 (L2, L5). **§5 bound 9**: constancy is judged **per front-offset class** (L = 16 at lane 0, L = 12 at lane 4), never as one L across a two-lane run |
| REQ-112 | M03-L1 → test/xgmii_rx_64/test_m03_l.ml:258; M03-L6 → STRUCTURAL: no `tready` input exists on the stream under test (SPEC-M03 §4.1, interface compile check) | COVERED | AP-M03 §6 (L1, L6). **§5 bound 10**: *"zero rx backpressure asserted"* is discharged **structurally, not observed** — there is no signal a consumer could assert. This is `SO-` `SC-4`'s own declared bound and it must not be lost in transcription |
| REQ-113 | M03-E4 → test/xgmii_rx_64/test_m03_e.ml:609; M03-I3 → test/xgmii_rx_64/test_m03_i.ml:1266 | COVERED | AP-M03 §6 (E4, I3) |

### 3.B Tier B — the sixteen programme-invariant rows M03 restates

**Every cell is prefixed `M03:` and every `Status` stays `OPEN`** (§1.2).

| REQ | **`Test(s)`** — paste verbatim | **`Status`** | provenance (NOT transcribed) |
|---|---|---|---|
| REQ-003 | M03: M03-L6, M03-O1 — STRUCTURAL: interface compile check — the output carries `Axi64.Source` with no `Dest` and the input carries no `tready` (SPEC-M03 §4.1) | OPEN | AP-M03 §6 (L6, O1 structural). No behavioural unit exists and none is owed: the requirement is a statement about the type |
| REQ-004 | M03: M03-L1 → test/xgmii_rx_64/test_m03_l.ml:258 (10 000 consecutive 64-octet frames, start lanes alternating, minimum spacing) | OPEN | AP-M03 §6 (L1); SPEC-M03 §8's stress obligation |
| REQ-005 | M03: M03-L2 → test/xgmii_rx_64/test_m03_l.ml:258; M03-L5 → test/xgmii_rx_64/test_m03_l.ml:361 | OPEN | AP-M03 §6 (L2, L5). **`M03-I4` was REMOVED from this REQ's map on 2026-08-07** (`J-dv_lead-0085`): its runs are injected and assert no per-octet constant at all — they report one — so it is not cited here |
| REQ-007 | M03: M03-D1 → test/xgmii_rx_64/test_m03_d.ml:176; M03-E1 → test/xgmii_rx_64/test_m03_e.ml:353; M03-F1 → test/xgmii_rx_64/test_m03_f.ml:304; M03-G1 → test/xgmii_rx_64/test_m03_g.ml:534; M03-H1 → test/xgmii_rx_64/test_m03_h.ml:378; the zero-delivered cases, where the abort bit has no word to ride on — M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-F2 → test/xgmii_rx_64/test_m03_f.ml:492 | OPEN | AP-M03 §6's two-part entry (the set; then the §0.7 zero-delivered cases). **M03-E3 is `NO-ASSERT`** (§5 bound 5); **M03-M9 is `STRUCTURAL`** — M03 inherits no abort and never re-reports one, being the origin of `tuser`[0] on this chain |
| REQ-008 | M03: M03-B2 → test/xgmii_rx_64/test_m03_b.ml:1089, :1331, :1343; M03-B3 → test/xgmii_rx_64/test_m03_b.ml:907; M03-B4 → test/xgmii_rx_64/test_m03_b.ml:459, :717; M03-E2 → test/xgmii_rx_64/test_m03_e.ml:490; M03-F2 → test/xgmii_rx_64/test_m03_f.ml:492; M03-G6 → test/xgmii_rx_64/test_m03_g.ml:1186; M03-H4 → test/xgmii_rx_64/test_m03_h.ml:1047; plus the frame-conservation monitor standing on every M03 bench (AP-M03 §2 obligation 2) | OPEN | AP-M03 §6 (every discard has a strobe; standing obligation 2). **§5 bound 11**: the monitor's two exemptions are mandatory and `frames_exempt` is never evidence that a frame was driven |
| REQ-009 | M03: M03-K1 → test/xgmii_rx_64/test_m03_k.ml:371; M03-K2 → test/xgmii_rx_64/test_m03_k.ml:688 | OPEN | AP-M03 §6 (K1, K2, K3). **`M03-K3` is `NO-ASSERT` and is NOT discharged** — no unit title in any round names it, and the `SO-`'s rider 3 says so in terms. **§5 bounds 12 and 13** |
| REQ-011 | M03: M03-C1 → test/xgmii_rx_64/test_m03_c.ml:338; M03-C3 → test/xgmii_rx_64/test_m03_c.ml:467; M03-C4 → test/xgmii_rx_64/test_m03_c.ml:556; M03-C5 → test/xgmii_rx_64/test_m03_c.ml:408; plus the protocol monitor standing on every M03 bench with `~max_words_per_frame:190` (AP-M03 §2 obligation 1) | OPEN | AP-M03 §6 (C1, C3, C4; standing obligation 1) **+ M03-C5, homed by this delivery** — `FINDING SO-1-A` |
| REQ-012 | M03: M03-A5 → test/xgmii_rx_64/test_m03_a.ml:203 | OPEN | AP-M03 §6 (A5). The filler is position-dependent on purpose: lane reversal, a byte-swapped word and a rotation by 4 are all invisible under uniform filler |
| REQ-014 | M03: producer half — the protocol monitor standing on every M03 bench asserts `tstrb` driven 0 on every output word (AP-M03 §2 obligation 1). GAP: REQ-014's differential run has no instance at M03 — the verification column commissions the same stimulus at `tstrb` = 0x00 and 0xFF, and M03's input is an XGMII lane pair, which has no `tstrb` to vary (SPEC-M03 §10 REQ-014 hook; AP-M03 M03-O2); the consumer half is M06's | OPEN | AP-M03 §6 (standing obligation 1; **M03-O2 declares the differential half has no instance here**). **This is the module's ONE declared `GAP` row**, and `SO-xgmii_rx_64.md` §1.1 `SC-1` carries it. The cell uses `traceability.md`'s own `GAP: <reason>` form. **`Status` is `OPEN`, not `GAP`**: the row is not covered *only* by a gap — its producer half is asserted — and the row itself is a programme invariant no one module closes |
| REQ-015 | M03: M03-C3 → test/xgmii_rx_64/test_m03_c.ml:467; M03-C4 → test/xgmii_rx_64/test_m03_c.ml:556; plus the protocol monitor's one-`tlast`-per-frame and 190-word rules on every M03 bench (AP-M03 §2 obligation 1) | OPEN | AP-M03 §6 (C3, C4; standing obligation 1) |
| REQ-016 | M03: M03-I4 → test/xgmii_rx_64/test_m03_i.ml:1781; M03-I6 → test/xgmii_rx_64/test_m03_i.ml:2106 | OPEN | AP-M03 §6 (I4, I5, I6, N3). **`M03-I5` is `NO-ASSERT`** and **`M03-N3` is `NO-STIMULUS`** — §5 bounds 6 and 14. The wrapper constraint N3 states is itself witnessed by a harness unit, `test/xgmii/test_idle_injection.ml:168`, which is **not** cited as REQ-016 coverage of the DUT: it tests the injector, not the module |
| REQ-017 | M03: M03-O3 — STRUCTURAL: the emitted-Verilog port names `xgmii_rxd` / `xgmii_rxc`, checked by `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN | AP-M03 §6 (O3). SPEC-M03 §10's hook names the check at M05 and M20; the M03-side instrument is the one above |
| REQ-018 | M03: M03-O3 — STRUCTURAL: the emitted-module whitelist, `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN | AP-M03 §6 (O3) |
| REQ-019 | M03: M03-L3 → test/xgmii_rx_64/test_m03_l.ml:258 (ΔC = 3 against the §1.1 ceiling of 4) | OPEN | AP-M03 §6 (L3). **§5 bound 15 is load-bearing here and the architect already anticipated it** at `traceability.md` `Open dependencies` item 4: the row reaches coverage on the ceiling alone and **no packet may read it as evidence about buffer depth**. Additionally `U-2`: L3's ΔC content is discharged by a derivation about the specification and **by no run** |
| REQ-020 | M03: M03-L4 → test/xgmii_rx_64/test_m03_l.ml:258 | OPEN | AP-M03 §6 (L4). **§5 bound 16 (`U-1`)**: L4's sequence read-back is qualified **by citation to M03-L1's pairing or not at all** — a claim counting both has counted one observation twice |
| REQ-021 | M03: M03-A2 → test/xgmii_rx_64/test_m03_a.ml:80; M03-A5 → test/xgmii_rx_64/test_m03_a.ml:203; M03-H2 → test/xgmii_rx_64/test_m03_h.ml:808 | OPEN | AP-M03 §6 (A2, A5, H2) |

### 3.C Tier C — the five rows hooked here and owned elsewhere

| REQ | **`Test(s)`** — paste verbatim | **`Status`** | provenance (NOT transcribed) |
|---|---|---|---|
| REQ-802 | M03 (the `cfg_rx_enable` sampling half): M03-J1 → test/xgmii_rx_64/test_m03_j.ml:259; M03-J2 → test/xgmii_rx_64/test_m03_j.ml:365; M03-J3 → test/xgmii_rx_64/test_m03_j.ml:574; M03-N4 → test/xgmii_rx_64/test_m03_n.ml:1450 | OPEN | AP-M03 §6's joint REQ-802/REQ-810 entry (J1 … J4, N4 — range expanded). Row owner is M20. **§5 bounds 17 and 18**: `M03-J4` is `NO-STIMULUS` **and unqualifiable by specification**; `M03-J1`'s silence cannot say frames were not admitted |
| REQ-808 | M03: M03-O3 — STRUCTURAL: `.mli`, `create` and `hierarchical` present, and the module name appears in `rtl_snapshots/`; `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN | AP-M03 §6's joint REQ-903/REQ-808 entry (O3). Row owner is M20 |
| REQ-810 | M03 (the receive half): M03-J1 → test/xgmii_rx_64/test_m03_j.ml:259; M03-J2 → test/xgmii_rx_64/test_m03_j.ml:365; M03-J3 → test/xgmii_rx_64/test_m03_j.ml:574; M03-N4 → test/xgmii_rx_64/test_m03_n.ml:1450 | OPEN | AP-M03 §6's joint entry. **This is the one tier-C row that already names M03 as an owner** — with M20 (configuration source), M04 (XGMII transmit half) and M18 (application-interface `tready` half), each of which is its own module's `SO-` round. **§5 bound 8** applies: the zero-delivered branch has no instance here |
| REQ-901 | M03: no behavioural row, and none is owed — REQ-901 is a process obligation on the differential co-simulation lane, not a property of M03's ports. The lane's producer is `test/cosim/` (`stimulus_gen.ml`, `ours_run.ml`, `compare.ml`, `tb_xgmii_rx_64.v`), run as CI job `cosim`; its five **stimulus classes** and their per-class `build` / `cosim` run ids are listed in SO-xgmii_rx_64.md §2.3 and §2.3-M. Declared divergence classes (e) and (f) are homed at this module | OPEN | AP-M03 §6's REQ-901 entry, verbatim in substance. **§5 bounds 2, 3 and 4 are mandatory beside this cell** and the architect is asked to carry them into the SO- reference rather than into the cell |
| REQ-903 | M03: M03-O3 — STRUCTURAL: `xgmii_rx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli`; repository-surface check plus the `rtl_snapshots/` name comparison, `tools/check_emitted_verilog.sh` (run from `tools/dv_checks.sh`, CI `build` step 9) | OPEN | AP-M03 §6's joint REQ-903/REQ-808 entry (O3) |

---

## 4. THE UNIT REGISTER — every cited unit, with its full title, once

**56 units of `test/xgmii_rx_64/` are cited above; the directory holds 59.** The
identity is closed rather than left as a remainder: **the three uncited units are bench
machinery** — `test_m03_structural.ml:49` (*"WO-0038 scaffolding: `Xgmii_rx_64`
elaborates and runs idle cycles"*), `:78` (*"`Bench.Enable.change_cycles`: the cycle-0
guard repair"*) and `:110` (*"`Bench.Clear`: the default schedule's high set is empty,
and window is inclusive at both ends"*) — **they test the bench, not the design against a
requirement**, so they carry no REQ and are cited in no cell.

```
$ grep -c 'let%expect_test' test/xgmii_rx_64/*.ml | awk -F: '{s+=$2} END {print s}'
59                          (56 cited + 3 bench-machinery units)
```

| `file:line` | full unit title (the test name) |
|---|---|
| `test_m03_a.ml:80` | M03-A1, M03-A2: 64-octet frame at both start lanes — 8 words, tkeep/tlast pattern, m+3 timing, FCS good at lane 4 (the C-18 kill) |
| `test_m03_a.ml:153` | M03-A3: directed lengths 64..71 equal as tuple sequences at both lanes; M03-A4: no cross-lane absolute-cycle comparison is made |
| `test_m03_a.ml:203` | M03-A5: position-dependent filler pins byte order and lane placement |
| `test_m03_b.ml:93` | M03-B1: nonstandard preamble filler and SFD octets, both start lanes |
| `test_m03_b.ml:459` | M03-B4: /S/ in lane 4 of the word whose lane 0 carried the outer frame's own /S/ — no output word for frame A, exactly one error_start_without_terminate, frame B received intact and correct, content-compared |
| `test_m03_b.ml:717` | M03-B4 (b): /S/ in lane 0 of the word AFTER the word whose lane 4 carried the outer frame's own /S/ — the bench's only 4 → 0 alignment transition, exactly one error_start_without_terminate on cycle 4 (not member (a)'s 3) |
| `test_m03_b.ml:907` | M03-B3: /T/ in lane 5 of a lane-0 start word — no output word, exactly one error_runt and no other strobe of any kind (an exact set, no error_bad_fcs), next frame received intact |
| `test_m03_b.ml:1089` | M03-B2: /E/ in a preamble position, both start lanes (lane 3 of a lane-0 start, lane 7 of a lane-4 start) — no output word at all, exactly one error_bad_frame two cycles after the input word carrying the /E/ |
| `test_m03_b.ml:1331` | M03-B2 /I/: idle character in a preamble position, both start lanes — figures identical to the landed /E/ members figure for figure; kills a design that carries REQ-113's ignore rule into the preamble |
| `test_m03_b.ml:1343` | M03-B2 /Q/: sequence-ordered-set character in a preamble position, both start lanes — kills a design whose preamble-position routing is a closed code table rather than REQ-102's extensional rule |
| `test_m03_c.ml:338` | M03-C1, M03-C2: directed lengths 64..71 at both lanes — all eight tkeep patterns once each, FCS good where terminate lands past lane 0 |
| `test_m03_c.ml:408` | M03-C5: 1513 and 1516-octet frames at both lanes — the P-1 probe (RV-0038-R7 R6-2) |
| `test_m03_c.ml:467` | M03-C3: one 1518-octet frame, both lanes — 1514 octets in 190 words |
| `test_m03_c.ml:556` | M03-C4: the 5-octet runt is a legal one-word frame (C-11) |
| `test_m03_d.ml:176` | M03-D1: 64-octet frame, one payload bit flipped post-FCS, both start lanes — forwarded in full, tuser[0] set, exactly one error_bad_fcs on the tlast cycle |
| `test_m03_d.ml:414` | M03-D2: good-FCS frames stay clean — D1's and D3's own good-FCS members, asserted independently of those rows' tests |
| `test_m03_d.ml:468` | M03-D3: two 64-octet frames at the minimum gap, both orderings, both start lanes — pair A kills the register-read design, pair B kills a latched abort bit |
| `test_m03_e.ml:353` | M03-E1: /E/ in each of the eight lanes of a mid-frame word, both start lanes — sixteen cases (M03-M3 — §9 ruling 3: the exact set is error_bad_frame ALONE, no error_bad_fcs) |
| `test_m03_e.ml:490` | M03-E2: /E/ at the frame's first octet position — no output word, exactly one error_bad_frame two cycles after the /E/'s input word |
| `test_m03_e.ml:609` | M03-E4: /E/ after a terminate character, in the inter-frame gap — nothing emitted, no strobe, following frame intact |
| `test_m03_e.ml:799` | M03-E5: /E/ at preamble positions 1..7, lane-0 start — a frame opened and closed inside one input word, no output word at all, exactly one error_bad_frame at §9's no-output-word pin |
| `test_m03_f.ml:304` | M03-F1: 5, 16, 60 and 63-octet runts, both start lanes — forwarded, marked, FCS removed and checked (M03-M1's second carrier — §9 ruling 1's second sentence) |
| `test_m03_f.ml:492` | M03-F2: 0, 1 and 4 octets between start and terminate, both start lanes — no output word at all, exactly one error_runt at §9's no-output-word pin |
| `test_m03_f.ml:653` | M03-F3: a 63-octet frame with a wrong FCS, both start lanes — error_runt AND error_bad_fcs pulse once each, tuser[0] set once (M03-M1) |
| `test_m03_f.ml:801` | M03-F4: the adjacent pair 63 and 64 octets, both lanes — 63 is a runt, 64 is legal, differing by one octet and by everything else |
| `test_m03_f.ml:811` | *(not a unit — the committed comment recording M03-F5's discharge by citation to M03-C4 and M03-F1's 5-octet member)* |
| `test_m03_g.ml:534` | M03-G1: a 1600-octet frame followed immediately by a valid 64-octet frame — 1514 octets delivered, exactly one error_oversize, no error_bad_fcs (M03-M2 — §9 ruling 2) |
| `test_m03_g.ml:684` | M03-G2: the adjacent pair 1518 and 1519 octets, both lanes — 1518 legal, 1519 oversize; both deliver exactly 1514 octets |
| `test_m03_g.ml:834` | M03-G3: a 1600-octet frame, then a new /S/ 102 octets past the truncation point — exactly one error_oversize, no error_start_without_terminate (M03-M6's second-epoch carrier) |
| `test_m03_g.ml:1003` | M03-G4: the same 1600-octet frame, with an /E/ absorbed 100 octets past the truncation point — exactly one error_oversize, no error_bad_frame (M03-M7's second-epoch carrier) |
| `test_m03_g.ml:1186` | M03-G6: a 1600-octet frame with no terminate character at all before the next /S/ — no output word and no strobe of any kind in between |
| `test_m03_g.ml:1490` | M03-G7: a start character injected strictly inside the first epoch (k = 1588) — exactly one error_oversize, no error_start_without_terminate, and the resynchronised frame's own disposition (M03-M6's first-epoch carrier) |
| `test_m03_g.ml:1696` | M03-G8: an error character injected strictly inside the first epoch (k = 1560) — exactly one error_oversize, no error_bad_frame, following frame intact (M03-M7's first-epoch carrier) |
| `test_m03_h.ml:378` | M03-H1: terminate replaced by a new /S/, both start lanes — all 64 octets delivered (no FCS removed), exactly one error_start_without_terminate (M03-M4 — §9 ruling 4) |
| `test_m03_h.ml:609` | M03-H3: /E/ mid-frame, then a /S/ exactly two cycles later, both start lanes — exactly one error_bad_frame and no error_start_without_terminate (M03-M5) |
| `test_m03_h.ml:808` | M03-H2: a new /S/ in lane 4 of a mid-frame word, both start lanes — the four preceding octets delivered as part of the aborted frame, content asserted, the new frame received intact and correctly aligned |
| `test_m03_h.ml:1047` | M03-H4: /S/ in lane 0 and lane 4 of one word, then /S/ in lane 0 of the next — two zero-delivered aborts on consecutive high cycles (C-23), no output word for either |
| `test_m03_i.ml:397` | M03-I1: 1000+ idle cycles with nothing in flight — tvalid and all five strobes stay 0 throughout the window, the frame after it delivered correct and complete |
| `test_m03_i.ml:977` | M03-I2: the drain window, three members at both start lanes — silence from 3 cycles after the terminate word onward, per-member per-lane boundaries derived and guarded independently |
| `test_m03_i.ml:1266` | M03-I3: 100 cycles of a /Q/ ordered set between two frames, both start lanes — no tvalid and no strobe during it, the following frame compared cycle for cycle against the same frame received after idles only |
| `test_m03_i.ml:1781` | M03-I4: the M03-C1 directed set through the idle-injection wrapper at 0/1/7 idle cycles, both start lanes — 48 injected runs plus 16 un-injected baselines; the per-octet constant of §7 MEASURED and REPORTED rather than asserted |
| `test_m03_i.ml:2106` | M03-I6: a 64-octet frame and a 1518-octet frame, each with 7 idle cycles injected between every pair of words, both start lanes — no strobe pulses at all, delivered content and clean FCS verdict unchanged |
| `test_m03_j.ml:259` | M03-J1: cfg_rx_enable = 0 held across 100 refused frames — no output word, no header effect, no strobe anywhere; a control run at Enable.high proves the schedule carries 101 well-formed frames |
| `test_m03_j.ml:365` | M03-J2: cfg_rx_enable 0 → 1 at least one cycle before a start character — the first frame admitted after re-enable is received correctly and completely, provenance confirmed by its own sequence number |
| `test_m03_j.ml:574` | M03-J3: cfg_rx_enable 1 → 0 mid-frame, at both start lanes — the in-flight frame completes under the old value byte-for-byte against an Enable.high reference run, cycles included |
| `test_m03_k.ml:371` | M03-K1: clear held for five cycles with no frame in flight — the bad-FCS strobe on the preceding cycle does not survive into the window, and the window's five cycles plus the release cycle are silent |
| `test_m03_k.ml:688` | M03-K2: clear asserted mid-frame and released onto the next frame's start character — the in-flight frame vanishes with two words delivered, no tlast and no strobe, frame_in_exempt accounts it (C-2) |
| `test_m03_l.ml:258` | M03-L1, M03-L2, M03-L3, M03-L4: 10 000-frame line-rate stress — sequence order, per-lane latency, the ΔC reserve |
| `test_m03_l.ml:361` | M03-L5: directed lengths 64 .. 71 and 1518, both start lanes, through the latency tagger |
| `test_m03_n.ml:698` | M03-N2 sub-case 1: /S/ lane 0, A lane 0, A delivered — error_start_without_terminate at A's own cycle, error_runt at B's, on different cycles |
| `test_m03_n.ml:708` | M03-N2 sub-case 2: /S/ lane 0, A lane 4, A delivered — A's four delivered octets are NOT classified as a runt |
| `test_m03_n.ml:718` | M03-N2 sub-case 3: /S/ lane 0, A zero-delivered — both frames' reports coincide, different names; does NOT pay WO-0058 bound 7 |
| `test_m03_n.ml:728` | M03-N2 sub-case 4 — the plan's own minimal witness for defect M03-R1: /S/ lane 4, A lane 0, A delivered; PAYS WO-0058 bound 7 for the first time |
| `test_m03_n.ml:739` | M03-N2 sub-case 5: /S/ lane 4, A lane 4, A delivered — PAYS WO-0058 bound 7 |
| `test_m03_n.ml:749` | M03-N2 sub-case 6 — the lane-4-start instance of the derived split: /S/ lane 4, A zero-delivered; PAYS WO-0058 bound 7, a third instance, in the zero-delivered form |
| `test_m03_n.ml:959` | M03-N1: an /E/ five octet times after the frame's own /T/ — the /T/ closes the frame normally (FCS checked), the /E/ finds no open frame and produces nothing and pulses nothing |
| `test_m03_n.ml:1450` | M03-N4: cfg_rx_enable 1 → 0 strictly inside frame A, at least one cycle before a refused start character — frame A aborted at the octet before it with tuser[0] = 1, exactly one error_start_without_terminate, no output word for the refused start |

**One unit outside `test/xgmii_rx_64/` is named in §3 and it is named as a bound, never as
coverage**: `test/xgmii/test_idle_injection.ml:168` — *"X-4: the M03-N3 constraint refuses
one boundary per frame"*. It exercises the **injector**, not the design.

---

## 5. THE BOUNDS THAT RIDE WITH THESE CELLS — restated, never summarised

**A traceability cell is a list of names and cannot carry a bound.** These are what a
reader of a cell must consult, and they are lifted from the artefacts that minted them.
**Every one is already published**; nothing here is new and nothing here moves.

1. **A class is anchored; a requirement is not; a module never is** (`WO-0078` §8,
   `AP-M03` §7, `SO-` §5.1 item 1). No cell above says a requirement is anchored.
2. **The differential co-simulation anchors five stimulus classes on four REQ-901
   observables and no requirement** (`SO-` §5.1 item 2). REQ-104's co-simulated value is
   written as a **pair** — the lane established **equality**, `M03-D1` established the
   **figure** — or not at all (`FINDING RV-0078-S2-11`).
3. **For REQ-107 and REQ-108 a co-simulation result is not an admissible external anchor
   at all, and no packet may offer one** (SPEC-M03 §10's own REQ-107 and REQ-108 hooks;
   REQ-901 declared divergence classes **(e)** and **(f)**; `SO-` §5.2). **This is
   permanence, not a current state**: no stage of any phase can alter it. Families F and
   G are not waiting on the lane; their directed rows are the whole of their verification.
4. **No cross-side timing comparison and no strobe comparison exists** (`SO-` §5.3 bar 3,
   §5.4 bar 4). The lane records the reference's cycles as data, never adjudicated; no
   strobe of either side was compared at any of the five landed classes, and none could
   have been.
5. **`M03-E3` and `M03-D4` are `NO-ASSERT`**: a monitor asserting *"every abort is marked
   on a `tlast` word"* must **not** be driven for E3's frame, and residue-versus-capture
   is unobservable (§6.3 item 1).
6. **`M03-N3` is `NO-STIMULUS`**: the idle-injection wrapper **SHALL NOT** inject between
   a start character and the frame's first octet — those lanes are preamble positions and
   the wrapper would be measuring an abort (SPEC-M03 §6.1 and §10's REQ-016 hook).
7. **`M03-B3` and `M03-N2`'s six sub-cases are NEVER coverage of §9's ruling 9**
   (`DECLARATION WO-0074-D1`, `SO-` §2.6 `U-3`). That coverage is the three epoch-A
   closures alone.
8. **The zero-delivered branch of a REQ-110 abort under a disabled receive path has NO
   INSTANCE at M03** — the admissible interval is **empty at both start lanes**, on this
   specification's own arithmetic and not on a bench limitation (SPEC-M03 §10's
   REQ-802/REQ-810 hook, `M03-N4`). **No packet may claim coverage of it here.** The same
   geometry **is** commissioned under `cfg_rx_enable` = 1, at the REQ-110 rows.
9. **REQ-111's constancy is judged per front-offset class, never as one L across a
   two-lane run** (requirements.md §0.5, C-15): L = 16 at lane 0, L = 12 at lane 4.
10. **REQ-112's *"zero rx backpressure asserted"* is discharged STRUCTURALLY, not
    observed** — the module exposes no `tready` and no `tready` input exists, so there is
    no signal a consumer could assert (`SO-` §1.1 `SC-4`, `M03-L6`).
11. **The conservation monitor's two exemptions are mandatory** — a frame presented while
    `clear` = 1 and a frame presented while `cfg_rx_enable` = 0 are `frame_in_exempt`
    (`AP-M03` §2 obligation 2) — and **`frames_exempt` is bench-supplied and is never
    evidence that a frame was driven** (`SO-` §2.1 rider 4).
12. **`M03-K3` is `NO-ASSERT` and is NOT discharged.** No unit title in any round names
    it (`SO-` §2.1 rider 3). **`M03-K2`'s third kill is a monitor-precondition, not a
    design kill.**
13. **`M03-K1` is convictable only by a defect that CARRIES an observable into the
    window**, never by one that fails to suppress (`SO-` §2.6 `U-5`).
14. **`M03-I5` is `NO-ASSERT`**: §6.1's `m + 3` formula is scoped to a gapless stimulus
    and is not asserted under injection; **the per-octet constant is reported as data and
    asserted nowhere** (`SCR-M03-I4`).
15. **REQ-019's second sentence has no port-visible symptom**: the row reaches coverage on
    the §1.1 latency ceiling alone and **no sign-off packet may read it as evidence about
    buffer depth** (`traceability.md` `Open dependencies` item 4 — the architect's own
    rule, restated so the cell cannot be read past it). **`U-2`**: `M03-L3`'s ΔC content is
    discharged by a derivation about the specification and **by no run**.
16. **`U-1`**: `M03-L4`'s sequence read-back is qualified **by citation to `M03-L1`'s
    pairing or not at all** — a coverage claim counting both has counted one observation
    twice.
17. **`M03-J4` is `NO-STIMULUS` and UNQUALIFIABLE BY SPECIFICATION**: §6.3 item 7 and
    C-14.5 leave the same-cycle enable change unconstrained, so every rendering of it is
    an equivalent mutant by specification.
18. **`U-4`**: `M03-J1`'s silence **cannot** say frames were not admitted; the separating
    instrument is `M03-J3`'s positive comparison.

**The portable form all five `U-` rows share, carried with them**: *an assertion whose
subject is already compared, positionally and earlier, by a sibling assertion in the same
unit is unreachable, and its greenness is evidence about the sibling* — **a coverage claim
counting both has counted one observation twice.**

---

## 6. WHAT THIS ROUND MEASURED THAT THE PLAN DOES NOT SAY

### 6.1 `FINDING SO-1-A` (MINOR, mine, against `AP-M03` §6)

**Six declared rows are reachable from the coverage map by neither name nor range.**
Measured over **every** declared row of §4 and over §6's whole text with its four
ellipsis ranges expanded — the polarity dimension, because the claim is that a naming
**does not exist**:

```
$ python3 - <<'PY'
import re
txt=open('test/attack_plans/AP-xgmii_rx_64.md').read()
declared=set(re.findall(r'^\| \*\*(M03-[A-Z]+\d+)\*\* \|', txt, re.M))
s=txt[txt.index('## 6. Coverage map'):txt.index('## 7. Machinery this plan requires')]
named=set(re.findall(r'M03-[A-Z]+\d+', s))
for m in re.finditer(r'M03-([A-Z]+)(\d+)\s*…\s*M03-\1(\d+)', s):
    named |= {f"M03-{m.group(1)}{k}" for k in range(int(m.group(2)), int(m.group(3))+1)}
print(len(declared), len(named & declared), sorted(declared-named))
PY
78 72 ['M03-C5', 'M03-E5', 'M03-M8', 'M03-M9', 'M03-O4', 'M03-O5']
```

**Two of the six are landed, green `ASSERT` units, and that is the part that costs
coverage**: `M03-C5` (`test_m03_c.ml:408`, the `BUG-0001` / `P-1` probe at 1513 and 1516
octets) and `M03-E5` (`test_m03_e.ml:799`, the `/E/` at preamble positions 1..7).
**§6 understates REQ-103, REQ-011 and REQ-105 by exactly those two units.** Had this
delivery transcribed §6 mechanically, three cells would have omitted landed evidence —
**which is the failure mode the matrix exists to prevent**, arriving through the
instrument meant to prevent it.

**The other four cost no coverage and are still a defect in the map's own rule**:
`M03-M8` (`NO-STIMULUS`, §9 ruling 8 — `error_runt` and `error_oversize` have disjoint
octet ranges), `M03-M9` (`STRUCTURAL`, REQ-007 — M03 is the origin of `tuser`[0] and
inherits no abort), `M03-O4` (`NO-STIMULUS`, REQ-101 — a start character outside lanes 0
and 4 is never driven) and `M03-O5` (`NO-ASSERT`, a plan-wide prohibition row with no REQ
home). §6 says *"A REQ with no behavioural row carries the reason"*; it does not say what
becomes of a **row** with no REQ line, and four rows fell through that hole.

**Disposition, in three parts.**
(a) **The delivery homes `M03-C5` and `M03-E5` explicitly** — §3.A REQ-103 and REQ-105,
§3.B REQ-011 — and the provenance column says the homing is this round's, not §6's, so no
reader takes it for a plan statement it can look up.
(b) **The recommended `AP-M03` §6 repair** is: add `M03-C5` to REQ-103 and REQ-011, add
`M03-E5` to REQ-105, and give `M03-M8`, `M03-M9`, `M03-O4` and `M03-O5` an explicit line
each recording that they are no-instance rows homed under REQ-107/REQ-108, REQ-007,
REQ-101 and no REQ respectively.
(c) **The repair does NOT ride this round.** `AP-M03` is in `test/**` and therefore in my
write scope, so this is a choice and not a constraint: **a delivery round is not a plan
round** (`J-dv_lead-0112`), and the `SO-` made the same call two days ago for `FINDING
SO-3`'s §4.J figure — *"its repair rides the next `AP-` opener, which is not this round"*.
**Carrier: the next round that opens `test/attack_plans/AP-xgmii_rx_64.md`.** Deciding it
here would widen a delivery round's write set mid-round, which is the move `RV-C4` §12
convicts.

### 6.2 What did NOT move, stated because a reader will look for it

**No `AP-M03` row is re-statused, no discharge count changes, no bar lifts, no class is
anchored, no `BUG-` is opened and no `SO-` sentence is amended.** The census
`SO-xgmii_rx_64.md` §2.1-M measured at `2183d71` — **78 rows / 62 `ASSERT` / 7
`NO-ASSERT` / 4 `NO-STIMULUS` / 4 `STRUCTURAL` / 1 `GAP`, 62 of 62 `ASSERT` rows
discharged** — **holds unchanged at `a851948`**, and it holds by identity rather than by
re-measurement: `git diff --quiet 2183d71..a851948 -- test/` exits **0**.

---

## 7. DEFINITION OF DONE — for architect_docs_lead

1. **Transcribe** the `Test(s)` and `Status` cells of §3.A, §3.B and §3.C into the 34
   named rows of `docs/specs/traceability.md`. **The 76 other rows are not touched.**
2. **Update the file's own header and prose** where transcription falsifies them —
   at minimum the **Status** line (*"DRAFT skeleton — test column pending dv_lead"*) and
   `Open dependencies` item 1 (*"Test column: empty by design at WO-0002 return"*), which
   become false the moment the paste lands. **That text is yours and I propose no
   wording.**
3. **Rule on the tier-B/tier-C `Status` question** (§1.2): keep `OPEN` with a populated
   cell, or extend the vocabulary. **Either is acceptable to DV and neither needs a
   further DV round**; if the vocabulary is extended, these 21 rows are the candidate set.
4. **Return** with a `J-architect_docs_lead-NNNN` reference in the Return log below,
   naming the SHA of the transcription. **Any cell you decline to transcribe, or
   transcribe differently, is recorded there with the reason** — a divergence between this
   packet and the matrix is a finding against one of us and it should be visible, not
   reconciled silently.

**Out of scope for this packet**: every non-M03 row; the `Spec section` column
(no cell of it is proposed or touched); `docs/gates/**`; and the `SO-`'s re-read, which
happens after **both** of `SO-xgmii_rx_64.md` §8.2's acts and is not triggered by this one.

---

## 8. Return / verdict log

### 8.1 architect_docs_lead — `J-architect_docs_lead-0035`, transcription accepted in full

**Verdict: ACCEPTED. All 34 cells transcribed, cell for cell, verbatim. Nothing
refused, nothing altered, no cell transcribed differently.** The delivery's
two-column design did what it was built to do: because §3 carries only columns 6
and 7, the paste could not reach columns 1–5, and it did not.

**SHA.** Transcribed against `HEAD = c55c754`; the landing SHA is the
orchestrator's commit carrying `J-architect_docs_lead-0035`, which I cannot name
from inside the round that writes it. Every figure below was measured at
`c55c754`.

**Matrix counts after transcription** (measured, not carried):

```
$ awk -F'|' '/^\| REQ-/{n++; t=$7; gsub(/^[ \t]+|[ \t]+$/,"",t);
             s=$8; gsub(/^[ \t]+|[ \t]+$/,"",s);
             if(t=="") e++; else p++; c[s]++}
     END{print n" rows: "p" populated, "e" empty";
         for(k in c) print "  "k": "c[k]}'  docs/specs/traceability.md
110 rows: 34 populated, 76 empty
  OPEN: 97
  COVERED: 13
```

**And the 76 are untouched, measured over every row rather than the ones I
remember not editing**: of the 76 rows outside the M03 slice, **76** still have
an empty `Test(s)` cell and `Status` `OPEN` — the set of rows whose cells changed
equals the set of 34 the packet delivers, exactly. In the diff,
`grep -c '^[-+]| REQ-'` counts **68** changed table lines — 34 removed, 34 added,
one pair per delivered row and no other row line moved. The remaining changed
lines are the prose of DoD item 2, listed at the end of this entry.

**Verification I ran before transcribing, and what it found.**

1. **The hook set is 34, independently re-derived.** A left-column pass over
   SPEC-M03 §10 returns exactly the 34 REQ ids of §3, and a whole-section
   `grep -oE 'REQ-[0-9]+'` returns 35; the difference is `REQ-010`, which appears
   in **zero** left-column cells and only inside REQ-014's cell as a
   cross-reference. **§1's figure and its explanation both hold.**
2. **Every cited `file:line` holds.** All **55** unit citations land on a
   `let%expect_test` line, and every one of those units' titles carries the row id
   the cell claims. The **one** non-unit citation, `test_m03_f.ml:811`, is the
   comment the packet says it is —
   `(* ---- M03-F5 — DISCHARGED BY CITATION, not built (WO-0047 §3.3) ----------- *)`
   — and the cell declares it rather than passing it off as a unit.
3. **The `COVERED` evidence is sounder at my SHA than the packet claimed at its
   own.** §2.3 shows `test/`, `tools/` and `docs/specs/` byte-identical across
   `2183d71..a851948`. I extended the interval to the SHA I am transcribing at:
   `git diff --quiet 2183d71..c55c754 -- test/` and the same over `docs/specs/`
   both exit **0**. So CI `build` run `31444471834` at `head_sha` `2183d71` covers
   the suite exactly as it stands here, and the 13 `COVERED` cells rest on a run
   id whose subject has not moved. **I re-executed no simulation** — ADR-0005
   forbids it in this container, and the pass stays an externally verifiable
   reference (ADR-0003/F5), carried as one, not upgraded by transcription.
4. **The tier partition matches this file's own `Owning module(s)` column.**
   Tier A's 13 rows all read `M03 Xgmii_rx_64` and are owned whole; tier C's five
   name M20, M20, the four-owner REQ-810, and `programme (process)` twice.

**Ruling on DoD item 3 — `OPEN` is kept; the vocabulary is NOT extended.** A
`PARTIAL` would have to define the condition under which it becomes `COVERED`,
and that condition is exactly the split `Open dependencies` item 3 defers to the
first module-ready gate; minting the value now would freeze half of that decision
into the vocabulary before the gate that owes it has met. `OPEN` beside a
populated `M03:` cell is honest once the file says what `Status` is a claim
*about* — and it did not say so, so I wrote it: `Status` is a claim about the
row's own subject, never a measure of how much evidence its cell holds. The 21
rows are recorded as the candidate set should the gate want `PARTIAL` later.

**Two precisions returned — neither is a refusal, and neither changed a cell.**
§7's item 4 asks for divergences to be visible rather than reconciled silently,
so these are stated even though both leave the transcription untouched.

- **P-1 — one citation does not satisfy the packet's own §2.1 rule, though it is
  substantively right.** §2.1 says `<path>:<line>` names "the `let%expect_test`
  unit **whose title carries that row id**". At `M03-M10 → test_m03_f.ml:492`
  the title carries `M03-F2` and **not** `M03-M10`; the string `M03-M10` does not
  occur anywhere inside that unit. Every other co-occurrence citation
  (M1, M2, M3, M4, M5, M6, M7, and M10's *other* carrier at `test_m03_b.ml:907`)
  does carry its id in the title, so this is the single exception. The **claim is
  true** — `AP-M03` records M03-M10's carriers as M03-F2 and M03-B3 and qualifies
  it "ON `M03-F2` ALONE" — so the homing lives in the plan rather than in the
  unit title. **Transcribed unchanged**; what is imprecise is §2.1's
  generalisation, not the cell. A reader following §2.1 literally at that one
  entry will not find the id and should look to `AP-M03` §6.
- **P-2 — §1.2's ground under-reaches two of its own 21 rows.** §1.2 justifies
  the tier-B/C `OPEN` disposition by the programme-invariant rule and
  `Open dependencies` item 3, whose ranges are REQ-001 … REQ-021 and
  REQ-801 … REQ-810. **`REQ-901` and `REQ-903` are in neither.** They are process
  rows, owned by `programme (process)`. Their `OPEN` is nonetheless correct, on a
  different ground this file already carries: a process obligation is the
  programme's to discharge and no module closes it — the same reasoning that
  makes four rows name a process document in the `Spec section` column rather
  than a module spec. **Same disposition, different ground**; I have written the
  process-row ground into the `Status` bullets so the 21 rows are not all resting
  on a rule that reaches only 19 of them.

**On the two rows §1.2 flagged as this delivery's own homing** (`M03-C5` at
REQ-103 and REQ-011, `M03-E5` at REQ-105 — `FINDING SO-1-A`): transcribed as
delivered. Both are landed green units, both cite lines that hold, and the
provenance column's statement that the homing is this round's and not `AP-M03`
§6's is why I could tell — a mechanical transcription of §6 would have dropped
them, which is the failure mode this matrix exists to prevent. **The `AP-M03` §6
repair is dv_lead's and rides its next plan round; nothing here anticipates it.**

**What I changed beyond the 34 cells, all of it prose this file owns** (DoD item
2): the `Status` header line and the `Test column owner` line; `Open dependencies`
item 1 (*"empty by design at WO-0002 return"*, false the moment the paste landed)
and item 3 (which gains the record that this is its first occasion, plus P-2's
two exceptions); the `Test(s)` bullet, whose *"listed comma separated"* rule the
delivered atom `<row-id> → <path>:<line>` falsifies — entries are
semicolon-separated and the comma groups *within* an entry; a new provenance
bullet making the `M03-` prefix the readable pointer back to this packet; and the
`OPEN`-with-populated-cell ruling above. **No `Spec section` cell was touched, no
row outside the M03 slice was touched, and no `AP-`, `SO-`, `test/` or `libs/`
byte was touched.**

**Not claimed here.** This entry pays act 1 of `SO-xgmii_rx_64.md` §8.2 and says
nothing about whether `SC-2` is met; that is adjudicated by a re-read against §1
after **both** acts, which is not this round and not mine to call.

---

## 9. Change log

| date | change | by |
|---|---|---|
| 2026-08-11 | **TRANSCRIBED AND ACCEPTED — §8.1.** All 34 `Test(s)`/`Status` cells landed in `docs/specs/traceability.md` cell for cell; nothing refused, nothing altered, the 76 rows outside the slice verified untouched by measurement over all 110. Matrix now **34 populated / 76 empty, 13 `COVERED` / 97 `OPEN`**. `OPEN` kept for the 21 tier-B/C rows and **no `PARTIAL` minted** — the vocabulary question ruled, with the reason written into the matrix's own `Status` bullets. Two precisions returned, neither changing a cell: **P-1**, `M03-M10 → test_m03_f.ml:492` is substantively right but is the one citation whose unit title does not carry the row id §2.1 promises; **P-2**, §1.2's ground reaches 19 of its 21 rows — `REQ-901` and `REQ-903` are process rows outside both cited ranges and hold `OPEN` on the process-row ground instead. `COVERED` re-underwritten at the transcription SHA: `test/` and `docs/specs/` byte-identical `2183d71..c55c754`, so run `31444471834` covers the suite as it stands. | architect_docs_lead, `J-architect_docs_lead-0035` |
| 2026-08-11 | **Packet created.** The 34-row M03 slice of `docs/specs/traceability.md` delivered as transcribable `Test(s)` and `Status` cells, in three tiers (13 M03-owned → `COVERED`; 16 programme-invariant restatements and 5 hooked-but-owned-elsewhere rows → `OPEN` with an `M03:`-prefixed cell), with a 56-unit register printing every cited unit's full title, an 18-item bound register, and **`FINDING SO-1-A`** — six `AP-M03` rows reachable from §6's coverage map by neither name nor range, two of them landed green units whose omission would have understated REQ-103, REQ-011 and REQ-105. **Nothing re-statused, nothing lifted, no `docs/**` byte touched, nothing run.** | dv_lead, `J-dv_lead-0166` |
