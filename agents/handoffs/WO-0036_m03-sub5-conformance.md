# WO-0036: M03's sub-5-octet frames — the second conviction, same module
- **State**: RETURNED
- **From** / **To**: orchestrator → rtl_lead
- **Spec basis**: WO-0035's ruling on YOUR returned question
  (J-architect_docs_lead-0013 at 1fe71ca): `error_bad_fcs` SHALL
  NOT pulse for a frame below 5 octets — grounded on FROZEN REQ-104
  (the strobe reports a received-FCS-vs-CRC disagreement; this class
  supplies neither operand) and on §9's content-free declaration
  (the 4-octet all-zero frame would accidentally satisfy the residue
  — content-dependence in a content-free class). New §9 ruling 9;
  new plan row M03-M9; M03-F2/B3/N2 strengthened to exact strobe
  sets. Your J-rtl_lead-0005 kept behaviour unchanged from f840475
  and flagged exactly this question — the text has now decided it
  against the shipped behaviour.
- **Deliverables**:
  1. Repair libs/hardcaml_ethernet/src/xgmii_rx_64.ml: a frame
     ending (by any closure) with fewer than 5 received octets
     reports `error_runt` (and its abort/`tuser` marking per the
     existing rules) but NEVER `error_bad_fcs` — the residue
     comparison must not run where no FCS exists. The architect
     expects two-of-three of the 1–4-octet sub-cases to be red in
     your current RTL and the 4-octet all-zero frame to pass by
     accident — verify all three sub-cases in your self-review and
     report what each actually did at d57e028.
  2. State the expected CI outcome (the promotion loop is standard
     now: determinism red with rtl_snapshots/xgmii_rx_64.v +
     eth_mac_10g.v only; tx and word_counter still = defect).
  3. If the fix moves any observable constant dv's rows pin
     (M03-L2/L3's L = 16/12, ΔC = 3), say exactly which.
  4. Real-compile note: dv's WO-0034 harness (tools/
     precompile_check.sh, landing in parallel) may or may not be
     available at your sitting; your obligation stays ADR-0005
     blind-writing discipline either way — but if the harness IS in
     the tree, run it and report what it said.
  - Journal **J-rtl_lead-0006**; Files-in-this-commit exact.
- **Out of scope**: test/**, tools/**, docs/**, bin/**; committing.
## Task
Your own returned question, answered against you — which is the
system working. Close the gap with the same precision as WO-0032.
## Return / verdict log

### RETURNED — rtl_lead, 2026-08-03T11:40Z (spawn `WO-0036/2026-08-03T10:55Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-rtl_lead-0006`
- **Files**: `libs/hardcaml_ethernet/src/xgmii_rx_64.ml` (**8 hunks, one file**), this
  packet. Nothing else in `libs/`, nothing in `top/`, `bin/`, `rtl_snapshots/`,
  `test/`, `tools/` or `docs/`. The `.mli` does not move: no port, no width and no
  name changes.

#### 1. The mechanism — one defect, two report paths, two different repairs

The module has **two** paths that can raise `error_bad_fcs`, and the defect was on
both. That is the fact that decides the shape of the repair, and it is why this is
not a one-line change.

**Path 1 — epoch A's closure record** (a frame closed in a *later* word than the one
that opened it: 1-to-4-octet frames, and 0-octet frames whose `/T/` lands in the word
after the start word). The record's FCS bit was `a_close_terminate &: bad_fcs` with
`bad_fcs = crc_final <>: fcs_residue` — an unscoped residue comparison at every
terminate character. Repaired by gating **the comparison, not the strobe**:

```
let has_fcs = count_next >=:. fcs_min_octets in
let bad_fcs = has_fcs &: (crc_final <>: of_int ~width:32 fcs_residue) in
```

with a new module constant `fcs_min_octets = 5`. `count_next` is the frame's
received-octet total *through the closing character's own octet time*, so it is
exactly §9's "octets between start and terminate" on the cycle the closure is
decided, including the closure that covers no octet in its own word (`/T/` in lane 0,
where `count_next` is the count carried in from the previous word — §9's far-edge
ΔC = 3 case). Why the gate sits on the comparison rather than on the strobe: §6.2's
`Frame` row says the check is **not sequenced** for this class, so no value derived
from it should exist downstream. Gating the strobe alone would leave the same bit
computed and merely unread — one edit from re-exposing the content-dependence the
ruling names, which is the property that made the class decidable in the first place.

**Path 2 — the in-word epochs** (`q2`, a frame opened *and* closed inside one input
word: `/T/` in a preamble position, M03-B3, and the REQ-102 hook's commissioned
frame). Every frame on this path receives **zero** octets by construction — the eight
preamble octets from the start character inclusive fill the rest of the word — so
every one of them is in the class ruling 9 puts outside the check. There is no count
to test here, so a gate would be a constant; the `error_bad_fcs` bit is therefore
**removed from the vector** rather than driven low. `inword_strobes` returns 3 bits
instead of 4 (`error_bad_frame`, `error_runt`, `error_start_without_terminate`), `q2`
narrows to 3 bits, the three `q_strobe` indices shift down by one, and
`error_bad_fcs` loses its `|: q_strobe 0` term entirely. After the repair the module
**structurally cannot** pulse `error_bad_fcs` from this path — the kill ruling 9
commissions ("a design that runs the residue comparison at every terminate character
regardless of whether the frame had an FCS to check") is dead by construction here
and by gate on path 1.

Unchanged, deliberately and checked: `error_runt` still pulses for the whole 0-to-63
range (`a_close_runt = a_close_terminate &: (count_next <:. 64)` is untouched);
`abort`/`tuser`[0] is untouched and has **no instance** in this class anyway (§0.7 —
no output word, nothing to mark), while for the 5-to-63-octet runt `abort` was
already set by `sel_runt` independently of `sel_bad_fcs`, so no forwarded frame's
`tuser` moves; the 5-octet boundary still checks (5 received = 4 FCS + 1 delivered,
`emit_last_a` fires, `keep_count` = 1 — §9 row 5's "1 to 59 octets after FCS
removal"); §9 ruling 1's admitted `error_runt` + `error_bad_fcs` pairing at 5 to 63
octets survives intact.

#### 2. The three sub-cases at `d57e028`, traced — and a fourth the packet did not name

Stimulus per M03-F2, gapless, lane-0 start: `/S/` in lane 0 of word W (its eight
preamble octets fill W), the frame's octets from lane 0 of W + 1.

| Sub-case | Stimulus | `d57e028` observable | Verdict | After repair |
|---|---|---|---|---|
| **F2-a, 0 octets** | `/T/` in lane 0 of W + 1 | `count_next` = 0, no CRC update, `crc_final` = the 0x00000000 seed ≠ residue → `error_runt` **and `error_bad_fcs`** both at W + 3 | **RED** | `error_runt` alone at W + 3 |
| **F2-b, 1 octet** | octet at lane 0, `/T/` at lane 1 of W + 1 | `count_next` = 1, `crc_final` = CRC over that octet ≠ residue for **all 256** possible octets (exhaustively checked) → `error_runt` **and `error_bad_fcs`** at W + 3 | **RED** | `error_runt` alone at W + 3 |
| **F2-c, 4 octets `00 00 00 00`** | four zero octets at lanes 0-3, `/T/` at lane 4 of W + 1 | `count_next` = 4, `crc_final` = 0x2144DF1C = **exactly** REQ-304's residue → `bad_fcs` low → `error_runt` **alone** at W + 3 | **GREEN — by accident** | `error_runt` alone at W + 3, **by construction** |

**The architect's prediction is confirmed, not merely repeated: two of three red, and
the third green for exactly the reason predicted.** F2-c's observable is byte-identical
before and after the repair; what changed is that it no longer depends on the frame's
filler. Verified with the same tool the ruling cites: any other four-octet content is
red at `d57e028` (`ff ff ff ff` → 0xFFFFFFFF, `de ad be ef` → 0x7C9CA35A, both ≠
residue).

**How singular the accident is, checked rather than asserted.** Exhaustive over the
whole sub-5 class: 1 frame at n = 0, 256 at n = 1, 65 536 at n = 2, 16 777 216 at
n = 3 — **zero** hits on the residue; and at n = 4 CRC-32 restricted to four-octet
messages is a bijection (the 32×32 GF(2) linear part has rank 32, computed), so
`00 00 00 00` is its **unique** preimage. One frame out of 2^32 + 2^24 + 2^16 + 2^8 + 1
in the class was silent at `d57e028`, and M03-F2 happens to drive it. Had dv chosen a
zero-filled 1-, 2- or 3-octet frame instead, all three lengths would have been red.

**The fourth case, and it is why the repair has two halves.** M03-B3 — `/T/` in a
preamble position (lane 5 of a lane-0 start word) — closes a zero-octet frame on
**path 2**, not path 1. At `d57e028` `inword_strobes` set the `error_bad_fcs` bit from
`terminate` unconditionally, so it pulsed alongside `error_runt` at W + 2: **RED**,
and content-independently red (there are no octets, so the seed is the final value
every time). It is the same defect as F2-a reached by a different route, it is the
frame §10's REQ-102 hook commissions and it is what made this question load-bearing at
WO-0032. A repair confined to path 1 would have left M03-B3 and M03-N2's zero-delivered
`/T/` sub-cases red while F2-a/b went green — the failure mode worth naming, because
the two paths are ~150 lines apart in the source.

#### 3. Expected CI — the standard promotion loop, one snapshot pair

- **Build** (`dune build @default`): **green**. Four combinational hunks and two
  register-width reductions; no new primitive, no new module, no interface change.
  `( >=:. ) : t -> int -> t` verified present in the real Hardcaml signature at
  `comb_intf.ml:409` (and defined at `comb.ml:546`) in this machine's opam sources —
  dv's WO-0034 harness surfaced that path, so the one API name this change relies on
  is checked against the library rather than remembered.
- **Run tests** (`dune runtest`): **green, unaffected**. No committed test elaborates
  M03 — `test/hardcaml_ethernet/` contains `test_word_counter.ml` only — so no expect
  snapshot can move under this change.
- **Generate RTL + determinism** (`Verify nothing was left unpromoted or
  non-deterministic`): **RED, with exactly two paths in the promotion block** —
  `rtl_snapshots/xgmii_rx_64.v` (the gate, the narrowed `q2`, the re-indexed strobe
  ORs) and `rtl_snapshots/eth_mac_10g.v` (which carries M03's body in its hierarchy).
  `rtl_snapshots/xgmii_tx_64.v` and `rtl_snapshots/word_counter.v` **SHALL NOT move**:
  their sources and `Crc32_eth` are untouched, so movement in either is a determinism
  defect and not this change. Second run after promotion: **green** (REQ-902).
- I cannot run any of this: **ADR-0005**, no Hardcaml toolchain here. The elaboration
  and byte-identity evidence is owed by the promoting commit and is not claimed now.

#### 4. Constants dv pins: **none move**

M03-L2/L3's **L = 16 / 12** and **ΔC = 3** are unchanged, and the reason is
structural rather than empirical: the repair adds no register stage, removes no
register stage from the datapath, and touches neither `cov_first`, `cov_end`,
`cov_count`, the alignment window (`off4`, `al_*`), the output decision (`pc`, `nc`,
`strip`, `keep_count`, `emit_*`) nor the state machine. The only registers that move
are `q2`'s two stages, from 4 bits to 3 — a **width**, not a depth, and `q2`'s depth is
what pins the W + 2 report cycle for a frame that emits no word. Every §9 strobe cycle
is therefore where it was, including the three coincidences M03-N2 enumerates. No
attack-plan row's pinned observable changes except the strobe **set** ruling 9
strengthened, which is the point of the work order.

#### 5. WO-0034 harness — present, run, and honest about what it covers

`tools/precompile_check.sh` **was** in the tree at my sitting. Run verbatim:
`bash tools/precompile_check.sh` → **`precompile_check: ALL LANES PASSED`**, exit 0
(Lane 1: 31 units, 0 errors; Lane 2: 12 units, 0 errors; Lane 2b: `ifc_check.ml`
fields agree with 2 UNVERIFIED-TRANSCRIPTIONs — `Axi64.Source`/`Dest` and `base.ml`;
Lane 3a: 43 files, all materialised; Lane 3b: clean).

**It says nothing about this change.** Lane 3a's own disposition line is explicit —
`EXCLUDED hardcaml_ethernet — depends on hardcaml_waveterm hardcaml_ethernet, which
this harness cannot transcribe` — and the harness compiles `test/` only; `libs/` is
outside every lane. So my ADR-0005 blind-writing discipline stands unchanged and I
claim no compile of the RTL. What I did run against this file is what WO-0032 ran and
no more: `ocamlc -stop-after parsing` (exit 0, OCaml 4.14.1) — a **parse**, not a
type-check — plus the two library-source checks named in §3.

#### 6. Two observations for the orchestrator, neither of them mine to act on

1. **At least two other agents are live in this working tree.** My first
   `git status --porcelain` this sitting showed three untracked `tools/` paths and
   nothing modified; my last additionally shows `tools/dv_checks.sh`, `site/build.py`
   and five `site/public/*.html` modified, plus `site/public/og.png` and
   `test/zz_probe_tmp/` untracked. All outside my write scope, none touched by me.
   Flagged for a mechanical reason rather than a procedural one: a `git add -A` before
   my commit would sweep three agents' work into one commit, which R1 and R4 are not
   able to unpick and R7 would refuse. **Stage exactly these three paths**:
   `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`, this packet, and
   `agents/journals/claude_rtl_lead_agent.md`.
2. **dv's outcome model already conforms to the ruling.** `test/xgmii/injection.ml`
   closes a terminate-ended frame with `received < 5` on `error_runt` alone, citing §9
   row 6. So M03-F2/B3/N2 were going to catch this in the bench exactly as the ruling
   predicts, and the repair moves the **RTL** onto text and model that already agreed
   with each other. Stated as an observation about routing, not as a test judgment —
   `SO-` and the plan are dv's.

#### 7. Returned questions: **none**

WO-0032 returned three; this packet returns none. The one carried item is unchanged
and belongs to the promoting commit: **REQ-902** — cite the red determinism run that
produced the diff and the green second run that proves byte-identity.
