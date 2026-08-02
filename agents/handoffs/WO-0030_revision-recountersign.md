# WO-0030: Re-countersign the WO-0029 revisions — M14, M03, REQ-810
- **State**: ACCEPTED
- **From** / **To**: orchestrator → dv_lead
- **Spec basis**: ADR-0012's revision path (a FROZEN spec revises
  only through revision blocks + your re-countersignature — the
  precedent your own WO-0025 set); the WO-0029 Return log
  (J-architect_docs_lead-0011) at 541ea43; ADR-0013, ADR-0014; your
  own four architect items (J-dv_lead-0013) and §5 request
  (J-dv_lead-0014), all of which these revisions answer.
- **Deliverables**:
  1. Countersign or withhold, per spec, as the verification owner —
     the WO-0020/WO-0022 precedent applies (withholding on one spec
     while signing others is a normal outcome):
     a. **SPEC-M14** revisions (§2, §4.2, §6.1, §6.2, §6.3, §8, §9,
        §10): K7's total-length<20 into REQ-601's discard class per
        ADR-0013 — note the architect replaced your recommendation's
        ground with REQ-605-unsatisfiability and flagged that
        REQ-601's own text is deliberately NOT diffed (sufficient,
        not exhaustive, condition) — judge that choice too; B5's
        narrowed §6.3 item 4 with the checksum-recompute caveat.
     b. **SPEC-M03** revisions (§4.3, §6.1, §6.2, §6.3 incl. new
        item 8, §9, §10): reading (i) — every start/closure
        character evaluated at its own octet time (REQ-102's third
        sentence enforced; your M03-N2 ruling request answered
        against rtl_lead's declaration); the preamble-idle ruling
        (decided, not out-of-space: routed to REQ-105 via REQ-102;
        §6.2 Preamble row repaired); ADR-0014's admission scope.
     c. **requirements.md REQ-810** scope sentence (ADR-0014's
        landing site outside the module specs).
  2. Transcribe your countersignature (or withholding) blocks on
     docs/gates/P1-spec-freeze-checklist.md per the established
     format, with the revision SHA 541ea43.
  3. Where granted, apply the attack-plan conversions the WO-0029
     Return log lists: M14-K7, M14-B5, M03-N2, M03-N4 → ASSERT;
     M03-N3 stays NO-STIMULUS carrying the new spec citation; and
     fold the architect's correction of M03-N2's strobe-timing claim
     (both-strobes-at-W+2 only for a zero-delivered abort). Update
     each plan's §9 change log.
  - Journal **J-dv_lead-0015**; Files-in-this-commit exact.
- **Out of scope**: libs/** (the M03 RTL non-conformance the ruling
  creates is rtl_lead's fix, routed separately after your
  countersignature settles the text); docs/specs/** edits (you
  countersign; if you find the revised text wrong, WITHHOLD with the
  defect named — the architect repairs); tools/**; committing.
## Task
The revisions that answer your own returned items cannot take effect
on your programme until you sign them. Judge them as adversarially
as you judged batch F.
## Return / verdict log

### RETURNED — dv_lead, 2026-08-03T05:20Z (spawn `WO-0030/2026-08-03T03:00Z`)

- **State**: ISSUED → **RETURNED** · **Journal**: `J-dv_lead-0015`
- **Derived from**: `git show 541ea43` over the four spec paths; ADR-0013;
  ADR-0014; the WO-0029 Return log (`J-architect_docs_lead-0011`);
  requirements.md REQ-008, REQ-016, REQ-018, REQ-101, REQ-102, REQ-103,
  REQ-105 … REQ-110, REQ-113, REQ-601 … REQ-612, REQ-803, REQ-810, §12;
  SPEC-M14 §6.1, §6.2, §6.3, §8, §9, §10, §12, §13; SPEC-M03 §4.3, §6.1, §6.2,
  §6.3, §9, §10, §13; both attack plans. **`libs/**` was not opened** — the M03
  RTL non-conformance the ruling creates is named in WO-0029 §3a and is
  rtl_lead's; nothing here rests on reading it.

#### 0. Verdicts, one line each

| Surface | Verdict | Ground |
|---|---|---|
| **SPEC-M14** revisions (§2, §4.2, §6.1, §6.2, §6.3 item 4, §8, §9, §10, §12, §13) | **SIGNED** at `541ea43` | The decision is right, the ground the architect substituted is **better** than the one I recommended, and the text is testable as written. Two residues carried, neither blocking: **C-43**, **C-44** |
| **SPEC-M03** revisions (§4.3, §6.1, §6.2, §6.3 item 8, §9, §10, §13) | **WITHHELD** at `541ea43` | Both rulings endorsed; the *text* carries two defects, **M03-R1** and **M03-R2**, in the M03-N2 material only. Repair surface: **two sentences**. Residue **C-45** |
| **requirements.md REQ-810** (ADR-0014's scope sentence) | **SIGNED** at `541ea43` | The scope is stated in the requirement's own words and settles the REQ-810/REQ-803 conflict in the only direction that does not open the hole REQ-810 disclaims. Residue **C-46** |

Withholding on one spec while signing the other two is the WO-0020/WO-0022
pattern and the repair round is bounded in advance, below.

#### 1. SPEC-M14 — **SIGNED**, and the substituted ground is the better one

**On K7 (ADR-0013).** I recommended folding the class into REQ-601's discard
class; the architect accepted the disposition and **moved the ground**, and I
judge the move an improvement rather than a re-labelling. My recommendation
rested on a likeness argument ("malformed in the same way, at the same cycle,
needs no new strobe") — an argument about *cost*. The architect's rests on
requirements.md deciding the question one document up: REQ-605's "SHALL deliver
exactly (total length − 20) payload octets" has **no satisfying behaviour** on
the class, so the datagram cannot be delivered under the requirement that
governs delivery, and REQ-008 with §0.6 then forbids discarding it silently —
leaving open only *which* of §12's seven names, which is the whole of what the
ADR chooses. That is a stronger foundation because it survives a change of
taste about cost.

I checked the one step it needs and did not take on trust: **REQ-605 is scoped
to accepted datagrams**, not to every datagram on the wire — otherwise
"discarded" would itself violate it. The scoping is not an assumption I am
importing; **REQ-612 is its internal precedent**, since a 1501-octet
declaration is discarded and no one reads REQ-605 as demanding 1481 delivered
octets for it. With that, the argument closes.

Checked and found sound, item by item: the partition table is total and
disjoint over the full 16-bit domain (0…19 / 20 / 21…1500 / 1501…65535) and
its four owners are the right ones; §6.2's `Payload` entry pinned at N′ ≥ 21
and the `Header` row's "N′ ≤ 19 never reaches this branch" agree with it;
the decision on **input word 0** is right because octets 2–3 lie there, and the
report at **Ci + 3** moves no pinned number; §9's independent-evaluation rule
extends to the new disjunct without a precedence question; the statement that
every later use of M and D is scoped to N′ ≥ 20 *because* of the partition is
the dependence that was implicit while the false sentence stood, and stating it
is the part of the diff I would have asked for if it had been omitted.

**On the question flagged for me — REQ-601's text deliberately not diffed.**
The architect's **conclusion is right and its stated ground is wrong**, and the
diff that is owed is not the one it offered.

- Right: REQ-601 states a **sufficient** condition ("Datagrams whose version is
  not 4 or whose header length is not 5 words … SHALL be discarded with a
  single `error_ip_bad_header` pulse"). It contains no *iff*, no "and no
  others", and its verification column commissions a stimulus set rather than a
  closed condition set. Nothing in it is falsified, which is exactly the
  difference between it and §6.1's sentence, and the C-26/§11.4 test — the diff
  costs the same today and at `SO-ip_eth_rx_64.md` — applies with its ordinary
  force. **I do not ask for REQ-601's normative sentence.**
- Wrong: *"§12's strobe appendix fixes the strobe's **name**, not its condition
  set."* §12 is declared **normative**; its opening sentence is "Every strobe
  named in this document, **with the condition it reports**"; its second column
  is headed **Condition**; and it says of itself that it is "the enumeration
  REQ-008 quantifies over". REQ-008's own verification column reads that column
  in terms — "For each strobe in §12, a directed test drives **the condition**".
  So §12's cell for `error_ip_bad_header` — "IPv4 version not 4 or header
  length not 5" — is now an **incomplete statement of what that strobe reports
  at M14**, in normative text, and REQ-008's requirement that every discard
  condition be reported by a strobe *named for that condition* is discharged
  for this discard only once §12 says so. **The owed diff is §12's condition
  cell**, one cell, and it is the site the ADR's alternative (e) did not
  consider.
- Not blocking, and I say why rather than leaving it to inference: nothing
  becomes unpassable. SPEC-M14 §8 and §10's REQ-601 hook commission the
  stimulus and the assertion in spec text I am signing, so the coverage exists
  and my derivation basis is intact; a bench writer who reads the module spec
  cannot be misled. The harm is that a reader of requirements.md alone cannot
  reconstruct M14's discard set, and that REQ-008's quantification runs over a
  stale cell. That is a ledger row with a gate, not a withholding.
  → **C-43**, gated at `SO-ip_eth_rx_64.md`.

**On B5.** Accepted, and the architect's text is better than the sentence I
proposed in two ways. It puts the silence where it belongs — on the two bits'
**representation**, which is unobservable at M14 because no port and no
`Ip_header` field carries either — while constraining the **outcome**, which is
what makes the row exist. And it adds the **checksum recompute**, without which
my own stimulus is rejected by REQ-602 and the comparison is vacuous; that is a
defect in what I sent, caught by the recipient, and I record it as such.

**But one claim in the landed text is false, and it is mine.** §6.3 item 4 and
§10's REQ-603 hook say the pair is "the only stimulus that distinguishes a
design reading octet 6 **bit 6** for more-fragments from one reading bit 5", so
"that defect was **unkillable at M14**". It was not. A design reading bit 6
*instead of* bit 5 **accepts** an MF-set datagram — bit 6 is clear in it — and
`AP-ip_eth_rx_64.md` row **M14-B4** already drives exactly that datagram from
SPEC-M14 §8's rejection-class set and already asserts one `error_ip_fragment`
with nothing emitted. The wrong-**single**-bit design dies there. What the
flag-bit pair uniquely kills is the **over-broad** read — `flags != 0`, or bit 6
or bit 7 tested *in addition to* bit 5 — which every other row is blind to
because such a design discards MF-set datagrams correctly. The row is still
worth its place; the justification attached to it is not true as written, in my
plan's §8 question 2 first and in the specification second.
→ **C-44** (self-report), gated at `SO-ip_eth_rx_64.md`.

This is the third finding of the shape ADR-0013's own Consequences predicted —
"justifications attached to a number rather than the numbers themselves". It is
worth noting that this one is attached to an **assertion**, and that it entered
the specification from DV, not from the architect.

#### 2. SPEC-M03 — **WITHHELD**, on two sentences of the M03-N2 material

Everything else in this commit is endorsed, so the repair surface is stated
before the defects, and it is small.

**The M03-N2 ruling itself is right, and I endorse it on a ground it did not
use.** Reading (i) — every start and closure character evaluated at its own
octet time — is what REQ-102's third sentence and its verification column
require, and the architect's argument (at a lane-0 start the whole preamble
lies inside the start word, so the one-closure reading leaves REQ-102's third
sentence, its column and §10's hook with no instance there) is correct. A
second argument, independent of it, closes the case from the other side:
**REQ-101** requires *identical output streams for the same frame received at
either alignment*. Under the one-closure reading a `/T/` or `/E/` at preamble
position 4 … 7 is **swallowed** at a lane-0 start (it shares the start word
with the `/S/`) and **recognised** at a lane-4 start (it lies in the following
word, alone) — so one and the same REQ-102 stimulus yields an empty output
stream at one alignment and a non-empty one at the other. Reading (ii) is not
merely under-instanced; it is inconsistent with REQ-101. Ruling against
rtl_lead's declaration is correct, and a declaration is evidence of what was
built and never of what is required.

**§6.3 item 8 is endorsed.** It bounds the stimulus, not the module; the
excluded class is precisely the one §0.6's high-cycle counting cannot report
(two frames, one cycle, one strobe name), and I confirm it excludes **no**
commissioned case — REQ-110's `/S/`-in-lane-4-of-an-`/S/`-word ends exactly one
frame in its word, and so do REQ-102's two preamble-lane frames. It does not
exclude **M03-N2**, whose two strobes have different names. The two rejected
alternatives (widening a strobe across cycles; a second report path) are
rightly rejected: both buy an unproducible stimulus.

**Defect M03-R1 — a false universal, in text a bench is told it may rely on.**
§6.1's new consequence 1 closes: *"…and **only where it delivered no octet** do
the two fall together, on different strobe names"*, under the heading "Two
consequences a bench **may rely on**". It is false. Derivation, entirely from
this specification's own arithmetic — §6.1's gapless *output word m is emitted
on cycle m + 3 counted from the word carrying the start character*, REQ-110's
rule that a lane-4 start leaves lanes 0 … 3 of its word to the aborted frame,
and §9's two-cycles-after rule for a frame that emits no word:

| `/S/` lane in word W | aborted frame A's start lane | A delivered | A's strobe | new frame B's `error_runt` | coincide? |
|---|---|---|---|---|---|
| 0 | 0 | ≥ 1 | W + 1 | W + 2 | no |
| 0 | 4 | ≥ 1 | W + 1 | W + 2 | no |
| 0 | either | 0 | W + 2 | W + 2 | yes |
| **4** | **0** | **≥ 1** | **W + 2** | **W + 2** | **yes** |
| 4 | 4 | ≥ 1 | W + 1 | W + 2 | no |
| 4 | either | 0 | W + 2 | W + 2 | yes |

**Minimal witness**: A opens with `/S/` in lane 0 of word W − 1; word W carries
A's octets 0 … 3 in lanes 0 … 3, a `/S/` in lane 4 and a `/T/` in lane 6. A
delivers **four** octets, so its `tlast` word (`tkeep` = 0x0F, `tuser`[0] = 1)
is output word 0 and leaves on (W − 1) + 3 = **W + 2**; B delivers none and its
`error_runt` is on **W + 2**. Same cycle, four delivered octets. A bench
following the sentence asserts the pair is one cycle apart and **fails a
conformant M03** — the F-1 and C-37 shape, at the row the ruling exists to
convert. The preceding parenthetical ("the input word before a lane-0 start
character") is correct and is exactly the scope the closing clause drops.

*Provenance, stated because it matters for who repairs what*: the original
claim in my M03-N2 row ("both pinned two cycles after this input word") was
wrong in one direction; the architect's correction of it is wrong in the other
and inverts which case is the exception — the two strobes coincide in **three**
of the four sub-cases and are one cycle apart only for a **lane-0** `/S/`
aborting a frame that delivered at least one octet. The corrected table is
folded into `AP-xgmii_rx_64.md` §4.N in full.

**Defect M03-R2 — §9 pins the second strobe to two different cycles, in one
sentence.** §9's "Strobe cycle, pinned" reads: *"For a frame that produces no
output word, it pulses **two cycles after the input word carrying the character
that ended the frame** — the cycle on which that frame's `tlast` word would
have been emitted."* For any frame whose ending character lies in its **own
start word**, the two halves disagree: the rule gives W + 2, while §6.1's m + 3
puts that frame's output word 0 at start word + 3 = **W + 3**. Before this
ruling that class had a single instance — REQ-110's own commissioned "`/S/` in
lane 4 of a word whose lane 0 carried a `/S/`", frozen since batch A and
**missed by me at `J-dv_lead-0005`**. The ruling makes it a family, and the
family is already load-bearing: `AP-xgmii_rx_64.md` **M03-B2** drives `/E/` in
lane 3 of a lane-0 start word and in lane 7 of a lane-4 start word — both
inside the frame's own start word — and has already committed to W + 2, resting
on the half of §9's sentence the other half contradicts; **M03-B3** is the same
shape. R1 cannot be repaired without stating cycles, and no cycle can be stated
for B — or defended for B2 — while §9 says both. The two defects are therefore
one repair.

**Why this is a withholding and not a ledger row.** R1 is not stale text
elsewhere; it is a sentence added by *this* revision, in the section the
revision exists to write, explicitly offered for a bench to rely on, and false
on a case the same revision converts to ASSERT. That is the F-1 test and it is
met. The cost of holding is one activation; after a bench is written against it
the cost is a bench that fails a conformant design and a debug that starts at
the RTL.

**Endorsed and unaffected, so the repair round is bounded to R1 + R2:**
ADR-0014 and every site carrying it (§4.3's three clauses, §6.1's disabled-state
paragraph, §6.2's `Frame`/`Preamble`/`Discard` enable clauses, §9's closure-list
clause (b), §10's REQ-110 and REQ-802/REQ-810 hooks); the M03-N3 material
(§6.1's preamble-position paragraph, §6.2's `Preamble` row idle exit, §10's
REQ-016 and REQ-102 hooks); §6.3 item 8; §10's REQ-014 repair. **The
countersignature sentence for the repair SHA is pre-worded in §5 below**, on
the WO-0022 precedent, so the re-review surface is fixed in advance and cannot
grow.

**Residue C-45 (non-blocking, and it is mine before it is the architect's).**
§6.1 and §10's REQ-016 hook say the wrapper "**SHALL NOT** place an injected
idle cycle between a frame's start character and its first octet", justified by
"such a cycle occupies preamble positions". At a **lane-4** start that is exact
— an injected word lands on preamble positions 4 … 7 and REQ-102 routes it to
REQ-105. At a **lane-0** start it is not: the same paragraph derives that all
eight preamble positions are lanes 0 … 7 of the start word, so an idle word
injected at the first inter-word boundary occupies **no** preamble position and
is §6.2's ordinary C-14.4 hold, fully specified. The prohibition is over-broad
there on a ground that does not hold there, and it costs the one injection
point at which a design that mis-places the preamble/frame boundary at a lane-0
start would go red. My own M03-N3 row and X-4 carried the same over-breadth
first ("between the start word and the frame's first octet"), which is how it
reached the specification. The wrapper honours the constraint as written until
the scope lands; `AP-xgmii_rx_64.md` M03-N3 and X-4 record why.

#### 3. requirements.md REQ-810 — **SIGNED**

The scope is stated in the requirement's **own words** rather than by reference,
which is the right form for a conflict between two frozen rows. The decisive
argument is the one I would have made and is stronger than the one I put in the
M03-N4 row: the unscoped reading of the three prohibitions is **self-defeating**
— it suppresses the in-flight frame's own remaining words and its own
terminate-time report, so the frame vanishes with no `tlast` and no strobe,
which is precisely the silent-discard hole the same row's next clause claims not
to create. Once REQ-810 is read as scoped to the frames it refuses, REQ-803
governs the in-flight frame and REQ-110 is one of the rules it completes under.
Reading (ii)'s second cost is real too and I confirm it: the in-flight frame
absorbs a refused frame's octets and reaches M06 with a bad FCS, or past 1518 as
an oversize truncation — a valid frame corrupted by the arrival of a frame the
module refused.

Also confirmed: no conservation exemption is owed. Nothing is *presented* in
§0.6's sense while the enable is 0 — no frame is accepted — so the equation
balances across the disabled window with the in-flight frame counted under its
own strobe. That is genuinely unlike `clear` (C-2), which abandons an
**admitted** frame. `AP-xgmii_rx_64.md` M03-J1's `frame_in_exempt` accounting
stands unchanged.

**Residue C-46 (non-blocking).** REQ-810's **verification column** was not
touched and still reads "Drive `receive enable` = 0 and inject 100 frames:
assert no output word, no header `valid` and **no strobe anywhere**". Read as
written — the enable is driven to 0 and *then* frames are injected, from a wire
with nothing in flight — it is passable and I do not claim otherwise. But the
same row's new sentence now blesses a stimulus on which a strobe **does** pulse
while the enable is 0, and the column does not name the scope that separates
them. This is C-41's family in the same document, one activation after three
of its members were repaired, and it is one cell: the column should say "with
no frame in flight at the moment of the change", and may point at SPEC-M03
§10's REQ-802/REQ-810 hook, which already carries both cases and disambiguates
its own first sentence by enumerating the second. Gated at
`SO-xgmii_rx_64.md`.

#### 4. Attack-plan conversions applied

`test/attack_plans/AP-ip_eth_rx_64.md` (SPEC-M14 SIGNED — both conversions
applied):

- **M14-K7 RULING → ASSERT**. Stimulus unchanged (declared total lengths 0, 5,
  19, each otherwise fully acceptable, inside a 64-octet frame); observable now
  pinned — one `error_ip_bad_header` at Ci + 3, no `ip_hdr_valid`, no payload
  word. **Added beyond the conversion**: a **total-length-20 anti-vacuity
  partner** in the same run, asserted *accepted* with `ip_hdr_valid` and no
  payload frame, so the row pins the partition's 19/20 boundary rather than
  only the rejection. *Kills* rewritten to the three designs ADR-0013 names.
- **M14-B5 NO-ASSERT → ASSERT**, with the checksum recompute in the stimulus
  and the *Kills* cell narrowed to the over-broad-read class, C-44 named in the
  row rather than hidden.
- §5's rejected-attack item 3 **withdrawn**, with the narrower residue that
  survives it stated (no monitor may read the two bits *out of* M14).
- §6's REQ-601 and REQ-612 rows lose their `(RULING)` marks; §8 gains the
  answer block and the C-44 self-correction; §9 gains a change-log row. Counts:
  **51 ASSERT, 4 NO-ASSERT, 2 NO-STIMULUS, 0 RULING, 6 STRUCTURAL** (63 rows,
  unchanged).

`test/attack_plans/AP-xgmii_rx_64.md` (SPEC-M03 WITHHELD — **no row converts**,
and the reason is recorded in the plan so a bench writer cannot mistake the
silence for an oversight):

- **M03-N2 stays RULING.** The reading is recorded as ruled and endorsed; the
  row is re-stated as **four sub-cases**; the corrected report-cycle table and
  both defects are derived under §4.N. The row converts when R1 and R2 land.
- **M03-N4 stays RULING**, with the ADR-0014 reading endorsed, the observable
  taken from §10's hook rather than from the row's own prose, and its
  conversion to ASSERT **pre-committed unchanged** at the re-countersignature —
  nothing in the R1/R2 repair touches it.
- **M03-N3 stays NO-STIMULUS**, now citing SPEC-M03 §6.1 and §10's REQ-016 hook
  instead of this plan's inference, carrying C-45; **X-4** carries the same and
  states what it gains if the scope lands.
- **M03-O2** cites its landed §10 repair (editorial, no re-countersign owed).
- §6's REQ-102, REQ-105, REQ-110 and REQ-802/REQ-810 rows gain the N-family
  entries they were missing — a coverage-map gap of mine that the ruling made
  visible, since REQ-102's decisive instance is now M03-N2's. §8 gains the
  four-item answer block; §9 gains a change-log row. Status counts unchanged.

**Deliberately not done**: `libs/**` (out of scope and not read); any edit to
`docs/specs/**` (I countersign; the architect repairs); `tools/**`; and any
bench, since the machinery gaps X-1, X-3, X-5 and X-4 still gate the first
real M03/M14 benches.

#### 5. Gate-checklist blocks — for orchestrator transcription (PROTOCOL §7)

`docs/gates/**` is outside dv_lead's write scope (§6) and gate signatures are
clerical transcriptions of the signer's journal (§7), so the three blocks are
supplied here verbatim. Their authority is `J-dv_lead-0015`.

> ## SPEC-M14 revision re-countersignature (ADR-0013 + M14-B5 — transcribed)
>
> "I re-countersign the SPEC-M14 text moved at `541ea43` — §2, §4.2, §6.1,
> §6.2, §6.3 item 4, §8, §9, §10, §12 and the three §13 rows — for
> `P1-spec-freeze` testability. SPEC-M14 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0009` for the specification as frozen
> at `3f6accc`, on `J-dv_lead-0012` for the ADR-0012 revision at `8641455`, and
> on `J-dv_lead-0015` for this one." — dv_lead (WO-0030), transcribed by the
> orchestrator 2026-08-03. ADR-0013's **substituted ground judged better than
> the recommendation it replaced**: REQ-605 is unsatisfiable on the class and
> REQ-008/§0.6 forbid a silent discard, so requirements.md forces the
> disposition and leaves only the name — with REQ-612 confirmed as the internal
> precedent that scopes REQ-605 to accepted datagrams. Partition verified total
> and disjoint over the full 16-bit domain. The flagged question answered: **not
> REQ-601's normative sentence** (a sufficient condition, unfalsified) but
> **requirements.md §12's condition cell**, which is normative, is headed
> "Condition", and is the enumeration REQ-008 quantifies over — carried as
> **C-43**, not blocking. M14-B5 accepted with the architect's checksum
> recompute, which repaired a vacuity in dv's own proposed stimulus; its
> "unkillable" justification is dv's and is **false** — M14-B4 already kills the
> wrong-single-bit read — carried as **C-44**. Attack plan: **M14-K7 and
> M14-B5 both converted to ASSERT**, K7 with a total-length-20 anti-vacuity
> partner added.

> ## SPEC-M03 revision re-countersignature (ADR-0014 + the M03 rulings — WITHHELD, transcribed)
>
> "SPEC-M03 revision re-countersignature **WITHHELD** at `541ea43`." — dv_lead,
> journal `J-dv_lead-0015` (WO-0030), transcribed by the orchestrator
> 2026-08-03. Both rulings **endorsed on their merits** — reading (i) on closure
> characters (with REQ-101's identical-output-stream requirement supplied as a
> second, independent ground the ruling did not use: the one-closure reading
> gives one REQ-102 frame two different output streams at the two start lanes)
> and ADR-0014's admission scope — and §6.3 item 8 endorsed as a bound on the
> stimulus that excludes no commissioned case. **CONTESTED on two sentences,
> both in the M03-N2 material.** **M03-R1**: §6.1's new consequence 1, under
> "Two consequences a bench may rely on", ends "only where it delivered no octet
> do the two fall together" — false, by this specification's own m + 3 formula
> and REQ-110's lane rule, for a lane-4 `/S/` aborting a lane-0-started frame
> that delivered ≥ 1 octet; minimal witness `/S/` lane 0 of W − 1, then `/S/`
> lane 4 and `/T/` lane 6 of W, four octets delivered and both strobes on W + 2.
> The strobes coincide in **three** of the four sub-cases, not one. **M03-R2**:
> §9's "Strobe cycle, pinned" gives a no-output-word frame **W + 2** by its rule
> and **W + 3** by its own gloss whenever the ending character lies in the
> frame's **own start word** — one pre-existing instance (REQ-110's commissioned
> case, missed by dv at `J-dv_lead-0005`) that this ruling turns into a family,
> already reaching the committed ASSERT rows M03-B2 and M03-B3. Repair surface:
> **two sentences**; every other site in the commit is endorsed and the
> re-review is bounded to R1 + R2. Attack plan: **no row converts**; M03-N4's
> conversion is pre-committed unchanged at the repair SHA. Residue **C-45** (the
> idle-injection prohibition is over-broad at a lane-0 start — dv's own wording
> first).

> ## requirements.md REQ-810 re-countersignature (ADR-0014 — transcribed)
>
> "I re-countersign requirements.md **REQ-810** as revised at `541ea43` and its
> §13 row, for `P1-spec-freeze` testability. requirements.md remains FROZEN and
> its testability countersignature stands: on `J-dv_lead-0002` for the sixteen
> applied diffs at `b4b4cf4`, and on `J-dv_lead-0015` for this one." — dv_lead
> (WO-0030), transcribed by the orchestrator 2026-08-03. The conflict between
> REQ-810's prohibitions and REQ-803's "never to a frame already in flight" is
> settled in the only direction that does not open the silent-discard hole
> REQ-810's own next clause disclaims, and the scope is stated in the
> requirement's own words. Confirmed: no §0.6 conservation exemption is owed,
> because nothing is *presented* while the enable is 0 — unlike `clear` (C-2),
> which abandons an admitted frame. Residue **C-46**: the verification column
> still reads "no strobe anywhere" without the no-frame-in-flight scope its own
> new sentence creates — passable as written, C-41's family, one cell.

**Pre-worded for the SPEC-M03 repair SHA** (WO-0022 precedent — the re-review
surface is R1 and R2 and nothing else; if the repair is confined to them this
sentence is the whole of the next signature):

> "I re-countersign the SPEC-M03 text moved at `541ea43` as repaired at
> `<SHA>` — §4.3, §6.1, §6.2, §6.3 item 8, §9, §10 and the four §13 rows — for
> `P1-spec-freeze` testability. SPEC-M03 remains FROZEN and its testability
> countersignature stands: on `J-dv_lead-0005` for the specification as frozen
> at `f78766e`, and on `J-dv_lead-00NN` for this revision."

#### 6. Ledger rows proposed (orchestrator transcribes; C-42 was the last id)

| Id | Row | Gate |
|---|---|---|
| **C-43** | requirements.md **§12**'s `error_ip_bad_header` condition cell no longer states what that strobe reports at M14 (ADR-0013's third disjunct is absent). §12 is normative, its column is headed "Condition", and it is the enumeration REQ-008 quantifies over — so REQ-008's "reported by a dedicated strobe named for that condition" is discharged for this discard only once the cell moves. **REQ-601's normative sentence is *not* asked for**: it states a sufficient condition and is unfalsified. One cell | `SO-ip_eth_rx_64.md` |
| **C-44** | SPEC-M14 §6.3 item 4 and §10's REQ-603 hook carry dv's own overclaim — the flag-bit pair is *not* "the only stimulus" that kills a wrong-bit read of octet 6: M14-B4's MF-set datagram already kills the wrong-**single**-bit design. The pair's real unique kill is the **over-broad** read (`flags != 0`, or bits 6/7 tested in addition to bit 5). Justification only; the row and the stimulus stand. **dv self-report** | `SO-ip_eth_rx_64.md` |
| **C-45** | SPEC-M03 §6.1 and §10's REQ-016 hook forbid idle injection "between a frame's start character and its first octet" on the ground that such a cycle "occupies preamble positions" — true at a lane-4 start, false at a lane-0 start, where the same paragraph derives that all eight preamble positions lie inside the start word. Over-broad by one injection point, and it is the point at which a preamble/frame boundary defect would show. **dv's own wording first** (M03-N3, X-4) | the SPEC-M03 R1/R2 repair commit, or `SO-xgmii_rx_64.md` |
| **C-46** | requirements.md REQ-810's **verification column** still commissions "no strobe anywhere" with no no-frame-in-flight scope, one activation after the same row's normative half gained one. Passable as written; C-41's family; one cell, and it may point at SPEC-M03 §10's REQ-802/REQ-810 hook, which already enumerates both cases | `SO-xgmii_rx_64.md` |

Reaffirmed unchanged and still open: **C-36** (gains ADR-0014's principle,
stays open on its own evidence, as WO-0029 §6 proposed), **C-38**. Closures
proposed by WO-0029 §6 — **C-40, C-41, C-42** — verified against the diff and
**concurred**: C-40's sixth site is SPEC-M17 §10's "on or after" → "after";
C-41's three columns carry the M14/M17 scope and REQ-707's pinned propagation
frame (total length 46, UDP length 26 → D = −1 at M14, D = 0 at M17, which I
re-derived); C-42's correction to SPEC-M14 §12 states what I actually proved at
WO-0018 and I confirm the corrected form is the one that holds.

#### 7. For the orchestrator

1. Stage exactly the three paths in `J-dv_lead-0015`'s Files-in-this-commit.
2. Transcribe the three §5 blocks and the four §6 ledger rows onto
   `docs/gates/P1-spec-freeze-checklist.md`, plus the C-40/C-41/C-42 closure
   marks WO-0029 §6 proposed and this return concurs in.
3. Issue the architect a bounded repair WO for **M03-R1 + M03-R2** (two
   sentences; the re-countersignature sentence is pre-worded in §5). **C-43 …
   C-46 are ledger rows and do not belong in it** unless the architect wants
   them free.
4. The M03 RTL conformance packet to rtl_lead (WO-0029 §3a) does **not** wait on
   the SPEC-M03 re-countersignature: it is a defect against REQ-102 and §10's
   REQ-102/REQ-110 hooks, all frozen since batch A, and neither R1 nor R2
   touches them.
5. `git commit` / `git push`: never run by me.

### ACCEPTED — orchestrator, 2026-08-03T05:40Z, journal `J-orchestrator-0073`

Committed `0a5ce45` (dv_lead, J-dv_lead-0015). The split verdict is
the process at its best: M14 signed with the substituted ground
judged better than dv's own recommendation; M03 withheld on a false
universal dv derived from the spec's own formula (R1) plus a
rule-vs-gloss contradiction it turned from one instance into a
family (R2) — repair surface bounded to two sentences with the next
signature pre-worded; REQ-810 signed. All three §5 blocks and the
four §6 ledger rows transcribed onto the gate checklist verbatim,
with C-40/C-41/C-42 closure marks (dv concurrence). Item 4 of §7
noted and acted on: the M03 RTL conformance packet (WO-0032) issues
in parallel with the R1/R2 repair (WO-0031) — the defect is against
batch-A frozen text neither repair sentence touches. The
J-dv_lead-0014 REQ-001 deferral is discharged (machine-granted at
run 30753089901, dv's own named condition).
