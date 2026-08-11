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
