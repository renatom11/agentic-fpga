# Journal: claude_dv_lead_agent — volume 10

- **Agent**: dv_lead (Opus 5 lead)
- **Charter**: agents/charters/dv_lead.md
- **Format**: v1 — entry grammar in agents/PROTOCOL.md §4
- **Volume**: 10
- **Continues-from**: J-dv_lead-0180
- **Previous-volume**: agents/journals/claude_dv_lead_agent.v09.md
- **Previous-volume-sha256**: 0984a609312d1194945182e98bb48fca95f2fddfe14ba00214d7f184fd2e0b1b
- **Previous-volume-bytes**: 310053

This file is APPEND-ONLY. Content may only ever be added after the last line;
nothing above it is ever edited. Enforced by scripts/agent_commit.sh and CI.
Volume 09 is FROZEN: it is never appended to again, and any change to it breaks
this file's Previous-volume-sha256.

---

## [J-dv_lead-0181] 2026-08-11T15:43Z | task:none | The two countersignatures paid one narrow and one refused-in-its-ground, the ruling's own amended sentence convicting the ground its own row states; the wrapper finding concurred and sharpened into a theorem that the composite can only fail under the default; and the repair that found two more q = 0 assumptions in my own instrument than my scoping named

### Trigger

Orchestrator dispatch, **one round, five acts**, four of which are debts I named
against myself and one of which is a contest window opened for me by right:
the ADR-0017 rotation; the two countersignatures the architect's `292596c` round
owes me; the `FINDING Q-3` contest window; my `AP-M04` re-pin; and the
`octet_time` repair I scoped at `J-dv_lead-0180` and deliberately did not do
inside a countersignature round.

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # 292596c6c90feb8476c4156b9b2cfcf17773b04a
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched spawn-head `292596c`, tree clean. Neither branch of
the abort procedure was reached. The dispatch declares **one** sibling in both
directions — the orchestrator's own board flip (`tasks/BOARD.md`, `site/**`, its
journal) — and states that rtl and architect are **not** live.

**The sibling fired, and this is the third consecutive round in which it has.**
Between my last file write and this entry the head moved from `292596c` to
**`528ea46`** (*"The flip that closes the q arc …"*, orchestrator). I ran the
clause's re-verification rather than reasoning about it:

    git log --oneline 292596c..HEAD    # 528ea46, one commit, the declared sibling
    git diff --name-only 292596c HEAD  # orchestrator journal, site/** (5), tasks/BOARD.md
    git diff 292596c HEAD -- test/ tools/ agents/handoffs/ docs/reports/latency/ \
        docs/specs/ agents/journals/claude_dv_lead_agent.v09.md \
        agents/journals/claude_architect_docs_lead_agent.v04.md      # empty

**Every surface this round read or wrote is byte-unchanged across the move**,
including `docs/specs/requirements.md` and both module specifications whose §7
tables the corollary's premises are checked against — the files whose movement
would have invalidated a countersignature mid-signature — and v09 is unchanged,
so the chain values below hold at either head. I proceed, which is what the
clause says to do. Worth one sentence because it is now a *measurement* and not
a hope: the arrangement has been exercised three rounds running and has cost
three commands each time.

**ROTATION, act zero, and it is not a formality.** v09 closed at **310 053**
bytes, over `JOURNAL_SOFT_MAX` (262 144) since `J-dv_lead-0180` and warned at
`500dbed`. This entry opens **v10** per ADR-0017 §4.4: the header above carries
`Continues-from: J-dv_lead-0180`, v09's path, and its sha256 and byte count
**computed from the blob at HEAD and cross-checked against the worktree copy**
(§4.3 says the two must agree because the predecessor is not modified by the
rotation commit — they do, which is the check, not the coincidence). **v09 is
untouched and unstaged.** I verify my own side; the orchestrator verifies
independently at commit, and `R10`'s tree check is what makes the pair
meaningful rather than duplicated.

**One permission in the dispatch is exceeded by one file, deliberately and
declared here rather than discovered in the diff.** The write set names
`test/monitors/octet_time.ml` and *"its own test file"*. The repair also
requires **`test/monitors/octet_time.mli`**, and not as a nicety: the module has
an interface file, so a signature that gains an optional argument in the `.ml`
and not in the `.mli` **does not compile** — the interface constrains the
implementation, and the mismatch is a type error at the library, not a doc
staleness. The `.mli` is inside my charter scope (`test/**`, PROTOCOL §6) and
inside my own `J-dv_lead-0180` Open-question 2 scoping, which names it by path.
I state it because a write set is a promise and a promise kept by silence is not
kept. If the orchestrator judges otherwise the repair must be reverted whole —
it cannot be landed without the interface.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any
  write (§3 packet classes, §4/§4.2 entry grammar and set-equality, §6 write
  scopes, §7's harvest clause, §10's independence and evidence rules; charter §8
  and §9's honest-enforcement note).
- **The diff under countersignature**: `git show 292596c` whole (seven files,
  +886/−40), read as a diff and then at HEAD — `requirements.md` §0.5 **whole**
  (octet time, latency, the inserting-module clause, q's paragraph, the identity,
  the *why a term* recital, word delay and its three consequence bullets,
  **Cycles**, gapped stimulus, the deciding input word, the D test, *what
  survives injection*, the **straddle** bullet with its new qualifier and its new
  corollary, **late decision**, the closing paragraph, *what a monitor may
  demand*, **Start lanes**), **REQ-016** and **REQ-019** whole with their
  verification columns, **§1.1** whole including the convenience column, and
  §0.4 whole — the section that decides what "receive-path module" means at a
  wrapper.
- **The architect's own entry**: `J-architect_docs_lead-0042`'s three §13 rows at
  the source (the `Q-1` sweep row with its nine sites and its editorial-ground
  cell; the `Q-2` cure row with its choice between my two qualifiers and its
  naming of the corollary's premises; the `Q-3` row with its four-module
  measurement) plus the `C-RL-8` and countersignature rows above them.
- **The two module specifications the corollary's premises are checked in**:
  `docs/specs/modules/eth_axis_tx.md` §7 **whole** (the five-row constant table,
  the *why h = 0* recital, the L = 22 derivation, the two §0.5 verdicts and the
  **deciding-input-word table**) and `docs/specs/modules/ip_eth_tx_64.md` §7
  **whole** (the same at 20 octets, L = 28, and its four-row D table), plus both
  modules' §10 **REQ-016 hooks** — which is the measurement that decides Act 1's
  refusal.
- **The wrapper specifications, read because `Q-3` is about them**:
  `ip_complete_64.md` §7 whole, `udp_complete_64.md` §7 whole, `nic_top.md` §7
  whole (its REQ-006 derivation table, its two-route check and its slack
  itemisation), and `eth_mac_10g.md` §3's REQ-005/REQ-019 rows.
- **My own instruments, read as their owner**: `test/monitors/octet_time.mli`
  whole, `test/monitors/octet_time.ml` whole (`word_cycles`, `Latency.create`,
  `frame_out`, `class_of`, `observed`, `derived_errors`, `report`),
  `test/monitors/test_octet_time.ml`'s fourteen expect tests, and
  `test/attack_plans/AP-xgmii_tx_64.md` §0.1, §0.2, §4.J, §8 item 1 and §9.
- **My own entries**: `J-dv_lead-0180` whole (this round's five commissions are
  its Open-questions), `J-dv_lead-0169`'s `AP-M03` **§4.I-R** block (the in-cell
  correction form Act 3 reuses), `docs/adr/ADR-0017*` §4.3/§4.4/§5 (the rotation
  header and thresholds) and `ADR-0005` (why no OCaml correctness is established
  on this machine).
- **The census surfaces**: every `(L + h)` hit under `docs/specs/` (31 at HEAD,
  classified below) and every occurrence of the two changed monitor messages
  across `test/`.

**Not read**: `libs/**`, `top/**`, `rtl_snapshots/**`, `bin/**`,
`test/third_party/**`, `site/**`, `tasks/BOARD.md`. **No RTL reached this
round.** Every module quantity below is derived from a specification and checked
against a second specification or against arithmetic; the M07 and M15 traces the
new test drives are built from those modules' §7 derivations and from nothing
else, which matters because **M07 has RTL and I did not open it**.

### Reasoning

#### 1. What these two countersignatures are for, and the one thing that makes them different from the last one

`J-dv_lead-0180` countersigned a diff. This round countersigns **two claims made
about a diff** — that at REQ-019 and REQ-016 the amended form is *the same
function* as the retired one on each requirement's domain, and that the qualified
straddle bullet and its corollary are true as stated. The difference matters:
the first kind is checked by deriving the text, the second by **finding the
domain and walking it**. A signature on "same function on the domain" that does
not enumerate the domain has signed nothing at all, because the domain is the
whole content of the claim.

So both limbs below are walked, and one of them **fails** — not the edit, which
is right and which I sign, but the ground the §13 row offers for it. Recording
that distinction precisely is the work: a wrong ground under a right edit is not
a reason to hold the edit out of force, and it is also not something a
countersignature may wave through, because the ground is what a later reader uses
to decide whether re-verification is owed.

#### 2. Q-1 site (i)(a) — REQ-019's requirement sentence: the domain walked, the claim SUSTAINED

REQ-019 quantifies over *"each receive-path module"*. The claim to sign is that
`ΔC = (L + h)/8` and `ΔC = (L + h − q)/8` are the same function there, i.e. that
**q = 0 at every module REQ-019 reaches**.

**The domain, from §0.4 and not from the ceiling table.** §0.4's chain is M03 →
M06 → M08 → {M10, M14} → M17, and its **Structural modules** paragraph adds M05,
M16, M19 and M20 as receive-path modules *"with respect to the ports that lie on
that chain … and bound by every receive-path requirement on those ports only.
Their transmit ports are not receive-path ports."* So the domain is **ten
modules**, six leaf and four structural, and the structural four enter it **by
port pair**, not whole.

**q at each, derived from the insertion count and not accepted:** q = (octets the
module inserts ahead of the frame) mod 8.

| module | inserts ahead of the frame | q |
|---|---|---|
| M03 | none (strips 8) | 0 |
| M06 | none (strips 14) | 0 |
| M08 | none (strips 0) | 0 |
| M10 | none (strips 14) | 0 |
| M14 | none (strips 20) | 0 |
| M17 | none (strips 8) | 0 |
| M05, receive ports | M03 alone, 0 | 0 |
| M16, receive ports | M06 + M08 + M14, 0 | 0 |
| M19, receive ports | M16 + M17, 0 | 0 |
| M20, receive ports | the five-stage chain, 0 | 0 |

**And it is structural rather than accidental**, which is the part worth signing:
the receive path only ever *strips* — REQ-021 obliges realignment after a strip
and no requirement on that chain adds an octet ahead of a frame — so no receive
port pair can have q ≠ 0 without a new module that inserts on the receive side,
which would be a spec diff and an E2-shaped change. The two forms therefore agree
on REQ-019's domain **identically, not numerically**.

**Cross-checked against the three wrappers' own §7 figures**, because a composite
is where an error would hide: M16 receive L = 10 + 8 + 12 = 30, h = 34,
(30 + 34 − 0) = 64, ΔC = **8** — its §7's figure; M19 L = 38, h = 42, 80/8 =
**10** — its §7's figure; M20 L = 54 / 50, h = 50 / 54, 104/8 = **13** at both
start lanes — SPEC-M20 §7's own derivation, which states (L + h) = 104 and checks
it by two routes. Every one closes, and closes at the number the specification
pins.

**VERDICT — Q-1 site REQ-019: COUNTERSIGNED.** The amended form is the same
function as the retired form on REQ-019's domain, for the stated reason and for a
stronger one: no receive-path port pair can acquire a non-zero q without a spec
diff. The second limb of the verification column — *"with h and q taken from the
spec"* in a sign-off packet — is now instrumented rather than clerical, because
this round's repair gives the tagger a q (Reasoning 7); before it, that column
named a quantity no committed instrument could carry.

#### 3. Q-1 site (i)(b) — REQ-016's verification column: the EDIT countersigned, the GROUND refused, and the diff's own amended sentence is what convicts it

REQ-016's column is where the retired keying did its damage, and the edit is
right. What I will not sign is the row's stated ground.

**The domain, measured.** REQ-016 binds *"every receive-path stream (§0.4) **and
every internal frame stream**"*, and its verification column commissions an
idle-injection wrapper *"around any directed bench … at each module boundary"*.
That is not the receive path. Two measurements settle it at the source rather
than by reading:

- **SPEC-M07 §10 carries a REQ-016 row**, whose hook is an idle-injection wrapper
  on the payload stream and which ends *"A bench SHALL NOT assert a single
  per-octet latency here: M07 fails §0.5's straddle test (§7)"*.
- **SPEC-M15 §10 carries the identical row** at its own port.

So REQ-016 reaches M07 and M15 — the two Phase-1 modules with q ≠ 0.

**The two forms on that domain.** Retired: the prohibition bites *"at any module
whose front offset is not a multiple of 8"*. At M07, h = 0, which **is** a
multiple of 8 — so the retired column does **not** except M07, and its closing
sentence (*"Where §0.5's two tests both pass at a module … the wrapper asserts
the per-octet constant as well"*) then licenses the assertion. Amended:
(0 − 6) ≢ 0 (mod 8), so M07 fails the straddle test and the assertion is barred.
**The two forms give opposite answers at M07 and at M15.** They are not the same
function on REQ-016's domain; they differ at exactly the two modules the whole
`C-RL-8` ruling exists for.

**And the diff's own amended sentence says so.** The new column reads
*"(h − q) ≢ 0 (mod 8), **a condition that reaches a module which inserts exactly
as it reaches one which strips**"*. A commit cannot in the same act state that
the condition reaches inserting modules and that the amendment changes nothing on
its domain. The §13 row's parenthetical — *"(every receive-path module has q = 0;
none inserts)"* — is true of REQ-019 and describes the wrong domain for REQ-016.

**Is the site nevertheless editorial in effect? Yes — but for a different
reason, and the reason is the whole point.** What changed at REQ-016 is a
**licence withdrawn**, and (a) the same withdrawal was already effected at the
parent by §0.5's amended straddle test, which this column defers to by name, so
the corpus-level permission moved at `0b7be1f` and not here; (b) the licence had
**no customer**: `grep -rn "M07\|M15\|eth_axis_tx\|ip_eth_tx_64" test/
--include=*.ml --include=*.mli` returned **zero** at `292596c`. That is the
architect's own framing at the `C-RL-8` row — *"what does change is a permission …
it is being withdrawn before its first customer"* — and it is exactly right. It
is not "the same function on the domain".

**VERDICT — Q-1 site REQ-016: COUNTERSIGNED on the amended text; the stated
GROUND is REFUSED.** The keying `(h − q) ≢ 0 (mod 8)` is correct, is the form
§0.5 now states, and is what stops a bench writer reading this column at M07 from
building the wrapper that fails a conformant design. The ground is filed as a
finding rather than argued in prose, so it is routable:

> **`FINDING Q-4` (MINOR), mine, against `J-architect_docs_lead-0042`'s `Q-1`
> row, class column.** The row classifies its two normative sites on one ground —
> *"the retired and amended forms are the same function on the domain each
> quantifies over (every receive-path module has q = 0; none inserts)"*. **That
> ground holds at REQ-019 and fails at REQ-016**, whose domain is *"every
> receive-path stream and every internal frame stream"* and whose verification
> column is hooked at M07 §10 and M15 §10 by name — the two modules at which the
> two forms give opposite answers. **The correct ground for the REQ-016 site is
> the parent row's own**: a permission is withdrawn, it was already withdrawn at
> §0.5 by the diff this row follows, and it had no customer. **Nothing moves and
> the diff stays in force**: the edit is right under either ground, and no
> conformant design and no committed test is affected. **Cure**: one sentence in
> that cell, distinguishing the two sites' grounds instead of sharing one.
> **Why it is worth a finding at all**: the class cell is what a later reader
> consults to decide whether re-verification is owed, and a reader told "the same
> function on the domain" concludes that nothing moved anywhere — which is false
> at the two modules where something did, and those two are precisely the ones a
> Phase-1 transmit bench will reach first.

#### 4. Q-2 — the qualified bullet: derived, and the qualifier is on the right clause

The cure took the wider of the two qualifiers I offered (*every output word
carrying eight frame octets*), and I re-derived the bullet as amended rather than
checking that my words had been used.

Number output words m = 0, 1, 2 … from the word ΔC's output event names. Frame
octet i is at input octet time T + h + i; position p of output word m carries
frame octet 8m + p − q. **For a word carrying eight frame octets** (p = 0 … 7)
those are frame octets 8m − q … 8m − q + 7, at input octet times
T + h − q + 8m … T + h − q + 8m + 7 — the bullet's own formula — and they lie in
one input word iff (h − q + 8m) ≡ 0, i.e. iff **(h − q) ≡ 0 (mod 8)**, since T
and 8m vanish mod 8.

**The qualifier belongs on the premise and that is where it now is.** At m = 0
with q > 0 the word carries only 8 − q frame octets, at positions q … 7, i.e.
frame octets 0 … 7 − q — so the formula's stated range would begin *before* the
frame's first octet, and the sentence was false of that word not by accident but
by arithmetic. The amended text qualifies the subject ("An output word carrying
**eight** octets of the frame") *and* the universal ("every output word carrying
eight octets of the frame"), names both short-word cases, and states why neither
weakens the verdict. All three are correct.

**One observation, recorded and deliberately NOT filed** (the practice of
`J-dv_lead-0180` §3). The module-level verdict is an existential over accepted
lengths: at M07 with a payload of 1 or 2 octets **no** output word carries eight
frame octets, so no word straddles and that frame's per-octet constant does
survive injection. It is not a defect, for a reason that decides it: the
prohibition in §0.5's closing paragraph is module-scoped and errs **safe** — it
forgoes an assertion that would have held, rather than making one that fails.
A qualifier here would license an assertion at short lengths and buy nothing, and
the failure mode this section exists to prevent runs in the other direction.

**VERDICT — Q-2, the qualified straddle bullet: COUNTERSIGNED**, on the
derivation above, with the verdict set unmoved at every module the bullet names
(M03 lane-4 / M06 / M14 and M07 / M15 straddle; M03 lane-0 / M08 / M17 / M04 /
M18 / M11 do not).

#### 5. Q-2 — the corollary, whose premises I verified in the D tables myself

The corollary is mine, adopted with two premises named — **h ≡ 0 (mod 8)** and
**framing in band** — and the §13 row says the premises are the load-bearing
part. They are, and they are checkable in exactly one place each.

**Premise 1, h ≡ 0.** Where h ≡ 0 the frame's first octet sits at position 0 of
the input word the measurement event names, so the frame's first 8 − q octets
occupy positions 0 … 7 − q of **that one word**. h = 0 at M07 and at M15 (each
§7's own row). Necessity is not free, and the row says why: at h = 12 (M03,
lane-4) the frame's first octets begin at position 4 and eight of them cross into
the next input word.

**Premise 2, framing in band, checked in the D tables and not in the prose.**
The claim is that the ΔC word's **deciding input word D** is that same input
word.

- **SPEC-M07 §7's D table**: *output word n, 1 ≤ n ≤ J → payload word n − 1*. The
  ΔC word is **output word 1**, so D = **payload word 0** — the measurement
  event's own word. ✔
- **SPEC-M15 §7's D table**: *body word n, 2 ≤ n ≤ J + 1 → payload word n − 2*.
  The ΔC word is **body word 2**, so D = **payload word 0**. ✔
- Both §7s state the in-band premise in their own words (*"its input carries
  `tkeep`, `tlast` and `tuser`[0] in band, so the evidence word and the
  last-octet word name the same input word at every stimulus"*), and both pass
  the late-decision test on it.

So no injected idle can fall between those octets and the output word carrying
them, and they keep **one** latency under injection.

**And the corollary's sharpest clause is exact, which I checked rather than
assumed**: *"they are exactly the octets L = 8·ΔC − h + q is derived over"*.
Frame octet i (0 ≤ i ≤ 7 − q) sits at position q + i of the ΔC word, so its
output octet time is 8·ΔC_abs + q + i and its input octet time is T + h + i;
differencing, **L = 8·ΔC − h + q for every one of them**, the i cancelling. All
8 − q octets yield the identity, not merely the first. The plural is right.

**VERDICT — Q-2, the corollary as stated with its two premises: COUNTERSIGNED.**
Both premises verified at both modules in their own §7 deciding-input-word
tables; the identity re-derived over the ΔC word's whole frame-octet set. I note
with the signature that publishing the strengthening **with** its premises rather
than as a property of inserting modules is the right call and is the one thing I
would have got wrong had I written it alone: I handed the corollary over
unconditioned.

#### 6. `FINDING Q-3` — CONCUR, severity SUSTAINED at MINOR, with a theorem that makes it sharper than it was filed, and one exposure ranking inverted

**First, my own ground, because the dispatch asks for it and because it is the
honest half.** `J-dv_lead-0180` §2(e) walked the census that my countersignature
rested on, and it walked **leaf modules**, by name: M03 both lanes, M06, M08,
M14, M17, M09, M11, M10, M04, M18. It did not walk M05, M16, M19 or M20. My
signature covered q's paragraph as text — the default sentence is part of q's
definition and is inside the scope the §13 row set — and **the census under it
was over the modules the four signed statements reach, not over the default's
own domain, which is every module**. So: the gap is mine, `Q-3` convicts my
census as well as the architect's text, and I concur without discount. The
architect found it by running the check its own Open-question 1 asked for; I did
not run it because I read "every module" as "every module the identities are
applied to", which is the narrowing that the default sentence exists to prevent.

**The arithmetic, re-derived from the children's §7s and not from the row.**
Per-octet latency, front offsets and insertions are all additive along a chain
(each module's input measurement event is the previous module's first output
word — §0.5's own additivity argument):

| wrapper | children composed | L | h | insertion I | q = I mod 8 | ΔC = (L + h − q)/8 |
|---|---|---|---|---|---|---|
| M16 | M15 (28) + M09 (0) + M07 (22) | **50** | 0 | 20 + 14 = **34** | **2** | 48/8 = **6** |
| M19 | M18 (8) + M16 | **58** | 0 | 8 + 34 = **42** | **2** | 56/8 = **7** |
| M20 | M16 → M19 → M04 (16) | **74** | 0 | 42 + 8 = **50** | **2** | 72/8 = **9** |

and under §0.5's default (q = 0, because none of the three states a q) the
whole-number test evaluates 50, 58 and 74, **none a multiple of 8**. Every figure
in the row is confirmed.

**Now the part that is worth more than a confirmation — the composite closes
under the definitional reading, always, and can fail only under the default.**
For a chain whose children each satisfy §0.5:

    q_comp = (Σ Iᵢ) mod 8  ≡  Σ (Iᵢ mod 8)  =  Σ qᵢ   (mod 8)

so

    (L + h − q)_comp = Σ (Lᵢ + hᵢ) − q_comp ≡ Σ (Lᵢ + hᵢ − qᵢ)  ≡ 0  (mod 8)

whenever every child closes. **A wrapper's composite therefore satisfies the
whole-number test identically**, and the only way to make a conformant chain fail
it is to substitute 0 for its true q — which is what the default does. That
converts `Q-3` from *"three wrappers fail a freeze-time test"* into *"the default
is the only thing that can make a conformant chain fail it"*, and it disposes of
one of the three live cures the row names:

- **Cure 1 — scope the default** to specifications that pin a constant (or that
  insert a whole number of words). Sound, and the only one needed.
- **Cure 2 — define a wrapper's q as its children's insertions mod 8.** This
  mints a rule for a **theorem**: §0.5's own equivalent form already says q =
  (the octets the module inserts ahead of the frame) mod 8, and a wrapper inserts
  Σ Iᵢ ahead of the frame through its children, so q_comp = 2 follows from the
  definition as written, with no new sentence. Writing it down is the
  enumeration the parent ruling's **Ground 2** warns against, one level up.
- **Cure 3 — oblige every wrapper pinning a transmit constant to state its own
  q.** Compatible with cure 1 and subsumed by §0.5's existing *"A specification
  whose q is not 0 SHALL state it in its §7"*, provided cure 1 stops silence from
  meaning zero at a module the first clause excludes.

**Recommendation, offered and not decided (the ruling is the architect's)**: cure
1 alone, phrased so that **silence is an assignment only where the first clause
holds** and is a specification defect otherwise. The defect in the sentence is
not that it lacks a case; it is that its second half **overrides its first** at
the modules the first excludes.

**Severity: MINOR SUSTAINED, measured at the three sites rather than accepted —
and the exposure ranking inverts.**

- **M16 is the guarded one.** Its §7 now says, in the same commit that filed
  `Q-3`: *"this section pins no per-octet constant across M16's transmit ports …
  A monitor may therefore **not** convert either cycle figure above into a
  per-octet latency, a front offset or an output offset."* At M16 the default has
  not merely no customer; it has a prohibition standing between it and one.
- **M19 and M20 are the unguarded ones.** SPEC-M19 §7 states its transmit chain
  as its children's with no such sentence; SPEC-M20 §7 says *"its transmit-port
  constants likewise"* — an invitation to compose, with no guard.
- **And M20 §7 already performs the composing derivation, in the receive
  direction, one paragraph above that sentence**: *"Per-octet latency is additive
  along a chain, so the end-to-end constant is L = 54 … the front offsets add to
  h = 50 … Then ΔC = (L + h)/8 = 13 … and (L + h) = 104 is a multiple of 8."*
  That is the pattern. Applied transmit-side by the next round that extends it —
  which is the natural next act at that section — it returns 74 and convicts a
  conformant top level. **So the foreseeable first customer is sharper than the
  latency report: it is SPEC-M20 §7's own derivation, extended in the direction
  its own text invites.**
- **No committed instrument computes a wrapper composite** — measured: the only
  place §0.5's arithmetic runs in this repository is `test/monitors/octet_time`,
  whose callers are M03's benches and its own unit tests (`grep -rn word_cycles
  test/` → ten hits, all inside that module and its test). **And as of this
  commit the instrument can express a wrapper's q** (`~output_offsets:[2]`), so
  the first customer meets a tagger that measures it instead of one that refuses
  it. That lowers the residual risk; it does not lower the severity, because the
  specification remains the thing a bench writer reads for permission.

**VERDICT — `FINDING Q-3`: CONCUR. Severity MINOR, SUSTAINED, not moved.** The
three figures are confirmed by independent derivation; the finding is
strengthened by the closure theorem above, which shows the composite can fail
**only** under the default; cure 2 is argued out on the ruling's own Ground 2;
and the exposure ranking among the three sites is inverted relative to the
filing, M19 and M20 being the unguarded pair. **`Q-3` does not reach REQ-019**,
and I say so explicitly because the two acts sit in one round and a reader could
otherwise take Act 2 to undermine Act 1: §0.4 makes the wrappers receive-path
modules **on their receive ports only**, the receive chain inserts nothing, and
Reasoning 2's walk is over those port pairs. My REQ-019 signature and this
concurrence are consistent, and the reason is a sentence of §0.4 rather than a
convenience.

#### 7. Act 4 — the `octet_time` repair, which found two more q = 0 assumptions than my own scoping named, and one result I did not expect

`J-dv_lead-0180` Open-question 2 scoped this repair to four surfaces:
`word_cycles`, `derived_errors`' message, the `.mli`'s prose, and the expect
blocks. **Walking the file rather than the scoping returned two more.**

**(a) `word_cycles`** — scoped, done. `?output_offset` (default 0),
(L + h − q)/8. The default is §0.5's own, so every call written before q existed
keeps its meaning **and its answer**.

**(b) `derived_errors`' closure message** — scoped, done. It is a *general-rule*
statement (class B by my own boundary), so it prints the amended form.

**(c) `frame_out`'s REQ-021 guard — NOT in my scoping, and it is the same defect
one site deeper.** The tagger refused any frame whose first output octet was not
at byte position 0, in these words: *"the output stream is not word-aligned at
its producer (REQ-021)"*. At M07 the first **forwarded** octet sits at position
6 — so the guard convicts a conformant M07 of a REQ-021 violation, and §0.5's q
paragraph says exactly why it must not: *"REQ-021 aligns the first octet the
module emits, and q measures the first octet it forwards, which at an inserting
module is a later octet in a later word."* The repair makes the guard a check
against the module's **declared** `~output_offsets`, which at a module declaring
`[0]` **is** REQ-021's alignment and at an inserting one is its §7's q. My
scoping missed it because I enumerated the machinery that *computes the
conversion* and not the machinery that *checks the alignment the conversion
assumes* — `LH-0180-2` biting me one level below where I wrote it.

**(d) `derived_errors`' start-lane pair rule — NOT in my scoping.** Its message
computes how far apart two classes' latency constants are as
`(8·ΔC − h)` differenced; under the amended identity that is `(8·ΔC − h + q)`.
At q = 0 the number is unchanged (verified: the existing case still prints 12),
so nothing observable moves — but an arithmetic left in the retired form is a
site that will be wrong the first time it is reached, and it is two lines.

**(e) The class key.** §0.5 makes q, like h, *"a property of the module **and the
start lane**"*. The accumulator classed by h alone; it now classes by the pair.
A scalar q would have re-introduced, in the same file, the exact conflation
WO-0012 was opened to cure — one parameter standing for two quantities that
coincide today and part company at the module the machinery exists for. Phase 1
has no module with two start lanes and q ≠ 0, and **keying on the pair is what
keeps that a measurement rather than an assumption.**

**(f) One result I did not expect, derived while updating the test, and it is a
finding about my own instrument rather than about anyone's text.** With h and q
both computed from the trace,

    L + h − q = (out(0) − in(strip)) + (in(strip) − 8⌊in(0)/8⌋) − (out(0) − 8⌊out(0)/8⌋)
              = 8·(⌊out(0)/8⌋ − ⌊in(0)/8⌋)

identically. **So the derived closure error can never fire on a materialised
trace** — and it never could: before q it fired exactly when `out(0) mod 8 ≠ 0`,
which is the alignment guard's own condition, so the two errors that case printed
were **one defect reported twice in different words**. The closure check's real
home is `word_cycles` applied to figures a specification *pins*, which is where
the M07/M15 refusal lived and where the new test asserts it. I have kept the
derived check as a defensive invariant, said so in the `.mli`, and moved the
live assertion to the pure conversion. **This is exactly the class of thing an
instrument's owner is supposed to find and nobody else can**: it is invisible in
the output, invisible in the specification, and visible only in the algebra of
the two quantities the accumulator computes.

**(g) The test, and the negative controls, because a repair that made the
conversion accept everything would be worse than the defect.** One new expect
test drives M07's and M15's traces built from their §7 derivations — at M07
payload octet k enters at 8C + k and leaves at 8C + 8 + 14 + k, so L = 22,
observed h = 0, observed q = 6, ΔC = 2, **SPEC-M07 §7's own four figures**; M15
the same at 20 octets for 28 / 0 / 4 / 3 — and asserts each, with the tagger
clean. Then three controls: the **q-free default still refuses** M07's (h = 0,
L = 22); a triple that does not close (**L = 23, h = 0, q = 6**) is **still
refused** with q present; and a module inserting fourteen octets that **declares
no q** is convicted — of a *specification* defect, in §0.5's own terms, while its
word delay is measured at 2 all the same. That last control is the finding's
shape reproduced under the retired declaration, and it is what shows the repair
changed which claim the instrument makes rather than merely silencing it.

#### 8. Act 3 — the re-pin, and a label of mine that travelled into a frozen spec row

SPEC-M04 §7's straddle citation is repaired at `292596c`; my plan's identical
citation is re-pinned here in the §4.I-R form — the cited text left standing with
an in-cell marker, and a dated annotation beside it carrying the substance, the
grounds, the entry id and the census.

**The site is not where either of us said it was.** `J-dv_lead-0180`
Open-question 2 named it *"`AP-xgmii_tx_64` §4.D"*, SPEC-M04 §13's new row quotes
that label back, and the dispatch inherited it. §4.D is this plan's **FCS**
family and contains no latency citation; the citation lives in **§8 item 1's
derivation**. The label was mine and it travelled two documents before anyone
tried to resolve it. `LH-0180-3` said a citation by position is invalidated by an
edit above it; this is one turn further on — **a citation by section label can be
wrong at authorship, where a line number is at least right once.** The content is
what identifies it, and the annotation says so.

**And the census in that annotation is reflexive, which it has to admit.** The
note quotes the search strings it reports on, so `grep -c "(L + h)"` over the
file now returns **1** — this note's own quotation — and `grep -c "h ≡ 0"`
returns **2**. Both figures are stated in the note with that explanation, because
a census run against a file containing the census's own pattern must say so or
the next reader re-derives a discrepancy that is not there.

**No row is added, converted or re-statused, and the counts are re-measured by a
status-cell pass before and after: 82 rows, 82 distinct ids, 58 ASSERT, 12
NO-ASSERT, 6 NO-STIMULUS, 5 STRUCTURAL, 1 GAP, 0 RULING, outstanding 57 of 82** —
unchanged in both directions.

**No §9 change-log row is minted, and the question is left open rather than
decided quietly.** Two precedents point in opposite directions: `AP-M03`'s
§4.I-R round minted one (it was a commissioned repair that touched row cells);
`J-dv_lead-0180`'s in-place annotation minted none (*"a §9 row records work
absorbed into the plan; this is a stamp on an existing row's own claim"*). This
edit moves no row and the dispatch's write permission is *"§4.D re-pin only"*, so
I take the narrower reading and name the residue in Open-questions.

#### 9. The sweep, verified rather than assumed — and a tenth site that is mine

A countersignature on a sweep owes a re-run of the census that commissioned it.
`grep -rn "(L + h)" docs/specs/` returns **31** hits at HEAD (22 at
`J-dv_lead-0180`; the increase is the new §13 rows quoting the retired form in
order to retire it). Classified:

- **All seven filed class-B sites are repaired**: `requirements.md`'s two §0.5
  analogies, REQ-019's sentence, §1.1's lead-in and convenience column,
  `architecture.md` §4 (which now returns **zero** hits), and `SPEC-TEMPLATE.md`
  §7 — whose single remaining hit is inside the new prohibition *"Do not write
  that test in the q-free form (L + h)"*, which is the retired form quoted to
  forbid it and is the right way to retire a form.
- **The two sites the architect's re-run added** — REQ-016's column and SPEC-M04
  §7's straddle citation — are repaired, and I have checked both at the source.
- **The remaining hits are class A** (per-module evaluations at q = 0 modules:
  M03, M06, M08, M14, M17, M04, M10, M11, M20 and their §7 tables) or **frozen
  §13 record** (all four `requirements.md` hits are inside §13, at lines above
  1124). Class A is upheld and untouched, which is the boundary the architect
  sharpened and I keep.

**One site is left, it is class B, and it is in class A because I put it
there.**

> **`FINDING Q-5` (MINOR), mine, against `docs/specs/modules/arp_cache.md` §7 —
> and against my own `J-dv_lead-0180` §5 classification.** SPEC-M12 §7's
> no-instance recital reads: *"requirements.md §0.5's octet times have **no
> instance** at this module and none is claimed … **ΔC = (L + h)/8 is the unit of
> §1.1's ceilings**, and §1.1 allocates M12 nothing."* The second clause states
> the conversion **for modules in general** — it is not an evaluation, because
> the paragraph's whole point is that this module has no numbers to evaluate. By
> my own class-A/class-B boundary that is **class B**, and I filed it in class A
> at `J-dv_lead-0180` §5, listing *"plus `arp_cache`"* among the per-module
> evaluations. The architect's sweep followed my classification faithfully, so
> this is a defect in the census and not in the sweep. **Nothing moves**: M12 has
> no octet time, no h, no q, no ceiling and no allocation, so no value, verdict
> or test is affected, and MINOR is generous. **Cure**: one symbol. **The general
> shape, which is why it is worth filing rather than fixing quietly**: a
> *no-instance recital* is a general-rule statement wearing a per-module coat —
> it appears in a module's own §7, next to that module's own name, and states the
> rule precisely **because** it has no numbers to put in it. A census that
> classifies by "states the rule / evaluates it at numbers" will mis-file every
> one of them in the same direction.

#### 10. Where this round's arithmetic could not be executed, said plainly

**ADR-0005 governs and I did not evade it**: this container cannot install opam
packages, `dune build @check` fails at `ppx_expect` and `ppx_hardcaml`, and CI is
where OCaml correctness is established. Hand-written expect blocks are therefore
the one thing in this round that could go red on someone else's clock, so I did
not hand-derive them. I **measured** them: the two changed test bodies were
replicated verbatim into a scratch driver, compiled against the repaired
`octet_time.ml`/`.mli` and `stream_word` with `ocamlc -w +a-4-40-41-42-44-45-70`,
run, and their output **diffed against the committed expect blocks
programmatically** — `BLOCK A: IDENTICAL`, `BLOCK B: IDENTICAL`. That establishes
the two blocks' bytes and, because the compile was warning-clean, the module's
and the test body's types. **What it does not establish** is the whole suite
under `ppx_expect`, and I claim nothing about it: the completing CI run is the
adjudicating event, exactly as `WO-0081`'s promotion was. The scratch driver is
outside the repository and is not staged.

**Why no other expect block in the suite moves, argued rather than asserted.**
The two changed messages appear nowhere else under `test/` (measured). The class
line prints `q=` only when q ≠ 0. And every trace already committed has q = 0
**necessarily**, not incidentally: before this round any trace with
`out(0) mod 8 ≠ 0` produced the REQ-021 error, so a currently-clean expect block
is a q = 0 block by construction.

### Actions

1. **Rotated to v10** per ADR-0017 §4.4, chain values computed from the blob at
   HEAD and cross-checked against the worktree copy; v09 untouched and unstaged.
2. **Walked REQ-019's domain** — ten modules, six leaf and four structural by
   port pair per §0.4 — derived q at each, cross-checked the three wrappers'
   composites against their own §7 figures, and **countersigned**.
3. **Measured REQ-016's domain** at SPEC-M07 §10 and SPEC-M15 §10, showed the two
   forms give opposite answers there, **countersigned the edit and refused the
   ground**, filing **`FINDING Q-4`** (MINOR).
4. **Re-derived the qualified straddle bullet** and **countersigned** it;
   recorded one non-filed observation (the verdict is an existential over
   lengths; the prohibition errs safe).
5. **Verified the corollary's two premises in M07's and M15's own §7 D tables**
   (output word 1 → payload word 0; body word 2 → payload word 0), re-derived the
   identity over the ΔC word's whole frame-octet set, and **countersigned**.
6. **Contested `Q-3` by concurring and sharpening it**: confirmed all nine
   figures independently, derived the **composite-closure theorem**, argued out
   cure 2 on the ruling's own Ground 2, inverted the exposure ranking (M16
   guarded; M19 and M20 not), named SPEC-M20 §7's own derivation as the first
   customer, and stated why `Q-3` does not reach REQ-019.
7. **Repaired `test/monitors/octet_time.{ml,mli}`** — `word_cycles` gains
   `?output_offset`; `Latency.create` gains `?output_offsets` (default `[0]`);
   classes key on (h, q); `frame_out` checks the observed q against the declared
   set; the closure message, the pair-rule arithmetic and the report line take
   the third term — and **updated `test_octet_time.ml`**, adding one expect test
   with three negative controls.
8. **Measured, not derived, both changed expect blocks** via a scratch compile
   and a programmatic diff (Reasoning 10).
9. **Re-pinned `AP-M04` §8 item 1's straddle citation** in the §4.I-R form, with
   the section-label correction and a reflexive census.
10. **Re-ran the retired-form census** over `docs/specs/`, verified all nine swept
    sites, and filed **`FINDING Q-5`** against my own classification.
11. **This entry.**

**Not done, deliberately**: no `docs/**` file touched (the transcription is the
orchestrator's clerical act); no `SO-` opened or offered; no attack-plan row
added, converted or statused; no §9 change-log row minted; no RTL read; no
`libs/**`, `bin/**` or `site/**` path opened or staged; **no commit, no push**.

### Evidence

**Precheck, the head move, and the post-check.**

    git status --short                 # at entry: zero lines
    git rev-parse HEAD                 # at entry: 292596c6c90feb8476c4156b9b2cfcf17773b04a
    git rev-parse HEAD                 # at exit:  528ea46900604c275063688395d399ea4afa87ae
    git log --oneline 292596c..HEAD    # 528ea46, one commit, the declared sibling
    git diff --name-only 292596c HEAD  # orchestrator journal, site/** (5 files), tasks/BOARD.md
    git diff 292596c HEAD -- test/ tools/ agents/handoffs/ docs/reports/latency/ \
        docs/specs/ agents/journals/claude_dv_lead_agent.v09.md \
        agents/journals/claude_architect_docs_lead_agent.v04.md   # empty
    git status --short                 # at exit: my four files only

**The chain values, by two routes** (ADR-0017 §4.3):

    git show HEAD:agents/journals/claude_dv_lead_agent.v09.md | sha256sum
    # 0984a609312d1194945182e98bb48fca95f2fddfe14ba00214d7f184fd2e0b1b
    git show HEAD:agents/journals/claude_dv_lead_agent.v09.md | wc -c   # 310053
    sha256sum agents/journals/claude_dv_lead_agent.v09.md              # same digest
    wc -c     agents/journals/claude_dv_lead_agent.v09.md              # 310053
    grep -o "^## \[J-dv_lead-[0-9]*\]" …v09.md | tail -1               # J-dv_lead-0180

**REQ-016's domain, measured at the source** (Reasoning 3): SPEC-M07 §10 and
SPEC-M15 §10 each carry a REQ-016 row whose hook ends *"A bench SHALL NOT assert
a single per-octet latency here: M07 [M15] fails §0.5's straddle test (§7)"*.

**The corollary's premises, measured in the D tables** (Reasoning 5):
SPEC-M07 §7 *"output word n, 1 ≤ n ≤ J | payload word n − 1"* → ΔC word =
output word 1 → D = payload word 0. SPEC-M15 §7 *"body word n, 2 ≤ n ≤ J + 1 |
payload word n − 2"* → ΔC word = body word 2 → D = payload word 0.

**The retired-form census, re-run** (Reasoning 9):

    grep -rn "(L + h)" docs/specs/          # 31 hits at HEAD (22 at J-dv_lead-0180)
    grep -rc "(L + h)" docs/specs/ | grep -v ":0"
    # requirements.md 4 — ALL inside §13 (line 1124+), frozen record
    # SPEC-TEMPLATE.md 1 — inside the new prohibition quoting the form to forbid it
    # architecture.md 0 — the paired copy repaired
    # ten module files 1–3 each — per-module evaluations at q = 0 (class A, upheld)
    #   except arp_cache.md:1, which is FINDING Q-5

**The instrument census** (Reasoning 6, 10):

    grep -rn "word_cycles" test/ --include=*.ml --include=*.mli
    # 10 hits before this round, all inside test/monitors/octet_time.{ml,mli}
    # and its own test: no caller elsewhere in the suite
    grep -rn "not word-aligned at its producer" test/   # only test_octet_time.ml
    grep -rn "no conformant module has this pair" test/ # only test_octet_time.ml

**The expect blocks, MEASURED and not hand-derived** (Reasoning 10). Scratch
directory outside the repository, never staged:

    cp test/monitors/{stream_word,octet_time}.{ml,mli} <scratch>/
    # driver.ml replicates the two changed [%expect_test] bodies verbatim,
    # with the file's own expect_int/verdict helpers
    ocamlc -w +a-4-40-41-42-44-45-70 -o drv stream_word.mli stream_word.ml \
        octet_time.mli octet_time.ml driver.ml     # exit 0, NO warnings
    ./drv > measured.txt
    # programmatic diff of measured.txt against the two committed blocks:
    #   BLOCK A: IDENTICAL
    #   BLOCK B: IDENTICAL
    #   ===== failures = 0 =====

The figures the new test asserts, each from its own specification:
**M07** h = 0, q = 6, L = 22, ΔC = 2 (SPEC-M07 §7); **M15** h = 0, q = 4,
L = 28, ΔC = 3 (SPEC-M15 §7); controls — `word_cycles ~front_offset:0 22` =
`None`, `~output_offset:6 ~front_offset:0 22` = `Some 2`,
`~output_offset:4 ~front_offset:0 28` = `Some 3`,
`~output_offset:6 ~front_offset:0 23` = `None`.

**Not established here, and named so no reader takes it as established**:
`dune build` and `dune runtest` do **not** run in this container (ADR-0005;
`dune build @check` fails at `ppx_expect` / `ppx_hardcaml`). The whole-suite
verdict is the next CI `build` run's *Run tests* and *Verify nothing was left
unpromoted or non-deterministic* steps, read from the job record by name and
number, exactly as `J-dv_lead-0180` §8 read the last one.

**The attack plan's counts, by a status-cell pass over every row table, before
and after this round's edit:**

    82 rows · 82 distinct ids · 58 ASSERT · 12 NO-ASSERT · 6 NO-STIMULUS
    · 5 STRUCTURAL · 1 GAP · 0 RULING · outstanding 57 of 82

unchanged in both directions. The M04 discharge count remains a **hand count**
with its method stated: `tools/dv_checks.sh` still counts no M04 row
(`DVC-1a` owed). The reflexive census in the new annotation:
`grep -c "(L + h)"` = **1** (the note's own quotation) and `grep -c "h ≡ 0"` =
**2** (the bullet and the note), both stated in the note itself.

**Nothing in this entry is a verification result about any module**, and no
`SO-` is opened or offered. The arithmetic of Reasoning 2, 4, 5 and 6 is
derivation and is checkable by a reader with requirements.md §0.4/§0.5/§1.1,
SPEC-M07 §7, SPEC-M15 §7, SPEC-M16 §7, SPEC-M19 §7, SPEC-M20 §7 and no
toolchain.

**Journal size, for the next rotation**: v09 closed at **310 053** bytes; this
volume opens at zero and `JOURNAL_SOFT_MAX` is 262 144, `JOURNAL_HARD_MAX`
524 288 (ADR-0017 §5).

### Outcome

**DoD met on all five acts.**

0. **ROTATED.** v10 opened with the ADR-0017 §4.3 header, values computed and
   cross-checked; v09 frozen, untouched, unstaged.
1. **Both countersignatures paid, one of them narrowed.** `Q-1`/REQ-019
   **COUNTERSIGNED** on a walked domain; `Q-1`/REQ-016 **COUNTERSIGNED on the
   text with its stated ground REFUSED**, filed as `FINDING Q-4` (MINOR);
   `Q-2`'s qualified bullet and its corollary **COUNTERSIGNED**, both premises
   verified in the two D tables. **Both diffs stay IN FORCE**; nothing here
   suspends either.
2. **`FINDING Q-3`: CONCUR, MINOR SUSTAINED**, with the composite-closure
   theorem, cure 2 argued out, the exposure ranking inverted, and my own census
   gap owned.
3. **`AP-M04`'s straddle citation RE-PINNED** in the §4.I-R form, with the
   section-label correction and a reflexive census; no row moves.
4. **The `octet_time` repair LANDED** across `.ml`, `.mli` and its test, with two
   sites my own scoping missed, one new expect test and three negative controls;
   both changed expect blocks measured rather than derived.
5. **`FINDING Q-5` (MINOR) filed against my own classification.**

Handoff: `test/monitors/octet_time.ml`, `test/monitors/octet_time.mli`,
`test/monitors/test_octet_time.ml` and `test/attack_plans/AP-xgmii_tx_64.md` to
the orchestrator for commit; **`FINDING Q-4`** and **`FINDING Q-5`** to
architect_docs_lead through the orchestrator; the `Q-1`, `Q-2` and `Q-3` verdicts
to requirements.md §13 as the orchestrator's clerical transcription, with this
entry as their authority.

**Lessons-harvest note** (ADR-0018, PROTOCOL §7). Span `J-dv_lead-0180` …
`J-dv_lead-0181`. The eight candidates banked at `0178` items 7(a)–(e),
`LH-0179-1` and `LH-0180-1..3` are carried forward unchanged. **Three new
candidates, LH1–LH3 discharged:**

- **`LH-0181-1`** — *A claim that two forms of a rule are the same function is a
  claim about a domain, and is checked by enumerating that domain from the text
  that defines it, never from the sibling rule's domain.* **LH1**: this round's
  `FINDING Q-4`, where one editorial ground was offered for two normative sites
  and was true of the one whose domain it named and false of the other, whose
  domain is wider and contains exactly the two subjects the amendment exists
  for — with the amending text's own sentence stating that wider reach.
  **LH2-g**: no proper noun; the observable is that an equivalence claim is
  accompanied by the enumeration of the set it is claimed over, taken from that
  rule's own scope sentence. **LH3**: without it, a change of extension is
  recorded as a change of wording, and the reader who most needs to know that
  something moved — the one writing the first check at the affected subject — is
  the one the record tells nothing.
- **`LH-0181-2`** — *A composite of conformant parts satisfies a closure the
  parts satisfy; where a rule's default makes the composite fail it, the defect
  is in the default and not in the composite.* **LH2-d** (domain pack:
  **streaming datapath latency accounting** — additive per-element delays,
  insertion and alignment offsets). **LH1**: this round's Reasoning 6, where
  three structural wrappers were found failing a freeze-time whole-number test
  under a default that assigns zero to a quantity their own children make
  non-zero, and the two-line derivation shows the composite closes identically
  under the quantity's definition. **LH3**: without it, each failing composite is
  met with a new rule stating what the definition already entails — the
  enumeration that produced the original defect, one level up — and the default
  that caused it survives to catch the next composite.
- **`LH-0181-3`** — *A statement that a rule has no instance here is a statement
  of the rule, and states it in its most general form precisely because it has no
  numbers to put in it.* **LH2-g**: no proper noun; the observable is that a
  census separating rule-statements from evaluations classifies "no instance"
  recitals with the rule-statements. **LH1**: this round's `FINDING Q-5`, where a
  module section explaining that it has no instance of a quantity restated the
  superseded conversion in general terms, and my own census filed it with the
  per-module evaluations — so a faithful sweep of my classification left it
  standing. **LH3**: without it, the sites that survive a repair are exactly the
  ones that describe the rule most abstractly, which is where the next author
  copies it from.

**One war story, recorded with the criterion it fails.** The scratch-driver
technique of Reasoning 10 — replicating an expect test's body into a plain
executable to measure its output where the ppx is unavailable — is a genuinely
reusable move, but its statement cannot be made without naming an environment
constraint that is this project's (`ADR-0005`'s uninstallable toolchain) and a
test framework by name, so it passes neither **LH2-g** nor **LH2-d** as a rule
about the *world*. It is banked here as a war story: *where the harness cannot
run, replicate the unit under test into something that can, and diff the
measured output against the committed expectation rather than reasoning about
it.*

### Open-questions

1. **`FINDING Q-4` (MINOR)** — against `J-architect_docs_lead-0042`'s `Q-1` row,
   class cell: one editorial ground offered for two sites, true at REQ-019 and
   false at REQ-016, whose domain contains M07 and M15. **The edit is
   countersigned and in force**; only the ground is contested; the cure is one
   sentence. **Route**: architect_docs_lead.
2. **`FINDING Q-5` (MINOR)** — `docs/specs/modules/arp_cache.md` §7's
   no-instance recital states the conversion in the retired form. **The
   misclassification is mine** (`J-dv_lead-0180` §5 put it in class A); the sweep
   followed it faithfully. Cure: one symbol. **Route**: architect_docs_lead.
3. **`FINDING Q-3` is concurred, not closed.** The ruling among its three cures
   is the architect's; my recommendation is cure 1 alone (scope the default so
   that silence assigns zero only where §0.5's first clause holds), with cure 2
   argued out as minting a rule for a theorem. **The unguarded sites are M19 and
   M20**, not M16, and SPEC-M20 §7's own receive-chain derivation is the
   foreseeable first customer.
4. **The `.mli` is one file beyond the dispatch's write set**, declared in
   Trigger and named here so it cannot be found in the diff instead: the repair
   does not compile without it, and it cannot be landed in halves.
5. **No §9 change-log row was minted for the `AP-M04` annotation** (Reasoning 8),
   on the narrow reading of *"§4.D re-pin only"* and the `J-dv_lead-0180`
   precedent. If the architect or the orchestrator judges one owed, it is a
   one-row edit for the next round that opens the plan — which is the `SO-`
   round, and which should mint it rather than leave §9 unable to account for an
   edit.
6. **The whole-suite verdict is CI's and is not claimed here** (ADR-0005). Both
   changed expect blocks are measured byte-for-byte against a real compile and
   run of the repaired module, and the compile is warning-clean; what is not
   established is `dune runtest` over every other test in the repository. **If
   the next run is red at *Run tests*, this round's repair is what to look at
   first, and the promotion block is the evidence** — the same discipline
   `WO-0081` used.
7. **`DVC-1a` remains unbuilt** and every M04 count in this round is a hand count
   with its method stated. It must land before any `SO-` quotes an M04 coverage
   fraction. Carried from `J-dv_lead-0180` item 6, unchanged.
8. **`test/` now names M07 and M15 for the first time** (measured: zero hits at
   `292596c`, thirty-two at this commit, all in the repaired monitor and its
   test, none of them a DUT reference). The architect's §13 rows rest on
   *"no file under `test/` names either module"*; that claim was true when
   written and is false from this commit, and the two rows should be read with
   this entry beside them. **No committed test drives either module**, which is
   the claim those rows actually need.

### Files-in-this-commit
- test/attack_plans/AP-xgmii_tx_64.md
- test/monitors/octet_time.ml
- test/monitors/octet_time.mli
- test/monitors/test_octet_time.ml

## [J-dv_lead-0182] 2026-08-11T16:28Z | task:none | The §0.5 repair countersigned whole on my own theorem returned to me and re-derived rather than remembered — with the carry's instance list narrowed because it is a property of the decomposition and not of the module, the census's fourth structural module found missing from it, and the location of Q-4's cure conceded in one sentence

### Trigger

Orchestrator dispatch, **one round, two acts**: the countersignature the
architect's `43c0087` round owes me on the whole `requirements.md` §0.5 diff, and
my one-sentence answer on where `FINDING Q-4`'s cure lands. Both acts are
consequences of my own `J-dv_lead-0181`: the diff takes my closure theorem and my
cure-2 argument, and the location question is the architect's Open-question 1
against my own proposed cure.

**Abort-first precheck, before any file was opened.**

    git status --short              # empty
    git rev-parse HEAD              # 43c0087d551b166432c79f4a1588fe3a94da61f1
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 16:18:31 UTC 2026

Byte-equal to the dispatched spawn-head `43c0087`, tree clean, so neither branch
of the abort procedure was reached. The dispatch declares **one** sibling — the
orchestrator's board flip (`tasks/BOARD.md`, `site/**`, its journal) — and states
that rtl and architect are **not** live.

**The sibling fired, for the fourth consecutive round, and I ran the clause
rather than reasoning about it.** Between my last read and this entry HEAD moved
`43c0087` → **`8babb6b`** (*"The flip that records the arc's third generation …"*,
orchestrator):

    git log --oneline 43c0087..HEAD    # 8babb6b, one commit, the declared sibling
    git diff --name-only 43c0087 HEAD  # orchestrator journal, site/** (5), tasks/BOARD.md
    git diff 43c0087 HEAD -- docs/specs/ test/ tools/ agents/handoffs/ \
        docs/reports/latency/ docs/gates/ \
        agents/journals/claude_dv_lead_agent.v10.md \
        agents/journals/claude_architect_docs_lead_agent.v04.md      # empty

**Every surface this countersignature rests on is byte-unchanged across the
move** — the whole of `docs/specs/`, my own instrument under `test/`, and both
journals — so every quantity below holds at either head, and the verdicts are
paid against `43c0087` as dispatched. Four rounds, four exercises of the clause,
three commands each time.

**No rotation.** v10 stands at 57,340 bytes against `JOURNAL_SOFT_MAX` = 262,144
(ADR-0017 §5); this entry appends to the volume `-0181` opened.

**Honest stamp.** The header stamp is `date -u` read at the moment of writing
(16:27:55Z, rounded to the minute), and it is this chain's own discipline rather
than a courtesy: the architect's ledger item 61 tracks a run of fast stamps on
the other chain, and a countersignature dated wrong is a countersignature whose
ordering against the diff it signs cannot be checked.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any
  other file (§3 packet classes and relay rule, §4/§4.1/§4.2 entry grammar and
  set-equality, §5 R1–R9, §6 write scopes, §7 gates and the harvest clause, §10's
  independence and evidence rules; charter §8's sign-off and independence rules).
- **`git show 43c0087` whole** (six files, +853/−29), read as a diff and then at
  HEAD: `requirements.md` §0.5's q paragraph group and the **Word delay ΔC**
  bullet list, the three new §13 rows, `arp_cache.md` §7 + §13,
  `udp_complete_64.md` §7 + §13, `nic_top.md` §7 + §13, and
  `docs/gates/lessons-harvest-block.md`.
- **`J-architect_docs_lead-0043` in full and verbatim** — Trigger, Inputs,
  Reasoning 1–8, Actions, Evidence (including its throwaway-script figures and
  its **two** decompositions of M19), Outcome with the seventy-row ledger, and
  Open-questions 1–5. Read at the source, not through the dispatch's summary.
- **`docs/specs/requirements.md` at HEAD**: §0.5 **whole** — octet time, latency,
  front offset h, the inserting-module clause, the amended **q** paragraph group
  (subject, halved default, the *what the default said* recital, REQ-021, the
  structural-wrapper clause, the closure consequence, the Phase-1 census
  sentence), the identity, *Why a term and not a scope*, **Word delay ΔC** and its
  three consequence bullets, **Cycles**, the straddle test and the closing
  paragraph — plus §0.4 whole (the **Structural modules** paragraph is the domain
  Act 1's census is checked against) and §13's three new rows.
- **The four structural modules' §7s**: `ip_complete_64.md` §7 whole (M16's
  guard, added at `292596c`), `udp_complete_64.md` §7 whole (M19's new guard),
  `nic_top.md` §7 whole (M20's new guard, its REQ-006 derivation table and its
  two-route check), and **`eth_mac_10g.md` §7 and §13 whole** — the fourth
  structural module, which neither this round's guards nor the census sentence
  reaches, and which is where `FINDING Q-8` lives.
- **The leaf §7s every figure below is derived from**: `xgmii_tx_64.md` §7 (M04's
  five-row table: event delay 8 octet times, L = 16, h = 0, ΔC = 2),
  `udp_ip_tx_64.md` §7 (M18: 1 cycle, one whole word inserted),
  `eth_arb_mux.md` §7 (M09: L = 0, ΔC = 0), `eth_axis_tx.md` §7 (M07: L = 22,
  h = 0, q = 6, ΔC = 2) and `ip_eth_tx_64.md` §7 (M15: L = 28, h = 0, q = 4,
  ΔC = 3), plus `arp_cache.md` §7's repaired no-instance recital.
- **My own instruments, read as their owner**: `test/monitors/octet_time.ml`
  (`word_cycles` at line 9 and its only in-module caller at line 294),
  `test/monitors/octet_time.mli` §`word_cycles`, and the census of every caller
  under `test/` and `tools/`.
- **My own `J-dv_lead-0181` whole** — §2's walked REQ-019 domain, §3's
  `FINDING Q-4` and its stated cure, §6's `Q-3` concurrence with the closure
  theorem and the inverted exposure ranking, §7's instrument repair, §9's
  `FINDING Q-5`, and the three harvest candidates.
- **Not read**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`,
  `test/third_party/**`, `site/**`, `tasks/BOARD.md`. **No RTL reached this
  round.** Every quantity below is derived from a specification, checked against a
  second specification, and re-checked by arithmetic in a throwaway script whose
  output is in Evidence. **No Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

#### 1. What this countersignature has to do that the last two did not

The `292596c` round asked me to check two claims *about* a diff. This one asks me
to check a diff that **contains my own theorem**, my own cure-2 argument and my
own exposure ranking. The failure mode is specific and I named it before I
started: a signer who recognises his own sentence coming back stops reading. So
the standard for this round is that **nothing is signed on recognition** — the
closure consequence is re-derived from §0.5's definition as it now stands, the
carry formula is derived independently and then checked at every decomposition of
all three composites, and the census sentence is checked against §0.4's own
structural set rather than against the three modules I ranked.

That standard is what produced the two narrowings below. Both are in text that
descends from my own filing, and one of them (`Q-6`) is a defect **my own
theorem's phrasing invited**, because a statement true mod 8 was carried into a
statement about a quotient where the modulus is exactly what is lost.

#### 2. The subject corrected to the port pair — COUNTERSIGNED, and item 53's residue measured rather than described

§0.5 now reads: q *"is a property of the **port pair** it is measured across (the
input port whose measurement event names the input word, and the output port
whose word ΔC counts to) together with the start lane"*, with the reason stated —
*"one module can answer differently at two of them, and three Phase-1 modules
do"*.

**This is the correction my REQ-019 signature depends on and I sign it without
qualification.** `J-dv_lead-0181` §2 walked REQ-019's domain as **ten modules,
six leaf and four structural, the structural four entering by port pair**, which
is §0.4's own sentence (*"their transmit ports are not receive-path ports"*).
Under a module-subject that walk is incoherent: M16 would have to have one q, and
it has 0 at its receive ports and 2 at its transmit ports. The architect states
exactly this dependency in its Reasoning 3 and it is correct.

**One seam, recorded and deliberately NOT filed.** The sentence still opens *"and
like h it is …"*, and h's own paragraph three above still says *"h is a property
of the module and the start lane"*. So the text now asserts a parallel that the
neighbouring paragraph does not carry. It is not a defect and I will not file it:
h **is** in fact port-pair-dependent (M16's receive h is 34 and its transmit h is
0), so the inference the phrase invites is true of the world and false only of
§0.5's own wording — which is precisely the residue the architect's ledger item 53
declares open, now made visible inside the section instead of only in a ledger.
Making a known residue legible is an improvement, not a defect.

**And the residue is bounded, which is a measurement nobody has made.** I
evaluated §0.5's straddle test — (h − q) ≢ 0 (mod 8) — at **both port pairs of
all four structural modules**, to find whether any module today answers the
module-subject tests two ways:

| port pair | h | q | (h − q) mod 8 | straddles |
|---|---|---|---|---|
| M05 receive, lane 0 | 8 | 0 | 0 | no |
| M05 receive, lane 4 | 12 | 0 | 4 | **yes** |
| M05 transmit | 0 | 0 | 0 | no |
| M16 receive / transmit | 34 / 0 | 0 / 2 | 2 / 6 | yes / yes |
| M19 receive / transmit | 42 / 0 | 0 / 2 | 2 / 6 | yes / yes |
| M20 receive, lanes 0 and 4 / transmit | 50, 54 / 0 | 0 / 2 | 2, 6 / 6 | yes / yes |

**Item 53's residue has exactly one live instance in Phase 1 — M05 at a lane-4
start — and is latent at the other three**, which straddle at both port pairs and
therefore answer the module-subject test unambiguously today. That does not make
the residue safe; it makes it *scheduled*, and it tells the §0.5 scoping round
which module its first test case is.

**VERDICT — the port-pair subject: COUNTERSIGNED.**

#### 3. The halved default — COUNTERSIGNED, and my own instrument already implements it, which is a theorem and not a coincidence

The default now assigns zero *"where that holds"* — at a port pair inserting
nothing or a whole number of words — and **assigns nothing** elsewhere, where q is
left *"unstated"* and *"every quantity below that consumes q is underived there
until it does"*, with a pinned constant across such a port pair declared
**defective, refutably by arithmetic before any RTL**. That is cure 1 as I
recommended it, phrased as a halving, with the reason kept attached: silence
remains an assignment where the rule holds, so every specification written before
q existed stays correct without amendment.

**What I checked that the recommendation did not cover: whether the halving is
implementable, or whether it obliges an instrument to know something it cannot
see.** `word_cycles` takes L, h and an optional q; it cannot see an insertion
count, so it cannot itself apply the halved default's condition. The question is
whether its unconditional `?output_offset = 0` therefore now *contradicts* §0.5 —
silently answering where the specification says nothing is assigned.

**It does not, and the reason is exhaustive rather than anecdotal.** At a
conformant port pair, (L + h − q) ≡ 0 (mod 8). If q ∈ {1 … 7} then
(L + h) ≡ q ≢ 0 (mod 8), so `word_cycles` with `~output_offset` omitted computes a
sum that is not a multiple of 8 and returns **`None`**. Searched exhaustively over
L ∈ [0, 200), h ∈ [0, 64), q ∈ [1, 8): **zero** triples exist where a conformant
port pair with q ≠ 0 also has (L + h) a multiple of 8 (Evidence). So the
instrument's silence produces a **refusal**, never a wrong number — the same
disposition the halved default takes in the specification. My round at `9a596e7`
built that alignment without knowing which cure would be ruled; it survives the
ruling, and the property is worth stating in the record because it is the reason
no committed expect block moves under this diff.

**VERDICT — the halved default: COUNTERSIGNED**, and I record that the
instrument's behaviour at an omitted q is refusal by arithmetic, not assignment by
default, so §0.5's *"silence assigns nothing"* has an implementation today.

#### 4. The structural-wrapper clause and the closure consequence — COUNTERSIGNED, the rule-versus-recital distinction verified as written, and one inherited premise named

**The distinction is written, in terms, and I checked the words rather than the
intent**: *"That is the definition **read at** a wrapper, not a rule **for**
wrappers, and the distinction is why no such rule is written: minting one would
enumerate what the definition already entails, which is the move* Why a term and
not a scope *refuses, one structural level up."* That is cure 2 refused as a
definition with its content kept as a recital, and the sentence a later reader
needs in order to tell which it is met is present. Signed.

**The closure consequence, re-derived from the amended text and not from my own
entry.** With q defined as (octets inserted ahead of the frame) mod 8 and the
wrapper clause reading that definition at a composite:

    q(comp) = (Σ Iᵢ) mod 8 ≡ Σ (Iᵢ mod 8) = Σ qᵢ           (mod 8)
    (L + h − q)(comp) = Σ (Lᵢ + hᵢ) − q(comp) ≡ Σ (Lᵢ + hᵢ − qᵢ) ≡ 0  (mod 8)

whenever every child closes. Checked numerically at all three composites: the
residue (L + h − q) mod 8 is **0** at M16 (48), M19 (56) and M20 (72), by both
the two-child and the all-leaf decompositions. Signed.

**One premise is unstated in three places, and I name it rather than file it.**
The step Σ Iᵢ = I(comp) — *"insertions add along a chain"* — holds only where **no
stage removes octets an earlier stage inserted ahead of the frame**. Where a stage
strips what an earlier one inserted, neither the insertion sum nor the front-offset
sum survives, and the closure argument, the wrapper clause and the additivity
correction all lose their footing together.

I do not file it, on a ground I want on the record because it cuts against my own
interest in filing: **the premise is inherited, not introduced.** §0.5's
pre-existing additivity of h rests on it (SPEC-M20 §7 sums front offsets to 50 by
exactly that route), so it is not this diff's defect, and it is **unfalsifiable in
Phase 1 by construction** — §0.4's receive chain only strips and the transmit
chain only inserts, so no Phase-1 path mixes the two, measured at every stage
(M03/M06/M08/M10/M14/M17 strip and insert nothing; M04/M07/M15/M18 insert and
strip nothing; M09 does neither). It belongs to the architect's ledger item 50
survey — *for each normative clause, enumerate the modules it quantifies over* —
where it is one clause covering three statements, and not to a countersignature
that would state it three times. **My theorem carries the same premise as the
text that adopted it**, which is the honest reason it is recorded here rather than
charged to anyone.

**VERDICT — the structural-wrapper clause and the closure consequence:
COUNTERSIGNED**, with the additivity premise named above as a shared, inherited
and currently unfalsifiable condition of all three statements.

#### 5. The ΔC-additivity qualification — the FORMULA countersigned exactly, the INSTANCE LIST narrowed, and `FINDING Q-6`

The headline now carries its condition (*"along a chain whose stages insert
nothing"*), the mechanism is stated correctly (ΔC counts to the first output word
carrying a frame octet while the next stage's measurement event is the previous
stage's first output word, and at an inserting stage those are different words),
and the exact statement is given as

    ΔC(comp) = Σ ΔCᵢ + (Σ qᵢ − q(comp))/8 = Σ ΔCᵢ + ⌊Σ qᵢ / 8⌋

**Both forms are right, and I derived them rather than checking them.** From
ΔCᵢ = (Lᵢ + hᵢ − qᵢ)/8 and the composite's own totals,
ΔC(comp) − Σ ΔCᵢ = (Σ qᵢ − q(comp))/8 identically; and since
q(comp) = (Σ qᵢ) mod 8 with Σ qᵢ ≥ 0, that equals ⌊Σ qᵢ / 8⌋. The architect's
characterisation is exact: it is **the same carry my closure theorem discards mod
8** — the composite always closes and only its ΔC is missed by the naive sum.
The uncommissioned repair was also the right call, and I say so against the
architect's Open-question 2: publishing a consequence recital that leans on
additivity beside an unconditioned additivity headline would have been the same
defect twice, which is the phrase the parent round used to refuse my own
unconditioned corollary.

**What I will not sign is the sentence that names where the correction
vanishes**, and the defect is one my own theorem's mod-8 phrasing invited:

> **`FINDING Q-6` (MINOR), mine, against `requirements.md` §0.5's amended
> ΔC-additivity bullet.** The bullet says the correction *"vanishes wherever
> Σ qᵢ < 8 — so along §0.4's receive chain, where every qᵢ is 0, and **at M19
> (0 + 2) and M20 (2 + 0)**"*. **The correction is a property of the
> decomposition, not of the composite**, and those two instances are named by
> module. Measured at both decompositions of each: **M19** over {M18, M16} has
> Σ qᵢ = 2 and correction 0 (7 = 7 + 0); over its four leaves {M18, M15, M09,
> M07} it has Σ qᵢ = 10 and correction **1** (7 = 6 + 1). **M20** over
> {M19, M05/M04} has Σ qᵢ = 2 and correction 0 (9 = 9 + 0); over its five leaves
> it has Σ qᵢ = 10 and correction **1** (9 = 8 + 1). The composite's ΔC is
> decomposition-invariant — that is the formula's content — but the *split*
> between the sum and the carry is not, so *"it vanishes at M19"* is true of one
> decomposition and false of the other. **Why this is not pedantry**: this same
> diff's guards leave **all three wrappers pinning nothing** in their §7s, so the
> wrapper-level ΔCs exist only inside change-log rows, and the decomposition a
> reader actually has through module §7s is the **leaf** one — exactly the one at
> which the correction is 1 at both named modules. A reader who takes the bullet
> at its word and sums the leaves gets **ΔC = 6 at M19 and 8 at M20** against the
> true 7 and 9: a one-cycle word-delay error, the same shape and direction as the
> quarter-cycle error the whole `Q-3` arc exists to prevent, reached by following
> the sentence rather than by ignoring it. **Nothing is red today**: no committed
> instrument computes a wrapper composite (§7 below, re-measured), no wrapper §7
> pins one, and the three §13 derivations state the composites correctly. **Cure**:
> one clause — say the correction is taken over the stages of the decomposition
> being summed, and give M19's two values as the worked instance, which is
> already in the architect's own Evidence block (*"M19 decomposed to leaves:
> 6 + 1 = 7"*) and did not reach the text. **Provenance, stated against myself**:
> the invitation is in my theorem's phrasing — I proved a congruence mod 8 and the
> bullet needed a quotient, and a congruence is exactly the statement from which
> the carry has been divided out.

**VERDICT — the ΔC-additivity qualification: COUNTERSIGNED as to the correction
formula in both its forms and as to the headline's condition; NARROWED as to its
instance list, filed as `FINDING Q-6` (MINOR).** The diff stays in force under
either reading: the unconditioned headline it replaces is false at three
composites, and this finding is about which decomposition a true correction is
computed over.

#### 6. The amended Phase-1 census sentence — NARROWED, and `FINDING Q-7`: the fourth structural module is in none of its three clauses

The sentence enumerates three sets: *"q = 0 across every receive-path port pair …
and across every leaf transmit port pair except M07 (q = 6) and M15 (q = 4).
Across the transmit port pairs of the three structural wrappers M16, M19 and M20
it is 2 … while across their receive port pairs it is 0."*

**I checked it against §0.4's own structural set rather than against the three
modules I ranked, which is `LH-0181-1`'s method applied to the sentence that
replaced a false census.** §0.4's **Structural modules** paragraph names
**four**: M05 `Eth_mac_10g`, M16, M19 and M20.

> **`FINDING Q-7` (MINOR), mine, against `requirements.md` §0.5's amended
> Phase-1 census sentence.** **M05's transmit port pair falls in none of the
> sentence's three clauses**: it is not a receive-path port pair (§0.4 — *"their
> transmit ports are not receive-path ports"*), it is not a **leaf** transmit port
> pair (M05 is structural), and it is not one of the three wrappers the sentence
> names. **No value is wrong**: M05's transmit port pair inserts M04's eight
> octets — one whole word — so q = 0, and the halved default assigns it correctly
> because §0.5's first clause holds there. What is defective is the **enumeration**,
> in a sentence whose entire content is an enumeration, replacing a census that
> was false for the same reason one clause too narrow. **Why M05 fell out**: both
> surveys that produced this sentence were keyed on the *symptom* — the
> architect's on the wrappers measured at q = 2, mine on the wrappers I ranked by
> exposure, both of which are the q ≠ 0 set — and M05 is the structural module
> whose q is benign. A census keyed on the value that triggered the finding cannot
> see the member whose value is fine. **Cure**: one clause — name the four
> structural modules of §0.4 and say that three carry q = 2 across their transmit
> ports while M05 carries 0, its child inserting a whole word. That also makes the
> sentence self-checking against §0.4 instead of against a memory of which
> modules the finding named.

**VERDICT — the amended census sentence: COUNTERSIGNED as to every value it
states** (all six re-derived: receive port pairs 0 by §0.4's strip-only chain, M07
6, M15 4, M16/M19/M20 transmit 2 from insertions of 34/42/50, their receive port
pairs 0); **NARROWED as to its completeness, filed as `FINDING Q-7` (MINOR).** The
sentence it replaces was false; this one is true and short by one member, so it is
IN FORCE without qualification.

#### 7. The class ground, checked at the source, including the measurement of mine that is load-bearing in it

The architect states the ground for my judgment: same-function is **not** offered
(the two defaults differ at exactly three port pairs), and the ground is that the
retired default was **false** there and that **nothing was built on the
falsehood**. Three limbs, each checked:

- **No wrapper §7 pins a transmit per-octet constant.** Read all three at HEAD.
  M16 §7: *"this section pins no per-octet constant across M16's transmit
  ports … A monitor may therefore **not** convert either cycle figure above into
  a per-octet latency, a front offset or an output offset."* M19 §7 and M20 §7
  now carry the same in their own terms. ✔
- **§0.5's injection licence is gated behind a fact stated in a module's own §7,
  and none of the three states it.** ✔ (checked in the closing paragraph of §0.5
  and in the three §7s).
- **No committed instrument computes a wrapper composite — my measurement, and
  the one the ground leans on hardest. Re-verified at `43c0087`.**
  `grep -rn "word_cycles" test/ tools/` returns **14** hits, against ten when I
  measured it at `292596c`; the four new ones are **my own repair's** — the
  `?output_offset` signature, its `.mli` contract, and the negative controls in
  `test_octet_time.ml`. **Every hit is inside `test/monitors/octet_time.{ml,mli}`
  and its own test; there is still no caller anywhere else in the suite.** The
  only external users of the module are M03's benches
  (`test/xgmii/test_arrival.ml`, `test/xgmii_rx_64/**`), which call
  `Latency.frame_in/frame_out/word_delay` on a **leaf** with q = 0 and never call
  the conversion. `tools/check_emitted_verilog.sh` names `nic_top` only for
  REQ-017's port set. **The measurement holds at this head and the count's change
  is fully accounted for.** ✔

The ground is correctly stated and correctly **not** stated as same-function:
offering that ground in the round that sustains `Q-4` would have repeated the
error `Q-4` convicts, and the row says so in terms. Signed.

#### 8. The two module guards, riding as consequences — COUNTERSIGNED, with an answer to the question the architect attached to them

The architect asks whether *a guard that names a q without pinning a constant is
the right instrument*. **It is, and for a reason the architect's own Reasoning 4
under-claims**: a guard that named no q would leave a reader with a prohibition
and no way to satisfy the obligation §0.5 now places on him — the halved default
tells him q is *unstated* there, and the guard tells him what it is, so the two
together convert a hole into a labelled hole. A guard that **pinned** the
composite would put a constant into a §7 whose governing §0.5 diff was still
awaiting this signature, which is the worse of the two errors and was my own
position at `J-dv_lead-0181` §6.

I re-derived both guards' figures from the children rather than reading them:
M19's transmit port pair inserts 8 + 34 = 42 → q = 2; M20's inserts 42 + 8 =
50 → q = 2. Both correct. Both name the transmit figures as **event delays**,
which is what SPEC-M16 §7, SPEC-M15 §7 and SPEC-M07 §7 already say of the figures
they compose, so the guards are consistent one level down. **Signed.**

**And to the architect's Open-question 5, as the countersignatory whose signature
was the stated blocker**: with this entry the blocker is gone, and my
recommendation is **pin all three** at the round that closes item 67 — L = 50/58/74,
h = 0, q = 2, ΔC = 6/7/9 — *after* `Q-6`'s cure lands, not before. The reason is
`Q-6` itself: while the wrappers pin nothing, every reader must compose from the
leaves, and the leaf route is exactly the one the additivity bullet currently
mis-describes. Pinning the three ends that exposure at its source; leaving them
unpinned keeps a derivable-but-unstated quantity in the corpus, which is an
invitation to derive it wrongly by a route the corpus itself gets wrong.

#### 9. `FINDING Q-8` — the fourth wrapper the guards did not reach, found by walking §0.4's structural set instead of the finding's

Walking the structural set for `Q-7` put SPEC-M05 §7 in front of me, and it is the
`C-RL-8` class at a site neither census could see.

> **`FINDING Q-8` (MINOR), mine, against `docs/specs/modules/eth_mac_10g.md`
> §7.** The **Latency** bullet reads: *"**Zero octet times added, in both
> directions.** M05's receive-port constants are M03's exactly — L = 16 octet
> times at a lane-0 start, 12 at a lane-4 start, front offset h = 8 and 12, word
> delay ΔC = 3 (SPEC-M03 §7) — and **its transmit-port constant is M04's, 8 octet
> times** (SPEC-M04 §7)."* **8 octet times is M04's event delay, not its
> latency.** SPEC-M04 §7's five-row table pins *"REQ-210's event delay | 1 cycle =
> 8 octet times"* **and** *"L (octet times), §0.5 | 16"*, h = 0, ΔC = 2 — and
> §0.5's inserting-module clause says in terms that a delay pinned to an inserted
> word *"is an event delay, not a latency … a specification pinning both SHALL name
> which is which."* M05's sentence pins **one**, does not name which, and names it
> in a clause built in exact parallel with a receive-side clause that names L. **It
> is refutable by the bullet's own first sentence**: M05 adds *zero* octet times in
> both directions, so M05's transmit-port L **is** M04's L = 16, and 8 is the
> figure the sentence should be calling the event delay. A composer of M20's
> transmit chain who takes M05's §7 at its word carries **8 where 16 belongs** —
> not a one-cycle error but a factor of two in L, which is why this is worth
> filing even though M05's q is 0. **Nothing is built on it, measured**: no
> committed test computes an M05 constant (`test/` names `eth_mac_10g` twice —
> `AP-xgmii_tx_64.md` §5 as a loopback candidate and `test/cosim/tb_xgmii_rx_64.v`
> in a comment about the reference's own files — neither a latency claim), and the
> architect's own M20 composite in `requirements.md` §13 uses **16** correctly.
> SPEC-M05 §13 has **no** post-freeze row and its preamble restates only the
> receive-side constants, so the transmit figure is untracked. **Cure**: name both
> figures at M05 as SPEC-M04 §7, SPEC-M07 §7 and SPEC-M15 §7 already do — one
> clause, no value moving. **The generalisable half, which is why this is filed
> and not fixed in passing**: this site escaped **two orthogonal censuses**. The
> retired-form census was keyed on the string `(L + h)`, which M05 §7 does not
> contain; the wrapper survey was keyed on q = 2, which M05 is not. A site can
> survive two complete sweeps when each is keyed on a **symptom** of the class
> rather than on the class, and the survivors are systematically the members whose
> symptom is absent.

#### 10. Act 2 — the location of `Q-4`'s cure: CONCUR, in one sentence and with its ground

The architect adopted my ground whole, refused my cure's **location**, and asks
whether I read §13's frozen-record rule as reaching *values* and not *grounds*.

**I do not, and I concur:**

> **I asked for one sentence and named a location I had no ground for, and the
> architect's is the better one: §13's frozen-record rule reaches a class cell's
> **ground** at least as strongly as its values, because a class cell is consulted
> as evidence of what was claimed when the sweep ran and a re-verification
> decision turns on knowing that a wrong ground was once offered — a fact that a
> corrected-in-place cell destroys and a row beside it preserves — so the new row
> is the cure, on the one condition it already satisfies, that it name the cell it
> corrects.**

Two things I add without contesting anything. **First**, the disposition has a
cost the ledger should carry rather than the practice absorbing it silently: a
reader of the corrected cell now needs a second row to know the first is wrong,
and nothing in the cell points forward to it. §13's rows are chronological, so the
pointer runs one way only — the correcting row names the cell, the cell does not
name the correcting row. That is inherent to an append-only record and is the
right trade, but it means the table's **navigability** degrades as instances
accumulate, and item 41's third instance is where that should be said. **Second**,
the rule is now general enough to state, and the architect's ledger item 41 says
so: *a record is corrected beside itself, never rewritten* has three independent
instances across two chains. I bank it below as a harvest candidate with its LH1
provenance in both chains rather than one.

### Actions

1. Ran the abort-first precheck; both outputs matched the dispatch exactly. Read
   HEAD again before writing: moved to `8babb6b` (the declared sibling), ran the
   re-verification clause, confirmed every read surface byte-unchanged, proceeded.
2. Read the charter and PROTOCOL in full, then `J-architect_docs_lead-0043` whole
   and verbatim, then `git show 43c0087` whole, then §0.5 and §0.4 whole at HEAD,
   before writing anything.
3. **Countersigned the port-pair subject**, and **measured** the straddle test at
   both port pairs of all four structural modules to bound ledger item 53's
   residue: one live instance (M05, lane-4 start), three latent.
4. **Countersigned the halved default**, and established by exhaustive search
   that my instrument's omitted-q behaviour is **refusal**, never assignment — so
   §0.5's *"silence assigns nothing"* has an implementation today.
5. **Countersigned the structural-wrapper clause and the closure consequence**,
   verifying the rule-versus-recital distinction is written in terms, re-deriving
   the congruence from the amended definition, and **naming the inherited
   insertions-add premise** shared by three statements without filing it.
6. **Re-derived the additivity correction in both forms**, confirmed it at
   **five** decompositions of the three composites, **countersigned the formula**,
   and **filed `FINDING Q-6` (MINOR)** against the instance list, which names a
   decomposition-relative fact by module.
7. **Re-derived every value in the amended census sentence**, checked its
   enumeration against §0.4's structural set, and **filed `FINDING Q-7` (MINOR)**:
   M05's transmit port pair is in none of its three clauses.
8. **Checked all three limbs of the stated class ground**, including
   **re-verifying my own load-bearing measurement at `43c0087`** (no committed
   instrument computes a wrapper composite; 14 `word_cycles` hits, all inside the
   monitor, its interface and its own test, the four new ones my own).
9. **Countersigned both module guards** as consequences, re-deriving their q from
   the children, and answered the architect's instrument question and its
   Open-question 5 with a recommendation to pin all three **after** `Q-6`'s cure.
10. **Filed `FINDING Q-8` (MINOR)** against SPEC-M05 §7, found by walking §0.4's
    structural set: the transmit-port constant it pins is M04's event delay, not
    its latency, and the bullet's own *"zero octet times added"* refutes it.
11. **CONCURRED on `FINDING Q-4`'s cure location** in one sentence with its
    ground, discharging the architect's Open-question 1.
12. Re-derived every figure in a throwaway script (Evidence), outside the
    repository and not staged.
13. Wrote this entry. **No `docs/**` file touched** — transcription is the
    orchestrator's clerical act. **No `git add`, no `git commit`, no `git push`,
    no git write of any kind.**

### Evidence

Reproducible from a checkout at this commit unless stated otherwise.

**Precheck, the head move, and the re-verification.**

    git status --short              # at entry AND at exit: empty
    git rev-parse HEAD              # at entry: 43c0087d551b166432c79f4a1588fe3a94da61f1
    git rev-parse HEAD              # before writing: 8babb6b5191cf754508a398c31bd38de61bedfde
    git log --oneline 43c0087..HEAD # 8babb6b, one commit, the declared sibling
    git diff --name-only 43c0087 HEAD
    # agents/journals/claude_orchestrator_agent.v02.md, site/public/*.html (5), tasks/BOARD.md
    git diff 43c0087 HEAD -- docs/specs/ test/ tools/ agents/handoffs/ docs/reports/latency/ \
        docs/gates/ agents/journals/claude_dv_lead_agent.v10.md \
        agents/journals/claude_architect_docs_lead_agent.v04.md          # empty
    date -u                         # Tue Aug 11 16:27:55 UTC 2026

**Every figure below is derived from module specifications only** — SPEC-M04 §7
(L 16, h 0, I 8, event delay 8 octet times), SPEC-M07 §7 (22, 0, 14), SPEC-M09 §7
(0, 0, 0), SPEC-M15 §7 (28, 0, 20), SPEC-M18 §7 (8, 0, 8) — and re-checked by a
throwaway script outside the repository, not staged:

    M16: L=50 h=0 I=34 q=2 dC=6   closure (L+h-q) mod 8 = 0
    M19: L=58 h=0 I=42 q=2 dC=7   closure (L+h-q) mod 8 = 0
    M20: L=74 h=0 I=50 q=2 dC=9   closure (L+h-q) mod 8 = 0

    additivity, both forms, at FIVE decompositions:
      M16 <- 3 leaves   qi=[4,0,6]     sum_q=10 sum_dC=5  form1=form2=direct=6  carry 1
      M19 <- {M18,M16}  qi=[0,2]       sum_q=2  sum_dC=7  form1=form2=direct=7  carry 0
      M19 <- 4 leaves   qi=[0,4,0,6]   sum_q=10 sum_dC=6  form1=form2=direct=7  carry 1
      M20 <- {M19,M04}  qi=[2,0]       sum_q=2  sum_dC=9  form1=form2=direct=9  carry 0
      M20 <- 5 leaves   qi=[0,0,4,0,6] sum_q=10 sum_dC=8  form1=form2=direct=9  carry 1

form1 = Σ ΔCᵢ + (Σ qᵢ − q(comp))/8, form2 = Σ ΔCᵢ + ⌊Σ qᵢ/8⌋, direct =
(L + h − q)/8 of the composite. **The composite's ΔC is decomposition-invariant
and the carry is not** — rows 2 and 3 are the same module and differ in the
carry — which is `FINDING Q-6`'s whole content, and the leaf rows are the ones a
reader reaches through module §7s.

**The straddle test at both port pairs of all four structural modules**
(§2's table above): M05 receive lane-0 (h 8) **0**, lane-4 (h 12) **4**, transmit
(h 0, q 0) **0**; M16 receive (34) **2** / transmit (0 − 2) **6**; M19 receive
(42) **2** / transmit **6**; M20 receive (50, 54) **2, 6** / transmit **6**. One
module answers two ways: **M05 at a lane-4 start**.

**The instrument's refusal property, exhaustively** (Reasoning 3):

    # word_cycles ?(output_offset = 0) ~front_offset l =
    #   let sum = l + front_offset - output_offset in
    #   if sum < 0 || sum mod 8 <> 0 then None else Some (sum / 8)   [octet_time.ml:9]
    conformant (L,h,q), q in 1..7, with (L+h) ALSO a multiple of 8,
    over L in [0,200), h in [0,64):   ZERO triples

so an omitted `~output_offset` at a conformant port pair with q ≠ 0 returns
`None`. Checked concretely at M07 (`~front_offset:0 22` → `None`) in the committed
test at `test/monitors/test_octet_time.ml`.

**The wrapper-composite measurement, re-verified at `43c0087`** (Reasoning 7):

    grep -rn "word_cycles" test/ tools/ --include=*.ml --include=*.mli
    # 14 hits: octet_time.ml 2, octet_time.mli 3, test_octet_time.ml 9 — no other file
    # (10 at 292596c; the four new hits are my own 9a596e7 repair)
    grep -rn "Octet_time\." test/ tools/ --include=*.ml --include=*.mli | grep -v test/monitors/
    # only M03's benches: test/xgmii/**, test/xgmii_rx_64/** — Latency.frame_in/out/word_delay
    grep -rln "ip_complete\|udp_complete\|nic_top\|Nic_top" test/ tools/
    # test/attack_plans/AP-ip_eth_rx_64.md (prose), tools/check_emitted_verilog.sh (REQ-017 ports)

**`FINDING Q-7`'s domain, measured at the source**: `requirements.md` §0.4's
**Structural modules** paragraph names **M05, M16, M19 and M20**; §0.5's amended
census sentence names three, and M05's transmit port pair matches none of its
three clauses.

**`FINDING Q-8`'s two figures, at the source**: `eth_mac_10g.md` §7 — *"its
transmit-port constant is M04's, **8 octet times** (SPEC-M04 §7)"*;
`xgmii_tx_64.md` §7's table — *"REQ-210's event delay | 1 cycle = 8 octet
times"* and *"L (octet times), §0.5 | **16**"*. `eth_mac_10g.md` §13: *"This spec
has none"*, no data row. `grep -rln "eth_mac_10g\|Eth_mac_10g" test/ tools/` →
`test/attack_plans/AP-xgmii_tx_64.md` (§5's loopback candidate),
`test/cosim/tb_xgmii_rx_64.v` (a comment naming the reference's own files).

**Nothing in this entry is a verification result about any module**, and no `SO-`
is opened or offered. No RTL, no bench and no `libs/**` file was read. `dune` was
not invoked and no claim here depends on it (ADR-0005). Every arithmetic claim
above is checkable by a reader with `requirements.md` §0.4/§0.5, SPEC-M04 §7,
SPEC-M07 §7, SPEC-M09 §7, SPEC-M15 §7, SPEC-M18 §7 and the four structural §7s,
and no toolchain.

**Journal size**: v10 stands at 57,340 bytes before this entry, against
`JOURNAL_SOFT_MAX` 262,144 (ADR-0017 §5). No rotation.

### Outcome

**DoD met on both acts.**

**ACT 1 — the whole `requirements.md` §0.5 diff of `43c0087`: COUNTERSIGNED,
narrowed at two of its six items, with three findings filed.** Item by item:

| item | verdict |
|---|---|
| q's subject corrected to the **port pair** | **COUNTERSIGNED** — it is the correction my REQ-019 walk depends on; item 53's residue measured and bounded to one live instance (M05, lane 4) |
| the **halved default** (cure 1) | **COUNTERSIGNED** — and my instrument's omitted-q behaviour is refusal, not assignment, exhaustively |
| the **structural-wrapper clause** | **COUNTERSIGNED** — the *read at* / *rule for* distinction is written in terms |
| the **closure consequence** | **COUNTERSIGNED** — re-derived from the amended definition; the shared insertions-add premise named, not filed |
| the amended **Phase-1 census sentence** | **COUNTERSIGNED as to every value; NARROWED as to completeness** — `FINDING Q-7` (MINOR) |
| the **ΔC-additivity qualification** | **COUNTERSIGNED as to the correction formula and the headline's condition; NARROWED as to its instance list** — `FINDING Q-6` (MINOR) |
| the **class ground** as stated | **ACCEPTED** — same-function correctly not offered; all three limbs checked, including my own measurement re-verified at `43c0087` |
| the two **module guards** (SPEC-M19 §7, SPEC-M20 §7) | **COUNTERSIGNED** as consequences; a guard naming a q without pinning a constant is the right instrument, and my recommendation is to pin all three after `Q-6`'s cure |

**The diff stays IN FORCE in every part**; nothing in this entry suspends any of
it, and both narrowings are about text that is true-but-incomplete standing where
the text it replaced was false.

**ACT 2 — `FINDING Q-4`'s cure location: CONCUR**, in the one sentence of
Reasoning 10, discharging the architect's Open-question 1. The frozen-record rule
reaches grounds at least as strongly as values; the architect's row is the cure;
I add only that the pointer runs one way and that item 41's rule is now general
enough to state.

**Three findings filed, all MINOR, all routed to architect_docs_lead through the
orchestrator**: `FINDING Q-6` (the additivity correction's instance list is
decomposition-relative), `FINDING Q-7` (the census sentence omits M05's transmit
port pair), `FINDING Q-8` (SPEC-M05 §7 pins M04's event delay as its transmit-port
constant). **`Q-6` and `Q-7` are against text inside the diff I am countersigning
and do not withhold the signature; `Q-8` is against a file the diff does not
touch, found by walking the domain the diff's census quantifies over.**

Handoff: **journal-only**. The verdicts above go to `requirements.md` §13 as the
orchestrator's clerical transcription with this entry as their authority; the
three findings go to architect_docs_lead. **No file outside this journal is
staged, and my mechanics require no handoff file** — a countersignature of this
class is a journal-entry signature block, per `J-dv_lead-0180` and
`J-dv_lead-0181`, and `docs/**` transcription is not mine to write.

**Lessons-harvest note** (ADR-0018, PROTOCOL §7). **Not owed this round** —
§7 attaches the harvest to an `SO-` and to a phase gate, and this round is
neither; declared rather than omitted. The span opened after `J-dv_lead-0181`
runs and this entry joins it; the eleven candidates banked through `LH-0181-3`
carry forward unchanged. **Two candidates banked for the next harvest, LH1–LH3
discharged**, so the span's yield is not reconstructed later from memory:

- **`LH-0182-1`** — *A sum's correction term is a property of the decomposition
  summed over, not of the thing summed to; naming its value at the composite is a
  claim that is true of one decomposition and false of another.* **LH2-g**: no
  proper noun; the observable is that a stated correction is accompanied by the
  partition it is taken over. **LH1**: this round's `FINDING Q-6`, where a
  correction stated to vanish at two composites is 1 at both under the
  decomposition their own component documents make available. **LH3**: without it,
  a reader following the text's own worked instance computes the composite short
  by exactly the carry, at the sites where no other route is published.
- **`LH-0182-2`** — *A survey keyed on the symptom that triggered a finding cannot
  see the members of the class whose symptom is absent; key it on the class and
  enumerate from the document that defines the set.* **LH2-g**: no proper noun;
  the observable is that a sweep's key is the class predicate rather than the
  value that produced the first instance. **LH1**: this round's `FINDING Q-7` and
  `FINDING Q-8` — two independent censuses (one keyed on a retired string, one on
  a non-zero quantity) both left the same module standing, and it is the structural
  module whose quantity is benign and whose *other* property is the defect.
  **LH3**: without it, each sweep's survivors are systematically the sites that
  look healthiest, which is where the next author copies from.

**No escalation.** **E5 not triggered**: the one disagreement between leads —
`Q-4`'s cure location — is resolved by concurrence in this entry, and the three
new findings are filed, not disputed. **E2 not triggered**: no requirement, phase
or role added or dropped; no ceiling, allocation or §1.1 row moves; the diff I
sign withdraws a false assignment and admits or excludes no design. **E3 not
triggered** — no toolchain or licensing surface reached.

### Open-questions

1. **`FINDING Q-6` (MINOR)** — `requirements.md` §0.5's ΔC-additivity bullet
   names the correction's vanishing **at M19 and M20**, which is true of their
   two-child decompositions and false of their leaf decompositions (correction 1
   at both), and the leaf decomposition is the one this same diff's guards leave
   as the only route through module §7s. **The formula is countersigned; only its
   instance list is contested.** Cure: one clause. **Route**: architect_docs_lead.
2. **`FINDING Q-7` (MINOR)** — the amended Phase-1 census sentence's three clauses
   do not reach **M05's transmit port pair**, the fourth structural module §0.4
   names. Its q is 0 and the halved default assigns it correctly, so no value
   moves; the enumeration is short by one member. Cure: one clause naming §0.4's
   four. **Route**: architect_docs_lead.
3. **`FINDING Q-8` (MINOR)** — `eth_mac_10g.md` §7 pins *"its transmit-port
   constant is M04's, 8 octet times"*, which is M04's **event delay**; M04's L is
   **16** and the bullet's own *"zero octet times added, in both directions"*
   refutes the sentence. `C-RL-8`'s class at a fifth site, at the structural
   module both prior censuses were keyed to miss. Cure: name both figures.
   **Route**: architect_docs_lead.
4. **My recommendation on the architect's Open-question 5**: pin all three wrapper
   transmit composites (L = 50/58/74, h = 0, q = 2, ΔC = 6/7/9) at the round that
   closes ledger item 67 — **after** `Q-6`'s cure, not before. While they are
   unpinned every reader must compose from the leaves, and the leaf route is the
   one the additivity bullet currently mis-describes.
5. **Ledger item 53's residue is bounded and its first test case is named**: the
   straddle test returns different verdicts at M05's two port pairs at a lane-4
   start, and agrees at both port pairs of M16, M19 and M20. The §0.5 scoping
   round that corrects h and the two tests should use M05 as its worked instance.
6. **The insertions-add premise is unstated at three statements** — the
   structural-wrapper clause, the closure consequence and the additivity
   correction — and is inherited rather than introduced (§0.5's h-additivity rests
   on it too). It is unfalsifiable in Phase 1 by construction: no path mixes
   stripping and inserting stages. It belongs to the item 50 survey, as one clause
   covering three statements, and is recorded here rather than filed because my
   own theorem carries it identically.
7. **`FINDING Q-4`'s disposition has a navigability cost worth one ledger line**:
   a corrected class cell does not point forward to the row that corrects it, so
   the reader must find the later row to learn the earlier cell is wrong. Inherent
   to an append-only record and the right trade; it should be said at item 41's
   third instance rather than absorbed.
8. **`DVC-1a` remains unbuilt** and every attack-plan count I quote remains a hand
   count with its method stated. It must land before any `SO-` quotes an M04
   coverage fraction. Carried from `J-dv_lead-0181` item 7, unchanged.
9. **The whole-suite verdict is still CI's** (ADR-0005). This round touched no
   file under `test/`, so nothing in it can move a suite result; the `9a596e7`
   repair's CI adjudication is still the open item from my last round.

### Files-in-this-commit
- (none)

## [J-dv_lead-0183] 2026-08-11T17:02Z | task:none | Both cures countersigned on carries re-derived from the leaf specifications rather than read from the rows — and the measurement that shows the two cures are mutually load-bearing: the worked instance the Q-6 row publishes was not checkable against the corpus until the Q-8 diff landed beside it in the same commit

### Trigger

Orchestrator dispatch, **one round, one act**: countersign (or refuse, or narrow)
the two `§0.5` cures my `J-dv_lead-0182` narrowings commissioned — `FINDING Q-6`'s
decomposition-relative instance list and `FINDING Q-7`'s four-member enumeration —
with the values at the partitions to be verified by me rather than accepted from
the row. The dispatch additionally opens `FINDING Q-8`'s **no-countersignature
classification** to challenge within this round.

**Abort-first precheck, before any file was opened.**

    git status --short              # empty
    git rev-parse HEAD              # 2b30ffc808b0e5578ff88839fa813b2a5d4da29e
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf
    date -u                         # Tue Aug 11 16:54:37 UTC 2026

Byte-equal to the dispatched spawn-head `2b30ffc`, tree clean, so neither branch
of the abort procedure was reached. The dispatch declares **two** siblings in both
directions: the auditor on a process round (its own journal and named audit
artifacts) and the orchestrator's possible board flip (`tasks/BOARD.md`, `site/**`,
its journal).

**A sibling fired, for the fifth consecutive round, and I ran the clause rather
than reasoning about it.** Between my reads and this entry HEAD moved
`2b30ffc` → **`60c1ccf`** (*"The census nobody took returns 234 wrong dates …"*,
auditor) and `tasks/BOARD.md` went dirty:

    git log --oneline 2b30ffc..HEAD    # 60c1ccf, one commit
    git diff --name-only 2b30ffc HEAD  # agents/journals/claude_auditor_agent.v02.md
    git diff --stat                    # tasks/BOARD.md (working tree, uncommitted)
    git diff 2b30ffc HEAD -- docs/specs/ test/ tools/ agents/handoffs/ \
        docs/reports/latency/ docs/gates/ \
        agents/journals/claude_dv_lead_agent.v10.md \
        agents/journals/claude_architect_docs_lead_agent.v04.md      # empty

The commit is sibling lane 1 (auditor journal only), the dirty path is sibling
lane 2 (the board flip); **both are inside the lanes the dispatch declared, and
every surface this countersignature rests on is byte-unchanged across the move** —
the whole of `docs/specs/`, my own instruments under `test/`, and both journals.
Every quantity below therefore holds at either head, and the verdicts are paid
against `2b30ffc` as dispatched. Five rounds, five exercises of the clause.

**And a second move landed while this entry was being written**, `60c1ccf` →
**`b9fb75b`** (*"The audit lands whole on the board …"*, orchestrator) — sibling
lane 2 committing the flip: its own journal, `site/**` (5 files) and
`tasks/BOARD.md`, leaving my journal the only dirty path in the tree. The clause
was run a second time against the **dispatched** head rather than against the
intermediate one, which is the comparison that matters:
`git diff 2b30ffc b9fb75b -- docs/specs/ test/ tools/ agents/handoffs/
docs/reports/latency/ docs/gates/ agents/journals/claude_architect_docs_lead_agent.v04.md`
is **empty**. Two sibling moves in one round, both declared, no read surface
touched by either.

**No rotation.** v10 stands at 105,563 bytes against `JOURNAL_SOFT_MAX` = 262,144
(`scripts/policy.sh`, ADR-0017 §5); this entry appends to the volume `-0181`
opened.

**Honest stamp.** The header stamp is `date -u` read at the moment of writing
(17:01:41Z, rounded to the minute). It is the discipline this chain owes and not
a courtesy: a countersignature whose ordering against the diff it signs cannot be
checked is not a countersignature.

### Inputs

- `agents/charters/dv_lead.md` and `agents/PROTOCOL.md`, in full, before any other
  file (§3 packet classes and relay rule, §4/§4.1/§4.2 entry grammar and
  set-equality, §5 R1–R9, §6 write scopes, §7 gates and the harvest clause, §10's
  independence and evidence rules; charter §8's role-specific journal rules).
- **`git show 2b30ffc` whole** (three files, +840/−24), read as a diff and then at
  HEAD: `requirements.md` §0.5's ΔC-additivity bullet and its amended Phase-1
  census sentence, `eth_mac_10g.md` §7 and §13, and the four new `requirements.md`
  §13 rows (`Q-6`, `Q-7`, `Q-8`, and the `Q-4`-status row).
- **`J-architect_docs_lead-0044`'s landed artefacts**, read at the source rather
  than through the dispatch's summary — the four §13 rows in full and verbatim,
  each read as the ruling it is rather than as a description of one.
- **`docs/specs/requirements.md` at HEAD**: §0.4 whole (both the **Structural
  modules** paragraph, which is the domain the `Q-7` cure is checked against, and
  the line-rate-bench paragraph, which contains the near-collision recorded in
  Reasoning 3), §0.5's q-paragraph group and **Word delay ΔC** bullet list whole,
  the **Start lanes** paragraph, and the REQ-016 and REQ-206 rows in full.
- **The five transmit-chain leaf §7s, read as the source of every figure below and
  not as a check on the rows**: `xgmii_tx_64.md` (M04), `eth_axis_tx.md` (M07),
  `eth_arb_mux.md` (M09), `ip_eth_tx_64.md` (M15), `udp_ip_tx_64.md` (M18); plus
  `arp_eth_tx.md` (M11) as the leaf-clause completeness check.
- **The four structural §7s**: `eth_mac_10g.md` (M05, the cured file — §7 whole
  including its **Handshake rules** bullet), `ip_complete_64.md` (M16),
  `udp_complete_64.md` (M19), `nic_top.md` (M20) — each read for its own
  pins-nothing guard and its own statement of which children compose it.
- **My own `J-dv_lead-0182` whole** — §5 (`Q-6` as filed, with the cure I
  specified), §6 (`Q-7` as filed), §9 (`Q-8` as filed, with the cure I specified),
  §10 (the `Q-4` concurrence) and its Open-questions 1–9.
- **My own instruments and attack plans, read as their owner**:
  `test/monitors/octet_time.{ml,mli}` and its test, `test/xgmii/idle_injection.ml`
  and `.mli`, `test/attack_plans/AP-xgmii_tx_64.md` §5, §6's REQ-016 row and §5
  item 11(a).
- **Not read**: `libs/**`, `top/**`, `bin/**`, `rtl_snapshots/**`,
  `test/third_party/**`, `site/**`, `tasks/BOARD.md`, the auditor's journal.
  **No RTL reached this round.** Every quantity below is derived from a
  specification, checked against a second specification, and re-checked by
  arithmetic in a throwaway script whose output is in Evidence. **No
  Essenceia/Nasdaq-HFT-FPGA material consulted.**

### Reasoning

#### 1. The standard this round is held to, which the dispatch set and I would have set anyway

The dispatch says *verify the carried values at the partitions yourself*. That is
the right instruction and it names the failure mode exactly: both cures were
written from my own filings, both quote my own arithmetic back at me, and a signer
who recognises his own numbers stops computing. So **no figure below is read from
a §13 row or from my own prior entry**. The five leaf constants are taken from the
five leaf §7s; the composite insertions are taken from the wrapper §7s; every carry
is recomputed from those, in both forms of the formula, at **seven** partitions —
the five the cure states or implies, plus two the cure does not name, because a
claim about *which* partitions exist is only as good as the enumeration behind it.

One consequence of computing rather than remembering is the measurement in
Reasoning 2 that neither the filing nor the ruling contains: the `Q-6` cure's own
worked instance was **not derivable from the corpus** until the `Q-8` cure landed
beside it in the same commit.

#### 2. `FINDING Q-6`'s cure — COUNTERSIGNED, on carries re-derived, plus one interlock and one seam

The bullet now says the correction is *"a property of the decomposition summed
over and not of the composite"*, that it is *"stated with the partition it is taken
over or it is not stated at all"*, that it vanishes where Σ qᵢ < 8 **over the
partition in hand**, and it names M19 as the worked instance with both of its
values, M16 with its one, and M20 with both of its.

**The five carried values, each re-derived from the leaf §7s** (the full table is
in Evidence; q(composite) is the wrapper's own insertion mod 8, taken from its §7):

| composite | partition | Σ qᵢ | Σ ΔCᵢ | carry | ΔC(composite) | text says |
|---|---|---|---|---|---|---|
| M19 | {M18, M16} | 2 | 7 | **0** | 7 | 0, *7 = 7 + 0* ✔ |
| M19 | {M18, M15, M09, M07} | 10 | 6 | **1** | 7 | 1, *7 = 6 + 1* ✔ |
| M20 | {M19, M05} | 2 | 9 | **0** | 9 | 0 ✔ |
| M20 | five leaves | 10 | 8 | **1** | 9 | 1, *9 = 8 + 1* ✔ |
| M16 | {M15, M09, M07} | 10 | 5 | **1** | 6 | 1, *5 against 6* ✔ |

All five are correct, in both forms of the correction and against the direct
(L + h − q)/8 of the composite. **M16's single value is right for a reason the text
gets right by naming the partition rather than by luck**: M16's transmit chain
contains no composite, so it has exactly one partition, and *"over its three
leaves"* is the partition statement the cure's own rule demands. The two partitions
the text does not name — M20 over {M18, M16, M05} (carry 0) and M20 over its four
leaves with M05 standing in for M04 (carry 1) — both close at 9, so the enumeration
is incomplete-by-choice and not wrong.

**The interlock, which is this round's one new measurement.** The row
*"M20 carries 0 over {M19, M05}"* asserts ΔC = 2 at M05's transmit port pair. Until
this same commit, SPEC-M05 §7 pinned *"its transmit-port constant is M04's, 8 octet
times"* — and a reader taking that as L computes ΔC = (8 + 0 − 0)/8 = **1**, so the
partition returns **8** against the true 9 and the published instance contradicts
its own components. Measured:

    M20 <- {M19,M05}  with M05 read at the CURED §7 (L 16, dC 2):  9 = 9 + 0   OK
    M20 <- {M19,M05}  with M05 read at the STRUCK §7 (L 8,  dC 1):  8 = 8 + 0   MISMATCH

So the `Q-6` row's worked instance is **true independently of `Q-8`** — M05's
constants are M04's as a matter of fact, because M05 adds zero — but it was **not
checkable against the corpus** until `Q-8`'s cure landed. The two cures are
mutually load-bearing and landing them in one commit was necessary, not tidy. I
record it because the alternative — curing `Q-6` in one round and `Q-8` in the
next — would have published, for the duration, a worked instance that a diligent
reader could refute from a frozen module specification, which is the precise
failure the whole `C-RL-8` arc exists to prevent.

**One seam, recorded and deliberately NOT filed.** The cure's closing sentence says
*"M16, M19 and M20 pin no constant in their own §7s … so the leaf partition is the
only route the module specifications offer to their composites"*. I read all three
§7s at this head and the premise holds in terms (M16: *"this section pins no
per-octet constant across M16's transmit ports"*; M19 and M20 the same in their own
words). But the **conclusion** is now one member loose, by the action of the
`Q-8` cure in the same commit: M05 *does* pin its transmit constants from
`2b30ffc`, so `{M18, M15, M09, M07, M05}` is a second buildable route to M20. It
carries the **same** Σ qᵢ = 10, the same Σ ΔCᵢ = 8 and the same correction 1, because
M05's transmit row is M04's relayed — so every buildable route to every composite
still carries the correction, which is the sentence's whole point. Not a defect,
not filed, and recorded here rather than swallowed so that a later reader who
notices the second route does not mistake it for one the cure missed.

**VERDICT — `FINDING Q-6`'s cure: COUNTERSIGNED**, narrowly and in every part: the
decomposition-relative clause, the *stated-with-its-partition-or-not-stated* rule,
the five carried values, and the today-clause. Nothing withheld.

#### 3. `FINDING Q-7`'s cure — COUNTERSIGNED, with the method clause tested rather than accepted and the added distinction checked against the new table

Three things were commissioned or added, and each is checked separately.

**(a) The enumeration is §0.4's own set.** §0.4's **Structural modules** paragraph
names *"M05 `Eth_mac_10g`, M16 `Ip_complete_64`, M19 `Udp_complete_64` and M20
`Nic_top`"*. The amended sentence names those four, at those values (three at
q = 2, M05 at 0), and states that all four carry 0 across their receive port pairs.
Set-equal. ✔ **The leaf clause is re-checked for the same defect**, because a
finding about one quantifier is worth nothing if the neighbouring quantifier has
it too: the Phase-1 transmit leaves are M04, M07, M09, M11, M15 and M18, and
*"every leaf transmit port pair except M07 and M15"* is correct at all six —
M11 is the one I had not checked before, and SPEC-M11 §7 states in terms that its
fourteen Ethernet header octets *"are **not** an insertion at this port … they
leave on the `hdr` record"*, so its q is 0 and the exception list is complete. ✔

**(b) Does the method clause actually make the sentence self-checking?** The clause
is *"this enumeration is taken from §0.4's own list rather than from the modules
whose q is non-zero"*. I take *self-checking* to mean the sentence carries the
procedure that would refute it, and it does: it names the authority document
section, it publishes a **cardinality** (*"§0.4's **four** structural modules"*)
that a re-checker can compare before reading a single name, and it names the
rejected key (the non-zero set) so that the next author cannot re-derive the
enumeration the way both prior surveys did. That is the strongest form available in
prose, and it is what my filing asked for. ✔

**One suggestion, recorded and NOT filed as a finding.** §0.4 contains a *second*
list of structural modules, in its line-rate-bench paragraph: *"Structural wrappers
M05, M16 and M19 are covered by their children's benches"* — a **three**-member
set. So *"§0.4's own list"* resolves to the right paragraph by the count "four"
rather than by name. I do not file it, and the reason is the honest one rather than
forbearance: the near-collision set is `{M05, M16, M19}`, which is **not** the
`{M16, M19, M20}` the finding convicted, so a re-checker who lands on the wrong
paragraph gets a visible discrepancy and is forced back, never a false
confirmation. If the sentence is ever touched again, *"§0.4's **Structural
modules** paragraph"* makes the self-check point-blank and costs two words.

**(c) The added clause beyond my cure — M05's licensed pin — is TRUE against
SPEC-M05 §7's new table, on two independent grounds.** The clause says M05 *"does
pin its transmit-port constants, which is licensed and not an exception — they are
its child's unchanged, its q is 0, and its §7 names the event delay and the latency
separately"*. Checked limb by limb against the table `2b30ffc` landed: all four
rows are attributed *"M04's, relayed"* ✔; q = 0 is stated in the table ✔; the event
delay (8 octet times) and L (16) appear as separate named rows ✔. And **licensed**
is right twice over, where the ruling states it once: §0.5's prohibition binds a
specification pinning a constant *"across such a port pair"* — one whose insertion
is **not** a whole number of words — and M05's insertion is eight octets, one whole
word, so the prohibition **does not reach the port at all**; and even where it did,
M05 states its q, which is the condition the prohibition attaches. The second
ground matters because it is the one that survives if a later revision of M04
changes its insertion.

**VERDICT — `FINDING Q-7`'s cure: COUNTERSIGNED**, narrowly: the four-member
enumeration is §0.4's own set, the method clause is self-checking in the operative
sense, the leaf clause is re-verified complete at six leaves, and the added
licensed-pin distinction is true against the new table on two grounds.

#### 4. `FINDING Q-8`'s no-countersignature classification — UPHELD for the two elements it names, NARROWED at a third it does not reach, and the practice settled rather than assumed

The row asks the question straight: *"If dv reads a post-freeze §7 diff as owing a
countersignature **regardless** of whose figures it lands, this row is where to say
so and the practice should be settled rather than assumed."*

**I do not read it that way, and the classification is upheld as to what it names.**
The `Q-5` precedent is correctly applied to the two-figure table and to the
struck-reading quotation: every figure there is either my own derivation in the
filing (8 as the event delay, 16 as L, the refutation from *"zero octet times
added"*) or SPEC-M04 §7's already-countersigned text relayed unchanged (h = 0,
ΔC = 2). A countersignature on my own arithmetic returned to me verifies nothing
that the filing did not already verify, and manufacturing one would make the
signature a formality — which is the thing that destroys it as an instrument.

**But the diff landed a third element the classification does not reach, and I
would not have signed the row without saying so.** The `Q-8` cure also added:

> *"**Pinning L here is not an idle-injection licence.** REQ-016's idle tolerance
> does not extend to this port … so no bench may build a REQ-016 injection wrapper
> at M05's transmit source interface and measure L across it."*

That is **not text I wrote** and it is **not a figure**: it is a prohibition
binding on the DV line, in the normative basis my benches are derived from. The
right rule is not about where a diff lands but about whom it binds, so I state it
in the general form the architect asked for:

> **A post-freeze §7 diff owes dv_lead no countersignature when every figure it
> lands is the signer's own derivation or another specification's countersigned
> figure relayed unchanged — that is `Q-5`'s precedent and it is right. It owes one
> when the diff lands a clause that constrains a party other than its author: a
> prohibition, a licence, or a scope on what a bench may assert. The value of the
> countersignature there is not arithmetic, which the filing already did, but
> whether the guard is *exactly* the rule rather than wider than it — and that is a
> question only the constrained party can answer.**

The test is on the clause's class, not on the file, not on post-freeze status and
not on who filed the finding. This chain has convicted a guard for being too wide
before (the W = 2 conversion rule, `J-dv_lead-0176`), which is why the distinction
is worth minting rather than waving at.

**And I sign the clause here, so the practice question and the clause do not need a
further round between them.** Four checks:

1. **It is narrower than its parent, never wider.** SPEC-M04 §7 states *"A bench
   SHALL NOT build a REQ-016 idle-injection wrapper at this module's source
   interface"* — unconditional. M05's adds *"and measure L across it"*. So it
   excludes strictly less than M04's clause already excludes, and no conformant
   bench is newly forbidden.
2. **No gap opens under the narrowing**, because M05's own **Handshake rules**
   bullet carries the unconditional half: *"`tx_tready` is M04's and REQ-016's idle
   tolerance does not extend to it (SPEC-M04 §7)"*. The pair is coherent: the
   general prohibition sits in the handshake bullet, and the latency bullet closes
   the specific inference *L is pinned here, therefore I may assert it under
   injection* — which is exactly the inference the newly-pinned L invites.
3. **It does not collide with the one bench that is REQUIRED at that port.**
   REQ-206's own verification column commissions *"Stall the source for exactly one
   required cycle mid-frame"* — at the same interface. That is a REQ-206 directed
   stimulus, not a REQ-016 wrapper, and it measures an error character and a strobe,
   not L, so the clause misses it on both of its conjuncts. A DV reader's first fear
   on meeting this clause is that his underflow bench was just prohibited; it was
   not, and I record the check because the clause does not say so itself.
4. **It closes a real under-determination rather than restating one.** REQ-016's
   normative carve-out names the interface by **component**: *"This does not apply
   to `Xgmii_tx_64`'s source interface"*. REQ-016's **verification column**
   commissions an injection wrapper *"at each module boundary"* and does not repeat
   the carve-out. M05's transmit source is M04's interface under a different port
   name — so at that boundary the two columns under-determine each other, and a
   bench author working from the column alone injects into an underflow and
   measures a frame the injection destroyed. The clause is the carve-out read down
   to the wrapper port. It is the most useful sentence in the diff for my own line.

**VERDICT — `Q-8`'s classification: NOT BOUNCED, and NARROWED.** No countersignature
was owed on the two-figure table or the struck-reading quotation, and none is paid
for them. One was owed on the idle-injection clause, on the class test above; it is
**COUNTERSIGNED here**, on the four checks, so nothing is left outstanding and the
architect owes no further round on `Q-8`.

#### 5. Nothing red, re-measured at this head rather than carried forward

Both cures' *nothing was built on it* grounds rest on measurements of mine, and a
measurement quoted from last round is a memory. Re-run at `2b30ffc`:

- **No committed instrument computes a wrapper composite.** `word_cycles` has
  **14** hits under `test/` and `tools/`, all inside `test/monitors/octet_time.ml`,
  its `.mli` and its own test — unchanged in count and in location from `43c0087`.
  `Octet_time.`'s only external customers remain M03's benches
  (`test/xgmii/test_arrival.ml`, `test/xgmii/idle_injection.mli`), calling
  `Latency.frame_in/frame_out/report` on a **leaf** with q = 0. ✔
- **No committed test computes an M05 constant.** `eth_mac_10g` appears twice in
  `test/`: `AP-xgmii_tx_64.md` §5 (a loopback candidate) and
  `test/cosim/tb_xgmii_rx_64.v` (a comment naming the reference's own files).
  Neither is a latency claim. ✔
- **No committed bench builds an injection wrapper at any transmit source**, so
  the new prohibition forbids nothing that exists: `test/xgmii/idle_injection.ml`'s
  only customers are M03's family-I benches (a receive-side module), and
  `AP-xgmii_tx_64.md` §6's REQ-016 row already records *"No instance at this
  interface"* with §5 item 11(a) rejecting an injection wrapper at M04's source in
  terms. **The bench side already agreed with the clause before the clause
  existed**, which is the strongest evidence that it is the rule and not a
  widening. ✔

### Actions

1. Ran the abort-first precheck; both outputs matched the dispatch exactly. Read
   HEAD again before writing: moved to `60c1ccf` with `tasks/BOARD.md` dirty, both
   inside declared sibling lanes; ran the re-verification clause, confirmed every
   read surface byte-unchanged, proceeded against `2b30ffc` as dispatched.
2. Read the charter and PROTOCOL in full, then `git show 2b30ffc` whole, then the
   four §13 rows verbatim, then §0.4 and §0.5 at HEAD.
3. **Re-derived all five leaf constants from the five leaf §7s** and both wrapper
   insertions from the wrapper §7s, taking nothing from a §13 row or from my own
   prior entry.
4. **Recomputed the correction at seven partitions** in both forms of the formula
   and against the composite's direct (L + h − q)/8 — the five the cure states, plus
   the two it does not name — and **countersigned `FINDING Q-6`'s cure**.
5. **Measured the interlock**: recomputed M20 over {M19, M05} with M05 read at its
   struck §7, obtaining 8 against the true 9, establishing that the `Q-6` cure's
   published instance was not corpus-checkable until the `Q-8` cure landed beside it.
6. **Checked the `Q-7` enumeration against §0.4's own paragraph**, re-verified the
   **leaf** clause at all six transmit leaves including M11 (which I had not checked
   before), tested the method clause against an operational reading of
   *self-checking*, verified the added licensed-pin distinction against SPEC-M05 §7's
   new table on two grounds, and **countersigned the cure**.
7. **Recorded two seams and filed neither** — the second buildable route to M20
   created by the `Q-8` cure, and §0.4's three-member near-collision list — each
   with the reason it is not a defect.
8. **Answered `Q-8`'s classification question with a class test**, upheld the
   no-countersignature ruling for the two elements it names, and **countersigned the
   idle-injection clause** on four checks, including that it does not reach REQ-206's
   own commissioned stimulus at the same port.
9. **Re-measured all three *nothing red* grounds at this head** rather than quoting
   them from `43c0087`.
10. Re-derived every figure in a throwaway script (Evidence), outside the repository
    and not staged.
11. Wrote this entry. **No `docs/**` file touched** — transcription is the
    orchestrator's clerical act. **No `git add`, no `git commit`, no `git push`, no
    git write of any kind**, and no stop-hook commit demand was honoured.

### Evidence

Reproducible from a checkout at this commit unless stated otherwise.

**Precheck, the head move, and the re-verification.**

    git status --short              # at entry: empty; before writing: " M tasks/BOARD.md"
    git rev-parse HEAD              # at entry: 2b30ffc808b0e5578ff88839fa813b2a5d4da29e
    git rev-parse HEAD              # before writing: 60c1ccf48c4e7c3ba1b844f756ae8d6b8149467e
    git log --oneline 2b30ffc..HEAD # 60c1ccf, one commit (auditor)
    git diff --name-only 2b30ffc HEAD   # agents/journals/claude_auditor_agent.v02.md
    git diff 2b30ffc HEAD -- docs/specs/ test/ tools/ agents/handoffs/ \
        docs/reports/latency/ docs/gates/ \
        agents/journals/claude_dv_lead_agent.v10.md \
        agents/journals/claude_architect_docs_lead_agent.v04.md      # empty
    date -u                         # Tue Aug 11 17:01:41 UTC 2026

**The leaf constants, each read at its own §7 and not at a §13 row:**

| leaf | insertion I | L | h | q = I mod 8 | ΔC | source |
|---|---|---|---|---|---|---|
| M04 `Xgmii_tx_64` | 8 | 16 | 0 | 0 | 2 | SPEC-M04 §7 table (event delay 8 octet times stated separately) |
| M07 `Eth_axis_tx` | 14 | 22 | 0 | 6 | 2 | SPEC-M07 §7 table |
| M09 `Eth_arb_mux` | 0 | 0 | 0 | 0 | 0 | SPEC-M09 §7 (*"zero cycles added"*, combinational datapath) |
| M15 `Ip_eth_tx_64` | 20 | 28 | 0 | 4 | 3 | SPEC-M15 §7 table |
| M18 `Udp_ip_tx_64` | 8 | 8 | 0 | 0 | 1 | SPEC-M18 §7 (1 cycle, both events at octet position 0; *"exactly one more word than it consumes — the UDP header"*) |
| M11 `Arp_eth_tx` | 0 at this port | 8 | 0 | 0 | 1 | SPEC-M11 §7 table (*the 14 header octets "are **not** an insertion at this port"*) |

Composite insertions from the wrapper §7s: M16 34, M19 42, M20 50 → q = 2 at all
three. M05's transmit port pair: insertion 8 (its child's), q = 0, L 16, ΔC 2
(SPEC-M05 §7 as cured at `2b30ffc`).

**The correction at seven partitions, both forms, against the direct value:**

    M16 <- {M15,M09,M07}         sum_q=10 sum_dC= 5 q(comp)=2 carry=1 form1=6 form2=6 direct=6 OK
    M19 <- {M18,M16}             sum_q= 2 sum_dC= 7 q(comp)=2 carry=0 form1=7 form2=7 direct=7 OK
    M19 <- {M18,M15,M09,M07}     sum_q=10 sum_dC= 6 q(comp)=2 carry=1 form1=7 form2=7 direct=7 OK
    M20 <- {M19,M05}             sum_q= 2 sum_dC= 9 q(comp)=2 carry=0 form1=9 form2=9 direct=9 OK
    M20 <- {M18,M16,M05}         sum_q= 2 sum_dC= 9 q(comp)=2 carry=0 form1=9 form2=9 direct=9 OK
    M20 <- 5 leaves (w/ M04)     sum_q=10 sum_dC= 8 q(comp)=2 carry=1 form1=9 form2=9 direct=9 OK
    M20 <- 4 leaves + M05        sum_q=10 sum_dC= 8 q(comp)=2 carry=1 form1=9 form2=9 direct=9 OK

form1 = Σ ΔCᵢ + (Σ qᵢ − q(comp))/8, form2 = Σ ΔCᵢ + ⌊Σ qᵢ/8⌋, direct =
(L + h − q)/8 of the composite. Rows 2 and 3 are one module at two partitions with
different carries, which is `Q-6`'s whole content; rows 6 and 7 are the two
buildable leaf routes to M20 and agree.

**The interlock measurement** (Reasoning 2), the same script with M05 read at its
struck §7 sentence:

    M20 <- {M19,M05} with M05 at the CURED §7  (L 16, dC 2):  9 = 9 + 0   OK
    M20 <- {M19,M05} with M05 at the STRUCK §7 (L  8, dC 1):  8 = 8 + 0   MISMATCH

**The three pins-nothing guards, read at HEAD** (the premise of the cure's
today-clause): SPEC-M16 §7 *"this section pins no per-octet constant across M16's
transmit ports"*; SPEC-M19 §7 *"this section pins no per-octet constant across
M19's transmit ports"*; SPEC-M20 §7 *"this section pins no per-octet constant
across M20's transmit ports"*. All three present, all three in terms.

**`Q-7`'s two domains, at the source**: §0.4's **Structural modules** paragraph
names M05, M16, M19, M20 (four); §0.4's line-rate paragraph names M05, M16, M19
(three) in a different quantifier — the near-collision of Reasoning 3. The amended
census sentence names the first set.

**`Q-8`'s clause and its parents, at the source**: SPEC-M04 §7 *"A bench SHALL NOT
build a REQ-016 idle-injection wrapper at this module's source interface"*;
REQ-016's normative row *"This does not apply to `Xgmii_tx_64`'s source interface,
where a missing word after transmission has begun is an underflow (REQ-206)"*;
REQ-016's verification column *"Idle-injection wrapper around any directed bench …
at each module boundary"* (no carve-out repeated); REQ-206's verification column
*"Stall the source for exactly one required cycle mid-frame"*; SPEC-M05 §7's
**Handshake rules** *"`tx_tready` is M04's and REQ-016's idle tolerance does not
extend to it"*.

**The three *nothing red* measurements, re-run at this head:**

    grep -rn "word_cycles" test/ tools/ --include=*.ml --include=*.mli | wc -l   # 14
    grep -rln "word_cycles" test/ tools/ --include=*.ml --include=*.mli
    # test/monitors/octet_time.ml, test/monitors/octet_time.mli, test/monitors/test_octet_time.ml
    grep -rn "Octet_time\." test/ tools/ --include=*.ml --include=*.mli | grep -v test/monitors/
    # test/xgmii/test_arrival.ml (Latency.create/frame_in/frame_out/report/observed/is_clean),
    # test/xgmii/idle_injection.mli (a doc comment naming frame_in)
    grep -rln "eth_mac_10g\|Eth_mac_10g" test/ tools/
    # test/cosim/tb_xgmii_rx_64.v, test/attack_plans/AP-xgmii_tx_64.md
    grep -rln "ip_complete\|udp_complete\|nic_top\|Nic_top" test/ tools/
    # test/attack_plans/AP-ip_eth_rx_64.md (prose), tools/check_emitted_verilog.sh (REQ-017 ports)

**Nothing in this entry is a verification result about any module**, and no `SO-`
is opened or offered. No RTL, no bench and no `libs/**` file was read. `dune` was
not invoked and no claim here depends on it (ADR-0005). Every arithmetic claim
above is checkable by a reader with `requirements.md` §0.4/§0.5 and the six leaf
§7s and four structural §7s named in Inputs, and no toolchain.

**Journal size**: v10 stands at 105,563 bytes before this entry, against
`JOURNAL_SOFT_MAX` 262,144 (ADR-0017 §5). No rotation.

### Outcome

**DoD met on the single act, and on the optional one the dispatch opened.**

| item | verdict |
|---|---|
| **`FINDING Q-6`'s cure** — the decomposition-relative clause, the worked instance, the today-clause | **COUNTERSIGNED**, narrowly and whole. All five carried values re-derived from the leaf §7s at seven partitions in both forms; M19 {M18,M16} = 0 and four leaves = 1; M20 {M19,M05} = 0 and five leaves = 1; M16 = 1. The three pins-nothing guards re-read at HEAD |
| **`FINDING Q-7`'s cure** — the four-member enumeration and its method clause | **COUNTERSIGNED**, narrowly. Set-equal to §0.4's **Structural modules** paragraph; the method clause is self-checking in the operative sense (named authority, published cardinality, named rejected key); the **leaf** clause re-verified complete at six leaves incl. M11 |
| the added **M05 licensed-pin distinction** (beyond my cure) | **COUNTERSIGNED** — true against SPEC-M05 §7's new table limb by limb, and *licensed* on two independent grounds where the row states one |
| **`FINDING Q-8`'s no-countersignature classification** | **UPHELD, not bounced**, for the two-figure table and the struck-reading quotation — `Q-5`'s precedent is correctly applied and I pay no signature there. **NARROWED**: it does not reach the diff's third element |
| the **idle-injection clause** at SPEC-M05 §7 | **COUNTERSIGNED here**, on four checks — narrower than its parent, no gap under the narrowing, no collision with REQ-206's own commissioned stimulus, and it closes a real under-determination between REQ-016's two columns |

**Both cures are IN FORCE without qualification**, as they were meanwhile. **No
finding is filed this round** — a first for this arc, and worth saying plainly: two
seams were found and both were adjudicated non-defects with their grounds recorded
(the second buildable route to M20, §0.4's three-member near-collision), and one
two-word suggestion is offered for whenever the census sentence is next touched.

**One rule is minted and offered for the record**, answering the question the `Q-8`
row asked: *a post-freeze §7 diff owes dv_lead no countersignature when every
figure it lands is the signer's own derivation or another specification's
countersigned figure relayed unchanged; it owes one when it lands a clause that
constrains a party other than its author.* The test is the clause's class, not the
file, not post-freeze status, and not who filed the finding.

Handoff: **journal-only**. The verdicts above go to `requirements.md` §13 and, for
the idle-injection clause, to `eth_mac_10g.md` §13, as the orchestrator's clerical
transcription with this entry as their authority. **No file outside this journal is
staged, and my mechanics require no handoff file** — a countersignature of this
class is a journal-entry signature block, per `J-dv_lead-0180`, `J-dv_lead-0181`
and `J-dv_lead-0182`, and `docs/**` transcription is not mine to write.

**Lessons-harvest note** (ADR-0018, PROTOCOL §7). **Not owed this round** — §7
attaches the harvest to an `SO-` and to a phase gate, and this round is neither;
declared rather than omitted. The span opened after `J-dv_lead-0181` runs and this
entry joins it; the thirteen candidates banked through `LH-0182-2` carry forward
unchanged. **Three candidates banked, LH1–LH3 discharged:**

- **`LH-0183-1`** — *When one round cures two coupled sites, re-check each cure's
  worked instance at the head that carries them all rather than at the head it was
  filed against: a statement about a composite is only checkable once the component
  document it is checked against has itself been corrected.* **LH2-g**: no proper
  noun; the observable is that a cure's evidence chain is re-run at the composite
  head. **LH1**: this round — the published instance *"the correction is 0 over
  {parent, child}"* returns the wrong total when the child's own document is read at
  its pre-cure text, and both cures landed in one commit. **LH3**: without it, a
  round can ship a cure whose worked instance a diligent reader refutes from a
  frozen sibling document, and each cure looks right when checked alone.
- **`LH-0183-2`** — *Where a requirement states a carve-out by naming a component
  and states the corresponding verification duty by naming a port class, the two
  under-determine each other at any wrapper port that is the named component's port
  under another name; the guard belongs at the wrapper, not only at the component.*
  **LH2-d** (domain pack: specification-and-verification practice — no project
  noun, but *requirement*, *verification duty* and *port* are domain nouns).
  **LH1**: this round's countersignature of the idle-injection clause, where the
  normative carve-out names one component and the verification column commissions a
  wrapper *at each module boundary*. **LH3**: without it, a bench author working
  from the duty alone builds the exact stimulus the carve-out excludes, and measures
  a frame the stimulus destroyed.
- **`LH-0183-3`** — *Key a review obligation on whom a change binds, not on where it
  lands: a location test exempts a prohibition that constrains a third party while
  demanding signatures on figures the reviewer himself supplied.* **LH2-g**: no
  proper noun; the observable is that the reviewing party is chosen by the class of
  clause rather than by the document section. **LH1**: this round's `Q-8`
  classification, upheld for two elements and narrowed at a third. **LH3**: without
  it, review effort is spent re-checking one's own arithmetic while the clauses that
  constrain other teams land unread.

**No escalation.** **E5 not triggered** — no disagreement between leads survives
this round; the classification question is answered with a rule rather than
contested, and no finding is filed. **E2 not triggered** — no requirement, phase or
role added or dropped; no value, ceiling, allocation or §1.1 row moves under either
cure. **E3 not triggered** — no toolchain or licensing surface reached.

### Open-questions

1. **A two-word suggestion, offered and not filed**: when §0.5's census sentence is
   next touched, *"§0.4's own list"* → *"§0.4's **Structural modules**
   paragraph"*. §0.4 carries a second, three-member structural list in its
   line-rate-bench paragraph, so the self-check currently resolves by the published
   count rather than by name. Not a defect — the near-collision set differs from the
   convicted set, so a mis-landing produces a discrepancy and not a false
   confirmation. **Route**: architect_docs_lead, at its convenience.
2. **The `Q-6` cure's today-clause is one member loose from `2b30ffc` onward**, by
   the action of the `Q-8` cure in the same commit: M05 now pins its transmit
   constants, so a second route to M20 exists beside the five-leaf one. Both carry
   correction 1 and both close at 9, so the sentence's conclusion holds under every
   buildable route. Recorded, not filed.
3. **My recommendation on the wrapper composites stands and its precondition is now
   met**: pin all three (L = 50/58/74, h = 0, q = 2, ΔC = 6/7/9) at the round that
   closes ledger item 67. `Q-6`'s cure has landed, which was the condition I
   attached at `J-dv_lead-0182` Open-question 4.
4. **Ledger item 53's residue** is unchanged and still has exactly one live
   instance — M05 at a lane-4 start — which the `Q-8` cure does not touch, its
   table being the transmit port pair. Carried from `J-dv_lead-0182` item 5.
5. **The insertions-add premise** remains unstated at what are now four statements
   (the wrapper clause, the closure consequence, the additivity correction, and the
   cure's decomposition clause). Still inherited, still unfalsifiable in Phase 1 by
   construction, still item 50's. Carried from `J-dv_lead-0182` item 6.
6. **`DVC-1a` remains unbuilt** and every attack-plan count I quote remains a hand
   count with its method stated. It must land before any `SO-` quotes an M04
   coverage fraction. Carried from `J-dv_lead-0181` item 7, unchanged.
7. **The whole-suite verdict is still CI's** (ADR-0005). This round touched no file
   under `test/`, so nothing in it can move a suite result; the `9a596e7` repair's
   CI adjudication is still open.

### Files-in-this-commit
- (none)

## [J-dv_lead-0184] 2026-08-11T17:17Z | task:none | The two surplus mut/ branches named and both benign — a voided class and a negative control, each ruled at the time in its own committed verdict — and the finding the reconciliation turns up is mine: the era tally's sealed column drops a SEEDED class and keeps an UNSEEDED one, on two grounds it never states, and G-1's amendment is written against the word that hides it

### Trigger

Orchestrator dispatch, **one round, one act**: reconcile the `mut/`-branch
arithmetic the auditor could not close at `J-auditor-0020` Open-question 4, which
names me as owner ("the score") and states the reconciliation is owed *before* the
`P1-module-ready` gate reads the tally. The dispatch commissions naming the two
surplus branches, classifying each, stating which figure the gate reads and why the
two figures differ, and reconciling against my own campaign scorecards — with the
instruction that an unrecorded seeding on a surplus branch is a finding against my
own score at whatever severity the facts support, and that a benign result makes the
reconciliation note itself the deliverable.

**Abort-first head check, before reading anything.**

    git status --short              # zero lines
    git rev-parse HEAD              # de3c56059eee62fa6315fef0764d66e85e2cde78
    git rev-parse --abbrev-ref HEAD # claude/fpga-hardcaml-agent-orchestration-37ceyf

Byte-equal to the dispatched expectation `de3c560`, tree clean. Neither branch of
the abort procedure was reached, and no dirty path in any lane had to be
adjudicated against the declared siblings (architect_docs_lead drafting the §7/§10
amendment; the orchestrator's own journal/board/site). HEAD did not move across the
round: re-verified at authoring time, still `de3c560`, still clean.

### Inputs

- `agents/charters/dv_lead.md`; `agents/PROTOCOL.md` (§3, §4, §5, §6, §7, §10 —
  §7's `P<n>-module-ready` row and §10's mutation-discipline clause are the two
  texts the "which figure does the gate read" question turns on).
- `agents/journals/claude_auditor_agent.v02.md` — `J-auditor-0020` **Open-question 4
  read at the source, in full**, plus its Outcome section for the routing sentence.
  Also `J-auditor-0018`, `-0019` headers for volume orientation, and volume 01
  `J-auditor-0004 … -0017` headers for the per-campaign seeding stamps.
- `tasks/BOARD.md` — the **Transient-ref inventory** block (line 84) and the campaign
  rows for `WO-0050`, `0055`, `0058`, `0061`, `0063B`, `0066`, `0073`, `0074`,
  `0076`, `0077` (lines 96–121).
- `agents/handoffs/WO-0061_family-i-mutation-campaign.md` — the verdict's disposition
  table (line 738) and its scoring summary (line 1139).
- `agents/handoffs/WO-0063B_m03-i2-report-path-campaign.md` — §2 IC-2 control
  sections (lines 458, 475, 562, 576, 779).
- `agents/handoffs/WO-0073_family-l-mutation-campaign.md` (searched whole for an era
  tally; there is none), `WO-0074_family-m-mutation-campaign.md` §12 (lines
  1740–1758), `WO-0076_family-j-mutation-campaign.md` §12 (line 2274),
  `WO-0077_family-k-mutation-campaign.md` (lines 1449, 2010).
- `agents/handoffs/SO-xgmii_rx_64.md` §2.2-M (lines 763–800) — my own re-walk table
  and its stated method.
- `docs/gates/P1-module-ready-checklist.md` line 517 — the `G-1` row as written.
- Auditor manifests: `docs/reports/audit/WO-0050-mutations/` … `WO-0077-mutations/`
  READMEs and their committed `.diff` files, specifically
  `WO-0063B-mutations/ic-2.diff` (compared byte-for-byte against a branch),
  `WO-0061-mutations/README.md` (the I-c1 hunk, compared line-for-line against a
  branch), `WO-0074-mutations/README.md` §3.5 and its branch table,
  `WO-0077-mutations/README.md` §2.8/§2.9.
- **The remote ref graph and the commit metadata of all 64 class-era `mut/`
  branches** — this round's explicit commission and the one read I would otherwise
  not have. **No branch was merged, checked out, or allowed to reach the working
  tree**; every branch was fetched into a throwaway `refs/mutinspect/*` namespace,
  read with `git diff`/`git log`, and the namespace was deleted before this entry was
  written, so no mutated RTL is reachable from any local ref.
- **No RTL source read for test derivation.** The only RTL bytes I read are the
  mutation hunks themselves, read as *identity evidence* — "is this branch the diff
  the manifest says it is" — never as a basis for a test, and the module is one
  already signed off. Recorded here explicitly because §10's independence discipline
  makes the disclosure, not the abstinence, the audit evidence.

### Reasoning

**The observation, restated precisely so the thing being reconciled is fixed.**
`J-auditor-0020` Open-question 4 asserts three numbers and one location: the remote
carries **87** `mut/` branches; the ten class-based campaigns account for **64**;
the era walk reports **63 sealed / 62 seeded**; and the seven campaigns entering
family M account for **43** branches against the walk's **41**, so the two-branch
surplus sits in the older group. It offers two candidate explanations — a re-cut
branch, or one class rendered on two branches — and files the whole thing as an
observation because `G-1` is a question about a denominator.

**Step 1 — I measured the ref population before adopting any of it, and the first
number is wrong.** `git ls-remote --heads origin 'refs/heads/mut/*'` returns **85**,
not 87. The board's inventory block says 85 and the board is right. The two-ref
difference is not a mystery and not a third and fourth surplus branch: an
unfiltered `git ls-remote --heads origin` returns **87** lines, of which the two
non-`mut/` lines are `refs/heads/main` and the working branch. The auditor read the
line count of the unfiltered listing as the `mut/` population. **This does not touch
the auditor's other figures** — its per-campaign counts were taken by prefix and
every one of the ten reproduces exactly against my own measurement, so 64 stands.
I record the correction because a 2 in the total and a 2 in the surplus invite a
reader to identify them, and they are unrelated.

**Step 2 — I refused to reason about the surplus from names and measured all 64
branches instead.** Both of the auditor's candidate explanations are testable
without opening a single campaign packet: a re-cut branch shows up as two refs with
the same or near-identical diff, and one class on two branches shows up as two refs
with identical diffs. So for every branch in all ten class campaigns I took the tip,
the merge-base against `de3c560`, the commit count over that base, the SHA-256 of
the full diff, and the set of files the diff touches. The result kills both
hypotheses outright:

- **All 64 diffs are distinct.** Zero collisions in the hash column. There is no
  duplicate render anywhere in the era, so no class is carried on two branches.
- **Every base is its campaign's declared base**, matching the auditor's own seeding
  entries one for one: `616686f` (`WO-0050`), `2e8994f` (`0055`), `a2d090d` (`0058`),
  `42b9df3` (`0061`), `c0595f9` (`0063B`), `199e319` (`0066`), `bbd4122` (`0073`),
  `ca1bb80` (`0074`), `8346a5c` (`0076`), `aced7b4` (`0077`). No branch is based off
  another branch, off `main`, or off a stale tree. **There is no stale branch.**
- **Sixty-three of 64 carry exactly one commit over their base.** The single
  exception, `mut/wo-0073-l3` at two commits, is a within-branch re-cut *already
  disclosed* by the auditor at `WO-0073-mutations/README.md` Q2 and named there with
  both SHAs. It is one branch for one class either way and contributes nothing to a
  branch surplus.
- **All 64 touch exactly one file**, `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`.
  Not one branch touches `test/**`, `agents/**` or `docs/**`. This is the check that
  matters most for the dispatch's finding condition: a seeding recorded nowhere would
  most plausibly show up as a branch reaching a bench or a seal, and none does.

So the surplus is **not a branch anomaly at all**. Every branch is a single-diff,
correctly-based, uniquely-rendered transient. The 43-vs-41 gap therefore cannot be
explained on the branch side, which means it must be explained on the *tally* side —
the two figures are counting different things, and the question is what the tally
declines to count.

**Step 3 — I re-derived the older seven campaign by campaign, from each campaign's
own verdict, and the gap closes exactly.** Branch counts against the sealed figure
each campaign's own adjudication records:

| campaign | branches | sealed classes in the tally | delta | why |
|---|---|---|---|---|
| `WO-0050` family F | 8 | 8 | 0 | `8/8` |
| `WO-0055` family G | 5 | 5 | 0 | `4/5` + survivor `G-c4` |
| `WO-0058` G7+H | 7 | 7 | 0 | `7/7` |
| `WO-0061` family I | 10 | **9** | **−1** | `I-c1` **VOID** |
| `WO-0063B` | 2 | **1** | **−1** | `IC-2` is a **control** |
| `WO-0066` family B/N | 6 | 6 | 0 | `6/6` |
| `WO-0073` family L | 5 | 5 | 0 | `5/5` |
| **total** | **43** | **41** | **−2** | |

Killed: 8 + 4 + 7 + 9 + 1 + 6 + 5 = **40**, survived **1**, and 40 + 1 = 41. Both
columns of the carried figure reproduce to the unit. **The two surplus branches are
named, and neither is a re-cut, a duplicate or a stale ref:**

**Surplus branch 1 — `mut/wo-0061-i-c1`**, tip `a4c7a04`, base `42b9df3`, one commit,
subject `MUTATION RUN i-c1 -- never merge`, diff `libs/hardcaml_ethernet/src/xgmii_rx_64.ml`
only, +15/−1. **Classification: a seeded class VOIDED as unscoreable.** `WO-0061`'s
verdict table rules it `VOID — NOT SEEDED AS SPECIFIED — scope report, 0 kills`, and
its scoring summary states `Classes seeded: 10. Branches red: 10 of 10. Scoreable
classes: 9`. The class shipped a real mutation, the branch ran, the suite went red on
it — on `T-F1`, `T-F2`, `T-G7`, with **all five I units green**, which is precisely
why it scores nothing: it reddened a bench, but not the bench the seal was written
against. The ground of the void is `FINDING A-1`, the program's first
disclosure-class finding against the auditor, accepted against itself at
`DISP-0001`. **Every added and removed line of the branch diff appears verbatim in
the committed manifest README**; the branch carries the recorded mutation and
nothing else.

**Surplus branch 2 — `mut/wo-0063b-ic2`**, tip `dbc4b0a`, base `c0595f9`, one commit,
subject **`MUTATION RUN WO-0063B/ic-2 (control) -- base c0595f9 + one diff -- never
merge`**, same single file. **Classification: a negative control, scoring zero by
design.** The word `control` is in the branch's own commit subject, in the campaign
packet's section heading, and in its scoring table: *"Kills: 0, by design. IC-2 is a
control and scores none."* Its purpose was to demonstrate `M03-I2` stays **green**,
which it did at all three members on both lanes. **The branch diff is
character-identical to the committed manifest `ic-2.diff`** — hunk bodies compare
with zero differences.

**Neither branch carries an unrecorded seeding.** Both are recorded in their
campaign's own committed verdict, both are byte- or line-identical to the auditor's
committed manifest, both were adjudicated to zero score *at the time* and not
retrospectively, and neither reaches a bench, a seal or a spec. The dispatch's
finding condition is **not met on the branches**, and on the branch question the
reconciliation note is the deliverable, exactly as the dispatch anticipated.

**Step 4 — the whole era, so the statement is not half a reconciliation.** The same
sweep over the newer three campaigns closes the auditor's other half, and in the
*opposite* direction. `WO-0074` cut **7** branches for **8** sealed classes: the
manifest states flatly *"No branch is cut for `IC-M5`, and no CI job is spent on
it"*, because `IC-M5` was declared to have no datapath-silent rendering at this
design. `WO-0076` is 5/5; `WO-0077` is 9/9 — and I checked the auditor's own
"one class on two branches" hypothesis against its most suggestive instance,
`n4a`/`n4b`: the manifest fixes the class list as nine including **`IC-N4a` and
`IC-N4b` as separate classes at separate sites**, the abort path and the report path.
Two classes, two branches. The complete identity:

    branches cut          64
      − I-c1  (void)      −1      seeded, red, unscoreable
      − IC-2  (control)   −1      seeded, green by design, scores nothing
      = seeded & scored   62      = 61 killed + 1 survived
    sealed classes        63      = 62 + IC-M5 (sealed, never seeded, no branch)
    and 61 + 1 + 0 + 1 =  63

**Every number in `J-auditor-0020` Open-question 4 now has a name attached to it, and
nothing is left over.**

**Step 5 — which figure the gate reads, and why the two differ.** The gate reads
**sealed classes with their disposition** — 63 / 61 / 1 / 0 / 1 — and **not**
branches-cut. Three grounds, none of them a preference:

1. **PROTOCOL §7's `P<n>-module-ready` row quantifies over *mutations*:** *"auditor's
   seeded mutations all killed by the DV suite."* §10 quantifies over *classes*:
   *"kills N/N (N ≥ 3, spanning distinct defect classes)."* Neither text mentions a
   ref. The scoring unit the constitution names is the class, and the authority for a
   class's disposition is its campaign verdict.
2. **A branch is a delivery vehicle, not a scoring unit.** §10's transient model has
   the orchestrator apply a manifest *in an uncommitted working tree*; the ref exists
   only because that tree had to reach CI. The manifest is the artifact; the branch is
   how it travelled.
3. **The ref population is not even a faithful proxy, and cannot be made one.** Remote
   ref deletion 403s at the proxy, so the population is monotone non-decreasing by an
   accident of infrastructure — nothing that ever gets pushed can ever leave it. **A
   denominator that can only grow, and only for reasons outside the program's
   control, cannot be a denominator.** The 85-ref inventory is an asset register; the
   tally is a score.

And the two differ in **both** directions, which is the part worth having measured:
a branch can exist without a scoring class (a control, or a class voided after it
ran), and a class can exist without a branch (sealed but never seeded). Anyone who
treats either count as a proxy for the other will be wrong, and will not know which
way.

**Step 6 — the finding the reconciliation actually produced, which is against me.**
Having closed the arithmetic, two things about *how the 41 got into the record* do
not survive the walk, and one of them bears directly on `G-1`.

The first two are clerical and materially void, and I file them anyway because a
correct number reached by an unearned method is exactly the thing my own harvest
rules say to convict. **`SO-xgmii_rx_64` §2.2-M states its method as *"the tally is
re-derived by walking the campaign verdicts, never quoted from the last one"* — and
its own first row, the 41, is quoted, from `WO-0074` §12, which quotes it in turn.**
The walk covered three campaigns of ten. Until this entry, **the seven-campaign
figure had never been derived campaign by campaign anywhere in the record.** It is
correct — I have now derived it — but the method claim was broader than the method
(`FINDING REC-1`, MINOR). And **`WO-0074` §12 sources the 41 to *"`WO-0073-VERDICT`
and `tasks/BOARD.md`"*, but the `WO-0073` packet contains no era tally at all**; the
only occurrence of `41` in it is inside a timestamp. Its sole prior home is
`tasks/BOARD.md` at `33871b8` (`Agent: orchestrator`, `J-orchestrator-0215`). A dv
figure was sourced to a dv packet that does not carry it, and the seat that actually
first wrote it was not credited (`FINDING REC-2`, MINOR). Both are mine.

The third is substantive. **Two structurally mirror-image events are accounted in
opposite directions, and neither treatment is stated as a rule anywhere.** `I-c1`
was *sealed and seeded* — a diff shipped, a branch ran, the suite reddened — and it
was **removed from the sealed denominator entirely**, appearing in none of the five
columns. `IC-M5` was *sealed and never seeded* — no diff, no branch, no CI job — and
it was **kept in the sealed denominator** and given a fifth column of its own, which
`WO-0074` §12 introduces with the words *"the era's first VOID class"*. The class
that was voided nine days earlier is not in that sentence, because it was voided
under a different word with a different consequence. Each individual ruling was made
at the time, in a committed packet, and disclosed there; what does not exist is any
statement, at the tally or anywhere downstream, that the sealed column **excludes one
seeded class on one ground and includes one unseeded class on another**. A reader of
"63 sealed" cannot recover either treatment (`FINDING REC-3`, MAJOR).

**Why that is MAJOR and not MINOR, stated with its materiality bounded.** It moves no
kill, creates no escape, and does not touch a single PASS: 61 killed is 61 killed and
`G-c4` is still the one survivor. What it moves is **the denominator the gate is about
to read, and the wording of the amendment being drafted right now.** The auditor
dissolved half of `G-1` on §7's own word — `IC-M5` was never *seeded*, so 63 sealed
− 1 = 62 seeded = 61 killed + 1 survived — and specified `G1-a` as *"quantify over
SEEDED with both numbers stated."* **Under a literal reading of `seeded`, `I-c1` is a
seeded mutation that is in no column at all.** It was seeded; it was not killed; it
did not survive; it is not the void. The identity 62 = 61 + 1 holds only because
`I-c1` was removed from numerator and denominator together, on a ground — *the
seeder's disclosure was falsified, so the class is unscoreable* — that appears in
`WO-0061` and in no normative instrument. **An amendment that quantifies over
`seeded` without a clause for the seeded-but-unscoreable class will be wrong at
`I-c1` on the day it is ratified.** That is worth a MAJOR because the amendment is
live in a sibling's hands this round, and because the defect is in my score, in my
packet's own method sentence, and in a figure I carried three times without walking.

**What I am not doing.** I am not touching the tally, the board, the `SO-`, or the
gate file. The dispatch confines me to this journal and requires me to name and stop
if my mechanics need more; my mechanics do not need more — the reconciliation is a
note in my chain and the corrections it implies are three sentences in artifacts I do
not own this round. They are routed in Open-questions with their owners named.

**Harvest.** Not due — this is neither an `SO-` nor a phase gate, and the span from
my last harvest stays **open**, declared rather than skipped. Two candidates banked
against it, both LH2-g: *(a)* **a figure carried across rounds must be re-derived by
the method its carrier claims, or the carrier must state that it was quoted** — LH1
this round's 41; LH3 without it a method sentence launders a number's provenance and
the first re-derivation happens after the number has been used to decide something.
*(b)* **When a scored population and its delivery artifacts are counted separately,
publish the reconciling identity, not just the score** — LH1 this round's 64/63/62;
LH3 without it a reader who finds the two counts differ has no way to tell an
accounting convention from a missing record, and files an observation nobody can
close.

### Actions

- Ran the abort-first precheck; verified `de3c560` and a clean tree, and re-verified
  both at authoring time after the round's reads.
- Read `J-auditor-0020` Open-question 4 at the source, in full, plus its Outcome.
- Measured the remote ref population by prefix and unfiltered; reconciled 87 to 85.
- Fetched all **64** class-era `mut/` branches into a throwaway `refs/mutinspect/*`
  namespace — **no merge, no checkout, no working-tree contact** — and recorded tip,
  base, commit count, full-diff SHA-256 and touched-file set for each.
- Compared `mut/wo-0063b-ic2` byte-for-byte against `WO-0063B-mutations/ic-2.diff`,
  and `mut/wo-0061-i-c1` line-for-line against the I-c1 hunk in
  `WO-0061-mutations/README.md`.
- Re-derived the older seven campaigns' sealed and killed columns from each
  campaign's own committed verdict, and reconciled 43 branches to 41 sealed.
- Swept the newer three campaigns and confirmed the opposite-direction case
  (`IC-M5`: 8 sealed classes, 7 branches) and the two-class reading of `n4a`/`n4b`.
- Traced the 41's provenance through `git log -S` to `33871b8`.
- **Deleted the entire `refs/mutinspect/*` namespace**, leaving zero local refs from
  which mutated RTL is reachable; re-ran one comparison from the cleaned state to
  prove the evidence reproduces without it.
- Wrote this entry. **No file outside this journal was created, edited or staged. No
  git commit or push was run, and no stop-hook commit demand was honoured.**

### Evidence

All commands run from a clean checkout at `de3c560`; all reads are of the remote and
of committed files. Ref population:

    $ git ls-remote --heads origin 'refs/heads/mut/*' | wc -l
    85
    $ git ls-remote --heads origin | wc -l
    87
    $ git ls-remote --heads origin | grep -v 'refs/heads/mut/'
    de3c560...  refs/heads/claude/fpga-hardcaml-agent-orchestration-37ceyf
    bd7fbcf...  refs/heads/main

**85 `mut/` refs (board figure confirmed); the 87 is the unfiltered listing, whose
two extra lines are `main` and the working branch.**

The two surplus branches, fetched without merge or checkout:

    $ git fetch --no-write-fetch-head origin refs/heads/mut/wo-0061-i-c1
    $ git log -1 --format='%H %P %aI %s' a4c7a047a27679117bd3577fcc773542f2a25a5a
    a4c7a047...  42b9df3fe648ea1735d24f1c629e402e409ef96c  2026-08-04T16:11:50+00:00
      MUTATION RUN i-c1 -- never merge
    $ git diff --stat 42b9df3 a4c7a047
     libs/hardcaml_ethernet/src/xgmii_rx_64.ml | 16 +++++++++++++++-
     1 file changed, 15 insertions(+), 1 deletion(-)

    $ git fetch --no-write-fetch-head origin refs/heads/mut/wo-0063b-ic2
    $ git log -1 --format='%H %P %aI %s' dbc4b0a8a4ffdff43512afbe97ebcf9055d36e1c
    dbc4b0a8...  c0595f9e8026757cd4eed6e856d06555424437e0  2026-08-04T22:17:52+00:00
      MUTATION RUN WO-0063B/ic-2 (control) -- base c0595f9 + one diff -- never merge

Branch-vs-manifest identity (both re-run from a state with the inspection refs
already deleted, so they reproduce standalone):

    $ diff <(git diff c0595f9 dbc4b0a8 -- libs/hardcaml_ethernet/src/xgmii_rx_64.ml \
             | sed -n '/^@@/,$p') \
           <(sed -n '/^@@/,$p' docs/reports/audit/WO-0063B-mutations/ic-2.diff)
    (no output — hunk bodies identical; 28 lines each)

    # every +/- line of the i-c1 branch diff, checked verbatim against the manifest
    $ while IFS= read -r l; do
        grep -qF -- "$l" docs/reports/audit/WO-0061-mutations/README.md || echo "MISSING: $l"
      done < <(git diff 42b9df3 a4c7a047 | sed -n '/^@@/,$p' | grep '^[+-]')
    (no output — all present; only context lines differ, the README quoting a
     narrower window)

The 64-branch sweep — per branch: merge-base against `de3c560`, commit count over
that base, SHA-256 of the full diff, touched files. Aggregate results:

    distinct diff hashes                     64 of 64   (zero collisions)
    branches whose base is the campaign base 64 of 64
    branches with exactly one commit         63 of 64   (mut/wo-0073-l3 = 2,
                                                         disclosed at its manifest Q2)
    branches touching exactly one file       64 of 64
    branches touching test/**, agents/**,
      or docs/**                              0 of 64
    bases observed: 616686f 2e8994f a2d090d 42b9df3 c0595f9 199e319 bbd4122
                    ca1bb80 8346a5c aced7b4   — one per campaign, matching the
                    auditor's seeding entries J-auditor-0008..-0018

Primary-source dispositions of the two surplus branches:

    $ grep -n 'I-c1' agents/handoffs/WO-0061_family-i-mutation-campaign.md
    738: | **I-c1** | ... | **VOID** | **NOT SEEDED AS SPECIFIED — scope report, 0 kills** |
    1139: - **Classes seeded: 10. Branches red: 10 of 10. Scoreable classes: 9**

    $ grep -n 'IC-2' agents/handoffs/WO-0063B_m03-i2-report-path-campaign.md
    576: - **Kills: 0, by design.** IC-2 is a control and scores none.
    779: | **IC-2** (control) | yes, as specified | ... | **0, by design** |

Opposite-direction case and the `n4a`/`n4b` check:

    $ grep -n 'IC-M5' docs/reports/audit/WO-0074-mutations/README.md
    288: **No branch is cut for IC-M5, and no CI job is spent on it.**
    1075: | IC-M5 | ❌ **NOT SEEDED** | — | ... |
    $ grep -n 'IC-N4a' docs/reports/audit/WO-0077-mutations/README.md
    205: ... IC-K1..IC-K6, IC-N1, **IC-N4a**, **IC-N4b**   (nine classes, fixed)
    241: IC-N4a at the abort path, IC-N4b at the report path

Provenance of the carried 41:

    $ grep -c '41 sealed\|40 killed' agents/handoffs/WO-0073_family-l-mutation-campaign.md
    0
    $ grep -on '\b41\b' agents/handoffs/WO-0073_family-l-mutation-campaign.md
    1254:41            # inside the timestamp 20:41:27Z
    $ git log --oneline -S'41 sealed' --all -- tasks/BOARD.md agents/handoffs/ | tail -2
    70cf13c  The eighth campaign ...            # Agent: dv_lead,      J-dv_lead-0137
    33871b8  Board: the seventh campaign ...    # Agent: orchestrator, J-orchestrator-0215

Cleanup, so that no mutated RTL is reachable from a local ref:

    $ git for-each-ref --format='%(refname)' refs/mutinspect | while read r; do
        git update-ref -d "$r"; done
    $ git for-each-ref refs/mutinspect | wc -l
    0
    $ git status --short && git rev-parse HEAD
    (clean)  de3c56059eee62fa6315fef0764d66e85e2cde78

**No suite was run and none is claimed.** This round touched no file under `test/`
and can move no suite result; the whole-suite verdict remains CI's (ADR-0005).

### Outcome

**DoD met, and the round's act is complete.** The two surplus branches are named
with tips, bases and commit subjects; each is classified from its own committed
verdict — **`mut/wo-0061-i-c1` a voided seeded class, `mut/wo-0063b-ic2` a negative
control** — and **neither is a re-cut, a duplicate render, a stale branch, or an
unrecorded seeding**, each of those four being refuted by measurement rather than by
argument. The figure the gate reads is stated (**sealed classes with disposition,
63/61/1/0/1**, not branches-cut) with three grounds, and the two counts are shown to
diverge in **both** directions. The reconciliation is exact end to end — 64 − 2 = 62
seeded = 61 + 1, and 62 + 1 unseeded = 63 sealed — and it closes `J-auditor-0020`
Open-question 4 with nothing left over. **The auditor's 87 is corrected to 85 and the
cause identified**, without disturbing its 64, which reproduces.

**Findings, all three against my own seat, per charter §8's adverse-party discipline:**

- **`FINDING REC-1` (MINOR, materially void)** — `SO-xgmii_rx_64` §2.2-M claims the
  tally is *"re-derived by walking the campaign verdicts, never quoted"*; its first
  row is quoted. The walk covered three of ten campaigns. **The figure is correct** —
  derived here for the first time — so nothing downstream moves; the method sentence
  overstated its reach.
- **`FINDING REC-2` (MINOR, materially void)** — `WO-0074` §12 attributes the 41 to
  `WO-0073-VERDICT`, which contains no era tally. Sole prior home is `tasks/BOARD.md`
  at `33871b8`, authored under `Agent: orchestrator`.
- **`FINDING REC-3` (MAJOR, narrow)** — the sealed column **excludes a seeded class
  (`I-c1`) and includes an unseeded one (`IC-M5`) on two grounds never stated
  together**, and `WO-0074` §12 calls `IC-M5` *"the era's first VOID class"* nine days
  after `I-c1` was voided under a different word. Moves no kill and no PASS; **moves
  the denominator the gate reads and the amendment `G1-a` now being drafted**, which
  quantifies over `seeded` and has no clause for the seeded-but-unscoreable class.

**Handoff**: to the orchestrator for commit as a **journal-only** commit —
`Files-in-this-commit` is `- (none)`, so `Journal-Only: true`, trailers
`Agent: dv_lead`, `Work-Order: none`, `Journal-Entry: J-dv_lead-0184` (`R2`, `R6`).
The reconciliation is returned verbatim in this round's return. **I staged nothing
outside this journal, and I named no board row or packet annotation as required —
because none is required for the reconciliation itself.** The corrections `REC-1`–
`REC-3` imply edits to artifacts I do not own this round; they are routed below, not
made.

### Open-questions

1. **`FINDING REC-3` should reach the architect before the §7/§10 amendment is
   frozen, and this is the round it is being drafted in.** `G1-a` as specified
   ("quantify over SEEDED with both numbers stated") is **correct and insufficient**:
   it needs a third clause for the class that *was* seeded and is scoreable against
   nothing, or it will be false at `I-c1` on the day it is ratified. The clause I
   would propose, offered and not filed: *a seeded mutation whose seeding is found not
   to render the sealed class is dispositioned as UNSCOREABLE, counted in neither
   numerator nor denominator, and named at the tally with its ground.* **Route**:
   orchestrator → architect_docs_lead, at its discretion, this round or the next.
2. **Three artifacts carry a figure whose provenance sentence is wrong, and I own two
   of them.** `SO-xgmii_rx_64` §2.2-M's method sentence and `WO-0074` §12's
   attribution are mine to correct; the correction is two sentences and **must not
   ride this round**, which is journal-only by dispatch. I name them and stop, per
   the dispatch's instruction. **Carrier**: the next round that opens
   `agents/handoffs/` for me.
3. **The board's `G-1` row and the gate file's `G-1` row both predate this
   reconciliation** and neither states which denominator the gate reads. **The board
   is the orchestrator's and `docs/gates/**` is nobody's but the orchestrator's by
   §7's transcription rule** — I neither edit nor draft either. If the orchestrator
   wants the identity `64 − 2 = 62 = 61 + 1`, `62 + 1 = 63` transcribed into the
   gate record, it is four lines and it is above, ready to lift verbatim.
4. **The transient-ref inventory is a monotone artifact of a proxy limitation and
   should be labelled as one.** Deletion 403s, so the count can only rise, and it now
   sits two counts away from a figure someone reasoned with. Recommend the board's
   inventory block gain one sentence: *this register is not a denominator*.
   **Owner**: orchestrator. Recorded, not filed.
5. **My reading of 64 mutation hunks is disclosed, not excused.** It was this round's
   express commission and it was identity evidence on an already-signed module, but
   §10's independence discipline is a habit and not a permission ledger. **No test,
   plan row or spec claim in any future round of mine may cite this round's reads**,
   and if one ever appears to, this sentence is the thing that convicts it.
6. **Carried, unchanged**: `DVC-1a` remains unbuilt and every attack-plan count I
   quote remains a hand count with its method stated — from `J-dv_lead-0183` item 6.
   The whole-suite verdict is still CI's and the `9a596e7` repair's CI adjudication is
   still open — from `J-dv_lead-0183` item 7.

### Files-in-this-commit
- (none)
