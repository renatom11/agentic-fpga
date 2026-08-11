# AP-M04 — attack plan for `Xgmii_tx_64`

- **Module**: M04 `Xgmii_tx_64` · spec `docs/specs/modules/xgmii_tx_64.md`
- **Status**: **OPEN** — committed before the first M04 bench, as charter §3 and
  ADR-0001 require. Rows are added by appending; no row is ever renumbered.
- **Spec basis**: SPEC-M04 **FROZEN at `f78766e`** (batch B, dv_lead
  countersignature `J-dv_lead-0005`), *plus every §13 row* — the frozen text and
  its recorded diffs together are the specification, which is WO-0024's
  formulation carried to the second XGMII module. The five §13 rows are
  **C-14.1** (`tx_tready` is not 0 "during the gap"), **C-14.2** (the reset
  clause wins over §6.2's `Idle` row), **C-14.5** (a same-cycle configuration
  change is unconstrained), **C-16** (the C+8 acceptance) and **C-31**
  (`error_underflow` and `error_tx_length_mismatch` are ordered and unpinned).
  requirements.md §0.2, §0.3, §0.5, §0.6, §0.7, §9.1, §11, REQ-201 … REQ-210 and
  the programme invariants SPEC-M04 §3 tabulates; SPEC-M01 §6.1/§6.3 (the source
  stream's encoding, which fixes what a bench may drive); SPEC-M02 §6.1 +
  ADR-0006/ADR-0007 (the finished-value convention and the 1-to-8 `octet_count`
  domain M04's CRC enable must never leave). Carry-forwards realised as rows:
  **C-14.1**, **C-14.2**, **C-14.5**, **C-16**, **C-31**, **C-2** (conservation
  machinery, at its first *transmit* module), **C-5** (§0.6's window carries no
  independent information for this module's one strobe — SPEC-M04 §11.3;
  **DISCHARGED 2026-08-11 at `ee47eee`** by §0.6's **fourth reference-word
  clause**, dv countersignature `J-dv_lead-0173` §(c), transcription
  `J-orchestrator-0247`. The prohibition it grounds survives with a better
  ground and the sites are repaired at §9's 2026-08-11 repair row).
- **Derivation (PROTOCOL §10)**: every row below is derived from specification
  text alone. `libs/**`, `top/**` and `rtl_snapshots/**` were **not opened** by
  the author of this plan, at this commit or at any earlier one; in particular
  `libs/hardcaml_ethernet/src/xgmii_tx_64.ml` exists at this SHA and was not
  read. `test/third_party/verilog-ethernet/` was listed (§7's co-sim posture
  turns on what is *in* it) and no file in it was opened, because the module
  this plan attacks has no counterpart there to open.
- **Author**: dv_lead, journal `J-dv_lead-0169`

---

## 0. What this document is, and what it inherits

The format is **AP-M03**'s — `test/attack_plans/AP-xgmii_rx_64.md` §0–§1, which
declared itself the template every later plan follows. Sections 1 to 9 are the
fixed skeleton; this plan adds rows and families and drops no section.

An attack plan is **not** a test list. A test list says what will be run; an
attack plan says, for each attack, **which wrong design it kills**. That last
column is the one the plan exists for: a row whose "kills" cell says only "a
broken design" is a row that has not been thought about, and the auditor is
invited to mine this document for exactly that failure. The bar is a **banked
lesson** here and not only a house style — the seeded corpus carries it, and the
first harvest's own `LC-SO-xgmii_rx_64-21` sharpens it: *a stated kill is a claim
about a stimulus and is re-derived from that stimulus each time the row is
commissioned*. Every Kills cell below names a design that this row's own
Stimulus can distinguish from a conformant one; where it cannot, the row says so
in terms and is NO-ASSERT or GAP rather than decorative.

### 0.1 The three standing rules this plan is bound by from its first line

The M03 era minted these against its own text, one dimension at a time, and each
cost a finding. They bind this document, every packet that quotes it, and every
campaign seal frozen against it. They are restated rather than cited because a
new plan that only points at them will be read as not having them.

> **(i) SHA — `AP-M03` §0.1, minted by `FINDING WO-0066-3` and `FINDING
> WO-0066-6`.** A sentence asserting the result of a census is not the census.
> Any claim that **quantifies over a set** — *"the only row that …"*, *"no unit
> drives …"*, *"the threshold is …"* — is **re-measured at the point of
> citation**, or quoted **with the SHA and the command it was measured at**. A
> set claim carrying neither is not evidence.
>
> **(ii) DOMAIN — `FINDING WO-0077-A1` (MAJOR), 2026-08-11.** Any universal
> quantified over "the bench" is measured over **every producer that drives the
> DUT** — the differential co-simulation lane included — or it is quoted with the
> producer set it was measured over. At M03 this cost a MAJOR finding: a census
> true of `test/xgmii_rx_64/` was relied on as if it were true of every producer,
> and `test/cosim/ours_run.ml` was the second producer nobody had counted.
>
> **(iii) POLARITY — `FINDING RV-0078-S2-13`, 2026-08-10.** A capability claim
> states the set it was measured over, and its polarity does not change that
> obligation. **A claim that a mechanism does not exist is measured over every
> landed construction of the thing in question** — not only over the modules that
> would naturally host one. Before a case is authorised, the producer that must
> emit its stimulus is checked for the capability to express it, and that check
> is a read of the producer's construction surface together with every existing
> construction of the same stimulus, never an inference from the specification
> that commissioned it.

**Rule (iii) is the one this plan pays first, and it pays it in §7.** M04's
machinery question is a capability question of exactly the shape that cost a
worker seat at M03 — *does a driver exist that can withhold a source word on a
chosen cycle?* — so §7 answers it by reading the committed construction surface
and naming the files, never by inferring from SPEC-M04 §9 that the stimulus is
constructible because it is specifiable.

**Rule (ii) has a second consequence here that it did not have at M03**, and it
is stated now because it will be easy to forget later: at M03 the second producer
existed and was uncounted. **At M04 there is exactly one producer today**, the
bench, and §7's co-sim posture says why. Any universal this plan's benches assert
is therefore true over the producer set `{ the M04 bench }` and **must be
re-measured the day a second producer lands**, not merely re-quoted.

### 0.2 What this plan may not claim, stated before any row makes a claim

`AP-M03` grew its prohibition register (§7's four bars) over nine campaigns, each
after a claim had already been made too widely once. This plan opens with the
three that are knowable at its first commit. They are **not** predictions about
M04's quality; each is a statement about an **instrument** that does not exist
yet. **Item 4 was added on 2026-08-11** and carries its date in place: a register
that grows silently cannot be read as a register, and the whole point of opening
with one was that a later reader can tell which bars were foreseen and which were
paid for.

1. **No claim of differential-anchor support for any M04 behaviour.** See §7's
   **BAR T1**: the reference module this boundary would compare against is not in
   the tree, there is no TX harness, and REQ-901 declares no divergence class at
   this boundary. Every row below is **bench-only** until that changes.
2. **No claim that the FCS is right because a loopback accepted it.** REQ-202's
   own verification column forbids it (§2 obligation 2), and the prohibition is
   in the requirement rather than in a bar, which makes it stronger than anything
   this plan could add.
3. **No claim about `error_underflow`'s conformance derived from §0.6's window.**
   Since `ee47eee` the window **has** a reference word for this strobe — §0.6's
   fourth clause makes it the cycle on which the word was required and not
   presented — and the prohibition survives on the clause's **own** closing
   statement: SPEC-M04 §9 pins the pulse on that same cycle, so the pin sits at
   the window's **near** edge and the window *"carries no independent
   information"* (§2 obligation 5, repaired 2026-08-11). **The change of ground
   is the whole of the change**: a green window check said nothing about this
   strobe when the window had no referent, and it says nothing now that it has
   one, for a reason that is written down instead of derived.
4. **No `SO-xgmii_tx_64.md` may report REQ-206 coverage while `M04-G10` is
   neither measured nor declared a gap** (added 2026-08-11; `BUG-0004` §10.3
   item 3, whose closure is `J-dv_lead-0176`). `BUG-0004`'s routes 2 and 3 — the
   pre-loaded back-to-back handover — were fixed **by derivation** and have never
   been measured in either design, so a sign-off that reports REQ-206 without
   naming them absorbs an unmeasured fix by silence. The permitted forms are
   exactly two: **(i)** `M04-G10` measured on the machinery §7 item **T-7**
   commissions, or **(ii)** both routes declared in the `SO-` as an explicit gap
   citing `BUG-0004`. **And the rule that decides whether the composed chain can
   reach them is restated here over the mechanism rather than over a word count**
   (`FINDING BUG-0004-1`, MINOR, mine, filed at that packet's §10.2 against its
   own §6): the question is **not** *"can the chain produce a frame of `W = 2`
   words?"* — it can — but ***"can the chain present a frame whose `tlast` word is
   in this module's hands at or before the cycle the frame starts?"*** The answer
   is no, on SPEC-M04 §7's own note that M07 presents nothing at `C + 8` (its
   word 0 leaves at `C + 9` and is accepted at `C + 11`), which is why both routes
   are reachable **only** by a bench driving M04 directly from a continuous
   source. The conclusion of the original rule survives; its ground does not, and
   a reader who re-derived the protection from the word count would conclude that
   `W = 2` is safe, which route 3 disproves.

## 1. Reading a row

Each row has six cells; the vocabulary is `AP-M03` §1's, unchanged.

| Cell | Meaning |
|---|---|
| **Row** | Stable id, `M04-<family letter><index>`. Ids are permanent: a superseded row is struck in §9's change log and keeps its id; new rows append inside their family. Tests and `SO-` packets cite these ids. |
| **Attacks** | The REQ ids and specification sections the row attacks. A row that cannot name one is not an attack, it is an opinion. |
| **Stimulus** | What the source model presents and what configuration is driven, in the specification's own units (octets DA through FCS per §0.3, cycles counted from the acceptance cycle §6.1's table calls C). |
| **Observable** | Exactly what a bench asserts, at the ports only — the XGMII lane pair, `tx_tready` and `error_underflow`. Nothing internal ever appears here. |
| **Kills** | The wrong design this row detects, stated concretely enough that a reader can see the row fail against it. |
| **Status** | See below. |

**Status vocabulary** (the same six values in every plan):

- **ASSERT** — a bench must assert the Observable. The default.
- **NO-ASSERT** — the stimulus may be driven but the named property must **not**
  be asserted; the clause that forbids it is cited in the Observable cell.
  Asserting it would fail a conformant design, or would freeze an unconstrained
  choice into an accidental requirement.
- **NO-STIMULUS** — the stimulus must **not** be produced at all: it lies outside
  the space the specification constrains, or outside the source contract §3
  fixes.
- **RULING** — the frozen text does not decide the observable. The row records
  every reading and its consequence, and is **not asserted** until a ruling
  lands. A `RULING` row blocks no bench except its own.
- **GAP** — an attack this plan wants and cannot mount. The reason is named and
  the row is carried, not deleted, so a sign-off packet cannot claim the coverage
  by silence.
- **STRUCTURAL** — discharged by a compile-time or script check, not by a
  waveform. Recorded so no `SO-` claims a behavioural test that does not exist.

**One cell of `AP-M03`'s reading rules does not carry, and saying so is the
point.** M03's Observable cells are written against an `Axi64` output stream, so
"nothing internal ever appears here" was enforced by the port list. **M04's
output is not a stream**: it is an XGMII pair that carries a value on every
cycle, including idle ones (SPEC-M04 §3's REQ-002 row). An Observable cell here
therefore names *lanes and cycles* where M03's named *words*, and the discipline
that replaces the stream monitor is §2 obligation 1.

## 2. Standing obligations

These attach to **every** M04 bench and are not repeated per row.

1. **The wire decoder on every bench** (`Dv_xgmii.Tx_decoder`, `observe` on every
   cycle including idle ones, `is_clean` asserted at the end). It is REQ-018's
   third clause made executable — *the link partner decodes transmit-side
   XGMII* — and it is the transmit analogue of M03's protocol monitor. It judges
   REQ-201 (start lane and preamble pattern), REQ-202 (the four wire octets
   against the REQ-305 oracle, plus REQ-304's residue as corroboration),
   REQ-203 (fewer than 60 octets before the FCS), REQ-204 (a gap below `ifg`
   octets by §0.3's convention, or a next start character outside lane 0),
   REQ-205 (a non-idle lane after the terminate character) and REQ-206 (the §9
   underflow word's shape), one violation per breach with its REQ named.
   **What it does not judge is as load-bearing as what it does**: REQ-209's
   cadence and REQ-207's octet-sequence equality are *reported* by it and
   asserted by the bench that chose the lengths, because a spacing is a property
   of a run and the accepted-word sequence is a thing the wire never saw.
2. **The FCS oracle is REQ-305's bit-serial reference and never the design's own
   engine.** REQ-202's verification column states it and states why: *"Feeding
   the frame back through the receiver and through the REQ-304 residue check is a
   supplementary check only: both share the design's own `Crc32_eth` engine, so a
   systematically wrong but self-consistent CRC would pass them."* No row below
   takes an expected FCS octet from a loopback through M03, and no `SO-` may
   offer one. **This is the one external-anchor obligation at M04 that is
   discharged today** (`test/golden/crc32_ref.ml`, independent of `libs/**`),
   and §7's BAR T1 is about the other one.
3. **Transmit-side frame conservation** (§0.6's counting discipline at a
   transmit module, C-2's machinery at its first transmit instance). Every frame
   the source **begins** — every frame whose *first* word M04 accepts — appears
   on the wire exactly once, as a frame closed by its own terminate character or
   as an underflowed frame closed by §9's `/E/` `/T/` word, and no frame appears
   that was not begun. **The counting rule is keyed on the first word and not on
   the `tlast` word, and the difference is not cosmetic**: an underflowed frame's
   `tlast` word is *never accepted* (§9's condition ends at that acceptance), so
   a conservation rule keyed on `tlast` would fail to count the one class of
   frame this module can lose. **One exemption is mandatory**: a frame abandoned
   mid-flight by `clear` (REQ-009,
   SPEC-M04 §7) is `frame_in_exempt`, never `frame_in`, because §7 makes it *the
   only silent frame loss in this specification* — no terminate character and no
   strobe. A conservation monitor without that exemption fails a conformant M04,
   which is the same shape M03's obligation 2 carries for `clear` and
   `cfg_rx_enable`. **No committed monitor implements this** (§7 item T-2); until
   one does, each bench carries the count itself and says so.
4. **Strobe accounting** follows requirements.md §0.6's counting convention as
   revised by **C-23**: a monitor counts **high cycles, never rising edges**.
   M04 owns exactly one strobe (`error_underflow`, §9), so every bench may assert
   an **exact** strobe-event set over its whole run — the anti-vacuity partner
   that M03's five-strobe surface made expensive is cheap here, and a bench that
   asserts only "the expected pulse happened" and not "no other pulse happened"
   is leaving the cheaper half of its own instrument unused.
5. **No bench asserts §0.6's strobe window on `error_underflow`.** The
   prohibition is unchanged; **its ground was replaced on 2026-08-11 and the old
   one is struck rather than quietly overwritten** (carry-forward **C-5**,
   **DISCHARGED** at `ee47eee`; countersigned `J-dv_lead-0173` §(c)).

   > ~~Struck 2026-08-11: *"the window's bound is not defined for a frame that
   > never receives that octet, which is every underflowed frame by
   > construction"*.~~ **False as stated, and it was false when written**:
   > requirements.md §0.6's first clause names *"the last octet that frame
   > **received while it was open**"*, not the frame's final octet, and an
   > underflowed frame **has** received octets — row `M04-G5` asserts that source
   > word 0's octets reach the wire, because REQ-207 forbids dropping an accepted
   > word (`FINDING ABS-1`, MINOR, mine, `J-dv_lead-0173`).

   **The standing ground.** §0.6's **fourth reference-word clause** gives this
   strobe a reference word — *the cycle on which the word was required and not
   presented* — with a ceiling of §0.5's word delay **ΔC = 2** and never REQ-210's
   event delay (SPEC-M04 §7 pins both; a reader taking the other computes a
   ceiling one cycle short). SPEC-M04 §9 pins the pulse on **that same cycle**, and
   §0.6's floor — *not earlier than the cycle the condition first becomes
   decidable* — is that cycle too. **Floor, reference word and pin coincide, the
   ceiling sits ΔC beyond, and the clause therefore states in its own words that
   here the window "carries no independent information".** §9's exact pin, with
   obligation 4's exact strobe-event set, is the whole of the assurance — and
   §0.6's *"a bound, never a licence"* note is why a pulse inside the window but
   off the pin is non-conformant on §9's authority. **This is the M03 lesson
   arriving before the bench instead of after it**: `RV-0057-VERDICT` Finding 2
   established the same disposition where a window's reference word and a module's
   own pin come from the same word, and this clause reaches this module for the
   same reason rather than for a stronger one.

   *One residue, filed and not decided here.* `FINDING ABS-1` also convicts the
   **clause's own stated premise** — that the three earlier clauses "name no
   word" — since the first clause does name one (the source word carrying the last
   octet accepted), which makes the fourth clause an **override** that moves the
   reference one cycle later rather than a hole-filler. Nothing in this plan turns
   on it: with `A` the last accepted source word, the pin is at `A + 1`, the first
   clause's ceiling `A + 2` and the fourth's `A + 3`, so the pin lies inside both
   windows and the change can only loosen a bound already redundant against §9.
   **Route**: architect_docs_lead (§8 item 3).
6. **Every frame the source model presents is checked against §3's contract
   before it is presented.** A stimulus generator nobody has checked is an
   unverified assertion about the design — M03's obligation 5, unchanged, and it
   applies to `tkeep` contiguity here where it applied to frame residues there.
7. **`tdata` positions where `tkeep` is 0 are driven with a poison value, never
   with zero.** SPEC-M01 §6.3 item 5 leaves those positions unconstrained, so a
   design that transmits them is not caught by a stimulus that happens to put
   zeros there — and REQ-203's pad octets **are** zeros, so a zero-filled
   don't-care position is indistinguishable from correct padding at exactly the
   place this module is most likely to be wrong. This obligation is the reason
   M04-C4 can exist at all.

## 3. Stimulus legality

REQ-018 fixes the *link partner's* contract at the wire; at M04 the contract that
binds a bench is the **source** contract, and it is SPEC-M01 §6.1 read with
SPEC-M04 §3's own table. Five consequences bind every row below.

- **`tkeep` = 0 with `tvalid` = 1 is never driven.** SPEC-M01 §6.1 says it is
  never produced and SPEC-M04 §3's REQ-011 row says M04 **defines no behaviour
  for it**. A row wanting it is not written; a design's response to it is not a
  defect this plan can convict.
- **`tkeep` is `0xFF` on every word but the `tlast` word, and 1 to 8 contiguous
  ones there** (SPEC-M01 §6.1, SPEC-M04 §4.2). Non-contiguous `tkeep` and a
  short non-final word are outside the contract and are never driven.
- **`cfg_ifg` below 12 is never driven** (SPEC-M04 §4.2, requirements.md §9.1:
  values below 12 SHALL NOT be driven, and M04 defines no behaviour for them).
- **A configuration change is never landed on its own sampling cycle.** SPEC-M04
  §6.3 item 5 (C-14.5) leaves the outcome deliberately unconstrained and says in
  terms that *"a bench that changes either input on the sampling event's own
  cycle and asserts either outcome is flaky by construction and SHALL NOT be
  written."* This plan does not write one (M04-O3).
- **`tuser`[0] and `tstrb` may be driven arbitrarily** (REQ-013, REQ-014) — and
  are, because "ignored" is a claim about the design that only a stimulus which
  varies them can test.

**One asymmetry with `AP-M03` §3 is worth stating rather than leaving to be
noticed.** At M03 the stimulus space is the *wire*, and REQ-018's contract narrows
it. At M04 the stimulus space is the *source stream plus its timing*, and the
timing half has no contract at all beyond the handshake: a source may present a
word on any cycle, or not present one. **That is not a gap in the specification —
it is REQ-206.** Withholding a word is not an illegal stimulus here, it is the
error condition, which is why family G is the largest in this plan and why
REQ-016's idle tolerance has no instance at this port (SPEC-M04 §3's REQ-016
row, §7's handshake bullet).

---

## 4. The rows

**One arithmetic identity is used by four families and is derived here once, from
§6.1 and §0.3, so that no row restates it and no two rows disagree.** Let `P` be
the frame's destination-address-through-payload length (REQ-203's unit) and
`F = max(P, 60) + 4` its length DA through FCS (§0.3's unit). With the preamble
occupying exactly one word and the frame's octet 0 in lane 0 of the next word
(§6.1, REQ-201):

> **frame octet `i` is at lane `i mod 8` of the word at cycle `C + 2 + ⌊i/8⌋`**,
> where `C` is the cycle the frame's first source word is accepted;
> **the terminate character is at octet index `F`, hence lane `F mod 8`, at cycle
> `C + 2 + ⌊F/8⌋`**;
> and with the terminate character in lane `t`, the next start character is
> **`g = ⌈(cfg_ifg + t)/8⌉`** words later, an actual gap of **`8g − t`** octets
> (§6.1's gap paragraph).

Checked against §6.1's own cycle-by-cycle table at `P = 60`: `F = 64`, `t = 0`,
terminate at `C + 2 + 8 = C + 10` ✓, `g = ⌈12/8⌉ = 2`, next start character at
`C + 12` ✓, gap `16 − 0 = 16` octets ✓, start-to-start 11 cycles ✓. **The table
and the formulae agree at the one length the table states**, which is the whole
of the cross-check available from the specification and is stated rather than
assumed.

### 4.A Preamble, SFD and the start lane — REQ-201, REQ-012, §6.1

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-A1** | REQ-201, §6.1's preamble paragraph, §6.3 item 2 | One `P = 60` frame into an idle transmitter with the gap already served, `cfg_ifg` = 12, `cfg_tx_enable` = 1 | Exactly one word carries `/S/`; it is in **lane 0**; on that word `xgmii_txc` = 0x01 — bit 0 set, **bits 1–7 clear**; `xgmii_txd` lane 0 = **0xFB**, lanes 1–6 = **0x55** each, lane 7 = **0xD5**; the word is at cycle `C + 1` | A design emitting 802.3's seven-octet preamble plus SFD **across two words** (start character in lane 0, destination address beginning at lane 4 of the next word) — the decomposition the reference's lane-4 machinery makes natural and REQ-201 forbids in Phase 1. A design marking the whole preamble word as control (`xgmii_txc` = 0xFF), which a checker reading only `xgmii_txd` cannot see. A design emitting 0xD5 and 0x55 in the wrong order, invisible under any check that only counts preamble octets | ASSERT |
| **M04-A2** | REQ-201, REQ-012, REQ-021, §6.1's "no rotation" clause | (same frame) | Frame octet 0 is at **lane 0 of the word at cycle `C + 2`** — the preamble occupies exactly **one** word and no frame octet shares it | A design that inserts the preamble as octets rather than as a word and so rotates the frame by the preamble length; a design emitting two preamble words (which pushes every frame octet one cycle late and is otherwise well formed, so only an absolute cycle assertion catches it) | ASSERT |
| **M04-A3** | REQ-201, §10's REQ-201 hook (*"decode 100 transmitted frames"*) | 100 consecutive `P = 60` frames from a continuous source at the default gap | The count of words carrying `/S/` is **exactly 100**; every one is in lane 0 with A1's exact preamble word; **no `/S/` appears between a start character and its frame's terminate character** (the decoder's own REQ-201 judgement, obligation 1) | A design re-emitting a preamble mid-frame on a source stall; a design that emits one preamble for two frames when the gap is short, which a single-frame bench cannot reach | ASSERT |
| **M04-A4** | REQ-201, REQ-009, REQ-206 | Three frames: one after `clear` returns to 0, one after a normally terminated frame, one after an **underflowed** frame (family G's stimulus) | All three carry the **same** preamble word, byte for byte and control bit for control bit | A design whose preamble content or control marking is a function of the previous frame's ending — the state-bit reuse that an all-clean-frames bench never reaches, and the reason this row drives three predecessors rather than one | ASSERT |
| **M04-A5** | REQ-201, §6.3 item 4, §7's reset bullet | (A4's first member) | **The number of idle words before the first frame after `clear`, and the absolute cycle of that frame's start character relative to the release of `clear`, are NOT asserted.** §6.3 item 4 leaves the count unconstrained beyond the first frame's gap obligation, and §7 records that the first frame has **no REQ-204 instance** at all, there being no preceding terminate character | — (a row that exists to stop a bench freezing an unconstrained start-up delay into a snapshot, which is the defect `AP-M03` §4.A's M03-A4 exists for at the other port) | NO-ASSERT |

### 4.B Frame octets, `tkeep` and the word cadence — REQ-012, REQ-021, REQ-011, REQ-015

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-B1** | REQ-012, REQ-021, §6.1's frame paragraph | One `P = 60` frame whose octets are **position-dependent** (`Frame.stress_frame`'s filler), not uniform | Frame octet `j` appears at `xgmii_txd`[8·(j mod 8)+7 : 8·(j mod 8)] of the word at cycle `C + 2 + ⌊j/8⌋`, and **at no other position among the frame's own wire octets, indices `0 … F−5`** (DA through the last pad octet); `xgmii_txc` = 0x00 on every word carrying only frame octets. **Quantifier repaired 2026-08-11** — it read *"and at no other position"*, a universal over the **run**, which is falsifiable by arithmetic at this row's own stimulus: the idle character `/I/` is `0x07`, a position-dependent filler containing `0x07` collides with it on every idle lane of the run, and the four FCS octets are a computed value that may equal any octet. The excluded classes are judged where they belong — the FCS against the REQ-305 oracle (M04-D1), the idle lanes by the decoder's REQ-205 judgement (obligation 1) — and never by a content scan. Cured operationally before it was ever executed, at `WO-0080` §6.3 assertion 4, on the worker's own reading | Lane reversal within a word, a byte-swapped word, and a rotation by 4 — **all three are invisible under uniform filler**, which is why the filler is position-dependent and why this is stated in the Stimulus cell rather than left to a bench writer's taste (`AP-M03` §4.A's M03-A5, the same defect class at the other port) | ASSERT |
| **M04-B2** | REQ-011, §4.2's `tkeep` row, SPEC-M01 §6.1 | `P = 20`, so the `tlast` word carries `tkeep` = 0x0F, with positions 4–7 of that word driven with poison (obligation 7) | Exactly **4** octets of the `tlast` word appear on the wire, at frame octet indices 16–19; the poison value appears at **no wire octet index `0 … F−5`** — DA through the last pad octet. **Quantifier repaired 2026-08-11** (`FINDING AP-M04-3`, MINOR, mine): it read *"the poison value appears **nowhere** in the whole run"*, and that universal is falsifiable by arithmetic — the four FCS octets are a computed value that may legitimately equal the poison, at roughly one chance in sixty-four per frame, so the row would eventually go red on a conformant design after a content change nobody connected to it. The scan's domain is therefore the frame's own octets, with the FCS **excluded and the exclusion's reason stated**: the FCS is judged against the REQ-305 oracle (M04-D1) and never by a scan. Cured operationally at `WO-0080` §6.0(c) before the row was first executed | A design transmitting the whole final word, which is indistinguishable from correct behaviour whenever the source happens to zero its don't-care positions — and REQ-203's pad octets **are** zeros, so at exactly this module the accidental agreement is total. **What this row does NOT kill, stated because the temptation is real**: a design reading `tkeep` as a *count* rather than as a mask is **not** distinguishable here, because §3 forbids driving a non-contiguous `tkeep` and the two readings agree on every legal stimulus. A row claiming that kill would be claiming a stimulus this plan may not drive | ASSERT |
| **M04-B3** | REQ-015, §2's "knowing a frame's length" row | Two frames back to back, `P = 1514` then `P = 20` | Each frame's wire octet count is its own `F` — 1518 then 64 — and each terminate character is at its own `F mod 8` | A design that latches a length from the first frame, or that derives the second frame's padding decision from the first's octet counter without clearing it. The **order matters**: long-then-short is the direction in which a stale counter produces a *conformant-looking* short frame, and short-then-long the direction in which it produces a visible over-run, so a bench driving only one order tests one of the two | ASSERT |
| **M04-B4** | REQ-011, REQ-015, §6.1 | The directed set `P ∈ {1, 20, 59, 60, 61, 64, 67, 1514}`, each into an idle transmitter | For each, the terminate character is at octet index `F` and cycle `C + 2 + ⌊F/8⌋`, and the wire carries exactly `F` octets between the preamble word and the terminate character | An off-by-one in the octet counter that only shows at one residue class — a defect that a single-length bench passes by construction. The set is chosen to cover the pad boundary (1, 59, 60, 61), every terminate lane through family E, and the maximum length | ASSERT |
| **M04-B5** | REQ-011, REQ-012, §2's not-my-job table (*"nobody"* knows the length in advance) | `P = 1514` — the maximum frame, `F = 1518` | 1514 frame octets on the wire, **no pad octet**, 4 FCS octets, terminate character at lane `1518 mod 8` = **6** | A design with an 8-bit octet counter (1518 > 255 wraps at octet 256 and pads a maximum frame as if it were short); a design that truncates or marks at a length threshold — M04 **has** no length threshold, and a design that borrowed one from its receive-side sibling would be caught here and nowhere else in this plan | ASSERT |

### 4.C Padding — REQ-203

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-C1** | REQ-203, §10's REQ-203 hook | `P = 20` (the hook's own frame) | **60** octets before the first FCS octet; wire frame octets at indices **20 … 59** are all **0x00**; `F` = **64** octets DA through FCS | A design padding to **64** rather than 60 — the confusion between REQ-203's pad target and §0.3's frame length, and the single most likely arithmetic error in this module; a design padding **after** the FCS; a design padding with 0xFF or by holding the last payload octet | ASSERT |
| **M04-C2** | REQ-203's "below 60" predicate | `P ∈ {1, 59, 60, 61}` | 59, 1, 0 and 0 pad octets respectively; `F` = 64, 64, 64, 65 | An off-by-one in the predicate: `≤ 60` pads a 60-octet frame to 61 and a strict `< 59` leaves a 59-octet frame short. **Both directions are driven**, because a bench holding only the short side passes a design that pads one octet too far | ASSERT |
| **M04-C3** | REQ-203's "pad covered by the CRC", REQ-202, §6.1 item 3 | `P = 20` | The four wire FCS octets **equal** `Crc32_ref` over the **60-octet padded** frame, **and do not equal** `Crc32_ref` over the 20-octet unpadded one | A design that closes the CRC at `tlast` and pads afterwards — the most likely padding defect there is, and one that produces a perfectly well-formed 64-octet frame that every length, lane and terminate check in this plan passes. **Both halves of the observable are required**: the positive comparison alone is satisfied by a design that pads correctly, and the negative one is what proves the row could have failed | ASSERT |
| **M04-C4** | REQ-203, SPEC-M01 §6.3 item 5, obligation 7 | `P = 20`, `tlast` word `tkeep` = 0x0F, positions 4–7 driven with **0xA5** | 0xA5 appears at **no wire octet index `0 … F−5`** — DA through the last pad octet, `F − 5` = 59 at this row's `P` = 20; wire octets 20 … 59 are 0x00. **Quantifier repaired 2026-08-11** (`FINDING AP-M04-3`, the same finding as M04-B2's): *"0xA5 appears **nowhere** on the wire"* is falsifiable by arithmetic, the four FCS octets being a computed value that may equal the poison. The FCS is excluded from the scan and judged against the REQ-305 oracle (M04-D1) instead; cured operationally at `WO-0080` §6.0(c) | A design that transmits its final word whole and lets the source's don't-care octets stand in for padding. **This is the row obligation 7 exists for**: under a zero-filled stimulus the defect and the conformant design are byte-identical on the wire, so the bench's own choice of filler is the entire instrument | ASSERT |
| **M04-C5** | REQ-203, REQ-011 | `P ∈ {1, 20, 59}` — one, three and eight source words, all padding to the same 60 | All three place the terminate character in **lane 0** and produce `F` = 64; the pad octet **count** is 59, 40 and 1 | A design whose pad counter is keyed on the **source word count** rather than on the transmitted octet count. The three members differ by a factor of eight in word count and not at all in target length, which is the only stimulus shape that separates the two counters | ASSERT |
| **M04-C6** | REQ-203, obligation 1's bound | (any padded frame) | **The wire decoder's REQ-203 verdict is NOT reported as coverage of REQ-203.** `Dv_xgmii.Tx_decoder` judges *"fewer than 60 octets before the FCS"* — a **necessary** condition — and its own interface says which octets are pad *"is not decidable from the wire alone"*. The sufficient check is C1's and C3's, which know the source frame | — (a row that exists so that a clean decoder report is never read as REQ-203 discharged; the same shape as §0.6's note that a bound inside which a pin already lies carries no independent information) | NO-ASSERT |

### 4.D The FCS — REQ-202, REQ-304, REQ-305, SPEC-M02 §6.1

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-D1** | REQ-202, REQ-305, §6.1's FCS paragraph item 4 | The directed set of M04-B4 | The four wire octets at frame indices `F−4 … F−1` equal `Crc32_ref.fcs_octets (Crc32_ref.of_octets padded_frame)` **octet for octet in wire order**, least significant octet first | A byte-reversed FCS — the defect REQ-202's own wire-order sentence exists to prevent, and the one that makes REQ-304's residue non-constant at the far end; a bit-reflected FCS; an FCS taken from M02's register rather than its finished value (ADR-0006's convention, whose two readings differ by exactly the final XOR) | ASSERT |
| **M04-D2** | REQ-304, REQ-202's verification column | (same runs) | `Frame.residue_ok` over the whole decoded frame is **true** | Nothing D1 does not already kill. **The row is carried at NO-ASSERT-adjacent strength deliberately and the reason is in obligation 2**: the residue check reads the same `Crc32_ref` oracle a second time, so it is corroboration that costs one call and is **not** a second independent witness. A packet reporting D1 and D2 as two anchors for REQ-202 is reporting one | ASSERT |
| **M04-D3** | REQ-202's coverage start (*"destination address through …"*) | Two `P = 60` frames identical except in **octet 0** | The two FCS values **differ** | A design seeding the CRC one octet late, or after the SFD — both of which produce a self-consistent FCS that D1's oracle comparison catches only because the oracle covers octet 0. This row is D1's **anti-vacuity partner**: it proves the covered range begins where REQ-202 says it does rather than wherever the design chose, and it fails loudly if the two frames are accidentally identical | ASSERT |
| **M04-D4** | REQ-202, §6.1's *"may share a word with frame octets or occupy a word of their own"* | `P = 60` (`F` = 64) and `P = 64` (`F` = 68) | At `P = 60` the last pad-or-frame octet is at lane 3 and the four FCS octets occupy **lanes 4–7 of that same word**; at `P = 64` the last frame octet is at lane 7 and the FCS occupies **lanes 0–3 of the next word** | A design that always begins the FCS on a word boundary — i.e. that pads to a multiple of eight before appending. It is conformant-looking at every length where the two placements coincide, and `P = 60`, the **minimum** frame and therefore the most-tested length in any suite, is one of them | ASSERT |
| **M04-D5** | ADR-0007, SPEC-M02 §6.1, §6.2's enable paragraph, §6.3 item 1 | (any frame) | **The CRC enable and its `octet_count` are NOT asserted.** They are internal; §6.3 item 1 leaves the register placement and the update mechanism unconstrained. What is observable is D1 at every length in M04-B4's set, and a design driving `octet_count` = 0 on a held cycle is convicted **at M02's own domain check**, not here | — (recorded so that no `SO-` claims a behavioural check of ADR-0007's mechanism at this module; the mechanism's own guard belongs to SPEC-M02) | NO-ASSERT |
| **M04-D6** | REQ-202, REQ-305, the vacuity class `AP-M03` §4.M's M03-M10 records | One `P = 60` frame whose 60 octets are **all zero**, driven **beside** M04-D1's position-dependent frames and never instead of them | The four wire FCS octets equal the oracle's value for the all-zero 60-octet frame, and that value is **printed**; a bench asserts it is **not** 0x00000000 | A design that emits the CRC **seed** (0x00000000, §6.1 item 1) instead of the finished value. **The reason this needs its own row**: at M03 the analogous accident is exact — a four-octet all-zero frame yields REQ-304's residue by accident — and the general form is that a stimulus whose content is the same as a defect's output cannot detect that defect. Here the all-zero frame is the *anti*-vacuity member and the position-dependent frames are the primary ones, which is the opposite arrangement to the one a "test the simplest case first" instinct produces | ASSERT |

### 4.E Terminate placement and fill — REQ-205

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-E1** | REQ-205, §10's REQ-205 hook (*"frame lengths placing the terminate character in each of the eight lanes"*) | `P ∈ {60, 61, 62, 63, 64, 65, 66, 67}`, hence `F ∈ {64 … 71}` and `t = F mod 8 ∈ {0 … 7}` — **the eight-lane sweep, derived from §4's identity and not sampled** | For each member: `/T/` (0xFD) at lane `t` of the word at cycle `C + 2 + ⌊F/8⌋`, with `xgmii_txc` bit `t` set | A design that always emits the terminate character in lane 0 of the word after the last FCS octet — which is **correct at `t = 0`**, i.e. correct at the minimum-length frame every suite drives first, and wrong at the other seven. An off-by-one that overwrites the last FCS octet (`t − 1`) or leaves a stale data octet at lane `t` (`t + 1`) | ASSERT |
| **M04-E2** | REQ-205's fill clause, §6.3 item 2 | (E1's eight members) | Every lane of the terminate word **after** lane `t`, and every lane of every gap word up to the next start character, carries `/I/` — `xgmii_txc` bit set **and** `xgmii_txd` = **0x07** | A design setting the control bits on the fill lanes but leaving the previous word's data underneath. A decoder reading only `xgmii_txc` passes it; §6.3 item 2 makes `/I/`'s **value** normative, so the row asserts the value too, and that sentence is the only reason the defect is reachable | ASSERT |
| **M04-E3** | REQ-205, the empty-fill boundary | `P = 67` (`t = 7`) beside `P = 60` (`t = 0`) | At `t = 7` the terminate word has **no** fill lane and the whole gap is subsequent words; at `t = 0` it has **seven** | A fill loop written over `t + 1 … 7` with an unguarded range — which at `t = 7` either writes nothing (conformant) or wraps into lane 0 of the same word (destroying the last FCS octet of the frame it just closed). The pair is driven because only the `t = 7` member can distinguish them and only the `t = 0` member proves the loop runs at all | ASSERT |
| **M04-E4** | REQ-205, REQ-011 | `P = 1514` (`F` = 1518, `t` = **6**) | `/T/` at lane 6 of the word at cycle `C + 2 + 189` | A lane index computed from a truncated counter: at 1518 octets any counter narrower than 11 bits gives the wrong residue, and every shorter frame in this plan hides it | ASSERT |
| **M04-E5** | REQ-205, REQ-206, §9's stream-effect cell | The underflow stimulus of family G | **REQ-205's *"immediately after the last FCS octet"* has NO INSTANCE on an underflowed frame**, because §9 appends **no FCS** to one. The terminate character there is §9's, at lane 1 of the `/E/` word, and a bench asserting REQ-205's placement rule universally **fails a conformant M04** on every underflowed frame | — (the trap is the row: REQ-205 reads as a universal about terminate characters and is scoped by §9 to the frames that have an FCS. Recorded before the first bench so that the assertion is written scoped rather than repaired after it goes red, which is the sequence `SCR-M03-I4` cost this programme once already) | NO-ASSERT |

### 4.F The inter-frame gap, and the DIC ruling — REQ-204, REQ-209, §0.3, §11

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-F1** | REQ-204, §6.1's gap paragraph, §10's REQ-204 hook | Two `P = 60` frames back to back from a continuous source, `cfg_ifg` = 12 | Terminate character at lane 0 of cycle `C + 10`; next start character at cycle `C + 12`; the gap **from the terminate character inclusive to the next start character exclusive is 16 octets**; **88 octets between successive start characters**, which is REQ-204's own verification figure | A design that serves no gap at all, or one word of gap. **What it does NOT kill, and the reason is arithmetic**: the wrong convention — twelve *idle* octets *after* the terminate character, which §0.3 names and rejects — yields the **same** 16 octets at `t = 0`. This row cannot see it; M04-F2 can, at exactly one of its eight members | ASSERT |
| **M04-F2** | REQ-204, §0.3's convention paragraph, §6.1's `g = ⌈(cfg_ifg + t)/8⌉` | The first frame of a pair swept over `P ∈ {60 … 67}`, so the terminate lane `t` runs 0 … 7; `cfg_ifg` = 12 throughout | For each `t`: next start character `g = ⌈(12 + t)/8⌉` words after the terminate word, an actual gap of `8g − t` octets — **16, 15, 14, 13, 12, 19, 18, 17** for `t` = 0 … 7. Every value is ≥ 12 and every start character is in lane 0 | **§0.3's rejected convention** — counting twelve idle octets *after* the terminate character rather than twelve *from it inclusive*. Worked out at every residue, the two conventions give the same answer at `t ∈ {0,1,2,3,5,6,7}` and differ **only at `t = 4`**, where this specification gives **12** octets and the rejected reading gives **20**. **A bench that samples this sweep instead of driving all eight members has a seven-in-eight chance of missing it**, which is why the Stimulus cell names the whole sweep and why `t = 4` (`P = 64`) is called out here rather than left to be noticed. §6.1 names the same two numbers — *"16 octets for t = 0 and 12 octets for t = 4"* — and this row is what makes that sentence executable | ASSERT |
| **M04-F3** | REQ-204, REQ-802, §4.3's `ifg` row | `cfg_ifg` ∈ {12, 13, 16, 20, 255}, each with `t = 0`, the value stable from well before the terminate character | `g = ⌈cfg_ifg/8⌉` words and a gap of `8g` octets: **16, 16, 16, 24, 256** | A design reading `cfg_ifg` as a **word** count (at 20 it would serve 160 octets); a design ignoring `cfg_ifg` and hard-wiring 16, which the default value hides — note that 12, 13 and 16 all give 16, so **the default cannot distinguish a configurable design from a fixed one** and 20 is the smallest member of this set that can; a design saturating an 8-bit accumulator at 255 | ASSERT |
| **M04-F4** | REQ-204's "never shortened", §0.3's *Against deficit idle count*, §11 | 10 000 consecutive `P = 60` frames, `cfg_ifg` = 12 (family I's run, read for its gaps) | **Every** measured gap is exactly **16** octets; no gap of 8, 9, 10 or 11 appears anywhere in the run; the criterion is the **minimum and the constancy**, never the average | A design implementing **deficit idle count** — shortening a later gap to as little as 9 octets so the average holds at 12. **This is the one row in this plan whose kill is a design that is right by IEEE 802.3 clause 46 and wrong by this specification** (§0.3 and §11 put DIC out of Phase-1 scope; §2's not-my-job table says *"nobody"* owns it), and it is the reason the observable is stated as a per-gap constant rather than as a mean: a DIC design passes any mean-based check by construction | ASSERT |
| **M04-F5** | §0.3's receive paragraph, REQ-004 | (no new stimulus) | **A bench SHALL NOT assert an average gap, SHALL NOT assert a gap of exactly 12 octets at `t = 0`, and SHALL NOT import §0.3's receive-side spacing.** §0.3 describes **two opposite behaviours one paragraph apart**: the *receive* path assumes a DIC-capable partner alternating lane-0 and lane-4 starts at 10-and-11-cycle spacing, and the *transmit* path rounds every gap up to 11 cycles on lane 0 only. A transmit bench built from the receive paragraph fails a conformant M04 on **every** frame | — (the row exists because the two paragraphs share a section and a vocabulary, and the receive one is the one this programme has been living in for nine campaigns; the mis-import is not hypothetical, it is the default) | NO-ASSERT |
| **M04-F6** | REQ-204, REQ-206, §9's stream-effect cell (*"the gap is then served from that terminate character"*) | An underflowed frame (family G's stimulus) followed by a normal frame, `cfg_ifg` = 12 | The gap is measured from §9's terminate character — **lane 1** of the `/E/` word, so `t = 1` — giving `g = ⌈13/8⌉ = 2` words and a gap of **15** octets, with the next start character in lane 0 | A design serving **no** gap after an abort (the next preamble immediately), and a design measuring the gap from the **`/E/`** character rather than from the `/T/` (`t = 0`, gap 16). **The second defect is one octet from conformant and passes every `≥ cfg_ifg` check**, so the observable is the *exact* placement and not the minimum — a row asserting only REQ-204's inequality here would be green against it | ASSERT |

### 4.G Underflow — REQ-206, §9, §7's handshake bullet

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-G1** | REQ-206, §9's row, §10's REQ-206 hook | `P = 1514`; the source presents every word except the one required at cycle `C + k` for a mid-frame `k`, and resumes afterwards | `error_underflow` pulses **exactly once**, on cycle `C + k` — §9's pin, *"the cycle the word was required and not presented"*. The words already accepted are transmitted. At cycle `C + k + 2` the wire carries one word with **`/E/` (0xFE) in lane 0, `/T/` (0xFD) in lane 1, `/I/` in lanes 2–7**, `xgmii_txc` = 0xFF. **No FCS octet is appended.** The gap is then served from that terminate character | A design with any elastic buffering at all — §11 records its absence as a **decision**, so a design that tolerates one missing cycle is not a kinder design, it is a different specification. A design appending a valid FCS to the truncated frame, which §9 names as the worse alternative in terms: it puts a **well-formed short frame** on the wire that the link partner accepts as real. A design dropping the already-accepted words, which REQ-207 forbids unconditionally and SPEC-M04 §11.2 records as **compelled** rather than chosen | ASSERT |
| **M04-G2** | §9's *"Strobe cycle, pinned"* paragraph | (M04-G1's run) | The strobe is at cycle `C + k`; the `/E/` word is at cycle `C + k + 2`; **the separation is exactly two cycles**, which is §6.1's own transmit rule (*"a source word accepted on cycle C + m is transmitted on cycle C + m + 2"*) read at the slot the missing word would have filled | A design pulsing the strobe when the wire consequence appears rather than when the condition is decidable — two cycles late, still one pulse, still one `/E/` word, and **invisible to any bench that asserts only that both happened**. §9 warns against the inverse error in terms (*"a bench must not expect the strobe and the `/E/` on the same cycle"*), and this row is that warning turned into the assertion it implies | ASSERT |
| **M04-G3** | REQ-206, §9's co-occurrence bullet (*"Two underflows on one frame: impossible"*) | `P = 1514`; the source withholds the required word at `C + k` **and** at `C + k + 1`, `C + k + 2`, `C + k + 3` | **Exactly one** pulse, at `C + k`; exactly one `/E/` word; the frame is over. The later withheld cycles produce nothing, because there is no open frame to underflow | A design pulsing once per missing cycle — four pulses where one is required, which a single-cycle stall cannot distinguish from correct behaviour. **The impossible case is not driven**: two underflows *on one frame* cannot be produced because the first ends the frame, so this row drives the stimulus that *looks* like it should produce two and asserts one | ASSERT |
| **M04-G4** | REQ-206's scope clause, §7's C-16 consequence 1 | `P = 60`; the source presents nothing at cycle **`C + 8`** — the cycle after the frame's `tlast` word is accepted — and `tx_tready` is 1 there | `error_underflow` is **0** on `C + 8` and on every cycle of the run; the frame transmits intact with its correct FCS and terminate lane | **A faithful implementation of a partial reading of REQ-206.** Its first clause — *"the transmitter asserts `tready`, requires a word, and no word is presented"* — is true at `C + 8`; what excludes it is the qualifier *"before it has accepted that frame's `tlast` word"*, and §7 needed the whole **C-16** diff to say so, ending with *"this is the one cycle in a frame's life where `tx_tready` = 1 with `tx_tvalid` = 0 means nothing at all."* **This is the highest-value row in the family**: the defect is not carelessness, it is the requirement read to its first full stop | ASSERT |
| **M04-G5** | REQ-206's *"after the transmitter has emitted a frame's start character"* | `P = 60`; the source withholds the word required at cycle `C + 1` — the earliest cycle the condition can hold | Strobe at `C + 1`; `/E/` word at `C + 3`; **frame octets 0–7 (source word 0) are on the wire** at `C + 2`, because REQ-207 forbids dropping an accepted word | A design whose underflow detection arms one cycle late (nothing pulses, and the design stalls or emits a malformed frame); a design that discards word 0 on an abort, which produces a frame with a preamble, no octets and an `/E/` — well formed by §9's shape and wrong by REQ-207 | ASSERT |
| **M04-G6** | REQ-206's *"and that the next frame transmits correctly"*, REQ-202, REQ-203 | An underflowed frame followed by a `P = 20` frame | The second frame carries the full preamble word, 40 pad octets, an FCS equal to the REQ-305 oracle over its own padded 60 octets, and its terminate character at lane 0 | A design whose CRC register is not re-seeded after an abort — the second frame's FCS then covers the first frame's octets too, and **every structural check in this plan passes it**: the length is right, the pad is right, the terminate lane is right, and only the oracle comparison of M04-D1 speaks. This row is why obligation 2's independence matters more than its convenience | ASSERT |
| **M04-G7** | §0.6's strobe window and its **fourth** reference-word clause, C-5 (DISCHARGED), SPEC-M04 §11.3 | (any underflowed frame) | **§0.6's window is NOT asserted for `error_underflow`.** Its reference word for this strobe is §0.6's fourth clause's — *the cycle on which the word was required and not presented* — and its ceiling adds §0.5's **word delay ΔC = 2**, never REQ-210's event delay. SPEC-M04 §9 pins the pulse on **that same cycle**, which is also §0.6's floor, so **floor, reference word and pin are one event and the clause itself states that the window "carries no independent information" here**. §9's exact pin is the whole of the assurance, together with obligation 4's exact strobe-event set; §0.6's *"a bound, never a licence"* note is why a pulse inside the window but off the pin is non-conformant on §9's authority and not on the window's. **Ground repaired 2026-08-11 (`FINDING ABS-1`, MINOR, mine)** — this cell read *"an underflowed frame **never receives that octet** — the window has no reference word, so a check against it is not loose, it is undefined"*, which was **false when written**: §0.6's first clause names the last octet the frame *received while it was open*, and an underflowed frame has received octets, as M04-G5 asserts in this very family. The status and the conclusion do not move; only the ground does | — (obligation 5 restated at the row that would otherwise be the natural site for the assertion; the M03 precedent is `RV-0057-VERDICT` Finding 2, where a window whose reference word coincided with the module's own pin was found to carry *no independent information* — this module reaches the same disposition by the same route, not by a stronger one) | NO-ASSERT |
| **M04-G8** | REQ-008, obligation 3, §0.6's conservation equation | (M04-G1's run) | The underflowed frame is counted **once** on the wire — as a frame that began and ended — and its `tlast` word is **never accepted**, so no bookkeeping keyed on `tlast` acceptance sees it at all | A conservation monitor keyed on `tlast` (which silently exempts the one class of frame this module can lose) and a design that neither terminates nor strobes an underflowed frame. **The monitor defect and the design defect produce the same green**, which is why obligation 3 states the counting rule in the plan rather than leaving it to the monitor's author | ASSERT |
| **M04-G9** | REQ-206's qualifier clause (*"before it has accepted that frame's `tlast` word"*), §7's C-16 consequence 1, §9, §4's identity | **A single-word frame** — `W = 1`, i.e. `P ∈ 1 … 8`, the one source word carrying both the frame's first octet and its `tlast` — presented to an idle transmitter with the gap already served; nothing presented afterwards, the cycle after the acceptance being the post-`tlast` cycle §7 authorises | **`error_underflow` is 0 on every cycle of the run** — obligation 4's exact strobe-event set is **empty** — and the frame transmits intact: preamble word at `C + 1`, its `P` octets from `C + 2`, `60 − P` pad octets, four FCS octets equal to the REQ-305 oracle over the padded 60, terminate character at octet index `F` = 64, lane 0, cycle `C + 10`. **REQ-206's window is provably EMPTY at this shape**: its condition opens after the start character and closes at the `tlast` acceptance, and here the `tlast` word is accepted at the cycle the frame starts, so no cycle lies inside it | **A design that strobes `error_underflow` after a single-word frame's only acceptance — and this is not a hypothetical: it is the defect measured red at `fcf6f08` and green at `02f762a`** (`BUG-0004`, MAJOR, route 1, CLOSED at `af06c62`), found by a standing instrument on stimuli commissioned for the pad boundary rather than by any row, because **this plan had no row for the shape** (`J-dv_lead-0175`). The wider class: any design whose underflow condition is evaluated without REQ-206's qualifier at the one frame shape where the opening acceptance **is** the `tlast` acceptance. **`M04-G5` is the opposite-verdict neighbour** — it drives the earliest cycle at which the condition *can* hold and asserts a pulse, where this row drives the shape at which it *cannot* and asserts silence; a design passing either alone is not thereby right, and the pair is what separates *detects an underflow* from *detects the absence of a word* | ASSERT |
| **M04-G10** | REQ-206's qualifier clause, §7's C-16 acceptance at `C + 8`, §9, `BUG-0004` §9.3's routes 2 and 3 | **Needs machinery T-7 and is not mountable at this commit.** A direct-drive continuous source with a **controllable handover cycle**: a frame accepted at `C`; the next frame's first word presented and accepted at **`C + 8`** — the acceptance §7's C-16 authorises — and that frame started from the held word at `C + 11`. Two shapes: **(a)** the held frame is `W = 1` (`BUG-0004` route 2); **(b)** the held frame is `W = 2`, **fully pre-loaded**, its `tlast` word accepted at `C + 11` (route 3) | **`error_underflow` is 0 on every cycle of both runs** — in particular **not** at `C + 12` in (a) and **not** at `C + 13` in (b), the two cycles at which the unfixed design strobes by `BUG-0004` §9.3's derivation — and both frames transmit intact with their own FCS and terminate lanes, with the second frame's start character where M04-H4 puts it (an acceptance at `C + 8` does not move it) | **The two routes `BUG-0004` §9.3 derives, which its own §1 stimulus cannot reach and which no committed bench can produce.** Both were fixed **by derivation** and **neither has ever been measured, in either design** — the class a sign-off absorbs by silence, which is why §0.2 item 4 bars a REQ-206 coverage claim that neither measures them nor declares them. The row also kills a **bench-side** defect: a suite reporting REQ-206 coverage on route 1 alone. **`M04-G5` is the opposite-verdict neighbour here too**, and (b) is the shape that refutes *"`W ≥ 2` is what the chain can produce, therefore the chain is safe"* — the ground `FINDING BUG-0004-1` withdraws (§0.2 item 4) | ASSERT |

### 4.H Backpressure and the no-drop rule — REQ-207, §7's throughput bullet, C-14.1, C-16

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-H1** | REQ-207, §10's REQ-207 hook | A continuous source driving 100 frames of mixed lengths from M04-B4's set | Per frame, the ordered concatenation of the octets of every word for which `tx_tvalid` and `tx_tready` **both** held equals the frame octets on the wire, **exactly once and in order**, before padding | A design dropping a word under its own backpressure, and a design transmitting one twice. The equality is stated per frame and end to end because a per-word check cannot see a duplication that is later compensated by a drop | ASSERT |
| **M04-H2** | REQ-207, §7's throughput bullet | `P = 60`, one frame | `tx_tready` = **0** at cycle `C + 9` (the FCS word) and at `C + 10` (the terminate word) | A design accepting a word it has no slot to transmit — which REQ-207's second clause forbids and which shows up downstream as either a dropped word or a delayed start character, i.e. as some *other* row's failure. This row convicts it at the port where it happens | ASSERT |
| **M04-H3** | REQ-209, §7's C-14.1 bullet, §10's REQ-209 hook | (M04-H2's run, continued into the gap) | `tx_tready` = **1** at cycle `C + 11`, the gap's **last** cycle. **And a bench SHALL NOT assert `tx_tready` = 0 across the whole gap** — REQ-209's own hook says so in those words, §6.1's table has asserted `C + 11` since the specification was written, and the 11-cycle cadence is unachievable otherwise | A design holding `tready` low for the whole gap: every frame still transmits correctly and REQ-209's cadence silently becomes 12. **The superseded specification sentence that would have produced it is quoted in §7** (*"`tx_tready` is 0 during the FCS word, the terminate word and the gap"*) with the note that a bench built from it *"would assert `tx_tready` = 0 at C+11 and fail every conformant design"* — so this row is a bench-side prohibition and a design-side assertion at once | ASSERT |
| **M04-H4** | REQ-209, §7's C-16 bullet and its four consequences | A continuous source presenting a word at cycle `C + 8` | `tx_tready` = **1** at `C + 8`; the word presented there **is accepted** and is the *next* frame's first word; it is transmitted at `C + 13`; **the start character does not move** — the next frame's `/S/` is at `C + 12` whether that word was accepted at `C + 8` or at `C + 11`. **A bench SHALL NOT assert `tx_tready` = 0 at `C + 8`** (REQ-209's hook, in terms) | A design with `tready` = 0 at `C + 8`. §7 derives its consequence exactly: M07 re-enters `Idle` at `C + 8`, would accept at `C + 11` instead, emit its word 0 at `C + 12`, and the composed chain would put start characters **twelve** cycles apart — failing REQ-209 and the composed assertions SPEC-M07 §8 and SPEC-M09 §8 item 5 commission. **The defect is invisible at M04 alone unless this row is written**, because a 12-cycle cadence is only wrong against a requirement no single frame exercises | ASSERT |
| **M04-H5** | §6.3 item 3, §7's throughput bullet | A long gap: `cfg_ifg` = 40, one frame then another | **`tx_tready`'s value on the gap's earlier cycles is NOT asserted.** §6.3 item 3 leaves it unconstrained — M04 may hold it high waiting for a source or gate it on the gap counter. **Two consequences ARE assertable and are what this row commissions instead**: no accepted word is ever untransmitted (REQ-207), and no acceptance moves the next start character earlier than `g = ⌈(cfg_ifg + t)/8⌉` allows (REQ-204) | — (a row that exists to stop a bench freezing one legal `tready` policy into a snapshot, and to say what may be asserted in its place rather than only what may not) | NO-ASSERT |
| **M04-H6** | REQ-207, §6.1's *"exactly two words are in flight"*, §7's C-16 consequence 4 | A continuous source over 100 frames | At every cycle, (words accepted so far) − (source words transmitted so far) ≤ **2**; and after an acceptance at `C + 8`, `tx_tready` is **0** at the next frame's preamble cycle `C + 12` | A design whose acceptance policy is not backed by a transmit slot. **The depth itself is not asserted** — §6.3 item 1 makes the register placement unconstrained — so the observable is the port-visible count identity and not a claim about storage. The `C + 12` half is the one direction §7 pins: if no word was accepted at `C + 8`, `tready` **may** be 1 at `C + 12`, and that half is M04-H5's | ASSERT |

### 4.I Throughput and cadence — REQ-209, §8

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-I1** | REQ-209, §8's stress obligation, §10's REQ-209 hook | **10 000** consecutive `P = 60` frames from a continuous source, `cfg_ifg` = 12 | The mean is **11** cycles per frame **and no individual inter-frame spacing differs from 11** — both, because §8 says in terms that the second is *"stronger than a mean, and it is what §0.4's list would have bought here"* | A design whose cadence is **12** — which is precisely what §7 derives from `tx_tready` = 0 at `C + 8` (M04-H4) — and a design that stutters: an occasional 10 paired with an occasional 12 holds the mean at 11 exactly. **Only the per-spacing clause sees the second**, and a bench asserting the mean alone would report green on a design whose gap logic is intermittently wrong | ASSERT |
| **M04-I2** | REQ-209, anti-vacuity | (M04-I1's run) | **10 000** start characters, **10 000** terminate characters, **10 000 × 64** octets DA through FCS, and **zero** `error_underflow` pulses over the whole run | A bench that computed a spacing statistic over a run in which nothing was transmitted, or in which the source starved and every frame aborted — both of which produce a defensible-looking cadence and no frames. The strobe clause is obligation 4's exact-set discipline used as the cheap half of the instrument | ASSERT |
| **M04-I3** | §8, requirements.md §0.4, charter §5's DoD checklist | (no new stimulus) | **A bench SHALL NOT assert the receive-path line-rate invariant at M04's source port.** §8 says M04 is **not** in §0.4's stress-bench list, REQ-004's invariant is about surviving an arrival rate a module cannot slow down, and M04 *"is the one module in Phase 1 that sets its own pace"*; §4.1's conformance note says M04 is allowed a `tready` **because** it is not a receive-path module. A bench asserting "zero backpressure" fails a conformant M04 at `C + 9` on every frame | — **and it reaches past the bench.** Charter §5's per-module DoD checklist carries the line *"Rx-path modules: back-to-back 64 B frame stress green, zero backpressure asserted"*. At M04 that box is answered **"not applicable, and here is the equivalent"** — M04-I1's sustained run — never run and never silently ticked. Recorded in the plan because the checklist is what a sign-off round reads, and an item answered by the wrong instrument is worse than one answered "N/A" | NO-ASSERT |
| **M04-I4** | REQ-209, REQ-204, §4's identity | One pair of frames at each `P ∈ {60 … 67}` | Start-to-start spacing = `1 + ⌊F/8⌋ + g` cycles, derived per member from §4's identity — **11, 11, 11, 11, 11, 12, 12, 12** for `t` = 0 … 7 | A design whose gap logic is tuned to the minimum frame and mis-rounds elsewhere. **What this row may not claim**: REQ-209 pins **only** the minimum-length cadence, so every value above except the first is a *consequence* of REQ-204's rounding rather than an independent requirement — the bench derives them from the identity and never tabulates them, and a divergence here is reported against REQ-204, not against REQ-209 | ASSERT |

### 4.J Latency — REQ-210, §7's REQ-210 bullet, requirements.md §0.5

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-J1** | REQ-210, §7's REQ-210 bullet, §10's REQ-210 hook | Several lengths from M04-B4's set, **each issued into an idle transmitter after the previous gap has elapsed** — REQ-210's own measurement condition | (cycle of the word whose lane 0 carries `/S/`) − (cycle on which `tx_tvalid` and `tx_tready` both held for the frame's first word) = **1 cycle = 8 octet times**, at every length. §7 names both measurement events exactly, and both sit at octet position 0 of their words | A design whose preamble insertion costs a variable number of cycles — one that waits for a second source word before starting, for instance, which is conformant at every other row in this plan and adds one cycle at exactly one length class | ASSERT |
| **M04-J2** | REQ-210's domain clause, §7 | A back-to-back run | **REQ-210 is NOT measured on a back-to-back run.** §7: *"Back-to-back transmission legitimately delays a start character until the gap is served, and REQ-210 puts that outside its domain."* A bench measuring the same two events there measures REQ-204's gap and reports it as a latency violation | — (the row exists to stop the measurement, and it is the cheapest of the three NO-ASSERT rows in this family to get wrong, because a sustained run is the most convenient place to take a statistic) | NO-ASSERT |
| **M04-J3** | REQ-210 **as repaired 2026-08-11**, requirements.md §0.5's per-octet definition, §7's two pinned values — **`FINDING AP-M04-1`, SUSTAINED, CURED and CLOSED, §8 item 1** | (M04-J1's runs, read per octet) | **The per-octet latency is REPORTED and asserted nowhere.** Derived from §0.5 and §6.1 rather than measured: frame octet `j` is accepted in source word `⌊j/8⌋` at cycle `C + ⌊j/8⌋`, byte position `j mod 8`, so its input octet time is `8C + j`; it is transmitted at cycle `C + 2 + ⌊j/8⌋`, lane `j mod 8`, so its output octet time is `8C + 16 + j`. **L = 16 octet times for every frame octet, of every frame, at every length** — a constant, and **not** the 8 that §7 pins. §7's 8 is a delay between two *events*. **The quotation this cell carried is STALE and is struck rather than deleted, 2026-08-11**: it read *"REQ-210's sentence opens ~~'Measured per octet in octet times (§0.5)'~~ and then names those two events"*, **and that opening clause no longer exists — striking it is what the ruling did.** REQ-210 now says in its own text that its constant is an **event delay** between two named events, names both, states that it is **not** §0.5's per-octet latency, requires both to be pinned in SPEC-M04 §7, and adds *"a monitor SHALL NOT assert either one per the other's measurement."* **The monitor this row forbids is therefore now forbidden by the requirement itself**, which is a stronger prohibition than a plan row can write. **Not one figure moves**: L = **16**, h = **0**, ΔC = **2**, event delay **8** octet times — SPEC-M04 §7's four pinned constants, re-derived off a materialised wire stream over **1501** frame lengths at the countersignature (`J-dv_lead-0170` §(a), in force at `816e187`, transcription `J-orchestrator-0244`) | **The bench this row forbids.** The kill here is a *test*, not a design: this is `SCR-M03-I4`'s shape at a new module — a monitor built from a specification sentence that no conformant design can satisfy — and it is reachable **by arithmetic on the specification before any RTL exists**, which is exactly what §0.5's own *"checkable at spec freeze"* clause promises. It was not caught at freeze, and this row is where the programme finds it the second time. **The finding is CLOSED** (§8 item 1) — routed to architect_docs_lead, SUSTAINED, and cured at `816e187` by pinning **both** constants rather than by renaming one; the alternative it rejected (repair §7's pinned 8 to 16, keep REQ-210's opening clause) would have invalidated `M04-J1`, whose two events are both named. **This row did move in neither direction on the resolution, as it said it would**: it reported 16 before the ruling and reports 16 after it | NO-ASSERT |
| **M04-J4** | requirements.md §0.5's L, §6.1's padding and FCS paragraphs | (M04-J1's runs) | **Pad and FCS octets have no input octet time, so §0.5's L has no value for them.** The domain of any latency measurement at M04 is the **frame** octets — the ones that entered on the source stream — and a tagger that tries to match every wire octet to an input octet has no match for up to 59 pad octets and 4 FCS octets per frame | — (recorded because the committed tagger's stated correspondence is *"output octet j is input octet j + strip_octets"*, a front-strip **prefix** relation over an output that is a subset of the input; M04's wire stream is an input stream with 8 octets prepended and up to 63 appended, so the relation is not of that shape. §7 item T-4 carries what follows for machinery) | NO-ASSERT |

### 4.K Configuration — REQ-802, REQ-803, REQ-810, §4.3

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-K1** | REQ-810, REQ-802, §4.3's `tx_enable` row, §10's REQ-802/810 hook | `cfg_tx_enable` = 0, stable, with the source presenting a frame's first word and holding it; then `cfg_tx_enable` → 1 at a frame boundary | While disabled: `tx_tready` = **0** on every cycle, **no start character**, every lane `/I/`. After enabling: the held word is accepted and the frame is transmitted complete and correct — preamble, padding, FCS, terminate lane | A design that accepts the word while disabled, which then must either drop it (REQ-207 forbids it) or transmit it at a start character REQ-810 forbids; a design that emits a preamble while disabled and stalls waiting for the rest | ASSERT |
| **M04-K2** | REQ-810, REQ-803, §4.3's *"a frame already in flight completes"* | `cfg_tx_enable` → 0 **mid-frame**, at least one cycle before the frame boundary | The frame in flight **completes normally** — padding, FCS, terminate character, and the gap served from it; the **next** frame does not begin and `tx_tready` stays 0 | A design that truncates the in-flight frame on disable. **That would be a silent frame loss with no strobe**, and unlike REQ-009's `clear` — which §7 authorises as *the only silent frame loss in this specification* — **REQ-810 authorises none**, so the design would be losing a frame the specification says it keeps | ASSERT |
| **M04-K3** | REQ-802, REQ-803, §4.3's `ifg` row | `cfg_ifg` = 12 at the terminate character, changed to **40** one cycle **after** it | The gap being served stays at the sampled value — `g = 2`, 16 octets at `t = 0` — and is **not lengthened**; the **next** gap uses 40 (`g = 5`, 40 octets) | A design sampling `cfg_ifg` continuously (the in-service gap stretches) and a design sampling it at the frame's *start* rather than at its terminate character (the change lands one frame late) | ASSERT |
| **M04-K4** | REQ-802, REQ-803, §4.3, REQ-204's "never shortened" | `cfg_ifg` = 40 at the terminate character, changed to **12** one cycle after it | The gap being served stays at 40 octets and is **not shortened** | The same continuous-sampling design as K3, in the direction K3 cannot see. **Both directions are driven because a continuous sampler is visible in only one of them, and which one depends on which way the value moved** — a single-direction bench has a coin-flip's chance against it. Shortening is additionally forbidden by REQ-204 itself, so this row convicts under two clauses | ASSERT |
| **M04-K5** | REQ-803, §4.3's two rows read together | Both `cfg_ifg` and `cfg_tx_enable` changed on the **same** cycle, that cycle being **neither** field's sampling event | Each field takes effect at **its own** sampling event — `cfg_ifg` at the next terminate character, `cfg_tx_enable` at the next frame boundary — and the two events are at different cycles | A design with one shared configuration-capture register, which makes both fields take effect at whichever event comes first. §4.3 gives the two fields **different** sampling events and nothing in the specification couples them; a bench changing one field at a time cannot see the coupling at all | ASSERT |

### 4.L Reset and `clear` — REQ-009, §7's reset bullet, C-14.2

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-L1** | REQ-009, §7's reset bullet, §9's closing sentence | `clear` asserted **mid-frame**, released after two cycles | The frame on the wire **stops**: no terminate character, no `/E/`, and **`error_underflow` stays 0** throughout. `tx_tready` = 0 while `clear` = 1. Every lane carries `/I/` from the abandonment onward | A design that terminates the abandoned frame — §9's `/E/` `/T/` word is **REQ-206's** and not REQ-009's, and emitting it here reports an underflow that did not happen. A design that pulses `error_underflow`: §9 says in terms that *"the `clear`-mid-frame case of §7 is REQ-009's, not REQ-008's"*, so the silence is required and not merely permitted | ASSERT |
| **M04-L2** | REQ-009, C-14.2, §6.2's `Idle` row, §10's REQ-009 hook | `clear` released; the source presents a word on the **first** cycle after and holds `tvalid` and the word stable | `tx_tready` = **0** on that first cycle; the word is accepted on the **second**; the frame is transmitted intact | **A design implementing §6.2's `Idle` row literally.** That row says `tx_tready` = `cfg_tx_enable`, and §7's reset clause says it **wins over** that row for exactly these cycles (C-14.2). The design that reads §6.2 alone accepts the word one cycle early — and the frame it then transmits is byte-perfect, so only the acceptance cycle convicts it | ASSERT |
| **M04-L3** | REQ-009, REQ-206, the co-occurrence of the two | `clear` asserted mid-frame **and** the source stops presenting words from that cycle onward | **No `error_underflow` pulse, ever** — neither during `clear` nor after it releases; the abandoned frame produces no report of any kind | A design whose underflow detector is not gated by `clear` and which fires when the abandoned frame's next required word never arrives. **This is the one stimulus in which REQ-009's silence and REQ-206's report are both plausibly due**, and the specification resolves it in REQ-009's favour by making the frame cease to exist; a bench driving `clear` with a well-behaved source never reaches it | ASSERT |
| **M04-L4** | REQ-009, obligation 3, §0.6's conservation | Three frames: one completed, one abandoned by `clear`, one completed after release | The first and third are accounted normally; the abandoned one is **`frame_in_exempt`**, never `frame_in` — it began and neither terminated nor strobed | A conservation monitor without the exemption, which **fails a conformant M04**. This is C-2's machinery becoming load-bearing at its first transmit module, and it is the same shape `AP-M03` §2 obligation 2 carries for `clear` and `cfg_rx_enable` at the other port — one exemption there, one here, and both mandatory | ASSERT |
| **M04-L5** | REQ-009, REQ-204, §6.3 item 4 | `clear` asserted **during the gap**, not mid-frame | No frame is lost; the frame after release is transmitted correctly; **the interrupted gap's remaining obligation does not carry over** — §6.3 item 4 gives the first frame after `clear` no REQ-204 instance, there being no preceding terminate character | A design that resumes its gap counter across `clear` and delays the next frame by the residue, and a design that carries the *previous* frame's terminate lane into the post-`clear` gap arithmetic. Neither is visible when `clear` lands mid-frame, which is where a reset test naturally puts it | ASSERT |

### 4.M Inherited bits, ignored fields and containment — REQ-013, REQ-014, REQ-208, REQ-709, REQ-710

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-M1** | REQ-013, §3's REQ-013 row, §9's third co-occurrence bullet, §10's REQ-013 hook | The same frame driven twice, once with `tuser`[0] = 1 on its `tlast` word and once with 0 | The two runs are **identical** as ordered sequences of (cycle, `xgmii_txd`, `xgmii_txc`) triples, and **no strobe pulses in either** | A design that drops, truncates or marks a frame on the advisory bit — REQ-013's *"no module drops a frame solely because this bit is set"* — and a design that re-reports it as a strobe, which §9 says would violate §0.6's rule that a module never re-reports a condition it merely inherited | ASSERT |
| **M04-M2** | REQ-014, §3's REQ-014 row, §10's REQ-014 hook (*"REQ-014's differential run"*) | The same frame driven three times with `tstrb` = 0x00, 0xFF and 0xA5 | All three runs are identical as ordered (cycle, `xgmii_txd`, `xgmii_txc`) sequences | A design ANDing `tstrb` into `tkeep`. **At `tstrb` = 0xFF it is invisible**, which is the value every convenient stimulus drives, so the row's whole instrument is the 0x00 member — and 0x00 with a design that ANDs produces a frame of nothing but padding, which is well formed and passes every length and lane row in this plan | ASSERT |
| **M04-M3** | REQ-208, REQ-510, §3's REQ-208 row | (none — no stimulus exists at this module) | **GAP.** REQ-208's verification hook drives the receive path at the REQ-004 rate while M04 is busy and checks that `error_arp_reply_dropped` fires — a strobe **REQ-510 gives to M13**, which does not exist at this commit, in a composition (M20) that does not exist either. **At M04's own ports the requirement has no observable**: it asserts the *absence* of a path, and an absence is not driveable | — (carried and not deleted so that no `SO-xgmii_tx_64` claims REQ-208 by silence. **Owner**: a system-level bench at the composition that first contains both a receive path and this module. The structural half is M04-M4) | GAP |
| **M04-M4** | REQ-208, REQ-010, REQ-017 | (none — a script check) | M04's port list contains **no receive-path signal**: `docs/specs/ifc_check/xgmii_tx_64_ifc.ml` compiles and the emitted-Verilog port check finds exactly §4.2's fourteen ports. A path from the transmit chain into the receive datapath cannot exist through a port that is not there | A composition that wires M04's `tx_tready` into a receive-path module's `tready` — visible in the emitted structure and not in any waveform at this module. **This is the half of REQ-208 that is checkable today**, and stating it as STRUCTURAL is what stops M04-M3's GAP from being read as "REQ-208 is untested" when half of it is not | STRUCTURAL |
| **M04-M5** | REQ-709, C-31, ADR-0011, §9's first co-occurrence bullet | (none at this commit — M18 does not exist) | **NO-STIMULUS today, and the reading is fixed here so the future bench inherits it rather than the phrase it replaced.** When M18 exists, a bench asserts **one pulse of `error_tx_length_mismatch` and one pulse of `error_underflow` per under-delivered frame, and nothing whatever about their relative timing** — they are **ordered and unpinned**, M18's first on the cycle it accepts the short `tlast`, M04's later by a number of cycles that depends on how far M15's drain had progressed | — **the superseded wording is the kill.** Before C-31 this bullet said the two *"pulse **together**"*; a bench built from that reading asserts simultaneity and **fails a conformant pair**. The corrected reading is recorded now, at the plan that will commission that bench, because the phrase is the memorable half and the diff is not | NO-STIMULUS |
| **M04-M6** | REQ-710, §9's first co-occurrence bullet | (none — no stimulus exists) | REQ-710's **over**-delivery is **not visible at this module at all**: §9 says *"the frame on the wire is already complete and correct"* by the time the extra octets arrive upstream. No row drives it and no `SO-` may claim it | — (declared so that REQ-709 and REQ-710 are not read as a pair with one instance each here; one has a future instance and the other has none) | NO-STIMULUS |

### 4.N Structural — REQ-001, REQ-010, REQ-017, REQ-018, REQ-903, REQ-808

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-N1** | REQ-001, §3's REQ-001 row, §10's REQ-001 hook | (script) | The emitted-Verilog **edge-expression check** (`tools/check_emitted_verilog.sh`, run by `tools/dv_checks.sh`) finds one clock and no gated or derived clock in the emitted `xgmii_tx_64` | A gated clock introduced for the CRC enable — the natural place to reach for one in this module, since §6.2's enable is described as a mechanism rather than as an expression | STRUCTURAL |
| **M04-N2** | REQ-010, REQ-017, §4.1, §4.2 | (compile) | `docs/specs/ifc_check/xgmii_tx_64_ifc.ml` compiles against the design's own interface, and the emitted-Verilog port check finds §4.2's fourteen ports with `[@rtlprefix "tx_"]` and `[@rtlprefix "xgmii_tx"]` applied as §4.1 declares | A `Source`/`Dest` inversion at the transmit-path pattern — the one place in Phase 1 where a `Dest` legitimately appears beside a frame stream (§4.1's conformance note), and therefore the one place the pattern can be got backwards without a compile error elsewhere | STRUCTURAL |
| **M04-N3** | REQ-018, §2, §3's REQ-018 row | (script) | The emitted-module **whitelist** check finds that `xgmii_tx_64` instantiates **M02 and nothing else** — no sub-XGMII logic, no PTP, no vendor primitive | A design pulling in a second CRC engine or a vendor FIFO for the two-word depth §6.1 describes | STRUCTURAL |
| **M04-N4** | REQ-903, REQ-808, §10's last row | (script) | `xgmii_tx_64` is a distinct emitted module with `create`, `hierarchical` and an `.mli`; the `rtl_snapshots/` name comparison agrees. **Read by the script, not by this seat** — `rtl_snapshots/**` is outside a DV agent's read discipline for expected values | A module flattened into its parent, which breaks the comparison boundary REQ-901 would need at this port and which nothing behavioural detects | STRUCTURAL |

### 4.O Declared no-instance and plan-wide prohibitions

| Row | Attacks | Stimulus | Observable | Kills | Status |
|---|---|---|---|---|---|
| **M04-O1** | REQ-201's Phase-1 clause, §0.3's transmit paragraph | (none — never driven) | **A lane-4 start is never produced and its absence is never asserted as a design choice.** REQ-201 fixes lane 0 for Phase 1, so there is no stimulus, configuration or length that could produce one; the decoder's standing REQ-201 judgement (obligation 1) is what watches for it, on every run, without a row of its own | — (the row exists so that no bench writes a "we checked it never happens" unit whose stimulus space could not have contained it — the vacuity `AP-M03` §4.O's M03-O4 records at the other port, where a start character outside lanes 0 and 4 is likewise never driven) | NO-STIMULUS |
| **M04-O2** | REQ-011, SPEC-M01 §6.1, §3 | (none — never driven) | **`tkeep` = 0 with `tvalid` = 1 is never driven, and neither is a non-contiguous `tkeep` or a short non-final word.** SPEC-M04 §3's REQ-011 row says M04 *defines no behaviour* for the first, and SPEC-M01 §6.1 fixes the other two | — (a design's response to an illegal source word is not a defect this plan can convict, and a row that drove one would be scoring the design against a contract nobody owes) | NO-STIMULUS |
| **M04-O3** | §6.3 item 5, C-14.5, §4.3 | (none — never driven) | **A configuration change is never landed on its own sampling cycle.** §6.3 item 5 leaves the outcome deliberately unconstrained and §6.3's own text says *"a bench that changes either input on the sampling event's own cycle and asserts either outcome is flaky by construction and SHALL NOT be written."* | — (the prohibition is the specification's own, quoted rather than paraphrased; family K drives every change at least one cycle clear of its sampling event, which is what makes K3 and K4 assertable at all) | NO-STIMULUS |
| **M04-O4** | REQ-204, requirements.md §9.1, §4.2's `cfg_ifg` row | (none — never driven) | **`cfg_ifg` below 12 is never driven.** requirements.md §9.1 says values below 12 SHALL NOT be driven and §4.2 says M04 defines no behaviour for them | — (M04-F3's set starts at 12 for this reason, and a bench probing 8 would be measuring an undefined region and reporting it as a gap arithmetic result) | NO-STIMULUS |
| **M04-O5** | ADR-0015's governing clause, obligation 2, §7's **BAR T1** — **and no REQ, deliberately** | (none — a rule about expected values, not a stimulus) | **No expected value anywhere in this plan is ever taken from a differential co-simulation result or from a loopback through M03.** A divergence resolves as a defect against our RTL, a documented-divergence entry, or a spec diff with its own ADR — **never** by amending an expectation to agree | — (a plan-wide prohibition row with **no REQ home**, carried here because §6's own converse rule requires every row to be homed somewhere and this one is homed at §6's rows-with-no-REQ block rather than at a requirement. That block exists because the M03 plan did **not** have one, and four of its rows fell through the hole — `FINDING SO-1-A`) | NO-ASSERT |

---

## 5. Attacks considered and rejected

Charter §8 makes this list the auditor's mining ground: the rejections are where
a blind spot hides, so each carries the argument that rejected it rather than a
verdict.

1. **A loopback bench — M04 into M03 — asserting the received frame equals the
   transmitted one.** Rejected **as an oracle**, twice over. REQ-202's own
   verification column forbids it in terms: both sides share the design's
   `Crc32_eth`, so *"a systematically wrong but self-consistent CRC would pass
   them."* And more generally a loopback exercises a **pair** and reports the
   result as a verdict on **one**. **Kept, in its proper place**: M05
   `Eth_mac_10g` is the structural wrapper binding M03 and M04, and a loopback
   there is a composition test with a composition's claim. What is rejected is
   the loopback as M04's oracle, not the loopback.
2. **A full length sweep, `P` = 1 … 1514.** Rejected in favour of M04-B4's
   directed set with M04-E1's derived eight-lane sweep. The residue classes that
   change M04's behaviour are `F mod 8` (eight of them, from §4's identity) and
   the pad boundary (four lengths), and the maximum. **The argument is not
   runtime**: a full sweep buys nothing derivable from the specification, and the
   test of a directed set is whether the derivation names every class, which §4's
   identity does.
3. **A non-contiguous `tkeep` to separate a mask reading from a count reading.**
   Rejected: §3 forbids the stimulus (SPEC-M01 §6.1). Recorded here because
   M04-B2's Kills cell is exactly where that claim would otherwise have been
   written, and it says in its own text that it cannot make it.
4. **Asserting the two-word storage depth directly.** Rejected: §6.3 item 1
   leaves the register placement unconstrained, so the depth is not an
   observable. M04-H6 asserts the port-visible count identity instead, which is
   the same fact where the specification puts it.
5. **A mid-frame `cfg_ifg` change asserting an effect on the frame in flight.**
   Rejected: `cfg_ifg` governs the gap only, and asserting anything about the
   frame would freeze a coupling no requirement states.
6. **An underflow injected before the first source word is accepted.** Rejected
   as outside REQ-206: its condition begins *after the transmitter has emitted a
   frame's start character*, and no start character exists before the first
   acceptance. A withheld first word is a source that has not presented a frame,
   not an underflow. **M04-G5 sits exactly one cycle inside this boundary**, and
   the rejection is what makes its placement derived rather than chosen.
7. **A 1000-cycle idle run asserting `error_underflow` never pulses** (M03-I1's
   analogue at this port). Rejected as **vacuous by construction**: with no frame
   in flight the strobe's condition cannot hold under any stimulus, so the
   assertion cannot fail on a defect it does not already exclude. The
   non-vacuous form is obligation 4's **exact strobe-event set on every
   functional run**, which convicts a spurious pulse wherever it occurs.
   *(The general form is a banked lesson: a silence assertion over an interval
   where a conformant component is already silent measures only defects that
   add.)*
8. **A DIC-enabled comparison against the reference, to show our gap is
   802.3-conservative.** Rejected: it would configure the reference contrary to
   REQ-901's own configuration clause (*deficit idle count disabled*), and a
   comparison run under a configuration the requirement forbids is not evidence
   for that requirement. M04-F4 makes the point from the specification instead.
9. **Asserting the six preamble filler octets at the far end of a loopback.**
   Rejected: REQ-102 forbids **M03** from validating them, so the assertion would
   be testing a prohibition. At M04 they are normative (REQ-201) and M04-A1
   asserts them at the wire, which is the only port at which they are assertable
   at all — a genuine asymmetry between the two XGMII modules and the reason this
   plan's family A is larger than its receive-side counterpart.
10. **A "maximum frame plus one" length, expecting truncation.** Rejected, and
    it is the most inviting error in this list: **M04 has no length threshold**
    (§2's not-my-job table gives *"knowing a frame's length before it arrives"*
    to **nobody**). A 1519-octet source frame is transmitted whole and that is
    conformant. Asserting a truncation would import M03's REQ-108 into a module
    that does not have it — and M04-B5, the maximum-length row, is precisely
    where that import would have landed.
11. **Two rejections carried by `M04-G9` and `M04-G10`, recorded 2026-08-11 with
    the rows** — this list is the auditor's mining ground and a row added later
    owes its rejections just as much as one added at the first commit.
    **(a) Producing the pre-loaded handover with an idle-injection wrapper at
    M04's source.** Rejected, and it is the inviting error: SPEC-M04 §7 forbids
    it in normative text (*"A bench SHALL NOT build a REQ-016 idle-injection
    wrapper at this module's source interface"*, `FINDING AP-M04-2` as ruled),
    because the first injected cycle on a required cycle **is** an underflow —
    a wrapper aiming at routes 2 and 3 would manufacture the very condition the
    rows assert is absent. The handover must come from a source that presents
    early, never from one that withholds. **(b) Statusing the two new rows
    `GAP`.** Rejected: `GAP` says an attack cannot be mounted and carries the
    reason, and `M04-G10`'s reason is a **capability that has not been built**,
    not one that cannot be. Writing it as a `GAP` would let a sign-off read the
    coverage as structurally unavailable; writing it as `ASSERT` with T-7 named
    and an executor attached is the form this plan already uses for T-2's rows
    (`M04-G8`, `M04-L4`), and it is what keeps the debt countable.

---

## 6. Coverage map — REQ to rows

Every REQ SPEC-M04 §10 lists appears exactly once, and so does every programme
invariant §3 tabulates that a row attacks. **A REQ with no behavioural row
carries the reason. And — the converse, which `AP-M03` did not have and which
cost it `FINDING SO-1-A` — every declared row appears somewhere in this section:
§6.1 is where the rows that no REQ line reaches are homed.**

| REQ | Rows |
|---|---|
| REQ-001 | M04-N1 (structural) |
| REQ-002 | **No behavioural row, and none is owed.** REQ-002's transmit half — *"the XGMII output is 64 data bits and 8 control bits per cycle, always present"* — is not a property of any one stimulus; it is what obligation 1's per-cycle `observe` presumes and what every row's cycle arithmetic rests on. A row asserting it would assert that the bench read a value it just read |
| REQ-003 | **No instance at M04's ports** (§3's REQ-003 row says so in terms). REQ-208 is the connection to the receive path: M04-M3 (GAP), M04-M4 (structural) |
| REQ-005 | **Does not bind M04** — it is not a receive-path module (§3, requirements.md §0.4). Its transmit analogue is REQ-210's constant: M04-J1, M04-J3 |
| REQ-008 | M04-G1, M04-G3, M04-G8 (the one strobe); M04-L1 (the one authorised silence, which §9 assigns to REQ-009 and not to REQ-008) |
| REQ-009 | M04-L1 … M04-L5; M04-A4's first member; M04-A5 |
| REQ-010 | M04-N2 (structural) |
| REQ-011 | M04-B2, M04-B4, **M04-B5**; M04-O2 (the prohibited stimulus) |
| REQ-012 | M04-A2, M04-B1, **M04-B5** |
| REQ-013 | M04-M1 |
| REQ-014 | M04-M2 |
| REQ-015 | M04-B3, M04-B4 |
| REQ-016 | **No instance at this interface, and this is the largest structural difference between this plan and `AP-M03`.** §3's REQ-016 row and §7's handshake bullet: REQ-016's idle tolerance *"does not extend to this interface"*, and a missing word on a required cycle is an **underflow** (REQ-206), not a gap. `AP-M03`'s family I — idle injection, the deciding input word, the whole `SCR-M03-I4` apparatus — **has no counterpart here**; family **G** is what stands in its place, and it asserts the opposite thing. requirements.md §11 records the absence of elastic buffering as a **decision**, which is why this is a scope statement and not a gap |
| REQ-017 | M04-N2 (structural) |
| REQ-018 | M04-N3 (structural); and **standing obligation 1 is REQ-018's third clause made executable** — the link partner decodes transmit-side XGMII |
| REQ-020 | M04-B3, M04-H1 (order preserved, one frame at a time) |
| REQ-021 | M04-A2, M04-B1 |
| REQ-201 | M04-A1, M04-A2, M04-A3, M04-A4; **M04-O1** (the lane-4 start that is never driven) |
| REQ-202 | M04-D1 … M04-D6; **M04-C3** (the pad's coverage, which is REQ-202's clause read at REQ-203's stimulus) |
| REQ-203 | M04-C1 … M04-C6 |
| REQ-204 | M04-F1 … M04-F6; M04-I4; M04-K3, M04-K4 (the sampling rules); M04-L5 (no instance for the first frame after `clear`) |
| REQ-205 | M04-E1 … M04-E5 |
| REQ-206 | M04-G1 … M04-G10; **M04-E5** (REQ-205 has no instance on an underflowed frame); M04-F6 (the gap after one); M04-L3 (the co-occurrence with REQ-009). **`M04-G9` and `M04-G10` were added 2026-08-11** — the two shapes at which REQ-206's window is **empty** and the strobe must stay silent — and **§0.2 item 4 bars an `SO-` from reporting this REQ's coverage while `M04-G10` is neither measured nor declared a gap** |
| REQ-207 | M04-H1, M04-H2, M04-H5, M04-H6; M04-G1 and M04-G5 (the accepted words that must still be transmitted on an abort) |
| REQ-208 | **M04-M3 — GAP**, its verification hook needing a strobe (REQ-510) at a module that does not exist; **M04-M4** carries the half that is checkable today |
| REQ-209 | M04-I1 … M04-I4; M04-H3 and M04-H4, the two `tx_tready` values the cadence turns on |
| REQ-210 | M04-J1 … M04-J4 |
| REQ-802 | M04-K1, M04-K3, M04-K4; M04-F3; **M04-O4** (the prohibited `cfg_ifg` range) |
| REQ-803 | M04-K2, M04-K3, M04-K4, M04-K5; **M04-O3** (the same-cycle change, C-14.5, never driven). **§10 does not list REQ-803 as a row of its own** — it appears in §4.3 and in §10's `REQ-802, REQ-810` entry — and it is given a line here rather than folded in, so that a reader looking for it finds it where the rows are |
| REQ-810 | M04-K1, M04-K2 |
| REQ-903, REQ-808 | M04-N4 (structural) |
| REQ-709, REQ-710 | **M04-M5**, **M04-M6** — both NO-STIMULUS at this commit. **These are M18's requirements, not M04's**, and they reach this plan through §9's co-occurrence bullet: REQ-709 has a future instance here (ordered and unpinned against `error_underflow`, C-31) and REQ-710 has **none at all**, the frame on the wire being already complete when the over-delivery is detected upstream. Given a line so the pair is not read as one instance each |
| REQ-304, REQ-305 | M04-D1, M04-D2, M04-D6. **These are SPEC-M02's requirements, not M04's**, and they appear here because standing obligation 2 rests on them: the oracle's independence is what makes REQ-202's rows evidence rather than tautology |
| **REQ-901** | **No behavioural row, and none is owed — but the reason differs from M03's and the difference is the point.** At M03, REQ-901 homes two declared divergence classes at the module (runt marking, oversize truncate-and-mark) and they cost that plan coverage. **At M04, REQ-901 declares no class at all**, because no comparison exists at this boundary to declare one against. The consequence for a sign-off packet is **BAR T1** (§7), and the consequence for the architect is §8 item 2. A reader who finds this row empty should read it as *"the lane is shut"*, never as *"the lane is clean"* |

### 6.1 Rows homed by no REQ line — the converse rule, stated because a plan without it loses rows

`AP-M03` §6 states *"a REQ with no behavioural row carries the reason"* and says
nothing about a **row** with no REQ line. Four of its rows fell through that hole
and two more were reachable by neither name nor range — six in all, two of them
landed green units whose omission understated three matrix cells
(**`FINDING SO-1-A`**, `WO-0079` §6.1, measured 2026-08-11 and repaired at
`AP-M03` §6.1 in this same commit). **This plan carries the converse from its
first line**, and the check is mechanical: every id in §4's row tables appears in
§6's table or in the list below, and nowhere else is needed.

| Row | Why no REQ line, and where it is homed instead |
|---|---|
| `M04-O5` | A **plan-wide prohibition on expected values** — no expectation is ever taken from a co-simulation result or from a loopback. It constrains the *plan*, not the design, so it attacks no requirement; its authorities are ADR-0015's governing clause, obligation 2 and §7's BAR T1. Homed **here, deliberately and permanently** |

**Every other declared row is named in §6's table.** The claim is a set claim and
is therefore **measured** rather than asserted (§0.1(i)), by a command that is
**quotation-stable** — it bounds its slice with a line-anchored header match, so
its own appearance inside this document's code fence cannot become the boundary
it looks for (`FINDING AP-6-1`, minted at `AP-M03` §6.1 in this same commit,
where the substring-bounded original reported a false unhomed row the moment it
was written down):

```
$ python3 - <<'PY'
import re
txt=open('test/attack_plans/AP-xgmii_tx_64.md').read()
declared=set(re.findall(r'^\| \*\*(M04-[A-Z]+\d+)\*\* \|', txt, re.M))
secs={n: p for p, n in
      ((m.start(), m.group(1)) for m in re.finditer(r'(?m)^## (\d)\. ', txt))}
s=txt[secs['6']:secs['7']]
named=set(re.findall(r'M04-[A-Z]+\d+', s))
for m in re.finditer(r'M04-([A-Z]+)(\d+)\s*…\s*M04-\1(\d+)', s):
    named |= {f"M04-{m.group(1)}{k}" for k in range(int(m.group(2)), int(m.group(3))+1)}
print(len(declared), len(named & declared), sorted(declared-named))
PY
82 82 []
```

**Re-measured 2026-08-11, after `M04-G9` and `M04-G10` landed** — the figure was
`80 80 []` at the plan's first commit and is quoted here at its new value with the
same command, because a census printed once and carried forward is the exact thing
§0.1(i) forbids. The two new ids are reached through §6's REQ-206 range
`M04-G1 … M04-G10`, which is why the range-expansion loop below is load-bearing for
them and not only for the families it was written for.

**The table above writes its row id in backticks and not in the row tables' bold
notation, deliberately** — `FINDING AP-6-2`, minted at `AP-M03` §6.1 in this same
commit and paid here at the same table: an annotation written in the notation the
census pattern selects **joins the census**, and this table did (81 raw against 80
declared) until the notation was changed. A document measured by a pattern must
not write its annotations in that pattern.

**The range-expansion loop is not decoration**: this section cites five families
by ellipsis (`M04-C1 … M04-C6` and its siblings), and without the loop the same
command reports **21** false unhomed rows. A homing check that does not expand
the ranges its own map uses is measuring the notation, not the coverage.
**`DVC-1a`** — the row-status census commissioned at `AP-M03` §0.1 and still
unbuilt — is the tool that would make this a repository-wide one-liner over both
plans; until it exists the command above is quoted with its output, which is what
§0.1(i) asks for in the meantime.

---

## 7. Machinery this plan requires, and the co-simulation posture

**Every capability claim below is a measurement over the committed tree at the
commit that lands this plan, not an inference from what a module is called** —
§0.1(iii), the polarity rule, applied at the first place this plan could have got
it wrong. Where something is absent, the absence is stated with the file that was
read to establish it.

| # | Item | State at this commit | Rows |
|---|---|---|---|
| **T-1** | **The wire decoder** — the link partner's receive side, REQ-018's third clause | **EXISTS**: `test/xgmii/tx_decoder.ml` / `.mli`, with its own unit suite `test/xgmii/test_tx_decoder.ml`. Its interface documents what it **judges** (REQ-201 … REQ-206, one violation per breach with its REQ named) and what it only **reports** (`start_cycles`, `start_spacings`, `gaps` — because a spacing is a property of a *run* and the bench that chose the lengths is what may assert it). It is derived from SPEC-M04 at the freeze SHA and says so in its own header | every row, through obligation 1 |
| **T-2** | **A transmit-side conservation monitor** | **DOES NOT EXIST**, and the reason is structural rather than an omission: `test/monitors/conservation_monitor.ml` takes a frame **stream** as its subject, and M04's output is an XGMII pair. **No row is blocked** — obligation 3 states the counting rule and each bench carries it — but the rule is easy to get wrong in exactly one way (keying on the `tlast` acceptance, which exempts every underflowed frame; M04-G8). **Executor: dv_lead, in the round that opens `test/monitors/`** | M04-G8, M04-L4, obligation 3 |
| **T-3** | **A source-side stall scheduler** — the machinery family G needs | **THE PRIMITIVE EXISTS; THE ORACLE DOES NOT, and the split is `AP-M03` §7's X-1 split at this port.** *(i) Placement*: `test/axi64_probe/axi64_driver.ml` drives one `Axi64.Source` record onto the six `Bits.t ref`s per call, so withholding a word on a chosen cycle is a bench presenting `tvalid` = 0 there — **no new module is needed and none is commissioned**, which is the answer §0.1(iii) obliges me to reach by reading the driver rather than by inferring from §9 that the stimulus is constructible because it is specifiable. *(ii) Computed outcome*: nothing derives, from a stall schedule, the expected strobe cycle, the `/E/` word's cycle and the truncated octet count. **Family G hand-derives all three from §9 and §6.1**, which is the half `AP-M03` gates and this plan simply does not have | family G |
| **T-4** | **A per-octet latency tagger for a *prepending* module** | **NOT APPLICABLE AS BUILT, and the claim is about the documented interface only.** `test/monitors/octet_time.mli`'s `Latency` states its correspondence as *"output octet `j` is input octet `j + strip_octets`"* — a front-strip **prefix** relation, over an output that is a subset of the input taken from the front. M04's wire stream is the input stream with **8 octets prepended** and up to **63 appended** (pad and FCS), so the relation is not of that shape at any value of `strip_octets`. **No row is blocked**: M04-J3 reports the per-octet figure by direct arithmetic from the source trace and the decoded wire, and no tagger is instantiated | M04-J3, M04-J4 |
| **T-5** | **An independent CRC-32 oracle** | **EXISTS**: `test/golden/crc32_ref.ml` / `.mli` — REQ-305's bit-serial reference, independent of `libs/**`, with `of_octets`, `fcs_octets` and the residue constants. **This is the one external-anchor obligation at M04 that is discharged today**, and obligation 2 rests on it | family D, M04-C3, M04-G6 |
| **T-6** | **Frame construction helpers** | **EXIST**: `test/xgmii/frame.mli` carries `fcs`, `with_fcs`, **`pad_to_60`** (REQ-203's own arithmetic, already committed), `residue_ok` and `stress_frame` with a position-dependent filler — the last being what M04-B1 and M04-C4 turn on | families B, C, D |
| **T-7** | **A direct-drive continuous source with a controllable handover cycle** — the machinery `M04-G10` needs, added 2026-08-11 | **DOES NOT EXIST, and T-3 is not it.** T-3's primitive drives one `Axi64.Source` record per call, which is enough to *withhold* a word on a chosen cycle; what is missing is the other polarity — presenting the **next** frame's first word while the previous frame is still transmitting, so that its acceptance lands on a **chosen** cycle (`C + 8`, §7's C-16 acceptance) and the frame it opens starts from a word the module already holds. **Measured at this commit, not inferred** (§0.1(iii)): T-3's own capability read establishes the withholding half, and the absence of the other half is read off the committed producer — `test/xgmii_tx_64/bench.ml`'s standing conservation check **fails unless exactly one frame is decoded per run** (`assert_instruments_clean`, the `| fs ->` branch), so no committed unit can drive a second frame at all, let alone hand one over on a chosen cycle. **Neither family D nor REQ-209's sustained run supplies it**: family D drives no handover, and REQ-209's frames are minimum-length, `W = 8`. **Executor: dv_lead**, in the round that first opens a back-to-back bench at M04 — and it is what §0.2 item 4's bar turns on, so it is a **sign-off dependency and not a nicety** | M04-G10 (and, on the same stimulus, the never-measured routes 2 and 3 of `BUG-0004`) |

### 7.1 BAR T1 — the differential anchor at this boundary is SHUT, and a bench cannot open it

> **No `SO-xgmii_tx_64.md` PASS may rest on a differential co-simulation result at
> this boundary.** Three independent conditions block it, each **measured at this
> tree** and each requiring an act outside a bench round.
>
> **(a) The reference module is not vendored.** `test/third_party/verilog-ethernet/`
> contains exactly four files at this commit — `axis_xgmii_rx_64.v`, `lfsr.v`,
> `COPYING`, `PROVENANCE.md`. **`axis_xgmii_tx_64.v` is not among them.** Adding it
> is a vendoring act governed by ADR-0015 D2 and by `PROVENANCE.md`'s own rules —
> its own commit, carrying the 40-hex pin, the byte sizes, the sha256s and a
> **re-derived** instance closure at that pin — and `PROVENANCE.md` says in terms
> that a pin bump *"lands as its own commit … never folded into a harness change"*.
> A bench round may not do it incidentally.
>
> **(b) There is no transmit harness, and the canonical form does not carry over.**
> `tools/cosim/run_cosim.sh` is the only caller of `iverilog`/`vvp` and it builds
> `test/cosim/tb_xgmii_rx_64.v` against the two vendored files; `test/cosim/ours_run.ml`
> elaborates M03. **`test/cosim/canonical.mli`'s pinned grammar is a per-word
> AXI-stream record** — `tkeep`, `tlast`, `tuser0`, `cycle`, `octets` — which is
> REQ-901's comparison content at a *receive* boundary. **At a transmit boundary the
> output has none of those fields**: it is a lane pair. A TX canonical form is a new
> grammar over **decoded** lanes, and a decoder on each side is part of the
> comparison rather than part of the harness — which is a design question, not a
> port.
>
> **(c) REQ-901 declares no divergence class at this boundary.** Its lettered list
> (a) … (h) is entirely M03's and IPv4/ARP/UDP's; **not one entry names the transmit
> port**. REQ-901's own rule is that *"a divergence class discovered later SHALL be
> added here by spec diff before any sign-off packet may cite it"*, so the lane
> could not even **report** an expected divergence until architect_docs_lead has
> added the classes. That is §8 item 2.
>
> **WHAT THE ANCHOR WOULD AND WOULD NOT SEE IF ALL THREE WERE PAID.** Stated now,
> because the answer bounds what any future round may promise and because the
> temptation at the moment a lane opens is to describe it as anchoring the module.
>
> - **Would see** — the octet sequence on the wire; **the padding**, since REQ-901's
>   own configuration clause requires the reference *padding enabled, minimum frame
>   length 64*; the four FCS octets and their wire order; the terminate lane; and the
>   gap **in octets**, with deficit idle count disabled as that same clause requires.
>   **This is the one boundary in Phase 1 at which the anchor could see length logic
>   at all** — REQ-901's classes (e) and (f) exclude every length-derived path at M03
>   *because the receive reference has none*, and architecture.md §5 records
>   `MIN_FRAME_LENGTH` as a parameter of the **transmit** counterpart, where it
>   *"drives transmit padding"* (REQ-901's own class (e) text says so). **Carried at
>   the strength of that record and not of a measurement**: this plan has not read
>   `axis_xgmii_tx_64.v`, because it is not in the tree, and §0.1(i) obliges the
>   distinction to be marked rather than glossed.
> - **Would not see** — **`error_underflow`**, because **REQ-901 does not compare
>   strobes at all**: its comparison content is frames, `tkeep`, `tuser`[0] and the
>   accept-or-discard decision. That is the ground `CD-xgmii_rx_64_cosim` §2-bis
>   reached at the other port after two wrong grounds, and it is
>   **boundary-independent** — it follows from REQ-901's text, not from anything
>   about the receive reference. **Any cycle**, because REQ-901 says *"cycle
>   alignment, internal pipelining and latency constants are deliberately not
>   compared"* — which takes **REQ-209's cadence and REQ-210's constant entirely out
>   of the comparison**. And **`tx_tready` on any cycle**, a handshake signal being
>   not an output frame — so REQ-207's no-drop rule is anchorable only through its
>   *consequence*, the octet sequence, and never through the handshake.
> - **Therefore even a fully opened TX lane leaves REQ-206, REQ-207's handshake
>   half, REQ-209 and REQ-210 bench-only.** A round that opens the lane may not
>   report it as anchoring those four, and this sentence exists so that the claim is
>   pre-refuted rather than argued about later.
>
> **AND THE BAR IS A GATE CONDITION, NOT A CAVEAT.** Charter §3 and PROTOCOL §10
> make differential co-simulation a **precondition of Phase 1 MAC/UDP sign-off** —
> *"no Phase 1 `SO-` PASS without it"*. M04 is a MAC module. **So (a), (b) and (c)
> are work that must be commissioned as work orders before the sign-off round, not
> discovered during it** (§8 item 6). The M03 era paid for the late discovery of a
> co-simulation dependency once already, at `WO-0044`; this plan's first commit is
> the earliest moment at which the same bill can be presented instead of incurred.

### 7.2 What this plan does NOT bar, said so the bars are not read wider than they are

- **The FCS rows are not gated.** Obligation 2's oracle is independent and
  committed (T-5), so family D's claims stand on their own external anchor today.
  BAR T1 is about the *differential* anchor and reaches no row of family D.
- **No row's status is gated on BAR T1.** A bar is a constraint on what a
  **packet** may claim, never on what a bench may assert — the distinction
  `AP-M03` §7's bar 1 lift cells make in their own words: *a class is anchored; a
  requirement is not*, and *no row's status, no coverage-map line and no discharge
  count moves on a lift*.
- **Nothing here bars a loopback at M05.** §5 item 1 keeps it, in its place.

---

## 8. Open questions and rulings requested

1. **`FINDING AP-M04-1` — SUSTAINED, CURED and CLOSED at `816e187`** (recorded
   2026-08-11; the derivation below is kept verbatim because it is the evidence
   the ruling was checked against, and a closed finding whose argument is deleted
   cannot be re-audited). **The repair is the opening clause and not the pinned
   figure**: REQ-210 now states that its constant is an **event delay** between
   two named events, names both, says it is not §0.5's per-octet latency,
   requires **both** constants pinned in SPEC-M04 §7 (event delay 1 cycle = 8
   octet times; L = **16**, h = **0**, ΔC = **2**), and adds *"a monitor SHALL
   NOT assert either one per the other's measurement."* Countersigned by
   re-derivation over **1501** frame lengths, `J-dv_lead-0170` §(a), in force at
   `816e187` (transcription `J-orchestrator-0244`). **The rejected alternative,
   recorded because it was live**: repair §7's pinned 8 to 16 and keep REQ-210's
   opening clause — refused because `M04-J1` is an `ASSERT` against the event
   delay, whose two events are both named, and pinning both is strictly more
   informative than renaming one. **No row moved in either direction**, exactly
   as the filing predicted: `M04-J1` asserts the event delay unchanged and
   `M04-J3` reports 16 either way. *The original filing follows.*

   **(MINOR against the text, MAJOR against any bench built
   from it; mine, against requirements.md REQ-210 read with SPEC-M04 §7).**
   **REQ-210 names a per-octet measurement and then pins an event delay, and the
   two quantities differ by 8 octet times at every octet of every frame.**
   Derivation, from §0.5's own definitions and §6.1's own table, entirely on the
   specification and before any RTL exists — which is what §0.5's *"checkable by
   arithmetic at spec freeze"* clause promises:
   - §0.5: *the latency of octet n is (octet time at the output) − (octet time at
     the input)*. Frame octet `j` is accepted in source word `⌊j/8⌋` at cycle
     `C + ⌊j/8⌋`, byte position `j mod 8`, so its input octet time is
     `8(C + ⌊j/8⌋) + (j mod 8) = 8C + j`.
   - §6.1: *a source word accepted on cycle `C + m` is transmitted on cycle
     `C + m + 2`*, at lane = byte position (REQ-012, no rotation). So its output
     octet time is `8(C + 2 + ⌊j/8⌋) + (j mod 8) = 8C + 16 + j`.
   - **`L = 16` octet times, for every frame octet, of every frame, at every
     length.** It *is* a constant — M04 passes §0.5's straddle test (`h ≡ 0`) and,
     having no late-decided output framing, its late-decision test as well — but
     it is **not the 8 that §7 pins**.
   - §7's 8 is the delay between **two events**: the acceptance handshake and the
     word whose lane 0 carries `/S/`. Both sit at octet position 0 of their words,
     which is why §7's own arithmetic (*"exactly 8 × 1 octet times"*) is
     self-consistent. **REQ-210's sentence is what conflates them**: it opens
     *"Measured per octet in octet times (§0.5)"* and then names those two events.
   - **Consequence, and it is the reason this is a finding and not a quibble**: a
     latency monitor built from REQ-210's opening clause and §7's pinned value
     asserts **8 per octet** and **fails a conformant M04 at every octet of every
     frame**. That is `SCR-M03-I4`'s shape at a new module — a monitor built from
     a specification sentence no conformant design can satisfy — reached this time
     from the specification's side, by a plan, before a bench existed to go red.
   - **The second half, which may be answered separately.** §0.5's **front offset
     `h`** is *"the number of octet times between the octet time of the input
     measurement event and the octet time, at that same input, of the first octet
     the module emits for that frame"*, and its worked gloss is *"the octets the
     module removes from the front"*. **M04 removes none and prepends eight.**
     Read against the preamble word — a word M04 emits for the frame that carries
     **none of its octets** — `ΔC = 1` and `L = 8`; read against the first word
     carrying frame octets, `ΔC = 2` and `L = 16`. **The per-octet measurement is
     unambiguous at 16**; the ambiguity is in which word `ΔC` counts to at a
     module that inserts.
   - **Route**: architect_docs_lead, as a spec-change request via the
     orchestrator. **Not decided here.** M04-J1 asserts §7's event delay (which is
     exact and unambiguous, both events being named) and M04-J3 reports 16;
     **neither moves in either direction on the ruling**, so nothing is blocked.
   - *Closing note, 2026-08-11.* The finding's **second half** — §0.5's front
     offset `h` at a module that **inserts** — was answered in the same diff:
     §0.5 gained an inserting-module clause (an inserted octet entered on no
     input and has no input octet time, so `h` = 0 and ΔC counts to the first
     output word carrying an octet **of the frame**, never to a word the module
     inserted ahead of it), which gives ΔC = 2 and L = 16 by the identity and
     agrees with the per-octet route. Both halves are closed.
2. **REQ-901 declares no divergence class at the M04 boundary**, and its own text
   forbids citing a class not listed there. Needed before any TX co-simulation
   result may be cited by a sign-off packet. **Route**: architect_docs_lead.
   §7.1(c).
3. **`C-5` — DISCHARGED at `ee47eee`, 2026-08-11** (this item read *"C-5 is still
   DEFERRED"* until then). §0.6 gained a **fourth reference-word clause**: for a
   condition reported on the **non-arrival** of an input word — which in §12's
   strobe appendix is REQ-206's `error_underflow` and nothing else — the reference
   word is the cycle on which the word was required and not presented, the ceiling
   adds §0.5's word delay **ΔC = 2** and never REQ-210's event delay, and the
   window *"carries no independent information"* here because SPEC-M04 §9's pin
   sits at its near edge. **This plan was the document the closure was written
   for** — §0.6's own clause cites this item by name — and obligation 5's
   prohibition survives on the clause's own statement rather than on an
   undischarged deferral. Countersigned `J-dv_lead-0173` §(c) (transcription
   `J-orchestrator-0247`); SPEC-M04 §11.3 closes on the same row.
   **One residue is OPEN and is not mine to decide: `FINDING ABS-1` (MINOR),
   against the clause's stated *ground* and not against its rule.** The clause
   grounds itself on the three earlier clauses "naming no word", and the first
   clause **does** name one here — *"the last octet that frame received while it
   was open"*, and an underflowed frame has received octets (`M04-G5`). So the
   clause is an **override**, moving the reference one cycle later to the
   condition's own decidability cycle, rather than a hole-filler. Nothing turns on
   it (the pin lies inside both candidate windows), the cure is one sentence, and
   **the identical misreading was in this plan's own row `M04-G7`, repaired here
   in the same act as the finding it convicts me under**. **Route**:
   architect_docs_lead, spec-diff request via the orchestrator.
4. **Machinery T-2** — the transmit-side conservation monitor. **Mine**, executor
   named, in the round that opens `test/monitors/`. Named with an executor
   precisely so it cannot evaporate into a good intention, which is the form
   `AP-M03` §0.1's `DVC-1` commission takes and the reason it is still countable
   while unbuilt.
5. **`DVC-1a`** — the row-status census commissioned at `AP-M03` §0.1 — **is now
   wanted by two plans.** §6.1's homing check and §6's status census are both
   described-method passes in this document for want of it. Still dv_lead's, still
   unbuilt, and the second plan is a fact about its priority rather than a new
   commission.
6. **The three BAR T1 conditions need work orders** — vendoring the transmit
   reference at a pin (its own commit, ADR-0015 D2), a transmit harness and
   canonical form, and REQ-901's divergence classes. **Route**: orchestrator, as
   scheduling. **Sequencing matters and is stated rather than left to be
   discovered**: (c) is architect work and gates what (b) may compare; (a) is a
   vendoring commit that gates (b) entirely; and none of the three is a bench
   round's to do inside a bench round.
7. **Machinery T-7 and the two never-measured routes of `BUG-0004`** (added
   2026-08-11). `M04-G10` needs a direct-drive continuous source with a
   controllable handover cycle, and no such producer exists — the committed bench
   cannot decode two frames in one run at all. **Mine**, executor named, in the
   round that first opens a back-to-back bench at M04. **What makes this different
   from T-2's kind of debt**: §0.2 item 4 **bars** an `SO-xgmii_tx_64.md` from
   reporting REQ-206 coverage while `M04-G10` is neither measured nor declared a
   gap, so this item is a **sign-off gate condition** rather than a wanted
   convenience — the same class as §7.1's BAR T1 conditions, and it is stated here
   before the sign-off round rather than discovered inside it. The routes were
   fixed **by derivation** in the same edit that fixed route 1; a derivation is not
   a class DV records a clearance on.

---

## 9. Change log

| Date | Change | Author |
|---|---|---|
| 2026-08-11 | **Created.** **80 rows** across 15 families (A 5, B 5, C 6, D 6, E 5, F 6, G 8, H 6, I 4, J 4, K 5, L 5, M 6, N 4, O 5) — **56 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP, 0 RULING**, counted from this file by a status-cell pass over every row table at this commit and **not** carried forward from the draft. The skeleton is `AP-M03`'s and no section is dropped. **Three things this plan does that its predecessor learned to do only later, and each is a debt paid forward rather than an innovation**: (1) **§6.1's converse rule** — every declared row is homed, in §6's table or in §6.1 — which `AP-M03` lacked and which cost it `FINDING SO-1-A`; **the check was run on this document's own draft and returned five unhomed rows** (`M04-B5`, `M04-M5`, `M04-M6`, `M04-O3`, `M04-O4`), repaired before this commit, so the instrument's first act was to convict its author. (2) **§0.2's prohibition register opens with the plan** rather than accreting over nine campaigns, carrying the three bars knowable at commit time. (3) **§7.1's BAR T1 states the co-simulation posture as a gate condition before the first bench**, with the three blocking conditions measured at the tree — the reference module is not vendored, there is no transmit harness and no canonical form for a lane pair, and REQ-901 declares no divergence class at this boundary. **One finding is minted against the specification and routed, not decided**: `FINDING AP-M04-1` (§8 item 1) — REQ-210 names a per-octet measurement and pins an event delay, and a monitor built from the two together fails a conformant M04 at every octet, `L` being **16** octet times per octet against §7's **8** between events. **No row moves on its resolution.** | dv_lead, `J-dv_lead-0169` |
| 2026-08-11 | **The first M04 bench round is ABSORBED INTO THE PLAN: THIRTEEN ROWS DISCHARGED at `af06c62` — eleven ASSERT by a green assertion and two NO-ASSERT by a prohibition that held.** `M04-A1`, `M04-A2` (U2, `P` = 60); `M04-A5` (**NO-ASSERT**, U2 title + round-wide — no unit anywhere asserts an absolute cycle measured from cycle 0, from reset, or from the release of `clear`; every cycle constant is computed from `C`, the first accepted cycle, stated at `test/xgmii_tx_64/test_m04_a.ml:8–11`); `M04-B1` (U3, `P` = 60, position-dependent content); `M04-B2` (U4, `P` = 20, poisoned `tlast` word); `M04-B4`, `M04-B5` (U5, the **full** directed set `P ∈ {1, 20, 59, 60, 61, 64, 67, 1514}`); `M04-C1` (U6, `P` = 20); `M04-C6` (**NO-ASSERT**, U6 title + round-wide — the decoder's REQ-203 verdict is not reported as REQ-203 coverage, in the bench or in the verdict; `M04-C1` and `M04-C3` are what discharge REQ-203); `M04-C2` (U7, `P ∈ {1, 59, 60, 61}`, both directions of the below-60 predicate); `M04-C3` (U8, `P` = 20, both halves of the oracle comparison); `M04-C4` (U9, `P` = 20, poison `0xA5`); `M04-C5` (U10, `P ∈ {1, 20, 59}`). Carrier `WO-0080` (`RV-0080-VERDICT` **BOUNCED** at `960c831` on `BM1`/D4a; rev B landed `cbbeb76`; the red that followed was a **design** defect, §15 class **D1** → `BUG-0004`, **CLOSED** at `af06c62`; `RV-0080B-VERDICT` **ACCEPT**, 16 of 16 bars, `J-dv_lead-0176`). Evidence: CI `build` run **31482795659**, job `build` **93751338432**, steps *Build*, *Run tests (expect tests, waveform snapshots)* and *Verify nothing was left unpromoted or non-deterministic* each `success`, read by name and status; `git diff cbbeb76 af06c62 -- test/` **empty**, so the green run reads the bench exactly as it landed. **NO ROW ADDED, NO ROW CONVERTED, NO STATUS MOVED, NO COVERAGE-MAP LINE CHANGED, NO CELL OF ANY ROW TOUCHED: 80 rows, 56 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP, 0 RULING** — re-measured at this tree by a **status-cell pass** over every row table, before and after this edit, and **not** carried forward. **The discharge count is a HAND COUNT and carries its provenance**: `tools/dv_checks.sh` at this commit contains **zero** occurrences of `M04`, `xgmii_tx_64` or `AP-xgmii_tx`; its row-discharge census is hard-keyed to `AP-xgmii_rx_64.md`/`M03-`/`test/xgmii_rx_64/*.ml` and reports 78 rows (M03's), and only its repository-wide bench-inventory line moved, to **149**. **No committed instrument counts an M04 row** — §19.3 item 1's M04 census is owed and is now load-bearing for any coverage fraction. **67 of 80 rows remain outstanding**; `BAR T1` stays **SHUT**; **no `SO-xgmii_tx_64.md` is opened or offered**, and `M04-G4` is **not** discharged and is not described as such. **Two obligations are carried into the plan's debt by `BUG-0004` §10.3/§10.4** and are the plan's to absorb when it is next repaired: two new family-G rows (the `W = 1` collapse, and the pre-loaded-handover shape covering that bug's derived-but-never-measured routes 2 and 3, with `M04-G5` named as the opposite-verdict neighbour on both). **The editorial repair debt stands at NINE and NONE of it is paid here** — this round opened this file for this change-log row and nothing else; the carrier is re-pinned from *"the round that next opens `test/attack_plans/**`"* to *"the round commissioned to repair this plan"*, because a carrier phrased over a **path** is discharged by accident the first time a round opens that path for an unrelated reason. | dv_lead, `J-dv_lead-0176` |
| 2026-08-11 | **THE REPAIR ROUND THIS PLAN'S DEBT WAS RE-PINNED TO: seven of eight carried items paid here, the eighth already paid, two rows added, no status cell moved on any pre-existing row.** The row above re-pinned the carrier from *"the round that next opens `test/attack_plans/**`"* to *"the round commissioned to repair this plan"*; **this is that round**, and the debt is paid by walking `J-dv_lead-0171` … `J-dv_lead-0176` rather than by trusting the running total. **The walk corrects the total, which is the first thing this row records.** The running count reached NINE by adding *"the §9 change-log row"* twice — once at `J-dv_lead-0171`, where it is the families A/B/C landed-status row, and again inside `J-dv_lead-0174`'s arithmetic, where the clause that follows it (*"whose landed-status figure must record **zero** rows discharged at `960c831`, not thirteen"*) is a correction to that same row's content and not a second obligation. **The distinct census is therefore EIGHT**, of which the landed-status row was **paid at `J-dv_lead-0176`** and the other seven are paid here. This round's own change-log row — the one you are reading — is the §9 discipline that attaches to any edit of this document, not a ninth debt item; counting it as one is what produced the ninth. **`BUG-0004` §10.4's trip condition is met on its own terms**: its item is *"two new family-G rows"*, and both are below. Enumerated, each with the entry that minted it: **(1)** `M04-B2`/`M04-C4`'s poison quantifier — `FINDING AP-M04-3`, `J-dv_lead-0171` — scoped to wire octet indices `0 … F−5` with the FCS excluded **and the exclusion's reason stated**, the four FCS octets being a computed value that may legitimately equal the poison; **(2)** `M04-J3`'s quotation of REQ-210's **struck** opening clause, `J-dv_lead-0171` — struck in place with its date, the repaired REQ-210's own separation stated, and §8 item 1 closed with it (`FINDING AP-M04-1` SUSTAINED/CURED/CLOSED at `816e187`), because a row cured while its finding still reads OPEN two sections later leaves the document at odds with itself; **(3)** carry-forward **C-5**'s superseded deferral, `J-dv_lead-0171` — repaired at **four** sites, the header's carry-forward bullet, §0.2 item 3, §2 obligation 5 and §8 item 3, C-5 having been **DISCHARGED at `ee47eee`** by §0.6's fourth reference-word clause; **(4)** the §9 landed-status row — **paid at `J-dv_lead-0176`**, not re-paid here; **(5)** `M04-G7`'s ground — `FINDING ABS-1`, `J-dv_lead-0173`, mine, and **wrong when written rather than made stale**: the row denied that §0.6's first clause reaches an underflowed frame, and it does, since that clause names the last octet the frame *received while it was open*. The NO-ASSERT status and the conclusion do not move; the ground is now the fourth clause's own *"carries no independent information"*; **(6)** `M04-B1`'s uniqueness quantifier, `J-dv_lead-0174` — *"at no other position"* was a universal over the **run**, falsifiable at this row's own stimulus because `/I/` is `0x07`; scoped to the frame's own wire octets; **(7)** and **(8)** the two new family-G rows below, owed since `J-dv_lead-0175` and `J-dv_lead-0176`. **Three of the eight are the same defect in three places** — a universal stated over a domain the claim cannot survive, twice caught by the worker executing my instrument and once by my own countersignature — which is why they are enumerated rather than summarised. **TWO ROWS ADDED, family G 8 → 10, both `ASSERT`, both `BUG-0004` §10.3's**: **`M04-G9`**, the `W = 1` collapse, the shape at which REQ-206's window is provably empty because the frame's `tlast` word is accepted at the cycle the frame starts — the defect measured red at `fcf6f08` and green at `02f762a`, which this plan had no row for and which a standing instrument caught on stimuli commissioned for the pad boundary; and **`M04-G10`**, the pre-loaded back-to-back handover at `C + 8`, covering that packet's routes 2 and 3 — **fixed by derivation and never measured in either design** — with `M04-G5` named as the opposite-verdict neighbour on both. **The `SO-` precondition is now readable from this plan and not only from a closed bug packet**: §0.2 item **4** bars any `SO-xgmii_tx_64.md` from reporting REQ-206 coverage while `M04-G10` is neither measured nor declared a gap, §7 item **T-7** names the missing machinery with an executor, §8 item **7** carries it as a gate condition, and §5 item **11** records the two rejections the new rows owe (an idle-injection wrapper at the source — forbidden by SPEC-M04 §7's own normative sentence, because the first injected cycle on a required cycle *is* an underflow; and statusing the rows `GAP`, which would read as structurally unavailable coverage rather than as unbuilt machinery). **`FINDING BUG-0004-1` is discharged here** — that packet's `W = 2` conversion rule is restated at §0.2 item 4 over the **mechanism** (*can the chain present a frame whose `tlast` word is in this module's hands at or before the cycle the frame starts?*) rather than over a word count; the malformed original sentence lives in `BUG-0004` §6, whose own §10.2 already corrects it in place, and that packet is **CLOSED and outside this round's write set**, so nothing there is edited. **COUNTS, re-measured at this tree by a status-cell pass before and after every edit, never carried forward: 82 rows (82 distinct ids), 58 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP, 0 RULING** — the deltas are exactly the two new ASSERT rows, and **no `Status` cell of any pre-existing row moved**. §6.1's homing census re-run with its own quoted command: **82 82 []**, the printed figure updated in place because a census carried forward is what §0.1(i) forbids. **Outstanding moves from 67 of 80 to 69 of 82**: the two new rows are added **undischarged**, and the thirteen-row tally of the row above is untouched. **One measurement is recorded and deliberately NOT called a discharge**: `M04-G9`'s observable is met at `af06c62` by the landed bench's standing instruments — `test/xgmii_tx_64/bench.ml`'s `assert_instruments_clean` fails the run unless `error_underflow` is high for **0** cycles, and `test/xgmii_tx_64/test_m04_b.ml`'s directed set contains `P = 1`, which is `W = 1` — but that run was adjudicated by `RV-0080B-VERDICT` against the rows that existed at that verdict, and a row written afterwards is not discharged by it without an adjudicating instrument saying so. The measurement is recorded with its provenance so the next `SO-` round decides with it in front of them, and the discharge count is not moved by this row. **`BAR T1` stays SHUT; no `SO-` is opened or offered; `M04-G4` is still not discharged.** The same round repaired `AP-ip_eth_rx_64`'s family F on the same discipline (that plan's §9, same date). | dv_lead, `J-dv_lead-0177` |
| 2026-08-11 | **The second M04 bench round is ABSORBED: TWELVE ROWS DISCHARGED at `aabae58` — ten ASSERT by a green assertion and two NO-ASSERT by a prohibition that held. Families D and E are COMPLETE, the first two families to close at this module.** `M04-D1`, `M04-D2`, `M04-D4` (U11, `test/xgmii_tx_64/test_m04_d.ml`, the directed set `P ∈ {1, 20, 59, 60, 61, 64, 67, 1514}` — D1 the four wire octets at `F−4 … F−1` against `Frame.fcs (Frame.pad_to_60 (content_octets ~p))` octet for octet in wire order, D2 `Frame.residue_ok` over the whole decoded frame as **corroboration and expressly not a second REQ-202 anchor**, D4 each FCS octet's own `(cycle, lane)` read off the raw sample plus the `P = 60` / `P = 64` contrast); `M04-D5` (**NO-ASSERT**, U11 title + round-wide — no unit, comment, title or verdict sentence asserts the CRC **enable** or its `octet_count`, and ADR-0007's mechanism is **not** claimed as behaviourally checked at this module); `M04-D3` (U12, two `P = 60` frames differing in octet 0 alone, anti-vacuity asserted first and by itself); `M04-D6` (U13, the all-zero 60-octet frame, the oracle's value computed at run time and **printed**, asserted non-zero against the seed-instead-of-finished-value defect); `M04-E1`, `M04-E2`, `M04-E3` (U14, `test_m04_e.ml`, the eight-lane sweep `P ∈ {60 … 67}` — **one cycle, eight lanes**, all eight terminating at `C + 10` with only `t = F mod 8` moving; E2's fill asserted as a **value** (control bit set **and** `xgmii_txd` = `0x07`) over the terminate word's lanes `t+1 … 7` and every lane of cycles `terminate_cycle + 1 … run_length − 1`; E3's boundary pair `t = 7` zero fill lanes / `t = 0` seven, the zero **counted** rather than left to an empty loop); `M04-E5` (**NO-ASSERT**, U14 title + round-wide — every scan reads **that run's own** `terminate_cycle`/`terminate_lane` and no helper is written as a universal over terminate characters, so no assertion here fails a conformant M04 on an underflowed frame); `M04-E4` (U15, `P = 1514`, `/T/` at lane 6 of `C + 2 + 189` — the row whose content is `⌊F/8⌋ = 189` and not the lane); `M04-G9` (U16, `test_m04_g.ml`, `P ∈ {1, 8}`, `W = 1` at both — the frame transmits intact **and** the `error_underflow` strobe's exact event set is **empty**, called first and named as the row's own assertion rather than as a background check). Carrier `WO-0081` (`RV-0081-VERDICT` **ACCEPT**, 20 of 20 bars, `J-dv_lead-0179`; no bounce condition fired; **`BM17` ARMED and NOT tripped** — zero instruments outside §17.1's allow-list, disclosed or otherwise). **`M04-G9`'s discharge is the adjudicating instrument the row above deliberately withheld**: `J-dv_lead-0177` recorded that the landed bench's standing instruments already met this row's strobe half at `af06c62` and refused to count it, because a row written after a run is not discharged by that run merely because the run would have passed it. This round gives the row its own stimulus, its own unit, its own content assertions and a verdict, and **that** is what discharges it. Evidence: CI `build` run **31494947078**, job `build` **93790202820** at `aabae58`, steps *Build* `success` and *Run tests (expect tests, waveform snapshots)* `failure`, read by name and status; the failure is **§15 class P**, the pre-committed promotion of U13's `[%expect]` block and **nothing else** — `dune promote`'s own `git diff --name-only` in that step names **exactly one** file, `test/xgmii_tx_64/test_m04_d.ml`, whose sole hunk replaces that unit's own empty `[%expect]` block with printed oracle data carrying **no exception text**, so all six units of this round ran and **none of their OCaml assertions fired**, and no other expect test in the repository moved. The same class-P red, byte-identical in its promotion payload, is re-read in full at run **31495302673** job **93791378385** (`cddad51`, rtl_lead's M07 landing, which touches `libs/**` only — `git diff aabae58 cddad51 -- test/` **empty**). **The promotion is placed in this round by dv_lead**, reconstructed from the CI promotion block by two independent channels that converge byte for byte — the base64 payload decoded, and the tree file with that one line substituted — both at sha256 `e1f8e9f0b4abbfa2af7a9b8743cc2e1f9427632e16bb41569397a08496f72979`, the figure CI itself printed, verified under four instruments (`sha256sum`, `openssl dgst`, Python `hashlib`, `shasum -a 256`); and **the printed value was checked against an oracle outside this repository before it was accepted as an expectation** — `CRC32` of sixty zero octets is `0x04128908`, i.e. `0x08 0x89 0x12 0x04` least significant octet first, agreeing under Python `zlib.crc32` and an independently written bit-serial routine over the reflected IEEE 802.3 polynomial `0xEDB88320`, both anchored on REQ-303's published check value `0xCBF43926`. **The completing event is named and not assumed**: the *Run tests* and *Verify nothing was left unpromoted or non-deterministic* steps are `failure`/`skipped` until the commit carrying this promotion runs green. **If that run is not green at both steps, this discharge is VOID and these twelve rows reopen** — the condition is recorded here rather than left to be inferred, because a discharge whose completing run was never read is the shape `FINDING WO-0080-2` convicted. **NO ROW ADDED, NO ROW CONVERTED, NO STATUS CELL MOVED, NO COVERAGE-MAP LINE CHANGED, NO CELL OF ANY ROW TOUCHED: 82 rows (82 distinct ids), 58 ASSERT, 12 NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP, 0 RULING** — re-measured at this tree by a status-cell pass over every row table, before and after this edit, and **not** carried forward. The twelve discharged here measure **ten ASSERT + two NO-ASSERT** by that same pass, which is `WO-0081` §2's own figure and which corrects the carrier's worker journal (`J-tb_writer-0044`, Trigger) where the same split is written *"eleven ASSERT + one NO-ASSERT"* — a count in a narrative sentence, contradicted by that round's own `dune` header row, which states ten and two correctly; nothing in the work depends on it. **The discharge count remains a HAND COUNT with its provenance**: `tools/dv_checks.sh` at this commit still contains **zero** occurrences of `M04`, `xgmii_tx_64` or `AP-xgmii_tx`, so **no committed instrument counts an M04 row** and `DVC-1a` is still owed and still load-bearing for any coverage fraction. **Outstanding moves from 69 of 82 to 57 of 82.** **Three defects were reported by the carrier's worker rather than adopted, and are adjudicated at `RV-0081-VERDICT` §4**: two UPHELD against `WO-0081` (its §6.1 prose and §6.2 assertion-6 cell call wire octet 59 at `P = 60` a *"pad octet 59 (`0x00`)"* where `P = 60` has pad count **zero** and that octet is the last **content** octet, value `0x3C`; and *"eleven exported values"* of `bench.mli` at **four** packet sites where a status-cell pass measures **twelve**, the enumeration having counted `decoder`/`strobes` as one) and one REFUTED (the §6.1 master table's `P = 67` FCS cell reads *"lanes 3–6 of `C + 10`"*, which is correct and is what the worker's own derivation produced — it misattributed the neighbouring `P = 63` row's cell). **None of the three touches a row of this plan and no cell here moves on any of them.** **`BAR T1` stays SHUT; `§0.2` item 4's REQ-206 bar stays in force; no `SO-xgmii_tx_64.md` is opened or offered; `M04-G4` and `M04-G10` are NOT discharged and are not described as such; REQ-206 is NOT described as covered.** | dv_lead, `J-dv_lead-0179` |
