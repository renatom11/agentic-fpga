# WO-0025: Re-countersign the moved SPEC-M14 text (the C-37 repair)
- **State**: ISSUED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: the WO-0023 return at **8641455** (ADR-0012 + the
  SPEC-M14 diff set + C-39/C-40 + the five-site relay sweep + the
  ratified batch-F status flip); your own C-37 statement (WO-0022 §3).
- **Evidence**: CI `build` run **30746705765**, conclusion
  **`success`**, SHA **8641455** (docs-only; all twenty lifts still
  elaborate; dv_checks green). Run 30746720184 on f4d41d2 also green.
- **Deliverables**:
  1. **Re-derive the moved M14 text only** (your C-28/WO-0022 bounded
     pattern): §6.1's separation formula with **D = K − M − 3** (the
     cycle deficit — verify it makes the separation 1 − D and that
     "copy iff D ≤ 0" is F-1's rule transposed, with D < 0 reachable
     at M14 where it was not at M17); the under-fill threshold
     N′ ≥ 8⌈N/8⌉ − 11; §6.2's conditional copy + the **Tail-superset
     proof** (a proper superset, unlike M17's equality — check the
     four residues where the word and cycle deficits differ); §10's
     split hook; **§8's 36/37 adjacent pair** (verify it kills the
     three wrong keys: unconditional copy, padding-keyed, and
     M17's-word-deficit-keyed); §11.5 as §11.4's second customer;
     the 183-vs-184 reconciliation (your figure and the spec's are
     different measurement events — confirm both stand); the
     five-site relay sweep.
  2. **ADR-0012's residual judgment**: the bad-FCS minimum frame
     unmarked at the application, carried on four grounds with E2
     reversal conditions. You raised the hazard at WO-0022 — judge
     the disposition as the person who owns the DV-escape ledger's
     shape.
  3. Reaffirm or contest C-39/C-40 as landed; note C-38 declined
     (reasons in the Return log — judge the deferral).
  4. If the moved text holds: the re-countersignature sentence for
     SPEC-M14 at 8641455 for transcription (J-dv_lead-0012). If not:
     the residual list.
  - Journal **J-dv_lead-0012**; Files-in-this-commit = this packet
    (+ any machinery, declared).
- **Out of scope**: everything not moved by 8641455; RTL (rtl_lead
  mid-flight in libs/** — do not read or touch); docs/gates/.
## Task
The close of the first post-freeze behavioural cycle: your largest
finding, repaired one activation after you raised it. Judge the
repair by the standard you set at WO-0022.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-02T18:25Z, journal `J-dv_lead-0012`

**The moved text holds. Every claim in it is true, and true over the whole
admissible space rather than at the worked example.** I re-derived the repair
from SPEC-M14's own cycle rules and then, because this algebra has now produced
the same defect twice, I stopped re-deriving it by hand and quantified over it:
**8 720 452 checks, 0 failures** across every (N, N′) pair M14 and M17 accept
(`tools/check_abort_availability.sh`, new here and declared below). The
re-countersignature is in §9.

Three ledger items come with it. **None blocks**, and I say why in each.

---

#### 1. The re-derivation, item by item against this WO's list

| Item | Verdict | What I checked |
|---|---|---|
| §6.1 separation = **1 − D**, D = K − M − 3 | **CONFIRMED** | Payload word j leaves Ci + 4 + j (the §6.1 cycle table's own rule), so the `tlast` word, index M − 1, leaves Ci + M + 3; input `tlast` at Ci + K − 1; separation = M − K + 4 = 1 − D identically. Verified at every one of the 1.06 M admissible (N, N′) pairs, not derived once |
| **D < 0 reachable at M14** where it was not at M17 | **CONFIRMED** | D ranges **−1 … 184**. D = −1 for N ≡ 0, 5, 6, 7 (mod 8) at full delivery, D = 0 for N ≡ 1 … 4. M17's D = ⌈N/8⌉ − ⌈N′/8⌉ ranges 0 … 183 and cannot be negative. So "copy iff D ≤ 0" is genuinely one rule with a live second branch here and a collapsed one there — the ADR's claim that it is the *same* rule and not an analogous one is exact |
| Under-fill threshold **N′ ≥ 8⌈N/8⌉ − 11** | **CONFIRMED** | Equivalent to D ≤ 0 by integer-ceiling algebra (⌈(N′−20)/8⌉ ≥ ⌈N/8⌉ − 3 ⟺ N′ > 8⌈N/8⌉ − 12), and checked as an iff at every pair. Surviving under-fill = 11 − (8⌈N/8⌉ − N), range **4 … 11** octets by residue — the spec's figure |
| The **21 … 36** band at N = 46, threshold 37 | **CONFIRMED** | 8·6 − 11 = 37; the band is exactly 21 … 36 by enumeration |
| §6.2's conditional copy | **CONFIRMED** | The condition is D and the `Payload` row says so in the words that matter: "it is neither 'the frame carries padding' nor the word deficit `Tail` keys on" |
| **Tail-SUPERSET proof**, and the four residues | **CONFIRMED, and it is a proper superset** | D = W − 1 for N′ mod 8 ∈ **{0, 5, 6, 7}** and D = W for {1, 2, 3, 4} — exactly the four-in-eight split the spec states, verified per residue at every pair. Hence D ≥ 1 ⟹ W ≥ 1 (Tail) always, and the converse fails on the set {W = 1, N′ mod 8 ∈ {0,5,6,7}}: **5 820 witnesses**, the **first of which is (N = 46, total length 37)** — §8's own case. M17's `Tail` ≡ D ≥ 1 is an equality at all 1.1 M of its pairs. The contrast is real and it is the direction a bench writer gets wrong: substituting M17's W predicts a derived 0 where a conformant design must copy, always in that direction |
| §10's split hook | **CONFIRMED, and it is now passable** | Two assertions, opposite outcomes, each driven twice with opposite input bits, Section cell widened to §3, §6.1, §6.2, §9, §11.5. The old hook asserted the bit set, unscoped, over §8's own directed frames — I re-checked those frames: at N = 46 every total length 21 … 28 is D = 2, so the old hook was unpassable on its own commissioned stimulus, not merely under-scoped. That is the half of C-37 I cared most about and it is closed |
| **§8's 36/37 pair kills the three wrong keys** | **CONFIRMED, and the choice is better than it had to be** | Both: N = 46, K = 6, input `tlast` Ci + 5, padding present (10 and 9 octets), `Tail` entered, word deficit **1** for both (⌈36/8⌉ = ⌈37/8⌉ = 5). They differ only in D. 36 → D = 1, M = 2, 16 octets, `tlast` Ci + 5 (**same cycle**), `tkeep` 0xFF. 37 → D = 0, M = 3, 17 octets, `tlast` Ci + 6, `tkeep` 0x01. Unconditional copy fails 36; padding-keyed, `Tail`-keyed and M17-word-deficit-keyed all fail 37. I also checked the two off-by-one D-keyed designs: "copy iff D ≤ 1" fails 36 and "copy iff D ≤ −1" fails 37, so the pair pins the threshold exactly rather than merely separating the classes. **And 36 is not an arbitrary class member**: see §3 below — it is the *largest application-visible* member of the residual at the commonest frame |
| §11.5 as §11.4's second customer | **CONFIRMED** | Same instrument, same price, second gate `SO-ip_eth_rx_64.md`, "whichever comes first decides it for both" recorded at both ends. §11.4's own generalisation corrected in the falsifiable form it was written in, with M10's independent reason supplied. The corrected scope — modules whose output extent is fixed by an in-data count, **M14 and M17 only** — is the bound I gave at WO-0022 and I re-checked it: three specs have a `Tail` state (M10, M14, M17); M10 emits no stream; M03, M06, M08, M16, M19 have no in-data count |
| **183 vs 184 reconciliation** | **CONFIRMED — both figures stand, and neither is a correction of the other** | At N = 1500, N′ = 21: D = 184, payload `tlast` **Ci + 4**, input `tlast` **Ci + 187**, bit readable by a registered output **Ci + 188**. 187 − 4 = **183** = D − 1, the distance to the *presentation* cycle, which is M17's regime-table convention and the spec's figure. 188 − 4 = **184** = D, the distance to the *readability* cycle, which is my WO-0022 figure. §6.1 now states 183 in the M17 convention and names 184 in the same cell. This is the right resolution: one number per event, both named |
| The five-site relay sweep | **CONFIRMED as complete — and it is six sites, not five** | §2's in-scope bullet, §2's not-my-job row, §3's REQ-007 row, §3's REQ-013 row, §4.2's `payload_tuser` **in** row and §4.2's `ip_payload_tuser` **out** row: six. The count "five" appears only in the WO-0023 Return log's prose; the §13 row that is the normative record enumerates all six and states no count, so nothing in a committed specification is wrong. I then grepped every `tuser`, `abort` and `inherit` occurrence in SPEC-M14 and found **no remaining site that states the copy unconditionally**. §7's handshake bullet and §9's truncation rows are about M14's *own* mark (REQ-605), which is always available to it, and are correctly left alone |

**Two nits, recorded and deliberately not made ledger rows.** §6.1 calls total
length 29 "the smallest UDP datagram the programme admits"; the smallest
*admitted* is UDP length 8 / total length 28 (a header record with no payload
frame, §0.7) and 29 is the smallest carrying a payload octet. ADR-0012's
Consequences says §8's "total lengths 20 … 28 … are all inside the band"; total
length 20 emits no payload frame at all and so is outside the question rather
than inside the band — the spec's own §8 note says 21 … 28 and is right. Neither
touches a hook, a number or a class boundary.

---

#### 2. What the repair looks like judged by the WO-0022 standard

The standard I set was: the substance must be right at the module, the hook must
be passable, and the generalisation must stay falsifiable rather than retreat to
something safe. All three are met, and two things exceed the commission.

**The §8 pair is better verification than I asked for.** I raised C-37 as a
formula error with a system consequence; I did not name a discriminating
stimulus. The pair does what a bench writer cannot easily do from the formula
alone — it makes the *wrong keys* fail, and it picks the three a reader is
actually likely to substitute. That is attack-plan work done inside a
specification, and it lands in `test/attack_plans/AP-ip_eth_rx_64.md` verbatim.

**The `Tail`-superset contrast is the trap I would have walked into.** My own
WO-0022 statement leaned on `Tail` as the class marker, because at M17 it *is*
the class marker. It is not at M14, and the specification now says so where a
bench writer trips over it rather than where an architect would file it.

---

#### 3. ADR-0012's residual disposition — judged

**One correction to the WO's framing first, because independence is the thing it
touches.** The WO asks me to judge the residual "as the owner of the DV-escape
ledger". I am not its owner: PROTOCOL §10 and my charter §3 put the DV-escape
ledger in `docs/reports/audit/` and give it to the **auditor**. I judge this
residual as the lead whose sign-off gate closes it (`SO-ip_eth_rx_64.md`), whose
own escape produced it, and who will have to write the benches that live with
it. I have written nothing under `docs/reports/audit/` and will not.

**Verdict: the disposition is correct, the four grounds hold, and the E2
reversal conditions are the right two. I endorse carrying it.** Ground by
ground, with the checks rather than the assent:

1. **"Still reported where detected."** Holds, and the requirement it is
   measured against is the right one. REQ-008/§0.6 prohibit *silent discard* and
   are enforced by frame conservation; on this class M14 **discards nothing** —
   it delivers the frame — so REQ-008 has no instance and `error_bad_fcs` at M03
   still reaches `Status` (REQ-104, REQ-804). What is lost is per-frame
   attribution at the application port, which is a strictly smaller thing and is
   correctly named as such.
2. **"Entered only by an already-invalid frame."** Holds by construction: the
   derived 0 is *right* whenever no abort occurred, so the only harm case is an
   aborted frame. Alternative (d) inverts that — it would mark the ordinary
   64-octet frame invalid — and its rejection is the strongest paragraph in the
   ADR.
3. **"Does not compound."** Holds, and I checked the composite rather than
   accepting it. M17's only source for the bit is M14's output, so a derived 0
   is copied as 0 where M17's D = 0 and replaced by M17's own derived 0
   otherwise: inert either way, and the loss cannot grow downstream. The
   composite — **the application sees the mark iff both stages can carry it** —
   is exactly right and is checked as a predicate in the new tool.
4. **"Nothing bought by blocking."** Holds, and it is the same flip-invariance
   test I applied to C-37 itself and the architect applied to C-38. Both
   documents that would have to move are frozen; the price is the same today and
   at either gate.

**One quantification I add, because it sharpens the residual in both
directions.** At the 64-octet minimum frame carrying a *conformant, fully
packed* datagram, the application-visible loss band is **IPv4 total lengths 29
through 36 — eight values, every one of them D = 1**. Below 29 the IPv4 payload
is at most a bare UDP header, so M17 emits no application payload frame and
there is no `tlast` word at the application to have lost a mark on; at 37 and
above M14 copies. So:

- The residual is **narrower than "every padded frame"** — it is eight declared
  lengths at the minimum frame, all at separation exactly 0.
- And §8's **total length 36 is the largest member of that band**, not an
  arbitrary probe. The pair therefore drives the worst *application-visible*
  case and its immediate neighbour. I did not expect that and it is worth
  recording as a property of the choice.
- The **E2 reversal conditions are correctly chosen**: a Phase-2 feed handler
  treating an unmarked datagram as authoritative, or a link partner with a
  non-negligible bad-FCS rate. Both are exactly the conditions under which
  "eight declared lengths at one frame size" stops being small. Alternative (e)
  — the `error_abort_not_propagated` strobe — is the right named repair and its
  price (a port, a REQ, a `Status` field, three relay rows, an E2) is honestly
  stated. I confirm it is **not** the architect's to take in-role.

**Where I differ from nothing in the ADR but add an obligation on myself**: the
residual is now a standing row in the M14 and M17 attack plans and a named
exclusion in `SO-ip_eth_rx_64.md`, so that no future SO- claims REQ-007 whole at
M14 by silence. That is the mechanism that keeps a carried item from becoming a
lost one.

---

#### 4. C-39 — REAFFIRMED as landed, and CLOSED

requirements.md REQ-710's verification column now reads "the ten excess
**octets — ten octets in two application words and not ten words**", with the
reason (the word carrying declared octets 97–100 also carries 101–104) and the
pointer to SPEC-M18 §8 item 4. The normative sentence is byte-unchanged; §13 row
added, class editorial. My exclusion is honoured — SPEC-M18 §9's "an application
that presents ten excess words" is a legitimate hypothetical and was not
touched. Nothing outstanding. **C-39 closes.**

---

#### 5. C-40 — REAFFIRMED as landed, but **one site short**; C-40 stays OPEN

The sweep is right and the honesty about provenance ("the wrong word was
transcribed faithfully rather than introduced" — from my own WO-0020 owed-diff
clause 2) is the correct record. §3's REQ-007 row now reads "*after* … and not
'on or after', which would admit D = 1", and the four relay statements carry one
parenthetical each.

**But SPEC-M17 §10's REQ-007/REQ-013 hook still reads "copied where that word is
emitted _on or after_ the input `tlast` (§6.1's D = 0)".** The §13 row calls §3's
instance "the sole unpinned instance of a phrase §10 pins" — which is accurate,
because §10's parenthetical does pin it. But it is the same wrong phrase, in the
**hook that commissions the bench**, saved only by a reader who follows the
parenthetical. Compare SPEC-M14 §10, written fresh in the same commit: "copied
where that word is emitted **after** the input `tlast` (§6.1's D ≤ 0)" — correct
in the prose and pinned in the parenthetical. The two hooks should read the same
way, and the one that is right is the new one.

**Disposition**: editorial, one word, no ADR, gated at `SO-udp_ip_rx_64.md` with
the rest of C-40. It does not block anything and I would not have raised it
alone; I raise it because the §13 row asserts the sweep is complete and it is
complete but for this. **C-40 stays open with this single named residual site.**

---

#### 6. C-38 — the declared deferral is CORRECT and I endorse it

The architect declined C-38's spec half and the reasoning is my own test applied
to my own item, which is the only way I would have accepted a decline. Three
things make it right:

1. **The WO conditioned it on cheapness and it is not cheap.** It moves `Body`'s
   Does cell, both forward exits, `Drain`'s entry and Does cells, and `Excess`'s
   "completes the output frame exactly as `Drain` does" sentence — which stops
   being true once the output `tlast` has already left `Body` under §7's pinned
   1-cycle latency — and must be re-derived against §9's pinned strobe cycle.
   That is a second post-freeze **behavioural** repair at a different module.
2. **Its price is flip-invariant.** SPEC-M18 is already FROZEN, so nothing is
   bought by taking it inside the commit carrying the programme's first
   post-freeze behavioural repair. That is precisely the test §11.4 uses, that I
   applied to C-37 itself, and applying it inconsistently would be worse than
   the delay.
3. **Its gate is a different gate.** `SO-udp_ip_tx_64.md`, not
   `SO-ip_eth_rx_64.md`, and my mandatory-row status on the M18 attack plan is
   intact: the declare-96/supply-104 datagram is a required row and it will be a
   bench before it is a reader.

**My standing position is unchanged**: C-38 is a carry, not a contest, on the
C-26 line — requirements.md REQ-710 states the correct reading one level up and
§10's REQ-710 hook asserts it correctly, so both carry criteria are met where at
F-1 neither was. I would still take the repair *before* M18's RTL rather than
after, and that is a sequencing preference, not a condition.

---

#### 7. NEW — **C-41**: the unpassable-assertion defect survives one level up, at
three requirements.md verification columns

This is the same defect class as C-37's first limb — a committed hook
commissioning an assertion no conformant design passes — at the one place
ADR-0012 did not look. It is **cheap**, and the C-39 diff in this very commit is
the proof of how cheap.

After the F-1 repair and now ADR-0012, **three verification columns in FROZEN
requirements.md commission the REQ-007 universal without the D scope**:

- **REQ-007**: "check the abort bit appears on the last word of **every
  downstream stream that emits a frame**". On a bad-FCS 64-octet frame carrying
  total length 29 … 36, M14 emits a payload frame and drives 0. Assertion fails
  against a conformant design.
- **REQ-013**: "a test driving `tuser`[0] = 1 on a `tlast` word and checking
  **every downstream stage still forwards the frame with the bit set**". Same
  shape, same stimulus.
- **REQ-707**: "an end-to-end payload comparison at the application boundary
  with `tuser`[0] propagation checked against **an injected bad-FCS frame**".
  This is the one the residual actually lands on, and it is the *system* bench —
  gated at neither §11.4's nor §11.5's SO- packet.

**Severity, stated honestly and below C-37's.** These three are *satisfiable*:
none of them pins the injected frame's length, so a bench writer who picks
REQ-708's stimulus (64-octet frame, total length 46, UDP length 26 — D = −1 at
M14, D = 0 at M17) passes all three. C-37's §10 hook was **unsatisfiable**,
because it named §8's own directed frames. So this is "an unscoped universal
whose natural stimulus choice falsifies it", not "an assertion no stimulus
satisfies". But the natural choice in a NIC bench *is* the minimum frame, and the
smallest datagram is the canonical error-injection payload.

**Why this is not already priced inside §11.4/§11.5.** Both rows price "one
normative diff to a FROZEN requirement, `traceability.md`'s REQ-007 row and each
implementer's REQ-007 hook" — module §10 hooks. §11.4 further says "REQ-707
needs no diff on either route: it already says `tuser`[0] propagated **per
REQ-007** and inherits whatever scope REQ-007 carries." That is right about
REQ-707's **normative sentence** and silent about its **verification column**,
which is a test commission and inherits no scope from anything.

**The repair, and why it is affordable today.** requirements.md §13's own class
column already distinguishes verification-column changes as **editorial**, and
this commit contains two of them (REQ-709 at WO-0019, REQ-710 as C-39) — neither
needed an ADR and neither touched a normative sentence. So the *unpassable-hook*
half of the REQ-007 problem can close now for three editorial verification-column
diffs and three §13 rows, while the *normative* scoping clause stays carried and
flip-invariant exactly as §11.4 and §11.5 price it. **The two halves have
different prices and have been treated as one item; they should be separated.**

**Disposition**: does **not** block this re-countersignature — it is at
requirements.md, outside the moved surface, and the SPEC-M14 text I am signing is
correct. Gated jointly at `SO-ip_eth_rx_64.md` and `SO-udp_ip_rx_64.md` with
§11.5/§11.4. Recommended as a cheap architect item ahead of the first
receive-chain bench, because a tb_writer working from requirements.md is the
person it hurts. **This is also mine to have missed**: it has been true since the
F-1 repair landed at `d8df28d` and I countersigned batch F without raising it. I
checked §11.4's generalisation and not requirements.md's own verification
columns. Root cause is journalled in `J-dv_lead-0012`.

---

#### 8. NEW — **C-42**: SPEC-M14 §12's countersignature row now records a proof of
the proposition the same document names as false

SPEC-M14 §12's dv_lead row reads: "… and **the abort-bit inequality M + 3 ≥ K
proved for every residue**". What I actually proved at WO-0018
(`J-dv_lead-0009`, Evidence item 7) is
**⌈(N − 20)/8⌉ + 3 ≥ ⌈N/8⌉** — the *second* of §6.1's two inequalities, which is
true in every residue. `M + 3 ≥ K` is the composite §13 now names as the error,
and it is obtained from the true one by the substitution M ← ⌈(N − 20)/8⌉ that
holds only at N′ = N. The freeze record therefore claims a proof of a false
proposition, in the same document whose §13 records that it is false.

The over-statement is **mine, not the architect's** — my own journal's Actions
line made the same substitution, and the architect transcribed the label
faithfully while my Evidence section stated the true proposition.

**Disposition**: editorial, one cell, no ADR, no behaviour. Suggested wording —
"the abort-bit inequality **⌈(N − 20)/8⌉ + 3 ≥ K** proved for every residue: the
true half of §6.1's argument. The false half, M ≥ ⌈(N − 20)/8⌉, was not checked
(ledger **C-37**, ADR-0012)". Does not block. Journals are append-only
(PROTOCOL §4), so my side of the correction is recorded in `J-dv_lead-0012`
rather than edited into `J-dv_lead-0009`, and the architect's side is a §13 row
whenever SPEC-M14 next moves.

---

#### 9. The re-countersignature

The moved text holds. I give it:

> **"I re-countersign the SPEC-M14 text moved by ADR-0012 — §2, §3, §4.2, §6.1,
> §6.2, §8, §10, the new §11.5 and the §13 row — for `P1-spec-freeze`
> testability at `8641455`. SPEC-M14 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0009` for the specification as frozen
> at `3f6accc`, and on `J-dv_lead-0012` for this revision."**

I also record, since it is the correction of my own countersignature: the
SPEC-M17 §11.4 and §13 corrections landed in the same commit are **accepted**,
and SPEC-M17's `J-dv_lead-0011` countersignature stands over them.

The ratified batch-F `DRAFT → FROZEN` flip is consistent with what I signed at
WO-0022 — all four §12 rows cite CI run **30744579228** at **d8df28d** with
`J-dv_lead-0011` in the countersignature cell, and the two specifications that
name a per-spec basis name the right one (M17 the WO-0022 bounded re-review, M18
and M19 their WO-0020 sign-offs). Nothing there needs a further signature from
me.

---

#### 10. Evidence

- **`bash tools/check_abort_availability.sh` → exit 0, `8720452 check(s) run,
  0 failure(s)`**, 2.5 s. New in this commit, `tools/**` (my scope), pure
  bash + awk, **not** wired into `tools/dv_checks.sh` — that script's CI-wiring
  decision is the orchestrator's and this is an on-demand oracle. Every formula
  in it is transcribed from SPEC-M14 §6.1/§6.2 and SPEC-M17 §6.1/§6.2 and cited
  inline; **no RTL was read** (PROTOCOL §10). Selected output:
  - `M14  D over the whole admissible space: -1 .. 184`
  - `M14  in-Tail-but-still-copies witnesses: 5820, first (N=46, total length 37)`
  - `M14  N=46 (64-octet frame): threshold total length >= 37, unavailable band 21 .. 36`
  - `M14  surviving under-fill by residue: 4 .. 11 octets`
  - `M14  worst case N=1500, total length 21: payload tlast Ci+4, input tlast Ci+187, readable Ci+188` / `183 cycles before … PRESENTED` / `184 cycles before … READABLE`
  - `M14  §8 pair, total length 36: D=1  W=1  Tail=yes  payload=16 octets in 2 words, tlast Ci+5, padding=10`
  - `M14  §8 pair, total length 37: D=0  W=1  Tail=yes  payload=17 octets in 3 words, tlast Ci+6, padding=9`
  - `M17  D over the whole admissible space: 0 .. 183` / `Tail == D>=1 EXACTLY`
- `bash tools/dv_checks.sh` → **exit 0**, `dv_checks: all checks passed`;
  `check_records_vs_appendix.sh` **23 checks / 0 failures** (all twenty §4.1
  lifts byte-identical); `check_emitted_verilog.sh` **4 checks / 0 failures /
  4 pending**.
- CI `build` run **30746705765** verified directly via the GitHub API:
  `head_sha` = `8641455ffdfa00697c590c23568c7712cb197beb`, `status` =
  `completed`, `conclusion` = **`success`**, `run_number` 60, `event` = `push`,
  branch `claude/fpga-hardcaml-agent-orchestration-37ceyf`. The head SHA **is**
  the commit carrying the moved text.
- Hand-reproducible from the cited sections, no tooling needed: separation
  = M − K + 4 = 1 − D; D ≥ −1 because 20 ≥ 16 forces
  ⌈(N−20)/8⌉ ≤ ⌈N/8⌉ − 2; threshold N′ ≥ 8⌈N/8⌉ − 11; D − W = −1 for
  N′ mod 8 ∈ {0,5,6,7} and 0 otherwise.
- Sweep completeness checked by grep over SPEC-M14 for `tuser`, `abort` and
  `inherit`: six qualified sites, no unqualified relay statement remaining.
- `git status --porcelain` at the time of writing: only
  `tools/check_abort_availability.sh` untracked. **`libs/` was neither read nor
  touched** (rtl_lead mid-flight); no spec, ADR, gate or audit file was
  modified; no git command beyond `status`, `log`, `show` and `diff` was run.

**Files in this return**: `agents/handoffs/WO-0025_m14-recountersign.md`,
`tools/check_abort_availability.sh`.
